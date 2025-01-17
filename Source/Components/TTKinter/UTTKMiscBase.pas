{-------------------------------------------------------------------------------
 Unit:     UTTKMiscBase
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  TKKinter misc widgets
-------------------------------------------------------------------------------}

unit UTTKMiscBase;

{ class hierarchie

  TTKMiscBaseWidget
    TTKFrame
      TTKLabelframe
    TTKScale
    TTKLabeledScale
    TTKScrollbar
    TTKPanedWindow
    TTKRadiobuttonGroup
    TTKNotebook
    TTKTreeview
    TTKProgressbar
    TTKSeparator
    TTKSizeGrip
}

interface

uses
  Classes, UTtkWidgets;

type

  // positioning of text, used in TextWidget
  TLabelAnchor = (_TL_nw, _TL_n, _TL_ne, _TL_en, _TL_e, _TL_es, _TL_se, _TL_s, _TL_sw, _TL_ws, _TL_w, _TL_wn);

  TOrient = (horizontal, vertical);

  TCompound = (_TC_top, _TC_bottom);

  TButtonState = (active, disabled, normal);

  TType = (_TT_menubar, _TT_normal);    // normal is used in TButtonState

  TSelectMode = (extended, browse, none);

  TMode = (determinate, indeterminate);

  TTKMiscBaseWidget = class(TTKWidget)
  private
    FOrient: TOrient;
    procedure setOrient(Value: TOrient);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    procedure MakeFont; override;

    property Background;
    property Orient: TOrient read FOrient write setOrient;
  end;

  TTKFrame = class (TTKMiscBaseWidget)
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
  published
    property Background;
    property BorderWidth;
    property Padding;
    property Relief;
  end;

  TTKLabelframe = class (TTKFrame)
  private
    FLabelAnchor: TLabelAnchor;
    FLabelWidget: string;
    procedure setLabelAnchor(Value: TLabelAnchor);
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure Paint; override;
  published
    property LabelAnchor: TLabelAnchor read FLabelAnchor write setLabelAnchor default _TL_nw;
    property LabelWidget: string read FLabelWidget write FLabelWidget;
    property Text;
    property Underline;
  end;

  TTKScale = class (TTKMiscBaseWidget)
  private
    FFrom: real;
    FState: TButtonState;
    FTo: real;
    FValue: real;
    procedure setRValue(Value: real);
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeCommand(Attr, Value: string); override;
    function getWidgetStylename: string; override;
    procedure Paint; override;
  published
    property Command;
    property From: real read FFrom write FFrom;
    property Orient;
    property State: TButtonState read FState write FState default normal;
    property TakeFocus;
    property To_: real read FTo write FTo;
    property Value: real read FValue write setRValue;
  end;

  TTKLabeledScale = class (TTKMiscBaseWidget)
  private
    FCompound: TCompound;
    FFrom: real;
    FState: TButtonState;
    FTo: real;
    FValue: real;
    procedure setRValue(Value: real);
    procedure setCompound(Value: TCompound);
    procedure setConfiguration;
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeCommand(Attr, Value: string); override;
    procedure Paint; override;
  published
    property BorderWidth;
    property Command;
    property Compound: TCompound read FCompound write setCompound default _TC_top;
    property From: real read FFrom write FFrom;
    property Relief;
    property State: TButtonState read FState write FState default normal;
    property TakeFocus;
    property To_: real read FTo write FTo;
    property Value: real read FValue write setRValue;
  end;

  TTKScrollbar = class(TTKMiscBaseWidget)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeCommand(Attr, Value: string); override;
    function getWidgetStylename: string; override;
    procedure Paint; override;
  published
    property Command;
    property Orient;
  end;

  TTKPanedWindow = class (TTKMiscBaseWidget)
  private
    procedure PaintSlashAt(Pos: Integer);
    function getPos(i: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure Resize; override;
    procedure Paint; override;
  published
    property Orient;
  end;

  TTKRadiobuttonGroup = class (TTKMiscBaseWidget)
  private
    FColumns: Integer;
    FLabel: string;
    FItems: TStrings;
    FOldItems: TStrings;
    FCheckboxes: Boolean;
    procedure setColumns(Value: Integer);
    procedure setLabel(Value: string);
    procedure setItems(Value: TStrings);
    procedure setCheckboxes(Value: Boolean);
    procedure ChangeCommand(Value: string);
    procedure MakeButtongroupItems;
    procedure MakeLabel(aLabel: string);
    function ItemsInColumn(i: Integer): Integer;
    function RBName(i: Integer): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure MakeCommand(Attr, Value: string); override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  published
    property Items: TStrings read FItems write setItems; // must stay before columns or label
    property Columns: Integer read FColumns write setColumns;
    property Command;
    property Font;
    property Label_: string read FLabel write setLabel;
    property Checkboxes: Boolean read FCheckboxes write setCheckboxes;
  end;

  TTKNotebook = class(TTKMiscBaseWidget)
  private
    FTabs: TStrings;
    FOldTabs: TStrings;
    procedure setTabs(Value: TStrings);
    procedure MakeTabs;
    function TabName(i: Integer): string;
    procedure DeleteTabs;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  published
    property Tabs: TStrings read FTabs write setTabs;
    property Padding;
    property TakeFocus;
  end;

  TTKTreeview = class(TTKMiscBaseWidget)
  private
    FColumns: TStrings;
    FDisplayColumns: string;
    FItems: TStrings;
    FOldItems: TStrings;
    FSelectMode: TSelectMode;
    FShowHeadings: Boolean;
    procedure setColumns(Value: TStrings);
    procedure setDisplayColumns(Value: string);
    procedure setItems(Value: TStrings);
    procedure setShowHeadings(Value: Boolean);
    procedure MakeColumns;
    procedure MakeItems;
    function ColumnId(i: Integer): string;
    procedure DeleteColumns;
    function hasSubNodes(i: Integer): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    function getWidgetStylename: string; override;
    procedure Paint; override;
  published
    property Columns: TStrings read FColumns write setColumns;
    property DisplayColumns: string read FDisplayColumns write setDisplayColumns;
    property Items: TStrings read FItems write setItems;
    property SelectMode: TSelectMode read FSelectMode write FSelectMode default extended;
    property ShowHeadings: Boolean read FShowHeadings write setShowHeadings default True;
    property Padding;
    property Scrollbars;
    property TakeFocus;
  end;

  TTKProgressbar = class (TTKMiscBaseWidget)
  private
    FMaximum: real;
    FMode: TMode;
    FValue: real;
    procedure setRValue(Value: real);
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    function getWidgetStylename: string; override;
  published
    property Maximum: real read FMaximum write FMaximum;
    property Mode: TMode read FMode write FMode default determinate;
    property Orient;
    property Value: real read FValue write setRValue;
  end;

  TTKSeparator = class(TTKMiscBaseWidget)
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Orient;
  end;

  TTKSizeGrip = class(TTKMiscBaseWidget)
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  end;

implementation

uses Math, Windows, Controls, Graphics, SysUtils,
     JvGnugettext, UBaseTkWidgets, UUtils, UConfiguration;

{--- TButtonBaseWidget --------------------------------------------------------}

constructor TTKMiscBaseWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOrient:= vertical;
  Width:= 120;
  Height:= 80;
end;

function TTKMiscBaseWidget.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '';
  if ShowAttributes = 3 then
    Result:= Result;
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TTKMiscBaseWidget.getEvents(ShowEvents: Integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

procedure TTKMiscBaseWidget.MakeFont;
begin
  // no font
end;

procedure TTKMiscBaseWidget.setOrient(Value: TOrient);
  var h: Integer;
begin
  if FOrient <> Value then begin
    FOrient:= Value;
    if not (csLoading in ComponentState) then begin
      h:= Width; Width:= Height; Height:= h;
      SetPositionAndSize;
    end;
    Invalidate;
  end;
end;

{--- TTKFrame ------------------------------------------------------------------}

constructor TTKFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 43;
  ControlStyle := [csAcceptsControls];
end;

procedure TTKFrame.NewWidget(Widget: string = '');
begin
  if Widget = ''
    then inherited NewWidget('ttk.Frame')
    else inherited NewWidget(Widget);     // for LabelFrame
end;

function TTKFrame.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Background';
  if ShowAttributes >= 3 then
    Result:= Result + '|Padding';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKFrame.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Background' then begin
    Style:= Name + '.TFrame';
    var s:= 'ttk.Style().configure(' + asString(Style);
    setAttributValue(s, s + ', background = ' + asString(Value) + ')');
    s:= 'self.' + Name + '[''style'']';
    setAttributValue(s, s + ' = ' + asString(Style));
    UpdateObjectInspector;
  end else
    inherited;
end;

{--- TTKLabelframe ------------------------------------------------------------------}

constructor TTKLabelframe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 44;
  FLabelAnchor:= _TL_nw;
  Relief:= _TR_solid;
end;

procedure TTKLabelframe.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.LabelFrame');
end;

function TTKLabelframe.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|LabelAnchor|Text|Underline';
  if ShowAttributes >= 2 then
    Result:= Result + '';
  if ShowAttributes >= 3 then
    Result:= Result + '|LabelWidget';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKLabelframe.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'LabelWidget' then
    inherited setAttribute(Attr, Value, 'Source')
  else
    inherited;
end;

procedure TTKLabelframe.setLabelAnchor(Value: TLabelAnchor);
begin
  if FLabelAnchor <> Value then begin
    FLabelAnchor:= Value;
    Invalidate;
  end;
end;

procedure TTKLabelframe.Paint;
  var tw, th, ts, tr, bd, h, w, x, y: Integer; R: TRect; s: string;
begin
  inherited;
  R:= ClientRect;
  Canvas.FillRect(R);  // remove border
  tw:= Canvas.TextWidth(Text);
  th:= Canvas.TextHeight('Hg');
  ts:= Max((th - BorderWidthInt) div 2, 0);
  tr:= Max((tw - BorderWidthInt) div 2, 0);
  case FLabelAnchor of
    _TL_nw, _TL_n, _TL_ne: R.Top   := R.Top + ts;
    _TL_en, _TL_e, _TL_es: R.Right := R.Right - tr;
    _TL_se, _TL_s, _TL_sw: R.Bottom:= R.Bottom - ts;
    _TL_ws, _TL_w, _TL_wn: R.Left  := R.Left + tr;
  end;
  Canvas.Pen.Color:= $DCDCDC;
  PaintBorder(R, Relief, BorderWidthInt);

  h:= Height;
  w:= Width;
  bd:= BorderWidthInt;
  case FLabelAnchor of
    _TL_nw: begin x:= bd + 4;          y:= 0; end;
    _TL_n : begin x:= (w - tw) div 2;  y:= 0; end;
    _TL_ne: begin x:= w - bd - 4 - tw; y:= 0; end;
    _TL_en: begin x:= w - tw - 1;      y:= bd + 4; end;
    _TL_e:  begin x:= w - tw - 1;      y:= (h - th) div 2; end;
    _TL_es: begin x:= w - tw - 1;      y:= h - bd - 4 - th; end;
    _TL_se: begin x:= w - bd - 4 - tw; y:= h - th - 1; end;
    _TL_s:  begin x:= (w - tw) div 2;  y:= h - th - 1; end;
    _TL_sw: begin x:= bd + 4;          y:= h - th - 1; end;
    _TL_ws: begin x:= 0;               y:= h - bd - 4 - th; end;
    _TL_w:  begin x:= 0;               y:= (h - th) div 2; end;
    else    begin x:= 0;               y:= bd + 4; end; // _TL_wn:
  end;
  R:= Rect(x, y, x + tw, y + th);
  s:= Text;
  if Underline >= 0 then
    insert('&', s, Underline + 1);
  DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_LEFT);
end;

{--- TTKScale ------------------------------------------------------------------}

constructor TTKScale.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 45;
  Width:= 120;
  Height:= 32;
  FOrient:= horizontal;
  FFrom:= 0;
  FTo:= 100;
  FValue:= 30;
  FState:= normal;
end;

function TTKScale.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|From|To_|Orient|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|Command';
  if ShowAttributes = 3 then
    Result:= Result + '|State';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKScale.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else if Attr = 'To_' then
    inherited setAttribute('To', Value, Typ)
  else
    inherited;
end;

procedure TTKScale.NewWidget(Widget: string = '');
begin
 inherited NewWidget('ttk.Scale');
  MakeControlVar('variable', Name + 'CV', IntToStr(Round(FValue)), 'Int');
  setAttribute('To', '100', '');
end;

procedure TTKScale.MakeCommand(Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x');
end;

function TTKScale.getWidgetStylename: string;
begin
  if FOrient = horizontal
    then Result:= Name + '.Horizontal.TScale'
    else Result:= Name + '.Vertical.TScale';
end;

procedure TTKScale.Paint;
  var X, Y, V, SliderWidth, SliderHeight, UsablePixels: Integer;
      R: TRect;
begin
  inherited;       // Length??
  // track
  if FOrient = horizontal then begin
    R.Left  := 1;
    R.Right := Width - 1;
    R.Top   := Height div 2 - 1;
    R.Bottom:= R.Top + PPIScale(3);
    SliderWidth := PPIScale(12);
    SliderHeight:= PPIScale(23);
    UsablePixels := Width - PPIScale(2) - SliderWidth;
  end else begin
    R.Top := 1;
    R.Bottom := Height - 1;
    R.Left := Width div 2 - 1;
    R.Right := R.Left + PPIScale(3);
    SliderWidth := PPIScale(23);
    SliderHeight:= PPIScale(12);
    UsablePixels := Height - PPIScale(2) - SliderHeight;
  end;
  Canvas.Pen.Color:= $D6D6D6;
  Canvas.Rectangle(R);

  // slider
  V:= Round(UsablePixels * (FValue - FFrom) / (FTo - FFrom)) + 1;
  if FOrient = horizontal then begin
    X := Round(V);
    Y := Height div 2 - SliderHeight div 2;
    R:= Rect(X, Y, X + SliderWidth, Y + SliderHeight)
  end else begin
    X := Width div 2 - SliderWidth div 2;
    Y := Round(V);
    R:= Rect(X, Y, X + SliderWidth, Y + SliderHeight)
  end;
  Canvas.Brush.Color:= $D97A00;
  Canvas.FillRect(R);
end;

procedure TTKScale.setRValue(Value: Real);
begin
  if Value <> FValue then begin
    FValue := Value;
    if FValue > FTo then FValue := FTo
    else if FValue < FFrom then FValue := FFrom;
    Invalidate;
  end;
end;

{--- TTKLabeledScale ----------------------------------------------------------}

constructor TTKLabeledScale.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 46;
  Width:= 120;
  Height:= 48;
  FCompound:= _TC_top;
  FFrom:= 0;
  FTo:= 100;
  FValue:= 0;
  FState:= normal;
  FNameExtension:= '.scale';
end;

function TTKLabeledScale.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Compound|From|To_|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|Command';
  if ShowAttributes = 3 then
    Result:= Result + '|Padding|State';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKLabeledScale.setAttribute(Attr, Value, Typ: string);
  var s: string; p: Integer;
begin
  if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else if (Attr = 'Compound') or (Attr = 'From') or (Attr = 'To_') then
    setConfiguration
  else if (Attr = 'BorderWidth') or (Attr = 'Relief') then begin
    s:= getAttrAsKey(Attr);
    p:= Pos(FNameExtension, s);
    Delete(s, p, Length(FNameExtension));
    if Value = ''
      then Partner.DeleteAttribute(s)
      else setAttributValue(s, s + ' = ' + asString(Value))
  end else
    inherited;
end;

procedure TTKLabeledScale.setConfiguration;
  var s, scomp: string;
begin
  if Compound = _TC_top
    then scomp:= asString('top')
    else scomp:= asString('bottom');
  s:= 'self.'+ Name + ' = ttk.LabeledScale';
  setAttributValue(s, s + '(variable=self.' + Name + 'CV, compound=' + scomp +
                      ', from_=' + FloatToStr(FFrom) + ', to=' + FloatToStr(FTo) + ')');
end;

procedure TTKLabeledScale.NewWidget(Widget: string = '');
begin
  InsertValue('self.' + Name + 'CV = tk.IntVar()');
  inherited NewWidget('ttk.LabeledScale');
  setConfiguration;
end;

procedure TTKLabeledScale.MakeCommand(Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x');
end;

procedure TTKLabeledScale.Paint;
  var X, Y, V, SliderWidth, SliderHeight, UsablePixels, tw, th: Integer;
      R: TRect; s: string;
begin
  inherited;
  // track
  R.Left  := 1;
  R.Right := Width - 1;
  if FCompound = _TC_top
    then R.Top:= Height - PPIScale(15)
    else R.Top:= PPIScale(12);
  R.Bottom:= R.Top + PPIScale(3);
  SliderWidth := PPIScale(12);
  SliderHeight:= PPIScale(23);
  UsablePixels := Width - 2 - SliderWidth;
  Canvas.Pen.Color:= $D6D6D6;
  Canvas.Rectangle(R);

  // slider
  V:= Round(UsablePixels * (FValue - FFrom) / (FTo - FFrom)) + 1;
  X := Round(V);
  Y := R.Top + 1 - SliderHeight div 2;
  R:= Rect(X, Y, X + SliderWidth, Y + SliderHeight);
  Canvas.Brush.Color:= $D97A00;
  Canvas.FillRect(R);

  // Label
  s:= IntToStr(round(FValue));
  tw:= Canvas.TextWidth(s);
  th:= Canvas.TextHeight(s);
  x:= R.Left + (R.Right - R.Left - tw) div 2;
  if FCompound = _TC_top
    then y:= R.Top - th - PPIScale(3)
    else y:= R.Bottom + PPIScale(3);
  Canvas.Brush.Color:= clBtnFace;
  Canvas.TextOut(x, y, s);
end;

procedure TTKLabeledScale.setRValue(Value: Real);
begin
  if Value <> FValue then begin
    FValue := Value;
    if FValue > FTo then FValue := FTo
    else if FValue < FFrom then FValue := FFrom;
    Invalidate;
  end;
end;

procedure TTKLabeledScale.setCompound(Value: TCompound);
begin
  if FCompound <> Value then begin
    FCompound:= Value;
    invalidate;
  end;
end;

{--- TTKScrollbar --------------------------------------------------------------}

constructor TTKScrollbar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 42;
  Width:= 120;
  Height:= 20;
  FOrient:= horizontal;
end;

function TTKScrollbar.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Command|Orient';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKScrollbar.MakeCommand(Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x, y, z');
end;

procedure TTKScrollbar.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Scrollbar');
  InsertValue('self.' + Name + '[''orient''] = ' + asString('horizontal'));
end;

function TTKScrollbar.getWidgetStylename: string;
begin
  if FOrient = horizontal
    then Result:= Name + '.Horizontal.TScrollbar'
    else Result:= Name + '.Vertical.TScrollbar';
end;

procedure TTKScrollbar.Paint;
begin
  PaintScrollbar(ClientRect, FOrient = horizontal, True);
end;

{--- PanedWindow --------------------------------------------------------------}

constructor TTKPanedWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 47;
  ControlStyle := [csAcceptsControls];
  Orient:= vertical;
end;

procedure TTKPanedWindow.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.PanedWindow');
end;

function TTKPanedWindow.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Orient';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKPanedWindow.PaintSlashAt(Pos: Integer);
  var R: TRect; w: Integer;
begin
  w:= 2;
  if FOrient = horizontal
    then R:= Rect(Pos - w, 0, Pos + w, Height)
    else R:= Rect(0, Pos - w, Width, Pos + w);
  Canvas.Brush.Color:= Background;
  Canvas.FillRect(R);
end;

function TTKPanedWindow.getPos(i: Integer): Integer;
  var SashW: Integer; ControlW: real;
begin
  SashW:= 5;
  if ControlCount > 0 then
    if FOrient = horizontal
       then ControlW:= (Width - (ControlCount - 1)* SashW)/(ControlCount*1.0)
       else ControlW:= (Height - (ControlCount - 1)* SashW)/(ControlCount*1.0)
  else
    ControlW:= 0;
  Result:= Round(i*ControlW + (i-1)*SashW + SashW div 2);
end;

procedure TTKPanedWindow.Paint;
  var R: TRect; i: Integer;
begin
  inherited;
  R:= ClientRect;
  Canvas.Brush.Color:= Background;
  Canvas.FillRect(R);
  if ControlCount > 1 then
    for i:= 1 to ControlCount - 1 do
      PaintSlashAt(getPos(i))
  else
    PaintSlashAt(getPos(1)); // to show a slider in the gui form
end;

procedure TTKPanedWindow.Resize;
  var i, w, cw, ch: Integer;
begin
  w:= 2;
  if Orient = horizontal then begin
    ch:= Height;
    if ControlCount > 1 then begin
      cw:= getPos(1) - w;
      Controls[0].SetBounds(0, 0, cw, ch);
      for i:= 1 to ControlCount - 1 do
        Controls[i].SetBounds(getPos(i) + w, 0, cw, ch);
      Controls[ControlCount-1].SetBounds(getPos(ControlCount-1) + w, 0, cw, ch);
    end else if ControlCount = 1 then
      Controls[0].SetBounds(0, 0, Width, ch);
  end else begin
    cw:= Width;
    if ControlCount > 1 then begin
      ch:= getPos(1) - w;
      Controls[0].SetBounds(0, 0, cw, ch);
      for i:= 1 to ControlCount - 1 do
        Controls[i].SetBounds(0, getPos(i) + w, cw, ch);
      Controls[ControlCount-1].SetBounds(0, getPos(ControlCount-1) + w, cw, ch);
    end else if ControlCount = 1 then
      Controls[0].SetBounds(0, 0, cw, Height);
  end;
end;

{--- TKRadiobuttonGroup -------------------------------------------------------}

constructor TTKRadiobuttonGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 37;
  FColumns:= 1;
  FItems:= TStringList.Create;
  FOldItems:= TStringList.Create;
  FLabel:= ' ' + _('Continent') + ' ';
end;

destructor TTKRadiobuttonGroup.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TTKRadiobuttonGroup.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Columns|Command|Items|Label_|Name|Checkboxes';
  if ShowAttributes = 3 then
    Result:= Result + '|Height|Width|Left|Top';
end;

procedure TTKRadiobuttonGroup.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Command' then
    ChangeCommand(Value)
  else if Attr = 'Items' then
    MakeButtonGroupItems
  else if Attr = 'Columns' then
    SetPositionAndSize
  else if Attr = 'Label_' then
    MakeLabel(Value)
  else if Attr = 'Background' then begin
    inherited;
    MakeButtongroupItems;
  end else if Attr = 'Checkboxes' then
    MakeButtongroupItems
  else if isFontAttribute(Attr) then begin
    if Label_ <> '' then inherited;
    MakeButtongroupItems;
  end else
    inherited;
end;

function TTKRadiobuttonGroup.RBName(i: Integer): string;
begin
  Result:= 'self.' + Name + 'RB' + IntToStr(i);
end;

procedure TTKRadiobuttonGroup.MakeButtongroupItems;
  var key, Options, s: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  for var i := 0 to FOldItems.Count - 1 do begin
    Partner.DeleteAttributeValues(RBName(i));
    Partner.DeleteAttributeValues(RBName(i) + 'CV');
  end;
  Partner.DeleteAttributeValues('self.' + Name + '[''variable'']');

  s:= '';
  for var i:= 0 to FItems.Count - 1 do begin
    key:= asString(FItems[i]);
    if FCheckboxes then begin
      Options:= 'self.' + Name + ', text=' + key;
      s:= s + surround(RBName(i) + ' = ttk.Checkbutton(' + Options + ')') +
          surround(RBName(i) + '.place(x=0, y=0, width=0, height=0)') +
          surround(RBName(i) + 'CV = tk.IntVar()') +
          surround(RBName(i) + '[''variable''] = ' + RBName(i) + 'CV') +
          surround(RBName(i) + 'CV.set(0)');
    end else begin
      Options:= 'self.' + Name + ', text=' + key + ', value=' + key;
      s:= s + surround(RBName(i) + ' = ttk.Radiobutton(' + Options + ')') +
          surround(RBName(i) + '.place(x=0, y=0, width=0, height=0)') +
          surround(RBName(i) + '[''variable''] = self.' + Name + 'CV');
    end;
  end;
  insertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
  FOldItems.Text:= FItems.Text;
  setPositionAndSize;
end;

procedure TTKRadiobuttonGroup.SetPositionAndSize;
  var col, row, ItemsInCol, line, x, y, th: Integer;
      RadioHeight, RadioWidth, ColWidth, RowHeight, ColWidthRest, RowHeightRest: Integer;
      xold, yold,ColWidthI, RowHeightI: Integer;
      key: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited;
  Canvas.Font.Assign(Font);
  th:= Canvas.TextHeight('Hg');
  if FLabel = '' then begin
    RadioWidth:= Width;
    RadioHeight:= Height;
  end else begin
    RadioWidth:= Width - PPIScale(4);
    RadioHeight:= Height - th - PPIScale(4);
  end;

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
        then x:= 0
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
          then y:= 0 // th in Qt?
          else y:= yold + RowHeightI;
        Dec(RowHeightRest);
        key:= RBName(line) + '.place';
        setAttributValue(key, key + '(x=' + IntToStr(PPIUnScale(x)) + ', y=' + IntToStr(PPIUnScale(y)) +
          ', width=' + IntToStr(PPIUnScale(ColWidthI)) + ', height=' + IntToStr(PPIUnScale(RowHeightI)) + ')');
        Inc(line);
        yold:= y;
      end;
      xold:= x;
    end;
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKRadiobuttonGroup.MakeCommand(Attr, Value: string);
  var func, nam, s: string; i: Integer;
begin
  Command:= True;
  nam:= Name + '_Command';
  func:= CrLF +
         Indent1 + 'def ' + nam +'(self):' + CrLf +
         Indent2 + '# ToDo insert source code here' + CrLf +
         Indent2 + 'pass' + CrLf;
  Partner.InsertProcedure(func);
  s:= '';
  for i:= 0 to FItems.Count - 1 do
    s:= s + surround(RBName(i) + '[''command''] = ' + 'self.' + nam);
  insertValue(s);
end;

procedure TTKRadiobuttonGroup.ChangeCommand(Value: string);
  var key: string; i: Integer;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  if Value = 'True' then begin
    MakeCommand('Command', Value);
    for i:= 0 to FItems.Count - 1 do begin
      key:= RBName(i) + '[''command'']';
      setAttributValue(key, key + ' = self.' + Name + '_Command');
    end;
  end else begin
    Partner.DeleteMethod(Name + '_Command');
    for i:= 0 to FItems.Count - 1 do
      Partner.DeleteAttribute(RBName(i) + '[''command'']');
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKRadiobuttonGroup.MakeLabel(aLabel: string);
begin
  FLabel:= aLabel;
  var key:= 'self.' + Name + ' = ';
  if aLabel = '' then begin
    Partner.ReplaceLine(key, Indent2 + key + 'ttk.Frame()');
    Partner.DeleteAttribute('self.' + Name + '[''text'']');
  end else begin
    Partner.ReplaceLine(key, Indent2 + key + 'ttk.LabelFrame()');
    key:= 'self.' + Name + '[''text'']';
    setAttributValue(key, key + ' = ' + asString(FLabel));
  end;
  setPositionAndSize;
end;

procedure TTKRadiobuttonGroup.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Frame');
  MakeLabel(' ' + _('Continent') + ' ');
  FItems.Text:= defaultItems;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + asString(FItems[0]) + ')');
  MakeButtongroupItems;
end;

procedure TTKRadiobuttonGroup.DeleteWidget;
begin
  for var i := 0 to FItems.Count - 1 do begin
    Partner.DeleteAttributeValues(RBName(i));
    Partner.DeleteAttributeValues(RBName(i) + 'CV');
  end;
  inherited;
end;

procedure TTKRadiobuttonGroup.setItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then begin
    FOldItems.Text:= FItems.Text;
    FItems.Text:= Value.Text;
    Invalidate;
  end;
end;

procedure TTKRadiobuttonGroup.setColumns(Value: Integer);
begin
  if (FColumns <> Value) and (Value > 0) then begin
    FColumns:= Value;
    Invalidate;
  end;
end;

procedure TTKRadiobuttonGroup.setLabel(Value: string);
begin
  if FLabel <> Value then begin
    FLabel:= Value;
    Invalidate;
  end;
end;

procedure TTKRadiobuttonGroup.setCheckboxes(Value: Boolean);
begin
  if FCheckboxes <> Value then begin
    FCheckboxes:= Value;
    Invalidate;
  end;
end;

function TTKRadiobuttonGroup.ItemsInColumn(i: Integer): Integer;
  var quot, rest: Integer;
begin
  quot:= FItems.Count div FColumns;
  rest:= FItems.Count mod FColumns;
  if i <= rest
    then Result:= quot + 1
    else Result:= quot;
end;

procedure TTKRadiobuttonGroup.Paint;
  const cRadius = 5;
  var ColumnWidth, RowWidth, RadioHeight, LabelHeight,
      col, row, yc, ItemsInCol, line, x, y, th, Radius: Integer;
      R: TRect; s: string;
begin
  FOldItems.Text:= FItems.Text;
  inherited;
  Radius:= PPIScale(cRadius);
  Canvas.FillRect(ClientRect);
  th:= Canvas.TextHeight('Hg');
  LabelHeight:= 0;
  RadioHeight:= Height;
  R:= ClientRect;
  if FLabel <> '' then begin
    R.Top:= th div 2;
    LabelHeight:= th;
    RadioHeight:= Height - th;
    Canvas.Rectangle(R);
    Canvas.Textout(PPIScale(10), 0, FLabel);
  end;

  if FItems.Count > 0 then begin
    ColumnWidth:= Width div FColumns;
    RowWidth:= RadioHeight div ItemsInColumn(1);
    line:= 0;
    for col:= 1 to FColumns do begin
      ItemsInCol:= ItemsInColumn(col);
      for row:= 1 to ItemsInCol do begin
        x:= PPIScale(4) + (col - 1)*ColumnWidth;
        y:= LabelHeight + 2 + (row - 1)*RowWidth;
        Canvas.Brush.Color:= clWhite;
        if FCheckboxes then begin
          R:= Rect(x, y + PPIScale(6), x + PPIScale(13), y + PPIScale(19));
          Canvas.Rectangle(R);
        end else begin
          yc:= y + RowWidth div 2 - Radius;
          Canvas.Ellipse(x, yc, x + 2*Radius, yc + 2*Radius);
        end;
        Canvas.Brush.Color:= clBtnFace;
        yc:= y + RowWidth div 2 - th div 2;
        R:= Rect(x + PPIScale(15), yc, col*ColumnWidth, yc + RowWidth);
        s:= FItems[line];
        Canvas.TextRect(R, s);
        Inc(line);
      end;
    end;
  end;
end;

{--- TTKNotebook --------------------------------------------------------------}

constructor TTKNotebook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 50;
  FTabs:= TStringList.Create;
  FTabs.Text:= 'Tab 1'#13#10'Tab 2'#13#10'Tab 3';
  FOldTabs:= TStringList.Create;
end;

destructor TTKNotebook.Destroy;
begin
  FreeAndNil(FTabs);
  FreeAndNil(FOldTabs);
  inherited;
end;

function TTKNotebook.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Padding|Tabs';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKNotebook.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Tabs' then
    MakeTabs
  else
    inherited;
end;

function TTKNotebook.TabName(i: Integer): string;
begin
  Result:= 'self.' + Name + 'Tab' + IntToStr(i);
end;

procedure TTKNotebook.DeleteWidget;
begin
  inherited;
  DeleteTabs;
end;

procedure TTKNotebook.DeleteTabs;
  var i, all: Integer;
begin
  all:= Max(FOldTabs.Count - 1, FTabs.Count - 1);
  for i:= 0 to all do
    Partner.DeleteAttributeValues(TabName(i));
end;

procedure TTKNotebook.MakeTabs;
  var i: Integer; s: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  DeleteTabs;
  s:= '';
  for i:= 0 to FTabs.Count - 1 do begin
    s:= s + surround(TabName(i) + ' = ttk.Frame(self.' + Name + ')');
    s:= s + surround('self.' + Name + '.add(' + TabName(i) + ', text=' + asString(FTabs[i]) + ')');
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKNotebook.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Notebook');
  MakeTabs;
end;

procedure TTKNotebook.setTabs(Value: TStrings);
begin
  FOldTabs.Text:= FTabs.Text;
  FTabs.Text:= Value.Text;
  Invalidate;
end;

procedure TTKNotebook.Paint;
  var pl, pt, pr, pb, tw, th, x, y, i: Integer; R: TRect; s: string;
begin
  Background:= clBtnFace;
  inherited;
  CalculatePadding(pl, pt, pr, pb);
  Canvas.Pen.Color:= $D9D9D9;
  Canvas.MoveTo(pl, pt);
  Canvas.LineTo(pl, Height - pb);
  Canvas.Lineto(Width - pr, Height - pb);
  Canvas.LineTo(Width - pr, pt -1);
  x:= pl;
  y:= pt;
  for i:= 0 to FTabs.Count - 1 do begin
    s:= FTabs[i];
    tw:= Canvas.TextWidth(s) + 8;
    th:= Canvas.TextHeight(s) + 4;
    if i = 0 then begin
      Canvas.Brush.Color:= clWindow;
      R:= Rect(x, y, x + tw, y + th + 2);
    end else begin
      Canvas.Brush.Color:= $F0F0F0;
      R:= Rect(x, y, x + tw, y + th);
    end;
    Canvas.Rectangle(R);
    Canvas.TextOut(x + 4, y + 2, s);
    x:= x + tw - 1;
    y:= pt + 2;
  end;
end;

{--- TTKTreeview --------------------------------------------------------------}

constructor TTKTreeview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 51;
  FColumns:= TStringList.Create;
  FColumns.Text:= 'Items';
  FItems:= TStringList.Create;
  FItems.Text:= 'First'#13#10'  node A'#13#10'  node B'#13#10'Second'#13#10'   node C'#13#10'    node D';
  FOldItems:= TStringList.Create;
  FShowHeadings:= True;
end;

destructor TTKTreeview.Destroy;
begin
  FreeAndNil(FColumns);
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TTKTreeview.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Columns|Items|Padding|Scrollbars';
  if ShowAttributes >= 2 then
    Result:= Result + '|SelectMode|ShowHeadings';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKTreeview.setAttribute(Attr, Value, Typ: string);
  var key: string;
begin
  if Attr = 'Columns' then
    MakeColumns
  else if Attr = 'Items' then begin
    MakeItems;
    if FColumns.Text = '' then
      MakeColumns;
  end else if Attr = 'Scrollbars' then
    MakeScrollbars(Value, 'ttk.')
  else if Attr = 'ShowHeadings' then begin
    key:= getAttrAsKey('Show');
    if Value = 'True'
      then Partner.DeleteAttribute(key)
      else InsertValue(key + ' = ' + asString('tree'));   // test
  end else
    inherited;
  if Attr = 'Padding' then
    MakeColumns;
end;

function TTKTreeview.ColumnId(i: Integer): string;
begin
  Result:= asString('#' + IntToStr(i));
end;

procedure TTKTreeview.DeleteWidget;
begin
  inherited;
  DeleteColumns;
end;

procedure TTKTreeview.DeleteColumns;
begin
  Partner.DeleteAttribute(getAttrAsKey('Columns'));
  //Partner.DeleteAttribute(getAttrAsKey('DisplayColumns'));
  Partner.DeleteAttributeValues('self.' + Name + '.column');
  Partner.DeleteAttributeValues('self.' + Name + '.heading');
end;

procedure TTKTreeview.MakeColumns;
  var w, i, Count, pl, pt, pr, pb: Integer; s, s1: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  DeleteColumns;
  CalculatePadding(pl, pt, pr, pb);
  s:= '';
  Count:= FColumns.Count;
  if Count = 0 then begin
    w:= Width - pl - pr - 2;
    s:= s + surround('self.' + Name + '.column(' + ColumnId(0) + ', width=' + IntToStr(w) + ')');
  end else begin
    s1:= asString(FColumns[0]);
    for i:= 1 to FColumns.Count - 1 do
      s1:= s1 + ', ' + asString(FColumns[i]);
    s1:= '(' + s1 + ')';
    s:= s + surround(getAttrAsKey('Columns') + ' = ' + s1);
    UpdateObjectInspector;
    w:= (Width - pl - pr - 2) div Count;
    for i:= 0 to Count - 1 do
      s:= s + surround('self.' + Name + '.column(' + ColumnId(i) + ', width=' + IntToStr(w) + ')');
    // hack
    if Count = 1 then
      s:= s+ surround('self.' + Name + '.column(' + ColumnId(1) + ', width=0)');
    for i:= 0 to Count - 1 do
      s:=s + surround('self.' + Name + '.heading(' + ColumnId(i) + ', text=' + asString(FColumns[i]) + ')');
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TTKTreeview.hasSubNodes(i: Integer): Boolean;
begin
  Result:= (i < FItems.Count - 1) and
           (LeftSpaces(FItems[i], 2) < LeftSpaces(FItems[i+1], 2));
end;

procedure TTKTreeview.MakeItems;
  var i, ls, Indent, NodeCount: Integer;
      s: string;
      NodeId: array[-1..10] of string;

  function MakeNode(Indent: Integer; Id: string = ''): string;
    var s: string;
  begin
    s:= 'self.' + Name + '.insert(' + asString(NodeId[Indent-1]) + ', ' + asString('end');
    if Id <> '' then
      s:= s + ', ' + asString(Id);
    s:= s + ', text=' + asString(Trim(FItems[i])) + ')';
    Result:= surround(s);
  end;

  function getNextNodeId: string;
  begin
    Inc(NodeCount);
    Result:= 'Id' + IntToStr(NodeCount);
  end;

begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteAttributeValues('self.' + Name + '.insert');

  FormatItems(FItems);
  NodeCount:= 0;
  NodeId[-1]:= '';
  Indent:= 0;
  // insert new items
  i:= 0;
  s:= '';
  while i < Items.Count do begin
    ls:= LeftSpaces(Items[i], 2) div 2;
    if ls < Indent then begin  // close open menus
      while Indent > ls do
        Dec(Indent);
      Dec(i);
    end else if ls > Indent then begin
      s:= s + MakeNode(Indent);
      Inc(Indent);
    end else if hasSubNodes(i) then begin  // create new node/subnode
      NodeId[Indent]:= getNextNodeId;
      s:= s + MakeNode(Indent, NodeId[Indent]);
      Inc(Indent);
    end else
      s:= s + MakeNode(Indent);
    Inc(i);
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKTreeview.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Treeview');
  MakeColumns;
  MakeItems;
end;

procedure TTKTreeview.setItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then begin
    FOldItems.Text:= FItems.Text;
    FItems.Text:= Value.Text;
    Invalidate;
  end;
end;

procedure TTKTreeview.setColumns(Value: TStrings);
begin
  if FColumns.Text <> Value.Text then begin
    FColumns.Text:= Value.Text;
    Invalidate;
  end;
end;

procedure TTKTreeview.setDisplayColumns(Value: string);
begin
  if FDisplayColumns <> Value then begin
    FDisplayColumns:= Value;
    Invalidate;
  end;
end;

procedure TTKTreeview.setShowHeadings(Value: Boolean);
begin
  if FShowHeadings <> Value then begin
    FShowHeadings:= Value;
    Invalidate;
  end;
end;

function TTKTreeview.getWidgetStylename: string;
begin
  Result:= Name + '.Treeview';
end;

procedure TTKTreeview.Paint;
  var pl, pt, pr, pb, x, y, i, Count, ColWidth: Integer;
      R: TRect; s: string;
begin
  Background:= clWindow;
  FOldItems.Text:= FItems.Text;
  inherited;
  CalculatePadding(pl, pt, pr, pb);
  // headings
  ColWidth:= Width - pl - pr - 2;
  Canvas.Pen.Color:= $908782;
  Canvas.Rectangle(ClientRect);
  if FShowHeadings then begin
    Count:= FColumns.Count;
    if Count > 1 then begin
      ColWidth:= ColWidth div Count;
      Canvas.Pen.Color:= $E5E5E5;
      for i:= 1 to Count - 1 do begin
        x:= pl + i*ColWidth;
        Canvas.MoveTo(x, 1);
        Canvas.LineTo(x, PPIScale(24));
      end;
    end;
    for i:= 0 to Count - 1 do begin
      x:= pl + i*ColWidth + 1;
      R:= Rect(x, PPIScale(4), x + ColWidth, PPIScale(23));
      s:= FColumns[i];
      DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_CENTER);
    end;
    y:= PPIScale(26);
  end else
    y:= PPIScale(2);
  // nodes
  x:= 1;
  i:= 0;
  while i < FItems.Count do begin
    if LeftSpaces(FItems[i], 2) = 0 then begin
      if hasSubNodes(i) then begin
        R:= Rect(x + PPIScale(5), y + PPIScale(6), x + PPIScale(14), y + PPIScale(15));
        Canvas.Pen.Color:= $919191;
        Canvas.Rectangle(R);
        Canvas.Pen.Color:= $724229;
        Canvas.MoveTo(x + PPIScale(9), y + PPIScale(8));
        Canvas.LineTo(x + PPIScale(9), y + PPIScale(13));
        Canvas.Pen.Color:= $A7634B;
        Canvas.MoveTo(x +  PPIScale(7), y + PPIScale(10));
        Canvas.LineTo(x + PPIScale(12), y + PPIScale(10));
      end;
      s:= FItems[i];
      R:= Rect(x + PPIScale(20), y + PPIScale(2), x + ColWidth - 1, y + PPIScale(22));
      DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_LEFT);
      y:= y + PPIScale(20);
      if y + PPIScale(20) > Height - pb then
        i:= FItems.Count;
    end;
    Inc(i);
  end;
  PaintScrollbars(Scrollbars);
end;

{--- TTKProgresbar ------------------------------------------------------------}

constructor TTKProgressbar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 52;
  Width:= 120;
  Height:= 24;
  FOrient:= horizontal;
  FMaximum:= 100;
  FMode:= determinate;
  FValue:= 30;
end;

function TTKProgressbar.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Maximum|Orient|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|Mode';
  if ShowAttributes = 3 then
    Result:= Result + '';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKProgressbar.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else
    inherited;
end;

procedure TTKProgressbar.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Progressbar');
  MakeControlVar('variable', Name + 'CV', FloatToStr(FValue), 'Double');
  Partner.ActiveSynEdit.EndUpdate;
end;

function TTKProgressbar.getWidgetStylename: string;
begin
  if FOrient = horizontal
    then Result:= Name + '.Horizontal.TProgressbar'
    else Result:= Name + '.Vertical.TPrograssbar';
end;

procedure TTKProgressbar.Paint;
  var x, y: Integer; R: TRect;
begin
  inherited;
  Canvas.Pen.Color:= $BCBCBC;
  Canvas.Brush.Color:= $E6E6E6;
  R:= ClientRect;
  Canvas.Rectangle(R);
  R.Inflate(-3, -3);
  if FOrient = horizontal then begin
    x:= Round((Width - 6) * FValue / FMaximum);
    R.Right:= R.Left + x;
  end else begin
    y:= Round((Height - 6) * FValue / FMaximum);
    R.Top:= R.Bottom - y;
  end;
  Canvas.Brush.Color:= $25B006;
  Canvas.FillRect(R);
end;

procedure TTKProgressbar.setRValue(Value: Real);
begin
  if Value <> FValue then begin
    FValue := Value;
    Invalidate;
  end;
end;

{--- TTKSeparator -------------------------------------------------------------}

constructor TTKSeparator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 53;
  Width:= 120;
  Height:= 2;
  FOrient:= horizontal;
end;

function TTKSeparator.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Orient';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKSeparator.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Separator');
end;

procedure TTKSeparator.Paint;
begin
  inherited;
  Canvas.Pen.Color:= $A0A0A0;
  Canvas.MoveTo(0, 0);
  if FOrient = horizontal then begin
    Canvas.LineTo(Width + 1, 0);
    Canvas.Pen.Color:= clWhite;
    Canvas.MoveTo(0, 1);
    Canvas.LineTo(Width + 1, 1)
  end else begin
    Canvas.LineTo(0, Height + 1);
    Canvas.Pen.Color:= clWhite;
    Canvas.MoveTo(1, 0);
    Canvas.LineTo(1, Height + 1)
  end;
end;

{--- TTKSizeGrip --------------------------------------------------------------}

constructor TTKSizeGrip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 54;
  Width:= 14;
  Height:= 14;
end;

procedure TTKSizeGrip.NewWidget(Widget: string = '');
begin
  InsertValue('self.' + Name + ' = ttk.Sizegrip(' + getContainer + ')');
  InsertValue('self.' + Name + '.pack(side=' + asString('right') + ', anchor=' + asString('se') + ')');
end;

function TTKSizeGrip.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Name';
end;

procedure TTKSizeGrip.Paint;
  var pw, ph, p3, p14: Integer; R: TRect;
begin
  p14:= PPIScale(14);
  p3:= PPIScale(3);
  setBounds(Parent.ClientWidth-p14, Parent.ClientHeight-p14, p14, p14);
  inherited;
  pw:= ClientWidth;
  ph:= ClientHeight;

  Canvas.Brush.Color:= $BFBFBF;
  R:= Rect(pw - PPIScale(11), ph - PPIScale(5), pw - PPIScale(9), ph - p3);
  Canvas.FillRect(R);
  R.Offset(p3, 0);
  Canvas.FillRect(R);
  R.Offset(p3, 0);
  Canvas.FillRect(R);
  R.Offset(0, -p3);
  Canvas.FillRect(R);
  R.Offset(0, -p3);
  Canvas.FillRect(R);
  R.Offset(-p3, +p3);
  Canvas.FillRect(R);
end;

procedure TTKSizeGrip.SetPositionAndSize;
begin
  // do nothing
end;

end.

