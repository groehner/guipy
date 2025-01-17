{-----------------------------------------------------------------------------
 Unit Name: cCustomShortcuts
 Author:    Kiriakos Vlahos
            Gerhard Röhner
 Purpose:   code to support IDE shortcut customization
 History:   Based on Delhpi Magazine article
-----------------------------------------------------------------------------}

unit cCustomShortcuts;

interface

uses
  Classes, Controls, StdCtrls, System.Actions, ActnList, dlgPyIDEBase,
  ExtCtrls, SynEditMiscClasses, System.Generics.Collections;

type
  TActionProxyItem = class(TCollectionItem)
  private
    fSecondaryShortCuts: TShortCutList;
    FShortCut: TShortCut;
    fActionListName: string;
    fActionName: string;
    procedure SetSecondaryShortCuts(const Value: TCustomShortCutList);
    function GetSecondaryShortCuts: TCustomShortCutList;
  protected
    function GetDisplayName : string;  override;
  public
    Category : string;
    Caption : string;
    Hint : string;
    destructor Destroy; override;
    function IsSecondaryShortCutsStored: Boolean;
  published
    property ActionListName : string read fActionListName write fActionListName;
    property ActionName : string read fActionName write fActionName;
    property ShortCut: TShortCut read FShortCut write FShortCut default 0;
    property SecondaryShortCuts: TCustomShortCutList read GetSecondaryShortCuts
      write SetSecondaryShortCuts stored IsSecondaryShortCutsStored;
  end;

  TActionListArray = array of TActionList;

  TActionProxyCollectionCreateType = (apcctEmpty, apcctAll, apcctChanged);

  TActionProxyCollection = class(TCollection)
    constructor Create(CreateType : TActionProxyCollectionCreateType);
    procedure ApplyShortCuts;
    public
    class var ActionLists : TActionListArray;
    class var ChangedActions: TList<TCustomAction>;
    class constructor Create;
    class destructor Destroy;
  end;

implementation

uses
  SysUtils,
  Menus,
  uCommonFunctions;

{ TActionProxyItem }

procedure TActionProxyItem.SetSecondaryShortCuts(const Value: TCustomShortCutList);
begin
  if FSecondaryShortCuts = nil then
    FSecondaryShortCuts := TShortCutList.Create;
  fSecondaryShortCuts.Assign(Value);
end;

function TActionProxyItem.IsSecondaryShortCutsStored: Boolean;
begin
  Result := Assigned(FSecondaryShortCuts) and (FSecondaryShortCuts.Count > 0);
end;

destructor TActionProxyItem.Destroy;
begin
  if Assigned(FSecondaryShortCuts) then
    FreeAndNil(FSecondaryShortCuts);
  inherited;
end;

function TActionProxyItem.GetDisplayName: string;
begin
  Result := StripHotkey(Caption)
end;

function TActionProxyItem.GetSecondaryShortCuts: TCustomShortCutList;
begin
  if FSecondaryShortCuts = nil then
    FSecondaryShortCuts := TShortCutList.Create;
  Result := FSecondaryShortCuts;
end;

{ TActionProxyCollection }

constructor TActionProxyCollection.Create(CreateType : TActionProxyCollectionCreateType);
var
  i, j, Index : Integer;
  Action : TCustomAction;
  ActionList : TActionList;
  ActionProxyItem : TActionProxyItem;
begin
  inherited Create(TActionProxyItem);
  if CreateType = apcctEmpty then Exit;

  for i := Low(TActionProxyCollection.ActionLists) to High(TActionProxyCollection.ActionLists) do begin
    ActionList := TActionProxyCollection.ActionLists[i];
    for j := 0 to ActionList.ActionCount - 1 do begin
      Action := ActionList.Actions[j] as TCustomAction;
      if TActionProxyCollection.ChangedActions.BinarySearch(Action, Index) or
        (CreateType = apcctAll) then
      begin
        ActionProxyItem := Add as TActionProxyItem;
        ActionProxyItem.fActionListName := ActionList.Name;
        ActionProxyItem.fActionName := Action.Name;
        ActionProxyItem.FShortCut := Action.ShortCut;
        ActionProxyItem.Category := Action.Category;
        ActionProxyItem.Caption := Action.Caption;
        ActionProxyItem.Hint := Action.Hint;
        if Action.SecondaryShortCuts.Count > 0 then
          ActionProxyItem.SecondaryShortCuts := Action.SecondaryShortCuts;
      end;
    end;
  end;
end;

function FindActionListByName(Name : string;
  ActionListArray: TActionListArray) : TActionList;
var
  i : Integer;
begin
  Result := nil;
  for i := Low(TActionProxyCollection.ActionLists) to High(TActionProxyCollection.ActionLists) do
    if ActionListArray[i].Name = Name then begin
      Result := ActionListArray[i];
      Break;
    end;
end;

function FindActionByName(Name : string; ActionList : TActionList): TCustomAction;
var
  i : Integer;
begin
  Result := nil;
  for i := 0 to ActionList.ActionCount - 1 do
    if ActionList.Actions[i].Name = Name then begin
      Result := ActionList.Actions[i] as TCustomAction;
      Break;
    end;
end;

function SameShortcuts(Action : TCustomAction; ActionProxy : TActionProxyItem): Boolean;
begin
  //  No PyScripter action has secondary shortcuts by default
  Result := (Action.ShortCut = ActionProxy.ShortCut)
    and (not ActionProxy.IsSecondaryShortCutsStored and (Action.SecondaryShortCuts.Count = 0));
end;

procedure TActionProxyCollection.ApplyShortCuts();
var
  i : Integer;
  Index : Integer;
  ActionProxyItem : TActionProxyItem;
  ActionList : TActionList;
  Action : TCustomAction;
begin
  for i := 0 to Count - 1 do begin
    ActionProxyItem := Items[i] as TActionProxyItem;
    ActionList := FindActionListByName(ActionProxyItem.ActionListName, TActionProxyCollection.ActionLists);
    if Assigned(ActionList) then begin
      Action := FindActionByName(ActionProxyItem.ActionName, ActionList);
      if Assigned(Action) then begin
        if SameShortcuts(Action, ActionProxyItem) then Continue;

        Action.ShortCut := ActionProxyItem.ShortCut;
        Action.SecondaryShortCuts.Clear;
        if ActionProxyItem.IsSecondaryShortCutsStored then
          Action.SecondaryShortCuts.Assign(ActionProxyItem.SecondaryShortCuts);
        //  Keep ChangedActions sorted
        if not TActionProxyCollection.ChangedActions.BinarySearch(Action, Index) then
          TActionProxyCollection.ChangedActions.Insert(Index, Action);
      end;
    end;
  end;
end;

class constructor TActionProxyCollection.Create;
begin
  SetLength(TActionProxyCollection.ActionLists, 0);
  TActionProxyCollection.ChangedActions := TList<TCustomAction>.Create;
end;

class destructor TActionProxyCollection.Destroy;
begin
  SetLength(TActionProxyCollection.ActionLists, 0);
  TActionProxyCollection.ChangedActions.Free;
end;


end.
