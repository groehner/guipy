unit USetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Registry, ShellLink, UUtils, IniFiles,
  {$WARNINGS OFF} FileCtrl {$WARNINGS ON};

type
  TFSetup = class(TForm)
    LHint1: TLabel;
    EUserfolder: TEdit;
    LHint2: TLabel;
    LFolder: TLabel;
    EFolder: TEdit;
    SBFolder: TSpeedButton;
    SBUserIni: TSpeedButton;
    BInstall: TButton;
    BDeinstall: TButton;
    BClose: TButton;
    CBDesktopSymbol: TCheckBox;
    CBStartmenu: TCheckBox;
    BLanguage: TButton;
    ODSelect: TOpenDialog;
    CBPortableApplication: TCheckBox;
    BDeutsch: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BInstallClick(Sender: TObject);
    procedure BDeinstallClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure CBPortableApplicationClick(Sender: TObject);
    procedure SBFolderClick(Sender: TObject);
    procedure BLanguageClick(Sender: TObject);
    procedure BDeutschClick(Sender: TObject);
  private
    Dir: String;
    CommonStartmenu: String;
    CommonDesktopdirectory: String;
    Error: boolean;
    Starting: boolean;
    FolderDialog: TFileOpenDialog;
    ShellLink: TShellLink;
    procedure CreateDirectory(dir: string);
    procedure CopyFromToFile(const dir1, dir2, Filename: string);
    procedure CreateINIFile(Filename: string);
    procedure RegisterPythonFiles(Path: string);

    function ReplaceUsername(s: String): String;
    function AppDataFolder: string;
    function UnPortApp(s: string): string;

    procedure DeleteFileWithComment(Comment, Pathname:String);
    procedure DeleteINIFiles(DestDir: string);
    procedure DeleteSetup;
    procedure DeleteRegistry;
    procedure RemoveDir(Path: string);
    procedure CopyFilesRecursive(SourceDir, DestDir: string);
  public
    DestDir: String;
    function GetUsername: string;
  end;

var
  FSetup: TFSetup;

implementation

uses UMemo, ShlObj, ShellApi, UITypes, IOUtils,
     JvGnugettext, UStringRessources;

{$R *.DFM}

procedure TFSetup.FormCreate(Sender: TObject);
  var s: string;
begin
  FolderDialog:= TFileOpenDialog.Create(Self);
  FolderDialog.options:= [fdoPickFolders];
  ShellLink:= TShellLink.Create(Self);

  Error:= false;
  Starting:= true;

  CommonStartmenu:= GetSpecialFolderPath(CSIDL_COMMON_STARTMENU);
  if CommonStartmenu = '' then
    CommonStartmenu:= GetSpecialFolderPath(CSIDL_STARTMENU);
  CommonStartmenu:= CommonStartmenu + '\Programs\';

  CommonDesktopdirectory:= GetSpecialFolderPath(CSIDL_COMMON_DESKTOPDIRECTORY);
  if CommonDesktopdirectory = '' then
    CommonDesktopdirectory:= GetSpecialFolderPath(CSIDL_DESKTOPDIRECTORY);

  CommonDesktopdirectory:= IncludeTrailingPathDelimiter(CommonDesktopdirectory);
  Dir:= GetSpecialFolderPath(CSIDL_PROGRAM_FILES) + '\GuiPy\';

  s:= ParamStr(0);
  if Copy(s, 1, 2) = '\\' then // Server
    Dir:= ExtractFilePath(s);
  EFolder.text:= Dir;
  EUserFolder.Text:= AppDataFolder;
  TranslateComponent(Self);
end;

procedure TFSetup.SBFolderClick(Sender: TObject);
begin
  if Sender = SBFolder
    then FolderDialog.DefaultFolder:= Dir
    else FolderDialog.DefaultFolder:= ReplaceUsername(EUserfolder.Text);

  if FolderDialog.Execute then begin
    Dir:= IncludeTrailingPathDelimiter(FolderDialog.Filename);
    if Sender = SBFolder then begin
      if Pos('GuiPy', Dir) = 0 then
        Dir:= Dir + 'GuiPy\';
      EFolder.Text:= Dir;
      if CBPortableApplication.Checked then
        EUserFolder.Text:= Dir
    end else
      EUserfolder.Text:= Dir;
  end;
end;

function TFSetup.GetUsername: string;
var
  UserName, s1: String;
  i: Integer;
  Laenge: LongWord;

begin
  Laenge:= 100;
  Username:= StringOfChar(' ', Laenge);
  WNetGetUser(Nil, PChar(Username), Laenge);
  s1:= '';
  i:= 1;
  while (Username[i] <> #0) do begin
    s1:= s1 + Username[i];
    inc(i);
  end;
  Result:= s1;
end;

function TFSetup.ReplaceUsername(s: String): String;
begin
  var p:= Pos('%USERNAME%', UpperCase(s));
  if p > 0 then begin
    Delete(s, p, 10);
    Insert(GetUsername, s, p);
  end;
  Result:= s;
end;

procedure TFSetup.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFSetup.CopyFromToFile(const dir1, dir2, Filename: string);
  var f1, f2, s: String;
begin
  f1:= TPath.Combine(dir1, Filename);
  f2:= TPath.Combine(dir2, Filename);
  if UpperCase(f1) = UpperCase(f2) then Exit;
  FMemo.Output(Format(_(LNGCopyFromTo), [f1, f2]));
  if FileExists(f2) and not DeleteFile(f2) then begin
    s:= Format(_(LNGCanNotDelete), [f2]);
    MessageDlg(s, mtError, [mbOK], 0);
    FMemo.Output(s);
    Error:= true;
    Exit;
  end;
  if not CopyFile(PChar(f1), PChar(f2), false) then begin
    s:= Format(_(LNGCopyError), [f2]);
    FMemo.Output(s);
    Error:= true;
  end;
end;

procedure TFSetup.CreateINIFile(Filename: string);
  var SL: TStringList; s: String;
begin
  FMemo.Output(_(LNGCreateConfigurationfile) + ' ' + Filename);
  SL:= TStringList.Create;
  try
    SL.SaveToFile(Filename);
  except
    s:= Format(_(LNGCanNotCreate), [Filename]);
    MessageDlg(s, mtError, [mbOk], 0);
    FMemo.Output(s);
  end;
  if Assigned(SL) then SL.Free;
end;

procedure TFSetup.CreateDirectory(dir: string);
begin
  if not SysUtils.DirectoryExists(dir) then begin
    if SysUtils.ForceDirectories(dir) then
      FMemo.Output(_('directory created: ') + dir)
    else
      FMemo.Output(_('directory cannot be created: ') + dir)
  end else
    FMemo.Output(_('directory already exists: ') + dir)
end;

procedure TFSetup.BInstallClick(Sender: TObject);
  var FromDir, UserDir, MachineFile, WorkDir, ProgData, Path, Parameter: string;
      IniDatei: TIniFile;
begin
  if not (CBPortableApplication.Checked or IsAdmin) and
    (MessageDlg(_(LNGNoAdministrator), mtWarning, [mbNo, mbYes], 0) <> mrYes) then
    exit;
  if EFolder.Text = '' then begin
    MessageDlg(_(LNGSpecifyInstallationfolder), mtError, [mbOK], 0);
    exit;
  end;

  FromDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  DestDir:= IncludeTrailingPathDelimiter(EFolder.Text);
  CreateDirectory(DestDir);
  if not SysUtils.DirectoryExists(DestDir) then begin
    MessageDlg(Format(_(LNGInstallationFolderDoesnotExist), [DestDir]), mtError, [mbOK], 0);
    Exit;
  end;

  if CBPortableApplication.Checked then
    UserDir:= DestDir
  else begin
    UserDir:= ReplaceUsername(IncludeTrailingPathDelimiter(EUserfolder.Text));
    CreateDirectory(UserDir);
  end;
  if not SysUtils.DirectoryExists(UserDir) then begin
    MessageDlg(_(LNGUserFolder), mtError, [mbOK], 0);
    exit;
  end;

  CopyFromToFile(FromDir, DestDir, 'GuiPy.exe');
  if Error then begin
    MessageDlg(Format(_(LNGCopyError), [DestDir]), mtError, [mbOK], 0);
    FMemo.MInstallation.Clear;
    exit;
  end;
  CopyFromToFile(FromDir, DestDir, 'Setup.exe');

  FMemo.Show;
  Screen.Cursor:= crHourGlass;
  try
    if CBPortableApplication.Checked
      then ProgData:= DestDir
      else ProgData:= TPath.Combine(TPath.GetPublicPath, 'GuiPy\'); // C:\ProgramData\GuiPy\

    CreateDirectory(ProgData);
    CopyFilesRecursive(TPath.Combine(FromDir, 'Scripts'), ProgData);

    WorkDir:= TPath.Combine(ProgData, 'Highlighters');
    CreateDirectory(WorkDir);
    CopyFilesRecursive(TPath.Combine(FromDir, 'Highlighters'), WorkDir);

    WorkDir:= TPath.Combine(ProgData, 'Styles');
    CreateDirectory(WorkDir);
    CopyFilesRecursive(TPath.Combine(FromDir, 'Styles'), WorkDir);

    WorkDir:= TPath.Combine(ProgData, 'Variable Inspectors\dataframe');
    CreateDirectory(WorkDir);
    CopyFilesRecursive(TPath.Combine(FromDir, 'Variable Inspectors\dataframe'), WorkDir);

    WorkDir:= TPath.Combine(ProgData, 'Lsp\jls');
    CreateDirectory(WorkDir);
    CopyFilesRecursive(TPath.Combine(FromDir, 'Lib\Lsp\jls'), WorkDir);

    Path:=  TPath.Combine(WorkDir, 'jedilsp.exe');
    Parameter:= '-y';
    ShellExecute(Handle, 'open', PChar(Path), PChar(Parameter), nil, SW_Hide);

    WorkDir:= TPath.Combine(DestDir, 'locale');
    CreateDirectory(WorkDir);
    CopyFilesRecursive(TPath.Combine(FromDir, 'locale'), WorkDir);

    CopyFromToFile(FromDir, DestDir, 'DebugLayout.ini');
    CopyFromToFile(FromDir, DestDir, 'DefaultLayout.ini');
    CopyFromToFile(FromDir, DestDir, 'WebView2Loader.dll');
    if IsWebView2RuntimeNeeded then begin
      CopyFromToFile(FromDir, ProgData, 'MicrosoftEdgeWebview2Setup.exe');
      var Params:= '/silent /install';
      ShellExecute(Handle, 'open',  PChar(ProgData + 'MicrosoftEdgeWebview2Setup.exe'),
        PChar(Params), PChar(ProgData), SW_Hide);
      TFile.Delete(ProgData + 'MicrosoftEdgeWebview2Setup.exe');
    end;

    WorkDir:= TPath.Combine(DestDir, 'Lib');
    CreateDirectory(WorkDir);
    CopyFromToFile(TPath.Combine(FromDir, 'Lib'), WorkDir, 'rpyc.zip');

    ShellLink.ProgramFile:= TPath.Combine(DestDir, 'GuiPy.exe');
    if CBDesktopSymbol.Checked then begin
      ShellLink.LinkFile:= TPath.Combine(CommonDesktopdirectory, 'GuiPy.lnk');
      FMemo.Output(_(LNGCreate) + ' ' + _(LNGDesktopLink) + ' ' + ShellLink.LinkFile);
      ShellLink.Write;
    end;

    if CBStartmenu.Checked then begin
      ShellLink.LinkFile:= TPath.Combine(CommonStartmenu, 'GuiPy.lnk');
      if not SysUtils.DirectoryExists(CommonStartmenu) then
        SysUtils.ForceDirectories(CommonStartmenu);
      FMemo.Output(LNGCreate + ' ' + _(LNGItemInProgramMenu) + ' ' + ShellLink.LinkFile);
      ShellLink.Write;
    end;

    if not CBPortableApplication.Checked then begin
      FMemo.Output(_(LNGCreateAdditionalLnk) + ' ' + DestDir);
      ShellLink.LinkFile:= TPath.Combine(DestDir, 'GuiPy.lnk');
      ShellLink.Write;
      RegisterPythonFiles(TPath.Combine(DestDir, 'GuiPy.exe'));
    end;

    MachineFile:= TPath.Combine(DestDir, 'GuiPyMachine.ini');
    CreateINIFile(MachineFile);
    if CBPortableApplication.Checked
      then EUserfolder.Text:= UserDir
      else EUserfolder.Text:= IncludeTrailingPathDelimiter(EUserfolder.Text);

    FMemo.Output(_(LNGSaveTo) + ' ' + EUserfolder.Text);
    IniDatei:= TIniFile.Create(MachineFile);
    IniDatei.WriteString('User', 'HomeDir', UnPortApp(EUserfolder.Text));
    IniDatei.WriteBool('GuiPy', 'PortableApplication', CBPortableApplication.Checked);
    IniDatei.Free;

    FMemo.Output(_(LNGSaveInstallation) + ' ' + DestDir + 'install.txt');
    FMemo.Output(_('finished'));
    FMemo.MInstallation.Lines.SaveToFile(DestDir + 'install.txt');
  finally
    Screen.Cursor:= crDefault;
  end;
  if not Error then
    FMemo.Installation:= 0;
end;

procedure TFSetup.CopyFilesRecursive(SourceDir, DestDir: string);
  var SR: TSearchRec;
begin
  SourceDir:= UnHideBlanks(SourceDir);
  try
    if FindFirst(TPath.Combine(SourceDir, '*.*'), faDirectory, SR) = 0 then
      repeat
        if (SR.Name = '.') or (SR.Name = '..') then
          continue;
        if SR.Attr and faDirectory = faDirectory then begin
          SysUtils.ForceDirectories(TPath.Combine(DestDir, SR.Name));
          CopyFilesRecursive(TPath.Combine(SourceDir, SR.Name),
                             TPath.Combine(DestDir, SR.Name));
        end else
          CopyFromToFile(SourceDir, DestDir, SR.Name);
      until FindNext(SR) <> 0;
  finally
    SysUtils.FindClose(SR);
  end;
end;

procedure TFSetup.BLanguageClick(Sender: TObject);
begin
  UseLanguage('en_EN');
  RetranslateComponent(Self);
  RetranslateComponent(FMemo);
end;

procedure TFSetup.BDeutschClick(Sender: TObject);
begin
  UseLanguage('de_DE');
  RetranslateComponent(Self);
  RetranslateComponent(FMemo);
end;

procedure TFSetup.DeleteRegistry;
  var Reg: TRegistry;

  procedure DeleteKeyRecursiv(Key: string);
    var Eintraege: TStringList;
        i: integer;
  begin
    Eintraege:= TStringList.Create;
    with Reg do begin
      if OpenKey(Key, false) then begin
        GetKeyNames(Eintraege);
        for i:= 0 to Eintraege.Count-1 do
          DeleteKeyRecursiv(Key + '\' + Eintraege.strings[i]);
        Eintraege.Clear;
      end;
      if OpenKey(Key, false) then begin
        GetValueNames(Eintraege);
        for i:= 0 to Eintraege.Count-1 do
          DeleteValue(Key + '\' + Eintraege.strings[i]);
      end;    
      DeleteKey(Key);
    end;
    Eintraege.Free;
  end;

begin
  Reg:= TRegistry.Create;
  with Reg do begin
    try
      Access:= KEY_ALL_ACCESS;
      RootKey:= HKEY_CURRENT_USER;
      DeleteKeyRecursiv('\Software\GuiPy');

      RootKey:= HKEY_LOCAL_MACHINE;
      DeleteKeyRecursiv('\Software\GuiPy');

      RootKey:= HKEY_CLASSES_ROOT;
      if OpenKey('\.py', false) and (ReadString('') = 'GuiPy')
        then WriteString('', '');
      if OpenKey('\.pyw', false) and (ReadString('') = 'GuiPy')
        then WriteString('', '');
      DeleteKeyRecursiv('\GuiPy');
    finally
      Reg.Free;
    end;
  end;
end;

procedure TFSetup.DeleteFileWithComment(Comment, Pathname: String);
begin
  if not FileExists(Pathname) then exit;
  TFile.Delete(Pathname);
  if TFile.Exists(Pathname) then
    FMemo.Output(Format(_(LNGCanNotDelete), [Pathname]))
  else
    FMemo.Output(_(LNGDelete) + ' ' + Comment + ' ' + Pathname);
end;

procedure TFSetup.DeleteINIFiles(DestDir: string);
  var p: Integer;
      IniDatei: TIniFile;
      MachineFile, UserDir: string;
begin
  DestDir:= IncludeTrailingPathDelimiter(DestDir);
  MachineFile:= DestDir + 'GuiPyMachine.ini';
  if FileExists(MachineFile) then begin
    IniDatei:= TIniFile.Create(MachineFile);
    UserDir:= IniDatei.ReadString('User', 'HomeDir', '<nix>');
    IniDatei.Free;

    p:= Pos('%USERNAME%', Uppercase(UserDir));
    if p > 0 then begin
      Delete(UserDir, p, 10);
      Insert(GetUserName, UserDir, p);
    end;
    UserDir:= IncludeTrailingPathDelimiter(UserDir);
    DeleteFileWithComment(_(LNGConfigurationfile), UserDir + 'GuiPyUser.ini');
    DeleteFileWithComment(_(LNGConfigurationfile), MachineFile);
  end;
end;

procedure TFSetup.BDeinstallClick(Sender: TObject);
begin
  if not (CBPortableApplication.Checked or IsAdmin) and
    (MessageDlg(_(LNGNoAdministrator), mtWarning, [mbNo, mbYes], 0) <> mrYes) then
    exit;

  FMemo.Show;
  FMemo.Installation:= 1;
  Screen.Cursor:= crHourGlass;
  try
    ShellLink.LinkFile:= CommonDesktopdirectory + 'GuiPy.lnk';
    ShellLink.Read;
    DestDir:= ExtractFilePath(ShellLink.ProgramFile);
    if DestDir = '' then begin
      ShellLink.LinkFile:= CommonStartmenu + 'GuiPy.lnk';
      ShellLink.Read;
      DestDir:= ExtractFilePath(ShellLink.ProgramFile);
    end;
    DeleteFileWithComment(_(LNGDesktopLink), CommonDesktopdirectory + 'GuiPy.lnk');
    DeleteFileWithComment(_(LNGItemInProgramMenu), CommonStartmenu + 'GuiPy\GuiPy.lnk');

    DestDir:= ExtractFilePath(ParamStr(0));
    RemoveDir(DestDir + 'Highlighters');
    RemoveDir(DestDir + 'Lib');
    RemoveDir(DestDir + 'locale');
    RemoveDir(DestDir + 'Scripts');
    RemoveDir(DestDir + 'Styles');
    RemoveDir(DestDir + 'Updates');
    RemoveDir(CommonStartmenu + 'GuiPy');

    DeleteFileWithComment('' , DestDir + 'DebugLayout.ini');
    DeleteFileWithComment('' , DestDir + 'DefaultLayout.ini');
    DeleteFileWithComment('' , DestDir + 'GuiPyMachine.ini');
    DeleteFileWithComment('' , DestDir + 'remserver.py');

    DeleteFileWithComment(_(LNGDesktopLink), DestDir + 'GuiPy.lnk');
    DeleteFileWithComment(_(LNGInstallationProcess), DestDir + 'install.txt');
    DeleteFileWithComment(_(LNGProgram), DestDir + 'GuiPy.exe');
    DeleteINIFiles(DestDir);
    DeleteRegistry;
    DeleteSetup;
  finally
    Screen.Cursor:= crDefault;
  end;
end;


procedure TFSetup.CBPortableApplicationClick(Sender: TObject);
begin
  if CBPortableApplication.Checked then begin
    EUserfolder.Enabled := false;
    EUserfolder.Color   := clMenu;
    SBUserIni.Enabled   := false;
  end else begin
    EUserfolder.Enabled := true;
    EUserfolder.Color   := clWindow;
    SBUserIni.Enabled   := true;
  end;
  EUserfolder.Text:= AppDataFolder;
end;

function TFSetup.AppDataFolder: string;
  var s, user: string; p: integer;
begin
  if CBPortableApplication.Checked then
    s:= EFolder.Text
  else begin
    s:= GetSpecialFolderPath(CSIDL_APPDATA) + '\GuiPy\';
    user:= GetUserName;
    p:= Pos(user, s);
    if p > 0 then begin
      Delete(s, p, Length(user));
      Insert('%Username%', s, p);
    end
  end;
  Result:= s;
end;

function TFSetup.UnPortApp(s: string): string;
  var SL1, SL2: TStringList;
      i, j: integer;
begin
  Result:= s;
  if CBPortableApplication.Checked and (s <> '') and
     (Uppercase(copy(DestDir, 1, 2)) = Uppercase(copy(s, 1, 2)))  // same drive
  then begin
    SL1:= Split('\', withoutTrailingSlash(DestDir));
    SL2:= Split('\', withoutTrailingSlash(s));
    i:= 0;
    while (i < SL1.Count) and (i < SL2.Count) and
          (Uppercase(SL1.Strings[i]) = Uppercase(SL2.Strings[i])) do
      inc(i);
    Result:= '';
    j:= i;
    while i < SL1.Count do begin
      Result:= Result + '..\';
      inc(i);
    end;
    while j < SL2.Count do begin
      Result:= Result + SL2.Strings[j] + '\';
      inc(j);
    end;
    Result:= withoutTrailingSlash(Result);
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

procedure TFSetup.RegisterPythonFiles(Path: string);
  var Reg: TRegistry; Filename: string;

  procedure WriteToRegistry(Key: String);
  begin
    with Reg do begin
      OpenKey(Key, true);
      WriteString('', 'GuiPy');
      CloseKey;
      OpenKey(Key + '\DefaultIcon', true);
      WriteString('', HideBlanks(Path) + ',0');
      CloseKey;
      OpenKey(Key + '\Shell\Open\command', true);
      WriteString('', HideBlanks(Path) + ' "%1"');
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec', true);
      WriteString('', '[FileOpen("%1")]');
      OpenKey('Application', true);
      FileName := ExtractFileName(Path);
      FileName := Copy(FileName, 1, Length(FileName)-4);
      WriteString('', Filename);
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec\topic', true);
      WriteString('', 'System');
      CloseKey;
    end;
  end;

begin
  try
    Reg:= TRegistry.Create;
    with Reg do begin
      Access:= KEY_ALL_ACCESS;
      RootKey:= HKEY_LOCAL_MACHINE;
      WriteToRegistry('Software\Classes\GuiPy');
      RootKey:= HKEY_CURRENT_USER;
      WriteToRegistry('\Software\Classes\GuiPy');

      OpenKey('\SOFTWARE\Classes\.py', true);
      WriteString('', 'GuiPy');
      OpenKey('\SOFTWARE\Classes\.pyw', true);
      WriteString('', 'GuiPy');
      OpenKey('\Software\Classes\.pfm', true);
      WriteString('', 'GuiPy');
      OpenKey('\Software\Classes\.puml', true);
      WriteString('', 'GuiPy');
      OpenKey('\Software\Classes\.psg', true);
      WriteString('', 'GuiPy');
      OpenKey('\Software\Classes\.psd', true);
      WriteString('', 'GuiPy');
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFSetup.DeleteSetup;
  var Datei: TFileStream; Filename: String;

  procedure StreamWriteln(FS: TFileStream; s: string);
  begin
    s:= s + #13#10;
    FS.write(s[1], length(s));
  end;

begin
  Datei:= TFileStream.Create(GetTempDir + 'RunPy.bat', fmCreate or fmOpenWrite);
  Filename:= HideBlanks(DestDir + 'Setup.exe');
  StreamWriteln(Datei, 'echo on');
  StreamWriteln(Datei, ':1');
  StreamWriteln(Datei, 'del ' + Filename);
  StreamWriteln(Datei, 'if exist ' + Filename + ' goto 1');
  StreamWriteln(Datei, 'rmdir -s ' + HideBlanks(DestDir));
  Datei.Free;
end;

procedure TFSetup.RemoveDir(Path: string);
begin
  if SysUtils.DirectoryExists(Path) then begin
    TDirectory.Delete(Path, true);
    if SysUtils.DirectoryExists(Path) then
      FMemo.Output(_('Can''t delete directory: ') + Path)
    else
      FMemo.Output(_('Directory deleted: ') + Path);
  end;
end;

end.