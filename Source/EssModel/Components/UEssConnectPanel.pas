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

{

  Thoughts on the representation in the UML window

  simple click/mousedown
  The background does not have to be emptied here, it is sufficient if the boxes are new
  be drawn.
  If two boxes overlap, the box you clicked on must go into the
  be brought to the fore. Therefore must in any case when clicking
  the entire box can be drawn, it is not enough just the markings
  to draw.

}

unit UEssConnectPanel;

interface

uses
  Windows,
  Messages,
  Menus,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  Contnrs,
  UUtils,
  UConnection;

const
  HANDLESIZE: Integer = 8;

type

  { Wrapper around a control managed by essConnectPanel }
  TManagedObject = class
  private
    FSelected: Boolean;
    FControl: TControl;
    // Old eventhandlers
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    procedure SetSelected(const Value: Boolean);
  public
    constructor Create;
    function SelectedBoundsRect: TRect;
    property Selected: Boolean read FSelected write SetSelected;
    property Control: TControl read FControl;
  end;

  {
    Component that manages a list of contained controls that can be connected with
    somekind of line and allows the user to move it around and gives the containd
    control grabhandles when selected.

    Further it manages the layout of the contained controls.
  }

  TEssConnectPanel = class(TCustomPanel)
  private
    FMemMousePos: TPoint;
    FSelectRect: TRect;
    FBackBitmap: TBitmap;
    FTempHidden: TObjectList;
    FBackgroundColor: TColor;
    FForegroundColor: TColor;
    FIsModified: Boolean;
    FIsMoving: Boolean;
    FUpdateCounter: Integer;
    FIsRectSelecting: Boolean;
    FSelectedOnly: Boolean;
    FResized: Boolean;
    FShowConnections: Integer;
    FMouseDownOK: Boolean;
    FMyForm: TForm;
    FOnClassEditSelectedDiagramElements: TNotifyEvent;
    FOnContentChanged: TNotifyEvent;
    FOnDeleteSelectedControls: TNotifyEvent;
    FOnFormMouseDown: TNotifyEvent;
    FOnModified: TBoolEvent;
    FPopupMenuAlign: TPopupMenu;
    FPopupMenuConnection: TPopupMenu;
    FPopupMenuWindow: TPopupMenu;

    procedure SetSelectedOnly(const Value: Boolean);
    procedure SetUpdateCounter(Value: Integer);
  protected
    FManagedObjects: TList;
    FConnections: TObjectList;
    //procedure CreateParams(var Params: TCreateParams); override;
    //procedure Click; override;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;

    procedure SelectObjectsInRect(SelRect: TRect);
    procedure OnManagedObjectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure OnManagedObjectMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectClick(Sender: TObject);
    procedure OnManagedObjectDblClick(Sender: TObject);

    function ClickOnConnection: Boolean;
    procedure HideConnections;
    procedure ShowCuttedConnections;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindManagedControl(AControl: TControl): TManagedObject;
    // Add a control to the managed list
    function AddManagedObject(AObject: TControl): TControl;
    function GetFirstManaged: TControl;
    // Returns a list containing all the managed controls.
    // The list should be freed by the caller.
    function GetManagedObjects: TList;
    function GetFirstSelected: TControl;
    // Returns a objectlist containing the selected controls.
    // The list should be freed by the caller.
    function GetSelectedControls: TObjectList;
    procedure DeleteSelectedControls;
    function CountSelectedControls: Integer;
    function HasSelectedControls: Boolean;

    // Returns a list with all interobject connections.
    // The list should be freed by the caller.
    function GetConnections: TList;
    procedure SetConnection(Num: Integer;
      Arrow: TEssConnectionArrowStyle); overload;
    procedure SetConnection(Num: Integer;
      Attributes: TConnectionAttributes); overload;
    procedure SetSelectedConnection(Attributes: TConnectionAttributes);
    function GetConnection(Num: Integer): TConnection;
    function HaveConnection(Src, Dest: TControl): Integer; overload;
    function HaveConnection(Src, Dest: TControl;
      ArrowStyle: TEssConnectionArrowStyle): Integer; overload;
    function CountConnections(Src, Dest: TControl): Integer;
    function GetRecursivConnection(Src: TControl): TConnection;
    function GetRecursivXEnlarge(Control: TControl): Integer;
    function GetRecursivYEnlarge(Control: TControl): Integer;
    function GetRecursivXDecrease(Control: TControl): Integer;
    function GetRecursivYDecrease(Control: TControl): Integer;
    procedure DeleteConnections;
    procedure DeleteSelectedConnection;
    procedure DeleteNotEditedConnections;
    procedure DeleteObjectConnections;
    function HasSelectedConnection: Boolean;
    function GetClickedConnectionNr: Integer;
    function GetClickedConnection: TConnection;
    function GetSelectedConnection: TConnection;

    // Add a connection from Src to Dst with the supplied style
    procedure ConnectObjects(Src, Dst: TControl;
      Attributes: TConnectionAttributes); overload;
    procedure ConnectObjects(Src, Dst: TControl;
      Arrow: TEssConnectionArrowStyle); overload;
    procedure EditParallelConnections;
    procedure DoConnection(Item: Integer);
    procedure DoAlign(Item: Integer);
    procedure TurnConnection(Num: Integer);
    procedure DeleteConnection(Num: Integer);
    procedure SetRecursiv(Point: TPoint; Pos: Integer);
    procedure ClearManagedObjects;
    procedure CheckRoleHidesAttribute(Conn: TConnection;
      Attributes: TConnectionAttributes);
    procedure ShowConnections;

    // Unselect all selected objects
    procedure ClearSelection(WithShowAll: Boolean = True);
    function SelectionChangedOnClear: Boolean;
    procedure ClearMarkerAndConnections(AControl: TControl);
    procedure ShowAll;
    procedure ShowAllIntersecting(Rect: TRect);
    procedure DrawMarkers(Rec: TRect; Show: Boolean);
    procedure SetFocus; override;
    procedure SelectAssociation;
    procedure ConnectBoxes(Src, Dest: TControl);
    procedure SetConnections(Value: Integer);
    procedure SetShowObjectDiagram(Show: Boolean);
    procedure GetDiagramSize(var Width, Height: Integer);
    function GetSelectedRect: TRect;
    procedure RecalcSize;
    procedure TextTo(ACanvas: TCanvas);
    function GetClipRect: TRect;
    procedure CloseEdit;
    procedure EditBox(Control: TControl);
    procedure SetModified(const Value: Boolean);
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function GetSVGConnections: string;
    procedure BeginUpdate;
    procedure EndUpdate;

    property IsModified: Boolean read FIsModified write SetModified;
    property IsMoving: Boolean read FIsMoving write FIsMoving;
    // Bitmap to be used as background for printing
    property BackBitmap: TBitmap read FBackBitmap write FBackBitmap;
    property OnContentChanged: TNotifyEvent read FOnContentChanged write
        FOnContentChanged;
    property OnModified: TBoolEvent read FOnModified write FOnModified;
    property OnDeleteSelectedControls: TNotifyEvent read FOnDeleteSelectedControls
        write FOnDeleteSelectedControls;
    property OnClassEditSelectedDiagramElements: TNotifyEvent read
        FOnClassEditSelectedDiagramElements write
        FOnClassEditSelectedDiagramElements;
    property OnFormMouseDown: TNotifyEvent read FOnFormMouseDown write
        FOnFormMouseDown;
    property PopupMenuAlign: TPopupMenu read FPopupMenuAlign write FPopupMenuAlign;
    property PopupMenuConnection: TPopupMenu read FPopupMenuConnection write
        FPopupMenuConnection;
    property PopupMenuWindow: TPopupMenu read FPopupMenuWindow write
        FPopupMenuWindow;
    // Only draw selected
    property SelectedOnly: Boolean read FSelectedOnly write SetSelectedOnly;
    property UpdateCounter: Integer read FUpdateCounter write SetUpdateCounter;
  published
    { Published declarations }
    property Align;
    property Alignment;
    property Anchors;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property FullRepaint;
    property ParentBiDiMode;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation

uses Math, Types, UITypes, StdCtrls, Themes, SysUtils,
  UModel, UModelEntity, UConfiguration, UAssociation, URtfdComponents,
  UZOrderControl;

{ --- TessConnectPanel --------------------------------------------------------- }

// http://www.delphipages.com/forum/showthread.php?t=75521
// https://www.mail-archive.com/lazarus@lists.lazarus.freepascal.org/msg08316.html
type
  TCrackControl = class(TControl);

  { TessConnectPanel }
function TEssConnectPanel.AddManagedObject(AObject: TControl): TControl;
var
  CrkObj: TCrackControl;
  NewObj: TManagedObject;
begin
  Result := nil;
  if AObject.Left + AObject.Width > Width then
    Width := Max(Width, AObject.Left + AObject.Width + 50);
  if AObject.Top + AObject.Height > Height then
    Height := Max(Height, AObject.Top + AObject.Height + 50);

  AObject.Parent := Self;
  if AObject is TRtfdObject then
    AObject.SendToBack; // !!!!!
  AObject.Visible := True;
  if FindManagedControl(AObject) = nil then
  begin
    NewObj := TManagedObject.Create;
    NewObj.FControl := AObject;
    FManagedObjects.Add(NewObj);

    CrkObj := TCrackControl(AObject);
    NewObj.FOnMouseDown := CrkObj.OnMouseDown;
    NewObj.FOnMouseMove := CrkObj.OnMouseMove;
    NewObj.FOnMouseUp := CrkObj.OnMouseUp;
    NewObj.FOnClick := CrkObj.OnClick;
    NewObj.FOnDblClick := CrkObj.OnDblClick;

    CrkObj.OnMouseDown := OnManagedObjectMouseDown;
    CrkObj.OnMouseMove := OnManagedObjectMouseMove;
    CrkObj.OnMouseUp := OnManagedObjectMouseUp;
    CrkObj.OnClick := OnManagedObjectClick;
    CrkObj.OnDblClick := OnManagedObjectDblClick;
    Result := AObject;
  end;
end;

procedure TEssConnectPanel.ClearManagedObjects;
begin
  FConnections.Clear;
  if Assigned(FManagedObjects) then
  begin
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      var
      AManagedObject := TManagedObject(FManagedObjects[I]);
      FreeAndNil(AManagedObject);
    end;
    FManagedObjects.Clear;
  end;
  SetBounds(0, 0, 0, 0);
  FIsModified := False;
end;

function TEssConnectPanel.SelectionChangedOnClear: Boolean;
begin
  Result := False;
  if Assigned(FManagedObjects) then
  begin
    for var I := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[I]).Selected and
        TManagedObject(FManagedObjects[I]).Control.Visible then
      begin
        TManagedObject(FManagedObjects[I]).Selected := False;
        Result := True;
      end;
  end;
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).Selected then
    begin
      TConnection(FConnections[I]).Selected := False;
      TConnection(FConnections[I]).DrawSelection(Canvas, False);
      Result := True;
    end;
end;

procedure TEssConnectPanel.ClearSelection(WithShowAll: Boolean = True);
begin
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      TManagedObject(FManagedObjects[I]).Selected := False;
  if Assigned(FConnections) then
    for var I := 0 to FConnections.Count - 1 do
      TConnection(FConnections[I]).Selected := False;
  if WithShowAll then
    ShowAll;
end;

procedure TEssConnectPanel.ClearMarkerAndConnections(AControl: TControl);
begin
  DrawMarkers((AControl as TRtfdBox).GetBoundsRect, False);
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := (FConnections[I] as TConnection);
    if Conn.Visible and ((Conn.FromControl = AControl) or (Conn.ToControl = AControl)) then
      Conn.Draw(Canvas, False);
  end;
end;

procedure TEssConnectPanel.ShowAll;
var
  ZOrderArr: array of Integer;
  ZNameArr: array of string;
  NextZ, Count: Integer;
  Box: TRtfdBox;
begin
  HideConnections;

  if Assigned(FManagedObjects) and (UpdateCounter = 0) then
  begin
    Count := FManagedObjects.Count;
    SetLength(ZOrderArr, Count);
    SetLength(ZNameArr, Count);
    for var I := 0 to Count - 1 do
    begin
      ZOrderArr[I] := zzGetControlZOrder(TManagedObject(FManagedObjects[I])
        .FControl);
      if (TManagedObject(FManagedObjects[I]).FControl is TRtfdBox) then
      begin
        Box := TManagedObject(FManagedObjects[I]).FControl as TRtfdBox;
        ZNameArr[I] := Box.Entity.Name + '-' + IntToStr(ZOrderArr[I]);
      end;
    end;
    ShowConnections;

    NextZ := 0;
    for var I := 0 to Count - 1 do
    begin
      var Pos := MaxInt;
      for var J := 0 to Count - 1 do
        if ZOrderArr[J] = NextZ then
        begin
          Pos := J;
          Break;
        end;
      if (Pos <= Count - 1) and TManagedObject(FManagedObjects[Pos]).FControl.Visible
      then
      begin
        Box := TManagedObject(FManagedObjects[Pos]).FControl as TRtfdBox;
        Box.Paint;
      end;
      Inc(NextZ);
    end;
  end;
end;

procedure TEssConnectPanel.CloseEdit;
begin
  if Assigned(FManagedObjects) then
  begin
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      var
      Box := TManagedObject(FManagedObjects[I]).FControl as TRtfdBox;
      Box.CloseEdit;
    end;
  end;
end;

procedure TEssConnectPanel.EditBox(Control: TControl);
begin
  if Assigned(FOnClassEditSelectedDiagramElements) then
    FOnClassEditSelectedDiagramElements(Control);
end;

procedure TEssConnectPanel.ShowAllIntersecting(Rect: TRect);
// https://wiki.lazarus.freepascal.org/Developing_with_Graphics#Motion_Graphics_-_How_to_Avoid_flickering

  function Intersect(const Rect1, Rect2: TRect): Boolean;
  begin
    Result := not((Rect1.BottomRight.X <= Rect2.TopLeft.X) or
      (Rect1.BottomRight.Y <= Rect2.TopLeft.Y) or (Rect2.BottomRight.X <= Rect1.TopLeft.X)
      or (Rect2.BottomRight.Y <= Rect1.TopLeft.Y));
  end;

begin
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      var
      AControl := TManagedObject(FManagedObjects[I]).Control;
      if AControl.Visible and Intersect(Rect, AControl.BoundsRect) then
        AControl.Invalidate;
    end;
end;

procedure TEssConnectPanel.DrawMarkers(Rec: TRect; Show: Boolean);

  procedure MarkerPart(X, Y: Integer);
  var
    Rec: TRect;
  begin
    Rec := Rect(X, Y, X + HANDLESIZE, Y + HANDLESIZE);
    Canvas.FillRect(Rec);
  end;

begin
  with Canvas do
  begin
    InflateRect(Rec, HANDLESIZE, HANDLESIZE);
    if Show then
      Brush.Color := FForegroundColor
    else
      Brush.Color := FBackgroundColor;
    MarkerPart(Rec.Left, Rec.Top);
    MarkerPart(Rec.Right - HANDLESIZE, Rec.Top);
    MarkerPart(Rec.Right - HANDLESIZE, Rec.Bottom - HANDLESIZE);
    MarkerPart(Rec.Left, Rec.Bottom - HANDLESIZE);
  end;
end;

procedure TEssConnectPanel.CMMouseLeave(var Message: TMessage);
var
  Point: TPoint;
  Rect: TRect;
begin
  Point := Mouse.CursorPos;
  IntersectRect(Rect, Parent.ClientRect, BoundsRect);
  Rect.TopLeft := Parent.ClientToScreen(Rect.TopLeft);
  Rect.BottomRight := Parent.ClientToScreen(Rect.BottomRight);
  if not PtInRect(Rect, Point) and not FIsRectSelecting then
    ReleaseCapture;
end;

procedure TEssConnectPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  var
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := Message.DC;
    if Assigned(FBackBitmap) then
      Canvas.Brush.Bitmap := FBackBitmap
    else
      Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  finally
    FreeAndNil(Canvas);
  end;
  Message.Result := 1;
end;

procedure TEssConnectPanel.EditParallelConnections;
var
  ParallelIndex, ParallelCount: Integer;
  Conn1, Conn2: TConnection;
begin
  for var I := 0 to FConnections.Count - 1 do
  begin
    Conn1 := TConnection(FConnections[I]);
    Conn1.ParallelIndex := 0;
    Conn1.ParallelCount := 0;
    Conn1.ParallelVisited := False;
    Conn1.ParallelVisiting := False;
  end;
  for var I := 0 to FConnections.Count - 2 do
  begin
    Conn1 := TConnection(FConnections[I]);
    if not Conn1.ParallelVisited then
    begin
      for var J := I + 1 to FConnections.Count - 1 do
      begin
        Conn2 := TConnection(FConnections[J]);
        if (Conn1.FromControl = Conn2.FromControl) and (Conn1.ToControl = Conn2.ToControl) or
          (Conn1.FromControl = Conn2.ToControl) and (Conn1.ToControl = Conn2.FromControl) then
        begin
          Conn1.ParallelCount:= Conn1.ParallelCount + 1;
          Conn2.ParallelVisiting := True; // simplify second search
        end;
      end;
      ParallelIndex := 0;
      ParallelCount := Conn1.ParallelCount;
      if ParallelCount > 0 then
        for var J := I + 1 to FConnections.Count - 1 do
        begin
          Conn2 := TConnection(FConnections[J]);
          if not Conn2.ParallelVisited and Conn2.ParallelVisiting then
          begin
            Conn2.ParallelVisited := True;
            Inc(ParallelIndex);
            Conn2.ParallelIndex := ParallelIndex;
            Conn2.ParallelCount := ParallelCount;
          end;
        end;
      Conn1.ParallelVisited := True;
    end;
  end;
  for var I := 0 to FConnections.Count - 1 do
    TConnection(FConnections[I]).ParallelCorrection;
end;

procedure TEssConnectPanel.ConnectObjects(Src, Dst: TControl;
  Attributes: TConnectionAttributes);
begin
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) then
  begin
    var
    Conn := TConnection.Create(Src, Dst, Attributes, Canvas);
    if GuiPyOptions.RoleHidesAttribute then
      CheckRoleHidesAttribute(Conn, Attributes);
    FConnections.Add(Conn);
    EditParallelConnections;
  end;
end;

procedure TEssConnectPanel.ConnectObjects(Src, Dst: TControl;
  Arrow: TEssConnectionArrowStyle);
begin
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) and
    (HaveConnection(Src, Dst, Arrow) = -1) then
  begin
    var
    Attributes := TConnectionAttributes.Create;
    try
      Attributes.ArrowStyle := Arrow;
      if Src = Dst then
        Attributes.RecursivCorner := 1;
      Attributes.Visible := (FShowConnections = 0) or
        ((FShowConnections = 1) and (Src.ClassType = Dst.ClassType));
      if Arrow = asComment then
        Attributes.IsEdited := True;

      ConnectObjects(Src, Dst, Attributes);
    finally
      FreeAndNil(Attributes);
    end;
    ClearSelection(False);
  end;
end;

procedure TEssConnectPanel.DeleteObjectConnections;
begin
  for var I := FConnections.Count - 1 downto 0 do
  begin
    var
    Conn := TConnection(FConnections[I]);
    if (Conn.FromControl is TRtfdObject) and (Conn.ToControl is TRtfdObject) then
      FConnections.Delete(I);
  end;
  EditParallelConnections;
end;

function TEssConnectPanel.GetRecursivConnection(Src: TControl): TConnection;
begin
  var
  Num := HaveConnection(Src, Src);
  if Num > -1 then
    Result := TConnection(FConnections[Num])
  else
    Result := nil;
end;

procedure TEssConnectPanel.DeleteConnections;
begin
  FConnections.Clear;
end;

constructor TEssConnectPanel.Create(AOwner: TComponent);
begin
  inherited;
  Name := 'TessConnectPanel';
  FMyForm := AOwner as TForm;
  FManagedObjects := TList.Create;
  FConnections := TObjectList.Create(True);
  FShowConnections := 0;
  FTempHidden := TObjectList.Create(False);
  UseDockManager := True;
  FMouseDownOK := True;
  FUpdateCounter := 0;
  ChangeStyle;
  SetFocus;
end;

procedure TEssConnectPanel.DblClick;
begin
  inherited;
  var
  Found := FindVCLWindow(Mouse.CursorPos);
  if Assigned(Found) then
  begin
    FindManagedControl(Found);
    if Found <> Self then
      TCrackControl(Found).DblClick;
    if GetClickedConnectionNr <> -1 then
      SelectAssociation;
  end;
end;

function TEssConnectPanel.GetClickedConnectionNr: Integer;
begin
  var
  Point := Self.ScreenToClient(Mouse.CursorPos);
  Result := 0;
  while Result < FConnections.Count do
  begin
    var
    Conn := TConnection(FConnections[Result]);
    if Conn.IsClicked(Point) then
      Exit;
    Inc(Result);
  end;
  Result := -1;
end;

function TEssConnectPanel.GetClickedConnection: TConnection;
begin
  var
  Num := GetClickedConnectionNr;
  if Num <> -1 then
    Result := TConnection(FConnections[Num])
  else
    Result := nil;
end;

function TEssConnectPanel.ClickOnConnection: Boolean;
begin
  var
  Num := GetClickedConnectionNr;
  Result := (Num <> -1);
end;

procedure TEssConnectPanel.TurnConnection(Num: Integer);
begin
  TConnection(FConnections[Num]).Turn;
end;

procedure TEssConnectPanel.DeleteConnection(Num: Integer);
begin
  var
  Conn := TConnection(FConnections[Num]);
  Conn.Selected := False;
  Conn.DrawSelection(Canvas, False);
  Conn.Draw(Canvas, False);
  FConnections.Delete(Num);
end;

procedure TEssConnectPanel.SetRecursiv(Point: TPoint; Pos: Integer);
begin
  Point := Self.ScreenToClient(Point);
  var
  Int := 0;
  while Int < FConnections.Count do
  begin
    var
    Conn := TConnection(FConnections[Int]);
    if Conn.IsClicked(Point) then
      Break;
    Inc(Int);
  end;
  if (Int < FConnections.Count) then
  begin
    TConnection(FConnections[Int]).SetRecursivPosition(Pos);
    Invalidate;
  end;
end;

procedure TEssConnectPanel.SelectAssociation;
begin
  var
  FAssociation := TFAssociation.Create(Self);
  try
    var
    Conn := GetSelectedConnection;
    var
    SelectedControls := CountSelectedControls;
    if not Assigned(Conn) then
      case SelectedControls of
        1:
          FAssociation.Init(False, Conn, 1);
        2:
          FAssociation.Init(False, Conn, 2);
      else
        Exit;
      end
    else
      FAssociation.Init(False, Conn, SelectedControls);
    case FAssociation.ShowModal of
      mrOk:
        begin
          var
          Attributes := FAssociation.GetConnectionAttributes;
          if HasSelectedConnection then
            SetSelectedConnection(Attributes)
          else
          begin
            var
            Tmp := GetSelectedControls;
            case Tmp.Count of
              1:
                ConnectObjects(Tmp[0] as TControl, Tmp[0] as TControl,
                  Attributes);
              2:
                ConnectObjects(Tmp[0] as TControl, Tmp[1] as TControl,
                  Attributes);
            end;
            FreeAndNil(Tmp);
          end;
          FreeAndNil(Attributes);
        end;
      mrYes: // turn
        for var I := 0 to FConnections.Count - 1 do
          if TConnection(FConnections[I]).Selected then
            TurnConnection(I);
      mrNo:
        DeleteSelectedConnection;
    end;
    Invalidate;
    ShowAll;
    IsModified := True;
  finally
    FAssociation.Release;
  end;
end;

procedure TEssConnectPanel.ConnectBoxes(Src, Dest: TControl);
begin
  var
  FAssociation := TFAssociation.Create(Self);
  try
    var
    SelectedControls := CountSelectedControls;
    case SelectedControls of
      1:
        FAssociation.Init(False, nil, 1);
      2:
        FAssociation.Init(False, nil, 2);
    else
      Exit;
    end;
    if Dest is TRtfdCommentBox then
    begin
      var
      Attributes := FAssociation.GetConnectionAttributes;
      Attributes.ArrowStyle := asComment;
      ConnectObjects(Src, Dest, Attributes);
      FreeAndNil(Attributes);
    end
    else if FAssociation.ShowModal = mrOk then
    begin
      var
      Attributes := FAssociation.GetConnectionAttributes;
      case SelectedControls of
        1:
          ConnectObjects(Src, Src, Attributes);
        2:
          ConnectObjects(Src, Dest, Attributes);
      end;
      FreeAndNil(Attributes);
    end;
    ClearSelection(True);
    IsModified := True;
  finally
    FAssociation.Release;
  end;
end;

procedure TEssConnectPanel.DoConnection(Item: Integer);
begin
  var
  Num := -1;
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).Selected then
      Num := I;
  if Num <> -1 then
  begin
    case Item of
      0 .. 9:
        SetConnection(Num, TEssConnectionArrowStyle(Item));
      10:
        SelectAssociation;
      11:
        TurnConnection(Num);
    else
      begin
        DeleteConnection(Num);
        EditParallelConnections;
      end;
    end;
    ShowAll;
    FIsModified := True;
  end;
end;

procedure TEssConnectPanel.DoAlign(Item: Integer);
var
  ALeft, Right, ATop, Bottom, VMiddle, HMiddle: Integer;
  Control: TControl;
begin
  if not Assigned(FManagedObjects) then
    Exit;
  ALeft := +MaxInt;
  Right := -MaxInt;
  ATop := +MaxInt;
  Bottom := -MaxInt;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
    begin
      Control := TManagedObject(FManagedObjects[I]).Control;
      if Control.Left < ALeft then
        ALeft := Control.Left;
      if Control.Left + Control.Width > Right then
        Right := Control.Left + Control.Width;
      if Control.Top < ATop then
        ATop := Control.Top;
      if Control.Top + Control.Height > Bottom then
        Bottom := Control.Top + Control.Height;
    end;
  HMiddle := (ALeft + Right) div 2;
  VMiddle := (ATop + Bottom) div 2;
  for var I := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[I]).FSelected then
    begin
      Control := TManagedObject(FManagedObjects[I]).Control;
      case Item of
        1:
          Control.Left := ALeft;
        2:
          Control.Left := HMiddle - Control.Width div 2;
        // - Control.Width mod 2;
        3:
          Control.Left := Right - Control.Width;
        4:
          Control.Top := ATop;
        5:
          Control.Top := VMiddle - Control.Height div 2;
        // - Control.Height mod 2;
        6:
          Control.Top := Bottom - Control.Height;
      end;
    end;
  Invalidate;
end;

destructor TEssConnectPanel.Destroy;
begin
  FreeAndNil(FTempHidden);
  ClearManagedObjects;
  FreeAndNil(FManagedObjects);
  FreeAndNil(FConnections);
  inherited;
end;

function TEssConnectPanel.FindManagedControl(AControl: TControl)
  : TManagedObject;
begin
  Result := nil;
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      var
      Curr := TManagedObject(FManagedObjects[I]);
      if Curr.FControl = AControl then
      begin
        Result := Curr;
        Exit;
      end;
    end;
end;

function TEssConnectPanel.GetConnections: TList;
begin
  Result := TList.Create;
  for var I := 0 to FConnections.Count - 1 do
    Result.Add(FConnections[I]);
end;

procedure TEssConnectPanel.SetConnection(Num: Integer;
  Attributes: TConnectionAttributes);
begin
  if (0 <= Num) and (Num < FConnections.Count) then
    TConnection(FConnections[Num]).SetAttributes(Attributes);
end;

procedure TEssConnectPanel.SetConnection(Num: Integer;
  Arrow: TEssConnectionArrowStyle);
begin
  if (0 <= Num) and (Num < FConnections.Count) then
    TConnection(FConnections[Num]).SetArrow(Arrow);
end;

procedure TEssConnectPanel.SetSelectedConnection
  (Attributes: TConnectionAttributes);
begin
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).Selected then
    begin
      var
      Conn := TConnection(FConnections[I]);
      if GuiPyOptions.RoleHidesAttribute then
        CheckRoleHidesAttribute(Conn, Attributes);
      Conn.SetAttributes(Attributes);
    end;
end;

function TEssConnectPanel.GetConnection(Num: Integer): TConnection;
begin
  Result := TConnection(FConnections[Num]);
end;

procedure TEssConnectPanel.DeleteSelectedConnection;
begin
  for var I := FConnections.Count - 1 downto 0 do
    if TConnection(FConnections[I]).Selected then
    begin
      DeleteConnection(I);
      IsModified := True;
    end;
  EditParallelConnections;
end;

procedure TEssConnectPanel.DeleteNotEditedConnections;
begin
  for var I := FConnections.Count - 1 downto 0 do
  begin
    var
    Conn := TConnection(FConnections[I]);
    if not Conn.IsEdited then
      FConnections.Delete(I);
  end;
  EditParallelConnections;
end;

function TEssConnectPanel.HasSelectedConnection: Boolean;
begin
  Result := False;
  for var I := FConnections.Count - 1 downto 0 do
    if TConnection(FConnections[I]).Selected then
    begin
      Result := True;
      Break;
    end;
end;

function TEssConnectPanel.GetSelectedConnection: TConnection;
begin
  Result := nil;
  for var I := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[I]).Selected then
    begin
      Result := TConnection(FConnections[I]);
      Exit;
    end;
end;

function TEssConnectPanel.HaveConnection(Src, Dest: TControl): Integer;
begin
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := TConnection(FConnections[I]);
    if ((Conn.FromControl = Src) and (Conn.ToControl = Dest)) or
      ((Conn.FromControl = Dest) and (Conn.ToControl = Src)) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TEssConnectPanel.HaveConnection(Src, Dest: TControl;
  ArrowStyle: TEssConnectionArrowStyle): Integer;
begin
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := TConnection(FConnections[I]);
    if (Conn.FromControl = Src) and (Conn.ToControl = Dest) and
      (Conn.ArrowStyle = ArrowStyle) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TEssConnectPanel.CountConnections(Src, Dest: TControl): Integer;
begin
  Result := 0;
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := TConnection(FConnections[I]);
    if ((Conn.FromControl = Src) and (Conn.ToControl = Dest)) or
      ((Conn.FromControl = Dest) and (Conn.ToControl = Src)) then
      Inc(Result);
  end;
end;

function TEssConnectPanel.GetRecursivXEnlarge(Control: TControl): Integer;
var
  Conn: TConnection;
  DLeft, DRight: Integer;
begin
  DLeft := 0;
  DRight := 0;
  for var I := 0 to FConnections.Count - 1 do
  begin
    Conn := TConnection(FConnections[I]);
    if Conn.IsRecursiv and ((Conn.FromControl = Control) or (Conn.ToControl = Control)) then
    begin
      DLeft := Max(DLeft, Conn.XDecrease);
      DRight := Max(DRight, Conn.XEnlarge);
    end;
  end;
  Result := DLeft + DRight;
end;

function TEssConnectPanel.GetRecursivYEnlarge(Control: TControl): Integer;
var
  Conn: TConnection;
  DTop, DBottom: Integer;
begin
  DTop := 0;
  DBottom := 0;
  for var I := 0 to FConnections.Count - 1 do
  begin
    Conn := TConnection(FConnections[I]);
    if Conn.IsRecursiv and ((Conn.FromControl = Control) or (Conn.ToControl = Control)) then
    begin
      DTop := Max(DTop, Conn.YDecrease);
      DBottom := Max(DBottom, Conn.YEnlarge);
    end;
  end;
  Result := DTop + DBottom;
end;

function TEssConnectPanel.GetRecursivXDecrease(Control: TControl): Integer;
begin
  var
  Conn := GetRecursivConnection(Control);
  if Assigned(Conn) then
    Result := Conn.XDecrease
  else
    Result := 0;
end;

function TEssConnectPanel.GetRecursivYDecrease(Control: TControl): Integer;
begin
  var
  Conn := GetRecursivConnection(Control);
  if Assigned(Conn) then
    Result := Conn.YDecrease
  else
    Result := 0;
end;

function TEssConnectPanel.GetFirstManaged: TControl;
begin
  if FManagedObjects.Count > 0 then
    Result := TManagedObject(FManagedObjects[0]).FControl
  else
    Result := nil;
end;

function TEssConnectPanel.GetManagedObjects: TList;
begin
  Result := TList.Create;
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      Result.Add(TManagedObject(FManagedObjects[I]).FControl);
end;

function TEssConnectPanel.CountSelectedControls: Integer;
begin
  var
  Num := 0;
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[I]).FSelected then
        Inc(Num);
  Result := Num;
end;

function TEssConnectPanel.HasSelectedControls: Boolean;
begin
  Result := False;
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[I]).FSelected then
        Exit(True);
end;

function TEssConnectPanel.GetFirstSelected: TControl;
begin
  Result := nil;
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[I]).FSelected then
        Exit(TManagedObject(FManagedObjects[I]).FControl);
end;

function TEssConnectPanel.GetSelectedControls: TObjectList;
begin
  Result := TObjectList.Create(False);
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[I]).FSelected then
        Result.Add(TManagedObject(FManagedObjects[I]).FControl);
end;

procedure TEssConnectPanel.DeleteSelectedControls;
var
  Control: TControl;
  Conn: TConnection;
  ManagedObject: TManagedObject;
begin
  if Assigned(FManagedObjects) then
    for var I := FManagedObjects.Count - 1 downto 0 do
      if TManagedObject(FManagedObjects[I]).FSelected then
      begin
        ManagedObject := TManagedObject(FManagedObjects[I]);
        Control := TManagedObject(FManagedObjects[I]).FControl;
        for var J := FConnections.Count - 1 downto 0 do
        begin
          Conn := TConnection(FConnections[J]);
          if (Conn.FromControl = Control) or (Conn.ToControl = Control) then
            FConnections.Delete(J);
        end;
        FManagedObjects.Delete(I);
        FreeAndNil(ManagedObject);
        IsModified := True;
      end;
  EditParallelConnections;
  RecalcSize;
  ClearSelection(False);
end;

// central MouseDown routine for TessConnectPanel
procedure TEssConnectPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Found: TControl;
  MCont: TManagedObject;
  CConn: TConnection;
  AChanged: Boolean;
  Box: TRtfdBox;
begin
  if not FMouseDownOK then
  begin
    FMouseDownOK := True;
    Exit;
  end;
  if not(ssDouble in Shift) then
    CloseEdit;
  // repaint TrMemo
  if Assigned(Application.MainForm.ActiveControl) and
    (Application.MainForm.ActiveControl is TMemo) then
    (Application.MainForm.ActiveControl as TMemo).Parent.Invalidate;
  if not Focused and Assigned(FOnFormMouseDown) then
    FOnFormMouseDown(Self);
  SetFocus; // a TPanel can have the Focus
  if GetCaptureControl <> Self then
    SetCaptureControl(Self);
  FIsRectSelecting := False;
  FIsMoving := False;
  FResized := False;
  FMemMousePos.X := X;
  FMemMousePos.Y := Y;
  AChanged := False;

  if (Button = mbRight) and (CountSelectedControls > 1) then
    FPopupMenuAlign.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
  else
  begin
    Found := FindVCLWindow(Mouse.CursorPos);
    if Found = Self then
      Found := nil;
    if Assigned(Found) then
    begin
      MCont := FindManagedControl(Found);
      if Assigned(MCont) then
      begin
        if not MCont.Selected then
        begin
          if (MCont.FControl is TRtfdBox) then
          begin
            Box := MCont.FControl as TRtfdBox;
            Box.BringToFront;
          end;
          if not CtrlPressed then
            SelectionChangedOnClear;
          if MCont.Control.Visible then
          begin
            MCont.Selected := True;
            AChanged := True;
          end;
        end
        else if CtrlPressed then
        begin
          MCont.Selected := False;
          AChanged := True;
        end;
        if AChanged then
          ShowAll;
        if CountSelectedControls > 0 then
          FIsMoving := True;
      end;
    end
    else
    begin
      CConn := GetClickedConnection;
      if Assigned(CConn) then
      begin
        if not CConn.Selected then
        begin
          if not CtrlPressed then
            SelectionChangedOnClear;
          CConn.Selected := True;
          AChanged := True;
        end
        else if CtrlPressed then
        begin
          CConn.Selected := False;
          AChanged := True;
        end;
        if AChanged then
          ShowAll;
      end
      else
      begin
        if SelectionChangedOnClear then
          ShowAll;
        if Button = mbLeft then
          FIsRectSelecting := True;
      end;
    end;
  end;
  if FIsRectSelecting then
  begin
    FSelectRect.TopLeft := FMemMousePos;
    FSelectRect.BottomRight := FMemMousePos;
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := clSilver;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
  end;
end;

procedure TEssConnectPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Point, Point1, Point2: TPoint;
  Found, Src: TControl;
  MCont: TManagedObject;
  DeltaX, DeltaY, SelControls, HandleShadow, NewLeft, NewTop, AWidth, AHeight: Integer;
  Curr: TCrackControl;
  Rect1, Rect2, MovedRect, MRectDxDy: TRect;
  Resized: Boolean;

  procedure InMakeVisible(Rect: TRect);
  var
    Mdx, Mdy: Integer;
    Point: TPoint;
  begin
    Mdx := TScrollBox(Parent).HorzScrollBar.Position;
    Mdy := TScrollBox(Parent).VertScrollBar.Position;

    if (DeltaX > 0) and (Rect.BottomRight.X >= TScrollBox(Parent)
      .HorzScrollBar.Position + Parent.Width) then
      TScrollBox(Parent).HorzScrollBar.Position := Rect.BottomRight.X -
        Parent.Width;

    if (DeltaY > 0) and (Rect.BottomRight.Y >= TScrollBox(Parent)
      .VertScrollBar.Position + Parent.Height) then
      TScrollBox(Parent).VertScrollBar.Position := Rect.BottomRight.Y -
        Parent.Height;

    if (DeltaX < 0) and (Rect.Left <= TScrollBox(Parent).HorzScrollBar.Position) then
      TScrollBox(Parent).HorzScrollBar.Position := Rect.Left;

    if (DeltaY < 0) and (Rect.Top <= TScrollBox(Parent).VertScrollBar.Position) then
      TScrollBox(Parent).VertScrollBar.Position := Rect.Top;

    Mdy := Mdy - TScrollBox(Parent).VertScrollBar.Position;
    Mdx := Mdx - TScrollBox(Parent).HorzScrollBar.Position;

    if (Mdx <> 0) or (Mdy <> 0) then
    begin
      Point := Mouse.CursorPos;
      Point.X := Point.X + Mdx;
      Point.Y := Point.Y + Mdy;
      Mouse.CursorPos := Point;
      Resized := True;
    end;
  end;

  function Intersect(const Rect1, Rect2: TRect): Boolean;
  begin
    Result := not((Rect1.BottomRight.X <= Rect2.TopLeft.X) or
      (Rect1.BottomRight.Y <= Rect2.TopLeft.Y) or (Rect2.BottomRight.X <= Rect1.TopLeft.X)
      or (Rect2.BottomRight.Y <= Rect1.TopLeft.Y));
  end;

  procedure ShowConnectionsAndMarkers(Show: Boolean);
  var
    AControl: TControl;
    Connect, AConnection: TConnection;
    SrcRect: TRect;
  begin
    Src := MCont.FControl;

    // for all moved connections
    for var K := 0 to FConnections.Count - 1 do
    begin
      Connect := TConnection(FConnections[K]);
      if Connect.Visible and Connect.ToControl.Visible and Connect.FromControl.Visible and
        ((Connect.FromControl = Src) or (Connect.ToControl = Src)) then
      begin
        // hide/show moved connection
        Connect.Draw(Canvas, Show);

        // invalidate Cutted controls
        for var I := 0 to FManagedObjects.Count - 1 do
        begin
          AControl := TManagedObject(FManagedObjects[I]).Control;
          if AControl.Visible and Connect.Square.Intersects(AControl.BoundsRect)
          then
            (AControl as TRtfdBox).Paint; // invalidate
        end;

        // mark Cutted connections
        if Show then
          for var I := 0 to FConnections.Count - 1 do
          begin
            AConnection := TConnection(FConnections[I]);
            if (I <> K) and AConnection.Visible and
              AConnection.Square.Intersects(Connect.Square) then
              AConnection.Cutted := True;
          end;
      end;
    end;

    // for the moved control
    SrcRect := Src.BoundsRect;
    SrcRect.Inflate(HANDLESIZE, HANDLESIZE);
    // invalidate all Cutted controls
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      AControl := TManagedObject(FManagedObjects[I]).Control;
      if AControl.Visible and (AControl <> Src) and
        Intersect(TManagedObject(FManagedObjects[I]).SelectedBoundsRect, SrcRect)
      then
        (AControl as TRtfdBox).Paint;
    end;

    if Show then
      for var I := 0 to FConnections.Count - 1 do
      begin
        AConnection := TConnection(FConnections[I]);
        if AConnection.Visible and AConnection.ToControl.Visible and
          AConnection.FromControl.Visible and
          not((AConnection.FromControl = Src) or (AConnection.ToControl = Src)) and
          AConnection.Square.Intersects(SrcRect) then
          // mark Cutted connections of moved control
          AConnection.Cutted := True;
      end;

    if not(MCont.FControl is TRtfdCommentBox) then
      DrawMarkers((MCont.FControl as TRtfdBox).GetBoundsRect, Show);
  end;

begin // of MouseMove
  inherited;

  if Shift = [] then
    Exit;
  Point1 := Mouse.CursorPos;
  Point.X := X;
  Point.Y := Y;
  DeltaX := Point.X - FMemMousePos.X;
  DeltaY := Point.Y - FMemMousePos.Y;
  if (DeltaX = 0) and (DeltaY = 0) then
    Exit;

  IntersectRect(Rect1, Parent.ClientRect, BoundsRect);
  Rect1.TopLeft := Parent.ClientToScreen(Rect1.TopLeft);
  Rect1.BottomRight := Parent.ClientToScreen(Rect1.BottomRight);

  if (not PtInRect(Rect1, Point1)) and (not(FIsRectSelecting or FIsMoving)) then
    ReleaseCapture
  else
  begin
    Found := FindVCLWindow(Point1);
    if FIsRectSelecting then
    begin
      FMemMousePos := Point;
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Color := clSilver;
      Canvas.Pen.Mode := pmXor;
      Canvas.Pen.Width := 0;
      Canvas.Rectangle(FSelectRect);
      FSelectRect.BottomRight := FMemMousePos;
      Canvas.Rectangle(FSelectRect);
    end
    else if ssLeft in Shift then
    begin
      // Move the selected boxes
      if (Abs(DeltaX) + Abs(DeltaY) > 5) or FIsMoving then
      begin
        Resized := False;
        MovedRect := Rect(MaxInt, 0, 0, 0);
        SelControls := CountSelectedControls;
        HandleShadow := Max(HANDLESIZE - GuiPyOptions.ShadowWidth, 0);

        if Assigned(FManagedObjects) then
          for var I := 0 to FManagedObjects.Count - 1 do
          begin
            MCont := TManagedObject(FManagedObjects[I]);
            if MCont.Control.Visible and MCont.Selected then
            begin
              ShowConnectionsAndMarkers(False);
              Curr := TCrackControl(MCont.FControl);
              MRectDxDy := Curr.BoundsRect;
              MRectDxDy.TopLeft.Offset(-HANDLESIZE, -HANDLESIZE);
              MRectDxDy.BottomRight.Offset(HandleShadow, HandleShadow);

              if (MCont.FControl is TRtfdCommentBox) and (SelControls = 1) then
                (MCont.FControl as TRtfdCommentBox)
                  .CommentMouseMove(ClientToScreen(FMemMousePos),
                  ClientToScreen(Point))
              else
              begin
                NewLeft := Curr.Left;
                NewTop := Curr.Top;
                if (DeltaX <> 0) and
                  (Curr.Left + DeltaX >= GetRecursivXDecrease(MCont.FControl)) then
                  NewLeft := Curr.Left + DeltaX;
                if (DeltaY <> 0) and
                  (Curr.Top + DeltaY >= GetRecursivYDecrease(MCont.FControl)) then
                  NewTop := Curr.Top + DeltaY;
                if (NewLeft <> Curr.Left) or (NewTop <> Curr.Top) then
                  Curr.SetBounds(NewLeft, NewTop, Curr.Width, Curr.Height);
              end;

              Rect2 := Curr.BoundsRect;
              Rect2.TopLeft.Offset(-HANDLESIZE, -HANDLESIZE);
              Rect2.BottomRight.Offset(HandleShadow, HandleShadow);
              MRectDxDy.Union(Rect2);

              // scrolling
              if Curr.Left + Curr.Width + 30 > Width then
              begin
                Width := Curr.Left + Curr.Width + 30;
                Resized := True;
              end;
              if Curr.Top + Curr.Height + 30 > Height then
              begin
                Height := Curr.Top + Curr.Height + 30;
                // ToDo wird nicht vergrößert
                Resized := True;
              end;

              if MovedRect.Left = MaxInt then
                MovedRect := MRectDxDy
              else
                UnionRect(MovedRect, MRectDxDy, MovedRect);
              // debug
              // Canvas.Brush.Color:= clRed;
              // Canvas.FrameRect(MovedRect);
              ShowConnectionsAndMarkers(True);
              ShowAll; // (MCont.FControl as TRtfdBox).Paint;
            end;
          end;

        GetDiagramSize(AWidth, AHeight);
        TScrollBox(Parent).HorzScrollBar.Visible := AWidth + 5 > Parent.Width;
        TScrollBox(Parent).VertScrollBar.Visible := AHeight + 5 > Parent.Height;
        // debug
        // Canvas.Brush.Color:= clRed;
        // Canvas.FrameRect(MovedRect);

        IsModified := True;
        FMemMousePos := Point;
        FIsMoving := True;

        if MovedRect.Left <> MaxInt then
          InMakeVisible(MovedRect);
        if Resized then
        begin
          Invalidate;
          // doesn't call paint in all cases, so ShowConnections is ensured
          Application.ProcessMessages; // ensures that invalidate is acomplished
          ShowConnections;
        end
        else
          ShowCuttedConnections;
      end
      else if Assigned(Found) then
      begin
        if Assigned(TCrackControl(Found).OnMouseMove) then
        begin
          Point2 := Found.ScreenToClient(Point);
          TCrackControl(Found).OnMouseMove(Found, Shift, Point2.X, Point2.Y);
        end;
      end;
    end;
  end;
end;

procedure TEssConnectPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Point1, Point2: TPoint;
  Rect: TRect;
  Found: TControl;
begin
  inherited;
  FIsMoving := False;
  Point1.X := X;
  Point1.Y := Y;
  IntersectRect(Rect, Parent.ClientRect, BoundsRect);
  Rect.TopLeft := Parent.ClientToScreen(Rect.TopLeft);
  Rect.BottomRight := Parent.ClientToScreen(Rect.BottomRight);
  Rect.TopLeft := ScreenToClient(Rect.TopLeft);
  Rect.BottomRight := ScreenToClient(Rect.BottomRight);

  if FIsRectSelecting then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
    Canvas.Rectangle(FSelectRect);
    SelectObjectsInRect(FSelectRect);
    Canvas.Brush.Color := FBackgroundColor;
    Canvas.Brush.Style := bsSolid;
    Canvas.Pen.Color := FForegroundColor;
    Canvas.Pen.Mode := pmCopy;
    ShowAll;
  end
  else
  begin
    ReleaseCapture;
    if PtInRect(Rect, Point1) then
    begin
      // if GetCaptureControl <> Self then     SetCaptureControl(Self);
      Found := FindVCLWindow(Mouse.CursorPos);
      if Assigned(Found) and (Found <> Self) and Found.Visible then
      begin
        if (Found is TMemo) then
          Found := (Found as TMemo).Parent;

        if Assigned(TCrackControl(Found).PopupMenu) and (Button = mbRight) then
          TCrackControl(Found).PopupMenu.Popup(Mouse.CursorPos.X,
            Mouse.CursorPos.Y);

        if Assigned(TCrackControl(Found).OnMouseUp) then
        begin
          Point2 := Found.ScreenToClient(Mouse.CursorPos);
          TCrackControl(Found).OnMouseUp(Found, Button, Shift, Point2.X, Point2.Y);
        end;
      end
      else if (Button = mbRight) then
        if ClickOnConnection then
          FPopupMenuConnection.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
        else
          FPopupMenuWindow.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    end;
  end;
  FIsRectSelecting := False;
end;

function TEssConnectPanel.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;

const
  WHEEL_DIVISOR = 120; // Mouse Wheel standard
var
  Mdy: Integer;
begin
  Mdy := TScrollBox(Parent).VertScrollBar.Position - WheelDelta;
  TScrollBox(Parent).VertScrollBar.Position := Mdy;
  Result := True;
end;

procedure TEssConnectPanel.OnManagedObjectClick(Sender: TObject);
begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnClick) then
    Control.FOnClick(Sender);
end;

procedure TEssConnectPanel.OnManagedObjectDblClick(Sender: TObject);
begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnDblClick) then
  begin
    FMouseDownOK := False;
    ClearSelection;
    Control.FOnDblClick(Sender);
  end;
end;

procedure TEssConnectPanel.OnManagedObjectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
begin
  if (not Focused) or (GetCaptureControl <> Self) then
  begin
    // Call the essConnectpanel MouseDown instead.
    Point.X := X;
    Point.Y := Y;
    Point := (Sender as TControl).ClientToScreen(Point);
    Point := ScreenToClient(Point);
    MouseDown(Button, Shift, Point.X, Point.Y);
  end;
end;

procedure TEssConnectPanel.OnManagedObjectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnMouseMove) then
    Control.FOnMouseMove(Sender, Shift, X, Y);
end;

procedure TEssConnectPanel.OnManagedObjectMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  var
  Control := FindManagedControl(Sender as TControl);
  if Assigned(Control) and Assigned(Control.FOnMouseUp) then
    Control.FOnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TEssConnectPanel.Paint;
begin
  if IsMoving or (UpdateCounter > 0) then
    Exit; // this inhibits painting while moving
  Canvas.Pen.Mode := pmCopy;
  var
  Rect := ClientRect;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  Canvas.Brush.Color := FBackgroundColor;
  Canvas.Pen.Color := FForegroundColor;
  Canvas.Font := Font;
  ShowAll;
end;

procedure TEssConnectPanel.BeginUpdate;
begin
  UpdateCounter := UpdateCounter + 1;
end;

procedure TEssConnectPanel.EndUpdate;
begin
  UpdateCounter := UpdateCounter - 1;
  if UpdateCounter = 0 then
    Invalidate;
end;

procedure TEssConnectPanel.ShowConnections;
begin
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := (FConnections[I] as TConnection);
    if Conn.FromControl.Visible and Conn.ToControl.Visible then
      Conn.Draw(Canvas, True);
  end;
end;

procedure TEssConnectPanel.HideConnections;
begin
  for var I := 0 to FConnections.Count - 1 do
    (FConnections[I] as TConnection).Draw(Canvas, False);
end;

procedure TEssConnectPanel.ShowCuttedConnections;
var
  Conn: TConnection;
  AControl: TControl;
begin
  for var I := 0 to FConnections.Count - 1 do
  begin
    Conn := (FConnections[I] as TConnection);
    if Conn.Cutted and Conn.FromControl.Visible and Conn.ToControl.Visible then
    begin
      Conn.Draw(Canvas, True);
      // invalidate controls, which are Cutted
      for var K := 0 to FManagedObjects.Count - 1 do
      begin
        AControl := TManagedObject(FManagedObjects[K]).Control;
        if AControl.Visible and Conn.Square.Intersects(AControl.BoundsRect) then
          AControl.Invalidate;
      end;
      Conn.Cutted := False;
    end;
  end;
end;

procedure TEssConnectPanel.RecalcSize;
var
  XMax, YMax: Integer;
begin
  if Assigned(Parent) then
  begin
    XMax := Parent.Width - 4; // 300;
    YMax := Parent.Height - 4; // 150;
  end
  else
  begin
    XMax := 300;
    YMax := 150;
  end;
  for var I := 0 to ControlCount - 1 do
  begin
    if (Controls[I].Align <> alNone) or (not Controls[I].Visible) then
      Continue;
    XMax := Max(XMax, Controls[I].Left + Controls[I].Width + 30);
    YMax := Max(YMax, Controls[I].Top + Controls[I].Height + 30);
  end;
  if (Width <> XMax) or (Height <> YMax) then
    SetBounds(Left, Top, XMax, YMax);
  TScrollBox(Parent).HorzScrollBar.Visible := XMax >= Parent.Width;
  TScrollBox(Parent).VertScrollBar.Visible := YMax >= Parent.Height;
  if Assigned(FOnContentChanged) then
    FOnContentChanged(nil);
end;

procedure TEssConnectPanel.GetDiagramSize(var Width, Height: Integer);
begin
  Width := 300;
  Height := 150;
  for var I := 0 to ControlCount - 1 do
  begin
    if (Controls[I].Align <> alNone) or (not Controls[I].Visible) then
      Continue;
    Width := Max(Width, Controls[I].Left + Controls[I].Width + 10 +
      GetRecursivXEnlarge(Controls[I]));
    Height := Max(Height, Controls[I].Top + Controls[I].Height + 10 +
      GetRecursivYEnlarge(Controls[I]));
  end;
end;

function TEssConnectPanel.GetSelectedRect: TRect;
var
  Control: TControl;
  DeltaL, DeltaR, DeltaT, DeltaB, Count: Integer;
  ARect: TRect;
  Conn: TConnection;
begin
  Count := 0;
  Result := Rect(MaxInt, MaxInt, 0, 0);
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[I]).FSelected then
      begin
        Control := TManagedObject(FManagedObjects[I]).FControl;
        ARect := Control.BoundsRect;
        DeltaL := 0;
        DeltaR := 0;
        DeltaT := 0;
        DeltaB := 0;
        for var J := 0 to FConnections.Count - 1 do
        begin
          Conn := TConnection(FConnections[J]);
          if Conn.IsRecursiv and ((Conn.FromControl = Control) or (Conn.ToControl = Control)) then
          begin
            DeltaL := Max(DeltaL, Conn.XDecrease);
            DeltaR := Max(DeltaR, Conn.XEnlarge);
            DeltaT := Max(DeltaT, Conn.YDecrease);
            DeltaB := Max(DeltaB, Conn.YEnlarge);
          end;
        end;
        if ARect.Top - DeltaT < Result.Top then
          Result.Top := ARect.Top - DeltaT;
        if ARect.Left - DeltaL < Result.Left then
          Result.Left := ARect.Left - DeltaL;
        if ARect.Bottom + DeltaB > Result.Bottom then
          Result.Bottom := ARect.Bottom + DeltaB;
        if ARect.Right + DeltaR > Result.Right then
          Result.Right := ARect.Right + DeltaR;
        Inc(Count);
      end;
  if Count = 0 then
    Result := Rect(0, 0, 0, 0);
end;

procedure TEssConnectPanel.SelectObjectsInRect(SelRect: TRect);
var
  Rect1, Rect2: TRect;
  AControl: TControl;
begin
  Rect1 := SelRect;
  if SelRect.Top > SelRect.Bottom then
  begin
    SelRect.Top := Rect1.Bottom;
    SelRect.Bottom := Rect1.Top;
  end;
  if SelRect.Left > SelRect.Right then
  begin
    SelRect.Left := Rect1.Right;
    SelRect.Right := Rect1.Left;
  end;

  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      if Assigned(TManagedObject(FManagedObjects[I]).FControl) then
      begin
        AControl := TManagedObject(FManagedObjects[I]).FControl;
        Rect1 := AControl.BoundsRect;
        IntersectRect(Rect2, SelRect, Rect1);
        if EqualRect(Rect1, Rect2) and TManagedObject(FManagedObjects[I]).FControl.Visible
        then
          TManagedObject(FManagedObjects[I]).Selected := True;
      end;
    end;
end;

procedure TEssConnectPanel.SetFocus;
begin
  Anchors := [akTop, akLeft];
  // Try to see if we can call inherited, otherwise there is a risc of getting
  // 'Cannot focus' exception when starting from delphi-tools.
  if CanFocus and Assigned(FMyForm) then
  begin
    // To avoid having the scrollbox resetting its positions after a setfocus call.
    var
    X := (Parent as TScrollBox).HorzScrollBar.Position;
    var
    Y := (Parent as TScrollBox).VertScrollBar.Position;
    (Parent as TScrollBox).HorzScrollBar.Position := X;
    (Parent as TScrollBox).VertScrollBar.Position := Y;
    inherited;
  end;
end;

procedure TEssConnectPanel.SetModified(const Value: Boolean);
begin
  if FIsModified <> Value then
  begin
    FIsModified := Value;
    if Assigned(FOnModified) then
      FOnModified(Value);
  end;
end;

procedure TEssConnectPanel.SetSelectedOnly(const Value: Boolean);
begin
  if FSelectedOnly <> Value then
  begin
    FSelectedOnly := Value;
    if FSelectedOnly then
    begin
      FTempHidden.Clear;
      for var I := 0 to FManagedObjects.Count - 1 do
        if (not TManagedObject(FManagedObjects[I]).Selected) and
          TManagedObject(FManagedObjects[I]).FControl.Visible then
        begin
          TManagedObject(FManagedObjects[I]).FControl.Visible := False;
          FTempHidden.Add(TObject(FManagedObjects[I]));
        end;
    end
    else
    begin
      for var I := 0 to FTempHidden.Count - 1 do
        TManagedObject(FTempHidden[I]).FControl.Visible := True;
      FTempHidden.Clear;
    end;
  end;
end;

procedure TEssConnectPanel.SetUpdateCounter(Value: Integer);
begin
  FUpdateCounter := Value;
end;

procedure TEssConnectPanel.SetConnections(Value: Integer);
begin
  FShowConnections := Value;
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := TConnection(FConnections[I]);
    case Value of
      0:
        Conn.Visible := True;
      1:
        Conn.Visible := (Conn.ArrowStyle <> asInstanceOf);
    else
      Conn.Visible := False;
    end;
  end;
end;

procedure TEssConnectPanel.SetShowObjectDiagram(Show: Boolean);
begin
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      var
      AControl := TManagedObject(FManagedObjects[I]).FControl;
      if AControl is TRtfdClass then
      begin
        AControl.Visible := not Show;
        if Show then
          AControl.Parent := nil
        else
          AControl.Parent := Self;
      end;
    end;
  Invalidate;
end;

procedure TEssConnectPanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if Assigned(FOnDeleteSelectedControls) then
      FOnDeleteSelectedControls(Self);
    DeleteSelectedConnection;
    Invalidate;
  end;
end;

procedure TEssConnectPanel.TextTo(ACanvas: TCanvas);
// this was a hard way to find, Panel.PaintTo doesn't show the text.
var
  FirsChar: Integer;
  AManagedObject: TManagedObject;
  CommentBox: TRtfdCommentBox;
  Rect: TRect;
  Str: string;
begin
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      AManagedObject := TManagedObject(FManagedObjects[I]);
      if (AManagedObject.FControl is TRtfdCommentBox) then
      begin
        CommentBox := (AManagedObject.FControl as TRtfdCommentBox);
        ACanvas.Font := CommentBox.TrMemo.Font;
        ACanvas.Brush.Color := GuiPyOptions.CommentColor;
        CommentBox.TrMemo.Perform(EM_GETRECT, 0, LPARAM(@Rect));
        // TODO em_getrect from MyMsic
        FirsChar := CommentBox.TrMemo.Perform(EM_LINEINDEX,
        // TODO EM_GETFIRSTVISIBLELINE from MyMisc
        CommentBox.TrMemo.Perform(EM_GETFIRSTVISIBLELINE, 0, 0), 0);
        Str := Copy(CommentBox.TrMemo.Text, FirsChar + 1, MaxInt);
        ACanvas.TextOut(Rect.Left, Rect.Top, ' '); // ensures font is selected
        OffsetRect(Rect, CommentBox.Left + CommentBox.TrMemo.Left,
          CommentBox.Top + CommentBox.TrMemo.Top);
        DrawTextEx(ACanvas.Handle, Pointer(Str), Length(Str), Rect, DT_WORDBREAK or
          DT_LEFT or DT_EDITCONTROL, nil);
      end;
    end;
end;

function TEssConnectPanel.GetClipRect: TRect;
var
  MovedRect: TRect;
  MCont: TManagedObject;
  Curr: TCrackControl;
begin
  MovedRect := Rect(MaxInt, 0, 0, 0);
  if Assigned(FManagedObjects) then
    for var I := 0 to FManagedObjects.Count - 1 do
    begin
      MCont := TManagedObject(FManagedObjects[I]);
      Curr := TCrackControl(MCont.FControl);
      if MovedRect.Left = MaxInt then
        MovedRect := Curr.BoundsRect
      else
        UnionRect(MovedRect, Curr.BoundsRect, MovedRect);
    end;
  Result := MovedRect;
end;

procedure TEssConnectPanel.ChangeStyle(BlackAndWhite: Boolean = False);
begin
  if StyleServices.IsSystemStyle or BlackAndWhite then
  begin
    FBackgroundColor := clWhite;
    FForegroundColor := clBlack;
  end
  else
  begin
    FBackgroundColor := StyleServices.GetStyleColor(scPanel);
    FForegroundColor := StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  Color := FBackgroundColor;
  Canvas.Pen.Color := FForegroundColor;
  Canvas.Brush.Color := FBackgroundColor;
  for var I := 0 to FConnections.Count - 1 do
    TConnection(FConnections[I]).ChangeStyle(BlackAndWhite);
  for var I := 0 to FManagedObjects.Count - 1 do
    (TManagedObject(FManagedObjects[I]).FControl as TRtfdBox)
      .ChangeStyle(BlackAndWhite);
end;

function TEssConnectPanel.GetSVGConnections: string;
begin
  var
  SVG := '';
  for var I := 0 to FConnections.Count - 1 do
  begin
    var
    Conn := (FConnections[I] as TConnection);
    if Conn.FromControl.Visible and Conn.ToControl.Visible then
      SVG := SVG + Conn.SVG;
  end;
  Result := SVG;
end;

procedure TEssConnectPanel.CheckRoleHidesAttribute(Conn: TConnection;
  Attributes: TConnectionAttributes);
var
  Ite: IModelIterator;
  AClass: TClass;
  Attribute: TAttribute;
  HiddenChanged: Boolean;
begin
  if Conn.ToControl is TRtfdClass then
  begin
    HiddenChanged := False;
    AClass := (Conn.ToControl as TRtfdClass).Entity as TClass;
    Ite := AClass.GetAllAttributes;
    while Ite.HasNext do
    begin
      Attribute := Ite.Next as TAttribute;
      if not Attribute.Hidden and ((Attribute.Name = Attributes.RoleA) or
        (Attribute.Name + '[]' = Attributes.RoleA)) then
      begin
        Attribute.Hidden := True;
        HiddenChanged := True;
      end
      else if Attribute.Hidden and (Attribute.Name = WithoutArray(Conn.RoleA))
        and (Conn.RoleA <> Attributes.RoleA) then
      begin
        Attribute.Hidden := False;
        HiddenChanged := True;
      end;
    end;
    if HiddenChanged then
      (Conn.ToControl as TRtfdClass).RefreshEntities;
  end;
  if Conn.FromControl is TRtfdClass then
  begin
    HiddenChanged := False;
    AClass := (Conn.FromControl as TRtfdClass).Entity as TClass;
    Ite := AClass.GetAllAttributes;
    while Ite.HasNext do
    begin
      Attribute := Ite.Next as TAttribute;
      if not Attribute.Hidden and ((Attribute.Name = Attributes.RoleB) or
        (Attribute.Name + '[]' = Attributes.RoleB)) then
      begin
        Attribute.Hidden := True;
        HiddenChanged := True;
      end
      else if Attribute.Hidden and (Attribute.Name = WithoutArray(Conn.RoleB))
        and (Conn.RoleB <> Attributes.RoleB) then
      begin
        Attribute.Hidden := False;
        HiddenChanged := True;
      end;
    end;
    if HiddenChanged then
      (Conn.FromControl as TRtfdClass).RefreshEntities;
  end;
end;

{ TManagedObject }

constructor TManagedObject.Create;
begin
  inherited;
  FControl := nil;
end;

function TManagedObject.SelectedBoundsRect: TRect;
begin
  Result := FControl.BoundsRect;
  if Selected then
    Result.Inflate(HANDLESIZE, HANDLESIZE);
end;

procedure TManagedObject.SetSelected(const Value: Boolean);
begin
  if FControl.Visible and (FSelected <> Value) then
  begin
    FSelected := Value;
    (FControl as TRtfdBox).Selected := Value;
  end;
end;

end.
