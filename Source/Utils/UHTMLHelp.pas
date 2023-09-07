unit UHTMLHelp;

interface

uses
  Windows, ActiveX;

//From KeyWorks CITS.H

type
  SNB = PChar; // from objidl.h

  TCompactionLev = (COMPACT_DATA, COMPACT_DATA_AND_PATH);

  PItsControlData = ^TItsControlData;
    _ITS_Control_Data = record
    cdwControlData: UINT;
    adwControlData: array [0..0] of UINT;
  end;
  TItsControlData = _ITS_Control_Data;

  IItsStorage = interface (IUnknown)
    function StgCreateDocFile(const pwcsName: PChar; grfMode: DWORD;
      reserved: DWORD; var ppstgOpen: IStorage): HRESULT; stdcall;

    function StgCreateDocFileOnILockBytes(plkbyt: ILockBytes; grfMode: DWORD;
      reserved: DWORD; var ppstgOpen: IStorage): HRESULT; stdcall;

    function StgIsStorageFile(const pwcsName: PChar): HRESULT; stdcall;

    function StgIsStorageILockBytes(plkbyt: ILockBytes): HRESULT; stdcall;

    function StgOpenStorage(const pwcsName: PChar; pstgPriority: IStorage;
      grfMode: DWORD; snbExclude: SNB; reserved: DWORD; var ppstgOpen: IStorage): HRESULT; stdcall;

    function StgOpenStorageOnILockBytes(plkbyt: ILockBytes; pStgPriority: IStorage;
      grfMode: DWORD; snbExclude: SNB; reserved: DWORD; var ppstgOpen: IStorage): HRESULT; stdcall;

    function StgSetTimes(const lpszName: PChar; const pctime, patime,
      pmtime: TFileTime): HRESULT; stdcall;

    function SetControlData(pControlData: PItsControlData): HRESULT; stdcall;

    function DefaultControlData(var ppControlData: PItsControlData): HRESULT; stdcall;

    function Compact(const pwcsName: PChar; iLev: TCompactionLev): HRESULT; stdcall;
  end;

  function GetRootCHM(const s: string): string;
  function LoadFromCHM(const afile: string): string;

implementation

uses SysUtils, ComObj, UUtils;

const
  CLSID_ITStorage: TGUID = (D1:$5d02926a; D2:$212e; D3:$11d0; D4:($9d,$f9,$00,$a0,$c9,$22,$e6,$ec));
  IID_ITStorage: TGUID = (D1:$88cc31de; D2:$27ab; D3:$11d0; D4:($9d,$f9,$00,$a0,$c9,$22,$e6,$ec));

var
  mDumpBuffer: array of AnsiChar;

function GetRootCHM(const s: string): string;
var
  ItsStorage: IItsStorage;
  Storage: IStorage;
  Enumerator: IEnumStatStg;
  StatStg: TStatStg;
  NumFetched: Longint;
  HR: HResult;
  text: String;
  filename: String;
begin
  Result:= '';
  filename:= s;
  try
    OleCheck(CoCreateInstance(CLSID_ITStorage, nil, CLSCTX_INPROC_SERVER, IID_ITStorage, ItsStorage));
    OleCheck(ItsStorage.StgOpenStorage(PChar(fileName), nil, STGM_READ or STGM_SHARE_DENY_WRITE, nil, 0, Storage));
    OleCheck(Storage.EnumElements(0, nil, 0, Enumerator));
    repeat
      HR:= Enumerator.Next(1, StatStg, @NumFetched);
      if (HR = S_OK) and (StatStg.pwcsName <> '') then begin
        text:= StatStg.pwcsName;
        if (Pos('$', text) = 0) and (StatStg.dwType = STGTY_STORAGE) then
          Result:= text;
        CoTaskMemFree(StatStg.pwcsName);
      end;
    until HR <> S_OK;
    Result:= '\' + Result;
  except
    ErrorMsg('Cannot read: ' + s);
  end;
end;

function LoadFromCHM(const afile: string): string;
const
  FILENAME_LENGTH = 400;
var
  ItsStorage: IItsStorage;
  Storage, SubStorage: IStorage;
  Stream: IStream;
  BytesRead: Longint;
  TotalRead, p: Integer;
  CHMDatei, Pfad, s: String;
  ws: String;
begin
  Result:= '';
  try
    p:= Pos('.CHM', Uppercase(afile));
    CHMDatei:= Copy(afile, 1, p + 3);
    Pfad:= Copy(afile, p + 5, length(afile));
    OleCheck(CoCreateInstance(CLSID_ITStorage, nil, CLSCTX_INPROC_SERVER, IID_ITStorage, ItsStorage));
    OleCheck(ItsStorage.StgOpenStorage(PChar(CHMDatei), nil, STGM_READ or STGM_SHARE_DENY_WRITE, nil, 0, Storage));
    p:= Pos('\', Pfad);
    while p > 0 do begin
      ws:= Copy(Pfad, 1, p-1);
      delete(Pfad, 1, p);
      OleCheck(Storage.OpenStorage(PWideChar(ws), nil, STGM_READ or STGM_SHARE_DENY_WRITE, nil, 0, SubStorage));
      Storage := SubStorage;
      p:= Pos('\', Pfad);
    end;
    ws:= Pfad;
    OleCheck(Storage.OpenStream(PWideChar(ws), nil, STGM_READ or STGM_SHARE_EXCLUSIVE, 0, Stream));
    TotalRead := 0;
    SetLength(mDumpBuffer, 0);
    repeat
      SetLength(mDumpBuffer, TotalRead + 128);
      OleCheck(Stream.Read(@mDumpBuffer[TotalRead], 128, @BytesRead));
      TotalRead := TotalRead + BytesRead;
    until BytesRead <> 128;
    SetLength(mDumpBuffer, TotalRead);
    s:= string(PAnsiChar(mDumpBuffer));
    Result:= s;
  except
  end;
end;

end.

