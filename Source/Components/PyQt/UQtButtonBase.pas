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
  Windows,
  Graphics,
  Classes,
  UBaseQtWidgets;

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
    FCheckable: Boolean;
    FChecked: Boolean;
    FAutoRepeat: Boolean;
    FAutoExclusive: Boolean;
    FAutoRepeatDelay: Integer;
    FAutoRepeatInterval: Integer;
    FClicked: string;
    FPressed: string;
    FReleased: string;
    FToggled: string;
    procedure SetText(const Value: string);
    procedure SetIcon(const Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetClicked(const Value: string);
    function GetIconAsBitmap: TBitmap;
  protected
    FPaintFlat: Boolean;
    FPaintStyle: Integer;
    FPaintArrow: Integer;
    procedure MakeClickEvent;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure Paint; override;
    procedure MakeIcon(const Value: string);
    procedure MakeShortcut(const Value: string);
    procedure SizeToText; override;
  published
    property Font;
    property Text: string read FText write SetText;
    property Icon: string read FIcon write SetIcon;
    property Shortcut: string read FShortcut write FShortcut;
    property Checkable: Boolean read FCheckable write FCheckable;
    property Checked: Boolean read FChecked write SetChecked;
    property AutoRepeat: Boolean read FAutoRepeat write FAutoRepeat;
    property AutoExclusive: Boolean read FAutoExclusive write FAutoExclusive;
    property AutoRepeatDelay: Integer read FAutoRepeatDelay write FAutoRepeatDelay;
    property AutoRepeatInterval: Integer read FAutoRepeatInterval write FAutoRepeatInterval;
    //signals
    property clicked: string read FClicked write SetClicked;
    property pressed: string read FPressed write FPressed;
    property released: string read FReleased write FReleased;
    property toggled: string read FToggled write FToggled;
  end;

  TQtPushButton = class(TQtAbstractButton)
  private
    FAutoDefault: Boolean;
    FDefault: Boolean;
    FFlat: Boolean;
    procedure SetFlat(Value: Boolean);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property AutoDefault: Boolean read FAutoDefault write FAutoDefault;
    property Default_: Boolean read FDefault write FDefault;
    property Flat: Boolean read FFlat write SetFlat;
  end;

  TQtToolButton = class(TQtAbstractButton)
  private
    FAutoRaise: Boolean;
    FArrowType: TArrowType;
    FPopupMode: TPopopMode;
    FToolButtonStyle: TToolButtonStyle;
    FTriggered: string;
    procedure SetArrowType(Value: TArrowType);
    procedure SetAutoRaise(Value: Boolean);
    procedure SetToolButtonStyle(Value: TToolButtonStyle);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property PopupMode: TPopopMode read FPopupMode write FPopupMode;
    property ToolButtonStyle: TToolButtonStyle read FToolButtonStyle write SetToolButtonStyle;
    property AutoRaise: Boolean read FAutoRaise write SetAutoRaise;
    property ArrowType: TArrowType read FArrowType write SetArrowType;
    // signals
    property triggered: string read FTriggered write FTriggered;
  end;

  TQtRadioButton = class(TQtAbstractButton)
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  end;

  TQtCheckBox = class(TQtAbstractButton)
  private
    FTristate: Boolean;
    FStateChanged: string;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
    procedure SizeToText; override;
  published
    property Tristate: Boolean read FTristate write FTristate;
    // signals
    property stateChanged: string read FStateChanged write FStateChanged;
  end;

  TQtCommandLinkButton = class(TQtPushButton)
  private
    FDescription: string;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property Description: string read FDescription write FDescription;
  end;

implementation

uses
  Controls,
  Math,
  Types,
  SysUtils,
  UGUIDesigner,
  UUtils;

{--- TQtAbstractButton ---------------------------------------------------------}

constructor TQtAbstractButton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FText:= '';
  FIcon:= '';
  Height:= 24;
  Width:= 80;
  FShortcut:= '';
  FCheckable:= False;
  FChecked:= False;
  FAutoRepeat:= False;
  FAutoExclusive:= False;
  FAutoRepeatDelay:= 300;
end;

function TQtAbstractButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Icon|Text|';
  if ShowAttributes >= 2 then
    Result:= Result + '|Checkable|Checked|Shortcut|';
  if ShowAttributes = 3 then
    Result:= Result + '|AutoRepeat|AutoExclusive|AutoRepeatDelay|AutoRepeatInterval|';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

function TQtAbstractButton.GetEvents(ShowEvents: Integer): string;
begin
  Result:= '|clicked|pressed|released|toggled';
  Result:= Result + inherited GetEvents(ShowEvents);
end;

function TQtAbstractButton.HandlerInfo(const Event: string): string;
begin
  if (Event = 'clicked') or (Event = 'toggled') then
    Result:= 'bool;checked'
  else
    Result:= inherited;
end;

procedure TQtAbstractButton.GetSlots(const Parametertypes: string; Slots: TStrings);
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
  var TextX, TextY, TextWidth, TextHeight, XPos, YPos, BmpY, MaxW, MaxH,
      Gtg, BoxX, BoxY: Integer;
      Pathname: string;
      StringList: TStringList;
      Bmp: TBitmap;

  procedure ShowText(ARect: TRect);
  begin
    var Str:= StringList.Text;
    if Trim(Str) = '' then
      Exit;
    DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_LEFT);
  end;

begin
  inherited;
  if FPaintFlat then begin
    Canvas.Brush.Color:= $F0F0F0;
    Canvas.Pen.Color:= $F0F0F0;
  end else begin
    Canvas.Brush.Color:= $E1E1E1;
    Canvas.Pen.Color:= $ADADAD;
  end;
  Canvas.Rectangle(ClientRect);
  StringList:= TStringList.Create;
  CalculateText(FText, TextWidth, TextHeight, StringList);
  if LeftSpace <> PPIScale(18) then
    LeftSpace:= 0;
  try
    Pathname:= FGUIDesigner.getPath + 'images\' + Copy(Icon, 8, Length(Icon));
    if not (FileExists(Pathname) or (FPaintArrow > 0)) or (FPaintStyle = 2) then begin
      // without graphic
      if FPaintStyle = 3 then begin // Radio- or CheckButton
        XPos:= LeftSpace;
        TopSpace:= (Height - PPIScale(15)) div 2;
      end else
        XPos:= (Width - TextWidth - LeftSpace) div 2 + LeftSpace;
      YPos:= (Height - TextHeight) div 2;
      ShowText(Rect(XPos, YPos, XPos + TextWidth, YPos + TextHeight));
    end else begin
      // with graphic
      if FPaintStyle in [1, 5] then // icon only, follow style
        TextWidth:= 0;
      Bmp:= GetIconAsBitmap;
      Gtg:= 1; // GraphicTextGap
      MaxW:= Bmp.Width + Gtg + TextWidth;
      MaxH:= Max(TextHeight, Bmp.Height);
      if MaxW > Width then
        Width:= MaxW;

      // BoxX, BoxY = position of compound box of graphic and text
      // MaxW, MaxH = size of compound box
      BoxX:= (Width - MaxW) div 2 + LeftSpace;
      BoxY:= (Height - MaxH) div 2;
      BmpY:= (Height - Bmp.Height) div 2;

      if FPaintStyle = 3 then // beside icon
        BoxX:= 2 + LeftSpace;
      TextX:= BoxX + Bmp.Width + Gtg;
      TextY:= (Height - TextHeight) div 2;

      if FPaintStyle = 4 then begin // under icon
        BoxX:= (Width - Bmp.Width) div 2;
        BmpY:= 0;
        TextX:= (Width - TextWidth) div 2;
        TextY:= Height div 2 + 3;
      end;

      if (FPaintStyle = 0) and (FText <> '') or (FPaintStyle in [3, 4]) then
        ShowText(Rect(TextX, TextY, TextX+TextWidth, TextY+TextHeight));
      Canvas.Draw(BoxX, BmpY, Bmp);

      // for debugging
      // ARect:= rect(min(BoxX,TextX), min(BmpY,TextY), max(BoxX+Bmp.Width,TextX+tw), max(BmpY+Bmp.Height, TextY+th));
      // Canvas.DrawFocusRect(ARect);

      // for use in Checkbutton and Radiobutton
      TopSpace:= BoxY + MaxH div 2 - PPIScale(10);
      FreeAndNil(Bmp);
    end;
  finally
    FreeAndNil(StringList);
    LeftSpace:= 0;
  end;
end;

function TQtAbstractButton.GetIconAsBitmap: TBitmap;
  var Bmp: Graphics.TBitmap;
begin
  if FPaintArrow in [1..4] then begin // ToolButton/ArrowType
    Bmp:= Graphics.TBitmap.Create;
    Bmp.Width:= 19;
    Bmp.Height:= 19;
    if FPaintFlat then begin
      Bmp.Canvas.Brush.Color:= $F0F0F0;
      Bmp.Canvas.Pen.Color:= $F0F0F0;
    end else begin
      Bmp.Canvas.Brush.Color:= $E1E1E1;
      Bmp.Canvas.Pen.Color:= $ADADAD;
    end;
    Bmp.Canvas.FillRect(Rect(0, 0, 18, 18));
    Bmp.Canvas.Pen.Color:= clBlack;
    Bmp.Canvas.Brush.Color:= clBlack;
    case FPaintArrow of
      1: Bmp.Canvas.Polygon([Point( 3, 12), Point(15, 12), Point( 9,  6)]);
      2: Bmp.Canvas.Polygon([Point( 3,  6), Point(15,  6), Point( 9, 12)]);
      3: Bmp.Canvas.Polygon([Point(12, 15), Point(12,  3), Point( 6,  9)]);
      4: Bmp.Canvas.Polygon([Point(6,  15), Point( 6,  3), Point(12,  9)]);
    end;
  end else begin
    Bmp:= BitmapFromRelativePath(Icon);
    if not Assigned(Bmp) and (FPaintArrow = 5) then begin // CommandLinkButton
      Bmp:= Graphics.TBitmap.Create;
      Bmp.Width:= 30;
      Bmp.Height:= 20;
      if FPaintFlat then begin
        Bmp.Canvas.Brush.Color:= $F0F0F0;
        Bmp.Canvas.Pen.Color:= $F0F0F0;
      end else begin
        Bmp.Canvas.Brush.Color:= $E1E1E1;
        Bmp.Canvas.Pen.Color:= $ADADAD;
      end;
      Bmp.Canvas.FillRect(Rect(0, 0, 30, 20));
      Bmp.Canvas.Pen.Color:= $DD953B; // blue
      Bmp.Canvas.Pen.Width:= 2;
      Bmp.Canvas.MoveTo(6, 11);
      Bmp.Canvas.LineTo(23, 11);
      Bmp.Canvas.LineTo(18, 6);
      Bmp.Canvas.MoveTo(23, 11);
      Bmp.Canvas.LineTo(18, 16);
    end;
  end;
  Result:= Bmp;
end;

procedure TQtAbstractButton.SetText(const Value: string);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.SetIcon(const Value: string);
begin
  if Value <> FIcon then begin
    FIcon:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.SetChecked(Value: Boolean);
begin
  if Value <> FChecked then begin
    FChecked:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.SetClicked(const Value: string);
begin
  if Value <> FClicked then begin
    FClicked:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractButton.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Icon' then
    MakeIcon(Value)
  else if Attr = 'Shortcut' then
    MakeShortcut(Value)
  else
    inherited;
end;

procedure TQtAbstractButton.MakeIcon(const Value: string);
  var Str, Key, Dest, Filename, Path: string;
      Bmp: TBitmap;
begin
  // ToDo use PIL if png-file selected
  Key:= 'self.' + Name + '.setIcon';
  if Value = '(Image)' then begin
    Partner.DeleteAttribute(Key);
    Partner.DeleteAttribute(Key + 'Size');
  end else begin
    Filename:= ExtractFileName(Value);
    if Pos('images/', Filename) = 1 then
      System.Delete(Filename, 1, 7);
    Path:= ExtractFilePath(Partner.Pathname);
    Dest:= Path + 'images\' + Filename;
    ForceDirectories(Path + 'images\');
    if not FileExists(Dest) then
      CopyFile(PChar(Value), PChar(Dest), True);
    FIcon:= 'images/' + Filename;
    Str:= Key + '(QIcon(' + AsString(FIcon) + '))';
    SetAttributValue(Key, Str);
    Key:= Key + 'Size';
    Bmp:= GetIconAsBitmap;
    Str:= Key + '(QSize(' + IntToStr(Bmp.Width) + ', ' + IntToStr(Bmp.Height) + '))';
    SetAttributValue(Key, Str);
    FreeAndNil(Bmp);
    UpdateObjectInspector;
  end;
end;

procedure TQtAbstractButton.MakeShortcut(const Value: string);
  var Str, Key: string;
begin
  Key:= 'self.' + Name + '.setShortcut';
  if Value = '' then
    Partner.DeleteAttribute(Key)
  else begin
    Str:= Key + '(QKeySequence(' + AsString(Value) + '))';
    SetAttributValue(Key, Str);
  end;
end;

procedure TQtAbstractButton.SizeToText;
begin
  var Delta:= Canvas.TextWidth(Text) + 3*HalfX - Width;
  if Delta > 0 then Width:= Width + Delta;
  Delta:= Canvas.TextHeight(Text)+ 4 - Height;
  if Delta > 0 then Height:= Height + Delta;
end;

procedure TQtAbstractButton.MakeClickEvent;
begin
  clicked:= HandlerName('Clicked');
  SetEvent('clicked');
  UpdateObjectInspector;
end;

{--- TQtPushButton -------------------------------------------------------------}

constructor TQtPushButton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 74;
  FText:= 'PushButton';
end;

function TQtPushButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|AutoDefault|Default_|Flat';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtPushButton.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Default_'
    then inherited SetAttribute('Default', Value, Typ)
    else inherited;
end;

procedure TQtPushButton.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.ShowMenu');
  inherited;
end;

procedure TQtPushButton.NewWidget(const Widget: string = '');
begin
  if Widget = ''
    then inherited NewWidget('QPushButton')
    else inherited NewWidget(Widget);
  SetAttribute('Text', 'PushButton', 'Text');
  MakeClickEvent;
end;

procedure TQtPushButton.Paint;
  var ARect: TRect;
begin
  if FFlat then
    FPaintFlat:= True;
  inherited;
  if Default_ and not FFlat then begin
    Canvas.Brush.Color:= $D77800;
    ARect:= ClientRect;
    Canvas.FrameRect(ARect);
    ARect.Inflate(-1, -1);
    Canvas.FrameRect(ARect);
  end;
  FPaintFlat:= False;
end;

procedure TQtPushButton.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then begin
    FFlat:= Value;
    Invalidate;
  end;
end;

{--- TQtToolButton ------------------------------------------------------------}

constructor TQtToolButton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 103;
  Width:= 24;
  FText:= '...';
  FocusPolicy:= TabFocus;
  FPopupMode:= DelayedPopup;
  FToolButtonStyle:= ToolButtonIconOnly;
  FArrowType:= NoArrow;
end;

function TQtToolButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|PopupMode|ToolButtonStyle|AutoRaise|ArrowType|';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtToolButton.SetAttribute(const Attr, Value, Typ: string);
begin
  if (Attr = 'ToolButtonStyle') or (Attr = 'ArrowType') then
    MakeAttribut(Attr, 'Qt.' + Attr + '.' + Value)
  else if Attr = 'PopupMode'  then
    MakeAttribut(Attr, 'QToolButton.ToolButtonPopupMode.' + Value)
  else
    inherited;
end;

function TQtToolButton.GetEvents(ShowEvents: Integer): string;
begin
  Result:= '|triggered';
  Result:= Result + inherited GetEvents(ShowEvents);
end;

function TQtToolButton.HandlerInfo(const Event: string): string;
begin
  if Event = 'triggered' then
    Result:= 'QAction;action'
  else
    Result:= inherited;
end;

procedure TQtToolButton.GetSlots(const Parametertypes: string; Slots: TStrings);
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
    FPaintFlat:= True;
  FPaintStyle:= Ord(FToolButtonStyle) + 1;
  FPaintArrow:= Ord(FArrowType);
  inherited;
  FPaintFlat:= False;
  FPaintStyle:= 0;
  FPaintArrow:= 0;
end;

procedure TQtToolButton.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QToolButton');
  SetAttribute('Text', '...', 'Text');
  MakeClickEvent;
end;

procedure TQtToolButton.SetArrowType(Value: TArrowType);
begin
  if Value <> FArrowType then begin
    FArrowType:= Value;
    Invalidate;
  end;
end;

procedure TQtToolButton.SetAutoRaise(Value: Boolean);
begin
  if Value <> FAutoRaise then begin
    FAutoRaise:= Value;
    Invalidate;
  end;
end;

procedure TQtToolButton.SetToolButtonStyle(Value: TToolButtonStyle);
begin
  if Value <> FToolButtonStyle then begin
    FToolButtonStyle:= Value;
    Invalidate;
  end;
end;

{--- TQtRadioButton ------------------------------------------------------------}

constructor TQtRadioButton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 76;
  FText:= 'RadioButton';
  MouseTracking:= True;
  FCheckable:= True;
  FAutoExclusive:= True;
end;

function TQtRadioButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Checked';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtRadioButton.Paint;
begin
  FPaintFlat:= True;
  FPaintStyle:= 3;
  LeftSpace:= PPIScale(18);
  inherited;
  if FChecked
    then FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 3)
    else FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 2);
  FPaintFlat:= False;
  FPaintStyle:= 0;
end;

procedure TQtRadioButton.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QRadioButton');
  SetAttribute('Text', 'RadioButton', 'Text');
end;

{--- TQtCheckBox ---------------------------------------------------------------}

constructor TQtCheckBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 75;
  FText:= 'CheckBox';
  MouseTracking:= True;
  FCheckable:= True;
end;

function TQtCheckBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Checked|Tristate';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

function TQtCheckBox.GetEvents(ShowEvents: Integer): string;
begin
  Result:= '|stateChanged';
  Result:= Result + inherited GetEvents(ShowEvents);
end;

function TQtCheckBox.HandlerInfo(const Event: string): string;
begin
  if Event = 'stateChanged' then
    Result:= 'int;state'
  else
    Result:= inherited;
end;

procedure TQtCheckBox.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QCheckBox');
  SetAttribute('Text', 'CheckBox', 'Text');
end;

procedure TQtCheckBox.Paint;
begin
  FPaintFlat:= True;
  FPaintStyle:= 3;
  LeftSpace:= PPIScale(18);
  inherited;
  if FChecked
    then FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 1)
    else FGUIDesigner.vilQtControls1616.Draw(Canvas, 0, TopSpace, 0);
  FPaintFlat:= False;
  FPaintStyle:= 0;
end;

procedure TQtCheckBox.SizeToText;
begin
  var Delta:= Canvas.TextWidth(Text) + PPIScale(18) + 3*HalfX - Width;
  if Delta > 0 then Width:= Width + Delta;
  Delta:= Canvas.TextHeight(Text)+ PPIScale(4) - Height;
  if Delta > 0 then Height:= Height + Delta;
end;

{--- TQtCommandLinkButton -----------------------------------------------------}

constructor TQtCommandLinkButton.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 104;
  Width:= 184;
  Height:= 40;
  FText:= 'CommandLinkButton';
  FPaintFlat:= True;
  FPaintArrow:= 5;
  FPaintStyle:= 3;
end;

function TQtCommandLinkButton.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Description';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtCommandLinkButton.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QCommandLinkButton');
  SetAttribute('Text', 'CommandLinkButton', 'Text');
  MakeClickEvent;
end;

end.
