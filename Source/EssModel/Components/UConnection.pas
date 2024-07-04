{-------------------------------------------------------------------------------
 Unit:     UConnection
 Author:   Gerhard Röhner
 Date:     2013
 Purpose:  connection in uml window
-------------------------------------------------------------------------------}

unit UConnection;

interface

uses Windows, Controls, Graphics;

type

  TFivePoints = array[1..5] of TPoint;

  { A square is a parallelogram or trapez  around a connection including
    the arrows, roles, relation an multiplicities.
  }

  {  TControl = class(Controls.TControl)
       function getBoundsRect: TRect; virtual;
     end;
   }

  TSquare = class
    // Points[1] and Points[2] belong to FromP
    // Points[3] and Points[4] belong to ToP
    Points: array[1..4] of TPoint;
    constructor create;
    procedure init;
    procedure enlargeRight(von, bis: integer; dx, dy: integer); overload;
    procedure enlargeLeft(von, bis: integer; dx, dy: integer); overload;
    function prev(n: integer): integer;
    procedure enlargeLeft(corner, dx: integer); overload;
    procedure enlargeRight(corner, dx: integer); overload;
    procedure enlargeTop(corner, dy: integer);
    procedure enlargeBottom(corner, dy: integer);
    procedure term(FromP, ToP: TPoint); overload;
    procedure term(corner: integer; pl: TFivePoints); overload;
    procedure draw(aCanvas: TCanvas);
    function LineIntersectsLine(l1p1, l1p2, l2p1, l2p2: TPoint): boolean;
    function intersects(P1, P2: TPoint; R: TRect): boolean; overload;
    function intersects(P1, P2: TPoint; S: TSquare): boolean; overload;
    function intersects(R: TRect): boolean; overload;
    function intersects(S: TSquare): boolean; overload;
  end;

  // Available linestyles
  TessConnectionStyle = (csThin, csNormal, csThinDash);

  //Different kinds of arrowheads
  TessConnectionArrowStyle = (asAssociation1, asAssociation2, asAssociation3,
                              asAggregation1, asAggregation2,
                              asComposition1, asComposition2,
                              asInheritends,  asInstanceOf, asComment);

  TConnectionAttributes = class
  public
    ConnectStyle: TessConnectionStyle;
    ArrowStyle : TessConnectionArrowStyle;
    RoleA, Relation, RoleB: string;
    MultiplicityA, MultiplicityB: string;
    ReadingOrderA, ReadingOrderB: boolean;
    RecursivCorner: integer;  // corner position of recursiv connection
    isTurned: boolean;
    Visible: boolean;
    isEdited: boolean;
  end;

  { Specifies a connection between two managed objects. }
  TConnection = class (TConnectionAttributes)
  public
    Selected: Boolean;
    FFrom, FTo: TControl;
    FromCenter, ToCenter: TPoint;  // Center with parallel correction
    FromP, ToP: TPoint;  // start/ending on border of Control
    FromPStart: integer; // start is on right, top, left, bottom side
    ToPEnd: integer;     // end is on right, top, left, bottom side
    isRecursiv: boolean;
    // isEdited: boolean;
    pl: TFivePoints;
    XEnlarge: integer;
    YEnlarge: integer;
    XDecrease: integer;
    YDecrease: integer;
    // parallel connections
    parallelindex: integer;    // index of parallel connection
    parallelcount: integer;    // count of parallel connection
    parallelvisited: boolean;  // avoid to compare
    parallelvisiting: boolean;
    Canvas: TCanvas;
    Square: TSquare;
    Cutted: boolean;
    BGColor: TColor;
    FGColor: TColor;
    svg: string;
    constructor create(Src, Dst: TControl; Attributes: TConnectionAttributes; aCanvas: TCanvas);
    destructor Destroy; override;
    procedure Draw(aCanvas: TCanvas; show: boolean);
    procedure DrawRecursiv(aCanvas: TCanvas; show: boolean);
    procedure DrawRecursivAnnotations(aCanvas: TCanvas);
    procedure DrawSelection(aCanvas: TCanvas; WithSelection: boolean = true);
    procedure SetPenBrushArrow(aCanvas: TCanvas);
    procedure CalcShortest;
    procedure CalcPolyline;
    function ArrowStartLength(Arrow: TessConnectionArrowStyle): integer;
    function ArrowHeadLength(Arrow: TessConnectionArrowStyle): integer;
    procedure SetAttributes(Attributes: TConnectionAttributes);
    procedure SetArrow(Arrow: TessConnectionArrowStyle);
    procedure Turn;
    function IsClicked(P: TPoint): boolean;
    procedure setRecursivPosition(pos: integer);
    procedure parallelCorrection;
    function getQuadrant(x, y: integer; R: TRect): integer;
    function CalcRect(ACanvas: TCanvas; AMaxWidth: Integer; const AString: string): TRect;
    function getBoundsRect(arect: TRect): TRect; overload;
    function getBoundsRect(aControl: TControl): TRect; overload;
    function getCenter(R: TRect): TPoint;
    function ArrowToConnect(Arrow: TessConnectionArrowStyle): TessConnectionStyle;
    procedure ChangeStyle(BlackAndWhite: boolean = false);
    function calcSVGBaseLine(R: TRect): integer;
    function getSVGText(R: TRect; s: string): string;
    function getSVGLine(x1, y1, x2, y2: real): string;
    function getSVGPolyline(Points: array of TPoint): string;
    function getSVGPolygon(Points: array of TPoint; color: string): string;
    function getSVG: string;
  end;


implementation

uses Types, Math, Themes, UITypes, SysUtils, uCommonFunctions, UUtils;

const rec_dx = 30;  // recursive connections
      rec_dy = 23;
      rec_dc = 40; // recursiv distance from corner
  HeadLength = 10; // pixels

{--- TControl -----------------------------------------------------------------}

{function TControl.getBoundsRect: TRect;
  var aRect: TRect; //aBox: TRtfdBox;
begin
  aRect:= Self.BoundsRect;
  if (aControl is TRtfdBox) then begin
    aBox:= aControl as TRtfdBox;
    aRect.Width:= aRect.Width - aBox.ExtentX;
    aRect.Top:= aRect.Top + aBox.ExtentY;
  end;
  Result:= aRect;
end;
}

{--- TSquare ------------------------------------------------------------------}

constructor TSquare.create;
begin
  init;
end;

procedure TSquare.init;
  var i: integer;
begin
  for i:= 1 to 4 do
    Points[i]:= Point(0, 0);
end;

procedure TSquare.enlargeRight(von, bis: integer; dx, dy: integer);
begin
  case von of
    1: Points[1].y := max(Points[1].y, +dy);
    2: Points[1].x := max(Points[1].x, +dx);
    3: Points[1].y := min(Points[1].y, -dy);
    4: Points[1].x := min(Points[1].x, -dx);
  end;
  case bis of
    1: Points[4].y := min(Points[4].y, -dy);
    2: Points[4].x := min(Points[4].x, -dx);
    3: Points[4].y := max(Points[4].y, +dy);
    4: Points[4].x := max(Points[4].x, +dx);
  end;
end;

procedure TSquare.enlargeLeft(von, bis: integer; dx, dy: integer);
begin
  case von of
    1: Points[2].y := min(Points[2].y, -dy);
    2: Points[2].x := min(Points[2].x, -dx);
    3: Points[2].y := max(Points[2].y, +dy);
    4: Points[2].x := max(Points[2].x, +dx);
  end;
  case bis of
    1: Points[3].y := max(Points[3].y, +dy);
    2: Points[3].x := max(Points[3].x, +dx);
    3: Points[3].y := min(Points[3].y, -dy);
    4: Points[3].x := min(Points[3].x, -dx);
  end;
end;

function TSquare.prev(n: integer): integer;
begin
  Result:= n - 1;
  if Result = 0 then
    Result:= 4;
end;

procedure TSquare.enlargeLeft(corner, dx: integer);
  var i, i1, i2: integer;
begin
  i1:= 1;
  i2:= 4;
  for i:= 2 to corner do begin
    i1:= prev(i1);
    i2:= prev(i2);
  end;
  Points[i1].x:= min(Points[i1].x, -dx);
  Points[i2].x:= min(Points[i2].x, -dx);
end;

procedure TSquare.enlargeRight(corner, dx: integer);
  var i, i1, i2: integer;
begin
  i1:= 2;
  i2:= 3;
  for i:= 2 to corner do begin
    i1:= prev(i1);
    i2:= prev(i2);
  end;
  Points[i1].x:= max(Points[i1].x, dx);
  Points[i2].x:= max(Points[i2].x, dx);
end;

procedure TSquare.enlargeTop(corner, dy: integer);
  var i, i1, i2: integer;
begin
  i1:= 3;
  i2:= 4;
  for i:= 2 to corner do begin
    i1:= prev(i1);
    i2:= prev(i2);
  end;
  Points[i1].y:= min(Points[i1].y, -dy);
  Points[i2].y:= min(Points[i2].y, -dy);
end;

procedure TSquare.enlargeBottom(corner, dy: integer);
  var i, i1, i2: integer;
begin
  i1:= 1;
  i2:= 2;
  for i:= 2 to corner do begin
    i1:= prev(i1);
    i2:= prev(i2);
  end;
  Points[i1].y:= max(Points[i1].y, dy);
  Points[i2].y:= max(Points[i2].y, dy);
end;

procedure TSquare.Term(FromP, ToP: TPoint);
begin
  Points[1].x := FromP.x + Points[1].x;
  Points[1].y := FromP.y + Points[1].y;
  Points[2].x := FromP.x + Points[2].x;
  Points[2].y := FromP.y + Points[2].y;
  Points[3].x := ToP.x + Points[3].x;
  Points[3].y := ToP.y + Points[3].y;
  Points[4].x := ToP.x + Points[4].x;
  Points[4].y := ToP.y + Points[4].y;
end;

procedure TSquare.Term(corner: integer; Pl: TFivePoints);
  var i: integer;
begin
  for i:= 2 to 4 do begin
    Points[i].x:= Pl[i].x + Points[i].x;
    Points[i].y:= Pl[i].y + Points[i].Y;
  end;
  if corner in [1, 3] then begin
    Points[1].x:= Pl[4].x + Points[1].x;
    Points[1].y:= Pl[2].y + Points[1].y;
  end else begin
    Points[1].x:= Pl[2].x + Points[1].x;
    Points[1].y:= Pl[4].y + Points[1].y;
  end;
end;

procedure TSquare.Draw(aCanvas: TCanvas);
  var i: integer;
begin
  aCanvas.Pen.Color:= clYellow;

  {
  aCanvas.moveTo(Points[1].x, Points[1].y);
  aCanvas.lineTo(Points[4].x, Points[4].y);
  aCanvas.moveTo(Points[2].x, Points[2].y);
  aCanvas.lineTo(Points[3].x, Points[3].y);
  }
  aCanvas.moveTo(Points[4].x, Points[4].y);
  for i:= 1 to 4 do
    aCanvas.lineTo(Points[i].x, Points[i].y);

end;

function TSquare.LineIntersectsLine(l1p1, l1p2, l2p1, l2p2: TPoint): boolean;
  var q, d, r, s: double;
begin
  Result:= false;
  q:= (l1p1.Y - l2p1.Y) * (l2p2.X - l2p1.X) - (l1p1.X - l2p1.X) * (l2p2.Y - l2p1.Y);
  d:= (l1p2.X - l1p1.X) * (l2p2.Y - l2p1.Y) - (l1p2.Y - l1p1.Y) * (l2p2.X - l2p1.X);
  if d = 0 then exit;
  r:= q / d;
  q:= (l1p1.Y - l2p1.Y) * (l1p2.X - l1p1.X) - (l1p1.X - l2p1.X) * (l1p2.Y - l1p1.Y);
  s:= q / d;
  if not ((r <= 0) or (r >= 1) or (s <= 0) or (s >= 1))
    then Result:= true;
end;

function TSquare.Intersects(P1, P2: TPoint; R: TRect): Boolean;
begin
  Result:=
    LineIntersectsLine(P1, P2, Point(R.Left, R.Top), Point(R.Right, R.Top)) or
    LineIntersectsLine(P1, P2, Point(R.Right, R.Top), Point(R.Right, R.Bottom)) or
    LineIntersectsLine(P1, P2, Point(R.Right, R.Bottom), Point(R.Left, R.Bottom)) or
    LineIntersectsLine(P1, P2, Point(R.Left, R.Bottom), Point(R.Left, R.Top));
end;

function TSquare.Intersects(P1, P2: TPoint; S: TSquare): Boolean;
begin
  Result:=
    LineIntersectsLine(P1, P2, S.Points[1], S.Points[2]) or
    LineIntersectsLine(P1, P2, S.Points[2], S.Points[3]) or
    LineIntersectsLine(P1, P2, S.Points[3], S.Points[4]) or
    LineIntersectsLine(P1, P2, S.Points[4], S.Points[1]);
end;

function TSquare.intersects(R: TRect): boolean;
begin
  Result:=
    Intersects(Points[1], Points[2], R) or
    Intersects(Points[2], Points[3], R) or
    Intersects(Points[3], Points[4], R) or
    Intersects(Points[4], Points[1], R);
end;

function TSquare.intersects(S: TSquare): boolean;
begin
  Result:=
    Intersects(Points[1], Points[2], S) or
    Intersects(Points[2], Points[3], S) or
    Intersects(Points[3], Points[4], S) or
    Intersects(Points[4], Points[1], S);
end;

{--- TConnection --------------------------------------------------------------}

function TConnection.ArrowToConnect(Arrow: TessConnectionArrowStyle): TessConnectionStyle;
begin
  case Arrow of
    asInheritends: Result:= csNormal;
    asInstanceOf,
    asComment :    Result:= csThinDash;
    else           Result:= csThin;
  end;
end;

function TConnection.getCenter(R: TRect): TPoint;
begin
  Result:= Point((R.Left + R.Right) div 2, (R.Top + R.Bottom) div 2);
end;

procedure TConnection.SetPenBrushArrow(aCanvas: TCanvas);
begin
  case ConnectStyle of
    csThin: begin
        aCanvas.Pen.Width := 1;
        aCanvas.Pen.Style := psSolid;
      end;
    csNormal: begin
        aCanvas.Pen.Width := 3;
        aCanvas.Pen.Style := psSolid;
      end;
    csThinDash: begin
        aCanvas.Pen.Width := 1;
        aCanvas.Pen.Style := psDash;
      end;
  end;
end;

function TConnection.getQuadrant(x, y: integer; R: TREct): integer;
begin
  if y < (R.Top + R.Bottom) div 2 then
    if x < (R.Left + R.Right) div 2
      then Result:= 2
      else Result:= 1
  else
    if x < (R.Left + R.Right) div 2
      then Result:= 3
      else Result:= 4;
end;

procedure TConnection.Draw(aCanvas: TCanvas; show: boolean);
  var
    x1, x2: Integer;
    y1, y2: Integer;
    xbase: Integer;
    ybase: Integer;
    xLineDelta: Integer;
    xLineUnitDelta: Double;
    xNormalDelta: Integer;
    xNormalUnitDelta: Double;
    yLineDelta: Integer;
    yLineUnitDelta: Double;
    yNormalDelta: Integer;
    yNormalUnitDelta: Double;
    Tmp1: double;
    dx, dy, d2x, d2y, d1x, d1y, d3x, d3y, xr, yr, hl: Integer;
    absXLineDelta, absYLineDelta: Integer;
    R2: TRect;
    MyRgn: HRGN;
    ConRect: TRect;
    PointArray: array of TPoint;

  function aCalcRect(ACanvas: TCanvas; const AString: string): TRect;
  begin
    Result := Rect(0, 0, MaxInt, 0);
    DrawText(ACanvas.Handle, PChar(AString), -1, Result, DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 4);
    Result.Top:= 2;
  end;

  procedure ShowMultiplicity(turned: boolean; xr, yr: integer; R2: TRect; const Multiplicity: string);
    var th, tw, Quadrant: integer; Flags: longint; R: TRect;
  begin
    if Multiplicity = '' then exit;
    R:= aCalcRect(aCanvas, Multiplicity);
    th:= R.Bottom;
    tw:= R.Right;

    Quadrant:= getQuadrant(xr, yr, R2);
    if Quadrant = 1 then begin
      // sofern der Schnittpunkt (xr/yr) auf der obere Rechtecklinie liegt
      // ihn auf die rechte Randlinie verschieben
      if xr < R2.Right then begin
        yr:= yr - (R2.Right - xr)*absYLineDelta div absXLineDelta;
        xr:= R2.Right;
      end;
      // ist die Korrektur zu groß
      if yr + th < R2.Top then begin
        // wird das Rechteck so verschoben, dass es auf der oberen Rechtecklinie aufliegt
        xr:= R2.Right - (R2.Top - (yr + th))*absXLineDelta div absYLineDelta +10;
        yr:= R2.Top - th;
      end;

    end else if Quadrant = 2 then begin
      // Bezugspunkt rechte obere Ecke
      if yr + th > R2.Top then begin
        // Ausgaberechteck nach oben verschieben
        xr:= xr - ((yr + th) - R2.Top)*absXLineDelta div absYLineDelta;
        yr:= R2.Top - th;
      end;
      if xr < R2.Left then begin
        // Ausgaberechteck nach rechts/unten verschieben
        yr:= yr + (R2.Left - xr)*absYLineDelta div absXLineDelta;
        xr:= R2.Left;
      end;
      xr:= xr - tw; // links von der Verbindung
    end else if Quadrant = 3 then begin
      if yr < R2.Bottom then begin
        yr:= yr + tw*absYLineDelta div absXLineDelta;
        xr:= R2.Left - tw;
      end;
      if yr > R2.Bottom then begin
        xr:= xr + (yr - R2.Bottom)*absXLineDelta div absYLineDelta;
        yr:= R2.Bottom;
     end;
    end else if Quadrant = 4 then begin
      if yr < R2.Bottom then begin
        xr:= xr + (R2.Bottom - yr)* absXLineDelta div absYLineDelta;
        yr:= R2.Bottom;
      end;
      if xr - tw > R2.Right then begin
         yr:= yr - ((xr -tw) - R2.Right)*absYLineDelta div absXLineDelta;
         xr:= R2.Right + tw;
      end;
      xr:= xr - tw; // links von der Verbindung
    end;
    OffsetRect(R, xr, yr);
    Flags:= DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
    DrawText(aCanvas.Handle, PChar(Multiplicity), -1, R, Flags);
    if not turned and (Quadrant in [1, 4]) or turned and (Quadrant in [2, 3])
      then Square.enlargeRight(FromPStart, ToPEnd, tw + 15, th)
      else Square.enlargeLeft(FromPStart, ToPEnd, tw + 15, th);
    svg:= svg + getSVGText(R, Multiplicity);
  end;

  procedure ShowRole(turned: boolean; xr, yr: integer; R2: TRect; const Role: string);
    var th, tw, Quadrant: integer; Flags: longint; R: TRect;
  begin
    if Role = '' then exit;
    R:= aCalcRect(aCanvas, Role);
    th:= R.Bottom;
    tw:= R.Right;

    Quadrant:= getQuadrant(xr, yr, R2);
    if Quadrant = 1 then begin
      // Verschiebung nach oben, damit Strecke nicht geschnitten wird
      yr:= yr - tw*absYLineDelta div absXLineDelta;
      if yr < R2.Top then begin
        xr:= xr - (R2.Top - yr)*absXLineDelta div absYLineDelta;
        yr:= R2.Top;
      end;
      yr:= yr - th;
    end else if Quadrant = 2 then begin
      if yr > R2.Top then begin
        xr:= xr - (yr - R2.Top)*absXLineDelta div absYLineDelta;
        yr:= R2.Top;
      end;
      if xr + tw < R2.Left then begin
        yr:= yr + (R2.Left - (xr + tw))* absYLineDelta div absXLineDelta;
        xr:= R2.Left - tw;
      end;
      yr:= yr - th;
    end else if Quadrant = 3 then begin
      if xr > R2.Left then begin
        yr:= yr + (xr - R2.Left)*absYLineDelta div absXLineDelta;
        xr:= R2.Left;
      end;
      if yr > R2.Bottom + th then begin
        xr:= xr - (R2.Bottom +th - yr)*absXLineDelta div absYLineDelta;
        yr:= R2.Bottom + th;
      end;
      xr:= xr - tw;
      yr:= yr - th;
    end else if Quadrant = 4 then begin
      if xr < R2.Right then begin
        yr:= yr + (R2.Right - xr)*absYLineDelta div absXLineDelta;
        xr:= R2.Right;
      end;
      if yr > R2.Bottom + th then begin
        xr:= xr - (yr - R2.Bottom -th)*absXLineDelta div absYLineDelta;
        yr:= R2.Bottom + th;
      end;
      yr:= yr - th;
    end;
    OffsetRect(R, xr, yr);
    Flags:= DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
    DrawText(aCanvas.Handle, PChar(Role), -1, R, Flags);
    if not turned and (Quadrant in [1, 4]) or turned and (Quadrant in [2, 3])
      then Square.enlargeLeft(FromPStart, ToPEnd, tw + 15, th)
      else Square.enlargeRight(FromPStart, ToPEnd, tw + 15, th);
    svg:= svg + getSVGText(R, Role);
  end;

  procedure ShowRelation(R2: TRect; dx, dy: integer; Relation: string);
    var R: TRect; tw, th, xBase, yBase, Quadrant: integer; alpha: double;
  begin
    if Relation = '' then exit;
    yLineDelta:= - yLineDelta;
    th:= aCanvas.TextHeight(Relation);
    tw:= aCanvas.TextWidth(Relation);
    xBase:= (x1 + x2) div 2;
    yBase:= (y1 + y2) div 2;

    Quadrant:= getQuadrant(xBase, yBase, R2);
    if Quadrant in [1, 3]
      then R:= Bounds(xBase - abs(dx) - tw, yBase -1 - th, tw, th)
      else R:= Bounds(xBase + abs(dx), yBase -1 - th, tw, th);

    if yLineDelta = 0
      then alpha:= 0
      else alpha:= Round(RadToDeg(arctan2(yLineDelta, xLineDelta)));
    if (abs(alpha) < 25) or (abs(abs(alpha)-180) < 25) then
      R.Left:= xBase + dx - tw div 2;
    if abs(abs(alpha)-90) < 20 then
      R.Top:= yBase + dy - th div 2;

    //   Canvas.TextOut(R1.Left, R1.Top, Relation); doesn't show Unicode characters well
    DrawText(aCanvas.Handle, PChar(Relation), -1, R, DT_CALCRECT);
    DrawText(aCanvas.Handle, PChar(Relation), -1, R, 0);
    if Quadrant in [1, 4]
      then Square.enlargeLeft(FromPStart, ToPEnd, tw + abs(dx), th)
      else Square.enlargeRight(FromPStart, ToPEnd, tw + abs(dx), th);
    svg:= svg + getSVGText(R, Relation);
  end;

begin  // of draw
  if not visible then exit;
  SetPenBrushArrow(aCanvas);
  if show then begin
    aCanvas.Pen.Color:= FGColor;
    aCanvas.Font.Color:= FGColor;
  end else begin
    aCanvas.Pen.Color:= BGColor;
    aCanvas.Font.Color:= BGColor;
  end;
  aCanvas.Brush.Color:= BGColor;

  if IsRecursiv then begin
    DrawRecursiv(aCanvas, show);
    exit;
  end;
  if IntersectRect(getBoundsRect(FFrom), getBoundsRect(FTo)) then exit;

  parallelCorrection;  // use actual position, control might be moved
  CalcShortest;

  {--- draw connection line ---------------------------------------------------}
  x1:= FromP.x; // first point
  y1:= FromP.y;
  x2:= ToP.x; // second point with arrow
  y2:= ToP.y;
  ConRect:= Rect(min(x1, x2),  min(y1, y2), max(x1, x2) + 1, max(y1, y2) + 1);
  dx:= abs(x2-x1); if dx < 3 then InflateRect(ConRect, 1, 0);
  dy:= abs(y2-y1); if dy < 3 then InflateRect(ConRect, 0, 1);

  Square.init;
  xLineDelta:= x2 - x1;
  yLineDelta:= y2 - y1;

  absXLineDelta:= abs(xLineDelta);
  absYLineDelta:= abs(yLineDelta);
  if absXLineDelta = 0 then absXLineDelta:= 1;
  if absYLineDelta = 0 then absYLineDelta:= 1;

  if (xLineDelta = 0) and (yLineDelta = 0) then exit; // Line has length 0
  if (absXLineDelta > 20000) or (absYLineDelta > 20000) then exit; // Line is too long

  Tmp1:= sqrt(sqr(xLineDelta) + sqr(yLineDelta));
  xLineUnitDelta:= xLineDelta / Tmp1;
  yLineUnitDelta:= yLineDelta / Tmp1;

  // just the line
  // clipping is necessary due to line width 3
  MyRgn:= CreateRectRgn(ConRect.Left, ConRect.Top, ConRect.Right, ConRect.Bottom);
  SelectClipRgn(aCanvas.Handle, MyRgn);

  svg:= '<g>'#13#10;
  aCanvas.MoveTo(x1, y1);
  if Canvas.Pen.Width = 1 then begin
    aCanvas.LineTo(x2, y2);
    aCanvas.Pixels[x2, y2]:= aCanvas.Pen.Color;
    svg:= svg + getSVGLine(x1, y1, x2, y2);
  end else begin
    aCanvas.LineTo(x2-Round(5*xLineUnitDelta), y2 - Round(5*yLineUnitDelta));
    svg:= svg + getSVGLine(x1, y1, x2 - SimpleRoundTo(5*xLineUnitDelta, -1), y2 - SimpleRoundTo(5*yLineUnitDelta, -1));
    insert('stroke-width="3" ', svg, pos('/>', svg));
  end;
  if ArrowStyle in [asInstanceOf, asComment] then
    insert('stroke-dasharray="1.5% 0.5%" ', svg, pos('/>', svg));

  SelectClipRgn(aCanvas.Handle, HRGN(nil));
  DeleteObject(MyRgn);

  xNormalDelta :=  yLineDelta;
  yNormalDelta := -xLineDelta;
  xNormalUnitDelta := xNormalDelta / Sqrt(Sqr(xNormalDelta) + Sqr(yNormalDelta));
  yNormalUnitDelta := yNormalDelta / Sqrt(Sqr(xNormalDelta) + Sqr(yNormalDelta));

  aCanvas.Pen.Width := 1;
  aCanvas.Pen.Style := psSolid;

  hl:= FFrom.PPIScale(HeadLength);

  dx := Round(hl*xNormalUnitDelta);
  dy := Round(hl*yNormalUnitDelta);
  d1x:= Round(hl*xLineUnitDelta);
  d1y:= Round(hl*yLineUnitDelta);
  d2x:= Round(hl*xLineUnitDelta*2.0);
  d2y:= Round(hl*yLineUnitDelta*2.0);
  d3x:= Round(hl*xLineUnitDelta*3.0);
  d3y:= Round(hl*yLineUnitDelta*3.0);

  case ArrowStyle of
    asAggregation1, asAggregation2: aCanvas.Brush.Color:= BGColor;
    asComposition1, asComposition2:
      if Show
       then aCanvas.Brush.Color:= FGColor
       else aCanvas.Brush.Color:= BGColor;
  end;

  // (xBase, yBase) is where arrow line is perpendicular to base of triangle.
  xBase:= x1 + Round(hl * xLineUnitDelta);
  yBase:= y1 + Round(hl * yLineUnitDelta);
  if ArrowStyle in [asAggregation1, asAggregation2, asComposition1, asComposition2, asAssociation3] then
      case FromPStart of
        1, 3: begin
             ConRect.Bottom:= max3(ConRect.Bottom, yBase + dy, yBase - dy);
             ConRect.Top:= min3(ConRect.Top, yBase + dy, yBase - dy);
           end;
        2, 4: begin
             ConRect.Right:= max3(ConRect.Right, xBase + dx, xBase - dx);
             ConRect.Left:= min3(ConRect.Left, xBase + dx, xBase - dx);
           end;
      end;

  // show aggregation and composition
  MyRgn:= CreateRectRgn(ConRect.Left, ConRect.Top, ConRect.Right, ConRect.Bottom);
  SelectClipRgn(aCanvas.Handle, MyRgn);
  if ArrowStyle in [asAggregation1, asAggregation2, asComposition1, asComposition2] then begin
    PointArray:= [Point(x1, y1), Point(xBase + dx, yBase + dy),
                  Point(x1 + d2x, y1 + d2y), Point(xBase - dx, yBase - dy)];
    aCanvas.Polygon(PointArray);
    if ArrowStyle in [asAggregation1, asAggregation2]
      then svg:= svg + getSVGPolygon(PointArray, 'white')
      else svg:= svg + getSVGPolygon(PointArray, 'black');

  end else if Arrowstyle = asAssociation3 then begin
    PointArray:= [Point(xBase + dx, yBase + dy), Point(x1, y1),
                  Point(xBase - dx, yBase - dy)];
    aCanvas.Polyline(PointArray);
    svg:= svg + getSVGPolyline(PointArray);
  end;
  SelectClipRgn(aCanvas.Handle, HRGN(nil));
  DeleteObject(MyRgn);
  if not (ArrowStyle in [asAssociation1, asComment]) then begin
    square.enlargeLeft(FromPStart, ToPEnd, 22, 22);
    square.enlargeRight(FromPStart, ToPEnd, 22, 22);
  end;

  // draw  arrow head
  aCanvas.Brush.Color:= BGColor;
  xBase:= x2 - Round(hl * xLineUnitDelta);
  yBase:= y2 - Round(hl * yLineUnitDelta);
  if ArrowStyle in [asInheritends, asAssociation2, asAssociation3,
                    asAggregation2, asComposition2, asInstanceOf] then
      case ToPEnd of
        1, 3: begin
             ConRect.Bottom:= max3(ConRect.Bottom, yBase + dy, yBase - dy);
             ConRect.Top:= min3(ConRect.Top, yBase + dy, yBase - dy);
           end;
        2, 4: begin
             ConRect.Right:= max3(ConRect.Right, xBase + dx, xBase - dx);
             ConRect.Left:= min3(ConRect.Left, xBase + dx, xBase - dx);
           end;
      end;

  MyRgn:= CreateRectRgn(ConRect.Left, ConRect.Top, ConRect.Right, ConRect.Bottom);
  SelectClipRgn(aCanvas.Handle, MyRgn);
  case ArrowStyle of
    asInheritends:
    begin
      PointArray:= [Point(x2, y2), Point(xBase + dx, yBase + dy),
                    Point(xBase - dx, yBase - dy)];
      aCanvas.Polygon(PointArray);
      svg:= svg + getSVGPolygon(PointArray, 'white');
    end;
    asAssociation2, asAssociation3, asAggregation2, asComposition2, asInstanceOf:
    begin
      PointArray:= [Point(xBase + dx, yBase + dy), Point(x2, y2),
                    Point(xBase - dx, yBase - dy)];
      aCanvas.Polyline(PointArray);
      svg:= svg + getSVGPolyline(PointArray);
    end;
  end;
  SelectClipRgn(aCanvas.Handle, HRGN(nil));
  DeleteObject(MyRgn);
  svg:= svg + '</g>'#13#10;

  {--- draw multiplicities and roles ------------------------------------------}

  R2:= getBoundsRect(FFrom);
  if ArrowStyle in [asAggregation1, asAggregation2, asComposition1, asComposition2] then begin
    inc(R2.Right, abs(d3x));
    dec(R2.Top, abs(d3y));
    dec(R2.Left, abs(d3x));
    inc(R2.Bottom, abs(d3y));
    xr:= x1 + d3x;
    yr:= y1 + d3y;
  end else begin
    inc(R2.Right, abs(d1x));
    dec(R2.Top, abs(d1y));
    dec(R2.Left, abs(d1x));
    inc(R2.Bottom, abs(d1y));
    xr:= x1 + d1x;
    yr:= y1 + d1y;
  end;
  ShowMultiplicity(false, xr, yr, R2, MultiplicityA);
  ShowRole(false, xr, yr, R2, RoleA);

  ShowRelation(R2, dx, dy, Relation);

  R2:= getBoundsRect(FTo);
  if ArrowStyle in [asAssociation2, asAssociation3, asAggregation2, asComposition2,
                    asInheritends,  asInstanceOf] then begin
    inc(R2.Right, abs(d2x));
    dec(R2.Top, abs(d2y));
    dec(R2.Left, abs(d2x));
    inc(R2.Bottom, abs(d2y));
    xr:= x2 - d2x;
    yr:= y2 - d2y;
  end else begin
    inc(R2.Right, abs(d1x));
    dec(R2.Top, abs(d1y));
    dec(R2.Left, abs(d1x));
    inc(R2.Bottom, abs(d1y));
    xr:= x2 - d1x;
    yr:= y2 - d1y;
  end;
  ShowMultiplicity(true, xr, yr, R2, MultiplicityB);
  ShowRole(true, xr, yr, R2, RoleB);
  DrawSelection(aCanvas);
  square.term(FromP, ToP);
  //square.draw(aCanvas);
end;

procedure TConnection.DrawRecursiv(aCanvas: TCanvas; show: boolean);

  var PointArray: array of TPoint;
      hl: integer;

  procedure DrawArrowStart(P1, P2: TPoint);
    var P3, P4: TPoint; dx, dy: integer;
  begin
    case ArrowStyle of
      asAssociation3:;
      asAggregation1, asAggregation2: aCanvas.Brush.Color:= BGColor;
      asComposition1, asComposition2:
        if show
          then aCanvas.Brush.Color:= FGColor
          else aCanvas.Brush.Color:= BGColor;
      else exit;
    end;
    dx:= P2.x - P1.x;
    dy:= P2.Y - P1.y;
    if dy = 0 then begin
      P2.X:= P1.X + hl*2*sign(dx);
      P3.X:= P1.X + hl*sign(dx);
      P3.Y:= P1.Y - hl;
      P4.X:= P3.X;
      P4.y:= P1.Y + hl;
    end else begin
      P2.Y:= P1.Y + hl*2*sign(dy);
      P3.X:= P1.X + hl;
      P3.Y:= P1.Y + hl*sign(dy);
      P4.X:= P1.X - hl;
      P4.Y:= P3.Y;
    end;
    if ArrowStyle = asAssociation3 then begin
      PointArray:= [P3, P1, P4];
      aCanvas.Polyline(PointArray);
      svg:= svg + getSVGPolyline(PointArray);
    end else begin
      PointArray:= [P1, P3, P2, P4];
      aCanvas.Polygon(PointArray);
      if ArrowStyle in [asAggregation1, asAggregation2]
        then svg:= svg + getSVGPolygon(PointArray, 'white')
        else svg:= svg + getSVGPolygon(PointArray, 'black');
    end;
    aCanvas.Brush.Color:= BGColor;
  end;

  procedure DrawArrowHead(P1, P2: TPoint);
    var P3, P4: TPoint; dx, dy: integer;
  begin
    //if ArrowStyle in [asAssociation1, asAggregation1, asComposition1, asComment] then exit;
    dx:= P2.x - P1.x;
    dy:= P2.Y - P1.y;
    if dy = 0 then begin
      P3.X:= P1.X + hl*sign(dx);
      P3.Y:= P1.Y - hl;
      P4.X:= P3.X;
      P4.y:= P1.Y + hl;
    end else begin
      P3.X:= P1.X + hl;
      P3.Y:= P1.Y + hl*sign(dy);
      P4.X:= P1.X - hl;
      P4.Y:= P3.Y;
    end;
    case ArrowStyle of
      asInheritends: begin
        PointArray:= [P1, P3, P4];
        aCanvas.Polygon(PointArray);
        if ArrowStyle in [asAggregation1, asAggregation2]
          then svg:= svg + getSVGPolygon(PointArray, 'white')
          else svg:= svg + getSVGPolygon(PointArray, 'black');
      end;
      asAssociation2,
      asAssociation3,
      asAggregation2,
      asComposition2,
      asInstanceOf: begin
        PointArray:= [P3, P1, P4];
        aCanvas.Polyline(PointArray);
        aCanvas.Pixels[P4.x, P4.y]:= aCanvas.Pen.Color;
        svg:= svg + getSVGPolyline(PointArray);
      end;
      asAssociation1,
      asAggregation1,
      asComposition1,
      asComment: begin
        PointArray:= [P1, P2];
        aCanvas.Polyline(PointArray);
        svg:= svg + getSVGPolyline(PointArray);
      end;
    end;
    aCanvas.Brush.Color:= BGColor;
  end;

begin
  hl:= FFrom.PPIScale(HeadLength);
  CalcPolyline;
  if show
    then aCanvas.Pen.Color:= FGColor
    else aCanvas.Pen.Color:= BGColor;
  aCanvas.Polyline(Pl);
  svg:= '<g>'#13#10 + getSVGPolyline(Pl);
  if ArrowStyle in [asInstanceOf, asComment] then
    insert('stroke-dasharray="1.5% 0.5%" ', svg, pos('/>', svg));

  aCanvas.Pen.Width:= 1;
  aCanvas.Pen.Style:= psSolid;
  if isTurned then begin
    DrawArrowStart(Pl[5], PL[4]);
    DrawArrowHead(Pl[1], Pl[2]);
  end else begin
    DrawArrowStart(Pl[1], PL[2]);
    DrawArrowHead(Pl[5], Pl[4]);
  end;
  svg:= svg + '</g>'#13#10;
  DrawRecursivAnnotations(aCanvas);
  DrawSelection(aCanvas);
  Square.term(RecursivCorner, Pl);
  // debugging
  // Square.draw(Canvas);
end;

procedure TConnection.DrawRecursivAnnotations(aCanvas: TCanvas);
  var R: TRect;
      x1, y1, th, tw, sl, hl: integer;
      ma, mb, ra, rb: string;
      Flags: longint;
begin
  Flags:= DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
  x1:= 0;
  y1:= 0;

  if isTurned then begin
    sl:= ArrowHeadLength(ArrowStyle);
    hl:= ArrowStartLength(ArrowStyle);
    ma:= MultiplicityB;
    mb:= MultiplicityA;
    ra:= RoleB;
    rb:= RoleA;
  end else begin
    sl:= ArrowStartLength(ArrowStyle);
    hl:= ArrowHeadLength(ArrowStyle);
    ma:= MultiplicityA;
    mb:= MultiplicityB;
    ra:= RoleA;
    rb:= RoleB;
  end;

  if ma <> '' then begin // Multiplicity A
    R:= CalcRect(aCanvas, MaxInt, ma);
    case RecursivCorner of
      1: begin
           x1:= Pl[1].x + sl + 5;
           y1:= Pl[1].Y + 5;
         end;
      2: begin
           x1:= Pl[2].x + 5;
           y1:= Pl[2].y + 5;
         end;
      3: begin
           x1:= Pl[2].x + 5;
           y1:= Pl[2].y - R.Bottom - 5;
         end;
      4: begin
           x1:= Pl[1].x - R.Right - 5;
           y1:= Pl[1].y + sl + 5;
         end;
    end;
    OffsetRect(R, x1, y1);
    DrawText(aCanvas.Handle, PChar(ma), -1, R, Flags);
    svg:= svg + getSVGText(R, ma);
  end;

  if ra <> '' then begin // Role A
    R:= CalcRect(aCanvas, MaxInt, ra);
    case RecursivCorner of
      1: begin
           x1:= Pl[1].x + sl + 5;
           y1:= Pl[1].y - R.Bottom - 5;
         end;
      2: begin
           x1:= Pl[2].x - R.Right - 5;
           y1:= Pl[2].y + 5;
         end;
      3: begin
           x1:= Pl[2].x + 5;
           y1:= Pl[2].y + 5;
         end;
      4: begin
           x1:= Pl[1].x + 5;
           y1:= Pl[1].y + sl + 5;
         end;
    end;
    OffsetRect(R, x1, y1);
    DrawText(aCanvas.Handle, PChar(ra), -1, R, Flags);
    svg:= svg + getSVGText(R, ra);
  end;

  if Relation <> '' then begin // Relationname
    R:= CalcRect(aCanvas, MaxInt, Relation);
    th:= R.Bottom;
    tw:= R.Right;
    case RecursivCorner of
      1: begin
           x1:= (Pl[3].x + Pl[4].x) div 2 - tw div 2;
           y1:= Pl[3].Y - 5 - th;
           inc(YDecrease, 5 + th);
         end;
      2: begin
           x1:= (Pl[2].x + Pl[3].x) div 2 - tw div 2;
           y1:= Pl[2].Y - 5 - th;
           inc(YDecrease, 5 + th);
        end;
      3: begin
           x1:= (Pl[3].x + Pl[4].x) div 2 - tw div 2;
           y1:= Pl[3].Y + 5;
           inc(YEnlarge, 5 + th);
        end;
      4: begin
           x1:= (Pl[2].x + Pl[3].x) div 2 - tw div 2;
           y1:= Pl[3].Y + 5;
           inc(YEnlarge, 5 + th);
        end;
      else begin
         x1:= 0;
         y1:= 0;
      end;
    end;
    OffsetRect(R, x1, y1);
    DrawText(aCanvas.Handle, PChar(Relation), -1, R, Flags);
    svg:= svg + getSVGText(R, Relation);
  end;

  if mb <> '' then begin // Multiplicity B
    R:= CalcRect(aCanvas, MaxInt, mb);
    case RecursivCorner of
      1: begin
           x1:= Pl[4].x - R.Right - 5;
           y1:= PL[4].y + 5;
         end;
      2: begin
           x1:= Pl[4].x + 5;
           y1:= Pl[4].y + 5;
         end;
      3: begin
           x1:= Pl[5].x + 5;
           y1:= Pl[5].y + hl + 5;
         end;
      4: begin
           x1:= Pl[5].x + hl + 5;
           y1:= Pl[5].y - R.Bottom - 5;
         end;
    end;
    OffsetRect(R, x1, y1);
    DrawText(aCanvas.Handle, PChar(mb), -1, R, Flags);
    svg:= svg + getSVGText(R, mb);
  end;

  if rb <> '' then begin // Role B
    R:= CalcRect(aCanvas, MaxInt, rb);
    case RecursivCorner of
      1: begin
           x1:= Pl[4].x + 5;
           y1:= Pl[4].Y + 5;
         end;
      2: begin
           x1:= Pl[4].x + 5;
           y1:= Pl[4].y - R.Bottom - 5;
         end;
      3: begin
           x1:= Pl[5].x - R.Right - 5;
           y1:= Pl[5].y + hl + 5;
         end;
      4: begin
           x1:= Pl[5].x + hl + 5;
           y1:= Pl[5].y + 5;
        end;
    end;
    OffsetRect(R, x1, y1);
    DrawText(aCanvas.Handle, PChar(rb), -1, R, Flags);
    svg:= svg + getSVGText(R, rb);
  end;
end;

procedure TConnection.DrawSelection(aCanvas: TCanvas; withSelection: boolean = true);

  function getRect(P: TPoint; side: integer): TRect;
    const w = 5;
  begin
    case side of
      1: Result:= Rect(P.x, P.y - w, P.x + w + 1, P.y + w + 1);
      2: Result:= Rect(P.x - w, P.y - w, P.x + w + 1, P.y + 1);
      3: Result:= Rect(P.x - w, P.y - w, P.x + 1, P.y + w + 1);
      4: Result:= Rect(P.x - w, P.y, P.x + w +1, P.y + w);
    end;
  end;

begin
  {--- show selection marks ---------------------------------------------------}
  if Selected or not withSelection then begin
    if withSelection
      then aCanvas.Brush.Color:= FGColor // clYellow
      else aCanvas.Brush.Color:= BGColor;
    aCanvas.FillRect(getRect(FromP, FromPStart));
    aCanvas.FillRect(getRect(ToP, ToPEnd));
  end;
  aCanvas.Brush.Color:= BGColor;
end;

function TConnection.CalcRect(ACanvas: TCanvas; AMaxWidth: Integer; const AString: string): TRect;
begin
  Result := Rect(0, 0, AMaxWidth, 0);
  DrawText(ACanvas.Handle, PChar(AString), -1, Result, DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
end;

procedure TConnection.CalcPolyline;
  var sl, hl, sw, hw, x1, y1, dy, l, w, t, h, tw, th, RRRb: integer;
      RRA, RRB, RMA, RMB, RRR: TRect;
begin
{
      P4-----P3
      |      |
      P5     |
             |
        P1---P2
}
  if isTurned then begin
    sl:= ArrowHeadLength(ArrowStyle);
    hl:= ArrowStartLength(ArrowStyle);
    sw:= sl;
    if hl > 0 then hw:= FFrom.PPIScale(HeadLength) else hw:= 0;
  end else begin
    sl:= ArrowStartLength(ArrowStyle);
    hl:= ArrowHeadLength(ArrowStyle);
    if sl > 0 then sw:= FFrom.PPIScale(HeadLength) else sw:= 0;
    hw:= hl;
  end;

  dy:= min(FFrom.Height div 2, rec_dc);
  l:= FFrom.Left;
  t:= FFrom.Top;
  w:= FFrom.Width;
  h:= FFrom.Height;
  case RecursivCorner of
    1: begin
         FromP:= Point(l + w, t + dy);
         ToP  := Point(l + w - rec_dx, t - 1);
       end;
    2: begin
         FromP:= Point(l + rec_dx, t - 1);
         ToP  := Point(l - 1, t + dy);
       end;
    3: begin
         FromP:= Point(l - 1, t + h - dy);
         ToP  := Point(l + rec_dx, t + h);
       end;
    4: begin
         FromP:= Point(l + w - rec_dx, t + h);
         ToP  := Point(l + w, t + h - dy);
       end;
  end;
  FromPStart:= RecursivCorner;
  ToPEnd:= RecursivCorner + 1;
  if ToPEnd = 5 then ToPEnd:= 1;

  x1:= FromP.x;
  y1:= FromP.Y;

  Pl[1]:= FromP;
  Pl[5]:= ToP;
  XEnlarge:= 0;
  YEnlarge:= 0;
  XDecrease:= 0;
  yDecrease:= 0;
  RRA:= CalcRect(Canvas, MaxInt, RoleA);
  RRB:= CalcRect(Canvas, MaxInt, RoleB);
  RMA:= CalcRect(Canvas, MaxInt, MultiplicityA);
  RMB:= CalcRect(Canvas, MaxInt, MultiplicityB);
  RRR:= CalcRect(Canvas, MaxInt, Relation);
  if RRR.Bottom = 0 then RRRb:= 2 else RRRb:= RRR.Bottom + 5;
  Square.Init;

  case RecursivCorner of
    1: begin
         th:= max3(RMB.Bottom, RRB.Bottom, RRA.Bottom - dy) + 10;
         tw:= max3(RMA.Right, RRA.Right, RRB.Right - rec_dx) + 10;
         Pl[2]:= Point(x1 + sl + tw, y1);
         Pl[3]:= Point(Pl[2].x, Pl[5].y - hl - th);
         Pl[4]:= Point(Pl[5].x, Pl[3].y);
         XEnlarge := Pl[2].x - Pl[1].x;
         YDecrease:= Pl[5].Y - Pl[4].y;
         Square.enlargeBottom(RecursivCorner, sw + RMA.Bottom);
         Square.enlargeLeft(RecursivCorner, hw + RMB.Right);
         Square.enlargeTop(RecursivCorner, RRRb);
         Square.enlargeRight(RecursivCorner, 2);
       end;
    2: begin
         th:= max3(RMA.Bottom, RRA.Bottom, RRB.Bottom - dy) + 10;
         tw:= max3(RMB.Right, RRB.Right, RRA.Right - rec_dx) + 10;
         Pl[2]:= Point(x1, y1 - sl - th);
         Pl[3]:= Point(Pl[5].x - hl - tw, Pl[2].y);
         Pl[4]:= Point(Pl[3].x, Pl[5].y);
         XDecrease:= Pl[5].x - Pl[4].x;
         YDecrease:= Pl[1].y - Pl[2].y;
         Square.enlargeRight(RecursivCorner, sw + RMA.Right);
         Square.enlargeBottom(RecursivCorner, hw + RMB.Bottom);
         Square.enlargeTop(RecursivCorner, RRRb);
         Square.enlargeLeft(RecursivCorner, 2);
       end;
    3: begin
         th:= max3(RMB.Bottom, RRB.Bottom, RRA.Bottom - dy) + 10;
         tw:= max3(RMA.Right, RRA.Right, RRB.Right - rec_dx) + 10;
         Pl[2]:= Point(x1 - sl - tw, y1);
         Pl[3]:= Point(Pl[2].x, pl[5].y + hl + th);
         Pl[4]:= Point(Pl[5].x, Pl[3].y);
         XDecrease:= Pl[1].x - Pl[2].x;
         YEnlarge := Pl[4].y - Pl[5].y;
         Square.enlargeTop(RecursivCorner, sw + RMA.Bottom);
         Square.enlargeRight(RecursivCorner, hw + RMB.Right);
         Square.enlargeBottom(RecursivCorner, RRRb);
         Square.enlargeLeft(RecursivCorner, 2);
       end;
    4: begin
         th:= max3(RMA.Bottom, RRA.Bottom, RRB.Bottom - dy) + 10;
         tw:= max3(RMB.Right, RRB.Right, RRA.Right - rec_dx) + 10;
         Pl[2]:= Point(x1, y1 + sl + th);
         Pl[3]:= Point(Pl[5].x + hl + tw, Pl[2].y);
         Pl[4]:= Point(Pl[3].x, Pl[5].y);
         XEnlarge:= Pl[4].x - Pl[5].x;
         YEnlarge:= Pl[2].y - Pl[1].y;
         Square.enlargeLeft(RecursivCorner, sw + RMA.Right);
         Square.enlargeTop(RecursivCorner, hw + RMB.Bottom);
         Square.enlargeBottom(RecursivCorner, RRRb);
         Square.enlargeRight(RecursivCorner, 2);
       end;
  end;
end;

procedure TConnection.CalcShortest;

{         2
    -------------
    |           |
  3 |           |  1
    |           |
    -------------
          4
}

  function CalcPointPos(P: TPoint; R: TRect): integer;
  begin
    if P.X = R.Left - 1 then Result:= 3 else
    if P.X = R.Right    then Result:= 1 else
    if P.y = R.Top - 1  then Result:= 2 else
    if P.Y = R.Bottom   then Result:= 4 else
    Result:= -1;
  end;

  function CalcIntersectionPoint(A, B: TPoint; R: TRect): TPoint;
    var dx, dy: LongInt;
  begin
    Dec(R.Left);    // intersection point must be outside rect
    Dec(R.Top);
    Result:= A;
    dx:= B.x - A.x;
    dy:= B.y - A.y;
    if dx <> 0 then begin
      if dx > 0
        then Result.X:= R.Right
        else Result.X:= R.Left;
      Result.Y:= A.Y + round(dy*(Result.X - A.X) / dx);
      if not ((R.Top <= Result.Y) and (Result.Y <= R.Bottom)) then begin
        if abs(R.Top-Result.Y) < abs(Result.y-R.Bottom)
          then Result.y:= R.Top
          else Result.Y:= R.Bottom;
        if dy <> 0 then
          Result.x:= A.x + round(dx*(Result.y - A.y) / dy);
      end
    end else begin
      Result.x:= A.x;
      if dy > 0
        then Result.y:= R.Bottom
        else Result.Y:= R.Top;
    end;
    if Result.x > R.Right then Result.x:= R.Right;
    if Result.x < R.Left then Result.x:= R.Left;
  end;

begin
  FromP:= CalcIntersectionPoint(FromCenter, ToCenter, getBoundsRect(FFrom));
  FromPStart:= CalcPointPos(FromP, getBoundsRect(FFrom));
  ToP:= CalcIntersectionPoint(ToCenter, FromCenter, getBoundsRect(FTo));
  ToPEnd:= CalcPointPos(ToP, getBoundsRect(FTo));
end;

function TConnection.ArrowHeadLength(Arrow: TessConnectionArrowStyle): integer;
begin
  if arrow in [asAssociation2, asAssociation3, asAggregation2, asComposition2,
               asInheritends, asInstanceOf]
    then Result:= FFrom.PPIScale(HeadLength)
    else Result:= 0;
end;

function TConnection.ArrowStartLength(Arrow: TessConnectionArrowStyle): integer;
begin
  if arrow in [asAggregation1, asAggregation2, asComposition1, asComposition2]
    then Result:= FFrom.PPIScale(HeadLength)*2
  else if arrow = asAssociation3
    then Result:= FFrom.PPIScale(HeadLength)
    else Result:= 0
end;

constructor TConnection.create(Src, Dst: TControl; Attributes: TConnectionAttributes; aCanvas: TCanvas);
begin
  FFrom         := Src;
  FTo           := Dst;
  ArrowStyle    := Attributes.ArrowStyle;
  ConnectStyle  := ArrowToConnect(ArrowStyle);
  RoleA         := Attributes.RoleA;
  MultiplicityA := Attributes.MultiplicityA;
  ReadingOrderA := Attributes.ReadingOrderA;
  Relation      := Attributes.Relation;
  ReadingOrderB := Attributes.ReadingOrderB;
  MultiplicityB := Attributes.MultiplicityB;
  RoleB         := Attributes.RoleB;
  RecursivCorner:= Attributes.RecursivCorner;
  isTurned      := Attributes.isTurned;
  Visible       := Attributes.Visible;
  isEdited      := Attributes.isEdited;
  FromCenter    := getCenter(getBoundsRect(FFrom));
  ToCenter      := getCenter(getBoundsRect(FTo));
  Square        := TSquare.create;
  isRecursiv    := (FFrom = FTo);
  Self.Canvas   := aCanvas;
  Selected      := false;
  Cutted        := false;
  XEnlarge      := 0;
  YEnlarge      := 0;
  FromPStart    := -1;
  ToPEnd        := -1;
  ChangeStyle;
  if IsRecursiv then
    CalcPolyline;
end;

destructor TConnection.destroy;
begin
  FreeAndNil(Square);
end;

procedure TConnection.SetAttributes(Attributes: TConnectionAttributes);
begin
  ConnectStyle:= ArrowToConnect(Attributes.ArrowStyle);
  ArrowStyle:= Attributes.ArrowStyle;
  RoleA:= Attributes.RoleA;
  MultiplicityA:= Attributes.MultiplicityA;
  ReadingOrderA:= Attributes.ReadingOrderA;
  Relation:= Attributes.Relation;
  ReadingOrderB:= Attributes.ReadingOrderB;
  MultiplicityB:= Attributes.MultiplicityB;
  RoleB:= Attributes.RoleB;
  if IsRecursiv and (Attributes.RecursivCorner <> 0) then
    RecursivCorner:= Attributes.RecursivCorner;
  IsEdited:= Attributes.IsEdited;
end;

procedure TConnection.SetArrow(Arrow: TessConnectionArrowStyle);
begin
  ConnectStyle:= ArrowToConnect(Arrow);
  ArrowStyle:= Arrow;
end;

procedure TConnection.Turn;
  var Src: TControl; Point: TPoint;
begin
  if IsRecursiv then begin
    isTurned:= not isTurned;
    CalcPolyline;
  end else begin
    Src:= FFrom; FFrom:= FTo; FTo:= Src;
    Point:= FromP; FromP:= ToP; ToP:= Point;
  end;
  IsEdited:= true;
end;

function TConnection.IsClicked(P: TPoint): boolean;
  var A, B, VectorAB, VectorAP, Normale: TPoint;
      i, xlineDelta, yLineDelta: Integer;
      Distance, CosAlpha: real;
      R: TRect;

  function Scalarproduct(P, Q: TPoint): real;
  begin
    Result:= P.X*Q.X + P.Y*Q.Y;
  end;

  function Norm(vector: TPoint):real;
  begin
    Result:= sqrt(sqr(vector.X) + sqr(vector.Y));
  end;

  function makeRect(P1, P2: TPoint): TRect;
    var dx, dy: integer;
  begin
    dx:= P2.x - P1.x;
    dy:= P2.Y - P1.Y;
    if dy = 0 then
      if dx > 0
        then Result:= Rect(P1.X,      P1.y - 10, P2.X + 10, P2.Y + 10)
        else Result:= Rect(P2.X - 10, P2.y - 10, P1.X     , P1.Y + 10)
    else // dx = 0
      if dy > 0
        then Result:= Rect(P1.X - 10, P1.Y     , P2.X + 10, P2.Y + 10)
        else Result:= Rect(P2.X - 10, P2.Y - 10, P1.X + 10, P1.Y);
   end;

begin
  Result:= true;
  if isRecursiv then begin
    for i:= 1 to 3 do begin
      R:= makeRect(Pl[i], Pl[i+1]);
      if PtinRect(R, P) then exit;
    end;
    R:= makeRect(Pl[5], Pl[4]);
    if PtInRect(R, P) then exit;
  end else begin
    A:= FromP;
    B:= ToP;
    xLineDelta:= B.x - A.x;
    yLineDelta:= B.y - A.y;
    if (xLineDelta = 0) and (yLineDelta = 0) then begin Result:= false; exit; end;// Line is 0 length
    if (abs(xLineDelta) > 20000) or (abs(yLineDelta) > 20000) then exit; // Line is too long
    VectorAB.X:= B.X - A.X;
    VectorAB.Y:= B.Y - A.Y;
    VectorAP.X:= P.X - A.X;
    VectorAP.Y:= P.Y - A.Y;
    Normale.X:= -VectorAB.Y;
    Normale.Y:=  VectorAB.X;
    if Norm(Normale) = 0
      then Distance:= 10000000
      else Distance:= Abs(Scalarproduct(VectorAP, Normale)/Norm(Normale));
    CosAlpha:= Scalarproduct(VectorAB, VectorAP);
    if (CosAlpha > 0) and (Distance < 10) and (norm(VectorAP) <= norm(VectorAB) + 10) then
      exit;
  end;
  Result:= false;
end;

procedure TConnection.setRecursivPosition(pos: integer);
begin
  RecursivCorner:= pos;
  CalcPolyline;
end;

procedure TConnection.parallelCorrection;
  var dx, dy, xLineDelta, yLineDelta, hl: integer;
      xLineunitDelta, yLineUnitDelta, Tmp: double;
      A, B: TPoint;
begin
  A:= getCenter(getBoundsRect(FFrom));
  B:= getCenter(getBoundsRect(FTo));
  xLineDelta:= B.x - A.x;
  yLineDelta:= B.y - A.y;
  if (xLineDelta = 0) and (yLineDelta = 0) then exit; // Line has length 0
  if (abs(xLineDelta) > 20000) or (abs(yLineDelta) > 20000) then exit; // Line is too long

  Tmp:= sqrt(sqr(xLineDelta) + sqr(yLineDelta));
  if Tmp = 0 then begin
    xLineUnitDelta:= 0;
    yLineUnitDelta:= 0;
  end else begin
    xLineUnitDelta:= xLineDelta / Tmp;
    yLineUnitDelta:= yLineDelta / Tmp;
  end;

  hl:= fFrom.PPIScale(HeadLength);
  if parallelcount > 0 then
    if abs(xLineUnitDelta) > abs(yLineUnitDelta) then begin
      dy:= -2*(hl+2)*Parallelcount div 2 + 2*(hl+2)*Parallelindex;
      A.y:= A.y + dy;
      B.y:= B.y + dy;
    end else begin
      dx:= -2*(hl+2)*Parallelcount div 2 + 2*(hl+2)*Parallelindex;
      A.x:= A.x + dx;
      B.x:= B.x + dx;
    end;
  FromCenter:= A;
  ToCenter:= B;
end;

function TConnection.getBoundsRect(aRect: TRect): TRect;
begin
  Result:= aRect;
  Result.Bottom:= Result.Bottom;
  Result.Right:= Result.Right;
end;

function TConnection.getBoundsRect(aControl: TControl): TRect;
  var aRect: TRect; //aBox: TRtfdBox;
begin
  aRect:= getBoundsRect(aControl.BoundsRect);
  {
  if (aControl is TRtfdBox) then begin
    aBox:= aControl as TRtfdBox;
    aRect.Width:= aRect.Width - aBox.ExtentX;
    aRect.Top:= aRect.Top + aBox.ExtentY;
  end;}
  Result:= aRect;
end;

procedure TConnection.ChangeStyle(BlackAndWhite: boolean = false);
begin
  if StyleServices.IsSystemStyle or BlackandWhite then begin
    BGColor:= clWhite;
    FGColor:= clBlack;
  end else begin
    BGColor:= StyleServices.GetStyleColor(scPanel);
    FGColor:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
end;

function TConnection.calcSVGBaseLine(R: TRect): integer;
begin
  Result:= R.Top + Round(1.0*abs(Canvas.Font.Height));
end;

function TConnection.getSVGText(R: TRect; s: string): string;
begin
  Result:= '  <text x=' + IntToVal(R.Left) + ' y=' + IntToVal(calcSVGBaseLine(R)) +
           ' white-space="pre-line">' + s + '</text>'#13#10;
end;

function TConnection.getSVGLine(x1, y1, x2, y2: real): string;
begin
  Result:= '  <line x1=' + FloatToVal(x1) + ' y1=' + FloatToVal(y1) +
           ' x2=' + FloatToVal(x2) + ' y2=' + FloatToVal(y2) +
           ' stroke="black" stroke-linecap="square" />'#13#10;
end;

function TConnection.getSVGPolyline(Points: array of TPoint): string;
  var i: integer;
begin
  Result:= '  <polyline points="';
  for i:= 0 to High(Points) do
    Result:= Result + PointToVal(Points[i]);
  Result[length(Result)]:= '"';
  Result:= Result + ' fill="none" stroke="black" />'#13#10;
end;

function TConnection.getSVGPolygon(Points: array of TPoint; color: string): string;
  var i: integer;
begin
  Result:= '  <polygon points="';
  for i:= 0 to High(Points) do
    Result:= Result + PointToVal(Points[i]);
  Result[length(Result)]:= '"';
  Result:= Result + ' fill="' + color + '" stroke="black" />'#13#10;
end;

function TConnection.getSVG: string;
begin
  Result:= svg;
end;


end.
