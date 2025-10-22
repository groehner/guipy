unit dlgImportDirectory;

interface

uses
  System.Classes,
  System.ImageList,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  dlgPyIDEBase;

type
  TImportDirectoryForm = class(TPyIDEDlgBase)
    Panel1: TPanel;
    ebMask: TEdit;
    cbRecursive: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    DirectoryEdit: TButtonedEdit;
    vilImages: TVirtualImageList;
    cbAutoUpdate: TCheckBox;
    cbPythonPath: TCheckBox;
    procedure DirectoryEditBtnClick(Sender: TObject);
  public
    class var FileMasks: string;
    class var Directory: string;
    class var Recursive: Boolean;
    class var AutoUpdate: Boolean;
    class var AddToPath: Boolean;
    class function Execute: Boolean;
  end;


implementation

uses
  Winapi.ShLwApi,
  Vcl.FileCtrl,
  Vcl.Forms,
  Vcl.Dialogs,
  JvGnugettext,
  dmResources;

{$R *.dfm}

{ TImportDirectoryForm }

procedure TImportDirectoryForm.DirectoryEditBtnClick(Sender: TObject);
var
  NewDir: string;
  Directories: TArray<string>;
begin
  NewDir := DirectoryEdit.Text;
  if SelectDirectory(NewDir, Directories, [], _('Select directory')) then
    DirectoryEdit.Text := Directories[0];
end;

class function TImportDirectoryForm.Execute: Boolean;
var
  Owner: TCustomForm;
begin
  if Assigned(Screen.ActiveCustomForm) then
    Owner := Screen.ActiveCustomForm
  else
    Owner := Application.MainForm;
  with TImportDirectoryForm.Create(Owner) do
  begin
    DirectoryEdit.Text := Directory;
    ebMask.Text := FileMasks;
    cbRecursive.Checked := Recursive;
    cbAutoUpdate.Checked := AutoUpdate;
    cbPythonPath.Checked := AddToPath;
    SHAutoComplete(DirectoryEdit.Handle, SHACF_FILESYSTEM or
      SHACF_AUTOAPPEND_FORCE_ON or SHACF_AUTOSUGGEST_FORCE_OFF);
    Result := ShowModal = mrOk;
    if Result then
    begin
      Result := True;
      FileMasks := ebMask.Text;
      Directory := DirectoryEdit.Text;
      Recursive := cbRecursive.Checked;
      AutoUpdate := cbAutoUpdate.Checked;
      AddToPath := cbPythonPath.Checked;
    end;
    Release;
  end;
end;

initialization
  TImportDirectoryForm.FileMasks := '*.py;*.pyw;*.toml';
  TImportDirectoryForm.Recursive := True;
  TImportDirectoryForm.AutoUpdate := True;
  TImportDirectoryForm.AddToPath := True;
end.
