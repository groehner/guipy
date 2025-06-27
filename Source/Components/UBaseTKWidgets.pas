{ -------------------------------------------------------------------------------
  Unit:     UBaseTkWidgets
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  base widget of Tkinter and TTKinter
  ------------------------------------------------------------------------------- }

unit UBaseTKWidgets;

interface

uses
  Windows,
  Graphics,
  Classes,
  ELEvents,
  UBaseWidgets;

type

  // Relief
  TRelief = (_TR_flat, _TR_groove, _TR_raised, _TR_ridge, _TR_solid,
    _TR_sunken);

  // positioning of text, used in TextWidget
  TAnchor = (_TA_nw, _TA_n, _TA_ne, _TA_w, _TA_center, _TA_e, _TA_sw,
    _TA_s, _TA_se);

  // used in Text and Labeled
  TJustify = (_TJ_left, _TJ_center, _TJ_right);

  TUCompound = (_TU_top, _TU_bottom, _TU_left, _TU_right, _TU_center, _TU_none,
    _TU_image, _TU_text); // united Compound

  TScrollbar = (_TB_none, _TB_horizontal, _TB_vertical, _TB_both);

  TSide = (_TS_none, _TS_left, _TS_right, _TS_bottom, _TS_top);

  TBaseTkWidget = class(TBaseWidget)
  private
    FAnchor: TAnchor;
    FBackground: TColor;
    FForeground: TColor;
    FBorderWidth: string;
    FCommand: Boolean;
    FImage: string;
    FJustify: TJustify;
    FRelief: TRelief;
    FScrollbar: Boolean;
    FScrollbars: TScrollbar;
    FTakeFocus: Boolean;
    FUnderline: Integer;
    FWrapLength: string;
    // events
    FActivate: TEvent;
    FButtonPress: TEvent;
    FButtonRelease: TEvent;
    FConfigure: TEvent;
    FDeactivate: TEvent;
    FEnter: TEvent;
    FFocusIn: TEvent;
    FFocusOut: TEvent;
    FKeyPress: TEvent;
    FKeyRelease: TEvent;
    FLeave: TEvent;
    FMotion: TEvent;
    FMouseWheel: TEvent;
    procedure SetAnchor(AValue: TAnchor);
    procedure SetBackground(AColor: TColor);
    procedure SetForeground(AColor: TColor);
    procedure SetBorderWidth(AValue: string);
    procedure SetMenu(Value: string);
    procedure SetImage(AValue: string);
    procedure SetJustify(AValue: TJustify);
    procedure SetRelief(AValue: TRelief);
    procedure SetUnderline(AValue: Integer);
    procedure SetWrapLength(AValue: string);
    procedure MakeBoolean(Attr, Value: string);
    procedure MakeShow(Value: string);
  protected
    FNameExtension: string; // used by LabeledScale
    FBorderWidthInt: Integer;
    FLeftSpace: Integer;
    FRightSpace: Integer;
    FTopSpace: Integer;
    function GetMouseEvents(ShowEvents: Integer): string; virtual;
    function GetKeyboardEvents(ShowEvents: Integer): string; virtual;
    function GetCompound: TUCompound; virtual; abstract;
    function GetAttrAsKey(Attr: string): string;
    procedure Calculate3DColors(var DarkColor, LightColor: TColor;
      Background: TColor);
    procedure CalculatePadding(var PaddingLeft, PaddingTop, PaddingRight,
      PaddingBottom: Integer); virtual; abstract;
    procedure CalculateText(var TextWidth, TextHeight: Integer;
      var StringList: TStringList); virtual; abstract;
    procedure AddParameter(const Value, Par: string);
    procedure MakeControlVar(Variable, ControlVar: string; Value: string = '';
      Typ: string = 'String');
    procedure MakeImage(const Value: string);
    procedure MakeValidateCommand(Attr, Value: string);
    procedure MakeScrollbar(Value, TkTyp: string);
    procedure MakeScrollbars(Value, TkTyp: string);
    procedure PaintAScrollbar(Value: Boolean);
    procedure PaintScrollbars(Scrollbar: TScrollbar);
    procedure SetScrollbar(Value: Boolean);
    procedure SetScrollbars(Value: TScrollbar);
    procedure ShowText(Text: string; NewWidth, NewHeight: Integer);
    procedure Paint; override;
    procedure PaintBorder(Rect: TRect; Relief: TRelief; BorderWidth: Integer);
      virtual; abstract;
    procedure PaintScrollbar(Rect: TRect; Horizontal: Boolean;
      TTK: Boolean = False);
    procedure ChangeCommand(Attr, Value: string);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    procedure SetEvent(Event: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure DeleteEvents; override;
    procedure DeleteWidget; override;
    procedure DeleteEventHandler(const Event: string); override;
    procedure NewWidget(Widget: string = ''); override;
    function MakeBinding(Eventname: string): string; override;
    function MakeHandler(const Event: string): string; override;
    procedure Resize; override;
    procedure SetPositionAndSize; override;
    function ClientRectWithoutScrollbars: TRect;
    function GetType: string; override;
    function GetNameAndType: string; override;
    function GetContainer: string;
    procedure MakeFont; override;

    property Anchor: TAnchor read FAnchor write SetAnchor default _TA_center;
    property Background: TColor read FBackground write SetBackground
      default clBtnFace;
    property BorderWidth: string read FBorderWidth write SetBorderWidth;
    property BorderWidthInt: Integer read FBorderWidthInt write FBorderWidthInt;
    property Command: Boolean read FCommand write FCommand;
    property Foreground: TColor read FForeground write SetForeground
      default clWindowText;
    property Image: string read FImage write SetImage;
    property Justify: TJustify read FJustify write SetJustify
      default _TJ_center;
    property Relief: TRelief read FRelief write SetRelief default _TR_flat;
    property Scrollbars: TScrollbar read FScrollbars write SetScrollbars
      default _TB_none;
    property Scrollbar: Boolean read FScrollbar write SetScrollbar
      default False;
    property TakeFocus: Boolean read FTakeFocus write FTakeFocus default True;
    property Underline: Integer read FUnderline write SetUnderline default -1;
    property WrapLength: string read FWrapLength write SetWrapLength;
    property LeftSpace: Integer read FLeftSpace write FLeftSpace;
    property RightSpace: Integer read FRightSpace write FRightSpace;
    property TopSpace: Integer read FTopSpace write FTopSpace;
  published
    property Activate: TEvent read FActivate write FActivate;
    property ButtonPress: TEvent read FButtonPress write FButtonPress;
    property ButtonRelease: TEvent read FButtonRelease write FButtonRelease;
    property Configure: TEvent read FConfigure write FConfigure;
    property Deactivate: TEvent read FDeactivate write FDeactivate;
    property Enter: TEvent read FEnter write FEnter;
    property FocusIn: TEvent read FFocusIn write FFocusIn;
    property FocusOut: TEvent read FFocusOut write FFocusOut;
    property KeyPress: TEvent read FKeyPress write FKeyPress;
    property KeyRelease: TEvent read FKeyRelease write FKeyRelease;
    property Leave: TEvent read FLeave write FLeave;
    property Motion: TEvent read FMotion write FMotion;
    property MouseWheel: TEvent read FMouseWheel write FMouseWheel;
  end;

  TKMainWindow = class(TBaseWidget)
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerParameter(const Event: string): string; override;
    function HandlerName(const Event: string): string; override;
  end;

implementation

uses
  Math,
  Controls,
  SysUtils,
  UITypes,
  UGUIForm,
  UTKMiscBase,
  UTTKMiscBase,
  UGUIDesigner,
  UObjectInspector,
  UUtils,
  ULink,
  UConfiguration;

const
  CrLf = #13#10;

constructor TBaseTkWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Width := 100;
  Height := 100;
  FAnchor := _TA_center;
  FBackground := clBtnFace; // SystemButtonFace
  FForeground := clWindowText; // SystemWindowText
  FBorderWidth := '2';
  FJustify := _TJ_center;
  FNameExtension := '';
  FRelief := _TR_flat;
  FTakeFocus := True;
  FUnderline := -1;
  FWrapLength := '0';
  Font.Name := GuiPyOptions.GuiFontName;
  // 'Segoe UI';   // TkDefaultFont and TkTextFont
  Font.Size := GuiPyOptions.GuiFontSize;
  Font.Style := [];
  HelpType := htContext;
  Sizeable := True;

  FButtonPress := TEvent.Create(Self, 'ButtonPress');
  FButtonRelease := TEvent.Create(Self, 'ButtonRelease');
  FKeyPress := TEvent.Create(Self, 'KeyPress');
  FKeyRelease := TEvent.Create(Self, 'KeyRelease');
  FActivate := TEvent.Create(Self, 'Activate');
  FConfigure := TEvent.Create(Self, 'Configure');
  FDeactivate := TEvent.Create(Self, 'Deactivate');
  FEnter := TEvent.Create(Self, 'Enter');
  FFocusIn := TEvent.Create(Self, 'FocusIn');
  FFocusOut := TEvent.Create(Self, 'FocusOut');
  FLeave := TEvent.Create(Self, 'Leave');
  FMouseWheel := TEvent.Create(Self, 'MouseWheel');
  FMotion := TEvent.Create(Self, 'Motion');
end;

destructor TBaseTkWidget.Destroy;
begin
  FActivate.Destroy;
  FButtonPress.Destroy;
  FButtonRelease.Destroy;
  FConfigure.Destroy;
  FDeactivate.Destroy;
  FEnter.Destroy;
  FFocusIn.Destroy;
  FFocusOut.Destroy;
  FKeyPress.Destroy;
  FKeyRelease.Destroy;
  FLeave.Destroy;
  FMotion.Destroy;
  FMouseWheel.Destroy;
  inherited;
end;

function TBaseTkWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Name|Font';
  if ShowAttributes >= 2 then
    Result := Result + '|BorderWidth|Relief';
  if ShowAttributes = 3 then
    Result := Result + '|Cursor|Left|Top|Height|Width|TakeFocus';
end;

function TBaseTkWidget.GetMouseEvents(ShowEvents: Integer): string;
begin
  Result := MouseEvents1;
  if ShowEvents >= 2 then
    Result := MouseEvents1 + MouseEvents2;
  if ShowEvents = 3 then
    Result := AllEvents;
  Result := Result + '|';
end;

function TBaseTkWidget.GetKeyboardEvents(ShowEvents: Integer): string;
begin
  Result := KeyboardEvents1;
  if ShowEvents = 3 then
    Result := AllEvents;
  Result := Result + '|';
end;

procedure TBaseTkWidget.PaintScrollbar(Rect: TRect; Horizontal: Boolean;
  TTK: Boolean = False);
var
  Mid, Int3, Int4, Int6, Int9, Int10, Int18: Integer;
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(Rect);
  Canvas.Brush.Color := $CDCDCD;
  Canvas.Pen.Color := clWhite;
  Int3 := PPIScale(3);
  Int4 := PPIScale(4);
  Int6 := PPIScale(6);
  Int9 := PPIScale(9);
  Int10 := PPIScale(10);
  Int18 := PPIScale(18);
  if Horizontal then
  begin
    Canvas.MoveTo(Rect.Left, Rect.Top);
    Canvas.LineTo(Rect.Right, Rect.Top);
    Canvas.Pen.Color := $606060;
    Mid := (Rect.Top + Rect.Bottom) div 2;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Rect.Left + Int9 + I, Mid - Int3);
      Canvas.LineTo(Rect.Left + Int6 + I, Mid);
      Canvas.LineTo(Rect.Left + Int10 + I, Mid + Int4);
    end;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Rect.Right - Int9 + I, Mid - Int3);
      Canvas.LineTo(Rect.Right - Int6 + I, Mid);
      Canvas.LineTo(Rect.Right - Int10 + I, Mid + Int4);
    end;
    if TTK then
    begin
      Rect.Left := Rect.Left + Int18;
      Rect.Right := Rect.Right - Int18;
    end
    else
    begin
      Rect.Left := Rect.Left + Int18;
      Rect.Right := Rect.Left + Int18;
    end;
  end
  else
  begin
    Canvas.MoveTo(Rect.Left, Rect.Top);
    Canvas.LineTo(Rect.Left, Rect.Bottom);
    Canvas.Pen.Color := $606060;
    Mid := (Rect.Left + Rect.Right) div 2;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Mid - Int3, Rect.Top + Int9 + I);
      Canvas.LineTo(Mid, Rect.Top + Int6 + I);
      Canvas.LineTo(Mid + Int4, Rect.Top + Int10 + I);
    end;
    for var I := 0 to 2 do
    begin
      Canvas.MoveTo(Mid - Int3, Rect.Bottom - Int9 + I);
      Canvas.LineTo(Mid, Rect.Bottom - Int6 + I);
      Canvas.LineTo(Mid + Int4, Rect.Bottom - Int10 + I);
    end;
    if TTK then
    begin
      Rect.Top := Rect.Top + Int18;
      Rect.Bottom := Rect.Bottom - Int18;
    end
    else
    begin
      Rect.Top := Rect.Top + Int18;
      Rect.Bottom := Rect.Top + Int18;
    end;
  end;
  Rect.Inflate(-1, -1);
  Canvas.FillRect(Rect);
end;

procedure TBaseTkWidget.Paint;
var
  TextX, TextY, TextWidth, TextHeight, XPos, YPos, BmpW, BmpH, BmpX, BmpY, MaxW,
    MaxH, Mgw, Mtw, Gtg, BoxX, BoxY, PaddingL, PaddingT, PaddingR, PaddingB,
    Center: Integer;
  Pathname: string;
  Bmp: Graphics.TBitmap;
  StringList: TStringList;
  Compound: TUCompound;

  procedure ShowText(Rect: TRect);
  var
    Format: Integer;
    WarpLen: Double;
    Text: string;
  begin
    case Justify of
      _TJ_left:
        Format := DT_LEFT;
      _TJ_center:
        Format := DT_CENTER;
    else
      Format := DT_RIGHT;
    end;
    Text := StringList.Text;
    if Trim(Text) = '' then
      Exit;
    if FUnderline >= 0 then
      insert('&', Text, FUnderline + 1);
    if TryStrToFloat(FWrapLength, WarpLen) and (WarpLen > 0) and
      (WarpLen < TextWidth) then
    begin
      Format := Format + DT_WORDBREAK + DT_NOFULLWIDTHCHARBREAK;
      Rect.Left := Rect.Left + TextWidth div 2 - Round(WarpLen / 2);
      Rect.Right := Rect.Left + Round(WarpLen);
      Rect.Bottom := Rect.Top + Round((TextHeight * TextWidth) / WarpLen);
    end;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Format);
  end;

begin
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := FForeground;
  Canvas.Brush.Color := FBackground;
  if (Parent is TKPanedWindow) or (Parent is TTKPanedWindow) then
    Parent.Invalidate;
  Canvas.FillRect(ClientRect);
  PaintBorder(ClientRectWithoutScrollbars, Relief, FBorderWidthInt);
  CalculatePadding(PaddingL, PaddingT, PaddingR, PaddingB);
  StringList := TStringList.Create;
  try
    CalculateText(TextWidth, TextHeight, StringList);
    Compound := GetCompound;
    if Compound = _TU_image then
    begin
      TextWidth := 0;
      TextHeight := 0;
    end;
    if FLeftSpace <> PPIScale(21) then
      FLeftSpace := 0;
    if FRightSpace <> PPIScale(21) then
      FRightSpace := 0;

    Pathname := FGUIDesigner.getPath + 'images\' +
      Copy(Image, 8, Length(Image));
    if (Image = '') or not FileExists(Pathname) or (Compound = _TU_text) then
    begin
      // without graphic
      Center := (Width - TextWidth - FLeftSpace - FRightSpace) div 2 +
        FLeftSpace;
      case FAnchor of
        _TA_nw:
          begin
            XPos := PaddingL + FLeftSpace;
            YPos := 1 + PaddingT;
          end;
        _TA_n:
          begin
            XPos := Center;
            YPos := 1 + PaddingT;
          end;
        _TA_ne:
          begin
            XPos := Width - 3 - TextWidth - PaddingR - FRightSpace;
            YPos := 1 + PaddingT;
          end;
        _TA_w:
          begin
            XPos := PaddingL + FLeftSpace;
            YPos := (Height - TextHeight) div 2;
          end;
        _TA_center:
          begin
            XPos := Center;
            YPos := (Height - TextHeight) div 2;
          end;
        _TA_e:
          begin
            XPos := Width - 3 - TextWidth - PaddingR - FRightSpace;
            YPos := (Height - TextHeight) div 2;
          end;
        _TA_sw:
          begin
            XPos := PaddingL + FLeftSpace;
            YPos := Height - 1 - TextHeight - PaddingB;
          end;
        _TA_s:
          begin
            XPos := Center;
            YPos := Height - 1 - TextHeight - PaddingB;
          end;
        _TA_se:
          begin
            XPos := Width - 3 - TextWidth - PaddingR - FRightSpace;
            YPos := Height - 1 - TextHeight - PaddingB;
          end;
      else
        begin
          XPos := 0;
          YPos := 0;
        end;
      end;
      TextWidth := Min(TextWidth, Width - FRightSpace);
      ShowText(Rect(XPos, YPos, XPos + TextWidth, YPos + TextHeight));
      FLeftSpace := XPos - PPIScale(21);
      // for use in Checkbutton and Radiobutton
      FTopSpace := YPos;
    end
    else
    begin
      // with graphic
      Bmp := BitmapFromRelativePath(Image);
      BmpW := Bmp.Width;
      BmpH := Bmp.Height;
      Gtg := 4; // GraphicTextGap
      MaxW := 0;
      MaxH := 0;

      case Compound of
        _TU_top, _TU_bottom:
          begin
            MaxW := Max(TextWidth, BmpW);
            MaxH := BmpH + Gtg + TextHeight;
          end;
        _TU_center:
          begin
            MaxW := Max(TextWidth, BmpW);
            MaxH := Max(BmpH, TextHeight);
          end;
        _TU_none, _TU_image:
          begin
            MaxW := BmpW;
            MaxH := BmpH;
          end;
        _TU_left, _TU_right:
          begin
            MaxW := BmpW + Gtg + TextWidth;
            MaxH := Max(TextHeight, BmpH);
          end;
      end;
      if MaxW > Width then
      begin
        Width := MaxW;
        Width := MaxW;
      end;

      // BoxX, BoxY = position of compound box of graphic and text
      // MaxW, MaxH = size of compound box
      BoxX := 0;
      BoxY := 0;
      case FAnchor of
        _TA_nw:
          begin
            BoxX := PaddingL + FLeftSpace;
            BoxY := PaddingT;
          end;
        _TA_n:
          begin
            BoxX := (Width - MaxW - FRightSpace) div 2 + FLeftSpace;
            BoxY := PaddingT;
          end;
        _TA_ne:
          begin
            BoxX := Width - MaxW - PaddingR - FRightSpace;
            BoxY := PaddingT;
          end;
        _TA_w:
          begin
            BoxX := PaddingL + FLeftSpace;
            BoxY := (Height - MaxH) div 2;
          end;
        _TA_center:
          begin
            BoxX := (Width - MaxW - FRightSpace) div 2 + FLeftSpace;
            BoxY := (Height - MaxH) div 2;
          end;
        _TA_e:
          begin
            BoxX := Width - MaxW - PaddingR - FRightSpace;
            BoxY := (Height - MaxH) div 2;
          end;
        _TA_sw:
          begin
            BoxX := PaddingR + FLeftSpace;
            BoxY := Height - MaxH - PaddingB;
          end;
        _TA_s:
          begin
            BoxX := (Width - MaxW - FRightSpace) div 2 + FLeftSpace;
            BoxY := Height - MaxH - PaddingB;
          end;
        _TA_se:
          begin
            BoxX := Width - MaxW - PaddingR - FRightSpace;
            BoxY := Height - MaxH - PaddingB;
          end;
      end;

      Mgw := (MaxW - BmpW) div 2;
      Mtw := (MaxW - TextWidth) div 2;
      TextX := 0;
      TextY := 0;
      BmpX := 0;
      BmpY := 0;

      case Compound of
        _TU_top:
          begin
            BmpX := Mgw;
            BmpY := 0;
            TextX := Mtw;
            TextY := BmpH + Gtg;
          end;
        _TU_bottom:
          begin
            BmpX := Mgw;
            BmpY := MaxH - BmpH;
            TextX := Mtw;
            TextY := 0;
          end;
        _TU_left:
          begin
            BmpX := 0;
            BmpY := 0;
            TextX := BmpW + Gtg;
            TextY := (MaxH - TextHeight) div 2;
          end;
        _TU_right:
          begin
            BmpX := MaxW - BmpW;
            BmpY := 0;
            TextX := 0;
            TextY := (MaxH - TextHeight) div 2;
          end;
        _TU_center:
          begin
            BmpX := Mgw;
            BmpY := 0;
            TextX := Mtw;
            TextY := (MaxH - TextHeight) div 2;
          end;
        _TU_none:
          begin
            BmpX := 0;
            BmpY := 0;
          end;
      end;

      BmpX := BoxX + BmpX;
      BmpY := BoxY + BmpY;
      TextX := BoxX + TextX;
      TextY := BoxY + TextY;

      Canvas.Draw(BmpX, BmpY, Bmp);
      if (Compound <> _TU_none) and (Compound <> _TU_image) and
        (StringList.Text <> #13#10) then
        ShowText(Rect(TextX, TextY, TextX + TextWidth, TextY + TextHeight));
      // for debugging
      // R:= rect(min(BmpX,TextX), min(BmpY,TextY), max(BmpX+BmpW,TextX+TextWidth), max(BmpY+BmpH, TextY+TextHeight));
      // Canvas.DrawFocusRect(r);

      // for use in Checkbutton and Radiobutton
      FLeftSpace := BoxX - PPIScale(21);
      FTopSpace := BoxY + MaxH div 2 - PPIScale(10);
      FreeAndNil(Bmp);
    end;
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TBaseTkWidget.SetPositionAndSize;
var
  Key: string;
  Rect: TRect;
begin
  Rect := ClientRectWithoutScrollbars;
  if not(Parent is TKPanedWindow) then
    SetAttributValue('self.' + Name + '.place', 'self.' + Name + '.place(x=' +
      IntToStr(PPIUnScale(Left)) + ', y=' + IntToStr(PPIUnScale(Top)) +
      ', width=' + IntToStr(PPIUnScale(Rect.Right)) + ', height=' +
      IntToStr(PPIUnScale(Rect.Bottom)) + ')');
  if Scrollbars in [_TB_both, _TB_vertical] then
  begin
    Key := 'self.' + Name + 'ScrollbarV.place';
    SetAttributValue(Key, Key + '(x=' + IntToStr(PPIUnScale(X + Rect.Right - 2))
      + ', y=' + IntToStr(PPIUnScale(Y)) + ', width=' + IntToStr(PPIUnScale(20))
      + ', height=' + IntToStr(PPIUnScale(Rect.Bottom)) + ')');
  end;
  if (Scrollbars in [_TB_both, _TB_horizontal]) or Scrollbar then
  begin
    Key := 'self.' + Name + 'ScrollbarH.place';
    SetAttributValue(Key, Key + '(x=' + IntToStr(PPIUnScale(X)) + ', y=' +
      IntToStr(PPIUnScale(Y + Rect.Bottom - 2)) + ', width=' +
      IntToStr(PPIUnScale(Rect.Right)) + ', height=' +
      IntToStr(PPIUnScale(20)) + ')');
  end;
end;

function TBaseTkWidget.ClientRectWithoutScrollbars: TRect;
begin
  Result := ClientRect;
  if Scrollbars in [_TB_vertical, _TB_both] then
    Result.Right := Result.Right - 20;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar then
    Result.Bottom := Result.Bottom - 20;
end;

procedure TBaseTkWidget.Resize;
begin
  inherited;
  if Parent is TKPanedWindow then
    (Parent as TKPanedWindow).Resize
  else if Self is TKPanedWindow then
    (Self as TKPanedWindow).Resize
  else if Parent is TTKPanedWindow then
    (Parent as TTKPanedWindow).Resize
  else if Self is TTKPanedWindow then
    (Self as TTKPanedWindow).Resize;
end;

function TBaseTkWidget.GetAttrAsKey(Attr: string): string;
begin
  Result := 'self.' + Name + FNameExtension + '[''' + LowerCase(Attr) + ''']';
end;

procedure TBaseTkWidget.SetAttribute(Attr, Value, Typ: string);
var
  Key: string;
begin
  Key := GetAttrAsKey(Attr);
  if IsFontAttribute(Attr) then
    MakeFont
  else if Attr = 'TakeFocus' then
    MakeBoolean(Attr, Value)
  else if Attr = 'Menu' then
    SetMenu(Value)
  else if Attr = 'Show' then
    MakeShow(Value)
  else if Right(Attr, -7) = 'Command' then
    ChangeCommand(Attr, Value)
  else if Typ = 'Source' then
    if Value = '' then
      Partner.DeleteAttribute(Key)
    else
      SetAttributValue(Key, Key + ' = ' + Value)
  else if Typ = 'TCursor' then
    if Value = 'default' then
      Partner.DeleteAttribute(Key)
    else
      SetAttributValue(Key, Key + ' = ' + AsString(Value))
  else if Typ = 'Boolean' then
    MakeBoolean(Attr, Value)
  else if (Typ = 'string') or ((Typ <> '') and (Typ[1] = 'T')) then
    // enum type, TColor
    if Value = '' then
      Partner.DeleteAttribute(Key) // borderwidth, padx, ...
    else
      SetAttributValue(Key, Key + ' = ' + AsString(Value))
  else
  begin
    if Value = '' // Typ Real
    then
      Partner.DeleteAttribute(Key)
    else
      SetAttributValue(Key, Key + ' = ' + Value);
  end;
end;

procedure TBaseTkWidget.SetEvent(Event: string);
begin
  if not Partner.hasText('def ' + HandlerNameAndParameter(Event)) then
    Partner.InsertProcedure(CrLf + MakeHandler(Event));
  Partner.InsertTkBinding(Name, Event, MakeBinding(Event));
end;

procedure TBaseTkWidget.MakeBoolean(Attr, Value: string);
var
  Key, Value2: string;
begin
  Key := GetAttrAsKey(Attr);
  if Value = 'True' then
    Value2 := Key + ' = 1'
  else
    Value2 := Key + ' = 0';
  SetAttributValue(Key, Value2);
end;

procedure TBaseTkWidget.MakeShow(Value: string);
begin
  var
  Str := 'self.' + Name + '[''show'']';
  if Value = 'True' then
    Partner.DeleteAttribute(Str)
  else
    SetAttributValue(Str, Str + ' = ''*''');
end;

procedure TBaseTkWidget.AddParameter(const Value, Par: string);
var
  Old, New: string;
begin
  Old := 'def ' + Value + '(self):';
  New := 'def ' + Value + '(self, ' + Par + '):';
  Partner.ReplaceWord(Old, New, False);
end;

procedure TBaseTkWidget.MakeControlVar(Variable, ControlVar: string;
  Value: string = ''; Typ: string = 'String');
begin
  var
  Str := Surround('self.' + ControlVar + ' = tk.' + Typ + 'Var()');
  if Typ = 'String' then
    Str := Str + Surround('self.' + ControlVar + '.set(' +
      AsString(Value) + ')')
  else
    Str := Str + Surround('self.' + ControlVar + '.set(' + Value + ')');
  Str := Str + Surround('self.' + Name + '[' + AsString(Variable) + '] = self.'
    + ControlVar);
  InsertValue(Str);
end;

procedure TBaseTkWidget.SetMenu(Value: string);
var
  Str1, Str2: string;
begin
  Str1 := 'self.' + Name + '[' + AsString('menu') + ']';
  Partner.DeleteAttribute(Str1);
  if Value = '' then
  begin
    Str1 := 'self.' + GOldValue + ' = tk.Menu';
    Str2 := Str1 + '(tearoff=0)';
    SetAttributValue(Str1, Str2);
  end
  else
  begin
    Partner.InsertAtEnd(Indent2 + Str1 + ' = self.' + Value);
    Str1 := 'self.' + Value + ' = tk.Menu';
    Str2 := Str1 + '(self.' + Name + ', tearoff=0)';
    SetAttributValue(Str1, Str2);
  end;
end;

procedure TBaseTkWidget.ChangeCommand(Attr, Value: string);
var
  Nam, Key: string;
begin
  Nam := Name + '_' + Attr;
  Key := 'self.' + Name + FNameExtension + '[' +
    AsString(LowerCase(Attr)) + ']';
  if Value = 'False' then
  begin
    Partner.DeleteAttribute(Key);
    Partner.DeleteMethod(Nam);
  end
  else
  begin
    SetAttributValue(Key, Key + ' = self.' + Nam);
    MakeCommand(Attr, Nam);
  end;
end;

function TBaseTkWidget.MakeBinding(Eventname: string): string;
var
  Event: TEvent;
begin
  if Eventname = 'ButtonPress' then
    Event := ButtonPress
  else if Eventname = 'ButtonRelease' then
    Event := ButtonRelease
  else if Eventname = 'KeyPress' then
    Event := KeyPress
  else if Eventname = 'KeyRelease' then
    Event := KeyRelease
  else if Eventname = 'Activate' then
    Event := Activate
  else if Eventname = 'Configure' then
    Event := Configure
  else if Eventname = 'Deactivate' then
    Event := Deactivate
  else if Eventname = 'Enter' then
    Event := Enter
  else if Eventname = 'FocusIn' then
    Event := FocusIn
  else if Eventname = 'FocusOut' then
    Event := FocusOut
  else if Eventname = 'Leave' then
    Event := Leave
  else if Eventname = 'Motion' then
    Event := Motion
  else
    Event := MouseWheel;
  Result := Indent2 + 'self.' + Name + '.bind(''<' +
    Event.getModifiers(Eventname) + Eventname + Event.getDetail(Eventname) +
    '>'', self.' + HandlerName(Eventname) + ')';
end;

function TBaseTkWidget.MakeHandler(const Event: string): string;
begin
  Result := Indent1 + 'def ' + HandlerNameAndParameter(Event) + CrLf + Indent2 +
    '# ToDo insert source code here' + CrLf + Indent2 + 'pass' + CrLf;
end;

procedure TBaseTkWidget.MakeImage(const Value: string);
var
  Str, Key1, Key2, Dest, Filename, Path: string;
begin
  // ToDo use PIL if png-file selected
  if Value = '(Image)' then
  begin
    Key1 := 'self.' + Name + 'Image';
    Partner.DeleteAttribute(Key1);
    Key2 := 'self.' + Name + '[''Image'']';
    Partner.DeleteAttribute(Key2);
  end
  else
  begin
    Filename := ExtractFileName(Value);
    if Pos('images/', Filename) = 1 then
      System.Delete(Filename, 1, 7);
    Path := ExtractFilePath(Partner.Pathname);
    Dest := Path + 'images\' + Filename;
    ForceDirectories(Path + 'images\');
    if not FileExists(Dest) then
      CopyFile(PChar(Value), PChar(Dest), True);
    FImage := 'images/' + Filename;
    Key1 := 'self.' + Name + 'Image';
    Str := Key1 + ' = tk.PhotoImage(file=' + AsString(FImage) + ')';
    SetAttributValue(Key1, Str);
    Key2 := 'self.' + Name + '[''image'']';
    Str := Key2 + ' = ' + Key1;
    SetAttributValue(Key2, Str);
    FObjectInspector.Invalidate;
  end;
end;

procedure TBaseTkWidget.MakeValidateCommand(Attr, Value: string);
var
  Key: string;
begin
  if Value = '' then
  begin
    Partner.DeleteAttribute(Name + 'VC');
    Partner.DeleteAttribute('self.' + Name + '[''validatecommand'']');
    Partner.DeleteMethod(ULink.GOldValue);
  end
  else
  begin
    Key := 'self.' + Name + 'VC';
    SetAttributValue(Key, Key + ' = self.register(self.' + Name +
      '_ValidateCommand)');
    ChangeCommand(Attr, Value);
    Key := 'self.' + Name + '[''validatecommand'']';
    SetAttributValue(Key, Key + ' = (self.' + Name +
      'VC, ''%d'', ''%I'', ''%S'')');
  end;
end;

procedure TBaseTkWidget.SetScrollbars(Value: TScrollbar);
begin
  if FScrollbars <> Value then
  begin
    FScrollbars := Value;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetScrollbar(Value: Boolean);
begin
  if FScrollbar <> Value then
  begin
    FScrollbar := Value;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.MakeScrollbar(Value, TkTyp: string);
begin
  if Value = 'True' then
    MakeScrollbars('horizontal', TkTyp)
  else
    MakeScrollbars('none', TkTyp);
end;

procedure TBaseTkWidget.MakeScrollbars(Value, TkTyp: string);
var
  ScrollbarName, OldValue: string;
  WidthNoScrollbar, HeightNoScrollbar, WidthScrollbar, HeightScrollbar: Integer;

  procedure DeleteVertical;
  begin
    Partner.DeleteAttributeValues(ScrollbarName + 'V');
    Partner.DeleteAttribute('self.' + Name + '[' +
      AsString('yscrollcommand') + ']');
    Dec(WidthNoScrollbar, 20);
  end;

  procedure DeleteHorizontal;
  begin
    Partner.DeleteAttributeValues(ScrollbarName + 'H');
    Partner.DeleteAttribute('self.' + Name + '[' +
      AsString('xscrollcommand') + ']');
    Dec(HeightNoScrollbar, 20);
  end;

  procedure InsertVertical;
  var
    Str: string;
  begin
    Str := Surround(ScrollbarName + 'V = ' + TkTyp + 'Scrollbar(' +
      GetContainer + ')');
    Str := Str + Surround(ScrollbarName + 'V.place(x=' +
      IntToStr(X + WidthNoScrollbar - 2) + ', y=' + IntToStr(Y) +
      ', width=20, height=' + IntToStr(HeightNoScrollbar) + ')');
    Str := Str + Surround(ScrollbarName + 'V[' + AsString('command') +
      '] = self.' + Name + '.yview');
    Str := Str + Surround('self.' + Name + '[' + AsString('yscrollcommand') +
      '] = ' + ScrollbarName + 'V.set');
    InsertValue(Str);
    Inc(WidthScrollbar, 20);
  end;

  procedure InsertHorizontal;
  var
    Str, Str1: string;
  begin
    Str1 := GetContainer;
    if Str1 <> '' then
      Str1 := Str1 + ', ';
    Str1 := Str1 + 'orient=' + AsString('horizontal');
    Str := Surround(ScrollbarName + 'H = ' + TkTyp + 'Scrollbar(' + Str1 + ')');
    Str := Str + Surround(ScrollbarName + 'H.place(x=' + IntToStr(X) + ', y=' +
      IntToStr(Y + HeightNoScrollbar - 2) + ', width=' +
      IntToStr(WidthNoScrollbar) + ', height=20)');
    Str := Str + Surround(ScrollbarName + 'H[' + AsString('command') +
      '] = self.' + Name + '.xview');
    Str := Str + Surround('self.' + Name + '[' + AsString('xscrollcommand') +
      '] = ' + ScrollbarName + 'H.set');
    InsertValue(Str);
    Inc(HeightScrollbar, 20);
  end;

begin
  OldValue := ULink.GOldValue;
  ScrollbarName := 'self.' + Name + 'Scrollbar';
  Partner.ActiveSynEdit.BeginUpdate;
  WidthNoScrollbar := Width;
  HeightNoScrollbar := Height;
  if (OldValue = 'vertical') or (OldValue = 'both') then
    DeleteVertical;
  if (OldValue = 'horizontal') or (OldValue = 'both') or (OldValue = 'True')
  then
    DeleteHorizontal;
  WidthScrollbar := WidthNoScrollbar;
  HeightScrollbar := HeightNoScrollbar;
  if (Value = 'vertical') or (Value = 'both') then
    InsertVertical;
  if (Value = 'horizontal') or (Value = 'both') then
    InsertHorizontal;
  SetBounds(X, Y, WidthScrollbar, HeightScrollbar);
  Partner.ActiveSynEdit.EndUpdate;
  FObjectInspector.Invalidate;
end;

procedure TBaseTkWidget.PaintAScrollbar(Value: Boolean);
begin
  if Value then
    PaintScrollbars(_TB_horizontal);
end;

procedure TBaseTkWidget.PaintScrollbars(Scrollbar: TScrollbar);
var
  Rect: TRect;
begin
  if Scrollbar = _TB_vertical then
  begin
    Rect := ClientRect;
    Rect.Left := Rect.Right - 20;
    PaintScrollbar(Rect, False);
  end;

  if Scrollbar = _TB_horizontal then
  begin
    Rect := ClientRect;
    Rect.Top := Rect.Bottom - 20;
    PaintScrollbar(Rect, True);
  end;

  if Scrollbar = _TB_both then
  begin
    Rect := ClientRect;
    Rect.Left := Rect.Right - 20;
    Rect.Bottom := Rect.Bottom - 20;
    PaintScrollbar(Rect, False);
    Rect := ClientRect;
    Rect.Top := Rect.Bottom - 20;
    Rect.Right := Rect.Right - 20;
    PaintScrollbar(Rect, True);
  end;
end;

procedure TBaseTkWidget.ShowText(Text: string; NewWidth, NewHeight: Integer);
var
  TextHeight, TextWidth, XPos, YPos: Integer;
begin
  TextHeight := Canvas.TextHeight(Text);
  TextWidth := Canvas.TextWidth(Text);
  YPos := (NewHeight - TextHeight) div 2;
  case Justify of
    _TJ_left:
      XPos := FBorderWidthInt + 2;
    _TJ_center:
      XPos := (NewWidth - TextWidth) div 2;
  else
    XPos := NewWidth - FBorderWidthInt - TextWidth - 2;
  end;
  Canvas.TextOut(XPos, YPos, Text);
end;

procedure TBaseTkWidget.SetAnchor(AValue: TAnchor);
begin
  if AValue <> FAnchor then
  begin
    FAnchor := AValue;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetBackground(AColor: TColor);
begin
  if AColor <> FBackground then
  begin
    FBackground := AColor;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetForeground(AColor: TColor);
begin
  if AColor <> FForeground then
  begin
    FForeground := AColor;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetBorderWidth(AValue: string);
begin
  if AValue <> FBorderWidth then
  begin
    FBorderWidth := AValue;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetImage(AValue: string);
begin
  if AValue <> FImage then
  begin
    FImage := AValue;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetJustify(AValue: TJustify);
begin
  if AValue <> FJustify then
  begin
    FJustify := AValue;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetUnderline(AValue: Integer);
begin
  if AValue <> FUnderline then
  begin
    FUnderline := AValue;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.SetWrapLength(AValue: string);
begin
  if AValue <> FWrapLength then
  begin
    FWrapLength := AValue;
    Invalidate;
  end;
end;

procedure TBaseTkWidget.DeleteWidget;
begin
  if FCommand then
    Partner.DeleteMethod(Name + '_Command');
  Partner.DeleteMethod(Name + 'ScrollbarH.set');
  Partner.DeleteMethod(Name + 'ScrollbarV.set');
  DeleteEvents;
  Partner.DeleteComponent(Self);
  if (Parent is TKPanedWindow) or (Parent is TTKPanedWindow) then
    Partner.DeleteAttribute('self.' + Parent.Name + '.add(self.' + Name);
end;

procedure TBaseTkWidget.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  Partner.DeleteBinding(MakeBinding(Event));
end;

procedure TBaseTkWidget.DeleteEvents;
var
  Posi: Integer;
  Str, Event: string;
  SL1, SL2: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  Str := getEvents(3) + '|';
  Posi := Pos('|', Str);
  while Posi > 0 do
  begin
    Event := UUtils.Left(Str, Posi - 1);
    if Event <> '' then
    begin
      Partner.DeleteBinding(MakeBinding(Name));
      SL1.Add(HandlerNameAndParameter(Event));
    end;
    Delete(Str, 1, Posi);
    Posi := Pos('|', Str);
  end;
  Partner.DeleteOldAddNewMethods(SL1, SL2);
  FreeAndNil(SL1);
  FreeAndNil(SL2);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseTkWidget.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  InsertValue('self.' + Name + ' = ' + Widget + '(' + GetContainer + ')');
  SetPositionAndSize;
  MakeFont;
  if Parent is TKPanedWindow then
    InsertValue('self.' + Parent.Name + '.add(self.' + Name + ')')
  else if Parent is TTKPanedWindow then
    InsertValue('self.' + Parent.Name + '.add(self.' + Name + ', weight=1)');
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseTkWidget.Calculate3DColors(var DarkColor, LightColor: TColor;
  Background: TColor);
const
  MAX_INTENSITY = 255.0;
var
  Red, Green, Blue: Integer;
  LightRed, LightGreen, LightBlue, DarkRed, DarkGreen, DarkBlue, Tmp1,
    Tmp2: Real;
  Color: TColor;
begin
  // from: https://github.com/tcltk/tk/blob/main/win/tkWin3d.c
  Color := Graphics.ColorToRGB(Background);
  Color2RGB(Color, Red, Green, Blue);

  if (Red * 0.5 * Red + Green * 1.0 * Green + Blue * 0.28 * Blue < MAX_INTENSITY
    * 0.05 * MAX_INTENSITY) then
  begin
    DarkRed := (MAX_INTENSITY + 3 * Red) / 4;
    DarkGreen := (MAX_INTENSITY + 3 * Green) / 4;
    DarkBlue := (MAX_INTENSITY + 3 * Blue) / 4;
  end
  else
  begin
    DarkRed := (60 * Red) / 100;
    DarkGreen := (60 * Green) / 100;
    DarkBlue := (60 * Blue) / 100;
  end;
  DarkColor := RGB2Color(Round(DarkRed), Round(DarkGreen), Round(DarkBlue));

  if (Green > MAX_INTENSITY * 0.95) then
  begin
    LightRed := (90 * Red) / 100;
    LightGreen := (90 * Green) / 100;
    LightBlue := (90 * Blue) / 100;
  end
  else
  begin
    Tmp1 := Min((14 * Red) / 10, MAX_INTENSITY);
    Tmp2 := (MAX_INTENSITY + Red) / 2;
    LightRed := Max(Tmp1, Tmp2);
    Tmp1 := Min((14 * Green) / 10, MAX_INTENSITY);
    Tmp2 := (MAX_INTENSITY + Green) / 2;
    LightGreen := Max(Tmp1, Tmp2);
    Tmp1 := Min((14 * Blue) / 10, MAX_INTENSITY);
    Tmp2 := (MAX_INTENSITY + Blue) / 2;
    LightBlue := Max(Tmp1, Tmp2);
  end;
  LightColor := RGB2Color(Round(LightRed), Round(LightGreen), Round(LightBlue));
end;

procedure TBaseTkWidget.SetRelief(AValue: TRelief);
begin
  if FRelief <> AValue then
  begin
    FRelief := AValue;
    Invalidate;
  end;
end;

function TBaseTkWidget.GetType: string;
begin
  if Pos('TTK', ClassName) = 1 then
    Result := Copy(ClassName, 4, Length(ClassName))
  else
    Result := Copy(ClassName, 3, Length(ClassName));
end;

function TBaseTkWidget.GetNameAndType: string;
begin
  Result := Name + ': ' + GetType;
end;

function TBaseTkWidget.GetContainer: string;
begin
  if (Parent = nil) or (Parent is TFGuiForm) then
    Result := ''
  else
    Result := 'self.' + Parent.Name;
end;

procedure TBaseTkWidget.MakeFont;
var
  Str1, Str2: string;
begin
  if Name = '' then
    Exit;
  Str1 := 'self.' + Name + '[''font'']';
  Str2 := ' = (' + AsString(Font.Name) + ', ' + IntToStr(Font.Size);
  if fsBold in Font.Style then
    Str2 := Str2 + ', ' + AsString('bold');
  if fsItalic in Font.Style then
    Str2 := Str2 + ', ' + AsString('italic');
  if fsStrikeOut in Font.Style then
    Str2 := Str2 + ', ' + AsString('overstrike');
  if fsUnderline in Font.Style then
    Str2 := Str2 + ', ' + AsString('underline');
  Str2 := Str2 + ')';
  SetAttributValue(Str1, Str1 + Str2);
  Invalidate;
end;

{ --- TKMainWindow ------------------------------------------------------------ }

function TKMainWindow.GetAttributes(ShowAttributes: Integer): string;
const
  Attributes1 = '|Transparency|Resizable|Title|Background|Width|Height';
  Attributes2 = Attributes1 + '|Fullscreen|AlwaysOnTop|Iconified';
  Attributes3 = Attributes2 + '|MaxHeight|MaxWidth|MinHeight|MinWidth|Theme';
begin
  case ShowAttributes of
    1:
      Result := Attributes1 + '|';
    2:
      Result := Attributes2 + '|';
  else
    Result := Attributes3 + '|';
  end;
end;

procedure TKMainWindow.SetAttribute(Attr, Value, Typ: string);
var
  Str1, Str2: string;
begin
  if Attr = 'Title' then
  begin
    Str1 := 'self.root.title';
    Str2 := Indent2 + Str1 + '(' + AsString(Value) + ')';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end
  else if Attr = 'Background' then
  begin
    Str1 := 'self.root[''background'']';
    Str2 := Indent2 + Str1 + ' = ' + AsString(Value);
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end
  else if Attr = 'Resizable' then
  begin
    Str1 := 'self.root.resizable';
    Str2 := Indent2 + Str1 + '(' + Value + ', ' + Value + ')';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end
  else if Attr = 'Transparency' then
  begin
    Str1 := 'self.root.attributes(''-alpha''';
    Str2 := Indent2 + Str1 + ', ' + Value + ')';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end
  else if Attr = 'Fullscreen' then
  begin
    Str1 := 'self.root.attributes(''-fullscreen''';
    Str2 := Indent2 + Str1 + ', ' + Value + ')';
    if Value = 'True' then
      Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0)
    else
      Partner.DeleteAttribute(Str1);
  end
  else if (Attr = 'MaxHeight') or (Attr = 'MaxWidth') then
  begin
    Str1 := 'self.root.maxsize';
    Str2 := Indent2 + Str1 + '(' + Value + ')';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end
  else if (Attr = 'MinHeight') or (Attr = 'MinWidth') then
  begin
    Str1 := 'self.root.minsize';
    Str2 := Indent2 + Str1 + '(' + Value + ')';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end
  else if Attr = 'Iconified' then
  begin
    Str1 := 'self.root.iconify';
    Str2 := Indent2 + Str1 + '()';
    if Value = 'True' then
      Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0)
    else
      Partner.DeleteAttribute(Str1);
  end
  else if Attr = 'AlwaysOnTop' then
  begin
    Str1 := 'self.root.attributes(''-topmost''';
    Str2 := Indent2 + Str1 + ', 1)';
    if Value = 'True' then
      Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0)
    else
      Partner.DeleteAttribute(Str1);
  end
  else if Attr = 'Theme' then
  begin
    Str1 := 'self.theme';
    Str2 := Indent2 + Str1 + ' = ttk.Style()';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
    Str1 := 'self.theme.theme_use';
    Str2 := Indent2 + Str1 + '(' + AsString(Value) + ')';
    Partner.SetAttributValue('self.create_widgets', Str1, Str2, 0);
  end;
end;

function TKMainWindow.getEvents(ShowEvents: Integer): string;
begin
  Result := MouseEvents1;
  if ShowEvents >= 2 then
    Result := MouseEvents1 + MouseEvents2;
  if ShowEvents = 3 then
    Result := AllEvents;
  Result := Result + '|Destroy_|Expose|Visibility|';
end;

function TKMainWindow.HandlerParameter(const Event: string): string;
begin
  Result := 'self, Event';
end;

function TKMainWindow.HandlerName(const Event: string): string;
begin
  Result := 'root_' + Event;
end;

end.
