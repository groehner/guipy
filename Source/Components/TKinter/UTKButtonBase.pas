{-------------------------------------------------------------------------------
 Unit:     UTKButtonBase
 Author:   Gerhard R?hner
 Date:     May 2021
 Purpose:  tkinter button widgets
-------------------------------------------------------------------------------}

unit UTKButtonBase;

{ class hierarchie

  TKButtonBaseWidget
    TKLabel
    TKButton
    TKCheckbutton
    TKMenubutton
      TKOptionMenu
}

interface

uses
  Windows, Messages, Classes, Controls, Graphics, UBaseTkWidgets, UTkWidgets;

type

  // combination of text and image
  TCompound = (_TC_top, _TC_bottom, _TC_left, _TC_right, _TC_center, _TC_none);

  // for disabeling  - different to TTextState in TKTextBase
  TButtonState = (active, disabled, normal);

  TDirection = (above, below, flush, left, right);


  TKButtonBaseWidget = class(TKWidget)
  private
    FActiveForeground: TColor;
    FBitmap: String;
    FCompound: TCompound;
    FIndicatorOn: boolean;
    FOffRelief: TRelief;
    FOverRelief: TRelief;
    FSelectColor: TColor;
    FSelectImage: String;
    FState: TButtonState;
    procedure setBitmap(aValue: string);
    procedure setCompound(aValue: TCompound);
    procedure setIndicatorOn(aValue: boolean);
    procedure setState(aValue: TButtonState);
  protected
    procedure MakeDirection(Value: String);
    procedure CalculateText(var tw, th: integer; var SL: TStringlist); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    function getCompound: TUCompound; override;

    property OffRelief: TRelief read fOffRelief write fOffRelief default _TR_raised;
    property OverRelief: TRelief read fOverRelief write fOverRelief default _TR_raised;
    property IndicatorOn: boolean read FIndicatorOn write setIndicatorOn default true;
    property SelectColor: TColor read fSelectColor write fSelectColor default clWindow;
    property SelectImage: String read fSelectImage write fSelectImage;
  published
    property ActiveBackground;
    property ActiveForeground: TColor read FActiveForeground write FActiveForeground default clBtnText;
    property Anchor;
    property Bitmap: string read FBitmap write setBitmap;
    property Compound: TCompound read FCompound write setCompound default _TC_none;
    property DisabledForeground;
    property Font;
    property Foreground;
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property Image;
    property Justify;
    property PadX;
    property PadY;
    property State: TButtonState read FState write setState default normal;
    property Text;
    property Underline;
    property WrapLength;
  end;

  TKLabel = class (TKButtonBaseWidget)
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure SizeLabelToText; override;
  end;

  TKButton = class (TKButtonBaseWidget)
  private
    FDefault: boolean;
    FRepeatDelay: integer;
    FRepeatInterval: integer;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property Command;
    property Default: boolean read FDefault write FDefault default false;
    property OverRelief;
    property RepeatDelay: integer read FRepeatDelay write FRepeatDelay default 0;
    property RepeatInterval: integer read FRepeatInterval write FRepeatInterval default 0;
    property TakeFocus;
  end;

  TKCheckbutton = class (TKButtonBaseWidget)
  private
    FOffValue: String;
    FOnValue: String;
  protected
    procedure Paint; override;
    procedure setText(aValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property Command;
    property IndicatorOn;
    property OffRelief;
    property OverRelief;
    property OffValue: String read fOffValue write fOffValue;
    property OnValue: String read fOnValue write fOnValue;
    property SelectColor;
    property SelectImage;
    property TakeFocus;
  end;

  TKMenubutton = class(TKButtonBaseWidget)
  private
    FDirection: TDirection;
    FMenu: String;
  public
    constructor Create (AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property Direction: TDirection read FDirection write FDirection default below;
    property IndicatorOn;
    property Menu: String read FMenu write FMenu;
  end;

  TKOptionMenu = class(TKMenubutton)
  private
    FNewItems: TStrings;
    FOldItems: TStrings;
    procedure setItems(aItems: TStrings);
    procedure MakeMenuItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property IndicatorOn;
    property MenuItems: TStrings read FNewItems write setItems;
  end;

implementation

uses Math, SysUtils, System.Types, UITypes, UUtils, UImages, UConfiguration,
     Vcl.Imaging.GIFImg, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
     UObjectGenerator, UObjectInspector, UGUIDesigner, UKoppel;

{--- TButtonBaseWidget --------------------------------------------------------}

constructor TKButtonBaseWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FActiveForeground:= clBtnText;
  FCompound:= _TC_none;
  FIndicatorOn:= true;
  FOffRelief:= _TR_raised;
  FOverRelief:= _TR_raised;
  FSelectColor:= clWindow;
  FState:= normal;
end;

procedure TKButtonBaseWidget.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Image' then
    MakeImage(Value)
  else if Attr = 'Direction' then
    MakeDirection(Value)
  else
    inherited;
end;

function TKButtonBaseWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Text|Anchor';
  if ShowAttributes >= 2 then
    Result:= Result + '|Bitmap|Compound|Image';
  if ShowAttributes = 3 then
    Result:= Result + '|ActiveBackground|ActiveForeground|DisabledForeground' +
                      '|Foreground|HighlightBackground|HighlightColor' +
                      '|HighlightThickness|Justify|PadX|PadY|State|Underline|WrapLength';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TKButtonBaseWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

procedure TKButtonBaseWidget.MakeDirection(Value: String);
  var s: string;
begin
  s:= 'self.' + Name + '[''direction'']';
  setAttributValue(s, s + ' = ' + asString(Value));
end;

function TKButtonBaseWidget.getCompound: TUCompound;
begin
  case FCompound of
    _TC_top   : Result:= _TU_top;
    _TC_bottom: Result:= _TU_bottom;
    _TC_left  : Result:= _TU_left;
    _TC_right : Result:= _TU_right;
    _TC_center: Result:= _TU_center;
  else          Result:= _TU_none;
  end;
end;

procedure TKButtonBaseWidget.CalculateText(var tw, th: integer; var SL: TStringlist);
  var s: String; p: integer;
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

procedure TKButtonBaseWidget.setBitmap(aValue: string);
begin
  if aValue <> fBitmap then begin
    fBitmap:= aValue;
    Invalidate;
  end;
end;

procedure TKButtonBaseWidget.setCompound(aValue: TCompound);
begin
  if aValue <> fCompound then begin
    fCompound:= aValue;
    Invalidate;
  end;
end;

procedure TKButtonBaseWidget.setIndicatorOn(aValue: boolean);
begin
  if aValue <> FIndicatorOn then begin
    FIndicatorOn:= aValue;
    Invalidate;
  end;
end;

procedure TKButtonBaseWidget.setState(aValue: TButtonState);
begin
  if aValue <> FState then begin
    FState:= aValue;
    Invalidate;
  end;
end;

{--- TKLabel ------------------------------------------------------------------}

constructor TKLabel.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 1;
  Width:= 102;
  Height:= 20;
  Text:= 'Text';
  Anchor:= _TA_w;
  HighlightThickness:= '0';
end;

procedure TKLabel.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Label');
  var s:= 'self.' + Name + '[''anchor'']';
  setAttributValue(s, s + ' = ''w''');
  s:= 'self.' + Name + '[''text'']';
  setAttributValue(s, s + ' = ''Text''');
end;

procedure TKLabel.SizeLabelToText;
begin
  var d:= Canvas.TextWidth(Text) + 4 - Width;
  if d > 0 then Width:= Width + d;
  d:= Canvas.TextHeight(Text)+ 4 - Height;
  if d > 0 then Height:= Height + d;
end;

{--- TKButton -----------------------------------------------------------------}

constructor TKButton.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 4;
  Width:= 75;
  Height:= 25;
  FDefault:= false;
  FRepeatDelay:= 0;
  FRepeatInterval:= 0;
  Relief:= _TR_raised;
  TakeFocus:= true;
end;

function TKButton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Command|Default';
  if ShowAttributes >= 3 then Result:= Result + '|OverRelief|RepeatDelay|RepeatInterval';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKButton.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Button');
  Command:= true;
  ChangeCommand('Command', Name + '_Command');
end;

{--- TKCheckbutton ------------------------------------------------------------}

constructor TKCheckbutton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 5;
  Width:= 102;
  Height:= 20;
  FActiveForeground:= clWindowText;
  FOffValue:= '0';
  FOnValue:= '1';
  Foreground:= clWindowText;
  TakeFocus:= true;
end;

function TKCheckbutton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Command';
  if ShowAttributes >= 2 then
    Result:= Result + '|OffValue|OnValue';
  if ShowAttributes = 3 then
    Result:= Result + '|IndicatorOn|OffRelief|OverRelief|SelectColor|SelectImage';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKCheckbutton.setText(aValue: string);
  var w: integer;
begin
  w:= 17 + Canvas.TextWidth(aValue + '    ');
  if Width < w then begin
    Width:= w;
    SetPositionAndSize;
  end;
  inherited;
end;

procedure TKCheckbutton.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Checkbutton');
  MakeControlVar('variable', Name + 'CV', '0', 'Int');
  Anchor:= _TA_w;
  var s:= 'self.' + Name + '[''anchor'']';
  setAttributValue(s, s + ' = ''w''');
end;

procedure TKCheckbutton.Paint;
  var R: TRect;
begin
  if FIndicatorOn
    then LeftSpace:= 21
    else LeftSpace:= 0;
  inherited;
  if FIndicatorOn then
    DrawBitmap(LeftSpace, TopSpace, 2, Canvas, DMImages.ILPythonControls)
  else begin
    R:= ClientRect;
    PaintBorder(R, FOffRelief, BorderWidthInt);
  end;
end;

{--- TKMenubutton -------------------------------------------------------------}

constructor TKMenubutton.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Tag:= 17;
  Width:= 75;
  Height:= 25;
  BorderWidth:= '1';
  HighlightThickness:= '0';
  FDirection:= below;
  FIndicatorOn:= false;
  PadX:= '5';
  PadY:= '4';
end;

function TKMenubutton.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Menu';
  if ShowAttributes >= 2 then
    Result:= Result + '|Direction';
  if ShowAttributes = 3 then
    Result:= Result + '|IndicatorOn|OffRelief|OverRelief|SelectColor|SelectImage';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKMenubutton.setAttribute(Attr, Value, Typ: string);
  var w: integer;
begin
  if Attr = 'Text' then begin
    w:= 17 + Canvas.TextWidth(Value + '    ');
    if Width < w then Width:= w;
  end;
  inherited;
end;

procedure TKMenubutton.NewWidget(Widget: String = '');
begin
  // because TKOptionMenu inherits from TKMenubutton
  if Widget = ''
    then inherited NewWidget('tk.Menubutton')
    else inherited NewWidget('tk.OptionMenu');
end;

procedure TKMenubutton.Paint;
  var R: TRect; x, y: integer;
begin
  if FIndicatorOn
    then RightSpace:= 21
    else RightSpace:= 0;
  inherited;
  if FIndicatorOn then begin
    R:= ClientRect;
    R.Inflate(-BorderWidthInt, -BorderWidthInt);

    x:= Width - BorderWidthInt - 21;
    y:= (Height - 6) div 2;
    R:= Rect(x, y, x + 15, y + 6);
    Canvas.FillRect(R);
    PaintBorder(R, _TR_raised, 1);
  end;
end;

{--- TKOptionMenu -------------------------------------------------------------}

constructor TKOptionMenu.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 18;
  Width:= 75;
  Height:= 25;
  HighlightThickness:= '2';
  PadX:= '5';
  PadY:= '4';
  FDirection:= Below;
  Relief:= _TR_raised;
  FNewItems:= TStringList.Create;
  FNewItems.Text:= 'A'#13#10'B'#13#10'C';
  FOldItems:= TStringList.Create;
end;

destructor TKOptionMenu.Destroy;
begin
  FreeAndNil(FNewItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TKOptionMenu.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|MenuItems';
  if ShowAttributes = 3 then
    Result:= Result + '';
  Result:= Result + inherited getAttributes(ShowAttributes);
  if ShowAttributes = 1 then begin
    var p:= Pos('|Menu|', Result);
    delete(Result, p, 5);
  end;
end;

procedure TKOptionMenu.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited;
end;

procedure TKOptionMenu.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  setAttributValue('self.' + Name + 'CV', 'self.' + Name + 'CV = tk.StringVar()');
  setValue(Name + 'CV', asString('A'));
  MakeMenuItems;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKOptionMenu.setItems(aItems: TStrings);
begin
  FOldItems.Text:= FNewItems.Text;
  if aItems.Text <> FNewItems.Text then
    FNewItems.Assign(aItems);
end;

procedure TKOptionMenu.MakeMenuItems;
  var i: integer;
      s, MenuItems, newMenuTitle: string;
begin
  MenuItems:= '';
  for i := 0 to FNewItems.Count - 1 do begin
    newMenuTitle:= trim(FNewItems.Strings[i]);
    if newMenuTitle = '' then continue;
    MenuItems:= MenuItems + ', ' + asString(newMenuTitle);
  end;
  s:= 'self.' + Name;
  setAttributValue(s, s + ' = tk.OptionMenu(self.root, self.' + Name + 'CV' + MenuItems + ')');
end;

procedure TKOptionMenu.Paint;
  var R: TRect; x, y: integer;
begin
  if FIndicatorOn
    then RightSpace:= 21
    else RightSpace:= 0;
  inherited;
  if FIndicatorOn then begin
    R:= ClientRect;
    R.Inflate(-BorderWidthInt, -BorderWidthInt);

    x:= Width - BorderWidthInt - 21;
    y:= (Height - 6) div 2;
    R:= Rect(x, y, x + 15, y + 6);
    Canvas.FillRect(R);
    PaintBorder(R, _TR_raised, 1);
  end;
end;

end.

