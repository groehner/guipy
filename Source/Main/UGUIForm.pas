unit UGUIForm;

{ For a long time there was a very hard to find runtime error
  when closing CodeCompletion. The cause was that when the
  CodeCompletion window was closed, another window was activated,
  which was a GUIForm window if it was in a certain order. This
  opened the corresponding EditorForm window. That means when
  typing an empty character with the CodeCompletion window open
  in the source code of a class, it jumped to the source code
  of the GUIForm window.

  Workaround: Set FormStyle to fsStayOnTop
  This took me 2 days to solve
}
interface

uses Messages, Windows, Classes, Graphics, Forms,
     uEditAppIntfs, frmEditor, ELEvents, UBaseWidgets;

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
    procedure FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
      NewDPI: Integer);
    procedure FormBeforeMonitorDpiChanged(Sender: TObject; OldDPI,
      NewDPI: Integer);
  private
    // Tk
    FAlwaysOnTop: Boolean;
    FFullscreen: Boolean;
    FIconified: Boolean;
    FMaxHeight: Integer;
    FMaxWidth: Integer;
    FMinHeight: Integer;
    FMinWidth: Integer;
    FResizable: Boolean;
    FUndecorated: Boolean;
    FTheme: TTheme;
    FTransparency: real;
    FTitle: string;
    FFontSize: Integer;
    Indent1: string;
    Indent2: string;

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
    FAnimated: Boolean;
    FDockNestingEnabled: Boolean;
    FDocumentMode: Boolean;
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
    function Without_(s: string): string;
    procedure setWidgetPartners;
    procedure SetGridOptions;
    procedure getFontSize;
  public
    ReadOnly: Boolean;
    Pathname: string;
    Partner: TEditorForm;
    Modified: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure InitEvents;
    procedure Open(Pathname, State: string; WidthHeight: TPoint; Partner: TEditorForm);
    procedure EnterForm(Sender: TObject); //override;
    procedure Save(MitBackup: Boolean);
    procedure Print;
    procedure UpdateState;
    procedure EnsureOnDesktop;
    procedure setAttribute(Attr, Value, Typ: string);
    function getAttributes(ShowAttributes: Integer): string;
    function getEvents(ShowEvents: Integer): string;
    procedure setEvent(Event: string);
    function HandlerName(Event: string): string;
    function MakeHandler(event: string): string;
    procedure DeleteEventHandler(const Event: string);
    function MakeBinding(Eventname: string): string;
    // IEditCommands implementation
    function CanCopy: Boolean;
    function CanCut: Boolean;
    function IEditCommands.CanDelete = CanCut;
    function CanPaste: Boolean;
    function CanRedo: Boolean;
    function CanSelectAll: Boolean;
    function CanUndo: Boolean;
    procedure ExecCopy;
    procedure ExecCut;
    procedure ExecDelete;
    procedure ExecPaste;
    procedure ExecRedo;
    procedure ExecSelectAll;
    procedure ExecUndo;
    procedure EndOfResizeMoveDetected(var Msg: Tmessage); message WM_EXITSIZEMOVE;
    procedure Paint; override;
    procedure Zoom(_in: Boolean);
    procedure Scale(NewPPI, OldPPI: Integer);
  published
    property AlwaysOnTop: Boolean read FAlwaysOnTop write FAlwaysOnTop;
    property Background: TColor read getBackground write setBackground;
    property Fullscreen: Boolean read FFullscreen write FFullscreen;
    property Iconified: Boolean read FIconified write FIconified;
    property MaxHeight: Integer read FMaxHeight write FMaxHeight;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property MinHeight: Integer read FMinHeight write FMinHeight;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property Resizable: Boolean read FResizable write FResizable;
    property Title: string read FTitle write FTitle;
    property Theme: TTheme read FTheme write FTheme;
    property Transparency: real read FTransparency write setTransparency;
    property Undecorated: Boolean read FUndecorated write FUndecorated;
    property FontSize: Integer read FFontSize write FFontSize;
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
    property Animated: Boolean read FAnimated write FAnimated;
    property DockNestingEnabled: Boolean read FDockNestingEnabled write FDockNestingEnabled;
    property DocumentMode: Boolean read FDocumentMode write FDocumentMode;
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

uses Clipbrd, Themes, SysUtils, Controls, Math, System.Generics.Collections,
     frmFile, jvDockControlForm, frmPyIDEMain, cPyScripterSettings,
     UGUIDesigner, UObjectGenerator, UObjectInspector, UUtils,
     UConfiguration, UXTheme, UQtWidgetDescendants, UBaseTKWidgets,
     uCommonFunctions;

{$R *.DFM}

constructor TFGUIForm.Create(AOwner: TComponent);
begin
  inherited;
  FAlwaysOnTop:= False;
  FIconified:= False;
  FFullscreen:= False;
  FResizable:= True;
  FTransparency:= 1;
  FTheme:= vista;
  Indent1:= FConfiguration.Indent1;
  Indent2:= FConfiguration.Indent2;
  // don't theme this window
  SetWindowTheme(Handle, nil, nil);
  SetGridOptions;
  ParentFont:= False;
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
  Self.Pathname:= Pathname;
  Self.Partner:= Partner;
  {$WARNINGS OFF}
  if Partner.FrameType < 3
    then Widget:= TKMainWindow.Create(nil)
    else Widget:= TQtMainWindow.Create(nil);
  Widget.Partner:= Partner;
  {$WARNINGS ON}
  setAnimation(False);
  ClientWidth:= PPIScale(WidthHeight.X);
  ClientHeight:= PPIScale(WidthHeight.Y);
  Name:= UUtils.GetUniqueName(PyIDEMainForm, ChangeFileext(ExtractFileName(Pathname), ''));
  Modified:= False;
  SetWidgetPartners;
  OnActivate:= EnterForm;
  PyIDEMainForm.ConnectGUIandPyWindow(Self);
  EnterForm(Self); // must stay!
  SetAnimation(True);
  ReadOnly:= IsWriteProtected(Pathname);
  if FontSize = 0 then
    GetFontSize;
end;

procedure TFGUIForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FGUIDesigner.ELDesigner.Active:= False;
  FGUIDesigner.ELDesigner.DesignControl:= nil;
  FGUIDesigner.DesignForm:= nil;
  FObjectInspector.RefreshCBObjects;
  if PyIDEOptions.SaveFilesAutomatically then
    Save(PyIDEOptions.CreateBackupFiles);
  CanClose:= True;
end;

procedure TFGUIForm.FormClose(Sender: TObject; var aAction: TCloseAction);
begin
  if Assigned(Partner) then begin
    Partner.Partner:= nil;
    (Partner as TEditorForm).getEditor.GUIFormOpen:= False;
  end;
  for var i:= 1 to 4 do
    PyIDEMainForm.TabControlWidgets.Items[i].Visible:= FConfiguration.vistabs[i];
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
procedure TFGUIForm.Save(MitBackup: Boolean);
  var BackupName: string;
begin
  if ReadOnly then Exit;
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
  Modified:= False;
end;
{$WARNINGS ON}

procedure TFGUIForm.EnterForm(Sender: TObject);
begin
  if Assigned(Partner) and not Partner.ParentTabItem.Checked then
    // show connected partner
    TThread.ForceQueue(nil, procedure
      begin
        Partner.ParentTabItem.Checked:= True;
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
  //if PyIDEMainForm.TabControlWidgets.ActiveTabIndex = 0 then
  //  PyIDEMainForm.TabControlWidgets.ActiveTabIndex:= 1;
end;

procedure TFGUIForm.FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
  NewDPI: Integer);
begin
  FGUIDesigner.ScaleImages;
  Invalidate;
  SetGridOptions;
  OnResize:= FormResize;
end;

procedure TFGUIForm.FormBeforeMonitorDpiChanged(Sender: TObject; OldDPI,
  NewDPI: Integer);
begin
  OnResize:= nil;
end;

procedure TFGUIForm.SetGridOptions;
begin
  FGUIDesigner.ELDesigner.SnapToGrid:= GuiPyOptions.SnapToGrid;
  FGUIDesigner.ELDesigner.Grid.XStep:= PPIScale(GuiPyOptions.GridSize);
  FGUIDesigner.ELDesigner.Grid.YStep:= PPIScale(GuiPyOptions.GridSize);
end;

procedure TFGUIForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if FGUIDesigner.ELDesigner.Active then
    FGUIDesigner.ELDesigner.Active:= False;
end;

procedure TFGUIForm.FormResize(Sender: TObject);
begin
  FObjectInspector.ELPropertyInspector.Modified;
  if Assigned(Partner) and not ReadOnly then begin
    FObjectGenerator.Partner:= TEditorForm(Partner);
    FObjectGenerator.SetBoundsForFormular(Self);
  end;
  Modified:= True;
  UpdateState;
end;

procedure TFGUIForm.EndOfResizeMoveDetected(var Msg: Tmessage);
begin
  FGUIDesigner.ELDesigner.Active:= True;
end;

procedure TFGUIForm.Print;
begin
  inherited Print;
end;

procedure TFGUIForm.UpdateState;
begin
  FGuiDesigner.UpdateState(False);
end;

procedure TFGUIForm.EnsureOnDesktop;
  var l, t, w, h: Integer;
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

function TFGuiForm.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= Widget.GetAttributes(ShowAttributes);
end;

function TFGUIForm.getEvents(ShowEvents: Integer): string;
begin
  Result:= Widget.GetEvents(ShowEvents) + '|';
end;

function TFGuiForm.Without_(s: string): string;
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
    else Partner.InsertQtBinding(Indent2 + 'self.', MakeBinding(Event));
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
  var Binding:= MakeBinding(Event);
  if Partner.FrameType >= 3 then
    Binding:= Copy(Binding, 1, Pos('(', Binding));
  Partner.DeleteBinding(Binding)
end;

{--- IEditorCommands implementation -------------------------------------------}

function TFGuiForm.CanCopy: Boolean;
begin
  Result:= True;
end;

function TFGuiForm.CanCut: Boolean;
begin
  Result:= FGUIDesigner.ELDesigner.CanCut;
end;

function TFGuiForm.CanPaste: Boolean;
begin
  Result:= FGUIDesigner.ELDesigner.CanPaste;
end;

function TFGuiForm.CanRedo: Boolean;
begin
  Result:= False;
end;

function TFGuiForm.CanSelectAll: Boolean;
begin
  Result:= True;
end;

function TFGuiForm.CanUndo: Boolean;
begin
  Result:= False;
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

procedure TFGuiForm.Zoom(_in: Boolean);
begin
  for var i:= 0 to ComponentCount - 1 do
    if Components[i] is TBaseWidget then
      (Components[i] as TBaseWidget).Zoom(_in);
  if _in
    then FontSize:= FontSize + GuiPyOptions.ZoomSteps
    else FontSize:= Max(FontSize - GuiPyOptions.ZoomSteps, 6);
end;

type
  TControlClass = class(TControl);

procedure TFGuiForm.Scale(NewPPI, OldPPI: Integer);
begin
  if NewPPI = OldPPI then
    Exit;
  FIScaling := True;
  try
    ScaleScrollBars(NewPPI, OldPPI);
    ScaleConstraints(NewPPI, OldPPI);
    ClientWidth := MulDiv(ClientWidth, NewPPI, OldPPI);
    ClientHeight := MulDiv(ClientHeight, NewPPI, OldPPI);
    for var I := 0 to ComponentCount - 1 do
      if Components[I] is TControl then
        TControlClass(Components[I]).ChangeScale(NewPPI, OldPPI, True);
    if not ParentFont then
      Font.Height := MulDiv(Font.Height, NewPPI, OldPPI);
    Realign;
  finally
    FIScaling := False;
  end;
end;

procedure TFGuiForm.getFontSize;
  var CompFontSize, Value, Key, MaxFontCount, MaxFontKey: Integer;
      FontSizeDictionary: TDictionary<Integer, Integer>;
begin
  FontSizeDictionary := TDictionary<Integer, Integer>.Create(20);
  for var i:= 0 to ComponentCount - 1 do
    if Components[i] is TBaseWidget then begin
      CompFontSize:= (Components[i] as TBaseWidget).Font.Size;
      if FontSizeDictionary.TryGetValue(CompFontSize, Value) then
        FontSizeDictionary.AddOrSetValue(CompFontSize, Value +1)
      else
        FontSizeDictionary.AddOrSetValue(CompFontSize, 1);
    end;
  MaxFontCount:= 0;
  MaxFontKey:= 0;
  for Key in FontSizeDictionary.Keys do
    if FontSizeDictionary.Items[Key] > MaxFontCount then begin
      MaxFontCount:= FontSizeDictionary.Items[Key];
      MaxFontKey:= Key;
    end;
  if MaxFontKey > 0
    then FontSize:= MaxFontKey
    else FontSize:= GuiPyOptions.GUIFontSize;
  FontSizeDictionary.Free;
end;

end.

