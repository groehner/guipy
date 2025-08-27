{ -------------------------------------------------------------------------------
  Unit:     USequencePanel
  Author:   Gerhard Röhner
  Date:     July 2019
  Purpose:  sequence diagram panel
  Hint:     modified version of UESSConnectPanel
  ------------------------------------------------------------------------------- }

unit USequencePanel;

interface

uses
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  Contnrs,
  Menus,
  SpTBXItem;

const CDistX: Integer = 30; CDistY: Integer = 30; CActivationWidth: Integer = 7;
  CHeadLength: Integer = 10; CMinWidth: Integer = 60; CMinHeight: Integer = 30;

type
  // available linestyles
  TConnectStyle = (csThin, csThinDash);

  // different kinds of arrowheads
  TArrowStyle = (casSynchron, casAsynchron, casReturn, casNew, casClose);

  TConnectionAttributes = class
  private
    FArrowStyle: TArrowStyle;
    FConnectStyle: TConnectStyle;
    FMessage: string;
  public
    property ArrowStyle: TArrowStyle read FArrowStyle write FArrowStyle;
    property AMessage: string read FMessage write FMessage;
    property ConnectStyle: TConnectStyle read FConnectStyle;
  end;

  TConnectionChanged = procedure(Sender: TObject;
    ArrowStyleOld, ArrowStyleNew: TArrowStyle) of object;

  TPolylineArray = array [1 .. 4] of TPoint;

  // Specifies a connection between two managed objects.
  TConnection = class(TConnectionAttributes)
  private
    FActivationWidth: Integer;
    FBackgroundColor: TColor;
    FForegroundColor: TColor;
    FConRect: TRect;
    FDistX: Integer;
    FDistY: Integer;
    FFromActivation: Integer;
    FToActivation: Integer;
    FStartControl: TControl;
    FEndControl: TControl; // from --> to Lifeline
    FStartPoint: TPoint;
    FEndPoint: TPoint; // start/ending of connection
    FHeadLength: Integer;
    FIsRecursiv: Boolean;
    FOnConnectionChanged: TConnectionChanged;
    FPolyline: TPolylineArray;
    FSelected: Boolean;
    FTextRect: TRect;
    FYPosition: Integer;
  public
    constructor Create(Src, Dst: TControl; Attributes: TConnectionAttributes;
      OnConnectionChanged: TConnectionChanged);
    procedure Draw(Canvas: TCanvas);
    procedure DrawRecursiv(Canvas: TCanvas);
    procedure DrawRecursivMessage(Canvas: TCanvas);
    procedure DrawSelection(Canvas: TCanvas; WithSelection: Boolean = True);
    procedure UnDrawSelection(Canvas: TCanvas);
    procedure SetPenBrushArrow(Canvas: TCanvas);
    procedure CalcPolyline;
    procedure SetAttributes(Attributes: TConnectionAttributes);
    procedure SetArrow(ArrowStyle: TArrowStyle);
    procedure Turn;
    function IsClicked(Point: TPoint): Boolean;
    function CalcRect(Canvas: TCanvas; AMaxWidth: Integer;
      const AString: string): TRect;
    function HasRect: TRect;
    function GetArrowStyleAsString: string;
    procedure SetFont(Font: TFont);
    procedure ChangeStyle(BlackAndWhite: Boolean = False);

    property ActivationWidth: Integer read FActivationWidth;
    property BackgroundColor: TColor read FBackgroundColor;
    property ForegroundColor: TColor read FForegroundColor;
    property ConRect: TRect read FConRect;
    property DistX: Integer read FDistX;
    property DistY: Integer read FDistY;
    property FromActivation: Integer read FFromActivation write FFromActivation;
    property HeadLength: Integer read FHeadLength;
    property IsRecursiv: Boolean read FIsRecursiv;
    property OnConnectionChanged: TConnectionChanged read FOnConnectionChanged;
    property StartControl: TControl read FStartControl;
    property EndControl: TControl read FEndControl;
    property StartPoint: TPoint read FStartPoint;
    property EndPoint: TPoint read FEndPoint;
    property Polyline: TPolylineArray read FPolyline;
    property Selected: Boolean read FSelected;
    property TextRect: TRect read FTextRect;
    property ToActivation: Integer read FToActivation write FToActivation;
    property YPosition: Integer read FYPosition write FYPosition;
  end;

  // Wrapper around a control managed by essConnectPanel
  TManagedObject = class
  private
    FSelected: Boolean;
    FVisible: Boolean;
    FControl: TControl;
    // old eventhandlers
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    procedure SetSelected(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  public
    constructor Create;
    property Selected: Boolean read FSelected write SetSelected;
    property Visible: Boolean read FVisible write SetVisible;
    property Control: TControl read FControl;
  end;

  {
    Component that manages a list of contained controls that can be connected with
    somekind of line and allows the user to move it around and gives the containd
    control grabhandles when FSelected.

    Further it manages the layout of the contained controls.
  }

  TBackgroundDblClicked = procedure(Sender: TObject; Conn: TConnection)
    of object;

  TSequencePanel = class(TCustomPanel)
  private
    FMemMousePos: TPoint;
    FSelectRect: TRect;
    FBackBitmap: TBitmap;
    FTempHidden: TObjectList;
    FSequenceForm: TForm;
    FBackgroundColor: TColor;
    FForegroundColor: TColor;
    FMoved: Boolean;
    FManagedObjects: TList;
    FConnections: TObjectList;
    FIsModified: Boolean;
    FIsMoving: Boolean;
    FIsRectSelecting: Boolean;
    FSelectedOnly: Boolean;
    FIsLocked: Boolean;
    FResized: Boolean;
    FChanged: Boolean;
    FShowConnections: Integer;
    FMouseDownOK: Boolean;
    FOnBackgroundDblClicked: TBackgroundDblClicked;
    FOnConnectionChanged: TConnectionChanged;
    FOnConnectionSet: TNotifyEvent;
    FOnContentChanged: TNotifyEvent;
    FOnLifelineSequencePanel: TNotifyEvent;
    FOnModified: TNotifyEvent;
    FOnSelectionChanged: TNotifyEvent;
    FOnShowAll: TNotifyEvent;
    FPopupMenuConnection: TSpTBXPopupMenu;
    FPopupMenuLifelineAndSequencePanel: TPopupMenu;

    procedure SetSelectedOnly(const Value: Boolean);
    procedure SetIsModified(const Value: Boolean);
    procedure SetIsLocked(const Value: Boolean);
    procedure TurnConnection(Num: Integer);
  protected
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SelectObjectsInRect(SelRect: TRect);
    procedure OnManagedObjectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure OnManagedObjectMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectClick(Sender: TObject);
    procedure OnManagedObjectDblClick(Sender: TObject);
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
  public
    // public declarations
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    function FindManagedControl(AControl: TControl): TManagedObject;
    function AddManagedObject(AObject: TControl): TControl;
    function GetFirstSelected: TControl;
    // Returns a objectlist containing the FSelected controls.
    // The list should be freed by the caller.
    function GetSelectedControls: TObjectList;
    procedure DeleteSelectedControls;
    function CountSelectedControls: Integer;

    // Returns a list with all interobject connections.
    // The list should be freed by the caller.
    function GetConnections: TList;
    function Get2NdLastConnection: TConnection;
    function GetLastConnection: TConnection;
    procedure SetConnection(Num: Integer; Arrow: TArrowStyle);
    procedure SetSelectedConnection(Attributes: TConnectionAttributes);
    function GetConnectionOfClickedTextRect: TConnection;
    procedure DeleteConnections;
    procedure DeleteSelectedConnection;
    function HasSelectedConnection: Boolean;
    function GetClickedConnectionNr: Integer;
    function GetClickedConnection: TConnection;
    function GetSelectedConnection: TConnection;

    // Add a connection from Src to Dst with the supplied style
    function ConnectObjects(Src, Dst: TControl;
      Attributes: TConnectionAttributes): TConnection;
    function ConnectObjectsAt(Src, Dst: TControl;
      Attributes: TConnectionAttributes; Pos: Integer): TConnection;
    procedure DoConnection(Item: Integer);
    procedure ClearManagedObjects;
    procedure ClearSelection(WithShowAll: Boolean = True);
    function SelectionChangedOnClear: Boolean;
    procedure ShowAll;
    procedure SetFocus; override;
    procedure SelectConnection;
    procedure SelectClickedConnection;
    procedure ConnectBoxesAt(Src, Dest: TControl; AtPosition: Integer);
    procedure GetDiagramSize(var Width, Height: Integer);
    procedure RecalcSize;
    procedure ShowConnections;
    procedure SetFont(AFont: TFont);
    procedure Clear;
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function GetEnclosingRect: TRect;
    property SelectedOnly: Boolean read FSelectedOnly write SetSelectedOnly;
    property BackBitmap: TBitmap read FBackBitmap write FBackBitmap;
    property IsLocked: Boolean read FIsLocked write SetIsLocked;
    property IsModified: Boolean read FIsModified write SetIsModified;
    property IsMoving: Boolean read FIsMoving write FIsMoving;
    property PopupMenuConnection: TSpTBXPopupMenu read FPopupMenuConnection
      write FPopupMenuConnection;
    property PopupMenuLifelineAndSequencePanel: TPopupMenu
      read FPopupMenuLifelineAndSequencePanel
      write FPopupMenuLifelineAndSequencePanel;
    property OnLifelineSequencePanel: TNotifyEvent read FOnLifelineSequencePanel
      write FOnLifelineSequencePanel;
    property OnBackgroundDblClicked: TBackgroundDblClicked
      read FOnBackgroundDblClicked write FOnBackgroundDblClicked;
    property OnConnectionChanged: TConnectionChanged read FOnConnectionChanged
      write FOnConnectionChanged;
    property OnConnectionSet: TNotifyEvent read FOnConnectionSet
      write FOnConnectionSet;
    property OnContentChanged: TNotifyEvent read FOnContentChanged
      write FOnContentChanged;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
    property OnShowAll: TNotifyEvent read FOnShowAll write FOnShowAll;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged;
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

uses
  Math,
  SysUtils,
  StdCtrls,
  Types,
  Themes,
  UITypes,
  uCommonFunctions,
  UUtils,
  UConnectForm,
  ULifeline;

type
  TCrackControl = class(TControl)
  end;

procedure TConnection.SetPenBrushArrow(Canvas: TCanvas);
begin
  case FConnectStyle of
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
  if FArrowStyle = casReturn then
    Canvas.Pen.Style := psDot;
end;

procedure TConnection.Draw(Canvas: TCanvas);
var X1Pos, X2Pos: Integer; Y1Pos, Y2Pos: Integer; XBase: Integer;
  YBase: Integer; XLineDelta: Integer; XLineUnitDelta: Double;
  XNormalDelta: Integer; XNormalUnitDelta: Double; YLineDelta: Integer;
  YLineUnitDelta: Double; YNormalDelta: Integer; YNormalUnitDelta: Double;
  Tmp1: Double; DeltaX, DeltaY, TextHeight, TextWidth: Integer;
  AbsXLineDelta, AbsYLineDelta: Integer;

  procedure DrawMessage;
  begin
    TextHeight := Canvas.TextHeight('A');
    if FMessage = '' then
      TextWidth := 100
    else
      TextWidth := Canvas.TextWidth(FMessage);
    if X1Pos < X2Pos then
      FTextRect := Bounds(X1Pos + FFromActivation * FActivationWidth + 5,
        Y1Pos - 1 - TextHeight, TextWidth, TextHeight)
    else
      FTextRect := Bounds(X1Pos - FFromActivation * FActivationWidth - 5 -
        TextWidth, Y1Pos - 1 - TextHeight, TextWidth, TextHeight);
    SetBkColor(Canvas.Handle, FBackgroundColor);
    DrawText(Canvas.Handle, PChar(FMessage), -1, FTextRect, DT_CALCRECT);
    DrawText(Canvas.Handle, PChar(FMessage), -1, FTextRect, 0);
    FConRect.Union(FTextRect);
  end;

begin // of draw
  Canvas.Pen.Mode := pmCopy;
  Canvas.Pen.Color := FForegroundColor;
  Canvas.Brush.Color := FBackgroundColor;

  if FIsRecursiv then
  begin
    DrawRecursiv(Canvas);
    Exit;
  end;

  { --- draw connection line --------------------------------------------------- }
  FStartPoint.X := FStartControl.Left + FStartControl.Width div 2;
  // first point
  FStartPoint.Y := FYPosition;
  X1Pos := FStartPoint.X;
  Y1Pos := FStartPoint.Y;

  if FArrowStyle = casNew then
    FEndPoint.X := FEndControl.Left
  else
    FEndPoint.X := FEndControl.Left + FEndControl.Width div 2;
  // second point with arrow
  FEndPoint.Y := FStartPoint.Y;
  X2Pos := FEndPoint.X;
  Y2Pos := FEndPoint.Y;

  XLineDelta := X2Pos - X1Pos;
  YLineDelta := Y2Pos - Y1Pos;
  AbsXLineDelta := Max(Abs(XLineDelta), 1);
  AbsYLineDelta := Max(Abs(YLineDelta), 1);

  if (XLineDelta = 0) and (YLineDelta = 0) then
    Exit; // Line has length 0
  if (AbsXLineDelta > 20000) or (AbsYLineDelta > 20000) then
    Exit; // Line is too long

  Tmp1 := Sqrt(Sqr(XLineDelta) + Sqr(YLineDelta));
  XLineUnitDelta := XLineDelta / Tmp1;
  YLineUnitDelta := YLineDelta / Tmp1;

  // (XBase, YBase) is where arrow line is perpendicular to base of triangle.
  XNormalDelta := YLineDelta;
  YNormalDelta := -XLineDelta;
  XNormalUnitDelta := XNormalDelta /
    Sqrt(Sqr(XNormalDelta) + Sqr(YNormalDelta));
  YNormalUnitDelta := YNormalDelta /
    Sqrt(Sqr(XNormalDelta) + Sqr(YNormalDelta));

  DeltaX := Round(FHeadLength * 0.4 * XNormalUnitDelta);
  DeltaY := Round(FHeadLength * 0.4 * YNormalUnitDelta);

  SetPenBrushArrow(Canvas);

  if FArrowStyle = casClose then
    X2Pos := X2Pos - FActivationWidth
  else if FStartControl.Left > FEndControl.Left then
  begin
    X1Pos := X1Pos - FFromActivation * FActivationWidth;
    X2Pos := X2Pos + FToActivation * FActivationWidth;
  end
  else
  begin
    X1Pos := X1Pos + FFromActivation * FActivationWidth;
    X2Pos := X2Pos - FToActivation * FActivationWidth;
  end;

  // just the line
  Canvas.MoveTo(X1Pos, Y1Pos);
  Canvas.LineTo(X2Pos, Y2Pos);
  // due to unexpected painting of casReturn
  Canvas.MoveTo(X1Pos, Y1Pos);
  Canvas.LineTo(X2Pos, Y2Pos);

  // draw the arrow
  XBase := X2Pos - Round(FHeadLength * XLineUnitDelta);
  YBase := Y2Pos - Round(FHeadLength * YLineUnitDelta);
  case FArrowStyle of
    casSynchron, casNew, casClose:
      begin
        Canvas.Brush.Color := Canvas.Pen.Color;
        Canvas.Polygon([Point(XBase + DeltaX, YBase + DeltaY),
          Point(X2Pos, Y2Pos), Point(XBase - DeltaX, YBase - DeltaY)]);
      end;
    casAsynchron, casReturn:
      begin
        Canvas.Pen.Style := psSolid;
        Canvas.Polyline([Point(XBase + DeltaX, YBase + DeltaY),
          Point(X2Pos, Y2Pos), Point(XBase - DeltaX, YBase - DeltaY)]);
      end;
  end;

  // close Message
  if FArrowStyle = casClose then
  begin
    Canvas.MoveTo(X2Pos, Y2Pos - FHeadLength);
    Canvas.LineTo(X2Pos + 2 * FActivationWidth, Y2Pos + FHeadLength);
    Canvas.MoveTo(X2Pos + 2 * FActivationWidth, Y2Pos - FHeadLength);
    Canvas.LineTo(X2Pos, Y2Pos + FHeadLength);
  end;
  Canvas.Pen.Color := FForegroundColor;
  FConRect := Rect(Min(X1Pos, X2Pos), Min(Y1Pos, Y2Pos) - Abs(DeltaY),
    Max(X1Pos, X2Pos), Max(Y1Pos, Y2Pos) + Abs(DeltaY));
  FConRect.Inflate(FStartControl.PPIScale(2), FStartControl.PPIScale(2));
  DrawMessage;

  // debug
  // Canvas.Brush.Color:= clRed;
  // Canvas.FrameRect(FConRect);
end;

procedure TConnection.DrawRecursiv(Canvas: TCanvas);

  procedure DrawArrowHead(Point1, Point2: TPoint);
  var Point3, Point4: TPoint; DeltaX: Integer;
  begin
    DeltaX := Point2.X - Point1.X;
    Point3.X := Point1.X + Round(FHeadLength) * Sign(DeltaX);
    Point3.Y := Point1.Y - Round(FHeadLength * 0.4);
    Point4.X := Point3.X;
    Point4.Y := Point1.Y + Round(FHeadLength * 0.4);

    case FArrowStyle of
      casAsynchron, casReturn:
        Canvas.Polyline([Point3, Point1, Point4]);
      casSynchron:
        begin
          Canvas.Brush.Color := Canvas.Pen.Color;
          Canvas.Polygon([Point3, Point1, Point4]);
        end;
    end;
    Canvas.Brush.Color := FBackgroundColor;
  end;

begin
  SetPenBrushArrow(Canvas);
  CalcPolyline;
  Canvas.Polyline(FPolyline);
  Canvas.Pen.Width := 1;
  Canvas.Pen.Style := psSolid;
  DrawArrowHead(FPolyline[4], FPolyline[3]);
  DrawRecursivMessage(Canvas);
end;

procedure TConnection.DrawRecursivMessage(Canvas: TCanvas);
var X1Pos, Y1Pos: Integer; Flags: LongInt;
begin
  // Relationname
  Flags := DT_EXPANDTABS or DT_WORDBREAK or DT_NOPREFIX;
  FTextRect := CalcRect(Canvas, MaxInt, FMessage);
  if FArrowStyle = casReturn then
    X1Pos := FPolyline[1].X + 5 + ActivationWidth
  else
    X1Pos := FPolyline[1].X + 5;

  Y1Pos := FPolyline[1].Y - 1 - FTextRect.Bottom;
  OffsetRect(FTextRect, X1Pos, Y1Pos);
  DrawText(Canvas.Handle, PChar(FMessage), -1, FTextRect, Flags);
  ConRect.Union(FTextRect);
end;

procedure TConnection.CalcPolyline;
var X1Pos, Y1Pos: Integer;
begin
  { FDistX
    P1----------P2
    |  FDistY
    |
    P4<------P3
  }

  FStartPoint.X := FStartControl.Left + FStartControl.Width div 2 +
    FFromActivation * FActivationWidth; // first point
  FStartPoint.Y := FYPosition;
  FEndPoint.X := FEndControl.Left + FEndControl.Width div 2 + FToActivation *
    FActivationWidth; // second point with arrow
  FEndPoint.Y := FStartPoint.Y + FDistY div 2;

  X1Pos := FStartPoint.X;
  Y1Pos := FStartPoint.Y;

  FPolyline[1] := FStartPoint;
  FPolyline[2] := Point(X1Pos + FDistX, Y1Pos);
  FPolyline[3] := Point(X1Pos + FDistX, Y1Pos + FDistY div 2);
  FPolyline[4] := FEndPoint;

  if FArrowStyle = casReturn then
  begin
    Dec(FPolyline[2].X, FActivationWidth);
    Dec(FPolyline[3].X, FActivationWidth);
  end;

  FConRect := Rect(FPolyline[1].X - 2, FPolyline[2].Y - 2, FPolyline[2].X + 2,
    FPolyline[4].Y + 2);
end;

procedure TConnection.DrawSelection(Canvas: TCanvas;
  WithSelection: Boolean = True);
var X1Pos, Y1Pos, X2Pos, Y2Pos, SelSize, XLineDelta, YLineDelta: Integer;
begin
  { --- show selection marks --------------------------------------------------- }
  if FSelected or not WithSelection then
  begin
    if WithSelection then
    begin
      Canvas.Brush.Color := FForegroundColor;
      Canvas.Pen.Color := FForegroundColor;
    end
    else
    begin
      Canvas.Brush.Color := FBackgroundColor;
      Canvas.Pen.Color := FBackgroundColor;
    end;
    SelSize := 5;
    X1Pos := FStartPoint.X; // first point
    Y1Pos := FStartPoint.Y;
    X2Pos := FEndPoint.X; // second point with arrow
    Y2Pos := FEndPoint.Y;

    XLineDelta := X2Pos - X1Pos;
    YLineDelta := Y2Pos - Y1Pos;

    if (XLineDelta = 0) and (YLineDelta = 0) then
      Exit; // Line is 0 length
    if (Abs(XLineDelta) > 20000) or (Abs(YLineDelta) > 20000) then
      Exit; // Line is too long

    if StartControl.Left > EndControl.Left then
    begin
      X1Pos := X1Pos - FFromActivation * ActivationWidth;
      X2Pos := X2Pos + FToActivation * ActivationWidth;
    end
    else
    begin
      X1Pos := X1Pos + FFromActivation * ActivationWidth;
      X2Pos := X2Pos - FToActivation * ActivationWidth;
    end;

    Canvas.Polygon([Point(X1Pos - SelSize, Y1Pos - SelSize),
      Point(X1Pos + SelSize, Y1Pos - SelSize), Point(X1Pos + SelSize,
      Y1Pos + SelSize), Point(X1Pos - SelSize, Y1Pos + SelSize),
      Point(X1Pos - SelSize, Y1Pos - SelSize)]);
    Canvas.Polygon([Point(X2Pos - SelSize, Y2Pos - SelSize),
      Point(X2Pos + SelSize, Y2Pos - SelSize), Point(X2Pos + SelSize,
      Y2Pos + SelSize), Point(X2Pos - SelSize, Y2Pos + SelSize),
      Point(X2Pos - SelSize, Y2Pos - SelSize)]);
  end;
  Canvas.Brush.Color := FBackgroundColor;
  Canvas.Pen.Color := FForegroundColor;
end;

procedure TConnection.UnDrawSelection(Canvas: TCanvas);
begin
  DrawSelection(Canvas, False);
end;

function TConnection.CalcRect(Canvas: TCanvas; AMaxWidth: Integer;
  const AString: string): TRect;
begin
  Result := Rect(0, 0, AMaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AString), -1, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX);
end;

constructor TConnection.Create(Src, Dst: TControl;
  Attributes: TConnectionAttributes; OnConnectionChanged: TConnectionChanged);
begin
  FStartControl := Src;
  FEndControl := Dst;
  FSelected := False;
  FArrowStyle := Attributes.ArrowStyle;
  FConnectStyle := csThin;
  FMessage := Attributes.AMessage;
  FIsRecursiv := (FStartControl = FEndControl);
  FYPosition := 0;
  FStartPoint := Point(FStartControl.Left + FStartControl.Width div 2,
    FStartControl.Top + FYPosition);
  FEndPoint := Point(FEndControl.Left + FEndControl.Width div 2,
    FStartControl.Top + FYPosition);
  FOnConnectionChanged := OnConnectionChanged;
  FConRect := Rect(0, 0, 0, 0);
  CalcPolyline;
  ChangeStyle;
end;

procedure TConnection.SetAttributes(Attributes: TConnectionAttributes);
begin
  FMessage := Attributes.AMessage;
  if FIsRecursiv and (Attributes.ArrowStyle <= casReturn) or not FIsRecursiv
  then
    SetArrow(Attributes.ArrowStyle);
end;

procedure TConnection.SetArrow(ArrowStyle: TArrowStyle);
begin
  FConnectStyle := csThin;
  if Self.FArrowStyle <> ArrowStyle then
  begin
    FOnConnectionChanged(Self, Self.FArrowStyle, ArrowStyle);
    if (Self.FArrowStyle = casReturn) or (ArrowStyle = casReturn) then
      Turn;
    Self.FArrowStyle := ArrowStyle;
  end;
end;

procedure TConnection.Turn;
var Src: TControl; Point: TPoint;
begin
  if FIsRecursiv then
    CalcPolyline
  else
  begin
    Src := FStartControl;
    FStartControl := FEndControl;
    FEndControl := Src;
    Point := FStartPoint;
    FStartPoint := FEndPoint;
    FEndPoint := Point;
  end;
end;

function TConnection.IsClicked(Point: TPoint): Boolean;
var ARect: TRect; X1Pos, X2Pos, Y1Pos, Y2Pos, Help: Integer;

  function makeRect(Point1, Point2: TPoint): TRect;
  var DeltaX, DeltaY: Integer;
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
      ARect := makeRect(FPolyline[I], FPolyline[I + 1]);
      if PtInRect(ARect, Point) then
        Exit;
    end;
    ARect := makeRect(FPolyline[4], FPolyline[3]);
    if PtInRect(ARect, Point) then
      Exit;
  end
  else
  begin
    X1Pos := FStartPoint.X;
    Y1Pos := FStartPoint.Y;
    X2Pos := FEndPoint.X;
    Y2Pos := FEndPoint.Y;
    if StartControl.Left > EndControl.Left then
    begin
      X1Pos := X1Pos - FFromActivation * ActivationWidth;
      X2Pos := X2Pos + FToActivation * ActivationWidth;
    end
    else
    begin
      X1Pos := X1Pos + FFromActivation * ActivationWidth;
      X2Pos := X2Pos - FToActivation * ActivationWidth;
    end;
    if X1Pos > X2Pos then
    begin
      Help := X2Pos;
      X2Pos := X1Pos;
      X1Pos := Help;
    end;
    if (X1Pos <= Point.X) and (Point.X <= X2Pos) and (Y1Pos - 10 <= Point.Y) and
      (Point.Y <= Y2Pos + 10) then
      Exit;
  end;
  Result := False;
end;

function TConnection.HasRect: TRect;
begin
  Result := FConRect;
end;

function TConnection.GetArrowStyleAsString: string;
begin
  Result := '';
  case FArrowStyle of
    casSynchron:
      Result := ' -> ';
    casAsynchron:
      Result := ' ->> ';
    casReturn:
      Result := ' --> ';
    casNew:
      Result := ' ->o ';
    casClose:
      Result := ' ->x ';
  end;
end;

procedure TConnection.SetFont(Font: TFont);
begin
  FDistX := Round(CDistX * Font.Size / 12.0);
  FDistY := Round(CDistY * Font.Size / 12.0);
  FActivationWidth := Round(CActivationWidth * Font.Size / 12.0);
  FHeadLength := Round(CHeadLength * Font.Size / 12.0);
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

{ --- TSequencePanel ----------------------------------------------------------- }

function TSequencePanel.AddManagedObject(AObject: TControl): TControl;
var CrkObj: TCrackControl; NewObj: TManagedObject;
begin
  Result := nil;
  if AObject.Left + AObject.Width > Width then
    Width := Max(Width, AObject.Left + AObject.Width + 50);
  if AObject.Top + AObject.Height > Height then
    Height := Max(Height, AObject.Top + AObject.Height + 50);

  AObject.Parent := Self;
  AObject.Visible := True;
  if FindManagedControl(AObject) = nil then
  begin
    NewObj := TManagedObject.Create;
    NewObj.FControl := AObject;
    NewObj.Visible := True;
    FManagedObjects.Add(NewObj);
    CrkObj := TCrackControl(AObject);
    NewObj.FOnMouseDown := CrkObj.OnMouseDown;
    NewObj.FOnMouseMove := CrkObj.OnMouseMove;
    NewObj.FOnMouseUp := CrkObj.OnMouseUp;
    NewObj.FOnClick := CrkObj.OnClick;
    NewObj.FOnDblClick := CrkObj.OnDblClick;

    CrkObj.OnMouseDown := OnManagedObjectMouseDown;
    CrkObj.OnMouseMove := OnManagedObjectMouseMove;
    CrkObj.OnMouseUp := OnManagedObjectMouseUp;
    CrkObj.OnClick := OnManagedObjectClick;
    CrkObj.OnDblClick := OnManagedObjectDblClick;
    Result := AObject;
  end;
end;

procedure TSequencePanel.ClearManagedObjects;
var
  AManagedObject: TManagedObject;
begin
  FConnections.Clear;
  for AManagedObject in FManagedObjects do begin
    AManagedObject.FControl.Free;
    AManagedObject.Free;
  end;
  FManagedObjects.Clear;
  SetBounds(0, 0, 0, 0);
  FIsModified := False;
end;

function TSequencePanel.SelectionChangedOnClear: Boolean;
begin
  Result := False;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
    begin
      TManagedObject(FManagedObjects[I]).FSelected := False;
      Result := True;
    end;
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).FSelected then
    begin
      TConnection(FConnections[I]).FSelected := False;
      TConnection(FConnections[I]).UnDrawSelection(Canvas);
      Result := True;
    end;
end;

procedure TSequencePanel.ClearSelection(WithShowAll: Boolean = True);
begin
  for var I := 0 to FManagedObjects.Count - 1 do
    TManagedObject(FManagedObjects[I]).FSelected := False;
  for var I := 0 to FConnections.Count - 1 do
    TConnection(FConnections[I]).FSelected := False;
  if WithShowAll then
    ShowAll;
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(nil);
end;

procedure TSequencePanel.ShowAll;
begin
  if Assigned(FOnShowAll) then
    FOnShowAll(nil);
  if IsLocked then
    Exit;
  ShowConnections;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FControl.Visible then
      TManagedObject(FManagedObjects[I]).FControl.Invalidate;
  FChanged := False;
  // calls Lifeline.Paint
end;

procedure TSequencePanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  var
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := Message.DC;
    if Assigned(FBackBitmap) then
      Canvas.Brush.Bitmap := FBackBitmap
    else
      Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  finally
    Canvas.Free;
  end;
  Message.Result := 1;
end;

function TSequencePanel.ConnectObjects(Src, Dst: TControl;
  Attributes: TConnectionAttributes): TConnection;
begin
  Result := nil;
  if Assigned(FindManagedControl(Src)) and Assigned(FindManagedControl(Dst))
  then
  begin
    Result := TConnection.Create(Src, Dst, Attributes, FOnConnectionChanged);
    Result.SetFont(Font);
    FConnections.Add(Result);
  end;
  FOnConnectionSet(Result);
end;

function TSequencePanel.ConnectObjectsAt(Src, Dst: TControl;
  Attributes: TConnectionAttributes; Pos: Integer): TConnection;
begin
  Result := nil;
  if Assigned(FindManagedControl(Src)) and Assigned(FindManagedControl(Dst))
  then
  begin
    Result := TConnection.Create(Src, Dst, Attributes, FOnConnectionChanged);
    Result.SetFont(Font);
    if Pos = -1 then
      FConnections.Add(Result)
    else
      FConnections.Insert(Pos, Result);
  end;
  FOnConnectionSet(Result);
end;

function TSequencePanel.GetClickedConnectionNr: Integer;
begin
  var
  Point := Self.ScreenToClient(Mouse.CursorPos);
  Result := 0;
  while Result < FConnections.Count do
  begin
    var
    Conn := TConnection(FConnections[Result]);
    if Conn.IsClicked(Point) then
    begin
      Conn.FSelected := True;
      Exit;
    end;
    Inc(Result);
  end;
  Result := -1;
end;

procedure TSequencePanel.DeleteConnections;
begin
  FConnections.Clear;
end;

constructor TSequencePanel.Create(AOwner: TComponent);
begin
  inherited;
  FSequenceForm := (AOwner as TScrollBox).Parent as TForm;
  FManagedObjects := TList.Create;
  FConnections := TObjectList.Create(True);
  FShowConnections := 0;
  FTempHidden := TObjectList.Create(False);
  UseDockManager := True;
  FMouseDownOK := True;
  Anchors := [akLeft, akTop];
  SetFocus;
end;

procedure TSequencePanel.DblClick;
// on plain background
var Found: TControl;
begin
  inherited;
  Found := FindVCLWindow(Mouse.CursorPos);
  if Assigned(Found) then
  begin
    FindManagedControl(Found);
    if Found <> Self then
      TCrackControl(Found).DblClick;
    if GetClickedConnectionNr <> -1 then
      SelectClickedConnection
    else if Assigned(FOnBackgroundDblClicked) then
      FOnBackgroundDblClicked(nil, GetConnectionOfClickedTextRect);
  end;
end;

function TSequencePanel.GetConnectionOfClickedTextRect: TConnection;
var Int: Integer; Point: TPoint; Conn: TConnection;
begin
  Result := nil;
  Point := Self.ScreenToClient(Mouse.CursorPos);
  Int := 0;
  while Int < FConnections.Count do
  begin
    Conn := TConnection(FConnections[Int]);
    if PtInRect(Conn.FTextRect, Point) then
    begin
      Result := Conn;
      Int := FConnections.Count;
    end;
    Inc(Int);
  end;
end;

function TSequencePanel.GetClickedConnection: TConnection;
begin
  var
  Num := GetClickedConnectionNr;
  if Num <> -1 then
    Result := TConnection(FConnections[Num])
  else
    Result := nil;
end;

procedure TSequencePanel.TurnConnection(Num: Integer);
begin
  TConnection(FConnections[Num]).Turn;
end;

procedure TSequencePanel.SelectConnection;
var Tmp: TObjectList; Attributes: TConnectionAttributes; Conn: TConnection;
  SelectedControls: Integer; FConnectForm: TFConnectForm;
begin
  FConnectForm := TFConnectForm.Create(Self);
  Conn := GetSelectedConnection;
  SelectedControls := CountSelectedControls;
  if not Assigned(Conn) then
    if SelectedControls in [1, 2] then
      FConnectForm.Init(False, Conn)
    else
      Exit
  else
    FConnectForm.Init(False, Conn);

  case FConnectForm.ShowModal of
    mrOk:
      begin
        Attributes := FConnectForm.GetConnectionAttributes;
        if HasSelectedConnection then
          SetSelectedConnection(Attributes)
        else
        begin
          Tmp := GetSelectedControls;
          case Tmp.Count of
            1:
              ConnectObjects(Tmp[0] as TControl, Tmp[0] as TControl,
                Attributes);
            2:
              ConnectObjects(Tmp[0] as TControl, Tmp[1] as TControl,
                Attributes);
          end;
          FreeAndNil(Tmp);
        end;
        FreeAndNil(Attributes);
      end;
    mrYes: // turn
      for var I := 0 to FConnections.Count - 1 do
        if TConnection(FConnections[I]).FSelected then
          TurnConnection(I);
    mrNo:
      DeleteSelectedConnection;
  end;
  FConnectForm.Release;
  Invalidate;
  ShowAll;
  IsModified := True;
end;

procedure TSequencePanel.SelectClickedConnection;
begin
  var
  Conn := GetClickedConnection;
  if Assigned(Conn) then
  begin
    Conn.FSelected := True;
    SelectConnection;
  end;
end;

procedure TSequencePanel.ConnectBoxesAt(Src, Dest: TControl;
  AtPosition: Integer);
var Attributes: TConnectionAttributes; SelectedControls, Int, Pos: Integer;
  FConnectForm: TFConnectForm;
begin
  FConnectForm := TFConnectForm.Create(Self);
  SelectedControls := CountSelectedControls;
  if SelectedControls in [1, 2] then
    FConnectForm.Init(False, nil)
  else
    Exit;
  if FConnectForm.ShowModal = mrOk then
  begin
    Attributes := FConnectForm.GetConnectionAttributes;
    Int := 0;
    Pos := -1;
    while (Int < FConnections.Count) and (Pos = -1) do
    begin
      if TConnection(FConnections[Int]).FYPosition >= AtPosition then
        Pos := Int;
      Inc(Int);
    end;
    case SelectedControls of
      1:
        ConnectObjectsAt(Src, Src, Attributes, Pos);
      2:
        ConnectObjectsAt(Src, Dest, Attributes, Pos);
    end;
    FreeAndNil(Attributes);
  end;
  ClearSelection(False);
  Invalidate;
  ShowAll;
  IsModified := True;
  FConnectForm.Release;
end;

procedure TSequencePanel.DoConnection(Item: Integer);
var Num: Integer; Conn: TConnection;
begin
  Conn := nil;
  Num := -1;
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).FSelected then
    begin
      Num := I;
      Conn := TConnection(FConnections[I]);
    end;
  if Num <> -1 then
  begin
    case Item of
      0 .. 4:
        SetConnection(Num, TArrowStyle(Item));
      5:
        SelectConnection; // Message
      6:
        TurnConnection(Num);
    else
      begin
        Canvas.FillRect(Conn.FConRect);
        FConnections.Delete(Num);
      end;
    end;
    if Item <= 6 then
    begin
      Conn.FSelected := False;
      InvalidateRect(Handle, Conn.FConRect, True);
    end
    else
      ShowAll;
    IsModified := True;
  end;
end;

destructor TSequencePanel.Destroy;
begin
  FreeAndNil(FTempHidden);
  ClearManagedObjects;
  FreeAndNil(FManagedObjects);
  FreeAndNil(FConnections);
  inherited;
end;

function TSequencePanel.FindManagedControl(AControl: TControl): TManagedObject;
begin
  Result := nil;
  for var I := 0 to FManagedObjects.Count - 1 do
  begin
    var
    Curr := TManagedObject(FManagedObjects[I]);
    if Curr.FControl = AControl then
    begin
      Result := Curr;
      Exit;
    end;
  end;
end;

function TSequencePanel.GetConnections: TList;
begin
  Result := TList.Create;
  for var I := 0 to FConnections.Count - 1 do
    Result.Add(FConnections[I]);
end;

procedure TSequencePanel.SetConnection(Num: Integer; Arrow: TArrowStyle);
begin
  if (0 <= Num) and (Num < FConnections.Count) then
    TConnection(FConnections[Num]).SetArrow(Arrow);
end;

procedure TSequencePanel.SetSelectedConnection
  (Attributes: TConnectionAttributes);
begin
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).FSelected then
      TConnection(FConnections[I]).SetAttributes(Attributes);
end;

procedure TSequencePanel.DeleteSelectedConnection;
begin
  for var I := FConnections.Count - 1 downto 0 do
    if TConnection(FConnections[I]).FSelected then
    begin
      FConnections.Delete(I);
      IsModified := True;
    end;
end;

function TSequencePanel.HasSelectedConnection: Boolean;
begin
  Result := False;
  for var I := FConnections.Count - 1 downto 0 do
    if TConnection(FConnections[I]).FSelected then
    begin
      Result := True;
      Break;
    end;
end;

function TSequencePanel.GetSelectedConnection: TConnection;
begin
  Result := nil;
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).FSelected then
    begin
      Result := TConnection(FConnections[I]);
      Exit;
    end;
end;

function TSequencePanel.GetLastConnection: TConnection;
begin
  if FConnections.Count > 1 then
    Result := TConnection(FConnections.Last)
  else
    Result := nil;
end;

function TSequencePanel.Get2NdLastConnection: TConnection;
begin
  if FConnections.Count > 1 then
    Result := TConnection(FConnections[FConnections.Count - 2])
  else
    Result := nil;
end;

function TSequencePanel.CountSelectedControls: Integer;
begin
  var
  Num := 0;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
      Inc(Num);
  Result := Num;
end;

function TSequencePanel.GetFirstSelected: TControl;
begin
  Result := nil;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
    begin
      Result := TManagedObject(FManagedObjects[I]).FControl;
      Exit;
    end;
end;

function TSequencePanel.GetSelectedControls: TObjectList;
begin
  Result := TObjectList.Create(False);
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
      Result.Add(TManagedObject(FManagedObjects[I]).FControl);
end;

procedure TSequencePanel.DeleteSelectedControls;
var Control: TControl; Conn: TConnection; ManagedObject: TManagedObject;
begin
  for var I := FManagedObjects.Count - 1 downto 0 do
    if TManagedObject(FManagedObjects[I]).FSelected then
    begin
      ManagedObject := TManagedObject(FManagedObjects[I]);
      Control := TManagedObject(FManagedObjects[I]).FControl;
      for var J := FConnections.Count - 1 downto 0 do
      begin
        Conn := TConnection(FConnections[J]);
        if (Conn.FStartControl = Control) or (Conn.FEndControl = Control) then
          FConnections.Delete(J);
      end;
      FManagedObjects.Delete(I);
      FreeAndNil(ManagedObject);
      FreeAndNil(Control);
      IsModified := True;
    end;
  RecalcSize;
  ClearSelection;
end;

// central MouseDown routine for the TSequencePanel
procedure TSequencePanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Found: TControl; MCont: TManagedObject; CConn: TConnection;
begin
  FMoved := False;
  if not FMouseDownOK then
  begin
    FMouseDownOK := True;
    Exit;
  end;
  inherited;
  SetFocus; // a TPanel can have the Focus
  if GetCaptureControl <> Self then
    SetCaptureControl(Self);
  FIsRectSelecting := False;
  FIsMoving := False;
  FResized := False;
  FMemMousePos.X := X;
  FMemMousePos.Y := Y;
  FChanged := False;

  Found := FindVCLWindow(Mouse.CursorPos);
  if Found = Self then
    Found := nil;
  if Assigned(Found) then
  begin
    MCont := FindManagedControl(Found);
    if Assigned(MCont) then
    begin
      if not MCont.FSelected then
      begin
        if not CtrlPressed then
          SelectionChangedOnClear;
        MCont.FSelected := True;
        FChanged := True;
      end
      else if CtrlPressed then
      begin
        MCont.FSelected := False;
        FChanged := True;
      end;
      if FChanged then
        ShowAll;
      if CountSelectedControls > 1 then
        FIsMoving := True;
      if Assigned(FOnSelectionChanged) then
        FOnSelectionChanged(nil);
    end;
  end
  else
  begin
    CConn := GetClickedConnection;
    if Assigned(CConn) then
    begin
      if not CConn.FSelected then
      begin
        if not CtrlPressed then
          SelectionChangedOnClear;
        CConn.FSelected := True;
      end
      else if CtrlPressed then
        CConn.FSelected := False;
      if Assigned(FOnSelectionChanged) then
        FOnSelectionChanged(nil);
    end
    else
    begin
      if Button = mbLeft then
        FIsRectSelecting := True;
    end;
  end;
  if FIsRectSelecting then
  begin
    FSelectRect.TopLeft := FMemMousePos;
    FSelectRect.BottomRight := FMemMousePos;
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := clSilver;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
  end;

  if Button = mbRight then
  begin
    Found := FindVCLWindow(Mouse.CursorPos);
    if Button = mbRight then
    begin
      var
      Conn := GetClickedConnection;
      if Assigned(Conn) then
      begin
        Conn.FSelected := True;
        if Conn.FIsRecursiv then
        begin
          FPopupMenuConnection.Items[3].Visible := False;
          FPopupMenuConnection.Items[4].Visible := False;
        end
        else
        begin
          FPopupMenuConnection.Items[3].Visible := True;
          FPopupMenuConnection.Items[4].Visible := True;
        end;
        FPopupMenuConnection.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      end
      else if Assigned(Found) and (Found <> Self) then
      begin
        if (Found is TMemo) then
          Found := (Found as TMemo).Parent;
        FOnLifelineSequencePanel(Found);
        if Assigned(TCrackControl(Found).PopupMenu) and (Button = mbRight) then
          TCrackControl(Found).PopupMenu.Popup(Mouse.CursorPos.X,
            Mouse.CursorPos.Y);

        if Assigned(TCrackControl(Found).OnMouseUp) then
        begin
          var
          Point := Found.ScreenToClient(Mouse.CursorPos);
          TCrackControl(Found).OnMouseUp(Found, Button, Shift, Point.X,
            Point.Y);
        end;
      end
      else
      begin
        FOnLifelineSequencePanel(nil);
        FPopupMenuLifelineAndSequencePanel.Popup(Mouse.CursorPos.X,
          Mouse.CursorPos.Y);
      end;
    end;
  end;
end;

procedure TSequencePanel.MouseMove(Shift: TShiftState; X, Y: Integer);

const MinTop = 20;

var Point1, Point2, Point3: TPoint; Found, Src, Dest: TControl;
  MCont: TManagedObject; DeltaX, DeltaY, Mdx, Mdy: Integer; Curr: TCrackControl;
  Rect1, Rect2, MovedRect, MovedRectWithoutConnections, MRectDxDy: TRect;
  Resized: Boolean; Connect: TConnection;

  procedure InMakeVisible(Rect: TRect);
  begin
    Mdx := TScrollBox(Parent).HorzScrollBar.Position;
    Mdy := TScrollBox(Parent).VertScrollBar.Position;

    if (DeltaX > 0) and (Rect.BottomRight.X >= TScrollBox(Parent)
      .HorzScrollBar.Position + Parent.Width) then
      TScrollBox(Parent).HorzScrollBar.Position := Rect.BottomRight.X -
        Parent.Width;

    if (DeltaY > 0) and (Rect.BottomRight.Y >= TScrollBox(Parent)
      .VertScrollBar.Position + Parent.Height) then
      TScrollBox(Parent).VertScrollBar.Position := Rect.BottomRight.Y -
        Parent.Height;

    if (DeltaX < 0) and (Rect.Left <= TScrollBox(Parent).HorzScrollBar.Position)
    then
      TScrollBox(Parent).HorzScrollBar.Position := Rect.Left;

    if (DeltaY < 0) and (Rect.Top <= TScrollBox(Parent).VertScrollBar.Position)
    then
      TScrollBox(Parent).VertScrollBar.Position := Rect.Top;

    Mdy := Mdy - TScrollBox(Parent).VertScrollBar.Position;
    Mdx := Mdx - TScrollBox(Parent).HorzScrollBar.Position;

    if (Mdx <> 0) or (Mdy <> 0) then
    begin
      Point3 := Mouse.CursorPos;
      Point3.X := Point3.X + Mdx;
      Point3.Y := Point3.Y + Mdy;
      Mouse.CursorPos := Point3;
      Resized := True;
    end;
  end;

begin
  inherited;
  if Shift = [] then
    Exit;
  Point2 := Mouse.CursorPos;
  Point1.X := X;
  Point1.Y := Y;
  DeltaX := Point1.X - FMemMousePos.X;
  DeltaY := Point1.Y - FMemMousePos.Y;
  if (DeltaX = 0) and (DeltaY = 0) then
    Exit;
  FMoved := True;
  if Abs(DeltaY) > 3 * Abs(DeltaX) then
    DeltaX := 0
  else
    DeltaY := 0;

  IntersectRect(Rect1, Parent.ClientRect, BoundsRect);
  Rect1.TopLeft := Parent.ClientToScreen(Rect1.TopLeft);
  Rect1.BottomRight := Parent.ClientToScreen(Rect1.BottomRight);

  if (not PtInRect(Rect1, Point2)) and (not(FIsRectSelecting or FIsMoving)) then
    ReleaseCapture
  else
  begin
    Found := FindVCLWindow(Point2);
    if FIsRectSelecting then
    begin
      FMemMousePos := Point1;
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Color := clSilver;
      Canvas.Pen.Mode := pmXor;
      Canvas.Pen.Width := 0;
      Canvas.Rectangle(FSelectRect);
      FSelectRect.BottomRight := FMemMousePos;
      Canvas.Rectangle(FSelectRect);
    end
    else if ssLeft in Shift then
    begin
      // Move the FSelected boxes
      if (Abs(DeltaX) + Abs(DeltaY) > 5) or FIsMoving then
      begin
        Resized := False;
        MovedRect := Rect(MaxInt, 0, 0, 0);
        MovedRectWithoutConnections := Rect(MaxInt, 0, 0, 0);
        for var I := 0 to FManagedObjects.Count - 1 do // ResumeDrawing
          SendMessage((TManagedObject(FManagedObjects[I])
            .FControl as TWinControl).Handle, WM_SETREDRAW, 1, 0);
        for var I := 0 to FManagedObjects.Count - 1 do
        begin
          MCont := TManagedObject(FManagedObjects[I]);
          if not MCont.Visible then
            Continue;

          Curr := TCrackControl(MCont.FControl);
          if TManagedObject(FManagedObjects[I]).FSelected then
          begin
            MRectDxDy := Curr.BoundsRect;

            // debug
            // Canvas.Brush.Color:= clBlue;
            // Canvas.FrameRect(MRectDxDy);

            if (Curr.Left + DeltaX >= 0) and (DeltaX <> 0) then
              Curr.Left := Curr.Left + DeltaX;
            if DeltaY <> 0 then
              for var J := 0 to FManagedObjects.Count - 1 do
                TManagedObject(FManagedObjects[J]).FControl.Top :=
                  Min(Max(TManagedObject(FManagedObjects[J]).FControl.Top +
                  DeltaY, MinTop), 500);
            Rect2 := Curr.BoundsRect;
            MRectDxDy.Union(Rect2);

            // scrolling
            if Curr.Left + Curr.Width + 50 > Width then
            begin
              Width := Curr.Left + Curr.Width + 50;
              Resized := True;
            end;
            if Curr.Top + Curr.Height + 50 > Height then
            begin
              Height := Curr.Top + Curr.Height + 50;
              Resized := True;
            end;

            if MovedRect.Left = MaxInt then
              MovedRect := MRectDxDy
            else
              UnionRect(MovedRect, MRectDxDy, MovedRect);

            if MovedRectWithoutConnections.Left = MaxInt then
              MovedRectWithoutConnections := MRectDxDy
            else
              UnionRect(MovedRectWithoutConnections, MRectDxDy,
                MovedRectWithoutConnections);

            // debug
            // Canvas.Brush.Color:= clRed;
            // Canvas.FrameRect(MovedRect);

            Src := MCont.FControl;
            for var J := 0 to FManagedObjects.Count - 1 do
            begin
              if not TManagedObject(FManagedObjects[J]).Visible then
                Continue;
              Dest := TManagedObject(FManagedObjects[J]).FControl;
              for var K := 0 to FConnections.Count - 1 do
              begin
                Connect := TConnection(FConnections[K]);
                if ((Connect.FStartControl = Src) and
                  (Connect.FEndControl = Dest)) or
                  ((Connect.FStartControl = Dest) and
                  (Connect.FEndControl = Src)) then
                begin
                  UnionRect(MovedRect, Connect.HasRect, MovedRect);
                end;
              end;
            end;
          end;
        end;

        // debug
        // Canvas.Brush.Color:= clRed;
        // Canvas.FrameRect(MovedRect);

        IsModified := True;
        FMemMousePos := Point1;
        FIsMoving := True;

        if MovedRect.Left <> MaxInt then
          InMakeVisible(MovedRectWithoutConnections);

        if Resized then
          MovedRect := BoundsRect;
        Invalidate;

      end
      else if Assigned(Found) then
      begin
        if Assigned(TCrackControl(Found).OnMouseMove) then
        begin
          Point3 := Found.ScreenToClient(Point1);
          TCrackControl(Found).OnMouseMove(Found, Shift, Point3.X, Point3.Y);
        end;
      end;
    end;
  end;
end;

procedure TSequencePanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Point: TPoint; Rect: TRect;
begin
  inherited;
  FIsMoving := False;
  Point.X := X;
  Point.Y := Y;
  IntersectRect(Rect, Parent.ClientRect, BoundsRect);
  Rect.TopLeft := Parent.ClientToScreen(Rect.TopLeft);
  Rect.BottomRight := Parent.ClientToScreen(Rect.BottomRight);
  Rect.TopLeft := ScreenToClient(Rect.TopLeft);
  Rect.BottomRight := ScreenToClient(Rect.BottomRight);

  if FIsRectSelecting then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
    Canvas.Rectangle(FSelectRect);
    SelectObjectsInRect(FSelectRect);
    if Assigned(FOnSelectionChanged) then
      FOnSelectionChanged(nil);
  end
  else if PtInRect(Rect, Point) then
    SetCaptureControl(nil);
  if FMoved then
    ShowAll;
  FIsRectSelecting := False;
  FMoved := False;
end;

function TSequencePanel.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;

const WHEEL_DIVISOR = 120; // Mouse Wheel standard
var Mdy: Integer;
begin
  Mdy := TScrollBox(Parent).VertScrollBar.Position - WheelDelta;
  TScrollBox(Parent).VertScrollBar.Position := Mdy;
  Result := True;
end;

procedure TSequencePanel.OnManagedObjectClick(Sender: TObject);
begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnClick) then
    Control.FOnClick(Sender);
end;

procedure TSequencePanel.OnManagedObjectDblClick(Sender: TObject);
var Control: TManagedObject; Conn: TConnection;
begin
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnDblClick) then
  begin
    FMouseDownOK := False;
    ClearSelection;
    Conn := GetClickedConnection;
    if Assigned(Conn) then
    begin
      Conn.FSelected := True;
      SelectConnection;
    end
    else
      Control.FOnDblClick(Sender);
  end;
end;

procedure TSequencePanel.OnManagedObjectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Point: TPoint;
begin
  if not Focused or (GetCaptureControl <> Self) then
  begin
    // Call the essConnectpanel MouseDown instead.
    Point.X := X;
    Point.Y := Y;
    Point := (Sender as TControl).ClientToScreen(Point);
    Point := ScreenToClient(Point);
    MouseDown(Button, Shift, Point.X, Point.Y);
  end;
end;

procedure TSequencePanel.OnManagedObjectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnMouseMove) then
    Control.FOnMouseMove(Sender, Shift, X, Y);
end;

procedure TSequencePanel.OnManagedObjectMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnMouseUp) then
    Control.FOnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TSequencePanel.Paint;
begin
  Canvas.Pen.Mode := pmCopy;
  if Assigned(FBackBitmap) then
    Canvas.Brush.Bitmap := FBackBitmap;
  Canvas.Pen.Color := FForegroundColor;
  Canvas.Brush.Color := FBackgroundColor;
  Canvas.FillRect(ClientRect);
  Canvas.Font := Font;
  Canvas.Font.Color := FForegroundColor;
  ShowConnections;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FControl.Visible then
      TManagedObject(FManagedObjects[I]).FControl.Invalidate;
end;

procedure TSequencePanel.ShowConnections;
begin
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := (FConnections[I] as TConnection);
    if Conn.FStartControl.Visible and Conn.FEndControl.Visible then
      Conn.Draw(Canvas);
  end;
end;

procedure TSequencePanel.RecalcSize;
var XMax, YMax: Integer;
begin
  if Assigned(Parent) then
  begin
    XMax := Parent.Width - 4; // 300;
    YMax := Parent.Height - 4; // 150;
  end
  else
  begin
    XMax := 300;
    YMax := 150;
  end;
  for var I := 0 to ControlCount - 1 do
  begin
    if (Controls[I].Align <> alNone) or (not Controls[I].Visible) then
      Continue;
    XMax := Max(XMax, Controls[I].Left + Controls[I].Width + 20);
    YMax := Max(YMax, Controls[I].Top + Controls[I].Height + 20);
  end;
  if (Width <> XMax) or (Height <> YMax) then
    SetBounds(Left, Top, XMax, YMax);
  if Assigned(FOnContentChanged) then
    FOnContentChanged(nil);
end;

procedure TSequencePanel.GetDiagramSize(var Width, Height: Integer);
begin
  Width := 300;
  Height := 150;
  for var I := 0 to ControlCount - 1 do
  begin
    if (Controls[I].Align <> alNone) or (not Controls[I].Visible) then
      Continue;
    Width := Max(Width, Controls[I].Left + Controls[I].Width + 10);
    Height := Max(Height, Controls[I].Top + Controls[I].Height + 10);
  end;
end;

procedure TSequencePanel.SelectObjectsInRect(SelRect: TRect);
var Rect1, Rect2: TRect;
begin
  Rect1 := SelRect;
  if SelRect.Top > SelRect.Bottom then
  begin
    SelRect.Top := Rect1.Bottom;
    SelRect.Bottom := Rect1.Top;
  end;
  if SelRect.Left > SelRect.Right then
  begin
    SelRect.Left := Rect1.Right;
    SelRect.Right := Rect1.Left;
  end;

  for var I := 0 to FManagedObjects.Count - 1 do
  begin
    if Assigned(TManagedObject(FManagedObjects[I]).FControl) then
    begin
      Rect1 := TCrackControl(TManagedObject(FManagedObjects[I]).FControl)
        .BoundsRect;
      IntersectRect(Rect2, SelRect, Rect1);
      if EqualRect(Rect1, Rect2) and TManagedObject(FManagedObjects[I])
        .FControl.Visible then
        TManagedObject(FManagedObjects[I]).FSelected := True;
      if Assigned(FOnSelectionChanged) then
        FOnSelectionChanged(nil);
    end;
  end;
end;

procedure TSequencePanel.SetFocus;
var Form: TCustomForm; XPos, YPos: Integer;
begin
  Form := GetParentForm(Self);

  // Try to see if we can call inherited, otherwise there is a risc of getting
  // 'Cannot focus' exception when starting from delphi-tools.
  if CanFocus and Assigned(Form) and Form.Active then
  begin
    // To avoid having the scrollbox resetting its positions after a setfocus call.
    XPos := (Parent as TScrollBox).HorzScrollBar.Position;
    YPos := (Parent as TScrollBox).VertScrollBar.Position;
    inherited;
    (Parent as TScrollBox).HorzScrollBar.Position := XPos;
    (Parent as TScrollBox).VertScrollBar.Position := YPos;
  end;
end;

procedure TSequencePanel.SetIsModified(const Value: Boolean);
begin
  if FIsModified <> Value then
  begin
    FIsModified := Value;
    if Assigned(FOnModified) then
      FOnModified(nil);
  end;
end;

procedure TSequencePanel.SetIsLocked(const Value: Boolean);
begin
  if FIsLocked <> Value then
  begin
    FIsLocked := Value;
    if not FIsLocked then
      ShowAll;
  end;
end;

procedure TSequencePanel.SetSelectedOnly(const Value: Boolean);
begin
  if FSelectedOnly <> Value then
  begin
    FSelectedOnly := Value;
    if FSelectedOnly then
    begin
      FTempHidden.Clear;
      for var I := 0 to FManagedObjects.Count - 1 do
        if (not TManagedObject(FManagedObjects[I]).FSelected) and
          TManagedObject(FManagedObjects[I]).FControl.Visible then
        begin
          TManagedObject(FManagedObjects[I]).FControl.Visible := False;
          FTempHidden.Add(TObject(FManagedObjects[I]));
        end;
    end
    else
    begin
      for var I := 0 to FTempHidden.Count - 1 do
        TManagedObject(FTempHidden[I]).FControl.Visible := True;
      FTempHidden.Clear;
    end;
  end;
end;

procedure TSequencePanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    DeleteSelectedConnection;
    Invalidate;
  end;
end;

procedure TSequencePanel.SetFont(AFont: TFont);
begin
  Font.Assign(AFont);
  for var I := 0 to FConnections.Count - 1 do
    TConnection(FConnections[I]).SetFont(AFont);
end;

procedure TSequencePanel.Clear;
begin
  Canvas.FrameRect(ClientRect);
end;

procedure TSequencePanel.ChangeStyle(BlackAndWhite: Boolean = False);
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
  Color := FBackgroundColor;
  Canvas.Pen.Color := FForegroundColor;
  Canvas.Brush.Color := FBackgroundColor;

  for var I := 0 to FConnections.Count - 1 do
    TConnection(FConnections[I]).ChangeStyle(BlackAndWhite);
  for var I := 0 to FManagedObjects.Count - 1 do
    (TManagedObject(FManagedObjects[I]).FControl as TLifeline)
      .ChangeStyle(BlackAndWhite);
end;

function TSequencePanel.GetEnclosingRect: TRect;
var Control: TControl; Count: Integer; ARect: TRect;
begin
  Count := 0;
  Result := Rect(MaxInt, MaxInt, 0, 0);
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
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

{ --- TManagedObject ----------------------------------------------------------- }

constructor TManagedObject.Create;
begin
  inherited;
  FControl := nil;
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
