unit dlgPyIDEBase;

interface

uses
  Forms;

type
  TPyIDEDlgBase = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PyIDEDlgBase: TPyIDEDlgBase;

implementation

uses
  uCommonFunctions,
  JvGnugettext;

{$R *.dfm}

procedure TPyIDEDlgBase.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
  SetDefaultUIFont(Font);
end;

end.
