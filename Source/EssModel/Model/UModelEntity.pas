{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde

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

{
  Definition of TModelEntity is in it's own unit to avoid a circular unit
  reference between uModel and uListeners

  IModelIterator is defined here for the same reason.
}

unit UModelEntity;

interface

uses
  Classes,
  UDocumentation,
  UUtils;

type
  TListenerMethodType = (mtBeforeChange, mtBeforeAddChild, mtBeforeRemove, mtBeforeEntityChange,
    mtAfterChange, mtAfterAddChild, mtAfterRemove, mtAfterEntityChange);

  TModelEntity = class(TObject)
  private
    function GetRoot: TModelEntity;
  protected
    FDocumentation: TDocumentation;
    FListeners: TInterfaceList;
    FOwner: TModelEntity;
    FVisibility: TVisibility;
    FName: string;
    FShortName: string;
    FPackage: string;
    FStatic: Boolean;
    FFinal: Boolean;
    FHasFinal: Boolean;
    FIsAbstract: Boolean;
    FIsVisible: Boolean;
    FIsObject: Boolean;
    FLocked: Boolean;
    FLineS: Integer;
    FLineSE: Integer;
    FLineE: Integer;
    FSpalte: Integer;
    FScopeDepth: Integer;
    FHidden: Boolean;
    FLevel: Integer;
    procedure SetName(const Value: string); virtual;
    function GetShortname: string;
    function GetFullname: string; virtual;
    function GetPackage: string;
    class function GetBeforeListener: TGUID; virtual;
    class function GetAfterListener: TGUID; virtual;
    procedure SetVisibility(const Value: TVisibility);
    procedure SetIsAbstract(const Value: Boolean);
    function GetLocked: Boolean;
    procedure Fire(Method: TListenerMethodType; Info: TModelEntity = nil); virtual;
    { IUnknown, required for listener }
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(Owner: TModelEntity); virtual;
    destructor Destroy; override;
    procedure AddListener(NewListener: IUnknown);
    procedure RemoveListener(Listener: IUnknown);
    function GetFullnameWithoutOuter: string;
    property Level: Integer read FLevel write FLevel;
    property Name: string read FName write SetName;
    property Fullname: string read GetFullname;
    property ShortName: string read GetShortname;
    property Package: string read GetPackage;
    property Owner: TModelEntity read FOwner write FOwner;
    property Visibility: TVisibility read FVisibility write SetVisibility;
    property Static: Boolean read FStatic write FStatic;
    property IsFinal: Boolean read FFinal write FFinal;
    property HasFinal: Boolean read FHasFinal write FHasFinal;
    property IsAbstract: Boolean read FIsAbstract write SetIsAbstract;
    property Locked: Boolean read GetLocked write FLocked;
    property Root : TModelEntity read GetRoot;
    property Documentation : TDocumentation read FDocumentation;
    property IsVisible: Boolean read FIsVisible write FIsVisible;
    property LineS: Integer read FLineS write FLineS;
    property LineSE: Integer read FLineSE write FLineSE;
    property LineE: Integer read FLineE write FLineE;
    property Spalte: Integer read FSpalte write FSpalte;
    property ScopeDepth: Integer read FScopeDepth write FScopeDepth;
    property Hidden: Boolean read FHidden write FHidden;
  end;

  TModelEntityClass = class of TModelEntity;

  //Sortorder for iterators
  TIteratorOrder = (ioNone, ioVisibility, ioAlpha {,ioType});

  //Basinterface for iterators
  IModelIterator = interface(IUnknown)
    ['{42329900-029F-46AE-96ED-6D4ABBEAFD4F}']
    function HasNext : Boolean;
    function Next : TModelEntity;
    procedure Reset;
    function Count : Integer;
  end;

  //Basinterface for iteratorfilters
  IIteratorFilter = interface(IUnknown)
    ['{FD77FD42-456C-4B8A-A917-A2555881E164}']
    function Accept(Model : TModelEntity) : Boolean;
  end;

implementation

uses
  SysUtils,
  Windows,
  UListeners;

{ TModelEntity }

constructor TModelEntity.Create(Owner: TModelEntity);
begin
  Self.Owner:= Owner;
  FIsObject:= False;
  FListeners:= TInterfaceList.Create;
  FDocumentation:= TDocumentation.Create;
  FName:= '';
  FShortName:= '';
  FPackage:= ' '; // not initialized
end;

destructor TModelEntity.Destroy;
begin
  FreeAndNil(FDocumentation);
  // here we get sometimes exceptions/memory leaks
  // when called by TLogicPackage.Destroy

  // presumably only if MadExcept is reporting memory leaks

  //if not (Self.ClassName = 'TLogicPackage') then
  try
    FListeners.Clear;
    FreeAndNil(FListeners);
  except
    on E: Exception do
      OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
  end;
  inherited;
end;

function TModelEntity.GetShortname: string;
  var Posi: Integer; Str, VarArg: string;
begin
  if FShortName = '' then begin
    Str:= FName;
    if Pos('.', FName) > 0 then begin
      // remove all long package types
      Str:= FName;
      if Str.EndsWith('...') then begin
        Delete(Str, Length(Str)-2, 3);
        VarArg:= '...';
      end else
        VarArg:= '';
      Posi:= LastDelimiter('.', Str);
      Delete(Str, 1, Posi);
      Str:= Str + VarArg;
    end;
    FShortName:= Str;
  end;
  Result:= FShortName;
end;

function TModelEntity.GetFullname: string;
begin
  if FName = 'Default'
    then Result:= ''
    else Result:= FName;
end;

function TModelEntity.GetFullnameWithoutOuter: string;
  var Posi: Integer;
begin
  Result:= GetFullname;
  Posi:= Pos('.', Result);
  if Posi > 0 then Delete(Result, 1, Posi);
end;

function TModelEntity.GetPackage: string;
  var Int: Integer;
begin
  if FPackage = ' ' then begin
    Int:= LastDelimiter('.', FName);
    if Int > 0
      then Result:= Copy(FName, 1, Int-1)
      else Result:= '';
  end else
    Result:= FPackage;
end;

function TModelEntity.GetLocked: Boolean;
begin
// Sant ifall detta object eller något ovanför i ownerhierarkien är låst
// Sant Wenn dieses Objekt oder eine der oben ownerhierarkien ist gesperrt
  Result := FLocked or (Assigned(Owner) and Owner.Locked);
end;

procedure TModelEntity.AddListener(NewListener: IUnknown);
begin
  if FListeners.IndexOf(NewListener) = -1 then
    FListeners.Add(NewListener);
end;

procedure TModelEntity.RemoveListener(Listener: IUnknown);
begin
  try
    FListeners.Remove(Listener);
  except
    on E: Exception do
      OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
 end;
end;

procedure TModelEntity.SetName(const Value: string);
var
  OldName: string; Int: Integer;
begin
  OldName := FName;
  FName:= Value;
  try
    Fire(mtBeforeEntityChange);
    FShortName:= GetShortname;
    Int:= LastDelimiter('.', WithoutGeneric(Value));
    if Int > 0
      then FPackage:= Copy(FName, 1, Int-1)
      else FPackage:= '';
  except
    FName := OldName;
    raise;
  end {try};
  Fire(mtAfterEntityChange);
end;

procedure TModelEntity.SetVisibility(const Value: TVisibility);
var
  Old: TVisibility;
begin
  Old := Value;
  FVisibility := Value;
  try
    Fire(mtBeforeEntityChange);
  except
    FVisibility := Old;
    raise;
  end {try};
  Fire(mtAfterEntityChange);
end;

procedure TModelEntity.SetIsAbstract(const Value: Boolean);
var
  Old: Boolean;
begin
  Old := FIsAbstract;
  if Old <> Value then
  begin
    FIsAbstract := Value;
    try
      Fire(mtBeforeEntityChange);
    except
      FIsAbstract := Old;
      raise;
    end;
    Fire(mtAfterEntityChange);
  end;
end;

procedure TModelEntity.Fire(Method: TListenerMethodType; Info: TModelEntity = nil);
var
  IMEL: IModelEntityListener;
  Instance: IUnknown;
begin
  if not Locked and Assigned(FListeners) then
    for var I := 0 to FListeners.Count - 1 do begin
      Instance := FListeners[I];
      case Method of
        mtBeforeAddChild:
          if Supports(Instance, GetBeforeListener, IMEL) then
            IMEL.AddChild(Self, Info);
        mtBeforeRemove:
          if Supports(Instance, GetBeforeListener, IMEL) then
            IMEL.Remove(Self);
        mtBeforeChange:
          if Supports(Instance, GetBeforeListener, IMEL) then
            IMEL.Change(Self);
        mtBeforeEntityChange:
          if Supports(Instance, GetBeforeListener, IMEL) then
            IMEL.EntityChange(Self);
        mtAfterAddChild:
          if Supports(Instance, GetAfterListener, IMEL) then
            IMEL.AddChild(Self, Info);
        mtAfterRemove:
          if Supports(Instance, GetAfterListener, IMEL) then
            IMEL.Remove(Self);
        mtAfterChange:
          if Supports(Instance, GetAfterListener, IMEL) then
            IMEL.Change(Self);
        mtAfterEntityChange:
          if Supports(Instance, GetAfterListener, IMEL) then
            IMEL.EntityChange(Self);
      else
        raise Exception.Create(ClassName + ' Eventmethod not recognized.');
      end {case};
    end;
end;

function TModelEntity.QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

function TModelEntity._AddRef: Integer; stdcall;
begin
  Result := -1; // -1 indicates no reference counting is taking place
end;

function TModelEntity._Release: Integer; stdcall;
begin
  Result := -1; // -1 indicates no reference counting is taking place
end;

function TModelEntity.GetRoot: TModelEntity;
begin
  Result := Self;
  while Result.Owner<>nil do
    Result := Result.Owner;
end;

class function TModelEntity.GetAfterListener: TGUID;
begin
  raise Exception.Create( ClassName + '.GetAfterListener');
end;

class function TModelEntity.GetBeforeListener: TGUID;
begin
  raise Exception.Create( ClassName + '.GetBeforeListener');
end;

end.
