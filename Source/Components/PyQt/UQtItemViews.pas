{ -------------------------------------------------------------------------------
  Unit:     UQtItemViews
  Author:   Gerhard Röhner
  Date:     July 2022
  Purpose:  PyQt item view widgets
  ------------------------------------------------------------------------------- }

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
  Windows, Classes, UBaseQtWidgets, UQtScrollable;

type

  TDragDropMode = (NoDragDrop, DragOnly, DropOnly, DragDrop, InternalMove);

  TDefaultDropAction = (CopyAction, MoveAction, LinkAction, ActionMask,
    TargetMoveAction, IgnoreAction);

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
    FAutoScroll: Boolean;
    FAutoScrollMargin: Integer;
    // editTriggers
    FTabKeyNavigation: Boolean;
    FShowDropIndicator: Boolean;
    FDragEnabled: Boolean;
    FDragDropOverwriteMode: Boolean;
    FDragDropMode: TDragDropMode;
    FDefaultDropAction: TDefaultDropAction;
    FAlternatingRowColors: Boolean;
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
    procedure SetAlternatingRowColors(Value: Boolean);
  public
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
  published
    property AutoScroll: Boolean read FAutoScroll write FAutoScroll;
    property AutoScrollMargin: Integer read FAutoScrollMargin
      write FAutoScrollMargin;
    // editTriggers
    property TabKeyNavigation: Boolean read FTabKeyNavigation
      write FTabKeyNavigation;
    property ShowDropIndicator: Boolean read FShowDropIndicator
      write FShowDropIndicator;
    property DragEnabled: Boolean read FDragEnabled write FDragEnabled;
    property DragDropOverwriteMode: Boolean read FDragDropOverwriteMode
      write FDragDropOverwriteMode;
    property DragDropMode: TDragDropMode read FDragDropMode write FDragDropMode;
    property DefaultDropAction: TDefaultDropAction read FDefaultDropAction
      write FDefaultDropAction;
    property AlternatingRowColors: Boolean read FAlternatingRowColors
      write SetAlternatingRowColors;
    property SelectionMode: TSelectionMode read FSelectionMode
      write FSelectionMode;
    property SelectionBehavior: TSelectionBehavior read FSelectionBehavior
      write FSelectionBehavior;
    // IconSize
    property TextElideMode: TTextElideMode read FTextElideMode
      write FTextElideMode;
    property VerticalScrollMode: TScrollMode read FVerticalScrollMode
      write FVerticalScrollMode;
    property HorizontalScrollMode: TScrollMode read FHorizontalScrollMode
      write FHorizontalScrollMode;
    // signas
    property activated: string read FActivated write FActivated;
    property clicked: string read FClicked write FClicked;
    property doubleClicked: string read FDoubleClicked write FDoubleClicked;
    property entered: string read FEntered write FEntered;
    property iconSizeChanged: string read FIconSizeChanged
      write FIconSizeChanged;
    property pressed: string read FPressed write FPressed;
    property viewportEntered: string read FViewportEntered
      write FViewportEntered;
  end;

  TQtListView = class(TQtAbstractItemView)
  private
    FMovement: TMovement;
    FFlow: TFlow;
    FIsWrapping: Boolean;
    FResizeMode: TResizeMode;
    FLayoutMode: TLayoutMode;
    FSpacing: Integer;
    // FGridSize
    FViewMode: TViewMode;
    FModelColumn: Integer;
    FUninformItemsSizes: Boolean;
    FBatchSize: Integer;
    FWordWrap: Boolean;
    FSelectionRectVisible: Boolean;
    FItemAlignment: TAlignmentHorizontal;
    FIndexesMoved: string;
    procedure SetFlow(Value: TFlow);
    procedure SetSpacing(Value: Integer);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property Movement: TMovement read FMovement write FMovement;
    property Flow: TFlow read FFlow write SetFlow;
    property IsWrapping: Boolean read FIsWrapping write FIsWrapping;
    property ResizeMode: TResizeMode read FResizeMode write FResizeMode;
    property LayoutMode: TLayoutMode read FLayoutMode write FLayoutMode;
    property Spacing: Integer read FSpacing write SetSpacing;
    // FGridSize
    property ViewMode: TViewMode read FViewMode write FViewMode;
    property ModelColumn: Integer read FModelColumn write FModelColumn;
    property UninformItemsSizes: Boolean read FUninformItemsSizes
      write FUninformItemsSizes;
    property BatchSize: Integer read FBatchSize write FBatchSize;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property SelectionRectVisible: Boolean read FSelectionRectVisible
      write FSelectionRectVisible;
    property ItemAlignment: TAlignmentHorizontal read FItemAlignment
      write FItemAlignment;
    // signals
    property indexesMoved: string read FIndexesMoved write FIndexesMoved;
  end;

  TQtListWidget = class(TQtListView)
  private
    FCurrentRow: Integer;
    FSortingEnabled: Boolean;
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
    procedure SetItems(Values: TStrings);
    function GetItems: string;
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
    property CurrentRow: Integer read FCurrentRow write FCurrentRow;
    property SortingEnabled: Boolean read FSortingEnabled write FSortingEnabled;
    property Items: TStrings read FItems write SetItems;

    // signals
    property currentItemChanged: string read FCurrentItemChanged
      write FCurrentItemChanged;
    property currentRowChanged: string read FCurrentRowChanged
      write FCurrentRowChanged;
    property currentTextChanged: string read FCurrentTextChanged
      write FCurrentTextChanged;
    property itemActivated: string read FItemActivated write FItemActivated;
    property itemChanged: string read FItemChanged write FItemChanged;
    property itemClicked: string read FItemClicked write FItemClicked;
    property itemDoubleClicked: string read FItemDoubleClicked
      write FItemDoubleClicked;
    property itemEntered: string read FItemEntered write FItemEntered;
    property itemPressed: string read FItemPressed write FItemPressed;
    property itemSelectionChanged: string read FItemSelectionChanged
      write FItemSelectionChanged;
  end;

  TQtColumnView = class(TQtAbstractItemView)
  private
    FResizeGripsVisible: Boolean;
    FItems: TStrings;
    FUpdatePreviewWidget: string;
    procedure SetResizeGripsVisible(Value: Boolean);
    procedure SetItems(Value: TStrings);
    procedure MakeItems;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure DeleteWidget; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    function InnerRect: TRect; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property ResizeGripsVisible: Boolean read FResizeGripsVisible
      write SetResizeGripsVisible;
    property Items: TStrings read FItems write SetItems;
    property UpdatePreviewWidget: string read FUpdatePreviewWidget
      write FUpdatePreviewWidget;
  end;

  TQtTreeView = class(TQtAbstractItemView)
  private
    FAutoExpandDelay: Integer;
    FIndentation: Integer;
    FRootIsDecorated: Boolean;
    FUniformRowHeights: Boolean;
    FItemsExpandable: Boolean;
    FSortingEnabled: Boolean;
    FAnimated: Boolean;
    FAllColumnsShowFocus: Boolean;
    FWordWrap: Boolean;
    FHeaderHidden: Boolean;
    FExpandsOnDoubleClick: Boolean;
    FColumnWidth: Integer;
    FCollapsed: string;
    FExpanded: string;
    procedure SetIndentation(Value: Integer);
    procedure SetColumnWidth(Value: Integer);
    procedure SetHeaderHidden(Value: Boolean);
    procedure MakeColumWidth(const Value: string);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property AutoExpandDelay: Integer read FAutoExpandDelay
      write FAutoExpandDelay;
    property Indentation: Integer read FIndentation write SetIndentation;
    property RootIsDecorated: Boolean read FRootIsDecorated
      write FRootIsDecorated;
    property UniformRowHeights: Boolean read FUniformRowHeights
      write FUniformRowHeights;
    property ItemsExpandable: Boolean read FItemsExpandable
      write FItemsExpandable;
    property SortingEnabled: Boolean read FSortingEnabled write FSortingEnabled;
    property Animated: Boolean read FAnimated write FAnimated;
    property AllColumnsShowFocus: Boolean read FAllColumnsShowFocus
      write FAllColumnsShowFocus;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property HeaderHidden: Boolean read FHeaderHidden write SetHeaderHidden;
    property ExpandsOnDoubleClick: Boolean read FExpandsOnDoubleClick
      write FExpandsOnDoubleClick;
    property ColumnWidth: Integer read FColumnWidth write SetColumnWidth;
    // signals
    property collapsed: string read FCollapsed write FCollapsed;
    property expanded: string read FExpanded write FExpanded;
  end;

  TQtTreeWidget = class(TQtTreeView)
  private
    FItems: TStrings;
    FHeader: TStrings;
    FColumnCount: Integer;
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
    procedure SetColumnCount(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetHeader(Value: TStrings);
    procedure MakeItems;
    procedure MakeHeader;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure DeleteWidget; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property Header: TStrings read FHeader write SetHeader;
    property Items: TStrings read FItems write SetItems;
    property ColumnCount: Integer read FColumnCount write SetColumnCount;
    // signals
    property currentItemChanged: string read FCurrentItemChanged
      write FCurrentItemChanged;
    property itemActivated: string read FItemActivated write FItemActivated;
    property itemChanged: string read FItemChanged write FItemChanged;
    property itemClicked: string read FItemClicked write FItemClicked;
    property itemCollapsed: string read FItemCollapsed write FItemCollapsed;
    property itemDoubleClicked: string read FItemDoubleClicked
      write FItemDoubleClicked;
    property itemEntered: string read FItemEntered write FItemEntered;
    property itemExpanded: string read FItemExpanded write FItemExpanded;
    property itemPressed: string read FItemPressed write FItemPressed;
    property itemSelectionChanged: string read FItemSelectionChanged
      write FItemSelectionChanged;
  end;

  TQtTableView = class(TQtAbstractItemView)
  private
    FShowGrid: Boolean;
    FGridStyle: TGridStyle;
    FSortingEnabled: Boolean;
    FWordWrap: Boolean;
    FCornerButtonEnabled: Boolean;
    FHeaderHorzVisible: Boolean;
    FHeaderVertVisible: Boolean;
    FColumnWidth: Integer;
    FRowHeight: Integer;
    procedure SetHeaderHorzVisible(Value: Boolean);
    procedure SetHeaderVertVisible(Value: Boolean);
    procedure SetColumnWidth(Value: Integer);
    procedure SetRowHeight(Value: Integer);
    procedure SetShowGrid(Value: Boolean);
    procedure SetGridStyle(Value: TGridStyle);
    procedure MakeHeaderVisible(const Attr, Value: string);
    procedure MakeColumWidth(const Value: string);
    procedure MakeRowHeight(const Value: string);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property ShowGrid: Boolean read FShowGrid write SetShowGrid;
    property GridStyle: TGridStyle read FGridStyle write SetGridStyle;
    property SortingEnabled: Boolean read FSortingEnabled write FSortingEnabled;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property CornerButtonEnabled: Boolean read FCornerButtonEnabled
      write FCornerButtonEnabled;
    property HeaderHorzVisible: Boolean read FHeaderHorzVisible
      write SetHeaderHorzVisible;
    property HeaderVertVisible: Boolean read FHeaderVertVisible
      write SetHeaderVertVisible;
    property ColumnWidth: Integer read FColumnWidth write SetColumnWidth;
    property RowHeight: Integer read FRowHeight write SetRowHeight;
  end;

  TQtTableWidget = class(TQtTableView)
  private
    FRowCount: Integer;
    FColumnCount: Integer;
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
    procedure SetRowCount(Value: Integer);
    procedure SetColumnCount(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetHeaderHorz(Value: TStrings);
    procedure SetHeaderVert(Value: TStrings);
    procedure MakeVerticalHeader;
    procedure MakeHorizontalHeader;
    procedure MakeItems;
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
    property RowCount: Integer read FRowCount write SetRowCount;
    property ColumnCount: Integer read FColumnCount write SetColumnCount;
    property Items: TStrings read FItems write SetItems;
    property HeaderHorz: TStrings read FHeaderHorz write SetHeaderHorz;
    property HeaderVert: TStrings read FHeaderVert write SetHeaderVert;
    // signals
    property cellActivated: string read FCellActivated write FCellActivated;
    property cellChanged: string read FCellChanged write FCellChanged;
    property cellClicked: string read FCellClicked write FCellClicked;
    property cellDoubleClicked: string read FCellDoubleClicked
      write FCellDoubleClicked;
    property cellEntered: string read FCellEntered write FCellEntered;
    property cellPressed: string read FCellPressed write FCellPressed;
    property currentCellChanged: string read FCurrentCellChanged
      write FCurrentCellChanged;
    property currentItemChanged: string read FCurrentItemChanged
      write FCurrentItemChanged;
    property itemActivated: string read FItemActivated write FItemActivated;
    property itemChanged: string read FItemChanged write FItemChanged;
    property itemClicked: string read FItemClicked write FItemClicked;
    property itemDoubleClicked: string read FItemDoubleClicked
      write FItemDoubleClicked;
    property itemEntered: string read FItemEntered write FItemEntered;
    property itemPressed: string read FItemPressed write FItemPressed;
    property itemSelectionChanged: string read FItemSelectionChanged
      write FItemSelectionChanged;
  end;

implementation

uses Controls, Graphics, SysUtils, Types, UITypes, Math, UQtFrameBased, UUtils;

{ --- TQtAbstractItemView ------------------------------------------------------ }

procedure TQtAbstractItemView.SetAttribute(const Attr, Value, Typ: string);
begin
  if (Attr = 'DragDropMode') or (Attr = 'SelectionMode') or
    (Attr = 'SelectionBehavior') then
    MakeAttribut(Attr, 'QAbstractItemView.' + Attr + '.' + Value)
  else if (Attr = 'VerticalScrollMode') or (Attr = 'HorizontalScrollMode') then
    MakeAttribut(Attr, 'QAbstractItemView.ScrollMode.' + Value)
  else if Attr = 'TextElideMode' then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if Attr = 'DefaultDropAction' then
    MakeAttribut(Attr, 'Qt.DropAction.' + Value)
  else
    inherited;
end;

function TQtAbstractItemView.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|AlternatingRowColors';
  if ShowAttributes = 3 then
    Result := Result + '|AutoScroll|AutoScrollMargin|TabKeyNavigation' +
      '|ShowDropIndicator|DragEnabled|DragDropOverwriteMode' +
      '|DragDropMode|DefaultDropAction|TextElideMode' +
      '|VerticalScrollMode|HorizontalScrollMode' +
      '|SelectionMode|SelectionBehavior';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

const
  EventsWithIndex = '|activated|clicked|doubleClicked|entered|pressed';
  EventsOther = '|iconSizeChanged|viewportEntered';

function TQtAbstractItemView.GetEvents(ShowEvents: Integer): string;
begin
  Result := EventsWithIndex + EventsOther;
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtAbstractItemView.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, EventsWithIndex) > 0 then
    Result := 'QModellIndex;index'
  else if Event = 'iconSizeChanged' then
    Result := 'QSize;size'
  else
    Result := inherited;
end;

procedure TQtAbstractItemView.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.clearSelection');
    Slots.Add(Name + '.reset');
    Slots.Add(Name + '.scrollToBottom');
    Slots.Add(Name + '.scrollToTop');
    Slots.Add(Name + '.selectAll');
  end
  else if Parametertypes = 'QModelIndex' then
  begin
    Slots.Add(Name + '.edit');
    Slots.Add(Name + '.setCurrentIndex');
    Slots.Add(Name + '.setRootIndex');
    Slots.Add(Name + '.update');
  end;
  inherited;
end;

procedure TQtAbstractItemView.SetAlternatingRowColors(Value: Boolean);
begin
  if Value <> FAlternatingRowColors then
  begin
    FAlternatingRowColors := Value;
    Invalidate;
  end;
end;

{ --- TQtListView -------------------------------------------------------------- }

constructor TQtListView.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 116;
  Width := 120;
  Height := 80;
  FrameShadow := Sunken;
end;

function TQtListView.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  if ShowAttributes >= 2 then
    Result := Result + '|Flow|Movement';
  if ShowAttributes = 3 then
    Result := Result + '|IsWrapping|ResizeMode|LayoutMode|ViewMode' +
      '|Spacing|ModelColumn|UninformItemsSizes' +
      '|BatchSize|WordWrap|SelectionRectVisible|ItemAlignment';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtListView.SetAttribute(const Attr, Value, Typ: string);
begin
  if (Attr = 'Movement') or (Attr = 'Flow') or (Attr = 'ViewMode') or
    (Attr = 'ResizeMode') or (Attr = 'LayoutMode') then
    MakeAttribut(Attr, 'QListView.' + Attr + '.' + Value)
  else if Attr = 'ItemAlignment' then
    MakeAttribut(Attr, 'Qt.AlignmentFlag.' + Value)
  else
    inherited;
end;

function TQtListView.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|indexesMoved';
  Result := Result + inherited GetEvents(ShowEvents);
end;

procedure TQtListView.NewWidget(const Widget: string = '');
begin
  if Widget = '' then
    inherited NewWidget('QListView')
  else
    inherited NewWidget(Widget);
end;

procedure TQtListView.SetFlow(Value: TFlow);
begin
  if Value <> FFlow then
  begin
    FFlow := Value;
    Invalidate;
  end;
end;

procedure TQtListView.SetSpacing(Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

{ --- TQtListWidget ------------------------------------------------------------ }

constructor TQtListWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 77;
  FrameShadow := Sunken;
  FCurrentRow := -1;
  FItems := TStringList.Create;
  FItems.Text := DefaultItems;
end;

destructor TQtListWidget.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TQtListWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Items|CurrentRow|SortingEnabled';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtListWidget.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Items' then
  begin
    var
    Str := 'self.' + Name + '.insertItems';
    SetAttributValue(Str, Str + '(0, ' + GetItems + ')');
  end
  else
    inherited;
end;

const
  ItemEvents = '|itemActivated|itemChanged|itemClicked|itemDoubleClicked|' +
    '|itemEntered|itemPressed';

function TQtListWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|currentItemChanged|currentRowChanged|currentTextChanged' +
    ItemEvents + '|itemSelectionChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtListWidget.HandlerInfo(const Event: string): string;
begin
  if Event = 'currentItemChanged' then
    Result := 'QListWidgetItem, QListWidgetItem;current, previous'
  else if Event = 'currentRowChanged' then
    Result := 'int;currentRow'
  else if Event = 'currentTextChanged' then
    Result := 'QString;currentText'
  else if Pos(Event, ItemEvents) > 0 then
    Result := 'QListWidgetItem;item'
  else
    Result := inherited;
end;

procedure TQtListWidget.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clear')
  else if Parametertypes = 'QListWidgetItem, QAbstractItemView' then
    Slots.Add(Name + '.scrollToItem');
  inherited;
end;

procedure TQtListWidget.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QListWidget');
  SetAttribute('Items', GetItems, '');
end;

procedure TQtListWidget.SetItems(Values: TStrings);
begin
  FItems.Assign(Values);
  Invalidate;
end;

function TQtListWidget.GetItems: string;
var
  Str: string;
begin
  Str := '[';
  for var I := 0 to FItems.Count - 1 do
    Str := Str + AsString(FItems[I]) + ', ';
  Delete(Str, Length(Str) - 1, 2);
  Result := Str + ']';
end;

procedure TQtListWidget.Paint;
var
  Str: string;
  Rect1, Rect2: TRect;
  RowHeight, ColumnWidth: Integer;
begin
  inherited;
  Rect1 := InnerRect;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(Rect1);
  RowHeight := Canvas.TextHeight('A') + 2 * HalfX;

  Rect1.Inflate(-FSpacing, -FSpacing);
  if FFlow = TopToBottom then
  begin
    Rect1.Bottom := Rect1.Top + RowHeight;
    for var I := 0 to FItems.Count - 1 do
    begin
      if AlternatingRowColors and (I mod 2 = 1) then
      begin
        Canvas.Brush.Color := $F5F5F5;
        Canvas.FillRect(Rect1);
      end;
      if I = FCurrentRow then
      begin
        Canvas.Brush.Color := $FFE8CD;
        Canvas.FillRect(Rect1);
      end;
      Rect2 := Rect1;
      Rect2.Inflate(-HalfX, -HalfX);
      Str := FItems[I];
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2, DT_LEFT);
      Rect1.Offset(0, RowHeight + 2 * FSpacing);
      if Rect1.Top > Height then
      begin
        PaintAScrollbar(False);
        if FSpacing > 0 then
        begin
          Rect1 := Rect(Width - 1 - 16 - FSpacing, 1, Width - 1 - 16,
            Height - 1);
          Canvas.Brush.Color := clWhite;
          Canvas.FillRect(Rect1);
        end;
        Break;
      end;
    end;
  end
  else
  begin
    for var I := 0 to FItems.Count - 1 do
    begin
      Str := FItems[I];
      ColumnWidth := Canvas.TextWidth(Str) + 2 * HalfX;
      Rect1.Right := Rect1.Left + ColumnWidth;
      if AlternatingRowColors and (I mod 2 = 1) then
      begin
        Canvas.Brush.Color := $F5F5F5;
        Canvas.FillRect(Rect1);
      end;
      if I = FCurrentRow then
      begin
        Canvas.Brush.Color := $FFE8CD;
        Canvas.FillRect(Rect1);
      end;
      Rect2 := Rect1;
      Rect2.Inflate(-HalfX, -HalfX);
      Rect2.Top := (Rect2.Bottom - Rect2.Top - RowHeight) div 2;
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2, DT_LEFT);
      Rect1.Offset(ColumnWidth + 2 * FSpacing, 0);
      if Rect1.Left > Width then
      begin
        PaintAScrollbar(True);
        if FSpacing > 0 then
        begin
          Rect1 := Rect(1, Height - 1 - 16 - FSpacing, Width - 1,
            Height - 1 - 16);
          Canvas.Brush.Color := clWhite;
          Canvas.FillRect(Rect1);
        end;
        Break;
      end;
    end;
  end;
end;

{ --- TQtColumnView ------------------------------------------------------------ }

constructor TQtColumnView.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 117;
  Width := 256;
  Height := 104;
  FrameShadow := Sunken;
  FItems := TStringList.Create;
  FItems.Text :=
    'First'#13#10'  node A'#13#10'  node B'#13#10'Second'#13#10'   node C'#13#10'    node D';
end;

destructor TQtColumnView.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TQtColumnView.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|ResizeGripsVisible|Items';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtColumnView.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Items' then
    MakeItems
  else
    inherited;
end;

procedure TQtColumnView.DeleteWidget;
begin
  inherited;
  Partner.DeleteItems(Name, 'Item');
end;

function TQtColumnView.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|updatePreviewWidget';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtColumnView.HandlerInfo(const Event: string): string;
begin
  if Event = 'updatePreviewWidget' then
    Result := 'QModelIndex;index'
  else
    Result := inherited;
end;

procedure TQtColumnView.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QColumnView');
  InsertValue('self.' + Name + '.setModel(QStandardItemModel())');
  MakeItems;
end;

procedure TQtColumnView.MakeItems;
var
  Int, LeftSpac, Indent: Integer;
  Str: string;

  function Itemname(Indent: Integer): string;
  begin
    Result := 'self.' + Name + 'Item' + IntToStr(Indent);
  end;

  function MakeNode(Indent: Integer; Value: string): string;
  begin
    Result := Surround(Itemname(Indent) + ' = QStandardItem(' +
      AsString(Value) + ')');
  end;

  function AppendNode(Indent: Integer): string;
  begin
    Result := Surround(Itemname(Indent - 1) + '.appendRow(' +
      Itemname(Indent) + ')');
  end;

begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteItems(Name, 'Item');
  FormatItems(FItems);
  Str := Surround('self.' + Name + 'Item0 = self.' + Name +
    '.model().invisibleRootItem()');
  Indent := 0;
  Int := 0;
  while Int < Items.Count do
  begin
    LeftSpac := LeftSpaces(Items[Int], 2) div 2 + 1;
    if LeftSpac < Indent then
    begin // close open items
      while Indent > LeftSpac do
      begin
        Str := Str + AppendNode(Indent);
        Dec(Indent);
      end;
      Dec(Int);
    end
    else if LeftSpac > Indent then
    begin
      Inc(Indent);
      Str := Str + MakeNode(Indent, Trim(Items[Int]));
    end
    else
    begin
      Str := Str + AppendNode(Indent);
      Str := Str + MakeNode(Indent, Trim(Items[Int]));
    end;
    Inc(Int);
  end;
  while Indent > 0 do
  begin
    Str := Str + AppendNode(Indent);
    Dec(Indent);
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TQtColumnView.InnerRect: TRect;
begin
  Result := inherited;
  Result.Bottom := Result.Bottom - 16;
  Result.Right := Result.Right - 16;
end;

procedure TQtColumnView.Paint;
var
  Str: string;
  Rect1, Rect2: TRect;
  TextHeight: Integer;
  Points: array [1 .. 3] of TPoint;
begin
  inherited;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(inherited InnerRect);
  // items
  TextHeight := Canvas.TextHeight('A');
  Rect1 := InnerRect;
  Rect1.Inflate(-HalfX, -HalfX);
  Rect1.Right := Rect1.Right - 16;
  Rect2 := Rect1;
  Str := '';
  for var I := 0 to FItems.Count - 1 do
  begin
    Str := FItems[I];
    if LeftSpaces(Str, 2) = 0 then
    begin
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2, DT_LEFT);
      if (I + 1 < FItems.Count) and (LeftSpaces(FItems[I + 1], 2) > 0) then
      begin
        Canvas.Brush.Color := Canvas.Pen.Color;
        Points[1] := Point(Rect2.Right + 8, Rect2.Top + 2);
        Points[2] := Point(Rect2.Right + 8, Rect2.Top + 8);
        Points[3] := Point(Rect2.Right + 11, Rect2.Top + 5);
        Canvas.Polygon(Points);
        Canvas.Brush.Color := clWhite;
      end;
      Rect2.Offset(0, TextHeight);
      if Rect2.Top > Rect1.Bottom then
        Break;
    end;
  end;
  // scrollbars
  if Width <= 256 then
    PaintAScrollbar(True);
  Rect2 := ClientRect;
  Rect2.Inflate(-1, -1);
  Rect2.Left := Rect2.Right - 16;
  Rect2.Bottom := Rect2.Bottom - 2 * 16;
  PaintScrollbar(Rect2, False);
  // mover
  Rect2.Bottom := Rect2.Bottom + 16;
  Rect2.Top := Rect2.Bottom - 16;
  Rect2.Right := Rect2.Right - 8;
  Canvas.Brush.Color := $D2D2D2;
  Canvas.FillRect(Rect2);
  Canvas.MoveTo(Rect2.Right - 2, Rect2.Top + 3);
  Canvas.LineTo(Rect2.Right - 2, Rect2.Bottom - 3);
  Canvas.MoveTo(Rect2.Right + 4, Rect2.Top + 3);
  Canvas.LineTo(Rect2.Right + 4, Rect2.Bottom - 3);
end;

procedure TQtColumnView.SetResizeGripsVisible(Value: Boolean);
begin
  if Value <> FResizeGripsVisible then
  begin
    FResizeGripsVisible := Value;
    Invalidate;
  end;
end;

procedure TQtColumnView.SetItems(Value: TStrings);
begin
  if Value <> FItems then
  begin
    FItems.Assign(Value);
    Invalidate;
  end;
end;

{ --- TQtTableView ------------------------------------------------------------- }

constructor TQtTableView.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 119;
  Width := 256;
  Height := 104;
  FrameShadow := Sunken;
  FShowGrid := True;
  FGridStyle := SolidLine;
  FWordWrap := True;
  FCornerButtonEnabled := True;
  FHeaderHorzVisible := True;
  FHeaderVertVisible := True;
  FColumnWidth := 100;
  FRowHeight := 30;
end;

function TQtTableView.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|ShowGrid|GridStyle|SortingEnabled|WordWrap|CornerButtonEnabled' +
    '|HeaderHorzVisible|HeaderVertVisible' + '|ColumnWidth|RowHeight';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTableView.SetAttribute(const Attr, Value, Typ: string);
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

procedure TQtTableView.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.resizeColumnsToContents');
    Slots.Add(Name + '.resizeRowsToContents');
    Slots.Add(Name + '.toggle');
  end
  else if Parametertypes = 'int' then
  begin
    Slots.Add(Name + '.hideColumn');
    Slots.Add(Name + '.hideRow');
    Slots.Add(Name + '.resizeColumnToContents');
    Slots.Add(Name + '.resizeRowToContents');
    Slots.Add(Name + '.selectColumn');
    Slots.Add(Name + '.selectRow');
    Slots.Add(Name + '.showColumn');
    Slots.Add(Name + '.showRow');
  end
  else if Parametertypes = 'bool' then
    Slots.Add(Name + '.setShowGrid')
  else if Parametertypes = 'int, SortOrder' then // ToDo Qt.SortOrder
    Slots.Add(Name + '.sortByColumn');
  inherited;
end;

procedure TQtTableView.NewWidget(const Widget: string = '');
begin
  if Widget = '' then
  begin
    inherited NewWidget('QTableView');
    InsertValue('self.' + Name + '.setModel(QStandardItemModel())');
  end
  else
    inherited NewWidget('QTableWidget');
end;

procedure TQtTableView.MakeHeaderVisible(const Attr, Value: string);
var
  Key: string;
begin
  if Attr = 'HorizontalHeaderVisible' then
    Key := 'self.' + Name + '.horizontalHeader'
  else
    Key := 'self.' + Name + '.verticalHeader';
  SetAttributValue(Key, Key + '().setVisible(' + Value + ')');
end;

procedure TQtTableView.MakeColumWidth(const Value: string);
begin
  var
  Key := 'self.' + Name + '.horizontalHeader().setDefaultSectionSize';
  SetAttributValue(Key, Key + '(' + Value + ')');
end;

procedure TQtTableView.MakeRowHeight(const Value: string);
begin
  var
  Key := 'self.' + Name + '.verticalHeader().setDefaultSectionSize';
  SetAttributValue(Key, Key + '(' + Value + ')');
end;

procedure TQtTableView.SetHeaderHorzVisible(Value: Boolean);
begin
  if Value <> FHeaderHorzVisible then
  begin
    FHeaderHorzVisible := Value;
    Invalidate;
  end;
end;

procedure TQtTableView.SetHeaderVertVisible(Value: Boolean);
begin
  if Value <> FHeaderVertVisible then
  begin
    FHeaderVertVisible := Value;
    Invalidate;
  end;
end;

procedure TQtTableView.SetColumnWidth(Value: Integer);
begin
  if Value <> FColumnWidth then
  begin
    FColumnWidth := Value;
    Invalidate;
  end;
end;

procedure TQtTableView.SetRowHeight(Value: Integer);
begin
  if Value <> FRowHeight then
  begin
    FRowHeight := Value;
    Invalidate;
  end;
end;

procedure TQtTableView.SetShowGrid(Value: Boolean);
begin
  if Value <> FShowGrid then
  begin
    FShowGrid := Value;
    Invalidate;
  end;
end;

procedure TQtTableView.SetGridStyle(Value: TGridStyle);
begin
  if Value <> FGridStyle then
  begin
    FGridStyle := Value;
    Invalidate;
  end;
end;

{ --- TQtTableWidget ----------------------------------------------------------- }

constructor TQtTableWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 89;
  FRowCount := 2;
  FColumnCount := 4;
  FItems := TStringList.Create;
  FItems.Text := 'A B C D'#13#10'1 2 3 4';
  FHeaderHorz := TStringList.Create;
  FHeaderHorz.Text :=
    'Column 1'#13#10'Column 2'#13#10'Column 3'#13#10'Column 4'#13#10'Column 5';
  FHeaderVert := TStringList.Create;
  FHeaderVert.Text :=
    'Row 1'#13#10'Row 2'#13#10'Row 3'#13#10'Row 4'#13#10'Row 5';
end;

destructor TQtTableWidget.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FHeaderHorz);
  FreeAndNil(FHeaderVert);
  inherited;
end;

function TQtTableWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|RowCount|ColumnCount|Items|HeaderHorz|HeaderVert';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTableWidget.SetAttribute(const Attr, Value, Typ: string);
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
  EventsItems = '|itemActivated|itemChanged|itemClicked|itemDoubleClicked|' +
    '|itemEntered|itemPressed';
  EventsTabOther =
    '|currentCellChanged|currentItemChanged|itemSelectionChanged';

function TQtTableWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := EventsRowCol + EventsItems + EventsTabOther;
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtTableWidget.HandlerInfo(const Event: string): string;
begin
  if Event = 'currentCellChanged' then
    Result := 'int, int, int, int;currentRow, currentColumn, previousRow, previousColumn'
  else if Event = 'currentItemChanged' then
    Result := 'QTableWidgetItem, QTableWidgetItem;current, previous'
  else if Pos(Event, EventsRowCol) > 0 then
    Result := 'int, int;row, column'
  else if Pos(Event, EventsItems) > 0 then
    Result := 'QTableWidgetItem;item'
  else
    Result := inherited;
end;

procedure TQtTableWidget.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.clearContents');
  end
  else if Parametertypes = 'int' then
  begin
    Slots.Add(Name + '.insertColumn');
    Slots.Add(Name + '.insertRow');
    Slots.Add(Name + '.removeColumn');
    Slots.Add(Name + '.removeRow');
  end
  else if Parametertypes = 'QTableWidgetItem, QAbstractItemView' then
    Slots.Add(Name + '.scrollToItem(');
  inherited;
end;

procedure TQtTableWidget.MakeItems;
var
  Posi, XPos, YPos: Integer;
  Str, Str1: string;

  function insertItem(Str: string): string;
  begin
    Result := Surround('self.' + Name + '.setItem(' + IntToStr(XPos) + ', ' +
      IntToStr(YPos) + ', QTableWidgetItem(' + AsString(Str) + '))');
  end;

begin
  Str1 := '';
  for XPos := 0 to FItems.Count - 1 do
  begin
    YPos := 0;
    Str := FItems[XPos];
    Posi := Pos(' ', Str);
    while Posi > 0 do
    begin
      Str1 := Str1 + insertItem(Copy(Str, 1, Posi - 1));
      Delete(Str, 1, Posi);
      Inc(YPos);
      Posi := Pos(' ', Str);
    end;
    if Str <> '' then
      Str1 := Str1 + insertItem(Str);
  end;
  InsertValue(Str1);
end;

procedure TQtTableWidget.MakeHorizontalHeader;
var
  Key, Str: string;
begin
  Str := '';
  for var I := 0 to FHeaderHorz.Count - 1 do
    if Trim(FHeaderHorz[I]) <> '' then
      Str := Str + ', ' + AsString(FHeaderHorz[I]);
  Delete(Str, 1, 2);
  if Str = '' then
    Partner.DeleteAttribute('self.' + Name + '.setHorizontalHeaderLabels')
  else
  begin
    Key := 'self.' + Name + '.setHorizontalHeaderLabels';
    SetAttributValue(Key, Key + '([' + Str + '])');
  end;
end;

procedure TQtTableWidget.MakeVerticalHeader;
var
  Key, Str: string;
begin
  Str := '';
  for var I := 0 to FHeaderVert.Count - 1 do
    if Trim(FHeaderVert[I]) <> '' then
      Str := Str + ', ' + AsString(FHeaderVert[I]);
  Delete(Str, 1, 2);
  if Str = '' then
    Partner.DeleteAttribute('self.' + Name + '.setVerticalHeaderLabels')
  else
  begin
    Key := 'self.' + Name + '.setVerticalHeaderLabels';
    SetAttributValue(Key, Key + '([' + Str + '])');
  end;
end;

procedure TQtTableWidget.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QTableWidget');
  SetAttribute('RowCount', '2', '');
  SetAttribute('ColumnCount', '4', '');
  MakeHorizontalHeader;
  MakeVerticalHeader;
  MakeItems;
end;

procedure TQtTableWidget.Paint;
var
  Str, Str1: string;
  Rect1, Rect2: TRect;
  Posi, TextHeight, TextWidth, YPos, XPos, MaxY, MaxX: Integer;
  ShowVerticalScrollbar, ShowHorizontalScrollbar: Boolean;
begin
  inherited;
  ShowVerticalScrollbar := False;
  ShowHorizontalScrollbar := False;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(InnerRect);
  TextHeight := HalfX + Canvas.TextHeight('A') + HalfX;
  TextWidth := Canvas.TextWidth('1');

  // vertical header
  if HeaderVertVisible then
  begin
    for YPos := 1 to RowCount do
      if YPos <= HeaderVert.Count then
        TextWidth := Max(TextWidth, Canvas.TextWidth(HeaderVert[YPos - 1]))
      else
        TextWidth := Max(TextWidth, Canvas.TextWidth(IntToStr(YPos)));
    TextWidth := TextWidth + 4 * HalfX;
  end
  else
    TextWidth := 0;
  if not HeaderHorzVisible then
    TextHeight := 0;

  Rect1 := Rect(1, 1 + TextHeight, 1 + TextWidth, 1 + TextHeight + FRowHeight);
  MaxY := RowCount;
  for YPos := 1 to RowCount do
  begin
    if (YPos <= HeaderVert.Count) and (Trim(HeaderVert[YPos - 1]) <> '') then
      Str := HeaderVert[YPos - 1]
    else
      Str := IntToStr(YPos);
    if HeaderVertVisible then
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect1,
        DT_CENTER + DT_VCENTER + DT_SINGLELINE);
    Rect1.Offset(0, FRowHeight);
    if Rect1.Top > Height then
    begin
      ShowVerticalScrollbar := True;
      MaxY := YPos;
      Break;
    end;
  end;

  // horizontal header
  Rect1 := Rect(1 + TextWidth, 1, 1 + TextWidth + FColumnWidth, 1 + TextHeight);
  MaxX := ColumnCount;
  for XPos := 1 to ColumnCount do
  begin
    if (XPos <= HeaderHorz.Count) and (Trim(HeaderHorz[XPos - 1]) <> '') then
      Str := HeaderHorz[XPos - 1]
    else
      Str := IntToStr(XPos);
    if HeaderHorzVisible then
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect1,
        DT_CENTER + DT_VCENTER + DT_SINGLELINE);
    Rect1.Offset(FColumnWidth, 0);
    if Rect1.Left > Width then
    begin
      ShowHorizontalScrollbar := True;
      MaxX := XPos;
      Break;
    end;
  end;

  // cells
  Rect1 := Rect(1 + TextWidth, 1 + TextHeight,
    Min(1 + TextWidth + MaxX * FColumnWidth, Width - 1),
    1 + TextHeight + FRowHeight);
  for YPos := 1 to MaxY do
  begin
    if AlternatingRowColors and (YPos mod 2 = 0) then
    begin
      Canvas.Brush.Color := $F5F5F5;
      if Rect1.Bottom >= Height then
        Rect1.Bottom := Height - 1;
      Canvas.FillRect(Rect1);
    end;
    if YPos <= FItems.Count then
      Str := FItems[YPos - 1]
    else
      Break;
    Rect2 := Rect1;
    Rect2.Right := Rect2.Left + FColumnWidth;
    Rect2.Inflate(-HalfX, -HalfX);
    Posi := Pos(' ', Str);
    while Posi > 0 do
    begin
      Str1 := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
      Posi := Pos(' ', Str);
      DrawText(Canvas.Handle, PChar(Str1), Length(Str1), Rect2,
        DT_LEFT + DT_VCENTER + DT_SINGLELINE);
      Rect2.Offset(FColumnWidth, 0);
      if Rect2.Left > Width then
        Break;
    end;
    DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2,
      DT_LEFT + DT_VCENTER + DT_SINGLELINE);
    Rect1.Offset(0, FRowHeight);
  end;

  // grid
  Canvas.Pen.Color := $D8D8D8;
  if (FGridStyle <> NoPen) and FShowGrid then
  begin
    case FGridStyle of
      NoPen:
        Canvas.Pen.Style := psClear;
      SolidLine:
        Canvas.Pen.Style := psSolid;
      DashLine:
        Canvas.Pen.Style := psDash;
      DotLine:
        Canvas.Pen.Style := psDot;
      DashDotLine:
        Canvas.Pen.Style := psDashDot;
      DashDotDotLine:
        Canvas.Pen.Style := psDashDotDot;
      CustomDashLine:
        Canvas.Pen.Style := psSolid;
    end;
    for YPos := 0 to MaxY do
    begin
      Canvas.MoveTo(TextWidth, TextHeight + YPos * FRowHeight);
      Canvas.LineTo(TextWidth + MaxX * FColumnWidth,
        TextHeight + YPos * FRowHeight);
    end;
    for XPos := 0 to MaxX do
    begin
      Canvas.MoveTo(TextWidth + XPos * FColumnWidth, 1);
      Canvas.LineTo(TextWidth + XPos * FColumnWidth,
        TextHeight + MaxY * FRowHeight);
    end;
    Canvas.Pen.Style := psSolid;
  end;
  PaintScrollbars(ShowHorizontalScrollbar, ShowVerticalScrollbar);
end;

procedure TQtTableWidget.SetRowCount(Value: Integer);
begin
  if Value <> FRowCount then
  begin
    FRowCount := Value;
    Invalidate;
  end;
end;

procedure TQtTableWidget.SetColumnCount(Value: Integer);
begin
  if Value <> FColumnCount then
  begin
    FColumnCount := Value;
    Invalidate;
  end;
end;

procedure TQtTableWidget.SetItems(Value: TStrings);
begin
  if Value <> FItems then
  begin
    FItems.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtTableWidget.SetHeaderHorz(Value: TStrings);
begin
  if Value <> FHeaderHorz then
  begin
    FHeaderHorz.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtTableWidget.SetHeaderVert(Value: TStrings);
begin
  if Value <> FHeaderVert then
  begin
    FHeaderVert.Assign(Value);
    Invalidate;
  end;
end;

{ --- TQtTreeView -------------------------------------------------------------- }

constructor TQtTreeView.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 118;
  Width := 256;
  Height := 104;
  FrameShadow := Sunken;
  FAutoExpandDelay := -1;
  FIndentation := 20;
  FItemsExpandable := True;
  FExpandsOnDoubleClick := True;
  FColumnWidth := 100;
end;

function TQtTreeView.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Indentation|SortingEnabled|HeaderHidden|ColumnWidth';
  if ShowAttributes >= 2 then
    Result := Result + '|AutoExpandDelay|RootIsDecorated|UniformRowHeights' +
      '|ItemsExpandable|Animated|AllColumnsShowFocus|WordWrap|ExpandsOnDoubleClick';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTreeView.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'ColumnWidth' then
    MakeColumWidth(Value)
  else
    inherited;
end;

const
  TVEvents = '|collapsed|expanded';

function TQtTreeView.GetEvents(ShowEvents: Integer): string;
begin
  Result := TVEvents + inherited GetEvents(ShowEvents);
end;

function TQtTreeView.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, TVEvents) > 0 then
    Result := 'QModelIndex;index'
  else
    Result := inherited;
end;

procedure TQtTreeView.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.collapseAll');
    Slots.Add(Name + '.expandAll');
  end
  else if Parametertypes = 'QModelIndex' then
  begin
    Slots.Add(Name + '.collapse');
    Slots.Add(Name + '.expand');
  end
  else if Parametertypes = 'QModelIndex, int' then
    Slots.Add(Name + '.expandRecursively')
  else if Parametertypes = 'int' then
  begin
    Slots.Add(Name + '.expandToDepth');
    Slots.Add(Name + '.hideColumn');
    Slots.Add(Name + '.resizeColumnToContents');
    Slots.Add(Name + '.showColumn');
  end
  else if Parametertypes = 'int, SortOrder' then // ToDo
    Slots.Add(Name + '.sortByColumn');
  inherited;
end;

procedure TQtTreeView.NewWidget(const Widget: string = '');
begin
  if Widget = '' then
  begin
    inherited NewWidget('QTreeView');
    InsertValue('self.' + Name + '.setModel(QStandardItemModel())');
  end
  else
    inherited NewWidget('QTreeWidget');
end;

procedure TQtTreeView.MakeColumWidth(const Value: string);
begin
  var
  Key := 'self.' + Name + '.header().setDefaultSectionSize';
  SetAttributValue(Key, Key + '(' + Value + ')');
end;

procedure TQtTreeView.SetColumnWidth(Value: Integer);
begin
  if Value <> FColumnWidth then
  begin
    FColumnWidth := Value;
    Invalidate;
  end;
end;

procedure TQtTreeView.SetHeaderHidden(Value: Boolean);
begin
  if Value <> FHeaderHidden then
  begin
    FHeaderHidden := Value;
    Invalidate;
  end;
end;

procedure TQtTreeView.SetIndentation(Value: Integer);
begin
  if Value <> FIndentation then
  begin
    FIndentation := Value;
    Invalidate;
  end;
end;

{ --- TQtTreeWidget ------------------------------------------------------------ }

constructor TQtTreeWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 88;
  FColumnCount := 3;
  FItems := TStringList.Create;
  FItems.Text :=
    'First, F2, F3'#13#10'  node A, A2, A3'#13#10'  node B'#13#10'Second'#13#10'   node C'#13#10'    node D, D2';
  FHeader := TStringList.Create;
  FHeader.Text := 'Column 1'#13#10'Column 2'#13#10'Column 3';
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

function TQtTreeWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|ColumnCount|Items|Header';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTreeWidget.SetAttribute(const Attr, Value, Typ: string);
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

function TQtTreeWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := EventsItemCol + EventsTableItems + EventsTableOther;
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtTreeWidget.HandlerInfo(const Event: string): string;
begin
  if Event = 'currentItemChanged' then
    Result := 'QTreeWidgetItem, QTreeWidgetItem;current, previous'
  else if Pos(Event, EventsTableItems) > 0 then
    Result := 'QTreeWidgetItem;item'
  else if Pos(Event, EventsItemCol) > 0 then
    Result := 'QTreeWidgetItem, int;item, column'
  else
    Result := inherited;
end;

procedure TQtTreeWidget.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clear')
  else if Parametertypes = 'QTreeWidgetItem ' then
  begin
    Slots.Add(Name + '.collapseItem');
    Slots.Add(Name + '.expandItem');
  end
  else if Parametertypes = 'QTreeWidgetItem, QAbstractItemView' then
    Slots.Add(Name + '.scrollToItem');
  inherited;
end;

procedure TQtTreeWidget.MakeItems;
var
  Int, LeftSpac, Indent: Integer;
  Str: string;

  function Itemname(Indent: Integer): string;
  begin
    if Indent = -1 then
      Result := 'self.' + Name
    else
      Result := 'self.' + Name + 'Item' + IntToStr(Indent);
  end;

  function MakeNode(Indent: Integer; Value: string): string;
  var
    Posi, Col: Integer;
  begin
    Result := Surround(Itemname(Indent) + ' = QTreeWidgetItem(' +
      Itemname(Indent - 1) + ')');
    Col := 0;
    Posi := Pos(',', Value);
    while Posi > 0 do
    begin
      Result := Result + Surround(Itemname(Indent) + '.setText(' + IntToStr(Col)
        + ', ' + AsString(Copy(Value, 1, Posi - 1)) + ')');
      Delete(Value, 1, Posi);
      Value := Trim(Value);
      Posi := Pos(',', Value);
      Inc(Col);
    end;
    Result := Result + Surround(Itemname(Indent) + '.setText(' + IntToStr(Col) +
      ', ' + AsString(Value) + ')');
  end;

begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteItems(Name, 'Item');
  FormatItems(FItems);
  Indent := 0;
  Str := '';
  Int := 0;
  while Int < Items.Count do
  begin
    LeftSpac := LeftSpaces(Items[Int], 2) div 2;
    if LeftSpac < Indent then
    begin // close open items
      while LeftSpac < Indent do
        Dec(Indent);
      Dec(Int);
    end
    else if LeftSpac > Indent then
    begin
      Inc(Indent);
      Str := Str + MakeNode(Indent, Trim(Items[Int]));
    end
    else
      Str := Str + MakeNode(Indent, Trim(Items[Int]));
    Inc(Int);
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtTreeWidget.MakeHeader;
var
  Key, Str: string;
begin
  Str := '';
  for var I := 0 to FHeader.Count - 1 do
    if Trim(FHeader[I]) <> '' then
      Str := Str + ', ' + AsString(FHeader[I]);
  Delete(Str, 1, 2);
  if Str = '' then
    Partner.DeleteAttribute('self.' + Name + '.setHeaderLabels')
  else
  begin
    Key := 'self.' + Name + '.setHeaderLabels';
    SetAttributValue(Key, Key + '([' + Str + '])');
  end;
end;

procedure TQtTreeWidget.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QTreeWidget');
  MakeHeader;
  MakeItems;
end;

procedure TQtTreeWidget.Paint;
var
  Str: string;
  Rect1, Rect2: TRect;
  Int2, Int4, YPos, XPos, RowHeight: Integer;
  ShowVerticalScrollbar, ShowHorizontalScrollbar: Boolean;
  StringList: TStringList;
begin
  inherited;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(InnerRect);
  RowHeight := HalfX + Canvas.TextHeight('A') + HalfX;
  ShowHorizontalScrollbar := False;
  ShowVerticalScrollbar := False;

  // horizontal header
  Rect1 := Rect(1 + HalfX, 1, FColumnWidth - 1, 1 + RowHeight);
  for var I := 1 to Max(FColumnCount, Header.Count) do
  begin
    if (I <= Header.Count) and (Trim(Header[I - 1]) <> '') then
      Str := Header[I - 1]
    else
      Str := IntToStr(I);
    if not HeaderHidden then
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect1,
        DT_LEFT + DT_VCENTER + DT_SINGLELINE);
    Rect1.Offset(FColumnWidth, 0);
    if Rect1.Left > Width then
    begin
      if HorizontalScrollBarPolicy <> ScrollBarAlwaysOff then
        ShowHorizontalScrollbar := True;
      Break;
    end;
  end;

  // items
  Rect1 := Rect(1 + HalfX + FIndentation, 1 + RowHeight + HalfX,
    FColumnWidth - 1, 1 + 2 * RowHeight + HalfX);
  for var I := 0 to FItems.Count - 1 do
  begin
    Str := FItems[I];
    if LeftSpaces(Str, 2) = 0 then
    begin
      if AlternatingRowColors and (I mod 2 = 1) then
      begin
        Rect2 := Rect1;
        Rect2.Bottom := Rect2.Top + RowHeight;
        Rect2.Right := ClientRect.Right - 1;
        Canvas.Brush.Color := $F5F5F5;
        Canvas.FillRect(Rect2);
      end;
      StringList := Split(',', Str);
      Str := Trim(StringList[0]);
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect1, DT_LEFT);
      Rect2 := Rect1;
      Rect2.Left := Rect2.Left - FIndentation;
      for var J := 1 to StringList.Count - 1 do
      begin
        Rect2.Offset(FColumnWidth, 0);
        Str := Trim(StringList[J]);
        DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2, DT_LEFT);
      end;
      FreeAndNil(StringList);
      if (I + 1 < FItems.Count) and (LeftSpaces(FItems[I + 1], 2) > 0) then
      begin
        Canvas.Brush.Color := Canvas.Pen.Color;
        Canvas.Pen.Width := 2;
        XPos := FIndentation div 2;
        YPos := Rect1.Top + RowHeight div 2 - 2;
        Int2 := PPIScale(2);
        Int4 := PPIScale(4);
        Canvas.MoveTo(XPos - Int2, YPos - Int4);
        Canvas.LineTo(XPos + Int2, YPos);
        Canvas.LineTo(XPos - Int2, YPos + Int4);
        Canvas.Brush.Color := clWhite;
      end;
      Rect1.Offset(0, RowHeight);
      if Rect1.Top > Height then
      begin
        if VerticalScrollBarPolicy <> ScrollBarAlwaysOff then
          ShowVerticalScrollbar := True;
        Break;
      end;
    end;
  end;

  // scrollbars
  Canvas.Pen.Width := 1;
  PaintScrollbars(ShowHorizontalScrollbar, ShowVerticalScrollbar);
end;

procedure TQtTreeWidget.SetColumnCount(Value: Integer);
begin
  if Value <> FColumnCount then
  begin
    FColumnCount := Value;
    Invalidate;
  end;
end;

procedure TQtTreeWidget.SetHeader(Value: TStrings);
begin
  if Value <> FHeader then
  begin
    FHeader.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtTreeWidget.SetItems(Value: TStrings);
begin
  if Value <> FItems then
  begin
    FItems.Assign(Value);
    Invalidate;
  end;
end;

end.
