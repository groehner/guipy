unit frmUnitTests;

interface

uses
  Winapi.Messages,
  System.UITypes,
  System.ImageList,
  System.Actions,
  System.Classes,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  SVGIconImageCollection,
  JvComponentBase,
  JvDockControlForm,
  VirtualTrees.Types,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.AncestorVCL,
  VirtualTrees.BaseTree,
  VirtualTrees,
  TB2Item,
  TB2Dock,
  TB2Toolbar,
  SpTBXDkPanels,
  SpTBXItem,
  SpTBXSkins,
  SynEdit,
  uEditAppIntfs,
  frmIDEDockWin;

type
  TUnitTestWindowStatus = (utwEmpty, utwLoaded, utwRunning, utwRun);

  TUnitTestWindow = class(TIDEDockWindow, IUnitTestsService)
    ExplorerDock: TSpTBXDock;
    ExplorerToolbar: TSpTBXToolbar;
    tbiRefresh: TSpTBXItem;
    TBXSeparatorItem1: TSpTBXSeparatorItem;
    tbiSelectFailed: TSpTBXItem;
    tbiDeselectAll: TSpTBXItem;
    tbiSelectAll: TSpTBXItem;
    TBXSeparatorItem2: TSpTBXSeparatorItem;
    tbiRun: TSpTBXItem;
    tbiStop: TSpTBXItem;
    tbiCollapseAll: TSpTBXItem;
    tbiExpandAll: TSpTBXItem;
    TBXSeparatorItem7: TSpTBXSeparatorItem;
    tbiClearAll: TSpTBXItem;
    SpTBXSplitter1: TSpTBXSplitter;
    DialogActions: TActionList;
    actClearAll: TAction;
    actCollapseAll: TAction;
    actExpandAll: TAction;
    actSelectFailed: TAction;
    actDeselectAll: TAction;
    actSelectAll: TAction;
    actStop: TAction;
    actRun: TAction;
    actRefresh: TAction;
    Panel1: TPanel;
    UnitTests: TVirtualStringTree;
    Panel2: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ModuleName: TLabel;
    lbFoundTests: TLabel;
    lblRunTests: TLabel;
    lblFailures: TLabel;
    SpTBXPanel1: TPanel;
    vilRunImages: TVirtualImageList;
    vilImages: TVirtualImageList;
    icRunImages: TSVGIconImageCollection;
    ErrorText: TSynEdit;
    procedure UnitTestsDblClick(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
    procedure actSelectFailedExecute(Sender: TObject);
    procedure UnitTestsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure actRunExecute(Sender: TObject);
    procedure UnitTestsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure actDeselectAllExecute(Sender: TObject);
    procedure actCollapseAllExecute(Sender: TObject);
    procedure actExpandAllExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure UnitTestsGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: string);
    procedure UnitTestsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure UnitTestsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure UnitTestsInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure UnitTestsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FTestClasses: TStringList;
    FTestSuite: Variant;
    FTestResult: Variant;
    FStatus: TUnitTestWindowStatus;
    FTestsRun: Integer;
    FTestsFailed: Integer;
    FTestErrors: Integer;
    FElapsedTime: Double;
    // IUnitTestServices implementaton
    procedure StartTest(Test: Variant);
    procedure StopTest(Test: Variant);
    procedure AddError(Test, Err: Variant);
    procedure AddFailure(Test, Err: Variant);
    procedure AddSuccess(Test: Variant);
    procedure ClearAll;
  protected
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
    procedure UpdateActions; override;
  public
    function SelectedTestCount: Integer;
    function FindTestNode(Test: Variant): PVirtualNode;
    class function CreateInstance: TIDEDockWindow; override;
  end;

var
  UnitTestWindow: TUnitTestWindow;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  System.StrUtils,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Themes,
  JvJVCLUtils,
  JvGnugettext,
  PythonEngine,
  VarPyth,
  StringResources,
  uPythonItfs,
  uCommonFunctions,
  cPySupportTypes;

{$R *.dfm}

{ Indexes of the color images used in the test tree and failure list }

type
  TTestStatus = (tsNotRun, tsRunning, tsRun, tsFailed, tsError);

  PNodeDataRec = ^TNodeDataRec;
  TNodeDataRec = record
  end;

const
  FoundTestsLabel = 'Found %d test%s';
  RunTestsLabel = 'Ran %d test%s%s';
  ElapsedTimeFormat = ' in %.3fs';
  FailuresLabel = 'Failures/Errors: %d/%d';
{ TUnitTestWindow }

procedure TUnitTestWindow.actRefreshExecute(Sender: TObject);
var
  Py: IPyEngineAndGIL;
  Index: Integer;
  Editor: IEditor;
  UnitTest, Module, InnerTestSuite,
  TestCase: Variant;
  ClassName, TestName: string;
  StringList: TStringList;
  Cursor: IInterface;
  PyTestCase: PPyObject;
  TestCount: Integer;
begin
  Py := SafePyEngine;
  ClearAll;
  Editor := GI_PyIDEServices.ActiveEditor;
  if Assigned(Editor) then begin
    Cursor := WaitCursor;

    ModuleName.Caption := 'Module: ' + Editor.FileTitle;
    ModuleName.Hint := Editor.FileName;

    Module := GI_PyControl.ActiveInterpreter.ImportModule(Editor);
    UnitTest := GI_PyControl.ActiveInterpreter.EvalCode('__import__("unittest")');
    FTestSuite := UnitTest.defaultTestLoader.loadTestsFromModule(Module);
    //  This FTestSuite contains a list of TestSuites
    //  each of which contains TestCases corresponding to
    //  a TestCase class in the module!!!
    TestCount := 0;
    for var I := 0 to len(FTestSuite._tests) - 1 do begin
      InnerTestSuite := FTestSuite._tests.__getitem__(I);
      for var J := 0 to len(InnerTestSuite._tests) - 1 do begin
        TestCase := InnerTestSuite._tests.__getitem__(J);
        //  set the TestStatus
        TestCase.testStatus := Ord(tsNotRun);
        TestCase.errMsg := '';
        TestCase.enabled := True;
        ClassName := GI_PyControl.ActiveInterpreter.GetObjectType(TestCase);
        Index := FTestClasses.IndexOf(ClassName);
        if Index < 0 then begin
          StringList := TStringList.Create;
          Index := FTestClasses.AddObject(ClassName, StringList);
        end;
        PyTestCase := ExtractPythonObjectFrom(TestCase); // Store the TestCase PPyObject
        Py.PythonEngine.Py_XINCREF(PyTestCase);
        TestName := TestCase._testMethodName;

        TStringList(FTestClasses.Objects[Index]).AddObject(TestName, TObject(PyTestCase));
        Inc(TestCount);
      end;
    end;

    if TestCount = 0 then begin
      StyledMessageDlg(_(SNoTestsFound), mtWarning, [mbOK], 0);
      ClearAll;
    end else begin
      UnitTests.RootNodeCount := FTestClasses.Count;
      UnitTests.ReinitNode(UnitTests.RootNode, True);
      lbFoundTests.Caption := Format(FoundTestsLabel, [TestCount, IfThen(TestCount=1, '', 's')]);
      FStatus := utwLoaded;
      actSelectAllExecute(Self);
    end;
  end;
  VarClear(UnitTest);
  VarClear(Module);
  VarClear(InnerTestSuite);
  VarClear(TestCase);
end;

procedure TUnitTestWindow.FormActivate(Sender: TObject);
begin
  inherited;
  if UnitTests.CanFocus then
    UnitTests.SetFocus;
end;

procedure TUnitTestWindow.FormCreate(Sender: TObject);
begin
  ImageName := 'UnitTestWin';
  inherited;
  UnitTests.NodeDataSize := SizeOf(TNodeDataRec);

  FTestClasses := TStringList.Create;
  FTestClasses.Sorted := True;
  FTestClasses.Duplicates := dupError;

  FStatus := utwEmpty;

  GI_UnitTestsService := Self;
end;

procedure TUnitTestWindow.FormDestroy(Sender: TObject);
begin
  GI_UnitTestsService := nil;
  ClearAll;
  FTestClasses.Free;
  inherited;
end;

procedure TUnitTestWindow.ClearAll;
var
  Py: IPyEngineAndGIL;
  StringList: TStringList;
  PyTestCase: PPyObject;
begin
  UnitTests.Clear;
  if (FTestClasses.Count > 0) or VarIsPython(FTestSuite) then
  begin
    Py := SafePyEngine;

    for var I := 0 to FTestClasses.Count - 1 do begin
      StringList := TStringList(FTestClasses.Objects[I]);
      for var J := 0 to StringList.Count - 1 do begin
        PyTestCase := PPyObject(StringList.Objects[J]);
        Py.PythonEngine.Py_XDECREF(PyTestCase);
      end;
      StringList.Free;
    end;
    FTestClasses.Clear;

    VarClear(FTestSuite);
  end;

  FTestsRun := 0;
  FTestsFailed := 0;
  FTestErrors := 0;
  FElapsedTime := 0;
  lblRunTests.Caption := Format(RunTestsLabel, [FTestsRun, IfThen(FTestsRun=1, '', 's'), '']);
  lblFailures.Caption := Format(FailuresLabel, [FTestsFailed, FTestErrors]);

  ModuleName.Caption := 'No Module Loaded';
  ModuleName.Hint := '';

  lbFoundTests.Caption := Format(FoundTestsLabel, [0, 's']);

  FStatus := utwEmpty;
end;

class function TUnitTestWindow.CreateInstance: TIDEDockWindow;
begin
  UnitTestWindow := TUnitTestWindow.Create(Application);
  Result := UnitTestWindow;
end;

procedure TUnitTestWindow.UnitTestsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  if ParentNode = nil then begin
    Node.CheckType := ctTriStateCheckBox;
    if TStringList(FTestClasses.Objects[Node.Index]).Count > 0 then
      InitialStates := [ivsHasChildren, ivsExpanded]
    else
      InitialStates := [];
  end else begin
    Node.CheckType := ctCheckBox;
    InitialStates := [];
  end;
end;

procedure TUnitTestWindow.UnitTestsInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
begin
  if UnitTests.GetNodeLevel(Node) = 0 then
    ChildCount := TStringList(FTestClasses.Objects[Node.Index]).Count
  else
    ChildCount := 0;
end;

procedure TUnitTestWindow.UnitTestsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  if TextType <> ttNormal then Exit;
  if UnitTests.GetNodeLevel(Node) = 0 then
    CellText := FTestClasses[Node.Index]
  else
    CellText := TStringList(FTestClasses.Objects[Node.Parent.Index])[Node.Index];
end;

procedure TUnitTestWindow.UnitTestsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  PyTestCase, PytestStatus: PPyObject;
begin
  if not (Kind in [ikNormal, ikSelected]) then Exit;
  if UnitTests.GetNodeLevel(Node) = 0 then begin
    if vsExpanded in Node.States then
      ImageIndex := 6
    else
      ImageIndex := 5;
  end else with SafePyEngine.PythonEngine do begin
    PyTestCase := PPyObject(TStringList(FTestClasses.Objects[Node.Parent.Index]).Objects[Node.Index]);
    PytestStatus := PyObject_GetAttrString(PyTestCase, 'testStatus');
    CheckError;
    ImageIndex := PyLong_AsLong(PytestStatus);
    Py_XDECREF(PytestStatus);
  end;
end;

procedure TUnitTestWindow.UnitTestsGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
var
  Py: IPyEngineAndGIL;
  PyTestCase: PPyObject;
  TestCase: Variant;
begin
  HintText := '';
  Py := SafePyEngine;
  if UnitTests.GetNodeLevel(Node) = 0 then begin
    if Assigned(Node.FirstChild) then begin
      PyTestCase := PPyObject(TStringList(FTestClasses.Objects[Node.Index]).Objects[0]);
      TestCase := VarPythonCreate(PyTestCase);
      if not VarIsNone(TestCase.__doc__) then
        HintText := FormatDocString(TestCase.__doc__);
    end;
  end else with Py.PythonEngine do begin
    PyTestCase := PPyObject(TStringList(FTestClasses.Objects[Node.Parent.Index]).Objects[Node.Index]);
    TestCase := VarPythonCreate(PyTestCase);
    if not VarIsNone(TestCase.shortDescription) then
      HintText := TestCase.shortDescription;
  end;
  VarClear(TestCase);
end;

procedure TUnitTestWindow.UnitTestsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if (UnitTests.GetNodeLevel(Node) = 1) and (vsInitialized in Node.States) then begin
    var Py := SafePyEngine;
    var PyTestCase := PPyObject(TStringList(FTestClasses.Objects[Node.Parent.Index]).Objects[Node.Index]);
    var TestCase: Variant := VarPythonCreate(PyTestCase);
    TestCase.enabled := Node.CheckState in [csCheckedNormal, csCheckedPressed];
    VarClear(TestCase);
  end;
end;

procedure TUnitTestWindow.actSelectAllExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
   Node := UnitTests.RootNode^.FirstChild;
   while Assigned(Node) do begin
     UnitTests.CheckState[Node] := csCheckedNormal;
     Node := Node.NextSibling;
   end;
end;

procedure TUnitTestWindow.actDeselectAllExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
   Node := UnitTests.RootNode^.FirstChild;
   while Assigned(Node) do begin
     UnitTests.CheckState[Node] := csUncheckedNormal;
     Node := Node.NextSibling;
   end;
end;

procedure TUnitTestWindow.actSelectFailedExecute(Sender: TObject);
var
 Py: IPyEngineAndGIL;
 ClassNode, TestCaseNode: PVirtualNode;
begin
  actDeselectAllExecute(Sender);

  Py := SafePyEngine;
  ClassNode := UnitTests.RootNode^.FirstChild;
  while Assigned(ClassNode) do begin
    TestCaseNode := ClassNode.FirstChild;
    while Assigned(TestCaseNode) do begin
      var PyTestCase :=
        PPyObject(TStringList(FTestClasses.Objects[TestCaseNode.Parent.Index]).Objects[TestCaseNode.Index]);
      var TestCase: Variant := VarPythonCreate(PyTestCase);
      if TTestStatus(TestCase.testStatus) in [tsFailed, tsError] then
         UnitTests.CheckState[TestCaseNode] := csCheckedNormal;
      TestCaseNode := TestCaseNode.NextSibling;
    end;
    ClassNode := ClassNode.NextSibling;
  end;
end;

procedure TUnitTestWindow.actExpandAllExecute(Sender: TObject);
begin
  UnitTests.FullExpand;
end;

procedure TUnitTestWindow.actCollapseAllExecute(Sender: TObject);
begin
  UnitTests.FullCollapse;
end;

procedure TUnitTestWindow.actRunExecute(Sender: TObject);
var
  Py: IPyEngineAndGIL;
  UnitTestModule, TempTestSuite: Variant;
  PyTestCase: PPyObject;
  TestCase: Variant;
  ClassNode, TestCaseNode: PVirtualNode;
  StartTime, StopTime, Freq: Int64;
begin
  // Only allow when PyControl.ActiveDebugger is inactive
  if not GI_PyControl.Inactive then Exit;

  Py := SafePyEngine;
  UnitTestModule := GI_PyControl.ActiveInterpreter.EvalCode('__import__("unittest")');

  //  Create a TempTestSuite that contains only the checked tests
  TempTestSuite := UnitTestModule.FTestSuite;

  ClassNode := UnitTests.RootNode^.FirstChild;
  while Assigned(ClassNode) do begin
    TestCaseNode := ClassNode.FirstChild;
    while Assigned(TestCaseNode) do begin
      PyTestCase :=
        PPyObject(TStringList(FTestClasses.Objects[TestCaseNode.Parent.Index]).Objects[TestCaseNode.Index]);
      TestCase := VarPythonCreate(PyTestCase);
      TestCase.testStatus := Ord(tsNotRun);
      TestCase.errMsg := '';
      if TestCase.enabled then
        TempTestSuite._tests.append(TestCase);
      TestCaseNode := TestCaseNode.NextSibling;
    end;
    ClassNode := ClassNode.NextSibling;
  end;

  FTestsRun := 0;
  FTestsFailed := 0;
  FTestErrors := 0;
  FElapsedTime := 0;
  lblRunTests.Caption := Format(RunTestsLabel, [FTestsRun, IfThen(FTestsRun=1, '', 's'), '']);
  lblFailures.Caption := Format(FailuresLabel, [FTestsFailed, FTestErrors]);

  FStatus := utwRunning;
  UpdateActions;
  GI_PyControl.DebuggerState := dsRunning;
  Application.ProcessMessages;

  FTestResult := GI_PyControl.ActiveInterpreter.UnitTestResult;
  try
    QueryPerformanceCounter(StartTime);
    TempTestSuite.run(FTestResult);
    QueryPerformanceCounter(StopTime);
  finally
    if QueryPerformanceFrequency(Freq) then
      FElapsedTime := (StopTime-StartTime) / Freq
    else
      FElapsedTime := 0;
    VarClear(FTestResult);
    VarClear(TempTestSuite);
    VarClear(UnitTestModule);
    VarClear(TestCase);
    FStatus := utwRun;
    GI_PyControl.DebuggerState := dsInactive;
    lblRunTests.Caption := Format(RunTestsLabel,
      [FTestsRun, IfThen(FTestsRun=1, '', 's'), Format(ElapsedTimeFormat, [FElapsedTime])]);
  end;
end;

procedure TUnitTestWindow.AddFailure(Test, Err: Variant);
// Called from IDETestResult
var
  TestCaseNode: PVirtualNode;
begin
  Test.testStatus := Ord(tsFailed);
  Test.errMsg := Err;
  TestCaseNode := FindTestNode(Test);
  if Assigned(TestCaseNode) then begin
    UnitTests.ScrollIntoView(TestCaseNode, True);
    UnitTests.Refresh;
  end;
  Inc(FTestsFailed);
  lblFailures.Caption := Format(FailuresLabel, [FTestsFailed, FTestErrors]);
  Application.ProcessMessages;
end;

procedure TUnitTestWindow.AddSuccess(Test: Variant);
// Called from IDETestResult
var
  TestCaseNode: PVirtualNode;
begin
  Test.testStatus := Ord(tsRun);
  TestCaseNode := FindTestNode(Test);
  if Assigned(TestCaseNode) then begin
    UnitTests.ScrollIntoView(TestCaseNode, True);
    UnitTests.Refresh;
  end;
  Application.ProcessMessages;
end;

procedure TUnitTestWindow.StopTest(Test: Variant);
// Called from IDETestResult
begin
  Inc(FTestsRun);
  lblRunTests.Caption := Format(RunTestsLabel, [FTestsRun, IfThen(FTestsRun=1, '', 's'), '']);
  Application.ProcessMessages;
end;

procedure TUnitTestWindow.StartTest(Test: Variant);
// Called from IDETestResult
var
  TestCaseNode: PVirtualNode;
begin
  Test.testStatus := Ord(tsRunning);
  TestCaseNode := FindTestNode(Test);
  if Assigned(TestCaseNode) then begin
    UnitTests.ScrollIntoView(TestCaseNode, True);
    UnitTests.Refresh;
    Application.ProcessMessages;
  end;
end;

procedure TUnitTestWindow.AddError(Test, Err: Variant);
// Called from IDETestResult
var
  TestCaseNode: PVirtualNode;
begin
  Test.testStatus := Ord(tsError);
  Test.errMsg := Err;
  TestCaseNode := FindTestNode(Test);
  if Assigned(TestCaseNode) then begin
    UnitTests.ScrollIntoView(TestCaseNode, True);
    UnitTests.Refresh;
  end;
  Inc(FTestErrors);
  lblFailures.Caption := Format(FailuresLabel, [FTestsFailed, FTestErrors]);
  Application.ProcessMessages;
end;

function TUnitTestWindow.FindTestNode(Test: Variant): PVirtualNode;
var
  PyTestCase: PPyObject;
  TestCase: Variant;
  ClassNode, TestCaseNode: PVirtualNode;
begin
  Result := nil;
  ClassNode := UnitTests.RootNode^.FirstChild;
  while Assigned(ClassNode) do begin
    TestCaseNode := ClassNode.FirstChild;
    while Assigned(TestCaseNode) do begin
      PyTestCase :=
        PPyObject(TStringList(FTestClasses.Objects[TestCaseNode.Parent.Index]).Objects[TestCaseNode.Index]);
      TestCase := VarPythonCreate(PyTestCase);
      if VarIsSame(Test, TestCase) then begin
        Result := TestCaseNode;
        Break;
      end;
      TestCaseNode := TestCaseNode.NextSibling;
    end;
    ClassNode := ClassNode.NextSibling;
  end;
end;

procedure TUnitTestWindow.UnitTestsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Py: IPyEngineAndGIL;
begin
  ErrorText.Clear;
  if Assigned(Node) and (vsSelected in Node.States) and
    (UnitTests.GetNodeLevel(Node) = 1) then
  begin
    Py := SafePyEngine;
    var PyTestCase := PPyObject(TStringList(FTestClasses.Objects[Node.Parent.Index]).Objects[Node.Index]);
    var TestCase: Variant := VarPythonCreate(PyTestCase);
    ErrorText.Text := TestCase.errMsg;
    VarClear(TestCase);
  end;
end;

procedure TUnitTestWindow.actClearAllExecute(Sender: TObject);
begin
  ClearAll;
end;

function TUnitTestWindow.SelectedTestCount: Integer;
var
  ClassNode, TestCaseNode: PVirtualNode;
begin
  Result := 0;
  ClassNode := UnitTests.RootNode^.FirstChild;
  while Assigned(ClassNode) do begin
    TestCaseNode := ClassNode.FirstChild;
    while Assigned(TestCaseNode) do begin
      if TestCaseNode.CheckState in [csCheckedNormal, csCheckedPressed] then
        Inc(Result);
      TestCaseNode := TestCaseNode.NextSibling;
    end;
    ClassNode := ClassNode.NextSibling;
  end;
end;

procedure TUnitTestWindow.UpdateActions;
var
  Count: Integer;
begin
  Count := SelectedTestCount;

  actRun.Enabled := (FStatus in [utwLoaded, utwRun]) and (Count > 0) and
    GI_PyControl.Inactive;

  actSelectAll.Enabled := FStatus in [utwLoaded, utwRun];
  actDeselectAll.Enabled := FStatus in [utwLoaded, utwRun];
  actSelectFailed.Enabled := FStatus = utwRun;

  actRefresh.Enabled := FStatus <> utwRunning;

  actExpandAll.Enabled := FStatus <> utwEmpty;
  actCollapseAll.Enabled := FStatus <> utwEmpty;

  actClearAll.Enabled := not (FStatus in [utwEmpty, utwRunning]);

  actStop.Enabled := FStatus = utwRunning;
  inherited;
end;

procedure TUnitTestWindow.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  icRunImages.SVGIconItems.BeginUpdate;
  try
    icRunImages.FixedColor := SvgFixedColor(clWindowText);
    icRunImages.AntiAliasColor := StyleServices.GetSystemColor(clWindow);
  finally
    icRunImages.SVGIconItems.EndUpdate;
  end;
  ErrorText.Font.Color := StyleServices.GetSystemColor(clWindowText);
  ErrorText.Color := StyleServices.GetSystemColor(clWindow);
end;

procedure TUnitTestWindow.actStopExecute(Sender: TObject);
begin
  if VarIsPython(FTestResult) then
    FTestResult.stop;
end;

procedure TUnitTestWindow.UnitTestsDblClick(Sender: TObject);
var
  Py: IPyEngineAndGIL;
  InspectModule: Variant;
  Node: PVirtualNode;
  PyTestCase: PPyObject;
  TestCase, PythonObject: Variant;
  FileName, TestName: string;
  NodeLevel, LineNo: Integer;
begin
  Node := UnitTests.HotNode;
  if Assigned(Node) then begin
    NodeLevel := UnitTests.GetNodeLevel(Node);
    if NodeLevel = 0 then
      Node := Node.FirstChild;
    if (NodeLevel > 1)  or not Assigned(Node) then Exit;

    Py := SafePyEngine;
    PyTestCase := PPyObject(TStringList(FTestClasses.Objects[Node.Parent.Index]).Objects[Node.Index]);
    TestCase := VarPythonCreate(PyTestCase);
    if NodeLevel = 0 then
      PythonObject := TestCase.__class__
    else
    begin
      TestName := TestCase._testMethodName;
      PythonObject := BuiltinModule.getattr(TestCase, TestName);
    end;
    if VarIsPython(PythonObject) then
    begin
      InspectModule := GI_PyControl.ActiveInterpreter.EvalCode('__import__("inspect")');
      if InspectModule.ismethod(PythonObject) then
      begin
        FileName := InspectModule.getsourcefile(PythonObject);
        if FileName = 'None' then
        begin
          FileName := PythonObject.__func__.__code__.co_filename;
          if ExtractFileExt(FileName) <> '' then
            Exit;
          // otherwise it should be an unsaved file
          LineNo := PythonObject.__func__.__code__.co_firstlineno-1;
        end else
          LineNo := InspectModule.findsource(PythonObject).__getitem__(1);
        GI_PyIDEServices.ShowFilePosition(FileName, Succ(LineNo), 1);
      end;
    end;
  end;
end;

initialization
  TIDEDockWindow.RegisterDockWinClass(ideUnitTests, TUnitTestWindow);

end.
