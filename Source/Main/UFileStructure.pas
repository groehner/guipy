unit UFileStructure;

interface

uses
  Windows, Messages, Math, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ComCtrls, Buttons, Menus, JvAppStorage,
  frmIDEDockWin, frmFile, System.ImageList, Vcl.ImgList, TB2Item, SpTBXItem;

type
  TInteger = class
  public
    i: integer;
    constructor create(aI: Integer);
  end;

  TFFileStructure = class(TIDEDockWindow, IJvAppStorageHandler)
    TVFileStructure: TTreeView;
    ILFileStructureDark: TImageList;
    ILFileStructureLight: TImageList;
    PMFileStructure: TSpTBXPopupMenu;
    MIClose: TSpTBXItem;
    MIDefaultLayout: TSpTBXItem;
    MIFont: TSpTBXItem;
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
    procedure SetFont(aFont: TFont);
    procedure ShowEditorCodeElement;
    procedure NavigateToNodeElement(Node: TTreeNode;
                ForceToMiddle : Boolean = True; Activate : Boolean = True);
    procedure ShowSelected;
    procedure ChangeStyle;
  end;

var
  FFileStructure: TFFileStructure;

implementation

{$R *.dfm}

uses frmPyIDEMAin, frmEditor, JvDockControlForm, dmCommands, uEditAppIntfs,
     JvGnugettext, SynEdit, uCommonFunctions,
     UUMLForm, UConfiguration, UUtils, UImages, UGUIDesigner;

constructor TInteger.create(aI: Integer);
begin
  inherited create;
  self.i:= aI;
end;

{--- TFFileStructure ----------------------------------------------------------}

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
  inherited;
  Action:= caHide;
end;

procedure TFFileStructure.FormDestroy(Sender: TObject);
begin
  Clear;
end;

procedure TFFileStructure.Init(items: TTreeNodes; Form: TFileForm);
begin
  myForm:= Form;
  if DifferentItems(Items) then begin
    // Lock.Acquire;
    TVFileStructure.Items.BeginUpdate;
    TVFileStructure.Items.Clear;
    TVFileStructure.Items.Assign(Items);
    TVFileStructure.FullExpand;
    TVFileStructure.HideSelection:= false;
    TVFileStructure.Items.EndUpdate;
    // Lock.Release;
  end;
end;

function TFFileStructure.DifferentItems(Items: TTreeNodes): boolean;
  var i: integer;

  function DifferentNodes(Node1, Node2: TTreeNode): boolean;
  begin
    Result:= (Node1.Text <> Node2.Text) or
             (TInteger(Node1.Data).i <> TInteger(Node2.Data).i);
  end;

begin
  if TVFileStructure.Items.Count <> Items.Count then
    Exit(true);
  for i:= 0 to TVFileStructure.Items.Count - 1 do
    if DifferentNodes(TVFileStructure.Items[i], Items[i]) then
      Exit(true);
  Result:= false;
end;

procedure TFFileStructure.Clear;
begin
  if assigned(TVFileStructure) then begin
    TVFileStructure.Items.BeginUpdate;
    TVFileStructure.Items.Clear;
    TVFileStructure.Items.EndUpdate;
  end;
end;

procedure TFFileStructure.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WritePersistent(BasePath+'\Font', Font);
end;

procedure TFFileStructure.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  AppStorage.ReadPersistent(BasePath + '\Font', Font);
end;

procedure TFFileStructure.MIFontClick(Sender: TObject);
  var aFont: TFont;
begin
  CommandsDataModule.dlgFontDialog.Font.Assign(Font);
  if CommandsDataModule.dlgFontDialog.Execute then begin
    aFont:= CommandsDataModule.dlgFontDialog.Font;
    SetFont(aFont);
  end;
end;

procedure TFFileStructure.MIDefaulLayoutClick(Sender: TObject);
begin
  pyIDEMainForm.mnViewDefaultLayoutClick(Self);
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
  if Activate and CanActuallyFocus(EditForm.ActiveSynEdit) then
    EditForm.ActiveSynEdit.SetFocus;
  if isWrapping then
    EditForm.TBWordWrapClick(nil);
end;

procedure TFFileStructure.TVFileStructureMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PMFileStructure.Popup(X+(Sender as TTreeView).ClientOrigin.X-40, Y+(Sender as TTreeView).ClientOrigin.Y-5);
end;

procedure TFFileStructure.SetFont(aFont: TFont);
begin
  Font.Assign(aFont);
end;

procedure TFFileStructure.ChangeStyle;
begin
  if IsStyledWindowsColorDark
    then TVFileStructure.Images:= ILFileStructureDark
    else TVFileStructure.Images:= ILFileStructureLight;
end;

procedure TFFileStructure.ShowSelected;
begin
  if assigned(TVFileStructure.Selected) and not LockShowSelected then begin
    LockWindow(Self.Handle);
    TVFileStructure.Selected.MakeVisible;
    SendMessage(TVFileStructure.Handle, WM_HSCROLL, SB_PAGELEFT, 0);
    UnlockWindow;
  end;
end;

end.
