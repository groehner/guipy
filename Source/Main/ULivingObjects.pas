{ -------------------------------------------------------------------------------
  Unit:     ULivingObjects
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  administration of created objects
  ------------------------------------------------------------------------------- }

unit ULivingObjects;

interface

uses
  Classes, Types, cPyControl, cPyBaseDebugger, ComCtrls;

type

  TLivingObjects = class
  private
    // <__main__.Node object at 0x0306546DF9>=node1
    // <Auto.Auto object at 0x03770658>=auto1
    SLObjectsAddressName: TStringList;

    // node4=linkedlist.head.next.next.next
    // auto1=auto1
    SLObjectsNamePath: TStringList;

    function getNodeFromPath(Path: string): TBaseNameSpaceItem;
    function isObject(Node: TBaseNameSpaceItem): boolean;
    function isAttribute(Node: TBaseNameSpaceItem): boolean;
    function getNameFromValue(Value: String): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute(command: String);
    procedure ExecutePython(Source: string);
    function getSignature(from: String): String;
    function ObjectExists(Objectname: string): boolean;
    function ClassExists(Classname: string): boolean;
    function InsertObject(const Objectname: string): boolean;
    procedure DeleteObject(const Objectname: string);

    function getNewObjectName(aClassname: string): string;
    function getObjectMembers(const Objectname: string): TStringList;
    function getObjectObjectMembers(const Objectname: string): TStringList;
    function getObjectAttributeValues(const Objectname: string): TStringList;
    function getNodeFromName(const Objectname: String): TBaseNameSpaceItem;
    function getAddressFromName(Name: String): String;
    function getPathFromName(Name: String): String;
    function getClassAttributes(const Classname: String): TStringList;
    function getClassMethods(const Classname: String): TStringList;
    function getClassnameOfObject(const Objectname: string): string;
    function getClassnameFromAddress(Address: string): string;

    procedure makeAllObjects;
    function getAllObjects: TStringList;
    procedure DeleteObjects;
  end;

implementation

uses
  Windows, Forms, SysUtils, JvJVCLUtils, SynEditKeyCmds, cInternalPython,
  frmVariables, frmCallStack, frmPythonII, uEditAppIntfs, uCommonFunctions,
  UConfiguration, UUtils;

constructor TLivingObjects.Create;
begin
  SLObjectsAddressName := TStringList.Create;
  SLObjectsAddressName.Sorted := true;
  SLObjectsAddressName.Duplicates := dupIgnore;
  SLObjectsNamePath := TStringList.Create;
  SLObjectsNamePath.Sorted := true;
  SLObjectsNamePath.Duplicates := dupIgnore;
end;

destructor TLivingObjects.Destroy;
begin
  SLObjectsAddressName.Clear;
  FreeAndNil(SLObjectsAddressName);
  FreeAndNil(SLObjectsNamePath);
  inherited;
end;

procedure TLivingObjects.Execute(command: String);
var
  Buffer: TStringDynArray;
begin
  setLength(Buffer, 1);
  Buffer[0] := command;
  PythonIIForm.AppendToPrompt(Buffer);
  PythonIIForm.SynEdit.CommandProcessor(ecLineBreak, ' ', nil);
end;

procedure TLivingObjects.ExecutePython(Source: string);
var
  EncodedSource: AnsiString;
  ExecType: string;
begin
  if not GI_PyControl.PythonLoaded or GI_PyControl.Running then
  begin
    // it is dangerous to execute code while running scripts
    // so just beep and do nothing
    MessageBeep(MB_ICONERROR);
    Exit;
  end;
  ExecType := 'exec';

  if Pos(sLineBreak, Source) = 0 then
    ExecType := 'single'
  else
    Source := Source + sLineBreak;

  // Dedent the selection
  Source := Dedent(Source);

  GI_PyInterpreter.ShowWindow;
  GI_PyInterpreter.AppendText(sLineBreak);
  PythonIIForm.SynEdit.ExecuteCommand(ecEditorBottom, ' ', nil);
  Source := CleanEOLs(Source);
  EncodedSource := UTF8BOMString + Utf8Encode(Source);

  if ExecType = 'exec' then
    EncodedSource := EncodedSource + #10;
  // RunSource
  case PyControl.DebuggerState of
    dsInactive:
      PyControl.ActiveInterpreter.RunSource(Source, '<editor selection>',
        ExecType);
    dsPaused, dsPostMortem:
      PyControl.ActiveDebugger.RunSource(Source, '<editor selection>',
        ExecType);
  end;

  GI_PyInterpreter.WritePendingMessages;
  GI_PyInterpreter.AppendPrompt;
end;

function TLivingObjects.getSignature(from: String): String;
var
  Cursor: IInterface;
  Py: IPyEngineAndGIL;
  v: Variant;
  s: String;
  p: integer;
begin
  if not ClassExists('inspect') then
    PyControl.ActiveInterpreter.RunSource('import inspect',
      '<interactive input>');
  Py := SafePyEngine;
  Cursor := WaitCursor;
  Application.ProcessMessages;
  v := PyControl.ActiveInterpreter.EvalCode('inspect.signature(' + from + ')');
  s := v;
  delete(s, 1, 1);
  p := Pos(')', s);
  s[p] := ',';
  Result := s;
end;

function TLivingObjects.ObjectExists(Objectname: string): boolean;
begin
  Result := assigned(getNodeFromName(Objectname));
end;

function TLivingObjects.ClassExists(Classname: string): boolean;
begin
  Result := assigned(getNodeFromPath(Classname));
end;

function TLivingObjects.InsertObject(const Objectname: string): boolean;
var
  i, j: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
  Name, PyOb: String;
begin
  Result := false;
  Py := SafePyEngine;
  SL := Split('.', Objectname); // also find Class.SubClass
  NS := VariablesWindow.GlobalsNameSpace;
  for i := 0 to SL.Count - 1 do
  begin
    Name := SL[i];
    for j := 0 to NS.ChildCount - 1 do
      if NS.ChildNode[j].Name = Name then
      begin
        if i < SL.Count - 1 then
          NS := NS.ChildNode[j]
        else
        begin
          Result := true;
          PyOb:= NS.ChildNode[j].PyObject;
          SLObjectsAddressName.Add(PyOb + '=' + Objectname);
        end;
        break;
      end;
  end;
  FreeAndNil(SL);
end;

procedure TLivingObjects.DeleteObject(const Objectname: string);
begin
  for var i := 0 to SLObjectsAddressName.Count - 1 do
    if SLObjectsAddressName.ValueFromIndex[i] = Objectname then
    begin
      SLObjectsAddressName.delete(i);
      break;
    end;
  var
  i := SLObjectsNamePath.IndexOfName(Objectname);
  if i > -1 then
    SLObjectsNamePath.delete(i);
end;

function TLivingObjects.getNodeFromPath(Path: string): TBaseNameSpaceItem;
var
  i, j: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
  Name: string;
begin
  Result := nil;
  Py := SafePyEngine;
  SL := Split('.', Path); // also find Class.SubClass
  try
    NS := VariablesWindow.GlobalsNameSpace;
    if assigned(NS) then
      for i := 0 to SL.Count - 1 do
      begin
        Name := SL[i];
        for j := 0 to NS.ChildCount - 1 do
          if NS.ChildNode[j].Name = Name then
          begin
            NS := NS.ChildNode[j];
            if i = SL.Count - 1 then
              Exit(NS);
            break;
          end;
      end;
  finally
    FreeAndNil(SL);
  end;
end;

function TLivingObjects.getNewObjectName(aClassname: string): string;
var
  i, j, k, Nr: integer;
  s: string;
begin
  aClassname := getShortType(aClassname);
  if GuiPyOptions.ObjectLowerCaseLetter then
    aClassname := LowerCase(aClassname);
  Nr := 1;
  for i := 0 to SLObjectsAddressName.Count - 1 do
  begin
    s := SLObjectsAddressName.ValueFromIndex[i];
    j := length(s);
    // classnames can have digits too, example: Eval$5
    while (j > length(aClassname)) and CharInSet(s[j], ['0' .. '9']) do
      dec(j);
    if j < length(s) then
    begin
      k := StrToInt(copy(s, j + 1, length(s)));
      s := copy(s, 1, j);
      if (s = aClassname) and (Nr <= k) then
        Nr := k + 1;
    end;
  end;
  Result := aClassname + IntToStr(Nr);
end;

function TLivingObjects.getObjectMembers(const Objectname: string): TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromName(Objectname);
  if assigned(NS) then
    for i := 0 to NS.ChildCount - 1 do
      if isDunder(NS.ChildNode[i].Name) then
        break
      else if isAttribute(NS.ChildNode[i]) then
        SL.Add(NS.ChildNode[i].Name + '=' +
          getNameFromValue(NS.ChildNode[i].Value) + '|' + NS.ChildNode[i]
          .ObjectType);
  Result := SL;
end;

function TLivingObjects.getObjectAttributeValues(const Objectname: string)
  : TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromName(Objectname);
  for i := 0 to NS.ChildCount - 1 do
    if isDunder(NS.ChildNode[i].Name) then
      break
    else if isAttribute(NS.ChildNode[i]) then
      SL.Add(NS.ChildNode[i].Name + '=' + getNameFromValue
        (NS.ChildNode[i].Value));
  Result := SL;
end;

function TLivingObjects.getObjectObjectMembers(const Objectname: string)
  : TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromName(Objectname);
  if assigned(NS) then
    for i := 0 to NS.ChildCount - 1 do
      if isDunder(NS.ChildNode[i].Name) then
        break
      else if isObject(NS.ChildNode[i]) then
        SL.Add(NS.ChildNode[i].Name + '=' +
          getNameFromValue(NS.ChildNode[i].Value));
  Result := SL;
end;

function TLivingObjects.getNameFromValue(Value: string): string;
var
  i, p1, p2: integer;
  Classname, Objectname: String;
begin
  i := SLObjectsAddressName.IndexOfName(Value);
  if i > -1 then
    Result := SLObjectsAddressName.ValueFromIndex[i]
  else if copy(Value, 1, 1) = '<' then
  begin
    Classname := getClassnameFromAddress(Value);
    Objectname := getNewObjectName(Classname);
    if SLObjectsAddressName.IndexOfName(Value) = -1 then
      SLObjectsAddressName.Add(Value + '=' + Objectname);
    Result := Objectname;
  end
  else
  begin
    p1 := Pos('<', Value);
    p2 := Pos('>', Value);
    while (p1 > 0) and (p2 > p1) do
    begin
      Objectname := copy(Value, p1, p2 - p1 + 1);
      i := SLObjectsAddressName.IndexOfName(Objectname);
      if i > -1 then
      begin
        delete(Value, p1, p2 - p1 + 1);
        insert(SLObjectsAddressName.ValueFromIndex[i], Value, p1);
        p1 := Pos('<', Value);
        p2 := Pos('>', Value);
      end
      else
        p1 := 0;
    end;
    Result := Value;
  end;
end;

function TLivingObjects.getAddressFromName(Name: String): String;
var
  i: integer;
begin
  Result := '';
  i := 0;
  while i < SLObjectsAddressName.Count do
  begin
    if SLObjectsAddressName.ValueFromIndex[i] = Name then
    begin
      Result := SLObjectsAddressName.KeyNames[i];
      break;
    end;
    inc(i);
  end;
end;

function TLivingObjects.getPathFromName(Name: String): String;
var
  i: integer;
begin
  i := SLObjectsNamePath.IndexOfName(Name);
  if i > -1 then
    Result := SLObjectsNamePath.ValueFromIndex[i]
  else
    Result := '';
end;

function TLivingObjects.isObject(Node: TBaseNameSpaceItem): boolean;
begin
  if Node.isClass or Node.IsDict or Node.IsModule or Node.isFunction or Node.isMethod
  then
    Exit(false);

  Result := { (Node.ObjectType <> 'list') and
    (Node.ObjectType <> 'NoneType') and
    (Node.ObjectType <> 'str') and }
    (Pos('object at', Node.Value) > 0);
end;

function TLivingObjects.isAttribute(Node: TBaseNameSpaceItem): boolean;
begin
  Result := (Node.ObjectType <> 'method') and
    (Node.ObjectType <> 'method-wrapper');
end;

function TLivingObjects.getClassnameOfObject(const Objectname: string): string;
begin
  Result := getClassnameFromAddress(getAddressFromName(Objectname));
end;

function TLivingObjects.getNodeFromName(const Objectname: String)
  : TBaseNameSpaceItem;
begin
  Result := getNodeFromPath(getPathFromName(Objectname));
end;

function TLivingObjects.getClassAttributes(const Classname: String)
  : TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromPath(Classname);
  for i := 0 to NS.ChildCount - 1 do
    if isDunder(NS.ChildNode[i].Name) then
      break
    else if NS.ChildNode[i].ObjectType <> 'function' then
      SL.Add(NS.ChildNode[i].Name + '=' + NS.ChildNode[i].ObjectType);
  Result := SL;
end;

function TLivingObjects.getClassMethods(const Classname: String): TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromPath(Classname);
  for i := 0 to NS.ChildCount - 1 do
    if (NS.ChildNode[i].ObjectType = 'method') or
      (NS.ChildNode[i].ObjectType = 'function') then
      SL.Add(NS.ChildNode[i].Name + Chr(3) + NS.ChildNode[i].ObjectType);
  Result := SL;
end;

function TLivingObjects.getClassnameFromAddress(Address: string): string;
var
  p: integer;
begin
  // example: <__main__.Node object at 0x0306546DF9>
  p := Pos('.', Address);
  delete(Address, 1, p);
  p := Pos(' ', Address);
  Result := copy(Address, 1, p - 1);
end;

procedure TLivingObjects.makeAllObjects;
var
  i: integer;
  PyOb: String;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;

  procedure Add(Prefixname: string; NS: TBaseNameSpaceItem);
  var
    i: integer;
    Name, Path: String;
  begin
    i := 0;
    while (i < NS.ChildCount - 1) and not isDunder(NS.ChildNode[i].Name) do
    begin
      if isObject(NS.ChildNode[i]) then
      begin
        Name := getNameFromValue(NS.ChildNode[i].Value);
        Path := getPathFromName(Name);
        if Path = '' then
        begin // avoid cycles
          SLObjectsNamePath.Add(Name + '=' + Prefixname + '.' +
            NS.ChildNode[i].Name);
          Add(Prefixname + '.' + NS.ChildNode[i].Name, NS.ChildNode[i]);
        end;
      end;
      inc(i);
    end;
  end;

begin
  SLObjectsNamePath.Clear;
  Py := SafePyEngine;
  NS := VariablesWindow.GlobalsNameSpace;
  i := 0;
  // collect objects with direct access first
  while (i < NS.ChildCount - 1) and not isDunder(NS.ChildNode[i].Name) do
  begin
    if isObject(NS.ChildNode[i]) then
    begin
      PyOb := NS.ChildNode[i].PyObject;
      SLObjectsAddressName.Add(PyOb + '=' + NS.ChildNode[i].Name);
      SLObjectsNamePath.Add(NS.ChildNode[i].Name + '=' + NS.ChildNode[i].Name);
    end;
    inc(i);
  end;
  i := 0;
  // collect object with indirect access second
  while (i < NS.ChildCount - 1) and not isDunder(NS.ChildNode[i].Name) do
  begin
    if isObject(NS.ChildNode[i]) then
      Add(NS.ChildNode[i].Name, NS.ChildNode[i]);
    inc(i);
  end;
end;

function TLivingObjects.getAllObjects: TStringList;
begin
  Result := SLObjectsNamePath;
end;

procedure TLivingObjects.DeleteObjects;
begin
  SLObjectsAddressName.Clear;
  SLObjectsNamePath.Clear;
end;

end.
