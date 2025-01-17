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
    Cancel: Boolean;
  public
    function GetInetFile(const aFileURL, aFileName: string; const Progress: TProgressBar): Boolean;
  end;

implementation

{$R *.dfm}

uses Windows, SysUtils, Forms, WinINet, jvGnugettext, UUtils;

procedure TFDownload.FormShow(Sender: TObject);
begin
  BCancel.Enabled:= False;
  ProgressBar.Position:= 0;
  Cancel:= False;
end;

procedure TFDownload.SPOpenClick(Sender: TObject);
begin
  SaveDialog.FileName:= ExtractFileName(EFile.Text);
  SaveDialog.InitialDir:= ExtractFilePath(EFile.Text);
  if SaveDialog.Execute then begin
    FileName:= SaveDialog.FileName;
    EFile.Text:= FileName;
    EFile.Hint:= FileName;
  end;
end;

procedure TFDownload.BDownloadClick(Sender: TObject);
  var dir: string;
begin
  BDownload.Enabled:= False;
  BCancel.Enabled:= False;
  FileUrl:= EUrl.Text;
  FileName:= EFile.Text;
  dir:= ExtractFilePath(FileName);
  if not DirectoryExists(dir) then
    ForceDirectories(dir);
  TimerDownload.Enabled:= True;
end;

procedure TFDownload.BCancelClick(Sender: TObject);
begin
  Cancel:= True;
end;

function TFDownload.GetInetFile(const aFileURL, aFileName: string; const Progress: TProgressBar): Boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[0..BufferSize+1] of Byte;
  code : array[1..20] of Char;
  codes: string;
  Value: Integer;
  BufferLen,
  Index,
  CodeLen: DWord;
  sAppName: string;
  aFile: TFileStream;
  KnowSize: Boolean;

  function codeToString: string;
  begin
    Result:= '';
    var i:= 1;
    while (i <= 20) and (code[i] <> #0) do begin
      Result:= Result + code[i];
      Inc(i);
    end;
  end;

begin
  result := False;
  sAppName := ExtractFileName(Application.ExeName) ;
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0) ;
  try
    hURL:= InternetOpenURL(hSession, PChar(aFileURL), nil, 0, INTERNET_FLAG_DONT_CACHE, 0);
    if Assigned(hURL) then begin
      try
        try
          // get HTTP status
          Index:= 0;
          CodeLen:= Length(code);
          if HttpQueryInfo(hURL, HTTP_QUERY_STATUS_CODE, @code, CodeLen, Index) then begin
            codes:= codeToString; // 200, 401, 404 or 500
            if codes <> '200' then Exit(False);
          end;

          // get file size
          KnowSize:= False;
          if Progress <> nil then begin
            KnowSize:= True;
            Index := 0;
            CodeLen := Length(Code);
            HttpQueryInfo(hURL, HTTP_QUERY_CONTENT_LENGTH, @code, CodeLen, Index);
            codes:= codeToString;
            if TryStrToInt(codes, Value)
              then Progress.Max:= Value
              else KnowSize:= False;
          end;
          BCancel.Enabled:= True;

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
    BCancel.Enabled:= True;
  end;
end;

procedure TFDownload.TimerDownloadTimer(Sender: TObject);
  var DownloadIsOk: Boolean;
begin
  TimerDownload.Enabled:= False;
  Screen.Cursor:= crHourGlass;
  try
    DownloadIsOK:= GetInetFile(fileUrl, fileName, ProgressBar);
  finally
    Screen.Cursor:= crDefault;
  end;
  if DownloadIsOK then BCancel.Caption:= _('&OK');
  BDownload.Enabled:= True;
end;

end.

