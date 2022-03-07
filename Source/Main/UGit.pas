unit UGit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls, uEditAppIntfs, dlgPyIDEBase;

type
  TFGit = class(TPyIDEDlgBase)
    LVRevisions: TListView;
    BOK: TButton;
    BCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure GitCall(const call, folder: string);
    procedure LVRevisionsDblClick(Sender: TObject);
    procedure ShowGUI(const Path: string);
    procedure ShowConsole(const Path: string);
    procedure ShowViewer(const Path: string);
  public
    { Public declarations }
    procedure Execute(Tag: integer; aEditor: IEditor);
    function IsRepository(const Dir: string): boolean;
  end;

var
  FGit: TFGit = nil;

implementation

uses frmCommandOutput, cTools, JvDockControlForm, JvGnugettext,
     StringResources, UConfiguration, UUtils, frmPyIDEMain, frmEditor;

{$R *.dfm}

procedure TFGit.FormShow(Sender: TObject);
begin
  with LVRevisions do begin
    Columns.Items[0].Caption:= _('Revision');
    Columns.Items[1].Caption:= _('Author');
    Columns.Items[2].Caption:= _('Date');
    Columns.Items[3].Caption:= _('Message');
  end;
  Caption:= _('Revisions');
end;

function TFGit.IsRepository(const Dir: string): boolean;
begin
  Result:= DirectoryExists(withTrailingSlash(Dir) + '.git');
end;

procedure TFGit.LVRevisionsDblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TFGit.ShowGUI(const Path: string);
begin
  ShellExecuteFile(GuiPyOptions.GitFolder + '\cmd\git-gui.exe', '', Path, SW_SHOWNORMAL)
end;

procedure TFGit.ShowViewer(const Path: string);
begin
  ShellExecuteFile(GuiPyOptions.GitFolder + '\cmd\gitk.exe', '', Path, SW_SHOWNORMAL)
end;

procedure TFGit.ShowConsole(const Path: string);
begin
  ShellExecuteFile(GuiPyOptions.GitFolder + '\bin\bash.exe', '', Path, SW_SHOWNORMAL)
end;

procedure TFGit.GitCall(const call, folder: string);
  var clone: boolean; ExternalTool: TExternalTool;
begin
  if not OutputWindow.Visible then
    ShowDockForm(OutputWindow);
  ExternalTool:= TExternalTool.Create;
  ExternalTool.ApplicationName:= GuiPyOptions.GitFolder + '\bin\git.exe';
  ExternalTool.Parameters:= call;
  ExternalTool.WorkingDirectory:= folder;
  OutputWindow.AddNewLine('git ' + call);
  Screen.Cursor:= crHourGlass;
  try
    clone:= (Pos('clone', call) > 0);
    if clone then
      OutputWindow.AddNewLine('Please wait!');
    ExternalTool.Execute;
    if clone then
      OutputWindow.AddNewLine('Done!');
  finally
    FreeAndNil(ExternalTool);
    Screen.Cursor:= crDefault;
  end;
end;

procedure TFGit.Execute(Tag: integer; aEditor: IEditor);
  var m, p, f: string;
begin
  if (aEditor = nil) and (Tag in [1, 2, 5, 6, 7]) then
    exit;

  if aEditor.Modified then
    TEditorForm(aEditor.Form).DoSave;
  f:= ExtractFileName(aEditor.Filename);
  p:= ExtractFilePath(aEditor.Filename);

  case Tag of
    1: GitCall('status', p);
    2: GitCall('add ' + f, p);
    3: if InputQuery('Commit', 'Message', m) then
         FGit.GitCall('commit -m "' + m + '"', GuiPyOptions.GitLocalRepository);
    4: GitCall('log --stat', GuiPyOptions.GitLocalRepository);
    5: GitCall('reset HEAD ' + f, p);
    6: GitCall('checkout -- ' + f, p);
    7: GitCall('rm ' + f, p);
    8: GitCall('remote -v', GuiPyOptions.GitLocalRepository);
    9: GitCall('fetch ' + GuiPyOptions.GitRemoteRepository, GuiPyOptions.GitLocalRepository);
   10: GitCall('push origin master', GuiPyOptions.GitLocalRepository);
   11: ShowGui(GuiPyOptions.GitLocalRepository);
   12: ShowViewer(GuiPyOptions.GitLocalRepository);
   13: ShowConsole(GuiPyOptions.GitLocalRepository);
  end;
end;

end.
