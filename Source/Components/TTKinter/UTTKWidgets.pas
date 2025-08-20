{ -------------------------------------------------------------------------------
  Unit:     UTTKWidgets
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  TTKinter base widget
  ------------------------------------------------------------------------------- }

unit UTTKWidgets;

interface

uses
  Windows,
  Classes,
  UBaseTKWidgets;

type

  TTKWidget = class(TBaseTkWidget)
  private
    FPadding: string;
    FStyle: string;
    FText: string;
    procedure SetPadding(const Value: string);
  protected
    function GetCompound: TUCompound; override;
    procedure Paint; override;
    procedure PaintBorder(Rect: TRect; Relief: TRelief;
      BorderWidth: Integer); override;
    procedure CalculatePadding(var PaddingL, PaddingT, PaddingR,
      PaddingB: Integer); override;
    procedure CalculateText(var Textwidth, TextHeight: Integer;
      var StringList: TStringList); override;
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
    function GetWidgetStylename: string; virtual;
    procedure MakePadding(const Value: string);
  public
    constructor Create(Owner: TComponent); override;
    procedure Rename(const OldName, NewName, Events: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure DeleteWidget; override;
    procedure MakeStyle;
    property Padding: string read FPadding write SetPadding;
    property Text: string read FText write SetText;
  published
    property Style: string read FStyle write FStyle;
  end;

implementation

uses
  Math,
  SysUtils,
  UITypes,
  UUtils;

{ --- TTKWidget ---------------------------------------------------------------- }

constructor TTKWidget.Create(Owner: TComponent);
begin
  inherited;
  BorderWidth := '0';
end;

procedure TTKWidget.SetPadding(const Value: string);
begin
  if Value <> FPadding then
  begin
    FPadding := Value;
    Invalidate;
  end;
end;

procedure TTKWidget.SetText(const Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    Invalidate;
  end;
end;

function TTKWidget.GetText: string;
begin
  Result := FText;
end;

procedure TTKWidget.CalculateText(var Textwidth, TextHeight: Integer;
  var StringList: TStringList);
var
  AText: string;
  Posi: Integer;
begin
  AText := GetText;
  Posi := Pos('\n', AText);
  while Posi > 0 do
  begin
    StringList.Add(Copy(AText, 1, Posi - 1));
    Delete(AText, 1, Posi + 1);
    Posi := Pos('\n', AText);
  end;
  StringList.Add(AText);
  Textwidth := 0;
  for Posi := 0 to StringList.Count - 1 do
    Textwidth := Max(Textwidth, Canvas.Textwidth(StringList[Posi]));
  TextHeight := StringList.Count * Canvas.TextHeight('Hg');
end;

{
  f['padding'] = 5           # 5 pixels on all sides
  f['padding'] = (5,10)      # 5 on left and right, 10 on top and bottom
  f['padding'] = (5,7,10,12) # left: 5, top: 7, right: 10, bottom: 12
}
procedure TTKWidget.CalculatePadding(var PaddingL, PaddingT, PaddingR,
  PaddingB: Integer);
var
  APadding: string;
  StringList: TStringList;
begin
  APadding := Trim(FPadding);
  if APadding = '' then
    APadding := '0';
  if (APadding[1] = '(') and (APadding[Length(APadding)] = ')') then
  begin
    APadding := Copy(APadding, 2, Length(APadding) - 2);
    StringList := Split(',', APadding);
    if StringList.Count = 2 then
    begin
      if not TryStrToInt(StringList[0], PaddingL) then
        PaddingL := 0;
      PaddingR := PaddingL;
      if not TryStrToInt(StringList[1], PaddingT) then
        PaddingT := 0;
      PaddingB := PaddingT;
    end
    else if StringList.Count = 4 then
    begin
      if not TryStrToInt(StringList[0], PaddingL) then
        PaddingL := 0;
      if not TryStrToInt(StringList[1], PaddingT) then
        PaddingT := 0;
      if not TryStrToInt(StringList[2], PaddingR) then
        PaddingR := 0;
      if not TryStrToInt(StringList[3], PaddingB) then
        PaddingB := 0;
    end;
    FreeAndNil(StringList);
  end
  else
  begin
    if not TryStrToInt(APadding, PaddingL) then
      PaddingL := 0;
    PaddingR := PaddingL;
    PaddingT := PaddingL;
    PaddingB := PaddingL;
  end;
  PaddingL := PaddingL + BorderWidthInt;
  PaddingT := PaddingT + BorderWidthInt;
  PaddingR := PaddingR + BorderWidthInt;
  PaddingB := PaddingB + BorderWidthInt;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar then
    PaddingB := PaddingB + 20;
  if (Scrollbars = _TB_vertical) or (Scrollbars = _TB_both) then
    PaddingR := PaddingR + 20;
end;

function TTKWidget.GetCompound: TUCompound;
begin
  Result := _TU_none;
end;

procedure TTKWidget.PaintBorder(Rect: TRect; Relief: TRelief;
  BorderWidth: Integer);

  procedure PaintTopLeft(Color1, Color2: TColor);
  begin
    Canvas.Pen.Color := Color1;
    Canvas.MoveTo(Rect.Left, Rect.Bottom - 1);
    Canvas.LineTo(Rect.Left, Rect.Top);
    Canvas.LineTo(Rect.Right, Rect.Top);
    Canvas.Pen.Color := Color2;
    Canvas.MoveTo(Rect.Left + 1, Rect.Bottom - 2);
    Canvas.LineTo(Rect.Left + 1, Rect.Top + 1);
    Canvas.LineTo(Rect.Right - 1, Rect.Top + 1);
  end;

  procedure PaintBottomRight(Color1, Color2: TColor);
  begin
    Canvas.Pen.Color := Color1;
    Canvas.MoveTo(Rect.Left + 1, Rect.Bottom - 2);
    Canvas.LineTo(Rect.Right - 2, Rect.Bottom - 2);
    Canvas.LineTo(Rect.Right - 2, Rect.Top);
    Canvas.Pen.Color := Color2;
    Canvas.MoveTo(Rect.Left, Rect.Bottom - 1);
    Canvas.LineTo(Rect.Right - 1, Rect.Bottom - 1);
    Canvas.LineTo(Rect.Right - 1, Rect.Top - 1);
  end;

begin
  if Relief <> _TR_flat then
  begin
    case Relief of
      _TR_groove:
        begin
          PaintTopLeft($A0A0A0, $FFFFFF);
          PaintBottomRight($A0A0A0, $FFFFFF);
        end;
      _TR_raised:
        begin
          PaintTopLeft($E3E3E3, $FFFFFF);
          PaintBottomRight($696969, $A0A0A0);
        end;
      _TR_ridge:
        begin
          PaintTopLeft($E3E3E3, $696969);
          PaintBottomRight($696969, $E3E3E3);
        end;
      _TR_solid:
        begin
          Canvas.Rectangle(Rect);
        end;
      _TR_sunken:
        begin
          PaintTopLeft($A0A0A0, $696969);
          PaintBottomRight($FFFFFF, $E3E3E3);
        end;
    end;
  end;
end;

procedure TTKWidget.Paint;
begin
  if Relief <> _TR_flat then
    BorderWidthInt := PPIScale(2)
  else
    BorderWidthInt := 0;
  inherited;
end;

function TTKWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  if ShowAttributes = 3 then
    Result := Result + '|Style';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKWidget.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Style' then
    MakeStyle
  else if Attr = 'Padding' then
    MakePadding(Value)
  else
    inherited;
end;

function TTKWidget.GetWidgetStylename: string;
begin
  Result := Name + '.T' + Copy(ClassName, 4, Length(ClassName));
end;

procedure TTKWidget.DeleteWidget;
begin
  inherited;
  if Style <> '' then
    Partner.DeleteLine('ttk.Style().configure(' + AsString(Style));
end;

procedure TTKWidget.Rename(const OldName, NewName, Events: string);
var
  WType: string;
begin
  inherited;
  if FStyle <> '' then
  begin
    WType := Copy(FStyle, Pos('.', FStyle), Length(FStyle));
    Partner.ReplaceWord(FStyle, NewName + WType, True);
    FStyle := NewName + WType;
  end;
end;

procedure TTKWidget.MakeStyle;
var
  Str: string;
begin
  FStyle := GetWidgetStylename;
  Str := 'ttk.Style().configure(' + AsString(FStyle) + ')';
  SetAttributValue(Str, Str);
  Str := 'self.' + Name + '[''style'']';
  SetAttributValue(Str, Str + ' = ' + AsString(FStyle));
  UpdateObjectInspector;
end;

procedure TTKWidget.MakePadding(const Value: string);
var
  Key: string;
  Int: Integer;
begin
  Key := 'self.' + Name + '[''padding'']';
  if Value = '' then
    Partner.DeleteAttribute(Key)
  else if (Value[1] = '(') and (Value[Length(Value)] = ')') then
    SetAttributValue(Key, Key + ' = ' + Value)
  else
  begin
    if TryStrToInt(Value, Int) then
      FPadding := '(' + Value + ', ' + Value + ', ' + Value + ', ' + Value + ')'
    else
      FPadding := '(10, 10, 10, 10)';
    SetAttributValue(Key, Key + ' = ' + Padding);
    UpdateObjectInspector;
  end;
end;

end.
