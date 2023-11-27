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
  TVisibility = (viPrivate, viProtected, viPublic, viPackage, viPublished);

  TBoolEvent = procedure (Value: Boolean) of object;

const
  UTF8BOMString : RawByteString = AnsiChar($EF) + AnsiChar($BB) + AnsiChar($BF);


function CtrlPressed: boolean;
procedure ErrorMsg(const s: string);
function myStringReplace(ImString: string; const DenString, DurchString: string): String;
function HideCrLf(const s: string): string;
function UnHideCrLf(const s: string): string;
function Split(Delimiter: Char; Input: string): TStringList;
function IsWriteProtected(const Filename: string): boolean;
function dissolveUsername(const s: String): String;
function IsHTTP(const Pathname: String): Boolean;
procedure ComboBoxAdd(ComboBox: TComboBox);
procedure ComboBoxInsert(ComboBox: TComboBox);
procedure ComboBoxInsert2(ComboBox: TComboBox; const s: string);
procedure ComboBoxDelete2(ComboBox: TComboBox; const s: string);
function ComboBoxItemsSpeichern(s: string): string;
function ComboBoxItemsLaden(s: string): string;
function withoutTrailingSlash(const s: String): string;
function withTrailingSlash(const s: String): string;
function VistaOrBetter: boolean;
function GetDocumentsPath: string;
procedure ErweiterePath(const s: string);
function  GetEnvironmentVar(const VarName: string): string;
procedure SetEnvironmentVar(const VarName, VarValue: string);
function GetTempDir: String;
function ExtractFilePathEx(const s: string): string;
function hasDefaultPrinter: boolean;
procedure CreateMyFile(const Path: string);
function IsAdministrator: Boolean;
function HasAssociationWithGuiPy(const Extension: string): boolean;
function getRegisteredGuiPy: string;
function HideBlanks(const s: String): String;
function UnHideBlanks(const s: String): String;
function GetLongPathName(const PathName: string): string;
function left(const s: string; p: integer): string;
function right(const s: string; p: integer): string;
function CountChar(c: char; const s: string): integer;
function HasWriteAccess(const Directory: string): boolean;
procedure SetPrinterIndex( i : Integer );
procedure PrintBitmap(FormBitmap: TBitmap; PixelsPerInch: integer; PrintScale: TPrintScale = poProportional);
function ExplorerTest: boolean;
function UpperLower(const s: string): string;
function IsWordBreakChar(C: Char): Boolean; overload;
function IsWordInLine(Word, Line: String): boolean;
function IsDigit(c: char): boolean;
function WindowStateToStr(W: TWindowState): string;
function StrToWindowState(const s: string): TWindowState;
function WithoutGeneric(s: String): String;
function getShortType(s: String): String;
function getShortTypeWith(s: String): String;
function getShortMethod(s: String): String;
function GenericOf(const s: String): String;
function VisibilityAsString(vis: TVisibility) : String;
function String2Visibility(const s: string): TVisibility;
function isPythonType(aType: string): boolean;
function hasClassExtension(const Pathname: String): Boolean;
function hasPythonExtension(const Pathname: String): Boolean;
function ValidFilename(s: String): boolean;
function max3(m1, m2, m3: integer): integer;
function min3(m1, m2, m3: integer): integer;
procedure LockFormUpdate(F: TForm);
procedure UnlockFormUpdate(F: TForm);
function WithoutArray(const s: String): String;
function IsUNC(const Pathname: String): Boolean;
function ExtractFileNameEx(s: string): string;
function StripHttpParams(const s: string): string;
function ToWindows(s: String): String;
function FileExistsCaseSensitive(const Filename: TFileName): Boolean;
function getFirstWord(s: string): string;
procedure SetAnimation(Value: boolean);
function einruecken(Einrueck, s: string): string;
function isDunder(Name: string): boolean;
function StringTimesN(s: string; n: integer): string;
function GetUniqueName(Control: TControl; Basename: string): string;
function OnlyCharsAndDigits(const s: string): string;
function ToWeb(const Browser: string; s: String): String;
procedure DrawBitmap(x, y, i: integer; aCanvas: TCanvas; aImagelist: TImageList);
procedure RotateBitmap(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean;
  BkColor: TColor = clNone);
function StartsWith(const Str, Substr: String): boolean;
function LowerUpper(const s: string): string;
function isLower(c: char): boolean;
function WithoutSpaces(const s: string): string;
function ChangeColor(Color: TColor; percent: real): TColor;
function asString(s: string): string;
function isIdentifierChar(c: char): boolean;
function LeftSpaces(s: string; tabW: integer): Integer;
function RGB2Color(const R, G, B: Integer): Integer;
procedure Color2RGB(const Color: TColor; var R, G, B: Integer);
function WithoutLeadingUnderscores(s: string): string;
function GetNextPart(var s: string): string; overload;
function GetNextPart(var s: string; ch: char): string; overload;
function Visibility2ImageNumber(vis: TVisibility): integer;
function IsVisibility(const s: string): boolean;
function IsModifier(const s: string): boolean;
function WithoutVisibility(s: string): string;
function IsSimpleType(const s: string): boolean;
function ShellExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
function FilenameToFileKind(const Filename: string): TFileKind;
function RemovePortableDrive(const s: string; folder: string = ''): string;
function AddPortableDrive(const s: string; folder: string = ''): string;
function WriteLog(LogString: String): Integer;
function getProtocolAndDomain(url: string): string;
function IsHTML(const Pathname: String): Boolean;
function HttpToWeb(s: String): String;
function DownloadURL(const aUrl, aFile: string): boolean;
procedure SetElevationRequiredState(aControl: TWinControl);
function DownloadFile(const SourceFile, DestFile: string): Boolean;
function MakeValidIdentifier(s: string): string;
function CanActuallyFocus(WinControl: TWinControl): Boolean;
function isNumber(var s: string): boolean;
function isBool(s: string): boolean;
procedure ReplaceResourceString(RStringRec: PResStringRec; const AString: String);
function DecToBase(nBase: integer; nDecValue: double): string;
function ConvertLtGt(s: string): string;
function FloatToVal(x: real): string;
function PointToVal(P: TPoint): string;
function IntToVal(x: integer): string;
function myColorToRGB(Color: TColor): string;
function XYToVal(x, y: integer): string;
function CalcIndent(S : string; TabWidth : integer = 4): integer;
function encodeQuotationMark(const s: string): string;

implementation

uses Dialogs, UITypes, WinInet, Winapi.SHFolder, Registry, Printers, Math, Messages,
     ShellAPI, IOUtils, SHDocVw, URLMon, StrUtils, cPyScripterSettings, uCommonFunctions;

function CtrlPressed: boolean;
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

function myStringReplace(ImString: string; const DenString, DurchString: string): String;
begin
  Result:= StringReplace(Imstring, DenString, DurchString, [rfReplaceAll, rfIgnoreCase]);
end;

procedure ErrorMsg(const s: string);
begin
  StyledMessageDlg(s, mtError, [mbOK], 0);
end;

function Split(Delimiter: Char; Input: string): TStringList;
  var p: integer; SL: TStringList;
begin
  SL:= TStringList.Create;
  p:= Pos(Delimiter, Input);
  while p > 0 do begin
    SL.Add(copy(Input, 1, p-1));
    delete(Input, 1, p);
    p:= Pos(Delimiter, Input);
  end;
  SL.Add(Input);
  Result:= SL;
end;

function HasAttr(const FileName: string; Attr: Word): Boolean;
  var Fileattr: integer;
begin
  Fileattr:= FileGetAttr(FileName);
  Result := (FileAttr and Attr) = Attr;
end;

function IsWriteProtected(const Filename: string): boolean;
begin
  Result:= FileExists(Filename) and HasAttr(Filename, faReadOnly);
end;

procedure StrResetLength(var S: String);
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

function dissolveUsername(const s: String): String;
  var p: integer; Username: String;
begin
  Result:= s;
  p:= Pos('%USERNAME%', Uppercase(Result));
  if p > 0 then begin
    Delete(Result, p, 10);
    Username:= GetLocalUsername;
    Insert(Username, Result, p);
  end;
end;

function IsHTTP(const Pathname: String): Boolean;
  var aPath: String;
begin
  aPath:= Uppercase(Pathname);
  Result:= (pos('HTTP://', aPath) + pos('RES://', aPath) + pos('HTTPS://', aPath) > 0);
end;

procedure ComboBoxAdd(ComboBox: TComboBox);
  var s: string; i: integer;
begin
  s:= ComboBox.Text;
  ComboBox.Hint:= s;
  if s = '' then exit;
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
  var i: integer;
begin
  i:= ComboBox.Items.IndexOf(s);
  if i >= 0 then
    ComboBox.Items.Delete(i);
end;

function withoutTrailingSlash(const s: String): string;
begin
  Result:= s;
  if (copy(Result, length(Result), 1) = '/') or (copy(Result, length(Result), 1) = '\') then
    SetLength(Result, Length(Result)-1);
end;

{$WARNINGS OFF}
function withTrailingSlash(const s: String): string;
begin
  Result:= withoutTrailingSlash(s);
  if IsHttp(Result)
    then Result:= Result + '/'
    else Result:= IncludeTrailingPathDelimiter(Result);
end;
{$WARNINGS ON}

function VistaOrBetter: boolean;
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
  var p: integer;
begin
  p:= Pos(#13#10, s);
  while p > 0 do begin
    delete(s, p, 2);
    insert(';', s, p);
    p:= Pos(#13#10, s);
  end;
  Result:= s;
end;

function ComboBoxItemsLaden(s: string): string;
  var p: integer;
begin
  p:= Pos(';', s);
  while p > 0 do begin
    delete(s, p, 1);
    insert(#13#10, s, p);
    p:= Pos(';', s);
  end;
  Result:= s;
end;

function GetTempDir: String;
  var P: PChar;
begin
  P:= StrAlloc(255);
  GetTempPath(255, P);
  Result:= String(P);
  StrDispose(P);
end;

function IsCHM(const Pathname: string): boolean;
begin
  Result:= (pos('.CHM', UpperCase(Pathname)) > 0);
end;

function ExtractFilePathEx(const s: string): string;
  var p: integer;
begin
  if IsHttp(s) then begin
    p:= length(s);
    while s[p] <> '/' do dec(p);
    Result:= copy(s, 1, p);
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
     if reg.OpenKey('SOFTWARE\Classes\' + ext + '\shell\open\command', false) then
      begin
       {The open command has been found}
       s:= reg.ReadString('');
       reg.CloseKey;
     end
     else begin
       {perhaps there is a system file pointer}
       if reg.OpenKey('SOFTWARE\Classes\' + ext, false) then begin
         try
           s:= reg.ReadString('');
         except
           s:= '';
         end;
         reg.CloseKey;
         if s <> '' then begin
           {A system file pointer was found}
           if reg.OpenKey('SOFTWARE\Classes\' + s + '\Shell\Open\command', false) then
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
     Delete(s, Pos('%', s), length(s));
   s:= Trim(s);
   p:= Pos('.EXE', UpperCase(s));
   if p > 0 then Delete(s, p + 4, Length(s));
   p:= Pos('"', s);
   if p = 1 then begin
     Delete(s, 1, 1);
     p:= Pos('"', s);
     if p > 0 then Delete(s, p, length(s));
   end;
   if FileExists(s)
     then Result:= s
     else Result:= '';
   FreeAndNil(reg);
 end;

 function hasDefaultPrinter: boolean;
var
  ResStr: array[0..255] of Char;
  DefaultPrinter: String;
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

function HasAssociationWithGuiPy(const Extension: string): boolean;
  var s: string;
begin
  s:= Uppercase(GetExeForExtension(Extension));
  Result:= Pos(UpperCase(ExtractFilename(ParamStr(0))), s) > 0;
end;

function getRegisteredGuiPy: string;
 var reg: TRegistry;
begin
  reg:= TRegistry.Create;
  reg.RootKey:= HKEY_LOCAL_MACHINE;
  reg.Access:= KEY_READ;
  if reg.OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', false)
    then Result:= reg.ReadString('')
    else Result:= '';
  reg.CloseKey;
  var p:= Pos(' "%1"', Result);
  if p > 0 then
    Result:= copy(Result, 1, p-1);
  FreeAndNil(reg);
end;

function HideBlanks(const s: String): String;
begin
  if (Pos(' ', s) > 0) and (Pos('"', s) <> 1)
    then Result:= AnsiQuotedStr(s, '"')
    else Result:= s;
end;

function UnHideBlanks(const s: String): String;
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

function left(const s: string; p: integer): string;
begin
  if p >= 0
    then Result:= copy(s, 1, p)
    else Result:= copy(s, 1, length(s)+p);
end;

function right(const s: string; p: integer): string;
begin
  if p >= 0
    then Result:= copy(s, p, length(s))
    else Result:= copy(s, length(s)+p+1, length(s));
end;

function CountChar(c: char; const s: string): integer;
  var i: integer;
begin
  Result:= 0;
  for i:= 1 to length(s) do
    if s[i] = c then inc(Result);
end;

function HasWriteAccess(const Directory: string): boolean;
  var FS: TFileStream; s: string;
begin
  s:= withTrailingSlash(Directory) + 'wa_test.$$$';
  try
    FS:= TFileStream.Create(s, fmCreate or fmShareExclusive);
    FreeAndNil(FS);
    Result:= DeleteFile(PChar(s));
  except
    Result:= false;
  end;
end;


procedure SetPrinterIndex(i: integer);
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

procedure PrintBitmap(FormBitmap: TBitmap; PixelsPerInch: integer; PrintScale: TPrintScale = poProportional);
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

function ExplorerTest: boolean;
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
    Result:= false;
  end;
end;

function UpperLower(const s: string): string;
begin
  Result:= UpperCase(Copy(s, 1, 1)) + Copy(s, 2, length(s));
end;

function IsWordBreakChar(C: Char): Boolean;  // fromSyneditSearch
begin
  case C of
    #0..#32, '.', ',', ';', ':', '"', '''', '´', '`', '°', '^', '!', '?', '&',
    '$', '@', '§', '%', '#', '~', '[', ']', '(', ')', '{', '}', '<', '>',
    '-', '=', '+', '*', '/', '\', '|':
      Result := True;
    else
      Result := False;
  end;
end;

function IsWordInLine(Word, Line: String): boolean;
  var p, q: integer;
begin
  Result:= false;
  p:= Pos(Word, Line);
  if p > 0 then begin
    q:= p + length(Word);
    Result:= ((p = 1) or (p > 1) and IsWordBreakChar(Line[p-1])) and
             ((q > length(Line)) or IsWordBreakChar(Line[q]));
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

function WithoutGeneric(s: String): String;
  var p1, p2: integer;
begin
  p1:= Pos('<', s);
  if p1 > 0 then begin
    p2:= length(s);
    while (p2 > 0) and (s[p2] <> '>') do
      dec(p2);
    delete(s, p1, p2-p1+1);
  end;
  if Pos('...', s) > 0
    then s:= copy(s, 1, Pos('...', s) -1);
  Result:= s;
end;

function GetShortType(s: String): String;
  var p: integer;
begin
  p:= Pos('.', s);
  if p > 0 then delete(s, 1, p);
  delete(s, 1, LastDelimiter('.', s));
  p:= Pos('<', s);
  if p > 1 then
    s:= copy(s, 1, p-1);
  Result:= s;
end;

function GetShortTypeWith(s: String): String;
  var p: integer;
begin
  p:= Pos('.', s);
  if p > 0 then delete(s, 1, p);
  delete(s, 1, LastDelimiter('.', s));
  Result:= s;
end;

function GetShortMethod(s: String): String;
  var p: integer; s1: string;
begin
  p:= Pos('throws ', s);
  if p > 0 then s:= trim(copy(s, 1, p-1));
  p:= Pos('(', s);
  s1:= getShortTypeWith(Left(s, p-1)) + '(';
  s:= copy(s, p+1, Length(s) - p -1) + ',';
  p:= Pos(',', s);
  while p > 0 do begin
    s1:= s1 + GetShortTypeWith(Left(s, p-1)) + ', ';
    delete(s, 1, p);
    p:= Pos(',', s);
  end;
  Result:= Left(s1, -2) + ')';
end;

function GenericOf(const s: String): String;
  var p: integer;
begin
  Result:= '';
  p:= Pos('<', s);
  if p > 0 then
    Result:= copy(s, p+1, length(s) - p - 1);
end;

function VisibilityAsString(vis: TVisibility) : String;
begin
  case vis of
    viPrivate:   Result:= '__';
    viProtected: Result:= '_';
  else           Result:= '';
  end;
end;

function String2Visibility(const s: string): TVisibility;
  var Underscores: integer;
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

function isPythonType(aType: string): boolean;
  const PythonTypes : array[0..39] of String =
     ('None', 'int', 'float', 'complex', 'str', 'bool', 'list', 'tuple', 'range',
      'set', 'dict', 'bytes', 'bytearray', 'memoryview', 'frozenset',
      'Optional', 'Callable', 'Type', 'Literal', 'ClassVar',
      'Annotated', 'Generic', 'TypeVar', 'AnyStr', 'Protocol', 'Dict', 'List',
      'Set', 'FrozenSet', 'DefaultDict', 'OrderedDict', 'ChainMap', 'Counter',
      'Deque', 'IO', 'TextIO', 'BinaryIO', 'Pattern', 'Match', 'Text' );
  var p: integer;
begin
  p:= Pos('[', aType); // GenericType?
  if p > 0 then Delete(aType, p, length(aType));
  for p:= 0 to 39 do
    if PythonTypes[p] = aType then
      Exit(True);
  Result:= false;
end;

function hasClassExtension(const Pathname: string): boolean;
begin
  Result:= (pos('.class', Pathname) > 0);
end;

function hasPythonExtension(const Pathname: string): boolean;
begin
  Result:= (pos('.py', Pathname) > 0);
end;

function ValidFilename(s: String): boolean;
begin
  s:= Uppercase(ChangeFileExt(ExtractFilename(s), ''));
  Result:= (s <> 'CON') and (s <> 'PRN') and (s <> 'AUX') and (s <> 'NUL');
end;

function max3(m1, m2, m3: integer): integer;
begin
  Result:= max(m1, max(m2, m3));
end;

function min3(m1, m2, m3: integer): integer;
begin
  Result:= min(m1, min(m2, m3));
end;

var FLockFormUpdatePile : integer;

procedure LockFormUpdate(F: TForm);
begin
  if assigned(F) then begin
    if FLockFormUpdatePile = 0 then
      F.Perform(WM_SetRedraw, 0, 0);
    inc(FLockFormUpdatePile);
  end;
end;

procedure UnlockFormUpdate(F: TForm);
begin
  if assigned(F) then begin
    dec(FLockFormUpdatePile);
    if FLockFormUpdatePile = 0 then begin
      F.Perform(WM_SetRedraw, 1, 0);
      RedrawWindow(F.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE +
        RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);
    end;
  end;
end;

function WithoutArray(const s: String): String;
  var i: integer;
begin
  Result:= s;
  i:= Pos('[', Result) + Pos('...', Result);
  if i > 0
    then Result:= copy(Result, 1, i-1)
end;

function IsUNC(const Pathname: String): boolean;
begin
  Result:= (pos('\\', Pathname) = 1);
end;

function ExtractFileNameEx(s: String):String;
  var i: Integer;
begin
  if Pos('file:///', s) > 0 then begin
    delete(s, 1, 8);
    s:= myStringReplace(s, '/', '\');
  end;
  s:= StripHttpParams(s);
  if IsHttp(s) then begin
    i:= Length(s);
    while (s[i] <> '/') do dec(i);
    Delete(s, 1, i);
    if s = '' then s:= 'index.html';
  end
  else if IsCHM(s) then begin
    i:= Pos('.CHM', Uppercase(s));
    delete(s, 1, i+3);
    if copy(s, 1, 2) = '::' then
      delete(s, 1, 2);
    s:= ExtractFileName(toWindows(s))
    end
  else
    s:= ExtractFileName(s);
  Result:= s;
end;

function StripHttpParams(const s: string): string;
    var i: integer; fname: string;
begin
  fname:= ExtractFilename(s);
  i:= Pos('?', fname);
  if i > 0 then delete(fname, i, length(fname));
  i:= Pos('#', fname);
  if i > 0 then delete(fname, i, length(fname));
  Result:= ExtractFilePath(s) + fname;
end;

function ToWindows(s: String): String;
  var p: Integer;
begin
  p:= pos('/', s);
  while p > 0 do begin
    s[p]:= '\';
    p:= pos('/', s);
  end;
  Result:= s;
end;

function FileExistsCaseSensitive(const Filename: TFileName): Boolean;
  var SR: TSearchRec;
begin
  Result:= FindFirst(Filename, faAnyFile, SR) = 0;
  if Result then Sysutils.FindClose(SR);
  Result:= Result and (SR.Attr and faDirectory = 0) and (SR.Name = ExtractFileName(Filename));
end;

function getFirstWord(s: string): string;
  var i: integer;
begin
  s:= trim(s);
  i:= 1;
  while (i <= length(s)) and not IsWordBreakChar(s[i]) do
    inc(i);
  Result:= copy(s, 1, i-1);
end;

procedure SetAnimation(Value: boolean);
  var Info: TAnimationInfo;
begin
  Info.cbSize:= SizeOf(TAnimationInfo);
  Bool(Info.iMinAnimate):= Value;
  SystemParametersinfo(SPI_SETANIMATION, SizeOf(Info), @Info, 0);
end;

function einruecken(Einrueck, s: string): string;
  var SL: TStringList; i: integer;
begin
  SL:= TStringList.Create;
  SL.Text:= s;
  for i:= 0 to SL.Count - 1 do
    SL[i]:= Einrueck + SL[i];
  Result:= SL.Text;
  FreeandNil(SL);
end;

function isDunder(Name: string): boolean;
begin
  Result:= (Copy(Name, 1, 2) = '__') and
           (Copy(Name, Length(Name) - 1, 2) = '__');
end;



function StringTimesN(s: string; n: integer): string;
  var i: integer;
begin
  Result:= '';
  for i:= 1 to n do
    Result:= Result + s;
end;

function changeVowels(const s: string): string;
  const Vowels = 'ÄÖÜäöüß';
  const Nowels = 'AOUaous';
  var i, p: integer;
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
  var i: integer; s: string;
begin
  BaseName:= OnlyCharsAndDigits(changeVowels(Basename));
  if Control.FindComponent(BaseName) = nil then begin
    Result:= BaseName;
    exit;
  end;
  s:= Right(BaseName, -1);
  while (Pos(s, '0123456789') > 0) and (Length(BaseName) > 2) do begin
    BaseName:= Left(Basename, Length(Basename) - 1);
    s:= Right(BaseName, -1);
  end;
  Result:= Basename;
  i:= 0;
  while Control.FindComponent(Result) <> nil do begin
    inc(i);
    Result:= BaseName + IntToStr(i);
  end;
end;

function OnlyCharsAndDigits(const s: string): string;
  var i: integer; c: char;
begin
  Result:= '';
  for i:= 1 to length(s) do begin
    c:= s[i];
    if not IsWordBreakChar(c) then
      Result:= Result + c;
  end;
end;

function CodeSpaces(s: String): string;
  var i: integer;
begin
  for i:= Length(s) downto 1 do
    if s[i] = ' ' then begin
      delete(s, i, 1);
      insert('%20', s, i);
    end;
  Result:= s;
end;

function toWeb(const Browser: string; s: String): String;
  var p: Integer;
      IsUNC, IsLaufwerk: boolean;
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
    if Pos('OPERA', Uppercase(Browser)) > 0
      then s:= 'file:' + s
      else s:= 'file://localhost/' + s;
  if isLaufwerk then
    s:= 'file:///' + s;
  Result:= s;
end;

procedure DrawBitmap(x, y, i: integer; aCanvas: TCanvas; aImagelist: TImageList);
  var aBitmap: TBitmap;
begin
  if i >= 0 then begin
    aBitmap:= TBitmap.Create;
    aImagelist.GetBitmap(i, aBitmap);
    aBitmap.Transparent:= true;
    aCanvas.Draw(x, y, aBitmap);
    FreeAndNil(aBitmap);
  end;
end;

procedure RotateBitmap(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean;
  BkColor: TColor = clNone);
var
  C: Single;
  S: Single;
  Tmp: TBitmap;
  OffsetX: Single;
  OffsetY: Single;
  Points: array[0..2] of TPoint;
begin
  C := Cos(Rads);
  S := Sin(Rads);
  Tmp := TBitmap.Create;
  try
    Tmp.TransparentColor := Bmp.TransparentColor;
    Tmp.TransparentMode := Bmp.TransparentMode;
    Tmp.Transparent := Bmp.Transparent;
    Tmp.Canvas.Brush.Color := BkColor;
    if AdjustSize then
    begin
      Tmp.Width := Round(Bmp.Width * Abs(C) + Bmp.Height * Abs(S));
      Tmp.Height := Round(Bmp.Width * Abs(S) + Bmp.Height * Abs(C));
      OffsetX := (Tmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      OffsetY := (Tmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end
    else
    begin
      Tmp.Width := Bmp.Width;
      Tmp.Height := Bmp.Height;
      OffsetX := (Bmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      OffsetY := (Bmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end;
    Points[0].X := Round(OffsetX);
    Points[0].Y := Round(OffsetY);
    Points[1].X := Round(OffsetX + Bmp.Width * C);
    Points[1].Y := Round(OffsetY + Bmp.Width * S);
    Points[2].X := Round(OffsetX - Bmp.Height * S);
    Points[2].Y := Round(OffsetY + Bmp.Height * C);
    PlgBlt(Tmp.Canvas.Handle, Points, Bmp.Canvas.Handle, 0, 0, Bmp.Width,
      Bmp.Height, 0, 0, 0);
    Bmp.Assign(Tmp);
  finally
    FreeAndNil(Tmp);
  end;
end;

function StartsWith(const Str, Substr: String): boolean;
begin
  if Str <> ''
    then Result:= CompareStr(copy(Str, 1, Length(SubStr)), SubStr) = 0
    else Result:= False;
end;

function LowerUpper(const s: string): string;
begin
  Result:= LowerCase(Copy(s, 1, 1)) + Copy(s, 2, length(s));
end;

function isLower(c: char): boolean;
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

function isIdentifierChar(c: char): boolean;
begin
  Result:= CharInSet(c, ['a'..'z', 'A'..'Z', '0'..'9', '_']);
end;

function LeftSpaces(s: string; tabW: integer): Integer;
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
  var p: integer;
begin
  p:= 1;
  while (p <= Length(s)) and (s[p] = '_') do
    inc(p);
  Result:= copy(s, p, length(s));
end;

function GetNextPart(var s: string; ch: char): string;
  var q, p, bracket: integer;
begin
  p:= Pos(ch, s);
  if p = 0 then p:= length(s)+1;
  q:= Pos('<', s); // generic part
  if (0 < q) and (q < p) then begin
    bracket:= 1;
    inc(q);
    while (q <= length(s)) and (bracket > 0) do begin
      if s[q] = '<' then inc(bracket) else
      if s[q] = '>' then dec(bracket);
      inc(q);
    end;
    while (q <= length(s)) and (s[q] <> ch) do
      inc(q);
    p:= q;
  end;
  Result:= copy(s, 1, p-1);
  delete(s, 1, p);
end;

function GetNextPart(var s: string): string;
begin
  result:= GetNextPart(s, ' ');
end;

function Visibility2ImageNumber(vis: TVisibility): integer;
begin
  case vis of
    viPrivate:   Result:= 7;
    viProtected: Result:= 8;
  else           Result:= 10;
  end;
end;

function IsVisibility(const s: string): boolean;
  const visibilities: array[1..3] of string = ('__', '_', '');
  var i: integer;
begin
  Result:= false;
  for i:= 1 to 3 do
    if s = visibilities[i] then begin
      Result:= true;
      exit;
    end;
end;

function IsModifier(const s: string): boolean;
  const Modifiers : Array[1..3] of string =
    ('static', 'abstract', 'final');
  var i: integer;
begin
  Result:= false;
  for i:= 1 to 3 do
    if s = Modifiers[i] then begin
      Result:= true;
      exit;
    end;
end;

function WithoutVisibility(s: string): string;
  var p: integer;
begin
  while (length(s) > 0) and (s[1] = '_') do
    delete(s, 1, 1);
  p:= Pos('__', s);
  if p > 0 then
    delete(s, 1, p+1);
  Result:= s;
end;

function IsSimpleType(const s: string): boolean;
  const simpleTypePython: array[1..4] of String =
          ('integer', 'boolean', 'float', 'string');
  var i: integer;
begin
  Result:= true;
  for i:= 1 to 4 do
    if simpletypePython[i] = s then exit;
  Result:= false;
end;

function ShellExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
begin
  Result:= ShellExecute(Application.MainForm.Handle, 'open',
             PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
end;

function FilenameToFileKind(const Filename: string): TFileKind;
  var Extension: string;
begin
  Result:= fkEditor;
  Extension:= TPath.GetExtension(Filename);
  if isHttp(Filename) then
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
      i, j: integer; Basefolder: string;
begin
  Result:= s;
  if TPyScripterSettings.IsPortable
    then Basefolder:= ExtractFilePath(Application.ExeName)
    else Basefolder:= folder;
  // same drive
  if TPath.isDriveRooted(Basefolder) and
    (Uppercase(copy(Basefolder, 1, 2)) = Uppercase(copy(s, 1, 2)))
  then begin
    SL1:= Split('\', withoutTrailingSlash(Basefolder));
    SL2:= Split('\', withoutTrailingSlash(s));
    i:= 0;
    while (i < SL1.Count) and (i < SL2.Count) and
          (Uppercase(SL1[i]) = Uppercase(SL2[i])) do
      inc(i);
    Result:= '';
    j:= i;
    while i < SL1.Count do begin
      Result:= Result + '..\';
      inc(i);
    end;
    while j < SL2.Count do begin
      Result:= Result + SL2[j] + '\';
      inc(j);
    end;
    Result:= withoutTrailingSlash(Result);
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

function AddPortableDrive(const s: string; folder: string = ''): string;
  // if folder is set then switch to relative paths, used in Store/FetchDiagram
  var SL1, SL2: TStringList;
      i, j: integer; Basefolder: string;
begin
  Result:= s;
  if (UUtils.left(s, 4) = 'its:') or ( s = '') or
     (copy(s, 2, 2) = ':\') or (copy(s, 1, 7) = 'file://') or // absolute path
     (Pos('\\', s) = 1) or (Pos('://', s) > 1) then // UNC or https:// or http://
    exit;

  if TPyScripterSettings.IsPortable
    then Basefolder:= ExtractFilePath(Application.ExeName)
    else Basefolder:= folder;

  if Basefolder <> '' then begin
    SL1:= Split('\', withoutTrailingSlash(Basefolder));
    SL2:= Split('\', withoutTrailingSlash(s));
    i:= 0;
    while (i < SL2.Count) and (SL2[i] = '..') do
      inc(i);
    Result:= SL1[0];
    for j:= 1 to SL1.Count - 1 - i do
      Result:= Result + '\' + SL1[j];
    for j:= i to SL2.Count - 1 do
      Result:= Result + '\' + SL2[j];
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

function WriteLog(LogString: String): Integer;
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
  var p: integer;
begin
  p:= Pos('://', url);
  if p > 0
    then Result:= copy(url, 1, p + 2)
    else Result:= '';
end;

function getProtocolAndDomain(url: string): string;
  var p: integer; protocol: string;
begin
  protocol:= getProtocol(url);
  delete(url, 1, length(protocol));
  p:= Pos('/', url);
  if p > 0
    then Result:= protocol + copy(url, 1, p-1)
    else Result:= protocol + url;
end;

function IsHTML(const Pathname: String): Boolean;
begin
  Result:= (Pos('.HTM', UpperCase(ExtractFileExt(Pathname))) > 0);
end;

function HttpToWeb(s: String): String;
  var p: Integer;
begin
  p:= pos('\', s);
  while p > 0 do begin
    s[p]:= '/';
    p:= pos('\', s);
  end;
  Result:= s;
end;

// benötigt WinInet
function DownloadURL(const aUrl, aFile: string): boolean;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  lpBuffer: array[0..1024 + 1] of Char;
  dwBytesRead: DWORD;
  Datei: TFileStream;
begin
  Result:= false;
  try
    Datei:= TFileStream.Create(aFile, fmCreate or fmShareExclusive);
    hSession:= InternetOpen('Java-Editor', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    try
      if Assigned(hSession) then begin                                                       // keine Cache-Benutzung!
        hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
        if Assigned(hService) then
          try
            while true do begin
              dwBytesRead := 1024;
              InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
              if dwBytesRead = 0 then break;
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
  SendMessage(aControl.Handle, BCM_SETSHIELD, 0, Integer(true));
end;

// benötigt URLMon
function DownloadFile(const SourceFile, DestFile: string): Boolean;
begin
  try
    Result:= UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, nil) = 0;
  except
    Result:= False;
  end;
end;

function MakeValidIdentifier(s: string): string;
  var i: integer;
begin
  for i := Length(s) downto 1 do
    if not CharInSet(s[i], ['a'..'z','A'..'Z', '0'..'9', '_']) then
      delete(s, i, 1);
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

function isNumber(var s: string): boolean;
  var d: Double; p: integer;
begin
  p:= Pos('.', s);
  if p > 0 then
    s[p]:= FormatSettings.DecimalSeparator;
  Result:= TryStrToFloat(s, d);
  p:= Pos(FormatSettings.DecimalSeparator, s);
  if p > 0 then
    s[p]:= '.';
end;

function isBool(s: string): boolean;
begin
  Result:= (s = 'True') or (s = 'False');
end;

procedure ReplaceResourceString(RStringRec: PResStringRec; const AString: String);
  var OldProtect: Cardinal;
begin
  if (RStringRec = nil) or (length(AString) = 0) then exit;
  if VirtualProtect(RStringRec, SizeOf(RStringRec^), PAGE_EXECUTE_READWRITE, @OldProtect) then begin
    RStringRec^.Identifier:= Integer(PChar(AString));
    VirtualProtect(RStringRec, SizeOf(RStringRec^), OldProtect, @OldProtect);
  end
  else ErrorMsg(SysErrorMessage(GetLastError));
end;

function DecToBase(nBase: integer; nDecValue: double): string;
{Function   : converts decimal integer to base n, max = Base36
 Parameters : nBase     = base number, ie. Hex is base 16
              nDecValue = decimal to be converted
              LeadZeros = min number of digits if leading zeros required
 Returns    : number in base n as string}
  var BaseString, DecToStr, f: string;
      Modulus, p, IntVal, FracVal: integer;
      negative: boolean;
begin
  Result:= '';
  BaseString:= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'; {max = Base36}
  if nDecValue < 0 then begin
    negative:= true;
    nDecValue:= -nDecValue;
  end else
    negative:= false;
  DecToStr:= FloatToStrF(nDecValue, ffGeneral, 15, 8);
  p:= Pos('.', DecToStr);
  if p > 0 then begin
    IntVal:= StrToInt(copy(DecToStr, 1, p-1));
    FracVal:= StrToInt(copy(DecToStr, p +1 , Length(DecToStr)));
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

function IntToVal(x: integer): string;
begin
  Result:= '"' + IntToStr(x) + '"';
end;

function myColorToRGB(Color: TColor): string;
  var ColorInt, r, g, b: integer;
begin
  ColorInt:= ColorToRGB(Color);
  r:= GetRValue(ColorInt);
  g:= GetGValue(ColorInt);
  b:= GetBValue(ColorInt);
  Result:= 'rgb(' + IntToStr(r) + ',' + IntToStr(g) + ',' + IntToStr(b) + ')';
end;

function XYToVal(x, y: integer): string;
begin
  Result:= IntToStr(x) + ',' + IntToStr(y) + ' ';
end;

function CalcIndent(S : string; TabWidth : integer = 4): integer;
Var
  i : integer;
begin
  Result := 0;
  for i := 1 to Length(S) do
    if S[i] = WideChar(#9) then
      Inc(Result, TabWidth)
    else if S[i] = ' ' then
      Inc(Result)
    else
      break;
end;

function encodeQuotationMark(const s: string): string;
begin
  Result:= ReplaceStr(s, '"', '&quot;');
end;

end.

