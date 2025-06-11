{ -------------------------------------------------------------------------------
  Unit:     ULifeline
  Author:   Gerhard Röhner
  Date:     July 2019
  Purpose:  Lifeline class
  ------------------------------------------------------------------------------- }

unit ULifeline;

interface

uses
  Classes,
  Graphics,
  UPanelTransparent,
  USequencePanel;

type
  TLifeline = class(TPanelTransparent)
  private
    FActivation: Integer;
    FSequencePanel: TSequencePanel;
    FTextWidth: Integer;
    FTextHeight: Integer;
    FDistY: Integer;
    FActivationWidth: Integer;
    FMinWidth: Integer;
    FMinHeight: Integer;
    FPadding: Integer;
    FCreated: Boolean;
    FBackgroundColor: TColor;
    FClosed: Boolean;
    FFirst: Boolean;
    FForegroundColor: TColor;
    FHeadHeight: Integer;
    FInternalName: string;
    FLineHeight: Integer;
    FOnCreatedChanged: TNotifyEvent;
    FParticipant: string;
    FRenamed: Boolean;
    procedure SetCreated(const Value: Boolean);
    procedure ShowHead;
  protected
    procedure Paint; override;
  public
    constructor CreateLL(AOwner: TComponent; const Participant: string;
      AFont: TFont);
    procedure SetFont(AFont: TFont);
    procedure GetWidthHeigthOfText(const Text: string;
      var Width, Height: Integer);
    procedure CalcWidthHeight;
    procedure RenameParticipant(const Value: string);
    procedure ChangeStyle(BlackAndWhite: Boolean = False);

    property Activation: Integer read FActivation write FActivation;
    property Closed: Boolean read FClosed write FClosed;
    property Created: Boolean read FCreated write SetCreated;
    property First: Boolean read FFirst write FFirst;
    property HeadHeight: Integer read FHeadHeight;
    property InternalName: string read FInternalName;
    property OnCreatedChanged: TNotifyEvent read FOnCreatedChanged
      write FOnCreatedChanged;
    property Participant: string read FParticipant write FParticipant;
  end;

implementation

uses
  Windows,
  Types,
  Math,
  Controls,
  SysUtils,
  UITypes,
  Themes,
  UUtils,
  UConfiguration;

constructor TLifeline.CreateLL(AOwner: TComponent; const Participant: string;
  AFont: TFont);
begin
  inherited Create(AOwner);
  FSequencePanel := AOwner as TSequencePanel;
  Parent := FSequencePanel;
  if Pos('@', Participant) > 0 then
    FInternalName := Participant
  else
    Self.FParticipant := Participant;
  FCreated := False;
  FClosed := False;
  FRenamed := (Participant = 'Actor');
  SetFont(AFont);
  ChangeStyle;
end;

procedure TLifeline.SetFont(AFont: TFont);
const
  CPadding: Integer = 20;
begin
  Canvas.Font.Assign(AFont);
  FDistY := Round(CDistY * Font.Size / 12.0);
  FActivationWidth := Round(CActivationWidth * Font.Size / 12.0);
  FMinWidth := Round(CMinWidth * Font.Size / 12.0);
  FMinHeight := Round(CMinHeight * Font.Size / 12.0);
  FPadding := Round(CPadding * Font.Size / 12.0);
  CalcWidthHeight;
end;

procedure TLifeline.Paint;
var
  Connections: TList;
  Conn1, Conn2: TConnection;
  Jdx, Y1Pos, Y2Pos: Integer;
  HeadColor: TColor;
begin
  Canvas.Pen.Color := FForegroundColor;
  Canvas.Font.Color := FForegroundColor;

  if GuiPyOptions.SDNoFilling then
    Canvas.Brush.Color := FBackgroundColor
  else
    Canvas.Brush.Color := GuiPyOptions.SDFillingColor;
  HeadColor := Canvas.Brush.Color;
  if IsColorDark(HeadColor) and IsColorDark(FForegroundColor) then
    Canvas.Font.Color := FForegroundColor
  else if not IsColorDark(HeadColor) and not IsColorDark(FForegroundColor) then
    Canvas.Font.Color := FBackgroundColor;

  ShowHead;
  Connections := FSequencePanel.GetConnections;
  Canvas.Pen.Style := psDash;
  Canvas.MoveTo(Width div 2, FHeadHeight);
  if Connections.Count > 0 then
    Canvas.LineTo(Width div 2, Height)
  else
    Canvas.LineTo(Width div 2, FHeadHeight + FDistY);
  Canvas.Pen.Style := psSolid;

  // FActivation of FFirst Lifeline
  if GuiPyOptions.SDNoFilling then
    Canvas.Brush.Color := FBackgroundColor
  else
    Canvas.Brush.Color := GuiPyOptions.SDFillingColor;

  if (Connections.Count > 0) and FFirst then
  begin
    Y1Pos := TConnection(Connections[0]).StartPoint.Y;
    Y2Pos := TConnection(Connections.Last).StartPoint.Y;
    if Y2Pos = Y1Pos then
      Y2Pos := Y2Pos + FDistY;
    if TConnection(Connections.Last).IsRecursiv then
      Y2Pos := Y2Pos + FDistY div 2;
    Canvas.Rectangle(Width div 2 - FActivationWidth, Y1Pos - Top,
      Width div 2 + FActivationWidth, Y2Pos - Top + 1);
  end;

  // show activations
  for var I := 0 to Connections.Count - 1 do
  begin
    Conn1 := TConnection(Connections[I]);
    if (Conn1.EndControl = Self) and (Conn1.ArrowStyle <> casNew) then
    begin
      Y1Pos := Conn1.StartPoint.Y;
      Y2Pos := 0;
      Jdx := I + 1;
      while Jdx < Connections.Count do
      begin
        Conn2 := TConnection(Connections[Jdx]);
        if (Conn2.EndControl = Conn1.StartControl) and
          (Conn2.StartControl = Conn1.EndControl) and
          (Conn2.ArrowStyle = casReturn) and
          (not Conn1.IsRecursiv or (Conn2.FromActivation = Conn1.FromActivation
          + 1)) then
        begin
          Y2Pos := Conn2.StartPoint.Y;
          Break;
        end;
        Inc(Jdx);
      end;
      if Y2Pos > 0 then
        if Conn1.IsRecursiv then
          Canvas.Rectangle(Width div 2 + (Conn1.FromActivation - 1) *
            FActivationWidth, Y1Pos - Top + FDistY div 2,
            Width div 2 + (Conn1.FromActivation + 1) * FActivationWidth,
            Y2Pos - Top + 1)
        else
          Canvas.Rectangle(Width div 2 - FActivationWidth, Y1Pos - Top,
            Width div 2 + FActivationWidth, Y2Pos - Top + 1);
    end;
  end;
  FreeAndNil(Connections);
end;

procedure TLifeline.ShowHead;
var
  Rec: TRect;
  Mid, Unity, Base, Delta: Integer;
begin
  if Pos('Actor', FParticipant) = 1 then
  begin
    Canvas.Pen.Width := 1;
    Mid := Width div 2;
    Unity := Round(FLineHeight * 0.7);
    Delta := Round(Unity * 0.935);
    Base := Round(Unity * 2.21);
    Rec := Rect(Mid - Unity div 2, 0, Mid + Unity div 2, Unity);
    Canvas.Ellipse(Rec);

    Canvas.MoveTo(Mid, Unity);
    Canvas.LineTo(Mid, Base);
    Canvas.MoveTo(Mid - Delta, Round(Unity * 1.42));
    Canvas.LineTo(Mid + Delta, Round(Unity * 1.42));

    Canvas.MoveTo(Mid, Base);
    Canvas.LineTo(Mid - Delta, Base + Delta);
    Canvas.MoveTo(Mid, Base);
    Canvas.LineTo(Mid + Delta, Base + Delta);
  end
  else
  begin
    Canvas.Pen.Width := 2;
    Canvas.Rectangle(1, 1, Width, FHeadHeight);
    Canvas.Pen.Width := 1;
    Rec := Rect(0, (FHeadHeight - FTextHeight) div 2, Width,
      (FHeadHeight + FTextHeight) div 2);
    DrawText(Canvas.Handle, PChar(FParticipant), Length(FParticipant), Rec,
      DT_CENTER);
  end;
  Canvas.Brush.Color := FBackgroundColor;
end;

procedure TLifeline.CalcWidthHeight;
begin
  FLineHeight := Canvas.TextHeight('A');
  GetWidthHeigthOfText(FParticipant, FTextWidth, FTextHeight);
  Width := Max(FTextWidth + FPadding, FMinWidth);
  FHeadHeight := Max(FTextHeight + FPadding, FMinHeight);
  if Pos('Actor', FParticipant) = 1 then
    FHeadHeight := Round(FLineHeight * 0.7 * (0.935 + 2.21));
end;

procedure TLifeline.GetWidthHeigthOfText(const Text: string;
  var Width, Height: Integer);
var
  Str, Str1: string;
  Posi: Integer;
begin
  Width := FMinWidth;
  Height := FLineHeight;
  Str := Text;
  Posi := Pos(#13#10, Str);
  while Posi > 0 do
  begin
    Str1 := Copy(Str, 1, Posi - 1);
    System.Delete(Str, 1, Posi + 1);
    Width := Max(Canvas.TextWidth(Str1), Width);
    Height := Height + FLineHeight;
    Posi := Pos(#13#10, Str);
  end;
  Width := Max(Canvas.TextWidth(Str), Width);
end;

procedure TLifeline.SetCreated(const Value: Boolean);
begin
  if FCreated <> Value then
  begin
    FCreated := Value;
    FOnCreatedChanged(Self);
  end;
end;

procedure TLifeline.RenameParticipant(const Value: string);
begin
  FParticipant := Value;
  CalcWidthHeight;
  Paint;
end;

procedure TLifeline.ChangeStyle(BlackAndWhite: Boolean = False);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then
  begin
    FBackgroundColor := clWhite;
    FForegroundColor := clBlack;
  end
  else
  begin
    FBackgroundColor := StyleServices.GetStyleColor(scPanel);
    FForegroundColor := StyleServices.GetStyleFontColor
      (sfTabTextInactiveNormal);
  end;
end;

end.
