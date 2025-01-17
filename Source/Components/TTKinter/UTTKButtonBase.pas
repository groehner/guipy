{-------------------------------------------------------------------------------
 Unit:     UTTKButtonBase
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  TKKinter button widgets
-------------------------------------------------------------------------------}

unit UTTKButtonBase;

{ class hierarchie

  TTKButtonBaseWidget
    TTKLabel
    TTKButton
    TTKCheckbutton
    TTKMenubutton
      TTKOptionMenu
}

interface

uses
  Classes, UBaseTkWidgets, UTtkWidgets;

type

  // combination of text and image
  TCompound = (_TC_top, _TC_bottom, _TC_left, _TC_right, _TC_center, _TC_none,
               _TC_image, _TC_text); // two new options in ttk

  // for disabeling  - different to TTextState in TKTextBase
  TButtonState = (active, alternate, background, disabled, focus, invalid, normal, pressed, readonly, selected);

  TDirection = (above, below, flush, left, right);

  TTKButtonBaseWidget = class(TTKWidget)
  private
    FCompound: TCompound;
    FState: TButtonState;
    procedure setCompound(aValue: TCompound);
    procedure setState(aValue: TButtonState);
    procedure MakeDirection(Value: string);
  protected
    function getCompound: TUCompound; override;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    procedure SizeToText; override;
  published
    property Compound: TCompound read FCompound write setCompound default _TC_none;
    property Image;
    property Padding;
    property State: TButtonState read FState write setState default active;
    property Style;
    property Text;
    property Underline;
  end;

  TTKLabel = class (TTKButtonBaseWidget)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeFont; override;
    function getAttributes(ShowAttributes: Integer): string; override;
  published
    property Anchor;
    property Background;
    property BorderWidth;
    property Font;
    property Foreground;
    property Justify;
    property Relief;
    property Wraplength;
  end;

  TTKButton = class (TTKButtonBaseWidget)
  private
    FDefault: Boolean;
    procedure setDefault(aValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property Command;
    property Default: Boolean read FDefault write setDefault default False;
    property Padding;
    property TakeFocus;
  end;

  TTKCheckbutton = class (TTKButtonBaseWidget)
  private
    FOffValue: string;
    FOnValue: string;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeFont; override;
    procedure SizeToText; override;
  published
    property Command;
    property OffValue: string read fOffValue write fOffValue;
    property OnValue: string read fOnValue write fOnValue;
    property TakeFocus;
  end;

  TTKMenubutton = class(TTKButtonBaseWidget)
  private
    FDirection: TDirection;
    FMenu: string;
  public
    constructor Create (AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property Direction: TDirection read FDirection write FDirection default below;
    property Menu: string read FMenu write FMenu;
    property Padding;
  end;

  TTKOptionMenu = class(TTKMenubutton)
  private
    FNewItems: TStrings;
    FOldItems: TStrings;
    procedure setItems(aItems: TStrings);
    procedure MakeMenuItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    function getText: string; override;
  published
    property MenuItems: TStrings read FNewItems write setItems;
  end;

implementation

uses Controls, Graphics, SysUtils, System.Types, UUtils, UGUIDesigner;

{--- TButtonBaseWidget --------------------------------------------------------}

constructor TTKButtonBaseWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCompound:= _TC_none;
  FState:= active;
  Width:= 80;
  Height:= 24;
end;

procedure TTKButtonBaseWidget.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Image' then
    MakeImage(Value)
  else if Attr = 'Direction' then
    MakeDirection(Value)
  else
    inherited;
end;

function TTKButtonBaseWidget.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Text';
  if ShowAttributes >= 2 then
    Result:= Result + '|Compound|Image';
  if ShowAttributes = 3 then
    Result:= Result + '|Padding|State|Underline';
  Result:= Result + inherited getAttributes(ShowAttributes)
end;

function TTKButtonBaseWidget.getEvents(ShowEvents: Integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

procedure TTKButtonBaseWidget.MakeDirection(Value: string);
  var s: string;
begin
  s:= 'self.' + Name + '[''direction'']';
  setAttributValue(s, s + ' = ' + asString(Value));
end;

function TTKButtonBaseWidget.getCompound: TUCompound;
begin
  case FCompound of
    _TC_top   : Result:= _TU_top;
    _TC_bottom: Result:= _TU_bottom;
    _TC_left  : Result:= _TU_left;
    _TC_right : Result:= _TU_right;
    _TC_center: Result:= _TU_center;
    _TC_none  : Result:= _TU_none;
    _TC_image : Result:= _TU_image;
  else          Result:= _TU_text;
  end;
end;

procedure TTKButtonBaseWidget.SizeToText;
begin
  var d:= Canvas.TextWidth(Text + 'x') + - Width;
  if d > 0 then Width:= Width + d;
  d:= Canvas.TextHeight(Text)+ 4 - Height;
  if d > 0 then Height:= Height + d;
end;

procedure TTKButtonBaseWidget.setCompound(aValue: TCompound);
begin
  if aValue <> fCompound then begin
    fCompound:= aValue;
    Invalidate;
  end;
end;

procedure TTKButtonBaseWidget.setState(aValue: TButtonState);
begin
  if aValue <> FState then begin
    FState:= aValue;
    Invalidate;
  end;
end;

{--- TKLabel ------------------------------------------------------------------}

constructor TTKLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 31;
  Text:= 'Label';
  Anchor:= _TA_w;
  Justify:= _TJ_left;
end;

function TTKLabel.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Anchor|Background';
  if ShowAttributes >= 2 then
    Result:= Result + '|Foreground';
  if ShowAttributes = 3 then
    Result:= Result + '|Justify|Wraplength';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKLabel.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Label');
  InsertValue('self.' + Name + '[' + asString('anchor') + '] = ' + asString('w'));
  InsertValue('self.' + Name + '[' + asString('text') + '] = ' + asString(Text));
end;

procedure TTKLabel.MakeFont;
begin
  // no font
end;

procedure TTKLabel.Paint;
begin
  Canvas.Brush.Color:= Background;
  inherited;
end;

{--- TKButton -----------------------------------------------------------------}

constructor TTKButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 34;
  Text:= 'Button';
  FDefault:= False;
  Relief:= _TR_solid;
  Background:= $E1E1E1;
end;

function TTKButton.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Command|Default';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKButton.setAttribute(Attr, Value, Typ: string);
  var s: string;
begin
  if Attr = 'Default' then begin
    s:= getAttrAsKey(Attr);
    if Value = 'True'
      then setAttributValue(s, s + ' = ' + asString('active'))
      else Partner.DeleteAttribute(s);
  end else
    inherited;
end;

procedure TTKButton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Button');
  InsertValue('self.' + Name + '[' + asString('text') + '] = ' + asString(Text));
  Command:= True;
  ChangeCommand('Command', Name + '_Command');
end;

procedure TTKButton.MakeFont;
begin
  // no font
end;

procedure TTKButton.setDefault(aValue: Boolean);
begin
  if FDefault <> aValue then begin
    fDefault:= aValue;
    Invalidate;
  end;
end;

procedure TTKButton.Paint;
  var R: TRect;
begin
  inherited;
  if Default then begin
    Canvas.Brush.Color:= $D77800;
    R:= ClientRect;
    Canvas.FrameRect(R);
    R.Inflate(-1, -1);
    Canvas.FrameRect(R);
  end;
end;

{--- TKCheckbutton ------------------------------------------------------------}

constructor TTKCheckbutton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 35;
  Width:= 120;
  Anchor:= _TA_w;
  Text:= 'Checkbutton';
  FOffValue:= '0';
  FOnValue:= '1';
end;

function TTKCheckbutton.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Command';
  if ShowAttributes >= 2 then
    Result:= Result + '|OffValue|OnValue';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKCheckbutton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('ttk.Checkbutton');
  InsertValue('self.' + Name + '[' + asString('text') + '] = ' + asString(Text));
  MakeControlVar('variable', Name + 'CV', '0', 'Int');
end;

procedure TTKCheckbutton.MakeFont;
begin
  // no font
end;

procedure TTKCheckbutton.Paint;
begin
  LeftSpace:= PPIScale(21);
  inherited;
  FGUIDesigner.vilPythonControls.Draw(Canvas, LeftSpace, TopSpace, 2);
end;

procedure TTKCheckbutton.SizeToText;
begin
  var d:= Canvas.TextWidth(Text) + 18 + (3*Canvas.TextWidth('x')) div 2 - Width;
  if d > 0 then Width:= Width + d;
  d:= Canvas.TextHeight(Text)+ 4 - Height;
  if d > 0 then Height:= Height + d;
end;

{--- TKMenuButton -------------------------------------------------------------}

constructor TTKMenubutton.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Tag:= 48;
  FDirection:= below;
  Anchor:= _TA_w;
  Justify:= _TJ_left;
  Text:= 'Menubutton';
end;

function TTKMenubutton.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Menu';
  if ShowAttributes >= 2 then
    Result:= Result + '|Direction';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKMenubutton.setAttribute(Attr, Value, Typ: string);
  var w: Integer;
begin
  if Attr = 'Text' then begin
    w:= PPIScale(17) + Canvas.TextWidth(Value + '    ');
    if Width < w then begin
      Width:= w;
      SetPositionAndSize;
    end;
  end;
  inherited;
end;

procedure TTKMenubutton.NewWidget(Widget: string = '');
begin
  // because TKOptionMenu inherits from TTKMenubutton
  if Widget = '' then begin
    inherited NewWidget('ttk.Menubutton');
    InsertValue('self.' + Name + '[' + asString('text') + '] = ' + asString(Text));
  end else
    inherited NewWidget('ttk.OptionMenu');
end;

procedure TTKMenuButton.MakeFont;
begin
  // no font
end;

procedure TTKMenubutton.Paint;
  var PArray: array[0..2] of TPoint;
begin
  RightSpace:= PPIScale(21);
  inherited;
  PArray[0].x:= Width - PPIScale(12);
  PArray[0].y:= Height div 2 - PPIScale(2);
  PArray[1].x:= Width - PPIScale(6);
  PArray[1].y:= Height div 2 - PPIScale(2);
  PArray[2].x:= Width - PPIScale(9);
  PArray[2].y:= PArray[0].y + PPIScale(3);
  Canvas.Pen.Color:= $282828;
  Canvas.Brush.Color:= $282828;
  Canvas.Polygon(PArray);
end;

{--- TKOptionMenu -------------------------------------------------------------}

constructor TTKOptionMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 49;
  FDirection:= Below;
  FNewItems:= TStringList.Create;
  FNewItems.Text:= defaultItems;
  FOldItems:= TStringList.Create;
end;

destructor TTKOptionMenu.Destroy;
begin
  FreeAndNil(FNewItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TTKOptionMenu.getAttributes(ShowAttributes: Integer): string;
  var p: Integer;
begin
  Result:= '|MenuItems';
  Result:= Result + inherited getAttributes(ShowAttributes);
  p:= Pos('|Style', Result);
  if p > 0 then
    Delete(Result, p, 6);
end;

procedure TTKOptionMenu.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited;
end;

procedure TTKOptionMenu.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + asString(MenuItems[0]) + ')');
  MakeMenuItems;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKOptionMenu.setItems(aItems: TStrings);
begin
  FOldItems.Text:= FNewItems.Text;
  if aItems.Text <> FNewItems.Text then
    FNewItems.Assign(aItems);
end;

procedure TTKOptionMenu.MakeMenuItems;
  var i: Integer;
      s, MenuItems, newMenuTitle: string;
begin
  MenuItems:= '';
  for i := 0 to FNewItems.Count - 1 do begin
    newMenuTitle:= Trim(FNewItems[i]);
    if newMenuTitle = '' then Continue;
    MenuItems:= MenuItems + ', ' + asString(newMenuTitle);
  end;
  s:= 'self.' + Name;
  setAttributValue(s, s + ' = ttk.OptionMenu(self.root, self.' + Name + 'CV' + MenuItems + ')');
end;

function TTKOptionMenu.getText: string;
  var s: string;
begin
  if FNewItems.Count > 0 then
    s:= Trim(FNewItems[0]);
  if s <> ''
    then Result:= s
    else Result:= Text;
end;

procedure TTKOptionMenu.Paint;
  var PArray: array[0..2] of TPoint;
begin
  FOldItems.Text:= FNewItems.Text;
  inherited;
  PArray[0].x:= Width - 12;
  PArray[0].y:= Height div 2 - 2;
  PArray[1].x:= Width - 6;
  PArray[1].y:= Height div 2 - 2;
  PArray[2].x:= Width - 9;
  PArray[2].y:= PArray[0].y + 3;
  Canvas.Pen.Color:= $282828;
  Canvas.Brush.Color:= $282828;
  Canvas.Polygon(PArray);
end;

end.

