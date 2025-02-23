{-------------------------------------------------------------------------------
 Unit:     UUtils
 Author:   Gerhard Röhner
 Date:     July 2000
 Purpose:  utility functions
-------------------------------------------------------------------------------}

unit UUtils;

interface

uses Windows, Classes, StdCtrls, Forms, SysUtils, Controls, Graphics,
     uEditAppIntfs;

type
  TVisibility = (viPrivate, viProtected, viPublic);

  TBoolEvent = procedure (Value: Boolean) of object;

const
  UTF8BOMString : RawByteString = AnsiChar($EF) + AnsiChar($BB) + AnsiChar($BF);


function CtrlPressed: Boolean;
procedure ErrorMsg(const s: string);
function myStringReplace(ImString: string; const DenString, DurchString: string): string;
function HideCrLf(const s: string): string;
function UnHideCrLf(const s: string): string;
function Split(Delimiter: Char; Input: string): TStringList;
function IsWriteProtected(const FileName: string): Boolean;
function dissolveUsername(const s: string): string;
function IsHTTP(const Pathname: string): Boolean;
procedure ComboBoxAdd(ComboBox: TComboBox);
procedure ComboBoxInsert(ComboBox: TComboBox);
procedure ComboBoxInsert2(ComboBox: TComboBox; const s: string);
procedure ComboBoxDelete2(ComboBox: TComboBox; const s: string);
function ComboBoxItemsSpeichern(s: string): string;
function ComboBoxItemsLaden(s: string): string;

function withoutTrailingSlash(const s: string): string;
function withTrailingSlash(const s: string): string;
function VistaOrBetter: Boolean;
function GetDocumentsPath: string;
procedure ErweiterePath(const s: string);
function  GetEnvironmentVar(const VarName: string): string;
procedure SetEnvironmentVar(const VarName, VarValue: string);
function GetTempDir: string;
function ExtractFilePathEx(const s: string): string;
function hasDefaultPrinter: Boolean;
procedure CreateMyFile(const Path: string);
function IsAdministrator: Boolean;
function HasAssociationWithGuiPy(const Extension: string): Boolean;
function getRegisteredGuiPy: string;
function HideBlanks(const s: string): string;
function UnHideBlanks(const s: string): string;
function GetLongPathName(const PathName: string): string;
function Left(const s: string; p: Integer): string;
function Right(const s: string; p: Integer): string;
function CountChar(c: char; const s: string): Integer;
function HasWriteAccess(const Directory: string): Boolean;
procedure SetPrinterIndex( i : Integer );
procedure PrintBitmap(FormBitmap: TBitmap; PixelsPerInch: Integer; PrintScale: TPrintScale = poProportional);
function ExplorerTest: Boolean;
function UpperLower(const s: string): string;
function IsWordBreakChar(C: Char): Boolean; overload;
function IsWordInLine(Word, Line: string): Boolean;
function IsDigit(c: char): Boolean;
function WindowStateToStr(W: TWindowState): string;
function StrToWindowState(const s: string): TWindowState;
function WithoutGeneric(s: string): string;
function getShortType(s: string): string;
function getShortTypeWith(s: string): string;
function getShortMethod(s: string): string;
function GenericOf(const s: string): string;
function VisibilityAsString(vis: TVisibility) : string;
function String2Visibility(const s: string): TVisibility;
function isPythonType(aType: string): Boolean;
function hasClassExtension(const Pathname: string): Boolean;
function hasPythonExtension(const Pathname: string): Boolean;
function ValidFilename(s: string): Boolean;
function max3(m1, m2, m3: Integer): Integer;
function min3(m1, m2, m3: Integer): Integer;
procedure LockFormUpdate(F: TForm);
procedure UnlockFormUpdate(F: TForm);
function WithoutArray(const s: string): string;
function IsUNC(const Pathname: string): Boolean;
function ExtractFileNameEx(s: string): string;
function StripHttpParams(const s: string): string;
function ToWindows(s: string): string;
function FileExistsCaseSensitive(const FileName: TFileName): Boolean;
function getFirstWord(s: string): string;
procedure SetAnimation(Value: Boolean);
function einruecken(Einrueck, s: string): string;
function isDunder(Name: string): Boolean;
function StringTimesN(s: string; n: Integer): string;
function GetUniqueName(Control: TControl; Basename: string): string;
function OnlyCharsAndDigits(const s: string): string;
function ToWeb(const Browser: string; s: string): string;
function StartsWith(const Str, Substr: string): Boolean;
function LowerUpper(const s: string): string;
function isLower(c: char): Boolean;
function WithoutSpaces(const s: string): string;
function ChangeColor(Color: TColor; percent: real): TColor;
function asString(s: string): string;
function isIdentifierChar(c: char): Boolean;
function LeftSpaces(s: string; tabW: Integer): Integer;
function RGB2Color(const R, G, B: Integer): Integer;
procedure Color2RGB(const Color: TColor; var R, G, B: Integer);
function WithoutLeadingUnderscores(s: string): string;
function GetNextPart(var s: string): string; overload;
function GetNextPart(var s: string; ch: char): string; overload;
function Visibility2ImageNumber(vis: TVisibility): Integer;
function IsVisibility(const s: string): Boolean;
function IsModifier(const s: string): Boolean;
function WithoutVisibility(s: string): string;
function IsSimpleType(const s: string): Boolean;
function ShellExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
function FilenameToFileKind(const FileName: string): TFileKind;
function RemovePortableDrive(const s: string; folder: string = ''): string;
function AddPortableDrive(const s: string; folder: string = ''): string;
function WriteLog(LogString: string): Integer;
function getProtocolAndDomain(url: string): string;
function IsHTML(const Pathname: string): Boolean;
function HttpToWeb(s: string): string;
function DownloadURL(const aUrl, aFile: string): Boolean;
procedure SetElevationRequiredState(aControl: TWinControl);
function DownloadFile(const SourceFile, DestFile: string): Boolean;
function MakeValidIdentifier(s: string): string;
function CanActuallyFocus(WinControl: TWinControl): Boolean;
function isNumber(var s: string): Boolean;
function isBool(s: string): Boolean;
procedure ReplaceResourceString(RStringRec: PResStringRec; const AString: string);
function DecToBase(nBase: Integer; nDecValue: double): string;
function ConvertLtGt(s: string): string;
function FloatToVal(x: real): string;
function StringToSingle(S: string): Single;
function PointToVal(P: TPoint): string;
function IntToVal(x: Integer): string;
function myColorToRGB(Color: TColor): string;
function XYToVal(x, y: Integer): string;
function CalcIndent(S : string; TabWidth : Integer = 4): Integer;
function encodeQuotationMark(const s: string): string;
function myMulDiv(nNumber, nNumerator, nDenominator: Integer): Integer;
procedure LockWindow(Handle: THandle);
procedure UnLockWindow;

implementation

uses Dialogs, UITypes, WinInet, Winapi.SHFolder, Registry, Printers, Math, Messages,
     ShellAPI, IOUtils, SHDocVw, URLMon, StrUtils,
     cPyScripterSettings, uCommonFunctions;

function CtrlPressed: Boolean;
begin
  Result:= (GetAsyncKeyState(VK_CONTROL) and $f000) <> 0;
end;

function HideCrLf(const s: string): string;
begin
  Result:= StringReplace(s, #13#10, '\r\n', [rfReplaceAll, rfIgnoreCase]);
end;

function UnhideCrLf(const s: string): string;
begin
  Result:= StringReplace(s, '\r\n', #13#10, [rfReplaceAll, rfIgnoreCase]);
end;

function myStringReplace(ImString: string; const DenString, DurchString: string): string;
begin
  Result:= StringReplace(ImString, DenString, DurchString, [rfReplaceAll, rfIgnoreCase]);
end;

procedure ErrorMsg(const s: string);
begin
  StyledMessageDlg(s, mtError, [mbOK], 0);
end;

function Split(Delimiter: Char; Input: string): TStringList;
  var p: Integer; SL: TStringList;
begin
  SL:= TStringList.Create;
  p:= Pos(Delimiter, Input);
  while p > 0 do begin
    SL.Add(Copy(Input, 1, p-1));
    Delete(Input, 1, p);
    p:= Pos(Delimiter, Input);
  end;
  SL.Add(Input);
  Result:= SL;
end;

function HasAttr(const FileName: string; Attr: Word): Boolean;
  var Fileattr: Integer;
begin
  Fileattr:= FileGetAttr(FileName);
  Result := (FileAttr and Attr) = Attr;
end;

function IsWriteProtected(const FileName: string): Boolean;
begin
  Result:= FileExists(FileName) and HasAttr(FileName, faReadOnly);
end;

procedure StrResetLength(var S: string);
var
  I: Integer;
begin
  for I := 0 to Length(S) - 1 do
    if S[I + 1] = #0 then
    begin
      SetLength(S, I);
      Exit;
    end;
end;

function GetLocalUserName: string;
var
  Count: DWORD;
begin
  Count := 256 + 1; // UNLEN + 1
  // set buffer size to 256 + 2 characters
  SetLength(Result, Count);
  if GetUserName(PChar(Result), Count) then
    StrResetLength(Result)
  else
    Result := '';
end;

function dissolveUsername(const s: string): string;
  var p: Integer; Username: string;
begin
  Result:= s;
  p:= Pos('%USERNAME%', UpperCase(Result));
  if p > 0 then begin
    Delete(Result, p, 10);
    Username:= GetLocalUsername;
    Insert(Username, Result, p);
  end;
end;

function IsHTTP(const Pathname: string): Boolean;
  var aPath: string;
begin
  aPath:= UpperCase(Pathname);
  Result:= (pos('HTTP://', aPath) + pos('RES://', aPath) + pos('HTTPS://', aPath) > 0);
end;

procedure ComboBoxAdd(ComboBox: TComboBox);
  var s: string; i: Integer;
begin
  s:= ComboBox.Text;
  ComboBox.Hint:= s;
  if s = '' then Exit;
  i:= ComboBox.Items.IndexOf(s);
  if i >= 0 then
    ComboBox.Items.Delete(i);
  ComboBox.Items.Insert(0, s);
  if ComboBox.Items.Count > 7 then
    ComboBox.Items.Delete(7);
  ComboBox.ItemIndex:= 0;
end;

procedure ComboBoxInsert(ComboBox: TComboBox);
  var s: string;
begin
  s:= Trim(ComboBox.Text);
  if (s <> '') and (ComboBox.Items.IndexOf(s) = -1) then
    ComboBox.Items.Add(s);
end;

procedure ComboBoxInsert2(ComboBox: TComboBox; const s: string);
begin
  if (s <> '') and (ComboBox.Items.IndexOf(s) = -1) then
    ComboBox.Items.Add(s);
end;

procedure ComboBoxDelete2(ComboBox: TComboBox; const s: string);
  var i: Integer;
begin
  i:= ComboBox.Items.IndexOf(s);
  if i >= 0 then
    ComboBox.Items.Delete(i);
end;

function withoutTrailingSlash(const s: string): string;
begin
  Result:= s;
  if (Copy(Result, Length(Result), 1) = '/') or (Copy(Result, Length(Result), 1) = '\') then
    SetLength(Result, Length(Result)-1);
end;

{$WARNINGS OFF}
function withTrailingSlash(const s: string): string;
begin
  Result:= withoutTrailingSlash(s);
  if IsHttp(Result)
    then Result:= Result + '/'
    else Result:= IncludeTrailingPathDelimiter(Result);
end;
{$WARNINGS ON}

function VistaOrBetter: Boolean;
begin
  result:= (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 6);
end;

function GetDocumentsPath: string;
const
  CSIDL_PERSONAL = $0005;
var
  LStr: array[0 .. MAX_PATH] of Char;
begin
  SetLastError(ERROR_SUCCESS);
  if SHGetFolderPath(0, CSIDL_PERSONAL, 0, 0, @LStr) = S_OK then
    Result := LStr;
end;

procedure ErweiterePath(const s: string);
  var path: string;
begin
  path:= GetEnvironmentVariable('PATH');
  if pos(s, path) = 0 then
    SetEnvironmentVariable('PATH', PChar(s + path));
end;

function GetEnvironmentVar(const VarName: string): string;
  var BufSize: Integer;
begin
  BufSize:= GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then begin
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
    end
  else
    Result := '';
end;

procedure SetEnvironmentVar(const VarName, VarValue: string);
begin
  SetEnvironmentVariable(PChar(VarName), PChar(VarValue));
end;

function ComboBoxItemsSpeichern(s: string): string;
  var p: Integer;
begin
  p:= Pos(#13#10, s);
  while p > 0 do begin
    Delete(s, p, 2);
    insert(';', s, p);
    p:= Pos(#13#10, s);
  end;
  Result:= s;
end;

function ComboBoxItemsLaden(s: string): string;
  var p: Integer;
begin
  p:= Pos(';', s);
  while p > 0 do begin
    Delete(s, p, 1);
    insert(#13#10, s, p);
    p:= Pos(';', s);
  end;
  Result:= s;
end;

function GetTempDir: string;
  var P: PChar;
begin
  P:= StrAlloc(255);
  GetTempPath(255, P);
  Result:= string(P);
  StrDispose(P);
end;

function IsCHM(const Pathname: string): Boolean;
begin
  Result:= (pos('.CHM', UpperCase(Pathname)) > 0);
end;

function ExtractFilePathEx(const s: string): string;
  var p: Integer;
begin
  if IsHttp(s) then begin
    p:= Length(s);
    while s[p] <> '/' do Dec(p);
    Result:= Copy(s, 1, p);
    end
  else
    Result:= ExtractFilePath(s);
  Result:= withoutTrailingSlash(Result);
end;

function GetExeForExtension(const Ext: string): string;
 var
   reg: TRegistry;
   s  : string;
   p  : Integer;
 begin
   s:= '';
   reg:= TRegistry.Create;
   reg.RootKey:= HKEY_LOCAL_MACHINE;
   reg.Access:= KEY_READ;
   try
     if reg.OpenKey('SOFTWARE\Classes\' + ext + '\shell\open\command', False) then
      begin
       {The open command has been found}
       s:= reg.ReadString('');
       reg.CloseKey;
     end
     else begin
       {perhaps there is a system file pointer}
       if reg.OpenKey('SOFTWARE\Classes\' + ext, False) then begin
         try
           s:= reg.ReadString('');
         except
           s:= '';
         end;
         reg.CloseKey;
         if s <> '' then begin
           {A system file pointer was found}
           if reg.OpenKey('SOFTWARE\Classes\' + s + '\Shell\Open\command', False) then
             {The open command has been found}
             s:= reg.ReadString('');
           reg.CloseKey;
         end;
       end;
     end;
   except
     s:= '';
   end;
   {Delete any command line, quotes and spaces}
   if Pos('%', s) > 0 then
     Delete(s, Pos('%', s), Length(s));
   s:= Trim(s);
   p:= Pos('.EXE', UpperCase(s));
   if p > 0 then Delete(s, p + 4, Length(s));
   p:= Pos('"', s);
   if p = 1 then begin
     Delete(s, 1, 1);
     p:= Pos('"', s);
     if p > 0 then Delete(s, p, Length(s));
   end;
   if FileExists(s)
     then Result:= s
     else Result:= '';
   FreeAndNil(reg);
 end;

 function hasDefaultPrinter: Boolean;
var
  ResStr: array[0..255] of Char;
  DefaultPrinter: string;
begin
  GetProfileString('Windows', 'device', '', ResStr, 255);
  DefaultPrinter:= StrPas(ResStr);
  Result:= (DefaultPrinter <> '');
end;

procedure CreateMyFile(const Path: string);
  var SL: TStringList;
begin
  if (Path <> '') and not FileExists(Path) then begin
    SL:= TStringList.Create;
    try
      try
        Sysutils.ForceDirectories(ExtractFilePath(Path));
        SL.SaveToFile(Path);
      except
        on e: Exception do
         Errormsg(e.Message);
      end;
    finally
      FreeAndNil(SL);
    end;
  end;
end;

const
  SECURITY_NT_AUTHORITY: TSidIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID  = ($00000020);
  DOMAIN_ALIAS_RID_ADMINS           = ($00000220);

function IsGroupMember(RelativeGroupID: DWORD): Boolean;
var
  psidAdmin: Pointer;
  Token: THandle;
  Count: DWORD;
  TokenInfo: PTokenGroups;
  HaveToken: Boolean;
  I: Integer;
const
  SE_GROUP_USE_FOR_DENY_ONLY = $00000010;
begin
  Result := not (Win32Platform = VER_PLATFORM_WIN32_NT);
  if Result then // Win9x and ME don't have user groups
    Exit;
  psidAdmin := nil;
  TokenInfo := nil;
  HaveToken := False;
  try
    Token := 0;
    HaveToken := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, Token);
    if (not HaveToken) and (GetLastError = ERROR_NO_TOKEN) then
      HaveToken := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, Token);
    if HaveToken then
    begin
      {$IFDEF FPC}
      Win32Check(AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, RelativeGroupID, 0, 0, 0, 0, 0, 0,
        psidAdmin));
      if GetTokenInformation(Token, TokenGroups, nil, 0, @Count) or
       (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
         RaiseLastOSError;
      TokenInfo := PTokenGroups(AllocMem(Count));
      Win32Check(GetTokenInformation(Token, TokenGroups, TokenInfo, Count, @Count));
      {$ELSE FPC}
      {$WARNINGS OFF}
      Win32Check(AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, RelativeGroupID, 0, 0, 0, 0, 0, 0,
        psidAdmin));
      if GetTokenInformation(Token, TokenGroups, nil, 0, Count) or
       (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
         RaiseLastOSError;
      TokenInfo := PTokenGroups(AllocMem(Count));
      Win32Check(GetTokenInformation(Token, TokenGroups, TokenInfo, Count, Count));
      {$WARNINGS ON}
      {$ENDIF FPC}
      for I := 0 to TokenInfo^.GroupCount - 1 do
      begin
        {$RANGECHECKS OFF} // Groups is an array [0..0] of TSIDAndAttributes, ignore ERangeError
        Result := EqualSid(psidAdmin, TokenInfo^.Groups[I].Sid);
        if Result then
        begin
          //consider denied ACE with Administrator SID
          Result := TokenInfo^.Groups[I].Attributes and SE_GROUP_USE_FOR_DENY_ONLY
              <> SE_GROUP_USE_FOR_DENY_ONLY;
          Break;
        end;
        {$IFDEF RANGECHECKS_ON}
        {$RANGECHECKS ON}
        {$ENDIF RANGECHECKS_ON}
      end;
    end;
  finally
    if TokenInfo <> nil then
      FreeMem(TokenInfo);
    if HaveToken then
      CloseHandle(Token);
    if psidAdmin <> nil then
      FreeSid(psidAdmin);
  end;
end;

function IsAdministrator: Boolean;
begin
  Result := IsGroupMember(DOMAIN_ALIAS_RID_ADMINS);
end;

function HasAssociationWithGuiPy(const Extension: string): Boolean;
  var s: string;
begin
  s:= UpperCase(GetExeForExtension(Extension));
  Result:= Pos(UpperCase(ExtractFilename(ParamStr(0))), s) > 0;
end;

function getRegisteredGuiPy: string;
 var reg: TRegistry;
begin
  reg:= TRegistry.Create;
  reg.RootKey:= HKEY_LOCAL_MACHINE;
  reg.Access:= KEY_READ;
  if reg.OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', False)
    then Result:= reg.ReadString('')
    else Result:= '';
  reg.CloseKey;
  var p:= Pos(' "%1"', Result);
  if p > 0 then
    Result:= Copy(Result, 1, p-1);
  FreeAndNil(reg);
end;

function HideBlanks(const s: string): string;
begin
  if (Pos(' ', s) > 0) and (Pos('"', s) <> 1)
    then Result:= AnsiQuotedStr(s, '"')
    else Result:= s;
end;

function UnHideBlanks(const s: string): string;
begin
  Result:= AnsiDequotedStr(s, '"');
end;

function GetLongPathName(const PathName: string): string;
var
  Drive: string;
  Path: string;
  SearchRec: TSearchRec;
begin
  if PathName = '' then
    Exit;
  Drive := ExtractFileDrive(PathName);
  Path := Copy(PathName, Length(Drive) + 1, Length(PathName));
  if (Path = '') or (Path = '\') then
  begin
    Result := PathName;
    if Result[Length(Result)] = '\' then
      Delete(Result, Length(Result), 1);
  end
  else
  begin
    Path := GetLongPathName(ExtractFileDir(PathName));
    if FindFirst(PathName, faAnyFile, SearchRec) = 0 then
    begin
      {$WARNINGS OFF}
      Result := Path + '\' + SearchRec.FindData.cFileName;
      {$WARNINGS ON}
      SysUtils.FindClose(SearchRec);
    end
    else
      Result := Path + '\' + ExtractFileName(PathName);
  end;
end;

function Left(const s: string; p: Integer): string;
begin
  if p >= 0
    then Result:= Copy(s, 1, p)
    else Result:= Copy(s, 1, Length(s)+p);
end;

function Right(const s: string; p: Integer): string;
begin
  if p >= 0
    then Result:= Copy(s, p, Length(s))
    else Result:= Copy(s, Length(s)+p+1, Length(s));
end;

function CountChar(c: char; const s: string): Integer;
  var i: Integer;
begin
  Result:= 0;
  for i:= 1 to Length(s) do
    if s[i] = c then Inc(Result);
end;

function HasWriteAccess(const Directory: string): Boolean;
  var FS: TFileStream; s: string;
begin
  s:= withTrailingSlash(Directory) + 'wa_test.$$$';
  try
    FS:= TFileStream.Create(s, fmCreate or fmShareExclusive);
    FreeAndNil(FS);
    Result:= DeleteFile(PChar(s));
  except
    Result:= False;
  end;
end;


procedure SetPrinterIndex(i: Integer);
  var Device, Driver, Port: array[0..79] of char;
      Dest: PChar; DeviceMode: THandle;
begin
  try
    Printer.PrinterIndex := i;

    // TSetupPrinter only seems to look to the DeviceMode.dmDeviceName field
    // when setting up the initial printer, hence we make sure this field
    // contains the correct value.
    // This is a bug fix around the error in the delphi library,
    // as it does not use the DevNames structure correctly
    Printer.GetPrinter(Device, Driver, Port, DeviceMode);
    if DeviceMode <> 0 then begin
      Dest:= GlobalLock(DeviceMode);
      StrCopy(Dest, Device);
      GlobalUnlock(DeviceMode);
    end;
  except
  end;
end;

procedure PrintBitmap(FormBitmap: TBitmap; PixelsPerInch: Integer; PrintScale: TPrintScale = poProportional);
var
  InfoSize: DWORD;
  ImageSize: DWORD;
  Bits: HBITMAP;
  DIBWidth, DIBHeight: Longint;
  PrintWidth, PrintHeight: Longint;
  Info: PBitmapInfo;
  Image: Pointer;
begin
  // analog to TCustomForm.Print
  Printer.BeginDoc;
  try
    FormBitmap.Canvas.Lock;
    try
      with Printer do begin
        Bits := FormBitmap.Handle;
        GetDIBSizes(Bits, InfoSize, ImageSize);
        Info := AllocMem(InfoSize);
        try
          Image := AllocMem(ImageSize);
          try
            GetDIB(Bits, 0, Info^, Image^);
          with Info.bmiHeader do
          begin
            DIBWidth := biWidth;
            DIBHeight := biHeight;
          end;
          case PrintScale of
            poProportional:
              begin
                PrintWidth := MulDiv(DIBWidth, GetDeviceCaps(Handle,
                  LOGPIXELSX), PixelsPerInch);
                PrintHeight := MulDiv(DIBHeight, GetDeviceCaps(Handle,
                  LOGPIXELSY), PixelsPerInch);
              end;
            poPrintToFit:
              begin
                PrintWidth := MulDiv(DIBWidth, PageHeight, DIBHeight);
                if PrintWidth < PageWidth then
                  PrintHeight := PageHeight
                else
                begin
                  PrintWidth := PageWidth;
                  PrintHeight := MulDiv(DIBHeight, PageWidth, DIBWidth);
                end;
              end;
          else
            PrintWidth := DIBWidth;
            PrintHeight := DIBHeight;
          end;
            StretchDIBits(Canvas.Handle, 0, 0, PrintWidth, PrintHeight, 0, 0,
              DIBWidth, DIBHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
          finally
            FreeMem(Image, ImageSize);
          end;
        finally
          FreeMem(Info, InfoSize);
        end;
      end;
    finally
      FormBitmap.Canvas.Unlock;
    end;
  finally
    Printer.EndDoc;
  end;
end;

function ExplorerTest: Boolean;
  var Web: TWebBrowser;
begin
  try
    Web:= TWebBrowser.Create(nil);
    try
      Result:= Assigned(Web);
    finally
      FreeAndNil(Web);
    end;
  except
    Result:= False;
  end;
end;

function UpperLower(const s: string): string;
begin
  Result:= UpperCase(Copy(s, 1, 1)) + Copy(s, 2, Length(s));
end;

function IsWordBreakChar(C: Char): Boolean;  // fromSyneditSearch
begin
  case C of
    #0..#32,
    '.',
    ',',
    ';',
    ':',
    '"',
    '''',
    '´',
    '`',
    '°',
    '^',
    '!',
    '?',
    '&',
    '$', '@', '§', '%', '#', '~', '[', ']', '(', ')', '{', '}', '<', '>',
    '-', '=', '+', '*', '/', '\', '|':
      Result := True;
    else
      Result := False;
  end;
end;

function IsWordInLine(Word, Line: string): Boolean;
  var p, q: Integer;
begin
  Result:= False;
  p:= Pos(Word, Line);
  if p > 0 then begin
    q:= p + Length(Word);
    Result:= ((p = 1) or (p > 1) and IsWordBreakChar(Line[p-1])) and
             ((q > Length(Line)) or IsWordBreakChar(Line[q]));
  end;
end;

function IsDigit(C: Char): Boolean;
begin
  Result:= ('0' <= C) and (C <= '9');
end;

function WindowStateToStr(W: TWindowState): string;
begin
  Result:= IntToStr(Ord(W));
end;

function StrToWindowState(const s: string): TWindowState;
begin
  if s = '0' then Result:= wsNormal else
  if s = '1' then Result:= wsMinimized else
                  Result:= wsMaximized;
end;

function WithoutGeneric(s: string): string;
  var p1, p2: Integer;
begin
  p1:= Pos('<', s);
  if p1 > 0 then begin
    p2:= Length(s);
    while (p2 > 0) and (s[p2] <> '>') do
      Dec(p2);
    Delete(s, p1, p2-p1+1);
  end;
  if Pos('...', s) > 0
    then s:= Copy(s, 1, Pos('...', s) -1);
  Result:= s;
end;

function GetShortType(s: string): string;
  var p: Integer;
begin
  p:= Pos('.', s);
  if p > 0 then Delete(s, 1, p);
  Delete(s, 1, LastDelimiter('.', s));
  p:= Pos('<', s);
  if p > 1 then
    s:= Copy(s, 1, p-1);
  Result:= s;
end;

function GetShortTypeWith(s: string): string;
  var p: Integer;
begin
  p:= Pos('.', s);
  if p > 0 then Delete(s, 1, p);
  Delete(s, 1, LastDelimiter('.', s));
  Result:= s;
end;

function GetShortMethod(s: string): string;
  var p: Integer; s1: string;
begin
  p:= Pos('throws ', s);
  if p > 0 then s:= Trim(Copy(s, 1, p-1));
  p:= Pos('(', s);
  s1:= getShortTypeWith(Left(s, p-1)) + '(';
  s:= Copy(s, p+1, Length(s) - p -1) + ',';
  p:= Pos(',', s);
  while p > 0 do begin
    s1:= s1 + GetShortTypeWith(Left(s, p-1)) + ', ';
    Delete(s, 1, p);
    p:= Pos(',', s);
  end;
  Result:= Left(s1, -2) + ')';
end;

function GenericOf(const s: string): string;
  var p: Integer;
begin
  Result:= '';
  p:= Pos('<', s);
  if p > 0 then
    Result:= Copy(s, p+1, Length(s) - p - 1);
end;

function VisibilityAsString(vis: TVisibility) : string;
begin
  case vis of
    viPrivate:   Result:= '__';
    viProtected: Result:= '_';
  else           Result:= '';
  end;
end;

function String2Visibility(const s: string): TVisibility;
  var Underscores: Integer;
begin
  Underscores:= 0;
  if (Length(s) > 0) and (s[1] = '_') then begin
    Underscores:= 1;
    if (Length(s) > 1) and (s[2] = '_') then
      Underscores:= 2;
  end;
  case Underscores of
    0: Result:= viPublic;
    1: Result:= viProtected;
  else Result:= viPrivate;
  end;
end;

function isPythonType(aType: string): Boolean;
  const PythonTypes : array[0..39] of string =
     ('None', 'int', 'float', 'complex', 'str', 'bool', 'list', 'tuple', 'range',
      'set', 'dict', 'bytes', 'bytearray', 'memoryview', 'frozenset',
      'Optional', 'Callable', 'Type', 'Literal', 'ClassVar',
      'Annotated', 'Generic', 'TypeVar', 'AnyStr', 'Protocol', 'Dict', 'List',
      'Set', 'FrozenSet', 'DefaultDict', 'OrderedDict', 'ChainMap', 'Counter',
      'Deque', 'IO', 'TextIO', 'BinaryIO', 'Pattern', 'Match', 'Text' );
  var p: Integer;
begin
  p:= Pos('[', aType); // GenericType?
  if p > 0 then Delete(aType, p, Length(aType));
  for p:= 0 to 39 do
    if PythonTypes[p] = aType then
      Exit(True);
  Result:= False;
end;

function hasClassExtension(const Pathname: string): Boolean;
begin
  Result:= (pos('.class', Pathname) > 0);
end;

function hasPythonExtension(const Pathname: string): Boolean;
begin
  Result:= (pos('.py', Pathname) > 0);
end;

function ValidFilename(s: string): Boolean;
begin
  s:= UpperCase(ChangeFileExt(ExtractFilename(s), ''));
  Result:= (s <> 'CON') and (s <> 'PRN') and (s <> 'AUX') and (s <> 'NUL');
end;

function max3(m1, m2, m3: Integer): Integer;
begin
  Result:= Max(m1, Max(m2, m3));
end;

function min3(m1, m2, m3: Integer): Integer;
begin
  Result:= Min(m1, Min(m2, m3));
end;

var FLockFormUpdatePile : Integer;

procedure LockFormUpdate(F: TForm);
begin
  if Assigned(F) then begin
    if FLockFormUpdatePile = 0 then
      F.Perform(WM_SetRedraw, 0, 0);
    Inc(FLockFormUpdatePile);
  end;
end;

procedure UnlockFormUpdate(F: TForm);
begin
  if Assigned(F) then begin
    Dec(FLockFormUpdatePile);
    if FLockFormUpdatePile = 0 then begin
      F.Perform(WM_SetRedraw, 1, 0);
      RedrawWindow(F.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE +
        RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);
    end;
  end;
end;

function WithoutArray(const s: string): string;
  var i: Integer;
begin
  Result:= s;
  i:= Pos('[', Result) + Pos('...', Result);
  if i > 0
    then Result:= Copy(Result, 1, i-1)
end;

function IsUNC(const Pathname: string): Boolean;
begin
  Result:= (pos('\\', Pathname) = 1);
end;

function ExtractFileNameEx(s: string):string;
  var i: Integer;
begin
  if Pos('file:///', s) > 0 then begin
    Delete(s, 1, 8);
    s:= myStringReplace(s, '/', '\');
  end;
  s:= StripHttpParams(s);
  if IsHttp(s) then begin
    i:= Length(s);
    while (s[i] <> '/') do Dec(i);
    Delete(s, 1, i);
    if s = '' then s:= 'index.html';
  end
  else if IsCHM(s) then begin
    i:= Pos('.CHM', UpperCase(s));
    Delete(s, 1, i+3);
    if Copy(s, 1, 2) = '::' then
      Delete(s, 1, 2);
    s:= ExtractFileName(toWindows(s))
    end
  else
    s:= ExtractFileName(s);
  Result:= s;
end;

function StripHttpParams(const s: string): string;
    var i: Integer; fname: string;
begin
  fname:= ExtractFilename(s);
  i:= Pos('?', fname);
  if i > 0 then Delete(fname, i, Length(fname));
  i:= Pos('#', fname);
  if i > 0 then Delete(fname, i, Length(fname));
  Result:= ExtractFilePath(s) + fname;
end;

function ToWindows(s: string): string;
  var p: Integer;
begin
  p:= pos('/', s);
  while p > 0 do begin
    s[p]:= '\';
    p:= pos('/', s);
  end;
  Result:= s;
end;

function FileExistsCaseSensitive(const FileName: TFileName): Boolean;
  var SR: TSearchRec;
begin
  Result:= FindFirst(FileName, faAnyFile, SR) = 0;
  if Result then Sysutils.FindClose(SR);
  Result:= Result and (SR.Attr and faDirectory = 0) and (SR.Name = ExtractFileName(FileName));
end;

function getFirstWord(s: string): string;
  var i: Integer;
begin
  s:= Trim(s);
  i:= 1;
  while (i <= Length(s)) and not IsWordBreakChar(s[i]) do
    Inc(i);
  Result:= Copy(s, 1, i-1);
end;

procedure SetAnimation(Value: Boolean);
  var Info: TAnimationInfo;
begin
  Info.cbSize:= SizeOf(TAnimationInfo);
  Bool(Info.iMinAnimate):= Value;
  SystemParametersinfo(SPI_SETANIMATION, SizeOf(Info), @Info, 0);
end;

function einruecken(Einrueck, s: string): string;
  var SL: TStringList; i: Integer;
begin
  SL:= TStringList.Create;
  SL.Text:= s;
  for i:= 0 to SL.Count - 1 do
    SL[i]:= Einrueck + SL[i];
  Result:= SL.Text;
  FreeandNil(SL);
end;

function isDunder(Name: string): Boolean;
begin
  Result:= (Copy(Name, 1, 2) = '__') and
           (Copy(Name, Length(Name) - 1, 2) = '__');
end;

function StringTimesN(s: string; n: Integer): string;
  var i: Integer;
begin
  Result:= '';
  for i:= 1 to n do
    Result:= Result + s;
end;

function changeVowels(const s: string): string;
  const Vowels = 'ÄÖÜäöüß';
  const Nowels = 'AOUaous';
  var i, p: Integer;
begin
  Result:= s;
  for i:= 1 to Length(Vowels) do begin
    p:= Pos(Vowels[i], Result);
    while p > 0 do begin
      Result[p]:= Nowels[i];
      if i < 7
        then insert('e', Result, p+1)
        else insert('s', Result, p+1);
      p:= Pos(Vowels[i], Result);
    end;
  end;
end;

function GetUniqueName(Control: TControl; Basename: string): string;
  var i: Integer; s: string;
begin
  BaseName:= OnlyCharsAndDigits(changeVowels(Basename));
  if Control.FindComponent(BaseName) = nil then begin
    Result:= BaseName;
    Exit;
  end;
  s:= Right(BaseName, -1);
  while (Pos(s, '0123456789') > 0) and (Length(BaseName) > 2) do begin
    BaseName:= Left(Basename, Length(Basename) - 1);
    s:= Right(BaseName, -1);
  end;
  Result:= Basename;
  i:= 0;
  while Control.FindComponent(Result) <> nil do begin
    Inc(i);
    Result:= BaseName + IntToStr(i);
  end;
end;

function OnlyCharsAndDigits(const s: string): string;
  var i: Integer; c: char;
begin
  Result:= '';
  for i:= 1 to Length(s) do begin
    c:= s[i];
    if not IsWordBreakChar(c) then
      Result:= Result + c;
  end;
end;

function CodeSpaces(s: string): string;
  var i: Integer;
begin
  for i:= Length(s) downto 1 do
    if s[i] = ' ' then begin
      Delete(s, i, 1);
      insert('%20', s, i);
    end;
  Result:= s;
end;

function toWeb(const Browser: string; s: string): string;
  var p: Integer;
      IsUNC, IsLaufwerk: Boolean;
begin
  IsUNC:= (Copy(s, 1, 2) = '\\');
  IsLaufwerk:= (Copy(s, 2, 1) = ':');
  s:= CodeSpaces(s);
  p:= pos('\', s);
  while p > 0 do begin
    s[p]:= '/';
    p:= pos('\', s);
  end;
  if IsUNC then
    if Pos('OPERA', UpperCase(Browser)) > 0
      then s:= 'file:' + s
      else s:= 'file://localhost/' + s;
  if isLaufwerk then
    s:= 'file:///' + s;
  Result:= s;
end;

function StartsWith(const Str, Substr: string): Boolean;
begin
  if Str <> ''
    then Result:= CompareStr(Copy(Str, 1, Length(SubStr)), SubStr) = 0
    else Result:= False;
end;

function LowerUpper(const s: string): string;
begin
  Result:= LowerCase(Copy(s, 1, 1)) + Copy(s, 2, Length(s));
end;

function isLower(c: char): Boolean;
begin
  Result:= CharInSet(c, ['a'..'z']);
end;

function WithoutSpaces(const s: string): string;
begin
  Result:= myStringReplace(s, ' ', '');
end;

function RGB2Color(const R, G, B: Integer): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

procedure Color2RGB(const Color: TColor; var R, G, B: Integer);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

function ChangeColor(Color: TColor; percent: real): TColor;
  var r, g, b: Integer;
begin
  r:= 0; g:= 0; b:= 0;
  Color2RGB(Color, r, g, b);
  r:= round(r * percent); if r > 255 then r:= 255;
  g:= round(g * percent); if g > 255 then g:= 255;
  b:= round(b * percent); if b > 255 then b:= 255;
  Result:= RGB2Color(r, g, b);
end;

function asString(s: string): string;
begin
  Result:= '''' + s + '''';
end;

function isIdentifierChar(c: char): Boolean;
begin
  Result:= CharInSet(c, ['a'..'z', 'A'..'Z', '0'..'9', '_']);
end;

function LeftSpaces(s: string; tabW: Integer): Integer;
  var
    p: PWideChar;
begin
  p := PWideChar(s);
  if Assigned(p) then
  begin
    Result := 0;
    while (p^ >= #1) and (p^ <= #32) do
    begin
      if (p^ = #9) then
        Inc(Result, TabW)
      else
        Inc(Result);
      Inc(p);
    end;
  end
  else
    Result := 0;
end;

function WithoutLeadingUnderscores(s: string): string;
  var p: Integer;
begin
  p:= 1;
  while (p <= Length(s)) and (s[p] = '_') do
    Inc(p);
  Result:= Copy(s, p, Length(s));
end;

function GetNextPart(var s: string; ch: char): string;
  var q, p, bracket: Integer;
begin
  p:= Pos(ch, s);
  if p = 0 then p:= Length(s)+1;
  q:= Pos('<', s); // generic part
  if (0 < q) and (q < p) then begin
    bracket:= 1;
    Inc(q);
    while (q <= Length(s)) and (bracket > 0) do begin
      if s[q] = '<' then Inc(bracket) else
      if s[q] = '>' then Dec(bracket);
      Inc(q);
    end;
    while (q <= Length(s)) and (s[q] <> ch) do
      Inc(q);
    p:= q;
  end;
  Result:= Copy(s, 1, p-1);
  Delete(s, 1, p);
end;

function GetNextPart(var s: string): string;
begin
  result:= GetNextPart(s, ' ');
end;

function Visibility2ImageNumber(vis: TVisibility): Integer;
begin
  case vis of
    viPrivate:   Result:= 7;
    viProtected: Result:= 8;
  else           Result:= 10;
  end;
end;

function IsVisibility(const s: string): Boolean;
  const visibilities: array[1..3] of string = ('__', '_', '');
  var i: Integer;
begin
  Result:= False;
  for i:= 1 to 3 do
    if s = visibilities[i] then begin
      Result:= True;
      Exit;
    end;
end;

function IsModifier(const s: string): Boolean;
  const Modifiers : array[1..3] of string =
    ('static', 'abstract', 'final');
  var i: Integer;
begin
  Result:= False;
  for i:= 1 to 3 do
    if s = Modifiers[i] then begin
      Result:= True;
      Exit;
    end;
end;

function WithoutVisibility(s: string): string;
  var p: Integer;
begin
  while (Length(s) > 0) and (s[1] = '_') do
    Delete(s, 1, 1);
  p:= Pos('__', s);
  if p > 0 then
    Delete(s, 1, p+1);
  Result:= s;
end;

function IsSimpleType(const s: string): Boolean;
  const simpleTypePython: array[1..4] of string =
          ('integer', 'boolean', 'float', 'string');
  var i: Integer;
begin
  Result:= True;
  for i:= 1 to 4 do
    if simpletypePython[i] = s then Exit;
  Result:= False;
end;

function ShellExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
begin
  Result:= ShellExecute(Application.MainForm.Handle, 'open',
             PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
end;

function FilenameToFileKind(const FileName: string): TFileKind;
  var Extension: string;
begin
  Result:= fkEditor;
  Extension:= TPath.GetExtension(FileName);
  if isHttp(FileName) then
    Result:= fkBrowser
  else if Extension = '.puml' then
    Result:= fkUML
  else if Extension = '.py' then
    Result:= fkEditor
  else if Extension = '.psd' then
    Result:= fkSequencediagram
  else if Extension = '.psg' then
    Result:= fkStructogram;
end;

{--- Portable -----------------------------------------------------------------}

function RemovePortableDrive(const s: string; folder: string = ''): string;
  // if folder is set then switch to relative paths, used in Store/FetchDiagram
  var SL1, SL2: TStringList;
      i, j: Integer; Basefolder: string;
begin
  Result:= s;
  if TPyScripterSettings.IsPortable
    then Basefolder:= ExtractFilePath(Application.ExeName)
    else Basefolder:= folder;
  // same drive
  if TPath.isDriveRooted(Basefolder) and
    (UpperCase(Copy(Basefolder, 1, 2)) = UpperCase(Copy(s, 1, 2)))
  then begin
    SL1:= Split('\', withoutTrailingSlash(Basefolder));
    SL2:= Split('\', withoutTrailingSlash(s));
    i:= 0;
    while (i < SL1.Count) and (i < SL2.Count) and
          (UpperCase(SL1[i]) = UpperCase(SL2[i])) do
      Inc(i);
    Result:= '';
    j:= i;
    while i < SL1.Count do begin
      Result:= Result + '..\';
      Inc(i);
    end;
    while j < SL2.Count do begin
      Result:= Result + SL2[j] + '\';
      Inc(j);
    end;
    Result:= withoutTrailingSlash(Result);
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

function AddPortableDrive(const s: string; folder: string = ''): string;
  // if folder is set then switch to relative paths, used in Store/FetchDiagram
  var SL1, SL2: TStringList;
      i, j: Integer; Basefolder: string;
begin
  Result:= s;
  if (UUtils.Left(s, 4) = 'its:') or ( s = '') or
     (Copy(s, 2, 2) = ':\') or (Copy(s, 1, 7) = 'file://') or // absolute path
     (Pos('\\', s) = 1) or (Pos('://', s) > 1) then // UNC or https:// or http://
    Exit;

  if TPyScripterSettings.IsPortable
    then Basefolder:= ExtractFilePath(Application.ExeName)
    else Basefolder:= folder;

  if Basefolder <> '' then begin
    SL1:= Split('\', withoutTrailingSlash(Basefolder));
    SL2:= Split('\', withoutTrailingSlash(s));
    i:= 0;
    while (i < SL2.Count) and (SL2[i] = '..') do
      Inc(i);
    Result:= SL1[0];
    for j:= 1 to SL1.Count - 1 - i do
      Result:= Result + '\' + SL1[j];
    for j:= i to SL2.Count - 1 do
      Result:= Result + '\' + SL2[j];
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

function WriteLog(LogString: string): Integer;
const
 LOGFILE = 'LogFile.log';
var
  f: TextFile;
begin
{$IOChecks OFF}
  AssignFile(f, ExtractFilePath(ParamStr(0))+LOGFILE);
  if FileExists(ExtractFilePath(ParamStr(0))+LOGFILE) then
    Append(f)
  else
    Rewrite(f);
  Writeln(f, LogString);
  CloseFile(f);
  result := GetLastError();
{$IOCHECKS ON}
end;

function getProtocol(url: string): string;
  var p: Integer;
begin
  p:= Pos('://', url);
  if p > 0
    then Result:= Copy(url, 1, p + 2)
    else Result:= '';
end;

function getProtocolAndDomain(url: string): string;
  var p: Integer; protocol: string;
begin
  protocol:= getProtocol(url);
  Delete(url, 1, Length(protocol));
  p:= Pos('/', url);
  if p > 0
    then Result:= protocol + Copy(url, 1, p-1)
    else Result:= protocol + url;
end;

function IsHTML(const Pathname: string): Boolean;
begin
  Result:= (Pos('.HTM', UpperCase(ExtractFileExt(Pathname))) > 0);
end;

function HttpToWeb(s: string): string;
  var p: Integer;
begin
  p:= pos('\', s);
  while p > 0 do begin
    s[p]:= '/';
    p:= pos('\', s);
  end;
  Result:= s;
end;

// needs WinInet
function DownloadURL(const aUrl, aFile: string): Boolean;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  lpBuffer: array[0..1024 + 1] of Char;
  dwBytesRead: DWORD;
  Datei: TFileStream;
begin
  Result:= False;
  try
    Datei:= TFileStream.Create(aFile, fmCreate or fmShareExclusive);
    hSession:= InternetOpen('Java-Editor', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    try
      if Assigned(hSession) then begin                                                       // keine Cache-Benutzung!
        hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
        if Assigned(hService) then
          try
            while True do begin
              dwBytesRead := 1024;
              InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
              if dwBytesRead = 0 then Break;
              Application.ProcessMessages;
              Datei.Write(lpBuffer[0], dwBytesRead);
            end;
            Result := True;
          finally
            InternetCloseHandle(hService);
          end;
      end;
    finally
      InternetCloseHandle(hSession);
      FreeAndNil(Datei);
    end;
  except
    on e: Exception do
      ErrorMsg(e.Message);
  end;
end;

procedure SetElevationRequiredState(aControl: TWinControl);
  const BCM_FIRST = $1600;
        BCM_SETSHIELD = BCM_FIRST + $000C;
begin
  SendMessage(aControl.Handle, BCM_SETSHIELD, 0, Integer(True));
end;

// needs URLMon
function DownloadFile(const SourceFile, DestFile: string): Boolean;
begin
  try
    Result:= UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, nil) = 0;
  except
    Result:= False;
  end;
end;

function MakeValidIdentifier(s: string): string;
  var i: Integer;
begin
  for i := Length(s) downto 1 do
    if not CharInSet(s[i], ['a'..'z','A'..'Z', '0'..'9', '_']) then
      Delete(s, i, 1);
  Result:= s;
end;

function CanActuallyFocus(WinControl: TWinControl): Boolean;
var
  Form: TCustomForm;
begin
  Result := False;
  if Assigned(WinControl) and not WinControl.Focused then begin
    Form := GetParentForm(WinControl);
    if Assigned(Form) and Form.Enabled and Form.Visible then
      Result := WinControl.CanFocus;
  end;
end;

function isNumber(var s: string): Boolean;
  var d: Double; p: Integer;
begin
  p:= Pos('.', s);
  if p > 0 then
    s[p]:= FormatSettings.DecimalSeparator;
  Result:= TryStrToFloat(s, d);
  p:= Pos(FormatSettings.DecimalSeparator, s);
  if p > 0 then
    s[p]:= '.';
end;

function isBool(s: string): Boolean;
begin
  Result:= (s = 'True') or (s = 'False');
end;

procedure ReplaceResourceString(RStringRec: PResStringRec; const AString: string);
  var OldProtect: Cardinal;
begin
  if (RStringRec = nil) or (Length(AString) = 0) then Exit;
  if VirtualProtect(RStringRec, SizeOf(RStringRec^), PAGE_EXECUTE_READWRITE, @OldProtect) then begin
    RStringRec^.Identifier:= Integer(PChar(AString));
    VirtualProtect(RStringRec, SizeOf(RStringRec^), OldProtect, @OldProtect);
  end
  else ErrorMsg(SysErrorMessage(GetLastError));
end;

function DecToBase(nBase: Integer; nDecValue: double): string;
{Function   : converts decimal integer to base n, max = Base36
 Parameters : nBase     = base number, ie. Hex is base 16
              nDecValue = decimal to be converted
              LeadZeros = min number of digits if leading zeros required
 Returns    : number in base n as string}
  var BaseString, DecToStr, f: string;
      Modulus, p, IntVal, FracVal: Integer;
      negative: Boolean;
begin
  Result:= '';
  BaseString:= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'; {max = Base36}
  if nDecValue < 0 then begin
    negative:= True;
    nDecValue:= -nDecValue;
  end else
    negative:= False;
  DecToStr:= FloatToStrF(nDecValue, ffGeneral, 15, 8);
  p:= Pos('.', DecToStr);
  if p > 0 then begin
    IntVal:= StrToInt(Copy(DecToStr, 1, p-1));
    FracVal:= StrToInt(Copy(DecToStr, p +1 , Length(DecToStr)));
  end else begin
    IntVal:= StrToInt(DecToStr);
    FracVal:= 0;
  end;
  while IntVal > 0 do begin
    Modulus:= IntVal mod nBase; {remainder is next digit}
    Result:= BaseString[Modulus+1] + Result;
    IntVal:= IntVal div nBase;
  end;
  if (FracVal > 0) and (nBase = 10) then begin
    f:= '';
    while FracVal > 0 do begin
      Modulus:= FracVal mod nBase; {remainder is next digit}
      f:= BaseString[Modulus+1] + f;
      FracVal:= FracVal div nBase;
    end;
    Result:= Result + '.' + f;
  end;
  if Result = '' then
    Result:= '0';
  if negative then Result:= '-' + Result;
end;

function ConvertLtGt(s: string): string;
begin
  Result:= ReplaceStr(ReplaceStr(s, '<', '&lt;'), '>', '&gt;');
end;

function FloatToVal(x: real): string;
begin
  Result:= '"' + FloatToStr(x) + '"';
  var p:= Pos(',', Result);
  if p > 0 then
    Result[p]:= '.';
end;

function PointToVal(P: TPoint): string;
begin
  Result:= IntToStr(P.x) + ',' + IntToStr(P.y) + ' ';
end;

function IntToVal(x: Integer): string;
begin
  Result:= '"' + IntToStr(x) + '"';
end;

function myColorToRGB(Color: TColor): string;
  var ColorInt, r, g, b: Integer;
begin
  ColorInt:= ColorToRGB(Color);
  r:= GetRValue(ColorInt);
  g:= GetGValue(ColorInt);
  b:= GetBValue(ColorInt);
  Result:= 'rgb(' + IntToStr(r) + ',' + IntToStr(g) + ',' + IntToStr(b) + ')';
end;

function XYToVal(x, y: Integer): string;
begin
  Result:= IntToStr(x) + ',' + IntToStr(y) + ' ';
end;

function CalcIndent(S : string; TabWidth : Integer = 4): Integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 1 to Length(S) do
    if S[i] = WideChar(#9) then
      Inc(Result, TabWidth)
    else if S[i] = ' ' then
      Inc(Result)
    else
      Break;
end;

function encodeQuotationMark(const s: string): string;
begin
  Result:= ReplaceStr(s, '"', '&quot;');
end;

function myMulDiv(nNumber, nNumerator, nDenominator: Integer): Integer;
begin
  Result:= MulDiv(nNumber, nNumerator, nDenominator);
end;

procedure LockWindow(Handle: THandle);
begin
  LockWindowUpdate(Handle);
end;

procedure UnlockWindow;
begin
  LockWindowUpdate(0);
end;

function StringToSingle(S: string): Single;
var
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';
  S := StringReplace(S, ',', '.', [rfReplaceAll]);
  try
    Result := StrToFloat(S, FS);
  except
    on E: EConvertError do
      Result := 0.0;
  end;
end;

end.

