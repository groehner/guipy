{-------------------------------------------------------------------------------
 Unit:     UQtButtonBase
 Author:   Gerhard Röhner
 Date:     April 2022
 Purpose:  PyQt button widgets
-------------------------------------------------------------------------------}
unit UQtButtonBase;

{ class hierarchy

  TQtAbstractButton
    TQtPushButton
      TQtCommandLinkButton
    TQtToolButton
    TQtRadioButton
    TQtCheckBox
}


interface

uses
  Windows, Graphics, Classes, UBaseQtWidgets;

type

  TPopopMode = (DelayedPopup, MenuButton_Popup, InstantPopup);

  TToolButtonStyle = (ToolButtonIconOnly, ToolButtonTextOnly,
                      ToolButtonTextBesideIcon, ToolButtonTextUnderIcon,
                      ToolButtonFollowStyle);

  TArrowType = (NoArrow, UpArrow, DownArrow, LeftArrow, RightArrow);

  TQtAbstractButton = class(TBaseQtWidget)
  private
    FText: string;
    FIcon: string;
    // IconSize?
    FShortcut: string;
    FCheckable: boolean;
    FChecked: boolean;
    FAutoRepeat: boolean;
    FAutoExclusive: boolean;
    FAutoRepeatDelay: integer;
    FAutoRepeatInterval: integer;
    FClicked: string;
    FPressed: string;
    FReleased: string;
    FToggled: string;
    procedure setText(Value: string);
    procedure setIcon(Value: string);
    procedure setChecked(value: boolean);
    procedure setClicked(value: string);
    function GetIconAsBitmap: TBitmap;
  protected
    PaintFlat: boolean;
    PaintStyle: integer;
    PaintArrow: integer;
    procedure MakeClickEvent;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure Paint; override;
    procedure MakeIcon(const Value: string);
    procedure MakeShortcut(const Value: string);
    procedure SizeToText; override;
  published
    property Font;
    property Text: string read FText write setText;
    property Icon: string read FIcon write setIcon;
    property Shortcut: string read FShortcut write FShortcut;
    property Checkable: boolean read FCheckable write FCheckable;
    property Checked: boolean read FChecked write setChecked;
    property AutoRepeat: boolean read FAutoRepeat write FAutoRepeat;
    property AutoExclusive: boolean read FAutoExclusive write FAutoExclusive;
    property AutoRepeatDelay: integer read FAutoRepeatDelay write FAutoRepeatDelay;
    property AutoRepeatInterval: integer read FAutoRepeatInterval write FAutoRepeatInterval;
    //signals
    property clicked: string read FClicked write setClicked;
    property pressed: string read FPressed write FPressed;
    property released: string read FReleased write FReleased;
    property toggled: string read FToggled write FToggled;
  end;

  TQtPushButton = class(TQtAbstractButton)
  private
    FAutoDefault: boolean;
    FDefault: boolean;
    FFlat: boolean;
    procedure setFlat(Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property AutoDefault: boolean read FAutoDefault write FAutoDefault;
    property Default_: boolean read FDefault write FDefault;
    property Flat: boolean read FFlat write setFlat;
  end;

  TQtToolButton = class(TQtAbstractButton)
  private
    FAutoRaise: boolean;
    FArrowType: TArrowType;
    FPopupMode: TPopopMode;
    FToolButtonStyle: TToolButtonStyle;
    FTriggered: string;
    procedure setArrowType(Value: TArrowType);
    procedure setAutoRaise(Value: boolean);
    procedure setToolButtonStyle(Value: TToolButtonStyle);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    function getEvents(ShowEvents: integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property PopupMode: TPopopMode read FPopupMode write FPopupMode;
    property ToolButtonStyle: TToolButtonStyle read FToolButtonStyle write setToolButtonStyle;
    property AutoRaise: boolean read FAutoRaise write setAutoRaise;
    property ArrowType: TArrowType read FarrowType write setArrowType;
    // signals
    property triggered: string read FTriggered write FTriggered;
  end;

  TQtRadioButton = class(TQtAbstractButton)
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  end;

  TQtCheckBox = class(TQtAbstractButton)
  private
    FTristate: boolean;
    FStateChanged: string;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    procedure SizeToText; override;
  published
    property Tristate: boolean read FTristate write FTristate;
    // signals
    property stateChanged: string read FStateChanged write FStateChanged;
  end;

  TQtCommandLinkButton = class(TQtPushButton)
  private
    FDescription: string;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
  published
    property Description: string read FDescription write FDescription;
  end;

implementation

uses
  Controls, Math, Types, SysUtils, UGUIDesigner, UUtils;

{--- TQtAbstractButton ---------------------------------------------------------}

constructor TQtAbstractButton.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FText:= '';
  FIcon:= '';
  Height:= 24;
  Width:= 80;
  FShortcut:= '';
  FCheckable:= false;
  FChecked:= false;
  FAutoRepeat:= false;
  FAutoExclusive:= false;
  FAutoRepeatDelay:= 300;
end;

function TQtAbstractButton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Icon|Text|';
  if ShowAttributes >= 2 then
    Result:= Result + '|Checkable|Checked|Shortcut|';
  if ShowAttributes = 3 then
    Result:= Result + '|AutoRepeat|AutoExclusive|AutoRepeatDelay|AutoRepeatInterval|';
  Result:= Result + inherited getAttributes(ShowAttributes)
end;

function TQtAbstractButton.getEvents(ShowEvents: integer): string;
begin
  Result:= '|clicked|pressed|released|toggled';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtAbstractButton.HandlerInfo(const event: string): string;
begin
  if (event = 'clicked') or (event = 'toggled') then
    Result:= 'bool;checked'
  else
    Result:= inherited;
end;

procedure TQtAbstractButton.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.animateClick');
    Slots.Add(Name + '.click');
    Slots.Add(Name + '.toggle');
  end else if Parametertypes = 'bool' then
    Slots.Add(Name + '.setChecked')
  else if Parametertypes = 'QSize' then
    Slots.Add(Name + '.setIconSize');
  inherited;
end;

procedure TQtAbstractButton.Paint;
  var tx, ty, tw, th, x, y, w, h, gw, gh, gx, gy, maxw, maxh,
      gtg, bx, by: integer;
      pathname: string;
      SL: TstringList;
      bmp: TBitmap;

  procedure ShowText(R: TRect);
  begin
    var s:= SL.Text;
    if trim(s) = '' then
      exit;
    DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_LEFT);
  end;

begin
  inherited;
  if PaintFlat then begin
    Canvas.Brush.Color:= $F0F0F0;
    Canvas.Pen.Color:= $F0F0F0;
  end else begin
    Canvas.Brush.Color:= $E1E1E1;
    Canvas.Pen.Color:= $ADADAD;
  end;
  Canvas.Rectangle(ClientRect);

  h:= Height;
  w:= Width;
  SL:= TStringList.Create;
  CalculateText(FText, tw, th, SL);
  if LeftSpace <> PPIScale(18) then
    LeftSpace:= 0;
  try
    pathname:= FGuiDesigner.getPath + 'images\' + copy(Icon, 8, length(Icon));
    if not (FileExists(pathname) or (PaintArrow > 0)) or (PaintStyle = 2) then begin
      // without graphic
      if PaintStyle = 3 then begin // Radio- or CheckButton
        x:= LeftSpace;
        TopSpace:= (h - PPIScale(15)) div 2;
      end else
        x:= (w - tw - LeftSpace) div 2 + LeftSpace;
      y:= (h - th) div 2;
      ShowText(Rect(x, y, x + tw, y + th));
    end else begin
      // with graphic
      if PaintStyle in [1, 5] then // icon only, follow style
        tw:= 0;
      bmp:= getIconAsBitmap;
      gw:= bmp.Width;
      gh:= bmp.Height;
      gtg:= 1; // GraphicTextGap
      maxw:= gw + gtg + tw;
      maxh:= max(th, gh);
      if maxw > w then begin
        width:= maxw;
        w:= maxw;
      end;

      // bx, by = position of compound box of graphic and text
      // maxw, maxh = size of compound box
      bx:= (w - maxw) div 2 + LeftSpace;
      by:= (h - maxh) div 2;
      gx:= bx;
      gy:= (h - gh) div 2;

      if PaintStyle = 3 then // beside icon
        gx:= 2 + LeftSpace;
      tx:= gx + gw + gtg;
      ty:= (h - th) div 2;

      if PaintStyle = 4 then begin // under icon
        gx:= (w - gw) div 2;
        gy:= 0;
        tx:= (w - tw) div 2;
        ty:= h div 2 + 3;
      end;

      if (PaintStyle = 0) and (FText <> '') or (PaintStyle in [3, 4]) then
        ShowText(Rect(tx, ty, tx+tw, ty+th));
      Canvas.Draw(gx, gy, bmp);

      // for debugging
      // R:= rect(min(gx,tx), min(gy,ty), max(gx+gw,tx+tw), max(gy+gh, ty+th));
      // Canvas.DrawFocusRect(r);

      // for use in Checkbutton and Radiobutton
      TopSpace:= by + maxh div 2 - PPIScale(10);
      FreeAndNil(bmp);
    end;
  finally
    FreeAndNil(SL);
    LeftSpace:= 0;
  end;
end;

function TQtAbstractButton.GetIconAsBitmap: TBitmap;
  var bmp: Graphics.TBitmap;
begin
  if PaintArrow in [1..4] then begin // ToolButton/ArrowType
    bmp:= Graphics.TBitmap.Create;
    bmp.Width:= 19;
    bmp.Height:= 19;
    if PaintFlat then begin
      bmp.Canvas.Brush.Color:= $F0F0F0;
      bmp.Canvas.Pen.Color:= $F0F0F0;
    end else begin
      bmp.Canvas.Brush.Color:= $E1E1E1;
      bmp.Canvas.Pen.Color:= $ADADAD;
    end;
    bmp.Canvas.FillRect(Rect(0, 0, 18, 18));
    bmp.Canvas.Pen.Color:= clBlack;
    bmp.Canvas.Brush.Color:= clBlack;
    case PaintArrow of
      1: bmp.canvas.Polygon([Point( 3, 12), Point(15, 12), Point( 9,  6)]);
      2: bmp.Canvas.Polygon([Point( 3,  6), Point(15,  6), Point( 9, 12)]);
      3: bmp.Canvas.Polygon([Point(12, 15), Point(12,  3), Point( 6,  9)]);
      4: bmp.Canvas.Polygon([Point(6,  15), Point( 6,  3), Point(12,  9)]);
    end;
  end else begin
    bmp:= BitmapFromRelativePath(Icon);
    if (bmp = nil) and (PaintArrow = 5) then begin // CommandLinkButton
      bmp:= Graphics.TBitmap.Create;
      bmp.Width:= 30;
      bmp.Height:= 20;
      if PaintFlat then begin
        bmp.Canvas.Brush.Color:= $F0F0F0;
        bmp.Canvas.Pen.Color:= $F0F0F0;
      end else begin
        bmp.Canvas.Brush.Color:= $E1E1E1;
        bmp.Canvas.Pen.Color:= $ADADAD;
      end;
      bmp.Canvas.FillRect(Rect(0, 0, 30, 20));
      bmp.Canvas.Pen.Color:= $DD953B; // blue
      bmp.Canvas.Pen.Width:= 2;
      bmp.Canvas.MoveTo(6, 11);
      bmp.Canvas.LineTo(23, 11);
      bmp.Canvas.LineTo(18, 6);
      bmp.Canvas.MoveTo(23, 11);
      bmp.Canvas.LineTo(18, 16);
    end;
  end;
  Result:= bmp;
end;

procedure TQtAbstractButton.setText(Value: string);
begin
  if Value <> fText then begin
    fText:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.setIcon(Value: string);
begin
  if Value <> FIcon then begin
    FIcon:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.setChecked(Value: boolean);
begin
  if Value <> FChecked then begin
    FChecked:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.setClicked(Value: string);
begin
  if Value <> FClicked then begin
    FClicked:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Icon' then
    MakeIcon(Value)
  else if Attr = 'Shortcut' then
    MakeShortcut(Value)
  else
    inherited;
end;

procedure TQtAbstractButton.MakeIcon(const Value: string);
  var s, key, Dest, filename, Path: string;
      bmp: TBitmap;
begin
  // ToDo use PIL if png-file selected
  key:= 'self.' + Name + '.setIcon';
  if Value = '(Image)' then begin
    Partner.DeleteAttribute(key);
    Partner.DeleteAttribute(key + 'Size');
  end else begin
    filename:= ExtractFileName(Value);
    if Pos('images/', filename) = 1 then
      System.delete(filename, 1, 7);
    Path:= ExtractFilePath(Partner.Pathname);
    Dest:= Path + 'images\' + filename;
    ForceDirectories(Path + 'images\');
    if not FileExists(Dest) then
      copyFile(PChar(Value), PChar(Dest), true);
    FIcon:= 'images/' + filename;
    s:= key + '(QIcon(' + asString(FIcon) + '))';
    setAttributValue(key, s);
    key:= key + 'Size';
    bmp:= GetIconAsBitmap;
    s:= key + '(QSize(' + IntToStr(bmp.Width) + ', ' + IntToStr(bmp.Height) + '))';
    setAttributValue(key, s);
    FreeAndNil(bmp);
    UpdateObjectInspector;
  end;
end;

procedure TQtAbstractButton.MakeShortcut(const Value: string);
  var s, key: string;
begin
  key:= 'self.' + Name + '.setShortcut';
  if Value = '' then
    Partner.DeleteAttribute(key)
  else begin
    s:= key + '(QKeySequence(' + asString(Value) + '))';
    setAttributValue(key, s);
  end;
end;

procedure TQtAbstractButton.SizeToText;
begin
  var d:= Canvas.TextWidth(Text) + 3*HalfX - Width;
  if d > 0 then Width:= Width + d;
  d:= Canvas.TextHeight(Text)+ 4 - Height;
  if d > 0 then Height:= Height + d;
end;

procedure TQtAbstractButton.MakeClickEvent;
begin
  Clicked:= Handlername('Clicked');
  setEvent('clicked');
  UpdateObjectInspector;
end;

{--- TQtPushButton -------------------------------------------------------------}

constructor TQtPushButton.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 74;
  FText:= 'PushButton';
end;

function TQtPushButton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|AutoDefault|Default_|Flat';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtPushButton.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Default_'
    then inherited setAttribute('Default', Value, Typ)
    else inherited;
end;

procedure TQtPushButton.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.ShowMenu');
  inherited;
end;

procedure TQtPushButton.NewWidget(Widget: string = '');
begin
  if Widget = ''
    then inherited NewWidget('QPushButton')
    else inherited NewWidget(Widget);
  setAttribute('Text', 'PushButton', 'Text');
  MakeClickEvent;
end;

procedure TQtPushButton.Paint;
  var R: TRect;
begin
  if FFlat then
    PaintFlat:= true;
  inherited;
  if Default_ and not FFlat then begin
    Canvas.Brush.Color:= $D77800;
    R:= ClientRect;
    Canvas.FrameRect(R);
    R.Inflate(-1, -1);
    Canvas.FrameRect(R);
  end;
  PaintFlat:= false;
end;

procedure TQtPushButton.setFlat(Value: boolean);
begin
  if Value <> FFlat then begin
    FFlat:= Value;
    Invalidate;
  end;
end;

{--- TQtToolButton ------------------------------------------------------------}

constructor TQtToolButton.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 103;
  Width:= 24;
  FText:= '...';
  FocusPolicy:= TabFocus;
  FPopupMode:= DelayedPopup;
  FToolButtonStyle:= ToolButtonIconOnly;
  FArrowType:= NoArrow;
end;

function TQtToolButton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|PopupMode|ToolButtonStyle|AutoRaise|ArrowType|';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtToolButton.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'ToolButtonStyle') or (Attr = 'ArrowType') then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if Attr = 'PopupMode'  then
    MakeAttribut(Attr, 'QToolButton.ToolButtonPopupMode.' + Value)
  else
    inherited;
end;

function TQtToolButton.getEvents(ShowEvents: integer): string;
begin
  Result:= '|triggered';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtToolButton.HandlerInfo(const event: string): string;
begin
  if event = 'triggered' then
    Result:= 'QAction;action'
  else
    Result:= inherited;
end;

procedure TQtToolButton.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.showMenu')
  else if Parametertypes = 'QAction' then
    Slots.Add(Name + '.setDefaultAction')
  else if Parametertypes = 'QToolButtonStyle' then
    Slots.Add(Name + '.setToolButtonStyle');
  inherited;
end;

procedure TQtToolButton.Paint;
begin
  if FAutoRaise then
    PaintFlat:= true;
  PaintStyle:= ord(FToolButtonStyle) + 1;
  PaintArrow:= ord(FArrowType);
  inherited;
  PaintFlat:= false;
  PaintStyle:= 0;
  PaintArrow:= 0;
end;

procedure TQtToolButton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QToolButton');
  setAttribute('Text', '...', 'Text');
  MakeClickEvent;
end;

procedure TQtToolButton.setArrowType(Value: TArrowType);
begin
  if Value <> FArrowType then begin
    FArrowType:= Value;
    Invalidate;
  end;
end;

procedure TQtToolButton.setAutoRaise(Value: boolean);
begin
  if Value <> FAutoRaise then begin
    FAutoRaise:= Value;
    Invalidate;
  end;
end;

procedure TQtToolButton.setToolButtonStyle(Value: TToolButtonStyle);
begin
  if Value <> FToolButtonStyle then begin
    FToolButtonStyle:= Value;
    Invalidate;
  end;
end;

{--- TQtRadioButton ------------------------------------------------------------}

constructor TQtRadioButton.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 76;
  FText:= 'RadioButton';
  MouseTracking:= true;
  FCheckable:= true;
  FAutoExclusive:= true;
end;

function TQtRadioButton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Checked';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtRadioButton.Paint;
begin
  PaintFlat:= true;
  PaintStyle:= 3;
  LeftSpace:= PPIScale(18);
  inherited;
  if FChecked
    then FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 3)
    else FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 2);
  PaintFlat:= false;
  PaintStyle:= 0;
end;

procedure TQtRadioButton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QRadioButton');
  setAttribute('Text', 'RadioButton', 'Text');
end;

{--- TQtCheckBox ---------------------------------------------------------------}

constructor TQtCheckBox.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 77;
  FText:= 'CheckBox';
  MouseTracking:= true;
  FCheckable:= true;
end;

function TQtCheckBox.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Checked|Tristate';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TQtCheckBox.getEvents(ShowEvents: integer): string;
begin
  Result:= '|stateChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtCheckBox.HandlerInfo(const event: string): string;
begin
  if event = 'stateChanged' then
    Result:= 'int;state'
  else
    Result:= inherited;
end;

procedure TQtCheckBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QCheckBox');
  setAttribute('Text', 'CheckBox', 'Text');
end;

procedure TQtCheckBox.Paint;
begin
  PaintFlat:= true;
  PaintStyle:= 3;
  LeftSpace:= PPIScale(18);
  inherited;
  if FChecked
    then FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 1)
    else FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 0);
  PaintFlat:= false;
  PaintStyle:= 0;
end;

procedure TQtCheckBox.SizeToText;
begin
  var d:= Canvas.TextWidth(Text) + PPIScale(18) + 3*HalfX - Width;
  if d > 0 then Width:= Width + d;
  d:= Canvas.TextHeight(Text)+ PPIScale(4) - Height;
  if d > 0 then Height:= Height + d;
end;

{--- TQtCommandLinkButton -----------------------------------------------------}

constructor TQtCommandLinkButton.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 104;
  Width:= 184;
  Height:= 40;
  FText:= 'CommandLinkButton';
  PaintFlat:= true;
  PaintArrow:= 5;
  PaintStyle:= 3;
end;

function TQtCommandLinkButton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Description';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtCommandLinkButton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QCommandLinkButton');
  setAttribute('Text', 'CommandLinkButton', 'Text');
  MakeClickEvent;
end;

end.
