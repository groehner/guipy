unit USubversion;

interface

uses
  Controls,
  StdCtrls,
  ComCtrls,
  Classes,
  uEditAppIntfs,
  dlgPyIDEBase;
type
  TFSubversion = class(TPyIDEDlgBase)
    LVRevisions: TListView;
    BOK: TButton;
    BCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure LVRevisionsDblClick(Sender: TObject);
    function ToRepository(const Str: string): string;
    procedure ForFile(const AFile: string);
    function GetRevision: string;
    function GetRepositoryURL(Str: string): string;
    function IsRepository(const Dir: string): Boolean;
    procedure CallSVN(const Programm, Call: string);
    procedure Commit;
    procedure Add;
    procedure Compare;
  private
    FPathname: string;
    FFilename: string;
    FPath: string;
  public
    procedure Execute(Tag: Integer; Editor: IEditor);
  end;

var
  FSubversion: TFSubversion = nil;

implementation

uses
  Forms,
  Dialogs,
  SysUtils,
  IOUtils,
  JvGnugettext,
  frmCommandOutput,
  cTools,
  UConfiguration,
  UUtils,
  frmEditor,
  frmPyIDEMain;

{$R *.dfm}

procedure TFSubversion.FormShow(Sender: TObject);
begin
  with LVRevisions do begin
    Columns[0].Caption:= _('Revision');
    Columns[1].Caption:= _('Author');
    Columns[2].Caption:= _('Date');
    Columns[3].Caption:= _('Message');
  end;
  Caption:= _('Revisions');
end;

procedure TFSubversion.ForFile(const AFile: string);
  var AMessage, Rev, Aut, Str: string;
    Posi, Int: Integer; ListItem: TListItem;
begin
  LVRevisions.Items.Clear;
  CallSVN('\svn.exe', 'log ' + AFile);
  Int:= 0;
  while OutputWindow.IsRunning and (Int < 10) do begin
    Sleep(100);
    Inc(Int);
  end;
  Int:= 2;
  while Int < OutputWindow.lsbConsole.Items.Count - 1 do begin
    Str:= OutputWindow.lsbConsole.Items[Int];
    ListItem := LVRevisions.Items.Add;
    Posi:= Pos(' | ', Str);
    Rev:= Copy(Str, 2, Posi-2);
    ListItem.Caption:= Rev;
    Delete(Str, 1, Posi + 2);
    Posi:= Pos(' | ', Str);
    Aut:= Copy(Str, 1, Posi-1);
    ListItem.SubItems.Add(Aut);
    Delete(Str, 1, Posi + 2);
    Posi:= Pos(':', Str);
    Delete(Str, Posi+5, Length(Str));
    ListItem.SubItems.Add(Str);
    AMessage:= OutputWindow.lsbConsole.Items[Int+2];
    ListItem.SubItems.Add(AMessage);
    Inc(Int, 4);
  end;
end;

function TFSubversion.GetRevision: string;
  var Index: Integer;
begin
  Index:= LVRevisions.ItemIndex;
  Result:= LVRevisions.Items[Index].Caption;
end;

function TFSubversion.IsRepository(const Dir: string): Boolean;
  var Str: string; StringList: TStringList;
begin
  Result:= False;
  Str:= WithTrailingSlash(Dir) + 'README.txt';
  if FileExists(Str) then begin
    StringList:= TStringList.Create;
    try
      StringList.LoadFromFile(Str);
      Result:= Pos('This is a Subversion repository;', StringList.Text) > 0;
    finally
      FreeAndNil(StringList);
    end;
  end;
end;

function TFSubversion.ToRepository(const Str: string): string;
  var Posi: Integer;
begin
  Result:= Str;
  Posi:= Pos(':', Result);
  if Posi = 2 then
    Delete(Result, 2, 1);
end;

function TFSubversion.GetRepositoryURL(Str: string): string;
begin
  Str:= WithoutTrailingSlash(ExtractFilePath(Str));
  Result:= ToWeb('IE', GuiPyOptions.SVNRepository + '/' + ToRepository(Str));
end;

procedure TFSubversion.LVRevisionsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFSubversion.CallSVN(const Programm, Call: string);
  var ExternalTool: TExternalTool;
begin
  ExternalTool:= TExternalTool.Create;
  ExternalTool.Caption:= 'Subversion (SVN)';
  ExternalTool.ApplicationName:= GuiPyOptions.SVNFolder + Programm;
  ExternalTool.Parameters:= Call;
  ExternalTool.WorkingDirectory:= FPath;
  ExternalTool.SaveFiles:= sfActive;
  ExternalTool.CaptureOutput:= True;
  OutputWindow.actToolTerminateExecute(Self);
  ExternalTool.Execute;
  FreeAndNil(ExternalTool);
end;

procedure TFSubversion.Execute(Tag: Integer; Editor: IEditor);
begin
  if Assigned(Editor) then begin
    FPathname:= Editor.FileName;
    FFilename:= ExtractFileName(FPathname);
    FPath:= ExtractFilePath(Editor.FileName);
    case Tag of
      1: Commit;
      2: Add;
      3: CallSVN('\svn.exe', 'log ' + FPathname);
      4: Compare;
      5: CallSVN('\svn.exe', 'status ' + FPath + ' -u -v');
      7: CallSVN('\svn.exe', 'update ' + FPath);
    end;
  end else if Tag = 6 then
    CallSVN('\svnlook.exe', 'tree ' + GuiPyOptions.SVNRepository);
end;

procedure TFSubversion.Commit;
  var AMessage: string;
begin
  if InputQuery('Commit', _('Message'), AMessage) then
    CallSVN('\svn.exe', 'commit -m "' + AMessage + '"');
end;

procedure TFSubversion.Add;
begin
  CallSVN('\svn.exe', 'add ' + FPathname);
end;

procedure TFSubversion.Compare;
  var Str1, Str2, Rev: string;
      Form: TEditorForm; AFile: IFile;
begin
  ForFile(FPathname);
  if (ShowModal = mrOk) and (LVRevisions.ItemIndex > -1) then begin
    Rev:= GetRevision;
    CallSVN('\svn.exe', 'cat -r ' + Rev + ' ' + FPathname);
    Str1:= OutputWindow.lsbConsole.Items[0];
    OutputWindow.lsbConsole.Items.Delete(0);
    Str2:= FFilename;
    System.Insert('[R' + Rev + ']', Str2, Pos('.', Str2));
    Str2:= TPath.Combine(GuiPyOptions.TempDir, Str2);
    AFile:= PyIDEMainForm.DoOpenAsEditor(Str2);
    if Assigned(AFile) then begin
      Form:= (AFile.Form as TEditorForm);
      Form.PutText(OutputWindow.lsbConsole.Items.Text, False);
      Form.DoSave;
    end;
    OutputWindow.lsbConsole.Items.Text:= Str1;
  end else
    OutputWindow.ClearScreen;
end;

end.
