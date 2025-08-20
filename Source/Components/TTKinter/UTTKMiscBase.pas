{ -------------------------------------------------------------------------------
  Unit:     UTTKMiscBase
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  TKKinter misc widgets
  ------------------------------------------------------------------------------- }

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
  Classes,
  UTTKWidgets;

type

  // positioning of text, used in TextWidget
  TLabelAnchor = (_TL_nw, _TL_n, _TL_ne, _TL_en, _TL_e, _TL_es, _TL_se, _TL_s,
    _TL_sw, _TL_ws, _TL_w, _TL_wn);

  TOrient = (horizontal, vertical);

  TCompound = (_TC_top, _TC_bottom);

  TButtonState = (active, disabled, normal);

  TType = (_TT_menubar, _TT_normal); // normal is used in TButtonState

  TSelectMode = (extended, browse, none);

  TMode = (determinate, indeterminate);

  TTKMiscBaseWidget = class(TTKWidget)
  private
    FOrient: TOrient;
    procedure SetOrient(Value: TOrient);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure MakeFont; override;
    property Background;
    property Orient: TOrient read FOrient write SetOrient;
  end;

  TTKFrame = class(TTKMiscBaseWidget)
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
  published
    property Background;
    property BorderWidth;
    property Padding;
    property Relief;
  end;

  TTKLabelframe = class(TTKFrame)
  private
    FLabelAnchor: TLabelAnchor;
    FLabelWidget: string;
    procedure SetLabelAnchor(Value: TLabelAnchor);
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure Paint; override;
  published
    property LabelAnchor: TLabelAnchor read FLabelAnchor write SetLabelAnchor
      default _TL_nw;
    property LabelWidget: string read FLabelWidget write FLabelWidget;
    property Text;
    property Underline;
  end;

  TTKScale = class(TTKMiscBaseWidget)
  private
    FFrom: Real;
    FState: TButtonState;
    FTo: Real;
    FValue: Real;
    procedure SetRValue(Value: Real);
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeCommand(const Attr, Value: string); override;
    function GetWidgetStylename: string; override;
    procedure Paint; override;
  published
    property Command;
    property From: Real read FFrom write FFrom;
    property Orient;
    property State: TButtonState read FState write FState default normal;
    property TakeFocus;
    property To_: Real read FTo write FTo;
    property Value: Real read FValue write SetRValue;
  end;

  TTKLabeledScale = class(TTKMiscBaseWidget)
  private
    FCompound: TCompound;
    FFrom: Real;
    FState: TButtonState;
    FTo: Real;
    FValue: Real;
    procedure SetRValue(Value: Real);
    procedure SetCompound(Value: TCompound);
    procedure SetConfiguration;
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeCommand(const Attr, Value: string); override;
    procedure Paint; override;
  published
    property BorderWidth;
    property Command;
    property Compound: TCompound read FCompound write SetCompound
      default _TC_top;
    property From: Real read FFrom write FFrom;
    property Relief;
    property State: TButtonState read FState write FState default normal;
    property TakeFocus;
    property To_: Real read FTo write FTo;
    property Value: Real read FValue write SetRValue;
  end;

  TTKScrollbar = class(TTKMiscBaseWidget)
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeCommand(const Attr, Value: string); override;
    function GetWidgetStylename: string; override;
    procedure Paint; override;
  published
    property Command;
    property Orient;
  end;

  TTKPanedWindow = class(TTKMiscBaseWidget)
  private
    procedure PaintSlashAt(Pos: Integer);
    function GetPos(Num: Integer): Integer;
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure Resize; override;
    procedure Paint; override;
  published
    property Orient;
  end;

  TTKRadiobuttonGroup = class(TTKMiscBaseWidget)
  private
    FColumns: Integer;
    FLabel: string;
    FItems: TStrings;
    FOldItems: TStrings;
    FCheckboxes: Boolean;
    procedure SetColumns(Value: Integer);
    procedure SetLabel(const Value: string);
    procedure SetItems(Value: TStrings);
    procedure SetCheckboxes(Value: Boolean);
    procedure ChangeCommand(const Value: string);
    procedure MakeButtongroupItems;
    procedure MakeLabel(const ALabel: string);
    function ItemsInColumn(Num: Integer): Integer;
    function RBName(Num: Integer): string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure MakeCommand(const Attr, Value: string); override;
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

  TTKNotebook = class(TTKMiscBaseWidget)
  private
    FTabs: TStrings;
    FOldTabs: TStrings;
    procedure SetTabs(Value: TStrings);
    procedure MakeTabs;
    function TabName(Num: Integer): string;
    procedure DeleteTabs;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  published
    property Tabs: TStrings read FTabs write SetTabs;
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
    procedure SetColumns(Value: TStrings);
    procedure SetDisplayColumns(const Value: string);
    procedure SetItems(Value: TStrings);
    procedure SetShowHeadings(Value: Boolean);
    procedure MakeColumns;
    procedure MakeItems;
    function ColumnId(Num: Integer): string;
    procedure DeleteColumns;
    function HasSubNodes(Num: Integer): Boolean;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure DeleteWidget; override;
    function GetWidgetStylename: string; override;
    procedure Paint; override;
  published
    property Columns: TStrings read FColumns write SetColumns;
    property DisplayColumns: string read FDisplayColumns
      write SetDisplayColumns;
    property Items: TStrings read FItems write SetItems;
    property SelectMode: TSelectMode read FSelectMode write FSelectMode
      default extended;
    property ShowHeadings: Boolean read FShowHeadings write SetShowHeadings
      default True;
    property Padding;
    property Scrollbars;
    property TakeFocus;
  end;

  TTKProgressbar = class(TTKMiscBaseWidget)
  private
    FMaximum: Real;
    FMode: TMode;
    FValue: Real;
    procedure SetRValue(Value: Real);
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
    function GetWidgetStylename: string; override;
  published
    property Maximum: Real read FMaximum write FMaximum;
    property Mode: TMode read FMode write FMode default determinate;
    property Orient;
    property Value: Real read FValue write SetRValue;
  end;

  TTKSeparator = class(TTKMiscBaseWidget)
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property Orient;
  end;

  TTKSizeGrip = class(TTKMiscBaseWidget)
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure Paint; override;
    procedure SetPositionAndSize; override;
  end;

implementation

uses
  Math,
  Windows,
  Controls,
  Graphics,
  SysUtils,
  JvGnugettext,
  StringResources,
  UBaseTKWidgets,
  UUtils,
  UConfiguration;

{ --- TButtonBaseWidget -------------------------------------------------------- }

constructor TTKMiscBaseWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FOrient := vertical;
  Width := 120;
  Height := 80;
end;

function TTKMiscBaseWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TTKMiscBaseWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetMouseEvents(ShowEvents);
end;

procedure TTKMiscBaseWidget.MakeFont;
begin
  // no font
end;

procedure TTKMiscBaseWidget.SetOrient(Value: TOrient);
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

{ --- TTKFrame ------------------------------------------------------------------ }

constructor TTKFrame.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 43;
  ControlStyle := [csAcceptsControls];
end;

procedure TTKFrame.NewWidget(const Widget: string = '');
begin
  if Widget = '' then
    inherited NewWidget('ttk.Frame')
  else
    inherited NewWidget(Widget); // for LabelFrame
end;

function TTKFrame.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Background';
  if ShowAttributes >= 3 then
    Result := Result + '|Padding';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKFrame.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Background' then
  begin
    Style := Name + '.TFrame';
    var
    Str := 'ttk.Style().configure(' + AsString(Style);
    SetAttributValue(Str, Str + ', background = ' + AsString(Value) + ')');
    Str := 'self.' + Name + '[''style'']';
    SetAttributValue(Str, Str + ' = ' + AsString(Style));
    UpdateObjectInspector;
  end
  else
    inherited;
end;

{ --- TTKLabelframe ------------------------------------------------------------------ }

constructor TTKLabelframe.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 44;
  FLabelAnchor := _TL_nw;
  Relief := _TR_solid;
end;

procedure TTKLabelframe.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.LabelFrame');
end;

function TTKLabelframe.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|LabelAnchor|Text|Underline';
  if ShowAttributes >= 2 then
    Result := Result + '';
  if ShowAttributes >= 3 then
    Result := Result + '|LabelWidget';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKLabelframe.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'LabelWidget' then
    inherited SetAttribute(Attr, Value, 'Source')
  else
    inherited;
end;

procedure TTKLabelframe.SetLabelAnchor(Value: TLabelAnchor);
begin
  if FLabelAnchor <> Value then
  begin
    FLabelAnchor := Value;
    Invalidate;
  end;
end;

procedure TTKLabelframe.Paint;
var
  TextWidth, TextWidthR, TextHeight, TextHeightS, BorderWidth, XPos,
    YPos: Integer;
  ARect: TRect;
  Str: string;
begin
  inherited;
  ARect := ClientRect;
  Canvas.FillRect(ARect); // remove border
  TextWidth := Canvas.TextWidth(Text);
  TextWidthR := Max((TextWidth - BorderWidthInt) div 2, 0);
  TextHeight := Canvas.TextHeight('Hg');
  TextHeightS := Max((TextHeight - BorderWidthInt) div 2, 0);
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
  Canvas.Pen.Color := $DCDCDC;
  PaintBorder(ARect, Relief, BorderWidthInt);
  BorderWidth := BorderWidthInt;
  case FLabelAnchor of
    _TL_nw:
      begin
        XPos := BorderWidth + 4;
        YPos := 0;
      end;
    _TL_n:
      begin
        XPos := (Width - TextWidth) div 2;
        YPos := 0;
      end;
    _TL_ne:
      begin
        XPos := Width - BorderWidth - 4 - TextWidth;
        YPos := 0;
      end;
    _TL_en:
      begin
        XPos := Width - TextWidth - 1;
        YPos := BorderWidth + 4;
      end;
    _TL_e:
      begin
        XPos := Width - TextWidth - 1;
        YPos := (Height - TextHeight) div 2;
      end;
    _TL_es:
      begin
        XPos := Width - TextWidth - 1;
        YPos := Height - BorderWidth - 4 - TextHeight;
      end;
    _TL_se:
      begin
        XPos := Width - BorderWidth - 4 - TextWidth;
        YPos := Height - TextHeight - 1;
      end;
    _TL_s:
      begin
        XPos := (Width - TextWidth) div 2;
        YPos := Height - TextHeight - 1;
      end;
    _TL_sw:
      begin
        XPos := BorderWidth + 4;
        YPos := Height - TextHeight - 1;
      end;
    _TL_ws:
      begin
        XPos := 0;
        YPos := Height - BorderWidth - 4 - TextHeight;
      end;
    _TL_w:
      begin
        XPos := 0;
        YPos := (Height - TextHeight) div 2;
      end;
  else
    begin
      XPos := 0;
      YPos := BorderWidth + 4;
    end; // _TL_wn:
  end;
  ARect := Rect(XPos, YPos, XPos + TextWidth, YPos + TextHeight);
  Str := Text;
  if Underline >= 0 then
    Insert('&', Str, Underline + 1);
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_LEFT);
end;

{ --- TTKScale ------------------------------------------------------------------ }

constructor TTKScale.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 45;
  Width := 120;
  Height := 32;
  FOrient := horizontal;
  FFrom := 0;
  FTo := 100;
  FValue := 30;
  FState := normal;
end;

function TTKScale.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|From|To_|Orient|Value';
  if ShowAttributes >= 2 then
    Result := Result + '|Command';
  if ShowAttributes = 3 then
    Result := Result + '|State';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKScale.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else if Attr = 'To_' then
    inherited SetAttribute('To', Value, Typ)
  else
    inherited;
end;

procedure TTKScale.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Scale');
  MakeControlVar('variable', Name + 'CV', IntToStr(Round(FValue)), 'Int');
  SetAttribute('To', '100', '');
end;

procedure TTKScale.MakeCommand(const Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x');
end;

function TTKScale.GetWidgetStylename: string;
begin
  if FOrient = horizontal then
    Result := Name + '.Horizontal.TScale'
  else
    Result := Name + '.Vertical.TScale';
end;

procedure TTKScale.Paint;
var
  XPos, YPos, AValue, SliderWidth, SliderHeight, UsablePixels: Integer;
  ARect: TRect;
begin
  inherited; // Length??
  // track
  if FOrient = horizontal then
  begin
    ARect.Left := 1;
    ARect.Right := Width - 1;
    ARect.Top := Height div 2 - 1;
    ARect.Bottom := ARect.Top + PPIScale(3);
    SliderWidth := PPIScale(12);
    SliderHeight := PPIScale(23);
    UsablePixels := Width - PPIScale(2) - SliderWidth;
  end
  else
  begin
    ARect.Top := 1;
    ARect.Bottom := Height - 1;
    ARect.Left := Width div 2 - 1;
    ARect.Right := ARect.Left + PPIScale(3);
    SliderWidth := PPIScale(23);
    SliderHeight := PPIScale(12);
    UsablePixels := Height - PPIScale(2) - SliderHeight;
  end;
  Canvas.Pen.Color := $D6D6D6;
  Canvas.Rectangle(ARect);

  // slider
  AValue := Round(UsablePixels * (FValue - FFrom) / (FTo - FFrom)) + 1;
  if FOrient = horizontal then
  begin
    XPos := Round(AValue);
    YPos := Height div 2 - SliderHeight div 2;
    ARect := Rect(XPos, YPos, XPos + SliderWidth, YPos + SliderHeight);
  end
  else
  begin
    XPos := Width div 2 - SliderWidth div 2;
    YPos := Round(AValue);
    ARect := Rect(XPos, YPos, XPos + SliderWidth, YPos + SliderHeight);
  end;
  Canvas.Brush.Color := $D97A00;
  Canvas.FillRect(ARect);
end;

procedure TTKScale.SetRValue(Value: Real);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    if FValue > FTo then
      FValue := FTo
    else if FValue < FFrom then
      FValue := FFrom;
    Invalidate;
  end;
end;

{ --- TTKLabeledScale ---------------------------------------------------------- }

constructor TTKLabeledScale.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 46;
  Width := 120;
  Height := 48;
  FCompound := _TC_top;
  FFrom := 0;
  FTo := 100;
  FValue := 0;
  FState := normal;
  FNameExtension := '.scale';
end;

function TTKLabeledScale.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Compound|From|To_|Value';
  if ShowAttributes >= 2 then
    Result := Result + '|Command';
  if ShowAttributes = 3 then
    Result := Result + '|Padding|State';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKLabeledScale.SetAttribute(const Attr, Value, Typ: string);
var
  Str: string;
  Posi: Integer;
begin
  if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else if (Attr = 'Compound') or (Attr = 'From') or (Attr = 'To_') then
    SetConfiguration
  else if (Attr = 'BorderWidth') or (Attr = 'Relief') then
  begin
    Str := GetAttrAsKey(Attr);
    Posi := Pos(FNameExtension, Str);
    Delete(Str, Posi, Length(FNameExtension));
    if Value = '' then
      Partner.DeleteAttribute(Str)
    else
      SetAttributValue(Str, Str + ' = ' + AsString(Value));
  end
  else
    inherited;
end;

procedure TTKLabeledScale.SetConfiguration;
var
  Str, Scomp: string;
begin
  if Compound = _TC_top then
    Scomp := AsString('top')
  else
    Scomp := AsString('bottom');
  Str := 'self.' + Name + ' = ttk.LabeledScale';
  SetAttributValue(Str, Str + '(variable=self.' + Name + 'CV, compound=' + Scomp
    + ', from_=' + FloatToStr(FFrom) + ', to=' + FloatToStr(FTo) + ')');
end;

procedure TTKLabeledScale.NewWidget(const Widget: string = '');
begin
  InsertValue('self.' + Name + 'CV = tk.IntVar()');
  inherited NewWidget('ttk.LabeledScale');
  SetConfiguration;
end;

procedure TTKLabeledScale.MakeCommand(const Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x');
end;

procedure TTKLabeledScale.Paint;
var
  XPos, YPos, AValue, SliderWidth, SliderHeight, UsablePixels, TextWidth,
    TextHeight: Integer;
  ARect: TRect;
  Str: string;
begin
  inherited;
  // track
  ARect.Left := 1;
  ARect.Right := Width - 1;
  if FCompound = _TC_top then
    ARect.Top := Height - PPIScale(15)
  else
    ARect.Top := PPIScale(12);
  ARect.Bottom := ARect.Top + PPIScale(3);
  SliderWidth := PPIScale(12);
  SliderHeight := PPIScale(23);
  UsablePixels := Width - 2 - SliderWidth;
  Canvas.Pen.Color := $D6D6D6;
  Canvas.Rectangle(ARect);

  // slider
  AValue := Round(UsablePixels * (FValue - FFrom) / (FTo - FFrom)) + 1;
  XPos := Round(AValue);
  YPos := ARect.Top + 1 - SliderHeight div 2;
  ARect := Rect(XPos, YPos, XPos + SliderWidth, YPos + SliderHeight);
  Canvas.Brush.Color := $D97A00;
  Canvas.FillRect(ARect);

  // Label
  Str := IntToStr(Round(FValue));
  TextWidth := Canvas.TextWidth(Str);
  TextHeight := Canvas.TextHeight(Str);
  XPos := ARect.Left + (ARect.Right - ARect.Left - TextWidth) div 2;
  if FCompound = _TC_top then
    YPos := ARect.Top - TextHeight - PPIScale(3)
  else
    YPos := ARect.Bottom + PPIScale(3);
  Canvas.Brush.Color := clBtnFace;
  Canvas.TextOut(XPos, YPos, Str);
end;

procedure TTKLabeledScale.SetRValue(Value: Real);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    if FValue > FTo then
      FValue := FTo
    else if FValue < FFrom then
      FValue := FFrom;
    Invalidate;
  end;
end;

procedure TTKLabeledScale.SetCompound(Value: TCompound);
begin
  if FCompound <> Value then
  begin
    FCompound := Value;
    Invalidate;
  end;
end;

{ --- TTKScrollbar -------------------------------------------------------------- }

constructor TTKScrollbar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 42;
  Width := 120;
  Height := 20;
  FOrient := horizontal;
end;

function TTKScrollbar.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Command|Orient';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKScrollbar.MakeCommand(const Attr, Value: string);
begin
  inherited;
  AddParameter(Value, 'x, y, z');
end;

procedure TTKScrollbar.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Scrollbar');
  InsertValue('self.' + Name + '[''orient''] = ' + AsString('horizontal'));
end;

function TTKScrollbar.GetWidgetStylename: string;
begin
  if FOrient = horizontal then
    Result := Name + '.Horizontal.TScrollbar'
  else
    Result := Name + '.Vertical.TScrollbar';
end;

procedure TTKScrollbar.Paint;
begin
  PaintScrollbar(ClientRect, FOrient = horizontal, True);
end;

{ --- PanedWindow -------------------------------------------------------------- }

constructor TTKPanedWindow.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 47;
  ControlStyle := [csAcceptsControls];
  Orient := vertical;
end;

procedure TTKPanedWindow.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.PanedWindow');
end;

function TTKPanedWindow.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Orient';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKPanedWindow.PaintSlashAt(Pos: Integer);
var
  ARect: TRect;
begin
  if FOrient = horizontal then
    ARect := Rect(Pos - 2, 0, Pos + 2, Height)
  else
    ARect := Rect(0, Pos - 2, 2, Pos + 2);
  Canvas.Brush.Color := Background;
  Canvas.FillRect(ARect);
end;

function TTKPanedWindow.GetPos(Num: Integer): Integer;
var
  SashW: Integer;
  ControlW: Real;
begin
  SashW := 5;
  if ControlCount > 0 then
    if FOrient = horizontal then
      ControlW := (Width - (ControlCount - 1) * SashW) / (ControlCount * 1.0)
    else
      ControlW := (Height - (ControlCount - 1) * SashW) / (ControlCount * 1.0)
  else
    ControlW := 0;
  Result := Round(Num * ControlW + (Num - 1) * SashW + SashW div 2);
end;

procedure TTKPanedWindow.Paint;
var
  ARect: TRect;
begin
  inherited;
  ARect := ClientRect;
  Canvas.Brush.Color := Background;
  Canvas.FillRect(ARect);
  if ControlCount > 1 then
    for var I := 1 to ControlCount - 1 do
      PaintSlashAt(GetPos(I))
  else
    PaintSlashAt(GetPos(1)); // to show a slider in the gui form
end;

procedure TTKPanedWindow.Resize;
var
  CWidth, CHeight: Integer;
begin
  if Orient = horizontal then
  begin
    if ControlCount > 1 then
    begin
      CWidth := GetPos(1) - 2;
      Controls[0].SetBounds(0, 0, CWidth, Height);
      for var I := 1 to ControlCount - 1 do
        Controls[I].SetBounds(GetPos(I) + 2, 0, CWidth, Height);
      Controls[ControlCount - 1].SetBounds(GetPos(ControlCount - 1) + 2, 0,
        CWidth, Height);
    end
    else if ControlCount = 1 then
      Controls[0].SetBounds(0, 0, Width, Height);
  end
  else
  begin
    if ControlCount > 1 then
    begin
      CHeight := GetPos(1) - 2;
      Controls[0].SetBounds(0, 0, Width, CHeight);
      for var I := 1 to ControlCount - 1 do
        Controls[I].SetBounds(0, GetPos(I) + 2, Width, CHeight);
      Controls[ControlCount - 1].SetBounds(0, GetPos(ControlCount - 1) + 2,
        Width, CHeight);
    end
    else if ControlCount = 1 then
      Controls[0].SetBounds(0, 0, Width, Height);
  end;
end;

{ --- TKRadiobuttonGroup ------------------------------------------------------- }

constructor TTKRadiobuttonGroup.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 37;
  FColumns := 1;
  FItems := TStringList.Create;
  FOldItems := TStringList.Create;
  FLabel := ' ' + _('Continent') + ' ';
end;

destructor TTKRadiobuttonGroup.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TTKRadiobuttonGroup.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Columns|Command|Items|Label_|Name|Checkboxes';
  if ShowAttributes = 3 then
    Result := Result + '|Height|Width|Left|Top';
end;

procedure TTKRadiobuttonGroup.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Command' then
    ChangeCommand(Value)
  else if Attr = 'Items' then
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
  else if Attr = 'Checkboxes' then
    MakeButtongroupItems
  else if IsFontAttribute(Attr) then
  begin
    if Label_ <> '' then
      inherited;
    MakeButtongroupItems;
  end
  else
    inherited;
end;

function TTKRadiobuttonGroup.RBName(Num: Integer): string;
begin
  Result := 'self.' + Name + 'RB' + IntToStr(Num);
end;

procedure TTKRadiobuttonGroup.MakeButtongroupItems;
var
  Key, Options, Str: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  for var I := 0 to FOldItems.Count - 1 do
  begin
    Partner.DeleteAttributeValues(RBName(I));
    Partner.DeleteAttributeValues(RBName(I) + 'CV');
  end;
  Partner.DeleteAttributeValues('self.' + Name + '[''variable'']');

  Str := '';
  for var I := 0 to FItems.Count - 1 do
  begin
    Key := AsString(FItems[I]);
    if FCheckboxes then
    begin
      Options := 'self.' + Name + ', text=' + Key;
      Str := Str + Surround(RBName(I) + ' = ttk.Checkbutton(' + Options + ')') +
        Surround(RBName(I) + '.place(x=0, y=0, width=0, height=0)') +
        Surround(RBName(I) + 'CV = tk.IntVar()') +
        Surround(RBName(I) + '[''variable''] = ' + RBName(I) + 'CV') +
        Surround(RBName(I) + 'CV.set(0)');
    end
    else
    begin
      Options := 'self.' + Name + ', text=' + Key + ', value=' + Key;
      Str := Str + Surround(RBName(I) + ' = ttk.Radiobutton(' + Options + ')') +
        Surround(RBName(I) + '.place(x=0, y=0, width=0, height=0)') +
        Surround(RBName(I) + '[''variable''] = self.' + Name + 'CV');
    end;
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
  FOldItems.Text := FItems.Text;
  SetPositionAndSize;
end;

procedure TTKRadiobuttonGroup.SetPositionAndSize;
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
          YPos := 0 // TextHeight in Qt?
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

procedure TTKRadiobuttonGroup.MakeCommand(const Attr, Value: string);
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

procedure TTKRadiobuttonGroup.ChangeCommand(const Value: string);
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

procedure TTKRadiobuttonGroup.MakeLabel(const ALabel: string);
begin
  FLabel := ALabel;
  var
  Key := 'self.' + Name + ' = ';
  if ALabel = '' then
  begin
    Partner.ReplaceLine(Key, Indent2 + Key + 'ttk.Frame()');
    Partner.DeleteAttribute('self.' + Name + '[''text'']');
  end
  else
  begin
    Partner.ReplaceLine(Key, Indent2 + Key + 'ttk.LabelFrame()');
    Key := 'self.' + Name + '[''text'']';
    SetAttributValue(Key, Key + ' = ' + AsString(FLabel));
  end;
  SetPositionAndSize;
end;

procedure TTKRadiobuttonGroup.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Frame');
  MakeLabel(' ' + _('Continent') + ' ');
  FItems.Text := DefaultItems;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + AsString(FItems[0]) + ')');
  MakeButtongroupItems;
end;

procedure TTKRadiobuttonGroup.DeleteWidget;
begin
  for var I := 0 to FItems.Count - 1 do
  begin
    Partner.DeleteAttributeValues(RBName(I));
    Partner.DeleteAttributeValues(RBName(I) + 'CV');
  end;
  inherited;
end;

procedure TTKRadiobuttonGroup.SetItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then
  begin
    FOldItems.Text := FItems.Text;
    FItems.Text := Value.Text;
    Invalidate;
  end;
end;

procedure TTKRadiobuttonGroup.SetColumns(Value: Integer);
begin
  if (FColumns <> Value) and (Value > 0) then
  begin
    FColumns := Value;
    Invalidate;
  end;
end;

procedure TTKRadiobuttonGroup.SetLabel(const Value: string);
begin
  if FLabel <> Value then
  begin
    FLabel := Value;
    Invalidate;
  end;
end;

procedure TTKRadiobuttonGroup.SetCheckboxes(Value: Boolean);
begin
  if FCheckboxes <> Value then
  begin
    FCheckboxes := Value;
    Invalidate;
  end;
end;

function TTKRadiobuttonGroup.ItemsInColumn(Num: Integer): Integer;
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

procedure TTKRadiobuttonGroup.Paint;
const
  CRadius = 5;
var
  ColumnWidth, RowWidth, RadioHeight, LabelHeight, Col, Row, YCenter,
    ItemsInCol, Line, XPos, YPos, TextHeight, Radius: Integer;
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
          YCenter := YPos + RowWidth div 2 - Radius;
          Canvas.Ellipse(XPos, YCenter, XPos + 2 * Radius,
            YCenter + 2 * Radius);
        end;
        Canvas.Brush.Color := clBtnFace;
        YCenter := YPos + RowWidth div 2 - TextHeight div 2;
        ARect := Rect(XPos + PPIScale(15), YCenter, Col * ColumnWidth,
          YCenter + RowWidth);
        Str := FItems[Line];
        Canvas.TextRect(ARect, Str);
        Inc(Line);
      end;
    end;
  end;
end;

{ --- TTKNotebook -------------------------------------------------------------- }

constructor TTKNotebook.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 50;
  FTabs := TStringList.Create;
  FTabs.Text := 'Tab 1'#13#10'Tab 2'#13#10'Tab 3';
  FOldTabs := TStringList.Create;
end;

destructor TTKNotebook.Destroy;
begin
  FreeAndNil(FTabs);
  FreeAndNil(FOldTabs);
  inherited;
end;

function TTKNotebook.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Padding|Tabs';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKNotebook.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Tabs' then
    MakeTabs
  else
    inherited;
end;

function TTKNotebook.TabName(Num: Integer): string;
begin
  Result := 'self.' + Name + 'Tab' + IntToStr(Num);
end;

procedure TTKNotebook.DeleteWidget;
begin
  inherited;
  DeleteTabs;
end;

procedure TTKNotebook.DeleteTabs;
begin
  var
  All := Max(FOldTabs.Count - 1, FTabs.Count - 1);
  for var I := 0 to All do
    Partner.DeleteAttributeValues(TabName(I));
end;

procedure TTKNotebook.MakeTabs;
var
  Str: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  DeleteTabs;
  Str := '';
  for var I := 0 to FTabs.Count - 1 do
  begin
    Str := Str + Surround(TabName(I) + ' = ttk.Frame(self.' + Name + ')');
    Str := Str + Surround('self.' + Name + '.add(' + TabName(I) + ', text=' +
      AsString(FTabs[I]) + ')');
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKNotebook.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Notebook');
  MakeTabs;
end;

procedure TTKNotebook.SetTabs(Value: TStrings);
begin
  FOldTabs.Text := FTabs.Text;
  FTabs.Text := Value.Text;
  Invalidate;
end;

procedure TTKNotebook.Paint;
var
  PaddingL, PaddingT, PaddingR, PaddingB, TextWidth, TextHeight, XPos,
    YPos: Integer;
  ARect: TRect;
  Str: string;
begin
  Background := clBtnFace;
  inherited;
  CalculatePadding(PaddingL, PaddingT, PaddingR, PaddingB);
  Canvas.Pen.Color := $D9D9D9;
  Canvas.MoveTo(PaddingL, PaddingT);
  Canvas.LineTo(PaddingL, Height - PaddingB);
  Canvas.LineTo(Width - PaddingR, Height - PaddingB);
  Canvas.LineTo(Width - PaddingR, PaddingT - 1);
  XPos := PaddingL;
  YPos := PaddingT;
  for var I := 0 to FTabs.Count - 1 do
  begin
    Str := FTabs[I];
    TextWidth := Canvas.TextWidth(Str) + 8;
    TextHeight := Canvas.TextHeight(Str) + 4;
    if I = 0 then
    begin
      Canvas.Brush.Color := clWindow;
      ARect := Rect(XPos, YPos, XPos + TextWidth, YPos + TextHeight + 2);
    end
    else
    begin
      Canvas.Brush.Color := $F0F0F0;
      ARect := Rect(XPos, YPos, XPos + TextWidth, YPos + TextHeight);
    end;
    Canvas.Rectangle(ARect);
    Canvas.TextOut(XPos + 4, YPos + 2, Str);
    XPos := XPos + TextWidth - 1;
    YPos := PaddingT + 2;
  end;
end;

{ --- TTKTreeview -------------------------------------------------------------- }

constructor TTKTreeview.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 51;
  FColumns := TStringList.Create;
  FColumns.Text := 'Items';
  FItems := TStringList.Create;
  FItems.Text :=
    'First'#13#10'  node A'#13#10'  node B'#13#10'Second'#13#10'   node C'#13#10'    node D';
  FOldItems := TStringList.Create;
  FShowHeadings := True;
end;

destructor TTKTreeview.Destroy;
begin
  FreeAndNil(FColumns);
  FreeAndNil(FItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TTKTreeview.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Columns|Items|Padding|Scrollbars';
  if ShowAttributes >= 2 then
    Result := Result + '|SelectMode|ShowHeadings';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKTreeview.SetAttribute(const Attr, Value, Typ: string);
var
  Key: string;
begin
  if Attr = 'Columns' then
    MakeColumns
  else if Attr = 'Items' then
  begin
    MakeItems;
    if FColumns.Text = '' then
      MakeColumns;
  end
  else if Attr = 'Scrollbars' then
    MakeScrollbars(Value, 'ttk.')
  else if Attr = 'ShowHeadings' then
  begin
    Key := GetAttrAsKey('Show');
    if Value = 'True' then
      Partner.DeleteAttribute(Key)
    else
      InsertValue(Key + ' = ' + AsString('tree')); // test
  end
  else
    inherited;
  if Attr = 'Padding' then
    MakeColumns;
end;

function TTKTreeview.ColumnId(Num: Integer): string;
begin
  Result := AsString('#' + IntToStr(Num));
end;

procedure TTKTreeview.DeleteWidget;
begin
  inherited;
  DeleteColumns;
end;

procedure TTKTreeview.DeleteColumns;
begin
  Partner.DeleteAttribute(GetAttrAsKey('Columns'));
  Partner.DeleteAttributeValues('self.' + Name + '.column');
  Partner.DeleteAttributeValues('self.' + Name + '.heading');
end;

procedure TTKTreeview.MakeColumns;
var
  AWidth, Count, PaddingL, PaddingT, PaddingR, PaddingB: Integer;
  Str, Str1: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  DeleteColumns;
  CalculatePadding(PaddingL, PaddingT, PaddingR, PaddingB);
  Str := '';
  Count := FColumns.Count;
  if Count = 0 then
  begin
    AWidth := Width - PaddingL - PaddingR - 2;
    Str := Str + Surround('self.' + Name + '.column(' + ColumnId(0) + ', width='
      + IntToStr(AWidth) + ')');
  end
  else
  begin
    Str1 := AsString(FColumns[0]);
    for var I := 1 to FColumns.Count - 1 do
      Str1 := Str1 + ', ' + AsString(FColumns[I]);
    Str1 := '(' + Str1 + ')';
    Str := Str + Surround(GetAttrAsKey('Columns') + ' = ' + Str1);
    UpdateObjectInspector;
    AWidth := (Width - PaddingL - PaddingR - 2) div Count;
    for var I := 0 to Count - 1 do
      Str := Str + Surround('self.' + Name + '.column(' + ColumnId(I) +
        ', width=' + IntToStr(AWidth) + ')');
    // hack
    if Count = 1 then
      Str := Str + Surround('self.' + Name + '.column(' + ColumnId(1) +
        ', width=0)');
    for var I := 0 to Count - 1 do
      Str := Str + Surround('self.' + Name + '.heading(' + ColumnId(I) +
        ', text=' + AsString(FColumns[I]) + ')');
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TTKTreeview.HasSubNodes(Num: Integer): Boolean;
begin
  Result := (Num < FItems.Count - 1) and
    (LeftSpaces(FItems[Num], 2) < LeftSpaces(FItems[Num + 1], 2));
end;

procedure TTKTreeview.MakeItems;
var
  Int, LeftSpac, Indent, NodeCount: Integer;
  Str: string;
  NodeId: array [-1 .. 10] of string;

  function MakeNode(Indent: Integer; Id: string = ''): string;
  var
    Str: string;
  begin
    Str := 'self.' + Name + '.insert(' + AsString(NodeId[Indent - 1]) + ', ' +
      AsString('end');
    if Id <> '' then
      Str := Str + ', ' + AsString(Id);
    Str := Str + ', text=' + AsString(Trim(FItems[Int])) + ')';
    Result := Surround(Str);
  end;

  function getNextNodeId: string;
  begin
    Inc(NodeCount);
    Result := 'Id' + IntToStr(NodeCount);
  end;

begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteAttributeValues('self.' + Name + '.insert');

  FormatItems(FItems);
  NodeCount := 0;
  NodeId[-1] := '';
  Indent := 0;
  // insert new items
  Int := 0;
  Str := '';
  while Int < Items.Count do
  begin
    LeftSpac := LeftSpaces(Items[Int], 2) div 2;
    if LeftSpac < Indent then
    begin // close open menus
      while Indent > LeftSpac do
        Dec(Indent);
      Dec(Int);
    end
    else if LeftSpac > Indent then
    begin
      Str := Str + MakeNode(Indent);
      Inc(Indent);
    end
    else if HasSubNodes(Int) then
    begin // create new node/subnode
      NodeId[Indent] := getNextNodeId;
      Str := Str + MakeNode(Indent, NodeId[Indent]);
      Inc(Indent);
    end
    else
      Str := Str + MakeNode(Indent);
    Inc(Int);
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKTreeview.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Treeview');
  MakeColumns;
  MakeItems;
end;

procedure TTKTreeview.SetItems(Value: TStrings);
begin
  if FItems.Text <> Value.Text then
  begin
    FOldItems.Text := FItems.Text;
    FItems.Text := Value.Text;
    Invalidate;
  end;
end;

procedure TTKTreeview.SetColumns(Value: TStrings);
begin
  if FColumns.Text <> Value.Text then
  begin
    FColumns.Text := Value.Text;
    Invalidate;
  end;
end;

procedure TTKTreeview.SetDisplayColumns(const Value: string);
begin
  if FDisplayColumns <> Value then
  begin
    FDisplayColumns := Value;
    Invalidate;
  end;
end;

procedure TTKTreeview.SetShowHeadings(Value: Boolean);
begin
  if FShowHeadings <> Value then
  begin
    FShowHeadings := Value;
    Invalidate;
  end;
end;

function TTKTreeview.GetWidgetStylename: string;
begin
  Result := Name + '.Treeview';
end;

procedure TTKTreeview.Paint;
var
  PaddingL, PaddingT, PaddingR, PaddingB, XPos, YPos, Int, Count,
    ColWidth: Integer;
  ARect: TRect;
  Str: string;
begin
  Background := clWindow;
  FOldItems.Text := FItems.Text;
  inherited;
  CalculatePadding(PaddingL, PaddingT, PaddingR, PaddingB);
  // headings
  ColWidth := Width - PaddingL - PaddingR - 2;
  Canvas.Pen.Color := $908782;
  Canvas.Rectangle(ClientRect);
  if FShowHeadings then
  begin
    Count := FColumns.Count;
    if Count > 1 then
    begin
      ColWidth := ColWidth div Count;
      Canvas.Pen.Color := $E5E5E5;
      for var I := 1 to Count - 1 do
      begin
        XPos := PaddingL + I * ColWidth;
        Canvas.MoveTo(XPos, 1);
        Canvas.LineTo(XPos, PPIScale(24));
      end;
    end;
    for var I := 0 to Count - 1 do
    begin
      XPos := PaddingL + I * ColWidth + 1;
      ARect := Rect(XPos, PPIScale(4), XPos + ColWidth, PPIScale(23));
      Str := FColumns[I];
      DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_CENTER);
    end;
    YPos := PPIScale(26);
  end
  else
    YPos := PPIScale(2);
  // nodes
  XPos := 1;
  Int := 0;
  while Int < FItems.Count do
  begin
    if LeftSpaces(FItems[Int], 2) = 0 then
    begin
      if HasSubNodes(Int) then
      begin
        ARect := Rect(XPos + PPIScale(5), YPos + PPIScale(6),
          XPos + PPIScale(14), YPos + PPIScale(15));
        Canvas.Pen.Color := $919191;
        Canvas.Rectangle(ARect);
        Canvas.Pen.Color := $724229;
        Canvas.MoveTo(XPos + PPIScale(9), YPos + PPIScale(8));
        Canvas.LineTo(XPos + PPIScale(9), YPos + PPIScale(13));
        Canvas.Pen.Color := $A7634B;
        Canvas.MoveTo(XPos + PPIScale(7), YPos + PPIScale(10));
        Canvas.LineTo(XPos + PPIScale(12), YPos + PPIScale(10));
      end;
      Str := FItems[Int];
      ARect := Rect(XPos + PPIScale(20), YPos + PPIScale(2),
        XPos + ColWidth - 1, YPos + PPIScale(22));
      DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_LEFT);
      YPos := YPos + PPIScale(20);
      if YPos + PPIScale(20) > Height - PaddingB then
        Int := FItems.Count;
    end;
    Inc(Int);
  end;
  PaintScrollbars(Scrollbars);
end;

{ --- TTKProgresbar ------------------------------------------------------------ }

constructor TTKProgressbar.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 52;
  Width := 120;
  Height := 24;
  FOrient := horizontal;
  FMaximum := 100;
  FMode := determinate;
  FValue := 30;
end;

function TTKProgressbar.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Maximum|Orient|Value';
  if ShowAttributes >= 2 then
    Result := Result + '|Mode';
  if ShowAttributes = 3 then
    Result := Result + '';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKProgressbar.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else
    inherited;
end;

procedure TTKProgressbar.NewWidget(const Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Progressbar');
  MakeControlVar('variable', Name + 'CV', FloatToStr(FValue), 'Double');
  Partner.ActiveSynEdit.EndUpdate;
end;

function TTKProgressbar.GetWidgetStylename: string;
begin
  if FOrient = horizontal then
    Result := Name + '.Horizontal.TProgressbar'
  else
    Result := Name + '.Vertical.TProgressbar';
end;

procedure TTKProgressbar.Paint;
var
  XPos, YPos: Integer;
  ARect: TRect;
begin
  inherited;
  Canvas.Pen.Color := $BCBCBC;
  Canvas.Brush.Color := $E6E6E6;
  ARect := ClientRect;
  Canvas.Rectangle(ARect);
  ARect.Inflate(-3, -3);
  if FOrient = horizontal then
  begin
    XPos := Round((Width - 6) * FValue / FMaximum);
    ARect.Right := ARect.Left + XPos;
  end
  else
  begin
    YPos := Round((Height - 6) * FValue / FMaximum);
    ARect.Top := ARect.Bottom - YPos;
  end;
  Canvas.Brush.Color := $25B006;
  Canvas.FillRect(ARect);
end;

procedure TTKProgressbar.SetRValue(Value: Real);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

{ --- TTKSeparator ------------------------------------------------------------- }

constructor TTKSeparator.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 53;
  Width := 120;
  Height := 2;
  FOrient := horizontal;
end;

function TTKSeparator.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Orient';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKSeparator.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Separator');
end;

procedure TTKSeparator.Paint;
begin
  inherited;
  Canvas.Pen.Color := $A0A0A0;
  Canvas.MoveTo(0, 0);
  if FOrient = horizontal then
  begin
    Canvas.LineTo(Width + 1, 0);
    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(0, 1);
    Canvas.LineTo(Width + 1, 1);
  end
  else
  begin
    Canvas.LineTo(0, Height + 1);
    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(1, 0);
    Canvas.LineTo(1, Height + 1);
  end;
end;

{ --- TTKSizeGrip -------------------------------------------------------------- }

constructor TTKSizeGrip.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 54;
  Width := 14;
  Height := 14;
end;

procedure TTKSizeGrip.NewWidget(const Widget: string = '');
begin
  InsertValue('self.' + Name + ' = ttk.Sizegrip(' + GetContainer + ')');
  InsertValue('self.' + Name + '.pack(side=' + AsString('right') + ', anchor=' +
    AsString('se') + ')');
end;

function TTKSizeGrip.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Name';
end;

procedure TTKSizeGrip.Paint;
var
  Int3, Int14: Integer;
  ARect: TRect;
begin
  Int14 := PPIScale(14);
  Int3 := PPIScale(3);
  SetBounds(Parent.ClientWidth - Int14, Parent.ClientHeight - Int14,
    Int14, Int14);
  inherited;
  Canvas.Brush.Color := $BFBFBF;
  ARect := Rect(ClientWidth - PPIScale(11), ClientHeight - PPIScale(5),
    ClientWidth - PPIScale(9), ClientHeight - Int3);
  Canvas.FillRect(ARect);
  ARect.Offset(Int3, 0);
  Canvas.FillRect(ARect);
  ARect.Offset(Int3, 0);
  Canvas.FillRect(ARect);
  ARect.Offset(0, -Int3);
  Canvas.FillRect(ARect);
  ARect.Offset(0, -Int3);
  Canvas.FillRect(ARect);
  ARect.Offset(-Int3, +Int3);
  Canvas.FillRect(ARect);
end;

procedure TTKSizeGrip.SetPositionAndSize;
begin
  // do nothing
end;

end.
