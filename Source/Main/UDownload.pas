unit UDownload;

interface

uses
  System.Classes, Dialogs, Vcl.Controls, StdCtrls, ComCtrls, ExtCtrls, Buttons,
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
    fileURL: string;
    fileName: string;
    Cancel: boolean;
  public
    function GetInetFile(const aFileURL, aFileName: string; const Progress: TProgressBar): boolean;
  end;

implementation

{$R *.dfm}

uses Windows, SysUtils, Forms, WinINet, jvGnugettext, UUtils;

procedure TFDownload.FormShow(Sender: TObject);
begin
  BCancel.Enabled:= false;
  ProgressBar.Position:= 0;
  Cancel:= false;
  ParentFont:= false;
end;

procedure TFDownload.SPOpenClick(Sender: TObject);
begin
  SaveDialog.FileName:= ExtractFileName(EFile.Text);
  SaveDialog.InitialDir:= ExtractFilePath(EFile.Text);
  if SaveDialog.Execute then begin
    Filename:= SaveDialog.FileName;
    EFile.Text:= FileName;
    EFile.Hint:= FileName;
  end;
end;

procedure TFDownload.BDownloadClick(Sender: TObject);
  var dir: String;
begin
  BDownload.Enabled:= false;
  BCancel.Enabled:= false;
  FileUrl:= EUrl.Text;
  FileName:= EFile.Text;
  dir:= ExtractFilePath(Filename);
  if not DirectoryExists(dir) then
    ForceDirectories(dir);
  TimerDownload.Enabled:= true;
end;

procedure TFDownload.BCancelClick(Sender: TObject);
begin
  Cancel:= true;
end;

function TFDownload.GetInetFile(const aFileURL, aFileName: string; const Progress: TProgressBar): boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[0..BufferSize+1] of Byte;
  code : array[1..20] of Char;
  codes: string;
  Value: integer;
  BufferLen,
  Index,
  CodeLen: DWord;
  sAppName: string;
  aFile: TFileStream;
  KnowSize: boolean;

  function codeToString: string;
  begin
    Result:= '';
    var i:= 1;
    while (i <= 20) and (code[i] <> #0) do begin
      Result:= Result + code[i];
      inc(i);
    end;
  end;

begin
  result := false;
  sAppName := ExtractFileName(Application.ExeName) ;
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0) ;
  try
    hURL:= InternetOpenURL(hSession, PChar(aFileURL), nil, 0, INTERNET_FLAG_DONT_CACHE, 0);
    if assigned(hURL) then begin
      try
        try
          // get HTTP status
          Index:= 0;
          CodeLen:= Length(code);
          if HttpQueryInfo(hURL, HTTP_QUERY_STATUS_CODE, @code, CodeLen, Index) then begin
            codes:= codeToString; // 200, 401, 404 or 500
            if codes <> '200' then exit(false);
          end;

          // get file size
          KnowSize:= false;
          if Progress <> nil then begin
            KnowSize:= true;
            Index := 0;
            CodeLen := Length(Code);
            HttpQueryInfo(hURL, HTTP_QUERY_CONTENT_LENGTH, @code, CodeLen, Index);
            codes:= codeToString;
            if TryStrToInt(codes, Value)
              then Progress.Max:= Value
              else KnowSize:= false;
          end;
          BCancel.Enabled:= true;

          // get file
          aFile:= TFileStream.Create(aFileName, fmCreate or fmShareExclusive);
          repeat
            InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
            aFile.Write(Buffer[0], BufferLen);
            if (Progress <> nil) and KnowSize then
              Progress.StepBy(SizeOf(Buffer));
            Application.ProcessMessages;
          until Cancel or (BufferLen = 0);
          FreeAndNil(aFile);

          result:= not Cancel;
        except on e: Exception do
          EFile.Text:= Format(_('Can''t create file %s!' + sLineBreak + 'Error: %s'), [aFilename, e.Message]);
        end
      finally
        InternetCloseHandle(hURL)
      end
    end else
      ErrorMsg(_('No Internet connection') + ' ' + SysErrorMessage(GetLastError));
  finally
    InternetCloseHandle(hSession);
    BCancel.Enabled:= true;
  end;
end;

procedure TFDownload.TimerDownloadTimer(Sender: TObject);
  var DownloadIsOk: boolean;
begin
  TimerDownload.Enabled:= false;
  Screen.Cursor:= crHourglass;
  try
    DownloadIsOK:= GetInetFile(fileUrl, fileName, ProgressBar);
  finally
    Screen.Cursor:= crDefault;
  end;
  if DownloadIsOK then BCancel.Caption:= _('&OK');
  BDownload.Enabled:= true;
end;

end.

