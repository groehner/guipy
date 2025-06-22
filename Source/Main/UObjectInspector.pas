unit UObjectInspector;

interface

uses
  Classes,
  Graphics,
  Controls,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  TypInfo,
  Vcl.Menus,
  JvAppStorage,
  SpTBXItem,
  TB2Item,
  frmIDEDockWin,
  ELDsgnr,
  ELPropInsp;

type
  TFObjectInspector = class(TIDEDockWindow, IJvAppStorageHandler)
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

    procedure ELPropertyInspectorModified(Sender: TObject);
    procedure ELPropertyInspectorFilterProp(Sender: TObject;
      AInstance: TPersistent; APropInfo: PPropInfo; var AIncludeProp: Boolean);

    procedure ELEventInspectorModified(Sender: TObject);
    procedure ELEventInspectorClick(Sender: TObject);
    procedure ELEventInspectorDblClick(Sender: TObject);
    procedure ELEventInspectorFilterProp(Sender: TObject;
      AInstance: TPersistent; APropInfo: PPropInfo; var AIncludeProp: Boolean);

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
    procedure OnMouseDownEvent(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TCAttributesEventsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FAttributes: string;
    FELEventInspector: TELPropertyInspector;
    FELPropertyInspector: TELPropertyInspector;
    FEvents: string;
    FShowAttributes: Integer;
    FShowEvents: Integer;
    procedure SetTabs;
    procedure SetFont(AFont: TFont);
    procedure MyOnGetSelectStrings(Sender: TObject; Event: string;
      AResult: TStrings);
    procedure MyOnGetComponentNames(Sender: TObject; AClass: TComponentClass;
      AResult: TStrings);
    procedure CBChangeName(const OldName, NewName: string);
    procedure RefreshCB(NewName: string = '');
    procedure SetButtonCaption(Show: Integer);
    procedure UpdatePropertyInspector;
    procedure UpdateEventInspector;
  protected
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string);
    procedure Add(AObject: TControl);
  public
    destructor Destroy; override;
    procedure RefreshCBObjects;
    procedure SetSelectedObject(Control: TControl);
    procedure ChangeSelection(SelectedControls: TELDesignerSelectedControls);
    procedure SetBNewDeleteCaption;
    procedure CutToClipboard;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;
    procedure ChangeStyle;

    property Attributes: string read FAttributes;
    property ELEventInspector: TELPropertyInspector read FELEventInspector;
    property ELPropertyInspector: TELPropertyInspector
      read FELPropertyInspector;
    property Events: string read FEvents;
    property ShowAttributes: Integer read FShowAttributes;
    property ShowEvents: Integer read FShowEvents;
  end;

var
  FObjectInspector: TFObjectInspector = nil;

implementation

uses
  Windows,
  SysUtils,
  Clipbrd,
  Themes,
  Forms,
  JvGnugettext,
  frmEditor,
  frmPyIDEMain,
  dmResources,
  uCommonFunctions,
  ELEvents,
  UBaseWidgets,
  UBaseQtWidgets,
  UGUIForm,
  UGUIDesigner,
  UObjectGenerator,
  UConfiguration,
  UUtils;

{$R *.dfm}

procedure TFObjectInspector.FormCreate(Sender: TObject);
begin
  inherited;
  Visible := False;
  FShowEvents := 1;
  FShowAttributes := 1;
  FELPropertyInspector := TELPropertyInspector.Create(Self);
  with FELPropertyInspector do
  begin
    Parent := Self;
    Align := alClient;
    BorderStyle := bsNone;
    OnFilterProp := ELPropertyInspectorFilterProp;
    OnModified := ELPropertyInspectorModified;
    OnGetComponentNames := MyOnGetComponentNames;
    OnMouseDown := OnMouseDownEvent;
  end;
  FELEventInspector := TELPropertyInspector.Create(Self);
  with FELEventInspector do
  begin
    Parent := Self;
    Align := alClient;
    BorderStyle := bsNone;
    Visible := False;
    ReadOnly := False;
    OnFilterProp := ELEventInspectorFilterProp;
    OnClick := ELEventInspectorClick;
    OnDblClick := ELEventInspectorDblClick;
    OnModified := ELEventInspectorModified;
    OnMouseDown := OnMouseDownEvent;
    OnGetSelectStrings := MyOnGetSelectStrings;
  end;
  OnDeactivate := ELObjectInspectorDeactivate;
  CBObjects.Align := alTop;
  TranslateComponent(Self);
  ChangeStyle;
end;

procedure TFObjectInspector.FormDeactivate(Sender: TObject);
begin
  FELPropertyInspector.UpdateActiveRow;
end;

procedure TFObjectInspector.OnMouseDownEvent(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // due to wrong determination of parent form if form is docked
  if CanFocus then
    SetFocus;
end;

destructor TFObjectInspector.Destroy;
begin
  FreeAndNil(FELPropertyInspector);
  FreeAndNil(FELEventInspector);
  inherited Destroy;
end;

procedure TFObjectInspector.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  FELPropertyInspector.Splitter :=
    PPIScale(AppStorage.ReadInteger(BasePath +
    '\FELPropertyInspector.Splitter', 100));
  FELEventInspector.Splitter :=
    PPIScale(AppStorage.ReadInteger(BasePath +
    '\FELEventInspector.Splitter', 100));
end;

procedure TFObjectInspector.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath + '\FELPropertyInspector.Splitter',
    PPIUnScale(FELPropertyInspector.Splitter));
  AppStorage.WriteInteger(BasePath + '\FELEventInspector.Splitter',
    PPIUnScale(FELEventInspector.Splitter));
end;

procedure TFObjectInspector.CBChangeName(const OldName, NewName: string);
var
  Str: string;
  Index: Integer;
begin
  Index := CBObjects.ItemIndex;
  Str := MyStringReplace(CBObjects.Items[Index], OldName, NewName);
  CBObjects.Items[Index] := Str;
  CBObjects.ItemIndex := Index;
  FGUIDesigner.ELDesigner.SelectedControls[0].Invalidate;
end;

procedure TFObjectInspector.MyOnGetComponentNames(Sender: TObject;
  AClass: TComponentClass; AResult: TStrings);
var
  Form: TFGuiForm;
begin
  if not FGUIDesigner.ELDesigner.Active then
    Exit;
  Form := TFGuiForm(FGUIDesigner.ELDesigner.DesignControl);
  for var I := 0 to Form.ComponentCount - 1 do
    AResult.Add(Form.Components[I].Name);
end;

procedure TFObjectInspector.MyOnGetSelectStrings(Sender: TObject; Event: string;
  AResult: TStrings);
var
  SourceWidget: TBaseQtWidget;
  Parametertypes: string;
  GuiForm: TFGuiForm;
begin
  if FGUIDesigner.ELDesigner.SelectedControls[0] is TBaseQtWidget then
  begin
    SourceWidget := FGUIDesigner.ELDesigner.SelectedControls[0]
      as TBaseQtWidget;
    Parametertypes := SourceWidget.Parametertypes(Event);
  end
  else
    Parametertypes := '';
  AResult.Add('');
  AResult.Add(SourceWidget.Name + '_' + Event);
  GuiForm := TFGuiForm(FGUIDesigner.ELDesigner.DesignControl);
  for var I := 0 to GuiForm.ComponentCount - 1 do
    if GuiForm.Components[I] is TBaseQtWidget then
      (GuiForm.Components[I] as TBaseQtWidget).GetSlots(Parametertypes,
        AResult);
end;

procedure TFObjectInspector.RefreshCB(NewName: string = '');
var
  Index: Integer;
  Typ, Nam, NamTyp: string;
  Form: TFGuiForm;
begin
  if not FGUIDesigner.ELDesigner.Active then
    Exit;
  Form := TFGuiForm(FGUIDesigner.ELDesigner.DesignControl);
  Index := CBObjects.ItemIndex;
  if Assigned(Form) then
  begin
    SetTabs;
    CBObjects.Clear;
    CBObjects.Items.AddObject(Form.Name + ': Frame', Form);
    for var I := 0 to Form.ComponentCount - 1 do
    begin
      Nam := Form.Components[I].Name;
      if Form.Components[I] is TBaseWidget then
      begin
        Typ := (Form.Components[I] as TBaseWidget).GetType;
        if (Nam <> '') and (Typ <> '') then
          CBObjects.Items.AddObject(Nam + ': ' + Typ, Form.Components[I]);
        if Nam = NewName then
          NamTyp := Nam + ': ' + Typ;
      end;
    end;
  end;
  if NewName = '' then
    CBObjects.ItemIndex := Index
  else
    CBObjects.ItemIndex := CBObjects.Items.IndexOf(NamTyp);
end;

procedure TFObjectInspector.RefreshCBObjects;
begin
  RefreshCB;
  if FGUIDesigner.ELDesigner.SelectedControls.Count = 1 then
  begin
    CBObjects.ItemIndex := CBObjects.Items.IndexOfObject
      (FGUIDesigner.ELDesigner.SelectedControls[0]);
    try
      SetSelectedObject(FGUIDesigner.ELDesigner.SelectedControls[0]);
    except
    end;
  end;
end;

procedure TFObjectInspector.SetTabs;
var
  FrameType: Integer;
begin
  FrameType := TFGuiForm(FGUIDesigner.ELDesigner.DesignControl)
    .Partner.FrameType;
  if FrameType < 3 then
    TCAttributesEvents.Tabs[1] := _('Events')
  else
    TCAttributesEvents.Tabs[1] := _('Signals');
end;

procedure TFObjectInspector.SetSelectedObject(Control: TControl);
begin
  if not Assigned(Control) then
  begin
    CBObjects.ItemIndex := -1;
    CBObjects.Repaint;
  end
  else
  begin
    CBObjects.ItemIndex := CBObjects.Items.IndexOfObject(Control);
    FELPropertyInspector.Clear;
    FELEventInspector.Clear;
    FELPropertyInspector.Add(Control);
    FELEventInspector.Add(Control);
  end;
end;

procedure TFObjectInspector.CBObjectsChange(Sender: TObject);
var
  Control: TControl;
begin
  if CBObjects.ItemIndex = -1 then
    Exit;
  Control := TControl(CBObjects.Items.Objects[CBObjects.ItemIndex]);
  Control.BringToFront;
  FGUIDesigner.ELDesigner.SelectedControls.Clear;
  FGUIDesigner.ELDesigner.SelectedControls.Add(Control);
end;

procedure TFObjectInspector.FormMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if FELPropertyInspector.Visible and FELPropertyInspector.CanFocus then
    FELPropertyInspector.SetFocus
  else if FELEventInspector.CanFocus then
    FELEventInspector.SetFocus;
end;

procedure TFObjectInspector.FormShow(Sender: TObject);
begin
  SetButtonCaption(1);
  Font.Assign(GuiPyOptions.InspectorFont);
  Font.Size := PPIScale(Font.Size);
  SetFont(Font);
  TCAttributesEvents.Height := Canvas.TextHeight('Attribute') + 10;
  CBObjects.Height := TCAttributesEvents.Height;
  if FELPropertyInspector.CanFocus then
    FELPropertyInspector.SetFocus;
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
  PyIDEMainForm.mnViewDefaultLayoutClick(Self);
end;

procedure TFObjectInspector.SetFont(AFont: TFont);
begin
  FELPropertyInspector.Font.Size := AFont.Size;
  FELPropertyInspector.Font.Name := AFont.Name;
  FELEventInspector.Font.Size := AFont.Size;
  FELEventInspector.Font.Name := AFont.Name;
  Canvas.Font.Size := AFont.Size;
  TCAttributesEvents.Height := Canvas.TextHeight('Attribute') + 10;
  CBObjects.Height := TCAttributesEvents.Height;
  AFont.Size := PPIUnScale(AFont.Size);
  GuiPyOptions.InspectorFont.Assign(AFont);
end;

procedure TFObjectInspector.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  ResourcesDataModule.dlgFontDialog.Options := [];
  if ResourcesDataModule.dlgFontDialog.Execute then
  begin
    Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
    SetFont(Font);
  end;
end;

// DPI awareness for object inspector
// width, height, x, y are scaled to fit the real widget values
// setPositionAndSize must unscale for correct values in the source code
//
// width, height, x, y must be shown unscaled
// this is done in TELPropertyInspectorItem.UpdateParams;

procedure TFObjectInspector.ELPropertyInspectorModified(Sender: TObject);
var
  IValue: Integer;
  Partner: TEditorForm;
  OldName, NewName, Caption: string;
  PropertyItem: TELPropertyInspectorItem;
  Control: TControl;
  Widget: TBaseWidget;

  procedure ChangeName(OldName, NewName: string; Control: TControl);
  begin
    Widget := TBaseWidget(Control);
    Widget.Rename(OldName, NewName, Widget.GetEvents(3));
    CBChangeName(OldName, NewName);
    // update eventnames
    FELEventInspector.Clear;
    FELEventInspector.Add(Widget);
  end;

  function PPIScale(ASize: Integer): Integer;
  begin
    Result := MulDiv(ASize, FCurrentPPI, 96);
  end;

begin
  PropertyItem := TELPropertyInspectorItem(FELPropertyInspector.ActiveItem);
  if not Assigned(PropertyItem) then
    Exit;
  Caption := PropertyItem.Caption;
  with FGUIDesigner.ELDesigner do
  begin
    TFGuiForm(DesignControl).Modified := True;
    Partner := TFGuiForm(DesignControl).Partner;
    if ((Caption = 'Width') or (Caption = 'Height') or (Caption = 'X') or
      (Caption = 'Y')) and TryStrToInt(PropertyItem.Editor.Value, IValue) then
      for var I := 0 to SelectedControls.Count - 1 do
      begin
        if Caption = 'Width' then
          SelectedControls[I].Width := PPIScale(IValue)
        else if Caption = 'Height' then
          SelectedControls[I].Height := PPIScale(IValue)
        else if Caption = 'X' then
          SelectedControls[I].Left := PPIScale(IValue)
        else if Caption = 'Y' then
          SelectedControls[I].Top := PPIScale(IValue);
        FObjectGenerator.MoveOrSizeComponent(Partner, SelectedControls[I]);
      end
    else if (Caption = 'Name') and (PropertyItem.Level = 0) then
    begin
      OldName := CBObjects.Text;
      Delete(OldName, Pos(':', OldName), Length(OldName));
      Control := SelectedControls[0];
      ChangeName(OldName, Control.Name, Control);
    end
    else
      for var I := 0 to SelectedControls.Count - 1 do
      begin
        OldName := SelectedControls[I].Name;
        if GuiPyOptions.NameFromText and
          (FELPropertyInspector.GetByCaption('Name') <> '') and
          (Caption = 'Text') then
        begin
          NewName := UpperLower(PropertyItem.Editor.Value);
          // get name from text
          if NewName <> '' then
          begin
            if SelectedControls[I].Tag in [1, 31, 71, 4, 34, 74, 5, 35, 75]
            then
            begin
              Widget := TBaseWidget(SelectedControls[I]);
              Widget.SizeToText;
              FObjectGenerator.MoveOrSizeComponent(Partner, Widget);
            end;
            case SelectedControls[I].Tag of
              1, 31, 71:
                NewName := 'l' + NewName; // Label
              4, 34, 74:
                NewName := 'b' + NewName; // Button
              5, 35, 75:
                NewName := 'cb' + NewName; // Checkbutton
            else
              NewName := '';
            end;
            if NewName <> '' then
            begin
              NewName := UUtils.GetUniqueName
                (FGUIDesigner.ELDesigner.DesignControl, NewName);
              FELPropertyInspector.SetByCaption('Name', NewName);
              FELPropertyInspector.SelectByCaption('Name');
              // make name to ActiveItem
              ELPropertyInspectorModified(nil);
              FELPropertyInspector.SelectByCaption('Text');
              // make text to ActiveItem again
              ChangeName(OldName, NewName, SelectedControls.Items[I]);
            end;
          end;
        end;
        FObjectGenerator.SetAttributForComponent(PropertyItem.Caption,
          PropertyItem.Editor.Value,
          string(PropertyItem.Editor.PropTypeInfo.Name),
          SelectedControls[I]);
      end;
  end;
  FELPropertyInspector.UpdateItems; // due to renaming of Images, Command, ...
end;

procedure TFObjectInspector.ELPropertyInspectorFilterProp(Sender: TObject;
  AInstance: TPersistent; APropInfo: PPropInfo; var AIncludeProp: Boolean);
var
  Str: string;
begin
  AIncludeProp := False;
  if Assigned(APropInfo) and Assigned(AInstance) then
    Str := string(APropInfo^.Name)
  else
    Exit;
  if not IsEvent(Str) then
  begin
    if AInstance is TFont then
      AIncludeProp := (Pos(' ' + Str + ' ', ' Name Size Style ') > 0)
    else if (AInstance is TFGuiForm) or (AInstance is TBaseWidget) then
      AIncludeProp := (Pos('|' + Str + '|', FAttributes) > 0);
  end;
end;

procedure TFObjectInspector.ELEventInspectorFilterProp(Sender: TObject;
  AInstance: TPersistent; APropInfo: PPropInfo; var AIncludeProp: Boolean);
begin
  AIncludeProp := Pos('|' + string(APropInfo.Name) + '|', FEvents) > 0;
end;

procedure TFObjectInspector.ELEventInspectorModified(Sender: TObject);
begin
  var
  PropertyItem := TELPropertyInspectorItem(FELEventInspector.ActiveItem);
  if not Assigned(PropertyItem) then
    Exit;
  with FGUIDesigner.ELDesigner do
  begin
    TFGuiForm(DesignControl).Modified := True;
    for var I := 0 to SelectedControls.Count - 1 do
      FObjectGenerator.SetSlotForComponent(PropertyItem.Caption,
        PropertyItem.DisplayValue, SelectedControls[I]);
    SetBNewDeleteCaption;
  end;
end;

procedure TFObjectInspector.BNewDeleteClick(Sender: TObject);
var
  Eventname: string;
  PropertyItem: TELPropsPageItem;
  GuiForm: TFGuiForm;
  Partner: TEditorForm;
  Control: TControl;
  Widget: TBaseWidget;
  Event: TEvent;
  Index: Integer;

  procedure SetDisplayValue(Value: string);
  begin
    FELEventInspector.OnModified := nil;
    PropertyItem.DisplayValue := Value;
    FELEventInspector.OnModified := ELEventInspectorModified;
  end;

begin
  Event := nil;
  PropertyItem := FELEventInspector.ActiveItem;
  if not Assigned(PropertyItem) then
    Exit;
  Index := CBObjects.ItemIndex;
  if Index = -1 then
    Exit;
  Control := TControl(CBObjects.Items.Objects[Index]);
  GuiForm := TFGuiForm(FGUIDesigner.ELDesigner.DesignControl);
  Partner := GuiForm.Partner;
  Partner.ActiveSynEdit.BeginUpdate;
  Eventname := PropertyItem.Caption;
  GetEventProperties(Control, Eventname, Event);
  if Control is TBaseWidget then
    Widget := Control as TBaseWidget
  else
    Widget := nil;
  if PropertyItem.DisplayValue <> '' then
  begin // Delete
    SetDisplayValue('');
    if Assigned(Widget) then
      Widget.DeleteEventHandler(Eventname)
    else
      GuiForm.DeleteEventHandler(Eventname);
    if Assigned(Event) then
      Event.Clear;
  end
  else
  begin // Insert
    if Assigned(Widget) then
    begin
      SetDisplayValue(Widget.Handlername(Eventname));
      Widget.SetEvent(Eventname);
    end
    else
    begin
      SetDisplayValue(GuiForm.Handlername(Eventname));
      GuiForm.SetEvent(Eventname);
    end;
    if Assigned(Event) then
      Event.Active := True;
  end;
  if Assigned(Event) then
    SetEventProperties(Control, Eventname, Event);
  Partner.ActiveSynEdit.EndUpdate;
  Partner.NeedsParsing := True;
  SetBNewDeleteCaption;
end;

procedure TFObjectInspector.ELObjectInspectorDeactivate(Sender: TObject);
// take last input from ObjectInspector
begin
  FELPropertyInspector.UpdateActiveRow;
end;

procedure TFObjectInspector.TCAttributesEventsChange(Sender: TObject);
begin
  case TCAttributesEvents.TabIndex of
    0:
      begin
        FELEventInspector.Visible := False;
        FELPropertyInspector.Visible := True;
        BNewDelete.Visible := False;
        SetButtonCaption(FShowAttributes);
        if FELPropertyInspector.CanFocus then
          FELPropertyInspector.SetFocus;
      end;
    1:
      begin
        FELPropertyInspector.Visible := False;
        FELEventInspector.Visible := True;
        BNewDelete.Visible := True;
        SetBNewDeleteCaption;
        SetButtonCaption(FShowEvents);
        if FELEventInspector.CanFocus then
          FELEventInspector.SetFocus;
      end;
  end;
end;

procedure TFObjectInspector.TCAttributesEventsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if CanFocus then
    SetFocus;
end;

procedure TFObjectInspector.SetButtonCaption(Show: Integer);
begin
  case Show of
    1:
      BMore.Caption := _('More');
    2:
      BMore.Caption := _('Full');
  else
    BMore.Caption := _('Default');
  end;
end;

procedure TFObjectInspector.SetBNewDeleteCaption;
begin
  if FELEventInspector.ActiveItem = nil then
    Exit;
  if FELEventInspector.ActiveItem.DisplayValue = '' then
    BNewDelete.Caption := _('New')
  else
    BNewDelete.Caption := _('Delete');
  UpdateEventInspector;
end;

procedure TFObjectInspector.BMoreClick(Sender: TObject);
begin
  if FELEventInspector.Visible then
  begin
    Inc(FShowEvents);
    if FShowEvents = 4 then
      FShowEvents := 1;
    if FGUIDesigner.ELDesigner.SelectedControls.Count > 0 then
    begin
      FELEventInspector.Clear;
      Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
      FELEventInspector.Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
    end;
    SetButtonCaption(FShowEvents);
    SetBNewDeleteCaption;
  end
  else
  begin
    Inc(FShowAttributes);
    if FShowAttributes = 4 then
      FShowAttributes := 1;
    if FGUIDesigner.ELDesigner.SelectedControls.Count > 0 then
    begin
      FELPropertyInspector.Clear;
      Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
      FELPropertyInspector.Add(FGUIDesigner.ELDesigner.SelectedControls[0]);
    end;
    SetButtonCaption(FShowAttributes);
    SetBNewDeleteCaption;
  end;
end;

procedure TFObjectInspector.ELEventInspectorClick(Sender: TObject);
begin
  SetBNewDeleteCaption;
end;

procedure TFObjectInspector.ELEventInspectorDblClick(Sender: TObject);
begin
  if Assigned(ELEventInspector.ActiveItem) then
  begin
    var
    Str := ELEventInspector.ActiveItem.DisplayValue;
    if Str = '' then
      BNewDeleteClick(Self)
    else
    begin
      var
      Partner := TEditorForm
        (TFGuiForm(FGUIDesigner.ELDesigner.DesignControl).Partner);
      Partner.GoTo2('def ' + Str);
      if Assigned(FGUIDesigner) then
        FGUIDesigner.GUIDesignerTimer.Enabled := True;
    end;
  end;
  UpdateEventInspector;
end;

procedure TFObjectInspector.PMObjectInspectorPopup(Sender: TObject);
begin
  MICut.Visible := (TCAttributesEvents.TabIndex = 0);
  MICopy.Visible := MICut.Visible;
  MIPaste.Visible := MICut.Visible;
end;

procedure TFObjectInspector.CutToClipboard;
var
  PropertyItem: TELPropertyInspectorItem;
begin
  if TCAttributesEvents.TabIndex = 0 then
  begin
    PropertyItem := TELPropertyInspectorItem(FELPropertyInspector.ActiveItem);
    if Assigned(PropertyItem) then
    begin
      Clipboard.AsText := PropertyItem.DisplayValue;
      PropertyItem.DisplayValue := '';
    end;
  end;
end;

procedure TFObjectInspector.CopyToClipboard;
var
  PropertyItem: TELPropertyInspectorItem;
begin
  if TCAttributesEvents.TabIndex = 0 then
  begin
    PropertyItem := TELPropertyInspectorItem(FELPropertyInspector.ActiveItem);
    if Assigned(PropertyItem) then
      Clipboard.AsText := PropertyItem.DisplayValue;
  end;
end;

procedure TFObjectInspector.PasteFromClipboard;
var
  PropertyItem: TELPropertyInspectorItem;
begin
  if TCAttributesEvents.TabIndex = 0 then
  begin
    PropertyItem := TELPropertyInspectorItem(FELPropertyInspector.ActiveItem);
    if Assigned(PropertyItem) then
      PropertyItem.DisplayValue := Clipboard.AsText;
  end;
end;

procedure TFObjectInspector.ChangeSelection(SelectedControls
  : TELDesignerSelectedControls);
var
  Str: string;
begin
  if Assigned(FELPropertyInspector.ActiveItem) then
    Str := FELPropertyInspector.ActiveItem.Caption
  else
    Str := '';
  FELPropertyInspector.Clear;
  FELEventInspector.Clear;
  if SelectedControls.Count <> 1 then
    CBObjects.ItemIndex := -1
  else
    CBObjects.ItemIndex := CBObjects.Items.IndexOfObject(SelectedControls[0]);
  if SelectedControls.Count > 0 then
    Add(SelectedControls[0]);
  for var I := 0 to SelectedControls.Count - 1 do
  begin
    FELPropertyInspector.Add(SelectedControls[I]);
    FELEventInspector.Add(SelectedControls[I]);
  end;
  if Str <> '' then
    FELPropertyInspector.SelectByCaption(Str);
  SetBNewDeleteCaption;
end;

procedure TFObjectInspector.UpdatePropertyInspector;
begin
  TThread.ForceQueue(nil,
    procedure
    begin
      FELPropertyInspector.UpdateItems;
    end);
end;

procedure TFObjectInspector.UpdateEventInspector;
begin
  TThread.ForceQueue(nil,
    procedure
    begin
      FELEventInspector.UpdateItems;
    end);
end;

procedure TFObjectInspector.Add(AObject: TControl);
var
  Widget: TBaseWidget;
  GuiForm: TFGuiForm;
begin
  if AObject is TBaseWidget then
  begin
    Widget := AObject as TBaseWidget;
    FEvents := Widget.GetEvents(FShowEvents);
    FAttributes := Widget.GetAttributes(FShowAttributes) + '|';
  end
  else if AObject is TFGuiForm then
  begin
    GuiForm := AObject as TFGuiForm;
    FEvents := GuiForm.GetEvents(FShowEvents);
    FAttributes := GuiForm.GetAttributes(FShowAttributes);
  end;
end;

procedure TFObjectInspector.ChangeStyle;
begin
  if StyleServices.IsSystemStyle then
  begin
    FELPropertyInspector.Color := clBtnFace;
    FELPropertyInspector.Font.Color := clBlack;
    FELPropertyInspector.ValuesColor := clNavy;
    FELEventInspector.Color := clBtnFace;
    FELEventInspector.Font.Color := clBlack;
    FELEventInspector.ValuesColor := clNavy;
  end
  else
  begin
    FELPropertyInspector.Color := StyleServices.GetSystemColor(clBtnFace);
    FELPropertyInspector.Font.Color := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal);
    FELPropertyInspector.ValuesColor := StyleServices.GetStyleFontColor
      (sfTabTextActiveNormal);
    FELEventInspector.Color := StyleServices.GetSystemColor(clBtnFace);
    FELEventInspector.Font.Color := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal);
    FELEventInspector.ValuesColor := StyleServices.GetStyleFontColor
      (sfTabTextActiveNormal);
  end;
end;

end.
