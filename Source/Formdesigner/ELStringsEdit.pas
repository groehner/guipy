{ ******************************************************* }
{ }
{ Extension Library }
{ Strin List Editor dialog Unit }
{ }
{ (c) 2002, Balabuyev Yevgeny }
{ E-mail: stalcer@rambler.ru }
{ Licence: Freeware }
{ https://torry.net/authorsmore.php?id=3588 }
{ }
{ ******************************************************* }

unit ELStringsEdit;

interface

uses
  Classes,
  ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Controls,
  dlgPyIDEBase;

var
  SELStringsEditorDlgCaption: string = 'String List Editor';
  SELStringsEditorDlgOkBtnCaption: string = '&Ok';
  SELStringsEditorDlgCancelBtnCaption: string = 'Cancel';
  SELStringsEditorDlgLinesCountTemplate: string = '%d lines';

type
  TELStringsEditorDlg = class(TPyIDEDlgBase)
    btnOk: TButton;
    btnCancel: TButton;
    lbLineCount: TLabel;
    bvlMain: TBevel;
    memMain: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure memMainChange(Sender: TObject);
  private
    function GetLines: TStrings;
    procedure SetLines(const Value: TStrings);
  public
    function Execute: Boolean;
    property Lines: TStrings read GetLines write SetLines;
  end;

implementation

uses
  Windows, Forms, SysUtils;

{$R *.dfm}

function TELStringsEditorDlg.Execute: Boolean;
begin
  Caption := SELStringsEditorDlgCaption;
  btnOk.Caption := SELStringsEditorDlgOkBtnCaption;
  btnCancel.Caption := SELStringsEditorDlgCancelBtnCaption;
  lbLineCount.Caption := Format(SELStringsEditorDlgLinesCountTemplate,
    [memMain.Lines.Count]);
  Result := (ShowModal = mrOk);
end;

procedure TELStringsEditorDlg.FormActivate(Sender: TObject);
var
  Mouse: TPoint;
begin
  Application.ProcessMessages;
  GetCursorPos(Mouse);
  SetCursorPos(Left + Width div 2, Top + Height div 2);
  if GetSystemMetrics(SM_SWAPBUTTON) = 0 then
  begin
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  end
  else
  begin
    mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
  end;
  SetCursorPos(Mouse.X, Mouse.Y);
end;

procedure TELStringsEditorDlg.FormResize(Sender: TObject);
begin
  SetBounds(Mouse.CursorPos.X - Width, Mouse.CursorPos.Y + 10, Width, Height);
end;

function TELStringsEditorDlg.GetLines: TStrings;
begin
  Result := memMain.Lines;
end;

procedure TELStringsEditorDlg.SetLines(const Value: TStrings);
begin
  memMain.Lines := Value;
end;

procedure TELStringsEditorDlg.memMainChange(Sender: TObject);
begin
  lbLineCount.Caption := Format(SELStringsEditorDlgLinesCountTemplate,
    [memMain.Lines.Count]);
end;

end.
