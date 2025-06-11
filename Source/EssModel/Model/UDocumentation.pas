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

unit UDocumentation;

interface

type
  //Instance of this class is a member of TModelEntity
  TDocumentation = class
  private
    FDescription : string;
    FLineE: Integer;
    FLineS: Integer;
    procedure SetDescription(const Value: string);
  public
    property Description : string read FDescription write SetDescription;
    property LineE: Integer read FLineE write FLineE;
    property LineS: Integer read FLineS write FLineS;
  end;

implementation

uses SysUtils;

{ TDocumentation }

procedure TDocumentation.SetDescription(const Value: string);
begin
  var
  Int := 1;
  while (Int < Length(Value) + 1) and
    CharInSet(Value[Int], ['*', '_', '/', ' ', #13, #10]) do
    Inc(Int);
  if Int > 1 then
    FDescription := Copy(Value, Int, MaxInt)
  else
    FDescription := Value;
  FDescription := Value;
end;

end.
