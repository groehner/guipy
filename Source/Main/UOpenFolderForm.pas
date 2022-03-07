unit UOpenFolderForm;

interface

{$WARN UNIT_PLATFORM OFF}

uses
  Windows, Messages, Forms, Dialogs, StdCtrls, Controls, ShellCtrls, Classes,
  dlgPyIDEBase;

type

  TFOpenFolderForm = class(TPyIDEDlgBase)
    LFiletype: TLabel;
    BOK: TButton;
    BCancel: TButton;
    CBFiletype: TComboBox;
    CBWithSubFolder: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    PathTreeView: TShellTreeView;
    destructor Destroy; override;
  end;

implementation

uses SysUtils, UConfiguration, JvGnugettext;

{$R *.dfm}

procedure TFOpenFolderForm.FormCreate(Sender: TObject);
begin
  inherited;
  PathTreeView:= TShellTreeView.Create(self);
  with PathTreeView do begin
    Parent:= Self;
    SetBounds(8, 8, 380, 250);
    HideSelection:= False;
    {$IFDEF LCL}
    PopulateWithBaseFiles;
    {$ENDIF}
  end;
end;

procedure TFOpenFolderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

destructor TFOpenFolderForm.Destroy;
begin
  FreeAndNil(PathTreeView);
  inherited;
end;

end.
