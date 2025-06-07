{ -------------------------------------------------------------------------------
  Unit:     UTypes
  Author:   Gerhard Röhner
  Based on: NSD-Editor by Marcel Kalt
  Date:     August 2013
  Purpose:  elements of a structogram
  ------------------------------------------------------------------------------- }

unit UTypes;

interface

uses
  Windows,
  Classes,
  Graphics,
  ExtCtrls,
  Forms;

const
  LEFT_RIGHT = 10; { Default Left/Right margin of element }

var
  CF_NSDDATA: Word; { ClipBoard-Format }

type

  TStringListReader = class
  private
    FARect: TRect;
    FIndentAsInt: Integer;
    FKey: string;
    FKind: Byte;
    FNum: Integer;
    FPoint: TPoint;
    FStringList: TStringList;
    FText: string;
    FVal: string;
    destructor Destroy; override;
    function NextLineIndent: Integer;
    function GetKind(Kind: string): Byte;
  public
    constructor Create(Filename: string);
    procedure LineBack;
    procedure ReadLine;

    property ARect: TRect read FARect;
    property IndentAsInt: Integer read FIndentAsInt;
    property Key: string read FKey;
    property Kind: Byte read FKind;
    property Num: Integer read FNum;
    property Point: TPoint read FPoint;
    property StringList: TStringList read FStringList;
    property Text: string read FText;
    property Val: string read FVal;
  end;

  TStrType = (nsAlgorithm, nsStatement, nsIf, nsWhile, nsDoWhile, nsFor,
    nsSwitch, nsSubProgram, nsListHead, nsCase, nsBreak, nsList);

  TStrList = class;

  TStrElement = class
  private
    FKind: Byte;
    FList: TStrList;
    FNext: TStrElement;
    FPrev: TStrElement;
    FRct: TRect;
    FText: string;
    FTextPos: TPoint;
    procedure Draw; virtual;
    procedure DrawRightBottom; virtual;
    procedure DrawLeftBottom; virtual;
    procedure DrawCircle(XPos, YPos, Height: Integer);
    procedure DrawLines(XPos, YPos, LineHeight: Integer);
    procedure DrawLinesRight(XPos, YPos, LineHeight: Integer);
    procedure DrawCenteredLines(Center, YPos: Integer; Percent: Real);
    procedure DrawContent(XPos, YPos: Integer); virtual;
    procedure MoveRight(Width: Integer); virtual;
    procedure MoveRightList(Width: Integer); virtual;
    procedure MoveDown(Height: Integer); virtual;
    procedure MoveDownList(Height: Integer); virtual;
    procedure Resize(XPos, YPos: Integer); virtual;
    procedure SetRight(Right: Integer); virtual;
    procedure SetBottomList(Bottom: Integer); virtual;
    procedure SetBottom(Bottom: Integer); virtual;
    procedure LoadFromStream(Stream: TStream; Version: Byte); virtual;
    procedure LoadFromReader(Reader: TStringListReader); virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    function GetText(Indent: string): string; virtual;
    procedure RectToStream(Stream: TStream; Rect: TRect);
    function GetRectPosAsText(Indent: string; Rect: TRect;
      Point: TPoint): string;
    function RectFromStream(Stream: TStream): TRect;
    procedure IntegerToStream(Stream: TStream; Int: Integer);
    function IntegerFromStream(Stream: TStream): Integer;
    procedure StringToStream(Stream: TStream; const Str: string);
    function StringFromStream(Stream: TStream): string;
    function AppendToClipboard: string; virtual;
    procedure CreateFromClipboard(var ClipboardStr: string); virtual;
    procedure SetRctList(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer); virtual;
    procedure SetList(List: TStrList); virtual;
  public
    constructor Create(List: TStrList);
    function GetHeadHeight: Integer; virtual;
    procedure SetRct(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer);
    procedure ResizeList(XPos, YPos: Integer);
    procedure SetRightList(Right: Integer);
    function GetStatementFromKind(Kind: Byte; const List: TStrList;
      Parent: TStrElement): TStrElement;
    function GetStatementFromReader(Reader: TStringListReader;
      const List: TStrList; Parent: TStrElement): TStrElement;
    function GetLineHeight: Integer;
    function GetDefaultRectWidth: Integer;
    function GetLines: Integer;
    function AsString: string; virtual;
    function GetKind: string;
    function GetMaxDelta: Integer;
    procedure Debug; virtual;
    procedure Debug1;
    procedure Collapse; virtual;
    procedure CollapseCase; virtual;

    property Kind: Byte read FKind;
    property List: TStrList read FList;
    property Next: TStrElement read FNext write FNext;
    property Prev: TStrElement read FPrev write FPrev;
    property Rct: TRect read FRct write FRct;
    property Text: string read FText write FText;
    property TextPos: TPoint read FTextPos;
  end;

  TStrStatement = class(TStrElement)
    constructor Create(List: TStrList);
    destructor Destroy; override;
    function AsString: string; override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure Debug; override;
  end;

  TStrIf = class(TStrElement)
  private
    FElseElem: TStrElement;
    FThenElem: TStrElement;
    FPercent: Real; // then-width to else-width
    procedure Draw; override;
    procedure DrawContent(XPos, YPos: Integer); override;
    procedure MoveRight(Width: Integer); override;
    procedure MoveDown(Height: Integer); override;
    procedure Resize(XPos, YPos: Integer); override;
    procedure SetRight(Right: Integer); override;
    procedure SetBottom(Bottom: Integer); override;
    procedure LoadFromStream(Stream: TStream; Version: Byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function GetText(Indent: string): string; override;
    function AppendToClipboard: string; override;
    procedure CreateFromClipboard(var ClipboardStr: string); override;
    procedure SetTextPos;
    procedure SetList(List: TStrList); override;
  public
    constructor Create(List: TStrList);
    constructor CreateStructogram(List: TStrList; Dummy: Boolean = True);
    destructor Destroy; override;
    function GetHeadHeight: Integer; override;
    function AsString: string; override;
    procedure Debug; override;
    procedure Collapse; override;
    property ElseElem: TStrElement read FElseElem;
    property ThenElem: TStrElement read FThenElem;
  end;

  TStrWhile = class(TStrElement)
  private
    FDoElem: TStrElement;
    procedure Draw; override;
    procedure DrawContent(XPos, YPos: Integer); override;
    procedure MoveRight(Width: Integer); override;
    procedure MoveDown(Height: Integer); override;
    procedure Resize(XPos, YPos: Integer); override;
    procedure SetRight(Right: Integer); override;
    procedure SetBottom(Bottom: Integer); override;
    procedure LoadFromStream(Stream: TStream; Version: Byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function GetText(Indent: string): string; override;
    function AppendToClipboard: string; override;
    procedure CreateFromClipboard(var ClipboardStr: string); override;
    procedure SetList(List: TStrList); override;
  public
    constructor Create(List: TStrList);
    constructor CreateStructogram(List: TStrList; Dummy: Boolean = True);
    destructor Destroy; override;
    function GetHeadHeight: Integer; override;
    function AsString: string; override;
    procedure Debug; override;
    procedure Collapse; override;
    property DoElem: TStrElement read FDoElem;
  end;

  TStrDoWhile = class(TStrWhile)
  private
    procedure Draw; override;
    procedure DrawContent(XPos, YPos: Integer); override;
    procedure Resize(XPos, YPos: Integer); override;
  public
    constructor Create(List: TStrList);
    constructor CreateStructogram(List: TStrList; Dummy: Boolean = True);
    procedure SetBottom(Bottom: Integer); override;
    function GetHeadHeight: Integer; override;
    function AsString: string; override;
    procedure Debug; override;
  end;

  TStrFor = class(TStrWhile)
  public
    constructor Create(List: TStrList);
    constructor CreateStructogram(List: TStrList; Dummy: Boolean = True);
    function AsString: string; override;
    procedure Debug; override;
  end;

  TStrCase = class(TStrElement)
  private
    procedure Draw; override;
    procedure DrawRightBottom; override;
    procedure DrawLeftBottom; override;
  public
    constructor Create(List: TStrList);
    function AsString: string; override;
    procedure Debug; override;
  end;

  TCaseArray = array of TStrElement;

  TStrSwitch = class(TStrElement)
  private
    FCaseElems: TCaseArray;
    FPercent: Real; // then-width to else-width
    procedure Draw; override;
    procedure DrawContent(XPos, YPos: Integer); override;
    procedure MoveRight(Width: Integer); override;
    procedure MoveDown(Height: Integer); override;
    procedure Resize(XPos, YPos: Integer); override;
    procedure SetRight(Right: Integer); override;
    procedure SetBottom(Bottom: Integer); override;
    procedure LoadFromStream(Stream: TStream; Version: Byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function GetText(Indent: string): string; override;
    function AppendToClipboard: string; override;
    procedure CreateFromClipboard(var ClipboardStr: string); override;
    procedure SetTextPos;
    procedure SetList(List: TStrList); override;
    procedure AdjustCaseElems(Count: Integer);
  public
    constructor Create(List: TStrList);
    constructor CreateStructogram(List: TStrList; Dummy: Boolean = True);
    destructor Destroy; override;
    function GetHeadHeight: Integer; override;
    function AsString: string; override;
    procedure Debug; override;
    procedure Collapse; override;
    property CaseElems: TCaseArray read FCaseElems write FCaseElems;
  end;

  TStrSubprogram = class(TStrElement)
  private
    procedure Draw; override;
    procedure Resize(XPos, YPos: Integer); override;
    function GetText(Indent: string): string; override;
  public
    constructor Create(List: TStrList);
    function GetHeadHeight: Integer; override;
    function AsString: string; override;
    procedure Debug; override;
  end;

  TStrBreak = class(TStrElement)
  private
    procedure Draw; override;
    procedure Resize(XPos, YPos: Integer); override;
    function GetText(Indent: string): string; override;
  public
    constructor Create(List: TStrList);
    function GetHeadHeight: Integer; override;
    function AsString: string; override;
    procedure Debug; override;
  end;

  // head of a FList of statements as part of a statement, used in in If/While/Do/Switch...
  TStrListHead = class(TStrElement)
  private
    FParent: TStrElement;
    procedure SetRctList(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer); override;
    procedure SetList(List: TStrList); override;
  public
    constructor Create(List: TStrList; Parent: TStrElement);
    constructor CreateStructogram(List: TStrList; Parent: TStrElement;
      Dummy: Boolean = True);
    procedure Resize(XPos, YPos: Integer); override;
    destructor Destroy; override;
    function AsString: string; override;
    procedure Debug; override;
    procedure Collapse; override;
    procedure CollapseCase; override;
    property Parent: TStrElement read FParent;
  end;

  TListImage = class;

  // a whole structure without Algorithm
  TStrList = class(TStrElement)
  private
    FCanvas: TCanvas;
    FDirty: Boolean;
    FDontMove: Boolean;
    FLineHeight: Integer;
    FListImage: TListImage;
    FLoadError: Boolean;
    FPuzzleMode: Integer;
    FRctList: TRect;
    FSwitchWithCaseLine: Boolean;
    procedure PaintShadow;
    procedure Draw; override;
    procedure SetColors(BlackAndWhite: Boolean);
    procedure Resize(XPos, YPos: Integer); override;
    procedure SetRctList(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer); override;
  public
    constructor Create(ScrollBox: TScrollBox; Mode: Integer; Font: TFont);
    destructor Destroy; override;
    procedure Paint(BlackAndWhite: Boolean = False);
    procedure Print;
    procedure DrawTo(Canvas: TCanvas);
    procedure ResizeAll;
    procedure LoadFromStream(Stream: TStream; Version: Byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function GetText(Indent: string): string; override;
    function GetRectPos(Indent: string): string;
    procedure DeleteElem(Elem: TStrElement);
    procedure Insert(Position, Elem: TStrElement);
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure GetWidthHeigthOfText(const Text: string;
      var Width, Height: Integer);
    function GetWidthOfOneLine(const Text: string): Integer;
    function GetWidthOfLines(const Text: string): Integer;
    procedure SetLineHeight;
    function AsString: string; override;
    procedure Debug; override;
    procedure SetList(List: TStrList); override;
    procedure SetPuzzleMode(Mode: Integer);
    procedure SetFont(Font: TFont);
    procedure Collapse; override;

    property Canvas: TCanvas read FCanvas;
    property Dirty: Boolean read FDirty write FDirty;
    property DontMove: Boolean read FDontMove write FDontMove;
    property LineHeight: Integer read FLineHeight;
    property ListImage: TListImage read FListImage;
    property LoadError: Boolean read FLoadError;
    property PuzzleMode: Integer read FPuzzleMode;
    property RctList: TRect read FRctList write FRctList;
    property SwitchWithCaseLine: Boolean read FSwitchWithCaseLine
      write FSwitchWithCaseLine;
  end;

  // a whole structure, inherited form TStrList
  TStrAlgorithm = class(TStrList)
  private
    procedure Resize(XPos, YPos: Integer); override;
  public
    constructor Create(ScrollBox: TScrollBox; Mode: Integer; Font: TFont);
    function GetAlgorithmName: string;
    function AsString: string; override;
    procedure Debug; override;
  end;

  TListImage = class(TImage)
  private
    FStrList: TStrList;
  public
    // the constructor in TImage is not overload
    constructor Create(ScrollBox: TScrollBox; List: TStrList); reintroduce;
    property StrList: TStrList read FStrList;
  end;

implementation

uses
  SysUtils,
  Printers,
  Math,
  Themes,
  System.UITypes,
  System.Types,
  frmMessages,
  uCommonFunctions,
  UUtils,
  UConfiguration;

const
  DO_LEFT = 22; { Default Left margin of do-element }
  DO_BREAK = 15;
  DO_SUB = 16;
  SEP = #254; { Separator of commands }
  TERM = #255; { Terminator of commands }

  RECT_WIDTH = 75; { Minimal width of a rectangle }
  TOP_BOTTOM = 4; { Default top/bottom margin of element }

constructor TStringListReader.Create(Filename: string);
begin
  FStringList := TStringList.Create;
  FNum := 0;
  try
    FStringList.LoadFromFile(Filename);
  except
    on e: Exception do
      ErrorMsg(e.Message);
  end;
end;

function TStringListReader.NextLineIndent: Integer;
var
  Str: string;
  Posi: Integer;
begin
  if FNum < FStringList.Count - 1 then
  begin
    Str := FStringList[FNum + 1];
    Posi := 1;
    if Str <> '' then
      while Str[Posi] = ' ' do
        Inc(Posi);
    Result := Posi - 1;
  end
  else
    Result := 0;
end;

procedure TStringListReader.ReadLine;
var
  Line: string;
  Pos1, Pos2: Integer;

  function GetInt: Integer;
  begin
    var Pos1 := Pos(' ', FVal);
    if Pos1 > 1 then
    begin
      Result := StrToInt(Copy(FVal, 1, Pos1 - 1));
      Delete(FVal, 1, Pos1);
    end
    else
      Result := 0;
  end;

begin
  FKind := Ord(nsStatement);
  FText := '';
  FARect := Rect(0, 0, 0, 0);
  FPoint.X := 0;
  FPoint.Y := 0;
  Line := '';
  FIndentAsInt := 0;
  FKey := '';
  FVal := '';

  Inc(FNum);
  while (FNum < FStringList.Count) and (Trim(FStringList[FNum]) = '') do
    Inc(FNum);

  if FNum < FStringList.Count then
  begin
    Line := FStringList[FNum];
    Pos2 := 1;
    if Line <> '' then
      while Line[Pos2] = ' ' do
        Inc(Pos2);
    FIndentAsInt := Pos2 - 1;
    Line := UnHideCrLf(Trim(Line));
  end;

  Pos1 := Length(Line);
  while (Pos1 > 0) and (Line[Pos1] <> '|') do
    Dec(Pos1);
  if Pos1 > 0 then
  begin
    FVal := Copy(Line, Pos1 + 1, Length(Line)) + ' ';
    FARect.Left := GetInt;
    FARect.Top := GetInt;
    FARect.Right := GetInt;
    FARect.Bottom := GetInt;
    FPoint.X := GetInt;
    FPoint.Y := GetInt;
  end;

  FText := Copy(Line, 1, Pos1 - 1);
  if FText = '' then
  begin
    Pos2 := Pos(':', Line);
    if Pos2 > 0 then
    begin
      FKey := Copy(Line, 1, Pos2 - 1);
      FVal := Copy(Line, Pos2 + 2, Length(Line));
      if (FKey <> '') and (FVal = '') then
        FKind := GetKind(FKey);
    end;
  end
  else if FText[1] = '|' then
    Delete(FText, 1, 1);
end;

function TStringListReader.GetKind(Kind: string): Byte;
begin
  if Kind = 'Algorithm' then
    Result := Ord(nsAlgorithm)
  else if Kind = 'if' then
    Result := Ord(nsIf)
  else if Kind = 'while' then
    Result := Ord(nsWhile)
  else if Kind = 'do while' then
    Result := Ord(nsDoWhile)
  else if Kind = 'for' then
    Result := Ord(nsFor)
  else if Kind = 'switch' then
    Result := Ord(nsSwitch)
  else if Kind = 'subprogram' then
    Result := Ord(nsSubProgram)
  else if Kind = 'list head' then
    Result := Ord(nsListHead)
  else if Kind = 'case' then
    Result := Ord(nsCase)
  else if Kind = 'break' then
    Result := Ord(nsBreak)
  else if Kind = 'List' then
    Result := Ord(nsList)
  else
    Result := Ord(nsStatement);
end;

procedure TStringListReader.LineBack;
begin
  Dec(FNum);
end;

destructor TStringListReader.Destroy;
begin
  FreeAndNil(FStringList);
  inherited;
end;

(* ******************************************************************************* *)
(* ELEMENT *)
(* ******************************************************************************* *)

constructor TStrElement.Create(List: TStrList);
begin
  FKind := 0;
  FText := '';
  FNext := nil;
  FPrev := nil;
  Self.FList := List;
end;

procedure TStrElement.DrawCircle(XPos, YPos, Height: Integer);
begin
  with FList.Canvas do
  begin
    Ellipse(XPos - Height, YPos - Height, XPos + Height, YPos + Height);
    MoveTo(XPos - Height, YPos + Height);
    LineTo(XPos + Height, YPos - Height);
  end;
end;

procedure TStrElement.DrawLines(XPos, YPos, LineHeight: Integer);
var
  Str, Str1: string;
  Posi: Integer;
  BrushColor: TColor;
begin
  BrushColor := FList.Canvas.Brush.Color;
  FList.Canvas.Brush.Style := bsClear;
  Str := FText;
  Posi := Pos(#13#10, Str);
  while Posi > 0 do
  begin
    Str1 := Copy(Str, 1, Posi - 1);
    Delete(Str, 1, Posi + 1);
    FList.Canvas.TextOut(XPos, YPos, Str1);
    YPos := YPos + LineHeight;
    Posi := Pos(#13#10, Str);
  end;
  if Str <> '' then
    FList.Canvas.TextOut(XPos, YPos, Str);
  FList.Canvas.Brush.Style := bsSolid;
  FList.Canvas.Brush.Color := BrushColor;
end;

procedure TStrElement.DrawLinesRight(XPos, YPos, LineHeight: Integer);
var
  Str, Str1: string;
  Posi: Integer;
  BrushColor: TColor;
begin
  BrushColor := FList.Canvas.Brush.Color;
  FList.Canvas.Brush.Style := bsClear;
  Str := FText;
  Posi := Pos(#13#10, Str);
  while Posi > 0 do
  begin
    Str1 := Copy(Str, 1, Posi - 1);
    Delete(Str, 1, Posi + 1);
    XPos := FRct.Right - FList.Canvas.TextWidth(Str1) - LEFT_RIGHT div 2;
    FList.Canvas.TextOut(XPos, YPos, Str1);
    YPos := YPos + LineHeight;
    Posi := Pos(#13#10, Str);
  end;
  if Str <> '' then
  begin
    XPos := FRct.Right - FList.Canvas.TextWidth(Str) - LEFT_RIGHT div 2;
    FList.Canvas.TextOut(XPos, YPos, Str);
  end;
  FList.Canvas.Brush.Style := bsSolid;
  FList.Canvas.Brush.Color := BrushColor;
end;

procedure TStrElement.DrawCenteredLines(Center, YPos: Integer; Percent: Real);
var
  Str, Str1: string;
  XPos, Width, Posi: Integer;
  BrushColor: TColor;
begin
  FList.Canvas.Rectangle(FRct.Left, FRct.Top, FRct.Right + 1, FRct.Bottom + 1);
  BrushColor := FList.Canvas.Brush.Color;
  FList.Canvas.Brush.Style := bsClear;
  Str := FText;
  YPos := FTextPos.Y;
  Posi := Pos(#13#10, Str);
  while Posi > 0 do
  begin
    Str1 := Copy(Str, 1, Posi - 1);
    Delete(Str, 1, Posi + 1);
    Width := Round(Percent * FList.GetWidthOfOneLine(Str1));
    XPos := Center - Width;
    FList.Canvas.TextOut(XPos, YPos, Str1);
    YPos := YPos + FList.LineHeight;
    Posi := Pos(#13#10, Str);
  end;
  if Str <> '' then
  begin
    Width := Round(Percent * FList.GetWidthOfOneLine(Str));
    XPos := Center - Width;
    FList.Canvas.TextOut(XPos, YPos, Str);
  end;
  FList.Canvas.Brush.Style := bsSolid;
  FList.Canvas.Brush.Color := BrushColor;
end;

procedure TStrElement.DrawContent(XPos, YPos: Integer);
begin
  if FText = '' then
  begin
    XPos := (FRct.Left + FRct.Right + 1) div 2;
    YPos := (FRct.Top + FRct.Bottom + 1) div 2;
    DrawCircle(XPos, YPos, (GetLineHeight - 10) div 2);
  end
  else
    DrawLines(XPos, YPos, FList.LineHeight);
end;

procedure TStrElement.Draw;
begin
  FList.Canvas.Rectangle(FRct.Left, FRct.Top, FRct.Right + 1, FRct.Bottom + 1);
  DrawContent(FTextPos.X, FTextPos.Y);
end;

procedure TStrElement.DrawRightBottom;
begin
end;

procedure TStrElement.DrawLeftBottom;
begin
end;

procedure TStrElement.MoveRight(Width: Integer);
begin
  FRct.Left := FRct.Left + Width;
  FRct.Right := FRct.Right + Width;
  FTextPos.X := FTextPos.X + Width;
end;

procedure TStrElement.MoveDown(Height: Integer);
begin
  FRct.Top := FRct.Top + Height;
  FRct.Bottom := FRct.Bottom + Height;
  FTextPos.Y := FTextPos.Y + Height;
end;

procedure TStrElement.MoveRightList(Width: Integer);
begin
  MoveRight(Width);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.MoveRight(Width);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrElement.MoveDownList(Height: Integer);
begin
  MoveDown(Height);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.MoveDown(Height);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrElement.Resize(XPos, YPos: Integer);
var
  Width, Height: Integer;
begin
  FList.GetWidthHeigthOfText(FText, Width, Height);
  if FList.PuzzleMode = 1 then
    SetRct(XPos, YPos, XPos + FRct.Right - FRct.Left,
      YPos + FRct.Bottom - FRct.Top)
  else if FList.PuzzleMode = 2 then
    SetRct(XPos, YPos, XPos + FRct.Right - FRct.Left, YPos + Height)
  else
    SetRct(XPos, YPos, XPos + Width, YPos + Height);
end;

procedure TStrElement.SetRight(Right: Integer);
begin
  FRct.Right := Right;
end;

procedure TStrElement.SetBottomList(Bottom: Integer);
begin
  SetBottom(Bottom);
  var
  Tmp := FNext;
  if Assigned(Tmp) then
  begin
    while Assigned(Tmp.FNext) do
      Tmp := Tmp.FNext;
    Tmp.SetBottom(Bottom);
  end;
end;

procedure TStrElement.SetBottom(Bottom: Integer);
begin
  FRct.Bottom := Bottom;
end;

procedure TStrElement.ResizeList(XPos, YPos: Integer);
var
  X1Pos, Y1Pos: Integer;
  Tmp: TStrElement;
  Kind: Byte;
begin
  // calculate width
  Resize(XPos, YPos); // Listhead  or StrList
  Kind := Ord(nsAlgorithm);
  if FKind = Kind then
    X1Pos := GetDefaultRectWidth + FList.Canvas.Font.Size + 2 * LEFT_RIGHT
  else
    X1Pos := Self.FRct.Right;
  Y1Pos := Self.FRct.Bottom;
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.Resize(XPos, Y1Pos);
    X1Pos := Max(X1Pos, Tmp.FRct.Right);
    Y1Pos := Tmp.FRct.Bottom;
    Tmp := Tmp.FNext;
  end;
  // set width
  SetRightList(X1Pos);
  SetRctList(XPos, YPos, X1Pos, Y1Pos);
end;

procedure TStrElement.SetRightList(Right: Integer);
begin
  SetRight(Right);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.SetRight(Right);
    Tmp := Tmp.FNext;
  end;
  FRct.Right := Right;
end;

function TStrElement.GetLineHeight: Integer;
begin
  Result := FList.LineHeight;
end;

function TStrElement.GetDefaultRectWidth: Integer;
begin
  Result := Round(RECT_WIDTH * (FList.Canvas.Font.Size / 12.0));
end;

function TStrElement.GetLines: Integer;
var
  Posi, Num: Integer;
  Str: string;
begin
  Num := 0;
  Str := FText;
  Posi := Pos(#13#10, Str);
  while Posi > 0 do
  begin
    Delete(Str, 1, Posi + 1);
    Inc(Num);
    Posi := Pos(#13#10, Str);
  end;
  if Str <> '' then
    Inc(Num);
  if Num = 0 then
    Num := 1;
  Result := Num;
end;

function TStrElement.GetHeadHeight: Integer;
begin
  Result := GetLineHeight;
end;

procedure TStrElement.LoadFromStream(Stream: TStream; Version: Byte);
var
  Bye: Byte;
  Str: ShortString;
begin
  if Version >= $0E then
  begin
    FText := StringFromStream(Stream);
    FRct := RectFromStream(Stream);
    FTextPos.X := IntegerFromStream(Stream);
    FTextPos.Y := IntegerFromStream(Stream);
  end
  else
  begin
    Stream.Read(Bye, 1);
    SetLength(Str, Bye);
    Stream.Read(Str[1], Bye);
    FText := string(Str);
  end;
end;

procedure TStrElement.LoadFromReader(Reader: TStringListReader);
begin
  Reader.ReadLine;
  FText := Reader.FText;
  FRct := Reader.FARect;
  FTextPos := Reader.FPoint;
end;

procedure TStrElement.SaveToStream(Stream: TStream);
begin
  Stream.Write(FKind, 1);
  StringToStream(Stream, FText);
  RectToStream(Stream, FRct);
  IntegerToStream(Stream, FTextPos.X);
  IntegerToStream(Stream, FTextPos.Y);
end;

function TStrElement.GetText(Indent: string): string;
begin
  var
  Str := HideCrLf(FText);
  if (Str <> '') and (Str[1] = ' ') then
    Str := '|' + Str;
  Result := Indent + Str + GetRectPosAsText(Indent, FRct, FTextPos) + CrLf;
end;

procedure TStrElement.RectToStream(Stream: TStream; Rect: TRect);
begin
  IntegerToStream(Stream, Rect.Left);
  IntegerToStream(Stream, Rect.Top);
  IntegerToStream(Stream, Rect.Right);
  IntegerToStream(Stream, Rect.Bottom);
end;

function TStrElement.GetRectPosAsText(Indent: string; Rect: TRect;
  Point: TPoint): string;
begin
  Result := '|' + IntToStr(Rect.Left) + ' ' + IntToStr(Rect.Top) + ' ' +
    IntToStr(Rect.Right) + ' ' + IntToStr(Rect.Bottom) + ' ' + IntToStr(Point.X)
    + ' ' + IntToStr(Point.Y);
end;

function TStrElement.RectFromStream(Stream: TStream): TRect;
begin
  Result.Left := IntegerFromStream(Stream);
  Result.Top := IntegerFromStream(Stream);
  Result.Right := IntegerFromStream(Stream);
  Result.Bottom := IntegerFromStream(Stream);
end;

procedure TStrElement.IntegerToStream(Stream: TStream; Int: Integer);
var
  Small: SmallInt;
begin
  Small := SmallInt(Int);
  Stream.Write(Small, 2);
end;

function TStrElement.IntegerFromStream(Stream: TStream): Integer;
begin
  Result := 0;
  Stream.Read(Result, 2);
end;

procedure TStrElement.StringToStream(Stream: TStream; const Str: string);
var
  Size: LongInt;
begin
  Size := Length(Str) * SizeOf(Char);
  Stream.Write(Size, SizeOf(Size));
  Stream.Write(Pointer(Str)^, Size);
end;

function TStrElement.StringFromStream(Stream: TStream): string;
var
  Size: LongInt;
begin
  Stream.Read(Size, SizeOf(Size));
  SetLength(Result, Size div SizeOf(Char));
  Stream.Read(Pointer(Result)^, Size);
end;

function TStrElement.AppendToClipboard: string;
begin
  Result := Chr(FKind) + FText + SEP;
end;

procedure TStrElement.CreateFromClipboard(var ClipboardStr: string);
var
  Index: Byte;
begin
  Index := Pos(SEP, ClipboardStr);
  FText := Copy(ClipboardStr, 2, Index - 2);
  Delete(ClipboardStr, 1, Index);
end;

procedure TStrElement.SetRct(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer);
begin
  FRct.Left := X1Pos;
  FRct.Top := Y1Pos;
  FRct.Right := X2Pos;
  FRct.Bottom := Y2Pos;
  FTextPos.X := FRct.Left + LEFT_RIGHT div 2;
  FTextPos.Y := FRct.Top + TOP_BOTTOM div 2;
end;

procedure TStrElement.SetRctList(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer);
begin
end;

procedure TStrElement.SetList(List: TStrList);
begin
  Self.FList := List;
end;

function TStrElement.GetStatementFromKind(Kind: Byte; const List: TStrList;
  Parent: TStrElement): TStrElement;
begin
  case Kind of
    Ord(nsAlgorithm):
      Result := nil;
    Ord(nsStatement):
      Result := TStrStatement.Create(List);
    Ord(nsIf):
      Result := TStrIf.Create(List);
    Ord(nsWhile):
      Result := TStrWhile.Create(List);
    Ord(nsDoWhile):
      Result := TStrDoWhile.Create(List);
    Ord(nsFor):
      Result := TStrFor.Create(List);
    Ord(nsSwitch):
      Result := TStrSwitch.Create(List);
    Ord(nsSubProgram):
      Result := TStrSubprogram.Create(List);
    Ord(nsListHead):
      Result := TStrListHead.Create(List, Parent);
    Ord(nsCase):
      Result := nil;
    Ord(nsBreak):
      Result := TStrBreak.Create(List);
  else
    Result := nil;
  end;
  if not Assigned(Result) then
    FList.FLoadError := True;
end;

function TStrElement.GetStatementFromReader(Reader: TStringListReader;
  const List: TStrList; Parent: TStrElement): TStrElement;
begin
  case Reader.Kind of
    Ord(nsStatement):
      Result := TStrStatement.Create(List);
    Ord(nsIf):
      Result := TStrIf.Create(List);
    Ord(nsWhile):
      Result := TStrWhile.Create(List);
    Ord(nsDoWhile):
      Result := TStrDoWhile.Create(List);
    Ord(nsFor):
      Result := TStrFor.Create(List);
    Ord(nsSwitch):
      Result := TStrSwitch.Create(List);
    Ord(nsSubProgram):
      Result := TStrSubprogram.Create(List);
    Ord(nsListHead):
      Result := TStrListHead.Create(List, Parent);
    Ord(nsBreak):
      Result := TStrBreak.Create(List);
  else
    Result := TStrStatement.Create(List);
  end;
end;

function TStrElement.AsString: string;
begin
  Result := FText;
end;

function TStrElement.GetKind: string;
begin
  case FKind of
    Ord(nsAlgorithm):
      Result := 'Algorithm';
    Ord(nsStatement):
      Result := 'Statement';
    Ord(nsIf):
      Result := 'if';
    Ord(nsWhile):
      Result := 'while';
    Ord(nsDoWhile):
      Result := 'do while';
    Ord(nsFor):
      Result := 'for';
    Ord(nsSwitch):
      Result := 'switch';
    Ord(nsSubProgram):
      Result := 'subprogram';
    Ord(nsListHead):
      Result := 'list head';
    Ord(nsCase):
      Result := 'case';
    Ord(nsBreak):
      Result := 'break';
  else
    Result := 'List';
  end;
end;

function TStrElement.GetMaxDelta: Integer;
begin
  Result := Min((FRct.Bottom - FRct.Top) div 2, GetHeadHeight);
end;

procedure TStrElement.Debug;
var
  Str: string;
begin
  Str := 'StrElement Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
end;

procedure TStrElement.Debug1;
var
  Str: string;
begin
  Str := 'StrElement Kind = ' + IntToStr(FKind) + ' Text= ' + FText;
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
end;

procedure TStrElement.Collapse;
begin
end;

procedure TStrElement.CollapseCase;
begin
end;

(* ******************************************************************************* *)
(* Statement *)
(* ******************************************************************************* *)

constructor TStrStatement.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsStatement);
end;

destructor TStrStatement.Destroy;
begin
  inherited;
end;

function TStrStatement.AsString: string;
begin
  Result := FText;
end;

procedure TStrStatement.Debug;
var
  Str: string;
begin
  Str := 'StrStatement Kind=' + IntToStr(FKind) + ' Text=' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
end;

procedure TStrStatement.LoadFromReader(Reader: TStringListReader);
begin
  FText := Reader.FText;
  FRct := Reader.FARect;
  FTextPos := Reader.FPoint;
end;

(* ******************************************************************************* *)
(* IF *)
(* ******************************************************************************* *)

constructor TStrIf.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsIf);
  FThenElem := TStrListHead.Create(List, Self);
  FThenElem.FText := 'then list head';
  FElseElem := TStrListHead.Create(List, Self);
  FElseElem.FText := 'else list head';
end;

constructor TStrIf.CreateStructogram(List: TStrList; Dummy: Boolean = True);
begin
  inherited Create(List);
  FKind := Ord(nsIf);
  FThenElem := TStrListHead.CreateStructogram(List, Self);
  FThenElem.FText := 'then list head';
  FElseElem := TStrListHead.CreateStructogram(List, Self);
  FElseElem.FText := 'else list head';
end;

destructor TStrIf.Destroy;
begin
  inherited;
  FreeAndNil(FThenElem);
  FreeAndNil(FElseElem);
end;

procedure TStrIf.Draw;
var
  Tmp: TStrElement;
  UHeight, Height, Width: Integer;
  BrushColor: TColor;
begin
  with FList.Canvas do
  begin
    if FText = '' then
      inherited Draw
    else
      DrawCenteredLines(FThenElem.FRct.Right, FTextPos.Y, FPercent);
    UHeight := FThenElem.FRct.Top - FRct.Top;
    MoveTo(FRct.Left, FRct.Top + 1);
    LineTo(FThenElem.FRct.Right - 1, FRct.Top + UHeight);
    MoveTo(FRct.Right, FRct.Top + 1);
    LineTo(FElseElem.FRct.Left + 1, FRct.Top + UHeight);

    MoveTo(FRct.Left, FRct.Top + UHeight);
    LineTo(FRct.Right, FRct.Top + UHeight);
    MoveTo(FThenElem.FRct.Right, FRct.Top + UHeight + 1);
    LineTo(FThenElem.FRct.Right, FRct.Bottom);

    Font.Size := Font.Size - 2;
    BrushColor := Brush.Color;
    Brush.Style := bsClear;
    Height := FThenElem.FRct.Top - GetLineHeight + TOP_BOTTOM;
    Width := TextWidth(GuiPyLanguageOptions.No);
    TextOut(FRct.Left + 4, Height + 6, GuiPyLanguageOptions.Yes);
    TextOut(FRct.Right - Width - 2, Height + 6, GuiPyLanguageOptions.No);
    Brush.Style := bsSolid;
    Brush.Color := BrushColor;
    Font.Size := Font.Size + 2;

    Tmp := FThenElem.FNext;
    while Assigned(Tmp) do
    begin
      Tmp.Draw;
      Tmp := Tmp.FNext;
    end;

    Tmp := FElseElem.FNext;
    while Assigned(Tmp) do
    begin
      Tmp.Draw;
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrIf.DrawContent(XPos, YPos: Integer);
var
  Height: Integer;
begin
  with FList.Canvas do
    if FText = '' then
    begin
      Height := GetLineHeight;
      YPos := FRct.Top + Height div 2;
      Height := (Height - 10) div 2;
      XPos := FThenElem.FRct.Right;
      DrawCircle(XPos, YPos, Height);
    end
    else
      DrawLines(XPos, YPos, FList.LineHeight);
end;

procedure TStrIf.MoveRight(Width: Integer);
begin
  inherited MoveRight(Width); { move IF-rectangle and condition-FText }
  var
  Tmp := FThenElem;
  while Assigned(Tmp) do
  begin { move all THEN-elements }
    Tmp.MoveRight(Width);
    Tmp := Tmp.FNext;
  end;
  Tmp := FElseElem;
  while Assigned(Tmp) do
  begin { move all ELSE-elements }
    Tmp.MoveRight(Width);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrIf.MoveDown(Height: Integer);
begin
  inherited MoveDown(Height); { move IF-rectangle and condition-FText }
  var
  Tmp := FThenElem;
  while Assigned(Tmp) do
  begin { move all THEN-elements }
    Tmp.MoveDown(Height);
    Tmp := Tmp.FNext;
  end;
  Tmp := FElseElem;
  while Assigned(Tmp) do
  begin { move all ELSE-elements }
    Tmp.MoveDown(Height);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrIf.Resize(XPos, YPos: Integer);
var
  Bottom, Width, Delta, Height, WCondition, WidthB: Integer;
begin
  FThenElem.ResizeList(XPos, YPos);
  FElseElem.ResizeList(XPos, YPos);

  FList.GetWidthHeigthOfText(FText, WCondition, Height);
  // width of "if" is at least 1.5* witdh of condition
  WidthB := Max(FThenElem.FRct.Right - FThenElem.FRct.Left + FElseElem.FRct.Right -
    FElseElem.FRct.Left, WCondition);
  if WidthB <= 1.5 * WCondition then
    WidthB := Round(1.5 * WCondition);
  Width := Max(WidthB, GetDefaultRectWidth);

  SetRct(XPos, YPos, XPos + Width, YPos + Height);
  FThenElem.ResizeList(XPos, YPos + Height);
  FElseElem.ResizeList(FThenElem.FRct.Right, YPos + Height);
  Bottom := Max(FThenElem.FRct.Bottom, FElseElem.FRct.Bottom);
  if Bottom > FThenElem.FRct.Bottom then
    FThenElem.SetBottomList(Bottom);
  if Bottom > FElseElem.FRct.Bottom then
    FElseElem.SetBottomList(Bottom);
  SetRct(XPos, YPos, FElseElem.FRct.Right, Bottom);

  // 1.5*condition_width > FRct.width ?
  Delta := WidthB - (FRct.Right - FRct.Left);
  if Delta > 0 then
    SetRight(FRct.Right + Delta);
  SetTextPos;
end;

procedure TStrIf.SetRight(Right: Integer);
var
  DeltaR: Integer;
begin
  DeltaR := (Right - FRct.Right) div 2;
  FThenElem.SetRightList(FThenElem.FRct.Right + DeltaR);
  FElseElem.MoveRightList(DeltaR);
  FElseElem.SetRightList(Right);
  FRct.Right := Right;
  SetTextPos;
end;

procedure TStrIf.SetBottom(Bottom: Integer);
begin
  inherited SetBottom(Bottom);
  FThenElem.SetBottomList(Bottom);
  FElseElem.SetBottomList(Bottom);
end;

function TStrIf.GetHeadHeight: Integer;
begin
  Result := FThenElem.FRct.Top - FRct.Top;
end;

procedure TStrIf.SetTextPos;
var
  Width, Height: Integer;
  DThen, DIf: Real;
begin
  DThen := FThenElem.FRct.Right - FThenElem.FRct.Left;
  DIf := FRct.Right - FRct.Left;
  if DIf = 0 then
    FPercent := DThen
  else
    FPercent := DThen / DIf;
  FList.GetWidthHeigthOfText(FText, Width, Height);
  Width := Round(FPercent * Width);
  FTextPos.X := FThenElem.FRct.Right - Width;
  FTextPos.Y := FRct.Top;
end;

procedure TStrIf.SetList(List: TStrList);
begin
  inherited;
  FThenElem.SetList(List);
  FElseElem.SetList(List);
end;

procedure TStrIf.LoadFromStream(Stream: TStream; Version: Byte);
var
  Current, Elem: TStrElement;
  AKind, Count: Byte;
begin
  inherited LoadFromStream(Stream, Version);
  FreeAndNil(FNext); { necessary for corrupted files ! }
  Stream.Read(AKind, 1); { overread Kind }
  FThenElem.LoadFromStream(Stream, Version);
  FreeAndNil(FThenElem.FNext);
  Current := FThenElem;
  Count := Stream.Read(AKind, 1);
  while (Count = 1) and (AKind <> $FF) do
  begin
    Elem := GetStatementFromKind(AKind, FList, Self);
    if not Assigned(Elem) then
      Exit;
    Elem.LoadFromStream(Stream, Version);
    FreeAndNil(Elem.FNext);
    FList.Insert(Current, Elem);
    Current := Elem;
    Count := Stream.Read(AKind, 1);
  end;
  if Count = 1 then
  begin
    Stream.Read(AKind, 1); { overread kind }
    FElseElem.LoadFromStream(Stream, Version);
    FreeAndNil(FElseElem.FNext);
    Current := FElseElem;
    Count := Stream.Read(AKind, 1);
    while (Count = 1) and (Kind <> $FF) do
    begin
      Elem := GetStatementFromKind(AKind, FList, Self);
      if not Assigned(Elem) then
        Exit;
      Elem.LoadFromStream(Stream, Version);
      FreeAndNil(Elem.FNext);
      FList.Insert(Current, Elem);
      Current := Elem;
      Count := Stream.Read(AKind, 1);
    end;
  end;
end;

procedure TStrIf.LoadFromReader(Reader: TStringListReader);
var
  Current, Elem: TStrElement;
  MyIndent: Integer;
begin
  inherited LoadFromReader(Reader); // condition
  MyIndent := Reader.FIndentAsInt;
  FThenElem.LoadFromReader(Reader);
  FreeAndNil(FThenElem.FNext); // don't use empty statement
  Current := FThenElem;
  while Reader.NextLineIndent = MyIndent do
  begin
    Reader.ReadLine;
    Elem := GetStatementFromReader(Reader, FList, Self);
    Elem.LoadFromReader(Reader);
    FList.Insert(Current, Elem);
    Current := Elem;
  end;
  Reader.ReadLine;
  FElseElem.LoadFromReader(Reader);
  FreeAndNil(FElseElem.FNext); // don't use empty statement
  Current := FElseElem;
  while Reader.NextLineIndent = MyIndent do
  begin
    Reader.ReadLine;
    Elem := GetStatementFromReader(Reader, FList, Self);
    Elem.LoadFromReader(Reader);
    FList.Insert(Current, Elem);
    Current := Elem;
  end;
end;

procedure TStrIf.SaveToStream(Stream: TStream);
var
  Tmp: TStrElement;
  Tag: Byte;
begin
  inherited SaveToStream(Stream);
  Tmp := FThenElem;
  while Assigned(Tmp) do
  begin
    Tmp.SaveToStream(Stream);
    Tmp := Tmp.FNext;
  end;
  Tag := $FF;
  Stream.Write(Tag, 1); { write end Tag }
  Tmp := FElseElem;
  while Assigned(Tmp) do
  begin
    Tmp.SaveToStream(Stream);
    Tmp := Tmp.FNext;
  end;
  Tag := $FF;
  Stream.Write(Tag, 1); { write end Tag }
end;

function TStrIf.GetText(Indent: string): string;
begin
  Result := Indent + 'if: ' + CrLf + inherited GetText(Indent + '  ');
  var
  Tmp := FThenElem;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.GetText(Indent + '  ');
    Tmp := Tmp.FNext;
  end;
  Result := Result + Indent + 'else:' + CrLf;
  Tmp := FElseElem;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.GetText(Indent + '  ');
    Tmp := Tmp.FNext;
  end;
end;

function TStrIf.AppendToClipboard: string;
begin
  Result := inherited AppendToClipboard;
  var
  Tmp := FThenElem;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.AppendToClipboard;
    Tmp := Tmp.FNext;
  end;
  Result := Result + TERM + SEP;
  Tmp := FElseElem;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.AppendToClipboard;
    Tmp := Tmp.FNext;
  end;
  Result := Result + TERM + SEP;
end;

procedure TStrIf.CreateFromClipboard(var ClipboardStr: string);
var
  Elem, Tmp: TStrElement;
  AKind, Index: Byte;
begin
  inherited CreateFromClipboard(ClipboardStr);

  Tmp := nil;
  AKind := Ord(ClipboardStr[1]);
  while AKind <> $FF do
  begin
    Elem := GetStatementFromKind(AKind, FList, Self);
    if not Assigned(Elem) then
      Exit;
    Elem.CreateFromClipboard(ClipboardStr);
    if not Assigned(Tmp) then
      FThenElem := Elem
    else
    begin
      Tmp.FNext := Elem;
      Elem.FPrev := Tmp;
    end;
    Tmp := Elem;
    AKind := Ord(ClipboardStr[1]);
  end;
  Index := Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, Index);

  Tmp := nil;
  AKind := Ord(ClipboardStr[1]);
  while AKind <> $FF do
  begin
    Elem := GetStatementFromKind(AKind, FList, Self);
    if not Assigned(Elem) then
      Exit;
    Elem.CreateFromClipboard(ClipboardStr);
    if not Assigned(Tmp) then
      FElseElem := Elem
    else
    begin
      Tmp.FNext := Elem;
      Elem.FPrev := Tmp;
    end;
    Tmp := Elem;
    AKind := Ord(ClipboardStr[1]);
  end;
  Index := Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, Index);
end;

function TStrIf.AsString: string;
begin
  Result := 'If(' + FText + ',' + FThenElem.AsString + ',' +
    FElseElem.AsString + ')';
end;

procedure TStrIf.Debug;
var
  Str: string;
begin
  Str := 'TStrIf Kind=' + IntToStr(FKind) + ' Text=' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  MessagesWindow.AddMessage('THEN');
  FThenElem.Debug;
  MessagesWindow.AddMessage('ELSE');
  FElseElem.Debug;
  MessagesWindow.AddMessage('IF END');
end;

procedure TStrIf.Collapse;
begin
  FThenElem.Collapse;
  FElseElem.Collapse;
end;

(* ******************************************************************************* *)
(* WHILE *)
(* ******************************************************************************* *)

constructor TStrWhile.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsWhile);
  FDoElem := TStrListHead.Create(List, Self);
  FDoElem.FText := 'while head';
end;

constructor TStrWhile.CreateStructogram(List: TStrList; Dummy: Boolean = True);
begin
  inherited Create(List);
  FKind := Ord(nsWhile);
  FDoElem := TStrListHead.CreateStructogram(List, Self);
  FDoElem.FText := 'while head';
end;

destructor TStrWhile.Destroy;
begin
  FreeAndNil(FDoElem);
  inherited;
end;

procedure TStrWhile.Draw;
begin
  with FList.Canvas do
  begin
    inherited Draw; { draw WHILE-rectangle and condition-FText }
    MoveTo(FDoElem.FRct.Right, FDoElem.FRct.Top);
    LineTo(FDoElem.FRct.Left, FDoElem.FRct.Top);
    LineTo(FDoElem.FRct.Left, FRct.Bottom);
    var
    Tmp := FDoElem.FNext;
    while Assigned(Tmp) do
    begin
      Tmp.Draw;
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrWhile.DrawContent(XPos, YPos: Integer);
begin
  if FText = '' then
  begin
    XPos := (FRct.Left + FRct.Right + 1) div 2;
    YPos := (FRct.Top + FDoElem.FRct.Top + 1) div 2;
    DrawCircle(XPos, YPos, (GetLineHeight - 10) div 2);
  end
  else
    DrawLines(XPos, YPos, GetLineHeight);
end;

procedure TStrWhile.MoveRight(Width: Integer);
begin
  inherited MoveRight(Width); { move WHILE-rectangle and condition-FText }
  var
  Tmp := FDoElem;
  while Assigned(Tmp) do
  begin { move all WHILE-elements }
    Tmp.MoveRight(Width);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrWhile.MoveDown(Height: Integer);
begin
  inherited MoveDown(Height); { move WHILE-rectangle and condition-FText }
  var
  Tmp := FDoElem;
  while Assigned(Tmp) do
  begin { move all WHILE-elements }
    Tmp.MoveDown(Height);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrWhile.Resize(XPos, YPos: Integer);
var
  Width: Integer;
begin
  inherited Resize(XPos, YPos);
  FDoElem.ResizeList(XPos + DO_LEFT, YPos + GetLines * FList.LineHeight);
  Width := Max(Self.FRct.Right, FDoElem.FRct.Right);
  SetRct(XPos, YPos, Width, FDoElem.FRct.Bottom);
  FDoElem.SetRightList(FRct.Right);
end;

procedure TStrWhile.SetRight(Right: Integer);
begin
  FRct.Right := Right;
  FDoElem.SetRightList(Right);
end;

procedure TStrWhile.SetBottom(Bottom: Integer);
begin
  inherited SetBottom(Bottom);
  FDoElem.SetBottomList(Bottom);
end;

function TStrWhile.GetHeadHeight: Integer;
begin
  Result := FDoElem.FRct.Top - FRct.Top;
end;

procedure TStrWhile.LoadFromStream(Stream: TStream; Version: Byte);
var
  Current, Elem: TStrElement;
  AKind, Count: Byte;
begin
  inherited LoadFromStream(Stream, Version);
  FreeAndNil(FNext); { necessary for corrupted files ! }
  Stream.Read(AKind, 1); { overread AKind }
  FDoElem.LoadFromStream(Stream, Version);
  FreeAndNil(FDoElem.FNext); { necessary for corrupted files ! }
  Current := FDoElem;
  Count := Stream.Read(AKind, 1);
  while (Count = 1) and (AKind <> $FF) do
  begin
    Elem := GetStatementFromKind(AKind, FList, Self);
    if not Assigned(Elem) then
      Exit;
    Elem.LoadFromStream(Stream, Version);
    FreeAndNil(Elem.FNext);
    FList.Insert(Current, Elem);
    Current := Elem;
    Count := Stream.Read(AKind, 1);
  end;
end;

procedure TStrWhile.LoadFromReader(Reader: TStringListReader);
var
  Current, Elem: TStrElement;
  MyIndent: Integer;
begin
  inherited LoadFromReader(Reader);
  FDoElem.LoadFromReader(Reader);
  FreeAndNil(FDoElem.FNext); // don't use empty statement
  Current := FDoElem;
  MyIndent := Reader.FIndentAsInt;
  while Reader.NextLineIndent = MyIndent do
  begin
    Reader.ReadLine;
    Elem := GetStatementFromReader(Reader, FList, Self);
    Elem.LoadFromReader(Reader);
    FList.Insert(Current, Elem);
    Current := Elem;
  end;
end;

procedure TStrWhile.SaveToStream(Stream: TStream);
var
  Tmp: TStrElement;
  Tag: Byte;
begin
  inherited SaveToStream(Stream);
  Tmp := FDoElem;
  while Assigned(Tmp) do
  begin
    Tmp.SaveToStream(Stream);
    Tmp := Tmp.FNext;
  end;
  Tag := $FF;
  Stream.Write(Tag, 1); { write end Tag }
end;

function TStrWhile.GetText(Indent: string): string;
begin
  Result := Indent + GetKind + ': ' + CrLf + inherited GetText(Indent + '  ');
  var
  Tmp := FDoElem;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.GetText(Indent + '  ');
    Tmp := Tmp.FNext;
  end;
end;

function TStrWhile.AppendToClipboard: string;
begin
  Result := inherited AppendToClipboard;
  var
  Tmp := FDoElem;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.AppendToClipboard;
    Tmp := Tmp.FNext;
  end; // $FF
  Result := Result + TERM + SEP;
end;

procedure TStrWhile.CreateFromClipboard(var ClipboardStr: string);
var
  Elem, Tmp: TStrElement;
  AKind, Index: Byte;
begin
  inherited CreateFromClipboard(ClipboardStr);

  Tmp := nil;
  AKind := Ord(ClipboardStr[1]);
  while AKind <> $FF do
  begin
    Elem := GetStatementFromKind(AKind, FList, Self);
    if not Assigned(Elem) then
      Exit;
    Elem.CreateFromClipboard(ClipboardStr);
    if not Assigned(Tmp) then
      FDoElem := Elem
    else
    begin
      Tmp.FNext := Elem;
      Elem.FPrev := Tmp;
    end;
    Tmp := Elem;
    AKind := Ord(ClipboardStr[1]);
  end;
  Index := Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, Index);
end;

procedure TStrWhile.SetList(List: TStrList);
begin
  inherited;
  FDoElem.SetList(List);
end;

function TStrWhile.AsString: string;
begin
  Result := 'While(' + FText + ',' + FDoElem.AsString + ')';
end;

procedure TStrWhile.Debug;
var
  Str: string;
begin
  Str := 'TStrWhile Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  MessagesWindow.AddMessage('DO');
  FDoElem.Debug;
  MessagesWindow.AddMessage('IF END');
end;

procedure TStrWhile.Collapse;
begin
  FDoElem.Collapse;
end;

(* ******************************************************************************* *)
(* Do-While *)
(* ******************************************************************************* *)

constructor TStrDoWhile.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsDoWhile);
  FDoElem.FText := 'do-while head';
end;

constructor TStrDoWhile.CreateStructogram(List: TStrList;
  Dummy: Boolean = True);
begin
  inherited CreateStructogram(List);
  FKind := Ord(nsDoWhile);
  FDoElem.FText := 'do-while head';
end;

procedure TStrDoWhile.Draw;
begin
  with FList.Canvas do
  begin
    Rectangle(FRct.Left, FRct.Top, FRct.Right + 1, FRct.Bottom + 1);
    DrawContent(FTextPos.X, FTextPos.Y);

    MoveTo(FDoElem.FRct.Left, FDoElem.FRct.Top);
    LineTo(FDoElem.FRct.Left, FDoElem.FRct.Bottom);
    LineTo(FDoElem.FRct.Right, FDoElem.FRct.Bottom);
    var
    Tmp := FDoElem.FNext;
    while Assigned(Tmp) do
    begin
      Tmp.Draw;
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrDoWhile.DrawContent(XPos, YPos: Integer);
begin
  if FText = '' then
  begin
    XPos := (FRct.Left + FRct.Right + 1) div 2;
    YPos := (FRct.Bottom + FDoElem.FRct.Bottom + 1) div 2;
    DrawCircle(XPos, YPos, (GetLineHeight - 10) div 2);
  end
  else
    DrawLines(XPos, YPos, GetLineHeight);
end;

function TStrDoWhile.GetHeadHeight: Integer;
begin
  Result := FRct.Top - FDoElem.FRct.Top;
end;

procedure TStrDoWhile.Resize(XPos, YPos: Integer);
var
  X1Pos, Y1Pos, Width, Height: Integer;
begin
  FDoElem.ResizeList(XPos + DO_LEFT, YPos);

  Y1Pos := FDoElem.FRct.Bottom;
  FList.GetWidthHeigthOfText(FText, Width, Height);
  X1Pos := Max(Width, FDoElem.FRct.Right - FDoElem.FRct.Left);
  SetRct(XPos, YPos, XPos + X1Pos, Y1Pos + Height);
  FTextPos.Y := Y1Pos + TOP_BOTTOM div 2;

  X1Pos := Max(Self.FRct.Right, FDoElem.FRct.Right);
  FDoElem.SetRightList(X1Pos);
  FRct.Right := X1Pos;
end;

procedure TStrDoWhile.SetBottom(Bottom: Integer);
begin
  FRct.Bottom := Bottom;
end;

function TStrDoWhile.AsString: string;
begin
  Result := 'DoWhile(' + FDoElem.AsString + ',' + FText + ')';
end;

procedure TStrDoWhile.Debug;
var
  Str: string;
begin
  Str := 'TStrDoWhile FKind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  MessagesWindow.AddMessage('DO WHILE');
  MessagesWindow.AddMessage('');
  FDoElem.Debug;
  MessagesWindow.AddMessage('DO WHILE END');
end;

(* ******************************************************************************* *)
(* FOR *)
(* ******************************************************************************* *)

constructor TStrFor.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsFor);
  FDoElem.FText := 'for head';
end;

constructor TStrFor.CreateStructogram(List: TStrList; Dummy: Boolean = True);
begin
  inherited CreateStructogram(List);
  FKind := Ord(nsFor);
  FDoElem.FText := 'for head';
end;

function TStrFor.AsString: string;
begin
  Result := 'For(' + FDoElem.AsString + ')';
end;

procedure TStrFor.Debug;
var
  Str: string;
begin
  Str := 'TStrFor Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  MessagesWindow.AddMessage('FOR ');
  FDoElem.Debug;
  MessagesWindow.AddMessage('FOR END');
end;

(* ******************************************************************************* *)
(* CASE *)
(* ******************************************************************************* *)

constructor TStrCase.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsCase);
  FText := '';
end;

procedure TStrCase.Draw;
begin
  DrawContent(FTextPos.X, FTextPos.Y);
end;

procedure TStrCase.DrawRightBottom;
var
  Height1, Height2, Width, YPos: Integer;
begin
  if FText = '' then
    DrawContent(0, 0)
  else
  begin
    FList.GetWidthHeigthOfText(FText, Width, Height1);
    Height2 := FRct.Bottom - FRct.Top;
    YPos := FTextPos.Y + Height2 - Height1;
    DrawLinesRight(FTextPos.X, YPos, FList.LineHeight);
  end;
end;

procedure TStrCase.DrawLeftBottom;
var
  Height1, Height2, Width, YPos: Integer;
begin
  if FText = '' then
    DrawContent(0, 0)
  else
  begin
    FList.GetWidthHeigthOfText(FText, Width, Height1);
    Height2 := FRct.Bottom - FRct.Top;
    YPos := FTextPos.Y + Height2 - Height1;
    DrawLines(FTextPos.X, YPos, FList.LineHeight);
  end;
end;

function TStrCase.AsString: string;
begin
  Result := 'Case';
end;

procedure TStrCase.Debug;
var
  Str: string;
begin
  Str := 'TStrCase Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
end;

(* ******************************************************************************* *)
(* SWITCH *)
(* ******************************************************************************* *)

constructor TStrSwitch.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsSwitch);
  SetLength(FCaseElems, GuiPyOptions.CaseCount);
  for var I := 0 to High(FCaseElems) do
  begin
    FCaseElems[I] := TStrListHead.Create(List, Self);
    FCaseElems[I].FText := 'case ' + IntToStr(I) + ' head';
  end;
  FCaseElems[High(FCaseElems)].FNext.FText := GuiPyLanguageOptions.Other;
end;

constructor TStrSwitch.CreateStructogram(List: TStrList; Dummy: Boolean = True);
begin
  inherited Create(List);
  FKind := Ord(nsSwitch);
end;

procedure TStrSwitch.Draw;
var
  Tmp: TStrElement;
  UHeight, XPos, DeltaX, DeltaY, DeltaX1, DeltaY1, Case_H: Integer;
begin
  with FList.Canvas do
  begin
    if FText = '' then
      inherited Draw
    else
      DrawCenteredLines(FCaseElems[High(FCaseElems)].FRct.Left, FTextPos.Y,
        FPercent);

    // draw diagonals
    Case_H := FCaseElems[0].FNext.FRct.Bottom - FCaseElems[0].FNext.FRct.Top;
    UHeight := FCaseElems[0].FRct.Top - FRct.Top + Case_H;
    if FList.SwitchWithCaseLine then
      UHeight := UHeight - Case_H;
    MoveTo(FRct.Left, FRct.Top);
    LineTo(FCaseElems[High(FCaseElems)].FRct.Left, FRct.Top + UHeight);
    MoveTo(FRct.Right, FRct.Top);
    LineTo(FCaseElems[High(FCaseElems)].FRct.Left, FRct.Top + UHeight);

    // draw verticals
    DeltaY := UHeight + 1;
    DeltaX := FCaseElems[High(FCaseElems)].FRct.Left - FRct.Left;
    for var I := 0 to High(FCaseElems) - 1 do
    begin
      XPos := FCaseElems[I].FRct.Right;
      DeltaX1 := XPos - FRct.Left;
      if DeltaX = 0 then
        DeltaY1 := Round(DeltaY * DeltaX1)
      else
        DeltaY1 := Round(DeltaY * DeltaX1 / DeltaX);
      MoveTo(XPos, FRct.Top + DeltaY1);
      LineTo(XPos, FRct.Bottom);
    end;

    // draw then elements
    for var I := 0 to High(FCaseElems) - 1 do
    begin
      Tmp := FCaseElems[I].FNext;
      Tmp.DrawLeftBottom;
      Tmp := Tmp.FNext;
      while Assigned(Tmp) do
      begin
        Tmp.Draw;
        Tmp := Tmp.FNext;
      end;
    end;

    // draw else element Right justified
    Tmp := FCaseElems[High(FCaseElems)].FNext;
    Tmp.DrawRightBottom;
    Tmp := Tmp.FNext;
    while Assigned(Tmp) do
    begin
      Tmp.Draw;
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrSwitch.DrawContent(XPos, YPos: Integer);
var
  Height: Integer;
begin
  with FList.Canvas do
    if FText = '' then
    begin
      XPos := FCaseElems[High(FCaseElems)].FRct.Left;
      YPos := (FRct.Top + FCaseElems[High(FCaseElems)].FRct.Top + 1) div 2;
      Height := (GetLineHeight - 10) div 2;
      DrawCircle(XPos, YPos, Height);
    end
    else
      DrawLines(XPos, YPos, FList.LineHeight);
end;

procedure TStrSwitch.MoveRight(Width: Integer);
var
  Tmp: TStrElement;
begin
  inherited MoveRight(Width); { move case-rectangle and condition-FText }
  for var I := 0 to High(FCaseElems) do
  begin
    Tmp := FCaseElems[I];
    while Assigned(Tmp) do
    begin { move all case-elements }
      Tmp.MoveRight(Width);
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrSwitch.MoveDown(Height: Integer);
var
  Tmp: TStrElement;
begin
  inherited MoveDown(Height); { move case-rectangle and condition-FText }
  for var I := 0 to High(FCaseElems) do
  begin
    Tmp := FCaseElems[I];
    while Assigned(Tmp) do
    begin { move all case-elements }
      Tmp.MoveDown(Height);
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrSwitch.Resize(XPos, YPos: Integer);
var
  Bottom, Width, Delta, Height, DHeight, WCondition, WidthB: Integer;
begin
  for var I := 0 to High(FCaseElems) do
    FCaseElems[I].ResizeList(XPos, YPos);

  FList.GetWidthHeigthOfText(FText, WCondition, Height);

  // height is at least 2*LineHeight;
  // if Height <= FList.LineHeight then Height:= 2*FList.LineHeight;

  // width of "case" is at least 1.5* width of condition
  WidthB := 0;
  for var I := 0 to High(FCaseElems) do
    WidthB := WidthB + FCaseElems[I].FRct.Right - FCaseElems[I].FRct.Left;
  WidthB := Max(WidthB, WCondition);
  if WidthB <= 1.5 * WCondition then
    WidthB := Round(1.5 * WCondition);
  Width := Max(WidthB, GetDefaultRectWidth);

  // position horizontal
  SetRct(XPos, YPos, XPos + Width, YPos + Height);
  FCaseElems[0].ResizeList(XPos, YPos + Height);
  for var I := 1 to High(FCaseElems) do
    FCaseElems[I].ResizeList(FCaseElems[I - 1].FRct.Right, YPos + Height);

  // set common case head
  Height := 0;
  for var I := 0 to High(FCaseElems) do
    Height := Max(Height, FCaseElems[I].FNext.FRct.Bottom);
  for var I := 0 to High(FCaseElems) do
  begin
    DHeight := Height - FCaseElems[I].FNext.FRct.Bottom;
    FCaseElems[I].FNext.FRct.Bottom := Height;
    if DHeight > 0 then
    begin
      if Assigned(FCaseElems[I].FNext) and Assigned(FCaseElems[I].FNext.FNext)
      then
        FCaseElems[I].FNext.FNext.MoveDownList(DHeight);
      FCaseElems[I].FRct.Bottom := FCaseElems[I].FRct.Bottom + DHeight;
    end;
  end;

  // set common bottom
  Bottom := 0;
  for var I := 0 to High(FCaseElems) do
    Bottom := Max(Bottom, FCaseElems[I].FRct.Bottom);
  for var I := 0 to High(FCaseElems) do
    if Bottom > FCaseElems[I].FRct.Bottom then
      FCaseElems[I].SetBottomList(Bottom);

  SetRct(XPos, YPos, FCaseElems[High(FCaseElems)].FRct.Right, Bottom);

  // 1.5*condition_width > FRct.width ?
  Delta := WidthB - (FRct.Right - FRct.Left);
  if Delta > 0 then
    SetRight(FRct.Right + Delta);
  SetTextPos;
end;

procedure TStrSwitch.SetRight(Right: Integer);
var
  DeltaR: Integer;
begin
  DeltaR := (Right - FRct.Right) div Length(FCaseElems);
  for var I := 0 to High(FCaseElems) - 1 do
  begin
    FCaseElems[I].MoveRightList(I * DeltaR);
    FCaseElems[I].SetRightList(FCaseElems[I].FRct.Right + DeltaR);
  end;
  FCaseElems[High(FCaseElems)].MoveRightList(High(FCaseElems) * DeltaR);
  FCaseElems[High(FCaseElems)].SetRightList(Right);
  FRct.Right := Right;
  SetTextPos;
end;

procedure TStrSwitch.SetBottom(Bottom: Integer);
begin
  inherited SetBottom(Bottom);
  for var I := 0 to High(FCaseElems) do
    FCaseElems[I].SetBottomList(Bottom);
end;

procedure TStrSwitch.SetTextPos;
var
  Width, Height: Integer;
  DThen, DCase: Real;
begin
  DThen := FCaseElems[High(FCaseElems)].FRct.Left - FCaseElems[0].FRct.Left;
  DCase := FRct.Right - FRct.Left;
  if DCase = 0 then
    FPercent := DThen
  else
    FPercent := DThen / DCase;
  FList.GetWidthHeigthOfText(FText, Width, Height);
  Width := Round(FPercent * Width);
  FTextPos.X := FCaseElems[High(FCaseElems)].FRct.Left - Width;
  FTextPos.Y := FRct.Top;
end;

procedure TStrSwitch.SetList(List: TStrList);
begin
  inherited;
  for var I := 0 to High(FCaseElems) do
    FCaseElems[I].SetList(List);
end;

procedure TStrSwitch.AdjustCaseElems(Count: Integer);
begin
  for var I := High(FCaseElems) downto Count do
    FreeAndNil(FCaseElems[I]);
  if Count <= High(FCaseElems) then
    SetLength(FCaseElems, Count);
end;

function TStrSwitch.GetHeadHeight: Integer;
begin
  Result := FCaseElems[0].FRct.Top - FRct.Top;
end;

procedure TStrSwitch.LoadFromStream(Stream: TStream; Version: Byte);
var
  Current, Elem: TStrElement;
  AKind, Count: Byte;
  IPos: Integer;
begin
  inherited LoadFromStream(Stream, Version);
  IPos := 0;
  FreeAndNil(FNext); // necessary for corrupted files !
  Count := Stream.Read(AKind, 1); // overread AKind
  while (Count = 1) and (AKind <> $FF) do
  begin
    if IPos > High(FCaseElems) then
    begin
      SetLength(FCaseElems, IPos + 1);
      FCaseElems[IPos] := TStrListHead.Create(FList, Self);
      FCaseElems[IPos].FText := 'case ' + IntToStr(IPos) + ' head';
    end;
    FCaseElems[IPos].FNext.LoadFromStream(Stream, Version);
    Current := FCaseElems[IPos].FNext;
    Count := Stream.Read(AKind, 1);
    while (Count = 1) and (AKind <> $FF) do
    begin
      Elem := GetStatementFromKind(AKind, FList, Self);
      if not Assigned(Elem) then
        Exit;
      Elem.LoadFromStream(Stream, Version);
      FreeAndNil(Elem.FNext);
      FList.Insert(Current, Elem);
      Current := Elem;
      Count := Stream.Read(AKind, 1);
    end;
    // Delete default statement from TStrListHead.Create
    FList.DeleteElem(Current.FNext);
    Inc(IPos);
    Count := Stream.Read(AKind, 1);
  end;
  AdjustCaseElems(IPos);
end;

procedure TStrSwitch.LoadFromReader(Reader: TStringListReader);
var
  Current, Elem: TStrElement;
  IPos, MyIndent: Integer;
begin
  IPos := 0;
  inherited LoadFromReader(Reader);
  MyIndent := Reader.FIndentAsInt;
  while Reader.NextLineIndent = MyIndent do
  begin
    Reader.ReadLine;
    if IPos > High(FCaseElems) then
    begin
      SetLength(FCaseElems, IPos + 1);
      FCaseElems[IPos] := TStrListHead.Create(FList, Self);
      FCaseElems[IPos].FText := 'case ' + IntToStr(IPos) + ' head';
    end;
    FCaseElems[IPos].LoadFromReader(Reader);
    FCaseElems[IPos].FNext.LoadFromReader(Reader);
    Current := FCaseElems[IPos].FNext;

    while Reader.NextLineIndent = MyIndent + 2 do
    begin
      Reader.ReadLine;
      Elem := GetStatementFromReader(Reader, FList, Self);
      Elem.LoadFromReader(Reader);
      FList.Insert(Current, Elem);
      Current := Elem;
    end;
    FList.DeleteElem(Current.FNext);
    Inc(IPos);
  end;
  AdjustCaseElems(IPos);
end;

procedure TStrSwitch.SaveToStream(Stream: TStream);
var
  Tmp: TStrElement;
  Tag: Byte;
begin
  inherited SaveToStream(Stream); // save condition
  Tag := $FF;
  for var I := 0 to High(FCaseElems) do
  begin
    Tmp := FCaseElems[I].FNext;
    while Assigned(Tmp) do
    begin
      Tmp.SaveToStream(Stream);
      Tmp := Tmp.FNext;
    end;
    Stream.Write(Tag, 1); // write end Tag
  end;
  Stream.Write(Tag, 1);
end;

function TStrSwitch.GetText(Indent: string): string;
var
  Tmp: TStrElement;
begin
  Result := Indent + 'switch: ' + CrLf + inherited GetText(Indent + '  ');
  for var I := 0 to High(FCaseElems) do
  begin
    Tmp := FCaseElems[I];
    Result := Result + Indent + '  case:' + CrLf;
    while Assigned(Tmp) do
    begin
      Result := Result + Tmp.GetText(Indent + '    ');
      Tmp := Tmp.FNext;
    end;
  end;
end;

function TStrSwitch.AppendToClipboard: string;
var
  Tmp: TStrElement;
begin
  Result := inherited AppendToClipboard;
  for var I := 0 to High(FCaseElems) do
  begin
    Tmp := FCaseElems[I].FNext;
    while Assigned(Tmp) do
    begin
      Result := Result + Tmp.AppendToClipboard;
      Tmp := Tmp.FNext;
    end;
    Result := Result + TERM + SEP;
  end;
  Result := Result + TERM + SEP;
end;

procedure TStrSwitch.CreateFromClipboard(var ClipboardStr: string);
var
  Elem, Current: TStrElement;
  Kind, Index: Byte;
  IPos: Integer;
begin
  inherited CreateFromClipboard(ClipboardStr);
  IPos := 0;
  Kind := Ord(ClipboardStr[1]);
  while Kind <> $FF do
  begin
    if IPos > High(FCaseElems) then
    begin
      SetLength(FCaseElems, IPos + 1);
      FCaseElems[IPos] := TStrListHead.Create(FList, Self);
      FCaseElems[IPos].FText := 'case ' + IntToStr(IPos) + ' head';
    end;
    FCaseElems[IPos].FNext.CreateFromClipboard(ClipboardStr);
    Current := FCaseElems[IPos].FNext;
    Kind := Ord(ClipboardStr[1]);
    while Kind <> $FF do
    begin
      Elem := GetStatementFromKind(Kind, FList, Self);
      if not Assigned(Elem) then
        Exit;
      Elem.CreateFromClipboard(ClipboardStr);
      FreeAndNil(Elem.FNext);
      FList.Insert(Current, Elem);
      Current := Elem;
      Kind := Ord(ClipboardStr[1]);
    end;
    Index := Pos(SEP, ClipboardStr);
    Delete(ClipboardStr, 1, Index);
    // Delete default statement from TStrListHead.Create
    FList.DeleteElem(Current.FNext);
    Inc(IPos);
    Kind := Ord(ClipboardStr[1]);
  end;
  Index := Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, Index);
  AdjustCaseElems(IPos);
end;

destructor TStrSwitch.Destroy;
begin
  for var I := 0 to High(FCaseElems) do
    FreeAndNil(FCaseElems[I]);
  inherited;
end;

function TStrSwitch.AsString: string;
begin
  Result := 'Switch(';
  for var I := 0 to High(FCaseElems) do
    Result := Result + 'case(' + FCaseElems[I].AsString + '),';
  Delete(Result, Length(Result), 1);
  Result := Result + ')';
end;

procedure TStrSwitch.Debug;
var
  Str: string;
begin
  Str := 'TStrSwitch Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  for var I := 0 to High(FCaseElems) do
  begin
    MessagesWindow.AddMessage('');
    MessagesWindow.AddMessage('CASE ' + IntToStr(I));
    FCaseElems[I].Debug;
    MessagesWindow.AddMessage('CASE ' + IntToStr(I) + ' END');
  end;
end;

procedure TStrSwitch.Collapse;
begin
  for var I := 0 to High(FCaseElems) do
    FCaseElems[I].CollapseCase;
end;

(* ******************************************************************************* *)
(* SUBPROGRAM *)
(* ******************************************************************************* *)

constructor TStrSubprogram.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsSubProgram);
end;

procedure TStrSubprogram.Draw;
var
  Delta: Integer;
begin
  inherited Draw;
  with FList.Canvas do
  begin
    Delta := DO_SUB div 2;
    MoveTo(FRct.Left + Delta, FRct.Top + 1);
    LineTo(FRct.Left + Delta, FRct.Bottom);
    MoveTo(FRct.Right - Delta, FRct.Top + 1);
    LineTo(FRct.Right - Delta, FRct.Bottom);
  end;
end;

procedure TStrSubprogram.Resize(XPos, YPos: Integer);
begin
  inherited Resize(XPos, YPos);
  FTextPos.X := FTextPos.X + DO_SUB div 2; { ... correct FText position }
  FRct.Right := FRct.Right + DO_SUB;
end;

function TStrSubprogram.GetHeadHeight: Integer;
begin
  Result := FRct.Bottom - FRct.Top;
end;

function TStrSubprogram.AsString: string;
begin
  Result := 'Sub(' + FText + ')';
end;

function TStrSubprogram.GetText(Indent: string): string;
begin
  Result := Indent + 'subprogram: ' + CrLf + inherited GetText(Indent + '  ');
end;

procedure TStrSubprogram.Debug;
var
  Str: string;
begin
  Str := 'TStrSubprogram Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct('
    + IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
end;

(* ******************************************************************************* *)
(* BREAK *)
(* ******************************************************************************* *)

constructor TStrBreak.Create(List: TStrList);
begin
  inherited Create(List);
  FKind := Ord(nsBreak);
end;

procedure TStrBreak.Draw;
var
  Delta: Integer;
begin
  inherited Draw;
  with FList.Canvas do
  begin
    Delta := DO_BREAK;
    MoveTo(FRct.Left + Delta, FRct.Top + 1);
    LineTo(FRct.Left, (FRct.Bottom + FRct.Top) div 2);
    LineTo(FRct.Left + Delta, FRct.Bottom);
  end;
end;

procedure TStrBreak.Resize(XPos, YPos: Integer);
begin
  inherited Resize(XPos, YPos);
  FTextPos.X := FTextPos.X + DO_BREAK; { ... correct FText position }
end;

function TStrBreak.GetHeadHeight: Integer;
begin
  Result := FRct.Bottom - FRct.Top;
end;

function TStrBreak.AsString: string;
begin
  Result := 'Break';
end;

function TStrBreak.GetText(Indent: string): string;
begin
  Result := Indent + 'break: ' + CrLf + inherited GetText(Indent + '  ');
end;

procedure TStrBreak.Debug;
var
  Str: string;
begin
  Str := 'TStrBreak Kind = ' + IntToStr(FKind) + ' Text= ' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
end;

(* ******************************************************************************* *)
(* Listhead *)
(* ******************************************************************************* *)

constructor TStrListHead.Create(List: TStrList; Parent: TStrElement);
begin
  inherited Create(List);
  FKind := Ord(nsListHead);
  Self.FParent := Parent;
  Self.FNext := TStrStatement.Create(List);
  Self.FNext.FPrev := Self;
  if Parent is TStrSwitch then
    FList.Insert(Self, TStrCase.Create(List));
end;

constructor TStrListHead.CreateStructogram(List: TStrList; Parent: TStrElement;
  Dummy: Boolean = True);
begin
  inherited Create(List);
  FKind := Ord(nsListHead);
  Self.FParent := Parent;
  if Parent is TStrSwitch then
    FList.Insert(Self, TStrCase.Create(List));
end;

destructor TStrListHead.Destroy;
var
  Cur, Tmp: TStrElement;
begin
  inherited;
  Cur := FNext;
  while Assigned(Cur) do
  begin
    Tmp := Cur;
    Cur := Cur.FNext;
    FreeAndNil(Tmp);
  end;
end;

procedure TStrListHead.SetRctList(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer);
begin
  FRct.Left := X1Pos;
  FRct.Top := Y1Pos;
  FRct.Right := X2Pos;
  FRct.Bottom := Y2Pos;
end;

procedure TStrListHead.SetList(List: TStrList);
begin
  inherited;
  var
  Cur := FNext;
  while Assigned(Cur) do
  begin
    Cur.SetList(List);
    Cur := Cur.FNext;
  end;
end;

procedure TStrListHead.Resize(XPos, YPos: Integer);
begin
  inherited Resize(XPos, YPos);
  SetRct(XPos, YPos, XPos, YPos);
end;

function TStrListHead.AsString: string;
var
  Str: string;
begin
  Str := '';
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Str := Str + Tmp.AsString + ',';
    Tmp := Tmp.FNext;
  end;
  Result := Copy(Str, 1, Length(Str) - 1);
end;

procedure TStrListHead.Debug;
var
  Str: string;
begin
  Str := 'TStrListHead Kind=' + IntToStr(FKind) + ' Text=' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')';

  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.Debug;
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrListHead.Collapse;
begin
  var
  Cur := FNext;
  while Assigned(Cur.FNext) do
    if Cur.FNext.FText = '' then
      FList.DeleteElem(Cur.FNext)
    else
    begin
      Cur.FNext.Collapse;
      Cur := Cur.FNext;
    end;
  if (FNext.FText = '') and Assigned(FNext.FNext) then
    FList.DeleteElem(FNext)
  else
    FNext.Collapse;
end;

procedure TStrListHead.CollapseCase;
begin
  var
  Cur := FNext.FNext;
  while Assigned(Cur.FNext) do
    if Cur.FNext.FText = '' then
      FList.DeleteElem(Cur.FNext)
    else
    begin
      Cur.FNext.Collapse;
      Cur := Cur.FNext;
    end;
  FNext.Collapse;
end;

(* ***************************************************************************** *)
(* List *)
(* ***************************************************************************** *)

constructor TStrList.Create(ScrollBox: TScrollBox; Mode: Integer; Font: TFont);
begin
  FKind := Ord(nsList);
  FText := 'list head';
  FLoadError := False;
  FList := Self;
  FListImage := TListImage.Create(ScrollBox, Self);
  FListImage.SetBounds(50, 50, 400, 250);
  FListImage.AutoSize := True;
  FListImage.Parent := ScrollBox;
  FListImage.Canvas.Font.Assign(Font);
  FCanvas := ListImage.Canvas;
  FSwitchWithCaseLine := GuiPyOptions.SwitchWithCaseLine;
  SetLineHeight;
  FPuzzleMode := Mode;
end;

destructor TStrList.Destroy;
var
  Tmp: TStrElement;
begin
  while Assigned(FNext) do
  begin
    Tmp := FNext;
    FNext := Tmp.FNext;
    FreeAndNil(Tmp);
  end;
  FreeAndNil(ListImage);
  inherited;
end;

procedure TStrList.Draw;
var
  Height, XMid, YMid: Integer;
begin
  with Canvas do
  begin
    DrawLines(FTextPos.X, FTextPos.Y, LineHeight - TOP_BOTTOM);
    if FText = GuiPyLanguageOptions.Algorithm + ' ' then
    begin
      Height := (LineHeight - 10) div 2;
      XMid := PenPos.X + TextHeight('X') div 2 + 5;
      YMid := PenPos.Y + TextHeight('X') div 2;
      Ellipse(XMid - Height, YMid - Height, XMid + Height, YMid + Height);
      MoveTo(XMid - Height, YMid + Height);
      LineTo(XMid + Height, YMid - Height);
    end;
    var
    Tmp := FNext;
    while Assigned(Tmp) do
    begin { paint all elements }
      Tmp.Draw;
      Tmp := Tmp.FNext;
    end;
  end;
end;

procedure TStrList.DrawTo(Canvas: TCanvas);
begin
  FCanvas:= Canvas;
  Draw;
  FCanvas:= ListImage.Canvas;
end;

procedure TStrList.LoadFromStream(Stream: TStream; Version: Byte);
var
  Current, Elem: TStrElement;
  AKind, Count: Byte;
begin
  if Version >= $0E then
    FRctList := RectFromStream(Stream);
  Stream.Read(AKind, 1); { overread StrList AKind }
  inherited LoadFromStream(Stream, Version); // read algorithm name
  FreeAndNil(FNext);
  Current := Self;
  Count := Stream.Read(AKind, 1);
  while (Count = 1) and (AKind <> $FF) do
  begin
    Elem := GetStatementFromKind(AKind, Self, Self);
    if not Assigned(Elem) then
      Exit;
    Elem.LoadFromStream(Stream, Version);
    FreeAndNil(Elem.FNext); { necessary for corrupted files ! }
    FList.Insert(Current, Elem);
    Current := Elem;
    Count := Stream.Read(AKind, 1);
  end;
end;

procedure TStrList.LoadFromReader(Reader: TStringListReader);
var
  Current, Elem: TStrElement;
begin
  Reader.ReadLine; // RectPos [...]
  FRctList := Reader.FARect;
  ListImage.Left := ListImage.PPIScale(Reader.FPoint.X);
  ListImage.Top := ListImage.PPIScale(Reader.FPoint.Y);

  Reader.ReadLine; // Algorithm or list head
  FText := Reader.FText;
  FRct := Reader.FARect;
  FTextPos := Reader.FPoint;
  Current := Self;

  while Reader.NextLineIndent = 4 do
  begin
    Reader.ReadLine;
    Elem := GetStatementFromReader(Reader, Self, Self);
    Elem.LoadFromReader(Reader);
    FList.Insert(Current, Elem);
    Current := Elem;
  end;
end;

procedure TStrList.SaveToStream(Stream: TStream);
var
  Tag: Byte;
begin
  RectToStream(Stream, RctList);
  inherited SaveToStream(Stream);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.SaveToStream(Stream);
    Tmp := Tmp.FNext;
  end;
  Tag := $FF;
  Stream.Write(Tag, 1); { write end Tag }
end;

function TStrList.GetText(Indent: string): string;
begin
  Result := inherited GetText(Indent);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Result := Result + Tmp.GetText(Indent + '  ');
    Tmp := Tmp.FNext;
  end;
end;

function TStrList.GetRectPos(Indent: string): string;
begin
  Result := GetRectPosAsText(Indent, RctList,
    Point(ListImage.PPIUnScale(ListImage.Left),
    ListImage.PPIUnScale(ListImage.Top)));
end;

procedure TStrList.PaintShadow;
var
  IPos, ShadowWidth, Top, Bottom, Delta, SCol, ECol, StartRed, StartGreen,
  StartBlue, EndRed, EndGreen, EndBlue: Integer;
  Rec: TRect;

  function ColorGradient(IPos: Integer): TColor;
  var
    Red, Green, Blue: Integer;
  begin
    Red := StartRed + Round(((EndRed - StartRed) * IPos) / ShadowWidth);
    Green := StartGreen + Round(((EndGreen - StartGreen) * IPos) / ShadowWidth);
    Blue := StartBlue + Round(((EndBlue - StartBlue) * IPos) / ShadowWidth);
    Result := RGB(Red, Green, Blue);
  end;

begin
  if FKind = Byte(nsAlgorithm) then
    ShadowWidth := GuiPyOptions.StructogramShadowWidth
  else
    ShadowWidth := 0;
  if (ShadowWidth = 0) or not Assigned(FNext) then
    Exit;

  Top := FRct.Bottom + ShadowWidth;
  Bottom := GetHeight + 1 + ShadowWidth;
  Delta := 2 * ShadowWidth - (Bottom - Top);
  if Delta > 0 then
    Top := Top - Delta;
  Rec := Rect(ShadowWidth, Top, FNext.FRct.Right + ShadowWidth, Bottom);

  Canvas.Pen.Mode := pmCopy;
  SCol := ColorToRGB(Canvas.Brush.Color);
  StartRed := GetRValue(SCol);
  StartGreen := GetGValue(SCol);
  StartBlue := GetBValue(SCol);
  ECol := ColorToRGB(Canvas.Pen.Color);
  EndRed := GetRValue(ECol);
  EndGreen := GetGValue(ECol);
  EndBlue := GetBValue(ECol);
  for IPos := 0 to ShadowWidth - 1 do
  begin
    Canvas.Pen.Color := ColorGradient(IPos);
    Canvas.Polyline([Point(Rec.Right - ShadowWidth + 1, Rec.Top + IPos), Point(Rec.Right - IPos,
      Rec.Top + IPos), Point(Rec.Right - IPos, Rec.Bottom - IPos - 1), Point(Rec.Left + IPos,
      Rec.Bottom - IPos - 1), Point(Rec.Left + IPos, Rec.Bottom - ShadowWidth - 1)]);
  end;
end;

procedure TStrList.Paint(BlackAndWhite: Boolean = False);
var
  Bitmap: TBitmap;
  ShadowWidth: Integer;
begin
  if FKind = Byte(nsAlgorithm) then
    ShadowWidth := GuiPyOptions.StructogramShadowWidth
  else
    ShadowWidth := 0;

  Bitmap := TBitmap.Create;
  try
    FCanvas := Bitmap.Canvas;
    FCanvas.Font := ListImage.Canvas.Font;
    FCanvas.Pen := ListImage.Canvas.Pen;
    SetColors(BlackAndWhite);
    Bitmap.SetSize(GetWidth + 1 + ShadowWidth, GetHeight + 1 + ShadowWidth);
    Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
    PaintShadow;
    Draw;
    ListImage.Picture.Bitmap.Height := Bitmap.Height;
    ListImage.Picture.Bitmap.Width := Bitmap.Width;

    // paint structogram on canvas
    ListImage.Canvas.Draw(0, 0, Bitmap);
    FCanvas := ListImage.Canvas;
  finally
    FreeAndNil(Bitmap);
  end;
end;

procedure TStrList.SetColors(BlackAndWhite: Boolean);
begin
  if BlackAndWhite or StyleServices.IsSystemStyle then
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Font.Color := clBlack;
    Canvas.Brush.Color := clWhite;
  end
  else
  begin
    Canvas.Pen.Color := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal); // clWhite
    Canvas.Font.Color := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal);
    Canvas.Brush.Color := StyleServices.GetStyleColor(scPanel);
  end;
end;

procedure TStrList.Print;
begin
  FCanvas := Printer.Canvas;
  Draw;
end;

procedure TStrList.SetRctList(X1Pos, Y1Pos, X2Pos, Y2Pos: Integer);
begin
  FRctList.Left := X1Pos;
  FRctList.Top := Y1Pos;
  FRctList.Right := X2Pos;
  FRctList.Bottom := Y2Pos;
end;

procedure TStrList.Resize(XPos, YPos: Integer);
var
  Width: Integer;
begin
  Width := GetWidthOfLines(FText) + Canvas.Font.Size + 2 * LEFT_RIGHT;
  SetRct(XPos, YPos, XPos + Max(Width, GetDefaultRectWidth), YPos);
  // Height = 0
end;

procedure TStrList.ResizeAll;
begin
  ResizeList(0, 0);
  SetRct(0, 0, Max(GetWidthOfLines(FText) + Canvas.Font.Size + 2 * LEFT_RIGHT,
    FRct.Right), FRct.Bottom);
end;

function TStrList.GetWidth: Integer;
begin
  Result := FRct.Right - FRct.Left;
end;

function TStrList.GetHeight: Integer;
begin
  Result := Self.RctList.Bottom;
end;

procedure TStrList.Insert(Position, Elem: TStrElement);
// Insert one element or a FList of elements
begin
  var
  Tmp := Position.FNext;
  Position.FNext := Elem;
  Elem.FPrev := Position;
  while Assigned(Elem.FNext) and (Elem.FNext <> Elem) do
    Elem := Elem.FNext;
  Elem.FNext := Tmp;
  if Assigned(Tmp) then
    Tmp.FPrev := Elem;
end;

procedure TStrList.DeleteElem(Elem: TStrElement);
var
  Pre, Nex: TStrElement;
begin
  if not Assigned(Elem) then
    Exit;
  Pre := Elem.FPrev;
  if not Assigned(Pre) then
  begin
    FreeAndNil(Elem);
    Exit;
  end;
  Nex := Elem.FNext;
  Pre.FNext := Nex;
  if Assigned(Nex) then
    Nex.FPrev := Pre
  else if (Pre is TStrListHead) or (Pre is TStrCase) then
    Insert(Pre, TStrStatement.Create(FList));
  Elem.Destroy;
end;

procedure TStrList.GetWidthHeigthOfText(const Text: string;
  var Width, Height: Integer);
var
  Str, Str1: string;
  Posi: Integer;
begin
  Width := GetDefaultRectWidth;
  Height := LineHeight;
  Str := Text;
  Posi := Pos(#13#10, Str);
  while Posi > 0 do
  begin
    Str1 := Copy(Str, 1, Posi - 1);
    Delete(Str, 1, Posi + 1);
    Width := Max(ListImage.Canvas.TextWidth(Str1) + LEFT_RIGHT, Width);
    Height := Height + LineHeight;
    Posi := Pos(#13#10, Str);
  end;
  Width := Max(ListImage.Canvas.TextWidth(Str) + LEFT_RIGHT, Width);
end;

function TStrList.GetWidthOfOneLine(const Text: string): Integer;
begin
  Result := ListImage.Canvas.TextWidth(Text) + LEFT_RIGHT;
end;

function TStrList.GetWidthOfLines(const Text: string): Integer;
var
  Width, Height: Integer;
begin
  GetWidthHeigthOfText(Text, Width, Height);
  Result := Width;
end;

procedure TStrList.SetLineHeight;
begin
  FLineHeight := Canvas.TextHeight('X') + TOP_BOTTOM;
end;

function TStrList.AsString: string;
var
  Str: string;
begin
  Str := FText + ',';
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Str := Str + Tmp.AsString + ',';
    Tmp := Tmp.FNext;
  end;
  Result := Copy(Str, 1, Length(Str) - 1);
end;

procedure TStrList.Debug;
var
  Str: string;
begin
  Str := 'TStrList Kind=' + IntToStr(FKind) + ' Text=' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')' + ' RctList(' +
    IntToStr(RctList.Left) + ', ' + IntToStr(RctList.Top) + ', ' +
    IntToStr(RctList.Width) + ', ' + IntToStr(RctList.Bottom) + ')';
  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);

  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.Debug;
    Tmp := Tmp.FNext;
  end;
  MessagesWindow.AddMessage('-----------------------');
end;

procedure TStrList.SetList(List: TStrList);
begin
  Self.FList := List;
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.SetList(List);
    Tmp := Tmp.FNext;
  end;
end;

procedure TStrList.SetPuzzleMode(Mode: Integer);
begin
  FPuzzleMode := Mode;
end;

procedure TStrList.SetFont(Font: TFont);
begin
  Canvas.Font.Assign(Font);
  SetLineHeight;
end;

procedure TStrList.Collapse;
begin
  var
  Cur := FNext;
  while Assigned(Cur) do
  begin
    if Cur.FText = '' then
    begin
      DeleteElem(Cur);
      Cur := FNext;
    end
    else
    begin
      Cur.Collapse;
      Cur := Cur.FNext;
    end;
  end;
end;

(* **************************************************************************** *)
(* TStrAlgorithm *)
(* **************************************************************************** *)

constructor TStrAlgorithm.Create(ScrollBox: TScrollBox; Mode: Integer;
  Font: TFont);
begin
  inherited Create(ScrollBox, Mode, Font);
  FText := '';
  FKind := Ord(nsAlgorithm);
end;

procedure TStrAlgorithm.Resize(XPos, YPos: Integer);
var
  Width, Height, Height1: Integer;
begin
  Width := GetWidthOfLines(FText) + Canvas.Font.Size + 2 * LEFT_RIGHT;
  Height := GetLines * (LineHeight - TOP_BOTTOM);
  Height1 := Canvas.Font.Size div 2; { height of bottom Line }
  SetRct(XPos, YPos, XPos + Max(Width, GetDefaultRectWidth),
    YPos + Height + Height1);
end;

function TStrAlgorithm.GetAlgorithmName: string;
var
  Inte: Integer;
  Str: string;
begin
  Inte := Pos(GuiPyLanguageOptions.Algorithm + ' ', FText);
  if Inte > 0 then
    Str := Copy(FList.FText, Inte + Length(GuiPyLanguageOptions.Algorithm + ' '), 255)
  else
    Str := FText;
  Inte := Pos('(', Str);
  if Inte > 0 then
    Delete(Str, Inte, Length(Str));
  Result := Trim(Str);
end;

function TStrAlgorithm.AsString: string;
var
  Str: string;
begin
  Str := FText + '(';
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Str := Str + Tmp.AsString + ',';
    Tmp := Tmp.FNext;
  end;
  Result := Copy(Str, 1, Length(Str) - 1);
end;

procedure TStrAlgorithm.Debug;
var
  Str: string;
begin
  Str := 'TStrAlgorithm Kind=' + IntToStr(FKind) + ' Text=' + FText + ' Rct(' +
    IntToStr(FRct.Left) + ', ' + IntToStr(FRct.Top) + ', ' +
    IntToStr(FRct.Width) + ', ' + IntToStr(FRct.Bottom) + ')' + ' RctList(' +
    IntToStr(RctList.Left) + ', ' + IntToStr(RctList.Top) + ', ' +
    IntToStr(RctList.Width) + ', ' + IntToStr(RctList.Bottom) + ')' + ' Image('
    + IntToStr(ListImage.Left) + ', ' + IntToStr(ListImage.Top) + ')';

  if Assigned(FPrev) and (FPrev.FNext <> Self) then
    Str := Str + ' Prev.Next <> self';
  if Assigned(FNext) and (FNext.FPrev <> Self) then
    Str := Str + ' Next.Prev <> self';
  MessagesWindow.AddMessage(Str);
  var
  Tmp := FNext;
  while Assigned(Tmp) do
  begin
    Tmp.Debug;
    Tmp := Tmp.FNext;
  end;
  MessagesWindow.AddMessage('-----------------------');
end;

(* ***************************************************************************** *)
(* TListImage *)
(* ***************************************************************************** *)

constructor TListImage.Create(ScrollBox: TScrollBox; List: TStrList);
begin
  inherited Create(ScrollBox);
  FStrList := List;
end;

initialization

CF_NSDDATA := RegisterClipboardFormat('CF_NSD'); { register clipboard format }

end.
