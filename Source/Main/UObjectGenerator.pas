unit UObjectGenerator;

// is needed for the visually impaired working without a GUI designer,
// for generating AWT/Swing dialogs
// for creating and manipulating objects!

interface

uses
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Grids,
  ComCtrls,
  ValEdit,
  JvAppStorage,
  dlgPyIDEBase,
  frmEditor,
  UGUIForm;

type
  TJfmRec = record
    Name: string;
    Default: string;
    Tag: Integer;
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
    procedure ValueListEditorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MIFontClick(Sender: TObject);
    function Indent2: string;
  private
    FDefaults: array [1 .. 50] of string;
    FJfmDefaults: array [1 .. 50] of TJfmRec;
    FMaxDefaults: Integer;
    FPartner: TEditorForm;
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string);
  public
    procedure SetBoundsForFormular(Form: TForm);
    procedure MoveOrSizeComponent(APartner: TEditorForm; Control: TControl);
    procedure ComponentToBackground(APartner: TEditorForm; Control: TControl);
    procedure ComponentToForeground(APartner: TEditorForm; Control: TControl);
    procedure SetAttributForComponent(Attr, Value: string; Typ: string;
      Control: TControl);
    procedure SetSlotForComponent(Attr, Value: string; Control: TControl);
    procedure AddRow(Attribute: string; const Value: string);
    function Edit(Control: TControl; Attributes: TStringList;
      Row: Integer): Boolean;
    procedure InsertComponent(EditForm: TEditorForm; Control: TControl;
      Pasting: Boolean);
    procedure SetComponentValues(DesignForm: TFGuiForm; Control: TControl);
    procedure SetControlEvents(DesignForm: TFGuiForm; EditorForm: TEditorForm);
    procedure DeleteComponent(Component: TControl);
    procedure PrepareEditClass(const ACaption, Title, ObjectNameOld: string);
    procedure PrepareEditObjectOrParams(const ACaption, Title: string);
    procedure SetPositionRelativTo(AControl: TControl);
    procedure SetWidthAndHeight;
    property Partner: TEditorForm read FPartner write FPartner;
  end;

var
  FObjectGenerator: TFObjectGenerator = nil;

implementation

uses
  Windows,
  Graphics,
  SysUtils,
  Math,
  TypInfo,
  UITypes,
  Types,
  JvGnugettext,
  dmResources,
  cPyScripterSettings,
  uCommonFunctions,
  ELEvents,
  ELPropInsp,
  ULink,
  UUtils,
  UObjectInspector,
  UGUIDesigner,
  UConfiguration,
  UBaseWidgets;

const
  FrameKonsole = 1;

{$R *.DFM}

procedure TFObjectGenerator.FormCreate(Sender: TObject);

  procedure SetDefault(I: Integer; const Str1, Str2: string; Tag: Integer);
  begin
    FJfmDefaults[I].Name := Str1;
    FJfmDefaults[I].Default := Str2;
    FJfmDefaults[I].Tag := Tag;
  end;

begin
  inherited;
  ValueListEditor.Color := clBtnFace;
  SetDefault(1, 'Alignment', 'taLeftJustify', TagAlignment);
  SetDefault(2, 'Background', 'clBtnFace', TagColor);
  SetDefault(3, 'Enabled', 'True', TagBoolean);
  SetDefault(4, 'Visible', 'True', TagBoolean);
  SetDefault(5, 'Text', '', TagText);
  SetDefault(6, 'Font', '(Font)', TagText);
  FMaxDefaults := 5;
  Font.Name := 'Segoe UI';
  Font.Size := 12;
end;

procedure TFObjectGenerator.FormShow(Sender: TObject);
begin
  ActiveControl := ValueListEditor;
  ValueListEditor.Canvas.Font.Size := Font.Size;
  ValueListEditor.DefaultRowHeight := ValueListEditor.Canvas.TextHeight
    ('Ag') + 4;
end;

procedure TFObjectGenerator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFObjectGenerator.InsertComponent(EditForm: TEditorForm;
  Control: TControl; Pasting: Boolean);
begin
  var
  Collapsed := EditForm.isGUICreationCollapsed;
  FPartner := EditForm;
  LockFormUpdate(EditForm);
  EditForm.ParseAndCreateModel;
  (Control as TBaseWidget).NewWidget;
  if PyIDEOptions.CodeFoldingForGuiElements and Collapsed then
    EditForm.CollapseGUICreation;
  if GuiPyOptions.SnapToGrid then
    FGUIDesigner.ELDesigner.SelectedControls.AlignToGrid;
  UnlockFormUpdate(EditForm);
end;

procedure TFObjectGenerator.SetBoundsForFormular(Form: TForm);
var
  Str1, Str2: string;
begin
  if FPartner.FrameType = 2 then
  begin
    Str1 := 'self.root.geometry(';
    Str2 := Indent2 + Str1 + '''' + IntToStr(PPIUnScale(Form.ClientWidth)) + 'x'
      + IntToStr(PPIUnScale(Form.ClientHeight)) + ''')';
  end
  else
  begin
    Str1 := 'self.resize(';
    Str2 := Indent2 + Str1 + IntToStr(PPIUnScale(Form.ClientWidth)) + ', ' +
      IntToStr(PPIUnScale(Form.ClientHeight)) + ')';
  end;
  FPartner.ReplaceLine(Str1, Str2);
end;

procedure TFObjectGenerator.MoveOrSizeComponent(APartner: TEditorForm;
  Control: TControl);
var
  Widget: TBaseWidget;
begin
  if not Assigned(APartner) or (Control is TFGuiForm) then
    Exit;
  Widget := Control as TBaseWidget;
  if not Widget.Sizeable then
  begin
    Widget.Width := Widget.PPIScale(33);
    Widget.Height := Widget.PPIScale(28);
  end
  else
    Widget.SetPositionAndSize;
end;

procedure TFObjectGenerator.ComponentToForeground(APartner: TEditorForm;
  Control: TControl);
begin
  if Assigned(Control) then
  begin
    Control.BringToFront;
    APartner.ToForeground(Control);
  end;
end;

procedure TFObjectGenerator.ComponentToBackground(APartner: TEditorForm;
  Control: TControl);
begin
  if Assigned(Control) then
  begin
    Control.SendToBack;
    APartner.ToBackground(Control);
  end;
end;

procedure TFObjectGenerator.SetAttributForComponent(Attr, Value, Typ: string;
  Control: TControl);
var
  Widget: TBaseWidget;
  GuiForm: TFGuiForm;
begin
  FPartner := TFGuiForm(FGUIDesigner.ELDesigner.DesignControl).Partner;
  Value := Delphi2PythonValues(Value);
  if Control is TBaseWidget then
  begin
    Widget := Control as TBaseWidget;
    Widget.SetAttribute(Attr, Value, Typ);
  end
  else if Control is TFGuiForm then
  begin
    GuiForm := Control as TFGuiForm;
    GuiForm.SetAttribute(Attr, Value, Typ);
  end;
end;

procedure TFObjectGenerator.SetSlotForComponent(Attr, Value: string;
  Control: TControl);
var
  CName, Str, Dest: string;
  Widget: TBaseWidget;
begin
  if Control is TBaseWidget then
    Widget := Control as TBaseWidget
  else
    Widget := nil;
  if Value = '' then
  begin
    if Control.Tag = 0 then
      FPartner.DeleteMethod('MainWindow_' + Attr)
    else
      FPartner.DeleteMethod(Control.Name + '_' + Attr);
    FPartner.DeleteBinding(Attr + '.connect');
  end
  else if Assigned(Widget) and (Widget.Name + '_' + Attr = Value) then
    Widget.SetEvent(Attr)
  else
  begin
    Str := Attr + '.connect(self.' + Value + ')';
    if Control.Tag = 76 // TQtButtonGroup
    then
      CName := Control.Name + 'BG'
    else
      CName := Control.Name;
    if Control.Tag = 0 then
      Dest := Indent2 + 'self.'
    else
    begin
      Str := CName + '.' + Str;
      Dest := 'self.' + CName;
    end;
    FPartner.InsertQtBinding(Dest, Indent2 + 'self.' + Str);
  end;
end;

procedure TFObjectGenerator.ValueListEditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_TAB) then
    if ValueListEditor.Row < ValueListEditor.RowCount - 1 then
      ValueListEditor.Row := ValueListEditor.Row + 1
    else if Key = VK_RETURN then
      ModalResult := mrOk;
end;

procedure TFObjectGenerator.AddRow(Attribute: string; const Value: string);
begin
  ValueListEditor.InsertRow(Attribute, Value, True);
  FDefaults[ValueListEditor.RowCount - 1] := Value;
end;

function TFObjectGenerator.Edit(Control: TControl; Attributes: TStringList;
  Row: Integer): Boolean;
begin
  for var I := 0 to Attributes.Count - 1 do
    AddRow(Attributes.KeyNames[I], Attributes.ValueFromIndex[I]);
  if ValueListEditor.Cells[0, 1] = 'Delete' then
    ValueListEditor.DeleteRow(1);
  if Row < ValueListEditor.RowCount then
    ValueListEditor.Row := Row;
  SetWidthAndHeight;
  SetPositionRelativTo(Control);
  Result := (ShowModal = mrOk);
end;

procedure TFObjectGenerator.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
var
  Left, Top, Width, Height, Col: Integer;
begin
  Left := PPIScale(AppStorage.ReadInteger(BasePath + '\Left', 300));
  Top := PPIScale(AppStorage.ReadInteger(BasePath + '\Top', 200));
  Width := PPIScale(AppStorage.ReadInteger(BasePath + '\Width', 100));
  Height := PPIScale(AppStorage.ReadInteger(BasePath + '\Height', 200));
  Left := Min(Left, Screen.Width - 100);
  Top := Min(Top, Screen.Height - 100);
  Width := Min(Width, Screen.Width div 2);
  Height := Min(Height, Screen.Height div 2);
  SetBounds(Left, Top, Width, Height);
  Width := ValueListEditor.Width;
  Col := PPIScale(AppStorage.ReadInteger(BasePath + '\ValueListEditor.ColWidth',
    Width div 2));
  if Col < Width * 2 div 10 then
    Col := Width * 2 div 10;
  if Col > Width * 8 div 10 then
    Col := Width * 8 div 10;
  ValueListEditor.ColWidths[0] := Col;
  AppStorage.ReadPersistent(BasePath + '\Font', Font);
  if Font.Size > 30 then
    Font.Size := 30;
  Font.Size := PPIScale(Font.Size);
end;

procedure TFObjectGenerator.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath + '\Left', PPIUnScale(Left));
  AppStorage.WriteInteger(BasePath + '\Top', PPIUnScale(Top));
  AppStorage.WriteInteger(BasePath + '\Width', PPIUnScale(Width));
  AppStorage.WriteInteger(BasePath + '\Height', PPIUnScale(Height));
  AppStorage.WriteInteger(BasePath + '\ValueListEditor.ColWidth',
    PPIUnScale(ValueListEditor.ColWidths[0]));
  var
  Str := Font.Size;
  Font.Size := PPIUnScale(Font.Size);
  AppStorage.WritePersistent(BasePath + '\Font', Font);
  Font.Size := Str;
end;

procedure TFObjectGenerator.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  ResourcesDataModule.dlgFontDialog.Options := [];
  if ResourcesDataModule.dlgFontDialog.Execute then
    Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
end;

procedure TFObjectGenerator.DeleteComponent(Component: TControl);
var
  Collapsed: Boolean;

  procedure DeleteAComponent(Control: TControl);
  var
    Int: Integer;
  begin
    if Control is TBaseWidget then
      (Control as TBaseWidget).DeleteWidget;
    Int := FObjectInspector.CBObjects.Items.IndexOf((Control as TBaseWidget)
      .GetNameAndType);
    FObjectInspector.CBObjects.Items.Delete(Int);
  end;

  procedure DeleteAllComponents(Control: TControl);
  begin
    if Control is TWinControl then
      for var I := 0 to (Control as TWinControl).ControlCount - 1 do
        DeleteAllComponents((Control as TWinControl).Controls[I]);
    DeleteAComponent(Control);
  end;

begin
  Collapsed := FPartner.isGUICreationCollapsed;
  LockFormUpdate(FPartner);
  DeleteAllComponents(Component);
  FPartner.NeedsParsing := True;
  if PyIDEOptions.CodeFoldingForGuiElements and Collapsed then
    FPartner.CollapseGUICreation;
  UnlockFormUpdate(FPartner);
end;

procedure TFObjectGenerator.PrepareEditClass(const ACaption, Title,
  ObjectNameOld: string);
begin
  Self.Caption := ACaption;
  ValueListEditor.TitleCaptions.Text := Title;
  for var I := ValueListEditor.RowCount - 1 downto 2 do
    ValueListEditor.DeleteRow(I);
  ValueListEditor.Cells[0, 1] := _('Name of object');
  ValueListEditor.Cells[1, 1] := ObjectNameOld;
end;

procedure TFObjectGenerator.PrepareEditObjectOrParams(const ACaption,
  Title: string);
begin
  Self.Caption := ACaption;
  ValueListEditor.TitleCaptions.Text := Title;
  for var I := ValueListEditor.RowCount - 1 downto 2 do
    ValueListEditor.DeleteRow(I);
  // it'Str not possible to delete row[1] now
  ValueListEditor.Cells[0, 1] := 'Delete';
end;

procedure TFObjectGenerator.SetControlEvents(DesignForm: TFGuiForm;
  EditorForm: TEditorForm);
var
  Comp: TControl;
  Event: TEvent;
  Eventname: string;
  PropInfos: PPropList;
  Widget: TBaseWidget;
  Count: Integer;
begin
  // create source code for copy&paste of events
  EditorForm.ActiveSynEdit.BeginUpdate;
  for var I := 0 to DesignForm.ComponentCount do
  begin
    if I = DesignForm.ComponentCount then
      Comp := DesignForm
    else
      Comp := TControl(DesignForm.Components[I]);
    Count := GetPropList(Comp.ClassInfo, tkAny, nil);
    GetMem(PropInfos, Count * SizeOf(PPropInfo));
    try
      GetPropList(Comp.ClassInfo, tkAny, PropInfos);
      for var J := 0 to Count - 1 do
      begin
        Eventname := string(PropInfos[J].Name);
        if IsEvent('|' + Eventname + '|') then
        begin
          GetEventProperties(Comp, Eventname, Event);
          if Event.Active and not(EditorForm.getLineNumberOfBinding(Comp.Name,
            Eventname) > 0) then
            if Comp is TBaseWidget then
            begin
              Widget := Comp as TBaseWidget;
              EditorForm.InsertProcedure(CrLf + Widget.MakeHandler(Eventname));
              EditorForm.InsertTkBinding(Name, Eventname,
                Widget.MakeBinding(Eventname));
            end
            else if Comp = DesignForm then
            begin
              EditorForm.InsertProcedure
                (CrLf + DesignForm.MakeHandler(Eventname));
              EditorForm.InsertTkBinding(Name, Eventname,
                DesignForm.MakeBinding(Eventname));
            end;
        end;
      end;
    finally
      FreeMem(PropInfos, Count * SizeOf(PPropInfo));
    end;
  end;
  EditorForm.ActiveSynEdit.EndUpdate;
  FObjectInspector.SetBNewDeleteCaption;
end;

procedure TFObjectGenerator.SetComponentValues(DesignForm: TFGuiForm;
  Control: TControl);
var
  Comp1, Comp2: TControl;
  Widget: TBaseWidget;
  Str, Attr, ForbiddenAttributes, AllowedAttributes: string;
  Font1, Font2: TFont;
  PropInfos1, PropInfos2: PPropList;
  Count: Integer;
  PropEditor1: TELPropEditor;
  PropEditor2: TELPropEditor;
  EditorClass: TELPropEditorClass;
  PropertyInspector: TELCustomPropertyInspector;
begin
  Comp1 := Control;
  Str := Comp1.ClassName;
  Comp2 := TControlClass(GetClass(Str)).Create(DesignForm);
  ForbiddenAttributes := ' Hint Name Left Top Width Height Caption Command ';
  Widget := Comp1 as TBaseWidget;
  AllowedAttributes := Widget.GetAttributes(3);

  Count := GetPropList(Comp1.ClassInfo, tkAny, nil);
  GetMem(PropInfos1, Count * SizeOf(PPropInfo));
  GetMem(PropInfos2, Count * SizeOf(PPropInfo));
  try
    GetPropList(Comp1.ClassInfo, tkAny, PropInfos1);
    GetPropList(Comp2.ClassInfo, tkAny, PropInfos2);
    PropertyInspector := TELCustomPropertyInspector.Create(nil);
    for var I := 0 to Count - 1 do
    begin
      Attr := string(PropInfos1[I].Name);
      if (Pos(' ' + Attr + ' ', ForbiddenAttributes) = 0) and
        (Pos('|' + Attr + '|', AllowedAttributes) > 0) then
      begin
        EditorClass := PropertyInspector.GetEditorClass(Comp1, PropInfos1[I]);
        if Assigned(EditorClass) then
        begin
          PropEditor1 := EditorClass.Create2(Comp1, PropInfos1[I]);
          PropEditor2 := EditorClass.Create2(Comp2, PropInfos2[I]);
          try
            if PropEditor2.Value <> PropEditor1.Value then
              SetAttributForComponent(Attr, PropEditor1.Value,
                string(PropEditor1.PropTypeInfo.Name), Comp1)
            else if (PropEditor1.PropTypeInfo.Name = 'TFont') then
            begin
              Font1 := (PropEditor1 as TELFontPropEditor).GetFont;
              Font2 := (PropEditor2 as TELFontPropEditor).GetFont;
              if (Font1.Name <> Font2.Name) or (Font1.Size <> Font2.Size) or
                (Font1.Style <> Font2.Style) then
                SetAttributForComponent(Attr, PropEditor1.Value,
                  string(PropEditor1.PropTypeInfo.Name), Comp1);
            end
            else if PropEditor1.PropTypeInfo.Name = 'TStrings' then
            begin
              if (PropEditor1 as TELStringsPropEditor).GetText <>
                (PropEditor2 as TELStringsPropEditor).GetText then
                SetAttributForComponent(Attr, PropEditor1.Value,
                  string(PropEditor1.PropTypeInfo.Name), Comp1);
            end;
          finally
            FreeAndNil(PropEditor1);
            FreeAndNil(PropEditor2);
          end;
        end;
      end;
    end;
  finally
    FreeMem(PropInfos1, Count * SizeOf(PPropInfo));
    FreeMem(PropInfos2, Count * SizeOf(PPropInfo));
    FreeAndNil(PropertyInspector);
    FreeAndNil(Comp2);
  end;
end;

procedure TFObjectGenerator.SetPositionRelativTo(AControl: TControl);
begin
  var
  ScreenPos := AControl.ClientToScreen(Point(0, 0));
  if ScreenPos.Y < Height then
    SetBounds(ScreenPos.X, ScreenPos.Y + AControl.Height, Width, Height)
  else
    SetBounds(ScreenPos.X, ScreenPos.Y - Height, Width, Height);
end;

procedure TFObjectGenerator.SetWidthAndHeight;
var
  Max1, Max2: Integer;
  Content: string;
begin
  Max1 := 0;
  Max2 := 0;
  for var I := 0 to ValueListEditor.RowCount - 1 do
  begin
    Content := ValueListEditor.Cells[0, I];
    Max1 := Math.Max(Canvas.TextWidth(Content), Max1);
    Content := ValueListEditor.Cells[1, I];
    Max2 := Math.Max(Canvas.TextWidth(Content), Max2);
  end;
  Max1 := Max1 + 10;
  Max2 := Max2 + 10;
  if ValueListEditor.ColWidths[0] < Max1 then
    ValueListEditor.ColWidths[0] := Max1;
  if ValueListEditor.ColWidths[1] < Max2 then
    ValueListEditor.ColWidths[1] := Max2;
  Width := Max3(PPIScale(Max1 + 3 + Max2),
    PPIScale(Canvas.TextWidth(Caption) + 55), PPIScale(270));
  Height := PPIScale(70) + (ValueListEditor.RowCount + 1) *
    ValueListEditor.DefaultRowHeight;
end;

function TFObjectGenerator.Indent2: string;
begin
  Result := FConfiguration.Indent2;
end;

end.
