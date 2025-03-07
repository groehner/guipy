unit UClassEditor;

interface

uses
  Classes, Controls, Forms, StdCtrls, ComCtrls, ImgList, ExtCtrls, Buttons,
  ActnList, System.ImageList, JvAppStorage, dlgPyIDEBase,
  UModel, UUMLForm, frmEditor, System.Actions, Vcl.ToolWin,
  Vcl.BaseImageCollection, SVGIconImageCollection, Vcl.VirtualImageList,
  SpTBXEditors;

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
    ActionList: TActionList;
    ActionNew: TAction;
    ActionDelete: TAction;
    ActionClose: TAction;
    ActionApply: TAction;
    BAttributeApply: TButton;
    BMethodApply: TButton;
    BClassApply: TButton;
    BClassNew: TButton;
    CBClassInner: TCheckBox;
    CBAttributeValue: TComboBox;
    LParameterValue: TLabel;
    CBParamValue: TComboBox;
    ILClassEditor: TVirtualImageList;
    icClassEditor: TSVGIconImageCollection;
    icClassTreeView: TSVGIconImageCollection;
    vilTreeViewLight: TVirtualImageList;
    vilTreeViewDark: TVirtualImageList;
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
    procedure FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
      NewDPI: Integer);
  private
    myEditor: TEditorForm;
    myUMLForm: TFUMLForm;
    AttributeNode: TTreeNode;
    MethodNode: TTreeNode;
    ComboBoxInvalid: Boolean;
    MakeNewClass: Boolean;
    TreeViewUpdating: Boolean;
    LNGTODO: string;
    LNGSet: string;
    LNGGet: string;
    procedure NewClass;
    procedure AttributeToPython(const Attribute: TAttribute; ClassNumber, Line: Integer);
    function RGMethodKindHasChanged: Boolean;
    procedure ShowMandatoryFields;
    procedure TVClass(Classifier: TClassifier);
    procedure TVAttribute(const Attribute: TAttribute);
    procedure TVMethod(Method: TOperation);
    procedure ChangeAttribute(var A: TAttribute; CName: string);
    procedure ChangeGetSet(Attribute: TAttribute; ClassNumber: Integer; cName: string);
    function MakeAttribute(CName: string): TAttribute;
    function MakeType(CB: TComboBox): TClassifier; overload;
    function MakeType(const s: string): TClassifier; overload;
    procedure GetParameter(LB: TListBox; Method: TOperation);
    function HasMethod(const getset: string; AttributeName: string;
      var Method: TOperation): Boolean;

    function MethodToPython(Method: TOperation; Source: string): string;
    procedure DeleteMethod(Method: TOperation);
    procedure ChangeMethod(var M: TOperation);
    procedure ReplaceMethod(var Method: TOperation; const New: string);
    procedure ReplaceParameter(ClassNumber: Integer; const s1, s2: string);
    function MakeMethod: TOperation;
    function CreateMethod(const getset, datatype: string; const Attribute: TAttribute): string;
    function makeConstructor(Method: TOperation; Source: string): string;
    function Typ2Value(const typ: string): string;
    procedure MoveNode(TargetNode, SourceNode: TTreeNode);
    procedure EnableEvents(enable: Boolean);
    procedure SetEditText(E: TEdit; const s: string);
    procedure SetComboBoxValue(CB: TComboBox; const s: string);
    function MakeIdentifier(var s: string): Integer; overload;
    function MakeIdentifier(E: TEdit): Boolean; overload;
    function MakeIdentifier(CB: TComboBox): Boolean; overload;
    function GetLastLineOfLastClass: Integer;
    function GetClassNumber(Node: TTreeNode): Integer;
    function GetClassNode(ClassNumber: Integer): TTreeNode; overload;
    function GetClassNode: TTreeNode; overload;
    function GetClassName(ClassNode: TTreeNode): string;
    function GetAttributeNode: TTreeNode;
    function GetMethodNode: TTreeNode;
    function GetClassifier(ClassNode: TTreeNode): TClassifier;
    function GetAttribute(AttributeLeafNode: TTreeNode): TAttribute;
    function GetMethod(MethodLeafNode: TTreeNode): TOperation;
    function GetLevel(Node: TTreeNode): Integer;
    function GetIndent(Level: Integer): string;
    function IsClassNode(Node: TTreeNode): Boolean;
    function IsAttributesNode(Node: TTreeNode): Boolean;
    function IsAttributesNodeLeaf(Node: TTreeNode): Boolean;
    function IsMethodsNode(Node: TTreeNode): Boolean;
    function IsMethodsNodeLeaf(Node: TTreeNode): Boolean;
    procedure AllAttributesAsParameters(Node: TTreeNode);
    function AttributeAlreadyExists(const s: string): Boolean;
    function MethodAlreadyExists(const s: string): Boolean;
    procedure Init;
    function NameTypeValueChanged: Boolean;
    procedure TakeParameter;
    function StrToPythonValue(s: string): string;
    function getConstructorHead(Superclass: string): string;
    function PrepareParameter(head: string): string;
    procedure DeleteAttributeFromConstructorParameters(Node: TTreeNode;
            Attribute: TAttribute);
  protected
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    function CreateTreeView(EditForm: TEditorForm; UMLForm: TFUMLForm): Boolean;
    procedure UpdateTreeView;
    procedure ChangeStyle;
  end;

var
  FClassEditor: TFClassEditor = nil;

implementation

{$R *.dfm}

uses Windows, Math, Graphics, Messages, SysUtils, Dialogs, UITypes, Character,
     System.IOUtils, SynEdit, JvGnugettext, RegularExpressions,
     uCommonFunctions, uModelEntity,
     frmPyIDEMain, UConfiguration, UUtils, uEditAppIntfs, frmFile;

const
  CrLf = #13#10;

type
  TParamTyp = class(TObject)
  public
    typ: string;
    constructor Create(const s: string);
  end;

constructor TParamTyp.Create(const s: string);
begin
  typ:= s;
end;

procedure TFClassEditor.FormCreate(Sender: TObject);
  const Values = '0'#$D#$A'0.0'#$D#$A''''''#$D#$A'True'#$D#$A'False'#$D#$A'None'#$D#$A'[]'#$D#$A'()'#$D#$A'{}'#$D#$A'set()';
begin
  inherited;
  MakeNewClass:= False;
  TreeViewUpdating:= False;
  TreeView.Images:= vilTreeViewLight;
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
  SL:= TStringList.Create;
  for i:= 0 to GI_FileFactory.Count - 1 do
    (GI_FileFactory.FactoryFile[i].Form as TFileForm).CollectClasses(SL);
  for i:= 0 to SL.Count - 1 do begin
    st:= getShortType(SL[i]);
    ComboBoxInsert2(CBAttributeType, st);
    ComboBoxInsert2(CBMethodType, st);
    ComboBoxInsert2(CBParamType, st);
  end;
  FreeAndNil(SL);

  if not GuiPyOptions.ShowGetSetMethods then begin
    CBGetMethod.Checked:= False;
    CBSetMethod.Checked:= False;
  end;
  CBGetMethod.Visible:= GuiPyOptions.ShowGetSetMethods;
  CBSetMethod.Visible:= GuiPyOptions.ShowGetSetMethods;
  CBAttributeType.Visible:= GuiPyOptions.ShowTypeSelection;
  LAttributeType.Visible:= GuiPyOptions.ShowTypeSelection;
  if CBAttributeType.Visible then begin
    CBAttributeValue.Top:= PPIScale(220);
    LAttributeValue.Top:= PPIScale(223);
  end else begin
    CBAttributeValue.Top:= PPIScale(184);
    LAttributeValue.Top:= PPIScale(187);
  end;

  CBParamType.Visible:= GuiPyOptions.ShowParameterTypeSelection;
  LParameterType.Visible:= GuiPyOptions.ShowParameterTypeSelection;
  if CBParamType.Visible then begin
    LParameterName.Top:= PPIScale(32);
    LParameterType.Top:= PPIScale(64);
    LParameterValue.Top:= PPISCale(96);
    CBParamName.Top:= PPIScale(29);
    CBParamType.Top:= PPIScale(61);
    CBParamValue.Top:= PPIScale(93);
  end else begin
    LParameterName.Top:= PPIScale(48);
    LParameterValue.Top:= PPISCale(80);
    CBParamName.Top:= PPIScale(45);
    CBParamValue.Top:= PPIScale(77);
  end;
  if GuiPyOptions.ShowWithWithoutReturnValue
    then RGMethodKind.Items.Text:= _('constructor') + #13#10 + _('with return value') + #13#10 + _('without return value')
    else RGMethodKind.Items.Text:= _('constructor') + #13#10 + _('function') + #13#10 + _('procedure');
end;

procedure TFClassEditor.FormClose(Sender: TObject; var aAction: TCloseAction);
begin
  TreeView.OnChange:= nil;
  TreeView.Items.Clear;
  for var i:= 0 to CBParamName.Items.Count - 1 do begin
    var aObject:= CBParamName.Items.Objects[i];
    FreeAndNil(aObject);
  end;
end;

procedure TFClassEditor.TVClass(Classifier: TClassifier);
var
  Node, Anchor: TTreeNode;
  p: Integer;
  CName: string;

  function GetAnchor(s: string): TTreeNode;
  var
    Node: TTreeNode;
    s1: string;
    p: Integer;
  begin
    Result:= nil;
    Node:= TreeView.Items.GetFirstNode;
    p:= Pos('.', s);
    s1:= Copy(s, 1, p - 1);
    Delete(s, 1, p);
    while s1 <> '' do begin
      while Assigned(Node) and (Node.Text <> s1) do
        Node:= Node.getNextSibling;
      if Node = nil then
        Exit;
      Node:= Node.getFirstChild;
      p:= Pos('.', s);
      s1:= Copy(s, 1, p - 1);
      Delete(s, 1, p);
    end;
    Result:= Node;
  end;

begin
  CName:= Classifier.Name;
  p:= LastDelimiter('.', CName);
  if p = 0 then
    Anchor:= nil
  else begin
    Anchor:= GetAnchor(Copy(CName, 1, p));
    Delete(CName, 1, p);
  end;

  Node:= TreeView.Items.Add(Anchor, CName);
  Node.ImageIndex:= 0;
  Node.SelectedIndex:= 0;

  AttributeNode:= TreeView.Items.AddChild(Node, _('Attributes'));
  AttributeNode.ImageIndex:= 8;
  AttributeNode.SelectedIndex:= 8;

  MethodNode:= TreeView.Items.AddChild(Node, _('Methods'));
  MethodNode.ImageIndex:= 9;
  MethodNode.SelectedIndex:= 9;

  ComboBoxInsert2(CBAttributeType, CName);
  ComboBoxInsert2(CBMethodType, CName);
  ComboBoxInsert2(CBParamType, CName);
end;

procedure TFClassEditor.TVAttribute(const Attribute: TAttribute);
begin
  var Node:= TreeView.Items.AddChild(AttributeNode, Attribute.toNameTypeUML);
  Node.ImageIndex:= 1 + Integer(Attribute.Visibility);
  Node.SelectedIndex:= 1 + Integer(Attribute.Visibility);
end;

procedure TFClassEditor.TVMethod(Method: TOperation);
  var ImageNr: Integer;
begin
  var Node:= TreeView.Items.AddChild(MethodNode, Method.toShortStringNode);
  if Method.OperationType = otConstructor
    then ImageNr:= 4
    else ImageNr:= 5 + Integer(Method.Visibility);
  Node.ImageIndex:= ImageNr;
  Node.SelectedIndex:= ImageNr;
end;

function TFClassEditor.getConstructorHead(Superclass: string): string;
begin
  Result:= '';
  var Line:= myEditor.getLineNumberWithWord('class ' + Superclass);
  if Line = -1 then begin
    var SL:= FConfiguration.getClassesAndFilename(myEditor.Pathname);
    try
      var p:= SL.IndexOfName(Superclass);
      if p >= 0 then begin
        var FileName:= SL.ValueFromIndex[p];
        SL.LoadFromFile(TPath.Combine(ExtractFilePath(myEditor.Pathname), FileName));
        for var i:= 0 to SL.Count -1 do begin
          p:= Pos('class ' + Superclass, SL[i]);
          if p > 0 then begin
            for var j:= i+1 to SL.Count - 1 do begin
              p:= Pos('def __init__(self', SL[j]);
              if p > 0 then
                Exit(Trim(SL[j]));
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(SL);
    end;
  end else begin
    Line:= myEditor.getLineNumberWithWordFromTill('def __init__(self', Line);
    if Line > -1 then
      Result:= Trim(myEditor.ActiveSynEdit.Lines[Line]);
  end;
end;

function TFClassEditor.PrepareParameter(head: string): string;
begin
  Delete(head, 1, Length('def __init__('));
  var p:= Pos('):', head);
  head:= Copy(head, 1, p-1);
  var SL:= Split(',', head);
  head:= '';
  SL.Delete(0); // self
  for var i:= 0 to SL.Count -1 do begin
    var s1:= SL[i];
    p:= Pos(':', s1);
    if p > 0 then
      Delete(s1, p, Length(s1));
    s1:= Trim(s1);
    if head = ''
      then head:= s1
      else head:= head + ', ' + s1;
  end;
  FreeAndNil(SL);
  Result:= head;
end;

procedure TFClassEditor.NewClass;
var
  Indent1, Indent2, s: string;
  Line, p1, p2, p3, p4: Integer;

  function MakeInner(s: string): string;
  begin
    var SL:= TStringList.Create;
    SL.Text:= s;
    for var i:= 0 to SL.Count - 1 do
      SL[i]:= Indent1 + SL[i];
    Result:= SL.Text;
    FreeAndNil(SL);
  end;

begin
  MakeNewClass:= False;
  Indent1:= GetIndent(0);
  Indent2:= GetIndent(1);
  if CBClassInner.Checked then begin
    Indent1:= GetIndent(1);
    Indent2:= GetIndent(2);
  end;
  s:= FConfiguration.getClassCodeTemplate;
  p1:= Pos('class ', s);
  p2:= Pos(':', s);
  p3:= Pos('__init__', s);
  p4:= Pos('pass', s);
  if (p1 > 0) and (p2 > p1) and (p3 > p2) and (p4 > p3) then begin
    Delete(s, p1, p2 - p1);
    var cls:= EClass.Text;
    if EExtends.Text <> '' then
      cls:= cls + '(' + EExtends.Text + ')';
    insert('class ' + cls, s, p1);
  end else begin
    s:= CrLf + Indent1 + 'class ' + EClass.Text;
    if EExtends.Text <> '' then
      s:= CrLf + CrLf + s + '(' + EExtends.Text + ')';
    s:= s + ':' + CrLf;
    s:= s + Indent2 + CrLf +
            Indent2 + 'def __init__(self):' + CrLf +
            Indent2 + Indent1 + 'pass' + CrLf + CrLf;
  end;
  if EExtends.Text <> '' then begin
    var head:= getConstructorHead(EExtends.Text);
    if head <> '' then begin
      s:= myStringReplace(s, 'def __init__(self):', head);
      head:= prepareParameter(head);
      s:= myStringReplace(s, 'pass', 'super().__init__(' + head + ')');
    end;
  end;
  if CBClassInner.Checked then
    s:= MakeInner(s);
  Line:= GetLastLineOflastClass;
  myEditor.InsertLinesAt(Line + 1, sLineBreak + s);
  myEditor.Modified:= True;
  UpdateTreeView;
  TreeView.Selected:= TreeView.Items[TreeView.Items.Count - 3];
  TreeViewChange(Self, TreeView.Selected);
end;

procedure TFClassEditor.BClassChangeClick(Sender: TObject);
var
  s, Searchtext, ReplaceText, tail,
  newClassname, oldClassname, Indent: string;
  SkipUpdate: Boolean;
  p, NodeIndex, i: Integer;
  Node: TTreeNode;
  SL: TStringList;
begin
  if Trim(EClass.Text) = '' then
    Exit;
  if MakeNewClass then
    NewClass
  else begin
    Node:= TreeView.Selected;
    if not Assigned(Node) then
      Exit;
    Indent:= GetIndent(2);
    if CBClassInner.Checked then
      Indent:= GetIndent(3);
    LockFormUpdate(myEditor);
    myEditor.ActiveSynEdit.BeginUpdate;
    oldClassname:= Node.Text;
    NodeIndex:= Node.AbsoluteIndex;
    newClassname:= Trim(EClass.Text);
    Searchtext:= 'class ' + oldClassname;
    ReplaceText:= 'class ' + newClassname;
    with myEditor do begin
      GotoWord(Searchtext);
      s:= ActiveSynEdit.LineText;
      s:= myStringReplace(s, Searchtext, ReplaceText);

      p:= Length(s);
      while (p > 0) and (s[p] <> ':') do
        Dec(p);
      if p > 0 then begin
        tail:= Copy(s, p + 1, Length(s));
        s:= Copy(s, 1, p - 1);
      end else
        tail:= '';

      p:= Pos('(', s);
      if p > 0 then
        s:= Copy(s, 1, p - 1);
      s:= Trim(s);
      SkipUpdate:= False;

      if EExtends.Text <> '' then begin
        SL:= Split(',', EExtends.Text);
        for i:= SL.Count - 1 downto 0 do
          if Trim(SL[i]) = '' then begin
            SL.Delete(i);
            SkipUpdate:= True;
          end;
        if SL.Count > 0 then begin
          s:= s + '(' + Trim(SL[0]);
          for i:= 1 to SL.Count - 1 do
            s:= s + ', ' + Trim(SL[i]);
          s:= s + ')';
        end;
        FreeAndNil(SL);
      end;
      s:= s + ':' + tail;
      ActiveSynEdit.LineText:= s;

      if EExtends.Text <> '' then begin
        var line:= myEditor.getLineNumberWithWord('class ' + newClassname);
        if line > -1 then begin
          Line:= myEditor.getLineNumberWithWordFromTill('def __init__(self', Line);
          if Line > -1 then begin
            s:= myEditor.ActiveSynEdit.Lines[Line];
            var head:= getConstructorHead(EExtends.Text);
            if head <> '' then
              s:= myStringReplace(s, 'def __init__(self):', head);
            myEditor.ActiveSynEdit.Lines[Line]:= s;
            s:= myEditor.ActiveSynEdit.Lines[Line + 1];
            if Pos('super().__init__', s) = 0 then begin
              head:= PrepareParameter(head);

              s:= Indent + 'super().__init__(' + head + ')';
              s:= FConfiguration.Indent2 + 'super().__init__(' + head + ')';
              myEditor.ActiveSynEdit.Lines.Insert(Line+1, s);
            end;
          end;
        end;
      end;

      Modified:= True;
      if SkipUpdate = False then begin
        UpdateTreeView;
        if NodeIndex < TreeView.Items.Count then
          TreeView.Selected:= TreeView.Items[NodeIndex];
      end;
    end;
    myEditor.ActiveSynEdit.EndUpdate;
    UnlockFormUpdate(myEditor);
  end;
  BClassApply.Enabled:= False;
end;

function TFClassEditor.HasMethod(const getset: string; AttributeName: string;
  var Method: TOperation): Boolean;
var
  cent: TClassifier;
  MethodName: string;
  Params1, Params2: Integer;
begin
  Method:= nil;
  if GuiPyOptions.GetSetMethodsAsProperty then
    MethodName:= AttributeName
  else if getset = _(LNGGet)
    then MethodName:= _(LNGGet) + '_' + AttributeName
    else MethodName:= _(LNGSet) + '_' + AttributeName;
  if getset = _(LNGGet)
    then Params1:= 1
    else Params1:= 2;
  cent:= GetClassifier(GetClassNode);
  if Assigned(cent) then begin
    var it1:= cent.GetOperations;
    while it1.HasNext do begin
      Method:= it1.Next as TOperation;
      if Method.Name = MethodName then begin
        Params2:= 0;
        var it2:= Method.GetParameters;
        while it2.HasNext do begin
          Inc(Params2);
          it2.Next;
        end;
        if Params1 = Params2 then
          Exit(True);
      end;
    end;
  end;
  Method:= nil;
  Result:= False;
end;

procedure TFClassEditor.EnableEvents(enable: Boolean);
begin
  if enable and not myEditor.ActiveSynEdit.ReadOnly then begin
    // EClass.OnChange:= @BClassChangeClick;
    // EExtends.OnChange:=  @BClassChangeClick;

    RGAttributeAccess.OnClick:= BAttributeChangeClick;
    CBAttributeStatic.OnClick:= BAttributeChangeClick;
    CBAttributeFinal.OnClick:= BAttributeChangeClick;
    CBgetMethod.OnClick:= BAttributeChangeClick;
    CBsetMethod.OnClick:= BAttributeChangeClick;

    RGMethodKind.OnClick:= BMethodChangeClick;
    RGMethodAccess.OnClick:= BMethodChangeClick;
    CBMethodStatic.OnClick:= BMethodChangeClick;
    CBMethodClass.OnClick:= BMethodChangeClick;
    CBMethodAbstract.OnClick:= BMethodChangeClick;
  end else begin
    EClass.OnChange:= nil;
    EExtends.OnChange:= nil;

    RGAttributeAccess.OnClick:= nil;
    CBAttributeStatic.OnClick:= nil;
    CBAttributeFinal.OnClick:= nil;
    CBgetMethod.OnClick:= nil;
    CBsetMethod.OnClick:= nil;

    RGMethodKind.OnClick:= nil;
    RGMethodAccess.OnClick:= nil;
    CBMethodStatic.OnClick:= nil;
    CBMethodClass.OnClick:= nil;
    CBMethodAbstract.OnClick:= nil;
  end;
end;

function TFClassEditor.GetClassNumber(Node: TTreeNode): Integer;
begin
  Result:= -1;
  var aNode:= TreeView.Items.GetFirstNode;
  while aNode <> Node do begin
    if IsClassNode(aNode) then
      Inc(Result);
    aNode:= aNode.GetNext;
  end;
end;

function TFClassEditor.GetClassNode(ClassNumber: Integer): TTreeNode;
begin
  var aNode:= TreeView.Items.GetFirstNode;
  while aNode <> nil do begin
    if IsClassNode(aNode) then begin
      Dec(ClassNumber);
      if ClassNumber = -1 then
        Exit(aNode);
    end;
    aNode:= aNode.GetNext;
  end;
  Result:= nil;
end;

function TFClassEditor.GetLastLineOfLastClass: Integer;
begin
  Result:= -1;
  myEditor.ParseAndCreateModel;
  var Ci:= myEditor.Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    var cent:= TClassifier(Ci.Next);
    Result:= Max(Result, cent.LineE);
  end;
end;

function TFClassEditor.GetClassNode: TTreeNode;
begin
  // we may have multiple classes in the treeview
  Result:= TreeView.Selected;
  if Assigned(Result) then
    while (Result <> nil) and (Result.ImageIndex <> 0) do
      Result:= Result.Parent
  else
    for var i:= 0 to TreeView.Items.Count - 1 do
      if TreeView.Items[i].ImageIndex = 0 then begin
        Result:= TreeView.Items[i];
        Break;
      end;
end;

function TFClassEditor.GetClassName(ClassNode: TTreeNode): string;
begin
  // we may have multilevel inner classes in the treeview
  if Assigned(ClassNode) then begin
    Result:= ClassNode.Text;
    while ClassNode.Parent <> nil do begin
      ClassNode:= ClassNode.Parent;
      Result:= ClassNode.Text + '.' + Result;
    end;
  end else
    Result:= '';
end;

function TFClassEditor.GetAttributeNode: TTreeNode;
begin
  Result:= GetClassNode;
  if Assigned(Result) then
    Result:= Result.getFirstChild;
end;

function TFClassEditor.GetMethodNode: TTreeNode;
begin
  Result:= GetAttributeNode;
  if Assigned(Result) then
    Result:= Result.getNextSibling;
end;

function TFClassEditor.GetClassifier(ClassNode: TTreeNode): TClassifier;
begin
  var FullClassname:= GetClassName(ClassNode);
  var Ci:= myEditor.Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    Result:= TClassifier(Ci.Next);
    if Result.Name = FullClassname then
      Exit(Result);
  end;
  Result:= nil;
end;

function TFClassEditor.GetAttribute(AttributeLeafNode: TTreeNode): TAttribute;
begin
  var cent:= GetClassifier(AttributeLeafNode.Parent.Parent);
  if Assigned(cent) then begin
    var it:= cent.GetAttributes;
    while it.HasNext do begin
      Result:= TAttribute(it.Next);
      if Result.toNameTypeUML = AttributeLeafNode.Text then
        Exit(Result);
    end;
  end;
  Result:= nil;
end;

function TFClassEditor.GetMethod(MethodLeafNode: TTreeNode): TOperation;
begin
  var cent:= GetClassifier(MethodLeafNode.Parent.Parent);
  if Assigned(cent) then begin
    var it:= cent.GetOperations;
    while it.HasNext do begin
      Result:= TOperation(it.Next);
      if Result.toShortStringNode = MethodLeafNode.Text then
        Exit(Result);
    end;
  end;
  Result:= nil;
end;

function TFClassEditor.GetLevel(Node: TTreeNode): Integer;
  var ClassNode: TTreeNode;
begin
  if Node = nil then
    Exit(0);
  Result:= 0;
  if IsClassNode(Node) then
    ClassNode:= Node
  else if IsAttributesNode(Node) or IsMethodsNode(Node) then
    ClassNode:= Node.Parent
  else ClassNode:= Node.Parent.Parent;
  while ClassNode.Parent <> nil do begin
    Result:= Result + 1;
    ClassNode:= ClassNode.Parent;
  end;
end;

function TFClassEditor.GetIndent(Level: Integer): string;
begin
  Result:= StringTimesN(FConfiguration.Indent1, Level);
end;

procedure TFClassEditor.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  aClassifier: TClassifier;
  aAttribute: TAttribute;
  aMethod: TOperation;
  Line: Integer;
  s: string;
begin
  if Node = nil then Exit;
  Line:= -1;
  EnableEvents(False);
  try
    if IsClassNode(Node) then begin
      PageControl.ActivePageIndex:= 0;
      aClassifier:= GetClassifier(Node);
      if Assigned(aClassifier) then begin
        EClass.Text:= Node.Text;
        CBClassInner.Checked:= (aClassifier.Level > 0);
        s:= (aClassifier as TClass).AncestorsAsString;
        SetEditText(EExtends, s);
        Line:= aClassifier.LineS;
      end;
    end else if IsAttributesNode(Node) or IsAttributesNodeLeaf(Node) then begin
      PageControl.ActivePageIndex:= 1;
      BAttributeApply.Enabled:= False;
      if IsAttributesNodeLeaf(Node) then begin
        aAttribute:= GetAttribute(Node);
        if Assigned(aAttribute) then begin
          SetEditText(EAttributeName, aAttribute.Name);
          if Assigned(aAttribute.TypeClassifier)
            then CBAttributeType.Text:= aAttribute.TypeClassifier.asUMLType
            else CBAttributeType.Text:= '';
          SetComboBoxValue(CBAttributeValue, aAttribute.Value);
          RGAttributeAccess.ItemIndex:= Integer(aAttribute.Visibility);
          if CBgetMethod.Visible then
            CBgetMethod.Checked:= HasMethod(_(LNGGet), aAttribute.Name, aMethod);
          if CBsetMethod.Visible then
            CBsetMethod.Checked:= HasMethod(_(LNGSet), aAttribute.Name, aMethod);
          CBAttributeStatic.Checked:= aAttribute.Static;
          CBAttributeFinal.Checked:= aAttribute.IsFinal;
          Line:= aAttribute.LineS;
        end;
      end else begin
        CBAttributeType.Text:= '';
        CBAttributeType.ItemIndex:= -1;
        CBAttributeValue.Text:= '';
        CBAttributeValue.ItemIndex:= -1;
        ActiveControl:= EAttributeName;
        EAttributeName.Text:= '';
      end;
      ComboBoxInsert(CBAttributeType);
    end else begin
      PageControl.ActivePageIndex:= 2;
      BMethodApply.Enabled:= False;
      AllAttributesAsParameters(Node);
      if IsMethodsNodeLeaf(Node) then begin
        EClass.Text:= Node.Parent.Parent.Text; // wg. constructor
        aMethod:= GetMethod(Node);
        if Assigned(aMethod) then begin
          CBMethodName.Text:= aMethod.Name;
          if Assigned(aMethod.ReturnValue)
            then CBMethodType.Text:= aMethod.ReturnValue.asUMLType
            else CBMethodType.Text:= '';
          RGMethodKind.ItemIndex:= Integer(aMethod.OperationType);
          RGMethodAccess.ItemIndex:= Integer(aMethod.Visibility);
          CBMethodStatic.Checked:= aMethod.isStaticMethod;
          CBMethodClass.Checked:= aMethod.isClassMethod;
          CBMethodAbstract.Checked:= aMethod.IsAbstract;
          GetParameter(LBParams, aMethod);
          Line:= aMethod.LineS;
        end;
      end else begin
        EClass.Text:= Node.Parent.Text; // wg. constructor
        RGMethodKind.ItemIndex:= 1; // wg. constructor
        CBMethodName.Text:= '';
        CBMethodType.Text:= '';
        CBMethodType.ItemIndex:= -1;
        CBParamName.Text:= '';
        CBParamType.Text:= '';
        CBParamType.ItemIndex:= -1;
        CBMethodStatic.Checked:= False;
        CBMethodClass.Checked:= False;
        CBMethodAbstract.Checked:= False;
        LBParams.Clear;
        if RGMethodKind.ItemIndex > 0 then begin
          CBMethodName.Enabled:= True;
          ActiveControl:= CBMethodName;
        end;
      end;
      ComboBoxInsert(CBMethodType);
      ComboBoxInsert(CBParamName);
      ComboBoxInsert(CBParamType);
      CBMethodName.Enabled:= (RGMethodKind.ItemIndex > 0);
      CBMethodType.Enabled:= (RGMethodKind.ItemIndex = 1);
    end;
  finally
    if IsAttributesNode(Node) or IsMethodsNode(Node) then
      if myEditor.ActiveSynEdit.ReadOnly
        then Line:= -1
        else Line:= myEditor.ActiveSynEdit.CaretY;
    if Line <> -1 then
      myEditor.GotoLine(Line);
    ShowMandatoryFields;
    EnableEvents(True);
  end;
end;

procedure TFClassEditor.SetEditText(E: TEdit; const s: string);
begin
  if E.Text <> s then begin
    var p:= E.SelStart;
    E.Text:= s;
    E.SelStart:= p;
  end;
end;

procedure TFClassEditor.SetComboBoxValue(CB: TComboBox; const s: string);
begin
  if CB.Text <> s then begin
    var p:= CB.SelStart;
    if (Pos('''', s) > 0) and (Pos('''', CB.Text) = 0) then
      Inc(p);
    CB.Text:= s;
    CB.SelStart:= p;
  end;
end;

procedure TFClassEditor.GetParameter(LB: TListBox; Method: TOperation);
var
  It2: IModelIterator;
  Parameter: TParameter;
  s: string;
  i: Integer;

  function asUMLType(aType: string): string;
  begin
    Result:= aType;
    if aType = 'bool' then
      Result:= 'boolean'
    else if aType = 'str' then
      Result:= 'String'
    else if aType = 'int' then
      Result:= 'integer';
  end;

begin
  LB.Clear;
  It2:= Method.GetParameters;
  while It2.HasNext do begin
    Parameter:= It2.Next as TParameter;
    if (Parameter.Name = 'self') or (Parameter.Name = 'cls') then
      Continue;
    s:= Parameter.Name;
    if Assigned(Parameter.TypeClassifier) then
      s:= s + ': ' + Parameter.TypeClassifier.asUMLType;
    if Parameter.Value <> '' then
      s:= s + ' = ' + Parameter.Value;
    LB.Items.Add(s);
  end;
  if CBParamType.Text <> ''
    then s:= CBParamName.Text + ': ' + asUMLType(CBParamType.Text)
    else s:= CBParamName.Text;
  i:= LB.Items.IndexOf(s);
  if i <> -1 then
    LB.Items.Delete(i);
end;

procedure TFClassEditor.PageControlChange(Sender: TObject);
  var Node: TTreeNode;
begin
  var tab:= PageControl.TabIndex;
  if BClassApply.Enabled then BClassChangeClick(Sender)
  else if BAttributeApply.Enabled then BAttributeChangeClick(Sender)
  else if BMethodApply.Enabled then BMethodChangeClick(Sender);
  PageControl.TabIndex:= tab;
  case PageControl.TabIndex of
    0: Node:= GetClassNode;
    1: Node:= GetAttributeNode;
  else begin
       Node:= GetMethodNode;
       AllAttributesAsParameters(Node);
       end;
  end;
  TreeView.Selected:= Node;
end;

procedure TFClassEditor.ActionNewExecute(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    1: begin
        EAttributeName.Text:= '';
        CBAttributeType.Text:= '';
        CBAttributeValue.Text:= '';
        TreeView.Selected:= GetAttributeNode;
        CBAttributeStatic.Checked:= False;
        CBAttributeFinal.Checked:= False;
        if GuiPyOptions.DefaultModifiers then
          RGAttributeAccess.ItemIndex:= 0;
        CBgetMethod.Checked:= GuiPyOptions.GetMethodChecked;
        CBsetMethod.Checked:= GuiPyOptions.SetMethodChecked;
      end;
    2: begin
        CBMethodName.Text:= '';
        CBMethodType.Text:= '';
        CBParamName.Text:= '';
        CBParamType.Text:= '';
        CBParamValue.Text:= '';
        LBParams.Items.Clear;
        CBParameter.Text:= _('Select attribute');
        TreeView.Selected:= GetMethodNode;
        CBMethodStatic.Checked:= False;
        CBMethodClass.Checked:= False;
        CBMethodAbstract.Checked:= False;
        if GuiPyOptions.DefaultModifiers then begin
          RGMethodKind.ItemIndex:= 1;
          RGMethodAccess.ItemIndex:= 2;
        end;
      end;
    else begin
        EClass.Text:= '';
        EExtends.Text:= '';
        CBClassInner.Checked:= False;
        if Assigned(TreeView.Selected) then
          TreeView.Selected.Selected:= False;
        MakeNewClass:= True;
      end;
  end;
end;

procedure TFClassEditor.AttributeToPython(const Attribute: TAttribute; ClassNumber, Line: Integer);
  var Method: TOperation; datatype: string;
begin
  // due to unexpected loss of datatype when transferred with parameter Attribute
  if Assigned(Attribute.TypeClassifier)
    then datatype:= Attribute.TypeClassifier.asType
    else datatype:= '';
  myEditor.ActiveSynEdit.BeginUpdate;
  myEditor.InsertLinesAt(Line, Attribute.toPython(False));
  if CBgetMethod.Checked and not HasMethod(_(LNGGet), Attribute.Name, Method) then
    myEditor.InsertProcedure(CrLf + CreateMethod(_(LNGGet), datatype, Attribute), ClassNumber);
  if CBsetMethod.Checked and not HasMethod(_(LNGSet), Attribute.Name, Method) then
    myEditor.InsertProcedure(CrLf + CreateMethod(_(LNGSet), datatype, Attribute), ClassNumber);
  myEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.ChangeGetSet(Attribute: TAttribute; ClassNumber: Integer; CName: string);
var
  NewGet, NewSet, datatype: string;
  Method1, Method2: TOperation;
  getIsFirst: Boolean;

  procedure DoGet;
  begin
    if CBgetMethod.Checked then
      if Assigned(Method1)
        then ReplaceMethod(Method1, NewGet)
        else myEditor.InsertProcedureWithoutParse(CrLf + NewGet, ClassNumber)
    else if Assigned(Method1) then
      DeleteMethod(Method1);
  end;

  procedure DoSet;
  begin
    if CBsetMethod.Checked then
      if Assigned(Method2)
        then ReplaceMethod(Method2, NewSet)
        else myEditor.InsertProcedureWithoutParse(CrLf + NewSet, ClassNumber)
    else if Assigned(Method2) then
      DeleteMethod(Method2);
  end;

begin
  // replace get/set-methods, names could be changed
  HasMethod(_(LNGGet), Attribute.Name, Method1);
  HasMethod(_(LNGSet), Attribute.Name, Method2);
  getIsFirst:= True;
  if Assigned(Method1) and Assigned(Method2) and
    (Method1.LineS > Method2.LineS) then
    getIsFirst:= False;
  ChangeAttribute(Attribute, CName);
  if Assigned(Attribute.TypeClassifier)
    then datatype:= Attribute.TypeClassifier.asType
    else datatype:= '';

  NewGet:= CreateMethod(_(LNGGet), datatype, Attribute);
  NewSet:= CreateMethod(_(LNGSet), datatype, Attribute);
  if getIsFirst then begin
    DoSet;
    DoGet;
  end else begin
    DoGet;
    DoSet;
  end;
end;

function TFClassEditor.NameTypeValueChanged: Boolean;
begin
  var Node:= TreeView.Selected;
  if Assigned(Node) then begin
    var s:= EAttributeName.Text + ': ' + CBAttributeType.Text;
    if CBAttributeValue.Text <> '' then
      s:= s + ' = ' + CBAttributeValue.Text;
    Result:= (Node.Text <> s)
  end else
    Result:= False;
end;

procedure TFClassEditor.BAttributeChangeClick(Sender: TObject);
  const
    Values = '|0|0.0|''''|True|False|None|[]|()|{}|set()|';
    Types  = '|int|integer|float|boolean|bool|str|String|string|list|tuple|dict|set|';

  var
    Old, New, OldName, NewNameTypeUML, OldVisName, OldNameType, newType: string;
    ClassNumber, NodeIndex, TopItemIndex, Line: Integer;
    Attribute: TAttribute;
    Node: TTreeNode;
    OldStatic, ValueChanged, TypeChanged: Boolean;

  function asUMLType(s: string): string;
  begin
    Result:= s;
    if Result = 'bool' then
      Result:= 'boolean'
    else if Result = 'str' then
      Result:= 'String'
    else if Result = 'int' then
      Result:= 'integer';
  end;

begin
  Node:= TreeView.Selected;
  if (Node = nil) or (EAttributeName.Text = '') or not MakeIdentifier(EAttributeName) then
    Exit;
  ClassNumber:= GetClassNumber(Node);
  TopItemIndex:= TreeView.TopItem.AbsoluteIndex;
  NodeIndex:= Node.AbsoluteIndex;

  myEditor.ActiveSynEdit.BeginUpdate;
  if IsAttributesNode(Node) then begin
    NodeIndex:= NodeIndex + Node.Count + 1;
    Attribute:= MakeAttribute(Node.Parent.Text);
    Attribute.Level:= GetLevel(Node);
    NewNameTypeUML:= Attribute.Name;
    if AttributeAlreadyExists(Attribute.Name) then
      ErrorMsg(Format(_('%s already exists'), [Attribute.Name]))
    else begin
      Line:= myEditor.getLastConstructorLine(ClassNumber);
      AttributeToPython(Attribute, ClassNumber, Line);
      myEditor.removePass(ClassNumber);
    end;
    FreeAndNil(Attribute);
  end else begin
    Attribute:= GetAttribute(Node);
    if Assigned(Attribute) then begin
      ValueChanged:= CBAttributeValue.Text <> Attribute.Value;
      TypeChanged:= Assigned(Attribute.TypeClassifier) and
                    (asUMLType(CBAttributeType.Text) <> Attribute.TypeClassifier.asUMLType);
      OldName:= Attribute.Name;
      OldVisName:= Attribute.VisName;
      OldNameType:= Attribute.toNameType;
      OldStatic:= Attribute.Static;
      Old:= Attribute.toPython(False);
      // changed to a value of another standard type then change type too
      if ValueChanged and Assigned(Attribute.TypeClassifier) and
         (Pos('|' + Attribute.TypeClassifier.asType + '|', Types) > 0) then begin
        newType:= Attribute.TypeClassifier.ValueToType(CBAttributeValue.Text);
        if newType <> Attribute.TypeClassifier.asType then begin
          if newType = ''
            then Attribute.TypeClassifier:= nil
            else Attribute.TypeClassifier:= MakeType(newType);
          CBAttributeType.Text:= newType;
          TypeChanged:= True;
        end;
      end;
      ChangeGetSet(Attribute, ClassNumber, Node.Parent.Parent.Text);
      if (Attribute.Name <> OldName) and AttributeAlreadyExists(Attribute.Name) then
        ErrorMsg(Format(_('%s already exists'), [Attribute.Name]))
      else begin
        New:= Attribute.toPython(TypeChanged);
        NewNameTypeUML:= Attribute.toNameTypeUML;
        if CBAttributeValue.Text <> '' then
          CBAttributeValue.Text:= Attribute.Value;
        if CBAttributeType.Text <> '' then
          CBAttributeType.Text:= Attribute.TypeClassifier.Name;
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
          myEditor.ReplaceWord(OldName, Attribute.Name, True);
          myEditor.ReplaceWord('self.' + OldVisName, 'self.' + Attribute.VisName, True);
          ReplaceParameter(ClassNumber, OldNameType, Attribute.toNameType);
        end;
      end;
    end;
  end;
  myEditor.ActiveSynEdit.EndUpdate;
  UpdateTreeView;
  Node:= GetClassNode(ClassNumber);
  if Assigned(Node) then begin
    Node:= Node.getFirstChild.getFirstChild;
    while Assigned(Node) and (Node.Text <> NewNameTypeUML) do
      Node:= Node.GetNext;
    if Assigned(Node) then
      NodeIndex:= Node.AbsoluteIndex;
  end;
  if (0 <= TopItemIndex) and (TopItemIndex < TreeView.Items.Count) then
    TreeView.TopItem:= TreeView.Items[TopItemIndex];
  if (0 <= NodeIndex) and (NodeIndex < TreeView.Items.Count) then
    TreeView.Selected:= TreeView.Items[NodeIndex];
  BAttributeApply.Enabled:= False;
end;

procedure TFClassEditor.ReplaceParameter(ClassNumber: Integer; const s1, s2: string);
  var Node: TTreeNode; Methodname, s: string; aClass: TClass; LineNr: Integer;

  function ReplaceWord(s, s1, s2: string): string;
    var ws1, RegExExpr: string;
        RegEx: TRegEx; Matches: TMatchCollection; Group: TGroup;
  begin
    RegExExpr:= '\b(' + TRegEx.Escape(s1) + ')';
    if not isWordBreakChar(s1[Length(s1)]) then
      RegExExpr:= RegExExpr + '\b';
    RegEx := CompiledRegEx(RegExExpr);

    ws1:= s;
    Matches:= RegEx.Matches(ws1);
    for var i:= Matches.Count - 1 downto 0 do begin
      Group:= Matches.Item[i].Groups[1];
      Delete(ws1, Group.Index, Group.Length);
      insert(s2, ws1, Group.Index);
    end;
    Result:= ws1;
  end;

begin
  aClass:= myEditor.getClass(ClassNumber);
  if aClass = nil then Exit;
  Node:= GetClassNode(ClassNumber);
  if Node = nil then Exit;
  Node:= Node.getFirstChild.getNextSibling.getFirstChild;  // first method
  while Assigned(Node) do begin
    case Node.ImageIndex of
      5   : Methodname:= '__';
      6   : Methodname:= '_';
      4, 7: Methodname:= '';
    end;
    Methodname:= Methodname + Copy(Node.Text, 1, Pos('(', Node.Text) - 1);
    LineNr:= myEditor.getLineNumberWithWordFromTill(MethodName, aClass.LineS, aClass.LineE);
    if LineNr > -1 then begin
      s:= myEditor.ActiveSynEdit.Lines[LineNr];
      if (Pos(s2, s) = 0) or (Pos(': ', s2) = 0) then begin
        // setter already done or change to None/no type
        myEditor.ActiveSynEdit.Lines[LineNr]:= ReplaceWord(s, s1, s2);
        myEditor.Modified:= True;
      end;
    end;
    Node:= Node.getNextSibling;
  end;
end;

procedure TFClassEditor.DeleteMethod(Method: TOperation);
begin
  myEditor.ActiveSynEdit.BeginUpdate;
  myEditor.DeleteBlock(Method.LineS - 1, Method.LineE - 1);
  var i:= Method.LineS - 1;
  if Method.hasComment then begin
    myEditor.DeleteBlock(Method.Documentation.LineS - 1, Method.Documentation.LineE - 1);
    i:= Method.Documentation.LineS - 1;
  end;
  myEditor.DeleteEmptyLine(i - 1);
  myEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.BAttributeDeleteClick(Sender: TObject);
var
  Attribute: TAttribute;
  Method1, Method2: TOperation;
  p1, p2, p3, ClassNumber: Integer;
  Node: TTreeNode;
begin
  Node:= TreeView.Selected;
  if Assigned(Node) and IsAttributesNodeLeaf(Node) then begin
    LockFormUpdate(myEditor);
    myEditor.ActiveSynEdit.BeginUpdate;
    Attribute:= GetAttribute(Node);
    HasMethod(_(LNGGet), Attribute.Name, Method1);
    HasMethod(_(LNGSet), Attribute.Name, Method2);
    if Assigned(Method1) and Assigned(Method2) then begin
      if Method1.LineS < Method2.LineS then begin
        DeleteMethod(Method2);
        DeleteMethod(Method1)
      end else begin
        DeleteMethod(Method1);
        DeleteMethod(Method2)
      end;
    end else begin
      if Assigned(Method1) then
        DeleteMethod(Method1);
      if Assigned(Method2) then
        DeleteMethod(Method2);
    end;
    ClassNumber:= GetClassNumber(Node);
    myEditor.DeleteAttributeCE('self.' + Attribute.VisName, ClassNumber);
    DeleteAttributeFromConstructorParameters(Node, Attribute);
    p1:= TreeView.Selected.AbsoluteIndex;
    p2:= TreeView.FindNextToSelect.AbsoluteIndex;
    p3:= TreeView.TopItem.AbsoluteIndex;
    UpdateTreeView;
    if (0 <= p3) and (p3 < TreeView.Items.Count) then
      TreeView.TopItem:= TreeView.Items[p3];
    p1:= Min(p1, p2);
    if (0 <= p1) and (p1 < TreeView.Items.Count) then
      TreeView.Selected:= TreeView.Items[p1];
    BAttributeApply.Enabled:= False;
    myEditor.ActiveSynEdit.EndUpdate;
    UnLockFormUpdate(myEditor);
  end;
end;

procedure TFClassEditor.DeleteAttributeFromConstructorParameters(Node: TTreeNode;
            Attribute: TAttribute);
begin
  var Parameter:= Attribute.Name;
  if Assigned(Attribute.TypeClassifier) then
    Parameter:= Parameter + ': ' + Attribute.TypeClassifier.asUMLType;
  while Assigned(Node) and (Pos('__init__', Node.Text) = 0) do
    Node:= Node.getNext;
  if Assigned(Node) then begin
    var p:= Pos(', ' + Parameter + ',', Node.Text) + Pos(', ' + Parameter + ')', Node.Text);
    if p > 0 then begin
      var Operation:= GetMethod(Node);
      var s:= Node.Text;
      Delete(s, p, 2 + Length(Parameter));
      Node.Text:= s;
      if Assigned(Operation) then begin
        var oldHead:= Operation.HeadToPython;
        Operation.DelParameter(Attribute.Name);
        var newHead:= Operation.HeadToPython;
        myEditor.ReplaceLine(oldHead, newHead);
      end;
    end;
  end;
end;

procedure TFClassEditor.BMethodDeleteClick(Sender: TObject);
var
  Node: TTreeNode;
  Method: TOperation;
  SL: TStringList;
  p: Integer;
  s: string;
  hasSourceCode: Boolean;
begin
  Node:= TreeView.Selected;
  if Assigned(Node) and IsMethodsNodeLeaf(Node) then begin
    LockFormUpdate(myEditor);
    myEditor.ActiveSynEdit.BeginUpdate;
    Method:= GetMethod(Node);
    hasSourceCode:= False;
    if Method.hasSourceCode then begin
      SL:= TStringList.Create;
      try
        SL.Text:= myEditor.getSource(Method.LineS, Method.LineE - 2);
        for p:= SL.Count - 1 downto 0 do begin
          s:= Trim(SL[p]);
          if (Pos('return', s) = 1) or (s = '') or (s = _(LNGTODO)) then
            SL.Delete(p);
        end;
        hasSourceCode:= (SL.Count > 0);
      finally
        SL.Free;
      end;
    end;

    if not hasSourceCode or
      (StyledMessageDlg(Format(_('Method %s contains source code.'), [Method.Name]) + #13 +
       _('Delete method with source code?'), mtConfirmation, mbYesNoCancel, 0) = mrYes) then begin
      DeleteMethod(Method);
      myEditor.Modified:= True;
      p:= Node.AbsoluteIndex;
      UpdateTreeView;
      if p = TreeView.Items.Count then
        Dec(p);
      TreeView.Selected:= TreeView.Items[p];
      BMethodApply.Enabled:= False;
    end;
    myEditor.ActiveSynEdit.EndUpdate;
    UnLockFormUpdate(myEditor);
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
  if Assigned(myEditor) then
    myEditor.DoSave;
 // if assigned(myUMLForm) then
 //   myUMLForm.Refresh;
end;

procedure TFClassEditor.ActionDeleteExecute(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1
    then BAttributeDeleteClick(Sender)
    else BMethodDeleteClick(Sender);
end;

function TFClassEditor.CreateMethod(const getset, datatype: string;
  const Attribute: TAttribute): string;
var
  s, Indent1, Indent2, aName: string;
begin
  Indent1:= GetIndent(Attribute.Level + 1);
  Indent2:= GetIndent(Attribute.Level + 2);
  aName:= Attribute.Name;

  if GuiPyOptions.GetSetMethodsAsProperty then begin
    if getset = _(LNGGet) then begin
      s:= Indent1 + '@property' + CrLf +
          Indent1 + 'def ' + aName + '(self)';
      if datatype <> '' then
        s:= s + ' -> ' + datatype;
      s:= s + ':' + CrLf + Indent2 + 'return self.' + Attribute.VisName + CrLf;
    end else begin
      s:=  Indent1 + '@' + aName + '.setter' + CrLf +
           Indent1 + 'def ' + aName + '(self, value';
      if datatype <> '' then
        s:= s + ': ' + datatype;
      s:= s + '):' + CrLf + Indent2 + 'self.' + Attribute.VisName + ' = value' + CrLf;
    end;
  end else begin
    if getset = _(LNGGet) then begin
      s:= Indent1 + 'def ' + _(LNGGet) + '_' + aName + '(self)';
      if datatype <> '' then
        s:= s + ' -> ' + datatype;
      s:= s + ':' + CrLf + Indent2 + 'return self.' + Attribute.VisName + CrLf;
    end else begin
      s:= Indent1 + 'def ' + _(LNGSet) + '_' + aName + '(self, ' + aName;
      if datatype <> '' then
        s:= s + ': ' + datatype;
      s:= s + '):' + CrLf + Indent2 + 'self.' + Attribute.VisName + ' = ' + aName + CrLf;
    end;
  end;
  Result:= s;
end;

function TFClassEditor.Typ2Value(const typ: string): string;
const
  typs: array [1 .. 8] of string = ('int', 'integer', 'float', 'bool', 'boolean',
    'String', 'str', 'None');
  vals: array [1 .. 8] of string = ('0', '0', '0', 'false', 'false',
    '""', '""', 'None');
begin
  Result:= 'None';
  for var i:= 1 to 8 do
    if typs[i] = typ then begin
      Result:= vals[i];
      Break;
    end;
end;

function TFClassEditor.makeConstructor(Method: TOperation; Source: string): string;
var
  Indent, vis, s, head: string;
  it: IModelIterator;
  Parameter: TParameter;
  Attribute: TAttribute;
  found: Boolean;
  p: Integer;
  Node: TTreeNode;
  SourceSL: TStringList;

  function getSourceIndex(const s: string): Integer;
  begin
    for var i:= 0 to SourceSL.Count - 1 do
      if Pos(s, SourceSL[i]) > 0 then
        Exit(i);
    Result:= MaxInt;
  end;

  function getSuperClass: TClass;
    var Ci: IModelIterator;
  begin
    Result:= nil;
    var FullClassname:= GetClassName(GetClassNode);
    if Assigned(myUMLForm)
      then Ci:= myUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers
      else Ci:= myEditor.Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      var cent:= TClassifier(Ci.Next);
      if (cent.name = FullClassname) and (cent is TClass) and
         ((cent as TClass).AncestorsCount > 0) then
        Exit((cent as TClass).Ancestor[0]);
    end;
  end;

  procedure CallInheritedConstructor;
  begin
    var SuperClass:= GetSuperClass;
    if Assigned(SuperClass) then begin
      var SL:= TStringList.Create;
      try
        it.Reset;
        while it.HasNext  do begin
          Parameter:= it.Next as TParameter;
          if not Parameter.UsedForAttribute then
            if Assigned(Parameter.TypeClassifier)
              then SL.Add(Parameter.Name + ': ' + Parameter.TypeClassifier.GetShortType)
              else SL.Add(Parameter.Name);
        end;
        It:= SuperClass.GetOperations;
        while It.HasNext do begin
          var Operation:= It.Next as TOperation;
          if Operation.OperationType = otConstructor then begin
            var s2:= Indent + 'super().__init__(';
            var it2:= Operation.GetParameters;
            while it2.HasNext do begin
              Parameter:= it2.Next as TParameter;
              var param:= Parameter.Name;
              if Assigned(Parameter.TypeClassifier) then
                param:= param + ': ' + Parameter.TypeClassifier.asUMLType;
              if SL.IndexOf(Param) >= 0 then
                s2:= s2 + Parameter.Name + ', '
            end;
            if s2.EndsWith(', ') then
              s2:= UUtils.Left(s2, -2);
            p:= getSourceIndex('super().__init__');
            if p < SourceSL.Count then
              SourceSL.Delete(p);
            p:= getSourceIndex('def __init__');
            if p < SourceSL.Count then
              SourceSL.Insert(p+1, s2 + ')');
            Break;
          end;
        end;
      finally
        FreeAndNil(SL);
      end
    end;
  end;

begin // makeConstructor
  Parameter:= nil;
  Indent:= GetIndent(Method.Level + 2);
  SourceSL:= TStringList.Create;
  SourceSL.Text:= Source;
  head:= Method.HeadToPython;
  p:= getSourceIndex('def __init__');
  if p < SourceSL.Count
    then SourceSL[p]:= head
    else SourceSL.Insert(0, head);
  Node:= GetAttributeNode.getFirstChild;
  it:= Method.GetParameters;
  while it.HasNext do begin
    Parameter:= it.Next as TParameter;
    Parameter.UsedForAttribute:= False;
  end;

  while Assigned(Node) do begin // iterate over all attributes
    it.Reset;
    found:= False;
    case Node.ImageIndex of
        1: vis:= '__';
        2: vis:= '_';
      else vis:= '';
    end;
    var NodeName:= Node.Text;
    p:= Pos(':', NodeName);
    if p > 0 then NodeName:= Copy(NodeName, 1, p-1);

    while it.HasNext and not found do begin // exists a corresponding parameter?
      Parameter:= it.Next as TParameter;
      if Parameter.Name = NodeName then
        found:= True;
    end;
    if found then begin // corresponding parameter exists or
      s:= Indent + 'self.' + vis + Parameter.Name;
      if Assigned(Parameter.TypeClassifier) then
        s:= s + ': ' + Parameter.TypeClassifier.asType;
      s:= s + ' = ' + Parameter.Name;
      p:= getSourceIndex('self.' + vis + Parameter.Name);
      Parameter.UsedForAttribute:= True;
    end else begin
      Attribute:= GetAttribute(Node);
      Attribute.Value:= '';
      s:= Attribute.toPython(False);
      p:= getSourceIndex('self.' + vis + Attribute.Name);
    end;
    if p < SourceSL.Count then begin
      SourceSL.Delete(p);
      SourceSL.Insert(p, s);
    end else
      SourceSL.Add(s);
    Node:= Node.getNextSibling;
  end;
  CallInheritedConstructor;
  Result:= SourceSL.Text;
  FreeAndNil(SourceSL);
end;

function TFClassEditor.MakeIdentifier(var s: string): Integer;
var
  i: Integer;
  s2: string;
begin
  s2:= s;
  Result:= 0;
  // delete illegal chars at the beginning
  while (Length(s) > 0) and not (s[1].isLetter or (s[1] = '_')) do begin
    Delete(s, 1, 1);
    Result:= 1;
  end;
  // delete illegal chars after the beginning
  i:= 2;
  while i <= Length(s) do
    if not (s[i].IsLetterOrDigit or (s[i] = '_')) then begin
      Delete(s, i, 1);
      Result:= i;
    end else
      Inc(i);
end;

function TFClassEditor.MakeIdentifier(CB: TComboBox): Boolean;
var
  errpos, len: Integer;
  s: string;
  OnChange: TNotifyEvent;
begin
  Result:= True;
  s:= CB.Text;
  errpos:= MakeIdentifier(s);
  if errpos = 0 then
    Exit;
  if errpos = -1 then
  begin
    Result:= False;
    Exit;
  end;
  len:= Length(CB.Text) - Length(s);
  OnChange:= CB.OnChange;
  CB.OnChange:= nil;
  CB.Text:= s;
  CB.OnChange:= OnChange;
  if len = 1 then
    CB.SelStart:= errpos - 1
  else
    CB.SelStart:= Length(s);
end;

function TFClassEditor.MakeIdentifier(E: TEdit): Boolean;
var
  errpos, errlen: Integer;
  s: string;
  OnChange: TNotifyEvent;
begin
  Result:= True;
  s:= E.Text;
  errpos:= MakeIdentifier(s);
  if errpos = 0 then
    Exit;
  Result:= False;
  if errpos = -1 then
    Exit;
  errlen:= Length(E.Text) - Length(s);
  OnChange:= E.OnChange;
  E.OnChange:= nil;
  E.Text:= s;
  E.OnChange:= OnChange;
  if errlen = 1 then
    E.SelStart:= errpos - 1
  else
    E.SelStart:= Length(s);
end;

procedure TFClassEditor.ChangeAttribute(var A: TAttribute; CName: string);
begin
  A.Name:= EAttributeName.Text;
  A.TypeClassifier:= MakeType(CBAttributeType);
  //if A.TypeClassifier.Name = CName then
  //  A.TypeClassifier.Recursive:= true;
  A.Value:= CBAttributeValue.Text;
  A.Visibility:= TVisibility(RGAttributeAccess.ItemIndex);
  A.Static:= CBAttributeStatic.Checked;
  A.IsFinal:= CBAttributeFinal.Checked;
end;

function TFClassEditor.MakeAttribute(CName: string): TAttribute;
begin
  Result:= TAttribute.Create(nil);
  ChangeAttribute(Result, CName);
end;

function TFClassEditor.MakeType(CB: TComboBox): TClassifier;
begin
  var s:= CB.Text;
  var i:= CB.Items.IndexOf(s);
  if i <> -1 then
    s:= CB.Items[i];
  if s = '' then
    Result:= nil
  else
    Result:= MakeType(s);
end;

function TFClassEditor.MakeType(const s: string): TClassifier;
var
  MyUnit: TUnitPackage;
  aClass: TClass;
begin
  Result:= nil;
  MyUnit:= myEditor.Model.ModelRoot.FindUnitPackage('Default');
  if Assigned(MyUnit) then
    Result:= MyUnit.FindClassifier(s, nil, True);
  if Result = nil then begin
    aClass:= TClass.Create(nil);
    aClass.Name:= s;
    if Assigned(MyUnit) then
      MyUnit.AddClass(aClass);
    Result:= aClass;
  end;
end;

procedure TFClassEditor.ChangeMethod(var M: TOperation);
var
  i, p: Integer;
  typ, s, Value: string;
  Parameter: TParameter;
begin
  M.Name:= CBMethodName.Text;
  M.ReturnValue:= MakeType(CBMethodType);
  M.OperationType:= TOperationType(RGMethodKind.ItemIndex);
  M.Visibility:= TVisibility(RGMethodAccess.ItemIndex);
  if UUtils.Left(M.Name, 2) = '__' then
    M.Visibility:= viPrivate;
  M.isStaticMethod:= CBMethodStatic.Checked;
  M.isClassMethod:= CBMethodClass.Checked;
  M.IsAbstract:= CBMethodAbstract.Checked;
  M.NewParameters;
  for i:= 0 to LBParams.Items.Count - 1 do begin
    s:= LBParams.Items[i];
    p:= Pos(' = ', s);
    if p > 0 then begin
      Value:= Copy(s, p + 3, Length(s));
      Delete(s, p, Length(s));
    end else
      Value:= '';
    p:= Pos(':', s);
    if p > 0 then begin
      typ:= Copy(s, p + 2, Length(s));
      Delete(s, p, Length(s));
    end else
      typ:= '';
    Parameter:= M.AddParameter(s);
    if typ <> ''
      then Parameter.TypeClassifier:= MakeType(typ)
      else Parameter.TypeClassifier:= nil;
    Parameter.Value:= Value;
  end;
  if (CBParamName.Text <> '') and (CBParamType.Text <> '') then
    M.AddParameter(CBParamName.Text).TypeClassifier:= MakeType(CBParamType);
end;

procedure TFClassEditor.UpdateTreeView;
var
  Ci, it: IModelIterator;
  cent: TClassifier;
  Attribute: TAttribute;
  Method: TOperation;
  IsFirstClass: Boolean;
begin
  if TreeViewUpdating then Exit;
  TreeViewUpdating:= True;
  TreeView.OnChange:= nil;
  IsFirstClass:= True;
  if myEditor.reparseIfNeeded then begin
    TreeView.Items.BeginUpdate;
    TreeView.Items.Clear;
    Ci:= myEditor.Model.ModelRoot.GetAllClassifiers;
    // Ci:= myUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      cent:= TClassifier(Ci.Next);
      if (cent.pathname <> myEditor.pathname) or cent.anonym then
        Continue;
      if IsFirstClass then begin
        EClass.Text:= getShortType(cent.ShortName);
        IsFirstClass:= False;
      end;
      TVClass(cent);
      it:= cent.GetAttributes;
      while it.HasNext do begin
        Attribute:= it.Next as TAttribute;
        TVAttribute(Attribute);
      end;
      it:= cent.GetOperations;
      while it.HasNext do begin
        Method:= it.Next as TOperation;
        TVMethod(Method);
      end;
    end;
    TreeView.FullExpand;
    TreeView.Items.EndUpdate;
  end;
  TreeView.OnChange:= TreeViewChange;
  TreeViewUpdating:= False;
end;

function TFClassEditor.CreateTreeView(EditForm: TEditorForm;
  UMLForm: TFUMLForm): Boolean;
begin
  myUMLForm:= UMLForm;
  myEditor:= EditForm;
  myEditor.NeedsParsing:= True;
  UpdateTreeView;
  if TreeView.Items.Count > 0 then begin
    TreeView.Selected:= AttributeNode;
    TreeView.TopItem:= TreeView.Items.GetFirstNode;
  end;
  myEditor.Invalidate;
  Result:= True;
end;

procedure TFClassEditor.ActionListUpdate(aAction: TBasicAction;
  var Handled: Boolean);
var
  vis: Boolean;
begin
  if (aAction is TAction) then begin
    if Assigned(myEditor) then
      vis:= not myEditor.ActiveSynEdit.ReadOnly
    else
      vis:= True;
    (aAction as TAction).Enabled:= vis;
  end;
  Handled:= True;
end;

procedure TFClassEditor.BParameterNewClick(Sender: TObject);
begin
  if CBParamName.Text <> '' then begin
    if (CBParamType.Text <> '') and
       (CBParamName.Items.IndexOf(CBParamName.Text) = -1) then
         CBParamName.Items.AddObject(CBParamName.Text, TParamTyp.Create(CBParamType.Text));
    TakeParameter;
    BMethodChangeClick(Self);
    if CBParamName.CanFocus then
      CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.BParameterDeleteClick(Sender: TObject);
begin
  CBParamName.Text:= '';
  CBParamType.Text:= '';
  CBParamValue.Text:= '';
  SBDeleteClick(Self);
end;

procedure TFClassEditor.CBParamNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    ComboBoxInvalid:= False;
    CBParamNameSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBParamNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if CBParamName.Text <> '' then
    BMethodApply.Enabled:= True;
  ShowMandatoryFields;
end;

procedure TFClassEditor.CBParamNameSelect(Sender: TObject);
  var s: string;
begin
  var p:= CBParamName.ItemIndex;
  if (p = -1) or (CBParamName.Text <> CBParamName.Items[p]) then
    s:= CBParamName.Text
  else
    s:= CBParamName.Items[p];
  if not ComboBoxInvalid then begin
    if (-1 < p) and Assigned(CBParamName.Items.Objects[p]) then
      CBParamType.Text:= TParamTyp(CBParamName.Items.Objects[p]).typ;
    CBParamName.Text:= s;
    SBRightClick(Self);
  end;
end;

procedure TFClassEditor.AllAttributesAsParameters(Node: TTreeNode);
var
  s, aClassname: string;
  Ci, it: IModelIterator;
  cent: TClassifier;
  Attribute: TAttribute;
  Method: TOperation;
  Parameter: TParameter;
  p: Integer;

  procedure MakeParameterFromAttributes(cent: TClassifier);
  begin
    var it:= cent.GetAttributes;
    while it.HasNext do begin
      Attribute:= it.Next as TAttribute;
      s:= Attribute.toNameTypeUML;
      if CBParameter.Items.IndexOf(s) = -1 then
        CBParameter.Items.Add(s);
    end;
  end;

begin
  CBParameter.Clear;
  aClassname:= GetClassName(GetClassNode);
  cent:= GetClassifier(GetClassNode);
  if Assigned(cent) then begin
    MakeParameterFromAttributes(cent);
    while (cent is TClass) and ((cent as TClass).AncestorsCount > 0) do begin // ToDo n ancestors
      cent:= (cent as TClass).Ancestor[0];
      MakeParameterFromAttributes(cent);
    end;
  end;

  // look too in model of uml-diagram for ancestors
  if Assigned(myUMLForm) and Assigned(myUMLForm.MainModul) and
    Assigned(myUMLForm.MainModul.Model) and
    Assigned(myUMLForm.MainModul.Model.ModelRoot) then begin
    Ci:= myUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      cent:= TClassifier(Ci.Next);
      if cent.Name = aClassname then    // ToDo check
        Break;
    end;
    if cent.Name = aClassname then
      while (cent is TClass) and ((cent as TClass).AncestorsCount > 0) do begin // Todo n ancestors
        cent:= (cent as TClass).Ancestor[0];
        MakeParameterFromAttributes(cent);
      end;
  end;

  if Assigned(Node) and IsMethodsNodeLeaf(Node) then begin
    Method:= GetMethod(Node);
    if Assigned(Method) then begin
      it:= Method.GetParameters;
      while it.HasNext do begin
        Parameter:= it.Next as TParameter;
        s:= Parameter.toShortStringNode;
        p:= CBParameter.Items.IndexOf(s);
        if p > -1 then
          CBParameter.Items.Delete(p);
      end;
    end;
  end;
  CBParameter.Text:= _('Select attribute');
end;

procedure TFClassEditor.ComboBoxCloseUp(Sender: TObject);
begin
  ComboBoxInvalid:= False;
  (Sender as TComboBox).AutoComplete:= True;
end;

procedure TFClassEditor.CBComboBoxEnter(Sender: TObject);
  var CB: TComboBox; R: TRect; LeftPart: Boolean;
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

procedure TFClassEditor.ComboBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var cb: TComboBox;
begin
  ComboBoxInvalid:= True;
  if (Sender is TComboBox) and (Ord('0') <= Key) and (key <= Ord('Z')) then begin
    cb:= Sender as TComboBox;
    if (0 < cb.SelStart) and (cb.SelStart < Length(cb.Text)) then
      cb.AutoComplete:= False;
  end;
end;

procedure TFClassEditor.CBAttributeTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    ComboBoxInvalid:= False;
    CBAttributeTypeSelect(Self);
  end;
end;

procedure TFClassEditor.CBAttributeTypeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    BAttributeApply.Enabled:= True
end;

procedure TFClassEditor.CBAttributeTypeSelect(Sender: TObject);
begin
  if not ComboBoxInvalid then begin
    var p:= CBAttributeType.ItemIndex;
    if not ((p = -1) or (CBAttributeType.Text <> CBAttributeType.Items[p])) then
      CBAttributeType.Text:= CBAttributeType.Items[p];
    if NameTypeValueChanged then
      TThread.ForceQueue(nil, procedure
        begin
          BAttributeChangeClick(Self);
        end);
  end;
end;

procedure TFClassEditor.CBAttributeValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  BAttributeApply.Enabled:= True;
  if (Key = #13) and NameTypeValueChanged then
    BAttributeChangeClick(Self);
  if Key = #13 then
    BAttributeNew.SetFocus;
end;

procedure TFClassEditor.CBAttributeValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    BAttributeApply.Enabled:= True
end;

procedure TFClassEditor.CBAttributeValueSelect(Sender: TObject);
var
  s: string;
  p: Integer;
begin
  p:= CBAttributeValue.ItemIndex;
  if (p = -1) or (CBAttributeValue.Text <> CBAttributeValue.Items[p]) then
    s:= CBAttributeValue.Text
  else
    s:= CBAttributeValue.Items[p];
  if not ComboBoxInvalid then begin
    CBAttributeValue.Text:= s;
    if NameTypeValueChanged then
      BAttributeChangeClick(Self);
    CBAttributeValue.AutoComplete:= True;
  end;
end;

procedure TFClassEditor.CBClassAbstractClick(Sender: TObject);
begin
  BClassChangeClick(Self);
end;

procedure TFClassEditor.CBClassAbstractMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BClassApply.Enabled:= True;
end;

procedure TFClassEditor.EAttributeNameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and CBAttributeType.CanFocus then
    CBAttributeType.SetFocus;
end;

procedure TFClassEditor.EAttributeNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BAttributeApply.Enabled:= True;
  if Key = VK_RETURN then
    BAttributeChangeClick(Self);
end;

procedure TFClassEditor.EClassKeyPress(Sender: TObject; var Key: Char);
begin
  BClassApply.Enabled:= True;
end;

procedure TFClassEditor.CBMethodnameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    BMethodChangeClick(Self);
    if CBMethodType.CanFocus then
      CBMethodType.SetFocus;
  end;
end;

procedure TFClassEditor.CBMethodnameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BMethodApply.Enabled:= True
end;

procedure TFClassEditor.CBMethodnameSelect(Sender: TObject);
var
  s: string;
  p: Integer;
begin
  p:= CBMethodName.ItemIndex;
  if (p = -1) or (CBMethodName.Text <> CBMethodName.Items[p]) then
    s:= CBMethodName.Text
  else
    s:= CBMethodName.Items[p];
  if not ComboBoxInvalid then
  begin
    CBMethodName.Text:= s;
    if CBMethodName.Items.IndexOf(s) = -11 then
      CBMethodName.Items.Add(s);
    if (CBMethodName.Text <> '') and (RGMethodKind.ItemIndex < 2) then
      BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.CBMethodTypeDropDown(Sender: TObject);
begin
  SendMessage(CBMethodType.Handle, WM_SETCURSOR, 0, 0);
  RGMethodKind.ItemIndex:= 1;
end;

procedure TFClassEditor.CBMethodTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    ComboBoxInvalid:= False;
    BMethodChangeClick(Self);
    CBMethodTypeSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBMethodParamTypeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    BMethodApply.Enabled:= True
end;

procedure TFClassEditor.CBMethodTypeSelect(Sender: TObject);
  var s: string; p: Integer;
begin
  p:= CBMethodType.ItemIndex;
  if (p = -1) or (CBMethodType.Text <> CBMethodType.Items[p])
    then s:= CBMethodType.Text
    else s:= CBMethodType.Items[p];
  BMethodApply.Enabled:= True;
  if not ComboBoxInvalid then begin
    CBMethodType.Text:= s;
    if (CBMethodName.Text <> '') and (CBMethodType.Text <> '') then
      BMethodChangeClick(Self);
    CBMethodType.AutoComplete:= True;
  end;
end;

procedure TFClassEditor.CBParameterSelect(Sender: TObject);
begin
  var s:= CBParameter.Items[CBParameter.ItemIndex];
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
    ComboBoxInvalid:= False;
    CBParamTypeSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBParameterKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    ComboBoxInvalid:= False;
    CBParameterSelect(Self);
  end;
end;

procedure TFClassEditor.CBParamTypeSelect(Sender: TObject);
  var s: string; p: Integer;
begin
  p:= CBParamType.ItemIndex;
  if (p = -1) or (CBParamType.Text <> CBParamType.Items[p])
    then s:= CBParamType.Text
    else s:= CBParamType.Items[p];
  if not ComboBoxInvalid then begin
    CBParamType.Text:= s;
    if CBParamName.Text <> '' then begin
      BMethodChangeClick(Self);
      CBParamType.AutoComplete:= True;
      TThread.ForceQueue(nil, procedure
        begin
          CBParamType.Text:= '';
          CBParamName.SetFocus;
        end);
    end;
  end;
end;

function TFClassEditor.RGMethodKindHasChanged: Boolean;
begin
  Result:= True;
  if (RGMethodKind.ItemIndex = 0) and (CBMethodName.Text <> '__init__') then begin
    if CBMethodType.Text = ''
      then RGMethodKind.ItemIndex:= 2
      else RGMethodKind.ItemIndex:= 1;
  end else if (RGMethodKind.ItemIndex > 0) and (CBMethodName.Text = '__init__') then
    RGMethodKind.ItemIndex:= 0
  else
    Result:= False;

  CBMethodName.Enabled:= (RGMethodKind.ItemIndex > 0);
  CBMethodType.Enabled:= (RGMethodKind.ItemIndex > 0);
  ShowMandatoryFields;
end;

procedure TFClassEditor.ShowMandatoryFields;
begin
  case PageControl.ActivePageIndex of
    1: if EAttributeName.Text = ''
         then EAttributeName.Color:= clInfoBk
         else EAttributeName.Color:= clWindow;
    2:  begin
          if CBMethodName.Enabled and (CBMethodName.Text = '')
            then CBMethodName.Color:= clInfoBk
            else CBMethodName.Color:= clWindow;
          if CBMethodType.Enabled and (CBMethodType.Text = '')
            then CBMethodType.Color:= clInfoBk
            else CBMethodType.Color:= clWindow;
          if (CBParamName.Text <> '') and (CBParamType.Text = '')
            then CBParamType.Color:= clInfoBk
            else CBParamType.Color:= clWindow;
          if (CBParamName.Text = '') and (CBParamType.Text <> '')
            then CBParamName.Color:= clInfoBk
            else CBParamName.Color:= clWindow;
        end;
  end;
end;

function TFClassEditor.MethodToPython(Method: TOperation; Source: string): string;
var
  s, s2, Indent1, Indent2, comment: string;
  i, Count: Integer;
  SL: TStringList;

  procedure delparam(const param: string);
    var i: Integer;
  begin
    i:= 0;
    while i < SL.Count do
      if Pos(param, SL[i]) > 0
        then SL.Delete(i)
        else Inc(i);
  end;

  procedure AdjustReturnValue;
    const ReturnValues: array[1..5] of string = (' return 0', ' return ""',
       ' return false', ' return ''\0''', ' return None');
    var i, p: Integer;
  begin
    for i:= 1 to 5 do begin
      p:= Pos(ReturnValues[i], Source);
      if p > 0 then begin
        Delete(Source, p, Length(ReturnValues[i]));
        Insert(' return ' + s2, Source, p);
        Break;
      end;
    end;
  end;

begin
  Indent1:= GetIndent(Method.Level + 1);
  Indent2:= GetIndent(Method.Level + 2);
  if Pos('"""', Source) = 0
    then comment:= FConfiguration.getMultiLineComment(Indent2)
    else comment:= '';
  s:= Method.HeadToPython + CrLf;
  SL:= TStringList.Create;
  case Method.OperationType of
    otConstructor: s:= s + comment + makeConstructor(Method, Source);
    otFunction: begin
        if Method.IsAbstract then
          s:= s + Indent2 + comment + 'pass'
        else begin
          if Assigned(Method.ReturnValue)
            then s2:= Typ2Value(Method.ReturnValue.getShortType)
            else s2:= 'None';
          if Pos(' return ', Source) > 0 then begin
            AdjustReturnValue;
            s:= s + Source;
          end else begin
            if (Source = '') or (Source = Indent2 + 'pass' + CrLf)
              then s:= s + comment + Indent2 + _(LNGTODO) + CrLf
              else s:= s + Source;
            s:= s + Indent2 + 'return ' + s2 + CrLf;
          end;

          SL.Text:= s;
          for i:= SL.Count - 1 downto 0 do
            if Trim(SL[i]) = 'pass' then
              SL.Delete(i);
          s:= SL.Text;
        end;
      end;
    otProcedure: begin
        if Method.IsAbstract then
          s:= s + Indent2 + comment + 'pass'
        else begin
          if (Source <> '') and (Source <> Indent2 + 'pass' + CrLf) then begin
            Count:= 0;
            SL.Text:= Source;
            for i:= 0 to SL.Count - 1 do begin
              if Trim(SL[i]) = 'pass' then
                Inc(Count);
              if Pos(' return ', SL[i]) >  0 then begin
                Sl[i]:= Indent2 + 'pass';
                Inc(Count);
              end;
            end;
            i:= 0;
            while Count > 1 do begin
              if Trim(SL[i]) = 'pass' then begin
                SL.Delete(i);
                Dec(Count);
              end else
                Inc(i);
            end;
            if Count = 0 then
              SL.Add(Indent2 + 'pass');
            s:= s + SL.Text;
          end else
            s:= s + comment + Indent2 + _(LNGTODO) + CrLf
                   + Indent2 + 'pass' + CrLf;
        end;
      end;
  end;
  if not Method.hasComment then
    Method.hasComment:= (comment <> '');
  Result:= s;
  FreeAndNil(SL);
end;

procedure TFClassEditor.BMethodChangeClick(Sender: TObject);
var
  New, Source: string;
  Method: TOperation;
  ClassNumber, NodeIndex, TopItemIndex, from: Integer;
  Node: TTreeNode;
begin
  Node:= TreeView.Selected;
  CBMethodType.Enabled:= (RGMethodKind.ItemIndex = 1);
  if (not (MakeIdentifier(CBMethodName) and MakeIdentifier(CBMethodType) and
    MakeIdentifier(CBParamName) and MakeIdentifier(CBParamType)) or
    (CBMethodName.Text = '')) and (RGMethodKind.ItemIndex > 0) or (Node = nil) then
    Exit;

  ClassNumber:= GetClassNumber(Node);
  NodeIndex:= Node.AbsoluteIndex;
  TopItemIndex:= TreeView.TopItem.AbsoluteIndex;
  TakeParameter;
  if RGMethodKindHasChanged then
    Exit;

  myEditor.ActiveSynEdit.BeginUpdate;
  if IsMethodsNode(Node) then begin
    if RGMethodKind.ItemIndex = 0 then begin
      Inc(NodeIndex);
      Node:= Node.GetNext;
      while Assigned(Node) and (Node.ImageIndex = 4) do begin
        Inc(NodeIndex);
        Node:= Node.GetNext;
      end;
    end else
      NodeIndex:= NodeIndex + Node.Count + 1;
    Method:= MakeMethod;
    Method.Level:= GetLevel(Node);
    if not MethodAlreadyExists(Method.toShortStringNode) then begin
      New:= sLineBreak + MethodToPython(Method, '');
      if RGMethodKind.ItemIndex = 0
        then myEditor.InsertConstructor(New, Classnumber)
        else myEditor.InsertProcedure(New, ClassNumber);
    end else if (Sender = BMethodApply) then
      ErrorMsg(Format(_('%s already exists'), [Method.toShortStringNode]));
    if Method.IsAbstract then
      myEditor.InsertImport('from abc import abstractmethod');
    FreeAndNil(Method);
  end else begin
    Method:= GetMethod(Node);
    if Assigned(Method) then begin
      if Method.hasSourceCode then begin
        from:= Method.LineS;
        if Method.isStaticMethod then Inc(from);
        if Method.isClassMethod then Inc(from);
        if Method.IsAbstract then Inc(from);
        if Method.isPropertyMethod then Inc(from);
        Source:= myEditor.getSource(from, Method.LineE - 1);
      end else
        Source:= '';
      ChangeMethod(Method);
      if Method.OperationType = otConstructor
        then New:= makeConstructor(Method, Source)
        else New:= MethodToPython(Method, Source);
      ReplaceMethod(Method, New);
      if Method.IsAbstract then
        myEditor.InsertImport('from abc import abstractmethod');
    end;
  end;
  myEditor.Modified:= True;
  myEditor.ActiveSynEdit.EndUpdate;
  UpdateTreeView;
  if (0 <= TopItemIndex) and (TopItemIndex < TreeView.Items.Count) then
    TreeView.TopItem:= TreeView.Items[TopItemIndex];
  if (0 <= NodeIndex) and (NodeIndex < TreeView.Items.Count) then
    TreeView.Selected:= TreeView.Items[NodeIndex];
  BMethodApply.Enabled:= False;
end;

procedure TFClassEditor.ReplaceMethod(var Method: TOperation; const New: string);
begin
  myEditor.ActiveSynEdit.BeginUpdate;
  myEditor.DeleteBlock(Method.LineS - 1, Method.LineE - 1);
  myEditor.InsertLinesAt(Method.LineS - 1, New);
  myEditor.ActiveSynEdit.EndUpdate;
end;

function TFClassEditor.MakeMethod: TOperation;
begin
  Result:= TOperation.Create(nil);
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
  RGAttributeAccess.ItemIndex:= AppStorage.ReadInteger(BasePath + '\RGAttributeAccess', 0);
  CBgetMethod.Checked:= AppStorage.ReadBoolean(BasePath + '\CBGetMethod', False);
  CBsetMethod.Checked:= AppStorage.ReadBoolean(BasePath + '\CBSetMethod', False);
  RGMethodKind.ItemIndex:= AppStorage.ReadInteger(BasePath + '\RGMethodKind', 1);
  RGMethodAccess.ItemIndex:= AppStorage.ReadInteger(BasePath + '\RGMethodAccess', 2);
end;

procedure TFClassEditor.SBDeleteClick(Sender: TObject);
begin
  var i:= LBParams.ItemIndex;
  LBParams.DeleteSelected;
  BMethodChangeClick(Self);
  if i = LBParams.Count then
    Dec(i);
  if i >= 0 then
    LBParams.Selected[i]:= True;
end;

procedure TFClassEditor.SBDownClick(Sender: TObject);
begin
  var i:= LBParams.ItemIndex;
  if (0 <= i) and (i < LBParams.Count - 1) then begin
    LBParams.Items.Exchange(i, i + 1);
    BMethodChangeClick(Self);
    LBParams.Selected[i + 1]:= True;
  end;
end;

procedure TFClassEditor.SBUpClick(Sender: TObject);
begin
  var i:= LBParams.ItemIndex;
  if (0 < i) and (i < LBParams.Count) then begin
    LBParams.Items.Exchange(i, i - 1);
    BMethodChangeClick(Self);
    LBParams.Selected[i - 1]:= True;
  end;
end;

procedure TFClassEditor.SBLeftClick(Sender: TObject);
begin
  if (CBParamName.Text = '') and (CBParamType.Text = '') and
    (LBParams.ItemIndex < LBParams.Items.Count) and (0 <= LBParams.ItemIndex)
  then begin
    var s:= LBParams.Items[LBParams.ItemIndex];
    var p:= Pos(' = ', s);
    if p > 0 then begin
      CBParamValue.Text:= Copy(s, p + 3, Length(s));
      Delete(s, p, Length(s));
    end;
    p:= Pos(': ', s);
    if p > 0 then begin
      CBParamType.Text:= Copy(s, p + 2, Length(s));
      Delete(s, p, Length(s));
    end;
    CBParamName.Text:= s;
    LBParams.Items.Delete(LBParams.ItemIndex);
  end;
end;

function TFClassEditor.StrToPythonValue(s: string): string;
begin
  Result:= Trim(s);
  if not (isNumber(Result) or isBool(Result) or (Result = 'None') or
     (Result <> '') and (Pos(Result[1], '[({''') > 0))
  then
    Result:= asString(Result);
end;

procedure TFClassEditor.TakeParameter;
begin
  if CBParamName.Text <> '' then begin
    var s:= CBParamName.Text;
    if CBParamType.Text <> '' then
      s:= s + ': ' + CBParamType.Text;
    if CBParamValue.Text <> '' then
      s:= s + ' = ' + StrToPythonValue(CBParamValue.Text);
    LBParams.Items.Add(s);
    CBParamName.Text:= '';
    CBParamValue.Text:= '';
    CBParamType.Text:= '';
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
  EnableEvents(False);
  CBAttributeStatic.Checked:= False;
  CBAttributeFinal.Checked:= False;
  CBMethodStatic.Checked:= False;
  CBMethodClass.Checked:= False;
  CBMethodAbstract.Checked:= False;
  if GuiPyOptions.DefaultModifiers then begin
    RGAttributeAccess.ItemIndex:= -1;
    RGAttributeAccess.ItemIndex:= 0;
    RGMethodKind.ItemIndex:= 1;
    RGMethodAccess.ItemIndex:= 3;
  end;
  if CBgetMethod.Visible then
    CBgetMethod.Checked:= GuiPyOptions.GetMethodChecked;
  if CBsetMethod.Visible then
    CBsetMethod.Checked:= GuiPyOptions.SetMethodChecked;

  EnableEvents(True);
end;

procedure TFClassEditor.TreeViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  with TreeView do begin
    var TargetNode:= GetNodeAt(X, Y); // Get target node
    if TargetNode = nil then begin
      EndDrag(False);
      Exit;
    end;
    MoveNode(TargetNode, Selected);
  end;
end;

procedure TFClassEditor.TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Sender = TreeView then
    Accept:= True;
end;

procedure TFClassEditor.MoveNode(TargetNode, SourceNode: TTreeNode);
var
  from, till, _to, totill, NodeIndex: Integer;
  BlankLines: string;
  SourceModelEntity, TargetModelEntity: TModelEntity;
begin
  if IsClassNode(SourceNode) or IsAttributesNode(SourceNode) or
    IsMethodsNode(SourceNode) or IsClassNode(TargetNode) or
    myEditor.ActiveSynEdit.ReadOnly then
    Exit;

  if IsAttributesNode(TargetNode) or IsMethodsNode(TargetNode) then
    TargetNode:= TargetNode.getFirstChild;
  if IsAttributesNodeLeaf(SourceNode) and IsAttributesNodeLeaf(TargetNode) then begin
    BlankLines:= '';
    SourceModelEntity:= GetAttribute(SourceNode);
    TargetModelEntity:= GetAttribute(TargetNode);
  end else if IsMethodsNodeLeaf(SourceNode) and IsMethodsNodeLeaf(TargetNode) then begin
    BlankLines:= #13#10;
    SourceModelEntity:= GetMethod(SourceNode);
    TargetModelEntity:= GetMethod(TargetNode);
  end else
    Exit;

  if Assigned(SourceModelEntity) then begin
    from:= SourceModelEntity.LineS;
    till:= SourceModelEntity.LineE;
  end else
    Exit;

  if Assigned(TargetModelEntity) then begin
    _to:= TargetModelEntity.LineS;
    totill:= TargetModelEntity.LineE;
  end else
    Exit;

  if IsMethodsNodeLeaf(SourceNode) and (Trim(myEditor.ActiveSynEdit.lines[totill]) = '') then
    Inc(totill);
  if (from <= _to) and (_to <= till) then
    Exit;
  myEditor.MoveBlock(from - 1, till - 1, _to - 1, totill-1, BlankLines);
  NodeIndex:= TargetNode.AbsoluteIndex;
  UpdateTreeView;
  if NodeIndex < TreeView.Items.Count then
    TreeView.Selected:= TreeView.Items[NodeIndex];
end;

procedure TFClassEditor.LBParamsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and not myEditor.ActiveSynEdit.ReadOnly then
    LBParams.DeleteSelected;
end;

function TFClassEditor.IsClassNode(Node: TTreeNode): Boolean;
begin
  Result:= Assigned(Node) and (Node.ImageIndex = 0);
end;

function TFClassEditor.IsAttributesNodeLeaf(Node: TTreeNode): Boolean;
begin
  Result:= Assigned(Node) and (Node.Parent.ImageIndex = 8);
end;

function TFClassEditor.IsAttributesNode(Node: TTreeNode): Boolean;
begin
  Result:= Assigned(Node) and (Node.ImageIndex = 8);
end;

function TFClassEditor.IsMethodsNodeLeaf(Node: TTreeNode): Boolean;
begin
  Result:= Assigned(Node) and (Node.Parent.ImageIndex = 9);
end;

function TFClassEditor.IsMethodsNode(Node: TTreeNode): Boolean;
begin
  Result:= Assigned(Node) and (Node.ImageIndex = 9);
end;

function TFClassEditor.AttributeAlreadyExists(const s: string): Boolean;
begin
  var Node:= AttributeNode.getFirstChild;
  while Assigned(Node) do
  begin
    var p:= Pos(':', Node.Text);
    if Copy(Node.Text, 1, p - 1) = s then
      Break;
    Node:= Node.getNextSibling;
  end;
  Result:= Assigned(Node);
end;

function TFClassEditor.MethodAlreadyExists(const s: string): Boolean;
begin
  var Node:= MethodNode.getFirstChild;
  while Assigned(Node) and (Node.Text <> s) do
    Node:= Node.getNextSibling;
  Result:= Assigned(Node);
end;

procedure TFClassEditor.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    SBDelete.ImageIndex:= 1;
    TreeView.Images:= vilTreeViewDark;
  end else begin
    SBDelete.ImageIndex:= 0;
    TreeView.Images:= vilTreeViewLight;
  end;
end;

procedure TFClassEditor.FormAfterMonitorDpiChanged(Sender: TObject; OldDPI,
  NewDPI: Integer);
begin
  ILClassEditor.SetSize(PPIScale(18), PPIScale(18));
  ChangeStyle;
end;


end.
