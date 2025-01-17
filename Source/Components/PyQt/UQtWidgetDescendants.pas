{-------------------------------------------------------------------------------
 Unit:     UQtWidgetDescendants
 Author:   Gerhard Röhner
 Date:     July 2022
 Purpose:  PyQt simple widgets
-------------------------------------------------------------------------------}
unit UQtWidgetDescendants;

{ classes
    TQtLineEdit
    TQtComboBox
      TQtFontComboBox
    TQtProgressBar
    TQtStatusBar
    TQtGroupBox
    TQtTabWidget
    TQtMenuBar
    TQtMenu
    TQtButtonGroup
    TQtMainWindow
}

interface

uses
  Windows, Graphics, Classes, UBaseQtWidgets;

type

  TEchoMode = (Normal, NoEcho, Password, PasswordEchoOnEdit);

  TCursorMoveStyle = (LogicalMoveStyle, VisualMoveStyle);

  TInsertPolicy = (NoInsert, InsertAtTop, InsertAtCurrent,
                   InsertAtBottom, InsertAfterCurrent,
                   InsertBeforeCurrent, InsertAlphabetically);

  TSizeAdjustPolicy = (AdjustToContents, AdjustToContentsOnFirstShow,
                       AdjustToMinimumContentsLength,
                       AdjustToMinimumContentsLengthWithIcon);

  TTextDirection = (TopToBottom, BottomToTop);

  TWritingSystem = (Any, Latin, Greek, Cyrillic, Armenian, Hebrew, Arabic,
                    SimplifiedChinese, Symbol, Other);

  TFontFilters = (AllFonts, ScalableFonts, NonScalableFonts, MonospacedFonts,
                  ProportionalFonts);

  TSetOfFontFilters = set of TFontFilters;

  TTabPosition = (North, South, West, East);

  TTabShape = (Rounded, Triangular);

  TQtLineEdit = class(TBaseQtWidget)
  private
    FInputMask: string;
    FText: string;
    FMaxLength: Integer;
    FFrame: Boolean;
    FEchoMode: TEchoMode;
    FCursorPosition: Integer;
    FAligment: string;
    FDragEnabled: Boolean;
    FReadOnly: Boolean;
    FPlaceholderText: string;
    FCursorMoveStyle: TCursorMoveStyle;
    FClearButtonEnabled: Boolean;
    FCursorPositionChanged: string;
    FEditingFinished: string;
    FInputRejected: string;
    FReturnPressed: string;
    FSelectionChanged: string;
    FTextChanged: string;
    FTextEdited: string;
    procedure setText(Value: string);
    procedure setPlaceholderText(Value: string);
    procedure setEchoMode(Value: TEchoMode);
    procedure setFrame(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property InputMask: string read FInputMask write FInputMask;
    property Text: string read FText write setText;
    property MaxLength: Integer read FMaxLength write FMaxLength;
    property Frame: Boolean read FFrame write setFrame;
    property EchoMode: TEchoMode read FEchoMode write setEchoMode;
    property CursorPosition: Integer read FCursorPosition write FCursorPosition;
    property Aligment: string read FAligment write FAligment;
    property DragEnabled: Boolean read FDragEnabled write FDragEnabled;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property PlaceholderText: string read FPlaceholderText write setPlaceholderText;
    property CursorMoveStyle: TCursorMoveStyle read FCursorMoveStyle write FCursorMoveStyle;
    property ClearButtonEnabled: Boolean read FClearButtonEnabled write FClearButtonEnabled;
    // signals
    property cursorPositionChanged: string read FCursorPositionChanged write FCursorPositionChanged;
    property editingFinished: string read FEditingFinished write FEditingFinished;
    property inputRejected: string read FInputRejected write FInputRejected;
    property returnPressed: string read FReturnPressed write FReturnPressed;
    property selectionChanged: string read FSelectionChanged write FSelectionChanged;
    property textChanged: string read FTextChanged write FTextChanged;
    property textEdited: string read FTextEdited write FTextEdited;
  end;

  TQtComboBox = class(TBaseQtWidget)
  private
    FEditable: Boolean;
    FCurrentText: string;
    FCurrentIndex: Integer;
    FMaxVisibleItems: Integer;
    FMaxCount: Integer;
    FInsertPolicy: TInsertPolicy;
    FSizeAdjustPolicy: TSizeAdjustPolicy;
    FMinimumContentsLength: Integer;
    FPlaceholderText: string;
    FDuplicatesEnabled: Boolean;
    FFrame: Boolean;
    FModelColumn: Integer;
    FListItems: TStrings;
    FActivated: string;
    FCurrentIndexChanged: string;
    FCurrentTextChanged: string;
    FEditTextChanged: string;
    FHighlighted: string;
    FTextActivated: string;
    FTextHighlighted: string;
    procedure setListItems(Values: TStrings);
    function getListItems: string;
    procedure setCurrentText(Value: string);
    procedure setPlaceholderText(Value: string);
    procedure setEditable(Value: Boolean);
    procedure setFrame(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Editable: Boolean read FEditable write setEditable;
    property CurrentText: string read FCurrentText write setCurrentText;
    property CurrentIndex: Integer read FCurrentIndex write FCurrentIndex;
    property MaxVisibleItems: Integer read FMaxVisibleItems write FMaxVisibleItems;
    property MaxCount: Integer read FMaxCount write FMaxCount;
    property InsertPolicy: TInsertPolicy read FInsertPolicy write FInsertPolicy;
    property SizeAdjustPolicy: TSizeAdjustPolicy read FSizeAdjustPolicy write FSizeAdjustPolicy;
    property MinimumContentsLength: Integer read FMinimumContentsLength write FMinimumContentsLength;
    property PlaceholderText: string read FPlaceholderText write setPlaceholderText;
    property DuplicatesEnabled: Boolean read FDuplicatesEnabled write FDuplicatesEnabled;
    property Frame: Boolean read FFrame write setFrame;
    property ModelColumn: Integer read FModelColumn write FModelColumn;
    property ListItems: TStrings read FListItems write setListItems;
    // signals
    property activated: string read FActivated write FActivated;
    property currentIndexChanged: string read FCurrentIndexChanged write FCurrentIndexChanged;
    property currentTextChanged: string read FCurrentTextChanged write FCurrentTextChanged;
    property editTextChanged: string read FEditTextChanged write FEditTextChanged;
    property highlighted: string read FHighlighted write FHighlighted;
    property textActivated: string read FTextActivated write FTextActivated;
    property textHighlighted: string read FTextHighlighted write FTextHighlighted;
  end;

  TQtFontComboBox = class(TQtComboBox)
  private
    FWritingSystem: TWritingSystem;
    FFontFilters: TSetOfFontFilters;
    FCurrentFont: TFont;
    FCurrentFontChanged: string;
    procedure setCurrentFont(Value: TFont);
    procedure MakeFontFilters;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    procedure MakeFont; override;
  published
    property WritingSystem: TWritingSystem read FWritingSystem write FWritingSystem;
    property FontFilters: TSetOfFontFilters read FFontFilters write FFontFilters;
    property CurrentFont: TFont read FCurrentFont write setCurrentFont;
    // signals
    property currentFontChanged: string read FCurrentFontChanged write FCurrentFontChanged;
  end;

  TQtProgressbar = class(TBaseQtWidget)
  private
    FMinimum: Integer;
    FMaximum: Integer;
    FValue: Integer;
    FTextVisible: Boolean;
    FOrientation: TOrientation;
    FInvertedAppearance: Boolean;
    // FTextDirection: TTextDirection; no text for vertical progressbar for windows
    FFormat: string;
    // Signals
    FValueChanged: string;
    procedure setMinimum(Value: Integer);
    procedure setMaximum(Value: Integer);
    procedure setValue(Value: Integer);
    procedure setTextVisible(Value: Boolean);
    procedure setOrientation(Value: TOrientation);
    procedure setInvertedAppearance(Value: Boolean);
    procedure setFormat(Value: string);
    function getText: string;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    function InnerRect: TRect; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Minimum: Integer read FMinimum write setMinimum;
    property Maximum: Integer read FMaximum write setMaximum;
    property Value: Integer read FValue write setValue;
    property TextVisible: Boolean read FTextVisible write setTextVisible;
    property Orientation: TOrientation read FOrientation write setOrientation;
    property InvertedAppearance: Boolean read FInvertedAppearance write setInvertedAppearance;
    property Format: string read FFormat write setFormat;
    // signals
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtStatusbar = class(TBaseQtWidget)
  private
    FSizeGripEnabled: Boolean;
    FMessageChanged: string;
    procedure setSizeGripEnabled(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  published
    property SizeGripEnabled: Boolean read FSizeGripEnabled write setSizeGripEnabled;
    // signals
    property messageChanged: string read FMessageChanged write FMessageChanged;
  end;

  TQtGroupBox = class(TBaseQtWidget)
  private
    FTitle: string;
    //FAligmnent
    FFlat: Boolean;
    FCheckable: Boolean;
    FChecked: Boolean;
    FClicked: string;
    FToggled: string;
    procedure setTitle(Value: string);
    procedure setFlat(Value: Boolean);
    procedure setCheckable(Value: Boolean);
    procedure setChecked(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Title: string read FTitle write setTitle;
    property Flat: Boolean read FFlat write setFlat;
    property Checkable: Boolean read FCheckable write setCheckable;
    property Checked: Boolean read FChecked write setChecked;
    // signals
    property clicked: string read FClicked write FClicked;
    property toggled: string read FToggled write FToggled;
  end;

  TQtTabWidget = class(TBaseQtWidget)
  private
    FTabPosition: TTabPosition;
    FTabShape: TTabShape;
    FCurrentIndex: Integer;
    FUsesScrollButtons: Boolean;
    FDocumentMode: Boolean;
    FTabsClosable: Boolean;
    FMoveable: Boolean;
    FTabBarAutoHide: Boolean;
    FTabs: TStrings;
    FCurrentChanged: string;
    FTabBarClicked: string;
    FTabBarDoubleClicked: string;
    FTabCloseRequested: string;
    procedure setTabPosition(Value: TTabPosition);
    procedure setTabShape(Value: TTabShape);
    procedure setCurrentIndex(Value: Integer);
    procedure setTabs(Value: TStrings);
    procedure MakeTabs;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteWidget; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property TabPosition: TTabPosition read FTabPosition write setTabPosition;
    property TabShape: TTabShape read FTabShape write setTabShape;
    property CurrentIndex: Integer read FCurrentIndex write setCurrentIndex;
    property UsesScrollButtons: Boolean read FUsesScrollButtons write FUsesScrollButtons;
    property DocumentMode: Boolean read FDocumentMode write FDocumentMode;
    property TabsClosable: Boolean read FTabsClosable write FTabsClosable;
    property Moveable: Boolean read FMoveable write FMoveable;
    property TabBarAutoHide: Boolean read FTabBarAutoHide write FTabBarAutoHide;
    property Tabs: TStrings read FTabs write setTabs;
    // signals
    property currentChanged: string read FCurrentChanged write FCurrentChanged;
    property tabBarClicked: string read FTabBarClicked write FTabBarClicked;
    property tabBarDoubleClicked: string read FTabBarDoubleClicked write FTabBarDoubleClicked;
    property tabCloseRequested: string read FTabCloseRequested write FTabCloseRequested;
  end;

  TQtMenuBar = class(TBaseQtWidget)
  private
    FMenuItems: TStrings;
    FHovered: string;
    FTriggered: string;
    procedure setItems(aItems: TStrings);
    procedure MakeMenuItems;
    function hasSubMenu(MenuItems: TStrings; i: Integer): Boolean;
    function makeMenuName(m, s: string): string;
    procedure CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings); virtual;
    function getCreateMenu: string; virtual;
  public
    MenuItemsOld: TStrings;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NewWidget(Widget: string = ''); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure Rename(const OldName, NewName, Events: string); override;
    procedure SetPositionAndSize; override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  published
    property MenuItems: TStrings read FMenuItems write setItems;
    // signals
    property hovered: string read FHovered write FHovered;
    property triggered: string read FTriggered write FTriggered;
  end;

  TQtMenu = class(TQtMenuBar)
  public
    constructor Create(AOwner: TComponent); override;
    procedure DeleteWidget; override;
    function getCreateMenu: string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  end;

  TQtButtonGroup = class (TBaseQtWidget)
  private
    FColumns: Integer;
    FTitle: string;
    FItems: TStrings;
    FOldItems: TStrings;
    FCheckboxes: Boolean;
    FbuttonClicked: string;
    FbuttonPressed: string;
    FbuttonReleased: string;
    FbuttonToggled: string;
    FidClicked: string;
    FidPressed: string;
    FidReleased: string;
    FidToggled: string;
    procedure setColumns(Value: Integer);
    procedure setTitle(Value: string);
    procedure setItems(Value: TStrings);
    procedure setCheckboxes(Value: Boolean);
    procedure MakeButtongroupItems;
    procedure MakeTitle(Title: string);
    function ItemsInColumn(i: Integer): Integer;
    function RBName(i: Integer): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteWidget; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    procedure setEvent(Attr: string); override;
    function HandlerInfo(const event: string): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
    function MakeBinding(Eventname: string): string; override;
    procedure Rename(const OldName, NewName, Events: string); override;
  published
    property Items: TStrings read fItems write setItems; // must stay before columns or label
    property Columns: Integer read FColumns write setColumns;
    property Title: string read FTitle write setTitle;
    property Checkboxes: Boolean read FCheckboxes write setCheckboxes;
    // signals
    property buttonClicked: string read FbuttonClicked write FbuttonClicked;
    property buttonPressed: string read FbuttonPressed write FbuttonPressed;
    property buttonReleased: string read FbuttonReleased write FbuttonReleased;
    property buttonToggled: string read FbuttonToggled write FbuttonToggled;
    property idClicked: string read FidClicked write FidClicked;
    property idPressed: string read FidPressed write FidPressed;
    property idReleased: string read FidReleased write FidReleased;
    property idToggled: string read FidToggled write FidToggled;
  end;

  TQtMainWindow = class (TBaseQtWidget)
  public
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    function HandlerName(const event: string): string; override;
  end;

implementation

uses Controls, SysUtils, Math, Types, UITypes, JvGnugettext,
     frmPyIDEMain, UGUIDesigner, UUtils;

{--- TQtLineEdit --------------------------------------------------------------}

constructor TQtLineEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 72;
  Width:= 80;
  Height:= 24;
  FocusPolicy:= StrongFocus;
  ContextMenuPolicy:= DefaultContextMenu;
  Cursor:= crIBeam;
  MouseTracking:= True;
  FMaxLength:= 32767;
  FFrame:= True;
end;

function TQtLineEdit.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|EchoMode|InputMask|Text|PlaceholderText';
  if ShowAttributes >= 2 then
    Result:= Result + '|Frame|ReadOnly|ClearButtonEnabled';
  if ShowAttributes = 3 then
    Result:= Result + '|MaxLength|CursorPosition|Alignment|DragEnabled|CursorMoveStyle';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtLineEdit.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'EchoMode'  then
    MakeAttribut(Attr, 'QLineEdit.EchoMode.' + Value)
  else if Attr = 'CursorMoveStyle' then
    MakeAttribut(Attr, 'Qt.CursorMoveStyle.' + Value)
  else
    inherited;
end;

function TQtLineEdit.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|cursorPositionChanged|editingFinished|inputRejected' +
           '|returnPressed|selectionChanged|textChanged|textEdited';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtLineEdit.HandlerInfo(const event: string): string;
begin
  if event = 'cursorPositionChanged' then
    Result:= 'int, int;oldPos, newPos'
  else if Pos('text', event) = 1 then
    Result:= 'QString;text'
  else
    Result:= inherited;
end;

procedure TQtLineEdit.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.copy');
    Slots.Add(Name + '.cut');
    Slots.Add(Name + '.paste');
    Slots.Add(Name + '.redo');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.undo');
  end else if Parametertypes = 'QString' then
    Slots.Add(Name + '.setText');
  inherited;
end;

procedure TQtLineEdit.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QLineEdit')
end;

procedure TQtLineEdit.Paint;
  var R: TRect; s: string;
begin
  inherited;
  if FFrame
    then Canvas.Pen.Color:= $7A7A7A
    else Canvas.Pen.Color:= clWhite;
  Canvas.Brush.Color:= clWhite;
  Canvas.Rectangle(ClientRect);

  R:= ClientRect;
  R.Left:= 2;
  R.Right:= R.Right - 2;
  if FClearButtonEnabled then
    R.Right:= R.Right - PPIScale(28);
  R.Top:= (Height - Canvas.TextHeight('Hg')) div 2;

  if FText <> '' then begin
    case FEchoMode of
      Normal: s:= FText;
      NoEcho: s:= '';
      Password,
      PasswordEchoOnEdit: s:= StringOfChar('*', Length(FText));
    end;
  end else if FPlaceholderText <> '' then begin
    Canvas.Font.Color:= $7F7F7F;
    s:= FPlaceholderText;
  end;
  if s <> '' then
    DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_LEFT);
  if FClearButtonEnabled then
    FGUIDesigner.vilQtControls1616.Draw(Canvas, R.Right + 8, (R.Height - FGUIDesigner.vilQtControls1616.Height) div 2, 4);
end;

procedure TQtLineEdit.setText(Value: string);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TQtLineEdit.setPlaceholderText(Value: string);
begin
  if Value <> FPlaceholderText then begin
    FPlaceholderText:= Value;
    Invalidate;
  end;
end;

procedure TQtLineEdit.setEchoMode(Value: TEchoMode);
begin
  if Value <> FEchoMode then begin
    FEchoMode:= Value;
    Invalidate;
  end;
end;

procedure TQtLineEdit.setFrame(Value: Boolean);
begin
  if Value <> FFrame then begin
    FFrame:= Value;
    Invalidate;
  end;
end;

{--- TQtComboBox --------------------------------------------------------------}

constructor TQtComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 78;
  Width:= 80;
  Height:= 24;
  FocusPolicy:= WheelFocus;
  ContextMenuPolicy:= DefaultContextMenu;
  FMaxVisibleItems:= 10;
  FMaxCount:= 2147483647;
  FInsertPolicy:= InsertAtBottom;
  FSizeAdjustPolicy:= AdjustToContentsOnFirstShow;
  FFrame:= True;
  FCurrentIndex:= -1;
  FListItems:= TStringList.Create;
  FListItems.Text:= defaultItems;
end;

destructor TQtComboBox.Destroy;
begin
  FreeAndNil(FListItems);
  inherited;
end;

function TQtComboBox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|CurrentText|CurrentIndex|PlaceholderText|ListItems|Editable';
  if ShowAttributes >= 2 then
    Result:= Result + '|Frame|InsertPolicy|DuplicatesEnabled';
  if ShowAttributes = 3 then
    Result:= Result + '|MaxVisibleItems|MaxCount|SizeAdjustPolicy' +
                      '|MinimumContentsLength|ModelColumn';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtComboBox.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'ListItems' then begin
    var s:= 'self.' + Name  + '.setModel';
    setAttributValue(s, s + '(QStringListModel(' + getListItems + '))');
  end else if (Attr = 'InsertPolicy') or (Attr = 'SizeAdjustPolicy') then
    MakeAttribut(Attr, 'QComboBox.' + Attr + '.' + Value)
  else
    inherited;
end;

const
  EventsWithIndex = '|activated|currentIndexChanged|highlighted';
  EventsWithText = '|currentTextChanged|editTextChanged|textActivated|textHighlighted';

function TQtComboBox.getEvents(ShowEvents: Integer): string;
begin
  Result:= EventsWithIndex + EventsWithText;
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtComboBox.HandlerInfo(const event: string): string;
begin
  if Pos(event, EventsWithIndex) > 0 then
    Result:= 'int;index'
  else if Pos(Event, EventsWithText) > 0 then
    Result:= 'QString;text'
  else
    inherited;
end;

procedure TQtComboBox.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.clearEditText');
  end else if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QString' then begin
    Slots.Add(Name + '.setCurrentText');
    Slots.Add(Name + '.setEditText');
  end;
  inherited;
end;

procedure TQtComboBox.NewWidget(Widget: string = '');
begin
  if Widget = '' then begin
    inherited NewWidget('QComboBox');
    setAttribute('ListItems', '[''A'', ''B'', ''C'']', '');
  end else
    inherited NewWidget('QFontComboBox');
end;

procedure TQtComboBox.Paint;
  var R: TRect; s: string; x, y: Integer;
begin
  inherited;
  if FFrame
    then Canvas.Pen.Color:= $7A7A7A
    else Canvas.Pen.Color:= clWhite;
  if FEditable
    then Canvas.Brush.Color:= clWhite
    else Canvas.Brush.Color:= $E1E1E1;
  Canvas.Rectangle(ClientRect);

  if FCurrentText <> ''
    then s:= FCurrentText
  else if FListItems.Count > 0 then
    s:= FListItems[0];
  if s = '' then
    s:= FPlaceholderText;

  R:= InnerRect;
  R.Top:= (R.Bottom - R.Top - Canvas.TextHeight('A')) div 2;
  R.Left:= R.Left + HalfX;
  R.Right:= R.Right - PPIScale(18);
  DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_LEFT);

  x:= Width - PPIScale(14);
  y:= Height div 2 - 2;
  var i3:= PPIScale(3);
  var i4:= PPIScale(4);
  var i5:= PPIScale(5);
  var i8:= PPIScale(8);
  var i10:= PPIScale(10);
  Canvas.Pen.Color:= $F1F1F1;
  Canvas.MoveTo(x, y);
  Canvas.LineTo(x + i4, y + i4);
  Canvas.LineTo(x + i5, y + i4);
  Canvas.LineTo(x + i10, y - 1);

  Canvas.Pen.Color:= $5C5C5C;
  x:= x + 1;
  Canvas.MoveTo(x, y);
  Canvas.LineTo(x + i3, y + i3);
  Canvas.LineTo(x + i4, y + i3);
  Canvas.LineTo(x + i8, y - 1);

  y:= y - 1;
  Canvas.Pen.Color:= $ADADAD;
  Canvas.MoveTo(x, y);
  Canvas.LineTo(x + i3, y + i3);
  Canvas.LineTo(x + i4, y + i3);
  Canvas.LineTo(x + i8, y - 1);
end;

procedure TQtComboBox.setListItems(Values: TStrings);
begin
  FListItems.Assign(Values);
  Invalidate;
end;

function TQtComboBox.getListItems: string;
  var s: string; i: Integer;
begin
  s:= '[';
  for i:= 0 to FListItems.Count -1 do
    s:= s + asString(FListItems[i]) + ', ';
  Delete(s, Length(s) - 1, 2);
  Result:= s + ']';
end;

procedure TQtComboBox.setCurrentText(Value: string);
begin
  if Value <> FCurrentText then begin
    FCurrentText:= Value;
    Invalidate;
  end;
end;

procedure TQtComboBox.setPlaceholderText(Value: string);
begin
  if Value <> FPlaceholderText then begin
    FPlaceholderText:= Value;
    Invalidate;
  end;
end;

procedure TQtComboBox.setEditable(Value: Boolean);
begin
  if Value <> FEditable then begin
    FEditable:= Value;
    Invalidate;
  end;
end;

procedure TQtComboBox.setFrame(Value: Boolean);
begin
  if Value <> FFrame then begin
    FFrame:= Value;
    Invalidate;
  end;
end;

{--- TQtFontComboBox ----------------------------------------------------------}

constructor TQtFontComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 105;
  Width:= 144;
  Height:= 24;
  FCurrentFont:= TFont.Create;
  FCurrentFont.Assign(Font);
  Editable:= True;
  ListItems.Text:= '';
end;

destructor TQtFontComboBox.Destroy;
begin
  inherited;
  FreeAndNil(FCurrentFont);
end;

function TQtFontComboBox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|WritingSystem|FontFilters|CurrentFont';
  Result:= Result + inherited getAttributes(ShowAttributes);
  var p:= Pos('|CurrentText|CurrentIndex|PlaceholderText|ListItems', Result);
  if p > 0 then Delete(Result, p, 51);
end;

procedure TQtFontComboBox.setAttribute(Attr, Value, Typ: string);
begin
  if Typ = 'TSetOfFontFilters' then
    MakeFontFilters
  else if (Attr = 'CurrentFont') or (Pos(Attr, ' Name Size Bold Italic ') > 0) then
    MakeFont
  else if Attr = 'WritingSystem' then
    MakeAttribut(Attr, 'QFontDatabase.WritingSystem.' + Value)
  else
    inherited;
end;

function TQtFontComboBox.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|currentFontChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtFontComboBox.HandlerInfo(const event: string): string;
begin
  if event = 'currentFontChanged' then
    Result:= 'QFont;font'
  else
    Result:= inherited;
end;

procedure TQtFontComboBox.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'QFont' then
    Slots.Add(Name + '.setCurrentFont');
  inherited;
end;

procedure TQtFontComboBox.MakeFont;
  var s1, s2: string;
begin
  if Name = '' then Exit;

  s1:= 'self.' + Name + '.setCurrentFont';
  s2:= '(QFont(' + asString(FCurrentFont.Name) + ', ' + IntToStr(FCurrentFont.Size);
  if fsBold   in FCurrentFont.Style then
    s2:= s2 + ', QFont.Weight.Bold';
  if fsItalic in FCurrentFont.Style then
    s2:= s2 + ', italic=True';
  s2:= s2 + '))';
  setAttributValue(s1, s1 + s2);
  s1:= 'self.' + Name + '.currentFont().setUnderline';
  if fsUnderline in FCurrentFont.Style
    then setAttributValue(s1, s1 + '(True)')
    else Partner.DeleteAttribute(s1);
  s1:= 'self.' + Name + '.currentFont().setStrikeOut';
  if fsStrikeout in FCurrentFont.Style
    then setAttributValue(s1, s1 + '(True)')
    else Partner.DeleteAttribute(s1);
  Invalidate;
end;

procedure TQtFontComboBox.MakeFontFilters;
begin
  var s:= '';
  if AllFonts in FFontFilters then
    s:= s + '|QFontComboBox.AllFonts';
  if ScalableFonts in FFontFilters then
    s:= s + '|QFontComboBox.ScalableFonts';
  if NonScalableFonts in FFontFilters then
    s:= s + '|QFontComboBox.NonScalableFonts';
  if MonospacedFonts in FFontFilters then
    s:= s + '|QFontComboBox.MonospacedFonts';
  if ProportionalFonts in FFontFilters then
    s:= s + '|QFontComboBox.ProportionalFonts';
  if s = '' then
    s:= '|QFontComboBox.AllFonts';
  Delete(s, 1, 1);
  setAttribute('FontFilters', s, '');
end;

procedure TQtFontComboBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QFontComboBox');
end;

procedure TQtFontComboBox.Paint;
begin
  CurrentText:= FCurrentFont.Name;
  inherited;
end;

procedure TQtFontComboBox.setCurrentFont(Value: TFont);
begin
  if Value <> FCurrentFont then begin
    FCurrentFont.assign(Value);
    Invalidate;
  end;
end;

{--- TQtProgressBar -----------------------------------------------------------}

constructor TQtProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 90;
  Width:= 120;
  Height:= 24;
  FMinimum:= 0;
  FMaximum:= 100;
  FValue:= 24;
  FTextVisible:= True;
  FOrientation:= Horizontal;
  FFormat:= '%p%';
end;

function TQtProgressBar.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Minimum|Maximum|Value|';
  if ShowAttributes >= 2 then
    Result:= Result + '|TextVisible|Orientation|InvertedAppearance|Format';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtProgressBar.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'TextDirection' then
    MakeAttribut(Attr, 'QProgressBar.' + Value)
  else if Attr = 'Orientation' then
    MakeAttribut(Attr, 'Qt.Orientation.' + Value)
  else
    inherited;
end;

function TQtProgressBar.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|valueChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtProgressBar.HandlerInfo(const event: string): string;
begin
  if event = 'valueChanged' then
    Result:= 'int;value'
  else
    Result:= inherited;
end;

procedure TQtProgressBar.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then begin
    Slots.Add(Name + '.setMaximum');
    Slots.Add(Name + '.setMinimum');
    Slots.Add(Name + '.setValue');
  end else if Parametertypes = '' then
    Slots.Add(Name + '.reset')
  else if Parametertypes = 'int, int' then
    Slots.Add(Name + '.setRange');
  inherited;
end;

function TQtProgressBar.InnerRect: TRect;
begin
  Result:= inherited;
  if FTextVisible and (FOrientation = Horizontal) and (FMinimum < FMaximum) then
    Result.Right:= Result.Right - Canvas.TextWidth(getText);
end;

procedure TQtProgressBar.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QProgressBar');
  setAttribute('Value', '24', '');
end;

procedure TQtProgressBar.Paint;
  var x, y: Integer; R: TRect; s: string;
begin
  inherited;
  Canvas.Pen.Color:= $BCBCBC;
  Canvas.Brush.Color:= $E6E6E6;
  R:= InnerRect;
  Canvas.Rectangle(R);

  if (FValue < FMinimum) or (FValue > FMaximum) or (FMaximum <= FMinimum) then
    Exit;

  // draw text
  if FTextVisible and (FOrientation = Horizontal) then begin
    var R2:= ClientRect;
    R2.inflate(-1, -1);
    R2.Left:= R.Right + 1;
    s:= getText;
    Canvas.Brush.Color:= clBtnFace;
    DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_CENTER+DT_VCENTER+DT_SINGLELINE);
  end;

  // draw visible progress
  if FOrientation = horizontal then begin
    x:= Round((R.Right - R.Left) * (FValue - FMinimum) / (FMaximum - FMinimum));
    if FInvertedAppearance
      then R.Left:= R.Right - x
      else R.Right:= R.Left + x;
  end else begin
    y:= Round((R.Bottom - R.Top) * (FValue - FMinimum) / (FMaximum - FMinimum));
    if InvertedAppearance
      then R.Bottom:= R.Top + y
      else R.Top:= R.Bottom - y;
  end;
  Canvas.Brush.Color:= $25B006;
  Canvas.FillRect(R);
end;

function TQtProgressBar.getText: string;
  var s: string; p: Integer;
begin
  s:= FFormat;
  p:= Pos('%p', s);
  if p > 0 then begin
    Delete(s, p, 2);
    insert(IntToStr(Round(0.5 + (FValue - FMinimum)/(FMaximum - FMinimum)*100)), s, p);
  end;
  p:= Pos('%v', s);
  if p > 0 then begin
    Delete(s, p, 2);
    insert(IntToStr(FValue), s, p);
  end;
  p:= Pos('%m', s);
  if p > 0 then begin
    Delete(s, p, 2);
    insert(IntToStr(FMaximum - FMinimum), s, p);
  end;
  Result:= '  ' + s + '  ';
end;

procedure TQtProgressBar.setMinimum(Value: Integer);
begin
  if Value <> FMinimum then begin
    FMinimum:= Value;
    Invalidate;
  end;
end;

procedure TQtProgressBar.setMaximum(Value: Integer);
begin
  if Value <> FMaximum then begin
    FMaximum:= Value;
    Invalidate;
  end;
end;

procedure TQtProgressBar.setValue(Value: Integer);
begin
  if Value <> FValue then begin
    FValue:= Value;
    Invalidate;
  end;
end;

procedure TQtProgressBar.setTextVisible(Value: Boolean);
begin
  if Value <> FTextVisible then begin
    FTextVisible:= Value;
    Invalidate;
  end;
end;

procedure TQtProgressBar.setOrientation(Value: TOrientation);
  var h: Integer;
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

procedure TQtProgressBar.setInvertedAppearance(Value: Boolean);
begin
  if Value <> FInvertedAppearance then begin
    FInvertedAppearance:= Value;
    Invalidate;
  end;
end;

procedure TQtProgressBar.setFormat(Value: string);
begin
  if Value <> FFormat then begin
    FFormat:= Value;
    Invalidate;
  end;
end;

{--- TQtStatusBar -------------------------------------------------------------}

constructor TQtStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 91;
  Width:= 100;
  Height:= 20;
end;

function TQtStatusBar.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|SizeGripEnabled';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TQtStatusBar.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|messageChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtStatusBar.HandlerInfo(const event: string): string;
begin
  if event = 'messageChanged' then
    Result:= 'QString;message'
  else
    Result:= inherited;
end;

procedure TQtStatusBar.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clearMessage')
  else if Parametertypes = 'QString, int' then
    Slots.Add(Name + '.showMessage');
  inherited;
end;

procedure TQtStatusBar.NewWidget(Widget: string = '');
begin
  InsertValue('self.statusBar()');
end;

procedure TQtStatusBar.DeleteWidget;
begin
  Partner.DeleteAttribute('self.statusBar');
end;

procedure TQtStatusBar.Paint;
  var R: TRect; p3: Integer;
begin
  setBounds(0, Parent.ClientHeight-PPIScale(21), Parent.ClientWidth, PPIScale(21));
  inherited;
  R:= Rect(Width - PPIScale(12), Height - PPIScale(5), Width - PPIScale(10), Height - PPIScale(3));
  Canvas.Brush.Color:= $BFBFBF;
  Canvas.FillRect(R);
  p3:= PPIScale(3);
  R.Offset(p3, 0);
  Canvas.FillRect(R);
  R.Offset(p3, 0);
  Canvas.FillRect(R);
  R.Offset(0, -p3);
  Canvas.FillRect(R);
  R.Offset(0, -p3);
  Canvas.FillRect(R);
  R.Offset(-p3, p3);
  Canvas.FillRect(R);
end;

procedure TQtStatusBar.SetPositionAndSize;
begin
  // do nothing
end;

procedure TQtStatusBar.setSizeGripEnabled(Value: Boolean);
begin
  if Value <> FSizeGripEnabled then begin
    FSizeGripEnabled:= Value;
    Invalidate;
  end;
end;

{--- TQtGroupBox --------------------------------------------------------------}

constructor TQtGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 83;
  Width:= 120;
  Height:= 80;
  FTitle:= 'GroupBox';
  ControlStyle := [csAcceptsControls];
end;

function TQtGroupBox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Title|Flat|Checkable|Checked';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TQtGroupBox.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|clicked|toggled';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtGroupBox.HandlerInfo(const event: string): string;
begin
  if event = 'clicked' then
    Result:= 'bool;checked'
  else if Result = 'toggled' then
    Result:= 'bool;on'
  else
    Result:= inherited;
end;

procedure TQtGroupBox.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then
    Slots.Add(Name + '.setChecked');
  inherited;
end;

procedure TQtGroupBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QGroupBox');
  setAttribute('Title', 'GroupBox', 'Text');
end;

procedure TQtGroupBox.Paint;
  var R: TRect; x: Integer;
begin
  inherited;
  Canvas.Pen.Color:= $DCDCDC;
  Canvas.Brush.Color:= $F0F0F0;
  R:= ClientRect;
  Canvas.FillRect(R);
  R.Top:= R.Top + Canvas.TextHeight('A') div 2;
  Canvas.Brush.Color:= $DCDCDC;
  Canvas.FrameRect(R);

  if FCheckable then begin
    Canvas.Pen.Color:= $333333;
    Canvas.Brush.Color:= clWhite;
    R:= Rect(9, 1, 22, 14);
    Canvas.Rectangle(R);
    if FChecked then begin
      Canvas.Pen.Color:= $222222;
      Canvas.MoveTo(11, 7);
      Canvas.LineTo(14, 10);
      Canvas.LineTo(19, 4);
    end;
    x:= 28;
  end else
    x:= 8;
  Canvas.Brush.Color:= $F0F0F0;
  R:= ClientRect;
  R.Left:= x;
  DrawText(Canvas.Handle, PChar(FTitle), Length(FTitle), R, DT_LEFT);
end;

procedure TQtGroupBox.setTitle(Value: string);
begin
  if Value <> FTitle then begin
    FTitle:= Value;
    Invalidate;
  end;
end;

procedure TQtGroupBox.setFlat(Value: Boolean);
begin
  if Value <> FFlat then begin
    FFlat:= Value;
    Invalidate;
  end;
end;

procedure TQtGroupBox.setCheckable(Value: Boolean);
begin
  if Value <> FCheckable then begin
    FCheckable:= Value;
    Invalidate;
  end;
end;

procedure TQtGroupBox.setChecked(Value: Boolean);
begin
  if Value <> FChecked then begin
    FChecked:= Value;
    Invalidate;
  end;
end;

{--- TQtTabWidget -------------------------------------------------------------}

constructor TQtTabWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 87;
  Width:= 160;
  Height:= 80;
  FTabs:= TStringList.Create;
  FTabs.Text:= 'Tab 1'#13#10'Tab 2'#13#10'Tab 3'#13#10;
  FTabPosition:= North;
  FTabShape:= Rounded;
  FUsesScrollButtons:= True;
end;

destructor TQtTabWidget.Destroy;
begin
  FreeAndNil(FTabs);
  inherited;
end;

procedure TQtTabWidget.DeleteWidget;
begin
  inherited;
  Partner.DeleteItems(Name, 'Page');
end;

function TQtTabWidget.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|TabPosition|TabShape|CurrentIndex|Tabs';
  if ShowAttributes >= 2 then
    Result:= Result + '|UsesScrollButtons|DocumentMode|TabsClosable|Movable|TabBarAutoHide';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtTabWidget.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'TabPosition') or (Attr = 'TabShape') then
    MakeAttribut(Attr, 'QTabWidget.' + Attr + '.' + Value)
  else if Attr = 'Tabs' then
    MakeTabs
  else
    inherited;
end;

const
  TabEvents = '|currentChanged|tabBarClicked|tabBarDoubleClicked|tabCloseRequested';

function TQtTabWidget.getEvents(ShowEvents: Integer): string;
begin
  Result:= TabEvents + inherited getEvents(ShowEvents);
end;

function TQtTabWidget.HandlerInfo(const event: string): string;
begin
  if Pos(event, TabEvents) > 0 then
    Result:= 'int;index'
  else
    Result:= inherited;
end;

procedure TQtTabWidget.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QWidget' then
    Slots.Add(Name + '.setCurrentWidget');
  inherited;
end;

procedure TQtTabWidget.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QTabWidget');
  MakeTabs;
end;

procedure TQtTabWidget.MakeTabs;
  var i: Integer; pagename, s: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteAttributeValues('self.' + Name + '.addTab');
  Partner.DeleteItems(Name, 'Page');
  s:= '';
  for i:= 1 to FTabs.Count do begin
    pagename:= 'self.' + Name + 'Page' + IntToStr(i);
    s:= s + surround(pagename + ' = QLabel()');
    s:= s + surround(pagename + '.setText(''Add widgets to this page'')');
    s:= s + surround('self.' + Name + '.addTab(' + pagename + ', ' + asString(FTabs[i-1]) + ')');
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtTabWidget.Paint;
  const paddingH = 12;
  var th, tw, i, x1, y1, RowHeight, x1Curr, x2Curr, y1Curr, y2Curr: Integer;
      Points: array[0..3] of TPoint;

  function ShowHorTab(x1, y1: Integer; const s: string; TopCorner: Boolean): Integer;
    var dx, dy: Integer; R: TRect;
  begin
    tw:= Canvas.TextWidth(s);
    dx:= Min(tw + 2*paddingH, Width-2);
    dy:= th + 2*HalfX;

    if (i = FCurrentIndex) or ((i = 0) and (FCurrentIndex = -1)) then begin
      if TopCorner then
        y1:= y1 - 2;
      dy:= dy + 2;
      x1Curr:= x1;
      x2Curr:= x1 + dx;
    end;

    if FTabShape = Rounded then begin
      R:= Rect(x1, y1, x1 + dx, y1 + dy);
      Canvas.Rectangle(R);
    end else begin
      if TopCorner then begin
        Points[0]:= Point(x1, y1 + dy);
        Points[1]:= Point(x1 + 7, y1);
        Points[2]:= Point(x1 + dx - 7, y1);
        Points[3]:= Point(x1 + dx, y1 + dy);
      end else begin
        Points[0]:= Point(x1, y1);
        Points[1]:= Point(x1 + 7, y1 + dy);
        Points[2]:= Point(x1 + dx - 7, y1 + dy);
        Points[3]:= Point(x1 + dx, y1);
      end;
      Canvas.Polygon(Points);
    end;
    Canvas.TextOut(x1 + paddingH, y1 + HalfX, s);
    Result:= x1 + dx;
  end;

  function ShowVerTab(x1, y1: Integer; const s: string; LeftCorner: Boolean): Integer;
    var dy, dx, tw: Integer; R: TRect;
  begin
    tw:= Canvas.TextWidth(s);
    dy:= Min(tw + 2*paddingH, Height-2);
    dx:= th + 2*HalfX +2;

    if (i = FCurrentIndex) or ((i = 0) and (FCurrentIndex = -1)) then begin
      if LeftCorner then
        x1:= x1 - 2;
      dx:= dx + 2;
      y1Curr:= y1;
      y2Curr:= y1 + dy;
    end;

    if FTabShape = Rounded then begin
      R:= Rect(x1, y1, x1 + dx, y1 + dy);
      Canvas.Rectangle(R);
    end else begin
      if LeftCorner then begin
        Points[0]:= Point(x1, y1 + 7);
        Points[1]:= Point(x1 + dx, y1);
        Points[2]:= Point(x1 + dx, y1 + dy);
        Points[3]:= Point(x1, y1 + dy - 7);
      end else begin
        Points[0]:= Point(x1, y1);
        Points[1]:= Point(x1 + dx, y1 + 7);
        Points[2]:= Point(x1 + dx, y1 + dy - 7);
        Points[3]:= Point(x1, y1 + dy);

      end;
      Canvas.Polygon(Points);
    end;
    if LeftCorner
      then Canvas.TextOut(x1 + HalfX, y1 + dy - paddingH, s)
      else Canvas.TextOut(x1 + dx - HalfX, y1 + paddingH, s);
    Result:= y1 + dy;
  end;

  procedure SetBrushColor(i: Integer);
  begin
    if (i = FCurrentIndex) or ((i = 0) and (FCurrentIndex = -1))
      then Canvas.Brush.Color:= clWhite //SelectionColor
      else Canvas.Brush.Color:= clBtnFace;
  end;

begin
  inherited;
  Canvas.Pen.Color:= $D9D9D9;
  Canvas.Brush.Color:= clBtnFace;
  Canvas.FillRect(ClientRect);

  th:= Canvas.TextHeight('Hg');
  RowHeight:= th + 2* HalfX;
  if FTabs.Count > 0 then
    case FTabPosition of
      North: begin
        x1:= 2;
        y1:= 2;
        for i:= 0 to FTabs.Count - 1 do begin
          SetBrushColor(i);
          x1:= ShowHorTab(x1, y1, FTabs[i], True);
        end;
        Canvas.Pen.Color:= $A0A0A0;
        y1:= RowHeight + 1;
        Canvas.MoveTo(0, y1);
        Canvas.LineTo(Width, y1);
        Canvas.Pen.Color:= clWhite;
        Canvas.MoveTo(x1Curr, y1);
        Canvas.LineTo(x2Curr, y1);
      end;
      South: begin
        x1:= 2;
        y1:= Height - RowHeight - 1;
        for i:= 0 to FTabs.Count - 1 do begin
          SetBrushColor(i);
          x1:= ShowHorTab(x1, y1, FTabs[i], False);
        end;
        Canvas.Pen.Color:= $A0A0A0;
        y1:= Height - RowHeight - 1;
        Canvas.MoveTo(0, y1);
        Canvas.LineTo(Width, y1);
        Canvas.Pen.Color:= clWhite;
        Canvas.MoveTo(x1Curr, y1);
        Canvas.LineTo(x2Curr, y1);
      end;
      West: begin
        Canvas.Font.Orientation:= 900;
        x1:= 2;
        y1:= 2;
        for i:= 0 to FTabs.Count - 1 do begin
          SetBrushColor(i);
          y1:= ShowVerTab(x1, y1, FTabs[i], True);
        end;
        Canvas.Pen.Color:= $A0A0A0;
        x1:= RowHeight + 3;
        Canvas.MoveTo(x1, 0);
        Canvas.LineTo(x1, Height);
        Canvas.Pen.Color:= clWhite;
        Canvas.MoveTo(x1, y1Curr);
        Canvas.LineTo(x1, y2Curr);
        Canvas.Font.Orientation:= 0;
      end;
      East: begin
        Canvas.Font.Orientation:= -900;
        x1:= Width - RowHeight - 3;
        y1:= 2;
        for i:= 0 to FTabs.Count - 1 do begin
          SetBrushColor(i);
          y1:= ShowVerTab(x1, y1, FTabs[i], False);
        end;
        Canvas.Pen.Color:= $A0A0A0;
        x1:= Width - RowHeight - 3;
        Canvas.MoveTo(x1, 0);
        Canvas.LineTo(x1, Height);
        Canvas.Pen.Color:= clWhite;
        Canvas.MoveTo(x1, y1Curr);
        Canvas.LineTo(x1, y2Curr);
        Canvas.Font.Orientation:= 0;
      end;
  end
  else begin
    Canvas.Brush.Color:= clBtnFace;
    Canvas.Rectangle(Rect(0, 0, Width, Height));
  end;
end;

procedure TQtTabWidget.setTabPosition(Value: TTabPosition);
begin
  if Value <> FTabPosition then begin
    FTabPosition:= Value;
    Invalidate;
  end;
end;

procedure TQtTabWidget.setTabShape(Value: TTabShape);
begin
  if Value <> FTabShape then begin
    FTabShape:= Value;
    Invalidate;
  end;
end;

procedure TQtTabWidget.setCurrentIndex(Value: Integer);
begin
  if Value <> FCurrentIndex then begin
    FCurrentIndex:= Value;
    Invalidate;
  end;
end;

procedure TQtTabWidget.setTabs(Value: TStrings);
begin
  if Value <> FTabs then begin
    FTabs.assign(Value);
    Invalidate;
  end;
end;

{--- TQtMenuBar ---------------------------------------------------------------}

constructor TQtMenuBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 85;
  Width:= 100;
  Height:= 21;
  FMenuItems:= TStringList.Create;
  FMenuItems.text:= 'File'#13#10'  New'#13#10'    Python'#13#10'    XML'#13#10'  Load'#13#10'  Save, Ctrl+S'#13#10 +
                    'Edit'#13#10'  Copy, Ctrl+C'#13#10'  Paste, Ctrl+V'#13#10'  -'#13#10'  Delete'#13#10;
  MenuItemsOld:= TStringList.Create;
end;

destructor TQtMenuBar.Destroy;
begin
  FreeAndNil(FMenuItems);
  FreeAndNil(MenuItemsOld);
  inherited;
end;

function TQtMenuBar.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|MenuItems|Name';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

const MenuBarEvents = '|hovered|triggered';

function TQtMenuBar.getEvents(ShowEvents: Integer): string;
begin
  Result:= MenuBarEvents + inherited getEvents(ShowEvents);
end;

function TQtMenuBar.HandlerInfo(const event: string): string;
begin
  if Pos(event, MenuBarEvents) > 0 then
    Result:= 'QAction;action'
  else
    Result:= inherited;
end;

procedure TQtMenuBar.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then
    Slots.Add(Name + '.setVisible');
  inherited;
end;

procedure TQtMenuBar.NewWidget(Widget: string = '');
begin
  MenuItemsOld.Text:= '';
  MakeMenuItems;
end;

procedure TQtMenuBar.SetPositionAndSize;
begin
  // do nothing
end;

procedure TQtMenuBar.setItems(aItems: TStrings);
begin
  MenuItemsOld.Text:= FMenuItems.Text;
  if aItems.Text <> FMenuItems.Text then
    FMenuItems.Assign(aItems);
end;

procedure TQtMenuBar.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited
end;

function TQtMenuBar.hasSubMenu(MenuItems: TStrings; i: Integer): Boolean;
begin
  Result:= (i < MenuItems.Count - 1) and
           (LeftSpaces(MenuItems[i], 2) < LeftSpaces(MenuItems[i+1], 2));
end;

function TQtMenuBar.makeMenuName(m, s: string): string;
begin
  if Right(m, -4) = 'Menu' then
    m:= Copy(m, 1, Length(m) - 4);
  Result:= m + OnlyCharsAndDigits(s) + 'Menu';
end;

function TQtMenuBar.getCreateMenu: string;
begin
  Result:= Indent2 + 'self.' + Name + ' = self.menuBar()';
end;

procedure TQtMenuBar.CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings);
  var i, MenuIndent, ls, p: Integer;
      s, ts, Shortcut: string;
      MenuName: array[-1..10] of string;
      MenuText: array[-1..10] of string;

  procedure MakeCommand(Indent: Integer);
    var Com: string;
  begin
    if ts = '-' then
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent-1] + '.addSeparator()')
    else begin
      Com:= MenuName[Indent-1];
      Com:= Com + OnlyCharsAndDigits(ts) + 'Command';
      PyMethods.Add(Com + '(self):');
      PyMenu.Add(Indent2 + 'self.' + MenuName[Indent-1] +
                 '.addAction(' + asString(ts) + Shortcut + ', self.' + Com + ')');
    end;
  end;

begin
  MenuName[-1]:= Name;
  MenuText[-1]:= '';
  MenuIndent:= 0;
  // insert new MenuItems
  for i:= 0 to MenuItems.Count - 1 do begin
    s:= MenuItems[i];
    p:= Pos(',', s);
    if p > 0 then begin
      Shortcut:= ', QKeySequence(' + asString(Trim(Copy(s, p+1, Length(s)))) + ')';
      s:= Copy(s, 1, p-1);
    end else
      Shortcut:= '';
    ts:= Trim(s);
    ls:= LeftSpaces(s, 2) div 2;
    if ls < MenuIndent then
      MenuIndent:= ls;
    if ls > MenuIndent then begin
      MakeCommand(MenuIndent);
      Inc(MenuIndent);
    end else if hasSubMenu(MenuItems, i) then begin  // create new menu/submenu
      MenuText[MenuIndent]:= ts;
      MenuName[MenuIndent]:= makeMenuName(MenuName[MenuIndent-1], s);
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent] + ' = self.' + MenuName[MenuIndent-1] + '.addMenu(' + asString(MenuText[MenuIndent]) + ')');
      Inc(MenuIndent);
    end else
      MakeCommand(MenuIndent);
  end;
end;

procedure TQtMenuBar.MakeMenuItems;
  var i: Integer;
      OldMenu: TStringList;
      OldMethods: TStringList;
      NewMenu: TStringList;
      NewMethods: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.ParseAndCreateModel;
  FormatItems(FMenuItems);
  OldMenu:= TStringList.Create;
  OldMethods:= TStringList.Create;
  NewMenu:= TStringList.Create;
  NewMethods:= TStringList.Create;

  CalculateMenus(MenuItemsOld, OldMenu, OldMethods);
  CalculateMenus(FMenuItems, NewMenu, NewMethods);
  Partner.DeleteOldAddNewMethods(OldMethods, NewMethods);

  for i:= 0 to OldMenu.Count - 1 do
    Partner.DeleteLine(OldMenu[i]);
  Partner.DeleteLine(getCreateMenu);
  if NewMenu.Text <> '' then
    Partner.InsertAtBegin(getCreateMenu + CrLf + NewMenu.Text);

  FreeAndNil(OldMenu);
  FreeAndNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtMenuBar.Rename(const OldName, NewName, Events: string);
  var i: Integer;
      OldMenu: TStringList;
      OldMethods: TStringList;
      NewMenu: TStringList;
      NewMethods: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.ParseAndCreateModel;
  OldMenu:= TStringList.Create;
  OldMethods:= TStringList.Create;
  NewMenu:= TStringList.Create;
  NewMethods:= TStringList.Create;
  MenuItemsOld.Text:= FMenuItems.Text;
  Name:= OldName;
  Partner.DeleteLine(getCreateMenu);
  CalculateMenus(MenuItemsOld, OldMenu, OldMethods);
  Name:= NewName;
  CalculateMenus(FMenuItems, NewMenu, NewMethods);
  Partner.DeleteOldAddNewMethods(OldMethods, NewMethods);

  for i:= 0 to OldMenu.Count - 1 do
    Partner.DeleteLine(OldMenu[i]);
  if NewMenu.Text <> '' then
    Partner.InsertAtBegin(getCreateMenu + CrLf + NewMenu.Text);

  FreeAndNil(OldMenu);
  FreeAndNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ReplaceWord(OldName, NewName, True);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtMenuBar.DeleteWidget;
begin
  inherited;
  MenuItemsOld.Text:= FMenuItems.Text;
  FMenuItems.Clear;
  MakeMenuItems;
end;

procedure TQtMenuBar.Paint;
  var s, item: string; i: Integer;
begin
  setBounds(0, 0, Parent.ClientWidth, PPIScale(21));
  inherited;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  s:= '';
  for i:= 0 to FMenuItems.Count - 1 do begin
    item:= FMenuItems[i];
    if (item <> '') and (item[1] <> '-') and (item[1] <> ' ') then
      s:= s + item + '     ';
  end;
  Canvas.TextOut(PPIScale(3), PPIScale(3), s);
end;

{--- TQtMenu -----------------------------------------------------------}

constructor TQtMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 86;
  Width:= 33;
  Height:= 28;
  FMenuItems.Text:= 'Cut, Ctrl+X'#13#10'Copy, Ctrl+C'#13#10'Paste, Ctrl+C'#13#10'-'#13#10+
                    'Delete'#13#10'  All'#13#10'  Selected';
  Sizeable:= False;
end;

procedure TQtMenu.NewWidget(Widget: string = '');
begin
  MenuItemsOld.Text:= '';
  MakeMenuItems;
end;

function TQtMenu.getCreateMenu: string;
begin
  Result:= Indent2 + 'self.' + Name + ' = QMenu()';
end;

procedure TQtMenu.DeleteWidget;
begin
  inherited;
  Partner.DeleteAttribute('self.' + Name + '.actions');
end;

procedure TQtMenu.Paint;
begin
  Canvas.Rectangle(Rect(0, 0, Width, Height));
  PyIDEMainForm.vilTkinterLight.Draw(Canvas, 7, 4, 16);
end;

{--- TQtButtonGroup -----------------------------------------------------------}

constructor TQtButtonGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 76;
  Width:= 120;
  Height:= 80;
  FColumns:= 1;
  FItems:= TStringList.Create;
  FOldItems:= TStringList.Create;
  FTitle:= ' ' + _('Continent') + ' ';
  FCheckboxes:= False;
end;

destructor TQtButtonGroup.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

procedure TQtButtonGroup.DeleteWidget;
begin
  inherited;
  for var i:= 0 to FItems.Count - 1 do
    Partner.DeleteAttributeValues(RBName(i));
  Partner.DeleteAttributeValues('self.' + Name + 'BG');
end;

function TQtButtonGroup.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Columns|Items|Title|Checkboxes';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtButtonGroup.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'Items') or (Attr = 'Checkboxes') then
    MakeButtonGroupItems
  else if Attr = 'Columns' then
    SetPositionAndSize
  else if Attr = 'Title' then
    MakeTitle(Value)
  else if isFontAttribute(Attr) then begin
    if Title <> '' then inherited;
    MakeButtongroupItems;
  end else
    inherited;
end;

function TQtButtonGroup.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|buttonClicked|buttonPressed|buttonReleased|buttonToggled' +
           '|idClicked|idPressed|idReleased|idToggled';
end;

procedure TQtButtonGroup.setEvent(Attr: string);
begin
  if not Partner.hasText('def ' + HandlerNameAndParameter(Attr)) then
    Partner.InsertProcedure(CrLf + MakeHandler(Attr));
  Partner.InsertQtBinding(Name + 'RB', MakeBinding(Attr));
end;

function TQtButtonGroup.HandlerInfo(const event: string): string;
begin
  if event = 'buttonToggled' then
    Result:= 'QAbstractButton, bool;button, checked'
  else if event = 'idToggled' then
    Result:= 'int, bool;id, checked'
  else if Pos('button', event) = 1 then
    Result:= 'QAbstractButton;button'
  else if Pos('id', event) = 1 then
    Result:= 'int;id'
  else
    Result:= inherited;
end;

function TQtButtonGroup.RBName(i: Integer): string;
begin
  Result:= 'self.' + Name + 'RB' + IntToStr(i);
end;

procedure TQtButtonGroup.MakeButtongroupItems;
  var i, p: Integer; s, s1, s2: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  for i:= 0 to FOldItems.Count - 1 do
    Partner.DeleteAttributeValues(RBName(i));
  Partner.DeleteAttribute('self.' + Name + 'BG');
  Partner.DeleteAttribute('self.' + Name + 'BG.setExclusive');
  // don't delete handlers
  s1:= '';
  s2:= surround('self.' + Name + 'BG = QButtonGroup(self)');
  if FCheckboxes
    then s2:= s2 + surround('self.' + Name + 'BG.setExclusive(False)')
    else s2:= s2 + surround('self.' + Name + 'BG.setExclusive(True)');
  for i:= 0 to FItems.Count - 1 do begin
    s:= FItems[i];
    p:= Pos(', ' + _('selected'), s);
    if p > 0
      then s:= asString(Copy(s, 1, p-1))
      else s:= asString(s);
    if FCheckboxes
      then s1:= s1 + surround(RBName(i) + ' = QCheckBox(' + s + ', self.' + Name + ')')
      else s1:= s1 + surround(RBName(i) + ' = QRadioButton(' + s + ', self.' + Name + ')');
    s1:= s1 + surround(RBName(i) + '.setGeometry(0, 0, 0, 0)');
    s2:= s2 + surround('self.' + Name + 'BG.addButton(' + RBName(i) + ')');
    s2:= s2 + surround('self.' + Name + 'BG.setId(' + RBName(i) + ', ' + IntToStr(i) + ')');
  end;
  insertValue(s1 + s2);
  FOldItems.Text:= FItems.Text;
  setPositionAndSize;
  Partner.ActiveSynEdit.EndUpdate;
end;

function TQtButtonGroup.MakeBinding(Eventname: string): string;
begin
  Result:= Indent2 + 'self.' + Name + 'BG.' + Eventname + '.connect(self.' + HandlerName(Eventname) + ')';
end;

procedure TQtButtonGroup.setPositionAndSize;
  var col, row, ItemsInCol, line, x, y, dx, dy, th: Integer;
      RadioHeight, RadioWidth, ColWidth, RowHeight, ColWidthRest, RowHeightRest: Integer;
      xold, yold,ColWidthI, RowHeightI: Integer;
      key: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited;
  Canvas.Font.Assign(Font);
  th:= Canvas.TextHeight('Hg');
  if FTitle = '' then begin
    RadioWidth:= Width;
    RadioHeight:= Height - PPIScale(4);
    dy:= PPIScale(2);
  end else begin
    RadioWidth:= Width - PPIScale(4);
    RadioHeight:= Height - th - PPIScale(4);
    dy:= PPIScale(2) + th;
  end;
  dx:= Canvas.TextWidth('x');

  if FItems.Count > 0 then begin
    ColWidth:= RadioWidth div FColumns;
    RowHeight:= RadioHeight div ItemsInColumn(1);
    line:= 0;
    xold:= 0;
    ColWidthRest:= RadioWidth mod FColumns;
    for col:= 0 to FColumns - 1 do begin
      if ColWidthRest > 0
        then ColWidthI:= ColWidth + 1
        else ColWidthI:= ColWidth;
      if col = 0
        then x:= dx
        else x:= xold + ColWidthI;
      Dec(ColWidthRest);

      yold:= 0;
      ItemsInCol:= ItemsInColumn(col+1);
      RowHeightRest:= RadioHeight mod ItemsInColumn(1);
      for row:= 0 to ItemsInCol - 1 do begin
        if RowHeightRest > 0
          then RowHeightI:= RowHeight + 1
          else RowHeightI:= RowHeight;
        if row = 0
          then y:= dy
          else y:= yold + RowHeightI;
        Dec(RowHeightRest);
        key:= RBName(line) + '.setGeometry';
        setAttributValue(key, key + '(' + IntToStr(PPIUnScale(x)) + ', ' + IntToStr(PPIUnScale(y)) +
          ', ' + IntToStr(PPIUnScale(ColWidthI)) + ', ' + IntToStr(PPIUnScale(RowHeightI)) + ')');
        if Pos(', ' + _('selected'), FItems[line]) > 0 then begin
          key:= RBName(line) + '.setChecked';
          setAttributValue(key, key + '(True)');
        end;
        Inc(line);
        yold:= y;
      end;
      xold:= x;
    end;
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtButtonGroup.MakeTitle(Title: string);
begin
  FTitle:= Title;
  MakeAttribut('Title', asString(FTitle));
  setPositionAndSize;
end;

procedure TQtButtonGroup.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QGroupBox');
  MakeTitle(' ' + _('Continent') + ' ');
  FItems.Text:= defaultItems;
  FItems[0]:= FItems[0] + ', ' + _('selected');
  MakeButtongroupItems;
end;

procedure TQtButtonGroup.setItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then begin
    FOldItems.Text:= FItems.Text;
    FItems.Text:= Value.Text;
    Invalidate;
  end;
end;

procedure TQtButtonGroup.setColumns(Value: Integer);
begin
  if (FColumns <> Value) and (Value > 0) then begin
    FColumns:= Value;
    Invalidate;
  end;
end;

procedure TQtButtonGroup.setTitle(Value: string);
begin
  if FTitle <> Value then begin
    FTitle:= Value;
    Invalidate;
  end;
end;

procedure TQtButtonGroup.setCheckboxes(Value: Boolean);
begin
  if FCheckboxes <> Value then begin
    FCheckboxes:= Value;
    Invalidate;
  end;
end;

function TQtButtonGroup.ItemsInColumn(i: Integer): Integer;
  var quot, rest: Integer;
begin
  quot:= FItems.Count div FColumns;
  rest:= FItems.Count mod FColumns;
  if i <= rest
    then Result:= quot + 1
    else Result:= quot;
end;

procedure TQtButtonGroup.Rename(const OldName, NewName, Events: string);
begin
  inherited;
  Partner.ReplaceWord('self.' + OldName + 'BG', 'self.' + NewName + 'BG', True);
end;

procedure TQtButtonGroup.Paint;
  const cRadius = 7;
  var ColumnWidth, RowHeight, RadioHeight, LabelHeight,
      col, row, yc, ItemsInCol, line, x, y, th, p, Radius: Integer;
      R: TRect; s: string;
begin
  FOldItems.Text:= FItems.Text;
  inherited;
  Canvas.Brush.Color:= clBtnFace;
  Canvas.FillRect(ClientRect);
  th:= Canvas.TextHeight('Hg');
  Radius:= PPIScale(cRadius);
  LabelHeight:= 0;
  RadioHeight:= Height;
  R:= ClientRect;
  Canvas.Pen.Color:= $BABABA;
  if FTitle <> '' then
    R.Top:= th div 2;
  Canvas.Rectangle(R);

  if FTitle <> '' then begin
    R.Top:= th div 2;
    LabelHeight:= th;
    RadioHeight:= Height - th;
    Canvas.Rectangle(R);
    Canvas.Textout(PPIScale(10), 0, FTitle);
  end;

  if FItems.Count > 0 then begin
    Canvas.Pen.Color:= $333333;
    ColumnWidth:= Width div FColumns;
    RowHeight:= RadioHeight div ItemsInColumn(1);
    line:= 0;
    for col:= 1 to FColumns do begin
      ItemsInCol:= ItemsInColumn(col);
      for row:= 1 to ItemsInCol do begin
        s:= FItems[line];
        p:= Pos(', ' + _('selected'), s);
        if p > 0 then
          s:= Copy(s, 1, p-1);
        x:= PPIScale(4) + (col - 1)*ColumnWidth;
        y:= LabelHeight + PPIScale(2) + (row - 1)*RowHeight;
        Canvas.Brush.Color:= clWhite;
        yc:= y + RowHeight div 2 - th div 2;
        if FCheckboxes then begin
          R:= Rect(x, y + PPIScale(3), x + PPIScale(13), y + PPIScale(16));
          Canvas.Rectangle(R);
          if p > 0 then begin
            Canvas.Pen.Width:= PPIScale(2);
            Canvas.MoveTo(x + PPIScale(3), yc + PPIScale(6));
            Canvas.LineTo(x + PPIScale(4), yc + PPIScale(9));
            Canvas.LineTo(x + PPIScale(9), yc + PPIScale(3));
            Canvas.Pen.Width:= 1;
          end;
        end else begin
          yc:= y + RowHeight div 2 - Radius;
          Canvas.Ellipse(x, yc, x + 2*Radius, yc + 2*Radius);
          if p > 0 then begin
            Canvas.Brush.Color:= clBlack;
            Canvas.Ellipse(x + PPIScale(3), yc + PPIScale(3), x + 2*Radius-PPIScale(3), yc + 2*Radius-PPIScale(3));
            Canvas.Brush.Color:= clWhite;
          end;
        end;
        Canvas.Brush.Color:= clBtnFace;
        yc:= y + RowHeight div 2 - th div 2;
        R:= Rect(x + PPIScale(19), yc, col*ColumnWidth, yc + RowHeight);
        Canvas.TextRect(R, s);
        Inc(line);
      end;
    end;
  end;
end;

{--- TQtMainWindow ------------------------------------------------------------}

function TQtMainWindow.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Title|Animated|DockNestingEnabled|DocumentMode|TabShape|ToolButtonStyle';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtMainWindow.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'TabShape' then
    MakeAttribut(Attr, 'QTabWidget.' + Value)
  else if attr = 'ToolButtonStyle' then
    MakeAttribut(Attr, 'Qt.ToolButtonStyle.' + Value)
  else if Attr = 'Title' then begin
    var s:= 'self.setWindowTitle';
    setAttributValue(s, s + '(' + asString(Value) + ')');
  end else
    inherited;
end;

function TQtMainWindow.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|iconSizeChanged|tabifiedDockWidgetActivated|toolButtonStyleChanged'; // ToDo
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtMainWindow.HandlerInfo(const event: string): string;
begin
  if event = 'iconSizeChanged' then
    Result:= 'QSize;iconSize'
  else if event = 'tabifiedDockWidgetActivated' then
    Result:= 'QDockWidget;dockWidget'
  else if event = 'toolButtonStyleChanged' then
    Result:= 'QToolButtonStyle;toolButtonStyle'
  else
    Result:= inherited;
end;

procedure TQtMainWindow.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then begin
    Slots.Add(Name + '.setAnimated');
    Slots.Add(Name + '.setDockNestingEnabled');
  end;
  inherited;
end;

function TQtMainWindow.HandlerName(const event: string): string;
begin
  Result:= 'MainWindow_' + Event;
end;

end.
