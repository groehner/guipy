{ -------------------------------------------------------------------------------
  Unit:     UTKMiscBase
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  tkinter misc widgets
  ------------------------------------------------------------------------------- }

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
  Windows,
  Classes,
  Controls,
  Graphics,
  UBaseTKWidgets,
  UTKWidgets;

type

  // positioning of text, used in TextWidget
  TLabelAnchor = (_TL_nw, _TL_n, _TL_ne, _TL_en, _TL_e, _TL_es, _TL_se, _TL_s,
    _TL_sw, _TL_ws, _TL_w, _TL_wn);

  TOrient = (horizontal, vertical);

  TButtonState = (active, disabled, normal);

  TType = (_TT_menubar, _TT_normal); // normal is used in TButtonState

  TKMiscBaseWidget = class(TKWidget)
  private
    FClass: string;
    FColormap: string;
    FContainer: Boolean;
    FOrient: TOrient;
    FRepeatDelay: Integer;
    FRepeatInterval: Integer;
    FTroughColor: TColor;
  protected
    procedure SetOrient(Value: TOrient);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;

    property Class_: string read FClass write FClass;
    property Colormap: string read FColormap write FColormap;
    property Container: Boolean read FContainer write FContainer default False;
    property Orient: TOrient read FOrient write SetOrient default vertical;
    property RepeatDelay: Integer read FRepeatDelay write FRepeatDelay
      default 300;
    property RepeatInterval: Integer read FRepeatInterval write FRepeatInterval
      default 100;
    property TroughColor: TColor read FTroughColor write FTroughColor
      default clScrollBar;
  end;

  TKFrame = class(TKMiscBaseWidget)
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure MakeFont; override;
  published
    property Font;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
  end;

  TKLabelframe = class(TKFrame)
  private
    FLabelAnchor: TLabelAnchor;
    FLabelWidget: string;
    procedure SetLabelAnchor(Value: TLabelAnchor);
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    procedure Paint; override;
  published
    property Foreground;
    property LabelAnchor: TLabelAnchor read FLabelAnchor write SetLabelAnchor
      default _TL_nw;
    property LabelWidget: string read FLabelWidget write FLabelWidget;
    property Text;
  end;

  TKMessage = class(TKMiscBaseWidget)
  private
    FAnchor: TAnchor;
    FAspect: Integer;
    FJustify: TJustify;
    procedure SetJustify(Value: TJustify);
    procedure SetAnchor(Value: TAnchor);
    procedure SetAspect(Value: Integer);
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Anchor: TAnchor read FAnchor write SetAnchor default _TA_center;
    property Aspect: Integer read FAspect write SetAspect default 150;
    property Foreground;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Justify: TJustify read FJustify write SetJustify default _TJ_left;
    property Text;
  end;

  TKScale = class(TKMiscBaseWidget)
  private
    FBigIncrement: Integer;
    FDigits: Integer;
    FFrom: Real;
    FLabel: string;
    FLength: Integer;
    FResolution: Real;
    FShowValue: Boolean;
    FSliderLength: Integer;
    FSliderRelief: TRelief;
    FState: TButtonState;
    FTickInterval: Real;
    FTo: Real;
    FValue: Real;
    FTrackRect: TRect;
    FUsablePixels: Integer;
    FTrackSize: Integer;
    FTickSpace: Integer;
    FDecimals: Integer;
    procedure SetFrom(Value: Real);
    procedure SetLabel(Value: string);
    procedure SetResolution(Value: Real);
    procedure SetShowValue(Value: Boolean);
    procedure SetSliderLength(Value: Integer);
    procedure SetTickInterval(Value: Real);
    procedure SetTo(Value: Real);
    procedure SetRValue(Value: Real);
    procedure UpdateTrackData;
    procedure UpdateTrack;
    procedure UpdateTicks;
    procedure UpdateSlider;
    procedure UpdateLabel;
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeCommand(Attr, Value: string); override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property BigIncrement: Integer read FBigIncrement write FBigIncrement
      default 0;
    property Command;
    property Digits: Integer read FDigits write FDigits default 0;
    property Font;
    property Foreground;
    property From: Real read FFrom write SetFrom;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Label_: string read FLabel write SetLabel;
    property Length: Integer read FLength write FLength default 100;
    property Orient;
    property Relief;
    property RepeatDelay;
    property RepeatInterval;
    property Resolution: Real read FResolution write SetResolution;
    property ShowValue: Boolean read FShowValue write SetShowValue default True;
    property SliderLength: Integer read FSliderLength write SetSliderLength
      default 30;
    property SliderRelief: TRelief read FSliderRelief write FSliderRelief
      default _TR_raised;
    property State: TButtonState read FState write FState default normal;
    property TakeFocus;
    property TickInterval: Real read FTickInterval write SetTickInterval;
    property To_: Real read FTo write SetTo;
    property TroughColor;
    property Value: Real read FValue write SetRValue;
  end;

  TKScrollbar = class(TKMiscBaseWidget)
  private
    FActiveRelief: TRelief;
    FElementBorderWidth: Integer;
    FJump: Boolean;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property ActiveRelief: TRelief read FActiveRelief write FActiveRelief
      default _TR_raised;
    property ElementBorderWidth: Integer read FElementBorderWidth
      write FElementBorderWidth default -1;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Jump: Boolean read FJump write FJump default False;
    property Orient;
    property RepeatDelay;
    property RepeatInterval;
    property TroughColor;
  end;

  TKPopupMenu = class(TKMiscBaseWidget)
  private
    FActiveBorderWidth: Integer;
    FActiveForeground: TColor;
    FDisabledForeground: TColor;
    FMenuItems: TStrings;
    FMenuItemsOld: TStrings;
    FPostCommand: Boolean;
    FSelectColor: TColor;
    FType: TType;
    procedure SetItems(Items: TStrings);
    procedure MakeMenuItems;
    function HasSubMenu(MenuItems: TStrings; Num: Integer): Boolean;
    function MakeMenuName(Menu, Str: string): string;
    procedure CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings);
  protected
    function MakeMenubar: string; virtual;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure NewWidget(Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure Rename(const OldName, NewName, Events: string); override;
    procedure SetPositionAndSize; override;
    procedure DeleteWidget; override;
    procedure Paint; override;
    property MenuItemsOld: TStrings read FMenuItemsOld write FMenuItemsOld;
  published
    property ActiveBackground;
    property ActiveBorderWidth: Integer read FActiveBorderWidth
      write FActiveBorderWidth default 1;
    property ActiveForeground: TColor read FActiveForeground
      write FActiveForeground default clHighlight;
    // doesn't work
    property DisabledForeground: TColor read FDisabledForeground
      write FDisabledForeground default clGrayText;
    property Foreground;
    property Font;
    property MenuItems: TStrings read FMenuItems write SetItems;
    property PostCommand: Boolean read FPostCommand write FPostCommand;
    property Relief;
    // doesn't work
    property SelectColor: TColor read FSelectColor write FSelectColor
      default clMenuText;
    property Type_: TType read FType write FType default _TT_normal;
  end;

  TKMenu = class(TKPopupMenu)
  protected
    function MakeMenubar: string; override;
  public
    constructor Create(Owner: TComponent); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  end;

  TKPanedWindow = class(TKMiscBaseWidget)
  private
    FHandlePad: Integer;
    FHandleSize: string;
    FOpaqueResize: Boolean;
    FProxyBackground: TColor;
    FProxyBorderWidth: string;
    FProxyRelief: TRelief;
    FSashCursor: TCursor;
    FSashPad: string;
    FSashRelief: TRelief;
    FSashWidth: string;
    FShowHandle: Boolean;
    FHandleSizeInt: Integer;
    FSashPadInt: Integer;
    FSashWidthInt: Integer;
    procedure SetHandlePad(Value: Integer);
    procedure SetHandleSize(Value: string);
    procedure SetSashPad(Value: string);
    procedure SetSashRelief(Value: TRelief);
    procedure SetSashWidth(Value: string);
    procedure SetShowHandle(Value: Boolean);
    procedure PaintSlashAt(Pos: Integer);
    function GetPos(Num: Integer): Integer;
    procedure CalculateInts;
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure MakeFont; override;
    procedure Resize; override;
    procedure Paint; override;
  published
    property HandlePad: Integer read FHandlePad write SetHandlePad default 8;
    property HandleSize: string read FHandleSize write SetHandleSize;
    property OpaqueResize: Boolean read FOpaqueResize write FOpaqueResize
      default True;
    property Orient;
    property ProxyBackground: TColor read FProxyBackground
      write FProxyBackground default clBlack;
    property ProxyBorderWidth: string read FProxyBorderWidth
      write FProxyBorderWidth;
    property ProxyRelief: TRelief read FProxyRelief write FProxyRelief
      default _TR_flat;
    property SashCursor: TCursor read FSashCursor write FSashCursor;
    property SashPad: string read FSashPad write SetSashPad;
    property SashRelief: TRelief read FSashRelief write SetSashRelief
      default _TR_flat;
    property SashWidth: string read FSashWidth write SetSashWidth;
    property ShowHandle: Boolean read FShowHandle write SetShowHandle
      default False;
  end;

  TKRadiobuttonGroup = class(TKMiscBaseWidget)
  private
    FColumns: Integer;
    FLabel: string;
    FItems: TStrings;
    FOldItems: TStrings;
    FCheckboxes: Boolean;
    procedure SetColumns(Value: Integer);
    procedure SetLabel(Value: string);
    procedure SetItems(Value: TStrings);
    procedure SetCheckboxes(Value: Boolean);
    procedure ChangeCommand(Value: string);
    procedure MakeButtongroupItems;
    procedure MakeLabel(ALabel: string);
    function ItemsInColumn(Num: Integer): Integer;
    function RBName(Num: Integer): string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure MakeCommand(Attr, Value: string); override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  published
    property Items: TStrings read FItems write SetItems;
    // must stay before columns or label
    property Columns: Integer read FColumns write SetColumns;
    property Command;
    property Font;
    property Label_: string read FLabel write SetLabel;
    property Checkboxes: Boolean read FCheckboxes write SetCheckboxes;
  end;

implementation

uses
  Math,
  SysUtils,
  JvGnugettext,
  frmPyIDEMain,
  StringResources,
  UUtils,
  UConfiguration,
  ULink;

{ --- TButtonBaseWidget -------------------------------------------------------- }

constructor TKMiscBaseWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Width := 120;
  Height := 80;
  BorderWidth := '1';
  FContainer := False;
  FOrient := vertical;
  FRepeatDelay := 300;
  FRepeatInterval := 100;
  FTroughColor := clScrollBar;
end;

function TKMiscBaseWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  if ShowAttributes = 3 then
    Result := Result + '|Foreground';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TKMiscBaseWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetMouseEvents(ShowEvents);
end;

procedure TKMiscBaseWidget.SetOrient(Value: TOrient);
var
  Tmp: Integer;
begin
  if FOrient <> Value then
  begin
    FOrient := Value;
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

{ --- TKFrame ------------------------------------------------------------------ }

constructor TKFrame.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 13;
  ControlStyle := [csAcceptsControls];
  BorderWidth := '0';
  HighlightThickness := '0';
  PadX := '0';
  PadY := '0';
  Text := '';
end;

procedure TKFrame.NewWidget(Widget: string = '');
begin
  if Widget = '' then
    inherited NewWidget('tk.Frame')
  else
    inherited NewWidget(Widget);
end;

function TKFrame.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  if ShowAttributes >= 3 then
    Result := Result + '|HighlightBackground|HighlightColor|HighlightThickness';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKFrame.MakeFont;
begin
  // no font
end;

{ --- TKLabelframe ------------------------------------------------------------------ }

constructor TKLabelframe.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 14;
  BorderWidth := '2';
  HighlightThickness := '0';
  FLabelAnchor := _TL_nw;
  PadX := '0';
  PadY := '0';
  Relief := _TR_solid;
  Text := '';
end;

procedure TKLabelframe.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.LabelFrame');
end;

function TKLabelframe.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|LabelAnchor|Text';
  if ShowAttributes >= 2 then
    Result := Result + '';
  if ShowAttributes >= 3 then
    Result := Result + '|LabelWidget';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKLabelframe.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'LabelWidget' then
    inherited SetAttribute(Attr, Value, 'Source')
  else
    inherited;
end;

procedure TKLabelframe.SetLabelAnchor(Value: TLabelAnchor);
begin
  if FLabelAnchor <> Value then
  begin
    FLabelAnchor := Value;
    Invalidate;
  end;
end;

procedure TKLabelframe.Paint;
var
  TextWidth, TextHeight, TextHeightS, TextWidthR, XPos, YPos: Integer;
  ARect: TRect;
begin
  inherited;
  ARect := ClientRect;
  Canvas.FillRect(ARect); // remove border
  TextWidth := Canvas.TextWidth(Text);
  TextHeight := Canvas.TextHeight('Hg');
  TextHeightS := Max((TextHeight - BorderWidthInt) div 2, 0);
  TextWidthR := Max((TextWidth - BorderWidthInt) div 2, 0);
  case FLabelAnchor of
    _TL_nw, _TL_n, _TL_ne:
      ARect.Top := ARect.Top + TextHeightS;
    _TL_en, _TL_e, _TL_es:
      ARect.Right := ARect.Right - TextWidthR;
    _TL_se, _TL_s, _TL_sw:
      ARect.Bottom := ARect.Bottom - TextHeightS;
    _TL_ws, _TL_w, _TL_wn:
      ARect.Left := ARect.Left + TextWidthR;
  end;
  PaintBorder(ARect, Relief, BorderWidthInt);
  case FLabelAnchor of
    _TL_nw:
      begin
        XPos := BorderWidthInt + 4;
        YPos := 0;
      end;
    _TL_n:
      begin
        XPos := (Width - TextWidth) div 2;
        YPos := 0;
      end;
    _TL_ne:
      begin
        XPos := Width - BorderWidthInt - 4 - TextWidth;
        YPos := 0;
      end;
    _TL_en:
      begin
        XPos := Width - TextWidth - 1;
        YPos := BorderWidthInt + 4;
      end;
    _TL_e:
      begin
        XPos := Width - TextWidth - 1;
        YPos := (Height - TextHeight) div 2;
      end;
    _TL_es:
      begin
        XPos := Width - TextWidth - 1;
        YPos := Height - BorderWidthInt - 4 - TextHeight;
      end;
    _TL_se:
      begin
        XPos := Width - BorderWidthInt - 4 - TextWidth;
        YPos := Height - TextHeight - 1;
      end;
    _TL_s:
      begin
        XPos := (Width - TextWidth) div 2;
        YPos := Height - TextHeight - 1;
      end;
    _TL_sw:
      begin
        XPos := BorderWidthInt + 4;
        YPos := Height - TextHeight - 1;
      end;
    _TL_ws:
      begin
        XPos := 0;
        YPos := Height - BorderWidthInt - 4 - TextHeight;
      end;
    _TL_w:
      begin
        XPos := 0;
        YPos := (Height - TextHeight) div 2;
      end;
  else
    begin
      XPos := 0;
      YPos := BorderWidthInt + 4;
    end; // _TL_wn:
  end;
  Canvas.TextOut(XPos, YPos, Text);
end;

{ --- TKMessage ---------------------------------------------------------------- }

constructor TKMessage.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 10;
  FAnchor := _TA_center;
  FAspect := 150;
  HighlightThickness := '0';
  FJustify := _TJ_left;
end;

procedure TKMessage.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Text' then
    SetValue(Name + 'CV', AsString(Value))
  else
    inherited;
end;

function TKMessage.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Justify|Text';
  if ShowAttributes >= 2 then
    Result := Result + '|Anchor|Aspect';
  if ShowAttributes = 3 then
    Result := Result + '|HighlightBackground|HighlightColor|HighlightThickness';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKMessage.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Message');
  MakeControlVar('textvariable', Name + 'CV', Text);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKMessage.SetJustify(Value: TJustify);
begin
  if FJustify <> Value then
  begin
    FJustify := Value;
    Invalidate;
  end;
end;

procedure TKMessage.SetAnchor(Value: TAnchor);
begin
  if FAnchor <> Value then
  begin
    FAnchor := Value;
    Invalidate;
  end;
end;

procedure TKMessage.SetAspect(Value: Integer);
begin
  if FAspect <> Value then
  begin
    FAspect := Value;
    Invalidate;
  end;
end;

procedure TKMessage.Paint;
var
  TextWidth, TextHeight, XPos, YPos, ATextWidth, ATextHeight: Integer;
  Str: string;
  ARect: TRect;
  Jus: Integer;
  StringList: TStringList;

  procedure Split(const Str: string; var Str1, Str2: string);
  var
    Len, Num, Posi: Integer;
  begin
    Len := Canvas.TextWidth('abcdefghijklmnopqrstuvwxyz');
    Num := Round(ATextWidth / (Len / 26.0)) + 1;

    Posi := Num;
    // wrap = word
    while (Posi > 0) and (Str[Posi] <> ' ') do
      Dec(Posi);

    if Posi > 0 then
    begin
      Str1 := Copy(Str, 1, Posi - 1);
      Str2 := Copy(Str, Posi + 1, Length(Str));
    end
    else
    begin
      Posi := Num;
      while (Posi < Length(Str)) and (Str[Posi] <> ' ') do
        Inc(Posi);
      if Posi = Length(Str) then
      begin
        Str1 := Str;
        Str2 := '';
      end
      else
      begin
        Str1 := Copy(Str, 1, Posi - 1);
        Str2 := Copy(Str, Posi + 1, Length(Str));
      end;
    end;
  end;

  procedure makeSL;
  var
    Str, Str1, Str2: string;
  begin
    StringList.Clear;
    Str := Text;
    Str1 := '';
    Str2 := '';
    while Canvas.TextWidth(Str) > ATextWidth do
    begin
      Split(Str, Str1, Str2);
      StringList.Add(Str1);
      Str := Str2;
    end;
    if Str <> '' then
      StringList.Add(Str);
  end;

begin
  inherited;

  ARect := Rect(BorderWidthInt, BorderWidthInt, Width - BorderWidthInt,
    Height - BorderWidthInt);
  Canvas.Brush.Color := Background;
  Canvas.FillRect(ARect);

  TextWidth := Canvas.TextWidth(Text);
  TextHeight := Canvas.TextHeight('Hg');
  // TextWidth*TextHeight is area of linear text
  // ATextWidth*ATextHeight is same area in a rectangle with XPos:YPos = Aspect/100
  ATextWidth := Round(Sqrt(TextWidth * TextHeight * FAspect / 100.0));
  // ATextHeight:= Round(ATextWidth/(FAspect/100.0));

  StringList := TStringList.Create;
  makeSL;
  Str := StringList.Text;
  while Copy(Str, Length(Str) - 1, 2) = #13#10 do
    Delete(Str, Length(Str) - 1, 2);

  ARect := Rect(0, 0, 0, 0);
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_CALCRECT);
  ATextWidth := ARect.Width;
  ATextHeight := ARect.Height;

  case FAnchor of
    _TA_nw:
      begin
        XPos := 6;
        YPos := 1;
      end;
    _TA_n:
      begin
        XPos := (Width - ATextWidth) div 2;
        YPos := 1;
      end;
    _TA_ne:
      begin
        XPos := Width - 5 - ATextWidth;
        YPos := 1;
      end;
    _TA_e:
      begin
        XPos := Width - 1 - ATextWidth;
        YPos := (Height - ATextHeight) div 2;
      end;
    _TA_se:
      begin
        XPos := Width - 5 - ATextWidth;
        YPos := Height - 1 - ATextHeight;
      end;
    _TA_s:
      begin
        XPos := (Width - ATextWidth) div 2;
        YPos := Height - 1 - ATextHeight;
      end;
    _TA_sw:
      begin
        XPos := 6;
        YPos := Height - 1 - ATextHeight;
      end;
    _TA_w:
      begin
        XPos := 1;
        YPos := (Height - ATextHeight) div 2;
      end;
  else
    begin
      XPos := (Width - ATextWidth) div 2;
      YPos := (Height - ATextHeight) div 2;
    end; // center
  end;
  case FJustify of
    _TJ_left:
      Jus := DT_LEFT;
    _TJ_center:
      Jus := DT_CENTER;
  else
    Jus := DT_RIGHT;
  end;
  ARect := Rect(XPos, YPos, ATextWidth, ATextHeight);
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_CALCRECT);
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, Jus);
  FreeAndNil(StringList);
end;

{ --- TKScale ------------------------------------------------------------------ }

constructor TKScale.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 15;
  Width := 80;
  Height := 120;
  FBigIncrement := 0;
  FDigits := 0;
  HighlightThickness := '2';
  FLength := 100;
  FResolution := 1;
  FShowValue := True;
  FSliderLength := 30;
  FSliderRelief := _TR_raised;
  FState := normal;
  FTo := 100;
  FTrackSize := 15;
end;

function TKScale.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|From|To_|Label_|Orient|Resolution|TickInterval|Value';
  if ShowAttributes >= 2 then
    Result := Result +
      '|BigIncrement|Command|Digits|SliderLength|SliderRelief|ShowValue';
  if ShowAttributes = 3 then
    Result := Result + '|ActiveBackground|HighlightBackground|HighlightColor' +
      '|HighlightThicknessLength|State|RepeatDelay|RepeatInterval|TroughColor';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKScale.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else
    inherited;
end;

procedure TKScale.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Scale');
  MakeControlVar('variable', Name + 'CV', IntToStr(Round(FValue)), 'Int');
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKScale.MakeCommand(Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x');
end;

procedure TKScale.Paint;
begin
  inherited;
  Canvas.Font.Assign(Font);
  UpdateTrackData;
  UpdateTrack;
  UpdateTicks;
  UpdateSlider;
  UpdateLabel;
end;

procedure TKScale.UpdateTrackData;
var
  Str1, Str2: string;
begin
  FTrackSize := PPIScale(15);
  FSliderLength := PPIScale(30);
  if FResolution <> 0 then
    if FResolution >= 1 then
      FDecimals := 0
    else
      FDecimals := Round(Ln(1 / FResolution) / Ln(10));

  if FOrient = horizontal then
  begin
    FTickSpace := Canvas.TextHeight('0') + PPIScale(4);
    FUsablePixels := Width - 4 * BorderWidthInt - FSliderLength;
    FTrackRect.Left := 2 * BorderWidthInt;
    FTrackRect.Right := Width - 2 * BorderWidthInt;
    FTrackRect.Top := 2 * BorderWidthInt;
    if FLabel <> '' then
      FTrackRect.Top := FTrackRect.Top + FTickSpace;
    if FShowValue then
      FTrackRect.Top := FTrackRect.Top + FTickSpace;
    FTrackRect.Bottom := FTrackRect.Top + FTrackSize;
  end
  else
  begin
    Str1 := FloatToStrF(FFrom, ffFixed, 8, FDecimals);
    Str2 := FloatToStrF(FTo, ffFixed, 8, FDecimals);
    FTickSpace := Max(Canvas.TextWidth(Str1), Canvas.TextWidth(Str2)) +
      PPIScale(4);
    FUsablePixels := Height - 4 * BorderWidthInt - FSliderLength;
    FTrackRect.Top := 2 * BorderWidthInt;
    FTrackRect.Bottom := Height - 2 * BorderWidthInt - 1;
    FTrackRect.Left := 2 * BorderWidthInt;
    if FShowValue then
      FTrackRect.Left := FTrackRect.Left + FTickSpace;
    if FTickInterval > 0 then
      FTrackRect.Left := FTrackRect.Left + FTickSpace;
    FTrackRect.Right := FTrackRect.Left + FTrackSize;
  end;
end;

procedure TKScale.UpdateTrack;
begin
  var
  ARect := FTrackRect;
  ARect.Inflate(BorderWidthInt, BorderWidthInt);
  PaintBorder(ARect, _TR_sunken, BorderWidthInt);
  Canvas.Brush.Color := FTroughColor;
  Canvas.FillRect(FTrackRect);
end;

procedure TKScale.UpdateTicks;
var
  XPos, YPos, XNew, XOld, YNew, YOld, TextHeight, TextWidth, FromPos: Integer;
  XVal, YVal: Real;
  Str: string;
begin
  Canvas.Pen.Color := Foreground;
  Canvas.Brush.Color := Background;
  Canvas.Font.Color := clBlack;
  FromPos := 2 * BorderWidthInt + FSliderLength div 2;
  TextHeight := Canvas.TextHeight('0');
  TextWidth := 0;
  XOld := 0;
  YOld := 0;

  if FTickInterval > 0 then
    if FOrient = horizontal then
    begin
      XVal := FFrom;
      while XVal <= FTo do
      begin
        XNew := Round(FUsablePixels * (XVal - FFrom) / (FTo - FFrom)) + FromPos;
        if XNew - XOld < TextWidth - 1 then
        begin
          XVal := XVal + FTickInterval;
          Continue;
        end;
        Str := FloatToStrF(XVal, ffFixed, 8, FDecimals);
        TextWidth := Canvas.TextWidth(Str);
        YPos := FTrackRect.Bottom + BorderWidthInt + PPIScale(4);
        Canvas.TextOut(XNew - TextWidth div 2, YPos, Str);
        XOld := XNew;
        XVal := XVal + FTickInterval;
      end;
    end
    else
    begin
      YVal := FFrom;
      while YVal <= FTo do
      begin
        YNew := Round(FUsablePixels * (YVal - FFrom) / (FTo - FFrom)) + FromPos;
        if YNew - YOld < TextHeight - 1 then
        begin
          YVal := YVal + FTickInterval;
          Continue;
        end;
        Str := FloatToStrF(YVal, ffFixed, 8, FDecimals);
        TextWidth := Canvas.TextWidth(Str);
        XPos := BorderWidthInt + FTickSpace - TextWidth - PPIScale(2);
        Canvas.TextOut(XPos, YNew - TextHeight div 2, Str);
        YOld := YNew;
        YVal := YVal + FTickInterval;
      end;
    end;
end;

procedure TKScale.UpdateSlider;
var
  XPos, YPos, Range, TextWidth, TextHeight: Integer;
  Str: string;
  FSliderRect: TRect;
  Val: Real;
begin
  // reduce Value to next resolution value
  Val := FValue;
  if FResolution > 0 then
    Val := Round(FValue / FResolution) * FResolution;
  Range := Round(FUsablePixels * (Val - FFrom) / (FTo - FFrom)) + 2 *
    BorderWidthInt;
  if FOrient = horizontal then
  begin
    XPos := Range;
    YPos := FTrackRect.Top;
    FSliderRect := Rect(XPos, YPos, XPos + FSliderLength, YPos + FTrackSize);
  end
  else
  begin
    XPos := FTrackRect.Left;
    YPos := Range;
    FSliderRect := Rect(XPos, YPos, XPos + FTrackSize, YPos + FSliderLength);
  end;
  Canvas.Pen.Color := clBlack;
  Canvas.Brush.Color := Background;
  Canvas.Rectangle(FSliderRect);
  if FOrient = horizontal then
  begin
    XPos := (FSliderRect.Left + FSliderRect.Right) div 2;
    Canvas.MoveTo(XPos, FSliderRect.Top);
    Canvas.LineTo(XPos, FSliderRect.Bottom);
  end
  else
  begin
    YPos := (FSliderRect.Top + FSliderRect.Bottom) div 2;
    Canvas.MoveTo(FSliderRect.Left, YPos);
    Canvas.LineTo(FSliderRect.Right, YPos);
  end;

  if FShowValue then
  begin
    Str := FloatToStrF(Val, ffFixed, 8, FDecimals);
    TextWidth := Canvas.TextWidth(Str);
    TextHeight := Canvas.TextHeight(Str);
    if FOrient = horizontal then
    begin
      XPos := Range + FTrackSize - TextWidth div 2;
      YPos := BorderWidthInt + FTickSpace - TextHeight - 2;
      if FLabel <> '' then
        YPos := YPos + FTickSpace;
    end
    else
    begin
      XPos := BorderWidthInt + FTickSpace - TextWidth - 2;
      if FTickInterval > 0 then
        Inc(XPos, FTickSpace);
      YPos := Range + FSliderLength div 2 - TextHeight div 2;
    end;
    Canvas.TextOut(XPos, YPos, Str);
  end;
end;

procedure TKScale.UpdateLabel;
var
  ARect: TRect;
begin
  if FLabel <> '' then
  begin
    if FOrient = horizontal then
      ARect := Rect(BorderWidthInt + PPIScale(6), BorderWidthInt + PPIScale(3),
        Width - BorderWidthInt, BorderWidthInt + PPIScale(6) + FTickSpace)
    else
      ARect := Rect(FTrackRect.Right + BorderWidthInt + PPIScale(6),
        BorderWidthInt + PPIScale(6), Width - BorderWidthInt,
        FTrackRect.Height - BorderWidthInt);
    DrawText(Canvas.Handle, PChar(FLabel), System.Length(FLabel),
      ARect, DT_LEFT);
  end;
end;

procedure TKScale.SetFrom(Value: Real);
begin
  if FFrom <> Value then
  begin
    FFrom := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetTo(Value: Real);
begin
  if FTo <> Value then
  begin
    FTo := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetLabel(Value: string);
begin
  if FLabel <> Value then
  begin
    FLabel := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetResolution(Value: Real);
begin
  if FResolution <> Value then
  begin
    FResolution := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetShowValue(Value: Boolean);
begin
  if FShowValue <> Value then
  begin
    FShowValue := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetSliderLength(Value: Integer);
begin
  if FSliderLength <> Value then
  begin
    FSliderLength := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetTickInterval(Value: Real);
begin
  if FTickInterval <> Value then
  begin
    FTickInterval := Value;
    Invalidate;
  end;
end;

procedure TKScale.SetRValue(Value: Real);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    if FValue > FTo then
      FValue := FTo
    else if FValue < FFrom then
      FValue := FFrom;
    if csDesigning in ComponentState then
      Invalidate
    else
      UpdateSlider;
  end;
end;

{ --- TKScrollbar -------------------------------------------------------------- }

constructor TKScrollbar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 12;
  Width := 160;
  Height := 16;
  FActiveRelief := _TR_raised;
  FElementBorderWidth := -1;
  HighlightThickness := '0';
  FJump := False;
  BorderWidth := '0';
  Relief := _TR_sunken;
  FOrient := horizontal;
end;

function TKScrollbar.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Orient';
  if ShowAttributes >= 2 then
    Result := Result + '|Jump';
  if ShowAttributes = 3 then
    Result := Result +
      '|ActiveRelief|ElementBorderWidth|ActiveBackground|HighlightBackground' +
      '|HighlightColor|HighlightThickness|RepeatDelay|RepeatInterval|TroughColor';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKScrollbar.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.Scrollbar');
  InsertValue('self.' + Name + '[''orient''] = ' + AsString('horizontal'));
end;

procedure TKScrollbar.MakeFont;
begin
  // no font
end;

procedure TKScrollbar.Paint;
begin
  PaintScrollbar(ClientRect, FOrient = horizontal);
end;

{ --- TKPopupMenu -------------------------------------------------------------- }

constructor TKPopupMenu.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 20;
  Width := 31;
  Height := 27;
  ActiveBackground := clHighlight;
  FActiveBorderWidth := 1;
  FActiveForeground := clHighlightText;
  FDisabledForeground := clGrayText;
  FSelectColor := clMenuText;
  FType := _TT_normal;
  Background := clMenu;
  Foreground := clMenuText;
  FMenuItems := TStringList.Create; // new menu items from user
  FMenuItems.Text :=
    'File'#13#10'  New'#13#10'    Python'#13#10'    XML'#13#10'  Load'#13#10'  Save'#13#10
    + 'Edit'#13#10'  Copy'#13#10'  Paste'#13#10'  -'#13#10'  Delete'#13#10;
  FMenuItemsOld := TStringList.Create; // old menu items from user
end;

destructor TKPopupMenu.Destroy;
begin
  FreeAndNil(FMenuItems);
  FreeAndNil(FMenuItemsOld);
  inherited;
end;

function TKPopupMenu.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|MenuItems|Name';
  if ShowAttributes >= 2 then
    Result := Result + '|PostCommand';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKPopupMenu.NewWidget(Widget: string = '');
begin
  InsertValue(Indent2 + 'self.' + Name + ' = tk.Menu(tearoff=0)');
  FMenuItemsOld.Text := '';
  MakeMenuItems;
end;

function TKPopupMenu.MakeMenubar: string;
begin
  Result := '';
end;

procedure TKPopupMenu.SetPositionAndSize;
begin
  // do nothing
end;

procedure TKPopupMenu.SetItems(Items: TStrings);
begin
  FMenuItemsOld.Text := FMenuItems.Text;
  if Items.Text <> FMenuItems.Text then
    FMenuItems.Assign(Items);
end;

procedure TKPopupMenu.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited;
end;

function TKPopupMenu.GetEvents(ShowEvents: Integer): string;
begin
  Result := '';
end;

function TKPopupMenu.HasSubMenu(MenuItems: TStrings; Num: Integer): Boolean;
begin
  Result := (Num < MenuItems.Count - 1) and
    (LeftSpaces(MenuItems[Num], 2) < LeftSpaces(MenuItems[Num + 1], 2));
end;

function TKPopupMenu.MakeMenuName(Menu, Str: string): string;
begin
  if Right(Menu, -4) = 'Menu' then
    Menu := Copy(Menu, 1, Length(Menu) - 4);
  Result := Menu + OnlyCharsAndDigits(Str) + 'Menu';
end;

procedure TKPopupMenu.CalculateMenus(MenuItems, PyMenu, PyMethods: TStrings);
var
  Int, MenuIndent, LeftSpac: Integer;
  Str, MenuS: string;
  MenuName: array [-1 .. 10] of string;
  MenuText: array [-1 .. 10] of string;

  procedure MakeCommand(Indent: Integer);
  var
    Com: string;
  begin
    if MenuS = '-' then
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent - 1] +
        '.add_separator()')
    else
    begin
      Com := MenuName[Indent - 1];
      Com := Copy(Com, 1, Length(Com) - 4) + OnlyCharsAndDigits(MenuS) +
        '_Command';
      PyMethods.Add(Com + '(self):');
      PyMenu.Add(Indent2 + 'self.' + MenuName[Indent - 1] +
        '.add_command(label=''' + MenuS + ''', command=self.' + Com + ')');
    end;
  end;

begin
  MenuName[-1] := Name;
  MenuText[-1] := '';
  MenuIndent := 0;
  // insert new MenuItems
  Int := 0;
  while Int < MenuItems.Count do
  begin
    Str := MenuItems[Int];
    MenuS := Trim(Str);
    LeftSpac := LeftSpaces(Str, 2) div 2;
    if LeftSpac < MenuIndent then
    begin // close all open menus
      while MenuIndent > LeftSpac do
      begin
        PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent - 2] +
          '.add_cascade(label=''' + MenuText[MenuIndent - 1] + ''', menu=self.'
          + MenuName[MenuIndent - 1] + ')');
        Dec(MenuIndent);
      end;
      Dec(Int);
    end
    else if LeftSpac > MenuIndent then
    begin
      MakeCommand(MenuIndent);
      Inc(MenuIndent);
    end
    else if (LeftSpac = 0) or HasSubMenu(MenuItems, Int) then
    begin // create new menu/submenu
      MenuText[MenuIndent] := MenuS;
      MenuName[MenuIndent] := MakeMenuName(MenuName[MenuIndent - 1], Str);
      PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent] + ' = tk.Menu(self.' +
        Name + ', tearoff=0)');
      Inc(MenuIndent);
    end
    else
      MakeCommand(MenuIndent);
    Inc(Int);
  end;
  while MenuIndent > 0 do
  begin
    PyMenu.Add(Indent2 + 'self.' + MenuName[MenuIndent - 2] +
      '.add_cascade(label=''' + MenuText[MenuIndent - 1] + ''', menu=self.' +
      MenuName[MenuIndent - 1] + ')');
    Dec(MenuIndent);
  end;
end;

procedure TKPopupMenu.MakeMenuItems;
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
  Partner.DeleteLine(MakeMenubar);
  if NewMenu.Text <> '' then
    Partner.InsertValue(Name, NewMenu.Text + MakeMenubar, 1);

  FreeAndNil(OldMenu);
  FreeAndNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKPopupMenu.Rename(const OldName, NewName, Events: string);
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
  Partner.DeleteLine(MakeMenubar);
  CalculateMenus(FMenuItemsOld, OldMenu, OldMethods);
  Name := NewName;
  CalculateMenus(FMenuItems, NewMenu, NewMethods);
  Partner.DeleteOldAddNewMethods(OldMethods, NewMethods);
  for var I := 0 to OldMenu.Count - 1 do
    Partner.DeleteLine(OldMenu[I]);
  Partner.ReplaceWord(OldName, NewName, True);
  if NewMenu.Text <> '' then
    Partner.InsertValue(Name, NewMenu.Text + MakeMenubar, 1);

  FreeAndNil(OldMenu);
  FreeAndNil(OldMethods);
  FreeAndNil(NewMenu);
  FreeAndNil(NewMethods);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKPopupMenu.DeleteWidget;
begin
  inherited;
  FMenuItemsOld.Text := FMenuItems.Text;
  FMenuItems.Clear;
  MakeMenuItems;
  if FPostCommand then
    Partner.DeleteMethod(Name + '_PostCommand');
end;

procedure TKPopupMenu.Paint;
begin
  inherited;
  Canvas.Rectangle(Rect(0, 0, Width, Height));
  PyIDEMainForm.vilTkInterLight.Draw(Canvas, 7, 4, 16);
end;

{ --- TKMenu ------------------------------------------------------------------- }

constructor TKMenu.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 19;
  Width := 100;
  Height := 19;
end;

function TKMenu.MakeMenubar: string;
begin
  Result := Indent2 + 'self.root[''menu''] = self.' + Name;
end;

procedure TKMenu.DeleteWidget;
begin
  inherited;
  Partner.DeleteAttribute('self.root[''menu'']');
end;

procedure TKMenu.Paint;
var
  Str, Item: string;
begin
  SetBounds(0, 0, Parent.ClientWidth, PPIScale(19));
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

{ --- PanedWindow -------------------------------------------------------------- }

constructor TKPanedWindow.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 16;
  Width := 80;
  Height := 120;
  ControlStyle := [csAcceptsControls];
  FHandlePad := 8;
  FHandleSize := '8';
  FOpaqueResize := True;
  FOrient := horizontal;
  FProxyBorderWidth := '2';
  FProxyRelief := _TR_flat;
  FSashRelief := _TR_flat;
  FSashWidth := '3';
  FShowHandle := False;
end;

procedure TKPanedWindow.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.PanedWindow');
  SashRelief := _TR_groove;
  SetAttribute('sashrelief', 'groove', 'TRelief');
end;

function TKPanedWindow.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|HandlePad|HandleSize|OpaqueResize|Orient|SashCursor|SashPad|SashRelief|SashWidth|ShowHandle';
  if ShowAttributes >= 2 then
    Result := Result + '|ProxyBackground|ProxyBorderWidth|ProxyRelief';
  if ShowAttributes >= 3 then
    Result := Result + '';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKPanedWindow.MakeFont;
begin
  // no font
end;

procedure TKPanedWindow.SetHandlePad(Value: Integer);
begin
  if FHandlePad <> Value then
  begin
    FHandlePad := Value;
    Invalidate;
  end;
end;

procedure TKPanedWindow.SetHandleSize(Value: string);
begin
  if FHandleSize <> Value then
  begin
    FHandleSize := Value;
    Resize;
    Invalidate;
  end;
end;

procedure TKPanedWindow.SetSashPad(Value: string);
begin
  if FSashPad <> Value then
  begin
    FSashPad := Value;
    Resize;
    Invalidate;
  end;
end;

procedure TKPanedWindow.SetSashRelief(Value: TRelief);
begin
  if FSashRelief <> Value then
  begin
    FSashRelief := Value;
    Invalidate;
  end;
end;

procedure TKPanedWindow.SetSashWidth(Value: string);
begin
  if FSashWidth <> Value then
  begin
    FSashWidth := Value;
    Resize;
    Invalidate;
  end;
end;

procedure TKPanedWindow.SetShowHandle(Value: Boolean);
begin
  if FShowHandle <> Value then
  begin
    FShowHandle := Value;
    Invalidate;
  end;
end;

procedure TKPanedWindow.PaintSlashAt(Pos: Integer);
var
  ARect: TRect;
  AWidth: Integer;
begin
  AWidth := Max(FHandleSizeInt, FSashWidthInt) div 2 + FSashPadInt;
  if FOrient = horizontal then
  begin
    ARect := Rect(Pos - AWidth, BorderWidthInt, Pos + AWidth,
      Height - BorderWidthInt);
    Canvas.Brush.Color := Background;
    Canvas.FillRect(ARect);
    ARect := Rect(Pos - FSashWidthInt div 2, BorderWidthInt,
      Pos + FSashWidthInt div 2, Height - BorderWidthInt);
    PaintBorder(ARect, SashRelief, 1);
    ARect := Rect(Pos - FHandleSizeInt div 2, BorderWidthInt + HandlePad,
      Pos + FHandleSizeInt div 2, BorderWidthInt + HandlePad + FHandleSizeInt);
    PaintBorder(ARect, SashRelief, 1);
  end
  else
  begin
    ARect := Rect(BorderWidthInt, Pos - AWidth, Width - BorderWidthInt,
      Pos + AWidth);
    Canvas.Brush.Color := Background;
    Canvas.FillRect(ARect);
    ARect := Rect(BorderWidthInt, Pos - FSashWidthInt div 2,
      Width - BorderWidthInt, Pos + FSashWidthInt div 2);
    PaintBorder(ARect, SashRelief, 1);
    ARect := Rect(BorderWidthInt + HandlePad, Pos - FHandleSizeInt div 2,
      BorderWidthInt + HandlePad + FHandleSizeInt, Pos + FHandleSizeInt div 2);
    PaintBorder(ARect, SashRelief, 1);
  end;
end;

procedure TKPanedWindow.CalculateInts;
begin
  if not TryStrToInt(FSashPad, FSashPadInt) then
    FSashPadInt := 0;
  if not TryStrToInt(FSashWidth, FSashWidthInt) then
    FSashWidthInt := 3;
  if not TryStrToInt(FHandleSize, FHandleSizeInt) then
    FHandleSizeInt := 8;
end;

function TKPanedWindow.GetPos(Num: Integer): Integer;
var
  SashW: Integer;
  ControlW: Real;
begin
  SashW := Max(FHandleSizeInt, FSashWidthInt) + 2 * FSashPadInt;
  if ControlCount > 0 then
    if FOrient = horizontal then
      ControlW := (Width - 2 * BorderWidthInt - (ControlCount - 1) * SashW) /
        (ControlCount * 1.0)
    else
      ControlW := (Height - 2 * BorderWidthInt - (ControlCount - 1) * SashW) /
        (ControlCount * 1.0)
  else
    ControlW := 0;
  Result := Round(BorderWidthInt + Num * ControlW + (Num - 1) * SashW +
    SashW div 2);
end;

procedure TKPanedWindow.Paint;
var
  ARect: TRect;
begin
  inherited;
  CalculateInts;
  ARect := Rect(BorderWidthInt, BorderWidthInt, Width - BorderWidthInt,
    Height - BorderWidthInt);
  Canvas.Brush.Color := Background;
  Canvas.FillRect(ARect);
  if ControlCount > 1 then
    for var I := 1 to ControlCount - 1 do
      PaintSlashAt(GetPos(I))
  else
    PaintSlashAt(GetPos(1)); // to show a slider in the gui form
end;

procedure TKPanedWindow.Resize;
var
  AWidth, CWidth, CHeight: Integer;
begin
  CalculateInts;
  AWidth := Max(FHandleSizeInt, FSashWidthInt) div 2 + FSashPadInt;
  if Orient = horizontal then
  begin
    CHeight := Height - 2 * BorderWidthInt;
    if ControlCount > 1 then
    begin
      CWidth := GetPos(1) - AWidth - BorderWidthInt;
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, CWidth, CHeight);
      for var I := 1 to ControlCount - 1 do
        Controls[I].SetBounds(GetPos(I) + AWidth, BorderWidthInt,
          CWidth, CHeight);
      Controls[ControlCount - 1].SetBounds(GetPos(ControlCount - 1) + AWidth,
        BorderWidthInt, CWidth, CHeight);
    end
    else if ControlCount = 1 then
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt,
        Width - 2 * BorderWidthInt, CHeight);
  end
  else
  begin
    CWidth := Width - 2 * BorderWidthInt;
    if ControlCount > 1 then
    begin
      CHeight := GetPos(1) - AWidth - BorderWidthInt;
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, CWidth, CHeight);
      for var I := 1 to ControlCount - 1 do
        Controls[I].SetBounds(BorderWidthInt, GetPos(I) + AWidth,
          CWidth, CHeight);
      Controls[ControlCount - 1].SetBounds(BorderWidthInt,
        GetPos(ControlCount - 1) + AWidth, CWidth, CHeight);
    end
    else if ControlCount = 1 then
      Controls[0].SetBounds(BorderWidthInt, BorderWidthInt, CWidth,
        Height - 2 * BorderWidthInt);
  end;
end;

{ --- TKRadiobuttonGroup ------------------------------------------------------- }

constructor TKRadiobuttonGroup.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 7;
  Width := 80;
  Height := 80;
  FColumns := 1;
  FItems := TStringList.Create;
  FOldItems := TStringList.Create;
  FLabel := ' ' + _('Continent') + ' ';
end;

destructor TKRadiobuttonGroup.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TKRadiobuttonGroup.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Background|Columns|Command|Items|Font|Label_|Name|Checkboxes';
  if ShowAttributes = 3 then
    Result := Result + '|Height|Width|Left|Top';
end;

procedure TKRadiobuttonGroup.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Command' then
    ChangeCommand(Value)
  else if (Attr = 'Items') or (Attr = 'Checkboxes') then
    MakeButtongroupItems
  else if Attr = 'Columns' then
    SetPositionAndSize
  else if Attr = 'Label_' then
    MakeLabel(Value)
  else if Attr = 'Background' then
  begin
    inherited;
    MakeButtongroupItems;
  end
  else if IsFontAttribute(Attr) then
  begin
    if Label_ <> '' then
      inherited;
    MakeButtongroupItems;
  end
  else
    inherited;
end;

function TKRadiobuttonGroup.RBName(Num: Integer): string;
begin
  Result := 'self.' + Name + 'RB' + IntToStr(Num);
end;

procedure TKRadiobuttonGroup.MakeButtongroupItems;
var
  Options, CommonOptions, Str: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  for var I := 0 to FOldItems.Count - 1 do
  begin
    Partner.DeleteAttributeValues(RBName(I));
    Partner.DeleteAttributeValues(RBName(I) + 'CV');
  end;
  Partner.DeleteAttributeValues('self.' + Name + '[''variable'']');

  CommonOptions := 'self.' + Name + ', ';
  if Background <> clBtnFace then
    CommonOptions := CommonOptions + 'background=''' +
      TColorToString(Background) + ''', ';
  if (Font.Name <> 'Segoe UI') or (PPIUnScale(Font.Size) <> 9) then
    CommonOptions := CommonOptions + 'font = (' + AsString(Font.Name) + ', ' +
      IntToStr(PPIUnScale(Font.Size)) + '), ';
  CommonOptions := CommonOptions + 'anchor=''w'', ';
  Str := '';
  for var I := 0 to FItems.Count - 1 do
  begin
    if FCheckboxes then
    begin
      Options := CommonOptions + 'text=' + AsString(FItems[I]);
      Str := Str + Surround(RBName(I) + ' = tk.Checkbutton(' + Options + ')') +
        Surround(RBName(I) + '.place(x=0, y=0, width=0, height=0)') +
        Surround(RBName(I) + 'CV = tk.IntVar()') +
        Surround(RBName(I) + '[''variable''] = ' + RBName(I) + 'CV') +
        Surround(RBName(I) + 'CV.set(0)');
    end
    else
    begin
      Options := CommonOptions + 'text=' + AsString(FItems[I]) + ', value=' +
        AsString(FItems[I]);
      Str := Str + Surround(RBName(I) + ' = tk.Radiobutton(' + Options + ')') +
        Surround(RBName(I) + '.place(x=0, y=0, width=0, height=0)') +
        Surround(RBName(I) + '[''variable''] = self.' + Name + 'CV');
    end;
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
  FOldItems.Text := FItems.Text;
  SetPositionAndSize;
end;

procedure TKRadiobuttonGroup.SetPositionAndSize;
var
  Col, Row, ItemsInCol, Line, XPos, YPos, TextHeight: Integer;
  RadioHeight, RadioWidth, ColWidth, RowHeight, ColWidthRest,
    RowHeightRest: Integer;
  XOld, YOld, ColWidthI, RowHeightI: Integer;
  Key: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited;
  Canvas.Font.Assign(Font);
  TextHeight := Canvas.TextHeight('Hg');
  if FLabel = '' then
  begin
    RadioWidth := Width;
    RadioHeight := Height;
  end
  else
  begin
    RadioWidth := Width - PPIScale(4);
    RadioHeight := Height - TextHeight - PPIScale(4);
  end;

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
        XPos := 0
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
          YPos := 0 // TextHeight in Qt
        else
          YPos := YOld + RowHeightI;
        Dec(RowHeightRest);
        Key := RBName(Line) + '.place';
        SetAttributValue(Key, Key + '(x=' + IntToStr(PPIUnScale(XPos)) + ', y='
          + IntToStr(PPIUnScale(YPos)) + ', width=' +
          IntToStr(PPIUnScale(ColWidthI)) + ', height=' +
          IntToStr(PPIUnScale(RowHeightI)) + ')');
        Inc(Line);
        YOld := YPos;
      end;
      XOld := XPos;
    end;
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKRadiobuttonGroup.MakeCommand(Attr, Value: string);
var
  Func, Nam, Str: string;
begin
  Command := True;
  Nam := Name + '_Command';
  Func := CrLf + Indent1 + 'def ' + Nam + '(self):' + CrLf + Indent2 +
    LNGInsertSourceCodeHere + CrLf + Indent2 + 'pass' + CrLf;
  Partner.InsertProcedure(Func);
  Str := '';
  for var I := 0 to FItems.Count - 1 do
    Str := Str + Surround(RBName(I) + '[''command''] = ' + 'self.' + Nam);
  InsertValue(Str);
end;

procedure TKRadiobuttonGroup.ChangeCommand(Value: string);
var
  Key: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  if Value = 'True' then
  begin
    MakeCommand('Command', Value);
    for var I := 0 to FItems.Count - 1 do
    begin
      Key := RBName(I) + '[''command'']';
      SetAttributValue(Key, Key + ' = self.' + Name + '_Command');
    end;
  end
  else
  begin
    Partner.DeleteMethod(Name + '_Command');
    for var I := 0 to FItems.Count - 1 do
      Partner.DeleteAttribute(RBName(I) + '[''command'']');
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKRadiobuttonGroup.MakeLabel(ALabel: string);
begin
  FLabel := ALabel;
  var
  Key := 'self.' + Name + ' = ';
  if ALabel = '' then
  begin
    Partner.ReplaceLine(Key, Indent2 + Key + 'tk.Frame()');
    Partner.DeleteAttribute('self.' + Name + '[''text'']');
    Partner.DeleteAttribute('self.' + Name + '[''font'']');
  end
  else
  begin
    Partner.ReplaceLine(Key, Indent2 + Key + 'tk.LabelFrame()');
    Key := 'self.' + Name + '[''text'']';
    SetAttributValue(Key, Key + ' = ' + AsString(FLabel));
    MakeFont;
  end;
  SetPositionAndSize;
end;

procedure TKRadiobuttonGroup.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.Frame');
  MakeLabel(' ' + _('Continent') + ' ');
  FItems.Text := DefaultItems;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + AsString(FItems[0]) + ')');
  MakeButtongroupItems;
end;

procedure TKRadiobuttonGroup.DeleteWidget;
begin
  for var I := 0 to FItems.Count - 1 do
  begin
    Partner.DeleteAttributeValues(RBName(I));
    Partner.DeleteAttributeValues(RBName(I) + 'CV');
  end;
  inherited;
end;

procedure TKRadiobuttonGroup.SetItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then
  begin
    FOldItems.Text := FItems.Text;
    FItems.Text := Value.Text;
    Invalidate;
  end;
end;

procedure TKRadiobuttonGroup.SetColumns(Value: Integer);
begin
  if (FColumns <> Value) and (Value > 0) then
  begin
    FColumns := Value;
    Invalidate;
  end;
end;

procedure TKRadiobuttonGroup.SetLabel(Value: string);
begin
  if FLabel <> Value then
  begin
    FLabel := Value;
    Invalidate;
  end;
end;

procedure TKRadiobuttonGroup.SetCheckboxes(Value: Boolean);
begin
  if FCheckboxes <> Value then
  begin
    FCheckboxes := Value;
    Invalidate;
  end;
end;

function TKRadiobuttonGroup.ItemsInColumn(Num: Integer): Integer;
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

procedure TKRadiobuttonGroup.Paint;
const
  CRadius = 5;
var
  ColumnWidth, RowWidth, RadioHeight, LabelHeight, Col, Row, YPosC, ItemsInCol,
    Line, XPos, YPos, TextHeight, Radius: Integer;
  ARect: TRect;
  Str: string;
begin
  FOldItems.Text := FItems.Text;
  inherited;
  Radius := PPIScale(CRadius);
  Canvas.FillRect(ClientRect);
  TextHeight := Canvas.TextHeight('Hg');
  LabelHeight := 0;
  RadioHeight := Height;
  ARect := ClientRect;
  if FLabel <> '' then
  begin
    ARect.Top := TextHeight div 2;
    LabelHeight := TextHeight;
    RadioHeight := Height - TextHeight;
    Canvas.Rectangle(ARect);
    Canvas.TextOut(PPIScale(10), 0, FLabel);
  end;

  if FItems.Count > 0 then
  begin
    ColumnWidth := Width div FColumns;
    RowWidth := RadioHeight div ItemsInColumn(1);
    Line := 0;
    for Col := 1 to FColumns do
    begin
      ItemsInCol := ItemsInColumn(Col);
      for Row := 1 to ItemsInCol do
      begin
        XPos := PPIScale(4) + (Col - 1) * ColumnWidth;
        YPos := LabelHeight + 2 + (Row - 1) * RowWidth;
        Canvas.Brush.Color := clWhite;
        if FCheckboxes then
        begin
          ARect := Rect(XPos, YPos + PPIScale(6), XPos + PPIScale(13),
            YPos + PPIScale(19));
          Canvas.Rectangle(ARect);
        end
        else
        begin
          YPosC := YPos + RowWidth div 2 - Radius;
          Canvas.Ellipse(XPos, YPosC, XPos + 2 * Radius, YPosC + 2 * Radius);
        end;
        Canvas.Brush.Color := clBtnFace;

        YPosC := YPos + RowWidth div 2 - TextHeight div 2;
        ARect := Rect(XPos + PPIScale(19), YPosC, Col * ColumnWidth,
          YPosC + RowWidth);
        Str := FItems[Line];
        Canvas.TextRect(ARect, Str);
        Inc(Line);
      end;
    end;
  end;
end;

end.
