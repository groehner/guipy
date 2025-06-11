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

uses
  Contnrs,
  Classes,
  UListeners,
  UModelEntity,
  UUtils;

const
  ConfigFileExt = '.puml';

type
  TLogicPackage = class;
  TUnitPackage = class;

  TOperationType = (otConstructor, otFunction, otProcedure, otDestructor);

  TObjectModel = class
  private
    FListeners: TInterfaceList;
    FModelRoot: TLogicPackage;
    FUnknownPackage: TUnitPackage;
    FLocked: Integer;
    FNameCache: TStringList;
    procedure CreatePackages;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Fire(Method: TListenerMethodType; Info: TModelEntity = nil);
    procedure AddListener(NewListener: IUnknown);
    procedure RemoveListener(Listener: IUnknown);
    procedure ClearListeners;
    procedure Clear;
    procedure Lock;
    procedure Unlock;
    function Debug: string;
    property ModelRoot: TLogicPackage read FModelRoot;
    property Locked: Integer read FLocked write FLocked;
    property NameCache: TStringList read FNameCache;
    property UnknownPackage: TUnitPackage read FUnknownPackage;
  end;

  TFeature = class(TModelEntity);

  TClassifier = class(TModelEntity)
  private
    FAnonym: Boolean;
    FFeatures: TObjectList;
    FGeneric: string;
    FGenericName: string;
    FImportname: string;
    FInner: Boolean;
    FPathname: string;
    FSourceRead: Boolean;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function GetFeatures : IModelIterator;
    function GetShortType: string;
    function GetAttributes : IModelIterator;
    function GetAllAttributes: IModelIterator;
    function GetOperations : IModelIterator;
    function GetName: string;
    function GetAncestorName(Index: Integer): string; virtual;
    function AsValue: string;
    function AsType: string;
    function AsUMLType: string;
    function ValueToType(Value: string): string;
    procedure SetCapacity(Capacity: Integer);

    property Anonym: Boolean read FAnonym write FAnonym;
    property Generic: string read FGeneric write FGeneric;
    property GenericName: string read FGenericName write FGenericName;
    property Importname: string read FImportname write FImportname;
    property Inner: Boolean read FInner write FInner;
    property Pathname: string read FPathname write FPathname;
    property SourceRead: Boolean read FSourceRead write FSourceRead;
  end;

  TParameter = class(TModelEntity)
  private
    FTypeClassifier : TClassifier;
    FUsedForAttribute: Boolean;
    FValue: string;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(Owner: TModelEntity); override;
    function AsPythonString: string;
    function AsUMLString(ShowParameter: Integer): string;
    function ToShortStringNode: string;
    property TypeClassifier : TClassifier read FTypeClassifier write FTypeClassifier;
    property UsedForAttribute : Boolean read FUsedForAttribute write FUsedForAttribute;
    property Value: string read FValue write FValue;
  end;

  TAttribute = class(TFeature)
  private
    FTypeClassifier: TClassifier;  // reference
    FValue: string;
    FConnected: Boolean;
    procedure SetTypeClassifier(const Value: TClassifier);
    procedure SetValue(const Value: string);
    procedure SetConnected(Value: Boolean);
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(Owner: TModelEntity); override;
    function ToPython(TypeChanged: Boolean): string;
    function ToNameType: string;
    function ToNameTypeUML: string;
    function VisName: string;

    property TypeClassifier: TClassifier read FTypeClassifier write SetTypeClassifier;
    property Value: string read FValue write SetValue;
    property Connected: Boolean read FConnected write SetConnected;
  end;

  TOperation = class(TFeature)
  private
    FAnnotation: string;
    FOperationType: TOperationType;
    FParameters: TObjectList;
    FReturnValue: TClassifier;
    FAttributes: TObjectList; // local variables
    FHasComment: Boolean;
    FHasSourceCode: Boolean;
    FIsClassMethod: Boolean;
    FIsPropertyMethod: Boolean;
    FIsStaticMethod: Boolean;
    FParentname: string;
    procedure SetOperationType(const Value: TOperationType);
    procedure SetReturnValue(const Value: TClassifier);
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    procedure NewParameters;
    function AddParameter(const NewName: string): TParameter;
    procedure DelParameter(const NewName: string);
    function GetParameters : IModelIterator;
    function AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute; // local variables
    function GetAttributes : IModelIterator;
    function ToShortStringWithoutParameterNames: string;
    function ToShortStringNode: string;
    function VisName: string;
    function HeadToPython: string;
    procedure SetAttributeScope(ScopeDepth, LineE: Integer);
    function GetFormattedDescription: string;

    property Annotation: string read FAnnotation write FAnnotation;
    property HasComment: Boolean read FHasComment write FHasComment;
    property HasSourceCode: Boolean read FHasSourceCode write FHasSourceCode;
    property IsClassMethod: Boolean read FIsClassMethod write FIsClassMethod;
    property IsPropertyMethod: Boolean read FIsPropertyMethod write
        FIsPropertyMethod;
    property IsStaticMethod: Boolean read FIsStaticMethod write FIsStaticMethod;
    property OperationType: TOperationType read FOperationType write SetOperationType;
    property Parentname: string read FParentname write FParentname;
    property ReturnValue: TClassifier read FReturnValue write SetReturnValue;
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
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function AddOperation(const NewName: string; TypeClass: TClassifier): TOperation;
    function AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
    function AddExtends(I: TInterface): TInterface;
    procedure ViewExtends(I: TInterface);
    function GetExtends : IModelIterator;
    function GetImplementingClasses : IModelIterator;
    function GetAncestorName(Index: Integer): string; override;

    property Ancestor: TInterface read FAncestor write SetAncestor;
  end;

  TClass = class(TClassifier, IBeforeClassListener)
  private
    FAncestor: TClass;
    FAncestors: TObjectList;
    FImplements: TObjectList;
    FIsJUnitTestClass: Boolean;
    procedure SetAncestor(Index: Integer; const Value: TClass);
    function GetAncestor(Index: Integer): TClass;
    //Ancestorlisteners
    procedure AncestorChange(Sender: TModelEntity);
    procedure AncestorAddChild(Sender: TModelEntity; NewChild: TModelEntity);
    procedure AncestorRemove(Sender: TModelEntity);
    procedure AncestorEntityChange(Sender: TModelEntity);
    function AncestorQueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): HRESULT; stdcall;
    procedure IBeforeClassListener.Change = AncestorChange;
    procedure IBeforeClassListener.EntityChange = AncestorEntityChange;
    procedure IBeforeClassListener.AddChild = AncestorAddChild;
    procedure IBeforeClassListener.Remove = AncestorRemove;
    function IBeforeClassListener.QueryInterface = AncestorQueryInterface;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function MakeOperation(const NewName: string; TypeClass: TClassifier): TOperation;
    procedure AddOperation(Operation: TOperation);
    function AddOperationWithoutType(const NewName: string): TOperation;
    function AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
    function AddProperty(const NewName: string): TProperty;
    function AddImplements(I: TInterface): TInterface;
    function AddAncestors(AClass: TClass): TClass;
    procedure ViewImplements(I: TInterface);
    function GetImplements : IModelIterator;
    function GetDescendants : IModelIterator;
    function FindOperation(Operation : TOperation) : TOperation;
    function OperationIsProperty(Name: string): Boolean;
    function FindAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
    function GetTyp: string;
    function GetAncestorName(Index: Integer): string; override;
    function AncestorsCount: Integer;
    function AncestorsAsString: string;

    property Ancestor[Index: Integer]: TClass read GetAncestor write SetAncestor;
    property IsJUnitTestClass: Boolean read FIsJUnitTestClass write FIsJUnitTestClass;
  end;

  TJUnitClass = class(TClass, IBeforeClassListener) // ToDo test
  end;

  TObjekt = class(TClassifier)
  private
    FClass: TClass;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    destructor Destroy; override;
    function AddAttribute(const NewName: string): TAttribute;
    function AddOperation(const NewName: string): TOperation;
    procedure RefreshEntities;
    function GetTyp: TClass;
    function GenericName: string;
  end;

  TAbstractPackage = class(TModelEntity)
  private
    FConfigFile : string;
  public
    procedure SetConfigFile(const Value : string);
    function GetConfigFile : string;
  end;

  //Represents the link between one package that uses another
  TUnitDependency = class(TModelEntity)
  private
    FMyPackage: TUnitPackage;
  public
    property MyPackage: TUnitPackage read FMyPackage write FMyPackage;
  end;

  TUnitPackage = class(TAbstractPackage)
  private
    FClassifiers: TObjectList;
    FClassImports: TStringList;
    FFullImports: TStringList;
    FUnitDependencies: TObjectList;
    FFunctions: TObjectList;
    FImportEndline: Integer;
    FImportStartline: Integer;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    procedure Clear;
    function MakeClass(const NewName, Filename: string): TClass;
    procedure AddClass(const AClass: TClass);
    procedure AddClassWithoutShowing(const AClass: TClass);
    function MakeInterface(const NewName, Filename: string): TInterface;
    procedure AddInterface(const AInterface: TInterface);
    procedure AddInterfaceWithoutShowing(const AInterface: TInterface);
    function AddDatatype(const NewName: string): TDataType;
    function AddObject(const NewName: string; AClass: TClass): TObjekt;
    procedure AddFunction(const Operation: TOperation);
    procedure DeleteObject(AName: string);
    function GetObject(const AName: string): TObjekt;
    function AddUnitDependency(UnitPackage: TUnitPackage; AVisibility : TVisibility): TUnitDependency;
    function FindClassifier(const CName: string; TheClass : TModelEntityClass = nil;
              CaseSense : Boolean = False): TClassifier;
    function FindClass(const FPathname: string): TClassifier;
    function GetClassifiers : IModelIterator;
    function GetUnitDependencies : IModelIterator;
    function GetObjects(const Typ: string): TStringList;
    function GetFunctions: IModelIterator;
    function GetAllObjects: TStringList;
    function GetObjekt(const AName, Typ: string): TObjekt;
    function Debug: string;
    property ClassImports: TStringList read FClassImports write FClassImports;
    property FullImports: TStringList read FFullImports write FFullImports;
    property ImportEndline: Integer read FImportEndline write FImportEndline;
    property ImportStartline: Integer read FImportStartline write FImportStartline;
  end;

  TLogicPackage = class(TAbstractPackage)
  private
    FFiles: TStringList;
    FPackages: TObjectList;
  protected
    class function GetBeforeListener: TGUID; override;
    class function GetAfterListener: TGUID; override;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    procedure Clear;
    function AddUnit(const NewUnitName: string): TUnitPackage;
    // might need a AddLogicPackage also
    function FindUnitPackage(const PName: string; CaseSense : Boolean = False): TUnitPackage;
    function GetPackages : IModelIterator;
    function GetAllUnitPackages : IModelIterator;
    function GetAllClassifiers : IModelIterator;
    function GetFunctions: IModelIterator;
    function Debug: string;
    property Files: TStringList read FFiles write FFiles;
  end;

function AllClassesPackage : TAbstractPackage;
procedure AllClassesPackageClose;

implementation

uses
  Winapi.Windows,
  SysUtils,
  Types,
  UIterators,
  UConfiguration;

const
  UNKNOWNPACKAGE_NAME = '<<Unknown>>';

type
  //Used by Class.GetDescendant
  TClassDescendantFilter = class(TIteratorFilter)
  private
    FAncestor : TClass;
  public
    constructor Create(Ancestor : TClass);
    function Accept(Model : TModelEntity) : Boolean; override;
  end;

  //Used by Interface.GetImplementingClasses
  TInterfaceImplementsFilter = class(TIteratorFilter)
  private
    FInt : TInterface;
  public
    constructor Create(Inter : TInterface);
    function Accept(Model : TModelEntity) : Boolean; override;
  end;

  TStrCompare = function(const Str1, Str2: string): Integer;

const
  CompareFunc : array[Boolean] of TStrCompare = (CompareText, CompareStr);

{ TObjectModel }

constructor TObjectModel.Create;
begin
  FListeners := TInterfaceList.Create;
  FNameCache:= TStringList.Create;
  CreatePackages;
end;

destructor TObjectModel.Destroy;
begin
  FreeAndNil(FModelRoot);
  // FUnknownPackage will be freed by FModelRoot who owns it
  FreeAndNil(FListeners);
  for var I:= 0 to FNameCache.Count - 1 do
    FreeAndNil(FNameCache.Objects[I]);
  FreeAndNil(FNameCache);
  inherited;
end;

procedure TObjectModel.Clear;
begin
  // model must be locked, otherwise events will be fired back to
  // backend and diagram.
  for var I:= 0 to FNameCache.Count - 1 do
    FreeAndNil(FNameCache.Objects[I]);
  FNameCache.Clear;
  FModelRoot.Clear;  // destroys UUnknownPackage
  FUnknownPackage := FModelRoot.AddUnit(UNKNOWNPACKAGE_NAME);
end;

procedure TObjectModel.Fire(Method: TListenerMethodType; Info: TModelEntity = nil);
var
  Listener, Dum: IUnknown;
begin
  if (FLocked = 0) and Assigned(FListeners) then
    for var I := 0 to FListeners.Count - 1 do
    begin
      Listener := FListeners[I];
      case Method of
        //BeforeChange is triggered when the model will be changed from the root-level.
        mtBeforeChange:
           if Listener.QueryInterface(IBeforeObjectModelListener, Dum) = 0 then
             (Listener as IBeforeObjectModelListener).Change(nil);
        //AfterChange is triggered when the model has been changed from the root-level.
        mtAfterChange:
           if Listener.QueryInterface(IAfterObjectModelListener, Dum) = 0 then
             (Listener as IAfterObjectModelListener).Change(nil);
      end;
    end;
end;

procedure TObjectModel.Lock;
begin
  Fire(mtBeforeChange);
  Inc(FLocked);
  ModelRoot.Locked := True;
end;

procedure TObjectModel.Unlock;
begin
  Dec(FLocked);
  if FLocked = 0 then begin
    ModelRoot.Locked := False;
    Fire(mtAfterChange);
  end;
end;

function TObjectModel.Debug: string;
begin
  Result:= FModelRoot.Debug + FUnknownPackage.Debug;
end;

procedure TObjectModel.CreatePackages;
begin
  //Creates the default packages that must exist
  FModelRoot := TLogicPackage.Create(nil);
  FUnknownPackage := FModelRoot.AddUnit(UNKNOWNPACKAGE_NAME);
end;

procedure TObjectModel.AddListener(NewListener: IUnknown);
begin
  if FListeners.IndexOf(NewListener) = -1 then
    FListeners.Add(NewListener);
end;

procedure TObjectModel.RemoveListener(Listener: IUnknown);
begin
  if Assigned(FListeners) then
    FListeners.Remove(Listener);
end;

procedure TObjectModel.ClearListeners;
begin
  if Assigned(FListeners) then
    FListeners.Clear;
end;

{ TLogicPackage }

constructor TLogicPackage.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FPackages := TObjectList.Create(True);
  FFiles:= TStringList.Create;
  FFiles.Duplicates:= dupIgnore;
  FFiles.Sorted:= True;
end;

destructor TLogicPackage.Destroy;
begin
  FreeAndNil(FPackages);
  FreeAndNil(FFiles);
  inherited;
end;

procedure TLogicPackage.Clear;
begin
  FFiles.Clear;
  FPackages.Clear;
end;

function TLogicPackage.AddUnit(const NewUnitName: string): TUnitPackage;
begin
  Result := TUnitPackage.Create(Self);
  Result.FName := NewUnitName;
  FPackages.Add(Result);
  try
    Fire(mtBeforeAddChild, Result);
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
function TLogicPackage.FindUnitPackage(const PName: string; CaseSense : Boolean = False): TUnitPackage;
var
  Package: TAbstractPackage;
  Compare : TStrCompare;
begin
  Compare := CompareFunc[CaseSense];
  Result := nil;
  for var I := 0 to FPackages.Count - 1 do begin
    Package := FPackages[I] as TAbstractPackage;
    if Package is TLogicPackage then begin
      Result := (Package as TLogicPackage).FindUnitPackage(PName);
      if Assigned(Result) then
        Exit;
    end
    else if Package is TUnitPackage then begin
      if Compare(Package.Name, PName) = 0 then begin
        Result := Package as TUnitPackage;
        Exit;
      end;
    end;
  end;
end;

function TLogicPackage.GetPackages: IModelIterator;
  var ObjList: TObjectList;
begin
  // Got TObjectList expected IModellIterator
  ObjList:= FPackages;
  Result := TModelIterator.Create(ObjList);
end;

//Returns all unitpackages in and below this logic package.
//Unknownpackage is excluded.
function TLogicPackage.GetAllUnitPackages: IModelIterator;
var
  List : TObjectList;

  procedure InAddNested(Logic : TLogicPackage);
  var
    MIte : IModelIterator;
    Package : TModelEntity;
  begin
    MIte := Logic.GetPackages;
    while MIte.HasNext do begin
      Package := MIte.Next;
      if Package is TLogicPackage then
        InAddNested(Package as TLogicPackage)
      else //Not logicpackage, must be unitpackage.
        if (Package.Name <> UNKNOWNPACKAGE_NAME) then List.Add( Package );
    end;
  end;

begin
  List := TObjectList.Create(False);
  try
    try
      InAddNested(Self);
    except
      on E: Exception do
        OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
    end;
    Result := TModelIterator.Create(List, True);
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
    Result := TModelIterator.Create(List, True);
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
    Result := TModelIterator.Create(List, True);
  finally
    FreeAndNil(List);
  end;
end;

function TLogicPackage.Debug: string;
var
  StringList: TStringList;
  Int: Integer;
  CIte, AIte, OIte, PIte: IModelIterator;
  Cent: TClassifier;
  Attribute: TAttribute;
  Operation: TOperation;
begin
  // use it in TFJava.OpenUMLWindow/TFJava.DoOpenInUMLWindow
  Int := 0;
  StringList := TStringList.Create;
  StringList.Add('LogicPackage ' + Name);
  StringList.Add('Packages');
  PIte := GetAllUnitPackages;
  while PIte.HasNext do
  begin
    StringList.Add((PIte.Next as TUnitPackage).Name);
  end;
  StringList.Add('');
  StringList.Add('Classes');
  CIte := GetAllClassifiers;
  while CIte.HasNext do
  begin
    Cent := TClassifier(CIte.Next);
    Inc(Int);
    StringList.Add('#' + IntToStr(Int) + ' ' + Cent.Name + ' - ' + Cent.Importname +
      ' - ' + Cent.FPathname);
    if (Cent is TClass) and Assigned((Cent as TClass).Ancestor[0]) then
      StringList.Add('Ancestor: ' + (Cent as TClass).Ancestor[0].Name);
    StringList.Add('--- Attributes ---');
    AIte := Cent.GetAllAttributes;
    while AIte.HasNext do
    begin
      Attribute := AIte.Next as TAttribute;
      StringList.Add(Attribute.ToPython(False));
    end;
    StringList.Add('--- Operations ---');
    OIte := Cent.GetOperations;
    while OIte.HasNext do
    begin
      Operation := OIte.Next as TOperation;
      StringList.Add(Operation.HeadToPython);
    end;
    StringList.Add('-------------------------');
  end;
  StringList.Add('');
  StringList.Add('Files: ');
  StringList.Add(FFiles.Text);
  StringList.Add('-------------------------');

  Result := StringList.Text;
  FreeAndNil(StringList);
end;

{ TUnitPackage }

constructor TUnitPackage.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
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
  var AClass: TClassifier;
begin
  AClass:= FindClassifier(NewName, TClass, True);
  if not Assigned(AClass) then begin
    AClass:= TClass.Create(Self);
    AClass.Name:= NewName;  // sets package too
  end;
  Result:= (AClass as TClass);
  Result.FPathname:= Filename;
end;

procedure TUnitPackage.AddClass(const AClass: TClass);
  var AClass1: TClassifier;
begin
  AClass1:= FindClassifier(AClass.Name, TClass, True);
  if Assigned(AClass1) then begin
    Fire(mtBeforeAddChild, AClass1);
    Fire(mtAfterAddChild, AClass1);
  end else begin
    FClassifiers.Add(AClass);
    Fire(mtBeforeAddChild, AClass);
    Fire(mtAfterAddChild, AClass);
  end;
end;

procedure TUnitPackage.AddClassWithoutShowing(const AClass: TClass);
  var AClass1: TClassifier;
begin
  AClass1:= FindClassifier(AClass.Name, TClass, True);
  if Assigned(AClass1) then Exit;
  if Assigned(FClassifiers) then FClassifiers.Add(AClass);
end;

function TUnitPackage.MakeInterface(const NewName, Filename: string): TInterface;
begin
  Result := TInterface.Create(Self);
  Result.FName := NewName;
  Result.FPathname:= Filename;
end;

procedure TUnitPackage.AddInterface(const AInterface: TInterface);
begin
  FClassifiers.Add(AInterface);
  try
    Fire(mtBeforeAddChild, AInterface);
  except
    FClassifiers.Remove(AInterface);
  end;
  Fire(mtAfterAddChild, AInterface);
end;

procedure TUnitPackage.AddInterfaceWithoutShowing(const AInterface: TInterface);
begin
  FClassifiers.Add(AInterface);
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

function TUnitPackage.AddObject(const NewName: string; AClass: TClass): TObjekt;
begin
  try
    Result:= GetObjekt(NewName, AClass.Name);
  except
    Result:= nil;
    Exit;
  end;
  if not Assigned(Result) then begin
    Result:= TObjekt.Create(Self);
    Result.FName:= NewName;
    Result.IsVisible:= True;
    Result.FClass:= AClass;
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
  FFunctions.Add(Operation);
end;

function TUnitPackage.GetObjekt(const AName, Typ: string): TObjekt;
var
  Ite: TModelIterator;
  AClassifier: TClassifier;
  AObjekt: TObjekt;
begin
  Result := nil;
  Ite := TModelIterator.Create(GetClassifiers);
  try
    while Ite.HasNext do
    begin
      AClassifier := Ite.Next as TClassifier;
      if (AClassifier is TObjekt) then
      begin
        AObjekt := (AClassifier as TObjekt);
        if (AClassifier.Name = AName) and
          (GetShortType(AObjekt.FClass.Name) = Typ) then
        begin
          Result := (AClassifier as TObjekt);
          Break;
        end;
      end;
    end;
  finally
    FreeAndNil(Ite);
  end;
end;

function TUnitPackage.GetObjects(const Typ: string): TStringList;
  var Ite: TModelIterator; AClassifier: TClassifier;
begin
  Result:= TStringList.Create;
  Ite:= TModelIterator.Create(GetClassifiers);
  try
    while Ite.HasNext do begin
      AClassifier:= Ite.Next as TClassifier;
      if (AClassifier is TObjekt) and (GetShortType((AClassifier as TObjekt).FClass.Name) = Typ) then
        Result.AddObject((AClassifier as TObjekt).FName, AClassifier);
    end;
  finally
    FreeAndNil(Ite);
  end;
end;

function TUnitPackage.GetAllObjects: TStringList;
  var Ite: TModelIterator; AClassifier: TClassifier;
begin
  Result:= TStringList.Create;
  Ite:= TModelIterator.Create(GetClassifiers);
  try
    try
      while Ite.HasNext do begin
        AClassifier:= Ite.Next as TClassifier;
        if AClassifier is TObjekt then
          Result.AddObject((AClassifier as TObjekt).FName, AClassifier);
      end;
    finally
      FreeAndNil(Ite);
    end;
  except
      on E: Exception do
        OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
  end;
end;

procedure TUnitPackage.DeleteObject(AName: string);
  var AObject: TClassifier;
begin
  AObject:= FindClassifier(AName, nil, True);   // true wegen casesensitive
  if Assigned(AObject) then
    FClassifiers.Remove(AObject);
end;

function TUnitPackage.GetObject(const AName: string): TObjekt;
begin
  Result:= TObjekt(FindClassifier(AName, nil, False));
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
  TheClass : TModelEntityClass = nil; CaseSense : Boolean = False): TClassifier;
var
  Classi : TClassifier;
  MIte : IModelIterator;
  Package : TUnitPackage;
  Compare : TStrCompare;

  function InFind(Package : TUnitPackage) : TClassifier;
    var MIte: IModelIterator;
  begin
    Result := nil;
    if Assigned(TheClass) then
      MIte := TModelIterator.Create( Package.GetClassifiers , TheClass )
    else if Assigned(Package) then
      MIte := Package.GetClassifiers
    else
      Exit;
    while MIte.HasNext do begin
      Classi := MIte.Next as TClassifier;
      if Compare(Classi.Name, CName) = 0 then begin
        Result := Classi;
        Break;
      end;
    end;
  end;

begin
  Result:= nil;
  try
    Compare := CompareFunc[CaseSense];
    Result := InFind(Self);
    // if nil search in public dependencies
    if not Assigned(Result) then begin
      MIte := GetUnitDependencies;
      while MIte.HasNext do begin
        Package := (MIte.Next as TUnitDependency).MyPackage;
        Result := InFind(Package);
        if Assigned(Result) then
          Break;
      end;
    end;
  except on e: Exception do
    ErrorMsg(' TUnitPackage.FindClassifier');
  end;
end;

function TUnitPackage.FindClass(const FPathname: string): TClassifier;
begin
  Result:= nil;
  var MIte:= GetClassifiers;
  while MIte.HasNext do begin
    var Classifier:= MIte.Next as TClassifier;
    if Classifier.FPathname = FPathname then begin
      Result:= Classifier;
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

function TUnitPackage.AddUnitDependency(UnitPackage: TUnitPackage; AVisibility: TVisibility): TUnitDependency;
begin
  Assert( (UnitPackage <> Self) and Assigned(UnitPackage), ClassName + 'AddUnitDependency invalid parameter');
  Result := TUnitDependency.Create( Self );
  Result.MyPackage := UnitPackage;
  Result.Visibility := AVisibility;
  FUnitDependencies.Add( Result );
end;

function TUnitPackage.GetUnitDependencies: IModelIterator;
begin
  Result := TModelIterator.Create( FUnitDependencies );
end;

function TUnitPackage.Debug: string;
   var StringList: TStringList;
      CIte, AIte, OIte: IModelIterator;
      Cent: TClassifier;
      Attribute: TAttribute;
      Operation: TOperation;
begin
  StringList:= TStringList.Create;
  StringList.Add('UnitPackage: ' + Name);
  CIte:= GetClassifiers;
  while CIte.HasNext do begin
    Cent:= TClassifier(CIte.Next);
    StringList.Add(Cent.Name + ' - ' + Cent.FImportname + ' - ' + Cent.FPathname);
    StringList.Add('--- Attributes ---');
    AIte:= Cent.GetAllAttributes;
    while AIte.HasNext do begin
      Attribute:= AIte.Next as TAttribute;
      StringList.Add(Attribute.ToPython(False));
    end;
    StringList.Add('--- Operations ---');
    OIte:= Cent.GetOperations;
    while OIte.HasNext do begin
      Operation:= OIte.Next as TOperation;
      StringList.Add(Operation.HeadToPython);
    end;
    StringList.Add('-------------------------');
  end;
  Result:= StringList.Text;
  FreeAndNil(StringList);
end;

{ TClass }

constructor TClass.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FAncestor:= nil;
  FImplements:= TObjectList.Create(False); // only reference
  FAncestors:= TObjectList.Create(False);  // only reference
end;

destructor TClass.Destroy;
begin
  // Dont touch FListeners if the model is locked.
  if not Locked then
  begin
    Fire(mtBeforeRemove);
  end;
  FreeAndNil(FImplements);
  FreeAndNil(FAncestors);
  inherited;
end;

function TClass.AddAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
begin
  Result:= FindAttribute(WithoutVisibility(NewName), TypeClass);
  if not Assigned(Result) then begin
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

function TClass.AddOperationWithoutType(const NewName: string): TOperation;
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

function TClass.AddAncestors(AClass: TClass): TClass;
begin
  Result := AClass;
  FAncestors.Add(AClass);
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

procedure TClass.SetAncestor(Index: Integer; const Value: TClass);
var
  Old: TClass;
begin
  if Value = Self then Exit;
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

function TClass.GetAncestor(Index: Integer): TClass;
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
  var Int: Integer;
begin
  Int:= FAncestors.IndexOf(Self);
  if (0 <= Int) and (Int < FAncestors.Count) then begin
    TClass(FAncestors[Int]).RemoveListener(IBeforeClassListener(Self));
    FAncestors[Int]:= nil;
  end;
end;

function TClass.AncestorQueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): HRESULT; stdcall;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
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
function TClass.FindOperation(Operation: TOperation): TOperation;
var
  MIte, Omi1, Omi2: IModelIterator;
  Operation2: TOperation;
begin
  Result := nil;
  MIte := GetOperations;
  while MIte.HasNext do
  begin
    Operation2 := MIte.Next as TOperation;
    // Compare nr of parameters
    if Operation.FParameters.Count <> Operation2.FParameters.Count then
      Continue;
    // Compare operation name
    if CompareText(Operation.Name, Operation2.Name) <> 0 then
      Continue;
    // Compare parameters
    Omi1 := Operation.GetParameters;
    Omi2 := Operation2.GetParameters;
    var Okay:= True;
    while Okay and Omi1.HasNext do
      if CompareText((Omi1.Next as TParameter).Name, (Omi2.Next as TParameter).Name) <> 0 then
        Okay:= False;
    if not Okay then
      Continue;
    // Ok, match
    Result := Operation2;
    Break;
  end;
end;

function TClass.OperationIsProperty(Name: string): Boolean;
var
  MIte: IModelIterator;
  Operation : TOperation;
begin
  Result := False;
  MIte := GetOperations;
  while MIte.HasNext do begin
    Operation := MIte.Next as TOperation;
    if Operation.FIsPropertyMethod and (CompareText(Operation.Name, Name) = 0) then
      Exit(True);
  end;
end;

{
  Finds an attribute with same name and type.
}
function TClass.FindAttribute(const NewName: string; TypeClass: TClassifier): TAttribute;
var
  MIte: IModelIterator;
  Attribute: TAttribute;
begin
  Result := nil;
  MIte := GetAttributes;
  while MIte.HasNext do begin
    Attribute := MIte.Next as TAttribute;
    if (CompareText(NewName, Attribute.Name) = 0) and
       (not Assigned(TypeClass) or (CompareText(TypeClass.Name, Attribute.TypeClassifier.Name) = 0)) then
      Exit(Attribute);
  end;
end;

function TClass.GetTyp: string;
begin
  if FPathname <> ''
    then Result:= Name
    else Result:= FImportname;
end;

function TClass.GetAncestorName(Index: Integer): string;
begin
  if Assigned(Ancestor[Index])
    then Result:= Ancestor[Index].Name
    else Result:= '';
end;

function TClass.AncestorsCount: Integer;
begin
  Result:= FAncestors.Count;
end;

function TClass.AncestorsAsString: string;
begin
  if AncestorsCount = 0 then
    Result:= ''
  else begin
    Result:= Ancestor[0].Name;
    for var I:= 1 to AncestorsCount - 1 do
      Result:= Result + ', ' + Ancestor[I].Name;
  end;
end;

{ TObjekt }

destructor TObjekt.Destroy;
begin
  // Dont touch Listeners if the model is locked.
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
  var Attribute: TAttribute;
begin
  Result:= nil;
  for var I:= 0 to FFeatures.Count - 1 do begin
    Attribute:= FFeatures[I] as TAttribute;
    if Attribute.Name = NewName then begin
      Result:= Attribute;
      Break;
    end;
  end;
  if not Assigned(Result) then begin
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

function TObjekt.GetTyp: TClass;
begin
  Result:= FClass;
end;

function TObjekt.GenericName: string;
begin
  Result:= FClass.GenericName;
  if Result = '' then Result:= FClass.Name;
end;

{ TParameter }

constructor TParameter.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FTypeClassifier:= nil;
  FUsedForAttribute:= False;
  FValue:= '';
end;

class function TParameter.GetAfterListener: TGUID;
begin
  Result := IAfterParameterListener;
end;

class function TParameter.GetBeforeListener: TGUID;
begin
  Result := IBeforeParameterListener;
end;

function TParameter.AsPythonString: string;
begin
  Result:= Name;
  if Assigned(TypeClassifier) then
    // pep 0484 forward references, shell be solved with python 3.11 but arn't,
    Result:= Result + ': ' + TypeClassifier.AsType;
  if Value <> '' then
    Result:= Result + ' = ' + Value;
end;

function TParameter.AsUMLString(ShowParameter: Integer): string;
  var Str: string;
begin
  Str:= '';
  if ShowParameter >= 3 then begin
    Str:= Name;
    if Assigned(TypeClassifier) and (ShowParameter in [4, 6]) then
      Str:= Str + ': ' + TypeClassifier.AsUMLType;
    if (Value <> '') and (ShowParameter >= 5) then
      Str:= Str + ' = ' + Value;
  end;
  Result:= Str;
end;

function TParameter.ToShortStringNode: string;
begin
  if Assigned(TypeClassifier)
    then Result:= Name + ': ' + TypeClassifier.AsUMLType
    else Result:= Name;
end;

{ TOperation }

constructor TOperation.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
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
  for var I:= 0 to FParameters.Count - 1 do
    if TParameter(FParameters[I]).FName = NewName then begin
      FParameters.Delete(I);
      Break;
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
  except on e: Exception do begin
    ErrorMsg('TOperation.AddAttribute');
    end;
  end;
end;

function TOperation.GetAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( FAttributes);
end;

function TOperation.HeadToPython: string;
  var Str, Indent: string; Ite2: IModelIterator; Parameter: TParameter;
begin
  Indent:= StringTimesN(FConfiguration.Indent1, Level + 1);
  if FIsClassMethod then Str:= '(cls, '
  else if FIsStaticMethod then Str:= '('
  else Str:= '(self, ';

  Ite2:= GetParameters;
  while Ite2.HasNext do begin
    Parameter:= Ite2.Next as TParameter;
    if (Parameter.Name <> 'cls') and (Parameter.Name <> 'self') then
      Str:= Str + Parameter.AsPythonString + ', ';
  end;
  if Copy(Str, Length(Str) - 1, 2) = ', ' then
    Delete(Str, Length(Str) - 1, 2);
  Str:= Str + ')';
  case OperationType of
    otConstructor: Str:= '__init__' + Str;
    otProcedure:   Str:= VisName + Str;
    otFunction:    if Assigned(ReturnValue)
                     then Str:= VisName + Str + ' -> ' + ReturnValue.AsType
                     else Str:= VisName + Str;
  end;
  Str:= Indent + 'def ' + Str + ':';
  if FIsStaticMethod then
    Str:= Indent + '@staticmethod' + CrLf + Str;
  if FIsClassMethod then
    Str:= Indent + '@classmethod' + CrLf + Str;
  if FIsAbstract then
    Str:= Indent + '@abstractmethod' + CrLf + Str;
  if FIsPropertyMethod then
    Str:= Indent + '@property' + CrLf + Str;
  Result:= Str;
end;

function TOperation.ToShortStringWithoutParameterNames: string;
  var Str: string; Ite2: IModelIterator; Parameter: TParameter;
begin
  Str:= '(';
  Ite2:= GetParameters;
  while Ite2.HasNext do begin
    Parameter:= Ite2.Next as TParameter;
    if Assigned(Parameter.TypeClassifier)
      then Str:= Str + Parameter.TypeClassifier.AsType + ', '
      else Str:= Str + ', ';
  end;
  if Copy(Str, Length(Str) - 1, 2) = ', ' then
    Delete(Str, Length(Str) - 1, 2);
  Str:= Str + '):';
  case OperationType of
    otConstructor: Result:= '__init__' + Str;
    otProcedure:   Result:= Name + Str;
    otFunction:    if Assigned(ReturnValue)
                     then Result:= Name + Str + ' ->' + ReturnValue.AsType
                     else Result:= Name + Str;
  end;
end;

function TOperation.ToShortStringNode: string;
  var Str: string; Ite2: IModelIterator; Parameter: TParameter;
begin
  Str:= '(';
  Ite2:= GetParameters;
  while Ite2.HasNext do begin
    Parameter:= Ite2.Next as TParameter;
    if (Parameter.Name <> 'self') and (Parameter.Name <> 'cls') then
      Str:= Str + Parameter.AsUMLString(4) + ', ';
  end;
  if Copy(Str, Length(Str)-1, 2) = ', ' then
    Delete(Str, Length(Str)-1, 2); // delete last comma
  Str:= Str + ')';
  case OperationType of
    otConstructor: Result:= Name + Str;
    otProcedure:   Result:= Name + Str;
    otFunction:    if Assigned(ReturnValue)
                     then Result:= Name + Str + ': ' + ReturnValue.AsUMLType
                     else Result:= Name + Str;
  end;
end;

function TOperation.VisName: string;
  var Str: string;
begin
  Str:= Name;
  while (Length(Str) > 0) and (Str[1] = '_') do
    Delete(Str, 1, 1);
  case Visibility of
    viPrivate: Str:= '__' + Str;
    viProtected: Str:= '_' + Str;
  end;
  Result:= Str;
end;

procedure TOperation.SetAttributeScope(ScopeDepth, LineE: Integer);
  var Ite: IModelIterator;
      Attribute: TAttribute;
begin
  Ite:= GetAttributes;
  while Ite.HasNext do begin
    Attribute:= Ite.Next as TAttribute;
    if (Attribute.LineE = 0) and (Attribute.ScopeDepth = ScopeDepth) then
      Attribute.LineE:= LineE;
  end;
end;

function TOperation.GetFormattedDescription: string;
begin
  Result:= MyStringReplace(Documentation.Description, #13#10, '<br>');
end;

{ TAttribute }

constructor TAttribute.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FTypeClassifier:= nil;
  FConnected:= False;
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
  // 2D arrays rows from numpy are separated by #$A
  FValue:= MyStringReplace(Value, #$A, ', ');
  try
    Fire(mtBeforeEntityChange);
  except
    FName := OldValue;
  end;
  Fire(mtAfterEntityChange);
end;

procedure TAttribute.SetConnected(Value: Boolean);
var
  OldValue: Boolean;
begin
  OldValue := FConnected;
  FConnected := Value;
  try
    Fire(mtBeforeEntityChange);
  except
    FConnected := OldValue;
  end;
  Fire(mtAfterEntityChange);
end;

function TAttribute.VisName: string;
  var Str: string;
begin
  Str:= Name;
  while (Length(Str) > 0) and (Str[1] = '_') do
    Delete(Str, 1, 1);
  case Visibility of
    viPrivate: Str:= '__' + Str;
    viProtected: Str:= '_' + Str;
  end;
  Result:= Str;
end;

function TAttribute.ToPython(TypeChanged: Boolean): string;
  const Values = '|0|0.0|''''|True|False|None|[]|()|{}|';
  var Str: string; Count: Integer;
begin
  Str:= VisName;
  if not Static then
    Str:= 'self.' + Str;
  if IsFinal then begin
    Str:= Str + ': Final';
    if Assigned(TypeClassifier) then
      Str:= Str + '[' + TypeClassifier.AsType + ']';
  end else if Assigned(TypeClassifier) then begin
    Str:= Str + ': ' + TypeClassifier.AsType;
    if TypeChanged and (Pos('|' + Value + '|', Values) > 0) then
      Value:= TypeClassifier.AsValue;  // Value of attribute is changed
  end;
  Str:= Str + ' = ';
  if Value <> '' then
    Str:= Str + Value
  else if Assigned(TypeClassifier) then
    Str:= Str + TypeClassifier.AsValue
  else
    Str:= Str + 'None';
  if Static
    then Count:= Level + 1
    else Count:= Level + 2;
  Result:= StringTimesN(FConfiguration.Indent1, Count) + Str;
end;

function TAttribute.ToNameType: string;
begin
  if Assigned(TypeClassifier)
    then Result:= Name + ': ' + TypeClassifier.AsType
    else Result:= Name;
end;

function TAttribute.ToNameTypeUML: string;
begin
  if Assigned(TypeClassifier)
    then Result:= Name + ': ' + TypeClassifier.AsUMLType
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

constructor TClassifier.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FFeatures := TObjectList.Create(True);
  FGenericName:= '';
  FInner:= False;
  FSourceRead:= False;
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

function TClassifier.GetShortType: string;
begin
  try
    Result:= ShortName;
  except
    on E: Exception do
      OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
  end;
end;

function TClassifier.GetAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TAttribute);
end;

function TClassifier.GetAllAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TAttribute, Low(TVisibility), ioNone, True);
end;

function TClassifier.GetOperations: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TOperation);
end;

function TClassifier.GetName: string;
begin
  Result:= Name;
end;

function TClassifier.GetAncestorName(Index: Integer): string;
begin
  Result:= '';
end;

function TClassifier.AsValue: string;
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
    Result:= AsType;
end;

function TClassifier.AsType: string;
begin
  Result:= Name;
  if Result = 'boolean' then
    Result:= 'bool'
  else if (Result = 'String') or (Result = 'string') then
    Result:= 'str'
  else if Result = 'integer' then
    Result:= 'int';
end;

function TClassifier.AsUMLType: string;
begin
  Result:= Name;
  if Result = 'bool' then
    Result:= 'boolean'
  else if Result = 'str' then
    Result:= 'String'
  else if Result = 'int' then
    Result:= 'integer';
end;

procedure TClassifier.SetCapacity(Capacity: Integer);
begin
  FFeatures.Capacity:= Capacity;
end;

{ TInterface }

constructor TInterface.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
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

function TInterface.GetAncestorName(Index: Integer): string;
begin
  if Assigned(Ancestor)
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
  Result := FConfigFile;
  if (Result='') and Assigned(FOwner) then
    Result := (Owner as TAbstractPackage).GetConfigFile;
end;

procedure TAbstractPackage.SetConfigFile(const Value: string);
begin
  if Value<>'' then
    FConfigFile := ChangeFileExt(Value,ConfigFileExt);
end;


{ TClassDescendantFilter }

constructor TClassDescendantFilter.Create(Ancestor: TClass);
begin
  inherited Create;
  Self.FAncestor := Ancestor;
end;

//Returns true if M inherits from ancestor
function TClassDescendantFilter.Accept(Model: TModelEntity): Boolean;
begin
  var I:= (Model as TClass).FAncestors.IndexOf(FAncestor);
  Result := (Model is TClass) and (I <> -1);
end;

{ TInterfaceImplementsFilter }

constructor TInterfaceImplementsFilter.Create(Inter: TInterface);
begin
  inherited Create;
  FInt := Inter;
end;

//Returns true if M implements interface Int
function TInterfaceImplementsFilter.Accept(Model: TModelEntity): Boolean;
begin
  Result := (Model is TClass) and ((Model as TClass).FImplements.IndexOf(FInt)<>-1);
end;

var
  GAllClassesPackage : TAbstractPackage = nil;

//Unique Flag-instance, if Integrator.CurrentEntity=AllClassesPackage then show all classes
function AllClassesPackage : TAbstractPackage;
begin
  if not Assigned(GAllClassesPackage) then
    GAllClassesPackage := TAbstractPackage.Create(nil);
  Result := GAllClassesPackage;
end;

procedure AllClassesPackageClose;
begin
  FreeAndNil(GAllClassesPackage);
end;

end.
