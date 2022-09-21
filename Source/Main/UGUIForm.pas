unit UGUIForm;

interface

uses SysUtils, Messages, Windows, Classes, Graphics, Forms, Controls,
  ComCtrls, Dialogs, Buttons, Grids, ExtCtrls, StdCtrls,
  uEditAppIntfs, frmFile, frmEditor, ELEvents, UBaseWidgets;

type

  TTheme = (alt, clam, default, classic, vista, winnative, xpnative);

  TToolButtonStyle = (ToolButtonIconOnly, ToolButtonTextOnly,
                      ToolButtonTextBesideIcon, ToolButtonTextUnderIcon,
                      ToolButtonFollowStyle);

  TTabShape = (Rounded, Triangular);

  TFGUIForm = class (TForm, IEditCommands)
    procedure FormClose(Sender: TObject; var aAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    // Tk
    FAlwaysOnTop: boolean;
    FFullscreen: boolean;
    FIconified: boolean;
    FMaxHeight: integer;
    FMaxWidth: integer;
    FMinHeight: integer;
    FMinWidth: integer;
    FResizable: boolean;
    FUndecorated: boolean;
    FTheme: TTheme;
    FTransparency: real;
    FTitle: string;
    Indent1: String;
    Indent2: String;

    // events
    // Tk
    FActivate: TEvent;
    FButtonPress: TEvent;
    FButtonRelease: TEvent;
    FConfigure: TEvent;
    FDeactivate: TEvent;
    FDestroy: TEvent;
    FEnter: TEvent;
    FExpose: TEvent;
    FFocusIn: TEvent;
    FFocusOut: TEvent;
    FKeyPress: TEvent;
    FKeyRelease: TEvent;
    FLeave: TEvent;
    FMotion: TEvent;
    FMouseWheel: TEvent;
    FVisibility: TEvent;
    // Qt attributes
    FAnimated: boolean;
    FDockNestingEnabled: boolean;
    FDocumentMode: boolean;
    FTabShape: TTabShape;
    FToolButtonStyle: TToolButtonStyle;
    // Qt signals
    FCustomContextMenuRequested: string;
    FWindowIconChanged: string;
    FWindowTitleChanged: string;
    FIconSizeChanged: string;
    FTabifiedDockWidgetActivated: string;
    FToolButtonStyleChanged: string;

    Widget: TBaseWidget;
    function getBackground: TColor;
    procedure setBackground(aValue: TColor);
    procedure setTransparency(Value: real);
    function Without_(s: String): String;
    procedure setWidgetPartners;
  public
    ReadOnly: boolean;
    Pathname: String;
    Partner: TEditorForm;
    Modified: boolean;
    constructor Create(AOwner: TComponent); override;
    procedure InitEvents;
    procedure Open(Pathname, State: string; WidthHeight: TPoint; Partner: TEditorForm);
    procedure EnterForm(Sender: TObject); //override;
    procedure Save(MitBackup: boolean);
    procedure Print;
    procedure UpdateState;
    procedure SetOptions;
    procedure EnsureOnDesktop;
    procedure setAttribute(Attr, Value, Typ: string);
    function getAttributes(ShowAttributes: integer): string;
    function getEvents(ShowEvents: integer): string;
    procedure setEvent(Event: string);
    function HandlerName(Event: string): string;
    function MakeHandler(event: string): string;
    procedure DeleteEventHandler(const Event: string);
    function MakeBinding(Eventname: string): string;
    // IEditCommands implementation
    function CanCopy: boolean;
    function CanCut: boolean;
    function IEditCommands.CanDelete = CanCut;
    function CanPaste: boolean;
    function CanRedo: boolean;
    function CanSelectAll: boolean;
    function CanUndo: boolean;
    procedure ExecCopy;
    procedure ExecCut;
    procedure ExecDelete;
    procedure ExecPaste;
    procedure ExecRedo;
    procedure ExecSelectAll;
    procedure ExecUndo;
    procedure EndOfResizeMoveDetected(var Msg: Tmessage); message WM_EXITSIZEMOVE;
    procedure Paint; override;
    procedure Zoom(_in: boolean);
  published
    property AlwaysOnTop: boolean read FAlwaysOnTop write FAlwaysOnTop;
    property Background: TColor read getBackground write setBackground;
    property Fullscreen: boolean read FFullscreen write FFullscreen;
    property Iconified: boolean read FIconified write FIconified;
    property MaxHeight: integer read FMaxHeight write FMaxHeight;
    property MaxWidth: integer read FMaxWidth write FMaxWidth;
    property MinHeight: integer read FMinHeight write FMinHeight;
    property MinWidth: integer read FMinWidth write FMinWidth;
    property Resizable: boolean read FResizable write FResizable;
    property Title: string read FTitle write FTitle;
    property Theme: TTheme read FTheme write FTheme;
    property Transparency: real read FTransparency write setTransparency;
    property Undecorated: boolean read FUndecorated write FUndecorated;
    property Height;
    property Width;
    // events
    // Tk
    {$WARNINGS OFF}
    property Activate: TEvent read Factivate write Factivate;
    property ButtonPress: TEvent read FbuttonPress write FbuttonPress;
    property ButtonRelease: TEvent read FbuttonRelease write FbuttonRelease;
    property Configure: TEvent read Fconfigure write Fconfigure;
    property Deactivate: TEvent read Fdeactivate write Fdeactivate;
    property Destroy_: TEvent read FDestroy write FDestroy;
    property Enter: TEvent read FEnter write FEnter;
    property Expose: TEvent read FExpose write FExpose;
    property FocusIn: TEvent read FfocusIn write FfocusIn;
    property FocusOut: TEvent read FfocusOut write FfocusOut;
    property KeyPress: TEvent read fkeyPress write fkeyPress;
    property KeyRelease: TEvent read fkeyRelease write fkeyRelease;
    property Leave: TEvent read fleave write fleave;
    property Motion: TEvent read fMotion write fMotion;
    property MouseWheel: TEvent read fmouseWheel write fmouseWheel;
    property Visibility: TEvent read FVisibility write FVisibility;
    {$WARNINGS ON}
    // Qt
    // attributes
    property Animated: boolean read FAnimated write FAnimated;
    property DockNestingEnabled: boolean read FDockNestingEnabled write FDockNestingEnabled;
    property DocumentMode: boolean read FDocumentMode write FDocumentMode;
    property TabShape: TTabShape read FTabShape write FTabShape;
    property ToolButtonStyle: TToolButtonStyle read FToolButtonStyle write FToolButtonStyle;
    //  signals QWidget
    property customContextMenuRequested: string read FCustomContextMenuRequested write FCustomContextMenuRequested;
    property windowIconChanged: string read FWindowIconChanged write FWindowIconChanged;
    property windowTitleChanged: string read FWindowTitleChanged write FwindowTitleChanged;
    //  signals QMainWindow
    property iconSizeChanged: string read FIconSizeChanged write FIconSizeChanged;
    property tabifiedDockWidgetActivated: string read FTabifiedDockWidgetActivated write FTabifiedDockWidgetActivated;
    property toolButtonStyleChanged: string read FToolButtonStyleChanged write FToolButtonStyleChanged;
  end;

implementation

uses Clipbrd, Themes, jvDockControlForm, frmPyIDEMain, cPyScripterSettings,
     UGUIDesigner, UObjectGenerator, UObjectInspector, UUtils, UKoppel,
     UConfiguration, UXTheme, UQtWidgetDescendants, UBaseTKWidgets;

{$R *.DFM}

constructor TFGUIForm.Create(AOwner: TComponent);
begin
  inherited;
  FAlwaysOnTop:= false;
  FIconified:= false;
  FFullscreen:= false;
  FResizable:= true;
  FTransparency:= 1;
  FTheme:= vista;
  Indent1:= FConfiguration.Indent1;
  Indent2:= FConfiguration.Indent2;
  // don't theme this window
  SetWindowTheme(Handle, nil, nil);
  SetOptions;
end;

procedure TFGUIForm.InitEvents;
begin
  FButtonPress:= TEvent.Create(Self);
  FButtonRelease:= TEvent.Create(Self);
  FKeyPress:= TEvent.Create(Self);
  FKeyRelease:= TEvent.Create(Self);
  FActivate:= TEvent.Create(Self);
  FConfigure:= TEvent.Create(Self);
  FDeactivate:= TEvent.Create(Self);
  FDestroy:= TEvent.Create(Self);
  FEnter:= TEvent.Create(Self);
  FExpose:= TEvent.Create(Self);
  FFocusIn:= TEvent.Create(Self);
  FFocusOut:= TEvent.Create(Self);
  FLeave:= TEvent.Create(Self);
  FMouseWheel:= TEvent.Create(Self);
  FMotion:= TEvent.Create(Self);
  FVisibility:= TEvent.Create(Self);

  FButtonPress.Name:= 'ButtonPress';
  FButtonRelease.Name := 'ButtonRelease';
  FKeyPress.Name:= 'KeyPressName';
  FKeyRelease.Name:= 'KeyRelease';
  FActivate.Name:= 'Activate';
  FConfigure.Name:= 'Configure';
  FDeactivate.Name:= 'Deactivate';
  FDestroy.Name:= 'Destroy';
  FEnter.Name:= 'Enter';
  FExpose.Name:= 'Expose';
  FFocusIn.Name:= 'FocusIn';
  FFocusOut.Name:= 'FocusOut';
  FLeave.Name:= 'Leave';
  FMouseWheel.Name:= 'MouseWheel';
  FMotion.Name:= 'Motion';
  FVisibility.Name:= 'Visibility';
end;

procedure TFGUIForm.Open(Pathname, State: string; WidthHeight: TPoint; Partner: TEditorForm);
begin
  self.Pathname:= Pathname;
  self.Partner:= Partner;
  {$WARNINGS OFF}
  if Partner.FrameType < 3
    then Widget:= TKMainWindow.Create(nil)
    else Widget:= TQtMainWindow.Create(nil);
  Widget.Partner:= Partner;
  {$WARNINGS ON}
  setAnimation(false);
  ClientWidth:= WidthHeight.X;
  ClientHeight:= WidthHeight.Y;
  Name:= UUtils.GetUniqueName(PyIDEMainForm, ChangeFileext(ExtractFileName(Pathname), ''));
  Modified:= false;
  SetWidgetPartners;
  OnActivate:= EnterForm;
  PyIDEMainForm.ConnectGUIandPyWindow(Self);
  EnterForm(Self); // must stay!
  SetAnimation(true);
  ReadOnly:= IsWriteProtected(Pathname);
end;

procedure TFGUIForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FGUIDesigner.ELDesigner.Active:= false;
  FGUIDesigner.ELDesigner.DesignControl:= nil;
  FGUIDesigner.DesignForm:= nil;
  FObjectInspector.RefreshCBObjects;
  CanClose:= true;
end;

procedure TFGUIForm.FormClose(Sender: TObject; var aAction: TCloseAction);
begin
  if PyIDEOptions.SaveFilesAutomatically then
    Save(PyIDEOptions.CreateBackupFiles);
  if Assigned(Partner) then begin
    Partner.Partner:= nil;
    (Partner as TEditorForm).getEditor.GUIFormOpen:= false;
  end;
  for var i:= 1 to 4 do
    PyIDEMainForm.TabControlWidgets.Items[i].Visible:= true;
  aAction:= caFree;
end;

procedure TFGUIForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FActivate);
  FreeAndNil(FButtonPress);
  FreeAndNil(FButtonRelease);
  FreeAndNil(FConfigure);
  FreeAndNil(FDeactivate);
  FreeAndNil(FDestroy);
  FreeAndNil(FEnter);
  FreeAndNil(FExpose);
  FreeAndNil(FFocusIn);
  FreeAndNil(FFocusOut);
  FreeAndNil(FKeyPress);
  FreeAndNil(FKeyRelease);
  FreeAndNil(FLeave);
  FreeAndNil(FMotion);
  FreeAndNil(FMouseWheel);
  FreeAndNil(FVisibility);
  FreeAndNil(Widget);
end;

function TFGUIForm.getBackground: TColor;
begin
  Result:= Color;
end;

procedure TFGUIForm.setBackground(aValue: TColor);
begin
  Color:= aValue;
end;

procedure TFGUIForm.setTransparency(Value: real);
begin
  if (0 <= Value) and (Value <= 1) then
    FTransparency:= Value;
end;

{$WARNINGS OFF}
procedure TFGUIForm.Save(MitBackup: boolean);
  Var BackupName: String;
begin
  if ReadOnly then exit;
  if MitBackup then begin
    BackupName:= Pathname;
    BackupName:= ChangeFileExt(BackupName, '.~fm');
    if FileExists(BackupName) then
      SysUtils.DeleteFile(BackupName);
    if FileExists(Pathname) then
      RenameFile(Pathname, BackupName);
  end;
  FGUIDesigner.Save(Pathname, Self);
  //FMessages.StatusMessage(Pathname + ' ' + frmEditor.LNGSaved);
  Modified:= false;
end;
{$WARNINGS ON}

procedure TFGUIForm.EnterForm(Sender: TObject);
begin
  if assigned(Partner) and not Partner.ParentTabItem.Checked then
    // show connected partner
    TThread.ForceQueue(nil, procedure
      begin
        Partner.ParentTabItem.Checked:= true;
      end);
  if not FObjectInspector.Visible then
    TThread.ForceQueue(nil, procedure
      begin
        ShowDockForm(FObjectInspector);
      end);
  if (FGUIDesigner.ELDesigner.DesignControl <> Self) or not FGUIDesigner.ELDesigner.Active then
    FGUIDesigner.ChangeTo(Self);
  Partner.SynEditEnter(Partner.ActiveSynEdit);
  // show TKinter or TTK or Qt
  if PyIDEMainForm.TabControlWidgets.ActiveTabIndex = 0 then
    PyIDEMainForm.TabControlWidgets.ActiveTabIndex:= 1;
end;

procedure TFGUIForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if FGUIDesigner.ELDesigner.Active then
    FGUIDesigner.ELDesigner.Active:= false;
end;

procedure TFGUIForm.FormResize(Sender: TObject);
begin
  FObjectInspector.ELPropertyInspector.Modified;
  if Assigned(Partner) and not ReadOnly then begin
    FObjectGenerator.Partner:= TEditorForm(Partner);
    FObjectGenerator.SetBoundsForFormular(Self);
  end;
  Modified:= true;
  UpdateState;
end;

procedure TFGUIForm.EndOfResizeMoveDetected(var Msg: Tmessage);
begin
  FGUIDesigner.ELDesigner.Active:= true;
end;

procedure TFGUIForm.Print;
begin
  inherited Print;
end;

procedure TFGUIForm.UpdateState;
begin
  FGuiDesigner.UpdateState(false);
end;

procedure TFGUIForm.SetOptions;
begin
  FGuiDesigner.ELDesigner.SnapToGrid:= GuiPyOptions.SnapToGrid;
  FGuiDesigner.ELDesigner.Grid.XStep:= GuiPyOptions.GridSize;
  FGuiDesigner.ELDesigner.Grid.YStep:= GuiPyOptions.GridSize;
end;

procedure TFGUIForm.EnsureOnDesktop;
  var l, t, w, h: integer;
begin
  w:= width;
  h:= Height;
  l:= Left;
  if l < 0 then l:= 0;
  if l + w > Screen.DesktopWidth then
    l:= Screen.DesktopWidth - w;
  t:= Top;
  if t < 0 then t:= 0;
  if t + h > Screen.DesktopHeight then
    t:= Screen.DesktopHeight - h;
  SetBounds(l, t, w, h);
end;

procedure TFGUIForm.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'MaxHeight') or (Attr = 'MaxWidth') then
    Value:= IntToStr(FMaxWidth) + ', ' + IntToStr(FMaxHeight)
  else if (Attr = 'MinHeight') or (Attr = 'MinWidth') then
    Value:= IntToStr(FMinWidth) + ', ' + IntToStr(FMinHeight)
  else if Attr = 'Title' then
    Caption:= Value;
  Widget.setAttribute(Attr, Value, Typ);
end;

function TFGuiForm.getAttributes(ShowAttributes: integer): string;
begin
  Result:= Widget.GetAttributes(ShowAttributes);
end;

function TFGUIForm.getEvents(ShowEvents: integer): string;
begin
  Result:= Widget.GetEvents(ShowEvents) + '|';
end;

function TFGuiForm.Without_(s: String): String;
begin
  if s = 'Destroy_'
    then Result:= 'Destroy'
    else Result:= s;
end;

function TFGuiForm.MakeHandler(event: string): string;
begin
  Result:= Indent1 + 'def ' + Widget.HandlerNameAndParameter(Event) + CrLf +
           Indent2 + '# ToDo insert source code here' + CrLf +
           Indent2 + 'pass' + CrLf;
end;

procedure TFGuiForm.setEvent(Event: string);
begin
  Event:= Without_(Event);
  if not Partner.hasText('def ' + Widget.HandlerNameAndParameter(Event)) then
    Partner.InsertProcedure(CrLf + MakeHandler(Event));
  if Partner.FrameType < 3
    then Partner.InsertTkBinding('root', Event, MakeBinding(Event))
    else Partner.InsertQtBinding(Name, MakeBinding(Event));
end;

function TFGuiForm.HandlerName(Event: string): string;
begin
  if Partner.FrameType < 3
    then Result:= 'root_' + Without_(Event)
    else Result:= 'MainWindow_' + Event;
end;

function TFGuiForm.MakeBinding(Eventname: string): string;
  var Event: TEvent;
begin
  if Partner.FrameType < 3 then begin
    Eventname:= Without_(Eventname);
    if Eventname = 'ButtonPress' then
      Event:= FButtonPress
    else if Eventname = 'ButtonRelease' then
      Event:= FButtonRelease
    else if Eventname = 'KeyPress' then
      Event:= FKeyPress
    else if Eventname = 'KeyRelease' then
      Event:= FKeyRelease
    else if Eventname = 'Activate' then
      Event:= FActivate
    else if Eventname = 'Configure' then
      Event:= FConfigure
    else if Eventname = 'Deactivate' then
      Event:= FDeactivate
    else if Eventname = 'Enter' then
      Event:= FEnter
    else if Eventname = 'FocusIn' then
      Event:= FFocusIn
    else if Eventname = 'FocusOut' then
      Event:= FFocusOut
    else if Eventname = 'Leave' then
      Event:= FLeave
    else if Eventname = 'Motion' then
      Event:= FMotion
    else if Eventname = 'MouseWheel' then
      Event:= FMouseWheel
    else if Eventname = 'Destroy_' then
      Event:= FDestroy
    else if Eventname = 'Expose' then
      Event:= FExpose
    else
      Event:= FVisibility;
    Result:= Indent2 + 'self.root.bind(''<' + Event.getModifiers(Eventname) +
             Eventname + Event.getDetail(Eventname) + '>'', self.' + HandlerName(Eventname) + ')';
  end else
    Result:= Indent2 + 'self.' + Eventname + '.connect(self.' + HandlerName(Eventname) + ')';
end;

procedure TFGuiForm.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  Partner.DeleteBinding(MakeBinding(Event));
end;

{--- IEditorCommands implementation -------------------------------------------}

function TFGuiForm.CanCopy: boolean;
begin
  Result:= true;
end;

function TFGuiForm.CanCut: boolean;
begin
  Result:= FGUIDesigner.ELDesigner.CanCut;
end;

function TFGuiForm.CanPaste: boolean;
begin
  Result:= FGUIDesigner.ELDesigner.CanPaste;
end;

function TFGuiForm.CanRedo: boolean;
begin
  Result:= false;
end;

function TFGuiForm.CanSelectAll: boolean;
begin
  Result:= true;
end;

function TFGuiForm.CanUndo: boolean;
begin
  Result:= false;
end;

procedure TFGuiForm.ExecCopy;
  var BM: TBitmap;
begin
  if FGUIDesigner.ELDesigner.CanCopy then
    FGUIDesigner.CopyClick(Self)
  else begin
    BM:= GetFormImage();
    Clipboard.Assign(BM);
    FreeAndNil(BM);
  end;
end;

procedure TFGuiForm.ExecCut;
begin
  FGUIDesigner.CutClick(Self);
end;

procedure TFGuiForm.ExecDelete;
begin
  FGUIDesigner.MIDeleteClick(Self);
end;

procedure TFGuiForm.ExecPaste;
begin
  FGUIDesigner.PasteClick(Self);
end;

procedure TFGuiForm.ExecRedo;
begin
end;

procedure TFGuiForm.ExecSelectAll;
begin
  FGUIDesigner.ELDesigner.SelectedControls.SelectAll;
end;

procedure TFGuiForm.ExecUndo;
begin
end;

procedure TFGUIForm.Paint;
begin
  inherited;
  Canvas.FillRect(ClientRect);
end;

procedure TFGuiForm.setWidgetPartners;
begin
  for var i := 0 to ComponentCount - 1 do
    if Components[i] is TBaseWidget then
      (Components[i] as TBaseWidget).Partner:= Partner;
end;

procedure TFGuiForm.Zoom(_in: boolean);
begin
  for var i:= 0 to ComponentCount - 1 do
    if Components[i] is TBaseWidget then
      (Components[i] as TBaseWidget).Zoom(_in);
end;

end.

