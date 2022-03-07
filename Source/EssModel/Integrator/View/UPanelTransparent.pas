{-------------------------------------------------------------------------------
 Unit:     UPanelTransparent
 Author:   Gerhard Röhner
 Date:     June 2021
 Purpose:  transparent panel for uml and sequence window
-------------------------------------------------------------------------------}

unit UPanelTransparent;

interface

uses
  Windows, Messages, Controls, ExtCtrls;

type
  TPanelTransparent = class (TPanel)
  private
    procedure CnCtlColorStatic (var Msg: TWMCtlColorStatic); message CN_CTLCOLORSTATIC;
    procedure WmEraseBkgnd (var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure Paint; override;
    procedure CreateParams (var Params: TCreateParams); override;
  end;


implementation

procedure TPanelTransparent.CreateParams (var Params: TCreateParams);
  begin
    inherited CreateParams(Params);
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
  end;

procedure TPanelTransparent.WmEraseBkgnd(var Msg: TWMEraseBkgnd);
  begin
  //  SetBkMode (msg.DC, TRANSPARENT);
    Msg.Result := 1;
  end;

procedure TPanelTransparent.CnCtlColorStatic(var Msg: TWMCtlColorStatic);
  begin
    SetBKMode (Msg.ChildDC, TRANSPARENT);
    Msg.Result := GetStockObject (NULL_BRUSH);
  end;

procedure TPanelTransparent.Paint;
  begin
    SetBKMode (Handle, TRANSPARENT);
    //inherited;
  end;

end.
