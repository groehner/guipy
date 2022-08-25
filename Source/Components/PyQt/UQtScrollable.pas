{-------------------------------------------------------------------------------
 Unit:     UQtScrollable
 Author:   Gerhard Röhner
 Date:     July 2022
 Purpose:  PyQt scrollable widgets
-------------------------------------------------------------------------------}
unit UQtScrollable;

{ classes
    TQtAbstractScrollArea
      TQtScrollArea
      TQtPlainTextEdit
      TQtTextEdit
        TQtTextBrowser
      TQtGraphicsView

    TQtAbstractSlider
      TQtScrollBar
      TQtSlider
      TQtDial
}

interface

uses
  Windows, Messages, Controls, Graphics, Classes,
  UBaseQtWidgets, UQtFrameBased;

type

  TScrollBarPolicy = (ScrollBarAsNeeded, ScrollBarAlwaysOff, ScrollBarAlwaysOn);

  TSizeAdjustPolicy = (AdjustIgnored, AdjustToContentsOnFirstShow, AdjustToContents);

  TTickPosition = (NoTicks, TicksAbove, TicksLeft, TicksBelow,
                   TicksRight, TicksBothSides);

  TAutoFormattings = (AutoNone, AutoBulletList, AutoAll);

  TAutoFormatting = set of TAutoFormattings;

  TTextInteractionItem = (NoTextInteraction, TextSelectableByMouse,
   TextSelectableByKeyboard, LinkAccessibleByMouse, LinkAcessibleByKeyboard,
   TextEditable, TextEditorInteraction, TextBrowserInteraction);

  TTextInteractionFlags = set of TTextInteractionItem;

  // QPainter
  TRender = (Antialiasing, TextAntialiasing, SmoothPixmapTransform,
    LosslessImageRendering);
  TRenderHints = set of TRender;

  // QGraphicsView
  TQtDragMode = (NoDrag, ScrollHandDrag, RubberBandDrag);

  // QGraphicsView
  TCacheMode = (CacheNone, CacheBackground);

  // QGraphicsView
  TAnchor =  (NoAnchor, AnchorViewCenter, AnchorUnderMouse);

  // QGraphicsView
  TViewportUpdateMode = (FullViewportUpdate, MinimalViewportUpdate,
    SmartViewportUpdate, BoundingRectViewportUpdate, NoViewportUpdate);

  // Qt
  TRubberBandSelectioMode = (ContainsItemShape, IntersectsItemShape,
    ContainsItemBoundingRect, IntersectsItemBoundingRect);

  // QGraphicsView
  TOptimizationFlag = (DontSavePainterState, DontAdjustForAntialiasing,
                       DontClipPainter);
  TOptimizationFlags = set of TOptimizationFlag;

  // Qt
  TQtBrushStyle = (SolidPattern, Dense1Pattern, Dense2Pattern, Dense3Pattern,
   Dense4Pattern, Dense5Patten, Dense6Pattern, Dense7Pattern, NoBrush, HorPattern,
   VerPattern, CrossPattern, BDiagPattern, FDiagPattern, DiagCrossPattern,
   LinearGradientPattern, RadialGradientPattern, ConicalGradientPattern);

  TTextEditLineWrapMode = (NoWrap, WidgetWidth, FixedPixelWidth, FixedColumnWidth);
  TPlainTextLineWrapMode = NoWrap..WidgetWidth;
  TWordWrapMode = (_WW_NoWrap, _WW_WordWrap, _WW_ManualWrap, _WW_WrapAnywhere,
                   _WW_WrapAtWordBoundaryOrAnywhere);

  TQtAbstractScrollArea = class(TQtFrame)
  private
    FHorizontalScrollBarPolicy: TScrollBarPolicy;
    FVerticalScrollBarPolicy: TScrollBarPolicy;
    FSizeAdjustPolicy: TSizeAdjustPolicy;
    FTextInteractionFlags: TTextInteractionFlags;
    procedure setHorizontalScrollBarPolicy(Value: TScrollbarPolicy);
    procedure setVerticalScrollBarPolicy(Value: TScrollbarPolicy);
    procedure PaintScrollbars;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure Paint; override;
    function InnerRect: TRect; override;
    procedure PaintAScrollbar(horizontal: boolean);
    procedure MakeTextInteraction;
    property TextInteractionFlags: TTextInteractionFlags read FTextInteractionFlags write FTextInteractionFlags;
  published
    property HorizontalScrollBarPolicy: TScrollBarPolicy
      read FHorizontalScrollBarPolicy write setHorizontalScrollBarPolicy;
    property VerticalScrollBarPolicy: TScrollBarPolicy
      read FVerticalScrollBarPolicy write setVerticalScrollBarPolicy;
    property SizeAdjustPolicy: TSizeAdjustPolicy
      read FSizeAdjustPolicy write FSizeAdjustPolicy;
  end;

  TQtScrollArea = class(TQtAbstractScrollArea)
  private
    FWidgetResizable: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property WidgetResizable: boolean read FWidgetResizable write FWidgetResizable;
  end;

  TQtPlainTextEdit = class(TQtAbstractScrollArea)
  private
    FBackgroundVisible: boolean;
    FBlockCountChanged: string;
    FCenterOnScroll: boolean;
    FCopyAvailable: string;
    FCursorPositionChanged: string;
    FCursorWidth: integer;
    FDocumentTitle: string;
    FLineWrapMode: TPlainTextLineWrapMode;
    FMaximumBlockCount: integer;
    FModificationChanged: string;
    FOverwriteMode: boolean;
    FPlaceHolderText: string;
    FPlainText: TStrings;
    FReadOnly: boolean;
    FRedoAvailable: string;
    FSelectionChanged: string;
    FTabChangesFocus: boolean;
    FTabStopDistance: integer;
    FTabStopWidth: integer;
    FTextChanged: string;
    FUndoAvailable: string;
    FUndoRedoEnabled: boolean;
    FUpdateRequest: string;
    FWordWrapMode: TWordWrapMode;
    procedure setTabChangesFocus(Value: boolean);
    procedure setLineWrapMode(Value: TPlainTextLineWrapMode);
    procedure setPlainText(Value: TStrings);
    procedure setPlaceholderText(Value: string);
    procedure MakePlainText;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property TabChangesFocus: boolean read FTabChangesFocus write setTabChangesFocus;
    property DocumentTitle: string read FDocumentTitle write FDocumentTitle;
    property UndoRedoEnabled: boolean read FUndoRedoEnabled write FUndoRedoEnabled;
    property LineWrapMode: TPlainTextLineWrapMode read FLineWrapMode write setLineWrapMode;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property PlainText: TStrings read FPlainText write setPlainText;
    property OverwriteMode: boolean read FOverwriteMode write FOverwriteMode;
    property TabStopWidth: integer read FTabStopWidth write FTabStopWidth;
    property TabStopDistance: integer read FTabStopDistance write FTabStopDistance;
    property CursorWidth: integer read FCursorWidth write FCursorWidth;
    property TextInteractionFlags;
    property MaximumBlockCount: integer read FMaximumBlockCount write FMaximumBlockCount;
    property BackgroundVisible: boolean read FBackgroundVisible write FBackgroundVisible;
    property CenterOnScroll: boolean read FCenterOnScroll write FCenterOnScroll;
    property PlaceholderText: string read FPlaceholderText write setPlaceholderText;
    property WordWrapMode: TWordWrapMode read FWordWrapMode write FWordWrapMode;
    // signals
    property blockCountChanged: string read FBlockCountChanged write FBlockCountChanged;
    property copyAvailable: string read FCopyAvailable write FCopyAvailable;
    property cursorPositionChanged: string read FCursorPositionChanged write FCursorPositionChanged;
    property modificationChanged: string read FModificationChanged write FModificationChanged;
    property redoAvailable: string read FRedoAvailable write FRedoAvailable;
    property selectionChanged: string read FSelectionChanged write FSelectionChanged;
    property textChanged: string read FTextChanged write FTextChanged;
    property undoAvailable: string read FUndoAvailable write FUndoAvailable;
    property updateRequest: string read FUpdateRequest write FUpdateRequest;
  end;

  TQtTextEdit = class(TQtAbstractScrollArea)
  private
    FAutoFormatting: TAutoFormatting;
    FTabChangesFocus: boolean;
    FDocumentTitle: string;
    FUndoRedoEnabled: boolean;
    FLineWrapMode: TTextEditLineWrapMode;
    FLineWarpColumnOrWidth: integer;
    FReadOnly: boolean;
    FMarkDown: string;
    FHtml: TStrings;
    FOverwriteMode: boolean;
    FTabStopWidth: integer;
    FTabStopDistance: double;
    FAcceptRichText: boolean;
    FCursorWidth: integer;
    FPlaceholderText: string;
    FCopyAvailable: string;
    FCurrentCharFormatChanged: string;
    FCursorPositionChanged: string;
    FRedoAvailable: string;
    FSelectionChanged: string;
    FTextChanged: string;
    FUndoAvailable: string;
    FWordWrapMode: TWordWrapMode;
    procedure setLineWrapMode(Value: TTextEditLineWrapMode);
    procedure setHTML(Value: TStrings);
    procedure setPlaceholderText(Value: string);
    procedure MakeAutoFormatting;
    procedure MakeHTML;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property AutoFormatting: TAutoFormatting
      read FAutoFormatting write FAutoFormatting;
    property TabChangesFocus: boolean read FTabChangesFocus write FTabChangesFocus;
    property DocumentTitle: string read FDocumentTitle write FDocumentTitle;
    property UndoRedoEnabled: boolean read FUndoRedoEnabled write FUndoRedoEnabled;
    property LineWrapMode: TTextEditLineWrapMode read FLineWrapMode write setLineWrapMode;
    property LineWarpColumnOrWidth: integer
      read FLineWarpColumnOrWidth write FLineWarpColumnOrWidth;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property MarkDown: string read FMarkDown write FMarkDown;
    property Html: TStrings read FHtml write setHtml;
    property OverwriteMode: boolean read FOverwriteMode write FOverwriteMode;
    property TextInteractionFlags;
    property TabStopWidth: integer read FTabStopWidth write FTabStopWidth;
    property TabStopDistance: double read FTabStopDistance write FTabStopDistance;
    property AcceptRichText: boolean read FAcceptRichText write FAcceptRichText;
    property CursorWidth: integer read FCursorWidth write FCursorWidth;
    property PlaceholderText: string read FPlaceholderText write setPlaceholderText;
    property WordWrapMode: TWordWrapMode read FWordWrapMode write FWordWrapMode;
    // signals
    property copyAvailable: string read FCopyAvailable write FCopyAvailable;
    property currentCharFormatChanged: string read FCurrentCharFormatChanged write FCurrentCharFormatChanged;
    property cursorPositionChanged: string read FCursorPositionChanged write FCursorPositionChanged;
    property redoAvailable: string read FRedoAvailable write FRedoAvailable;
    property selectionChanged: string read FSelectionChanged write FSelectionChanged;
    property textChanged: string read FTextChanged write FTextChanged;
    property undoAvailable: string read FUndoAvailable write FUndoAvailable;
  end;

  TQtTextBrowser = class(TQtTextEdit)
  private
    FSource: string;
    FSearchPaths: TStrings;
    FOpenExternalLinks: boolean;
    FOpenLinks: boolean;
    FAnchorClicked: string;
    FBackwardAvailable: string;
    FForwardAvailable: string;
    FHighlighted: string;
    FHistoryChanged: string;
    FSourceChanged: string;
    function getSearchPaths: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property Source: string read FSource write FSource;
    property SearchPaths: TStrings read FSearchPaths write FSearchPaths;
    property OpenExternalLinks: boolean read FOpenExternalLinks write FOpenExternalLinks;
    property OpenLinks: boolean read FOpenLinks write FOpenLinks;
    // signals
    property anchorClicked: string read FAnchorClicked write FAnchorClicked;
    property backwardAvailable: string read FBackwardAvailable write FBackwardAvailable;
    property forwardAvailable: string read FForwardAvailable write FForwardAvailable;
    property highlighted: string read FHighlighted write FHighlighted;
    property historyChanged: string read FHistoryChanged write FHistoryChanged;
    property sourceChanged: string read FSourceChanged write FSourceChanged;
  end;

  TQtGraphicsView = class(TQtAbstractScrollArea)
  private
    FBackgroundColor: TColor;
    FBackgroundStyle: TQtBrushStyle;
    FForegroundColor: TColor;
    FForegroundStyle: TQtBrushStyle;
    FInteractive: boolean;
    //FSceneRect: TQtRect;
    //FAlignment: TQtAlignment;
    FRenderHints: TRenderHints;
    FDragMode: TQtDragMode;
    FCacheMode: TCacheMode;
    FTransformationAnchor: TAnchor;
    FResizeAnchor: TAnchor;
    FViewportUpdateMode: TViewportUpdateMode;
    FRubberBandSelectioMode: TRubberBandSelectioMode;
    FOptimizationFlags: TOptimizationFlags;
    FRubberBandChanged: string;
    procedure MakeRenderHints;
    procedure MakeOptimizationFlags;
    procedure MakeColorAndStyle(Attr: string);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property ForegroundColor: TColor read FForegroundColor write FForegroundColor;
    property BackgroundStyle: TQtBrushStyle read FBackgroundStyle write FBackgroundStyle;
    property ForegroundStyle: TQtBrushStyle read FForegroundStyle write FForegroundStyle;
    property Interactive: boolean read FInteractive write FInteractive;
    //property SceneRect: TQtRect read FSceneRect write FSceneRect;
    //property Alignment: TQtAlignment read FAlignment write FAlignment;
    property RenderHints: TRenderHints read FRenderHints write FRenderHints;
    property DragMode: TQtDragMode read FDragMode write FDragMode;
    property CacheMode: TCacheMode read FCacheMode write FCacheMode;
    property TransformationAnchor: TAnchor read FTransformationAnchor write FTransformationAnchor;
    property ResizeAnchor: TAnchor read FResizeAnchor write FResizeAnchor;
    property ViewportUpdateMode: TViewportUpdateMode read FViewportUpdateMode write FViewportUpdateMode;
    property RubberBandSelectioMode: TRubberBandSelectioMode read FRubberBandSelectioMode write FRubberBandSelectioMode;
    property OptimizationFlags: TOptimizationFlags read FOptimizationFlags write FOptimizationFlags;
    // signals
    property rubberBandChanged: string read FRubberBandChanged write FRubberBandChanged;
  end;

  TQtAbstractSlider = class(TBaseQtWidget)
  private
    FMinimum: integer;
    FMaximum: integer;
    FSingleStep: integer;
    FPageStep: integer;
    FValue: integer;
    FSliderPosition: integer;
    FTracking: boolean;
    FOrientation: TOrientation;
    FInvertedAppearance: boolean;
    FInvertedControls: boolean;
    FActionTriggered: string;
    FRangeChanged: string;
    FSliderMoved: string;
    FSliderPressed: string;
    FSliderReleased: string;
    FValueChanged: string;
    procedure setOrientation(Value: TOrientation);
    procedure setValue(Value: integer);
    procedure setInvertedAppearance(Value: boolean);
  public
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
  published
    property Minimum: integer read FMinimum write FMinimum;
    property Maximum: integer read FMaximum write FMaximum;
    property SingleStep: integer read FSingleStep write FSingleStep;
    property PageStep: integer read FPageStep write FPageStep;
    property Value: integer read FValue write setValue;
    property SliderPosition: integer read FSliderPosition write FSliderPosition;
    property Tracking: boolean read FTracking write FTracking;
    property Orientation: TOrientation read FOrientation write setOrientation;
    property InvertedAppearance: boolean read FInvertedAppearance write setInvertedAppearance;
    property InvertedControls: boolean read FInvertedControls write FInvertedControls;
    // signals
    property actionTriggered: string read FActionTriggered write FActionTriggered;
    property rangeChanged: string read FRangeChanged write FRangeChanged;
    property sliderMoved: string read FSliderMoved write FSliderMoved;
    property sliderPressed: string read FSliderPressed write FSliderPressed;
    property sliderReleased: string read FSliderReleased write FSliderReleased;
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtScrollBar = class(TQtAbstractSlider)
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  end;

  TQtSlider = class(TQtAbstractSlider)
  private
    FTickPosition: TTickPosition;
    FTickInterval: integer;
    procedure setTickPosition(Value: TTickPosition);
    procedure setTickInterval(Value: integer);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property TickPosition: TTickPosition read FTickPosition write setTickPosition;
    property TickInterval: integer read FTickInterval write setTickInterval;
  end;

  TQtDial = class(TQtAbstractSlider)
  private
    FWrapping: boolean;
    FNotchTarget: double;
    FNotchesVisible: boolean;
    procedure setWrapping(Value: boolean);
    procedure setNotchTarget(Value: double);
    procedure setNotchesVisible(Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property Wrapping: boolean read FWrapping write setWrapping;
    property NotchTarget: double read FNotchTarget write setNotchTarget;
    property NotchesVisible: boolean read FNotchesVisible write setNotchesVisible;
  end;

implementation

uses SysUtils, Types, Math, Forms, UUtils;

{--- TQtAbstractScrollArea ----------------------------------------------------}

constructor TQtAbstractScrollArea.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FTextInteractionFlags:= [TextSelectableByMouse, TextSelectableByKeyboard,
                           Texteditable];
end;

function TQtAbstractScrollArea.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|VerticalScrollBarPolicy|HorizontalScrollBarPolicy|';
  if ShowAttributes = 3 then
    Result:= Result + '|SizeAdjustPolicy';
  Result:= Result + inherited getAttributes(ShowAttributes)
end;

procedure TQtAbstractScrollArea.SetAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'HorizontalScrollBarPolicy') or (Attr = 'VerticalScrollBarPolicy')  then
    MakeAttribut(Attr, 'Qt.ScrollBarPolicy.' + Value)
  else if Attr = 'SizeAdjustPolicy' then
    MakeAttribut(Attr, 'QAbstractScrollArea.SizeAdjustPolicy.' + Value)
  else
    inherited;
end;

procedure TQtAbstractScrollArea.Paint;
begin
  inherited;
  PaintScrollbars;
end;

procedure TQtAbstractScrollArea.PaintScrollbars;
  var R: TRect;
begin
  R:= inherited InnerRect;
  if FHorizontalScrollbarPolicy = ScrollbarAlwaysOn then begin
    R.Top:= R.Bottom - 16;
    if FVerticalScrollbarPolicy = ScrollbarAlwaysOn then
      R.Right:= R.Right - 16;
    PaintScrollbar(R, true);
  end;
  R:= inherited InnerRect;
  if FVerticalScrollbarPolicy = ScrollbarAlwaysOn then begin
    R.Left:= R.Right - 16;
    if FHorizontalScrollbarPolicy = ScrollbarAlwaysOn then
      R.Bottom:= R.Bottom - 16;
    PaintScrollbar(R, false);
  end;
end;

procedure TQtAbstractScrollArea.PaintAScrollbar(horizontal: boolean);
  var R: TRect;
begin
  R:= inherited InnerRect;
  if horizontal
    then R.Top:= R.Bottom - 16
    else R.Left:= R.Right - 16;
  PaintScrollbar(R, horizontal);
end;

function TQtAbstractScrollArea.InnerRect: TRect;
begin
  Result:= inherited;
  if FHorizontalScrollBarPolicy = ScrollbarAlwaysOn then
    Result.Bottom:= Result.Bottom - 16;
  if FVerticalScrollBarPolicy = ScrollbarAlwaysOn then
    Result.Right:= Result.Right - 16;
end;

procedure TQtAbstractScrollArea.MakeTextInteraction;
begin
  var s:= '';
  if NoTextInteraction in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.NoTextInteraction';
  if TextSelectableByMouse in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.TextSelectableByMouse';
  if TextSelectableByKeyboard in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.TextSelectableByKeyboard';
  if LinkAccessibleByMouse in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.LinkAccessibleByMouse';
  if LinkAcessibleByKeyboard in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.LinkAcessibleByKeyboard';
  if TextEditable in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.TextEditable';
  if TextEditorInteraction in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.TextEditorInteraction';
  if TextBrowserInteraction in FTextInteractionFlags then
    s:= s + '|Qt.TextInteractionFlag.TextBrowserInteraction';
  if s <> '' then begin
    delete(s, 1, 1);
    MakeAttribut('TextInteractionFlags', s);
  end else
    Partner.DeleteAttribute('self.' + name + '.setTextInteractionFlags');
end;

procedure TQtAbstractScrollArea.setHorizontalScrollBarPolicy(Value: TScrollbarPolicy);
begin
  if Value <> FHorizontalScrollBarPolicy then begin
    FHorizontalScrollBarPolicy:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractScrollArea.setVerticalScrollBarPolicy(Value: TScrollbarPolicy);
begin
  if Value <> FVerticalScrollBarPolicy then begin
    FVerticalScrollBarPolicy:= Value;
    Invalidate;
  end;
end;

{--- TQtScrollArea ------------------------------------------------------------}

constructor TQtScrollArea.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 113;
  Width:= 120;
  Height:= 80;
  FrameShadow:= Sunken;
end;

function TQtScrollArea.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|WidgetResizable';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtScrollArea.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QScrollArea');
end;

{--- TQtPlainTextEdit ---------------------------------------------------------}

constructor TQtPlainTextEdit.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 73;
  Width:= 120;
  Height:= 80;
  FrameShape:= StyledPanel;
  FrameShadow:= Sunken;
  LineWidth:= 1;
  FUndoRedoEnabled:= true;
  FLineWrapMode:= WidgetWidth;
  FTabStopWidth:= 80;
  FTabStopdistance:= 80;
  Cursor:= crIBeam;
  FCursorWidth:= 1;
  FPlainText:= TStringList.Create;
end;

destructor TQtPlainTextEdit.Destroy;
begin
  FreeAndNil(FPlainText);
  inherited;
end;

function TQtPlainTextEdit.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|PlainText|PlaceholderText';
  if ShowAttributes >= 2 then
    Result:= Result + '|LineWrapMode';
  if ShowAttributes = 3 then
    Result:= Result + '|TabChangesFocus|UndoRedoEnabled|ReadOnly|DocumentTitle' +
                      '|OverwriteMode|TabStopWidth|TabStopDistance|CursorWidth' +
                      '|MaximumBlockCount|BackgroundVisible|CenterOnScroll' +
                      '|TextInteractionFlags|WordWrapMode';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtPlainTextEdit.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'LineWrapMode'  then
    MakeAttribut(Attr, 'QPlainTextEdit.LineWrapMode.' + Value)
  else if Attr = 'PlainText' then
    MakePlainText
  else if Attr = 'WordWrapMode' then
    MakeAttribut(Attr, 'QTextOption.WrapMode.' + Value)
  else
    inherited;
end;

function TQtPlainTextEdit.getEvents(ShowEvents: integer): string;
begin
  Result:= '|blockCountChanged|copyAvailable|cursorPositionChanged' +
           '|modificationChanged|redoAvailable|selectionChanged' +
           '|textChanged|undoAvailable|updateRequest';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtPlainTextEdit.HandlerInfo(const event: string): string;
begin
  if event = 'blockCountChanged' then
    Result:= 'int;newBlockCount'
  else if event = 'copyAvailable' then
    Result:= 'bool;yes'
  else if event = 'modificationChanged' then
    Result:= 'bool;changed'
  else if (event = 'redoAvailable') or (event = 'undoAvailable') then
    Result:= 'bool;available'
  else if event = 'updateRequest' then
    Result:= 'QRect, int;rect, dy'
  else
    Result:= inherited;
end;

procedure TQtPlainTextEdit.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.centerCursor');
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.copy');
    Slots.Add(Name + '.cut');
    Slots.Add(Name + '.paste');
    Slots.Add(Name + '.redo');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.undo');
  end else if Parametertypes = 'QString' then begin
    Slots.Add(Name + '.appendHtml');
    Slots.Add(Name + '.appendPlainText');
    Slots.Add(Name + '.insertPlainText');
    Slots.Add(Name + '.setPlainText');
  end else if Parametertypes = 'int' then begin
    Slots.Add(Name + '.zoomIn');
    Slots.Add(Name + '.zoomOut');
  end;
  inherited;
end;

procedure TQtPlainTextEdit.MakePlainText;
begin
  MakeAttribut('PlainText', asString(myStringReplace(FPlainText.Text, sLineBreak, '\n')));
end;

procedure TQtPlainTextEdit.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QPlainTextEdit');
end;

procedure TQtPlainTextEdit.Paint;
  var w, h, format: integer;
      SL: TStringList; R: TRect;
begin
  inherited;
  R:= InnerRect;
  R.Inflate(-HalfX, -HalfX);
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(R);
  SL:= TStringList.Create;
  format:= DT_LEFT;
  if FLineWrapMode = WidgetWidth then begin
    format:= format + DT_WORDBREAK;
    WrapText(FPlainText.Text, R.Right - R.Left, w, h, SL);
  end else
    CalculateText(FPlainText.Text, w, h, SL);
  if SL.Text <> CrLf then
    DrawText(Canvas.Handle, PChar(SL.Text), Length(SL.Text), R, format);
  FreeAndNil(SL);
end;

procedure TQtPlainTextEdit.setTabChangesFocus(Value: boolean);
begin
  if Value <> FTabChangesFocus then begin
    TabChangesFocus:= Value;
    Invalidate;
  end;
end;

procedure TQtPlainTextEdit.setLineWrapMode(Value: TPlainTextLineWrapMode);
begin
  if Value <> FLineWrapMode then begin
    FLineWrapMode:= Value;
    Invalidate;
  end;
end;

procedure TQtPlainTextEdit.setPlainText(Value: TStrings);
begin
  if Value.text <> FPlainText.Text then begin
    FPlainText.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtPlainTextEdit.setPlaceholderText(Value: string);
begin
  if Value <> FPlaceholderText then begin
    FPlaceholderText:= Value;
    Invalidate;
  end;
end;

{--- TQtTextEdit --------------------------------------------------------------}

constructor TQtTextEdit.Create(AOwner: TComponent);
  var SL: TStringList;
begin
  inherited create(AOwner);
  Tag:= 101;
  Width:= 120;
  Height:= 80;
  FrameShape:= StyledPanel;
  FrameShadow:= Sunken;
  LineWidth:= 1;
  FUndoRedoEnabled:= true;
  FLineWrapMode:= WidgetWidth;
  FHtml:= TStringList.Create;
  SL:= TStringList.Create;
  SL.Text:= DefaultItems;
  var s:= '<ul>'#13#10;
  for var i:= 0 to SL.Count-1 do
    s:= s  + '<li>' + SL[i] + '</li>' + #13#10;
  FHtml.Text:= s + '</ul>'#13#10;
  FreeAndNil(SL);
  FTabStopWidth:= 80;
  FTabStopDistance:= 80;
  FAcceptRichtext:= true;
  FCursorWidth:= 1;
  Cursor:= crIBeam;
end;

destructor TQtTextEdit.Destroy;
begin
  inherited;
  FreeAndNil(FHtml);
end;

function TQtTextEdit.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|AutoFormatting|DocumentTitle|UndoRedoEnabled|ReadOnly|Markdown' +
           '|Html|OverwriteMode|TabStopWidth|AcceptRichText|PlaceholderText';
  if ShowAttributes >= 2 then
    Result:= Result + '|CursorWidth|TextInteractionFlags|TabStopDistance' +
              '|LineWrapColumnsOrWidth|LineWrapMode|TabChangesFocus|WordWrapMode';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTextEdit.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'LineWrapMode'  then
    MakeAttribut(Attr, 'QTextEdit.' + Value)
  else if (Attr = 'AutoNone') or (Attr = 'AutoBulletList') or (Attr = 'AutoAll') then
    MakeAutoFormatting
  else if (Pos('Text', Attr) = 1) or (Pos('Link', Attr) = 1) or (Attr = 'NoTextInteraction') then
    MakeTextInteraction
  else if Attr = 'Html' then
    MakeHTML
  else if Attr = 'WordWrapMode' then
    MakeAttribut(Attr, 'QTextOption.WrapMode.' + Value)
  else
    inherited;
end;

function TQtTextEdit.getEvents(ShowEvents: integer): string;
begin
  Result:= '|copyAvailable|currentCharFormatChanged|cursorPositionChanged' +
           '|redoAvailable|selectionChanged|textChanged|undoAvailable';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtTextEdit.HandlerInfo(const event: string): string;
begin
  if event = 'copyAvailable' then
    Result:= 'bool;yes'
  else if event = 'currentCharFormatChanged' then
    Result:= 'QTextCharFormat;f'
  else if (event = 'redoAvailable') or (event = 'undoAvailable') then
    Result:= 'bool;available'
  else
    Result:= inherited;
end;

procedure TQtTextEdit.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.clear(');
    Slots.Add(Name + '.copy');
    Slots.Add(Name + '.cut');
    Slots.Add(Name + '.paste');
    Slots.Add(Name + '.redo');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.undo(');
  end else if Parametertypes = 'QString' then begin
    Slots.Add(Name + '.append');
    Slots.Add(Name + '.insertHtml');
    Slots.Add(Name + '.insertPlainText');
    Slots.Add(Name + '.scrollToAnchor');
    Slots.Add(Name + '.setFontFamily');
    Slots.Add(Name + '.setHtml');
    Slots.Add(Name + '.setMarkdown');
    Slots.Add(Name + '.setPlainText');
    Slots.Add(Name + '.setText');
  end else if Parametertypes = 'QFont' then
    Slots.Add(Name + '.setCurrentFont')
  else if Parametertypes = 'bool' then begin
    Slots.Add(Name + '.setFontItalic');
    Slots.Add(Name + '.setFontUnderline');
  end else if Parametertypes = 'int' then
    Slots.Add(Name + '.setFontWeight')
  else if Parametertypes = 'QColor' then begin
    Slots.Add(Name + '.setTextBackgroundColor');
    Slots.Add(Name + '.setTextColor');
  end;
  inherited;
end;

procedure TQtTextEdit.MakeAutoFormatting;
begin
  var s:= '';
  if AutoNone in FAutoFormatting then
    s:= s + '|QTextEdit.AutoNone';
  if AutoBulletList in FAutoFormatting then
    s:= s + '|QTextEdit.AutoBulletList';
  if AutoAll in FAutoFormatting then
    s:= s + '|QTextEdit.AutoAll';
  if s <> '' then begin
    delete(s, 1, 1);
    MakeAttribut('AutoFormatting', s);
  end else
    Partner.DeleteAttribute('self.' + name + '.setAutoFormatting');
end;

procedure TQtTextedit.MakeHTML;
begin
  MakeAttribut('Html', asString(myStringReplace(FHtml.Text, sLineBreak, '\n')));
end;

procedure TQtTextEdit.NewWidget(Widget: String = '');
begin
  if Widget = ''then begin
    inherited NewWidget('QTextEdit');
    MakeHTML;
  end else
    inherited NewWidget('QTextBrowser');
end;

procedure TQtTextEdit.Paint;
  var w, h, format: integer;
      SL: TStringList; R: TRect;
begin
  inherited;
  R:= InnerRect;
  R.Inflate(-HalfX, -HalfX);
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(R);
  SL:= TStringList.Create;
  format:= DT_LEFT;
  if FLineWrapMode = WidgetWidth then begin
    format:= format + DT_WORDBREAK;
    WrapText(FHtml.Text, R.Right - R.Left, w, h, SL);
  end else
    CalculateText(FHtml.Text, w, h, SL);
  if SL.Text <> CrLf then
    DrawText(Canvas.Handle, PChar(SL.Text), Length(SL.Text), R, format);
  FreeAndNil(SL);
end;

procedure TQtTextEdit.setLineWrapMode(Value: TTextEditLineWrapMode);
begin
  if Value <> FLineWrapMode then begin
    FLineWrapMode:= Value;
    Invalidate;
  end;
end;

procedure TQtTextEdit.setHTML(Value: TStrings);
begin
  if Value.Text <> FHtml.Text then begin
    FHtml.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtTextEdit.setPlaceholderText(Value: string);
begin
  if Value <> FPlaceholderText then begin
    FPlaceholderText:= Value;
    Invalidate;
  end;
end;

{--- TQtTextBrowser -----------------------------------------------------------}

constructor TQtTextBrowser.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 102;
  FrameShape:= StyledPanel;
  FrameShadow:= Sunken;
  LineWidth:= 1;
  FOpenLinks:= true;
  FSearchPaths:= TStringList.Create;
  FSearchPaths.Text:= '';
end;

destructor TQtTextBrowser.Destroy;
begin
  inherited;
  FreeAndNil(FSearchPaths);
end;

function TQtTextBrowser.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Source|SearchPaths|OpenExternalLinks|OpenLinks';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTextBrowser.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'SearchPaths' then
    MakeAttribut(Attr, getSearchPaths)
  else if Attr = 'Source' then
    MakeAttribut(Attr, 'QUrl(' + asString(Value) + ')')
  else
    inherited;
end;

function TQtTextBrowser.getSearchPaths: string;
begin
  Result:= '';
  for var i:= 0 to FSearchPaths.Count - 1 do
    Result:= Result + asString(FSearchPaths[i]) + ', ';
  delete(Result, Length(Result) - 1, 2);
  Result:= '[' + Result + ']';
end;

function TQtTextBrowser.getEvents(ShowEvents: integer): string;
begin
  Result:= '|anchorClicked|backwardAvailable|forwardAvailable' +
           '|highlighted|historyChanged|sourceChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtTextBrowser.HandlerInfo(const event: string): string;
begin
  if (event = 'anchorClicked') or (event = 'highlighted') then
    Result:= 'QUrl;link'
  else if (event = 'backwardAvailable') or (event = 'forwardAvailable') then
    Result:= 'bool;available'
  else if event = 'sourceChanged' then
    Result:= 'QUrl;src'
  else
    Result:= inherited;
end;

procedure TQtTextBrowser.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.backward');
    Slots.Add(Name + '.forward');
    Slots.Add(Name + '.home');
    Slots.Add(Name + '.reload');
  end else if Parametertypes = 'QUrl, QTextDocument' then
    Slots.Add(Name + '.setSource');
  inherited;
end;

procedure TQtTextBrowser.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QTextBrowser');
end;

{--- TQtGraphicsView ----------------------------------------------------------}

constructor TQtGraphicsView.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 120;
  Width:= 256;
  Height:= 104;
  FrameShape:= StyledPanel;
  FrameShadow:= Sunken;
  LineWidth:= 1;
  FInteractive:= true;
  FRenderHints:= [TextAntialiasing];
  FTransformationAnchor:= AnchorViewCenter;
  FViewportUpdateMode:= MinimalViewportUpdate;
  FRubberBandSelectioMode:= IntersectsItemShape;
end;

function TQtGraphicsView.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|BackgroundColor|ForegroundColor|ForegroundStyle|BackgroundStyle|Interactive' +
           '|Alignment|RenderHints|DragMode|CacheMode|TransformationAnchor|SceneRect' +
           '|ResizeAnchor|ViewportUpdateMode|RubberBandSelectionMode|OptimizationFlags';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TQtGraphicsView.getEvents(ShowEvents: integer): string;
begin
  Result:= '|rubberBandChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtGraphicsView.HandlerInfo(const event: string): string;
begin
  if event = 'rubberBandChanged' then
    Result:= 'QRect, QPointF, QPointF;rubberBandRect, fromScenePoint, toScenePoint'
  else
    Result:= inherited;
end;

procedure TQtGraphicsView.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'QRect, QGraphicsScene' then
    Slots.Add(Name + '.invalidateScene')
  else if Parametertypes = 'QList' then
    Slots.Add(Name + '.updateScene')
  else if Parametertypes = 'QRectF' then
    Slots.Add(Name + '.updateSceneRect');
  inherited;
end;

procedure TQtGraphicsView.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'CacheMode' then
    MakeAttribut(Attr, 'QGraphicsView.CacheModeFlag.' + Value)
  else if (Attr = 'ViewportUpdateMode') or (Attr = 'DragMode') then
    MakeAttribut(Attr, 'QGraphicsView.' + Attr + '.' + Value)
  else if (Attr = 'ResizeAnchor') or (Attr = 'TransformationAnchor') then
    MakeAttribut(Attr, 'QGraphicsView.ViewportAnchor.' + Value)
  else if Attr = 'RubberBandSelectionMode' then
    MakeAttribut(Attr, 'Qt.' + Value)
  else if (Pos('Antialiasing', Attr) > 0) or (Attr = 'SmoothPixmapTransform') or
    (Attr = 'LosslessImageRendering') then
    MakeRenderHints
  else if Pos('Dont', Attr) = 1 then
    MakeOptimizationFlags
  else if (Attr = 'ForegroundColor') or (Attr = 'BackgroundColor') or
          (Attr = 'ForegroundStyle') or (Attr = 'BackgroundStyle')
  then
    MakeColorAndStyle(Attr)
  else
    inherited;
end;

procedure TQtGraphicsView.MakeRenderHints;
begin
  var s:= '';
  if Antialiasing in FRenderHints then
    s:= s + '|QPainter.Antialiasing';
  if TextAntialiasing in FRenderHints then
    s:= s + '|QPainter.TextAntialiasing';
  if SmoothPixmapTransform in FRenderHints then
    s:= s + '|QPainter.SmoothPixmapTransform';
{  if VerticalSubpixelPositioning in FRenderHints then
    s:= s + '|QPainter.VerticalSubpixelPositioning';
}
  if LosslessImageRendering in FRenderHints then
    s:= s + '|QPainter.LosslessImageRendering';
  if s <> '' then begin
    delete(s, 1, 1);
    MakeAttribut('RenderHints', s);
  end else
    Partner.DeleteAttribute('self.' + name + '.setRenderHints');
end;

procedure TQtGraphicsView.MakeOptimizationFlags;
begin
  var s:= '';
  if DontSavePainterState in FOptimizationFlags then
    s:= s + '|QGraphicsView.DontSavePainterState';
  if DontAdjustForAntialiasing in FOptimizationFlags then
    s:= s + '|QGraphicsView.DontAdjustForAntialiasing';
  if DontClipPainter in FOptimizationFlags then
    s:= s + '|QGraphicsView.DontClipPainter';
  if s <> '' then begin
    delete(s, 1, 1);
    MakeAttribut('OptimizationFlags', s);
  end else
    Partner.DeleteAttribute('self.' + Name + '.setOptimizationFlags');
end;

procedure TQtGraphicsView.MakeColorAndStyle(Attr: string);
  var R, G, B: integer; Color, Style: string;
begin
  if Pos('Foreground', Attr) = 1 then begin
    Color2RGB(FForegroundColor, R, G, B);
    Style:= 'Qt.BrushStyle.' + enumTostring(FForegroundStyle);
    Attr:= 'Foreground';
  end else begin
    Color2RGB(FBackgroundColor, R, G, B);
    Style:= 'Qt.BrushStyle.' + enumTostring(FBackgroundStyle);
    Attr:= 'Background';
  end;
  Color:= 'QColor(' + IntToStr(R) + ', ' + IntToStr(G) + ', ' +
                      IntToStr(B) + ', 255)';
  MakeAttribut(Attr + 'Brush', 'QBrush(' + Color + ', ' + Style + ')')
end;

procedure TQtGraphicsView.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QGraphicsView');
end;

procedure TQtGraphicsView.Paint;
begin
  inherited;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(InnerRect);
end;

{--- TQtAbstractSlider --------------------------------------------------------}

function TQtAbstractSlider.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Minimum|Maximum|Value|Orientation';
  if ShowAttributes >= 2 then
    Result:= Result + '|SingleStep|PageStep|SliderPosition|Tracking' +
                      '|InvertedAppearance|InvertedControls';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtAbstractSlider.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Orientation'  then
    MakeAttribut(Attr, 'Qt.Orientation.' + Value)
  else
    inherited;
end;

function TQtAbstractSlider.getEvents(ShowEvents: integer): string;
begin
  Result:= '|actionTriggered|rangeChanged|sliderMoved|sliderPressed' +
           '|sliderReleased|valueChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtAbstractSlider.HandlerInfo(const event: string): string;
begin
  if event = 'actionTriggered' then
    Result:= 'int;action'
  else if event = 'rangeChanged' then
    Result:= 'int, int;min, max'
  else if (event = 'sliderMoved') or (event = 'valueChanged') then
    Result:= 'int;value'
  else
    Result:= inherited;
end;

procedure TQtAbstractSlider.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'Orientation' then
    Slots.Add(Name + '.setOrientation')
  else if Parametertypes = 'int, int' then
    Slots.Add(Name + '.setTange')
  else if Parametertypes = 'int' then
    Slots.Add(Name + '.setValue');
  inherited;
end;

procedure TQtAbstractSlider.setOrientation(Value: TOrientation);
  var h: integer;
begin
  if Value <> FOrientation then begin
    FOrientation:= Value;
    if not (csLoading in ComponentState) then begin
      h:= Width; Width:= Height; Height:= h;
      SetPositionAndSize;
    end;
    Invalidate;
  end;
end;

procedure TQtAbstractSlider.setValue(Value: integer);
begin
  if Value <> FValue then begin
    FValue:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSlider.setInvertedAppearance(Value: boolean);
begin
  if Value <> FInvertedAppearance then begin
    FInvertedAppearance:= Value;
    Invalidate;
  end;
end;

{--- TQtScrollBar -------------------------------------------------------------}

constructor TQtScrollBar.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 80;
  Width:= 120;
  Height:= 16;
  FMaximum:= 99;
  FSingleStep:= 1;
  FPageStep:= 10;
  FTracking:= true;
  FOrientation:= Horizontal;
  FInvertedControls:= true;
end;

procedure TQtScrollBar.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QScrollBar');
  InsertValue('self.' + Name + '.setOrientation(Qt.Orientation.Horizontal)');
end;

procedure TQtScrollBar.Paint;
begin
  PaintScrollbar(ClientRect, FOrientation = Horizontal);
end;

{--- TQtSlider ----------------------------------------------------------------}

constructor TQtSlider.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 84;
  Width:= 120;
  Height:= 24;
  FMaximum:= 99;
  FSingleStep:= 1;
  FPageStep:= 10;
  FTracking:= true;
  FOrientation:= Horizontal;
  FInvertedControls:= true;
end;

procedure TQtSlider.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'TickPosition' then
    MakeAttribut(Attr, 'QSlider.TickPosition.' + Value)
  else
    inherited;
end;

function TQtSlider.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|TickPosition|TickInterval';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtSlider.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QSlider');
  InsertValue('self.' + Name + '.setOrientation(Qt.Orientation.Horizontal)');
end;

procedure TQtSlider.Paint;

  type TArrayOfPoint = array of TPoint;

  var R: TRect; TickInc: double;
      i, X, Y, V, SliderWidth, SliderHeight, UsablePixels,
      Tick1, Tick2, TickCount: integer;
      Arr: TArrayOfPoint;

  function RectToArrow: TArrayOfPoint;
    var Arr: TArrayOfPoint; TickPos: TTickPosition;
  begin
    TickPos:= FTickPosition;
    if FOrientation = Horizontal then begin
      if TickPos = TicksRight then
        TickPos:= TicksBelow
      else if TickPos = TicksLeft then
        TickPos:= TicksAbove
    end else begin
      if TickPos = TicksAbove then
        TickPos:= TicksLeft
      else if TickPos = TicksBelow then
        TickPos:= TicksRight;
    end;
    setLength(Arr, 5);
    case TickPos of
      NoTicks,
      TicksBothSides: begin
        Arr[0]:= Point(R.Left, R.Top);
        Arr[1]:= Point(R.Right, R.Top);
        Arr[2]:= Point(R.Right, R.Bottom);
        Arr[3]:= Point(R.Left, R.Bottom);
        setLength(Arr, 4);
      end;
      TicksAbove: begin
        Arr[0]:= Point(R.Left, R.Top + 5);
        Arr[1]:= Point(R.Left + 5, R.Top);
        Arr[2]:= Point(R.Right, R.Top + 5);
        Arr[3]:= Point(R.Right, R.Bottom);
        Arr[4]:= Point(R.Left, R.Bottom);
      end;
      TicksLeft: begin
        Arr[0]:= Point(R.Left + 5, R.Bottom);
        Arr[1]:= Point(R.Left, R.Top + 5);
        Arr[2]:= Point(R.Left + 5, R.Top);
        Arr[3]:= Point(R.Right, R.Top);
        Arr[4]:= Point(R.Right, R.Bottom);
      end;
      TicksBelow: begin
        Arr[0]:= Point(R.Right, R.Bottom - 5);
        Arr[1]:= Point(R.Right - 5, R.Bottom);
        Arr[2]:= Point(R.Left, R.Bottom - 5);
        Arr[3]:= Point(R.Left, R.Top);
        Arr[4]:= Point(R.Right, R.Top);
      end;
      TicksRight: begin
        Arr[0]:= Point(R.Right - 5, R.Top);
        Arr[1]:= Point(R.Right, R.Top + 5);
        Arr[2]:= Point(R.Right - 5, R.Bottom);
        Arr[3]:= Point(R.Left, R.Bottom);
        Arr[4]:= Point(R.Left, r.Top);
      end;
    end;
    Result:= Arr;
  end;

begin
  inherited;
  Canvas.Brush.Color:= $EAEAE7;
  Canvas.Pen.Color:= $D6D6D6;
  Tick2:= 0;

  // track
  if FOrientation = Horizontal then begin
    R.Left  := 1;
    R.Right := Width - 1;
    if FTickPosition in [NoTicks, TicksBothSides] then begin
      R.Top:= Height div 2 - 1;
      Tick1:= Round(Height/4.0);
      Tick2:= Round(3*Height/4.0);
    end else if FTickPosition in [TicksRight, TicksBelow] then begin
      R.Top:= Round(Height/3.0) - 1;
      Tick1:= Round(2.0*Height/3.0);
    end else begin
      R.Top:= Round(2.0*Height/3.0) - 1;
      Tick1:= Round(Height/3.0);
    end;
    R.Bottom:= R.Top + 3;
    SliderWidth := 10;
    SliderHeight:= 21;
    UsablePixels := Width - 2 - SliderWidth;
  end else begin
    R.Top := 1;
    R.Bottom := Height - 1;
    if FTickPosition in [NoTicks, TicksBothSides] then begin
      R.Left:= Width div 2 - 1;
      Tick1:= Round(Width/4.0);
      Tick2:= Round(3*Width/4.0);
    end else if FTickPosition in [TicksRight, TicksBelow] then begin
      R.Left:= Round(Width/3.0) - 1;
      Tick1:= Round(2.0*Width/3.0);
    end else begin
      R.Left:= Round(2.0*Width/3.0) - 1;
      Tick1:= Round(Width/3.0);
    end;
    R.Right := R.Left + 3;
    SliderWidth := 21;
    SliderHeight:= 10;
    UsablePixels := Height - 2 - SliderHeight;
  end;
  Canvas.Rectangle(R);

  // ticks
  if FTickPosition <> NoTicks then begin
    Canvas.Pen.Color:= $94A2A5;
    if FTickInterval = 0
      then TickInc:= (FMaximum - FMinimum)/10.0
      else TickInc:= (FMaximum - FMinimum)/FTickInterval;
    TickCount:= Round((FMaximum - FMinimum)/TickInc);
    if FOrientation = Horizontal then
      for i:= 0 to TickCount  do begin
        x:= Round(UsablePixels * (FMinimum + i*TickInc) / (FMaximum - FMinimum) + TickInc/2 + 1);
        Canvas.MoveTo(x, Tick1 - 2);
        Canvas.LineTo(x, Tick1 + 2);
        if FTickPosition = TicksBothSides then begin
          Canvas.MoveTo(x, Tick2 - 2);
          Canvas.LineTo(x, Tick2 + 2);
        end;
      end
    else
      for i:= 0 to TickCount do begin
        y:= Round(UsablePixels * (FMinimum + i*TickInc) / (FMaximum - FMinimum) + TickInc/2 + 1);
        Canvas.MoveTo(Tick1 - 2, y);
        Canvas.LineTo(Tick1 + 2, y);
        if FTickPosition = TicksBothSides then begin
          Canvas.MoveTo(Tick2 - 2, y);
          Canvas.LineTo(Tick2 + 2, y);
        end;
      end
  end;

  // slider
  if FInvertedAppearance and (FOrientation = Horizontal) or
     not FInvertedAppearance and (FOrientation = Vertical)
    then V:= Round(UsablePixels * (FMaximum - FValue) / (FMaximum - FMinimum)) + 1
    else V:= Round(UsablePixels * (FValue - FMinimum) / (FMaximum - FMinimum)) + 1;
  if FOrientation = Horizontal then begin
    X:= Round(V);
    Y:= R.Top + 1 - SliderHeight div 2;
    R:= Rect(X, Y, X + SliderWidth, Y + SliderHeight)
  end else begin
    X:= R.Left + 1 - SliderWidth div 2;
    Y:= Round(V);
    R:= Rect(X, Y, X + SliderWidth, Y + SliderHeight)
  end;
  Canvas.Pen.Color:= $D97A00;
  Canvas.Brush.Color:= $D97A00;
  Arr:= RectToArrow;
  Canvas.Polygon(Arr);
  setLength(Arr, 0);
end;

procedure TQtSlider.setTickPosition(Value: TTickPosition);
begin
  if Value <> FTickPosition then begin
    FTickPosition:= Value;
    Invalidate;
  end;
end;

procedure TQtSlider.setTickInterval(Value: integer);
begin
  if Value <> FTickInterval then begin
    FTickInterval:= Value;
    Invalidate;
  end;
end;

{--- TQtDial ------------------------------------------------------------------}

constructor TQtDial.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 111;
  Width:= 64;
  Height:= 64;
  FMaximum:= 99;
  FSingleStep:= 1;
  FPageStep:= 10;
  FTracking:= true;
  FNotchTarget:= 3.7;
end;

function TQtDial.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Wrapping|NotchTarget|NotchesVisible';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtDial.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then begin
    Slots.Add(Name + '.setNotchesVisible');
    Slots.Add(Name + '.setWrapping');
  end;
  inherited;
end;

procedure TQtDial.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QDial');
end;

procedure TQtDial.Paint;
  var Radius, Radius1, Radius2, count, size, WholeArc, PageStepArc, SingleStepArc,
      SingleStepPerNotchTarget, StartAngle, EndAngle, Angle, mx, my: integer;
      ValueAngle: double;
      R: TRect; CP: TPoint;
begin
  // big circle
  Canvas.Brush.Color:= $F5F5F5;
  Canvas.Pen.Color:= $606060;
  R:= InnerRect;
  CP:= R.CenterPoint;
  size:= min(Width, Height) div 2;
  Radius:= round(0.82*size);
  Canvas.Ellipse(CP.x - Radius, CP.y - Radius, CP.x + Radius, CP.y + Radius);

  if FWrapping then begin
    StartAngle:= 0;
    EndAngle:= 360;
  end else begin
    StartAngle:= -60;
    EndAngle:= 240;
  end;

  // show notches
  if FNotchesVisible then begin
    WholeArc:= round(0.5 + 2*System.PI*Radius);
    if not FWrapping then
      WholeArc:= Round(0.5 + 5/6*2*System.PI*Radius);
    if Maximum > Minimum + PageStep
      then PageStepArc:= Round(0.5 + WholeArc * (PageStep/(Maximum - Minimum)))
      else PageStepArc:= Round(0.5 + WholeArc);
    if PageStepArc <> 0
      then SingleStepArc:= Round(0.5 + PageStepArc*SingleStep/PageStep)
      else SingleStepArc:= Round(0.5 + PageStepArc*SingleStep);
    if SingleStepArc < 1 then
      SingleStepArc:= 1;
    SingleStepPerNotchTarget:= round(0.5 + NotchTarget/SingleStepArc);
    if SingleStepPerNotchTarget < 1 then
      SingleStepPerNotchTarget:= 1;
    Radius1:= round(0.9*size);
    Radius2:= round(1.0*size);
    Angle:= StartAngle;
    Count:= 0;

    while Angle <= EndAngle do begin
      if Count = 0 then begin
        Canvas.MoveTo(CP.x - Round(Radius*cos(Angle*Pi/180)), CP.y - Round(Radius*sin(Angle*Pi/180)));
        Count:= Round(PageStep/SingleStep);
      end else
        Canvas.MoveTo(CP.x - Round(Radius1*cos(Angle*Pi/180)), CP.y - Round(Radius1*sin(Angle*Pi/180)));
      Canvas.LineTo(CP.x - Round(Radius2*cos(Angle*Pi/180)), CP.y - Round(Radius2*sin(Angle*Pi/180)));
      Angle:= Angle + SingleStepPerNotchTarget;
      Count:= Count - 1;
    end;
  end;

  // small value circle
  ValueAngle:= StartAngle + Value/(Maximum - Minimum)*(EndAngle - StartAngle);
  if FWrapping then
    ValueAngle:= ValueAngle - 90;

  Radius1:= Round(0.6*size);
  Radius2:= Round((0.78 - 0.65)*size);
  mx:= CP.x - Round(Radius1*cos(ValueAngle*Pi/180));
  my:= CP.y - round(Radius1*sin(ValueAngle*Pi/180));
  Canvas.Ellipse(mx - Radius2, my - Radius2, mx + Radius2, my + Radius2);
end;

procedure TQtDial.setWrapping(Value: boolean);
begin
  if Value <> FWrapping then begin
    FWrapping:= Value;
    Invalidate;
  end;
end;

procedure TQtDial.setNotchTarget(Value: double);
begin
  if Value <> FNotchTarget then begin
    FNotchTarget:= Value;
    Invalidate;
  end;
end;

procedure TQtDial.setNotchesVisible(Value: boolean);
begin
  if Value <> FNotchesVisible then begin
    FNotchesVisible:= Value;
    Invalidate;
  end;
end;

end.
