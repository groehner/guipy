{-----------------------------------------------------------------------------
 Unit Name: frmVariables
 Author:    Kiriakos Vlahos
 Date:      09-Mar-2005
 Purpose:   Variables Window
 History:
-----------------------------------------------------------------------------}

unit frmVariables;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.Classes,
  System.ImageList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  JvComponentBase,
  JvDockControlForm,
  JvAppStorage,
  SpTBXDkPanels,
  SpTBXSkins,
  SpTBXPageScroller,
  SpTBXItem,
  SpTBXControls,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.AncestorVCL,
  VirtualTrees.BaseTree,
  VirtualTrees.HeaderPopup,
  VirtualTrees,
  frmIDEDockWin,
  cPyBaseDebugger;

type
  TVariablesWindow = class(TIDEDockWindow, IJvAppStorageHandler)
    VTHeaderPopupMenu: TVTHeaderPopupMenu;
    VariablesTree: TVirtualStringTree;
    DocPanel: TSpTBXPageScroller;
    SpTBXSplitter: TSpTBXSplitter;
    reInfo: TRichEdit;
    Panel1: TPanel;
    vilCodeImages: TVirtualImageList;
    procedure FormCreate(Sender: TObject);
    procedure VariablesTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VariablesTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VariablesTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VariablesTreeInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure reInfoResizeRequest(Sender: TObject; Rect: TRect);
    procedure VariablesTreeFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure VariablesTreeAddToSelection(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure VariablesTreeGetCellText(Sender: TCustomVirtualStringTree;
      var E: TVSTGetCellTextEventArgs);
  private
    { Private declarations }
    CurrentModule, CurrentFunction : string;
    FGlobalsNameSpace, LocalsNameSpace : TBaseNameSpaceItem;
    FOnNotify: TNotifyEvent;
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    { Public declarations }
    procedure ClearAll;
    procedure UpdateWindow;
    property GlobalsNameSpace: TBaseNameSpaceItem read FGlobalsNameSpace write FGlobalsNameSpace;
    property OnNotify: TNotifyEvent read FOnNotify write FOnNotify;
  end;

var
  VariablesWindow: TVariablesWindow = nil;

implementation

uses
  System.Math,
  System.SysUtils,
  Vcl.Forms,
  Vcl.Graphics,
  VirtualTrees.Types,
  JvGnugettext,
  StringResources,
  uEditAppIntfs,
  uCommonFunctions,
  dmResources,
  frmCallStack,
  cPyControl,
  cPySupportTypes,
  cPyScripterSettings;

{$R *.dfm}
Type
  PNodeData = ^TNodeData;
  TNodeData = record
    Name : string;
    ObjectType : string;
    Value : string;
    ImageIndex : Integer;
    NameSpaceItem : TBaseNameSpaceItem;
  end;

procedure TVariablesWindow.FormCreate(Sender: TObject);
begin
  ImageName := 'VariablesWin';
  inherited;
  // Let the tree know how much data space we need.
  VariablesTree.NodeDataSize := SizeOf(TNodeData);
end;

procedure TVariablesWindow.VariablesTreeInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  Data: PNodeData;
begin
  Data := Node.GetData;
  if Assigned(Data.NameSpaceItem) then
  begin
    var Py := GI_PyControl.SafePyEngine;
    ChildCount := Data.NameSpaceItem.ChildCount;
  end;
end;

procedure TVariablesWindow.VariablesTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data, ParentData: PNodeData;
begin
  Data := Node.GetData;
  if Assigned(ParentNode) then
    ParentData := ParentNode.GetData
  else
    ParentData := nil;

  if not VariablesTree.Enabled or
    ((ParentData <> nil) and (ParentData.NameSpaceItem = nil)) then
  begin
    Data.NameSpaceItem := nil;
    Exit;
  end;

  var Py := GI_PyControl.SafePyEngine;
  if ParentNode = nil then begin
    // Top level
    Assert(Node.Index <= 1);
    if CurrentModule <> '' then begin
      if Node.Index = 0 then begin
        Assert(Assigned(GlobalsNameSpace));
        Data.NameSpaceItem := GlobalsNameSpace;
        InitialStates := [ivsHasChildren];
      end else if Node.Index = 1 then begin
        Assert(Assigned(LocalsNameSpace));
        Data.NameSpaceItem := LocalsNameSpace;
        InitialStates := [ivsExpanded, ivsHasChildren];
      end;
    end else begin
      Assert(Node.Index = 0);
      Assert(Assigned(GlobalsNameSpace));
      Data.NameSpaceItem := GlobalsNameSpace;
      InitialStates := [ivsExpanded, ivsHasChildren];
    end;
  end else begin
    Data.NameSpaceItem := ParentData.NameSpaceItem.ChildNode[Node.Index];
    if Data.NameSpaceItem.ChildCount > 0 then
      InitialStates := [ivsHasChildren]
    else
      InitialStates := [];
  end;
  // Node Text
  Data.Name := Data.NameSpaceItem.Name;
  Data.ObjectType := Data.NameSpaceItem.ObjectType;
  if not (Data.NameSpaceItem.IsClass or Data.NameSpaceItem.IsFunction
    or Data.NameSpaceItem.IsModule or Data.NameSpaceItem.IsMethod
    or Data.NameSpaceItem.IsDict)
  then
    try
      Data.Value := Data.NameSpaceItem.Value;
    except
      Data.Value := '';
    end
  else
    Data.Value := '';
  // ImageIndex
  if Data.NameSpaceItem.IsDict then
    Data.ImageIndex := Ord(TCodeImages.Namespace)
  else if Data.NameSpaceItem.IsModule then
    Data.ImageIndex := Ord(TCodeImages.Module)
  else if Data.NameSpaceItem.IsMethod then
    Data.ImageIndex := Ord(TCodeImages.Method)
  else if Data.NameSpaceItem.IsFunction then
    Data.ImageIndex := Ord(TCodeImages.Func)
  else if Data.NameSpaceItem.IsClass or Data.NameSpaceItem.Has__dict__ then
     Data.ImageIndex := Ord(TCodeImages.Klass)
  else if (Data.ObjectType = 'list') or (Data.ObjectType = 'tuple') then
    Data.ImageIndex := Ord(TCodeImages.List)
  else begin
    if Assigned(ParentData) and
      (ParentData.NameSpaceItem.IsDict or ParentData.NameSpaceItem.IsModule)
    then
      Data.ImageIndex := Ord(TCodeImages.Variable)
    else
      Data.ImageIndex := Ord(TCodeImages.Field);
  end;
end;

procedure TVariablesWindow.VariablesTreePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data : PNodeData;
begin
  Data := Node.GetData;
  if VariablesTree.Enabled and Assigned(Data) and Assigned(Data.NameSpaceItem) then
    if nsaChanged in Data.NameSpaceItem.Attributes then
      TargetCanvas.Font.Color := clRed
    else if nsaNew in Data.NameSpaceItem.Attributes then
      TargetCanvas.Font.Color := $FF8844;
end;

procedure TVariablesWindow.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
Var
  TempWidth : integer;
begin
  TempWidth := PPIScale(AppStorage.ReadInteger(BasePath+'\DocPanelWidth', DocPanel.Width));
  DocPanel.Width := Min(TempWidth,  Max(Width-PPIScale(100), PPIScale(3)));
  if AppStorage.ReadBoolean(BasePath+'\Types Visible') then
    VariablesTree.Header.Columns[1].Options := VariablesTree.Header.Columns[1].Options + [coVisible]
  else
    VariablesTree.Header.Columns[1].Options := VariablesTree.Header.Columns[1].Options - [coVisible];
  VariablesTree.Header.Columns[0].Width :=
    PPIScale(AppStorage.ReadInteger(BasePath+'\Names Width', 160));
  VariablesTree.Header.Columns[1].Width :=
    PPIScale(AppStorage.ReadInteger(BasePath+'\Types Width', 100));
end;

procedure TVariablesWindow.reInfoResizeRequest(Sender: TObject; Rect: TRect);
begin
  Rect.Height := Max(Rect.Height, reInfo.Parent.ClientHeight);
  reInfo.BoundsRect := Rect;
end;

procedure TVariablesWindow.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteInteger(BasePath+'\DocPanelWidth', PPIUnScale(DocPanel.Width));
  AppStorage.WriteBoolean(BasePath+'\Types Visible', coVisible in VariablesTree.Header.Columns[1].Options);
  AppStorage.WriteInteger(BasePath+'\Names Width',
    PPIUnScale(VariablesTree.Header.Columns[0].Width));
  AppStorage.WriteInteger(BasePath+'\Types Width',
    PPIUnScale(VariablesTree.Header.Columns[1].Width));
end;

procedure TVariablesWindow.VariablesTreeGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  Data : PNodeData;
begin
  Data := Node.GetData;
  if Assigned(Data.NameSpaceItem) and (Column = 0) and (Kind in [ikNormal, ikSelected]) then begin
    ImageIndex := Data.ImageIndex;
  end else
    ImageIndex := -1;
end;

procedure TVariablesWindow.VariablesTreeGetCellText(
  Sender: TCustomVirtualStringTree; var E: TVSTGetCellTextEventArgs);
var
  Data : PNodeData;
begin
  Data := E.Node.GetData;
  if Assigned(Data) and Assigned(Data.NameSpaceItem) then
    case E.Column of
      0 : E.CellText := Data.Name;
      1 : E.CellText := Data.ObjectType;
      2 : E.CellText := Data.Value;
    end
  else
    E.CellText := 'NA';
end;

procedure TVariablesWindow.UpdateWindow;
Var
  CurrentFrame : TBaseFrameInfo;
  SameFrame : boolean;
  RootNodeCount : Cardinal;
  OldGlobalsNameSpace, OldLocalsNamespace : TBaseNameSpaceItem;
begin
  if ((PyControl.PythonEngineType = peSSH) and (PyIDEOptions.SSHDisableVariablesWin)) or
     not (GI_PyControl.PythonLoaded and
          Assigned(CallStackWindow) and
          Assigned(PyControl.ActiveInterpreter) and
          Assigned(PyControl.ActiveDebugger)) then
  begin
     ClearAll;
     Exit;
  end;

  if GI_PyControl.Running then begin
    // should not update
    VariablesTree.Enabled := False;
    Exit;
  end else
    VariablesTree.Enabled := True;

  var Py := GI_PyControl.SafePyEngine;

  // Get the selected frame
  CurrentFrame := CallStackWindow.GetSelectedStackFrame;

  SameFrame := (not Assigned(CurrentFrame) and
                (CurrentModule = '') and
                (CurrentFunction = '')) or
                (Assigned(CurrentFrame) and
                (CurrentModule = CurrentFrame.FileName) and
                (CurrentFunction = CurrentFrame.FunctionName));

  OldGlobalsNameSpace := GlobalsNameSpace;
  OldLocalsNamespace := LocalsNameSpace;
  GlobalsNameSpace := nil;
  LocalsNameSpace := nil;

  // Turn off Animation to speed things up
  VariablesTree.TreeOptions.AnimationOptions :=
    VariablesTree.TreeOptions.AnimationOptions - [toAnimatedToggle];

  if Assigned(CurrentFrame) then begin
    CurrentModule := CurrentFrame.FileName;
    CurrentFunction := CurrentFrame.FunctionName;
    // Set the initial number of nodes.
    GlobalsNameSpace := PyControl.ActiveDebugger.GetFrameGlobals(CurrentFrame);
    LocalsNameSpace := PyControl.ActiveDebugger.GetFrameLocals(CurrentFrame);
    if Assigned(GlobalsNameSpace) and Assigned(LocalsNameSpace) then
      RootNodeCount := 2
    else
      RootNodeCount := 0;
  end else begin
    CurrentModule := '';
    CurrentFunction := '';
    try
      GlobalsNameSpace := PyControl.ActiveInterpreter.GetGlobals;
      RootNodeCount := 1;
    except
      RootNodeCount := 0;
    end;
  end;

  if (RootNodeCount > 0) and SameFrame and (RootNodeCount = VariablesTree.RootNodeCount) then begin
    if Assigned(GlobalsNameSpace) and Assigned(OldGlobalsNameSpace) then
      GlobalsNameSpace.CompareToOldItem(OldGlobalsNameSpace);
    if Assigned(LocalsNameSpace) and Assigned(OldLocalsNameSpace) then
      LocalsNameSpace.CompareToOldItem(OldLocalsNameSpace);
    VariablesTree.BeginUpdate;
    try
      // The following will Reinitialize only initialized nodes
      // No need to initialize other nodes they will be initialized as needed
      VariablesTree.ReinitChildren(nil, True);
      VariablesTree.Invalidate;
    finally
      VariablesTree.EndUpdate;
    end;
  end else begin
    VariablesTree.Clear;
    VariablesTree.RootNodeCount := RootNodeCount;
  end;
  FreeAndNil(OldGlobalsNameSpace);
  FreeAndNil(OldLocalsNameSpace);

  VariablesTree.TreeOptions.AnimationOptions :=
    VariablesTree.TreeOptions.AnimationOptions + [toAnimatedToggle];
  VariablesTreeAddToSelection(VariablesTree, nil);
  if Assigned(FOnNotify) then
    FOnNotify(Self);
end;

procedure TVariablesWindow.ClearAll;
begin
  VariablesTree.Clear;
  if Assigned(GlobalsNameSpace) or Assigned(LocalsNameSpace) then
  begin
    var Py := GI_PyControl.SafePyEngine;
    FreeAndNil(GlobalsNameSpace);
    FreeAndNil(LocalsNameSpace);
  end;
end;

procedure TVariablesWindow.FormActivate(Sender: TObject);
begin
  inherited;
  if not VariablesTree.Enabled then VariablesTree.Clear;

  if CanActuallyFocus(VariablesTree) then
    VariablesTree.SetFocus;
  //PostMessage(VariablesTree.Handle, WM_SETFOCUS, 0, 0);
end;

procedure TVariablesWindow.FormDestroy(Sender: TObject);
begin
  VariablesWindow := nil;
  ClearAll;
  inherited;
end;

procedure TVariablesWindow.VariablesTreeAddToSelection(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
Var
  NameSpace,
  ObjectName,
  ObjectType,
  ObjectValue,
  DocString : string;
  Data : PNodeData;
begin
  if not Enabled then Exit;

  // Get the selected frame
  if CurrentModule <> '' then
    NameSpace := Format(_(SNamespaceFormat), [CurrentFunction, CurrentModule])
  else
    NameSpace := 'Interpreter globals';

  reInfo.Clear;
  AddFormatText(reInfo, _('Namespace') + ': ', [fsBold]);
  AddFormatText(reInfo, NameSpace, [fsItalic]);
  if Assigned(Node) then begin
    var Py := GI_PyControl.SafePyEngine;
    Data := Node.GetData;
    ObjectName := Data.Name;
    ObjectType := Data.ObjectType;
    ObjectValue := Data.Value;
    DocString :=  Data.NameSpaceItem.DocString;

    AddFormatText(reInfo, SLineBreak+_('Name')+': ', [fsBold]);
    AddFormatText(reInfo, ObjectName, [fsItalic]);
    AddFormatText(reInfo, SLineBreak + _('Type') + ': ', [fsBold]);
    AddFormatText(reInfo, ObjectType);
    if ObjectValue <> '' then begin
      AddFormatText(reInfo, SLineBreak + _('Value') + ':' + SLineBreak, [fsBold]);
      AddFormatText(reInfo, ObjectValue);
    end;
    AddFormatText(reInfo, SLineBreak + _('DocString') + ':' + SLineBreak, [fsBold]);
    AddFormatText(reInfo, Docstring);
  end;
end;

procedure TVariablesWindow.VariablesTreeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
Var
  Data : PNodeData;
begin
  Data := Node.GetData;
  Finalize(Data^);
end;

end.


