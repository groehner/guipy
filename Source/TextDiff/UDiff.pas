unit UDiff;

(* ******************************************************************************
  * Component         TDiff                                                      *
  * Version:          4.1                                                        *
  * Date:             7 November 2009                                            *
  * Compilers:        Delphi 7 - Delphi 2009                                     *
  * Author:           Angus Johnson - angusj-AT-myrealbox-DOT-com                *
  * Copyright:        © 2001-2009 Angus Johnson                                  *
  *                                                                              *
  * Licence to use, terms and conditions:                                        *
  *                   The code in the TDiff component is released as freeware    *
  *                   provided you agree to the following terms & conditions:    *
  *                   1. the copyright notice, terms and conditions are          *
  *                   left unchanged                                             *
  *                   2. modifications to the code by other authors must be      *
  *                   clearly documented and accompanied by the modifier's name. *
  *                   3. the TDiff component may be freely compiled into binary  *
  *                   format and no acknowledgement is required. However, a      *
  *                   discrete acknowledgement would be appreciated (eg. in a    *
  *                   program's 'About Box').                                    *
  *                                                                              *
  * Description:      Component to list differences between two integer arrays   *
  *                   using a "longest common subsequence" algorithm.            *
  *                   Typically, this component is used to diff 2 text files     *
  *                   once their individuals lines have been hashed.             *
  *                                                                              *
  * Acknowledgements: The key algorithm in this component is based on:           *
  *                   "An O(NP) Sequence Comparison Algorithm"                   *
  *                   by Sun Wu, Udi Manber & Gene Myers                         *
  *                   and uses a "divide-and-conquer" technique to avoid         *
  *                   using exponential amounts of memory as described in        *
  *                   "An O(ND) Difference Algorithm and its Variations"         *
  *                   By E Myers - Algorithmica Vol. 1 No. 2, 1986, pp. 251-266  *
  ****************************************************************************** *)

(* ******************************************************************************
  * History:                                                                     *
  * 13 December 2001 - Original release (used Myer's O(ND) Difference Algorithm) *
  * 22 April 2008    - Complete rewrite to greatly improve the code and          *
  *                    provide a much simpler view of differences through a new  *
  *                    'Compares' property.                                      *
  * 21 May 2008      - Another complete code rewrite to use Sun Wu et al.'s      *
  *                    O(NP) Sequence Comparison Algorithm which more than       *
  *                    halves times of typical comparisons.                      *
  * 24 May 2008      - Reimplemented "divide-and-conquer" technique (which was   *
  *                    omitted in 21 May release) so memory use is again minimal.*
  * 25 May 2008      - Removed recursion to avoid the possibility of running out *
  *                    of stack memory during massive comparisons.               *
  * 2 June 2008      - Bugfix: incorrect number of appended AddChangeInt() calls *
  *                    in Execute() for integer arrays. (It was OK with Chars)   *
  *                    Added check to prevent repeat calls to Execute() while    *
  *                    already executing.                                        *
  *                    Added extra parse of differences to find occasional       *
  *                    missed matches. (See readme.txt for further discussion)   *
  * 7 November 2009  - Updated so now compiles in newer versions of Delphi.      *
  ****************************************************************************** *)

interface

uses
  Windows, Classes;

const
  MAX_DIAGONAL = $FFFFFF; // ~16 million

type

  TArrOfInteger = array of Integer;

  PDiags = ^TDiags;
  TDiags = array [-MAX_DIAGONAL .. MAX_DIAGONAL] of Integer;

  TChangeKind = (ckNone, ckAdd, ckDelete, ckModify);

  PCompareRec = ^TCompareRec;

  TCompareRec = record
    Kind: TChangeKind;
    OldIndex1, OldIndex2: Integer;
    case Boolean of
      False:
        (chr1, chr2: Char);
      True:
        (int1, int2: Integer);
  end;

  TDiffStats = record
    matches: Integer;
    adds: Integer;
    deletes: Integer;
    modifies: Integer;
  end;

  TDiff = class(TComponent)
  private
    FCompareList: TList;
    FDiffList: TList; // this TList circumvents the need for recursion
    FCancelled: Boolean;
    FExecuting: Boolean;
    FCompareInts: Boolean; // ie are we comparing integer arrays
    FDiagBufferF: Pointer;
    FDiagBufferB: Pointer;
    FDiagF, FDiagB: PDiags;
    FInts1, FInts2: TArrOfInteger;
    FDiffStats: TDiffStats;
    FLastCompareRec: TCompareRec;
    procedure PushDiff(Offset1, Offset2, Len1, Len2: Integer);
    function PopDiff: Boolean;
    procedure InitDiagArrays(Len1, Len2: Integer);
    procedure DiffInt(Offset1, Offset2, Len1, Len2: Integer);
    function SnakeIntF(IntK, Offset1, Offset2, Len1, Len2: Integer): Boolean;
    function SnakeIntB(IntK, Offset1, Offset2, Len1, Len2: Integer): Boolean;
    procedure AddChangeInt(Offset1, Range: Integer; ChangeKind: TChangeKind);
    function GetCompareCount: Integer;
    function GetCompare(Index: Integer): TCompareRec;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // compare array of integers ...
    function Execute(Pints1, Pints2: TArrOfInteger;
      Len1, Len2: Integer): Boolean;

    // Cancel allows interrupting excessively prolonged comparisons
    procedure Cancel;
    procedure Clear;
    property Cancelled: Boolean read FCancelled;
    property Count: Integer read GetCompareCount;
    property Compares[Index: Integer]: TCompareRec read GetCompare; default;
    property DiffStats: TDiffStats read FDiffStats;
  end;

implementation

uses Forms;

type

{$IFDEF UNICODE}
  P8Bits = PByte;
{$ELSE}
  P8Bits = PAnsiChar;
{$ENDIF}
  PDiffVars = ^TDiffVars;

  TDiffVars = record
    Offset1: Integer;
    Offset2: Integer;
    Len1: Integer;
    Len2: Integer;
  end;

  // ------------------------------------------------------------------------------
  // ------------------------------------------------------------------------------

constructor TDiff.Create(AOwner: TComponent);
begin
  inherited;
  FCompareList := TList.Create;
  FDiffList := TList.Create;
end;
// ------------------------------------------------------------------------------

destructor TDiff.Destroy;
begin
  Clear;
  FCompareList.Free;
  FDiffList.Free;
  inherited;
end;
// ------------------------------------------------------------------------------

function TDiff.Execute(Pints1, Pints2: TArrOfInteger;
  Len1, Len2: Integer): Boolean;
var
  Len1Minus1: Integer;
begin
  Result := not FExecuting;
  if not Result then
    Exit;
  FCancelled := False;
  FExecuting := True;
  try
    Clear;

    Len1Minus1 := Len1 - 1;
    FCompareList.Capacity := Len1 + Len2;
    FCompareInts := True;

    GetMem(FDiagBufferF, SizeOf(Integer) * (Len1 + Len2 + 3));
    GetMem(FDiagBufferB, SizeOf(Integer) * (Len1 + Len2 + 3));
    FInts1 := Pints1;
    FInts2 := Pints2;
    try
      PushDiff(0, 0, Len1, Len2);
      while PopDiff do;
    finally
      FreeMem(FDiagBufferF);
      FreeMem(FDiagBufferB);
    end;

    if FCancelled then
    begin
      Result := False;
      Clear;
      Exit;
    end;

    // correct the occasional missed match ...
    for var I := 1 to Count - 1 do
      with PCompareRec(FCompareList[I])^ do
        if (Kind = ckModify) and (int1 = int2) then
        begin
          Kind := ckNone;
          Dec(FDiffStats.modifies);
          Inc(FDiffStats.matches);
        end;

    // finally, append any trailing matches onto compareList ...
    with FLastCompareRec do
      AddChangeInt(OldIndex1, Len1Minus1 - OldIndex1, ckNone);
  finally
    FExecuting := False;
  end;
end;
// ------------------------------------------------------------------------------

procedure TDiff.PushDiff(Offset1, Offset2, Len1, Len2: Integer);
var
  DiffVars: PDiffVars;
begin
  New(DiffVars);
  DiffVars.Offset1 := Offset1;
  DiffVars.Offset2 := Offset2;
  DiffVars.Len1 := Len1;
  DiffVars.Len2 := Len2;
  FDiffList.Add(DiffVars);
end;
// ------------------------------------------------------------------------------

function TDiff.PopDiff: Boolean;
var
  DiffVars: PDiffVars;
begin
  var ACount := FDiffList.Count - 1;
  Result := ACount >= 0;
  if not Result then
    Exit;
  DiffVars := PDiffVars(FDiffList[ACount]);
  with DiffVars^ do
    if FCompareInts then
      DiffInt(Offset1, Offset2, Len1, Len2);
  Dispose(DiffVars);
  FDiffList.Delete(ACount);
end;
// ------------------------------------------------------------------------------

procedure TDiff.InitDiagArrays(Len1, Len2: Integer);
begin
  // assumes that top and bottom matches have been excluded
  P8Bits(FDiagF) := P8Bits(FDiagBufferF) - SizeOf(Integer) *
    (MAX_DIAGONAL - (Len1 + 1));
  for var I := -(Len1 + 1) to (Len2 + 1) do
    FDiagF[I] := -MaxInt;
  FDiagF[1] := -1;

  P8Bits(FDiagB) := P8Bits(FDiagBufferB) - SizeOf(Integer) *
    (MAX_DIAGONAL - (Len1 + 1));
  for var I := -(Len1 + 1) to (Len2 + 1) do
    FDiagB[I] := MaxInt;
  FDiagB[Len2 - Len1 + 1] := Len2;
end;
// ------------------------------------------------------------------------------

procedure TDiff.DiffInt(Offset1, Offset2, Len1, Len2: Integer);
var
  Posi, Delta: Integer;
begin
  // trim matching bottoms ...
  while (Len1 > 0) and (Len2 > 0) and (FInts1[Offset1] = FInts2[Offset2]) do
  begin
    Inc(Offset1);
    Inc(Offset2);
    Dec(Len1);
    Dec(Len2);
  end;
  // trim matching tops ...
  while (Len1 > 0) and (Len2 > 0) and
    (FInts1[Offset1 + Len1 - 1] = FInts2[Offset2 + Len2 - 1]) do
  begin
    Dec(Len1);
    Dec(Len2);
  end;

  // stop diff'ing if minimal conditions reached ...
  if (Len1 = 0) then
  begin
    AddChangeInt(Offset1, Len2, ckAdd);
    Exit;
  end
  else if (Len2 = 0) then
  begin
    AddChangeInt(Offset1, Len1, ckDelete);
    Exit;
  end
  else if (Len1 = 1) and (Len2 = 1) then
  begin
    AddChangeInt(Offset1, 1, ckDelete);
    AddChangeInt(Offset1, 1, ckAdd);
    Exit;
  end;

  Posi := -1;
  Delta := Len2 - Len1;
  InitDiagArrays(Len1, Len2);
  if Delta < 0 then
  begin
    repeat
      Inc(Posi);
      if (Posi mod 1024) = 1023 then
      begin
        Application.ProcessMessages;
        if FCancelled then
          Exit;
      end;
      // nb: the Snake order is important here
      for var K := Posi downto Delta + 1 do
        if SnakeIntF(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      for var K := -Posi + Delta to Delta - 1 do
        if SnakeIntF(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      for var K := Delta - Posi to -1 do
        if SnakeIntB(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      for var K := Posi downto 1 do
        if SnakeIntB(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      if SnakeIntF(Delta, Offset1, Offset2, Len1, Len2) then
        Exit;
      if SnakeIntB(0, Offset1, Offset2, Len1, Len2) then
        Exit;
    until False;
  end
  else
  begin
    repeat
      Inc(Posi);
      if (Posi mod 1024) = 1023 then
      begin
        Application.ProcessMessages;
        if FCancelled then
          Exit;
      end;
      // nb: the Snake order is important here
      for var K := -Posi to Delta - 1 do
        if SnakeIntF(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      for var K := Posi + Delta downto Delta + 1 do
        if SnakeIntF(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      for var K := Delta + Posi downto 1 do
        if SnakeIntB(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      for var K := -Posi to -1 do
        if SnakeIntB(K, Offset1, Offset2, Len1, Len2) then
          Exit;
      if SnakeIntF(Delta, Offset1, Offset2, Len1, Len2) then
        Exit;
      if SnakeIntB(0, Offset1, Offset2, Len1, Len2) then
        Exit;
    until False;
  end;
end;
// ------------------------------------------------------------------------------

function TDiff.SnakeIntF(IntK, Offset1, Offset2, Len1, Len2: Integer): Boolean;
var
  IntX, IntY: Integer;
begin
  if FDiagF[IntK + 1] > FDiagF[IntK - 1] then
    IntY := FDiagF[IntK + 1]
  else
    IntY := FDiagF[IntK - 1] + 1;
  IntX := IntY - IntK;
  while (IntX < Len1 - 1) and (IntY < Len2 - 1) and
    (FInts1[Offset1 + IntX + 1] = FInts2[Offset2 + IntY + 1]) do
  begin
    Inc(IntX);
    Inc(IntY);
  end;
  FDiagF[IntK] := IntY;
  Result := (FDiagF[IntK] >= FDiagB[IntK]);
  if not Result then
    Exit;

  Inc(IntX);
  Inc(IntY);
  PushDiff(Offset1 + IntX, Offset2 + IntY, Len1 - IntX, Len2 - IntY);
  PushDiff(Offset1, Offset2, IntX, IntY);
end;
// ------------------------------------------------------------------------------

function TDiff.SnakeIntB(IntK, Offset1, Offset2, Len1, Len2: Integer): Boolean;
var
  IntX, IntY: Integer;
begin
  if FDiagB[IntK - 1] < FDiagB[IntK + 1] then
    IntY := FDiagB[IntK - 1]
  else
    IntY := FDiagB[IntK + 1] - 1;
  IntX := IntY - IntK;
  while (IntX >= 0) and (IntY >= 0) and (FInts1[Offset1 + IntX] = FInts2[Offset2 + IntY]) do
  begin
    Dec(IntX);
    Dec(IntY);
  end;
  FDiagB[IntK] := IntY;
  Result := FDiagB[IntK] <= FDiagF[IntK];
  if not Result then
    Exit;

  Inc(IntX);
  Inc(IntY);
  PushDiff(Offset1 + IntX, Offset2 + IntY, Len1 - IntX, Len2 - IntY);
  PushDiff(Offset1, Offset2, IntX, IntY);
end;
// ------------------------------------------------------------------------------

procedure TDiff.AddChangeInt(Offset1, Range: Integer; ChangeKind: TChangeKind);
var
  IntJ: Integer;
  CompareRec: PCompareRec;
begin
  // first, add any unchanged items into this list ...
  while FLastCompareRec.OldIndex1 < Offset1 - 1 do
  begin
    with FLastCompareRec do
    begin
      Kind := ckNone;
      Inc(OldIndex1);
      Inc(OldIndex2);
      int1 := FInts1[OldIndex1];
      int2 := FInts2[OldIndex2];
    end;
    New(CompareRec);
    CompareRec^ := FLastCompareRec;
    FCompareList.Add(CompareRec);
    Inc(FDiffStats.matches);
  end;

  case ChangeKind of
    ckNone:
      for var I := 1 to Range do
      begin
        with FLastCompareRec do
        begin
          Kind := ckNone;
          Inc(OldIndex1);
          Inc(OldIndex2);
          int1 := FInts1[OldIndex1];
          int2 := FInts2[OldIndex2];
        end;
        New(CompareRec);
        CompareRec^ := FLastCompareRec;
        FCompareList.Add(CompareRec);
        Inc(FDiffStats.matches);
      end;
    ckAdd:
      begin
        for var I := 1 to Range do
        begin
          with FLastCompareRec do
          begin

            // check if a Range of adds are following a Range of deletes
            // and convert them to modifies ...
            if Kind = ckDelete then
            begin
              IntJ := FCompareList.Count - 1;
              while (IntJ > 0) and
                (PCompareRec(FCompareList[IntJ - 1]).Kind = ckDelete) do
                Dec(IntJ);
              PCompareRec(FCompareList[IntJ]).Kind := ckModify;
              Dec(FDiffStats.deletes);
              Inc(FDiffStats.modifies);
              Inc(FLastCompareRec.OldIndex2);
              PCompareRec(FCompareList[IntJ]).OldIndex2 :=
                FLastCompareRec.OldIndex2;
              PCompareRec(FCompareList[IntJ]).int2 := FInts2[OldIndex2];
              if IntJ = FCompareList.Count - 1 then
                FLastCompareRec.Kind := ckModify;
              Continue;
            end;

            Kind := ckAdd;
            int1 := $0;
            Inc(OldIndex2);
            int2 := FInts2[OldIndex2]; // ie what we added
          end;
          New(CompareRec);
          CompareRec^ := FLastCompareRec;
          FCompareList.Add(CompareRec);
          Inc(FDiffStats.adds);
        end;
      end;
    ckDelete:
      begin
        for var I := 1 to Range do
        begin
          with FLastCompareRec do
          begin

            // check if a Range of deletes are following a range of adds
            // and convert them to modifies ...
            if Kind = ckAdd then
            begin
              IntJ := FCompareList.Count - 1;
              while (IntJ > 0) and
                (PCompareRec(FCompareList[IntJ - 1]).Kind = ckAdd) do
                Dec(IntJ);
              PCompareRec(FCompareList[IntJ]).Kind := ckModify;
              Dec(FDiffStats.adds);
              Inc(FDiffStats.modifies);
              Inc(FLastCompareRec.OldIndex1);
              PCompareRec(FCompareList[IntJ]).OldIndex1 :=
                FLastCompareRec.OldIndex1;
              PCompareRec(FCompareList[IntJ]).int1 := FInts1[OldIndex1];
              if IntJ = FCompareList.Count - 1 then
                FLastCompareRec.Kind := ckModify;
              Continue;
            end;

            Kind := ckDelete;
            int2 := $0;
            Inc(OldIndex1);
            int1 := FInts1[OldIndex1]; // ie what we deleted
          end;
          New(CompareRec);
          CompareRec^ := FLastCompareRec;
          FCompareList.Add(CompareRec);
          Inc(FDiffStats.deletes);
        end;
      end;
  end;
end;
// ------------------------------------------------------------------------------

procedure TDiff.Clear;
begin
  for var I := 0 to FCompareList.Count - 1 do
    Dispose(PCompareRec(FCompareList[I]));
  FCompareList.Clear;
  FLastCompareRec.Kind := ckNone;
  FLastCompareRec.OldIndex1 := -1;
  FLastCompareRec.OldIndex2 := -1;
  FDiffStats.matches := 0;
  FDiffStats.adds := 0;
  FDiffStats.deletes := 0;
  FDiffStats.modifies := 0;
  FInts1 := nil;
  FInts2 := nil;
end;
// ------------------------------------------------------------------------------

function TDiff.GetCompareCount: Integer;
begin
  Result := FCompareList.Count;
end;
// ------------------------------------------------------------------------------

function TDiff.GetCompare(Index: Integer): TCompareRec;
begin
  Result := PCompareRec(FCompareList[Index])^;
end;
// ------------------------------------------------------------------------------

procedure TDiff.Cancel;
begin
  FCancelled := True;
end;
// ------------------------------------------------------------------------------

end.
