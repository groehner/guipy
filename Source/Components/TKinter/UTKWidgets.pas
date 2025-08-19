{ -------------------------------------------------------------------------------
  Unit:     UTKWidgets
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  tkinter base widget
  ------------------------------------------------------------------------------- }

unit UTKWidgets;

interface

uses
  Windows,
  Classes,
  Graphics,
  UBaseTKWidgets;

type

  TKWidget = class(TBaseTkWidget)
  private
    FActiveBackground: TColor;
    FDisabledForeground: TColor;
    FHighlightBackground: TColor;
    FHighlightColor: TColor;
    FHighlightThickness: string;
    FPadX: string;
    FPadY: string;
    FText: string;
    procedure SetPadX(Value: string);
    procedure SetPadY(Value: string);
  protected
    procedure CalculateText(var TextWidth, TextHeight: Integer;
      var StringList: TStringList); override;
    procedure CalculatePadding(var PaddingL, PaddingT, PaddingR,
      PaddingB: Integer); override;
    function GetCompound: TUCompound; override;
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
    procedure Paint; override;
    procedure PaintBorder(ARect: TRect; Relief: TRelief;
      BorderWidth: Integer); override;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;

    property ActiveBackground: TColor read FActiveBackground
      write FActiveBackground;
    property DisabledForeground: TColor read FDisabledForeground
      write FDisabledForeground;
    property HighlightBackground: TColor read FHighlightBackground
      write FHighlightBackground;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor;
    property HighlightThickness: string read FHighlightThickness
      write FHighlightThickness;
    property PadX: string read FPadX write SetPadX;
    property PadY: string read FPadY write SetPadY;
    property Text: string read FText write SetText;
  published
    property Background;
    property BorderWidth;
    property Relief;
  end;

implementation

uses Math, SysUtils;

{ --- TKWidget ------------------------------------------------------------------ }

constructor TKWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FActiveBackground := clBtnFace; // SystemButtonFace
  FDisabledForeground := clGrayText; // SystemDisabledText
  FHighlightBackground := clBtnFace; // SystemButtonFace
  FHighlightColor := clWindowFrame; // SystemWindowFrame
  FHighlightThickness := '1';
  FPadX := '1';
  FPadY := '1';
end;

procedure TKWidget.SetPadX(Value: string);
begin
  if Value <> FPadX then
  begin
    FPadX := Value;
    Invalidate;
  end;
end;

procedure TKWidget.SetPadY(Value: string);
begin
  if Value <> FPadY then
  begin
    FPadY := Value;
    Invalidate;
  end;
end;

procedure TKWidget.SetText(const Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    Invalidate;
  end;
end;

procedure TKWidget.PaintBorder(ARect: TRect; Relief: TRelief;
  BorderWidth: Integer);
var
  LightBackground, DarkBackground: TColor;

  procedure PaintTopLeft(Color1, Color2: TColor);
  begin
    Canvas.Pen.Color := Color1;
    for var I := 0 to BorderWidth div 2 do
    begin
      Canvas.MoveTo(ARect.Left + I, ARect.Bottom - I - 1);
      Canvas.LineTo(ARect.Left + I, ARect.Top + I);
      Canvas.LineTo(ARect.Right - I, ARect.Top + I);
    end;
    Canvas.Pen.Color := Color2;
    for var I := BorderWidth div 2 + 1 to BorderWidth do
    begin
      Canvas.MoveTo(ARect.Left + I, ARect.Bottom - I - 1);
      Canvas.LineTo(ARect.Left + I, ARect.Top + I);
      Canvas.LineTo(ARect.Right - I, ARect.Top + I);
    end;
  end;

  procedure PaintBottomRight(Color1, Color2: TColor);
  begin
    Canvas.Pen.Color := Color1;
    for var I := BorderWidth div 2 + 1 to BorderWidth do
    begin
      Canvas.MoveTo(ARect.Left + I, ARect.Bottom - I);
      Canvas.LineTo(ARect.Right - I, ARect.Bottom - I);
      Canvas.LineTo(ARect.Right - I, ARect.Top + I - 1);
    end;
    Canvas.Pen.Color := Color2;
    for var I := 0 to BorderWidth div 2 do
    begin
      Canvas.MoveTo(ARect.Left + I, ARect.Bottom - I);
      Canvas.LineTo(ARect.Right - I, ARect.Bottom - I);
      Canvas.LineTo(ARect.Right - I, ARect.Top + I - 1);
    end;
  end;

begin
  if (BorderWidth > 0) and (Relief <> _TR_flat) then
  begin
    Calculate3DColors(DarkBackground, LightBackground, Background);
    case Relief of
      _TR_groove:
        begin
          PaintTopLeft(DarkBackground, LightBackground);
          PaintBottomRight(DarkBackground, LightBackground);
        end;
      _TR_ridge:
        begin
          PaintTopLeft(LightBackground, DarkBackground);
          PaintBottomRight(LightBackground, DarkBackground);
        end;
      _TR_raised:
        begin
          PaintTopLeft(LightBackground, Background);
          PaintBottomRight(DarkBackground, clBlack);
        end;
      _TR_sunken:
        begin
          PaintTopLeft(DarkBackground, clBlack);
          PaintBottomRight(Background, LightBackground);
        end;
      _TR_solid:
        begin
          PaintTopLeft(clBlack, clBlack);
          PaintBottomRight(clBlack, clBlack);
        end;
    end;
  end;
end;

procedure TKWidget.CalculateText(var TextWidth, TextHeight: Integer;
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

procedure TKWidget.CalculatePadding(var PaddingL, PaddingT, PaddingR,
  PaddingB: Integer);
begin
  if not TryStrToInt(FPadX, PaddingL) then
    PaddingL := 0;
  if not TryStrToInt(FPadY, PaddingT) then
    PaddingT := 0;
  PaddingR := PaddingL;
  PaddingB := PaddingT;
  PaddingL := PaddingL + BorderWidthInt + 1;
  PaddingT := PaddingT + BorderWidthInt + 1;
  PaddingR := PaddingR + BorderWidthInt + 1;
  PaddingB := PaddingB + BorderWidthInt + 1;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar then
    PaddingB := PaddingB + 20;
  if (Scrollbars = _TB_vertical) or (Scrollbars = _TB_both) then
    PaddingR := PaddingR + 20;
end;

function TKWidget.GetCompound: TUCompound;
begin
  Result := _TU_none;
end;

function TKWidget.GetText: string;
begin
  Result := FText;
end;

procedure TKWidget.Paint;
var
  Int: Integer;
begin
  if (Relief <> _TR_flat) and not TryStrToInt(BorderWidth, Int) then
    BorderWidthInt := PPIScale(2)
  else
    BorderWidthInt := Int;
  inherited;
end;

function TKWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Background';
  if ShowAttributes >= 2 then
    Result := Result + '';
  if ShowAttributes = 3 then
    Result := Result + '';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

end.

