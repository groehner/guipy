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

unit URtfdComponents;

interface

uses
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  StdCtrls,
  UModel,
  UModelEntity,
  UListeners,
  UDiagramFrame,
  UStyledMemo,
  UPanelTransparent,
  UUtils;

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
    FEntity: TModelEntity;
    FFrame: TAFrameDiagram;
    FSVGHead: string;
    FSVGComment: string;
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
    procedure PaintShadow(Rounded: Boolean; Shadow: Integer; Canvas: TCanvas;
      Rect: TRect);
    function MyGetClientRect: TRect;
    function GetTopH: Integer;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: Classes.TOperation); override;
    procedure EntityChange(Sender: TModelEntity); virtual;
    procedure Change(Sender: TModelEntity); virtual;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); virtual;
    procedure Remove(Sender: TModelEntity); virtual;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity;
      Frame: TAFrameDiagram; MinVisibility: TVisibility); reintroduce; virtual;
    destructor Destroy; override;
    procedure CloseEdit;
    procedure RefreshEntities; virtual;
    procedure Paint; override;
    function GetBoundsRect: TRect; virtual;
    function GetPathname: string; virtual; abstract;
    procedure SetParameters(ShowParameter, SortOrder, ShowIcons: Integer;
      Font: TFont; const TypeBinding: string);
    function IsJUnitTestClass: Boolean;
    procedure MakeBitmap;
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function GetSVG: string; virtual;

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
    property ForegroundColor: TColor read FFGColor write FFGColor;
    property BackgroundColor: TColor read FBGColor write FBGColor;
    property Entity: TModelEntity read FEntity;
    property Frame: TAFrameDiagram read FFrame;
  end;

  TRtfdClass = class(TRtfdBox, IAfterClassListener)
  private
    FPathname: string;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity;
      Frame: TAFrameDiagram; MinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetPathname: string; override;
    function Debug: string;
  end;

  TRtfdObject = class(TRtfdBox, IAfterObjektListener)
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity;
      Frame: TAFrameDiagram; MinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetClassname: string;
  end;

  TRtfdInterface = class(TRtfdBox, IAfterInterfaceListener)
  private
    FPathname: string;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity;
      Frame: TAFrameDiagram; MinVisibility: TVisibility); override;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); override;
    function GetPathname: string; override;
  end;

  TRtfdCommentBox = class(TRtfdBox)
  private
    FHandleSize: Integer;
    FPanels: array [0 .. 7] of TRect;
    FTrMemo: TStyledMemo;
    procedure SetSelected(const Value: Boolean); override;
    function GetPanelRect(Num: Integer): TRect;
    function GetPanelNr(Point: TPoint): Integer;
  public
    constructor Create(Owner: TComponent; const Name: string;
      Frame: TAFrameDiagram; MinVisibility: TVisibility; HandleSize: Integer);
      reintroduce;
    destructor Destroy; override;
    procedure RefreshEntities; override;
    function GetPathname: string; override;
    procedure Paint; override;
    procedure ResizeMemo;
    procedure CommentMouseMove(PFrom, PTo: TPoint);
    procedure OnCommentBoxEnter(Sender: TObject);
    property TrMemo: TStyledMemo read FTrMemo;
  end;

  TRtfdUnitPackage = class(TRtfdBox)
  private
    FPackage: TUnitPackage;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity;
      Frame: TAFrameDiagram; MinVisibility: TVisibility); override;
    procedure RefreshEntities; override;
  end;

  { --- RtfdCustomLabel and descentants ------------------------------------------ }

  TRtfdCustomLabel = class(TGraphicControl, IModelEntityListener)
  private
    FAlignment: TAlignment;
    FTransparent: Boolean;
    FEntity: TModelEntity;
    FTextWidth: Integer;
    FForegroundColor: TColor;
    FBackgroundColor: TColor;
    FSingleLineHeight: Integer;
    function GetAlignment: TAlignment;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetTransparent(const Value: Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure AdjustBounds;
    procedure DoDrawText(var Rect: TRect; Flags: Integer);
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity);
      reintroduce; virtual;
    procedure Paint; override;
    procedure Change(Sender: TModelEntity); virtual;
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity); virtual;
    procedure Remove(Sender: TModelEntity); virtual;
    procedure EntityChange(Sender: TModelEntity); virtual;
    procedure SetColors;
    function GetSVG(OwnerRect: TRect): string; virtual;
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
    FTypeParameter: string;
    FTypeAndBinding: string;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure Paint; override;
    function GetSVG(OwnerRect: TRect): string; override;
    function GetSVGTypeAndBinding(Rect: TRect): string;
    property TextWidthParameter: Integer read FTextWidthParameter;
    property ExtentX: Integer read FExtentX write FExtentX;
    property ExtentY: Integer read FExtentY;
  end;

  TRtfdObjectName = class(TRtfdCustomLabel, IAfterObjektListener)
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure Paint; override;
    function GetSVG(OwnerRect: TRect): string; override;
  end;

  TRtfdInterfaceName = class(TRtfdCustomLabel, IAfterInterfaceListener)
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    function GetSVG(OwnerRect: TRect): string; override;
  end;

  TRtfdStereotype = class(TRtfdCustomLabel)
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity;
      const Caption: string); reintroduce;
  end;

  TRtfdUnitPackageName = class(TRtfdCustomLabel, IAfterUnitPackageListener)
  private
    FPackage: TUnitPackage;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterUnitPackageListener.EntityChange = EntityChange;
  end;

  // Class to display name of package at upper-left corner in a unitpackage diagram
  TRtfdUnitPackageDiagram = class(TRtfdCustomLabel, IAfterUnitPackageListener)
  private
    FPackage: TUnitPackage;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterUnitPackageListener.EntityChange = EntityChange;
  end;

  // Left-justified label with visibility-icon
  TVisibilityLabel = class(TRtfdCustomLabel)
  public
    procedure Paint; override;
    function GetSVG(OwnerRect: TRect): string; override;
  end;

  TRtfdOperation = class(TVisibilityLabel, IAfterOperationListener)
  private
    FOperation: TOperation;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterOperationListener.EntityChange = EntityChange;
  end;

  TRtfdAttribute = class(TVisibilityLabel, IAfterAttributeListener)
  private
    FAttribute: TAttribute;
  public
    constructor Create(Owner: TComponent; Entity: TModelEntity); override;
    destructor Destroy; override;
    procedure EntityChange(Sender: TModelEntity); override;
    procedure IAfterAttributeListener.EntityChange = EntityChange;
  end;

  TRtfdSeparator = class(TGraphicControl)
  public
    constructor Create(Owner: TComponent); override;
    procedure Paint; override;
    function GetSVG(OwnerRect: TRect): string;
  end;

implementation

uses
  SysUtils,
  Forms,
  Themes,
  UITypes,
  Types,
  Math,
  ExtCtrls,
  VirtualImageList,
  StrUtils,
  UIterators,
  UConfiguration,
  uCommonFunctions,
  frmPyIDEMain;

const
  CDefaultWidth = 150;

function GetSVGRect(X, Y, Width, Height: Real; const Color: string;
  const Attribute: string = ''): string;
begin
  Result := '  <rect x=' + FloatToVal(X) + ' y=' + FloatToVal(Y) + ' width=' +
    FloatToVal(Width) + ' height=' + FloatToVal(Height) + ' fill="' + Color +
    '" stroke="black"' + Attribute + ' />'#13#10;
end;

function GetSVGCircle(X, Y, Radius: Real): string;
begin
  Result := '  <circle cx=' + FloatToVal(X) + ' cy=' + FloatToVal(Y) + ' r=' +
    FloatToVal(Radius) + ' fill="none" stroke="black" />'#13#10;
end;

function GetSVGText(X, Y: Real; const Attribut, Text: string): string;
var
  StringList: TStringList;
  Dyr: Real;
  Dys: string;

  function getPreserve(Str: string): string;
  begin
    if (Length(Str) > 0) and (Str[1] = ' ') then
      Result := ' xml:space="preserve"'
    else
      Result := '';
  end;

begin
  StringList := TStringList.Create;
  StringList.Text := ConvertLtGt(Text);
  Result := '  <Text x=' + FloatToVal(X) + ' y=' + FloatToVal(Y) +
    Attribut + '>';
  if StringList.Count > 1 then
  begin
    Result := Result + #13#10'    <tspan' + getPreserve(StringList[0]) + '>' +
      StringList[0] + '</tspan>'#13#10;
    Dyr := 1.3;
    for var I := 1 to StringList.Count - 1 do
    begin
      if Trim(StringList[I]) = '' then
        Dyr := Dyr + 1.3
      else
      begin
        Dys := FloatToVal(Dyr);
        Insert('em', Dys, Length(Dys));
        Result := Result + '    <tspan' + getPreserve(StringList[I]) + ' x=' +
          FloatToVal(X) + ' dy=' + Dys + '>' + StringList[I] + '</tspan>'#13#10;
        Dyr := 1.3;
      end;
    end;
    Result := Result + '  </Text>'#13#10;
  end
  else
    Result := Result + ReplaceText(StringList.Text, #13#10, '') +
      '</Text>'#13#10;
  FreeAndNil(StringList);
end;

function GetSVGPolyline(Points: array of TPoint; const Color: string): string;
begin
  Result := '  <polyline points="';
  for var I := 0 to High(Points) do
    Result := Result + PointToVal(Points[I]);
  Result[Length(Result)] := '"';
  Result := Result + ' fill="none" stroke="' + Color +
    '" stroke-width="2" />'#13#10;
end;

function GetSVGPolygon(Points: array of TPoint; const Color: string): string;
begin
  Result := '  <polygon points="';
  for var I := 0 to High(Points) do
    Result := Result + PointToVal(Points[I]);
  Result[Length(Result)] := '"';
  Result := Result + ' fill="' + Color + '" stroke="black" />'#13#10;
end;

function CalcSVGBaseLine(Rect: TRect; Font: TFont): Integer;
begin
  Result := Rect.Top + Round(1.0 * Abs(Font.Height));
end;

{ TRtfdBox }
constructor TRtfdBox.Create(Owner: TComponent; Entity: TModelEntity;
  Frame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(Owner);
  BorderWidth := 3;
  FFrame := Frame;
  FEntity := Entity;
  FMinVisibility := MinVisibility;
  Font.Assign(Frame.Diagram.Font);
  Top := (Frame.ClientHeight - Width) div 2 + Random(50) - 25;
  Left := (Frame.ClientWidth - Width) div 2 + Random(50) - 25;
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
  FFrame.Diagram.ClearMarkerAndConnections(Self);
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
  Result.Right := Result.Right - ExtentX;
end;

procedure TRtfdBox.PaintShadow(Rounded: Boolean; Shadow: Integer;
  Canvas: TCanvas; Rect: TRect);
var
  Intensity, SCol, StartR, StartG, StartB, EndR, EndG, EndB: Integer;

  function ColorGradient(I: Integer): TColor;
  var
    Red, Green, Blue: Integer;
  begin
    Red := StartR + Round(((EndR - StartR) * I) / Shadow);
    Green := StartG + Round(((EndG - StartG) * I) / Shadow);
    Blue := StartB + Round(((EndB - StartB) * I) / Shadow);
    Result := RGB(Red, Green, Blue);
  end;

begin
  if Shadow = 0 then
    Exit;
  Canvas.Pen.Mode := pmCopy;
  SCol := ColorToRGB(BackgroundColor);
  StartR := GetRValue(SCol);
  StartG := GetGValue(SCol);
  StartB := GetBValue(SCol);
  Intensity := 255 - Round(GuiPyOptions.ShadowIntensity * 25.5);
  EndR := Intensity;
  EndG := Intensity;
  EndB := Intensity;
  Canvas.Pen.Width := 2;
  for var I := 1 to Shadow do
  begin
    Canvas.Pen.Color := ColorGradient(I);
    if Rounded then
      Canvas.RoundRect(Rect.Left + I, Rect.Top + I, Rect.Right - I,
        Rect.Bottom - I, 16 - I, 16 - I)
    else
      Canvas.Polyline([Point(Rect.Right - Shadow, Rect.Top + I),
        Point(Rect.Right - I, Rect.Top + I), Point(Rect.Right - I,
        Rect.Bottom - I), Point(Rect.Left + I, Rect.Bottom - I),
        Point(Rect.Left + I, Rect.Bottom - Shadow)]);
  end;
  Canvas.Pen.Width := 1;
end;

procedure TRtfdBox.Paint;
var
  Rect1, Rect2: TRect;
  Shadow, Intensity, TopH, NeedH, Int, Separator: Integer;
  IsObject, IsClass, IsValid: Boolean;
  Pathname, SVGColor: string;
begin
  Canvas.Font.Assign(Font);
  if Assigned(FBitmap) and FBitmapOK then
  begin
    Canvas.Draw(0, 0, FBitmap);
    if Selected then
      FFrame.Diagram.DrawMarkers(GetBoundsRect, True);
    Exit;
  end;

  IsValid := False;
  IsObject := (Self is TRtfdObject);
  IsClass := (Self is TRtfdClass);
  if IsClass then
  begin
    Pathname := (Self as TRtfdClass).FPathname;
    IsValid := PyIDEMainForm.IsAValidClass(Pathname);
  end;

  Shadow := ShadowWidth;
  Intensity := 255 - Round(GuiPyOptions.ShadowIntensity * 25.5);
  Rect1 := MyGetClientRect; // Client
  NeedH := BorderWidth + Shadow + 5;
  if ComponentCount > 0 then
  begin
    TopH := TGraphicControl(Components[0]).Height + NeedH - Shadow;
    if Components[0] is TRtfdStereotype then
      TopH := TopH + TGraphicControl(Components[0]).Height;
  end
  else
    TopH := NeedH - Shadow;

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
      FFrame.Diagram.DrawMarkers(GetBoundsRect, True);

    // shadow-colors
    Brush.Color := RGB(Intensity, Intensity, Intensity);
    Rect2 := Rect(Rect1.Left + Shadow, Rect1.Top + Shadow + ExtentY,
      Rect1.Right, Rect1.Bottom);

    if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
      (IsClass and (GuiPyOptions.ClassHead = 1)) then
      PaintShadow(True, Shadow, Canvas, Rect2)
    else
      PaintShadow(False, Shadow, Canvas, Rect2);

    // Background
    Pen.Color := ForegroundColor;
    Brush.Color := BackgroundColor;

    // footer first
    if IsObject and (GuiPyOptions.ObjectFooter = 1) then
    begin
      RoundRect(Rect1.Left, Rect1.Bottom - Shadow - TopH, Rect1.Right - Shadow,
        Rect1.Bottom - Shadow, 16, 16);
      Rectangle(Rect1.Left, Rect1.Top + TopH - 1, Rect1.Right - Shadow,
        Rect1.Bottom - Shadow - TopH div 2);
      MoveTo(Rect1.Left + 1, Rect1.Bottom - Shadow - TopH div 2 - 1);
      Pen.Color := BackgroundColor;
      LineTo(Rect1.Right - Shadow - 1, Rect1.Bottom - Shadow - TopH div 2 - 1);
      Pen.Color := ForegroundColor;
    end
    else // room for attributes and methods
      if Rect1.Bottom > TopH + Shadow then
        Rectangle(Rect1.Left, Rect1.Top + TopH - 1 + ExtentY,
          Rect1.Right - Shadow, Rect1.Bottom - Shadow);

    // Class- or Object-Label
    if IsObject then
    begin
      Brush.Color := GuiPyOptions.ObjectColor;
      SVGColor := myColorToRGB(GuiPyOptions.ObjectColor);
    end
    else if IsValid then
    begin
      Brush.Color := BackgroundColor;
      SVGColor := myColorToRGB(GuiPyOptions.ValidClassColor);
    end
    else
    begin
      Brush.Color := GuiPyOptions.InvalidClassColor;
      SVGColor := myColorToRGB(GuiPyOptions.InvalidClassColor);
    end;
    if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
      (IsClass and (GuiPyOptions.ClassHead = 1)) then
    begin
      RoundRect(Rect1.Left, Rect1.Top, Rect1.Right - Shadow,
        Rect1.Top + TopH, 16, 16);
      FillRect(Rect(Rect1.Left, Rect1.Top + TopH div 2, Rect1.Right - Shadow,
        Rect1.Top + TopH));
      MoveTo(Rect1.Left, Rect1.Top + TopH div 2);
      LineTo(Rect1.Left, Rect1.Top + TopH - 1);
      LineTo(Rect1.Right - Shadow - 1, Rect1.Top + TopH - 1);
      LineTo(Rect1.Right - Shadow - 1, Rect1.Top + TopH div 2 - 1);
      FSVGHead := '  <path d="M ' + XYToVal(Rect1.Left, Rect1.Top + TopH - 1) +
        ' h ' + IntToStr(Rect1.Width - Shadow) + ' v ' + IntToStr(-TopH + 1 + 8)
        + ' a ' + PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(-8, -8)
        ) + ' h ' + IntToStr(-Rect1.Width + Shadow + 2 * 8) + ' a ' +
        PointToVal(Point(8, 8)) + '90 0 0 ' + PointToVal(Point(-8, +8)) + ' v '
        + IntToStr(TopH - 1 - 8) + '" fill="' + SVGColor +
        '" stroke="black" />'#13#10;
    end
    else
    begin // class label
      Rectangle(Rect1.Left, Rect1.Top + ExtentY, Rect1.Right - Shadow,
        Rect1.Top + TopH + ExtentY);
      FSVGHead := GetSVGRect(Rect1.Left, Rect1.Top + ExtentY,
        Rect1.Right - Shadow, Rect1.Top + TopH - 1, SVGColor);
    end;

    // debug: show box FFrame
    // Canvas.Brush.Color:= clRed;
    // FrameRect(ClientRect);

    if IsObject and (GuiPyOptions.ObjectFooter = 1) then
      Pen.Color := clGray;

    // if IsClassOrInterface or (IsObject and GuiPyOptions.ShowObjectsWithMethods) then begin
    Separator := ExtentY;
    if (Self is TRtfdInterface) or IsJUnitTestClass then
      Int := 3
    else
      Int := 2;
    while (Int < ComponentCount) and (Components[Int] is TRtfdAttribute) do
    begin
      Separator := Separator + TGraphicControl(Components[Int]).Height;
      Inc(Int);
    end;
    if (Int < ComponentCount) and (Components[Int] is TRtfdSeparator) then
    begin
      Separator := Separator + TopH - 1 +
        (Components[Int] as TRtfdSeparator).Height;
      MoveTo(Rect1.Left, Separator);
      LineTo(Rect1.Right - Shadow, Separator);
    end;
  end;
  // paintTo in MakeBitmap calls Paint to create the bitmap
  // it doesn't copy the screen-pixels, because controls can be covered by others
  // or can be partially places outside the window
  if not Assigned(FBitmap) then
    MakeBitmap;
  FBitmapOK := True;
end;

function TRtfdBox.GetSVG: string;
var
  ARect: TRect;
  TopH, Shadow: Integer;
  IsObject, IsClassOrInterface, IsComment: Boolean;
  SVG, ShadowFilter: string;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
begin
  ARect := MyGetClientRect;
  Shadow := ShadowWidth;
  TopH := GetTopH;
  IsObject := (Self is TRtfdObject);
  IsClassOrInterface := (Self is TRtfdClass) or (Self is TRtfdInterface);
  IsComment := (Self is TRtfdCommentBox);
  if (IsObject and (GuiPyOptions.ObjectHead = 1)) or
    (IsClassOrInterface and (GuiPyOptions.ClassHead = 1)) then
    ARect.Top := ARect.Top + TopH - 1;
  if ShadowWidth > 0 then
    ShadowFilter := ' style="filter:url(#Shadow)"'
  else
    ShadowFilter := '';

  SVG := '<g id="' + ConvertLtGt(FEntity.Name) + '" transform="translate(' +
    IntToStr(Left) + ', ' + IntToStr(Top) + ')" font-family="' + Font.Name +
    '" font-size=' + IntToVal(Round(Font.Size * 1.3)) + ShadowFilter +
    '>'#13#10;
  if IsObject and (GuiPyOptions.ObjectFooter = 1) then
    SVG := SVG + '  <path d="M ' + XYToVal(ARect.Left, ARect.Top) + ' v ' +
      IntToStr(ARect.Height - 8 - Shadow) + ' a ' + PointToVal(Point(8, 8)) +
      '90 0 0 ' + PointToVal(Point(8, 8)) + ' h ' +
      IntToStr(ARect.Width - Shadow - 2 * 8) + ' a ' + PointToVal(Point(8, 8)) +
      '90 0 0 ' + PointToVal(Point(8, -8)) + ' v ' +
      IntToStr(-ARect.Height + 8 + Shadow) + ' h ' +
      IntToStr(-ARect.Width + Shadow) + '" fill="white" stroke="black" />'#13#10
  else if IsComment then
  begin
    Paint;
    SVG := SVG + FSVGComment;
  end
  else
    SVG := SVG + GetSVGRect(ARect.Left, ARect.Top + FExtentY,
      ARect.Width - Shadow, ARect.Height - FExtentY - Shadow, 'white');

  if IsClassOrInterface and (FSVGHead = '') then
    Paint;
  SVG := SVG + FSVGHead;
  ARect := GetBoundsRect;
  ARect.Width := ARect.Width - FExtentX;
  ARect.Top := ARect.Top + FExtentY;
  for var I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := Controls[I] as TRtfdCustomLabel;
      SVG := SVG + CustomLabel.GetSVG(ARect); // BoundsRect
    end;
    if Controls[I] is TRtfdSeparator then
    begin
      Separator := Controls[I] as TRtfdSeparator;
      SVG := SVG + Separator.GetSVG(ARect);
    end;
  end;
  Result := SVG + '</g>'#13#10;

  if (Controls[0] is TRtfdClassName) and
    ((Controls[0] as TRtfdClassName).FTypeAndBinding <> '') then
  begin
    SVG := '<g id="' + ConvertLtGt(FEntity.Name + '1') +
      '" transform="translate(' + IntToStr(Left) + ', ' + IntToStr(Top) +
      ')" font-family="' + Font.Name + '" font-size=' +
      IntToVal(Round(Font.Size * 1.3)) + '>'#13#10;
    Result := Result + SVG;
    Result := Result + (Controls[0] as TRtfdClassName)
      .GetSVGTypeAndBinding(ARect);
    Result := Result + '</g>'#13#10;
  end;
  Result := ReplaceStr(Result, '[]', '[ ]');
  Result := Result + #13#10;
end;

function TRtfdBox.GetTopH: Integer;
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
    FFrame.Diagram.DrawMarkers(GetBoundsRect, Value);
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
  Font: TFont; const TypeBinding: string);
begin
  Self.Font.Assign(Font);
  Canvas.Font.Assign(Font);
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
  Point: TPoint;
begin
  Point.X := X;
  Point.Y := Y;
  Point := TControl(Sender).ClientToScreen(Point);
  Point := ScreenToClient(Point);
  MouseDown(Button, Shift, Point.X, Point.Y);
end;

procedure TRtfdBox.OnChildMouseDblClick(Sender: TObject);
var
  Point: TPoint;
begin
  Point := ScreenToClient(Mouse.CursorPos);
  if GuiPyOptions.ShowClassparameterSeparately and (TypeParameter <> '') and
    (Point.X > Width - 2 * ExtentX - 12) and (Point.Y < 2 * ExtentY + 4) then
  begin
    Selected := False;
    FETypeBinding := TEdit.Create(Owner);
    FETypeBinding.Parent := (Owner as TCustomPanel);
    FETypeBinding.OnKeyUp := OnEditKeyUp;
    FETypeBinding.Visible := True;
    FETypeBinding.Text := FTypeParameter + ': ' + FTypeBinding;
    FETypeBinding.Font.Assign(Font);
    FETypeBinding.SetBounds(Left + Width - 2 * ExtentX - 6, Top + 6,
      2 * ExtentX + 50, 2 * ExtentY - 4);
    FETypeBinding.SelStart := Length(FETypeBinding.Text);
    if FETypeBinding.CanFocus then
      FETypeBinding.SetFocus;
  end
  else
    FFrame.Diagram.EditBox(Self);
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
    Str := FETypeBinding.Text;
    Delete(Str, 1, Length(FTypeParameter) + 2);
    TypeBinding := Str;
    FFrame.Diagram.SetModified(True);
    FETypeBinding.Visible := False;
    FreeAndNil(FETypeBinding);
  end;
end;

function TRtfdBox.IsJUnitTestClass: Boolean;
begin
  if FEntity is TClass then
    Result := (FEntity as TClass).IsJUnitTestClass
  else
    Result := False;
end;

procedure TRtfdBox.MakeBitmap;
begin
  if not Assigned(FBitmap) then
  begin
    FBitmapOK := False;
    FBitmap := TBitmap.Create;
    FBitmap.Width := Width;
    FBitmap.Height := Height;
    FBitmap.Canvas.Lock;
    FBitmap.Canvas.Pen.Color := ForegroundColor;
    FBitmap.Canvas.Brush.Color := clRed;
    FBitmap.TransparentColor := clRed;
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
    BackgroundColor := clWhite;
    ForegroundColor := clBlack;
  end
  else
  begin
    BackgroundColor := StyleServices.GetStyleColor(scPanel);
    ForegroundColor := StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  Color := BackgroundColor;
  FreeAndNil(FBitmap);
end;

{ TRtfdClass }

constructor TRtfdClass.Create(Owner: TComponent; Entity: TModelEntity;
  Frame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(Owner, Entity, Frame, MinVisibility);
  FShowStatic := True;
  FPathname := (Entity as TClass).Pathname;
  PopupMenu := Frame.PopMenuClass;
  Entity.AddListener(IAfterClassListener(Self));
  FShowParameter := GuiPyOptions.DiShowParameter;
  FSortOrder := GuiPyOptions.DiSortOrder;
  FShowIcons := GuiPyOptions.DiShowIcons;
  FMinVisibility := TVisibility(GuiPyOptions.DiVisibilityFilter);
  RefreshEntities;
end;

destructor TRtfdClass.Destroy;
begin
  FEntity.RemoveListener(IAfterClassListener(Self));
  inherited;
end;

procedure TRtfdClass.AddChild(Sender: TModelEntity; NewChild: TModelEntity);
begin
  RefreshEntities;
end;

function TRtfdClass.GetPathname: string;
begin
  Result := FPathname;
end;

procedure TRtfdClass.RefreshEntities;
var
  NeedH, NeedW, ATop: Integer;
  AClass: TClass;
  Omi, Ami: IModelIterator;
  AClassname: TRtfdClassName;
  CustomLabel: TRtfdCustomLabel;
  Attribute: TRtfdAttribute;
  Operation: TRtfdOperation;
  Separator: TRtfdSeparator;
  Stereotype: TRtfdStereotype;

begin
  if not Visible then
    Exit;
  inherited;

  NeedW := CDefaultWidth;
  NeedH := 2 * BorderWidth + 2;

  if (FEntity is TClass) and (FEntity as TClass).IsJUnitTestClass then
  begin
    Stereotype := TRtfdStereotype.Create(Self, nil, 'JUnit Testclass');
    Inc(NeedH, Stereotype.Height);
  end;

  // Height depends on choosed font
  AClassname := TRtfdClassName.Create(Self, FEntity);
  ExtentX := AClassname.ExtentX;
  ExtentY := AClassname.ExtentY;
  TypeParameter := AClassname.FTypeParameter;
  Inc(NeedH, AClassname.Height);

  // Get names in visibility order
  AClass := FEntity as TClass;
  if FMinVisibility > Low(TVisibility) then
  begin
    Ami := TModelIterator.Create(AClass.GetAttributes, TAttribute,
      FMinVisibility, TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(AClass.GetOperations, TOperation,
      FMinVisibility, TIteratorOrder(FSortOrder));
  end
  else
  begin
    Ami := TModelIterator.Create(AClass.GetAttributes,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(AClass.GetOperations,
      TIteratorOrder(FSortOrder));
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
    Attribute := TRtfdAttribute.Create(Self, Ami.Next);
    Inc(NeedH, Attribute.Height);
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

  for var I := 0 to ControlCount - 1 do
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      NeedW := Max(CustomLabel.TextWidth, NeedW);
    end;
  Width := Max(NeedW, CDefaultWidth);

  if AClassname.FTypeParameter <> '' then
  begin
    if Width - ExtentX < Width div 4 then
    begin
      ExtentX := ExtentX + (Width div 4 - (Width - ExtentX));
      AClassname.ExtentX := ExtentX;
    end;
  end;

  ATop := 4;
  for var I := 0 to ControlCount - 1 do
    if Controls[I] is TRtfdClassName then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      CustomLabel.SetBounds(4, ATop, Width + ExtentX, CustomLabel.Height);
      ATop := ATop + CustomLabel.Height;
    end
    else if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      CustomLabel.SetBounds(4, ATop, Width, CustomLabel.Height);
      ATop := ATop + CustomLabel.Height;
    end
    else if Controls[I] is TRtfdSeparator then
    begin
      Separator := TRtfdSeparator(Controls[I]);
      Separator.SetBounds(4, ATop, Width, Separator.Height);
      ATop := ATop + Separator.Height;
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
  Str: string;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
  ARect: TRect;
begin
  Str := '';
  for var I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := Controls[I] as TRtfdCustomLabel;
      ARect := CustomLabel.BoundsRect;
      Str := Str + IntToStr(ARect.Left) + '-' + IntToStr(ARect.Top) + '-' +
        IntToStr(ARect.Width) + '-' + IntToStr(ARect.Height) + #13#10;
    end;
    if Controls[I] is TRtfdSeparator then
    begin
      Separator := Controls[I] as TRtfdSeparator;
      ARect := Separator.BoundsRect;
      Str := Str + IntToStr(ARect.Left) + '-' + IntToStr(ARect.Top) + '-' +
        IntToStr(ARect.Width) + '-' + IntToStr(ARect.Height) + #13#10;
    end;
  end;
  Result := Str;
end;

{ TRtfdObject }

constructor TRtfdObject.Create(Owner: TComponent; Entity: TModelEntity;
  Frame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(Owner, Entity, Frame, MinVisibility);
  FShowStatic := False;
  PopupMenu := Frame.PopMenuObject;
  Entity.AddListener(IAfterObjektListener(Self));
  FSortOrder := GuiPyOptions.DiSortOrder;
  if GuiPyOptions.ObjectsWithoutVisibility then
    FShowIcons := 2
  else
    FShowIcons := GuiPyOptions.DiShowIcons;
  FMinVisibility := MinVisibility;
  RefreshEntities;
end;

destructor TRtfdObject.Destroy;
begin
  FEntity.RemoveListener(IAfterObjektListener(Self));
  // FreeAndNil(FEntity) this is wrong
  inherited;
end;

procedure TRtfdObject.AddChild(Sender: TModelEntity; NewChild: TModelEntity);
begin
  RefreshEntities;
end;

function TRtfdObject.GetClassname: string;
begin
  Result := (FEntity as TObjekt).GetTyp.Name;
end;

procedure TRtfdObject.RefreshEntities;
var
  NeedH, NeedW, ATop: Integer;
  AObjekt: TObjekt;
  AClass: TClass;
  Ami, Omi: IModelIterator;
  ModelEntity: TModelEntity;
  CustomLabel: TRtfdCustomLabel;
  Attribute: TRtfdAttribute;
  Separator: TRtfdSeparator;
begin
  Locked := True;
  if not Visible then
    Exit;
  inherited;

  NeedW := 0;
  NeedH := 2 * BorderWidth + 2;
  Inc(NeedH, TRtfdObjectName.Create(Self, FEntity).Height);

  // Get names in visibility order
  AObjekt := FEntity as TObjekt;
  AClass := AObjekt.GetTyp;
  if FMinVisibility > Low(TVisibility) then
  begin
    Ami := TModelIterator.Create(AObjekt.GetAttributes, TAttribute,
      FMinVisibility, TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(AClass.GetOperations, TOperation,
      FMinVisibility, TIteratorOrder(FSortOrder));
  end
  else
  begin
    Ami := TModelIterator.Create(AObjekt.GetAttributes,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(AClass.GetOperations,
      TIteratorOrder(FSortOrder));
  end;

  // Separator
  if ((Ami.Count > 0) or (Omi.Count > 0)) or GuiPyOptions.ShowEmptyRects then
    Inc(NeedH, TRtfdSeparator.Create(Self).Height);

  // Attributes
  while Ami.HasNext do
  begin
    ModelEntity := Ami.Next;
    if not ModelEntity.Static or FShowStatic then
    begin
      Attribute := TRtfdAttribute.Create(Self, ModelEntity);
      Inc(NeedH, Attribute.Height);
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

  for var I := 0 to ControlCount - 1 do
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      NeedW := Max(CustomLabel.TextWidth, NeedW);
    end;
  Width := Max(NeedW, CDefaultWidth);

  ATop := 4;
  for var I := 0 to ControlCount - 1 do
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      CustomLabel.SetBounds(4, ATop, Width, CustomLabel.Height);
      ATop := ATop + CustomLabel.Height;
    end
    else if Controls[I] is TRtfdSeparator then
    begin
      Separator := TRtfdSeparator(Controls[I]);
      Separator.SetBounds(4, ATop, Width, Separator.Height);
      ATop := ATop + Separator.Height;
    end;

  Width := Width + ShadowWidth;
  Locked := False;
  Visible := True;
end;

{ TRtfdComment }

type
  TMoveCracker = class(TControl);

constructor TRtfdCommentBox.Create(Owner: TComponent; const Name: string;
  Frame: TAFrameDiagram; MinVisibility: TVisibility; HandleSize: Integer);
var
  ModelEntity: TModelEntity;
begin
  ModelEntity := TModelEntity.Create(nil);
  ModelEntity.Name := Name;
  inherited Create(Owner, ModelEntity, Frame, MinVisibility);
  FHandleSize := HandleSize;
  FTrMemo := TStyledMemo.Create(Owner);
  FTrMemo.Brush.Color := GuiPyOptions.CommentColor;
  FTrMemo.Parent := Self;
  FTrMemo.BorderStyle := bsNone;
  FTrMemo.ControlStyle := FTrMemo.ControlStyle + [csOpaque];
  FTrMemo.OnEnter := OnCommentBoxEnter;
  Cursor := crCross;
  DoubleBuffered := False;
  PopupMenu := Frame.PopupMenuComment;
end;

destructor TRtfdCommentBox.Destroy;
begin
  FreeAndNil(FEntity);
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
    FFrame.Diagram.ClearSelection;
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
  CCorner = 12;
var
  Rect1, Rect2: TRect;
  Shadow: Integer;
  Points: array [0 .. 4] of TPoint;
begin
  ResizeMemo; // relevant
  Shadow := ShadowWidth;
  FTrMemo.Color := GuiPyOptions.CommentColor;
  FTrMemo.Brush.Color := GuiPyOptions.CommentColor;

  // debugging
  // FMessages.OutputToTerminal('Paint: CommentBox');

  with Canvas do
  begin
    Brush.Color := BackgroundColor;
    Pen.Color := BackgroundColor;
    Rect1 := MyGetClientRect;
    Rect1.Inflate(-FHandleSize, -FHandleSize);
    FillRect(ClientRect);
    // shadow-colors
    Rect2 := Rect(Rect1.Left + Shadow, Rect1.Top + CCorner - 3 + Shadow,
      Rect1.Right, Rect1.Bottom);
    PaintShadow(False, Shadow, Canvas, Rect2);

    // background for Memo
    Pen.Color := ForegroundColor;
    Font.Color := ForegroundColor;
    Brush.Color := GuiPyOptions.CommentColor;
    Points[0] := Point(Rect1.Left, Rect1.Top);
    Points[1] := Point(Rect1.Right - Shadow - CCorner, Rect1.Top);
    Points[2] := Point(Rect1.Right - Shadow, Rect1.Top + CCorner);
    Points[3] := Point(Rect1.Right - Shadow, Rect1.Bottom - Shadow);
    Points[4] := Point(Rect1.Left, Rect1.Bottom - Shadow);
    Polygon(Points);
    FSVGComment := GetSVGPolygon(Points,
      myColorToRGB(GuiPyOptions.CommentColor));

    MoveTo(Rect1.Right - Shadow - CCorner, Rect1.Top);
    LineTo(Rect1.Right - Shadow - CCorner, Rect1.Top + CCorner);
    LineTo(Rect1.Right - Shadow, Rect1.Top + CCorner);

    FSVGComment := FSVGComment + '  <path d="M ' +
      PointToVal(Point(Rect1.Right - Shadow - CCorner, Rect1.Top)) + 'L ' +
      PointToVal(Point(Rect1.Right - Shadow - CCorner, Rect1.Top + CCorner)) +
      'L ' + PointToVal(Point(Rect1.Right - Shadow, Rect1.Top + CCorner)) + '"'
      + ' stroke="black" fill="' + myColorToRGB(GuiPyOptions.CommentColor) +
      '" />'#13#10;

    Rect1 := FTrMemo.BoundsRect;
    FSVGComment := FSVGComment + GetSVGText(FTrMemo.Left,
      CalcSVGBaseLine(Rect1, Canvas.Font), '', FTrMemo.Lines.Text);

    if FSelected then
    begin
      Brush.Color := ForegroundColor;
      for var I := 0 to 7 do
      begin
        Rect2 := FPanels[I];
        FillRect(Rect2);
      end;
    end;
    FTrMemo.Invalidate;
  end;
end;

procedure TRtfdCommentBox.CommentMouseMove(PFrom, PTo: TPoint);
var
  Num, DeltaX, DeltaY, ALeft, ATop, AWidth, AHeight: Integer;
  Posi1, Posi2: TPoint;
begin
  Posi1 := ScreenToClient(PFrom);
  Posi2 := ScreenToClient(PTo);
  DeltaX := Posi2.X - Posi1.X;
  DeltaY := Posi2.Y - Posi1.Y;
  Num := GetPanelNr(Posi1);
  ALeft := Left;
  ATop := Top;
  AWidth := Width;
  AHeight := Height;
  case Num of
    0:
      begin // upper left
        ATop := ATop + DeltaY;
        AHeight := AHeight - DeltaY;
        ALeft := ALeft + DeltaX;
        AWidth := AWidth - DeltaX;
      end;
    1:
      begin // upper middle
        ATop := ATop + DeltaY;
        AHeight := AHeight - DeltaY;
      end;
    2:
      begin // upper right
        ATop := ATop + DeltaY;
        AHeight := AHeight - DeltaY;
        AWidth := AWidth + DeltaX;
      end;
    3:
      begin // bottom right
        AWidth := AWidth + DeltaX;
        AHeight := AHeight + DeltaY;
      end;
    4: // bottom middle
      AHeight := AHeight + DeltaY;
    5:
      begin // bottom left
        ALeft := ALeft + DeltaX;
        AWidth := AWidth - DeltaX;
        AHeight := AHeight + DeltaY;
      end;
    6:
      begin // left center
        ALeft := ALeft + DeltaX;
        AWidth := AWidth - DeltaX;
      end;
    7: // right center
      AWidth := AWidth + DeltaX;
    8: // The component was clicked directly
      begin
        ALeft := ALeft + DeltaX;
        ATop := ATop + DeltaY;
      end;
  end;
  SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TRtfdCommentBox.ResizeMemo;
var
  Width2, Height2: Integer;
  Rect: TRect;
  HandleSizeH: Integer;
begin
  HandleSizeH := FHandleSize;
  FTrMemo.Left := 2 * HandleSizeH;
  FTrMemo.Top := 2 * HandleSizeH;
  FTrMemo.Width := Self.Width - 4 * HandleSizeH - ShadowWidth - 5;
  FTrMemo.Height := Self.Height - 4 * HandleSizeH - ShadowWidth;

  // Rect:= GetHandleClientRect
  Rect := MyGetClientRect;
  Rect.Left := HandleSizeH;
  Rect.Top := HandleSizeH;
  Rect.Right := Rect.Right - HandleSizeH;
  Rect.Bottom := Rect.Bottom - HandleSizeH;

  Width2 := (Rect.Right - Rect.Left) div 2;
  Height2 := (Rect.Bottom - Rect.Top) div 2;

  FPanels[0].Left := Rect.Left - HandleSizeH;
  FPanels[0].Top := Rect.Top - HandleSizeH;
  FPanels[1].Left := Rect.Left + Width2 - HandleSizeH;
  FPanels[1].Top := Rect.Top - HandleSizeH;
  FPanels[2].Left := Rect.Right - FHandleSize;
  FPanels[2].Top := Rect.Top - HandleSizeH;
  FPanels[3].Left := Rect.Right - HandleSizeH;
  FPanels[3].Top := Rect.Bottom - HandleSizeH;
  FPanels[4].Left := Rect.Left + Width2 - HandleSizeH;
  FPanels[4].Top := Rect.Bottom - HandleSizeH;
  FPanels[5].Left := Rect.Left - HandleSizeH;
  FPanels[5].Top := Rect.Bottom - HandleSizeH;
  FPanels[6].Left := Rect.Left - HandleSizeH;
  FPanels[6].Top := Rect.Top + Height2 - HandleSizeH;
  FPanels[7].Left := Rect.Right - HandleSizeH;
  FPanels[7].Top := Rect.Top + Height2 - HandleSizeH;
  for var I := 0 to 7 do
  begin
    FPanels[I].Right := FPanels[I].Left + 2 * HandleSizeH;
    FPanels[I].Bottom := FPanels[I].Top + 2 * HandleSizeH;
  end;
end;

function TRtfdCommentBox.GetPanelRect(Num: Integer): TRect;
begin
  Result := Rect(FPanels[Num].Left, FPanels[Num].Top,
    FPanels[Num].Left + FPanels[Num].Width, FPanels[Num].Top +
    FPanels[Num].Height);
end;

function TRtfdCommentBox.GetPanelNr(Point: TPoint): Integer;
begin
  var
  Int := 0;
  while (Int < 8) and not PtInRect(GetPanelRect(Int), Point) do
    Inc(Int);
  Result := Int;
end;

{ TRtfdUnitPackage }

constructor TRtfdUnitPackage.Create(Owner: TComponent; Entity: TModelEntity;
  Frame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(Owner, Entity, Frame, MinVisibility);
  FPackage := Entity as TUnitPackage;
  RefreshEntities;
end;

procedure TRtfdUnitPackage.RefreshEntities;
begin
  DestroyComponents;
  TRtfdUnitPackageName.Create(Self, FPackage);
  Height := 45;
end;

{ TVisibilityLabel }

procedure TVisibilityLabel.Paint;
var
  Rect: TRect;
  Visibi: string;
  PictureNr, Distance: Integer;
  Style: TFontStyles;
  Vil: TVirtualImageList;
begin
  // for debugging
  // Canvas.Brush.Color:= clRed;
  // Canvas.FillRect(ClientRect);
  SetColors;
  Rect := ClientRect;
  if FEntity is TAttribute then
    PictureNr := Integer(FEntity.Visibility)
  else
    PictureNr := Integer(FEntity.Visibility) + 3;
  if not GuiPyOptions.ConstructorWithVisibility and (FEntity is TOperation) and
    ((FEntity as TOperation).OperationType = otConstructor) then
    PictureNr := 6;
  Font.Color := FForegroundColor;
  Canvas.Brush.Color := FBackgroundColor;
  Canvas.Font.Assign(Font);
  if FEntity.Static then
    Canvas.Font.Style := [fsUnderline];
  if GuiPyOptions.RelationshipAttributesBold and (FEntity is TAttribute) and
    (FEntity as TAttribute).Connected then
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];

  case (Owner as TRtfdBox).ShowIcons of
    0:
      begin
        if StyleServices.IsSystemStyle then
          Vil := (Owner as TRtfdBox).FFrame.vilUMLRtfdComponentsLight
        else
          Vil := (Owner as TRtfdBox).FFrame.vilUMLRtfdComponentsDark;
        Vil.SetSize(Rect.Height, Rect.Height);
        Vil.Draw(Canvas, 4, 0, PictureNr);
        Rect.Left := Rect.Left + PPIScale(Vil.Width + 8);
        Canvas.TextOut(Rect.Left, Rect.Top, Caption);
      end;
    1:
      begin
        Style := Canvas.Font.Style;
        Canvas.Font.Style := [];
        case FEntity.Visibility of
          viPrivate:
            Visibi := '- ';
          viProtected:
            Visibi := '# ';
          viPublic:
            Visibi := '+ ';
        end;
        if PictureNr = 6 then
          Visibi := 'c ';
        Canvas.Font.Pitch := fpFixed;
        Canvas.TextOut(Rect.Left + 4, Rect.Top, Visibi);
        Distance := Canvas.TextWidth('+ ');
        Canvas.Font.Style := Style;
        Canvas.TextOut(Rect.Left + 4 + Distance, Rect.Top, Caption);
      end;
    2:
      Canvas.TextOut(Rect.Left + 4, Rect.Top, Caption);
  end;
end;

function TVisibilityLabel.GetSVG(OwnerRect: TRect): string;
var
  PictureNr: Integer;
  Visibi, Fontstyle, Icon, Attribute: string;
  Chr: Char;
  BaseX, BaseY: Real;
begin
  Fontstyle := '';
  if GuiPyOptions.RelationshipAttributesBold and (FEntity is TAttribute) and
    (FEntity as TAttribute).Connected then
    Fontstyle := Fontstyle + ' font-weight="bold"';
  if FEntity.Static then
    Fontstyle := Fontstyle + ' Text-decoration="underline"';
  if FEntity.IsAbstract then
    Fontstyle := Fontstyle + ' font-style="italic"';

  if (FEntity is TAttribute) then
    PictureNr := Integer(FEntity.Visibility)
  else
    PictureNr := Integer(FEntity.Visibility) + 3;
  if not GuiPyOptions.ConstructorWithVisibility and (FEntity is TOperation) and
    ((FEntity as TOperation).OperationType = otConstructor) then
    PictureNr := 3;
  case (Owner as TRtfdBox).ShowIcons of
    0:
      begin
        if (FEntity is TAttribute) then
          Icon := GetSVGRect(Left, Top + (Height - Font.Size) / 2, Font.Size,
            Font.Size, 'none')
        else
          Icon := GetSVGCircle(Left + Font.Size / 2, Top + Height / 2,
            Font.Size / 2);

        Chr := ' ';
        case FEntity.Visibility of
          viPrivate:
            Chr := '-';
          viProtected:
            Chr := '#';
          viPublic:
            Chr := '+';
        end;
        if PictureNr = 6 then
          Chr := 'c';

        BaseX := Left;
        // Canvas.TextOut starts output at left/top
        // SVG start output at left/baseline of Text
        BaseY := Top + Round(0.65 * Height);
        case Chr of
          'c':
            begin
              BaseX := BaseX + 1.5;
              BaseY := BaseY + 0.5;
            end;
          '~':
            begin
              BaseX := BaseX + 0.5;
              BaseY := BaseY + 1.5;
            end;
          '#':
            begin
              BaseX := BaseX + 2.1;
              BaseY := BaseY + 1.3;
            end; // 2,5   1.0
          '+':
            begin
              BaseX := BaseX + 0.5;
              BaseY := BaseY + 1.3;
            end;
          '-':
            begin
              BaseX := BaseX + 1.9;
              BaseY := BaseY + 1.5;
            end;
        end;
        case Chr of
          '#':
            Attribute := ' font-size=' + FloatToVal(Font.Size);
          '-':
            Attribute := ' font-size=' + FloatToVal(Font.Size * 1.5);
        else
          Attribute := '';
        end;
        Icon := Icon + GetSVGText(BaseX, BaseY, Attribute, Chr);
        Result := Icon + GetSVGText(Left + Font.Size + 4,
          Top + Round(0.65 * Height) + 1, Fontstyle, Text);
      end;
    1:
      begin
        BaseX := Left;
        BaseY := Top + Round(0.65 * Height) + 1;
        case FEntity.Visibility of
          viPrivate:
            begin
              Visibi := '-';
              BaseX := Left + 1;
            end;
          viProtected:
            Visibi := '#';
          viPublic:
            Visibi := '+';
        end;
        if PictureNr = 6 then
          Visibi := 'Chr';
        Result := GetSVGText(BaseX, BaseY, '', Visibi);
      end;
    2:
      Result := GetSVGText(Left, Top + Round(0.65 * Height) + 1,
        Fontstyle, Text);
  end;
end;

{ TRtfdClassName }

constructor TRtfdClassName.Create(Owner: TComponent; Entity: TModelEntity);
var
  DeviceContext: THandle;
  Name, TypeBinding: string;
begin
  inherited Create(Owner, Entity);

  if Entity.IsAbstract then
    Font.Style := [fsBold, fsItalic]
  else
    Font.Style := [fsBold];
  Alignment := taCenter;
  Entity.AddListener(IAfterClassListener(Self));
  Caption := Entity.Name;
  FSingleLineHeight := Height;

  Name := GetShortTypeWith(Entity.Name);
  FTypeParameter := GenericOf(Name); // class<Parameter>
  if (FTypeParameter <> '') and GuiPyOptions.ShowClassparameterSeparately then
  begin // parameterized class
    TypeBinding := (Owner as TRtfdClass).FTypeBinding;
    if TypeBinding = '' then
      FTypeAndBinding := FTypeParameter
    else
      FTypeAndBinding := FTypeParameter + ': ' + TypeBinding;
    DeviceContext := GetDC(0);
    Canvas.Handle := DeviceContext;
    Canvas.Font := Font;
    Canvas.Font.Style := [];
    FTextWidthParameter := Canvas.TextWidth(FTypeAndBinding) + 8;
    FExtentX := FTextWidthParameter div 2;
    FExtentY := Abs(Font.Height);
    Caption := WithoutGeneric(Name);
    Canvas.Font.Style := [fsBold];
    Canvas.Handle := 0;
    ReleaseDC(0, DeviceContext);
  end
  else
  begin
    FTextWidthParameter := 0;
    FExtentX := 0;
    FExtentY := 0;
    EntityChange(nil);
  end;
  if Entity.IsAbstract and GuiPyOptions.UseAbstractForClass then
    Caption := Caption + #13#10'{abstract}';
  Height := Height + 2 * FExtentY;
end;

destructor TRtfdClassName.Destroy;
begin
  FEntity.RemoveListener(IAfterClassListener(Self));
  inherited;
end;

procedure TRtfdClassName.EntityChange(Sender: TModelEntity);
var
  Name: string;
begin
  if (Owner as TRtfdBox).FFrame.Diagram.Package <> FEntity.Owner then
    Name := FEntity.Fullname
  else
    Name := FEntity.Name;
  Caption := Name;
end;

procedure TRtfdClassName.Paint;
var
  ARect: TRect;
  Name: string;
  Posi, NeedH: Integer;
  HeadColor: TColor;
begin
  if FTypeAndBinding <> '' then
  begin
    Canvas.Font.Assign(Font);
    SetColors;
    // draw classname
    if FTransparent then
      Canvas.Brush.Style := bsClear
    else
      Canvas.Brush.Style := bsSolid;
    if FEntity.IsAbstract then
      Canvas.Font.Style := [fsBold, fsItalic]
    else
      Canvas.Font.Style := [fsBold];

    HeadColor := (Owner as TRtfdBox).Canvas.Brush.Color;
    if IsColorDark(HeadColor) and IsColorDark(FForegroundColor) then
      Canvas.Font.Color := FForegroundColor
    else if not IsColorDark(HeadColor) and not IsColorDark(FForegroundColor)
    then
      Canvas.Font.Color := FBackgroundColor;

    ARect := ClientRect;
    ARect.Top := ARect.Top + 2 * FExtentY;
    ARect.Right := ARect.Right - FExtentX - GuiPyOptions.ShadowWidth;
    Posi := Pos(#13#10'{abstract}', Caption);
    if Posi > 0 then
      Name := Copy(Caption, 1, Posi - 1)
    else
      Name := Caption;
    if GuiPyOptions.ClassnameInUppercase then
      Name := UpperCase(Name);
    DrawText(Canvas.Handle, PChar(Name), Length(Name), ARect, DT_CENTER);
    if Posi > 0 then
    begin
      Canvas.Font.Style := [fsItalic];
      ARect.Top := ARect.Top + FSingleLineHeight;
      Name := '{abstract}';
      DrawText(Canvas.Handle, PChar(Name), Length(Name), ARect, DT_CENTER);
    end;

    // draw parameter
    SetColors;
    Canvas.Font.Style := [];
    Canvas.Brush.Style := bsSolid;
    Canvas.Pen.Style := psDash;
    Canvas.Pen.Color := FForegroundColor;
    ARect := Parent.ClientRect;
    NeedH := Round(Height * 0.6);
    Canvas.Brush.Color := FBackgroundColor;
    Canvas.Rectangle(ARect.Right - TextWidthParameter - 12, 0,
      ARect.Right - 8, NeedH);
    ARect := Rect(ARect.Right - TextWidthParameter - 14, (NeedH - ExtentY) div 2
      - 2, ARect.Right - 6, NeedH);
    DrawText(Canvas.Handle, PChar(FTypeAndBinding), Length(FTypeAndBinding),
      ARect, DT_CENTER);
  end
  else
    inherited;
end;

function TRtfdClassName.GetSVG(OwnerRect: TRect): string;
var
  XPos, YPos, Posi: Integer;
  Name, Attribute: string;
begin
  Attribute := ' font-weight="bold" Text-anchor="middle"';
  if FEntity.IsAbstract then
    Attribute := Attribute + ' font-style="italic"';
  XPos := OwnerRect.Width div 2;
  YPos := Top + 2 * FExtentY + Round(0.65 * FSingleLineHeight) + 1;
  Posi := Pos(#13#10'{abstract}', Caption);
  if Posi > 0 then
    Name := Copy(Caption, 1, Posi - 1)
  else
    Name := Caption;
  Result := GetSVGText(XPos, YPos, Attribute, Name);
  if Posi > 0 then
  begin
    Attribute := ' Text-anchor="middle" font-style="italic"';
    YPos := YPos + FSingleLineHeight;
    Result := Result + GetSVGText(XPos, YPos, Attribute, '{abstract}');
  end;
end;

function TRtfdClassName.GetSVGTypeAndBinding(Rect: TRect): string;
begin
  Rect := Parent.ClientRect;
  Rect.Right := Rect.Right - GuiPyOptions.ShadowWidth - 4;
  var
  SVG := GetSVGRect(Rect.Right - 2 * FExtentX, 0, 2 * FExtentX, 2 * FExtentY,
    'white', ' stroke-dasharray="1.5% 0.5%"');
  Result := SVG + GetSVGText(Rect.Right - 2 * FExtentX + 6,
    Round(2 * FExtentY * 0.7), '', FTypeAndBinding);
end;

{ TRtfdObjectName }

constructor TRtfdObjectName.Create(Owner: TComponent; Entity: TModelEntity);
begin
  inherited Create(Owner, Entity);
  if GuiPyOptions.ObjectUnderline then
    Font.Style := [fsBold, fsUnderline]
  else
    Font.Style := [fsBold];
  Alignment := taCenter;
  Entity.AddListener(IAfterObjektListener(Self));
  EntityChange(nil);
end;

destructor TRtfdObjectName.Destroy;
begin
  FEntity.RemoveListener(IAfterObjektListener(Self));
  inherited;
end;

procedure TRtfdObjectName.EntityChange(Sender: TModelEntity);
begin
  var
  Classname := (FEntity as TObjekt).GenericName;
  if GuiPyOptions.ClassnameInUppercase then
    Classname := UpperCase(Classname);
  case GuiPyOptions.ObjectCaption of
    0:
      Caption := FEntity.Name + ': ' + Classname;
    1:
      Caption := FEntity.Fullname;
  else
    Caption := ': ' + Classname;
  end;
end;

procedure TRtfdObjectName.Paint;
var
  Alig: Integer;
  Rect: TRect;
  HeadColor: TColor;
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

  HeadColor := (Owner as TRtfdBox).Canvas.Brush.Color;
  if IsColorDark(HeadColor) and IsColorDark(FForegroundColor) then
    Canvas.Font.Color := FForegroundColor
  else if not IsColorDark(HeadColor) and not IsColorDark(FForegroundColor) then
    Canvas.Font.Color := FBackgroundColor;

  Rect := ClientRect;
  Rect.Right := Rect.Right - GuiPyOptions.ShadowWidth;
  DrawText(Canvas.Handle, PChar(Caption), Length(Caption), Rect, Alig);
end;

function TRtfdObjectName.GetSVG(OwnerRect: TRect): string;
var
  XPos: Integer;
  Attribute: string;
begin
  Attribute := ' font-weight="bold" Text-anchor="middle"';
  if fsUnderline in Font.Style then
    Attribute := Attribute + ' Text-decoration="underline"';
  XPos := OwnerRect.Width div 2;
  Result := GetSVGText(XPos, Top + Height - 4, Attribute, Text);
end;

{ TRtfdInterfaceName }

constructor TRtfdInterfaceName.Create(Owner: TComponent; Entity: TModelEntity);
begin
  inherited Create(Owner, Entity);
  Font.Style := [fsBold];
  Alignment := taCenter;
  Entity.AddListener(IAfterInterfaceListener(Self));
  Caption := Entity.Name;
  FSingleLineHeight := Height;
  EntityChange(nil);
end;

destructor TRtfdInterfaceName.Destroy;
begin
  FEntity.RemoveListener(IAfterInterfaceListener(Self));
  inherited;
end;

procedure TRtfdInterfaceName.EntityChange(Sender: TModelEntity);
begin
  if (Owner as TRtfdBox).FFrame.Diagram.Package <> FEntity.Owner then
    Caption := FEntity.Fullname
  else
    Caption := FEntity.Name;
end;

function TRtfdInterfaceName.GetSVG(OwnerRect: TRect): string;
var
  XPos, YPos: Integer;
  Attribute: string;
begin
  Attribute := ' Text-anchor="middle"';
  XPos := OwnerRect.Width div 2;
  YPos := Top + Round(0.65 * FSingleLineHeight) + 1 - FSingleLineHeight;
  Result := GetSVGText(XPos, YPos, Attribute, '<<interface>>');
  Attribute := ' font-weight="bold" Text-anchor="middle"';
  YPos := YPos + FSingleLineHeight;
  Result := Result + GetSVGText(XPos, YPos, Attribute, Text);
end;

{ TRtfdSeparator }

constructor TRtfdSeparator.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Parent := Owner as TWinControl;
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

function TRtfdSeparator.GetSVG(OwnerRect: TRect): string;
begin
  Result := '  <line x1="0" y1="' + IntToStr(Top + Height div 2) + '" x2="' +
    IntToStr(OwnerRect.Width) + '" y2="' + IntToStr(Top + Height div 2) +
    '" stroke="black" />'#13#10;
end;

{ TRtfdPackageName }

constructor TRtfdUnitPackageName.Create(Owner: TComponent;
  Entity: TModelEntity);
begin
  inherited Create(Owner, Entity);
  Font.Style := [fsBold];
  Alignment := taCenter;
  FPackage := Entity as TUnitPackage;
  FPackage.AddListener(IAfterUnitPackageListener(Self));
  EntityChange(nil);
end;

destructor TRtfdUnitPackageName.Destroy;
begin
  FPackage.RemoveListener(IAfterUnitPackageListener(Self));
  inherited;
end;

procedure TRtfdUnitPackageName.EntityChange(Sender: TModelEntity);
begin
  Caption := FPackage.Name;
end;

{ TRtfdOperation }

constructor TRtfdOperation.Create(Owner: TComponent; Entity: TModelEntity);
begin
  inherited Create(Owner, Entity);
  FOperation := Entity as TOperation;
  FOperation.AddListener(IAfterOperationListener(Self));
  EntityChange(nil);
  // ParentFont:= true;  due to abstract operations not possible
end;

destructor TRtfdOperation.Destroy;
begin
  FOperation.RemoveListener(IAfterOperationListener(Self));
  inherited;
end;

// show operation, show method
procedure TRtfdOperation.EntityChange(Sender: TModelEntity);
const
  ColorMap: array [TOperationType] of TColor = (clGreen, clBlack, clGray);
  // otConstructor, otProcedure, otFunction
var
  Name: string;
  Ite: IModelIterator;
  Parameter: TParameter;
  ParameterCount: Integer;
  ShowParameter: Integer;
begin
  // Default uml-syntax
  // visibility name ( parameter-list ) : return-type-expression { property-string }
  ParameterCount := 0;
  ShowParameter := (Owner as TRtfdBox).ShowParameter;
  Name := FOperation.Name;

  if ShowParameter > 1 then
  begin
    Name := Name + '(';
    Ite := FOperation.GetParameters;
    while Ite.HasNext do
    begin
      Parameter := Ite.Next as TParameter;
      if Parameter.Name = 'self' then
        Continue;
      case ShowParameter of
        2:
          Inc(ParameterCount);
        3:
          Name := Name + Parameter.AsUMLString(3) + ', ';
        4:
          Name := Name + Parameter.AsUMLString(4) + ', ';
        5:
          Name := Name + Parameter.AsUMLString(5) + ', ';
        6:
          Name := Name + Parameter.AsUMLString(6) + ', ';
      end;
    end;
    if (ShowParameter = 2) and (ParameterCount > 0) then
      Name := Name + '...';
    if Copy(Name, Length(Name) - 1, 2) = ', ' then
      Delete(Name, Length(Name) - 1, 2); // delete last comma
    Name := Name + ')';
  end;

  if (ShowParameter > 0) and (FOperation.OperationType = otFunction) then
  begin
    Name := Name + ':';
    if Assigned(FOperation.ReturnValue) then
      Name := Name + ' ' + FOperation.ReturnValue.AsUMLType;
  end;

  if FEntity.IsAbstract and GuiPyOptions.UseAbstractForMethods then
    Name:= Name + ' {abstract}';
  Caption := Name;
  Font.Style := [];
  Font.Color := FForegroundColor;
  if FOperation.IsAbstract then
    Font.Style := [fsItalic];
end;

{ TRtfdAttribute }

constructor TRtfdAttribute.Create(Owner: TComponent; Entity: TModelEntity);
begin
  inherited Create(Owner, Entity);
  FAttribute := Entity as TAttribute;
  FAttribute.AddListener(IAfterAttributeListener(Self));
  EntityChange(Entity);
end;

destructor TRtfdAttribute.Destroy;
begin
  FAttribute.RemoveListener(IAfterAttributeListener(Self));
  inherited;
end;

procedure TRtfdAttribute.EntityChange(Sender: TModelEntity);
begin
  // uml standard syntax is:
  // visibility name [ multiplicity ] : type-expression = initial-value { property-string }
  if Sender.Owner is TObjekt then
    Caption := FAttribute.Name + ' = ' + FAttribute.Value
  else if Assigned(FAttribute.TypeClassifier) then
  begin
    var
    Name := FAttribute.Name;
    if Assigned(FAttribute.TypeClassifier) and
      ((Owner as TRtfdBox).ShowParameter >= 4) then
      Name := Name + ': ' + FAttribute.TypeClassifier.AsUMLType;
    if (FAttribute.Value <> '') and ((Owner as TRtfdBox).ShowParameter >= 5)
    then
      Name := Name + ' = ' + FAttribute.Value;
    Caption := Name;
  end
  else
    Caption := FAttribute.Name;
end;

{ TRtfdUnitPackageDiagram }

constructor TRtfdUnitPackageDiagram.Create(Owner: TComponent;
  Entity: TModelEntity);
begin
  // This class is the caption in upper left corner for a unitdiagram
  inherited Create(Owner, Entity);
  Color := clBtnFace;
  Font.Name := 'Times New Roman';
  Font.Style := [fsBold];
  Font.Size := 12;
  Alignment := taLeftJustify;
  FPackage := Entity as TUnitPackage;
  FPackage.AddListener(IAfterUnitPackageListener(Self));
  EntityChange(nil);
end;

destructor TRtfdUnitPackageDiagram.Destroy;
begin
  FPackage.RemoveListener(IAfterUnitPackageListener(Self));
  inherited;
end;

procedure TRtfdUnitPackageDiagram.EntityChange(Sender: TModelEntity);
begin
  Caption := '   ' + FPackage.Fullname;
end;

{ TRtfdInterface }

constructor TRtfdInterface.Create(Owner: TComponent; Entity: TModelEntity;
  Frame: TAFrameDiagram; MinVisibility: TVisibility);
begin
  inherited Create(Owner, Entity, Frame, MinVisibility);
  FPathname := (Entity as TInterface).Pathname;
  Entity.AddListener(IAfterInterfaceListener(Self));
  PopupMenu := Frame.PopMenuClass;
  RefreshEntities;
end;

destructor TRtfdInterface.Destroy;
begin
  FEntity.RemoveListener(IAfterInterfaceListener(Self));
  inherited;
end;

procedure TRtfdInterface.RefreshEntities;
var
  NeedW, NeedH, ATop: Integer;
  Omi, Ami: IModelIterator;
  CustomLabel: TRtfdCustomLabel;
  Separator: TRtfdSeparator;
  Intf: TInterface;
begin
  if not Visible then
    Exit;
  inherited;

  NeedW := 0;
  NeedH := 2 * BorderWidth + 2;

  Inc(NeedH, TRtfdStereotype.Create(Self, nil, 'interface').Height);
  Inc(NeedH, TRtfdInterfaceName.Create(Self, FEntity).Height);

  // Get names in visibility order
  Intf := FEntity as TInterface;
  if FMinVisibility > Low(TVisibility) then
  begin
    Ami := TModelIterator.Create(Intf.GetAttributes, TAttribute, FMinVisibility,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(Intf.GetOperations, TOperation, FMinVisibility,
      TIteratorOrder(FSortOrder));
  end
  else
  begin
    Ami := TModelIterator.Create(Intf.GetAttributes,
      TIteratorOrder(FSortOrder));
    Omi := TModelIterator.Create(Intf.GetOperations,
      TIteratorOrder(FSortOrder));
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

  for var I := 0 to ControlCount - 1 do
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      NeedW := Max(CustomLabel.TextWidth, NeedW);
    end;
  Width := Max(NeedW, CDefaultWidth);

  ATop := 4;
  for var I := 0 to ControlCount - 1 do
    if Controls[I] is TRtfdCustomLabel then
    begin
      CustomLabel := TRtfdCustomLabel(Controls[I]);
      CustomLabel.SetBounds(4, ATop, Width, CustomLabel.Height);
      ATop := ATop + CustomLabel.Height;
    end
    else if Controls[I] is TRtfdSeparator then
    begin
      Separator := TRtfdSeparator(Controls[I]);
      Separator.SetBounds(4, ATop, Width, Separator.Height);
      ATop := ATop + Separator.Height;
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
  Result := FPathname;
end;

{ TRtfdStereotype }

constructor TRtfdStereotype.Create(Owner: TComponent; Entity: TModelEntity;
  const Caption: string);
begin
  inherited Create(Owner, Entity);
  Alignment := taCenter;
  Self.Caption := '<<' + Caption + '>>';
end;

{ TRtfdCustomLabel }

constructor TRtfdCustomLabel.Create(Owner: TComponent; Entity: TModelEntity);
begin
  inherited Create(Owner);
  Parent := Owner as TWinControl;
  Canvas.Font.Assign(Font);
  Self.FEntity := Entity;
  Height := Abs(Font.Height);
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
  Alig, Posi: Integer;
  Rect: TRect;
  Str: string;
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
  Rect := ClientRect;
  Posi := Pos(#13#10'{abstract}', Caption);
  if Posi > 0 then
  begin
    Str := Copy(Caption, 1, Posi - 1);
    Canvas.Font.Style := [fsItalic, fsBold];
  end
  else
    Str := Caption;
  if GuiPyOptions.ClassnameInUppercase then
    Str := UpperCase(Str);
  DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect, Alig);
  if Posi > 0 then
  begin
    Canvas.Font.Style := [fsItalic];
    Rect.Top := Rect.Top + FSingleLineHeight;
    Str := '{abstract}';
    DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect, Alig);
  end;
end;

function TRtfdCustomLabel.GetSVG(OwnerRect: TRect): string;
begin
  Result := '';
end;

procedure TRtfdCustomLabel.SetColors;
begin
  FForegroundColor := (Parent as TRtfdBox).ForegroundColor;
  FBackgroundColor := (Parent as TRtfdBox).BackgroundColor;
  Canvas.Font.Color := FForegroundColor;
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
  DeviceContext: HDC;
  XPos: Integer;
  ARect: TRect;
  AAlignment: TAlignment;
begin
  if not(csReading in ComponentState) then
  begin
    ARect := Rect(0, 0, 0, 0);
    DeviceContext := GetDC(0);
    Canvas.Handle := DeviceContext;
    Canvas.Font.Assign(Font);
    if GuiPyOptions.RelationshipAttributesBold and (FEntity is TAttribute) then
      if (FEntity as TAttribute).Connected then
        Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    if (FEntity is TOperation) and FEntity.IsAbstract then
      Canvas.Font.Style := Canvas.Font.Style + [fsItalic];
    var
    Str := Caption;
    if (Self is TRtfdClassName) and GuiPyOptions.ClassnameInUppercase then
      Str := UpperCase(Str);
    DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_CALCRECT);
    FTextWidth := 8 + ARect.Right + 8;
    case (Owner as TRtfdBox).ShowIcons of
      0:
        FTextWidth := FTextWidth + PPIScale(ARect.Height + 8);
      1:
        FTextWidth := FTextWidth + Canvas.TextWidth('+ ');
      2:
        FTextWidth := FTextWidth + 0;
    end;
    DoDrawText(ARect, DT_EXPANDTABS or DT_CALCRECT);
    Canvas.Handle := 0;
    ReleaseDC(0, DeviceContext);
    XPos := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then
      ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then
      Inc(XPos, Width - ARect.Right);
    SetBounds(XPos, Top, FTextWidth, ARect.Bottom);
  end;
end;

procedure TRtfdCustomLabel.DoDrawText(var Rect: TRect; Flags: LongInt);
begin
  var
  AText := Caption;
  if AText = '' then
    AText := '  ';
  if (Flags and DT_CALCRECT <> 0) and ((AText = '') and (AText[1] = '&') and
    (AText[2] = #0)) then
    AText := AText + ' ';
  Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Canvas.Font.Assign(Font);
  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(AText), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(AText), Length(AText), Rect, Flags);
  end
  else
    DrawText(Canvas.Handle, PChar(AText), Length(AText), Rect, Flags);
end;

end.
