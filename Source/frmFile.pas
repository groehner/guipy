unit frmFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
  SpTBXTabs, SpTBXSkins, uEditAppIntfs;

type
  TFile = class;

  { // class(TFileForm) - working windows of GuiPy
    ChangeStyle with notifications
    TEditorForm
    TFUMLForm
    TFTextDiff
    TFBrowser
    TFStructogram
    TFSequenceForm

    TFGUIForm = class (TForm)

    // class(TPyIDEDlgBase) - dialog windows
    TFAssociation        ChangeStyle - temporary window
    TFClassEditor        ChangeStyle
    TFDownload           no need
    TFGit                no need
    TFGUIDesigner        no need
    TFObjectGenerator    no need
    TFOpenFolderForm     no need - temporary window
    TFSubversion         no need
    TFUpdate             no need
    TFConnectForm        ChangeStyle - temporary window
    TFConfiguration      no need

    // class(TIDEDockWindow) - dockable windows
    TFFileStructure      ChangeStyle
    TFObjectInspector    ChangeStyle

}

  TFileForm = class(TForm)
    procedure FormCreate(Sender: TObject); virtual;
    procedure FormDestroy(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); virtual;
  private
    function getPathname: string;
    procedure setPathname(aFilename: string);
  protected
    fModified: boolean;
    procedure SetModified(Value: boolean); virtual;
    function GetModified: Boolean; virtual;
    procedure DoActivate;
    procedure DoActivateFile(Primary: boolean = True); virtual;
    function DoSaveFile: boolean; virtual;
    function DoSaveAs: boolean; virtual;
    function DoSaveAsRemote: boolean; virtual;
    function SaveToFile(const FileName: string): boolean;
    function LoadFromFile(const FileName: string): boolean; virtual;
    function OpenFile(const aFilename: String): boolean; virtual;
    procedure Enter(Sender: TObject); virtual;
    function DoAskSaveChanges: boolean; virtual;
    procedure Print; virtual;

    procedure SetFont(aFont: TFont); virtual;
    procedure SetFontSize(Delta: integer); virtual;
    procedure SelectFont(FileKind: TFileKind);

    function CanPaste: boolean; virtual;
    function CanCopy: boolean; virtual;
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;

    procedure DoAssignInterfacePointer(AActive: boolean);
    function GetState: string;
    procedure SetState(var s: string);
    function myActiveControl: TWinControl;
    procedure WndProc(var Message: TMessage); override;
    procedure Retranslate; virtual;
    procedure DoOnIdle; virtual;
  public
    fFile: TFile;
    ReadOnly: boolean;
    FileTime: TDateTime;
    ParentTabItem: TSpTBXTabItem;
    ParentTabControl: TSpTBXCustomTabControl;
    DefaultExtension: string;
    function GetFile: IFile;
    function DoSave: boolean;
    procedure DoExport; virtual;
    function getAsStringList: TStringList; virtual;
    procedure ExecCommand(cmd: integer); virtual;
    procedure OpenWindow(Sender: TObject); virtual;
    procedure CollectClasses(SL: TStringList); virtual;
    procedure DoUpdateCaption; virtual;
    procedure SetActiveControl(aControl: TWinControl);

    property Modified: boolean read GetModified write SetModified;
    property Pathname: string read GetPathname write SetPathname;
  end;

  TFile = class(TInterfacedObject, IUnknown, IFile, IFileCommands)
  private
    fFileKind: TFileKind;
    // IFile implementation
    procedure Retranslate;
    function GetForm: TForm;
    function GetTabControlIndex: Integer;
    function GetRemoteFileName: string;
    function GetSSHServer: string;
    // IFileCommands implementation
    function CanPrint: boolean;
    function CanSave: boolean;
    function CanSaveAs: boolean;
    function CanReload: boolean;
    procedure ExecSaveAs;
    procedure ExecSaveAsRemote;
  protected
    fUntitledNumber: Integer;
    procedure Activate(Primary: boolean = True); virtual;
    procedure Close; virtual;
    function GetFileTitle: string; virtual;
    function GetModified: boolean; virtual;
    procedure SetModified(aValue: boolean); virtuaL;
    function CanClose: boolean;
    function CanPaste: boolean; virtual;
    function CanCopy: boolean; virtual;
    procedure ExecClose;
    procedure ExecPaste; virtual;
    procedure ExecCopy; virtual;
    procedure ExecPrint; virtual;
    procedure ExecPrintPreview; virtual;
    procedure OpenFile(const AFileName: string);
    procedure ExecReload(Quiet: boolean = False); virtual;
    procedure Translate; virtual;
  public
    fFileName: string;
    fRemoteFileName : string;
    fSSHServer : string;
    fForm: TFileForm;
    fFromTemplate: boolean;
    constructor Create(FileKind: TFileKind; AForm: TFileForm); virtual;
    function GetFileKind: TFileKind;
    function GetFileName: string;
    function GetFileId: string;
    function GetFromTemplate: boolean;
    procedure SetFromTemplate(value: boolean);
    procedure DoSetFileName(AFileName: string); virtual;
    procedure OpenRemoteFile(const FileName, ServerName: string); virtual;
    function SaveToRemoteFile(const FileName, ServerName: string) : boolean; virtual;
    function AskSaveChanges: boolean;
    function DefaultFilename: boolean;
    procedure ExecCommand(cmd: integer);
    procedure ExecSave;
    procedure ExecExport;
    procedure DoOnIdle; virtual;

    class var UntitledNumbers: TBits;
    class function GetUntitledNumber: Integer;
    class constructor Create;
    class destructor Destroy;
  end;

  TFileFactory = class(TInterfacedObject, IFileFactory)
  private
    // IFileFactory implementation
    function CanCloseAll: boolean;
    procedure CloseAll;
    function GetFileByName(const Name: string): IFile;
    function GetFileByNameAndType(const Name: string; Kind: TFileKind): IFile;
    function GetFileByType(Kind: TFileKind): IFile;
    function GetFileByFileId(const Name : string): IFile;
  protected
    procedure LockList;
    procedure UnlockList;
  public
    fFiles: TInterfaceList;
    constructor Create;
    destructor Destroy; override;
    function NewFile(FileKind: TFileKind; TabControlIndex: integer = 1): IFile; overload;
    function GetFileCount: Integer;
    function GetFile(Index: Integer): IFile;
    procedure RemoveFile(aFile: IFile);
    procedure ApplyToFiles(const Proc: TProc<IFile>);
    function FirstFileCond(const Predicate: TPredicate<IFile>): IFile;
  end;

  var FileFactory: TFileFactory = nil;


implementation

uses System.IOUtils, UITypes, Types, Vcl.Dialogs, JvGnugettext, StringResources, uCommonFunctions,
  dlgPickList, frmPyIDEMain, dmResources, cSSHSupport,
  UUMLForm, USequenceForm, UStructogram, UTextDiff, UBrowser,
  cPyScripterSettings, VirtualShellNotifier, dlgRemoteFile, JclFileUtils,
  UUtils, UConfiguration;

{$R *.dfm}

{ TFileForm }

procedure TFileForm.FormCreate(Sender: TObject);
begin
  fModified:= false;
  fFile:= nil;
  TranslateComponent(Self);
  SkinManager.AddSkinNotification(Self);
end;

procedure TFileForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SkinManager.RemoveSkinNotification(Self);
  DoAssignInterfacePointer(false);
end;

procedure TFileForm.FormDestroy(Sender: TObject);
begin
  if assigned(fFile) and assigned(GI_FileFactory) then begin
    fFile.fForm := nil;
    GI_FileFactory.RemoveFile(fFile);
    if GI_FileFactory.Count = 0 then
      PyIDEMainForm.UpdateCaption;
  end;
end;

function TFileForm.DoAskSaveChanges: boolean;
begin
  // this is necessary to prevent second confirmation when closing tabs
  if fModified then
    if PyIDEOptions.SaveFilesAutomatically then begin
      Result:= DoSave;
      if not Result then begin
        var s:= Format(_(SCloseWithoutSaving), [TPath.GetFileName(fFile.GetFileTitle)]);
        if StyledMessageDlg(S, mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes) = mrYes then
          Result:= true;
      end
    end else begin
      DoActivateFile;
      MessageBeep(MB_ICONQUESTION);
      Assert(fFile <> nil);
      var S := Format(_(SAskSaveChanges), [TPath.GetFileName(fFile.GetFileTitle)]);
      case StyledMessageDlg(S, mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes) of
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

function TFileForm.DoSave: boolean;
begin
  Assert(fFile <> nil);
  if (fFile.fFileName <> '') or (fFile.fRemoteFileName <> '') then
    Result := DoSaveFile
  else
    Result := DoSaveAs;
end;

procedure TFileForm.DoExport;
begin
end;

procedure TFileForm.DoActivate;
begin
  ParentTabItem.Checked := True;
end;

procedure TFileForm.DoUpdateCaption;
Var
  TabCaption : string;
begin
  Assert(fFile <> nil);
  if fFile.fRemoteFileName <> '' then
    TabCaption := TPath.GetFileName(fFile.fRemoteFileName)
  else
    TabCaption := fFile.GetFileTitle;

  if assigned(ParentTabItem) then
    with ParentTabItem do
    begin
      Caption := StringReplace(TabCaption, '&', '&&', [rfReplaceAll]);
      Hint := fFile.GetFileId;
    end;
  PyIDEMainForm.UpdateCaption;
end;

function TFileForm.DoSaveAsRemote: boolean;
Var
  FileName, Server : string;
  aFile : IFile;
begin
  Assert(fFile <> nil);
  if ExecuteRemoteFileDialog(FileName, Server, rfdSave) then
  begin
    aFile := GI_FileFactory.GetFileByName(TSSHFileName.Format(Server, FileName));
    if Assigned(aFile) and (aFile <> Self.fFile as IFile) then
    begin
      Vcl.Dialogs.MessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    fFile.DoSetFileName('');
    fFile.fRemoteFileName := FileName;
    fFile.fSSHServer := Server;
    DoUpdateCaption; // Do it twice in case the following statement fails
    Result := DoSaveFile;
    DoUpdateCaption;
  end
  else
    Result := False;
end;

function TFileForm.OpenFile(const aFilename: String): boolean;
begin
  Result:= LoadFromFile(aFilename);
  if Result then begin
    Self.Pathname:= aFilename;
    Modified:= false;
    Enter(Self); // must stay! DoUpdateCaption
    SetFocus;
    ReadOnly:= IsWriteProtected(aFilename);
    PyIDEMainForm.ActiveTabControl := ParentTabControl;
    //UpdateState;
  end else
    Close;
end;

procedure TFileForm.ExecCommand(cmd: integer);
begin
end;

procedure TFileForm.Retranslate;
begin
  RetranslateComponent(Self);
end;

procedure TFileForm.OpenWindow(Sender: TObject);
begin
  try
    LockWindow(Self.Handle);
    try
      SetAnimation(false);
      Visible:= true;
      SetAnimation(true);
      BringToFront;
      Enter(Self);
    except on e: Exception do
      ErrorMsg('OpenWindow: ' + Pathname);
    end;
  finally
    UnlockWindow;
  end;
end;

procedure TFileForm.Enter(Sender: TObject);
begin
  DoUpdateCaption;
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
end;

function TFileForm.getAsStringList: TStringList;
begin
  Result:= nil;
end;

function TFileForm.GetFile: IFile;
begin
  Result := fFile;
end;

procedure TFileForm.DoActivateFile(Primary: boolean = True);
begin
  DoAssignInterfacePointer(true);
  DoActivate;
end;

procedure TFileForm.SetModified(Value: Boolean);
begin
  if fModified <> Value then begin
    fModified:= Value;
    PyIDEMainForm.UpdateCaption;
    if assigned(ParentTabItem) then
      ParentTabItem.Invalidate;
  end;
end;

function TFileForm.GetModified: Boolean;
begin
  Result:= fModified;
end;

procedure TFileForm.DoAssignInterfacePointer(AActive: boolean);
begin
  if AActive then
  begin
    GI_ActiveFile := fFile;
    //GI_EditCmds := fFile;
    GI_FileCmds := fFile;
    //GI_SearchCmds := fFile;
  end
  else
  begin
    if GI_ActiveFile = IFile(fFile) then
      GI_ActiveFile := nil;
    //if GI_EditCmds = IEditCommands(fEditor) then
      GI_EditCmds := nil;
    if GI_FileCmds = IFileCommands(fFile) then
      GI_FileCmds := nil;
    //if GI_SearchCmds = ISearchCommands(fFile) then
      GI_SearchCmds := nil;
  end;
end;

function TFileForm.DoSaveAs: boolean;
var
  NewName: string;
  aFile: IFile;
begin
  Assert(fFile<> nil);
  NewName := fFile.GetFileId;
  if (fFile.GetFileName = '') and (ExtractFileExt(NewName) = '') then
    NewName := NewName + '.' + DefaultExtension;
  if IsHttp(NewName) and (copy(Lowercase(ExtractFileExt(NewName)), 1, 4) <> '.htm') then
      NewName:= NewName + '.html';

  if ResourcesDataModule.GetSaveFileName(NewName, nil, '.' + DefaultExtension) then
  begin
    aFile := GI_FileFactory.GetFileByName(NewName);
    if Assigned(aFile) and (aFile <> Self.fFile as IFile) then
    begin
      MessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    fFile.DoSetFileName(NewName);
    DoUpdateCaption; // Do it twice in case the following statement fails
    Result := DoSaveFile;
    DoUpdateCaption;
  end
  else
    Result := False;
end;

function TFileForm.DoSaveFile: boolean;
begin
  Result := False;
  if fFile.fFileName <> '' then begin
    Result := SaveToFile(fFile.fFilename);
    if Result then
      if not FileAge(fFile.fFileName, FileTime) then
        FileTime := 0;
  end else if fFile.fRemoteFileName <> '' then
     Result := fFile.SaveToRemoteFile(fFile.fRemoteFileName, fFile.fSSHServer);
  if Result then
    Modified := False;
end;

function TFileForm.SaveToFile(const FileName: string): boolean;
  var SL: TStringList;
begin
  SL:= getAsStringList;
  try
    try
      SL.SaveToFile(Filename, TEncoding.UTF8);
      Result:= true;
    except
      on e: Exception do begin
        ErrorMsg(e.Message);
        Result:= false;
      end;
    end
  finally
    FreeAndNil(SL);
  end;
end;

function TFileForm.LoadfromFile(const FileName: string): boolean;
begin
  Result:= false;
end;

procedure TFileForm.SelectFont(FileKind: TFileKind);
  var i: Integer; aFont: TFont; aFile: IFile;
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  if ResourcesDataModule.dlgFontDialog.Execute then begin
    aFont:= ResourcesDataModule.dlgFontDialog.Font;
    for i:= 0 to GI_FileFactory.Count - 1 do begin
      aFile:= GI_FileFactory.FactoryFile[i];
      if assigned(aFile) and (aFile.FileKind = FileKind) then
        TFileForm(aFile.Form).SetFont(aFont);
    end;
  end;
end;

procedure TFileForm.SetFont(aFont: TFont);
begin
  Font.assign(aFont);
end;

procedure TFileForm.SetFontSize(Delta: integer);
begin
  Font.Size:= Font.Size + Delta;
  if Font.Size < 6 then Font.Size:= 6;
  SetFont(Font);
end;

function TFileForm.CanPaste: boolean;
begin
  Result:= false;
end;

function TFileForm.CanCopy: boolean;
begin
  Result:= false;
end;

procedure TFileForm.CopyToClipboard;
begin
end;

procedure TFileForm.PasteFromClipboard;
begin
end;

procedure TFileForm.WndProc(var Message: TMessage);
begin
  if assigned(fFile) and (fFile.fFileKind <> fkEditor) then begin
    if Message.Msg = CM_ENTER then
      DoAssignInterfacePointer(true)
    else if Message.Msg = CM_EXIT then
      DoAssignInterfacePointer(false);
  end;
  inherited WndProc(Message);
end;

function TFileForm.GetState: string;
begin
  Result:= 'W' + IntToStr(Left) + ')' + IntToStr(Top) + ')' +
                 IntToStr(Width) + ')' + IntToStr(Height) + ')' +
                 WindowStateToStr(WindowState) + ')';
end;

procedure TFileForm.SetState(var s: string);
  var {l, t, w, h,} p: integer; WS: TWindowState;
begin
  if s = '' then exit;
  if copy(s, 1, 1) = 'W' then begin
    p:= Pos(')', s); {l:= StrToInt(Copy(s, 2, p-2)); }delete(s, 1, p);
    p:= Pos(')', s);{ t:= StrToInt(Copy(s, 1, p-1)); }delete(s, 1, p);
    p:= Pos(')', s); {w:= StrToInt(Copy(s, 1, p-1)); }delete(s, 1, p);
    p:= Pos(')', s); {h:= StrToInt(Copy(s, 1, p-1));} delete(s, 1, p);
    p:= Pos(')', s); WS:= StrToWindowState(Copy(s, 1, p-1)); delete(s, 1, p);
    WindowState:= TWindowState(WS);
  end;
end;

procedure TFileForm.SetActiveControl(aControl: TWinControl);
begin
  if assigned(Parent) and Parent.CanFocus then
    Application.Mainform.ActiveControl:= aControl;
end;

function TFileForm.myActiveControl: TWinControl;
// https://de.comp.lang.delphi.misc.narkive.com/AU1p5kiy/activecontrol-nil
begin
  Result:= Application.Mainform.ActiveControl;
end;

function TFileForm.getPathname: string;
begin
  if assigned(fFile)
    then Result:= fFile.GetFilename
    else Result:= '';
end;

procedure TFileForm.setPathname(aFilename: string);
begin
  if assigned(fFile)
    then fFile.DoSetFileName(aFilename);
end;

procedure TFileForm.CollectClasses(SL: TStringList);
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
  Assert(AForm <> nil);
  inherited Create;
  fForm := AForm;
  fFileKind:= FileKind;
  fUntitledNumber := -1;
end;

procedure TFile.Activate(Primary: boolean = True);
begin
  if fForm <> nil then
    fForm.DoActivateFile(Primary);
end;

function TFile.AskSaveChanges: boolean;
begin
  if fForm <> nil then
    Result := fForm.DoAskSaveChanges
  else
    Result := True;
end;

procedure TFile.Close;
// Closes without asking
Var
  TabSheet: TSpTBXTabSheet;
  TabControl: TSpTBXCustomTabControl;
begin
  if (fForm <> nil) then
  begin
    GI_PyIDEServices.MRUAddFile(Self);
    if fUntitledNumber <> -1 then
      UntitledNumbers[fUntitledNumber] := False;

    Assert(GI_FileFactory <> nil);
    GI_FileFactory.RemoveFile(Self);
    if GI_FileFactory.Count = 0 then
      PyIDEMainForm.UpdateCaption;

    TabSheet := (fForm.Parent as TSpTBXTabSheet);
    TabControl := TabSheet.TabControl;
    TabControl.View.BeginUpdate;
    try
      (fForm.ParentTabControl as TSpTBXTabControl).zOrder.Remove(TabSheet.Item);
      fForm.Close;
      fForm:= nil;
      TabSheet.Free;
      if Assigned(TabControl) then begin
        TabControl.Toolbar.MakeVisible(TabControl.ActiveTab);
        var aFile:= GI_PyIDEServices.GetActiveFile;
        if assigned(aFile) then
          aFile.Activate;
      end;
    finally
      TabControl.View.EndUpdate;
    end;
  end;
end;

procedure TFile.DoSetFileName(AFileName: string);
begin
  if AFileName <> fFileName then
  begin
    fFileName := AFileName;
    fRemoteFileName := '';
    fSSHServer := '';
    if ((AFileName <> '') or (fRemoteFileName <> '')) and (fUntitledNumber <> -1) then
    begin
      UntitledNumbers[fUntitledNumber] := False;
      fUntitledNumber := -1;
    end;
    // Kernel change notification
    if (fFileName <> '') and FileExists(fFileName) then
      ChangeNotifier.NotifyWatchFolder(fForm, ExtractFileDir(fFileName))
    else
      ChangeNotifier.NotifyWatchFolder(fForm, '');
  end;
end;

function TFile.GetTabControlIndex: Integer;
begin
  Result := PyIDEMainForm.TabControlIndex(fForm.ParentTabControl);
end;

function TFile.GetFileName: string;
begin
  Result := fFileName;
end;

function TFile.GetFileTitle: string;
begin
  if fFileName <> '' then
  begin
    if PyIDEOptions.DisplayPackageNames and
      FileIsPythonPackage(fFileName)
    then
      Result := FileNameToModuleName(fFileName)
    else
      Result := ExtractFileName(fFileName);
  end
  else if fSSHServer <> '' then
    Result := TSSHFileName.Format(fSSHServer, fRemoteFileName)
  else
  begin
    if fUntitledNumber = -1 then
      fUntitledNumber := GetUntitledNumber;
    Result := _(SNonameFileTitle) + IntToStr(fUntitledNumber);
  end;
end;

function TFile.GetFileKind: TFileKind;
begin
  Result:= fFileKind;
end;

function TFile.GetFileId: string;
begin
  if fFileName <> '' then
    Result := fFileName
  else
    Result := GetFileTitle;
end;

function TFile.GetModified: boolean;
begin
  if fForm <> nil then
    Result := fForm.Modified
  else
    Result := False;
end;

procedure TFile.SetModified(aValue: boolean);
begin
  fForm.Modified:= aValue;
end;

function TFile.GetRemoteFileName: string;
begin
  Result := fRemoteFileName;
end;

function TFile.GetSSHServer: string;
begin
  Result := fSSHServer;
end;

function TFile.GetFromTemplate: boolean;
begin
  Result:= fFromTemplate;
end;

procedure TFile.SetFromTemplate(value: boolean);
begin
  fFromTemplate:= value;
end;

procedure TFile.Retranslate;
begin
  fForm.Retranslate;
end;

function TFile.GetForm: TForm;
begin
  Result := fForm;
end;

function TFile.DefaultFilename: boolean;
 var i, p: Integer; s, Default: String;
begin
  Result:= false;
  if assigned(FConfiguration) then
    if true {not FConfiguration.AcceptDefaultname }then begin
      Default:= Uppercase(_('File'));
      s:= Uppercase(ExtractFilename(fFilename));
      if Copy(s, 1, Length(Default)) = Default then begin
        delete(s, 1, Length(Default));
        p:= Pos('.', s);
        delete(s, p,length(s));
        Result:= TryStrToInt(s, i);
        end
      else
        Result:= false;
    end;
end;

procedure TFile.ExecCommand(cmd: integer);
begin
  fForm.ExecCommand(cmd);
end;

// IFileCommands implementation

function TFile.CanPrint: boolean;
begin
  Result := True;
end;

procedure TFile.ExecPrint;
begin
  if fForm <> nil then
    with ResourcesDataModule do
    begin
      PrintDialog.PrintRange := prAllPages;
      if PrintDialog.Execute then
        fForm.Print;
    end;
end;

procedure TFile.ExecPrintPreview;
begin
end;

function TFile.CanCopy: boolean;
begin
  Result := (fForm <> nil) and fForm.CanCopy;
end;

function TFile.CanPaste: boolean;
begin
  Result := (fForm <> nil) and fForm.CanPaste;
end;

function TFile.CanSave: boolean;
begin
  Result := (fForm <> nil) and (GetModified or ((fFileName = '') and (fRemoteFileName = '')));
end;

function TFile.CanSaveAs: boolean;
begin
  Result := fForm <> nil;
end;

function TFile.CanClose: boolean;
begin
  Result := fForm <> nil;
end;

procedure TFile.ExecCopy;
begin
  if fForm <> nil then
    fForm.CopyToClipboard;
end;

procedure TFile.ExecPaste;
begin
  if fForm <> nil then
    fForm.PasteFromClipboard;
end;

procedure TFile.ExecClose;
// Close only after asking
begin
  if AskSaveChanges then
    Close;
end;

procedure TFile.ExecExport;
begin
  fForm.DoExport;
end;

procedure TFile.ExecSave;
begin
  if fForm <> nil then
  begin
    if (fFileName <> '') or (fRemoteFileName <> '') then
      fForm.DoSave
    else
      fForm.DoSaveAs
  end;
end;

procedure TFile.ExecSaveAs;
begin
  if fForm <> nil then
    fForm.DoSaveAs;
end;

procedure TFile.ExecSaveAsRemote;
begin
  if fForm <> nil then
    fForm.DoSaveAsRemote;
end;

function TFile.CanReload: boolean;
begin
  Result := fFileName <> '';
end;

procedure TFile.OpenFile(const AFileName: string);
begin
  DoSetFileName(AFileName);
  if FileExists(AFileName) or IsHTTP(aFilename) then
    fForm.OpenFile(aFilename);
  if not FileAge(AFileName, fForm.FileTime) then
    fForm.FileTime := 0;
  fForm.DoUpdateCaption;
end;

procedure TFile.OpenRemoteFile(const FileName, ServerName: string);
Var
  TempFileName : string;
  ErrorMsg : string;
begin
  if (fForm = nil)  or (FileName = '') or (ServerName = '') then Exit;

  DoSetFileName('');

  TempFileName := ChangeFileExt(FileGetTempName('PyScripter'), ExtractFileExt(FileName));
  if not GI_SSHServices.ScpDownload(ServerName, FileName, TempFileName, ErrorMsg) then begin
    StyledMessageDlg(Format(_(SFileOpenError), [FileName, ErrorMsg]), mtError, [mbOK], 0);
    Abort;
  end else begin
    fForm.openFile(TempFilename);
    DeleteFile(TempFileName);
    {if not LoadFileIntoWideStrings(TempFileName, fForm.SynEdit.Lines) then
      Abort
    else
      DeleteFile(TempFileName);}
  end;

  fRemoteFileName := FileName;
  fSSHServer := ServerName;
  fForm.DoUpdateCaption;
end;

function TFile.SaveToRemoteFile(const FileName, ServerName: string): boolean;
  var ErrorMsg : string;
begin
  Result:= false;
  if (fForm = nil)  or (FileName = '') or (ServerName = '') then exit;    // ToDo was Abort

  var TempFileName := FileGetTempName('PyScripter');
  var SL:= fForm.getAsStringList;
  Result := SaveWideStringsToFile(TempFileName, SL, False);
  if Result then begin
    Result := GI_SSHServices.ScpUpload(ServerName, TempFileName, FileName, ErrorMsg);
    DeleteFile(TempFileName);
    if not Result then
      Vcl.Dialogs.MessageDlg(Format(_(SFileSaveError), [FileName, ErrorMsg]), mtError, [mbOK], 0);
  end;
  FreeAndNil(SL);
end;

procedure TFile.ExecReload(Quiet: boolean = False);
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
  fForm.DoOnIdle;
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
  fFiles := TInterfaceList.Create;
end;

destructor TFileFactory.Destroy;
begin
  FreeAndNil(fFiles);
  inherited;
end;

function TFileFactory.CanCloseAll: boolean;
begin
  Result := False;
  with TPickListDialog.Create(Application.MainForm) do
  begin
    Caption := _(SSaveModifiedFiles);
    lbMessage.Caption := _(SSelectModifiedFiles);
    ApplyToFiles(procedure(aFile: IFile)
    begin
      if aFile.Modified then
        CheckListBox.Items.AddObject(aFile.fileId, aFile.Form);
    end);
    SetScrollWidth;
    mnSelectAllClick(nil);
    if CheckListBox.Items.Count = 0 then
      Result := True
    else if CheckListBox.Items.Count = 1 then
      Result := TFileForm(CheckListBox.Items.Objects[0]).DoAskSaveChanges
    else if ShowModal = IdOK then
    begin
      Result := True;
      for var I := CheckListBox.Count - 1 downto 0 do
      begin
        if CheckListBox.Checked[I] then
        begin
          if not TFileForm(CheckListBox.Items.Objects[I]).DoSave then
          begin
            Result := False;
            break;
          end;
        end;
      end;
    end;
    Free;
  end;
end;

procedure TFileFactory.CloseAll;
var
  i: Integer;
begin
  fFiles.Lock;
  try
    i := fFiles.Count - 1;
    while i >= 0 do
    begin
      IFile(fFiles[i]).Close;
      Dec(i);
    end;
  finally
    fFiles.Unlock;
  end;
end;

function TFileFactory.NewFile(FileKind: TFileKind; TabControlIndex: integer = 1): IFile;
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
      fFile:= TFile.Create(FileKind, LForm);
      ParentTabItem := TabItem;
      ParentTabControl := TabControl;
      ParentTabItem.OnTabClosing := PyIDEMainForm.TabControlTabClosing;
      ParentTabItem.OnDrawTabCloseButton := PyIDEMainForm.DrawCloseButton;
      Result := fFile;
      BorderStyle := bsNone;
      Parent := Sheet;
      Align := alClient;
      Visible := True;
    end;
    if Result <> nil then
      fFiles.Add(Result);
  except
    Sheet.Free;
  end;
end;

function TFileFactory.GetFileByName(const Name: string): IFile;
Var
  i: Integer;
  FullName: string;
begin
  Result := nil;
  FullName := GetLongFileName(ExpandFileName(Name));
  for i := 0 to fFiles.Count - 1 do
    if AnsiSameText(IFile(fFiles[i]).GetFileName, FullName) then
    begin
      Result := IFile(fFiles[i]);
      break;
    end;
end;

function TFileFactory.GetFileByNameAndType(const Name: string; Kind: TFileKind): IFile;
Var
  i: Integer;
  FullName: string;
  aFile: IFile;
begin
  Result := nil;
  FullName := GetLongFileName(ExpandFileName(Name));
  for i := 0 to fFiles.Count - 1 do begin
    aFile:= IFile(fFiles[i]);
    if AnsiSameText(aFile.GetFileName, FullName) and (aFile.FileKind = Kind) then
    begin
      Result := aFile;
      break;
    end;
  end;
end;

function TFileFactory.GetFileByType(Kind: TFileKind): IFile;
Var
  i: Integer;
  aFile: IFile;
begin
  Result := nil;
  for i := 0 to fFiles.Count - 1 do begin
    aFile:= IFile(fFiles[i]);
    if aFile.FileKind = Kind then
    begin
      Result := aFile;
      break;
    end;
  end;
end;

function TFileFactory.GetFileByFileId(const Name: string): IFile;
Var
  i: Integer;
  aFile : IFile;
begin
  Result := GetFileByName(Name);
  if not Assigned(Result) then
    for i := 0 to fFiles.Count - 1 do begin
      aFile := IFile(fFiles[i]);
      if (aFile.FileName = '') and AnsiSameText(aFile.GetFileTitle, Name) then
      begin
        Result := aFile;
        break;
      end;
   end;
end;

function TFileFactory.GetFile(Index: Integer): IFile;
begin
  Result := IFile(fFiles[Index]);
end;

procedure TFileFactory.RemoveFile(aFile: IFile);
  var i: Integer;
begin
  i := fFiles.IndexOf(aFile);
  if i > -1 then
    fFiles.Delete(i);
end;

function TFileFactory.GetFileCount: Integer;
begin
  Result := fFiles.Count;
end;

procedure TFileFactory.ApplyToFiles(const Proc: TProc<IFile>);
  var i: integer;
begin
  fFiles.Lock;
  try
    for i:= 0 to fFiles.Count - 1 do
      Proc(IFile(fFiles[I]));
  finally
    fFiles.Unlock;
  end;
end;

function TFileFactory.FirstFileCond(const Predicate: TPredicate<IFile>): IFile;
Var
  afile: IFile;
begin
  fFiles.Lock;
  try
    Result := nil;
    for var I := 0 to fFiles.Count - 1 do begin
      aFile := IFile(fFiles[I]);
      if Predicate(aFile) then
        Exit(aFile);
    end;
  finally
    fFiles.Unlock;
  end;
end;

procedure TFileFactory.LockList;
begin
  fFiles.Lock;
end;

procedure TFileFactory.UnlockList;
begin
  fFiles.UnLock;
end;

end.

