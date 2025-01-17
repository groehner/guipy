unit UAssociation;

interface

uses
  Windows,
  System.Classes,
  Controls,
  StdCtrls,
  ComCtrls,
  ImgList,
  ExtCtrls,
  ImageList,
  Vcl.BaseImageCollection,
  Vcl.VirtualImageList,
  SVGIconImageCollection,
  dlgPyIDEBase,
  UConnection;

type
  TFAssociation = class(TPyIDEDlgBase)
    LBAssociations: TListBox;
    LSelect: TLabel;
    BOK: TButton;
    BTurn: TButton;
    BDelete: TButton;
    BCancel: TButton;
    LMultiplicityA: TLabel;
    LRelation: TLabel;
    LMultiplicityB: TLabel;
    ERelation: TEdit;
    RGRecursivCorner: TRadioGroup;
    LRoleA: TLabel;
    LRoleB: TLabel;
    CBReadingOrderA: TCheckBox;
    CBReadingOrderB: TCheckBox;
    MRoleA: TMemo;
    MRoleB: TMemo;
    MMultiplicityA: TMemo;
    MMultiplicityB: TMemo;
    vilConnectionsLight: TVirtualImageList;
    vilConnectionsDark: TVirtualImageList;
    icMenuConnection: TSVGIconImageCollection;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBAssociationsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LBAssociationsDblClick(Sender: TObject);
    procedure CBReadingOrderAClick(Sender: TObject);
    procedure CBReadingOrderBClick(Sender: TObject);
  private
    FILAssociations: TVirtualImageList;
  public
    isTurned: Boolean;
    procedure Init(IsConnecting: Boolean; Conn: TConnection; SelectedControls: Integer);
    function GetCorner: Integer;
    procedure SetCorner(I: Integer);
    function GetConnectionAttributes: TConnectionAttributes;
  end;

implementation

uses
  Forms,
  uCommonFunctions;


{$R *.dfm}

procedure TFAssociation.FormCreate(Sender: TObject);
begin
  inherited;
  LBAssociations.ItemHeight:= LBAssociations.Height div LBAssociations.Items.Count;
  CBReadingOrderA.Caption:= #$25C0 + ' ';
  CBReadingOrderB.Caption:= #$25B6 + ' ';
  if IsStyledWindowsColorDark
    then FILAssociations:= vilConnectionsDark
    else FILAssociations:= vilConnectionsLight;
end;

procedure TFAssociation.FormShow(Sender: TObject);
begin
  Top:= Mouse.CursorPos.Y + 25;
  if Top + Height > Application.MainForm.Height then
    Top:= Application.MainForm.Height - Height - 25;
  Left:= Mouse.CursorPos.X + 25;
  if Left + Width > Application.MainForm.Width then
    Left:= Application.MainForm.Width - Width - 25;
end;

procedure TFAssociation.LBAssociationsDblClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFAssociation.LBAssociationsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  var ACaption:=  (Control as TListBox).Items[Index];
  var ACanvas:= (Control as TListBox).Canvas;
  ACanvas.FillRect(Rect);
  FILAssociations.Draw(ACanvas, 4, Rect.Top + (Rect.Height - FILAssociations.Height) div 2, Index);
  ACanvas.TextOut(4 + FILAssociations.Width + 8, Rect.Top + 2, ACaption);
end;

function TFAssociation.GetCorner: Integer;
begin
  case RGRecursivCorner.ItemIndex of
    0: Result:= 2;
    1: Result:= 3;
    2: Result:= 1;
    3: Result:= 4;
    else Result:= 0;
  end;
end;

procedure TFAssociation.SetCorner(I: Integer);
  var Corner: Integer;
begin
  case I of
    1: Corner:= 2;
    2: Corner:= 0;
    3: Corner:= 1;
    4: Corner:= 3;
    else Corner:= -1;
  end;
  RGRecursivCorner.ItemIndex:= Corner;
end;

procedure TFAssociation.Init(IsConnecting: Boolean; Conn: TConnection; SelectedControls: Integer);
begin
  ClientHeight:= 495;
  var Height:= ((MMultiplicityA.Top + MMultiplicityA.Height) + RGRecursivCorner.Top) div 2 + 4;
  if IsConnecting then begin
    BTurn.Enabled:= False;
    BDelete.Enabled:= False;
    ClientHeight:= Height;
    end
  else begin
    BTurn.Enabled:= True;
    BDelete.Enabled:= True;
  end;
  if Assigned(Conn) then begin
    MRoleA.Lines.Text:= Conn.RoleA;
    MMultiplicityA.Lines.Text:= Conn.MultiplicityA;
    ERelation.Text:= Conn.Relation;
    CBReadingOrderA.Checked:= Conn.ReadingOrderA;
    CBReadingOrderB.Checked:= Conn.ReadingOrderB;
    MMultiplicityB.Lines.Text:= Conn.MultiplicityB;
    MRoleB.Lines.Text:= Conn.RoleB;
    LBAssociations.ItemIndex:= Ord(Conn.ArrowStyle);
    if Conn.isRecursiv
      then SetCorner(Conn.RecursivCorner)
      else ClientHeight:= Height;
    isTurned:= Conn.isTurned;
  end else begin
    MRoleA.Lines.Text:= '';
    MMultiplicityA.Lines.Text:= '';
    CBReadingOrderA.Checked:= False;
    ERelation.Text:= '';
    CBReadingOrderB.Checked:= False;
    MMultiplicityB.Lines.Text:= '';
    MRoleB.Lines.Text:= '';
    LBAssociations.ItemIndex:= 0;
    if SelectedControls = 1
      then SetCorner(1)
      else ClientHeight:= Height;
  end;
end;

procedure TFAssociation.CBReadingOrderAClick(Sender: TObject);
  const ArrowLeft : string = #$25C0 + ' ';
begin
  var Pos:= Pos(ArrowLeft, ERelation.Text);
  if CBReadingOrderA.Checked then begin
    if Pos = 0 then
      ERelation.Text:= ArrowLeft + ERelation.Text;
  end else if Pos > 0 then begin
    var Str:= ERelation.Text;
    Delete(Str, Pos, 2);
    ERelation.Text:= Str;
  end;
end;

procedure TFAssociation.CBReadingOrderBClick(Sender: TObject);
  const ArrowRight: string  = ' ' + #$25B6;
begin
  var Pos:= Pos(ArrowRight, ERelation.Text);
  if CBReadingOrderB.Checked then begin
    if Pos = 0 then
     ERelation.Text:= ERelation.Text + ArrowRight;
  end else if Pos > 0 then begin
    var Str:= ERelation.Text;
    Delete(Str, Pos, 2);
    ERelation.Text:= Str;
  end;
end;

function TFAssociation.GetConnectionAttributes: TConnectionAttributes;
begin
  var Attr:= TConnectionAttributes.Create;
  Attr.ArrowStyle:= TessConnectionArrowStyle(LBAssociations.ItemIndex);
  Attr.RoleA:= MRoleA.Lines.Text;
  Attr.MultiplicityA:= MMultiplicityA.Lines.Text;
  Attr.ReadingOrderA:= CBReadingOrderA.Checked;
  Attr.Relation:= ERelation.Text;
  Attr.ReadingOrderB:= CBReadingOrderB.Checked;
  Attr.MultiplicityB:= MMultiplicityB.Lines.Text;
  Attr.RoleB:= MRoleB.Lines.Text;
  Attr.RecursivCorner:= GetCorner;
  Attr.isTurned:= isTurned;
  Attr.isEdited:= True;
  Attr.Visible:= True;
  Result:= Attr;
end;

end.

