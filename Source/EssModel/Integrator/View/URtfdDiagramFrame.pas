{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde
  Gerhard Röhner

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

unit URtfdDiagramFrame;

interface

uses
  Messages, Classes, Controls, Forms, Vcl.Menus, System.ImageList, ImgList,
  uListeners, uDiagramFrame, uRtfdDiagram, SpTBXItem, TB2Item;

type
  TAFrameRtfdDiagram = class(TAFrameDiagram)
  public
    constructor Create(aOwner: TComponent; aDiagram: TRtfdDiagram); reintroduce;
  end;

implementation

{$R *.DFM}

// probably really necessary for reasons of circular references

constructor TAFrameRtfdDiagram.Create(aOwner: TComponent; aDiagram: TRtfdDiagram);
begin
  inherited Create(aOwner, aDiagram.Model);
  Self.Diagram:= aDiagram;
end;


end.
