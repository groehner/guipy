{-------------------------------------------------------------------------------
 Unit:     UBaseQtWidgets
 Author:   Gerhard Röhner
 Date:     April 2022
 Purpose:  base widget for PyQt
-------------------------------------------------------------------------------}

unit UBaseQtWidgets;

interface

uses
  Windows, Messages, Controls, Graphics, Classes,
  ELEvents, UBaseWidgets, frmEditor;

const CrLf = sLineBreak;

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
    FEnabled: boolean;
    FMouseTracking: boolean;
    FTabletTracking: boolean;
    FFocusPolicy: TFocusPolicy;
    FContextMenuPolicy: TContextMenuPolicy;
    FContextMenu: string;
    FAcceptDrops: boolean;
    FToolTip: string;
    FToolTipDuration: integer;
    FStatusTip: string;
    FWhatsThis: string;
    FAccessibleName: string;
    FAccessibleDescription: string;
    FLayoutDirection: TLayoutDirection;
    FAutoFillBackground: boolean;
    FStyleSheet: string;
    FHalfX: integer;
    FCustomContextMenuRequested: string;
    FWindowIconChanged: string;
    FWindowTitleChanged: string;
    procedure MakeContextMenu(Value: string);
    procedure MakeFont;
    function getType: String;
    function getContainer: string;
    function getAttrAsKey(Attr: string): string;
  protected
    TopSpace: integer;
    LeftSpace: integer;
    function HalfX: integer;
    procedure MakeAttribut(Attr, Value: string);
    procedure CalculateText(s: string; var tw, th: integer; var SL: TStringList);
    function InnerRect: TRect; virtual;
    procedure PaintScrollbar(R: TRect; horizontal: boolean);
    procedure PaintScrollbars(horizontal, vertical: boolean);
  public
    constructor Create(aOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; virtual;
    function HandlerParameter(const event: string): string; override;
    function Parametertypes(const event: string): string;
    procedure getSlots(Parametertypes: string; Slots: TStrings); virtual;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure setEvent(Attr: string); override;
    procedure DeleteEvents; override;
    procedure DeleteWidget; override;
    procedure DeleteEventHandler(const Event: string); override;
    procedure NewWidget(Widget: String = ''); override;
    function MakeBinding(Eventname: string): string; override;
    function MakeHandler(const event: string ): string; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetPositionAndSize; override;
    function getNameAndType: String; override;
  published
    // common attribute for QWidget
    property Enabled: boolean read FEnabled write FEnabled;
    property MouseTracking: boolean read FMouseTracking write FMouseTracking;
    property TabletTracking: boolean read FTabletTracking write FTabletTracking;
    property FocusPolicy: TFocusPolicy read FFocusPolicy write FFocusPolicy;
    property ContextMenuPolicy: TContextMenuPolicy read FContextMenuPolicy write FContextMenuPolicy;
    property ContextMenu: string read FContextMenu write FContextMenu;
    property AcceptDrops: boolean read FAcceptDrops write FAcceptDrops;
    property ToolTip: string read FToolTip write FToolTip;
    property ToolTipDuration: integer read FToolTipDuration write FToolTipDuration;
    property StatusTip: string read FStatusTip write FStatusTip;
    property WhatsThis: string read FWhatsThis write FWhatsThis;
    property AccessibleName: string read FAccessibleName write FAccessibleName;
    property AccessibleDescription: string read FAccessibleDescription write FAccessibleDescription;
    property LayoutDirection: TLayoutDirection read FLayoutDirection write FLayoutDirection;
    property AutoFillBackground: boolean read FAutoFillBackground write FAutoFillBackground;
    property StyleSheet: string read FStyleSheet write FStyleSheet;
    property Font;
    // signals
    property customContextMenuRequested: string read FcustomContextMenuRequested write FcustomContextMenuRequested;
    property windowIconChanged: string read FWindowIconChanged write FWindowIconChanged;
    property windowTitleChanged: string read FWindowTitleChanged write FWindowTitleChanged;
  end;

implementation

uses SysUtils, TypInfo, Math, UITypes, UGuiForm, UTKMiscBase, UTTKMiscBase,
     UGUIDesigner, UObjectInspector, UKoppel, UConfiguration, UUtils;

constructor TBaseQtWidget.create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Width:= 120;
  Height:= 80;
  Enabled:= true;
  ToolTipDuration:= -1;
  FocusPolicy:= NoFocus;
  LayoutDirection:= LeftToRight;
  ContextMenuPolicy:= DefaultContextMenu;
  Canvas.Font.PixelsPerInch:= 72;
  Font.PixelsPerInch:= 72;
  Font.Name:= 'MS Shell Dlg 2';
  Font.Size:= 8;
  Font.Style:= [];
  HelpType:= htContext;
  Sizeable:= true;
end;

function TBaseQtWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Name|';
  if ShowAttributes = 3 then
    Result:= '|Name|Left|Top|Height|Width|ToolTip|ToolTipDuration' +
             '|MouseTracking|TabletTracking|FocusPolicy' +
             '|ContextMenuPolicy|ContextMenu|AcceptDrops|StatusTip|WhatsThis' +
             '|AccessibleName|AccessibleDescription|LayoutDirection' +
             '|AutoFillBackground|StyleSheet|Cursor|Font|Enabled|';
end;

function TBaseQtWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= '';
  if (ShowEvents = 3) or (Classname = 'TQtMainWindow') then
    Result:= '|customContextMenuRequested|windowIconChanged|windowTitleChanged';
  Result:= Result + '|';
end;

function TBaseQtWidget.HandlerInfo(const event: string): string;
begin
  if event = 'customContextMenuRequested' then
    Result:= 'QPoint pos'
  else if event = 'windowIconChanged' then
    Result:= 'QIcon icon'
  else if event = 'windowTitleChanged' then
    Result:= 'QString title'
  else
    Result:= '';
end;

function TBaseQtWidget.HandlerParameter(const event: string): string;
  var s: string; p: integer;
begin
  s:= HandlerInfo(event);
  p:= Pos(';', s);
  if p > 0
    then Result:= 'self, ' + copy(s, p+1, length(s))
    else Result:= 'self';
end;

function TBaseQtWidget.Parametertypes(const event: string): string;
  var s: string; p: integer;
begin
  s:= HandlerInfo(event);
  p:= Pos(';', s);
  if p > 0
    then Result:= copy(s, 1, p-1)
    else Result:= '';
end;

procedure TBaseQtWidget.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
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
  end else if Parametertypes = 'bool' then begin
    Slots.Add(Name + '.setDisabled');
    Slots.Add(Name + '.setEnabled');
    Slots.Add(Name + '.setHidden');
    Slots.Add(Name + '.setVisible');
    Slots.Add(Name + '.setWindowModified');
  end else if Parametertypes = 'QString' then begin
    Slots.Add(Name + '.setStyleSheet');
    Slots.Add(Name + '.setWindowTitle');
  end;
end;

procedure TBaseQtWidget.SetPositionAndSize;
  var R: TRect; key: string;
begin
  R:= ClientRect;
  key:= 'self.' + Name + '.setGeometry';
  setAttributValue(key, key + '(' + IntToStr(Left) + ', ' + IntToStr(Top) +
    ', ' + IntToStr(R.Right) + ', ' + IntToStr(R.Bottom) + ')');
end;

function TBaseQtWidget.getAttrAsKey(Attr: string): string;
begin
  Result:= 'self.' + Name + '.set' + Attr;
end;

procedure TBaseQtWidget.setAttribute(Attr, Value, Typ: string);
begin
  if isFontAttribute(Attr)then
    MakeFont
  else if Attr = 'Cursor' then  // ok
    MakeAttribut(Attr, 'QCursor(Qt.CursorShape.' + Value + ')')
  else if Attr = 'ContextMenu' then
    MakeContextMenu(Value)
  else if (Attr = 'FocusPolicy') or
          (Attr = 'ContextMenuPolicy') or
          (Attr = 'LayoutDirection')  then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if (Typ = 'string') or (copy(Typ, 1, 1) = 'T') then  // enum type, TColor
    if Value = ''
      then Partner.DeleteAttribute(getAttrAsKey(Attr))
      else MakeAttribut(Attr, asString(Value))
  else
    if Value = ''                       // Typ int, real, ...
      then Partner.DeleteAttribute(getAttrAsKey(Attr))
      else MakeAttribut(Attr, Value)
end;

procedure TBaseQtWidget.setEvent(Attr: string);
begin
  if not Partner.hasText('def ' + HandlerNameAndParameter(Attr)) then
    Partner.InsertProcedure(CrLf + MakeHandler(Attr));
  Partner.InsertQtBinding(Name, MakeBinding(Attr));
end;

procedure TBaseQtWidget.MakeContextMenu(Value: string);
begin
  var s:= 'self.' + Name  + '.addActions';
  if Value = '' then
    Partner.DeleteAttribute(s)
  else begin
    MakeAttribut('ContextMenuPolicy', 'Qt.ContextMenuPolicy.ActionsContextMenu');
    setAttributValue(s, s + '(self.' + Value + '.actions())');
  end;
end;

procedure TBaseQtWidget.MakeAttribut(Attr, Value: String);
  var s: string;
begin
  if Name = ''
    then s:= 'self.set' +  Attr
    else s:= 'self.' + Name  + '.set' +  Attr;
  setAttributValue(s, s + '(' + Value + ')');
end;

procedure TBaseQtWidget.Paint;
begin
  Canvas.Font.Assign(Font);
  Canvas.Font.Size:= Font.Size + (Font.Size + 1) div 3;
  Canvas.Font.Color:= clWindowText;
  FHalfX:= Canvas.TextWidth('x') div 2;
end;

procedure TBaseQtWidget.Resize;
begin
end;

function TBaseQtWidget.MakeBinding(Eventname: string): string;
begin
  Result:= Indent2 + 'self.' + Name + '.' + Eventname + '.connect(self.' + HandlerName(Eventname) + ')';
end;

function TBaseQtWidget.MakeHandler(const event: string ): string;
begin
  Result:= Indent1 + 'def ' + HandlerNameAndParameter(Event) + CrLf +
           Indent2 +     '# ToDo insert source code here' + CrLf +
           Indent2 +     'pass' + CrLf;
end;

procedure TBaseQtWidget.DeleteWidget;
begin
  DeleteEvents;
  Partner.DeleteComponent(Self);
end;

procedure TBaseQtWidget.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  Partner.DeleteBinding(MakeBinding(Event));
end;

procedure TBaseQtWidget.DeleteEvents;
  var p: integer; s, Event: string; SL1, SL2: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  SL1:= TStringList.Create;
  SL2:= TStringList.Create;
  s:= getEvents(3) + '|';
  p:= Pos('|', s);
  while p > 0 do begin
    Event:= UUtils.Left(s, p-1);
    if Event <> '' then begin
      Partner.DeleteBinding(MakeBinding(Event));
      SL1.Add(HandlerNameAndParameter(Event));
    end;
    delete(s, 1, p);
    p:= Pos('|', s);
  end;
  Partner.DeleteOldAddNewMethods(SL1, SL2);
  FreeAndNil(SL1);
  FreeAndNil(SL2);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseQtWidget.NewWidget(Widget: String = '');
begin
  setAttributValue('self.' + Name, 'self.' + Name + ' = ' + Widget + '(' + getContainer + ')');
  setPositionAndSize;
end;

function TBaseQtWidget.getType;
begin
  Result:= 'Q' + copy(Classname, 4, Length(Classname));
end;

function TBaseQtWidget.getNameAndType;
begin
  Result:= Name + ': ' + getType;
end;

function TBaseQtWidget.getContainer: string;
begin
  if (Parent = nil) or (Parent is TFGUIForm)
    then Result:= 'self'
    else Result:= 'self.' + Parent.Name;
end;

procedure TBaseQtWidget.MakeFont;
  var s1, s2: string;
begin
  s1:= 'self.' + Name + '.setFont';
  s2:= '(QFont(' + asString(Font.Name) + ', ' + IntToStr(Font.Size);
  if fsBold   in Font.Style then s2:= s2 + ', QFont.Bold';
  if fsItalic in Font.Style then s2:= s2 + ', QFont.StyleItalic';
  s2:= s2 + '))';
  setAttributValue(s1, s1 + s2);
  s1:= 'self.' + Name + '.font().setUnderline';
  if fsUnderline in Font.Style
    then setAttributValue(s1, s1 + '(True)')
    else Partner.DeleteAttribute(s1);
  s1:= 'self.' + Name + '.font().setStrikeOut';
  if fsStrikeout in Font.Style
    then setAttributValue(s1, s1 + '(True)')
    else Partner.DeleteAttribute(s1);
  Invalidate;
end;

procedure TBaseQtWidget.CalculateText(s: string; var tw, th: integer; var SL: TStringList);
begin
  SL.Text:= myStringReplace(s, '\n', CrLf);
  tw:= 0;
  for var p:= 0 to SL.Count - 1 do
    tw:= max(tw, Canvas.TextWidth(SL[p]));
  th:= SL.Count * Canvas.TextHeight('Hg');
end;

function TBaseQtWidget.InnerRect: TRect;
begin
  Result:= ClientRect;
  Result.Inflate(-1, -1);
end;

function TBaseQtWidget.HalfX: integer;
begin
  Result:= fHalfX;
end;

procedure TBaseQtWidget.PaintScrollbar(R: TRect; horizontal: boolean);
  var i, mid: integer;
begin
  Canvas.Brush.Color:= clBtnFace;
  Canvas.FillRect(R);
  Canvas.Brush.Color:= $CDCDCD;
  Canvas.Pen.Color:= clWhite;
  if horizontal then begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Right, R.Top);
    Canvas.Pen.Color:= $606060;
    mid:= (R.Top + R.Bottom) div 2;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(R.Left +  9 + i, mid - 3);
      Canvas.LineTo(R.Left +  6 + i, mid);
      Canvas.LineTo(R.Left + 10 + i, mid + 4);
    end;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(R.Right -  9 + i, mid - 3);
      Canvas.LineTo(R.Right -  6 + i, mid);
      Canvas.LineTo(R.Right - 10 + i, mid + 4);
    end;
    R.Left:= R.Left + 18;
    R.Right:= R.Left + 18;
  end else begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Left, R.Bottom);
    Canvas.Pen.Color:= $606060;
    mid:= (R.Left + r.Right) div 2;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(mid - 3, R.Top +  9 + i);
      Canvas.LineTo(mid    , R.Top +  6 + i);
      Canvas.LineTo(mid + 4, R.Top + 10 + i);
    end;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(mid - 3, R.Bottom -  9 + i);
      Canvas.LineTo(mid    , R.Bottom -  6 + i);
      Canvas.LineTo(mid + 4, R.Bottom - 10 + i);
    end;
    R.Top:= R.Top + 18;
    R.Bottom:= R.Top + 18;
  end;
  R.Inflate(-1, -1);
  Canvas.FillRect(R);
end;

procedure TBaseQtWidget.PaintScrollbars(horizontal, vertical: boolean);
begin
  var R:= ClientRect;
  R.Inflate(-1, -1);
  if horizontal then begin
    R.Top:= R.Bottom - 16;
    if vertical then
      R.Right:= R.Right - 16;
    PaintScrollbar(R, true);
  end;
  R:= ClientRect;
  R.Inflate(-1, -1);
  if vertical then begin
    R.Left:= R.Right - 16;
    if horizontal then
      R.Bottom:= R.Bottom - 16;
    PaintScrollbar(R, false);
  end;
  if horizontal and vertical then begin
    Canvas.Brush.Color:= clBtnFace;
    R:= ClientRect;
    R.Inflate(-1, -1);
    R.Top:= R.Bottom - 16;
    R.Left:= R.Right - 16;
    Canvas.FillRect(R);
  end;
end;

end.
