{-----------------------------------------------------------------------------
 Unit Name: dlgPickList
 Author:    Kiriakos Vlahos
 Date:      10-Mar-2006
 Purpose:   Generic Pick List dialog
 History:
-----------------------------------------------------------------------------}
unit dlgPickList;

interface

uses
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.CheckLst,
  Vcl.Menus,
  Vcl.VirtualImageList,
  dlgPyIDEBase, System.ImageList, Vcl.ImgList, Vcl.Controls, System.Classes;

type
  TPickListDialog = class(TPyIDEDlgBase)
    PickListPopUp: TPopupMenu;
    mnSelectAll: TMenuItem;
    mnDeselectAll: TMenuItem;
    imgIcon: TImage;
    Panel2: TPanel;
    Bevel1: TBevel;
    Panel1: TPanel;
    btnSelectAll: TButton;
    btnDeselectAll: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    lbMessage: TLabel;
    CheckListBox: TCheckListBox;
    vilImages: TVirtualImageList;
    procedure mnDeselectAllClick(Sender: TObject);
    procedure mnSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    procedure SetScrollWidth;
  end;

var
  PickListDialog: TPickListDialog;

implementation

uses
  Winapi.Windows,
  System.Math;

{$R *.dfm}

procedure TPickListDialog.mnSelectAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to CheckListBox.Items.Count - 1 do
    CheckListBox.Checked[I]:= True;
end;

procedure TPickListDialog.SetScrollWidth;
var
  I: Integer;
  ItemMaxWidth: Integer;
begin
  ItemMaxWidth := 0;
  with CheckListBox do
  begin
    //  Calculate the Max Length
    for I := 0 to CheckListBox.Items.Count - 1 do
      ItemMaxWidth := Max(CheckListBox.Canvas.TextWidth(CheckListBox.Items[I]),
        ItemMaxWidth);
    ScrollWidth := ItemMaxWidth + 5;
  end;
end;

procedure TPickListDialog.FormCreate(Sender: TObject);
begin
  inherited;
  imgIcon.Picture.Icon.Handle := LoadIcon(0, IDI_INFORMATION);
end;

procedure TPickListDialog.mnDeselectAllClick(Sender: TObject);
var
  I : Integer;
begin
  for I := 0 to CheckListBox.Items.Count - 1 do
    CheckListBox.Checked[I] := False;
end;

end.
