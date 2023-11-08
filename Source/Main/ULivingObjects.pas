{ ------------------------------------------------------------------------------
  Unit:     ULivingObjects
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  administration of created objects
-------------------------------------------------------------------------------}

unit ULivingObjects;

interface

uses
  Classes, cPyBaseDebugger;

type

  TLivingObjects = class
  private
    // from address to name
    // <__main__.Node object at 0x0306546DF9>=node1
    // <Auto.Auto object at 0x03770658>=auto1
    // <TurtleIntern Sprite(in 771 groups)>
    SLObjectsAddressName: TStringList;

    // path in the namespace
    // node4=linkedlist.head.next.next.next
    // auto1=auto1
    SLObjectsNamePath: TStringList;

    function getNodeFromPath(Path: string): TBaseNameSpaceItem;
    function isObject(Node: TBaseNameSpaceItem): boolean;
    function isAttribute(Node: TBaseNameSpaceItem): boolean;
    function getNameFromValue(Value: String; Node: TBaseNameSpaceItem = nil): string;
  public
    constructor Create;
    destructor Destroy; override;
    function ObjectExists(Objectname: string): boolean;
    function ClassExists(Classname: string): boolean;
    function InsertObject(const Objectname: string): boolean;
    procedure DeleteObject(const Objectname: string);

    function getNewObjectName(aClassname: string): string;
    function getObjectMembers(const Objectname: string): TStringList;
    function getObjectObjectMembers(const Objectname: string): TStringList;
    function getObjectAttributeValues(const Objectname: string): TStringList;
    function getNodeFromName(const Objectname: String): TBaseNameSpaceItem;
    function getHexAddressFromName(Name: String): String;
    function getRealAddressFromName(Name: String): String;
    function getPathFromName(Name: String): String;
    function getClassAttributes(const Classname: String): TStringList;
    function getClassMethods(const Classname: String): TStringList;
    function getClassnameOfObject(const Objectname: string): string;
    function getClassnameFromAddress(Address: string): string;
    procedure SimplifyPath(Objectname: String);

    // access to python
    procedure Execute(command: String);
    procedure ExecutePython(Source: string);
    procedure LoadClassOfObject(Objectname, aClassname: String);
    function getSignature(from: String): String;
    function getHexAddress(from, value: String): string;
    function getMethods(from: string): TStringList;
    function getPathOf(Classname: String): string;

    function getAllObjects: TStringList;
    procedure makeAllObjects;
    procedure DeleteObjects;
  end;

implementation

uses
  Windows, Forms, SysUtils, Variants, Types, StrUtils, JvJVCLUtils, SynEditKeyCmds,
  cPyControl, PythonEngine, frmVariables, frmPythonII, uEditAppIntfs, uCommonFunctions,
  System.RegularExpressions, UConfiguration, UUtils;

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
begin
  if not ClassExists('inspect') then
    PyControl.ActiveInterpreter.RunSource('import inspect', '<interactive input>');
  Py := SafePyEngine;
  Cursor := WaitCursor;
  Application.ProcessMessages;
  v := PyControl.ActiveInterpreter.EvalCode('inspect.signature(' + from + ')');
  Result := String(v);
end;

procedure TLivingObjects.LoadClassOfObject(Objectname, aClassname: String);
var
  Py: IPyEngineAndGIL;
  v: Variant;
  Filepath: string;
begin
  Py := SafePyEngine;
  v := PyControl.ActiveInterpreter.EvalCode(Objectname + '.__module__');
  Filepath:= String(v);
  PyControl.ActiveInterpreter.RunSource('from ' + Filepath + ' import ' + aClassname, '<interactive input>');
end;

function TLivingObjects.getPathOf(Classname: String): string;
var
  Py: IPyEngineAndGIL;
  v: Variant;
  Path, Filename: string;
begin
  Py:= SafePyEngine;
  if not ClassExists('os') then
    PyControl.ActiveInterpreter.RunSource('import os', '<interactive input>');
  v:= PyControl.ActiveInterpreter.EvalCode('os.path.abspath(os.curdir)');
  Path:= String(v);
  v:= PyControl.ActiveInterpreter.EvalCode(Classname + '.__module__');
  Filename:= String(v);
  Result:= Path + '\' + Filename + '.py';
end;

function TLivingObjects.getHexAddress(from, value: String): String;
begin
  var Py := SafePyEngine;
  var hex := PyControl.ActiveInterpreter.EvalCode('hex(id(' + from + '))');
  var p:= pos(' ', value);
  if p = -1
    then Result:= value
    else Result:= copy(value, 1, p) + 'object at ' + hex + '>';
end;

function TLivingObjects.getMethods(from: String): TStringList;
var
  Py: IPyEngineAndGIL; v: Variant;
  RegEx: TRegEx; Matches: TMatchCollection;
begin
  var SL:= TStringList.Create;
  if not ClassExists('inspect') then
    PyControl.ActiveInterpreter.RunSource('import inspect', '<interactive input>');
  Py := SafePyEngine;
  v := PyControl.ActiveInterpreter.EvalCode('inspect.getmembers(' + from + ', inspect.ismethod)');
  Regex:= CompiledRegEx('''(\w+)''');
  Matches:= RegEx.Matches(String(v));
  for var i:= 0 to Matches.count - 1 do
    SL.Add(Matches.Item[i].Groups[1].Value);
  Result := SL;
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
  Name, Address: String;
begin
  Result := false;
  Py := SafePyEngine;
  SL := Split('.', Objectname); // also find Class.SubClass
  NS := VariablesWindow.GlobalsNameSpace;
  for i := 0 to SL.Count - 1 do begin
    Name := SL[i];
    for j := 0 to NS.ChildCount - 1 do
      if NS.ChildNode[j].Name = Name then begin
        if i < SL.Count - 1 then
          NS := NS.ChildNode[j]
        else begin
          Result := true;
          Address:= VarToStr(NS.ChildNode[j].PyObject);
          SLObjectsAddressName.Add(Address + '=' + Objectname);
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
      for i := 0 to SL.Count - 1 do begin
        Name := SL[i];
        for j := 0 to NS.ChildCount - 1 do
          if NS.ChildNode[j].Name = Name then begin
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
  NS, NSi: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromName(Objectname);
  if assigned(NS) then
    for i := 0 to NS.ChildCount - 1 do begin
      NSi:= NS.ChildNode[i];
      if isDunder(NSi.Name) then
        break
      else if isAttribute(NSi) then begin
        var s:= VarToStr(NSi.PyObject);
        s:= getNameFromValue(s, NSi);
        SL.Add(NSi.Name + '=' + s + '|' + NSi.ObjectType);
      end;
    end;
  Result := SL;
end;

function TLivingObjects.getObjectAttributeValues(const Objectname: string)
  : TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS, NSi: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromName(Objectname);
  for i := 0 to NS.ChildCount - 1 do begin
    NSi:= NS.ChildNode[i];
    if isDunder(NSi.Name) then
      break
    else if isAttribute(NSi) then begin
      var s:= VarToStr(NSi.PyObject);
      s:= getNameFromValue(s, NSi);
      SL.Add(NSi.Name + '=' + s);
    end;
  end;
  Result := SL;
end;

function TLivingObjects.getObjectObjectMembers(const Objectname: string): TStringList;
var
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;

  procedure AddObjectsFromString(NS: TBaseNameSpaceItem; values: string);
    // set or dict names
    var p, pa, pe: integer;
  begin
    p:= Pos('object at 0x', values);
    while p > 0 do begin
      pa:= p - 1;
      while values[pa] <> '<' do
        dec(pa);
      pe:= p + length('object at 0x');
      while values[pe] <> '>' do
        inc(pe);
      SL.Add(getNameFromValue(copy(values, pa, pe - pa +1), NS));
      values:= copy(values, pe + 1, length(values));
      p:= Pos('object at 0x', values);
    end;
  end;

  procedure AddObjectsFromDictNames(NS: TBaseNameSpaceItem);
    var NSi: TBaseNameSpaceItem;
  begin
    for var i:= 0 to NS.ChildCount - 1 do begin
      NSi:= NS.ChildNode[i];
      var s:= NSi.Name;
      if (s[1] = '(') and (s[length(s)] = ')') then  // a tuple
        AddObjectsFromString(NSi, s)
      else if Pos('object at 0x', s) > 0 then       // a object
        SL.Add(getNameFromValue(s, NSi))
    end;
  end;

  procedure AddObjects(NS: TBaseNameSpaceItem);
    var s: String; NSi: TBaseNameSpaceItem;
  begin
    for var i:= 0 to NS.ChildCount - 1 do begin
      NSi:= NS.ChildNode[i];
      var OType:= NSi.ObjectType;
      if (OType = 'list') or (OType = 'tuple') then
        AddObjects(NSi)
      else if OType = 'dict' then begin
        AddObjectsFromDictNames(NSi);
        AddObjects(NSi)
      end else if OType = 'set' then begin
        s:= VarToStr(NSi.PyObject);
        AddObjectsFromString(NSi, s);
      end else if isObject(NSi) then begin
        s:= VarToStr(NSi.PyObject);
        s:= getNameFromValue(s, NSi);
        SL.Add(s);
      end else if isDunder(NSi.Name) then
        break;
    end;
  end;

begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromName(Objectname);
  if assigned(NS) then
    AddObjects(NS);
  Result := SL;
end;

function TLivingObjects.getNameFromValue(Value: string; Node: TBaseNameSpaceItem): string;
var
  i, p1, p2: integer;
  Classname, Objectname: String;
begin
  Result:= Value;
  i := SLObjectsAddressName.IndexOfName(Value);
  if i > -1 then
    Result := SLObjectsAddressName.ValueFromIndex[i]
  else if Pos('<', Value) > 0 then begin
    if copy(Value, 1, 1) = '<' then begin
      // for example: <TurtleIntern Sprite(in <xxx> groups)>
      Value:= getHexAddress(Node.Parent.Name + '.' + Node.Name, Value);
      i := SLObjectsAddressName.IndexOfName(Value);
      if i > -1 then
        Result := SLObjectsAddressName.ValueFromIndex[i]
      else begin
        Classname := getClassnameFromAddress(Value);
        Result := getNewObjectName(Classname);
        SLObjectsAddressName.Add(Value + '=' + Result);
      end;
    end else begin
      p1 := Pos('<', Value);
      p2 := Pos('>', Value);
      while (p1 > 0) and (p2 > p1) do begin
        Objectname := copy(Value, p1, p2 - p1 + 1);
        i := SLObjectsAddressName.IndexOfName(Objectname);
        if i > -1 then begin
          delete(Value, p1, p2 - p1 + 1);
          insert(SLObjectsAddressName.ValueFromIndex[i], Value, p1);
          p1 := Pos('<', Value);
          p2 := Pos('>', Value);
        end else
          p1 := 0;
      end;
      Result := Value;
    end;
  end;
end;

function TLivingObjects.getHexAddressFromName(Name: String): String;
begin
  Result:= '';
  for var i:= 0 to SLObjectsAddressName.Count - 1 do
    if SLObjectsAddressName.ValueFromIndex[i] = Name then
      Exit(SLObjectsAddressName.KeyNames[i]);
end;

function TLivingObjects.getRealAddressFromName(Name: String): String;
begin
  var address:= getHexAddressFromName(Name);
  if address <> '' then begin
    var p:= Pos(' 0x', address);
    address:= copy(address, p + 1, length(address) - p - 1);
  end;
  Result:= address;
end;

function TLivingObjects.getPathFromName(Name: String): String;
begin
  var i := SLObjectsNamePath.IndexOfName(Name);
  if i > -1 then
    Result := SLObjectsNamePath.ValueFromIndex[i]
  else
    Result := '';
end;

function TLivingObjects.isObject(Node: TBaseNameSpaceItem): boolean;
begin
  Result:= false;
  if not (Node.isClass or Node.IsModule or Node.isFunction or Node.isMethod) and
          (Pos('object at', Node.Value) > 0) then
    Result := (Node.ObjectType <> 'Window') and
              (Node.ObjectType <> 'QMetaObject') and
              (Node.ObjectType <> 'QApplication');
end;

function TLivingObjects.isAttribute(Node: TBaseNameSpaceItem): boolean;
begin
  Result:= not Node.IsMethod;
end;

function TLivingObjects.getClassnameOfObject(const Objectname: string): string;
begin
  Result:= getClassnameFromAddress(getHexAddressFromName(Objectname));
end;

function TLivingObjects.getNodeFromName(const Objectname: String): TBaseNameSpaceItem;
begin
  Result:= getNodeFromPath(getPathFromName(Objectname));
end;

function TLivingObjects.getClassAttributes(const Classname: String): TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS, NSi: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromPath(Classname);
  for i := 0 to NS.ChildCount - 1 do begin
    NSi:= NS.ChildNode[i];
    if isDunder(NSi.Name) then
      break
    else if NSi.ObjectType <> 'function' then
      SL.Add(NSi.Name + '=' + NSi.ObjectType);
  end;
  Result := SL;
end;

function TLivingObjects.getClassMethods(const Classname: String): TStringList;
var
  i: integer;
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS, NSi: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := SafePyEngine;
  NS := getNodeFromPath(Classname);
  for i := 0 to NS.ChildCount - 1 do begin
    NSi:= NS.ChildNode[i];
    if (NSi.ObjectType = 'method') or (NSi.ObjectType = 'function') then
      SL.Add(NSi.Name + Chr(3) + NSi.ObjectType);
  end;
  Result := SL;
end;

function TLivingObjects.getClassnameFromAddress(Address: string): string;
  var p: integer;
begin
  // examples: <__main__.Node object at 0x0306546DF9>
  // '<TurtleIntern Sprite(in 37 groups)>'
  p := Pos('.', Address);
  delete(Address, 1, p);
  p := Pos(' ', Address);
  Address:= copy(Address, 1, p - 1);
  if copy(Address, 1, 1) = '<' then
    delete(Address, 1, 1);
  Result:= Address;
end;

procedure TLivingObjects.makeAllObjects;
  var SLObjectsAddressNameDuplicat: TStringList;
      i: integer; s, Name: string;
      NSi: TBaseNameSpaceItem;

  procedure Add(Prefixname: string; NS: TBaseNameSpaceItem);

    function getNameFromAddress(Address: string): string;
      var aClassname, Objectname, s: string; SL: TStringList;
          i, j, k, Nr: integer;
    begin
      SL:= TStringList.Create;
      SL.Assign(SLObjectsAddressNameDuplicat);
      SL.Text:= SL.Text + SLObjectsAddressName.Text;
      aClassname := getClassnameFromAddress(Address);
      aClassname := getShortType(aClassname);
      if GuiPyOptions.ObjectLowerCaseLetter then
        aClassname := LowerCase(aClassname);
      Nr := 1;
      for i := 0 to SL.Count - 1 do begin
        s := SL.ValueFromIndex[i];
        j := length(s);
        // classnames can have digits too, example: Eval$5
        while (j > length(aClassname)) and CharInSet(s[j], ['0' .. '9']) do
          dec(j);
        if j < length(s) then begin
          k := StrToInt(copy(s, j + 1, length(s)));
          s := copy(s, 1, j);
          if (s = aClassname) and (Nr <= k) then
            Nr := k + 1;
        end;
      end;
      Objectname := aClassname + IntToStr(Nr);
      if SLObjectsAddressName.IndexOfName(Address) = -1 then
        SLObjectsAddressName.Add(Address + '=' + Objectname);
      Result := Objectname;
      FreeAndNil(SL);
    end;

    function getObjectName(aObject: string): string;
      var Name: string;
    begin
      var j := SLObjectsAddressNameDuplicat.IndexOfName(aObject);
      if j > -1 then begin
        Name:= SLObjectsAddressNameDuplicat.ValueFromIndex[j];
        SLObjectsAddressName.Add(aObject + '=' + Name);
      end else begin
        j := SLObjectsAddressName.IndexOfName(aObject);
        if j > -1
          then Name:= SLObjectsAddressName.ValueFromIndex[j]
          else Name:= getNameFromAddress(aObject);
      end;
      Result:= Name;
    end;

    function AddObject(Prefixname, aObject: string): string;
      var Name: string;
    begin
      Name:= getObjectName(aObject);
      if SLObjectsNamePath.IndexOfName(Name) = -1 then
        SLObjectsNamePath.Add(Name + '=' + Prefixname);
      Result:= Name;
    end;

    procedure AddObjectsFromString(Prefixname, values: string);
      // set or dict names
      var p, pa, pe: integer;
    begin
      p:= Pos('object at 0x', values);
      while p > 0 do begin
        pa:= p - 1;
        while values[pa] <> '<' do
          dec(pa);
        pe:= p + length('object at 0x');
        while values[pe] <> '>' do
          inc(pe);
        AddObject(Prefixname, copy(values, pa, pe - pa +1));
        values:= copy(values, pe + 1, length(values));
        p:= Pos('object at 0x', values);
      end;
    end;

    procedure AddObjectsFromDictNames(Prefixname: string; NS: TBaseNameSpaceItem);
      // dict names must be hashable, i.e. simple, tuple, object
    begin
      for var i:= 0 to NS.ChildCount - 1 do begin
        var s:= NS.ChildNode[i].Name;
        if (s[1] = '(') and (s[length(s)] = ')') then  // a tuple
          AddObjectsFromString(Prefixname, s)
        else if Pos('object at 0x', s) > 0 then       // a object
          AddObject(Prefixname + s, s);
      end;
    end;

    procedure AddObjectsFromDict(Prefixname: string; NS: TBaseNameSpaceItem);
    begin
      AddObjectsFromDictNames(Prefixname + '.' + NS.Name, NS);
      Add(Prefixname + '.' + NS.Name, NS)
    end;

  begin // off add()
    for var i:= 0 to NS.ChildCount - 1 do begin
      var NSi:= NS.ChildNode[i];
      if NSi.IsMethod or NSi.IsFunction or NSi.IsClass or NSi.IsModule then
        continue
      else if isDunder(NSi.Name) then
        break
      else begin
        var OType:= NSi.ObjectType;
        if (OType = 'list') or (OType = 'tuple' ) then
          Add(Prefixname + '.' + NSi.Name, NSi)
        else if OType = 'dict' then
          AddObjectsFromDict(Prefixname, NSi)
        else if OType = 'set' then begin
          var s:= VarToStr(NSi.PyObject);
          AddObjectsFromString(Prefixname + '.' + NSi.Name, s);
        end else if isObject(NSi) then begin
          s:= VarToStr(NSi.PyObject);
          Name:= getObjectName(s);
          if SLObjectsNamePath.IndexOfName(Name) = -1 then begin
            SLObjectsNamePath.Add(Name + '=' + Prefixname);
            Add(Prefixname + '.' + NSi.Name, NSi);
          end;
        end else begin
          // object with modified string representation by __repr__
          // for example: <TurtleIntern Sprite(in 1039 groups)>
          s:= VarToStr(NSi.PyObject);
          if copy(s, 1, 1) = '<' then begin
            Name:= getHexAddress(Prefixname + '.' + NSi.Name, s);
            //  if SLObjectsNamePath.IndexOfName(Name) = -1 then
            //    SLObjectsNamePath.Add(Name + '=' + Prefixname);
            //  Add(Prefixname + '.' + NSi.Name, NSi);
          end;
        end;
      end;
    end;
  end;

begin
  SLObjectsAddressNameDuplicat:= TStringList.Create; // remember names
  SLObjectsAddressNameDuplicat.Assign(SLObjectsAddressName);
  SLObjectsAddressName.Clear;
  SLObjectsNamePath.Clear;
  var Py := SafePyEngine;
  var NS := VariablesWindow.GlobalsNameSpace;
  // collect objects with direct access first
  for i:= 0 to NS.ChildCount -1 do begin
    NSi:= NS.ChildNode[i];
    if isObject(NSi) then begin
      s:= VarToStr(NSi.PyObject);
      SLObjectsAddressName.Add(s + '=' + NSi.Name);
      SLObjectsNamePath.Add(NSi.Name + '=' + NSi.Name);
    end else if isDunder(NSi.Name) then
      break;
  end;

  // collect objects with indirect access second
  for i:= 0 to NS.ChildCount -1 do begin
    NSi:= NS.ChildNode[i];
    if isObject(NSi) then
      Add(NSi.Name, NSi)
    else if isDunder(NSi.Name) then
      break;
  end;
  FreeAndNil(SLObjectsAddressNameDuplicat);
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

procedure TLivingObjects.SimplifyPath(Objectname: String);
begin
  SLObjectsNamePath.Sorted:= false;
  var i:= SLObjectsNamePath.IndexOfName(Objectname);
  if i > -1 then
    SLObjectsNamePath.Values[Objectname]:= Objectname;
  SLObjectsNamePath.Sorted:= true;

end;

end.
