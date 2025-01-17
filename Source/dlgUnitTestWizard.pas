{-----------------------------------------------------------------------------
 Unit Name: dlgUnitTestWizard
 Author:    Kiriakos Vlahos
 Date:      09-Feb-2006
 Purpose:   Unit Test Wizard
 History:
-----------------------------------------------------------------------------}
unit dlgUnitTestWizard;

interface

uses
  System.UITypes,
  System.Classes,
  System.ImageList,
  System.JSON,
  Vcl.Controls,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  TB2Item,
  SpTBXItem,
  VirtualTrees.Types,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.AncestorVCL,
  VirtualTrees.BaseTree,
  VirtualTrees,
  dlgPyIDEBase;

type

  TUnitTestWizard = class(TPyIDEDlgBase)
    Panel1: TPanel;
    ExplorerTree: TVirtualStringTree;
    Bevel1: TBevel;
    PopupUnitTestWizard: TSpTBXPopupMenu;
    mnSelectAll: TSpTBXItem;
    mnDeselectAll: TSpTBXItem;
    Label1: TLabel;
    lbHeader: TLabel;
    lbFileName: TLabel;
    OKButton: TButton;
    BitBtn2: TButton;
    HelpButton: TButton;
    vilCodeImages: TVirtualImageList;
    vilImages: TVirtualImageList;
    procedure HelpButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExplorerTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure ExplorerTreeInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure ExplorerTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVstTextType; var CellText: string);
    procedure ExplorerTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure ExplorerTreeGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: string);
    procedure mnSelectAllClick(Sender: TObject);
    procedure mnDeselectAllClick(Sender: TObject);
  private
    Symbols : TJSONArray;
    FModuleName: string;
    FModuleFileName: string;
    function SymbolHint(Symbol: TJSONObject): string;
    function SymbolSignature(Symbol: TJSONObject): string;
  public
    class function GenerateTests(const ModuleFName: string) : string;
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Forms,
  JvJVCLUtils,
  JvGnugettext,
  dmResources,
  uCommonFunctions,
  SynEditTypes,
  LspUtils,
  JediLspClient;

{$R *.dfm}

procedure Prune(Symbols: TJSONArray; ModuleFileName: string);

  function IsImported(Symbol: TJSONValue; Kind: Integer): Boolean;
  var
    Line: Integer;
  begin
    Result := Symbol.TryGetValue<Integer>('selectionRange.start.line', Line);
    if Result then
    begin
      var LineSource := GetNthSourceLine(ModuleFileName, Line + 1).TrimLeft;
      Result := LineSource.StartsWith('from') or
        ((Kind = Ord(TSymbolKind._Function)) and not LineSource.StartsWith('def'));
    end;
  end;

  function PruneChildren(Symbol: TJSONValue; IsClass: Boolean): Boolean;
  var
    Kind: Integer;
  begin
    Result := False;
    var Children := Symbol.FindValue('children');
    if Assigned(Children) and (Children is TJSONArray) then
    begin
      var Arr := TJSONArray(Children);
      for var I := Arr.Count - 1 downto 0 do
      begin
         var Val := Arr[I];
         if not IsClass or not Val.TryGetValue<Integer>('kind', Kind) or not
           (Kind = Ord(TSymbolKind.Method))
         then
           Arr.Remove(I).Free;
      end;
      Result := IsClass and (Arr.Count = 0);
    end;
  end;

var
  Kind: Integer;
begin
  for var I := Symbols.Count -1 downto 0 do
  begin
     var Value := Symbols[I];
     if not Value.TryGetValue<Integer>('kind', Kind) or
       not (Kind in [Ord(TSymbolKind._Class), Ord(TSymbolKind._Function)]) or
       IsImported(Value, Kind) or
       PruneChildren(Value, Kind = Ord(TSymbolKind._Class))
     then
       Symbols.Remove(I).Free;
  end;
end;

class function TUnitTestWizard.GenerateTests(const ModuleFName: string) : string;

const
  Header = '#This file was originally generated by PyScripter''s unit test wizard' +
    sLineBreak + sLineBreak + 'import unittest'+ sLineBreak + 'import %s'
    + sLineBreak + sLineBreak;

   ClassHeader =
      'class Test%s(unittest.TestCase):'+ sLineBreak + sLineBreak +
      '    def setUp(self): ' + sLineBreak +
      '        pass' + sLineBreak + sLineBreak +
      '    def tearDown(self): ' + sLineBreak +
      '        pass' + sLineBreak + sLineBreak;

    MethodHeader =
        '    def test%s(self):' + sLineBreak +
        '        pass' + sLineBreak + sLineBreak;

     Footer =
      'if __name__ == ''__main__'':' + sLineBreak +
      '    unittest.main()' + sLineBreak;

var
  LSymbols : TJSONArray;
  Node, MethodNode: PVirtualNode;
  Symbol, MSymbol: TJSONObject;
  SName, MName: string;
  FunctionTests : string;
begin
  Result := '';
  FunctionTests := '';

  LSymbols := TJedi.DocumentSymbols(ModuleFName);
  if not Assigned(LSymbols) then Exit;
  Prune(LSymbols, ModuleFName);
  if LSymbols.Count = 0 then
  begin
    LSymbols.Free;
    Exit;
  end;

  with TUnitTestWizard.Create(Application) do
  begin
    lbFileName.Caption := ModuleFName;
    Symbols := LSymbols;
    FModuleFileName := ModuleFName;
    FModuleName := FileNameToModuleName(ModuleFName);
    // Turn off Animation to speed things up
    ExplorerTree.TreeOptions.AnimationOptions :=
      ExplorerTree.TreeOptions.AnimationOptions - [toAnimatedToggle];
    ExplorerTree.RootNodeCount := 1;
    ExplorerTree.ReinitNode(ExplorerTree.RootNode, True);
    ExplorerTree.TreeOptions.AnimationOptions :=
      ExplorerTree.TreeOptions.AnimationOptions + [toAnimatedToggle];
    if ShowModal = idOK then begin
      Application.ProcessMessages;
      // Generate code
      Result := Format(Header, [FModuleName]);
      Node := ExplorerTree.RootNode^.FirstChild^.FirstChild;
      while Assigned(Node) do begin
        Symbol := Node.GetData<TJSONObject>;
        Symbol.TryGetValue<string>('name', SName);
        if (Node.CheckState in [csCheckedNormal, csCheckedPressed,
          csMixedNormal, csMixedPressed]) then
        begin
          if Node.ChildCount > 0 then begin
            // Class Symbol
            Result := Result + Format(ClassHeader, [SName]);
            MethodNode := Node.FirstChild;
            while Assigned(MethodNode) do begin
              if (MethodNode.CheckState in [csCheckedNormal, csCheckedPressed]) then begin
                MSymbol := MethodNode.GetData<TJSONObject>;
                MSymbol.TryGetValue<string>('name', MName);
                Result := Result + Format(MethodHeader, [MName]);
              end;
              MethodNode := MethodNode.NextSibling;
            end;
          end
          else
          begin
            if FunctionTests = '' then
              FunctionTests := Format(ClassHeader, ['GlobalFunctions']);
            FunctionTests := FunctionTests + Format(MethodHeader, [SName]);
          end;
        end;
        Node := Node.NextSibling;
      end;
      if FunctionTests <> '' then
        Result := Result + FunctionTests;
      Result := Result + Footer;
    end;
    Release;
    Symbols.Free;
  end;
end;

procedure TUnitTestWizard.ExplorerTreeGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
begin
  case ExplorerTree.GetNodeLevel(Node) of
    0:  HintText := Format(_('Python Module "%s"'), [FModuleName]);
    1, 2:
      begin
        var Symbol := Node.GetData<TJSONObject>;
        HintText := SymbolHint(Symbol);
      end;
    else
      raise Exception.Create('TUnitTestWizard.ExplorerTreeGetHint');
  end;
end;

procedure TUnitTestWizard.ExplorerTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if Kind in [ikNormal, ikSelected] then
    case ExplorerTree.GetNodeLevel(Node) of
      0: ImageIndex := Integer(TCodeImages.Python);
      1: if Node.ChildCount = 0 then
           ImageIndex := Integer(TCodeImages.Func)
         else
           ImageIndex := Integer(TCodeImages.Klass);
      2: ImageIndex := Integer(TCodeImages.Method);
      else
        raise Exception.Create('TUnitTestWizard.ExplorerTreeGetImageIndex');
    end;
end;

procedure TUnitTestWizard.ExplorerTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVstTextType;
  var CellText: string);
begin
  if TextType = ttNormal then
    case ExplorerTree.GetNodeLevel(Node) of
      0:  CellText := FModuleName;
      1:  begin
            var Symbol := Node.GetData<TJSONObject>;
            if Node.ChildCount = 0 then
              CellText := SymbolSignature(Symbol)
            else
              Symbol.TryGetValue<string>('name', CellText);
          end;
      2:  begin
            var Symbol := Node.GetData<TJSONObject>;
            CellText := SymbolSignature(Symbol);
          end;
      else
        raise Exception.Create('TUnitTestWizard.ExplorerTreeGetText');
    end;
end;

procedure TUnitTestWizard.ExplorerTreeInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
begin
  case ExplorerTree.GetNodeLevel(Node) of
    0: ChildCount := Symbols.Count;
    1:
       begin
         ChildCount := 0;
         var Value := Node.GetData<TJSONObject>;
         var Children := Value.FindValue('children');
         if Children is TJSONArray then
           ChildCount := TJSONArray(Children).Count;
       end;
    2: ChildCount := 0;
    else
      raise Exception.Create('TUnitTestWizard.ExplorerTreeInitChildren');
  end;
end;

procedure TUnitTestWizard.ExplorerTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Name: string;
  Kind: Integer;
begin
  Node.CheckState := csCheckedNormal;
  Node.CheckType := ctCheckBox;
  case ExplorerTree.GetNodeLevel(Node) of
    0:
       begin
         InitialStates := [ivsHasChildren, ivsExpanded];
         Node.SetData<TJSONValue>(Symbols);
         Node.CheckType := ctTriStateCheckBox;
       end;
    1:
       begin
         var Child := Symbols[Node.Index];
         Node.SetData<TJSONValue>(Child);
         if Child.TryGetValue<Integer>('kind', Kind) and
           (Kind = Ord(TSymbolKind._Class)) then
         begin
           InitialStates := [ivsHasChildren, ivsExpanded];
           Node.CheckType := ctTriStateCheckBox;
         end;
       end;
    2:
      begin
        var Klass := ParentNode.GetData<TJSONObject>;
        var Children := Klass.FindValue('children');
        var Method := TJSONArray(Children).Items[Node.Index];
        Assert(Assigned(Children) and (Children is TJSONArray));
        Node.SetData<TJSONValue>(Method);
        if Method.TryGetValue<string>('name', Name) and (Name = '__init__') then
          Node.CheckState := csUncheckedNormal;
      end;
    else
      raise Exception.Create('TUnitTestWizard.ExplorerTreeInitNode');
  end;
end;

procedure TUnitTestWizard.FormCreate(Sender: TObject);
begin
  inherited;
  ExplorerTree.NodeDataSize := SizeOf(Pointer);
end;

procedure TUnitTestWizard.HelpButtonClick(Sender: TObject);
begin
  if HelpContext <> 0 then
    Application.HelpContext(HelpContext);
end;

procedure TUnitTestWizard.mnDeselectAllClick(Sender: TObject);
var
  Node : PVirtualNode;
begin
   Node := ExplorerTree.RootNode^.FirstChild;
   while Assigned(Node) do begin
     ExplorerTree.CheckState[Node] := csUncheckedNormal;
     Node := Node.NextSibling;
   end;
end;

procedure TUnitTestWizard.mnSelectAllClick(Sender: TObject);
var
  Node : PVirtualNode;
begin
   Node := ExplorerTree.RootNode^.FirstChild;
   while Assigned(Node) do begin
     ExplorerTree.CheckState[Node] := csCheckedNormal;
     Node := Node.NextSibling;
   end;
end;

function TUnitTestWizard.SymbolHint(Symbol: TJSONObject): string;
var
  BC: TBufferCoord;
begin
  if Symbol.TryGetValue<Integer>('selectionRange.start.line', BC.Line) and
    Symbol.TryGetValue<Integer>('selectionRange.start.character', BC.Char)
  then
  begin
    Inc(BC.Line);
    Inc(BC.Char);
    Result := TJedi.SimpleHintAtCoordinates(FModuleFileName, BC);
  end;
end;

function TUnitTestWizard.SymbolSignature(Symbol: TJSONObject): string;
var
  Line: Integer;
begin
  Result := '';
  if Symbol.TryGetValue<Integer>('selectionRange.start.line', Line) then
  begin
    Result := Trim(GetNthSourceLine(FModuleFileName, Line + 1));
    var Index := Result.LastIndexOf(':');
    if Index >= 0 then
      Delete(Result, Index + 1, MaxInt);
    if Result.StartsWith('def') then
      Delete(Result, 1, 3);
    Result := Result.TrimLeft;
  end;
end;

end.
