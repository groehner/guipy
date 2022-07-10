unit UGUIForm;

interface

uses SysUtils, Messages, Windows, Classes, Graphics, Forms, Controls,
  ComCtrls, Dialogs, Buttons, Grids, ExtCtrls, StdCtrls,
  uEditAppIntfs, frmFile, frmEditor, ELEvents, UBaseWidgets;

type

  TTheme = (alt, clam, default, classic, vista, winnative, xpnative);

  TFGUIForm = class (TForm, IEditCommands)
    procedure FormClose(Sender: TObject; var aAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
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

    function getBackground: TColor;
    procedure setBackground(aValue: TColor);
    procedure setTransparency(Value: real);
    function Without_(s: String): String;

  public
    ReadOnly: boolean;
    Pathname: String;
    Partner: TEditorForm;
    Modified: boolean;
    constructor Create(AOwner: TComponent); override;
    procedure InitEvents;
    procedure Open(Pathname, State: string; WidthHeight: TPoint);
    procedure EnterForm(Sender: TObject); //override;
    procedure Save(MitBackup: boolean);
    procedure SaveIn(const Dir: String);
    procedure Change(const NewFilename: string);
    function GetSaveAsName: string;
    procedure SaveAs(const Filename: string);
    procedure Print;
    procedure UpdateState;
    procedure SetFontSize(Delta: integer);
    procedure SetOptions;
    procedure DeleteGUIComponent(const aName: string);
    procedure EnsureOnDesktop;
    procedure setAttribute(Attr, Value, Typ: string);
    function getAttributes(ShowAttributes: integer): string;
    function getEvents(ShowEvents: integer): string;
    procedure setEvent(Event: string);
    function HandlerName(Event: string): string;
    procedure DeleteEventHandler(const Event: string);
    function MakeBinding(Eventname: string): string;
    function MakeHandler(Event: string ): string;
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
  end;

implementation

uses Clipbrd, Themes, jvDockControlForm, frmPyIDEMain, cPyScripterSettings,
     UGUIDesigner, UObjectGenerator, UObjectInspector, UUtils, UKoppel,
     UConfiguration, UXTheme;

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
end;

procedure TFGUIForm.InitEvents;
// initializing a new form
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

procedure TFGUIForm.Open(Pathname, State: string; WidthHeight: TPoint);
begin
  self.Pathname:= Pathname;
  setAnimation(false);
  ClientWidth:= WidthHeight.X;
  ClientHeight:= WidthHeight.Y;
  Name:= UUtils.GetUniqueName(PyIDEMainForm, ChangeFileext(ExtractFileName(Pathname), ''));
  Modified:= false;
  OnActivate:= EnterForm;
  //OnMouseActivate:= FormMouseActivate;
  PyIDEMainForm.ConnectGUIandPyWindow(Self);
  EnterForm(Self); // must stay!
  FGUIDesigner.ChangeTo(Self);
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

procedure TFGUIForm.SaveAs(const Filename: String);
  var n: string;
begin
  try
    n:= UUtils.GetUniqueName(Self, ChangeFileExt(ExtractFilename(Filename), ''));
    Self.Name:= n;
  except
    on e: exception do begin
      ErrorMsg(e.Message);
    end;
  end;
  FObjectInspector.RefreshCBObjects;
  Pathname:= Filename;
  ReadOnly:= false;
  Save(false);
end;

procedure TFGUIForm.SaveIn(const Dir: string);
begin
  SaveAs(Dir + ExtractFilename(Pathname));
end;

procedure TFGUIForm.Change(const NewFilename: string);
  var old: string;
begin
  old:= Pathname;
  SaveAs(NewFilename);
  DeleteFile(PCHar(old));
end;

function TFGUIForm.GetSaveAsName: String;
begin
  Result:= Pathname;
end;

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
  FObjectInspector.RefreshCBObjects;
  if (FGUIDesigner.ELDesigner.DesignControl <> Self) or not FGUIDesigner.ELDesigner.Active then
    FGUIDesigner.ChangeTo(Self);
  // show TKinter or TTK
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

procedure TFGUIForm.DeleteGUIComponent(const aName: string);
  var i: integer; Temp: TComponent;
begin
  for i:= ComponentCount - 1 downto 0 do begin
    Temp:= Components[I];
    if Temp.Name = aName then begin
      FreeAndNil(Temp);
      exit;
    end;
  end;
end;

procedure TFGUIForm.UpdateState;
begin
  FGuiDesigner.UpdateState(false);
end;

procedure TFGUIForm.setFontSize(Delta: integer);
begin
  FObjectGenerator.Partner:= TEditorForm(Partner);
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
  var s1, s2: string;
begin
  if Attr = 'Title' then begin
    s1:= 'self.root.title';
    s2:= Indent2 + s1 + '(' + asString(Value) + ')';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
    Caption:= Value;
  end else if Attr = 'Background' then begin
    s1:= 'self.root[''background'']';
    s2:=  Indent2 + s1 + ' = ' + asString(Value);
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
  end else if Attr = 'Resizable' then begin
    s1:= 'self.root.resizable';
    s2:=  Indent2 + s1 + '(' + Value + ', ' + Value + ')';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
  end else if Attr = 'Transparency' then begin
    s1:= 'self.root.attributes(''-alpha''';
    s2:=  Indent2 + s1 + ', ' + Value + ')';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0)
  end else if Attr = 'Fullscreen' then begin
    s1:= 'self.root.attributes(''-fullscreen''';
    s2:=  Indent2 + s1 + ', ' + Value + ')';
    if Value = 'True'
      then Partner.setAttributValue('self.create_widgets', s1, s2, 0)
      else Partner.DeleteAttribute(s1);
  end else if (Attr = 'MaxHeight') or (Attr = 'MaxWidth') then begin
    s1:= 'self.root.maxsize';
    s2:=  Indent2 + s1 + '(' + IntToStr(FMaxWidth) + ', ' + IntToStr(FMaxHeight) + ')';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
  end else if (Attr = 'MinHeight') or (Attr = 'MinWidth') then begin
    s1:= 'self.root.minsize';
    s2:=  Indent2 + s1 + '(' + IntToStr(FMinWidth) + ', ' + IntToStr(FMinHeight) + ')';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
  end else if Attr = 'Iconified' then begin
    s1:= 'self.root.iconify';
    s2:=  Indent2 + s1 + '()';
    if Value = 'True'
      then Partner.setAttributValue('self.create_widgets', s1, s2, 0)
      else Partner.DeleteAttribute(s1);
  end else if Attr = 'AlwaysOnTop' then begin
    s1:= 'self.root.attributes(''-topmost''';
    s2:=  Indent2 + s1 + ', 1)';
    if Value = 'True'
      then Partner.setAttributValue('self.create_widgets', s1, s2, 0)
      else Partner.DeleteAttribute(s1);
  end else if Attr = 'Theme' then begin
    s1:= 'self.theme';
    s2:= Indent2 + s1 + ' = ttk.Style()';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
    s1:= 'self.theme.theme_use';
    s2:= Indent2 + s1 + '(' + asString(Value) + ')';
    Partner.setAttributValue('self.create_widgets', s1, s2, 0);
  end;
end;

function TFGuiForm.getAttributes(ShowAttributes: integer): string;
  const Attributes1 = '|Transparency|Resizable|Title|Background|Width|Height';
        Attributes2 = Attributes1 + '|Fullscreen|AlwaysOnTop|Iconified';
        Attributes3 = Attributes2 + '|MaxHeight|MaxWidth|MinHeight|MinWidth|Theme';
begin
  case ShowAttributes of
    1: Result:= Attributes1 + '|';
    2: Result:= Attributes2 + '|';
  else Result:= Attributes3 + '|';
  end;
end;

function TFGuiForm.getEvents(ShowEvents: integer): string;
  const FormEvents = '|Destroy_|Expose|Visibility|';
begin
  Result:= MouseEvents1;
  if ShowEvents >= 2 then
    Result:= MouseEvents1 + MouseEvents2;
  if ShowEvents = 3 then
    Result:= AllEvents;
  Result:= Result + FormEvents;
end;

function TFGuiForm.Without_(s: String): String;
begin
  if s = 'Destroy_'
    then Result:= 'Destroy'
    else Result:= s;
end;

procedure TFGuiForm.setEvent(Event: string);
begin
  Event:= Without_(Event);
  if not Partner.hasText('def ' + Handlername(Event) + '(self, event):') then
    Partner.InsertProcedure(CrLf + MakeHandler(Event));
  Partner.InsertBinding('root', Event, MakeBinding(Event));
end;

function TFGuiForm.HandlerName(Event: string): string;
begin
  Result:= 'root_' + Without_(Event);
end;

function TFGuiForm.MakeBinding(Eventname: string): string;
  var Event: TEvent;
begin
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
end;

function TFGuiForm.MakeHandler(Event: string ): string;
begin
  //  Example:
  //  def name(self, event):
  //    // ToDo insert source code here
  //    pass
  Event:= without_(Event);
  Result:= Indent1 + 'def ' + HandlerName(Event) + '(self, event):' + CrLf +
           Indent2 + '# ToDo insert source code here' + CrLf +
           Indent2 + 'pass' + CrLf;
end;

procedure TFGuiForm.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  Partner.DeleteBinding(Name, Event);
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

end.

