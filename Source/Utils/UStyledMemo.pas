unit UStyledMemo;

{$R-}

interface

uses
  Windows, Messages, Controls, StdCtrls, Classes, Themes, Grids;

type

  TMemoStyleHookColor = class(TMemoStyleHook)  // TMemoStyleHook in StdCtrls
  private
    procedure UpdateColors;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TWinControlH = class(TWinControl);

  TStyledMemo = class(TMemo);


implementation

uses
  Graphics, SysUtils, System.UITypes, SynEdit;

{--- TMemoStyleHook -----------------------------------------------------------}
{--- https://theroadtodelphi.com/2012/02/06/changing-the-color-of-edit-controls-with-vcl-styles-enabled/ }

{ Define Colors in Color und Font.Color of TMemo
  Example in UMessages:
    MInterpreter.Color:= BGColor;
    MInterpreter.Font.Color:= FGColor;
}

constructor TMemoStyleHookColor.Create(AControl: TWinControl);
begin
  inherited;
  //call the UpdateColors method to use the custom colors
  UpdateColors;
end;

//Here you set the colors of the style hook
procedure TMemoStyleHookColor.UpdateColors;
begin
  if Control.Enabled then begin
    Brush.Color:= TWinControlH(Control).Color; // use the Control color
    FontColor  := TWinControlH(Control).Font.Color; // use the Control font color
  end else begin
    // if the control is disabled use the colors of the style
    Brush.Color:= StyleServices.GetStyleColor(scEdit); // scEditDisabled
    FontColor  := StyleServices.GetStyleFontColor(sfEditBoxTextDisabled);
  end;
end;

//handle the messages
procedure TMemoStyleHookColor.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        //get the colors
        UpdateColors;
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled:= true;
      end;
    CM_COLORCHANGED,
    CM_ENABLEDCHANGED:
      begin
        //get the colors
        UpdateColors;
        Handled:= false;
      end
  else
    inherited WndProc(Message);
  end;
end;

initialization
  TStyleManager.Engine.RegisterStyleHook(TStyledMemo, TMemoStyleHookColor);

finalization
  TStyleManager.Engine.UnRegisterStyleHook(TStyledMemo, TMemoStyleHookColor);

end.


