unit UGUIDesigner;

interface

uses
  Classes,
  Controls,
  Forms,
  ExtCtrls,
  ImgList,
  System.Actions,
  System.Generics.Collections,
  System.ImageList,
  Vcl.Menus,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  Vcl.StdCtrls,
  Vcl.ActnList,
  SVGIconImageCollection,
  SpTBXItem,
  TB2Item,
  dlgPyIDEBase,
  ELDsgnr,
  UGUIForm,
  frmEditor;

type
  TFGuiDesigner = class(TPyIDEDlgBase)
    GUIDesignerTimer: TTimer;
    PopupMenu: TSpTBXPopupMenu;
    MIPaste: TSpTBXItem;
    MICopy: TSpTBXItem;
    MICut: TSpTBXItem;
    MIDelete: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MISnapToGrid: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MIAlign: TSpTBXSubmenuItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    MIBackground: TSpTBXItem;
    MIForeground: TSpTBXItem;
    MIToSource: TSpTBXItem;
    MIClose: TSpTBXItem;
    MISameDistanceVert: TSpTBXItem;
    MIAlignCenteredInWindowVert: TSpTBXItem;
    MIAlignBottom: TSpTBXItem;
    MIAlignMiddle: TSpTBXItem;
    MIAlignTop: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    MISameDistanceHorz: TSpTBXItem;
    MIAlignCenteredInWindowHorz: TSpTBXItem;
    MIAlignRight: TSpTBXItem;
    MIAlignCentered: TSpTBXItem;
    MIAlignLeft: TSpTBXItem;
    MIZoomIn: TSpTBXItem;
    MIZoomOut: TSpTBXItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    scGuiDesignerLight: TSVGIconImageCollection;
    vilGuiDesignerLight: TVirtualImageList;
    scGUIDesignerDark: TSVGIconImageCollection;
    vilGUIDesignerDark: TVirtualImageList;
    icPythonControls: TSVGIconImageCollection;
    vilPythonControls: TVirtualImageList;
    icQtControls: TSVGIconImageCollection;
    vilQtControls1616: TVirtualImageList;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    MIConfiguration: TSpTBXItem;
    ActionList: TActionList;
    actEditCopy: TAction;
    actEditCut: TAction;
    actEditPaste: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ELDesignerControlInserting(Sender: TObject;
      var AControlClass: TControlClass);
    procedure ELDesignerControlInserted(Sender: TObject);
    procedure ELDesignerChangeSelection(Sender: TObject);
    procedure ELDesignerModified(Sender: TObject);
    procedure ELDesignerDesignFormClose(Sender: TObject;
      var Action: TCloseAction);
    procedure ELDesignerControlDeleting(Sender: TObject;
      SelectedControls: TELDesignerSelectedControls);
    procedure ELDesignerDblClick(Sender: TObject);
    procedure ELDesignerGetUniqueName(Sender: TObject; const ABaseName: string;
      var AUniqueName: string);
    procedure ELDragDrop(Sender, ASource, ATarget: TObject;
      XPos, YPos: Integer);
    procedure ELDragOver(Sender, ASource, ATarget: TObject; XPos, YPos: Integer;
      AState: TDragState; var Accept: Boolean);
    procedure MIDeleteClick(Sender: TObject);
    procedure MICloseClick(Sender: TObject);
    procedure MIToSourceClick(Sender: TObject);
    procedure MISnapToGridClick(Sender: TObject);
    procedure GUIDesignerTimerTimer(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure CutClick(Sender: TObject);
    procedure PasteClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure MIForegroundClick(Sender: TObject);
    procedure MIBackgroundClick(Sender: TObject);
    procedure MIAlignClick(Sender: TObject);
    procedure MIZoomInClick(Sender: TObject);
    procedure MIZoomOutClick(Sender: TObject);
    procedure MIConfigurationClick(Sender: TObject);
  private
    FComponentToInsert: TControlClass;
    FDesignForm: TFGuiForm;
    FELDesigner: TELDesigner;
    FClassMap: TDictionary<Integer, TControlClass>;
    procedure SetEnabledMI(MenuItem: TSpTBXItem; Enabled: Boolean);
    function GetPixelsPerInchOfFile(const Filename: string): Integer;
    procedure RemovePixelsPerInch0(const Filename: string);
    procedure AddTkToClassMap;
    procedure AddQtToClassMap;
  public
    procedure Save(const Filename: string; Formular: TFGuiForm);
    function Open(const Filename: string): TFGuiForm;
    procedure FindMethod(Reader: TReader; const Methodname: string;
      var Address: Pointer; var Error: Boolean);
    procedure ErrorMethod(Reader: TReader; const Message: string;
      var Handled: Boolean);
    function Tag2Class(Tag: Integer): TControlClass;
    procedure SetToolButton(Tag: Integer);
    procedure ChangeTo(Formular: TFGuiForm);
    function GetEditForm: TEditorForm;
    procedure UpdateState(Modified: Boolean);
    function GetPath: string;
    procedure ScaleImages;
    procedure ChangeStyle;
    property DesignForm: TFGuiForm read FDesignForm write FDesignForm;
    property ELDesigner: TELDesigner read FELDesigner;
  end;

  TMyDragObject = class(TDragControlObjectEx)
  private
    FDragImages: TDragImageList;
  protected
    function GetDragImages: TDragImageList; override;
  public
    constructor Create(AControl: TControl); override;
    destructor Destroy; override;
  end;

var
  FGUIDesigner: TFGuiDesigner = nil;

implementation

uses
  System.Types,
  SysUtils,
  Graphics,
  JvGnugettext,
  StringResources,
  UBaseWidgets,
  UTKButtonBase,
  UTKTextBase,
  UTKMiscBase,
  UTTKButtonBase,
  UTTKTextBase,
  UTTKMiscBase,
  UQtButtonBase,
  UQtWidgetDescendants,
  UQtFrameBased,
  UQtScrollable,
  UQtItemViews,
  UQtSpinBoxes,
  uCommonFunctions,
  UUtils,
  ULink,
  uEditAppIntfs,
  UObjectInspector,
  UObjectGenerator,
  UConfiguration;

{$R *.dfm}

type
  TClassArray = array [1 .. 81] of TPersistentClass;

const
  Modified = True;

  ClassArray: TClassArray = (TFGuiForm, TKLabel, TKEntry, TKText, TKButton,
    TKCheckbutton, TKRadiobuttonGroup, TKListbox, TKSpinbox, TKMessage,
    TKCanvas, TKScrollbar, TKFrame, TKLabelframe, TKScale, TKPanedWindow,
    TKOptionMenu, TKMenu, TKPopupMenu, TKMenubutton,

    TTKLabel, TTKEntry, TTKButton, TTKCheckbutton, TTKRadiobuttonGroup,
    TTKCombobox, TTKSpinbox, TTKFrame, TTKLabelframe, TTKScale, TTKLabeledScale,
    TTKPanedWindow, TTKScrollbar, TTKMenubutton, TTKOptionMenu, TTKNotebook,
    TTKTreeview, TTKProgressbar, TTKSeparator, TTKSizeGrip,

    TQtLabel, TQtLineEdit, TQtPlainTextEdit, TQtPushButton, TQtCheckBox,
    TQtButtonGroup, TQtListWidget, TQtComboBox, TQtSpinBox, TQtScrollBar,
    TQtCanvas, TQtFrame, TQtGroupBox, TQtSlider, TQtMenuBar, TQtMenu,
    TQtTabWidget, TQtTreeWidget, TQtTableWidget, TQtProgressBar, TQtStatusBar,

    TQtTextEdit, TQtTextBrowser, TQtToolButton, TQtCommandLinkButton,
    TQtFontComboBox, TQtDoubleSpinBox, TQtLCDNumber, TQtDateTimeEdit,
    TQtDateEdit, TQtTimeEdit, TQtDial, TQtLine, TQtScrollArea, TQtToolBox,
    TQtStackedWidget, TQtListView, TQtColumnView, TQtTreeView, TQtTableView,
    TQtGraphicsView);

procedure TFGuiDesigner.FormCreate(Sender: TObject);
begin
  inherited;
  FELDesigner := TELDesigner.Create(Self);
  FELDesigner.PopupMenu := PopupMenu;
  with FELDesigner do
  begin
    ShowingHints := [htControl, htSize, htMove, htInsert];
    ClipboardFormat := 'Extension Library designer components';
    OnModified := ELDesignerModified;
    OnGetUniqueName := ELDesignerGetUniqueName;
    OnControlInserting := ELDesignerControlInserting;
    OnDragDrop := ELDragDrop;
    OnDragOver := ELDragOver;
    OnControlInserted := ELDesignerControlInserted;
    OnControlDeleting := ELDesignerControlDeleting;
    OnChangeSelection := ELDesignerChangeSelection;
    OnDesignFormClose := ELDesignerDesignFormClose;
    OnDblClick := ELDesignerDblClick;
  end;
  FELDesigner.GuiDesignerHints := GuiPyOptions.GuiDesignerHints;
  FClassMap := TDictionary<Integer, TControlClass>.Create;
  AddTkToClassMap;
  AddQtToClassMap;
  ChangeStyle;
end;

procedure TFGuiDesigner.ChangeTo(Formular: TFGuiForm);
begin
  if Assigned(FELDesigner) then
  begin
    if (FELDesigner.DesignControl <> Formular) or not FELDesigner.Active then
    begin
      FELDesigner.Active := False;
      FELDesigner.DesignControl := Formular;
      FDesignForm := Formular;
      if Assigned(Formular) then
        FELDesigner.Active := True;
      if FObjectInspector.Visible then
        FObjectInspector.RefreshCBObjects;
    end;
  end;
end;

procedure TFGuiDesigner.ELDesignerChangeSelection(Sender: TObject);
begin
  FObjectInspector.ChangeSelection(FELDesigner.SelectedControls);
  UpdateState(not Modified);
end;

procedure TFGuiDesigner.ELDesignerModified(Sender: TObject);
var
  Control: TControl;
begin
  FObjectInspector.ELPropertyInspector.Modified;
  for var I := 0 to FELDesigner.SelectedControls.Count - 1 do
  begin
    Control := FELDesigner.SelectedControls[I];
    FObjectGenerator.MoveOrSizeComponent(GetEditForm, Control);
    if Control is TBaseWidget then
      (Control as TBaseWidget).Resize;
  end;
  UpdateState(Modified);
end;

procedure TFGuiDesigner.UpdateState(Modified: Boolean);
begin
  if Modified and Assigned(FELDesigner.DesignControl) then
    TFGuiForm(FELDesigner.DesignControl).Modified := True;
end;

procedure TFGuiDesigner.PopupMenuPopup(Sender: TObject);
var
  Enable: Boolean;
begin
  SetEnabledMI(MICut, FELDesigner.CanCut);
  SetEnabledMI(MICopy, FELDesigner.CanCopy);
  SetEnabledMI(MIPaste, FELDesigner.CanPaste);
  SetEnabledMI(MIAlign, FELDesigner.SelectedControls.Count > 1);
  MISnapToGrid.Checked := FELDesigner.SnapToGrid;
  Enable := (FELDesigner.SelectedControls.Count > 0) and
    (FELDesigner.SelectedControls[0].ClassName <> 'TFGUIForm');
  SetEnabledMI(MIDelete, Enable);
  Enable := Assigned(FDesignForm.Partner);
  SetEnabledMI(MIForeground, Enable);
  SetEnabledMI(MIBackground, Enable);
end;

procedure TFGuiDesigner.MIDeleteClick(Sender: TObject);
begin
  if not FDesignForm.ReadOnly then
  begin
    FELDesigner.DeleteSelectedControls;
    UpdateState(Modified);
  end;
end;

procedure TFGuiDesigner.MIForegroundClick(Sender: TObject);
begin
  for var I := 0 to FELDesigner.SelectedControls.Count - 1 do
    FObjectGenerator.ComponentToForeground(GetEditForm,
      FELDesigner.SelectedControls[I]);
end;

procedure TFGuiDesigner.MIBackgroundClick(Sender: TObject);
begin
  for var I := 0 to FELDesigner.SelectedControls.Count - 1 do
    FObjectGenerator.ComponentToBackground(GetEditForm,
      FELDesigner.SelectedControls[I]);
end;

procedure TFGuiDesigner.MIAlignClick(Sender: TObject);
var
  AHorzAlign, AVertAlign: TELDesignerAlignType;
  Tag: NativeInt;
begin
  Tag := (Sender as TSpTBXItem).Tag;
  AHorzAlign := atNoChanges;
  AVertAlign := atNoChanges;
  case Tag of
    1:
      AHorzAlign := atLeftTop;
    2:
      AHorzAlign := atCenter;
    3:
      AHorzAlign := atRightBottom;
    4:
      AHorzAlign := atCenterInWindow;
    5:
      AHorzAlign := atSpaceEqually;
    6:
      AVertAlign := atLeftTop;
    7:
      AVertAlign := atCenter;
    8:
      AVertAlign := atRightBottom;
    9:
      AVertAlign := atCenterInWindow;
    10:
      AVertAlign := atSpaceEqually;
  end;
  FELDesigner.SelectedControls.Align(AHorzAlign, AVertAlign);
end;

procedure TFGuiDesigner.ELDesignerControlInserting(Sender: TObject;
  var AControlClass: TControlClass);
begin
  if not FDesignForm.ReadOnly then
    AControlClass := FComponentToInsert;
end;

type
  TControlEx = class(TControl)
  protected
    FFont: TFont;
  end;

procedure TFGuiDesigner.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FClassMap);
end;

procedure TFGuiDesigner.ELDragDrop(Sender, ASource, ATarget: TObject;
  XPos, YPos: Integer);
var
  LInsertingControl: TControl;
  LName: string;
begin
  if csAcceptsControls in (ATarget as TControl).ControlStyle then
  begin
    LInsertingControl := ASource as TControl;
    FELDesigner.GetUniqueName(Tag2PythonType(LInsertingControl.Tag), LName);
    LInsertingControl.Name := LName;
    LInsertingControl.Parent := ATarget as TWinControl;
    LInsertingControl.SetBounds(XPos - LInsertingControl.Width,
      YPos - LInsertingControl.Height, LInsertingControl.Width,
      LInsertingControl.Height);
    TControlEx(LInsertingControl).Font.Size := FDesignForm.FontSize;
    FELDesigner.SelectedControls.ClearExcept(LInsertingControl);
    ELDesignerControlInserted(nil);
    UpdateState(Modified);
  end;
end;

procedure TFGuiDesigner.ELDragOver(Sender, ASource, ATarget: TObject;
  XPos, YPos: Integer; AState: TDragState; var Accept: Boolean);
begin
  Accept := csAcceptsControls in (ATarget as TControl).ControlStyle;
end;

function TFGuiDesigner.Tag2Class(Tag: Integer): TControlClass;
begin
  if not FClassMap.TryGetValue(Tag, Result) then
    Result := nil;
end;

procedure TFGuiDesigner.AddTkToClassMap;
begin
  // Tk base components
  FClassMap.Add(1, TKLabel);
  FClassMap.Add(2, TKEntry);
  FClassMap.Add(3, TKText);
  FClassMap.Add(4, TKButton);
  FClassMap.Add(5, TKCheckbutton);
  FClassMap.Add(7, TKRadiobuttonGroup);
  FClassMap.Add(8, TKListbox);
  FClassMap.Add(9, TKSpinbox);
  FClassMap.Add(10, TKMessage);
  FClassMap.Add(11, TKCanvas);
  FClassMap.Add(12, TKScrollbar);
  FClassMap.Add(13, TKFrame);
  FClassMap.Add(14, TKLabelframe);
  FClassMap.Add(15, TKScale);
  FClassMap.Add(16, TKPanedWindow);
  FClassMap.Add(17, TKMenubutton);
  FClassMap.Add(18, TKOptionMenu);
  FClassMap.Add(19, TKMenu);
  FClassMap.Add(20, TKPopupMenu);
  // Ttk components
  FClassMap.Add(31, TTKLabel);
  FClassMap.Add(32, TTKEntry);
  FClassMap.Add(34, TTKButton);
  FClassMap.Add(35, TTKCheckbutton);
  FClassMap.Add(37, TTKRadiobuttonGroup);
  FClassMap.Add(38, TTKCombobox);
  FClassMap.Add(39, TTKSpinbox);
  FClassMap.Add(42, TTKScrollbar);
  FClassMap.Add(43, TTKFrame);
  FClassMap.Add(44, TTKLabelframe);
  FClassMap.Add(45, TTKScale);
  FClassMap.Add(46, TTKLabeledScale);
  FClassMap.Add(47, TTKPanedWindow);
  FClassMap.Add(48, TTKMenubutton);
  FClassMap.Add(49, TTKOptionMenu);
  FClassMap.Add(50, TTKNotebook);
  FClassMap.Add(51, TTKTreeview);
  FClassMap.Add(52, TTKProgressbar);
  FClassMap.Add(53, TTKSeparator);
  FClassMap.Add(54, TTKSizeGrip);
end;

procedure TFGuiDesigner.AddQtToClassMap;
begin
  // Qt base components
  FClassMap.Add(71, TQtLabel);
  FClassMap.Add(72, TQtLineEdit);
  FClassMap.Add(73, TQtPlainTextEdit);
  FClassMap.Add(74, TQtPushButton);
  FClassMap.Add(75, TQtCheckBox);
  FClassMap.Add(76, TQtButtonGroup);
  FClassMap.Add(77, TQtListWidget);
  FClassMap.Add(78, TQtComboBox);
  FClassMap.Add(79, TQtSpinBox);
  FClassMap.Add(80, TQtScrollBar);
  FClassMap.Add(81, TQtCanvas);
  FClassMap.Add(82, TQtFrame);
  FClassMap.Add(83, TQtGroupBox);
  FClassMap.Add(84, TQtSlider);
  FClassMap.Add(85, TQtMenuBar);
  FClassMap.Add(86, TQtMenu);
  FClassMap.Add(87, TQtTabWidget);
  FClassMap.Add(88, TQtTreeWidget);
  FClassMap.Add(89, TQtTableWidget);
  FClassMap.Add(90, TQtProgressBar);
  FClassMap.Add(91, TQtStatusBar);
  // Qt control components
  FClassMap.Add(101, TQtTextEdit);
  FClassMap.Add(102, TQtTextBrowser);
  FClassMap.Add(103, TQtToolButton);
  FClassMap.Add(104, TQtCommandLinkButton);
  FClassMap.Add(105, TQtFontComboBox);
  FClassMap.Add(106, TQtDoubleSpinBox);
  FClassMap.Add(107, TQtLCDNumber);
  FClassMap.Add(108, TQtDateTimeEdit);
  FClassMap.Add(109, TQtDateEdit);
  FClassMap.Add(110, TQtTimeEdit);
  FClassMap.Add(111, TQtDial);
  FClassMap.Add(112, TQtLine);
  FClassMap.Add(113, TQtScrollArea);
  FClassMap.Add(114, TQtToolBox);
  FClassMap.Add(115, TQtStackedWidget);
  FClassMap.Add(116, TQtListView);
  FClassMap.Add(117, TQtColumnView);
  FClassMap.Add(118, TQtTreeView);
  FClassMap.Add(119, TQtTableView);
  FClassMap.Add(120, TQtGraphicsView);
end;

procedure TFGuiDesigner.SetToolButton(Tag: Integer);
begin
  FComponentToInsert := nil;
  var
  EditorForm := GetEditForm;
  if Assigned(EditorForm) then
  begin
    GComponentNrToInsert := Tag;
    FComponentToInsert := Tag2Class(Tag);
  end;
end;

procedure TFGuiDesigner.MIZoomOutClick(Sender: TObject);
begin
  FDesignForm.Zoom(False);
end;

procedure TFGuiDesigner.MIZoomInClick(Sender: TObject);
begin
  FDesignForm.Zoom(True);
end;

procedure TFGuiDesigner.ELDesignerControlInserted(Sender: TObject);
var
  Control: TControl;
begin
  Control := FELDesigner.SelectedControls[0];
  Control.Tag := GComponentNrToInsert;
  Control.HelpType := htContext;
  (Control as TBaseWidget).Resize;
  Control.Hint := Control.Name;
  Control.ShowHint := True;
  FObjectInspector.RefreshCBObjects;
  FObjectInspector.SetSelectedObject(Control);
  FComponentToInsert := nil;
  FObjectGenerator.InsertComponent(GetEditForm, Control, False);
  UpdateState(Modified);
end;

procedure TFGuiDesigner.Save(const Filename: string; Formular: TFGuiForm);
var
  BinStream: TMemoryStream;
  FilStream: TFileStream;
begin
  BinStream := TMemoryStream.Create;
  try
    try
      FilStream := TFileStream.Create(Filename, fmCreate or fmShareExclusive);
      try
        BinStream.WriteComponent(Formular);
        BinStream.Seek(0, soFromBeginning);
        ObjectBinaryToText(BinStream, FilStream);
      finally
        FreeAndNil(FilStream);
      end;
    except
      on E: Exception do
        ErrorMsg(Format(_(SFileSaveError), [Filename, E.Message]));
    end;
  finally
    FreeAndNil(BinStream);
  end;
  if Assigned(FELDesigner.DesignControl) then
    TFGuiForm(FELDesigner.DesignControl).Modified := False;
end;

procedure TFGuiDesigner.RemovePixelsPerInch0(const Filename: string);
begin
  var
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(Filename);
    for var I := 0 to StringList.Count - 1 do
    begin
      var
      Str := StringList[I];
      var
      Posi := Pos('PixelsPerInch', Str);
      if Posi > 0 then
      begin
        Posi := Pos('=', Str);
        Delete(Str, 1, Posi);
        Posi := StrToInt(Trim(Str));
        if Posi = 0 then
        begin
          StringList.Delete(I);
          var WriteProtected:= IsWriteProtected(FileName);
          if WriteProtected then
            RemoveReadOnlyAttribute(FileName);
          try
            StringList.SaveToFile(FileName);
            if WriteProtected then
              SetReadOnlyAttribute(FileName);
          except
            ErrorMsg(Format(_('File %s contains invalid "PixelsPerInch = 0", ' +
                    'but cannot delete due to write protection.'), [FileName]));
          end;
          Break;
        end;
      end
      else if Pos('  object', Str) > 0 then
        Break;
    end;
  finally
    FreeAndNil(StringList);
  end;
end;

function TFGuiDesigner.GetPixelsPerInchOfFile(const Filename: string): Integer;
begin
  Result := 96;
  var
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(Filename);
    for var I := 0 to StringList.Count - 1 do
    begin
      var
      Str := StringList[I];
      var
      Posi := Pos('PixelsPerInch', Str);
      if Posi > 0 then
      begin
        Posi := Pos('=', Str);
        Delete(Str, 1, Posi);
        Exit(StrToInt(Trim(Str)));
      end
      else if Pos('  object', Str) > 0 then
        Break;
    end;
  finally
    FreeAndNil(StringList);
  end;
end;

function TFGuiDesigner.Open(const Filename: string): TFGuiForm;
var
  FilStream: TFileStream;
  BinStream: TMemoryStream;
  Reader: TReader;
  PythonFilename: string;
  AForm: TEditorForm;
  PPI: Integer;
  NewName: string;

  function GetName: string;
  var
    StringList: TStringList;
    Index, Num: Integer;
    Str: string;
  begin
    Result:= '';
    StringList := TStringList.Create;
    try
      StringList.Sorted := True;
      for var I := 0 to Screen.FormCount - 1 do
        if StartsWith(Screen.Forms[I].Name, 'FGUIForm') then
          StringList.Add(Screen.Forms[I].Name);
      if not StringList.Find('FGUIForm', Index) then
        Exit('FGUIForm');
      Num := 1;
      repeat
        Str := 'FGUIForm_' + IntToStr(Num);
        if not StringList.Find(Str, Index) then
          Exit(Str);
        Inc(Num);
      until False;
    finally
      FreeAndNil(StringList);
    end;
  end;

begin
  Result := nil;
  if not FileExists(Filename) then
    Exit;
  PPI := GetPixelsPerInchOfFile(Filename);
  if PPI = 0 then
  begin
    RemovePixelsPerInch0(Filename);
    PPI := 96;
  end;
  PythonFilename := ChangeFileExt(Filename, '.pyw');
  AForm := GI_EditorFactory.GetEditorByName(PythonFilename).Form as TEditorForm;
  FObjectGenerator.Partner := AForm;
  BinStream := TMemoryStream.Create;
  FilStream := TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  Reader := TReader.Create(BinStream, 4096);
  Reader.OnFindMethod := FindMethod;
  Reader.OnError := ErrorMethod;
  try
    try
      NewName := GetName;
      ObjectTextToResource(FilStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      BinStream.ReadResHeader;
      FDesignForm := TFGuiForm.Create(Self);
      FDesignForm.Partner := AForm;
      Reader.ReadRootComponent(FDesignForm);
      FDesignForm.Open(Filename, AForm.GetGeometry, AForm);
      FDesignForm.Name := NewName;
      if FDesignForm.Monitor.PixelsPerInch > PPI then
        FDesignForm.Scale(FDesignForm.Monitor.PixelsPerInch, PPI);
      ScaleImages;
      FDesignForm.Invalidate; // to paint correct image sizes
      FDesignForm.EnsureOnDesktop;
      ChangeTo(FDesignForm);
      if not AForm.ActiveSynEdit.Modified and not FDesignForm.Modified then
        FDesignForm.Partner.Modified := False;
      Result := FDesignForm;
    except
      on E: Exception do
        ErrorMsg(Format(_(SFileOpenError), [Filename, E.Message]));
    end;
  finally
    FreeAndNil(Reader);
    FreeAndNil(FilStream);
    FreeAndNil(BinStream);
    FObjectInspector.RefreshCBObjects;
  end;
  if Assigned(FDesignForm) and FDesignForm.ReadOnly then
    FELDesigner.LockAll([lmNoMove, lmNoResize, lmNoDelete, lmNoInsertIn,
      lmNoCopy]);
end;

procedure TFGuiDesigner.FindMethod(Reader: TReader; const Methodname: string;
  var Address: Pointer; var Error: Boolean);
begin
  Address := nil;
  Error := False;
end;

procedure TFGuiDesigner.ErrorMethod(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  Handled := (Pos('ShowName', Message) + Pos('Number', Message) > 0);
  Handled := True; // read form anyway
end;

procedure TFGuiDesigner.MICloseClick(Sender: TObject);
begin
  TForm(FELDesigner.DesignControl).Close;
end;

procedure TFGuiDesigner.MIConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('GUI designer');
end;

procedure TFGuiDesigner.ELDesignerDesignFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  if Assigned(FELDesigner.DesignControl) then
    TForm(FELDesigner.DesignControl).Close;
end;

procedure TFGuiDesigner.ELDesignerControlDeleting(Sender: TObject;
  SelectedControls: TELDesignerSelectedControls);
var
  Int: Integer;
begin
  FObjectGenerator.Partner := GetEditForm;
  FObjectGenerator.Partner.ActiveSynEdit.BeginUpdate;
  Int := SelectedControls.Count - 1;
  while Int > -1 do
  begin
    FObjectGenerator.DeleteComponent(SelectedControls[Int]);
    Dec(Int);
  end;
  FObjectInspector.SetSelectedObject(nil);
  UpdateState(Modified);
  FObjectGenerator.Partner.ActiveSynEdit.EndUpdate;
end;

procedure TFGuiDesigner.MIToSourceClick(Sender: TObject);
begin
  TFGuiForm(FELDesigner.DesignControl).Partner.BringToFront;
  ELDesignerDblClick(Self);
end;

procedure TFGuiDesigner.MISnapToGridClick(Sender: TObject);
begin
  FELDesigner.SelectedControls.AlignToGrid;
  UpdateState(Modified);
  MISnapToGrid.Checked := not MISnapToGrid.Checked;
  FELDesigner.SnapToGrid := MISnapToGrid.Checked;
end;

procedure TFGuiDesigner.ELDesignerDblClick(Sender: TObject);
var
  Destination: string;
begin
  if FELDesigner.SelectedControls.Count = 1 then
  begin
    if FELDesigner.SelectedControls[0].Tag in [4, 34] then
      Destination := 'def ' + FELDesigner.SelectedControls[0].Name + '_Command'
    else if FELDesigner.SelectedControls[0].Tag in [74, 103, 104] then
      Destination := 'def ' + FELDesigner.SelectedControls[0].Name + '_clicked'
    else
      Destination := FELDesigner.SelectedControls[0].Name;
    GetEditForm.GoTo2(Destination);
    GUIDesignerTimer.Enabled := True;
  end;
  UpdateState(not Modified);
end;

procedure TFGuiDesigner.GUIDesignerTimerTimer(Sender: TObject);
begin
  GUIDesignerTimer.Enabled := False;
  var
  EditForm := GetEditForm;
  if Assigned(EditForm) then
  begin
    EditForm.BringToFront;
    EditForm.Enter(Self);
    if EditForm.CanFocus then
      EditForm.SetFocus;
  end;
end;

procedure TFGuiDesigner.CutClick(Sender: TObject);
begin
  if ELDesigner.Active then begin
    FELDesigner.Cut;
    UpdateState(Modified);
  end;
end;

procedure TFGuiDesigner.CopyClick(Sender: TObject);
begin
  if ELDesigner.Active then begin
    FELDesigner.Copy;
    UpdateState(not Modified);
  end;
end;

procedure TFGuiDesigner.PasteClick(Sender: TObject);
var
  PasteInContainer: Boolean;
  Container, Control: TControl;
  WinControl: TWinControl;
  EditForm: TEditorForm;
begin
  if not ELDesigner.Active or not FELDesigner.CanPaste then
    Exit;

  // copy&paste ensures correct model, but source code must be generated
  PasteInContainer := (FELDesigner.SelectedControls.Count > 0);
  if PasteInContainer then
    Container := FELDesigner.SelectedControls[0]
  else
    Container := nil;
  FELDesigner.Paste;
  EditForm := GetEditForm;
  EditForm.ActiveSynEdit.BeginUpdate;
  // handle the pasted widgets
  for var I := 0 to FELDesigner.SelectedControls.Count - 1 do
  begin
    Control := FELDesigner.SelectedControls[I];
    if PasteInContainer then
    begin
      if Control.Left + Control.Width > Container.Width then
        Control.Left := Container.Width - Control.Width;
      if Control.Top + Control.Height > Container.Height then
        Control.Top := Container.Height - Control.Height;
    end;
    FObjectInspector.SetSelectedObject(Control);
    GComponentNrToInsert := FELDesigner.SelectedControls[I].Tag;
    FObjectGenerator.InsertComponent(EditForm, Control, True);
    FObjectGenerator.SetComponentValues(FDesignForm, Control);
    WinControl := TWinControl(Control);
    for var J := 0 to WinControl.ControlCount - 1 do
    begin
      FObjectInspector.SetSelectedObject(WinControl.Controls[J]);
      GComponentNrToInsert := WinControl.Controls[J].Tag;
      FObjectGenerator.InsertComponent(EditForm, WinControl.Controls[J], True);
      FObjectGenerator.SetComponentValues(FDesignForm, WinControl.Controls[J]);
    end;
  end;
  FObjectGenerator.SetControlEvents(FDesignForm, EditForm);
  EditForm.ActiveSynEdit.EndUpdate;
  FObjectInspector.RefreshCBObjects;
  UpdateState(Modified);
end;

procedure TFGuiDesigner.ELDesignerGetUniqueName(Sender: TObject;
  const ABaseName: string; var AUniqueName: string);
var
  Int: Integer;
  Str, Basename: string;
begin
  Basename := LowerUpper(ABaseName);
  Str := UUtils.Right(Basename, -1);
  while (Pos(Str, '0123456789') > 0) and (Length(Basename) > 2) do
  begin
    Basename := UUtils.Left(Basename, Length(Basename) - 1);
    Str := UUtils.Right(Basename, -1);
  end;
  Int := 1;
  repeat
    AUniqueName := Basename + IntToStr(Int);
    Inc(Int);
  until FELDesigner.IsUniqueName(AUniqueName);
end;

function TFGuiDesigner.GetEditForm: TEditorForm;
begin
  if Assigned(FELDesigner) and Assigned(FELDesigner.DesignControl) then
    Result := TFGuiForm(FELDesigner.DesignControl).Partner
  else
    Result := nil;
end;

function TFGuiDesigner.GetPath: string;
begin
  if Assigned(TFGuiForm(FELDesigner.DesignControl)) then
    Result := ExtractFilePath(TFGuiForm(FELDesigner.DesignControl).Pathname)
  else
    Result := '';
end;

procedure TFGuiDesigner.SetEnabledMI(MenuItem: TSpTBXItem; Enabled: Boolean);
begin
  if Assigned(MenuItem) and (MenuItem.Enabled <> Enabled) then
    MenuItem.Enabled := Enabled;
end;

procedure TFGuiDesigner.ScaleImages;
begin
  vilPythonControls.SetSize(FDesignForm.PPIScale(16), FDesignForm.PPIScale(16));
  vilQtControls1616.SetSize(FDesignForm.PPIScale(15), FDesignForm.PPIScale(15));
end;

procedure TFGuiDesigner.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
    PopupMenu.Images := vilGUIDesignerDark
  else
    PopupMenu.Images := vilGuiDesignerLight;
end;

{ TMyDragObject }

function TMyDragObject.GetDragImages: TDragImageList;
begin
  Result := FDragImages;
end;

constructor TMyDragObject.Create(AControl: TControl);
var
  Bitmap: TBitmap;
begin
  inherited Create(AControl);
  FDragImages := TDragImageList.Create(AControl);
  AlwaysShowDragImages := True;

  Bitmap := TBitmap.Create;
  Bitmap.Width := AControl.Width;
  Bitmap.Height := AControl.Height;
  if AControl is TWinControl then
    (AControl as TWinControl).PaintTo(Bitmap.Canvas, 0, 0);
  FDragImages.Width := Bitmap.Width;
  FDragImages.Height := Bitmap.Height;
  FDragImages.Add(Bitmap, nil);
  FDragImages.DragHotspot := Point(Bitmap.Width, Bitmap.Height);
  FreeAndNil(Bitmap);
end;

destructor TMyDragObject.Destroy;
begin
  FreeAndNil(FDragImages);
  inherited Destroy;
end;

initialization

RegisterClasses(ClassArray);

end.
