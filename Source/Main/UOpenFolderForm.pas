unit UOpenFolderForm;

interface

{$WARN UNIT_PLATFORM OFF}

uses
  System.Classes, Vcl.Controls, Forms, StdCtrls, ShellCtrls, dlgPyIDEBase;

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
  public
    PathTreeView: TShellTreeView;
    destructor Destroy; override;
  end;

implementation

uses SysUtils, UConfiguration;

{$R *.dfm}

procedure TFOpenFolderForm.FormCreate(Sender: TObject);
begin
  inherited;
  PathTreeView:= TShellTreeView.Create(self);
  CBPath.Items.CommaText:= GuiPyOptions.OpenFolderFormItems;
  if (CBPath.Items.Count > 0) and DirectoryExists(CBPath.Items[0])
    then CBPath.Text:= CBPath.Items[0]
    else CBPath.Text:= GuiPyOptions.Sourcepath;
  with PathTreeView do begin
    Parent:= Self;
    SetBounds(8, 8, 380, 270);
    HideSelection:= False;
    Path:= CBPath.Text;
    AutoRefresh:= true;
  end;
end;

procedure TFOpenFolderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
  GuiPyOptions.OpenFolderFormItems:= CBPath.Items.CommaText;
end;

destructor TFOpenFolderForm.Destroy;
begin
  FreeAndNil(PathTreeView);
  inherited;
end;

end.
