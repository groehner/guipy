unit UClassEditor;

interface

uses
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ComCtrls,
  ImgList,
  ExtCtrls,
  Buttons,
  ActnList,
  System.ImageList,
  System.Actions,
  Vcl.BaseImageCollection,
  Vcl.VirtualImageList,
  SVGIconImageCollection,
  JvAppStorage,
  dlgPyIDEBase,
  UModel,
  UUMLForm,
  frmEditor;

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
    CBSetMethod: TCheckBox;
    CBGetMethod: TCheckBox;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
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
    procedure FormAfterMonitorDpiChanged(Sender: TObject;
      OldDPI, NewDPI: Integer);
  private
    FMyEditor: TEditorForm;
    FMyUMLForm: TFUMLForm;
    FAttributeNode: TTreeNode;
    FMethodNode: TTreeNode;
    FComboBoxInvalid: Boolean;
    FMakeNewClass: Boolean;
    FTreeViewUpdating: Boolean;
    FLngTODO: string;
    FLngSet: string;
    FLngGet: string;
    procedure NewClass;
    procedure AttributeToPython(const Attribute: TAttribute;
      ClassNumber, Line: Integer);
    function RGMethodKindHasChanged: Boolean;
    procedure ShowMandatoryFields;
    procedure TVClass(Classifier: TClassifier);
    procedure TVAttribute(const Attribute: TAttribute);
    procedure TVMethod(Method: TOperation);
    procedure ChangeAttribute(var Attribute: TAttribute; CName: string);
    procedure ChangeGetSet(Attribute: TAttribute; ClassNumber: Integer;
      Name: string);
    function MakeAttribute(CName: string): TAttribute;
    function MakeType(ComboBox: TComboBox): TClassifier; overload;
    function MakeType(const Name: string): TClassifier; overload;
    procedure GetParameter(ListBox: TListBox; Method: TOperation);
    function HasMethod(const GetSet: string; AttributeName: string;
      var Method: TOperation): Boolean;
    function MethodToPython(Method: TOperation; Source: string): string;
    procedure DeleteMethod(Method: TOperation);
    procedure ChangeMethod(var Method: TOperation);
    procedure ReplaceMethod(var Method: TOperation; const New: string);
    procedure ReplaceParameter(ClassNumber: Integer; const Str1, Str2: string);
    function MakeMethod: TOperation;
    function CreateMethod(const GetSet, Datatype: string;
      const Attribute: TAttribute): string;
    function MakeConstructor(Method: TOperation; Source: string): string;
    function Typ2Value(const Typ: string): string;
    procedure MoveNode(TargetNode, SourceNode: TTreeNode);
    procedure EnableEvents(Enable: Boolean);
    procedure SetEditText(Edit: TEdit; const Str: string);
    procedure SetComboBoxValue(ComboBox: TComboBox; const Str: string);
    function MakeIdentifier(var Str: string): Integer; overload;
    function MakeIdentifier(Edit: TEdit): Boolean; overload;
    function MakeIdentifier(ComboBox: TComboBox): Boolean; overload;
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
    function AttributeAlreadyExists(const Str: string): Boolean;
    function MethodAlreadyExists(const Str: string): Boolean;
    function NameTypeValueChanged: Boolean;
    function StrToPythonValue(Str: string): string;
    function GetConstructorHead(Superclass: string): string;
    function PrepareParameter(Head: string): string;
    procedure Init;
    procedure TakeParameter;
    procedure DeleteAttributeFromConstructorParameters(Node: TTreeNode;
      Attribute: TAttribute);
  protected
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string);
  public
    function CreateTreeView(EditForm: TEditorForm; UMLForm: TFUMLForm): Boolean;
    procedure UpdateTreeView;
    procedure ChangeStyle;
  end;

var
  FClassEditor: TFClassEditor = nil;

implementation

{$R *.dfm}

uses
  Windows,
  Math,
  Graphics,
  Messages,
  SysUtils,
  Dialogs,
  UITypes,
  Character,
  System.IOUtils,
  JvGnugettext,
  RegularExpressions,
  uEditAppIntfs,
  uCommonFunctions,
  StringResources,
  frmFile,
  UModelEntity,
  UConfiguration,
  UUtils;

const
  CrLf = #13#10;

type
  TParamTyp = class(TObject)
  private
    FTyp: string;
  public
    constructor Create(const Str: string);
    property Typ: string read FTyp;
  end;

constructor TParamTyp.Create(const Str: string);
begin
  FTyp := Str;
end;

procedure TFClassEditor.FormCreate(Sender: TObject);
const
  Values = '0'#$D#$A'0.0'#$D#$A''''''#$D#$A'True'#$D#$A'False'#$D#$A'None'#$D#$A'[]'#$D#$A'()'#$D#$A'{}'#$D#$A'set()';
begin
  inherited;
  FMakeNewClass := False;
  FTreeViewUpdating := False;
  TreeView.Images := vilTreeViewLight;
  CBAttributeValue.Items.Text := Values;
  CBParamValue.Items.Text := Values;
  FLngTODO := LNGInsertSourceCodeHere;
  FLngSet := _('set');
  FLngGet := _('get');
  ChangeStyle;
end;

procedure TFClassEditor.FormShow(Sender: TObject);
begin
  Init;
  var
  StringList := TStringList.Create;
  for var I := 0 to GI_FileFactory.Count - 1 do
    (GI_FileFactory[I].Form as TFileForm).CollectClasses(StringList);
  for var I := 0 to StringList.Count - 1 do
  begin
    var
    Str := GetShortType(StringList[I]);
    ComboBoxInsert2(CBAttributeType, Str);
    ComboBoxInsert2(CBMethodType, Str);
    ComboBoxInsert2(CBParamType, Str);
  end;
  FreeAndNil(StringList);

  if not GuiPyOptions.ShowGetSetMethods then
  begin
    CBGetMethod.Checked := False;
    CBSetMethod.Checked := False;
  end;
  CBGetMethod.Visible := GuiPyOptions.ShowGetSetMethods;
  CBSetMethod.Visible := GuiPyOptions.ShowGetSetMethods;
  CBAttributeType.Visible := GuiPyOptions.ShowTypeSelection;
  LAttributeType.Visible := GuiPyOptions.ShowTypeSelection;
  if CBAttributeType.Visible then
  begin
    CBAttributeValue.Top := PPIScale(220);
    LAttributeValue.Top := PPIScale(223);
  end
  else
  begin
    CBAttributeValue.Top := PPIScale(184);
    LAttributeValue.Top := PPIScale(187);
  end;

  CBParamType.Visible := GuiPyOptions.ShowParameterTypeSelection;
  LParameterType.Visible := GuiPyOptions.ShowParameterTypeSelection;
  if CBParamType.Visible then
  begin
    LParameterName.Top := PPIScale(32);
    LParameterType.Top := PPIScale(64);
    LParameterValue.Top := PPIScale(96);
    CBParamName.Top := PPIScale(29);
    CBParamType.Top := PPIScale(61);
    CBParamValue.Top := PPIScale(93);
  end
  else
  begin
    LParameterName.Top := PPIScale(48);
    LParameterValue.Top := PPIScale(80);
    CBParamName.Top := PPIScale(45);
    CBParamValue.Top := PPIScale(77);
  end;
  if GuiPyOptions.ShowWithWithoutReturnValue then
    RGMethodKind.Items.Text := _('constructor') + #13#10 +
      _('with return value') + #13#10 + _('without return value')
  else
    RGMethodKind.Items.Text := _('constructor') + #13#10 + _('function') +
      #13#10 + _('procedure');
end;

procedure TFClassEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TreeView.OnChange := nil;
  TreeView.Items.Clear;
  for var I := 0 to CBParamName.Items.Count - 1 do
  begin
    var
    AObject := CBParamName.Items.Objects[I];
    FreeAndNil(AObject);
  end;
end;

procedure TFClassEditor.TVClass(Classifier: TClassifier);
var
  Node, Anchor: TTreeNode;
  Posi: Integer;
  CName: string;

  function GetAnchor(Str: string): TTreeNode;
  var
    Node: TTreeNode;
    Str1: string;
    Posi: Integer;
  begin
    Result := nil;
    Node := TreeView.Items.GetFirstNode;
    Posi := Pos('.', Str);
    Str1 := Copy(Str, 1, Posi - 1);
    Delete(Str, 1, Posi);
    while Str1 <> '' do
    begin
      while Assigned(Node) and (Node.Text <> Str1) do
        Node := Node.getNextSibling;
      if not Assigned(Node) then
        Exit;
      Node := Node.getFirstChild;
      Posi := Pos('.', Str);
      Str1 := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
    end;
    Result := Node;
  end;

begin
  CName := Classifier.Name;
  Posi := LastDelimiter('.', CName);
  if Posi = 0 then
    Anchor := nil
  else
  begin
    Anchor := GetAnchor(Copy(CName, 1, Posi));
    Delete(CName, 1, Posi);
  end;

  Node := TreeView.Items.Add(Anchor, CName);
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;

  FAttributeNode := TreeView.Items.AddChild(Node, _('Attributes'));
  FAttributeNode.ImageIndex := 8;
  FAttributeNode.SelectedIndex := 8;

  FMethodNode := TreeView.Items.AddChild(Node, _('Methods'));
  FMethodNode.ImageIndex := 9;
  FMethodNode.SelectedIndex := 9;

  ComboBoxInsert2(CBAttributeType, CName);
  ComboBoxInsert2(CBMethodType, CName);
  ComboBoxInsert2(CBParamType, CName);
end;

procedure TFClassEditor.TVAttribute(const Attribute: TAttribute);
begin
  var
  Node := TreeView.Items.AddChild(FAttributeNode, Attribute.ToNameTypeUML);
  Node.ImageIndex := 1 + Integer(Attribute.Visibility);
  Node.SelectedIndex := 1 + Integer(Attribute.Visibility);
end;

procedure TFClassEditor.TVMethod(Method: TOperation);
var
  ImageNr: Integer;
begin
  var
  Node := TreeView.Items.AddChild(FMethodNode, Method.ToShortStringNode);
  if Method.OperationType = otConstructor then
    ImageNr := 4
  else
    ImageNr := 5 + Integer(Method.Visibility);
  Node.ImageIndex := ImageNr;
  Node.SelectedIndex := ImageNr;
end;

function TFClassEditor.GetConstructorHead(Superclass: string): string;
var
  Filename: string;
  Line, Posi: Integer;
  StringList: TStringList;

  procedure SearchInStringList;
  begin
    for var I := 0 to StringList.Count - 1 do
      if StringList[I].Contains('class ' + Superclass) then
        for var J := I + 1 to StringList.Count - 1 do
          if StringList[J].Contains('def __init__(self') then
            Result := Trim(StringList[J]);
  end;

begin
  Result := '';
  Line := FMyEditor.GetLineNumberWithWord('class ' + Superclass);
  if Line = -1 then
  begin
    StringList := FConfiguration.GetClassesAndFilename(FMyEditor.Pathname);
    try
      Posi := StringList.IndexOfName(Superclass);
      if Posi >= 0 then
      begin
        Filename := StringList.ValueFromIndex[Posi];
        StringList.LoadFromFile
          (TPath.Combine(ExtractFilePath(FMyEditor.Pathname), Filename));
        SearchInStringList;
      end;
    finally
      FreeAndNil(StringList);
    end;
  end
  else
  begin
    Line := FMyEditor.GetLineNumberWithWordFromTill('def __init__(self', Line);
    if Line > -1 then
      Result := Trim(FMyEditor.ActiveSynEdit.Lines[Line]);
  end;
end;

function TFClassEditor.PrepareParameter(Head: string): string;
begin
  Delete(Head, 1, Length('def __init__('));
  var
  Posi := Pos('):', Head);
  Head := Copy(Head, 1, Posi - 1);
  var
  StringList := Split(',', Head);
  Head := '';
  StringList.Delete(0); // self
  for var I := 0 to StringList.Count - 1 do
  begin
    var
    Str1 := StringList[I];
    Posi := Pos(':', Str1);
    if Posi > 0 then
      Delete(Str1, Posi, Length(Str1));
    Str1 := Trim(Str1);
    if Head = '' then
      Head := Str1
    else
      Head := Head + ', ' + Str1;
  end;
  FreeAndNil(StringList);
  Result := Head;
end;

procedure TFClassEditor.NewClass;
var
  Indent1, Indent2, Str: string;
  Line, Posi1, Posi2, Posi3, Posi4: Integer;

  function MakeInner(Str: string): string;
  begin
    var
    StringList := TStringList.Create;
    StringList.Text := Str;
    for var I := 0 to StringList.Count - 1 do
      StringList[I] := Indent1 + StringList[I];
    Result := StringList.Text;
    FreeAndNil(StringList);
  end;

begin
  FMakeNewClass := False;
  Indent1 := GetIndent(0);
  Indent2 := GetIndent(1);
  if CBClassInner.Checked then
  begin
    Indent1 := GetIndent(1);
    Indent2 := GetIndent(2);
  end;
  Str := FConfiguration.GetClassCodeTemplate;
  Posi1 := Pos('class ', Str);
  Posi2 := Pos(':', Str);
  Posi3 := Pos('__init__', Str);
  Posi4 := Pos('pass', Str);
  if (Posi1 > 0) and (Posi2 > Posi1) and (Posi3 > Posi2) and (Posi4 > Posi3)
  then
  begin
    Delete(Str, Posi1, Posi2 - Posi1);
    var
    Cls := EClass.Text;
    if EExtends.Text <> '' then
      Cls := Cls + '(' + EExtends.Text + ')';
    Insert('class ' + Cls, Str, Posi1);
  end
  else
  begin
    Str := CrLf + Indent1 + 'class ' + EClass.Text;
    if EExtends.Text <> '' then
      Str := CrLf + CrLf + Str + '(' + EExtends.Text + ')';
    Str := Str + ':' + CrLf;
    Str := Str + Indent2 + CrLf + Indent2 + 'def __init__(self):' + CrLf +
      Indent2 + Indent1 + 'pass' + CrLf + CrLf;
  end;
  if EExtends.Text <> '' then
  begin
    var
    Head := GetConstructorHead(EExtends.Text);
    if Head <> '' then
    begin
      Str := MyStringReplace(Str, 'def __init__(self):', Head);
      Head := PrepareParameter(Head);
      Str := MyStringReplace(Str, 'pass', 'super().__init__(' + Head + ')');
    end;
  end;
  if CBClassInner.Checked then
    Str := MakeInner(Str);
  Line := GetLastLineOfLastClass;
  FMyEditor.InsertLinesAt(Line + 1, sLineBreak + Str);
  FMyEditor.Modified := True;
  UpdateTreeView;
  TreeView.Selected := TreeView.Items[TreeView.Items.Count - 3];
  TreeViewChange(Self, TreeView.Selected);
end;

procedure TFClassEditor.BClassChangeClick(Sender: TObject);
var
  Str, Searchtext, ReplaceText, Tail, NewClassname, OldClassname,
    AIndent: string;
  SkipUpdate: Boolean;
  Posi, NodeIndex: Integer;
  Node: TTreeNode;
  StringList: TStringList;
begin
  if Trim(EClass.Text) = '' then
    Exit;
  if FMakeNewClass then
    NewClass
  else
  begin
    Node := TreeView.Selected;
    if not Assigned(Node) then
      Exit;
    AIndent := GetIndent(2);
    if CBClassInner.Checked then
      AIndent := GetIndent(3);
    LockFormUpdate(FMyEditor);
    FMyEditor.ActiveSynEdit.BeginUpdate;
    OldClassname := Node.Text;
    NodeIndex := Node.AbsoluteIndex;
    NewClassname := Trim(EClass.Text);
    Searchtext := 'class ' + OldClassname;
    ReplaceText := 'class ' + NewClassname;
    with FMyEditor do
    begin
      GotoWord(Searchtext);
      Str := ActiveSynEdit.LineText;
      Str := MyStringReplace(Str, Searchtext, ReplaceText);

      Posi := Length(Str);
      while (Posi > 0) and (Str[Posi] <> ':') do
        Dec(Posi);
      if Posi > 0 then
      begin
        Tail := Copy(Str, Posi + 1, Length(Str));
        Str := Copy(Str, 1, Posi - 1);
      end
      else
        Tail := '';

      Posi := Pos('(', Str);
      if Posi > 0 then
        Str := Copy(Str, 1, Posi - 1);
      Str := Trim(Str);
      SkipUpdate := False;

      if EExtends.Text <> '' then
      begin
        StringList := Split(',', EExtends.Text);
        for var I := StringList.Count - 1 downto 0 do
          if Trim(StringList[I]) = '' then
          begin
            StringList.Delete(I);
            SkipUpdate := True;
          end;
        if StringList.Count > 0 then
        begin
          Str := Str + '(' + Trim(StringList[0]);
          for var I := 1 to StringList.Count - 1 do
            Str := Str + ', ' + Trim(StringList[I]);
          Str := Str + ')';
        end;
        FreeAndNil(StringList);
      end;
      Str := Str + ':' + Tail;
      ActiveSynEdit.LineText := Str;

      if EExtends.Text <> '' then
      begin
        var
        Line := FMyEditor.GetLineNumberWithWord('class ' + NewClassname);
        if Line > -1 then
        begin
          Line := FMyEditor.GetLineNumberWithWordFromTill
            ('def __init__(self', Line);
          if Line > -1 then
          begin
            Str := FMyEditor.ActiveSynEdit.Lines[Line];
            var
            Head := GetConstructorHead(EExtends.Text);
            if Head <> '' then
              Str := MyStringReplace(Str, 'def __init__(self):', Head);
            FMyEditor.ActiveSynEdit.Lines[Line] := Str;
            Str := FMyEditor.ActiveSynEdit.Lines[Line + 1];
            if Pos('super().__init__', Str) = 0 then
            begin
              Head := PrepareParameter(Head);

              Str := AIndent + 'super().__init__(' + Head + ')';
              Str := FConfiguration.Indent2 + 'super().__init__(' + Head + ')';
              FMyEditor.ActiveSynEdit.Lines.Insert(Line + 1, Str);
            end;
          end;
        end;
      end;
      Modified := True;
      if not SkipUpdate then
      begin
        UpdateTreeView;
        if NodeIndex < TreeView.Items.Count then
          TreeView.Selected := TreeView.Items[NodeIndex];
      end;
    end;
    FMyEditor.ActiveSynEdit.EndUpdate;
    UnlockFormUpdate(FMyEditor);
  end;
  BClassApply.Enabled := False;
end;

function TFClassEditor.HasMethod(const GetSet: string; AttributeName: string;
  var Method: TOperation): Boolean;
var
  Cent: TClassifier;
  MethodName: string;
  Params1, Params2: Integer;
begin
  Method := nil;
  if GuiPyOptions.GetSetMethodsAsProperty then
    MethodName := AttributeName
  else if GetSet = _(FLngGet) then
    MethodName := _(FLngGet) + '_' + AttributeName
  else
    MethodName := _(FLngSet) + '_' + AttributeName;
  if GetSet = _(FLngGet) then
    Params1 := 1
  else
    Params1 := 2;
  Cent := GetClassifier(GetClassNode);
  if Assigned(Cent) then
  begin
    var
    It1 := Cent.GetOperations;
    while It1.HasNext do
    begin
      Method := It1.Next as TOperation;
      if Method.Name = MethodName then
      begin
        Params2 := 0;
        var
        It2 := Method.GetParameters;
        while It2.HasNext do
        begin
          Inc(Params2);
          It2.Next;
        end;
        if Params1 = Params2 then
          Exit(True);
      end;
    end;
  end;
  Method := nil;
  Result := False;
end;

procedure TFClassEditor.EnableEvents(Enable: Boolean);
begin
  if Enable and not FMyEditor.ActiveSynEdit.ReadOnly then
  begin
    RGAttributeAccess.OnClick := BAttributeChangeClick;
    CBAttributeStatic.OnClick := BAttributeChangeClick;
    CBAttributeFinal.OnClick := BAttributeChangeClick;
    CBGetMethod.OnClick := BAttributeChangeClick;
    CBSetMethod.OnClick := BAttributeChangeClick;

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
    CBGetMethod.OnClick := nil;
    CBSetMethod.OnClick := nil;

    RGMethodKind.OnClick := nil;
    RGMethodAccess.OnClick := nil;
    CBMethodStatic.OnClick := nil;
    CBMethodClass.OnClick := nil;
    CBMethodAbstract.OnClick := nil;
  end;
end;

function TFClassEditor.GetClassNumber(Node: TTreeNode): Integer;
begin
  Result := -1;
  var
  ANode := TreeView.Items.GetFirstNode;
  while ANode <> Node do
  begin
    if IsClassNode(ANode) then
      Inc(Result);
    ANode := ANode.GetNext;
  end;
end;

function TFClassEditor.GetClassNode(ClassNumber: Integer): TTreeNode;
begin
  var
  Node := TreeView.Items.GetFirstNode;
  while Assigned(Node) do
  begin
    if IsClassNode(Node) then
    begin
      Dec(ClassNumber);
      if ClassNumber = -1 then
        Exit(Node);
    end;
    Node := Node.GetNext;
  end;
  Result := nil;
end;

function TFClassEditor.GetLastLineOfLastClass: Integer;
begin
  Result := -1;
  FMyEditor.ParseAndCreateModel;
  var
  CIte := FMyEditor.Model.ModelRoot.GetAllClassifiers;
  while CIte.HasNext do
  begin
    var
    Cent := TClassifier(CIte.Next);
    Result := Max(Result, Cent.LineE);
  end;
end;

function TFClassEditor.GetClassNode: TTreeNode;
begin
  // we may have multiple classes in the treeview
  Result := TreeView.Selected;
  if Assigned(Result) then
    while Assigned(Result) and (Result.ImageIndex <> 0) do
      Result := Result.Parent
  else
    for var I := 0 to TreeView.Items.Count - 1 do
      if TreeView.Items[I].ImageIndex = 0 then
      begin
        Result := TreeView.Items[I];
        Break;
      end;
end;

function TFClassEditor.GetClassName(ClassNode: TTreeNode): string;
begin
  // we may have multilevel inner classes in the treeview
  if Assigned(ClassNode) then
  begin
    Result := ClassNode.Text;
    while ClassNode.Parent <> nil do
    begin
      ClassNode := ClassNode.Parent;
      Result := ClassNode.Text + '.' + Result;
    end;
  end
  else
    Result := '';
end;

function TFClassEditor.GetAttributeNode: TTreeNode;
begin
  Result := GetClassNode;
  if Assigned(Result) then
    Result := Result.getFirstChild;
end;

function TFClassEditor.GetMethodNode: TTreeNode;
begin
  Result := GetAttributeNode;
  if Assigned(Result) then
    Result := Result.getNextSibling;
end;

function TFClassEditor.GetClassifier(ClassNode: TTreeNode): TClassifier;
begin
  var
  FullClassname := GetClassName(ClassNode);
  var
  CIte := FMyEditor.Model.ModelRoot.GetAllClassifiers;
  while CIte.HasNext do
  begin
    Result := TClassifier(CIte.Next);
    if Result.Name = FullClassname then
      Exit(Result);
  end;
  Result := nil;
end;

function TFClassEditor.GetAttribute(AttributeLeafNode: TTreeNode): TAttribute;
begin
  var
  Cent := GetClassifier(AttributeLeafNode.Parent.Parent);
  if Assigned(Cent) then
  begin
    var
    Ite := Cent.GetAttributes;
    while Ite.HasNext do
    begin
      Result := TAttribute(Ite.Next);
      if Result.ToNameTypeUML = AttributeLeafNode.Text then
        Exit(Result);
    end;
  end;
  Result := nil;
end;

function TFClassEditor.GetMethod(MethodLeafNode: TTreeNode): TOperation;
begin
  var
  Cent := GetClassifier(MethodLeafNode.Parent.Parent);
  if Assigned(Cent) then
  begin
    var
    Ite := Cent.GetOperations;
    while Ite.HasNext do
    begin
      Result := TOperation(Ite.Next);
      if Result.ToShortStringNode = MethodLeafNode.Text then
        Exit(Result);
    end;
  end;
  Result := nil;
end;

function TFClassEditor.GetLevel(Node: TTreeNode): Integer;
var
  ClassNode: TTreeNode;
begin
  if not Assigned(Node) then
    Exit(0);
  Result := 0;
  if IsClassNode(Node) then
    ClassNode := Node
  else if IsAttributesNode(Node) or IsMethodsNode(Node) then
    ClassNode := Node.Parent
  else
    ClassNode := Node.Parent.Parent;
  while ClassNode.Parent <> nil do
  begin
    Result := Result + 1;
    ClassNode := ClassNode.Parent;
  end;
end;

function TFClassEditor.GetIndent(Level: Integer): string;
begin
  Result := StringTimesN(FConfiguration.Indent1, Level);
end;

procedure TFClassEditor.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  Classifier: TClassifier;
  Attribute: TAttribute;
  Method: TOperation;
  Line: Integer;
begin
  if not Assigned(Node) then
    Exit;
  Line := -1;
  EnableEvents(False);
  try
    if IsClassNode(Node) then
    begin
      PageControl.ActivePageIndex := 0;
      Classifier := GetClassifier(Node);
      if Assigned(Classifier) then
      begin
        EClass.Text := Node.Text;
        CBClassInner.Checked := (Classifier.Level > 0);
        SetEditText(EExtends, (Classifier as TClass).AncestorsAsString);
        Line := Classifier.LineS;
      end;
    end
    else if IsAttributesNode(Node) or IsAttributesNodeLeaf(Node) then
    begin
      PageControl.ActivePageIndex := 1;
      BAttributeApply.Enabled := False;
      if IsAttributesNodeLeaf(Node) then
      begin
        Attribute := GetAttribute(Node);
        if Assigned(Attribute) then
        begin
          SetEditText(EAttributeName, Attribute.Name);
          if Assigned(Attribute.TypeClassifier) then
            CBAttributeType.Text := Attribute.TypeClassifier.AsUMLType
          else
            CBAttributeType.Text := '';
          SetComboBoxValue(CBAttributeValue, Attribute.Value);
          RGAttributeAccess.ItemIndex := Integer(Attribute.Visibility);
          if CBGetMethod.Visible then
            CBGetMethod.Checked := HasMethod(_(FLngGet),
              Attribute.Name, Method);
          if CBSetMethod.Visible then
            CBSetMethod.Checked := HasMethod(_(FLngSet),
              Attribute.Name, Method);
          CBAttributeStatic.Checked := Attribute.Static;
          CBAttributeFinal.Checked := Attribute.IsFinal;
          Line := Attribute.LineS;
        end;
      end
      else
      begin
        CBAttributeType.Text := '';
        CBAttributeType.ItemIndex := -1;
        CBAttributeValue.Text := '';
        CBAttributeValue.ItemIndex := -1;
        ActiveControl := EAttributeName;
        EAttributeName.Text := '';
      end;
      ComboBoxInsert(CBAttributeType);
    end
    else
    begin
      PageControl.ActivePageIndex := 2;
      BMethodApply.Enabled := False;
      AllAttributesAsParameters(Node);
      if IsMethodsNodeLeaf(Node) then
      begin
        EClass.Text := Node.Parent.Parent.Text; // wg. constructor
        Method := GetMethod(Node);
        if Assigned(Method) then
        begin
          CBMethodName.Text := Method.Name;
          if Assigned(Method.ReturnValue) then
            CBMethodType.Text := Method.ReturnValue.AsUMLType
          else
            CBMethodType.Text := '';
          RGMethodKind.ItemIndex := Integer(Method.OperationType);
          RGMethodAccess.ItemIndex := Integer(Method.Visibility);
          CBMethodStatic.Checked := Method.IsStaticMethod;
          CBMethodClass.Checked := Method.IsClassMethod;
          CBMethodAbstract.Checked := Method.IsAbstract;
          GetParameter(LBParams, Method);
          Line := Method.LineS;
        end;
      end
      else
      begin
        EClass.Text := Node.Parent.Text; // wg. constructor
        RGMethodKind.ItemIndex := 1; // wg. constructor
        CBMethodName.Text := '';
        CBMethodType.Text := '';
        CBMethodType.ItemIndex := -1;
        CBParamName.Text := '';
        CBParamType.Text := '';
        CBParamType.ItemIndex := -1;
        CBMethodStatic.Checked := False;
        CBMethodClass.Checked := False;
        CBMethodAbstract.Checked := False;
        LBParams.Clear;
        if RGMethodKind.ItemIndex > 0 then
        begin
          CBMethodName.Enabled := True;
          ActiveControl := CBMethodName;
        end;
      end;
      ComboBoxInsert(CBMethodType);
      ComboBoxInsert(CBParamName);
      ComboBoxInsert(CBParamType);
      CBMethodName.Enabled := (RGMethodKind.ItemIndex > 0);
      CBMethodType.Enabled := (RGMethodKind.ItemIndex = 1);
    end;
  finally
    if IsAttributesNode(Node) or IsMethodsNode(Node) then
      if FMyEditor.ActiveSynEdit.ReadOnly then
        Line := -1
      else
        Line := FMyEditor.ActiveSynEdit.CaretY;
    if Line <> -1 then
      FMyEditor.GotoLine(Line);
    ShowMandatoryFields;
    EnableEvents(True);
  end;
end;

procedure TFClassEditor.SetEditText(Edit: TEdit; const Str: string);
begin
  if Edit.Text <> Str then
  begin
    var
    Posi := Edit.SelStart;
    Edit.Text := Str;
    Edit.SelStart := Posi;
  end;
end;

procedure TFClassEditor.SetComboBoxValue(ComboBox: TComboBox;
  const Str: string);
begin
  if ComboBox.Text <> Str then
  begin
    var
    Posi := ComboBox.SelStart;
    if (Pos('''', Str) > 0) and (Pos('''', ComboBox.Text) = 0) then
      Inc(Posi);
    ComboBox.Text := Str;
    ComboBox.SelStart := Posi;
  end;
end;

procedure TFClassEditor.GetParameter(ListBox: TListBox; Method: TOperation);
var
  It2: IModelIterator;
  Parameter: TParameter;
  Str: string;
  Int: Integer;

  function AsUMLType(AType: string): string;
  begin
    Result := AType;
    if AType = 'bool' then
      Result := 'boolean'
    else if AType = 'str' then
      Result := 'String'
    else if AType = 'int' then
      Result := 'integer';
  end;

begin
  ListBox.Clear;
  It2 := Method.GetParameters;
  while It2.HasNext do
  begin
    Parameter := It2.Next as TParameter;
    if (Parameter.Name = 'self') or (Parameter.Name = 'Cls') then
      Continue;
    Str := Parameter.Name;
    if Assigned(Parameter.TypeClassifier) then
      Str := Str + ': ' + Parameter.TypeClassifier.AsUMLType;
    if Parameter.Value <> '' then
      Str := Str + ' = ' + Parameter.Value;
    ListBox.Items.Add(Str);
  end;
  if CBParamType.Text <> '' then
    Str := CBParamName.Text + ': ' + AsUMLType(CBParamType.Text)
  else
    Str := CBParamName.Text;
  Int := ListBox.Items.IndexOf(Str);
  if Int <> -1 then
    ListBox.Items.Delete(Int);
end;

procedure TFClassEditor.PageControlChange(Sender: TObject);
var
  Node: TTreeNode;
begin
  var
  Tab := PageControl.TabIndex;
  if BClassApply.Enabled then
    BClassChangeClick(Sender)
  else if BAttributeApply.Enabled then
    BAttributeChangeClick(Sender)
  else if BMethodApply.Enabled then
    BMethodChangeClick(Sender);
  PageControl.TabIndex := Tab;
  case PageControl.TabIndex of
    0:
      Node := GetClassNode;
    1:
      Node := GetAttributeNode;
  else
    begin
      Node := GetMethodNode;
      AllAttributesAsParameters(Node);
    end;
  end;
  TreeView.Selected := Node;
end;

procedure TFClassEditor.ActionNewExecute(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    1:
      begin
        EAttributeName.Text := '';
        CBAttributeType.Text := '';
        CBAttributeValue.Text := '';
        TreeView.Selected := GetAttributeNode;
        CBAttributeStatic.Checked := False;
        CBAttributeFinal.Checked := False;
        if GuiPyOptions.DefaultModifiers then
          RGAttributeAccess.ItemIndex := 0;
        CBGetMethod.Checked := GuiPyOptions.GetMethodChecked;
        CBSetMethod.Checked := GuiPyOptions.SetMethodChecked;
      end;
    2:
      begin
        CBMethodName.Text := '';
        CBMethodType.Text := '';
        CBParamName.Text := '';
        CBParamType.Text := '';
        CBParamValue.Text := '';
        LBParams.Items.Clear;
        CBParameter.Text := _('Select attribute');
        TreeView.Selected := GetMethodNode;
        CBMethodStatic.Checked := False;
        CBMethodClass.Checked := False;
        CBMethodAbstract.Checked := False;
        if GuiPyOptions.DefaultModifiers then
        begin
          RGMethodKind.ItemIndex := 1;
          RGMethodAccess.ItemIndex := 2;
        end;
      end;
  else
    begin
      EClass.Text := '';
      EExtends.Text := '';
      CBClassInner.Checked := False;
      if Assigned(TreeView.Selected) then
        TreeView.Selected.Selected := False;
      FMakeNewClass := True;
    end;
  end;
end;

procedure TFClassEditor.AttributeToPython(const Attribute: TAttribute;
  ClassNumber, Line: Integer);
var
  Method: TOperation;
  Datatype: string;
begin
  // due to unexpected loss of Datatype when transferred with parameter Attribute
  if Assigned(Attribute.TypeClassifier) then
    Datatype := Attribute.TypeClassifier.AsType
  else
    Datatype := '';
  FMyEditor.ActiveSynEdit.BeginUpdate;
  FMyEditor.InsertLinesAt(Line, Attribute.ToPython(False));
  if CBGetMethod.Checked and not HasMethod(_(FLngGet), Attribute.Name, Method)
  then
    FMyEditor.InsertProcedure(CrLf + CreateMethod(_(FLngGet), Datatype,
      Attribute), ClassNumber);
  if CBSetMethod.Checked and not HasMethod(_(FLngSet), Attribute.Name, Method)
  then
    FMyEditor.InsertProcedure(CrLf + CreateMethod(_(FLngSet), Datatype,
      Attribute), ClassNumber);
  FMyEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.ChangeGetSet(Attribute: TAttribute;
  ClassNumber: Integer; Name: string);
var
  NewGet, NewSet, Datatype: string;
  Method1, Method2: TOperation;
  GetIsFirst: Boolean;

  procedure DoGet;
  begin
    if CBGetMethod.Checked then
      if Assigned(Method1) then
        ReplaceMethod(Method1, NewGet)
      else
        FMyEditor.InsertProcedureWithoutParse(CrLf + NewGet, ClassNumber)
    else if Assigned(Method1) then
      DeleteMethod(Method1);
  end;

  procedure DoSet;
  begin
    if CBSetMethod.Checked then
      if Assigned(Method2) then
        ReplaceMethod(Method2, NewSet)
      else
        FMyEditor.InsertProcedureWithoutParse(CrLf + NewSet, ClassNumber)
    else if Assigned(Method2) then
      DeleteMethod(Method2);
  end;

begin
  // replace get/set-methods, names could be changed
  HasMethod(_(FLngGet), Attribute.Name, Method1);
  HasMethod(_(FLngSet), Attribute.Name, Method2);
  GetIsFirst := True;
  if Assigned(Method1) and Assigned(Method2) and (Method1.LineS > Method2.LineS)
  then
    GetIsFirst := False;
  ChangeAttribute(Attribute, Name);
  if Assigned(Attribute.TypeClassifier) then
    Datatype := Attribute.TypeClassifier.AsType
  else
    Datatype := '';

  NewGet := CreateMethod(_(FLngGet), Datatype, Attribute);
  NewSet := CreateMethod(_(FLngSet), Datatype, Attribute);
  if GetIsFirst then
  begin
    DoSet;
    DoGet;
  end
  else
  begin
    DoGet;
    DoSet;
  end;
end;

function TFClassEditor.NameTypeValueChanged: Boolean;
begin
  var
  Node := TreeView.Selected;
  if Assigned(Node) then
  begin
    var
    Str := EAttributeName.Text + ': ' + CBAttributeType.Text;
    if CBAttributeValue.Text <> '' then
      Str := Str + ' = ' + CBAttributeValue.Text;
    Result := (Node.Text <> Str);
  end
  else
    Result := False;
end;

procedure TFClassEditor.BAttributeChangeClick(Sender: TObject);
const
  Values = '|0|0.0|''''|True|False|None|[]|()|{}|set()|';
  Types = '|int|integer|float|boolean|bool|str|String|string|list|tuple|dict|set|';

var
  Old, New, OldName, NewNameTypeUML, OldVisName, OldNameType, NewType: string;
  ClassNumber, NodeIndex, TopItemIndex, Line: Integer;
  Attribute: TAttribute;
  Node: TTreeNode;
  OldStatic, ValueChanged, TypeChanged: Boolean;

  function AsUMLType(Str: string): string;
  begin
    Result := Str;
    if Result = 'bool' then
      Result := 'boolean'
    else if Result = 'str' then
      Result := 'String'
    else if Result = 'int' then
      Result := 'integer';
  end;

begin
  Node := TreeView.Selected;
  if not Assigned(Node) or (EAttributeName.Text = '') or
    not MakeIdentifier(EAttributeName) then
    Exit;
  ClassNumber := GetClassNumber(Node);
  TopItemIndex := TreeView.TopItem.AbsoluteIndex;
  NodeIndex := Node.AbsoluteIndex;

  FMyEditor.ActiveSynEdit.BeginUpdate;
  if IsAttributesNode(Node) then
  begin
    NodeIndex := NodeIndex + Node.Count + 1;
    Attribute := MakeAttribute(Node.Parent.Text);
    Attribute.Level := GetLevel(Node);
    NewNameTypeUML := Attribute.Name;
    if AttributeAlreadyExists(Attribute.Name) then
      ErrorMsg(Format(_('%s already exists'), [Attribute.Name]))
    else
    begin
      Line := FMyEditor.GetLastConstructorLine(ClassNumber);
      AttributeToPython(Attribute, ClassNumber, Line);
      FMyEditor.RemovePass(ClassNumber);
    end;
    FreeAndNil(Attribute);
  end
  else
  begin
    Attribute := GetAttribute(Node);
    if Assigned(Attribute) then
    begin
      ValueChanged := CBAttributeValue.Text <> Attribute.Value;
      TypeChanged := Assigned(Attribute.TypeClassifier) and
        (AsUMLType(CBAttributeType.Text) <> Attribute.TypeClassifier.AsUMLType);
      OldName := Attribute.Name;
      OldVisName := Attribute.VisName;
      OldNameType := Attribute.ToNameType;
      OldStatic := Attribute.Static;
      Old := Attribute.ToPython(False);
      // changed to a value of another standard type then change type too
      if ValueChanged and Assigned(Attribute.TypeClassifier) and
        (Pos('|' + Attribute.TypeClassifier.AsType + '|', Types) > 0) then
      begin
        NewType := Attribute.TypeClassifier.ValueToType(CBAttributeValue.Text);
        if NewType <> Attribute.TypeClassifier.AsType then
        begin
          if NewType = '' then
            Attribute.TypeClassifier := nil
          else
            Attribute.TypeClassifier := MakeType(NewType);
          CBAttributeType.Text := NewType;
          TypeChanged := True;
        end;
      end;
      ChangeGetSet(Attribute, ClassNumber, Node.Parent.Parent.Text);
      if (Attribute.Name <> OldName) and AttributeAlreadyExists(Attribute.Name)
      then
        ErrorMsg(Format(_('%s already exists'), [Attribute.Name]))
      else
      begin
        New := Attribute.ToPython(TypeChanged);
        NewNameTypeUML := Attribute.ToNameTypeUML;
        if CBAttributeValue.Text <> '' then
          CBAttributeValue.Text := Attribute.Value;
        if CBAttributeType.Text <> '' then
          CBAttributeType.Text := Attribute.TypeClassifier.Name;
        if New <> Old then
        begin
          if OldStatic = Attribute.Static then
            FMyEditor.ReplaceLineInLine(Attribute.LineS - 1, Old, New)
          else if Attribute.Static then
          begin
            FMyEditor.DeleteLine(Attribute.LineS - 1);
            FMyEditor.InsertLinesAt(TClassifier(Attribute.Owner).LineS, New);
          end
          else if OldStatic then
          begin
            FMyEditor.InsertAttributeCE(New, ClassNumber);
            FMyEditor.DeleteLine(Attribute.LineS - 1);
          end;
          FMyEditor.ReplaceWord(OldName, Attribute.Name, True);
          FMyEditor.ReplaceWord('self.' + OldVisName,
            'self.' + Attribute.VisName, True);
          ReplaceParameter(ClassNumber, OldNameType, Attribute.ToNameType);
        end;
      end;
    end;
  end;
  FMyEditor.ActiveSynEdit.EndUpdate;
  UpdateTreeView;
  Node := GetClassNode(ClassNumber);
  if Assigned(Node) then
  begin
    Node := Node.getFirstChild.getFirstChild;
    while Assigned(Node) and (Node.Text <> NewNameTypeUML) do
      Node := Node.GetNext;
    if Assigned(Node) then
      NodeIndex := Node.AbsoluteIndex;
  end;
  if (0 <= TopItemIndex) and (TopItemIndex < TreeView.Items.Count) then
    TreeView.TopItem := TreeView.Items[TopItemIndex];
  if (0 <= NodeIndex) and (NodeIndex < TreeView.Items.Count) then
    TreeView.Selected := TreeView.Items[NodeIndex];
  BAttributeApply.Enabled := False;
end;

procedure TFClassEditor.ReplaceParameter(ClassNumber: Integer;
  const Str1, Str2: string);
var
  Node: TTreeNode;
  MethodName, Str: string;
  AClass: TClass;
  LineNr: Integer;

  function ReplaceWord(Str, Str1, Str2: string): string;
  var
    WStr, RegExExpr: string;
    RegEx: TRegEx;
    Matches: TMatchCollection;
    Group: TGroup;
  begin
    RegExExpr := '\b(' + TRegEx.Escape(Str1) + ')';
    if not IsWordBreakChar(Str1[Length(Str1)]) then
      RegExExpr := RegExExpr + '\b';
    RegEx := CompiledRegEx(RegExExpr);

    WStr := Str;
    Matches := RegEx.Matches(WStr);
    for var I := Matches.Count - 1 downto 0 do
    begin
      Group := Matches[I].Groups[1];
      Delete(WStr, Group.Index, Group.Length);
      Insert(Str2, WStr, Group.Index);
    end;
    Result := WStr;
  end;

begin
  AClass := FMyEditor.GetClass(ClassNumber);
  if not Assigned(AClass) then
    Exit;
  Node := GetClassNode(ClassNumber);
  if not Assigned(Node) then
    Exit;
  Node := Node.getFirstChild.getNextSibling.getFirstChild; // first method
  while Assigned(Node) do
  begin
    case Node.ImageIndex of
      5:
        MethodName := '__';
      6:
        MethodName := '_';
      4, 7:
        MethodName := '';
    end;
    MethodName := MethodName + Copy(Node.Text, 1, Pos('(', Node.Text) - 1);
    LineNr := FMyEditor.GetLineNumberWithWordFromTill(MethodName, AClass.LineS,
      AClass.LineE);
    if LineNr > -1 then
    begin
      Str := FMyEditor.ActiveSynEdit.Lines[LineNr];
      if (Pos(Str2, Str) = 0) or (Pos(': ', Str2) = 0) then
      begin
        // setter already done or change to None/no type
        FMyEditor.ActiveSynEdit.Lines[LineNr] := ReplaceWord(Str, Str1, Str2);
        FMyEditor.Modified := True;
      end;
    end;
    Node := Node.getNextSibling;
  end;
end;

procedure TFClassEditor.DeleteMethod(Method: TOperation);
begin
  FMyEditor.ActiveSynEdit.BeginUpdate;
  FMyEditor.DeleteBlock(Method.LineS - 1, Method.LineE - 1);
  var
  Int := Method.LineS - 1;
  if Method.HasComment then
  begin
    FMyEditor.DeleteBlock(Method.Documentation.LineS - 1,
      Method.Documentation.LineE - 1);
    Int := Method.Documentation.LineS - 1;
  end;
  FMyEditor.DeleteEmptyLine(Int - 1);
  FMyEditor.ActiveSynEdit.EndUpdate;
end;

procedure TFClassEditor.BAttributeDeleteClick(Sender: TObject);
var
  Attribute: TAttribute;
  Method1, Method2: TOperation;
  Posi1, Posi2, Posi3, ClassNumber: Integer;
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Assigned(Node) and IsAttributesNodeLeaf(Node) then
  begin
    LockFormUpdate(FMyEditor);
    FMyEditor.ActiveSynEdit.BeginUpdate;
    Attribute := GetAttribute(Node);
    HasMethod(_(FLngGet), Attribute.Name, Method1);
    HasMethod(_(FLngSet), Attribute.Name, Method2);
    if Assigned(Method1) and Assigned(Method2) then
    begin
      if Method1.LineS < Method2.LineS then
      begin
        DeleteMethod(Method2);
        DeleteMethod(Method1);
      end
      else
      begin
        DeleteMethod(Method1);
        DeleteMethod(Method2);
      end;
    end
    else
    begin
      if Assigned(Method1) then
        DeleteMethod(Method1);
      if Assigned(Method2) then
        DeleteMethod(Method2);
    end;
    ClassNumber := GetClassNumber(Node);
    FMyEditor.DeleteAttributeCE('self.' + Attribute.VisName, ClassNumber);
    DeleteAttributeFromConstructorParameters(Node, Attribute);
    Posi1 := TreeView.Selected.AbsoluteIndex;
    Posi2 := TreeView.FindNextToSelect.AbsoluteIndex;
    Posi3 := TreeView.TopItem.AbsoluteIndex;
    UpdateTreeView;
    if (0 <= Posi3) and (Posi3 < TreeView.Items.Count) then
      TreeView.TopItem := TreeView.Items[Posi3];
    Posi1 := Min(Posi1, Posi2);
    if (0 <= Posi1) and (Posi1 < TreeView.Items.Count) then
      TreeView.Selected := TreeView.Items[Posi1];
    BAttributeApply.Enabled := False;
    FMyEditor.ActiveSynEdit.EndUpdate;
    UnlockFormUpdate(FMyEditor);
  end;
end;

procedure TFClassEditor.DeleteAttributeFromConstructorParameters
  (Node: TTreeNode; Attribute: TAttribute);
begin
  var
  Parameter := Attribute.Name;
  if Assigned(Attribute.TypeClassifier) then
    Parameter := Parameter + ': ' + Attribute.TypeClassifier.AsUMLType;
  while Assigned(Node) and (Pos('__init__', Node.Text) = 0) do
    Node := Node.GetNext;
  if Assigned(Node) then
  begin
    var
    Posi := Pos(', ' + Parameter + ',', Node.Text) + Pos(', ' + Parameter + ')',
      Node.Text);
    if Posi > 0 then
    begin
      var
      Operation := GetMethod(Node);
      var
      Str := Node.Text;
      Delete(Str, Posi, 2 + Length(Parameter));
      Node.Text := Str;
      if Assigned(Operation) then
      begin
        var
        OldHead := Operation.HeadToPython;
        Operation.DelParameter(Attribute.Name);
        var
        NewHead := Operation.HeadToPython;
        FMyEditor.ReplaceLine(OldHead, NewHead);
      end;
    end;
  end;
end;

procedure TFClassEditor.BMethodDeleteClick(Sender: TObject);
var
  Node: TTreeNode;
  Method: TOperation;
  StringList: TStringList;
  Index: Integer;
  Str: string;
  HasSourceCode: Boolean;
begin
  Node := TreeView.Selected;
  if Assigned(Node) and IsMethodsNodeLeaf(Node) then
  begin
    LockFormUpdate(FMyEditor);
    FMyEditor.ActiveSynEdit.BeginUpdate;
    Method := GetMethod(Node);
    HasSourceCode := False;
    if Method.HasSourceCode then
    begin
      StringList := TStringList.Create;
      try
        StringList.Text := FMyEditor.GetSource(Method.LineS, Method.LineE - 2);
        for var I := StringList.Count - 1 downto 0 do
        begin
          Str := Trim(StringList[I]);
          if (Pos('return', Str) = 1) or (Str = '') or (Str = _(FLngTODO)) then
            StringList.Delete(I);
        end;
        HasSourceCode := (StringList.Count > 0);
      finally
        StringList.Free;
      end;
    end;

    if not HasSourceCode or
      (StyledMessageDlg(Format(_('Method %s contains source code.'),
      [Method.Name]) + #13 + _('Delete method with source code?'),
      mtConfirmation, mbYesNoCancel, 0) = mrYes) then
    begin
      DeleteMethod(Method);
      FMyEditor.Modified := True;
      Index := Node.AbsoluteIndex;
      UpdateTreeView;
      if Index = TreeView.Items.Count then
        Dec(Index);
      TreeView.Selected := TreeView.Items[Index];
      BMethodApply.Enabled := False;
    end;
    FMyEditor.ActiveSynEdit.EndUpdate;
    UnlockFormUpdate(FMyEditor);
  end;
end;

procedure TFClassEditor.ActionApplyExecute(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    0:
      BClassChangeClick(Sender);
    1:
      begin
        BAttributeChangeClick(Sender);
        ActionNewExecute(Sender);
      end;
    2:
      begin
        BMethodChangeClick(Sender);
        ActionNewExecute(Sender);
      end;
  end;
end;

procedure TFClassEditor.ActionCloseExecute(Sender: TObject);
begin
  if Assigned(FMyEditor) then
    FMyEditor.DoSave;
end;

procedure TFClassEditor.ActionDeleteExecute(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1 then
    BAttributeDeleteClick(Sender)
  else
    BMethodDeleteClick(Sender);
end;

function TFClassEditor.CreateMethod(const GetSet, Datatype: string;
  const Attribute: TAttribute): string;
var
  Str, Indent1, Indent2, AName: string;
begin
  Indent1 := GetIndent(Attribute.Level + 1);
  Indent2 := GetIndent(Attribute.Level + 2);
  AName := Attribute.Name;

  if GuiPyOptions.GetSetMethodsAsProperty then
  begin
    if GetSet = _(FLngGet) then
    begin
      Str := Indent1 + '@property' + CrLf + Indent1 + 'def ' + AName + '(self)';
      if Datatype <> '' then
        Str := Str + ' -> ' + Datatype;
      Str := Str + ':' + CrLf + Indent2 + 'return self.' +
        Attribute.VisName + CrLf;
    end
    else
    begin
      Str := Indent1 + '@' + AName + '.setter' + CrLf + Indent1 + 'def ' + AName
        + '(self, value';
      if Datatype <> '' then
        Str := Str + ': ' + Datatype;
      Str := Str + '):' + CrLf + Indent2 + 'self.' + Attribute.VisName +
        ' = value' + CrLf;
    end;
  end
  else
  begin
    if GetSet = _(FLngGet) then
    begin
      Str := Indent1 + 'def ' + _(FLngGet) + '_' + AName + '(self)';
      if Datatype <> '' then
        Str := Str + ' -> ' + Datatype;
      Str := Str + ':' + CrLf + Indent2 + 'return self.' +
        Attribute.VisName + CrLf;
    end
    else
    begin
      Str := Indent1 + 'def ' + _(FLngSet) + '_' + AName + '(self, ' + AName;
      if Datatype <> '' then
        Str := Str + ': ' + Datatype;
      Str := Str + '):' + CrLf + Indent2 + 'self.' + Attribute.VisName + ' = ' +
        AName + CrLf;
    end;
  end;
  Result := Str;
end;

function TFClassEditor.Typ2Value(const Typ: string): string;
const
  Typs: array [1 .. 8] of string = ('int', 'integer', 'float', 'bool',
    'boolean', 'String', 'str', 'None');
  Vals: array [1 .. 8] of string = ('0', '0', '0', 'false', 'false', '""',
    '""', 'None');
begin
  Result := 'None';
  for var I := 1 to 8 do
    if Typs[I] = Typ then
    begin
      Result := Vals[I];
      Break;
    end;
end;

function TFClassEditor.MakeConstructor(Method: TOperation;
  Source: string): string;
var
  Indent, Vis, Str, Head: string;
  Ite: IModelIterator;
  Parameter: TParameter;
  Attribute: TAttribute;
  Found: Boolean;
  Posi: Integer;
  Node: TTreeNode;
  SourceSL: TStringList;

  function GetSourceIndex(const Str: string): Integer;
  begin
    for var I := 0 to SourceSL.Count - 1 do
      if Pos(Str, SourceSL[I]) > 0 then
        Exit(I);
    Result := MaxInt;
  end;

  function GetSuperClass: TClass;
  var
    CIte: IModelIterator;
  begin
    Result := nil;
    var
    FullClassname := GetClassName(GetClassNode);
    if Assigned(FMyUMLForm) then
      CIte := FMyUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers
    else
      CIte := FMyEditor.Model.ModelRoot.GetAllClassifiers;
    while CIte.HasNext do
    begin
      var
      Cent := TClassifier(CIte.Next);
      if (Cent.Name = FullClassname) and (Cent is TClass) and
        ((Cent as TClass).AncestorsCount > 0) then
        Exit((Cent as TClass).Ancestor[0]);
    end;
  end;

  procedure CallInheritedConstructor;
  begin
    var
    Superclass := GetSuperClass;
    if Assigned(Superclass) then
    begin
      var
      StringList := TStringList.Create;
      try
        Ite.Reset;
        while Ite.HasNext do
        begin
          Parameter := Ite.Next as TParameter;
          if not Parameter.UsedForAttribute then
            if Assigned(Parameter.TypeClassifier) then
              StringList.Add(Parameter.Name + ': ' +
                Parameter.TypeClassifier.GetShortType)
            else
              StringList.Add(Parameter.Name);
        end;
        Ite := Superclass.GetOperations;
        while Ite.HasNext do
        begin
          var
          Operation := Ite.Next as TOperation;
          if Operation.OperationType = otConstructor then
          begin
            var
            Str2 := Indent + 'super().__init__(';
            var
            It2 := Operation.GetParameters;
            while It2.HasNext do
            begin
              Parameter := It2.Next as TParameter;
              var
              Param := Parameter.Name;
              if Assigned(Parameter.TypeClassifier) then
                Param := Param + ': ' + Parameter.TypeClassifier.AsUMLType;
              if StringList.IndexOf(Param) >= 0 then
                Str2 := Str2 + Parameter.Name + ', ';
            end;
            if Str2.EndsWith(', ') then
              Str2 := UUtils.Left(Str2, -2);
            Posi := GetSourceIndex('super().__init__');
            if Posi < SourceSL.Count then
              SourceSL.Delete(Posi);
            Posi := GetSourceIndex('def __init__');
            if Posi < SourceSL.Count then
              SourceSL.Insert(Posi + 1, Str2 + ')');
            Break;
          end;
        end;
      finally
        FreeAndNil(StringList);
      end;
    end;
  end;

begin // MakeConstructor
  Parameter := nil;
  Indent := GetIndent(Method.Level + 2);
  SourceSL := TStringList.Create;
  SourceSL.Text := Source;
  Head := Method.HeadToPython;
  Posi := GetSourceIndex('def __init__');
  if Posi < SourceSL.Count then
    SourceSL[Posi] := Head
  else
    SourceSL.Insert(0, Head);
  Node := GetAttributeNode.getFirstChild;
  Ite := Method.GetParameters;
  while Ite.HasNext do
  begin
    Parameter := Ite.Next as TParameter;
    Parameter.UsedForAttribute := False;
  end;

  while Assigned(Node) do
  begin // iterate over all attributes
    Ite.Reset;
    Found := False;
    case Node.ImageIndex of
      1:
        Vis := '__';
      2:
        Vis := '_';
    else
      Vis := '';
    end;
    var
    NodeName := Node.Text;
    Posi := Pos(':', NodeName);
    if Posi > 0 then
      NodeName := Copy(NodeName, 1, Posi - 1);

    while Ite.HasNext and not Found do
    begin // exists a corresponding parameter?
      Parameter := Ite.Next as TParameter;
      if Parameter.Name = NodeName then
        Found := True;
    end;
    if Found then
    begin // corresponding parameter exists or
      Str := Indent + 'self.' + Vis + Parameter.Name;
      if Assigned(Parameter.TypeClassifier) then
        Str := Str + ': ' + Parameter.TypeClassifier.AsType;
      Str := Str + ' = ' + Parameter.Name;
      Posi := GetSourceIndex('self.' + Vis + Parameter.Name);
      Parameter.UsedForAttribute := True;
    end
    else
    begin
      Attribute := GetAttribute(Node);
      Attribute.Value := '';
      Str := Attribute.ToPython(False);
      Posi := GetSourceIndex('self.' + Vis + Attribute.Name);
    end;
    if Posi < SourceSL.Count then
    begin
      SourceSL.Delete(Posi);
      SourceSL.Insert(Posi, Str);
    end
    else
      SourceSL.Add(Str);
    Node := Node.getNextSibling;
  end;
  CallInheritedConstructor;
  Result := SourceSL.Text;
  FreeAndNil(SourceSL);
end;

function TFClassEditor.MakeIdentifier(var Str: string): Integer;
var
  Int: Integer;
begin
  Result := 0;
  // delete illegal chars at the beginning
  while (Length(Str) > 0) and not(Str[1].IsLetter or (Str[1] = '_')) do
  begin
    Delete(Str, 1, 1);
    Result := 1;
  end;
  // delete illegal chars after the beginning
  Int := 2;
  while Int <= Length(Str) do
    if not(Str[Int].IsLetterOrDigit or (Str[Int] = '_')) then
    begin
      Delete(Str, Int, 1);
      Result := Int;
    end
    else
      Inc(Int);
end;

function TFClassEditor.MakeIdentifier(ComboBox: TComboBox): Boolean;
var
  ErrPos, Len: Integer;
  Str: string;
  OnChange: TNotifyEvent;
begin
  Result := True;
  Str := ComboBox.Text;
  ErrPos := MakeIdentifier(Str);
  if ErrPos = 0 then
    Exit;
  if ErrPos = -1 then
  begin
    Result := False;
    Exit;
  end;
  Len := Length(ComboBox.Text) - Length(Str);
  OnChange := ComboBox.OnChange;
  ComboBox.OnChange := nil;
  ComboBox.Text := Str;
  ComboBox.OnChange := OnChange;
  if Len = 1 then
    ComboBox.SelStart := ErrPos - 1
  else
    ComboBox.SelStart := Length(Str);
end;

function TFClassEditor.MakeIdentifier(Edit: TEdit): Boolean;
var
  ErrPos, ErrLen: Integer;
  Str: string;
  OnChange: TNotifyEvent;
begin
  Result := True;
  Str := Edit.Text;
  ErrPos := MakeIdentifier(Str);
  if ErrPos = 0 then
    Exit;
  Result := False;
  if ErrPos = -1 then
    Exit;
  ErrLen := Length(Edit.Text) - Length(Str);
  OnChange := Edit.OnChange;
  Edit.OnChange := nil;
  Edit.Text := Str;
  Edit.OnChange := OnChange;
  if ErrLen = 1 then
    Edit.SelStart := ErrPos - 1
  else
    Edit.SelStart := Length(Str);
end;

procedure TFClassEditor.ChangeAttribute(var Attribute: TAttribute;
  CName: string);
begin
  Attribute.Name := EAttributeName.Text;
  Attribute.TypeClassifier := MakeType(CBAttributeType);
  Attribute.Value := CBAttributeValue.Text;
  Attribute.Visibility := TVisibility(RGAttributeAccess.ItemIndex);
  Attribute.Static := CBAttributeStatic.Checked;
  Attribute.IsFinal := CBAttributeFinal.Checked;
end;

function TFClassEditor.MakeAttribute(CName: string): TAttribute;
begin
  Result := TAttribute.Create(nil);
  ChangeAttribute(Result, CName);
end;

function TFClassEditor.MakeType(ComboBox: TComboBox): TClassifier;
begin
  var
  Str := ComboBox.Text;
  var
  I := ComboBox.Items.IndexOf(Str);
  if I <> -1 then
    Str := ComboBox.Items[I];
  if Str = '' then
    Result := nil
  else
    Result := MakeType(Str);
end;

function TFClassEditor.MakeType(const Name: string): TClassifier;
var
  MyUnit: TUnitPackage;
  AClass: TClass;
begin
  Result := nil;
  MyUnit := FMyEditor.Model.ModelRoot.FindUnitPackage('Default');
  if Assigned(MyUnit) then
    Result := MyUnit.FindClassifier(Name, nil, True);
  if not Assigned(Result) then
  begin
    AClass := TClass.Create(nil);
    AClass.Name := Name;
    if Assigned(MyUnit) then
      MyUnit.AddClass(AClass);
    Result := AClass;
  end;
end;

procedure TFClassEditor.ChangeMethod(var Method: TOperation);
var
  Posi: Integer;
  Typ, Str, Value: string;
  Parameter: TParameter;
begin
  Method.Name := CBMethodName.Text;
  Method.ReturnValue := MakeType(CBMethodType);
  Method.OperationType := TOperationType(RGMethodKind.ItemIndex);
  Method.Visibility := TVisibility(RGMethodAccess.ItemIndex);
  if UUtils.Left(Method.Name, 2) = '__' then
    Method.Visibility := viPrivate;
  Method.IsStaticMethod := CBMethodStatic.Checked;
  Method.IsClassMethod := CBMethodClass.Checked;
  Method.IsAbstract := CBMethodAbstract.Checked;
  Method.NewParameters;
  for var I := 0 to LBParams.Items.Count - 1 do
  begin
    Str := LBParams.Items[I];
    Posi := Pos(' = ', Str);
    if Posi > 0 then
    begin
      Value := Copy(Str, Posi + 3, Length(Str));
      Delete(Str, Posi, Length(Str));
    end
    else
      Value := '';
    Posi := Pos(':', Str);
    if Posi > 0 then
    begin
      Typ := Copy(Str, Posi + 2, Length(Str));
      Delete(Str, Posi, Length(Str));
    end
    else
      Typ := '';
    Parameter := Method.AddParameter(Str);
    if Typ <> '' then
      Parameter.TypeClassifier := MakeType(Typ)
    else
      Parameter.TypeClassifier := nil;
    Parameter.Value := Value;
  end;
  if (CBParamName.Text <> '') and (CBParamType.Text <> '') then
    Method.AddParameter(CBParamName.Text).TypeClassifier :=
      MakeType(CBParamType);
end;

procedure TFClassEditor.UpdateTreeView;
var
  CIte, Ite: IModelIterator;
  Cent: TClassifier;
  Attribute: TAttribute;
  Method: TOperation;
  IsFirstClass: Boolean;
begin
  if FTreeViewUpdating then
    Exit;
  FTreeViewUpdating := True;
  TreeView.OnChange := nil;
  IsFirstClass := True;
  if FMyEditor.ReparseIfNeeded then
  begin
    TreeView.Items.BeginUpdate;
    TreeView.Items.Clear;
    CIte := FMyEditor.Model.ModelRoot.GetAllClassifiers;
    while CIte.HasNext do
    begin
      Cent := TClassifier(CIte.Next);
      if (Cent.Pathname <> FMyEditor.Pathname) or Cent.Anonym then
        Continue;
      if IsFirstClass then
      begin
        EClass.Text := GetShortType(Cent.ShortName);
        IsFirstClass := False;
      end;
      TVClass(Cent);
      Ite := Cent.GetAttributes;
      while Ite.HasNext do
      begin
        Attribute := Ite.Next as TAttribute;
        TVAttribute(Attribute);
      end;
      Ite := Cent.GetOperations;
      while Ite.HasNext do
      begin
        Method := Ite.Next as TOperation;
        TVMethod(Method);
      end;
    end;
    TreeView.FullExpand;
    TreeView.Items.EndUpdate;
  end;
  TreeView.OnChange := TreeViewChange;
  FTreeViewUpdating := False;
end;

function TFClassEditor.CreateTreeView(EditForm: TEditorForm;
  UMLForm: TFUMLForm): Boolean;
begin
  FMyUMLForm := UMLForm;
  FMyEditor := EditForm;
  FMyEditor.NeedsParsing := True;
  UpdateTreeView;
  if TreeView.Items.Count > 0 then
  begin
    TreeView.Selected := FAttributeNode;
    TreeView.TopItem := TreeView.Items.GetFirstNode;
  end;
  FMyEditor.Invalidate;
  Result := True;
end;

procedure TFClassEditor.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  Vis: Boolean;
begin
  if Action is TAction then
  begin
    if Assigned(FMyEditor) then
      Vis := not FMyEditor.ActiveSynEdit.ReadOnly
    else
      Vis := True;
    (Action as TAction).Enabled := Vis;
  end;
  Handled := True;
end;

procedure TFClassEditor.BParameterNewClick(Sender: TObject);
begin
  if CBParamName.Text <> '' then
  begin
    if (CBParamType.Text <> '') and (CBParamName.Items.IndexOf(CBParamName.Text)
      = -1) then
      CBParamName.Items.AddObject(CBParamName.Text,
        TParamTyp.Create(CBParamType.Text));
    TakeParameter;
    BMethodChangeClick(Self);
    if CBParamName.CanFocus then
      CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.BParameterDeleteClick(Sender: TObject);
begin
  CBParamName.Text := '';
  CBParamType.Text := '';
  CBParamValue.Text := '';
  SBDeleteClick(Self);
end;

procedure TFClassEditor.CBParamNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FComboBoxInvalid := False;
    CBParamNameSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBParamNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if CBParamName.Text <> '' then
    BMethodApply.Enabled := True;
  ShowMandatoryFields;
end;

procedure TFClassEditor.CBParamNameSelect(Sender: TObject);
var
  Str: string;
begin
  var
  Posi := CBParamName.ItemIndex;
  if (Posi = -1) or (CBParamName.Text <> CBParamName.Items[Posi]) then
    Str := CBParamName.Text
  else
    Str := CBParamName.Items[Posi];
  if not FComboBoxInvalid then
  begin
    if (-1 < Posi) and Assigned(CBParamName.Items.Objects[Posi]) then
      CBParamType.Text := TParamTyp(CBParamName.Items.Objects[Posi]).Typ;
    CBParamName.Text := Str;
    SBRightClick(Self);
  end;
end;

procedure TFClassEditor.AllAttributesAsParameters(Node: TTreeNode);
var
  Str, AClassname: string;
  CIte, Ite: IModelIterator;
  Cent: TClassifier;
  Attribute: TAttribute;
  Method: TOperation;
  Parameter: TParameter;
  Posi: Integer;

  procedure MakeParameterFromAttributes(Cent: TClassifier);
  begin
    var
    Ite := Cent.GetAttributes;
    while Ite.HasNext do
    begin
      Attribute := Ite.Next as TAttribute;
      Str := Attribute.ToNameTypeUML;
      if CBParameter.Items.IndexOf(Str) = -1 then
        CBParameter.Items.Add(Str);
    end;
  end;

begin
  CBParameter.Clear;
  AClassname := GetClassName(GetClassNode);
  Cent := GetClassifier(GetClassNode);
  if Assigned(Cent) then
  begin
    MakeParameterFromAttributes(Cent);
    while (Cent is TClass) and ((Cent as TClass).AncestorsCount > 0) do
    begin // ToDo n ancestors
      Cent := (Cent as TClass).Ancestor[0];
      MakeParameterFromAttributes(Cent);
    end;
  end;

  // look too in model of uml-diagram for ancestors
  if Assigned(FMyUMLForm) and Assigned(FMyUMLForm.MainModul) and
    Assigned(FMyUMLForm.MainModul.Model) and
    Assigned(FMyUMLForm.MainModul.Model.ModelRoot) then
  begin
    CIte := FMyUMLForm.MainModul.Model.ModelRoot.GetAllClassifiers;
    while CIte.HasNext do
    begin
      Cent := TClassifier(CIte.Next);
      if Cent.Name = AClassname then // ToDo check
        Break;
    end;
    if Cent.Name = AClassname then
      while (Cent is TClass) and ((Cent as TClass).AncestorsCount > 0) do
      begin // Todo n ancestors
        Cent := (Cent as TClass).Ancestor[0];
        MakeParameterFromAttributes(Cent);
      end;
  end;

  if Assigned(Node) and IsMethodsNodeLeaf(Node) then
  begin
    Method := GetMethod(Node);
    if Assigned(Method) then
    begin
      Ite := Method.GetParameters;
      while Ite.HasNext do
      begin
        Parameter := Ite.Next as TParameter;
        Str := Parameter.ToShortStringNode;
        Posi := CBParameter.Items.IndexOf(Str);
        if Posi > -1 then
          CBParameter.Items.Delete(Posi);
      end;
    end;
  end;
  CBParameter.Text := _('Select attribute');
end;

procedure TFClassEditor.ComboBoxCloseUp(Sender: TObject);
begin
  FComboBoxInvalid := False;
  (Sender as TComboBox).AutoComplete := True;
end;

procedure TFClassEditor.CBComboBoxEnter(Sender: TObject);
var
  ComboBox: TComboBox;
  Rect: TRect;
  LeftPart: Boolean;
begin
  if Sender is TComboBox then
  begin
    ComboBox := Sender as TComboBox;
    Rect := ComboBox.ClientRect;
    Rect.Width := Rect.Width - 20;
    Rect := ComboBox.ClientToScreen(Rect);
    LeftPart := Rect.Contains(Mouse.CursorPos);
    if LeftPart and (ComboBox.Items.Count > 0) then
      SendMessage(ComboBox.Handle, CB_SHOWDROPDOWN, 1, 0);
  end;
end;

procedure TFClassEditor.CBAttributeTypeDropDown(Sender: TObject);
begin
  SendMessage(CBAttributeType.Handle, WM_SETCURSOR, 0, 0);
end;

procedure TFClassEditor.CBAttributeValueDropDown(Sender: TObject);
begin
  SendMessage(CBAttributeValue.Handle, WM_SETCURSOR, 0, 0);
end;

procedure TFClassEditor.ComboBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ComboBox: TComboBox;
begin
  FComboBoxInvalid := True;
  if (Sender is TComboBox) and (Ord('0') <= Key) and (Key <= Ord('Z')) then
  begin
    ComboBox := Sender as TComboBox;
    if (0 < ComboBox.SelStart) and (ComboBox.SelStart < Length(ComboBox.Text))
    then
      ComboBox.AutoComplete := False;
  end;
end;

procedure TFClassEditor.CBAttributeTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FComboBoxInvalid := False;
    CBAttributeTypeSelect(Self);
  end;
end;

procedure TFClassEditor.CBAttributeTypeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    BAttributeApply.Enabled := True;
end;

procedure TFClassEditor.CBAttributeTypeSelect(Sender: TObject);
begin
  if not FComboBoxInvalid then
  begin
    var
    Posi := CBAttributeType.ItemIndex;
    if not((Posi = -1) or (CBAttributeType.Text <> CBAttributeType.Items[Posi]))
    then
      CBAttributeType.Text := CBAttributeType.Items[Posi];
    if NameTypeValueChanged then
      TThread.ForceQueue(nil,
        procedure
        begin
          BAttributeChangeClick(Self);
        end);
  end;
end;

procedure TFClassEditor.CBAttributeValueKeyPress(Sender: TObject;
var Key: Char);
begin
  BAttributeApply.Enabled := True;
  if (Key = #13) and NameTypeValueChanged then
    BAttributeChangeClick(Self);
  if Key = #13 then
    BAttributeNew.SetFocus;
end;

procedure TFClassEditor.CBAttributeValueKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    BAttributeApply.Enabled := True;
end;

procedure TFClassEditor.CBAttributeValueSelect(Sender: TObject);
var
  Str: string;
  Index: Integer;
begin
  Index := CBAttributeValue.ItemIndex;
  if (Index = -1) or (CBAttributeValue.Text <> CBAttributeValue.Items[Index])
  then
    Str := CBAttributeValue.Text
  else
    Str := CBAttributeValue.Items[Index];
  if not FComboBoxInvalid then
  begin
    CBAttributeValue.Text := Str;
    if NameTypeValueChanged then
      BAttributeChangeClick(Self);
    CBAttributeValue.AutoComplete := True;
  end;
end;

procedure TFClassEditor.CBClassAbstractClick(Sender: TObject);
begin
  BClassChangeClick(Self);
end;

procedure TFClassEditor.CBClassAbstractMouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BClassApply.Enabled := True;
end;

procedure TFClassEditor.EAttributeNameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and CBAttributeType.CanFocus then
    CBAttributeType.SetFocus;
end;

procedure TFClassEditor.EAttributeNameKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  BAttributeApply.Enabled := True;
  if Key = VK_RETURN then
    BAttributeChangeClick(Self);
end;

procedure TFClassEditor.EClassKeyPress(Sender: TObject; var Key: Char);
begin
  BClassApply.Enabled := True;
end;

procedure TFClassEditor.CBMethodnameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    BMethodChangeClick(Self);
    if CBMethodType.CanFocus then
      CBMethodType.SetFocus;
  end;
end;

procedure TFClassEditor.CBMethodnameKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  BMethodApply.Enabled := True;
end;

procedure TFClassEditor.CBMethodnameSelect(Sender: TObject);
var
  Str: string;
  Index: Integer;
begin
  Index := CBMethodName.ItemIndex;
  if (Index = -1) or (CBMethodName.Text <> CBMethodName.Items[Index]) then
    Str := CBMethodName.Text
  else
    Str := CBMethodName.Items[Index];
  if not FComboBoxInvalid then
  begin
    CBMethodName.Text := Str;
    if CBMethodName.Items.IndexOf(Str) = -11 then
      CBMethodName.Items.Add(Str);
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
  if Key = #13 then
  begin
    FComboBoxInvalid := False;
    BMethodChangeClick(Self);
    CBMethodTypeSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBMethodParamTypeKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    BMethodApply.Enabled := True;
end;

procedure TFClassEditor.CBMethodTypeSelect(Sender: TObject);
var
  Str: string;
  Index: Integer;
begin
  Index := CBMethodType.ItemIndex;
  if (Index = -1) or (CBMethodType.Text <> CBMethodType.Items[Index]) then
    Str := CBMethodType.Text
  else
    Str := CBMethodType.Items[Index];
  BMethodApply.Enabled := True;
  if not FComboBoxInvalid then
  begin
    CBMethodType.Text := Str;
    if (CBMethodName.Text <> '') and (CBMethodType.Text <> '') then
      BMethodChangeClick(Self);
    CBMethodType.AutoComplete := True;
  end;
end;

procedure TFClassEditor.CBParameterSelect(Sender: TObject);
begin
  var
  Str := CBParameter.Items[CBParameter.ItemIndex];
  if (Str <> _('Select attribute')) and (LBParams.Items.IndexOf(Str) = -1) then
  begin
    LBParams.Items.Add(Str);
    BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.CBParamTypeDropDown(Sender: TObject);
begin
  SendMessage(CBParamType.Handle, WM_SETCURSOR, 0, 0);
end;

procedure TFClassEditor.CBParamTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FComboBoxInvalid := False;
    CBParamTypeSelect(Self);
    CBParamName.SetFocus;
  end;
end;

procedure TFClassEditor.CBParameterKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FComboBoxInvalid := False;
    CBParameterSelect(Self);
  end;
end;

procedure TFClassEditor.CBParamTypeSelect(Sender: TObject);
var
  Str: string;
  Index: Integer;
begin
  Index := CBParamType.ItemIndex;
  if (Index = -1) or (CBParamType.Text <> CBParamType.Items[Index]) then
    Str := CBParamType.Text
  else
    Str := CBParamType.Items[Index];
  if not FComboBoxInvalid then
  begin
    CBParamType.Text := Str;
    if CBParamName.Text <> '' then
    begin
      BMethodChangeClick(Self);
      CBParamType.AutoComplete := True;
      TThread.ForceQueue(nil,
        procedure
        begin
          CBParamType.Text := '';
          CBParamName.SetFocus;
        end);
    end;
  end;
end;

function TFClassEditor.RGMethodKindHasChanged: Boolean;
begin
  Result := True;
  if (RGMethodKind.ItemIndex = 0) and (CBMethodName.Text <> '__init__') then
  begin
    if CBMethodType.Text = '' then
      RGMethodKind.ItemIndex := 2
    else
      RGMethodKind.ItemIndex := 1;
  end
  else if (RGMethodKind.ItemIndex > 0) and (CBMethodName.Text = '__init__') then
    RGMethodKind.ItemIndex := 0
  else
    Result := False;

  CBMethodName.Enabled := (RGMethodKind.ItemIndex > 0);
  CBMethodType.Enabled := (RGMethodKind.ItemIndex > 0);
  ShowMandatoryFields;
end;

procedure TFClassEditor.ShowMandatoryFields;
begin
  case PageControl.ActivePageIndex of
    1:
      if EAttributeName.Text = '' then
        EAttributeName.Color := clInfoBk
      else
        EAttributeName.Color := clWindow;
    2:
      begin
        if CBMethodName.Enabled and (CBMethodName.Text = '') then
          CBMethodName.Color := clInfoBk
        else
          CBMethodName.Color := clWindow;
        if CBMethodType.Enabled and (CBMethodType.Text = '') then
          CBMethodType.Color := clInfoBk
        else
          CBMethodType.Color := clWindow;
        if (CBParamName.Text <> '') and (CBParamType.Text = '') then
          CBParamType.Color := clInfoBk
        else
          CBParamType.Color := clWindow;
        if (CBParamName.Text = '') and (CBParamType.Text <> '') then
          CBParamName.Color := clInfoBk
        else
          CBParamName.Color := clWindow;
      end;
  end;
end;

function TFClassEditor.MethodToPython(Method: TOperation;
Source: string): string;
var
  Str, Str2, Indent2, Comment: string;
  Count: Integer;
  StringList: TStringList;

  procedure DelParam(const Param: string);
  var
    Int: Integer;
  begin
    Int := 0;
    while Int < StringList.Count do
      if Pos(Param, StringList[Int]) > 0 then
        StringList.Delete(Int)
      else
        Inc(Int);
  end;

  procedure AdjustReturnValue;
  const
    ReturnValues: array [1 .. 5] of string = (' return 0', ' return ""',
      ' return false', ' return ''\0''', ' return None');
  var
    Posi: Integer;
  begin
    for var I := 1 to 5 do
    begin
      Posi := Pos(ReturnValues[I], Source);
      if Posi > 0 then
      begin
        Delete(Source, Posi, Length(ReturnValues[I]));
        Insert(' return ' + Str2, Source, Posi);
        Break;
      end;
    end;
  end;

begin
  Indent2 := GetIndent(Method.Level + 2);
  if Pos('"""', Source) = 0 then
    Comment := FConfiguration.GetMultiLineComment(Indent2)
  else
    Comment := '';
  Str := Method.HeadToPython + CrLf;
  StringList := TStringList.Create;
  case Method.OperationType of
    otConstructor:
      Str := Str + Comment + MakeConstructor(Method, Source);
    otFunction:
      begin
        if Method.IsAbstract then
          Str := Str + Indent2 + Comment + 'pass'
        else
        begin
          if Assigned(Method.ReturnValue) then
            Str2 := Typ2Value(Method.ReturnValue.GetShortType)
          else
            Str2 := 'None';
          if Pos(' return ', Source) > 0 then
          begin
            AdjustReturnValue;
            Str := Str + Source;
          end
          else
          begin
            if (Source = '') or (Source = Indent2 + 'pass' + CrLf) then
              Str := Str + Comment + Indent2 + _(FLngTODO) + CrLf
            else
              Str := Str + Source;
            Str := Str + Indent2 + 'return ' + Str2 + CrLf;
          end;

          StringList.Text := Str;
          for var I := StringList.Count - 1 downto 0 do
            if Trim(StringList[I]) = 'pass' then
              StringList.Delete(I);
          Str := StringList.Text;
        end;
      end;
    otProcedure:
      begin
        if Method.IsAbstract then
          Str := Str + Indent2 + Comment + 'pass'
        else
        begin
          if (Source <> '') and (Source <> Indent2 + 'pass' + CrLf) then
          begin
            Count := 0;
            StringList.Text := Source;
            for var I := 0 to StringList.Count - 1 do
            begin
              if Trim(StringList[I]) = 'pass' then
                Inc(Count);
              if Pos(' return ', StringList[I]) > 0 then
              begin
                StringList[I] := Indent2 + 'pass';
                Inc(Count);
              end;
            end;
            var
            Int := 0;
            while Count > 1 do
            begin
              if Trim(StringList[Int]) = 'pass' then
              begin
                StringList.Delete(Int);
                Dec(Count);
              end
              else
                Inc(Int);
            end;
            if Count = 0 then
              StringList.Add(Indent2 + 'pass');
            Str := Str + StringList.Text;
          end
          else
            Str := Str + Comment + Indent2 + _(FLngTODO) + CrLf + Indent2 +
              'pass' + CrLf;
        end;
      end;
  end;
  if not Method.HasComment then
    Method.HasComment := (Comment <> '');
  Result := Str;
  FreeAndNil(StringList);
end;

procedure TFClassEditor.BMethodChangeClick(Sender: TObject);
var
  New, Source: string;
  Method: TOperation;
  ClassNumber, NodeIndex, TopItemIndex, From: Integer;
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  CBMethodType.Enabled := (RGMethodKind.ItemIndex = 1);
  if (not(MakeIdentifier(CBMethodName) and MakeIdentifier(CBMethodType) and
    MakeIdentifier(CBParamName) and MakeIdentifier(CBParamType)) or
    (CBMethodName.Text = '')) and (RGMethodKind.ItemIndex > 0) or
    not Assigned(Node) then
    Exit;

  ClassNumber := GetClassNumber(Node);
  NodeIndex := Node.AbsoluteIndex;
  TopItemIndex := TreeView.TopItem.AbsoluteIndex;
  TakeParameter;
  if RGMethodKindHasChanged then
    Exit;

  FMyEditor.ActiveSynEdit.BeginUpdate;
  if IsMethodsNode(Node) then
  begin
    if RGMethodKind.ItemIndex = 0 then
    begin
      Inc(NodeIndex);
      Node := Node.GetNext;
      while Assigned(Node) and (Node.ImageIndex = 4) do
      begin
        Inc(NodeIndex);
        Node := Node.GetNext;
      end;
    end
    else
      NodeIndex := NodeIndex + Node.Count + 1;
    Method := MakeMethod;
    Method.Level := GetLevel(Node);
    if not MethodAlreadyExists(Method.ToShortStringNode) then
    begin
      New := sLineBreak + MethodToPython(Method, '');
      if RGMethodKind.ItemIndex = 0 then
        FMyEditor.InsertConstructor(New, ClassNumber)
      else
        FMyEditor.InsertProcedure(New, ClassNumber);
    end
    else if (Sender = BMethodApply) then
      ErrorMsg(Format(_('%s already exists'), [Method.ToShortStringNode]));
    if Method.IsAbstract then
      FMyEditor.InsertImport('From abc import abstractmethod');
    FreeAndNil(Method);
  end
  else
  begin
    Method := GetMethod(Node);
    if Assigned(Method) then
    begin
      if Method.HasSourceCode then
      begin
        From := Method.LineS;
        if Method.IsStaticMethod then
          Inc(From);
        if Method.IsClassMethod then
          Inc(From);
        if Method.IsAbstract then
          Inc(From);
        if Method.IsPropertyMethod then
          Inc(From);
        Source := FMyEditor.GetSource(From, Method.LineE - 1);
      end
      else
        Source := '';
      ChangeMethod(Method);
      if Method.OperationType = otConstructor then
        New := MakeConstructor(Method, Source)
      else
        New := MethodToPython(Method, Source);
      ReplaceMethod(Method, New);
      if Method.IsAbstract then
        FMyEditor.InsertImport('From abc import abstractmethod');
    end;
  end;
  FMyEditor.Modified := True;
  FMyEditor.ActiveSynEdit.EndUpdate;
  UpdateTreeView;
  if (0 <= TopItemIndex) and (TopItemIndex < TreeView.Items.Count) then
    TreeView.TopItem := TreeView.Items[TopItemIndex];
  if (0 <= NodeIndex) and (NodeIndex < TreeView.Items.Count) then
    TreeView.Selected := TreeView.Items[NodeIndex];
  BMethodApply.Enabled := False;
end;

procedure TFClassEditor.ReplaceMethod(var Method: TOperation;
const New: string);
begin
  FMyEditor.ActiveSynEdit.BeginUpdate;
  FMyEditor.DeleteBlock(Method.LineS - 1, Method.LineE - 1);
  FMyEditor.InsertLinesAt(Method.LineS - 1, New);
  FMyEditor.ActiveSynEdit.EndUpdate;
end;

function TFClassEditor.MakeMethod: TOperation;
begin
  Result := TOperation.Create(nil);
  ChangeMethod(Result);
end;

procedure TFClassEditor.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath + '\RGAttributeAccess',
    RGAttributeAccess.ItemIndex);
  AppStorage.WriteBoolean(BasePath + '\CBGetMethod', CBGetMethod.Checked);
  AppStorage.WriteBoolean(BasePath + '\CBSetMethod', CBSetMethod.Checked);
  AppStorage.WriteInteger(BasePath + '\RGMethodKind', RGMethodKind.ItemIndex);
  AppStorage.WriteInteger(BasePath + '\RGMethodAccess',
    RGMethodAccess.ItemIndex);
end;

procedure TFClassEditor.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
const BasePath: string);
begin
  RGAttributeAccess.ItemIndex := AppStorage.ReadInteger
    (BasePath + '\RGAttributeAccess', 0);
  CBGetMethod.Checked := AppStorage.ReadBoolean
    (BasePath + '\CBGetMethod', False);
  CBSetMethod.Checked := AppStorage.ReadBoolean
    (BasePath + '\CBSetMethod', False);
  RGMethodKind.ItemIndex := AppStorage.ReadInteger
    (BasePath + '\RGMethodKind', 1);
  RGMethodAccess.ItemIndex := AppStorage.ReadInteger
    (BasePath + '\RGMethodAccess', 2);
end;

procedure TFClassEditor.SBDeleteClick(Sender: TObject);
begin
  var
  Int := LBParams.ItemIndex;
  LBParams.DeleteSelected;
  BMethodChangeClick(Self);
  if Int = LBParams.Count then
    Dec(Int);
  if Int >= 0 then
    LBParams.Selected[Int] := True;
end;

procedure TFClassEditor.SBDownClick(Sender: TObject);
begin
  var
  Int := LBParams.ItemIndex;
  if (0 <= Int) and (Int < LBParams.Count - 1) then
  begin
    LBParams.Items.Exchange(Int, Int + 1);
    BMethodChangeClick(Self);
    LBParams.Selected[Int + 1] := True;
  end;
end;

procedure TFClassEditor.SBUpClick(Sender: TObject);
begin
  var
  Int := LBParams.ItemIndex;
  if (0 < Int) and (Int < LBParams.Count) then
  begin
    LBParams.Items.Exchange(Int, Int - 1);
    BMethodChangeClick(Self);
    LBParams.Selected[Int - 1] := True;
  end;
end;

procedure TFClassEditor.SBLeftClick(Sender: TObject);
begin
  if (CBParamName.Text = '') and (CBParamType.Text = '') and
    (LBParams.ItemIndex < LBParams.Items.Count) and (0 <= LBParams.ItemIndex)
  then
  begin
    var
    Str := LBParams.Items[LBParams.ItemIndex];
    var
    Posi := Pos(' = ', Str);
    if Posi > 0 then
    begin
      CBParamValue.Text := Copy(Str, Posi + 3, Length(Str));
      Delete(Str, Posi, Length(Str));
    end;
    Posi := Pos(': ', Str);
    if Posi > 0 then
    begin
      CBParamType.Text := Copy(Str, Posi + 2, Length(Str));
      Delete(Str, Posi, Length(Str));
    end;
    CBParamName.Text := Str;
    LBParams.Items.Delete(LBParams.ItemIndex);
  end;
end;

function TFClassEditor.StrToPythonValue(Str: string): string;
begin
  Result := Trim(Str);
  if not(IsNumber(Result) or IsBool(Result) or (Result = 'None') or
    (Result <> '') and (Pos(Result[1], '[({''') > 0)) then
    Result := AsString(Result);
end;

procedure TFClassEditor.TakeParameter;
begin
  if CBParamName.Text <> '' then
  begin
    var
    Str := CBParamName.Text;
    if CBParamType.Text <> '' then
      Str := Str + ': ' + CBParamType.Text;
    if CBParamValue.Text <> '' then
      Str := Str + ' = ' + StrToPythonValue(CBParamValue.Text);
    LBParams.Items.Add(Str);
    CBParamName.Text := '';
    CBParamValue.Text := '';
    CBParamType.Text := '';
  end;
end;

procedure TFClassEditor.SBRightClick(Sender: TObject);
begin
  if CBParamName.Text <> '' then
  begin
    TakeParameter;
    BMethodChangeClick(Self);
  end;
end;

procedure TFClassEditor.Init;
begin
  EnableEvents(False);
  CBAttributeStatic.Checked := False;
  CBAttributeFinal.Checked := False;
  CBMethodStatic.Checked := False;
  CBMethodClass.Checked := False;
  CBMethodAbstract.Checked := False;
  if GuiPyOptions.DefaultModifiers then
  begin
    RGAttributeAccess.ItemIndex := -1;
    RGAttributeAccess.ItemIndex := 0;
    RGMethodKind.ItemIndex := 1;
    RGMethodAccess.ItemIndex := 3;
  end;
  if CBGetMethod.Visible then
    CBGetMethod.Checked := GuiPyOptions.GetMethodChecked;
  if CBSetMethod.Visible then
    CBSetMethod.Checked := GuiPyOptions.SetMethodChecked;

  EnableEvents(True);
end;

procedure TFClassEditor.TreeViewDragDrop(Sender, Source: TObject;
X, Y: Integer);
begin
  with TreeView do
  begin
    var
    TargetNode := GetNodeAt(X, Y); // Get target node
    if not Assigned(TargetNode) then
    begin
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
    Accept := True;
end;

procedure TFClassEditor.MoveNode(TargetNode, SourceNode: TTreeNode);
var
  From, Till, ATo, ToTill, NodeIndex: Integer;
  BlankLines: string;
  SourceModelEntity, TargetModelEntity: TModelEntity;
begin
  if IsClassNode(SourceNode) or IsAttributesNode(SourceNode) or
    IsMethodsNode(SourceNode) or IsClassNode(TargetNode) or
    FMyEditor.ActiveSynEdit.ReadOnly then
    Exit;

  if IsAttributesNode(TargetNode) or IsMethodsNode(TargetNode) then
    TargetNode := TargetNode.getFirstChild;
  if IsAttributesNodeLeaf(SourceNode) and IsAttributesNodeLeaf(TargetNode) then
  begin
    BlankLines := '';
    SourceModelEntity := GetAttribute(SourceNode);
    TargetModelEntity := GetAttribute(TargetNode);
  end
  else if IsMethodsNodeLeaf(SourceNode) and IsMethodsNodeLeaf(TargetNode) then
  begin
    BlankLines := #13#10;
    SourceModelEntity := GetMethod(SourceNode);
    TargetModelEntity := GetMethod(TargetNode);
  end
  else
    Exit;

  if Assigned(SourceModelEntity) then
  begin
    From := SourceModelEntity.LineS;
    Till := SourceModelEntity.LineE;
  end
  else
    Exit;

  if Assigned(TargetModelEntity) then
  begin
    ATo := TargetModelEntity.LineS;
    ToTill := TargetModelEntity.LineE;
  end
  else
    Exit;

  if IsMethodsNodeLeaf(SourceNode) and
    (Trim(FMyEditor.ActiveSynEdit.Lines[ToTill]) = '') then
    Inc(ToTill);
  if (From <= ATo) and (ATo <= Till) then
    Exit;
  FMyEditor.MoveBlock(From - 1, Till - 1, ATo - 1, ToTill - 1, BlankLines);
  NodeIndex := TargetNode.AbsoluteIndex;
  UpdateTreeView;
  if NodeIndex < TreeView.Items.Count then
    TreeView.Selected := TreeView.Items[NodeIndex];
end;

procedure TFClassEditor.LBParamsKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  if (Key = VK_DELETE) and not FMyEditor.ActiveSynEdit.ReadOnly then
    LBParams.DeleteSelected;
end;

function TFClassEditor.IsClassNode(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.ImageIndex = 0);
end;

function TFClassEditor.IsAttributesNodeLeaf(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.Parent.ImageIndex = 8);
end;

function TFClassEditor.IsAttributesNode(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.ImageIndex = 8);
end;

function TFClassEditor.IsMethodsNodeLeaf(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.Parent.ImageIndex = 9);
end;

function TFClassEditor.IsMethodsNode(Node: TTreeNode): Boolean;
begin
  Result := Assigned(Node) and (Node.ImageIndex = 9);
end;

function TFClassEditor.AttributeAlreadyExists(const Str: string): Boolean;
begin
  var
  Node := FAttributeNode.getFirstChild;
  while Assigned(Node) do
  begin
    var
    Posi := Pos(':', Node.Text);
    if Copy(Node.Text, 1, Posi - 1) = Str then
      Break;
    Node := Node.getNextSibling;
  end;
  Result := Assigned(Node);
end;

function TFClassEditor.MethodAlreadyExists(const Str: string): Boolean;
begin
  var
  Node := FMethodNode.getFirstChild;
  while Assigned(Node) and (Node.Text <> Str) do
    Node := Node.getNextSibling;
  Result := Assigned(Node);
end;

procedure TFClassEditor.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
  begin
    SBDelete.ImageIndex := 1;
    TreeView.Images := vilTreeViewDark;
  end
  else
  begin
    SBDelete.ImageIndex := 0;
    TreeView.Images := vilTreeViewLight;
  end;
end;

procedure TFClassEditor.FormAfterMonitorDpiChanged(Sender: TObject;
OldDPI, NewDPI: Integer);
begin
  ILClassEditor.SetSize(PPIScale(18), PPIScale(18));
  ChangeStyle;
end;

end.
