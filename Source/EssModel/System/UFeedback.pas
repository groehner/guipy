{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

unit UFeedback;

interface

uses ExtCtrls;

type
  IEldeanFeedback = interface(IUnknown)
    ['{130C7331-3B65-4D90-BF5C-07DF47B17317}']
    procedure Message(const M : string);
  end;

  TGuiFeedback = class(TInterfacedObject,IEldeanFeedback)
  private
    P : TPanel;
    T : TTimer;
  private
    procedure OnTimer(Sender : TObject);
  public
    constructor Create(aPanel : TPanel);
    destructor Destroy; override;
    procedure Message(const M : string);
  end;

var
  NilFeedback : IEldeanFeedback;


implementation


uses SysUtils;

{ TGuiFeedback }

constructor TGuiFeedback.Create(aPanel: TPanel);
begin
  Self.P := aPanel;
  T := TTimer.Create(nil);
  T.OnTimer := {$IFDEF LCL} @ {$ENDIF} OnTimer;
end;

destructor TGuiFeedback.Destroy;
begin
  FreeAndNil(T);
  inherited;
end;

procedure TGuiFeedback.Message(const M: string);
begin
  P.Caption := M;
  P.Visible := True;
  P.Height := 20;
  P.Refresh;
  T.Enabled := False;
  T.Interval := 5000;
  T.Enabled := True;
end;

procedure TGuiFeedback.OnTimer(Sender: TObject);
begin
  if P.Height>=0 then
  begin
    P.Height := P.Height - 5;
    T.Interval := 25;
  end
  else
  begin
    P.Visible := False;
    T.Enabled := False;
  end;
end;


{ TNilFeedback }

type
  TNilFeedback = class(TInterfacedObject, IEldeanFeedback)
    procedure Message(const M : string);
  end;

procedure TNilFeedback.Message(const M: string);
begin
//
end;

initialization
  NilFeedBack := TNilFeedback.Create;

end.
