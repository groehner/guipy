unit UClassEditor;

interface

uses
  Windows, Messages, Actions, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ComCtrls, ImgList, ExtCtrls, IniFiles, Buttons,
  ActnList, System.ImageList, JvAppStorage, dlgPyIDEBase,
  UModel, UUMLForm, frmEditor;

type
  TFClassEditor = class(TPyIDEDlgBase, IJvAppStorageHandler)
    LClass: TLabel;
    TreeView: TTreeView;
    PageControl: TPageControl;
    TSClass: TTabSheet;
    TSAttributes: TTabSheet;
    TSMethods: TTabSheet;
    LClassName: TLabel;
    EClass: TEdit;
    LAttributeName: TLabel;
    LAttributeType: TLabel;
    RGAttributeAccess: TRadioGroup;
    CBAttributeType: TComboBox;
    BAttributeDelete: TButton;
    BAttributeNew: TButton;
    GBAttributeOptions: TGroupBox;
    CBsetMethod: TCheckBox;
    CBgetMethod: TCheckBox;
    CBAttributeStatic: TCheckBox;
    EAttributeName: TEdit;
    LAttributeValue: TLabel;
    LMethodName: TLabel;
    LMethodType: TLabel;
    CBMethodType: TComboBox;
    RGMethodAccess: TRadioGroup;
    GBMethodOptions: TGroupBox;
    CBMethodStatic: TCheckBox;
    CBMethodClass: TCheckBox;
    BMethodNew: TButton;
    BMethodDelete: TButton;
    CBMethodAbstract: TCheckBox;
    RGMethodKind: TRadioGroup;
    GRFormalParameters: TGroupBox;
    LParameterName: TLabel;
    LParameterType: TLabel;
    CBParamType: TComboBox;
    BParameterNew: TButton;
    LBParams: TListBox;
    BMethodClose: TButton;
    BAttributeClose: TButton;
    BClassClose: TButton;
    LExtends: TLabel;
    EExtends: TEdit;
    CBMethodName: TComboBox;
    CBParamName: TComboBox;
    CBParameter: TComboBox;
    CBAttributeFinal: TCheckBox;
    SBUp: TSpeedButton;
    SBDelete: TSpeedButton;
    SBDown: TSpeedButton;
    SBRight: TSpeedButton;
    SBLeft: TSpeedButton;
    BParameterDelete: TButton;
    Timer1: TTimer;
    ActionList: TActionList;
    ActionNew: TAction;
    ActionDelete: TAction;
    ActionClose: TAction;
    ActionApply: TAction;
    BAttributeApply: TButton;
    BMethodApply: TButton;
    BClassApply: TButton;
    ILSpeedButton: TImageList;
    BClassNew: TButton;
    CBClassInner: TCheckBox;
    CBAttributeValue: TComboBox;
    LParameterValue: TLabel;
    CBParamValue: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var aAction: TCloseAction);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure PageControlChange(Sender: TObject);

    procedure BClassChangeClick(Sender: TObject);
    procedure BAttributeChangeClick(Sender: TObject);
    procedure BAttributeDeleteClick(Sender: TObject);

    procedure BMethodChangeClick(Sender: TObject);
    procedure BMethodDeleteClick(Sender: TObject);

    procedure BParameterNewClick(Sender: TObject);
    procedure LBParamsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBParamNameSelect(Sender: TObject);
    procedure CBParameterSelect(Sender: TObject);
    procedure CBAttributeTypeKeyPress(Sender: TObject; var Key: Char);
    procedure CBAttributeTypeSelect(Sender: TObject);
    procedure SBUpClick(Sender: TObject);
    procedure SBDownClick(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure SBRightClick(Sender: TObject);
    procedure SBLeftClick(Sender: TObject);
    procedure BParameterDeleteClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ComboBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBParamTypeKeyPress(Sender: TObject; var Key: Char);
    procedure CBParameterKeyPress(Sender: TObject; var Key: Char);
    procedure CBParamTypeSelect(Sender: TObject);
    procedure CBParamNameKeyPress(Sender: TObject; var Key: Char);
    procedure CBMethodTypeKeyPress(Sender: TObject; var Key: Char);
    procedure CBMethodTypeSelect(Sender: TObject);
    procedure CBMethodnameSelect(Sender: TObject);
    procedure ActionApplyExecute(Sender: TObject);
    procedure ActionNewExecute(Sender: TObject);
    procedure ActionListUpdate(aAction: TBasicAction; var Handled: Boolean);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure CBAttributeTypeDropDown(Sender: TObject);
    procedure CBMethodTypeDropDown(Sender: TObject);
    procedure CBParamTypeDropDown(Sender: TObject);
    procedure ComboBoxCloseUp(Sender: TObject);

    procedure EAttributeNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBMethodnameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBParamNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBAttributeTypeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBMethodParamTypeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EClassKeyPress(Sender: TObject; var Key: Char);
    procedure CBMethodnameKeyPress(Sender: TObject; var Key: Char);
    procedure EAttributeNameKeyPress(Sender: TObject; var Key: Char);
    procedure CBClassAbstractMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CBClassAbstractClick(Sender: TObject);
    procedure CBAttributeValueKeyPress(Sender: TObject; var Key: Char);
    procedure CBAttributeValueDropDown(Sender: TObject);
    procedure CBAttributeValueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBAttributeValueSelect(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure CBComboBoxEnter(Sender: TObject);
  private
    myEditor: TEditorForm;
    myUMLForm: TFUMLForm;
    IsClass: Boolean;
    ComboBoxInvalid: Boolean;
    MakeNewClass: Boolean;
    LNGTODO: string;
    LNGSet: string;
    LNGGet: string;
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    AttributeNode: TTreeNode;
    MethodNode: TTreeNode;
    function CreateTreeView(Editor: TEditorForm; UMLForm: TFUMLForm): Boolean;
    procedure UpdateTreeView;
    procedure AttributeToPython(Attribute: TAttribute; ClassNumber, Line: Integer);
    function RGMethodKindChanged(ClassNumber: integer): boolean;
    procedure ShowMandatoryFields;
    procedure SetClassOrInterface(aIsClass: Boolean);
    procedure TVClassOrInterface(Classifier: TClassifier);
    procedure TVAttribute(Attribute: TAttribute);
    procedure TVMethod(Method: TOperation);
    procedure ChangeAttribute(var A: TAttribute);
    procedure ChangeGetSet(Attribut: TAttribute; ClassNumber: Integer);
    procedure NewClass;
    function GetAttrValue: string;
    function MakeAttribute: TAttribute;
    function MakeType(CB: TComboBox): TClassifier; overload;
    function MakeType(const s: string): TClassifier; overload;
    procedure GetParameter(LB: TListBox; Method: TOperation);

    function HasMethod(const getset: string; Attribute: TAttribute;
      var Method: TOperation): Boolean;
    function MethodToPython(Method: TOperation; Source: string): string;
    procedure DeleteMethod(Method: TOperation);
    procedure ChangeMethod(var M: TOperation);
    procedure ReplaceMethod(var Method: TOperation; const New: string);
    function MakeMethod(Level: integer): TOperation;
    function CreateMethod(const getset: string; Attribute: TAttribute): string;

    function makeConstructor(Method: TOperation; Source: string): string;
    function Typ2Value(const typ: string): string;
    procedure MoveNode(TargetNode, SourceNode: TTreeNode);
    procedure EnableEvents(enable: Boolean);
    procedure SetEditText(E: TEdit; const s: string);
    procedure SetComboBoxValue(CB: TComboBox; const s: string);
    function MakeIdentifier(var s: string): Integer; overload;
    function MakeIdentifier(E: TEdit): Boolean; overload;
    function MakeIdentifier(CB: TComboBox): Boolean; overload;
    function PartOfClass(Node: TTreeNode): Boolean;
    function GetClassNumber(Node: TTreeNode): Integer;
    function GetClassNode(ClassNumber: integer): TTreeNode;
    function GetNextClassNumber: String;
    function GetLastLineOflastClass: Integer;
    function GetClassInterfaceNode: TTreeNode;
    function GetAttributeNode: TTreeNode;
    function GetMethodNode: TTreeNode;
    function IsClassOrInterface(Node: TTreeNode): Boolean;
    function IsAttributesNodeLeaf(Node: TTreeNode): Boolean;
    function IsAttributesNode(Node: TTreeNode): Boolean;
    function IsMethodsNodeLeaf(Node: TTreeNode): Boolean;
    function IsMethodsNode(Node: TTreeNode): Boolean;
    function CountClassOrInterface: Integer;
    procedure AllAttributesAsParameters(Node: TTreeNode);
    function AttributeAlreadyExists(const s: string): Boolean;
    function MethodAlreadyExists(const s: string): Boolean;
    procedure Init;
    function NameTypeValueChanged: Boolean;
    procedure TakeParameter;
    function StrToPythonValue(s: String): String;
    procedure ChangeStyle;
    procedure PrepareNewClass;
  end;

var
  FClassEditor: TFClassEditor = nil;

implementation

{$R *.dfm}

uses Math, UITypes, SynEdit, JvGnugettext, StringResources, uCommonFunctions,
     UFileStructure, uModelEntity, uFileProvider, UConfiguration, UUtils,
     uEditAppIntfs, frmFile;

const
  CrLf = #13#10;

type
  TParamTyp = class(TObject)
  public
    typ: string;
    constructor create(const s: string);
  end;

constructor TParamTyp.create(const s: string);
begin
  typ := s;
end;

procedure TFClassEditor.FormCreate(Sender: TObject);
  const Values =  '0'#$D#$A'0.0'#$D#$A''''''#$D#$A'True'#$D#$A'False'#$D#$A'None'#$D#$A'[]'#$D#$A'()'#$D#$A'{}';
begin
  inherited;
  MakeNewClass := false;
  TreeView.Images := FFileStructure.ILFileStructureLight;
  CBAttributeValue.Items.Text:= Values;
  CBParamValue.Items.Text:= Values;
  LNGTODO:= _('# TODO add your code here');
  LNGSet:= _('set');
  LNGGet:= _('get');
  ChangeStyle;
end;

procedure TFClassEditor.FormShow(Sender: TObject);
var
  SL: TStringList;
  i: Integer;
  st: string;
begin
  Init;
  SL := TStringList.create;
  for i:= 0 to GI_FileFactory.Count - 1 do
    (GI_FileFactory.FactoryFile[i].Form as TFileForm).CollectClasses(SL);
  for i := 0 to SL.Count - 1 do begin
    st := getShortType(SL[i]);
    ComboBoxInsert2(CBAttributeType, st);
    ComboBoxInsert2(CBMethodType, st);
    ComboBoxInsert2(CBParamType, st);
  end;
  FreeAndNil(SL);

  if not GuiPyOptions.ShowGetSetMethods then begin
    CBGetMethod.Checked:= false;
    CBSetMethod.Checked:= false;
  end;
  CBGetMethod.Visible:= GuiPyOptions.ShowGetSetMethods;
  CBSetMethod.Visible:= GuiPyOptions.ShowGetSetMethods;
  CBAttributeType.Visible:= GuiPyOptions.ShowTypeSelection;
  LAttributeType.Visible:= GuiPyOptions.ShowTypeSelection;
  if GuiPyOptions.ShowKindProcedure
    then RGMethodKind.Items.Text:= _('Constructor') + #13#10 + _('Function') + #13#10 + _('Procedure')
    else RGMethodKind.Items.Text:= _('Constructor') + #13#10 + _('Function');
  CBParamType.Visible:= GuiPyOptions.ShowParameterTypeSelection;
  LParameterType.Visible:= GuiPyOptions.ShowParameterTypeSelection;
end;

procedure TFClassEditor.FormClose(Sender: TObject; var aAction: TCloseAction);
var
  i: Integer;
  aObject: TObject;
begin
  TreeView.OnChange := nil;
  TreeView.Items.Clear;
  for i := 0 to CBParamName.Items.Count - 1 do begin
    aObject := CBParamName.Items.Objects[i];
    FreeAndNil(aObject);
  end;
end;

procedure TFClassEditor.TVClassOrInterface(Classifier: TClassifier);
var
  Node, Anchor: TTreeNode;
  p: Integer;
  CName: string;

  function GetCorINode(s: string): TTreeNode;
  var
    Node: TTreeNode;
    s1: string;
    p: Integer;
  begin
    Result := nil;
    Node := TreeView.Items.GetFirstNode;
    p := Pos('.', s);
    s1 := copy(s, 1, p - 1);
    delete(s, 1, p);
    while s1 <> '' do begin
      while Assigned(Node) and (withoutGeneric(Node.Text) <> s1) do
        Node := Node.getNextSibling;
      if Node = nil then
        exit;
      Node := Node.getFirstChild;
      p := Pos('.', s);
      s1 := copy(s, 1, p - 1);
      delete(s, 1, p);
    end;
    Result := Node;
  end;

begin
  CName := Classifier.Name;
  p := LastDelimiter('.', CName);
  if p = 0 then
    Anchor := nil
  else begin
    Anchor := GetCorINode(copy(CName, 1, p));
    delete(CName, 1, p);
  end;

  Node := TreeView.Items.AddObject(Anchor, CName, Classifier);
  if Classifier is TClass then begin
    Node.ImageIndex := 1;
    Node.SelectedIndex := 1
  end else begin
    Node.ImageIndex := 11;
    Node.SelectedIndex := 11;
  end;

  AttributeNode := TreeView.Items.AddChild(Node, _('Attributes'));
  AttributeNode.ImageIndex := 12;
  AttributeNode.SelectedIndex := 12;

  MethodNode := TreeView.Items.AddChild(Node, _('Methods'));
  MethodNode.ImageIndex := 13;
  MethodNode.SelectedIndex := 13;

  ComboBoxInsert2(CBAttributeType, CName);
  ComboBoxInsert2(CBMethodType, CName);
  ComboBoxInsert2(CBParamType, CName);
end;

procedure TFClassEditor.TVAttribute(Attribute: TAttribute);
var
  Node: TTreeNode;
begin
  Node := TreeView.Items.AddChildObject(AttributeNode, Attribute.Name,
    Attribute);
  Node.ImageIndex := Integer(Attribute.Visibility) + 2;
  Node.SelectedIndex := Integer(Attribute.Visibility) + 2;
end;

procedure TFClassEditor.TVMethod(Method: TOperation);
var
  Node: TTreeNode;
  ImageNr: Integer;
begin
  Node := TreeView.Items.AddChildObject(MethodNode, Method.toShortStringNode, Method);
  if Method.OperationType = otConstructor
    then ImageNr := 6
    else ImageNr := Integer(Method.Visibility) + 7;
  Node.ImageIndex := ImageNr;
  Node.SelectedIndex := ImageNr;
end;

procedure TFClassEditor.NewClass;
var
  Indent1, Indent2, s: string;
  Line, p1, p2, p3, p4: Integer;
  SL: TStringList;
  i: Integer;
begin
  MakeNewClass := false;
  Indent1:= FConfiguration.Indent1;
  s:= FConfiguration.getClassCodeTemplate;
  p1:= Pos('class ', s);
  p2:= Pos(':', s);
  p3:= Pos('__init__', s);
  p4:= Pos('pass', s);
  if (p1 > 0) and (p2 > p1) and (p3 > p2) and (p4 > p3) then begin
    delete(s, p1, p2 - p1);
    insert('class ' + EClass.Text, s, p1);
    if CBClassInner.Checked then begin
      SL:= TStringList.Create;
      SL.Text:= s;
      for i:= 0 to SL.Count - 1 do
        SL[i]:= Indent1 + SL[i];
      s:= SL.Text;
      FreeAndNil(SL);
    end;
  end else begin
    if CBClassInner.Checked
      then Indent2 := Indent1
      else Indent2 := '';
    s := CrLf + Indent2 + 'class ' + EClass.Text;
    if EExtends.Text <> '' then
      s := s + '(' + EExtends.Text + ')';
    s := s + ':' + CrLf;
    s := s +
         Indent2 + Indent1 + CrLf +
         Indent2 + Indent1 + 'def __init__(self):' + CrLf +
         Indent2 + Indent1 + Indent1 + 'pass' + CrLf;
    s := s + CrLf;
  end;
  Line := GetLastLineOflastClass;
  myEditor.InsertLinesAt(Line + 1, s);
  myEditor.Modified:= true;
  UpdateTreeView;
  TreeView.Selected := TreeView.Items[TreeView.Items.Count - 3];
  TreeViewChange(Self, TreeView.Selected);
end;

procedure TFClassEditor.BClassChangeClick(Sender: TObject);
var
  s, Searchtext, ReplaceText, tail,
  newClassname, ClassOrInterfaceName: String;
  aClassifier: TClassifier;
  SkipUpdate: Boolean;
  p, NodeIndex, i: Integer;
  Node: TTreeNode;
  SL: TStringList;
begin
  if Trim(EClass.Text) = '' then
    exit;
  if MakeNewClass then
    NewClass
  else begin
    Node := TreeView.Selected;
    if not Assigned(Node) or not Assigned(Node.Data) then
      exit;

    NodeIndex := Node.AbsoluteIndex;
    IsClass := PartOfClass(Node);
    aClassifier := TClassifier(Node.Data);
    newClassname := Trim(EClass.Text);
    ClassOrInterfaceName := getShortType(aClassifier.ShortName);
    Searchtext := 'class ' + ClassOrInterfaceName;
    ReplaceText := 'class ' + newClassname;

    with myEditor do begin
      GotoWord(Searchtext);
      s := ActiveSynEdit.LineText;
      s := myStringReplace(s, Searchtext, ReplaceText);

      p := length(s);
      while (p > 0) and (s[p] <> ':') do
        Dec(p);
      if p > 0 then begin
        tail := copy(s, p + 1, length(s));
        s := copy(s, 1, p - 1);
      end else
        tail := '';

      p := Pos('(', s);
      if p > 0 then
        s := copy(s, 1, p - 1);
      s := Trim(s);
      SkipUpdate := false;

      if EExtends.Text <> '' then begin
        SL := split(',', EExtends.Text);
        for i := SL.Count - 1 downto 0 do
          if Trim(SL.Strings[i]) = '' then begin
            SL.delete(i);
            SkipUpdate := true;
          end;
        if SL.Count > 0 then begin
          s := s + '(' + Trim(SL.Strings[0]);
          for i := 1 to SL.Count - 1 do
            s := s + ', ' + Trim(SL.Strings[i]);
          s := s + ')';
        end;
        FreeAndNil(SL);
      end;

      s := s + ':' + tail;
      ActiveSynEdit.LineText := s;
      Modified := true;
      if SkipUpdate = false then begin
        UpdateTreeView;
        if NodeIndex < TreeView.Items.Count then
          TreeView.Selected := TreeView.Items[NodeIndex];
      end;
    end;
  end;
  BClassApply.Enabled := false;
end;

function TFClassEditor.HasMethod(const getset: string; Attribute: TAttribute;
  var Method: TOperation): Boolean;
var
  s, aName, sNode, datatype: string;
  Node: TTreeNode;
begin
  aName := Attribute.Name;
  if Assigned(Attribute.TypeClassifier)
    then datatype := asPythonType(Attribute.TypeClassifier.Name)
    else datatype := '';
  if getset = _(LNGGet)
    then s := _(LNGGet) + '_' + aName + '('
    else s := _(LNGSet) + '_' + aName + '(';
  Node := GetMethodNode;
  if Assigned(Node) then
    Node := Node.getFirstChild;
  while Assigned(Node) and Assigned(Node.Data) do begin
    sNode := TOperation(Node.Data).toShortStringWithoutParameterNames;
    if Pos(s, sNode) = 1 then
      break;
    Node := Node.getNextSibling;
  end;
  if Assigned(Node)
    then Method := TOperation(Node.Data)
    else Method := nil;
  Result := Assigned(Method);
end;

procedure TFClassEditor.EnableEvents(enable: Boolean);
begin
  if enable and not myEditor.ActiveSynEdit.ReadOnly then begin
    // EClass.OnChange:= @BClassChangeClick;
    // EExtends.OnChange:=  @BClassChangeClick;

    RGAttributeAccess.OnClick := BAttributeChangeClick;
    CBAttributeStatic.OnClick := BAttributeChangeClick;
    CBAttributeFinal.OnClick := BAttributeChangeClick;
    CBgetMethod.OnClick := BAttributeChangeClick;
    CBsetMethod.OnClick := BAttributeChangeClick;

    RGMethodKind.OnClick := BMethodChangeClick;
    RGMethodAccess.OnClick := BMethodChangeClick;
    CBMethodStatic.OnClick := BMethodChangeClick;
    CBMethodClass.OnClick := BMethodChangeClick;
    CBMethodAbstract.OnClick := BMethodChangeClick;
  end
  else
  begin
    EClass.OnChange := nil;
    EExtends.OnChange := nil;

    RGAttributeAccess.OnClick := nil;
    CBAttributeStatic.OnClick := nil;
    CBAttributeFinal.OnClick := nil;
    CBgetMethod.OnClick := nil;
    CBsetMethod.OnClick := nil;

    RGMethodKind.OnClick := nil;
    RGMethodAccess.OnClick := nil;
    CBMethodStatic.OnClick := nil;
    CBMethodClass.OnClick := nil;
    CBMethodAbstract.OnClick := nil;
  end;
end;

function TFClassEditor.PartOfClass(Node: TTreeNode): Boolean;
begin
  Result := false;
  if Assigned(Node) then begin
    while (Node.ImageIndex <> 1) and (Node.ImageIndex <> 11) do
      Node := Node.Parent;
    Result := (Node.ImageIndex = 1);
  end;
end;

function TFClassEditor.GetClassNumber(Node: TTreeNode): Integer;
var
  aCursor: TTreeNode;
begin
  Result := -1;
  aCursor := TreeView.Items.GetFirstNode;
  while aCursor <> Node do begin
    if IsClassOrInterface(aCursor) then
      inc(Result);
    aCursor := aCursor.GetNext;
  end;
end;

function TFClassEditor.GetClassNode(ClassNumber: integer): TTreeNode;
  var aCursor: TTreeNode;
begin
  aCursor := TreeView.Items.GetFirstNode;
  while aCursor <> nil do begin
    if IsClassOrInterface(aCursor) then begin
      dec(ClassNumber);
      if ClassNumber = -1 then
        Exit(aCursor);
    end;
    aCursor := aCursor.GetNext;
  end;
  Result:= nil;
end;

function TFClassEditor.GetNextClassNumber: String;
var
  aCursor: TTreeNode;
  i: Integer;
begin
  i := -1;
  aCursor := TreeView.Items.GetFirstNode;
  while Assigned(aCursor) do begin
    if IsClassOrInterface(aCursor) then
      inc(i);
    aCursor := aCursor.GetNext;
  end;
  inc(i);
  Result := IntToStr(i);
end;

function TFClassEditor.GetLastLineOflastClass: Integer;
var
  Ci: IModelIterator;
  cent: TClassifier;
begin
  Result := -1;
  myEditor.ParseAndCreateModel;
  Ci := myEditor.Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    Result := max(Result, cent.LineE);
  end;
end;

function TFClassEditor.GetClassInterfaceNode: TTreeNode;
var
  i: Integer;
begin
  Result := TreeView.Selected;
  if Assigned(Result) then // we may have multiple classes in the treeview
    while (Result <> nil) and (Result.ImageIndex <> 1) and (Result.ImageIndex <> 11) do
      Result := Result.Parent
  else
    for i := 0 to TreeView.Items.Count - 1 do
      if TreeView.Items[i].ImageIndex in [1, 11] then begin
        Result := TreeView.Items[i];
        break;
      end;
end;

function TFClassEditor.GetAttributeNode: TTreeNode;
var
  Node: TTreeNode;
begin
  Node := GetClassInterfaceNode;
  if Assigned(Node) then
    Result := Node.getFirstChild
  else
    Result := nil;
end;

function TFClassEditor.GetMethodNode: TTreeNode;
var
  Node: TTreeNode;
begin
  Node := GetClassInterfaceNode;
  if Assigned(Node) then
  begin
    Node := Node.getFirstChild;
    if Assigned(Node) then
      Node := Node.getNextSibling
    else
      Node := nil;
  end;
  Result := Node;
end;

procedure TFClassEditor.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  EAttributeName.SelStart := 1;
  EAttributeName.SelLength := 0;
end;

procedure TFClassEditor.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  aClassifier: TClassifier;
  Attribut: TAttribute;
  Methode: TOperation;
  Zeile,{ ClassNumber, }p, q, l: Integer;
  it: IModelIterator;
  s, s1: string;
begin
  if Node = nil then exit;
  
  EnableEvents(false);
  IsClass := PartOfClass(Node);
  //ClassNumber := GetClassNumber(Node);
  if IsClassOrInterface(Node) then begin
    PageControl.ActivePageIndex := 0;
    aClassifier := TClassifier(Node.Data);
    if aClassifier = nil then
      exit;
    EClass.Text := getShortType(aClassifier.ShortName);
    CBClassInner.Checked := (aClassifier.Level > 0);
    if IsClass then  begin
      s := (aClassifier as TClass).AncestorsAsString;
      SetEditText(EExtends, s);
      it := (aClassifier as TClass).GetImplements;
      s := '';
      while it.HasNext do begin
        s1 := getShortType((it.Next as TInterface).ShortName);
        s := s + ', ';
        if Pos('{', s1) = 0 then
          s := s + s1;
      end;
      delete(s, 1, 2);
      // EImplements.Text:= s;
    end else begin
      it := (aClassifier as TInterface).GetExtends;
      s := '';
      while it.HasNext do begin
        s1 := getShortType((it.Next as TInterface).ShortName);
        s := s + ', ';
        if Pos('{', s1) = 0 then
          s := s + s1;
      end;
      delete(s, 1, 2);
      p := EExtends.SelStart;
      q := length(EExtends.Text);
      l := length(s);
      EExtends.Text := s;
      if l > q then
        EExtends.SelStart := p + 1
      else if l < q then
        EExtends.SelStart := p - 1;
    end;
  end
  else if IsAttributesNode(Node) or IsAttributesNodeLeaf(Node) then begin
    PageControl.ActivePageIndex := 1;
    BAttributeApply.Enabled := false;
    if IsAttributesNodeLeaf(Node) then begin
      Attribut := TAttribute(Node.Data);
      if Attribut = nil then
        exit;
      SetEditText(EAttributeName, Attribut.Name);
      if Assigned(Attribut.TypeClassifier)
        then CBAttributeType.Text := asUMLType(Attribut.TypeClassifier.Name)
        else CBAttributeType.Text := '';
      {
      if Attribut.Value <> Attribut.Name
        then SetComboBoxValue(CBAttributeValue, Attribut.Value)
        else CBAttributeValue.Text:= '';
      }

      SetComboBoxValue(CBAttributeValue, Attribut.Value);
      if IsClass then
        RGAttributeAccess.ItemIndex := Integer(Attribut.Visibility)
      else if Attribut.Visibility = viPackage then
        RGAttributeAccess.ItemIndex := 0
      else
        RGAttributeAccess.ItemIndex := 1;
      if CBgetMethod.Visible then
        CBgetMethod.Checked := HasMethod(_(LNGGet), Attribut, Methode);
      if CBsetMethod.Visible then
        CBsetMethod.Checked := HasMethod(_(LNGSet), Attribut, Methode);
      CBAttributeStatic.Checked := Attribut.Static;
      CBAttributeFinal.Checked := Attribut.IsFinal;
    end
    else
    begin
      ComboBoxInsert(CBAttributeType);
      CBAttributeType.Text := '';
      CBAttributeType.ItemIndex := -1;
      CBAttributeValue.Text := '';
      CBAttributeValue.ItemIndex := -1;
      ActiveControl := EAttributeName;
      EAttributeName.Text := '';
    end
  end else begin
    PageControl.ActivePageIndex := 2;
    BMethodApply.Enabled := false;
    AllAttributesAsParameters(Node);
    if IsMethodsNodeLeaf(Node) then begin
      EClass.Text := Node.Parent.Parent.Text; // wg. constructor
      Methode := TOperation(Node.Data);
      if Methode = nil then
        exit;
      CBMethodName.Text := Methode.Name;
      if Assigned(Methode.ReturnValue)
        then CBMethodType.Text := asUMLType(Methode.ReturnValue.getShortType)
        else CBMethodType.Text := '';
      if IsClass then begin
        RGMethodKind.ItemIndex := Integer(Methode.OperationType);
        RGMethodAccess.ItemIndex := Integer(Methode.Visibility);
      end else begin
        RGMethodKind.ItemIndex := Integer(Methode.OperationType) - 1;
        if Methode.Visibility = viPackage
          then RGMethodAccess.ItemIndex := 0
          else RGMethodAccess.ItemIndex := 1;
      end;
      CBMethodStatic.Checked := Methode.isStaticMethod;
      CBMethodClass.Checked := Methode.isClassMethod;
      CBMethodAbstract.Checked := Methode.IsAbstract;
      GetParameter(LBParams, Methode);
    end else begin
      if Assigned(Node) then
        EClass.Text := Node.Parent.Text // wg. constructor
      else
        EClass.Text:= '';
      if IsClass
        then RGMethodKind.ItemIndex := 1 // wg. constructor
        else RGMethodKind.ItemIndex := 0;
      CBMethodName.Text := '';
      ComboBoxInsert(CBMethodType);
      CBMethodType.Text := '';
      CBMethodType.ItemIndex := -1;
      ComboBoxInsert(CBParamName);
      CBParamName.Text := '';
      ComboBoxInsert(CBParamType);
      CBParamType.Text := '';
      CBParamType.ItemIndex := -1;
      CBMethodStatic.Checked:= false;
      CBMethodClass.Checked:= false;
      CBMethodAbstract.Checked:= false;
      LBParams.Clear;
      if IsClass and (RGMethodKind.ItemIndex > 0) or not IsClass then begin
        CBMethodName.Enabled := true;
        ActiveControl := CBMethodName;
      end;
    end;
    CBMethodName.Enabled := (RGMethodKind.ItemIndex > 0) or not IsClass;
    CBMethodType.Enabled := (RGMethodKind.ItemIndex in [1, 2]) or
      (not IsClass and (RGMethodKind.ItemIndex = 1));
  end;
  if IsAttributesNode(Node) or IsMethodsNode(Node) then
    if myEditor.ActiveSynEdit.ReadOnly
      then Zeile := -1
      else Zeile := myEditor.ActiveSynEdit.CaretY
  else if assigned(Node) // Class, Interface, Leaf
    then Zeile := TModelEntity(Node.Data).LineS
    else Zeile := -1;
  if Zeile <> -1 then
    myEditor.GotoLine(Zeile);
  SetClassOrInterface(IsClass);
  ShowMandatoryFields;
  EnableEvents(true);
end;

procedure TFClassEditor.SetEditText(E: TEdit; const s: string);
var
  p: Integer;
begin
  if E.Text <> s then
  begin
    p := E.SelStart;
    E.Text := s;
    E.SelStart := p;
  end;
end;

procedure TFClassEditor.SetComboBoxValue(CB: TComboBox; const s: string);
var
  p: Integer;
begin
  if CB.Text <> s then
  begin
    p := CB.SelStart;
    if (Pos('''', s) > 0) and (Pos('''', CB.Text) = 0) then
      inc(p);
    CB.Text := s;
    CB.SelStart := p;
  end;
end;

procedure TFClassEditor.GetParameter(LB: TListBox; Method: TOperation);
var
  It2: IModelIterator;
  Parameter: TParameter;
  s: string;
  i: Integer;
begin
  LB.Clear;
  It2 := Method.GetParameters;
  while It2.HasNext do begin
    Parameter := It2.Next as TParameter;
    if (Parameter.Name = 'self') or (Parameter.Name = 'cls') then
      continue;
    s:= Parameter.Name;
    if Assigned(Parameter.TypeClassifier) then
      s:= s + ': ' + asUMLType(Parameter.TypeClassifier.getShortType);
    if Parameter.Value <> '' then
      s:= s + ' = ' + Parameter.Value;
    LB.Items.Add(s);
  end;
  if CBParamType.Text <> ''
    then s := CBParamName.Text + ': ' + asUMLType(CBParamType.Text)
    else s := CBParamName.Text;
  i := LB.Items.IndexOf(s);
  if i <> -1 then
    LB.Items.delete(i);
end;

procedure TFClassEditor.PageControlChange(Sender: TObject);
var
  Node: TTreeNode;
  tab: Integer;
begin
  tab := PageControl.TabIndex;
  if BClassApply.Enabled then
    BClassChangeClick(Sender);
  if BAttributeApply.Enabled then
    BAttributeChangeClick(Sender);
  if BMethodApply.Enabled then
    BMethodChangeClick(Sender);
  PageControl.TabIndex := tab;
  case PageControl.TabIndex of
    0: Node := GetClassInterfaceNode;
    1: Node := GetAttributeNode;
  else begin
       Node := GetMethodNode;
       AllAttributesAsParameters(Node);
       end;
  end;
  TreeView.Selected := Node;
end;

procedure TFClassEditor.ActionNewExecute(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    1: begin
        EAttributeName.Text := '';
        CBAttributeType.Text := '';
        CBAttributeValue.Text := '';
        TreeView.Selected := GetAttributeNode;
        CBAttributeStatic.Checked := false;
        CBAttributeFinal.Checked := false;
        if GuiPyOptions.DefaultModifiers and CBgetMethod.Visible then begin
          RGAttributeAccess.ItemIndex := 0;
          CBgetMethod.Checked := true;
        end;
      end;
    2: begin
        CBMethodName.Text := '';
        CBMethodType.Text := '';
        CBParamName.Text := '';
        CBParamType.Text := '';
        CBParamValue.Text := '';
        LBParams.Items.Clear;
        CBParameter.Text := _('Select attribute');
        TreeView.Selected := GetMethodNode;
        CBMethodStatic.Checked := false;
        CBMethodClass.Checked := false;
        CBMethodAbstract.Checked := false;
        if GuiPyOptions.DefaultModifiers then begin
          RGMethodKind.ItemIndex := 1;
          RGMethodAccess.ItemIndex := 2;
        end;
      end;
  else
    begin
      EClass.Text := '';
      EExtends.Text := '';
      CBClassInner.Checked := false;
      if Assigned(TreeView.Selected) then
        TreeView.Selected.Selected:= false;
      MakeNewClass := true;
    end;
  end;
end;

procedure TFClassEditor.AttributeToPython(Attribute: TAttribute; ClassNumber, Line: Integer);
var
  Method: TOperation;
begin
  myEditor.ActiveSynEdit.BeginUpdate;
  myEditor.InsertLinesAt(Line, Attribute.toPython {+ GetAttrValue});
  if IsClass and CBgetMethod.Checked and not HasMethod(_(LNGGet), Attribute, Method) then
    myEditor.InsertProcedure(CrLf + CreateMethod(_(LNGGet), Attribute), ClassNumber);
  if IsClass and CBsetMethod.Checked and not HasMethod(_(LNGSet), Attribute, Method) then
    myEditor.InsertProcedure(CrLf + CreateMethod(_(LNGSet), Attribute), ClassNumber);
  myEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.ChangeGetSet(Attribut: TAttribute; ClassNumber: Integer);
var
  NewGet, NewSet: string;
  Methode1, Methode2: TOperation;
  getIsFirst: Boolean;

  procedure DoGet;
  begin
    if CBgetMethod.Checked then
      if Assigned(Methode1)
        then ReplaceMethod(Methode1, NewGet)
        else myEditor.InsertProcedurewithoutParse(CrLf + NewGet, ClassNumber)
    else if Assigned(Methode1) then
      DeleteMethod(Methode1);
  end;

  procedure DoSet;
  begin
    if CBsetMethod.Checked then
      if Assigned(Methode2)
        then ReplaceMethod(Methode2, NewSet)
        else myEditor.InsertProcedurewithoutParse(CrLf + NewSet, ClassNumber)
    else if Assigned(Methode2) then
      DeleteMethod(Methode2);
  end;

begin
  // replace get/set-methods, names could be changed
  HasMethod(_(LNGGet), Attribut, Methode1);
  HasMethod(_(LNGSet), Attribut, Methode2);
  getIsFirst := true;
  if Assigned(Methode1) and Assigned(Methode2) and
    (Methode1.LineS > Methode2.LineS) then
    getIsFirst := false;
  ChangeAttribute(Attribut);
  if IsClass then begin
    NewGet := CreateMethod(_(LNGGet), Attribut);
    NewSet := CreateMethod(_(LNGSet), Attribut);
    if getIsFirst then begin
      DoSet;
      DoGet;
    end else begin
      DoGet;
      DoSet;
    end;
  end else begin
    if getIsFirst then begin
      if Assigned(Methode2) then
        DeleteMethod(Methode2);
      if Assigned(Methode1) then
        DeleteMethod(Methode1);
    end else begin
      if Assigned(Methode1) then
        DeleteMethod(Methode1);
      if Assigned(Methode2) then
        DeleteMethod(Methode2);
    end;
  end;
end;

function TFClassEditor.NameTypeValueChanged: Boolean;
var
  Node: TTreeNode;
  s: string;
begin
  Node := TreeView.Selected;
  if Assigned(Node) then begin
    s := EAttributeName.Text + ': ' + CBAttributeType.Text;
    if CBAttributeValue.Text <> '' then
      s := s + ' = ' + CBAttributeValue.Text;
    Result := (Node.Text <> s)
  end
  else
    Result := false;
end;

procedure TFClassEditor.BAttributeChangeClick(Sender: TObject);
var
  Old, New, OldName, NewName: string;
  ClassNumber, NodeIndex, TopItemIndex, Line: Integer;
  Attribute: TAttribute;
  Node: TTreeNode;
  OldStatic: Boolean;
begin
  if not MakeIdentifier(EAttributeName) or (EAttributeName.Text = '') then
    exit;
  Node := TreeView.Selected;
  if (Node = nil) or (not PartOfClass(Node) and (CBAttributeValue.Text = '')) then
    exit;
  NodeIndex := Node.AbsoluteIndex;
  TopItemIndex := TreeView.TopItem.AbsoluteIndex;
  ClassNumber := GetClassNumber(Node);

  myEditor.ActiveSynEdit.BeginUpdate;
  if IsAttributesNode(Node) then begin
    NodeIndex := NodeIndex + Node.Count + 1;
    Attribute := MakeAttribute;
    NewName:= Attribute.Name;
    if AttributeAlreadyExists(Attribute.Name) then
      ErrorMsg(Format(_('%s already exists'), [Attribute.Name]))
    else begin
      Line:= myEditor.getLastConstructorLine(ClassNumber);
      AttributeToPython(Attribute, ClassNumber, Line);
      myEditor.removePass(ClassNumber);
    end;
    FreeAndNil(Attribute);
  end else begin
    Attribute := TAttribute(Node.Data);
    OldName := Attribute.Name;
    OldStatic := Attribute.Static;
    Old := Attribute.toPython;
    ChangeGetSet(Attribute, ClassNumber);
    New := Attribute.toPython;
    NewName:= Attribute.Name;
    if New <> Old then begin
      if OldStatic = Attribute.Static then
        myEditor.ReplaceLineInLine(Attribute.LineS - 1, Old, New)
      else if Attribute.Static then begin
        myEditor.DeleteLine(Attribute.LineS - 1);
        myEditor.InsertLinesAt(TClassifier(Attribute.Owner).LineS, New)
      end else if OldStatic then begin
        myEditor.InsertAttributeCE(New, ClassNumber);
        myEditor.DeleteLine(Attribute.LineS - 1);
      end;
      myEditor.ReplaceWord(OldName, Attribute.Name, true);
    end;
  end;

  UpdateTreeView; // reparses
  Node:= GetClassNode(ClassNumber);
  if assigned(Node) then begin
    Node:= Node.getFirstChild.getFirstChild;
    while assigned(Node) and (Node.Text <> NewName) do
      Node:= Node.GetNext;
    if assigned(Node) then
      NodeIndex:= Node.AbsoluteIndex;
  end;

  if (0 <= TopItemIndex) and (TopItemIndex < TreeView.Items.Count) then
    TreeView.TopItem := TreeView.Items[TopItemIndex];
  if (0 <= NodeIndex) and (NodeIndex < TreeView.Items.Count) then
    TreeView.Selected := TreeView.Items[NodeIndex];
  BAttributeApply.Enabled := false;
  myEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.DeleteMethod(Method: TOperation);
var
  i: Integer;
begin
  myEditor.ActiveSynEdit.BeginUpdate;
  myEditor.DeleteBlock(Method.LineS - 1, Method.LineE - 1);
  i := Method.LineS - 1;
  if Method.hasComment then begin
    myEditor.DeleteBlock(Method.Documentation.LineS - 1, Method.Documentation.LineE - 1);
    i := Method.Documentation.LineS - 1;
  end;
  myEditor.DeleteEmptyLine(i - 1);
  myEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.BAttributeDeleteClick(Sender: TObject);
var
  Attribute: TAttribute;
  Methode1, Methode2: TOperation;
  p1, p2, p3, ClassNumber: Integer;
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Assigned(Node) and Assigned(Node.Data) and IsAttributesNodeLeaf(Node) then begin
    myEditor.ActiveSynEdit.BeginUpdate;
    Attribute := TAttribute(Node.Data);
    HasMethod(_(LNGGet), Attribute, Methode1);
    HasMethod(_(LNGSet), Attribute, Methode2);
    if Assigned(Methode1) and Assigned(Methode2) then begin
      if Methode1.LineS < Methode2.LineS then begin
        DeleteMethod(Methode2);
        DeleteMethod(Methode1)
      end else begin
        DeleteMethod(Methode1);
        DeleteMethod(Methode2)
      end;
    end else begin
      if Assigned(Methode1) then
        DeleteMethod(Methode1);
      if Assigned(Methode2) then
        DeleteMethod(Methode2);
    end;
    ClassNumber:= GetClassNumber(Node);
    myEditor.DeleteAttributeCE('self.' + Attribute.VisName, ClassNumber);
    myEditor.ActiveSynEdit.EndUpdate;

    myEditor.Modified := true;
    p1 := TreeView.Selected.AbsoluteIndex;
    p2 := TreeView.FindNextToSelect.AbsoluteIndex;
    p3 := TreeView.TopItem.AbsoluteIndex;
    UpdateTreeView;
    if (0 <= p3) and (p3 < TreeView.Items.Count) then
      TreeView.TopItem := TreeView.Items[p3];
    p1 := min(p1, p2);
    if (0 <= p1) and (p1 < TreeView.Items.Count) then
      TreeView.Selected := TreeView.Items[p1];
    BAttributeApply.Enabled := false;
  end;
end;

procedure TFClassEditor.BMethodDeleteClick(Sender: TObject);
var
  Node: TTreeNode;
  Method: TOperation;
  SL: TStringList;
  p: Integer;
  s: String;
  hasSourceCode: Boolean;
begin
  Node := TreeView.Selected;
  if Assigned(Node) and Assigned(Node.Data) and IsMethodsNodeLeaf(Node) then begin
    Method := TOperation(Node.Data);
    hasSourceCode := false;
    if Method.hasSourceCode then begin
      SL := TStringList.create;
      try
        SL.Text := myEditor.getSource(Method.LineS, Method.LineE - 2);
        for p := SL.Count - 1 downto 0 do begin
          s := Trim(SL.Strings[p]);
          if (Pos('return', s) = 1) or (s = '') or (s = _(LNGTODO)) then
            SL.delete(p);
        end;
        hasSourceCode := (SL.Count > 0);
      finally
        SL.Free;
      end;
    end;

    if hasSourceCode and
      not (MessageDlg(Format(_('Method %s contains source code.'), [Method.Name]) + #13 +
       _('Delete method with source code?'), mtConfirmation, mbYesNoCancel, 0) = mrYes) then
      exit;
    DeleteMethod(Method);
    myEditor.Modified := true;
    p := Node.AbsoluteIndex;
    UpdateTreeView;
    if p = TreeView.Items.Count then
      Dec(p);
    TreeView.Selected := TreeView.Items[p];
    BMethodApply.Enabled := false;
  end;
end;

procedure TFClassEditor.ActionApplyExecute(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    0: BClassChangeClick(Sender);
    1: begin
          BAttributeChangeClick(Sender);
          ActionNewExecute(Sender);
        end;
    2: begin
         BMethodChangeClick(Sender);
         ActionNewExecute(Sender);
       end;
  end;
end;

procedure TFClassEditor.ActionCloseExecute(Sender: TObject);
begin
  myEditor.DoSave;
  if assigned(myUMLForm) then
    myUMLForm.Refresh;
end;

procedure TFClassEditor.ActionDeleteExecute(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1
    then BAttributeDeleteClick(Sender)
    else BMethodDeleteClick(Sender);
end;

function TFClassEditor.GetAttrValue: string;
var
  s: string;
begin
  Result := '';
  s := Trim(CBAttributeValue.Text);
  if s = '' then
    exit;
  if CBAttributeType.Text = 'char' then
  begin
    s := myStringReplace(s, '''', '');
    if s = '' then
      s := ''''''
    else
      s := '''' + s[1] + ''''
  end
  else if CBAttributeType.Text = 'String' then
  begin
    s := myStringReplace(s, '"', '');
    s := '"' + s + '"';
  end;
  Result := ' = ' + s;
end;

function TFClassEditor.CreateMethod(const getset: string;
  Attribute: TAttribute): string;
var
  s, Ident1, Ident2, aName, datatype: string;
begin
  Ident1:= StringTimesN(FConfiguration.Indent1, Attribute.Level + 1);
  Ident2:= StringTimesN(FConfiguration.Indent1, Attribute.Level + 2);
  if Assigned(Attribute.TypeClassifier)
    then datatype := asPythonType(Attribute.TypeClassifier.Name)
    else datatype := '';
  aName := Attribute.Name;

  if getset = _(LNGGet) then begin
    s := Ident1 + 'def ' + _(LNGGet) + '_' + aName + '(self)';
    if datatype <> '' then
      s := s + ' -> ' + datatype;
    s := s + ':' + CrLf + Ident2 + 'return self.' + Attribute.VisName + CrLf;
  end else begin
    s := Ident1 + 'def ' + _(LNGSet) + '_' + aName + '(self, ' + aName;
    if datatype <> '' then
      s := s + ': ' + datatype;
    s := s + '):' + CrLf + Ident2 + 'self.' + Attribute.VisName + ' = ' + aName + CrLf;
  end;
  Result:= s;
end;

function TFClassEditor.Typ2Value(const typ: string): string;
const
  typs: array [1 .. 8] of String = ('int', 'integer', 'float', 'bool', 'boolean',
    'String', 'str', 'None');
const
  vals: array [1 .. 8] of String = ('0', '0', '0', 'false', 'false',
    '""', '""', 'None');
var
  i: Integer;
begin
  Result := 'None';
  for i := 1 to 8 do
    if typs[i] = typ then
    begin
      Result := vals[i];
      break;
    end;
end;

function TFClassEditor.makeConstructor(Method: TOperation; Source: string): string;
var
  Indent, aName, val, vis, s,key: string;
  it: IModelIterator;
  Parameter: TParameter;
  found: Boolean;
  p: Integer;
  Node: TTreeNode;
  SourceSL: TStringList;

  function getSourceIndex(const s: string): integer;
  begin
    Result:= -1;
    for var i:= 0 to SourceSL.Count - 1 do
      if Pos(s, SourceSL[i]) > 0 then
        Exit(i);
  end;

begin
  Parameter := nil;
  SourceSL:= TStringList.Create;
  SourceSL.Text:= Source;
  Indent:= StringTimesN(FConfiguration.Indent1, Method.Level + 2);
  Node := GetAttributeNode.getFirstChild;
  it := Method.GetParameters;
  while it.HasNext do begin
    Parameter := it.Next as TParameter;
    Parameter.UsedForAttribute := false;
  end;

  while Assigned(Node) do begin // iterate over all attributes
    it.Reset;
    found := false;
    case Node.ImageIndex of
        2: vis := '__';
        3: vis := '_';
      else vis := '';
    end;
    while it.HasNext and not found do begin // exists a corresponding parameter?
      Parameter := it.Next as TParameter;
      if Parameter.Name = Node.Text then
        found := true;
    end;
    if found then begin // corresponding parameter exists or
      p:= getSourceIndex('self.' + vis + Parameter.Name);
      if assigned(Parameter.TypeClassifier) then
        s:= Indent + 'self.' + vis + Parameter.Name + ': ' +
            asPythonType(Parameter.TypeClassifier.name) + ' = ' + Parameter.Name
      else
        s:= Indent + 'self.' + vis + Parameter.Name + ' = ' + Parameter.Name;
      if p > -1 then begin
        SourceSL.Delete(p);
        SourceSL.Insert(p, s);
      end else
        SourceSL.Add(s);
      Parameter.UsedForAttribute := true;
    end else begin
      aName := Node.Text;
      val := 'None';
      s:= Indent + 'self.' + vis + aName + ' = ' + val;
      key:= 'self.' + vis + aName + ' = ' + aName;
      p:= getSourceIndex(key);
      if p > -1 then begin
        SourceSL.Delete(p);
        SourceSL.Insert(p, s);
      end else begin
        key:= 'self.' + vis + aName;
        p := getSourceIndex(key);
        if p = -1 then
          SourceSL.Add(s);
      end;
    end;
    Node := Node.getNextSibling;
  end;
  if SourceSL.Count = 0 then
    SourceSL.Add(Indent + 'pass');
  Result := SourceSL.Text;
  FreeAndNil(SourceSL);
end;

function TFClassEditor.MakeIdentifier(var s: string): Integer;
var
  i: Integer;
  s2: string;
begin
  s2 := s;
  Result := 0;
  // delete illegal chars at the beginning
  while (length(s) > 0) and
    not(CharInSet(s[1], ['A' .. 'Z', 'a' .. 'z', '_', '$', 'ä', 'ö', 'ü', 'Ä',
    'Ö', 'Ü'])) do
  begin
    delete(s, 1, 1);
    Result := 1;
  end;
  // delete illegal chars after the beginning
  i := 2;
  while i <= length(s) do
    if not(CharInSet(s[i], ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_']) or
      (Pos(s[i], 'äöüÄÖÜß') > 0)) then
    begin
      delete(s, i, 1);
      Result := i;
    end
    else
      inc(i);
end;

function TFClassEditor.MakeIdentifier(CB: TComboBox): Boolean;
var
  errpos, len: Integer;
  s: string;
  OnChange: TNotifyEvent;
begin
  Result := true;
  s := CB.Text;
  errpos := MakeIdentifier(s);
  if errpos = 0 then
    exit;
  if errpos = -1 then
  begin
    Result := false;
    exit;
  end;
  len := length(CB.Text) - length(s);
  OnChange := CB.OnChange;
  CB.OnChange := nil;
  CB.Text := s;
  CB.OnChange := OnChange;
  if len = 1 then
    CB.SelStart := errpos - 1
  else
    CB.SelStart := length(s);
end;

function TFClassEditor.MakeIdentifier(E: TEdit): Boolean;
var
  errpos, errlen: Integer;
  s: string;
  OnChange: TNotifyEvent;
begin
  Result := true;
  s := E.Text;
  errpos := MakeIdentifier(s);
  if errpos = 0 then
    exit;
  Result := false;
  if errpos = -1 then
    exit;
  errlen := length(E.Text) - length(s);
  OnChange := E.OnChange;
  E.OnChange := nil;
  E.Text := s;
  E.OnChange := OnChange;
  if errlen = 1 then
    E.SelStart := errpos - 1
  else
    E.SelStart := length(s);
end;

procedure TFClassEditor.ChangeAttribute(var A: TAttribute);
begin
  A.Name := EAttributeName.Text;
  A.TypeClassifier := MakeType(CBAttributeType);
  A.Value := CBAttributeValue.Text;
  if IsClass then
    A.Visibility := TVisibility(RGAttributeAccess.ItemIndex)
  else if RGAttributeAccess.ItemIndex = 0 then
    A.Visibility := viPackage
  else
    A.Visibility := viPublic;
  A.Static := CBAttributeStatic.Checked;
  A.IsFinal := CBAttributeFinal.Checked;
end;

function TFClassEditor.MakeAttribute: TAttribute;
begin
  Result := TAttribute.create(nil);
  ChangeAttribute(Result);
end;

function TFClassEditor.MakeType(CB: TComboBox): TClassifier;
var
  s: string;
  i: Integer;
begin
  s := CB.Text;
  i := CB.Items.IndexOf(s);
  if i <> -1 then
    s := CB.Items[i];
  if s = '' then
    Result := nil
  else
    Result := MakeType(s);
end;

function TFClassEditor.MakeType(const s: string): TClassifier;
var
  MyUnit: TUnitPackage;
  aClass: TClass;
begin
  Result := nil;
  MyUnit := myEditor.Model.ModelRoot.FindUnitPackage('Default');
  if Assigned(MyUnit) then
    Result := MyUnit.FindClassifier(s, nil, true);
  if Result = nil then begin
    aClass := TClass.create(nil);
    aClass.Name := s;
    if Assigned(MyUnit) then
      MyUnit.AddClass(aClass);
    Result := aClass;
  end;
end;

procedure TFClassEditor.ChangeMethod(var M: TOperation);
var
  i, p: Integer;
  typ, s, Value: string;
  Parameter: TParameter;
begin
  M.Name := CBMethodName.Text;
  M.ReturnValue := MakeType(CBMethodType);
  if IsClass then begin
    M.OperationType := TOperationType(RGMethodKind.ItemIndex);
    if (CBMethodType.Text = 'None') or (CBMethodType.Text = '') then begin
      M.OperationType:= otProcedure;
      M.ReturnValue:= nil;
    end;
  end
  else if RGMethodKind.ItemIndex = 0 then
    M.OperationType := otFunction
  else
    M.OperationType := otProcedure;

  M.Visibility:= TVisibility(RGMethodAccess.ItemIndex);
  if UUtils.Left(M.Name, 2) = '__' then
    M.Visibility:= viPrivate;
  M.isStaticMethod := CBMethodStatic.Checked;
  M.isClassMethod := CBMethodClass.Checked;
  M.IsAbstract := CBMethodAbstract.Checked and IsClass;
  M.NewParameters;
  for i := 0 to LBParams.Items.Count - 1 do begin
    s:= LBParams.Items[i];
    p:= Pos(' = ', s);
    if p > 0 then begin
      Value:= copy(s, p + 3, length(s));
      delete(s, p, length(s));
    end else
      Value:= '';
    p := Pos(':', s);
    if p > 0 then begin
      typ := copy(s, p + 2, length(s));
      delete(s, p, length(s));
    end else
      typ:= '';
    Parameter:= M.AddParameter(s);
    if typ <> ''
      then Parameter.TypeClassifier:= MakeType(typ)
      else Parameter.TypeClassifier:= nil;
    Parameter.Value:= Value;
  end;
  if (CBParamName.Text <> '') and (CBParamType.Text <> '') then
    M.AddParameter(CBParamName.Text).TypeClassifier := MakeType(CBParamType);
end;

procedure TFClassEditor.SetClassOrInterface(aIsClass: Boolean);

  procedure setRadioGroup(RG: TRadioGroup; Text: string);
  var
    index: Integer;
  begin
    if RG.Items.Text <> Text then
    begin
      index := RG.ItemIndex;
      RG.Items.Text := Text;
      RG.ItemIndex := index;
    end;
  end;

begin
  if aIsClass then begin
    TSClass.Caption := '&' + _('Class');
    LClass.Caption := _('Class');
    CBMethodAbstract.Visible := true;
    if GuiPyOptions.ShowGetSetMethods then begin
      CBgetMethod.Visible := true;
      CBsetMethod.Visible := true;
    end;
    RGAttributeAccess.Height := 115;
    GBAttributeOptions.Height := 115;
    RGMethodKind.Height := 105;
    RGMethodAccess.Height := 105;
    GBMethodOptions.Visible := true;
  end else begin
    TSClass.Caption := '&' + _('Interface');
    LClass.Caption := _('Interface');
    RGMethodKind.Items.delete(0);
    CBMethodAbstract.Visible := false;
    CBgetMethod.Visible := false;
    CBsetMethod.Visible := false;
    RGAttributeAccess.Height := 65;
    GBAttributeOptions.Height := 65;
    RGMethodKind.Height := 65;
    RGMethodAccess.Height := 65;
    GBMethodOptions.Visible := false;
  end;
  CBMethodStatic.Enabled := aIsClass;
  CBMethodClass.Enabled := aIsClass;
end;

procedure TFClassEditor.UpdateTreeView;
var
  Ci, it: IModelIterator;
  cent: TClassifier;
  Attribut: TAttribute;
  Methode: TOperation;
  IsFirstClass: Boolean;
begin
  TreeView.OnChange := nil;
  EnableEvents(false);
  IsFirstClass := true;
  myEditor.ParseAndCreateModel;
  TreeView.Items.BeginUpdate;
  TreeView.Items.Clear;
  Ci := myEditor.Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    if (cent.pathname <> myEditor.pathname) or cent.anonym then
      continue;
    if IsFirstClass then begin
      EClass.Text := getShortType(cent.ShortName);
      IsFirstClass := false;
    end;
    TVClassOrInterface(cent);
    it := cent.GetAttributes;
    while it.HasNext do begin
      Attribut := it.Next as TAttribute;
      TVAttribute(Attribut);
    end;
    it := cent.GetOperations;
    while it.HasNext do begin
      Methode := it.Next as TOperation;
      TVMethod(Methode);
    end;
  end;
  TreeView.FullExpand;
  TreeView.Items.EndUpdate;
  EnableEvents(true);
  TreeView.OnChange := TreeViewChange;
end;

function TFClassEditor.CountClassOrInterface: Integer;
var
  Ci: IModelIterator; cent: TClassifier;
begin
  Result := 0;
  if assigned(myUMLForm) then begin
    Ci := myUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      cent:= TClassifier(Ci.Next);
      if cent.Pathname = myEditor.pathname then
        inc(Result);
    end;
  end;
end;

function TFClassEditor.CreateTreeView(Editor: TEditorForm;
  UMLForm: TFUMLForm): Boolean;
begin
  myUMLForm := UMLForm;
  myEditor := Editor;
  UpdateTreeView;
  if TreeView.Items.Count > 0 then begin
    TreeView.Selected := AttributeNode;
    TreeView.TopItem := TreeView.Items.GetFirstNode;
  end;
  Editor.Invalidate;
  Result := true;
end;

procedure TFClassEditor.ActionListUpdate(aAction: TBasicAction;
  var Handled: Boolean);
var
  vis: Boolean;
begin
  if (aAction is TAction) then
  begin
    if Assigned(myEditor) then
      vis := not myEditor.ActiveSynEdit.ReadOnly
    else
      vis := true;
    (aAction as TAction).Enabled := vis;
  end;
  Handled := true;
end;

procedure TFClassEditor.BParameterNewClick(Sender: TObject);
begin
  if CBParamName.Text <> '' then begin
    if (CBParamType.Text <> '') and
       (CBParamName.Items.IndexOf(CBParamName.Text) = -1) then
         CBParamName.Items.AddObject(CBParamName.Text, TParamTyp.create(CBParamType.Text));
    TakeParameter;
    BMethodChangeClick(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.BParameterDeleteClick(Sender: TObject);
begin
  CBParamName.Text := '';
  CBParamType.Text := '';
  CBParamValue.Text:= '';
end;

procedure TFClassEditor.CBParamNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    ComboBoxInvalid := false;
    CBParamNameSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBParamNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if CBParamName.Text <> '' then
    BMethodApply.Enabled := true;
  ShowMandatoryFields;
end;

procedure TFClassEditor.CBParamNameSelect(Sender: TObject);
var
  s: string;
  p: Integer;
begin
  p := CBParamName.ItemIndex;
  if (p = -1) or (CBParamName.Text <> CBParamName.Items[p]) then
    s := CBParamName.Text
  else
    s := CBParamName.Items[p];
  if not ComboBoxInvalid then begin
    if (-1 < p) and Assigned(CBParamName.Items.Objects[p]) then
      CBParamType.Text := TParamTyp(CBParamName.Items.Objects[p]).typ;
    CBParamName.Text := s;
    SBRightClick(Self);
  end;
end;

procedure TFClassEditor.AllAttributesAsParameters(Node: TTreeNode);
var
  s, aClassname: string;
  Ci, it: IModelIterator;
  cent: TClassifier;
  Attribute: TAttribute;
  aNode: TTreeNode;
  Method: TOperation;
  Parameter: TParameter;
  p: Integer;

  procedure MakeParameterFromAttributes(cent: TClassifier);
    var it: IModelIterator;
  begin
    it := cent.GetAttributes;
    while it.HasNext do begin
      Attribute := it.Next as TAttribute;
      s := Attribute.toShortStringNode;
      if CBParameter.Items.IndexOf(s) = -1 then
        CBParameter.Items.Add(s);
    end;
  end;

begin
  cent := nil;
  CBParameter.Clear;
  aNode := GetClassInterfaceNode;
  if Assigned(aNode) and Assigned(aNode.Data) then
    aClassname := TClassifier(aNode.Data).Name
  else
    aClassname := '';

  // look in modified model
  Ci := myEditor.Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    if cent.Name = aClassname then
      break;
  end;
  if Assigned(cent) then
    MakeParameterFromAttributes(cent);

  while (cent is TClass) and ((cent as TClass).AncestorsCount > 0) do begin // ToDo n ancestors
    cent := (cent as TClass).Ancestor[0];
    MakeParameterFromAttributes(cent);
  end;

  // look too in model of uml-diagram for ancestors
  if Assigned(myUMLForm) and Assigned(myUMLForm.MainModul) and
    Assigned(myUMLForm.MainModul.Model) and
    Assigned(myUMLForm.MainModul.Model.ModelRoot) then begin
    Ci := myUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      cent := TClassifier(Ci.Next);
      if cent.Name = aClassname then
        break;
    end;
    while (cent is TClass) and ((cent as TClass).AncestorsCount > 0) do begin // Todo n ancestors
      cent := (cent as TClass).Ancestor[0];
      MakeParameterFromAttributes(cent);
    end;
  end;

  if Assigned(Node) and Assigned(Node.Data) and IsMethodsNodeLeaf(Node) then begin
    Method := TOperation(Node.Data);
    it := Method.GetParameters;
    while it.HasNext do begin
      Parameter := it.Next as TParameter;
      s := Parameter.toShortStringNode;
      p := CBParameter.Items.IndexOf(s);
      if p > -1 then
        CBParameter.Items.delete(p);
    end;
  end;
  CBParameter.Text := _('Select attribute');
end;

procedure TFClassEditor.ComboBoxCloseUp(Sender: TObject);
begin
  ComboBoxInvalid := false;
end;

procedure TFClassEditor.CBComboBoxEnter(Sender: TObject);
  var CB: TComboBox; R: TRect; LeftPart: boolean;
begin
  if Sender is TComboBox then begin
    CB:= Sender as TComboBox;
    R:= CB.ClientRect;
    R.Width:= R.Width - 20;
    R:= CB.ClientToScreen(R);
    LeftPart:= R.Contains(Mouse.CursorPos);
    if LeftPart and (CB.Items.Count > 0) then
      SendMessage(CB.Handle, CB_SHOWDROPDOWN, 1, 0);
  end;
end;

procedure TFClassEditor.CBAttributeTypeDropDown(Sender: TObject);
begin
  SendMessage(CBAttributeType.Handle, WM_SETCURSOR, 0, 0)
end;

procedure TFClassEditor.CBAttributeValueDropDown(Sender: TObject);
begin
  SendMessage(CBAttributeValue.Handle, WM_SETCURSOR, 0, 0)
end;

procedure TFClassEditor.CBAttributeTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    ComboBoxInvalid := false;
    CBAttributeTypeSelect(Self);
    CBAttributeValue.SetFocus;
  end;
end;

procedure TFClassEditor.CBAttributeTypeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_Return then
    BAttributeApply.Enabled := true
end;

procedure TFClassEditor.CBAttributeTypeSelect(Sender: TObject);
  var s: string;  p: Integer;
begin
  p := CBAttributeType.ItemIndex;
  if (p = -1) or (CBAttributeType.Text <> CBAttributeType.Items[p])
    then s := CBAttributeType.Text
    else s := CBAttributeType.Items[p];
  if not ComboBoxInvalid then begin
    CBAttributeType.Text := s;
    if NameTypeValueChanged then
      BAttributeChangeClick(Self);
  end;
end;

procedure TFClassEditor.CBAttributeValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  BAttributeApply.Enabled := true;
  if (Key = #13) and NameTypeValueChanged then
    BAttributeChangeClick(Self);
  if Key = #13 then
    BAttributeNew.SetFocus;
end;

procedure TFClassEditor.CBAttributeValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_Return then
    BAttributeApply.Enabled := true
end;

procedure TFClassEditor.CBAttributeValueSelect(Sender: TObject);
var
  s: string;
  p: Integer;
begin
  p := CBAttributeValue.ItemIndex;
  if (p = -1) or (CBAttributeValue.Text <> CBAttributeValue.Items[p]) then
    s := CBAttributeValue.Text
  else
    s := CBAttributeValue.Items[p];
  if not ComboBoxInvalid then
  begin
    CBAttributeValue.Text := s;
    if NameTypeValueChanged then
      BAttributeChangeClick(Self);
  end;
end;

procedure TFClassEditor.CBClassAbstractClick(Sender: TObject);
begin
  BClassChangeClick(Self);
end;

procedure TFClassEditor.CBClassAbstractMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BClassApply.Enabled := true;
end;

procedure TFClassEditor.EAttributeNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    CBAttributeType.SetFocus;
end;

procedure TFClassEditor.EAttributeNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BAttributeApply.Enabled := true;
  if Key = VK_Return then
    BAttributeChangeClick(Self);
end;

procedure TFClassEditor.EClassKeyPress(Sender: TObject; var Key: Char);
begin
  BClassApply.Enabled := true;
end;

procedure TFClassEditor.CBMethodnameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    BMethodChangeClick(Self);
    CBMethodType.SetFocus;
  end;
end;

procedure TFClassEditor.CBMethodnameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BMethodApply.Enabled := true
end;

procedure TFClassEditor.CBMethodnameSelect(Sender: TObject);
var
  s: string;
  p: Integer;
begin
  p := CBMethodName.ItemIndex;
  if (p = -1) or (CBMethodName.Text <> CBMethodName.Items[p]) then
    s := CBMethodName.Text
  else
    s := CBMethodName.Items[p];
  if not ComboBoxInvalid then
  begin
    CBMethodName.Text := s;
    if CBMethodName.Items.IndexOf(s) = -11 then
      CBMethodName.Items.Add(s);
    if (CBMethodName.Text <> '') and (RGMethodKind.ItemIndex < 2) then
      BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.CBMethodTypeDropDown(Sender: TObject);
begin
  SendMessage(CBMethodType.Handle, WM_SETCURSOR, 0, 0);
  RGMethodKind.ItemIndex := 1;
end;

procedure TFClassEditor.CBMethodTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    ComboBoxInvalid := false;
    BMethodChangeClick(Self);
    CBMethodTypeSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBMethodParamTypeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_Return then
    BMethodApply.Enabled := true
end;

procedure TFClassEditor.CBMethodTypeSelect(Sender: TObject);
  var s: string; p: Integer;
begin
  p := CBMethodType.ItemIndex;
  if (p = -1) or (CBMethodType.Text <> CBMethodType.Items[p])
    then s := CBMethodType.Text
    else s := CBMethodType.Items[p];
  BMethodApply.Enabled := true;
  if not ComboBoxInvalid then begin
    CBMethodType.Text := s;
    if (CBMethodName.Text <> '') and (CBMethodType.Text <> '') then
      BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.ComboBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ComboBoxInvalid := true;
end;

procedure TFClassEditor.CBParameterSelect(Sender: TObject);
var
  s: string;
begin
  s := CBParameter.Items[CBParameter.ItemIndex];
  if (s <> _('Select attribute')) and (LBParams.Items.IndexOf(s) = -1) then
  begin
    LBParams.Items.Add(s);
    BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.CBParamTypeDropDown(Sender: TObject);
begin
  SendMessage(CBParamType.Handle, WM_SETCURSOR, 0, 0);
end;

procedure TFClassEditor.CBParamTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    ComboBoxInvalid := false;
    CBParamTypeSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBParameterKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    ComboBoxInvalid := false;
    CBParameterSelect(Self);
  end;
end;

procedure TFClassEditor.CBParamTypeSelect(Sender: TObject);
var
  s: string;
  p: Integer;
begin
  p := CBParamType.ItemIndex;
  if (p = -1) or (CBParamType.Text <> CBParamType.Items[p])
    then s := CBParamType.Text
    else s := CBParamType.Items[p];
  if not ComboBoxInvalid then begin
    CBParamType.Text := s;
    if (CBParamName.Text <> '') then begin
      BMethodChangeClick(Self); {
      TThread.ForceQueue(nil, procedure
        begin
          CBParamType.Text:= '';
        end);
        }
    end;
  end;
end;


function TFClassEditor.RGMethodKindChanged(ClassNumber: integer): boolean;
  var Node: TTreeNode;
begin
  Result:= false;
  if (RGMethodKind.ItemIndex = 0) and (CBMethodName.Text <> '__init__') then begin
    Node:= GetClassNode(ClassNumber);
    if assigned(Node) then begin
      Node:= Node.getFirstChild.getNextSibling.getFirstChild;
      while assigned(Node) and (pos('__init__(', Node.Text) = 0) do
        Node:= Node.GetNextSibling;
      if assigned(Node) then begin
        Node.Selected:= true;
        TreeViewChange(self, Node);
        Result:= true;
      end else begin
        CBMethodName.Text:= '__init__';
      end;
    end;
  end else if (RGMethodKind.ItemIndex > 0) and (CBMethodName.Text = '__init__') then begin
    RGMethodKind.ItemIndex:= 0;
    Result:= true;
  end;

  CBMethodName.Enabled := (RGMethodKind.ItemIndex > 0);
  CBMethodType.Enabled := true;
  ShowMandatoryFields;
end;

procedure TFClassEditor.ShowMandatoryFields;
begin
  case PageControl.ActivePageIndex of
    1: if EAttributeName.Text = ''
         then EAttributeName.Color := clInfoBK
         else EAttributeName.Color := clWindow;
    2:
      begin
        if CBMethodName.Enabled and (CBMethodName.Text = '')
          then CBMethodName.Color := clInfoBK
          else CBMethodName.Color := clWindow;
        if CBMethodType.Enabled and (CBMethodType.Text = '')
          then CBMethodType.Color := clInfoBK
          else CBMethodType.Color := clWindow;
        if (CBParamName.Text <> '') and (CBParamType.Text = '')
          then CBParamType.Color := clInfoBK
          else CBParamType.Color := clWindow;
        if (CBParamName.Text = '') and (CBParamType.Text <> '')
          then CBParamName.Color := clInfoBK
          else CBParamName.Color := clWindow;
      end;
  end;
end;

function TFClassEditor.MethodToPython(Method: TOperation; Source: string): string;
var
  s, s2, Indent1, Indent2, comment: string;
  i, count: Integer;
  SL: TStringList;

  procedure delparam(const param: string);
    var i: Integer;
  begin
    i := 0;
    while i < SL.Count do
      if Pos(param, SL.Strings[i]) > 0
        then SL.delete(i)
        else inc(i);
  end;

  procedure AdjustReturnValue;
    const ReturnValues: Array[1..5] of string = (' return 0', ' return ""',
       ' return false', ' return ''\0''', ' return None');
    var i, p: integer;
  begin
    for i:= 1 to 5 do begin
      p:= Pos(ReturnValues[i], Source);
      if p > 0 then begin
        Delete(Source, p, length(ReturnValues[i]));
        Insert(' return ' + s2, Source, p);
        break;
      end;
    end;
  end;

begin
  Indent1:= StringTimesN(FConfiguration.Indent1, Method.Level + 1);
  Indent2:= StringTimesN(FConfiguration.Indent1, Method.Level + 2);
  if Pos('"""', Source) = 0
    then comment:= FConfiguration.getMultiLineComment(Indent2)
    else comment:= '';
  s := Method.HeadToPython + CrLf;
  SL:= TStringList.Create;
  case Method.OperationType of
    otConstructor: s := s + comment + makeConstructor(Method, Source);
    otFunction:
      begin
        if assigned(Method.ReturnValue)
          then s2:= Typ2Value(Method.ReturnValue.getShortType)
          else s2:= 'None';
        if Pos(' return ', Source) > 0 then begin
          AdjustReturnValue;
          s:= s + Source;
        end else begin
          if Source = ''
            then s := s + comment + Indent2 + _(LNGTODO) + CrLf
            else s := s + Source;
          s:= s + Indent2 + 'return ' + s2 + CrLf;
        end;

        SL.Text:= s;
        for i := SL.Count - 1 downto 0 do
          if trim(SL.Strings[i]) = 'pass' then
            SL.Delete(i);
        s:= SL.Text;
      end;
    otProcedure:
      begin
        if Source <> '' then begin
          count:= 0;
          SL.Text:= Source;
          for i:= 0 to SL.Count - 1 do begin
            if trim(SL.Strings[i]) = 'pass' then
              inc(count);
            if Pos(' return ', SL.Strings[i]) >  0 then begin
              Sl.Strings[i] := Indent2 + 'pass';
              inc(count);
            end;
          end;
          i:= 0;
          while Count > 1 do begin
            if trim(SL.Strings[i]) = 'pass' then begin
              SL.delete(i);
              dec(Count);
            end else
              inc(i);
          end;
          if Count = 0 then
            SL.Add(Indent2 + 'pass');
          s:= s + SL.Text;
        end else
          s := s + comment + Indent2 + _(LNGTODO) + CrLf
                 + Indent2 + 'pass' + CrLf;
      end;
  end;
  LBParams.Items.Clear;
  if not Method.hasComment then
    Method.hasComment := (comment <> '');
  Result := s;
  FreeAndNil(SL);
end;

procedure TFClassEditor.BMethodChangeClick(Sender: TObject);
var
  New, Source: string;
  Method: TOperation;
  ClassNumber, NodeIndex, TopItemIndex, Level: Integer;
  Node, Cursor: TTreeNode;
  SL: TStringList;
begin
  if (not (MakeIdentifier(CBMethodName) and MakeIdentifier(CBMethodType) and
    MakeIdentifier(CBParamName) and MakeIdentifier(CBParamType)) or
    (CBMethodName.Text = '')) and (RGMethodKind.ItemIndex > 0) then
    exit;
  Node := TreeView.Selected;
  if Assigned(Node)
    then NodeIndex := Node.AbsoluteIndex
    else exit;
  if Assigned(TreeView.TopItem)
    then TopItemIndex := TreeView.TopItem.AbsoluteIndex
    else exit;

  TakeParameter;
  ClassNumber := GetClassNumber(Node);
  if RGMethodKindChanged(ClassNumber) then
    exit;

  myEditor.ActiveSynEdit.BeginUpdate;
  if IsMethodsNode(Node) then begin
    Level:= -1;
    Cursor:= Node;
    while Cursor.Parent <> nil do begin
      inc(Level);
      Cursor:= Cursor.Parent;
    end;
    if RGMethodKind.ItemIndex = 0 then begin
      inc(NodeIndex);
      Node := Node.GetNext;
      while Assigned(Node) and (Node.ImageIndex = 6) do begin
        inc(NodeIndex);
        Node := Node.GetNext;
      end;
    end else
      NodeIndex := NodeIndex + Node.Count + 1;
    Method := MakeMethod(Level);
    if not MethodAlreadyExists(Method.toShortStringNode) then begin
      New := sLineBreak + MethodToPython(Method, '');
      if IsClass and (RGMethodKind.ItemIndex = 0)
        then myEditor.InsertConstructor(New, Classnumber)
        else myEditor.InsertProcedure(New, ClassNumber);
    end else if (Sender = BMethodApply) then
      ErrorMsg(Format(_('%s already exists'), [Method.toShortStringNode]));
    FreeAndNil(Method);
  end else begin
    Method := TOperation(Node.Data);
    if Assigned(Method) then begin
      ChangeMethod(Method);
      if Method.hasSourceCode then begin
        Source := myEditor.getSource(Method.LineS - 1, Method.LineE - 1);
        SL:= TStringList.Create;
        SL.Text:= Source;
        while (SL.Count > 0) and (Pos(FConfiguration.Indent1 + 'def ', SL.Strings[0]) = 0) do
          SL.Delete(0);
        if (SL.Count > 0) then SL.Delete(0);
        Source:= SL.Text;
        FreeAndNil(SL);
      end else
        Source := '';
      New := MethodToPython(Method, Source);
      ReplaceMethod(Method, New);
    end;
  end;
  myEditor.Modified := true;
  UpdateTreeView;
  BMethodApply.Enabled := false;
  if TopItemIndex < TreeView.Items.Count then
    TreeView.TopItem := TreeView.Items[TopItemIndex];
  if NodeIndex < TreeView.Items.Count then
    TreeView.Selected := TreeView.Items[NodeIndex];
  myEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.ReplaceMethod(var Method: TOperation; const New: string);
begin
  myEditor.ActiveSynEdit.BeginUpdate;
  myEditor.DeleteBlock(Method.LineS - 1, Method.LineE - 1);
  myEditor.InsertLinesAt(Method.LineS - 1, New);
  myEditor.ActiveSynEdit.EndUpdate;
end;

function TFClassEditor.MakeMethod(Level: integer): TOperation;
begin
  Result := TOperation.create(nil);
  Result.Level:= Level;
  ChangeMethod(Result);
end;

procedure TFClassEditor.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath + '\RGAttributeAccess', RGAttributeAccess.ItemIndex);
  AppStorage.WriteBoolean(BasePath + '\CBGetMethod', CBGetMethod.Checked);
  AppStorage.WriteBoolean(BasePath + '\CBSetMethod', CBSetMethod.Checked);
  AppStorage.WriteInteger(BasePath + '\RGMethodKind', RGMethodKind.ItemIndex);
  AppStorage.WriteInteger(BasePath + '\RGMethodAccess', RGMethodAccess.ItemIndex);
end;

procedure TFClassEditor.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  RGAttributeAccess.ItemIndex := AppStorage.ReadInteger(BasePath + '\RGAttributeAccess', 0);
  CBgetMethod.Checked := AppStorage.ReadBoolean(BasePath + '\CBGetMethod', false);
  CBsetMethod.Checked := AppStorage.ReadBoolean(BasePath + '\CBSetMethod', false);
  RGMethodKind.ItemIndex := AppStorage.ReadInteger(BasePath + '\RGMethodKind', 1);
  RGMethodAccess.ItemIndex := AppStorage.ReadInteger(BasePath + '\RGMethodAccess', 2);
end;

procedure TFClassEditor.SBDeleteClick(Sender: TObject);
var
  i: Integer;
begin
  i := LBParams.ItemIndex;
  LBParams.DeleteSelected;
  BMethodChangeClick(Self);
  if i = LBParams.Count then
    Dec(i);
  if i >= 0 then
    LBParams.Selected[i] := true;
end;

procedure TFClassEditor.SBDownClick(Sender: TObject);
var
  i: Integer;
begin
  i := LBParams.ItemIndex;
  if (0 <= i) and (i < LBParams.Count - 1) then begin
    LBParams.Items.Exchange(i, i + 1);
    BMethodChangeClick(Self);
    LBParams.Selected[i + 1] := true;
  end;
end;

procedure TFClassEditor.SBUpClick(Sender: TObject);
var
  i: Integer;
begin
  i := LBParams.ItemIndex;
  if (0 < i) and (i < LBParams.Count) then begin
    LBParams.Items.Exchange(i, i - 1);
    BMethodChangeClick(Self);
    LBParams.Selected[i - 1] := true;
  end;
end;

procedure TFClassEditor.SBLeftClick(Sender: TObject);
var
  s: String;
  p: Integer;
begin
  if (CBParamName.Text = '') and (CBParamType.Text = '') and
    (LBParams.ItemIndex < LBParams.Items.Count) and (0 <= LBParams.ItemIndex)
  then begin
    s := LBParams.Items[LBParams.ItemIndex];
    p := Pos(' = ', s);
    if p > 0 then begin
      CBParamValue.Text := copy(s, p + 3, length(s));
      delete(s, p, length(s));
    end;
    p := Pos(': ', s);
    if p > 0 then begin
      CBParamType.Text := copy(s, p + 2, length(s));
      delete(s, p, length(s));
    end;
    CBParamName.Text := s;
    LBParams.Items.delete(LBParams.ItemIndex);
  end;
end;

function TFClassEditor.StrToPythonValue(s: String): String;
begin
  Result:= trim(s);
  if not (isNumber(Result) or isBool(Result) or (Result = 'None') or
     (Result <> '') and (Pos(Result[1], '[({''') > 0))
  then
    Result:= asString(Result);
end;

procedure TFClassEditor.TakeParameter;
  var s: string;
begin
  if CBParamName.Text <> '' then begin
    s:= CBParamName.Text;
    if CBParamType.Text <> '' then
      s:= s + ': ' + CBParamType.Text;
    if CBParamValue.Text <> '' then
      s:= s + ' = ' + StrToPythonValue(CBParamValue.Text);
    LBParams.Items.Add(s);
    CBParamName.Text := '';
    CBParamValue.Text := '';
    CBParamType.Text := '';
  end;
end;

procedure TFClassEditor.SBRightClick(Sender: TObject);
begin
  if CBParamName.Text <> '' then begin
    TakeParameter;
    BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.Init;
begin
  EnableEvents(false);
  CBAttributeStatic.Checked := false;
  CBAttributeFinal.Checked := false;
  CBMethodStatic.Checked := false;
  CBMethodClass.Checked := false;
  CBMethodAbstract.Checked := false;
  if GuiPyOptions.DefaultModifiers then begin
    RGAttributeAccess.ItemIndex := -1;
    RGAttributeAccess.ItemIndex := 0;
    if CBgetMethod.Visible then
      CBgetMethod.Checked := true;
    CBsetMethod.Checked := false;
    RGMethodKind.ItemIndex := 1;
    RGMethodAccess.ItemIndex := 3;
  end;
  EnableEvents(true);
end;

procedure TFClassEditor.TreeViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
  var TargetNode, SourceNode: TTreeNode;
begin
  with TreeView do begin
    TargetNode := GetNodeAt(X, Y); // Get target node
    if TargetNode = nil then begin
      EndDrag(false);
      exit;
    end;
    SourceNode := Selected;
    MoveNode(TargetNode, SourceNode);
  end;
end;

procedure TFClassEditor.TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if (Sender = TreeView) then
    Accept := true;
end;

procedure TFClassEditor.MoveNode(TargetNode, SourceNode: TTreeNode);
var
  von, bis, nach, nachbis, NodeIndex: Integer;
  Leerzeilen: String;
begin
  if IsClassOrInterface(SourceNode) or IsAttributesNode(SourceNode) or
    IsMethodsNode(SourceNode) or IsClassOrInterface(TargetNode) or
    myEditor.ActiveSynEdit.ReadOnly then
    exit;

  if IsAttributesNode(TargetNode) or IsMethodsNode(TargetNode) then
    TargetNode:= TargetNode.getFirstChild;
  if IsAttributesNodeLeaf(SourceNode) and IsAttributesNodeLeaf(TargetNode) then
    Leerzeilen := ''
  else if IsMethodsNodeLeaf(SourceNode) and IsMethodsNodeLeaf(TargetNode) then
    Leerzeilen := #13#10
  else
    exit;

  if assigned(TModelEntity(SourceNode.Data)) then begin
    von:= TModelEntity(SourceNode.Data).LineS;
    bis:= TModelEntity(SourceNode.Data).LineE;
  end else
    exit;

  if assigned(TModelEntity(TargetNode.Data)) then begin
    nach := TModelEntity(TargetNode.Data).LineS;
    nachbis:= TModelEntity(TargetNode.Data).LineE;
  end else
    exit;

  if IsMethodsNodeLeaf(SourceNode) and (trim(myEditor.ActiveSynEdit.lines[nachbis]) = '') then
    inc(nachbis);
  if (von <= nach) and (nach <= bis) then
    exit;
  myEditor.MoveBlock(von - 1, bis - 1, nach - 1, nachbis-1, Leerzeilen);
  NodeIndex := TargetNode.AbsoluteIndex;
  UpdateTreeView;
  if NodeIndex < TreeView.Items.Count then
    TreeView.Selected := TreeView.Items[NodeIndex];
end;

procedure TFClassEditor.LBParamsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_Delete) and not myEditor.ActiveSynEdit.ReadOnly then
    LBParams.DeleteSelected;
end;

function TFClassEditor.IsClassOrInterface(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and
    ((Node.ImageIndex = 1) or (Node.ImageIndex = 11));
end;

function TFClassEditor.IsAttributesNodeLeaf(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.Parent.ImageIndex = 12);
end;

function TFClassEditor.IsAttributesNode(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.ImageIndex = 12);
end;

function TFClassEditor.IsMethodsNodeLeaf(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.Parent.ImageIndex = 13);
end;

function TFClassEditor.IsMethodsNode(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.ImageIndex = 13);
end;

function TFClassEditor.AttributeAlreadyExists(const s: string): Boolean;
var
  Node: TTreeNode;
  p: Integer;
begin
  Node := AttributeNode.getFirstChild;
  while Assigned(Node) do
  begin
    p := Pos(':', Node.Text);
    if copy(Node.Text, 1, p - 1) = s then
      break;
    Node := Node.getNextSibling;
  end;
  Result := Assigned(Node);
end;

function TFClassEditor.MethodAlreadyExists(const s: string): Boolean;
var
  Node: TTreeNode;
begin
  Node := MethodNode.getFirstChild;
  while Assigned(Node) and (Node.Text <> s) do
    Node := Node.getNextSibling;
  Result := Assigned(Node);
end;

procedure TFClassEditor.ChangeStyle;
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.create;
  Bitmap.Transparent := true;
  if IsStyledWindowsColorDark then begin
    ILSpeedButton.GetBitmap(1, Bitmap);
    TreeView.Images := FFileStructure.ILFileStructureDark;
  end else begin
    ILSpeedButton.GetBitmap(0, Bitmap);
    TreeView.Images := FFileStructure.ILFileStructureLight;
  end;
  SBDelete.Glyph := Bitmap;
  FreeAndNil(Bitmap);
end;

procedure TFClassEditor.PrepareNewClass;
begin
  if assigned(TReeView.Selected) then
    TreeView.Selected.Selected:= false;
  PageControl.ActivePageIndex:= 0;
  FClassEditor.EClass.Text := '';
  MakeNewClass:= true;
end;

end.
