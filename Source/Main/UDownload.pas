unit UDownload;

interface

uses
  System.Classes,
  Vcl.Dialogs,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  dlgPyIDEBase;

type
  TFDownload = class(TPyIDEDlgBase)
    LUrl: TLabel;
    EUrl: TEdit;
    ProgressBar: TProgressBar;
    TimerDownload: TTimer;
    BCancel: TButton;
    EFile: TEdit;
    LFile: TLabel;
    BDownload: TButton;
    SaveDialog: TSaveDialog;
    SPOpen: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure TimerDownloadTimer(Sender: TObject);
    procedure BDownloadClick(Sender: TObject);
    procedure SPOpenClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
  private
    FFileURL: string;
    FFileName: string;
    FCancel: Boolean;
  public
    function GetInetFile(const AFileURL, AFileName: string;
      const Progress: TProgressBar): Boolean;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  Winapi.WinInet,
  System.SysUtils,
  Vcl.Forms,
  JvGnugettext,
  StringResources,
  UUtils;

procedure TFDownload.FormShow(Sender: TObject);
begin
  BCancel.Enabled := False;
  ProgressBar.Position := 0;
  FCancel := False;
end;

procedure TFDownload.SPOpenClick(Sender: TObject);
begin
  SaveDialog.FileName := ExtractFileName(EFile.Text);
  SaveDialog.InitialDir := ExtractFilePath(EFile.Text);
  if SaveDialog.Execute then
  begin
    FFileName := SaveDialog.FileName;
    EFile.Text := FFileName;
    EFile.Hint := FFileName;
  end;
end;

procedure TFDownload.BDownloadClick(Sender: TObject);
begin
  BDownload.Enabled := False;
  BCancel.Enabled := False;
  FFileURL := EUrl.Text;
  FFileName := EFile.Text;
  var
  Dir := ExtractFilePath(FFileName);
  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);
  TimerDownload.Enabled := True;
end;

procedure TFDownload.BCancelClick(Sender: TObject);
begin
  FCancel := True;
end;

function TFDownload.GetInetFile(const AFileURL, AFileName: string;
  const Progress: TProgressBar): Boolean;
const
  BufferSize = 1024;
var
  HSession, HUrl: HINTERNET;
  Buffer: array [0 .. BufferSize + 1] of Byte;
  Code: array [1 .. 20] of Char;
  BufferLen, Index, CodeLen: DWORD;
  AppName: string;
  AFile: TFileStream;

  function CodeToString: string;
  begin
    Result := '';
    var
    Int := 1;
    while (Int <= 20) and (Code[Int] <> #0) do
    begin
      Result := Result + Code[Int];
      Inc(Int);
    end;
  end;

  function GetHTTPStatus: string;
  begin
    Result := '';
    Index := 0;
    if HttpQueryInfo(HUrl, HTTP_QUERY_STATUS_CODE, @Code, CodeLen, Index) then
      Result := CodeToString; // 200, 401, 404 or 500
  end;

  function GetFileSize: Integer;
  var
    Value: Integer;
  begin
    Result := 0;
    Index := 0;
    if HttpQueryInfo(HUrl, HTTP_QUERY_CONTENT_LENGTH, @Code, CodeLen, Index)
    then
      if TryStrToInt(CodeToString, Value) then
        Result := Value;
  end;

begin
  Result := False;
  CodeLen := Length(Code);
  AppName := ExtractFileName(Application.ExeName);
  HSession := InternetOpen(PChar(AppName), INTERNET_OPEN_TYPE_PRECONFIG,
    nil, nil, 0);
  try
    HUrl := InternetOpenUrl(HSession, PChar(AFileURL), nil, 0,
      INTERNET_FLAG_DONT_CACHE, 0);

    if Assigned(HUrl) then
    begin
      if GetHTTPStatus <> '200' then
        Exit(False);
      BCancel.Enabled := True;
      Progress.Max := GetFileSize;
      AFile := TFileStream.Create(AFileName, fmCreate or fmShareExclusive);
      try
        try
          try
            repeat
              InternetReadFile(HUrl, @Buffer, SizeOf(Buffer), BufferLen);
              AFile.Write(Buffer[0], BufferLen);
              if Assigned(Progress) and (Progress.Max > 0) then
                Progress.StepBy(SizeOf(Buffer));
              Application.ProcessMessages;
            until FCancel or (BufferLen = 0);
          except
            on E: Exception do
              EFile.Text := Format(_(SFileSaveError), [AFileName, E.Message]);
          end;
        finally
          FreeAndNil(AFile);
        end;
        Result := not FCancel;
      finally
        InternetCloseHandle(HUrl);
      end;
    end
    else
      ErrorMsg(_('No internet connection') + ' ' +
        SysErrorMessage(GetLastError));
  finally
    InternetCloseHandle(HSession);
    BCancel.Enabled := True;
  end;
end;

procedure TFDownload.TimerDownloadTimer(Sender: TObject);
var
  DownloadIsOk: Boolean;
begin
  TimerDownload.Enabled := False;
  Screen.Cursor := crHourGlass;
  try
    DownloadIsOk := GetInetFile(FFileURL, FFileName, ProgressBar);
  finally
    Screen.Cursor := crDefault;
  end;
  if DownloadIsOk then
    BCancel.Caption := _('&OK');
  BDownload.Enabled := True;
end;

end.
