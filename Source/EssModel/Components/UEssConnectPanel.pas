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


{ Gedanken zur Darstellung im UML-Fenster

 einfaches Anklicken/MouseDown
   Hier muss der Hintergrund nicht geleert werden, es reicht wenn die Boxen neu
   gezeichnet werden.

   Wenn zwei Boxen sich überlappen muss jeweils die angeklickt Box in den
   Vordergrund gebracht werden. Daher muss auf alle Fälle beim Anklicken
   die gesamte Box gezeichnet werden, es reicht nicht nur die Markierungen
   zu zeichnen.

}

unit UEssConnectPanel;

interface

uses
  Windows, Messages, Menus, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Contnrs, UUtils, UConnection;

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
    TempHidden : TObjectList;
    BGColor: TColor;
    FGColor: TColor;

    procedure SetSelectedOnly(const Value : boolean);
  protected
    { Protected declarations }
    FManagedObjects: TList;
    FConnections: TObjectList;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Click; override;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd);
      message WM_ERASEBKGND;

    procedure SelectObjectsInRect(SelRect: TRect);
    procedure OnManagedObjectMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnManagedObjectClick(Sender: TObject);
    procedure OnManagedObjectDblClick(Sender: TObject);

    procedure Paint; override;
    function ClickOnConnection: boolean;
    procedure HideConnections;
    procedure ShowCuttedConnections;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;

  public
    OnContentChanged : TNotifyEvent;
    OnModified: TBoolEvent; // TNotifyEvent
    OnDeleteSelectedControls: TNotifyEvent;
    OnClassEditSelectedDiagramElements: TNotifyEvent;

    PopupMenuConnection: TPopupMenu;
    PopupMenuAlign: TPopupMenu;
    PopupMenuWindow: TPopupMenu;

    FIsModified: Boolean;
    FIsMoving: Boolean;
    FIsRectSelecting: Boolean;
    FSelectedOnly: Boolean;
    FResized: boolean;
    FShowConnections: integer;
    MouseDownOK: boolean;
    myForm: TForm;

    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function FindManagedControl( AControl: TControl ): TManagedObject;
    // Add a control to the managed list
    function AddManagedObject(AObject: TControl): TControl;

    function GetFirstManaged: TControl;
    // Returns a list containing all the managed controls.
    // The list should be freed by the caller.
    function GetManagedObjects: TList;

    function GetFirstSelected: TControl;
    // Returns a objectlist containing the selected controls.
    // The list should be freed by the caller.
    function GetSelectedControls : TObjectList;
    procedure DeleteSelectedControls;
    function CountSelectedControls: integer;
    function HasSelectedControls: boolean;

    // Returns a list with all interobject connections.
    // The list should be freed by the caller.
    function GetConnections : TList;
    procedure SetConnection(i: Integer; Arrow: TessConnectionArrowStyle); overload;
    procedure SetConnection(i: Integer; Attributes: TConnectionAttributes); overload;
    procedure SetSelectedConnection(Attributes: TConnectionAttributes);
    function getConnection(i: integer): TConnection;
    function HaveConnection(Src, Dest: TControl): integer; overload;
    function HaveConnection(Src, Dest: TControl; ArrowStyle: TessConnectionArrowStyle): integer; overload;
    function CountConnections(Src, Dest: TControl): integer;
    function getRecursivConnection(Src: TControl): TConnection;
    function getRecursivXEnlarge(Control: TControl): integer;
    function getRecursivYEnlarge(Control: TControl): integer;
    function getRecursivXDecrease(Control: TControl): integer;
    function getRecursivYDecrease(Control: TControl): integer;
    procedure DeleteConnections;
    procedure DeleteSelectedConnection;
    procedure DeleteNotEditedConnections;
    procedure DeleteObjectConnections;
    function HasSelectedConnection: boolean;
    function GetClickedConnectionNr: integer;
    function GetClickedConnection: TConnection;
    function GetSelectedConnection: TConnection;

    // Add a connection from Src to Dst with the supplied style
    procedure ConnectObjects(Src, Dst: TControl; Attributes: TConnectionAttributes); overload;
    procedure ConnectObjects(Src, Dst: TControl; Arrow: TessConnectionArrowStyle); overload;
    procedure EditParallelConnections;
    procedure DoConnection(Item: integer);
    procedure DoAlign(Item: integer);
    procedure TurnConnection(i: integer);
    procedure DeleteConnection(i: integer);
    procedure setRecursiv(P: TPoint; pos: integer);
    procedure ClearManagedObjects;
    procedure CheckRoleHidesAttribute(conn: TConnection; Attributes: TConnectionAttributes);
    procedure ShowConnections;

    // Unselect all selected objects
    procedure ClearSelection(WithShowAll: boolean = true);
    function SelectionChangedOnClear: boolean;
    procedure ClearMarkerAndConnections(aControl: TControl);
    procedure ShowAll;
    procedure ShowAllIntersecting(R: TRect);
    procedure DrawMarkers(r: TRect; show: boolean);
    procedure SetFocus; override;
    procedure SelectAssociation;
    procedure ConnectBoxes(Src, Dest: TControl);
    procedure SetConnections(Value: integer);
    procedure SetShowObjectDiagram(b: boolean);
    procedure GetDiagramSize(var W, H: integer);
    function GetSelectedRect: TRect;
    procedure RecalcSize;
    procedure TextTo(aCanvas: TCanvas);
    function getClipRect: TRect;
    procedure CloseEdit;
    procedure EditBox(Control: TControl);
    procedure SetModified(const Value: boolean);

    procedure ChangeStyle;

    property IsModified: Boolean read FIsModified write SetModified;
    property IsMoving: boolean read FIsMoving write FIsMoving;
    // Bitmap to be used as background for printing
    property BackBitmap : TBitmap read FBackBitmap write FBackBitmap;
    // Only draw selected
    property SelectedOnly: boolean read FSelectedOnly write SetSelectedOnly;
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

uses Math, Types, UITypes, StdCtrls, Themes,
     UStyledMemo, UModel, UModelEntity,
     UConfiguration, UAssociation, URtfdComponents;


{--- TessConnectPanel ---------------------------------------------------------}

// http://www.delphipages.com/forum/showthread.php?t=75521
// https://www.mail-archive.com/lazarus@lists.lazarus.freepascal.org/msg08316.html
type  TCrackControl = class(TControl);

{ TessConnectPanel }
function TessConnectPanel.AddManagedObject(AObject: TControl): TControl;
var
  crkObj : TCrackControl;
  newObj: TManagedObject;
begin
  Result := nil;
  if AObject.Left + AObject.Width > Width  then Width := Max(Width, AObject.Left + AObject.Width + 50);
  if AObject.Top + AObject.Height > Height then Height:= Max(Height, AObject.Top + AObject.Height + 50);

  AObject.Parent := Self;
  AObject.Visible := True;
  if FindManagedControl(AObject) = nil then begin
    newObj := TManagedObject.Create;
    newObj.FControl := AObject;
    //newObj.Visible:= true;
    FManagedObjects.Add(newObj);

    // if not (AObject is TRtfdCommentBox) then begin
    crkObj := TCrackControl(AObject);
    newObj.FOnMouseDown:= crkObj.OnMouseDown;
    newObj.FOnMouseMove:= crkObj.OnMouseMove;
    newObj.FOnMouseUp  := crkObj.OnMouseUp;
    newObj.FOnClick    := crkObj.OnClick;
    newObj.FOnDblClick := crkObj.OnDblClick;

    crkObj.OnMouseDown := {$IFDEF LCL}@{$ENDIF}OnManagedObjectMouseDown;
    crkObj.OnMouseMove := {$IFDEF LCL}@{$ENDIF}OnManagedObjectMouseMove;
    crkObj.OnMouseUp   := {$IFDEF LCL}@{$ENDIF}OnManagedObjectMouseUp;
    crkObj.OnClick     := {$IFDEF LCL}@{$ENDIF}OnManagedObjectClick;
    crkObj.OnDblClick  := {$IFDEF LCL}@{$ENDIF}OnManagedObjectDblClick;
    //end;
    Result := AObject;
  end;
end;

procedure TessConnectPanel.ClearManagedObjects;
var
  i: Integer; aManagedObject: TManagedObject;
begin
  FConnections.Clear;
  if assigned(FManagedObjects) then begin
    for i:= 0 to FManagedObjects.Count - 1 do begin
      aManagedObject:= TManagedObject(FManagedObjects[i]);
      FreeAndNil(aManagedObject);
    end;
    FManagedObjects.Clear;
  end;
  SetBounds(0, 0, 0, 0);
  IsModified := False;
end;

function TessConnectPanel.SelectionChangedOnClear: boolean;
  var i: Integer;
begin
  Result:= false;
  if assigned(FManagedObjects) then begin
    for i:= 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).Selected and TManagedObject(FManagedObjects[i]).Control.Visible then begin
        TManagedObject(FManagedObjects[i]).Selected:= false;
        Result:= true;
      end;
  end;
  for i:= 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then begin
      TConnection(FConnections[i]).Selected:= false;
      TConnection(FConnections[i]).DrawSelection(Canvas, false);
      Result:= true;
    end;
end;

procedure TessConnectPanel.ClearSelection(WithShowAll: boolean = true);
  var i: Integer;
begin
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do
      TManagedObject(FManagedObjects[i]).Selected:= false;
  if assigned(FConnections) then
    for i:= 0 to FConnections.Count - 1 do
      TConnection(FConnections[i]).Selected:= false;
  if withShowAll then
    ShowAll;
end;

procedure TessConnectPanel.ClearMarkerAndConnections(aControl: TControl);
  var i: integer; conn: TConnection;
begin
  DrawMarkers((aControl as TRtfdBox).GetBoundsRect, false);
  for i:= 0 to FConnections.Count -1 do begin
    conn:= (FConnections[i] as TConnection);
    if conn.visible and ((conn.FFrom = aControl) or (Conn.FTo = aControl)) then
      Conn.Draw(Canvas, false);
  end;
end;

procedure TessConnectPanel.ShowAll;
  var i: Integer;
begin
  HideConnections;
  if assigned(FManagedObjects) then begin
    for i:= 0 to FManagedObjects.Count -1 do
      if TManagedObject(FManagedObjects[i]).FControl.Visible then
        TManagedObject(FManagedObjects[i]).FControl.Invalidate;
    ShowConnections;
  end;
end;

procedure TessConnectPanel.CloseEdit;
  var i: integer; aBox: TRtfdBox;
begin
  if assigned(FManagedObjects) then begin
    for i:= 0 to FManagedObjects.Count -1 do begin
      aBox:= TManagedObject(FManagedObjects[i]).FControl as TRtfdBox;
      aBox.CloseEdit;
    end;
  end;
end;

procedure TessConnectPanel.EditBox(Control: TControl);
begin
  if assigned(OnClassEditSelectedDiagramElements) then
    OnClassEditSelectedDiagramElements(Control);
end;

procedure TessConnectPanel.ShowAllIntersecting(R: TRect);
  var i: Integer; aControl: TControl;

  // https://wiki.lazarus.freepascal.org/Developing_with_Graphics#Motion_Graphics_-_How_to_Avoid_flickering

  function Intersect(const R1, R2: TRect): Boolean;
  begin
    Result := not ( (R1.BottomRight.X <= R2.TopLeft.X) or
                    (R1.BottomRight.Y <= R2.TopLeft.Y) or
                    (R2.BottomRight.X <= R1.TopLeft.X) or
                    (R2.BottomRight.Y <= R1.TopLeft.Y) );
  end;

begin
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do begin
      aControl:= TManagedObject(FManagedObjects[i]).Control;
      if aControl.Visible and Intersect(R, aControl.BoundsRect) then
        aControl.Invalidate;
    end;
end;

procedure TessConnectPanel.DrawMarkers(r: TRect; show: boolean);

  procedure MarkerPart(x, y: integer);
    var r: TRect;
  begin
    r:= Rect(x, y, x + HandleSize, y + HandleSize);
    Canvas.FillRect(r);
  end;

begin
  with Canvas do begin
    InflateRect(r, HandleSize, HandleSize);
    if Show
      then Brush.Color:= FGColor
      else Brush.Color:= BGColor;
    MarkerPart(r.Left, r.Top);
    MarkerPart(r.Right - HandleSize, r.Top);
    MarkerPart(r.Right - HandleSize, r.Bottom - HandleSize);
    MarkerPart(r.Left, r.Bottom - HandleSize);
  end;
end;

procedure TessConnectPanel.Click;
begin
end;

procedure TessConnectPanel.CMMouseLeave(var Message: TMessage);
var
  pt: TPoint;
  r: TRect;
begin
  pt := Mouse.CursorPos;

  IntersectRect(r, Parent.ClientRect,BoundsRect);
  r.TopLeft := Parent.ClientToScreen(r.TopLeft);
  r.BottomRight := Parent.ClientToScreen(r.BottomRight);
  if (not PtInRect(r,pt)) and not (FIsRectSelecting) then
    ReleaseCapture;
end;

procedure TessConnectPanel.WMEraseBkgnd(var Message: TWmEraseBkgnd);
var
  can : Tcanvas;
begin
  can := tcanvas.create;
  try
    can.handle := message.DC;
    if Assigned(FBackBitmap) then
      Can.Brush.Bitmap := FBackBitmap
    else
      Can.Brush.Color := Color;
    Can.FillRect(ClientRect);
  finally
    FreeAndNil(can);
  end;
  Message.Result := 1;
end;

procedure TessConnectPanel.EditParallelConnections;
  var i, j, parallelindex, parallelcount: integer;
      conn1, conn2: TConnection;
begin
  for i:= 0 to FConnections.Count - 1 do begin
    conn1:= TConnection(FConnections[i]);
    conn1.parallelindex:= 0;
    conn1.parallelcount:= 0;
    conn1.parallelvisited:= false;
    conn1.parallelvisiting:= false;
  end;
  for i:= 0 to FConnections.Count - 2 do begin
    conn1:= TConnection(FConnections[i]);
    if not conn1.parallelvisited then begin
      for j:= i + 1 to FConnections.Count - 1 do begin
        conn2:= TConnection(FConnections[j]);
        if (conn1.FFrom = conn2.FFrom) and (conn1.FTo = conn2.FTo) or
           (conn1.FFrom = conn2.FTo) and (conn1.FTo = conn2.FFrom)
        then begin
          inc(conn1.parallelcount);
          conn2.parallelvisiting:= true; // simplify second search
        end;
      end;
      parallelindex:= 0;
      parallelcount:= conn1.parallelcount;
      if parallelcount > 0 then
        for j:= i + 1 to FConnections.Count - 1 do begin
          conn2:= TConnection(FConnections[j]);
          if not conn2.parallelvisited and conn2.parallelvisiting then begin
            conn2.parallelvisited:= true;
            inc(parallelindex);
            conn2.parallelindex:= parallelindex;
            conn2.parallelcount:= parallelcount;
          end;
        end;
      conn1.parallelvisited:= true;
    end;
  end;
  for i:= 0 to FConnections.Count - 1 do
    TConnection(FConnections[i]).parallelCorrection;
end;

procedure TessConnectPanel.ConnectObjects(Src, Dst: TControl; Attributes: TConnectionAttributes);
  var conn: TConnection;
begin
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) then begin
    conn:= TConnection.Create(Src, Dst, Attributes, Canvas);
    if GuiPyOptions.RoleHidesAttribute then
      CheckRoleHidesAttribute(conn, Attributes);
    FConnections.Add(conn);
    EditParallelConnections;
  end;
end;

procedure TessConnectPanel.ConnectObjects(Src, Dst: TControl; Arrow: TessConnectionArrowStyle);
  var Attributes: TConnectionAttributes;
begin
  if (FindManagedControl(Src) <> nil) and (FindManagedControl(Dst) <> nil) and
     (HaveConnection(Src, Dst, Arrow) = -1) then begin
    Attributes:= TConnectionAttributes.Create;
    try
      Attributes.ArrowStyle:= Arrow;
      if Src = Dst then Attributes.RecursivCorner:= 1;
      Attributes.Visible:= (FShowConnections = 0) or
                           ((FShowConnections = 1) and (Src.ClassType = Dst.ClassType));
      if Arrow = asComment then
        Attributes.isEdited:= true;

      ConnectObjects(Src, Dst, Attributes);
    finally
      FreeAndNil(Attributes);
    end;
    ClearSelection(false);
  end;
end;

procedure TessConnectPanel.DeleteObjectConnections;
  var conn: TConnection; i: integer;
begin
  for i:= FConnections.Count - 1 downto 0 do begin
    conn:= TConnection(FConnections[i]);
    if (conn.FFrom is TRtfdObject) and (conn.FTo is TRtfdObject) then
      FConnections.Delete(i);
  end;
  EditParallelConnections;
end;

function TessConnectPanel.getRecursivConnection(Src: TControl): TConnection;
  var i: integer;
begin
  i:= HaveConnection(Src, Src);
  if i > -1
    then Result:= TConnection(FConnections[i])
    else Result:= nil;
end;

procedure TessConnectPanel.DeleteConnections;
begin
  FConnections.Clear;
end;

constructor TessConnectPanel.Create(AOwner: TComponent);
begin
  inherited;
  myForm:= AOwner as TForm;
  FManagedObjects := TList.Create;
  FConnections := TObjectList.Create(True);
  FShowConnections:= 0;
  TempHidden := TObjectList.Create(False);
  UseDockManager := True;
  MouseDownOK:= True;
  ChangeStyle;
  SetFocus;
end;

procedure TessConnectPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Params.Style := Params.Style and (not WS_CLIPCHILDREN);
end;

procedure TessConnectPanel.DblClick;
  var found: TControl;
begin
  inherited;
  found:= FindVCLWindow(Mouse.CursorPos);
  if Assigned(found) then begin
    FindManagedControl(found);
    if found <> Self then
      TCrackControl(found).DblClick;
    if (GetClickedConnectionNr <> -1) then
      SelectAssociation;
  end
end;

function TEssConnectPanel.GetClickedConnectionNr: integer;
  var P: TPoint; conn: TConnection;
begin
  P:= Self.ScreenToClient(Mouse.CursorPos);
  Result:= 0;
  while Result < FConnections.Count do begin
    Conn:= TConnection(FConnections[Result]);
    if Conn.IsClicked(P) then exit;
    inc(Result);
  end;
  Result:= -1;
end;

function TEssConnectPanel.GetClickedConnection: TConnection;
  var Nr: integer;
begin
  Nr:= GetClickedConnectionNr;
  if Nr <> -1
    then Result:= TConnection(FConnections[Nr])
    else Result:= nil;
end;

function TessConnectPanel.ClickOnConnection: boolean;
  var Nr: integer;
begin
  Nr:= GetClickedConnectionNr;
  Result:= (Nr <> -1);
end;

procedure TEssConnectPanel.TurnConnection(i: Integer);
begin
  TConnection(FConnections[i]).Turn;
end;

procedure TEssConnectPanel.DeleteConnection(i: Integer);
  var conn: TConnection;
begin
  conn:= TConnection(FConnections[i]);
  conn.Selected:= false;
  conn.DrawSelection(Canvas, false);
  conn.Draw(Canvas, false);
  FConnections.delete(i);
end;

procedure TEssConnectPanel.setRecursiv(P: TPoint; pos: integer);
  var conn: TConnection;  i: integer;
begin
  P:= Self.ScreenToClient(P);
  i:= 0;
  while i < FConnections.Count do begin
    Conn:= TConnection(FConnections[i]);
    if Conn.IsClicked(P) then break;
    inc(i);
  end;
  if (i < FConnections.Count) then begin
    TConnection(FConnections[i]).setRecursivPosition(pos);
    Invalidate;
  end;
end;

procedure TessConnectPanel.SelectAssociation;
  var i: integer;
      Tmp : TObjectList;
      Attributes: TConnectionAttributes;
      conn: TConnection; 
      SelectedControls: integer;
      FAssociation: TFAssociation;
begin
  FAssociation:= TFAssociation.Create(Self);
  conn:= getSelectedConnection;
  SelectedControls:= CountSelectedControls;
  if conn = nil then
    case SelectedControls of
      1: FAssociation.init(false, conn, 1);
      2: FAssociation.init(false, conn, 2)
      else exit;
    end
  else
    FAssociation.init(false, conn, SelectedControls);

  case FAssociation.ShowModal of
    mrOK: begin
      Attributes:= FAssociation.getConnectionAttributes;
      if HasSelectedConnection then
        SetSelectedConnection(Attributes)
      else begin
        Tmp:= GetSelectedControls;
        case Tmp.Count of
          1: ConnectObjects(Tmp[0] as TControl, Tmp[0] as TControl, Attributes);
          2: ConnectObjects(Tmp[0] as TControl, Tmp[1] as TControl, Attributes);
        end;
        FreeAndNil(Tmp);
      end;
      FreeAndNil(Attributes);
    end;
    mrYes: // turn
      for i:= 0 to FConnections.Count - 1 do
        if TConnection(FConnections[i]).Selected then
          TurnConnection(i);
    mrNo:
      DeleteSelectedConnection;
  end;
  FAssociation.Release;
  Invalidate;
  ShowAll;
  IsModified:= true;
end;

procedure TessConnectPanel.ConnectBoxes(Src, Dest: TControl);
  var Attributes: TConnectionAttributes;
      SelectedControls: integer;
      FAssociation: TFAssociation;
begin
  FAssociation:= TFAssociation.Create(Self);
  SelectedControls:= CountSelectedControls;
  case SelectedControls of
    1: FAssociation.init(false, nil, 1);
    2: FAssociation.init(false, nil, 2)
    else exit;
  end;
  if Dest is TRtfdCommentBox then begin
    Attributes:= FAssociation.getConnectionAttributes;
    Attributes.ArrowStyle:= asComment;
    ConnectObjects(Src, Dest, Attributes);
    FreeAndNil(Attributes);
  end else if FAssociation.ShowModal =  mrOK then begin
    Attributes:= FAssociation.getConnectionAttributes;
    case SelectedControls of
      1: ConnectObjects(Src, Src, Attributes);
      2: ConnectObjects(Src, Dest, Attributes);
    end;
    FreeAndNil(Attributes);
  end;
  ClearSelection(true);
  //Invalidate;
  IsModified:= true;
  FAssociation.Release;
end;

procedure TEssConnectPanel.DoConnection(Item: integer);
  var i, n: integer;
begin
  n:= -1;
  for i:= 0 to FConnections.Count-1 do
    if TConnection(FConnections[i]).Selected then
      n:= i;
  if n <> -1 then begin
    case Item of
       0..9: SetConnection(n, TessConnectionArrowStyle(Item));
       10  : SelectAssociation;
       11  : TurnConnection(n);
      else begin
        DeleteConnection(n);
        EditParallelConnections;
      end;
    end;
    ShowAll;
    IsModified:= true;
  end;
end;

procedure TEssConnectPanel.DoAlign(Item: integer);
  var i, aLeft, Right, aTop, Bottom, VMiddle, HMiddle: integer;
      Control: TControl;
begin
  if not assigned(FManagedObjects) then
    exit;
  aLeft := +MaxInt;
  Right := -MaxInt;
  aTop  := +MaxInt;
  Bottom:= -MaxInt;
  for i:= 0 to FManagedObjects.Count-1 do
    if TManagedObject(FManagedObjects[I]).FSelected then begin
      Control:= TManagedObject(FManagedObjects[I]).Control;
      if Control.Left < aLeft then aLeft:= Control.Left;
      if Control.Left + Control.Width > Right then Right:= Control.Left + Control.Width;
      if Control.Top < aTop then aTop:= Control.Top;
      if Control.Top + Control.Height > Bottom then Bottom:= Control.Top + Control.Height;
    end;
  HMiddle:= (aLeft + Right) div 2;
  VMiddle:= (aTop + Bottom) div 2;
  for i:= 0 to FManagedObjects.Count-1 do
    if TManagedObject(FManagedObjects[I]).FSelected then begin
      Control:= TManagedObject(FManagedObjects[I]).Control;
      case Item of
        1: Control.Left:= aLeft;
        2: Control.Left:= HMiddle - Control.Width div 2; // - Control.Width mod 2;
        3: Control.Left:= Right - Control.Width;
        4: Control.Top:= aTop;
        5: Control.Top:= VMiddle - Control.Height div 2; //- Control.Height mod 2;
        6: Control.Top:= Bottom - Control.Height;
      end;
    end;
  Invalidate;
end;

destructor TessConnectPanel.Destroy;
begin
  FreeAndNil(TempHidden);
  ClearManagedObjects;
  FreeAndNil(FManagedObjects);
  FreeAndNil(FConnections);
  inherited;
end;

function TessConnectPanel.FindManagedControl(AControl: TControl): TManagedObject;
var
  i: Integer;
  curr: TManagedObject;
begin
  Result := nil;
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do begin
      curr := TManagedObject(FManagedObjects[i]);
      if curr.FControl = AControl then begin
        Result := curr;
        exit;
      end;
    end;
end;

function TessConnectPanel.GetConnections: TList;
var
  i: Integer;
begin
  Result:= TList.Create;
  for i:= 0 to FConnections.Count-1 do
    Result.Add(FConnections[I]);
end;

procedure TessConnectPanel.SetConnection(i: Integer; Attributes: TConnectionAttributes);
begin
  if (0 <= i) and (i < FConnections.Count) then
    TConnection(FConnections[i]).SetAttributes(Attributes);
end;

procedure TessConnectPanel.SetConnection(i: Integer; Arrow: TessConnectionArrowStyle);
begin
  if (0 <= i) and (i < FConnections.Count) then
    TConnection(FConnections[i]).setArrow(Arrow);
end;

procedure TessConnectPanel.SetSelectedConnection(Attributes: TConnectionAttributes);
  var i: integer; conn: TConnection;
begin
  for i:= 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then begin
      conn:= TConnection(FConnections[i]);
      if GuiPyOptions.RoleHidesAttribute then
        CheckRoleHidesAttribute(conn, Attributes);
      conn.SetAttributes(Attributes);
    end;
end;

function TessConnectPanel.getConnection(i: integer): TConnection;
begin
  Result:= TConnection(FConnections[i]);
end;

procedure TEssConnectPanel.DeleteSelectedConnection;
  var i: Integer;
begin
  for i:= FConnections.Count-1 downto 0 do
    if TConnection(FConnections[i]).Selected then begin
      DeleteConnection(i);
      IsModified:= true;
    end;
  EditParallelConnections;
end;

procedure TEssConnectPanel.DeleteNotEditedConnections;
  var i: Integer;
begin
  for i:= FConnections.Count-1 downto 0 do
    if not TConnection(FConnections[i]).isEdited
      then FConnections.delete(i);
  EditParallelConnections;
end;

function TEssConnectPanel.HasSelectedConnection: boolean;
  var i: Integer;
begin
  Result:= false;
  for i:= FConnections.Count-1 downto 0 do
    if TConnection(FConnections[i]).Selected then begin
      Result:= true;
      break;
    end;
end;

function TessConnectPanel.getSelectedConnection: TConnection;
  var i: integer;
begin
  Result:= nil;
  for i:= 0 to FConnections.Count - 1 do
    if TConnection(FConnections[i]).Selected then begin
      Result:= TConnection(FConnections[i]);
      exit;
    end;
end;

function TessConnectPanel.HaveConnection(Src, Dest: TControl): integer;
  var i: Integer; Conn: TConnection;
begin
  for i:= 0 to FConnections.Count-1 do begin
    Conn:= TConnection(FConnections[i]);
    if ((Conn.FFrom = Src) and (Conn.FTo = Dest)) or
       ((Conn.FFrom = Dest) and (Conn.FTo = Src)) then begin
      Result:= i;
      exit;
    end;
  end;
  Result:= -1;
end;

function TessConnectPanel.HaveConnection(Src, Dest: TControl; ArrowStyle: TessConnectionArrowStyle): integer;
  var i: Integer; Conn: TConnection;
begin
  for i:= 0 to FConnections.Count-1 do begin
    Conn:= TConnection(FConnections[i]);
    if (Conn.FFrom = Src) and (Conn.FTo = Dest) and (Conn.ArrowStyle = ArrowStyle) then begin
      Result:= i;
      exit;
    end;
  end;
  Result:= -1;
end;

function TessConnectPanel.CountConnections(Src, Dest: TControl): integer;
   var i: Integer; Conn: TConnection;
begin
  Result:= 0;
  for i:= 0 to FConnections.Count-1 do begin
    Conn:= TConnection(FConnections[i]);
    if ((Conn.FFrom = Src) and (Conn.FTo = Dest)) or
       ((Conn.FFrom = Dest) and (Conn.FTo = Src)) then
      inc(Result);
  end;
end;

function TessConnectPanel.getRecursivXEnlarge(Control: TControl): integer;
  var Conn: TConnection;  i, dl, dr: integer;
begin
  dl:= 0;
  dr:= 0;
  for i:= 0 to FConnections.Count - 1 do begin
    Conn:= TConnection(FConnections[i]);
    if Conn.isRecursiv and ((Conn.FFrom = Control) or (Conn.FTo = Control)) then begin
      dl:= max(dl, Conn.XDecrease);
      dr:= max(dr, Conn.XEnlarge);
    end;
  end;
  Result:= dl + dr;
end;

function TessConnectPanel.getRecursivYEnlarge(Control: TControl): integer;
  var Conn: TConnection;  i, dt, db: integer;
begin
  dt:= 0;
  db:= 0;
  for i:= 0 to FConnections.Count - 1 do begin
    Conn:= TConnection(FConnections[i]);
    if Conn.isRecursiv and ((Conn.FFrom = Control) or (Conn.FTo = Control)) then begin
      dt:= max(dt, Conn.YDecrease);
      db:= max(db, Conn.YEnlarge);
    end;
  end;
  Result:= dt + db;
end;

function TessConnectPanel.getRecursivXDecrease(Control: TControl): integer;
  var Conn: TConnection;
begin
  Conn:= getRecursivConnection(Control);
  if assigned(Conn)
    then Result:= Conn.XDecrease
    else Result:= 0;
end;

function TessConnectPanel.getRecursivYDecrease(Control: TControl): integer;
  var Conn: TConnection;
begin
  Conn:= getRecursivConnection(Control);
  if assigned(Conn)
    then Result:= Conn.YDecrease
    else Result:= 0;
end;

function TessConnectPanel.GetFirstManaged: TControl;
begin
  if FManagedObjects.Count > 0
    then Result:= TManagedObject(FManagedObjects[0]).FControl
    else Result:= nil;
end;

function TessConnectPanel.GetManagedObjects: TList;
  var i: Integer;
begin
  Result:= TList.Create;
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count-1 do
      Result.Add(TManagedObject(FManagedObjects[i]).FControl);
end;

function TessConnectPanel.CountSelectedControls: integer;
  var i, n: Integer;
begin
  n:= 0;
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count-1 do
      if TManagedObject(FManagedObjects[I]).FSelected then
        inc(n);
  Result:= n;
end;

function TessConnectPanel.HasSelectedControls: boolean;
  var i: Integer;
begin
  Result:= false;
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Exit(true);
end;

function TessConnectPanel.GetFirstSelected: TControl;
  var i: integer;
begin
  Result:= nil;
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Exit(TManagedObject(FManagedObjects[i]).FControl);
end;

function TessConnectPanel.GetSelectedControls: TObjectList;
  var i: Integer;
begin
  Result:= TObjectList.Create(false);
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count-1 do
      if TManagedObject(FManagedObjects[i]).FSelected then
        Result.Add(TManagedObject(FManagedObjects[i]).FControl);
end;

procedure TessConnectPanel.DeleteSelectedControls;
  var i, j: integer; Control: TControl; Conn: TConnection;  ManagedObject: TManagedObject;
begin
  if assigned(FManagedObjects) then
    for i:= FManagedObjects.Count - 1 downto 0 do
      if TManagedObject(FManagedObjects[i]).FSelected then begin
        ManagedObject:= TManagedObject(FManagedObjects[i]);
        Control:= TManagedObject(FManagedObjects[i]).FControl;
        for j:= FConnections.Count - 1 downto 0 do begin
          Conn:= TConnection(FConnections[j]);
          if (Conn.FFrom = Control) or (Conn.FTo = Control) then
            FConnections.Delete(j);
        end;
        FManagedObjects.Delete(i);
        FreeAndNil(ManagedObject);
        IsModified := True;
      end;
  EditParallelConnections;
  RecalcSize;
  ClearSelection;
end;

// zentrale MouseDown-Routine für das TessConnectPanel
procedure TessConnectPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  found: TControl;
  mcont: TManagedObject;
  cconn: TConnection;
  aChanged: boolean;
begin
  if not MouseDownOK then begin MouseDownOK:= true; exit end;
  inherited;
  if not (ssDouble in Shift) then
    CloseEdit;

  // repaint TrMemo
  if assigned(Application.MainForm.ActiveControl) and
      (Application.Mainform.ActiveControl is TMemo)
  then
    (Application.Mainform.ActiveControl as TMemo).Parent.Invalidate;

  SetFocus;  // a TPanel can have the Focus
  if GetCaptureControl <> Self then
    SetCaptureControl(Self);
  FIsRectSelecting := False;
  FIsMoving := False;
  FResized:= false;
  FMemMousePos.x := X;
  FMemMousePos.y := Y;
  aChanged:= false;

  if (Button = mbRight) and (CountSelectedControls > 1) then
    PopupMenuAlign.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
  else begin
    found:= FindVCLWindow(Mouse.CursorPos);
    if found = Self then
      found := nil;
    if Assigned(found) then begin
      mcont := FindManagedControl(found);
      if Assigned(mcont) then begin
        if not mcont.Selected then begin
          if (mcont.FControl is TRtfdBox) then
            (mcont.FControl as TRtfdBox).makeBitmap;
          if not CtrlPressed then
            SelectionChangedOnClear;
          if mcont.control.visible then begin
            mcont.Selected:= true;
            TManagedObject(mcont).FControl.SendToBack;
            aChanged:= true;
          end;
        end else if CtrlPressed then begin
          mcont.Selected:= false;
          aChanged:= true;
        end;
        if aChanged then
          ShowAll;
        if CountSelectedControls > 0 then
          FIsMoving:= true;
      end;
    end else begin
      cconn:= GetClickedConnection;
      if Assigned(cconn) then begin
        if not cconn.Selected then begin
          if not CtrlPressed then
            SelectionChangedOnClear;
          cconn.Selected:= true;
          aChanged:= true;
        end else if CtrlPressed then begin
          cconn.Selected:= false;
          aChanged:= true;
        end;
        if aChanged then
          ShowAll;
      end else begin
        if SelectionChangedOnClear then
          ShowAll;
        if Button = mbLeft then
          FIsRectSelecting := True;
      end;
    end;
  end;
  if FIsRectSelecting then begin
    FSelectRect.TopLeft := FMemMousePos;
    FSelectRect.BottomRight := FMemMousePos;
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := clSilver;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
    //Canvas.Rectangle(FSelectRect);
  end;
end;

procedure TessConnectPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pt, pt1, p2: TPoint;
  found, Src: TControl;
  mcont: TManagedObject;
  i, dx, dy, SelControls, Handle_Shadow, newLeft, newTop: Integer;
  curr: TCrackControl;
  r, rt, MovedRect, mRectDxDy: TRect;
  resized: boolean;

  procedure InMakeVisible(C : TRect);
    var mdx, mdy: integer; p: TPoint;
  begin
    mdx := TScrollBox(Parent).HorzScrollBar.Position;
    mdy := TScrollBox(Parent).VertScrollBar.Position;

    if (dx > 0) and (C.BottomRight.X >= TScrollBox(Parent).HorzScrollBar.Position + Parent.Width) then
      TScrollBox(Parent).HorzScrollBar.Position := C.BottomRight.X - Parent.Width;

    if (dy > 0) and (C.BottomRight.Y >= TScrollBox(Parent).VertScrollBar.Position + Parent.Height) then
      TScrollBox(Parent).VertScrollBar.Position := C.BottomRight.Y - Parent.Height;

    if (dx < 0) and (C.Left <= TScrollBox(Parent).HorzScrollBar.Position) then
      TScrollBox(Parent).HorzScrollBar.Position := C.Left;

    if (dy < 0) and (C.Top <= TScrollBox(Parent).VertScrollBar.Position) then
      TScrollBox(Parent).VertScrollBar.Position := C.Top;

    mdy := mdy - TScrollBox(Parent).VertScrollBar.Position;
    mdx := mdx - TScrollBox(Parent).HorzScrollBar.Position;

    if (mdx <> 0) or (mdy <> 0) then begin
      p := Mouse.CursorPos;
      p.X := p.X + mdx;
      p.Y := p.Y + mdy;
      Mouse.CursorPos := p;
      Resized:= true;
    end;
  end;

  function Intersect(const R1, R2: TRect): Boolean;
  begin
    Result := not ( (R1.BottomRight.X <= R2.TopLeft.X) or
                    (R1.BottomRight.Y <= R2.TopLeft.Y) or
                    (R2.BottomRight.X <= R1.TopLeft.X) or
                    (R2.BottomRight.Y <= R1.TopLeft.Y) );
  end;

  procedure ShowConnectionsAndMarkers(show: boolean);
    var k, i: integer; aControl: TControl; Connect, aConnection: TConnection;
        SrcRect: TRect;
  begin
    Src:= mcont.FControl;

    // for all moved connections
    for k:= 0 to FConnections.Count - 1 do begin
      Connect:= TConnection(FConnections[k]);
      if Connect.visible and Connect.FTo.visible and Connect.FFrom.visible and
         ((Connect.FFrom = Src) or (Connect.FTo = Src))
      then begin
        // hide/show moved connection
        Connect.draw(Canvas, show);

        // invalidate cutted controls
        for i:= 0 to FManagedObjects.Count - 1 do begin
          aControl:= TManagedObject(FManagedObjects[i]).Control;
          if aControl.Visible and connect.square.intersects(aControl.BoundsRect) then
            aControl.Invalidate;
        end;

        // mark cutted connections
        if Show then
          for i:= 0 to FConnections.Count - 1 do begin
            aConnection:= TConnection(FConnections[i]);
            if (i <> k) and aConnection.visible and aConnection.square.intersects(Connect.square) then
              aConnection.cutted:= true;
          end;
      end;
    end;

    // for the moved control
    SrcRect:= Src.BoundsRect;
    SrcRect.Inflate(HandleSize, HandleSize);
    // invalidate all cutted controls
    for i:= 0 to FManagedObjects.Count - 1 do begin
      aControl:= TManagedObject(FManagedObjects[i]).Control;
      if aControl.Visible and (aControl <> Src) and
         intersect(TManagedObject(FManagedObjects[i]).SelectedBoundsRect, SrcRect) then
        aControl.Invalidate;
    end;

    if Show then
      for i:= 0 to FConnections.Count - 1 do begin
        aConnection:= TConnection(FConnections[i]);
        if aConnection.visible and aConnection.FTo.visible and aConnection.FFrom.visible and
           not ((aConnection.FFrom = Src) or  (aConnection.FTo = Src)) and
           aConnection.square.intersects(SrcRect) then
          // mark cutted connections of moved control
          aConnection.cutted:= true;
      end;

    if not (mcont.FControl is TRtfdCommentBox)  then
      DrawMarkers((mcont.FControl as TRtfdBox).GetBoundsRect, show);
  end;

begin
  inherited;

  if shift = [] then exit;
  pt1 := Mouse.CursorPos;
  pt.x := X;
  pt.Y := Y;
  dx := pt.x - FMemMousePos.x;
  dy := pt.y - FMemMousePos.y;
  if (dx = 0) and (dy = 0) then exit;

  IntersectRect(r, Parent.ClientRect, BoundsRect);
  r.TopLeft := Parent.ClientToScreen(r.TopLeft);
  r.BottomRight := Parent.ClientToScreen(r.BottomRight);

  if (not PtInRect(r, pt1)) and (not (FIsRectSelecting or FIsMoving)) then
    ReleaseCapture
  else begin
    found:= FindVCLWindow(pt1);
    if FIsRectSelecting then begin
      FMemMousePos := pt;
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Color := clSilver;
      Canvas.Pen.Mode := pmXor;
      Canvas.Pen.Width := 0;
      Canvas.Rectangle(FSelectRect);
      FSelectRect.BottomRight := FMemMousePos;
      Canvas.Rectangle(FSelectRect);
    end else if ssLeft in Shift then begin
      //  Move the selected boxes
      if (Abs(dx) + Abs(dy) > 5) or FIsMoving then begin
        Resized:= false;
        MovedRect:= Rect(MaxInt, 0, 0, 0);
        SelControls:= CountSelectedControls;
        Handle_Shadow:= max(HandleSize - GuiPyOptions.ShadowWidth, 0);

        if assigned(FManagedObjects) then
          for i:= 0 to FManagedObjects.Count - 1 do begin
            mcont:= TManagedObject(FManagedObjects[i]);
            if mcont.Control.Visible and mcont.Selected then begin
              ShowConnectionsAndMarkers(false);
              curr := TCrackControl(mcont.FControl);
              mRectDxDy:= curr.BoundsRect;
              mRectDxDy.TopLeft.Offset(-HandleSize, -HandleSize);
              mRectDxDy.BottomRight.Offset(Handle_Shadow, Handle_Shadow);

              if (mcont.FControl is TRtfdCommentBox) and (selControls = 1) then
                (mcont.FControl as TRtfdCommentBox).CommentMouseMove(ClientToScreen(FMemMousePos), ClientToScreen(pt))
              else begin
                newLeft:= curr.Left;
                newTop:= curr.Top;
                if (dx <> 0) and (curr.Left + dx >= getRecursivXDecrease(mcont.FControl)) then
                  newLeft:= curr.Left + dx;
                if (dy <> 0) and (curr.Top + dy >= getRecursivYDecrease(mcont.FControl)) then
                  newTop:= curr.Top + dy;
                if (newLeft <> curr.Left) or (newTop <> curr.Top) then
                  curr.setBounds(newLeft, newTop, curr.width, curr.height);
              end;

              rt:= curr.BoundsRect;
              rt.TopLeft.Offset(-HandleSize, -HandleSize);
              rt.BottomRight.Offset(Handle_Shadow, Handle_Shadow);
              mRectDxDy.Union(rt);

              // scrolling
              if curr.Left + curr.Width + 50 > Width then begin
                Width:= curr.Left + curr.Width + 50;
                Resized:= true;
              end;
              if curr.Top + curr.Height + 50 > Height then begin
                Height:= curr.Top + curr.Height + 50; // ToDo wird nicht vergrößert
                Resized:= true;
              end;

              if MovedRect.Left = MaxInt
                then MovedRect:= mRectDxDy
                else UnionRect(MovedRect, mRectDxDy, MovedRect);
              // debug
              //   Canvas.Brush.Color:= clRed;
              //   Canvas.FrameRect(MovedRect);
              ShowConnectionsAndMarkers(true);
            end;
          end;

        // debug
        //   Canvas.Brush.Color:= clRed;
        //   Canvas.FrameRect(MovedRect);

        IsModified:= True;
        FMemMousePos:= pt;
        FIsMoving:= True;

        if MovedRect.Left <> MaxInt then
          InMakeVisible(MovedRect);
        if Resized then begin
          Invalidate;  // doesn't call paint in all cases, so ShowConnections is ensured
          Application.ProcessMessages; // ensures that invalidate is acomplished
          ShowConnections;
        end else
          ShowCuttedConnections;
      end else if Assigned(found) then begin
        if Assigned(TCrackControl(found).OnMouseMove) then begin
          p2 := found.ScreenToClient(pt);
          TCrackControl(found).OnMouseMove(found, Shift, p2.x, p2.y);
        end;
      end;
    end;
  end;
end;

procedure TessConnectPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt, p2: TPoint;
  r: TRect;
  found: TControl;
begin
  inherited;
  FIsMoving := False;
  pt.X := X;
  pt.Y := Y;
  IntersectRect(r, Parent.ClientRect, BoundsRect);
  r.TopLeft := Parent.ClientToScreen(r.TopLeft);
  r.BottomRight := Parent.ClientToScreen(r.BottomRight);
  r.TopLeft := ScreenToClient(r.TopLeft);
  r.BottomRight := ScreenToClient(r.BottomRight);

  if FIsRectSelecting then begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 0;
    Canvas.Rectangle(FSelectRect);
    SelectObjectsInRect(FSelectRect);
    Canvas.Brush.Color:= BGColor;
    Canvas.Brush.Style:= bsSolid;
    Canvas.Pen.Color:= FGColor;
    Canvas.Pen.Mode:= pmCopy;
    ShowAll;
  end else begin
    ReleaseCapture;
    if PtInRect(r, pt) then begin
       //if GetCaptureControl <> Self then     SetCaptureControl(Self);
      found:= FindVCLWindow(Mouse.CursorPos);

      if Assigned(found) and (found <> self) and found.visible then begin
        if (found is TMemo) then
          found:= (found as TMemo).Parent;

        if Assigned(TCrackControl(found).PopupMenu) and (Button = mbRight) then
          TCrackControl(found).PopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);

        if Assigned(TCrackControl(found).OnMouseUp) then begin
          p2 := found.ScreenToClient(Mouse.CursorPos);
          TCrackControl(found).OnMouseUp(found, Button, Shift, p2.x, p2.y);
        end;
      end
      else if (Button = mbRight) then
        if ClickOnConnection
          then PopupMenuConnection.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
          else PopupMenuWindow.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    end;
  end;
  FIsRectSelecting:= False;
end;

function TessConnectPanel.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;

  const WHEEL_DIVISOR = 120; // Mouse Wheel standard
  var mdy: integer;
begin
  mdy := TScrollBox(Parent).VertScrollBar.Position - WheelDelta;
  TScrollBox(Parent).VertScrollBar.Position:= mdy;
  Result := True;
end;

procedure TessConnectPanel.OnManagedObjectClick(Sender: TObject);
var
  inst: TManagedObject;
begin
  inst:= FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnClick) then
    inst.FOnClick(Sender);
end;

procedure TessConnectPanel.OnManagedObjectDblClick(Sender: TObject);
var
  inst: TManagedObject;
begin
  inst:= FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnDblClick) then begin
    MouseDownOK:= false;
    ClearSelection;
    inst.FOnDblClick(Sender);
  end;
end;

procedure TessConnectPanel.OnManagedObjectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  if (not Focused) or (GetCaptureControl<>Self) then begin
    // Call the essConnectpanel MouseDown instead.
    pt.x := X;
    pt.y := Y;
    pt := (Sender as TControl).ClientToScreen(pt);
    pt := ScreenToClient(pt);
    MouseDown(Button, Shift, pt.x, pt.y);
  end;
end;

procedure TessConnectPanel.OnManagedObjectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  inst: TManagedObject;
begin
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnMouseMove)
    then inst.FOnMouseMove(Sender,Shift,X,Y);
end;

procedure TessConnectPanel.OnManagedObjectMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  inst: TManagedObject;
begin
  inst := FindManagedControl(Sender as TControl);
  if Assigned(inst) and Assigned(inst.FOnMouseUp)
    then inst.FOnMouseUp(Sender,Button,Shift,X,Y);
end;

procedure TessConnectPanel.Paint;
  var Rect: TRect;
begin
  if IsMoving then exit;  // this inhibits painting while moving
  Canvas.Pen.Mode := pmCopy;
  Rect:= ClientRect;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  Canvas.Brush.Color:= BGColor;
  Canvas.Pen.Color:= FGColor;
  Canvas.Font:= Font;
  ShowAll;
end;

procedure TessConnectPanel.ShowConnections;
  var i: integer; conn: TConnection;
begin
  for i:= 0 to FConnections.Count -1 do begin
    conn:= (FConnections[i] as TConnection);
    if Conn.FFrom.Visible and Conn.FTo.Visible then
      Conn.Draw(Canvas, true);
  end;
end;

procedure TessConnectPanel.HideConnections;
  var i: integer; conn: TConnection;
begin
  for i:= 0 to FConnections.Count -1 do begin
    conn:= (FConnections[i] as TConnection);
    Conn.Draw(Canvas, false);
  end;
end;

procedure TessConnectPanel.ShowCuttedConnections;
  var i, k: integer; conn: TConnection; aControl: TControl;
begin
  for i:= 0 to FConnections.Count -1 do begin
    conn:= (FConnections[i] as TConnection);
    if Conn.Cutted and Conn.FFrom.Visible and Conn.FTo.Visible then begin
      Conn.Draw(Canvas, true);
      // invalidate controls, which are cutted
      for k:= 0 to FManagedObjects.Count - 1 do begin
        aControl:= TManagedObject(FManagedObjects[k]).Control;
        if aControl.Visible and conn.square.intersects(aControl.BoundsRect) then
          aControl.Invalidate;
      end;
      Conn.Cutted:= false;
    end;
  end;
end;

procedure TessConnectPanel.RecalcSize;
  var i, xmax, ymax: Integer;
begin
  if assigned(Parent) then begin
    xmax:= Parent.Width - 4; // 300;
    ymax:= Parent.Height- 4; // 150;
  end else begin
    xmax:= 300;
    ymax:= 150;
  end;
  for i:= 0 to ControlCount - 1 do begin
    if (Controls[i].Align <> alNone) or (not Controls[i].Visible) then
      Continue;
    xmax := Max(xmax, Controls[i].Left + Controls[i].Width + 30);
    ymax := Max(ymax, Controls[i].Top + Controls[i].Height + 30);
  end;
  if (Width <> xmax) or (Height <> ymax) then
    SetBounds(Left, Top, xmax, ymax);
  if Assigned(OnContentChanged) then
    OnContentChanged(nil);
end;

procedure TessConnectPanel.GetDiagramSize(var W, H: integer);
  var i: Integer;
begin
  W:= 300;
  H:= 150;
  for i:= 0 to ControlCount - 1 do begin
    if (Controls[i].Align <> alNone) or (not Controls[i].Visible) then
      Continue;
    W:= Max(W, Controls[i].Left + Controls[i].Width + 10 + getRecursivXEnlarge(Controls[i]));
    H:= Max(H, Controls[i].Top + Controls[i].Height + 10 + getRecursivYEnlarge(Controls[i]));
  end;
end;

function TessConnectPanel.GetSelectedRect: TRect;
var
  C: TControl;
  i, j, dl, dr, dt, db, count: integer;
  R: TRect;
  Conn: TConnection;
begin
  count:= 0;
  Result:= {$IFDEF LCL}Types.{$ENDIF}Rect(MaxInt, MaxInt, 0, 0);
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count-1 do
      if TManagedObject(FManagedObjects[i]).FSelected then begin
        C:= TManagedObject(FManagedObjects[i]).FControl;
        R:= C.BoundsRect;
        dl:= 0;
        dr:= 0;
        dt:= 0;
        db:= 0;
        for j:= 0 to FConnections.Count - 1 do begin
          Conn:= TConnection(FConnections[j]);
          if Conn.isRecursiv and ((Conn.FFrom = C) or (Conn.FTo = C)) then begin
            dl:= max(dl, Conn.XDecrease);
            dr:= max(dr, Conn.XEnlarge);
            dt:= max(dt, Conn.YDecrease);
            db:= max(db, Conn.YEnlarge);
          end;
        end;
        if R.Top - dt < Result.Top then       Result.Top:= R.Top - dt;
        if R.Left - dl < Result.Left then     Result.Left:= R.Left - dl;
        if R.Bottom + db > Result.Bottom then Result.Bottom:= R.Bottom + db;
        if R.Right + dr > Result.Right then   Result.Right:= R.Right + dr;
        inc(count);
      end;
  if count = 0 then
    Result:= {$IFDEF LCL}Types.{$ENDIF}Rect(0, 0, 0, 0)
end;

procedure TessConnectPanel.SelectObjectsInRect(SelRect: TRect);
var
  i: Integer;
  r1, r2: TRect;
  aControl: TControl;
begin
  r1 := SelRect;
  if SelRect.Top > SelRect.Bottom then begin
    SelRect.Top := r1.Bottom;
    SelRect.Bottom := r1.Top;
  end;
  if SelRect.Left > SelRect.Right then begin
    SelRect.Left := r1.Right;
    SelRect.Right := r1.Left;
  end;

  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do begin
      if assigned(TManagedObject(FManagedObjects[i]).FControl) then begin
        aControl:= TManagedObject(FManagedObjects[i]).FControl;
        r1 := aControl.BoundsRect;
        IntersectRect(r2, SelRect, r1);
        if EqualRect(r1, r2) and TManagedObject(FManagedObjects[i]).FControl.Visible then
          TManagedObject(FManagedObjects[i]).Selected := true;
      end;
    end;
end;

procedure TessConnectPanel.SetFocus;
  var X,Y : integer;
begin
  Anchors:= [akTop, akLeft];  // ToDo ergänzt
  // Try to see if we can call inherited, otherwise there is a risc of getting
  // 'Cannot focus' exception when starting from delphi-tools.
  if CanFocus and Assigned(myForm) then begin
    // To avoid having the scrollbox resetting its positions after a setfocus call.
    X := (Parent as TScrollBox).HorzScrollBar.Position;
    Y := (Parent as TScrollBox).VertScrollBar.Position;
    inherited;
    (Parent as TScrollBox).HorzScrollBar.Position := X;
    (Parent as TScrollBox).VertScrollBar.Position := Y;
  end;
  //if GetCaptureControl <> Self then SetCaptureControl(Self);
end;

procedure TessConnectPanel.SetModified(const Value : boolean);
begin
  if FIsModified <> Value then begin
    FIsModified:= Value;
    if Assigned(OnModified) then
      OnModified(Value);
  end;
end;

procedure TessConnectPanel.SetSelectedOnly(const Value : boolean);
var
  I : integer;
begin
  if FSelectedOnly <> Value then
  begin
    FSelectedOnly := Value;
    if FSelectedOnly then
    begin
      TempHidden.Clear;
      for i:=0 to FManagedObjects.Count -1 do
        if (not TManagedObject(FManagedObjects[i]).Selected) and TManagedObject(FManagedObjects[i]).FControl.Visible then
        begin
          TManagedObject(FManagedObjects[i]).FControl.Visible := False;
          TempHidden.Add( TObject(FManagedObjects[i]) );
        end;
    end
    else
    begin
      for I := 0 to TempHidden.Count-1 do
        TManagedObject(TempHidden[I]).FControl.Visible := True;
      TempHidden.Clear;
    end;
  end;
end;

procedure TessConnectPanel.SetConnections(Value: integer);
  var i: integer; conn: TConnection;
begin
  FShowConnections:= Value;
  for i:= 0 to FConnections.Count - 1 do begin
    conn:= TConnection(FConnections[i]);
    case Value of
        0: conn.visible:= true;
        1: conn.visible:= (conn.ArrowStyle <> asInstanceOf);
      else conn.visible:= false;
    end;
  end;
  Self.Repaint;
  Self.SetFocus;
end;

procedure TessConnectPanel.SetShowObjectDiagram(b: boolean);
  var i: integer; aControl: TControl;
begin
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do begin
      aControl:= TManagedObject(FManagedObjects[i]).FControl;
      if aControl is TRtfdClass then begin
        aControl.visible:= not b;
        if b
          then aControl.Parent:= nil
          else aControl.Parent:= Self;
      end;
    end;
  Self.Repaint;
  Self.SetFocus;
end;

procedure TessConnectPanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Delete then begin
    if assigned(OnDeleteSelectedControls) then
      OnDeleteSelectedControls(self);
    DeleteSelectedConnection;
    Invalidate;
  end;
end;

procedure TessConnectPanel.TextTo(aCanvas: TCanvas);
  // this was a hard way to find, Panel.PaintTo doesn't show the text.
 var i, firstchar: integer; aManagedObject: TManagedObject; CommentBox: TRtfdCommentBox;
     r: TRect;  s: string;
begin
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count - 1 do begin
      aManagedObject:= TManagedObject(FManagedObjects[i]);
      if (aManagedObject.FControl is TRtfdCommentBox) then begin
        CommentBox:= (aManagedObject.FControl as TRtfdCommentBox);
        aCanvas.Font:= CommentBox.TrMemo.Font;
        aCanvas.Brush.Color:= GuiPyOptions.CommentColor;
        CommentBox.TrMemo.perform(em_getrect, 0, lparam(@r));  // TODO em_getrect aus MyMsic
        firstchar:= CommentBox.TrMemo.perform(EM_LINEINDEX,    // TODO EM_GETFIRSTVISIBLELINE aus MyMisc
                                      CommentBox.TrMemo.perform(em_getfirstvisibleline, 0, 0), 0);
        s:= copy(CommentBox.TrMemo.text, firstchar+1, maxint);
        aCanvas.TextOut(r.left, r.top, ' '); // ensures font is selected
        OffsetRect(r, CommentBox.left + CommentBox.TrMemo.Left, CommentBox.Top + CommentBox.TrMemo.Top);
        DrawTextEx(aCanvas.handle, @S[1], Length(S), r, DT_WORDBREAK or DT_LEFT or DT_EDITCONTROL, nil);
      end;
    end;
end;

function TessConnectPanel.getClipRect: TRect;
  var MovedRect: TRect; i: integer;
      mcont: TManagedObject;
      curr: TCrackControl;
begin
  MovedRect:= Rect(MaxInt, 0, 0, 0);
  if assigned(FManagedObjects) then
    for i:= 0 to FManagedObjects.Count -1 do begin
      mcont:= TManagedObject(FManagedObjects[i]);
      curr := TCrackControl(mcont.FControl);
      if MovedRect.Left = MaxInt
        then MovedRect:= curr.BoundsRect
        else UnionRect(MovedRect, curr.BoundsRect, MovedRect);
    end;
  Result:= MovedRect;
end;

procedure TessConnectPanel.ChangeStyle;
  var i: integer;
begin
  if StyleServices.IsSystemStyle then begin
    BGColor:= clWhite;
    FGColor:= clBlack;
  end else begin
    BGColor:= StyleServices.GetStyleColor(scPanel);
    FGColor:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  Color:= BGColor;
  Canvas.Pen.Color:= FGColor;
  Canvas.Brush.Color:= BGColor;
  for i:= 0 to FConnections.Count - 1 do
    TConnection(FConnections[i]).ChangeStyle;
  for i:= 0 to FManagedObjects.Count -1 do
    (TManagedObject(FManagedObjects[i]).FControl as TRtfdBox).ChangeStyle;
end;

procedure TessConnectPanel.CheckRoleHidesAttribute(conn: TConnection; Attributes: TConnectionAttributes);
  var it: IModelIterator; C: TClass; Attribute: TAttribute; HiddenChanged: boolean;
begin
  if conn.FTo is TRtfdClass then begin
    HiddenChanged:= false;
    C:= (conn.FTo as TRtfdClass).Entity as TClass;
    it:= C.GetAllAttributes;
    while it.HasNext do begin
      Attribute:= it.next as TAttribute;
      if not Attribute.Hidden and ((Attribute.Name = Attributes.RoleA) or (Attribute.Name + '[]' = Attributes.RoleA)) then begin
        Attribute.Hidden:= true;
        HiddenChanged:= true;
      end else if Attribute.Hidden and (Attribute.Name = WithoutArray(conn.RoleA)) and (conn.RoleA <> Attributes.RoleA) then begin
        Attribute.Hidden:= false;
        HiddenChanged:= true;
      end;
    end;
    if HiddenChanged then
      (conn.FTo as TRtfdClass).RefreshEntities;
  end;
  if conn.FFrom is TRtfdClass then begin
    HiddenChanged:= false;
    C:= (conn.FFrom as TRtfdClass).Entity as TClass;
    it:= C.GetAllAttributes;
    while it.HasNext do begin
      Attribute:= it.next as TAttribute;
      if not Attribute.Hidden and ((Attribute.Name = Attributes.RoleB) or (Attribute.Name + '[]' = Attributes.RoleB)) then begin
        Attribute.Hidden:= true;
        HiddenChanged:= true;
      end else if Attribute.Hidden and (Attribute.Name = WithoutArray(conn.RoleB)) and (conn.RoleB <> Attributes.RoleB) then begin
        Attribute.Hidden:= false;
        HiddenChanged:= true;
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
  FControl:= nil;
end;

function TManagedObject.SelectedBoundsRect: TRect;
begin
  Result:= FControl.BoundsRect;
  if Selected then
    Result.inflate(HandleSize, HandleSize);
end;

procedure TManagedObject.SetSelected(const Value: Boolean);
begin
  if FControl.visible and (FSelected <> Value) then begin
    FSelected := Value;
    (FControl as TRtfdBox).Selected:= Value;
  end;
end;

end.
