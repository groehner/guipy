unit dlgCommandLine;

interface

uses
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  SynEdit,
  SpTBXControls,
  SpTBXItem,
  SpTBXMDIMRU,
  dlgPyIDEBase, TB2Item, Vcl.Menus, Vcl.Controls, System.Classes;

type
  TCommandLineDlg = class(TPyIDEDlgBase)
    Panel: TPanel;
    SynParameters: TSynEdit;
    TBXButton1: TSpTBXButton;
    TBXPopupHistory: TSpTBXPopupMenu;
    EmptyHistoryPopupItem: TSpTBXItem;
    mnCommandHistoryMRU: TSpTBXMRUListItem;
    cbUseCommandLine: TCheckBox;
    Label1: TLabel;
    Label3: TLabel;
    OKButton: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    procedure btnHelpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SynParametersEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure TBXPopupHistoryPopup(Sender: TObject);
    procedure mnCommandHistoryMRUClick(Sender: TObject;
      const Filename: string);
  public
    { Public declarations }
  end;

implementation

uses
  Vcl.Forms,
  JvAppIniStorage,
  dmResources,
  uEditAppIntfs;

{$R *.dfm}

procedure TCommandLineDlg.SynParametersEnter(Sender: TObject);
begin
  ResourcesDataModule.ParameterCompletion.Editor := SynParameters;
  ResourcesDataModule.ModifierCompletion.Editor := SynParameters;
end;

procedure TCommandLineDlg.TBXPopupHistoryPopup(Sender: TObject);
begin
  if mnCommandHistoryMRU.Count > 0 then
    EmptyHistoryPopupItem.Visible := False;
end;

procedure TCommandLineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  mnCommandHistoryMRU.LoadFromIni(
    (GI_PyIDEServices.AppStorage as TJvAppIniFileStorage).IniFile,
      'CommandLine MRU');
end;

procedure TCommandLineDlg.FormDestroy(Sender: TObject);
begin
  mnCommandHistoryMRU.SaveToIni(
    (GI_PyIDEServices.AppStorage as TJvAppIniFileStorage).IniFile,
      'CommandLine MRU');
end;

procedure TCommandLineDlg.mnCommandHistoryMRUClick(Sender: TObject;
  const Filename: string);
begin
  SynParameters.Text := Filename;
  SynParameters.SetFocus;
end;

procedure TCommandLineDlg.OKButtonClick(Sender: TObject);
begin
  if (SynParameters.Text <> '') and cbUseCommandLine.Checked then
    mnCommandHistoryMRU.MRUAdd(SynParameters.Text);
end;

procedure TCommandLineDlg.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
