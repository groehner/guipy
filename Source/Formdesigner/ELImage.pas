{ -----------------------------------------------------------------------------
  Unit:     ELImage
  Author:   Gerhard Röhner
  Date:     July 2014
  Purpose:  icon editor for object inspector
  ----------------------------------------------------------------------------- }

unit ELImage;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Dialogs,
  ExtDlgs,
  ExtCtrls,
  dlgPyIDEBase;

type
  TFIconEditor = class(TPyIDEDlgBase)
    BSelect: TButton;
    BLoeschen: TButton;
    BOK: TButton;
    ODIconDialog: TOpenPictureDialog;
    ImagePanel: TPanel;
    Image: TImage;
    procedure SetValue(const Value: string);
    procedure BSelectClick(Sender: TObject);
    procedure BLoeschenClick(Sender: TObject);
  private
    FValue: string;
  public
    property Value: string read FValue write SetValue;
  end;

implementation

uses
  SysUtils,
  UGUIDesigner,
  UUtils;

{$R *.dfm}

procedure TFIconEditor.SetValue(const Value: string);
var
  Pathname: string;
begin
  if Assigned(Image.Picture) then
    Image.Picture.Assign(nil);
  if Pos('images/', Value) = 1 then
    Pathname := FGUIDesigner.getPath + 'images\' + Copy(Value, 8, Length(Value))
  else
    Pathname := Value;
  if FileExists(Pathname) then
    Image.Picture.LoadFromFile(Pathname);
  FValue := Value;
end;

procedure TFIconEditor.BLoeschenClick(Sender: TObject);
begin
  Value := '(Image)'; // (Icon)
  Image.Picture.Assign(nil);
end;

procedure TFIconEditor.BSelectClick(Sender: TObject);
begin
  with ODIconDialog do
  begin
    FileName := '';
    InitialDir := FGUIDesigner.getPath + 'images';
    ForceDirectories(InitialDir);
    Filter := '*.jpg;*.jpeg;*.png;*.gif|*.jpg;*.jpeg;*.png;*.gif|*.jpg;' +
              '*.jpeg|*.jpg;*.jpeg|*.png|*.png|*.gif|*.gif|*.*|*.*';
    FilterIndex := 0;
    try
      if Execute then
        Value := FileName;
    except
      on e: Exception do
        ErrorMsg(e.Message);
    end;
  end;
end;

end.
