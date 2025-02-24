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
    procedure ImportOneFile(const FileName : string; withoutNeedSouce: Boolean = False); override;
    class function GetFileExtensions : TStringList; override;
  end;

  TPythonParser = class
  private
    FModel: TAbstractPackage;
    FUnit: TUnitPackage;
    FOM: TObjectModel;
    WithView: Boolean;
    FWithoutNeedSource: Boolean;
    fModule: TParsedModule;
    fFileName: string;
    ModVisibility: TVisibility;
    //function ShowView(IsInner: Boolean): Boolean;
  public
    constructor Create(aWithView: Boolean); virtual;
    procedure ParseModul(Module: TParsedModule; AModel: TAbstractPackage;
      AOM: TObjectModel; FileName: string; Level: Integer; withoutNeedSource: Boolean);
    procedure ParseClassDeclaration(ParsedClass: TParsedClass;
      Level: Integer; const ParentName: string = '');
    procedure ParseAttributes(C: TClass; Attributes: TObjectList; Level: Integer);
    procedure ParseMethods(C: TClass; ParsedClass: TParsedClass; Level: Integer);
    procedure DoOperation(ParsedFunction: TParsedFunction; O: TOperation;
                const ParentName: string; Level: Integer);
    procedure ParseFunction(ParsedFunction: TParsedFunction);
    function NeedClassifier(const ParentClass, CName: string): TClassifier;
    procedure SetAttributeVisibility(M: TModelEntity);
    procedure SetOperationVisibility(M: TModelEntity);
    procedure SetVisibility(M: TModelEntity);
    function IsTypename(const s: string): Boolean;
    function IsReservedWord(const s: string): Boolean;
  end;

implementation

uses SysUtils, Math, uEditAppIntfs, frmEditor, UConfiguration;

{ TPythonImporter }

const
  ReservedWords: array [0 .. 33] of string =
    ('False', 'None', 'True', 'and', 'as', 'assert', 'async',
     'await', 'break', 'class', 'def', 'del', 'elif',
     'else', 'except', 'finally', 'for', 'from', 'global', 'if',
     'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or',
     'pass', 'raise', 'return', 'try', 'while', 'with', 'yield');


procedure TPythonImporter.ImportOneFile(const FileName: string; withoutNeedSouce: Boolean);
var
  SourceScanner: IAsyncSourceScanner;
  SL: TStringList;
  Module: TParsedModule;
  Parser: TPythonParser;
  Encoding: TEncoding;
  Editor: IEditor;
begin
  Encoding:= FConfiguration.getEncoding(FileName);
  SL:= TStringList.Create;
  Editor:= GI_EditorFactory.GetEditorByName(filename);
  if Assigned(Editor)
    then SL.Text:= (Editor.Form as TEditorForm).SynEdit.Text
    else SL.LoadFromFile(FileName, Encoding);
  SourceScanner := TAsynchSourceScanner.Create(FileName, SL.Text);
  Module:= SourceScanner.ParsedModule;
  Parser:= TPythonParser.Create(True);
  try
    Parser.ParseModul(Module, Model.ModelRoot, Model, FileName, 0, withoutNeedSouce);
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
  AOM: TObjectModel; FileName: string; Level: Integer; withoutNeedSource: Boolean);
  var aClassifier: TClassifier; aClass: TClass; i: Integer;
    CE : TCodeElement;
begin
  fModule:= Module;
  FModel := AModel;
  fFilename:= FileName;
  FOM := AOM;
  FWithoutNeedSource:= withoutNeedSource;
  FUnit := (FModel as TLogicPackage).FindUnitPackage('Default');
  if not Assigned(FUnit) then
    FUnit := (FModel as TLogicPackage).AddUnit('Default');

  aClassifier:= FUnit.FindClass(FileName);
  if Assigned(aClassifier) and aClassifier.SourceRead then begin
    if aClassifier is TClass then begin
      aClass:= aClassifier as TClass;
      aClass.IsVisible:= True;
      FUnit.AddClass(aClass);
    end;
    Exit;
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
      Level: Integer; const ParentName: string = '');
var
  C: TClass;
  aClass: TClassifier;
  aClassname: string;
  i: Integer;
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
  C.IsVisible:= True;
  if C.IsVisible then
    FUnit.AddClass(C);
  SetVisibility(C);
  C.LineS:= ParsedClass.CodeBlock.StartLine;
  C.LineSE:= Max(ParsedClass.CodeBlock.LastCommentLine, ParsedClass.CodeBlock.StartLine);
  C.LineE:= ParsedClass.CodeBlock.EndLine;

  if ParsedClass.SuperClasses.Count > 0 then  // ToDo only one superclass
    for i:= 0 to ParsedClass.SuperClasses.Count - 1 do begin
      aClass := NeedClassifier('', ParsedClass.SuperClasses[i]);
      if Assigned(aClass) and (aClass is TClass) then
        C.AddAncestors(aClass as TClass);
    end;
  ParseAttributes(C, ParsedClass.Attributes, Level);
  ParseMethods(C, ParsedClass, Level);
end;

procedure TPythonParser.ParseAttributes(C: TClass; Attributes: TObjectList; Level: Integer);
  var i: Integer;
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
        Attribute.TypeClassifier:= NeedClassifier(C.Name, Variable.Typ);
      //if Variable.ObjType <> '' then
      //  Attribute.TypeClassifier:= NeedClassifier(C.Name, Variable.ObjType);
      Variablename:= WithoutVisibility(Variable.Name);
      if Variable.DefaultValue <> Variablename
        then Attribute.Value:= Variable.DefaultValue
        else Attribute.Value:= Variablename;
      SetAttributeVisibility(Attribute);
      Attribute.IsAbstract := False;
      Attribute.Level:= Level;
    end;
  end;
  FreeAndNil(SL);
end;

procedure TPythonParser.ParseMethods(C: TClass; ParsedClass: TParsedClass; Level: Integer);
  var i: Integer;
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
      if ParsedFunction.isAbstractMethod then
        C.IsAbstract:= true;
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
           const ParentName: string; Level: Integer);
var
  Param: TParameter;
  i: Integer;
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
  O.LineSE:= Max(ParsedFunction.Codeblock.LastCommentLine, ParsedFunction.CodeBlock.StartLine);
  O.LineE:= ParsedFunction.CodeBlock.EndLine;
  O.hasSourceCode:= True;
  O.isStaticMethod:= ParsedFunction.isStaticMethod;
  O.isClassMethod:= ParsedFunction.isClassMethod;
  O.isAbstract:= ParsedFunction.isAbstractMethod;
  O.isPropertyMethod:= ParsedFunction.isPropertyMethod;
  O.Level:= Level;
  SetOperationVisibility(O);
  if ParsedFunction.ReturnType <> '' then
    O.ReturnValue := NeedClassifier(Parentname, ParsedFunction.ReturnType);
  if O.Name = '__init__' then
    O.OperationType := otConstructor
  else if (ParsedFunction.ReturnType <> '') or (ParsedFunction.ReturnValue <> '') then
    O.OperationType := otFunction
  else
    O.OperationType := otProcedure;

  // Parameterlist
  Arguments:= ParsedFunction.Arguments;
  for i:= 0 to Arguments.Count - 1 do begin
    aVariable:= TVariable(Arguments[i]);
    Param := O.AddParameter(FormatVarArgument(aVariable));
    if aVariable.aType <> ''
      then Param.TypeClassifier:= NeedClassifier(Parentname, aVariable.aType)
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

function TPythonParser.NeedClassifier(const ParentClass, CName: string): TClassifier;

  function AddAClass(const CName: string): TClassifier;
  var
    C: TClass;
  begin
    Result := nil;
    C := FUnit.MakeClass(CName, '');
    if not Assigned(C) then
      Exit;
    C.Importname := CName;
    FUnit.AddClassWithoutShowing(C);
    Result := TClassifier(C);
  end;

begin
  Result := nil;
  if not Assigned(FUnit) then
    Exit;

  Result:= FUnit.FindClassifier(CName, TClass, True);
  if Result = nil then
    Result := AddAClass(CName);
//  if ParentClass = CName then
//    Result.Recursive:= true;
end;

{function TPythonParser.ShowView(IsInner: Boolean): Boolean;
begin
  Result := WithView;

  if FConfiguration.ShowPublicOnly and (ModVisibility <> viPublic) then
    Result := False;

  Result := Result or FConfiguration.ShowAlways;
  if IsInner then
    Result := true;
end;
}

procedure TPythonParser.SetAttributeVisibility(M: TModelEntity);
begin
  M.Visibility:= viPublic;
  if Pos('_', M.Name) = 1 then begin
    M.Visibility:= viProtected;
    M.Name:= Copy(M.Name, 2, Length(M.Name));
  end;
  if Pos('_', M.Name) = 1 then begin
    M.Visibility:= viPrivate;
    M.Name:= Copy(M.Name, 2, Length(M.Name));
  end;
end;

procedure TPythonParser.SetOperationVisibility(M: TModelEntity);
begin
  if isDunder(M.Name) then
    M.Visibility:= viPublic
  else
    setAttributeVisibility(M);
end;

procedure TPythonParser.SetVisibility(M: TModelEntity);
begin
  M.Visibility:= ModVisibility;
  M.Static := False;
  M.IsFinal := False;
  M.IsAbstract := False;
end;

function TPythonParser.IsTypename(const s: string): Boolean;
var
  ci, it: IModelIterator;
  Attr: TAttribute;
  cent: TModelEntity;
begin
  Result:= True;
  if IsSimpleType(s) then
    Exit;
  Result:= not IsReservedWord(s);
  if Result and Assigned(FUnit) then begin
    ci:= FUnit.GetClassifiers;
    while ci.HasNext do begin
      cent:= ci.Next;
      it:= (cent as TClassifier).GetAttributes;
      while it.HasNext do  begin
        Attr:= it.Next as TAttribute;
        if Attr.Name = s then
          Result:= False;
      end
    end;
  end;
end;

function TPythonParser.IsReservedWord(const s: string): Boolean;
var
  Left, Mid, Right: Integer;
begin
  Result := True;
  Left := 0;
  Right := High(ReservedWords);

  while Left <= Right do
  begin
    Mid := (Left + Right) div 2;
    if ReservedWords[Mid] = s then
      Exit;
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
