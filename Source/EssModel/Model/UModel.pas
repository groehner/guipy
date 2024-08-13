{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde,
  Gerhard Röhner

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

unit UModel;

{
  Classes to represent the object model.
}

interface

uses Contnrs, Classes, uListeners, uModelEntity, uUtils;

const
  ConfigFileExt = '.puml';

type
  TLogicPackage = class;
  TUnitPackage = class;

  TOperationType = (otConstructor, otFunction, otProcedure, otDestructor);

  TObjectModel = class
  private
    Listeners: TInterfaceList;
    FModelRoot: TLogicPackage;
    FUnknownPackage: TUnitPackage;
    FLocked: integer;
    procedure CreatePackages;
  public
    NameCache: TStringList;
    constructor Create;
    destructor Destroy; override;
    procedure Fire(Method: TListenerMethodType; Info: TModelEntity = nil);
    procedure AddListener(NewListener: IUnknown);
    procedure RemoveListener(Listener: IUnknown);
    procedure ClearListeners;
    procedure Clear;
    procedure Lock;
    procedure Unlock;
    function debug: string;
    property ModelRoot: TLogicPackage read FModelRoot;
    property Locked: integer read FLocked write FLocked;
    property UnknownPackage: TUnitPackage read FUnknownPackage;
  end;

  TFeature = class(TModelEntity);

  TClassifier = class(TModelEntity)
  private
    FFeatures: TObjectList;
  public
    Pathname: string;
    Importname: string;
    aGeneric: string;
    GenericName: string;
    Inner: boolean;
    Anonym: boolean;
    SourceRead: boolean;
    //Recursive: boolean;
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    function GetFeatures : IModelIterator;
    function GetShortType: String;
    function GetAttributes : IModelIterator;
    function GetAllAttributes: IModelIterator;
    function GetOperations : IModelIterator;
    function getName: string;
    //function isReference: boolean;
    function getAncestorName(index: integer): string; virtual;
    function asValue: string;
    function asType: string;
    function asUMLType: string;
    function ValueToType(Value: string): string;
    procedure setCapacity(capacity: integer);
  end;

  TParameter = class(TModelEntity)
  private
    FTypeClassifier : TClassifier;
    FUsedForAttribute: boolean;
    FValue: string;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(aOwner: TModelEntity); override;
    function asPythonString: string;
    function asUMLString(ShowParameter: integer): string;
    function toShortStringNode: string;
    property TypeClassifier : TClassifier read FTypeClassifier write FTypeClassifier;
    property UsedForAttribute : Boolean read FUsedForAttribute write FUsedForAttribute;
    property Value: string read fValue write fValue;
  end;

  TAttribute = class(TFeature)
  private
    FTypeClassifier: TClassifier;  // reference
    FValue: string;
    FConnected: boolean;
    procedure SetTypeClassifier(const Value: TClassifier);
    procedure SetValue(const Value: string);
    procedure SetConnected(Value: boolean);
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(aOwner: TModelEntity); override;
    property TypeClassifier: TClassifier read FTypeClassifier write SetTypeClassifier;
    property Value: string read FValue write SetValue;
    property Connected: boolean read FConnected write SetConnected;
    function toPython(TypeChanged: boolean): string;
    function toNameType: string;
    function toNameTypeUML: string;
    function VisName: string;
  end;

  TOperation = class(TFeature)
  private
    FOperationType: TOperationType;
    FParameters: TObjectList;
    FReturnValue: TClassifier;
    FAttributes: TObjectList; // local variables
    procedure SetOperationType(const Value: TOperationType);
    procedure SetReturnValue(const Value: TClassifier);
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    hasSourceCode: boolean;
    hasComment: boolean;
    isStaticMethod: boolean;
    isClassMethod: boolean;
    isPropertyMethod: boolean;
    Parentname: String;
    Annotation: String;
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    procedure NewParameters;
    function AddParameter(const NewName: string): TParameter;
    procedure DelParameter(const NewName: string);
    property OperationType: TOperationType read FOperationType write SetOperationType;
    property ReturnValue: TClassifier read FReturnValue write SetReturnValue;
    function GetParameters : IModelIterator;
    function AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute; // local variables
    function GetAttributes : IModelIterator;
    function toShortStringWithoutParameterNames: string;
    function toShortStringNode: string;
    function VisName: string;
    function HeadToPython: string;
    procedure setAttributeScope(aScopeDepth, aLineE: integer);
    function getFormattedDescription: string;
  end;

  TProperty = class(TAttribute)
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  end;

  TDataType = class(TClassifier)
    {From UML-spec: A descriptor of a set of values that lack identity and whose
    operations do not have side effects. Datatypes include
    primitive pre-defined types and user-definable types. Pre-defined
    types include numbers, string and time. User-definable
    types include enumerations.}
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  end;

  TInterface = class(TClassifier)
  private
    FAncestor: TInterface;
    FExtends: TObjectList;
    procedure SetAncestor(const Value: TInterface);
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    function AddOperation(const NewName: string; TypeClass: TClassifier): TOperation;
    function AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
    function AddExtends(I: TInterface): TInterface;
    procedure ViewExtends(I: TInterface);
    property Ancestor: TInterface read FAncestor write SetAncestor;
    function GetExtends : IModelIterator;
    function GetImplementingClasses : IModelIterator;
    function getAncestorName(index: integer): String; override;
  end;

  TClass = class(TClassifier, IBeforeClassListener)
  private
    FAncestor: TClass;
    FAncestors: TObjectList;
    FImplements: TObjectList;
    FisJUnitTestClass: boolean;
    procedure SetAncestor(Index: integer; const Value: TClass);
    function GetAncestor(Index: integer): TClass;
    //Ancestorlisteners
    procedure AncestorChange(Sender: TModelEntity);
    procedure AncestorAddChild(Sender: TModelEntity; NewChild: TModelEntity);
    procedure AncestorRemove(Sender: TModelEntity);
    procedure AncestorEntityChange(Sender: TModelEntity);
    function AncestorQueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): HResult; stdcall;
    procedure IBeforeClassListener.Change = AncestorChange;
    procedure IBeforeClassListener.EntityChange = AncestorEntityChange;
    procedure IBeforeClassListener.AddChild = AncestorAddChild;
    procedure IBeforeClassListener.Remove = AncestorRemove;
    function IBeforeClassListener.QueryInterface = AncestorQueryInterface;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    function MakeOperation(const NewName: string; TypeClass: TClassifier): TOperation;
    procedure AddOperation(Operation: TOperation);
    function AddOperationWithoutType(Const NewName: string): TOperation;
    function AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
    function AddProperty(const NewName: string): TProperty;
    function AddImplements(I: TInterface): TInterface;
    function AddAncestors(C: TClass): TClass;
    procedure ViewImplements(I: TInterface);
    property Ancestor[Index: integer]: TClass read GetAncestor write SetAncestor;
    property isJUnitTestClass: boolean read FisJUnitTestClass write FisJUnitTestClass;
    function GetImplements : IModelIterator;
    function GetDescendants : IModelIterator;
    function FindOperation(O : TOperation) : TOperation;
    function OperationIsProperty(Name: string): boolean;
    function FindAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
    function GetTyp: string;
    function getAncestorName(index: integer): String; override;
    function AncestorsCount: integer;
    function AncestorsAsString: string;
  end;

  TJUnitClass = class(TClass, IBeforeClassListener) // ToDo test
  end;

  TObjekt = class(TClassifier)
  private
    // FName: string; inherited
    aClass: TClass;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    function AddAttribute(const NewName: string): TAttribute;
    function AddOperation(const NewName: string): TOperation;
    procedure RefreshEntities;
    function getTyp: TClass;
    function GenericName: String;
  end;

  TAbstractPackage = class(TModelEntity)
  private
    ConfigFile : string;
  public
    procedure SetConfigFile(const Value : string);
    function GetConfigFile : string;
  end;

  //Represents the link between one package that uses another
  TUnitDependency = class(TModelEntity)
  public
    myPackage : TUnitPackage;
  end;

  TUnitPackage = class(TAbstractPackage)
  private
    FClassifiers: TObjectList;
    FUnitDependencies: TObjectList;
    FFunctions: TObjectList;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    ImportStartline: integer;
    ImportEndline: integer;
    FullImports: TStringList;
    ClassImports: TStringList;
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    procedure Clear;
    function MakeClass(const NewName, Filename: string): TClass;
    procedure AddClass(const aClass: TClass);
    procedure AddClassWithoutShowing(const aClass: TClass);
    function MakeInterface(const NewName, filename: string): TInterface;
    procedure AddInterface(const aInterface: TInterface);
    procedure AddInterfaceWithoutShowing(const aInterface: TInterface);    
    function AddDatatype(const NewName: string): TDataType;
    function AddObject(const NewName: string; aClass: TClass): TObjekt;
    procedure AddFunction(const Operation: TOperation);
    procedure DeleteObject(aName: string);
    function GetObject(const aName: string): TObjekt;
    function AddUnitDependency(U : TUnitPackage; aVisibility : TVisibility): TUnitDependency;
    function FindClassifier(const CName: string; TheClass : TModelEntityClass = nil;
              CaseSense : boolean = False): TClassifier;
    function FindClass(const Pathname: string): TClassifier;
    function GetClassifiers : IModelIterator;
    function GetUnitDependencies : IModelIterator;
    function GetObjects(const Typ: string): TStringList;
    function GetFunctions: IModelIterator;
    function GetAllObjects: TStringList;
    function GetObjekt(const aName, Typ: string): TObjekt;
    function Debug: string;
  end;

  TLogicPackage = class(TAbstractPackage)
  private
    FPackages: TObjectList;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    Files: TStringList;
    constructor Create(aOwner: TModelEntity); override;
    destructor Destroy; override;
    procedure Clear;
    function AddUnit(const NewUnitName: string): TUnitPackage;
    // might need a AddLogicPackage also
    function FindUnitPackage(const PName: string; CaseSense : boolean = False): TUnitPackage;
    function GetPackages : IModelIterator;
    function GetAllUnitPackages : IModelIterator;
    function GetAllClassifiers : IModelIterator;
    function GetFunctions: IModelIterator;
    function Debug: string;
  end;

  function AllClassesPackage : TAbstractPackage;
  procedure AllClassesPackageClose;

implementation

uses SysUtils, Types, uIterators, UConfiguration;

const
  UNKNOWNPACKAGE_NAME = '<<Unknown>>';

type
  //Used by Class.GetDescendant
  TClassDescendantFilter = class(TIteratorFilter)
  private
    Ancestor : TClass;
  public
    constructor Create(aAncestor : TClass);
    function Accept(M : TModelEntity) : boolean; override;
  end;

  //Used by Interface.GetImplementingClasses
  TInterfaceImplementsFilter = class(TIteratorFilter)
  private
    Int : TInterface;
  public
    constructor Create(I : TInterface);
    function Accept(M : TModelEntity) : boolean; override;
  end;

  TStrCompare = function(const S1, S2: string): Integer;

const
  CompareFunc : array[boolean] of TStrCompare = (CompareText, CompareStr);

{ TObjectModel }

constructor TObjectModel.Create;
begin
  Listeners := TInterfaceList.Create;
  NameCache:= TStringList.Create;
  CreatePackages;
end;

destructor TObjectModel.Destroy;
begin
  FreeAndNil(FModelRoot);
  // FUnknownPackage will be freed by FModelRoot who owns it
  FreeAndNil(Listeners);
  for var i:= 0 to NameCache.Count - 1 do
    FreeAndNil(NameCache.Objects[i]);
  FreeAndNil(NameCache);
  inherited;
end;

procedure TObjectModel.Clear;
begin
  // model must be locked, otherwise events will be fired back to
  // backend and diagram.
  for var i:= 0 to NameCache.Count - 1 do
    FreeAndNil(NameCache.Objects[i]);
  NameCache.Clear;
  FModelRoot.Clear;  // destroys UUnknownPackage
  FUnknownPackage := FModelRoot.AddUnit(UNKNOWNPACKAGE_NAME);
end;

procedure TObjectModel.Fire(Method: TListenerMethodType; Info: TModelEntity = nil);
var
  I: integer;
  L,Dum: IUnknown;
begin
  if (FLocked = 0) and assigned(Listeners) then
    for I := 0 to Listeners.Count - 1 do
    begin
      L := Listeners[I];
      case Method of
        //BeforeChange is triggered when the model will be changed from the root-level.
        mtBeforeChange:
           if L.QueryInterface(IBeforeObjectModelListener,Dum) = 0 then
             (L as IBeforeObjectModelListener).Change(nil);
        //AfterChange is triggered when the model has been changed from the root-level.
        mtAfterChange:
           if L.QueryInterface(IAfterObjectModelListener,Dum) = 0 then
             (L as IAfterObjectModelListener).Change(nil);
      end;
    end;
end;

procedure TObjectModel.Lock;
begin
  Fire(mtBeforeChange);
  inc(FLocked);
  ModelRoot.Locked := True;
end;

procedure TObjectModel.Unlock;
begin
  dec(FLocked);
  if FLocked = 0 then begin
    ModelRoot.Locked := False;
    Fire(mtAfterChange);
  end;
end;

function TObjectModel.debug: string;
begin
  Result:= FModelRoot.debug + FUnknownPackage.debug;
end;

procedure TObjectModel.CreatePackages;
begin
  //Creates the default packages that must exist
  FModelRoot := TLogicPackage.Create(nil);
  FUnknownPackage := FModelRoot.AddUnit(UNKNOWNPACKAGE_NAME);
end;

procedure TObjectModel.AddListener(NewListener: IUnknown);
begin
  if Listeners.IndexOf(NewListener) = -1 then
    Listeners.Add(NewListener);
end;

procedure TObjectModel.RemoveListener(Listener: IUnknown);
begin
  if assigned(Listeners) then
    Listeners.Remove(Listener);
end;

procedure TObjectModel.ClearListeners;
begin
  if assigned(Listeners) then
    Listeners.Clear;
end;

{ TLogicPackage }

constructor TLogicPackage.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FPackages := TObjectList.Create(True);
  Files:= TStringList.Create;
  Files.Duplicates:= dupIgnore;
  Files.Sorted:= true;
end;

destructor TLogicPackage.Destroy;
begin
  FreeAndNil(FPackages);
  FreeAndNil(Files);
  inherited;
end;

procedure TLogicPackage.Clear;
begin
  Files.Clear;
  FPackages.Clear;
end;

function TLogicPackage.AddUnit(const NewUnitName: string): TUnitPackage;
begin
  Result := TUnitPackage.Create(Self);
  Result.FName := NewUnitName;
  FPackages.Add(Result);
  try
    Fire(mtBeforeAddChild, Result)
  except
    FPackages.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

class function TLogicPackage.GetAfterListener: TGUID;
begin
  Result := IAfterLogicPackageListener;
end;

class function TLogicPackage.GetBeforeListener: TGUID;
begin
  Result := IBeforeLogicPackageListener;
end;

//Searches in this and dependant logic packages after a unit with name PName.
function TLogicPackage.FindUnitPackage(const PName: string; CaseSense : boolean = False): TUnitPackage;
var
  I: integer;
  P: TAbstractPackage;
  F : TStrCompare;
begin
  F := CompareFunc[CaseSense];
  Result := nil;
  for I := 0 to FPackages.Count - 1 do begin
    P := FPackages[I] as TAbstractPackage;
    if P is TLogicPackage then begin
      Result := (P as TLogicPackage).FindUnitPackage(PName);
      if Assigned(Result) then
        Exit;
    end
    else if P is TUnitPackage then begin
      if F(P.Name, PName) = 0 then begin
        Result := P as TUnitPackage;
        Exit;
      end;
    end;
  end;
end;

function TLogicPackage.GetPackages: IModelIterator;
  var ObjList: TObjectList;
begin
  // Got TObjectList expected IModellIterator
  ObjList:= TObjectList(FPackages);
  Result := TModelIterator.Create(ObjList);
end;

//Returns all unitpackages in and below this logic package.
//Unknownpackage is excluded.
function TLogicPackage.GetAllUnitPackages: IModelIterator;
var
  List : TObjectList;

  procedure InAddNested(L : TLogicPackage);
  var
    Mi : IModelIterator;
    P : TModelEntity;
  begin
    Mi := L.GetPackages;
    while Mi.HasNext do begin
      P := Mi.Next;
      if P is TLogicPackage then
        InAddNested(P as TLogicPackage)
      else //Not logicpackage, must be unitpackage.
        if (P.Name <> UNKNOWNPACKAGE_NAME) then List.Add( P );
    end;
  end;

begin
  List := TObjectList.Create(False);
  try
    try
      InAddNested(Self);
    except
    end;
    Result := TModelIterator.Create(List, true);
  finally
    FreeAndNil(List);
  end;
end;

//Returns all classifiers in and below this logic package.
function TLogicPackage.GetAllClassifiers: IModelIterator;
var
  Pmi,Cmi : IModelIterator;
  List : TObjectList;
begin
  List := TObjectList.Create(False);
  try
    Pmi := GetAllUnitPackages;
    while Pmi.HasNext do begin
      Cmi := (Pmi.Next as TUnitPackage).GetClassifiers;
      while Cmi.HasNext do
        List.Add(Cmi.Next);
    end;
    Result := TModelIterator.Create(List, true);
  finally
    FreeAndNil(List);
  end;
end;

//Returns all functions in and below this logic package.
function TLogicPackage.GetFunctions: IModelIterator;
var
  Pmi,Cmi : IModelIterator;
  List : TObjectList;
begin
  List := TObjectList.Create(False);
  try
    Pmi := GetAllUnitPackages;
    while Pmi.HasNext do begin
      Cmi := (Pmi.Next as TUnitPackage).GetFunctions;
      while Cmi.HasNext do
        List.Add(Cmi.Next);
    end;
    Result := TModelIterator.Create(List, true);
  finally
    FreeAndNil(List);
  end;
end;

function TLogicPackage.Debug: string;
  var SL: TStringList; i: integer;
      Ci, Ai, Oi, Pi: IModelIterator;
      cent: TClassifier;
      Attribute: TAttribute;
      Operation: TOperation;
begin
  i:= 0;
  SL:= TStringList.Create;
  SL.Add('LogicPackage ' + Name);
  SL.Add('Packages');
  Pi:= GetAllUnitPackages;
  while Pi.HasNext do begin
    SL.Add((Pi.Next as TUnitPackage).Name);
  end;
  SL.Add('');
  SL.Add('Classes');
  Ci:= GetAllClassifiers;
  while Ci.HasNext do begin
    cent:= TClassifier(Ci.Next);
    inc(i);
    SL.Add('#' + IntTostr(i) + ' ' + Cent.Name + ' - ' + Cent.Importname + ' - ' + Cent.Pathname);
    if (Cent is TClass) and ((Cent as TClass).AncestorsCount > 0) then
      SL.Add('Ancestor: ' + (Cent as TClass).Ancestor[0].Name);
    SL.Add('--- Attributes ---');
    Ai:= Cent.GetAllAttributes;
    while Ai.HasNext do begin
      Attribute:= ai.Next as TAttribute;
      SL.Add(Attribute.toPython(false));
    end;
    SL.Add('--- Operations ---');
    oi:= cent.GetOperations;
    while oi.HasNext do begin
      Operation:= oi.Next as TOperation;
      SL.Add(Operation.HeadToPython);
    end;
    SL.Add('-------------------------');
  end;
  SL.Add('');
  SL.Add('Files: ');
  SL.Add(Files.Text);
  SL.Add('-------------------------');

  Result:= SL.Text;
  FreeAndNil(SL);
end;

{ TUnitPackage }

constructor TUnitPackage.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FClassifiers := TObjectList.Create(True);
  FUnitDependencies := TObjectList.Create(True);
  FFunctions:= TObjectList.Create(True);
  FullImports:= TStringList.Create;
  ClassImports:= TStringList.Create;
end;

destructor TUnitPackage.Destroy;
begin
  Clear;
  FreeAndNil(ClassImports);
  FreeAndNil(FullImports);
  FreeAndNil(FFunctions);
  FreeAndNil(FUnitDependencies);
  FreeAndNil(FClassifiers);
  inherited;
end;

procedure TUnitPackage.Clear;
begin
  ClassImports.Clear;
  FullImports.Clear;
  FFunctions.Clear;
  FUnitDependencies.Clear;
  FClassifiers.Clear;
end;

function TUnitPackage.MakeClass(const NewName, Filename: string): TClass;
  var aClass: TClassifier;
begin
  aClass:= FindClassifier(NewName, TClass, true);
  if aClass = nil then begin
    aClass:= TClass.Create(Self);
    aClass.Name:= NewName;  // sets package too
  end;
  Result:= (aClass as TClass);
  Result.Pathname:= Filename;
end;

procedure TUnitPackage.AddClass(const aClass: TClass);
  var aClass1: TClassifier;
begin
  aClass1:= FindClassifier(aClass.Name, TClass, true);
  if assigned(aClass1) then begin
    Fire(mtBeforeAddChild, aClass1);
    Fire(mtAfterAddChild, aClass1);
  end else begin
    FClassifiers.Add(aClass);
    Fire(mtBeforeAddChild, aClass);
    Fire(mtAfterAddChild, aClass);
  end;
end;

procedure TUnitPackage.AddClassWithoutShowing(const aClass: TClass);
  var aClass1: TClassifier;
begin
  aClass1:= FindClassifier(aClass.Name, TClass, true);
  if assigned(aClass1) then exit;
  if assigned(FClassifiers) then FClassifiers.Add(aClass);
end;

function TUnitPackage.MakeInterface(const NewName, Filename: string): TInterface;
begin
  Result := TInterface.Create(Self);
  Result.FName := NewName;
  Result.Pathname:= Filename;
end;

procedure TUnitPackage.AddInterface(const aInterface: TInterface);
begin
  FClassifiers.Add(aInterface);
  try
    Fire(mtBeforeAddChild, aInterface);
  except
    FClassifiers.Remove(aInterface);
  end;
  Fire(mtAfterAddChild, aInterface);
end;

procedure TUnitPackage.AddInterfaceWithoutShowing(const aInterface: TInterface);
begin
  FClassifiers.Add(aInterface);
end;

function TUnitPackage.AddDatatype(const NewName: string): TDataType;
begin
  Result := TDataType.Create(Self);
  Result.FName := NewName;
  FClassifiers.Add(Result);
  try
    Fire(mtBeforeAddChild, Result);
  except
    FClassifiers.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

function TUnitPackage.AddObject(const NewName: string; aClass: TClass): TObjekt;
begin
  try
    Result:= GetObjekt(NewName, aClass.Name);
  except
    Result:= nil;
    exit;
  end;
  if Result = nil then begin
    Result:= TObjekt.Create(Self);
    Result.FName:= NewName;
    Result.IsVisible:= true;
    Result.aClass:= aClass;
    FClassifiers.Add(Result);
  end;
  try
    Fire(mtBeforeAddChild, Result);
  except
    FClassifiers.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

procedure TUnitPackage.AddFunction(const Operation: TOperation);
begin
  fFunctions.Add(Operation);
end;

function TUnitPackage.GetObjekt(const aName, Typ: string): TObjekt;
  var it: TModelIterator; aClassifier: TClassifier; aObjekt: TObjekt;
begin
  Result:= nil;
  it:= TModelIterator.Create(GetClassifiers);
  try
    while it.HasNext do begin
      aClassifier:= it.Next as TClassifier;
      if (aClassifier is TObjekt) then begin
        aObjekt:= (aClassifier as TObjekt);
        if (aClassifier.Name = aName) and (GetShortType(aObjekt.aClass.name) = Typ) then begin
          Result:= (aClassifier as TObjekt);
          break;
        end;
      end;
    end;
  finally
    FreeAndNil(it);
  end;
end;

function TUnitPackage.GetObjects(const Typ: string): TStringList;
  var it: TModelIterator; aClassifier: TClassifier;
begin
  Result:= TStringList.Create;
  it:= TModelIterator.Create(GetClassifiers);
  try
    while it.HasNext do begin
      aClassifier:= it.Next as TClassifier;
      if (aClassifier is TObjekt) and (GetShortType((aClassifier as TObjekt).aClass.name) = Typ) then
        Result.AddObject((aClassifier as TObjekt).FName, aClassifier);
    end;
  finally
    FreeAndNil(it);
  end;
end;

function TUnitPackage.GetAllObjects: TStringList;
  var it: TModelIterator; aClassifier: TClassifier;
begin
  Result:= TStringList.Create;
  it:= TModelIterator.Create(GetClassifiers);
  try
    try
      while it.HasNext do begin
        aClassifier:= it.Next as TClassifier;
        if aClassifier is TObjekt then
          Result.AddObject((aClassifier as TObjekt).FName, aClassifier);
      end;
    finally
      FreeAndNil(it);
    end;
  except
  end;
end;

procedure TUnitPackage.DeleteObject(aName: string);
  var aObject: TClassifier;
begin
  aObject:= FindClassifier(aName, nil, true);   // true wegen casesensitive
  if assigned(aObject) then
    FClassifiers.Remove(aObject);
end;

function TUnitPackage.GetObject(const aName: string): TObjekt;
begin
  Result:= TObjekt(FindClassifier(aName, nil, false));
end;

class function TUnitPackage.GetAfterListener: TGUID;
begin
  Result := IAfterUnitPackageListener;
end;

class function TUnitPackage.GetBeforeListener: TGUID;
begin
  Result := IBeforeUnitPackageListener;
end;

{
  Search for classifier in this unit, then looks in UnitDependencies if necessary.
  Used by the parser to find ancestorclass within current scope.
}
function TUnitPackage.FindClassifier(const CName: string;
  TheClass : TModelEntityClass = nil; CaseSense : boolean = False): TClassifier;
var
  C : TClassifier;
  Mi : IModelIterator;
  P : TUnitPackage;
  F : TStrCompare;

  function InFind(P : TUnitPackage) : TClassifier;
    var Mi: IModelIterator;
  begin
    Result := nil;
    if assigned(TheClass) then
      Mi := TModelIterator.Create( P.GetClassifiers , TheClass )
    else if assigned(P) then
      Mi := P.GetClassifiers
    else
      exit;
    while Mi.HasNext do begin
      C := Mi.Next as TClassifier;
      if F(C.Name, CName) = 0 then begin
        Result := C;
        Break;
      end;
    end;
  end;

begin
  Result:= nil;
  try
    F := CompareFunc[CaseSense];
    Result := InFind(Self);
    // if nil search in public dependencies
    if not Assigned(Result) then begin
      Mi := GetUnitDependencies;
      while Mi.HasNext do begin
        P := (Mi.Next as TUnitDependency).myPackage;
        Result := InFind(P);
        if Assigned(Result) then
          Break;
      end;
    end;
  except on e: exception do
    ErrorMsg(' TUnitPackage.FindClassifier');
  end;
end;

function TUnitPackage.FindClass(const Pathname: string): TClassifier;
  var Mi: IModelIterator; C : TClassifier;
begin
  Result:= nil;
  Mi:= GetClassifiers;
  while Mi.HasNext do begin
    C:= Mi.Next as TClassifier;
    if C.Pathname = Pathname then begin
      Result:= C;
      Break;
    end;
  end;
end;

function TUnitPackage.GetClassifiers: IModelIterator;
begin
  try
    Result := TModelIterator.Create( FClassifiers );
  except
    Result:= nil;
  end;
end;

function TUnitPackage.GetFunctions: IModelIterator;
begin
  try
    Result := TModelIterator.Create( FFunctions );
  except
    Result:= nil;
  end;
end;

function TUnitPackage.AddUnitDependency(U: TUnitPackage; aVisibility: TVisibility): TUnitDependency;
begin
  Assert( (U<>Self) and (U<>nil), Classname + 'AddUnitDependency invalid parameter');
  Result := TUnitDependency.Create( Self );
  Result.myPackage := U;
  Result.Visibility := aVisibility;
  FUnitDependencies.Add( Result );
end;

function TUnitPackage.GetUnitDependencies: IModelIterator;
begin
  Result := TModelIterator.Create( FUnitDependencies );
end;

function TUnitPackage.Debug: string;
   var SL: TStringList;
      Ci, Ai, Oi: IModelIterator;
      cent: TClassifier;
      Attribute: TAttribute;
      Operation: TOperation;
begin
  SL:= TStringList.Create;
  SL.Add('UnitPackage: ' + Name);
  Ci:= GetClassifiers;
  while Ci.HasNext do begin
    cent:= TClassifier(Ci.Next);
    SL.Add(Cent.Name + ' - ' + Cent.Importname + ' - ' + Cent.Pathname);
    SL.Add('--- Attributes ---');
    Ai:= Cent.GetAllAttributes;
    while Ai.HasNext do begin
      Attribute:= ai.Next as TAttribute;
      SL.Add(Attribute.toPython(false));
    end;
    SL.Add('--- Operations ---');
    oi:= cent.GetOperations;
    while oi.HasNext do begin
      Operation:= oi.Next as TOperation;
      SL.Add(Operation.HeadToPython);
    end;
    SL.Add('-------------------------');
  end;
  Result:= SL.Text;
  FreeAndNil(SL);
end;

{ TClass }

constructor TClass.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FAncestor:= nil;
  FImplements:= TObjectList.Create(False); // only reference
  FAncestors:= TObjectList.Create(False);  // only reference
end;

destructor TClass.Destroy;
begin
  // Dont touch listeners if the model is locked.
  if not Locked then
  begin
    Fire(mtBeforeRemove);
    //  if Assigned(FAncestor) then
    //    FAncestor.RemoveListener(IBeforeClassListener(Self));
  end;
  FreeAndNil(FImplements);
  FreeAndNil(FAncestors);
  inherited;
end;

function TClass.AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
begin
  Result:= FindAttribute(withoutVisibility(NewName), TypeClass);
  if Result = nil then begin
    Result:= TAttribute.Create(Self);
    Result.FTypeClassifier:= TypeClass;
    Result.FName := NewName;
    FFeatures.Add(Result);
    try
      Fire(mtBeforeAddChild, Result);
    except
      FFeatures.Remove(Result);
    end;
    Fire(mtAfterAddChild, Result);
  end;
end;

function TClass.AddProperty(const NewName: string): TProperty;
begin
  Result := TProperty.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

function TClass.AddOperationWithoutType(Const NewName: string): TOperation;
begin
  Result := TOperation.Create(Self);
  Result.FName := NewName;
  Result.FReturnValue:= nil;
  FFeatures.Add(Result);
  try
    Fire(mtBeforeAddChild, Result);
  except
    FFeatures.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

function TClass.MakeOperation(const NewName: string; TypeClass: TClassifier): TOperation;
begin
  Result := TOperation.Create(Self);
  Result.FName := NewName;
  Result.FReturnValue:= TypeClass;
end;

procedure TClass.AddOperation(Operation: TOperation);
begin
  FFeatures.Add(Operation);
  try
    Fire(mtBeforeAddChild, Operation);
  except
    FFeatures.Remove(Operation);
  end;
  Fire(mtAfterAddChild, Operation);
end;

class function TClass.GetAfterListener: TGUID;
begin
  Result := IAfterClassListener;
end;

class function TClass.GetBeforeListener: TGUID;
begin
  Result := IBeforeClassListener;
end;

function TClass.AddImplements(I: TInterface): TInterface;
begin
  Result := I;
  FImplements.Add(I);
end;

function TClass.AddAncestors(C: TClass): TClass;
begin
  Result := C;
  FAncestors.Add(C);
end;

procedure TClass.ViewImplements(I: TInterface);
begin
  try
    Fire(mtBeforeAddChild, I);
  except
    FImplements.Remove(I);
  end;
  Fire(mtAfterAddChild, I);
end;

procedure TClass.SetAncestor(Index: integer; const Value: TClass);
var
  Old: TClass;
begin
  if Value = Self then exit;
  if (0 <= Index) and (Index < FAncestors.Count) and (Value <> FAncestors[Index]) then
  begin
    Old := TClass(FAncestors[Index]);
    FAncestors[Index] := Value;
    try
      Fire(mtBeforeEntityChange);
    except
      FAncestors[Index] := Old;
    end;
    Fire(mtAfterEntityChange);
  end;
end;

function TClass.getAncestor(Index: integer): TClass;
begin
  if (0 <= Index) and (Index <= FAncestors.Count) then
    Result:= TClass(FAncestors[Index])
  else
    Result:= nil;
end;

procedure TClass.AncestorAddChild(Sender, NewChild: TModelEntity);
begin
end;

procedure TClass.AncestorChange(Sender: TModelEntity);
begin
end;

procedure TClass.AncestorEntityChange(Sender: TModelEntity);
begin
  Fire(mtBeforeEntityChange);
  Fire(mtAfterEntityChange);
end;

procedure TClass.AncestorRemove(Sender: TModelEntity);
  var i: integer;
begin
  i:= FAncestors.IndexOf(Self);
  if (0 <= i) and (i < FAncestors.Count) then begin
    TClass(FAncestors[i]).RemoveListener(IBeforeClassListener(Self));
    FAncestors[i]:= nil;
  end;
end;

function TClass.AncestorQueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE
end;

function TClass.GetImplements: IModelIterator;
begin
  Result := TModelIterator.Create( FImplements );
end;

//Returns a list of classes that inherits from this class.
function TClass.GetDescendants: IModelIterator;
begin
  Result := TModelIterator.Create(
    (Root as TLogicPackage).GetAllClassifiers,
    TClassDescendantFilter.Create(Self) );
end;

{
  Finds an operation with same name and signature as parameter.
  Used by Delphi-parser to find a modelentity for a method implementation.
}
function TClass.FindOperation(O: TOperation): TOperation;
var
  Mi,Omi1,Omi2 : IModelIterator;
  O2 : TOperation;
  label Skip;
begin
  Assert(O <> nil, ClassName + '.FindOperation invalid parameter');
  Result := nil;
  Mi := GetOperations;
  while Mi.HasNext do
  begin
    O2 := Mi.Next as TOperation;
    //Compare nr of parameters
    if O.FParameters.Count<>O2.FParameters.Count then
      Continue;
    //Compare operation name
    if CompareText(O.Name,O2.Name)<>0 then
      Continue;
    //Compare parameters
    Omi1 := O.GetParameters;
    Omi2 := O2.GetParameters;
    while Omi1.HasNext do
      if CompareText((Omi1.Next as TParameter).Name,(Omi2.Next as TParameter).Name)<>0 then
        goto Skip;
    //Ok, match
    Result := O2;
    Break;
  Skip:
  end;
end;

function TClass.OperationIsProperty(Name: string): boolean;
var
  Mi: IModelIterator;
  O : TOperation;
begin
  Result := false;
  Mi := GetOperations;
  while Mi.HasNext do begin
    O := Mi.Next as TOperation;
    if O.isPropertyMethod and (CompareText(O.Name, Name) = 0) then
      exit(true);
  end;
end;


{
  Finds an attribute with same name and type.
}
function TClass.FindAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
var
  Mi: IModelIterator;
  A: TAttribute;
begin
  Result := nil;
  Mi := getAttributes;
  while Mi.HasNext do begin
    A := Mi.Next as TAttribute;
    if (CompareText(NewName, A.Name) = 0) and
       ((TypeClass = nil) or (CompareText(TypeClass.Name, A.TypeClassifier.Name) = 0)) then
      exit(A);
  end;
end;

function TClass.GetTyp: string;
begin
  if Pathname <> ''
    then Result:= Name
    else Result:= ImportName;
end;

function TClass.getAncestorName(index: integer): string;
begin
  if assigned(Ancestor[index])
    then Result:= Ancestor[index].Name
    else Result:= '';
end;

function TClass.AncestorsCount: integer;
begin
  Result:= fAncestors.Count;
end;

function TClass.AncestorsAsString: string;
  var i: integer;
begin
  if AncestorsCount = 0 then
    Result:= ''
  else begin
    Result:= TClass(Ancestor[0]).Name;
    for i:= 1 to AncestorsCount - 1 do
      Result:= Result + ', ' + TClass(Ancestor[i]).Name;
  end;
end;

{ TObjekt }

constructor TObjekt.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
end;

destructor TObjekt.Destroy;
begin
  // Dont touch listeners if the model is locked.
  if not Locked then
    Fire(mtBeforeRemove);
  inherited;
end;

class function TObjekt.GetAfterListener: TGUID;
begin
  Result:= IAfterObjektListener;
end;

class function TObjekt.GetBeforeListener: TGUID;
begin
  Result:= IBeforeObjektListener;
end;

function TObjekt.AddAttribute(const NewName: string): TAttribute;
  var i: integer; aAttribute: TAttribute;
begin
  Result:= nil;
  for i:= 0 to FFeatures.Count - 1 do begin
    aAttribute:= FFeatures.Items[i] as TAttribute;
    if aAttribute.Name = NewName then begin
      Result:= aAttribute;
      break;
    end;
  end;
  if Result = nil then begin
    Result:= TAttribute.Create(Self);
    Result.FName := NewName;
    FFeatures.Add(Result);
  end;
  try
    Fire(mtBeforeAddChild, Result);
  except
    FFeatures.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

function TObjekt.AddOperation(const NewName: string): TOperation;
begin
  Result:= TOperation.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

procedure TObjekt.RefreshEntities;
begin
  Fire(mtAfterAddChild, nil);
end;

function TObjekt.getTyp: TClass;
begin
  Result:= aClass;
end;

function TObjekt.GenericName: String;
begin
  Result:= aClass.GenericName;
  if Result = '' then Result:= aClass.Name;
end;

{ TParameter }

constructor TParameter.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FTypeClassifier:= nil;
  FUsedForAttribute:= false;
  fValue:= '';
end;

class function TParameter.GetAfterListener: TGUID;
begin
  Result := IAfterParameterListener;
end;

class function TParameter.GetBeforeListener: TGUID;
begin
  Result := IBeforeParameterListener;
end;

function TParameter.asPythonString: string;
begin
  Result:= Name;
  if assigned(TypeClassifier) then
    // pep 0484 forward references, shell be solved with python 3.11 but arn't,
    Result:= Result + ': ' + TypeClassifier.asType;
  if Value <> '' then
    Result:= Result + ' = ' + Value;
end;

function TParameter.asUMLString(ShowParameter: integer): string;
  var s: string;
begin
  s:= '';
  if ShowParameter >= 3 then begin
    s:= Name;
    if assigned(TypeClassifier) and (ShowParameter in [4, 6]) then
      s:= s + ': ' + TypeClassifier.asUMLType;
    if (Value <> '') and (ShowParameter >= 5) then
      s:= s + ' = ' + Value;
  end;
  Result:= s;
end;

function TParameter.toShortStringNode: string;
begin
  if assigned(TypeClassifier)
    then result:= Name + ': ' + TypeClassifier.asUMLType
    else result:= Name;
end;

{ TOperation }

constructor TOperation.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FParameters := TObjectList.Create(True);
  FAttributes := TObjectList.Create(True);
  FReturnValue:= nil;
end;

destructor TOperation.Destroy;
begin
  FreeAndNil(FParameters);
  FreeAndNil(FAttributes);
  // FreeAndNil(FReturnValue); FReturnValue belongs to FUnit.
  inherited;
end;

procedure TOperation.NewParameters;
begin
  FreeAndNil(FParameters);
  FParameters := TObjectList.Create(True);
end;

function TOperation.AddParameter(const NewName: string): TParameter;
begin
  Result:= TParameter.Create(Self);
  Result.FName := NewName;
  FParameters.Add(Result);
  try
    Fire(mtBeforeAddChild, Result);
  except
    FParameters.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

procedure TOperation.DelParameter(const NewName: string);
begin
  for var i:= 0 to FParameters.Count - 1 do
    if TParameter(FParameters.Items[i]).FName = NewName then begin
      FParameters.Delete(i);
      break;
    end;
end;

class function TOperation.GetAfterListener: TGUID;
begin
  Result := IAfterOperationListener;
end;

class function TOperation.GetBeforeListener: TGUID;
begin
  Result := IBeforeOperationListener;
end;

procedure TOperation.SetOperationType(const Value: TOperationType);
var
  Old: TOperationType;
begin
  Old := FOperationType;
  if Old <> Value then
  begin
    FOperationType := Value;
    try
      Fire(mtBeforeEntityChange);
    except
      FOperationType := Old;
    end;
    Fire(mtAfterEntityChange);
  end;
end;

procedure TOperation.SetReturnValue(const Value: TClassifier);
var
  Old: TClassifier;
begin
  Old := FReturnValue;
  if Old <> Value then
  begin
    FReturnValue := Value;
    try
      Fire(mtBeforeEntityChange);
    except
      FReturnValue := Old;
    end;
    Fire(mtAfterEntityChange);
  end;
end;

function TOperation.GetParameters: IModelIterator;
begin
  Result := TModelIterator.Create( FParameters );
end;

function TOperation.AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
begin
  Result:= nil;
  try
    Result := TAttribute.Create(Self);
    Result.FTypeClassifier:= TypeClass;
    Result.FName := NewName;
    FAttributes.Add(Result);
    Fire(mtBeforeAddChild, Result);
    Fire(mtAfterAddChild, Result);
  except on e: exception do begin
    // FAttributes.Remove(Result);
    ErrorMsg('TOperation.AddAttribute');
    end;
  end;
end;

function TOperation.GetAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( FAttributes);
end;

function TOperation.HeadToPython: string;
  var s, indent: string; It2: IModelIterator; Parameter: TParameter;
begin
  indent:= StringTimesN(FConfiguration.Indent1, Level + 1);
  if isClassMethod then s:= '(cls, '
  else if isStaticMethod then s:= '('
  else s:= '(self, ';

  it2:= GetParameters;
  while it2.HasNext do begin
    Parameter:= it2.next as TParameter;
    if (Parameter.Name <> 'cls') and (Parameter.Name <> 'self') then
      s:= s + Parameter.asPythonString + ', ';
  end;
  if Copy(s, length(s) - 1, 2) = ', ' then
    Delete(s, length(s) - 1, 2);
  s:= s + ')';
  case OperationType of
    otConstructor: s:= '__init__' + s;
    otProcedure:   s:= VisName + s;
    otFunction:    if assigned(ReturnValue)
                     then s:= VisName + s + ' -> ' + ReturnValue.asType
                     else s:= VisName + s;
  end;
  s:= Indent + 'def ' + s + ':';
  if isStaticMethod then
    s:= Indent + '@staticmethod' + CrLf + s;
  if isClassMethod then
    s:= Indent + '@classmethod' + CrLf + s;
  if isAbstract then
    s:= Indent + '@abstractmethod' + CrLf + s;
  if isPropertyMethod then
    s:= Indent + '@property' + CrLf + s;
  Result:= s;
end;

function TOperation.toShortStringWithoutParameterNames: string;
  var s: string; It2: IModelIterator; Parameter: TParameter;
begin
  s:= '(';
  it2:= GetParameters;
  while it2.HasNext do begin
    Parameter:= it2.next as TParameter;
    if assigned(Parameter.TypeClassifier)
      then s:= s + Parameter.TypeClassifier.asType + ', '
      else s:= s + ', ';
  end;
  if Copy(s, length(s) - 1, 2) = ', ' then
    Delete(s, length(s) - 1, 2);
  s:= s + '):';
  case OperationType of
    otConstructor: Result:= '__init__' + s;
    otProcedure:   Result:= Name + s;
    otFunction:    if assigned(ReturnValue)
                     then Result:= Name + s + ' ->' + ReturnValue.asType
                     else Result:= Name + s;
  end;
end;

function TOperation.toShortStringNode: string;
  var s: string; It2: IModelIterator; Parameter: TParameter;
begin
  s:= '(';
  it2:= GetParameters;
  while it2.HasNext do begin
    Parameter:= it2.next as TParameter;
    if (Parameter.Name <> 'self') and (Parameter.Name <> 'cls') then
      s:= s + Parameter.asUMLString(4) + ', ';
  end;
  if Copy(s, length(s)-1, 2) = ', ' then
    Delete(s, length(s)-1, 2); // delete last comma
  s:= s + ')';
  case OperationType of
    otConstructor: Result:= Name + s;
    otProcedure:   Result:= Name + s;
    otFunction:    if assigned(ReturnValue)
                     then Result:= Name + s + ': ' + ReturnValue.asUMLType
                     else Result:= Name + s;
  end;
end;

function TOperation.VisName: string;
  var s: string;
begin
  s:= Name;
  while (length(s) > 0) and (s[1] = '_') do
    delete(s, 1, 1);
  case Visibility of
    viPrivate: s:= '__' + s;
    viProtected: s:= '_' + s;
  end;
  Result:= s;
end;

procedure TOperation.setAttributeScope(aScopeDepth, aLineE: integer);
  var It: IModelIterator;
      Attribute: TAttribute;
begin
  it:= GetAttributes;
  while it.HasNext do begin
    Attribute:= it.next as TAttribute;
    if (Attribute.LineE = 0) and (Attribute.ScopeDepth = ScopeDepth) then
      Attribute.LineE:= LineE;
  end;
end;

function TOperation.getFormattedDescription: string;
  var s: string;
begin
  s:= Documentation.Description;
  // if s = '' then s:= 'No JavaDoc available';
  Result:= myStringReplace(s, #13#10, '<br>');
end;

{ TAttribute }

constructor TAttribute.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FTypeClassifier:= nil;
  FConnected:= false;
  FValue:= '';
end;

class function TAttribute.GetAfterListener: TGUID;
begin
  Result := IAfterAttributeListener;
end;

class function TAttribute.GetBeforeListener: TGUID;
begin
  Result := IBeforeAttributeListener;
end;

procedure TAttribute.SetTypeClassifier(const Value: TClassifier);
var
  Old: TClassifier;
begin
  Old := FTypeClassifier;
  if Old <> Value then
  begin
    FTypeClassifier := Value;
    try
      Fire(mtBeforeEntityChange);
    except
      FTypeClassifier := Old;
    end;
    Fire(mtAfterEntityChange);
  end;
end;

procedure TAttribute.SetValue(const Value: string);
var
  OldValue: string;
begin
  OldValue := FValue;
  FValue := Value;
  try
    Fire(mtBeforeEntityChange)
  except
    FName := OldValue;
  end;
  Fire(mtAfterEntityChange)
end;

procedure TAttribute.SetConnected(Value: boolean);
var
  OldValue: boolean;
begin
  OldValue := FConnected;
  FConnected := Value;
  try
    Fire(mtBeforeEntityChange)
  except
    FConnected := OldValue;
  end;
  Fire(mtAfterEntityChange)
end;

function TAttribute.VisName: string;
  var s: string;
begin
  s:= Name;
  while (length(s) > 0) and (s[1] = '_') do
    delete(s, 1, 1);
  case Visibility of
    viPrivate: s:= '__' + s;
    viProtected: s:= '_' + s;
  end;
  Result:= s;
end;

function TAttribute.toPython(TypeChanged: boolean): string;
  const Values = '|0|0.0|''''|True|False|None|[]|()|{}|';
  var s: string; count: integer;
begin
  s:= VisName;
  if not Static then
    s:= 'self.' + s;
  if IsFinal then begin
    s:= s + ': Final';
    if assigned(TypeClassifier) then
      s:= s + '[' + TypeClassifier.asType + ']';
  end else if assigned(TypeClassifier) then begin
    s:= s + ': ' + TypeClassifier.asType;
    if TypeChanged and (Pos('|' + Value + '|', Values) > 0) then
      Value:= TypeClassifier.asValue;  // Value of attribute is changed
  end;
  s:= s + ' = ';
  if Value <> '' then
    s:= s + Value
  else if assigned(TypeClassifier) then
    s:= s + TypeClassifier.asValue
  else
    s:= s + 'None';
  if Static
    then count:= Level + 1
    else count:= Level + 2;
  Result:= StringTimesN(FConfiguration.Indent1, count) + s;
end;

function TAttribute.toNameType: string;
begin
  if assigned(TypeClassifier)
    then Result:= Name + ': ' + TypeClassifier.asType
    else Result:= Name;
end;

function TAttribute.toNameTypeUML: string;
begin
  if assigned(TypeClassifier)
    then Result:= Name + ': ' + TypeClassifier.asUMLType
    else Result:= Name;
end;

{ TProperty }

class function TProperty.GetAfterListener: TGUID;
begin
  Result := IAfterPropertyListener;
end;

class function TProperty.GetBeforeListener: TGUID;
begin
  Result := IBeforePropertyListener;
end;

{ TClassifier }

constructor TClassifier.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FFeatures := TObjectList.Create(True);
  GenericName:= '';
  Inner:= false;
  SourceRead:= false;
  //Recursive:= false;
end;

destructor TClassifier.Destroy;
begin
  if Name <> '' then
    FreeAndNil(FFeatures);
  inherited;
end;

function TClassifier.GetFeatures: IModelIterator;
begin
  Result := TModelIterator.Create( FFeatures );
end;

function TClassifier.GetShortType: String;
begin
  try
    Result:= ShortName;
  except
  end;
end;

function TClassifier.GetAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TAttribute);
end;

function TClassifier.GetAllAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TAttribute, Low(TVisibility), ioNone, true);
end;

function TClassifier.GetOperations: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TOperation);
end;

function TClassifier.getName: string;
begin
  Result:= Name;
end;

function TClassifier.getAncestorName(index: integer): string;
begin
  Result:= '';
end;

function TClassifier.asValue: string;
begin
  if (Name = 'int') or (Name = 'integer') then
    Result:= '0'
  else if Name = 'float' then
    Result:= '0.0'
  else if (Name = 'bool') or (Name = 'boolean') then
    Result:= 'False'
  else if (Name = 'str') or (Name = 'String')  or (Name = 'string') then
    Result:= ''''''
  else if Name = 'list' then
    Result:= '[]'
  else if Name = 'tuple' then
    Result:= '()'
  else if (Name = 'dict') or (Name = 'set') then
    Result:= '{}'
  else
    Result:= 'None';
end;

function TClassifier.ValueToType(Value: string): string;
begin
  if Value = '0' then
    Result:= 'int'
  else if Value = '0.0' then
    Result:= 'float'
  else if (Value = 'True') or (Value = 'False') then
    Result:= 'bool'
  else if Value = '''''' then
    Result:= 'str'
  else if Value = '[]' then
    Result:= 'list'
  else if Value = '()' then
    Result:= 'tuple'
  else if Value = '{}' then
    Result:= 'dict'
  else if Value = 'set()' then
    Result:= 'set'
  else if Value = 'None' then
    Result:= ''
  else
    Result:= asType;
end;

function TClassifier.asType: string;
begin
  Result:= Name;
  if Result = 'boolean' then
    Result:= 'bool'
  else if (Result = 'String') or (Result = 'string') then
    Result:= 'str'
  else if Result = 'integer' then
    Result:= 'int';
//  if Recursive then
//    Result:= asString(Result);
end;

function TClassifier.asUMLType: string;
begin
  Result:= Name;
  if Result = 'bool' then
    Result:= 'boolean'
  else if Result = 'str' then
    Result:= 'String'
  else if Result = 'int' then
    Result:= 'integer';
end;

procedure TClassifier.setCapacity(capacity: integer);
begin
  FFeatures.Capacity:= capacity;
end;

{ TInterface }

constructor TInterface.Create(aOwner: TModelEntity);
begin
  inherited Create(aOwner);
  FExtends := TObjectList.Create(False); //Only reference
  FAncestor:= nil;
end;

destructor TInterface.Destroy;
begin
  inherited;
  FreeAndNil(FExtends);
end;

function TInterface.AddOperation(const NewName: string; TypeClass: TClassifier): TOperation;
begin
  Result := TOperation.Create(Self);
  Result.FName := NewName;
  Result.FReturnValue:= TypeClass;
  FFeatures.Add(Result);
  try
    Fire(mtBeforeAddChild, Result);
  except
    FFeatures.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

class function TInterface.GetAfterListener: TGUID;
begin
  Result := IAfterInterfaceListener;
end;

class function TInterface.GetBeforeListener: TGUID;
begin
  Result := IBeforeInterfaceListener;
end;

function TInterface.AddExtends(I: TInterface): TInterface;
begin
  Result := I;
  FExtends.Add(I);
end;

procedure TInterface.ViewExtends(I: TInterface);
begin
  try
    Fire(mtBeforeAddChild, I);
  except
    FExtends.Remove(I);
  end;
  Fire(mtAfterAddChild, I);
end;

function TInterface.GetExtends: IModelIterator;
begin
  Result := TModelIterator.Create( FExtends );
end;

procedure TInterface.SetAncestor(const Value: TInterface);
begin
  if Value = Self
    then FAncestor:= nil
    else FAncestor := Value;
end;

//Returns a list of classes that implements this interface.
function TInterface.GetImplementingClasses: IModelIterator;
begin
  Result := TModelIterator.Create(
    (Root as TLogicPackage).GetAllClassifiers,
    TInterfaceImplementsFilter.Create(Self) );
end;

function TInterface.AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
begin
  Result := TAttribute.Create(Self);
  Result.FName := NewName;
  Result.FTypeClassifier:= TypeClass;
  FFeatures.Add(Result);
  try
    Fire(mtBeforeAddChild, Result);
  except
    FFeatures.Remove(Result);
  end;
  Fire(mtAfterAddChild, Result);
end;

function TInterface.getAncestorName(index: integer): string;
begin
  if assigned(Ancestor)
    then Result:= Ancestor.Name
    else Result:= '';
end;

{ TDataType }

class function TDataType.GetAfterListener: TGUID;
begin
  Result := IBeforeInterfaceListener;
end;

class function TDataType.GetBeforeListener: TGUID;
begin
  Result := IAfterInterfaceListener;
end;

{ TAbstractPackage }

function TAbstractPackage.GetConfigFile: string;
begin
  Result := ConfigFile;
  if (Result='') and Assigned(FOwner) then
    Result := (Owner as TAbstractPackage).GetConfigFile;
end;

procedure TAbstractPackage.SetConfigFile(const Value: string);
begin
  if Value<>'' then
    ConfigFile := ChangeFileExt(Value,ConfigFileExt);
end;


{ TClassDescendantFilter }

constructor TClassDescendantFilter.Create(aAncestor: TClass);
begin
  inherited Create;
  Self.Ancestor := aAncestor;
end;

//Returns true if M inherits from ancestor
function TClassDescendantFilter.Accept(M: TModelEntity): boolean;
  var i: integer;
begin
  i:= (M as TClass).fAncestors.IndexOf(Ancestor);
  Result := (M is TClass) and (i <> -1);
end;

{ TInterfaceImplementsFilter }

constructor TInterfaceImplementsFilter.Create(I: TInterface);
begin
  inherited Create;
  Int := I;
end;

//Returns true if M implements interface Int
function TInterfaceImplementsFilter.Accept(M: TModelEntity): boolean;
begin
  Result := (M is TClass) and ((M as TClass).FImplements.IndexOf(Int)<>-1);
end;

var
  _AllClassesPackage : TAbstractPackage = nil;

//Unique Flag-instance, if Integrator.CurrentEntity=AllClassesPackage then show all classes
function AllClassesPackage : TAbstractPackage;
begin
  if _AllClassesPackage = nil then
    _AllClassesPackage := TAbstractPackage.Create(nil);
  Result := _AllClassesPackage;
end;

procedure AllClassesPackageClose;
begin
  FreeAndNil(_AllClassesPackage);
end;

end.
