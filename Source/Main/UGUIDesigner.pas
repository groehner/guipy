unit UGUIDesigner;

interface

uses
  Windows, Classes, Controls, Forms, ExtCtrls, ImgList, ActnList,
  System.ImageList, Vcl.Menus,
  dlgPyIDEBase, ELDsgnr, UGUIForm, frmEditor, SpTBXItem, TB2Item,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, SVGIconImageCollection;

type
  TFGUIDesigner = class (TPyIDEDlgBase)
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
    procedure ELDesignerGetUniqueName(Sender: TObject;
      const ABaseName: String; var AUniqueName: String);
    procedure ELDragDrop(Sender, ASource, ATarget: TObject; AX, AY: Integer);
    procedure ELDragOver(Sender, ASource, ATarget: TObject; AX, AY: Integer;
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
  private
    procedure SetEnabledMI(MenuItem: TSpTBXItem; Enabled: boolean);
    function GetPixelsPerInchOfFile(Filename: string): integer;
    procedure RemovePixelsPerInch0(Filename: string);
  public
    ComponentToInsert: TControlClass;
    ELDesigner: TELDesigner;
    DesignForm: TFGuiForm;
    procedure Save(const Filename: string; Formular: TFGUIForm);
    function Open(const Filename: string): TFGUIForm;
    procedure FindMethod(Reader: TReader; const MethodName: string;
                         var Address: Pointer; var Error: Boolean);
    procedure ErrorMethod(Reader: TReader; const Message: string; var Handled: Boolean);
    function Tag2Class(Tag: integer): TControlClass;
    procedure SetToolButton(Tag: Integer);
    procedure ChangeTo(Formular: TFGUIForm);
    function GetEditForm: TEditorForm;
    procedure UpdateState(Modified: boolean);
    function getPath: string;
    function getControlWidthHeigth: TPoint;
    procedure ScaleImages;
    procedure ChangeStyle;
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
  FGUIDesigner: TFGUIDesigner = nil;

implementation

uses System.Types, TypInfo, SysUtils, Graphics,
     UObjectInspector, UObjectGenerator, UConfiguration, UUtils, ULink,
     UBaseWidgets, UTKButtonBase, UTKTextBase, UTKMiscBase,
     UTTKButtonBase, UTTKTextBase, UTTKMiscBase,
     UQtButtonBase, UQtWidgetDescendants, UQtFrameBased, UQtScrollable,
     UQtItemViews, UQtSpinboxes,
     uCommonFunctions, uEditAppIntfs;

{$R *.dfm}

type
  TClassArray = array [1..81] of TPersistentClass;

const
  Modified = true;

  ClassArray: TClassArray = (
    TFGUIForm,
    TKLabel, TKEntry, TKText, TKButton, TKCheckbutton, TKRadiobuttonGroup,
    TKListbox, TKSpinbox, TKMessage, TKCanvas, TKScrollbar, TKFrame, TKLabelframe,
    TKScale, TKPanedWindow, TKOptionMenu, TKMenu, TKPopupMenu, TKMenubutton,

    TTKLabel, TTKEntry, TTKButton, TTKCheckbutton, TTKRadiobuttonGroup, TTKCombobox,
    TTKSpinbox, TTKFrame, TTKLabelframe, TTKScale, TTKLabeledScale, TTKPanedwindow, TTKScrollbar,
    TTKMenubutton, TTKOptionMenu, TTKNotebook, TTKTreeview, TTKProgressbar, TTKSeparator, TTKSizegrip,

    TQtLabel, TQtLineEdit, TQtPlainTextEdit, TQtPushButton, TQtCheckBox,
    TQtButtonGroup, TQtListWidget, TQtComboBox, TQtSpinBox, TQtScrollBar,
    TQtCanvas, TQtFrame, TQtGroupBox, TQtSlider, TQtMenuBar, TQtMenu,
    TQtTabWidget, TQtTreeWidget, TQtTableWidget, TQtProgressBar, TQtStatusBar,

    TQtTextEdit, TQtTextBrowser, TQtToolButton, TQtCommandLinkButton,
    TQtFontComboBox, TQtDoubleSpinBox, TQtLCDNumber, TQtDateTimeEdit,
    TQtDateEdit, TQtTimeEdit, TQtDial, TQtLine, TQtScrollArea, TQtToolBox,
    TQtStackedWidget, TQtListView, TQtColumnView, TQtTreeView,
    TQtTableView, TQtGraphicsView
  );

procedure TFGUIDesigner.FormCreate(Sender: TObject);
begin
  inherited;
  ELDesigner:= TELDesigner.Create(Self);
  ELDesigner.PopupMenu:= PopupMenu;
  with ELDesigner do begin
    ShowingHints:= [htControl, htSize, htMove, htInsert];
    ClipboardFormat:= 'Extension Library designer components';
    OnModified:= ELDesignerModified;
    OnGetUniqueName:= ELDesignerGetUniqueName;
    OnControlInserting:= ELDesignerControlInserting;
    OnDragDrop:= ELDragDrop;
    OnDragOver:= ELDragOver;
    OnControlInserted:= ELDesignerControlInserted;
    OnControlDeleting:= ELDesignerControlDeleting;
    OnChangeSelection:= ELDesignerChangeSelection;
    OnDesignFormClose:= ELDesignerDesignFormClose;
    OnDblClick       := ELDesignerDblClick;
  end;
  ELDesigner.GuiDesignerHints:= GuiPyOptions.GuiDesignerHints;
  ChangeStyle;
end;

procedure TFGUIDesigner.ChangeTo(Formular: TFGUIForm);
begin
  if Assigned(ELDesigner) then begin
    if (ELDesigner.DesignControl <> Formular) or not ELDesigner.Active then begin
      ELDesigner.Active:= false;
      ELDesigner.DesignControl:= Formular;
      DesignForm:= Formular;
      if Assigned(Formular) then
        ELDesigner.Active:= true;
      if FObjectInspector.Visible then
        FObjectInspector.RefreshCBObjects;
    end;
  end;
end;

procedure TFGUIDesigner.ELDesignerChangeSelection(Sender: TObject);
begin
  FObjectInspector.ChangeSelection(ELDesigner.SelectedControls);
  UpdateState(not Modified);
end;

procedure TFGUIDesigner.ELDesignerModified(Sender: TObject);
  var i: integer; aControl: TControl;
begin
  FObjectInspector.ELPropertyInspector.Modified;
  for i:= 0 to ELDesigner.SelectedControls.Count - 1 do begin
    aControl:= ELDesigner.SelectedControls.Items[i];
    FObjectGenerator.MoveOrSizeComponent(GetEditForm, aControl);
    if aControl is TBaseWidget then
      (aControl as TBaseWidget).Resize;
  end;
  UpdateState(Modified);
end;

procedure TFGUIDesigner.UpdateState(Modified: boolean);
begin
  if Modified and Assigned(ELDesigner.DesignControl) then
    TFGUIForm(ELDesigner.DesignControl).Modified:= true;
end;

procedure TFGUIDesigner.PopupMenuPopup(Sender: TObject);
  var en: boolean;
begin
  SetEnabledMI(MICut, ELDesigner.CanCut);
  SetEnabledMI(MICopy, ELDesigner.CanCopy);
  SetEnabledMI(MIPaste, ELDesigner.CanPaste);
  SetEnabledMI(MIAlign, ELDesigner.SelectedControls.Count > 1);
  MISnapToGrid.Checked:= ELDesigner.SnapToGrid;
  en:= (ELDesigner.SelectedControls.Count > 0) and
       (ELDesigner.SelectedControls[0].ClassName <> 'TFGUIForm');
  SetEnabledMI(MIDelete, en);
  en:= assigned(DesignForm.Partner);
  SetEnabledMI(MIForeground, en);
  SetEnabledMI(MIBackground, en);
end;

procedure TFGUIDesigner.MIDeleteClick(Sender: TObject);
begin
  if not DesignForm.ReadOnly then begin
    ELDesigner.DeleteSelectedControls;
    UpdateState(Modified);
  end;
end;

procedure TFGUIDesigner.MIForegroundClick(Sender: TObject);
begin
  for var i:= 0 to ELDesigner.SelectedControls.Count - 1 do
    FObjectGenerator.ComponentToForeground(GetEditForm, ELDesigner.SelectedControls.Items[i]);
end;

procedure TFGUIDesigner.MIBackgroundClick(Sender: TObject);
begin
  for var i:= 0 to ELDesigner.SelectedControls.Count - 1 do
    FObjectGenerator.ComponentToBackground(GetEditForm, ELDesigner.SelectedControls.Items[i]);
end;

procedure TFGUIDesigner.MIAlignClick(Sender: TObject);
  var AHorzAlign, AVertAlign: TELDesignerAlignType;
      Tag: integer;
begin
  Tag:= (Sender as TSpTBXItem).Tag;
  AHorzAlign:= atNoChanges;
  AVertAlign:= atNoChanges;
  case Tag of
    1: AHorzAlign:= atLeftTop;
    2: AHorzAlign:= atCenter;
    3: AHorzAlign:= atRightBottom;
    4: AHorzAlign:= atCenterInWindow;
    5: AHorzAlign:= atSpaceEqually;
    6: AVertAlign:= atLeftTop;
    7: AVertAlign:= atCenter;
    8: AVertAlign:= atRightBottom;
    9: AVertAlign:= atCenterInWindow;
   10: AVertAlign:= atSpaceEqually;
  end;
  ELDesigner.SelectedControls.Align(AHorzAlign, AVertAlign);
end;

procedure TFGUIDesigner.ELDesignerControlInserting(Sender: TObject;
  var AControlClass: TControlClass);
begin
  if not DesignForm.ReadOnly then
    AControlClass:= ComponentToInsert;
end;

procedure TFGUIDesigner.ELDragDrop(Sender, ASource, ATarget: TObject; AX, AY: Integer);
  var accept: boolean;
      LInsertingControl: TControl;
      LName: string;
begin
  Accept:= csAcceptsControls in (ATarget as TControl).ControlStyle;
  if Accept and assigned(ComponentToInsert) then begin
    LInsertingControl:= ComponentToInsert.Create(Designform);
    try
      ELDesigner.getUniqueName(Tag2PythonType(LInsertingControl.Tag), LName);
      LInsertingControl.Name:= LName; // <-- here may be an exception
      LInsertingControl.Parent:= ATarget as TWinControl;
      LInsertingControl.SetBounds(AX-LInsertingControl.Width, AY-LInsertingControl.Height,
                                     LInsertingControl.Width, LInsertingControl.Height);
      //(LInsertingControl as TBaseWidget).UnScaleFontSize;
      ELDesigner.SelectedControls.ClearExcept(LInsertingControl);
      ELDesignerControlInserted(nil);
      UpdateState(Modified);
    except
      FreeAndNil(LInsertingControl);
      raise;
    end;
  end;
end;

procedure TFGUIDesigner.ELDragOver (Sender, ASource, ATarget: TObject; AX, AY: Integer;
      AState: TDragState; var Accept: Boolean);
begin
  Accept:= csAcceptsControls in (ATarget as TControl).ControlStyle;
end;

function TFGuiDesigner.Tag2Class(Tag: integer): TControlClass;
begin
  case Tag of
     1: Result:= TKLabel;
     2: Result:= TKEntry;
     3: Result:= TKText;
     4: Result:= TKButton;
     5: Result:= TKCheckbutton;
     7: Result:= TKRadiobuttonGroup;
     8: Result:= TKListbox;
     9: Result:= TKSpinbox;
    10: Result:= TKMessage;
    11: Result:= TKCanvas;
    12: Result:= TKScrollbar;
    13: Result:= TKFrame;
    14: Result:= TKLabelFrame;
    15: Result:= TKScale;
    16: Result:= TKPanedWindow;
    17: Result:= TKMenubutton;
    18: Result:= TKOptionMenu;
    19: Result:= TKMenu;
    20: Result:= TKPopupMenu;

    31: Result:= TTKLabel;
    32: Result:= TTKEntry;
    34: Result:= TTKButton;
    35: Result:= TTKCheckbutton;
    37: Result:= TTKRadiobuttongroup;
    38: Result:= TTKCombobox;
    39: Result:= TTKSpinbox;
    42: Result:= TTKScrollbar;
    43: Result:= TTKFrame;
    44: Result:= TTKLabelFrame;
    45: Result:= TTKScale;
    46: Result:= TTKLabeledScale;
    47: Result:= TTKPanedwindow;
    48: Result:= TTKMenuButton;
    49: Result:= TTKOptionMenu;
    50: Result:= TTKNotebook;
    51: Result:= TTKTreeview;
    52: Result:= TTKProgressbar;
    53: Result:= TTKSeparator;
    54: Result:= TTKSizegrip;
    // Qt Base
    71: Result:= TQtLabel;
    72: Result:= TQtLineEdit;
    73: Result:= TQtPlainTextEdit;
    74: Result:= TQtPushButton;
    75: Result:= TQtCheckBox;
    76: Result:= TQtButtonGroup;
    77: Result:= TQtListWidget;
    78: Result:= TQtComboBox;
    79: Result:= TQtSpinBox;
    80: Result:= TQtScrollBar;
    81: Result:= TQtCanvas;
    82: Result:= TQtFrame;
    83: Result:= TQtGroupBox;
    84: Result:= TQtSlider;
    85: Result:= TQtMenuBar;
    86: Result:= TQtMenu;
    87: Result:= TQtTabWidget;
    88: Result:= TQtTreeWidget;
    89: Result:= TQtTableWidget;
    90: Result:= TQtProgressBar;
    91: Result:= TQtStatusBar;

    // Qt Controls
   101: Result:= TQtTextEdit;
   102: Result:= TQtTextBrowser;
   103: Result:= TQtToolButton;
   104: Result:= TQtCommandLinkButton;
   105: Result:= TQtFontComboBox;
   106: Result:= TQtDoubleSpinBox;
   107: Result:= TQtLCDNumber;
   108: Result:= TQtDateTimeEdit;
   109: Result:= TQtDateEdit;
   110: Result:= TQtTimeEdit;
   111: Result:= TQtDial;
   112: Result:= TQtLine;
   113: Result:= TQtScrollArea;
   114: Result:= TQtToolBox;
   115: Result:= TQtStackedWidget;
   116: Result:= TQtListView;
   117: Result:= TQtColumnView;
   118: Result:= TQtTreeView;
   119: Result:= TQtTableView;
   120: Result:= TQtGraphicsView;
   else Result:= nil;
  end;
end;

procedure TFGUIDesigner.SetToolButton(Tag: Integer);
begin
  ComponentToInsert:= nil;
  var EditorForm:= GetEditForm;
  if assigned(EditorForm) then begin
    ULink.ComponentNrToInsert:= Tag;
    ComponentToInsert:= Tag2Class(Tag);
    ScaleImages;
  end;
end;

procedure TFGUIDesigner.MIZoomOutClick(Sender: TObject);
begin
  DesignForm.Zoom(false);
end;

procedure TFGUIDesigner.MIZoomInClick(Sender: TObject);
begin
  DesignForm.Zoom(true);
end;

procedure TFGUIDesigner.ELDesignerControlInserted(Sender: TObject);
  var Control: TControl;
begin
  Control:= ELDesigner.SelectedControls[0];
  Control.Tag:= ComponentNrToInsert;
  Control.HelpType:= htContext;
  (Control as TBaseWidget).Resize;
  Control.Hint:= Control.Name;
  Control.ShowHint:= true;
  FObjectInspector.RefreshCBObjects;
  FObjectInspector.SetSelectedObject(Control);
  ComponentToInsert:= nil;
  FObjectGenerator.InsertComponent(GetEditForm, Control, false);
  UpdateState(Modified);
end;

procedure TFGUIDesigner.Save(const Filename: string; Formular: TFGUIForm);
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
      on e: exception do
        ErrorMsg(e.Message);
    end;
  finally
    FreeAndNil(BinStream)
  end;
  if Assigned(ELDesigner.DesignControl) then
    TFGUIForm(ELDesigner.DesignControl).Modified:= false;
end;

procedure TFGUIDesigner.RemovePixelsPerInch0(Filename: string);
begin
  var SL:= TStringList.Create;
  try
    SL.LoadFromFile(Filename);
    for var i:= 0 to SL.Count -1 do begin
      var s:= SL[i];
      var p:= Pos('PixelsPerInch', s);
      if p > 0 then begin
        p:= Pos('=', s);
        delete(s, 1, p);
        p:= StrToInt(trim(s));
        if p = 0 then begin
          SL.Delete(i);
          SL.SaveToFile(Filename);
          break;
        end
      end else if Pos('  object', s) > 0 then
        break;
    end;
  finally
    FreeAndNil(SL);
  end;
end;

function TFGUIDesigner.GetPixelsPerInchOfFile(Filename: string): integer;
begin
  Result:= 96;
  var SL:= TStringList.Create;
  try
    SL.LoadFromFile(Filename);
    for var i:= 0 to SL.Count -1 do begin
      var s:= SL[i];
      var p:= Pos('PixelsPerInch', s);
      if p > 0 then begin
        p:= Pos('=', s);
        delete(s, 1, p);
        Exit(StrToInt(trim(s)));
      end else if Pos('  object', s) > 0 then
        break;
    end;
  finally
    FreeAndNil(SL);
  end;
end;

function TFGUIDesigner.Open(const Filename: string): TFGUIForm;
var
   FilStream: TFileStream;
   BinStream: TMemoryStream;
   Reader   : TReader;
   PythonFilename: string;
   aForm: TEditorForm;
   PPI: Integer;
begin
  Result:= nil;
  if not FileExists(Filename) then
    Exit;
  PPI:= GetPixelsPerInchOfFile(Filename);
  if PPI = 0 then begin
    RemovePixelsPerInch0(Filename);
    PPI:= 96;
  end;
  PythonFilename:= ChangeFileExt(Filename, '.pyw');
  aForm:= TEditorForm(GI_EditorFactory.GetEditorByName(PythonFilename).Form);
  FObjectGenerator.Partner:= aForm;
  BinStream:= TMemoryStream.Create;
  FilStream:= TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  Reader:= TReader.Create(BinStream, 4096);
  Reader.OnFindMethod:= FindMethod;
  Reader.OnError:= ErrorMethod;
  try
    try
      ObjectTextToResource(FilStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      BinStream.ReadResHeader;
      DesignForm:= TFGuiForm.Create(self);
      DesignForm.Partner:= aForm;
      DesignForm.Name:= ''; // don't change to name_1
      Reader.ReadRootComponent(DesignForm);
      DesignForm.Open(Filename, '', aForm.getGeometry, aForm);
      if DesignForm.PixelsPerInch > PPI then
        DesignForm.Scale(DesignForm.PixelsPerInch, PPI);
      ScaleImages;
      DesignForm.Invalidate; // to paint correct image sizes
      DesignForm.EnsureOnDesktop;
      ChangeTo(DesignForm);
      if not aForm.ActiveSynEdit.Modified and not DesignForm.Modified then
        TEditorForm(DesignForm.Partner).Modified:= false;
      Result:= DesignForm;
    except
      on e: exception do
        ErrorMsg(E.Message);
    end;
  finally
    FreeAndNil(Reader);
    FreeAndNil(FilStream);
    FreeAndNil(BinStream);
    FObjectInspector.RefreshCBObjects;
  end;
  if assigned(DesignForm) and DesignForm.ReadOnly then
     ELDesigner.LockAll([lmNoMove, lmNoResize, lmNoDelete, lmNoInsertIn, lmNoCopy]);
end;

procedure TFGUIDesigner.FindMethod(Reader: TReader; const MethodName: string;
    var Address: Pointer; var Error: Boolean);
begin
  Address:= nil;
  Error:= False;
end;

procedure TFGuiDesigner.ErrorMethod(Reader: TReader; const Message: string; var Handled: Boolean);
begin
  Handled:= (Pos('ShowName', Message) + Pos('Number', Message) > 0);
  Handled:= true; // read form anyway
end;

procedure TFGUIDesigner.MICloseClick(Sender: TObject);
begin
  TForm(ELDesigner.DesignControl).Close;
end;

procedure TFGUIDesigner.ELDesignerDesignFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
  if Assigned(ELDesigner.DesignControl)
    then TForm(ELDesigner.DesignControl).Close;
end;

procedure TFGUIDesigner.ELDesignerControlDeleting(Sender: TObject;
  SelectedControls: TELDesignerSelectedControls);
  var i: integer;
begin
  FObjectGenerator.Partner:= GetEditForm;
  FObjectGenerator.Partner.ActiveSynEdit.BeginUpdate;
  i:= SelectedControls.Count - 1;
  while i > -1 do begin
    FObjectGenerator.DeleteComponent(SelectedControls.Items[i]);
    dec(i);
  end;
  FObjectInspector.SetSelectedObject(nil);
  UpdateState(Modified);
  FObjectGenerator.Partner.ActiveSynEdit.EndUpdate;
end;

procedure TFGUIDesigner.MIToSourceClick(Sender: TObject);
begin
  TFGUIForm(ELDesigner.DesignControl).Partner.BringToFront;
  ELDesignerDblClick(Self);
end;

procedure TFGUIDesigner.MISnapToGridClick(Sender: TObject);
begin
  ELDesigner.SelectedControls.AlignToGrid;
  UpdateState(Modified);
  MISnapToGrid.Checked:= not MISnapToGrid.Checked;
  ELDesigner.SnapToGrid:= MISnapToGrid.Checked;
end;

procedure TFGUIDesigner.ELDesignerDblClick(Sender: TObject);
  var s: string;
begin
  if ELDesigner.SelectedControls.Count = 1 then begin
    if ELDesigner.SelectedControls[0].Tag in [4, 34] then
      s:= 'def ' + ELDesigner.SelectedControls[0].Name + '_Command'
    else if ELDesigner.SelectedControls[0].Tag in [74, 103, 104] then
      s:= 'def ' + ELDesigner.SelectedControls[0].Name + '_clicked'
    else
      s:= ELDesigner.SelectedControls[0].Name;
    GetEditForm.GoTo2(s);
    GUIDesignerTimer.Enabled:= true;
  end;
  UpdateState(not Modified);
end;

procedure TFGUIDesigner.GUIDesignerTimerTimer(Sender: TObject);
begin
  GUIDesignerTimer.Enabled:= false;
  var EditForm:= GetEditForm;
  if assigned(EditForm) then begin
    EditForm.BringToFront;
    EditForm.Enter(Self);
    if EditForm.CanFocus then
      EditForm.SetFocus;
  end;
end;

procedure TFGUIDesigner.CutClick(Sender: TObject);
begin
  ELDesigner.Cut;
  UpdateState(Modified);
end;

procedure TFGUIDesigner.CopyClick(Sender: TObject);
begin
  ELDesigner.Copy;
  UpdateState(not Modified);
end;

procedure TFGUIDesigner.PasteClick(Sender: TObject);
  var i, j: integer;
      PasteInContainer: boolean;
      Container, Control: TControl;
      WinControl: TWinControl;
      EditForm: TEditorForm;
begin
  // copy&paste ensures correct model, but source code must be generated
  PasteInContainer:= (ELDesigner.SelectedControls.Count > 0);
  if PasteInContainer
    then Container:= ELDesigner.SelectedControls[0]
    else Container:= nil;
  ELDesigner.Paste;
  EditForm:= GetEditForm;
  EditForm.ActiveSynEdit.BeginUpdate;
  // handle the pasted widgets
  for i:= 0 to ELDesigner.SelectedControls.Count - 1 do begin
    Control:= ELDesigner.SelectedControls[i];
    if PasteInContainer then begin
      if Control.Left + Control.Width > Container.Width then
        Control.Left:= Container.Width - Control.Width;
      if Control.Top + Control.Height > Container.Height then
        Control.Top:= Container.Height - Control.Height;
    end;
    FObjectInspector.SetSelectedObject(Control);
    ComponentNrToInsert:= ELDesigner.SelectedControls.Items[i].Tag;
    FObjectGenerator.InsertComponent(EditForm, Control, true);
    FObjectGenerator.SetComponentValues(DesignForm, Control);
    WinControl:= TWinControl(Control);
    for j:= 0 to WinControl.ControlCount - 1 do begin
      FObjectInspector.SetSelectedObject(WinControl.Controls[j]);
      ComponentNrToInsert:= WinControl.Controls[j].Tag;
      FObjectGenerator.InsertComponent(EditForm, WinControl.Controls[j], true);
      FObjectGenerator.SetComponentValues(DesignForm, WinControl.Controls[j]);
    end;
  end;
  FObjectGenerator.setControlEvents(DesignForm, EditForm);
  EditForm.ActiveSynEdit.EndUpdate;
  FObjectInspector.RefreshCBObjects;
  UpdateState(Modified);
end;

procedure TFGUIDesigner.ELDesignerGetUniqueName(Sender: TObject;
           const ABaseName: String; var AUniqueName: String);
  var i: integer; s, b: string;
begin
  b:= LowerUpper(aBaseName);
  s:= UUtils.Right(b, -1);
  while (Pos(s, '0123456789') > 0) and (Length(b) > 2) do begin
    b:= UUtils.Left(b, Length(b) - 1);
    s:= UUtils.Right(b, -1);
  end;
  i:= 1;
  repeat
    aUniqueName:= b + IntToStr(i);
    inc(i);
  until ELDesigner.IsUniqueName(AUniqueName);
end;

function TFGuiDesigner.GetEditForm: TEditorForm;
begin
  if Assigned(ELDesigner) and Assigned(ELDesigner.DesignControl)
    then Result:= TEditorForm(TFGUIForm(ELDesigner.DesignControl).Partner)
    else Result:= nil;
end;

function TFGUIDesigner.getPath: string;
begin
  if assigned(TFGUIForm(ELDesigner.DesignControl))
    then Result:= ExtractFilepath(TFGuiForm(ELDesigner.DesignControl).Pathname)
    else Result:= '';
end;

function TFGUIDesigner.getControlWidthHeigth: TPoint;
  var aControl: TControl;
begin
  if assigned(ComponentToInsert) then begin
    aControl:= ComponentToInsert.Create(Designform);
    Result:= Point(aControl.Width, aControl.height);
    FreeAndNil(aControl);
  end else
    Result:= Point(100, 100);
end;

procedure TFGUIDesigner.SetEnabledMI(MenuItem: TSpTBXItem; Enabled: boolean);
begin
  if assigned(MenuItem) and (MenuItem.Enabled <> Enabled) then
    MenuItem.Enabled:= Enabled;
end;

procedure TFGUIDesigner.ScaleImages;
begin
  vilPythonControls.SetSize(DesignForm.PPIScale(16), DesignForm.PPIScale(16));
  vilQtControls1616.SetSize(DesignForm.PPIScale(15), DesignForm.PPIScale(15));
end;

procedure TFGUIDesigner.ChangeStyle;
begin
  if IsStyledWindowsColorDark
    then PopupMenu.Images:= vilGuiDesignerDark
    else PopupMenu.Images:= vilGuiDesignerLight;
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
