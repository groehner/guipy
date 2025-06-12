{ -------------------------------------------------------------------------------
  Unit:     UQtWidgetDescendants
  Author:   Gerhard Röhner
  Date:     July 2022
  Purpose:  PyQt simple widgets
  ------------------------------------------------------------------------------- }
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
  Windows,
  Graphics,
  Classes,
  UBaseQtWidgets;

type

  TEchoMode = (Normal, NoEcho, Password, PasswordEchoOnEdit);

  TCursorMoveStyle = (LogicalMoveStyle, VisualMoveStyle);

  TInsertPolicy = (NoInsert, InsertAtTop, InsertAtCurrent, InsertAtBottom,
    InsertAfterCurrent, InsertBeforeCurrent, InsertAlphabetically);

  TSizeAdjustPolicy = (AdjustToContents, AdjustToContentsOnFirstShow,
    AdjustToMinimumContentsLength, AdjustToMinimumContentsLengthWithIcon);

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
    procedure SetText(Value: string);
    procedure SetPlaceholderText(Value: string);
    procedure SetEchoMode(Value: TEchoMode);
    procedure SetFrame(Value: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property InputMask: string read FInputMask write FInputMask;
    property Text: string read FText write SetText;
    property MaxLength: Integer read FMaxLength write FMaxLength;
    property Frame: Boolean read FFrame write SetFrame;
    property EchoMode: TEchoMode read FEchoMode write SetEchoMode;
    property CursorPosition: Integer read FCursorPosition write FCursorPosition;
    property Aligment: string read FAligment write FAligment;
    property DragEnabled: Boolean read FDragEnabled write FDragEnabled;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property PlaceholderText: string read FPlaceholderText
      write SetPlaceholderText;
    property CursorMoveStyle: TCursorMoveStyle read FCursorMoveStyle
      write FCursorMoveStyle;
    property ClearButtonEnabled: Boolean read FClearButtonEnabled
      write FClearButtonEnabled;
    // signals
    property cursorPositionChanged: string read FCursorPositionChanged
      write FCursorPositionChanged;
    property editingFinished: string read FEditingFinished
      write FEditingFinished;
    property inputRejected: string read FInputRejected write FInputRejected;
    property returnPressed: string read FReturnPressed write FReturnPressed;
    property selectionChanged: string read FSelectionChanged
      write FSelectionChanged;
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
    procedure SetListItems(Values: TStrings);
    function GetListItems: string;
    procedure SetCurrentText(Value: string);
    procedure SetPlaceholderText(Value: string);
    procedure SetEditable(Value: Boolean);
    procedure SetFrame(Value: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Editable: Boolean read FEditable write SetEditable;
    property CurrentText: string read FCurrentText write SetCurrentText;
    property CurrentIndex: Integer read FCurrentIndex write FCurrentIndex;
    property MaxVisibleItems: Integer read FMaxVisibleItems
      write FMaxVisibleItems;
    property MaxCount: Integer read FMaxCount write FMaxCount;
    property InsertPolicy: TInsertPolicy read FInsertPolicy write FInsertPolicy;
    property SizeAdjustPolicy: TSizeAdjustPolicy read FSizeAdjustPolicy
      write FSizeAdjustPolicy;
    property MinimumContentsLength: Integer read FMinimumContentsLength
      write FMinimumContentsLength;
    property PlaceholderText: string read FPlaceholderText
      write SetPlaceholderText;
    property DuplicatesEnabled: Boolean read FDuplicatesEnabled
      write FDuplicatesEnabled;
    property Frame: Boolean read FFrame write SetFrame;
    property ModelColumn: Integer read FModelColumn write FModelColumn;
    property ListItems: TStrings read FListItems write SetListItems;
    // signals
    property activated: string read FActivated write FActivated;
    property currentIndexChanged: string read FCurrentIndexChanged
      write FCurrentIndexChanged;
    property currentTextChanged: string read FCurrentTextChanged
      write FCurrentTextChanged;
    property editTextChanged: string read FEditTextChanged
      write FEditTextChanged;
    property highlighted: string read FHighlighted write FHighlighted;
    property textActivated: string read FTextActivated write FTextActivated;
    property textHighlighted: string read FTextHighlighted
      write FTextHighlighted;
  end;

  TQtFontComboBox = class(TQtComboBox)
  private
    FWritingSystem: TWritingSystem;
    FFontFilters: TSetOfFontFilters;
    FCurrentFont: TFont;
    FCurrentFontChanged: string;
    procedure SetCurrentFont(Value: TFont);
    procedure MakeFontFilters;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    procedure MakeFont; override;
  published
    property WritingSystem: TWritingSystem read FWritingSystem
      write FWritingSystem;
    property FontFilters: TSetOfFontFilters read FFontFilters
      write FFontFilters;
    property CurrentFont: TFont read FCurrentFont write SetCurrentFont;
    // signals
    property currentFontChanged: string read FCurrentFontChanged
      write FCurrentFontChanged;
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
    procedure SetMinimum(Value: Integer);
    procedure SetMaximum(Value: Integer);
    procedure SetValue(Value: Integer);
    procedure SetTextVisible(Value: Boolean);
    procedure SetOrientation(Value: TOrientation);
    procedure SetInvertedAppearance(Value: Boolean);
    procedure SetFormat(Value: string);
    function GetText: string;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    function InnerRect: TRect; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Minimum: Integer read FMinimum write SetMinimum;
    property Maximum: Integer read FMaximum write SetMaximum;
    property Value: Integer read FValue write SetValue;
    property TextVisible: Boolean read FTextVisible write SetTextVisible;
    property Orientation: TOrientation read FOrientation write SetOrientation;
    property InvertedAppearance: Boolean read FInvertedAppearance
      write SetInvertedAppearance;
    property Format: string read FFormat write SetFormat;
    // signals
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtStatusbar = class(TBaseQtWidget)
  private
    FSizeGripEnabled: Boolean;
    FMessageChanged: string;
    procedure SetSizeGripEnabled(Value: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  published
    property SizeGripEnabled: Boolean read FSizeGripEnabled
      write SetSizeGripEnabled;
    // signals
    property messageChanged: string read FMessageChanged write FMessageChanged;
  end;

  TQtGroupBox = class(TBaseQtWidget)
  private
    FTitle: string;
    // FAligmnent
    FFlat: Boolean;
    FCheckable: Boolean;
    FChecked: Boolean;
    FClicked: string;
    FToggled: string;
    procedure SetTitle(Value: string);
    procedure SetFlat(Value: Boolean);
    procedure SetCheckable(Value: Boolean);
    procedure SetChecked(Value: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Title: string read FTitle write SetTitle;
    property Flat: Boolean read FFlat write SetFlat;
    property Checkable: Boolean read FCheckable write SetCheckable;
    property Checked: Boolean read FChecked write SetChecked;
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
    procedure SetTabPosition(Value: TTabPosition);
    procedure SetTabShape(Value: TTabShape);
    procedure SetCurrentIndex(Value: Integer);
    procedure SetTabs(Value: TStrings);
    procedure MakeTabs;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteWidget; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property TabPosition: TTabPosition read FTabPosition write SetTabPosition;
    property TabShape: TTabShape read FTabShape write SetTabShape;
    property CurrentIndex: Integer read FCurrentIndex write SetCurrentIndex;
    property UsesScrollButtons: Boolean read FUsesScrollButtons
      write FUsesScrollButtons;
    property DocumentMode: Boolean read FDocumentMode write FDocumentMode;
    property TabsClosable: Boolean read FTabsClosable write FTabsClosable;
    property Moveable: Boolean read FMoveable write FMoveable;
    property TabBarAutoHide: Boolean read FTabBarAutoHide write FTabBarAutoHide;
    property Tabs: TStrings read FTabs write SetTabs;
    // signals
    property currentChanged: string read FCurrentChanged write FCurrentChanged;
    property tabBarClicked: string read FTabBarClicked write FTabBarClicked;
    property tabBarDoubleClicked: string read FTabBarDoubleClicked
      write FTabBarDoubleClicked;
    property tabCloseRequested: string read FTabCloseRequested
      write FTabCloseRequested;
  end;

  TQtMenuBar = class(TBaseQtWidget)
  private
    FMenuItems: TStrings;
    FHovered: string;
    FMenuItemsOld: TStrings;
    FTriggered: string;
    procedure SetItems(Items: TStrings);
    procedure MakeMenuItems;
    function HasSubMenu(MenuItems: TStrings; Num: Integer): Boolean;
    function MakeMenuName(MenuStr, Str: string): string;
    procedure CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings); virtual;
    function GetCreateMenu: string; virtual;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure NewWidget(Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure Rename(const OldName, NewName, Events: string); override;
    procedure SetPositionAndSize; override;
    procedure DeleteWidget; override;
    procedure Paint; override;
    property MenuItemsOld: TStrings read FMenuItemsOld write FMenuItemsOld;
  published
    property MenuItems: TStrings read FMenuItems write SetItems;
    // signals
    property hovered: string read FHovered write FHovered;
    property triggered: string read FTriggered write FTriggered;
  end;

  TQtMenu = class(TQtMenuBar)
  public
    constructor Create(Owner: TComponent); override;
    procedure DeleteWidget; override;
    function GetCreateMenu: string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  end;

  TQtButtonGroup = class(TBaseQtWidget)
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
    procedure SetColumns(Value: Integer);
    procedure SetTitle(Value: string);
    procedure SetItems(Value: TStrings);
    procedure SetCheckboxes(Value: Boolean);
    procedure MakeButtongroupItems;
    procedure MakeTitle(Title: string);
    function ItemsInColumn(Num: Integer): Integer;
    function RBName(Num: Integer): string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteWidget; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure SetEvent(Attr: string); override;
    function HandlerInfo(const Event: string): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
    function MakeBinding(Eventname: string): string; override;
    procedure Rename(const OldName, NewName, Events: string); override;
  published
    property Items: TStrings read FItems write SetItems;
    // must stay before columns or label
    property Columns: Integer read FColumns write SetColumns;
    property Title: string read FTitle write SetTitle;
    property Checkboxes: Boolean read FCheckboxes write SetCheckboxes;
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

  TQtMainWindow = class(TBaseQtWidget)
  public
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    function HandlerName(const Event: string): string; override;
  end;

implementation

uses
  Controls,
  SysUtils,
  Math,
  Types,
  UITypes,
  JvGnugettext,
  frmPyIDEMain,
  UGUIDesigner,
  UUtils;

{ --- TQtLineEdit -------------------------------------------------------------- }

constructor TQtLineEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 72;
  Width := 80;
  Height := 24;
  FocusPolicy := StrongFocus;
  ContextMenuPolicy := DefaultContextMenu;
  Cursor := crIBeam;
  MouseTracking := True;
  FMaxLength := 32767;
  FFrame := True;
end;

function TQtLineEdit.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|EchoMode|InputMask|Text|PlaceholderText';
  if ShowAttributes >= 2 then
    Result := Result + '|Frame|ReadOnly|ClearButtonEnabled';
  if ShowAttributes = 3 then
    Result := Result +
      '|MaxLength|CursorPosition|Alignment|DragEnabled|CursorMoveStyle';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtLineEdit.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'EchoMode' then
    MakeAttribut(Attr, 'QLineEdit.EchoMode.' + Value)
  else if Attr = 'CursorMoveStyle' then
    MakeAttribut(Attr, 'Qt.CursorMoveStyle.' + Value)
  else
    inherited;
end;

function TQtLineEdit.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|cursorPositionChanged|editingFinished|inputRejected' +
    '|returnPressed|selectionChanged|textChanged|textEdited';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtLineEdit.HandlerInfo(const Event: string): string;
begin
  if Event = 'cursorPositionChanged' then
    Result := 'int, int;oldPos, newPos'
  else if Pos('text', Event) = 1 then
    Result := 'QString;text'
  else
    Result := inherited;
end;

procedure TQtLineEdit.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.copy');
    Slots.Add(Name + '.cut');
    Slots.Add(Name + '.paste');
    Slots.Add(Name + '.redo');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.undo');
  end
  else if Parametertypes = 'QString' then
    Slots.Add(Name + '.setText');
  inherited;
end;

procedure TQtLineEdit.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QLineEdit');
end;

procedure TQtLineEdit.Paint;
var
  ARect: TRect;
  Str: string;
begin
  inherited;
  if FFrame then
    Canvas.Pen.Color := $7A7A7A
  else
    Canvas.Pen.Color := clWhite;
  Canvas.Brush.Color := clWhite;
  Canvas.Rectangle(ClientRect);

  ARect := ClientRect;
  ARect.Left := 2;
  ARect.Right := ARect.Right - 2;
  if FClearButtonEnabled then
    ARect.Right := ARect.Right - PPIScale(28);
  ARect.Top := (Height - Canvas.TextHeight('Hg')) div 2;

  if FText <> '' then
  begin
    case FEchoMode of
      Normal:
        Str := FText;
      NoEcho:
        Str := '';
      Password, PasswordEchoOnEdit:
        Str := StringOfChar('*', Length(FText));
    end;
  end
  else if FPlaceholderText <> '' then
  begin
    Canvas.Font.Color := $7F7F7F;
    Str := FPlaceholderText;
  end;
  if Str <> '' then
    DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_LEFT);
  if FClearButtonEnabled then
    FGUIDesigner.vilQtControls1616.Draw(Canvas, ARect.Right + 8,
      (ARect.Height - FGUIDesigner.vilQtControls1616.Height) div 2, 4);
end;

procedure TQtLineEdit.SetText(Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    Invalidate;
  end;
end;

procedure TQtLineEdit.SetPlaceholderText(Value: string);
begin
  if Value <> FPlaceholderText then
  begin
    FPlaceholderText := Value;
    Invalidate;
  end;
end;

procedure TQtLineEdit.SetEchoMode(Value: TEchoMode);
begin
  if Value <> FEchoMode then
  begin
    FEchoMode := Value;
    Invalidate;
  end;
end;

procedure TQtLineEdit.SetFrame(Value: Boolean);
begin
  if Value <> FFrame then
  begin
    FFrame := Value;
    Invalidate;
  end;
end;

{ --- TQtComboBox -------------------------------------------------------------- }

constructor TQtComboBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 78;
  Width := 80;
  Height := 24;
  FocusPolicy := WheelFocus;
  ContextMenuPolicy := DefaultContextMenu;
  FMaxVisibleItems := 10;
  FMaxCount := 2147483647;
  FInsertPolicy := InsertAtBottom;
  FSizeAdjustPolicy := AdjustToContentsOnFirstShow;
  FFrame := True;
  FCurrentIndex := -1;
  FListItems := TStringList.Create;
  FListItems.Text := DefaultItems;
end;

destructor TQtComboBox.Destroy;
begin
  FreeAndNil(FListItems);
  inherited;
end;

function TQtComboBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|CurrentText|CurrentIndex|PlaceholderText|ListItems|Editable';
  if ShowAttributes >= 2 then
    Result := Result + '|Frame|InsertPolicy|DuplicatesEnabled';
  if ShowAttributes = 3 then
    Result := Result + '|MaxVisibleItems|MaxCount|SizeAdjustPolicy' +
      '|MinimumContentsLength|ModelColumn';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtComboBox.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'ListItems' then
  begin
    var
    Str := 'self.' + Name + '.setModel';
    SetAttributValue(Str, Str + '(QStringListModel(' + GetListItems + '))');
  end
  else if (Attr = 'InsertPolicy') or (Attr = 'SizeAdjustPolicy') then
    MakeAttribut(Attr, 'QComboBox.' + Attr + '.' + Value)
  else
    inherited;
end;

const
  EventsWithIndex = '|activated|currentIndexChanged|highlighted';
  EventsWithText =
    '|currentTextChanged|editTextChanged|textActivated|textHighlighted';

function TQtComboBox.GetEvents(ShowEvents: Integer): string;
begin
  Result := EventsWithIndex + EventsWithText;
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtComboBox.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, EventsWithIndex) > 0 then
    Result := 'int;index'
  else if Pos(Event, EventsWithText) > 0 then
    Result := 'QString;text'
  else
    inherited;
end;

procedure TQtComboBox.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.clearEditText');
  end
  else if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QString' then
  begin
    Slots.Add(Name + '.setCurrentText');
    Slots.Add(Name + '.setEditText');
  end;
  inherited;
end;

procedure TQtComboBox.NewWidget(Widget: string = '');
begin
  if Widget = '' then
  begin
    inherited NewWidget('QComboBox');
    SetAttribute('ListItems', '[''A'', ''B'', ''C'']', '');
  end
  else
    inherited NewWidget('QFontComboBox');
end;

procedure TQtComboBox.Paint;
var
  ARect: TRect;
  Str: string;
  XPos, YPos: Integer;
begin
  inherited;
  if FFrame then
    Canvas.Pen.Color := $7A7A7A
  else
    Canvas.Pen.Color := clWhite;
  if FEditable then
    Canvas.Brush.Color := clWhite
  else
    Canvas.Brush.Color := $E1E1E1;
  Canvas.Rectangle(ClientRect);

  if FCurrentText <> '' then
    Str := FCurrentText
  else if FListItems.Count > 0 then
    Str := FListItems[0];
  if Str = '' then
    Str := FPlaceholderText;

  ARect := InnerRect;
  ARect.Top := (ARect.Bottom - ARect.Top - Canvas.TextHeight('A')) div 2;
  ARect.Left := ARect.Left + HalfX;
  ARect.Right := ARect.Right - PPIScale(18);
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_LEFT);

  XPos := Width - PPIScale(14);
  YPos := Height div 2 - 2;
  var
  Int3 := PPIScale(3);
  var
  Int4 := PPIScale(4);
  var
  Int5 := PPIScale(5);
  var
  Int8 := PPIScale(8);
  var
  Int10 := PPIScale(10);
  Canvas.Pen.Color := $F1F1F1;
  Canvas.MoveTo(XPos, YPos);
  Canvas.LineTo(XPos + Int4, YPos + Int4);
  Canvas.LineTo(XPos + Int5, YPos + Int4);
  Canvas.LineTo(XPos + Int10, YPos - 1);

  Canvas.Pen.Color := $5C5C5C;
  XPos := XPos + 1;
  Canvas.MoveTo(XPos, YPos);
  Canvas.LineTo(XPos + Int3, YPos + Int3);
  Canvas.LineTo(XPos + Int4, YPos + Int3);
  Canvas.LineTo(XPos + Int8, YPos - 1);

  YPos := YPos - 1;
  Canvas.Pen.Color := $ADADAD;
  Canvas.MoveTo(XPos, YPos);
  Canvas.LineTo(XPos + Int3, YPos + Int3);
  Canvas.LineTo(XPos + Int4, YPos + Int3);
  Canvas.LineTo(XPos + Int8, YPos - 1);
end;

procedure TQtComboBox.SetListItems(Values: TStrings);
begin
  FListItems.Assign(Values);
  Invalidate;
end;

function TQtComboBox.GetListItems: string;
var
  Str: string;
begin
  Str := '[';
  for var I := 0 to FListItems.Count - 1 do
    Str := Str + AsString(FListItems[I]) + ', ';
  Delete(Str, Length(Str) - 1, 2);
  Result := Str + ']';
end;

procedure TQtComboBox.SetCurrentText(Value: string);
begin
  if Value <> FCurrentText then
  begin
    FCurrentText := Value;
    Invalidate;
  end;
end;

procedure TQtComboBox.SetPlaceholderText(Value: string);
begin
  if Value <> FPlaceholderText then
  begin
    FPlaceholderText := Value;
    Invalidate;
  end;
end;

procedure TQtComboBox.SetEditable(Value: Boolean);
begin
  if Value <> FEditable then
  begin
    FEditable := Value;
    Invalidate;
  end;
end;

procedure TQtComboBox.SetFrame(Value: Boolean);
begin
  if Value <> FFrame then
  begin
    FFrame := Value;
    Invalidate;
  end;
end;

{ --- TQtFontComboBox ---------------------------------------------------------- }

constructor TQtFontComboBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 105;
  Width := 144;
  Height := 24;
  FCurrentFont := TFont.Create;
  FCurrentFont.Assign(Font);
  Editable := True;
  ListItems.Text := '';
end;

destructor TQtFontComboBox.Destroy;
begin
  inherited;
  FreeAndNil(FCurrentFont);
end;

function TQtFontComboBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|WritingSystem|FontFilters|CurrentFont';
  Result := Result + inherited GetAttributes(ShowAttributes);
  var
  Posi := Pos('|CurrentText|CurrentIndex|PlaceholderText|ListItems', Result);
  if Posi > 0 then
    Delete(Result, Posi, 51);
end;

procedure TQtFontComboBox.SetAttribute(Attr, Value, Typ: string);
begin
  if Typ = 'TSetOfFontFilters' then
    MakeFontFilters
  else if (Attr = 'CurrentFont') or (Pos(Attr, ' Name Size Bold Italic ') > 0)
  then
    MakeFont
  else if Attr = 'WritingSystem' then
    MakeAttribut(Attr, 'QFontDatabase.WritingSystem.' + Value)
  else
    inherited;
end;

function TQtFontComboBox.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|currentFontChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtFontComboBox.HandlerInfo(const Event: string): string;
begin
  if Event = 'currentFontChanged' then
    Result := 'QFont;font'
  else
    Result := inherited;
end;

procedure TQtFontComboBox.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'QFont' then
    Slots.Add(Name + '.setCurrentFont');
  inherited;
end;

procedure TQtFontComboBox.MakeFont;
var
  Str1, Str2: string;
begin
  if Name = '' then
    Exit;

  Str1 := 'self.' + Name + '.setCurrentFont';
  Str2 := '(QFont(' + AsString(FCurrentFont.Name) + ', ' +
    IntToStr(FCurrentFont.Size);
  if fsBold in FCurrentFont.Style then
    Str2 := Str2 + ', QFont.Weight.Bold';
  if fsItalic in FCurrentFont.Style then
    Str2 := Str2 + ', italic=True';
  Str2 := Str2 + '))';
  SetAttributValue(Str1, Str1 + Str2);
  Str1 := 'self.' + Name + '.currentFont().setUnderline';
  if fsUnderline in FCurrentFont.Style then
    SetAttributValue(Str1, Str1 + '(True)')
  else
    Partner.DeleteAttribute(Str1);
  Str1 := 'self.' + Name + '.currentFont().setStrikeOut';
  if fsStrikeOut in FCurrentFont.Style then
    SetAttributValue(Str1, Str1 + '(True)')
  else
    Partner.DeleteAttribute(Str1);
  Invalidate;
end;

procedure TQtFontComboBox.MakeFontFilters;
begin
  var
  Str := '';
  if AllFonts in FFontFilters then
    Str := Str + '|QFontComboBox.AllFonts';
  if ScalableFonts in FFontFilters then
    Str := Str + '|QFontComboBox.ScalableFonts';
  if NonScalableFonts in FFontFilters then
    Str := Str + '|QFontComboBox.NonScalableFonts';
  if MonospacedFonts in FFontFilters then
    Str := Str + '|QFontComboBox.MonospacedFonts';
  if ProportionalFonts in FFontFilters then
    Str := Str + '|QFontComboBox.ProportionalFonts';
  if Str = '' then
    Str := '|QFontComboBox.AllFonts';
  Delete(Str, 1, 1);
  SetAttribute('FontFilters', Str, '');
end;

procedure TQtFontComboBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QFontComboBox');
end;

procedure TQtFontComboBox.Paint;
begin
  CurrentText := FCurrentFont.Name;
  inherited;
end;

procedure TQtFontComboBox.SetCurrentFont(Value: TFont);
begin
  if Value <> FCurrentFont then
  begin
    FCurrentFont.Assign(Value);
    Invalidate;
  end;
end;

{ --- TQtProgressBar ----------------------------------------------------------- }

constructor TQtProgressbar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 90;
  Width := 120;
  Height := 24;
  FMinimum := 0;
  FMaximum := 100;
  FValue := 24;
  FTextVisible := True;
  FOrientation := Horizontal;
  FFormat := '%p%';
end;

function TQtProgressbar.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Minimum|Maximum|Value|';
  if ShowAttributes >= 2 then
    Result := Result + '|TextVisible|Orientation|InvertedAppearance|Format';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtProgressbar.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'TextDirection' then
    MakeAttribut(Attr, 'QProgressBar.' + Value)
  else if Attr = 'Orientation' then
    MakeAttribut(Attr, 'Qt.Orientation.' + Value)
  else
    inherited;
end;

function TQtProgressbar.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|valueChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtProgressbar.HandlerInfo(const Event: string): string;
begin
  if Event = 'valueChanged' then
    Result := 'int;value'
  else
    Result := inherited;
end;

procedure TQtProgressbar.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
  begin
    Slots.Add(Name + '.setMaximum');
    Slots.Add(Name + '.setMinimum');
    Slots.Add(Name + '.setValue');
  end
  else if Parametertypes = '' then
    Slots.Add(Name + '.reset')
  else if Parametertypes = 'int, int' then
    Slots.Add(Name + '.setRange');
  inherited;
end;

function TQtProgressbar.InnerRect: TRect;
begin
  Result := inherited;
  if FTextVisible and (FOrientation = Horizontal) and (FMinimum < FMaximum) then
    Result.Right := Result.Right - Canvas.TextWidth(GetText);
end;

procedure TQtProgressbar.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QProgressBar');
  SetAttribute('Value', '24', '');
end;

procedure TQtProgressbar.Paint;
var
  XPos, YPos: Integer;
  ARect: TRect;
  Str: string;
begin
  inherited;
  Canvas.Pen.Color := $BCBCBC;
  Canvas.Brush.Color := $E6E6E6;
  ARect := InnerRect;
  Canvas.Rectangle(ARect);

  if (FValue < FMinimum) or (FValue > FMaximum) or (FMaximum <= FMinimum) then
    Exit;

  // draw text
  if FTextVisible and (FOrientation = Horizontal) then
  begin
    var
    Rect2 := ClientRect;
    Rect2.Inflate(-1, -1);
    Rect2.Left := ARect.Right + 1;
    Str := GetText;
    Canvas.Brush.Color := clBtnFace;
    DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2,
      DT_CENTER + DT_VCENTER + DT_SINGLELINE);
  end;

  // draw visible progress
  if FOrientation = Horizontal then
  begin
    XPos := Round((ARect.Right - ARect.Left) * (FValue - FMinimum) /
      (FMaximum - FMinimum));
    if FInvertedAppearance then
      ARect.Left := ARect.Right - XPos
    else
      ARect.Right := ARect.Left + XPos;
  end
  else
  begin
    YPos := Round((ARect.Bottom - ARect.Top) * (FValue - FMinimum) /
      (FMaximum - FMinimum));
    if InvertedAppearance then
      ARect.Bottom := ARect.Top + YPos
    else
      ARect.Top := ARect.Bottom - YPos;
  end;
  Canvas.Brush.Color := $25B006;
  Canvas.FillRect(ARect);
end;

function TQtProgressbar.GetText: string;
var
  Str: string;
  Posi: Integer;
begin
  Str := FFormat;
  Posi := Pos('%p', Str);
  if Posi > 0 then
  begin
    Delete(Str, Posi, 2);
    insert(IntToStr(Round(0.5 + (FValue - FMinimum) / (FMaximum - FMinimum) *
      100)), Str, Posi);
  end;
  Posi := Pos('%v', Str);
  if Posi > 0 then
  begin
    Delete(Str, Posi, 2);
    insert(IntToStr(FValue), Str, Posi);
  end;
  Posi := Pos('%m', Str);
  if Posi > 0 then
  begin
    Delete(Str, Posi, 2);
    insert(IntToStr(FMaximum - FMinimum), Str, Posi);
  end;
  Result := '  ' + Str + '  ';
end;

procedure TQtProgressbar.SetMinimum(Value: Integer);
begin
  if Value <> FMinimum then
  begin
    FMinimum := Value;
    Invalidate;
  end;
end;

procedure TQtProgressbar.SetMaximum(Value: Integer);
begin
  if Value <> FMaximum then
  begin
    FMaximum := Value;
    Invalidate;
  end;
end;

procedure TQtProgressbar.SetValue(Value: Integer);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

procedure TQtProgressbar.SetTextVisible(Value: Boolean);
begin
  if Value <> FTextVisible then
  begin
    FTextVisible := Value;
    Invalidate;
  end;
end;

procedure TQtProgressbar.SetOrientation(Value: TOrientation);
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

procedure TQtProgressbar.SetInvertedAppearance(Value: Boolean);
begin
  if Value <> FInvertedAppearance then
  begin
    FInvertedAppearance := Value;
    Invalidate;
  end;
end;

procedure TQtProgressbar.SetFormat(Value: string);
begin
  if Value <> FFormat then
  begin
    FFormat := Value;
    Invalidate;
  end;
end;

{ --- TQtStatusBar ------------------------------------------------------------- }

constructor TQtStatusbar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 91;
  Width := 100;
  Height := 20;
end;

function TQtStatusbar.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|SizeGripEnabled';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TQtStatusbar.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|messageChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtStatusbar.HandlerInfo(const Event: string): string;
begin
  if Event = 'messageChanged' then
    Result := 'QString;message'
  else
    Result := inherited;
end;

procedure TQtStatusbar.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clearMessage')
  else if Parametertypes = 'QString, int' then
    Slots.Add(Name + '.showMessage');
  inherited;
end;

procedure TQtStatusbar.NewWidget(Widget: string = '');
begin
  InsertValue('self.statusBar()');
end;

procedure TQtStatusbar.DeleteWidget;
begin
  Partner.DeleteAttribute('self.statusBar');
end;

procedure TQtStatusbar.Paint;
var
  ARect: TRect;
  Int3: Integer;
begin
  SetBounds(0, Parent.ClientHeight - PPIScale(21), Parent.ClientWidth,
    PPIScale(21));
  inherited;
  ARect := Rect(Width - PPIScale(12), Height - PPIScale(5),
    Width - PPIScale(10), Height - PPIScale(3));
  Canvas.Brush.Color := $BFBFBF;
  Canvas.FillRect(ARect);
  Int3 := PPIScale(3);
  ARect.Offset(Int3, 0);
  Canvas.FillRect(ARect);
  ARect.Offset(Int3, 0);
  Canvas.FillRect(ARect);
  ARect.Offset(0, -Int3);
  Canvas.FillRect(ARect);
  ARect.Offset(0, -Int3);
  Canvas.FillRect(ARect);
  ARect.Offset(-Int3, Int3);
  Canvas.FillRect(ARect);
end;

procedure TQtStatusbar.SetPositionAndSize;
begin
  // do nothing
end;

procedure TQtStatusbar.SetSizeGripEnabled(Value: Boolean);
begin
  if Value <> FSizeGripEnabled then
  begin
    FSizeGripEnabled := Value;
    Invalidate;
  end;
end;

{ --- TQtGroupBox -------------------------------------------------------------- }

constructor TQtGroupBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 83;
  Width := 120;
  Height := 80;
  FTitle := 'GroupBox';
  ControlStyle := [csAcceptsControls];
end;

function TQtGroupBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Title|Flat|Checkable|Checked';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TQtGroupBox.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|clicked|toggled';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtGroupBox.HandlerInfo(const Event: string): string;
begin
  if Event = 'clicked' then
    Result := 'bool;checked'
  else if Result = 'toggled' then
    Result := 'bool;on'
  else
    Result := inherited;
end;

procedure TQtGroupBox.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then
    Slots.Add(Name + '.setChecked');
  inherited;
end;

procedure TQtGroupBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QGroupBox');
  SetAttribute('Title', 'GroupBox', 'Text');
end;

procedure TQtGroupBox.Paint;
var
  ARect: TRect;
  XPos: Integer;
begin
  inherited;
  Canvas.Pen.Color := $DCDCDC;
  Canvas.Brush.Color := $F0F0F0;
  ARect := ClientRect;
  Canvas.FillRect(ARect);
  ARect.Top := ARect.Top + Canvas.TextHeight('A') div 2;
  Canvas.Brush.Color := $DCDCDC;
  Canvas.FrameRect(ARect);

  if FCheckable then
  begin
    Canvas.Pen.Color := $333333;
    Canvas.Brush.Color := clWhite;
    ARect := Rect(9, 1, 22, 14);
    Canvas.Rectangle(ARect);
    if FChecked then
    begin
      Canvas.Pen.Color := $222222;
      Canvas.MoveTo(11, 7);
      Canvas.LineTo(14, 10);
      Canvas.LineTo(19, 4);
    end;
    XPos := 28;
  end
  else
    XPos := 8;
  Canvas.Brush.Color := $F0F0F0;
  ARect := ClientRect;
  ARect.Left := XPos;
  DrawText(Canvas.Handle, PChar(FTitle), Length(FTitle), ARect, DT_LEFT);
end;

procedure TQtGroupBox.SetTitle(Value: string);
begin
  if Value <> FTitle then
  begin
    FTitle := Value;
    Invalidate;
  end;
end;

procedure TQtGroupBox.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TQtGroupBox.SetCheckable(Value: Boolean);
begin
  if Value <> FCheckable then
  begin
    FCheckable := Value;
    Invalidate;
  end;
end;

procedure TQtGroupBox.SetChecked(Value: Boolean);
begin
  if Value <> FChecked then
  begin
    FChecked := Value;
    Invalidate;
  end;
end;

{ --- TQtTabWidget ------------------------------------------------------------- }

constructor TQtTabWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 87;
  Width := 160;
  Height := 80;
  FTabs := TStringList.Create;
  FTabs.Text := 'Tab 1'#13#10'Tab 2'#13#10'Tab 3'#13#10;
  FTabPosition := North;
  FTabShape := Rounded;
  FUsesScrollButtons := True;
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

function TQtTabWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|TabPosition|TabShape|CurrentIndex|Tabs';
  if ShowAttributes >= 2 then
    Result := Result +
      '|UsesScrollButtons|DocumentMode|TabsClosable|Movable|TabBarAutoHide';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtTabWidget.SetAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'TabPosition') or (Attr = 'TabShape') then
    MakeAttribut(Attr, 'QTabWidget.' + Attr + '.' + Value)
  else if Attr = 'Tabs' then
    MakeTabs
  else
    inherited;
end;

const
  TabEvents =
    '|currentChanged|tabBarClicked|tabBarDoubleClicked|tabCloseRequested';

function TQtTabWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := TabEvents + inherited GetEvents(ShowEvents);
end;

function TQtTabWidget.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, TabEvents) > 0 then
    Result := 'int;index'
  else
    Result := inherited;
end;

procedure TQtTabWidget.GetSlots(Parametertypes: string; Slots: TStrings);
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
var
  Pagename, Str: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteAttributeValues('self.' + Name + '.addTab');
  Partner.DeleteItems(Name, 'Page');
  Str := '';
  for var I := 1 to FTabs.Count do
  begin
    Pagename := 'self.' + Name + 'Page' + IntToStr(I);
    Str := Str + Surround(Pagename + ' = QLabel()');
    Str := Str + Surround(Pagename + '.setText(''Add widgets to this page'')');
    Str := Str + Surround('self.' + Name + '.addTab(' + Pagename + ', ' +
      AsString(FTabs[I - 1]) + ')');
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtTabWidget.Paint;
const
  CPaddingH = 12;
var
  TextHeight, TextWidth, Int, X1Pos, Y1Pos, RowHeight, X1Curr, X2Curr, Y1Curr,
    Y2Curr: Integer;
  Points: array [0 .. 3] of TPoint;

  function ShowHorTab(X1Pos, Y1Pos: Integer; const Str: string;
    TopCorner: Boolean): Integer;
  var
    DeltaX, DeltaY: Integer;
    ARect: TRect;
  begin
    TextWidth := Canvas.TextWidth(Str);
    DeltaX := Min(TextWidth + 2 * CPaddingH, Width - 2);
    DeltaY := TextHeight + 2 * HalfX;

    if (Int = FCurrentIndex) or ((Int = 0) and (FCurrentIndex = -1)) then
    begin
      if TopCorner then
        Y1Pos := Y1Pos - 2;
      DeltaY := DeltaY + 2;
      X1Curr := X1Pos;
      X2Curr := X1Pos + DeltaX;
    end;

    if FTabShape = Rounded then
    begin
      ARect := Rect(X1Pos, Y1Pos, X1Pos + DeltaX, Y1Pos + DeltaY);
      Canvas.Rectangle(ARect);
    end
    else
    begin
      if TopCorner then
      begin
        Points[0] := Point(X1Pos, Y1Pos + DeltaY);
        Points[1] := Point(X1Pos + 7, Y1Pos);
        Points[2] := Point(X1Pos + DeltaX - 7, Y1Pos);
        Points[3] := Point(X1Pos + DeltaX, Y1Pos + DeltaY);
      end
      else
      begin
        Points[0] := Point(X1Pos, Y1Pos);
        Points[1] := Point(X1Pos + 7, Y1Pos + DeltaY);
        Points[2] := Point(X1Pos + DeltaX - 7, Y1Pos + DeltaY);
        Points[3] := Point(X1Pos + DeltaX, Y1Pos);
      end;
      Canvas.Polygon(Points);
    end;
    Canvas.TextOut(X1Pos + CPaddingH, Y1Pos + HalfX, Str);
    Result := X1Pos + DeltaX;
  end;

  function ShowVerTab(X1Pos, Y1Pos: Integer; const Str: string;
    LeftCorner: Boolean): Integer;
  var
    DeltaY, DeltaX, TextWidth: Integer;
    ARect: TRect;
  begin
    TextWidth := Canvas.TextWidth(Str);
    DeltaY := Min(TextWidth + 2 * CPaddingH, Height - 2);
    DeltaX := TextHeight + 2 * HalfX + 2;

    if (Int = FCurrentIndex) or ((Int = 0) and (FCurrentIndex = -1)) then
    begin
      if LeftCorner then
        X1Pos := X1Pos - 2;
      DeltaX := DeltaX + 2;
      Y1Curr := Y1Pos;
      Y2Curr := Y1Pos + DeltaY;
    end;

    if FTabShape = Rounded then
    begin
      ARect := Rect(X1Pos, Y1Pos, X1Pos + DeltaX, Y1Pos + DeltaY);
      Canvas.Rectangle(ARect);
    end
    else
    begin
      if LeftCorner then
      begin
        Points[0] := Point(X1Pos, Y1Pos + 7);
        Points[1] := Point(X1Pos + DeltaX, Y1Pos);
        Points[2] := Point(X1Pos + DeltaX, Y1Pos + DeltaY);
        Points[3] := Point(X1Pos, Y1Pos + DeltaY - 7);
      end
      else
      begin
        Points[0] := Point(X1Pos, Y1Pos);
        Points[1] := Point(X1Pos + DeltaX, Y1Pos + 7);
        Points[2] := Point(X1Pos + DeltaX, Y1Pos + DeltaY - 7);
        Points[3] := Point(X1Pos, Y1Pos + DeltaY);

      end;
      Canvas.Polygon(Points);
    end;
    if LeftCorner then
      Canvas.TextOut(X1Pos + HalfX, Y1Pos + DeltaY - CPaddingH, Str)
    else
      Canvas.TextOut(X1Pos + DeltaX - HalfX, Y1Pos + CPaddingH, Str);
    Result := Y1Pos + DeltaY;
  end;

  procedure SetBrushColor(Int: Integer);
  begin
    if (Int = FCurrentIndex) or ((Int = 0) and (FCurrentIndex = -1)) then
      Canvas.Brush.Color := clWhite // SelectionColor
    else
      Canvas.Brush.Color := clBtnFace;
  end;

begin
  inherited;
  Canvas.Pen.Color := $D9D9D9;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ClientRect);

  TextHeight := Canvas.TextHeight('Hg');
  RowHeight := TextHeight + 2 * HalfX;
  if FTabs.Count > 0 then
    case FTabPosition of
      North:
        begin
          X1Pos := 2;
          Y1Pos := 2;
          for Int := 0 to FTabs.Count - 1 do
          begin
            SetBrushColor(Int);
            X1Pos := ShowHorTab(X1Pos, Y1Pos, FTabs[Int], True);
          end;
          Canvas.Pen.Color := $A0A0A0;
          Y1Pos := RowHeight + 1;
          Canvas.MoveTo(0, Y1Pos);
          Canvas.LineTo(Width, Y1Pos);
          Canvas.Pen.Color := clWhite;
          Canvas.MoveTo(X1Curr, Y1Pos);
          Canvas.LineTo(X2Curr, Y1Pos);
        end;
      South:
        begin
          X1Pos := 2;
          Y1Pos := Height - RowHeight - 1;
          for Int := 0 to FTabs.Count - 1 do
          begin
            SetBrushColor(Int);
            X1Pos := ShowHorTab(X1Pos, Y1Pos, FTabs[Int], False);
          end;
          Canvas.Pen.Color := $A0A0A0;
          Y1Pos := Height - RowHeight - 1;
          Canvas.MoveTo(0, Y1Pos);
          Canvas.LineTo(Width, Y1Pos);
          Canvas.Pen.Color := clWhite;
          Canvas.MoveTo(X1Curr, Y1Pos);
          Canvas.LineTo(X2Curr, Y1Pos);
        end;
      West:
        begin
          Canvas.Font.Orientation := 900;
          X1Pos := 2;
          Y1Pos := 2;
          for Int := 0 to FTabs.Count - 1 do
          begin
            SetBrushColor(Int);
            Y1Pos := ShowVerTab(X1Pos, Y1Pos, FTabs[Int], True);
          end;
          Canvas.Pen.Color := $A0A0A0;
          X1Pos := RowHeight + 3;
          Canvas.MoveTo(X1Pos, 0);
          Canvas.LineTo(X1Pos, Height);
          Canvas.Pen.Color := clWhite;
          Canvas.MoveTo(X1Pos, Y1Curr);
          Canvas.LineTo(X1Pos, Y2Curr);
          Canvas.Font.Orientation := 0;
        end;
      East:
        begin
          Canvas.Font.Orientation := -900;
          X1Pos := Width - RowHeight - 3;
          Y1Pos := 2;
          for Int := 0 to FTabs.Count - 1 do
          begin
            SetBrushColor(Int);
            Y1Pos := ShowVerTab(X1Pos, Y1Pos, FTabs[Int], False);
          end;
          Canvas.Pen.Color := $A0A0A0;
          X1Pos := Width - RowHeight - 3;
          Canvas.MoveTo(X1Pos, 0);
          Canvas.LineTo(X1Pos, Height);
          Canvas.Pen.Color := clWhite;
          Canvas.MoveTo(X1Pos, Y1Curr);
          Canvas.LineTo(X1Pos, Y2Curr);
          Canvas.Font.Orientation := 0;
        end;
    end
  else
  begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.Rectangle(Rect(0, 0, Width, Height));
  end;
end;

procedure TQtTabWidget.SetTabPosition(Value: TTabPosition);
begin
  if Value <> FTabPosition then
  begin
    FTabPosition := Value;
    Invalidate;
  end;
end;

procedure TQtTabWidget.SetTabShape(Value: TTabShape);
begin
  if Value <> FTabShape then
  begin
    FTabShape := Value;
    Invalidate;
  end;
end;

procedure TQtTabWidget.SetCurrentIndex(Value: Integer);
begin
  if Value <> FCurrentIndex then
  begin
    FCurrentIndex := Value;
    Invalidate;
  end;
end;

procedure TQtTabWidget.SetTabs(Value: TStrings);
begin
  if Value <> FTabs then
  begin
    FTabs.Assign(Value);
    Invalidate;
  end;
end;

{ --- TQtMenuBar --------------------------------------------------------------- }

constructor TQtMenuBar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 85;
  Width := 100;
  Height := 21;
  FMenuItems := TStringList.Create;
  FMenuItems.Text :=
    'File'#13#10'  New'#13#10'    Python'#13#10'    XML'#13#10'  Load'#13#10'  Save, Ctrl+Str'#13#10
    + 'Edit'#13#10'  Copy, Ctrl+C'#13#10'  Paste, Ctrl+V'#13#10'  -'#13#10'  Delete'#13#10;
  FMenuItemsOld := TStringList.Create;
end;

destructor TQtMenuBar.Destroy;
begin
  FreeAndNil(FMenuItems);
  FreeAndNil(FMenuItemsOld);
  inherited;
end;

function TQtMenuBar.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|MenuItems|Name';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

const
  MenuBarEvents = '|hovered|triggered';

function TQtMenuBar.GetEvents(ShowEvents: Integer): string;
begin
  Result := MenuBarEvents + inherited GetEvents(ShowEvents);
end;

function TQtMenuBar.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, MenuBarEvents) > 0 then
    Result := 'QAction;action'
  else
    Result := inherited;
end;

procedure TQtMenuBar.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then
    Slots.Add(Name + '.setVisible');
  inherited;
end;

procedure TQtMenuBar.NewWidget(Widget: string = '');
begin
  FMenuItemsOld.Text := '';
  MakeMenuItems;
end;

procedure TQtMenuBar.SetPositionAndSize;
begin
  // do nothing
end;

procedure TQtMenuBar.SetItems(Items: TStrings);
begin
  FMenuItemsOld.Text := FMenuItems.Text;
  if Items.Text <> FMenuItems.Text then
    FMenuItems.Assign(Items);
end;

procedure TQtMenuBar.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited;
end;

function TQtMenuBar.HasSubMenu(MenuItems: TStrings; Num: Integer): Boolean;
begin
  Result := (Num < MenuItems.Count - 1) and
    (LeftSpaces(MenuItems[Num], 2) < LeftSpaces(MenuItems[Num + 1], 2));
end;

function TQtMenuBar.MakeMenuName(MenuStr, Str: string): string;
begin
  if Right(MenuStr, -4) = 'Menu' then
    MenuStr := Copy(MenuStr, 1, Length(MenuStr) - 4);
  Result := MenuStr + OnlyCharsAndDigits(Str) + 'Menu';
end;

function TQtMenuBar.GetCreateMenu: string;
begin
  Result := Indent2 + 'self.' + Name + ' = self.menuBar()';
end;

procedure TQtMenuBar.CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings);
var
  MenuIndent, LeftSpac, Posi: Integer;
  Str, TStr, Shortcut: string;
  MenuName: array [-1 .. 10] of string;
  MenuText: array [-1 .. 10] of string;

  procedure MakeCommand(Indent: Integer);
  var
    Com: string;
  begin
    if TStr = '-' then
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent - 1] +
        '.addSeparator()')
    else
    begin
      Com := MenuName[Indent - 1];
      Com := Com + OnlyCharsAndDigits(TStr) + 'Command';
      PyMethods.Add(Com + '(self):');
      PyMenu.Add(Indent2 + 'self.' + MenuName[Indent - 1] + '.addAction(' +
        AsString(TStr) + Shortcut + ', self.' + Com + ')');
    end;
  end;

begin
  MenuName[-1] := Name;
  MenuText[-1] := '';
  MenuIndent := 0;
  // insert new MenuItems
  for var I := 0 to MenuItems.Count - 1 do
  begin
    Str := MenuItems[I];
    Posi := Pos(',', Str);
    if Posi > 0 then
    begin
      Shortcut := ', QKeySequence(' +
        AsString(Trim(Copy(Str, Posi + 1, Length(Str)))) + ')';
      Str := Copy(Str, 1, Posi - 1);
    end
    else
      Shortcut := '';
    TStr := Trim(Str);
    LeftSpac := LeftSpaces(Str, 2) div 2;
    if LeftSpac < MenuIndent then
      MenuIndent := LeftSpac;
    if LeftSpac > MenuIndent then
    begin
      MakeCommand(MenuIndent);
      Inc(MenuIndent);
    end
    else if HasSubMenu(MenuItems, I) then
    begin // create new menu/submenu
      MenuText[MenuIndent] := TStr;
      MenuName[MenuIndent] := MakeMenuName(MenuName[MenuIndent - 1], Str);
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent] + ' = self.' +
        MenuName[MenuIndent - 1] + '.addMenu(' +
        AsString(MenuText[MenuIndent]) + ')');
      Inc(MenuIndent);
    end
    else
      MakeCommand(MenuIndent);
  end;
end;

procedure TQtMenuBar.MakeMenuItems;
var
  OldMenu: TStringList;
  OldMethods: TStringList;
  NewMenu: TStringList;
  NewMethods: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.ParseAndCreateModel;
  FormatItems(FMenuItems);
  OldMenu := TStringList.Create;
  OldMethods := TStringList.Create;
  NewMenu := TStringList.Create;
  NewMethods := TStringList.Create;

  CalculateMenus(FMenuItemsOld, OldMenu, OldMethods);
  CalculateMenus(FMenuItems, NewMenu, NewMethods);
  Partner.DeleteOldAddNewMethods(OldMethods, NewMethods);

  for var I := 0 to OldMenu.Count - 1 do
    Partner.DeleteLine(OldMenu[I]);
  Partner.DeleteLine(GetCreateMenu);
  if NewMenu.Text <> '' then
    Partner.InsertAtBegin(GetCreateMenu + CrLf + NewMenu.Text);

  FreeAndNil(OldMenu);
  FreeAndNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtMenuBar.Rename(const OldName, NewName, Events: string);
var
  OldMenu: TStringList;
  OldMethods: TStringList;
  NewMenu: TStringList;
  NewMethods: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.ParseAndCreateModel;
  OldMenu := TStringList.Create;
  OldMethods := TStringList.Create;
  NewMenu := TStringList.Create;
  NewMethods := TStringList.Create;
  FMenuItemsOld.Text := FMenuItems.Text;
  Name := OldName;
  Partner.DeleteLine(GetCreateMenu);
  CalculateMenus(FMenuItemsOld, OldMenu, OldMethods);
  Name := NewName;
  CalculateMenus(FMenuItems, NewMenu, NewMethods);
  Partner.DeleteOldAddNewMethods(OldMethods, NewMethods);

  for var I := 0 to OldMenu.Count - 1 do
    Partner.DeleteLine(OldMenu[I]);
  if NewMenu.Text <> '' then
    Partner.InsertAtBegin(GetCreateMenu + CrLf + NewMenu.Text);

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
  FMenuItemsOld.Text := FMenuItems.Text;
  FMenuItems.Clear;
  MakeMenuItems;
end;

procedure TQtMenuBar.Paint;
var
  Str, Item: string;
begin
  SetBounds(0, 0, Parent.ClientWidth, PPIScale(21));
  inherited;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  Str := '';
  for var I := 0 to FMenuItems.Count - 1 do
  begin
    Item := FMenuItems[I];
    if (Item <> '') and (Item[1] <> '-') and (Item[1] <> ' ') then
      Str := Str + Item + '     ';
  end;
  Canvas.TextOut(PPIScale(3), PPIScale(3), Str);
end;

{ --- TQtMenu ----------------------------------------------------------- }

constructor TQtMenu.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 86;
  Width := 33;
  Height := 28;
  FMenuItems.Text :=
    'Cut, Ctrl+X'#13#10'Copy, Ctrl+C'#13#10'Paste, Ctrl+C'#13#10'-'#13#10 +
    'Delete'#13#10'  All'#13#10'  Selected';
  Sizeable := False;
end;

procedure TQtMenu.NewWidget(Widget: string = '');
begin
  FMenuItemsOld.Text := '';
  MakeMenuItems;
end;

function TQtMenu.GetCreateMenu: string;
begin
  Result := Indent2 + 'self.' + Name + ' = QMenu()';
end;

procedure TQtMenu.DeleteWidget;
begin
  inherited;
  Partner.DeleteAttribute('self.' + Name + '.actions');
end;

procedure TQtMenu.Paint;
begin
  Canvas.Rectangle(Rect(0, 0, Width, Height));
  PyIDEMainForm.vilTkInterLight.Draw(Canvas, 7, 4, 16);
end;

{ --- TQtButtonGroup ----------------------------------------------------------- }

constructor TQtButtonGroup.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 76;
  Width := 120;
  Height := 80;
  FColumns := 1;
  FItems := TStringList.Create;
  FOldItems := TStringList.Create;
  FTitle := ' ' + _('Continent') + ' ';
  FCheckboxes := False;
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
  for var I := 0 to FItems.Count - 1 do
    Partner.DeleteAttributeValues(RBName(I));
  Partner.DeleteAttributeValues('self.' + Name + 'BG');
end;

function TQtButtonGroup.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Columns|Items|Title|Checkboxes';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtButtonGroup.SetAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'Items') or (Attr = 'Checkboxes') then
    MakeButtongroupItems
  else if Attr = 'Columns' then
    SetPositionAndSize
  else if Attr = 'Title' then
    MakeTitle(Value)
  else if IsFontAttribute(Attr) then
  begin
    if Title <> '' then
      inherited;
    MakeButtongroupItems;
  end
  else
    inherited;
end;

function TQtButtonGroup.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|buttonClicked|buttonPressed|buttonReleased|buttonToggled' +
    '|idClicked|idPressed|idReleased|idToggled';
end;

procedure TQtButtonGroup.SetEvent(Attr: string);
begin
  if not Partner.hasText('def ' + HandlerNameAndParameter(Attr)) then
    Partner.InsertProcedure(CrLf + MakeHandler(Attr));
  Partner.InsertQtBinding(Name + 'RB', MakeBinding(Attr));
end;

function TQtButtonGroup.HandlerInfo(const Event: string): string;
begin
  if Event = 'buttonToggled' then
    Result := 'QAbstractButton, bool;button, checked'
  else if Event = 'idToggled' then
    Result := 'int, bool;id, checked'
  else if Pos('button', Event) = 1 then
    Result := 'QAbstractButton;button'
  else if Pos('id', Event) = 1 then
    Result := 'int;id'
  else
    Result := inherited;
end;

function TQtButtonGroup.RBName(Num: Integer): string;
begin
  Result := 'self.' + Name + 'RB' + IntToStr(Num);
end;

procedure TQtButtonGroup.MakeButtongroupItems;
var
  Posi: Integer;
  Str, Str1, Str2: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  for var I := 0 to FOldItems.Count - 1 do
    Partner.DeleteAttributeValues(RBName(I));
  Partner.DeleteAttribute('self.' + Name + 'BG');
  Partner.DeleteAttribute('self.' + Name + 'BG.setExclusive');
  // don't delete handlers
  Str1 := '';
  Str2 := Surround('self.' + Name + 'BG = QButtonGroup(self)');
  if FCheckboxes then
    Str2 := Str2 + Surround('self.' + Name + 'BG.setExclusive(False)')
  else
    Str2 := Str2 + Surround('self.' + Name + 'BG.setExclusive(True)');
  for var I := 0 to FItems.Count - 1 do
  begin
    Str := FItems[I];
    Posi := Pos(', ' + _('selected'), Str);
    if Posi > 0 then
      Str := AsString(Copy(Str, 1, Posi - 1))
    else
      Str := AsString(Str);
    if FCheckboxes then
      Str1 := Str1 + Surround(RBName(I) + ' = QCheckBox(' + Str + ', self.' +
        Name + ')')
    else
      Str1 := Str1 + Surround(RBName(I) + ' = QRadioButton(' + Str + ', self.' +
        Name + ')');
    Str1 := Str1 + Surround(RBName(I) + '.setGeometry(0, 0, 0, 0)');
    Str2 := Str2 + Surround('self.' + Name + 'BG.addButton(' + RBName(I) + ')');
    Str2 := Str2 + Surround('self.' + Name + 'BG.setId(' + RBName(I) + ', ' +
      IntToStr(I) + ')');
  end;
  InsertValue(Str1 + Str2);
  FOldItems.Text := FItems.Text;
  SetPositionAndSize;
  Partner.ActiveSynEdit.EndUpdate;
end;

function TQtButtonGroup.MakeBinding(Eventname: string): string;
begin
  Result := Indent2 + 'self.' + Name + 'BG.' + Eventname + '.connect(self.' +
    HandlerName(Eventname) + ')';
end;

procedure TQtButtonGroup.SetPositionAndSize;
var
  Col, Row, ItemsInCol, Line, XPos, YPos, DeltaX, DeltaY, TextHeight: Integer;
  RadioHeight, RadioWidth, ColWidth, RowHeight, ColWidthRest,
    RowHeightRest: Integer;
  XOld, YOld, ColWidthI, RowHeightI: Integer;
  Key: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited;
  Canvas.Font.Assign(Font);
  TextHeight := Canvas.TextHeight('Hg');
  if FTitle = '' then
  begin
    RadioWidth := Width;
    RadioHeight := Height - PPIScale(4);
    DeltaY := PPIScale(2);
  end
  else
  begin
    RadioWidth := Width - PPIScale(4);
    RadioHeight := Height - TextHeight - PPIScale(4);
    DeltaY := PPIScale(2) + TextHeight;
  end;
  DeltaX := Canvas.TextWidth('x');

  if FItems.Count > 0 then
  begin
    ColWidth := RadioWidth div FColumns;
    RowHeight := RadioHeight div ItemsInColumn(1);
    Line := 0;
    XOld := 0;
    ColWidthRest := RadioWidth mod FColumns;
    for Col := 0 to FColumns - 1 do
    begin
      if ColWidthRest > 0 then
        ColWidthI := ColWidth + 1
      else
        ColWidthI := ColWidth;
      if Col = 0 then
        XPos := DeltaX
      else
        XPos := XOld + ColWidthI;
      Dec(ColWidthRest);

      YOld := 0;
      ItemsInCol := ItemsInColumn(Col + 1);
      RowHeightRest := RadioHeight mod ItemsInColumn(1);
      for Row := 0 to ItemsInCol - 1 do
      begin
        if RowHeightRest > 0 then
          RowHeightI := RowHeight + 1
        else
          RowHeightI := RowHeight;
        if Row = 0 then
          YPos := DeltaY
        else
          YPos := YOld + RowHeightI;
        Dec(RowHeightRest);
        Key := RBName(Line) + '.setGeometry';
        SetAttributValue(Key, Key + '(' + IntToStr(PPIUnScale(XPos)) + ', ' +
          IntToStr(PPIUnScale(YPos)) + ', ' + IntToStr(PPIUnScale(ColWidthI)) +
          ', ' + IntToStr(PPIUnScale(RowHeightI)) + ')');
        if Pos(', ' + _('selected'), FItems[Line]) > 0 then
        begin
          Key := RBName(Line) + '.setChecked';
          SetAttributValue(Key, Key + '(True)');
        end;
        Inc(Line);
        YOld := YPos;
      end;
      XOld := XPos;
    end;
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtButtonGroup.MakeTitle(Title: string);
begin
  FTitle := Title;
  MakeAttribut('Title', AsString(FTitle));
  SetPositionAndSize;
end;

procedure TQtButtonGroup.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QGroupBox');
  MakeTitle(' ' + _('Continent') + ' ');
  FItems.Text := DefaultItems;
  FItems[0] := FItems[0] + ', ' + _('selected');
  MakeButtongroupItems;
end;

procedure TQtButtonGroup.SetItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then
  begin
    FOldItems.Text := FItems.Text;
    FItems.Text := Value.Text;
    Invalidate;
  end;
end;

procedure TQtButtonGroup.SetColumns(Value: Integer);
begin
  if (FColumns <> Value) and (Value > 0) then
  begin
    FColumns := Value;
    Invalidate;
  end;
end;

procedure TQtButtonGroup.SetTitle(Value: string);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    Invalidate;
  end;
end;

procedure TQtButtonGroup.SetCheckboxes(Value: Boolean);
begin
  if FCheckboxes <> Value then
  begin
    FCheckboxes := Value;
    Invalidate;
  end;
end;

function TQtButtonGroup.ItemsInColumn(Num: Integer): Integer;
var
  Quot, Rest: Integer;
begin
  Quot := FItems.Count div FColumns;
  Rest := FItems.Count mod FColumns;
  if Num <= Rest then
    Result := Quot + 1
  else
    Result := Quot;
end;

procedure TQtButtonGroup.Rename(const OldName, NewName, Events: string);
begin
  inherited;
  Partner.ReplaceWord('self.' + OldName + 'BG', 'self.' + NewName + 'BG', True);
end;

procedure TQtButtonGroup.Paint;
const
  CRadius = 7;
var
  ColumnWidth, RowHeight, RadioHeight, LabelHeight, Col, Row, YCenter,
    ItemsInCol, Line, XPos, YPos, TextHeight, Posi, Radius: Integer;
  ARect: TRect;
  Str: string;
begin
  FOldItems.Text := FItems.Text;
  inherited;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ClientRect);
  TextHeight := Canvas.TextHeight('Hg');
  Radius := PPIScale(CRadius);
  LabelHeight := 0;
  RadioHeight := Height;
  ARect := ClientRect;
  Canvas.Pen.Color := $BABABA;
  if FTitle <> '' then
    ARect.Top := TextHeight div 2;
  Canvas.Rectangle(ARect);

  if FTitle <> '' then
  begin
    ARect.Top := TextHeight div 2;
    LabelHeight := TextHeight;
    RadioHeight := Height - TextHeight;
    Canvas.Rectangle(ARect);
    Canvas.TextOut(PPIScale(10), 0, FTitle);
  end;

  if FItems.Count > 0 then
  begin
    Canvas.Pen.Color := $333333;
    ColumnWidth := Width div FColumns;
    RowHeight := RadioHeight div ItemsInColumn(1);
    Line := 0;
    for Col := 1 to FColumns do
    begin
      ItemsInCol := ItemsInColumn(Col);
      for Row := 1 to ItemsInCol do
      begin
        Str := FItems[Line];
        Posi := Pos(', ' + _('selected'), Str);
        if Posi > 0 then
          Str := Copy(Str, 1, Posi - 1);
        XPos := PPIScale(4) + (Col - 1) * ColumnWidth;
        YPos := LabelHeight + PPIScale(2) + (Row - 1) * RowHeight;
        Canvas.Brush.Color := clWhite;
        YCenter := YPos + RowHeight div 2 - TextHeight div 2;
        if FCheckboxes then
        begin
          ARect := Rect(XPos, YPos + PPIScale(3), XPos + PPIScale(13),
            YPos + PPIScale(16));
          Canvas.Rectangle(ARect);
          if Posi > 0 then
          begin
            Canvas.Pen.Width := PPIScale(2);
            Canvas.MoveTo(XPos + PPIScale(3), YCenter + PPIScale(6));
            Canvas.LineTo(XPos + PPIScale(4), YCenter + PPIScale(9));
            Canvas.LineTo(XPos + PPIScale(9), YCenter + PPIScale(3));
            Canvas.Pen.Width := 1;
          end;
        end
        else
        begin
          YCenter := YPos + RowHeight div 2 - Radius;
          Canvas.Ellipse(XPos, YCenter, XPos + 2 * Radius,
            YCenter + 2 * Radius);
          if Posi > 0 then
          begin
            Canvas.Brush.Color := clBlack;
            Canvas.Ellipse(XPos + PPIScale(3), YCenter + PPIScale(3),
              XPos + 2 * Radius - PPIScale(3), YCenter + 2 * Radius -
              PPIScale(3));
            Canvas.Brush.Color := clWhite;
          end;
        end;
        Canvas.Brush.Color := clBtnFace;
        YCenter := YPos + RowHeight div 2 - TextHeight div 2;
        ARect := Rect(XPos + PPIScale(19), YCenter, Col * ColumnWidth,
          YCenter + RowHeight);
        Canvas.TextRect(ARect, Str);
        Inc(Line);
      end;
    end;
  end;
end;

{ --- TQtMainWindow ------------------------------------------------------------ }

function TQtMainWindow.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Title|Animated|DockNestingEnabled|DocumentMode|TabShape|ToolButtonStyle';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtMainWindow.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'TabShape' then
    MakeAttribut(Attr, 'QTabWidget.' + Value)
  else if Attr = 'ToolButtonStyle' then
    MakeAttribut(Attr, 'Qt.ToolButtonStyle.' + Value)
  else if Attr = 'Title' then
  begin
    var
    Str := 'self.setWindowTitle';
    SetAttributValue(Str, Str + '(' + AsString(Value) + ')');
  end
  else
    inherited;
end;

function TQtMainWindow.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|iconSizeChanged|tabifiedDockWidgetActivated|toolButtonStyleChanged';
  // ToDo
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtMainWindow.HandlerInfo(const Event: string): string;
begin
  if Event = 'iconSizeChanged' then
    Result := 'QSize;iconSize'
  else if Event = 'tabifiedDockWidgetActivated' then
    Result := 'QDockWidget;dockWidget'
  else if Event = 'toolButtonStyleChanged' then
    Result := 'QToolButtonStyle;toolButtonStyle'
  else
    Result := inherited;
end;

procedure TQtMainWindow.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'bool' then
  begin
    Slots.Add(Name + '.setAnimated');
    Slots.Add(Name + '.setDockNestingEnabled');
  end;
  inherited;
end;

function TQtMainWindow.HandlerName(const Event: string): string;
begin
  Result := 'MainWindow_' + Event;
end;

end.
