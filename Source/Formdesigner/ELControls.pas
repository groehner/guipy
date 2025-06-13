{*******************************************************}
{                                                       }
{       Extension Library                               }
{       Controls Unit                                   }
{                                                       }
{       (c) 1999 - 2002, Balabuyev Yevgeny              }
{       E-mail: stalcer@rambler.ru                      }
{       Licence: Freeware                               }
{       https://torry.net/authorsmore.php?id=3588       }
{                                                       }
{*******************************************************}

unit ELControls;

interface

uses
  Classes;

  { TELObjectList }

type

  TELObjectList = class
  private
    FItems: TList;
    FChangingCount: Boolean;
    function GetItems(AIndex: Integer): TObject;
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
  protected
    function CreateItem: TObject; virtual;
    procedure ValidateAddition; virtual;
    procedure ValidateDeletion; virtual;
    procedure Change; virtual;
    procedure Added; virtual;
    procedure Deleted; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: Integer;
    procedure Remove(AItem: TObject);
    procedure Delete(AIndex: Integer);
    procedure Clear;
    procedure Sort(Compare: TListSortCompare);
    function IndexOf(AItem: TObject): Integer;
    property Items[AIndex: Integer]: TObject read GetItems; default;
    property Count: Integer read GetCount write SetCount;
  end;

  { TELEventSender, TELEvent }

implementation

uses
  SysUtils;

{ TELObjectList }

function TELObjectList.Add: Integer;
begin
  ValidateAddition;
  Result := FItems.Add(CreateItem);
  Added;
  if not FChangingCount then Change;
end;

constructor TELObjectList.Create;
begin
  FItems := TList.Create;
end;

function TELObjectList.CreateItem: TObject;
begin
  Result := nil;
end;

procedure TELObjectList.Delete(AIndex: Integer);
  var AObject: TObject;
begin
  ValidateDeletion;
  AObject:= TObject(FItems[AIndex]);
  FreeAndNil(AObject);
  FItems.Delete(AIndex);
  Deleted;
  if not FChangingCount then Change;
end;

destructor TELObjectList.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TELObjectList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TELObjectList.GetItems(AIndex: Integer): TObject;
begin
  Result := TObject(FItems[AIndex]);
end;

// Röhner
procedure TELObjectList.Sort(Compare: TListSortCompare);
begin
  FItems.Sort(Compare);
end;

function TELObjectList.IndexOf(AItem: TObject): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TELObjectList.Remove(AItem: TObject);
var
  LIndex: Integer;
begin
  LIndex := FItems.IndexOf(AItem);
  if LIndex <> -1 then Delete(LIndex);
end;

procedure TELObjectList.SetCount(const Value: Integer);
begin
  FChangingCount := True;
  try
    if Value > Count then
      while Count < Value do Add
    else if Value < Count then
      while Count > Value do Delete(Count - 1);
  finally
    FChangingCount := False;
  end;
  Change;
end;

procedure TELObjectList.Clear;
begin
  Count := 0;
end;

procedure TELObjectList.ValidateAddition;
begin
  // Do nothing
end;

procedure TELObjectList.ValidateDeletion;
begin
  // Do nothing
end;

procedure TELObjectList.Change;
begin
  // Do nothing
end;

procedure TELObjectList.Added;
begin
  // Do nothing
end;

procedure TELObjectList.Deleted;
begin
  // Do nothing
end;

end.
