{-------------------------------------------------------------------------------
 Unit:     USequencePanel
 Author:   Gerhard Röhner
 Date:     July 2019
 Purpose:  sequence diagram panel
 Hint:     modified version of UESSConnectPanel
-------------------------------------------------------------------------------}

unit USequencePanel;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, ExtCtrls, Contnrs,
  Menus, SpTBXItem;

const
  cDistX: Integer = 30;
  cDistY: Integer = 30;
  cActivationWidth: Integer = 7;
  cHeadLength: Integer = 10;
  cMinWidth: Integer = 60;
  cMinHeight: Integer = 30;

type
  // available linestyles
  TConnectStyle = (csThin, csThinDash);

  // different kinds of arrowheads
  TArrowStyle = (casSynchron, casAsynchron, casReturn, casNew, casClose);

  TConnectionAttributes = class
    ConnectStyle: TConnectStyle;
    ArrowStyle : TArrowStyle;
    aMessage: string;
  end;

  TConnectionChanged = procedure(Sender: TObject; ArrowStyleOld, ArrowStyleNew: TArrowStyle) of object;

  // Specifies a connection between two managed objects.
  TConnection = class(TConnectionAttributes)
  public
    Selected: Boolean;
    FFrom, FTo: TControl; // from --> to Lifeline
    FromP, ToP: TPoint;   // start/ending of connection
    isRecursiv: Boolean;
    Pl: array[1..4] of TPoint;
    ConRect: TRect;
    YPos: Integer;
    FromActivation: Integer;
    ToActivation: Integer;
    TextRect: TRect;
    DistX: Integer;
    DistY: Integer;
    ActivationWidth: Integer;
    HeadLength: Integer;
    OnConnectionChanged: TConnectionChanged;
    BGColor: TColor;
    FGColor: TColor;
    constructor Create(Src, Dst: TControl; Attributes: TConnectionAttributes; aOnConnectionChanged: TConnectionChanged);
    procedure Draw(Canvas: TCanvas);
    procedure DrawRecursiv(Canvas: TCanvas);
    procedure DrawRecursivMessage(Canvas: TCanvas);
    procedure DrawSelection(Canvas: TCanvas; WithSelection: Boolean = True);
    procedure UnDrawSelection(Canvas: TCanvas);
    procedure SetPenBrushArrow(Canvas: TCanvas);
    procedure CalcPolyline;
    procedure SetAttributes(Attributes: TConnectionAttributes);
    procedure SetArrow(aArrowStyle: TArrowStyle);
    procedure Turn;
    function IsClicked(P: TPoint): Boolean;
    function CalcRect(Canvas: TCanvas; AMaxWidth: Integer; const AString: string): TRect;
    function hasRect: TRect;
    function getArrowStyleAsString: string;
    procedure setFont(aFont: TFont);
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
  end;

  // Wrapper around a control managed by essConnectPanel
  TManagedObject = class
  private
    FSelected: Boolean;
    FVisible: Boolean;
    procedure SetSelected(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  private
    FControl: TControl;
    // old eventhandlers
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
  public
    constructor Create;
    property Selected: Boolean read FSelected write SetSelected;
    property Visible: Boolean read FVisible write SetVisible;
    property Control: TControl read FControl;
  end;

  {
    Component that manages a list of contained controls that can be connected with
    somekind of line and allows the user to move it around and gives the containd
    control grabhandles when selected.

    Further it manages the layout of the contained controls.
  }

  TBackgroundDblClicked = procedure(Sender: TObject; Conn: TConnection) of object;

  TSequencePanel = class(TCustomPanel)
  private
    FMemMousePos: TPoint;
    FSelectRect: TRect;
    FBackBitmap: TBitmap;
    TempHidden : TObjectList;
    SequenceForm: TForm;
    BGColor: TColor;
    FGColor: TColor;
    FMoved: Boolean;

    procedure SetSelectedOnly(const Value : Boolean);
    procedure SetModified(const Value: Boolean);
    procedure SetLocked(const Value: Boolean);
    procedure TurnConnection(i: Integer);
  protected
    FManagedObjects: TList;
    FConnections: TObjectList;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;

    procedure SelectObjectsInRect(SelRect: TRect);
    procedure OnManagedObjectMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectClick(Sender: TObject);
    procedure OnManagedObjectDblClick(Sender: TObject);

    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;

  public
    OnContentChanged : TNotifyEvent;
    OnModified: TNotifyEvent;
    OnSelectionChanged: TNotifyEvent;
    OnShowAll: TNotifyEvent;
    OnConnectionSet: TNotifyEvent;
    OnConnectionChanged: TConnectionChanged;
    OnBackgroundDblClicked: TBackgroundDblClicked;
    OnLifeLineSequencePanel: TNotifyEvent;
    PopupMenuConnection: TSpTBXPopupMenu;
    PopupMenuLifeLineAndSequencePanel: TPopupMenu;

    FIsModified: Boolean;
    FIsMoving: Boolean;
    FIsRectSelecting: Boolean;
    FSelectedOnly: Boolean;
    FIsLocked: Boolean;
    MouseDownOK: Boolean;
    FResized: Boolean;
    FShowConnections: Integer;

    // public declarations
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Paint; override;
    function FindManagedControl(AControl: TControl ): TManagedObject;
    // Add a control to the managed list
    function AddManagedObject(AObject: TControl): TControl;

    function GetFirstSelected: TControl;
    // Returns a objectlist containing the selected controls.
    // The list should be freed by the caller.
    function GetSelectedControls : TObjectList;
    procedure DeleteSelectedControls;
    function CountSelectedControls: Integer;

    // Returns a list with all interobject connections.
    // The list should be freed by the caller.
    function GetConnections : TList;
    function Get2NdLastConnection: TConnection;
    function GetLastConnection: TConnection;
    procedure SetConnection(i: Integer; Arrow: TArrowStyle);
    procedure SetSelectedConnection(Attributes: TConnectionAttributes);
    function getConnectionOfClickedTextRect: TConnection;
    procedure DeleteConnections;
    procedure DeleteSelectedConnection;
    function HasSelectedConnection: Boolean;
    function GetClickedConnectionNr: Integer;
    function GetClickedConnection: TConnection;
    function GetSelectedConnection: TConnection;

    // Add a connection from Src to Dst with the supplied style
    function ConnectObjects(Src, Dst: TControl; Attributes: TConnectionAttributes): TConnection;
    function ConnectObjectsAt(Src, Dst: TControl; Attributes: TConnectionAttributes; i: Integer): TConnection;
    procedure DoConnection(Item: Integer);

    // Free all managed objects and the managed controls.
    procedure ClearManagedObjects;

    // Unselect all selected objects
    procedure ClearSelection(WithShowAll: Boolean = True);
    function SelectionChangedOnClear: Boolean;
    procedure ShowAll;
    procedure SetFocus; override;
    procedure SelectConnection;
    procedure SelectClickedConnection;
    procedure ConnectBoxesAt(Src, Dest: TControl; at: Integer);
    procedure GetDiagramSize(var W, H: Integer);
    procedure RecalcSize;
    procedure ShowConnections;
    procedure setFont(aFont: TFont);
    procedure Clear;
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function GetEnclosingRect: TRect;

    property isLocked: Boolean read FIsLocked write SetLocked;
    property IsModified: Boolean read FIsModified write SetModified;
    property IsMoving: Boolean read FIsMoving write FIsMoving;
    // Bitmap to be used as background for printing
    property BackBitmap : TBitmap read FBackBitmap write FBackBitmap;
    property SelectedOnly: Boolean read FSelectedOnly write SetSelectedOnly;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property FullRepaint;
    property ParentBiDiMode;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color default clWhite;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation

uses Math, SysUtils, StdCtrls, Types, Themes, UITypes,
     uCommonFunctions, UUtils, UConnectForm, ULifeline;

type
  TCrackControl = class(TControl)
  end;

procedure TConnection.SetPenBrushArrow(Canvas: TCanvas);
begin
  case ConnectStyle of
    csThin:
      begin
        Canvas.Pen.Width := 1;
        Canvas.Pen.Style := psSolid;
      end;
    csThinDash:
      begin
        Canvas.Pen.Width := 1;
        Canvas.Pen.Style := psDash;
      end;
  end;
  if ArrowStyle = casReturn then
    Canvas.Pen.Style:= psDot;
end;

procedure TConnection.Draw(Canvas: TCanvas);
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
    dx, dy, th, tw: Integer;
    absXLineDelta, absYLineDelta: Integer;

  procedure DrawMessage;
  begin
    th:= Canvas.TextHeight('A');
    if aMessage = ''
      then tw:= 100
      else tw:= Canvas.TextWidth(aMessage);
    if x1 < x2
      then TextRect:= Bounds(x1 + FromActivation*ActivationWidth + 5, y1 - 1 - th, tw, th)
      else TextRect:= Bounds(x1 - FromActivation*ActivationWidth - 5 - tw, y1 - 1 - th, tw, th);
    SetBkColor(Canvas.Handle, BGColor);
    DrawText(Canvas.Handle, PChar(aMessage), -1, TextRect, DT_CALCRECT);
    DrawText(Canvas.Handle, PChar(aMessage), -1, TextRect, 0);
    ConRect.Union(TextRect);
  end;

begin  // of draw
  Canvas.Pen.Mode:= pmCopy;
  Canvas.Pen.Color:= FGColor;
  Canvas.Brush.Color:= BGColor;

  if IsRecursiv then begin
    DrawRecursiv(Canvas);
    Exit;
  end;

  {--- draw connection line ---------------------------------------------------}
  FromP.x:= FFrom.Left + FFrom.Width div 2; // first point
  FromP.Y:= YPos;
  x1:= FromP.x;
  y1:= FromP.Y;

  if ArrowStyle = casNew
    then ToP.x:= FTo.Left
    else ToP.x:= FTo.Left + FTo.Width div 2; // second point with arrow
  ToP.y:= FromP.y;
  x2:= ToP.x;
  y2:= ToP.y;

  xLineDelta:= x2 - x1;
  yLineDelta:= y2 - y1;
  absXLineDelta:= Max(abs(xLineDelta), 1);
  absYLineDelta:= Max(abs(yLineDelta), 1);

  if (xLineDelta = 0) and (yLineDelta = 0) then Exit; // Line has length 0
  if (absXLineDelta > 20000) or (absYLineDelta > 20000) then Exit; // Line is too long

  Tmp1:= sqrt(sqr(xLineDelta) + sqr(yLineDelta));
  xLineUnitDelta:= xLineDelta / Tmp1;
  yLineUnitDelta:= yLineDelta / Tmp1;

  // (xBase, yBase) is where arrow line is perpendicular to base of triangle.
  xNormalDelta :=  yLineDelta;
  yNormalDelta := -xLineDelta;
  xNormalUnitDelta := xNormalDelta / Sqrt(Sqr(xNormalDelta) + Sqr(yNormalDelta));
  yNormalUnitDelta := yNormalDelta / Sqrt(Sqr(xNormalDelta) + Sqr(yNormalDelta));

  dx := Round(HeadLength*0.4*xNormalUnitDelta);
  dy := Round(HeadLength*0.4*yNormalUnitDelta);

  SetPenBrushArrow(Canvas);

  if ArrowStyle = casClose then
    x2:= x2 - ActivationWidth
  else
    if FFrom.Left > FTo.Left then begin
      x1:= x1 - FromActivation*ActivationWidth;
      x2:= x2 + ToActivation*ActivationWidth
    end else begin
      x1:= x1 + FromActivation*ActivationWidth;
      x2:= x2 - ToActivation*ActivationWidth;
    end;

  // just the line
  Canvas.MoveTo(x1, y1);
  Canvas.LineTo(x2, y2);
  // due to unexpected painting of casReturn
  Canvas.MoveTo(x1, y1);
  Canvas.LineTo(x2, y2);

  // draw the arrow
  xBase:= x2 - Round(HeadLength * xLineUnitDelta);
  yBase:= y2 - Round(HeadLength * yLineUnitDelta);
  case ArrowStyle of
    casSynchron,
    casNew,
    casClose: begin
      Canvas.Brush.Color:= Canvas.Pen.Color;
      Canvas.Polygon([
        Point(xBase + dx, yBase + dy),
        Point(x2, y2),
        Point(xBase - dx, yBase - dy)]);
    end;
    casAsynchron,
    casReturn: begin
      Canvas.Pen.Style:= psSolid;
      Canvas.Polyline([
        Point(xBase + dx, yBase + dy),
        Point(x2, y2),
        Point(xBase - dx, yBase - dy)]);
    end;
  end;

  // close message
  if ArrowStyle = casClose then begin
    Canvas.MoveTo(x2, y2 - HeadLength);
    Canvas.LineTo(x2 + 2*Activationwidth, y2 + HeadLength);
    Canvas.MoveTo(x2 + 2*ActivationWidth, y2 - HeadLength);
    Canvas.LineTo(x2, y2 + HeadLength);
  end;
  Canvas.Pen.Color:= FGColor;
  ConRect:= Rect(Min(x1, x2), Min(y1, y2) - abs(dy),
                 Max(x1, x2), Max(y1, y2) + abs(dy));
  ConRect.Inflate(FFrom.PPIScale(2), FFrom.PPIScale(2));
  DrawMessage;

  // debug
  // Canvas.Brush.Color:= clRed;
  // Canvas.FrameRect(ConRect);
end;

procedure TConnection.DrawRecursiv(Canvas: TCanvas);

  procedure DrawArrowHead(P1, P2: TPoint);
    var P3, P4: TPoint; dx: Integer;
  begin
    dx:= P2.x - P1.x;
    P3.X:= P1.X + Round(Headlength)*sign(dx);
    P3.Y:= P1.Y - Round(Headlength*0.4);
    P4.X:= P3.X;
    P4.y:= P1.Y + Round(Headlength*0.4);

    case ArrowStyle of
      casAsynchron,
      casReturn:
        Canvas.Polyline([P3, P1, P4]);
      casSynchron: begin
        Canvas.Brush.Color:= Canvas.Pen.Color;
        Canvas.Polygon([P3, P1, P4]);
      end;
    end;
    Canvas.Brush.Color:= BGColor;
  end;

begin
  SetPenBrushArrow(Canvas);
  CalcPolyline;
  Canvas.Polyline(Pl);
  Canvas.Pen.Width:= 1;
  Canvas.Pen.Style:= psSolid;
  DrawArrowHead(Pl[4], Pl[3]);
  DrawRecursivMessage(Canvas);
end;

procedure TConnection.DrawRecursivMessage(Canvas: TCanvas);
  var x1, y1: Integer;
      Flags: longint;
begin
  // Relationname
  Flags:= DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
  TextRect:= CalcRect(Canvas, MaxInt, aMessage);
  if ArrowStyle = casReturn
    then x1:= Pl[1].x + 5 + ActivationWidth
    else x1:= Pl[1].x + 5;

  y1:= Pl[1].Y - 1 - TextRect.Bottom;
  OffsetRect(TextRect, x1, y1);
  DrawText(Canvas.Handle, PChar(aMessage), -1, TextRect, Flags);
  Conrect.Union(TextRect);
end;

procedure TConnection.CalcPolyline;
  var x1, y1: Integer;
begin
{         DistX
      P1----------P2
                   |  DistY
                   |
         P4<------P3
}

  FromP.x:= FFrom.Left + FFrom.Width div 2 + FromActivation*ActivationWidth; // first point
  FromP.y:= YPos;
  ToP.x  := FTo.Left + FTo.Width div 2 + ToActivation*ActivationWidth; // second point with arrow
  ToP.y  := FromP.y + DistY div 2;

  x1:= FromP.x;
  y1:= FromP.y;

  Pl[1]:= FromP;
  Pl[2]:= Point(x1 + DistX, y1);
  Pl[3]:= Point(x1 + DistX, y1 + DistY div 2);
  Pl[4]:= ToP;

  if ArrowStyle = casReturn then begin
    Dec(Pl[2].x, ActivationWidth);
    Dec(Pl[3].x, ActivationWidth);
  end;

  ConRect:= Rect(Pl[1].X - 2, Pl[2].Y- 2, Pl[2].X + 2, Pl[4].Y + 2);
end;

procedure TConnection.DrawSelection(Canvas: TCanvas; withSelection: Boolean = True);
  var x1, y1, x2, y2, r, xLineDelta, yLineDelta: Integer;
begin
  {--- show selection marks ---------------------------------------------------}
  if Selected or not withSelection then begin
    if withSelection
      then begin
        Canvas.Brush.Color:= FGColor;
        Canvas.Pen.Color:= FGColor;
      end else begin
        Canvas.Brush.Color:= BGColor;
        Canvas.Pen.Color:= BGColor;
      end;
    r:= 5;
    x1:= FromP.x; // first point
    y1:= FromP.y;
    x2:= ToP.x;   // second point with arrow
    y2:= ToP.y;

    xLineDelta:= x2 - x1;
    yLineDelta:= y2 - y1;

    if (xLineDelta = 0) and (yLineDelta = 0) then Exit; // Line is 0 length
    if (abs(xLineDelta) > 20000) or (abs(yLineDelta) > 20000) then Exit; // Line is too long

    if FFrom.Left > FTo.Left then begin
      x1:= x1 - FromActivation*ActivationWidth;
      x2:= x2 + ToActivation*ActivationWidth
    end else begin
      x1:= x1 + FromActivation*ActivationWidth;
      x2:= x2 - ToActivation*ActivationWidth;
    end;

    Canvas.Polygon([
      Point(x1-r, y1-r),
      Point(x1+r, y1-r),
      Point(x1+r, y1+r),
      Point(x1-r, y1+r),
      Point(x1-r, y1-r) ]);
    Canvas.Polygon([
      Point(x2-r, y2-r),
      Point(x2+r, y2-r),
      Point(x2+r, y2+r),
      Point(x2-r, y2+r),
      Point(x2-r, y2-r) ]);
  end;
  Canvas.Brush.Color:= BGColor;
end;

procedure TConnection.UnDrawSelection(Canvas: TCanvas);
begin
  DrawSelection(Canvas, False);
end;

function TConnection.CalcRect(Canvas: TCanvas; AMaxWidth: Integer; const AString: string): TRect;
begin
  Result := Rect(0, 0, AMaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AString), -1, Result, DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
end;

constructor TConnection.Create(Src, Dst: TControl; Attributes: TConnectionAttributes; aOnConnectionChanged: TConnectionChanged);
begin
  FFrom       := Src;
  FTo         := Dst;
  Selected    := False;
  ArrowStyle  := Attributes.ArrowStyle;
  ConnectStyle:= csThin;
  aMessage    := Attributes.aMessage;
  isRecursiv  := (FFrom = FTo);
  YPos        := 0;
  FromP       := Point(FFrom.Left + FFrom.Width div 2, FFrom.Top + YPos);
  ToP         := Point(FTo.Left + FTo.Width div 2, FFrom.Top + YPos);
  Self.OnConnectionChanged:= aOnConnectionChanged;
  ConRect     := Rect(0, 0, 0, 0);
  CalcPolyline;
  ChangeStyle;
end;

procedure TConnection.SetAttributes(Attributes: TConnectionAttributes);
begin
  aMessage:= Attributes.aMessage;
  if isRecursiv and (Attributes.ArrowStyle <= casReturn) or not isRecursiv then
    setArrow(Attributes.ArrowStyle);
end;

procedure TConnection.SetArrow(aArrowStyle: TArrowStyle);
begin
  ConnectStyle:= csThin;
  if Self.ArrowStyle <> aArrowStyle then begin
    onConnectionChanged(Self, Self.ArrowStyle, aArrowStyle);
    if (Self.ArrowStyle = casReturn) or (aArrowStyle = casReturn) then
      Turn;
    Self.ArrowStyle:= aArrowStyle;
  end;
end;

procedure TConnection.Turn;
  var Src: TControl; Point: TPoint;
begin
  if IsRecursiv then
    CalcPolyline
  else begin
    Src:= FFrom; FFrom:= FTo; FTo:= Src;
    Point:= FromP; FromP:= ToP; ToP:= Point;
  end;
end;

function TConnection.IsClicked(P: TPoint): Boolean;
  var i: Integer;
      R: TRect;
      x1, x2, y1, y2, h: Integer;

  function makeRect(P1, P2: TPoint): TRect;
    var dx, dy: Integer;
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
  Result:= True;
  if isRecursiv then begin
    for i:= 1 to 3 do begin
      R:= makeRect(Pl[i], Pl[i+1]);
      if PtinRect(R, P) then Exit;
    end;
    R:= makeRect(Pl[4], Pl[3]);
    if PtInRect(R, P) then Exit;
  end else begin
    x1:= FromP.X;
    y1:= FromP.Y;
    x2:= ToP.X;
    y2:= ToP.Y;
    if FFrom.Left > FTo.Left then begin
      x1:= x1 - FromActivation*ActivationWidth;
      x2:= x2 + ToActivation*ActivationWidth
    end else begin
      x1:= x1 + FromActivation*ActivationWidth;
      x2:= x2 - ToActivation*ActivationWidth;
    end;
    if x1 > x2 then begin
      h:= x2;
      x2:= x1;
      x1:= h;
    end;
    if (x1 <= P.X) and (P.X <= x2) and (y1 - 10 <= P.Y) and (P.Y <= y2 + 10) then
      Exit;
  end;
  Result:= False;
end;

function TConnection.hasRect: TRect;
begin
  Result:= ConRect;
end;

function TConnection.getArrowStyleAsString: string;
begin
  Result:= '';
  case ArrowStyle of
    casSynchron:  Result:= ' -> ';
    casAsynchron: Result:= ' ->> ';
    casReturn:    Result:= ' --> ';
    casNew:       Result:= ' ->o ';
    casClose:     Result:= ' ->x ';
  end;
end;

procedure TConnection.setFont(aFont: TFont);
begin
  DistX:= Round(cDistX*aFont.Size/12.0);
  DistY:= Round(cDistY*aFont.Size/12.0);
  ActivationWidth:= Round(cActivationWidth*aFont.Size/12.0);
  HeadLength:= Round(cHeadLength*aFont.Size/12.0);
end;

procedure TConnection.ChangeStyle(BlackAndWhite: Boolean = False);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then
  begin
    BGColor := clWhite;
    FGColor := clBlack;
  end
  else
  begin
    BGColor := StyleServices.GetStyleColor(scPanel);
    FGColor := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal);
  end;
end;

{--- TSequencePanel -----------------------------------------------------------}

function TSequencePanel.AddManagedObject(AObject: TControl): TControl;
var
  crkObj : TCrackControl;
  newObj: TManagedObject;
begin
  Result := nil;
  if AObject.Left + AObject.Width > Width  then Width := Max(Width, AObject.Left + AObject.Width + 50);
  if AObject.Top + AObject.Height > Height then Height:= Max(Height, AObject.Top + AObject.Height + 50);

  AObject.Parent := Self;
  AObject.Visible := True;
  if FindManagedControl(AObject) = nil then begin
    newObj := TManagedObject.Create;
    newObj.FControl:= AObject;
    newObj.Visible:= True;
    FManagedObjects.Add(newObj);
    crkObj := TCrackControl(AObject);
    newObj.FOnMouseDown:= crkObj.OnMouseDown;
    newObj.FOnMouseMove:= crkObj.OnMouseMove;
    newObj.FOnMouseUp  := crkObj.OnMouseUp;
    newObj.FOnClick    := crkObj.OnClick;
    newObj.FOnDblClick := crkObj.OnDblClick;

    crkObj.OnMouseDown := OnManagedObjectMouseDown;
    crkObj.OnMouseMove := OnManagedObjectMouseMove;
    crkObj.OnMouseUp   := OnManagedObjectMouseUp;
    crkObj.OnClick     := OnManagedObjectClick;
    crkObj.OnDblClick  := OnManagedObjectDblClick;
    Result := AObject;
  end;
end;

procedure TSequencePanel.ClearManagedObjects;
var
  i: Integer; aManagedObject: TManagedObject;
begin
  FConnections.Clear;
  try
    for i:= 0 to FManagedObjects.Count - 1 do begin
      aManagedObject:= TManagedObject(FManagedObjects[i]);
      FreeAndNil(aManagedObject.FControl);
      FreeAndNil(aManagedObject);
    end;
  except on e: Exception do
    ErrorMsg(e.Message);
  end;
  FManagedObjects.Clear;
  SetBounds(0, 0, 0, 0);
  FIsModified := False;
end;

function TSequencePanel.SelectionChangedOnClear: Boolean;
  var i: Integer;
begin
  Result:= False;
  for i:= 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[i]).Selected then begin
      TManagedObject(FManagedObjects[i]).Selected:= False;
      Result:= True;
    end;
  for i:= 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then begin
      TConnection(FConnections[i]).Selected:= False;
      TConnection(FConnections[i]).UnDrawSelection(Canvas);
      Result:= True;
    end;
end;

procedure TSequencePanel.ClearSelection(WithShowAll: Boolean = True);
  var i: Integer;
begin
  for i:= 0 to FManagedObjects.Count - 1 do
    TManagedObject(FManagedObjects[i]).Selected:= False;
  for i:= 0 to FConnections.Count - 1 do
    TConnection(FConnections[i]).Selected:= False;
  if withShowAll then
    ShowAll;
  if Assigned(OnSelectionChanged) then
    OnSelectionChanged(nil);
end;

procedure TSequencePanel.ShowAll;
  var i: Integer;
begin
  if Assigned(OnShowAll) then
    OnShowAll(nil);
  if isLocked then Exit;
  ShowConnections;
  for i:= 0 to FManagedObjects.Count -1 do
    if TManagedObject(FManagedObjects[i]).FControl.Visible then
      TManagedObject(FManagedObjects[i]).FControl.Invalidate;  // calls LifeLine.Paint
end;

procedure TSequencePanel.WMEraseBkgnd(var Message: TWmEraseBkgnd);
var
  can : Tcanvas;
begin
  can := tcanvas.Create;
  try
    can.handle := message.DC;
    if Assigned(FBackBitmap) then
      Can.Brush.Bitmap := FBackBitmap
    else
      Can.Brush.Color := Color;
    Can.FillRect(ClientRect);
  finally
    FreeAndNil(can);
  end;
  Message.Result := 1;
end;

function TSequencePanel.ConnectObjects(Src, Dst: TControl; Attributes: TConnectionAttributes): TConnection;
begin
  Result:= nil;
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) then begin
    Result:= TConnection.Create(Src, Dst, Attributes, onConnectionChanged);
    Result.setFont(Font);
    FConnections.Add(Result);
  end;
  OnConnectionSet(Result);
end;

function TSequencePanel.ConnectObjectsAt(Src, Dst: TControl; Attributes: TConnectionAttributes; i: Integer): TConnection;
begin
  Result:= nil;
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) then begin
    Result:= TConnection.Create(Src, Dst, Attributes, OnConnectionChanged);
    Result.setFont(Font);
    if i = -1
      then FConnections.Add(Result)
      else FConnections.Insert(i, Result);
  end;
  OnConnectionSet(Result);
end;

function TSequencePanel.GetClickedConnectionNr: Integer;
  var P: TPoint; conn: TConnection;
begin
  P:= Self.ScreenToClient(Mouse.CursorPos);
  Result:= 0;
  while Result < FConnections.Count do begin
    Conn:= TConnection(FConnections[Result]);
    if Conn.IsClicked(P) then begin
      Conn.Selected:= True;
      Exit;
    end;
    Inc(Result);
  end;
  Result:= -1;
end;

procedure TSequencePanel.DeleteConnections;
begin
  FConnections.Clear;
end;

constructor TSequencePanel.Create(AOwner: TComponent);
begin
  inherited;
  SequenceForm:= (AOwner as TScrollBox).Parent as TForm;
  FManagedObjects := TList.Create;
  FConnections := TObjectList.Create(True);
  FShowConnections:= 0;
  TempHidden := TObjectList.Create(False);
  UseDockManager := True;
  MouseDownOK:= True;
  Anchors:= [akLeft, akTop];
  SetFocus;
end;

procedure TSequencePanel.DblClick;
  // on plain background
  var found: TControl;
begin
  inherited;
  found:= FindVCLWindow(Mouse.CursorPos);
  if Assigned(found) then begin
    FindManagedControl(found);
    if found <> Self then
      TCrackControl(found).DblClick;
    if GetClickedConnectionNr <> -1 then
      SelectClickedConnection
    else if Assigned(OnBackgroundDblClicked) then
      OnBackgroundDblClicked(nil, getConnectionOfClickedTextRect);
  end
end;

function TSequencePanel.getConnectionOfClickedTextRect: TConnection;
  var i: Integer; P: TPoint; conn: TConnection;
begin
  Result:= nil;
  P:= Self.ScreenToClient(Mouse.CursorPos);
  i:= 0;
  while i < FConnections.Count do begin
    Conn:= TConnection(FConnections[i]);
    if PtInRect(Conn.TextRect, P) then begin
      Result:= Conn;
      i:= FConnections.Count;
    end;
    Inc(i);
  end;
end;

function TSequencePanel.GetClickedConnection: TConnection;
  var Nr: Integer;
begin
  Nr:= GetClickedConnectionNr;
  if Nr <> -1
    then Result:= TConnection(FConnections[Nr])
    else Result:= nil;
end;

procedure TSequencePanel.TurnConnection(i: Integer);
begin
  TConnection(FConnections[i]).Turn;
end;

procedure TSequencePanel.SelectConnection;
  var i: Integer;
      Tmp : TObjectList;
      Attributes: TConnectionAttributes;
      conn: TConnection; 
      SelectedControls: Integer;
      FConnectForm: TFConnectForm;
begin
  FConnectForm:= TFConnectForm.Create(Self);
  conn:= getSelectedConnection;
  SelectedControls:= CountSelectedControls;
  if conn = nil then
    case SelectedControls of
      1: FConnectForm.init(False, conn, 1);
      2: FConnectForm.init(False, conn, 2)
      else Exit;
    end
  else
    FConnectForm.init(False, conn, SelectedControls);

  case FConnectForm.ShowModal of
    mrOk: begin
      Attributes:= FConnectForm.getConnectionAttributes;
      if HasSelectedConnection then
        SetSelectedConnection(Attributes)
      else begin
        Tmp:= GetSelectedControls;
        case Tmp.Count of
          1: ConnectObjects(Tmp[0] as TControl, Tmp[0] as TControl, Attributes);
          2: ConnectObjects(Tmp[0] as TControl, Tmp[1] as TControl, Attributes);
        end;
        FreeAndNil(Tmp);
      end;
      FreeAndNil(Attributes);
    end;
    mrYes: // turn
      for i:= 0 to FConnections.Count - 1 do
        if TConnection(FConnections[i]).Selected then
          TurnConnection(i);
    mrNo:
      DeleteSelectedConnection;
  end;
  FConnectForm.Release;
  Invalidate;
  ShowAll;
  IsModified:= True;
end;

procedure TSequencePanel.SelectClickedConnection;
  var conn: TConnection;
begin
  conn:= getClickedConnection;
  if Assigned(conn) then begin
    conn.selected:= True;
    SelectConnection;
  end;
end;

procedure TSequencePanel.ConnectBoxesAt(Src, Dest: TControl; at: Integer);
  var Attributes: TConnectionAttributes;
      SelectedControls, i, pos: Integer;
      FConnectForm: TFConnectForm;
begin
  FConnectForm:= TFConnectForm.Create(Self);
  SelectedControls:= CountSelectedControls;
  case SelectedControls of
    1: FConnectForm.init(False, nil, 1);
    2: FConnectForm.init(False, nil, 2)
    else Exit;
  end;
  if FConnectForm.ShowModal =  mrOk then begin
    Attributes:= FConnectForm.getConnectionAttributes;
    i:= 0;
    pos:= -1;
    while (i < FConnections.Count) and (pos = -1) do begin
      if TConnection(FConnections[i]).yPos >= at then
        pos:= i;
      Inc(i);
    end;
    case SelectedControls of
      1: ConnectObjectsAt(Src, Src, Attributes, pos);
      2: ConnectObjectsAt(Src, Dest, Attributes, pos);
    end;
    FreeAndNil(Attributes);
  end;
  ClearSelection(False);
  Invalidate;
  ShowAll;
  IsModified:= True;
  FConnectForm.Release;
end;

procedure TSequencePanel.DoConnection(Item: Integer);
  var i, n: Integer; conn: TConnection;
begin
  conn:= nil;
  n:= -1;
  for i:= 0 to FConnections.Count-1 do
    if TConnection(FConnections[i]).Selected then begin
      n:= i;
      conn:= TConnection(FConnections[i]);
    end;
  if n <> -1 then begin
    case Item of
       0..4: SetConnection(n, TArrowStyle(Item));
       5   : SelectConnection; // Message
       6   : TurnConnection(n);
      else begin
        Canvas.FillRect(conn.ConRect);
        FConnections.Delete(n);
      end;
    end;
    if Item <= 6 then begin
      conn.Selected:= False;
      InvalidateRect(Handle, conn.ConRect, True);
//      conn.Draw(Canvas);
    end else
      ShowAll;
    isModified:= True;
  end;
end;

destructor TSequencePanel.Destroy;
begin
  FreeAndNil(TempHidden);
  ClearManagedObjects;
  FreeAndNil(FManagedObjects);
  FreeAndNil(FConnections);
  inherited;
end;

function TSequencePanel.FindManagedControl(AControl: TControl): TManagedObject;
var
  i: Integer;
  curr: TManagedObject;
begin
  Result := nil;
  for i:= 0 to FManagedObjects.Count - 1 do begin
    curr := TManagedObject(FManagedObjects[i]);
    if curr.FControl = AControl then begin
      Result := curr;
      Exit;
    end;
  end;
end;

function TSequencePanel.GetConnections: TList;
var
  i: Integer;
begin
  Result:= TList.Create;
  for i:= 0 to FConnections.Count-1 do
    Result.Add(FConnections[I]);
end;

procedure TSequencePanel.SetConnection(i: Integer; Arrow: TArrowStyle);
begin
  if (0 <= i) and (i < FConnections.Count) then
    TConnection(FConnections[i]).setArrow(Arrow);
end;

procedure TSequencePanel.SetSelectedConnection(Attributes: TConnectionAttributes);
  var i: Integer;
begin
  for i:= 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then
      TConnection(FConnections[i]).setAttributes(Attributes);
end;

procedure TSequencePanel.DeleteSelectedConnection;
  var i: Integer;
begin
  for i:= FConnections.Count-1 downto 0 do
    if TConnection(FConnections[i]).Selected then begin
      FConnections.Delete(i);
      IsModified:= True;
    end;
end;

function TSequencePanel.HasSelectedConnection: Boolean;
  var i: Integer;
begin
  Result:= False;
  for i:= FConnections.Count-1 downto 0 do
    if TConnection(FConnections[i]).Selected then begin
      Result:= True;
      Break;
    end;
end;

function TSequencePanel.getSelectedConnection: TConnection;
  var i: Integer;
begin
  Result:= nil;
  for i:= 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then begin
      Result:= TConnection(FConnections[i]);
      Exit;
    end;
end;

function TSequencePanel.GetLastConnection: TConnection;
begin
  if FConnections.Count > 1
    then Result:= TConnection(FConnections[FConnections.Count-1])
    else Result:= nil;
end;

function TSequencePanel.Get2NdLastConnection: TConnection;
begin
  if FConnections.Count > 1
    then Result:= TConnection(FConnections[FConnections.Count-2])
    else Result:= nil;
end;

function TSequencePanel.CountSelectedControls: Integer;
  var i, n: Integer;
begin
  n:= 0;
  for i:= 0 to FManagedObjects.Count-1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
      Inc(n);
  Result:= n;
end;

function TSequencePanel.GetFirstSelected: TControl;
  var i: Integer;
begin
  Result:= nil;
  for i:= 0 to FManagedObjects.Count-1 do
    if TManagedObject(FManagedObjects[i]).FSelected then begin
      Result:= TManagedObject(FManagedObjects[i]).FControl;
      Exit;
    end;
end;

function TSequencePanel.GetSelectedControls: TObjectList;
  var i: Integer;
begin
  Result:= TObjectList.Create(False);
  for i:= 0 to FManagedObjects.Count-1 do
    if TManagedObject(FManagedObjects[i]).FSelected then
      Result.Add(TManagedObject(FManagedObjects[i]).FControl);
end;

procedure TSequencePanel.DeleteSelectedControls;
  var i, j: Integer; Control: TControl; Conn: TConnection;  ManagedObject: TManagedObject;
begin
  for i:= FManagedObjects.Count - 1 downto 0 do
    if TManagedObject(FManagedObjects[i]).FSelected then begin
      ManagedObject:= TManagedObject(FManagedObjects[i]);
      Control:= TManagedObject(FManagedObjects[i]).FControl;
      for j:= FConnections.Count - 1 downto 0 do begin
        Conn:= TConnection(FConnections[j]);
        if (Conn.FFrom = Control) or (Conn.FTo = Control) then
          FConnections.Delete(j);
      end;
      FManagedObjects.Delete(i);
      FreeAndNil(ManagedObject);
      FreeAndNil(Control);
      IsModified := True;
    end;
  RecalcSize;
  ClearSelection;
end;

// central MouseDown routine for the TSequencePanel
procedure TSequencePanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  found: TControl;
  mcont: TManagedObject;
  cconn: TConnection;
  aChanged: Boolean;
  p2: TPoint;
  conn: TConnection;
begin
  FMoved:= False;
  if not MouseDownOK then begin MouseDownOK:= True; Exit end;
  inherited;
  SetFocus;  // a TPanel can have the Focus
  if GetCaptureControl <> Self then
    SetCaptureControl(Self);
  FIsRectSelecting := False;
  FIsMoving := False;
  FResized:= False;
  FMemMousePos.x := X;
  FMemMousePos.y := Y;
  aChanged:= False;

  found:= FindVCLWindow(Mouse.CursorPos);
  if found = Self then
    found := nil;
  if Assigned(found) then begin
    mcont := FindManagedControl(found);
    if Assigned(mcont) then begin
      if not mcont.Selected then begin
        if not CtrlPressed then
          SelectionChangedOnClear;
        mcont.Selected:= True;
        //TManagedObject(mcont).FControl.SendToBack;
        aChanged:= True;
      end else if CtrlPressed then begin
        mcont.Selected:= False;
        aChanged:= True;
      end;
      if aChanged then
        ShowAll;
      if CountSelectedControls > 1 then
        FIsMoving:= True;
      if Assigned(OnSelectionChanged) then
        OnSelectionChanged(nil);
    end;
  end else begin
    cconn:= GetClickedConnection;
    if Assigned(cconn) then begin
      if not cconn.Selected then begin
        if not CtrlPressed then
          SelectionChangedOnClear;
        cconn.Selected:= True;
      end else if CtrlPressed then
        cconn.Selected:= False;
      if Assigned(OnSelectionChanged) then
        OnSelectionChanged(nil);
    end else begin
      //if SelectionChangedOnClear then
      //  ShowAll;
      if Button = mbLeft then
        FIsRectSelecting := True;
    end;
  end;
  if FIsRectSelecting then begin
    FSelectRect.TopLeft := FMemMousePos;
    FSelectRect.BottomRight := FMemMousePos;
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := clSilver;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
  end;

  if Button = mbRight then begin
      found:= FindVCLWindow(Mouse.CursorPos);
      if Button = mbRight then begin
        conn:= GetClickedConnection;
        if Assigned(conn) then begin
          conn.Selected:= True;
          if conn.isRecursiv then begin
            PopupMenuConnection.Items[3].Visible:= False;
            PopupMenuConnection.Items[4].Visible:= False;
          end else begin
            PopupMenuConnection.Items[3].Visible:= True;
            PopupMenuConnection.Items[4].Visible:= True;
          end;
          PopupMenuConnection.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
        end else if Assigned(found) and (found <> Self) then begin
          if (found is TMemo) then
            found:= (found as TMemo).Parent;
          OnLifeLineSequencePanel(found);
          if Assigned(TCrackControl(found).PopupMenu) and (Button = mbRight) then
            TCrackControl(found).PopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);

          if Assigned(TCrackControl(found).OnMouseUp) then begin
            p2 := found.ScreenToClient(Mouse.CursorPos);
            TCrackControl(found).OnMouseUp(found, Button, Shift, p2.x, p2.y);
          end;
        end else begin
          OnLifeLineSequencePanel(nil);
          PopupMenuLifeLineAndSequencePanel.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
        end;
      end;
  end;
end;

procedure TSequencePanel.MouseMove(Shift: TShiftState; X, Y: Integer);

const minTop = 20;

var
  pt, pt1, p2: TPoint;
  found, Src, Dest: TControl;
  mcont: TManagedObject;
  i, j, k, dx, dy, mdx, mdy: Integer;
  curr: TCrackControl;
  r, rt, MovedRect, MovedRectWithoutConnections, mRectDxDy: TRect;
  resized: Boolean;
  connect: TConnection;

  procedure InMakeVisible(C : TRect);
  begin
    mdx := TScrollBox(Parent).HorzScrollBar.Position;
    mdy := TScrollBox(Parent).VertScrollBar.Position;

    if (dx > 0) and (C.BottomRight.X >= TScrollBox(Parent).HorzScrollBar.Position + Parent.Width) then
      TScrollBox(Parent).HorzScrollBar.Position := C.BottomRight.X - Parent.Width;

    if (dy > 0) and (C.BottomRight.Y >= TScrollBox(Parent).VertScrollBar.Position + Parent.Height) then
      TScrollBox(Parent).VertScrollBar.Position := C.BottomRight.Y - Parent.Height;

    if (dx < 0) and (C.Left <= TScrollBox(Parent).HorzScrollBar.Position) then
      TScrollBox(Parent).HorzScrollBar.Position := C.Left;

    if (dy < 0) and (C.Top <= TScrollBox(Parent).VertScrollBar.Position) then
      TScrollBox(Parent).VertScrollBar.Position := C.Top;

    mdy := mdy - TScrollBox(Parent).VertScrollBar.Position;
    mdx := mdx - TScrollBox(Parent).HorzScrollBar.Position;

    if (mdx <> 0) or (mdy <> 0) then begin
      p2 := Mouse.CursorPos;
      p2.X := p2.X + mdx;
      p2.Y := p2.Y + mdy;
      Mouse.CursorPos := p2;
      Resized:= True;
    end;
  end;

begin
  inherited;
  if shift = [] then Exit;
  pt1 := Mouse.CursorPos;
  pt.x := X;
  pt.Y := Y;
  dx := pt.x - FMemMousePos.x;
  dy := pt.y - FMemMousePos.y;
  if (dx = 0) and (dy = 0) then Exit;
  FMoved:= True;
  if abs(dy) > 3*abs(dx)
    then dx:= 0
    else dy:= 0;

  IntersectRect(r, Parent.ClientRect, BoundsRect);
  r.TopLeft := Parent.ClientToScreen(r.TopLeft);
  r.BottomRight := Parent.ClientToScreen(r.BottomRight);

  if (not PtInRect(r, pt1)) and (not (FIsRectSelecting or FIsMoving)) then
    ReleaseCapture
  else begin
    found:= FindVCLWindow(pt1);
    if FIsRectSelecting then begin
      FMemMousePos := pt;
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Color := clSilver;
      Canvas.Pen.Mode := pmXor;
      Canvas.Pen.Width := 0;
      Canvas.Rectangle(FSelectRect);
      FSelectRect.BottomRight := FMemMousePos;
      Canvas.Rectangle(FSelectRect);
    end
    else if ssLeft in Shift then begin
      //  Move the selected boxes
      if (Abs(dx) + Abs(dy) > 5) or FIsMoving then begin
        Resized:= False;
        MovedRect:= Rect(MaxInt, 0, 0, 0);
        MovedRectWithoutConnections:= Rect(MaxInt, 0, 0, 0);
        for i:= 0 to FManagedObjects.Count -1 do // ResumeDrawing
          SendMessage((TManagedObject(FManagedObjects[i]).FControl as TWinControl).Handle , WM_SETREDRAW, 1, 0);
        for i:= 0 to FManagedObjects.Count -1 do begin
          mcont:= TManagedObject(FManagedObjects[i]);
          if not mcont.Visible then Continue;

          curr:= TCrackControl(mcont.FControl);
          if TManagedObject(FManagedObjects[i]).Selected then begin
            mRectDxDy:= curr.BoundsRect;

            // debug
            //  Canvas.Brush.Color:= clBlue;
            //  Canvas.FrameRect(mRectDxDy);

            if (curr.Left + dx >= 0) and (dx <> 0) then
              curr.Left:= curr.Left + dx;
            if dy <> 0 then
              for j:= 0 to FManagedObjects.Count -1 do
                TManagedObject(FManagedObjects[j]).FControl.Top:=
                  Min(Max(TManagedObject(FManagedObjects[j]).FControl.Top + dy, minTop), 500);
            rt:= curr.BoundsRect;
            mRectDxDy.Union(rt);

            // scrolling
            if curr.Left + curr.Width + 50 > Width then begin
              Width:= curr.Left + curr.Width + 50;
              Resized:= True;
            end;
            if curr.Top + curr.Height + 50 > Height then begin
              Height:= curr.Top + curr.Height + 50;
              Resized:= True;
            end;

            if MovedRect.Left = MaxInt
              then MovedRect:= mRectDxDy
              else UnionRect(MovedRect, mRectDxDy, MovedRect);

            if MovedRectWithoutConnections.Left = MaxInt
              then MovedRectWithoutConnections:= mRectDxDy
              else UnionRect(MovedRectWithoutConnections, mRectDxDy, MovedRectWithoutConnections);

            // debug
            //   Canvas.Brush.Color:= clRed;
            //   Canvas.FrameRect(MovedRect);

            Src:= mcont.FControl;
            for j:= 0 to FManagedObjects.Count-1 do begin
              if not TManagedObject(FManagedObjects[j]).Visible then Continue;
              Dest:= TManagedObject(FManagedObjects[j]).FControl;
              for k:= 0 to FConnections.Count-1 do begin
                Connect:= TConnection(FConnections[k]);
                if ((Connect.FFrom = Src) and (Connect.FTo = Dest)) or
                   ((Connect.FFrom = Dest) and (Connect.FTo = Src)) then begin
                  UnionRect(MovedRect, connect.hasRect, MovedRect);
                end;
              end;
            end;
          end;
        end;

        // debug
        //   Canvas.Brush.Color:= clRed;
        //   Canvas.FrameRect(MovedRect);

        IsModified:= True;
        FMemMousePos:= pt;
        FIsMoving:= True;

        if MovedRect.Left <> MaxInt then
          InMakeVisible(MovedRectWithoutConnections);

        if Resized then
          MovedRect:= Boundsrect;
        Invalidate;

      end else if Assigned(found) then begin
        if Assigned(TCrackControl(found).OnMouseMove) then begin
          p2 := found.ScreenToClient(pt);
          TCrackControl(found).OnMouseMove(found, Shift, p2.x, p2.y);
        end;
      end;  
    end;
  end;
end;

procedure TSequencePanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
  r: TRect;
begin
  inherited;
  FIsMoving := False;
  pt.X := X;
  pt.Y := Y;
  IntersectRect(r, Parent.ClientRect, BoundsRect);
  r.TopLeft := Parent.ClientToScreen(r.TopLeft);
  r.BottomRight := Parent.ClientToScreen(r.BottomRight);
  r.TopLeft := ScreenToClient(r.TopLeft);
  r.BottomRight := ScreenToClient(r.BottomRight);

  if FIsRectSelecting then begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
    Canvas.Rectangle(FSelectRect);
    SelectObjectsInRect(FSelectRect);
    if Assigned(OnSelectionChanged) then
      OnSelectionChanged(nil);
  end else
    if PtInRect(r, pt) then
      SetCaptureControl(nil);
  if FMoved then
    ShowAll;
  FIsRectSelecting:= False;
  FMoved:= False;
end;

function TSequencePanel.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;

  const WHEEL_DIVISOR = 120; // Mouse Wheel standard
  var mdy: Integer;
begin
  mdy := TScrollBox(Parent).VertScrollBar.Position - WheelDelta;
  TScrollBox(Parent).VertScrollBar.Position:= mdy;
  Result := True;
end;

procedure TSequencePanel.OnManagedObjectClick(Sender: TObject);
var
  inst: TManagedObject;
begin
  inst:= FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnClick) then
    inst.FOnClick(Sender);
end;

procedure TSequencePanel.OnManagedObjectDblClick(Sender: TObject);
var
  inst: TManagedObject;
  Conn: TConnection;
begin
  inst:= FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnDblClick) then begin
    MouseDownOK:= False;
    ClearSelection;
    conn:= getClickedConnection;
    if Assigned(conn) then begin
      conn.selected:= True;
      SelectConnection;
    end else
      inst.FOnDblClick(Sender);
  end;
end;

procedure TSequencePanel.OnManagedObjectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  if (not Focused) or (GetCaptureControl<>Self) then begin
    // Call the essConnectpanel MouseDown instead.
    pt.x := X;
    pt.y := Y;
    pt := (Sender as TControl).ClientToScreen(pt);
    pt := ScreenToClient(pt);
    MouseDown(Button, Shift, pt.x, pt.y);
  end;
end;

procedure TSequencePanel.OnManagedObjectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  inst: TManagedObject;
begin
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnMouseMove)
    then inst.FOnMouseMove(Sender,Shift,X,Y);
end;

procedure TSequencePanel.OnManagedObjectMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  inst: TManagedObject;
begin
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnMouseUp)
    then inst.FOnMouseUp(Sender,Button,Shift,X,Y);
end;

procedure TSequencePanel.Paint;
begin
  Canvas.Pen.Mode := pmCopy;
  if Assigned(FBackBitmap) then
    Canvas.Brush.Bitmap := FBackBitmap;
  Canvas.Pen.Color:= FGColor;
  Canvas.Brush.Color:= BGColor;
  Canvas.FillRect(ClientRect);
  Canvas.Font:= Font;
  Canvas.Font.Color:= FGColor;
  ShowConnections;
  for var i:= 0 to FManagedObjects.Count -1 do
    if TManagedObject(FManagedObjects[i]).FControl.Visible then
      TManagedObject(FManagedObjects[i]).FControl.Invalidate;
end;

procedure TSequencePanel.ShowConnections;
  var i: Integer; Conn: TConnection;
begin
  for i:= 0 to FConnections.Count -1 do begin
    Conn:= (FConnections[i] as TConnection);
    if Conn.FFrom.Visible and Conn.FTo.Visible then
      Conn.Draw(Canvas);
  end;
end;

procedure TSequencePanel.RecalcSize;
  var i, xmax, ymax: Integer;
begin
  if Assigned(Parent) then begin
    xmax:= Parent.Width - 4; // 300;
    ymax:= Parent.Height- 4; // 150;
  end else begin
    xmax:= 300;
    ymax:= 150;
  end;
  for i:= 0 to ControlCount - 1 do begin
    if (Controls[i].Align <> alNone) or (not Controls[i].Visible) then
      Continue;
    xmax:= Max(xmax, Controls[i].Left + Controls[i].Width + 20);
    ymax:= Max(ymax, Controls[i].Top + Controls[i].Height + 20);
  end;
  if (Width <> xmax) or (Height <> ymax) then
    SetBounds(Left, Top, xmax, ymax);
  if Assigned(OnContentChanged) then
    OnContentChanged(nil);
end;

procedure TSequencePanel.GetDiagramSize(var W, H: Integer);
  var i: Integer;
begin
  W:= 300;
  H:= 150;
  for i:= 0 to ControlCount - 1 do begin
    if (Controls[i].Align <> alNone) or (not Controls[i].Visible) then
      Continue;
    W:= Max(W, Controls[i].Left + Controls[i].Width + 10);
    H:= Max(H, Controls[i].Top + Controls[i].Height + 10);
  end;
end;

procedure TSequencePanel.SelectObjectsInRect(SelRect: TRect);
var
  i: Integer;
  r1, r2: TRect;
begin
  r1 := SelRect;
  if SelRect.Top > SelRect.Bottom then begin
    SelRect.Top := r1.Bottom;
    SelRect.Bottom := r1.Top;
  end;
  if SelRect.Left > SelRect.Right then begin
    SelRect.Left := r1.Right;
    SelRect.Right := r1.Left;
  end;

  for i:= 0 to FManagedObjects.Count - 1 do begin
    if Assigned(TManagedObject(FManagedObjects[i]).FControl) then begin
      r1 := TCrackControl(TManagedObject(FManagedObjects[i]).FControl).BoundsRect;
      IntersectRect(r2, SelRect, r1);
      if EqualRect(r1, r2) and TManagedObject(FManagedObjects[i]).FControl.Visible then
        TManagedObject(FManagedObjects[i]).Selected := True;
      if Assigned(OnSelectionChanged) then
        OnSelectionChanged(nil);
    end;
  end;
end;

procedure TSequencePanel.SetFocus;
var
  F : TCustomForm;
  X, Y : Integer;
begin
  F := GetParentForm(Self);

  // Try to see if we can call inherited, otherwise there is a risc of getting
  // 'Cannot focus' exception when starting from delphi-tools.
  if CanFocus and Assigned(F) and F.Active then
  begin
    // To avoid having the scrollbox resetting its positions after a setfocus call.
    X := (Parent as TScrollBox).HorzScrollBar.Position;
    Y := (Parent as TScrollBox).VertScrollBar.Position;
    inherited;
    (Parent as TScrollBox).HorzScrollBar.Position := X;
    (Parent as TScrollBox).VertScrollBar.Position := Y;
  end;
end;

procedure TSequencePanel.SetModified(const Value : Boolean);
begin
  if FIsModified <> Value then begin
    FIsModified:= Value;
    if Assigned(OnModified) then
      OnModified(nil);
  end;
end;

procedure TSequencePanel.SetLocked(const Value : Boolean);
begin
  if FIsLocked <> Value then begin
    FIsLocked:= Value;
    if not FIsLocked then
      ShowAll;
  end;
end;

procedure TSequencePanel.SetSelectedOnly(const Value : Boolean);
var
  I : Integer;
begin
  if FSelectedOnly <> Value then
  begin
    FSelectedOnly := Value;
    if FSelectedOnly then
    begin
      TempHidden.Clear;
      for i:=0 to FManagedObjects.Count -1 do
        if (not TManagedObject(FManagedObjects[i]).Selected) and TManagedObject(FManagedObjects[i]).FControl.Visible then
        begin
          TManagedObject(FManagedObjects[i]).FControl.Visible := False;
          TempHidden.Add( TObject(FManagedObjects[i]) );
        end;
    end
    else
    begin
      for I := 0 to TempHidden.Count-1 do
        TManagedObject(TempHidden[I]).FControl.Visible := True;
      TempHidden.Clear;
    end;
  end;
end;

procedure TSequencePanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then begin
    DeleteSelectedConnection;
    Invalidate;
  end;
end;

procedure TSequencePanel.setFont(aFont: TFont);
  var i: Integer;
begin
  Self.Font.Assign(aFont);
  for i:= 0 to FConnections.Count - 1 do
    TConnection(FConnections[i]).setFont(aFont);
end;

procedure TSequencePanel.clear;
begin
  Canvas.FrameRect(ClientRect);
end;

procedure TSequencePanel.ChangeStyle(BlackAndWhite: Boolean = False);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then
  begin
    BGColor := clWhite;
    FGColor := clBlack;
  end
  else
  begin
    BGColor := StyleServices.GetStyleColor(scPanel);
    FGColor := StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  Color := BGColor;
  Canvas.Pen.Color := FGColor;
  Canvas.Brush.Color := BGColor;

  for var I := 0 to FConnections.Count - 1 do
    TConnection(FConnections[I]).ChangeStyle(BlackAndWhite);
  for var I := 0 to FManagedObjects.Count - 1 do
    (TManagedObject(FManagedObjects[I]).FControl as TLifeline)
      .ChangeStyle(BlackAndWhite);
end;

function TSequencePanel.GetEnclosingRect: TRect;
var
  Control: TControl;
  Count: Integer;
  ARect: TRect;
begin
  Count := 0;
  Result := Rect(MaxInt, MaxInt, 0, 0);
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do begin
      Control := TManagedObject(FManagedObjects[I]).FControl;
      ARect := Control.BoundsRect;
      if ARect.Top < Result.Top then
        Result.Top := ARect.Top;
      if ARect.Left < Result.Left then
        Result.Left := ARect.Left;
      if ARect.Bottom > Result.Bottom then
        Result.Bottom := ARect.Bottom;
      if ARect.Right > Result.Right then
        Result.Right := ARect.Right;
      Inc(Count);
    end;
  if Count = 0 then
    Result := Rect(0, 0, 0, 0);
end;

{--- TManagedObject -----------------------------------------------------------}

constructor TManagedObject.Create;
begin
  inherited;
  FControl:= nil;
end;

procedure TManagedObject.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
    FSelected := Value;
end;

procedure TManagedObject.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
    FVisible := Value;
end;

end.
