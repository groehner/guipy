{-----------------------------------------------------------------------------
 Unit Name: frmDocView
 Author:    Kiriakos Vlahos
 Date:      09-May-2005
 Purpose:   HTML documentation Editor View
 History:
-----------------------------------------------------------------------------}

unit frmWebPreview;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ActiveX,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.OleCtrls,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  SHDocVw,
  Vcl.ImgList,
  TB2Item,
  TB2Dock,
  TB2Toolbar,
  SpTBXItem,
  dmCommands,
  uEditAppIntfs,
  cTools,
//  Winapi.WebView2,
  Vcl.Edge, WebView2;

type
  TWebPreviewForm = class(TForm, IEditorView)
    TBXDock1: TSpTBXDock;
    TBXToolbar1: TSpTBXToolbar;
    ToolButtonForward: TSpTBXItem;
    ToolButtonBack: TSpTBXItem;
    TBXSeparatorItem1: TSpTBXSeparatorItem;
    TBXItem3: TSpTBXItem;
    TBXSeparatorItem2: TSpTBXSeparatorItem;
    TBXItem5: TSpTBXItem;
    TBXItem7: TSpTBXItem;
    BrowserImages: TVirtualImageList;
    WebBrowser: TEdgeBrowser;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButtonBackClick(Sender: TObject);
    procedure ToolButtonForwardClick(Sender: TObject);
    procedure ToolButtonStopClick(Sender: TObject);
    procedure ToolButtonPrintClick(Sender: TObject);
    procedure ToolButtonSaveClick(Sender: TObject);
    procedure WebBrowserCommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    procedure WebBrowserCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult:
        HRESULT);
  private
    { Private declarations }
    fEditor: IEditor;
    procedure UpdateView(Editor : IEditor);
  private
    class var FExternalTool: TExternalTool;
    class constructor Create;
    class destructor Destroy;
  public
    { Public declarations }
    const JupyterServerCaption = 'Jupyter Server';
    const JupyterServer = '$[PythonDir-Short]Scripts\Jupyter-notebook.exe';
  end;

  TWebPreviewView = class(TInterfacedObject, IEditorViewFactory)
  private
    function CreateForm(Editor: IEditor; AOwner : TComponent): TCustomForm;
    function GetName : string;
    function GetTabCaption : string;
    function GetMenuCaption : string;
    function GetHint : string;
    function GetImageName : string;
    function GetShortCut : TShortCut;
    procedure GetContextHighlighters(List : TList);
  end;

Var
  WebPreviewFactoryIndex : integer;

implementation

uses
  System.UITypes,
  System.IOUtils,
  MSHTML,
  JvGnugettext,
  uCommonFunctions,
  StringResources,
  VarPyth,
  frmCommandOutput,
  cParameters,
  cPyScripterSettings;

{$R *.dfm}

class constructor TWebPreviewForm.Create;
begin
  FExternalTool := TExternalTool.Create;
  with FExternalTool do begin
    Caption := JupyterServerCaption;
    Description := Caption;
    ApplicationName := JupyterServer;
    Parameters := '--no-browser --NotebookApp.token=""';
    WorkingDirectory := '$[ActiveDoc-Short-Dir]';
    SaveFiles := sfActive;
    Context := tcAlwaysEnabled;
    ParseTraceback := False;
    CaptureOutput := True;
    ConsoleHidden := True;
  end;
end;

procedure TWebPreviewForm.FormCreate(Sender: TObject);
begin
  WebBrowser.UserDataFolder := TPath.Combine(TPyScripterSettings.UserDataPath,
    'WebView2');
end;

class destructor TWebPreviewForm.Destroy;
begin
  FExternalTool.Free;
end;

procedure TWebPreviewForm.FormDestroy(Sender: TObject);
begin
  inherited;
  if OutputWindow.IsRunning and (OutputWindow.RunningTool = FExternalTool.Caption) then
    OutputWindow.actToolTerminate.Execute;
end;

procedure TWebPreviewForm.ToolButtonBackClick(Sender: TObject);
begin
  WebBrowser.GoBack;
end;

procedure TWebPreviewForm.ToolButtonForwardClick(Sender: TObject);
begin
  WebBrowser.GoForward;
end;

procedure TWebPreviewForm.ToolButtonStopClick(Sender: TObject);
begin
  WebBrowser.Stop;
end;

procedure TWebPreviewForm.ToolButtonPrintClick(Sender: TObject);
begin
  WebBrowser.ExecuteScript('window.print();');
end;

procedure TWebPreviewForm.ToolButtonSaveClick(Sender: TObject);
begin
  var JS :=
    'async function savehtml() {'#13#10 +
      'const opts = {'#13#10 +
      '  types: [{'#13#10 +
      '      description: ''html file'','#13#10 +
      '      accept: { ''text/html'': [''.html''] },'#13#10 +
      '  }],'#13#10 +
      '};'#13#10 +
      'const handle = await window.showSaveFilePicker(opts);'#13#10 +
      'const writable = await handle.createWritable();'#13#10 +
      'var html = document.documentElement.outerHTML;'#13#10 +
      'writable.write(html);'#13#10 +
      'writable.close();}'#13#10 +
     'savehtml();';

  WebBrowser.ExecuteScript(JS);
end;

procedure TWebPreviewForm.WebBrowserCommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
  case Command of
    CSC_NAVIGATEBACK: ToolButtonBack.Enabled := Enable;
    CSC_NAVIGATEFORWARD: ToolButtonForward.Enabled := Enable;
  end;
end;

procedure TWebPreviewForm.UpdateView(Editor: IEditor);
begin
  fEditor := Editor;
  if Assigned(Editor.SynEdit.Highlighter) and
    (Editor.SynEdit.Highlighter = CommandsDataModule.SynJSONSyn) then
  begin
    var FN := ExtractFileName(Editor.FileName);
    FN := StringReplace(FN, ' ', '%20', [rfReplaceAll]);
    WebBrowser.Navigate('http://localhost:8888/notebooks/'+FN);
  end else begin
    WebBrowser.CreateWebView;
    while WebBrowser.BrowserControlState in [TEdgeBrowser.TBrowserControlState.None,
      TEdgeBrowser.TBrowserControlState.Creating]
    do
      Application.ProcessMessages;
    WebBrowser.NavigateToString(Editor.SynEdit.Text);
  end;
end;

procedure TWebPreviewForm.WebBrowserCreateWebViewCompleted(Sender:
    TCustomEdgeBrowser; AResult: HRESULT);
begin
  if WebBrowser.BrowserControlState <> TEdgeBrowser.TBrowserControlState.Created then
    StyledMessageDlg(_(SWebView2Error), mtError, [mbOK], 0);
end;

{ TDocView }

function TWebPreviewView.CreateForm(Editor: IEditor; AOwner : TComponent): TCustomForm;
begin
  if Assigned(Editor.SynEdit.Highlighter) and
    (Editor.SynEdit.Highlighter = CommandsDataModule.SynJSONSyn) then
  begin
    if Editor.FileName = '' then
      (Editor as IFileCommands).ExecSave;
    if LowerCase(ExtractFileExt(Editor.FileName)) <> '.ipynb' then begin
      StyledMessageDlg(_(SOnlyJupyterFiles), mtError, [mbOK], 0);
      Abort;
    end;

    if not FileExists(Parameters.ReplaceInText(TWebPreviewForm.JupyterServer)) then
    begin
      StyledMessageDlg(_(SNoJupyter), mtError, [mbOK], 0);
      Abort;
    end;

    if OutputWindow.IsRunning then begin
      StyledMessageDlg(_(SExternalProcessRunning), mtError, [mbOK], 0);
      Abort;
    end;

    try
      OutputWindow.ExecuteTool(TWebPreviewForm.FExternalTool);
    except
      Abort;
    end;
  end;

  Result := TWebPreviewForm.Create(AOwner);
end;

function TWebPreviewView.GetImageName: string;
begin
  Result := 'Web';
end;

procedure TWebPreviewView.GetContextHighlighters(List: TList);
begin
  List.Add(CommandsDataModule.SynWebHtmlSyn);
  List.Add(CommandsDataModule.SynWebXmlSyn);
  List.Add(CommandsDataModule.SynWebCssSyn);
  List.Add(CommandsDataModule.SynJSONSyn);
end;

function TWebPreviewView.GetHint: string;
begin
  Result := _(SWebPreviewHint);
end;

function TWebPreviewView.GetMenuCaption: string;
begin
  Result := _(SWebPreview);
end;

function TWebPreviewView.GetName: string;
begin
  Result := 'Web Preview';
end;

function TWebPreviewView.GetTabCaption: string;
begin
  Result := _(SWebPreviewTab);
end;

function TWebPreviewView.GetShortCut: TShortCut;
begin
  Result := 0;
end;

initialization
  //  This unit must be initialized after frmEditor
  if Assigned(GI_EditorFactory) then
    WebPreviewFactoryIndex := GI_EditorFactory.RegisterViewFactory(TWebPreviewView.Create as IEditorViewFactory);
  OleInitialize(nil);

finalization
  OleUninitialize;

end.

