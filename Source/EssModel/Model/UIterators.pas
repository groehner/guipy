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

uses
  Contnrs,
  UModelEntity,
  UUtils;

type

  // Baseclass for iterators
  TModelIterator = class(TInterfacedObject, IModelIterator)
  private
    FItems: TObjectList;
    FOwnsItems: Boolean;
    FNextI: Integer;
    FNext: TModelEntity;
    FHasNext: Boolean;
    procedure Init(List: IModelIterator; Filter: IIteratorFilter;
      Order: TIteratorOrder);
  protected
    procedure Advance; virtual;
  public
    constructor Create(ObList: TObjectList; MakeCopy: Boolean = False);
      overload;
    constructor Create(List: IModelIterator; Filter: IIteratorFilter;
      Order: TIteratorOrder = ioNone); overload;
    constructor Create(List: IModelIterator; FOneClass: TModelEntityClass;
      FMinVisibility: TVisibility = Low(TVisibility);
      Order: TIteratorOrder = ioNone; FAll: Boolean = False); overload;
    constructor Create(List: IModelIterator;
      Order: TIteratorOrder = ioNone); overload;
    constructor Create(List: IModelIterator;
      FMinVisibility: TVisibility); overload;
    destructor Destroy; override;
    // IModelIterator
    function HasNext: Boolean;
    function Next: TModelEntity;
    procedure Reset;
    function Count: Integer;
  end;

  // Baseclass for filter used in iterators
  TIteratorFilter = class(TInterfacedObject, IIteratorFilter)
  public
    function Accept(Model: TModelEntity): Boolean; virtual; abstract;
  end;

  // Filters on a class and a minimum visibilty
  TClassAndVisibilityFilter = class(TIteratorFilter)
  private
    FOneClass: TModelEntityClass;
    FMinVisibility: TVisibility;
    FAll: Boolean;
  public
    constructor Create(FOneClass: TModelEntityClass;
      FMinVisibility: TVisibility = Low(TVisibility); FAll: Boolean = False);
    function Accept(Model: TModelEntity): Boolean; override;
  end;

  // Excludes an entity
  TEntitySkipFilter = class(TIteratorFilter)
  private
    FSkipEntity: TModelEntity;
  public
    constructor Create(FSkipEntity: TModelEntity);
    function Accept(Model: TModelEntity): Boolean; override;
  end;

implementation

uses
  Classes,
  SysUtils;

{ TModelIterator }

// Creates iterator as a direct copy of an objectlist.
// If makecopy=false then reference oblist, else copy FAll items.

constructor TModelIterator.Create(ObList: TObjectList;
  MakeCopy: Boolean = False);
begin
  inherited Create;
  if MakeCopy then
  begin
    // Copy oblist to items
    FOwnsItems := True;
    FItems := TObjectList.Create(False);
    for var I := 0 to ObList.Count - 1 do
      FItems.Add(ObList[I]);
  end
  else
  begin
    // Reference, same list instead of copy
    FOwnsItems := False;
    FItems := ObList;
  end;
  Advance;
end;

// Creates an iterator based on another iterator, filter with Filter, sort on Order.
constructor TModelIterator.Create(List: IModelIterator; Filter: IIteratorFilter;
  Order: TIteratorOrder = ioNone);
begin
  inherited Create;
  Init(List, Filter, Order);
end;

// Creates an iterator based on another iterator, filter on class and
// visibility, sort result.
constructor TModelIterator.Create(List: IModelIterator;
  FOneClass: TModelEntityClass; FMinVisibility: TVisibility = Low(TVisibility);
  Order: TIteratorOrder = ioNone; FAll: Boolean = False);
begin
  inherited Create;
  Init(List, TClassAndVisibilityFilter.Create(FOneClass, FMinVisibility,
    FAll), Order);
end;

// Creates an iterator based on another iterator, sort result.
constructor TModelIterator.Create(List: IModelIterator; Order: TIteratorOrder);
begin
  inherited Create;
  Init(List, nil, Order);
end;

// Creates an iterator based on another iterator, filtered on visibility.
constructor TModelIterator.Create(List: IModelIterator;
  FMinVisibility: TVisibility);
begin
  inherited Create;
  // TModelEntity as classfilter = always true
  Init(List, TClassAndVisibilityFilter.Create(TModelEntity,
    FMinVisibility), ioNone);
end;

destructor TModelIterator.Destroy;
begin
  if FOwnsItems then
    FreeAndNil(FItems);
  inherited;
end;

function SortVisibility(Item1, Item2: Pointer): Integer;
begin
  // Visibility, then alpha
  var
  Model1 := TModelEntity(Item1);
  var
  Model2 := TModelEntity(Item2);
  if (Model1.Visibility < Model2.Visibility) then
    Result := -1 // Lower
  else if (Model1.Visibility = Model2.Visibility) then
    Result := CompareText(Model1.Name, Model2.Name)
  else
    Result := 1; // Higher
end;

function SortAlpha(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TModelEntity(Item1).Name, TModelEntity(Item2).Name);
end;

// Called by FAll iterator constructors that has an iterator as a parameter
// Initializes iterator
procedure TModelIterator.Init(List: IModelIterator; Filter: IIteratorFilter;
  Order: TIteratorOrder);
begin
  FOwnsItems := True;
  FItems := TObjectList.Create(False);
  if Assigned(Filter) then
    while List.HasNext do
    begin
      var E := List.Next;
      if Filter.Accept(E) then
        FItems.Add(E);
    end
  else // not filtered
    while List.HasNext do
      FItems.Add(List.Next);
  // sort
  case Order of
    ioNone:
      ;
    ioVisibility:
      FItems.Sort( {$IFDEF LCL} @ {$ENDIF} SortVisibility);
    ioAlpha:
      FItems.Sort( {$IFDEF LCL} @ {$ENDIF} SortAlpha);
  end;
  Advance;
end;

procedure TModelIterator.Advance;
begin
  if Assigned(FItems) then
    FHasNext := FNextI < FItems.Count
  else
    FHasNext := False;
  if FHasNext then
  begin
    if FItems[FNextI] is TModelEntity then
      FNext := FItems[FNextI] as TModelEntity;
    Inc(FNextI);
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
  FNextI := 0;
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

constructor TClassAndVisibilityFilter.Create(FOneClass: TModelEntityClass;
  FMinVisibility: TVisibility; FAll: Boolean);
begin
  inherited Create;
  Self.FOneClass := FOneClass;
  Self.FMinVisibility := FMinVisibility;
  Self.FAll := FAll;
end;

function TClassAndVisibilityFilter.Accept(Model: TModelEntity): Boolean;
begin
  if FAll then
    Result := (Model is FOneClass) and (Model.Visibility >= FMinVisibility)
  else
    Result := (Model is FOneClass) and (Model.Visibility >= FMinVisibility) and
      not Model.Hidden;
end;

{ TEntitySkipFilter }

constructor TEntitySkipFilter.Create(FSkipEntity: TModelEntity);
begin
  Self.FSkipEntity := FSkipEntity;
end;

function TEntitySkipFilter.Accept(Model: TModelEntity): Boolean;
begin
  Result := Model <> FSkipEntity;
end;

end.
