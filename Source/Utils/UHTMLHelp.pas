unit UHTMLHelp;

interface

uses
  Windows,
  ActiveX;

type
  SNB = PChar; // from objidl.h

  TCompactionLev = (COMPACT_DATA, COMPACT_DATA_AND_PATH);

  PItsControlData = ^TItsControlData;
    TITS_Control_Data = record
    cdwControlData: UINT;
    adwControlData: array [0..0] of UINT;
  end;
  TItsControlData = TITS_Control_Data;

  IItsStorage = interface (IUnknown)
    function StgCreateDocFile(const PwcsName: PChar; GrfMode: DWORD;
      Reserved: DWORD; var PpstgOpen: IStorage): HRESULT; stdcall;

    function StgCreateDocFileOnILockBytes(Plkbyt: ILockBytes; GrfMode: DWORD;
      Reserved: DWORD; var PpstgOpen: IStorage): HRESULT; stdcall;

    function StgIsStorageFile(const PwcsName: PChar): HRESULT; stdcall;

    function StgIsStorageILockBytes(Plkbyt: ILockBytes): HRESULT; stdcall;

    function StgOpenStorage(const PwcsName: PChar; PpstgPriority: IStorage;
      GrfMode: DWORD; SnbExclude: SNB; Reserved: DWORD; var PpstgOpen: IStorage): HRESULT; stdcall;

    function StgOpenStorageOnILockBytes(Plkbyt: ILockBytes; PpstgPriority: IStorage;
      GrfMode: DWORD; SnbExclude: SNB; Reserved: DWORD; var PpstgOpen: IStorage): HRESULT; stdcall;

    function StgSetTimes(const LpszName: PChar; const Pctime, Patime,
      Pmtime: TFileTime): HRESULT; stdcall;

    function SetControlData(PControlData: PItsControlData): HRESULT; stdcall;

    function DefaultControlData(var PpControlData: PItsControlData): HRESULT; stdcall;

    function Compact(const PwcsName: PChar; ILev: TCompactionLev): HRESULT; stdcall;
  end;

function GetRootCHM(const Str: string): string;
function LoadFromCHM(const AFile: string): string;

implementation

uses SysUtils, ComObj, UUtils;

const
  CLSID_ITStorage: TGUID = (D1:$5d02926a; D2:$212e; D3:$11d0; D4:($9d,$f9,$00,$a0,$c9,$22,$e6,$ec));
  IID_ITStorage: TGUID = (D1:$88cc31de; D2:$27ab; D3:$11d0; D4:($9d,$f9,$00,$a0,$c9,$22,$e6,$ec));

var
  MDumpBuffer: array of AnsiChar;

function GetRootCHM(const Str: string): string;
var
  ItsStorage: IItsStorage;
  Storage: IStorage;
  Enumerator: IEnumSTATSTG;
  StatStg: TStatStg;
  NumFetched: LongInt;
  HRes: HRESULT;
  Text: string;
  Filename: string;
begin
  Result:= '';
  Filename:= Str;
  try
    OleCheck(CoCreateInstance(CLSID_ITStorage, nil, CLSCTX_INPROC_SERVER, IID_ITStorage, ItsStorage));
    OleCheck(ItsStorage.StgOpenStorage(PChar(Filename), nil, STGM_READ or STGM_SHARE_DENY_WRITE, nil, 0, Storage));
    OleCheck(Storage.EnumElements(0, nil, 0, Enumerator));
    repeat
      HRes:= Enumerator.Next(1, StatStg, @NumFetched);
      if (HRes = S_OK) and (StatStg.pwcsName <> '') then begin
        Text:= StatStg.pwcsName;
        if (Pos('$', Text) = 0) and (StatStg.dwType = STGTY_STORAGE) then
          Result:= Text;
        CoTaskMemFree(StatStg.pwcsName);
      end;
    until HRes <> S_OK;
    Result:= '\' + Result;
  except
    ErrorMsg('Cannot read: ' + Str);
  end;
end;

function LoadFromCHM(const AFile: string): string;
const
  FILENAME_LENGTH = 400;
var
  ItsStorage: IItsStorage;
  Storage, SubStorage: IStorage;
  Stream: IStream;
  BytesRead: LongInt;
  TotalRead, Posi: Integer;
  CHMDatei, Pfad, Str: string;
  WStr: string;
begin
  Result:= '';
  try
    Posi:= Pos('.CHM', UpperCase(AFile));
    CHMDatei:= Copy(AFile, 1, Posi + 3);
    Pfad:= Copy(AFile, Posi + 5, Length(AFile));
    OleCheck(CoCreateInstance(CLSID_ITStorage, nil, CLSCTX_INPROC_SERVER, IID_ITStorage, ItsStorage));
    OleCheck(ItsStorage.StgOpenStorage(PChar(CHMDatei), nil, STGM_READ or STGM_SHARE_DENY_WRITE, nil, 0, Storage));
    Posi:= Pos('\', Pfad);
    while Posi > 0 do begin
      WStr:= Copy(Pfad, 1, Posi-1);
      Delete(Pfad, 1, Posi);
      OleCheck(Storage.OpenStorage(PWideChar(WStr), nil, STGM_READ or STGM_SHARE_DENY_WRITE, nil, 0, SubStorage));
      Storage := SubStorage;
      Posi:= Pos('\', Pfad);
    end;
    WStr:= Pfad;
    OleCheck(Storage.OpenStream(PWideChar(WStr), nil, STGM_READ or STGM_SHARE_EXCLUSIVE, 0, Stream));
    TotalRead := 0;
    SetLength(MDumpBuffer, 0);
    repeat
      SetLength(MDumpBuffer, TotalRead + 128);
      OleCheck(Stream.Read(@MDumpBuffer[TotalRead], 128, @BytesRead));
      TotalRead := TotalRead + BytesRead;
    until BytesRead <> 128;
    SetLength(MDumpBuffer, TotalRead);
    Str:= string(PAnsiChar(MDumpBuffer));
    Result:= Str;
  except on E: Exception do
    OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
  end;
end;

end.

