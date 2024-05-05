unit ELHintWindow;

{Copy from unit Controls with TOP instead of TOPMOST }

interface

uses Windows, Messages, Classes, Controls;

type

  TESHintWindow = class(TCustomControl)
  private
    FActivating: Boolean;
    FLastActive: Cardinal;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure NCPaint(DC: HDC); virtual;
    procedure Paint; override;
    procedure WMPrint(var Message: TMessage); message WM_PRINT;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ActivateHint(Rect: TRect; const AHint: string); virtual;
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); virtual;
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; virtual;
    function IsHintMsg(var Msg: TMsg): Boolean; virtual;
    function ShouldHideHint: Boolean; virtual;
    procedure ReleaseHandle;
    property BiDiMode;
    property Caption;
    property Color;
    property Canvas;
    property Font;
  end;


implementation

uses Forms, Graphics, SysUtils, Themes, Types;

{ TESHintWindow }

constructor TESHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := $80FFFF;
  Canvas.Font := Screen.HintFont;
  Canvas.Brush.Style := bsClear;
end;

procedure TESHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    // CS_DROPSHADOW requires Windows XP or above
    if CheckWin32Version(5, 1) then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
    if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;
    {AddBiDiModeExStyle(ExStyle);  { TODO : auskommentiert }
  end;
end;

procedure TESHintWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

procedure TESHintWindow.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    NCPaint(DC);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TESHintWindow.Paint;
begin
  var R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Canvas.Font.Color := Screen.HintFont.Color;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
  // SWP_NOACTIVATE!
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NoMove or SWP_NoSize or SWP_NOACTIVATE);
end;

function TESHintWindow.IsHintMsg(var Msg: TMsg): Boolean;
begin
  with Msg do
    Result := ((Message >= WM_KEYFIRST) and (Message <= WM_KEYLAST)) or
      ((Message = CM_ACTIVATE) or (Message = CM_DEACTIVATE)) or
      (Message = CM_APPKEYDOWN) or (Message = CM_APPSYSCOMMAND) or
      (Message = WM_COMMAND) or ((Message > WM_MOUSEMOVE) and
      (Message <= WM_MOUSELAST)) or (Message = WM_NCMOUSEMOVE);
end;

procedure TESHintWindow.ReleaseHandle;
begin
  DestroyHandle;
end;

procedure TESHintWindow.CMTextChanged(var Message: TMessage);
begin
  inherited;
  { Avoid flicker when calling ActivateHint }
  if FActivating then Exit;
  Width := Canvas.TextWidth(Caption) + 6;
  Height := Canvas.TextHeight(Caption) + 4;
end;

procedure TESHintWindow.ActivateHint(Rect: TRect; const AHint: string);
type
  TAnimationStyle = (atSlideNeg, atSlidePos, atBlend);
const
  AnimationStyle: array[TAnimationStyle] of Integer = (AW_VER_NEGATIVE,
    AW_VER_POSITIVE, AW_BLEND);
var
  Animate: BOOL;
  Style: TAnimationStyle;
begin
  FActivating := True;
  try
    Caption := AHint;
    Inc(Rect.Bottom, 4);
    UpdateBoundsRect(Rect);
    if Rect.Top + Height > Screen.DesktopHeight then
      Rect.Top := Screen.DesktopHeight - Height;
    if Rect.Left + Width > Screen.DesktopWidth then
      Rect.Left := Screen.DesktopWidth - Width;
    if Rect.Left < Screen.DesktopLeft then Rect.Left := Screen.DesktopLeft;
    if Rect.Bottom < Screen.DesktopTop then Rect.Bottom := Screen.DesktopTop;
    SetWindowPos(Handle, HWND_TOP, Rect.Left, Rect.Top, Width, Height, {WS_EX_TOPMOST + WS_EX_NOACTIVATE}
      SWP_NOACTIVATE + SWP_SHOWWINDOW);

    if (GetTickCount - FLastActive > 250) and (Length(AHint) < 100) and
       Assigned(AnimateWindowProc) then
    begin
      SystemParametersInfo(SPI_GETTOOLTIPANIMATION, 0, @Animate, 0);
      if Animate then
      begin
        SystemParametersInfo(SPI_GETTOOLTIPFADE, 0, @Animate, 0);
        if Animate then
          Style := atBlend
        else
          if Mouse.CursorPos.Y > Rect.Top then
            Style := atSlideNeg
          else
            Style := atSlidePos;
        AnimateWindowProc(Handle, 100, AnimationStyle[Style] or AW_SLIDE);
      end;
    end;
    //ShowWindow(Handle, SW_SHOWNOACTIVATE);
    Invalidate;
  finally
    FLastActive := GetTickCount;
    FActivating := False;
  end;
end;

procedure TESHintWindow.ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer);
begin
  ActivateHint(Rect, AHint);
end;

function TESHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Result := Rect(0, 0, MaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AHint), -1, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);
  Inc(Result.Right, 6);
  Inc(Result.Bottom, 2);
end;

procedure TESHintWindow.NCPaint(DC: HDC);
var
  R: TRect;
  Details: TThemedElementDetails;
begin
  R := Rect(0, 0, Width, Height);
  if not StyleServices.Enabled then
    Windows.DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT)
  else
  begin
    Details := StyleServices.GetElementDetails(twWindowRoot);
    StyleServices.DrawEdge(DC, Details, R, [eeRaisedOuter], [efLEFT, efTOP, efRIGHT, efBOTTOM]);
  end;
end;

procedure TESHintWindow.WMPrint(var Message: TMessage);
begin
  PaintTo(Message.WParam, 0, 0);
  NCPaint(Message.WParam);
end;

function TESHintWindow.ShouldHideHint: Boolean;
begin
  Result := True;
end;

end.
