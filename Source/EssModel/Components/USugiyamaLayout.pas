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
    Id : Integer;     //Index in nodes-list, must be updated when node changes position (after re-sort)
    InEdges,OutEdges : TEdgeList;
    Rank : Integer;
    Order : Integer;
    COrder : Integer;
    Weight : single;
    IsDummy : Boolean;
    X,Y,H,W : Integer;
    Control : TControl;
    //Name: String;      // handle UML-objects special
    //NameNr: integer;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TEdge = class
  private
    FromNode, ToNode : TNode;
    constructor Create(const aFromNode, aToNode : TNode);
  end;

  {$HINTS OFF}
  TEdgeList = class(TObjectList)
  private
    function GetEdge(Index: Integer): TEdge;
    property Edges[Index: Integer]: TEdge read GetEdge; default;
  end;

  TNodeList = class(TObjectList)
  private
    function GetNode(Index: Integer): TNode;
    function LastIndexOf(const P : pointer) : Integer;
    property Nodes[Index: Integer]: TNode read GetNode; default;
  end;

  TLayerList = class(TObjectList)
  private
    function GetLayer(Index: Integer): TNodeList;
    property Layers[Index: Integer]: TNodeList read GetLayer; default;
  end;
  {$HINTS ON}

  TSugiyamaLayout = class
  private
    LManagedObjects: TList;
    LConnections: TList;
    HSpacing: Integer;
    VSpacing: Integer;
    Nodes : TNodeList;
    Layers : TLayerList;
    procedure ExtractNodes;
    procedure ApplyNodes;
    procedure DoPhases;
    procedure AddEdge(const FromNode,ToNode : TNode);

    //First phase
    procedure LayeringPhase;
    procedure MakeAcyclic;
    procedure InitialRanking;
    procedure MakeProper;
    procedure TopoSort;

    //Second phase
    procedure OrderingPhase;
    function CalcCrossings : Integer;
    function CalcCrossingsTwoLayers(const Layer1,Layer2 : TNodeList) : Integer;

    //Third phase
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

uses Math, SysUtils, UUtils, UConnection{, URtfdComponents};  // ToDo

{ TSugiyamaLayout }

constructor TSugiyamaLayout.Create(ManagedObjects: TList; Connections: TList);
begin
  LManagedObjects := ManagedObjects;
  LConnections:= Connections;
end;

procedure TSugiyamaLayout.Execute;
begin
  HSpacing:= 20;
  VSpacing:= 40;
  try
    ExtractNodes;
    DoPhases;
    ApplyNodes;
  except on e: Exception do
    ErrorMsg('TSugiyamaLayout.Execute');
  end;
end;

//Extract nodes from essconnectpanel
procedure TSugiyamaLayout.ExtractNodes;
var
  L : TList;
  I : Integer;
  C : TControl;
  Con : TConnection;
  Node,FromNode,ToNode : TNode;
begin
  Nodes:= TNodeList.Create(True);

  L:= LManagedObjects;
  try
    for I:= 0 to L.Count-1 do
    begin
      C:= TControl(L[I]);
      if not C.Visible then
        Continue;
      Node:= TNode.Create;
      Node.H:= C.Height;
      Node.W:= C.Width;
      Node.Control:= C;
      Node.Id:= Nodes.Count;
      { ToDo
      Node.Name:= (C as TRtfdBox).Entity.Name;
      if (C is TRtfdObject) then begin
        p:= length(Node.Name);
        if (p > 0) and isdigit(Node.Name[p]) then begin
          while isDigit(Node.Name[p]) do dec(p);
          Node.NameNr:= StrToInt(copy(Node.name, p+1, length(Node.Name)));
          delete(Node.Name, p+1, length(Node.Name));
        end else
          Node.NameNr:= 0;
      end;
      }
      C.Tag:= Node.Id;
      Nodes.Add(Node);
    end;
  finally
    FreeAndNil(L);
  end;

  L:= LConnections;
  try
    for I:= 0 to L.Count-1 do
    begin
      Con:= TConnection(L[I]);
      if (not Con.FFrom.Visible) or (not Con.FTo.Visible) then
        Continue;

      if Con.isRecursiv then begin
        HSpacing:= 80;
        VSpacing:= 80;
        Continue;
      end;

      //Here the connection is reversed: from=to, to=from
      //This is because the algorithm assumes that everything points downwards, while
      //we want all arrows to point upwards (descendants pointing up to their baseclass).
      if (Con.ConnectStyle=csNormal) or (Con.ArrowStyle = asInstanceOf) then
      begin  //Reverse Inheritance-connections
        FromNode:= Nodes[ Con.FTo.Tag ];
        ToNode:= Nodes[ Con.FFrom.Tag ];
      end
      else
      begin  //Do not reverse Unit-Associations and Implements-interface
        FromNode:= Nodes[ Con.FFrom.Tag ];
        ToNode:= Nodes[ Con.FTo.Tag ];
      end;
      AddEdge(FromNode,ToNode);
    end;
  finally
    FreeAndNil(L);
  end;
end;

//Writes back layout to essconnectpanel
procedure TSugiyamaLayout.ApplyNodes;
var
  I : Integer;
  Node : TNode;
begin
  for I:= 0 to Nodes.Count-1 do
  begin
    Node:= Nodes[I];
    if Node.IsDummy then
      Continue;
    Node.Control.Left:= Node.X;
    Node.Control.Top:= Node.Y;
  end;
end;


//Executes the different phases of the layout-algorithm
procedure TSugiyamaLayout.DoPhases;
begin
  //Place nodes in layers
  LayeringPhase;
  //Sort nodes within each layer
  OrderingPhase;
  //Decide final X and Y position for nodes
  PositioningPhase;
end;



//Make layers, and assign each node to a layer
procedure TSugiyamaLayout.LayeringPhase;
const
  //Max nr of nodes in a layer, used when distributing 'zeronodes'.
  LayerMaxNodes = 16;
var
  I,J,MinC,MinI : Integer;
  Node : TNode;
  ZeroNodes : TNodeList;
begin
  MakeAcyclic;
  InitialRanking;
  MakeProper;
  //Here the layers are created based on the ranking-value of nodes.
  Layers:= TLayerList.Create;
  ZeroNodes:= TNodeList.Create(False);
  try
    for I:= 0 to Nodes.Count-1 do begin
      Node:= Nodes[I];
      if Node.InEdges.Count + Node.OutEdges.Count=0 then
        ZeroNodes.Add(Node)
      else begin
        while Layers.Count<Nodes[I].Rank + 1 do
          Layers.Add( TNodeList.Create(False) );
        Layers[ Nodes[I].Rank ].Add( Nodes[I] );
      end;
    end;
    //Distribute nodes without edges onto layers with the least nr of nodes
    for I:=0 to ZeroNodes.Count-1 do begin
      MinC:= LayerMaxNodes;
      MinI:= 0;
      for J:= 0 to Layers.Count-1 do
        if Layers[J].Count<MinC then begin
          MinC:= Layers[J].Count;
          MinI:= J;
        end;
      if MinC>=LayerMaxNodes then begin
        //If all layers has LayerMaxNodes nr of nodes, then create a new layer
        Layers.Add( TNodeList.Create(False) );
        MinI:= Layers.Count-1;
      end;
      Layers[MinI].Add(ZeroNodes[I]);
    end;
  finally
    FreeAndNil(ZeroNodes);
  end;
  //Now all edges should be pointing down onto the layer directly beneath it.
end;


destructor TSugiyamaLayout.Destroy;
begin
  FreeAndNil(Nodes);
  FreeAndNil(Layers);
  inherited;
end;


procedure TSugiyamaLayout.AddEdge(const FromNode, ToNode: TNode);
begin
  FromNode.OutEdges.Add( TEdge.Create(FromNode,ToNode) );
  ToNode.InEdges.Add( TEdge.Create(FromNode,ToNode) );
end;


procedure TSugiyamaLayout.MakeAcyclic;
{
  The graph cannot include cycles, so these must be removed.

  A cycle is removed by reversing an edge in the cycle.

  DFS = Depth First Search.

  "strongly connected components"
    This means nodes where there is a path a->b and b<-a (cycles)

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
  TDfsStruct =
    record
      Visited,Removed : Boolean;
      DfsNum,DfsLow : Integer;
    end;
var
  DfsList : array of TDfsStruct;
  CurDfs,CycCount : Integer;
  Path : TObjectList;
  I,Safety : Integer;
  SuperNode : TNode;

  procedure InReverse(N : TNode; E : Integer);
  var
    I : Integer;
    ToNode : TNode;
  begin
    ToNode:= N.OutEdges[E].ToNode;
    for I:= 0 to ToNode.InEdges.Count-1 do
      if ToNode.InEdges[I].FromNode = N then
      begin
        ToNode.InEdges.Delete(I);
        N.OutEdges.Delete(E);
        AddEdge( ToNode, N );
        Break;
      end;
  end;

  procedure InVisit(N : TNode);
  var
    I,J,Score,BestScore,RevEdge : Integer;
    W,V,RevNode : TNode;
    Cyc : TObjectList;
  begin
    Path.Add( N );
    with DfsList[ N.Id ] do
    begin
      DfsNum:= CurDfs;
      DfsLow:= CurDfs;
      Visited:= True;
    end;
    Inc(CurDfs);
    //Walk out-edges recursive
    for I:= 0 to N.OutEdges.Count-1 do
    begin
      W:= N.OutEdges[I].ToNode;
      if not DfsList[ W.Id ].Removed then
      begin
        if not DfsList[ W.Id ].Visited then
        begin
          InVisit(W);
          DfsList[ N.Id ].DfsLow:= Min( DfsList[ N.Id ].DfsLow , DfsList[ W.Id ].DfsLow );
        end
        else
          DfsList[ N.Id ].DfsLow:= Min( DfsList[ N.Id ].DfsLow , DfsList[ W.Id ].DfsNum );
      end;
    end;
    //Check if there was a cycle
    if DfsList[ N.Id ].DfsLow = DfsList[ N.Id ].DfsNum then
    begin
      Cyc:= TObjectList.Create(False);
      repeat
        V:= TNode(Path.Last);
        Path.Delete( Path.Count-1 );
        Cyc.Add( V );
        DfsList[ V.Id ].Removed:= True;
      until V = N;
      if Cyc.Count>1 then
      begin //Real cycle found
        Inc(CycCount);
        BestScore:= -1;
        RevEdge:= 0;
        RevNode:= TNode(Cyc[0]);
        for I:=0 to Cyc.Count-1 do
        begin //Find edge with min( outdeg(v) ) max( indeg(v) + indeg(w) )
          V:= TNode(Cyc[I]);
          for J:= 0 to V.OutEdges.Count-1 do
            if Cyc.IndexOf( V.OutEdges[J].ToNode )>-1 then
            begin
              Score:= V.InEdges.Count + V.OutEdges[J].ToNode.InEdges.Count - V.OutEdges.Count;
              if V.OutEdges.Count=1 then
                Inc(Score,50);
              if Score>BestScore then
              begin
                BestScore:= Score;
                RevNode:= V;
                RevEdge:= J;
              end;
            end;
        end;
        InReverse(RevNode,RevEdge);
      end;
      FreeAndNil(Cyc);
    end;
  end;

begin
  Path:= TObjectList.Create(False);
  SuperNode:= TNode.Create;
  try
    for I:= 0 to Nodes.Count-1 do
      SuperNode.OutEdges.Add( TEdge.Create(SuperNode,Nodes[I]) );
    SuperNode.Id:= Nodes.Count;

    Safety:= 0;
    repeat
      Path.Clear;
      DfsList:= nil;
      SetLength(DfsList,Nodes.Count + 1);
      CurDfs:= 0;
      CycCount:= 0;
      InVisit(SuperNode);
      Inc(Safety);
      if Safety > 30 then
        raise Exception.Create('Layout failed.');
    until CycCount=0;
  finally
    FreeAndNil(SuperNode);
    FreeAndNil(Path);
  end;
end;

var
  //Global temparray used by sortfunc
  _Labels : array of Integer;

function TopoSortProc(Item1, Item2: Pointer): Integer;
begin
  if _Labels[ TNode(Item1).Id ] < _Labels[ TNode(Item2).Id ] then
    Result:= -1
  else if _Labels[ TNode(Item1).Id ] = _Labels[ TNode(Item2).Id ] then
    Result:=0  //equal
  else
    Result:= 1;
end;


{
  Topological sort.

  Sort so that all dependancies points forward in the list.

  Topological order:
    A numbering of the nodes of a directed acyclic graph such that every edge from a node
    numbered i to a node numbered j satisfies i<j.
}

procedure TSugiyamaLayout.TopoSort;
var
  Indeg : array of Integer;
  S : TStack;
  I,NextLabel : Integer;
  Node : TNode;
  Edge : TEdge;
begin
  SetLength(Indeg,Nodes.Count);
  _Labels:= nil;
  SetLength(_Labels,Nodes.Count);

  S:=TStack.Create;
  try
    //init indeg with n.indeg
    //push nodes without incoming edges
    for I:=0 to Nodes.Count-1 do
    begin
      Indeg[I]:= Nodes[I].InEdges.Count;
      if Indeg[I]=0 then
        S.Push(Nodes[I]);
    end;

    if S.Count > 0 then begin

      NextLabel:= 0;
      while S.Count>0 do
      begin
        Node:= TNode(S.Pop);
        Inc(NextLabel);
        _Labels[Node.Id]:=NextLabel;
        for I:=0 to Node.OutEdges.Count-1 do
        begin
          Edge:= Node.OutEdges[I];
          Dec(Indeg[ Edge.ToNode.Id ]);
          if (Indeg[ Edge.ToNode.Id ]=0) and (_Labels[Edge.ToNode.Id]=0) then
            S.Push( Edge.ToNode );
        end;
      end;

      //0 cannot be in _labels, i.e. all nodes must have been processed in the previous step
   {   for I:= 0 to High(_Labels) do
        if _Labels[I]=0 then
          raise Exception.Create('connection-cycles'); }

      //sort nodes based on their _label
      Nodes.Sort({$IFDEF LCL} @ {$ENDIF} TopoSortProc);
      _Labels:= nil;
      //refresh node id's after sort
      for I:=0 to Nodes.Count-1 do
        Nodes[I].Id:=I;
    end;
  finally
    FreeAndNil(S);
  end;
end;


procedure TSugiyamaLayout.InitialRanking;
{
    sortera nodes med topological sort

    nodes[0] har minst antal indeg, nodes[count] har flest
      setlength(rank,nodes.count)
      foreach nodes, n
        r = 0
        foreach nodes i n.inEdges, innode
          if rank[ innode ]>r then r= rank[ innode ] + 1
        rank[index]=r
}
var
  I,J,R,Temp : Integer;
begin
  TopoSort;
  for I:= 0 to Nodes.Count-1 do
  begin
    R:= 0;
    for J:= 0 to Nodes[I].InEdges.Count-1 do
    begin
      Temp:= Nodes[I].InEdges[J].FromNode.Rank;
      if Temp>=R then
        R:= Temp + 1;
    end;
    Nodes[I].Rank:= R;
  end;
end;


procedure TSugiyamaLayout.SetYPositions;
var
  Node : TNode;
  I,J : Integer;
  Highest,Y : Integer;
begin
  Y:= VSpacing;
  for I:= 0 to Layers.Count-1 do
  begin
    //Put all nodes in a layer with the same Y, increase Y with highest node + spacing
    Highest:= 0;
    for J:= 0 to Layers[I].Count-1 do
    begin
      Node:= Layers[I][J];
      Highest:= Max(Node.H,Highest);
      Node.Y:= Y;
    end;
    Inc(Y,Highest + VSpacing);
  end;
end;


procedure TSugiyamaLayout.SetXPositions;
const
  MaxIter = 20;
var
  I,J,X,Z,OldZ,BailOut,RegStart,RegCount,MaxAmount,Amount : Integer;
  Force,LastForce,RegForce : single;
  Layer : TNodeList;
  Node : TNode;
  Forces : array of single;

  function InCenter(const Node : TNode) : Integer;
  begin
    Result:= Node.X + Node.W div 2;
  end;

  function InForce(const Node : TNode) : single;
  var
    Sum : Integer;
    I,Deg,CenterX : Integer;
  begin
    Deg:= Node.InEdges.Count + Node.OutEdges.Count;
    if Deg=0 then
    begin
      Result:= 0;
      Exit;
    end;
    Sum:= 0;
    CenterX:= InCenter(Node);
    for I:= 0 to Node.InEdges.Count-1 do
      Inc(Sum, InCenter(Node.InEdges[I].FromNode) - CenterX );
    for I:= 0 to Node.OutEdges.Count-1 do
      Inc(Sum, InCenter(Node.OutEdges[I].ToNode) - CenterX );
    Inc(Z, Abs(Sum) );
    Result:= (1 / Deg) * Sum;
  end;

begin
  //Initialize X for each node based on its position within the layer
  for I:= 0 to Layers.Count-1 do
  begin
    Layer:= Layers[I];
    X:= HSpacing;
    for J:= 0 to Layer.Count-1 do
    begin
      Node:= Layer[J];
      Node.X:= X;
      Inc(X,HSpacing + Node.W);
    end;
  end;

  BailOut:= 0;
  OldZ:= High(Integer);
  repeat
    Inc(BailOut);
    //Z is the sum of differences between all node.x and node.desired_X
    Z:= 0;
    for I:= 0 to Layers.Count-1 do
    begin
      Layer:= Layers[I];

      SetLength(Forces,Layer.Count);
      for J:= 0 to Layer.Count-1 do
        Forces[J]:= InForce(Layer[J]);

      //Calc regions of nodes so that two neibours do not block each other out
      RegStart:=0;
      while RegStart<Layer.Count do
      begin
        LastForce:= Forces[RegStart];
        RegForce:= LastForce;
        RegCount:= 1;
        J:= RegStart + 1;
        //"Touching" nodes with higher force belongs to the same group
        while (J < Layer.Count) and (LastForce >= Forces[J]) and
          (Layer[J].X - (Layer[J-1].X + Layer[J-1].W) <= HSpacing) do
        begin
          LastForce:= Forces[J];
          RegForce:= RegForce + LastForce;
          Inc(J);
          Inc(RegCount);
        end;
        Force:= 1/RegCount * RegForce;

        if Force<>0 then
        begin
          if Force<0 then
          begin
            //Move region left
            if RegStart=0 then
              MaxAmount:= Layer[RegStart].X - HSpacing
            else //Cannot move over node to the left
              MaxAmount:= Layer[RegStart].X - (Layer[RegStart-1].X + Layer[RegStart-1].W + HSpacing);
            Amount:= -Min( Abs(Round(Force)) , MaxAmount );
          end
          else
          begin
            //Move region right
            if RegStart + RegCount = Layer.Count then
              MaxAmount:= High(Integer)
            else //Cannot move over node to the right
              MaxAmount:= Layer[RegStart + RegCount].X -
                (Layer[ RegStart + RegCount - 1 ].X + Layer[ RegStart + RegCount - 1 ].W + HSpacing);
            Amount:= Min( Round(Force) , MaxAmount );
          end;

          //Move nodes in region
          if Amount<>0 then
            for J:= RegStart to RegStart + RegCount - 1 do
              Inc(Layer[J].X,Amount);
        end;

        //Advance regionstart to first node after this region
        //This line must be executed, Continue cannot be used in the code above
        Inc(RegStart,RegCount)
      end; //Regions
    end; //Layers

    //Stop if no more improvment
    if Z>=OldZ then
      Break;
    OldZ:= Z;

  until (BailOut=MaxIter) or (Z=0);

end;

procedure TSugiyamaLayout.XCorrection;
  var i, j, minx, correction: Integer;
    Layer : TNodeList;
begin
  // search leftmost node
  minx:= high(Integer);
  for I:= 0 to Layers.Count-1 do begin
    Layer:= Layers[I];
    // X:= HSpacing;
    for J:= 0 to Layer.Count-1 do
      if Assigned(Layer[j].Control) and (Layer[J].x < minx) then
        minx:= Layer[j].X;
  end;
  // left shift
  correction:= minx - hSpacing;
  if correction > 0 then
    for I:= 0 to Layers.Count-1 do begin
      Layer:= Layers[I];
      // X:= HSpacing;
      for J:= 0 to Layer.Count-1 do
        Layer[J].x:= Layer[J].X - correction;
    end;

end;


procedure TSugiyamaLayout.PositioningPhase;
begin
  SetYPositions;
  SetXPositions;
  XCorrection;
end;


//Insert dummy-nodes so that each edge has length 1.
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
  I,J,K,Diff : Integer;
  Node : TNode;
  Edge : TEdge;

  Path : array of TNode;

  function InMakeDummy : TNode;
  begin
    Result:= TNode.Create;
    Result.IsDummy:= True;
    //Dummys must have a width, otherwise they will be kicked away by PositionX
    Result.W:= DummyWidth;
    Result.Id:= Nodes.Count;
    Nodes.Add(Result);
  end;

begin
  for I:= 0 to Nodes.Count-1 do
  begin
    Node:= Nodes[I];
    for J:= 0 to Node.OutEdges.Count-1 do
    begin
      Edge:= Node.OutEdges[J];
      Diff:= Edge.ToNode.Rank - Node.Rank;
      Assert(Diff>0);
      if Diff>1 then
      begin
        //Edge spans more than one layer, create dummy nodes
        SetLength(Path,Diff-1);
        for K:= 0 to High(Path) do
        begin
          Path[K]:= InMakeDummy;
          Path[K].Rank:= Node.Rank + K + 1;
          if K>0 then
            AddEdge(Path[K-1],Path[K]);
        end;
        for K:= 0 to Edge.ToNode.InEdges.Count-1 do
          if Edge.ToNode.InEdges[K].FromNode=Node then
          begin
            Edge.ToNode.InEdges[K].FromNode:= Path[High(Path)];
            Break;
          end;
        Path[High(Path)].OutEdges.Add( TEdge.Create(Path[High(Path)],Edge.ToNode) );
        Edge.ToNode:= Path[0];
        Path[0].InEdges.Add( TEdge.Create(Node,Path[0]) );
      end;
    end;
  end;
end;

function WeightSortProc(Item1, Item2: Pointer): Integer;
begin
  Result:= 0;
  if TNode(Item1).Weight < TNode(Item2).Weight then
    Result:= -1
  else if TNode(Item1).Weight = TNode(Item2).Weight then begin

    {if (TNode(Item1).Control is TRtfdObject) and (TNode(Item2).Control is TRtfdObject) then begin
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
      Result:=0  //equal}
    end
  else
    Result:= 1;
end;

function OrderSortProc(Item1, Item2: Pointer): Integer;
begin
  if TNode(Item1).Order < TNode(Item2).Order then
    Result:= -1
  else if TNode(Item1).Order = TNode(Item2).Order then
    Result:=0  //equal
  else
    Result:= 1;
end;

procedure TSugiyamaLayout.OrderingPhase;
const
  MaxIter = 20;
var
  I,J,BailOut,BestC : Integer;
  BestO : array of Integer;
  Layer : TNodeList;
  Node : TNode;

  function WeightPred(const Node : TNode) : single;
  var
    Sum,I : Integer;
  begin
    Sum:= 0;
    for I:= 0 to Node.InEdges.Count-1 do
      if Assigned(Node.InEdges[I].FromNode.Control) then  // Rr
        Inc(Sum,Node.InEdges[I].FromNode.Order);
    if Node.InEdges.Count = 0 then
      Result:= 0
    else
      Result:= Sum / Node.InEdges.Count;
  end;

  function WeightSucc(const Node : TNode) : single;
  var
    Sum,I : Integer;
  begin
    Sum:= 0;
    for I:= 0 to Node.OutEdges.Count-1 do
      if Assigned(Node.OutEdges[I].FromNode.Control) then   // Rr
        Inc(Sum,Node.OutEdges[I].ToNode.Order);
    if Node.OutEdges.Count = 0 then
      Result:= 0
    else
      Result:= Sum / Node.OutEdges.Count;
  end;

  procedure InCheckCrossings;
  var
    I : Integer;
  begin
    I:= CalcCrossings;
    if I<BestC then
    begin
      BestC:= I;
      for I:= 0 to Nodes.Count-1 do
        BestO[I]:=Nodes[I].Order;
    end;
  end;

begin
  //**ge initial order, anropa remakeLayers;
  //**nu uppdaterar vi bara order
  for I:= 0 to Layers.Count-1 do
    for J:= 0 to Layers[I].Count-1 do
      Layers[I][J].Order:= J;

  BailOut:= 0;
  BestC:= High(Integer);
  SetLength(BestO,Nodes.Count);
  repeat
    Inc(BailOut);
    //Go down and sort each layer based on the order of nodes in the layer above.
    for I:= 1 to Layers.Count-1 do
    begin
      Layer:= Layers[I];
      for J:= 0 to Layer.Count-1 do
      begin
        Node:= Layer[J];
        Node.Weight:= WeightPred(Node);
      end;
      Layer.Sort( {$IFDEF LCL} @ {$ENDIF} WeightSortProc );
      //Update order because nodes have switched positions
      for J:= 0 to Layer.Count-1 do Layer[J].Order:= J;
    end;
    InCheckCrossings;
    if BestC=0 then
      Break;
    //Go up and sort each layer based on the order of nodes in the layer below.
    for I:= Layers.Count-2 downto 0 do
    begin
      Layer:= Layers[I];
      for J:= 0 to Layer.Count-1 do
      begin
        Node:= Layer[J];
        Node.Weight:= WeightSucc(Node);
      end;
      Layer.Sort( {$IFDEF LCL} @ {$ENDIF} WeightSortProc );
      //Update order because nodes have switched positions
      for J:= 0 to Layer.Count-1 do Layer[J].Order:= J;
    end;
    InCheckCrossings;
    //**ha flera tester för när vi skall avbryta, t.ex. ingen improvment sker
    //**nu körs alltid till maxiter
  until (BailOut>MaxIter) or (BestC=0);

  //Apply the best order found
  for I:= 0 to Nodes.Count-1 do
    Nodes[I].Order:= BestO[I];
  for I:= 0 to Layers.Count-1 do
    Layers[I].Sort( {$IFDEF LCL} @ {$ENDIF} OrderSortProc );
end;

function TSugiyamaLayout.CalcCrossings: Integer;
var
  I : Integer;
begin
  Result:= 0;
  if Layers.Count>1 then
    for I:= 0 to Layers.Count-2 do
      Inc( Result , CalcCrossingsTwoLayers(Layers[I],Layers[I+1]) );
end;

function ToNodeCOrderSortProc(Item1, Item2: Pointer): Integer;
begin
  if TEdge(Item1).ToNode.COrder < TEdge(Item2).ToNode.COrder then
    Result:= -1
  else if TEdge(Item1).ToNode.COrder = TEdge(Item2).ToNode.COrder then
    Result:=0  //equal
  else
    Result:= 1;
end;

function FromNodeCOrderSortProc(Item1, Item2: Pointer): Integer;
begin
  if TEdge(Item1).FromNode.COrder < TEdge(Item2).FromNode.COrder then
    Result:= -1
  else if TEdge(Item1).FromNode.COrder = TEdge(Item2).FromNode.COrder then
    Result:=0  //equal
  else
    Result:= 1;
end;

function TSugiyamaLayout.CalcCrossingsTwoLayers(const Layer1, Layer2: TNodeList): Integer;
var
  COrder,I,J,K : Integer;
  K1,K2,K3 : Integer;
  CNodes,UL,LL : TNodeList;
  Node : TNode;
begin
  Result:= 0;
  COrder:=0;
  CNodes:= TNodeList.Create(False);
  UL:= TNodeList.Create(False);
  LL:= TNodeList.Create(False);
  try

    //Initialize CNodes and Node.COrder
    for I:=0 to Max(Layer1.Count,Layer2.Count)-1 do
    begin
      Node:=nil;
      if I<Layer2.Count then
      begin
        Node:= Layer2[I];
        Node.COrder:=COrder;
      end;
      CNodes.Add(Node);
      Inc(COrder);

      Node:=nil;
      if I<Layer1.Count then
      begin
        Node:= Layer1[I];
        Node.COrder:=COrder;
      end;
      CNodes.Add(Node);
      Inc(COrder)
    end;

    {foreach cnodes, node
      if odd, sort outedges on tonode.corder
      if even, sort inedges on fromnode.corder}
    for I:= 0 to CNodes.Count-1 do
    begin
      Node:= CNodes[I];
      if Node=nil then
        Continue;
      if Odd(I) then
        Node.OutEdges.Sort( {$IFDEF LCL} @ {$ENDIF} ToNodeCOrderSortProc )
      else
        Node.InEdges.Sort( {$IFDEF LCL} @ {$ENDIF} FromNodeCOrderSortProc )
    end;

    for I:= 0 to CNodes.Count-1 do
    begin
      Node:= CNodes[I];
      if Node=nil then
        Continue;
      if Odd(I) then
      begin
        //Odd, upper layer
        K:= UL.LastIndexOf(Node);
        if K<>-1 then
        begin
          K1:=0; K2:=0; K3:=0;
          for J:= 0 to K do
          begin
            //Loop all active endpoints in upperlayer
            if UL[J]=Node then
            begin
              Inc(K1);
              Inc(K3,K2);
              UL.Items[J]:=nil;
            end
            else
              Inc(K2);
          end;
          UL.Pack;
          //Increase nr of crossings
          Inc(Result, K1 * LL.Count + K3);
        end;
        //Add new active endpoints in lowerlayer
        for J:= 0 to Node.OutEdges.Count-1 do
        begin
          //Only add edges that points "to the right" (higher corder), the other edges are handled by even
          if I < Node.OutEdges[J].ToNode.COrder then
            LL.Add( Node.OutEdges[J].ToNode );
        end;
      end
      else
      begin
        //Even, lower layer
        K:= LL.LastIndexOf(Node);
        if K<>-1 then
        begin
          K1:=0; K2:=0; K3:=0;
          for J:= 0 to K do
          begin
            //Loop all active endpoints in upperlayer
            if LL[J]=Node then
            begin
              Inc(K1);
              Inc(K3,K2);
              LL.Items[J]:=nil;
            end
            else
              Inc(K2);
          end;
          LL.Pack;
          //Increase nr of crossings
          Inc(Result, K1 * UL.Count + K3);
        end;
        //Add new active endpoints in upperlayer
        for J:= 0 to Node.InEdges.Count-1 do
        begin
          //Only add edges that points "to the right" (higher corder), the other edges are handled by odd
          if I < Node.InEdges[J].FromNode.COrder then
            UL.Add( Node.InEdges[J].FromNode );
        end;
      end;
    end;
  finally
    FreeAndNil(CNodes);
    FreeAndNil(UL);
    FreeAndNil(LL);
  end;
end;

{ TEdge }

constructor TEdge.Create(const aFromNode, aToNode: TNode);
begin
  Self.FromNode:= aFromNode;
  Self.ToNode:= aToNode;
end;

{ TNode }

constructor TNode.Create;
begin
  InEdges:= TEdgeList.Create;
  OutEdges:= TEdgeList.Create;
end;

destructor TNode.Destroy;
begin
  FreeAndNil(InEdges);
  FreeAndNil(OutEdges);
  inherited;
end;

{ TNodeList }

function TNodeList.GetNode(Index: Integer): TNode;
begin
  Result:= TNode(Get(Index));
end;

function TNodeList.LastIndexOf(const P: pointer): Integer;
var
  I : Integer;
begin
  Result:= -1;
  for I:= Count-1 downto 0 do
    if Get(I)=P then
    begin
      Result:= I;
      Break;
    end;
end;

{ TEdgeList }

function TEdgeList.GetEdge(Index: Integer): TEdge;
begin
  Result:= TEdge(Get(Index));
end;

{ TLayerList }

function TLayerList.GetLayer(Index: Integer): TNodeList;
begin
  Result:= TNodeList(Get(Index));
end;

end.
