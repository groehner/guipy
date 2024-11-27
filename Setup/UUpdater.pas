unit UUpdater;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Zip, ShlObj, Registry, IniFiles, ExtCtrls;

type
  TFUpdater = class(TForm)
    Memo: TMemo;
    Panel1: TPanel;
    BOK: TButton;
    BRetry: TButton;
    procedure BOKClick(Sender: TObject);
    procedure BRetryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Source: string;
    Dest: string;
    Version: string;
    MachineIniFile: TMemIniFile;
    PortableApplication: boolean;
    PortAppDrive: String;

    procedure CopyFromTo(const dir1, dir2, Filename: string);
    procedure RegisterApp(GuiPy: string);
    procedure ChangeRegistry(Dest, Source: string);
    procedure ChangeGuiPyRegistration(Source: string);
    procedure WriteString(key, name, value: String);
    function ReadString(key, name, default: String): String;
    procedure WriteInteger(key, name: String; value: Integer);
    function  ReadInteger(key, name: String; default: Integer): Integer;
  public
    Error: boolean;
    Restart: boolean;
    procedure CopyFilesRecursive(SourceDir, DestDir: string);
    procedure MakeUpdate;
  end;

var
  FUpdater: TFUpdater;

implementation

{$R *.dfm}

Uses ShellApi, UUtils, USetup, UWait, UITypes, IOUtils,
     JvGnugettext, UStringRessources;

procedure TFUpdater.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
end;

{$WARNINGS OFF}
procedure TFUpdater.CopyFromTo(const dir1, dir2, Filename: string);
  var Attribute: Integer; f1, f2: string;
begin
  f1:= TPath.Combine(dir1, Filename);
  f2:= TPath.Combine(dir2, Filename);
  Attribute:= FileGetAttr(f2);
  if (Attribute <> -1) and (Attribute and faReadOnly <> 0) then
    FileSetAttr(f2, 0);

  if FileExists(f2) and not DeleteFile(PChar(f2)) then
    Memo.Lines.Add(Format(_(LNGCanNotDelete), [f2]));
  TFile.Copy(f1, f2, true);
  if FileExists(f2) then
    Memo.Lines.Add(Format(_(LNGCopyFromTo), [f1, f2]))
  else begin
    Memo.Lines.Add('Cannot copy ' + f1);
    Memo.Lines.Add('  to: ' + f2);
    Error:= true;
  end;
end;
{$WARNINGS ON}

procedure TFUpdater.BOKClick(Sender: TObject);
begin
  ExecuteFile(Dest + 'GuiPy.exe', '', Dest, SW_ShowNormal);
  Close;
  FSetup.Close;
end;

procedure TFUpdater.RegisterApp(GuiPy: string);
  var Reg: TRegistry;

  procedure WriteToRegistry(Key: String);
  begin
    with Reg do begin
      OpenKey(Key, true);
      WriteString('', 'GuiPy');
      CloseKey;
      OpenKey(Key + '\DefaultIcon', true);
      WriteString('', HideBlanks(GuiPy) + ',0');
      CloseKey;
      OpenKey(Key + '\Shell\Open\command', true);
      WriteString('', HideBlanks(GuiPy) + ' "%1"');
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec', true);
      WriteString('', '[FileOpen("%1")]');
      OpenKey('Application', true);
      WriteString('', changeFileExt(ExtractFilename(GuiPy), ''));
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec\topic', true);
      WriteString('', 'System');
      CloseKey;
    end;
  end;

begin
  Reg:= TRegistry.Create;
  try
    with Reg do begin
      Access:= KEY_ALL_ACCESS;
      RootKey:= HKEY_LOCAL_MACHINE;
      WriteToRegistry('\SOFTWARE\Classes\GuiPy');
      RootKey:= HKEY_CURRENT_USER;
      WriteToRegistry('\SOFTWARE\Classes\GuiPy');
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFUpdater.ChangeGuiPyRegistration(Source: string);
  var Reg: TRegistry;
begin
  Source:= decodeQuotationMark(Source);
  if Pos(' "%1"', Source) = 0 then
    Source:= Source + ' "%1"';
  Reg:= TRegistry.Create;
  try
    with Reg do begin
      Access:= KEY_ALL_ACCESS;
      RootKey:= HKEY_LOCAL_MACHINE;
      OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', true);
      WriteString('', Source);
      RootKey:= HKEY_CURRENT_USER;
      OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', true);
      WriteString('', Source);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFUpdater.ChangeRegistry(Dest, Source: string);

  var reg: TRegistry; s1, ext, b: string; p: integer;

  procedure EditAssociation(Extension: string; docreate: boolean);
  begin
    with Reg do begin
      Access:= KEY_ALL_ACCESS;
      RootKey:= HKEY_LOCAL_MACHINE;
      try
        if docreate then begin
          OpenKey('\SOFTWARE\Classes\' + Extension, true);
          WriteString('', 'GuiPy')
        end else begin
          OpenKey('\SOFTWARE\Classes\' + Extension, false);
          if ReadString('') = 'GuiPy' then
            WriteString('', '');
        end;
        CloseKey;
        RootKey:= HKEY_CURRENT_USER;
        if docreate then begin
          OpenKey('\SOFTWARE\Classes\' + Extension, true);
          WriteString('', 'GuiPy');
        end else begin
          OpenKey('\SOFTWARE\Classes\' + Extension, false);
          if ReadString('') = 'GuiPy' then
            WriteString('', '');
        end;
        CloseKey;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end
    end;
  end;

begin
  RegisterApp(Dest);
  Reg:= TRegistry.Create;
  s1:= UnhideBlanks(Source);
  p:= Pos(' ', s1);
  while p > 0 do begin
    ext:= copy(s1, 1, p-1);
    delete(s1, 1, p);
    p:= Pos(' ', s1);
    b:= copy(s1, 1, p-1);
    delete(s1, 1, p);
    EditAssociation(ext, StrToBool(b));
    Memo.Lines.Add(ext + ' ' + b);
    p:= Pos(' ', s1);
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil) ;
end;

procedure TFUpdater.BRetryClick(Sender: TObject);
begin
  MakeUpdate;
end;

procedure TFUpdater.CopyFilesRecursive(SourceDir, DestDir: string);
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
          CopyFromTo(SourceDir, DestDir, SR.Name);
      until FindNext(SR) <> 0;
  finally
    SysUtils.FindClose(SR);
  end;
end;

{$WARNINGS OFF}
procedure TFUpdater.MakeUpdate;
  var Source2, From, To1, Machine, s, Key, Name, Value, kind, p1,
      ProgData, WorkDir, Path, UserDir, Parameter: string;
       i, p: integer; SL: TStringList;

  procedure FromTo(Filename: string);
    var FDT1, FDT2: TDateTime;
  begin
    From:= Source + Filename;
    To1 := Dest + Filename;
    if not FileExists(To1) or (FileAge(From, FDT1) and FileAge(To1, FDT2) and (FDT1 > FDT2)) then
      CopyFromTo(Source, Dest, Filename);
  end;

  procedure del(Filename: string);
  begin
    To1:= Dest + Filename;
    if FileExists(To1) then begin
      if DeleteFile(To1)
        then Memo.Lines.Add(From + ' deleted.')
        else Memo.Lines.Add('Unable to delete: ' + To1);
    end;
  end;

begin
  //Show;
  //Memo.Clear;
  Restart:= false;
  PortableApplication:= false;
  UserDir:= '';

  Dest   := IncludeTrailingPathDelimiter(UnHideBlanks(ParamStr(2)));
  Source := IncludeTrailingPathDelimiter(UnHideBlanks(ParamStr(3)));
  Source2:= UnHideBlanks(Paramstr(4));

  p1:= ParamStr(1);
  i:= 1;
  while (i < ParamCount) and (ParamStr(i) <> '-INI') do
    inc(i);
  if i < ParamCount then begin
    Machine:= UnhideBlanks(ParamStr(i+1));
    MachineIniFile:= TMemIniFile.Create(Machine);
    PortableApplication:= MachineIniFile.ReadBool('GuiPy', 'PortableApplication', false);
    UserDir:= MachineIniFile.ReadString('User', 'HomeDir', '');
    PortAppDrive:= ExtractFileDrive(Machine);   // with UNC we get \\Server\Freigabe
    if Pos(':', PortAppDrive) > 0 then
      PortAppDrive:= copy(PortAppDrive, 1, 1);
  end else begin
    Machine:= Dest + 'GuiPyMachine.ini';
    if FileExists(Machine) then begin
      MachineIniFile:= TMemIniFile.Create(Machine);
      PortableApplication:= MachineIniFile.ReadBool('GuiPy', 'PortableApplication', false);
      UserDir:= MachineIniFile.ReadString('User', 'HomeDir', '');
    end;
  end;

  p:= Pos('%USERNAME%', Uppercase(UserDir));
  if p > 0 then begin
    Delete(UserDir, p, 10);
    Insert(FSetup.GetUserName, UserDir, p);
  end;
  if UserDir = '' then
    UserDir:= TPath.Combine(TPath.GetHomePath, 'GuiPy\');
  if UserDir <> '' then
    UserDir:= IncludeTrailingPathDelimiter(UserDir);

  if ParamStr(1) = '-Registry' then begin
    SL:= Split('#', UnhideBlanks(ParamStr(2)));
    for i:= 0 to SL.Count - 1 do begin
      s:= SL.strings[i];
      if s = '' then continue;
      p:= Pos('|', s);
      Key:= copy(s, 1, p-1);
      delete(s, 1, p);
      p:= Pos('|', s);
      Name:= copy(s, 1, p-1);
      delete(s, 1, p);
      p:= Pos('|', s);
      Value:= copy(s, 1, p-1);
      delete(s, 1, p);
      Kind:= s;
      memo.lines.add('Key: ' + Key + ' name: ' + name + ' Value: ' + Value);
      case Kind[1] of
        's': WriteString(Key, Name, Value);
        'i': WriteInteger(Key, Name, StrToInt(Value));
      end;
    end;
  end
  else if ParamStr(1) = '-Update' then begin
    // FixUpdate;

    Error:= false;
    if Source2 <> '' then
      Memo.Lines.Add('Old Version: ' + Source2);
    Memo.Lines.Add('Source     : ' + Source);
    Memo.Lines.Add('Destination: ' + Dest);
    Memo.Lines.Add('');
    if Dest <> '' then
      SysUtils.ForceDirectories(Dest);
    if Pos('gpregistry', source) > 0 then
      ChangeGuiPyRegistration(Source2)
    else if Pos('registry', source) > 0 then
      ChangeRegistry(Dest, Source2)
    else begin
      Restart:= true;
      if Dest = '' then Exit;
      Sleep(2000); // let GuiPy terminate;
      Version:= Source2;

      if PortableApplication
        then ProgData:= Dest
        else ProgData:= TPath.Combine(TPath.GetPublicPath, 'GuiPy\');

      Screen.Cursor:= crHourGlass;
      try
        // ProgramData
        CopyFilesRecursive(TPath.Combine(Source, 'Scripts'), ProgData);

        WorkDir:= TPath.Combine(ProgData, 'Highlighters');
        if not DirectoryExists(WorkDir) then
          SysUtils.ForceDirectories(WorkDir);
        CopyFilesRecursive(TPath.Combine(Source, 'Highlighters'), WorkDir);

        WorkDir:= TPath.Combine(ProgData, 'Styles');
        if not DirectoryExists(WorkDir) then
          SysUtils.ForceDirectories(WorkDir);
        CopyFilesRecursive(TPath.Combine(Source, 'Styles'), WorkDir);

        WorkDir:= TPath.Combine(ProgData, 'Variable Inspectors');
        if not DirectoryExists(WorkDir) then
          SysUtils.ForceDirectories(WorkDir);
        CopyFilesRecursive(TPath.Combine(Source, 'Variable Inspectors'), WorkDir);

        WorkDir:= TPath.Combine(ProgData, 'Lsp\jls\');
        if not DirectoryExists(WorkDir) then
          SysUtils.ForceDirectories(WorkDir);
        CopyFilesRecursive(TPath.Combine(Source, 'Lib\Lsp\jls'), WorkDir);

        Path:=  TPath.Combine(WorkDir, 'jedilsp.exe');
        Parameter:= '-y';
        ShellExecute(Handle, 'open', PChar(Path), PChar(Parameter), nil, SW_Hide);

        // GuiPy
        WorkDir:= TPath.Combine(Dest, 'locale');
        if not DirectoryExists(WorkDir) then
          SysUtils.ForceDirectories(WorkDir);
        CopyFilesRecursive(TPath.Combine(Source, 'locale'), WorkDir);

        CopyFromTo(Source, Dest, 'DebugLayout.ini');
        CopyFromTo(Source, Dest, 'DefaultLayout.ini');
        CopyFromTo(Source, Dest, 'GuiPy.exe');
        CopyFromTo(Source, Dest, 'Setup.exe');
        CopyFromTo(Source, Dest, 'WebView2Loader.dll');
        if IsWebView2RuntimeNeeded then begin
          CopyFromTo(Source, ProgData, 'MicrosoftEdgeWebview2Setup.exe');
          var Params:= '/silent /install';
          ShellExecute(Handle, 'open',  PChar(ProgData + 'MicrosoftEdgeWebview2Setup.exe'),
            PChar(Params), PChar(ProgData), SW_Hide);
          TFile.Delete(ProgData + 'MicrosoftEdgeWebview2Setup.exe');
        end;

        WorkDir:= TPath.Combine(Dest, 'Lib\');
        if not DirectoryExists(WorkDir) then
          SysUtils.ForceDirectories(WorkDir);
        CopyFromTo(TPath.Combine(Source, 'Lib'), WorkDir, 'rpyc.zip');
      finally
        Screen.Cursor:= crDefault;
      end;
      try
        Memo.Lines.Add(TPath.Combine((ExtractFilePath(Dest)), 'update.txt'));
        Memo.Lines.SaveToFile(IncludeTrailingPathDelimiter(ExtractFilePath(Dest)) + 'update.txt');
      except on E: Exception do
         Memo.Lines.Add(E.Message);
      end;
    end;
  end;
end;
{$WARNINGS ON}

procedure TFUpdater.WriteString(key, name, value: String);
begin
  if ReadString(key, name, '') = value then exit;
  MachineIniFile.WriteString(key, name, value);
end;

function TFUpdater.ReadString(key, name, default: String): String;
begin
  Result:= MachineIniFile.ReadString(key, name, default);
end;

procedure TFUpdater.WriteInteger(key, name: String; value: Integer);
begin
  if ReadInteger(key, name, 0) = value then exit;
  MachineIniFile.WriteInteger(key, name, value)
end;

function TFUpdater.ReadInteger(key, name: String; default: Integer): Integer;
begin
  Result:= MachineIniFile.ReadInteger(key, name, default)
end;



end.
