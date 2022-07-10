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

type

  TFocusPolicy = (_FP_NoFocus, _FP_TabFocus, _FP_ClickFocus, _FP_StrongFocus,
                  _FP_WheelFocus);
  TContextMenuPolicy = (_CP_NoContextMenu, _CP_DefaultContextMenu,
         _CP_ActionsContextMenu, _CP_CustomContextMenu, _CP_PreventContextMenu);
  TLayoutDirection = (_LD_LeftToRight, _LD_RightToLeft, _LD_LayoutDirectionAuto);

  TBaseQtWidget = class(TBaseWidget)
  private
    FCommand: boolean;
    FScrollbar: boolean;
    FScrollbars: TScrollbar;

    FEnabled: boolean;
    FMouseTracking: boolean;
    FTabletTracking: boolean;
    FFocusPolicy: TFocusPolicy;
    FContextMenuPolicy: TContextMenuPolicy;
    FAcceptDrops: boolean;
    FToolTip: string;
    FToolTipDuration: integer;
    FStatusTip: string;
    FWhatThis: string;
    FAccessibleName: string;
    FAccessibleDescription: string;
    FLayoutDirection: TLayoutDirection;
    FAutoFillBackground: boolean;
    FStyleSheet: string;
    procedure setMenu(Value: string);
    function getObjectName: string;
    procedure setObjectName(Value: string);
    procedure MakeBoolean(Attr, Value: String);
    procedure MakeShow(Value: String);
  protected
    TopSpace: integer;
    LeftSpace: integer;
    RightSpace: integer;

    function getMouseEvents(ShowEvents: integer): string; virtual;
    function getKeyboardEvents(ShowEvents: integer): string; virtual;
    function getAttrAsKey(Attr: string): string; override;
    procedure CalculatePadding(var pl, pt, pr, pb: integer); virtual; abstract;
    procedure CalculateText(var tw, th: integer; var SL: TStringList); virtual;
    procedure AddParameter(const Value, par: String);
    procedure MakeControlVar(Variable, ControlVar: String; Value: String = '';  Typ: String = 'String');
    procedure MakeValidateCommand(Attr, Value: string);
    procedure MakeScrollbar(Value, TkTyp: String);
    procedure MakeScrollbars(Value, TkTyp: String);
    procedure PaintAScrollbar(Value: boolean);
    procedure PaintScrollbars(Scrollbar: TScrollbar);
    procedure setScrollbar(Value: boolean);
    procedure setScrollbars(Value: TScrollbar);
    procedure Paint; override;
    procedure PaintScrollbar(R: TRect; horizontal: boolean; ttk: boolean = false);
    procedure ChangeCommand(Attr, Value: string);
  public
    property Command: Boolean read FCommand write FCommand;


    constructor Create(aOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setEvent(Attr: string); override;
    procedure DeleteEvents; override;
    procedure DeleteWidget; override;
    procedure DeleteEventHandler(const Event: string); override;
    procedure NewWidget(Widget: String = ''); override;
    function MakeBinding(Eventname: string): string; override;
    function MakeHandler(const event: string ): string; override;
    function HandlerName(const event: string): string; override;
    procedure Resize; override;
    procedure SetPositionAndSize; override;
    function ClientRectWithoutScrollbars: TRect;
    procedure SizeLabelToText; override;
    function getType: String;
    function getNameAndType: String; override;
  published
    // common attribute for QWidget
    property ObjectName: string read getObjectName write setObjectName;
    property Enabled: boolean read FEnabled write FEnabled;
    property MouseTracking: boolean read FMouseTracking write FMouseTracking;
    property TabletTracking: boolean read FTabletTracking write FTabletTracking;
    property FocusPolicy: TFocusPolicy read FFocusPolicy write FFocusPolicy;
    property ContextMenuPolicy: TContextMenuPolicy read FContextMenuPolicy write FContextMenuPolicy;
    property AcceptDrops: boolean read FAcceptDrops write FAcceptDrops;
    property ToolTip: string read FToolTip write FToolTip;
    property ToolTipDuration: integer read FToolTipDuration write FToolTipDuration;
    property StatusTip: string read FStatusTip write FStatusTip;
    property WhatThis: string read FWhatThis write FWhatThis;
    property AccessibleName: string read FAccessibleName write FAccessibleName;
    property AccessibleDescription: string read FAccessibleDescription write FAccessibleDescription;
    property LayoutDirection: TLayoutDirection read FLayoutDirection write FLayoutDirection;
    property AutoFillBackground: boolean read FAutoFillBackground write FAutoFillBackground;
    property StyleSheet: string read FStyleSheet write FStyleSheet;
  end;

implementation

uses SysUtils, TypInfo, Math, UITypes, UGuiForm, UTKMiscBase, UTTKMiscBase,
     UGUIDesigner, UObjectInspector, UKoppel, UConfiguration, UUtils;

constructor TBaseQtWidget.create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Width:= 100;
  Height:= 100;
  Canvas.Font.PixelsPerInch:= 72;
  Font.PixelsPerInch:= 72;
  Font.Name:= 'MS Shell Dlg 2';   // QtDefaultFont
  Font.Size:= 8;
  Font.Style:= [];
  HelpType:= htContext;
  Sizeable:= true;
end;

function TBaseQtWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Name|Font';
  if ShowAttributes >= 2 then
    Result:= Result + '|BorderWidth|Relief';
  if ShowAttributes = 3 then
    Result:= Result + '|Cursor|Left|Top|Height|Width|TakeFocus';
end;

function TBaseQtWidget.getMouseEvents(ShowEvents: integer): string;
begin
  Result:= MouseEvents1;
  if ShowEvents >= 2 then
    Result:= MouseEvents1 + MouseEvents2;
  if ShowEvents = 3 then
    Result:= AllEvents;
  Result:= Result + '|';
end;

function TBaseQtWidget.getKeyboardEvents(ShowEvents: integer): string;
begin
  Result:= KeyboardEvents1;
{  if ShowEvents >= 2 then
    Result:= Result + KeyboardEvents2;}
  if ShowEvents = 3 then
    Result:= AllEvents;
  Result:= Result + '|';
end;

procedure TBaseQtWidget.PaintScrollbar(R: TRect; horizontal: boolean; ttk: boolean = false);
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
    if ttk then begin
      R.Left:= R.Left + 18;
      R.Right:= R.Right - 18;
    end else begin
      R.Left:= R.Left + 18;
      R.Right:= R.Left + 18;
    end;
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
    if ttk then begin
      R.Top:= R.Top + 18;
      R.Bottom:= R.Bottom - 18;
    end else begin
      R.Top:= R.Top + 18;
      R.Bottom:= R.Top + 18;
    end;
  end;
  R.Inflate(-1, -1);
  Canvas.FillRect(R);
end;

procedure TBaseQtWidget.SetPositionAndSize;
  var key: String; R: TRect;
begin
key:= '';
  R:= ClientRectWithoutScrollbars;
  if not (Parent is TKPanedWindow) then
    setAttributValue('self.' + Name + '.place',
      'self.' + Name +
      '.place(x=' + IntToStr(Left) + ', y=' + IntToStr(Top) +
      ', width=' + IntToStr(R.Right) + ', height=' + IntToStr(R.Bottom) +')');
{
  if Scrollbars in [_TB_both, _TB_vertical] then begin
    key:= 'self.' + Name + 'ScrollbarV.place';
    setAttributValue(key,
      key + '(x=' + IntToStr(x + R.Right - 2) + ', y=' + IntToStr(y) +
            ', width=20, height='+ IntToStr(R.Bottom) + ')');
  end;
  if (Scrollbars in [_TB_both, _TB_horizontal]) or Scrollbar then begin
    key:= 'self.' + Name + 'ScrollbarH.place';
    setAttributValue(key,
      key + '(x=' + IntToStr(x) + ', y=' + IntToStr(y + R.Bottom - 2) +
            ', width=' + IntToStr(R.Right) + ', height=20)');
  end;
  }
end;

function TBaseQtWidget.ClientRectWithoutScrollbars: TRect;
begin
  Result:= ClientRect; {
  if Scrollbars in [_TB_vertical, _TB_both]
    then Result.Right:= Result.Right - 20;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar
    then Result.Bottom:= Result.Bottom - 20;}
end;

procedure TBaseQtWidget.Resize;
begin
  inherited;
  if Parent is TKPanedWindow then
    (Parent as TKPanedWindow).Resize
  //else if Self is TKPanedWindow then
  //  (Self as TKPanedWindow).Resize
  //else if Parent is TTKPanedwindow then
  //  (Parent as TTKPanedwindow).Resize
  //else if Self is TTKPanedwindow then
  //  (Self as TTKPanedwindow).Resize;
end;

function TBaseQtWidget.getAttrAsKey(Attr: string): string;
begin
  Result:= 'self.' + Name + '[''' + Lowercase(Attr) + ''']';
end;

procedure TBaseQtWidget.setAttribute(Attr, Value, Typ: string);
  var s1: string;
begin
  s1:= getAttrAsKey(Attr);
  if isFontAttribute(Attr)then
    MakeFont
  else if Attr = 'TakeFocus' then
    MakeBoolean(Attr, Value)
  else if Attr = 'Menu' then
    setMenu(Value)
  else if Attr = 'Show' then
    MakeShow(Value)
  else if Right(Attr, -7) = 'Command' then
    ChangeCommand(Attr, Value)
  else if Typ = 'Source' then
    if Value = ''
      then Partner.DeleteAttribute(s1)
      else setAttributValue(s1, s1 + ' = ' + Value)
  else if Typ = 'TCursor' then
    if Value = 'default'
      then Partner.DeleteAttribute(s1)
      else setAttributValue(s1, s1 + ' = ' + asString(Value))
  else if Typ = 'Boolean' then
    MakeBoolean(Attr, Value)
  else if (Typ = 'string') or (Typ[1] = 'T') then  // enum type, TColor
    if Value = ''
      then Partner.DeleteAttribute(s1)  // borderwidth, padx, ...
      else setAttributValue(s1, s1 + ' = ' + asString(Value))
  else begin
    if Value = ''                                  // Typ real
      then Partner.DeleteAttribute(s1)
      else setAttributValue(s1, s1 + ' = ' + Value);
  end;
end;

procedure TBaseQtWidget.setEvent(Attr: string);
begin
  if not Partner.hasText('def ' + HandlerName(Attr) + '(self, event):') then
    Partner.InsertProcedure(CrLf + MakeHandler(Attr));
  Partner.InsertBinding(Name, Attr, MakeBinding(Attr));
end;

procedure TBaseQtWidget.MakeBoolean(Attr, Value: String);
  var s1, s2: string;
begin
  s1:= getAttrAsKey(Attr);
  if Value = 'True'
    then s2:= s1 + ' = 1'
    else s2:= s1 + ' = 0';
  setAttributValue(s1, s2)
end;

procedure TBaseQtWidget.MakeShow(Value: String);
  var s: string;
begin
  s:= 'self.' + Name  + '[''show'']';
  if Value = 'True'
    then Partner.DeleteAttribute(s)
    else setAttributValue(s, s + ' = ''*''');
end;

procedure TBaseQtWidget.AddParameter(const Value, par: string);
  var old, new: String;
begin
  old:= 'def ' + Value + '(self):';
  new:= 'def ' + Value + '(self, ' + par + '):';
  Partner.ReplaceWord(old, new, false);
end;

procedure TBaseQtWidget.MakeControlVar(Variable, ControlVar: String; Value: String = ''; Typ: String = 'String');
begin
  InsertVariable('self.' + ControlVar + ' = tk.' + Typ + 'Var()');
  if Typ = 'String'
    then InsertVariable('self.' + ControlVar + '.set(' + asString(Value) + ')')
    else InsertVariable('self.' + ControlVar + '.set(' + Value + ')');
  InsertVariable('self.' + Name + '[' + asString(Variable) + '] = self.' + ControlVar);
end;

procedure TBaseQtWidget.setMenu(Value: string);
  var s1, s2: string;
begin
  if Value = '' then begin
    Partner.DeleteAttribute('self.' + Name + '[''menu'']');
    s1:= 'self.' + LOldValue + ' = tk.Menu';
    s2:= s1 + '(tearoff=0)';
  end else begin
    s1:= 'self.' + Name + '[''menu'']';
    setAttributValue(s1, s1 + ' = self.' + Value);
    s1:= 'self.' + Value + ' = tk.Menu';
    s2:= s1 + '(self.' + Name + ', tearoff=0)';
  end;
  setAttributValue(s1, s2);
end;

procedure TBaseQtWidget.ChangeCommand(Attr, Value: string);
  var nam, key: string;
begin
  nam:= Name + '_' + Attr;
  key:= 'self.' + Name + '[' + asString(lowercase(Attr)) + ']';
  if Value = 'False' then begin
    Partner.DeleteAttribute(key);
    Partner.DeleteMethod(nam);
  end else begin
    setAttributValue(key, key + ' = self.' + nam);
    MakeCommand(Attr, nam);
  end;
end;

function TBaseQtWidget.HandlerName(const event: string): string;
begin
  Result:= Name + '_' + Event;
end;

function TBaseQtWidget.MakeBinding(Eventname: string): string;
  var Event: TEvent;
begin
  if Eventname = 'ButtonPress' then
    Event:= ButtonPress
  else if Eventname = 'ButtonRelease' then
    Event:= ButtonRelease
  else if Eventname = 'KeyPress' then
    Event:= KeyPress
  else if Eventname = 'KeyRelease' then
    Event:= KeyRelease
  else if Eventname = 'Activate' then
    Event:= Activate
  else if Eventname = 'Configure' then
    Event:= Configure
  else if Eventname = 'Deactivate' then
    Event:= Deactivate
  else if Eventname = 'Enter' then
    Event:= Enter
  else if Eventname = 'FocusIn' then
    Event:= FocusIn
  else if Eventname = 'FocusOut' then
    Event:= FocusOut
  else if Eventname = 'Leave' then
    Event:= Leave
  else if Eventname = 'Motion' then
    Event:= Motion
  else
    Event:= MouseWheel;
  Result:= Indent2 + 'self.' + Name + '.bind(''<' + Event.getModifiers(Eventname) +
           Eventname + Event.getDetail(Eventname) + '>'', self.' + HandlerName(Eventname) + ')';
end;

function TBaseQtWidget.MakeHandler(const event: string ): string;
begin
  //  Example:
  //  def name(self, event):
  //    // TODO insert source code here
  //    pass
  Result:= Indent1 + 'def ' + HandlerName(Event) + '(self, event):' + CrLf +
           Indent2 + '# ToDo insert source code here' + CrLf +
           Indent2 + 'pass' + CrLf;
end;

procedure TBaseQtWidget.MakeValidateCommand(Attr, Value: string);
  var key: string;
begin
  if Value = '' then begin
    Partner.DeleteAttribute(Name + 'VC');
    Partner.DeleteAttribute('self.' + Name + '[''validatecommand'']');
    Partner.DeleteMethod(UKoppel.LOldValue);
  end else begin
    key:= 'self.' + Name + 'VC';
    setAttributValue(key, key + ' = self.register(self.' + Name + '_ValidateCommand)');
    ChangeCommand(Attr, Value);
    key:= 'self.' + Name + '[''validatecommand'']';
    setAttributValue(key, key + ' = (self.' + Name + 'VC, ''%d'', ''%i'', ''%S'')');
  end;
end;

procedure TBaseQtWidget.Paint;
begin

end;

procedure TBaseQtWidget.setScrollbars(Value: TScrollbar);
begin
  if FScrollbars <> Value then begin
    FScrollbars:= Value;
    invalidate;
  end;
end;

procedure TBaseQtWidget.setScrollbar(Value: boolean);
begin
  if FScrollbar <> Value then begin
    FScrollbar:= Value;
    invalidate;
  end;
end;

procedure TBaseQtWidget.MakeScrollbar(Value, TkTyp: String);
begin
  if Value = 'True'
    then MakeScrollbars('horizontal', TkTyp)
    else MakeScrollbars('none', TkTyp);
end;

procedure TBaseQtWidget.MakeScrollbars(Value, TkTyp: String);
  var ScrollbarName, OldValue: String;
     WidthNoScrollbar, HeightNoScrollbar, WidthScrollbar, HeightScrollbar: integer;

  procedure DeleteVertical;
  begin
    Partner.DeleteAttributeValues(ScrollbarName + 'V');
    Partner.DeleteAttribute('self.' + Name +  '[' + asString('yscrollcommand') + ']');
    Dec(WidthNoScrollbar, 20);
  end;

  procedure DeleteHorizontal;
  begin
    Partner.DeleteAttributeValues(ScrollbarName + 'H');
    Partner.DeleteAttribute('self.' + Name +  '[' + asString('sxcrollcommand') + ']');
    Dec(HeightNoScrollbar, 20);
  end;

  procedure InsertVertical;
  begin
    InsertVariable(ScrollbarName + 'V = ' + TkTyp + 'Scrollbar(' + getContainer + ')');
    InsertVariable(ScrollbarName + 'V.place(x=' + IntToStr(x + WidthNoScrollbar - 2) + ', y=' + IntToStr(y) +
                                   ', width=20, height=' + IntToStr(HeightNoScrollbar) + ')');
    InsertVariable(ScrollbarName + 'V[' + asString('command') + '] = self.' + Name + '.yview');
    InsertVariable('self.' + Name + '[' + asString('yscrollcommand') + '] = ' + ScrollbarName + 'V.set');
    Inc(WidthScrollbar, 20);
  end;

  procedure InsertHorizontal;
    var s: string;
  begin
    s:= getContainer;
    if s <> '' then s:= s + ', ';
    s:= s + 'orient=' + asString('horizontal');
    InsertVariable(ScrollbarName + 'H = ' + TkTyp+ 'Scrollbar(' + s + ')');
    InsertVariable(ScrollbarName + 'H.place(x=' + IntToStr(x) + ', y=' + IntToStr(y + HeightNoScrollbar - 2) +
                                   ', width=' + IntToStr(WidthNoScrollbar) + ', height=20)');
    InsertVariable(ScrollbarName + 'H[' + asString('command') + '] = self.' + Name + '.xview');
    InsertVariable('self.' + Name + '[' + asString('xscrollcommand') + '] = ' + ScrollbarName + 'H.set');
    Inc(HeightScrollbar, 20);
  end;

begin
  OldValue:= UKoppel.LOldValue;
  ScrollbarName:= 'self.' + Name + 'Scrollbar';
  Partner.ActiveSynEdit.BeginUpdate;
  WidthNoScrollbar:= Width;
  HeightNoScrollbar:= Height;
  if (OldValue = 'vertical') or (OldValue = 'both') then
    DeleteVertical;
  if (OldValue = 'horizontal') or (OldValue = 'both') or (OldValue = 'True') then
    DeleteHorizontal;
  WidthScrollbar:= WidthNoScrollbar;
  HeightScrollbar:= HeightNoScrollbar;
  if (Value = 'vertical') or (Value = 'both') then
    InsertVertical;
  if (Value = 'horizontal') or (Value = 'both') then
    InsertHorizontal;
  SetBounds(x, y, WidthScrollbar, HeightScrollbar);
  Partner.ActiveSynEdit.EndUpdate;
  FObjectInspector.Invalidate;
end;

procedure TBaseQtWidget.PaintAScrollbar(Value: boolean);
begin
  if Value then
    PaintScrollbars(_TB_horizontal)
end;

procedure TBaseQtWidget.PaintScrollbars(Scrollbar: TScrollbar);
  var R: TRect;
begin
  if Scrollbar = _TB_vertical then begin
    R:= ClientRect;
    R.Left:= R.Right - 20;
    PaintScrollbar(R, false);
  end;

  if Scrollbar = _TB_horizontal then begin
    R:= ClientRect;
    R.Top:= R.Bottom - 20;
    PaintScrollbar(R, true);
  end;

  if Scrollbar = _TB_both then begin
    R:= ClientRect;
    R.Left:= R.Right - 20;
    R.Bottom:= R.Bottom - 20;
    PaintScrollbar(R, false);
    R:= ClientRect;
    R.Top:= R.Bottom - 20;
    R.Right:= R.Right - 20;
    PaintScrollbar(R, true);
  end;
end;

procedure TBaseQtWidget.DeleteWidget;
begin
  if FCommand then Partner.DeleteMethod(Name + '_Command');
  Partner.DeleteMethod(Name + 'ScrollbarH.set');
  Partner.DeleteMethod(Name + 'ScrollbarV.set');
  DeleteEvents;
  Partner.DeleteComponent(Self);
  if (Parent is TKPanedWindow) or (Parent is TTKPanedWindow) then
    Partner.DeleteAttribute('self.' + Parent.Name + '.add(self.' + Name);
end;

procedure TBaseQtWidget.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  Partner.DeleteBinding(Name, Event);
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
      Partner.DeleteBinding(Name, Event);
      SL1.Add(HandlerName(Event));
    end;
    delete(s, 1, p);
    p:= Pos('|', s);
  end;
  Partner.DeleteOldAddNewMethods(SL1, SL2, 'self, event');
  FreeAndNil(SL1);
  FreeAndNil(SL2);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseQtWidget.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  InsertVariable('self.' + Name + ' = ' + Widget + '(' + getContainer + ')');
  setPositionAndSize;
  if Parent is TKPanedWindow then begin
    InsertVariable('self.' + Parent.Name + '.add(self.' + Name + ')');
    //ControlStyle:= [];
  end else if Parent is TTKPanedwindow then begin
    InsertVariable('self.' + Parent.Name + '.add(self.' + Name + ', weight=1)');
    //ControlStyle:= [];
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseQtWidget.SizeLabelToText;
begin
end;

function TBaseQtWidget.getType;
begin
  if Pos('TTK', Classname) = 1
    then Result:= copy(Classname, 4, Length(Classname))
    else Result:= copy(Classname, 3, Length(Classname));
end;

function TBaseQtWidget.getNameAndType;
begin
  Result:= Name + ': ' + getType;
end;

function TBaseQtWidget.getObjectName: string;
begin
  Result:= Name;
end;

procedure TBaseQtWidget.setObjectName(Value: string);
begin
  Name:= Value;
end;

procedure TBaseQtWidget.CalculateText(var tw, th: integer; var SL: TStringlist);
  var s: string; p: integer;
begin
  s:= Text;
  p:= Pos('\n', s);
  while p > 0 do begin
    SL.Add(copy(s, 1, p-1));
    delete(s, 1, p+1);
    p:= Pos('\n', s);
  end;
  SL.Add(s);
  tw:= 0;
  for p:= 0 to SL.Count - 1 do
    tw:= max(tw, Canvas.TextWidth(SL.Strings[p]));
  th:= SL.Count * Canvas.TextHeight('Hg');
end;

end.
