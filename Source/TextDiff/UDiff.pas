unit UDiff;

(*******************************************************************************
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
*******************************************************************************)

(*******************************************************************************
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
*******************************************************************************)

interface

uses
  Windows, Classes;

const
  MAX_DIAGONAL = $FFFFFF; //~16 million

type

  TArrOfInteger = array of Integer;

  PDiags = ^TDiags;
  TDiags = array [-MAX_DIAGONAL .. MAX_DIAGONAL] of Integer;

  TChangeKind = (ckNone, ckAdd, ckDelete, ckModify);

  PCompareRec = ^TCompareRec;
  TCompareRec = record
    Kind      : TChangeKind;
    oldIndex1,
    oldIndex2 : Integer;
    case Boolean of
      False   : (chr1, chr2 : Char);
      True    : (int1, int2 : Integer);
  end;

  TDiffStats = record
    matches  : Integer;
    adds     : Integer;
    deletes  : Integer;
    modifies : Integer;
  end;

  TDiff = class(TComponent)
  private
    fCompareList: TList;
    fDiffList: TList;      //this TList circumvents the need for recursion
    fCancelled: Boolean;
    fExecuting: Boolean;
    fCompareInts: Boolean; //ie are we comparing integer arrays
    DiagBufferF: pointer;
    DiagBufferB: pointer;
    DiagF, DiagB: PDiags;
    Ints1, Ints2: TArrOfInteger;
    fDiffStats: TDiffStats;
    fLastCompareRec: TCompareRec;
    procedure PushDiff(offset1, offset2, len1, len2: Integer);
    function  PopDiff: Boolean;
    procedure InitDiagArrays(len1, len2: Integer);
    procedure DiffInt(offset1, offset2, len1, len2: Integer);
    function SnakeIntF(k,offset1,offset2,len1,len2: Integer): Boolean;
    function SnakeIntB(k,offset1,offset2,len1,len2: Integer): Boolean;
    procedure AddChangeInt(offset1, range: Integer; ChangeKind: TChangeKind);
    function GetCompareCount: Integer;
    function GetCompare(index: Integer): TCompareRec;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    //compare array of integers ...
    function Execute(pints1, pints2: TArrOfInteger; len1, len2: Integer): Boolean;

    //Cancel allows interrupting excessively prolonged comparisons
    procedure Cancel;
    procedure Clear;
    property Cancelled: Boolean read fCancelled;
    property Count: Integer read GetCompareCount;
    property Compares[index: Integer]: TCompareRec read GetCompare; default;
    property DiffStats: TDiffStats read fDiffStats;
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
    offset1 : Integer;
    offset2 : Integer;
    len1    : Integer;
    len2    : Integer;
  end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

constructor TDiff.Create(aOwner: TComponent);
begin
  inherited;
  fCompareList := TList.Create;
  fDiffList := TList.Create;
end;
//------------------------------------------------------------------------------

destructor TDiff.Destroy;
begin
  Clear;
  fCompareList.free;
  fDiffList.Free;
  inherited;
end;
//------------------------------------------------------------------------------

function TDiff.Execute(pints1, pints2: TArrOfInteger; len1, len2: Integer): Boolean;
var
  i, Len1Minus1: Integer;
begin
  result := not fExecuting;
  if not result then Exit;
  fCancelled := False;
  fExecuting := True;
  try
    Clear;

    Len1Minus1 := len1 -1;
    fCompareList.Capacity := len1 + len2;
    fCompareInts := True;

    GetMem(DiagBufferF, sizeof(Integer)*(len1+len2+3));
    GetMem(DiagBufferB, sizeof(Integer)*(len1+len2+3));
    Ints1 := pints1;
    Ints2 := pints2;
    try
      PushDiff(0, 0, len1, len2);
      while PopDiff do;
    finally
      freeMem(DiagBufferF);
      freeMem(DiagBufferB);
    end;

    if fCancelled then
    begin
      result := False;
      Clear;
      Exit;
    end;

    //correct the occasional missed match ...
    for i := 1 to Count -1 do
      with PCompareRec(fCompareList[i])^ do
        if (Kind = ckModify) and (int1 = int2) then
        begin
          Kind := ckNone;
          Dec(fDiffStats.modifies);
          Inc(fDiffStats.matches);
        end;
        
    //finally, append any trailing matches onto compareList ...
    with fLastCompareRec do
      AddChangeInt(oldIndex1,len1Minus1-oldIndex1, ckNone);
  finally
    fExecuting := False;
  end;
end;
//------------------------------------------------------------------------------

procedure TDiff.PushDiff(offset1, offset2, len1, len2: Integer);
var
  DiffVars: PDiffVars;
begin
  new(DiffVars);
  DiffVars.offset1 := offset1;
  DiffVars.offset2 := offset2;
  DiffVars.len1 := len1;
  DiffVars.len2 := len2;
  fDiffList.Add(DiffVars);
end;
//------------------------------------------------------------------------------

function  TDiff.PopDiff: Boolean;
var
  DiffVars: PDiffVars;
  idx: Integer;
begin
  idx := fDiffList.Count -1;
  result := idx >= 0;
  if not result then Exit;
  DiffVars := PDiffVars(fDiffList[idx]);
  with DiffVars^ do
    if fCompareInts
      then DiffInt(offset1, offset2, len1, len2);
  Dispose(DiffVars);
  fDiffList.Delete(idx);
end;
//------------------------------------------------------------------------------

procedure TDiff.InitDiagArrays(len1, len2: Integer);
var
  i: Integer;
begin
  //assumes that top and bottom matches have been excluded
  P8Bits(DiagF) := P8Bits(DiagBufferF) - sizeof(Integer)*(MAX_DIAGONAL-(len1+1));
  for i := - (len1+1) to (len2+1) do DiagF[i] := -MAXINT;
  DiagF[1] := -1;

  P8Bits(DiagB) := P8Bits(DiagBufferB) - sizeof(Integer)*(MAX_DIAGONAL-(len1+1));
  for i := - (len1+1) to (len2+1) do DiagB[i] := MAXINT;
  DiagB[len2-len1+1] := len2;
end;
//------------------------------------------------------------------------------

procedure TDiff.DiffInt(offset1, offset2, len1, len2: Integer);
var
  p, k, delta: Integer;
begin
  //trim matching bottoms ...
  while (len1 > 0) and (len2 > 0) and (Ints1[offset1] = Ints2[offset2]) do
  begin
    Inc(offset1); Inc(offset2); Dec(len1); Dec(len2);
  end;
  //trim matching tops ...
  while (len1 > 0) and (len2 > 0) and
    (Ints1[offset1+len1-1] = Ints2[offset2+len2-1]) do
  begin
    Dec(len1); Dec(len2);
  end;

  //stop diff'ing if minimal conditions reached ...
  if (len1 = 0) then
  begin
    AddChangeInt(offset1 ,len2, ckAdd);
    Exit;
  end
  else if (len2 = 0) then
  begin
    AddChangeInt(offset1 ,len1, ckDelete);
    Exit;
  end
  else if (len1 = 1) and (len2 = 1) then
  begin
    AddChangeInt(offset1, 1, ckDelete);
    AddChangeInt(offset1, 1, ckAdd);
    Exit;
  end;

  p := -1;
  delta := len2 - len1;
  InitDiagArrays(len1, len2);
  if delta < 0 then
  begin
    repeat
      Inc(p);
      if (p mod 1024) = 1023 then
      begin
        Application.ProcessMessages;
        if fCancelled then Exit;
      end;
      //nb: the Snake order is important here
      for k := p downto delta +1 do
        if SnakeIntF(k,offset1,offset2,len1,len2) then Exit;
      for k := -p + delta to delta-1 do
        if SnakeIntF(k,offset1,offset2,len1,len2) then Exit;
      for k := delta -p to -1 do
        if SnakeIntB(k,offset1,offset2,len1,len2) then Exit;
      for k := p downto 1 do
        if SnakeIntB(k,offset1,offset2,len1,len2) then Exit;
      if SnakeIntF(delta,offset1,offset2,len1,len2) then Exit;
      if SnakeIntB(0,offset1,offset2,len1,len2) then Exit;
    until(False);
  end else
  begin
    repeat
      Inc(p);
      if (p mod 1024) = 1023 then
      begin
        Application.ProcessMessages;
        if fCancelled then Exit;
      end;
      //nb: the Snake order is important here
      for k := -p to delta -1 do
        if SnakeIntF(k,offset1,offset2,len1,len2) then Exit;
      for k := p + delta downto delta +1 do
        if SnakeIntF(k,offset1,offset2,len1,len2) then Exit;
      for k := delta + p downto 1 do
        if SnakeIntB(k,offset1,offset2,len1,len2) then Exit;
      for k := -p to -1 do
        if SnakeIntB(k,offset1,offset2,len1,len2) then Exit;
      if SnakeIntF(delta,offset1,offset2,len1,len2) then Exit;
      if SnakeIntB(0,offset1,offset2,len1,len2) then Exit;
    until(False);
  end;
end;
//------------------------------------------------------------------------------


function TDiff.SnakeIntF(k,offset1,offset2,len1,len2: Integer): Boolean;
var
  x,y: Integer;
begin
  if DiagF[k+1] > DiagF[k-1] then
    y := DiagF[k+1] else
    y := DiagF[k-1]+1;
  x := y - k;
  while (x < len1-1) and (y < len2-1) and
    (Ints1[offset1+x+1] = Ints2[offset2+y+1]) do
  begin
    Inc(x); Inc(y);
  end;
  DiagF[k] := y;
  result := (DiagF[k] >= DiagB[k]);
  if not result then Exit;

  Inc(x); Inc(y);
  PushDiff(offset1+x, offset2+y, len1-x, len2-y);
  PushDiff(offset1, offset2, x, y);
end;
//------------------------------------------------------------------------------

function TDiff.SnakeIntB(k,offset1,offset2,len1,len2: Integer): Boolean;
var
  x,y: Integer;
begin
  if DiagB[k-1] < DiagB[k+1] then
    y := DiagB[k-1] else
    y := DiagB[k+1]-1;
  x := y - k;
  while (x >= 0) and (y >= 0) and (Ints1[offset1+x] = Ints2[offset2+y]) do
  begin
    Dec(x); Dec(y);
  end;
  DiagB[k] := y;
  result := DiagB[k] <= DiagF[k];
  if not result then Exit;

  Inc(x); Inc(y);
  PushDiff(offset1+x, offset2+y, len1-x, len2-y);
  PushDiff(offset1, offset2, x, y);
end;
//------------------------------------------------------------------------------


procedure TDiff.AddChangeInt(offset1, range: Integer; ChangeKind: TChangeKind);
var
  i,j: Integer;
  compareRec: PCompareRec;
begin
  //first, add any unchanged items into this list ...
  while (fLastCompareRec.oldIndex1 < offset1 -1) do
  begin
    with fLastCompareRec do
    begin
      Kind := ckNone;
      Inc(oldIndex1);
      Inc(oldIndex2);
      int1 := Ints1[oldIndex1];
      int2 := Ints2[oldIndex2];
    end;
    New(compareRec);
    compareRec^ := fLastCompareRec;
    fCompareList.Add(compareRec);
    Inc(fDiffStats.matches);
  end;

  case ChangeKind of
    ckNone:
      for i := 1 to range do
      begin
        with fLastCompareRec do
        begin
          Kind := ckNone;
          Inc(oldIndex1);
          Inc(oldIndex2);
          int1 := Ints1[oldIndex1];
          int2 := Ints2[oldIndex2];
        end;
        New(compareRec);
        compareRec^ := fLastCompareRec;
        fCompareList.Add(compareRec);
        Inc(fDiffStats.matches);
      end;
    ckAdd :
      begin
        for i := 1 to range do
        begin
          with fLastCompareRec do
          begin

            //check if a range of adds are following a range of deletes
            //and convert them to modifies ...
            if Kind = ckDelete then
            begin
              j := fCompareList.Count -1;
              while (j > 0) and (PCompareRec(fCompareList[j-1]).Kind = ckDelete) do
                Dec(j);
              PCompareRec(fCompareList[j]).Kind := ckModify;
              Dec(fDiffStats.deletes);
              Inc(fDiffStats.modifies);
              Inc(fLastCompareRec.oldIndex2);
              PCompareRec(fCompareList[j]).oldIndex2 := fLastCompareRec.oldIndex2;
              PCompareRec(fCompareList[j]).int2 := Ints2[oldIndex2];
              if j = fCompareList.Count-1 then fLastCompareRec.Kind := ckModify;
              Continue;
            end;

            Kind := ckAdd;
            int1 := $0;
            Inc(oldIndex2);
            int2 := Ints2[oldIndex2]; //ie what we added
          end;
          New(compareRec);
          compareRec^ := fLastCompareRec;
          fCompareList.Add(compareRec);
          Inc(fDiffStats.adds);
        end;
      end;
    ckDelete :
      begin
        for i := 1 to range do
        begin
          with fLastCompareRec do
          begin

            //check if a range of deletes are following a range of adds
            //and convert them to modifies ...
            if Kind = ckAdd then
            begin
              j := fCompareList.Count -1;
              while (j > 0) and (PCompareRec(fCompareList[j-1]).Kind = ckAdd) do
                Dec(j);
              PCompareRec(fCompareList[j]).Kind := ckModify;
              Dec(fDiffStats.adds);
              Inc(fDiffStats.modifies);
              Inc(fLastCompareRec.oldIndex1);
              PCompareRec(fCompareList[j]).oldIndex1 := fLastCompareRec.oldIndex1;
              PCompareRec(fCompareList[j]).int1 := Ints1[oldIndex1];
              if j = fCompareList.Count-1 then fLastCompareRec.Kind := ckModify;
              Continue;
            end;

            Kind := ckDelete;
            int2 := $0;
            Inc(oldIndex1);
            int1 := Ints1[oldIndex1]; //ie what we deleted
          end;
          New(compareRec);
          compareRec^ := fLastCompareRec;
          fCompareList.Add(compareRec);
          Inc(fDiffStats.deletes);
        end;
      end;
  end;
end;
//------------------------------------------------------------------------------

procedure TDiff.Clear;
var
  i: Integer;
begin
  for i := 0 to fCompareList.Count-1 do
    dispose(PCompareRec(fCompareList[i]));
  fCompareList.clear;
  fLastCompareRec.Kind := ckNone;
  fLastCompareRec.oldIndex1 := -1;
  fLastCompareRec.oldIndex2 := -1;
  fDiffStats.matches := 0;
  fDiffStats.adds := 0;
  fDiffStats.deletes :=0;
  fDiffStats.modifies :=0;
  Ints1 := nil; Ints2 := nil;
end;
//------------------------------------------------------------------------------

function TDiff.GetCompareCount: Integer;
begin
  result := fCompareList.Count;
end;
//------------------------------------------------------------------------------

function TDiff.GetCompare(index: Integer): TCompareRec;
begin
  result := PCompareRec(fCompareList[index])^;
end;
//------------------------------------------------------------------------------

procedure TDiff.Cancel;
begin
  fCancelled := True;
end;
//------------------------------------------------------------------------------

end.
