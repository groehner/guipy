unit UMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UUtils;

type
  TFMemo = class(TForm)
    MInstallation: TMemo;
    BClose: TButton;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
  public
    Installation: Integer;
    procedure Output(s: string);
  end;

var
  FMemo: TFMemo;

implementation

uses JvGnugettext, USetup;

{$R *.DFM}

procedure TFMemo.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
  SaveDialog.Filter:= _('Text file|*.txt');
  SaveDialog.InitialDir:= 'C:\';
  Installation:= 2
end;

procedure TFMemo.Output(s: string);
begin
  MInstallation.Lines.Add(s);
end;

procedure TFMemo.BCloseClick(Sender: TObject);
begin
  case Installation of
    0: ExecuteFile(FSetup.DestDir + 'GuiPy.exe', '', '', SW_ShowNormal);
    1: ExecuteFile(GetTempDir + 'RunPy.bat', '', '', SW_Hide);
  end;
  FSetup.Close;
end;

end.
