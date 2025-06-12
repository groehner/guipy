{ -------------------------------------------------------------------------------
  Unit:     UTKButtonBase
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  tkinter button widgets
  ------------------------------------------------------------------------------- }

unit UTKButtonBase;

{ class hierarchy

  TKButtonBaseWidget
  TKLabel
  TKButton
  TKCheckbutton
  TKMenubutton
  TKOptionMenu
}

interface

uses
  Classes,
  Graphics,
  UBaseTKWidgets,
  UTKWidgets;

type

  // combination of text and image
  TCompound = (_TC_top, _TC_bottom, _TC_left, _TC_right, _TC_center, _TC_none);

  // for disabeling  - different to TTextState in TKTextBase
  TButtonState = (active, disabled, normal);

  TDirection = (above, below, flush, left, right);

  TKButtonBaseWidget = class(TKWidget)
  private
    FActiveForeground: TColor;
    FBitmap: string;
    FCompound: TCompound;
    FIndicatorOn: Boolean;
    FOffRelief: TRelief;
    FOverRelief: TRelief;
    FSelectColor: TColor;
    FSelectImage: string;
    FState: TButtonState;
    procedure SetBitmap(Value: string);
    procedure SetCompound(Value: TCompound);
    procedure SetIndicatorOn(Value: Boolean);
    procedure SetState(Value: TButtonState);
  protected
    procedure MakeDirection(Value: string);
    procedure CalculateText(var TextWidth, TextHeight: Integer;
      var StringList: TStringList); override;
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function GetCompound: TUCompound; override;
    procedure SizeToText; override;

    property OffRelief: TRelief read FOffRelief write FOffRelief
      default _TR_raised;
    property OverRelief: TRelief read FOverRelief write FOverRelief
      default _TR_raised;
    property IndicatorOn: Boolean read FIndicatorOn write SetIndicatorOn
      default True;
    property SelectColor: TColor read FSelectColor write FSelectColor
      default clWindow;
    property SelectImage: string read FSelectImage write FSelectImage;
  published
    property ActiveBackground;
    property ActiveForeground: TColor read FActiveForeground
      write FActiveForeground default clBtnText;
    property Anchor;
    property Bitmap: string read FBitmap write SetBitmap;
    property Compound: TCompound read FCompound write SetCompound
      default _TC_none;
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
    property State: TButtonState read FState write SetState default normal;
    property Text;
    property Underline;
    property WrapLength;
  end;

  TKLabel = class(TKButtonBaseWidget)
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
  end;

  TKButton = class(TKButtonBaseWidget)
  private
    FDefault: Boolean;
    FRepeatDelay: Integer;
    FRepeatInterval: Integer;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
  published
    property Command;
    property Default: Boolean read FDefault write FDefault default False;
    property OverRelief;
    property RepeatDelay: Integer read FRepeatDelay write FRepeatDelay
      default 0;
    property RepeatInterval: Integer read FRepeatInterval write FRepeatInterval
      default 0;
    property TakeFocus;
  end;

  TKCheckbutton = class(TKButtonBaseWidget)
  private
    FOffValue: string;
    FOnValue: string;
  protected
    procedure Paint; override;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure SizeToText; override;
  published
    property Command;
    property IndicatorOn;
    property OffRelief;
    property OverRelief;
    property OffValue: string read FOffValue write FOffValue;
    property OnValue: string read FOnValue write FOnValue;
    property SelectColor;
    property SelectImage;
    property TakeFocus;
  end;

  TKMenubutton = class(TKButtonBaseWidget)
  private
    FDirection: TDirection;
    FMenu: string;
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Direction: TDirection read FDirection write FDirection
      default below;
    property IndicatorOn;
    property Menu: string read FMenu write FMenu;
  end;

  TKOptionMenu = class(TKMenubutton)
  private
    FNewItems: TStrings;
    FOldItems: TStrings;
    procedure SetItems(Items: TStrings);
    procedure MakeMenuItems;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
    function GetText: string; override;
  published
    property IndicatorOn;
    property MenuItems: TStrings read FNewItems write SetItems;
  end;

implementation

uses
  Math,
  Controls,
  SysUtils,
  System.Types,
  UUtils,
  UGUIDesigner;

{ --- TButtonBaseWidget -------------------------------------------------------- }

constructor TKButtonBaseWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Width := 80;
  Height := 24;
  FActiveForeground := clBtnText;
  FCompound := _TC_none;
  FIndicatorOn := True;
  FOffRelief := _TR_raised;
  FOverRelief := _TR_raised;
  FSelectColor := clWindow;
  FState := normal;
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

function TKButtonBaseWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Text|Anchor';
  if ShowAttributes >= 2 then
    Result := Result + '|Bitmap|Compound|Image';
  if ShowAttributes = 3 then
    Result := Result + '|ActiveBackground|ActiveForeground|DisabledForeground' +
      '|Foreground|HighlightBackground|HighlightColor' +
      '|HighlightThickness|Justify|PadX|PadY|State|Underline|WrapLength';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TKButtonBaseWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetMouseEvents(ShowEvents);
end;

procedure TKButtonBaseWidget.MakeDirection(Value: string);
var
  Str: string;
begin
  Str := 'self.' + Name + '[''direction'']';
  SetAttributValue(Str, Str + ' = ' + AsString(Value));
end;

function TKButtonBaseWidget.GetCompound: TUCompound;
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
  else
    Result := _TU_none;
  end;
end;

procedure TKButtonBaseWidget.CalculateText(var TextWidth, TextHeight: Integer;
  var StringList: TStringList);
var
  Str: string;
  Posi: Integer;
begin
  Str := GetText;
  Posi := Pos('\n', Str);
  while Posi > 0 do
  begin
    StringList.Add(Copy(Str, 1, Posi - 1));
    Delete(Str, 1, Posi + 1);
    Posi := Pos('\n', Str);
  end;
  StringList.Add(Str);
  TextWidth := 0;
  for Posi := 0 to StringList.Count - 1 do
    TextWidth := Max(TextWidth, Canvas.TextWidth(StringList[Posi]));
  TextHeight := StringList.Count * Canvas.TextHeight('Hg');
end;

procedure TKButtonBaseWidget.SizeToText;
begin
  var
  Delta := Canvas.TextWidth(Text + 'x') - Width;
  if Delta > 0 then
    Width := Width + Delta;
  Delta := Canvas.TextHeight(Text) + 4 - Height;
  if Delta > 0 then
    Height := Height + Delta;
end;

procedure TKButtonBaseWidget.SetBitmap(Value: string);
begin
  if Value <> FBitmap then
  begin
    FBitmap := Value;
    Invalidate;
  end;
end;

procedure TKButtonBaseWidget.SetCompound(Value: TCompound);
begin
  if Value <> FCompound then
  begin
    FCompound := Value;
    Invalidate;
  end;
end;

procedure TKButtonBaseWidget.SetIndicatorOn(Value: Boolean);
begin
  if Value <> FIndicatorOn then
  begin
    FIndicatorOn := Value;
    Invalidate;
  end;
end;

procedure TKButtonBaseWidget.SetState(Value: TButtonState);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

{ --- TKLabel ------------------------------------------------------------------ }

constructor TKLabel.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 1;
  Text := 'Label';
  Anchor := _TA_w;
  HighlightThickness := '0';
end;

procedure TKLabel.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.Label');
  InsertValue('self.' + Name + '[' + AsString('anchor') + '] = ' +
    AsString('w'));
  InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
    AsString(Text));
end;

{ --- TKButton ----------------------------------------------------------------- }

constructor TKButton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 4;
  Text := 'Button';
  FDefault := False;
  FRepeatDelay := 0;
  FRepeatInterval := 0;
  Relief := _TR_raised;
  TakeFocus := True;
end;

function TKButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Command|Default';
  if ShowAttributes >= 3 then
    Result := Result + '|OverRelief|RepeatDelay|RepeatInterval';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKButton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.Button');
  InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
    AsString(Text));
  Command := True;
  ChangeCommand('Command', Name + '_Command');
end;

{ --- TKCheckbutton ------------------------------------------------------------ }

constructor TKCheckbutton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 5;
  Text := 'Checkbutton';
  FActiveForeground := clWindowText;
  FOffValue := '0';
  FOnValue := '1';
  Foreground := clWindowText;
  TakeFocus := True;
  Width := 120;
end;

function TKCheckbutton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Command';
  if ShowAttributes >= 2 then
    Result := Result + '|OffValue|OnValue';
  if ShowAttributes = 3 then
    Result := Result +
      '|IndicatorOn|OffRelief|OverRelief|SelectColor|SelectImage';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKCheckbutton.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.Checkbutton');
  MakeControlVar('variable', Name + 'CV', '0', 'Int');
  Anchor := _TA_w;
  InsertValue('self.' + Name + '[' + AsString('anchor') + '] = ' +
    AsString('w'));
  InsertValue('self.' + Name + '[' + AsString('text') + '] = ' +
    AsString(Text));
end;

procedure TKCheckbutton.Paint;
var
  ARect: TRect;
begin
  if FIndicatorOn then
    LeftSpace := PPIScale(21)
  else
    LeftSpace := 0;
  inherited;
  if FIndicatorOn then
    FGUIDesigner.vilPythonControls.Draw(Canvas, LeftSpace, TopSpace, 2)
  else
  begin
    ARect := ClientRect;
    PaintBorder(ARect, FOffRelief, BorderWidthInt);
  end;
end;

procedure TKCheckbutton.SizeToText;
begin
  var
  Delta := Canvas.TextWidth(Text) + +18 + (3 * Canvas.TextWidth('x'))
    div 2 - Width;
  if Delta > 0 then
    Width := Width + Delta;
  Delta := Canvas.TextHeight(Text) + 4 - Height;
  if Delta > 0 then
    Height := Height + Delta;
end;

{ --- TKMenubutton ------------------------------------------------------------- }

constructor TKMenubutton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 17;
  BorderWidth := '1';
  HighlightThickness := '0';
  FDirection := below;
  FIndicatorOn := False;
  PadX := '5';
  PadY := '4';
  Text := 'Menubutton';
end;

function TKMenubutton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Menu';
  if ShowAttributes >= 2 then
    Result := Result + '|Direction';
  if ShowAttributes = 3 then
    Result := Result +
      '|IndicatorOn|OffRelief|OverRelief|SelectColor|SelectImage';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKMenubutton.SetAttribute(Attr, Value, Typ: string);
var
  AWidth: Integer;
begin
  if Attr = 'Text' then
  begin
    AWidth := 17 + Canvas.TextWidth(Value + '    ');
    if Width < AWidth then
      Width := AWidth;
  end;
  inherited;
end;

procedure TKMenubutton.NewWidget(Widget: string = '');
var
  Str: string;
begin
  // because TKOptionMenu inherits from TKMenubutton
  if Widget = '' then
  begin
    Str := Surround('self.' + Name + ' = tk.Menubutton(' + getContainer + ')') +
      Surround('self.' + Name + '[' + AsString('text') + '] = ' +
      AsString(Text));
    Partner.InsertAtBegin(Str); // Menubutton must stay before a menu
    SetPositionAndSize;
  end
  else
    inherited NewWidget('tk.OptionMenu');
end;

procedure TKMenubutton.Paint;
var
  ARect: TRect;
  XPos, YPos: Integer;
begin
  if FIndicatorOn then
    RightSpace := PPIScale(21)
  else
    RightSpace := 0;
  inherited;
  if FIndicatorOn then
  begin
    ARect := ClientRect;
    ARect.Inflate(-BorderWidthInt, -BorderWidthInt);

    XPos := Width - BorderWidthInt - PPIScale(21);
    YPos := (Height - 6) div 2;
    ARect := Rect(XPos, YPos, XPos + PPIScale(15), YPos + PPIScale(6));
    Canvas.FillRect(ARect);
    PaintBorder(ARect, _TR_raised, 1);
  end;
end;

{ --- TKOptionMenu ------------------------------------------------------------- }

constructor TKOptionMenu.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 18;
  HighlightThickness := '2';
  PadX := '5';
  PadY := '4';
  FDirection := below;
  Relief := _TR_raised;
  FIndicatorOn := True;
  FNewItems := TStringList.Create;
  FNewItems.Text := DefaultItems;
  FOldItems := TStringList.Create;
end;

destructor TKOptionMenu.Destroy;
begin
  FreeAndNil(FNewItems);
  FreeAndNil(FOldItems);
  inherited;
end;

function TKOptionMenu.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|MenuItems';
  if ShowAttributes = 3 then
    Result := Result + '';
  Result := Result + inherited GetAttributes(ShowAttributes);
  if ShowAttributes = 1 then
  begin
    var
    Posi := Pos('|Menu|', Result);
    Delete(Result, Posi, 5);
  end;
end;

procedure TKOptionMenu.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'MenuItems' then
    MakeMenuItems
  else
    inherited;
end;

procedure TKOptionMenu.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  InsertValue('self.' + Name + 'CV = tk.StringVar()');
  InsertValue('self.' + Name + 'CV.set(' + AsString(MenuItems[0]) + ')');
  MakeMenuItems;
  SetPositionAndSize;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKOptionMenu.SetItems(Items: TStrings);
begin
  FOldItems.Text := FNewItems.Text;
  if Items.Text <> FNewItems.Text then
    FNewItems.Assign(Items);
end;

procedure TKOptionMenu.MakeMenuItems;
var
  Str, MenuItems, NewMenuTitle: string;
begin
  MenuItems := '';
  for var I := 0 to FNewItems.Count - 1 do
  begin
    NewMenuTitle := Trim(FNewItems[I]);
    if NewMenuTitle = '' then
      Continue;
    MenuItems := MenuItems + ', ' + AsString(NewMenuTitle);
  end;
  Str := 'self.' + Name;
  SetAttributValue(Str, Str + ' = tk.OptionMenu(self.root, self.' + Name + 'CV'
    + MenuItems + ')');
end;

procedure TKOptionMenu.Paint;
begin
  FOldItems.Text := FNewItems.Text;
  inherited;
end;

function TKOptionMenu.GetText: string;
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

end.
