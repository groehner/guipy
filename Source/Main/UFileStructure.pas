unit UFileStructure;

interface

uses
  System.Classes, System.ImageList, Vcl.ImgList,  Vcl.Menus, Controls, Forms,
  ComCtrls, JvAppStorage,
  frmIDEDockWin, frmFile, TB2Item, SpTBXItem, Vcl.ExtCtrls,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, SVGIconImageCollection,
  VirtualTrees.BaseAncestorVCL, VirtualTrees.BaseTree, VirtualTrees.AncestorVCL,
  VirtualTrees;

type
  TInteger = class
  public
    i: integer;
    constructor create(aI: Integer);
  end;

  TFFileStructure = class(TIDEDockWindow, IJvAppStorageHandler)
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
    locked: boolean;
    LockShowSelected: boolean;
    function DifferentItems(Items: TTreeNodes): boolean;
    procedure NavigateToVilNode(Node: PVirtualNode;
                ForceToMiddle : Boolean = True; Activate : Boolean = True);
  protected
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    myForm: TFileForm;
    procedure Init(Items: TTreeNodes; Form: TFileForm);
    procedure ShowEditorCodeElement(Line: integer);
    procedure Clear(Form: TFileForm);
    procedure ChangeStyle;
  end;

var
  FFileStructure: TFFileStructure;

implementation

{$R *.dfm}

uses Math, Windows, Messages, SysUtils, Graphics, Dialogs,
     frmPyIDEMAin, frmEditor, JvDockControlForm, dmResources, uEditAppIntfs,
     JvGnugettext, SynEdit, uCommonFunctions, VirtualTrees.Types,
     UUMLForm, UUtils, UGUIDesigner;

type
  PMyRec = ^TMyRec;
  TMyRec = record
    LineNumber: Integer;
    ImageIndex: Integer;
    Caption: string;
  end;

constructor TInteger.create(aI: Integer);
begin
  inherited create;
  self.i:= aI;
end;

{--- TFFileStructure ----------------------------------------------------------}

{ If TVFiletructure has ParentFont true and the default font with size 9
  then during dpi change the font doesn't change, remains small. But if it has
  another font size, then during dpi change it's size is scaled.

  But the dependency does not exist if ParentFont is false.
}

procedure TFFileStructure.FormCreate(Sender: TObject);
begin
  inherited;
  visible:= false;
  locked:= false;
  LockShowSelected:= false;
  TranslateComponent(Self);
  myForm:= nil;
  ChangeStyle;

  // Let the tree know how much data space we need.
  vilFileStructure.NodeDataSize := SizeOf(TMyRec);
  // used options: toShowTreeLines, toShowRoot
end;

procedure TFFileStructure.FormShow(Sender: TObject);
begin
  inherited;
  SetFocus;
end;

procedure TFFileStructure.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFFileStructure.Clear(Form: TFileForm);
begin
  if assigned(myForm) and (Form.Pathname = myForm.Pathname) then begin
    vilFileStructure.Clear;
    myForm:= nil;
  end;
end;

procedure TFFileStructure.FormDestroy(Sender: TObject);
begin
  vilFileStructure.Clear;
end;

procedure TFFileStructure.Init(items: TTreeNodes; Form: TFileForm);

  function addNode(Node: TTreeNode; Anchor: PVirtualNode): PVirtualNode;
    var Data: PMyRec;
  begin
    Result:= vilFileStructure.AddChild(Anchor);
    Data:= vilFileStructure.GetNodeData(Result);
    Data.LineNumber:= TInteger(Node.Data).i;
    Data.ImageIndex:= Node.ImageIndex;
    Data.Caption:= Node.Text;
    vilFileStructure.ValidateNode(Result, False);
  end;

  procedure AddClasses(ClassNode: TTreeNode; Anchor: PVirtualNode);
    var Node: TTreeNode; vilClassNode: PVirtualNode;
  begin
    while assigned(ClassNode) do begin
      vilClassNode:= addNode(ClassNode, Anchor);
      Node:= ClassNode.getFirstChild;
      while assigned(Node) do begin
        if Node.ImageIndex = 0 // is node an inner class
          then AddClasses(Node, vilClassNode)
          else addNode(Node, vilClassNode);
        Node:= Node.getNextSibling;
      end;
      ClassNode:= ClassNode.getNextSibling;
    end;
  end;

begin
  myForm:= Form;
  if DifferentItems(Items) then begin
    vilFileStructure.BeginUpdate;
    vilFileStructure.Clear;
    AddClasses(Items.GetFirstNode, vilFileStructure.RootNode);
    vilFileStructure.EndUpdate;
    vilFileStructure.FullExpand;
  end;
end;

procedure TFFileStructure.vilFileStructureFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
  var Data: PMyRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFFileStructure.vilFileStructureGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
  var Data: PMyRec;
begin
  if Kind in [ikNormal, ikSelected] then begin
    Data := Sender.GetNodeData(Node);
    ImageIndex:= Data.ImageIndex;
  end else
    ImageIndex:= -1;
end;

procedure TFFileStructure.vilFileStructureGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
  var Data: PMyRec;
begin
  if TextType = ttNormal then begin
    Data := Sender.GetNodeData(Node);
    Celltext:= Data.Caption;
  end;
end;

procedure TFFileStructure.vilFileStructureMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PMFileStructure.Popup(X + (Sender as TVirtualStringTree).ClientOrigin.X - 40,
                          Y + (Sender as TVirtualStringTree).ClientOrigin.Y - 5);
end;

function TFFileStructure.DifferentItems(Items: TTreeNodes): boolean;
  var i: integer; Data: PMyRec;
begin
  if vilFileStructure.TotalCount <> Cardinal(Items.Count) then
    Exit(true);
  i:= -1;
  for var Node in vilFileStructure.Nodes() do begin
    inc(i);
    Data := vilFileStructure.GetNodeData(Node);
    if Data.Caption <> Items[i].Text then
      Exit(true);
  end;
  Result:= false;
end;

procedure TFFileStructure.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  var CurrentSize:= Font.Size;
  Font.Size:= PPIUnScale(Font.Size);
  AppStorage.WritePersistent(BasePath+'\Font', Font);
  Font.Size:= CurrentSize;
end;

procedure TFFileStructure.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  AppStorage.ReadPersistent(BasePath + '\Font', Font);
  vilFilestructure.Font.Size:= PPIScale(Font.Size);
end;

procedure TFFileStructure.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(vilFilestructure.Font);
  if ResourcesDataModule.dlgFontDialog.Execute then
    vilFilestructure.Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
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
  var Data: PMyRec;
begin
  if locked then begin
    locked:= false;
    exit;
  end;
  var Node:= vilFileStructure.GetFirstSelected();
  if Node = nil then
    Exit;
  NavigateToVilNode(Node);

  Data := vilFileStructure.GetNodeData(Node);
  var attri:= Data.Caption;
  Delete(attri, 1, Pos(' ', attri));
  if (Pos('(', attri) = 0) and assigned(FGuiDesigner.ELDesigner) then // methods can't be selected
    FGuiDesigner.ELDesigner.SelectControl(attri);
end;

procedure TFFileStructure.vilFileStructureKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Char(VK_Return) then
    NavigateToVilNode(vilFileStructure.GetFirstSelected());
end;

procedure TFFileStructure.ShowEditorCodeElement(Line: integer);
  var Data: PMyRec; Node, FoundNode: PVirtualNode;
begin
  FoundNode:= nil;
  for Node in vilFileStructure.Nodes() do begin
    Data := vilFileStructure.GetNodeData(Node);
    if Data.LineNumber = Line then begin
      FoundNode:= Node;
      break;
    end else if Data.ImageIndex in [1..3] then
      continue
    else if Data.LineNumber > Line then
      break
    else
      FoundNode:= Node;
  end;
  if Assigned(FoundNode) then
    vilFileStructure.Selected[FoundNode]:= true;
end;

procedure TFFileStructure.NavigateToVilNode(Node: PVirtualNode;
            ForceToMiddle : Boolean = True; Activate : Boolean = True);
var
  i, aNodeLine: integer;
  Line, aClassname, aNodeText: string;
  EditForm: TEditorForm;
  aEditor: IEditor;
  isWrapping: boolean;
  Files: TStringList;
  Data: PMyRec;

  function BufferCoord(AChar, ALine: Integer): TBufferCoord;
  begin
    Result.Char := AChar;
    Result.Line := ALine;
  end;

begin
  if Node = nil then exit;
  Data:= vilFileStructure.GetNodeData(Node);
  aNodeLine:= Data.LineNumber;
  aNodeText:= Data.Caption;
  EditForm:= nil;
  isWrapping:= false;

  if Assigned(myForm) then begin
    if myForm.fFile.GetFileKind = fkEditor then
      EditForm:= myForm as TEditorForm
    else if myForm.fFile.GetFileKind = fkUML then begin
      locked:= true;
      Files:= (myForm as TFUMLForm).MainModul.Model.ModelRoot.Files;
      while vilFileStructure.NodeParent[Node] <> nil do
        Node:= vilFileStructure.NodeParent[Node];
      Data:= vilFileStructure.GetNodeData(Node);
      aClassname:= WithoutGeneric(Data.Caption);
      i:= 0;
      while i < Files.Count do begin
        aEditor:= GI_EditorFactory.GetEditorByFileId(Files[i]);
        if assigned(aEditor) then begin
          EditForm:= aEditor.Form as TEditorForm;
          if Pos('class ' + aClassname, EditForm.ActiveSynEdit.Lines.Text) > 0 then
            break;
        end;
        inc(i);
      end;
    end;
    if assigned(EditForm) then begin
      isWrapping:= EditForm.ActiveSynEdit.WordWrap;
      with EditForm.ActiveSynEdit do begin
        // Changing TopLine/CaretXY calls indirect ShowSelected;
        if isWrapping then EditForm.TBWordWrapClick(nil);
        Line:= Lines[aNodeLine-1];
        LockShowSelected:= true;
        Topline:= aNodeLine;
        LockShowSelected:= false;
        CaretXY:= BufferCoord(max(1, Pos(aNodeText, Line)), aNodeLine);
        if isWrapping then EditForm.TBWordWrapClick(nil);
      end;
    end;
  end;
  if assigned(EditForm) then begin
    if Activate and CanActuallyFocus(EditForm.ActiveSynEdit) then
      EditForm.ActiveSynEdit.SetFocus;
    if isWrapping then
      EditForm.TBWordWrapClick(nil);
  end;
end;

procedure TFFileStructure.ChangeStyle;
begin
  if IsStyledWindowsColorDark
    then vilFileStructure.Images:= vilFileStructureDark
    else vilFileStructure.Images:= vilFileStructureLight;
end;

end.
