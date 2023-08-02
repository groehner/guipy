{-----------------------------------------------------------------------------
 Unit:     ELImage
 Author:   Gerhard Röhner
 Date:     July 2014
 Purpose:  icon editor for object inspector
-----------------------------------------------------------------------------}

unit ELImage;

interface

uses
  Windows, Messages, Classes, Forms, ExtDlgs, ExtCtrls,
  Vcl.StdCtrls, Vcl.Controls, Vcl.Dialogs, dlgPyIDEBase;

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
    property Value: String read FValue write SetValue;
  end;

implementation

uses SysUtils, Graphics, UGuiDesigner, UUtils;

{$R *.dfm}

procedure TFIconEditor.SetValue(const Value: string);
  var pathname: string;
begin
  if assigned(Image.Picture) then
    Image.Picture.Assign(nil);
  if pos('images/', Value) = 1
    then pathname:= FGuiDesigner.getPath + 'images\' + copy(Value, 8, length(Value))
    else pathname:= Value;
  if FileExists(pathname) then
    Image.Picture.LoadFromFile(pathname);
  FValue:= Value;
end;

procedure TFIconEditor.BLoeschenClick(Sender: TObject);
begin
  Value:= '(Image)'; // (Icon)
  Image.Picture.Assign(nil);
end;

procedure TFIconEditor.BSelectClick(Sender: TObject);
begin
  with ODIconDialog do begin
    Filename:= '';
    InitialDir:= FGuiDesigner.getPath + 'images';
    ForceDirectories(Initialdir);
    Filter:= '*.jpg;*.jpeg;*.png;*.gif|*.jpg;*.jpeg;*.png;*.gif|*.jpg;*.jpeg|*.jpg;*.jpeg|*.png|*.png|*.gif|*.gif|*.*|*.*';
    FilterIndex:= 0;
    try
      if Execute then
        Value:= Filename;
    except on e: Exception do
      ErrorMsg(e.Message);
    end;
  end;
end;


end.
