{-------------------------------------------------------------------------------
 Unit:     UTKWidgets
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  tkinter base widget
-------------------------------------------------------------------------------}

unit UTKWidgets;

interface

uses
  Windows, Classes, Graphics, UBaseTKWidgets;

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

    procedure setPadX(aValue: string);
    procedure setPadY(aValue: string);
  protected
    procedure CalculateText(var tw, th: Integer; var SL: TStringlist); override;
    procedure CalculatePadding(var pl, pt, pr, pb: Integer); override;
    function getCompound: TUCompound; override;
    function getText: string; virtual;
    procedure setText(aValue: string); virtual;
    procedure Paint; override;
    procedure PaintBorder(R: TRect; Relief: TRelief; BorderWidth: Integer); override;
 public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;

    property ActiveBackground: TColor read FActiveBackground write FActiveBackground;
    property DisabledForeground: TColor read FDisabledForeground write FDisabledForeground;
    property HighlightBackground: TColor read FHighlightBackground write FHighlightBackground;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor;
    property HighlightThickness: string read FHighlightThickness write FHighlightThickness;
    property PadX: string read fPadX write setPadX;
    property PadY: string read fPadY write setPadY;
    property Text: string read FText write setText;
  published
    property Background;
    property BorderWidth;
    property Relief;
  end;

implementation

uses Math, SysUtils;

{--- TKWidget ------------------------------------------------------------------}

constructor TKWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActiveBackground   := clBtnFace;     // SystemButtonFace
  FDisabledForeground := clGrayText;    // SystemDisabledText
  FHighlightBackground:= clBtnFace;     // SystemButtonFace
  FHighlightColor     := clWindowFrame; // SystemWindowFrame
  FHighlightThickness:= '1';
  FPadX:= '1';
  FPadY:= '1';
end;

procedure TKWidget.setPadX(aValue: string);
begin
  if aValue <> fPadX then begin
    fPadX:= aValue;
    Invalidate;
  end;
end;

procedure TKWidget.setPadY(aValue: string);
begin
  if aValue <> fPadY then begin
    fPadY:= aValue;
    Invalidate;
  end;
end;

procedure TKWidget.setText(aValue: string);
begin
  if aValue <> fText then begin
    fText:= aValue;
    Invalidate;
  end;
end;

procedure TKWidget.PaintBorder(R: TRect; Relief: TRelief; BorderWidth: Integer);
  var LightBackground, DarkBackground: TColor;

  procedure PaintTopLeft(C1, C2: TColor);
    var i: Integer;
  begin
    Canvas.Pen.Color:= C1;
    for i:= 0 to BorderWidth div 2 do begin
      Canvas.MoveTo(R.Left + i, R.Bottom - i - 1);
      Canvas.LineTo(R.Left + i, R.Top + i);
      Canvas.LineTo(R.Right - i, R.Top + i);
    end;
    Canvas.Pen.Color:= C2;
    for i:= BorderWidth div 2 + 1 to BorderWidth do begin
      Canvas.MoveTo(R.Left + i, R.Bottom - i - 1);
      Canvas.LineTo(R.Left + i, R.Top + i);
      Canvas.LineTo(R.Right - i, R.Top + i);
    end;
  end;

  procedure PaintBottomRight(C1, C2: TColor);
    var i: Integer;
  begin
    Canvas.Pen.Color:= C1;
    for i:= BorderWidth div 2 + 1 to BorderWidth do begin
      Canvas.MoveTo(R.Left + i, R.Bottom - i);
      Canvas.LineTo(R.Right - i, R.Bottom - i);
      Canvas.LineTo(R.Right - i, R.Top + i - 1);
    end;
    Canvas.Pen.Color:= C2;
    for i:= 0 to BorderWidth div 2 do begin
      Canvas.MoveTo(R.Left + i, R.Bottom - i);
      Canvas.LineTo(R.Right - i, R.Bottom - i);
      Canvas.LineTo(R.Right - i, R.Top + i - 1);
    end;
  end;

begin
  if (BorderWidth > 0) and (Relief <> _TR_flat) then begin
    Calculate3DColors(DarkBackground, LightBackground, Background);
    case Relief of
      _TR_groove: begin
         PaintTopLeft(DarkBackground, LightBackground);
         PaintBottomRight(DarkBackground, LightBackground);
       end;
      _TR_ridge: begin
         PaintTopLeft(LightBackground, DarkBackground);
         PaintBottomRight(LightBackground, DarkBackground);
       end;
      _TR_raised: begin
         PaintTopLeft(LightBackground, Background);
         PaintBottomRight(DarkBackground, clBlack);
       end;
      _TR_sunken: begin
         PaintTopLeft(DarkBackground, clBlack);
         PaintBottomRight(Background, LightBackground);
       end;
      _TR_solid: begin
         PaintTopLeft(clBlack, clBlack);
         PaintBottomRight(clBlack, clBlack);
       end;
    end;
  end;
end;

procedure TKWidget.CalculateText(var tw, th: Integer; var SL: TStringlist);
  var s: string; p: Integer;
begin
  s:= getText;
  p:= Pos('\n', s);
  while p > 0 do begin
    SL.Add(Copy(s, 1, p-1));
    Delete(s, 1, p+1);
    p:= Pos('\n', s);
  end;
  SL.Add(s);
  tw:= 0;
  for p:= 0 to SL.Count - 1 do
    tw:= Max(tw, Canvas.TextWidth(SL[p]));
  th:= SL.Count * Canvas.TextHeight('Hg');
end;

procedure TKWidget.CalculatePadding(var pl, pt, pr, pb: Integer);
begin
  if not TryStrToInt(FPadX, pl) then pl:= 0;
  if not TryStrToInt(FPadY, pt) then pt:= 0;
  pr:= pl;
  pb:= pt;
  pl:= pl + BorderWidthInt + 1;
  pt:= pt + BorderWidthInt + 1;
  pr:= pr + BorderWidthInt + 1;
  pb:= pb + BorderWidthInt + 1;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar then
    pb:= pb + 20;
  if (Scrollbars = _TB_vertical) or (Scrollbars = _TB_both) then
    pr:= pr + 20;
end;

function TKWidget.getCompound: TUCompound;
begin
  Result:= _TU_none;
end;

function TKWidget.getText: string;
begin
  Result:= FText;
end;

procedure TKWidget.Paint;
begin
  if (Relief <> _TR_flat) and not TryStrToInt(BorderWidth, BorderWidthInt) then
    BorderWidthInt:= PPIScale(2);
  inherited;
end;

function TKWidget.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Background';
  if ShowAttributes >= 2 then
    Result:= Result + '';
  if ShowAttributes = 3 then
    Result:= Result + '';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

end.
