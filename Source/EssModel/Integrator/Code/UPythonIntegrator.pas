{-------------------------------------------------------------------------------
 Unit:     UPythonIntegrator
 Author:   Gerhard Röhner
 Date:     March 2021
 Purpose:  parser for python classes
-------------------------------------------------------------------------------}


unit UPythonIntegrator;

interface

uses Classes, Contnrs, cPythonSourceScanner, uIntegrator, uModel, uModelEntity,
     UUtils;

type

  // ordinary import of python code
  TPythonImporter = class(TImportIntegrator)
  public
    procedure ImportOneFile(const FileName : string; withoutNeedSouce: boolean = false); override;
    class function GetFileExtensions : TStringList; override;
  end;

  TPythonParser = class
  private
    FModel: TAbstractPackage;
    FUnit: TUnitPackage;
    FOM: TObjectModel;
    WithView: Boolean;
    FWithoutNeedSource: boolean;
    fModule: TParsedModule;
    fFileName: string;
    ModVisibility: TVisibility;
  public
    constructor Create(aWithView: Boolean); virtual;
    procedure ParseModul(Module: TParsedModule; AModel: TAbstractPackage;
      AOM: TObjectModel; FileName: string; Level: integer; withoutNeedSource: boolean);
    procedure ParseClassDeclaration(ParsedClass: TParsedClass;
      Level: integer; const ParentName: string = '');
    procedure ParseAttributes(C: TClass; Attributes: TObjectList; Level: integer);
    procedure ParseMethods(C: TClass; ParsedClass: TParsedClass; Level: integer);
    procedure DoOperation(ParsedFunction: TParsedFunction; O: TOperation;
                const ParentName: string; Level: integer);
    procedure ParseFunction(ParsedFunction: TParsedFunction);
    function NeedClassifier(const CName: string; TheClass: TModelEntityClass = nil): TClassifier;
    function ShowView(IsInner: Boolean): Boolean;
    procedure SetAttributeVisibility(M: TModelEntity);
    procedure SetOperationVisibility(M: TModelEntity);
    procedure SetVisibility(M: TModelEntity);
    function IsTypename(const s: string): Boolean;
    function IsReservedWord(const s: string): Boolean;
  end;

implementation

uses SysUtils, Math, UConfiguration, uCodeProvider;

{ TPythonImporter }

const
  ReservedWords: array [0 .. 33] of string =
    ('False', 'None', 'True', 'and', 'as', 'assert', 'async',
     'await', 'break', 'class', 'def', 'del', 'elif',
     'else', 'except', 'finally', 'for', 'from', 'global', 'if',
     'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or',
     'pass', 'raise', 'return', 'try', 'while', 'with', 'yield');


procedure TPythonImporter.ImportOneFile(const FileName: string; withoutNeedSouce: boolean);
var
  SourceScanner: IAsyncSourceScanner;
  SL: TStringList;
  Module: TParsedModule;
  Parser: TPythonParser;
  Encoding: TEncoding;
begin
  Encoding:= FConfiguration.getEncoding(Filename);
  SL:= TStringList.Create;
  SL.LoadFromFile(FileName, Encoding);
  SourceScanner := TAsynchSourceScanner.Create(FileName, SL.Text);
  Module:= SourceScanner.ParsedModule;
  Parser:= TPythonParser.Create(true);
  try
    Parser.ParseModul(Module, Model.ModelRoot, Model, Filename, 0, withoutNeedSouce);
  finally
    FreeAndNil(Parser);
  end;
  FreeAndNil(SL);
end;

class function TPythonImporter.GetFileExtensions: TStringList;
begin
  Result := TStringList.Create;
  Result.Values['.py'] := 'Python';
  Result.Values['.pyw'] := 'Python';
end;

{--- TPythonParser ------------------------------------------------------------}

constructor TPythonParser.Create(aWithView: Boolean);
begin
  Self.WithView := aWithView;
  ModVisibility:= viPublic;
end;

procedure TPythonParser.ParseModul(Module: TParsedModule; AModel: TAbstractPackage;
  AOM: TObjectModel; FileName: string; Level: integer; withoutNeedSource: boolean);
  var aClassifier: TClassifier; aClass: TClass; i: integer;
    CE : TCodeElement;
begin
  fModule:= Module;
  FModel := AModel;
  fFilename:= Filename;
  FOM := AOM;
  FWithoutNeedSource:= withoutNeedSource;
  FUnit := (FModel as TLogicPackage).FindUnitPackage('Default');
  if not Assigned(FUnit) then
    FUnit := (FModel as TLogicPackage).AddUnit('Default');

  aClassifier:= FUnit.FindClass(Filename);
  if assigned(aClassifier) and aClassifier.SourceRead then begin
    if aClassifier is TClass then begin
      aClass:= aClassifier as TClass;
      aClass.IsVisible:= true;
      FUnit.AddClass(aClass);
    end;
    exit;
  end;

  for i:= 0 to Module.ChildCount - 1 do begin
    CE := Module.Children[i];
    if CE is TParsedClass then
      ParseClassDeclaration(TParsedClass(CE), Level)
    else if CE is TParsedFunction then
      ParseFunction(TParsedFunction(CE));
  end;
end;

procedure TPythonParser.ParseClassDeclaration(ParsedClass: TParsedClass;
      Level: integer; const ParentName: string = '');
var
  C: TClass;
  aClass: TClassifier;
  aClassname: string;
  i: integer;
begin
  if Level > 0
    then aClassname := ParentName + '.' + ParsedClass.Name
    else aClassname := ParsedClass.Name;
  C := FUnit.MakeClass(aClassname, FFilename);
  C.Importname := aClassname;
  //C.aGeneric := aGeneric;
  C.Level := Level;
  //C.anonym := anonym;
  //C.IsVisible := ShowView(IsInner) and not anonym;
  C.IsVisible:= true;
  if C.IsVisible then
    FUnit.AddClass(C);
  SetVisibility(C);
  C.LineS:= ParsedClass.CodeBlock.StartLine;
  C.LineSE:= max(ParsedClass.CodeBlock.LastCommentLine, ParsedClass.CodeBlock.StartLine);
  C.LineE:= ParsedClass.CodeBlock.EndLine;

  if ParsedClass.SuperClasses.Count > 0 then  // ToDo only one superclass
    for i:= 0 to ParsedClass.SuperClasses.Count - 1 do begin
      aClass := NeedClassifier(ParsedClass.SuperClasses.Strings[i], TClass);
      if Assigned(aClass) and (aClass is TClass) then
        C.AddAncestors(aClass as TClass);
    end;
  ParseAttributes(C, ParsedClass.Attributes, Level);
  ParseMethods(C, ParsedClass, Level);
end;

procedure TPythonParser.ParseAttributes(C: TClass; Attributes: TObjectList; Level: integer);
  var i: integer;
    SL: TStringList;
    AttributeName, Variablename: string;
    Attribute: TAttribute;
    Variable: TVariable;
begin
  SL:= TStringList.Create;
  for i:= 0 to Attributes.Count - 1 do begin
    Variable:= TVariable(Attributes[i]);
    AttributeName:= Variable.Name;
    if SL.IndexOf(withoutArray(AttributeName)) = -1 then begin
      SL.Add(AttributeName);
      Attribute:= C.AddAttribute(AttributeName, nil);
      Attribute.LineS:= Variable.CodePos.LineNo;
      Attribute.LineE:= Variable.CodePos.LineNo;
      Attribute.Static:= (vaClassAttribute in Variable.Attributes);
      Attribute.IsFinal:= Variable.IsFinal;
      if Variable.Typ <> '' then
        Attribute.TypeClassifier:= NeedClassifier(Variable.Typ, TClass);
      Variablename:= WithoutVisibility(Variable.Name);
      if Variable.DefaultValue <> Variablename
        then Attribute.Value:= Variable.DefaultValue
        else Attribute.Value:= Variablename;
      SetAttributeVisibility(Attribute);
      Attribute.IsAbstract := false;
      Attribute.Level:= Level;
    end;
  end;
  FreeAndNil(SL);
end;

procedure TPythonParser.ParseMethods(C: TClass; ParsedClass: TParsedClass; Level: integer);
  var i: integer;
    CE : TCodeElement;
    ParsedFunction: TParsedFunction;
    Operation, OPTemp: TOperation;
begin
  for i:= 0 to ParsedClass.ChildCount - 1 do begin
    CE:= ParsedClass.Children[i];
    if CE is TParsedFunction then begin
      ParsedFunction:= TParsedFunction(CE);
      OpTemp := C.MakeOperation(ParsedFunction.Name, nil);
      DoOperation(ParsedFunction, OpTemp, C.Name, Level);
      Operation:= C.FindOperation(OpTemp);
      if Operation = nil then begin
        Operation:= OpTemp;
        C.AddOperation(Operation);
      end else
        FreeAndNil(OpTemp);
    end else if CE is TParsedClass then
      ParseClassDeclaration(TParsedClass(CE), Level + 1, C.Name);
  end;
end;

procedure TPythonParser.DoOperation(ParsedFunction: TParsedFunction; O: TOperation;
           const ParentName: string; Level: integer);
var
  Param: TParameter;
  i: integer;
  Arguments: TObjectList;
  aVariable: TVariable;

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
  O.ParentName := ParentName;
  O.LineS:= ParsedFunction.CodeBlock.StartLine;
  O.LineSE:= max(ParsedFunction.Codeblock.LastCommentLine, ParsedFunction.CodeBlock.StartLine);
  O.LineE:= ParsedFunction.CodeBlock.EndLine;
  O.hasSourceCode:= true;
  O.isStaticMethod:= ParsedFunction.isStaticMethod;
  O.isClassMethod:= ParsedFunction.isClassMethod;
  O.isAbstract:= ParsedFunction.isAbstractMethod;
  O.Level:= Level;
  SetOperationVisibility(O);
  if ParsedFunction.ReturnType <> '' then
    O.ReturnValue := NeedClassifier(ParsedFunction.ReturnType);
  if O.Name = '__init__' then
    O.OperationType := otConstructor
  else if ParsedFunction.ReturnType <> '' then
    O.OperationType := otFunction
  else
    O.OperationType := otProcedure;

  // Parameterlist
  Arguments:= ParsedFunction.Arguments;
  for i:= 0 to Arguments.Count - 1 do begin
    aVariable:= TVariable(Arguments[i]);
    Param := O.AddParameter(FormatVarArgument(aVariable));
    if aVariable.aType <> ''
      then Param.TypeClassifier:= NeedClassifier(aVariable.aType)
      else Param.TypeClassifier:= nil;
    Param.Value:= aVariable.DefaultValue;
  end;
end;

procedure TPythonParser.ParseFunction(ParsedFunction: TParsedFunction);
  var Operation: TOperation;
begin
  Operation := TOperation.Create(nil);
  Operation.Name := ParsedFunction.Name;
  Operation.ReturnValue:= nil;
  DoOperation(ParsedFunction, Operation, 'no parent', 1);
  FUnit.AddFunction(Operation);
end;

function TPythonParser.NeedClassifier(const CName: string; TheClass: TModelEntityClass = nil): TClassifier;

  function AddAClass(const CName: string): TClassifier;
  var
    C: TClass;
    I: TInterface;
  begin
    Result := nil;
    if TheClass = TInterface then begin
      I := FUnit.MakeInterface(CName, '');
      I.Importname := CName;
      FUnit.AddInterfaceWithoutShowing(I);
      Result := TClassifier(I);
    end else begin
      C := FUnit.MakeClass(CName, '');
      if not Assigned(C) then
        exit;
      C.Importname := CName;
      FUnit.AddClassWithoutShowing(C);
      Result := TClassifier(C);
    end;
  end;

begin
  Result := nil;
  if not assigned(FUnit) then
    exit;

  Result:= FUnit.FindClassifier(CName, TheClass, true);
  if Assigned(Result)
    then exit
    else Result := AddAClass(CName);
end;

function TPythonParser.ShowView(IsInner: Boolean): Boolean;
begin
  Result := WithView;
  {
  if FConfiguration.ShowPublicOnly and (ModVisibility <> viPublic) then
    Result := False;
  }
  Result := Result or FConfiguration.ShowAlways;
  if IsInner then
    Result := true;
end;

procedure TPythonParser.SetAttributeVisibility(M: TModelEntity);
begin
  M.Visibility:= viPublic;
  if Pos('_', M.Name) = 1 then begin
    M.Visibility:= viProtected;
    M.Name:= copy(M.Name, 2, length(M.Name));
  end;
  if Pos('_', M.Name) = 1 then begin
    M.Visibility:= viPrivate;
    M.Name:= copy(M.Name, 2, length(M.Name));
  end;
end;

procedure TPythonParser.SetOperationVisibility(M: TModelEntity);
begin
  if isDunder(M.Name) then
    M.Visibility:= viPrivate
  else
    setAttributeVisibility(M);
end;

procedure TPythonParser.SetVisibility(M: TModelEntity);
begin
  M.Visibility:= ModVisibility;
  M.Static := false;
  M.IsFinal := false;
  M.IsAbstract := false;
end;

function TPythonParser.IsTypename(const s: string): Boolean;
var
  ci, it: IModelIterator;
  Attr: TAttribute;
  cent: TModelEntity;
begin
  Result:= true;
  if IsSimpleType(s) then
    exit;
  Result:= not IsReservedWord(s);
  if Result and Assigned(FUnit) then begin
    ci:= FUnit.GetClassifiers;
    while ci.HasNext do begin
      cent:= ci.next;
      it:= (cent as TClassifier).GetAttributes;
      while it.HasNext do  begin
        Attr:= it.next as TAttribute;
        if Attr.Name = s then
          Result:= False;
      end
    end;
  end;
end;

function TPythonParser.IsReservedWord(const s: string): Boolean;
var
  Left, Mid, Right: integer;
begin
  Result := true;
  Left := 0;
  Right := High(ReservedWords);

  while Left <= Right do
  begin
    Mid := (Left + Right) div 2;
    if ReservedWords[Mid] = s then
      exit;
    if ReservedWords[Mid] > s then
      Right := Mid - 1
    else
      Left := Mid + 1;
  end;
  Result := False;
end;


initialization
  Integrators.Register(TPythonImporter);

end.
