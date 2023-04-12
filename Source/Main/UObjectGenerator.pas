unit UObjectGenerator;

// is needed for the visually impaired working without a GUI designer,
// for generating AWT/Swing dialogs
// for creating and manipulating objects!

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ComCtrls, Grids, ValEdit, JvAppStorage, dlgPyIDEBase, frmEditor, UGuiForm;

const CrLf = #13#10;

type
   jfmRec = record
      name: string;
      Default: string;
      Tag: integer;
   end;

  TFObjectGenerator = class(TPyIDEDlgBase, IJvAppStorageHandler)
    StatusBar: TStatusBar;
      BCancel: TButton;
      BFont: TButton;
      BOK: TButton;
    PictureDialog: TOpenDialog;
    FontDialog: TFontDialog;
    ValueListEditor: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ValueListEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MIFontClick(Sender: TObject);
  private
    Defaults: array[1..50] of string;
    jfmDefaults: array[1..50] of jfmrec;
    Indent1, Indent2, Indent3: string;
    MaxDefaults: integer;
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    Partner: TEditorForm;
    procedure setBoundsForFormular(Form: TForm);

    procedure moveOrSizeComponent(aPartner: TEditorForm; Control: TControl);
    procedure ComponentToBackground(aPartner: TEditorForm; Control: TControl);
    procedure ComponentToForeground(aPartner: TEditorForm; Control: TControl);

    procedure setAttributForComponent(Attr, Value: string; Typ: string; Control: TControl);
    procedure SetSlotForComponent(Attr, Value: string; Control: TControl);

    procedure addRow(Attribut: string; const Value: string);
    procedure Retranslate;

    // new component
    procedure InsertComponent(EditForm: TEditorForm; Control: TControl; Pasting: boolean);
    procedure setComponentValues(DesignForm: TFGUIForm; Control: TControl);
    procedure setControlEvents(DesignForm: TFGUIForm; EditorForm: TEditorForm);

    // deletes a component
    procedure DeleteComponent(Component: TControl);
    procedure PrepareEditClass(const aCaption, Title, ObjectNameOld: string);
    procedure PrepareEditObjectOrParams(const aCaption, Title: string);
    procedure DeleteRow;
    procedure SetRow(i: integer);
    procedure SetColWidths;
end;

var
  FObjectGenerator: TFObjectGenerator = nil;

implementation

uses
  SysUtils, Math, SynEdit, TypInfo, UITypes, Types, JvGnugettext, StringResources,
  SynCompletionProposal, UStrings, frmPyIDEMain, cPyScripterSettings,
  UKoppel, UUtils, frmFile, UObjectInspector, UGUIDesigner, UConfiguration,
  UTKWidgets, UBaseWidgets, ELEvents, ELPropInsp, uCommonFunctions, uEditAppIntfs,
  dmCommands;

const
  FrameKonsole = 1;

{$R *.DFM}

procedure TFObjectGenerator.FormCreate(Sender: TObject);

  procedure SetDefault(i: integer; const s1, s2: string; Tag: integer);
  begin
    jfmDefaults[i].Name:= s1;
    jfmDefaults[i].Default:= s2;
    jfmDefaults[i].Tag:= Tag;
  end;

begin
  inherited;
  ValueListEditor.Color:= clBtnFace;
  FStringEditor:= TFStringEditor.Create(Self);
  setDefault(1, 'Alignment', 'taLeftJustify', TagAlignment);
  setDefault(2, 'Background', 'clBtnFace', TagColor);
  setDefault(3, 'Enabled', 'True', TagBoolean);
  setDefault(4, 'Visible', 'True', TagBoolean);
  setDefault(5, 'Text', '', TagText);
  setDefault(6, 'Font', '(Font)', TagText);
  MaxDefaults:= 5;
  Indent1:= FConfiguration.Indent1;
  Indent2:= FConfiguration.Indent2;
  Indent3:= FConfiguration.Indent3;
  Font.Name:= 'Segoe UI';
  Font.Size:= 12;
end;

procedure TFObjectGenerator.FormShow(Sender: TObject);
begin
  ActiveControl:= ValueListEditor;
  ValueListEditor.Canvas.Font.Size:= Font.Size;
  ValueListEditor.DefaultRowHeight:= ValueListEditor.Canvas.TextHeight('Ag') + 4;
end;

procedure TFObjectGenerator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFObjectGenerator.InsertComponent(EditForm: TEditorForm; Control: TControl; Pasting: boolean);
begin
  var Collapsed:= EditForm.isGUICreationCollapsed;
  Partner:= EditForm;
  LockFormUpdate(EditForm);
  EditForm.ParseAndCreateModel;
  (Control as TBaseWidget).NewWidget;
  if PyIDEOptions.CodeFoldingForGuiElements and Collapsed then
    EditForm.CollapseGUICreation;
  if GuiPyOptions.AlignToGrid then
    FGuiDesigner.ELDesigner.SelectedControls.AlignToGrid;
  UnlockFormUpdate(EditForm);
end;

procedure TFObjectGenerator.SetBoundsForFormular(Form: TForm);
  var s1, s2: string;
begin
  if Partner.FrameType = 2 then begin
    s1:= 'self.root.geometry(';
    s2:= Indent2 + s1 + '''' + IntToStr(Form.ClientWidth) + 'x' + IntToStr(Form.ClientHeight) + ''')';
  end else begin
    s1:= 'self.resize(';
    s2:= Indent2 + s1 + IntToStr(Form.ClientWidth) + ', ' + IntToStr(Form.ClientHeight) + ')';
  end;
  Partner.ReplaceLine(s1, s2);
end;

procedure TFObjectGenerator.MoveOrSizeComponent(aPartner: TEditorForm; Control: TControl);
  var Widget: TBaseWidget;
begin
  if (aPartner = nil) or (Control is TFGUIForm) then exit;
  if not (Control as TBaseWidget).Sizeable then begin
    Control.Width:= 33;
    Control.Height:= 28;
    exit;
  end;
  Widget:= Control as TBaseWidget;
  Widget.SetPositionAndSize;
end;

procedure TFObjectGenerator.ComponentToForeground(aPartner: TEditorForm; Control: TControl);
begin
  if assigned(Control) then begin
    Control.BringToFront;
    aPartner.ToForeground(Control);
  end;
end;

procedure TFObjectGenerator.ComponentToBackground(aPartner: TEditorForm; Control: TControl);
begin
  if assigned(Control) then begin
    Control.SendToBack;
    aPartner.ToBackground(Control);
  end;
end;

procedure TFObjectGenerator.SetAttributForComponent(Attr, Value, Typ: string; Control: TControl);
  var Widget: TBaseWidget; GuiForm: TFGuiForm;
begin
  Self.Partner:= TEditorForm(TFGUIForm(FGUIDesigner.ELDesigner.DesignControl).Partner);
  Value:= Delphi2PythonValues(Value);
  if Control is TBaseWidget then begin
    Widget:= Control as TBaseWidget;
    Widget.setAttribute(Attr, Value, Typ);
  end else if Control is TFGuiForm then begin
    GuiForm:= Control as TFGuiForm;
    GuiForm.setAttribute(Attr, Value, Typ);
  end;
end;

procedure TFObjectGenerator.SetSlotForComponent(Attr, Value: string; Control: TControl);
  var CName, s, dest: string;
begin
  if Value = '' then begin
    if Control.Tag = 0
      then Partner.DeleteMethod('MainWindow_' + Attr)
      else Partner.DeleteMethod(Control.Name + '_' + Attr);
    Partner.DeleteBinding(Attr + '.connect');
  end else begin
    s:= Attr + '.connect(self.' + Value + ')';
    if Control.Tag = 76 // TQtButtonGroup
      then CName:= Control.Name + 'BG'
      else CName:= Control.Name;
    if Control.Tag = 0 then
      dest:= Indent2 + 'self.'
    else begin
      s:= CName + '.' + s;
      dest:= 'self.' + CName;
    end;
    Partner.InsertQtBinding(dest, Indent2 + 'self.' + s);
  end;
end;

procedure TFObjectGenerator.ValueListEditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_Return) or (Key = VK_Tab) then
    if ValueListEditor.Row < ValueListEditor.RowCount-1
      then ValueListEditor.Row:= ValueListEditor.Row + 1
    else if Key = VK_Return then
      ModalResult:= mrOK;
end;

procedure TFObjectGenerator.AddRow(Attribut: string; const Value: string);
  var i: integer;
begin
  ValueListEditor.InsertRow(Attribut, Value, true);
  i:= ValueListEditor.RowCount - 1;
  Defaults[i]:= Value;
end;

procedure TFObjectGenerator.ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  var L, T, W, H, C: integer;
begin
  L:= AppStorage.ReadInteger(BasePath + '\Left', 300);
  T:= AppStorage.ReadInteger(BasePath + '\Top', 200);
  W:= AppStorage.ReadInteger(BasePath + '\Width', 100);
  H:= AppStorage.ReadInteger(BasePath + '\Height', 200);
  L:= min(L, Screen.Width - 100);
  T:= min(T, Screen.Height - 100);
  SetBounds(L, T, W, H);
  W:= ValueListEditor.Width;
  C:= AppStorage.ReadInteger(BasePath + '\ValueListEditor.ColWidth', w div 2);
  if C < W * 2 div 10 then C:= W * 2 div 10;
  if C > W * 8 div 10 then C:= W * 8 div 10;
  ValueListEditor.ColWidths[0]:= C;
  AppStorage.ReadPersistent(BasePath + '\Font', Font);
end;

procedure TFObjectGenerator.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath + '\Left', Left);
  AppStorage.WriteInteger(BasePath + '\Top', Top);
  AppStorage.WriteInteger(BasePath + '\Width', Width);
  AppStorage.WriteInteger(BasePath + '\Height', Height);
  AppStorage.WriteInteger(BasePath + '\ValueListEditor.ColWidth', ValueListEditor.ColWidths[0]);
  AppStorage.WritePersistent(BasePath+'\Font', Font);
end;

procedure TFObjectGenerator.MIFontClick(Sender: TObject);
begin
  CommandsDataModule.dlgFontDialog.Font.Assign(Font);
  CommandsDataModule.dlgFontDialog.Options:= [];
  if CommandsDataModule.dlgFontDialog.Execute then
    Font.Assign(CommandsDataModule.dlgFontDialog.Font);
end;

procedure TFObjectGenerator.DeleteComponent(Component: TControl);
  var Collapsed: boolean;

  procedure DeleteAComponent(Control: TControl);
    var i: integer;
  begin
    if Control is TBaseWidget then
      (Control as TBaseWidget).DeleteWidget;
    i:= FObjectInspector.CBObjects.Items.IndexOf((Control as TBaseWidget).getNameAndType);
    FObjectInspector.CBObjects.Items.Delete(i);
  end;

  procedure DeleteAllComponents(Control: TControl);
    var i: integer;
  begin
    if (Control is TWinControl) then
      for i:= 0 to (Control as TWinControl).ControlCount - 1 do
        DeleteAllComponents((Control as TWinControl).Controls[i]);
    DeleteAComponent(Control);
  end;

begin
  Collapsed:= Partner.isGUICreationCollapsed;
  LockFormUpdate(Partner);
  DeleteAllComponents(Component);
  Partner.NeedsParsing:= true;
  if PyIDEOptions.CodeFoldingForGuiElements and Collapsed then
    Partner.CollapseGUICreation;
  UnlockFormUpdate(Partner);
end;

procedure TFObjectGenerator.PrepareEditClass(const aCaption, Title, ObjectNameOld: string);
  var i: integer;
begin
  Self.Caption:= aCaption;
  ValueListEditor.TitleCaptions.Text:= Title;
  for i:= ValueListEditor.RowCount-1 downto 2 do
    ValueListEditor.DeleteRow(i);
  ValueListEditor.Cells[0, 1]:= _('Name of object');
  ValueListEditor.Cells[1, 1]:= ObjectNameOld;
end;

procedure TFObjectGenerator.PrepareEditObjectOrParams(const aCaption, Title: string);
  var i: integer;
begin
  Self.Caption:= aCaption;
  ValueListEditor.TitleCaptions.Text:= Title;
  for i:= ValueListEditor.RowCount-1 downto 2 do
     ValueListEditor.DeleteRow(i);
  // it's not possible to delete row[1] now
  ValueListEditor.Cells[0, 1]:= 'Delete';
end;

procedure TFObjectGenerator.DeleteRow;
begin
  if ValueListEditor.Cells[0, 1] = 'Delete' then
    ValueListEditor.DeleteRow(1);
end;

procedure TFObjectGenerator.SetRow(i: integer);
begin
  if i < ValueListEditor.RowCount then
    ValueListEditor.Row:= i;
end;

procedure TFObjectGenerator.setControlEvents(DesignForm: TFGUIForm; EditorForm: TEditorForm);
  var Comp: TControl; Event: TEvent;
      Eventname: String;
      PropInfos: PPropList;
      Widget: TBaseWidget;
      Count, i, j: Integer;
begin
  // create source code for copy&paste of events
  EditorForm.ActiveSynEdit.BeginUpdate;
  for i:= 0 to DesignForm.ComponentCount do begin
    if i = DesignForm.ComponentCount
      then Comp:= DesignForm
      else Comp:= TControl(DesignForm.Components[i]);
    Count:= GetPropList(Comp.ClassInfo, tkAny, nil);
    GetMem(PropInfos, Count * SizeOf(PPropInfo));
    try
      GetPropList(Comp.ClassInfo, tkAny, PropInfos);
      for j:= 0 to Count - 1 do begin
        Eventname:= String(PropInfos[j].Name);
        if IsEvent('|' + Eventname + '|') then begin
          getEventProperties(comp, Eventname, Event);
          if Event.Active and not
            (EditorForm.getLineNumberOfBinding(Comp.Name, Eventname) > 0)
          then
            if Comp is TBaseWidget then begin
              Widget:= Comp as TBaseWidget;
              EditorForm.InsertProcedure(CrLf + Widget.MakeHandler(Eventname));
              EditorForm.InsertTkBinding(Name, Eventname, Widget.MakeBinding(Eventname));
            end else if Comp = DesignForm then begin
              EditorForm.InsertProcedure(CrLf + DesignForm.MakeHandler(Eventname));
              EditorForm.InsertTkBinding(Name, Eventname, DesignForm.MakeBinding(Eventname));
            end;
        end;
      end
    finally
      FreeMem(PropInfos, Count * SizeOf(PPropInfo));
    end;
  end;
  EditorForm.ActiveSynEdit.EndUpdate;
  FObjectInspector.SetBNewDeleteCaption;
end;

procedure TFObjectGenerator.SetComponentValues(DesignForm: TFGUIForm; Control: TControl);
  var Comp1, Comp2: TControl; Widget: TBaseWidget;
      s, Attr, ForbiddenAttributes, AllowedAttributes: String;
      f1, f2: TFont;
      PropInfos1, PropInfos2: PPropList;
      Count, i: Integer;
      PropEditor1: TELPropEditor;
      PropEditor2: TELPropEditor;
      aEditorClass: TELPropEditorClass;
      aPropertyInspector: TELCustomPropertyInspector;
begin
  Comp1:= Control;
  s:= Comp1.Classname;
  Comp2:= TControlClass(GetClass(s)).Create(DesignForm);
  ForbiddenAttributes:= ' Hint Name Left Top Width Height Caption Command ';
  Widget:= Comp1 as TBaseWidget;
  AllowedAttributes:= Widget.getAttributes(3);

  Count:= GetPropList(Comp1.ClassInfo, tkAny, nil);
  GetMem(PropInfos1, Count * SizeOf(PPropInfo));
  GetMem(PropInfos2, Count * SizeOf(PPropInfo));
  try
    GetPropList(Comp1.ClassInfo, tkAny, PropInfos1);
    GetPropList(Comp2.ClassInfo, tkAny, PropInfos2);
    aPropertyInspector:= TELCustomPropertyInspector.Create(nil);
    for i:= 0 to Count - 1 do begin
      Attr:= String(PropInfos1[i].Name);
      if (Pos(' ' + Attr + ' ', ForbiddenAttributes) = 0) and (Pos('|' + Attr + '|', AllowedAttributes) > 0) then begin
        aEditorClass:= aPropertyInspector.GetEditorClass(Comp1, PropInfos1[i]);
        if assigned(aEditorClass) then begin
          PropEditor1:= aEditorClass.Create2(Comp1, PropInfos1[i]);
          PropEditor2:= aEditorClass.Create2(Comp2, PropInfos2[i]);
          try
            if PropEditor2.Value <> PropEditor1.Value then
              SetAttributForComponent(Attr, PropEditor1.Value, String(PropEditor1.PropTypeInfo.Name), Comp1)
            else if (PropEditor1.PropTypeInfo.Name = 'TFont') then begin
              f1:= (PropEditor1 as TELFontPropEditor).getFont;
              f2:= (PropEditor2 as TELFontPropEditor).getFont;
              if (f1.Name <> f2.Name) or (f1.Size <> f2.Size) or (f1.Style <> f2.Style) then
                 SetAttributForComponent(Attr, PropEditor1.Value, String(PropEditor1.PropTypeInfo.Name), Comp1);
            end else if PropEditor1.PropTypeInfo.Name = 'TStrings' then begin
              if (PropEditor1 as TELStringsPropEditor).getText <> (PropEditor2 as TELStringsPropEditor).getText then
                 SetAttributForComponent(Attr, PropEditor1.Value, String(PropEditor1.PropTypeInfo.Name), Comp1);
            end;
          finally
            FreeAndNil(PropEditor1);
            FreeAndNil(PropEditor2);
          end;
        end
      end;
    end
  finally
    FreeMem(PropInfos1, Count * SizeOf(PPropInfo));
    FreeMem(PropInfos2, Count * SizeOf(PPropInfo));
    FreeAndNil(aPropertyInspector);
    FreeAndNil(Comp2);
  end;
end;

procedure TFObjectGenerator.SetColWidths;
  var i, max1, max2, h, w: integer;
      s: string;
      //SInfo: TScrollBarInfo;
begin
  max1:= 0;
  max2:= 0;
  for i:= 0 to ValueListEditor.RowCount - 1 do begin
    s:= ValueListEditor.Cells[0, i];
    max1:= Math.Max(length(s), max1);
    s:= ValueListEditor.Cells[1, i];
    max2:= Math.max(length(s), max2);
  end;
  max1:= max1*(Font.Size-2);
  max2:= max2*(Font.Size-2);
  max1:= max1 + 10;
  max2:= max2 + 10;

  // vertical scrollbar?
  {SInfo.cbSize:= SizeOf(TScrollBarInfo);
  //  $ WARN BOUNDS_ERROR OFF
  try
    GetScrollBarInfo(ValueListEditor.Handle, OBJID_VSCROLL , SInfo);
  except
  end;
  // $ WARN BOUNDS_ERROR ON

  if (SInfo.rgstate[0] and STATE_SYSTEM_INVISIBLE <> STATE_SYSTEM_INVISIBLE) then
    max2:= max2 + SInfo.rcScrollBar.Right - SInfo.rcScrollBar.Left;
  }

  if Width < max1 + 1 + max2 then
    Width:= max1 + 3 + max2;
  if Width < BCancel.Left + BCancel.Width then
    Width:= BCancel.Left + BCancel.Width;
  if ValueListEditor.ColWidths[0] < max1 then
     ValueListEditor.ColWidths[0]:= max1;
  if ValueListEditor.ColWidths[1] < max2 then
     ValueListEditor.ColWidths[1]:= max2;

  // very strange interaction with Themes/Styles
  h:= Height;
  w:= Width;
  Show;
  Hide;
  Height:= h;
  Width:= w;
end;

procedure TFObjectGenerator.Retranslate;
begin
  RetranslateComponent(FStringEditor);
end;

end.
