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

unit USugiyamaLayout;

{
  Layout according to the 'Sugiyama'-algoritm.

  Here is a good description of how it works:

  http://www.csi.uottawa.ca/ordal/papers/sander/main.html
}

interface

uses Contnrs, Classes, Controls;

type
  TEdgeList = class;

  TNode = class
  private
    FId: Integer;
    // Index in FNodes-list, must be updated when node changes position (after re-sort)
    FInEdges: TEdgeList;
    FOutEdges: TEdgeList;
    FRank: Integer;
    FOrder: Integer;
    FCOrder: Integer;
    FWeight: Single;
    FIsDummy: Boolean;
    FXPos, FYPos, FHeight, FWidth: Integer;
    FControl: TControl;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TEdge = class
  private
    FFromNode, FToNode: TNode;
    constructor Create(const FromNode, ToNode: TNode);
  end;

  TEdgeList = class(TObjectList)
  private
    function GetEdge(Index: Integer): TEdge;
    property Edges[Index: Integer]: TEdge read GetEdge; default;
  end;

  TNodeList = class(TObjectList)
  private
    function GetNode(Index: Integer): TNode;
    function LastIndexOf(const APointer: Pointer): Integer;
    property FNodes[Index: Integer]: TNode read GetNode; default;
  end;

  TLayerList = class(TObjectList)
  private
    function GetLayer(Index: Integer): TNodeList;
    property FLayers[Index: Integer]: TNodeList read GetLayer; default;
  end;
{$HINTS ON}

  TSugiyamaLayout = class
  private
    FManagedObjects: TList;
    FConnections: TList;
    FHSpacing: Integer;
    FVSpacing: Integer;
    FNodes: TNodeList;
    FLayers: TLayerList;
    procedure ExtractNodes;
    procedure ApplyNodes;
    procedure DoPhases;
    procedure AddEdge(const FromNode, ToNode: TNode);

    // First phase
    procedure LayeringPhase;
    procedure MakeAcyclic;
    procedure InitialRanking;
    procedure MakeProper;
    procedure TopoSort;

    // Second phase
    procedure OrderingPhase;
    function CalcCrossings: Integer;
    function CalcCrossingsTwoLayers(const Layer1, Layer2: TNodeList): Integer;

    // Third phase
    procedure PositioningPhase;
    procedure SetXPositions;
    procedure SetYPositions;
    procedure XCorrection;
  public
    constructor Create(ManagedObjects: TList; Connections: TList);
    procedure Execute;
    destructor Destroy; override;
  end;

implementation

uses
  Math,
  SysUtils,
  UUtils,
  UConnection; {, URtfdComponents} // ToDo

{ TSugiyamaLayout }

constructor TSugiyamaLayout.Create(ManagedObjects: TList; Connections: TList);
begin
  FManagedObjects := ManagedObjects;
  FConnections := Connections;
end;

procedure TSugiyamaLayout.Execute;
begin
  FHSpacing := 20;
  FVSpacing := 40;
  try
    ExtractNodes;
    DoPhases;
    ApplyNodes;
  except
    on e: Exception do
      ErrorMsg('TSugiyamaLayout.Execute');
  end;
end;

// Extract FNodes from essconnectpanel
procedure TSugiyamaLayout.ExtractNodes;
var
  List: TList;
  //I: Integer;
  Control: TControl;
  Con: TConnection;
  Node, FromNode, ToNode: TNode;
begin
  FNodes := TNodeList.Create(True);

  List := FManagedObjects;
  try
    for var I := 0 to List.Count - 1 do
    begin
      Control := TControl(List[I]);
      if not Control.Visible then
        Continue;
      Node := TNode.Create;
      Node.FHeight := Control.Height;
      Node.FWidth := Control.Width;
      Node.FControl := Control;
      Node.FId := FNodes.Count;
      { ToDo
        Node.Name:= (Control as TRtfdBox).Entity.Name;
        if (Control is TRtfdObject) then begin
        p:= length(Node.Name);
        if (p > 0) and isdigit(Node.Name[p]) then begin
        while isDigit(Node.Name[p]) do dec(p);
        Node.NameNr:= StrToInt(copy(Node.name, p+1, length(Node.Name)));
        delete(Node.Name, p+1, length(Node.Name));
        end else
        Node.NameNr:= 0;
        end;
      }
      Control.Tag := Node.FId;
      FNodes.Add(Node);
    end;
  finally
    FreeAndNil(List);
  end;

  List := FConnections;
  try
    for var I := 0 to List.Count - 1 do
    begin
      Con := TConnection(List[I]);
      if (not Con.FromControl.Visible) or (not Con.ToControl.Visible) then
        Continue;

      if Con.isRecursiv then
      begin
        FHSpacing := 80;
        FVSpacing := 80;
        Continue;
      end;

      // Here the connection is reversed: from=to, to=from
      // This is because the algorithm assumes that everything points downwards, while
      // we want all arrows to point upwards (descendants pointing up to their baseclass).
      if (Con.ConnectStyle = csNormal) or (Con.ArrowStyle = asInstanceOf) then
      begin // Reverse Inheritance-connections
        FromNode := FNodes[Con.ToControl.Tag];
        ToNode := FNodes[Con.FromControl.Tag];
      end
      else
      begin // Do not reverse Unit-Associations and Implements-interface
        FromNode := FNodes[Con.FromControl.Tag];
        ToNode := FNodes[Con.ToControl.Tag];
      end;
      AddEdge(FromNode, ToNode);
    end;
  finally
    FreeAndNil(List);
  end;
end;

// Writes back layout to essconnectpanel
procedure TSugiyamaLayout.ApplyNodes;
var
  Node: TNode;
begin
  for var I := 0 to FNodes.Count - 1 do
  begin
    Node := FNodes[I];
    if Node.FIsDummy then
      Continue;
    Node.FControl.Left := Node.FXPos;
    Node.FControl.Top := Node.FYPos;
  end;
end;

// Executes the different phases of the layout-algorithm
procedure TSugiyamaLayout.DoPhases;
begin
  // Place FNodes in FLayers
  LayeringPhase;
  // Sort FNodes within each layer
  OrderingPhase;
  // Decide final X and Y position for FNodes
  PositioningPhase;
end;

// Make FLayers, and assign each node to a layer
procedure TSugiyamaLayout.LayeringPhase;
const
  // Max nr of FNodes in a layer, used when distributing 'zeronodes'.
  CLayerMaxNodes = 16;
var
  MinC, MinI: Integer;
  Node: TNode;
  ZeroNodes: TNodeList;
begin
  MakeAcyclic;
  InitialRanking;
  MakeProper;
  // Here the FLayers are created based on the ranking-value of FNodes.
  FLayers := TLayerList.Create;
  ZeroNodes := TNodeList.Create(False);
  try
    for var I := 0 to FNodes.Count - 1 do
    begin
      Node := FNodes[I];
      if Node.FInEdges.Count + Node.FOutEdges.Count = 0 then
        ZeroNodes.Add(Node)
      else
      begin
        while FLayers.Count < FNodes[I].FRank + 1 do
          FLayers.Add(TNodeList.Create(False));
        FLayers[FNodes[I].FRank].Add(FNodes[I]);
      end;
    end;
    // Distribute FNodes without edges onto FLayers with the least nr of FNodes
    for var I := 0 to ZeroNodes.Count - 1 do
    begin
      MinC := CLayerMaxNodes;
      MinI := 0;
      for var J := 0 to FLayers.Count - 1 do
        if FLayers[J].Count < MinC then
        begin
          MinC := FLayers[J].Count;
          MinI := J;
        end;
      if MinC >= CLayerMaxNodes then
      begin
        // If all FLayers has CLayerMaxNodes nr of FNodes, then create a new layer
        FLayers.Add(TNodeList.Create(False));
        MinI := FLayers.Count - 1;
      end;
      FLayers[MinI].Add(ZeroNodes[I]);
    end;
  finally
    FreeAndNil(ZeroNodes);
  end;
  // Now all edges should be pointing down onto the layer directly beneath it.
end;

destructor TSugiyamaLayout.Destroy;
begin
  FreeAndNil(FNodes);
  FreeAndNil(FLayers);
  inherited;
end;

procedure TSugiyamaLayout.AddEdge(const FromNode, ToNode: TNode);
begin
  FromNode.FOutEdges.Add(TEdge.Create(FromNode, ToNode));
  ToNode.FInEdges.Add(TEdge.Create(FromNode, ToNode));
end;

procedure TSugiyamaLayout.MakeAcyclic;
{
  The graph cannot include cycles, so these must be removed.

  A cycle is removed by reversing an edge in the cycle.

  DFS = Depth First Search.

  "strongly connected components"
  This means FNodes where there is a path a->b and b<-a (cycles)

  Calc set of strongly connected components
  for each component
  if there are more than one node in component, reverse an edge
  reverse the edge with min( outdeg(v) ) max( indeg(v) + indeg(w) )
  loop until each component includes only one node

  More info:
  http://www.ics.uci.edu/~eppstein/161/960215.html
  http://www.ics.uci.edu/~eppstein/161/960220.html
}
type
  TDfsStruct = record
    Visited, Removed: Boolean;
    DfsNum, DfsLow: Integer;
  end;

var
  DfsList: array of TDfsStruct;
  CurDfs, CycCount: Integer;
  Path: TObjectList;
  Safety: Integer;
  SuperNode: TNode;

  procedure InReverse(Node: TNode; EPos: Integer);
  var
    ToNode: TNode;
  begin
    ToNode := Node.FOutEdges[EPos].FToNode;
    for var I := 0 to ToNode.FInEdges.Count - 1 do
      if ToNode.FInEdges[I].FFromNode = Node then
      begin
        ToNode.FInEdges.Delete(I);
        Node.FOutEdges.Delete(EPos);
        AddEdge(ToNode, Node);
        Break;
      end;
  end;

  procedure InVisit(Node: TNode);
  var
    Score, BestScore, RevEdge: Integer;
    WNode, VNode, RevNode: TNode;
    Cyc: TObjectList;
  begin
    Path.Add(Node);
    with DfsList[Node.FId] do
    begin
      DfsNum := CurDfs;
      DfsLow := CurDfs;
      Visited := True;
    end;
    Inc(CurDfs);
    // Walk out-edges recursive
    for var I := 0 to Node.FOutEdges.Count - 1 do
    begin
      WNode := Node.FOutEdges[I].FToNode;
      if not DfsList[WNode.FId].Removed then
      begin
        if not DfsList[WNode.FId].Visited then
        begin
          InVisit(WNode);
          DfsList[Node.FId].DfsLow := Min(DfsList[Node.FId].DfsLow,
            DfsList[WNode.FId].DfsLow);
        end
        else
          DfsList[Node.FId].DfsLow := Min(DfsList[Node.FId].DfsLow,
            DfsList[WNode.FId].DfsNum);
      end;
    end;
    // Check if there was a cycle
    if DfsList[Node.FId].DfsLow = DfsList[Node.FId].DfsNum then
    begin
      Cyc := TObjectList.Create(False);
      repeat
        VNode := TNode(Path.Last);
        Path.Delete(Path.Count - 1);
        Cyc.Add(VNode);
        DfsList[VNode.FId].Removed := True;
      until VNode = Node;
      if Cyc.Count > 1 then
      begin // Real cycle found
        Inc(CycCount);
        BestScore := -1;
        RevEdge := 0;
        RevNode := TNode(Cyc[0]);
        for var I := 0 to Cyc.Count - 1 do
        begin // Find edge with min( outdeg(VNode) ) max( indeg(VNode) + indeg(WNode) )
          VNode := TNode(Cyc[I]);
          for var J := 0 to VNode.FOutEdges.Count - 1 do
            if Cyc.IndexOf(VNode.FOutEdges[J].FToNode) > -1 then
            begin
              Score := VNode.FInEdges.Count + VNode.FOutEdges[J].FToNode.FInEdges.Count -
                VNode.FOutEdges.Count;
              if VNode.FOutEdges.Count = 1 then
                Inc(Score, 50);
              if Score > BestScore then
              begin
                BestScore := Score;
                RevNode := VNode;
                RevEdge := J;
              end;
            end;
        end;
        InReverse(RevNode, RevEdge);
      end;
      FreeAndNil(Cyc);
    end;
  end;

begin
  Path := TObjectList.Create(False);
  SuperNode := TNode.Create;
  try
    for var I := 0 to FNodes.Count - 1 do
      SuperNode.FOutEdges.Add(TEdge.Create(SuperNode, FNodes[I]));
    SuperNode.FId := FNodes.Count;

    Safety := 0;
    repeat
      Path.Clear;
      DfsList := nil;
      SetLength(DfsList, FNodes.Count + 1);
      CurDfs := 0;
      CycCount := 0;
      InVisit(SuperNode);
      Inc(Safety);
      if Safety > 30 then
        raise Exception.Create('Layout failed.');
    until CycCount = 0;
  finally
    FreeAndNil(SuperNode);
    FreeAndNil(Path);
  end;
end;

var
  // Global temparray used by sortfunc
  GLabels: array of Integer;

function TopoSortProc(Item1, Item2: Pointer): Integer;
begin
  if GLabels[TNode(Item1).FId] < GLabels[TNode(Item2).FId] then
    Result := -1
  else if GLabels[TNode(Item1).FId] = GLabels[TNode(Item2).FId] then
    Result := 0 // equal
  else
    Result := 1;
end;

{
  Topological sort.

  Sort so that all dependancies points forward in the list.

  Topological FOrder:
  A numbering of the FNodes of a directed acyclic graph such that every edge from a node
  numbered i to a node numbered j satisfies i<j.
}

procedure TSugiyamaLayout.TopoSort;
var
  Indeg: array of Integer;
  Stack: TStack;
  NextLabel: Integer;
  Node: TNode;
  Edge: TEdge;
begin
  SetLength(Indeg, FNodes.Count);
  GLabels := nil;
  SetLength(GLabels, FNodes.Count);

  Stack := TStack.Create;
  try
    // init indeg with n.indeg
    // push FNodes without incoming edges
    for var I := 0 to FNodes.Count - 1 do
    begin
      Indeg[I] := FNodes[I].FInEdges.Count;
      if Indeg[I] = 0 then
        Stack.Push(FNodes[I]);
    end;

    if Stack.Count > 0 then
    begin
      NextLabel := 0;
      while Stack.Count > 0 do
      begin
        Node := TNode(Stack.Pop);
        Inc(NextLabel);
        GLabels[Node.FId] := NextLabel;
        for var I := 0 to Node.FOutEdges.Count - 1 do
        begin
          Edge := Node.FOutEdges[I];
          Dec(Indeg[Edge.FToNode.FId]);
          if (Indeg[Edge.FToNode.FId] = 0) and (GLabels[Edge.FToNode.FId] = 0) then
            Stack.Push(Edge.FToNode);
        end;
      end;

      // 0 cannot be in _labels, i.e. all FNodes must have been processed in the previous step
      { for I:= 0 to High(_Labels) do
        if _Labels[I]=0 then
        raise Exception.Create('connection-cycles'); }

      // sort FNodes based on their _label
      FNodes.Sort({$IFDEF LCL} @ {$ENDIF} TopoSortProc);
      GLabels := nil;
      // refresh node FId'Stack after sort
      for var I := 0 to FNodes.Count - 1 do
        FNodes[I].FId := I;
    end;
  finally
    FreeAndNil(Stack);
  end;
end;

procedure TSugiyamaLayout.InitialRanking;
{
  sortera FNodes med topological sort

  FNodes[0] har minst antal indeg, FNodes[count] har flest
  setlength(FRank,FNodes.count)
  foreach FNodes, n
  Rank = 0
  foreach FNodes i n.FInEdges, innode
  if FRank[ innode ]>Rank then Rank= FRank[ innode ] + 1
  FRank[index]=Rank
}
var
  Rank, Temp: Integer;
begin
  TopoSort;
  for var I := 0 to FNodes.Count - 1 do
  begin
    Rank := 0;
    for var J := 0 to FNodes[I].FInEdges.Count - 1 do
    begin
      Temp := FNodes[I].FInEdges[J].FFromNode.FRank;
      if Temp >= Rank then
        Rank := Temp + 1;
    end;
    FNodes[I].FRank := Rank;
  end;
end;

procedure TSugiyamaLayout.SetYPositions;
var
  Node: TNode;
  Highest, YPos: Integer;
begin
  YPos := FVSpacing;
  for var I := 0 to FLayers.Count - 1 do
  begin
    // Put all FNodes in a layer with the same YPos, increase YPos with highest node + spacing
    Highest := 0;
    for var J := 0 to FLayers[I].Count - 1 do
    begin
      Node := FLayers[I][J];
      Highest := Max(Node.FHeight, Highest);
      Node.FYPos := YPos;
    end;
    Inc(YPos, Highest + FVSpacing);
  end;
end;

procedure TSugiyamaLayout.SetXPositions;
const
  MaxIter = 20;
var
  XPos, JPos, SumOfDiff, OldSumOfDiff, BailOut, RegStart, RegCount, MaxAmount, Amount: Integer;
  Force, LastForce, RegForce: Single;
  Layer: TNodeList;
  Node: TNode;
  Forces: array of Single;

  function InCenter(const Node: TNode): Integer;
  begin
    Result := Node.FXPos + Node.FWidth div 2;
  end;

  function InForce(const Node: TNode): Single;
  var
    Sum, Deg, CenterX: Integer;
  begin
    Deg := Node.FInEdges.Count + Node.FOutEdges.Count;
    if Deg = 0 then
    begin
      Result := 0;
      Exit;
    end;
    Sum := 0;
    CenterX := InCenter(Node);
    for var I := 0 to Node.FInEdges.Count - 1 do
      Inc(Sum, InCenter(Node.FInEdges[I].FFromNode) - CenterX);
    for var I := 0 to Node.FOutEdges.Count - 1 do
      Inc(Sum, InCenter(Node.FOutEdges[I].FToNode) - CenterX);
    Inc(SumOfDiff, Abs(Sum));
    Result := (1 / Deg) * Sum;
  end;

begin
  // Initialize XPos for each node based on its position within the layer
  for var I := 0 to FLayers.Count - 1 do
  begin
    Layer := FLayers[I];
    XPos := FHSpacing;
    for var J := 0 to Layer.Count - 1 do
    begin
      Node := Layer[J];
      Node.FXPos := XPos;
      Inc(XPos, FHSpacing + Node.FWidth);
    end;
  end;

  BailOut := 0;
  OldSumOfDiff := High(Integer);
  repeat
    Inc(BailOut);
    // SumOfDiff is the sum of differences between all node.XPos and node.desired_X
    SumOfDiff := 0;
    for var I := 0 to FLayers.Count - 1 do
    begin
      Layer := FLayers[I];

      SetLength(Forces, Layer.Count);
      for var J := 0 to Layer.Count - 1 do
        Forces[J] := InForce(Layer[J]);

      // Calc regions of FNodes so that two neibours do not block each other out
      RegStart := 0;
      while RegStart < Layer.Count do
      begin
        LastForce := Forces[RegStart];
        RegForce := LastForce;
        RegCount := 1;
        JPos := RegStart + 1;
        // "Touching" FNodes with higher force belongs to the same group
        while (JPos < Layer.Count) and (LastForce >= Forces[JPos]) and
          (Layer[JPos].FXPos - (Layer[JPos - 1].FXPos + Layer[JPos - 1].FWidth) <= FHSpacing) do
        begin
          LastForce := Forces[JPos];
          RegForce := RegForce + LastForce;
          Inc(JPos);
          Inc(RegCount);
        end;
        Force := 1 / RegCount * RegForce;

        if Force <> 0 then
        begin
          if Force < 0 then
          begin
            // Move region left
            if RegStart = 0 then
              MaxAmount := Layer[RegStart].FXPos - FHSpacing
            else // Cannot move over node to the left
              MaxAmount := Layer[RegStart].FXPos -
                (Layer[RegStart - 1].FXPos + Layer[RegStart - 1].FWidth + FHSpacing);
            Amount := -Min(Abs(Round(Force)), MaxAmount);
          end
          else
          begin
            // Move region right
            if RegStart + RegCount = Layer.Count then
              MaxAmount := High(Integer)
            else // Cannot move over node to the right
              MaxAmount := Layer[RegStart + RegCount].FXPos -
                (Layer[RegStart + RegCount - 1].FXPos + Layer[RegStart + RegCount -
                1].FWidth + FHSpacing);
            Amount := Min(Round(Force), MaxAmount);
          end;

          // Move FNodes in region
          if Amount <> 0 then
            for var J := RegStart to RegStart + RegCount - 1 do
              Inc(Layer[J].FXPos, Amount);
        end;

        // Advance regionstart to first node after this region
        // This line must be executed, Continue cannot be used in the code above
        Inc(RegStart, RegCount);
      end; // Regions
    end; // FLayers

    // Stop if no more improvment
    if SumOfDiff >= OldSumOfDiff then
      Break;
    OldSumOfDiff := SumOfDiff;

  until (BailOut = MaxIter) or (SumOfDiff = 0);

end;

procedure TSugiyamaLayout.XCorrection;
var
  MinX, Correction: Integer;
  Layer: TNodeList;
begin
  // search leftmost node
  MinX := High(Integer);
  for var I := 0 to FLayers.Count - 1 do
  begin
    Layer := FLayers[I];
    // FXPos:= FHSpacing;
    for var J := 0 to Layer.Count - 1 do
      if Assigned(Layer[J].FControl) and (Layer[J].FXPos < MinX) then
        MinX := Layer[J].FXPos;
  end;
  // left shift
  Correction := MinX - FHSpacing;
  if Correction > 0 then
    for var I := 0 to FLayers.Count - 1 do
    begin
      Layer := FLayers[I];
      // FXPos:= FHSpacing;
      for var J := 0 to Layer.Count - 1 do
        Layer[J].FXPos := Layer[J].FXPos - Correction;
    end;

end;

procedure TSugiyamaLayout.PositioningPhase;
begin
  SetYPositions;
  SetXPositions;
  XCorrection;
end;

// Insert dummy-FNodes so that each edge has length 1.
procedure TSugiyamaLayout.MakeProper;
{
  O         O
  |   -->   |
  |         x
  |         |
  O         O
}
const
  DummyWidth = 200;
var
  Diff: Integer;
  Node: TNode;
  Edge: TEdge;
  Path: array of TNode;

  function InMakeDummy: TNode;
  begin
    Result := TNode.Create;
    Result.FIsDummy := True;
    // Dummys must have a width, otherwise they will be kicked away by PositionX
    Result.FWidth := DummyWidth;
    Result.FId := FNodes.Count;
    FNodes.Add(Result);
  end;

begin
  for var I := 0 to FNodes.Count - 1 do
  begin
    Node := FNodes[I];
    for var J := 0 to Node.FOutEdges.Count - 1 do
    begin
      Edge := Node.FOutEdges[J];
      Diff := Edge.FToNode.FRank - Node.FRank;
      if Diff > 1 then
      begin
        // Edge spans more than one layer, create dummy FNodes
        SetLength(Path, Diff - 1);
        for var K := 0 to High(Path) do
        begin
          Path[K] := InMakeDummy;
          Path[K].FRank := Node.FRank + K + 1;
          if K > 0 then
            AddEdge(Path[K - 1], Path[K]);
        end;
        for var K := 0 to Edge.FToNode.FInEdges.Count - 1 do
          if Edge.FToNode.FInEdges[K].FFromNode = Node then
          begin
            Edge.FToNode.FInEdges[K].FFromNode := Path[High(Path)];
            Break;
          end;
        Path[High(Path)].FOutEdges.Add(TEdge.Create(Path[High(Path)],
          Edge.FToNode));
        Edge.FToNode := Path[0];
        Path[0].FInEdges.Add(TEdge.Create(Node, Path[0]));
      end;
    end;
  end;
end;

function WeightSortProc(Item1, Item2: Pointer): Integer;
begin
  Result := 0;
  if TNode(Item1).FWeight < TNode(Item2).FWeight then
    Result := -1
  else if TNode(Item1).FWeight = TNode(Item2).FWeight then
  begin

    { if (TNode(Item1).FControl is TRtfdObject) and (TNode(Item2).FControl is TRtfdObject) then begin
      if TNode(Item1).Name < TNode(Item2).Name
      then Result:= -1
      else if TNode(Item1).Name = TNode(Item2).Name
      then begin
      if TNode(Item1).NameNr < TNode(Item2).NameNr then
      Result:= -1
      else if TNode(Item1).NameNr = TNode(Item2).NameNr
      then Result:= 0
      else Result:= 1;
      end
      else Result:= +1;
      end else
      Result:=0  //equal }
  end
  else
    Result := 1;
end;

function OrderSortProc(Item1, Item2: Pointer): Integer;
begin
  if TNode(Item1).FOrder < TNode(Item2).FOrder then
    Result := -1
  else if TNode(Item1).FOrder = TNode(Item2).FOrder then
    Result := 0 // equal
  else
    Result := 1;
end;

procedure TSugiyamaLayout.OrderingPhase;
const
  MaxIter = 20;
var
  BailOut, BestC: Integer;
  BestO: array of Integer;
  Layer: TNodeList;
  Node: TNode;

  function WeightPred(const Node: TNode): Single;
  var
    Sum: Integer;
  begin
    Sum := 0;
    for var I := 0 to Node.FInEdges.Count - 1 do
      if Assigned(Node.FInEdges[I].FFromNode.FControl) then // Rr
        Inc(Sum, Node.FInEdges[I].FFromNode.FOrder);
    if Node.FInEdges.Count = 0 then
      Result := 0
    else
      Result := Sum / Node.FInEdges.Count;
  end;

  function WeightSucc(const Node: TNode): Single;
  var
    Sum: Integer;
  begin
    Sum := 0;
    for var I := 0 to Node.FOutEdges.Count - 1 do
      if Assigned(Node.FOutEdges[I].FFromNode.FControl) then // Rr
        Inc(Sum, Node.FOutEdges[I].FToNode.FOrder);
    if Node.FOutEdges.Count = 0 then
      Result := 0
    else
      Result := Sum / Node.FOutEdges.Count;
  end;

  procedure InCheckCrossings;
  var
    Int: Integer;
  begin
    Int := CalcCrossings;
    if Int < BestC then
    begin
      BestC := Int;
      for Int := 0 to FNodes.Count - 1 do
        BestO[Int] := FNodes[Int].FOrder;
    end;
  end;

begin
  // **ge initial FOrder, anropa remakeLayers;
  // **nu uppdaterar vi bara FOrder
  for var I := 0 to FLayers.Count - 1 do
    for var J := 0 to FLayers[I].Count - 1 do
      FLayers[I][J].FOrder := J;

  BailOut := 0;
  BestC := High(Integer);
  SetLength(BestO, FNodes.Count);
  repeat
    Inc(BailOut);
    // Go down and sort each layer based on the FOrder of FNodes in the layer above.
    for var I := 1 to FLayers.Count - 1 do
    begin
      Layer := FLayers[I];
      for var J := 0 to Layer.Count - 1 do
      begin
        Node := Layer[J];
        Node.FWeight := WeightPred(Node);
      end;
      Layer.Sort( {$IFDEF LCL} @ {$ENDIF} WeightSortProc);
      // Update FOrder because FNodes have switched positions
      for var J := 0 to Layer.Count - 1 do
        Layer[J].FOrder := J;
    end;
    InCheckCrossings;
    if BestC = 0 then
      Break;
    // Go up and sort each layer based on the FOrder of FNodes in the layer below.
    for var I := FLayers.Count - 2 downto 0 do
    begin
      Layer := FLayers[I];
      for var J := 0 to Layer.Count - 1 do
      begin
        Node := Layer[J];
        Node.FWeight := WeightSucc(Node);
      end;
      Layer.Sort( {$IFDEF LCL} @ {$ENDIF} WeightSortProc);
      // Update FOrder because FNodes have switched positions
      for var J := 0 to Layer.Count - 1 do
        Layer[J].FOrder := J;
    end;
    InCheckCrossings;
    // **ha flera tester för när vi skall avbryta, t.ex. ingen improvment sker
    // **nu körs alltid till maxiter
  until (BailOut > MaxIter) or (BestC = 0);

  // Apply the best FOrder found
  for var I := 0 to FNodes.Count - 1 do
    FNodes[I].FOrder := BestO[I];
  for var I := 0 to FLayers.Count - 1 do
    FLayers[I].Sort( {$IFDEF LCL} @ {$ENDIF} OrderSortProc);
end;

function TSugiyamaLayout.CalcCrossings: Integer;
begin
  Result := 0;
  if FLayers.Count > 1 then
    for var I := 0 to FLayers.Count - 2 do
      Inc(Result, CalcCrossingsTwoLayers(FLayers[I], FLayers[I + 1]));
end;

function ToNodeCOrderSortProc(Item1, Item2: Pointer): Integer;
begin
  if TEdge(Item1).FToNode.FCOrder < TEdge(Item2).FToNode.FCOrder then
    Result := -1
  else if TEdge(Item1).FToNode.FCOrder = TEdge(Item2).FToNode.FCOrder then
    Result := 0 // equal
  else
    Result := 1;
end;

function FromNodeCOrderSortProc(Item1, Item2: Pointer): Integer;
begin
  if TEdge(Item1).FFromNode.FCOrder < TEdge(Item2).FFromNode.FCOrder then
    Result := -1
  else if TEdge(Item1).FFromNode.FCOrder = TEdge(Item2).FFromNode.FCOrder then
    Result := 0 // equal
  else
    Result := 1;
end;

function TSugiyamaLayout.CalcCrossingsTwoLayers(const Layer1,
  Layer2: TNodeList): Integer;
var
  FCOrder, KPos: Integer;
  Count1, Count2, Count3: Integer;
  CNodes, UList, LList: TNodeList;
  Node: TNode;
begin
  Result := 0;
  FCOrder := 0;
  CNodes := TNodeList.Create(False);
  UList := TNodeList.Create(False);
  LList := TNodeList.Create(False);
  try

    // Initialize CNodes and Node.FCOrder
    for var I := 0 to Max(Layer1.Count, Layer2.Count) - 1 do
    begin
      Node := nil;
      if I < Layer2.Count then
      begin
        Node := Layer2[I];
        Node.FCOrder := FCOrder;
      end;
      CNodes.Add(Node);
      Inc(FCOrder);

      Node := nil;
      if I < Layer1.Count then
      begin
        Node := Layer1[I];
        Node.FCOrder := FCOrder;
      end;
      CNodes.Add(Node);
      Inc(FCOrder);
    end;

    { foreach cnodes, node
      if odd, sort FOutEdges on FToNode.FCOrder
      if even, sort FInEdges on FFromNode.FCOrder }
    for var I := 0 to CNodes.Count - 1 do
    begin
      Node := CNodes[I];
      if not Assigned(Node) then
        Continue;
      if Odd(I) then
        Node.FOutEdges.Sort( {$IFDEF LCL} @ {$ENDIF} ToNodeCOrderSortProc)
      else
        Node.FInEdges.Sort( {$IFDEF LCL} @ {$ENDIF} FromNodeCOrderSortProc);
    end;

    for var I := 0 to CNodes.Count - 1 do
    begin
      Node := CNodes[I];
      if not Assigned(Node) then
        Continue;
      if Odd(I) then
      begin
        // Odd, upper layer
        KPos := UList.LastIndexOf(Node);
        if KPos <> -1 then
        begin
          Count1 := 0;
          Count2 := 0;
          Count3 := 0;
          for var J := 0 to KPos do
          begin
            // Loop all active endpoints in upperlayer
            if UList[J] = Node then
            begin
              Inc(Count1);
              Inc(Count3, Count2);
              UList.Items[J] := nil;
            end
            else
              Inc(Count2);
          end;
          UList.Pack;
          // Increase nr of crossings
          Inc(Result, Count1 * LList.Count + Count3);
        end;
        // Add new active endpoints in lowerlayer
        for var J := 0 to Node.FOutEdges.Count - 1 do
        begin
          // Only add edges that points "to the right" (higher FCOrder), the other edges are handled by even
          if I < Node.FOutEdges[J].FToNode.FCOrder then
            LList.Add(Node.FOutEdges[J].FToNode);
        end;
      end
      else
      begin
        // Even, lower layer
        KPos := LList.LastIndexOf(Node);
        if KPos <> -1 then
        begin
          Count1 := 0;
          Count2 := 0;
          Count3 := 0;
          for var J := 0 to KPos do
          begin
            // Loop all active endpoints in upperlayer
            if LList[J] = Node then
            begin
              Inc(Count1);
              Inc(Count3, Count2);
              LList.Items[J] := nil;
            end
            else
              Inc(Count2);
          end;
          LList.Pack;
          // Increase nr of crossings
          Inc(Result, Count1 * UList.Count + Count3);
        end;
        // Add new active endpoints in upperlayer
        for var J := 0 to Node.FInEdges.Count - 1 do
        begin
          // Only add edges that points "to the right" (higher FCOrder), the other edges are handled by odd
          if I < Node.FInEdges[J].FFromNode.FCOrder then
            UList.Add(Node.FInEdges[J].FFromNode);
        end;
      end;
    end;
  finally
    FreeAndNil(CNodes);
    FreeAndNil(UList);
    FreeAndNil(LList);
  end;
end;

{ TEdge }

constructor TEdge.Create(const FromNode, ToNode: TNode);
begin
  Self.FFromNode := FromNode;
  Self.FToNode := ToNode;
end;

{ TNode }

constructor TNode.Create;
begin
  FInEdges := TEdgeList.Create;
  FOutEdges := TEdgeList.Create;
end;

destructor TNode.Destroy;
begin
  FreeAndNil(FInEdges);
  FreeAndNil(FOutEdges);
  inherited;
end;

{ TNodeList }

function TNodeList.GetNode(Index: Integer): TNode;
begin
  Result := TNode(Get(Index));
end;

function TNodeList.LastIndexOf(const APointer: Pointer): Integer;
begin
  Result := -1;
  for var I := Count - 1 downto 0 do
    if Get(I) = APointer then
    begin
      Result := I;
      Break;
    end;
end;

{ TEdgeList }

function TEdgeList.GetEdge(Index: Integer): TEdge;
begin
  Result := TEdge(Get(Index));
end;

{ TLayerList }

function TLayerList.GetLayer(Index: Integer): TNodeList;
begin
  Result := TNodeList(Get(Index));
end;

end.
