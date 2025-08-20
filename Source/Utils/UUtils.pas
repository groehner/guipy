{ -------------------------------------------------------------------------------
  Unit:     UUtils
  Author:   Gerhard Röhner
  Date:     July 2000
  Purpose:  utility functions
  ------------------------------------------------------------------------------- }

unit UUtils;

interface

uses
  Windows,
  Classes,
  StdCtrls,
  Forms,
  SysUtils,
  Controls,
  Graphics,
  uEditAppIntfs;

type
  TVisibility = (viPrivate, viProtected, viPublic);

  TBoolEvent = procedure(Value: Boolean) of object;

const
  UTF8BOMString: RawByteString = AnsiChar($EF) + AnsiChar($BB) + AnsiChar($BF);

function CtrlPressed: Boolean;
procedure ErrorMsg(const Str: string);
function MyStringReplace(const InString: string;
  const TheString, NewString: string): string;
function HideCrLf(const Str: string): string;
function UnHideCrLf(const Str: string): string;
function Split(Delimiter: Char; Input: string): TStringList;
function IsWriteProtected(const FileName: string): Boolean;
function RemoveReadOnlyAttribute(const FileName: string): Boolean;
function SetReadOnlyAttribute(const FileName: string): Boolean;
function DissolveUsername(const Str: string): string;
function IsHttp(const Pathname: string): Boolean;
procedure ComboBoxAdd(ComboBox: TComboBox);
procedure ComboBoxInsert(ComboBox: TComboBox);
procedure ComboBoxInsert2(ComboBox: TComboBox; const Str: string);
procedure ComboBoxDelete2(ComboBox: TComboBox; const Str: string);

function WithoutTrailingSlash(const Str: string): string;
function WithTrailingSlash(const Str: string): string;
function VistaOrBetter: Boolean;
function GetDocumentsPath: string;
function GetTempDir: string;
function ExtractFilePathEx(const Str: string): string;
function IsAdministrator: Boolean;
function HasAssociationWithGuiPy(const Extension: string): Boolean;
function GetRegisteredGuiPy: string;
function HideBlanks(const Str: string): string;
function Left(const Str: string; Num: Integer): string;
function Right(const Str: string; Num: Integer): string;
function CountChar(Chr: Char; const Str: string): Integer;
procedure PrintBitmap(FormBitmap: TBitmap; PixelsPerInch: Integer;
  PrintScale: TPrintScale = poProportional);
function UpperLower(const Str: string): string;
function IsWordBreakChar(Chr: Char): Boolean; overload;
function IsDigit(Chr: Char): Boolean;
function WindowStateToStr(WindowState: TWindowState): string;
function StrToWindowState(const Str: string): TWindowState;
function WithoutGeneric(Str: string): string;
function GetShortType(Str: string): string;
function GetShortTypeWith(Str: string): string;
function GenericOf(const Str: string): string;
function VisibilityAsString(Vis: TVisibility): string;
function IsPythonType(AType: string): Boolean;
function HasPythonExtension(const Pathname: string): Boolean;
function ValidFilename(Str: string): Boolean;
function Max3(Int1, Int2, Int3: Integer): Integer;
function Min3(Int1, Int2, Int3: Integer): Integer;
procedure LockFormUpdate(Form: TForm);
procedure UnlockFormUpdate(Form: TForm);
function WithoutArray(const Str: string): string;
function IsUNC(const Pathname: string): Boolean;
function ExtractFileNameEx(Str: string): string;
function StripHttpParams(const Str: string): string;
function ToWindows(Str: string): string;
function FileExistsCaseSensitive(const Filepath: string): Boolean;
procedure SetAnimation(Value: Boolean);
function IsDunder(const Name: string): Boolean;
function StringTimesN(const Str: string; Num: Integer): string;
function GetUniqueName(Control: TControl; Basename: string): string;
function OnlyCharsAndDigits(const Str: string): string;
function ToWeb(const Browser: string; Str: string): string;
function StartsWith(const Str, Substr: string): Boolean;
function LowerUpper(const Str: string): string;
function IsLower(Chr: Char): Boolean;
function AsString(const Str: string): string;
function LeftSpaces(const Str: string; TabW: Integer): Integer;
function RGB2Color(const Red, Green, Blue: Integer): Integer;
procedure Color2RGB(const Color: TColor; var Red, Green, Blue: Integer);
function WithoutVisibility(Str: string): string;
function IsSimpleType(const Str: string): Boolean;
function ShellExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
function FilenameToFileKind(const FileName: string): TFileKind;
function RemovePortableDrive(const Str: string; const Folder: string = ''): string;
function AddPortableDrive(const Str: string; const Folder: string = ''): string;
function GetProtocolAndDomain(Url: string): string;
function IsHTML(const Pathname: string): Boolean;
function HttpToWeb(Str: string): string;
function DownloadURL(const Url, FileName: string): Boolean;
procedure SetElevationRequiredState(AControl: TWinControl);
function CanActuallyFocus(WinControl: TWinControl): Boolean;
function IsNumber(var Str: string): Boolean;
function IsBool(const Str: string): Boolean;
function DecToBase(Base: Integer; DecValue: Double): string;
function ConvertLtGt(const Str: string): string;
function FloatToVal(AFloat: Real): string;
function PointToVal(Point: TPoint): string;
function IntToVal(Int: Integer): string;
function MyColorToRGB(Color: TColor): string;
function XYToVal(Xpos, YPos: Integer): string;
function CalcIndent(const Str: string; TabWidth: Integer = 4): Integer;
function EncodeQuotationMark(const Str: string): string;
function MyMulDiv(Number, Numerator, Denominator: Integer): Integer;
procedure LockWindow(Handle: THandle);
procedure UnLockWindow;
function IsColorDark(AColor: TColor): Boolean;

implementation

uses
  System.StrUtils,
  System.IOUtils,
  Dialogs,
  UITypes,
  WinInet,
  Winapi.SHFolder,
  Registry,
  Printers,
  Math,
  Messages,
  ShellAPI,
  cPyScripterSettings,
  uCommonFunctions;

function CtrlPressed: Boolean;
begin
  Result := (GetAsyncKeyState(VK_CONTROL) and $F000) <> 0;
end;

function HideCrLf(const Str: string): string;
begin
  Result := StringReplace(Str, #13#10, '\r\n', [rfReplaceAll, rfIgnoreCase]);
end;

function UnHideCrLf(const Str: string): string;
begin
  Result := StringReplace(Str, '\r\n', #13#10, [rfReplaceAll, rfIgnoreCase]);
end;

function MyStringReplace(const InString: string;
  const TheString, NewString: string): string;
begin
  Result := StringReplace(InString, TheString, NewString,
    [rfReplaceAll, rfIgnoreCase]);
end;

procedure ErrorMsg(const Str: string);
begin
  StyledMessageDlg(Str, mtError, [mbOK], 0);
end;

function Split(Delimiter: Char; Input: string): TStringList;
var
  Posi: Integer;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  Posi := Pos(Delimiter, Input);
  while Posi > 0 do
  begin
    StringList.Add(Copy(Input, 1, Posi - 1));
    Delete(Input, 1, Posi);
    Posi := Pos(Delimiter, Input);
  end;
  StringList.Add(Input);
  Result := StringList;
end;

function HasAttr(const FileName: string; Attr: Word): Boolean;
var
  Fileattr: Integer;
begin
  Fileattr := FileGetAttr(FileName);
  Result := (Fileattr and Attr) = Attr;
end;

function IsWriteProtected(const FileName: string): Boolean;
begin
  Result := FileExists(FileName) and HasAttr(FileName, faReadOnly);
end;

function RemoveReadOnlyAttribute(const FileName: string): Boolean;
var
  Attr: Integer;
begin
  Result := False;
  Attr := FileGetAttr(FileName);
  if Attr <> -1 then // -1 bedeutet, dass die Datei nicht existiert
  begin
    Result := FileSetAttr(FileName, Attr and not faReadOnly) = 0;
  end;
end;

function SetReadOnlyAttribute(const FileName: string): Boolean;
var
  Attr: Integer;
begin
  Result := False;
  Attr := FileGetAttr(FileName);
  if Attr <> -1 then
  begin
    Result := FileSetAttr(FileName, Attr or faReadOnly) = 0;
  end;
end;

procedure StrResetLength(var Str: string);
begin
  for var I := 0 to Length(Str) - 1 do
    if Str[I + 1] = #0 then
    begin
      SetLength(Str, I);
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

function DissolveUsername(const Str: string): string;
var
  Posi: Integer;
  Username: string;
begin
  Result := Str;
  Posi := Pos('%USERNAME%', UpperCase(Result));
  if Posi > 0 then
  begin
    Delete(Result, Posi, 10);
    Username := GetLocalUserName;
    Insert(Username, Result, Posi);
  end;
end;

function IsHttp(const Pathname: string): Boolean;
begin
  var Path := UpperCase(Pathname);
  Result := (Pos('HTTP://', Path) + Pos('RES://', Path) + Pos('HTTPS://',
    Path) > 0);
end;

procedure ComboBoxAdd(ComboBox: TComboBox);
var
  Str: string;
  Int: Integer;
begin
  Str := ComboBox.Text;
  ComboBox.Hint := Str;
  if Str = '' then
    Exit;
  Int := ComboBox.Items.IndexOf(Str);
  if Int >= 0 then
    ComboBox.Items.Delete(Int);
  ComboBox.Items.Insert(0, Str);
  if ComboBox.Items.Count > 7 then
    ComboBox.Items.Delete(7);
  ComboBox.ItemIndex := 0;
end;

procedure ComboBoxInsert(ComboBox: TComboBox);
var
  Str: string;
begin
  Str := Trim(ComboBox.Text);
  if (Str <> '') and (ComboBox.Items.IndexOf(Str) = -1) then
    ComboBox.Items.Add(Str);
end;

procedure ComboBoxInsert2(ComboBox: TComboBox; const Str: string);
begin
  if (Str <> '') and (ComboBox.Items.IndexOf(Str) = -1) then
    ComboBox.Items.Add(Str);
end;

procedure ComboBoxDelete2(ComboBox: TComboBox; const Str: string);
var
  Int: Integer;
begin
  Int := ComboBox.Items.IndexOf(Str);
  if Int >= 0 then
    ComboBox.Items.Delete(Int);
end;

function WithoutTrailingSlash(const Str: string): string;
begin
  Result := Str;
  if (Copy(Result, Length(Result), 1) = '/') or
    (Copy(Result, Length(Result), 1) = '\') then
    SetLength(Result, Length(Result) - 1);
end;

function WithTrailingSlash(const Str: string): string;
begin
  Result := WithoutTrailingSlash(Str);
  if IsHTTP(Result) then
    Result := Result + '/'
  else
    Result := IncludeTrailingPathDelimiter(Result);
end;

function VistaOrBetter: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and
    (Win32MajorVersion >= 6);
end;

function GetDocumentsPath: string;
const
  CSIDL_PERSONAL = $0005;
var
  LStr: array [0 .. MAX_PATH] of Char;
begin
  Result := '';
  SetLastError(ERROR_SUCCESS);
  if SHGetFolderPath(0, CSIDL_PERSONAL, 0, 0, @LStr) = S_OK then
    Result := LStr;
end;

function GetTempDir: string;
var
  PChr: PChar;
begin
  PChr := StrAlloc(255);
  GetTempPath(255, PChr);
  Result := string(PChr);
  StrDispose(PChr);
end;

function IsCHM(const Pathname: string): Boolean;
begin
  Result := (Pos('.CHM', UpperCase(Pathname)) > 0);
end;

function ExtractFilePathEx(const Str: string): string;
var
  Posi: Integer;
begin
  if IsHTTP(Str) then
  begin
    Posi := Length(Str);
    while Str[Posi] <> '/' do
      Dec(Posi);
    Result := Copy(Str, 1, Posi);
  end
  else
    Result := ExtractFilePath(Str);
  Result := WithoutTrailingSlash(Result);
end;

function GetExeForExtension(const Ext: string): string;
var
  Reg: TRegistry;
  Str: string;
  Posi: Integer;
begin
  Str := '';
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.Access := KEY_READ;
  try
    if Reg.OpenKey('SOFTWARE\Classes\' + Ext + '\shell\open\command', False)
    then
    begin
      { The open command has been found }
      Str := Reg.ReadString('');
      Reg.CloseKey;
    end
    else
    begin
      { perhaps there is a system file pointer }
      if Reg.OpenKey('SOFTWARE\Classes\' + Ext, False) then
      begin
        try
          Str := Reg.ReadString('');
        except
          Str := '';
        end;
        Reg.CloseKey;
        if Str <> '' then
        begin
          { A system file pointer was found }
          if Reg.OpenKey('SOFTWARE\Classes\' + Str + '\Shell\Open\command',
            False) then
            { The open command has been found }
            Str := Reg.ReadString('');
          Reg.CloseKey;
        end;
      end;
    end;
  except
    Str := '';
  end;
  { Delete any command line, quotes and spaces }
  if Pos('%', Str) > 0 then
    Delete(Str, Pos('%', Str), Length(Str));
  Str := Trim(Str);
  Posi := Pos('.EXE', UpperCase(Str));
  if Posi > 0 then
    Delete(Str, Posi + 4, Length(Str));
  Posi := Pos('"', Str);
  if Posi = 1 then
  begin
    Delete(Str, 1, 1);
    Posi := Pos('"', Str);
    if Posi > 0 then
      Delete(Str, Posi, Length(Str));
  end;
  if FileExists(Str) then
    Result := Str
  else
    Result := '';
  FreeAndNil(Reg);
end;

const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;

function IsGroupMember(RelativeGroupID: DWORD): Boolean;
var
  PsidAdmin: Pointer;
  Token: THandle;
  Count: DWORD;
  TokenInfo: PTokenGroups;
  HaveToken: Boolean;
const
  SE_GROUP_USE_FOR_DENY_ONLY = $00000010;
begin
  Result := not(Win32Platform = VER_PLATFORM_WIN32_NT);
  if Result then // Win9x and ME don't have user groups
    Exit;
  PsidAdmin := nil;
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
        PsidAdmin));
      if GetTokenInformation(Token, TokenGroups, nil, 0, @Count) or
        (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
        RaiseLastOSError;
      TokenInfo := PTokenGroups(AllocMem(Count));
      Win32Check(GetTokenInformation(Token, TokenGroups, TokenInfo,
        Count, @Count));
{$ELSE FPC}
      Win32Check(AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, RelativeGroupID, 0, 0, 0, 0, 0, 0,
        PsidAdmin));
      if GetTokenInformation(Token, TokenGroups, nil, 0, Count) or
        (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
        RaiseLastOSError;
      TokenInfo := PTokenGroups(AllocMem(Count));
      Win32Check(GetTokenInformation(Token, TokenGroups, TokenInfo,
        Count, Count));
{$ENDIF FPC}
      for var I := 0 to TokenInfo^.GroupCount - 1 do
      begin
{$RANGECHECKS OFF} // Groups is an array [0..0] of TSIDAndAttributes, ignore ERangeError
        Result := EqualSid(PsidAdmin, TokenInfo^.Groups[I].Sid);
        if Result then
        begin
          // consider denied ACE with Administrator SID
          Result := TokenInfo^.Groups[I].Attributes and
            SE_GROUP_USE_FOR_DENY_ONLY <> SE_GROUP_USE_FOR_DENY_ONLY;
          Break;
        end;
{$IFDEF RANGECHECKS_ON}
{$RANGECHECKS ON}
{$ENDIF RANGECHECKS_ON}
      end;
    end;
  finally
    if Assigned(TokenInfo) then
      FreeMem(TokenInfo);
    if HaveToken then
      CloseHandle(Token);
    if Assigned(PsidAdmin) then
      FreeSid(PsidAdmin);
  end;
end;

function IsAdministrator: Boolean;
begin
  Result := IsGroupMember(DOMAIN_ALIAS_RID_ADMINS);
end;

function HasAssociationWithGuiPy(const Extension: string): Boolean;
var
  Str: string;
begin
  Str := UpperCase(GetExeForExtension(Extension));
  Result := Pos(UpperCase(ExtractFileName(ParamStr(0))), Str) > 0;
end;

function GetRegisteredGuiPy: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.Access := KEY_READ;
  if Reg.OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', False) then
    Result := Reg.ReadString('')
  else
    Result := '';
  Reg.CloseKey;
  var
  Posi := Pos(' "%1"', Result);
  if Posi > 0 then
    Result := Copy(Result, 1, Posi - 1);
  FreeAndNil(Reg);
end;

function HideBlanks(const Str: string): string;
begin
  if (Pos(' ', Str) > 0) and (Pos('"', Str) <> 1) then
    Result := AnsiQuotedStr(Str, '"')
  else
    Result := Str;
end;

function Left(const Str: string; Num: Integer): string;
begin
  if Num >= 0 then
    Result := Copy(Str, 1, Num)
  else
    Result := Copy(Str, 1, Length(Str) + Num);
end;

function Right(const Str: string; Num: Integer): string;
begin
  if Num >= 0 then
    Result := Copy(Str, Num, Length(Str))
  else
    Result := Copy(Str, Length(Str) + Num + 1, Length(Str));
end;

function CountChar(Chr: Char; const Str: string): Integer;
begin
  Result := 0;
  for var I := 1 to Length(Str) do
    if Str[I] = Chr then
      Inc(Result);
end;

procedure PrintBitmap(FormBitmap: TBitmap; PixelsPerInch: Integer;
  PrintScale: TPrintScale = poProportional);
var
  InfoSize: DWORD;
  ImageSize: DWORD;
  Bits: HBITMAP;
  DIBWidth, DIBHeight: LongInt;
  PrintWidth, PrintHeight: LongInt;
  Info: PBitmapInfo;
  Image: Pointer;
begin
  // analog to TCustomForm.Print
  Printer.BeginDoc;
  try
    FormBitmap.Canvas.Lock;
    try
      with Printer do
      begin
        Bits := FormBitmap.Handle;
        GetDIBSizes(Bits, InfoSize, ImageSize);
        Info := AllocMem(InfoSize);
        try
          Image := AllocMem(ImageSize);
          try
            GetDIB(Bits, 0, Info^, Image^);
            DIBWidth := Info.bmiHeader.biWidth;
            DIBHeight := Info.bmiHeader.biHeight;
            case PrintScale of
              poProportional:
                begin
                  PrintWidth :=
                    MulDiv(DIBWidth, GetDeviceCaps(Handle, LOGPIXELSX),
                    PixelsPerInch);
                  PrintHeight :=
                    MulDiv(DIBHeight, GetDeviceCaps(Handle, LOGPIXELSY),
                    PixelsPerInch);
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

function UpperLower(const Str: string): string;
begin
  Result := UpperCase(Copy(Str, 1, 1)) + Copy(Str, 2, Length(Str));
end;

function IsWordBreakChar(Chr: Char): Boolean; // fromSyneditSearch
begin
  case Chr of
    #0 .. #32, '.', ',', ';', ':', '"', '''', '´', '`', '°', '^', '!', '?', '&',
      '$', '@', '§', '%', '#', '~', '[', ']', '(', ')', '{', '}', '<', '>', '-',
      '=', '+', '*', '/', '\', '|':
      Result := True;
  else
    Result := False;
  end;
end;

function IsDigit(Chr: Char): Boolean;
begin
  Result := ('0' <= Chr) and (Chr <= '9');
end;

function WindowStateToStr(WindowState: TWindowState): string;
begin
  Result := IntToStr(Ord(WindowState));
end;

function StrToWindowState(const Str: string): TWindowState;
begin
  if Str = '0' then
    Result := wsNormal
  else if Str = '1' then
    Result := wsMinimized
  else
    Result := wsMaximized;
end;

function WithoutGeneric(Str: string): string;
var
  Int1, Int2: Integer;
begin
  Int1 := Pos('<', Str);
  if Int1 > 0 then
  begin
    Int2 := Length(Str);
    while (Int2 > 0) and (Str[Int2] <> '>') do
      Dec(Int2);
    Delete(Str, Int1, Int2 - Int1 + 1);
  end;
  if Pos('...', Str) > 0 then
    Str := Copy(Str, 1, Pos('...', Str) - 1);
  Result := Str;
end;

function GetShortType(Str: string): string;
var
  Posi: Integer;
begin
  Posi := Pos('.', Str);
  if Posi > 0 then
    Delete(Str, 1, Posi);
  Delete(Str, 1, LastDelimiter('.', Str));
  Posi := Pos('<', Str);
  if Posi > 1 then
    Str := Copy(Str, 1, Posi - 1);
  Result := Str;
end;

function GetShortTypeWith(Str: string): string;
var
  Posi: Integer;
begin
  Posi := Pos('.', Str);
  if Posi > 0 then
    Delete(Str, 1, Posi);
  Delete(Str, 1, LastDelimiter('.', Str));
  Result := Str;
end;

function GenericOf(const Str: string): string;
var
  Posi: Integer;
begin
  Result := '';
  Posi := Pos('<', Str);
  if Posi > 0 then
    Result := Copy(Str, Posi + 1, Length(Str) - Posi - 1);
end;

function VisibilityAsString(Vis: TVisibility): string;
begin
  case Vis of
    viPrivate:
      Result := '__';
    viProtected:
      Result := '_';
  else
    Result := '';
  end;
end;

function IsPythonType(AType: string): Boolean;
const
  PythonTypes: array [0 .. 39] of string = ('None', 'int', 'float', 'complex',
    'str', 'bool', 'list', 'tuple', 'range', 'set', 'dict', 'bytes',
    'bytearray', 'memoryview', 'frozenset', 'Optional', 'Callable', 'Type',
    'Literal', 'ClassVar', 'Annotated', 'Generic', 'TypeVar', 'AnyStr',
    'Protocol', 'Dict', 'List', 'Set', 'FrozenSet', 'DefaultDict',
    'OrderedDict', 'ChainMap', 'Counter', 'Deque', 'IO', 'TextIO', 'BinaryIO',
    'Pattern', 'Match', 'Text');
var
  Posi: Integer;
begin
  Posi := Pos('[', AType); // GenericType?
  if Posi > 0 then
    Delete(AType, Posi, Length(AType));
  for Posi := 0 to 39 do
    if PythonTypes[Posi] = AType then
      Exit(True);
  Result := False;
end;

function HasPythonExtension(const Pathname: string): Boolean;
begin
  Result := (Pos('.py', Pathname) > 0);
end;

function ValidFilename(Str: string): Boolean;
begin
  Str := UpperCase(ChangeFileExt(ExtractFileName(Str), ''));
  Result := (Str <> 'CON') and (Str <> 'PRN') and (Str <> 'AUX') and
    (Str <> 'NUL');
end;

function Max3(Int1, Int2, Int3: Integer): Integer;
begin
  Result := Max(Int1, Max(Int2, Int3));
end;

function Min3(Int1, Int2, Int3: Integer): Integer;
begin
  Result := Min(Int1, Min(Int2, Int3));
end;

var
  FLockFormUpdatePile: Integer;

procedure LockFormUpdate(Form: TForm);
begin
  if Assigned(Form) then
  begin
    if FLockFormUpdatePile = 0 then
      Form.Perform(WM_SETREDRAW, 0, 0);
    Inc(FLockFormUpdatePile);
  end;
end;

procedure UnlockFormUpdate(Form: TForm);
begin
  if Assigned(Form) then
  begin
    Dec(FLockFormUpdatePile);
    if FLockFormUpdatePile = 0 then
    begin
      Form.Perform(WM_SETREDRAW, 1, 0);
      RedrawWindow(Form.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE +
        RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);
    end;
  end;
end;

function WithoutArray(const Str: string): string;
var
  Int: Integer;
begin
  Result := Str;
  Int := Pos('[', Result) + Pos('...', Result);
  if Int > 0 then
    Result := Copy(Result, 1, Int - 1);
end;

function IsUNC(const Pathname: string): Boolean;
begin
  Result := (Pos('\\', Pathname) = 1);
end;

function ExtractFileNameEx(Str: string): string;
var
  Posi: Integer;
begin
  if Pos('file:///', Str) > 0 then
  begin
    Delete(Str, 1, 8);
    Str := MyStringReplace(Str, '/', '\');
  end;
  Str := StripHttpParams(Str);
  if IsHTTP(Str) then
  begin
    Posi := Length(Str);
    while (Str[Posi] <> '/') do
      Dec(Posi);
    Delete(Str, 1, Posi);
    if Str = '' then
      Str := 'index.html';
  end
  else if IsCHM(Str) then
  begin
    Posi := Pos('.CHM', UpperCase(Str));
    Delete(Str, 1, Posi + 3);
    if Copy(Str, 1, 2) = '::' then
      Delete(Str, 1, 2);
    Str := ExtractFileName(ToWindows(Str));
  end
  else
    Str := ExtractFileName(Str);
  Result := Str;
end;

function StripHttpParams(const Str: string): string;
var
  Posi: Integer;
  FNname: string;
begin
  FNname := ExtractFileName(Str);
  Posi := Pos('?', FNname);
  if Posi > 0 then
    Delete(FNname, Posi, Length(FNname));
  Posi := Pos('#', FNname);
  if Posi > 0 then
    Delete(FNname, Posi, Length(FNname));
  Result := ExtractFilePath(Str) + FNname;
end;

function ToWindows(Str: string): string;
var
  Posi: Integer;
begin
  Posi := Pos('/', Str);
  while Posi > 0 do
  begin
    Str[Posi] := '\';
    Posi := Pos('/', Str);
  end;
  Result := Str;
end;

function FileExistsCaseSensitive(const Filepath: string): Boolean;
begin
  if not FileExists(Filepath) then
    Exit(False);
  var Filename := ExtractFileName(Filepath);
  var FileNames := TDirectory.GetFiles(ExtractFilePath(Filepath), Filename);
  Result:= (ExtractFilename(FileNames[0]) = Filename);
end;

procedure SetAnimation(Value: Boolean);
var
  Info: TAnimationInfo;
begin
  Info.cbSize := SizeOf(TAnimationInfo);
  BOOL(Info.iMinAnimate) := Value;
  SystemParametersInfo(SPI_SETANIMATION, SizeOf(Info), @Info, 0);
end;

function IsDunder(const Name: string): Boolean;
begin
  Result := (Copy(Name, 1, 2) = '__') and
    (Copy(Name, Length(Name) - 1, 2) = '__');
end;

function StringTimesN(const Str: string; Num: Integer): string;
begin
  Result := '';
  for var I := 1 to Num do
    Result := Result + Str;
end;

function changeVowels(const Str: string): string;
const
  Vowels = 'ÄÖÜäöüß';
  Nowels = 'AOUaous';
var
  Posi: Integer;
begin
  Result := Str;
  for var I := 1 to Length(Vowels) do
  begin
    Posi := Pos(Vowels[I], Result);
    while Posi > 0 do
    begin
      Result[Posi] := Nowels[I];
      if I < 7 then
        Insert('e', Result, Posi + 1)
      else
        Insert('Str', Result, Posi + 1);
      Posi := Pos(Vowels[I], Result);
    end;
  end;
end;

function GetUniqueName(Control: TControl; Basename: string): string;
var
  Int: Integer;
  Str: string;
begin
  Basename := OnlyCharsAndDigits(changeVowels(Basename));
  if Control.FindComponent(Basename) = nil then
  begin
    Result := Basename;
    Exit;
  end;
  Str := Right(Basename, -1);
  while (Pos(Str, '0123456789') > 0) and (Length(Basename) > 2) do
  begin
    Basename := Left(Basename, Length(Basename) - 1);
    Str := Right(Basename, -1);
  end;
  Result := Basename;
  Int := 0;
  while Control.FindComponent(Result) <> nil do
  begin
    Inc(Int);
    Result := Basename + IntToStr(Int);
  end;
end;

function OnlyCharsAndDigits(const Str: string): string;
var
  Chr: Char;
begin
  Result := '';
  for var I := 1 to Length(Str) do
  begin
    Chr := Str[I];
    if not IsWordBreakChar(Chr) then
      Result := Result + Chr;
  end;
end;

function CodeSpaces(Str: string): string;
begin
  for var I := Length(Str) downto 1 do
    if Str[I] = ' ' then
    begin
      Delete(Str, I, 1);
      Insert('%20', Str, I);
    end;
  Result := Str;
end;

function ToWeb(const Browser: string; Str: string): string;
var
  Posi: Integer;
  IsUNC, IsDrive: Boolean;
begin
  IsUNC := (Copy(Str, 1, 2) = '\\');
  IsDrive := (Copy(Str, 2, 1) = ':');
  Str := CodeSpaces(Str);
  Posi := Pos('\', Str);
  while Posi > 0 do
  begin
    Str[Posi] := '/';
    Posi := Pos('\', Str);
  end;
  if IsUNC then
    if Pos('OPERA', UpperCase(Browser)) > 0 then
      Str := 'file:' + Str
    else
      Str := 'file://localhost/' + Str;
  if IsDrive then
    Str := 'file:///' + Str;
  Result := Str;
end;

function StartsWith(const Str, Substr: string): Boolean;
begin
  if Str <> '' then
    Result := CompareStr(Copy(Str, 1, Length(Substr)), Substr) = 0
  else
    Result := False;
end;

function LowerUpper(const Str: string): string;
begin
  Result := LowerCase(Copy(Str, 1, 1)) + Copy(Str, 2, Length(Str));
end;

function IsLower(Chr: Char): Boolean;
begin
  Result := CharInSet(Chr, ['a' .. 'z']);
end;

function RGB2Color(const Red, Green, Blue: Integer): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := Red + Green shl 8 + Blue shl 16;
end;

procedure Color2RGB(const Color: TColor; var Red, Green, Blue: Integer);
begin
  // convert hexa-decimal values to RGB
  Red := Color and $FF;
  Green := (Color shr 8) and $FF;
  Blue := (Color shr 16) and $FF;
end;

function AsString(const Str: string): string;
begin
  Result := '''' + Str + '''';
end;

function LeftSpaces(const Str: string; TabW: Integer): Integer;
var
  PChr: PWideChar;
begin
  PChr := PWideChar(Str);
  if Assigned(PChr) then
  begin
    Result := 0;
    while (PChr^ >= #1) and (PChr^ <= #32) do
    begin
      if (PChr^ = #9) then
        Inc(Result, TabW)
      else
        Inc(Result);
      Inc(PChr);
    end;
  end
  else
    Result := 0;
end;

function WithoutVisibility(Str: string): string;
var
  Posi: Integer;
begin
  while (Length(Str) > 0) and (Str[1] = '_') do
    Delete(Str, 1, 1);
  Posi := Pos('__', Str);
  if Posi > 0 then
    Delete(Str, 1, Posi + 1);
  Result := Str;
end;

function IsSimpleType(const Str: string): Boolean;
  const SimpleTypePython: array[1..4] of string =
          ('integer', 'boolean', 'float', 'string');
begin
  Result:= True;
  for var I:= 1 to 4 do
    if SimpletypePython[I] = Str then Exit;
  Result:= False;
end;

function ShellExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(Application.MainForm.Handle, 'open', PChar(FileName),
    PChar(Params), PChar(DefaultDir), ShowCmd);
end;

function FilenameToFileKind(const FileName: string): TFileKind;
var
  Extension: string;
begin
  Result := fkEditor;
  Extension := TPath.GetExtension(FileName);
  if IsHTTP(FileName) then
    Result := fkBrowser
  else if Extension = '.puml' then
    Result := fkUML
  else if Extension = '.py' then
    Result := fkEditor
  else if Extension = '.psd' then
    Result := fkSequencediagram
  else if Extension = '.psg' then
    Result := fkStructogram;
end;

{ --- Portable ----------------------------------------------------------------- }

function RemovePortableDrive(const Str: string; const Folder: string = ''): string;
// if Folder is set then switch to relative paths, used in Store/FetchDiagram
var
  SL1, SL2: TStringList;
  Int1, Int2: Integer;
  Basefolder: string;
begin
  Result := Str;
  if TPyScripterSettings.IsPortable then
    Basefolder := ExtractFilePath(Application.ExeName)
  else
    Basefolder := Folder;
  // same drive
  if TPath.IsDriveRooted(Basefolder) and
    (UpperCase(Copy(Basefolder, 1, 2)) = UpperCase(Copy(Str, 1, 2))) then
  begin
    SL1 := Split('\', WithoutTrailingSlash(Basefolder));
    SL2 := Split('\', WithoutTrailingSlash(Str));
    Int1 := 0;
    while (Int1 < SL1.Count) and (Int1 < SL2.Count) and
      (UpperCase(SL1[Int1]) = UpperCase(SL2[Int1])) do
      Inc(Int1);
    Result := '';
    Int2 := Int1;
    while Int1 < SL1.Count do
    begin
      Result := Result + '..\';
      Inc(Int1);
    end;
    while Int2 < SL2.Count do
    begin
      Result := Result + SL2[Int2] + '\';
      Inc(Int2);
    end;
    Result := WithoutTrailingSlash(Result);
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

function AddPortableDrive(const Str: string; const Folder: string = ''): string;
// if Folder is set then switch to relative paths, used in Store/FetchDiagram
var
  SL1, SL2: TStringList;
  Int1, Int2: Integer;
  Basefolder: string;
begin
  Result := Str;
  if (UUtils.Left(Str, 4) = 'its:') or (Str = '') or (Copy(Str, 2, 2) = ':\') or
    (Copy(Str, 1, 7) = 'file://') or // absolute path
    (Pos('\\', Str) = 1) or (Pos('://', Str) > 1) then
  // UNC or https:// or http://
    Exit;

  if TPyScripterSettings.IsPortable then
    Basefolder := ExtractFilePath(Application.ExeName)
  else
    Basefolder := Folder;

  if Basefolder <> '' then
  begin
    SL1 := Split('\', WithoutTrailingSlash(Basefolder));
    SL2 := Split('\', WithoutTrailingSlash(Str));
    Int1 := 0;
    while (Int1 < SL2.Count) and (SL2[Int1] = '..') do
      Inc(Int1);
    Result := SL1[0];
    for Int2 := 1 to SL1.Count - 1 - Int1 do
      Result := Result + '\' + SL1[Int2];
    for Int2 := Int1 to SL2.Count - 1 do
      Result := Result + '\' + SL2[Int2];
    FreeAndNil(SL1);
    FreeAndNil(SL2);
  end;
end;

function GetProtocol(const Url: string): string;
var
  Posi: Integer;
begin
  Posi := Pos('://', Url);
  if Posi > 0 then
    Result := Copy(Url, 1, Posi + 2)
  else
    Result := '';
end;

function GetProtocolAndDomain(Url: string): string;
var
  Posi: Integer;
  Protocol: string;
begin
  Protocol := GetProtocol(Url);
  Delete(Url, 1, Length(Protocol));
  Posi := Pos('/', Url);
  if Posi > 0 then
    Result := Protocol + Copy(Url, 1, Posi - 1)
  else
    Result := Protocol + Url;
end;

function IsHTML(const Pathname: string): Boolean;
begin
  Result := (Pos('.HTM', UpperCase(ExtractFileExt(Pathname))) > 0);
end;

function HttpToWeb(Str: string): string;
var
  Posi: Integer;
begin
  Posi := Pos('\', Str);
  while Posi > 0 do
  begin
    Str[Posi] := '/';
    Posi := Pos('\', Str);
  end;
  Result := Str;
end;

// needs WinInet
function DownloadURL(const Url, FileName: string): Boolean;
var
  HSession: HINTERNET;
  HService: HINTERNET;
  LpBuffer: array [0 .. 1024 + 1] of Char;
  DwBytesRead: DWORD;
  AFile: TFileStream;
begin
  Result := False;
  try
    AFile := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
    HSession := InternetOpen('Java-Editor', INTERNET_OPEN_TYPE_PRECONFIG,
      nil, nil, 0);
    try
      if Assigned(HSession) then
      begin
        HService := InternetOpenUrl(HSession, PChar(Url), nil, 0,
          INTERNET_FLAG_RELOAD, 0);
        if Assigned(HService) then
          try
            while True do
            begin
              DwBytesRead := 1024;
              InternetReadFile(HService, @LpBuffer, 1024, DwBytesRead);
              if DwBytesRead = 0 then
                Break;
              Application.ProcessMessages;
              AFile.Write(LpBuffer[0], DwBytesRead);
            end;
            Result := True;
          finally
            InternetCloseHandle(HService);
          end;
      end;
    finally
      InternetCloseHandle(HSession);
      FreeAndNil(AFile);
    end;
  except
    on e: Exception do
      ErrorMsg(e.Message);
  end;
end;

procedure SetElevationRequiredState(AControl: TWinControl);
const
  BCM_FIRST = $1600;
  BCM_SETSHIELD = BCM_FIRST + $000C;
begin
  SendMessage(AControl.Handle, BCM_SETSHIELD, 0, Integer(True));
end;

function CanActuallyFocus(WinControl: TWinControl): Boolean;
var
  Form: TCustomForm;
begin
  Result := False;
  if Assigned(WinControl) and not WinControl.Focused then
  begin
    Form := GetParentForm(WinControl);
    if Assigned(Form) and Form.Enabled and Form.Visible then
      Result := WinControl.CanFocus;
  end;
end;

function IsNumber(var Str: string): Boolean;
var
  Dou: Double;
  Posi: Integer;
begin
  Posi := Pos('.', Str);
  if Posi > 0 then
    Str[Posi] := FormatSettings.DecimalSeparator;
  Result := TryStrToFloat(Str, Dou);
  Posi := Pos(FormatSettings.DecimalSeparator, Str);
  if Posi > 0 then
    Str[Posi] := '.';
end;

function IsBool(const Str: string): Boolean;
begin
  Result := (Str = 'True') or (Str = 'False');
end;

function DecToBase(Base: Integer; DecValue: Double): string;
{ Function   : converts decimal integer to base n, max = Base36
  Parameters : Base     = base number, ie. Hex is base 16
  DecValue = decimal to be converted
  LeadZeros = min number of digits if leading zeros required
  Returns    : number in base n as string }
var
  BaseString, DecToStr, Frac: string;
  Modulus, Posi, IntVal, FracVal: Integer;
  Negative: Boolean;
begin
  Result := '';
  BaseString := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'; { max = Base36 }
  if DecValue < 0 then
  begin
    Negative := True;
    DecValue := -DecValue;
  end
  else
    Negative := False;
  DecToStr := FloatToStrF(DecValue, ffGeneral, 15, 8);
  Posi := Pos('.', DecToStr);
  if Posi > 0 then
  begin
    IntVal := StrToInt(Copy(DecToStr, 1, Posi - 1));
    FracVal := StrToInt(Copy(DecToStr, Posi + 1, Length(DecToStr)));
  end
  else
  begin
    IntVal := StrToInt(DecToStr);
    FracVal := 0;
  end;
  while IntVal > 0 do
  begin
    Modulus := IntVal mod Base; { remainder is next digit }
    Result := BaseString[Modulus + 1] + Result;
    IntVal := IntVal div Base;
  end;
  if (FracVal > 0) and (Base = 10) then
  begin
    Frac := '';
    while FracVal > 0 do
    begin
      Modulus := FracVal mod Base; { remainder is next digit }
      Frac := BaseString[Modulus + 1] + Frac;
      FracVal := FracVal div Base;
    end;
    Result := Result + '.' + Frac;
  end;
  if Result = '' then
    Result := '0';
  if Negative then
    Result := '-' + Result;
end;

function ConvertLtGt(const Str: string): string;
begin
  Result := ReplaceStr(ReplaceStr(Str, '<', '&lt;'), '>', '&gt;');
end;

function FloatToVal(AFloat: Real): string;
begin
  Result := '"' + FloatToStr(AFloat) + '"';
  var
  Posi := Pos(',', Result);
  if Posi > 0 then
    Result[Posi] := '.';
end;

function PointToVal(Point: TPoint): string;
begin
  Result := IntToStr(Point.X) + ',' + IntToStr(Point.Y) + ' ';
end;

function IntToVal(Int: Integer): string;
begin
  Result := '"' + IntToStr(Int) + '"';
end;

function MyColorToRGB(Color: TColor): string;
var
  ColorInt, Red, Green, Blue: Integer;
begin
  ColorInt := ColorToRGB(Color);
  Red := GetRValue(ColorInt);
  Green := GetGValue(ColorInt);
  Blue := GetBValue(ColorInt);
  Result := 'rgb(' + IntToStr(Red) + ',' + IntToStr(Green) + ',' +
    IntToStr(Blue) + ')';
end;

function XYToVal(Xpos, YPos: Integer): string;
begin
  Result := IntToStr(Xpos) + ',' + IntToStr(YPos) + ' ';
end;

function CalcIndent(const Str: string; TabWidth: Integer = 4): Integer;
begin
  Result := 0;
  for var I := 1 to Length(Str) do
    if Str[I] = #9 then
      Inc(Result, TabWidth)
    else if Str[I] = ' ' then
      Inc(Result)
    else
      Break;
end;

function EncodeQuotationMark(const Str: string): string;
begin
  Result := ReplaceStr(Str, '"', '&quot;');
end;

function MyMulDiv(Number, Numerator, Denominator: Integer): Integer;
begin
  Result := MulDiv(Number, Numerator, Denominator);
end;

procedure LockWindow(Handle: THandle);
begin
  LockWindowUpdate(Handle);
end;

procedure UnLockWindow;
begin
  LockWindowUpdate(0);
end;

function IsColorDark(AColor: TColor): Boolean;
var
  ACol: LongInt;
begin
  ACol := ColorToRGB(AColor) and $00FFFFFF;
  Result := ((2.99 * GetRValue(ACol) + 5.87 * GetGValue(ACol) + 1.14 *
    GetBValue(ACol)) < $400);
end;

end.
