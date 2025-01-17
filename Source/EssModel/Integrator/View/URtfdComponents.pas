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


  procedure TVisibilityLabel.Paint;
}

unit URtfdComponents;

interface

uses Windows, Messages, Classes, Graphics, Controls, StdCtrls,
  uModel, uModelEntity, uListeners, uDiagramFrame, uStyledMemo,
  UPanelTransparent, UUtils;

type
  // Baseclass for a diagram-panel
  TRtfdBoxClass = class of TRtfdBox;

  TRtfdBox = class(TPanelTransparent, IModelEntityListener)
  private
    FMinVisibility: TVisibility;
    FShowParameter: Integer;
    FSortOrder: Integer;
    FShowIcons: Integer;
    FShowStatic: Boolean;
    FShowInherited: Boolean;
    FShowView: Integer;
    FExtentX: Integer;
    FExtentY: Integer;
    FShadowWidth: Integer;
    FTypeBinding: string;
    FSelected: Boolean;
    FTypeParameter: string;
    FETypeBinding: TEdit;
    FBGColor: TColor;
    FFGColor: TColor;
    FBitmap: TBitmap;
    FBitmapOK: Boolean;
    SVGHead: string;
    SVGComment: string;
    procedure SetMinVisibility(const Value: TVisibility);
    procedure SetShowParameter(const Value: Integer);
    procedure SetSortOrder(const Value: Integer);
    procedure SetShowIcons(const Value: Integer);
    procedure SetShowView(const Value: Integer);
    procedure SetSelected(const Value: Boolean); virtual;
    procedure SetTypeBinding(const Value: string);
    procedure SetShadowWidth(const Value: Integer);
    procedure OnChildMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnChildMouseDblClick(Sender: TObject);
    procedure OnEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: Classes.TOperation); override;
  public
    Frame: TAFrameDiagram;
    Entity: TModelEntity;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity;
      aFrame: TAFrameDiagram; MinVisibility: TVisibility); reintroduce; virtual;
    destructor Destroy; override;
    procedure PaintShadow(rounded: Boolean; sw: Integer; C: TCanvas; R: TRect);
    procedure RefreshEntities; virtual;
    function GetPathname: string; virtual; abstract;
    function GetBoundsRect: TRect; virtual;
    function MyGetClientRect: TRect;
    procedure Paint; override;
    procedure Change(Sender: TModelEntity); virtual;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); virtual;
    procedure Remove(Sender: TModelEntity); virtual;
    procedure EntityChange(Sender: TModelEntity); virtual;
    procedure SetParameters(ShowParameter, SortOrder, ShowIcons: Integer;
      aFont: TFont; const TypeBinding: string);
    function isJUnitTestclass: Boolean;
    procedure CloseEdit;
    procedure makeBitmap;
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function getSVG: string; virtual;
    function getTopH: Integer;

    property MinVisibility: TVisibility read FMinVisibility
      write SetMinVisibility;
    property ShowParameter: Integer read FShowParameter write SetShowParameter;
    property SortOrder: Integer read FSortOrder write SetSortOrder;
    property ShowIcons: Integer read FShowIcons write SetShowIcons;
    property ShowView: Integer read FShowView write SetShowView;
    property ShowInherited: Boolean read FShowInherited write FShowInherited;
    property ExtentX: Integer read FExtentX write FExtentX;
    property ExtentY: Integer read FExtentY write FExtentY;
    property Selected: Boolean read FSelected write SetSelected;
    property ShadowWidth: Integer read FShadowWidth write SetShadowWidth;
    property TypeParameter: string read FTypeParameter write FTypeParameter;
    property TypeBinding: string read FTypeBinding write SetTypeBinding;
    property FGColor: TColor read FFGColor write FFGColor;
    property BGColor: TColor read FBGColor write FBGColor;
  end;

  TRtfdClass = class(TRtfdBox, IAfterClassListener)
  private
    Pathname: string;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity;
      aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetPathname: string; override;
    function Debug: string;
  end;

  TRtfdObject = class(TRtfdBox, IAfterObjektListener)
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity;
      aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function getClassname: string;
  end;

  TRtfdInterface = class(TRtfdBox, IAfterInterfaceListener)
  private
    Pathname: string;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity;
      aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetPathname: string; override;
  end;

  TRtfdCommentBox = class(TRtfdBox)
  private
    HandleSize: Integer;
    panels: array [0 .. 7] of TRect;
    procedure SetSelected(const Value: Boolean); override;
    function getPanelRect(i: Integer): TRect;
    function getPanelNr(P: TPoint): Integer;
  public
    TrMemo: TStyledMemo;
    constructor Create(aOwner: TComponent; const S: string;
      aFrame: TAFrameDiagram; aMinVisibility: TVisibility;
      aHandleSize: Integer); reintroduce;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    function GetPathname: string; override;
    procedure Paint; override;
    procedure ResizeMemo;
    procedure CommentMouseMove(PFrom, PTo: TPoint);
    procedure OnCommentBoxEnter(Sender: TObject);
  end;

  TRtfdUnitPackage = class(TRtfdBox)
  public
    P: TUnitPackage;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity;
      aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    procedure RefreshEntities; override;
  end;

  { --- RtfdCustomLabel and descentants ------------------------------------------ }

  TRtfdCustomLabel = class(TGraphicControl, IModelEntityListener)
  private
    FAlignment: TAlignment;
    FTransparent: Boolean;
    Entity: TModelEntity;
    FTextWidth: Integer;
    FGColor: TColor;
    BGColor: TColor;
    SingleLineHeight: Integer;
    function GetAlignment: TAlignment;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetTransparent(const Value: Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure AdjustBounds;
    procedure DoDrawText(var Rect: TRect; Flags: Integer);
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity);
      reintroduce; virtual;
    procedure Paint; override;
    procedure Change(Sender: TModelEntity); virtual;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); virtual;
    procedure Remove(Sender: TModelEntity); virtual;
    procedure EntityChange(Sender: TModelEntity); virtual;
    procedure SetColors;
    function getSVG(OwnerRect: TRect): string; virtual;
    property Alignment: TAlignment read GetAlignment write SetAlignment
      default taLeftJustify;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property TextWidth: Integer read FTextWidth;
  end;

  TRtfdClassName = class(TRtfdCustomLabel, IAfterClassListener)
  private
    FTextWidthParameter: Integer;
    FExtentX: Integer;
    FExtentY: Integer;
    TypeParameter: string;
    TypeAndBinding: string;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure Paint; override;
    function getSVG(OwnerRect: TRect): string; override;
    function getSVGTypeAndBinding(R: TRect): string;
    property TextWidthParameter: Integer read FTextWidthParameter;
    property ExtentX: Integer read FExtentX write FExtentX;
    property ExtentY: Integer read FExtentY;
  end;

  TRtfdObjectName = class(TRtfdCustomLabel, IAfterObjektListener)
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure Paint; override;
    function getSVG(OwnerRect: TRect): string; override;
  end;

  TRtfdInterfaceName = class(TRtfdCustomLabel, IAfterInterfaceListener)
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    function getSVG(OwnerRect: TRect): string; override;
  end;

  TRtfdStereotype = class(TRtfdCustomLabel)
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity;
      const aCaption: string); reintroduce;
  end;

  TRtfdUnitPackageName = class(TRtfdCustomLabel, IAfterUnitPackageListener)
  private
    P: TUnitPackage;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterUnitPackageListener.EntityChange = EntityChange;
  end;

  // Class to display name of package at upper-left corner in a unitpackage diagram
  TRtfdUnitPackageDiagram = class(TRtfdCustomLabel, IAfterUnitPackageListener)
  private
    P: TUnitPackage;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterUnitPackageListener.EntityChange = EntityChange;
  end;

  // Left-justified label with visibility-icon
  TVisibilityLabel = class(TRtfdCustomLabel)
  protected
  public
    procedure Paint; override;
    function getSVG(OwnerRect: TRect): string; override;
  end;

  TRtfdOperation = class(TVisibilityLabel, IAfterOperationListener)
  private
    O: TOperation;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterOperationListener.EntityChange = EntityChange;
  end;

  TRtfdAttribute = class(TVisibilityLabel, IAfterAttributeListener)
  private
    A: TAttribute;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterAttributeListener.EntityChange = EntityChange;
  end;

  TRtfdSeparator = class(TGraphicControl)
  public
    constructor Create(aOwner: TComponent); override;
    procedure Paint; override;
    function getSVG(OwnerRect: TRect): string;
  end;

implementation

uses SysUtils, Forms, Themes, UITypes, Types, Math, ExtCtrls, VirtualImageList,
  StrUtils, uIterators, uConfiguration, uViewIntegrator, UCommonFunctions, frmPyIDEMain;

const
  cDefaultWidth = 150;

function getSVGRect(X, Y, w, h: real; color: string;
  attribute: string = ''): string;
begin
  Result := '  <rect x=' + FloatToVal(X) + ' y=' + FloatToVal(Y) + ' width=' +
    FloatToVal(w) + ' height=' + FloatToVal(h) + ' fill="' + color +
    '" stroke="black"' + attribute + ' />'#13#10;
end;

function getSVGCircle(X, Y, R: real): string;
begin
  Result := '  <circle cx=' + FloatToVal(X) + ' cy=' + FloatToVal(Y) + ' r=' +
    FloatToVal(R) + ' fill="none" stroke="black" />'#13#10;
end;

function getSVGText(X, Y: real; attribute, text: string): string;
var
  SL: TStringList;
  i: Integer;
  dyr: real;
  dys: string;

  function getPreserve(S: string): string;
  begin
    if (Length(S) > 0) and (S[1] = ' ') then
      Result := ' xml:space="preserve"'
    else
      Result := '';
  end;

begin
  SL := TStringList.Create;
  SL.text := ConvertLtGt(text);
  Result := '  <text x=' + FloatToVal(X) + ' y=' + FloatToVal(Y) +
    attribute + '>';
  if SL.Count > 1 then
  begin
    Result := Result + #13#10'    <tspan' + getPreserve(SL.Strings[0]) + '>' +
      SL.Strings[0] + '</tspan>'#13#10;
    dyr := 1.3;
    for i := 1 to SL.Count - 1 do
    begin
      if Trim(SL.Strings[i]) = '' then
        dyr := dyr + 1.3
      else
      begin
        dys := FloatToVal(dyr);
        insert('em', dys, Length(dys));
        Result := Result + '    <tspan' + getPreserve(SL.Strings[i]) + ' x=' +
          FloatToVal(X) + ' dy=' + dys + '>' + SL.Strings[i] + '</tspan>'#13#10;
        dyr := 1.3;
      end;
    end;
    Result := Result + '  </text>'#13#10;
  end
  else
    Result := Result + ReplaceText(SL.text, #13#10, '') + '</text>'#13#10;
  FreeAndNil(SL);
end;

function getSVGPolyline(Points: array of TPoint; color: string): string;
var
  i: Integer;
begin
  Result := '  <polyline points="';
  for i := 0 to High(Points) do
    Result := Result + PointToVal(Points[i]);
  Result[Length(Result)] := '"';
  Result := Result + ' fill="none" stroke="' + color +
    '" stroke-width="2" />'#13#10;
end;

function getSVGPolygon(Points: array of TPoint; color: string): string;
var
  i: Integer;
begin
  Result := '  <polygon points="';
  for i := 0 to High(Points) do
    Result := Result + PointToVal(Points[i]);
  Result[Length(Result)] := '"';
  Result := Result + ' fill="' + color + '" stroke="black" />'#13#10;
end;

function calcSVGBaseLine(R: TRect; Font: TFont): Integer;
begin
  Result := R.Top + Round(1.0 * abs(Font.Height));
end;

{ TRtfdBox }
constructor TRtfdBox.Create(aOwner: TComponent; aEntity: TModelEntity;
  aFrame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(aOwner);
  BorderWidth := 3;
  Self.Frame := aFrame;
  Self.Entity := aEntity;
  Self.FMinVisibility := MinVisibility;
  Font.assign(aFrame.Diagram.Font);
  Top := (aFrame.ClientHeight - Self.Width) div 2 + Random(50) - 25;
  Left := (aFrame.ClientWidth - Self.Width) div 2 + Random(50) - 25;
  ParentBackground := True;
  DoubleBuffered := False; // bad for debugging
  ShadowWidth := GuiPyOptions.ShadowWidth;
  FETypeBinding := nil;
  FBitmap := nil;
  ChangeStyle;
end;

destructor TRtfdBox.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TRtfdBox.RefreshEntities;
begin
  Frame.Diagram.ClearMarkerAndConnections(Self);
  DestroyComponents;
  FreeAndNil(FBitmap);
  FBitmapOK := False;
end;

function TRtfdBox.GetBoundsRect: TRect;
begin
  Result := BoundsRect;
  Result.Bottom := Result.Bottom - ShadowWidth;
  Result.Right := Result.Right - ShadowWidth;
end;

function TRtfdBox.MyGetClientRect: TRect;
begin
  Result := ClientRect;
  Result.Bottom := Result.Bottom;
  Result.Right := Result.Right - ExtentX;
  Result.Left := Result.Left;
  Result.Top := Result.Top;
end;

procedure TRtfdBox.PaintShadow(rounded: Boolean; sw: Integer; C: TCanvas;
  R: TRect);
var
  i, SCol, ECol, sr, sg, sb, er, eg, eb: Integer;

  function ColorGradient(i: Integer): TColor;
  var
    R, g, b: Integer;
  begin
    R := sr + Round(((er - sr) * i) / sw);
    g := sg + Round(((eg - sg) * i) / sw);
    b := sb + Round(((eb - sb) * i) / sw);
    Result := RGB(R, g, b);
  end;

begin
  if sw = 0 then
    Exit;
  C.Pen.Mode := pmCopy;
  SCol := ColorToRGB(BGColor);
  sr := GetRValue(SCol);
  sg := GetGValue(SCol);
  sb := getBValue(SCol);
  ECol := ColorToRGB(FGColor);
  er := GetRValue(ECol);
  eg := GetGValue(ECol);
  eb := getBValue(ECol);
  C.Pen.Width := 2;
  for i := 1 to sw do
  begin
    C.Pen.color := ColorGradient(i);
    if rounded then
      C.RoundRect(R.Left + i, R.Top + i, R.Right - i, R.Bottom - i,
        16 - i, 16 - i)
    else
      C.PolyLine([Point(R.Right - sw, R.Top + i), Point(R.Right - i, R.Top + i),
        Point(R.Right - i, R.Bottom - i), Point(R.Left + i, R.Bottom - i),
        Point(R.Left + i, R.Bottom - sw)]);
  end;
  C.Pen.Width := 1;
end;

procedure TRtfdBox.Paint;
var
  R, R1: TRect;
  sw, Si, TopH, NeedH, i, Separator: Integer;
  IsObject, IsClass, IsValid: Boolean;
  Pathname, SVGColor: string;
begin
  Canvas.Font.Assign(Font);
  if Assigned(FBitmap) and FBitmapOK then
  begin
    Canvas.Draw(0, 0, FBitmap);
    if Selected then
      Frame.Diagram.DrawMarkers(GetBoundsRect, True);
    Exit;
  end;

  IsValid := False;
  IsObject := (Self is TRtfdObject);
  IsClass := (Self is TRtfdClass);
  if IsClass then
  begin
    Pathname := (Self as TRtfdClass).Pathname;
    IsValid := PyIDEMainForm.IsAValidClass(Pathname);
  end;

  sw := ShadowWidth;
  Si := 255 - Round(GuiPyOptions.ShadowIntensity * 25.5);
  R := MyGetClientRect; // Client
  NeedH := BorderWidth + sw + 5;
  if ComponentCount > 0 then
  begin
    TopH := TGraphicControl(Components[0]).Height + NeedH - sw;
    if Components[0] is TRtfdStereotype then
      TopH := TopH + TGraphicControl(Components[0]).Height;
  end
  else
    TopH := NeedH - sw;

  TopH := TopH - ExtentY;

  // debugging
  // FMessages.OutputToTerminal('Paint: ' + ExtractFilename(Pathname));

  with Canvas do
  begin
    // the white border musst be filled, else there are arrow-grabber rests
    // Canvas.Brush.Color:= clWhite;
    // Canvas.FillRect(Clientrect);

    // markers
    if Selected then
      Frame.Diagram.DrawMarkers(GetBoundsRect, True);

    // shadow-colors
    Brush.color := RGB(Si, Si, Si);
    R1 := Rect(R.Left + sw, R.Top + sw + ExtentY, R.Right, R.Bottom);

    if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
      (IsClass and (GuiPyOptions.ClassHead = 1)) then
      PaintShadow(True, sw, Canvas, R1)
    else
      PaintShadow(False, sw, Canvas, R1);

    // Background
    Pen.color := FGColor;
    Brush.color := BGColor;

    // footer first
    if IsObject and (GuiPyOptions.ObjectFooter = 1) then
    begin
      RoundRect(R.Left, R.Bottom - sw - TopH, R.Right - sw,
        R.Bottom - sw, 16, 16);
      Rectangle(R.Left, R.Top + TopH - 1, R.Right - sw,
        R.Bottom - sw - TopH div 2);
      MoveTo(R.Left + 1, R.Bottom - sw - TopH div 2 - 1);
      Pen.color := BGColor;
      LineTo(R.Right - sw - 1, R.Bottom - sw - TopH div 2 - 1);
      Pen.color := FGColor;
    end
    else // room for attributes and methods
      if R.Bottom > TopH + sw then
        Rectangle(R.Left, R.Top + TopH - 1 + ExtentY, R.Right - sw,
          R.Bottom - sw);

    // Class- or Object-Label
    if IsObject then
    begin
      Brush.color := GuiPyOptions.ObjectColor;
      SVGColor := myColorToRGB(GuiPyOptions.ObjectColor);
    end
    else if IsValid then
    begin
      Brush.color := BGColor;
      SVGColor := myColorToRGB(GuiPyOptions.ValidClassColor);
    end
    else
    begin
      Brush.color := GuiPyOptions.InvalidClassColor;
      SVGColor := myColorToRGB(GuiPyOptions.InvalidClassColor);
    end;
    if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
      (IsClass and (GuiPyOptions.ClassHead = 1)) then
    begin
      RoundRect(R.Left, R.Top, R.Right - sw, R.Top + TopH, 16, 16);
      FillRect(Rect(R.Left, R.Top + TopH div 2, R.Right - sw, R.Top + TopH));
      MoveTo(R.Left, R.Top + TopH div 2);
      LineTo(R.Left, R.Top + TopH - 1);
      LineTo(R.Right - sw - 1, R.Top + TopH - 1);
      LineTo(R.Right - sw - 1, R.Top + TopH div 2 - 1);
      SVGHead := '  <path d="M ' + XYToVal(R.Left, R.Top + TopH - 1) + ' h ' +
        IntToStr(R.Width - sw) + ' v ' + IntToStr(-TopH + 1 + 8) + ' a ' +
        PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(-8, -8)) + ' h '
        + IntToStr(-R.Width + sw + 2 * 8) + ' a ' + PointToVal(Point(8, 8)) +
        '90 0 0 ' + PointToVal(Point(-8, +8)) + ' v ' + IntToStr(TopH - 1 - 8) +
        '" fill="' + SVGColor + '" stroke="black" />'#13#10;
    end
    else
    begin // class label
      Rectangle(R.Left, R.Top + ExtentY, R.Right - sw, R.Top + TopH + ExtentY);
      SVGHead := getSVGRect(R.Left, R.Top + ExtentY, R.Right - sw,
        R.Top + TopH - 1, SVGColor);
    end;

    // debug: show box frame
    // Canvas.Brush.Color:= clRed;
    // FrameRect(ClientRect);

    if IsObject and (GuiPyOptions.ObjectFooter = 1) then
      Pen.color := clGray;

    // if IsClassOrInterface or (IsObject and GuiPyOptions.ShowObjectsWithMethods) then begin
    Separator := ExtentY;
    if (Self is TRtfdInterface) or isJUnitTestclass then
      i := 3
    else
      i := 2;
    while (i < ComponentCount) and (Components[i] is TRtfdAttribute) do
    begin
      Separator := Separator + TGraphicControl(Components[i]).Height;
      Inc(i);
    end;
    if (i < ComponentCount) and (Components[i] is TRtfdSeparator) then
    begin
      Separator := Separator + TopH - 1 +
        (Components[i] as TRtfdSeparator).Height;
      MoveTo(R.Left, Separator);
      LineTo(R.Right - sw, Separator);
    end;
    // end;
  end;
  // paintTo in makeBitmap calls Paint to create the bitmap
  // it doesn't copy the screen-pixels, because controls can be covered by others
  // or can be partially places outside the window
  if not Assigned(FBitmap) then
    makeBitmap;
  FBitmapOK := True;
end;

function TRtfdBox.getSVG: string;
var
  R: TRect;
  TopH, sw, i: Integer;
  IsObject, IsClassOrInterface, IsComment: Boolean;
  S, ShadowFilter: string;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
begin
  R := MyGetClientRect;
  sw := ShadowWidth;
  TopH := getTopH;
  IsObject := (Self is TRtfdObject);
  IsClassOrInterface := (Self is TRtfdClass) or (Self is TRtfdInterface);
  IsComment := (Self is TRtfdCommentBox);
  if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
    (IsClassOrInterface and (GuiPyOptions.ClassHead = 1)) then
    R.Top := R.Top + TopH - 1;
  if ShadowWidth > 0 then
    ShadowFilter := ' style="filter:url(#Shadow)"'
  else
    ShadowFilter := '';

  S := '<g id="' + ConvertLtGt(Entity.Name) + '" transform="translate(' +
    IntToStr(Left) + ', ' + IntToStr(Top) + ')" font-family="' + Font.Name +
    '" font-size=' + IntToVal(Round(Font.Size * 1.3)) + ShadowFilter +
    '>'#13#10;
  if IsObject and (GuiPyOptions.ObjectFooter = 1) then
    S := S + '  <path d="M ' + XYToVal(R.Left, R.Top) + ' v ' +
      IntToStr(R.Height - 8 - sw) + ' a ' + PointToVal(Point(8, 8)) + '90 0 0 '
      + PointToVal(Point(8, 8)) + ' h ' + IntToStr(R.Width - sw - 2 * 8) + ' a '
      + PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(8, -8)) + ' v ' +
      IntToStr(-R.Height + 8 + sw) + ' h ' + IntToStr(-R.Width + sw) +
      '" fill="white" stroke="black" />'#13#10
  else if IsComment then
  begin
    Paint;
    S := S + SVGComment
  end
  else
    S := S + getSVGRect(R.Left, R.Top + FExtentY, R.Width - sw,
      R.Height - FExtentY - sw, 'white');

  if IsClassOrInterface and (SVGHead = '') then
    Paint;
  S := S + SVGHead;
  R := GetBoundsRect;
  R.Width := R.Width - FExtentX;
  R.Top := R.Top + FExtentY;
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := Controls[i] as TRtfdCustomLabel;
      S := S + CustomLabel.getSVG(R); // BoundsRect
    end;
    if Controls[i] is TRtfdSeparator then
    begin
      Separator := Controls[i] as TRtfdSeparator;
      S := S + Separator.getSVG(R);
    end;
  end;
  Result := S + '</g>'#13#10;

  if (Controls[0] is TRtfdClassName) and
    ((Controls[0] as TRtfdClassName).TypeAndBinding <> '') then
  begin
    S := '<g id="' + ConvertLtGt(Entity.Name + '1') + '" transform="translate('
      + IntToStr(Left) + ', ' + IntToStr(Top) + ')" font-family="' + Font.Name +
      '" font-size=' + IntToVal(Round(Font.Size * 1.3)) + '>'#13#10;
    Result := Result + S;
    Result := Result + (Controls[0] as TRtfdClassName).getSVGTypeAndBinding(R);
    Result := Result + '</g>'#13#10;
  end;
  Result := ReplaceStr(Result, '[]', '[ ]');
  Result := Result + #13#10;
end;

function TRtfdBox.getTopH: Integer;
begin
  var
  NeedH := BorderWidth + ShadowWidth + 5;
  if ComponentCount > 0 then
  begin
    var
    CustomLabel := TRtfdCustomLabel(Components[0]);
    Result := CustomLabel.Height + NeedH - ShadowWidth;
    if CustomLabel is TRtfdStereotype then
      Result := Result + CustomLabel.Height;
  end
  else
    Result := NeedH - ShadowWidth;
  Result := Result - ExtentY;
end;

procedure TRtfdBox.AddChild(Sender, NewChild: TModelEntity);
begin
  // Stub
end;

procedure TRtfdBox.Change(Sender: TModelEntity);
begin
  // Stub
end;

procedure TRtfdBox.EntityChange(Sender: TModelEntity);
begin
  // Stub
end;

procedure TRtfdBox.Remove(Sender: TModelEntity);
begin
  // Stub
end;

procedure TRtfdBox.SetMinVisibility(const Value: TVisibility);
begin
  if Value <> FMinVisibility then
  begin
    FMinVisibility := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShowParameter(const Value: Integer);
begin
  if Value <> FShowParameter then
  begin
    FShowParameter := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetSortOrder(const Value: Integer);
begin
  if Value <> FSortOrder then
  begin
    FSortOrder := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShowIcons(const Value: Integer);
begin
  if Value <> FShowIcons then
  begin
    FShowIcons := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShowView(const Value: Integer);
begin
  if Value <> FShowView then
  begin
    FShowView := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetSelected(const Value: Boolean);
begin
  if Value <> FSelected then
  begin
    FSelected := Value;
    Frame.Diagram.DrawMarkers(GetBoundsRect, Value);
  end;
end;

procedure TRtfdBox.SetTypeBinding(const Value: string);
begin
  if Value <> FTypeBinding then
  begin
    FTypeBinding := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShadowWidth(const Value: Integer);
begin
  if Value <> FShadowWidth then
  begin
    FShadowWidth := Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetParameters(ShowParameter, SortOrder, ShowIcons: Integer;
  aFont: TFont; const TypeBinding: string);
begin
  Self.Font.assign(aFont);
  Canvas.Font.Assign(aFont);
  Self.FShowParameter := ShowParameter;
  Self.FSortOrder := SortOrder;
  Self.FShowIcons := ShowIcons;
  Self.FTypeBinding := TypeBinding;
  RefreshEntities;
end;

// The following declarations are needed for helping essconnectpanel to
// catch all mouse actions. All controls that are inserted (classname etc)
// in rtfdbox will get their mousedown-event redefined.
type
  TCrackControl = class(TControl);

procedure TRtfdBox.Notification(AComponent: TComponent;
  Operation: Classes.TOperation);
begin
  inherited;
  // Owner=Self must be tested because notifications are being sent for all components
  // in the form. TRtfdLabels are created with Owner=box.
  if (Operation = opInsert) and (AComponent.Owner = Self) and
    (AComponent is TControl) then
  begin
    TCrackControl(AComponent).OnMouseDown := OnChildMouseDown;
    TCrackControl(AComponent).OnDblClick := OnChildMouseDblClick;
  end;
end;

procedure TRtfdBox.OnChildMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  pt.X := X;
  pt.Y := Y;
  pt := TControl(Sender).ClientToScreen(pt);
  pt := ScreenToClient(pt);
  MouseDown(Button, Shift, pt.X, pt.Y);
end;

procedure TRtfdBox.OnChildMouseDblClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt := ScreenToClient(Mouse.CursorPos);
  if GuiPyOptions.ShowClassparameterSeparately and (TypeParameter <> '') and
    (pt.X > Width - 2 * ExtentX - 12) and (pt.Y < 2 * ExtentY + 4) then
  begin
    Selected := False;
    FETypeBinding := TEdit.Create(Owner);
    FETypeBinding.Parent := (Owner as TCustomPanel);
    FETypeBinding.OnKeyUp := OnEditKeyUp;
    FETypeBinding.Visible := True;
    FETypeBinding.text := FTypeParameter + ': ' + FTypeBinding;
    FETypeBinding.Font.assign(Font);
    FETypeBinding.SetBounds(Left + Width - 2 * ExtentX - 6, Top + 6,
      2 * ExtentX + 50, 2 * ExtentY - 4);
    FETypeBinding.SelStart := Length(FETypeBinding.text);
    if FETypeBinding.CanFocus then
      FETypeBinding.SetFocus;
  end
  else
    Frame.Diagram.EditBox(Self);
end;

procedure TRtfdBox.OnEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    CloseEdit;
end;

procedure TRtfdBox.CloseEdit;
begin
  if Assigned(FETypeBinding) and FETypeBinding.Visible then
  begin
    var
    S := FETypeBinding.text;
    Delete(S, 1, Length(FTypeParameter) + 2);
    TypeBinding := S;
    Frame.Diagram.SetModified(True);
    FETypeBinding.Visible := False;
    FreeAndNil(FETypeBinding);
  end;
end;

function TRtfdBox.isJUnitTestclass: Boolean;
begin
  if Entity is TClass then
    Result := (Entity as TClass).isJUnitTestclass
  else
    Result := False;
end;

procedure TRtfdBox.makeBitmap;
begin
  if FBitmap = nil then
  begin
    FBitmapOK := False;
    FBitmap := TBitmap.Create;
    FBitmap.Width := Width;
    FBitmap.Height := Height;
    FBitmap.Canvas.Lock;
    FBitmap.Canvas.Pen.color := FGColor;
    FBitmap.Canvas.Brush.color := clred;;
    FBitmap.TransparentColor := clred;
    FBitmap.Transparent := True;
    FBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
    PaintTo(FBitmap.Canvas, 0, 0);
    FBitmap.Canvas.Unlock;
  end;
end;

procedure TRtfdBox.ChangeStyle(BlackAndWhite: Boolean = False);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then
  begin
    BGColor := clWhite;
    FGColor := clBlack;
  end
  else
  begin
    BGColor := StyleServices.GetStyleColor(scPanel);
    FGColor := StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  color := BGColor;
  FreeAndNil(FBitmap);
end;

{ TRtfdClass }

constructor TRtfdClass.Create(aOwner: TComponent; aEntity: TModelEntity;
  aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  Self.FShowStatic := True;
  Pathname := (aEntity as TClass).Pathname;
  PopupMenu := aFrame.PopMenuClass;
  aEntity.AddListener(IAfterClassListener(Self));
  FShowParameter := GuiPyOptions.DiShowParameter;
  FSortOrder := GuiPyOptions.DiSortOrder;
  FShowIcons := GuiPyOptions.DiShowIcons;
  FMinVisibility := TVisibility(GuiPyOptions.DiVisibilityFilter);
  RefreshEntities;
end;

destructor TRtfdClass.Destroy;
begin
  Entity.RemoveListener(IAfterClassListener(Self));
  inherited;
end;

procedure TRtfdClass.AddChild(Sender: TModelEntity; NewChild: TModelEntity);
begin
  RefreshEntities;
end;

function TRtfdClass.GetPathname: string;
begin
  Result := Pathname;
end;

procedure TRtfdClass.RefreshEntities;
var
  NeedH, NeedW, i, aTop: Integer;
  C: TClass;
  Omi, Ami: IModelIterator;
  aClassname: TRtfdClassName;
  CustomLabel: TRtfdCustomLabel;
  attribute: TRtfdAttribute;
  Operation: TRtfdOperation;
  Separator: TRtfdSeparator;
  Stereotype: TRtfdStereotype;

begin
  if not Visible then
    Exit;
  inherited;

  NeedW := cDefaultWidth;
  NeedH := 2 * BorderWidth + 2;

  if (Entity is TClass) and (Entity as TClass).isJUnitTestclass then
  begin
    Stereotype := TRtfdStereotype.Create(Self, nil, 'JUnit Testclass');
    Inc(NeedH, Stereotype.Height);
  end;

  // Height depends on choosed font

  aClassname := TRtfdClassName.Create(Self, Entity);
  ExtentX := aClassname.ExtentX;
  ExtentY := aClassname.ExtentY;
  TypeParameter := aClassname.TypeParameter;
  Inc(NeedH, aClassname.Height);

  // Get names in visibility order
  C := Entity as TClass;
  if FMinVisibility > Low(TVisibility) then
  begin
    Ami := TModelIterator.Create(C.GetAttributes, TAttribute, FMinVisibility,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(C.GetOperations, TOperation, FMinVisibility,
      TIteratorOrder(FSortOrder));
  end
  else
  begin
    Ami := TModelIterator.Create(C.GetAttributes, TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(C.GetOperations, TIteratorOrder(FSortOrder));
  end;

  // Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
  begin
    Separator := TRtfdSeparator.Create(Self);
    Inc(NeedH, Separator.Height);
  end;

  // Attributes
  while Ami.HasNext do
  begin
    attribute := TRtfdAttribute.Create(Self, Ami.Next);
    Inc(NeedH, attribute.Height);
  end;

  // Separator
  if ((Ami.Count > 0) and (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
  begin
    Separator := TRtfdSeparator.Create(Self);
    Inc(NeedH, Separator.Height);
  end;

  // Operations
  while Omi.HasNext do
  begin
    Operation := TRtfdOperation.Create(Self, Omi.Next);
    Inc(NeedH, Operation.Height);
  end;
  Height := NeedH + ShadowWidth;

  for i := 0 to ControlCount - 1 do
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      NeedW := Max(CustomLabel.TextWidth, NeedW);
    end;
  Width := Max(NeedW, cDefaultWidth);

  if aClassname.TypeParameter <> '' then
  begin
    if Width - ExtentX < Width div 4 then
    begin
      ExtentX := ExtentX + (Width div 4 - (Width - ExtentX));
      aClassname.ExtentX := ExtentX;
    end;
  end;

  aTop := 4;
  for i := 0 to ControlCount - 1 do
    if Controls[i] is TRtfdClassName then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width + ExtentX, CustomLabel.Height);
      aTop := aTop + CustomLabel.Height;
    end
    else if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width, CustomLabel.Height);
      aTop := aTop + CustomLabel.Height;
    end
    else if Controls[i] is TRtfdSeparator then
    begin
      Separator := TRtfdSeparator(Controls[i]);
      Separator.SetBounds(4, aTop, Width, Separator.Height);
      aTop := aTop + Separator.Height;
    end;

  Width := Width + ExtentX + ShadowWidth;
  Visible := True;

  // debugging
  // Application.ProcessMessages;
  // FMessages.OutputToTerminal('RtfdClass - ' + Self.Pathname);
  // FMessages.OutputToTerminal(Debug);
end;

function TRtfdClass.Debug: string;
var
  S: string;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
  R: TRect;
  i: Integer;
begin
  S := '';
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := Controls[i] as TRtfdCustomLabel;
      R := CustomLabel.BoundsRect;
      S := S + IntToStr(R.Left) + '-' + IntToStr(R.Top) + '-' +
        IntToStr(R.Width) + '-' + IntToStr(R.Height) + #13#10;
    end;
    if Controls[i] is TRtfdSeparator then
    begin
      Separator := Controls[i] as TRtfdSeparator;
      R := Separator.BoundsRect;
      S := S + IntToStr(R.Left) + '-' + IntToStr(R.Top) + '-' +
        IntToStr(R.Width) + '-' + IntToStr(R.Height) + #13#10;
    end;
  end;
  Result := S;
end;

{ TRtfdObject }

constructor TRtfdObject.Create(aOwner: TComponent; aEntity: TModelEntity;
  aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  Self.FShowStatic := False;
  PopupMenu := aFrame.PopMenuObject;
  aEntity.AddListener(IAfterObjektListener(Self));
  FSortOrder := GuiPyOptions.DiSortOrder;
  if GuiPyOptions.ObjectsWithoutVisibility then
    FShowIcons := 2
  else
    FShowIcons := GuiPyOptions.DiShowIcons;
  FMinVisibility := aMinVisibility;
  RefreshEntities;
end;

destructor TRtfdObject.Destroy;
begin
  Entity.RemoveListener(IAfterObjektListener(Self));
  // FreeAndNil(Entity); this is wrong
  inherited;
end;

procedure TRtfdObject.AddChild(Sender: TModelEntity; NewChild: TModelEntity);
begin
  RefreshEntities;
end;

function TRtfdObject.getClassname: string;
begin
  Result := (Entity as TObjekt).getTyp.Name;
end;

procedure TRtfdObject.RefreshEntities;
var
  NeedH, NeedW, i, aTop: Integer;
  O: TObjekt;
  C: TClass;
  Ami, Omi: IModelIterator;
  aModelEntity: TModelEntity;
  CustomLabel: TRtfdCustomLabel;
  attribute: TRtfdAttribute;
  Separator: TRtfdSeparator;
begin
  Locked := True;
  if not Visible then
    Exit;
  inherited;

  NeedW := 0;
  NeedH := 2 * BorderWidth + 2;
  Inc(NeedH, TRtfdObjectName.Create(Self, Entity).Height);

  // Get names in visibility order
  O := Entity as TObjekt;
  C := O.getTyp;
  if FMinVisibility > Low(TVisibility) then
  begin
    Ami := TModelIterator.Create(O.GetAttributes, TAttribute, FMinVisibility,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(C.GetOperations, TOperation, FMinVisibility,
      TIteratorOrder(FSortOrder));
  end
  else
  begin
    Ami := TModelIterator.Create(O.GetAttributes, TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(C.GetOperations, TIteratorOrder(FSortOrder));
  end;

  // Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  // Attributes
  while Ami.HasNext do
  begin
    aModelEntity := Ami.Next;
    if not aModelEntity.Static or FShowStatic then
    begin
      attribute := TRtfdAttribute.Create(Self, aModelEntity);
      Inc(NeedH, attribute.Height);
    end;
  end;

  if GuiPyOptions.ShowObjectsWithMethods then
  begin
    // Separator
    if (Ami.Count > 0) and (Omi.Count > 0) or GuiPyOptions.ShowEmptyRects then
      Inc(NeedH, TRtfdSeparator.Create(Self).Height);
    // Operations
    while Omi.HasNext do
      Inc(NeedH, TRtfdOperation.Create(Self, Omi.Next).Height);
  end;
  Height := NeedH + ShadowWidth;

  for i := 0 to ControlCount - 1 do
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      NeedW := Max(CustomLabel.TextWidth, NeedW);
    end;
  Width := Max(NeedW, cDefaultWidth);

  aTop := 4;
  for i := 0 to ControlCount - 1 do
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width, CustomLabel.Height);
      aTop := aTop + CustomLabel.Height;
    end
    else if Controls[i] is TRtfdSeparator then
    begin
      Separator := TRtfdSeparator(Controls[i]);
      Separator.SetBounds(4, aTop, Width, Separator.Height);
      aTop := aTop + Separator.Height;
    end;

  Width := Width + ShadowWidth;
  Locked := False;
  Visible := True;
end;

{ TRtfdComment }

type
  TMoveCracker = class(TControl);

constructor TRtfdCommentBox.Create(aOwner: TComponent; const S: string;
  aFrame: TAFrameDiagram; aMinVisibility: TVisibility; aHandleSize: Integer);
var
  E: TModelEntity;
begin
  E := TModelEntity.Create(nil);
  E.Name := S;
  inherited Create(aOwner, E, aFrame, aMinVisibility);
  Self.HandleSize := aHandleSize;
  TrMemo := TStyledMemo.Create(aOwner);
  TrMemo.Brush.color := GuiPyOptions.CommentColor;
  TrMemo.Parent := Self;
  TrMemo.BorderStyle := bsNone;
  TrMemo.ControlStyle := TrMemo.ControlStyle + [csOpaque];
  TrMemo.onEnter := OnCommentBoxEnter;
  Cursor := crCross;
  DoubleBuffered := False;
  PopupMenu := aFrame.PopupMenuComment;
end;

destructor TRtfdCommentBox.Destroy;
begin
  FreeAndNil(Entity);
  inherited;
end;

procedure TRtfdCommentBox.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
    FSelected := Value;
end;

procedure TRtfdCommentBox.OnCommentBoxEnter(Sender: TObject);
begin
  if Selected then
    Frame.Diagram.ClearSelection;
end;

procedure TRtfdCommentBox.RefreshEntities;
begin
  Invalidate;
end;

function TRtfdCommentBox.GetPathname: string;
begin
  Result := '';
end;

procedure TRtfdCommentBox.Paint;
const
  corner = 12;
var
  R, R1: TRect;
  i: Integer;
  sw: Integer;
  Points: array [0 .. 4] of TPoint;
begin
  ResizeMemo; // relevant
  sw := ShadowWidth;
  TrMemo.color := GuiPyOptions.CommentColor;
  TrMemo.Brush.color := GuiPyOptions.CommentColor;

  // debugging
  // FMessages.OutputToTerminal('Paint: CommentBox');

  with Canvas do
  begin
    Brush.color := BGColor;
    Pen.color := BGColor;
    R := MyGetClientRect;
    R.Inflate(-HandleSize, -HandleSize);
    FillRect(ClientRect);
    // shadow-colors
    R1 := Rect(R.Left + sw, R.Top + corner - 3 + sw, R.Right, R.Bottom);
    PaintShadow(False, sw, Canvas, R1);

    // background for Memo
    Pen.color := FGColor;
    Font.color := FGColor;
    Brush.color := GuiPyOptions.CommentColor;
    Points[0] := Point(R.Left, R.Top);
    Points[1] := Point(R.Right - sw - corner, R.Top);
    Points[2] := Point(R.Right - sw, R.Top + corner);
    Points[3] := Point(R.Right - sw, R.Bottom - sw);
    Points[4] := Point(R.Left, R.Bottom - sw);
    Polygon(Points);
    SVGComment := getSVGPolygon(Points,
      myColorToRGB(GuiPyOptions.CommentColor));

    MoveTo(R.Right - sw - corner, R.Top);
    LineTo(R.Right - sw - corner, R.Top + corner);
    LineTo(R.Right - sw, R.Top + corner);

    SVGComment := SVGComment + '  <path d="M ' +
      PointToVal(Point(R.Right - sw - corner, R.Top)) + 'L ' +
      PointToVal(Point(R.Right - sw - corner, R.Top + corner)) + 'L ' +
      PointToVal(Point(R.Right - sw, R.Top + corner)) + '"' +
      ' stroke="black" fill="' + myColorToRGB(GuiPyOptions.CommentColor) +
      '" />'#13#10;

    R := TrMemo.BoundsRect;
    SVGComment := SVGComment + getSVGText(TrMemo.Left,
      calcSVGBaseLine(R, Canvas.Font), '', TrMemo.Lines.text);

    if FSelected then
    begin
      Brush.color := FGColor;
      for i := 0 to 7 do
      begin
        R1 := panels[i];
        FillRect(R1);
      end;
    end;
    TrMemo.Invalidate;
  end;
end;

procedure TRtfdCommentBox.CommentMouseMove(PFrom, PTo: TPoint);
var
  nr, dx, dy, l, t, w, h: Integer;
  P1, P2: TPoint;
begin
  P1 := ScreenToClient(PFrom);
  P2 := ScreenToClient(PTo);
  dx := P2.X - P1.X;
  dy := P2.Y - P1.Y;
  nr := getPanelNr(P1);
  l := Left;
  t := Top;
  w := Width;
  h := Height;
  case nr of
    0:
      begin // upper left
        t := t + dy;
        h := h - dy;
        l := l + dx;
        w := w - dx;
      end;
    1:
      begin // upper middle
        t := t + dy;
        h := h - dy;
      end;
    2:
      begin // upper right
        t := t + dy;
        h := h - dy;
        w := w + dx;
      end;
    3:
      begin // bottom right
        w := w + dx;
        h := h + dy;
      end;
    4: // bottom middle
      h := h + dy;
    5:
      begin // bottom left
        l := l + dx;
        w := w - dx;
        h := h + dy;
      end;
    6:
      begin // left center
        l := l + dx;
        w := w - dx;
      end;
    7: // right center
      w := w + dx;
    8: // The component was clicked directly
      begin
        l := l + dx;
        t := t + dy;
      end;
  end;
  SetBounds(l, t, w, h);
end;

procedure TRtfdCommentBox.ResizeMemo;
var
  w2, h2, i: Integer;
  Rect: TRect;
  HandleSizeH: Integer;
begin
  HandleSizeH := HandleSize;
  TrMemo.Left := 2 * HandleSizeH;
  TrMemo.Top := 2 * HandleSizeH;
  TrMemo.Width := Self.Width - 4 * HandleSizeH - ShadowWidth - 5;
  TrMemo.Height := Self.Height - 4 * HandleSizeH - ShadowWidth;

  // Rect:= GetHandleClientRect;
  Rect := MyGetClientRect;
  Rect.Left := HandleSizeH;
  Rect.Top := HandleSizeH;
  Rect.Right := Rect.Right - HandleSizeH;
  Rect.Bottom := Rect.Bottom - HandleSizeH;

  w2 := (Rect.Right - Rect.Left) div 2;
  h2 := (Rect.Bottom - Rect.Top) div 2;

  panels[0].Left := Rect.Left - HandleSizeH;
  panels[0].Top := Rect.Top - HandleSizeH;
  panels[1].Left := Rect.Left + w2 - HandleSizeH;
  panels[1].Top := Rect.Top - HandleSizeH;
  panels[2].Left := Rect.Right - HandleSize;
  panels[2].Top := Rect.Top - HandleSizeH;
  panels[3].Left := Rect.Right - HandleSizeH;
  panels[3].Top := Rect.Bottom - HandleSizeH;
  panels[4].Left := Rect.Left + w2 - HandleSizeH;
  panels[4].Top := Rect.Bottom - HandleSizeH;
  panels[5].Left := Rect.Left - HandleSizeH;
  panels[5].Top := Rect.Bottom - HandleSizeH;
  panels[6].Left := Rect.Left - HandleSizeH;
  panels[6].Top := Rect.Top + h2 - HandleSizeH;
  panels[7].Left := Rect.Right - HandleSizeH;
  panels[7].Top := Rect.Top + h2 - HandleSizeH;
  for i := 0 to 7 do
  begin
    panels[i].Right := panels[i].Left + 2 * HandleSizeH;
    panels[i].Bottom := panels[i].Top + 2 * HandleSizeH;
  end;
end;

function TRtfdCommentBox.getPanelRect(i: Integer): TRect;
begin
  Result := Rect(panels[i].Left, panels[i].Top,
    panels[i].Left + panels[i].Width, panels[i].Top + panels[i].Height);
end;

function TRtfdCommentBox.getPanelNr(P: TPoint): Integer;
begin
  var
  i := 0;
  while (i < 8) and not ptInRect(getPanelRect(i), P) do
    Inc(i);
  Result := i;
end;

{ TRtfdUnitPackage }

constructor TRtfdUnitPackage.Create(aOwner: TComponent; aEntity: TModelEntity;
  aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  P := aEntity as TUnitPackage;
  RefreshEntities;
end;

procedure TRtfdUnitPackage.RefreshEntities;
begin
  DestroyComponents;
  TRtfdUnitPackageName.Create(Self, P);
  Height := 45;
end;

{ TVisibilityLabel }

procedure TVisibilityLabel.Paint;
var
  R: TRect;
  S: string;
  PictureNr, Distance: Integer;
  Style: TFontStyles;
  vil: TVirtualImageList;
begin
  // for debugging
  // Canvas.Brush.Color:= clRed;
  // Canvas.FillRect(ClientRect);
  SetColors;
  R := ClientRect;
  if Entity is TAttribute then
    PictureNr := Integer(Entity.Visibility)
  else
    PictureNr := Integer(Entity.Visibility) + 3;
  if not GuiPyOptions.ConstructorWithVisibility and (Entity is TOperation) and
    ((Entity as TOperation).OperationType = otConstructor) then
    PictureNr := 6;
  Font.color := FGColor;
  Canvas.Brush.color := BGColor;
  Canvas.Font.assign(Font);
  if Entity.Static then
    Canvas.Font.Style := [fsUnderline];
  if GuiPyOptions.RelationshipAttributesBold and (Entity is TAttribute) and
    (Entity as TAttribute).Connected then
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];

  case (Owner as TRtfdBox).ShowIcons of
    0:begin
        if StyleServices.IsSystemStyle
          then vil:= (Owner as TRtfdBox).Frame.vilUMLRtfdComponentsLight
          else vil:= (Owner as TRtfdBox).Frame.vilUMLRtfdComponentsDark;
        vil.SetSize(r.Height, r.Height);
        vil.Draw(Canvas, 4, 0, PictureNr);
        R.Left := R.Left + PPIScale(vil.Width + 8);
        Canvas.TextOut(R.Left, R.Top, Caption);
      end;
    1:begin
        Style := Canvas.Font.Style;
        Canvas.Font.Style := [];
        case Entity.Visibility of
          viPrivate:   S := '- ';
          viProtected: S := '# ';
          viPublic:    S := '+ ';
        end;
        if PictureNr = 6 then
          S := 'c ';
        Canvas.Font.Pitch := fpFixed;
        Canvas.TextOut(R.Left + 4, R.Top, S);
        Distance := Canvas.TextWidth('+ ');
        Canvas.Font.Style := Style;
        Canvas.TextOut(R.Left + 4 + Distance, R.Top, Caption);
      end;
    2:Canvas.TextOut(R.Left + 4, R.Top, Caption);
  end;
end;

function TVisibilityLabel.getSVG(OwnerRect: TRect): string;
var
  PictureNr: Integer;
  S, fontstyle, Icon, attribute, span: string;
  C: char;
  bx, by: real;

begin
  fontstyle := '';
  if GuiPyOptions.RelationshipAttributesBold and (Entity is TAttribute) and
    (Entity as TAttribute).Connected then
    fontstyle := fontstyle + ' font-weight="bold"';
  if Entity.Static then
    fontstyle := fontstyle + ' text-decoration="underline"';
  if Entity.IsAbstract then
    fontstyle := fontstyle + ' font-style="italic"';

  // R:= ClientRect;
  if (Entity is TAttribute) then
    PictureNr := Integer(Entity.Visibility)
  else
    PictureNr := Integer(Entity.Visibility) + 3;
  if not GuiPyOptions.ConstructorWithVisibility and (Entity is TOperation) and
    ((Entity as TOperation).OperationType = otConstructor) then
    PictureNr:= 3;
  case (Owner as TRtfdBox).ShowIcons of
    0:
      begin
        if (Entity is TAttribute) then
          Icon := getSVGRect(Left, Top + (Height - Font.Size) / 2, Font.Size,
            Font.Size, 'none')
        else
          Icon := getSVGCircle(Left + Font.Size / 2, Top + Height / 2,
            Font.Size / 2);

        C := ' ';
        case Entity.Visibility of
          viPrivate:
            C := '-';
          viProtected:
            C := '#';
          viPublic:
            C := '+';
        end;
        if PictureNr = 6 then
          C := 'c';

        bx := Left;
        // Canvas.TextOut starts output at left/top
        // SVG start output at left/baseline of text
        by := Top + Round(0.65 * Height);
        case C of
          'c':
            begin
              bx := bx + 1.5;
              by := by + 0.5
            end;
          '~':
            begin
              bx := bx + 0.5;
              by := by + 1.5
            end;
          '#':
            begin
              bx := bx + 2.1;
              by := by + 1.3
            end; // 2,5   1.0
          '+':
            begin
              bx := bx + 0.5;
              by := by + 1.3
            end;
          '-':
            begin
              bx := bx + 1.9;
              by := by + 1.5
            end;
        end;
        case C of
          '#':
            attribute := ' font-size=' + FloatToVal(Font.Size);
          '-':
            attribute := ' font-size=' + FloatToVal(Font.Size * 1.5);
        else
          attribute := '';
        end;
        Icon := Icon + getSVGText(bx, by, attribute, C);
        Result := Icon + getSVGText(Left + Font.Size + 4,
          Top + Round(0.65 * Height) + 1, fontstyle, text);
      end;
    1:
      begin
        bx := Left;
        by := Top + Round(0.65 * Height) + 1;
        case Entity.Visibility of
          viPrivate:
            begin
              S := '-';
              bx := Left + 1
            end;
          viProtected:
            S := '#';
          viPublic:
            S := '+';
        end;
        if PictureNr = 6 then
          S := 'c';

        Result := getSVGText(bx, by, '', S);
        span := '<tspan x=' + IntToVal(Left + Font.Size + 4) + fontstyle + '>' +
          ConvertLtGt(text) + '</tspan>';
        insert(span, Result, Pos('>' + S, Result) + 2);
      end;
    2:
      Result := getSVGText(Left, Top + Round(0.65 * Height) + 1,
        fontstyle, text);
  end;

  // if GuiPyOptions.UseAbstract and Entity.IsAbstract then
  // Result:= Result + getSVGText(OwnerRect.Width-8 - ShadowWidth, Top + Round(0.65*Height) + 1,
  // ' font-style="italic" text-anchor="end"', '{abstract}');'
end;

{ TRtfdClassName }

constructor TRtfdClassName.Create(aOwner: TComponent; aEntity: TModelEntity);
var
  DC: THandle;
  S, TypeBinding: string;
begin
  inherited Create(aOwner, aEntity);

  if aEntity.IsAbstract then
    Font.Style := [fsBold, fsItalic]
  else
    Font.Style := [fsBold];
  Alignment := taCenter;
  aEntity.AddListener(IAfterClassListener(Self));
  Caption := aEntity.Name;
  SingleLineHeight := Height;

  S := getShortTypeWith(aEntity.Name);
  TypeParameter := GenericOf(S); // class<Parameter>
  if (TypeParameter <> '') and GuiPyOptions.ShowClassparameterSeparately then
  begin // parameterized class
    TypeBinding := (aOwner as TRtfdClass).FTypeBinding;
    if TypeBinding = '' then
      TypeAndBinding := TypeParameter
    else
      TypeAndBinding := TypeParameter + ': ' + TypeBinding;
    DC := GetDC(0);
    Canvas.Handle := DC;
    Canvas.Font := Font;
    Canvas.Font.Style := [];
    FTextWidthParameter := Canvas.TextWidth(TypeAndBinding) + 8;
    FExtentX := FTextWidthParameter div 2;
    FExtentY := abs(Font.Height);
    Caption := WithoutGeneric(S);
    Canvas.Font.Style := [fsBold];
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
  end
  else
  begin
    FTextWidthParameter := 0;
    FExtentX := 0;
    FExtentY := 0;
    EntityChange(nil);
  end;
  Height := Height + 2 * FExtentY;
end;

destructor TRtfdClassName.Destroy;
begin
  Entity.RemoveListener(IAfterClassListener(Self));
  inherited;
end;

procedure TRtfdClassName.EntityChange(Sender: TModelEntity);
var
  S: string;
begin
  if ((Owner as TRtfdBox).Frame as TAFrameDiagram).Diagram.Package <> Entity.Owner
  then
    S := Entity.FullName
  else
    S := Entity.Name;
  Caption := S;
end;

procedure TRtfdClassName.Paint;
var
  R: TRect;
  S: string;
  P, NeedH: Integer;
  HeadColor: TColor;

  function isDark(color: TColor): Boolean;
  begin
    Result := (Max(GetRValue(color), Max(GetGValue(color), getBValue(color)
      )) <= 128);
  end;

begin
  if TypeAndBinding <> '' then
  begin
    Canvas.Font.Assign(Font);
    SetColors;
    // draw classname
    if FTransparent then
      Canvas.Brush.Style := bsClear
    else
      Canvas.Brush.Style := bsSolid;
    if Entity.IsAbstract then
      Canvas.Font.Style := [fsBold, fsItalic]
    else
      Canvas.Font.Style := [fsBold];

    HeadColor := (Owner as TRtfdBox).Canvas.Brush.color;
    if isDark(HeadColor) and isDark(FGColor) then
      Canvas.Font.color := FGColor
    else if not isDark(HeadColor) and not isDark(FGColor) then
      Canvas.Font.color := BGColor;

    R := ClientRect;
    R.Top := R.Top + 2 * FExtentY;
    R.Right := R.Right - FExtentX - GuiPyOptions.ShadowWidth;
    P := Pos(#13#10'{abstract}', Caption);
    if P > 0 then
      S := Copy(Caption, 1, P - 1)
    else
      S := Caption;
    if GuiPyOptions.ClassnameInUppercase then
      S := UpperCase(S);
    DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_CENTER);
    if P > 0 then
    begin
      Canvas.Font.Style := [fsItalic];
      R.Top := R.Top + SingleLineHeight;
      S := '{abstract}';
      DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_CENTER);
    end;

    // draw parameter
    SetColors;
    Canvas.Font.Style := [];
    Canvas.Brush.Style := bsSolid;
    Canvas.Pen.Style := psDash;
    Canvas.Pen.color := FGColor;
    R := Parent.ClientRect;
    NeedH := Round(Height * 0.6);
    Canvas.Brush.color := BGColor;
    Canvas.Rectangle(R.Right - TextWidthParameter - 12, 0, R.Right - 8, NeedH);
    R := Rect(R.Right - TextWidthParameter - 14, (NeedH - ExtentY) div 2 - 2,
      R.Right - 6, NeedH);
    DrawText(Canvas.Handle, PChar(TypeAndBinding), Length(TypeAndBinding), R,
      DT_CENTER);
  end
  else
    inherited;
end;

function TRtfdClassName.getSVG(OwnerRect: TRect): string;
var
  X, Y, P: Integer;
  S, attribute: string;
begin
  attribute := ' font-weight="bold" text-anchor="middle"';
  if Entity.IsAbstract then
    attribute := attribute + ' font-style="italic"';
  X := OwnerRect.Width div 2;
  Y := Top + 2 * FExtentY + Round(0.65 * SingleLineHeight) + 1;
  P := Pos(#13#10'{abstract}', Caption);
  if P > 0 then
    S := Copy(Caption, 1, P - 1)
  else
    S := Caption;
  Result := getSVGText(X, Y, attribute, S);
  if P > 0 then
  begin
    attribute := ' text-anchor="middle" font-style="italic"';
    Y := Y + SingleLineHeight;
    Result := Result + getSVGText(X, Y, attribute, '{abstract}');
  end;
end;

function TRtfdClassName.getSVGTypeAndBinding(R: TRect): string;
begin
  R := Parent.ClientRect;
  R.Right := R.Right - GuiPyOptions.ShadowWidth - 4;
  var
  S := getSVGRect(R.Right - 2 * FExtentX, 0, 2 * FExtentX, 2 * FExtentY,
    'white', ' stroke-dasharray="1.5% 0.5%"');
  Result := S + getSVGText(R.Right - 2 * FExtentX + 6,
    Round(2 * FExtentY * 0.7), '', TypeAndBinding);
end;

{ TRtfdObjectName }

constructor TRtfdObjectName.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  if GuiPyOptions.ObjectUnderline then
    Font.Style := [fsBold, fsUnderline]
  else
    Font.Style := [fsBold];
  Alignment := taCenter;
  aEntity.AddListener(IAfterObjektListener(Self));
  EntityChange(nil);
end;

destructor TRtfdObjectName.Destroy;
begin
  Entity.RemoveListener(IAfterObjektListener(Self));
  inherited;
end;

procedure TRtfdObjectName.EntityChange(Sender: TModelEntity);
begin
  var
  classname := (Entity as TObjekt).GenericName;
  if GuiPyOptions.ClassnameInUppercase then
    classname := UpperCase(classname);
  case GuiPyOptions.ObjectCaption of
    0:
      Caption := Entity.Name + ': ' + classname;
    1:
      Caption := Entity.FullName;
  else
    Caption := ': ' + classname;
  end;
end;

procedure TRtfdObjectName.Paint;
var
  Alig: Integer;
  R: TRect;
  HeadColor: TColor;

  function isDark(color: TColor): Boolean;
  begin
    var
    V := Max(GetRValue(color), Max(GetGValue(color), getBValue(color)));
    Result := (V <= 128);
  end;

begin
  SetColors;
  if FTransparent then
    Canvas.Brush.Style := bsClear
  else
    Canvas.Brush.Style := bsSolid;
  Alig := DT_LEFT;
  case FAlignment of
    taLeftJustify:
      Alig := DT_LEFT;
    taRightJustify:
      Alig := DT_RIGHT;
    taCenter:
      Alig := DT_CENTER;
  end;

  HeadColor := (Owner as TRtfdBox).Canvas.Brush.color;
  if isDark(HeadColor) and isDark(FGColor) then
    Canvas.Font.color := FGColor
  else if not isDark(HeadColor) and not isDark(FGColor) then
    Canvas.Font.color := BGColor;

  R := ClientRect;
  R.Right := R.Right - GuiPyOptions.ShadowWidth;
  DrawText(Canvas.Handle, PChar(Caption), Length(Caption), R, Alig);
end;

function TRtfdObjectName.getSVG(OwnerRect: TRect): string;
var
  X: Integer;
  attribute: string;
begin
  attribute := ' font-weight="bold" text-anchor="middle"';
  if fsUnderline in Font.Style then
    attribute := attribute + ' text-decoration="underline"';
  X := OwnerRect.Width div 2;
  Result := getSVGText(X, Top + Height - 4, attribute, text);
end;

{ TRtfdInterfaceName }

constructor TRtfdInterfaceName.Create(aOwner: TComponent;
  aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  Font.Style := [fsBold];
  Alignment := taCenter;
  aEntity.AddListener(IAfterInterfaceListener(Self));
  Caption := aEntity.Name;
  SingleLineHeight := Height;
  EntityChange(nil);
end;

destructor TRtfdInterfaceName.Destroy;
begin
  Entity.RemoveListener(IAfterInterfaceListener(Self));
  inherited;
end;

procedure TRtfdInterfaceName.EntityChange(Sender: TModelEntity);
begin
  if ((Owner as TRtfdBox).Frame as TAFrameDiagram).Diagram.Package <> Entity.Owner
  then
    Caption := Entity.FullName
  else
    Caption := Entity.Name;
end;

function TRtfdInterfaceName.getSVG(OwnerRect: TRect): string;
var
  X, Y: Integer;
  attribute: string;
begin
  attribute := ' text-anchor="middle"';
  X := OwnerRect.Width div 2;
  Y := Top + Round(0.65 * SingleLineHeight) + 1 - SingleLineHeight;
  Result := getSVGText(X, Y, attribute, '<<interface>>');
  attribute := ' font-weight="bold" text-anchor="middle"';
  Y := Y + SingleLineHeight;
  Result := Result + getSVGText(X, Y, attribute, text);
end;

{ TRtfdSeparator }

constructor TRtfdSeparator.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Parent := aOwner as TWinControl;
  AutoSize := False;
  Height := 7;
end;

procedure TRtfdSeparator.Paint;
begin
  // both variants, so that it also works when copying

  // old painitng
  // appears in the display and in the copy
  // but lines are too short
  { R:= ClientRect;
    Canvas.brush.Color:= clGreen;
    Canvas.FillRect(R);
    Canvas.Pen.Color:= clBlue;  // clBlack;
    Canvas.MoveTo(R.Left, R.Top + (Height div 2));
    Canvas.LineTo(R.Right, R.Top + (Height div 2)); }

  // neu Röhner
  // erscheint nur in der Anzeige, nicht in der Kopie

  { ox:= (Owner as TRtfdBox);
    Box.Canvas.Pen.Color:= clRed;  // clBlack;
    Box.Canvas.Brush.Color:= clGreen; // clWhite
    Box.Canvas.FillRect(Rect(1, Top, Box.Width-4, Top + Height));
    Box.Canvas.MoveTo(1, Top + (Height div 2));
    Box.Canvas.LineTo(Box.Width-4, Top + (Height div 2));
  }
end;

function TRtfdSeparator.getSVG(OwnerRect: TRect): string;
begin
  Result := '  <line x1="0" y1="' + IntToStr(Top + Height div 2) + '" x2="' +
    IntToStr(OwnerRect.Width) + '" y2="' + IntToStr(Top + Height div 2) +
    '" stroke="black" />'#13#10;
end;

{ TRtfdPackageName }

constructor TRtfdUnitPackageName.Create(aOwner: TComponent;
  aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  Font.Style := [fsBold];
  Alignment := taCenter;
  P := aEntity as TUnitPackage;
  P.AddListener(IAfterUnitPackageListener(Self));
  EntityChange(nil);
end;

destructor TRtfdUnitPackageName.Destroy;
begin
  P.RemoveListener(IAfterUnitPackageListener(Self));
  inherited;
end;

procedure TRtfdUnitPackageName.EntityChange(Sender: TModelEntity);
begin
  Caption := P.Name;
end;

{ TRtfdOperation }

constructor TRtfdOperation.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  O := aEntity as TOperation;
  O.AddListener(IAfterOperationListener(Self));
  EntityChange(nil);
  // ParentFont:= true;  due to abstract operations not possible
end;

destructor TRtfdOperation.Destroy;
begin
  O.RemoveListener(IAfterOperationListener(Self));
  inherited;
end;

// show operation, show method
procedure TRtfdOperation.EntityChange(Sender: TModelEntity);
const
  ColorMap: array [TOperationType] of TColor = (clGreen, clBlack,
    clGray, clred);
  // otConstructor, otProcedure, otFunction, otDestructor,);
var
  S: string;
  it: IModelIterator;
  Parameter: TParameter;
  ParameterCount: Integer;
  ShowParameter: Integer;
begin
  // Default uml-syntax
  // visibility name ( parameter-list ) : return-type-expression { property-string }
  ParameterCount := 0;
  ShowParameter := (Owner as TRtfdBox).ShowParameter;
  S := O.Name;

  if ShowParameter > 1 then
  begin
    S := S + '(';
    it := O.GetParameters;
    while it.HasNext do
    begin
      Parameter := it.Next as TParameter;
      if Parameter.Name = 'self' then
        Continue;
      case ShowParameter of
        2:
          Inc(ParameterCount);
        3:
          S := S + Parameter.asUMLString(3) + ', ';
        4:
          S := S + Parameter.asUMLString(4) + ', ';
        5:
          S := S + Parameter.asUMLString(5) + ', ';
        6:
          S := S + Parameter.asUMLString(6) + ', ';
      end
    end;
    if (ShowParameter = 2) and (ParameterCount > 0) then
      S := S + '...';
    if Copy(S, Length(S) - 1, 2) = ', ' then
      Delete(S, Length(S) - 1, 2); // delete last comma
    S := S + ')';
  end;

  if (ShowParameter > 0) and (O.OperationType = otFunction) then
  begin
    S := S + ':';
    if Assigned(O.ReturnValue) then
      S := S + ' ' + O.ReturnValue.asUMLType;
  end;
  Caption := S;
  Font.Style := [];
  // Font.Color:= ColorMap[O.OperationType];
  Font.color := FGColor;
  if O.IsAbstract then
    Font.Style := [fsItalic];
end;

{ TRtfdAttribute }

constructor TRtfdAttribute.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  A := aEntity as TAttribute;
  A.AddListener(IAfterAttributeListener(Self));
  EntityChange(aEntity);
end;

destructor TRtfdAttribute.Destroy;
begin
  A.RemoveListener(IAfterAttributeListener(Self));
  inherited;
end;

procedure TRtfdAttribute.EntityChange(Sender: TModelEntity);
var
  S: string;
begin
  // uml standard syntax is:
  // visibility name [ multiplicity ] : type-expression = initial-value { property-string }
  if Sender.Owner is TObjekt then
    Caption := A.Name + ' = ' + A.Value
  else if Assigned(A.TypeClassifier) then
  begin
    S := A.Name;
    if Assigned(A.TypeClassifier) and ((Owner as TRtfdBox).ShowParameter >= 4)
    then
      S := S + ': ' + A.TypeClassifier.asUMLType;
    if (A.Value <> '') and ((Owner as TRtfdBox).ShowParameter >= 5) then
      S := S + ' = ' + A.Value;
    Caption := S;
  end
  else
    Caption := A.Name;
end;

{ TRtfdUnitPackageDiagram }

constructor TRtfdUnitPackageDiagram.Create(aOwner: TComponent;
  aEntity: TModelEntity);
begin
  // This class is the caption in upper left corner for a unitdiagram
  inherited Create(aOwner, aEntity);
  color := clBtnFace;
  Font.Name := 'Times New Roman';
  Font.Style := [fsBold];
  Font.Size := 12;
  Alignment := taLeftJustify;
  P := aEntity as TUnitPackage;
  P.AddListener(IAfterUnitPackageListener(Self));
  EntityChange(nil);
end;

destructor TRtfdUnitPackageDiagram.Destroy;
begin
  P.RemoveListener(IAfterUnitPackageListener(Self));
  inherited;
end;

procedure TRtfdUnitPackageDiagram.EntityChange(Sender: TModelEntity);
begin
  Caption := '   ' + P.FullName;
end;

{ TRtfdInterface }

constructor TRtfdInterface.Create(aOwner: TComponent; aEntity: TModelEntity;
  aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  Pathname := (aEntity as TInterface).Pathname;
  aEntity.AddListener(IAfterInterfaceListener(Self));
  PopupMenu := aFrame.PopMenuClass;
  RefreshEntities;
end;

destructor TRtfdInterface.Destroy;
begin
  Entity.RemoveListener(IAfterInterfaceListener(Self));
  inherited;
end;

procedure TRtfdInterface.RefreshEntities;
var
  NeedW, NeedH, i, aTop: Integer;
  Omi, Ami: IModelIterator;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
  Int: TInterface;
begin
  if not Visible then
    Exit;
  inherited;

  NeedW := 0;
  NeedH := 2 * BorderWidth + 2;

  Inc(NeedH, TRtfdStereotype.Create(Self, nil, 'interface').Height);
  Inc(NeedH, TRtfdInterfaceName.Create(Self, Entity).Height);

  // Get names in visibility order
  Int := Entity as TInterface;
  if FMinVisibility > Low(TVisibility) then
  begin
    Ami := TModelIterator.Create(Int.GetAttributes, TAttribute, FMinVisibility,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(Int.GetOperations, TOperation, FMinVisibility,
      TIteratorOrder(FSortOrder));
  end
  else
  begin
    Ami := TModelIterator.Create(Int.GetAttributes, TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(Int.GetOperations, TIteratorOrder(FSortOrder));
  end;

  // Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  // Attributes
  while Ami.HasNext do
    Inc(NeedH, TRtfdAttribute.Create(Self, Ami.Next).Height);

  // Separator
  if ((Ami.Count > 0) and (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  // Operations
  while Omi.HasNext do
    Inc(NeedH, TRtfdOperation.Create(Self, Omi.Next).Height);
  Height := NeedH + ShadowWidth;

  for i := 0 to ControlCount - 1 do
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      NeedW := Max(CustomLabel.TextWidth, NeedW);
    end;
  Width := Max(NeedW, cDefaultWidth);

  aTop := 4;
  for i := 0 to ControlCount - 1 do
    if Controls[i] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width, CustomLabel.Height);
      aTop := aTop + CustomLabel.Height;
    end
    else if Controls[i] is TRtfdSeparator then
    begin
      Separator := TRtfdSeparator(Controls[i]);
      Separator.SetBounds(4, aTop, Width, Separator.Height);
      aTop := aTop + Separator.Height;
    end;

  Width := Width + ShadowWidth;
  Visible := True;
end;

procedure TRtfdInterface.AddChild(Sender, NewChild: TModelEntity);
begin
  RefreshEntities;
end;

function TRtfdInterface.GetPathname: string;
begin
  Result := Pathname;
end;

{ TRtfdStereotype }

constructor TRtfdStereotype.Create(aOwner: TComponent; aEntity: TModelEntity;
  const aCaption: string);
begin
  inherited Create(aOwner, aEntity);
  Alignment := taCenter;
  Self.Caption := '<<' + aCaption + '>>';
end;

{ TRtfdCustomLabel }

constructor TRtfdCustomLabel.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner);
  Parent := aOwner as TWinControl;
  Canvas.Font.assign(Font);
  Self.Entity := aEntity;
  Height := abs(Font.Height);
  FAlignment := taLeftJustify;
  FTransparent := True;
end;

procedure TRtfdCustomLabel.EntityChange(Sender: TModelEntity);
begin
  // Stub
end;

procedure TRtfdCustomLabel.Remove(Sender: TModelEntity);
begin
  // Stub
end;

procedure TRtfdCustomLabel.AddChild(Sender, NewChild: TModelEntity);
begin
  // Stub
end;

procedure TRtfdCustomLabel.Change(Sender: TModelEntity);
begin
  // Stub
end;

function TRtfdCustomLabel.GetAlignment: TAlignment;
begin
  Result := FAlignment;
end;

procedure TRtfdCustomLabel.SetAlignment(const Value: TAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TRtfdCustomLabel.Paint;
var
  Alig, P: Integer;
  R: TRect;
  S: string;
begin
  Canvas.Font.Assign(Font);
  SetColors;
  if FTransparent then
    Canvas.Brush.Style := bsClear
  else
    Canvas.Brush.Style := bsSolid;
  Alig := DT_LEFT;
  case FAlignment of
    taLeftJustify:
      Alig := DT_LEFT;
    taRightJustify:
      Alig := DT_RIGHT;
    taCenter:
      Alig := DT_CENTER;
  end;
  R := ClientRect;
  P := Pos(#13#10'{abstract}', Caption);
  if P > 0 then
  begin
    S := Copy(Caption, 1, P - 1);
    Canvas.Font.Style := [fsItalic, fsBold];
  end
  else
    S := Caption;
  if GuiPyOptions.ClassnameInUppercase then
    S := UpperCase(S);
  DrawText(Canvas.Handle, PChar(S), Length(S), R, Alig);
  if P > 0 then
  begin
    Canvas.Font.Style := [fsItalic];
    R.Top := R.Top + SingleLineHeight;
    S := '{abstract}';
    DrawText(Canvas.Handle, PChar(S), Length(S), R, Alig);
  end;
end;

function TRtfdCustomLabel.getSVG(OwnerRect: TRect): string;
begin
  Result := '';
end;

procedure TRtfdCustomLabel.SetColors;
begin
  FGColor := (Parent as TRtfdBox).FGColor;
  BGColor := (Parent as TRtfdBox).BGColor;
  Canvas.Font.color := FGColor;
end;

procedure TRtfdCustomLabel.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Invalidate;
  end;
end;

procedure TRtfdCustomLabel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  AdjustBounds;
end;

procedure TRtfdCustomLabel.AdjustBounds;
var
  DC: HDC;
  X: Integer;
  S: string;
  aRect: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) then begin
    aRect := Rect(0, 0, 0, 0);
    DC := GetDC(0);
    Canvas.Handle := DC;
    Canvas.Font.assign(Font);
    if GuiPyOptions.RelationshipAttributesBold and (Entity is TAttribute) then
      if (Entity as TAttribute).Connected then
        Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    if (Entity is TOperation) and Entity.IsAbstract then
      Canvas.Font.Style := Canvas.Font.Style + [fsItalic];
    S := Caption;
    if (Self is TRtfdClassName) and GuiPyOptions.ClassnameInUppercase then
      S := UpperCase(S);
    DrawText(Canvas.Handle, PChar(S), Length(S), aRect, DT_CALCRECT);
    FTextWidth := 8 + aRect.Right + 8;
    case (Owner as TRtfdBox).ShowIcons of
      0: FTextWidth := FTextWidth + PPIScale(aRect.Height + 8);
      1: FTextWidth := FTextWidth + Canvas.TextWidth('+ ');
      2: FTextWidth := FTextWidth + 0;
    end;
    DoDrawText(aRect, DT_EXPANDTABS or DT_CALCRECT);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then
      ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then
      Inc(X, Width - aRect.Right);
    SetBounds(X, Top, FTextWidth, aRect.Bottom);
  end;
end;

procedure TRtfdCustomLabel.DoDrawText(var Rect: TRect; Flags: Longint);
begin
  var aText:= Caption;
  if aText = '' then
    aText:= '  ';
  if (Flags and DT_CALCRECT <> 0) and ((aText = '') and (aText[1] = '&') and
    (aText[2] = #0)) then
    aText := aText + ' ';
  Flags:= Flags or DT_NOPREFIX;
  Flags:= DrawTextBiDiModeFlags(Flags);
  Canvas.Font.assign(Font);
  if not Enabled then begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(text), Length(aText), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.color:= clBtnShadow;
    DrawText(Canvas.Handle, PChar(aText), Length(aText), Rect, Flags);
  end else
    DrawText(Canvas.Handle, PChar(aText), Length(aText), Rect, Flags);
end;

end.
