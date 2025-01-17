unit UStrings;

interface

uses
  Windows, Messages, Forms, StdCtrls, Classes, Controls, dlgPyIDEBase;

type
  TFStringEditor = class(TPyIDEDlgBase)
    MStrings: TMemo;
    BOK: TButton;
    BCancel: TButton;
    procedure FormCreate(Sender: TObject);
  end;

var
  FStringEditor: TFStringEditor;

implementation

uses UConfiguration, JvGnugettext;

{$R *.DFM}

procedure TFStringEditor.FormCreate(Sender: TObject);
begin
  inherited;
  PixelsPerInch := Screen.PixelsPerInch;
  if (PixelsPerInch <> 96) then begin
    Width := LongInt(Width * PixelsPerInch) div 96;
    Height := LongInt(Height * PixelsPerInch) div 96;
  end;
end;

end.
