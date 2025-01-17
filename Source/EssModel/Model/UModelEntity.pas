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

uses Classes, uDocumentation, UUtils;

type
  TListenerMethodType = (mtBeforeChange, mtBeforeAddChild, mtBeforeRemove, mtBeforeEntityChange,
    mtAfterChange, mtAfterAddChild, mtAfterRemove, mtAfterEntityChange);

  TModelEntity = class(TObject)
  private
    function GetRoot: TModelEntity;
  protected
    FDocumentation: TDocumentation;
    Listeners: TInterfaceList;

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
    function GetShortName: string;
    function getFullName: string; virtual;
    function GetPackage: string;
    class function GetBeforeListener: TGUID; virtual;
    class function GetAfterListener: TGUID; virtual;
    procedure SetVisibility(const Value: TVisibility);
    procedure SetIsAbstract(const Value: Boolean);
    function GetLocked: Boolean;
    procedure Fire(Method: TListenerMethodType; Info: TModelEntity = nil); virtual;
    { IUnknown, required for listener }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(aOwner: TModelEntity); virtual;
    destructor Destroy; override;
    procedure AddListener(NewListener: IUnknown);
    procedure RemoveListener(Listener: IUnknown);
    function GetFullNameWithoutOuter: string;
    property Level: Integer read FLevel write FLevel;
    property Name: string read FName write SetName;
    property Fullname: string read GetFullName;
    property ShortName: string read GetShortName;
    property Package: string read GetPackage;
    property Owner: TModelEntity read FOwner write FOwner;
    property Visibility: TVisibility read FVisibility write SetVisibility;
    property Static: Boolean read FStatic write FStatic;
    property IsFinal: Boolean read FFinal write FFinal;
    property hasFinal: Boolean read FhasFinal write FhasFinal;
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
    function Accept(M : TModelEntity) : Boolean;
  end;

implementation

uses Sysutils, Windows, uListeners;

{ TModelEntity }

constructor TModelEntity.Create(aOwner: TModelEntity);
begin
  Self.Owner:= aOwner;
  FIsObject:= False;
  Listeners:= TInterfaceList.Create;
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
    Listeners.Clear;
    FreeAndNil(Listeners);
  except
  end;
end;

function TModelEntity.GetShortName: string;
  var p: Integer; s, vararg: string;
begin
  if FShortName = '' then begin
    s:= FName;
    if Pos('.', FName) > 0 then begin
      // remove all long package types
      s:= FName;
      if s.EndsWith('...') then begin
        Delete(s, Length(s)-2, 3);
        vararg:= '...'
      end else
        vararg:= '';
      p:= LastDelimiter('.', s);
      Delete(s, 1, p);
      s:= s + vararg;
    end;
    FShortName:= s;
  end;
  Result:= FShortName;
end;

function TModelEntity.GetFullName: string;
begin
  if FName = 'Default'
    then Result:= ''
    else Result:= FName;
end;

function TModelEntity.GetFullNameWithoutOuter: string;
  var p: Integer;
begin
  Result:= GetFullName;
  p:= Pos('.', Result);
  if p > 0 then Delete(Result, 1, p);
end;

function TModelEntity.GetPackage: string;
  var i: Integer;
begin
  if FPackage = ' ' then begin
    i:= LastDelimiter('.', FName);
    if i > 0
      then Result:= Copy(FName, 1, i-1)
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
  if Listeners.IndexOf(NewListener) = -1 then
    Listeners.Add(NewListener)
end;

procedure TModelEntity.RemoveListener(Listener: IUnknown);
begin
  try
    Listeners.Remove(Listener);
  except
  end;
end;

procedure TModelEntity.SetName(const Value: string);
var
  OldName: string; i: Integer;
begin
  OldName := FName;
  FName:= Value;
  try
    Fire(mtBeforeEntityChange);
    FShortName:= getShortName;
    i:= LastDelimiter('.', withoutGeneric(Value));
    if i > 0
      then FPackage:= Copy(FName, 1, i-1)
      else FPackage:= '';
  except
    FName := OldName;
    raise;
  end {try};
  Fire(mtAfterEntityChange)
end;

procedure TModelEntity.SetVisibility(const Value: TVisibility);
var
  Old: TVisibility;
begin
  Old := Value;
  FVisibility := Value;
  try
    Fire(mtBeforeEntityChange)
  except
    FVisibility := Old;
    raise;
  end {try};
  Fire(mtAfterEntityChange)
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
  I: Integer;
  IL: IModelEntityListener;
  L: IUnknown;
begin
  if not Locked and Assigned(Listeners) then
    for I := 0 to Listeners.Count - 1 do begin
      L := Listeners[I];
      case Method of
        mtBeforeAddChild:
          if Supports(L, GetBeforeListener, IL) then
            IL.AddChild(Self, Info);
        mtBeforeRemove:
          if Supports(L, GetBeforeListener, IL) then
            IL.Remove(Self);
        mtBeforeChange:
          if Supports(L, GetBeforeListener, IL) then
            IL.Change(Self);
        mtBeforeEntityChange:
          if Supports(L, GetBeforeListener, IL) then
            IL.EntityChange(Self);
        mtAfterAddChild:
          if Supports(L, GetAfterListener, IL) then
            IL.AddChild(Self, Info);
        mtAfterRemove:
          if Supports(L, GetAfterListener, IL) then
            IL.Remove(Self);
        mtAfterChange:
          if Supports(L, GetAfterListener, IL) then
            IL.Change(Self);
        mtAfterEntityChange:
          if Supports(L, GetAfterListener, IL) then
            IL.EntityChange(Self);
      else
        raise Exception.Create(ClassName + ' Eventmethod not recognized.');
      end {case};
    end;
end;

function TModelEntity.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE
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
