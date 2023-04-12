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
  //Baseclass for a diagram-panel
  TRtfdBoxClass = class of TRtfdBox;

  TRtfdBox = class(TPanelTransparent, IModelEntityListener)
  private
    FMinVisibility : TVisibility;
    FShowParameter: integer;
    FSortOrder: integer;
    FShowIcons: integer;
    FShowStatic: boolean;
    FShowInherited: boolean;
    FShowView: integer;
    FExtentX: integer;
    FExtentY: integer;
    FShadowWidth: integer;
    FTypeBinding: string;
    FSelected: boolean;
    FTypeParameter: string;
    FLocked: boolean;
    FETypeBinding: TEdit;
    FBGColor: TColor;
    FFGColor: TColor;
    FBitmap: TBitmap;
    FBitmapOK: boolean;
    SVGHead: string;
    SVGComment: string;
    procedure SetMinVisibility(const Value: TVisibility);
    procedure SetShowParameter(const Value: integer);
    procedure SetSortOrder(const Value: integer);
    procedure SetShowIcons(const Value: integer);
    procedure SetShowView(const Value: integer);
    procedure SetSelected(const Value: boolean); virtual;
    procedure SetTypeBinding(const Value: string);
    procedure SetShadowWidth(const Value: integer);
    procedure OnChildMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure OnChildMouseDblClick(Sender: TObject);
    procedure OnEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure Notification(AComponent: TComponent; Operation: Classes.TOperation); override;
  public
    Frame: TAFrameDiagram;
    Entity: TModelEntity;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; MinVisibility: TVisibility); reintroduce; virtual;
    destructor Destroy; override;
    procedure PaintShadow(rounded: boolean; sw: integer; C: TCanvas; R: TRect);
    procedure RefreshEntities; virtual;
    function GetPathname: string; virtual; abstract;
    function GetBoundsRect: TRect; virtual;
    function MyGetClientRect: TRect;
    procedure Paint; override;
    procedure Change(Sender: TModelEntity); virtual;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); virtual;
    procedure Remove(Sender: TModelEntity); virtual;
    procedure EntityChange(Sender: TModelEntity); virtual;
    procedure SetParameters(ShowParameter, SortOrder, ShowIcons, FontSize: integer;
                const Fontname: string; aFont: TFont; const TypeBinding: string);
    function isJUnitTestclass: boolean;
    procedure CloseEdit;
    procedure Lock(b: Boolean);
    procedure makeBitmap;
    procedure ChangeStyle(BlackAndWhite: boolean = false);
    function getSVG: string; virtual;
    function getTopH: integer;

    property MinVisibility : TVisibility read FMinVisibility write SetMinVisibility;
    property ShowParameter: integer read FShowParameter write SetShowParameter;
    property SortOrder: integer read FSortOrder write SetSortOrder;
    property ShowIcons: integer read FShowIcons write SetShowIcons;
    property ShowView: integer read FShowView write setShowView;
    property ShowInherited: boolean read FShowInherited write FShowInherited;
    property ExtentX: integer read FExtentX write FExtentX;
    property ExtentY: integer read FExtentY write FExtentY;
    property Selected: boolean read FSelected write SetSelected;
    property ShadowWidth: integer read FShadowWidth write SetShadowWidth;
    property TypeParameter: String read FTypeParameter write FTypeParameter;
    property TypeBinding: String read FTypeBinding write SetTypeBinding;
    property FGColor: TColor read FFGColor write FFGColor;
    property BGColor: TColor read FBGColor write FBGColor;
  end;

  TRtfdClass = class(TRtfdBox, IAfterClassListener)
  private
    Pathname: string;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetPathname: string; override;
    function Debug: String;
  end;

  TRtfdObject = class(TRtfdBox, IAfterObjektListener)
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function getClassname: string;
  end;

  TRtfdInterface = class(TRtfdBox, IAfterInterfaceListener)
  private
    Pathname: string;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetPathname: string; override;
  end;

  TRtfdCommentBox = class(TRtfdBox)
  private
    HandleSize: integer;
    panels: array[0..7] of TRect;
    procedure SetSelected(const Value: boolean); override;
    function getPanelRect(i: integer): TRect;
    function getPanelNr(P: TPoint): integer;
  public
    TrMemo: TStyledMemo;
    constructor Create(aOwner: TComponent; const S: String; aFrame: TAFrameDiagram;
                       aMinVisibility: TVisibility; aHandleSize: integer); reintroduce;
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
    constructor Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility); override;
    procedure RefreshEntities; override;
  end;

{--- RtfdCustomLabel and descentants ------------------------------------------}

  TRtfdCustomLabel = class(TGraphicControl, IModelEntityListener)
  private
    FAlignment: TAlignment;
    FTransparent: Boolean;
    Entity: TModelEntity;
    FTextWidth: integer;
    FGColor: TColor;
    BGColor: TColor;
    SingleLineHeight: integer;
    function GetAlignment: TAlignment;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetTransparent(const Value: Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure AdjustBounds;
    procedure DoDrawText(var Rect: TRect; Flags: Integer);
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); reintroduce; virtual;
    procedure Paint; override;
    procedure Change(Sender: TModelEntity); virtual;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); virtual;
    procedure Remove(Sender: TModelEntity); virtual;
    procedure EntityChange(Sender: TModelEntity); virtual;
    procedure SetColors;
    function getSVG(OwnerRect: TRect): string; virtual;
    property Alignment: TAlignment read GetAlignment write SetAlignment default taLeftJustify;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property TextWidth: integer read FTextWidth;
  end;

  TRtfdClassName = class(TRtfdCustomLabel, IAfterClassListener)
  private
    FTextWidthParameter: integer;
    FExtentX: integer;
    FExtentY: integer;
    TypeParameter: String;
    TypeAndBinding: String;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure Paint; override;
    function getSVG(OwnerRect: TRect): string; override;
    function getSVGTypeAndBinding(R: TRect): string;
    property TextWidthParameter: integer read FTextWidthParameter;
    property ExtentX: integer read FExtentX write FExtentX;
    property ExtentY: integer read FExtentY;
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
    constructor Create(aOwner: TComponent; aEntity: TModelEntity; const aCaption: string); reintroduce;
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

  //Class to display name of package at upper-left corner in a unitpackage diagram
  TRtfdUnitPackageDiagram = class(TRtfdCustomLabel, IAfterUnitPackageListener)
  private
    P: TUnitPackage;
  public
    constructor Create(aOwner: TComponent; aEntity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterUnitPackageListener.EntityChange = EntityChange;
  end;

  //Left-justified label with visibility-icon
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

uses SysUtils, Forms, Themes, UITypes, Types, Math, Dialogs, ExtCtrls, Clipbrd,
     StrUtils, uIterators, uConfiguration, uViewIntegrator, UImages, frmPyIDEMain;

const
  cDefaultWidth = 150;

  function getSVGRect(x, y, w, h: real; color: string; attribut: string = ''): string;
  begin
    Result:= '  <rect x=' + FloatToVal(x) + ' y=' + FloatToVal(y) +
             ' width=' + FloatToVal(w) + ' height=' + FloatToVal(h) +
             ' fill="' + color + '" stroke="black"' + attribut + ' />'#13#10;
  end;

  function getSVGCircle(x, y, r: real): string;
  begin
    Result:= '  <circle cx=' + FloatToVal(x) + ' cy=' + FloatToVal(y) +
             ' r=' + FloatToVal(r) + ' fill="none" stroke="black" />'#13#10;
  end;

  function getSVGText(x, y: real; attribut, text: string): string;
    var SL: TStringList; i: integer; dyr: real; dys: string;

    function getPreserve(s: string): string;
    begin
      if (length(s) > 0) and (s[1] = ' ')
        then Result:= ' xml:space="preserve"'
        else Result:= '';
    end;

  begin
    SL:= TStringList.Create;
    SL.Text:= ConvertLtGt(text);
    Result:= '  <text x=' + FloatToVal(x) + ' y=' + FloatToVal(y) + attribut + '>';
    if SL.Count > 1 then begin
      Result:= Result + #13#10'    <tspan' + getPreserve(SL.Strings[0]) + '>' + SL.Strings[0] + '</tspan>'#13#10;
      dyr:= 1.3;
      for i:= 1 to SL.Count - 1 do begin
        if trim(SL.Strings[i]) = '' then
          dyr:= dyr + 1.3
        else begin
          dys:= FloatToVal(dyr);
          insert('em', dys, length(dys));
          Result:= Result + '    <tspan' + getPreserve(SL.Strings[i]) +
            ' x=' + FloatToVal(x) + ' dy=' + dys + '>' + SL.Strings[i] + '</tspan>'#13#10;
          dyr:= 1.3;
        end;
      end;
      Result:= Result + '  </text>'#13#10;
    end else
      Result:= Result + ReplaceText(SL.Text, #13#10, '') + '</text>'#13#10;
    FreeAndNil(SL);
  end;

  function getSVGPolyline(Points: array of TPoint; color: string): string;
    var i: integer;
  begin
    Result:= '  <polyline points="';
    for i:= 0 to High(Points) do
      Result:= Result + PointToVal(Points[i]);
    Result[length(Result)]:= '"';
    Result:= Result + ' fill="none" stroke="' + color +'" stroke-width="2" />'#13#10;
  end;

  function getSVGPolygon(Points: array of TPoint; color: string): string;
    var i: integer;
  begin
    Result:= '  <polygon points="';
    for i:= 0 to High(Points) do
      Result:= Result + PointToVal(Points[i]);
    Result[length(Result)]:= '"';
    Result:= Result + ' fill="' + color + '" stroke="black" />'#13#10;
  end;

  function calcSVGBaseLine(R: TRect; Font: TFont): integer;
  begin
    Result:= R.Top + Round(1.0*abs(Font.Height));
  end;

{ TRtfdBox }
constructor TRtfdBox.Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(aOwner);
  BorderWidth:= 3;
  Self.Frame:= aFrame;
  Self.Entity:= aEntity;
  Self.FMinVisibility:= MinVisibility;
  Font.assign(aFrame.Diagram.Font);
  Top:= (aFrame.ClientHeight - Self.Width) div 2 + Random(50) - 25;
  Left:= (aFrame.ClientWidth - Self.Width) div 2 + Random(50) - 25;
  ParentBackground:= true;
  DoubleBuffered:= false;  // bad for debugging
  ShadowWidth:= GuiPyOptions.ShadowWidth;
  FETypeBinding:= nil;
  FBitmap:= nil;
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
  Hide;
  DestroyComponents;
  FreeAndNil(fBitmap);
  FBitmapOK:= false;
end;

function TRtfdBox.GetBoundsRect: TRect;
begin
  Result:= BoundsRect;
  Result.Bottom:= Result.Bottom - ShadowWidth;
  Result.Right:= Result.Right - ShadowWidth;
end;

function TRtfdBox.MyGetClientRect: TRect;
begin
  Result:= ClientRect;
  Result.Bottom:= Result.Bottom;
  Result.Right:= Result.Right - ExtentX;
  Result.Left:= Result.Left;
  Result.Top:= Result.Top;
end;

procedure TRtfdBox.PaintShadow(rounded: boolean; sw: integer; C: TCanvas; R: TRect);
  var i, SCol, ECol, sr, sg, sb, er, eg, eb: Integer;

  function ColorGradient(i: integer): TColor;
    var r, g, b: integer;
  begin
    r:= sr + round(((er - sr)*i)/Sw);
    g:= sg + round(((eg - sg)*i)/Sw);
    b:= sb + round(((eb - sb)*i)/Sw);
    Result:= RGB(r, g, b);
  end;

begin
  if sw = 0 then exit;
  C.Pen.Mode:= pmCopy;
  SCol:= ColorToRGB(BGColor);
  sr:= GetRValue(SCol);
  sg:= GetGValue(SCol);
  sb:= getBValue(SCol);
  ECol:= ColorToRGB(FGColor);
  er:= GetRValue(ECol);
  eg:= GetGValue(ECol);
  eb:= getBValue(ECol);
  C.Pen.width:= 2;
  for i:= 1 to Sw do begin
    C.Pen.Color:= ColorGradient(i);
    if rounded then
      C.RoundRect(R.Left + i, R.Top + i, R.Right-i, R.Bottom -i, 16-i, 16-i)
    else
      C.PolyLine([Point(R.Right- sw, R.Top+i), Point(R.Right-i, R.Top+i),
                  Point(R.Right-i, R.Bottom-i), Point(R.Left+i, R.Bottom-i),
                  Point(R.Left+i, R.Bottom- Sw)]);
  end;
  C.Pen.Width:= 1;
end;

procedure TRtfdBox.Paint;
var
  R, R1: TRect;
  Sw, Si, TopH, NeedH, i, Separator: integer;
  IsObject, IsClass, IsValid: boolean;
  Pathname, SVGColor: String;

begin
  if assigned(fBitmap) and fBitmapOK then begin
    Canvas.Draw(0, 0, fBitmap);
    if Selected then
      Frame.Diagram.DrawMarkers(GetBoundsRect, true);
    exit;
  end;

  IsValid:= false;
  IsObject:= (Self is TRtfdObject);
  IsClass:= (Self is TRTfdClass);
  if IsClass then begin
    Pathname:= (Self as TRtfdClass).Pathname;
    IsValid:= PyIDEMainForm.IsAValidClass(Pathname);
  end;

  Sw:= ShadowWidth;
  Si:= 255 - Round(GuiPyOptions.ShadowIntensity*25.5);
  R:= MyGetClientRect;    // Client
  NeedH:= BorderWidth + Sw + 5;
  if ComponentCount > 0 then begin
    TopH:= TGraphicControl(Components[0]).Height + NeedH - Sw;
    if Components[0] is TRtfdStereotype then
      TopH:= TopH + TGraphicControl(Components[0]).Height;
  end else
    TopH:= NeedH - Sw;

  TopH:= TopH - ExtentY;

  // debugging
  //  FMessages.OutputToTerminal('Paint: ' + ExtractFilename(Pathname));

  with Canvas do begin
    // the white border musst be filled, else there are arrow-grabber rests
    // Canvas.Brush.Color:= clWhite;
    // Canvas.FillRect(Clientrect);

    // markers
    if Selected then
      Frame.Diagram.DrawMarkers(GetBoundsRect, true);

    // shadow-colors
    Brush.Color:= RGB(Si, Si, Si);
    R1:= Rect(R.Left + Sw, R.Top + Sw + ExtentY, R.Right, R.Bottom);

    if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
       (IsClass and (GuiPyOptions.ClassHead = 1))
      then PaintShadow(true,  sw, Canvas, R1)
      else PaintShadow(false, sw, Canvas, R1);

    //Background
    Pen.Color:= FGColor;
    Brush.Color:= BGColor;

    // footer first
    if IsObject and (GuiPyOptions.ObjectFooter = 1) then begin
      RoundRect(R.Left, R.Bottom - Sw - TopH, R.Right - Sw, R.Bottom - Sw, 16, 16);
      Rectangle(R.Left, R.Top + TopH - 1, R.Right - Sw, R.Bottom - Sw - TopH div 2);
      MoveTo(R.Left + 1, R.Bottom - Sw - TopH div 2 - 1);
      Pen.Color:= BGColor;
      LineTo(R.Right - Sw - 1, R.Bottom - Sw - TopH div 2 - 1);
      Pen.Color:= FGColor;
    end else // room for attributes and methods
      if R.Bottom > TopH + Sw then
        Rectangle(R.Left, R.Top + TopH - 1 + ExtentY, R.Right - Sw, R.Bottom - Sw);

    // Class- or Object-Label
    if IsObject then begin
      Brush.Color:= GuiPyOptions.ObjectColor;
      SVGColor:=  myColorToRGB(GuiPyOptions.ObjectColor);
    end else if IsValid or FLocked then begin
      Brush.Color:= BGColor;
      SVGColor:= myColorToRGB(GuiPyOptions.ValidClassColor);
    end else begin
      Brush.Color:= GuiPyOptions.InvalidClassColor;
      SVGColor:= myColorToRGB(GuiPyOptions.InvalidClassColor);
    end;
    if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
       (IsClass and (GuiPyOptions.ClassHead = 1))
    then begin
      RoundRect(R.Left, R.Top, R.Right - Sw, R.Top + TopH, 16, 16);
      FillRect(Rect(R.Left, R.Top + TopH div 2, R.Right - Sw, R.Top + TopH));
      MoveTo(R.Left, R.Top + TopH div 2);
      LineTo(R.Left, R.Top + TopH - 1);
      LineTo(R.Right - Sw - 1, R.Top + TopH - 1);
      LineTo(R.Right - Sw - 1, R.Top + TopH div 2 - 1);
      SVGHead:= '  <path d="M ' + XYToVal(R.Left, R.Top + TopH - 1) +
                ' h ' + IntToStr(R.Width - sw) +
                ' v ' + IntToStr(-TopH + 1 + 8) +
                ' a ' + PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(-8, -8)) +
                ' h ' + IntToStr(-R.Width + sw + 2*8) +
                ' a ' + PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(-8, +8)) +
                ' v ' + IntToStr(TopH - 1 - 8) + '" fill="' + SVGColor + '" stroke="black" />'#13#10;
    end else begin // class label
      Rectangle(R.Left, R.Top + ExtentY, R.Right - Sw, R.Top + TopH + ExtentY);
      SVGHead:= getSVGRect(R.Left, R.Top + ExtentY, R.Right - sw,
                           R.Top + TopH - 1, SVGColor);
    end;

    // debug: show box frame
    //   Canvas.Brush.Color:= clRed;
    //   FrameRect(ClientRect);

    if IsObject and (GuiPyOptions.ObjectFooter = 1) then
      Pen.Color:= clGray;

    //if IsClassOrInterface or (IsObject and GuiPyOptions.ShowObjectsWithMethods) then begin
      Separator:= ExtentY;
      if (Self is TRtfdInterface) or isJUnitTestClass
        then i:= 3
        else i:= 2;
      while (i < ComponentCount) and (Components[i] is TRtfdAttribute) do begin
        Separator:= Separator + TGraphicControl(Components[i]).Height;
        inc(i);
      end;
      if (i < ComponentCount) and (Components[i] is TRtfdSeparator) then begin
        Separator:= Separator + TopH - 1 + (Components[i] as TRtfdSeparator).Height;
        MoveTo(R.Left, Separator);
        LineTo(R.Right - Sw, Separator);
      end;
    //end;
  end;
  // paintTo in makeBitmap calls Paint to create the bitmap
  // it doesn't copy the screen-pixels, because controls can be covered by others
  // or can be partially places outside the window
  if assigned(FBitmap) then fBitmapOK:= true;
end;

function TRtfdBox.getSVG: string;
  var R: TRect; TopH, sw: integer;
      IsObject, IsClassOrInterface, IsComment: boolean;
    S, ShadowFilter: string;
    CustomLabel: TRtfdCustomLabel;
    Separator: TRtfdSeparator;
    i: integer;
begin
  R:= MyGetClientRect;
  sw:= ShadowWidth;
  TopH:= getTopH;
  IsObject:= (Self is TRtfdObject);
  IsClassOrInterface:= (Self is TRtfdClass) or (Self is TRtfdInterface);
  IsComment:= (Self is TRtfdCommentBox);
  if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
    (IsClassOrInterface and (GuiPyOptions.ClassHead = 1)) then
    R.Top:= R.Top + TopH - 1;
  if ShadowWidth > 0
    then ShadowFilter:= ' style="filter:url(#Shadow)"'
    else ShadowFilter:= '';

  s:= '<g id="' + ConvertLtGt(Entity.Name) + '" transform="translate(' + IntToStr(Left) +
      ', ' + IntToStr(Top) + ')" font-family="' + Font.Name +
      '" font-size=' + IntToVal(round(Font.Size*1.3)) + ShadowFilter + '>'#13#10;
  if IsObject and (GuiPyOptions.ObjectFooter = 1) then
    s:= s + '  <path d="M ' + XYToVal(R.Left, R.Top) +
            ' v ' + IntToStr(R.Height - 8 - sw) +
            ' a ' + PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(8, 8)) +
            ' h ' + IntToStr(R.Width - sw - 2*8) +
            ' a ' + PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(8, -8)) +
            ' v ' + IntToStr(-R.Height + 8 + sw) +
            ' h ' + IntToStr(-R.Width + sw) + '" fill="white" stroke="black" />'#13#10
  else if isComment then begin
    Paint;
    s:= s + SVGComment
  end else
    s:= s + getSVGRect(R.Left, R.Top + FExtentY, R.Width - sw, R.Height - FExtentY - sw, 'white');

  if IsClassOrInterface and (SVGHead = '') then
    Paint;
  s:= s + SVGHead;
  R:= getBoundsRect;
  R.Width:= R.Width - FExtentX;
  R.Top:= R.Top + FExtentY;
  for i:= 0 to ControlCount - 1 do begin
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= Controls[i] as TRtfdCustomLabel;
      s:= s + CustomLabel.getSVG(R); // BoundsRect
    end;
    if Controls[i] is TRtfdSeparator then begin
      Separator:= Controls[i] as TRtfdSeparator;
      s:= s + Separator.getSVG(R);
    end;
  end;
  Result:= S + '</g>'#13#10;

  if (Controls[0] is TRtfdClassname) and ((Controls[0] as TRtfdClassname).TypeAndBinding <> '') then begin
    s:= '<g id="' + ConvertLtGt(Entity.Name + '1') + '" transform="translate(' + IntToStr(Left) +
        ', ' + IntToStr(Top) + ')" font-family="' + Font.Name +
        '" font-size=' + IntToVal(round(Font.Size*1.3)) + '>'#13#10;
    Result:= Result + s;
    Result:= Result + (Controls[0] as TRtfdClassname).getSVGTypeAndBinding(R);
    Result:= Result + '</g>'#13#10;
  end;
  Result:= ReplaceStr(Result, '[]', '[ ]');
  Result:= Result + #13#10;
end;

function TRtfdBox.getTopH: integer;
  var NeedH: integer; CustomLabel: TRtfdCustomLabel;
begin
  NeedH:= BorderWidth + ShadowWidth + 5;
  if ComponentCount > 0 then begin
    CustomLabel:= TRtfdCustomLabel(Components[0]);
    Result:= CustomLabel.Height + NeedH - ShadowWidth;
    if CustomLabel is TRtfdStereotype then
      Result:= Result + CustomLabel.Height;
  end else
    Result:= NeedH - ShadowWidth;
  Result:= Result - ExtentY;
end;

procedure TRtfdBox.AddChild(Sender, NewChild: TModelEntity);
begin
  //Stub
end;

procedure TRtfdBox.Change(Sender: TModelEntity);
begin
  //Stub
end;

procedure TRtfdBox.EntityChange(Sender: TModelEntity);
begin
  //Stub
end;

procedure TRtfdBox.Remove(Sender: TModelEntity);
begin
  //Stub
end;

procedure TRtfdBox.SetMinVisibility(const Value: TVisibility);
begin
  if Value <> FMinVisibility then begin
    FMinVisibility:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShowParameter(const Value: integer);
begin
  if Value <> fShowParameter then begin
    fShowParameter:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetSortOrder(const Value: integer);
begin
  if Value <> fSortOrder then begin
    fSortOrder:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShowIcons(const Value: integer);
begin
  if Value <> fShowIcons then begin
    fShowIcons:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShowView(const Value: integer);
begin
  if Value <> fShowView then begin
    fShowView:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetSelected(const Value: boolean);
begin
  if Value <> fSelected then begin
    fSelected:= Value;
    Frame.Diagram.DrawMarkers(GetBoundsRect, Value);
  end;
end;

procedure TRtfdBox.SetTypeBinding(const Value: string);
begin
  if Value <> FTypeBinding then begin
    FTypeBinding:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetShadowWidth(const Value: integer);
begin
  if Value <> FShadowWidth then
  begin
    FShadowWidth:= Value;
    RefreshEntities;
  end;
end;

procedure TRtfdBox.SetParameters(ShowParameter, SortOrder, ShowIcons, Fontsize: integer;
                                 const Fontname: string; aFont: TFont; const TypeBinding: string);
begin
  Self.Font.Assign(aFont);
  Self.Font.Size:= Fontsize;
  Self.Font.Name:= Fontname;
  Self.FShowParameter:= ShowParameter;
  Self.FSortOrder:= SortOrder;
  Self.FShowIcons:= ShowIcons;
  Self.FTypeBinding:= TypeBinding;
  RefreshEntities;
end;

//The following declarations are needed for helping essconnectpanel to
//catch all mouse actions. All controls that are inserted (classname etc)
//in rtfdbox will get their mousedown-event redefined.
type  TCrackControl = class(TControl);

procedure TRtfdBox.Notification(AComponent: TComponent; Operation: Classes.TOperation);
begin
  inherited;
  //Owner=Self must be tested because notifications are being sent for all components
  //in the form. TRtfdLabels are created with Owner=box.
  if (Operation = opInsert) and (aComponent.Owner = Self) and (aComponent is TControl) then begin
    TCrackControl(aComponent).OnMouseDown:= OnChildMouseDown;
    TCrackControl(aComponent).OnDblClick:= OnChildMouseDblClick;
  end;
end;

procedure TRtfdBox.OnChildMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var pt: TPoint;
begin
  pt.X:= X;
  pt.Y:= Y;
  pt:= TControl(Sender).ClientToScreen(pt);
  pt:= ScreenToClient(pt);
  MouseDown(Button, Shift, pt.X, pt.Y);
end;

procedure TRtfdBox.OnChildMouseDblClick(Sender: TObject);
  var pt: TPoint;
begin
  pt:= ScreenToClient(Mouse.CursorPos);
  if GuiPyOptions.ShowClassparameterSeparately and (TypeParameter <> '') and
       (pt.X > Width - 2*ExtentX - 12) and (pt.Y < 2*ExtentY + 4)
  then begin
    Selected:= false;
    FETypeBinding:= TEdit.Create(Owner);
    FETypeBinding.Parent:= (Owner as TCustomPanel);
    FETypeBinding.OnKeyUp:= {$IFDEF LCL}@{$ENDIF} OnEditKeyUp;
    FETypeBinding.Visible:= true;
    FETypeBinding.Text:= FTypeParameter + ': ' + FTypeBinding;
    FETypeBinding.Font.Assign(Font);
    FETypeBinding.SetBounds(Left + Width-2*ExtentX-6, Top + 6, 2*ExtentX + 50, 2*ExtentY - 4);
    FETypeBinding.SelStart:= Length(FETypeBinding.Text);
    FETypeBinding.SetFocus;
  end else
    Frame.Diagram.EditBox(Self);
end;

procedure TRtfdBox.OnEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
    CloseEdit;
end;

procedure TRtfdBox.CloseEdit;
  var s: String;
begin
  if assigned(FETypeBinding) and FETypeBinding.Visible then begin
    s:= FETypeBinding.Text;
    Delete(s, 1, Length(FTypeParameter) + 2);
    TypeBinding:= s;
    Frame.Diagram.SetModified(true);
    FETypeBinding.Visible:= false;
    FreeAndNil(FETypeBinding);
  end;
end;

function TRtfdBox.isJUnitTestclass: boolean;
begin
  if Entity is TClass
    then Result:= (Entity as TClass).isJUnitTestClass
    else Result:= false;
end;

procedure TRtfdBox.Lock(b: Boolean);
begin
  FLocked:= b;
end;

procedure TRtfdBox.makeBitmap;
begin
  if fBitmap = nil then begin
    fBitmapOK:= false;
    fBitmap:= TBitmap.Create;
    fBitmap.Width:= Width;
    fBitmap.Height:= Height;
    fBitmap.Canvas.Lock;
    fBitmap.Canvas.Pen.Color:= FGColor;
    fBitmap.Canvas.Brush.Color:= clred;;
    fBitmap.TransparentColor:= clRed;
    fBitmap.Transparent:= true;
    fBitmap.Canvas.FillRect(Rect(0, 0, width, height));
    PaintTo(fBitmap.Canvas, 0, 0);
    fBitmap.Canvas.Unlock;
  end;
end;

procedure TRtfdBox.ChangeStyle(BlackAndWhite: boolean = false);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then begin
    BGColor:= clWhite;
    FGColor:= clBlack;
  end else begin
    BGColor:= StyleServices.GetStyleColor(scPanel);
    FGColor:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  Color:= BGColor;
  FreeAndNil(fBitmap);
end;

{ TRtfdClass }

constructor TRtfdClass.Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  Self.FShowStatic:= true;
  Pathname:= (aEntity as TClass).Pathname;
  PopupMenu:= aFrame.PopMenuClass;
  aEntity.AddListener(IAfterClassListener(Self));
  FShowParameter:= GuiPyOptions.DiShowParameter;
  FSortOrder:= GuiPyOptions.DiSortOrder;
  FShowIcons:= GuiPyOptions.DiShowIcons;
  FMinVisibility:= TVisibility(GuiPyOptions.DiVisibilityFilter);
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
  Result:= Pathname;
end;

procedure TRtfdClass.RefreshEntities;
var
  NeedH, NeedW, I, aTop: integer;
  C: TClass;
  Omi, Ami : IModelIterator;
  aClassname: TRtfdClassName;
  CustomLabel: TRtfdCustomLabel;
  Attribut: TRtfdAttribute;
  Operation: TRtfdOperation;
  Separator: TRtfdSeparator;
  Stereotype: TRtfdStereotype;

begin
  if not Visible then exit;
  inherited;

  NeedW:= 0;
  NeedH:= 2*Borderwidth + 2;

  if (Entity is TClass) and (Entity as TClass).isJUnitTestClass then begin
    StereoType:= TRtfdStereotype.Create(Self, nil, 'JUnit Testclass');
    Inc(NeedH, Stereotype.Height);
  end;

  // Height depends on choosed font

  aClassname:= TRtfdClassName.Create(Self, Entity);
  ExtentX:= aClassname.ExtentX;
  ExtentY:= aClassname.ExtentY;
  TypeParameter:= aClassname.TypeParameter;
  Inc(NeedH, aClassname.Height);

  //Get names in visibility order
  C:= Entity as TClass;
  if FMinVisibility > Low(TVisibility) then  begin
    Ami:= TModelIterator.Create(C.GetAttributes, TAttribute, FMinVisibility, TIteratorOrder(FSortOrder));
    Omi:= TModelIterator.Create(C.GetOperations, TOperation, FMinVisibility, TIteratorOrder(FSortOrder));
  end else begin
    Ami:= TModelIterator.Create(C.GetAttributes, TIteratorOrder(FSortOrder));
    Omi:= TModelIterator.Create(C.GetOperations, TIteratorOrder(FSortOrder));
  end;

  //Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then begin
    Separator:= TRtfdSeparator.Create(Self);
    Inc(NeedH, Separator.Height);
  end;

  //Attributes
  while Ami.HasNext do begin
    Attribut:= TRtfdAttribute.Create(Self, Ami.Next);
    Inc(NeedH, Attribut.Height);
  end;

  //Separator
  if ((Ami.Count > 0) and (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then begin
    Separator:= TRtfdSeparator.Create(Self);
    Inc(NeedH, Separator.Height);
  end;

  //Operations
  while Omi.HasNext do begin
    Operation:= TRtfdOperation.Create(Self, Omi.Next);
    Inc(NeedH, Operation.Height);
  end;
  Height:= NeedH + ShadowWidth;

  for i:= 0 to ControlCount-1 do
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      NeedW:= Max(CustomLabel.TextWidth, NeedW);
    end;
  Width:= Max(NeedW, cDefaultWidth);

  if aClassname.TypeParameter <> '' then begin
    if Width - ExtentX < Width div 4 then begin
      ExtentX:= Extentx + (Width div 4 - (Width - ExtentX));
      aClassname.ExtentX:= ExtentX;
    end;
  end;

  aTop:= 4;
  for i:= 0 to ControlCount-1 do
    if Controls[i] is TRtfdClassName then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width + ExtentX, CustomLabel.Height);
      aTop:= aTop + CustomLabel.Height;
    end else if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width, CustomLabel.Height);
      aTop:= aTop + CustomLabel.Height;
    end else if Controls[i] is TRtfdSeparator then begin
      Separator:= TRtfdSeparator(Controls[i]);
      Separator.SetBounds(4, aTop, Width, Separator.Height);
      aTop:= aTop + Separator.Height;
    end;

  //if aClassname.Parameter <> '' then
  Width:= Width + ExtentX;
  Width:= Width + ShadowWidth;
  Visible:= true;

 // debugging
 // Application.ProcessMessages;
 // FMessages.OutputToTerminal('RtfdClass - ' + Self.Pathname);
 // FMessages.OutputToTerminal(Debug);
end;

function TRtfdClass.Debug: String;
  var s: string; CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator; R: TRect; i: integer;
begin
s:= '';
  for i:= 0 to ControlCount-1 do begin
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= Controls[i] as TRtfdCustomLabel;
      R:= CustomLabel.BoundsRect;
      s:= s + IntToStr(R.Left) + '-'+IntTostr(R.Top)+'-'+IntTostr(r.Width) +'-'+IntToStr(r.height)+#13#10;
    end;
    if Controls[i] is TRtfdSeparator then begin
      Separator:= Controls[i] as TRtfdSeparator;
      R:= Separator.BoundsRect;
      s:= s + IntToStr(R.Left) + '-'+IntTostr(R.Top)+'-'+IntTostr(r.Width) +'-'+IntToStr(r.height)+#13#10;
    end;
  end;
  Result:= s;
end;

{ TRtfdObject }

constructor TRtfdObject.Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  Self.FShowStatic:= false;
  PopupMenu:= aFrame.PopMenuObject;
  aEntity.AddListener(IAfterObjektListener(Self));
  FSortOrder:= GuiPyOptions.DiSortOrder;
  if GuiPyOptions.ObjectsWithoutVisibility
    then FShowIcons:= 2
    else FShowIcons:= GuiPyOptions.DiShowIcons;
  FMinVisibility:= TVisibility(GuiPyOptions.DiVisibilityFilter);
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
  Result:= (Entity as TObjekt).getTyp.Name;
end;

procedure TRtfdObject.RefreshEntities;
var
  NeedH, NeedW, I, aTop: integer;
  O: TObjekt; C: TClass;
  Ami, Omi : IModelIterator;
  aModelEntity: TModelEntity;
  CustomLabel: TRtfdCustomLabel;
  Attribut: TRtfdAttribute;
  Separator: TRtfdSeparator;
begin
  if not Visible then exit;
  inherited;

  NeedW:= 0;
  NeedH:= 2*Borderwidth + 2;
  Inc(NeedH, TRtfdObjectName.Create(Self, Entity).Height);

  //Get names in visibility order
  O:= Entity as TObjekt;
  C:= O.getTyp;
  if FMinVisibility > Low(TVisibility) then begin
    Ami:= TModelIterator.Create(O.GetAttributes, TAttribute, FMinVisibility, TIteratorOrder(FSortOrder));
    Omi:= TModelIterator.Create(C.GetOperations, TOperation, FMinVisibility, TIteratorOrder(FSortOrder));
  end else begin
    Ami:= TModelIterator.Create(O.GetAttributes, TIteratorOrder(FSortOrder));
    Omi:= TModelIterator.Create(C.GetOperations, TIteratorOrder(FSortOrder));
  end;

  //Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  //Attributes
  while Ami.HasNext do begin
    aModelEntity:= Ami.Next;
    if not aModelEntity.Static or FShowStatic then begin
      Attribut:= TRtfdAttribute.Create(Self, aModelEntity);
      Inc(NeedH, Attribut.Height);
    end;
  end;

  if GuiPyOptions.ShowObjectsWithMethods then begin
    //Separator
    if (Ami.Count > 0) and (Omi.Count > 0) or GuiPyOptions.ShowEmptyRects then
      Inc(NeedH, TRtfdSeparator.Create(Self).Height);

    //Operations
    while Omi.HasNext do
      Inc(NeedH, TRtfdOperation.Create(Self,Omi.Next).Height);
  end;
  Height:= NeedH + ShadowWidth;

  for i:= 0 to ControlCount-1 do
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      NeedW:= Max(CustomLabel.TextWidth, NeedW);
    end;
  Width:= Max(NeedW, cDefaultWidth);

  aTop:= 4;
  for i:= 0 to ControlCount-1 do
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width, CustomLabel.Height);
      aTop:= aTop + CustomLabel.Height;
    end else if Controls[i] is TRtfdSeparator then begin
      Separator:= TRtfdSeparator(Controls[i]);
      Separator.SetBounds(4, aTop, Width, Separator.Height);
      aTop:= aTop + Separator.Height;
    end;

  Width:= Width + ShadowWidth;
  Visible:= true;
end;

{ TRtfdComment }

type
  TMoveCracker = class(TControl);

constructor TRtfdCommentBox.Create(aOwner: TComponent; const S: String; aFrame: TAFrameDiagram;
                                   aMinVisibility: TVisibility; aHandleSize: integer);
  var E: TModelEntity;
begin
  E:= TModelEntity.Create(nil);
  E.Name:= S;
  inherited Create(aOwner, E, aFrame, aMinVisibility);
  Self.HandleSize:= aHandleSize;
  TrMemo:= TStyledMemo.Create(aOwner);
  TrMemo.Brush.Color:= GuiPyOptions.CommentColor;
  TrMemo.Parent:= self;
  TrMemo.BorderStyle:= bsNone;
  TrMemo.ControlStyle:= TrMemo.Controlstyle + [csOpaque];
  TrMemo.onEnter:= OnCommentBoxEnter;
  Cursor:= crCross;
  DoubleBuffered:= false;
  PopupMenu:= aFrame.PopupMenuComment;
end;

destructor TRtfdCommentBox.Destroy;
begin
  FreeAndNil(Entity);
  inherited;
end;

procedure TRtfdCommentBox.SetSelected(const Value: boolean);
begin
  if FSelected <> Value then
    FSelected:= Value;
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

function TRtfdCommentBox.GetPathname: String;
begin
  Result:= '';
end;

procedure TRtfdCommentBox.Paint;
const corner = 12;
var
  R, R1: TRect; i: integer;
  Sw: integer;
  Points: Array[0..4] of TPoint;
begin
  ResizeMemo;  // relevant
  Sw:= ShadowWidth;
  TrMemo.Color:= GuiPyOptions.CommentColor;
  TrMemo.Brush.Color:= GuiPyOptions.CommentColor;

  // debugging
  //  FMessages.OutputToTerminal('Paint: CommentBox');

  with Canvas do begin
    Brush.Color:= BGColor;
    Pen.Color:= BGColor;
    R:= MygetClientRect;
    R.Inflate(-HandleSize, -HandleSize);
    FillRect(ClientRect);
    // shadow-colors
    //Brush.Color:= RGB(Si, Si, Si);
    R1:= Rect(R.Left + Sw, R.Top + corner-3 + Sw, R.Right, R.Bottom);
    PaintShadow(false, Sw, Canvas, R1);

    // background for Memo
    Pen.Color:= FGColor;
    Font.Color:= FGColor;
    Brush.Color:= GuiPyOptions.CommentColor;
    Points[0]:= Point(R.Left, R.Top);
    Points[1]:= Point(R.Right - Sw - corner, R.Top);
    Points[2]:= Point(R.Right - Sw, R.Top + corner);
    Points[3]:= Point(R.Right - Sw, R.Bottom - Sw);
    Points[4]:= Point(R.Left, R.Bottom - Sw);
    Polygon(Points);
    SVGComment:= getSVGPolygon(Points, myColorToRGB(GuiPyOptions.CommentColor));

    MoveTo(R.Right - Sw - corner, R.Top);
    LineTo(R.Right - Sw - corner, R.Top + corner);
    LineTo(R.Right - Sw, R.Top + corner);

    SVGComment:= SVGComment +
                   '  <path d="M ' + PointToVal(Point(R.Right - sw - corner, R.Top)) +
                   'L ' + PointToVal(Point(R.Right - sw - corner, R.Top + corner)) +
                   'L ' + PointToVal(Point(R.Right - sw, R.Top + corner)) + '"' +
                   ' stroke="black" fill="' + myColorToRGB(GuiPyOptions.CommentColor) + '" />'#13#10;

    R:= TrMemo.BoundsRect;
    SVGComment:= SVGComment + getSVGText(TrMemo.Left, calcSVGBaseLine(R, Canvas.Font), '', TrMemo.Lines.Text);

    if FSelected then begin
      Brush.Color:= FGColor;
      for i:= 0 to 7 do begin
        R1:= panels[i];
        FillRect(R1);
      end;
    end;
    TrMemo.Invalidate;
  end;
end;

procedure TRtfdCommentBox.CommentMouseMove(PFrom, PTo: TPoint);
  var nr, dx, dy, l, t, w, h: integer;
      P1, P2: TPoint;
begin
  P1:= ScreenToClient(PFrom);
  P2:= ScreenToClient(PTo);
  dx:= P2.X - P1.X;
  dy:= P2.Y - P1.Y;
  nr:= getPanelNr(P1);
  l:= Left;
  t:= Top;
  w:= Width;
  h:= height;
  case nr of
    0:
      begin //oben links
        t:= t + dy;
        h:= h - dy;
        l:= l + dx;
        w:= w - dx;
      end;
    1:
      begin //oben mitte
        t:= t + dy;
        h:= h - dy;
      end;
    2:
      begin //oben rechts
        t:= t + dy;
        h:= h - dy;
        w:= w + dx;
      end;
    3:
      begin //unten rechts
        w:= w + dx;
        h:= h + dy;
      end;
    4: //unten mitte
       h:= h + dy;
    5:
      begin //unten links
        l:= l + dx;
        w:= w - dx;
        h:= h + dy;
      end;
    6:
      begin // links mitte
        l:= l + dx;
        w:= w - dx;
      end;
    7: // rechts mitte
       w:= w + dx;
    8: //Es wurde direkt auf die Komponente geklickt
      begin
        l:= l + dx;
        t:= t + dy;
      end;
  end;
  SetBounds(L, t, w, h);
end;

procedure TRtfdCommentBox.ResizeMemo;
  var w2, h2, i: integer; Rect: TRect;
      HandleSizeH: integer;
begin
  HandleSizeH:= handleSize;
  TrMemo.Left:= 2*HandleSizeH;
  TrMemo.Top:= 2*HandleSizeH;
  TrMemo.Width:= Self.Width - 4*HandleSizeH - ShadowWidth - 5;
  TrMemo.Height:= Self.Height - 4*HandleSizeH - ShadowWidth;

  //  Rect:= GetHandleClientRect;
  Rect:= MygetClientrect;
  rect.Left  := HandleSizeH;
  rect.Top   := HandleSizeH;
  rect.Right := rect.Right - HandleSizeH;
  rect.Bottom:= rect.Bottom - HandleSizeH;

  w2:= (Rect.Right - Rect.Left) div 2;
  h2:= (Rect.Bottom - Rect.Top) div 2;

  panels[0].Left:= Rect.Left - HandleSizeH;
  panels[0].Top:= Rect.Top - HandleSizeH;
  panels[1].Left:= Rect.Left + w2 - HandleSizeH;
  panels[1].Top:= Rect.Top - HandleSizeH;
  panels[2].Left:= Rect.Right - HandleSize;
  panels[2].Top:= Rect.Top - HandleSizeH;
  panels[3].Left:= Rect.Right - HandleSizeH;
  panels[3].Top:= Rect.Bottom - HandleSizeH;
  panels[4].Left:= Rect.Left + w2 - HandleSizeH;
  panels[4].Top:= Rect.Bottom - HandleSizeH;
  panels[5].Left:= Rect.Left - HandleSizeH;
  panels[5].Top:= Rect.Bottom - HandleSizeH;
  panels[6].Left:= Rect.Left - HandleSizeH;
  panels[6].Top:= Rect.Top + h2 - HandleSizeH;
  panels[7].Left:= Rect.Right - HandleSizeH;
  panels[7].Top:= Rect.Top + h2 - HandleSizeH;
  for i:= 0 to 7 do begin
    panels[i].right:= panels[i].left + 2*HandleSizeH;
    panels[i].Bottom:= panels[i].Top + 2*HandleSizeH;
  end;
end;

function TRtfdCommentBox.getPanelRect(i: integer): TRect;
begin
  Result:= Rect(Panels[i].Left, Panels[i].Top,
                Panels[i].Left + Panels[i].Width, Panels[i].Top + Panels[i].Height);
end;

function TRtfdCommentBox.getPanelNr(P: TPoint): integer;
  var i: integer;
begin
  i:= 0;
  while (i < 8) and not ptInRect(getPanelRect(i), P) do
    inc(i);
  Result:= i;
end;

{ TRtfdUnitPackage }

constructor TRtfdUnitPackage.Create(aOwner: TComponent; aEntity: TModelEntity; aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  P:= aEntity as TUnitPackage;
  RefreshEntities;
end;

procedure TRtfdUnitPackage.RefreshEntities;
begin
  DestroyComponents;
  TRtfdUnitPackageName.Create(Self, P);
  Height:= 45;
end;

{ TVisibilityLabel }

const
  IconW = 12;

procedure TVisibilityLabel.Paint;
var
  R : TRect;
  Bitmap : Graphics.TBitmap;
  BildNr, Abstand: Integer;
  s: String;
  Style: TFontStyles;
begin
  // for debugging
  //   Canvas.Brush.Color:= clRed;
  //   Canvas.FillRect(ClientRect);
  SetColors;
  R:= ClientRect;
  if Entity.Visibility = viPublished then
    Entity.Visibility:= viPublic;
 
  if Entity is TAttribute
    then BildNr:= Integer(Entity.Visibility)
    else BildNr:= Integer(Entity.Visibility) + 4;
  if not GuiPyOptions.ConstructorWithVisibility and (Entity is TOperation) and
     ((Entity as TOperation).OperationType = otConstructor)
    then BildNr:= 8;
  Font.Color:= FGColor;
  Canvas.Brush.Color:= BGColor;
  Canvas.Font.Assign(Font);
  if Entity.Static then Canvas.Font.Style:= [fsUnderline];
  if GuiPyOptions.RelationshipAttributesBold and (Entity is TAttribute) and (Entity as TAttribute).Connected then
    Canvas.Font.Style:= Canvas.Font.Style + [fsBold];

  case (Owner as TRtfdBox).ShowIcons of
    0: begin
         Bitmap:= TBitmap.Create;
         Bitmap.TransparentMode:= tmFixed;
         Bitmap.Transparent:= true;
         Bitmap.TransparentColor:= clWhite;
         if StyleServices.IsSystemStyle
           then DMImages.ILUMLRtfdComponentsLight.GetBitmap(BildNr, Bitmap)
           else DMImages.ILUMLRtfdComponentsDark.GetBitmap(BildNr, Bitmap);
         Canvas.Draw(R.Left + 4, R.Bottom div 2 - 5, Bitmap);
         R.Left:= R.Left + IconW + 8;
         Canvas.TextOut(R.Left, R.Top, Caption);
         FreeAndNil(Bitmap);
       end;
    1: begin
         Style:= Canvas.Font.Style;
         Canvas.Font.Style:= [];
         case Entity.Visibility of
           viPrivate:   s:= '- ';
           viPackage:   s:= '~ ';
           viProtected: s:= '# ';
           viPublic:    s:= '+ ';
         end;
         if BildNr = 8 then s:= 'c ';
         Canvas.Font.Pitch:= fpFixed;
         Canvas.TextOut(R.Left + 4, R.Top, s);
         Abstand:= Canvas.Textwidth('+ ');
         Canvas.Font.Style:= Style;
         Canvas.TextOut(R.Left + 4 + Abstand, R.Top, Caption);
       end;
    2: Canvas.TextOut(R.Left + 4, R.Top, Caption);
  end;
end;

function TVisibilityLabel.getSVG(OwnerRect: TRect): string;
var
  BildNr: integer;
  S, fontstyle, Icon, attribut, span: string;
  c: char;
  bx, by: real;

begin
  fontstyle:= '';
  if GuiPyOptions.RelationshipAttributesBold and (Entity is TAttribute) and
    (Entity as TAttribute).Connected then
    fontstyle:= fontstyle + ' font-weight="bold"';
  if Entity.Static then
    fontstyle:= fontstyle + ' text-decoration="underline"';
  if Entity.IsAbstract then
    fontstyle:= fontstyle + ' font-style="italic"';

  //R:= ClientRect;
  if (Entity is TAttribute)
    then BildNr:= integer(Entity.Visibility)
    else BildNr:= integer(Entity.Visibility) + 4;
  if not GuiPyOptions.ConstructorWithVisibility and (Entity is TOperation) and
    ((Entity as TOperation).OperationType = otConstructor) then
    BildNr:= 8;
  case (Owner as TRtfdBox).ShowIcons of
    0: begin
        if (Entity is TAttribute)
          then Icon:= getSVGRect(Left, Top + (Height - Font.size)/2, Font.Size, Font.Size, 'none')
          else Icon:= getSVGCircle(Left + Font.Size/2, Top + Height/2, Font.Size/2);

        c:= ' ';
        case Entity.Visibility of
          viPrivate:   c:= '-';
          viPackage:   c:= '~';
          viProtected: c:= '#';
          viPublic:    c:= '+';
        end;
        if BildNr = 8 then
          c:= 'c';

        bx:= Left;
        // Canvas.TextOut starts output at left/top
        // SVG start output at left/baseline of text
        by:= Top + Round(0.65*Height);
        case c of
          'c': begin bx:= bx + 1.5; by:= by + 0.5 end;
          '~': begin bx:= bx + 0.5; by:= by + 1.5 end;
          '#': begin bx:= bx + 2.1; by:= by + 1.3 end;   // 2,5   1.0
          '+': begin bx:= bx + 0.5; by:= by + 1.3 end;
          '-': begin bx:= bx + 1.9; by:= by + 1.5 end;
        end;
        case c of
          '#': attribut:= ' font-size=' + FloatToVal(Font.Size);
          '-': attribut:= ' font-size=' + FloatToVal(Font.Size*1.5);
        else   attribut:= '';
        end;
        Icon:= Icon + getSVGText(bx, by, attribut, c);
        Result:= Icon + getSVGText(Left + Font.Size + 4, Top + Round(0.65*Height) + 1,
                         fontstyle, Text);
      end;
    1:
      begin
        bx:= Left;
        by:= Top + Round(0.65*Height) + 1;
        case Entity.Visibility of
          viPrivate:   begin S:= '-'; bx:= Left + 1 end;
          viPackage:   S:= '~';
          viProtected: S:= '#';
          viPublic:    S:= '+';
        end;
        if BildNr = 8 then
          S:= 'c';

        Result:= getSVGText(bx, by, '', S);
        span:= '<tspan x=' + IntToVal(Left + Font.Size + 4) + fontstyle + '>' +
                ConvertLtGt(Text) + '</tspan>';
        insert(span, Result, Pos('>' + S, Result) + 2);
      end;
    2: Result:= getSVGText(Left, Top + Round(0.65*Height) + 1, fontstyle, Text);
  end;

  // if GuiPyOptions.UseAbstract and Entity.IsAbstract then
  //  Result:= Result + getSVGText(OwnerRect.Width-8 - ShadowWidth, Top + Round(0.65*Height) + 1,
  //                      ' font-style="italic" text-anchor="end"', '{abstract}');'
end;

{ TRtfdClassName }

constructor TRtfdClassName.Create(aOwner: TComponent; aEntity: TModelEntity);
  var DC: THandle; s, TypeBinding: string;
begin
  inherited Create(aOwner, aEntity);

  if aEntity.IsAbstract
    then Font.Style:= [fsBold, fsItalic]
    else Font.Style:= [fsBold];
  Alignment:= taCenter;
  aEntity.AddListener(IAfterClassListener(Self));
  Caption:= aEntity.Name;
  SingleLineHeight:= Height;

  s:= getShortTypeWith(aEntity.Name);
  TypeParameter:= GenericOf(s);   // class<Parameter>
  if (TypeParameter <> '') and GuiPyOptions.ShowClassparameterSeparately then begin // parameterized class
    TypeBinding:= (aOwner as TRtfdClass).FTypeBinding;
    if TypeBinding = ''
      then TypeAndBinding:= TypeParameter
      else TypeAndBinding:= TypeParameter + ': ' + TypeBinding;
    DC:= GetDC(0);
    Canvas.Handle:= DC;
    Canvas.Font:= Font;
    Canvas.Font.Style:= [];
    FTextWidthParameter:= Canvas.TextWidth(TypeAndBinding) + 8;
    FExtentX:= FTextWidthParameter div 2;
    FExtentY:= abs(Font.Height);
    Caption:= WithoutGeneric(s);
    Canvas.Font.Style:= [fsBold];
    Canvas.Handle:= 0;
    ReleaseDC(0, DC);
  end else begin
    FTextWidthParameter:= 0;
    FExtentX:= 0;
    FExtentY:= 0;
    EntityChange(nil);
  end;
  Height:= Height + 2*FExtentY;
end;

destructor TRtfdClassName.Destroy;
begin
  Entity.RemoveListener(IAfterClassListener(Self));
  inherited;
end;

procedure TRtfdClassName.EntityChange(Sender: TModelEntity);
  var s: string;
begin
  if ((Owner as TRtfdBox).Frame as TAFrameDiagram).Diagram.Package <> Entity.Owner
    then s:= Entity.FullName
    else s:= Entity.Name;
  Caption:= s;
end;

procedure TRtfdClassName.Paint;
var
  R: TRect;
  s: string;
  p, NeedH: integer;
  HeadColor: TColor;

  function isDark(Color: TColor): boolean;
    var V: integer;
  begin
    V:= max(GetRValue(Color), max(GetGValue(Color), GetBValue(Color)));
    Result:= (V <= 128);
  end;

begin
  if TypeAndBinding <> '' then begin
    SetColors;
    // draw classname
    if FTransparent
      then Canvas.Brush.Style:= bsClear
      else Canvas.Brush.Style:= bsSolid;
    if Entity.IsAbstract
      then Canvas.Font.Style:= [fsBold, fsItalic]
      else Canvas.Font.Style:= [fsBold];

    HeadColor:= (Owner as TRtfdBox).Canvas.Brush.Color;
    if IsDark(HeadColor) and IsDark(FGColor) then
      Canvas.Font.Color:= FGColor
    else if not IsDark(HeadColor) and not IsDark(FGColor) then
      Canvas.Font.Color:= BGColor;

    R:= ClientRect;
    R.Top:= R.Top + 2*FExtentY;
    R.Right:= R.Right - FExtentX - GuiPyOptions.ShadowWidth;
    p:= Pos(#13#10'{abstract}', Caption);
    if p > 0
      then s:= copy(Caption, 1, p-1)
      else s:= Caption;
    DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_CENTER);
    if p > 0 then begin
      Canvas.Font.Style:= [fsItalic];
      R.Top:= R.top + SingleLineHeight;
      s:= '{abstract}';
      DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_CENTER);
    end;

    // draw parameter
    SetColors;
    Canvas.Font.Style:= [];
    Canvas.Brush.Style:= bsSolid;
    Canvas.Pen.Style:= psDash;
    Canvas.Pen.Color:= FGColor;
    R:= Parent.ClientRect;
    NeedH:= Round(Height*0.6);
    Canvas.Brush.Color:= BGColor;
    Canvas.Rectangle(R.Right - TextWidthParameter - 12, 0, R.Right - 8, NeedH);
    R:= Rect(R.Right - TextWidthParameter - 14, (NeedH - ExtentY) div 2 - 2, R.Right - 6, NeedH);
    DrawText(Canvas.Handle, PChar(TypeAndBinding), Length(TypeAndBinding), r, DT_CENTER);
  end else
    inherited;
end;

function TRtfdClassName.getSVG(OwnerRect: TRect): string;
  var x, y, p: integer; s, attribut: string;
begin
  attribut:= ' font-weight="bold" text-anchor="middle"';
  if Entity.IsAbstract then
    attribut:= attribut + ' font-style="italic"';
  x:= OwnerRect.Width div 2;
  y:= Top + 2*FExtentY + round(0.65*SingleLineHeight) + 1;
  p:= Pos(#13#10'{abstract}', Caption);
  if p > 0
    then s:= Copy(Caption, 1, p-1)
    else s:= Caption;
  Result:= getSVGText(x, y, attribut, s);
  if p > 0 then begin
    attribut:= ' text-anchor="middle" font-style="italic"';
    y:= y + SingleLineHeight;
    Result:= Result + getSVGText(x, y, attribut, '{abstract}');
  end;
end;

function TRtfdClassName.getSVGTypeAndBinding(R: TRect): string;
  var s: string;
begin
  R:= Parent.ClientRect;
  R.Right:= R.Right - GuiPyOptions.ShadowWidth - 4;
  s:= getSVGRect(R.Right - 2*FExtentX, 0, 2*FExtentX, 2*FExtentY,
        'white', ' stroke-dasharray="1.5% 0.5%"');
  Result:= s + getSVGText(R.Right - 2*FExtentX + 6, Round(2*FExtentY*0.7), '', TypeAndBinding);
end;

{ TRtfdObjectName }

constructor TRtfdObjectName.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  if GuiPyOptions.ObjectUnderline
    then Font.Style:= [fsBold, fsUnderline]
    else Font.Style:= [fsBold];
  Alignment:= taCenter;
  aEntity.AddListener(IAfterObjektListener(Self));
  EntityChange(nil);
end;

destructor TRtfdObjectName.Destroy;
begin
  Entity.RemoveListener(IAfterObjektListener(Self));
  inherited;
end;

procedure TRtfdObjectName.EntityChange(Sender: TModelEntity);
  var Obj: TObjekt;
begin
  Obj:= (Entity as TObjekt);
  case GuiPyOptions.ObjectCaption of
    0: Caption:= Entity.Name + ': ' + Obj.GenericName;
    1: Caption:= Entity.FullName;
  else Caption:= ': ' + Obj.GenericName;
  end;
end;

procedure TRtfdObjectName.Paint;
  var Alig: Integer; R: TRect; HeadColor: TColor;

  function isDark(Color: TColor): boolean;
    var V: integer;
  begin
    V:= max(GetRValue(Color), max(GetGValue(Color), GetBValue(Color)));
    Result:= (V <= 128);
  end;

begin
  SetColors;
  if FTransparent
    then Canvas.Brush.Style:= bsClear
    else Canvas.Brush.Style:= bsSolid;
  Alig:= DT_LEFT;
  case FAlignment of
    taLeftJustify : Alig:= DT_LEFT;
    taRightJustify: Alig:= DT_RIGHT;
    taCenter      : Alig:= DT_CENTER;
  end;

  HeadColor:= (Owner as TRtfdBox).Canvas.Brush.Color;
  if IsDark(HeadColor) and IsDark(FGColor) then
    Canvas.Font.Color:= FGColor
  else if not IsDark(HeadColor) and not IsDark(FGColor) then
    Canvas.Font.Color:= BGColor;

  R:= ClientRect;
  R.Right:= R.Right - GuiPyOptions.ShadowWidth;
  DrawText(Canvas.Handle, PChar(Caption), Length(Caption), R, Alig);
end;

function TRtfdObjectName.getSVG(OwnerRect: TRect): string;
  var x: integer; attribut: string;
begin
  attribut:= ' font-weight="bold" text-anchor="middle"';
  if fsUnderline in Font.Style then
    attribut:= attribut + ' text-decoration="underline"';
  x:= OwnerRect.Width div 2;
  Result:= getSVGText(x, Top + Height - 4, attribut, Text);
end;

{ TRtfdInterfaceName }

constructor TRtfdInterfaceName.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  Font.Style:= [fsBold];
  Alignment:= taCenter;
  aEntity.AddListener(IAfterInterfaceListener(Self));
  Caption:= aEntity.Name;
  SingleLineHeight:= Height;
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
    then Caption:= Entity.FullName
    else Caption:= Entity.Name;
end;

function TRtfdInterfaceName.getSVG(OwnerRect: TRect): string;
  var x, y: integer; attribut: string;
begin
  attribut:= ' text-anchor="middle"';
  x:= OwnerRect.Width div 2;
  y:= Top + round(0.65*SingleLineHeight) + 1 - SingleLineHeight;
  Result:= getSVGText(x, y, attribut, '<<interface>>');
  attribut:= ' font-weight="bold" text-anchor="middle"';
  y:= y + SingleLineHeight;
  Result:= Result + getSVGText(x, y, attribut, Text);
end;

{ TRtfdSeparator }

constructor TRtfdSeparator.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Parent:= aOwner as TWinControl;
  AutoSize:= False;
  Height:= 7;
end;

procedure TRtfdSeparator.Paint;
{var
  R: TRect;
  Box: TRtfdbox;
}
begin
  // beide Varianten, damit es auch beim Kopieren klappt

  // altes Zeichnen
  // erscheint in der Anzeige und in der Kopie
  // aber Strecken sind zu kurz
  {R:= ClientRect;
  Canvas.brush.Color:= clGreen;
  Canvas.FillRect(R);
  Canvas.Pen.Color:= clBlue;  // clBlack;
  Canvas.MoveTo(R.Left, R.Top + (Height div 2));
  Canvas.LineTo(R.Right, R.Top + (Height div 2)); }

  // neu Röhner
  // erscheint nur in der Anzeige, nicht in der Kopie

  {ox:= (Owner as TRtfdBox);
  Box.Canvas.Pen.Color:= clRed;  // clBlack;
  Box.Canvas.Brush.Color:= clGreen; // clWhite
  Box.Canvas.FillRect(Rect(1, Top, Box.Width-4, Top + Height));
  Box.Canvas.MoveTo(1, Top + (Height div 2));
  Box.Canvas.LineTo(Box.Width-4, Top + (Height div 2));
}
end;

function TRtfdSeparator.getSVG(OwnerRect: TRect): string;
begin
  Result:= '  <line x1="0" y1="' + IntToStr(Top + Height div 2) +
           '" x2="' + IntToStr(OwnerRect.Width) +
           '" y2="' + IntToStr(Top + Height div 2) + '" stroke="black" />'#13#10;
end;

{ TRtfdPackageName }

constructor TRtfdUnitPackageName.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  Font.Style:= [fsBold];
  Alignment:= taCenter;
  P:= aEntity as TUnitPackage;
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
  Caption:= P.Name;
end;

{ TRtfdOperation }

constructor TRtfdOperation.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  O:= aEntity as TOperation;
  O.AddListener(IAfterOperationListener(Self));
  EntityChange(nil);
  //ParentFont:= true;  due to abstract operations not possible
end;

destructor TRtfdOperation.Destroy;
begin
  O.RemoveListener(IAfterOperationListener(Self));
  inherited;
end;

// show operation, show method
procedure TRtfdOperation.EntityChange(Sender: TModelEntity);
const
  ColorMap: array[TOperationType] of TColor = (clGreen, clBlack, clGray, clRed);
  //  otConstructor, otProcedure, otFunction, otDestructor,);
var s: string;
    it: IModelIterator;
    Parameter: TParameter;
    ParameterCount: integer;
    ShowParameter: integer;
begin
  //Default uml-syntax
  //visibility name ( parameter-list ) : return-type-expression { property-string }
  ParameterCount:= 0;
  ShowParameter:= (Owner as TRtfdBox).ShowParameter;
  s:= O.Name;

  if ShowParameter > 1 then begin
    s:= s + '(';
    it:= O.GetParameters;
    while it.HasNext do begin
      Parameter:= it.next as TParameter;
      if Parameter.Name = 'self' then
        continue;
      case ShowParameter of
        2: inc(ParameterCount);
        3: s:= s + Parameter.asUMLString(3) + ', ';
        4: s:= s + Parameter.asUMLString(4) + ', ';
        5: s:= s + Parameter.asUMLString(5) + ', ';
        6: s:= s + Parameter.asUMLString(6) + ', ';
      end
    end;
    if (ShowParameter = 2) and (ParameterCount > 0) then
      s:= s + '...';
    if Copy(s, length(s)-1, 2) = ', ' then
      Delete(s, length(s)-1, 2); // delete last comma
    s:= s + ')';
    //if O.OperationType = otFunction then
    //  s:= s + ':';
  end;

  if (ShowParameter > 0) and Assigned(O.ReturnValue) then
    s:= s + ': ' + O.ReturnValue.asUMLType;
  Caption:= s;
  Font.Style:= [];
  //Font.Color:= ColorMap[O.OperationType];
  Font.Color:= FGColor;
  if O.IsAbstract then
    Font.Style:= [fsItalic];
end;

{ TRtfdAttribute }

constructor TRtfdAttribute.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner, aEntity);
  A:= aEntity as TAttribute;
  A.AddListener(IAfterAttributeListener(Self));
  EntityChange(aEntity);
end;

destructor TRtfdAttribute.Destroy;
begin
  A.RemoveListener(IAfterAttributeListener(Self));
  inherited;
end;

procedure TRtfdAttribute.EntityChange(Sender: TModelEntity);
  var s: string;
begin
  // uml standard syntax is:
  // visibility name [ multiplicity ] : type-expression = initial-value { property-string }
  if Sender.Owner is TObjekt then
    Caption:= A.Name + ' = ' + A.Value
  else begin
    s:= A.Name;
    if Assigned(A.TypeClassifier) and ((Owner as TRtfdBox).ShowParameter >= 4) then
      s:= s + ': ' + A.TypeClassifier.asUMLType;
    if (A.Value <> '') and ((Owner as TRtfdBox).ShowParameter >= 5) then
      s:= s + ' = ' + A.Value;
    Caption:= s;
  end
end;

{ TRtfdUnitPackageDiagram }

constructor TRtfdUnitPackageDiagram.Create(aOwner: TComponent;aEntity: TModelEntity);
begin
  //This class is the caption in upper left corner for a unitdiagram
  inherited Create(aOwner, aEntity);
  Color:= clBtnFace;
  Font.Name:= 'Times New Roman';
  Font.Style:= [fsBold];
  Font.Size:= 12;
  Alignment:= taLeftJustify;
  P:= aEntity as TUnitPackage;
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
  Caption:= '   ' + P.FullName;
end;

{ TRtfdInterface }

constructor TRtfdInterface.Create(aOwner: TComponent; aEntity: TModelEntity;
  aFrame: TAFrameDiagram; aMinVisibility: TVisibility);
begin
  inherited Create(aOwner, aEntity, aFrame, aMinVisibility);
  Pathname:= (aEntity as TInterface).Pathname;
  aEntity.AddListener(IAfterInterfaceListener(Self));
  PopupMenu:= aFrame.PopMenuClass;
  RefreshEntities;
end;

destructor TRtfdInterface.Destroy;
begin
  Entity.RemoveListener(IAfterInterfaceListener(Self));
  inherited;
end;

procedure TRtfdInterface.RefreshEntities;
var
  NeedW, NeedH, I, aTop : integer;
  OMi,AMi : IModelIterator;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
  Int : TInterface;
begin
  if not Visible then exit;
  inherited;

  NeedW:= 0;
  NeedH:= 2*Borderwidth + 2;

  Inc(NeedH, TRtfdStereotype.Create(Self, nil, 'interface').Height);
  Inc(NeedH, TRtfdInterfaceName.Create(Self, Entity).Height);

  //Get names in visibility order
  Int:= Entity as TInterface;
  if FMinVisibility > Low(TVisibility) then begin
    Ami:= TModelIterator.Create(Int.GetAttributes, TAttribute, FMinVisibility, TIteratorOrder(FSortOrder));
    Omi:= TModelIterator.Create(Int.GetOperations, TOperation, FMinVisibility, TIteratorOrder(FSortOrder));
  end else begin
    Ami:= TModelIterator.Create(Int.GetAttributes, TIteratorOrder(FSortOrder));
    Omi:= TModelIterator.Create(Int.GetOperations, TIteratorOrder(FSortOrder));
  end;

  //Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  //Attributes
  while Ami.HasNext do
    Inc(NeedH, TRtfdAttribute.Create(Self,Ami.Next).Height);

  //Separator
  if ((Ami.Count > 0) and (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  //Operations
  while Omi.HasNext do
    Inc(NeedH, TRtfdOperation.Create(Self,Omi.Next).Height);
  Height:= NeedH + ShadowWidth;

  for i:= 0 to ControlCount-1 do
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      NeedW:= Max(CustomLabel.TextWidth, NeedW);
    end;
  Width:= Max(NeedW, cDefaultWidth);

  aTop:= 4;
  for i:= 0 to ControlCount-1 do
    if Controls[i] is TRtfdCustomLabel then begin
      CustomLabel:= TRtfdCustomLabel(Controls[i]);
      CustomLabel.SetBounds(4, aTop, Width, CustomLabel.Height);
      aTop:= aTop + CustomLabel.Height;
    end else if Controls[i] is TRtfdSeparator then begin
      Separator:= TRtfdSeparator(Controls[i]);
      Separator.SetBounds(4, aTop, Width, Separator.Height);
      aTop:= aTop + Separator.Height;
    end;

  Width:= Width + ShadowWidth;
  Visible:= true;
end;

procedure TRtfdInterface.AddChild(Sender, NewChild: TModelEntity);
begin
  RefreshEntities;
end;

function TRtfdInterface.GetPathname: string;
begin
  Result:= Pathname;
end;

{ TRtfdStereotype }

constructor TRtfdStereotype.Create(aOwner: TComponent; aEntity: TModelEntity; const aCaption: string);
begin
  inherited Create(aOwner, aEntity);
  Alignment:= taCenter;
  Self.Caption:= '<<' + aCaption + '>>';
end;

{ TRtfdCustomLabel }

constructor TRtfdCustomLabel.Create(aOwner: TComponent; aEntity: TModelEntity);
begin
  inherited Create(aOwner);
  Parent:= aOwner as TWinControl;
  Font.Assign((aOwner as TRtfdBox).Font);
  Self.Entity:= aEntity;
  Height:= abs(Font.Height);
  FAlignment:= taLeftJustify;
  FTransparent:= True;
end;

procedure TRtfdCustomLabel.EntityChange(Sender: TModelEntity);
begin
  //Stub
end;

procedure TRtfdCustomLabel.Remove(Sender: TModelEntity);
begin
  //Stub
end;

procedure TRtfdCustomLabel.AddChild(Sender, NewChild: TModelEntity);
begin
  //Stub
end;

procedure TRtfdCustomLabel.Change(Sender: TModelEntity);
begin
  //Stub
end;

function TRtfdCustomLabel.GetAlignment: TAlignment;
begin
  Result:= FAlignment;
end;

procedure TRtfdCustomLabel.SetAlignment(const Value: TAlignment);
begin
  if Value <> FAlignment then
    begin
    FAlignment:= Value;
    Invalidate;
  end;
end;

procedure TRtfdCustomLabel.Paint;
var
  Alig, p: integer;
  R: TRect;
  s: string;
begin
  SetColors;
  if FTransparent
    then Canvas.Brush.Style:= bsClear
    else Canvas.Brush.Style:= bsSolid;
  Alig:= DT_LEFT;
  case FAlignment of
    taLeftJustify : Alig:= DT_LEFT;
    taRightJustify: Alig:= DT_RIGHT;
    taCenter      : Alig:= DT_CENTER;
  end;
  R:= ClientRect;
  p:= Pos(#13#10'{abstract}', Caption);
  if p > 0 then begin
    s:= Copy(Caption, 1, p-1);
    Canvas.Font.Style:= [fsItalic, fsBold];
  end else
    s:= Caption;
  DrawText(Canvas.Handle, PChar(S), Length(S), R, Alig);
  if p > 0 then begin
    Canvas.Font.Style:= [fsItalic];
    R.Top:= R.Top + SingleLineHeight;
    s:= '{abstract}';
    DrawText(Canvas.Handle, PChar(S), Length(S), R, Alig);
  end;
end;

function TRtfdCustomLabel.getSVG(OwnerRect: TRect): string;
begin
  Result:= '';
end;

procedure TRtfdCustomLabel.SetColors;
begin
  FGColor:= (Parent as TRtfdBox).FGColor;
  BGColor:= (Parent as TRtfdBox).BGColor;
  Canvas.Font.Color:= FGColor;
end;

procedure TRtfdCustomLabel.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent:= Value;
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
  aRect: TRect;
  AAlignment: TAlignment;

begin
  if not (csReading in ComponentState) then begin
    aRect:= Rect(0, 0, 0, 0);
    DC:= GetDC(0);
    Canvas.Handle:= DC;
    Canvas.Font.Assign(Font);
    if GuiPyOptions.RelationshipAttributesBold and (Entity is TAttribute) then
      if (Entity as TAttribute).Connected then
        Canvas.Font.Style:= Canvas.Font.Style + [fsBold];
    if (Entity is TOperation) and Entity.IsAbstract then
      Canvas.Font.Style:= Canvas.Font.Style + [fsItalic];
    drawText(Canvas.handle, PChar(Caption), length(Caption), aRect, DT_CALCRECT);
    FTextWidth:= 8 + aRect.Right + 8;
    case (Owner as TRtfdBox).ShowIcons of
      0: FTextWidth:= FTextWidth + IconW + 4;
      1: FTextWidth:= FTextWidth + Canvas.Textwidth('+ ');
      2: FTextWidth:= FTextWidth + 0;
    end;

    DoDrawText(aRect, DT_EXPANDTABS or DT_CALCRECT);
    Canvas.Handle:= 0;
    ReleaseDC(0, DC);
    X:= Left;
    AAlignment:= FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - aRect.Right);
    SetBounds(X, Top, FTextWidth, aRect.Bottom);
  end;
end;

procedure TRtfdCustomLabel.DoDrawText(var Rect: TRect; Flags: Longint);
var
  aText: string;
begin
  aText:= Caption;
  if aText = '' then
    aText:= '  ';
  if (Flags and DT_CALCRECT <> 0) and ((aText = '') and
    (aText[1] = '&') and (aText[2] = #0)) then aText:= aText + ' ';
  Flags:= Flags or DT_NOPREFIX;
  Flags:= DrawTextBiDiModeFlags(Flags);
  Canvas.Font.Assign(Font);
  if not Enabled then begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color:= clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(aText), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color:= clBtnShadow;
    DrawText(Canvas.Handle, PChar(aText), Length(aText), Rect, Flags);
  end else
    DrawText(Canvas.Handle, PChar(aText), Length(aText), Rect, Flags);
end;

end.
