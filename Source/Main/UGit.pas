unit UGit;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  uEditAppIntfs,
  dlgPyIDEBase;

type
  TFGit = class(TPyIDEDlgBase)
    LVRevisions: TListView;
    BOK: TButton;
    BCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure GitCall(const Call, Folder: string);
    procedure LVRevisionsDblClick(Sender: TObject);
    procedure ShowGui(const Path: string);
    procedure ShowConsole(const Path: string);
    procedure ShowViewer(const Path: string);
  public
    procedure Execute(Tag: Integer; AEditor: IEditor);
    function IsRepository(const Dir: string): Boolean;
  end;

var
  FGit: TFGit = nil;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.Forms,
  Vcl.Dialogs,
  JvDockControlForm,
  JvGnugettext,
  cTools,
  UUtils,
  UConfiguration,
  frmCommandOutput,
  frmEditor;

{$R *.dfm}

procedure TFGit.FormShow(Sender: TObject);
begin
  with LVRevisions do
  begin
    Columns[0].Caption := _('Revision');
    Columns[1].Caption := _('Author');
    Columns[2].Caption := _('Date');
    Columns[3].Caption := _('Message');
  end;
  Caption := _('Revisions');
end;

function TFGit.IsRepository(const Dir: string): Boolean;
begin
  Result := DirectoryExists(WithTrailingSlash(Dir) + '.git');
end;

procedure TFGit.LVRevisionsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFGit.ShowGui(const Path: string);
begin
  ShellExecuteFile(GuiPyOptions.GitFolder + '\cmd\git-gui.exe', '', Path,
    SW_SHOWNORMAL);
end;

procedure TFGit.ShowViewer(const Path: string);
begin
  ShellExecuteFile(GuiPyOptions.GitFolder + '\cmd\gitk.exe', '', Path,
    SW_SHOWNORMAL);
end;

procedure TFGit.ShowConsole(const Path: string);
begin
  ShellExecuteFile(GuiPyOptions.GitFolder + '\bin\bash.exe', '', Path,
    SW_SHOWNORMAL);
end;

procedure TFGit.GitCall(const Call, Folder: string);
var
  Clone: Boolean;
  ExternalTool: TExternalTool;
begin
  if not OutputWindow.Visible then
    ShowDockForm(OutputWindow);
  ExternalTool := TExternalTool.Create;
  ExternalTool.ApplicationName := GuiPyOptions.GitFolder + '\bin\git.exe';
  ExternalTool.Parameters := Call;
  ExternalTool.WorkingDirectory := Folder;
  OutputWindow.AddNewLine('git ' + Call);
  Screen.Cursor := crHourGlass;
  try
    Clone := (Pos('clone', Call) > 0);
    if Clone then
      OutputWindow.AddNewLine('Please wait!');
    ExternalTool.Execute;
    if Clone then
      OutputWindow.AddNewLine('Done!');
  finally
    FreeAndNil(ExternalTool);
    Screen.Cursor := crDefault;
  end;
end;

procedure TFGit.Execute(Tag: Integer; AEditor: IEditor);
var
  AMessage, FileName: string;
begin
  if (Tag in [2, 5, 6, 7]) and not Assigned(AEditor) then
    Exit;

  if Assigned(AEditor) then begin
    if AEditor.Modified then
      (AEditor.Form as TEditorForm).DoSave;
    FileName := ExtractFileName(AEditor.FileName);
  end;

  case Tag of
    1:
      GitCall('status', GuiPyOptions.GitLocalRepository);
    2:
      GitCall('add ' + FileName, GuiPyOptions.GitLocalRepository);
    3:
      if InputQuery('Commit', 'Message', AMessage) then
        FGit.GitCall('commit -m "' + AMessage + '"',
          GuiPyOptions.GitLocalRepository);
    4:
      GitCall('log --stat', GuiPyOptions.GitLocalRepository);
    5:
      GitCall('reset HEAD ' + FileName, GuiPyOptions.GitLocalRepository);
    6:
      GitCall('checkout -- ' + FileName, GuiPyOptions.GitLocalRepository);
    7:
      GitCall('rm ' + FileName, GuiPyOptions.GitLocalRepository);
    8:
      GitCall('remote -v', GuiPyOptions.GitLocalRepository);
    9:
      GitCall('fetch ' + GuiPyOptions.GitRemoteRepository,
        GuiPyOptions.GitLocalRepository);
    10:
      GitCall('push origin master', GuiPyOptions.GitLocalRepository);
    11:
      ShowGui(GuiPyOptions.GitLocalRepository);
    12:
      ShowViewer(GuiPyOptions.GitLocalRepository);
    13:
      ShowConsole(GuiPyOptions.GitLocalRepository);
  end;
end;

end.
