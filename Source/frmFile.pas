unit frmFile;

interface

uses
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  SpTBXTabs,
  uEditAppIntfs;

type
  TFile = class;

  TFileForm = class(TForm)
    procedure FormCreate(Sender: TObject); virtual;
    procedure FormDestroy(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); virtual;
  private
    FDefaultExtension: string;
    FFileTime: TDateTime;
    FMyFile: TFile;
    FParentTabControl: TSpTBXCustomTabControl;
    FParentTabItem: TSpTBXTabItem;
    FReadOnly: Boolean;
    function GetPathname: string;
    procedure SetPathname(FileName: string);
  protected
    FModified: Boolean;
    procedure SetModified(Value: Boolean); virtual;
    function GetModified: Boolean; virtual;
    procedure DoActivate;
    procedure DoActivateFile(Primary: Boolean = True); virtual;
    function DoSaveFile: Boolean; virtual;
    function DoSaveAs: Boolean; virtual;
    function DoSaveAsRemote: Boolean; virtual;
    function SaveToFile(const FileName: string): Boolean;
    function LoadFromFile(const FileName: string): Boolean; virtual;
    function OpenFile(const FileName: string): Boolean; virtual;
    procedure Enter(Sender: TObject); virtual;
    function DoAskSaveChanges: Boolean; virtual;
    procedure Print; virtual;
    procedure SetFont(Font: TFont); virtual;
    procedure SetFontSize(Delta: Integer); virtual;
    procedure SelectFont(FileKind: TFileKind);
    function CanPaste: Boolean; virtual;
    function CanCopy: Boolean; virtual;
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    procedure DoAssignInterfacePointer(Active: Boolean);
    function GetState: string;
    procedure SetState(var State: string);
    function MyActiveControl: TWinControl;
    procedure WndProc(var Message: TMessage); override;
    procedure Retranslate; virtual;
    procedure DoOnIdle; virtual;
  public
    function GetFile: IFile;
    function DoSave: Boolean;
    procedure DoExport; virtual;
    function GetAsStringList: TStringList; virtual;
    procedure OpenWindow(Sender: TObject); virtual;
    procedure CollectClasses(StringList: TStringList); virtual;
    procedure DoUpdateCaption; virtual;
    procedure SetOptions; virtual;
    procedure DPIChanged; virtual;
    procedure SetActiveControl(Control: TWinControl);

    property DefaultExtension: string read FDefaultExtension write FDefaultExtension;
    property FileTime: TDateTime read FFileTime write FFileTime;
    property Modified: Boolean read GetModified write SetModified;
    property MyFile: TFile read FMyFile write FMyFile;
    property ParentTabControl: TSpTBXCustomTabControl read FParentTabControl write
        FParentTabControl;
    property ParentTabItem: TSpTBXTabItem read FParentTabItem write FParentTabItem;
    property Pathname: string read GetPathname write SetPathname;
    property ReadOnly: Boolean read FReadOnly;
  end;

  TFile = class(TInterfacedObject, IUnknown, IFile, IFileCommands)
  private
    FFileKind: TFileKind;
    FFileName: string;
    FRemoteFileName : string;
    FSSHServer : string;
    FForm: TFileForm;
    FFromTemplate: Boolean;
    // IFile implementation
    procedure Retranslate;
    function GetForm: TForm;
    function GetTabControlIndex: Integer;
    function GetRemoteFileName: string;
    function GetSSHServer: string;
    // IFileCommands implementation
    function CanPrint: Boolean;
    function CanSave: Boolean;
    function CanSaveAs: Boolean;
    function CanReload: Boolean;
    procedure ExecSaveAs;
    procedure ExecSaveAsRemote;
  protected
    FUntitledNumber: Integer;
    procedure Activate(Primary: Boolean = True); virtual;
    procedure Close; virtual;
    function GetFileTitle: string; virtual;
    function GetModified: Boolean; virtual;
    procedure SetModified(Value: Boolean); virtual;
    function CanClose: Boolean;
    function CanPaste: Boolean; virtual;
    function CanCopy: Boolean; virtual;
    procedure ExecClose;
    procedure ExecPaste; virtual;
    procedure ExecCopy; virtual;
    procedure ExecPrint; virtual;
    procedure ExecPrintPreview; virtual;
    procedure ExecReload(Quiet: Boolean = False); virtual;
    procedure OpenFile(const FileName: string);
    procedure Translate; virtual;
  public
    class var UntitledNumbers: TBits;
    constructor Create(FileKind: TFileKind; AForm: TFileForm); virtual;
    function GetFileKind: TFileKind;
    function GetFileName: string;
    function GetFileId: string;
    function GetFromTemplate: Boolean;
    procedure SetFromTemplate(Value: Boolean);
    procedure DoSetFilename(FileName: string); virtual;
    procedure OpenRemoteFile(const FileName, ServerName: string); virtual;
    function SaveToRemoteFile(const FileName, Servername: string) : Boolean; virtual;
    function AskSaveChanges: Boolean;
    function DefaultFilename: Boolean;
    procedure ExecSave;
    procedure ExecExport;
    procedure DoOnIdle; virtual;

    class function GetUntitledNumber: Integer;
    class constructor Create;
    class destructor Destroy;

    property FileName: string read FFileName write FFileName;
    property RemoteFileName: string read FRemoteFileName write FRemoteFileName;
    property SSHServer: string read FSSHServer write FSSHServer;
    property Form: TFileForm read FForm write FForm;
    property FromTemplate: Boolean read FFromTemplate write FFromTemplate;
  end;

  TFileFactory = class(TInterfacedObject, IFileFactory)
  private
    FFiles: TInterfaceList;
    // IFileFactory implementation
    function CanCloseAll: Boolean;
    procedure CloseAll;
    function GetFileByName(const Name: string): IFile;
    function GetFileByNameAndType(const Name: string; Kind: TFileKind): IFile;
    function GetFileByType(Kind: TFileKind): IFile;
    function GetFileByFileId(const Name : string): IFile;
  protected
    procedure LockList;
    procedure UnlockList;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateFile(FileKind: TFileKind; TabControlIndex: Integer = 1): IFile;
    function NewFile(FileKind: TFileKind; TabControlIndex: Integer = 1): IFile; overload;
    function GetFileCount: Integer;
    function GetFile(Index: Integer): IFile;
    procedure RemoveFile(AFile: IFile);
    procedure ApplyToFiles(const Proc: TProc<IFile>);
    function FirstFileCond(const Predicate: TPredicate<IFile>): IFile;
    property Files: TInterfaceList read FFiles write FFiles;
  end;

var FileFactory: TFileFactory = nil;

implementation

uses
  System.IOUtils,
  Winapi.Windows,
  UITypes,
  Types,
  Vcl.Dialogs,
  VirtualShellNotifier,
  JvGnugettext,
  JclFileUtils,
  SpTBXSkins,
  StringResources,
  cPyScripterSettings,
  uCommonFunctions,
  dlgPickList,
  dlgRemoteFile,
  dmResources,
  cSSHSupport,
  frmPyIDEMain,
  UUMLForm,
  USequenceForm,
  UStructogram,
  UTextDiff,
  UBrowser,
  UUtils,
  UConfiguration;

{$R *.dfm}

{ TFileForm }

procedure TFileForm.FormCreate(Sender: TObject);
begin
  FModified:= False;
  FMyFile:= nil;
  TranslateComponent(Self);
  SkinManager.AddSkinNotification(Self);
end;

procedure TFileForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SkinManager.RemoveSkinNotification(Self);
  DoAssignInterfacePointer(False);
end;

procedure TFileForm.FormDestroy(Sender: TObject);
begin
  // Unregister kernel notification
  ChangeNotifier.UnRegisterKernelChangeNotify(Self);
  if Assigned(FMyFile) and Assigned(GI_FileFactory) then begin
    FMyFile.FForm := nil;
    GI_FileFactory.RemoveFile(FMyFile);
    if GI_FileFactory.Count = 0 then
      PyIDEMainForm.UpdateCaption;
  end;
end;

function TFileForm.DoAskSaveChanges: Boolean;
begin
  // this is necessary to prevent second confirmation when closing tabs
  if FModified then
    if PyIDEOptions.SaveFilesAutomatically then begin
      Result:= DoSave;
      if not Result then begin
        var Str:= Format(_(SCloseWithoutSaving), [TPath.GetFileName(FMyFile.GetFileTitle)]);
        if StyledMessageDlg(Str, mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes) = mrYes then
          Result:= True;
      end;
    end else begin
      DoActivateFile;
      MessageBeep(MB_ICONQUESTION);
      var Str := Format(_(SAskSaveChanges), [TPath.GetFileName(FMyFile.GetFileTitle)]);
      case StyledMessageDlg(Str, mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes) of
        mrYes:
          Result := DoSave;
        mrNo:
          Result := True;
      else
        Result := False;
      end;
    end
  else
    Result := True;
end;

function TFileForm.DoSave: Boolean;
begin
  if (FMyFile.FFileName <> '') or (FMyFile.FRemoteFileName <> '') then
    Result := DoSaveFile
  else
    Result := DoSaveAs;
end;

procedure TFileForm.DoExport;
begin
end;

procedure TFileForm.DoActivate;
begin
  FParentTabItem.Checked := True;
end;

procedure TFileForm.DoUpdateCaption;
var
  TabCaption : string;
begin
  if FMyFile.FRemoteFileName <> '' then
    TabCaption := TPath.GetFileName(FMyFile.FRemoteFileName)
  else
    TabCaption := FMyFile.GetFileTitle;

  if Assigned(FParentTabItem) then
    with FParentTabItem do
    begin
      Caption := StringReplace(TabCaption, '&', '&&', [rfReplaceAll]);
      Hint := FMyFile.GetFileId;
    end;
  PyIDEMainForm.UpdateCaption;
end;

procedure TFileForm.SetOptions;
begin
end;

procedure TFileForm.DPIChanged;
begin
end;

function TFileForm.DoSaveAsRemote: Boolean;
var
  FileName, Server : string;
  AFile : IFile;
begin
  if ExecuteRemoteFileDialog(FileName, Server, rfdSave) then
  begin
    AFile := GI_FileFactory.GetFileByName(TSSHFileName.Format(Server, FileName));
    if Assigned(AFile) and (AFile <> Self.FMyFile as IFile) then
    begin
      Vcl.Dialogs.MessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    FMyFile.DoSetFilename('');
    FMyFile.FRemoteFileName := FileName;
    FMyFile.FSSHServer := Server;
    DoUpdateCaption; // Do it twice in case the following statement fails
    Result := DoSaveFile;
    DoUpdateCaption;
  end
  else
    Result := False;
end;

function TFileForm.OpenFile(const FileName: string): Boolean;
begin
  Result:= LoadFromFile(FileName);
  if Result then begin
    Self.Pathname:= FileName;
    Modified:= False;
    SetFocus;
    FReadOnly:= IsWriteProtected(FileName);
    PyIDEMainForm.ActiveTabControl := FParentTabControl;
  end else
    Close;
end;

procedure TFileForm.Retranslate;
begin
  RetranslateComponent(Self);
end;

procedure TFileForm.OpenWindow(Sender: TObject);
begin
  try
    LockFormUpdate(Self);
    try
      SetAnimation(False);
      Visible:= True;
      SetAnimation(True);
      BringToFront;
      Enter(Self);
    except
      on E: Exception do
        ErrorMsg('OpenWindow: ' + Pathname);
    end;
  finally
    UnlockFormUpdate(Self);
  end;
end;

procedure TFileForm.Enter(Sender: TObject);
begin
  DoUpdateCaption;
  PyIDEMainForm.ActiveTabControl := FParentTabControl;
end;

function TFileForm.GetAsStringList: TStringList;
begin
  Result:= nil;
end;

function TFileForm.GetFile: IFile;
begin
  Result := FMyFile;
end;

procedure TFileForm.DoActivateFile(Primary: Boolean = True);
begin
  DoAssignInterfacePointer(True);
  DoActivate;
end;

procedure TFileForm.SetModified(Value: Boolean);
begin
  if FModified <> Value then begin
    FModified:= Value;
    PyIDEMainForm.UpdateCaption;
    if Assigned(FParentTabItem) then
      FParentTabItem.Invalidate;
  end;
end;

function TFileForm.GetModified: Boolean;
begin
  Result:= FModified;
end;

procedure TFileForm.DoAssignInterfacePointer(Active: Boolean);
begin
  if Active then
  begin
    GI_ActiveFile := FMyFile;
    GI_FileCmds := FMyFile;
    //GI_SearchCmds := FMyFile;
  end
  else
  begin
    if GI_ActiveFile = IFile(FMyFile) then
      GI_ActiveFile := nil;
    if GI_FileCmds = IFileCommands(FMyFile) then
      GI_FileCmds := nil;
    //if GI_SearchCmds = ISearchCommands(FMyFile) then
      GI_SearchCmds := nil;
  end;
end;

function TFileForm.DoSaveAs: Boolean;
var
  NewName: string;
  AFile: IFile;
begin
  NewName := FMyFile.GetFileId;
  if (FMyFile.GetFileName = '') and (ExtractFileExt(NewName) = '') then
    NewName := NewName + '.' + FDefaultExtension;
  if IsHttp(NewName) and (Copy(LowerCase(ExtractFileExt(NewName)), 1, 4) <> '.htm') then
      NewName:= NewName + '.html';

  if ResourcesDataModule.GetSaveFileName(NewName, nil, '.' + FDefaultExtension) then
  begin
    AFile := GI_FileFactory.GetFileByName(NewName);
    if Assigned(AFile) and (AFile <> Self.FMyFile as IFile) then
    begin
      StyledMessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    FMyFile.DoSetFilename(NewName);
    DoUpdateCaption; // Do it twice in case the following statement fails
    Result := DoSaveFile;
    DoUpdateCaption;
  end
  else
    Result := False;
end;

function TFileForm.DoSaveFile: Boolean;
begin
  Result := False;
  if FMyFile.FFileName <> '' then begin
    Result := SaveToFile(FMyFile.FFileName);
    if Result then
      if not FileAge(FMyFile.FFileName, FFileTime) then
        FFileTime := 0;
  end else if FMyFile.FRemoteFileName <> '' then
     Result := FMyFile.SaveToRemoteFile(FMyFile.FRemoteFileName, FMyFile.FSSHServer);
  if Result then
    Modified := False;
end;

function TFileForm.SaveToFile(const FileName: string): Boolean;
  var StringList: TStringList;
begin
  StringList:= GetAsStringList;
  try
    try
      StringList.SaveToFile(FileName, TEncoding.UTF8);
      Result:= True;
    except
      on E: Exception do begin
        StyledMessageDlg(Format(_(SFileSaveError),
          [FileName, E.Message]), mtWarning, [mbOK], 0);
        Result:= False;
      end;
    end;
  finally
    FreeAndNil(StringList);
  end;
end;

function TFileForm.LoadFromFile(const FileName: string): Boolean;
begin
  Result:= False;
end;

procedure TFileForm.SelectFont(FileKind: TFileKind);
  var AFile: IFile;
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  if ResourcesDataModule.dlgFontDialog.Execute then begin
    Font:= ResourcesDataModule.dlgFontDialog.Font;
    for var I:= 0 to GI_FileFactory.Count - 1 do begin
      AFile:= GI_FileFactory[I];
      if Assigned(AFile) and (AFile.FileKind = FileKind) then
        TFileForm(AFile.Form).SetFont(Font);
    end;
  end;
end;

procedure TFileForm.SetFont(Font: TFont);
begin
  Font.Assign(Font);
end;

procedure TFileForm.SetFontSize(Delta: Integer);
begin
  Font.Size:= Font.Size + Delta;
  if Font.Size < 6 then Font.Size:= 6;
  SetFont(Font);
end;

function TFileForm.CanPaste: Boolean;
begin
  Result:= False;
end;

function TFileForm.CanCopy: Boolean;
begin
  Result:= False;
end;

procedure TFileForm.CopyToClipboard;
begin
end;

procedure TFileForm.PasteFromClipboard;
begin
end;

procedure TFileForm.WndProc(var Message: TMessage);
begin
  if Assigned(FMyFile) and (FMyFile.FFileKind <> fkEditor) then begin
    if Message.Msg = CM_ENTER then
      DoAssignInterfacePointer(True)
    else if Message.Msg = CM_EXIT then
      DoAssignInterfacePointer(False);
  end;
  inherited WndProc(Message);
end;

function TFileForm.GetState: string;
begin
  Result:= 'W' + IntToStr(Left) + ')' + IntToStr(Top) + ')' +
                 IntToStr(Width) + ')' + IntToStr(Height) + ')' +
                 WindowStateToStr(WindowState) + ')';
end;

procedure TFileForm.SetState(var State: string);
  var Posi: Integer;
begin
  if State = '' then Exit;
  if Copy(State, 1, 1) = 'W' then begin
    Posi:= Pos(')', State); Delete(State, 1, Posi);
    Posi:= Pos(')', State); Delete(State, 1, Posi);
    Posi:= Pos(')', State); Delete(State, 1, Posi);
    Posi:= Pos(')', State); Delete(State, 1, Posi);
    Posi:= Pos(')', State);
    WindowState:= StrToWindowState(Copy(State, 1, Posi-1));
  end;
end;

procedure TFileForm.SetActiveControl(Control: TWinControl);
begin
  if Assigned(Parent) and Parent.CanFocus then
    Application.MainForm.ActiveControl:= Control;
end;

function TFileForm.MyActiveControl: TWinControl;
// https://de.comp.lang.delphi.misc.narkive.com/AU1p5kiy/activecontrol-nil
begin
  Result:= Application.MainForm.ActiveControl;
end;

function TFileForm.GetPathname: string;
begin
  if Assigned(FMyFile)
    then Result:= FMyFile.GetFileName
    else Result:= '';
end;

procedure TFileForm.SetPathname(FileName: string);
begin
  if Assigned(FMyFile)
    then FMyFile.DoSetFilename(FileName);
end;

procedure TFileForm.CollectClasses(StringList: TStringList);
begin
end;

procedure TFileForm.Print;
begin
end;

procedure TFileForm.DoOnIdle;
begin
end;

{--- TFile --------------------------------------------------------------------}

constructor TFile.Create(FileKind: TFileKind; AForm: TFileForm);
begin
  inherited Create;
  FForm := AForm;
  FFileKind:= FileKind;
  FUntitledNumber := -1;
end;

procedure TFile.Activate(Primary: Boolean = True);
begin
  if Assigned(FForm) then
    FForm.DoActivateFile(Primary);
end;

function TFile.AskSaveChanges: Boolean;
begin
  if Assigned(FForm) then
    Result := FForm.DoAskSaveChanges
  else
    Result := True;
end;

procedure TFile.Close;
// Closes without asking
var
  TabSheet: TSpTBXTabSheet;
  TabControl: TSpTBXCustomTabControl;
begin
  if Assigned(FForm) then
  begin
    GI_PyIDEServices.MRUAddFile(Self);
    if FUntitledNumber <> -1 then
      UntitledNumbers[FUntitledNumber] := False;

    GI_FileFactory.RemoveFile(Self);
    if GI_FileFactory.Count = 0 then
      PyIDEMainForm.UpdateCaption;

    TabSheet := (FForm.Parent as TSpTBXTabSheet);
    TabControl := TabSheet.TabControl;
    TabControl.Toolbar.BeginUpdate;
    try
      (FForm.FParentTabControl as TSpTBXTabControl).zOrder.Remove(TabSheet.Item);
      FForm.Close;
      FForm:= nil;
      TabSheet.Free;
      if Assigned(TabControl) then begin
        TabControl.Toolbar.MakeVisible(TabControl.ActiveTab);
        var AFile:= GI_PyIDEServices.GetActiveFile;
        if Assigned(AFile) then
          AFile.Activate;
      end;
    finally
      TabControl.Toolbar.EndUpdate;
    end;
  end;
end;

procedure TFile.DoSetFilename(FileName: string);
begin
  if ((FileName <> '') or (FRemoteFileName <> '')) and (FUntitledNumber <> -1) then
  begin
    UntitledNumbers[FUntitledNumber] := False;
    FUntitledNumber := -1;
  end;

  if FileName <> FFileName then
  begin
    FFileName := FileName;
    if FileName <> '' then
    begin
      FRemoteFileName := '';
      FSSHServer := '';
    end;
    // Kernel change notification
    if (FFileName <> '') and FileExists(FFileName) then
    begin
      // Register Kernel Notification
      ChangeNotifier.RegisterKernelChangeNotify(FForm, [vkneFileName, vkneDirName,
        vkneLastWrite, vkneCreation]);

      ChangeNotifier.NotifyWatchFolder(FForm, TPath.GetDirectoryName(FFileName));
    end
    else
      ChangeNotifier.UnRegisterKernelChangeNotify(FForm);  // just in case it was registered
  end;
end;

function TFile.GetTabControlIndex: Integer;
begin
  Result := PyIDEMainForm.TabControlIndex(FForm.FParentTabControl);
end;

function TFile.GetFileName: string;
begin
  Result := FFileName;
end;

function TFile.GetFileTitle: string;
begin
  if FFileName <> '' then
  begin
    if PyIDEOptions.DisplayPackageNames and
      FileIsPythonPackage(FFileName)
    then
      Result := FileNameToModuleName(FFileName)
    else
      Result := ExtractFileName(FFileName);
  end
  else if FSSHServer <> '' then
    Result := TSSHFileName.Format(FSSHServer, FRemoteFileName)
  else
  begin
    if FUntitledNumber = -1 then
      FUntitledNumber := GetUntitledNumber;
    Result := _(SNonameFileTitle) + IntToStr(FUntitledNumber);
  end;
end;

function TFile.GetFileKind: TFileKind;
begin
  Result:= FFileKind;
end;

function TFile.GetFileId: string;
begin
  if FFileName <> '' then
    Result := FFileName
  else
    Result := GetFileTitle;
end;

function TFile.GetModified: Boolean;
begin
  if Assigned(FForm) then
    Result := FForm.Modified
  else
    Result := False;
end;

procedure TFile.SetModified(Value: Boolean);
begin
  FForm.Modified:= Value;
end;

function TFile.GetRemoteFileName: string;
begin
  Result := FRemoteFileName;
end;

function TFile.GetSSHServer: string;
begin
  Result := FSSHServer;
end;

function TFile.GetFromTemplate: Boolean;
begin
  Result:= FFromTemplate;
end;

procedure TFile.SetFromTemplate(Value: Boolean);
begin
  FFromTemplate:= Value;
end;

procedure TFile.Retranslate;
begin
  FForm.Retranslate;
end;

function TFile.GetForm: TForm;
begin
  Result := FForm;
end;

function TFile.DefaultFilename: Boolean;
 var Int, Posi: Integer; Str, Default: string;
begin
  Result:= False;
  if Assigned(FConfiguration) then
    if True {not FConfiguration.AcceptDefaultname }then begin
      Default:= UpperCase(_('File'));
      Str:= UpperCase(ExtractFileName(FFileName));
      if Copy(Str, 1, Length(Default)) = Default then begin
        Delete(Str, 1, Length(Default));
        Posi:= Pos('.', Str);
        Delete(Str, Posi,Length(Str));
        Result:= TryStrToInt(Str, Int);
        end
      else
        Result:= False;
    end;
end;

// IFileCommands implementation

function TFile.CanPrint: Boolean;
begin
  Result := True;
end;

procedure TFile.ExecPrint;
begin
  if Assigned(FForm) then
    with ResourcesDataModule do
    begin
      PrintDialog.PrintRange := prAllPages;
      if PrintDialog.Execute then
        FForm.Print;
    end;
end;

procedure TFile.ExecPrintPreview;
begin
end;

function TFile.CanCopy: Boolean;
begin
  Result := Assigned(FForm) and FForm.CanCopy;
end;

function TFile.CanPaste: Boolean;
begin
  Result := Assigned(FForm) and FForm.CanPaste;
end;

function TFile.CanSave: Boolean;
begin
  Result := Assigned(FForm) and (GetModified or ((FFileName = '') and (FRemoteFileName = '')));
end;

function TFile.CanSaveAs: Boolean;
begin
  Result := Assigned(FForm);
end;

function TFile.CanClose: Boolean;
begin
  Result := Assigned(FForm);
end;

procedure TFile.ExecCopy;
begin
  if Assigned(FForm) then
    FForm.CopyToClipboard;
end;

procedure TFile.ExecPaste;
begin
  if Assigned(FForm) then
    FForm.PasteFromClipboard;
end;

procedure TFile.ExecClose;
// Close only after asking
begin
  if AskSaveChanges then
    Close;
end;

procedure TFile.ExecExport;
begin
  FForm.DoExport;
end;

procedure TFile.ExecSave;
begin
  if Assigned(FForm) then
  begin
    if (FFileName <> '') or (FRemoteFileName <> '') then
      FForm.DoSave
    else
      FForm.DoSaveAs;
  end;
end;

procedure TFile.ExecSaveAs;
begin
  if Assigned(FForm) then
    FForm.DoSaveAs;
end;

procedure TFile.ExecSaveAsRemote;
begin
  if Assigned(FForm) then
    FForm.DoSaveAsRemote;
end;

function TFile.CanReload: Boolean;
begin
  Result := FFileName <> '';
end;

procedure TFile.OpenFile(const FileName: string);
begin
  DoSetFilename(FileName);
  if FileExists(FileName) or IsHttp(FileName) then
    FForm.OpenFile(FileName);
  if not FileAge(FileName, FForm.FFileTime) then
    FForm.FFileTime := 0;
  FForm.DoUpdateCaption;
end;

procedure TFile.OpenRemoteFile(const FileName, Servername: string);
var
  TempFilename : string;
  ErrorMsg : string;
begin
  if not Assigned(FForm) or (FileName = '') or (Servername = '') then Exit;
  DoSetFilename('');
  TempFilename := ChangeFileExt(FileGetTempName('PyScripter'), ExtractFileExt(FileName));
  if not GI_SSHServices.ScpDownload(Servername, FileName, TempFilename, ErrorMsg) then begin
    StyledMessageDlg(Format(_(SFileOpenError), [FileName, ErrorMsg]), mtError, [mbOK], 0);
    Abort;
  end else begin
    FForm.OpenFile(TempFilename);
    DeleteFile(PWideChar(TempFilename));
  end;
  FRemoteFileName := FileName;
  FSSHServer := Servername;
  FForm.DoUpdateCaption;
end;

function TFile.SaveToRemoteFile(const FileName, Servername: string): Boolean;
  var ErrorMsg : string;
begin
  Result:= False;
  if not Assigned(FForm)  or (FileName = '') or (Servername = '') then Exit;    // ToDo was Abort

  var TempFilename := FileGetTempName('PyScripter');
  var StringList:= FForm.GetAsStringList;
  Result := SaveWideStringsToFile(TempFilename, StringList, False);
  if Result then begin
    Result := GI_SSHServices.ScpUpload(Servername, TempFilename, FileName, ErrorMsg);
    DeleteFile(PWideChar(TempFilename));
    if not Result then
      Vcl.Dialogs.MessageDlg(Format(_(SFileSaveError), [FileName, ErrorMsg]), mtError, [mbOK], 0);
  end;
  FreeAndNil(StringList);
end;

procedure TFile.ExecReload(Quiet: Boolean = False);
begin
  if Quiet or not GetModified or (Vcl.Dialogs.MessageDlg(_(SFileReloadingWarning),
      mtWarning, [mbYes, mbNo], 0) = mrYes) then
    OpenFile(GetFileName);
end;

procedure TFile.Translate;
begin
end;

procedure TFile.DoOnIdle;
begin
  FForm.DoOnIdle;
end;

class function TFile.GetUntitledNumber: Integer;
begin
  Result := UntitledNumbers.OpenBit;
  UntitledNumbers[Result] := True;
end;

class constructor TFile.Create;
begin
  UntitledNumbers := TBits.Create;
  UntitledNumbers[0] := True;  // do not use 0
end;

class destructor TFile.Destroy;
begin
  UntitledNumbers.Free;
end;

{--- TFileFactory -------------------------------------------------------------}

constructor TFileFactory.Create;
begin
  inherited Create;
  FFiles := TInterfaceList.Create;
end;

destructor TFileFactory.Destroy;
begin
  FreeAndNil(FFiles);
  inherited;
end;

function TFileFactory.CreateFile(FileKind: TFileKind; TabControlIndex: Integer = 1): IFile;
begin
  if (FileKind = fkEditor) and Assigned(GI_EditorFactory) then
    Result:= GI_EditorFactory.NewEditor(TabControlIndex)
  else if (FileKind <> fkEditor) and Assigned(GI_FileFactory) then
    Result := GI_FileFactory.NewFile(FileKind, TabControlIndex)
  else
    Result := nil;
end;

function TFileFactory.CanCloseAll: Boolean;
begin
  Result := False;
  with TPickListDialog.Create(Application.MainForm) do
  begin
    Caption := _(SSaveModifiedFiles);
    lbMessage.Caption := _(SSelectModifiedFiles);
    ApplyToFiles(procedure(AFile: IFile)
    begin
      if AFile.Modified then
        CheckListBox.Items.AddObject(AFile.FileId, AFile.Form);
    end);
    SetScrollWidth;
    mnSelectAllClick(nil);
    if CheckListBox.Items.Count = 0 then
      Result := True
    else if CheckListBox.Items.Count = 1 then
      Result := TFileForm(CheckListBox.Items.Objects[0]).DoAskSaveChanges
    else if ShowModal = idOK then
    begin
      Result := True;
      for var I := CheckListBox.Count - 1 downto 0 do
      begin
        if CheckListBox.Checked[I] then
        begin
          if not TFileForm(CheckListBox.Items.Objects[I]).DoSave then
          begin
            Result := False;
            Break;
          end;
        end;
      end;
    end;
    Free;
  end;
end;

procedure TFileFactory.CloseAll;
var
  Count: Integer;
begin
  FFiles.Lock;
  try
    Count := FFiles.Count - 1;
    while Count >= 0 do
    begin
      IFile(FFiles[Count]).Close;
      Dec(Count);
    end;
  finally
    FFiles.Unlock;
  end;
end;

function TFileFactory.NewFile(FileKind: TFileKind; TabControlIndex: Integer = 1): IFile;
var
  Sheet: TSpTBXTabSheet;
  LForm: TFileForm;
  TabItem: TSpTBXTabItem;
begin
  var TabControl := PyIDEMainForm.TabControl(TabControlIndex);
  TabItem := TabControl.Add('');
  Sheet := TabControl.GetPage(TabItem);
  try
    LForm:= nil;
    case FileKind of
      fkUML            : LForm:= TFUMLForm.Create(Sheet);
      fkStructogram    : LForm:= TFStructogram.Create(Sheet);
      fkSequencediagram: LForm:= TFSequenceForm.Create(Sheet);
      fkTextdiff       : LForm:= TFTextDiff.Create(Sheet);
      fkBrowser        : LForm:= TFBrowser.Create(Sheet);
    end;
    with LForm do begin
      FMyFile:= TFile.Create(FileKind, LForm);
      FParentTabItem := TabItem;
      FParentTabControl := TabControl;
      FParentTabItem.OnTabClosing := PyIDEMainForm.TabControlTabClosing;
      FParentTabItem.OnDrawTabCloseButton := PyIDEMainForm.DrawCloseButton;
      Result := FMyFile;
      BorderStyle := bsNone;
      Parent := Sheet;
      Align := alClient;
      DPIChanged;
    end;
    if Assigned(Result) then
      FFiles.Add(Result);
  except
    Sheet.Free;
  end;
end;

function TFileFactory.GetFileByName(const Name: string): IFile;
var
  Fullname: string;
begin
  Result := nil;
  Fullname := GetLongFileName(ExpandFileName(Name));
  for var I := 0 to FFiles.Count - 1 do
    if AnsiSameText(IFile(FFiles[I]).GetFileName, Fullname) then
    begin
      Result := IFile(FFiles[I]);
      Break;
    end;
end;

function TFileFactory.GetFileByNameAndType(const Name: string; Kind: TFileKind): IFile;
var
  Fullname: string;
  AFile: IFile;
begin
  Result := nil;
  Fullname := GetLongFileName(ExpandFileName(Name));
  for var I := 0 to FFiles.Count - 1 do begin
    AFile:= IFile(FFiles[I]);
    if AnsiSameText(AFile.GetFileName, Fullname) and (AFile.FileKind = Kind) then
    begin
      Result := AFile;
      Break;
    end;
  end;
end;

function TFileFactory.GetFileByType(Kind: TFileKind): IFile;
var
  AFile: IFile;
begin
  Result := nil;
  for var I := 0 to FFiles.Count - 1 do begin
    AFile:= IFile(FFiles[I]);
    if AFile.FileKind = Kind then
    begin
      Result := AFile;
      Break;
    end;
  end;
end;

function TFileFactory.GetFileByFileId(const Name: string): IFile;
var
  AFile : IFile;
begin
  Result := GetFileByName(Name);
  if not Assigned(Result) then
    for var I := 0 to FFiles.Count - 1 do begin
      AFile := IFile(FFiles[I]);
      if (AFile.FileName = '') and AnsiSameText(AFile.GetFileTitle, Name) then
      begin
        Result := AFile;
        Break;
      end;
   end;
end;

function TFileFactory.GetFile(Index: Integer): IFile;
begin
  Result := IFile(FFiles[Index]);
end;

procedure TFileFactory.RemoveFile(AFile: IFile);
  var Index: Integer;
begin
  Index := FFiles.IndexOf(AFile);
  if Index > -1 then
    FFiles.Delete(Index);
end;

function TFileFactory.GetFileCount: Integer;
begin
  Result := FFiles.Count;
end;

procedure TFileFactory.ApplyToFiles(const Proc: TProc<IFile>);
begin
  FFiles.Lock;
  try
    for var I:= 0 to FFiles.Count - 1 do
      Proc(IFile(FFiles[I]));
  finally
    FFiles.Unlock;
  end;
end;

function TFileFactory.FirstFileCond(const Predicate: TPredicate<IFile>): IFile;
var
  AFile: IFile;
begin
  FFiles.Lock;
  try
    Result := nil;
    for var I := 0 to FFiles.Count - 1 do begin
      AFile := IFile(FFiles[I]);
      if Predicate(AFile) then
        Exit(AFile);
    end;
  finally
    FFiles.Unlock;
  end;
end;

procedure TFileFactory.LockList;
begin
  FFiles.Lock;
end;

procedure TFileFactory.UnlockList;
begin
  FFiles.Unlock;
end;

end.

