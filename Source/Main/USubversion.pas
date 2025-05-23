unit USubversion;

interface

uses
  Controls, StdCtrls, ComCtrls, Classes,
  uEditAppIntfs, dlgPyIDEBase, frmEditor;

type
  TFSubversion = class(TPyIDEDlgBase)
    LVRevisions: TListView;
    BOK: TButton;
    BCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure LVRevisionsDblClick(Sender: TObject);
    function ToRepository(const s: string): string;
    procedure ForFile(const aFile: string);
    function GetRevision: string;
    function GetRepositoryURL(s: string): string;
    function IsRepository(const Dir: string): Boolean;
    procedure CallSVN(Programm: string; const call: string);
    procedure Commit;
    procedure Add;
    procedure Compare;
  private
    Pathname: string;
    FileName: string;
    Path: string;
  public
    procedure Execute(Tag: Integer; aEditor: IEditor);
  end;

var
  FSubversion: TFSubversion = nil;

implementation

uses Forms, Dialogs, SysUtils, IOUtils, JvGnugettext,
     frmCommandOutput, cTools, UConfiguration, UUtils, frmPyIDEMain;

{$R *.dfm}

procedure TFSubversion.FormShow(Sender: TObject);
begin
  with LVRevisions do begin
    Columns.Items[0].Caption:= _('Revision');
    Columns.Items[1].Caption:= _('Author');
    Columns.Items[2].Caption:= _('Date');
    Columns.Items[3].Caption:= _('Message');
  end;
  Caption:= _('Revisions');
end;

procedure TFSubversion.ForFile(const aFile: string);
  var m, rev, aut, s: string; p, i: Integer; ListItem: TListItem;
begin
  LVRevisions.Items.Clear;
  CallSVN('\svn.exe', 'log ' + aFile);
  i:= 0;
  while OutputWindow.IsRunning and (i < 10) do begin
    Sleep(100);
    Inc(i);
  end;
  i:= 2;
  while i < OutputWindow.lsbConsole.Items.Count - 1 do begin
    s:= OutputWindow.lsbConsole.Items[i];
    ListItem := LVRevisions.Items.Add;
    p:= Pos(' | ', s);
    rev:= Copy(s, 2, p-2);
    ListItem.Caption:= rev;
    Delete(s, 1, p + 2);
    p:= Pos(' | ', s);
    aut:= Copy(s, 1, p-1);
    ListItem.SubItems.Add(aut);
    Delete(s, 1, p + 2);
    p:= Pos(':', s);
    Delete(s, p+5, Length(s));
    ListItem.SubItems.Add(s);
    m:= OutputWindow.lsbConsole.Items[i+2];
    ListItem.SubItems.Add(m);
    Inc(i, 4);
  end;
end;

function TFSubversion.GetRevision: string;
  var i: Integer;
begin
  i:= LVRevisions.ItemIndex;
  Result:= LVRevisions.Items[i].Caption;
end;

function TFSubversion.IsRepository(const Dir: string): Boolean;
  var s: string; Datei: TStringList;
begin
  Result:= False;
  s:= withTrailingSlash(Dir) + 'README.txt';
  if FileExists(s) then begin
    Datei:= TStringList.Create;
    try
      Datei.LoadFromFile(s);
      Result:= Pos('This is a Subversion repository;', Datei.Text) > 0;
    finally
      FreeAndNil(Datei);
    end;
  end;
end;

function TFSubversion.ToRepository(const s: string): string;
  var p: Integer;
begin
  Result:= s;
  p:= pos(':', Result);
  if p = 2 then
    Delete(Result, 2, 1);
end;

function TFSubversion.GetRepositoryURL(s: string): string;
begin
  s:= withoutTrailingSlash(ExtractFilePath(s));
  Result:= toWeb('IE', GuiPyOptions.SVNRepository + '/' + toRepository(s));
end;

procedure TFSubversion.LVRevisionsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFSubversion.CallSVN(Programm: string; const call: string);
  var ExternalTool: TExternalTool;
begin
  ExternalTool:= TExternalTool.Create;
  ExternalTool.Caption:= 'Subversion (SVN)';
  ExternalTool.ApplicationName:= GuiPyOptions.SVNFolder + Programm;
  ExternalTool.Parameters:= call;
  ExternalTool.WorkingDirectory:= Path;
  ExternalTool.SaveFiles:= sfActive;
  ExternalTool.CaptureOutput:= True;
  OutputWindow.actToolTerminateExecute(Self);
  ExternalTool.Execute;
  FreeAndNil(ExternalTool);
end;

procedure TFSubversion.Execute(Tag: Integer; aEditor: IEditor);
begin
  if Assigned(aEditor) then begin
    Pathname:= aEditor.FileName;
    FileName:= ExtractFileName(Pathname);
    Path:= ExtractFilePath(aEditor.FileName);
    case Tag of
      1: Commit;
      2: Add;
      3: CallSVN('\svn.exe', 'log ' + Pathname);
      4: Compare;
      5: CallSVN('\svn.exe', 'status ' + Path + ' -u -v');
      7: CallSVN('\svn.exe', 'update ' + Path);
    end;
  end else if Tag = 6 then
    CallSVN('\svnlook.exe', 'tree ' + GuiPyOptions.SVNRepository);
end;

procedure TFSubversion.Commit;
  var m: string;
begin
  if InputQuery('Commit', _('Message'), m) then
    CallSVN('\svn.exe', 'commit -m "' + m + '"');
end;

procedure TFSubversion.Add;
{  var repos, TempFile1, TempFile2: string;
      FStream: TFileStream;
      i: integer;  }
begin
  CallSVN('\svn.exe', 'add ' + Pathname);
{
  Repos:= GetRepositoryURL(Pathname);
  TempFile1:= HideBlanks(GuiPyOptions.TempDir + 'RunPython.bat');
  TempFile2:= HideBlanks(Repos + '/RunPython.bat');
  FStream:= TFileStream.Create(TempFile1, fmCreate or fmShareExclusive);
  FreeAndNil(FStream);
  i:= 0;
  while OutputWindow.IsRunning and (i < 50) do begin
    Sleep(100);
    inc(i);
  end;
  CallSVN('\svn.exe', 'import ' + TempFile1 + ' ' + TempFile2 + ' -m ""');
  while OutputWindow.IsRunning and (i < 50) do begin
    Sleep(100);
    inc(i);
  end;
  CallSVN('\svn.exe', 'delete ' + TempFile2+ ' -m ""');
  while OutputWindow.IsRunning and (i < 50) do begin
    Sleep(100);
    inc(i);
  end;
  CallSVN('\svn.exe', 'checkout ' + Repos + ' ' + Path);
  while OutputWindow.IsRunning and (i < 50) do begin
    Sleep(100);
    inc(i);
  end;
  CallSVN('\svn.exe', 'add ' + Pathname);
  }
end;

procedure TFSubversion.Compare;
  var s1, s2, rev: string;
      aForm: TEditorForm; aFile: IFile;
begin
  ForFile(Pathname);
  if (ShowModal = mrOk) and (LVRevisions.ItemIndex > -1) then begin
    rev:= GetRevision;
    CallSVN('\svn.exe', 'cat -r ' + rev + ' ' + Pathname);
    s1:= OutputWindow.lsbConsole.Items[0];
    OutputWindow.lsbConsole.Items.Delete(0);
    s2:= FileName;
    System.insert('[R' + rev + ']', s2, Pos('.', s2));
    s2:= TPath.Combine(GuiPyOptions.TempDir, s2);

    aFile:= PyIDEMainForm.DoOpenAsEditor(s2);
    if Assigned(aFile) then begin
      aForm:= TEditorForm(aFile.Form);
      aForm.PutText(OutputWindow.lsbConsole.Items.Text, False);
      aForm.DoSave;
    end;
    OutputWindow.lsbConsole.Items.Text:= s1;
  end else
    OutputWindow.ClearScreen;
end;

end.
