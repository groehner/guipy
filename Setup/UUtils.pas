unit UUtils;

interface

uses SysUtils, Windows, Classes, Consts, Vcl.StdCtrls;

type
  EInvalidDest = class(EStreamError);
  EFCantMove = class(EStreamError);

function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
function IsAdmin: Boolean;
function GetTempDir: string;
function HideBlanks(s: string): string;
function UnHideBlanks(s: string): string;
function decodeQuotationMark(s: string): string;
function myStringReplace(ImString: string; const DenString, DurchString: string): string;
function Split(Delimiter: Char; Input: string): TStringList;
function withoutTrailingSlash(s: string): string;
function GetSpecialFolderPath(CSIDLFolder: Integer): string;
function IsWebView2RuntimeNeeded(): Boolean;

implementation

uses Dialogs, Forms, ShlObj, RTLConsts, ShellAPI, System.UITypes, Registry;

function ExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(0, nil,
    PChar(FileName),PChar(Params), PChar(DefaultDir), ShowCmd);
end;

function IsAdmin: Boolean;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =
    (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS     = $00000220;
var
  hAccessToken       : THandle;
  ptgGroups          : PTokenGroups;
  dwInfoBufferSize   : Cardinal;
  psidAdministrators : PSID;
  x                  : Integer;
begin
  Result := False;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    Exit;
  if not OpenThreadToken(GetCurrentThread, TOKEN_QUERY,
                         TRUE, hAccessToken) then begin
    if GetLastError <> ERROR_NO_TOKEN then
      Exit;
    if not OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
                            hAccessToken) then
      Exit;
  end;
  try
    GetTokenInformation(hAccessToken, TokenGroups, nil,
                        0, dwInfoBufferSize);
    if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
      Exit;
    GetMem(ptgGroups, dwInfoBufferSize);
    try
      if not GetTokenInformation(hAccessToken, TokenGroups, ptgGroups,
                                 dwInfoBufferSize, dwInfoBufferSize) then
        Exit;
      if not AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
             SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
             0, 0, 0, 0, 0, 0, psidAdministrators) then
        Exit;
      try
        for x := 0 to ptgGroups^.GroupCount - 1 do begin
          if EqualSid(psidAdministrators, ptgGroups^.Groups[x].Sid) then begin
            Result := True;
            Break;
          end;
        end;
      finally
        FreeSid(psidAdministrators);
      end;
    finally
      FreeMem(ptgGroups);
    end;
  finally
    CloseHandle(hAccessToken);
  end;
end; {Michael Winter}

function GetTempDir: string;
  var P: PChar;
begin
  P:= StrAlloc(255);
  GetTempPath(255, P);
  Result:= string(P);
end;

function HideBlanks(s: string): string;
begin
  if (Pos(' ', s) > 0) and (Pos('"', s) <> 1)
    then Result:= '"' + s + '"'
    else Result:= s;
end;

function UnHideBlanks(s: string): string;
begin
  if Pos('"', s) = 1
    then Result:= Copy(s, 2, Length(s) - 2)
    else Result:= s;
end;

function decodeQuotationMark(s: string): string;
begin
  Result:= myStringReplace(s, '&quot;', '"');
end;

function myStringReplace(ImString: string; const DenString, DurchString: string): string;
begin
  Result:= StringReplace(Imstring, DenString, DurchString, [rfReplaceAll, rfIgnoreCase]);
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

function withoutTrailingSlash(s: string): string;
begin
  if (Copy(s, Length(s), 1) = '/') or (Copy(s, Length(s), 1) = '\') then
    SetLength(s, Length(s)-1);
  Result:= s;
end;

function GetSpecialFolderPath(CSIDLFolder: Integer): string;
var
   FilePath: array [0..MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDLFolder, 0, 0, FilePath);
  Result := FilePath;
end;

function IsWebView2RuntimeNeeded(): Boolean;
{ See: https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution#detect-if-a-suitable-webview2-runtime-is-already-installed }
var
    Version: string;
    RuntimeNeeded: Boolean;
    VerifyRuntime: Boolean;

  function ReadString(Root: HKEY; const key, aName, default: string): string;
     var Reg: TRegistry;
  begin
    Reg:= TRegistry.Create;
    with Reg do begin
      RootKey:= Root;
      Access:= KEY_READ;
      try
        OpenKey(key, False);
        if ValueExists(aName)
          then Result:= ReadString(aName)
          else Result:= Default;
      finally
        CloseKey;
      end;
    end;
    FreeAndNil(Reg);
  end;

begin
  RuntimeNeeded := True;
  VerifyRuntime := False;
  { Since we are using an elevated installer I am not checking HKCU }
  {$IFDEF WIN32}
    var key:= 'SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
    Version:= ReadString(HKEY_LOCAL_MACHINE, key, 'pv', '');
    if Version = '' then begin
      key:= 'Software\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
      Version:= ReadString(HKEY_CURRENT_USER, key, 'pv', '');
    end;
    if Version <> '' then
      VerifyRuntime:= True;
  {$ENDIF}
  {$IFDEF WIN64}
    var key:= 'SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
    Version:= ReadString(HKEY_LOCAL_MACHINE, key, 'pv', '');
    if Version = '' then begin
      key:= 'Software\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
      Version:= ReadString(HKEY_CURRENT_USER, key, 'pv', '');
    end;
    if Version <> '' then
      VerifyRuntime:= True;
  {$ENDIF}

  { Verify the version information }
  if VerifyRuntime and (Version <> '0.0.0.0') then
    RuntimeNeeded := False;
  Result := RuntimeNeeded;
end;

end.
