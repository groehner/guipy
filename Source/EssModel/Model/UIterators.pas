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

unit UIterators;

interface

{
  Iterators and filters for model navigation.
}

uses Contnrs, UUtils, uModelEntity;

type

  //Baseclass for iterators
  TModelIterator = class(TInterfacedObject, IModelIterator)
  private
    FItems : TObjectList;
    OwnsItems : Boolean;
    NextI : Integer;
    FNext : TModelEntity;
    FHasNext : Boolean;
  private
    procedure Init(List : IModelIterator; Filter : IIteratorFilter; Order : TIteratorOrder);
  protected
    procedure Advance; virtual;
  public
    constructor Create(ObList: TObjectList; MakeCopy : Boolean = False); overload;
    constructor Create(List: IModelIterator; Filter: IIteratorFilter; Order: TIteratorOrder = ioNone); overload;
    constructor Create(List: IModelIterator;
      OneClass: TModelEntityClass;
      MinVisibility: TVisibility = Low(TVisibility);
      Order: TIteratorOrder = ioNone;
      All: Boolean = False); overload;
    constructor Create(List: IModelIterator; Order: TIteratorOrder = ioNone); overload;
    constructor Create(List: IModelIterator; MinVisibility: TVisibility); overload;
    destructor Destroy; override;
    //IModelIterator
    function HasNext : Boolean;
    function Next : TModelEntity;
    procedure Reset;
    function Count : Integer;
  end;

  //Baseclass for filter used in iterators
  TIteratorFilter = class(TInterfacedObject, IIteratorFilter)
  public
    function Accept(M : TModelEntity) : Boolean; virtual; abstract;
  end;

  //Filters on a class and a minimum visibilty
  TClassAndVisibilityFilter = class(TIteratorFilter)
  private
    OneClass : TModelEntityClass;
    MinVisibility : TVisibility;
    All: Boolean;
  public
    constructor Create(aOneClass : TModelEntityClass; aMinVisibility : TVisibility = Low(TVisibility); aAll: Boolean = False);
    function Accept(M : TModelEntity) : Boolean; override;
  end;

  //Excludes an entity
  TEntitySkipFilter = class(TIteratorFilter)
  private
    SkipEntity : TModelEntity;
  public
    constructor Create(aSkipEntity : TModelEntity);
    function Accept(M : TModelEntity) : Boolean; override;
  end;

implementation

uses Classes, SysUtils;



{ TModelIterator }

//Creates iterator as a direct copy of an objectlist.
//If makecopy=false then reference oblist, else copy all items.

constructor TModelIterator.Create(ObList: TObjectList; MakeCopy : Boolean = False);
var
  I : Integer;
begin
  inherited Create;
  if MakeCopy then begin
    //Copy oblist to items
    OwnsItems := True;
    FItems := TObjectList.Create(False);
    for I:=0 to ObList.Count-1 do
      FItems.Add(ObList[I]);
  end else begin
    //Reference, same list instead of copy
    OwnsItems := False;
    FItems := ObList;
  end;
  Advance;
end;


//Creates an iterator based on another iterator, filter with Filter, sort on Order.
constructor TModelIterator.Create(List: IModelIterator; Filter : IIteratorFilter; Order : TIteratorOrder = ioNone);
begin
  inherited Create;
  Init(List, Filter, Order);
end;


//Creates an iterator based on another iterator, filter on class and
//visibility, sort result.
constructor TModelIterator.Create(List: IModelIterator;
  OneClass: TModelEntityClass;
  MinVisibility : TVisibility = Low(TVisibility);
  Order : TIteratorOrder = ioNone;
  All: Boolean = False);
begin
  inherited Create;
  Init(List, TClassAndVisibilityFilter.Create(OneClass, MinVisibility, All), Order);
end;

//Creates an iterator based on another iterator, sort result.
constructor TModelIterator.Create(List: IModelIterator; Order: TIteratorOrder);
begin
  inherited Create;
  Init(List, nil, Order);
end;

//Creates an iterator based on another iterator, filtered on visibility.
constructor TModelIterator.Create(List: IModelIterator; MinVisibility: TVisibility);
begin
  inherited Create;
  //TModelEntity as classfilter = always true
  Init(List, TClassAndVisibilityFilter.Create(TModelEntity, MinVisibility), ioNone);
end;

destructor TModelIterator.Destroy;
begin
  if OwnsItems then
    FreeAndNil(FItems);
  inherited;
end;

function SortVisibility(Item1, Item2: Pointer): Integer;
var
  E1, E2: TModelEntity;
begin
  //Visibility, then alpha
  E1:= TModelEntity(Item1);
  E2:= TModelEntity(Item2);
  if (E1.Visibility < E2.Visibility) then
    Result:= -1  //Lower
  else if (E1.Visibility = E2.Visibility) then
    Result:= CompareText(E1.Name, E2.Name)
  else
    Result:= 1; //Higher
end;

function SortAlpha(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText( TModelEntity(Item1).Name , TModelEntity(Item2).Name );
end;


//Called by all iterator constructors that has an iterator as a parameter
//Initializes iterator
procedure TModelIterator.Init(List: IModelIterator; Filter: IIteratorFilter; Order: TIteratorOrder);
var
  E : TModelEntity;
begin
  OwnsItems := True;
  FItems := TObjectList.Create(False);
  if Assigned(Filter) then
    while List.HasNext do
    begin
      E := List.Next;
      if Filter.Accept( E ) then
        FItems.Add( E );
    end
  else // not filtered
    while List.HasNext do
      FItems.Add( List.Next );
  // sort
  case Order of
    ioNone : ;
    ioVisibility : FItems.Sort( {$IFDEF LCL} @ {$ENDIF} SortVisibility );
    ioAlpha      : FItems.Sort( {$IFDEF LCL} @ {$ENDIF} SortAlpha );
  end;
  Advance;
end;


procedure TModelIterator.Advance;
begin
  if Assigned(FItems)
    then FHasNext := NextI < FItems.Count
    else FHasNext := False;
  if FHasNext then begin
    if FItems[NextI] is TModelEntity then
      FNext := FItems[NextI] as TModelEntity;
    Inc(NextI);
  end;
end;

function TModelIterator.HasNext: Boolean;
begin
  Result := FHasNext;
end;

function TModelIterator.Next: TModelEntity;
begin
  if not FHasNext then
    raise Exception.Create(ClassName + '.Next at end');
  Result := FNext;
  Advance;
end;

procedure TModelIterator.Reset;
begin
  NextI := 0;
  Advance;
end;

{
  Returns nr of elements.
}
function TModelIterator.Count: Integer;
begin
  Result := FItems.Count;
end;


{ TClassAndVisibilityFilter }

constructor TClassAndVisibilityFilter.Create(aOneClass: TModelEntityClass;
  aMinVisibility: TVisibility; aAll: Boolean);
begin
  inherited Create;
  Self.OneClass := aOneClass;
  Self.MinVisibility := aMinVisibility;
  Self.All:= aAll;
end;

function TClassAndVisibilityFilter.Accept(M: TModelEntity): Boolean;
begin
  if All
    then Result := (M is OneClass) and (M.Visibility >= MinVisibility)
    else Result := (M is OneClass) and (M.Visibility >= MinVisibility) and not M.Hidden;
end;


{ TEntitySkipFilter }

constructor TEntitySkipFilter.Create(aSkipEntity: TModelEntity);
begin
  Self.SkipEntity := aSkipEntity;
end;

function TEntitySkipFilter.Accept(M: TModelEntity): Boolean;
begin
  Result := M<>SkipEntity;
end;


end.
