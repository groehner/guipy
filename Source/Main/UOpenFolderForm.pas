unit UOpenFolderForm;

interface

uses
  System.Classes,
  Vcl.Controls,
  Forms,
  StdCtrls,
  ShellCtrls,
  dlgPyIDEBase;

type

  TFOpenFolderForm = class(TPyIDEDlgBase)
    LFiletype: TLabel;
    BOK: TButton;
    BCancel: TButton;
    CBFiletype: TComboBox;
    CBWithSubFolder: TCheckBox;
    CBPath: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FPathTreeView: TShellTreeView;
  public
    destructor Destroy; override;
    property PathTreeView: TShellTreeView read FPathTreeView;
  end;

implementation

uses
  SysUtils,
  UConfiguration;

{$R *.dfm}

procedure TFOpenFolderForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPathTreeView:= TShellTreeView.Create(Self);
  CBPath.Items.CommaText:= GuiPyOptions.OpenFolderFormItems;
  if (CBPath.Items.Count > 0) and DirectoryExists(CBPath.Items[0])
    then CBPath.Text:= CBPath.Items[0]
    else CBPath.Text:= GuiPyOptions.Sourcepath;
  with FPathTreeView do begin
    Parent:= Self;
    SetBounds(8, 8, 380, 270);
    HideSelection:= False;
    Path:= CBPath.Text;
    AutoRefresh:= True;
  end;
end;

procedure TFOpenFolderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  GuiPyOptions.OpenFolderFormItems:= CBPath.Items.CommaText;
end;

destructor TFOpenFolderForm.Destroy;
begin
  FreeAndNil(FPathTreeView);
  inherited;
end;

end.
