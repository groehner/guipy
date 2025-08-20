{ -------------------------------------------------------------------------------
  Unit:     UConnectForm
  Author:   Gerhard Röhner
  Date:     July 2019
  Purpose:  form to connect lifelines
  ------------------------------------------------------------------------------- }

unit UConnectForm;

interface

uses
  Windows,
  Classes,
  Controls,
  StdCtrls,
  ComCtrls,
  ImgList,
  ImageList,
  Vcl.VirtualImageList,
  dlgPyIDEBase,
  USequencePanel;

type

  TFConnectForm = class(TPyIDEDlgBase)
    LBConnections: TListBox;
    LSelect: TLabel;
    BOK: TButton;
    BTurn: TButton;
    BDelete: TButton;
    BCancel: TButton;
    LMessage: TLabel;
    ERelation: TEdit;
    vilConnectionsLight: TVirtualImageList;
    vilConnectionsDark: TVirtualImageList;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBConnectionsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LBConnectionsDblClick(Sender: TObject);
    procedure LBConnectionsClick(Sender: TObject);
  private
    FILConnections: TVirtualImageList;
    FIsTurned: Boolean;
  public
    procedure Init(IsConnecting: Boolean; Conn: TConnection);
    function GetConnectionAttributes: TConnectionAttributes;
  end;

implementation

uses
  SysUtils,
  Graphics,
  Forms,
  Themes,
  UConfiguration;

{$R *.dfm}

procedure TFConnectForm.FormCreate(Sender: TObject);
begin
  inherited;
  LBConnections.Color := StyleServices.GetSystemColor(clWindow);
  LBConnections.ItemHeight := LBConnections.Height div LBConnections.
    Items.Count;
  if TFConfiguration.isDark then
    FILConnections := vilConnectionsDark
  else
    FILConnections := vilConnectionsLight;
end;

procedure TFConnectForm.FormShow(Sender: TObject);
begin
  Top := Mouse.CursorPos.Y + 25;
  if Top + Height > Application.MainForm.Height then
    Top := Application.MainForm.Height - Height - 25;
  Left := Mouse.CursorPos.X + 25;
  if Left + Width > Application.MainForm.Width then
    Left := Application.MainForm.Width - Width - 25;
  ShowScrollBar(LBConnections.Handle, SB_VERT, False);
  ERelation.SetFocus;
end;

procedure TFConnectForm.LBConnectionsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  var
  ACaption := (Control as TListBox).Items[Index];
  var
  ACanvas := (Control as TListBox).Canvas;
  ACanvas.FillRect(Rect);
  FILConnections.SetSize(Rect.Height, Rect.Height);
  FILConnections.Draw(ACanvas, 4, Rect.Top, 12 + Index);
  ACanvas.TextOut(4 + FILConnections.Width + 8, Rect.Top + 2, ACaption);
end;

procedure TFConnectForm.LBConnectionsClick(Sender: TObject);
begin
  ERelation.SetFocus;
end;

procedure TFConnectForm.LBConnectionsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFConnectForm.Init(IsConnecting: Boolean; Conn: TConnection);
begin
  if IsConnecting then
  begin
    BTurn.Enabled := False;
    BDelete.Enabled := False;
  end
  else
  begin
    BTurn.Enabled := True;
    BDelete.Enabled := True;
  end;
  if Assigned(Conn) then
  begin
    ERelation.Text := Conn.AMessage;
    LBConnections.ItemIndex := Ord(Conn.ArrowStyle);
    FIsTurned := False;
    if Conn.IsRecursiv then
    begin
      LBConnections.Items.Delete(4);
      LBConnections.Items.Delete(3);
    end;
  end
  else
  begin
    ERelation.Text := '';
    LBConnections.ItemIndex := 0;
  end;
end;

function TFConnectForm.GetConnectionAttributes: TConnectionAttributes;
begin
  Result := TConnectionAttributes.Create;
  Result.ArrowStyle := TArrowStyle(LBConnections.ItemIndex);
  if Result.ArrowStyle = casClose then
  begin
    var
    Str := Trim(ERelation.Text);
    if Str = '' then
      Str := GuiPyLanguageOptions.SDClose;
    ERelation.Text := Str;
  end;
  Result.AMessage := ERelation.Text;
end;

end.
