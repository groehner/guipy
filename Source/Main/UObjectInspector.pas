unit UObjectInspector;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, ComCtrls, StdCtrls, ExtCtrls,
  TypInfo, Menus, Forms, JvAppStorage, frmIDEDockWin, ELDsgnr, ELPropInsp,
  TB2Item, SpTBXItem;

type

  TFObjectInspector = class(TIDEDockWindow, IJvAppStorageHandler)
    PObjects: TPanel;
      CBObjects: TComboBox;
    TCAttributesEvents: TTabControl;
    PNewDel: TPanel;
      BNewDelete: TButton;
      BMore: TButton;
    PMObjectInspector: TSpTBXPopupMenu;
    MIClose: TSpTBXItem;
    MIFont: TSpTBXItem;
    MIDefaultLayout: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIPaste: TSpTBXItem;
    MICopy: TSpTBXItem;
    MICut: TSpTBXItem;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);

    procedure ELPropertyInspectorClick(Sender: TObject);
    procedure ELPropertyInspectorFilterProp(Sender: TObject; AInstance: TPersistent;
      APropInfo: PPropInfo; var AIncludeProp: Boolean);
    procedure ELPropertyInspectorModified(Sender: TObject);

    procedure ELEventInspectorClick(Sender: TObject);
    procedure ELEventInspectorFilterProp(Sender: TObject; AInstance: TPersistent;
      APropInfo: PPropInfo; var AIncludeProp: Boolean);
    procedure ELEventInspectorModified(Sender: TObject);

    procedure ELObjectInspectorDeactivate(Sender: TObject);
    procedure BMoreClick(Sender: TObject);
    procedure BNewDeleteClick(Sender: TObject);
    procedure MICopyClick(Sender: TObject);
    procedure MICutClick(Sender: TObject);
    procedure MIPasteClick(Sender: TObject);
    procedure MIDefaultLayoutClick(Sender: TObject);
    procedure MIFontClick(Sender: TObject);
    procedure MICloseClick(Sender: TObject);

    procedure CBObjectsChange(Sender: TObject);
    procedure TCAttributesEventsChange(Sender: TObject);
    procedure PMObjectInspectorPopup(Sender: TObject);
    procedure FormMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure OnMouseDownEvent(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TCAttributesEventsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure setTabs;
    procedure MyOnGetSelectStrings(Sender: TObject; event: string; AResult: TStrings);
    procedure MyOnGetComponentNames(Sender: TObject; AClass: TComponentClass; AResult: TStrings);
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    ELPropertyInspector: TELPropertyInspector;
    ELEventInspector: TELPropertyInspector;
    Events: string;
    Attributes: string;
    ShowEvents: integer;
    ShowAttributes: integer;

    destructor Destroy; override;
    procedure RefreshCBObjects;
    procedure OnEnterEvent(Sender: TObject);
    procedure SetSelectedObject(Control: TControl);
    procedure ChangeSelection(SelectedControls: TELDesignerSelectedControls);
    procedure CBChangeName(const OldName, NewName: string);
    procedure SetBNewDeleteCaption;
    procedure SetButtonCaption(aShow: integer);
    procedure CutToClipboard;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;
    procedure SetFontSize(Delta: integer);
    procedure SetFont(aFont: TFont);
    procedure UpdateState;
    procedure Add(AObject: TControl);
    procedure ChangeStyle;
  end;

var
  FObjectInspector: TFObjectInspector = nil;

implementation

uses SysUtils, Dialogs, Clipbrd, Math, Themes, JvGnugettext, StringResources,
     UGUIForm, UGUIDesigner, UKoppel, UObjectGenerator, frmPyIDEMain,
     UConfiguration, UUtils, UBaseWidgets, UBaseQtWidgets, ELEvents, frmFile, frmEditor,
     dmCommands;

{$R *.dfm}

procedure TFObjectInspector.FormCreate(Sender: TObject);
begin
  inherited;
  visible:= false;
  ShowEvents:= 1;
  ShowAttributes:= 1;
  ELPropertyInspector:= TELPropertyInspector.Create(Self);
  with ELPropertyInspector do begin
    Parent:= Self;
    Align:= alClient;
    BorderStyle:= bsNone;
    OnFilterProp:= ELPropertyInspectorFilterProp;
    OnModified  := ELPropertyInspectorModified;
    OnClick     := ELPropertyInspectorClick;
    OnGetComponentNames:= MyOnGetComponentNames;
    OnMouseDown := OnMouseDownEvent;
    OnEnter     := OnEnterEvent;
  end;
  ELEventInspector:= TELPropertyInspector.Create(Self);
  with ELEventInspector do begin
    Parent:= self;
    Align:= alClient;
    BorderStyle:= bsNone;
    Visible:= False;
    ReadOnly:= false;
    OnFilterProp:= ELEventInspectorFilterProp;
    OnModified  := ELEventInspectorModified;
    OnClick     := ELEventInspectorClick;
    OnMouseDown := OnMouseDownEvent;
    OnEnter     := OnEnterEvent;
    OnGetSelectStrings:= MyOnGetSelectStrings;
  end;
  OnDeactivate:= ELObjectInspectorDeactivate;
  PObjects.Autosize:= true;
  CBObjects.Align:= alTop;
  Font.Name:= 'Segoe UI';
  Font.Size:= 10;
  TranslateComponent(Self);
  ChangeStyle;
end;

procedure TFObjectInspector.FormDeactivate(Sender: TObject);
begin
  ELPropertyInspector.UpdateActiveRow;
end;

procedure TFObjectInspector.OnMouseDownEvent(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // due to wrong determination auf parent form if form is docked
  SetFocus;
end;

destructor TFObjectInspector.Destroy;
begin
  FreeAndNil(ELPropertyInspector);
  FreeAndNil(ELEventInspector);
  inherited Destroy;
end;

procedure TFObjectInspector.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  ELPropertyInspector.Splitter := AppStorage.ReadInteger(BasePath + '\ELPropertyInspector.Splitter', 100);
  ELEventInspector.Splitter := AppStorage.ReadInteger(BasePath + '\ELEventInspector.Splitter', 100);
  AppStorage.ReadPersistent(BasePath + '\Font', Font);
end;

procedure TFObjectInspector.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath + '\ELPropertyInspector.Splitter', ELPropertyInspector.Splitter);
  AppStorage.WriteInteger(BasePath + '\ELEventInspector.Splitter', ELEventInspector.Splitter);
  AppStorage.WritePersistent(BasePath+'\Font', Font);
end;

procedure TFObjectInspector.CBChangeName(const OldName, NewName: string);
  var s: string; i: integer;
begin
  i:= CBObjects.ItemIndex;
  s:= myStringReplace(CBObjects.Items[i], OldName, NewName);
  CBObjects.Items[i]:= s;
  CBObjects.ItemIndex:= i;
  FGUIDesigner.ELDesigner.SelectedControls.Items[0].Invalidate;
end;

procedure TFObjectInspector.MyOnGetComponentNames(Sender: TObject; AClass: TComponentClass; AResult: TStrings);
  var i: integer; Form: TFGUIForm;
begin
  if not FGUIDesigner.ELDesigner.Active then exit;
  Form:= TFGUIForm(FGUIDesigner.ELDesigner.DesignControl);
  for i:= 0 to Form.ComponentCount - 1 do
    AResult.Add(Form.Components[i].Name);
end;

procedure TFObjectInspector.MyOnGetSelectStrings(Sender: TObject; event: string; AResult: TStrings);
  var SourceWidget: TBaseQtWidget; Parametertypes: string; i: integer;
      GuiForm: TFGuiForm;
begin
  SourceWidget:= TBaseQtWidget(FGUIDesigner.ELDesigner.SelectedControls[0]);
  Parametertypes:= SourceWidget.Parametertypes(event);
  GuiForm:= TFGUIForm(FGUIDesigner.ELDesigner.DesignControl);
  for i:= 0 to GuiForm.ComponentCount - 1 do
    if GuiForm.Components[i] is TBaseQtWidget then
      (GuiForm.Components[i] as TBaseQtWidget).getSlots(Parametertypes, AResult);
end;

procedure TFObjectInspector.OnEnterEvent(Sender: TObject);
begin
  UpdateState;
end;

procedure TFObjectInspector.setTabs;
  var FrameType: integer;
begin
  FrameType:= TEditorForm(TFGUIForm(FGUIDesigner.ELDesigner.DesignControl).Partner).FrameType;
  if FrameType < 3
    then TCAttributesEvents.Tabs[1]:= _('Events')
    else TCAttributesEvents.Tabs[1]:= _('Signals');
end;

procedure TFObjectInspector.RefreshCBObjects;
  var i: integer; Form: TFGUIForm;
begin
  CBObjects.Clear;
  if not FGUIDesigner.ELDesigner.Active then exit;
  Form:= TFGUIForm(FGUIDesigner.ELDesigner.DesignControl);
  setTabs;
  if Assigned(Form) then begin
    CBObjects.Items.AddObject(Form.Name + ': Frame', Form);
    for i:= 0 to Form.ComponentCount - 1 do
      if Form.Components[i] is TBaseWidget then
        CBObjects.Items.AddObject(
          (Form.Components[i] as TBaseWidget).getNameAndType, Form.Components[i]);
  end;
  CBObjects.ItemIndex:= -1;
  if FGUIDesigner.ELDesigner.SelectedControls.Count = 1 then begin
    CBObjects.ItemIndex:= CBObjects.Items.IndexOfObject(FGUIDesigner.ELDesigner.SelectedControls[0]);
    SetSelectedObject(FGUIDesigner.ELDesigner.SelectedControls[0]);
  end;
end;

procedure TFObjectInspector.SetSelectedObject(Control: TControl);
begin
  if Control = nil then begin
    CBObjects.ItemIndex:= -1;
    CBObjects.Repaint;
  end else begin
    CBObjects.ItemIndex:= CBObjects.Items.IndexOfObject(Control);
    ELPropertyInspector.Clear;
    ELEventInspector.Clear;
    ELPropertyInspector.Add(Control);
    ELEventInspector.Add(Control);
  end;
end;

procedure TFObjectInspector.CBObjectsChange(Sender: TObject);
  var ctrl: TControl;
begin
  if CBObjects.ItemIndex = -1 then exit;
  ctrl:= TControl(CBObjects.Items.Objects[CBObjects.ItemIndex]);
  ctrl.BringToFront;
  FGUIDesigner.ELDesigner.SelectedControls.Clear;
  FGUIDesigner.ELDesigner.SelectedControls.Add(ctrl);
end;

procedure TFObjectInspector.FormMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if ELPropertyInspector.Visible
    then ELPropertyInspector.SetFocus
    else ELEventInspector.SetFocus;
end;

procedure TFObjectInspector.FormShow(Sender: TObject);
begin
  SetButtonCaption(1);
  TCAttributesEvents.Height:= Canvas.TextHeight('Attribute') + 10;
  PObjects.Height:= TCAttributesEvents.Height;
  ELPropertyInspector.SetFocus;
end;

procedure TFObjectInspector.MICloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFObjectInspector.MICutClick(Sender: TObject);
begin
  CutToClipboard;
end;

procedure TFObjectInspector.MICopyClick(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TFObjectInspector.MIPasteClick(Sender: TObject);
begin
  PasteFromClipboard;
end;

procedure TFObjectInspector.MIDefaultLayoutClick(Sender: TObject);
begin
  //FJava.MIDefaultLayoutClick(Self); ToDo
end;

procedure TFObjectInspector.MIFontClick(Sender: TObject);
begin
  CommandsDataModule.dlgFontDialog.Font.Assign(Font);
  CommandsDataModule.dlgFontDialog.Options:= [];
  if CommandsDataModule.dlgFontDialog.Execute then
    Font.Assign(CommandsDataModule.dlgFontDialog.Font);
  TCAttributesEvents.Height:= Canvas.TextHeight('Attribute') + 10;
  PObjects.Height:= TCAttributesEvents.Height;
end;

procedure TFObjectInspector.ELPropertyInspectorModified(Sender: TObject);
  var i, iValue: integer; Partner: TEditorForm;
      OldName, NewName, Caption: string;
      PropertyItem: TELPropertyInspectorItem;
      Control: TControl;
      Widget: TBaseWidget;

  procedure ChangeName(OldName, NewName: string; Control: TControl);
  begin
    Widget:= TBaseWidget(Control);
    Widget.Rename(OldName, NewName, Widget.getEvents(3));
    CBChangeName(OldName, NewName);
    // update eventnames
    ELEventInspector.Clear;
    ELEventInspector.Add(Widget);
  end;

begin
  PropertyItem:= TELPropertyInspectorItem(ELPropertyInspector.ActiveItem);
  if PropertyItem = nil then exit;
  Caption:= PropertyItem.Caption;
  with FGUIDesigner.ELDesigner do begin
    TFGUIForm(DesignControl).Modified:= true;
    Partner:= TEditorForm(TFGUIForm(DesignControl).Partner);
    if ((Caption = 'Width') or (Caption = 'Height') or  (Caption = 'X') or (Caption = 'Y')) and
      TryStrToInt(PropertyItem.Editor.Value, iValue) then
        for i:= 0 to SelectedControls.Count-1 do begin
          if Caption = 'Width' then
            SelectedControls.Items[i].Width:= iValue
          else if Caption = 'Height' then
            SelectedControls.Items[i].Height:= iValue
          else if Caption = 'X' then
            SelectedControls.Items[i].Left:= iValue
          else if Caption = 'Y' then
            SelectedControls.Items[i].Top:= iValue;
          FObjectGenerator.MoveOrSizeComponent(Partner, SelectedControls.Items[i])
        end
    else if (Caption = 'Name') and (PropertyItem.Level = 0) then begin
      OldName:= CBObjects.Text;
      var p:= Pos(':', OldName);
      if p > 0 then begin
        delete(OldName, p, length(OldName));
        Control:= SelectedControls.Items[0];
        ChangeName(OldName, Control.Name, Control);

         {
        Widget:= TBaseWidget(SelectedControls.Items[0]);
        Widget.Rename(OldName, Widget.Name, Widget.getEvents(3));
        CBChangeName(OldName, Widget.Name);
        // update eventnames
        ELEventInspector.Clear;
        ELEventInspector.Add(Widget);
        }
      end;
    end else
      for i:= 0 to SelectedControls.Count-1 do begin
        OldName:= SelectedControls.Items[I].Name;
        if GuiPyOptions.NameFromText and (ELPropertyInspector.GetByCaption('Name') <> '')
           and (Caption = 'Text') then begin
          NewName:= UpperLower(PropertyItem.Editor.Value);   // get name from text
          if NewName <> '' then begin
            if SelectedControls.Items[i].Tag in [1, 31, 71, 4, 34, 74, 5, 35, 75] then
            begin
              Widget:= TBaseWidget(SelectedControls.Items[i]);
              Widget.SizeToText;
              FObjectGenerator.MoveOrSizeComponent(Partner, Widget);
            end;
            case SelectedControls.Items[i].Tag of
              1, 31, 71: NewName:= 'l' + NewName;  // Label
              4, 34, 74: NewName:= 'b' + NewName;  // Button
              5, 35, 75: NewName:= 'cb' + NewName; // Checkbutton
              else NewName:= '';
            end;
            if NewName <> '' then begin
              NewName:= UUtils.GetUniqueName(FGUIDesigner.ELDesigner.DesignControl, NewName);
              ELPropertyInspector.SetByCaption('Name', NewName);
              ELPropertyInspector.SelectByCaption('Name'); // make name to ActiveItem
              ELPropertyInspectorModified(nil);
              ELPropertyInspector.SelectByCaption('Text');  // make text to ActiveItem again
              ChangeName(OldName, NewName, SelectedControls.Items[i]);
            end;
          end;
        end;

        FObjectGenerator.SetAttributForComponent(PropertyItem.Caption,
          PropertyItem.Editor.Value,
          String(PropertyItem.Editor.PropTypeInfo.Name),
          SelectedControls.Items[i]);
      end
  end;
  ELPropertyInspector.UpdateItems;  // due to renaming of Images, Command, ...
end;

procedure TFObjectInspector.ELPropertyInspectorFilterProp(
  Sender: TObject; AInstance: TPersistent; APropInfo: PPropInfo; var AIncludeProp: Boolean);
  var s: string;
begin
  AIncludeProp:= false;
  if assigned(APropInfo) and assigned(AInstance)
    then s:= String(APropInfo^.Name)
    else exit;
  if not isEvent(s) then begin
    if AInstance is TFont then
      AIncludeProp:= (Pos(' ' + s + ' ', ' Name Size Style ') > 0)
    else
      if (AInstance is TFGuiForm) or (AInstance is TBaseWidget) then
        AIncludeProp:= (Pos('|' + s + '|', Attributes) > 0)
  end;
end;

procedure TFObjectInspector.ELEventInspectorFilterProp(
  Sender: TObject; AInstance: TPersistent; APropInfo: PPropInfo; var AIncludeProp: Boolean);
begin
  AIncludeProp:= Pos('|' + String(APropInfo.Name) + '|', Events) > 0;
end;

procedure TFObjectInspector.ELEventInspectorModified(Sender: TObject);
  var PropertyItem: TELPropertyInspectorItem;
      i: integer;
begin
  PropertyItem:= TELPropertyInspectorItem(ELEventInspector.ActiveItem);
  if PropertyItem = nil then exit;
  with FGUIDesigner.ELDesigner do begin
    TFGUIForm(DesignControl).Modified:= true;
    for i:= 0 to SelectedControls.Count - 1 do
      if IsLower(PropertyItem.Caption[1]) then
        FObjectGenerator.SetSlotForComponent(PropertyItem.Caption,
          PropertyItem.DisplayValue, SelectedControls.Items[i])
      else
        FObjectGenerator.SetEventForComponent(PropertyItem.Caption,
          SelectedControls.Items[i]);
  end;
  ELPropertyInspector.UpdateItems;  // due to renaming of Images, Command, ...
end;

procedure TFObjectInspector.BNewDeleteClick(Sender: TObject);
  var Eventname: string;
      PropertyItem: TELPropsPageItem;
      GUIForm: TFGUIForm;
      Partner: TEditorForm;
      Control: TControl;
      Widget: TBaseWidget;
      Event: TEvent;
      i: integer;

  procedure SetDisplayValue(value: string);
  begin
    ELEventInspector.OnModified:= nil;
    PropertyItem.DisplayValue:= Value;
    ELEventInspector.OnModified:= ELEventInspectorModified;
  end;

begin
  Event:= nil;
  PropertyItem:= ELEventInspector.ActiveItem;
  if not assigned(PropertyItem) then exit;
  i:= CBObjects.ItemIndex;
  if i > -1
    then Control:= TControl(CBObjects.Items.Objects[i])
    else exit;
  GUIForm:= TFGUIForm(FGUIDesigner.ELDesigner.DesignControl);
  Partner:= TEditorForm(GUIForm.Partner);
  Partner.ActiveSynEdit.BeginUpdate;
  Eventname:= PropertyItem.Caption;
  getEventProperties(Control, Eventname, Event);
  if Control is TBaseWidget
    then Widget:= Control as TBaseWidget
    else Widget:= nil;
  if PropertyItem.DisplayValue <> '' then begin     // Delete
    SetDisplayValue('');
    if assigned(Widget)
      then Widget.DeleteEventHandler(Eventname)
      else GUIForm.DeleteEventHandler(Eventname);
    if assigned(Event) then
      Event.Clear;
  end else begin                                    // Insert
    if assigned(Widget) then begin
      setDisplayValue(Widget.Handlername(Eventname));
      Widget.setEvent(Eventname);
    end else begin
      setDisplayValue(GUIForm.Handlername(Eventname));
      GUIForm.setEvent(Eventname);
    end;
    if assigned(Event) then
      Event.Active:= true;
  end;
  if assigned(Event) then
    setEventProperties(Control, Eventname, Event);
  Partner.ActiveSynEdit.EndUpdate;
  Partner.NeedsParsing:= true;
  SetBNewDeleteCaption;
end;

procedure TFObjectInspector.ELPropertyInspectorClick(Sender: TObject);
begin
  UpdateState;
end;

procedure TFObjectInspector.ELObjectInspectorDeactivate(Sender: TObject);
  // take last input from ObjectInspector
begin
  ELPropertyInspector.UpdateActiveRow;
end;

procedure TFObjectInspector.TCAttributesEventsChange(Sender: TObject);
begin
  case TCAttributesEvents.TabIndex of
    0: begin
         ELEventInspector.Visible:= false;
         ELPropertyInspector.Visible:= true;
         BNewDelete.visible:= false;
         SetButtonCaption(ShowAttributes);
         ELPropertyInspector.SetFocus;
      end;
   1: begin
         ELPropertyInspector.Visible:= false;
         ELEventInspector.Visible:= true;
         BNewDelete.Visible:= true;
         SetBNewDeleteCaption;
         SetButtonCaption(ShowEvents);
         ELEventInspector.SetFocus;
       end;
  end;
  UpdateState;
end;

procedure TFObjectInspector.TCAttributesEventsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;
end;

procedure TFObjectInspector.setButtonCaption(aShow: integer);
begin
  case aShow of
      1: BMore.Caption:= _('More');
      2: BMore.Caption:= _('Full');
    else BMore.Caption:= _('Default');
  end;
end;

procedure TFObjectInspector.SetBNewDeleteCaption;
begin
  if ELEventInspector.ActiveItem = nil then exit;
  if ELEventInspector.ActiveItem.DisplayValue = ''
    then BNewDelete.Caption:= _('New')
    else BNewDelete.Caption:= _('Delete');
end;

procedure TFObjectInspector.BMoreClick(Sender: TObject);
begin
  if ELEventInspector.Visible then begin
    Inc(ShowEvents);
    if ShowEvents = 4 then
       ShowEvents:= 1;
    if FGUIDesigner.ELDesigner.SelectedControls.Count > 0 then begin
      ELEventInspector.Clear;
      Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
      ELEventInspector.Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
    end;
    SetButtonCaption(ShowEvents);
    SetBNewDeleteCaption;
  end else begin
    Inc(ShowAttributes);
    if ShowAttributes = 4 then
       ShowAttributes:= 1;
    if FGUIDesigner.ELDesigner.SelectedControls.Count > 0 then begin
      ELPropertyInspector.Clear;
      Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
      ELPropertyInspector.Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
    end;
    SetButtonCaption(ShowAttributes);
    SetBNewDeleteCaption;
  end;
end;

procedure TFObjectInspector.ELEventInspectorClick(Sender: TObject);
begin
  SetBNewDeleteCaption;
end;

procedure TFObjectInspector.PMObjectInspectorPopup(Sender: TObject);
begin
  MICut.Visible:= (TCAttributesEvents.TabIndex = 0);
  MICopy.Visible:= MICut.Visible;
  MIPaste.Visible:= MICut.Visible;
end;

procedure TFObjectInspector.CutToClipboard;
  var PropertyItem: TELPropertyInspectorItem;
begin
  if TCAttributesEvents.TabIndex = 0 then begin
    PropertyItem:= TELPropertyInspectorItem(ELPropertyInspector.ActiveItem);
    Clipboard.AsText:= PropertyItem.DisplayValue;
    PropertyItem.DisplayValue:= '';
  end;
end;

procedure TFObjectInspector.CopyToClipboard;
  var PropertyItem: TELPropertyInspectorItem;
begin
  if TCAttributesEvents.TabIndex = 0 then begin
    PropertyItem:= TELPropertyInspectorItem(ELPropertyInspector.ActiveItem);
    Clipboard.AsText:= PropertyItem.DisplayValue;
  end;
end;

procedure TFObjectInspector.PasteFromClipboard;
  var PropertyItem: TELPropertyInspectorItem;
begin
  if TCAttributesEvents.TabIndex = 0 then begin
    PropertyItem:= TELPropertyInspectorItem(ELPropertyInspector.ActiveItem);
    PropertyItem.DisplayValue:= Clipboard.AsText;
  end;
end;

procedure TFObjectInspector.ChangeSelection(SelectedControls: TELDesignerSelectedControls);
  var i: integer; s: string;
begin
  if assigned(ELPropertyInspector.ActiveItem)
    then s:= ELPropertyInspector.ActiveItem.Caption
    else s:= '';
  ELPropertyInspector.Clear;
  ELEventInspector.Clear;
  if SelectedControls.Count <> 1
    then CBObjects.ItemIndex:= -1
    else CBObjects.ItemIndex:= CBObjects.Items.IndexOfObject(SelectedControls[0]);
  if SelectedControls.Count > 0 then
    Add(SelectedControls[0]);
  for i:= 0 to SelectedControls.Count - 1 do begin
    ELPropertyInspector.Add(SelectedControls[i]);
    ELEventInspector.Add(SelectedControls[i]);
  end;
  if s <> '' then
    ELPropertyInspector.SelectByCaption(s);
  SetBNewDeleteCaption;
end;

procedure TFObjectInspector.SetFont(aFont: TFont);
begin
  Font.Assign(aFont);
  TCAttributesEvents.Height:= Canvas.TextHeight('Attribute') + 10;
  PObjects.Height:= TCAttributesEvents.Height;
end;

procedure TFObjectInspector.SetFontSize(Delta: integer);
  var Size: integer;
begin
  Size:= Font.Size + Delta;
  if Size < 6 then Size:= 6;
  Font.Size:= Size;
  TCAttributesEvents.Height:= Canvas.TextHeight('Attribute') + 10;
  PObjects.Height:= TCAttributesEvents.Height;
  Show;
end;

procedure TFObjectInspector.UpdateState;
  //var b: boolean;
begin
  //b:= (TCAttributesEvents.TabIndex = 0) and (ELPropertyInspector.SelText <> '');
{  with FJava do begin
    SetEnabledMI(MICut, b);
    SetEnabledMI(MICopy, b);
    SetEnabledMI(MIPaste, Clipboard.HasFormat(CF_Text) and (TCAttributesEvents.TabIndex = 0));
  end;}
end;

procedure TFObjectInspector.Add(AObject: TControl);
  var Widget: TBaseWidget; GuiForm: TFGuiForm;
begin
  if AObject is TBaseWidget then begin
    Widget:= AObject as TBaseWidget;
    Events:= Widget.getEvents(ShowEvents);
    Attributes:= Widget.getAttributes(ShowAttributes) + '|';
  end
  else if AObject is TFGuiForm then begin
    GuiForm:= AObject as TFGuiForm;
    Events:= GuiForm.getEvents(ShowEvents);
    Attributes:= GuiForm.getAttributes(ShowAttributes);
  end;
end;

procedure TFObjectInspector.ChangeStyle;
begin
  if StyleServices.IsSystemStyle then begin
    ELPropertyInspector.Color:= clBtnFace;
    ELPropertyInspector.Font.Color:= clBlack;
    ELPropertyInspector.ValuesColor:= clNavy;
    ELEventInspector.Color:= clBtnFace;
    ELEventInspector.Font.Color:= clBlack;
    ELEventInspector.ValuesColor:= clNavy;
  end else begin
    ELPropertyInspector.Color:= StyleServices.GetSystemColor(clBtnFace);
    ELPropertyInspector.Font.Color:= StyleServices.getStyleFontColor(sfTabTextInactiveNormal);
    ELPropertyInspector.ValuesColor:= StyleServices.getStyleFontColor(sfTabTextActiveNormal);
    ELEventInspector.Color:= StyleServices.GetSystemColor(clBtnFace);
    ELEventInspector.Font.Color:= StyleServices.getStyleFontColor(sfTabTextInactiveNormal);
    ELEventInspector.ValuesColor:= StyleServices.getStyleFontColor(sfTabTextActiveNormal);
  end;
end;

end.


