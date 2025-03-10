{-------------------------------------------------------------------------------
 Unit:     UBaseQtWidgets
 Author:   Gerhard R�hner
 Date:     April 2022
 Purpose:  base widget for PyQt
-------------------------------------------------------------------------------}

unit UBaseQtWidgets;

interface

uses
  Windows, Classes, UBaseWidgets;

const CrLf = #13#10;

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
    FWindowIconChanged: string;
    FWindowTitleChanged: string;
    procedure MakeContextMenu(Value: string);
    function getContainer: string;
    function getAttrAsKey(Attr: string): string;
  protected
    TopSpace: Integer;
    LeftSpace: Integer;
    function HalfX: Integer;
    procedure MakeAttribut(Attr, Value: string);
    procedure CalculateText(s: string; var tw, th: Integer; var SL: TStringList);
    function InnerRect: TRect; virtual;
    procedure PaintScrollbar(R: TRect; horizontal: Boolean);
    procedure PaintScrollbars(horizontal, vertical: Boolean);
  public
    constructor Create(aOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; virtual;
    function HandlerParameter(const event: string): string; override;
    function Parametertypes(const event: string): string;
    procedure getSlots(Parametertypes: string; Slots: TStrings); virtual;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure setEvent(Attr: string); override;
    procedure DeleteEvents; override;
    procedure DeleteWidget; override;
    procedure DeleteEventHandler(const Event: string); override;
    procedure NewWidget(Widget: string = ''); override;
    function MakeBinding(Eventname: string): string; override;
    function MakeHandler(const event: string ): string; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetPositionAndSize; override;
    function getNameAndType: string; override;
    procedure MakeFont; override;
    function getType: string; override;
  published
    // common attribute for QWidget
    property Enabled: Boolean read FEnabled write FEnabled;
    property MouseTracking: Boolean read FMouseTracking write FMouseTracking;
    property TabletTracking: Boolean read FTabletTracking write FTabletTracking;
    property FocusPolicy: TFocusPolicy read FFocusPolicy write FFocusPolicy;
    property ContextMenuPolicy: TContextMenuPolicy read FContextMenuPolicy write FContextMenuPolicy;
    property ContextMenu: string read FContextMenu write FContextMenu;
    property AcceptDrops: Boolean read FAcceptDrops write FAcceptDrops;
    property ToolTip: string read FToolTip write FToolTip;
    property ToolTipDuration: Integer read FToolTipDuration write FToolTipDuration;
    property StatusTip: string read FStatusTip write FStatusTip;
    property WhatsThis: string read FWhatsThis write FWhatsThis;
    property AccessibleName: string read FAccessibleName write FAccessibleName;
    property AccessibleDescription: string read FAccessibleDescription write FAccessibleDescription;
    property LayoutDirection: TLayoutDirection read FLayoutDirection write FLayoutDirection;
    property AutoFillBackground: Boolean read FAutoFillBackground write FAutoFillBackground;
    property StyleSheet: string read FStyleSheet write FStyleSheet;
    // signals
    property customContextMenuRequested: string read FcustomContextMenuRequested write FcustomContextMenuRequested;
    property windowIconChanged: string read FWindowIconChanged write FWindowIconChanged;
    property windowTitleChanged: string read FWindowTitleChanged write FWindowTitleChanged;
  end;

implementation

uses Math, Controls, Graphics, SysUtils, UITypes,
     frmEditor, UGuiForm, UUtils, UConfiguration;

constructor TBaseQtWidget.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Width:= 120;
  Height:= 80;
  Enabled:= True;
  ToolTipDuration:= -1;
  FocusPolicy:= NoFocus;
  LayoutDirection:= LeftToRight;
  ContextMenuPolicy:= DefaultContextMenu;
  Font.Name:= 'Segoe UI';
  Font.Size:= GuiPyOptions.GuiFontSize;
  Font.Style:= [];
  HelpType:= htContext;
  Sizeable:= True;
end;

function TBaseQtWidget.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Name|';
  if ShowAttributes = 3 then
    Result:= '|Name|Left|Top|Height|Width|ToolTip|ToolTipDuration' +
             '|MouseTracking|TabletTracking|FocusPolicy' +
             '|ContextMenuPolicy|ContextMenu|AcceptDrops|StatusTip|WhatsThis' +
             '|AccessibleName|AccessibleDescription|LayoutDirection' +
             '|AutoFillBackground|StyleSheet|Cursor|Font|Enabled|';
end;

function TBaseQtWidget.getEvents(ShowEvents: Integer): string;
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
  var s: string; p: Integer;
begin
  s:= HandlerInfo(event);
  p:= Pos(';', s);
  if p > 0
    then Result:= 'self, ' + Copy(s, p+1, Length(s))
    else Result:= 'self';
end;

function TBaseQtWidget.Parametertypes(const event: string): string;
  var s: string; p: Integer;
begin
  s:= HandlerInfo(event);
  p:= Pos(';', s);
  if p > 0
    then Result:= Copy(s, 1, p-1)
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
begin
  var R:= ClientRect;
  var key:= 'self.' + Name + '.setGeometry';
  setAttributValue(key, key + '(' + IntToStr(PPIUnScale(Left)) + ', ' + IntToStr(PPIUnScale(Top)) +
    ', ' + IntToStr(PPIUnScale(R.Right)) + ', ' + IntToStr(PPIUnScale(R.Bottom)) + ')');
end;

function TBaseQtWidget.getAttrAsKey(Attr: string): string;
begin
  Result:= 'self.' + Name + '.set' + Attr;
end;

procedure TBaseQtWidget.setAttribute(Attr, Value, Typ: string);
begin
  if isFontAttribute(Attr)then
    MakeFont
  else if Attr = 'Cursor' then
    MakeAttribut(Attr, 'QCursor(Qt.CursorShape.' + Value + ')')
  else if Attr = 'ContextMenu' then
    MakeContextMenu(Value)
  else if (Attr = 'FocusPolicy') or
          (Attr = 'ContextMenuPolicy') or
          (Attr = 'LayoutDirection')  then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if (Typ = 'string') or (Copy(Typ, 1, 1) = 'T') then  // enum type, TColor
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

procedure TBaseQtWidget.MakeAttribut(Attr, Value: string);
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
  var Binding:= MakeBinding(Event);
  Partner.DeleteBinding(Copy(Binding, 1, Pos('(', Binding)));
end;

procedure TBaseQtWidget.DeleteEvents;
  var p: Integer; s, Event, Binding: string; SL1, SL2: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  SL1:= TStringList.Create;
  SL2:= TStringList.Create;
  s:= getEvents(3) + '|';
  p:= Pos('|', s);
  while p > 0 do begin
    Event:= UUtils.Left(s, p-1);
    if Event <> '' then begin
      Binding:= MakeBinding(Event);
      Partner.DeleteBinding(Copy(Binding, 1, Pos('(', Binding)));
      SL1.Add(HandlerNameAndParameter(Event));
    end;
    Delete(s, 1, p);
    p:= Pos('|', s);
  end;
  Partner.DeleteOldAddNewMethods(SL1, SL2);
  FreeAndNil(SL1);
  FreeAndNil(SL2);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseQtWidget.NewWidget(Widget: string = '');
begin
  setAttributValue('self.' + Name, 'self.' + Name + ' = ' + Widget + '(' + getContainer + ')');
  setPositionAndSize;
  MakeFont;
end;

function TBaseQtWidget.getType;
begin
  Result:= 'Q' + Copy(Classname, 4, Length(Classname));
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
  if Name = '' then Exit;
  s1:= 'self.' + Name + '.setFont';
  s2:= '(QFont(' + asString(Font.Name) + ', ' + IntToStr(Font.Size);
  if fsBold in Font.Style then
    s2:= s2 + ', QFont.Weight.Bold';
  if fsItalic in Font.Style then
    s2:= s2 + ', italic=True';
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

procedure TBaseQtWidget.CalculateText(s: string; var tw, th: Integer; var SL: TStringList);
begin
  SL.Text:= myStringReplace(s, '\n', CrLf);
  tw:= 0;
  for var p:= 0 to SL.Count - 1 do
    tw:= Max(tw, Canvas.TextWidth(SL[p]));
  th:= SL.Count * Canvas.TextHeight('Hg');
end;

function TBaseQtWidget.InnerRect: TRect;
begin
  Result:= ClientRect;
  Result.Inflate(-1, -1);
end;

function TBaseQtWidget.HalfX: Integer;
begin
  Result:= fHalfX;
end;

procedure TBaseQtWidget.PaintScrollbar(R: TRect; horizontal: Boolean);
  var i, i3, i4, i6, i9, i10, i18, mid: Integer;
begin
  Canvas.Brush.Color:= clBtnFace;
  Canvas.FillRect(R);
  Canvas.Brush.Color:= $CDCDCD;
  Canvas.Pen.Color:= clWhite;
  i3:= PPIScale(3);
  i4:= PPIScale(4);
  i6:= PPIScale(6);
  i9:= PPIScale(9);
  i10:= PPIScale(10);
  i18:= PPIScale(18);
  if horizontal then begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Right, R.Top);
    Canvas.Pen.Color:= $606060;
    mid:= (R.Top + R.Bottom) div 2;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(R.Left +  i9 + i, mid - i3);
      Canvas.LineTo(R.Left +  i6 + i, mid);
      Canvas.LineTo(R.Left + i10 + i, mid + i4);
    end;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(R.Right -  i9 + i, mid - i3);
      Canvas.LineTo(R.Right -  i6 + i, mid);
      Canvas.LineTo(R.Right - i10 + i, mid + i4);
    end;
    R.Left:= R.Left + i18;
    R.Right:= R.Left + i18;
  end else begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Left, R.Bottom);
    Canvas.Pen.Color:= $606060;
    mid:= (R.Left + r.Right) div 2;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(mid - i3, R.Top +  i9 + i);
      Canvas.LineTo(mid     , R.Top +  i6 + i);
      Canvas.LineTo(mid + i4, R.Top + i10 + i);
    end;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(mid - i3, R.Bottom -  i9 + i);
      Canvas.LineTo(mid     , R.Bottom -  i6 + i);
      Canvas.LineTo(mid + i4, R.Bottom - i10 + i);
    end;
    R.Top:= R.Top + i18;
    R.Bottom:= R.Top + i18;
  end;
  R.Inflate(-1, -1);
  Canvas.FillRect(R);
end;

procedure TBaseQtWidget.PaintScrollbars(horizontal, vertical: Boolean);
begin
  var R:= ClientRect;
  R.Inflate(-1, -1);
  if horizontal then begin
    R.Top:= R.Bottom - 16;
    if vertical then
      R.Right:= R.Right - 16;
    PaintScrollbar(R, True);
  end;
  R:= ClientRect;
  R.Inflate(-1, -1);
  if vertical then begin
    R.Left:= R.Right - 16;
    if horizontal then
      R.Bottom:= R.Bottom - 16;
    PaintScrollbar(R, False);
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
