{-------------------------------------------------------------------------------
 Unit:     UConnectForm
 Author:   Gerhard Röhner
 Date:     July 2019
 Purpose:  form to connect lifelines
-------------------------------------------------------------------------------}

unit UConnectForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, ImageList, dlgPyIDEBase, USequencePanel;

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
    ILSequencediagramLight: TImageList;
    ILSequencediagramDark: TImageList;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBConnectionsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LBConnectionsDblClick(Sender: TObject);
  private
    isTurned: boolean;
    SL: TStringList;
    ILSequenceDiagram: TImageList;
    procedure ChangeStyle;
  public
    LNGClose: string;
    destructor Destroy; override;
    procedure init(IsConnecting: boolean; conn: TConnection; SelectedControls: integer);
    function getConnectionAttributes: TConnectionAttributes;
  end;

implementation

uses Themes, uCommonFunctions, JvGnugettext, UConfiguration;

{$R *.dfm}

procedure TFConnectForm.FormCreate(Sender: TObject);
begin
  inherited;
  LBConnections.ItemHeight:= LBConnections.Height div LBConnections.Items.Count;
  SL:= TStringList.create;
  SL.assign(LBConnections.Items);
  ILSequenceDiagram:= ILSequenceDiagramLight;
  ChangeStyle;
end;

destructor TFConnectForm.Destroy;
begin
  inherited;
  FreeAndNil(SL);
end;

procedure TFConnectForm.FormShow(Sender: TObject);
begin
  Top:= Mouse.CursorPos.Y + 25;
  if Top + Height > Application.MainForm.Height then
    Top:= Application.MainForm.Height - Height - 25;
  Left:= Mouse.CursorPos.X + 25;
  if Left + Width > Application.MainForm.Width then
    Left:= Application.MainForm.Width - Width - 25;
  ShowScrollBar(LBConnections.Handle, SB_VERT, false);
end;

procedure TFConnectForm.LBConnectionsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  var Bitmap: TBitmap; aCaption: String;
begin
  aCaption:= (Control as TListBox).Items[Index];
  BitMap:= TBitmap.Create;
  Bitmap.Transparent:= true;
  with (Control as TListBox).Canvas do begin
    FillRect(Rect);
    ILSequencediagram.GetBitmap(Index, Bitmap);
    Draw(0, Rect.Top, Bitmap);
    TextOut(Bitmap.Width + 8, Rect.Top + 3, aCaption);
  end;
  FreeAndNil(Bitmap);
end;

procedure TFConnectForm.LBConnectionsDblClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TFConnectForm.init(IsConnecting: Boolean; conn: TConnection; SelectedControls: integer);
begin
  if LBConnections.Items.Count <= 3 then begin
    LBConnections.Items[3]:= SL.Strings[3];
    LBConnections.Items[4]:= SL.Strings[4];
  end;
  if IsConnecting then begin
    BTurn.Enabled:= false;
    BDelete.Enabled:= false;
    end
  else begin
    BTurn.Enabled:= true;
    BDelete.Enabled:= true;
  end;
  if assigned(conn) then begin
    ERelation.Text:= conn.aMessage;
    LBConnections.ItemIndex:= Ord(conn.ArrowStyle);
    IsTurned:= false;
    if conn.isRecursiv then begin
      LBConnections.Items.delete(4);
      LBConnections.items.delete(3);
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
    s:= trim(ERelation.Text);
    if s = '' then
      s:= LNGClose;
    ERelation.Text:= s;
  end;
  Result.aMessage:= ERelation.Text;
end;

procedure TFConnectForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark
    then ILSequenceDiagram:= ILSequenceDiagramDark
    else ILSequenceDiagram:= ILSequenceDiagramLight;
  LBConnections.Color:= StyleServices.GetSystemColor(clWindow);
end;

end.
