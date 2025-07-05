unit UFileStructure;

interface

uses
  System.Classes,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.Graphics,
  TB2Item,
  SpTBXItem,
  SVGIconImageCollection,
  VirtualTrees,
  VirtualTrees.AncestorVCL,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.BaseTree,
  frmIDEDockWin,
  frmFile;

type
  TInteger = class
  private
    FInt: Integer;
  public
    constructor Create(Int: Integer);
    property Int: Integer read FInt;
  end;

  TFFileStructure = class(TIDEDockWindow)
    PMFileStructure: TSpTBXPopupMenu;
    MIClose: TSpTBXItem;
    MIDefaultLayout: TSpTBXItem;
    MIFont: TSpTBXItem;
    icFileStructure: TSVGIconImageCollection;
    vilFileStructureLight: TVirtualImageList;
    vilFileStructureDark: TVirtualImageList;
    vilFileStructure: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure MIFontClick(Sender: TObject);
    procedure MIDefaulLayoutClick(Sender: TObject);
    procedure MICloseClick(Sender: TObject);
    procedure vilFileStructureGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vilFileStructureGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure vilFileStructureFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vilFileStructureClick(Sender: TObject);
    procedure vilFileStructureMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vilFileStructureKeyPress(Sender: TObject; var Key: Char);
  private
    FMyForm: TFileForm;
    function DifferentItems(Items: TTreeNodes): Boolean;
    procedure NavigateToVilNode(Node: PVirtualNode;
      ForceToMiddle: Boolean = True; Activate: Boolean = True);
    procedure SetFont(AFont: TFont);
  public
    procedure Init(Items: TTreeNodes; Form: TFileForm);
    procedure ShowEditorCodeElement(Line: Integer);
    procedure Clear(Form: TFileForm);
    procedure ChangeStyle;
    property MyForm: TFileForm read FMyForm;
  end;

var
  FFileStructure: TFFileStructure;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils,
  VirtualTrees.Types,
  JvGnugettext,
  SynEdit,
  JvDockControlForm,
  dmResources,
  uEditAppIntfs,
  uCommonFunctions,
  frmPyIDEMain,
  frmEditor,
  UUMLForm,
  UUtils,
  UGUIDesigner,
  UConfiguration;

type
  PMyRec = ^TMyRec;

  TMyRec = record
    LineNumber: Integer;
    ImageIndex: Integer;
    Caption: string;
  end;

constructor TInteger.Create(Int: Integer);
begin
  inherited Create;
  FInt := Int;
end;

{ --- TFFileStructure ---------------------------------------------------------- }

{ If TVFiletructure has ParentFont true and the default font with size 9
  then during dpi change the font doesn't change, remains small. But if it has
  another font size, then during dpi change it's size is scaled.

  But the dependency does not exist if ParentFont is false.
}

procedure TFFileStructure.FormCreate(Sender: TObject);
begin
  inherited;
  Visible := False;
  TranslateComponent(Self);
  FMyForm := nil;
  ChangeStyle;

  // Let the tree know how much data space we need.
  vilFileStructure.NodeDataSize := SizeOf(TMyRec);
  // used options: toShowTreeLines, toShowRoot
end;

procedure TFFileStructure.FormShow(Sender: TObject);
begin
  Font.Assign(GuiPyOptions.StructureFont);
  Font.Size := PPIScale(Font.Size);
  SetFont(Font);
  SetFocus;
end;

procedure TFFileStructure.SetFont(AFont: TFont);
begin
  vilFileStructure.Font.Size := AFont.Size;
  vilFileStructure.Font.Name := AFont.Name;
  AFont.Size := PPIUnScale(AFont.Size);
  GuiPyOptions.StructureFont.Assign(AFont);
end;

procedure TFFileStructure.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFFileStructure.Clear(Form: TFileForm);
begin
  if Assigned(FMyForm) and (Form.Pathname = FMyForm.Pathname) then
  begin
    vilFileStructure.Clear;
    FMyForm := nil;
  end;
end;

procedure TFFileStructure.FormDestroy(Sender: TObject);
begin
  vilFileStructure.Clear;
end;

procedure TFFileStructure.Init(Items: TTreeNodes; Form: TFileForm);

  function addNode(Node: TTreeNode; Anchor: PVirtualNode): PVirtualNode;
  var
    Data: PMyRec;
  begin
    Result := vilFileStructure.AddChild(Anchor);
    Data := vilFileStructure.GetNodeData(Result);
    Data.LineNumber := TInteger(Node.Data).Int;
    Data.ImageIndex := Node.ImageIndex;
    Data.Caption := Node.Text;
    vilFileStructure.ValidateNode(Result, False);
  end;

  procedure AddClasses(ClassNode: TTreeNode; Anchor: PVirtualNode);
  var
    Node: TTreeNode;
    VilClassNode: PVirtualNode;
  begin
    while Assigned(ClassNode) do
    begin
      VilClassNode := addNode(ClassNode, Anchor);
      Node := ClassNode.getFirstChild;
      while Assigned(Node) do
      begin
        if Node.ImageIndex = 0 // is node an inner class
        then
          AddClasses(Node, VilClassNode)
        else
          addNode(Node, VilClassNode);
        Node := Node.getNextSibling;
      end;
      ClassNode := ClassNode.getNextSibling;
    end;
  end;

begin
  FMyForm := Form;
  if DifferentItems(Items) then
  begin
    vilFileStructure.BeginUpdate;
    vilFileStructure.Clear;
    AddClasses(Items.GetFirstNode, vilFileStructure.RootNode);
    vilFileStructure.EndUpdate;
    vilFileStructure.FullExpand;
  end;
end;

procedure TFFileStructure.vilFileStructureFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PMyRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFFileStructure.vilFileStructureGetImageIndex
  (Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  Data: PMyRec;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    Data := Sender.GetNodeData(Node);
    ImageIndex := Data.ImageIndex;
  end
  else
    ImageIndex := -1;
end;

procedure TFFileStructure.vilFileStructureGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PMyRec;
begin
  if TextType = ttNormal then
  begin
    Data := Sender.GetNodeData(Node);
    CellText := Data.Caption;
  end;
end;

procedure TFFileStructure.vilFileStructureMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PMFileStructure.Popup(X + (Sender as TVirtualStringTree).ClientOrigin.X -
      40, Y + (Sender as TVirtualStringTree).ClientOrigin.Y - 5);
end;

function TFFileStructure.DifferentItems(Items: TTreeNodes): Boolean;
var
  Data: PMyRec;
begin
  if vilFileStructure.TotalCount <> Cardinal(Items.Count) then
    Exit(True);
  var
  I := -1;
  for var Node in vilFileStructure.Nodes do
  begin
    Inc(I);
    Data := vilFileStructure.GetNodeData(Node);
    if Data.Caption <> Items[I].Text then
      Exit(True);
  end;
  Result := False;
end;

procedure TFFileStructure.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  ResourcesDataModule.dlgFontDialog.Options := [];
  if ResourcesDataModule.dlgFontDialog.Execute then
  begin
    Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
    SetFont(Font);
  end;
end;

procedure TFFileStructure.MIDefaulLayoutClick(Sender: TObject);
begin
  PyIDEMainForm.mnViewDefaultLayoutClick(Self);
end;

procedure TFFileStructure.MICloseClick(Sender: TObject);
begin
  HideDockForm(Self);
end;

procedure TFFileStructure.vilFileStructureClick(Sender: TObject);
var
  Data: PMyRec;
begin
  var
  Node := vilFileStructure.GetFirstSelected;
  if not Assigned(Node) then
    Exit;
  NavigateToVilNode(Node);

  Data := vilFileStructure.GetNodeData(Node);
  var
  Attri := Data.Caption;
  Delete(Attri, 1, Pos(' ', Attri));
  if (Pos('(', Attri) = 0) and Assigned(FGUIDesigner.ELDesigner) then
  // methods can't be selected
    FGUIDesigner.ELDesigner.SelectControl(Attri);
end;

procedure TFFileStructure.vilFileStructureKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Char(VK_RETURN) then
    NavigateToVilNode(vilFileStructure.GetFirstSelected);
end;

procedure TFFileStructure.ShowEditorCodeElement(Line: Integer);
var
  Data: PMyRec;
  Node, FoundNode: PVirtualNode;
begin
  FoundNode := nil;
  for Node in vilFileStructure.Nodes do
  begin
    Data := vilFileStructure.GetNodeData(Node);
    if Data.LineNumber = Line then
    begin
      FoundNode := Node;
      Break;
    end
    else if Data.ImageIndex in [1 .. 3] then
      Continue
    else if Data.LineNumber > Line then
      Break
    else
      FoundNode := Node;
  end;
  if Assigned(FoundNode) then
    vilFileStructure.Selected[FoundNode] := True;
end;

procedure TFFileStructure.NavigateToVilNode(Node: PVirtualNode;
  ForceToMiddle: Boolean = True; Activate: Boolean = True);
var
  ANodeLine: Integer;
  ANodeText: string;
  EditForm: TEditorForm;
  ASynEdit: TSynEdit;
  Data: PMyRec;

  function GetEditFormForUMLFile: TEditorForm;
    var
      Files, FileContent: TStringList;
      Filename: string;
      AFile: IFile;
  begin
    Result := nil;
    Files := (FMyForm as TFUMLForm).MainModul.Model.ModelRoot.Files;
    while vilFileStructure.NodeParent[Node] <> nil do
      Node := vilFileStructure.NodeParent[Node];
    Data := vilFileStructure.GetNodeData(Node);
    FileContent:= TStringList.Create;
    try
      for Filename in Files do
      begin
        if not FileExists(Filename) then
          Continue;
        FileContent.LoadFromFile(Filename);
        if Pos('class ' + Data.Caption, FileContent.Text) > 0 then
        begin
          AFile:= GI_EditorFactory.OpenFile(Filename);
          if Assigned(AFile) then
            Exit(AFile.Form as TEditorForm);
        end;
      end;
    finally
      FreeAndNil(FileContent);
    end;
  end;

begin
  if not Assigned(Node) or not Assigned(FMyForm) then
    Exit;
  Data := vilFileStructure.GetNodeData(Node);
  ANodeLine := Data.LineNumber;
  ANodeText := Data.Caption;
  EditForm := nil;

  if FMyForm.MyFile.GetFileKind = fkEditor then
    EditForm := FMyForm as TEditorForm;
  if FMyForm.MyFile.GetFileKind = fkUML then
    EditForm:= GetEditFormForUMLFile;
  if not Assigned(EditForm) then
    Exit;

  EditForm.ShowTopLine(ANodeLine, ANodeText);
  ASynEdit:= EditForm.ActiveSynEdit;
  if Activate and CanActuallyFocus(ASynEdit) then
    ASynEdit.SetFocus;
  GI_PyIDEServices.ShowFilePosition(EditForm.Pathname, ASynEdit.CaretY, ASynEdit.CaretX);
end;

procedure TFFileStructure.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
    vilFileStructure.Images := vilFileStructureDark
  else
    vilFileStructure.Images := vilFileStructureLight;
end;

end.
