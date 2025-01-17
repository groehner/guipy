{-------------------------------------------------------------------------------
 Unit:     UConnectForm
 Author:   Gerhard Röhner
 Date:     July 2019
 Purpose:  form to connect lifelines
-------------------------------------------------------------------------------}

unit UConnectForm;

interface

uses
  Windows, Classes, Controls, StdCtrls, ComCtrls, ImgList, ImageList,
  dlgPyIDEBase, USequencePanel, Vcl.VirtualImageList;

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
    ILConnections: TVirtualImageList;
    isTurned: Boolean;
  public
    LNGClose: string;
    procedure init(IsConnecting: Boolean; conn: TConnection; SelectedControls: Integer);
    function getConnectionAttributes: TConnectionAttributes;
  end;

implementation

uses SysUtils, Graphics, Forms, Themes, uCommonFunctions, UConfiguration;

{$R *.dfm}

procedure TFConnectForm.FormCreate(Sender: TObject);
begin
  inherited;
  LBConnections.Color:= StyleServices.GetSystemColor(clWindow);
  LBConnections.ItemHeight:= LBConnections.Height div LBConnections.Items.Count;
  if TFConfiguration.isDark
    then ILConnections:= vilConnectionsDark
    else ILConnections:= vilConnectionsLight;
end;

procedure TFConnectForm.FormShow(Sender: TObject);
begin
  Top:= Mouse.CursorPos.Y + 25;
  if Top + Height > Application.MainForm.Height then
    Top:= Application.MainForm.Height - Height - 25;
  Left:= Mouse.CursorPos.X + 25;
  if Left + Width > Application.MainForm.Width then
    Left:= Application.MainForm.Width - Width - 25;
  ShowScrollBar(LBConnections.Handle, SB_VERT, False);
  ERelation.SetFocus;
end;

procedure TFConnectForm.LBConnectionsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  var aCaption:= (Control as TListBox).Items[Index];
  var aCanvas:= (Control as TListBox).Canvas;
  aCanvas.FillRect(Rect);
  ILConnections.SetSize(Rect.Height, Rect.Height);
  ILConnections.Draw(aCanvas, 4, Rect.Top, 12 + Index);
  aCanvas.TextOut(4 + ILConnections.Width + 8, Rect.Top + 2, aCaption);
end;

procedure TFConnectForm.LBConnectionsClick(Sender: TObject);
begin
  ERelation.SetFocus;
end;

procedure TFConnectForm.LBConnectionsDblClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFConnectForm.init(IsConnecting: Boolean; conn: TConnection; SelectedControls: Integer);
begin
  if IsConnecting then begin
    BTurn.Enabled:= False;
    BDelete.Enabled:= False;
    end
  else begin
    BTurn.Enabled:= True;
    BDelete.Enabled:= True;
  end;
  if Assigned(conn) then begin
    ERelation.Text:= conn.aMessage;
    LBConnections.ItemIndex:= Ord(conn.ArrowStyle);
    IsTurned:= False;
    if conn.isRecursiv then begin
      LBConnections.Items.Delete(4);
      LBConnections.Items.Delete(3);
    end;
  end else begin
    ERelation.Text:= '';
    LBConnections.ItemIndex:= 0;
  end;
end;

function TFConnectForm.getConnectionAttributes: TConnectionAttributes;
  var s: string;
begin
  Result:= TConnectionAttributes.Create;
  Result.ArrowStyle:= TArrowStyle(LBConnections.ItemIndex);
  if Result.ArrowStyle = casClose then begin
    s:= Trim(ERelation.Text);
    if s = '' then
      s:= LNGClose;
    ERelation.Text:= s;
  end;
  Result.aMessage:= ERelation.Text;
end;

end.
