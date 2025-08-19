{ -------------------------------------------------------------------------------
  Unit:     UQtScrollable
  Author:   Gerhard Röhner
  Date:     July 2022
  Purpose:  PyQt scrollable widgets
  ------------------------------------------------------------------------------- }
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
  Windows,
  Graphics,
  Classes,
  UBaseQtWidgets,
  UQtFrameBased;

type

  TScrollBarPolicy = (ScrollBarAsNeeded, ScrollBarAlwaysOff, ScrollBarAlwaysOn);

  TSizeAdjustPolicy = (AdjustIgnored, AdjustToContentsOnFirstShow,
    AdjustToContents);

  TTickPosition = (NoTicks, TicksAbove, TicksLeft, TicksBelow, TicksRight,
    TicksBothSides);

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
  TAnchor = (NoAnchor, AnchorViewCenter, AnchorUnderMouse);

  // QGraphicsView
  TViewportUpdateMode = (FullViewportUpdate, MinimalViewportUpdate,
    SmartViewportUpdate, BoundingRectViewportUpdate, NoViewportUpdate);

  // Qt
  TRubberBandSelectionMode = (ContainsItemShape, IntersectsItemShape,
    ContainsItemBoundingRect, IntersectsItemBoundingRect);

  // QGraphicsView
  TOptimizationFlag = (DontSavePainterState, DontAdjustForAntialiasing,
    DontClipPainter);
  TOptimizationFlags = set of TOptimizationFlag;

  // Qt
  TQtBrushStyle = (SolidPattern, Dense1Pattern, Dense2Pattern, Dense3Pattern,
    Dense4Pattern, Dense5Patten, Dense6Pattern, Dense7Pattern, NoBrush,
    HorPattern, VerPattern, CrossPattern, BDiagPattern, FDiagPattern,
    DiagCrossPattern, LinearGradientPattern, RadialGradientPattern,
    ConicalGradientPattern);

  TTextEditLineWrapMode = (NoWrap, WidgetWidth, FixedPixelWidth,
    FixedColumnWidth);
  TPlainTextLineWrapMode = NoWrap .. WidgetWidth;
  TWordWrapMode = (_WW_NoWrap, _WW_WordWrap, _WW_ManualWrap, _WW_WrapAnywhere,
    _WW_WrapAtWordBoundaryOrAnywhere);

  TQtAbstractScrollArea = class(TQtFrame)
  private
    FHorizontalScrollBarPolicy: TScrollBarPolicy;
    FVerticalScrollBarPolicy: TScrollBarPolicy;
    FSizeAdjustPolicy: TSizeAdjustPolicy;
    FTextInteractionFlags: TTextInteractionFlags;
    procedure SetHorizontalScrollBarPolicy(Value: TScrollBarPolicy);
    procedure SetVerticalScrollBarPolicy(Value: TScrollBarPolicy);
    procedure PaintScrollbars;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure Paint; override;
    function InnerRect: TRect; override;
    procedure PaintAScrollbar(Horizontal: Boolean);
    procedure MakeTextInteraction;
    property TextInteractionFlags: TTextInteractionFlags
      read FTextInteractionFlags write FTextInteractionFlags;
  published
    property HorizontalScrollBarPolicy: TScrollBarPolicy
      read FHorizontalScrollBarPolicy write SetHorizontalScrollBarPolicy;
    property VerticalScrollBarPolicy: TScrollBarPolicy
      read FVerticalScrollBarPolicy write SetVerticalScrollBarPolicy;
    property SizeAdjustPolicy: TSizeAdjustPolicy read FSizeAdjustPolicy
      write FSizeAdjustPolicy;
  end;

  TQtScrollArea = class(TQtAbstractScrollArea)
  private
    FWidgetResizable: Boolean;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property WidgetResizable: Boolean read FWidgetResizable
      write FWidgetResizable;
  end;

  TQtPlainTextEdit = class(TQtAbstractScrollArea)
  private
    FBackgroundVisible: Boolean;
    FBlockCountChanged: string;
    FCenterOnScroll: Boolean;
    FCopyAvailable: string;
    FCursorPositionChanged: string;
    FCursorWidth: Integer;
    FDocumentTitle: string;
    FLineWrapMode: TPlainTextLineWrapMode;
    FMaximumBlockCount: Integer;
    FModificationChanged: string;
    FOverwriteMode: Boolean;
    FPlaceHolderText: string;
    FPlainText: TStrings;
    FReadOnly: Boolean;
    FRedoAvailable: string;
    FSelectionChanged: string;
    FTabChangesFocus: Boolean;
    FTabStopDistance: Integer;
    FTabStopWidth: Integer;
    FTextChanged: string;
    FUndoAvailable: string;
    FUndoRedoEnabled: Boolean;
    FUpdateRequest: string;
    FWordWrapMode: TWordWrapMode;
    procedure SetTabChangesFocus(Value: Boolean);
    procedure SetLineWrapMode(Value: TPlainTextLineWrapMode);
    procedure SetPlainText(Value: TStrings);
    procedure SetPlaceholderText(const Value: string);
    procedure MakePlainText;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property TabChangesFocus: Boolean read FTabChangesFocus
      write SetTabChangesFocus;
    property DocumentTitle: string read FDocumentTitle write FDocumentTitle;
    property UndoRedoEnabled: Boolean read FUndoRedoEnabled
      write FUndoRedoEnabled;
    property LineWrapMode: TPlainTextLineWrapMode read FLineWrapMode
      write SetLineWrapMode;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property PlainText: TStrings read FPlainText write SetPlainText;
    property OverwriteMode: Boolean read FOverwriteMode write FOverwriteMode;
    property TabStopWidth: Integer read FTabStopWidth write FTabStopWidth;
    property TabStopDistance: Integer read FTabStopDistance
      write FTabStopDistance;
    property CursorWidth: Integer read FCursorWidth write FCursorWidth;
    property TextInteractionFlags;
    property MaximumBlockCount: Integer read FMaximumBlockCount
      write FMaximumBlockCount;
    property BackgroundVisible: Boolean read FBackgroundVisible
      write FBackgroundVisible;
    property CenterOnScroll: Boolean read FCenterOnScroll write FCenterOnScroll;
    property PlaceholderText: string read FPlaceHolderText
      write SetPlaceholderText;
    property WordWrapMode: TWordWrapMode read FWordWrapMode write FWordWrapMode;
    // signals
    property blockCountChanged: string read FBlockCountChanged
      write FBlockCountChanged;
    property copyAvailable: string read FCopyAvailable write FCopyAvailable;
    property cursorPositionChanged: string read FCursorPositionChanged
      write FCursorPositionChanged;
    property modificationChanged: string read FModificationChanged
      write FModificationChanged;
    property redoAvailable: string read FRedoAvailable write FRedoAvailable;
    property selectionChanged: string read FSelectionChanged
      write FSelectionChanged;
    property textChanged: string read FTextChanged write FTextChanged;
    property undoAvailable: string read FUndoAvailable write FUndoAvailable;
    property updateRequest: string read FUpdateRequest write FUpdateRequest;
  end;

  TQtTextEdit = class(TQtAbstractScrollArea)
  private
    FAutoFormatting: TAutoFormatting;
    FTabChangesFocus: Boolean;
    FDocumentTitle: string;
    FUndoRedoEnabled: Boolean;
    FLineWrapMode: TTextEditLineWrapMode;
    FLineWarpColumnOrWidth: Integer;
    FReadOnly: Boolean;
    FMarkDown: string;
    FHtml: TStrings;
    FOverwriteMode: Boolean;
    FTabStopWidth: Integer;
    FTabStopDistance: Double;
    FAcceptRichText: Boolean;
    FCursorWidth: Integer;
    FPlaceHolderText: string;
    FCopyAvailable: string;
    FCurrentCharFormatChanged: string;
    FCursorPositionChanged: string;
    FRedoAvailable: string;
    FSelectionChanged: string;
    FTextChanged: string;
    FUndoAvailable: string;
    FWordWrapMode: TWordWrapMode;
    procedure SetLineWrapMode(Value: TTextEditLineWrapMode);
    procedure SetHTML(Value: TStrings);
    procedure SetPlaceholderText(const Value: string);
    procedure MakeAutoFormatting;
    procedure MakeHTML;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property AutoFormatting: TAutoFormatting read FAutoFormatting
      write FAutoFormatting;
    property TabChangesFocus: Boolean read FTabChangesFocus
      write FTabChangesFocus;
    property DocumentTitle: string read FDocumentTitle write FDocumentTitle;
    property UndoRedoEnabled: Boolean read FUndoRedoEnabled
      write FUndoRedoEnabled;
    property LineWrapMode: TTextEditLineWrapMode read FLineWrapMode
      write SetLineWrapMode;
    property LineWarpColumnOrWidth: Integer read FLineWarpColumnOrWidth
      write FLineWarpColumnOrWidth;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property MarkDown: string read FMarkDown write FMarkDown;
    property Html: TStrings read FHtml write SetHTML;
    property OverwriteMode: Boolean read FOverwriteMode write FOverwriteMode;
    property TextInteractionFlags;
    property TabStopWidth: Integer read FTabStopWidth write FTabStopWidth;
    property TabStopDistance: Double read FTabStopDistance
      write FTabStopDistance;
    property AcceptRichText: Boolean read FAcceptRichText write FAcceptRichText;
    property CursorWidth: Integer read FCursorWidth write FCursorWidth;
    property PlaceholderText: string read FPlaceHolderText
      write SetPlaceholderText;
    property WordWrapMode: TWordWrapMode read FWordWrapMode write FWordWrapMode;
    // signals
    property copyAvailable: string read FCopyAvailable write FCopyAvailable;
    property currentCharFormatChanged: string read FCurrentCharFormatChanged
      write FCurrentCharFormatChanged;
    property cursorPositionChanged: string read FCursorPositionChanged
      write FCursorPositionChanged;
    property redoAvailable: string read FRedoAvailable write FRedoAvailable;
    property selectionChanged: string read FSelectionChanged
      write FSelectionChanged;
    property textChanged: string read FTextChanged write FTextChanged;
    property undoAvailable: string read FUndoAvailable write FUndoAvailable;
  end;

  TQtTextBrowser = class(TQtTextEdit)
  private
    FSource: string;
    FSearchPaths: TStrings;
    FOpenExternalLinks: Boolean;
    FOpenLinks: Boolean;
    FAnchorClicked: string;
    FBackwardAvailable: string;
    FForwardAvailable: string;
    FHighlighted: string;
    FHistoryChanged: string;
    FSourceChanged: string;
    function GetSearchPaths: string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property Source: string read FSource write FSource;
    property SearchPaths: TStrings read FSearchPaths write FSearchPaths;
    property OpenExternalLinks: Boolean read FOpenExternalLinks
      write FOpenExternalLinks;
    property OpenLinks: Boolean read FOpenLinks write FOpenLinks;
    // signals
    property anchorClicked: string read FAnchorClicked write FAnchorClicked;
    property backwardAvailable: string read FBackwardAvailable
      write FBackwardAvailable;
    property forwardAvailable: string read FForwardAvailable
      write FForwardAvailable;
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
    FInteractive: Boolean;
    // FSceneRect: TQtRect;
    // FAlignment: TQtAlignment;
    FRenderHints: TRenderHints;
    FDragMode: TQtDragMode;
    FCacheMode: TCacheMode;
    FTransformationAnchor: TAnchor;
    FResizeAnchor: TAnchor;
    FViewportUpdateMode: TViewportUpdateMode;
    FRubberBandSelectionMode: TRubberBandSelectionMode;
    FOptimizationFlags: TOptimizationFlags;
    FRubberBandChanged: string;
    procedure MakeRenderHints;
    procedure MakeOptimizationFlags;
    procedure MakeColorAndStyle(Attr: string);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property BackgroundColor: TColor read FBackgroundColor
      write FBackgroundColor;
    property ForegroundColor: TColor read FForegroundColor
      write FForegroundColor;
    property BackgroundStyle: TQtBrushStyle read FBackgroundStyle
      write FBackgroundStyle;
    property ForegroundStyle: TQtBrushStyle read FForegroundStyle
      write FForegroundStyle;
    property Interactive: Boolean read FInteractive write FInteractive;
    // property SceneRect: TQtRect read FSceneRect write FSceneRect;
    // property Alignment: TQtAlignment read FAlignment write FAlignment;
    property RenderHints: TRenderHints read FRenderHints write FRenderHints;
    property DragMode: TQtDragMode read FDragMode write FDragMode;
    property CacheMode: TCacheMode read FCacheMode write FCacheMode;
    property TransformationAnchor: TAnchor read FTransformationAnchor
      write FTransformationAnchor;
    property ResizeAnchor: TAnchor read FResizeAnchor write FResizeAnchor;
    property ViewportUpdateMode: TViewportUpdateMode read FViewportUpdateMode
      write FViewportUpdateMode;
    property RubberBandSelectionMode: TRubberBandSelectionMode
      read FRubberBandSelectionMode write FRubberBandSelectionMode;
    property OptimizationFlags: TOptimizationFlags read FOptimizationFlags
      write FOptimizationFlags;
    // signals
    property rubberBandChanged: string read FRubberBandChanged
      write FRubberBandChanged;
  end;

  TQtAbstractSlider = class(TBaseQtWidget)
  private
    FMinimum: Integer;
    FMaximum: Integer;
    FSingleStep: Integer;
    FPageStep: Integer;
    FValue: Integer;
    FSliderPosition: Integer;
    FTracking: Boolean;
    FOrientation: TOrientation;
    FInvertedAppearance: Boolean;
    FInvertedControls: Boolean;
    FActionTriggered: string;
    FRangeChanged: string;
    FSliderMoved: string;
    FSliderPressed: string;
    FSliderReleased: string;
    FValueChanged: string;
    procedure SetOrientation(Value: TOrientation);
    procedure SetValue(Value: Integer);
    procedure SetInvertedAppearance(Value: Boolean);
  public
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
  published
    property Minimum: Integer read FMinimum write FMinimum;
    property Maximum: Integer read FMaximum write FMaximum;
    property SingleStep: Integer read FSingleStep write FSingleStep;
    property PageStep: Integer read FPageStep write FPageStep;
    property Value: Integer read FValue write SetValue;
    property SliderPosition: Integer read FSliderPosition write FSliderPosition;
    property Tracking: Boolean read FTracking write FTracking;
    property Orientation: TOrientation read FOrientation write SetOrientation;
    property InvertedAppearance: Boolean read FInvertedAppearance
      write SetInvertedAppearance;
    property InvertedControls: Boolean read FInvertedControls
      write FInvertedControls;
    // signals
    property actionTriggered: string read FActionTriggered
      write FActionTriggered;
    property rangeChanged: string read FRangeChanged write FRangeChanged;
    property sliderMoved: string read FSliderMoved write FSliderMoved;
    property sliderPressed: string read FSliderPressed write FSliderPressed;
    property sliderReleased: string read FSliderReleased write FSliderReleased;
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtScrollBar = class(TQtAbstractSlider)
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  end;

  TQtSlider = class(TQtAbstractSlider)
  private
    FTickPosition: TTickPosition;
    FTickInterval: Integer;
    procedure SetTickPosition(Value: TTickPosition);
    procedure SetTickInterval(Value: Integer);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property TickPosition: TTickPosition read FTickPosition
      write SetTickPosition;
    property TickInterval: Integer read FTickInterval write SetTickInterval;
  end;

  TQtDial = class(TQtAbstractSlider)
  private
    FWrapping: Boolean;
    FNotchTarget: Double;
    FNotchesVisible: Boolean;
    procedure SetWrapping(Value: Boolean);
    procedure SetNotchTarget(Value: Double);
    procedure SetNotchesVisible(Value: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property Wrapping: Boolean read FWrapping write SetWrapping;
    property NotchTarget: Double read FNotchTarget write SetNotchTarget;
    property NotchesVisible: Boolean read FNotchesVisible
      write SetNotchesVisible;
  end;

implementation

uses
  Controls,
  SysUtils,
  Types,
  Math,
  UUtils;

{ --- TQtAbstractScrollArea ---------------------------------------------------- }

constructor TQtAbstractScrollArea.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FTextInteractionFlags := [TextSelectableByMouse, TextSelectableByKeyboard,
    TextEditable];
end;

function TQtAbstractScrollArea.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|VerticalScrollBarPolicy|HorizontalScrollBarPolicy|';
  if ShowAttributes = 3 then
    Result := Result + '|SizeAdjustPolicy';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtAbstractScrollArea.SetAttribute(const Attr, Value, Typ: string);
begin
  if (Attr = 'HorizontalScrollBarPolicy') or (Attr = 'VerticalScrollBarPolicy')
  then
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
var
  ARect: TRect;
begin
  ARect := inherited InnerRect;
  if FHorizontalScrollBarPolicy = ScrollBarAlwaysOn then
  begin
    ARect.Top := ARect.Bottom - 16;
    if FVerticalScrollBarPolicy = ScrollBarAlwaysOn then
      ARect.Right := ARect.Right - 16;
    PaintScrollbar(ARect, True);
  end;
  ARect := inherited InnerRect;
  if FVerticalScrollBarPolicy = ScrollBarAlwaysOn then
  begin
    ARect.Left := ARect.Right - 16;
    if FHorizontalScrollBarPolicy = ScrollBarAlwaysOn then
      ARect.Bottom := ARect.Bottom - 16;
    PaintScrollbar(ARect, False);
  end;
end;

procedure TQtAbstractScrollArea.PaintAScrollbar(Horizontal: Boolean);
var
  ARect: TRect;
begin
  ARect := inherited InnerRect;
  if Horizontal then
    ARect.Top := ARect.Bottom - 16
  else
    ARect.Left := ARect.Right - 16;
  PaintScrollbar(ARect, Horizontal);
end;

function TQtAbstractScrollArea.InnerRect: TRect;
begin
  Result := inherited;
  if FHorizontalScrollBarPolicy = ScrollBarAlwaysOn then
    Result.Bottom := Result.Bottom - 16;
  if FVerticalScrollBarPolicy = ScrollBarAlwaysOn then
    Result.Right := Result.Right - 16;
end;

procedure TQtAbstractScrollArea.MakeTextInteraction;
begin
  var
  Str := '';
  if NoTextInteraction in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.NoTextInteraction';
  if TextSelectableByMouse in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.TextSelectableByMouse';
  if TextSelectableByKeyboard in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.TextSelectableByKeyboard';
  if LinkAccessibleByMouse in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.LinkAccessibleByMouse';
  if LinkAcessibleByKeyboard in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.LinkAcessibleByKeyboard';
  if TextEditable in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.TextEditable';
  if TextEditorInteraction in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.TextEditorInteraction';
  if TextBrowserInteraction in FTextInteractionFlags then
    Str := Str + '|Qt.TextInteractionFlag.TextBrowserInteraction';
  if Str <> '' then
  begin
    Delete(Str, 1, 1);
    MakeAttribut('TextInteractionFlags', Str);
  end
  else
    Partner.DeleteAttribute('self.' + Name + '.setTextInteractionFlags');
end;

procedure TQtAbstractScrollArea.SetHorizontalScrollBarPolicy
  (Value: TScrollBarPolicy);
begin
  if Value <> FHorizontalScrollBarPolicy then
  begin
    FHorizontalScrollBarPolicy := Value;
    Invalidate;
  end;
end;

procedure TQtAbstractScrollArea.SetVerticalScrollBarPolicy
  (Value: TScrollBarPolicy);
begin
  if Value <> FVerticalScrollBarPolicy then
  begin
    FVerticalScrollBarPolicy := Value;
    Invalidate;
  end;
end;

{ --- TQtScrollArea ------------------------------------------------------------ }

constructor TQtScrollArea.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 113;
  Width := 120;
  Height := 80;
  FrameShadow := Sunken;
end;

function TQtScrollArea.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|WidgetResizable';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtScrollArea.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QScrollArea');
end;

{ --- TQtPlainTextEdit --------------------------------------------------------- }

constructor TQtPlainTextEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 73;
  Width := 120;
  Height := 80;
  LineWidth := 1;
  Cursor := crIBeam;
  FrameShape := StyledPanel;
  FrameShadow := Sunken;
  FUndoRedoEnabled := True;
  FLineWrapMode := WidgetWidth;
  FTabStopWidth := 80;
  FTabStopDistance := 80;
  FCursorWidth := 1;
  FPlainText := TStringList.Create;
end;

destructor TQtPlainTextEdit.Destroy;
begin
  FreeAndNil(FPlainText);
  inherited;
end;

function TQtPlainTextEdit.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|PlainText|PlaceholderText';
  if ShowAttributes >= 2 then
    Result := Result + '|LineWrapMode';
  if ShowAttributes = 3 then
    Result := Result + '|TabChangesFocus|UndoRedoEnabled|ReadOnly|DocumentTitle'
      + '|OverwriteMode|TabStopWidth|TabStopDistance|CursorWidth' +
      '|MaximumBlockCount|BackgroundVisible|CenterOnScroll' +
      '|TextInteractionFlags|WordWrapMode';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtPlainTextEdit.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'LineWrapMode' then
    MakeAttribut(Attr, 'QPlainTextEdit.LineWrapMode.' + Value)
  else if Attr = 'PlainText' then
    MakePlainText
  else if Attr = 'WordWrapMode' then
    MakeAttribut(Attr, 'QTextOption.WrapMode.' + Value)
  else
    inherited;
end;

function TQtPlainTextEdit.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|blockCountChanged|copyAvailable|cursorPositionChanged' +
    '|modificationChanged|redoAvailable|selectionChanged' +
    '|textChanged|undoAvailable|updateRequest';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtPlainTextEdit.HandlerInfo(const Event: string): string;
begin
  if Event = 'blockCountChanged' then
    Result := 'int;newBlockCount'
  else if Event = 'copyAvailable' then
    Result := 'bool;yes'
  else if Event = 'modificationChanged' then
    Result := 'bool;changed'
  else if (Event = 'redoAvailable') or (Event = 'undoAvailable') then
    Result := 'bool;available'
  else if Event = 'updateRequest' then
    Result := 'QRect, int;rect, dy'
  else
    Result := inherited;
end;

procedure TQtPlainTextEdit.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.centerCursor');
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.copy');
    Slots.Add(Name + '.cut');
    Slots.Add(Name + '.paste');
    Slots.Add(Name + '.redo');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.undo');
  end
  else if Parametertypes = 'QString' then
  begin
    Slots.Add(Name + '.appendHtml');
    Slots.Add(Name + '.appendPlainText');
    Slots.Add(Name + '.insertPlainText');
    Slots.Add(Name + '.setPlainText');
  end
  else if Parametertypes = 'int' then
  begin
    Slots.Add(Name + '.zoomIn');
    Slots.Add(Name + '.zoomOut');
  end;
  inherited;
end;

procedure TQtPlainTextEdit.MakePlainText;
begin
  MakeAttribut('PlainText', AsString(MyStringReplace(FPlainText.Text,
    sLineBreak, '\n')));
end;

procedure TQtPlainTextEdit.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QPlainTextEdit');
end;

procedure TQtPlainTextEdit.Paint;
var
  AWidth, AHeight, Format: Integer;
  StringList: TStringList;
  ARect: TRect;
begin
  inherited;
  ARect := InnerRect;
  ARect.Inflate(-HalfX, -HalfX);
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(ARect);
  StringList := TStringList.Create;
  Format := DT_LEFT;
  if FLineWrapMode = WidgetWidth then
  begin
    Format := Format + DT_WORDBREAK;
    WrapText(FPlainText.Text, ARect.Right - ARect.Left, AWidth, AHeight,
      StringList);
  end
  else
    CalculateText(FPlainText.Text, AWidth, AHeight, StringList);
  if StringList.Text <> CrLf then
    DrawText(Canvas.Handle, PChar(StringList.Text), Length(StringList.Text),
      ARect, Format);
  FreeAndNil(StringList);
end;

procedure TQtPlainTextEdit.SetTabChangesFocus(Value: Boolean);
begin
  if Value <> FTabChangesFocus then
  begin
    FTabChangesFocus := Value;
    Invalidate;
  end;
end;

procedure TQtPlainTextEdit.SetLineWrapMode(Value: TPlainTextLineWrapMode);
begin
  if Value <> FLineWrapMode then
  begin
    FLineWrapMode := Value;
    Invalidate;
  end;
end;

procedure TQtPlainTextEdit.SetPlainText(Value: TStrings);
begin
  if Value.Text <> FPlainText.Text then
  begin
    FPlainText.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtPlainTextEdit.SetPlaceholderText(const Value: string);
begin
  if Value <> FPlaceHolderText then
  begin
    FPlaceHolderText := Value;
    Invalidate;
  end;
end;

{ --- TQtTextEdit -------------------------------------------------------------- }

constructor TQtTextEdit.Create(Owner: TComponent);
var
  StringList: TStringList;
begin
  inherited Create(Owner);
  Tag := 101;
  Width := 120;
  Height := 80;
  FrameShape := StyledPanel;
  FrameShadow := Sunken;
  LineWidth := 1;
  FUndoRedoEnabled := True;
  FLineWrapMode := WidgetWidth;
  FHtml := TStringList.Create;
  StringList := TStringList.Create;
  StringList.Text := DefaultItems;
  var
  Str := '<ul>'#13#10;
  for var I := 0 to StringList.Count - 1 do
    Str := Str + '<li>' + StringList[I] + '</li>' + #13#10;
  FHtml.Text := Str + '</ul>'#13#10;
  FreeAndNil(StringList);
  FTabStopWidth := 80;
  FTabStopDistance := 80;
  FAcceptRichText := True;
  FCursorWidth := 1;
  Cursor := crIBeam;
end;

destructor TQtTextEdit.Destroy;
begin
  inherited;
  FreeAndNil(FHtml);
end;

function TQtTextEdit.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|AutoFormatting|DocumentTitle|UndoRedoEnabled|ReadOnly|Markdown' +
    '|Html|OverwriteMode|TabStopWidth|AcceptRichText|PlaceholderText';
  if ShowAttributes >= 2 then
    Result := Result + '|CursorWidth|TextInteractionFlags|TabStopDistance' +
      '|LineWrapColumnsOrWidth|LineWrapMode|TabChangesFocus|WordWrapMode';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTextEdit.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'LineWrapMode' then
    MakeAttribut(Attr, 'QTextEdit.' + Value)
  else if (Attr = 'AutoNone') or (Attr = 'AutoBulletList') or (Attr = 'AutoAll')
  then
    MakeAutoFormatting
  else if (Pos('Text', Attr) = 1) or (Pos('Link', Attr) = 1) or
    (Attr = 'NoTextInteraction') then
    MakeTextInteraction
  else if Attr = 'Html' then
    MakeHTML
  else if Attr = 'WordWrapMode' then
    MakeAttribut(Attr, 'QTextOption.WrapMode.' + Value)
  else
    inherited;
end;

function TQtTextEdit.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|copyAvailable|currentCharFormatChanged|cursorPositionChanged' +
    '|redoAvailable|selectionChanged|textChanged|undoAvailable';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtTextEdit.HandlerInfo(const Event: string): string;
begin
  if Event = 'copyAvailable' then
    Result := 'bool;yes'
  else if Event = 'currentCharFormatChanged' then
    Result := 'QTextCharFormat;f'
  else if (Event = 'redoAvailable') or (Event = 'undoAvailable') then
    Result := 'bool;available'
  else
    Result := inherited;
end;

procedure TQtTextEdit.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.clear(');
    Slots.Add(Name + '.copy');
    Slots.Add(Name + '.cut');
    Slots.Add(Name + '.paste');
    Slots.Add(Name + '.redo');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.undo(');
  end
  else if Parametertypes = 'QString' then
  begin
    Slots.Add(Name + '.append');
    Slots.Add(Name + '.insertHtml');
    Slots.Add(Name + '.insertPlainText');
    Slots.Add(Name + '.scrollToAnchor');
    Slots.Add(Name + '.setFontFamily');
    Slots.Add(Name + '.setHTML');
    Slots.Add(Name + '.setMarkdown');
    Slots.Add(Name + '.setPlainText');
    Slots.Add(Name + '.setText');
  end
  else if Parametertypes = 'QFont' then
    Slots.Add(Name + '.setCurrentFont')
  else if Parametertypes = 'bool' then
  begin
    Slots.Add(Name + '.setFontItalic');
    Slots.Add(Name + '.setFontUnderline');
  end
  else if Parametertypes = 'int' then
    Slots.Add(Name + '.setFontWeight')
  else if Parametertypes = 'QColor' then
  begin
    Slots.Add(Name + '.setTextBackgroundColor');
    Slots.Add(Name + '.setTextColor');
  end;
  inherited;
end;

procedure TQtTextEdit.MakeAutoFormatting;
begin
  var
  Str := '';
  if AutoNone in FAutoFormatting then
    Str := Str + '|QTextEdit.AutoNone';
  if AutoBulletList in FAutoFormatting then
    Str := Str + '|QTextEdit.AutoBulletList';
  if AutoAll in FAutoFormatting then
    Str := Str + '|QTextEdit.AutoAll';
  if Str <> '' then
  begin
    Delete(Str, 1, 1);
    MakeAttribut('AutoFormatting', Str);
  end
  else
    Partner.DeleteAttribute('self.' + Name + '.setAutoFormatting');
end;

procedure TQtTextEdit.MakeHTML;
begin
  MakeAttribut('Html', AsString(MyStringReplace(FHtml.Text, sLineBreak, '\n')));
end;

procedure TQtTextEdit.NewWidget(const Widget: string = '');
begin
  if Widget = '' then
  begin
    inherited NewWidget('QTextEdit');
    MakeHTML;
  end
  else
    inherited NewWidget('QTextBrowser');
end;

procedure TQtTextEdit.Paint;
var
  AWidth, AHeight, Format: Integer;
  StringList: TStringList;
  ARect: TRect;
begin
  inherited;
  ARect := InnerRect;
  ARect.Inflate(-HalfX, -HalfX);
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(ARect);
  StringList := TStringList.Create;
  Format := DT_LEFT;
  if FLineWrapMode = WidgetWidth then
  begin
    Format := Format + DT_WORDBREAK;
    WrapText(FHtml.Text, ARect.Right - ARect.Left, AWidth, AHeight, StringList);
  end
  else
    CalculateText(FHtml.Text, AWidth, AHeight, StringList);
  if StringList.Text <> CrLf then
    DrawText(Canvas.Handle, PChar(StringList.Text), Length(StringList.Text),
      ARect, Format);
  FreeAndNil(StringList);
end;

procedure TQtTextEdit.SetLineWrapMode(Value: TTextEditLineWrapMode);
begin
  if Value <> FLineWrapMode then
  begin
    FLineWrapMode := Value;
    Invalidate;
  end;
end;

procedure TQtTextEdit.SetHTML(Value: TStrings);
begin
  if Value.Text <> FHtml.Text then
  begin
    FHtml.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtTextEdit.SetPlaceholderText(const Value: string);
begin
  if Value <> FPlaceHolderText then
  begin
    FPlaceHolderText := Value;
    Invalidate;
  end;
end;

{ --- TQtTextBrowser ----------------------------------------------------------- }

constructor TQtTextBrowser.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 102;
  FrameShape := StyledPanel;
  FrameShadow := Sunken;
  LineWidth := 1;
  FOpenLinks := True;
  FSearchPaths := TStringList.Create;
  FSearchPaths.Text := '';
end;

destructor TQtTextBrowser.Destroy;
begin
  inherited;
  FreeAndNil(FSearchPaths);
end;

function TQtTextBrowser.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Source|SearchPaths|OpenExternalLinks|OpenLinks';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTextBrowser.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'SearchPaths' then
    MakeAttribut(Attr, GetSearchPaths)
  else if Attr = 'Source' then
    MakeAttribut(Attr, 'QUrl(' + AsString(Value) + ')')
  else
    inherited;
end;

function TQtTextBrowser.GetSearchPaths: string;
begin
  Result := '';
  for var I := 0 to FSearchPaths.Count - 1 do
    Result := Result + AsString(FSearchPaths[I]) + ', ';
  Delete(Result, Length(Result) - 1, 2);
  Result := '[' + Result + ']';
end;

function TQtTextBrowser.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|anchorClicked|backwardAvailable|forwardAvailable' +
    '|highlighted|historyChanged|sourceChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtTextBrowser.HandlerInfo(const Event: string): string;
begin
  if (Event = 'anchorClicked') or (Event = 'highlighted') then
    Result := 'QUrl;link'
  else if (Event = 'backwardAvailable') or (Event = 'forwardAvailable') then
    Result := 'bool;available'
  else if Event = 'sourceChanged' then
    Result := 'QUrl;src'
  else
    Result := inherited;
end;

procedure TQtTextBrowser.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.backward');
    Slots.Add(Name + '.forward');
    Slots.Add(Name + '.home');
    Slots.Add(Name + '.reload');
  end
  else if Parametertypes = 'QUrl, QTextDocument' then
    Slots.Add(Name + '.setSource');
  inherited;
end;

procedure TQtTextBrowser.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QTextBrowser');
end;

{ --- TQtGraphicsView ---------------------------------------------------------- }

constructor TQtGraphicsView.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 120;
  Width := 256;
  Height := 104;
  FrameShape := StyledPanel;
  FrameShadow := Sunken;
  LineWidth := 1;
  FInteractive := True;
  FRenderHints := [TextAntialiasing];
  FTransformationAnchor := AnchorViewCenter;
  FViewportUpdateMode := MinimalViewportUpdate;
  FRubberBandSelectionMode := IntersectsItemShape;
end;

function TQtGraphicsView.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|BackgroundColor|ForegroundColor|ForegroundStyle|BackgroundStyle|Interactive'
    + '|Alignment|RenderHints|DragMode|CacheMode|TransformationAnchor|SceneRect'
    + '|ResizeAnchor|ViewportUpdateMode|RubberBandSelectionMode|OptimizationFlags';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TQtGraphicsView.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|rubberBandChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtGraphicsView.HandlerInfo(const Event: string): string;
begin
  if Event = 'rubberBandChanged' then
    Result := 'QRect, QPointF, QPointF;rubberBandRect, fromScenePoint, toScenePoint'
  else
    Result := inherited;
end;

procedure TQtGraphicsView.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'QRect, QGraphicsScene' then
    Slots.Add(Name + '.invalidateScene')
  else if Parametertypes = 'QList' then
    Slots.Add(Name + '.updateScene')
  else if Parametertypes = 'QRectF' then
    Slots.Add(Name + '.updateSceneRect');
  inherited;
end;

procedure TQtGraphicsView.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'CacheMode' then
    MakeAttribut(Attr, 'QGraphicsView.CacheModeFlag.' + Value)
  else if (Attr = 'ViewportUpdateMode') or (Attr = 'DragMode') then
    MakeAttribut(Attr, 'QGraphicsView.' + Attr + '.' + Value)
  else if (Attr = 'ResizeAnchor') or (Attr = 'TransformationAnchor') then
    MakeAttribut(Attr, 'QGraphicsView.ViewportAnchor.' + Value)
  else if Attr = 'RubberBandSelectionMode' then
    MakeAttribut(Attr, 'Qt.ItemSelectionMode.' + Value)
  else if (Pos('Antialiasing', Attr) > 0) or (Attr = 'SmoothPixmapTransform') or
    (Attr = 'LosslessImageRendering') then
    MakeRenderHints
  else if Pos('Dont', Attr) = 1 then
    MakeOptimizationFlags
  else if (Attr = 'ForegroundColor') or (Attr = 'BackgroundColor') or
    (Attr = 'ForegroundStyle') or (Attr = 'BackgroundStyle') then
    MakeColorAndStyle(Attr)
  else
    inherited;
end;

procedure TQtGraphicsView.MakeRenderHints;
begin
  var
  Str := '';
  if Antialiasing in FRenderHints then
    Str := Str + '|QPainter.Antialiasing';
  if TextAntialiasing in FRenderHints then
    Str := Str + '|QPainter.TextAntialiasing';
  if SmoothPixmapTransform in FRenderHints then
    Str := Str + '|QPainter.SmoothPixmapTransform';
  { if VerticalSubpixelPositioning in FRenderHints then
    s:= s + '|QPainter.VerticalSubpixelPositioning';
  }
  if LosslessImageRendering in FRenderHints then
    Str := Str + '|QPainter.LosslessImageRendering';
  if Str <> '' then
  begin
    Delete(Str, 1, 1);
    MakeAttribut('RenderHints', Str);
  end
  else
    Partner.DeleteAttribute('self.' + Name + '.setRenderHints');
end;

procedure TQtGraphicsView.MakeOptimizationFlags;
begin
  var
  Str := '';
  if DontSavePainterState in FOptimizationFlags then
    Str := Str + '|QGraphicsView.DontSavePainterState';
  if DontAdjustForAntialiasing in FOptimizationFlags then
    Str := Str + '|QGraphicsView.DontAdjustForAntialiasing';
  if DontClipPainter in FOptimizationFlags then
    Str := Str + '|QGraphicsView.DontClipPainter';
  if Str <> '' then
  begin
    Delete(Str, 1, 1);
    MakeAttribut('OptimizationFlags', Str);
  end
  else
    Partner.DeleteAttribute('self.' + Name + '.setOptimizationFlags');
end;

procedure TQtGraphicsView.MakeColorAndStyle(Attr: string);
var
  Red, Green, Blue: Integer;
  Color, Style: string;
begin
  if Pos('Foreground', Attr) = 1 then
  begin
    Color2RGB(FForegroundColor, Red, Green, Blue);
    Style := 'Qt.BrushStyle.' + EnumToString(FForegroundStyle);
    Attr := 'Foreground';
  end
  else
  begin
    Color2RGB(FBackgroundColor, Red, Green, Blue);
    Style := 'Qt.BrushStyle.' + EnumToString(FBackgroundStyle);
    Attr := 'Background';
  end;
  Color := 'QColor(' + IntToStr(Red) + ', ' + IntToStr(Green) + ', ' +
    IntToStr(Blue) + ', 255)';
  MakeAttribut(Attr + 'Brush', 'QBrush(' + Color + ', ' + Style + ')');
end;

procedure TQtGraphicsView.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QGraphicsView');
end;

procedure TQtGraphicsView.Paint;
begin
  inherited;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(InnerRect);
end;

{ --- TQtAbstractSlider -------------------------------------------------------- }

function TQtAbstractSlider.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Minimum|Maximum|Value|Orientation';
  if ShowAttributes >= 2 then
    Result := Result + '|SingleStep|PageStep|SliderPosition|Tracking' +
      '|InvertedAppearance|InvertedControls';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtAbstractSlider.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Orientation' then
    MakeAttribut(Attr, 'Qt.Orientation.' + Value)
  else
    inherited;
end;

function TQtAbstractSlider.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|actionTriggered|rangeChanged|sliderMoved|sliderPressed' +
    '|sliderReleased|valueChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtAbstractSlider.HandlerInfo(const Event: string): string;
begin
  if Event = 'actionTriggered' then
    Result := 'int;action'
  else if Event = 'rangeChanged' then
    Result := 'int, int;min, max'
  else if (Event = 'sliderMoved') or (Event = 'valueChanged') then
    Result := 'int;value'
  else
    Result := inherited;
end;

procedure TQtAbstractSlider.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'Orientation' then
    Slots.Add(Name + '.setOrientation')
  else if Parametertypes = 'int, int' then
    Slots.Add(Name + '.setTange')
  else if Parametertypes = 'int' then
    Slots.Add(Name + '.setValue');
  inherited;
end;

procedure TQtAbstractSlider.SetOrientation(Value: TOrientation);
var
  Tmp: Integer;
begin
  if Value <> FOrientation then
  begin
    FOrientation := Value;
    if not(csLoading in ComponentState) then
    begin
      Tmp := Width;
      Width := Height;
      Height := Tmp;
      SetPositionAndSize;
    end;
    Invalidate;
  end;
end;

procedure TQtAbstractSlider.SetValue(Value: Integer);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSlider.SetInvertedAppearance(Value: Boolean);
begin
  if Value <> FInvertedAppearance then
  begin
    FInvertedAppearance := Value;
    Invalidate;
  end;
end;

{ --- TQtScrollBar ------------------------------------------------------------- }

constructor TQtScrollBar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 80;
  Width := 120;
  Height := 16;
  FMaximum := 99;
  FSingleStep := 1;
  FPageStep := 10;
  FTracking := True;
  FOrientation := Horizontal;
  FInvertedControls := True;
end;

procedure TQtScrollBar.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QScrollBar');
  InsertValue('self.' + Name + '.setOrientation(Qt.Orientation.Horizontal)');
end;

procedure TQtScrollBar.Paint;
begin
  PaintScrollbar(ClientRect, FOrientation = Horizontal);
end;

{ --- TQtSlider ---------------------------------------------------------------- }

constructor TQtSlider.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 84;
  Width := 120;
  Height := 24;
  FMaximum := 99;
  FSingleStep := 1;
  FPageStep := 10;
  FTracking := True;
  FOrientation := Horizontal;
  FInvertedControls := True;
end;

procedure TQtSlider.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'TickPosition' then
    MakeAttribut(Attr, 'QSlider.TickPosition.' + Value)
  else
    inherited;
end;

function TQtSlider.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|TickPosition|TickInterval';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtSlider.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QSlider');
  InsertValue('self.' + Name + '.setOrientation(Qt.Orientation.Horizontal)');
end;

procedure TQtSlider.Paint;

type
  TArrayOfPoint = array of TPoint;

var
  ARect: TRect;
  TickInc: Double;
  XPos, YPos, Range, SliderWidth, SliderHeight, UsablePixels, Tick1, Tick2,
    TickCount: Integer;
  Arr: TArrayOfPoint;

  function RectToArrow: TArrayOfPoint;
  var
    Arr: TArrayOfPoint;
    TickPos: TTickPosition;
  begin
    TickPos := FTickPosition;
    if FOrientation = Horizontal then
    begin
      if TickPos = TicksRight then
        TickPos := TicksBelow
      else if TickPos = TicksLeft then
        TickPos := TicksAbove;
    end
    else
    begin
      if TickPos = TicksAbove then
        TickPos := TicksLeft
      else if TickPos = TicksBelow then
        TickPos := TicksRight;
    end;
    SetLength(Arr, 5);
    case TickPos of
      NoTicks, TicksBothSides:
        begin
          Arr[0] := Point(ARect.Left, ARect.Top);
          Arr[1] := Point(ARect.Right, ARect.Top);
          Arr[2] := Point(ARect.Right, ARect.Bottom);
          Arr[3] := Point(ARect.Left, ARect.Bottom);
          SetLength(Arr, 4);
        end;
      TicksAbove:
        begin
          Arr[0] := Point(ARect.Left, ARect.Top + 5);
          Arr[1] := Point(ARect.Left + 5, ARect.Top);
          Arr[2] := Point(ARect.Right, ARect.Top + 5);
          Arr[3] := Point(ARect.Right, ARect.Bottom);
          Arr[4] := Point(ARect.Left, ARect.Bottom);
        end;
      TicksLeft:
        begin
          Arr[0] := Point(ARect.Left + 5, ARect.Bottom);
          Arr[1] := Point(ARect.Left, ARect.Top + 5);
          Arr[2] := Point(ARect.Left + 5, ARect.Top);
          Arr[3] := Point(ARect.Right, ARect.Top);
          Arr[4] := Point(ARect.Right, ARect.Bottom);
        end;
      TicksBelow:
        begin
          Arr[0] := Point(ARect.Right, ARect.Bottom - 5);
          Arr[1] := Point(ARect.Right - 5, ARect.Bottom);
          Arr[2] := Point(ARect.Left, ARect.Bottom - 5);
          Arr[3] := Point(ARect.Left, ARect.Top);
          Arr[4] := Point(ARect.Right, ARect.Top);
        end;
      TicksRight:
        begin
          Arr[0] := Point(ARect.Right - 5, ARect.Top);
          Arr[1] := Point(ARect.Right, ARect.Top + 5);
          Arr[2] := Point(ARect.Right - 5, ARect.Bottom);
          Arr[3] := Point(ARect.Left, ARect.Bottom);
          Arr[4] := Point(ARect.Left, ARect.Top);
        end;
    end;
    Result := Arr;
  end;

begin
  inherited;
  Canvas.Brush.Color := $EAEAE7;
  Canvas.Pen.Color := $D6D6D6;
  Tick2 := 0;

  // track
  if FOrientation = Horizontal then
  begin
    ARect.Left := 1;
    ARect.Right := Width - 1;
    if FTickPosition in [NoTicks, TicksBothSides] then
    begin
      ARect.Top := Height div 2 - 1;
      Tick1 := Round(Height / 4.0);
      Tick2 := Round(3 * Height / 4.0);
    end
    else if FTickPosition in [TicksRight, TicksBelow] then
    begin
      ARect.Top := Round(Height / 3.0) - 1;
      Tick1 := Round(2.0 * Height / 3.0);
    end
    else
    begin
      ARect.Top := Round(2.0 * Height / 3.0) - 1;
      Tick1 := Round(Height / 3.0);
    end;
    ARect.Bottom := ARect.Top + 3;
    if FTickPosition = NoTicks then
      SliderHeight := Height
    else
      SliderHeight := 2 * (Round(Height / 4.0) - 2);
    SliderWidth := PPIScale(10);
    UsablePixels := Width - 2 - SliderWidth;
  end
  else
  begin
    ARect.Top := 1;
    ARect.Bottom := Height - 1;
    if FTickPosition in [NoTicks, TicksBothSides] then
    begin
      ARect.Left := Width div 2 - 1;
      Tick1 := Round(Width / 4.0);
      Tick2 := Round(3 * Width / 4.0);
    end
    else if FTickPosition in [TicksRight, TicksBelow] then
    begin
      ARect.Left := Round(Width / 3.0) - 1;
      Tick1 := Round(2.0 * Width / 3.0);
    end
    else
    begin
      ARect.Left := Round(2.0 * Width / 3.0) - 1;
      Tick1 := Round(Width / 3.0);
    end;
    ARect.Right := ARect.Left + 3;
    if FTickPosition = NoTicks then
      SliderWidth := Width
    else
      SliderWidth := 2 * (Round(Width / 4.0) - 2);
    SliderHeight := PPIScale(10);
    UsablePixels := Height - 2 - SliderHeight;
  end;
  Canvas.Rectangle(ARect);

  // ticks
  if FTickPosition <> NoTicks then
  begin
    Canvas.Pen.Color := $94A2A5;
    if FTickInterval = 0 then
      TickInc := (FMaximum - FMinimum) / 10.0
    else
      TickInc := (FMaximum - FMinimum) / FTickInterval;
    TickCount := Round((FMaximum - FMinimum) / TickInc);
    if FOrientation = Horizontal then
      for var I := 0 to TickCount do
      begin
        XPos := Round(UsablePixels * (FMinimum + I * TickInc) /
          (FMaximum - FMinimum) + TickInc / 2 + 1);
        Canvas.MoveTo(XPos, Tick1 - 2);
        Canvas.LineTo(XPos, Tick1 + 2);
        if FTickPosition = TicksBothSides then
        begin
          Canvas.MoveTo(XPos, Tick2 - 2);
          Canvas.LineTo(XPos, Tick2 + 2);
        end;
      end
    else
      for var I := 0 to TickCount do
      begin
        YPos := Round(UsablePixels * (FMinimum + I * TickInc) /
          (FMaximum - FMinimum) + TickInc / 2 + 1);
        Canvas.MoveTo(Tick1 - 2, YPos);
        Canvas.LineTo(Tick1 + 2, YPos);
        if FTickPosition = TicksBothSides then
        begin
          Canvas.MoveTo(Tick2 - 2, YPos);
          Canvas.LineTo(Tick2 + 2, YPos);
        end;
      end;
  end;

  // slider
  if FInvertedAppearance and (FOrientation = Horizontal) or
    not FInvertedAppearance and (FOrientation = Vertical) then
    Range := Round(UsablePixels * (FMaximum - FValue) /
      (FMaximum - FMinimum)) + 1
  else
    Range := Round(UsablePixels * (FValue - FMinimum) /
      (FMaximum - FMinimum)) + 1;
  if FOrientation = Horizontal then
  begin
    XPos := Round(Range);
    YPos := ARect.Top + 1 - SliderHeight div 2;
    ARect := Rect(XPos, YPos, XPos + SliderWidth, YPos + SliderHeight);
  end
  else
  begin
    XPos := ARect.Left + 1 - SliderWidth div 2;
    YPos := Round(Range);
    ARect := Rect(XPos, YPos, XPos + SliderWidth, YPos + SliderHeight);
  end;
  Canvas.Pen.Color := $D97A00;
  Canvas.Brush.Color := $D97A00;
  Arr := RectToArrow;
  Canvas.Polygon(Arr);
  SetLength(Arr, 0);
end;

procedure TQtSlider.SetTickPosition(Value: TTickPosition);
begin
  if Value <> FTickPosition then
  begin
    FTickPosition := Value;
    Invalidate;
  end;
end;

procedure TQtSlider.SetTickInterval(Value: Integer);
begin
  if Value <> FTickInterval then
  begin
    FTickInterval := Value;
    Invalidate;
  end;
end;

{ --- TQtDial ------------------------------------------------------------------ }

constructor TQtDial.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 111;
  Width := 64;
  Height := 64;
  FMaximum := 99;
  FSingleStep := 1;
  FPageStep := 10;
  FTracking := True;
  FNotchTarget := 3.7;
end;

function TQtDial.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Wrapping|NotchTarget|NotchesVisible';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtDial.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then
  begin
    Slots.Add(Name + '.setNotchesVisible');
    Slots.Add(Name + '.setWrapping');
  end;
  inherited;
end;

procedure TQtDial.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QDial');
end;

procedure TQtDial.Paint;
var
  Radius, Radius1, Radius2, Count, Size, WholeArc, PageStepArc, SingleStepArc,
    SingleStepPerNotchTarget, StartAngle, EndAngle, Angle, MidX, MidY: Integer;
  ValueAngle: Double;
  ARect: TRect;
  Center: TPoint;
begin
  // big circle
  Canvas.Brush.Color := $F5F5F5;
  Canvas.Pen.Color := $606060;
  ARect := InnerRect;
  Center := ARect.CenterPoint;
  Size := Min(Width, Height) div 2;
  Radius := Round(0.82 * Size);
  Canvas.Ellipse(Center.X - Radius, Center.Y - Radius, Center.X + Radius,
    Center.Y + Radius);

  if FWrapping then
  begin
    StartAngle := 0;
    EndAngle := 360;
  end
  else
  begin
    StartAngle := -60;
    EndAngle := 240;
  end;

  // show notches
  if FNotchesVisible then
  begin
    WholeArc := Round(0.5 + 2 * System.Pi * Radius);
    if not FWrapping then
      WholeArc := Round(0.5 + 5 / 6 * 2 * System.Pi * Radius);
    if Maximum > Minimum + PageStep then
      PageStepArc := Round(0.5 + WholeArc * (PageStep / (Maximum - Minimum)))
    else
      PageStepArc := Round(0.5 + WholeArc);
    if PageStepArc <> 0 then
      SingleStepArc := Round(0.5 + PageStepArc * SingleStep / PageStep)
    else
      SingleStepArc := Round(0.5 + PageStepArc * SingleStep);
    if SingleStepArc < 1 then
      SingleStepArc := 1;
    SingleStepPerNotchTarget := Round(0.5 + NotchTarget / SingleStepArc);
    if SingleStepPerNotchTarget < 1 then
      SingleStepPerNotchTarget := 1;
    Radius1 := Round(0.9 * Size);
    Radius2 := Round(1.0 * Size);
    Angle := StartAngle;
    Count := 0;

    while Angle <= EndAngle do
    begin
      if Count = 0 then
      begin
        Canvas.MoveTo(Center.X - Round(Radius * Cos(Angle * Pi / 180)),
          Center.Y - Round(Radius * Sin(Angle * Pi / 180)));
        Count := Round(PageStep / SingleStep);
      end
      else
        Canvas.MoveTo(Center.X - Round(Radius1 * Cos(Angle * Pi / 180)),
          Center.Y - Round(Radius1 * Sin(Angle * Pi / 180)));
      Canvas.LineTo(Center.X - Round(Radius2 * Cos(Angle * Pi / 180)),
        Center.Y - Round(Radius2 * Sin(Angle * Pi / 180)));
      Angle := Angle + SingleStepPerNotchTarget;
      Count := Count - 1;
    end;
  end;

  // small value circle
  ValueAngle := StartAngle + Value / (Maximum - Minimum) *
    (EndAngle - StartAngle);
  if FWrapping then
    ValueAngle := ValueAngle - 90;

  Radius1 := Round(0.6 * Size);
  Radius2 := Round((0.78 - 0.65) * Size);
  MidX := Center.X - Round(Radius1 * Cos(ValueAngle * Pi / 180));
  MidY := Center.Y - Round(Radius1 * Sin(ValueAngle * Pi / 180));
  Canvas.Ellipse(MidX - Radius2, MidY - Radius2, MidX + Radius2,
    MidY + Radius2);
end;

procedure TQtDial.SetWrapping(Value: Boolean);
begin
  if Value <> FWrapping then
  begin
    FWrapping := Value;
    Invalidate;
  end;
end;

procedure TQtDial.SetNotchTarget(Value: Double);
begin
  if Value <> FNotchTarget then
  begin
    FNotchTarget := Value;
    Invalidate;
  end;
end;

procedure TQtDial.SetNotchesVisible(Value: Boolean);
begin
  if Value <> FNotchesVisible then
  begin
    FNotchesVisible := Value;
    Invalidate;
  end;
end;

end.
