unit dlgRemoteFile;

interface

uses
  System.UITypes,
  System.ImageList,
  System.Classes,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.VirtualImageList,
  Vcl.ImgList,
  Vcl.Controls,
  dlgPyIDEBase;

type
  TRemoteFileDialog = class(TPyIDEDlgBase)
    Panel1: TPanel;
    Label1: TLabel;
    edFileName: TEdit;
    Label2: TLabel;
    cbSSHConfigs: TComboBox;
    Panel2: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    btnSSHServersSetup: TButton;
    vilImages: TVirtualImageList;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSSHServersSetupClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TRemoteFileDialogType = (rfdOpen, rfdSave, rfdAdd, rfdSelect);

  function ExecuteRemoteFileDialog(var FileName, SSHServerName: string;
    DialogType: TRemoteFileDialogType): boolean;

implementation

Uses
  Vcl.Forms,
  Vcl.Dialogs,
  StringResources,
  cSSHSupport,
  JvGnugettext,
  uCommonFunctions,
  dmResources,
  uEditAppIntfs;

{$R *.dfm}


function ExecuteRemoteFileDialog(var FileName, SSHServerName: string;
  DialogType: TRemoteFileDialogType): boolean;
begin
  with TRemoteFileDialog.Create(Application.MainForm) do begin
    edFileName.Text := FileName;
    FillSSHConfigNames(cbSSHConfigs.Items);
    if SSHServerName <> '' then
      cbSSHConfigs.ItemIndex := cbSSHConfigs.Items.IndexOf(SSHServerName)
    else if GI_PyControl.ActiveSSHServerName <> '' then
      cbSSHConfigs.ItemIndex := cbSSHConfigs.Items.IndexOf(GI_PyControl.ActiveSSHServerName);
    case DialogType of
      rfdOpen: Caption := _(SRemoteFileOpen);
      rfdSave: Caption := _(SRemoteFileSave);
      rfdAdd: Caption := _(SRemoteFileAdd);
      rfdSelect: Caption := _(SRemoteFileSelect);
    end;

    Result := ShowModal = mrOK;

    if Result then begin
      FileName := edFileName.Text;
      if cbSSHConfigs.ItemIndex >= 0 then
        SSHServerName := cbSSHConfigs.Items[cbSSHConfigs.ItemIndex];
    end;

    Release;
  end;
end;

procedure TRemoteFileDialog.btnSSHServersSetupClick(Sender: TObject);
begin
  if EditSSHServers then
    FillSSHConfigNames(cbSSHConfigs.Items);
end;

procedure TRemoteFileDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
  if (ModalResult = mrOK) and (edFileName.Text = '') then
    StyledMessageDlg(_(SErrorEmptyPath), mtError, [mbAbort], 0)
  else if (ModalResult = mrOK) and (cbSSHConfigs.ItemIndex < 0) then
    StyledMessageDlg(_(SErrorEmptySSH), mtError, [mbAbort], 0)
  else
    CanClose := True;
end;

procedure TRemoteFileDialog.HelpButtonClick(Sender: TObject);
begin
  if HelpContext <> 0 then
    Application.HelpContext(HelpContext);
end;

end.
