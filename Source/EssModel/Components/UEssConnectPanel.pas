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
  Windows, Messages, Menus, Classes, Graphics, Controls, Forms,
  ExtCtrls, Contnrs, UUtils, UConnection;

const
  HANDLESIZE: Integer = 8;

type

  { Wrapper around a control managed by essConnectPanel }
  TManagedObject = class
  private
    FSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
  private
    FControl: TControl;
    // Old eventhandlers
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
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
    TempHidden: TObjectList;
    BGColor: TColor;
    FGColor: TColor;
    FUpdateCounter: Integer;
    procedure SetSelectedOnly(const Value: Boolean);
    procedure SetUpdateCounter(Value: Integer);
  protected
    FManagedObjects: TList;
    FConnections: TObjectList;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Click; override;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure CMMouseLeave(var message: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var message: TWmEraseBkgnd); message WM_ERASEBKGND;

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
    OnContentChanged: TNotifyEvent;
    OnModified: TBoolEvent; // TNotifyEvent;
    OnDeleteSelectedControls: TNotifyEvent;
    OnClassEditSelectedDiagramElements: TNotifyEvent;
    OnFormMouseDown: TNotifyEvent;

    PopupMenuConnection: TPopupMenu;
    PopupMenuAlign: TPopupMenu;
    PopupMenuWindow: TPopupMenu;

    FIsModified: Boolean;
    FIsMoving: Boolean;
    FIsRectSelecting: Boolean;
    FSelectedOnly: Boolean;
    FResized: Boolean;
    FShowConnections: Integer;
    MouseDownOK: Boolean;
    myForm: TForm;

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
    procedure SetConnection(i: Integer;
      Arrow: TessConnectionArrowStyle); overload;
    procedure SetConnection(i: Integer;
      Attributes: TConnectionAttributes); overload;
    procedure SetSelectedConnection(Attributes: TConnectionAttributes);
    function getConnection(i: Integer): TConnection;
    function HaveConnection(Src, Dest: TControl): Integer; overload;
    function HaveConnection(Src, Dest: TControl;
      ArrowStyle: TessConnectionArrowStyle): Integer; overload;
    function CountConnections(Src, Dest: TControl): Integer;
    function getRecursivConnection(Src: TControl): TConnection;
    function getRecursivXEnlarge(Control: TControl): Integer;
    function getRecursivYEnlarge(Control: TControl): Integer;
    function getRecursivXDecrease(Control: TControl): Integer;
    function getRecursivYDecrease(Control: TControl): Integer;
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
      Arrow: TessConnectionArrowStyle); overload;
    procedure EditParallelConnections;
    procedure DoConnection(Item: Integer);
    procedure DoAlign(Item: Integer);
    procedure TurnConnection(i: Integer);
    procedure DeleteConnection(i: Integer);
    procedure setRecursiv(P: TPoint; pos: Integer);
    procedure ClearManagedObjects;
    procedure CheckRoleHidesAttribute(conn: TConnection;
      Attributes: TConnectionAttributes);
    procedure ShowConnections;

    // Unselect all selected objects
    procedure ClearSelection(WithShowAll: Boolean = True);
    function SelectionChangedOnClear: Boolean;
    procedure ClearMarkerAndConnections(AControl: TControl);
    procedure ShowAll;
    procedure ShowAllIntersecting(R: TRect);
    procedure DrawMarkers(R: TRect; show: Boolean);
    procedure SetFocus; override;
    procedure SelectAssociation;
    procedure ConnectBoxes(Src, Dest: TControl);
    procedure SetConnections(Value: Integer);
    procedure SetShowObjectDiagram(b: Boolean);
    procedure GetDiagramSize(var W, H: Integer);
    function GetSelectedRect: TRect;
    procedure RecalcSize;
    procedure TextTo(aCanvas: TCanvas);
    function getClipRect: TRect;
    procedure CloseEdit;
    procedure EditBox(Control: TControl);
    procedure SetModified(const Value: Boolean);
    procedure ChangeStyle(BlackAndWhite: Boolean = False);
    function getSVGConnections: string;
    procedure BeginUpdate;
    procedure EndUpdate;

    property IsModified: Boolean read FIsModified write SetModified;
    property IsMoving: Boolean read FIsMoving write FIsMoving;
    // Bitmap to be used as background for printing
    property BackBitmap: TBitmap read FBackBitmap write FBackBitmap;
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
  crkObj: TCrackControl;
  newObj: TManagedObject;
begin
  Result := nil;
  if AObject.Left + AObject.Width > Width then
    Width := Max(Width, AObject.Left + AObject.Width + 50);
  if AObject.Top + AObject.Height > Height then
    Height := Max(Height, AObject.Top + AObject.Height + 50);

  AObject.Parent := Self;
  AObject.Visible := True;
  if FindManagedControl(AObject) = nil then
  begin
    newObj := TManagedObject.Create;
    newObj.FControl := AObject;
    // newObj.Visible:= true;
    FManagedObjects.Add(newObj);

    // if not (AObject is TRtfdCommentBox) then begin
    crkObj := TCrackControl(AObject);
    newObj.FOnMouseDown := crkObj.OnMouseDown;
    newObj.FOnMouseMove := crkObj.OnMouseMove;
    newObj.FOnMouseUp := crkObj.OnMouseUp;
    newObj.FOnClick := crkObj.OnClick;
    newObj.FOnDblClick := crkObj.OnDblClick;

    crkObj.OnMouseDown := OnManagedObjectMouseDown;
    crkObj.OnMouseMove := OnManagedObjectMouseMove;
    crkObj.OnMouseUp := OnManagedObjectMouseUp;
    crkObj.OnClick := OnManagedObjectClick;
    crkObj.OnDblClick := OnManagedObjectDblClick;
    // end;
    Result := AObject;
  end;
end;

procedure TEssConnectPanel.ClearManagedObjects;
begin
  FConnections.Clear;
  if Assigned(FManagedObjects) then
  begin
    for var i := 0 to FManagedObjects.Count - 1 do
    begin
      var
      aManagedObject := TManagedObject(FManagedObjects[i]);
      FreeAndNil(aManagedObject);
    end;
    FManagedObjects.Clear;
  end;
  SetBounds(0, 0, 0, 0);
  FIsModified := False;
end;

function TEssConnectPanel.SelectionChangedOnClear: Boolean;
var
  i: Integer;
begin
  Result := False;
  if Assigned(FManagedObjects) then
  begin
    for i := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).Selected and
        TManagedObject(FManagedObjects[i]).Control.Visible then
      begin
        TManagedObject(FManagedObjects[i]).Selected := False;
        Result := True;
      end;
  end;
  for i := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then
    begin
      TConnection(FConnections[i]).Selected := False;
      TConnection(FConnections[i]).DrawSelection(Canvas, False);
      Result := True;
    end;
end;

procedure TEssConnectPanel.ClearSelection(WithShowAll: Boolean = True);
var
  i: Integer;
begin
  if Assigned(FManagedObjects) then
    for i := 0 to FManagedObjects.Count - 1 do
      TManagedObject(FManagedObjects[i]).Selected := False;
  if Assigned(FConnections) then
    for i := 0 to FConnections.Count - 1 do
      TConnection(FConnections[i]).Selected := False;
  if WithShowAll then
    ShowAll;
end;

procedure TEssConnectPanel.ClearMarkerAndConnections(AControl: TControl);
begin
  DrawMarkers((AControl as TRtfdBox).GetBoundsRect, False);
  for var i := 0 to FConnections.Count - 1 do
  begin
    var
    conn := (FConnections[i] as TConnection);
    if conn.Visible and ((conn.FFrom = AControl) or (conn.FTo = AControl)) then
      conn.Draw(Canvas, False);
  end;
end;

procedure TEssConnectPanel.ShowAll;
var
  ZOrderArr: array of Integer;
  NextZ, i, j, Anz: Integer;
  ZNameArr: array of string;
  aBox: TRtfdBox;
begin
  HideConnections;

  if Assigned(FManagedObjects) and (UpdateCounter = 0) then
  begin
    Anz := FManagedObjects.Count;
    SetLength(ZOrderArr, Anz);
    SetLength(ZNameArr, Anz);
    for i := 0 to Anz - 1 do
    begin
      ZOrderArr[i] := zzGetControlZOrder(TManagedObject(FManagedObjects[i])
        .FControl);
      if (TManagedObject(FManagedObjects[i]).FControl is TRtfdBox) then
      begin
        aBox := TManagedObject(FManagedObjects[i]).FControl as TRtfdBox;
        ZNameArr[i] := aBox.Entity.Name + '-' + IntToStr(ZOrderArr[i]);
      end;
    end;
    ShowConnections;

    NextZ := 0;
    for i := 0 to Anz - 1 do
    begin
      for j := 0 to Anz - 1 do
        if ZOrderArr[j] = NextZ then
          Break;
      if (j <= Anz - 1) and TManagedObject(FManagedObjects[j]).FControl.Visible
      then
      begin
        aBox := TManagedObject(FManagedObjects[j]).FControl as TRtfdBox;
        aBox.Paint;
      end;
      Inc(NextZ);
    end;
  end;
end;

procedure TEssConnectPanel.CloseEdit;
begin
  if Assigned(FManagedObjects) then
  begin
    for var i := 0 to FManagedObjects.Count - 1 do
    begin
      var
      aBox := TManagedObject(FManagedObjects[i]).FControl as TRtfdBox;
      aBox.CloseEdit;
    end;
  end;
end;

procedure TEssConnectPanel.EditBox(Control: TControl);
begin
  if Assigned(OnClassEditSelectedDiagramElements) then
    OnClassEditSelectedDiagramElements(Control);
end;

procedure TEssConnectPanel.ShowAllIntersecting(R: TRect);
// https://wiki.lazarus.freepascal.org/Developing_with_Graphics#Motion_Graphics_-_How_to_Avoid_flickering

  function Intersect(const R1, R2: TRect): Boolean;
  begin
    Result := not((R1.BottomRight.X <= R2.TopLeft.X) or
      (R1.BottomRight.Y <= R2.TopLeft.Y) or (R2.BottomRight.X <= R1.TopLeft.X)
      or (R2.BottomRight.Y <= R1.TopLeft.Y));
  end;

begin
  if Assigned(FManagedObjects) then
    for var i := 0 to FManagedObjects.Count - 1 do
    begin
      var
      AControl := TManagedObject(FManagedObjects[i]).Control;
      if AControl.Visible and Intersect(R, AControl.BoundsRect) then
        AControl.Invalidate;
    end;
end;

procedure TEssConnectPanel.DrawMarkers(R: TRect; show: Boolean);

  procedure MarkerPart(X, Y: Integer);
  var
    R: TRect;
  begin
    R := Rect(X, Y, X + HANDLESIZE, Y + HANDLESIZE);
    Canvas.FillRect(R);
  end;

begin
  with Canvas do
  begin
    InflateRect(R, HANDLESIZE, HANDLESIZE);
    if show then
      Brush.Color := FGColor
    else
      Brush.Color := BGColor;
    MarkerPart(R.Left, R.Top);
    MarkerPart(R.Right - HANDLESIZE, R.Top);
    MarkerPart(R.Right - HANDLESIZE, R.Bottom - HANDLESIZE);
    MarkerPart(R.Left, R.Bottom - HANDLESIZE);
  end;
end;

procedure TEssConnectPanel.Click;
begin
end;

procedure TEssConnectPanel.CMMouseLeave(var message: TMessage);
var
  pt: TPoint;
  R: TRect;
begin
  pt := Mouse.CursorPos;

  IntersectRect(R, Parent.ClientRect, BoundsRect);
  R.TopLeft := Parent.ClientToScreen(R.TopLeft);
  R.BottomRight := Parent.ClientToScreen(R.BottomRight);
  if (not PtInRect(R, pt)) and not(FIsRectSelecting) then
    ReleaseCapture;
end;

procedure TEssConnectPanel.WMEraseBkgnd(var message: TWmEraseBkgnd);
begin
  var
  can := TCanvas.Create;
  try
    can.handle := message.DC;
    if Assigned(FBackBitmap) then
      can.Brush.Bitmap := FBackBitmap
    else
      can.Brush.Color := Color;
    can.FillRect(ClientRect);
  finally
    FreeAndNil(can);
  end;
  Message.Result := 1;
end;

procedure TEssConnectPanel.EditParallelConnections;
var
  i, j, parallelindex, parallelcount: Integer;
  conn1, conn2: TConnection;
begin
  for i := 0 to FConnections.Count - 1 do
  begin
    conn1 := TConnection(FConnections[i]);
    conn1.parallelindex := 0;
    conn1.parallelcount := 0;
    conn1.parallelvisited := False;
    conn1.parallelvisiting := False;
  end;
  for i := 0 to FConnections.Count - 2 do
  begin
    conn1 := TConnection(FConnections[i]);
    if not conn1.parallelvisited then
    begin
      for j := i + 1 to FConnections.Count - 1 do
      begin
        conn2 := TConnection(FConnections[j]);
        if (conn1.FFrom = conn2.FFrom) and (conn1.FTo = conn2.FTo) or
          (conn1.FFrom = conn2.FTo) and (conn1.FTo = conn2.FFrom) then
        begin
          Inc(conn1.parallelcount);
          conn2.parallelvisiting := True; // simplify second search
        end;
      end;
      parallelindex := 0;
      parallelcount := conn1.parallelcount;
      if parallelcount > 0 then
        for j := i + 1 to FConnections.Count - 1 do
        begin
          conn2 := TConnection(FConnections[j]);
          if not conn2.parallelvisited and conn2.parallelvisiting then
          begin
            conn2.parallelvisited := True;
            Inc(parallelindex);
            conn2.parallelindex := parallelindex;
            conn2.parallelcount := parallelcount;
          end;
        end;
      conn1.parallelvisited := True;
    end;
  end;
  for i := 0 to FConnections.Count - 1 do
    TConnection(FConnections[i]).parallelCorrection;
end;

procedure TEssConnectPanel.ConnectObjects(Src, Dst: TControl;
  Attributes: TConnectionAttributes);
begin
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) then
  begin
    var conn := TConnection.Create(Src, Dst, Attributes, Canvas);
    if GuiPyOptions.RoleHidesAttribute then
      CheckRoleHidesAttribute(conn, Attributes);
    FConnections.Add(conn);
    EditParallelConnections;
  end;
end;

procedure TEssConnectPanel.ConnectObjects(Src, Dst: TControl;
  Arrow: TessConnectionArrowStyle);
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
        Attributes.isEdited := True;

      ConnectObjects(Src, Dst, Attributes);
    finally
      FreeAndNil(Attributes);
    end;
    ClearSelection(False);
  end;
end;

procedure TEssConnectPanel.DeleteObjectConnections;
begin
  for var i := FConnections.Count - 1 downto 0 do begin
    var conn := TConnection(FConnections[i]);
    if (conn.FFrom is TRtfdObject) and (conn.FTo is TRtfdObject) then
      FConnections.Delete(i);
  end;
  EditParallelConnections;
end;

function TEssConnectPanel.getRecursivConnection(Src: TControl): TConnection;
begin
  var
  i := HaveConnection(Src, Src);
  if i > -1 then
    Result := TConnection(FConnections[i])
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
  myForm := AOwner as TForm;
  FManagedObjects := TList.Create;
  FConnections := TObjectList.Create(True);
  FShowConnections := 0;
  TempHidden := TObjectList.Create(False);
  UseDockManager := True;
  MouseDownOK := True;
  FUpdateCounter := 0;
  ChangeStyle;
  SetFocus;
end;

procedure TEssConnectPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Params.Style := Params.Style and (not WS_CLIPCHILDREN);
end;

procedure TEssConnectPanel.DblClick;
begin
  inherited;
  var
  found := FindVCLWindow(Mouse.CursorPos);
  if Assigned(found) then
  begin
    FindManagedControl(found);
    if found <> Self then
      TCrackControl(found).DblClick;
    if GetClickedConnectionNr <> -1 then
      SelectAssociation;
  end
end;

function TEssConnectPanel.GetClickedConnectionNr: Integer;
begin
  var
  P := Self.ScreenToClient(Mouse.CursorPos);
  Result := 0;
  while Result < FConnections.Count do
  begin
    var
    conn := TConnection(FConnections[Result]);
    if conn.IsClicked(P) then
      Exit;
    Inc(Result);
  end;
  Result := -1;
end;

function TEssConnectPanel.GetClickedConnection: TConnection;
begin
  var
  Nr := GetClickedConnectionNr;
  if Nr <> -1 then
    Result := TConnection(FConnections[Nr])
  else
    Result := nil;
end;

function TEssConnectPanel.ClickOnConnection: Boolean;
begin
  var
  Nr := GetClickedConnectionNr;
  Result := (Nr <> -1);
end;

procedure TEssConnectPanel.TurnConnection(i: Integer);
begin
  TConnection(FConnections[i]).Turn;
end;

procedure TEssConnectPanel.DeleteConnection(i: Integer);
begin
  var
  conn := TConnection(FConnections[i]);
  conn.Selected := False;
  conn.DrawSelection(Canvas, False);
  conn.Draw(Canvas, False);
  FConnections.Delete(i);
end;

procedure TEssConnectPanel.setRecursiv(P: TPoint; pos: Integer);
begin
  P := Self.ScreenToClient(P);
  var
  i := 0;
  while i < FConnections.Count do
  begin
    var
    conn := TConnection(FConnections[i]);
    if conn.IsClicked(P) then
      Break;
    Inc(i);
  end;
  if (i < FConnections.Count) then
  begin
    TConnection(FConnections[i]).setRecursivPosition(pos);
    Invalidate;
  end;
end;

procedure TEssConnectPanel.SelectAssociation;
begin
  var
  FAssociation := TFAssociation.Create(Self);
  try
    var
    conn := GetSelectedConnection;
    var
    SelectedControls := CountSelectedControls;
    if conn = nil then
      case SelectedControls of
        1:
          FAssociation.init(False, conn, 1);
        2:
          FAssociation.init(False, conn, 2)
      else
        Exit;
      end
    else
      FAssociation.init(False, conn, SelectedControls);
    case FAssociation.ShowModal of
      mrOk:
        begin
          var
          Attributes := FAssociation.getConnectionAttributes;
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
        for var i := 0 to FConnections.Count - 1 do
          if TConnection(FConnections[i]).Selected then
            TurnConnection(i);
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
        FAssociation.init(False, nil, 1);
      2:
        FAssociation.init(False, nil, 2)
    else
      Exit;
    end;
    if Dest is TRtfdCommentBox then
    begin
      var
      Attributes := FAssociation.getConnectionAttributes;
      Attributes.ArrowStyle := asComment;
      ConnectObjects(Src, Dest, Attributes);
      FreeAndNil(Attributes);
    end
    else if FAssociation.ShowModal = mrOk then
    begin
      var
      Attributes := FAssociation.getConnectionAttributes;
      case SelectedControls of
        1:
          ConnectObjects(Src, Src, Attributes);
        2:
          ConnectObjects(Src, Dest, Attributes);
      end;
      FreeAndNil(Attributes);
    end;
    ClearSelection(True);
    // Invalidate;
    IsModified := True;
  finally
    FAssociation.Release;
  end;
end;

procedure TEssConnectPanel.DoConnection(Item: Integer);
begin
  var
  n := -1;
  for var i := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then
      n := i;
  if n <> -1 then
  begin
    case Item of
      0 .. 9:
        SetConnection(n, TessConnectionArrowStyle(Item));
      10:
        SelectAssociation;
      11:
        TurnConnection(n);
    else
      begin
        DeleteConnection(n);
        EditParallelConnections;
      end;
    end;
    ShowAll;
    FIsModified := True;
  end;
end;

procedure TEssConnectPanel.DoAlign(Item: Integer);
var
  i, aLeft, Right, aTop, Bottom, VMiddle, HMiddle: Integer;
  Control: TControl;
begin
  if not Assigned(FManagedObjects) then
    Exit;
  aLeft := +MaxInt;
  Right := -MaxInt;
  aTop := +MaxInt;
  Bottom := -MaxInt;
  for i := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[i]).FSelected then
    begin
      Control := TManagedObject(FManagedObjects[i]).Control;
      if Control.Left < aLeft then
        aLeft := Control.Left;
      if Control.Left + Control.Width > Right then
        Right := Control.Left + Control.Width;
      if Control.Top < aTop then
        aTop := Control.Top;
      if Control.Top + Control.Height > Bottom then
        Bottom := Control.Top + Control.Height;
    end;
  HMiddle := (aLeft + Right) div 2;
  VMiddle := (aTop + Bottom) div 2;
  for i := 0 to FManagedObjects.Count - 1 do
    if TManagedObject(FManagedObjects[i]).FSelected then
    begin
      Control := TManagedObject(FManagedObjects[i]).Control;
      case Item of
        1:
          Control.Left := aLeft;
        2:
          Control.Left := HMiddle - Control.Width div 2;
          // - Control.Width mod 2;
        3:
          Control.Left := Right - Control.Width;
        4:
          Control.Top := aTop;
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
  FreeAndNil(TempHidden);
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
    for var i := 0 to FManagedObjects.Count - 1 do
    begin
      var
      curr := TManagedObject(FManagedObjects[i]);
      if curr.FControl = AControl then
      begin
        Result := curr;
        Exit;
      end;
    end;
end;

function TEssConnectPanel.GetConnections: TList;
begin
  Result := TList.Create;
  for var i := 0 to FConnections.Count - 1 do
    Result.Add(FConnections[i]);
end;

procedure TEssConnectPanel.SetConnection(i: Integer;
  Attributes: TConnectionAttributes);
begin
  if (0 <= i) and (i < FConnections.Count) then
    TConnection(FConnections[i]).SetAttributes(Attributes);
end;

procedure TEssConnectPanel.SetConnection(i: Integer;
  Arrow: TessConnectionArrowStyle);
begin
  if (0 <= i) and (i < FConnections.Count) then
    TConnection(FConnections[i]).setArrow(Arrow);
end;

procedure TEssConnectPanel.SetSelectedConnection
  (Attributes: TConnectionAttributes);
begin
  for var i := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then
    begin
      var
      conn := TConnection(FConnections[i]);
      if GuiPyOptions.RoleHidesAttribute then
        CheckRoleHidesAttribute(conn, Attributes);
      conn.SetAttributes(Attributes);
    end;
end;

function TEssConnectPanel.getConnection(i: Integer): TConnection;
begin
  Result := TConnection(FConnections[i]);
end;

procedure TEssConnectPanel.DeleteSelectedConnection;
begin
  for var i := FConnections.Count - 1 downto 0 do
    if TConnection(FConnections[i]).Selected then
    begin
      DeleteConnection(i);
      IsModified := True;
    end;
  EditParallelConnections;
end;

procedure TEssConnectPanel.DeleteNotEditedConnections;
begin
  for var i := FConnections.Count - 1 downto 0 do begin
    var conn := TConnection(FConnections[i]);
    if not conn.isEdited then
      FConnections.Delete(i);
  end;
  EditParallelConnections;
end;

function TEssConnectPanel.HasSelectedConnection: Boolean;
begin
  Result := False;
  for var i := FConnections.Count - 1 downto 0 do
    if TConnection(FConnections[i]).Selected then
    begin
      Result := True;
      Break;
    end;
end;

function TEssConnectPanel.GetSelectedConnection: TConnection;
begin
  Result := nil;
  for var i := 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then
    begin
      Result := TConnection(FConnections[i]);
      Exit;
    end;
end;

function TEssConnectPanel.HaveConnection(Src, Dest: TControl): Integer;
begin
  for var i := 0 to FConnections.Count - 1 do
  begin
    var
    conn := TConnection(FConnections[i]);
    if ((conn.FFrom = Src) and (conn.FTo = Dest)) or
      ((conn.FFrom = Dest) and (conn.FTo = Src)) then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function TEssConnectPanel.HaveConnection(Src, Dest: TControl;
  ArrowStyle: TessConnectionArrowStyle): Integer;
begin
  for var i := 0 to FConnections.Count - 1 do
  begin
    var
    conn := TConnection(FConnections[i]);
    if (conn.FFrom = Src) and (conn.FTo = Dest) and
      (conn.ArrowStyle = ArrowStyle) then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function TEssConnectPanel.CountConnections(Src, Dest: TControl): Integer;
begin
  Result := 0;
  for var i := 0 to FConnections.Count - 1 do
  begin
    var
    conn := TConnection(FConnections[i]);
    if ((conn.FFrom = Src) and (conn.FTo = Dest)) or
      ((conn.FFrom = Dest) and (conn.FTo = Src)) then
      Inc(Result);
  end;
end;

function TEssConnectPanel.getRecursivXEnlarge(Control: TControl): Integer;
var
  conn: TConnection;
  i, dl, dr: Integer;
begin
  dl := 0;
  dr := 0;
  for i := 0 to FConnections.Count - 1 do
  begin
    conn := TConnection(FConnections[i]);
    if conn.isRecursiv and ((conn.FFrom = Control) or (conn.FTo = Control)) then
    begin
      dl := Max(dl, conn.XDecrease);
      dr := Max(dr, conn.XEnlarge);
    end;
  end;
  Result := dl + dr;
end;

function TEssConnectPanel.getRecursivYEnlarge(Control: TControl): Integer;
var
  conn: TConnection;
  i, dt, db: Integer;
begin
  dt := 0;
  db := 0;
  for i := 0 to FConnections.Count - 1 do
  begin
    conn := TConnection(FConnections[i]);
    if conn.isRecursiv and ((conn.FFrom = Control) or (conn.FTo = Control)) then
    begin
      dt := Max(dt, conn.YDecrease);
      db := Max(db, conn.YEnlarge);
    end;
  end;
  Result := dt + db;
end;

function TEssConnectPanel.getRecursivXDecrease(Control: TControl): Integer;
begin
  var
  conn := getRecursivConnection(Control);
  if Assigned(conn) then
    Result := conn.XDecrease
  else
    Result := 0;
end;

function TEssConnectPanel.getRecursivYDecrease(Control: TControl): Integer;
begin
  var
  conn := getRecursivConnection(Control);
  if Assigned(conn) then
    Result := conn.YDecrease
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
    for var i := 0 to FManagedObjects.Count - 1 do
      Result.Add(TManagedObject(FManagedObjects[i]).FControl);
end;

function TEssConnectPanel.CountSelectedControls: Integer;
begin
  var
  n := 0;
  if Assigned(FManagedObjects) then
    for var i := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Inc(n);
  Result := n;
end;

function TEssConnectPanel.HasSelectedControls: Boolean;
begin
  Result := False;
  if Assigned(FManagedObjects) then
    for var i := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Exit(True);
end;

function TEssConnectPanel.GetFirstSelected: TControl;
begin
  Result := nil;
  if Assigned(FManagedObjects) then
    for var i := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Exit(TManagedObject(FManagedObjects[i]).FControl);
end;

function TEssConnectPanel.GetSelectedControls: TObjectList;
begin
  Result := TObjectList.Create(False);
  if Assigned(FManagedObjects) then
    for var i := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Result.Add(TManagedObject(FManagedObjects[i]).FControl);
end;

procedure TEssConnectPanel.DeleteSelectedControls;
var
  i, j: Integer;
  Control: TControl;
  conn: TConnection;
  ManagedObject: TManagedObject;
begin
  if Assigned(FManagedObjects) then
    for i := FManagedObjects.Count - 1 downto 0 do
      if TManagedObject(FManagedObjects[i]).FSelected then
      begin
        ManagedObject := TManagedObject(FManagedObjects[i]);
        Control := TManagedObject(FManagedObjects[i]).FControl;
        for j := FConnections.Count - 1 downto 0 do
        begin
          conn := TConnection(FConnections[j]);
          if (conn.FFrom = Control) or (conn.FTo = Control) then
            FConnections.Delete(j);
        end;
        FManagedObjects.Delete(i);
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
  found: TControl;
  mcont: TManagedObject;
  cconn: TConnection;
  aChanged: Boolean;
  aBox: TRtfdBox;
  aName: string;
begin
  if not MouseDownOK then
  begin
    MouseDownOK := True;
    Exit
  end;
  if not(ssDouble in Shift) then
    CloseEdit;
  // repaint TrMemo
  if Assigned(Application.MainForm.ActiveControl) and
    (Application.MainForm.ActiveControl is TMemo) then
    (Application.MainForm.ActiveControl as TMemo).Parent.Invalidate;
  if not Focused and Assigned(OnFormMouseDown) then
    OnFormMouseDown(Self);
  SetFocus; // a TPanel can have the Focus
  if GetCaptureControl <> Self then
    SetCaptureControl(Self);
  FIsRectSelecting := False;
  FIsMoving := False;
  FResized := False;
  FMemMousePos.X := X;
  FMemMousePos.Y := Y;
  aChanged := False;

  if (Button = mbRight) and (CountSelectedControls > 1) then
    PopupMenuAlign.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
  else
  begin
    found := FindVCLWindow(Mouse.CursorPos);
    if found = Self then
      found := nil;
    if Assigned(found) then
    begin
      mcont := FindManagedControl(found);
      if Assigned(mcont) then
      begin
        if not mcont.Selected then
        begin
          if (mcont.FControl is TRtfdBox) then
          begin
            aBox := mcont.FControl as TRtfdBox;
            aBox.BringToFront;
            aName := aBox.Entity.Name;
          end;
          if not CtrlPressed then
            SelectionChangedOnClear;
          if mcont.Control.Visible then
          begin
            mcont.Selected := True;
            aChanged := True;
          end;
        end
        else if CtrlPressed then
        begin
          mcont.Selected := False;
          aChanged := True;
        end;
        if aChanged then
          ShowAll;
        if CountSelectedControls > 0 then
          FIsMoving := True;
      end;
    end
    else
    begin
      cconn := GetClickedConnection;
      if Assigned(cconn) then
      begin
        if not cconn.Selected then
        begin
          if not CtrlPressed then
            SelectionChangedOnClear;
          cconn.Selected := True;
          aChanged := True;
        end
        else if CtrlPressed then
        begin
          cconn.Selected := False;
          aChanged := True;
        end;
        if aChanged then
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
    // Canvas.Rectangle(FSelectRect);
  end;
end;

procedure TEssConnectPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pt, pt1, p2: TPoint;
  found, Src: TControl;
  mcont: TManagedObject;
  i, dx, dy, SelControls, Handle_Shadow, newLeft, newTop, W, H: Integer;
  curr: TCrackControl;
  R, rt, MovedRect, mRectDxDy: TRect;
  resized: Boolean;

  procedure InMakeVisible(C: TRect);
  var
    mdx, mdy: Integer;
    P: TPoint;
  begin
    mdx := TScrollBox(Parent).HorzScrollBar.Position;
    mdy := TScrollBox(Parent).VertScrollBar.Position;

    if (dx > 0) and (C.BottomRight.X >= TScrollBox(Parent)
      .HorzScrollBar.Position + Parent.Width) then
      TScrollBox(Parent).HorzScrollBar.Position := C.BottomRight.X -
        Parent.Width;

    if (dy > 0) and (C.BottomRight.Y >= TScrollBox(Parent)
      .VertScrollBar.Position + Parent.Height) then
      TScrollBox(Parent).VertScrollBar.Position := C.BottomRight.Y -
        Parent.Height;

    if (dx < 0) and (C.Left <= TScrollBox(Parent).HorzScrollBar.Position) then
      TScrollBox(Parent).HorzScrollBar.Position := C.Left;

    if (dy < 0) and (C.Top <= TScrollBox(Parent).VertScrollBar.Position) then
      TScrollBox(Parent).VertScrollBar.Position := C.Top;

    mdy := mdy - TScrollBox(Parent).VertScrollBar.Position;
    mdx := mdx - TScrollBox(Parent).HorzScrollBar.Position;

    if (mdx <> 0) or (mdy <> 0) then
    begin
      P := Mouse.CursorPos;
      P.X := P.X + mdx;
      P.Y := P.Y + mdy;
      Mouse.CursorPos := P;
      resized := True;
    end;
  end;

  function Intersect(const R1, R2: TRect): Boolean;
  begin
    Result := not((R1.BottomRight.X <= R2.TopLeft.X) or
      (R1.BottomRight.Y <= R2.TopLeft.Y) or (R2.BottomRight.X <= R1.TopLeft.X)
      or (R2.BottomRight.Y <= R1.TopLeft.Y));
  end;

  procedure ShowConnectionsAndMarkers(show: Boolean);
  var
    k, i: Integer;
    AControl: TControl;
    Connect, aConnection: TConnection;
    SrcRect: TRect;
  begin
    Src := mcont.FControl;

    // for all moved connections
    for k := 0 to FConnections.Count - 1 do
    begin
      Connect := TConnection(FConnections[k]);
      if Connect.Visible and Connect.FTo.Visible and Connect.FFrom.Visible and
        ((Connect.FFrom = Src) or (Connect.FTo = Src)) then
      begin
        // hide/show moved connection
        Connect.Draw(Canvas, show);

        // invalidate cutted controls
        for i := 0 to FManagedObjects.Count - 1 do
        begin
          AControl := TManagedObject(FManagedObjects[i]).Control;
          if AControl.Visible and Connect.square.intersects(AControl.BoundsRect)
          then
            (AControl as TRtfdBox).Paint; // invalidate
        end;

        // mark cutted connections
        if show then
          for i := 0 to FConnections.Count - 1 do
          begin
            aConnection := TConnection(FConnections[i]);
            if (i <> k) and aConnection.Visible and
              aConnection.square.intersects(Connect.square) then
              aConnection.cutted := True;
          end;
      end;
    end;

    // for the moved control
    SrcRect := Src.BoundsRect;
    SrcRect.Inflate(HANDLESIZE, HANDLESIZE);
    // invalidate all cutted controls
    for i := 0 to FManagedObjects.Count - 1 do
    begin
      AControl := TManagedObject(FManagedObjects[i]).Control;
      if AControl.Visible and (AControl <> Src) and
        Intersect(TManagedObject(FManagedObjects[i]).SelectedBoundsRect, SrcRect)
      then
        // aControl.Invalidate;
        (AControl as TRtfdBox).Paint;
    end;

    if show then
      for i := 0 to FConnections.Count - 1 do
      begin
        aConnection := TConnection(FConnections[i]);
        if aConnection.Visible and aConnection.FTo.Visible and
          aConnection.FFrom.Visible and
          not((aConnection.FFrom = Src) or (aConnection.FTo = Src)) and
          aConnection.square.intersects(SrcRect) then
          // mark cutted connections of moved control
          aConnection.cutted := True;
      end;

    if not(mcont.FControl is TRtfdCommentBox) then
      DrawMarkers((mcont.FControl as TRtfdBox).GetBoundsRect, show);
  end;

begin // of MouseMove
  inherited;

  if Shift = [] then
    Exit;
  pt1 := Mouse.CursorPos;
  pt.X := X;
  pt.Y := Y;
  dx := pt.X - FMemMousePos.X;
  dy := pt.Y - FMemMousePos.Y;
  if (dx = 0) and (dy = 0) then
    Exit;

  IntersectRect(R, Parent.ClientRect, BoundsRect);
  R.TopLeft := Parent.ClientToScreen(R.TopLeft);
  R.BottomRight := Parent.ClientToScreen(R.BottomRight);

  if (not PtInRect(R, pt1)) and (not(FIsRectSelecting or FIsMoving)) then
    ReleaseCapture
  else
  begin
    found := FindVCLWindow(pt1);
    if FIsRectSelecting then
    begin
      FMemMousePos := pt;
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
      if (Abs(dx) + Abs(dy) > 5) or FIsMoving then
      begin
        resized := False;
        MovedRect := Rect(MaxInt, 0, 0, 0);
        SelControls := CountSelectedControls;
        Handle_Shadow := Max(HANDLESIZE - GuiPyOptions.ShadowWidth, 0);

        if Assigned(FManagedObjects) then
          for i := 0 to FManagedObjects.Count - 1 do
          begin
            mcont := TManagedObject(FManagedObjects[i]);
            if mcont.Control.Visible and mcont.Selected then
            begin
              ShowConnectionsAndMarkers(False);
              curr := TCrackControl(mcont.FControl);
              mRectDxDy := curr.BoundsRect;
              mRectDxDy.TopLeft.Offset(-HANDLESIZE, -HANDLESIZE);
              mRectDxDy.BottomRight.Offset(Handle_Shadow, Handle_Shadow);

              if (mcont.FControl is TRtfdCommentBox) and (SelControls = 1) then
                (mcont.FControl as TRtfdCommentBox)
                  .CommentMouseMove(ClientToScreen(FMemMousePos),
                  ClientToScreen(pt))
              else
              begin
                newLeft := curr.Left;
                newTop := curr.Top;
                if (dx <> 0) and
                  (curr.Left + dx >= getRecursivXDecrease(mcont.FControl)) then
                  newLeft := curr.Left + dx;
                if (dy <> 0) and
                  (curr.Top + dy >= getRecursivYDecrease(mcont.FControl)) then
                  newTop := curr.Top + dy;
                if (newLeft <> curr.Left) or (newTop <> curr.Top) then
                  curr.SetBounds(newLeft, newTop, curr.Width, curr.Height);
              end;

              rt := curr.BoundsRect;
              rt.TopLeft.Offset(-HANDLESIZE, -HANDLESIZE);
              rt.BottomRight.Offset(Handle_Shadow, Handle_Shadow);
              mRectDxDy.Union(rt);

              // scrolling
              if curr.Left + curr.Width + 30 > Width then
              begin
                Width := curr.Left + curr.Width + 30;
                resized := True;
              end;
              if curr.Top + curr.Height + 30 > Height then
              begin
                Height := curr.Top + curr.Height + 30;
                // ToDo wird nicht vergrößert
                resized := True;
              end;

              if MovedRect.Left = MaxInt then
                MovedRect := mRectDxDy
              else
                UnionRect(MovedRect, mRectDxDy, MovedRect);
              // debug
              // Canvas.Brush.Color:= clRed;
              // Canvas.FrameRect(MovedRect);
              ShowConnectionsAndMarkers(True);
              ShowAll; // (mcont.FControl as TRtfdBox).Paint;
            end;
          end;

        GetDiagramSize(W, H);
        TScrollBox(Parent).HorzScrollBar.Visible := W + 5 > Parent.Width;
        TScrollBox(Parent).VertScrollBar.Visible := H + 5 > Parent.Height;
        // debug
        // Canvas.Brush.Color:= clRed;
        // Canvas.FrameRect(MovedRect);

        IsModified := True;
        FMemMousePos := pt;
        FIsMoving := True;

        if MovedRect.Left <> MaxInt then
          InMakeVisible(MovedRect);
        if resized then
        begin
          Invalidate;
          // doesn't call paint in all cases, so ShowConnections is ensured
          Application.ProcessMessages; // ensures that invalidate is acomplished
          ShowConnections;
        end
        else
          ShowCuttedConnections;
      end
      else if Assigned(found) then
      begin
        if Assigned(TCrackControl(found).OnMouseMove) then
        begin
          p2 := found.ScreenToClient(pt);
          TCrackControl(found).OnMouseMove(found, Shift, p2.X, p2.Y);
        end;
      end;
    end;
  end;
end;

procedure TEssConnectPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  pt, p2: TPoint;
  R: TRect;
  found: TControl;
begin
  inherited;
  FIsMoving := False;
  pt.X := X;
  pt.Y := Y;
  IntersectRect(R, Parent.ClientRect, BoundsRect);
  R.TopLeft := Parent.ClientToScreen(R.TopLeft);
  R.BottomRight := Parent.ClientToScreen(R.BottomRight);
  R.TopLeft := ScreenToClient(R.TopLeft);
  R.BottomRight := ScreenToClient(R.BottomRight);

  if FIsRectSelecting then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
    Canvas.Rectangle(FSelectRect);
    SelectObjectsInRect(FSelectRect);
    Canvas.Brush.Color := BGColor;
    Canvas.Brush.Style := bsSolid;
    Canvas.Pen.Color := FGColor;
    Canvas.Pen.Mode := pmCopy;
    ShowAll;
  end
  else
  begin
    ReleaseCapture;
    if PtInRect(R, pt) then
    begin
      // if GetCaptureControl <> Self then     SetCaptureControl(Self);
      found := FindVCLWindow(Mouse.CursorPos);
      if Assigned(found) and (found <> Self) and found.Visible then
      begin
        if (found is TMemo) then
          found := (found as TMemo).Parent;

        if Assigned(TCrackControl(found).PopupMenu) and (Button = mbRight) then
          TCrackControl(found).PopupMenu.Popup(Mouse.CursorPos.X,
            Mouse.CursorPos.Y);

        if Assigned(TCrackControl(found).OnMouseUp) then
        begin
          p2 := found.ScreenToClient(Mouse.CursorPos);
          TCrackControl(found).OnMouseUp(found, Button, Shift, p2.X, p2.Y);
        end;
      end
      else if (Button = mbRight) then
        if ClickOnConnection then
          PopupMenuConnection.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
        else
          PopupMenuWindow.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    end;
  end;
  FIsRectSelecting := False;
end;

function TEssConnectPanel.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;

const
  WHEEL_DIVISOR = 120; // Mouse Wheel standard
var
  mdy: Integer;
begin
  mdy := TScrollBox(Parent).VertScrollBar.Position - WheelDelta;
  TScrollBox(Parent).VertScrollBar.Position := mdy;
  Result := True;
end;

procedure TEssConnectPanel.OnManagedObjectClick(Sender: TObject);
begin
  var
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnClick) then
    inst.FOnClick(Sender);
end;

procedure TEssConnectPanel.OnManagedObjectDblClick(Sender: TObject);
begin
  var
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnDblClick) then
  begin
    MouseDownOK := False;
    ClearSelection;
    inst.FOnDblClick(Sender);
  end;
end;

procedure TEssConnectPanel.OnManagedObjectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  if (not Focused) or (GetCaptureControl <> Self) then
  begin
    // Call the essConnectpanel MouseDown instead.
    pt.X := X;
    pt.Y := Y;
    pt := (Sender as TControl).ClientToScreen(pt);
    pt := ScreenToClient(pt);
    MouseDown(Button, Shift, pt.X, pt.Y);
  end;
end;

procedure TEssConnectPanel.OnManagedObjectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  var
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnMouseMove) then
    inst.FOnMouseMove(Sender, Shift, X, Y);
end;

procedure TEssConnectPanel.OnManagedObjectMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  var
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnMouseUp) then
    inst.FOnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TEssConnectPanel.Paint;
begin
  if IsMoving or (UpdateCounter > 0) then
    Exit; // this inhibits painting while moving
  Canvas.Pen.Mode := pmCopy;
  var
  Rect := ClientRect;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  Canvas.Brush.Color := BGColor;
  Canvas.Pen.Color := FGColor;
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
  for var i := 0 to FConnections.Count - 1 do
  begin
    var
    conn := (FConnections[i] as TConnection);
    if conn.FFrom.Visible and conn.FTo.Visible then
      conn.Draw(Canvas, True);
  end;
end;

procedure TEssConnectPanel.HideConnections;
begin
  for var i := 0 to FConnections.Count - 1 do
    (FConnections[i] as TConnection).Draw(Canvas, False);
end;

procedure TEssConnectPanel.ShowCuttedConnections;
var
  i, k: Integer;
  conn: TConnection;
  AControl: TControl;
begin
  for i := 0 to FConnections.Count - 1 do
  begin
    conn := (FConnections[i] as TConnection);
    if conn.cutted and conn.FFrom.Visible and conn.FTo.Visible then
    begin
      conn.Draw(Canvas, True);
      // invalidate controls, which are cutted
      for k := 0 to FManagedObjects.Count - 1 do
      begin
        AControl := TManagedObject(FManagedObjects[k]).Control;
        if AControl.Visible and conn.square.intersects(AControl.BoundsRect) then
          AControl.Invalidate;
      end;
      conn.cutted := False;
    end;
  end;
end;

procedure TEssConnectPanel.RecalcSize;
var
  i, xmax, ymax: Integer;
begin
  if Assigned(Parent) then
  begin
    xmax := Parent.Width - 4; // 300;
    ymax := Parent.Height - 4; // 150;
  end
  else
  begin
    xmax := 300;
    ymax := 150;
  end;
  for i := 0 to ControlCount - 1 do
  begin
    if (Controls[i].Align <> alNone) or (not Controls[i].Visible) then
      Continue;
    xmax := Max(xmax, Controls[i].Left + Controls[i].Width + 30);
    ymax := Max(ymax, Controls[i].Top + Controls[i].Height + 30);
  end;
  if (Width <> xmax) or (Height <> ymax) then
    SetBounds(Left, Top, xmax, ymax);
  TScrollBox(Parent).HorzScrollBar.Visible := xmax >= Parent.Width;
  TScrollBox(Parent).VertScrollBar.Visible := ymax >= Parent.Height;
  if Assigned(OnContentChanged) then
    OnContentChanged(nil);
end;

procedure TEssConnectPanel.GetDiagramSize(var W, H: Integer);
begin
  W := 300;
  H := 150;
  for var i := 0 to ControlCount - 1 do
  begin
    if (Controls[i].Align <> alNone) or (not Controls[i].Visible) then
      Continue;
    W := Max(W, Controls[i].Left + Controls[i].Width + 10 +
      getRecursivXEnlarge(Controls[i]));
    H := Max(H, Controls[i].Top + Controls[i].Height + 10 +
      getRecursivYEnlarge(Controls[i]));
  end;
end;

function TEssConnectPanel.GetSelectedRect: TRect;
var
  C: TControl;
  i, j, dl, dr, dt, db, Count: Integer;
  R: TRect;
  conn: TConnection;
begin
  Count := 0;
  Result := Rect(MaxInt, MaxInt, 0, 0);
  if Assigned(FManagedObjects) then
    for i := 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
      begin
        C := TManagedObject(FManagedObjects[i]).FControl;
        R := C.BoundsRect;
        dl := 0;
        dr := 0;
        dt := 0;
        db := 0;
        for j := 0 to FConnections.Count - 1 do
        begin
          conn := TConnection(FConnections[j]);
          if conn.isRecursiv and ((conn.FFrom = C) or (conn.FTo = C)) then
          begin
            dl := Max(dl, conn.XDecrease);
            dr := Max(dr, conn.XEnlarge);
            dt := Max(dt, conn.YDecrease);
            db := Max(db, conn.YEnlarge);
          end;
        end;
        if R.Top - dt < Result.Top then
          Result.Top := R.Top - dt;
        if R.Left - dl < Result.Left then
          Result.Left := R.Left - dl;
        if R.Bottom + db > Result.Bottom then
          Result.Bottom := R.Bottom + db;
        if R.Right + dr > Result.Right then
          Result.Right := R.Right + dr;
        Inc(Count);
      end;
  if Count = 0 then
    Result := Rect(0, 0, 0, 0)
end;

procedure TEssConnectPanel.SelectObjectsInRect(SelRect: TRect);
var
  i: Integer;
  R1, R2: TRect;
  AControl: TControl;
begin
  R1 := SelRect;
  if SelRect.Top > SelRect.Bottom then
  begin
    SelRect.Top := R1.Bottom;
    SelRect.Bottom := R1.Top;
  end;
  if SelRect.Left > SelRect.Right then
  begin
    SelRect.Left := R1.Right;
    SelRect.Right := R1.Left;
  end;

  if Assigned(FManagedObjects) then
    for i := 0 to FManagedObjects.Count - 1 do
    begin
      if Assigned(TManagedObject(FManagedObjects[i]).FControl) then
      begin
        AControl := TManagedObject(FManagedObjects[i]).FControl;
        R1 := AControl.BoundsRect;
        IntersectRect(R2, SelRect, R1);
        if EqualRect(R1, R2) and TManagedObject(FManagedObjects[i]).FControl.Visible
        then
          TManagedObject(FManagedObjects[i]).Selected := True;
      end;
    end;
end;

procedure TEssConnectPanel.SetFocus;
begin
  Anchors := [akTop, akLeft];
  // Try to see if we can call inherited, otherwise there is a risc of getting
  // 'Cannot focus' exception when starting from delphi-tools.
  if CanFocus and Assigned(myForm) then
  begin
    // To avoid having the scrollbox resetting its positions after a setfocus call.
    var
    X := (Parent as TScrollBox).HorzScrollBar.Position;
    var
    Y := (Parent as TScrollBox).VertScrollBar.Position;
    // inherited;
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
    if Assigned(OnModified) then
      OnModified(Value);
  end;
end;

procedure TEssConnectPanel.SetSelectedOnly(const Value: Boolean);
var
  i: Integer;
begin
  if FSelectedOnly <> Value then
  begin
    FSelectedOnly := Value;
    if FSelectedOnly then
    begin
      TempHidden.Clear;
      for i := 0 to FManagedObjects.Count - 1 do
        if (not TManagedObject(FManagedObjects[i]).Selected) and
          TManagedObject(FManagedObjects[i]).FControl.Visible then
        begin
          TManagedObject(FManagedObjects[i]).FControl.Visible := False;
          TempHidden.Add(TObject(FManagedObjects[i]));
        end;
    end
    else
    begin
      for i := 0 to TempHidden.Count - 1 do
        TManagedObject(TempHidden[i]).FControl.Visible := True;
      TempHidden.Clear;
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
  for var i := 0 to FConnections.Count - 1 do
  begin
    var
    conn := TConnection(FConnections[i]);
    case Value of
      0:
        conn.Visible := True;
      1:
        conn.Visible := (conn.ArrowStyle <> asInstanceOf);
    else
      conn.Visible := False;
    end;
  end;
end;

procedure TEssConnectPanel.SetShowObjectDiagram(b: Boolean);
begin
  if Assigned(FManagedObjects) then
    for var i := 0 to FManagedObjects.Count - 1 do
    begin
      var AControl := TManagedObject(FManagedObjects[i]).FControl;
      if AControl is TRtfdClass then
      begin
        AControl.Visible := not b;
        if b then
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
    if Assigned(OnDeleteSelectedControls) then
      OnDeleteSelectedControls(Self);
    DeleteSelectedConnection;
    Invalidate;
  end;
end;

procedure TEssConnectPanel.TextTo(aCanvas: TCanvas);
// this was a hard way to find, Panel.PaintTo doesn't show the text.
var
  i, firstchar: Integer;
  aManagedObject: TManagedObject;
  CommentBox: TRtfdCommentBox;
  R: TRect;
  s: string;
begin
  if Assigned(FManagedObjects) then
    for i := 0 to FManagedObjects.Count - 1 do
    begin
      aManagedObject := TManagedObject(FManagedObjects[i]);
      if (aManagedObject.FControl is TRtfdCommentBox) then
      begin
        CommentBox := (aManagedObject.FControl as TRtfdCommentBox);
        aCanvas.Font := CommentBox.TrMemo.Font;
        aCanvas.Brush.Color := GuiPyOptions.CommentColor;
        CommentBox.TrMemo.perform(em_getrect, 0, lparam(@R));
        // TODO em_getrect aus MyMsic
        firstchar := CommentBox.TrMemo.perform(EM_LINEINDEX,
          // TODO EM_GETFIRSTVISIBLELINE from MyMisc
          CommentBox.TrMemo.perform(em_getfirstvisibleline, 0, 0), 0);
        s := Copy(CommentBox.TrMemo.text, firstchar + 1, MaxInt);
        aCanvas.TextOut(R.Left, R.Top, ' '); // ensures font is selected
        OffsetRect(R, CommentBox.Left + CommentBox.TrMemo.Left,
          CommentBox.Top + CommentBox.TrMemo.Top);
        DrawTextEx(aCanvas.handle, @s[1], Length(s), R, DT_WORDBREAK or
          DT_LEFT or DT_EDITCONTROL, nil);
      end;
    end;
end;

function TEssConnectPanel.getClipRect: TRect;
var
  MovedRect: TRect;
  i: Integer;
  mcont: TManagedObject;
  curr: TCrackControl;
begin
  MovedRect := Rect(MaxInt, 0, 0, 0);
  if Assigned(FManagedObjects) then
    for i := 0 to FManagedObjects.Count - 1 do
    begin
      mcont := TManagedObject(FManagedObjects[i]);
      curr := TCrackControl(mcont.FControl);
      if MovedRect.Left = MaxInt then
        MovedRect := curr.BoundsRect
      else
        UnionRect(MovedRect, curr.BoundsRect, MovedRect);
    end;
  Result := MovedRect;
end;

procedure TEssConnectPanel.ChangeStyle(BlackAndWhite: Boolean = False);
var
  i: Integer;
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
  Color := BGColor;
  Canvas.Pen.Color := FGColor;
  Canvas.Brush.Color := BGColor;
  for i := 0 to FConnections.Count - 1 do
    TConnection(FConnections[i]).ChangeStyle(BlackAndWhite);
  for i := 0 to FManagedObjects.Count - 1 do
    (TManagedObject(FManagedObjects[i]).FControl as TRtfdBox)
      .ChangeStyle(BlackAndWhite);
end;

function TEssConnectPanel.getSVGConnections: string;
begin
  var s := '';
  for var i:= 0 to FConnections.Count - 1 do begin
    var conn:= (FConnections[i] as TConnection);
    if conn.FFrom.Visible and conn.FTo.Visible then
      s := s + conn.getSVG;
  end;
  Result := s;
end;

procedure TEssConnectPanel.CheckRoleHidesAttribute(conn: TConnection;
  Attributes: TConnectionAttributes);
var
  it: IModelIterator;
  C: TClass;
  Attribute: TAttribute;
  HiddenChanged: Boolean;
begin
  if conn.FTo is TRtfdClass then
  begin
    HiddenChanged := False;
    C := (conn.FTo as TRtfdClass).Entity as TClass;
    it := C.GetAllAttributes;
    while it.HasNext do
    begin
      Attribute := it.Next as TAttribute;
      if not Attribute.Hidden and ((Attribute.Name = Attributes.RoleA) or
        (Attribute.Name + '[]' = Attributes.RoleA)) then
      begin
        Attribute.Hidden := True;
        HiddenChanged := True;
      end
      else if Attribute.Hidden and (Attribute.Name = WithoutArray(conn.RoleA))
        and (conn.RoleA <> Attributes.RoleA) then
      begin
        Attribute.Hidden := False;
        HiddenChanged := True;
      end;
    end;
    if HiddenChanged then
      (conn.FTo as TRtfdClass).RefreshEntities;
  end;
  if conn.FFrom is TRtfdClass then
  begin
    HiddenChanged := False;
    C := (conn.FFrom as TRtfdClass).Entity as TClass;
    it := C.GetAllAttributes;
    while it.HasNext do
    begin
      Attribute := it.Next as TAttribute;
      if not Attribute.Hidden and ((Attribute.Name = Attributes.RoleB) or
        (Attribute.Name + '[]' = Attributes.RoleB)) then
      begin
        Attribute.Hidden := True;
        HiddenChanged := True;
      end
      else if Attribute.Hidden and (Attribute.Name = WithoutArray(conn.RoleB))
        and (conn.RoleB <> Attributes.RoleB) then
      begin
        Attribute.Hidden := False;
        HiddenChanged := True;
      end;
    end;
    if HiddenChanged then
      (conn.FFrom as TRtfdClass).RefreshEntities;
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
