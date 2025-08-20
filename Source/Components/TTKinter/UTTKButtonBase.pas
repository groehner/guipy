{ -------------------------------------------------------------------------------
  Unit:     UTTKButtonBase
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  TKKinter button widgets
  ------------------------------------------------------------------------------- }

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
  Classes,
  UBaseTKWidgets,
  UTTKWidgets;

type

  // combination of text and image
  TCompound = (_TC_top, _TC_bottom, _TC_left, _TC_right, _TC_center, _TC_none,
    _TC_image, _TC_text); // two new options in ttk

  // for disabeling  - different to TTextState in TKTextBase
  TButtonState = (active, alternate, background, disabled, focus, invalid,
    normal, pressed, readonly, selected);

  TDirection = (above, below, flush, left, right);

  TTKButtonBaseWidget = class(TTKWidget)
  private
    FCompound: TCompound;
    FState: TButtonState;
    procedure SetCompound(AValue: TCompound);
    procedure SetState(AValue: TButtonState);
    procedure MakeDirection(const Value: string);
  protected
    function GetCompound: TUCompound; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure SizeToText; override;
  published
    property Compound: TCompound read FCompound write SetCompound
      default _TC_none;
    property Image;
    property Padding;
    property State: TButtonState read FState write SetState default active;
    property Style;
    property Text;
    property Underline;
  end;

  TTKLabel = class(TTKButtonBaseWidget)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeFont; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
  published
    property Anchor;
    property background;
    property BorderWidth;
    property Font;
    property Foreground;
    property Justify;
    property Relief;
    property Wraplength;
  end;

  TTKButton = class(TTKButtonBaseWidget)
  private
    FDefault: Boolean;
    procedure SetDefault(AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property Command;
    property Default: Boolean read FDefault write SetDefault default False;
    property Padding;
    property TakeFocus;
  end;

  TTKCheckbutton = class(TTKButtonBaseWidget)
  private
    FOffValue: string;
    FOnValue: string;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeFont; override;
    procedure SizeToText; override;
  published
    property Command;
    property OffValue: string read FOffValue write FOffValue;
    property OnValue: string read FOnValue write FOnValue;
    property TakeFocus;
  end;

  TTKMenubutton = class(TTKButtonBaseWidget)
  private
    FDirection: TDirection;
    FMenu: string;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property Direction: TDirection read FDirection write FDirection
      default below;
    property Menu: string read FMenu write FMenu;
    property Padding;
  end;

  TTKOptionMenu = class(TTKMenubutton)
  private
    FNewItems: TStrings;
    FOldItems: TStrings;
    procedure SetItems(AItems: TStrings);
    procedure MakeMenuItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
    function GetText: string; override;
  published
    property MenuItems: TStrings read FNewItems write SetItems;
  end;

implementation

uses
  Controls,
  Graphics,
  SysUtils,
  System.Types,
  UUtils,
  UGUIDesigner;

{ --- TButtonBaseWidget -------------------------------------------------------- }

constructor TTKButtonBaseWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCompound := _TC_none;
  FState := active;
  Width := 80;
  Height := 24;
end;

procedure TTKButtonBaseWidget.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Image' then
    MakeImage(Value)
  else if Attr = 'Direction' then
    MakeDirection(Value)
  else
    inherited;
end;

function TTKButtonBaseWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Text';
  if ShowAttributes >= 2 then
    Result := Result + '|Compound|Image';
  if ShowAttributes = 3 then
    Result := Result + '|Padding|State|Underline';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TTKButtonBaseWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetMouseEvents(ShowEvents);
end;

procedure TTKButtonBaseWidget.MakeDirection(const Value: string);
var
  Str: string;
begin
  Str := 'self.' + Name + '[''direction'']';
  SetAttributValue(Str, Str + ' = ' + AsString(Value));
end;

function TTKButtonBaseWidget.GetCompound: TUCompound;
begin
  case FCompound of
    _TC_top:
      Result := _TU_top;
    _TC_bottom:
      Result := _TU_bottom;
    _TC_left:
      Result := _TU_left;
    _TC_right:
      Result := _TU_right;
    _TC_center:
      Result := _TU_center;
    _TC_none:
      Result := _TU_none;
    _TC_image:
      Result := _TU_image;
  else
    Result := _TU_text;
  end;
end;

procedure TTKButtonBaseWidget.SizeToText;
begin
  var
  Delta := Canvas.TextWidth(Text + 'x') + -Width;
  if Delta > 0 then
    Width := Width + Delta;
  Delta := Canvas.TextHeight(Text) + 4 - Height;
  if Delta > 0 then
    Height := Height + Delta;
end;

procedure TTKButtonBaseWidget.SetCompound(AValue: TCompound);
begin
  if AValue <> FCompound then
  begin
    FCompound := AValue;
    Invalidate;
  end;
end;

procedure TTKButtonBaseWidget.SetState(AValue: TButtonState);
begin
  if AValue <> FState then
  begin
    FState := AValue;
    Invalidate;
  end;
end;

{ --- TKLabel ------------------------------------------------------------------ }

constructor TTKLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag := 31;
  Text := 'Label';
  Anchor := _TA_w;
  Justify := _TJ_left;
end;

function TTKLabel.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Anchor|Background';
  if ShowAttributes >= 2 then
    Result := Result + '|Foreground';
  if ShowAttributes = 3 then
    Result := Result + '|Justify|Wraplength';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKLabel.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Label');
  InsertValue('self.' + Name + '[' + AsString('anchor') + '] = ' +
    AsString('w'));
  InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
    AsString(Text));
end;

procedure TTKLabel.MakeFont;
begin
  // no font
end;

procedure TTKLabel.Paint;
begin
  Canvas.Brush.Color := background;
  inherited;
end;

{ --- TKButton ----------------------------------------------------------------- }

constructor TTKButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag := 34;
  Text := 'Button';
  FDefault := False;
  Relief := _TR_solid;
  background := $E1E1E1;
end;

function TTKButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Command|Default';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKButton.SetAttribute(const Attr, Value, Typ: string);
var
  Str: string;
begin
  if Attr = 'Default' then
  begin
    Str := GetAttrAsKey(Attr);
    if Value = 'True' then
      SetAttributValue(Str, Str + ' = ' + AsString('active'))
    else
      Partner.DeleteAttribute(Str);
  end
  else
    inherited;
end;

procedure TTKButton.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Button');
  InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
    AsString(Text));
  Command := True;
  ChangeCommand('Command', Name + '_Command');
end;

procedure TTKButton.MakeFont;
begin
  // no font
end;

procedure TTKButton.SetDefault(AValue: Boolean);
begin
  if FDefault <> AValue then
  begin
    FDefault := AValue;
    Invalidate;
  end;
end;

procedure TTKButton.Paint;
var
  Rect: TRect;
begin
  inherited;
  if Default then
  begin
    Canvas.Brush.Color := $D77800;
    Rect := ClientRect;
    Canvas.FrameRect(Rect);
    Rect.Inflate(-1, -1);
    Canvas.FrameRect(Rect);
  end;
end;

{ --- TKCheckbutton ------------------------------------------------------------ }

constructor TTKCheckbutton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag := 35;
  Width := 120;
  Anchor := _TA_w;
  Text := 'Checkbutton';
  FOffValue := '0';
  FOnValue := '1';
end;

function TTKCheckbutton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Command';
  if ShowAttributes >= 2 then
    Result := Result + '|OffValue|OnValue';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKCheckbutton.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('ttk.Checkbutton');
  InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
    AsString(Text));
  MakeControlVar('variable', Name + 'CV', '0', 'Int');
end;

procedure TTKCheckbutton.MakeFont;
begin
  // no font
end;

procedure TTKCheckbutton.Paint;
begin
  LeftSpace := PPIScale(21);
  inherited;
  FGUIDesigner.vilPythonControls.Draw(Canvas, LeftSpace, TopSpace, 2);
end;

procedure TTKCheckbutton.SizeToText;
begin
  var
  Delta := Canvas.TextWidth(Text) + 18 + (3 * Canvas.TextWidth('x'))
    div 2 - Width;
  if Delta > 0 then
    Width := Width + Delta;
  Delta := Canvas.TextHeight(Text) + 4 - Height;
  if Delta > 0 then
    Height := Height + Delta;
end;

{ --- TKMenuButton ------------------------------------------------------------- }

constructor TTKMenubutton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag := 48;
  FDirection := below;
  Anchor := _TA_w;
  Justify := _TJ_left;
  Text := 'Menubutton';
end;

function TTKMenubutton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Menu';
  if ShowAttributes >= 2 then
    Result := Result + '|Direction';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKMenubutton.SetAttribute(const Attr, Value, Typ: string);
var
  Width1: Integer;
begin
  if Attr = 'Text' then
  begin
    Width1 := PPIScale(17) + Canvas.TextWidth(Value + '    ');
    if Width < Width1 then
    begin
      Width := Width1;
      SetPositionAndSize;
    end;
  end;
  inherited;
end;

procedure TTKMenubutton.NewWidget(const Widget: string = '');
begin
  // because TKOptionMenu inherits from TTKMenubutton
  if Widget = '' then
  begin
    inherited NewWidget('ttk.Menubutton');
    InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
      AsString(Text));
  end
  else
    inherited NewWidget('ttk.OptionMenu');
end;

procedure TTKMenubutton.MakeFont;
begin
  // no font
end;

procedure TTKMenubutton.Paint;
var
  PArray: array [0 .. 2] of TPoint;
begin
  RightSpace := PPIScale(21);
  inherited;
  PArray[0].X := Width - PPIScale(12);
  PArray[0].Y := Height div 2 - PPIScale(2);
  PArray[1].X := Width - PPIScale(6);
  PArray[1].Y := Height div 2 - PPIScale(2);
  PArray[2].X := Width - PPIScale(9);
  PArray[2].Y := PArray[0].Y + PPIScale(3);
  Canvas.Pen.Color := $282828;
  Canvas.Brush.Color := $282828;
  Canvas.Polygon(PArray);
end;

{ --- TKOptionMenu ------------------------------------------------------------- }

constructor TTKOptionMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag := 49;
  FDirection := below;
  FNewItems := TStringList.Create;
  FNewItems.Text := DefaultItems;
  FOldItems := TStringList.Create;
end;

destructor TTKOptionMenu.Destroy;
begin
  FreeAndNil(FNewItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TTKOptionMenu.GetAttributes(ShowAttributes: Integer): string;
var
  Posi: Integer;
begin
  Result := '|MenuItems';
  Result := Result + inherited GetAttributes(ShowAttributes);
  Posi := Pos('|Style', Result);
  if Posi > 0 then
    Delete(Result, Posi, 6);
end;

procedure TTKOptionMenu.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited;
end;

procedure TTKOptionMenu.NewWidget(const Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + AsString(MenuItems[0]) + ')');
  MakeMenuItems;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKOptionMenu.SetItems(AItems: TStrings);
begin
  FOldItems.Text := FNewItems.Text;
  if AItems.Text <> FNewItems.Text then
    FNewItems.Assign(AItems);
end;

procedure TTKOptionMenu.MakeMenuItems;
var
  Str, AMenuItems, NewMenuTitle: string;
begin
  AMenuItems := '';
  for var I := 0 to FNewItems.Count - 1 do
  begin
    NewMenuTitle := Trim(FNewItems[I]);
    if NewMenuTitle = '' then
      Continue;
    AMenuItems := AMenuItems + ', ' + AsString(NewMenuTitle);
  end;
  Str := 'self.' + Name;
  SetAttributValue(Str, Str + ' = ttk.OptionMenu(self.root, self.' + Name + 'CV'
    + AMenuItems + ')');
end;

function TTKOptionMenu.GetText: string;
var
  Str: string;
begin
  if FNewItems.Count > 0 then
    Str := Trim(FNewItems[0]);
  if Str <> '' then
    Result := Str
  else
    Result := Text;
end;

procedure TTKOptionMenu.Paint;
var
  PArray: array [0 .. 2] of TPoint;
begin
  FOldItems.Text := FNewItems.Text;
  inherited;
  PArray[0].X := Width - 12;
  PArray[0].Y := Height div 2 - 2;
  PArray[1].X := Width - 6;
  PArray[1].Y := Height div 2 - 2;
  PArray[2].X := Width - 9;
  PArray[2].Y := PArray[0].Y + 3;
  Canvas.Pen.Color := $282828;
  Canvas.Brush.Color := $282828;
  Canvas.Polygon(PArray);
end;

end.
