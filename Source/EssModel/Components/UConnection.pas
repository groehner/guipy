{ -------------------------------------------------------------------------------
  Unit:     UConnection
  Author:   Gerhard Röhner
  Date:     2013
  Purpose:  connection in uml window
  ------------------------------------------------------------------------------- }

unit UConnection;

interface

uses
  Windows,
  Controls,
  Graphics;

type

  TFivePoints = array [1 .. 5] of TPoint;

  { A square is a parallelogram or trapez around a connection including
    the arrows, roles, relation and multiplicities.
  }

  TSquare = class
  private
    // Points[1] and Points[2] belong to FFromBorder
    // Points[3] and Points[4] belong to FToBorder
    FPoints: array [1 .. 4] of TPoint;
  public
    constructor Create;
    procedure Init;
    procedure EnlargeRight(FromCorner, ToCorner: Integer;
      DeltaX, DeltaY: Integer); overload;
    procedure EnlargeLeft(FromCorner, ToCorner: Integer;
      DeltaX, DeltaY: Integer); overload;
    function Prev(Corner: Integer): Integer;
    procedure EnlargeLeft(Corner, DeltaX: Integer); overload;
    procedure EnlargeRight(Corner, DeltaX: Integer); overload;
    procedure EnlargeTop(Corner, DeltaY: Integer);
    procedure EnlargeBottom(Corner, DeltaY: Integer);
    procedure Term(FFromBorder, FToBorder: TPoint); overload;
    procedure Term(Corner: Integer; FFivePoints: TFivePoints); overload;
    procedure Draw(FCanvas: TCanvas);
    function LineIntersectsLine(L1p1, L1p2, L2p1, L2p2: TPoint): Boolean;
    function Intersects(Point1, Point2: TPoint; Rect: TRect): Boolean; overload;
    function Intersects(Point1, Point2: TPoint; Square: TSquare)
      : Boolean; overload;
    function Intersects(Rect: TRect): Boolean; overload;
    function Intersects(Square: TSquare): Boolean; overload;
  end;

  // Available linestyles
  TEssConnectionStyle = (csThin, csNormal, csThinDash);

  // Different kinds of arrowheads
  TEssConnectionArrowStyle = (asAssociation1, asAssociation2, asAssociation3,
    asAggregation1, asAggregation2, asComposition1, asComposition2,
    asInheritends, asInstanceOf, asComment);

  TConnectionAttributes = class
  private
    FArrowStyle: TEssConnectionArrowStyle;
    FConnectStyle: TEssConnectionStyle;
    FIsEdited: Boolean;
    FIsTurned: Boolean;
    FMultiplicityA: string;
    FMultiplicityB: string;
    FReadingOrderA: Boolean;
    FReadingOrderB: Boolean;
    FRecursivCorner: Integer; // Corner position of recursiv connection
    FRelation: string;
    FRoleA: string;
    FRoleB: string;
    FVisible: Boolean;
  public
    property ArrowStyle: TEssConnectionArrowStyle read FArrowStyle
      write FArrowStyle;
    property ConnectStyle: TEssConnectionStyle read FConnectStyle;
    property IsEdited: Boolean read FIsEdited write FIsEdited;
    property MultiplicityA: string read FMultiplicityA write FMultiplicityA;
    property MultiplicityB: string read FMultiplicityB write FMultiplicityB;
    property ReadingOrderA: Boolean read FReadingOrderA write FReadingOrderA;
    property ReadingOrderB: Boolean read FReadingOrderB write FReadingOrderB;
    property RecursivCorner: Integer read FRecursivCorner write FRecursivCorner;
    property IsTurned: Boolean read FIsTurned write FIsTurned;
    property Relation: string read FRelation write FRelation;
    property RoleA: string read FRoleA write FRoleA;
    property RoleB: string read FRoleB write FRoleB;
    property Visible: Boolean read FVisible write FVisible;
  end;

  { Specifies a connection between two managed objects. }
  TConnection = class(TConnectionAttributes)
  private
    FBackgroundColor: TColor;
    FForegroundColor: TColor;
    FCanvas: TCanvas;
    FCutted: Boolean;
    FFromCenter: TPoint; // Center with parallel correction
    FToCenter: TPoint;
    FFromControl: TControl;
    FToControl: TControl;
    FSelected: Boolean;
    FFromBorder: TPoint; // start/ending on border of control
    FToBorder: TPoint;
    FFromBorderNum: Integer; // start is on right, FToBorder, left, bottom Side
    FIsRecursiv: Boolean;
    FToBorderNum: Integer; // end is on right, FToBorder, left, bottom Side
    FFivePoints: TFivePoints;
    // parallel connections
    FParallelCount: Integer;
    FParallelIndex: Integer;
    FParallelVisited: Boolean;
    FParallelVisiting: Boolean;
    FSquare: TSquare;
    FSVG: string;
    FXDecrease: Integer;
    FXEnlarge: Integer;
    FYDecrease: Integer;
    FYEnlarge: Integer;
  public
    constructor Create(Src, Dst: TControl; Attributes: TConnectionAttributes;
      Canvas: TCanvas);
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; Show: Boolean);
    procedure DrawRecursiv(Canvas: TCanvas; Show: Boolean);
    procedure DrawRecursivAnnotations(Canvas: TCanvas);
    procedure DrawSelection(Canvas: TCanvas; WithSelection: Boolean = True);
    procedure SetPenBrushArrow(Canvas: TCanvas);
    procedure CalcShortest;
    procedure CalcPolyline;
    function ArrowStartLength(Arrow: TEssConnectionArrowStyle): Integer;
    function ArrowHeadLength(Arrow: TEssConnectionArrowStyle): Integer;
    procedure SetAttributes(Attributes: TConnectionAttributes);
    procedure SetArrow(Arrow: TEssConnectionArrowStyle);
    procedure Turn;
    function IsClicked(Point: TPoint): Boolean;
    procedure SetRecursivPosition(Pos: Integer);
    procedure ParallelCorrection;
    function GetQuadrant(XPos, YPos: Integer; Rect: TRect): Integer;
    function CalcRect(Canvas: TCanvas; AMaxWidth: Integer;
      const AString: string): TRect;
    function GetBoundsRect(Control: TControl): TRect; overload;
    function GetCenter(Rect: TRect): TPoint;
    function ArrowToConnect(Arrow: TEssConnectionArrowStyle)
      : TEssConnectionStyle;
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function CalcSVGBaseLine(Rect: TRect): Integer;
    function GetSVGText(Rect: TRect; const Str: string): string;
    function GetSVGLine(X1Pos, Y1Pos, X2Pos, Y2Pos: Real): string;
    function GetSVGPolyline(Points: array of TPoint): string;
    function GetSVGPolygon(Points: array of TPoint; const Color: string): string;

    property Cutted: Boolean read FCutted write FCutted;
    property FromControl: TControl read FFromControl write FFromControl;
    property IsRecursiv: Boolean read FIsRecursiv;
    property ParallelCount: Integer read FParallelCount write FParallelCount;
    property ParallelIndex: Integer read FParallelIndex write FParallelIndex;
    property ParallelVisited: Boolean read FParallelVisited
      write FParallelVisited;
    property ParallelVisiting: Boolean read FParallelVisiting
      write FParallelVisiting;
    property Selected: Boolean read FSelected write FSelected;
    property Square: TSquare read FSquare;
    property SVG: string read FSVG;
    property ToControl: TControl read FToControl write FToControl;
    property XDecrease: Integer read FXDecrease;
    property XEnlarge: Integer read FXEnlarge;
    property YDecrease: Integer read FYDecrease;
    property YEnlarge: Integer read FYEnlarge;
  end;

implementation

uses
  Types,
  Math,
  Themes,
  UITypes,
  SysUtils,
  uCommonFunctions,
  UUtils;

const
  RecDx = 30; // recursive connections
  RecDc = 40; // recursiv distance FromCorner Corner
  HeadLength = 10; // pixels

  { --- TSquare ------------------------------------------------------------------ }

constructor TSquare.Create;
begin
  Init;
end;

procedure TSquare.Init;
begin
  for var I := 1 to 4 do
    FPoints[I] := Point(0, 0);
end;

procedure TSquare.EnlargeRight(FromCorner, ToCorner: Integer;
  DeltaX, DeltaY: Integer);
begin
  case FromCorner of
    1:
      FPoints[1].Y := Max(FPoints[1].Y, +DeltaY);
    2:
      FPoints[1].X := Max(FPoints[1].X, +DeltaX);
    3:
      FPoints[1].Y := Min(FPoints[1].Y, -DeltaY);
    4:
      FPoints[1].X := Min(FPoints[1].X, -DeltaX);
  end;
  case ToCorner of
    1:
      FPoints[4].Y := Min(FPoints[4].Y, -DeltaY);
    2:
      FPoints[4].X := Min(FPoints[4].X, -DeltaX);
    3:
      FPoints[4].Y := Max(FPoints[4].Y, +DeltaY);
    4:
      FPoints[4].X := Max(FPoints[4].X, +DeltaX);
  end;
end;

procedure TSquare.EnlargeLeft(FromCorner, ToCorner: Integer;
  DeltaX, DeltaY: Integer);
begin
  case FromCorner of
    1:
      FPoints[2].Y := Min(FPoints[2].Y, -DeltaY);
    2:
      FPoints[2].X := Min(FPoints[2].X, -DeltaX);
    3:
      FPoints[2].Y := Max(FPoints[2].Y, +DeltaY);
    4:
      FPoints[2].X := Max(FPoints[2].X, +DeltaX);
  end;
  case ToCorner of
    1:
      FPoints[3].Y := Max(FPoints[3].Y, +DeltaY);
    2:
      FPoints[3].X := Max(FPoints[3].X, +DeltaX);
    3:
      FPoints[3].Y := Min(FPoints[3].Y, -DeltaY);
    4:
      FPoints[3].X := Min(FPoints[3].X, -DeltaX);
  end;
end;

function TSquare.Prev(Corner: Integer): Integer;
begin
  Result := Corner - 1;
  if Result = 0 then
    Result := 4;
end;

procedure TSquare.EnlargeLeft(Corner, DeltaX: Integer);
var
  Int1, Int2: Integer;
begin
  Int1 := 1;
  Int2 := 4;
  for var I := 2 to Corner do
  begin
    Int1 := Prev(Int1);
    Int2 := Prev(Int2);
  end;
  FPoints[Int1].X := Min(FPoints[Int1].X, -DeltaX);
  FPoints[Int2].X := Min(FPoints[Int2].X, -DeltaX);
end;

procedure TSquare.EnlargeRight(Corner, DeltaX: Integer);
var
  Int1, Int2: Integer;
begin
  Int1 := 2;
  Int2 := 3;
  for var I := 2 to Corner do
  begin
    Int1 := Prev(Int1);
    Int2 := Prev(Int2);
  end;
  FPoints[Int1].X := Max(FPoints[Int1].X, DeltaX);
  FPoints[Int2].X := Max(FPoints[Int2].X, DeltaX);
end;

procedure TSquare.EnlargeTop(Corner, DeltaY: Integer);
var
  Int1, Int2: Integer;
begin
  Int1 := 3;
  Int2 := 4;
  for var I := 2 to Corner do
  begin
    Int1 := Prev(Int1);
    Int2 := Prev(Int2);
  end;
  FPoints[Int1].Y := Min(FPoints[Int1].Y, -DeltaY);
  FPoints[Int2].Y := Min(FPoints[Int2].Y, -DeltaY);
end;

procedure TSquare.EnlargeBottom(Corner, DeltaY: Integer);
var
  Int1, Int2: Integer;
begin
  Int1 := 1;
  Int2 := 2;
  for var I := 2 to Corner do
  begin
    Int1 := Prev(Int1);
    Int2 := Prev(Int2);
  end;
  FPoints[Int1].Y := Max(FPoints[Int1].Y, DeltaY);
  FPoints[Int2].Y := Max(FPoints[Int2].Y, DeltaY);
end;

procedure TSquare.Term(FFromBorder, FToBorder: TPoint);
begin
  FPoints[1].X := FFromBorder.X + FPoints[1].X;
  FPoints[1].Y := FFromBorder.Y + FPoints[1].Y;
  FPoints[2].X := FFromBorder.X + FPoints[2].X;
  FPoints[2].Y := FFromBorder.Y + FPoints[2].Y;
  FPoints[3].X := FToBorder.X + FPoints[3].X;
  FPoints[3].Y := FToBorder.Y + FPoints[3].Y;
  FPoints[4].X := FToBorder.X + FPoints[4].X;
  FPoints[4].Y := FToBorder.Y + FPoints[4].Y;
end;

procedure TSquare.Term(Corner: Integer; FFivePoints: TFivePoints);
begin
  for var I := 2 to 4 do
  begin
    FPoints[I].X := FFivePoints[I].X + FPoints[I].X;
    FPoints[I].Y := FFivePoints[I].Y + FPoints[I].Y;
  end;
  if Corner in [1, 3] then
  begin
    FPoints[1].X := FFivePoints[4].X + FPoints[1].X;
    FPoints[1].Y := FFivePoints[2].Y + FPoints[1].Y;
  end
  else
  begin
    FPoints[1].X := FFivePoints[2].X + FPoints[1].X;
    FPoints[1].Y := FFivePoints[4].Y + FPoints[1].Y;
  end;
end;

procedure TSquare.Draw(FCanvas: TCanvas);
begin
  FCanvas.Pen.Color := clYellow;
  {
    Canvas.MoveTo(FPoints[1].X, FPoints[1].Y);
    Canvas.LineTo(FPoints[4].X, FPoints[4].Y);
    Canvas.MoveTo(FPoints[2].X, FPoints[2].Y);
    Canvas.LineTo(FPoints[3].X, FPoints[3].Y);
  }
  FCanvas.MoveTo(FPoints[4].X, FPoints[4].Y);
  for var I := 1 to 4 do
    FCanvas.LineTo(FPoints[I].X, FPoints[I].Y);
end;

function TSquare.LineIntersectsLine(L1p1, L1p2, L2p1, L2p2: TPoint): Boolean;
var
  QVal, DVal, RVal, SVal: Double;
begin
  Result := False;
  QVal := (L1p1.Y - L2p1.Y) * (L2p2.X - L2p1.X) - (L1p1.X - L2p1.X) *
    (L2p2.Y - L2p1.Y);
  DVal := (L1p2.X - L1p1.X) * (L2p2.Y - L2p1.Y) - (L1p2.Y - L1p1.Y) *
    (L2p2.X - L2p1.X);
  if DVal = 0 then
    Exit;
  RVal := QVal / DVal;
  QVal := (L1p1.Y - L2p1.Y) * (L1p2.X - L1p1.X) - (L1p1.X - L2p1.X) *
    (L1p2.Y - L1p1.Y);
  SVal := QVal / DVal;
  if not((RVal <= 0) or (RVal >= 1) or (SVal <= 0) or (SVal >= 1)) then
    Result := True;
end;

function TSquare.Intersects(Point1, Point2: TPoint; Rect: TRect): Boolean;
begin
  Result := LineIntersectsLine(Point1, Point2, Point(Rect.Left, Rect.Top),
    Point(Rect.Right, Rect.Top)) or LineIntersectsLine(Point1, Point2,
    Point(Rect.Right, Rect.Top), Point(Rect.Right, Rect.Bottom)) or
    LineIntersectsLine(Point1, Point2, Point(Rect.Right, Rect.Bottom),
    Point(Rect.Left, Rect.Bottom)) or LineIntersectsLine(Point1, Point2,
    Point(Rect.Left, Rect.Bottom), Point(Rect.Left, Rect.Top));
end;

function TSquare.Intersects(Point1, Point2: TPoint; Square: TSquare): Boolean;
begin
  Result := LineIntersectsLine(Point1, Point2, Square.FPoints[1],
    Square.FPoints[2]) or LineIntersectsLine(Point1, Point2, Square.FPoints[2],
    Square.FPoints[3]) or LineIntersectsLine(Point1, Point2, Square.FPoints[3],
    Square.FPoints[4]) or LineIntersectsLine(Point1, Point2, Square.FPoints[4],
    Square.FPoints[1]);
end;

function TSquare.Intersects(Rect: TRect): Boolean;
begin
  Result := Intersects(FPoints[1], FPoints[2], Rect) or
    Intersects(FPoints[2], FPoints[3], Rect) or
    Intersects(FPoints[3], FPoints[4], Rect) or
    Intersects(FPoints[4], FPoints[1], Rect);
end;

function TSquare.Intersects(Square: TSquare): Boolean;
begin
  Result := Intersects(FPoints[1], FPoints[2], Square) or
    Intersects(FPoints[2], FPoints[3], Square) or
    Intersects(FPoints[3], FPoints[4], Square) or
    Intersects(FPoints[4], FPoints[1], Square);
end;

{ --- TConnection -------------------------------------------------------------- }

function TConnection.ArrowToConnect(Arrow: TEssConnectionArrowStyle)
  : TEssConnectionStyle;
begin
  case Arrow of
    asInheritends:
      Result := csNormal;
    asInstanceOf, asComment:
      Result := csThinDash;
  else
    Result := csThin;
  end;
end;

function TConnection.GetCenter(Rect: TRect): TPoint;
begin
  Result := Point((Rect.Left + Rect.Right) div 2,
    (Rect.Top + Rect.Bottom) div 2);
end;

procedure TConnection.SetPenBrushArrow(Canvas: TCanvas);
begin
  case FConnectStyle of
    csThin:
      begin
        Canvas.Pen.Width := 1;
        Canvas.Pen.Style := psSolid;
      end;
    csNormal:
      begin
        Canvas.Pen.Width := 3;
        Canvas.Pen.Style := psSolid;
      end;
    csThinDash:
      begin
        Canvas.Pen.Width := 1;
        Canvas.Pen.Style := psDash;
      end;
  end;
end;

function TConnection.GetQuadrant(XPos, YPos: Integer; Rect: TRect): Integer;
begin
  if YPos < (Rect.Top + Rect.Bottom) div 2 then
    if XPos < (Rect.Left + Rect.Right) div 2 then
      Result := 2
    else
      Result := 1
  else if XPos < (Rect.Left + Rect.Right) div 2 then
    Result := 3
  else
    Result := 4;
end;

procedure TConnection.Draw(Canvas: TCanvas; Show: Boolean);
var
  X1Pos, X2Pos: Integer;
  Y1Pos, Y2Pos: Integer;
  XBase: Integer;
  YBase: Integer;
  XLineDelta: Integer;
  XLineUnitDelta: Double;
  XNormalDelta: Integer;
  XNormalUnitDelta: Double;
  YLineDelta: Integer;
  YLineUnitDelta: Double;
  YNormalDelta: Integer;
  YNormalUnitDelta: Double;
  Tmp1: Double;
  DeltaX, DeltaY, D2X, D2Y, D1X, D1Y, D3X, D3Y, XRPos, YRPos, HLPPI: Integer;
  AbsXLineDelta, AbsYLineDelta: Integer;
  Rect2: TRect;
  MyRgn: HRGN;
  ConRect: TRect;
  PointArray: array of TPoint;

  function aCalcRect(Canvas: TCanvas; const AString: string): TRect;
  begin
    Result := Rect(0, 0, MaxInt, 0);
    DrawText(Canvas.Handle, PChar(AString), -1, Result, DT_CALCRECT or
      DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 4);
    Result.Top := 2;
  end;

  procedure ShowMultiplicity(Turned: Boolean; XRPos, YRPos: Integer;
    Rect2: TRect; const Multiplicity: string);
  var
    THeight, TWidth, Quadrant: Integer;
    Flags: LongInt;
    Rect: TRect;
  begin
    if Multiplicity = '' then
      Exit;
    Rect := aCalcRect(Canvas, Multiplicity);
    THeight := Rect.Bottom;
    TWidth := Rect.Right;

    Quadrant := GetQuadrant(XRPos, YRPos, Rect2);
    if Quadrant = 1 then
    begin
      // sofern der Schnittpunkt (XRPos/YRPos) auf der obere Rechtecklinie liegt
      // ihn auf die rechte Randlinie verschieben
      if XRPos < Rect2.Right then
      begin
        YRPos := YRPos - (Rect2.Right - XRPos) *
          AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Right;
      end;
      // ist die Korrektur zu groß
      if YRPos + THeight < Rect2.Top then
      begin
        // wird das Rechteck so verschoben, dass es auf der oberen Rechtecklinie aufliegt
        XRPos := Rect2.Right - (Rect2.Top - (YRPos + THeight)) *
          AbsXLineDelta div AbsYLineDelta + 10;
        YRPos := Rect2.Top - THeight;
      end;

    end
    else if Quadrant = 2 then
    begin
      // Bezugspunkt rechte obere Ecke
      if YRPos + THeight > Rect2.Top then
      begin
        // Ausgaberechteck nach oben verschieben
        XRPos := XRPos - ((YRPos + THeight) - Rect2.Top) *
          AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Top - THeight;
      end;
      if XRPos < Rect2.Left then
      begin
        // Ausgaberechteck nach rechts/unten verschieben
        YRPos := YRPos + (Rect2.Left - XRPos) * AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Left;
      end;
      XRPos := XRPos - TWidth; // left of connection
    end
    else if Quadrant = 3 then
    begin
      if YRPos < Rect2.Bottom then
      begin
        YRPos := YRPos + TWidth * AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Left - TWidth;
      end;
      if YRPos > Rect2.Bottom then
      begin
        XRPos := XRPos + (YRPos - Rect2.Bottom) *
          AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Bottom;
      end;
    end
    else if Quadrant = 4 then
    begin
      if YRPos < Rect2.Bottom then
      begin
        XRPos := XRPos + (Rect2.Bottom - YRPos) *
          AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Bottom;
      end;
      if XRPos - TWidth > Rect2.Right then
      begin
        YRPos := YRPos - ((XRPos - TWidth) - Rect2.Right) *
          AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Right + TWidth;
      end;
      XRPos := XRPos - TWidth; // left of connection
    end;
    OffsetRect(Rect, XRPos, YRPos);
    Flags := DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
    DrawText(Canvas.Handle, PChar(Multiplicity), -1, Rect, Flags);
    if not Turned and (Quadrant in [1, 4]) or Turned and (Quadrant in [2, 3])
    then
      Square.EnlargeRight(FFromBorderNum, FToBorderNum, TWidth + 15, THeight)
    else
      Square.EnlargeLeft(FFromBorderNum, FToBorderNum, TWidth + 15, THeight);
    FSVG := FSVG + GetSVGText(Rect, Multiplicity);
  end;

  procedure ShowRole(Turned: Boolean; XRPos, YRPos: Integer; Rect2: TRect;
    const Role: string);
  var
    THeight, TWidth, Quadrant: Integer;
    Flags: LongInt;
    Rect: TRect;
  begin
    if Role = '' then
      Exit;
    Rect := aCalcRect(Canvas, Role);
    THeight := Rect.Bottom;
    TWidth := Rect.Right;

    Quadrant := GetQuadrant(XRPos, YRPos, Rect2);
    if Quadrant = 1 then
    begin
      // Verschiebung nach oben, damit Strecke nicht geschnitten wird
      YRPos := YRPos - TWidth * AbsYLineDelta div AbsXLineDelta;
      if YRPos < Rect2.Top then
      begin
        XRPos := XRPos - (Rect2.Top - YRPos) * AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Top;
      end;
      YRPos := YRPos - THeight;
    end
    else if Quadrant = 2 then
    begin
      if YRPos > Rect2.Top then
      begin
        XRPos := XRPos - (YRPos - Rect2.Top) * AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Top;
      end;
      if XRPos + TWidth < Rect2.Left then
      begin
        YRPos := YRPos + (Rect2.Left - (XRPos + TWidth)) *
          AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Left - TWidth;
      end;
      YRPos := YRPos - THeight;
    end
    else if Quadrant = 3 then
    begin
      if XRPos > Rect2.Left then
      begin
        YRPos := YRPos + (XRPos - Rect2.Left) * AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Left;
      end;
      if YRPos > Rect2.Bottom + THeight then
      begin
        XRPos := XRPos - (Rect2.Bottom + THeight - YRPos) *
          AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Bottom + THeight;
      end;
      XRPos := XRPos - TWidth;
      YRPos := YRPos - THeight;
    end
    else if Quadrant = 4 then
    begin
      if XRPos < Rect2.Right then
      begin
        YRPos := YRPos + (Rect2.Right - XRPos) *
          AbsYLineDelta div AbsXLineDelta;
        XRPos := Rect2.Right;
      end;
      if YRPos > Rect2.Bottom + THeight then
      begin
        XRPos := XRPos - (YRPos - Rect2.Bottom - THeight) *
          AbsXLineDelta div AbsYLineDelta;
        YRPos := Rect2.Bottom + THeight;
      end;
      YRPos := YRPos - THeight;
    end;
    OffsetRect(Rect, XRPos, YRPos);
    Flags := DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
    DrawText(Canvas.Handle, PChar(Role), -1, Rect, Flags);
    if not Turned and (Quadrant in [1, 4]) or Turned and (Quadrant in [2, 3])
    then
      Square.EnlargeLeft(FFromBorderNum, FToBorderNum, TWidth + 15, THeight)
    else
      Square.EnlargeRight(FFromBorderNum, FToBorderNum, TWidth + 15, THeight);
    FSVG := FSVG + GetSVGText(Rect, Role);
  end;

  procedure ShowRelation(Rect2: TRect; DeltaX, DeltaY: Integer;
    FRelation: string);
  var
    Rect: TRect;
    TWidth, THeight, XBase, YBase, Quadrant: Integer;
    Alpha: Double;
  begin
    if FRelation = '' then
      Exit;
    YLineDelta := -YLineDelta;
    THeight := Canvas.TextHeight(FRelation);
    TWidth := Canvas.TextWidth(FRelation);
    XBase := (X1Pos + X2Pos) div 2;
    YBase := (Y1Pos + Y2Pos) div 2;

    Quadrant := GetQuadrant(XBase, YBase, Rect2);
    if Quadrant in [1, 3] then
      Rect := Bounds(XBase - Abs(DeltaX) - TWidth, YBase - 1 - THeight,
        TWidth, THeight)
    else
      Rect := Bounds(XBase + Abs(DeltaX), YBase - 1 - THeight, TWidth, THeight);

    if YLineDelta = 0 then
      Alpha := 0
    else
      Alpha := Round(RadToDeg(ArcTan2(Double(YLineDelta), Double(XLineDelta))));
    if (Abs(Alpha) < 25) or (Abs(Abs(Alpha) - 180) < 25) then
      Rect.Left := XBase + DeltaX - TWidth div 2;
    if Abs(Abs(Alpha) - 90) < 20 then
      Rect.Top := YBase + DeltaY - THeight div 2;

    // FCanvas.TextOut(R1.Left, R1.FToBorder, FRelation); doesn't Show Unicode characters well
    DrawText(Canvas.Handle, PChar(FRelation), -1, Rect, DT_CALCRECT);
    DrawText(Canvas.Handle, PChar(FRelation), -1, Rect, 0);
    if Quadrant in [1, 4] then
      Square.EnlargeLeft(FFromBorderNum, FToBorderNum,
        TWidth + Abs(DeltaX), THeight)
    else
      Square.EnlargeRight(FFromBorderNum, FToBorderNum,
        TWidth + Abs(DeltaX), THeight);
    FSVG := FSVG + GetSVGText(Rect, FRelation);
  end;

begin // of Draw
  if not FVisible then
    Exit;
  SetPenBrushArrow(Canvas);
  if Show then
  begin
    Canvas.Pen.Color := FForegroundColor;
    Canvas.Font.Color := FForegroundColor;
  end
  else
  begin
    Canvas.Pen.Color := FBackgroundColor;
    Canvas.Font.Color := FBackgroundColor;
  end;
  Canvas.Brush.Color := FBackgroundColor;

  if FIsRecursiv then
  begin
    DrawRecursiv(Canvas, Show);
    Exit;
  end;
  if IntersectRect(GetBoundsRect(FFromControl), GetBoundsRect(FToControl)) then
    Exit;

  ParallelCorrection; // use actual position, control might be moved
  CalcShortest;

  { --- Draw connection line --------------------------------------------------- }
  X1Pos := FFromBorder.X; // first point
  Y1Pos := FFromBorder.Y;
  X2Pos := FToBorder.X; // second point with arrow
  Y2Pos := FToBorder.Y;
  ConRect := Rect(Min(X1Pos, X2Pos), Min(Y1Pos, Y2Pos), Max(X1Pos, X2Pos) + 1,
    Max(Y1Pos, Y2Pos) + 1);
  DeltaX := Abs(X2Pos - X1Pos);
  if DeltaX < 3 then
    InflateRect(ConRect, 1, 0);
  DeltaY := Abs(Y2Pos - Y1Pos);
  if DeltaY < 3 then
    InflateRect(ConRect, 0, 1);

  Square.Init;
  XLineDelta := X2Pos - X1Pos;
  YLineDelta := Y2Pos - Y1Pos;

  AbsXLineDelta := Abs(XLineDelta);
  AbsYLineDelta := Abs(YLineDelta);
  if AbsXLineDelta = 0 then
    AbsXLineDelta := 1;
  if AbsYLineDelta = 0 then
    AbsYLineDelta := 1;

  if (XLineDelta = 0) and (YLineDelta = 0) then
    Exit; // Line has length 0
  if (AbsXLineDelta > 20000) or (AbsYLineDelta > 20000) then
    Exit; // Line is too long

  Tmp1 := Sqrt(Sqr(XLineDelta) + Sqr(YLineDelta));
  XLineUnitDelta := XLineDelta / Tmp1;
  YLineUnitDelta := YLineDelta / Tmp1;

  // just the line
  // clipping is necessary due to line width 3
  MyRgn := CreateRectRgn(ConRect.Left, ConRect.Top, ConRect.Right,
    ConRect.Bottom);
  SelectClipRgn(Canvas.Handle, MyRgn);

  FSVG := '<g>'#13#10;
  Canvas.MoveTo(X1Pos, Y1Pos);
  if FCanvas.Pen.Width = 1 then
  begin
    Canvas.LineTo(X2Pos, Y2Pos);
    Canvas.Pixels[X2Pos, Y2Pos] := Canvas.Pen.Color;
    FSVG := FSVG + GetSVGLine(X1Pos, Y1Pos, X2Pos, Y2Pos);
  end
  else
  begin
    Canvas.LineTo(X2Pos - Round(5 * XLineUnitDelta),
      Y2Pos - Round(5 * YLineUnitDelta));
    FSVG := FSVG + GetSVGLine(X1Pos, Y1Pos,
      X2Pos - SimpleRoundTo(5 * XLineUnitDelta, -1),
      Y2Pos - SimpleRoundTo(5 * YLineUnitDelta, -1));
    Insert('stroke-width="3" ', FSVG, Pos('/>', FSVG));
  end;
  if ArrowStyle in [asInstanceOf, asComment] then
    Insert('stroke-dasharray="1.5% 0.5%" ', FSVG, Pos('/>', FSVG));

  SelectClipRgn(Canvas.Handle, HRGN(nil));
  DeleteObject(MyRgn);

  XNormalDelta := YLineDelta;
  YNormalDelta := -XLineDelta;
  XNormalUnitDelta := XNormalDelta /
    Sqrt(Sqr(XNormalDelta) + Sqr(YNormalDelta));
  YNormalUnitDelta := YNormalDelta /
    Sqrt(Sqr(XNormalDelta) + Sqr(YNormalDelta));

  Canvas.Pen.Width := 1;
  Canvas.Pen.Style := psSolid;

  HLPPI := FFromControl.PPIScale(HeadLength);

  DeltaX := Round(HLPPI * XNormalUnitDelta);
  DeltaY := Round(HLPPI * YNormalUnitDelta);
  D1X := Round(HLPPI * XLineUnitDelta);
  D1Y := Round(HLPPI * YLineUnitDelta);
  D2X := Round(HLPPI * XLineUnitDelta * 2.0);
  D2Y := Round(HLPPI * YLineUnitDelta * 2.0);
  D3X := Round(HLPPI * XLineUnitDelta * 3.0);
  D3Y := Round(HLPPI * YLineUnitDelta * 3.0);

  case ArrowStyle of
    asAggregation1, asAggregation2:
      Canvas.Brush.Color := FBackgroundColor;
    asComposition1, asComposition2:
      if Show then
        Canvas.Brush.Color := FForegroundColor
      else
        Canvas.Brush.Color := FBackgroundColor;
  end;

  // (XBase, YBase) is where arrow line is perpendicular to base of triangle.
  XBase := X1Pos + Round(HLPPI * XLineUnitDelta);
  YBase := Y1Pos + Round(HLPPI * YLineUnitDelta);
  if ArrowStyle in [asAggregation1, asAggregation2, asComposition1,
    asComposition2, asAssociation3] then
    case FFromBorderNum of
      1, 3:
        begin
          ConRect.Bottom := max3(ConRect.Bottom, YBase + DeltaY,
            YBase - DeltaY);
          ConRect.Top := min3(ConRect.Top, YBase + DeltaY, YBase - DeltaY);
        end;
      2, 4:
        begin
          ConRect.Right := max3(ConRect.Right, XBase + DeltaX, XBase - DeltaX);
          ConRect.Left := min3(ConRect.Left, XBase + DeltaX, XBase - DeltaX);
        end;
    end;

  // Show aggregation and composition
  MyRgn := CreateRectRgn(ConRect.Left, ConRect.Top, ConRect.Right,
    ConRect.Bottom);
  SelectClipRgn(Canvas.Handle, MyRgn);
  if ArrowStyle in [asAggregation1, asAggregation2, asComposition1,
    asComposition2] then
  begin
    PointArray := [Point(X1Pos, Y1Pos), Point(XBase + DeltaX, YBase + DeltaY),
      Point(X1Pos + D2X, Y1Pos + D2Y), Point(XBase - DeltaX, YBase - DeltaY)];
    Canvas.Polygon(PointArray);
    if ArrowStyle in [asAggregation1, asAggregation2] then
      FSVG := FSVG + GetSVGPolygon(PointArray, 'white')
    else
      FSVG := FSVG + GetSVGPolygon(PointArray, 'black');

  end
  else if ArrowStyle = asAssociation3 then
  begin
    PointArray := [Point(XBase + DeltaX, YBase + DeltaY), Point(X1Pos, Y1Pos),
      Point(XBase - DeltaX, YBase - DeltaY)];
    Canvas.Polyline(PointArray);
    FSVG := FSVG + GetSVGPolyline(PointArray);
  end;
  SelectClipRgn(Canvas.Handle, HRGN(nil));
  DeleteObject(MyRgn);
  if not(ArrowStyle in [asAssociation1, asComment]) then
  begin
    Square.EnlargeLeft(FFromBorderNum, FToBorderNum, 22, 22);
    Square.EnlargeRight(FFromBorderNum, FToBorderNum, 22, 22);
  end;

  // Draw  arrow head
  Canvas.Brush.Color := FBackgroundColor;
  XBase := X2Pos - Round(HLPPI * XLineUnitDelta);
  YBase := Y2Pos - Round(HLPPI * YLineUnitDelta);
  if ArrowStyle in [asInheritends, asAssociation2, asAssociation3,
    asAggregation2, asComposition2, asInstanceOf] then
    case FToBorderNum of
      1, 3:
        begin
          ConRect.Bottom := max3(ConRect.Bottom, YBase + DeltaY,
            YBase - DeltaY);
          ConRect.Top := min3(ConRect.Top, YBase + DeltaY, YBase - DeltaY);
        end;
      2, 4:
        begin
          ConRect.Right := max3(ConRect.Right, XBase + DeltaX, XBase - DeltaX);
          ConRect.Left := min3(ConRect.Left, XBase + DeltaX, XBase - DeltaX);
        end;
    end;

  MyRgn := CreateRectRgn(ConRect.Left, ConRect.Top, ConRect.Right,
    ConRect.Bottom);
  SelectClipRgn(Canvas.Handle, MyRgn);
  case ArrowStyle of
    asInheritends:
      begin
        PointArray := [Point(X2Pos, Y2Pos),
          Point(XBase + DeltaX, YBase + DeltaY),
          Point(XBase - DeltaX, YBase - DeltaY)];
        Canvas.Polygon(PointArray);
        FSVG := FSVG + GetSVGPolygon(PointArray, 'white');
      end;
    asAssociation2, asAssociation3, asAggregation2, asComposition2,
      asInstanceOf:
      begin
        PointArray := [Point(XBase + DeltaX, YBase + DeltaY),
          Point(X2Pos, Y2Pos), Point(XBase - DeltaX, YBase - DeltaY)];
        Canvas.Polyline(PointArray);
        FSVG := FSVG + GetSVGPolyline(PointArray);
      end;
  end;
  SelectClipRgn(Canvas.Handle, HRGN(nil));
  DeleteObject(MyRgn);
  FSVG := FSVG + '</g>'#13#10;

  { --- Draw multiplicities and roles ------------------------------------------ }

  Rect2 := GetBoundsRect(FFromControl);
  if ArrowStyle in [asAggregation1, asAggregation2, asComposition1,
    asComposition2] then
  begin
    Inc(Rect2.Right, Abs(D3X));
    Dec(Rect2.Top, Abs(D3Y));
    Dec(Rect2.Left, Abs(D3X));
    Inc(Rect2.Bottom, Abs(D3Y));
    XRPos := X1Pos + D3X;
    YRPos := Y1Pos + D3Y;
  end
  else
  begin
    Inc(Rect2.Right, Abs(D1X));
    Dec(Rect2.Top, Abs(D1Y));
    Dec(Rect2.Left, Abs(D1X));
    Inc(Rect2.Bottom, Abs(D1Y));
    XRPos := X1Pos + D1X;
    YRPos := Y1Pos + D1Y;
  end;
  ShowMultiplicity(False, XRPos, YRPos, Rect2, FMultiplicityA);
  ShowRole(False, XRPos, YRPos, Rect2, FRoleA);

  ShowRelation(Rect2, DeltaX, DeltaY, FRelation);

  Rect2 := GetBoundsRect(FToControl);
  if ArrowStyle in [asAssociation2, asAssociation3, asAggregation2,
    asComposition2, asInheritends, asInstanceOf] then
  begin
    Inc(Rect2.Right, Abs(D2X));
    Dec(Rect2.Top, Abs(D2Y));
    Dec(Rect2.Left, Abs(D2X));
    Inc(Rect2.Bottom, Abs(D2Y));
    XRPos := X2Pos - D2X;
    YRPos := Y2Pos - D2Y;
  end
  else
  begin
    Inc(Rect2.Right, Abs(D1X));
    Dec(Rect2.Top, Abs(D1Y));
    Dec(Rect2.Left, Abs(D1X));
    Inc(Rect2.Bottom, Abs(D1Y));
    XRPos := X2Pos - D1X;
    YRPos := Y2Pos - D1Y;
  end;
  ShowMultiplicity(True, XRPos, YRPos, Rect2, FMultiplicityB);
  ShowRole(True, XRPos, YRPos, Rect2, FRoleB);
  DrawSelection(Canvas);
  Square.Term(FFromBorder, FToBorder);
  // Square.Draw(Canvas);
end;

procedure TConnection.DrawRecursiv(Canvas: TCanvas; Show: Boolean);

var
  PointArray: array of TPoint;
  HLPPI: Integer;

  procedure DrawArrowStart(Point1, Point2: TPoint);
  var
    Point3, Point4: TPoint;
    DeltaX, DeltaY: Integer;
  begin
    case ArrowStyle of
      asAssociation3:
        ;
      asAggregation1, asAggregation2:
        Canvas.Brush.Color := FBackgroundColor;
      asComposition1, asComposition2:
        if Show then
          Canvas.Brush.Color := FForegroundColor
        else
          Canvas.Brush.Color := FBackgroundColor;
    else
      Exit;
    end;
    DeltaX := Point2.X - Point1.X;
    DeltaY := Point2.Y - Point1.Y;
    if DeltaY = 0 then
    begin
      Point2.X := Point1.X + HLPPI * 2 * Sign(DeltaX);
      Point3.X := Point1.X + HLPPI * Sign(DeltaX);
      Point3.Y := Point1.Y - HLPPI;
      Point4.X := Point3.X;
      Point4.Y := Point1.Y + HLPPI;
    end
    else
    begin
      Point2.Y := Point1.Y + HLPPI * 2 * Sign(DeltaY);
      Point3.X := Point1.X + HLPPI;
      Point3.Y := Point1.Y + HLPPI * Sign(DeltaY);
      Point4.X := Point1.X - HLPPI;
      Point4.Y := Point3.Y;
    end;
    if ArrowStyle = asAssociation3 then
    begin
      PointArray := [Point3, Point1, Point4];
      Canvas.Polyline(PointArray);
      FSVG := FSVG + GetSVGPolyline(PointArray);
    end
    else
    begin
      PointArray := [Point1, Point3, Point2, Point4];
      Canvas.Polygon(PointArray);
      if ArrowStyle in [asAggregation1, asAggregation2] then
        FSVG := FSVG + GetSVGPolygon(PointArray, 'white')
      else
        FSVG := FSVG + GetSVGPolygon(PointArray, 'black');
    end;
    Canvas.Brush.Color := FBackgroundColor;
  end;

  procedure DrawArrowHead(Point1, Point2: TPoint);
  var
    Point3, Point4: TPoint;
    DeltaX, DeltaY: Integer;
  begin
    // if ArrowStyle in [asAssociation1, asAggregation1, asComposition1, asComment] then exit;
    DeltaX := Point2.X - Point1.X;
    DeltaY := Point2.Y - Point1.Y;
    if DeltaY = 0 then
    begin
      Point3.X := Point1.X + HLPPI * Sign(DeltaX);
      Point3.Y := Point1.Y - HLPPI;
      Point4.X := Point3.X;
      Point4.Y := Point1.Y + HLPPI;
    end
    else
    begin
      Point3.X := Point1.X + HLPPI;
      Point3.Y := Point1.Y + HLPPI * Sign(DeltaY);
      Point4.X := Point1.X - HLPPI;
      Point4.Y := Point3.Y;
    end;
    case ArrowStyle of
      asInheritends:
        begin
          PointArray := [Point1, Point3, Point4];
          Canvas.Polygon(PointArray);
          if ArrowStyle in [asAggregation1, asAggregation2] then
            FSVG := FSVG + GetSVGPolygon(PointArray, 'white')
          else
            FSVG := FSVG + GetSVGPolygon(PointArray, 'black');
        end;
      asAssociation2, asAssociation3, asAggregation2, asComposition2,
        asInstanceOf:
        begin
          PointArray := [Point3, Point1, Point4];
          Canvas.Polyline(PointArray);
          Canvas.Pixels[Point4.X, Point4.Y] := Canvas.Pen.Color;
          FSVG := FSVG + GetSVGPolyline(PointArray);
        end;
      asAssociation1, asAggregation1, asComposition1, asComment:
        begin
          PointArray := [Point1, Point2];
          Canvas.Polyline(PointArray);
          FSVG := FSVG + GetSVGPolyline(PointArray);
        end;
    end;
    Canvas.Brush.Color := FBackgroundColor;
  end;

begin
  HLPPI := FFromControl.PPIScale(HeadLength);
  CalcPolyline;
  if Show then
    Canvas.Pen.Color := FForegroundColor
  else
    Canvas.Pen.Color := FBackgroundColor;
  Canvas.Polyline(FFivePoints);
  FSVG := '<g>'#13#10 + GetSVGPolyline(FFivePoints);
  if ArrowStyle in [asInstanceOf, asComment] then
    Insert('stroke-dasharray="1.5% 0.5%" ', FSVG, Pos('/>', FSVG));

  Canvas.Pen.Width := 1;
  Canvas.Pen.Style := psSolid;
  if FIsTurned then
  begin
    DrawArrowStart(FFivePoints[5], FFivePoints[4]);
    DrawArrowHead(FFivePoints[1], FFivePoints[2]);
  end
  else
  begin
    DrawArrowStart(FFivePoints[1], FFivePoints[2]);
    DrawArrowHead(FFivePoints[5], FFivePoints[4]);
  end;
  FSVG := FSVG + '</g>'#13#10;
  DrawRecursivAnnotations(Canvas);
  DrawSelection(Canvas);
  Square.Term(FRecursivCorner, FFivePoints);
  // debugging
  // Square.Draw(FCanvas);
end;

procedure TConnection.DrawRecursivAnnotations(Canvas: TCanvas);
var
  Rect: TRect;
  X1Pos, Y1Pos, THeight, TWidth, ArrowLength1, ArrowLength2: Integer;
  Multiplicity1, Multiplicity2, RoleA, RoleB: string;
  Flags: LongInt;
begin
  Flags := DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
  X1Pos := 0;
  Y1Pos := 0;

  if FIsTurned then
  begin
    ArrowLength1 := ArrowHeadLength(ArrowStyle);
    ArrowLength2 := ArrowStartLength(ArrowStyle);
    Multiplicity1 := FMultiplicityB;
    Multiplicity2 := FMultiplicityA;
    RoleA := FRoleB;
    RoleB := FRoleA;
  end
  else
  begin
    ArrowLength1 := ArrowStartLength(ArrowStyle);
    ArrowLength2 := ArrowHeadLength(ArrowStyle);
    Multiplicity1 := FMultiplicityA;
    Multiplicity2 := FMultiplicityB;
    RoleA := FRoleA;
    RoleB := FRoleB;
  end;

  if Multiplicity1 <> '' then
  begin // Multiplicity A
    Rect := CalcRect(Canvas, MaxInt, Multiplicity1);
    case FRecursivCorner of
      1:
        begin
          X1Pos := FFivePoints[1].X + ArrowLength1 + 5;
          Y1Pos := FFivePoints[1].Y + 5;
        end;
      2:
        begin
          X1Pos := FFivePoints[2].X + 5;
          Y1Pos := FFivePoints[2].Y + 5;
        end;
      3:
        begin
          X1Pos := FFivePoints[2].X + 5;
          Y1Pos := FFivePoints[2].Y - Rect.Bottom - 5;
        end;
      4:
        begin
          X1Pos := FFivePoints[1].X - Rect.Right - 5;
          Y1Pos := FFivePoints[1].Y + ArrowLength1 + 5;
        end;
    end;
    OffsetRect(Rect, X1Pos, Y1Pos);
    DrawText(Canvas.Handle, PChar(Multiplicity1), -1, Rect, Flags);
    FSVG := FSVG + GetSVGText(Rect, Multiplicity1);
  end;

  if RoleA <> '' then
  begin // Role A
    Rect := CalcRect(Canvas, MaxInt, RoleA);
    case FRecursivCorner of
      1:
        begin
          X1Pos := FFivePoints[1].X + ArrowLength1 + 5;
          Y1Pos := FFivePoints[1].Y - Rect.Bottom - 5;
        end;
      2:
        begin
          X1Pos := FFivePoints[2].X - Rect.Right - 5;
          Y1Pos := FFivePoints[2].Y + 5;
        end;
      3:
        begin
          X1Pos := FFivePoints[2].X + 5;
          Y1Pos := FFivePoints[2].Y + 5;
        end;
      4:
        begin
          X1Pos := FFivePoints[1].X + 5;
          Y1Pos := FFivePoints[1].Y + ArrowLength1 + 5;
        end;
    end;
    OffsetRect(Rect, X1Pos, Y1Pos);
    DrawText(Canvas.Handle, PChar(RoleA), -1, Rect, Flags);
    FSVG := FSVG + GetSVGText(Rect, RoleA);
  end;

  if FRelation <> '' then
  begin // Relationname
    Rect := CalcRect(Canvas, MaxInt, FRelation);
    THeight := Rect.Bottom;
    TWidth := Rect.Right;
    case FRecursivCorner of
      1:
        begin
          X1Pos := (FFivePoints[3].X + FFivePoints[4].X) div 2 - TWidth div 2;
          Y1Pos := FFivePoints[3].Y - 5 - THeight;
          Inc(FYDecrease, 5 + THeight);
        end;
      2:
        begin
          X1Pos := (FFivePoints[2].X + FFivePoints[3].X) div 2 - TWidth div 2;
          Y1Pos := FFivePoints[2].Y - 5 - THeight;
          Inc(FYDecrease, 5 + THeight);
        end;
      3:
        begin
          X1Pos := (FFivePoints[3].X + FFivePoints[4].X) div 2 - TWidth div 2;
          Y1Pos := FFivePoints[3].Y + 5;
          Inc(FYEnlarge, 5 + THeight);
        end;
      4:
        begin
          X1Pos := (FFivePoints[2].X + FFivePoints[3].X) div 2 - TWidth div 2;
          Y1Pos := FFivePoints[3].Y + 5;
          Inc(FYEnlarge, 5 + THeight);
        end;
    else
      begin
        X1Pos := 0;
        Y1Pos := 0;
      end;
    end;
    OffsetRect(Rect, X1Pos, Y1Pos);
    DrawText(Canvas.Handle, PChar(FRelation), -1, Rect, Flags);
    FSVG := FSVG + GetSVGText(Rect, FRelation);
  end;

  if Multiplicity2 <> '' then
  begin // Multiplicity B
    Rect := CalcRect(Canvas, MaxInt, Multiplicity2);
    case FRecursivCorner of
      1:
        begin
          X1Pos := FFivePoints[4].X - Rect.Right - 5;
          Y1Pos := FFivePoints[4].Y + 5;
        end;
      2:
        begin
          X1Pos := FFivePoints[4].X + 5;
          Y1Pos := FFivePoints[4].Y + 5;
        end;
      3:
        begin
          X1Pos := FFivePoints[5].X + 5;
          Y1Pos := FFivePoints[5].Y + ArrowLength2 + 5;
        end;
      4:
        begin
          X1Pos := FFivePoints[5].X + ArrowLength2 + 5;
          Y1Pos := FFivePoints[5].Y - Rect.Bottom - 5;
        end;
    end;
    OffsetRect(Rect, X1Pos, Y1Pos);
    DrawText(Canvas.Handle, PChar(Multiplicity2), -1, Rect, Flags);
    FSVG := FSVG + GetSVGText(Rect, Multiplicity2);
  end;

  if RoleB <> '' then
  begin // Role B
    Rect := CalcRect(Canvas, MaxInt, RoleB);
    case FRecursivCorner of
      1:
        begin
          X1Pos := FFivePoints[4].X + 5;
          Y1Pos := FFivePoints[4].Y + 5;
        end;
      2:
        begin
          X1Pos := FFivePoints[4].X + 5;
          Y1Pos := FFivePoints[4].Y - Rect.Bottom - 5;
        end;
      3:
        begin
          X1Pos := FFivePoints[5].X - Rect.Right - 5;
          Y1Pos := FFivePoints[5].Y + ArrowLength2 + 5;
        end;
      4:
        begin
          X1Pos := FFivePoints[5].X + ArrowLength2 + 5;
          Y1Pos := FFivePoints[5].Y + 5;
        end;
    end;
    OffsetRect(Rect, X1Pos, Y1Pos);
    DrawText(Canvas.Handle, PChar(RoleB), -1, Rect, Flags);
    FSVG := FSVG + GetSVGText(Rect, RoleB);
  end;
end;

procedure TConnection.DrawSelection(Canvas: TCanvas;
  WithSelection: Boolean = True);

  function getRect(Point4: TPoint; Side: Integer): TRect;
  const
    CWidth = 5;
  begin
    case Side of
      1:
        Result := Rect(Point4.X, Point4.Y - CWidth, Point4.X + CWidth + 1,
          Point4.Y + CWidth + 1);
      2:
        Result := Rect(Point4.X - CWidth, Point4.Y - CWidth,
          Point4.X + CWidth + 1, Point4.Y + 1);
      3:
        Result := Rect(Point4.X - CWidth, Point4.Y - CWidth, Point4.X + 1,
          Point4.Y + CWidth + 1);
      4:
        Result := Rect(Point4.X - CWidth, Point4.Y, Point4.X + CWidth + 1,
          Point4.Y + CWidth);
    end;
  end;

begin
  { --- Show selection marks --------------------------------------------------- }
  if FSelected or not WithSelection then
  begin
    if WithSelection then
      Canvas.Brush.Color := FForegroundColor // clYellow
    else
      Canvas.Brush.Color := FBackgroundColor;
    Canvas.FillRect(getRect(FFromBorder, FFromBorderNum));
    Canvas.FillRect(getRect(FToBorder, FToBorderNum));
  end;
  Canvas.Brush.Color := FBackgroundColor;
end;

function TConnection.CalcRect(Canvas: TCanvas; AMaxWidth: Integer;
  const AString: string): TRect;
begin
  Result := Rect(0, 0, AMaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AString), -1, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX);
end;

procedure TConnection.CalcPolyline;
var
  Arrow1, Arrow2, Arrow3, Arrow4, X1Pos, Y1Pos, DeltaY, Left, Width, Top,
    Height, TextWidth, TextHeight, RRRb: Integer;
  RRA, RRB, RMA, RMB, RRR: TRect;
begin
  {
    P4-----P3
    |      |
    P5     |
    |
    Point1---Point2
  }
  if FIsTurned then
  begin
    Arrow1 := ArrowHeadLength(ArrowStyle);
    Arrow2 := ArrowStartLength(ArrowStyle);
    Arrow3 := Arrow1;
    if Arrow2 > 0 then
      Arrow4 := FFromControl.PPIScale(HeadLength)
    else
      Arrow4 := 0;
  end
  else
  begin
    Arrow1 := ArrowStartLength(ArrowStyle);
    Arrow2 := ArrowHeadLength(ArrowStyle);
    if Arrow1 > 0 then
      Arrow3 := FFromControl.PPIScale(HeadLength)
    else
      Arrow3 := 0;
    Arrow4 := Arrow2;
  end;

  DeltaY := Min(FFromControl.Height div 2, RecDc);
  Left := FFromControl.Left;
  Top := FFromControl.Top;
  Width := FFromControl.Width;
  Height := FFromControl.Height;
  case FRecursivCorner of
    1:
      begin
        FFromBorder := Point(Left + Width, Top + DeltaY);
        FToBorder := Point(Left + Width - RecDx, Top - 1);
      end;
    2:
      begin
        FFromBorder := Point(Left + RecDx, Top - 1);
        FToBorder := Point(Left - 1, Top + DeltaY);
      end;
    3:
      begin
        FFromBorder := Point(Left - 1, Top + Height - DeltaY);
        FToBorder := Point(Left + RecDx, Top + Height);
      end;
    4:
      begin
        FFromBorder := Point(Left + Width - RecDx, Top + Height);
        FToBorder := Point(Left + Width, Top + Height - DeltaY);
      end;
  end;
  FFromBorderNum := FRecursivCorner;
  FToBorderNum := FRecursivCorner + 1;
  if FToBorderNum = 5 then
    FToBorderNum := 1;

  X1Pos := FFromBorder.X;
  Y1Pos := FFromBorder.Y;

  FFivePoints[1] := FFromBorder;
  FFivePoints[5] := FToBorder;
  FXEnlarge := 0;
  FYEnlarge := 0;
  FXDecrease := 0;
  FYDecrease := 0;
  RRA := CalcRect(FCanvas, MaxInt, FRoleA);
  RRB := CalcRect(FCanvas, MaxInt, FRoleB);
  RMA := CalcRect(FCanvas, MaxInt, FMultiplicityA);
  RMB := CalcRect(FCanvas, MaxInt, FMultiplicityB);
  RRR := CalcRect(FCanvas, MaxInt, FRelation);
  if RRR.Bottom = 0 then
    RRRb := 2
  else
    RRRb := RRR.Bottom + 5;
  Square.Init;

  case FRecursivCorner of
    1:
      begin
        TextHeight := max3(RMB.Bottom, RRB.Bottom, RRA.Bottom - DeltaY) + 10;
        TextWidth := max3(RMA.Right, RRA.Right, RRB.Right - RecDx) + 10;
        FFivePoints[2] := Point(X1Pos + Arrow1 + TextWidth, Y1Pos);
        FFivePoints[3] := Point(FFivePoints[2].X, FFivePoints[5].Y - Arrow2 -
          TextHeight);
        FFivePoints[4] := Point(FFivePoints[5].X, FFivePoints[3].Y);
        FXEnlarge := FFivePoints[2].X - FFivePoints[1].X;
        FYDecrease := FFivePoints[5].Y - FFivePoints[4].Y;
        Square.EnlargeBottom(FRecursivCorner, Arrow3 + RMA.Bottom);
        Square.EnlargeLeft(FRecursivCorner, Arrow4 + RMB.Right);
        Square.EnlargeTop(FRecursivCorner, RRRb);
        Square.EnlargeRight(FRecursivCorner, 2);
      end;
    2:
      begin
        TextHeight := max3(RMA.Bottom, RRA.Bottom, RRB.Bottom - DeltaY) + 10;
        TextWidth := max3(RMB.Right, RRB.Right, RRA.Right - RecDx) + 10;
        FFivePoints[2] := Point(X1Pos, Y1Pos - Arrow1 - TextHeight);
        FFivePoints[3] := Point(FFivePoints[5].X - Arrow2 - TextWidth,
          FFivePoints[2].Y);
        FFivePoints[4] := Point(FFivePoints[3].X, FFivePoints[5].Y);
        FXDecrease := FFivePoints[5].X - FFivePoints[4].X;
        FYDecrease := FFivePoints[1].Y - FFivePoints[2].Y;
        Square.EnlargeRight(FRecursivCorner, Arrow3 + RMA.Right);
        Square.EnlargeBottom(FRecursivCorner, Arrow4 + RMB.Bottom);
        Square.EnlargeTop(FRecursivCorner, RRRb);
        Square.EnlargeLeft(FRecursivCorner, 2);
      end;
    3:
      begin
        TextHeight := max3(RMB.Bottom, RRB.Bottom, RRA.Bottom - DeltaY) + 10;
        TextWidth := max3(RMA.Right, RRA.Right, RRB.Right - RecDx) + 10;
        FFivePoints[2] := Point(X1Pos - Arrow1 - TextWidth, Y1Pos);
        FFivePoints[3] := Point(FFivePoints[2].X, FFivePoints[5].Y + Arrow2 +
          TextHeight);
        FFivePoints[4] := Point(FFivePoints[5].X, FFivePoints[3].Y);
        FXDecrease := FFivePoints[1].X - FFivePoints[2].X;
        FYEnlarge := FFivePoints[4].Y - FFivePoints[5].Y;
        Square.EnlargeTop(FRecursivCorner, Arrow3 + RMA.Bottom);
        Square.EnlargeRight(FRecursivCorner, Arrow4 + RMB.Right);
        Square.EnlargeBottom(FRecursivCorner, RRRb);
        Square.EnlargeLeft(FRecursivCorner, 2);
      end;
    4:
      begin
        TextHeight := max3(RMA.Bottom, RRA.Bottom, RRB.Bottom - DeltaY) + 10;
        TextWidth := max3(RMB.Right, RRB.Right, RRA.Right - RecDx) + 10;
        FFivePoints[2] := Point(X1Pos, Y1Pos + Arrow1 + TextHeight);
        FFivePoints[3] := Point(FFivePoints[5].X + Arrow2 + TextWidth,
          FFivePoints[2].Y);
        FFivePoints[4] := Point(FFivePoints[3].X, FFivePoints[5].Y);
        FXEnlarge := FFivePoints[4].X - FFivePoints[5].X;
        FYEnlarge := FFivePoints[2].Y - FFivePoints[1].Y;
        Square.EnlargeLeft(FRecursivCorner, Arrow3 + RMA.Right);
        Square.EnlargeTop(FRecursivCorner, Arrow4 + RMB.Bottom);
        Square.EnlargeBottom(FRecursivCorner, RRRb);
        Square.EnlargeRight(FRecursivCorner, 2);
      end;
  end;
end;

procedure TConnection.CalcShortest;

{ 2
  -------------
  |           |
  3 |           |  1
  |           |
  -------------
  4
}

  function CalcPointPos(Point: TPoint; Rect: TRect): Integer;
  begin
    if Point.X = Rect.Left - 1 then
      Result := 3
    else if Point.X = Rect.Right then
      Result := 1
    else if Point.Y = Rect.Top - 1 then
      Result := 2
    else if Point.Y = Rect.Bottom then
      Result := 4
    else
      Result := -1;
  end;

  function CalcIntersectionPoint(APoint, BPoint: TPoint; Rect: TRect): TPoint;
  var
    DeltaX, DeltaY: LongInt;
  begin
    Dec(Rect.Left); // intersection point must be outside rect
    Dec(Rect.Top);
    Result := APoint;
    DeltaX := BPoint.X - APoint.X;
    DeltaY := BPoint.Y - APoint.Y;
    if DeltaX <> 0 then
    begin
      if DeltaX > 0 then
        Result.X := Rect.Right
      else
        Result.X := Rect.Left;
      Result.Y := APoint.Y + Round(DeltaY * (Result.X - APoint.X) / DeltaX);
      if not((Rect.Top <= Result.Y) and (Result.Y <= Rect.Bottom)) then
      begin
        if Abs(Rect.Top - Result.Y) < Abs(Result.Y - Rect.Bottom) then
          Result.Y := Rect.Top
        else
          Result.Y := Rect.Bottom;
        if DeltaY <> 0 then
          Result.X := APoint.X + Round(DeltaX * (Result.Y - APoint.Y) / DeltaY);
      end;
    end
    else
    begin
      Result.X := APoint.X;
      if DeltaY > 0 then
        Result.Y := Rect.Bottom
      else
        Result.Y := Rect.Top;
    end;
    if Result.X > Rect.Right then
      Result.X := Rect.Right;
    if Result.X < Rect.Left then
      Result.X := Rect.Left;
  end;

begin
  FFromBorder := CalcIntersectionPoint(FFromCenter, FToCenter,
    GetBoundsRect(FFromControl));
  FFromBorderNum := CalcPointPos(FFromBorder, GetBoundsRect(FFromControl));
  FToBorder := CalcIntersectionPoint(FToCenter, FFromCenter,
    GetBoundsRect(FToControl));
  FToBorderNum := CalcPointPos(FToBorder, GetBoundsRect(FToControl));
end;

function TConnection.ArrowHeadLength(Arrow: TEssConnectionArrowStyle): Integer;
begin
  if Arrow in [asAssociation2, asAssociation3, asAggregation2, asComposition2,
    asInheritends, asInstanceOf] then
    Result := FFromControl.PPIScale(HeadLength)
  else
    Result := 0;
end;

function TConnection.ArrowStartLength(Arrow: TEssConnectionArrowStyle): Integer;
begin
  if Arrow in [asAggregation1, asAggregation2, asComposition1, asComposition2]
  then
    Result := FFromControl.PPIScale(HeadLength) * 2
  else if Arrow = asAssociation3 then
    Result := FFromControl.PPIScale(HeadLength)
  else
    Result := 0;
end;

constructor TConnection.Create(Src, Dst: TControl;
  Attributes: TConnectionAttributes; Canvas: TCanvas);
begin
  FFromControl := Src;
  FToControl := Dst;
  ArrowStyle := Attributes.ArrowStyle;
  FConnectStyle := ArrowToConnect(ArrowStyle);
  FRoleA := Attributes.FRoleA;
  FMultiplicityA := Attributes.FMultiplicityA;
  FReadingOrderA := Attributes.FReadingOrderA;
  FRelation := Attributes.FRelation;
  FReadingOrderB := Attributes.FReadingOrderB;
  FMultiplicityB := Attributes.FMultiplicityB;
  FRoleB := Attributes.FRoleB;
  FRecursivCorner := Attributes.FRecursivCorner;
  FIsTurned := Attributes.FIsTurned;
  FVisible := Attributes.FVisible;
  FIsEdited := Attributes.FIsEdited;
  FFromCenter := GetCenter(GetBoundsRect(FFromControl));
  FToCenter := GetCenter(GetBoundsRect(FToControl));
  FSquare := TSquare.Create;
  FIsRecursiv := (FFromControl = FToControl);
  FCanvas := Canvas;
  FSelected := False;
  FCutted := False;
  FXEnlarge := 0;
  FYEnlarge := 0;
  FFromBorderNum := -1;
  FToBorderNum := -1;
  ChangeStyle;
  if FIsRecursiv then
    CalcPolyline;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(Square);
  inherited;
end;

procedure TConnection.SetAttributes(Attributes: TConnectionAttributes);
begin
  FConnectStyle := ArrowToConnect(Attributes.ArrowStyle);
  ArrowStyle := Attributes.ArrowStyle;
  FRoleA := Attributes.FRoleA;
  FMultiplicityA := Attributes.FMultiplicityA;
  FReadingOrderA := Attributes.FReadingOrderA;
  FRelation := Attributes.FRelation;
  FReadingOrderB := Attributes.FReadingOrderB;
  FMultiplicityB := Attributes.FMultiplicityB;
  FRoleB := Attributes.FRoleB;
  if FIsRecursiv and (Attributes.FRecursivCorner <> 0) then
    FRecursivCorner := Attributes.FRecursivCorner;
  FIsEdited := Attributes.FIsEdited;
end;

procedure TConnection.SetArrow(Arrow: TEssConnectionArrowStyle);
begin
  FConnectStyle := ArrowToConnect(Arrow);
  ArrowStyle := Arrow;
end;

procedure TConnection.Turn;
var
  Src: TControl;
  Point: TPoint;
begin
  if FIsRecursiv then
  begin
    FIsTurned := not FIsTurned;
    CalcPolyline;
  end
  else
  begin
    Src := FFromControl;
    FFromControl := FToControl;
    FToControl := Src;
    Point := FFromBorder;
    FFromBorder := FToBorder;
    FToBorder := Point;
  end;
  FIsEdited := True;
end;

function TConnection.IsClicked(Point: TPoint): Boolean;
var
  APoint, BPoint, VectorAB, VectorAP, Normale: TPoint;
  XLineDelta, YLineDelta: Integer;
  Distance, CosAlpha: Real;
  ARect: TRect;

  function Scalarproduct(Point1, Point2: TPoint): Real;
  begin
    Result := Point1.X * Point2.X + Point1.Y * Point2.Y;
  end;

  function Norm(Vector: TPoint): Real;
  begin
    Result := Sqrt(Sqr(Vector.X) + Sqr(Vector.Y));
  end;

  function makeRect(Point1, Point2: TPoint): TRect;
  var
    DeltaX, DeltaY: Integer;
  begin
    DeltaX := Point2.X - Point1.X;
    DeltaY := Point2.Y - Point1.Y;
    if DeltaY = 0 then
      if DeltaX > 0 then
        Result := Rect(Point1.X, Point1.Y - 10, Point2.X + 10, Point2.Y + 10)
      else
        Result := Rect(Point2.X - 10, Point2.Y - 10, Point1.X, Point1.Y + 10)
    else // DeltaX = 0
      if DeltaY > 0 then
        Result := Rect(Point1.X - 10, Point1.Y, Point2.X + 10, Point2.Y + 10)
      else
        Result := Rect(Point2.X - 10, Point2.Y - 10, Point1.X + 10, Point1.Y);
  end;

begin
  Result := True;
  if FIsRecursiv then
  begin
    for var I := 1 to 3 do
    begin
      ARect := makeRect(FFivePoints[I], FFivePoints[I + 1]);
      if PtInRect(ARect, Point) then
        Exit;
    end;
    ARect := makeRect(FFivePoints[5], FFivePoints[4]);
    if PtInRect(ARect, Point) then
      Exit;
  end
  else
  begin
    APoint := FFromBorder;
    BPoint := FToBorder;
    XLineDelta := BPoint.X - APoint.X;
    YLineDelta := BPoint.Y - APoint.Y;
    if (XLineDelta = 0) and (YLineDelta = 0) then
    begin
      Result := False;
      Exit;
    end; // Line is 0 length
    if (Abs(XLineDelta) > 20000) or (Abs(YLineDelta) > 20000) then
      Exit; // Line is too long
    VectorAB.X := BPoint.X - APoint.X;
    VectorAB.Y := BPoint.Y - APoint.Y;
    VectorAP.X := Point.X - APoint.X;
    VectorAP.Y := Point.Y - APoint.Y;
    Normale.X := -VectorAB.Y;
    Normale.Y := VectorAB.X;
    if Norm(Normale) = 0 then
      Distance := 10000000
    else
      Distance := Abs(Scalarproduct(VectorAP, Normale) / Norm(Normale));
    CosAlpha := Scalarproduct(VectorAB, VectorAP);
    if (CosAlpha > 0) and (Distance < 10) and
      (Norm(VectorAP) <= Norm(VectorAB) + 10) then
      Exit;
  end;
  Result := False;
end;

procedure TConnection.SetRecursivPosition(Pos: Integer);
begin
  FRecursivCorner := Pos;
  CalcPolyline;
end;

procedure TConnection.ParallelCorrection;
var
  DeltaX, DeltaY, XLineDelta, YLineDelta, HLPPI: Integer;
  XLineUnitDelta, YLineUnitDelta, Tmp: Double;
  APoint, BPoint: TPoint;
begin
  APoint := GetCenter(GetBoundsRect(FFromControl));
  BPoint := GetCenter(GetBoundsRect(FToControl));
  XLineDelta := BPoint.X - APoint.X;
  YLineDelta := BPoint.Y - APoint.Y;
  if (XLineDelta = 0) and (YLineDelta = 0) then
    Exit; // Line has length 0
  if (Abs(XLineDelta) > 20000) or (Abs(YLineDelta) > 20000) then
    Exit; // Line is too long

  Tmp := Sqrt(Sqr(XLineDelta) + Sqr(YLineDelta));
  if Tmp = 0 then
  begin
    XLineUnitDelta := 0;
    YLineUnitDelta := 0;
  end
  else
  begin
    XLineUnitDelta := XLineDelta / Tmp;
    YLineUnitDelta := YLineDelta / Tmp;
  end;

  HLPPI := FFromControl.PPIScale(HeadLength);
  if FParallelCount > 0 then
    if Abs(XLineUnitDelta) > Abs(YLineUnitDelta) then
    begin
      DeltaY := -2 * (HLPPI + 2) * FParallelCount div 2 + 2 * (HLPPI + 2) *
        FParallelIndex;
      APoint.Y := APoint.Y + DeltaY;
      BPoint.Y := BPoint.Y + DeltaY;
    end
    else
    begin
      DeltaX := -2 * (HLPPI + 2) * FParallelCount div 2 + 2 * (HLPPI + 2) *
        FParallelIndex;
      APoint.X := APoint.X + DeltaX;
      BPoint.X := BPoint.X + DeltaX;
    end;
  FFromCenter := APoint;
  FToCenter := BPoint;
end;

function TConnection.GetBoundsRect(Control: TControl): TRect;
begin
  Result := Control.BoundsRect;
end;

procedure TConnection.ChangeStyle(BlackAndWhite: Boolean = False);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then
  begin
    FBackgroundColor := clWhite;
    FForegroundColor := clBlack;
  end
  else
  begin
    FBackgroundColor := StyleServices.GetStyleColor(scPanel);
    FForegroundColor := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal);
  end;
end;

function TConnection.CalcSVGBaseLine(Rect: TRect): Integer;
begin
  Result := Rect.Top + Round(1.0 * Abs(FCanvas.Font.Height));
end;

function TConnection.GetSVGText(Rect: TRect; const Str: string): string;
begin
  Result := '  <text x=' + IntToVal(Rect.Left) + ' y=' +
    IntToVal(CalcSVGBaseLine(Rect)) + ' white-space="pre-line">' + Str +
    '</text>'#13#10;
end;

function TConnection.GetSVGLine(X1Pos, Y1Pos, X2Pos, Y2Pos: Real): string;
begin
  Result := '  <line x1=' + FloatToVal(X1Pos) + ' y1=' + FloatToVal(Y1Pos) +
    ' x2=' + FloatToVal(X2Pos) + ' y2=' + FloatToVal(Y2Pos) +
    ' stroke="black" stroke-linecap="square" />'#13#10;
end;

function TConnection.GetSVGPolyline(Points: array of TPoint): string;
begin
  Result := '  <polyline points="';
  for var I := 0 to High(Points) do
    Result := Result + PointToVal(Points[I]);
  Result[Length(Result)] := '"';
  Result := Result + ' fill="none" stroke="black" />'#13#10;
end;

function TConnection.GetSVGPolygon(Points: array of TPoint;
  const Color: string): string;
begin
  Result := '  <polygon points="';
  for var I := 0 to High(Points) do
    Result := Result + PointToVal(Points[I]);
  Result[Length(Result)] := '"';
  Result := Result + ' fill="' + Color + '" stroke="black" />'#13#10;
end;

end.
