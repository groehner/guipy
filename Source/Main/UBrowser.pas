unit UBrowser;

interface

uses
  Classes, Controls, OleCtrls, Forms, SHDocVw, ComCtrls, ToolWin, StdCtrls,
  ExtCtrls, Messages, ImageList, ImgList, SpTBXSkins, frmFile,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, SVGIconImageCollection;

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
      const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebBrowserDownloadBegin(Sender: TObject);
    procedure WebBrowserDownloadComplete(Sender: TObject);
    procedure WebBrowserCommandStateChange(ASender: TObject; Command: Integer;
      Enable: WordBool);
  private
    Zoom: OleVariant;
    procedure InvokeOleCMD (Value1, Value2: Integer);
    procedure ActivateBrowser;
    procedure NavigateTo(URL: string);
  protected
    procedure Print; override;
    procedure CutToClipboard;
    procedure CopyToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure SetFontSize(Delta: integer); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    function OpenFile(const aFilename: String): boolean; override;
    procedure OpenWindow(Sender: TObject); override;
    function getAsStringList: TStringList; override;
    procedure UploadFilesHttpPost(const URLstring: string; names, values, nFiles, vFiles: array of string);
    procedure ChangeStyle;
    procedure DPIChanged; override;
  end;

implementation

uses Winapi.Windows, System.SysUtils, System.Variants, Vcl.Dialogs, IOUtils,
     Clipbrd, ActiveX, MSHTML, JvGnugettext,
     uEditAppIntfs, uCommonFunctions, frmPyIDEMain,
     frmFileExplorer, UUtils, UConfiguration;

{$R *.dfm}

procedure TFBrowser.FormCreate(Sender: TObject);
begin
  inherited;
  WebBrowser.Silent:= true;
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
  var aEditor: IEditor;
begin
  { If you have used the search function in a browser window and you then
    close the browser window in the editor window the blinking caret isn't
    shown.

    This is fixed with a timer event.
  }
  WebBrowser.OnCommandStateChange:= nil;
  with PyIDEMainForm.AppStorage do
    WriteInteger('Browser\CBWidth', PLeft.Width);
  CanClose:= true;

  TThread.ForceQueue(nil, procedure
  begin
    aEditor:= GI_PyIDEServices.getActiveEditor;
    if assigned(aEditor) and aEditor.ActiveSynEdit.CanFocus then
      aEditor.ActiveSynEdit.SetFocus;
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

function TFBrowser.OpenFile(const aFilename: String): boolean;
begin
  Pathname:= getProtocolAndDomain(aFilename);
  fFile.fFileName:= Pathname;
  PyIDEMainForm.UpdateCaption;
  Enter(Self);
  Webbrowser.OnCommandStateChange:= WebBrowserCommandStateChange;
  NavigateTo(aFilename);
  Result:= true;
end;

procedure TFBrowser.NavigateTo(URL: string);
begin
  WebBrowser.Navigate(URL);
end;

procedure TFBrowser.CBUrlsClick(Sender: TObject);
  var s: string;
begin
  s:= CBUrls.Text;
  if FileExists(s) then
    NavigateTo(s)
  else if DirectoryExists(ExtractFilePathEx(s)) then begin
    PyIDEMainForm.actNavFileExplorerExecute(self);
    FileExplorerWindow.ExplorerPath:= ExtractFilePathEx(s);
  end else if GuiPyOptions.LockedInternet then
    NavigateTo('about:' + _('Internet locked!'))
  else begin
    if Pos('://', s) = 0 then
      s:= 'https://' + s;
    NavigateTo(s);
  end;
  CBUrls.Text:= s;
end;

procedure TFBrowser.CBUrlsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    CBUrlsClick(Self);
end;

procedure TFBrowser.TBCloseClick(Sender: TObject);
begin
  Close;
  (fFile as IFileCommands).ExecClose;
end;

procedure TFBrowser.TBShowSourceClick(Sender: TObject);
  var s: string;
begin
  TBShowSource.Enabled:= false;
  s:= StripHttpParams(CBUrls.Text);
  if FileExists(s) then
    PyIDEMainForm.DoOpenAsEditor(s)
  else begin
    s:= ExtractFileNameEx(CBUrls.Text);
    if not IsHTML(s) then s:= ChangeFileExt(s, '.html');
    try
      Screen.Cursor:= crHourglass;
      if DownloadURL(CBUrls.Text, TPath.Combine(GuiPyOptions.TempDir, s))
        then PyIDEMainForm.DoOpenAsEditor(TPath.Combine(GuiPyOptions.TempDir, s))
        else StyledMessageDlg(_('Download failed!'), mtError, [mbOK], 0);
    finally
      Screen.Cursor:= crDefault;
    end;
  end;
  TBShowSource.Enabled:= true;
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

procedure TFBrowser.SetFontSize(Delta: integer);
  var Zoom1: OleVariant;
begin
  WebBrowser.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, Zoom1, Zoom);
  Zoom:= Zoom + Delta;
  if Zoom < 0 then Zoom:= 0;
  if Zoom > 4 then Zoom:= 4;
  WebBrowser.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_PROMPTUSER, Zoom);
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
    else InvokeOleCMD(OLECMDID_Copy, OLECMDEXECOPT_DODEFAULT);;
end;

procedure TFBrowser.PasteFromClipboard;
begin
  if CBUrls.Focused then
    CBUrls.SelText:= Clipboard.AsText;
end;

procedure TFBrowser.InvokeOleCMD (Value1, Value2: Integer);
  // from Henri Fournier in Borland.Public.Delphi.Internet
var CmdTarget:   IOleCommandTarget;
    vaIn, vaOut: OleVariant;
begin
  if WebBrowser.Document <> nil then
    try
      WebBrowser.Document.QueryInterface (IOleCommandTarget, CmdTarget);
      if CmdTarget <> nil then
        try
          CmdTarget.Exec(PGuid(nil), Value1, Value2, VaIn, VaOut);
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
  if assigned(WebBrowser) and assigned(WebBrowser.Document) then
    (WebBrowser.Document as IHTMLDocument2).ParentWindow.Focus;
end;

function TFBrowser.getAsStringList: TStringList;
  var filename: string;
begin
  TBShowSource.Enabled:= false;
  Result:= TStringList.Create;
  filename:= StripHttpParams(CBUrls.Text);
  if not FileExists(filename) then begin
    Screen.Cursor:= crHourglass;
    try
      filename:= TPath.Combine(GuiPyOptions.TempDir, 'download.html');
      if not DownloadURL(CBUrls.Text, filename) then
        StyledMessageDlg(_('Download failed!'), mtError, [mbOK], 0);
    finally
      Screen.Cursor:= crDefault;
    end;
  end;
  if FileExists(filename) then
    Result.LoadFromFile(filename);
  TBShowSource.Enabled:= true;
end;

procedure TFBrowser.UploadFilesHttpPost(const URLstring: string; names, values, nFiles, vFiles: array of string) ;
 var
   strData, n, v, boundary: string;
   URL: OleVariant;
   Flags: OleVariant;
   PostData: OleVariant;
   Headers: OleVariant;
   idx: Integer;

   ms: TMemoryStream;
   ss: TStringStream;
 begin
   if Length(names) <> Length(values) then
     raise Exception.Create('UploadFilesHttpPost: Names and Values must have the same length.') ;
   if Length(nFiles) <> Length(vFiles) then
     raise Exception.Create('UploadFilesHttpPost: FileNames and FileValues must have the same length.') ;

   URL := 'about:blank';
   Flags := NavNoHistory or NavNoReadFromCache or NavNoWriteToCache or NavAllowAutosearch;
   WebBrowser.Navigate2(URL, Flags) ;
   while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do Application.ProcessMessages;

   // anything random that WILL NOT occur in the data.
   boundary := '---------------------------123456789';

   strData := '';
   for idx := Low(names) to High(names) do
   begin
     n := names[idx];
     v := values[idx];
     strData := strData + '--' + boundary + #13#10 + 'Content-Disposition: form-data; name="' + n + '"' + #13#10#13#10 + v + #13#10;
   end;

   for idx := Low(nFiles) to High(nFiles) do
   begin
     n := nFiles[idx];
     v := vFiles[idx];

     strData := strData + '--' + boundary + #13#10 + 'Content-Disposition: form-data; name="' + n + '"; filename="' + v + '"' + #13#10;

     if v = '' then
     begin
        strData := strData + 'Content-Transfer-Encoding: binary'#13#10#13#10;
     end
     else
     begin
       if (CompareText(ExtractFileExt(v), '.JPG') = 0) or (CompareText(ExtractFileExt(v), '.JPEG') = 0) then
       begin
         strData := strData + 'Content-Type: image/pjpeg'#13#10#13#10;
       end
       else if (CompareText(ExtractFileExt(v), '.PNG') = 0) then
       begin
         strData := strData + 'Content-Type: image/x-png'#13#10#13#10;
       end
       else if (CompareText(ExtractFileExt(v), '.PNG') = 0) then
       begin
         strData := strData + 'Content-Type: image/x-png'#13#10#13#10;
       end
       else if (CompareText(ExtractFileExt(v), '.CSS') = 0) then
       begin
         strData := strData + 'Content-Type: text/css'#13#10#13#10;
       end
       else if (CompareText(ExtractFileExt(v), '.HTML') = 0) then
       begin
       strData := strData + 'Content-Type: text/html'#13#10#13#10;
       end;

       ms := TMemoryStream.Create;
       try
         ms.LoadFromFile(v) ;
         ss := TStringStream.Create('') ;
         try
           ss.CopyFrom(ms, ms.Size) ;

           strData := strData + ss.DataString + #13#10;
         finally
           FreeAndNil(ss);
         end;
       finally
         FreeAndNil(ms);
       end;
     end;

     strData := strData + '--' + boundary + '--'#13#10; // FOOTER
   end;

   strData := strData + #0;

   {2. you must convert a string into variant array of bytes and every character from string is a value in array}
   PostData := VarArrayCreate([0, Length(strData) - 1], varByte) ;

   { copy the ordinal value of the character into the PostData array}
   for idx := 1 to Length(strData) do PostData[idx-1] := Ord(strData[idx]) ;

   {3. prepare headers which will be sent to remote web-server}
   Headers := 'Content-Type: multipart/form-data; boundary=' + boundary + #13#10;

   {4. you must navigate to the URL with your script and send as parameters your array with POST-data and headers}
   URL := URLstring;
   WebBrowser.Navigate2(URL, Flags, EmptyParam, PostData, Headers) ;
   while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do Application.ProcessMessages;
 end;

procedure TFBrowser.WebBrowserBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var p: Integer; s, s1, nUrl: string;
begin
  if URL = 'about:blank' then begin
    Cancel:= true;
    Exit;
  end;
  nUrl:= URL;
  s:= URL;
  if Pos('file:///', s) = 1 then begin
    delete(s, 1, 8);
    p:= Pos('#', s);
    if p > 0 then begin
      s1:= copy(s, p, length(s));
      delete(s, p, length(s));
    end else s1:= '';
    nURL:= ToWindows(s) + s1;
  end else if Pos('file:', s) = 1 then begin // UNC-Namen
    delete(s, 1, 5);
    p:= Pos('#', s);
    if p > 0 then begin
      s1:= copy(s, p, length(s));
      delete(s, p, length(s));
    end else s1:= '';
    nURL:= ToWindows(s) + s1;
  end;
  if not hasPythonExtension(nURL) then
    CBURLs.Text:= nURL;
  if isHttp(URL) and GuiPyOptions.LockedInternet then
    Cancel:= true;
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
  if not FConfiguration.visible then ActivateBrowser;
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
  CBUrls.Height:= Toolbar.Height;
end;

end.
