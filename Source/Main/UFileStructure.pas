unit UFileStructure;

interface

uses
  System.Classes, System.ImageList, Vcl.ImgList,  Vcl.Menus, Controls, Forms,
  ComCtrls, JvAppStorage,
  frmIDEDockWin, frmFile, TB2Item, SpTBXItem, Vcl.ExtCtrls;

type
  TInteger = class
  public
    i: integer;
    constructor create(aI: Integer);
  end;

  TFFileStructure = class(TIDEDockWindow, IJvAppStorageHandler)
    TVFileStructure: TTreeView;
    PMFileStructure: TSpTBXPopupMenu;
    MIClose: TSpTBXItem;
    MIDefaultLayout: TSpTBXItem;
    MIFont: TSpTBXItem;
    ILFileStructureLight: TImageList;
    ILFileStructureDark: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure MIFontClick(Sender: TObject);
    procedure MIDefaulLayoutClick(Sender: TObject);
    procedure MICloseClick(Sender: TObject);
    procedure TVFileStructureClick(Sender: TObject);
    procedure TVFileStructureMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVFileStructureKeyPress(Sender: TObject; var Key: Char);
  private
    locked: boolean;
    LockShowSelected: boolean;
    function DifferentItems(Items: TTreeNodes): boolean;
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    myForm: TFileForm;
    procedure Init(Items: TTreeNodes; Form: TFileForm);
    procedure Clear;
    procedure ShowEditorCodeElement;
    procedure NavigateToNodeElement(Node: TTreeNode;
                ForceToMiddle : Boolean = True; Activate : Boolean = True);
    procedure ShowSelected;
    procedure ChangeStyle;
   // procedure StoreSettings(AppStorage: TJvCustomAppStorage); override;  ??
   // procedure RestoreSettings(AppStorage: TJvCustomAppStorage); override;
  end;

var
  FFileStructure: TFFileStructure;

implementation

{$R *.dfm}

uses Math, Windows, Messages, SysUtils, Graphics, Dialogs,
     frmPyIDEMAin, frmEditor, JvDockControlForm, dmResources, uEditAppIntfs,
     JvGnugettext, SynEdit, uCommonFunctions,
     UUMLForm, UUtils, UImages, UGUIDesigner;

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
  myForm:= nil;
  TranslateComponent(Self);
  ChangeStyle;
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

procedure TFFileStructure.FormDestroy(Sender: TObject);
begin
  Clear;
end;

procedure TFFileStructure.Init(items: TTreeNodes; Form: TFileForm);
  var i: Integer;
begin
  myForm:= Form;
  if DifferentItems(Items) then begin
    TVFileStructure.Items.BeginUpdate;
    for i:= 0 to TVFileStructure.Items.Count - 1 do
      FreeAndNil(TVFileStructure.Items[i].Data);
    TVFileStructure.Items.Clear;
    TVFileStructure.Items.Assign(Items);
    for i:= 0 to TVFileStructure.Items.Count - 1 do
      TVFileStructure.Items[i].Data:= TInteger.create(TInteger(Items[i].Data).i);
    TVFileStructure.FullExpand;
    TVFileStructure.HideSelection:= false;
    TVFileStructure.Items.EndUpdate;
    Form.SetFocus;
  end;
end;

function TFFileStructure.DifferentItems(Items: TTreeNodes): boolean;
  var i: integer;
begin
  if TVFileStructure.Items.Count <> Items.Count then
    Exit(true);
  for i:= 0 to TVFileStructure.Items.Count - 1 do
    if TVFileStructure.Items[i].Text <> Items[i].Text then
      Exit(true);
  for i:= 0 to TVFileStructure.Items.Count - 1 do
    TInteger(TVFileStructure.Items[i].Data).i:=
      TInteger(Items[i].Data).i;
  Result:= false;
end;

procedure TFFileStructure.Clear;
begin
  if assigned(TVFileStructure) then begin
    TVFileStructure.Items.BeginUpdate;
    for var i:= TVFileStructure.Items.Count - 1 downto 0 do
      FreeAndNil(TVFileStructure.Items[i].Data);
    TVFileStructure.Items.Clear;
    TVFileStructure.Items.EndUpdate;
  end;
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
  TVFilestructure.Font.Size:= PPIScale(Font.Size);
end;

procedure TFFileStructure.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(TVFilestructure.Font);
  if ResourcesDataModule.dlgFontDialog.Execute then
    TVFilestructure.Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
end;

procedure TFFileStructure.MIDefaulLayoutClick(Sender: TObject);
begin
  PyIDEMainForm.mnViewDefaultLayoutClick(Self);
end;

procedure TFFileStructure.MICloseClick(Sender: TObject);
begin
  HideDockForm(Self);
end;

procedure TFFileStructure.TVFileStructureClick(Sender: TObject);
  var attri: string;
      Node: TTreeNode;
begin
  if locked then begin
    locked:= false;
    exit;
  end;
  with TVFileStructure.ScreenToClient(Mouse.CursorPos) do
    Node := TVFileStructure.GetNodeAt(X, Y);
  if Node = nil then
    Exit;
  NavigateToNodeElement(TVFileStructure.Selected);
  SendMessage(TVFileStructure.Handle, WM_HSCROLL, SB_PAGELEFT, 0);
  Delete(attri, 1, Pos(' ', attri));

  if (Pos('(', attri) = 0) and assigned(FGuiDesigner.ELDesigner) then // methods can't be selected
    FGuiDesigner.ELDesigner.SelectControl(attri);
end;

procedure TFFileStructure.TVFileStructureKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Char(VK_Return) then
    NavigateToNodeElement(TVFileStructure.Selected);
end;

procedure TFFileStructure.ShowEditorCodeElement;
  var Line, i, Nr, PrevIndex: integer; aInteger: TInteger;
begin
  PrevIndex:= 0;
  if Assigned(myForm) and (myForm is TEditorForm) then begin
    Line:= (myForm as TEditorForm).ActiveSynEdit.CaretY;
    Nr:= -1;
    for i:= 0 to TVFileStructure.Items.Count - 1 do begin
      aInteger:= TInteger(TVFileStructure.Items[i].Data);
      if aInteger.i = Line then
        Nr:= i
      else if TVFileStructure.Items[i].ImageIndex in [2..5] then
        continue
      else if aInteger.i > Line then
        Nr:= PrevIndex
      else
        PrevIndex:= i;
      if Nr > - 1 then
        break;
    end;
    if Nr = -1 then
      Nr:= TVFileStructure.Items.Count - 1;
    if (Nr > -1) and (Nr < TVFileStructure.Items.Count) and
      not TVFileStructure.Items[Nr].Selected then
        TVFileStructure.Items[Nr].Selected:= true;
    ShowSelected;
  end;
end;

procedure TFFileStructure.NavigateToNodeElement(Node: TTreeNode;
            ForceToMiddle : Boolean = True; Activate : Boolean = True);
var
  i, aNodeLine: integer;
  Line, aClassname, aNodeText: string;
  EditForm: TEditorForm;
  aEditor: IEditor;
  isWrapping: boolean;
  Files: TStringList;

  function BufferCoord(AChar, ALine: Integer): TBufferCoord;
  begin
    Result.Char := AChar;
    Result.Line := ALine;
  end;

begin
  EditForm:= nil;
  isWrapping:= false;
  if Assigned(Node) then begin
    aNodeLine:= TInteger(Node.Data).i;
    aNodeText:= Node.Text;
  end else
    exit;

  if Assigned(myForm) then begin
    if myForm.fFile.GetFileKind = fkEditor then
      EditForm:= myForm as TEditorForm
    else if myForm.fFile.GetFileKind = fkUML then begin
      locked:= true;
      Files:= (myForm as TFUMLForm).MainModul.Model.ModelRoot.Files;
      while Node.Parent <> nil do
        Node:= Node.Parent;
      aClassname:= WithoutGeneric(Node.Text);
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

procedure TFFileStructure.TVFileStructureMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PMFileStructure.Popup(X+(Sender as TTreeView).ClientOrigin.X-40, Y+(Sender as TTreeView).ClientOrigin.Y-5);
end;

procedure TFFileStructure.ChangeStyle;
begin
  if IsStyledWindowsColorDark
    then TVFileStructure.Images:= ILFileStructureDark
    else TVFileStructure.Images:= ILFileStructureLight;
end;

procedure TFFileStructure.ShowSelected;
begin
  if assigned(TVFileStructure.Selected) and not TVFileStructure.Selected.isVisible
    and not LockShowSelected
  then begin
    LockFormUpdate(Self);
    TVFileStructure.Selected.MakeVisible;
    SendMessage(TVFileStructure.Handle, WM_HSCROLL, SB_PAGELEFT, 0);
    UnLockFormUpdate(Self);
  end;
end;

end.
