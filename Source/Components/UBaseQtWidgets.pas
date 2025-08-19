{ -------------------------------------------------------------------------------
  Unit:     UBaseQtWidgets
  Author:   Gerhard Röhner
  Date:     April 2022
  Purpose:  base widget for PyQt
  ------------------------------------------------------------------------------- }

unit UBaseQtWidgets;

interface

uses
  Windows,
  Classes,
  UBaseWidgets;

const
  CrLf = #13#10;

type

  TFocusPolicy = (NoFocus, TabFocus, ClickFocus, StrongFocus, WheelFocus);

  TContextMenuPolicy = (NoContextMenu, DefaultContextMenu, ActionsContextMenu,
    CustomContextMenu, PreventContextMenu);

  TLayoutDirection = (LeftToRight, RightToLeft, LayoutDirectionAuto);

  TAlignmentHorizontal = (AlignLeft, AlignRight, AlignHCenter, AlignJustify);

  TAlignmentVertical = (AlignTop, AlignBottom, AlignVCenter, AlignBaseline);

  TOrientation = (Vertical, Horizontal);

  TBaseQtWidget = class(TBaseWidget)
  private
    FEnabled: Boolean;
    FMouseTracking: Boolean;
    FTabletTracking: Boolean;
    FFocusPolicy: TFocusPolicy;
    FContextMenuPolicy: TContextMenuPolicy;
    FContextMenu: string;
    FAcceptDrops: Boolean;
    FToolTip: string;
    FToolTipDuration: Integer;
    FStatusTip: string;
    FWhatsThis: string;
    FAccessibleName: string;
    FAccessibleDescription: string;
    FLayoutDirection: TLayoutDirection;
    FAutoFillBackground: Boolean;
    FStyleSheet: string;
    FHalfX: Integer;
    FCustomContextMenuRequested: string;
    FLeftSpace: Integer;
    FTopSpace: Integer;
    FVisible: Boolean;
    FWindowIconChanged: string;
    FWindowTitleChanged: string;
    procedure MakeContextMenu(const Value: string);
    function GetContainer: string;
    function GetAttrAsKey(const Attr: string): string;
  protected
    function HalfX: Integer;
    procedure MakeAttribut(const Attr, Value: string);
    procedure CalculateText(const Text: string; var TextWidth, TextHeight: Integer;
      var StringList: TStringList);
    function InnerRect: TRect; virtual;
    procedure PaintScrollbar(Rect: TRect; Horizontal: Boolean);
    procedure PaintScrollbars(Horizontal, Vertical: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; virtual;
    function HandlerParameter(const Event: string): string; override;
    function Parametertypes(const Event: string): string;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); virtual;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure SetEvent(const Attr: string); override;
    procedure DeleteEvents; override;
    procedure DeleteWidget; override;
    procedure DeleteEventHandler(const Event: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    function MakeBinding(const Eventname: string): string; override;
    function MakeHandler(const Event: string): string; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetPositionAndSize; override;
    function GetNameAndType: string; override;
    procedure MakeFont; override;
    function GetType: string; override;
    property LeftSpace: Integer read FLeftSpace write FLeftSpace;
    property TopSpace: Integer read FTopSpace write FTopSpace;
  published
    // common attribute for QWidget
    property Enabled: Boolean read FEnabled write FEnabled;
    property MouseTracking: Boolean read FMouseTracking write FMouseTracking;
    property TabletTracking: Boolean read FTabletTracking write FTabletTracking;
    property FocusPolicy: TFocusPolicy read FFocusPolicy write FFocusPolicy;
    property ContextMenuPolicy: TContextMenuPolicy read FContextMenuPolicy
      write FContextMenuPolicy;
    property ContextMenu: string read FContextMenu write FContextMenu;
    property AcceptDrops: Boolean read FAcceptDrops write FAcceptDrops;
    property ToolTip: string read FToolTip write FToolTip;
    property ToolTipDuration: Integer read FToolTipDuration
      write FToolTipDuration;
    property StatusTip: string read FStatusTip write FStatusTip;
    property WhatsThis: string read FWhatsThis write FWhatsThis;
    property AccessibleName: string read FAccessibleName write FAccessibleName;
    property AccessibleDescription: string read FAccessibleDescription
      write FAccessibleDescription;
    property LayoutDirection: TLayoutDirection read FLayoutDirection
      write FLayoutDirection;
    property AutoFillBackground: Boolean read FAutoFillBackground
      write FAutoFillBackground;
    property StyleSheet: string read FStyleSheet write FStyleSheet;
    property Visible: Boolean read FVIsible write FVisible;
    // signals
    property customContextMenuRequested: string read FCustomContextMenuRequested
      write FCustomContextMenuRequested;
    property windowIconChanged: string read FWindowIconChanged
      write FWindowIconChanged;
    property windowTitleChanged: string read FWindowTitleChanged
      write FWindowTitleChanged;
  end;

implementation

uses
  Math,
  Controls,
  Graphics,
  SysUtils,
  UITypes,
  StringResources,
  UGUIForm,
  UUtils,
  UConfiguration;

constructor TBaseQtWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Width := 120;
  Height := 80;
  Enabled := True;
  ToolTipDuration := -1;
  FocusPolicy := NoFocus;
  LayoutDirection := LeftToRight;
  ContextMenuPolicy := DefaultContextMenu;
  Font.Name := 'Segoe UI';
  Font.Size := GuiPyOptions.GuiFontSize;
  Font.Style := [];
  HelpType := htContext;
  Sizeable := True;
  FVisible := True;
end;

function TBaseQtWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Name|';
  if ShowAttributes = 3 then
    Result := '|Name|Left|Top|Height|Width|ToolTip|ToolTipDuration' +
      '|MouseTracking|TabletTracking|FocusPolicy' +
      '|ContextMenuPolicy|ContextMenu|AcceptDrops|StatusTip|WhatsThis' +
      '|AccessibleName|AccessibleDescription|LayoutDirection' +
      '|AutoFillBackground|StyleSheet|Cursor|Font|Enabled|Visible|';
end;

function TBaseQtWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := '';
  if (ShowEvents = 3) or (ClassName = 'TQtMainWindow') then
    Result := '|customContextMenuRequested|windowIconChanged|windowTitleChanged';
  Result := Result + '|';
end;

function TBaseQtWidget.HandlerInfo(const Event: string): string;
begin
  if Event = 'customContextMenuRequested' then
    Result := 'QPoint pos'
  else if Event = 'windowIconChanged' then
    Result := 'QIcon icon'
  else if Event = 'windowTitleChanged' then
    Result := 'QString title'
  else
    Result := '';
end;

function TBaseQtWidget.HandlerParameter(const Event: string): string;
var
  Str: string;
  Posi: Integer;
begin
  Str := HandlerInfo(Event);
  Posi := Pos(';', Str);
  if Posi > 0 then
    Result := 'self, ' + Copy(Str, Posi + 1, Length(Str))
  else
    Result := 'self';
end;

function TBaseQtWidget.Parametertypes(const Event: string): string;
var
  Str: string;
  Posi: Integer;
begin
  Str := HandlerInfo(Event);
  Posi := Pos(';', Str);
  if Posi > 0 then
    Result := Copy(Str, 1, Posi - 1)
  else
    Result := '';
end;

procedure TBaseQtWidget.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.close');
    Slots.Add(Name + '.hide');
    Slots.Add(Name + '.lower');
    Slots.Add(Name + '.raise');
    Slots.Add(Name + '.repaint');
    Slots.Add(Name + '.setFocus');
    Slots.Add(Name + '.show');
    Slots.Add(Name + '.showFullScreen');
    Slots.Add(Name + '.showMaximized');
    Slots.Add(Name + '.showMinimized');
    Slots.Add(Name + '.showNormal');
    Slots.Add(Name + '.update');
  end
  else if Parametertypes = 'bool' then
  begin
    Slots.Add(Name + '.setDisabled');
    Slots.Add(Name + '.setEnabled');
    Slots.Add(Name + '.setHidden');
    Slots.Add(Name + '.setVisible');
    Slots.Add(Name + '.setWindowModified');
  end
  else if Parametertypes = 'QString' then
  begin
    Slots.Add(Name + '.setStyleSheet');
    Slots.Add(Name + '.setWindowTitle');
  end;
end;

procedure TBaseQtWidget.SetPositionAndSize;
begin
  var
  Rect := ClientRect;
  var
  Key := 'self.' + Name + '.setGeometry';
  SetAttributValue(Key, Key + '(' + IntToStr(PPIUnScale(Left)) + ', ' +
    IntToStr(PPIUnScale(Top)) + ', ' + IntToStr(PPIUnScale(Rect.Right)) + ', ' +
    IntToStr(PPIUnScale(Rect.Bottom)) + ')');
end;

function TBaseQtWidget.GetAttrAsKey(const Attr: string): string;
begin
  Result := 'self.' + Name + '.set' + Attr;
end;

procedure TBaseQtWidget.SetAttribute(const Attr, Value, Typ: string);
begin
  if IsFontAttribute(Attr) then
    MakeFont
  else if Attr = 'Cursor' then
    MakeAttribut(Attr, 'QCursor(Qt.CursorShape.' + Value + ')')
  else if Attr = 'ContextMenu' then
    MakeContextMenu(Value)
  else if (Attr = 'FocusPolicy') or (Attr = 'ContextMenuPolicy') or
    (Attr = 'LayoutDirection') then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if (Typ = 'string') or (Copy(Typ, 1, 1) = 'T') then // enum type, TColor
    if Value = '' then
      Partner.DeleteAttribute(GetAttrAsKey(Attr))
    else
      MakeAttribut(Attr, AsString(Value))
  else if Value = '' // Typ int, real, ...
  then
    Partner.DeleteAttribute(GetAttrAsKey(Attr))
  else
    MakeAttribut(Attr, Value);
end;

procedure TBaseQtWidget.SetEvent(const Attr: string);
begin
  if not Partner.hasText('def ' + HandlerNameAndParameter(Attr)) then
    Partner.InsertProcedure(CrLf + MakeHandler(Attr));
  Partner.InsertQtBinding(Name, MakeBinding(Attr));
end;

procedure TBaseQtWidget.MakeContextMenu(const Value: string);
begin
  var
  Str := 'self.' + Name + '.addActions';
  if Value = '' then
    Partner.DeleteAttribute(Str)
  else
  begin
    MakeAttribut('ContextMenuPolicy',
      'Qt.ContextMenuPolicy.ActionsContextMenu');
    SetAttributValue(Str, Str + '(self.' + Value + '.actions())');
  end;
end;

procedure TBaseQtWidget.MakeAttribut(const Attr, Value: string);
var
  Str: string;
begin
  if Name = '' then
    Str := 'self.set' + Attr
  else
    Str := 'self.' + Name + '.set' + Attr;
  SetAttributValue(Str, Str + '(' + Value + ')');
end;

procedure TBaseQtWidget.Paint;
begin
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := clWindowText;
  FHalfX := Canvas.TextWidth('x') div 2;
end;

procedure TBaseQtWidget.Resize;
begin
end;

function TBaseQtWidget.MakeBinding(const Eventname: string): string;
begin
  Result := Indent2 + 'self.' + Name + '.' + Eventname + '.connect(self.' +
    HandlerName(Eventname) + ')';
end;

function TBaseQtWidget.MakeHandler(const Event: string): string;
begin
  Result := Indent1 + 'def ' + HandlerNameAndParameter(Event) + CrLf + Indent2 +
    LNGInsertSourceCodeHere + CrLf + Indent2 + 'pass' + CrLf;
end;

procedure TBaseQtWidget.DeleteWidget;
begin
  DeleteEvents;
  Partner.DeleteComponent(Self);
end;

procedure TBaseQtWidget.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  var
  Binding := MakeBinding(Event);
  Partner.DeleteBinding(Copy(Binding, 1, Pos('(', Binding)));
end;

procedure TBaseQtWidget.DeleteEvents;
var
  Posi: Integer;
  Str, Event, Binding: string;
  SL1, SL2: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  Str := GetEvents(3) + '|';
  Posi := Pos('|', Str);
  while Posi > 0 do
  begin
    Event := UUtils.Left(Str, Posi - 1);
    if Event <> '' then
    begin
      Binding := MakeBinding(Event);
      Partner.DeleteBinding(Copy(Binding, 1, Pos('(', Binding)));
      SL1.Add(HandlerNameAndParameter(Event));
    end;
    Delete(Str, 1, Posi);
    Posi := Pos('|', Str);
  end;
  Partner.DeleteOldAddNewMethods(SL1, SL2);
  FreeAndNil(SL1);
  FreeAndNil(SL2);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseQtWidget.NewWidget(const Widget: string = '');
begin
  SetAttributValue('self.' + Name, 'self.' + Name + ' = ' + Widget + '(' +
    GetContainer + ')');
  SetPositionAndSize;
  MakeFont;
end;

function TBaseQtWidget.GetType: string;
begin
  Result := 'Q' + Copy(ClassName, 4, Length(ClassName));
end;

function TBaseQtWidget.GetNameAndType: string;
begin
  Result := Name + ': ' + GetType;
end;

function TBaseQtWidget.GetContainer: string;
begin
  if (Parent = nil) or (Parent is TFGuiForm) then
    Result := 'self'
  else
    Result := 'self.' + Parent.Name;
end;

procedure TBaseQtWidget.MakeFont;
var
  Str1, Str2: string;
begin
  if Name = '' then
    Exit;
  Str1 := 'self.' + Name + '.setFont';
  Str2 := '(QFont(' + AsString(Font.Name) + ', ' + IntToStr(Font.Size);
  if fsBold in Font.Style then
    Str2 := Str2 + ', QFont.Weight.Bold';
  if fsItalic in Font.Style then
    Str2 := Str2 + ', italic=True';
  Str2 := Str2 + '))';
  SetAttributValue(Str1, Str1 + Str2);
  Str1 := 'self.' + Name + '.font().setUnderline';
  if fsUnderline in Font.Style then
    SetAttributValue(Str1, Str1 + '(True)')
  else
    Partner.DeleteAttribute(Str1);
  Str1 := 'self.' + Name + '.font().setStrikeOut';
  if fsStrikeOut in Font.Style then
    SetAttributValue(Str1, Str1 + '(True)')
  else
    Partner.DeleteAttribute(Str1);
  Invalidate;
end;

procedure TBaseQtWidget.CalculateText(const Text: string;
  var TextWidth, TextHeight: Integer; var StringList: TStringList);
begin
  StringList.Text := MyStringReplace(Text, '\n', CrLf);
  TextWidth := 0;
  for var I := 0 to StringList.Count - 1 do
    TextWidth := Max(TextWidth, Canvas.TextWidth(StringList[I]));
  TextHeight := StringList.Count * Canvas.TextHeight('Hg');
end;

function TBaseQtWidget.InnerRect: TRect;
begin
  Result := ClientRect;
  Result.Inflate(-1, -1);
end;

function TBaseQtWidget.HalfX: Integer;
begin
  Result := FHalfX;
end;

procedure TBaseQtWidget.PaintScrollbar(Rect: TRect; Horizontal: Boolean);
var
  Int3, Int4, Int6, Int9, Int10, Int18, Mid: Integer;
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(Rect);
  Canvas.Brush.Color := $CDCDCD;
  Canvas.Pen.Color := clWhite;
  Int3 := PPIScale(3);
  Int4 := PPIScale(4);
  Int6 := PPIScale(6);
  Int9 := PPIScale(9);
  Int10 := PPIScale(10);
  Int18 := PPIScale(18);
  if Horizontal then
  begin
    Canvas.MoveTo(Rect.Left, Rect.Top);
    Canvas.LineTo(Rect.Right, Rect.Top);
    Canvas.Pen.Color := $606060;
    Mid := (Rect.Top + Rect.Bottom) div 2;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Rect.Left + Int9 + I, Mid - Int3);
      Canvas.LineTo(Rect.Left + Int6 + I, Mid);
      Canvas.LineTo(Rect.Left + Int10 + I, Mid + Int4);
    end;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Rect.Right - Int9 + I, Mid - Int3);
      Canvas.LineTo(Rect.Right - Int6 + I, Mid);
      Canvas.LineTo(Rect.Right - Int10 + I, Mid + Int4);
    end;
    Rect.Left := Rect.Left + Int18;
    Rect.Right := Rect.Left + Int18;
  end
  else
  begin
    Canvas.MoveTo(Rect.Left, Rect.Top);
    Canvas.LineTo(Rect.Left, Rect.Bottom);
    Canvas.Pen.Color := $606060;
    Mid := (Rect.Left + Rect.Right) div 2;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Mid - Int3, Rect.Top + Int9 + I);
      Canvas.LineTo(Mid, Rect.Top + Int6 + I);
      Canvas.LineTo(Mid + Int4, Rect.Top + Int10 + I);
    end;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Mid - Int3, Rect.Bottom - Int9 + I);
      Canvas.LineTo(Mid, Rect.Bottom - Int6 + I);
      Canvas.LineTo(Mid + Int4, Rect.Bottom - Int10 + I);
    end;
    Rect.Top := Rect.Top + Int18;
    Rect.Bottom := Rect.Top + Int18;
  end;
  Rect.Inflate(-1, -1);
  Canvas.FillRect(Rect);
end;

procedure TBaseQtWidget.PaintScrollbars(Horizontal, Vertical: Boolean);
begin
  var
  Rect := ClientRect;
  Rect.Inflate(-1, -1);
  if Horizontal then
  begin
    Rect.Top := Rect.Bottom - 16;
    if Vertical then
      Rect.Right := Rect.Right - 16;
    PaintScrollbar(Rect, True);
  end;
  Rect := ClientRect;
  Rect.Inflate(-1, -1);
  if Vertical then
  begin
    Rect.Left := Rect.Right - 16;
    if Horizontal then
      Rect.Bottom := Rect.Bottom - 16;
    PaintScrollbar(Rect, False);
  end;
  if Horizontal and Vertical then
  begin
    Canvas.Brush.Color := clBtnFace;
    Rect := ClientRect;
    Rect.Inflate(-1, -1);
    Rect.Top := Rect.Bottom - 16;
    Rect.Left := Rect.Right - 16;
    Canvas.FillRect(Rect);
  end;
end;

end.
