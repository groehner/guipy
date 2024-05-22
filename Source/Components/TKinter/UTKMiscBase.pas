{-------------------------------------------------------------------------------
 Unit:     UTKMiscBase
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  tkinter misc widgets
-------------------------------------------------------------------------------}

unit UTKMiscBase;

{ class hierarchy

  TKMiscBaseWidget
    TKFrame
      TKLabelFrame
    TKMessage
    TKScale
    TKScrollbar
    TKPopupMenu
      TKMenu
    TKPanedWindow
    TKRadiobuttonGroup
}

interface

uses
  Windows, Classes, Controls, Graphics, UBaseTkWidgets, UTKWidgets;

type

  // positioning of text, used in TextWidget
  TLabelAnchor = (_TL_nw, _TL_n, _TL_ne, _TL_en, _TL_e, _TL_es, _TL_se, _TL_s, _TL_sw, _TL_ws, _TL_w, _TL_wn);

  TOrient = (horizontal, vertical);

  TButtonState = (active, disabled, normal);

  TType = (_TT_menubar, _TT_normal);    // normal is used in TButtonState

  TKMiscBaseWidget = class(TKWidget)
  private
    FClass: String;
    FColormap: String;
    FContainer: boolean;
    FOrient: TOrient;
    FRepeatDelay: integer;
    FRepeatInterval: integer;
    FTroughColor: TColor;
  protected
    procedure setOrient(Value: TOrient);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;

    property Class_: String read FClass write FClass;
    property Colormap: String read FColormap write FColormap;
    property Container: boolean read FContainer write FContainer default false;
    property Orient: TOrient read FOrient write setOrient default vertical;
    property RepeatDelay: integer read FRepeatDelay write FRepeatDelay default 300;
    property RepeatInterval: integer read FRepeatInterval write FRepeatInterval default 100;
    property TroughColor: TColor read FTroughColor write FTroughColor default clScrollbar;
  end;

  TKFrame = class (TKMiscBaseWidget)
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure MakeFont; override;
  published
    property Font;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
  end;

  TKLabelframe = class (TKFrame)
  private
    FLabelAnchor: TLabelAnchor;
    FLabelWidget: String;
    procedure setLabelAnchor(Value: TLabelAnchor);
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure Paint; override;
  published
    property Foreground;
    property LabelAnchor: TLabelAnchor read FLabelAnchor write setLabelAnchor default _TL_nw;
    property LabelWidget: String read FLabelWidget write FLabelWidget;
    property Text;
  end;

  TKMessage = class (TKMiscBaseWidget)
  private
    FAnchor: TAnchor;
    FAspect: integer;
    FJustify: TJustify;
    procedure setJustify(Value: TJustify);
    procedure setAnchor(Value: TAnchor);
    procedure setAspect(Value: integer);
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property Anchor: TAnchor read FAnchor write setAnchor default _TA_center;
    property Aspect: integer read FAspect write setAspect default 150;
    property Foreground;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Justify: TJustify read FJustify write setJustify default _TJ_left;
    property Text;
  end;

  TKScale = class (TKMiscBaseWidget)
  private
    FBigIncrement: integer;
    FDigits: integer;
    FFrom: real;
    FLabel: String;
    FLength: integer;
    FResolution: real;
    FShowValue: boolean;
    FSliderLength: integer;
    FSliderRelief: TRelief;
    FState: TButtonState;
    FTickInterval: real;
    FTo: real;
    FValue: real;
    FTrackRect: TRect;
    FUsablePixels: Integer;
    FTrackSize: Integer;
    FTickSpace: integer;
    FDecimals: integer;
    procedure setFrom(Value: real);
    procedure setLabel(Value: String);
    procedure setResolution(Value: real);
    procedure setShowValue(Value: boolean);
    procedure setSliderLength(Value: integer);
    procedure setTickInterval(Value: real);
    procedure setTo(Value: real);
    procedure setRValue(Value: real);
    procedure UpdateTrackData;
    procedure UpdateTrack;
    procedure UpdateTicks;
    procedure UpdateSlider;
    procedure UpdateLabel;
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure MakeCommand(Attr, Value: String); override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property BigIncrement: integer read FBigIncrement write FBigIncrement default 0;
    property Command;
    property Digits: integer read FDigits write FDigits default 0;
    property Font;
    property Foreground;
    property From: real read FFrom write SetFrom;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Label_: String read FLabel write SetLabel;
    property Length: integer read FLength write FLength default 100;
    property Orient;
    property Relief;
    property RepeatDelay;
    property RepeatInterval;
    property Resolution: real read FResolution write setResolution;
    property ShowValue: boolean read FShowValue write setShowValue default true;
    property SliderLength: integer read FSliderLength write setSliderLength default 30;
    property SliderRelief: TRelief read FSliderRelief write FSliderRelief default _TR_raised;
    property State: TButtonState read FState write FState default normal;
    property TakeFocus;
    property TickInterval: real read FTickInterval write setTickinterval;
    property To_: real read FTo write setTo;
    property TroughColor;
    property Value: real read FValue write setRValue;
  end;

  TKScrollbar = class(TKMiscBaseWidget)
  private
    FActiveRelief: TRelief;
    FElementBorderWidth: integer;
    FJump: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property ActiveRelief: TRelief read FActiveRelief write FActiveRelief default _TR_raised;
    property ElementBorderWidth: integer read FElementBorderWidth write FElementBorderWidth default -1;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Jump: boolean read FJump write FJump default false;
    property Orient;
    property RepeatDelay;
    property RepeatInterval;
    property TroughColor;
  end;

  TKPopupMenu = class(TKMiscBaseWidget)
  private
    FActiveBorderWidth: integer;
    FActiveForeground: TColor;
    FDisabledForeground: TColor;
    FMenuItems: TStrings;
    FPostCommand: Boolean;
    FSelectColor: TColor;
    FType: TType;
    procedure setItems(aItems: TStrings);
    procedure MakeMenuItems;
    function hasSubMenu(MenuItems: TStrings; i: integer): boolean;
    function makeMenuName(m, s: string): string;
    procedure CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings);
  protected
    function MakeMenubar: string; virtual;
  public
    MenuItemsOld: TStrings;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NewWidget(Widget: String = ''); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    procedure Rename(const OldName, NewName, Events: string); override;
    procedure SetPositionAndSize; override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property ActiveBorderWidth: integer read FActiveBorderWidth write FActiveBorderWidth default 1;
    property ActiveForeground: TColor read FActiveForeground write FActiveForeground default clHighlight;
    // doesn't work
    property DisabledForeground: TColor read FDisabledForeground write FDisabledForeground default clGrayText;
    property Foreground;
    property Font;
    property MenuItems: TStrings read FMenuItems write setItems;
    property PostCommand: Boolean read FPostCommand write FPostCommand;
    property Relief;
    // doesn't work
    property SelectColor: TColor read FSelectColor write FSelectColor default clMenuText;
    property Type_: TType read FType write FType default _TT_normal;
  end;

  TKMenu = class(TKPopupMenu)
  protected
    function MakeMenubar: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  end;

  TKPanedWindow = class (TKMiscBaseWidget)
  private
    FHandlePad: integer;
    FHandleSize: String;
    FOpaqueResize: boolean;
    FProxyBackground: TColor;
    FProxyBorderWidth: String;
    FProxyRelief: TRelief;
    FSashCursor: TCursor;
    FSashPad: String;
    FSashRelief: TRelief;
    FSashWidth: String;
    FShowHandle: boolean;

    HandleSizeInt: integer;
    SashPadInt: integer;
    SashWidthInt: integer;
    procedure setHandlePad(Value: integer);
    procedure setHandleSize(Value: String);
    procedure setSashPad(Value: String);
    procedure setSashRelief(Value: TRelief);
    procedure setSashWidth(Value: String);
    procedure setShowHandle(Value: boolean);
    procedure PaintSlashAt(Pos: integer);
    function getPos(i: integer): integer;
    procedure CalculateInts;
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure MakeFont; override;
    procedure Resize; override;
    procedure Paint; override;
  published
    property HandlePad: integer read FHandlePad write setHandlePad default 8;
    property HandleSize: String read FHandleSize write setHandleSize;
    property OpaqueResize: boolean read FOpaqueResize write FOpaqueResize default true;
    property Orient;
    property ProxyBackground: TColor read FProxyBackground write FProxyBackground default clBlack;
    property ProxyBorderwidth: String read FProxyBorderwidth write FProxyBorderwidth;
    property ProxyRelief: TRelief read FProxyRelief write FProxyRelief default _TR_flat;
    property SashCursor: TCursor read FSashCursor write FSashCursor;
    property SashPad: String read FSashPad write setSashPad;
    property SashRelief: TRelief read FSashRelief write setSashRelief default _TR_flat;
    property SashWidth: String read FSashWidth write setSashWidth;
    property ShowHandle: boolean read FShowHandle write setShowHandle default false;
  end;

  TKRadiobuttonGroup = class (TKMiscBaseWidget)
  private
    FColumns: integer;
    FLabel: string;
    FItems: TStrings;
    FOldItems: TStrings;
    FCheckboxes: boolean;
    procedure setColumns(Value: integer);
    procedure setLabel(Value: string);
    procedure setItems(Value: TStrings);
    procedure setCheckboxes(Value: boolean);
    procedure ChangeCommand(Value: string);
    procedure MakeButtongroupItems;
    procedure MakeLabel(aLabel: string);
    function ItemsInColumn(i: integer): integer;
    function RBName(i: integer): String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure DeleteWidget; override;
    procedure MakeCommand(Attr, Value: String); override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  published
    property Items: TStrings read fItems write setItems; // must stay before columns or label
    property Columns: integer read FColumns write setColumns;
    property Command;
    property Font;
    property Label_: string read FLabel write setLabel;
    property Checkboxes: boolean read FCheckboxes write setCheckboxes;
  end;

implementation

uses Math, SysUtils, JvGnugettext,
     frmPyIDEMain, UUtils, UConfiguration, ULink;

{--- TButtonBaseWidget --------------------------------------------------------}

constructor TKMiscBaseWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Width:= 120;
  Height:= 80;
  BorderWidth:= '1';
  FContainer:= false;
  FOrient:= vertical;
  FRepeatDelay:= 300;
  FRepeatInterval:= 100;
  FTroughColor:= clScrollbar;
end;

function TKMiscBaseWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '';
  if ShowAttributes = 3 then
    Result:= Result + '|Foreground';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TKMiscBaseWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

procedure TKMiscBaseWidget.setOrient(Value: TOrient);
  var h: integer;
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

{--- TKFrame ------------------------------------------------------------------}

constructor TKFrame.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 13;
  ControlStyle := [csAcceptsControls];
  BorderWidth:= '0';
  HighlightThickness:= '0';
  PadX:= '0';
  PadY:= '0';
  Text:= '';
end;

procedure TKFrame.NewWidget(Widget: String = '');
begin
  if Widget = ''
    then inherited NewWidget('tk.Frame')
    else inherited NewWidget(Widget);
end;

function TKFrame.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '';
  if ShowAttributes >= 3 then
    Result:= Result + '|HighlightBackground|HighlightColor|HighlightThickness';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKFrame.MakeFont;
begin
  // no font
end;

{--- TKLabelframe ------------------------------------------------------------------}

constructor TKLabelframe.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 14;
  BorderWidth:= '2';
  HighlightThickness:= '0';
  FLabelAnchor:= _TL_nw;
  PadX:= '0';
  PadY:= '0';
  Relief:= _TR_solid;
  Text:= '';
end;

procedure TKLabelframe.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.LabelFrame');
end;

function TKLabelframe.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|LabelAnchor|Text';
  if ShowAttributes >= 2 then
    Result:= Result + '';
  if ShowAttributes >= 3 then
    Result:= Result + '|LabelWidget';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKLabelframe.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'LabelWidget' then
    inherited setAttribute(Attr, Value, 'Source')
  else
    inherited;
end;

procedure TKLabelframe.setLabelAnchor(Value: TLabelAnchor);
begin
  if FLabelAnchor <> Value then begin
    FLabelAnchor:= Value;
    Invalidate;
  end;
end;

procedure TKLabelframe.Paint;
  var tw, th, ts, tr, bd, h, w, x, y: integer; R: TRect;
begin
  inherited;
  R:= ClientRect;
  Canvas.FillRect(R);   // remove border
  tw:= Canvas.TextWidth(Text);
  th:= Canvas.TextHeight('Hg');
  ts:= max((th - BorderWidthInt) div 2, 0);
  tr:= max((tw - BorderWidthInt) div 2, 0);
  case FLabelAnchor of
    _TL_nw, _TL_n, _TL_ne: R.Top   := R.Top + ts;
    _TL_en, _TL_e, _TL_es: R.Right := R.Right - tr;
    _TL_se, _TL_s, _TL_sw: R.Bottom:= R.Bottom - ts;
    _TL_ws, _TL_w, _TL_wn: R.Left  := R.Left + tr;
  end;
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
  Canvas.TextOut(x, y, Text);
end;

{--- TKMessage ----------------------------------------------------------------}

constructor TKMessage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 10;
  FAnchor:= _TA_center;
  FAspect:= 150;
  HighlightThickness:= '0';
  FJustify:= _TJ_left;
end;

procedure TKMessage.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Text' then
    setValue(Name + 'CV', asString(Value))
  else
    inherited;
end;

function TKMessage.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Justify|Text';
  if ShowAttributes >= 2 then
    Result:= Result + '|Anchor|Aspect';
  if ShowAttributes = 3 then
    Result:= Result + '|HighlightBackground|HighlightColor|HighlightThickness';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKMessage.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Message');
  MakeControlVar('textvariable', Name + 'CV', Text);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKMessage.setJustify(Value: TJustify);
begin
  if FJustify <> Value then begin
    FJustify:= Value;
    Invalidate;
  end;
end;

procedure TKMessage.setAnchor(Value: TAnchor);
begin
  if FAnchor <> Value then begin
    FAnchor:= Value;
    Invalidate;
  end;
end;

procedure TKMessage.setAspect(Value: integer);
begin
  if FAspect <> Value then begin
    FAspect:= Value;
    Invalidate;
  end;
end;

procedure TKMessage.Paint;
  var tw, th, h, w, x, y, taw, tah: integer;
      s: String; R: TRect; jus: Integer;
      SL: TStringList;

  procedure split(const s: string; var s1, s2: string);
    var len, n, p: integer;
  begin
    len:= Canvas.TextWidth('abcdefghijklmnopqrstuvwxyz');
    n:= round(taw / (len / 26.0)) + 1;

    p:= n;
    // wrap = word
    while (p > 0) and (s[p] <> ' ') do
      dec(p);

    if p > 0 then begin
      s1:= copy(s, 1, p-1);
      s2:= copy(s, p+1, length(s));
    end else begin
      p:= n;
      while (p < Length(s)) and (s[p] <> ' ') do
        inc(p);
      if p = Length(s) then begin
        s1:= s;
        s2:= '';
      end else begin
        s1:= copy(s, 1, p-1);
        s2:= copy(s, p+1, length(s));
      end;
    end;
  end;

  procedure makeSL;
    var s, s1, s2: string;
  begin
    SL.Clear;
    s:= Text; s1:= ''; s2:= '';
    while Canvas.TextWidth(s) > taw do begin
      split(s, s1, s2);
      SL.Add(s1);
      s:= s2;
    end;
    if s <> '' then
      SL.Add(s);
  end;

begin
  inherited;

  R:= Rect(BorderWidthInt, BorderWidthInt, Width - BorderWidthInt, Height - BorderWidthInt);
  Canvas.Brush.Color:= Background;
  Canvas.FillRect(R);

  tw:= Canvas.TextWidth(Text);
  th:= Canvas.TextHeight('Hg');
  // tw*th is area of linear text
  // taw*tah is same area in a rectangle with x:y = Aspect/100
  taw:= round(sqrt(tw*th*FAspect/100.0));
  // tah:= round(taw/(FAspect/100.0));

  SL:= TStringList.Create;
  makeSL;
  s:= SL.Text;
  while copy(s, length(s) - 1, 2) = #13#10 do
    delete(s, length(s) - 1, 2);

  R:= Rect(0, 0, 0, 0);
  DrawText(Canvas.Handle, PChar(s), Length(S), R, DT_CALCRECT);
  taw:= R.Width;
  tah:= R.Height;

  h:= Height;
  w:= Width;
  case FAnchor of
    _TA_nw: begin x:= 6; y:= 1; end;
    _TA_n : begin x:= (w - taw) div 2; y:= 1 end;
    _TA_ne: begin x:= w - 5 - taw; y:= 1; end;
    _TA_e:  begin x:= w - 1 - taw; y:= (h - tah) div 2; end;
    _TA_se: begin x:= w - 5 - taw; y:= h - 1 - tah; end;
    _TA_s:  begin x:= (w - taw) div 2; y:= h - 1 - tah; end;
    _TA_sw: begin x:= 6; y:= h - 1 - tah; end;
    _TA_w:  begin x:= 1; y:= (h - tah) div 2; end;
    else    begin x:= (w - taw) div 2; y:= (h -tah) div 2; end; // center
  end;
  case FJustify of
    _TJ_left:   jus:= DT_LEFT;
    _TJ_center: jus:= DT_CENTER;
    else        jus:= DT_RIGHT;
  end;
  R:= Rect(x, y, taw, tah);
  DrawText(Canvas.Handle, PChar(s), Length(S), R, DT_CALCRECT);
  DrawText(Canvas.Handle, PChar(s), Length(s), R, jus);
  FreeAndNil(SL);
end;

{--- TKScale ------------------------------------------------------------------}

constructor TKScale.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 15;
  Width:= 80;
  Height:= 120;
  FBigIncrement:= 0;
  FDigits:= 0;
  HighlightThickness:= '2';
  FLength:= 100;
  FResolution:= 1;
  FShowValue:= true;
  FSliderLength:= 30;
  FSliderRelief:= _TR_raised;
  FState:= normal;
  FTo:= 100;
  FTrackSize := 15;
end;

function TKScale.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|From|To_|Label_|Orient|Resolution|TickInterval|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|BigIncrement|Command|Digits|SliderLength|SliderRelief|ShowValue';
  if ShowAttributes = 3 then
    Result:= Result + '|ActiveBackground|HighlightBackground|HighlightColor' +
                      '|HighlightThicknessLength|State|RepeatDelay|RepeatInterval|TroughColor';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKScale.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else
    inherited;
end;

procedure TKScale.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Scale');
  MakeControlVar('variable', Name + 'CV', IntToStr(round(FValue)), 'Int');
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKScale.MakeCommand(Attr, Value: String);
begin
  inherited;
  AddParameter(Value, 'x');
end;

procedure TKScale.Paint;
begin
  inherited;
  UpdateTrackData;
  UpdateTrack;
  UpdateTicks;
  UpdateSlider;
  UpdateLabel;
end;

procedure TKScale.UpdateTrackData;
  var s1, s2: String;
begin
  if FResolution <> 0 then
    if FResolution >= 1
      then FDecimals:= 0
      else FDecimals:= Round(ln(1/FResolution)/ln(10));

  if FOrient = horizontal then begin
    FTickSpace:= Canvas.TextHeight('0') + 4;
    FUsablePixels := Width - 4*BorderWidthInt - FSliderLength;
    FTrackRect.Left := 2*BorderWidthInt;
    FTrackRect.Right := Width - 2*BorderWidthInt;
    FTrackRect.Top := 2*BorderWidthInt;
    if FLabel <> '' then
      FTrackRect.Top := FTrackRect.Top + FTickSpace;
    if FShowValue then
      FTrackRect.Top := FTrackRect.Top + FTickSpace;
    FTrackRect.Bottom := FTrackRect.Top + FTrackSize;
  end else begin
    s1:= FloatToStrF(FFrom, ffFixed, 8, FDecimals);
    s2:= FloatToStrF(FTo, ffFixed, 8, FDecimals);
    FTickSpace:= max(Canvas.TextWidth(s1), Canvas.TextWidth(s2)) + 4;
    FUsablePixels := Height - 4*BorderWidthInt - FSliderLength;
    FTrackRect.Top := 2*BorderWidthInt;
    FTrackRect.Bottom := Height - 2*BorderWidthInt -1;
    FTrackRect.Left := 2*BorderWidthInt;
    if FShowValue then
      FTrackRect.Left := FTrackRect.Left + FTickSpace;
    if FTickinterval > 0 then
      FTrackRect.Left := FTrackRect.Left + FTickSpace;
    FTrackRect.Right := FTrackRect.Left + FTrackSize;
  end;
end;

procedure TKScale.UpdateTrack;
  var R: TRect;
begin
  R:= FTrackRect;
  R.Inflate(BorderWidthInt, BorderWidthInt);
  PaintBorder(R, _TR_sunken, BorderWidthInt);
  Canvas.Brush.Color := FTroughColor;
  Canvas.FillRect(FTrackRect);
end;

procedure TKScale.UpdateTicks;
  var X, Y, Xnew, XOld, YNew, YOld, th, tw, FromPos: integer;
      XVal, YVal: real; s: string;
begin
  Canvas.Pen.Color := Foreground;
  Canvas.Brush.Color:= Background;
  Canvas.Font.Color:= clBlack;
  FromPos:= 2*BorderWidthInt + FSliderLength div 2;
  th:= Canvas.TextHeight('0');
  tw:= 0;
  XOld:= 0;
  YOld:= 0;

  if FTickInterval > 0 then
    if FOrient = horizontal then begin
      XVal:= FFrom;
      while XVal <= FTo do begin
        XNew:= round(FUsablePixels*(XVal-FFrom) / (FTo-FFrom)) + FromPos;
        if XNew - XOld < tw - 1 then begin
          XVal:= XVal + FTickInterval;
          continue;
        end;
        s:= FloatToStrF(XVal, ffFixed, 8, FDecimals);
        tw:= Canvas.TextWidth(s);
        y:= FTrackRect.Bottom + BorderWidthInt + 4;
        Canvas.TextOut(XNew - tw div 2, Y, s);
        XOld:= XNew;
        XVal:= XVal + FTickInterval;
      end;
    end else begin
      YVal:= FFrom;
      while YVal <= FTo do begin
        Ynew := round(FUsablePixels*(YVal - FFrom) / (FTo-FFrom)) + FromPos;
        if YNew - YOld < th - 1 then begin
          YVal:= YVal + FTickInterval;
          continue;
        end;
        s:= FloatToStrF(YVal, ffFixed, 8, FDecimals);
        tw:= Canvas.TextWidth(s);
        X := BorderWidthInt + FTickSpace - tw - 2;
        Canvas.TextOut(X, YNew - th div 2, s);
        YOld:= YNew;
        YVal:= YVal + FTickInterval;
      end;
    end;
end;

procedure TKScale.UpdateSlider;
  var X, Y, V, tw, th: integer; s: string;
      FSliderRect: TRect; val: real;
begin
  // reduce Value to next resolution value
  val:= FValue;
  if FResolution > 0 then
    val:= round(FValue/FResolution)*FResolution;
  V:= Round(FUsablePixels * (val - FFrom) / (FTo - FFrom)) + 2*BorderWidthInt;
  if FOrient = horizontal then begin
    X := V;
    Y := FTrackRect.Top;
    FSliderRect:= Rect(X, Y, X + FSliderLength, Y + FTrackSize)
  end else begin
    X := FTrackRect.Left;
    Y := V;
    FSliderRect:= Rect(X, Y, X + FTrackSize, Y + FSliderLength)
  end;
  Canvas.Pen.Color:= clBlack;
  Canvas.Brush.Color:= Background;
  Canvas.Rectangle(FSliderRect);
  if FOrient = horizontal then begin
    x:= (FSliderRect.Left + FSliderRect.Right) div 2;
    Canvas.MoveTo(x, FSliderRect.Top);
    Canvas.LineTo(x, FSliderRect.Bottom);
  end else begin
    y:= (FSliderRect.Top + FSliderRect.Bottom) div 2;
    Canvas.MoveTo(FSliderRect.Left, y);
    Canvas.LineTo(FSliderRect.Right, y);
  end;

  if FShowValue then begin
    s:= FloatToStrF(val, ffFixed, 8, FDecimals);
    tw:= Canvas.TextWidth(s);
    th:= Canvas.TextHeight(s);
    if FOrient = horizontal then begin
      X:= V + FTrackSize - tw div 2;
      Y:= BorderWidthInt + FTickSpace - th - 2;
      if FLabel <> '' then
        Y:= Y + FTickSpace;
    end else begin
      X:= BorderWidthInt + FTickSpace - tw - 2;
      if FTickInterval > 0 then
        inc(X, FTickSpace);
      Y:= V + FSliderLength div 2 - th div 2;
    end;
    Canvas.TextOut(X, Y, s);
  end;
end;

procedure TKScale.UpdateLabel;
  var R: TRect;
begin
  if FLabel <> '' then begin
    if FOrient = horizontal then
      R:= Rect(BorderWidthInt + 6, BorderWidthInt + 3,
               Width-BorderWidthInt, BorderWidthInt + 6 + FTickSpace)
    else
      R:= Rect(FTrackRect.Right + BorderWidthInt + 6, BorderWidthInt + 6,
               Width-BorderWidthInt, FTrackRect.Height-BorderWidthInt);
    DrawText(Canvas.handle, PChar(FLabel), System.Length(FLabel), R, DT_Left);
  end;
end;

procedure TKScale.setFrom(Value: real);
begin
  if FFrom <> Value then begin
    FFrom := Value;
    invalidate;
  end;
end;

procedure TKScale.setTo(Value: real);
begin
  if FTo <> Value then begin
    FTo := Value;
    invalidate;
  end;
end;

procedure TKScale.setLabel(Value: String);
begin
  if FLabel <> Value then begin
    FLabel := Value;
    invalidate;
  end;
end;

procedure TKScale.setResolution(Value: real);
begin
  if FResolution <> Value then begin
    FResolution := Value;
    invalidate;
  end;
end;

procedure TKScale.setShowValue(Value: boolean);
begin
  if FShowValue <> Value then begin
    FShowValue := Value;
    invalidate;
  end;
end;

procedure TKScale.setSliderLength(Value: integer);
begin
  if FSliderLength <> Value then begin
    FSliderLength := Value;
    invalidate;
  end;
end;

procedure TKScale.setTickInterval(Value: real);
begin
  if FTickInterval <> Value then begin
    FTickInterval := Value;
    invalidate;
  end;
end;

procedure TKScale.setRValue(Value: Real);
begin
  if Value <> FValue then begin
    FValue := Value;
    if FValue > FTo then FValue := FTo
    else if FValue < FFrom then FValue := FFrom;
    if csDesigning in ComponentState
      then Invalidate
      else UpdateSlider;
  end;
end;

{--- TKScrollbar --------------------------------------------------------------}

constructor TKScrollbar.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 12;
  Width:= 16;
  Height:= 160;
  FActiveRelief:= _TR_raised;
  FElementBorderWidth:= -1;
  HighlightThickness:= '0';
  FJump:= false;
  BorderWidth:= '0';
  Relief:= _TR_sunken;
end;

function TKScrollbar.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Orient';
  if ShowAttributes >= 2 then
    Result:= Result + '|Jump';
  if ShowAttributes = 3 then
    Result:= Result + '|ActiveRelief|ElementBorderWidth|ActiveBackground|HighlightBackground' +
                      '|HighlightColor|HighlightThickness|RepeatDelay|RepeatInterval|TroughColor';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKScrollbar.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Scrollbar');
end;

procedure TKScrollbar.MakeFont;
begin
  // no font
end;

procedure TKScrollbar.Paint;
begin
  PaintScrollbar(ClientRect, FOrient = horizontal);
end;

{--- TKPopupMenu --------------------------------------------------------------}

constructor TKPopupMenu.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 20;
  Width:= 31;
  Height:= 27;
  ActiveBackground:= clHighlight;
  FActiveBorderWidth:= 1;
  FActiveForeground:= clHighlightText;
  FDisabledForeground:= clGrayText;
  FSelectColor:= clMenuText;
  FType:= _TT_normal;
  Background:= clMenu;
  Foreground:= clMenuText;
  FMenuItems:= TStringList.Create;     // new menu items from user
  FMenuItems.text:= 'File'#13#10'  New'#13#10'    Python'#13#10'    XML'#13#10'  Load'#13#10'  Save'#13#10 +
                    'Edit'#13#10'  Copy'#13#10'  Paste'#13#10'  -'#13#10'  Delete'#13#10;
  MenuItemsOld:= TStringList.Create;   // old menu items from user
end;

destructor TKPopupMenu.Destroy;
begin
  FreeAndNil(FMenuItems);
  FreeAndNil(MenuItemsOld);
  inherited;
end;

function TKPopupMenu.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|MenuItems|Name';
  if ShowAttributes >= 2 then
    Result:= Result + '|PostCommand';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKPopupMenu.NewWidget(Widget: String = '');
begin
  InsertValue(Indent2 + 'self.' + Name + ' = tk.Menu(tearoff=0)');
  MenuItemsOld.Text:= '';
  MakeMenuItems;
end;

function TKPopupMenu.MakeMenubar: string;
begin
  Result:= '';
end;

procedure TKPopupMenu.SetPositionAndSize;
begin
  // do nothing
end;

procedure TKPopupMenu.setItems(aItems: TStrings);
begin
  MenuItemsOld.Text:= FMenuItems.Text;
  if aItems.Text <> FMenuItems.Text then
    FMenuItems.Assign(aItems);
end;

procedure TKPopupMenu.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited
end;

function TKPopupMenu.getEvents(ShowEvents: integer): string;
begin
  Result:= '';
end;

function TKPopupMenu.hasSubMenu(MenuItems: TStrings; i: integer): boolean;
begin
  Result:= (i < MenuItems.count - 1) and
           (LeftSpaces(MenuItems[i], 2) < LeftSpaces(MenuItems[i+1], 2));
end;

function TKPopupMenu.makeMenuName(m, s: string): string;
begin
  if Right(m, -4) = 'Menu' then
    m:= copy(m, 1, Length(m) - 4);
  Result:= m + OnlyCharsAndDigits(s) + 'Menu';
end;

procedure TKPopupMenu.CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings);
  var i, MenuIndent, ls: integer;
      s, ts: string;
      MenuName: array[-1..10] of String;
      MenuText: array[-1..10] of String;

  procedure MakeCommand(Indent: integer);
    var Com: string;
  begin
    if ts = '-' then
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent-1] + '.add_separator()')
    else begin
      Com:= MenuName[Indent-1];
      Com:= copy(Com, 1, length(Com) - 4) + OnlyCharsAndDigits(ts) + '_Command';
      PyMethods.Add(Com + '(self):');
      PyMenu.Add(Indent2 + 'self.' + MenuName[Indent-1] +
                 '.add_command(label=''' + ts + ''', command=self.' + Com + ')');
    end;
  end;

begin
  MenuName[-1]:= Name;
  MenuText[-1]:= '';
  MenuIndent:= 0;
  // insert new MenuItems
  i:= 0;
  while i < MenuItems.Count do begin
    s:= MenuItems[i];
    ts:= trim(s);
    ls:= LeftSpaces(s, 2) div 2;
    if ls < MenuIndent then begin  // close all open menus
      while MenuIndent > ls do begin
        PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent-2] + '.add_cascade(label=''' +
                   MenuText[MenuIndent-1] + ''', menu=self.' + MenuName[MenuIndent-1] + ')');
        dec(MenuIndent);
      end;
      dec(i);
    end else if ls > MenuIndent then begin
      MakeCommand(MenuIndent);
      inc(MenuIndent);
    end else if (ls = 0) or hasSubMenu(MenuItems, i) then begin  // create new menu/submenu
      MenuText[MenuIndent]:= ts;
      MenuName[MenuIndent]:= makeMenuName(MenuName[MenuIndent-1], s);
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent] + ' = tk.Menu(self.' + Name + ', tearoff=0)');
      inc(MenuIndent);
    end else
      MakeCommand(MenuIndent);
    inc(i);
  end;
  while MenuIndent > 0 do begin
    PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent-2] + '.add_cascade(label=''' +
               MenuText[MenuIndent-1] + ''', menu=self.' + MenuName[MenuIndent-1] + ')');
    dec(MenuIndent);
  end;
end;

procedure TKPopupMenu.MakeMenuItems;
  var i: integer;
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
  Partner.DeleteLine(MakeMenubar);
  if NewMenu.Text <> '' then
    Partner.InsertValue(Name, NewMenu.Text + MakeMenubar, 1);

  FreeAndNil(OldMenu);
  FreeandNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKPopupMenu.Rename(const OldName, NewName, Events: string);
  var i: integer;
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
  Partner.DeleteLine(MakeMenubar);
  CalculateMenus(MenuItemsOld, OldMenu, OldMethods);
  Name:= NewName;
  CalculateMenus(FMenuItems, NewMenu, NewMethods);
  Partner.DeleteOldAddNewMethods(OldMethods, NewMethods);
  for i:= 0 to OldMenu.Count - 1 do
    Partner.DeleteLine(OldMenu[i]);
  Partner.ReplaceWord(OldName, NewName, true);
  if NewMenu.Text <> '' then
    Partner.InsertValue(Name, NewMenu.Text + MakeMenubar, 1);

  FreeAndNil(OldMenu);
  FreeandNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKPopupMenu.DeleteWidget;
begin
  inherited;
  MenuItemsOld.Text:= FMenuItems.Text;
  FMenuItems.Clear;
  MakeMenuItems;
  if FPostCommand then Partner.DeleteMethod(Name + '_PostCommand');
end;

procedure TKPopupMenu.Paint;
begin
  inherited;
  Canvas.Rectangle(Rect(0, 0, Width, Height));
  DrawBitmap(7, 4, 16, Canvas, PyIDEMainForm.ILTkinter);
end;

{--- TKMenu -------------------------------------------------------------------}

constructor TKMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 19;
  Width:= 100;
  Height:= 19;
end;

function TKMenu.MakeMenubar: string;
begin
  Result:= Indent2 + 'self.root[''menu''] = self.' + Name;
end;

procedure TKMenu.DeleteWidget;
begin
  inherited;
  Partner.DeleteAttribute('self.root[''menu'']');
end;

procedure TKMenu.Paint;
  var s, item: String; i: integer;
begin
  setBounds(0, 0, Parent.ClientWidth, PPIScale(19));
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

{--- PanedWindow --------------------------------------------------------------}

constructor TKPanedWindow.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 16;
  Width:= 80;
  Height:= 120;
  ControlStyle := [csAcceptsControls];
  FHandlePad:= 8;
  FHandleSize:= '8';
  FOpaqueResize:= true;
  FOrient:= horizontal;
  FProxyBorderWidth:= '2';
  FProxyRelief:= _TR_flat;
  FSashRelief:= _TR_flat;
  FSashWidth:= '3';
  FShowHandle:= false;
end;

procedure TKPanedWindow.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.PanedWindow');
  SashRelief:= _TR_groove;
  setAttribute('sashrelief', 'groove', 'TRelief');
end;

function TKPanedWindow.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|HandlePad|HandleSize|OpaqueResize|Orient|SashCursor|SashPad|SashRelief|SashWidth|ShowHandle';
  if ShowAttributes >= 2 then
    Result:= Result + '|ProxyBackground|ProxyBorderwidth|ProxyRelief';
  if ShowAttributes >= 3 then
    Result:= Result + '';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKPanedWindow.MakeFont;
begin
  // no font
end;

procedure TKPanedWindow.setHandlePad(Value: integer);
begin
  if FHandlePad <> Value then begin
    FHandlePad := Value;
    invalidate;
  end;
end;

procedure TKPanedWindow.setHandleSize(Value: String);
begin
  if FHandleSize <> Value then begin
    FHandleSize := Value;
    Resize;
    invalidate;
  end;
end;

procedure TKPanedWindow.setSashPad(Value: String);
begin
  if FSashPad <> Value then begin
    FSashPad := Value;
    Resize;
    invalidate;
  end;
end;

procedure TKPanedWindow.setSashRelief(Value: TRelief);
begin
  if FSashRelief <> Value then begin
    FSashRelief := Value;
    invalidate;
  end;
end;

procedure TKPanedWindow.setSashWidth(Value: String);
begin
  if FSashWidth <> Value then begin
    FSashWidth := Value;
    Resize;
    invalidate;
  end;
end;

procedure TKPanedWindow.setShowHandle(Value: boolean);
begin
  if FShowHandle <> Value then begin
    FShowHandle := Value;
    invalidate;
  end;
end;

procedure TKPanedWindow.PaintSlashAt(Pos: integer);
  var R: TRect; w: integer;
begin
  w:= max(HandleSizeInt, SashWidthInt) div 2 + SashPadInt;
  if FOrient = horizontal then begin
    R:= Rect(Pos - w, BorderWidthInt, Pos + w, Height - BorderWidthInt);
    Canvas.Brush.Color:= Background;
    Canvas.FillRect(R);
    R:= Rect(Pos - SashWidthInt div 2, BorderWidthInt,
             Pos + SashWidthInt div 2, Height - BorderWidthInt);
    PaintBorder(R, SashRelief, 1);
    R:= Rect(Pos - HandleSizeInt div 2, BorderWidthInt + HandlePad,
             Pos + HandleSizeInt div 2, BorderWidthInt + HandlePad + HandleSizeInt);
    PaintBorder(R, SashRelief, 1);
  end else begin
    R:= Rect(BorderWidthInt, Pos - w, Width - BorderWidthInt, Pos + w);
    Canvas.Brush.Color:= Background;
    Canvas.FillRect(R);
    R:= Rect(BorderWidthInt, Pos - SashWidthInt div 2,
             Width - BorderWidthInt, Pos + SashWidthInt div 2);
    PaintBorder(R, SashRelief, 1);
    R:= Rect(BorderWidthInt + HandlePad, Pos - HandleSizeInt div 2,
             BorderWidthInt + HandlePad + HandleSizeInt, Pos + HandleSizeInt div 2);
    PaintBorder(R, SashRelief, 1);
  end;
end;

procedure TKPanedWindow.CalculateInts;
begin
  if not TryStrToInt(FSashPad, SashPadInt) then SashPadInt:= 0;
  if not TryStrToInt(FSashWidth, SashWidthInt) then SashWidtHint:= 3;
  if not TryStrToInt(FHandleSize, HandleSizeInt) then HandleSizeInt:= 8;
end;

function TKPanedWindow.getPos(i: integer): integer;
  var SashW: integer; ControlW: real;
begin
  SashW:= max(HandleSizeInt, SashWidthInt) + 2*SashPadInt;
  if ControlCount > 0 then
    if FOrient = horizontal
       then ControlW:= (Width  - 2*BorderWidthInt - (ControlCount - 1)* SashW)/(ControlCount*1.0)
       else ControlW:= (Height - 2*BorderWidthInt - (ControlCount - 1)* SashW)/(ControlCount*1.0)
  else
    ControlW:= 0;
  Result:= Round(BorderWidthInt + i*ControlW + (i-1)*SashW + SashW div 2);
end;

procedure TKPanedWindow.Paint;
  var R: TRect; i: integer;
begin
  inherited;
  CalculateInts;
  R:= Rect(BorderWidthInt, BorderWidthInt, Width - BorderWidthInt, Height - BorderWidthInt);
  Canvas.Brush.Color:= Background;
  Canvas.FillRect(R);
  if ControlCount > 1 then
    for i:= 1 to ControlCount - 1 do
      PaintSlashAt(getPos(i))
  else
    PaintSlashAt(getPos(1)); // to show a slider in the gui form
end;

procedure TKPanedWindow.Resize;
  var i, w, cw, ch: integer;
begin
  CalculateInts;
  w:= max(HandleSizeInt, SashWidthInt) div 2 + SashPadInt;
  if Orient = horizontal then begin
    ch:= Height - 2*BorderWidthInt;
    if ControlCount > 1 then begin
      cw:= getPos(1) - w - BorderWidthInt;
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, cw, ch);
      for i:= 1 to ControlCount - 1 do
        Controls[i].SetBounds(getPos(i) + w, BorderWidthInt, cw, ch);
      Controls[ControlCount-1].SetBounds(getPos(ControlCount-1) + w, BorderWidthInt, cw, ch);
    end else if ControlCount = 1 then
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, Width - 2*BorderWidthInt, ch);
  end else begin
    cw:= Width - 2*BorderWidthInt;
    if ControlCount > 1 then begin
      ch:= getPos(1) - w - BorderWidthInt;
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, cw, ch);
      for i:= 1 to ControlCount - 1 do
        Controls[i].SetBounds(BorderWidthInt, getPos(i) + w, cw, ch);
      Controls[ControlCount-1].SetBounds(BorderWidthInt, getPos(ControlCount-1) + w, cw, ch);
    end else if ControlCount = 1 then
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, cw, Height - 2*BorderWidthInt);
  end;
end;

{--- TKRadiobuttonGroup -------------------------------------------------------}

constructor TKRadiobuttonGroup.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 7;
  Width:= 80;
  Height:= 80;
  FColumns:= 1;
  FItems:= TStringList.Create;
  FOldItems:= TStringList.Create;
  FLabel:= ' ' + _('Continent') + ' ';
end;

destructor TKRadiobuttonGroup.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TKRadiobuttonGroup.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Background|Columns|Command|Items|Font|Label_|Name|Checkboxes';
  if ShowAttributes = 3 then
    Result:= Result + '|Height|Width|Left|Top';
end;

procedure TKRadiobuttonGroup.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Command' then
    ChangeCommand(Value)
  else if (Attr = 'Items') or (Attr = 'Checkboxes') then
    MakeButtonGroupItems
  else if Attr = 'Columns' then
    SetPositionAndSize
  else if Attr = 'Label_' then
    MakeLabel(Value)
  else if Attr = 'Background' then begin
    inherited;
    MakeButtongroupItems;
  end else if isFontAttribute(Attr) then begin
    if Label_ <> '' then inherited;
    MakeButtongroupItems;
  end else
    inherited;
end;

function TKRadiobuttonGroup.RBName(i: integer): String;
begin
  Result:= 'self.' + Name + 'RB' + IntToStr(i);
end;

procedure TKRadiobuttonGroup.MakeButtongroupItems;
  var Options, CommonOptions, s: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  for var i := 0 to FOldItems.Count - 1 do begin
    Partner.DeleteAttributeValues(RBName(i));
    Partner.DeleteAttributeValues(RBName(i) + 'CV');
  end;
  Partner.DeleteAttributeValues('self.' + Name + '[''variable'']');

  CommonOptions:= 'self.' + Name + ', ';
  if Background <> clBtnFace then
    CommonOptions:= CommonOptions + 'background=''' + TColorToString(Background) + ''', ';
  if (Font.Name <> 'Segoe UI') or (Font.Size <> 9) then
    CommonOptions:= CommonOptions + 'font = (' + asString(Font.Name) + ', ' + IntToStr(Font.Size) + '), ';
  CommonOptions:= CommonOptions + 'anchor=''w'', ';
  s:= '';
  for var i:= 0 to FItems.Count - 1 do begin
    if FCheckboxes then begin
      Options:= CommonOptions + 'text=' + asString(FItems[i]);
      s:= s + surround(RBName(i) + ' = tk.Checkbutton(' + Options + ')') +
          surround(RBName(i) + '.place(x=0, y=0, width=0, height=0)') +
          surround(RBName(i) + 'CV = tk.IntVar()') +
          surround(RBName(i) + '[''variable''] = ' + RBName(i) + 'CV') +
          surround(RBName(i) + 'CV.set(0)');
    end else begin
      Options:= CommonOptions + 'text=' + asString(FItems[i]) + ', value=' + asString(FItems[i]);
      s:= s + surround( RBName(i) + ' = tk.Radiobutton(' + Options + ')') +
          surround(RBName(i) + '.place(x=0, y=0, width=0, height=0)') +
          surround(RBName(i) + '[''variable''] = self.' + Name + 'CV');
    end;
  end;
  insertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
  FOldItems.Text:= FItems.Text;
  setPositionAndSize;
end;

procedure TKRadiobuttonGroup.SetPositionAndSize;
  var col, row, ItemsInCol, line, x, y, th: integer;
      RadioHeight, RadioWidth, ColWidth, RowHeight, ColWidthRest, RowHeightRest: integer;
      xold, yold,ColWidthI, RowHeightI: integer;
      key: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited;

  th:= Canvas.TextHeight('Hg');
  if FLabel = '' then begin
    RadioWidth:= Width;
    RadioHeight:= Height;
  end else begin
    RadioWidth:= Width - 4;
    RadioHeight:= Height - th - 4;
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
      dec(ColWidthRest);

      yold:= 0;
      ItemsInCol:= ItemsInColumn(col+1);
      RowHeightRest:= RadioHeight mod ItemsInColumn(1);
      for row:= 0 to ItemsInCol - 1 do begin
        if RowHeightRest > 0
          then RowHeightI:= RowHeight + 1
          else RowHeightI:= RowHeight;
        if row = 0
          then y:= 0 // th in Qt
          else y:= yold + RowHeightI;
        dec(RowHeightRest);
        key:= RBName(line) + '.place';
        setAttributValue(key, key + '(x=' + IntToStr(PPIUnScale(x)) + ', y=' + IntToStr(PPIUnScale(y)) +
          ', width=' + IntToStr(PPIUnScale(ColWidthI)) + ', height=' + IntToStr(PPIUnScale(RowHeightI)) + ')');
        inc(line);
        yold:= y;
      end;
      xold:= x;
    end;
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKRadiobuttonGroup.MakeCommand(Attr, Value: String);
  var func, nam, s: string; i: integer;
begin
  Command:= true;
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

procedure TKRadiobuttonGroup.ChangeCommand(Value: string);
  var key: string; i: integer;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  if Value = 'True' then begin
    MakeCommand('Command', Value);
    for i:= 0 to FItems.Count - 1 do begin
      key:= RBName(i) + '[''command'']';
      setAttributValue(key, key + ' = self.' + Name + '_Command');
    end
  end else begin
    Partner.DeleteMethod(Name + '_Command');
    for i:= 0 to FItems.Count - 1 do
      Partner.DeleteAttribute(RBName(i) + '[''command'']');
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKRadiobuttonGroup.MakeLabel(aLabel: string);
begin
  FLabel:= aLabel;
  var key:= 'self.' + Name + ' = ';
  if aLabel = '' then begin
    Partner.ReplaceLine(key, Indent2 + key + 'tk.Frame()');
    Partner.DeleteAttribute('self.' + Name + '[''text'']');
    Partner.DeleteAttribute('self.' + Name + '[''font'']');
  end else begin
    Partner.ReplaceLine(key, Indent2 + key + 'tk.LabelFrame()');
    key:= 'self.' + Name + '[''text'']';
    setAttributValue(key, key + ' = ' + asString(FLabel));
    MakeFont;
  end;
  setPositionAndSize;
end;

procedure TKRadiobuttonGroup.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Frame');
  MakeLabel(' ' + _('Continent') + ' ');
  FItems.Text:= defaultItems;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + asString(FItems[0]) + ')');
  MakeButtongroupItems;
end;

procedure TkRadiobuttonGroup.DeleteWidget;
begin
  for var i := 0 to FItems.Count - 1 do begin
    Partner.DeleteAttributeValues(RBName(i));
    Partner.DeleteAttributeValues(RBName(i) + 'CV');
  end;
  inherited;
end;

procedure TKRadiobuttonGroup.setItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then begin
    FOldItems.Text:= FItems.Text;
    FItems.Text:= Value.Text;
    Invalidate;
  end;
end;

procedure TKRadiobuttonGroup.setColumns(Value: integer);
begin
  if (FColumns <> Value) and (Value > 0) then begin
    FColumns:= Value;
    Invalidate;
  end;
end;

procedure TKRadiobuttonGroup.setLabel(Value: String);
begin
  if FLabel <> Value then begin
    FLabel:= Value;
    Invalidate;
  end;
end;

procedure TKRadiobuttonGroup.setCheckboxes(Value: boolean);
begin
  if FCheckboxes <> Value then begin
    FCheckboxes:= Value;
    Invalidate;
  end;
end;

function TKRadiobuttonGroup.ItemsInColumn(i: integer): integer;
  var quot, rest: integer;
begin
  quot:= FItems.Count div FColumns;
  rest:= FItems.Count mod FColumns;
  if i <= rest
    then Result:= quot + 1
    else Result:= quot;
end;

procedure TKRadiobuttonGroup.Paint;
  const cRadius = 5;
  var ColumnWidth, RowWidth, RadioHeight, LabelHeight,
      col, row, yc, ItemsInCol, line, x, y, th, Radius: integer;
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
        R:= Rect(x + PPIScale(19), yc, col*ColumnWidth, yc + RowWidth);
        s:= FItems[line];
        Canvas.TextRect(R, s);
        inc(line);
      end;
    end;
  end;
end;

end.

