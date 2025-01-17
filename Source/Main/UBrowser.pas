unit UBrowser;

interface

uses
  Classes,
  Controls,
  OleCtrls,
  Forms,
  SHDocVw,
  ComCtrls,
  ToolWin,
  StdCtrls,
  ExtCtrls,
  Messages,
  ImageList,
  ImgList,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  SVGIconImageCollection,
  SpTBXSkins,
  frmFile;

type
  TFBrowser = class(TFileForm)
    WebBrowser: TWebBrowser;
    PBrowser: TPanel;
    PTop: TPanel;
    Splitter: TSplitter;
    PLeft: TPanel;
    CBUrls: TComboBox;
    PRight: TPanel;
    ToolBar: TToolBar;
    TBClose: TToolButton;
    TBShowSource: TToolButton;
    TBBack: TToolButton;
    TBForward: TToolButton;
    TBStop: TToolButton;
    TBRefresh: TToolButton;
    TBFavoritesAdd: TToolButton;
    TBFavoritesDelete: TToolButton;
    icBrowser: TSVGIconImageCollection;
    vilBrowserLight: TVirtualImageList;
    vilBrowserDark: TVirtualImageList;
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBUrlsClick(Sender: TObject);
    procedure CBUrlsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TBCloseClick(Sender: TObject);
    procedure TBShowSourceClick(Sender: TObject);
    procedure TBBackClick(Sender: TObject);
    procedure TBForwardClick(Sender: TObject);
    procedure TBStopClick(Sender: TObject);
    procedure TBRefreshClick(Sender: TObject);
    procedure TBFavoritesAddClick(Sender: TObject);
    procedure TBFavoritesDeleteClick(Sender: TObject);

    procedure WebBrowserBeforeNavigate2(ASender: TObject;
      const PDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebBrowserDownloadBegin(Sender: TObject);
    procedure WebBrowserDownloadComplete(Sender: TObject);
    procedure WebBrowserCommandStateChange(ASender: TObject; Command: Integer;
      Enable: WordBool);
  private
    FZoom: OleVariant;
    procedure InvokeOleCMD (Value1, Value2: Integer);
    procedure ActivateBrowser;
    procedure NavigateTo(URL: string);
  protected
    procedure Print; override;
    procedure CutToClipboard;
    procedure CopyToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure SetFontSize(Delta: Integer); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    function OpenFile(const AFilename: string): Boolean; override;
    procedure OpenWindow(Sender: TObject); override;
    function getAsStringList: TStringList; override;
    procedure UploadFilesHttpPost(const URLstring: string; Names, Values, NFiles, VFiles: array of string);
    procedure ChangeStyle;
    procedure DPIChanged; override;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  System.Variants,
  Vcl.Dialogs,
  IOUtils,
  Clipbrd,
  ActiveX,
  MSHTML,
  JvGnugettext,
  uEditAppIntfs,
  uCommonFunctions,
  frmPyIDEMain,
  frmFileExplorer,
  UUtils,
  UConfiguration;

{$R *.dfm}

procedure TFBrowser.FormCreate(Sender: TObject);
begin
  inherited;
  WebBrowser.Silent:= True;
  with PyIDEMainForm.AppStorage do begin
    PLeft.Width:= ReadInteger('Browser\CBwidth', 200);
    ReadStringList('Browser\Favoriten', CBUrls.Items);
  end;
  ChangeStyle;
end;

procedure TFBrowser.FormShow(Sender: TObject);
begin
  CBUrls.SelLength:= 0;
end;

procedure TFBrowser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TFBrowser.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  var AEditor: IEditor;
begin
  { If you have used the search function in a browser window and you then
    close the browser window in the editor window the blinking caret isn't
    shown.

    This is fixed with a timer event.
  }
  WebBrowser.OnCommandStateChange:= nil;
  with PyIDEMainForm.AppStorage do
    WriteInteger('Browser\CBWidth', PLeft.Width);
  CanClose:= True;

  TThread.ForceQueue(nil, procedure
  begin
    AEditor:= GI_PyIDEServices.GetActiveEditor;
    if Assigned(AEditor) and AEditor.ActiveSynEdit.CanFocus then
      AEditor.ActiveSynEdit.SetFocus;
  end);
end;

procedure TFBrowser.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssAlt] then
    if (Key = VK_RIGHT) and TBForward.Enabled then
      TBForward.Click
    else if (Key = VK_LEFT) and TBBack.Enabled then
      TBBack.Click;
end;

function TFBrowser.OpenFile(const AFilename: string): Boolean;
begin
  Pathname:= getProtocolAndDomain(AFilename);
  fFile.fFileName:= Pathname;
  PyIDEMainForm.UpdateCaption;
  Enter(Self);
  WebBrowser.OnCommandStateChange:= WebBrowserCommandStateChange;
  NavigateTo(AFilename);
  Result:= True;
end;

procedure TFBrowser.NavigateTo(URL: string);
begin
  WebBrowser.Navigate(URL);
end;

procedure TFBrowser.CBUrlsClick(Sender: TObject);
begin
  var Str:= CBUrls.Text;
  if FileExists(Str) then
    NavigateTo(Str)
  else if DirectoryExists(ExtractFilePathEx(Str)) then begin
    PyIDEMainForm.actNavFileExplorerExecute(Self);
    FileExplorerWindow.ExplorerPath:= ExtractFilePathEx(Str);
  end else if GuiPyOptions.LockedInternet then
    NavigateTo('about:' + _('Internet locked!'))
  else begin
    if Pos('://', Str) = 0 then
      Str:= 'https://' + Str;
    NavigateTo(Str);
  end;
  CBUrls.Text:= Str;
end;

procedure TFBrowser.CBUrlsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    CBUrlsClick(Self);
end;

procedure TFBrowser.TBCloseClick(Sender: TObject);
begin
  Close;
  (fFile as IFileCommands).ExecClose;
end;

procedure TFBrowser.TBShowSourceClick(Sender: TObject);
begin
  TBShowSource.Enabled:= False;
  var Str:= StripHttpParams(CBUrls.Text);
  if FileExists(Str) then
    PyIDEMainForm.DoOpenAsEditor(Str)
  else begin
    Str:= ExtractFileNameEx(CBUrls.Text);
    if not IsHTML(Str) then Str:= ChangeFileExt(Str, '.html');
    try
      Screen.Cursor:= crHourGlass;
      if DownloadURL(CBUrls.Text, TPath.Combine(GuiPyOptions.TempDir, Str))
        then PyIDEMainForm.DoOpenAsEditor(TPath.Combine(GuiPyOptions.TempDir, Str))
        else StyledMessageDlg(_('Download failed!'), mtError, [mbOK], 0);
    finally
      Screen.Cursor:= crDefault;
    end;
  end;
  TBShowSource.Enabled:= True;
end;

procedure TFBrowser.TBBackClick(Sender: TObject);
begin
  if not WebBrowser.Busy then
    WebBrowser.GoBack;
end;

procedure TFBrowser.TBForwardClick(Sender: TObject);
begin
  if not WebBrowser.Busy then
    WebBrowser.GoForward;
end;

procedure TFBrowser.TBStopClick(Sender: TObject);
begin
  WebBrowser.Stop;
end;

procedure TFBrowser.TBRefreshClick(Sender: TObject);
begin
  if not WebBrowser.Busy then
    WebBrowser.Refresh;
end;

procedure TFBrowser.TBFavoritesAddClick(Sender: TObject);
begin
  ComboBoxAdd(CBUrls);
  PyIDEMainForm.AppStorage.WriteStringList('Browser\Favoriten', CBUrls.Items);
end;

procedure TFBrowser.TBFavoritesDeleteClick(Sender: TObject);
begin
  ComboBoxDelete2(CBUrls, CBUrls.Text);
  PyIDEMainForm.AppStorage.WriteStringList('Browser\Favoriten', CBUrls.Items);
  CBUrls.Text:= '';
end;

procedure TFBrowser.SetFontSize(Delta: Integer);
  var Zoom1: OleVariant;
begin
  WebBrowser.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, Zoom1, FZoom);
  FZoom:= FZoom + Delta;
  if FZoom < 0 then FZoom:= 0;
  if FZoom > 4 then FZoom:= 4;
  WebBrowser.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_PROMPTUSER, FZoom);
end;

procedure TFBrowser.Print;
begin
  InvokeOleCMD(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER);
end;

procedure TFBrowser.CutToClipboard;
begin
  if CBUrls.Focused then begin
    Clipboard.AsText:= CBUrls.SelText;
    CBUrls.SelText:= '';
  end;
end;

procedure TFBrowser.CopyToClipboard;
begin
  if CBUrls.Focused
    then Clipboard.AsText:= CBUrls.SelText
    else InvokeOleCMD(OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT);
end;

procedure TFBrowser.PasteFromClipboard;
begin
  if CBUrls.Focused then
    CBUrls.SelText:= Clipboard.AsText;
end;

procedure TFBrowser.InvokeOleCMD (Value1, Value2: Integer);
  // from Henri Fournier in Borland.Public.Delphi.Internet
var CmdTarget:   IOleCommandTarget;
    VaIn, VaOut: OleVariant;
begin
  if WebBrowser.Document <> nil then
    try
      WebBrowser.Document.QueryInterface (IOleCommandTarget, CmdTarget);
      if Assigned(CmdTarget) then
        try
          CmdTarget.Exec(PGUID(nil), Value1, Value2, VaIn, VaOut);
        finally
          CmdTarget._Release;
        end;
    except on e: Exception do
      StyledMessageDlg(e.Message, mtError, [mbOK], 0);
    end;
end;

procedure TFBrowser.OpenWindow(Sender: TObject);
begin
  inherited;
  WebBrowser.Update;
  ActivateBrowser;
end;

procedure TFBrowser.ActivateBrowser;
begin
  if Assigned(WebBrowser) and Assigned(WebBrowser.Document) then
    (WebBrowser.Document as IHTMLDocument2).parentWindow.focus;
end;

function TFBrowser.getAsStringList: TStringList;
  var Filename: string;
begin
  TBShowSource.Enabled:= False;
  Result:= TStringList.Create;
  Filename:= StripHttpParams(CBUrls.Text);
  if not FileExists(Filename) then begin
    Screen.Cursor:= crHourGlass;
    try
      Filename:= TPath.Combine(GuiPyOptions.TempDir, 'download.html');
      if not DownloadURL(CBUrls.Text, Filename) then
        StyledMessageDlg(_('Download failed!'), mtError, [mbOK], 0);
    finally
      Screen.Cursor:= crDefault;
    end;
  end;
  if FileExists(Filename) then
    Result.LoadFromFile(Filename);
  TBShowSource.Enabled:= True;
end;

procedure TFBrowser.UploadFilesHttpPost(const URLstring: string; Names, Values, NFiles, VFiles: array of string);
 var
   StrData, Name, Value, Boundary: string;
   URL: OleVariant;
   Flags: OleVariant;
   PostData: OleVariant;
   Headers: OleVariant;
   Idx: Integer;

   MemoryStream: TMemoryStream;
   StringStream: TStringStream;
begin
  if Length(Names) <> Length(Values) then
    raise Exception.Create('UploadFilesHttpPost: Names and Values must have the same length.') ;
  if Length(NFiles) <> Length(VFiles) then
    raise Exception.Create('UploadFilesHttpPost: FileNames and FileValues must have the same length.') ;

  URL := 'about:blank';
  Flags := navNoHistory or navNoReadFromCache or navNoWriteToCache or navAllowAutosearch;
  WebBrowser.Navigate2(URL, Flags) ;
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do Application.ProcessMessages;

  // anything random that WILL NOT occur in the data.
  Boundary := '---------------------------123456789';

  StrData := '';
  for Idx := Low(Names) to High(Names) do
  begin
    Name := Names[Idx];
    Value := Values[Idx];
    StrData := StrData + '--' + Boundary + #13#10 +
      'Content-Disposition: form-data; name="' + Name + '"' + #13#10#13#10 + Value + #13#10;
  end;

  for Idx := Low(NFiles) to High(NFiles) do
  begin
    Name := NFiles[Idx];
    Value := VFiles[Idx];
    StrData := StrData + '--' + Boundary + #13#10 +
      'Content-Disposition: form-data; name="' + Name + '"; filename="' + Value + '"' + #13#10;

    if Value = '' then
      StrData := StrData + 'Content-Transfer-Encoding: binary'#13#10#13#10
    else begin
      if (CompareText(ExtractFileExt(Value), '.JPG') = 0) or
         (CompareText(ExtractFileExt(Value), '.JPEG') = 0) then
        StrData := StrData + 'Content-Type: image/pjpeg'#13#10#13#10
      else if (CompareText(ExtractFileExt(Value), '.PNG') = 0) then
        StrData := StrData + 'Content-Type: image/x-png'#13#10#13#10
      else if (CompareText(ExtractFileExt(Value), '.PNG') = 0) then
        StrData := StrData + 'Content-Type: image/x-png'#13#10#13#10
      else if (CompareText(ExtractFileExt(Value), '.CSS') = 0) then
        StrData := StrData + 'Content-Type: text/css'#13#10#13#10
      else if (CompareText(ExtractFileExt(Value), '.HTML') = 0) then
        StrData := StrData + 'Content-Type: text/html'#13#10#13#10;

      MemoryStream := TMemoryStream.Create;
      try
        MemoryStream.LoadFromFile(Value) ;
        StringStream := TStringStream.Create('');
        try
          StringStream.CopyFrom(MemoryStream, MemoryStream.Size);

          StrData := StrData + StringStream.DataString + #13#10;
        finally
          FreeAndNil(StringStream);
        end;
      finally
        FreeAndNil(MemoryStream);
      end;
    end;

    StrData := StrData + '--' + Boundary + '--'#13#10; // FOOTER
  end;

  StrData := StrData + #0;

  {2. you must convert a String into variant array of bytes and every character from String is a value in array}
  PostData := VarArrayCreate([0, Length(StrData) - 1], varByte) ;

  { copy the ordinal value of the character into the PostData array}
  for Idx := 1 to Length(StrData) do PostData[Idx-1] := Ord(StrData[Idx]) ;

  {3. prepare headers which will be sent to remote web-server}
  Headers := 'Content-Type: multipart/form-data; Boundary=' + Boundary + #13#10;

  {4. you must navigate to the URL with your script and send as parameters your array with POST-data and headers}
  URL := URLstring;
  WebBrowser.Navigate2(URL, Flags, EmptyParam, PostData, Headers) ;
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do Application.ProcessMessages;
end;

procedure TFBrowser.WebBrowserBeforeNavigate2(ASender: TObject;
  const PDisp: IDispatch;
  const URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
var
  Posi: Integer; Str, Str1, NUrl: string;
begin
  if URL = 'about:blank' then begin
    Cancel:= True;
    Exit;
  end;
  NUrl:= URL;
  Str:= URL;
  if Pos('file:///', Str) = 1 then begin
    Delete(Str, 1, 8);
    Posi:= Pos('#', Str);
    if Posi > 0 then begin
      Str1:= Copy(Str, Posi, Length(Str));
      Delete(Str, Posi, Length(Str));
    end else Str1:= '';
    NUrl:= ToWindows(Str) + Str1;
  end else if Pos('file:', Str) = 1 then begin // UNC-Namen
    Delete(Str, 1, 5);
    Posi:= Pos('#', Str);
    if Posi > 0 then begin
      Str1:= Copy(Str,Posi, Length(Str));
      Delete(Str, Posi, Length(Str));
    end else Str1:= '';
    NUrl:= ToWindows(Str) + Str1;
  end;
  if not hasPythonExtension(NUrl) then
    CBUrls.Text:= NUrl;
  if IsHTTP(URL) and GuiPyOptions.LockedInternet then
    Cancel:= True;
end;

procedure TFBrowser.WebBrowserCommandStateChange(ASender: TObject;
  Command: Integer; Enable: WordBool);
begin
  case Command of
    CSC_NAVIGATEBACK:    TBBack.Enabled := Enable;
    CSC_NAVIGATEFORWARD: TBForward.Enabled := Enable;
  end;
end;

procedure TFBrowser.WebBrowserDownloadBegin(Sender: TObject);
begin
  TBStop.ImageName:= 'AbortOn';
end;

procedure TFBrowser.WebBrowserDownloadComplete(Sender: TObject);
begin
  TBStop.ImageName:= 'AbortOff';
  Pathname:= getProtocolAndDomain(CBUrls.Text);
  fFile.fFileName:= Pathname;
  PyIDEMainForm.UpdateCaption;
  DoUpdateCaption;
  if not FConfiguration.Visible then
    ActivateBrowser;
end;

procedure TFBrowser.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFBrowser.ChangeStyle;
begin
  if FConfiguration.isDark
    then ToolBar.Images:= vilBrowserDark
    else ToolBar.Images:= vilBrowserLight;
end;

procedure TFBrowser.DPIChanged;
begin
  CBUrls.Height:= ToolBar.Height;
end;

end.
