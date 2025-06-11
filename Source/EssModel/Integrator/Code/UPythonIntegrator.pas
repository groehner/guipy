{ -------------------------------------------------------------------------------
  Unit:     UPythonIntegrator
  Author:   Gerhard Röhner
  Date:     March 2021
  Purpose:  parser for python classes
  ------------------------------------------------------------------------------- }

unit UPythonIntegrator;

interface

uses
  Classes,
  Contnrs,
  cPythonSourceScanner,
  UIntegrator,
  UModel,
  UModelEntity,
  UUtils;

type

  // ordinary import of python code
  TPythonImporter = class(TImportIntegrator)
  public
    procedure ImportOneFile(const Filename: string;
      WithoutNeedSouce: Boolean = False); override;
    class function GetFileExtensions: TStringList; override;
  end;

  TPythonParser = class
  private
    FModel: TAbstractPackage;
    FUnit: TUnitPackage;
    FOM: TObjectModel;
    FWithView: Boolean;
    FWithoutNeedSource: Boolean;
    FModule: TParsedModule;
    FFilename: string;
    FModVisibility: TVisibility;
  public
    constructor Create(WithView: Boolean); virtual;
    procedure ParseModul(Module: TParsedModule; AModel: TAbstractPackage;
      AOM: TObjectModel; Filename: string; Level: Integer;
      WithoutNeedSource: Boolean);
    procedure ParseClassDeclaration(ParsedClass: TParsedClass; Level: Integer;
      const ParentName: string = '');
    procedure ParseAttributes(AClass: TClass; Attributes: TObjectList;
      Level: Integer);
    procedure ParseMethods(AClass: TClass; ParsedClass: TParsedClass;
      Level: Integer);
    procedure DoOperation(ParsedFunction: TParsedFunction;
      Operation: TOperation; const ParentName: string; Level: Integer);
    procedure ParseFunction(ParsedFunction: TParsedFunction);
    function NeedClassifier(const ParentClass, CName: string): TClassifier;
    procedure SetAttributeVisibility(Model: TModelEntity);
    procedure SetOperationVisibility(Model: TModelEntity);
    procedure SetVisibility(Model: TModelEntity);
    function IsTypename(const Identifier: string): Boolean;
    function IsReservedWord(const Word: string): Boolean;
  end;

implementation

uses SysUtils, Math, uEditAppIntfs, frmEditor, UConfiguration;

{ TPythonImporter }

const
  ReservedWords: array [0 .. 33] of string = ('False', 'None', 'True', 'and',
    'as', 'assert', 'async', 'await', 'break', 'class', 'def', 'del', 'elif',
    'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in',
    'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try',
    'while', 'with', 'yield');

procedure TPythonImporter.ImportOneFile(const Filename: string;
  WithoutNeedSouce: Boolean);
var
  SourceScanner: IAsyncSourceScanner;
  StringList: TStringList;
  Module: TParsedModule;
  Parser: TPythonParser;
  Encoding: TEncoding;
  Editor: IEditor;
begin
  Encoding := FConfiguration.getEncoding(Filename);
  StringList := TStringList.Create;
  Editor := GI_EditorFactory.GetEditorByName(Filename);
  if Assigned(Editor) then
    StringList.Text := (Editor.Form as TEditorForm).SynEdit.Text
  else
    StringList.LoadFromFile(Filename, Encoding);
  SourceScanner := TAsynchSourceScanner.Create(Filename, StringList.Text);
  Module := SourceScanner.ParsedModule;
  Parser := TPythonParser.Create(True);
  try
    Parser.ParseModul(Module, Model.ModelRoot, Model, Filename, 0,
      WithoutNeedSouce);
  finally
    FreeAndNil(Parser);
  end;
  FreeAndNil(StringList);
end;

class function TPythonImporter.GetFileExtensions: TStringList;
begin
  Result := TStringList.Create;
  Result.Values['.py'] := 'Python';
  Result.Values['.pyw'] := 'Python';
end;

{ --- TPythonParser ------------------------------------------------------------ }

constructor TPythonParser.Create(WithView: Boolean);
begin
  FWithView := WithView;
  FModVisibility := viPublic;
end;

procedure TPythonParser.ParseModul(Module: TParsedModule;
  AModel: TAbstractPackage; AOM: TObjectModel; Filename: string; Level: Integer;
  WithoutNeedSource: Boolean);
var
  AClassifier: TClassifier;
  AClass: TClass;
  CodeElement: TCodeElement;
begin
  FModule := Module;
  FModel := AModel;
  FFilename := Filename;
  FOM := AOM;
  FWithoutNeedSource := WithoutNeedSource;
  FUnit := (FModel as TLogicPackage).FindUnitPackage('Default');
  if not Assigned(FUnit) then
    FUnit := (FModel as TLogicPackage).AddUnit('Default');

  AClassifier := FUnit.FindClass(Filename);
  if Assigned(AClassifier) and AClassifier.SourceRead then
  begin
    if AClassifier is TClass then
    begin
      AClass := AClassifier as TClass;
      AClass.IsVisible := True;
      FUnit.AddClass(AClass);
    end;
    Exit;
  end;

  for var I := 0 to Module.ChildCount - 1 do
  begin
    CodeElement := Module.Children[I];
    if CodeElement is TParsedClass then
      ParseClassDeclaration(TParsedClass(CodeElement), Level)
    else if CodeElement is TParsedFunction then
      ParseFunction(TParsedFunction(CodeElement));
  end;
end;

procedure TPythonParser.ParseClassDeclaration(ParsedClass: TParsedClass;
  Level: Integer; const ParentName: string = '');
var
  AClass: TClass;
  AClassifier: TClassifier;
  AClassname: string;
begin
  if Level > 0 then
    AClassname := ParentName + '.' + ParsedClass.Name
  else
    AClassname := ParsedClass.Name;
  AClass := FUnit.MakeClass(AClassname, FFilename);
  AClass.Importname := AClassname;
  AClass.Level := Level;
  AClass.IsVisible := True;
  if AClass.IsVisible then
    FUnit.AddClass(AClass);
  SetVisibility(AClass);
  AClass.LineS := ParsedClass.CodeBlock.StartLine;
  AClass.LineSE := Max(ParsedClass.CodeBlock.LastCommentLine,
    ParsedClass.CodeBlock.StartLine);
  AClass.LineE := ParsedClass.CodeBlock.EndLine;

  if ParsedClass.SuperClasses.Count > 0 then // ToDo only one superclass
    for var I := 0 to ParsedClass.SuperClasses.Count - 1 do
    begin
      AClassifier := NeedClassifier('', ParsedClass.SuperClasses[I]);
      if Assigned(AClassifier) and (AClassifier is TClass) then
        AClass.AddAncestors(AClassifier as TClass);
    end;
  ParseAttributes(AClass, ParsedClass.Attributes, Level);
  ParseMethods(AClass, ParsedClass, Level);
end;

procedure TPythonParser.ParseAttributes(AClass: TClass; Attributes: TObjectList;
  Level: Integer);
var
  StringList: TStringList;
  AttributeName, Variablename: string;
  Attribute: TAttribute;
  Variable: TVariable;
begin
  StringList := TStringList.Create;
  for var I := 0 to Attributes.Count - 1 do
  begin
    Variable := TVariable(Attributes[I]);
    AttributeName := Variable.Name;
    if StringList.IndexOf(WithoutArray(AttributeName)) = -1 then
    begin
      StringList.Add(AttributeName);
      Attribute := AClass.AddAttribute(AttributeName, nil);
      Attribute.LineS := Variable.CodePos.LineNo;
      Attribute.LineE := Variable.CodePos.LineNo;
      Attribute.Static := (vaClassAttribute in Variable.Attributes);
      Attribute.IsFinal := Variable.IsFinal;
      if Variable.Typ <> '' then
        Attribute.TypeClassifier := NeedClassifier(AClass.Name, Variable.Typ);
      Variablename := WithoutVisibility(Variable.Name);
      if Variable.DefaultValue <> Variablename then
        Attribute.Value := Variable.DefaultValue
      else
        Attribute.Value := Variablename;
      SetAttributeVisibility(Attribute);
      Attribute.IsAbstract := False;
      Attribute.Level := Level;
    end;
  end;
  FreeAndNil(StringList);
end;

procedure TPythonParser.ParseMethods(AClass: TClass; ParsedClass: TParsedClass;
  Level: Integer);
var
  CodeEditor: TCodeElement;
  ParsedFunction: TParsedFunction;
  Operation, OPTemp: TOperation;
begin
  for var I := 0 to ParsedClass.ChildCount - 1 do
  begin
    CodeEditor := ParsedClass.Children[I];
    if CodeEditor is TParsedFunction then
    begin
      ParsedFunction := TParsedFunction(CodeEditor);
      OPTemp := AClass.MakeOperation(ParsedFunction.Name, nil);
      DoOperation(ParsedFunction, OPTemp, AClass.Name, Level);
      if ParsedFunction.isAbstractMethod then
        AClass.IsAbstract := True;
      Operation := AClass.FindOperation(OPTemp);
      if not Assigned(Operation) then
      begin
        Operation := OPTemp;
        AClass.AddOperation(Operation);
      end
      else
        FreeAndNil(OPTemp);
    end
    else if CodeEditor is TParsedClass then
      ParseClassDeclaration(TParsedClass(CodeEditor), Level + 1, AClass.Name);
  end;
end;

procedure TPythonParser.DoOperation(ParsedFunction: TParsedFunction;
  Operation: TOperation; const ParentName: string; Level: Integer);
var
  Param: TParameter;
  Arguments: TObjectList;
  Variable: TVariable;

  function FormatVarArgument(Variable: TVariable): string;
  begin
    if vaStarArgument in Variable.Attributes then
      Result := '*' + Variable.Name
    else if vaStarStarArgument in Variable.Attributes then
      Result := '**' + Variable.Name
    else
      Result := Variable.Name;
  end;

begin
  Operation.Parentname := ParentName;
  Operation.LineS := ParsedFunction.CodeBlock.StartLine;
  Operation.LineSE := Max(ParsedFunction.CodeBlock.LastCommentLine,
    ParsedFunction.CodeBlock.StartLine);
  Operation.LineE := ParsedFunction.CodeBlock.EndLine;
  Operation.HasSourceCode := True;
  Operation.IsStaticMethod := ParsedFunction.IsStaticMethod;
  Operation.IsClassMethod := ParsedFunction.IsClassMethod;
  Operation.IsAbstract := ParsedFunction.isAbstractMethod;
  Operation.IsPropertyMethod := ParsedFunction.IsPropertyMethod;
  Operation.Level := Level;
  SetOperationVisibility(Operation);
  if ParsedFunction.ReturnType <> '' then
    Operation.ReturnValue := NeedClassifier(ParentName,
      ParsedFunction.ReturnType);
  if Operation.Name = '__init__' then
    Operation.OperationType := otConstructor
  else if (ParsedFunction.ReturnType <> '') or (ParsedFunction.ReturnValue <> '')
  then
    Operation.OperationType := otFunction
  else
    Operation.OperationType := otProcedure;

  // Parameterlist
  Arguments := ParsedFunction.Arguments;
  for var I := 0 to Arguments.Count - 1 do
  begin
    Variable := TVariable(Arguments[I]);
    Param := Operation.AddParameter(FormatVarArgument(Variable));
    if Variable.aType <> '' then
      Param.TypeClassifier := NeedClassifier(ParentName, Variable.aType)
    else
      Param.TypeClassifier := nil;
    Param.Value := Variable.DefaultValue;
  end;
end;

procedure TPythonParser.ParseFunction(ParsedFunction: TParsedFunction);
var
  Operation: TOperation;
begin
  Operation := TOperation.Create(nil);
  Operation.Name := ParsedFunction.Name;
  Operation.ReturnValue := nil;
  DoOperation(ParsedFunction, Operation, 'no parent', 1);
  FUnit.AddFunction(Operation);
end;

function TPythonParser.NeedClassifier(const ParentClass, CName: string)
  : TClassifier;

  function AddAClass(const CName: string): TClassifier;
  var
    AClass: TClass;
  begin
    Result := nil;
    AClass := FUnit.MakeClass(CName, '');
    if not Assigned(AClass) then
      Exit;
    AClass.Importname := CName;
    FUnit.AddClassWithoutShowing(AClass);
    Result := TClassifier(AClass);
  end;

begin
  Result := nil;
  if not Assigned(FUnit) then
    Exit;

  Result := FUnit.FindClassifier(CName, TClass, True);
  if not Assigned(Result) then
    Result := AddAClass(CName);
end;

procedure TPythonParser.SetAttributeVisibility(Model: TModelEntity);
begin
  Model.Visibility := viPublic;
  if Pos('_', Model.Name) = 1 then
  begin
    Model.Visibility := viProtected;
    Model.Name := Copy(Model.Name, 2, Length(Model.Name));
  end;
  if Pos('_', Model.Name) = 1 then
  begin
    Model.Visibility := viPrivate;
    Model.Name := Copy(Model.Name, 2, Length(Model.Name));
  end;
end;

procedure TPythonParser.SetOperationVisibility(Model: TModelEntity);
begin
  if isDunder(Model.Name) then
    Model.Visibility := viPublic
  else
    SetAttributeVisibility(Model);
end;

procedure TPythonParser.SetVisibility(Model: TModelEntity);
begin
  Model.Visibility := FModVisibility;
  Model.Static := False;
  Model.IsFinal := False;
  Model.IsAbstract := False;
end;

function TPythonParser.IsTypename(const Identifier: string): Boolean;
var
  CIte, Ite: IModelIterator;
  Attr: TAttribute;
  Cent: TModelEntity;
begin
  Result := True;
  if IsSimpleType(Identifier) then
    Exit;
  Result := not IsReservedWord(Identifier);
  if Result and Assigned(FUnit) then
  begin
    CIte := FUnit.GetClassifiers;
    while CIte.HasNext do
    begin
      Cent := CIte.Next;
      Ite := (Cent as TClassifier).GetAttributes;
      while Ite.HasNext do
      begin
        Attr := Ite.Next as TAttribute;
        if Attr.Name = Identifier then
          Result := False;
      end;
    end;
  end;
end;

function TPythonParser.IsReservedWord(const Word: string): Boolean;
var
  Left, Mid, Right: Integer;
begin
  Result := True;
  Left := 0;
  Right := High(ReservedWords);

  while Left <= Right do
  begin
    Mid := (Left + Right) div 2;
    if ReservedWords[Mid] = Word then
      Exit;
    if ReservedWords[Mid] > Word then
      Right := Mid - 1
    else
      Left := Mid + 1;
  end;
  Result := False;
end;

initialization

Integrators.Register(TPythonImporter);

end.
