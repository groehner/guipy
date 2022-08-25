{-------------------------------------------------------------------------------
 Unit:     UQtItemViews
 Author:   Gerhard Röhner
 Date:     July 2022
 Purpose:  PyQt item view widgets
-------------------------------------------------------------------------------}

unit UQtItemViews;

{ classes
    TQtAbstractItemView
      TQtListView
        TQtListWidget
      TQtColumnView
      TQtTreeView
        TQtTreeWidget
      TQtTableView
        TQtTableWidget
}

interface

uses
  Windows, Messages, Controls, Graphics, Classes,
  UBaseQtWidgets, UQtScrollable, UQtFrameBased;

type

  TDragDropMode = (NoDragDrop, DragOnly, DropOnly, DragDrop,
                   InternalMove);

  TDefaultDropAction = (CopyAction, MoveAction, LinkAction,
                        ActionMask, TargetMoveAction, IgnoreAction);

  TSelectionMode = (NoSelection, SingleSelection, MultiSelection,
                    ExtendedSelection, ContiguousSelection);

  TSelectionBehavior = (SelectItems, SelectRows, SelectColumns);

  TTextElideMode = (ElideLeft, ElideRight, ElideMiddle, ElideNone);

  TScrollMode = (ScrollPerItem, SCrollPerPixel);

  TMovement = (Static, Free, Snap);

  TFlow = (TopToBottom, LeftToRight);

  TResizeMode = (Fixed, Adjust);

  TLayoutMode = (SinglePass, Batched);

  TViewMode = (ListMode, IconMode);

  TGridStyle = (NoPen, SolidLine, DashLine, DotLine, DashDotLine,
                DashDotDotLine, CustomDashLine);

  TQtAbstractItemView = class(TQtAbstractScrollArea)
  private
    FAutoScroll: boolean;
    FAutoScrollMargin: integer;
    // editTriggers
    FTabKeyNavigation: boolean;
    FShowDropIndicator: boolean;
    FDragEnabled: boolean;
    FDragDropOverwriteMode: boolean;
    FDragDropMode: TDragDropMode;
    FDefaultDropAction: TDefaultDropAction;
    FAlternatingRowColors: boolean;
    FSelectionMode: TSelectionMode;
    FSelectionBehavior: TSelectionBehavior;
    // IconSize
    FTextElideMode: TTextElideMode;
    FVerticalScrollMode: TScrollMode;
    FHorizontalScrollMode: TScrollMode;
    FActivated: string;
    FClicked: string;
    FDoubleClicked: string;
    FEntered: string;
    FIconSizeChanged: string;
    FPressed: string;
    FViewportEntered: string;
    procedure setAlternatingRowColors(Value: boolean);
  public
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
  published
    property AutoScroll: boolean read FAutoScroll write FAutoScroll;
    property AutoScrollMargin: integer read FAutoScrollMargin write FAutoScrollMargin;
    // editTriggers
    property TabKeyNavigation: boolean read FTabKeyNavigation write FTabKeyNavigation;
    property ShowDropIndicator: boolean read FShowDropIndicator write FShowDropIndicator;
    property DragEnabled: boolean read FDragEnabled write FDragEnabled;
    property DragDropOverwriteMode: boolean read FDragDropOverwriteMode write FDragDropOverwriteMode;
    property DragDropMode: TDragDropMode read FDragDropMode write FDragDropMode;
    property DefaultDropAction: TDefaultDropAction read FDefaultDropAction write FDefaultDropAction;
    property AlternatingRowColors: boolean read FAlternatingRowColors write setAlternatingRowColors;
    property SelectionMode: TSelectionMode read FSelectionMode write FSelectionMode;
    property SelectionBehavior: TSelectionBehavior read FSelectionBehavior write FSelectionBehavior;
    // IconSize
    property TextElideMode: TTextElideMode read FTextElideMode write FTextElideMode;
    property VerticalScrollMode: TScrollMode read FVerticalScrollMode write FVerticalScrollMode;
    property HorizontalScrollMode: TScrollMode read FHorizontalScrollMode write FHorizontalScrollMode;
    // signas
    property activated: string read FActivated write FActivated;
    property clicked: string read FClicked write FClicked;
    property doubleClicked: string read FDoubleClicked write FDoubleClicked;
    property entered: string read FEntered write FEntered;
    property iconSizeChanged: string read FIconSizeChanged write FIconSizeChanged;
    property pressed: string read FPressed write FPressed;
    property viewportEntered: string read FViewportEntered write FViewportEntered;
  end;

  TQtListView = class(TQtAbstractItemView)
  private
    FMovement: TMovement;
    FFlow: TFlow;
    FIsWrapping: boolean;
    FResizeMode: TResizeMode;
    FLayoutMode: TLayoutMode;
    FSpacing: integer;
    // FGridSize
    FViewMode: TViewMode;
    FModelColumn: integer;
    FUninformItemsSizes: boolean;
    FBatchSize: integer;
    FWordWrap: boolean;
    FSelectionRectVisible: boolean;
    FItemAlignment: TAlignmentHorizontal;
    FIndexesMoved: string;
    procedure setFlow(Value: TFlow);
    procedure setSpacing(Value: integer);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property Movement: TMovement read FMovement write FMovement;
    property Flow: TFlow read FFlow write setFlow;
    property IsWrapping: boolean read FIsWrapping write FIsWrapping;
    property ResizeMode: TResizeMode read FResizeMode write FResizeMode;
    property LayoutMode: TLayoutMode read FLayoutMode write FLayoutMode;
    property Spacing: integer read FSpacing write setSpacing;
    // FGridSize
    property ViewMode: TViewMode read FViewMode write FViewMode;
    property ModelColumn: integer read FModelColumn write FModelColumn;
    property UninformItemsSizes: boolean read FUninformItemsSizes write FUninformItemsSizes;
    property BatchSize: integer read FBatchSize write FBatchSize;
    property WordWrap: boolean read FWordWrap write FWordWrap;
    property SelectionRectVisible: boolean read FSelectionRectVisible write FSelectionRectVisible;
    property ItemAlignment: TAlignmentHorizontal read FItemAlignment write FItemAlignment;
    // signals
    property indexesMoved: string read FIndexesMoved write FIndexesMoved;
  end;

  TQtListWidget = class(TQtListView)
  private
    FCurrentRow: integer;
    FSortingEnabled: boolean;
    FItems: TStrings;
    FCurrentItemChanged: string;
    FCurrentRowChanged: string;
    FCurrentTextChanged: string;
    FItemActivated: string;
    FItemChanged: string;
    FItemClicked: string;
    FItemDoubleClicked: string;
    FItemEntered: string;
    FItemPressed: string;
    FItemSelectionChanged: string;
    procedure setItems(Values: TStrings);
    function getItems: String;
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
    property CurrentRow: integer read FCurrentRow write FCurrentRow;
    property SortingEnabled: boolean read FSortingEnabled write FSortingEnabled;
    property Items: TStrings read FItems write setItems;

    // signals
    property currentItemChanged: string read FCurrentItemChanged write FCurrentItemChanged;
    property currentRowChanged: string read FCurrentRowChanged write FCurrentRowChanged;
    property currentTextChanged: string read FCurrentTextChanged write FCurrentTextChanged;
    property itemActivated: string read FItemActivated write FItemActivated;
    property itemChanged: string read FItemChanged write FItemChanged;
    property itemClicked: string read FItemClicked write FItemClicked;
    property itemDoubleClicked: string read FItemDoubleClicked write FItemDoubleClicked;
    property itemEntered: string read FItemEntered write FItemEntered;
    property itemPressed: string read FItemPressed write FItemPressed;
    property itemSelectionChanged: string read FItemSelectionChanged write FItemSelectionChanged;
  end;

  TQtColumnView = class(TQtAbstractItemView)
  private
    FResizeGripsVisible: boolean;
    FItems: TStrings;
    FUpdatePreviewWidget: string;
    procedure setResizeGripsVisible(Value: boolean);
    procedure setItems(Value: TStrings);
    procedure MakeItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure DeleteWidget; override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    function InnerRect: TRect; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property ResizeGripsVisible: boolean
             read FResizeGripsVisible write setResizeGripsVisible;
    property Items: TStrings read FItems write setItems;
    property UpdatePreviewWidget: string read FUpdatePreviewWidget write FUpdatePreviewWidget;
  end;

  TQtTreeView = class(TQtAbstractItemView)
  private
    FAutoExpandDelay: integer;
    FIndentation: integer;
    FRootIsDecorated: boolean;
    FUniformRowHeights: boolean;
    FItemsExpandable: boolean;
    FSortingEnabled: boolean;
    FAnimated: boolean;
    FAllColumnsShowFocus: boolean;
    FWordWrap: boolean;
    FHeaderHidden: boolean;
    FExpandsOnDoubleClick: boolean;
    FColumnWidth: integer;
    FCollapsed: string;
    FExpanded: string;
    procedure setIndentation(Value: integer);
    procedure setColumnWidth(Value: integer);
    procedure setHeaderHidden(Value: boolean);
    procedure MakeColumWidth(Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property AutoExpandDelay: integer read FAutoExpandDelay write FAutoExpandDelay;
    property Indentation: integer read FIndentation write setIndentation;
    property RootIsDecorated: boolean read FRootIsDecorated write FRootIsDecorated;
    property UniformRowHeights: boolean read FUniformRowHeights write FUniformRowHeights;
    property ItemsExpandable: boolean read FItemsExpandable write FItemsExpandable;
    property SortingEnabled: boolean read FSortingEnabled write FSortingEnabled;
    property Animated: boolean read FAnimated write FAnimated;
    property AllColumnsShowFocus: boolean read FAllColumnsShowFocus write FAllColumnsShowFocus;
    property WordWrap: boolean read FWordWrap write FWordWrap;
    property HeaderHidden: boolean read FHeaderHidden write setHeaderHidden;
    property ExpandsOnDoubleClick: boolean read FExpandsOnDoubleClick write FExpandsOnDoubleClick;
    property ColumnWidth: integer read FColumnWidth write setColumnWidth;
    // signals
    property collapsed: string read FCollapsed write FCollapsed;
    property expanded: string read FExpanded write FExpanded;
  end;

  TQtTreeWidget = class(TQtTreeView)
  private
    FItems: TStrings;
    FHeader: TStrings;
    FColumnCount: integer;
    FCurrentItemChanged: string;
    FItemActivated: string;
    FItemChanged: string;
    FItemClicked: string;
    FItemCollapsed: string;
    FItemDoubleClicked: string;
    FItemEntered: string;
    FItemExpanded: string;
    FItemPressed: string;
    FItemSelectionChanged: string;
    procedure setColumnCount(Value: integer);
    procedure setItems(Value: TStrings);
    procedure setHeader(Value: TStrings);
    procedure MakeItems;
    procedure MakeHeader;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure DeleteWidget; override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property Header: TStrings read FHeader write setHeader;
    property Items: TStrings read FItems write setItems;
    property ColumnCount: integer read FColumnCount write setColumnCount;
    // signals
    property currentItemChanged: string read FCurrentItemChanged write FCurrentItemChanged;
    property itemActivated: string read FItemActivated write FItemActivated;
    property itemChanged: string read FItemChanged write FItemChanged;
    property itemClicked: string read FItemClicked write FItemClicked;
    property itemCollapsed: string read FItemCollapsed write FItemCollapsed;
    property itemDoubleClicked: string read FItemDoubleClicked write FItemDoubleClicked;
    property itemEntered: string read FItemEntered write FItemEntered;
    property itemExpanded: string read FItemExpanded write FItemExpanded;
    property itemPressed: string read FItemPressed write FItemPressed;
    property itemSelectionChanged: string read FItemSelectionChanged write FItemSelectionChanged;
  end;

  TQtTableView = Class(TQtAbstractItemView)
  private
    FShowGrid: boolean;
    FGridStyle: TGridStyle;
    FSortingEnabled: boolean;
    FWordWrap: boolean;
    FCornerButtonEnabled: boolean;
    FHeaderHorzVisible: boolean;
    FHeaderVertVisible: boolean;
    FColumnWidth: integer;
    FRowHeight: integer;
    procedure setHeaderHorzVisible(Value: boolean);
    procedure setHeaderVertVisible(Value: boolean);
    procedure setColumnWidth(Value: integer);
    procedure setRowHeight(Value: integer);
    procedure setShowGrid(Value: boolean);
    procedure setGridStyle(Value: TGridStyle);
    procedure MakeHeaderVisible(Attr, Value: string);
    procedure MakeColumWidth(Value: string);
    procedure MakeRowHeight(Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property ShowGrid: boolean read FShowGrid write setShowGrid;
    property GridStyle: TGridStyle read FGridStyle write setGridStyle;
    property SortingEnabled: boolean read FSortingEnabled write FSortingEnabled;
    property WordWrap: boolean read FWordWrap write FWordWrap;
    property CornerButtonEnabled: boolean read FCornerButtonEnabled write FCornerButtonEnabled;
    property HeaderHorzVisible: boolean read FHeaderHorzVisible write setHeaderHorzVisible;
    property HeaderVertVisible: boolean read FHeaderVertVisible write setHeaderVertVisible;
    property ColumnWidth: integer read FColumnWidth write setColumnWidth;
    property RowHeight: integer read FRowHeight write setRowHeight;
  end;

  TQtTableWidget = Class(TQtTableView)
  private
    FRowCount: integer;
    FColumnCount: integer;
    FItems: TStrings;
    FHeaderHorz: TStrings;
    FHeaderVert: TStrings;
    FCellActivated: string;
    FCellChanged: string;
    FCellClicked: string;
    FCellDoubleClicked: string;
    FCellEntered: string;
    FCellPressed: string;
    FCurrentCellChanged: string;
    FCurrentItemChanged: string;
    FItemActivated: string;
    FItemChanged: string;
    FItemClicked: string;
    FItemDoubleClicked: string;
    FItemEntered: string;
    FItemPressed: string;
    FItemSelectionChanged: string;
    procedure setRowCount(Value: integer);
    procedure setColumnCount(Value: integer);
    procedure setItems(Value: TStrings);
    procedure setHeaderHorz(Value: TStrings);
    procedure setHeaderVert(Value: TStrings);
    procedure MakeVerticalHeader;
    procedure MakeHorizontalHeader;
    procedure MakeItems;
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
    property RowCount: integer read FRowCount write setRowCount;
    property ColumnCount: integer read FColumnCount write setColumnCount;
    property Items: TStrings read FItems write setItems;
    property HeaderHorz: TStrings read FHeaderHorz write setHeaderHorz;
    property HeaderVert: TStrings read FHeaderVert write setHeaderVert;
    // signals
    property cellActivated: string read FCellActivated write FCellActivated;
    property cellChanged: string read FCellChanged write FCellChanged;
    property cellClicked: string read FCellClicked write FCellClicked;
    property cellDoubleClicked: string read FCellDoubleClicked write FCellDoubleClicked;
    property cellEntered: string read FCellEntered write FCellEntered;
    property cellPressed: string read FCellPressed write FCellPressed;
    property currentCellChanged: string read FCurrentCellChanged write FCurrentCellChanged;
    property currentItemChanged: string read FCurrentItemChanged write FCurrentItemChanged;
    property itemActivated: string read FItemActivated write FItemActivated;
    property itemChanged: string read FItemChanged write FItemChanged;
    property itemClicked: string read FItemClicked write FItemClicked;
    property itemDoubleClicked: string read FItemDoubleClicked write FItemDoubleClicked;
    property itemEntered: string read FItemEntered write FItemEntered;
    property itemPressed: string read FItemPressed write FItemPressed;
    property itemSelectionChanged: string read FItemSelectionChanged write FItemSelectionChanged;
  end;



implementation

uses SysUtils, Types, UITypes, Math, UUtils;

{--- TQtAbstractItemView ------------------------------------------------------}

procedure TQtAbstractItemView.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'DragDropMode') or (Attr = 'SelectionMode') or
     (Attr = 'SelectionBehavior') then
    MakeAttribut(Attr, 'QAbstractItemView.' + Attr + '.' + Value)
  else if (Attr = 'VerticalScrollMode') or (Attr = 'HorizontalScrollMode') then
    MakeAttribut(Attr, 'QAbstractItemView.ScrollMode.' + Value)
  else if Attr = 'TextElideMode' then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if Attr = 'DefaultDropAction' then
    MakeAttribut(Attr, 'Qt.dropAction.' + Value)
  else
    inherited;
end;

function TQtAbstractItemView.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|AlternatingRowColors';
  if ShowAttributes = 3 then
    Result:= Result + '|AutoScroll|AutoScrollMargin|TabKeyNavigation' +
                      '|ShowDropIndicator|DragEnabled|DragDropOverwriteMode' +
                      '|DragDropMode|DefaultDropAction|TextElideMode' +
                      '|VerticalScrollMode|HorizontalScrollMode' +
                      '|SelectionMode|SelectionBehavior';
  Result:= Result + inherited getAttributes(ShowAttributes)
end;

const
  EventsWithIndex = '|activated|clicked|doubleClicked|entered|pressed';
  EventsOther = '|iconSizeChanged|viewportEntered';

function TQtAbstractItemView.getEvents(ShowEvents: integer): string;
begin
  Result:= EventsWithIndex +  EventsOther;
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtAbstractItemView.HandlerInfo(const event: string): string;
begin
  if Pos(event, EventsWithIndex) > 0then
    Result:= 'QModellIndex;index'
  else if event = 'iconSizeChanged' then
    Result:= 'QSize;size'
  else
    Result:= inherited;
end;

procedure TQtAbstractItemView.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.clearSelection');
    Slots.Add(Name + '.reset');
    Slots.Add(Name + '.scrollToBottom');
    Slots.Add(Name + '.scrollToTop');
    Slots.Add(Name + '.selectAll');
  end else if Parametertypes = 'QModelIndex' then begin
    Slots.Add(Name + '.edit');
    Slots.Add(Name + '.setCurrentIndex');
    Slots.Add(Name + '.setRootIndex');
    Slots.Add(Name + '.update');
  end;
  inherited;
end;

procedure TQtAbstractItemView.setAlternatingRowColors(Value: boolean);
begin
  if Value <> fAlternatingRowColors then begin
    FAlternatingRowColors:= Value;
    Invalidate;
  end;
end;

{--- TQtListView --------------------------------------------------------------}

constructor TQtListView.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 116;
  Width:= 120;
  Height:= 80;
  FrameShadow:= Sunken;
end;

function TQtListView.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '';
  if ShowAttributes >= 2 then
    Result:= Result + '|Flow|Movement';
  if ShowAttributes = 3 then
    Result:= Result + '|IsWrapping|ResizeMode|LayoutMode|ViewMode' +
                      '|Spacing|ModelColumn|UninformItemsSizes' +
                      '|BatchSize|WordWrap|SelectionRectVisible|ItemAlignment';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtListView.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'Movement') or (Attr = 'Flow') or
    (Attr = 'ViewMode') or (Attr = 'ResizeMode') or (Attr = 'LayoutMode') then
    MakeAttribut(Attr, 'QListView.' + Attr + '.' + Value)
  else if Attr = 'ItemAlignment' then
    MakeAttribut(Attr, 'Qt.AlignmentFlag.' + Value)
  else
    inherited;
end;

function TQtListView.getEvents(ShowEvents: integer): string;
begin
  Result:= '|indexesMoved';
  Result:= Result + inherited getEvents(ShowEvents);
end;

procedure TQtListView.NewWidget(Widget: String = '');
begin
  if Widget = ''
    then inherited NewWidget('QListView')
    else inherited NewWidget(Widget);
end;

procedure TQtListView.setFlow(Value: TFlow);
begin
  if Value <> FFlow then begin
    FFlow:= Value;
    Invalidate;
  end;
end;

procedure TQtListView.setSpacing(Value: integer);
begin
  if Value <> FSpacing then begin
    FSpacing:= Value;
    Invalidate;
  end;
end;

{--- TQtListWidget ------------------------------------------------------------}

constructor TQtListWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 77;
  FrameShadow:= Sunken;
  FCurrentRow:= -1;
  FItems:= TStringList.Create;
  FItems.Text:= defaultItems;
end;

destructor TQtListWidget.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TQtListWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Items|CurrentRow|SortingEnabled';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtListWidget.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Items'  then begin
    var s:= 'self.' + Name  + '.insertItems';
    setAttributValue(s, s + '(0, ' + getItems + ')');
  end else
    inherited;
end;

const ItemEvents =
  '|itemActivated|itemChanged|itemClicked|itemDoubleClicked|' +
  '|itemEntered|itemPressed';

function TQtListWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= '|currentItemChanged|currentRowChanged|currentTextChanged' +
           ItemEvents + '|itemSelectionChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtListWidget.HandlerInfo(const event: string): string;
begin
  if event = 'currentItemChanged' then
    Result:= 'QListWidgetItem, QListWidgetItem;current, previous'
  else if event = 'currentRowChanged' then
    Result:= 'int;currentRow'
  else if event = 'currentTextChanged' then
    Result:= 'QString;currentText'
  else if Pos(event, ItemEvents) > 0 then
    Result:= 'QListWidgetItem;item'
  else
    Result:= inherited;
end;

procedure TQtListWidget.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clear')
  else if Parametertypes = 'QListWidgetItem, QAbstractItemView' then
    Slots.Add(Name + '.scrollToItem');
  inherited;
end;

procedure TQtListWidget.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QListWidget');
  setAttribute('Items', getItems, '');
end;

procedure TQtListWidget.setItems(Values: TStrings);
begin
  FItems.Assign(Values);
  Invalidate;
end;

function TQtListWidget.getItems: String;
  var s: String; i: integer;
begin
  s:= '[';
  for i:= 0 to FItems.Count -1 do
    s:= s + asString(FItems[i]) + ', ';
  delete(s, length(s) - 1, 2);
  Result:= s + ']';
end;

procedure TQtListWidget.Paint;
  var s: String; R1, R2: TRect; RowHeight, ColumnWidth, i: integer;
begin
  inherited;
  R1:= InnerRect;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(R1);
  RowHeight:= Canvas.TextHeight('A') + 2*HalfX;

  R1.Inflate(-FSpacing, -FSpacing);
  if FFlow = TopToBottom then begin
    R1.Bottom:= R1.Top + RowHeight;
    for i:= 0 to FItems.Count - 1 do begin
      if AlternatingRowColors and (i mod 2 = 1) then begin
        Canvas.Brush.Color:= $F5F5F5;
        Canvas.FillRect(R1);
      end;
      if i = FCurrentRow then begin
        Canvas.Brush.Color:= $FFE8CD;
        Canvas.FillRect(R1);
      end;
      R2:= R1;
      R2.Inflate(-HalfX, -HalfX);
      s:= FItems[i];
      DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_LEFT);
      R1.Offset(0, RowHeight + 2*FSpacing);
      if R1.Top > Height then begin
        PaintAScrollbar(false);
        if FSpacing > 0 then begin
          R1:= Rect(Width - 1 - 16 - FSpacing, 1, Width - 1 - 16, Height - 1);
          Canvas.Brush.Color:= clWhite;
          Canvas.FillRect(R1);
        end;
        break;
      end;
    end;
  end else begin
    for i:= 0 to FItems.Count - 1 do begin
      s:= FItems[i];
      ColumnWidth:= Canvas.TextWidth(s) + 2*HalfX;
      R1.Right:= R1.Left + ColumnWidth;
      if AlternatingRowColors and (i mod 2 = 1) then begin
        Canvas.Brush.Color:= $F5F5F5;
        Canvas.FillRect(R1);
      end;
      if i = FCurrentRow then begin
        Canvas.Brush.Color:= $FFE8CD;
        Canvas.FillRect(R1);
      end;
      R2:= R1;
      R2.Inflate(-HalfX, -HalfX);
      R2.Top:= (R2.Bottom - R2.Top - RowHeight) div 2;
      DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_LEFT);
      R1.Offset(ColumnWidth + 2*FSpacing, 0);
      if R1.Left > Width then begin
        PaintAScrollbar(true);
        if FSpacing > 0 then begin
          R1:= Rect(1, Height - 1 - 16 - FSpacing, Width - 1, Height - 1 - 16);
          Canvas.Brush.Color:= clWhite;
          Canvas.FillRect(R1);
        end;
        break;
      end;
    end;
  end;
end;

{--- TQtColumnView ------------------------------------------------------------}

constructor TQtColumnView.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 117;
  Width:= 256;
  Height:= 104;
  FrameShadow:= Sunken;
  FItems:= TStringList.Create;
  FItems.Text:= 'First'#13#10'  node A'#13#10'  node B'#13#10'Second'#13#10'   node C'#13#10'    node D';
end;

destructor TQtColumnView.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TQtColumnView.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|ResizeGripsVisible|Items';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtColumnView.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Items'  then
    MakeItems
  else
    inherited;
end;

procedure TQtColumnView.DeleteWidget;
begin
  inherited;
  Partner.DeleteItems(Name, 'Item');
end;

function TQtColumnView.getEvents(ShowEvents: integer): string;
begin
  Result:= '|updatePreviewWidget';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtColumnView.HandlerInfo(const event: string): string;
begin
  if event = 'updatePreviewWidget' then
    Result:= 'QModelIndex;index'
  else
    Result:= inherited;
end;

procedure TQtColumnView.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QColumnView');
  InsertValue('self.' + Name + '.setModel(QStandardItemModel())');
  MakeItems;
end;

procedure TQtColumnView.MakeItems;
  var i, ls, Indent: integer;
      s: string;

  function Itemname(Indent: integer): string;
  begin
    Result:= 'self.' + Name + 'Item' + IntToStr(Indent);
  end;

  function MakeNode(Indent: integer; value: string): string;
  begin
    Result:= surround(Itemname(Indent) + ' = QStandardItem(' + asString(value) + ')');
  end;

  function AppendNode(Indent: integer): string;
  begin
    Result:= surround(Itemname(Indent-1) + '.appendRow(' + Itemname(Indent) + ')');
  end;

begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteItems(Name, 'Item');
  FormatItems(FItems);
  s:= surround('self.' + Name + 'Item0 = self.' + Name + '.model().invisibleRootItem()');
  Indent:= 0;
  i:= 0;
  while i < Items.Count do begin
    ls:= LeftSpaces(Items[i], 2) div 2 + 1;
    if ls < Indent then begin  // close open items
      while Indent > ls do begin
        s:= s + AppendNode(Indent);
        dec(Indent);
      end;
      dec(i);
    end else if ls > Indent then begin
      inc(Indent);
      s:= s + MakeNode(Indent, trim(Items[i]));
    end else begin
      s:= s + AppendNode(Indent);
      s:= s + MakeNode(Indent, trim(Items[i]));
    end;
    inc(i);
  end;
  while Indent > 0 do begin
    s:= s + AppendNode(Indent);
    dec(Indent);
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TQtColumnView.InnerRect: TRect;
begin
  Result:= inherited;
  Result.Bottom:= Result.Bottom - 16;
  Result.Right:= Result.Right - 16;
end;

procedure TQtColumnView.Paint;
  var s: String; R1, R2: TRect; th, i: integer;
      Points: array[1..3] of TPoint;
begin
  inherited;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(inherited InnerRect);
  // items
  th:= Canvas.TextHeight('A');
  R1:= InnerRect;
  R1.Inflate(-HalfX, -HalfX);
  R1.Right:= R1.Right - 16;
  R2:= R1;
  s:= '';
  for i:= 0 to FItems.Count - 1 do begin
    s:= FItems[i];
    if LeftSpaces(s, 2) = 0 then begin
      DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_LEFT);
      if (i + 1 < FItems.Count) and (LeftSpaces(FItems[i+1], 2) > 0) then begin
        Canvas.Brush.Color:= Canvas.Pen.Color;
        Points[1]:= Point(R2.Right + 8, R2.Top + 2);
        Points[2]:= Point(R2.Right + 8, R2.Top + 8);
        Points[3]:= Point(R2.Right + 11, R2.Top + 5);
        Canvas.Polygon(Points);
        Canvas.Brush.Color:= clWhite;
      end;
      R2.Offset(0, th);
      if R2.Top > R1.Bottom then
        break;
    end;
  end;
  // scrollbars
  if Width <= 256 then
    PaintAScrollbar(true);
  R2:= ClientRect;
  R2.Inflate(-1, -1);
  R2.Left:= R2.Right - 16;
  R2.Bottom:= R2.Bottom - 2*16;
  PaintScrollbar(R2, false);
  // mover
  R2.Bottom:= R2.Bottom + 16;
  R2.Top:= R2.Bottom - 16;
  R2.Right:= R2.Right - 8;
  Canvas.Brush.Color:= $D2D2D2;
  Canvas.FillRect(R2);
  Canvas.MoveTo(R2.Right - 2, R2.Top + 3);
  Canvas.LineTo(R2.Right - 2, R2.Bottom - 3);
  Canvas.MoveTo(R2.Right + 4, R2.Top + 3);
  Canvas.LineTo(R2.Right + 4, R2.Bottom - 3);
end;

procedure TQtColumnView.setResizeGripsVisible(Value: boolean);
begin
  if Value <> FResizeGripsVisible then begin
    fResizeGripsVisible:= Value;
    Invalidate;
  end;
end;

procedure TQtColumnView.setItems(Value: TStrings);
begin
  if Value <> FItems then begin
    FItems.assign(Value);
    Invalidate;
  end;
end;

{--- TQtTableView -------------------------------------------------------------}

constructor TQtTableView.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 119;
  Width:= 256;
  Height:= 104;
  FrameShadow:= Sunken;
  FShowGrid:= true;
  FGridStyle:= SolidLine;
  FWordWrap:= true;
  FCornerButtonEnabled:= true;
  FHeaderHorzVisible:= true;
  FHeaderVertVisible:= true;
  FColumnWidth:= 100;
  FRowHeight:= 30;
end;

function TQtTableView.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|ShowGrid|GridStyle|SortingEnabled|WordWrap|CornerButtonEnabled' +
           '|HeaderHorzVisible|HeaderVertVisible' +
           '|ColumnWidth|RowHeight';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTableView.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'HeaderHorzVisible') or (Attr = 'HeaderVertVisible') then
    MakeHeaderVisible(Attr, Value)
  else if Attr = 'ColumnWidth' then
    MakeColumWidth(Value)
  else if Attr = 'RowHeight' then
    MakeRowHeight(Value)
  else if Attr = 'GridStyle' then
    MakeAttribut(Attr, 'Qt.PenStyle.' + Value)
  else
    inherited;
end;

procedure TQtTableView.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.resizeColumnsToContents');
    Slots.Add(Name + '.resizeRowsToContents');
    Slots.Add(Name + '.toggle');
  end else if Parametertypes = 'int' then begin
    Slots.Add(Name + '.hideColumn');
    Slots.Add(Name + '.hideRow');
    Slots.Add(Name + '.resizeColumnToContents');
    Slots.Add(Name + '.resizeRowToContents');
    Slots.Add(Name + '.selectColumn');
    Slots.Add(Name + '.selectRow');
    Slots.Add(Name + '.showColumn');
    Slots.Add(Name + '.showRow');
  end else if Parametertypes = 'bool' then
    Slots.Add(Name + '.setShowGrid')
  else if Parametertypes = 'int, SortOrder' then  // ToDo Qt.SortOder
    Slots.Add(Name + '.sortByColumn');
  inherited;
end;

procedure TQtTableView.NewWidget(Widget: String = '');
begin
  if Widget = '' then begin
    inherited NewWidget('QTableView');
    InsertValue('self.' + Name + '.setModel(QStandardItemModel())');
  end else
    inherited NewWidget('QTableWidget');
end;

procedure TQtTableView.MakeHeaderVisible(Attr, Value: string);
  var key: string;
begin
  if Attr = 'HorizontalHeaderVisible'
    then key:= 'self.' + Name + '.horizontalHeader'
    else key:= 'self.' + Name + '.verticalHeader';
  setAttributValue(key, key + '().setVisible(' + Value + ')');
end;

procedure TQtTableView.MakeColumWidth(Value: string);
begin
  var key:= 'self.' + Name + '.horizontalHeader().setDefaultSectionSize';
  setAttributValue(key, key + '(' + Value + ')');
end;

procedure TQtTableView.MakeRowHeight(Value: string);
begin
  var key:= 'self.' + Name + '.verticalHeader().setDefaultSectionSize';
  setAttributValue(key, key + '(' + Value + ')');
end;

procedure TQtTableView.setHeaderHorzVisible(Value: boolean);
begin
  if Value <> FHeaderHorzVisible then begin
    FHeaderHorzVisible:= Value;
    Invalidate;
  end;
end;

procedure TQtTableView.setHeaderVertVisible(Value: boolean);
begin
  if Value <> FHeaderVertVisible then begin
    FHeaderVertVisible:= Value;
    Invalidate;
  end;
end;

procedure TQtTableView.setColumnWidth(Value: integer);
begin
  if Value <> FColumnWidth then begin
    fColumnWidth:= Value;
    Invalidate;
  end;
end;

procedure TQtTableView.setRowHeight(Value: integer);
begin
  if Value <> FRowHeight then begin
    FRowHeight:= Value;
    Invalidate;
  end;
end;

procedure TQtTableView.setShowGrid(Value: boolean);
begin
  if Value <> FShowGrid then begin
    FShowGrid:= Value;
    Invalidate;
  end;
end;

procedure TQtTableView.setGridStyle(Value: TGridStyle);
begin
  if Value <> FGridStyle then begin
    FGridStyle:= Value;
    Invalidate;
  end;
end;

{--- TQtTableWidget -----------------------------------------------------------}

constructor TQtTableWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 89;
  FRowCount:= 2;
  FColumnCount:= 4;
  FItems:= TStringList.Create;
  FItems.Text:= 'A B C D'#13#10'1 2 3 4';
  FHeaderHorz:= TStringList.Create;
  FHeaderHorz.Text:= 'Column 1'#13#10'Column 2'#13#10'Column 3'#13#10'Column 4'#13#10'Column 5';
  FHeaderVert:= TStringList.Create;
  FHeaderVert.Text:= 'Row 1'#13#10'Row 2'#13#10'Row 3'#13#10'Row 4'#13#10'Row 5';
end;

destructor TQtTableWidget.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FHeaderHorz);
  FreeAndNil(FHeaderVert);
  inherited;
end;

function TQtTableWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|RowCount|ColumnCount|Items|HeaderHorz|HeaderVert';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTableWidget.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'HeaderHorz' then
    MakeHorizontalHeader
  else if Attr = 'HeaderVert' then
    MakeVerticalHeader
  else if Attr = 'Items' then
    MakeItems
  else
    inherited;
end;

const
  EventsRowCol = '|cellActivated|cellChanged|cellClicked|cellDoubleClicked' +
                 '|cellEntered|cellPressed';
  EventsItems =  '|itemActivated|itemChanged|itemClicked|itemDoubleClicked|' +
                 '|itemEntered|itemPressed';
  EventsTabOther = '|currentCellChanged|currentItemChanged|itemSelectionChanged';

function TQtTableWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= EventsRowCol + EventsItems + EventsTabOther;
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtTableWidget.HandlerInfo(const event: string): string;
begin
  if event = 'currentCellChanged' then
    Result:= 'int, int, int, int;currentRow, currentColumn, previousRow, previousColumn'
  else if event = 'currentItemChanged' then
    Result:= 'QTableWidgetItem, QTableWidgetItem;current, previous'
  else if Pos(event, EventsRowCol) > 0 then
    Result:= 'int, int;row, column'
  else if Pos(event, EventsItems) > 0 then
    Result:= 'QTableWidgetItem;item'
  else
    Result:= inherited;
end;

procedure TQtTableWidget.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.clearContents');
  end else if Parametertypes = 'int' then begin
    Slots.Add(Name + '.insertColumn');
    Slots.Add(Name + '.insertRow');
    Slots.Add(Name + '.removeColumn');
    Slots.Add(Name + '.removeRow');
  end else if Parametertypes = 'QTableWidgetItem, QAbstractItemView' then
    Slots.Add(Name + '.scrollToItem(');
  inherited;
end;

procedure TQtTableWidget.MakeItems;
  var p, x, y: integer; s, s1: string;

  function insertItem(s: string): string;
  begin
    Result:= surround('self.' + Name + '.setItem(' + IntTostr(x) + ', ' +
                      IntToStr(y) + ', QTableWidgetItem(' + asString(s) + '))');
  end;

begin
  s1:= '';
  for x:= 0 to FItems.count - 1 do begin
    y:= 0;
    s:= FItems[x];
    p:= Pos(' ', s);
    while p > 0 do begin
      s1:= s1 + insertItem(copy(s, 1 , p-1));
      delete(s, 1, p);
      inc(y);
      p:= Pos(' ', s);
    end;
    if s <> '' then
      s1:= s1 + insertItem(s);
  end;
  InsertValue(s1);
end;

procedure TQtTableWidget.MakeHorizontalHeader;
  var i: integer; key, s: string;
begin
  s:= '';
  for i:= 0 to FHeaderHorz.Count - 1 do
    if trim(FHeaderHorz[i]) <> '' then
      s:= s + ', ' + asString(FHeaderHorz[i]);
  delete(S, 1, 2);
  if s = '' then
    Partner.DeleteAttribute('self.' + Name + '.setHorizontalHeaderLabels')
  else begin
    key:= 'self.' + Name + '.setHorizontalHeaderLabels';
    setAttributValue(key, key + '([' + s + '])');
  end;
end;

procedure TQtTableWidget.MakeVerticalHeader;
  var i: integer; key, s: string;
begin
  s:= '';
  for i:= 0 to FHeaderVert.Count - 1 do
    if trim(FHeaderVert[i]) <> '' then
      s:= s + ', ' + asString(FHeaderVert[i]);
  delete(S, 1, 2);
  if s = '' then
    Partner.DeleteAttribute('self.' + Name + '.setVerticalHeaderLabels')
  else begin
    key:= 'self.' + Name + '.setVerticalHeaderLabels';
    setAttributValue(key, key + '([' + s + '])');
  end;
end;

procedure TQtTableWidget.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QTableWidget');
  setAttribute('RowCount', '2', '');
  setAttribute('ColumnCount', '4', '');
  MakeHorizontalHeader;
  MakeVerticalHeader;
  MakeItems;
end;

procedure TQtTableWidget.Paint;
  var s, s1: String; R1, R2: TRect; p, th, tw, y, x, MaxY, MaxX: integer;
      ShowVerticalScrollbar, ShowHorizontalScrollbar: boolean;
begin
  inherited;
  ShowVerticalScrollBar:= false;
  ShowHorizontalScrollBar:= false;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(InnerRect);
  th:= HalfX + Canvas.TextHeight('A') + HalfX;
  tw:= Canvas.TextWidth('1');

  // vertical header
  if HeaderVertVisible then begin
    for y:= 1 to RowCount do
      if y <= HeaderVert.Count then
        tw:= max(tw, Canvas.TextWidth(HeaderVert[y-1]))
      else
        tw:= max(tw, Canvas.Textwidth(IntToStr(y)));
    tw:= tw + 4*HalfX;
  end else
    tw:= 0;
  if not HeaderHorzVisible then
    th:= 0;

  R1:= Rect(1, 1 + th, 1 + tw, 1 + th + FRowHeight);
  MaxY:= RowCount;
  for y:= 1 to RowCount do begin
    if (y <= HeaderVert.Count) and (trim(HeaderVert[y-1]) <> '')
      then s:= HeaderVert[y-1]
      else s:= IntToStr(y);
    if HeaderVertVisible then
      DrawText(Canvas.Handle, PChar(s), Length(s), R1, DT_CENTER + DT_VCENTER + DT_SINGLELINE);
    R1.Offset(0, FRowHeight);
    if R1.Top > Height then begin
      ShowVerticalScrollbar:= true;
      MaxY:= y;
      break;
    end;
  end;

  // horizontal header
  R1:= Rect(1 + tw, 1, 1 + tw + FColumnWidth, 1 + th);
  MaxX:= ColumnCount;
  for x:= 1 to ColumnCount do begin
    if (x <= HeaderHorz.Count) and (trim(HeaderHorz[x-1]) <> '')
      then s:= HeaderHorz[x-1]
      else s:= IntToStr(x);
    if HeaderHorzVisible then
      DrawText(Canvas.Handle, PChar(s), Length(s), R1, DT_CENTER + DT_VCENTER + DT_SINGLELINE);
    R1.Offset(FColumnWidth, 0);
    if R1.Left > Width then begin
      ShowHorizontalScrollbar:= true;
      MaxX:= x;
      break;
    end;
  end;

  // cells
  R1:= Rect(1 + tw, 1 + th, min(1 + tw + MaxX*FColumnWidth, Width - 1), 1 + th + FRowHeight);
  for y:= 1 to MaxY do begin
    if AlternatingRowColors and (y mod 2 = 0) then begin
      Canvas.Brush.Color:= $F5F5F5;
      if R1.Bottom >= Height then
        R1.Bottom:= Height - 1;
      Canvas.FillRect(R1);
    end;
    if y <= FItems.Count
      then s:= FItems[y-1]
      else break;
    R2:= R1;
    R2.Right:= R2.Left + FColumnWidth;
    R2.Inflate(-HalfX, -HalfX);
    p:= Pos(' ', s);
    while p > 0 do begin
      s1:= copy(s, 1, p - 1);
      delete(s, 1, p);
      p:= Pos(' ', s);
      DrawText(Canvas.Handle, PChar(s1), Length(s1), R2, DT_LEFT + DT_VCENTER + DT_SINGLELINE);
      R2.Offset(FColumnWidth, 0);
      if R2.Left > Width then
        break;
    end;
    DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_LEFT + DT_VCENTER + DT_SINGLELINE);
    R1.Offset(0, FRowHeight);
  end;

  // grid
  Canvas.Pen.Color:= $D8D8D8;
  if (FGridStyle <> NoPen) and FShowGrid then begin
    case FGridStyle of
      NoPen:     Canvas.Pen.Style:= psClear;
      SolidLine: Canvas.Pen.Style:= psSolid;
      DashLine:  Canvas.Pen.Style:= psDash;
      DotLine:   Canvas.Pen.Style:= psDot;
      DashDotLine: Canvas.Pen.Style:= psDashDot;
      DashDotDotLine: Canvas.Pen.Style:= psDashDotDot;
      CustomDashLine: Canvas.Pen.Style:= psSolid;
    end;
    for y:= 0 to MaxY do begin
      Canvas.MoveTo(tw, th + y*FRowHeight);
      Canvas.LineTo(tw + MaxX*FColumnWidth, th + y*FRowHeight);
    end;
    for x:= 0 to MaxX do begin
      Canvas.MoveTo(tw + x*FColumnWidth, 1);
      Canvas.LineTo(tw + x*FColumnWidth, th + MaxY*FRowHeight);
    end;
    Canvas.Pen.Style:= psSolid;
  end;
  PaintScrollbars(ShowHorizontalScrollbar, ShowVerticalScrollbar);
end;

procedure TQtTableWidget.setRowCount(Value: integer);
begin
  if Value <> FRowCount then begin
    FRowCount:= Value;
    Invalidate;
  end;
end;

procedure TQtTableWidget.setColumnCount(Value: integer);
begin
  if Value <> FColumnCount then begin
    FColumnCount:= Value;
    Invalidate;
  end;
end;

procedure TQtTableWidget.setItems(Value: TStrings);
begin
  if Value <> FItems then begin
    FItems.assign(Value);
    Invalidate;
  end;
end;

procedure TQtTableWidget.setHeaderHorz(Value: TStrings);
begin
  if Value <> FHeaderHorz then begin
    fHeaderHorz.assign(Value);
    Invalidate;
  end;
end;

procedure TQtTableWidget.setHeaderVert(Value: TStrings);
begin
  if Value <> FHeaderVert then begin
    FHeaderVert.assign(Value);
    Invalidate;
  end;
end;

{--- TQtTreeView --------------------------------------------------------------}

constructor TQtTreeView.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 118;
  Width:= 256;
  Height:= 104;
  FrameShadow:= Sunken;
  FAutoExpandDelay:= -1;
  FIndentation:= 20;
  FItemsExpandable:= true;
  FExpandsOnDoubleClick:= true;
  FColumnWidth:= 100;
end;

function TQtTreeView.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Indentation|SortingEnabled|HeaderHidden|ColumnWidth';
  if ShowAttributes >= 2 then
    Result:= Result + '|AutoExpandDelay|RootIsDecorated|UniformRowHeights' +
     '|ItemsExpandable|Animated|AllColumnsShowFocus|WordWrap|ExpandsOnDoubleClick';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTreeView.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'ColumnWidth' then
    MakeColumWidth(Value)
  else
    inherited;
end;

const TVEvents = '|collapsed|expanded';

function TQtTreeView.getEvents(ShowEvents: integer): string;
begin
  Result:= TVEvents + inherited getEvents(ShowEvents);
end;

function TQtTreeView.HandlerInfo(const event: string): string;
begin
  if Pos(event, TVEvents) > 0 then
    Result:= 'QModelIndex;index'
  else
    Result:= inherited;
end;

procedure TQtTreeView.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.collapseAll');
    Slots.Add(Name + '.expandAll');
  end else if Parametertypes = 'QModelIndex' then begin
    Slots.Add(Name + '.collapse');
    Slots.Add(Name + '.expand');
  end else if Parametertypes = 'QModelIndex, int' then
    Slots.Add(Name + '.expandRecursively')
  else if Parametertypes = 'int' then begin
    Slots.Add(Name + '.expandToDepth');
    Slots.Add(Name + '.hideColumn');
    Slots.Add(Name + '.resizeColumnToContents');
    Slots.Add(Name + '.showColumn');
  end else if Parametertypes = 'int, SortOrder' then // ToDo
    Slots.Add(Name + '.sortByColumn');
  inherited;
end;

procedure TQtTreeView.NewWidget(Widget: String = '');
begin
  if Widget = '' then begin
    inherited NewWidget('QTreeView');
    InsertValue('self.' + Name + '.setModel(QStandardItemModel())');
  end else
    inherited NewWidget('QTreeWidget');
end;

procedure TQtTreeView.MakeColumWidth(Value: string);
begin
  var key:= 'self.' + Name + '.header().setDefaultSectionSize';
  setAttributValue(key, key + '(' + Value + ')');
end;

procedure TQtTreeView.setColumnWidth(Value: integer);
begin
  if Value <> FColumnWidth then begin
    fColumnWidth:= Value;
    Invalidate;
  end;
end;

procedure TQtTreeView.setHeaderHidden(Value: boolean);
begin
  if Value <> FHeaderHidden then begin
    FHeaderHidden:= Value;
    Invalidate;
  end;
end;

procedure TQtTreeView.setIndentation(Value: integer);
begin
  if Value <> FIndentation then begin
    FIndentation:= Value;
    Invalidate;
  end;
end;

{--- TQtTreeWidget ------------------------------------------------------------}

constructor TQtTreeWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 88;
  FColumnCount:= 3;
  FItems:= TStringList.Create;
  FItems.Text:= 'First, F2, F3'#13#10'  node A, A2, A3'#13#10'  node B'#13#10'Second'#13#10'   node C'#13#10'    node D, D2';
  FHeader:= TStringList.Create;
  FHeader.Text:= 'Column 1'#13#10'Column 2'#13#10'Column 3';
end;

destructor TQtTreeWidget.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FHeader);
  inherited;
end;

procedure TQtTreeWidget.DeleteWidget;
begin
  inherited;
  Partner.DeleteItems(Name, 'Item');
end;

function TQtTreeWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|ColumnCount|Items|Header';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTreeWidget.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Header' then
    MakeHeader
  else if Attr = 'Items' then
    MakeItems
  else
    inherited;
end;

const
  EventsItemCol = '|itemActivated|itemChanged|itemClicked|itemDoubleClicked' +
                  '|itemEntered|itemPressed';
  EventsTableItems = '|itemCollapsed|itemExpanded';
  EventsTableOther = '|currentItemChanged|itemSelectionChanged';

function TQtTreeWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= EventsItemCol + EventsTableItems + EventsTableOther;
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtTreeWidget.HandlerInfo(const event: string): string;
begin
  if event = 'currentItemChanged' then
    Result:= 'QTreeWidgetItem, QTreeWidgetItem;current, previous'
  else if Pos(event, EventsTableItems) > 0 then
    Result:= 'QTreeWidgetItem;item'
  else if Pos(event, EventsItemCol) > 0 then
    Result:= 'QTreeWidgetItem, int;item, column'
  else
    Result:= inherited;
end;

procedure TQtTreeWidget.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clear')
  else if Parametertypes = 'QTreeWidgetItem ' then begin
    Slots.Add(Name + '.collapseItem');
    Slots.Add(Name + '.expandItem');
  end else if Parametertypes = 'QTreeWidgetItem, QAbstractItemView' then
    Slots.Add(Name + '.scrollToItem');
  inherited;
end;

procedure TQtTreeWidget.MakeItems;
  var i, ls, Indent: integer;
      s: string;

  function Itemname(Indent: integer): string;
  begin
    if Indent = -1
      then Result:= 'self.' + Name
      else Result:= 'self.' + Name + 'Item' + IntToStr(Indent);
  end;

  function MakeNode(Indent: integer; value: string): string;
    var p, col: integer;
  begin
    Result:= surround(Itemname(Indent) + ' = QTreeWidgetItem(' +
                      Itemname(Indent - 1) + ')');
    col:= 0;
    p:= Pos(',', value);
    while p > 0 do begin
      Result:= Result + surround(Itemname(Indent) + '.setText(' + IntToStr(col) + ', ' +
                                 asString(copy(value, 1, p-1)) + ')');
      delete(value, 1, p);
      value:= trim(value);
      p:= Pos(',', value);
      inc(col);
    end;
    Result:= Result + surround(Itemname(Indent) + '.setText(' + IntToStr(col) +
                               ', ' + asString(value) + ')');
  end;

begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteItems(Name, 'Item');
  FormatItems(FItems);
  Indent:= 0;
  s:= '';
  i:= 0;
  while i < Items.Count do begin
    ls:= LeftSpaces(Items[i], 2) div 2;
    if ls < Indent then begin  // close open items
      while ls < Indent do
        dec(Indent);
      dec(i);
    end else if ls > Indent then begin
      inc(Indent);
      s:= s + MakeNode(Indent, trim(Items[i]));
    end else
      s:= s + MakeNode(Indent, trim(Items[i]));
    inc(i);
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtTreeWidget.MakeHeader;
  var i: integer; key, s: string;
begin
  s:= '';
  for i:= 0 to FHeader.Count - 1 do
    if trim(FHeader[i]) <> '' then
      s:= s + ', ' + asString(FHeader[i]);
  delete(S, 1, 2);
  if s = '' then
    Partner.DeleteAttribute('self.' + Name + '.setHeaderLabels')
  else begin
    key:= 'self.' + Name + '.setHeaderLabels';
    setAttributValue(key, key + '([' + s + '])');
  end;
end;

procedure TQtTreeWidget.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QTreeWidget');
  MakeHeader;
  MakeItems;
end;

procedure TQtTreeWidget.Paint;
  var s: String; R1, R2: TRect; i, j, y, x, RowHeight: integer;
      ShowVerticalScrollbar, ShowHorizontalScrollbar: boolean;
      SL: TStringList;
begin
  inherited;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(InnerRect);
  RowHeight:= HalfX + Canvas.TextHeight('A') + HalfX;
  ShowHorizontalScrollbar:= false;
  ShowVerticalScrollbar:= false;
  // horizontal header
  R1:= Rect(1 + HalfX, 1, FColumnWidth - 1, 1 + RowHeight);
  for x:= 1 to max(FColumnCount, Header.Count) do begin
    if (x <= Header.Count) and (trim(Header[x-1]) <> '')
      then s:= Header[x-1]
      else s:= IntToStr(x);
    if not HeaderHidden then
      DrawText(Canvas.Handle, PChar(s), Length(s), R1, DT_Left + DT_VCENTER + DT_SINGLELINE);
    R1.Offset(FColumnWidth, 0);
    if R1.Left > Width then begin
      if HorizontalScrollBarPolicy <> ScrollBarAlwaysOff then
        ShowHorizontalScrollbar:= true;
      break;
    end;
  end;

  // items
  R1:= Rect(1 + HalfX + FIndentation, 1 + RowHeight + HalfX, FColumnWidth - 1, 1 + 2*RowHeight + HalfX);
  for i:= 0 to FItems.Count - 1 do begin
    s:= FItems[i];
    if LeftSpaces(s, 2) = 0 then begin
      if AlternatingRowColors and (i mod 2 = 1) then begin
        R2:= R1;
        R2.Bottom:= R2.Top + RowHeight;
        R2.Right:= ClientRect.Right - 1;
        Canvas.Brush.Color:= $F5F5F5;
        Canvas.FillRect(R2);
      end;
      SL:= Split(',', s);
      s:= trim(SL[0]);
      DrawText(Canvas.Handle, PChar(s), Length(s), R1, DT_LEFT);
      R2:= R1;
      R2.Left:= R2.Left - FIndentation;
      for j:= 1 to SL.Count - 1 do begin
        R2.Offset(FColumnWidth, 0);
        s:= trim(SL[j]);
        DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_LEFT);
      end;
      FreeAndNil(SL);
      if (i + 1 < FItems.Count) and (LeftSpaces(FItems[i+1], 2) > 0) then begin
        Canvas.Brush.Color:= Canvas.Pen.Color;
        Canvas.Pen.Width:= 2;
        x:= FIndentation div 2;
        y:= R1.Top + RowHeight div 2 - 2;
        Canvas.MoveTo(x - 2, y - 4);
        Canvas.LineTo(X + 2, y);
        Canvas.LineTo(x - 2, y + 4);
        Canvas.Brush.Color:= clWhite;
      end;
      R1.Offset(0, RowHeight);
      if R1.Top > Height then begin
        if VerticalScrollBarPolicy <> ScrollBarAlwaysOff then
          ShowVerticalScrollbar:= true;
        break;
      end;
    end;
  end;

  // scrollbars
  Canvas.Pen.Width:= 1;
  PaintScrollbars(ShowHorizontalScrollbar, ShowVerticalScrollbar);
end;

procedure TQtTreeWidget.setColumnCount(Value: integer);
begin
  if Value <> FColumnCount then begin
    FColumnCount:= Value;
    Invalidate;
  end;
end;

procedure TQtTreeWidget.setHeader(Value: TStrings);
begin
  if Value <> FHeader then begin
    FHeader.assign(Value);
    Invalidate;
  end;
end;

procedure TQtTreeWidget.setItems(Value: TStrings);
begin
  if Value <> FItems then begin
    FItems.assign(Value);
    Invalidate;
  end;
end;

end.
