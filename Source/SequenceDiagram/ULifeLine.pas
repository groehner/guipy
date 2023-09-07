{-------------------------------------------------------------------------------
 Unit:     ULifeLine
 Author:   Gerhard Röhner
 Date:     July 2019
 Purpose:  lifeline class
-------------------------------------------------------------------------------}

unit ULifeLine;

interface

uses
  Classes, Graphics, UPanelTransparent, USequencePanel;

type
  TLifeLine = class(TPanelTransparent)
  private
    SequencePanel: TSequencePanel;
    TextWidth: Integer;
    TextHeight: Integer;
    DistY: integer;
    ActivationWidth: integer;
    MinWidth: Integer;
    MinHeight: Integer;
    Padding: Integer;
    FCreated: boolean;
    BGColor: TColor;
    FGColor: TColor;
    LineHeight: integer;
    Renamed: boolean;
    procedure SetCreated(const Value: boolean);
    procedure ShowHead;
  protected
    procedure Paint; override;
  public
    Participant: String;
    InternalName: String;
    Activation: integer;
    HeadHeight: Integer;
    Closed: boolean;
    First: boolean;
    onCreatedChanged: TNotifyEvent;
    constructor CreateLL(aOwner: TComponent; const aParticipant: String; aFont: TFont);
    procedure SetFont(aFont: TFont);
    procedure getWidthHeigthOfText(const aText: string; var w, h: integer);
    procedure CalcWidthHeight;
    procedure RenameParticipant(const Value: string);
    property Created: boolean read FCreated write setCreated;
  end;

implementation

uses
  Windows, Types, Controls, Math, SysUtils, UITypes, Themes, UConfiguration;

constructor TLifeLine.CreateLL(aOwner: TComponent; const aParticipant: String; aFont: TFont);
begin
  inherited Create(aOwner);
  SequencePanel:= aOwner as TSequencePanel;
  Parent:= SequencePanel;
  if Pos('@', aParticipant) > 0
    then InternalName:= aParticipant
    else Self.Participant:= aParticipant;
  Created:= false;
  Closed:= false;
  Renamed:= (aParticipant = 'Actor');
  setFont(aFont);
  CalcWidthHeight;
end;

procedure TLifeLine.SetFont(aFont: TFont);
  const cPadding: Integer = 20;
begin
  Canvas.Font.Assign(aFont);
  DistY:= Round(cDistY*Font.Size/12.0);
  ActivationWidth:= Round(cActivationWidth*Font.Size/12.0);
  MinWidth:= Round(cMinWidth*Font.Size/12.0);
  MinHeight:= Round(cMinHeight*Font.Size/12.0);
  Padding:= Round(cPadding*Font.Size/12.0);
  CalcWidthHeight;
end;

procedure TLifeLine.Paint;
  var Connections: TList;
      Conn1, Conn2: TConnection;
      i, j, y1, y2: integer;
      HeadColor: TColor;

  function isDark(Color: TColor): boolean;
    var ACol: Longint;
  begin
    ACol := ColorToRGB(Color) and $00FFFFFF;
    Result := ((2.99 * GetRValue(ACol) + 5.87 * GetGValue(ACol) +
                 1.14 * GetBValue(ACol)) < $400);
  end;

begin
  if StyleServices.IsSystemStyle then begin
    BGColor:= clWhite;
    FGColor:= clBlack;
  end else begin
    BGColor:= StyleServices.GetStyleColor(scPanel);
    FGColor:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  Canvas.Pen.Color:= FGColor;
  Canvas.Font.Color:= FGColor;

  if GuiPyOptions.SDNoFilling
    then Canvas.Brush.Color:= BGColor
    else Canvas.Brush.Color:= GuiPyOptions.SDFillingcolor;

  HeadColor:= Canvas.Brush.Color;
  if IsDark(HeadColor) and IsDark(FGColor) then
    Canvas.Font.Color:= FGColor
  else if not IsDark(HeadColor) and not IsDark(FGColor) then
    Canvas.Font.Color:= BGColor;

  ShowHead;
  Connections:= SequencePanel.GetConnections;
  Canvas.Pen.Style:= psDash;
  Canvas.MoveTo(Width div 2, HeadHeight);
  if Connections.Count > 0
    then Canvas.LineTo(Width div 2, Height)
    else Canvas.LineTo(Width div 2, HeadHeight + DistY);
  Canvas.Pen.Style:= psSolid;

  // activation of first lifeline
  if GuiPyOptions.SDNoFilling
    then Canvas.Brush.Color:= BGColor
    else Canvas.Brush.Color:= GuiPyOptions.SDFillingcolor;

  if (Connections.Count > 0) and First then begin
    y1:= TConnection(Connections.Items[0]).FromP.y;
    y2:= TConnection(Connections.Items[Connections.Count-1]).FromP.y;
    if y2 = y1 then
      y2:= y2 + DistY;
    if TConnection(Connections.Items[Connections.Count-1]).isRecursiv then
      y2:= y2 + DistY div 2;
    Canvas.Rectangle(Width div 2 - ActivationWidth, y1-Top, width div 2 + ActivationWidth, y2-Top+1);
  end;

  // show activations
  for i:= 0 to Connections.Count - 1 do begin
    Conn1:= TConnection(Connections.Items[i]);
    if (Conn1.FTo = Self) and (Conn1.ArrowStyle <> casNew) then begin
      y1:= Conn1.FromP.y;
      y2:= 0;
      j:= i+1;
      while j < Connections.Count do begin
        Conn2:= TConnection(Connections.Items[j]);
        if (Conn2.FTo = Conn1.FFrom) and (Conn2.FFrom = Conn1.FTo) and (Conn2.ArrowStyle = casReturn) and
           (not Conn1.isRecursiv or (Conn2.FromActivation = Conn1.FromActivation + 1))
        then begin
          y2:= Conn2.FromP.y;
          break;
        end;
        inc(j);
      end;
      if y2 > 0 then
        if Conn1.isRecursiv
          then Canvas.Rectangle(Width div 2 + (conn1.FromActivation-1)*ActivationWidth, y1 - Top + DistY div 2,
                                Width div 2 + (conn1.FromActivation+1)*ActivationWidth, y2 - Top + 1)
          else Canvas.Rectangle(Width div 2 - ActivationWidth, y1-Top, width div 2 + ActivationWidth, y2 - Top + 1);
    end;
  end;
  FreeAndNil(Connections);
end;

procedure TLifeLine.ShowHead;
  var R: TRect; mid, unity, base, delta: integer;
begin
  if Pos('Actor', Participant) = 1 then begin
    Canvas.Pen.Width:= 1;
    mid:= Width div 2;
    unity:= Round(LineHeight*0.7);
    delta:= Round(unity*0.935);
    base:=  Round(unity*2.21);
    R:= Rect(mid - unity div 2, 0, mid + unity div 2, unity);
    Canvas.Ellipse(R);

    Canvas.MoveTo(mid, unity);
    Canvas.LineTo(mid, base);
    Canvas.MoveTo(mid - delta, round(unity*1.42));
    Canvas.LineTo(mid + delta, round(unity*1.42));

    Canvas.MoveTo(mid,  base);
    Canvas.LineTo(mid - delta, base + delta);
    Canvas.MoveTo(mid,  base);
    Canvas.LineTo(mid + delta, base + delta);
  end else begin
    Canvas.Pen.Width:= 2;
    Canvas.Rectangle(1, 1, Width, HeadHeight);
    Canvas.Pen.Width:= 1;
    R:= Rect(0, (HeadHeight - TextHeight) div 2, Width, (HeadHeight + TextHeight) div 2);
    DrawText(Canvas.Handle, PChar(Participant), Length(Participant), R, DT_CENTER);
  end;
  Canvas.Brush.Color:= BGColor;
end;

procedure TLifeLine.CalcWidthHeight;
begin
  LineHeight:= Canvas.TextHeight('A');
  getWidthHeigthOfText(Participant, TextWidth, TextHeight);
  Width:= max(TextWidth + Padding, minWidth);
  HeadHeight:= max(TextHeight + Padding, minHeight);
  if Pos('Actor', Participant) = 1 then
    HeadHeight:= Round(LineHeight*0.7*(0.935 + 2.21));
end;

procedure TLifeLine.getWidthHeigthOfText(const aText: string; var w, h: integer);
  var s, s1: String; p: integer;
begin
  w:= minWidth;
  h:= LineHeight;
  s:= aText;
  p:= Pos(#13#10, s);
  while p > 0 do begin
    s1:= copy(s, 1, p-1);
    System.delete(s, 1, p+1);
    w:= max(Canvas.TextWidth(s1), w);
    h:= h + LineHeight;
    p:= Pos(#13#10, s);
  end;
  w:= max(Canvas.TextWidth(s), w);
end;

procedure TLifeLine.SetCreated(const Value : boolean);
begin
  if FCreated <> Value then begin
    FCreated:= Value;
    onCreatedChanged(Self);
  end;
end;

procedure TLifeLine.RenameParticipant(const Value : string);
begin
  Participant:= Value;
  CalcWidthHeight;
  Paint;
end;

end.
