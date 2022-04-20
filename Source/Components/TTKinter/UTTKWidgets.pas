{-------------------------------------------------------------------------------
 Unit:     UTTKWidgets
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  TTKinter base widget
-------------------------------------------------------------------------------}

unit UTTKWidgets;

interface

uses
  Windows, SysUtils, Classes, UBaseTKWidgets;

type

  TTKWidget = class (TBaseTKWidget)
  private
    FPadding: string;
    FStyle: String;
    FText: String;
    procedure setPadding(aValue: String);
  protected
    function getCompound: TUCompound; override;
    procedure Paint; override;
    procedure PaintBorder(R: TRect; Relief: TRelief; BorderWidth: integer); override;
    procedure CalculatePadding(var pl, pt, pr, pb: integer); override;
    procedure CalculateText(var tw, th: integer; var SL: TStringlist); override;
    function getText: String; virtual;
    procedure setText(aValue: string); virtual;
    function getWidgetStylename: String; virtual;
    procedure MakePadding(Value: String);
  public
    constructor Create(aOwner: TComponent); override;
    procedure Rename(const OldName, NewName, Events: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure DeleteWidget; override;
    procedure MakeStyle(Value: String);
    property Padding: String read FPadding write setPadding;
    property Text: String read FText write setText;
  published
    property Style: string read FStyle write FStyle;
  end;

implementation

uses Math, UITypes, TypInfo, GraphUtil, UImages, UUtils, UObjectGenerator,
     UObjectInspector, UGuiForm, UTKMiscBase, UConfiguration, UKoppel;

{--- TTKWidget ----------------------------------------------------------------}

constructor TTKWidget.Create(aOwner: TComponent);
begin
  inherited;
  BorderWidth:= '0';
end;

procedure TTKWidget.setPadding(aValue: String);
begin
  if aValue <> fPadding then begin
    fPadding:= aValue;
    Invalidate;
  end;
end;

procedure TTKWidget.setText(aValue: string);
begin
  if aValue <> fText then begin
    fText:= aValue;
    Invalidate;
  end;
end;

function TTKWidget.getText: String;
begin
  Result:= FText;
end;

procedure TTKWidget.CalculateText(var tw, th: integer; var SL: TStringlist);
  var s: String; p: integer;
begin
  s:= getText;
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

{
f['padding'] = 5           # 5 pixels on all sides
f['padding'] = (5,10)      # 5 on left and right, 10 on top and bottom
f['padding'] = (5,7,10,12) # left: 5, top: 7, right: 10, bottom: 12
}
procedure TTKWidget.CalculatePadding(var pl, pt, pr, pb: integer);
  var s: String; SL: TStringList;
begin
  s:= trim(FPadding);
  if s = '' then
    s:= '0';
  if (s[1] = '(') and (s[length(s)] = ')') then begin
    s:= copy(s, 2, length(s) - 2);
    SL:= Split(',', s);
    if SL.Count = 2 then begin
      if not TryStrToInt(SL.Strings[0], pl) then pl:= 0;
      pr:= pl;
      if not TryStrToInt(SL.Strings[1], pt) then pt:= 0;
      pb:= pt;
    end else if SL.Count = 4 then begin
      if not TryStrToInt(SL.Strings[0], pl) then pl:= 0;
      if not TryStrToInt(SL.Strings[1], pt) then pt:= 0;
      if not TryStrToInt(SL.Strings[2], pr) then pr:= 0;
      if not TryStrToInt(SL.Strings[3], pb) then pb:= 0;
    end;
    FreeandNil(SL);
  end else begin
    if not TryStrToInt(s, pl) then pl:= 0;
    pr:= pl;
    pt:= pl;
    pb:= pl;
  end;
  pl:= pl + BorderWidthInt;
  pt:= pt + BorderWidthInt;
  pr:= pr + BorderWidthInt;
  pb:= pb + BorderWidthInt;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar then
    pb:= pb + 20;
  if (Scrollbars = _TB_vertical) or (Scrollbars = _TB_both) then
    pr:= pr + 20;
end;

function TTKWidget.getCompound: TUCompound;
begin
  Result:= _TU_none;
end;

procedure TTKWidget.PaintBorder(R: TRect; Relief: TRelief; BorderWidth: integer);

  procedure PaintTopLeft(C1, C2: TColor);
  begin
    Canvas.Pen.Color:= C1;
    Canvas.MoveTo(R.Left, R.Bottom - 1);
    Canvas.LineTo(R.Left, R.Top);
    Canvas.LineTo(R.Right, R.Top);
    Canvas.Pen.Color:= C2;
    Canvas.MoveTo(R.Left + 1, R.Bottom - 2);
    Canvas.LineTo(R.Left + 1, R.Top + 1);
    Canvas.LineTo(R.Right - 1, R.Top + 1);
  end;

  procedure PaintBottomRight(C1, C2: TColor);
  begin
    Canvas.Pen.Color:= C1;
    Canvas.MoveTo(R.Left + 1, R.Bottom - 2);
    Canvas.LineTo(R.Right - 2, R.Bottom - 2);
    Canvas.LineTo(R.Right - 2, R.Top);
    Canvas.Pen.Color:= C2;
    Canvas.MoveTo(R.Left, R.Bottom - 1);
    Canvas.LineTo(R.Right - 1, R.Bottom - 1);
    Canvas.LineTo(R.Right - 1, R.Top - 1);
  end;

begin
  if Relief <> _TR_flat then begin
    case Relief of
      _TR_groove: begin
         PaintTopLeft($A0A0A0, $FFFFFF);
         PaintBottomRight($A0A0A0, $FFFFFF);
       end;
      _TR_raised: begin
         PaintTopLeft($E3E3E3, $FFFFFF);
         PaintBottomRight($696969, $A0A0A0);
       end;
      _TR_ridge: begin
         PaintTopLeft($E3E3E3, $696969);
         PaintBottomRight($696969, $E3E3E3);
       end;
      _TR_solid: begin
         //Canvas.Pen.Color:= $7A7A7A;
         //Canvas.Brush.Color:= $7A7A7A;
         Canvas.Rectangle(R);
         //Canvas.Brush.Color:= Background;
       end;
      _TR_sunken: begin
         PaintTopLeft($A0A0A0, $696969);
         PaintBottomRight($FFFFFF, $E3E3E3);
       end;
    end;
  end;
end;

procedure TTKWidget.Paint;
begin
  if Relief <> _TR_flat
    then BorderWidthInt:= 2
    else BorderWidthInt:= 0;
  inherited;
end;

function TTKWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '';
  if ShowAttributes = 3 then
    Result:= Result + '|Style';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKWidget.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Style' then
    MakeStyle(Value)
  else if Attr = 'Padding' then
    MakePadding(Value)
  else
    inherited;
end;

function TTKWidget.getWidgetStylename: String;
begin
  Result:= Name + '.T' + copy(Classname, 4, length(Classname));
end;

procedure TTKWidget.DeleteWidget;
begin
  inherited;
  if Style <> '' then
    Partner.DeleteLine('ttk.Style().configure(' + asString(Style));
end;

procedure TTKWidget.Rename(const OldName, NewName, Events: string);
  var WType: string;
begin
  inherited;
  if FStyle <> '' then begin
    WType:= copy(FStyle, Pos('.', FStyle), length(FStyle));
    Partner.ReplaceWord(FStyle, NewName + WType, true);
    FStyle:= NewName + WType;
  end;
end;

procedure TTKWidget.MakeStyle(Value: String);
  var s: String;
begin
  FStyle:= getWidgetStylename;
  s:= 'ttk.Style().configure(' + asString(FStyle) + ')';
  setAttributValue(s, s);
  s:= 'self.' + Name + '[''style'']';
  setAttributValue(s, s + ' = ' + asString(FStyle));
  UpdateObjectInspector;
end;

procedure TTKWidget.MakePadding(Value: String);
  var key: string; i: integer;
begin
  key:= 'self.' + Name + '[''padding'']';
  if Value = '' then
    Partner.DeleteAttribute(key)
  else if (Value[1] = '(') and (Value[length(Value)] = ')') then
    setAttributValue(key, key + ' = ' + Value)
  else begin
    if TryStrToInt(Value, i)
      then FPadding:= '(' + Value + ', ' + Value + ', ' + Value + ', ' + Value + ')'
      else FPadding:= '(10, 10, 10, 10)';
    setAttributValue(key, key + ' = ' + Padding);
    UpdateObjectInspector;
  end;
end;

end.
