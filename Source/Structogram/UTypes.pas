{-------------------------------------------------------------------------------
 Unit:     UTypes
 Author:   Gerhard Röhner
 Based on: NSD-Editor by Marcel Kalt
 Date:     August 2013
 Purpose:  elements of a structogram
-------------------------------------------------------------------------------}

unit UTypes;

interface

uses
  Windows, Classes, Graphics, ExtCtrls, Forms;

const
  LEFT_RIGHT = 10;                { Default left/right margin of element }

type

  TStringListReader = class
    SL: TStringList;
    nr: integer;
    kind: Byte;
    IndentAsInt: integer;
    Text: String;
    aRect: TRect;
    Point: TPoint;
    key: string;
    val: string;
    constructor create(Filename: string);
    function nextLineIndent: integer;
    procedure ReadLine;
    procedure LineBack;
    function getKind(Kind: String): byte;
    destructor Destroy; override;
  end;

  TStrType = (nsAlgorithm, nsStatement, nsIf, nsWhile, nsDoWhile, nsFor, nsSwitch,
              nsSubProgram, nsListHead, nsCase, nsBreak, nsList);

  TStrList = class;

  TStrElement = class
  private
    procedure Draw; virtual;
    procedure DrawRightBottom; virtual;
    procedure DrawLeftBottom; virtual;
    procedure DrawCircle(x, y, h: integer);
    procedure DrawLines(x, y, line_height: integer);
    procedure DrawLinesRight(x, y, line_height: integer);
    procedure DrawCenteredLines(center, y: integer; percent: real);
    procedure DrawContent(x, y: integer); virtual;
    procedure MoveRight(w: Integer); virtual;
    procedure MoveRightList(b: integer); virtual;
    procedure MoveDown(h: Integer); virtual;
    procedure MoveDownList(h: integer); virtual;
    procedure Resize(x, y: integer); virtual;
    procedure setRight(Right: integer); virtual;
    procedure setBottomList(b: integer); virtual;
    procedure setBottom(b: integer); virtual;
    procedure LoadFromStream(Stream: TStream; Version: byte); virtual;
    procedure LoadFromReader(Reader: TStringListReader); virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    function getText(Indent: string): string; virtual;
    procedure RectToStream(Stream: TStream; Rect: TRect);
    function getRectPosAsText(Indent: string; Rect: TRect; Pos: TPoint): string;
    function RectFromStream(Stream: TStream): TRect;
    procedure IntegerToStream(Stream: TStream; i: Integer);
    function IntegerFromStream(Stream: TStream): Integer;
    procedure StringToStream(Stream: TStream; const s: string);
    function StringFromStream(Stream: TStream): String;
    function AppendToClipboard: string; virtual;
    procedure CreateFromClipboard(var ClipboardStr: String); virtual;
    procedure SetRctList(X1, Y1, X2, Y2: integer); virtual;
    procedure setList(aList: TStrList); virtual;
  public
    Kind: byte;
    text: String;
    rct: TRect;
    next: TStrElement;
    prev: TStrElement;
    list: TStrList;
    textPos: TPoint;
    constructor create(aList: TStrList);
    function getHeadHeight: integer; virtual;
    procedure SetRct(X1, Y1, X2, Y2: Integer);
    procedure ResizeList(x, y: integer);
    procedure setRightList(right: integer);
    function getStatementFromKind(aKind: byte; const aList: TStrList; aParent: TStrElement): TStrElement;
    function getStatementFromReader(Reader: TStringListReader; const aList: TStrList; aParent: TStrElement): TStrElement;
    function getLineHeight: integer;
    function getDefaultRectWidth: integer;
    function getLines: integer;
    function asString: String; virtual;
    function getKind: string;
    function getMaxDelta: integer;
    procedure debug; virtual;
    procedure debug1;
    procedure Collapse; virtual;
    procedure CollapseCase; virtual;
  end;

  TStrStatement = class(TStrElement)
    constructor create(aList: TStrList);
    destructor Destroy; override;
    function asString: String; override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure debug; override;
  end;

  TStrIf = class(TStrElement)
  private
    percent: real; // then-width to else-width
    procedure Draw; override;
    procedure DrawContent(x, y: integer); override;
    procedure MoveRight(w: Integer); override;
    procedure MoveDown(h: Integer); override;
    procedure Resize(x, y: integer); override;
    procedure setRight(Right: integer); override;
    procedure setBottom(b: integer); override;
    procedure LoadFromStream(Stream: TStream; Version: byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function getText(Indent: string): string; override;
    function AppendToClipboard: string; override;
    procedure CreateFromClipboard(var ClipboardStr: string); override;
    procedure setTextPos;
    procedure setList(aList: TStrList); override;
  public
    then_elem: TStrElement;
    else_elem: TStrElement;
    constructor create(aList: TStrList);
    constructor createStructogram(aList: TStrList; dummy: boolean = true);
    destructor Destroy; override;
    function getHeadHeight: integer; override;
    function asString: String; override;
    procedure debug; override;
    procedure Collapse; override;
  end;

  TStrWhile = class(TStrElement)
  private
    procedure Draw; override;
    procedure MoveRight(w: Integer); override;
    procedure MoveDown(h: Integer); override;
    procedure Resize(x, y: integer); override;
    procedure setRight(Right: integer); override;
    procedure setBottom(b: Integer); override;
    procedure LoadFromStream(Stream: TStream; Version: byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function getText(Indent: string): string; override;
    function AppendToClipboard: string; override;
    procedure CreateFromClipboard(var ClipboardStr: string); override;
    procedure setList(aList: TStrList); override;
  public
    do_elem: TStrElement;
    constructor create(aList: TStrList);
    constructor createStructogram(aList: TStrList; dummy: boolean = true);
    destructor Destroy; override;
    function getHeadHeight: integer; override;
    function asString: String; override;
    procedure debug; override;
    procedure Collapse; override;
  end;

  TStrDoWhile = class(TStrWhile)
  private
    procedure Draw; override;
    procedure Resize(x, y: integer); override;
  public
    constructor create(aList: TStrList);
    constructor createStructogram(aList: TStrList; dummy: boolean = true);
    procedure setBottom(b: Integer); override;
    function getHeadHeight: integer; override;
    function asString: String; override;
    procedure debug; override;
  end;

  TStrFor = class(TStrWhile)
  private
  public
    constructor create(aList: TStrList);
    constructor createStructogram(aList: TStrList; dummy: boolean = true);
    function asString: String; override;
    procedure debug; override;
  end;

  TStrCase = class(TStrElement)
  private
    procedure Draw; override;
    procedure DrawRightBottom; override;
    procedure DrawLeftBottom; override;
    function getText(Indent: string): string; override;
  public
    constructor create(aList: TStrList);
    function asString: String; override;
    procedure debug; override;
  end;

  TStrSwitch = class(TStrElement)
  private
    percent: real; // then-width to else-width
    procedure Draw; override;
    procedure DrawContent(x, y: integer); override;
    procedure MoveRight(w: Integer); override;
    procedure MoveDown(h: integer); override;
    procedure Resize(x, y: integer); override;
    procedure setRight(Right: integer); override;
    procedure setBottom(b: integer); override;
    procedure LoadFromStream(Stream: TStream; Version: byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function getText(Indent: string): string; override;
    function AppendToClipboard: string; override;
    procedure CreateFromClipboard(var ClipboardStr: string); override;
    procedure setTextPos;
    procedure setList(aList: TStrList); override;
    procedure AdjustCaseElems(i: integer);
  public
    case_elems: array of TStrElement;  // SetLength, Length, High, Low
    constructor create(aList: TStrList);
    constructor createStructogram(aList: TStrList; dummy: boolean = true);
    destructor Destroy; override;
    function getHeadHeight: integer; override;
    function asString: String; override;
    procedure debug; override;
    procedure Collapse; override;
  end;

  { example debug of a switch element

    TStrSwitch Kind = 6 Text= cases rct(0, 0, 300, 125)

    CASE 0
    TStrListHead Kind=8 Text=case 0 head rct(0, 25, 75, 125)
    TStrCase Kind = 9 Text= case A rct(0, 25, 75, 50)
    StrStatement Kind=1 Text=A rct(0, 50, 75, 75)
    StrStatement Kind=1 Text=X rct(0, 75, 75, 100)
    StrStatement Kind=1 Text=Y rct(0, 100, 75, 125)
    CASE 0 END

    CASE 1
    TStrListHead Kind=8 Text=case 1 head rct(75, 25, 75, 125)
    TStrCase Kind = 9 Text= case B rct(75, 25, 75, 50)
    StrStatement Kind=1 Text=B rct(75, 50, 75, 75)
    StrStatement Kind=1 Text=W rct(75, 75, 75, 125)
    CASE 1 END

    CASE 2
    TStrListHead Kind=8 Text=case 2 head rct(150, 25, 75, 125)
    TStrCase Kind = 9 Text= case C rct(150, 25, 75, 50)
    StrStatement Kind=1 Text=B rct(150, 50, 75, 125)
    CASE 2 END

    CASE 3
    TStrListHead Kind=8 Text=case 3 head rct(225, 25, 75, 125)
    TStrCase Kind = 9 Text= else rct(225, 25, 75, 50)
    StrStatement Kind=1 Text=D rct(225, 50, 75, 125)
    CASE 3 END

  }

  TStrSubprogram = class(TStrElement)
  private
    procedure Draw; override;
    procedure Resize(x, y: integer); override;
    function getText(Indent: string): string; override;
    procedure LoadFromReader(Reader: TStringListReader); override;
  public
    constructor create(aList: TStrList);
    function getHeadHeight: integer; override;
    function asString: String; override;
    procedure debug; override;
  end;

  TStrBreak = class(TStrElement)
  private
    procedure Draw; override;
    procedure Resize(x, y: integer); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    function getText(Indent: string): string; override;
  public
    constructor create(aList: TStrList);
    function getHeadHeight: integer; override;
    function asString: String; override;
    procedure debug; override;
  end;

  // head of a list of statements as part of a statement, used in in If/While/Do/Switch...
  TStrListHead = class(TStrElement)
  private
    procedure SetRctList(X1, Y1, X2, Y2: integer); override;
    procedure setList(aList: TStrList); override;
  public
    Parent: TStrElement;
    constructor create(aList: TStrList; aParent: TStrElement);
    constructor createStructogram(aList: TStrList; aParent: TStrElement; Dummy: boolean = true);
    procedure Resize(x, y: integer); override;
    destructor Destroy; override;
    function asString: String; override;
    procedure debug; override;
    procedure Collapse; override;
    procedure CollapseCase; override;
  end;

  TListImage = class;

  // a whole structure without Algorithm
  TStrList = class(TStrElement)
  private
    procedure Draw; override;
    procedure Resize(x, y: integer); override;
    procedure SetRctList(X1, Y1, X2, Y2: integer); override;
  public
    LoadError: boolean;
    SwitchWithCaseLine: boolean;
    rctList: TRect;
    LineHeight: integer;
    Image: TListImage;
    Canvas: TCanvas;
    PuzzleMode: integer;
    DontMove: boolean;
    SL: TStringList;
    nr: integer;
    dirty: boolean;
    constructor create(ScrollBox: TScrollBox; Mode: integer; Font: TFont);
    destructor Destroy; override;
    procedure PaintShadow;
    procedure Paint; virtual;
    procedure SetColors;
    procedure Print;
    procedure ResizeAll; virtual;
    procedure LoadFromStream(Stream: TStream; Version: byte); override;
    procedure LoadFromReader(Reader: TStringListReader); override;
    procedure SaveToStream(Stream: TStream); override;
    function getText(indent: string): string; override;
    function getRectPos(Indent: string): string;
    procedure deleteElem(elem: TStrElement);
    function getWidth: integer;
    function getHeight: integer;
    procedure insert(at, elem: TStrElement);

    procedure getWidthHeigthOfText(const aText: string; var w, h: integer);
    function getWidthOfOneLine(const aText: string): integer;
    function getWidthOfLines(const aText: string): integer;
    procedure setLineHeight;
    function asString: String; override;
    procedure debug; override;
    procedure setList(aList: TStrList); override;
    procedure setPuzzleMode(Mode: integer);
    procedure setFont(Font: TFont);
    procedure Collapse; override;
  end;

  // a whole structure, inherited form TStrList
  TStrAlgorithm = class(TStrList)
  private
    procedure Resize(x, y: integer); override;
  public
    constructor create(ScrollBox: TScrollBox; Mode: integer; Font: TFont);
    function getAlgorithmName: string;
    function asString: String; override;
    procedure debug; override;
  end;

  TListImage = class (TImage)
  public
    StrList: TStrList;
    // the constructor in TImage is not overload
    constructor Create(Scrollbox: TScrollBox; List: TStrList); reintroduce;
  end;


implementation

uses SysUtils, Printers, Math, Themes, Controls,
     System.UITypes, System.Types,
     frmMessages, UUtils, UConfiguration;

const
  DO_LEFT = 22;                   { Default left margin of do-element }
  DO_BREAK = 15;
  DO_SUB = 16;
  SEP  = #254;                    { Separator of commands }
  TERM = #255;                    { Terminator of commands }

  RECT_WIDTH = 75;                { Minimal width of a rectangle }
  TOP_BOTTOM = 4;                 { Default top/bottom margin of element }

constructor TStringListReader.create(Filename: string);
begin
  SL:= TStringList.Create;
  nr:= 0;
  try
    SL.LoadFromFile(Filename);
  except on e: Exception do
    ErrorMsg(e.Message);
  end;
end;

function TStringListReader.nextLineIndent: integer;
  var s: string; p: integer;
begin
  if nr < SL.Count - 1 then begin
    s:= SL[nr+1];
    p:= 1;
    if s <> '' then
      while s[p] = ' ' do
        inc(p);
    Result:= p - 1;
  end else
    Result:= 0;
end;

procedure TStringListReader.ReadLine;
  var line: string;
      p, q: integer;

  function getInt: integer;
    var p: integer;
  begin
    p:= pos(' ', val);
    if p > 1 then begin
      Result:= StrToInt(copy(val, 1, p-1));
      delete(val, 1, p)
    end else
      Result:= 0;
  end;

begin
  Kind:= Ord(nsStatement);
  Text:= '';
  aRect:= Rect(0, 0, 0, 0);
  Point.X:= 0;
  Point.Y:= 0;
  line:= '';
  IndentAsInt:= 0;
  key:= '';
  val:= '';

  inc(nr);
  while (nr < SL.Count) and (trim(SL[nr]) = '') do
    inc(nr);

  if nr < SL.Count then begin
    line:= SL[nr];
    q:= 1;
    if line <> '' then
      while line[q] = ' ' do
        inc(q);
    IndentAsInt:= q - 1;
    line:= UnhideCrLf(trim(line));
    //dline:= line;
  end;

  p:= length(line);
  while (p > 0) and (line[p] <> '|') do
    dec(p);
  if p > 0 then begin
    val:= copy(line, p + 1, length(line)) + ' ';
    aRect.Left:= getInt;
    aRect.Top:= getInt;
    aRect.Right:= getInt;
    aRect.Bottom:= getInt;
    Point.x:= getInt;
    Point.y:= getInt;
  end;

  Text:= copy(line, 1, p - 1);
  if Text = '' then begin
    q:= Pos(':', Line);
    if q > 0 then begin
      key:= copy(line, 1, q - 1);
      val:= copy(line, q + 2, length(line));
      if (key <> '') and (val = '') then
        Kind:= getKind(key)
    end
  end else
    if Text[1] = '|' then
      delete(Text, 1, 1);
end;

function TStringListReader.getKind(Kind: String): byte;
begin
  if Kind = 'Algorithm'  then Result:= Ord(nsAlgorithm) else
  if Kind = 'if'         then Result:= Ord(nsIf) else
  if Kind = 'while'      then Result:= Ord(nsWhile) else
  if Kind = 'do while'   then Result:= Ord(nsDoWhile) else
  if Kind = 'for'        then Result:= Ord(nsFor) else
  if Kind = 'switch'     then Result:= Ord(nsSwitch) else
  if Kind = 'subprogram' then Result:= Ord(nsSubprogram) else
  if Kind = 'listhead'   then Result:= Ord(nsListHead) else
  if Kind = 'case'       then Result:= Ord(nsCase) else
  if Kind = 'break'      then Result:= Ord(nsBreak) else
  if Kind = 'list'       then Result:= Ord(nsList) else
                              Result:= Ord(nsStatement);
end;

procedure TStringListReader.LineBack;
begin
  dec(nr);
end;

destructor TStringListReader.destroy;
begin
  FreeAndNil(SL);
end;

(*********************************************************************************)
(*                                      ELEMENT                                  *)
(*********************************************************************************)

constructor TStrElement.create(aList: TStrList);
begin
  kind:= 0;
  text:= '';
  next:= nil;
  prev:= nil;
  Self.list:= aList;
end;

procedure TStrElement.DrawCircle(x, y, h: integer);
begin
  with list.Canvas do begin
    Ellipse(x - h, y - h, x + h, y + h);
    MoveTo(x - h, y + h);
    LineTo(x + h, y -h);
  end;
end;

procedure TStrElement.DrawLines(x, y, line_height: integer);
  var s, s1: string; p: integer; BrushColor: TColor;
begin
  BrushColor:= list.Canvas.Brush.Color;
  list.Canvas.Brush.Style:= bsClear;
  s:= text;
  p:= Pos(#13#10, s);
  while p > 0 do begin
    s1:= copy(s, 1, p-1);
    delete(s, 1, p+1);
    list.Canvas.TextOut(x, y, s1);
    y:= y + line_height;
    p:= Pos(#13#10, s);
  end;
  if s <> '' then list.Canvas.TextOut(x, y, s);
  list.Canvas.Brush.Style:= bsSolid;
  list.Canvas.Brush.Color:= BrushColor;
end;

procedure TStrElement.DrawLinesRight(x, y, line_height: integer);
  var s, s1: string; p: integer; BrushColor: TColor;
begin
  BrushColor:= list.Canvas.Brush.Color;
  list.Canvas.Brush.Style:= bsClear;
  s:= text;
  p:= Pos(#13#10, s);
  while p > 0 do begin
    s1:= copy(s, 1, p-1);
    delete(s, 1, p+1);
    x:= rct.Right - list.Canvas.TextWidth(s1) -  LEFT_RIGHT div 2;
    list.Canvas.TextOut(x, y, s1);
    y:= y + line_height;
    p:= Pos(#13#10, s);
  end;
  if s <> '' then begin
    x:= rct.Right - list.Canvas.TextWidth(s) -  LEFT_RIGHT div 2;
    list.Canvas.TextOut(x, y, s);
  end;
  list.Canvas.Brush.Style:= bsSolid;
  list.Canvas.Brush.Color:= BrushColor;
end;

procedure TStrElement.DrawCenteredLines(center, y: integer; percent: real);
  var s, s1: string; x, w, p: integer; BrushColor: TColor;
begin
  list.Canvas.Rectangle(rct.left, rct.top, rct.right+1, rct.bottom+1);
  BrushColor:= list.Canvas.Brush.Color;
  list.Canvas.Brush.Style:= bsClear;
  s:= text;
  y:= textPos.Y;
  p:= Pos(#13#10, s);
  while p > 0 do begin
    s1:= copy(s, 1, p-1);
    delete(s, 1, p+1);
    w:= round(percent * list.getWidthOfOneLine(s1));
    x:= center - w;
    list.Canvas.TextOut(x, y, s1);
    y:= y + list.LineHeight;
    p:= Pos(#13#10, s);
  end;
  if s <> '' then begin
    w:= round(percent * list.getWidthOfOneLine(s));
    x:= center - w;
    list.Canvas.TextOut(x, y, s);
  end;
  list.Canvas.Brush.Style:= bsSolid;
  list.Canvas.Brush.Color:= BrushColor;
end;

procedure TStrElement.DrawContent(x, y: integer);
  var h: integer;
begin
  with list.Canvas do
    if text = '' then begin
      x:= (rct.left + rct.right + 1) div 2;
      y:= (rct.top + rct.bottom + 1) div 2;
      h:= (getLineHeight - 10) div 2;
      DrawCircle(x, y, h);
    end else
      DrawLines(x, y, list.LineHeight);
end;

procedure TStrElement.Draw;
begin
  with list.Canvas do begin
    Rectangle(rct.left, rct.top, rct.right+1, rct.bottom+1);
    DrawContent(textPos.X, textPos.Y);
  end;
end;

procedure TStrElement.DrawRightBottom;
begin
end;

procedure TStrElement.DrawLeftBottom;
begin
end;

procedure TStrElement.MoveRight(w: Integer);
begin
  rct.left:= rct.left + w;
  rct.right:= rct.right + w;
  textPos.x:= textPos.x + w;
end;

procedure TStrElement.MoveDown(h: Integer);
begin
  rct.top:= rct.top + h;
  rct.bottom:= rct.bottom + h;
  textPos.y:= textPos.y + h;
end;

procedure TStrElement.MoveRightList(b: Integer);
  var tmp: TStrElement;
begin
  MoveRight(b);
  tmp:= next;
  while tmp <> nil do begin
    tmp.MoveRight(b);
    tmp:= tmp.next;
  end;
end;

procedure TStrElement.MoveDownList(h: Integer);
  var tmp: TStrElement;
begin
  MoveDown(h);
  tmp:= next;
  while tmp <> nil do begin
    tmp.MoveDown(h);
    tmp:= tmp.next;
  end;
end;

procedure TStrElement.Resize(x, y: integer);
  var w, h: Integer;
begin
  list.getWidthHeigthOfText(text, w, h);
  if list.PuzzleMode = 1
    then SetRct(x, y, x + rct.Right-rct.Left, y + rct.Bottom-rct.top)
  else if list.PuzzleMode = 2 then
    SetRct(x, y, x + rct.Right-rct.Left, y + h)
  else
    SetRct(x, y, x + w, y + h);
end;

procedure TStrElement.setRight(Right: Integer);
begin
  rct.Right:= Right;
end;

procedure TStrElement.setBottomList(b: Integer);
  var tmp: TStrElement;
begin
  setBottom(b);
  tmp:= next;
  if assigned(tmp) then begin
    while tmp.next <> nil do
      tmp:= tmp.next;
    tmp.setBottom(b);
  end;
end;

procedure TStrElement.setBottom(b: integer);
begin
  rct.Bottom:= b;
end;

procedure TStrElement.ResizeList(x, y: integer);
  var x1, y1: Integer; tmp: TStrElement; k1: byte;
begin
  // calculate width
  Resize(x, y); // Listhead  or StrList
  k1 := Ord(nsAlgorithm);
  if Kind = k1
    then x1:= getDefaultRectWidth + list.Canvas.Font.Size + 2*LEFT_RIGHT
    else x1:= Self.rct.Right;
  y1:= Self.rct.Bottom;
  tmp:= next;
  while tmp <> nil do begin
    tmp.Resize(x, y1);
    x1:= max(x1, tmp.rct.Right);
    y1:= tmp.rct.Bottom;
    tmp:= tmp.next;
  end;
  // set width
  setRightList(x1);
  SetRctList(x, y, x1, y1);
end;

procedure TStrElement.setRightList(right: integer);
  var tmp: TStrElement;
begin
  setRight(right);
  tmp:= next;
  while tmp <> nil do begin
    tmp.setRight(right);
    tmp:= tmp.next
  end;
  rct.Right:= right;
end;

function TStrElement.getLineHeight: integer;
begin
  Result:= list.LineHeight;
end;

function TStrElement.getDefaultRectWidth: integer;
begin
  Result:= round(RECT_WIDTH*(list.Canvas.Font.Size/12.0));
end;

function TStrElement.getLines: integer;
  var p, n: integer; s: string;
begin
  n:= 0;
  s:= text;
  p:= Pos(#13#10, s);
  while p > 0 do begin
    delete(s, 1, p+1);
    inc(n);
    p:= Pos(#13#10, s);
  end;
  if s <> '' then inc(n);
  if n = 0 then n:= 1;
  Result:= n;
end;

function TStrElement.getHeadHeight: integer;
begin
  Result:= getLineHeight;
end;

procedure TStrElement.LoadFromStream(Stream: TStream; Version: byte);
  var i: byte; s: ShortString;
begin
  if Version >= $0E then begin
    Text:= StringFromStream(Stream);
    rct:= RectFromStream(Stream);
    TextPos.X:= IntegerFromStream(Stream);
    TextPos.Y:= IntegerFromStream(Stream);
  end else begin
    Stream.Read(i, 1);
    setLength(s, i);
    Stream.Read(s[1], i);
    Text:= String(s);
  end;
end;

procedure TStrElement.LoadFromReader(Reader: TStringListReader);
begin
  Reader.ReadLine;
  Text:= Reader.Text;
  rct:= Reader.aRect;
  TextPos:= Reader.Point;
end;

procedure TStrElement.SaveToStream(Stream: TStream);
begin
  Stream.Write(kind, 1);
  StringToStream(Stream, Text);
  RectToStream(Stream, rct);
  IntegerToStream(Stream, TextPos.X);
  IntegerToStream(Stream, TextPos.Y);
end;

function TStrElement.getText(Indent: string): string;
  var s: string;
begin
  s:= HideCrLf(Text);
  if (s <> '') and (s[1] = ' ') then
    s:= '|' + s;
  Result:= Indent + s + getRectPosAsText(indent, rct, TextPos) + CrLf;
end;

procedure TStrElement.RectToStream(Stream: TStream; Rect: TRect);
begin
  IntegerToStream(Stream, Rect.Left);
  IntegerToStream(Stream, Rect.Top);
  IntegerToStream(Stream, Rect.Right);
  IntegerToStream(Stream, Rect.Bottom);
end;

function TStrElement.getRectPosAsText(Indent: string; Rect: TRect; Pos: TPoint): string;
begin
  Result:= '|' +
           IntToStr(Rect.Left) + ' ' +
           IntTostr(Rect.Top) + ' '  +
           IntToStr(Rect.Right) + ' ' +
           IntToStr(Rect.Bottom) + ' ' +
           IntToStr(Pos.x) + ' ' +
           IntToStr(Pos.y);
end;

function TStrElement.RectFromStream(Stream: TStream): TRect;
begin
  Result.Left:= IntegerFromStream(Stream);
  Result.Top:= IntegerFromStream(Stream);
  Result.Right:= IntegerFromStream(Stream);
  Result.Bottom:= IntegerFromStream(Stream);
end;

procedure TStrElement.IntegerToStream(Stream: TStream; i: Integer);
  var si: SmallInt;
begin
  si:= SmallInt(i);
  Stream.Write(si, 2);
end;

function TStrElement.IntegerFromStream(Stream: TStream): Integer;
begin
  Result:= 0;
  Stream.read(Result, 2);
end;

procedure TStrElement.StringToStream(Stream: TStream; const s: string);
  var Size: LongInt;
begin
  Size:= Length(s)*SizeOf(Char);
  stream.Write(Size, SizeOf(Size));
  stream.Write(Pointer(s)^, Size);
end;

function TStrElement.StringFromStream(Stream: TStream): String;
  var Size: LongInt;
begin
  stream.read(Size, SizeOf(Size));
  setLength(Result, Size div SizeOf(Char));
  stream.read(Pointer(Result)^, Size);
end;

function TStrElement.AppendToClipboard: string;
begin
  Result:= chr(kind) + text + SEP;
end;

procedure TStrElement.CreateFromClipboard(var ClipboardStr: String);
var
  index: Byte;
begin
  index:= Pos(SEP, ClipboardStr);
  text:= Copy(ClipboardStr, 2, index-2);
  Delete(ClipboardStr, 1, index);
end;

procedure TStrElement.SetRct(X1, Y1, X2, Y2: integer);
begin
  rct.left:= X1;
  rct.top:= Y1;
  rct.right:= X2;
  rct.bottom:= Y2;
  textPos.X:= rct.left + LEFT_RIGHT div 2;
  textPos.Y:= rct.top + TOP_BOTTOM div 2;
end;

procedure TStrElement.SetRctList(X1, Y1, X2, Y2: integer);
begin
end;

procedure TStrElement.SetList(aList: TStrList);
begin
  Self.List:= aList;
end;

function TStrElement.getStatementFromKind(aKind: byte; const aList: TStrList; aParent: TStrElement): TStrElement;
begin
  case aKind of
    ord(nsAlgorithm)  : Result:= nil; //TStrAlgorithm.create(aList);
    ord(nsStatement)  : Result:= TStrStatement.Create(aList);
    ord(nsIf)         : Result:= TStrIf.Create(aList);
    ord(nsWhile)      : Result:= TStrWhile.Create(aList);
    ord(nsDoWhile)    : Result:= TStrDoWhile.Create(aList);
    ord(nsFor)        : Result:= TStrFor.Create(aList);
    ord(nsSwitch)     : Result:= TStrSwitch.Create(aList);
    ord(nsSubprogram) : Result:= TStrSubprogram.Create(aList);
    ord(nsListhead)   : Result:= TStrListHead.create(aList, aParent);
    ord(nsCase)       : Result:= nil; // TStrCase.create(aList);
    ord(nsBreak)      : Result:= TStrBreak.create(aList);
    else                Result:= nil;
  end;
  if Result = nil then
    list.LoadError:= true;
end;

function TStrElement.getStatementFromReader(Reader: TStringListReader; const aList: TStrList; aParent: TStrElement): TStrElement;
begin
  case Reader.Kind of
    ord(nsStatement)  : Result:= TStrStatement.Create(aList);
    ord(nsIf)         : Result:= TStrIf.Create(aList);
    ord(nsWhile)      : Result:= TStrWhile.Create(aList);
    ord(nsDoWhile)    : Result:= TStrDoWhile.Create(aList);
    ord(nsFor)        : Result:= TStrFor.Create(aList);
    ord(nsSwitch)     : Result:= TStrSwitch.Create(aList);
    ord(nsSubprogram) : Result:= TStrSubprogram.Create(aList);
    ord(nsListhead)   : Result:= TStrListHead.create(aList, aParent);
    ord(nsBreak)      : Result:= TStrBreak.create(aList);
    else                Result:= TStrStatement.Create(aList);
  end;
end;

function TStrElement.asString: String;
begin
  Result:= Text;
end;

function TStrElement.getKind: string;
begin
  case Kind of
    Ord(nsAlgorithm) : Result:= 'Algorithm';
    ord(nsStatement) : Result:= 'Statement';
    ord(nsIf)        : Result:= 'if';
    ord(nsWhile)     : Result:= 'while';
    ord(nsDoWhile)   : Result:= 'do while';
    ord(nsFor)       : Result:= 'for';
    ord(nsSwitch)    : Result:= 'switch';
    ord(nsSubprogram): Result:= 'subprogram';
    ord(nsListhead)  : Result:= 'list head';
    ord(nsCase)      : Result:= 'case';
    ord(nsBreak)     : Result:= 'break';
    else               Result:= 'List';
  end;
end;

function TStrElement.getMaxDelta: integer;
begin
  Result:= min((rct.bottom - rct.top) div 2, getHeadHeight);
end;

procedure TStrElement.debug;
  var s: String;
begin
  s:= 'StrElement Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> TStrElement(Self)) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> TStrElement(Self)) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
end;

procedure TStrElement.debug1;
  var s: String;
begin
  s:= 'StrElement Kind = ' + IntToStr(kind) + ' Text= ' + text;
  if assigned(prev) and (prev.next <> TStrElement(Self)) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> TStrElement(Self)) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
end;

procedure TStrElement.Collapse;
begin
end;

procedure TStrElement.CollapseCase;
begin
end;

(*********************************************************************************)
(*                                      Statement                                *)
(*********************************************************************************)

constructor TStrStatement.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= Ord(nsStatement);
end;

destructor TStrStatement.destroy;
begin
  inherited;
end;

function TStrStatement.asString: String;
begin
  Result:= Text;
end;

procedure TStrStatement.debug;
  var s: String;
begin
  s:= 'StrStatement Kind=' + IntToStr(kind) + ' Text=' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
end;

procedure TStrStatement.LoadFromReader(Reader: TStringListReader);
begin
  text:= Reader.Text;
  rct:= Reader.aRect;
  textPos:= Reader.Point;
end;

(*********************************************************************************)
(*                                      IF                                       *)
(*********************************************************************************)

constructor TStrIf.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsIf);
  then_elem:= TStrListHead.Create(aList, Self);
  then_elem.text:= 'then list head';
  else_elem:= TStrListHead.Create(aList, Self);
  else_elem.text:= 'else list head';
end;

constructor TStrIf.createStructogram(aList: TStrList; dummy: boolean = true);
begin
  inherited create(aList);
  kind:= ord(nsIf);
  then_elem:= TStrListHead.CreateStructogram(aList, Self);
  then_elem.text:= 'then list head';
  else_elem:= TStrListHead.CreateStructogram(aList, Self);
  else_elem.text:= 'else list head';
end;

destructor TStrIf.Destroy;
begin
  inherited;
  FreeAndNil(then_elem);
  FreeAndNil(else_elem);
end;

procedure TStrIf.Draw;
  var tmp: TStrElement;
      uh, h, w: Integer;
      BrushColor: TColor;
begin
  with list.Canvas do begin
    if text = ''
      then inherited Draw
      else drawCenteredLines(then_elem.rct.Right, textPos.Y, percent);
    uh:= then_elem.rct.Top - rct.Top;
    MoveTo(rct.left, rct.top+1);
    LineTo(then_elem.rct.right-1, rct.top + uh);
    MoveTo(rct.right, rct.top+1);
    LineTo(else_elem.rct.left+1, rct.top + uh);

    MoveTo(rct.Left, rct.top + uh);
    LineTo(rct.Right, rct.top + uh);
    MoveTo(then_elem.rct.right, rct.top + uh + 1);
    LineTo(then_elem.rct.right, rct.Bottom);

    Font.Size:= Font.Size - 2;
    BrushColor:= Brush.Color;
    Brush.Style:= bsClear;
    h:= then_elem.rct.Top - getLineHeight + TOP_BOTTOM;
    w:= TextWidth(GuiPyLanguageOptions.No);
    TextOut(rct.left+4, h, GuiPyLanguageOptions.Yes);
    TextOut(rct.right-w-2, h+2, GuiPyLanguageOptions.No);
    Brush.Style:= bsSolid;
    Brush.Color:= BrushColor;
    Font.Size:= Font.Size + 2;

    tmp:= then_elem.next;
    while tmp <> nil do begin
      tmp.Draw;
      tmp:= tmp.next;
    end;

    tmp:= else_elem.next;
    while tmp <> nil do begin
      tmp.Draw;
      tmp:= tmp.next;
    end;
  end;
end;

procedure TStrIf.DrawContent(x, y: integer);
  var h: integer;
begin
  with list.Canvas do
    if text = '' then begin
      h:= getLineHeight;
      y:= rct.top + h div 2;
      h:= (h - 10) div 2;
      x:= then_elem.rct.right;
      DrawCircle(x, y, h);
    end else
      DrawLines(x, y, list.LineHeight);
end;

procedure TStrIf.MoveRight(w: Integer);
  var tmp: TStrElement;
begin
  inherited MoveRight(w);    { move IF-rectangle and condition-text }
  tmp:= then_elem;
  while tmp <> nil do begin  { move all THEN-elements }
    tmp.MoveRight(w);
    tmp:= tmp.next;
  end;
  tmp:= else_elem;
  while tmp <> nil do begin  { move all ELSE-elements }
    tmp.MoveRight(w);
    tmp:= tmp.next;
  end;
end;

procedure TStrIf.MoveDown(h: Integer);
  var tmp: TStrElement;
begin
  inherited MoveDown(h);    { move IF-rectangle and condition-text }
  tmp:= then_elem;
  while tmp <> nil do begin  { move all THEN-elements }
    tmp.MoveDown(h);
    tmp:= tmp.next;
  end;
  tmp:= else_elem;
  while tmp <> nil do begin  { move all ELSE-elements }
    tmp.MoveDown(h);
    tmp:= tmp.next;
  end;
end;

procedure TStrIf.Resize(x, y: integer);
  var b, w, d, h, wcondition, wb: integer;
begin
  then_elem.ResizeList(x, y);
  else_elem.ResizeList(x, y);

  list.getWidthHeigthOfText(text, wcondition, h);
  // width of "if" is at least 1.5* witdh of condition
  wb:= max(then_elem.rct.Right - then_elem.rct.Left +
           else_elem.rct.Right - else_elem.rct.Left, wcondition);
  if wb <= 1.5*wcondition then wb:= round(1.5*wcondition);
  w:= max(wb, getDefaultRectWidth);

  SetRct(x, y, x + w, y + h);
  then_elem.ResizeList(x, y + h);
  else_elem.ResizeList(then_elem.rct.Right, y + h);
  b:= max(then_elem.rct.Bottom, else_elem.rct.Bottom);
  if b > then_elem.rct.Bottom then
    then_elem.setBottomList(b);
  if b > else_elem.rct.Bottom then
    else_elem.setBottomList(b);
  SetRct(x, y, else_elem.rct.Right, b);

  // 1.5*condition_width > rct.width ?
  d:= wb - (rct.Right - rct.Left);
  if d > 0 then
    setRight(rct.Right + d);

  setTextPos;
end;

procedure TStrIf.setRight(Right: integer);
  var r1, dr: integer;
begin
  dr:= Right - rct.Right;
  r1:= dr div 2;
  then_elem.setRightList(then_elem.rct.Right + r1);
  else_elem.MoveRightList(r1);
  else_elem.setRightList(Right);
  rct.Right:= Right;
  setTextPos;
end;

procedure TStrIf.setBottom(b: Integer);
begin
  inherited setBottom(b);
  then_elem.setBottomList(b);
  else_elem.setBottomList(b);
end;

function TStrIf.getHeadHeight: integer;
begin
  Result:= then_elem.rct.top - rct.top;
end;

procedure TStrIf.setTextPos;
  var w, h: integer;
      dthen, dif: real;
begin
  dthen:= then_elem.rct.Right - then_elem.rct.Left;
  dif:= rct.Right - rct.Left;
  if dif = 0
    then percent:= dthen
    else percent:= dthen/dif;
  list.getWidthHeigthOfText(text, w, h);
  w:= round(percent * w);
  TextPos.x:= then_elem.rct.Right - w;
  TextPos.y:= rct.top;
end;

procedure TStrIf.setList(aList: TStrList);
begin
  inherited;
  then_elem.setList(aList);
  else_elem.setList(aList);
end;

procedure TStrIf.LoadFromStream(Stream: TStream; Version: byte);
  var current, elem: TStrElement;
      aKind, count: Byte;
begin
  inherited LoadFromStream(Stream, Version);
  FreeAndNil(next); {necessary for corrupted files !}
  Stream.Read(aKind, 1);  {overread aKind}
  then_elem.LoadFromStream(Stream, Version);
  FreeAndNil(then_elem.next);
  current:= then_elem;
  count:= Stream.Read(aKind, 1);
  while (count = 1) and (aKind <> $FF) do begin
    elem:= getStatementFromKind(aKind, list, Self);
    if elem = nil then exit;
    elem.LoadFromStream(Stream, Version);
    FreeAndNil(elem.next);
    list.Insert(current, elem);
    current:= elem;
    count:= Stream.Read(aKind, 1);
  end;
  if count = 1 then begin
    Stream.Read(akind, 1);  {overread kind}
    else_elem.LoadFromStream(Stream, Version);
    FreeAndNil(else_elem.next);
    current:= else_elem;
    count:= Stream.Read(aKind, 1);
    while (count = 1) and (aKind <> $FF) do begin
      elem:= getStatementFromKind(aKind, list, Self);
      if elem = nil then exit;
      elem.LoadFromStream(Stream, Version);
      FreeAndNil(elem.next);
      list.Insert(current, elem);
      current:= elem;
      count:= Stream.Read(aKind, 1);
    end;
  end;
end;

procedure TStrIf.LoadFromReader(Reader: TStringListReader);
  var current, elem: TStrElement;
      myIndent: integer;
begin
  inherited LoadFromReader(Reader); // condition
  myIndent:= Reader.IndentAsInt;
  then_elem.LoadFromReader(Reader);
  FreeAndNil(then_elem.next); // don't use empty statement
  current:= then_elem;
  while Reader.nextLineIndent = myIndent do begin
    Reader.ReadLine;
    elem:= getStatementFromReader(Reader, list, Self);
    elem.LoadFromReader(Reader);
    list.Insert(current, elem);
    current:= elem;
  end;
  Reader.ReadLine; // else
  else_elem.LoadFromReader(Reader);
  FreeAndNil(else_elem.next); // don't use empty statement
  current:= else_elem;
  while Reader.nextLineIndent = myIndent do begin
    Reader.ReadLine;
    elem:= getStatementFromReader(Reader, list, Self);
    elem.LoadFromReader(Reader);
    list.Insert(current, elem);
    current:= elem;
  end;
end;

procedure TStrIf.SaveToStream(Stream: TStream);
var
  tmp: TStrElement;
  tag: Byte;
begin
  inherited SaveToStream(Stream);
  tmp:= then_elem;
  while tmp <> nil do begin
    tmp.SaveToStream(Stream);
    tmp:= tmp.next;
  end;
  tag:= $FF;
  Stream.Write(tag, 1);      {write end tag}
  tmp:= else_elem;
  while tmp <> nil do begin
    tmp.SaveToStream(Stream);
    tmp:= tmp.next;
  end;
  tag:= $FF;
  Stream.Write(tag, 1);      {write end tag}
end;

function TStrIf.getText(Indent: string): string;
  var tmp: TStrElement;
begin
  Result:= Indent + 'if: ' + CrLf + inherited getText(Indent + '  ');
  tmp:= then_elem;
  while tmp <> nil do begin
    Result:= Result + tmp.getText(Indent + '  ');
    tmp:= tmp.next;
  end;
  Result:= Result + Indent + 'else:' + CrLf;
  tmp:= else_elem;
  while tmp <> nil do begin
    Result:= Result + tmp.getText(Indent + '  ');
    tmp:= tmp.next;
  end;
end;

function TStrIf.AppendToClipboard: string;
var
  tmp: TStrElement;
begin
  Result:= inherited AppendToClipboard;
  tmp:= then_elem;
  while tmp <> nil do begin
    Result:= Result + tmp.AppendToClipboard;
    tmp:= tmp.next;
  end;
  Result:= Result + TERM + SEP;
  tmp:= else_elem;
  while tmp <> nil do begin
    Result:= Result + tmp.AppendToClipboard;
    tmp:= tmp.next;
  end;
  Result:= Result + TERM + SEP;
end;

procedure TStrIf.CreateFromClipboard(var ClipboardStr: string);
var
  elem, tmp: TStrElement;
  aKind, index: Byte;
begin
  inherited CreateFromClipboard(ClipboardStr);

  tmp:= nil;
  aKind:= ord(ClipboardStr[1]);
  while aKind <> $FF do begin
    elem:= getStatementFromKind(aKind, list, Self);
    if elem = nil then exit;
    elem.CreateFromClipboard(ClipboardStr);
    if tmp = nil then
      then_elem:= elem
    else begin
      tmp.next:= elem;
      elem.prev:= tmp;
    end;
    tmp:= elem;
    aKind:= ord(ClipboardStr[1]);
  end;
  index:= Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, index);

  tmp:= nil;
  aKind:= ord(ClipboardStr[1]);
  while aKind <> $FF do begin
    elem:= getStatementFromKind(aKind, list, Self);
    if elem = nil then exit;
    elem.CreateFromClipboard(ClipboardStr);
    if tmp = nil then
      else_elem:= elem
    else begin
      tmp.next:= elem;
      elem.prev:= tmp;
    end;
    tmp:= elem;
    aKind:= ord(ClipboardStr[1]);
  end;
  index:= Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, index);
end;

function TStrIf.asString: String;
begin
  Result:= 'If(' + text + ',' + then_elem.asString + ',' + else_elem.asString + ')';
end;

procedure TStrIf.debug;
  var s: String;
begin
  s:= 'TStrIf Kind=' + IntToStr(kind) + ' Text=' + text +
     ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
   if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  MessagesWindow.AddMessage('THEN');
  then_elem.debug;
  MessagesWindow.AddMessage('ELSE');
  else_elem.debug;
  MessagesWindow.AddMessage('IF END');
end;

procedure TStrIf.Collapse;
begin
  then_elem.Collapse;
  else_elem.Collapse;
end;

(*********************************************************************************)
(*                                     WHILE                                     *)
(*********************************************************************************)

constructor TStrWhile.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsWhile);
  do_elem:= TStrListHead.create(aList, Self);
  do_elem.text:= 'while head';
end;

constructor TStrWhile.createStructogram(aList: TStrList; dummy: boolean = true);
begin
  inherited create(aList);
  kind:= ord(nsWhile);
  do_elem:= TStrListHead.CreateStructogram(aList, Self);
  do_elem.text:= 'while head';
end;

destructor TStrWhile.Destroy;
begin
  FreeAndNil(do_elem);
end;

procedure TStrWhile.Draw;
  var tmp: TStrElement;
begin
  with list.Canvas do begin
    inherited Draw;           { draw WHILE-rectangle and condition-text }
    MoveTo(do_elem.rct.right, do_elem.rct.top);
    LineTo(do_elem.rct.left, do_elem.rct.top);
    LineTo(do_elem.rct.left, rct.bottom);
    tmp:= do_elem.next;
    while tmp <> nil do begin
      tmp.Draw;
      tmp:= tmp.next;
    end;
  end;
end;

procedure TStrWhile.MoveRight(w: Integer);
  var tmp: TStrElement;
begin
  inherited MoveRight(w);    { move WHILE-rectangle and condition-text }
  tmp:= do_elem;
  while tmp <> nil do begin  { move all WHILE-elements }
    tmp.MoveRight(w);
    tmp:= tmp.next;
  end;
end;

procedure TStrWhile.MoveDown(h: Integer);
  var tmp: TStrElement;
begin
  inherited MoveDown(h);    { move WHILE-rectangle and condition-text }
  tmp:= do_elem;
  while tmp <> nil do begin  { move all WHILE-elements }
    tmp.MoveDown(h);
    tmp:= tmp.next;
  end;
end;

procedure TStrWhile.Resize(x, y: integer);
  var w: integer;
begin
  inherited Resize(x, y);
  do_elem.ResizeList(x + DO_LEFT, y + getLines*list.LineHeight);
  w:= max(Self.rct.Right, do_elem.rct.Right);
  SetRct(x, y, w, do_elem.rct.Bottom);
  do_elem.setRightList(rct.Right);
end;

procedure TStrWhile.setRight(Right: integer);
begin
  rct.right:= Right;
  do_elem.setRightList(Right);
end;

procedure TStrWhile.setBottom(b: Integer);
begin
  inherited setBottom(b);
  do_elem.setBottomList(b);
end;

function TStrWhile.getHeadHeight: integer;
begin
  Result:= do_elem.rct.top - rct.top;
end;

procedure TStrWhile.LoadFromStream(Stream: TStream; Version: byte);
var
  current, elem: TStrElement;
  aKind, count: Byte;
begin
  inherited LoadFromStream(Stream, Version);
  FreeAndNil(next); {necessary for corrupted files !}
  Stream.Read(aKind, 1);  {overread aKind}
  do_elem.LoadFromStream(Stream, Version);
  FreeAndNil(do_elem.next); {necessary for corrupted files !}
  current:= do_elem;
  count:= Stream.Read(aKind, 1);
  while (count = 1) and (aKind <> $FF) do begin
    elem:= getStatementFromKind(aKind, list, Self);
    if elem = nil then exit;
    elem.LoadFromStream(Stream, Version);
    FreeAndNil(elem.next);
    list.Insert(current, elem);
    current:= elem;
    count:= Stream.Read(aKind, 1);
  end;
end;

procedure TStrWhile.LoadFromReader(Reader: TStringListReader);
  var current, elem: TStrElement;
      myIndent: integer;
begin
  inherited LoadFromReader(Reader);
  do_elem.LoadFromReader(Reader);
  FreeAndNil(do_elem.next); // don't use empty statement
  current:= do_elem;
  myIndent:= Reader.IndentAsInt;
  while Reader.nextLineIndent = myIndent do begin
    Reader.ReadLine;
    elem:= getStatementFromReader(Reader, list, Self);
    elem.LoadFromReader(Reader);
    list.Insert(current, elem);
    current:= elem;
  end;
end;

procedure TStrWhile.SaveToStream(Stream: TStream);
var
  tmp: TStrElement;
  tag: Byte;
begin
  inherited SaveToStream(Stream);
  tmp:= do_elem;
  while tmp <> nil do begin
    tmp.SaveToStream(Stream);
    tmp:= tmp.next;
  end;
  tag:= $FF;
  Stream.Write(tag, 1);      {write end tag}
end;

function TStrWhile.getText(Indent: string): string;
  var tmp: TStrElement;
begin
  Result:= Indent + getKind + ': ' + CrLf + inherited getText(Indent + '  ');
  tmp:= do_elem;
  while tmp <> nil do begin
    Result:= Result + tmp.getText(Indent + '  ');
    tmp:= tmp.next;
  end;
end;

function TStrWhile.AppendToClipboard: string;
var
  tmp: TStrElement;
begin
  Result:= inherited AppendToClipboard;
  tmp:= do_elem;
  while tmp <> nil do begin
    Result:= Result + tmp.AppendToClipboard;
    tmp:= tmp.next;
  end;                           // $FF
  Result:= Result + TERM + SEP;
end;

procedure TStrWhile.CreateFromClipboard(var ClipboardStr: string);
var
  elem, tmp: TStrElement;
  aKind, index: Byte;
begin
  inherited CreateFromClipboard(ClipboardStr);

  tmp:= nil;
  aKind:= ord(ClipboardStr[1]);
  while aKind <> $FF do begin
    elem:= getStatementFromKind(aKind, list, Self);
    if elem = nil then exit;
    elem.CreateFromClipboard(ClipboardStr);
    if tmp = nil then
      do_elem:= elem
    else begin
      tmp.next:= elem;
      elem.prev:= tmp;
    end;
    tmp:= elem;
    aKind:= ord(ClipboardStr[1]);
  end;
  index:= Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, index);
end;

procedure TStrWhile.setList(aList: TStrList);
begin
  inherited;
  do_elem.setList(aList);
end;

function TStrWhile.asString: String;
begin
  Result:= 'While(' + text + ',' + do_elem.asString + ')';
end;

procedure TStrWhile.debug;
  var s: String;
begin
  s:= 'TStrWhile Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  MessagesWindow.AddMessage('DO');
  do_elem.debug;
  MessagesWindow.AddMessage('WHILE END');
end;

procedure TStrWhile.Collapse;
begin
  do_elem.Collapse;
end;

(*********************************************************************************)
(*                                    Do-While                                   *)
(*********************************************************************************)

constructor TStrDoWhile.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsDoWhile);
  do_elem.text:= 'do-while head';
end;

constructor TStrDoWhile.createStructogram(aList: TStrList; dummy: boolean = true);
begin
  inherited createStructogram(aList);
  kind:= ord(nsDoWhile);
  do_elem.text:= 'do-while head';
end;

procedure TStrDoWhile.Draw;
  var tmp: TStrElement;
begin
  with list.Canvas do begin
    Rectangle(rct.left, rct.top, rct.right+1, rct.bottom+1);
    DrawContent(textPos.x, textPos.y);

    MoveTo(do_elem.rct.left, do_elem.rct.top);
    LineTo(do_elem.rct.left, do_elem.rct.bottom);
    LineTo(do_elem.rct.right,do_elem.rct.bottom);
    tmp:= do_elem.next;
    while tmp <> nil do begin
      tmp.Draw;
      tmp:= tmp.next;
    end;
  end;
end;

function TStrDoWhile.getHeadHeight: integer; 
begin
  Result:= rct.top - do_elem.rct.top;
end;

procedure TStrDoWhile.Resize(x, y: integer);
  var x1, y1, w, h: integer;
begin
  do_elem.ResizeList(x + DO_LEFT, y);

  y1:= do_elem.rct.Bottom;
  list.getWidthHeigthOfText(text, w, h);
  x1:= max(w, do_elem.rct.Right - do_elem.rct.Left);
  SetRct(x, y, x + x1, y1 + h);
  TextPos.y:= y1 + TOP_BOTTOM div 2;

  x1:= max(Self.rct.Right, do_elem.rct.Right);
  do_elem.setRightList(x1);
  rct.Right:= x1;
end;

procedure TStrDoWhile.setBottom(b: Integer);
begin
  rct.Bottom:= b;
  //do_elem.setBottomList(b);
end;

function TStrDoWhile.asString: String;
begin
  Result:= 'DoWhile(' + do_elem.asString + ',' + text + ')';
end;

procedure TStrDoWhile.debug;
  var s: String;
begin
  s:= 'TStrDoWhile Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
   if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  MessagesWindow.AddMessage('DO WHILE');
  MessagesWindow.AddMessage('');
  do_elem.debug;
  MessagesWindow.AddMessage('DO WHILE END');
end;

(*********************************************************************************)
(*                                      FOR                                      *)
(*********************************************************************************)

constructor TStrFor.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsFor);
  do_elem.text:= 'for head';
end;

constructor TStrFor.createStructogram(aList: TStrList; dummy: boolean = true);
begin
  inherited createStructogram(aList);
  kind:= ord(nsFor);
  do_elem.text:= 'for head';
end;

function TStrFor.asString: string;
begin
  Result:= 'For(' + do_elem.asString + ')';
end;

procedure TStrFor.debug;
  var s: String;
begin
  s:= 'TStrFor Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
   if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  MessagesWindow.AddMessage('FOR ');
  do_elem.debug;
  MessagesWindow.AddMessage('FOR END');
end;

(*********************************************************************************)
(*                                      CASE                                     *)
(*********************************************************************************)

constructor TStrCase.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsCase);
  text:= '';
end;

procedure TStrCase.Draw;
begin
  DrawContent(textPos.X, textPos.Y);
end;

procedure TStrCase.DrawRightBottom;
  var h1, h2, w, y: integer;
begin
  if text = ''
    then DrawContent(0,0)
  else begin
    list.getWidthHeigthOfText(text, w, h1);
    h2:= rct.Bottom - rct.Top;
    y:= textPos.Y + h2 - h1;
    DrawLinesRight(textPos.x, y, list.LineHeight);
  end;
end;

procedure TStrCase.DrawLeftBottom;
  var h1, h2, w, y: integer;
begin
  if text = ''
    then DrawContent(0,0)
  else begin
    list.getWidthHeigthOfText(text, w, h1);
    h2:= rct.Bottom - rct.Top;
    y:= textPos.Y + h2 - h1;
    DrawLines(textPos.x, y, list.LineHeight);
  end;
end;

function TStrCase.asString: string;
begin
  Result:= 'Case';
end;

function TStrCase.getText(Indent: string): string;
begin
  Result:= inherited getText(Indent);
end;

procedure TStrCase.debug;
  var s: String;
begin
  s:= 'TStrCase Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
end;

(*********************************************************************************)
(*                                      SWITCH                                   *)
(*********************************************************************************)

constructor TStrSwitch.create(aList: TStrList);
  var i: integer;
begin
  inherited create(aList);
  kind:= ord(nsSwitch);
  SetLength(case_elems, GuiPyOptions.CaseCount);
  for i:= 0 to high(case_elems) do begin
    case_elems[i]:= TStrListHead.Create(aList, Self);
    case_elems[i].text:= 'case ' + IntToStr(i) + ' head';
  end;
  case_elems[high(case_elems)].next.text:= GuiPyLanguageOptions.Other;
end;

constructor TStrSwitch.createStructogram(aList: TStrList; dummy: boolean = true);
begin
  inherited create(aList);
  kind:= ord(nsSwitch);
end;

procedure TStrSwitch.Draw;
  var tmp: TStrElement;
      uh, x, dx, dy, dx1, dy1, case_h, i: Integer;
begin
  with list.Canvas do begin
    if text = ''
      then inherited Draw
      else drawCenteredLines(case_elems[high(case_elems)].rct.Left, textPos.Y, percent);

    // draw diagonals
    case_h:= case_elems[0].next.rct.Bottom - case_elems[0].next.rct.Top;
    uh:= case_elems[0].rct.Top - rct.Top + case_h;
    if list.SwitchWithCaseLine then uh:= uh - case_h;
    MoveTo(rct.left, rct.top);
    LineTo(case_elems[high(case_elems)].rct.Left, rct.top + uh);
    MoveTo(rct.right, rct.top);
    LineTo(case_elems[high(case_elems)].rct.Left, rct.top + uh);

    // draw verticals
    dy:= uh + 1;
    dx:= case_elems[high(case_elems)].rct.Left - rct.Left;
    for i:= 0 to high(case_elems) - 1 do begin
      x:= case_elems[i].rct.Right;
      dx1:= x - rct.Left;
      if dx = 0
        then dy1:= round(dy*dx1)
        else dy1:= round(dy*dx1/dx);
      MoveTo(x, rct.Top + dy1);
      LineTo(x, rct.Bottom);
    end;

    // draw then elements
    for i:= 0 to high(case_elems) - 1  do begin
      tmp:= case_elems[i].next;
      tmp.DrawLeftBottom;
      tmp:= tmp.next;
      while tmp <> nil do begin
        tmp.Draw;
        tmp:= tmp.next;
      end;
    end;

    // draw else element right justified
    i:= high(case_elems);
    tmp:= case_elems[i].next;
    tmp.DrawRightBottom;
    tmp:= tmp.Next;
    while tmp <> nil do begin
      tmp.Draw;
      tmp:= tmp.next;
    end;
  end;
end;

procedure TStrSwitch.DrawContent(x, y: integer);
  var h: integer;
begin
  with list.Canvas do
    if text = '' then begin
      x:= case_elems[high(case_elems)].rct.Left;
      y:= (rct.top + case_elems[high(case_elems)].rct.top + 1) div 2;
      h:= (getLineHeight - 10) div 2;
      DrawCircle(x, y, h);
    end else
      DrawLines(x, y, list.LineHeight);
end;

procedure TStrSwitch.MoveRight(w: Integer);
  var tmp: TStrElement; i: integer;
begin
  inherited MoveRight(w);    { move case-rectangle and condition-text }
  for i:= 0 to high(case_elems) do begin
    tmp:= case_elems[i];
    while tmp <> nil do begin  { move all case-elements }
      tmp.MoveRight(w);
      tmp:= tmp.next;
    end;
  end;
end;

procedure TStrSwitch.MoveDown(h: Integer);
  var tmp: TStrElement; i: integer;
begin
  inherited MoveDown(h);    { move case-rectangle and condition-text }
  for i:= 0 to high(case_elems) do begin
    tmp:= case_elems[i];
    while tmp <> nil do begin  { move all case-elements }
      tmp.MoveDown(h);
      tmp:= tmp.next;
    end;
  end;
end;

procedure TStrSwitch.Resize(x, y: integer);
  var b, w, d, h, dh, wcondition, wb, i: integer;
begin
  for i:= 0 to high(case_elems) do
    case_elems[i].ResizeList(x, y);

  list.getWidthHeigthOfText(text, wcondition, h);

  // height is at least 2*LineHeight;
  //if h <= list.LineHeight then h:= 2*list.LineHeight;

  // width of "case" is at least 1.5* width of condition
  wb:= 0;
  for i:= 0 to high(case_elems) do
     wb:= wb + case_elems[i].rct.Right - case_elems[i].rct.Left;
  wb:= max(wb, wcondition);
  if wb <= 1.5*wcondition then wb:= round(1.5*wcondition);
  w:= max(wb, getDefaultRectWidth);

  // position horizontal
  SetRct(x, y, x + w, y + h);
  case_elems[0].ResizeList(x, y + h);
  for i:= 1 to high(case_elems) do
    case_elems[i].ResizeList(case_elems[i-1].rct.Right, y + h);

  // set common case head
  h:= 0;
  for i:= 0 to high(case_elems) do
    h:= max(h, case_elems[i].next.rct.Bottom);
  for i:= 0 to high(case_elems) do begin
    dh:= h - case_elems[i].next.rct.Bottom;
    case_elems[i].next.rct.Bottom:= h;
    if dh > 0 then begin
      if assigned(case_elems[i].next) and assigned(case_elems[i].next.next) then
        case_elems[i].next.next.MoveDownList(dh);
      case_elems[i].rct.Bottom:= case_elems[i].rct.Bottom + dh;
    end;
  end;

  // set common bottom
  b:= 0;
  for i:= 0 to high(case_elems) do
    b:= max(b, case_elems[i].rct.Bottom);
  for i:= 0 to high(case_elems) do
    if b > case_elems[i].rct.Bottom then
      case_elems[i].setBottomList(b);

  SetRct(x, y, case_elems[high(case_elems)].rct.Right, b);

  // 1.5*condition_width > rct.width ?
  d:= wb - (rct.Right - rct.Left);
  if d > 0 then
    setRight(rct.Right + d);
  setTextPos;
end;

procedure TStrSwitch.setRight(Right: integer);
  var dr, i: integer;
begin
  dr:= (Right - rct.Right) div Length(case_elems);
  for i:= 0 to high(case_elems) - 1 do begin
    case_elems[i].MoveRightList(i*dr);
    case_elems[i].setRightList(case_elems[i].rct.Right + dr);
  end;
  case_elems[high(case_elems)].MoveRightList(high(case_elems)*dr);
  case_elems[high(case_elems)].setRightList(Right);
  rct.Right:= Right;
  setTextPos;
end;

procedure TStrSwitch.setBottom(b: Integer);
  var i: integer;
begin
  inherited setBottom(b);
  for i:= 0 to high(case_elems) do
    case_elems[i].setBottomList(b);
end;

procedure TStrSwitch.setTextPos;
  var w, h: integer;
      dthen, dcase: real;
begin
  dthen:= case_elems[high(case_elems)].rct.Left - case_elems[0].rct.Left;
  dcase:= rct.Right - rct.Left;
  if dcase = 0
    then percent:= dthen
    else percent:= dthen/dcase;
  list.getWidthHeigthOfText(text, w, h);
  w:= round(percent * w);
  TextPos.x:= case_elems[high(case_elems)].rct.Left - w;
  TextPos.y:= rct.top;
end;

procedure TStrSwitch.setList(aList: TStrList);
  var i: integer;
begin
  inherited;
  for i:= 0 to high(case_elems) do
    case_elems[i].setList(aList);
end;

procedure TStrSwitch.AdjustCaseElems(i: integer);
  var j: integer;
begin
  for j:= high(case_elems) downto i do
    FreeAndNil(case_elems[j]);
  if i <= high(case_elems) then
    SetLength(case_elems, i);
end;

function TStrSwitch.getHeadHeight: integer;
begin
  Result:= case_elems[0].rct.top - rct.top;
end;

procedure TStrSwitch.LoadFromStream(Stream: TStream; Version: byte);
var
  current, elem: TStrElement;
  aKind, count: Byte; i: integer;
begin
  inherited LoadFromStream(Stream, Version);
  i:= 0;
  FreeAndNil(next);  // necessary for corrupted files !
  count:= Stream.Read(akind, 1);  // overread aKind
  while (count = 1) and (aKind <> $FF) do begin
    if i > high(case_elems) then begin
      SetLength(case_elems, i+1);
      case_elems[i]:= TStrListHead.Create(list, Self);
      case_elems[i].text:= 'case ' + IntToStr(i) + ' head';
    end;
    case_elems[i].next.LoadFromStream(Stream, Version);
    current:= case_elems[i].next;
    count:= Stream.Read(aKind, 1);
    while (count = 1) and (aKind <> $FF) do begin
      elem:= getStatementFromKind(aKind, list, Self);
      if elem = nil then exit;
      elem.LoadFromStream(Stream, Version);
      FreeAndNil(elem.next);
      list.Insert(current, elem);
      current:= elem;
      count:= Stream.Read(aKind, 1);
    end;
    // delete default statement from TStrListHead.create
    list.deleteElem(current.next);
    inc(i);
    count:= Stream.Read(aKind, 1);
  end;
  AdjustCaseElems(i);
end;

procedure TStrSwitch.LoadFromReader(Reader: TStringListReader);
  var current, elem: TStrElement;
      i, myIndent: integer;
begin
  i:= 0;
  inherited LoadFromReader(Reader);
  myIndent:= Reader.IndentAsInt;
  while Reader.nextLineIndent = myIndent do begin
    Reader.ReadLine;
    if i > high(case_elems) then begin
      SetLength(case_elems, i+1);
      case_elems[i]:= TStrListHead.Create(list, Self);
      case_elems[i].text:= 'case ' + IntToStr(i) + ' head';
    end;
    case_elems[i].LoadFromReader(Reader);
    case_elems[i].next.LoadFromReader(Reader);
    current:= case_elems[i].next;

    while Reader.nextLineIndent = myIndent + 2 do begin
      Reader.ReadLine;
      elem:= getStatementFromReader(Reader, list, Self);
      elem.LoadFromReader(Reader);
      list.Insert(current, elem);
      current:= elem;
    end;
    list.deleteElem(current.next);
    inc(i);
  end;
  AdjustCaseElems(i);
end;

procedure TStrSwitch.SaveToStream(Stream: TStream);
var
  tmp: TStrElement;
  tag: Byte;
  i: integer;
begin
  inherited SaveToStream(Stream); // save condition
  tag:= $FF;
  for i:= 0 to high(case_elems) do begin
    tmp:= case_elems[i].next;
    while tmp <> nil do begin
      tmp.SaveToStream(Stream);
      tmp:= tmp.next;
    end;
    Stream.Write(tag, 1);      // write end tag
  end;
  Stream.Write(tag, 1);
end;

function TStrSwitch.getText(Indent: string): string;
var
  tmp: TStrElement;
  i: integer;
begin
  Result:= Indent + 'switch: ' + CrLf + inherited getText(Indent + '  ');
  for i:= 0 to high(case_elems) do begin
    tmp:= case_elems[i];
    Result:= Result + Indent + '  case:' + CrLf;
    while tmp <> nil do begin
      Result:= Result + tmp.getText(Indent + '    ');
      tmp:= tmp.next;
    end;
  end;
end;

function TStrSwitch.AppendToClipboard: string;
  var tmp: TStrElement; i: integer;
begin
  Result:= inherited AppendToClipboard;
  for i:= 0 to high(case_elems) do begin
    tmp:= case_elems[i].next;
    while tmp <> nil do begin
      Result:= Result + tmp.AppendToClipboard;
      tmp:= tmp.next;
    end;
    Result:= Result + TERM + SEP;
  end;
  Result:= Result + TERM + SEP;
end;

procedure TStrSwitch.CreateFromClipboard(var ClipboardStr: string);
var
  elem, current: TStrElement;
  aKind, index: Byte; i: integer;
begin
  inherited CreateFromClipboard(ClipboardStr);
  i:= 0;
  aKind:= ord(ClipboardStr[1]);
  while akind <> $FF do begin
    if i > high(case_elems) then begin
      SetLength(case_elems, i+1);
      case_elems[i]:= TStrListHead.Create(list, Self);
      case_elems[i].text:= 'case ' + IntToStr(i) + ' head';
    end;
    case_elems[i].next.CreateFromClipboard(ClipboardStr);
    current:= case_elems[i].next;
    aKind:= ord(ClipboardStr[1]);
    while akind <> $FF do begin
      elem:= getStatementFromKind(aKind, list, Self);
      if elem = nil then exit;
      elem.CreateFromClipboard(ClipboardStr);
      FreeAndNil(elem.next);
      list.Insert(current, elem);
      current:= elem;
      aKind:= ord(ClipboardStr[1]);
    end;
    index:= Pos(SEP, ClipboardStr);
    Delete(ClipboardStr, 1, index);
    // delete default statement from TStrListHead.create
    list.deleteElem(current.next);
    inc(i);
    aKind:= ord(ClipboardStr[1]);
  end;
  index:= Pos(SEP, ClipboardStr);
  Delete(ClipboardStr, 1, index);
  AdjustCaseElems(i);
end;

destructor TStrSwitch.Destroy;
  var i: integer;
begin
  for i:= 0 to high(case_elems) do
    FreeAndNil(case_elems[i]);
end;

function TStrSwitch.asString: String;
 var i: integer;
begin
  Result:= 'Switch(';
  for i:= 0 to high(case_elems) do
    Result:= Result + 'case(' + case_elems[i].asString + '),';
  delete(Result, length(Result), 1);
  Result:= Result + ')';
end;

procedure TStrSwitch.debug;
  var s: String; i: integer;
begin
  s:= 'TStrSwitch Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  for i:= 0 to high(case_elems) do begin
    MessagesWindow.AddMessage('');
    MessagesWindow.AddMessage('CASE ' + IntToStr(i));
    case_elems[i].debug;
    MessagesWindow.AddMessage('CASE ' + IntToStr(i) + ' END');
  end;
end;

procedure TStrSwitch.Collapse;
  var i: integer;
begin
  for i:= 0 to high(case_elems) do
    case_elems[i].CollapseCase;
end;

(*********************************************************************************)
(*                                  SUBPROGRAM                                   *)
(*********************************************************************************)

constructor TStrSubProgram.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsSubProgram);
end;

procedure TStrSubprogram.Draw;
  var d: integer;
begin
  inherited Draw;
  with list.Canvas do begin
    d:= DO_SUB div 2;
    MoveTo(rct.left + d, rct.top+1);
    LineTo(rct.left + d, rct.bottom);
    MoveTo(rct.right - d, rct.top+1);
    LineTo(rct.right - d, rct.bottom);
  end;
end;

procedure TStrSubprogram.Resize(x, y: integer);
begin
  inherited Resize(x, y);
  textPos.x:= textPos.x + DO_SUB div 2;                { ... correct text position }
  rct.right:= rct.right + DO_SUB;
end;

function TStrSubprogram.getHeadHeight: integer;
begin
  Result:= rct.bottom - rct.top;
end;

function TStrSubprogram.asString: String;
begin
  Result:= 'Sub(' + text + ')';
end;

procedure TStrSubprogram.LoadFromReader(Reader: TStringListReader);
begin
  inherited LoadFromReader(Reader);
end;

function TStrSubprogram.getText(Indent: string): string;
begin
  Result:= Indent + 'subprogram: ' + CrLf + inherited getText(Indent + '  ');
end;

procedure TStrSubprogram.debug;
  var s: String;
begin
  s:= 'TStrSubprogram Kind = ' + IntToStr(kind) + ' Text= ' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
end;

(*********************************************************************************)
(*                                  BREAK                                        *)
(*********************************************************************************)

constructor TStrBreak.create(aList: TStrList);
begin
  inherited create(aList);
  kind:= ord(nsBreak);
end;

procedure TStrBreak.Draw;
  var d: integer;
begin
  inherited Draw;
  with list.Canvas do begin
    d:= DO_BREAK;
    MoveTo(rct.left + d, rct.top+1);
    LineTo(rct.left, (rct.bottom + rct.top) div 2);
    LineTo(rct.left + d, rct.bottom);
  end;
end;

procedure TStrBreak.Resize(x, y: integer);
begin
  inherited Resize(x, y);
  textPos.x:= textPos.x + DO_BREAK;        { ... correct text position }
end;

function TStrBreak.getHeadHeight: integer;
begin
  Result:= rct.bottom - rct.top;
end;

function TStrBreak.asString: String;
begin
  Result:= 'Break';
end;

procedure TStrBreak.LoadFromReader(Reader: TStringListReader);
begin
  inherited LoadFromReader(Reader);
end;

function TStrBreak.getText(Indent: string): string;
begin
  Result:= Indent + 'break: ' + CrLf + inherited getText(Indent + '  ');
end;

procedure TStrBreak.debug;
  var s: String;
begin
  s:= 'TStrBreak Kind = ' + IntToStr(kind) + ' Text= ' + text +
     ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
end;

(*********************************************************************************)
(*                                      Listhead                                 *)
(*********************************************************************************)

constructor TStrListHead.create(aList: TStrList; aParent: TStrElement);
begin
  inherited create(aList);
  kind:= Ord(nsListHead);
  Self.Parent:= aParent;
  Self.next:= TStrStatement.create(aList);
  Self.next.prev:= Self;
  if parent is TStrSwitch then
    aList.insert(Self, TStrCase.create(aList));
end;

constructor TStrListHead.createStructogram(aList: TStrList; aParent: TStrElement; Dummy: boolean = true);
begin
  inherited create(aList);
  kind:= Ord(nsListHead);
  Self.Parent:= aParent;
  if parent is TStrSwitch then
    aList.insert(Self, TStrCase.create(aList));
end;

destructor TStrListHead.Destroy;
  var cur, tmp: TStrElement;
begin
  inherited;
  cur:= next;
  while cur <> nil do begin
    tmp:= cur;
    cur:= cur.next;
    FreeAndNil(tmp);
  end;
end;

procedure TStrListHead.SetRctList(X1, Y1, X2, Y2: integer);
begin
  rct.left := X1;
  rct.top := Y1;
  rct.right := X2;
  rct.bottom := Y2;
end;

procedure TStrListHead.setList(aList: TStrList);
  var cur: TStrElement;
begin
  inherited;
  cur:= next;
  while cur <> nil do begin
    cur.setList(aList);
    cur:= cur.next;
  end;
end;

procedure TStrListHead.Resize(x, y: integer);
begin
  inherited Resize(x, y);
  setRct(x, y, x, y);
end;

function TStrListHead.asString: String;
  var s: String; var tmp: TStrElement;
begin
  s:= '';
  tmp:= next;
  while tmp <> nil do begin
    s:= s + tmp.asString + ',';
    tmp:= tmp.next;
  end;
  Result:= copy(s, 1, length(s)-1);
end;

procedure TStrListHead.debug;
  var s: String; var tmp: TStrElement;
begin
  s:= 'TStrListHead Kind=' + IntToStr(kind) + ' Text=' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')';

  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  tmp:= next;
  while tmp <> nil do begin
    tmp.debug;
    tmp:= tmp.next;
  end;
end;

procedure TStrListHead.collapse;
  var cur: TStrElement;
begin
  cur:= next;
  while cur.next <> nil do
    if cur.next.text = '' then
      list.deleteElem(cur.next)
    else begin
      cur.next.collapse;
      cur:= cur.next;
    end;
  if (next.text = '') and assigned(next.next)
    then list.deleteElem(next)
    else next.Collapse;
end;

procedure TStrListHead.collapseCase;
  var cur: TStrElement;
begin
  cur:= next.next;
  while cur.next <> nil do
    if cur.next.text = '' then
      list.deleteElem(cur.next)
    else begin
      cur.next.collapse;
      cur:= cur.next;
    end;
  next.Collapse;
end;

(*******************************************************************************)
(*                                      LIST                                   *)
(*******************************************************************************)

constructor TStrList.create(Scrollbox: TScrollBox; Mode: integer; Font: TFont);
begin
  Kind:= Ord(nsList);
  text:= 'list head';
  LoadError:= false;
  list:= Self;
  Image:= TListImage.Create(ScrollBox, Self);
  Image.setBounds(100, 150, 400, 250);
  Image.AutoSize:= true;
  Image.Parent:= ScrollBox;
  Image.Canvas.Font.Assign(Font);
  Canvas:= Image.Canvas;
  SwitchWithCaseLine:= GuiPyOptions.SwitchWithCaseLine;
  setLineHeight;
  PuzzleMode:= Mode;
end;

destructor TStrList.Destroy;
var
  tmp: TStrElement;
begin
  while next <> nil do begin
    tmp:= next;
    next:= tmp.next;
    FreeAndNil(tmp);
  end;
  FreeAndNil(Image);
end;

procedure TStrList.Draw;
var
  h, xm, ym: Integer;
  tmp: TStrElement;
begin
  with Canvas do begin
    DrawLines(textPos.X, textPos.Y, LineHeight-TOP_BOTTOM);
    if text = GuiPyLanguageOptions.Algorithm + ' ' then begin
      h:= (LineHeight - 10) div 2;
      xm:= PenPos.x + TextHeight('X') div 2 + 5;
      ym:= PenPos.y + TextHeight('X') div 2;
      Ellipse(xm - h, ym - h, xm + h, ym + h);
      MoveTo(xm - h, ym + h);
      LineTo(xm + h, ym -h);
    end;
    tmp:= next;
    while tmp <> nil do begin  { paint all elements }
      tmp.Draw;
      tmp:= tmp.next;
    end;
  end;
end;

procedure TStrList.LoadFromStream(Stream: TStream; Version: byte);
var
  current, elem: TStrElement;
  aKind, count: Byte;
begin
  if Version >= $0E then
    rctList:= RectFromStream(Stream);
  Stream.Read(aKind, 1);  {overread StrList aKind }
  inherited LoadFromStream(Stream, Version); // read algorithm name
  FreeAndNil(next);
  current:= Self;
  count:= Stream.Read(aKind, 1);
  while (count = 1) and (aKind <> $FF) do begin
    elem:= getStatementFromKind(aKind, Self, Self);
    if elem = nil then exit;
    elem.LoadFromStream(Stream, Version);
    FreeAndNil(elem.next); {necessary for corrupted files !}
    list.Insert(current, elem);
    current:= elem;
    count:= Stream.Read(aKind, 1);
  end;
end;

procedure TStrList.LoadFromReader(Reader: TStringListReader);
  var current, elem: TStrElement;
begin
  Reader.ReadLine;   // RectPos [...]
  rctList:= Reader.aRect;
  Image.Left:= Reader.Point.X;
  Image.Top:= Reader.Point.Y;

  Reader.ReadLine;   // Algorithm or list head
  Text:= Reader.Text;
  rct:= Reader.aRect;
  TextPos:= Reader.Point;
  current:= Self;

  while Reader.nextLineIndent = 4 do begin
    Reader.ReadLine;
    elem:= getStatementFromReader(Reader, Self, Self);
    elem.LoadFromReader(Reader);
    list.Insert(current, elem);
    current:= elem;
  end;
end;

procedure TStrList.SaveToStream(Stream: TStream);
var
  tmp: TStrElement;
  tag: Byte;
begin
  RectToStream(Stream, rctList);
  inherited SaveToStream(Stream);
  tmp:= next;
  while tmp <> nil do begin
    tmp.SaveToStream(Stream);
    tmp:= tmp.next;
  end;
  tag:= $FF;
  Stream.Write(tag, 1);      {write end tag}
end;

function TStrList.getText(indent: string): string;
var
  tmp: TStrElement;
begin
  Result:= inherited getText(indent);
  tmp:= next;
  while tmp <> nil do begin
    Result:= Result + tmp.getText(indent + '  ');
    tmp:= tmp.next;
  end;
end;

function TStrList.getRectPos(Indent: string): string;
begin
  Result:= getRectPosAsText(Indent, rctList, Point(Image.Left, Image.Top));
end;

procedure TStrList.PaintShadow;
  var i, sw, t, b, d, SCol, ECol, sr, sg, sb, er, eg, eb: integer;
      R: TRect;

  function ColorGradient(i: integer): TColor;
    var r, g, b: integer;
  begin
    r:= sr + round(((er - sr)*i)/Sw);
    g:= sg + round(((eg - sg)*i)/Sw);
    b:= sb + round(((eb - sb)*i)/Sw);
    Result:= RGB(r, g, b);
  end;

begin
  if Kind = Byte(nsAlgorithm)
    then Sw:= GuiPyOptions.StructogramShadowWidth
    else Sw:= 0;
  if (sw = 0) or (next = nil) then exit;

  t:= rct.Bottom + Sw;
  b:= getHeight + 1 + Sw;
  d:= 2*Sw - (b - t);
  if d > 0 then
    t:= t - d;
  R:= Rect(Sw, t, next.rct.Right + Sw, b);

  Canvas.Pen.Mode:= pmCopy;
  SetColors;
  SCol:= ColorToRGB(Canvas.Brush.Color);
  sr:= GetRValue(SCol);
  sg:= GetGValue(SCol);
  sb:= getBValue(SCol);
  ECol:= ColorToRGB(Canvas.Pen.Color);
  er:= GetRValue(ECol);
  eg:= GetGValue(ECol);
  eb:= getBValue(ECol);
  for i:= 0 to Sw - 1 do begin
    Canvas.Pen.Color:= ColorGradient(i);
    Canvas.PolyLine([Point(R.Right - Sw + 1, R.Top + i),
                     Point(R.Right - i, R.Top + i),
                     Point(R.Right - i, R.Bottom - i - 1),
                     Point(R.Left + i, R.Bottom - i - 1),
                     Point(R.Left + i, R.Bottom - Sw - 1)]);
  end;
end;

procedure TStrList.Paint;
  var Bitmap: TBitmap;
      sw: integer;
begin
  if Kind = Byte(nsAlgorithm)
    then Sw:= GuiPyOptions.StructogramShadowWidth
    else Sw:= 0;

  Bitmap:= TBitmap.Create;
  try
    Canvas:= Bitmap.Canvas;
    Canvas.Font:= Image.Canvas.Font;
    Canvas.Pen:= Image.Canvas.Pen;
    SetColors;
    Bitmap.SetSize(getWidth + 1 + Sw, getHeight + 1 + Sw);
    Canvas.Fillrect(Rect(0, 0, bitmap.width, bitmap.height));
    PaintShadow;
    Draw;
    Image.Picture.Bitmap.Height:= Bitmap.Height;
    Image.Picture.Bitmap.Width := Bitmap.Width;

    // paint structogram on canvas
    Image.Canvas.Draw(0, 0, Bitmap);
    Canvas:= Image.Canvas;
  finally
    FreeAndNil(Bitmap);
  end;
end;

procedure TStrList.SetColors;
begin
  if StyleServices.IsSystemStyle then begin
    Canvas.Pen.Color:= clBlack;
    Canvas.Font.Color:= clBlack;
    Canvas.Brush.Color:= clWhite;
  end else begin
    Canvas.Pen.Color:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);  // clWhite
    Canvas.Font.Color:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
    Canvas.Brush.Color:= StyleServices.GetStyleColor(scPanel);
  end;
end;

procedure TStrList.Print;
begin
  Canvas:= Printer.Canvas;
  Draw;
end;

procedure TStrList.SetRctList(X1, Y1, X2, Y2: integer);
begin
  rctList.left := X1;
  rctList.top := Y1;
  rctList.right := X2;
  rctList.bottom := Y2;
end;

procedure TStrList.Resize(x, y: integer);
  var w: Integer;
begin
  w:= getWidthOfLines(text) + Canvas.Font.Size + 2*LEFT_RIGHT;
  SetRct(x, y, x + max(w, getDefaultRectWidth), y); // h = 0
end;

procedure TStrList.ResizeAll;
begin
  ResizeList(0, 0);
  setRct(0, 0, max(getWidthOfLines(text) + Canvas.Font.Size + 2*LEFT_RIGHT, rct.Right), rct.Bottom);
end;

function TStrList.getWidth: integer;
begin
  Result:= rct.Right - rct.Left;
end;

function TStrList.getHeight: integer;
begin
  Result:= Self.rctList.Bottom;
end;

procedure TStrList.insert(at, elem: TStrElement);
  // insert one element or a list of elements
  var tmp: TStrElement;
begin
  tmp:= at.next;
  at.next:= elem;
  elem.prev:= at;
  while (elem.next <> nil) and (elem.next <> elem) do
    elem:= elem.next;
  elem.next:= tmp;
  if assigned(tmp) then
    tmp.prev:= elem;
end;

procedure TStrList.deleteElem(elem: TStrElement);
  var p, n: TStrElement;
begin
  if elem = nil then exit;
  p:= elem.prev;
  if p = nil then begin
    FreeAndNil(elem);
    exit;
  end;
  n:= elem.next;
  p.next:= n;
  if n <> nil then
    n.prev:= p
  else if (p is TStrListHead) or (p is TStrCase) then
    insert(p, TStrStatement.create(list));
  elem.Destroy;
end;

procedure TStrList.getWidthHeigthOfText(const aText: string; var w, h: integer);
  var s, s1: String; p: integer;
begin
  w:= getDefaultRectWidth;
  h:= LineHeight;
  s:= aText;
  p:= Pos(#13#10, s);
  while p > 0 do begin
    s1:= copy(s, 1, p-1);
    delete(s, 1, p+1);
    w:= max(Image.Canvas.TextWidth(s1) + LEFT_RIGHT, w);
    h:= h + LineHeight;
    p:= Pos(#13#10, s);
  end;
  w:= max(Image.Canvas.TextWidth(s) + LEFT_RIGHT, w);
end;

function TStrList.getWidthOfOneLine(const aText: string): integer;
begin
  Result:= Image.Canvas.TextWidth(aText) + LEFT_RIGHT;
end;

function TStrList.getWidthOfLines(const aText: string): integer;
  var w, h: integer;
begin
  getWidthHeigthOfText(aText, w, h);
  Result:= w;
end;

procedure TStrList.setLineHeight;
begin
  LineHeight:= Canvas.TextHeight('X') + TOP_BOTTOM;
end;

function TStrList.asString: string;
  var s: String; tmp: TStrElement;
begin
  s:= text + ',';
  tmp:= next;
  while assigned(tmp) do begin
    s:= s + tmp.asString + ',';
    tmp:= tmp.next;
  end;
  Result:= copy(s, 1, length(s)-1);
end;

procedure TStrList.debug;
  var s: String; tmp: TStrElement;
begin
  s:= 'TStrList Kind=' + IntToStr(kind) + ' Text=' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')' +
      ' rctList(' + IntToStr(rctList.Left) + ', ' + IntToStr(rctList.Top) + ', ' + IntToStr(rctList.Width) + ', ' + IntToStr(rctList.Bottom) + ')';
  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);

  tmp:= next;
  while assigned(tmp) do begin
    tmp.debug;
    tmp:= tmp.next;
  end;
  MessagesWindow.AddMessage('-----------------------');
end;

procedure TStrList.setList(aList: TStrList);
  var tmp: TStrElement;
begin
  self.List:= aList;
  tmp:= next;
  while assigned(tmp) do begin
    tmp.setList(aList);
    tmp:= tmp.next;
  end;
end;

procedure TStrList.setPuzzleMode(Mode: integer);
begin
  PuzzleMode:= Mode;
end;

procedure TStrList.setFont(Font: TFont);
begin
  Canvas.Font.Assign(Font);
  setLineHeight;
end;

procedure TStrList.Collapse;
  var cur: TStrElement;
begin
  cur:= next;
  while cur <> nil do begin
    if cur.text = '' then begin
      deleteElem(cur);
      cur:= next;
    end else begin
      cur.collapse;
      cur:= cur.next;
    end;
  end;
end;

(******************************************************************************)
(*                                TStrAlgorithm                               *)
(******************************************************************************)

constructor TStrAlgorithm.create(Scrollbox: TScrollBox; Mode: integer; Font: TFont);
begin
  inherited create(Scrollbox, Mode, Font);
  text:= '';
  Kind:= Ord(nsAlgorithm);
end;

procedure TStrAlgorithm.Resize(x, y: integer);
var
  w, h, h1: Integer;
begin
  w:= getWidthOfLines(text) + Canvas.Font.Size + 2*LEFT_RIGHT;
  h:= getLines*(LineHeight - TOP_BOTTOM);
  h1:= Canvas.Font.Size div 2;             {height of bottom line}
  SetRct(x, y, x + max(w, getDefaultRectWidth), y + h + h1);
end;

function TStrAlgorithm.getAlgorithmName: string;
  var i: integer; s: string;
begin
  i:= Pos(GuiPyLanguageOptions.Algorithm + ' ', text);
  if i > 0
    then s:= copy(list.text, i + Length(GuiPyLanguageOptions.Algorithm + ' '), 255)
    else s:= text;
  i:= Pos('(', s);
  if i > 0 then
    delete(s, i, length(s));
  Result:= trim(s);
end;

function TStrAlgorithm.asString: String;
  var s: String; tmp: TStrElement;
begin
  s:=  text + '(';
  tmp:= next;
  while assigned(tmp) do begin
    s:= s + tmp.asString + ',';
    tmp:= tmp.next;
  end;
  Result:= copy(s, 1, length(s)-1);
end;

procedure TStrAlgorithm.debug;
  var s: String; tmp: TStrElement;
begin
  s:= 'TStrAlgorithm Kind=' + IntToStr(kind) + ' Text=' + text +
      ' rct(' + IntToStr(rct.Left) + ', ' + IntToStr(rct.Top) + ', ' + IntToStr(rct.Width) + ', ' + IntToStr(rct.Bottom) + ')' +
      ' rctList(' + IntToStr(rctList.Left) + ', ' + IntToStr(rctList.Top) + ', ' + IntToStr(rctList.Width) + ', ' + IntToStr(rctList.Bottom) + ')' +
      ' Image(' + IntTostr(Image.Left) + ', ' + IntToStr(Image.Top) + ')';

  if assigned(prev) and (prev.next <> Self) then
    s:= s + ' prev.next <> self';
  if assigned(next) and (next.prev <> Self) then
    s:= s + ' next.prev <> self';
  MessagesWindow.AddMessage(s);
  tmp:= next;
  while assigned(tmp) do begin
    tmp.debug;
    tmp:= tmp.next;
  end;
  MessagesWindow.AddMessage('-----------------------');
end;

(*******************************************************************************)
(*                                 TListImage                                  *)
(*******************************************************************************)

constructor TListImage.create(Scrollbox: TScrollBox; List: TStrList);
begin
  inherited create(ScrollBox);
  StrList:= List;
end;

end.
