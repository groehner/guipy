{-----------------------------------------------------------------------------
 Unit Name: dlgPyIDEBase
 Author:    Kiriakos Vlahos, Gerhard Röhner
 Date:      08-Aug-2006
 Purpose:   base class for all dialogs
 History:
-----------------------------------------------------------------------------}

unit dlgPyIDEBase;

interface

uses
  Forms;

type
  TPyIDEDlgBase = class(TForm)
    procedure FormCreate(Sender: TObject);
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
  { I have problems to load dfm forms correctly.
    The ParentFont property often changes it's value during loading from the stream.
    Therefore I here set ParentFont:= false

    Debugging in these two methods
      procedure TControl.ChangeScale(M, D: Integer; isDpiChange: Boolean);
      procedure TCustomForm.WMDpiChanged(var Message: TWMDpi);
    was very helpful to understand the things during a dpi change.
  }

  ParentFont:= False;
  TranslateComponent(Self);
  Font.PixelsPerInch := FCurrentPPI;
  SetDefaultUIFont(Font);
  {$IF CompilerVersion >= 36}
  Font.IsDPIRelated := True;
  {$ELSE}
  Font.PixelsPerInch := Screen.PixelsPerInch;
  {$ENDIF}
end;

end.
