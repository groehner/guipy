{ ------------------------------------------------------------------------------
  Unit:     ULivingObjects
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  administration of created objects
-------------------------------------------------------------------------------}

unit ULivingObjects;

interface

uses
  Classes, Types, cPyControl, cPyBaseDebugger, ComCtrls;

type

  TLivingObjects = class
  private
    // from address to name
    // <__main__.Node object at 0x0306546DF9>=node1
    // <Auto.Auto object at 0x03770658>=auto1
    SLObjectsAddressName: TStringList;

    // path in the namespace
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
    function getRealAddressFromName(Name: String): String;
    function getPathFromName(Name: String): String;
    function getClassAttributes(const Classname: String): TStringList;
    function getClassMethods(const Classname: String): TStringList;
    function getClassnameOfObject(const Objectname: string): string;
    function getClassnameFromAddress(Address: string): string;
    procedure SimplifyPath(Objectname: String);

    procedure makeAllObjects;
    function getAllObjects: TStringList;
    procedure DeleteObjects;
  end;

implementation

uses
  Windows, Forms, SysUtils, Variants, JvJVCLUtils, SynEditKeyCmds, cInternalPython,
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
    PyControl.ActiveInterpreter.RunSource('import inspect', '<interactive input>');
  Py := GI_PyControl.SafePyEngine;
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
  Name: String;
begin
  Result := false;
  Py := GI_PyControl.SafePyEngine;
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
          SLObjectsAddressName.Add(VarToStr(NS.ChildNode[i].PyObject) + '=' + Objectname);
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
  Py := GI_PyControl.SafePyEngine;
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
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := GI_PyControl.SafePyEngine;
  NS := getNodeFromName(Objectname);
  if assigned(NS) then
    for i := 0 to NS.ChildCount - 1 do
      if isDunder(NS.ChildNode[i].Name) then
        break
      else if isAttribute(NS.ChildNode[i]) then
        SL.Add(NS.ChildNode[i].Name + '=' +
          getNameFromValue(VarToStr(NS.ChildNode[i].PyObject)) + '|' +
          NS.ChildNode[i].ObjectType);
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
  Py := GI_PyControl.SafePyEngine;
  NS := getNodeFromName(Objectname);
  for i := 0 to NS.ChildCount - 1 do
    if isDunder(NS.ChildNode[i].Name) then
      break
    else if isAttribute(NS.ChildNode[i]) then
      SL.Add(NS.ChildNode[i].Name + '=' + getNameFromValue
        (VarToStr(NS.ChildNode[i].PyObject)));
  Result := SL;
end;

function TLivingObjects.getObjectObjectMembers(const Objectname: string): TStringList;
var
  SL: TStringList;
  Py: IPyEngineAndGIL;
  NS: TBaseNameSpaceItem;

  procedure AddObjectsFromString(values: string);
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
      SL.Add(getNameFromValue(copy(values, pa, pe - pa +1)));
      values:= copy(values, pe + 1, length(values));
      p:= Pos('object at 0x', values);
    end;
  end;

  procedure AddObjectsFromDictNames(NS: TBaseNameSpaceItem);
  begin
    for var i:= 0 to NS.ChildCount - 1 do begin
      var s:= NS.ChildNode[i].Name;
      if (s[1] = '(') and (s[length(s)] = ')') then  // a tuple
        AddObjectsFromString(s)
      else if Pos('object at 0x', s) > 0 then       // a object
        SL.Add(getNameFromValue(s))
    end;
  end;

  procedure AddObjects(NS: TBaseNameSpaceItem);
  begin
    for var i:= 0 to NS.ChildCount - 1 do begin
      var OType:= NS.ChildNode[i].ObjectType;
      if (OType = 'list') or (OType = 'tuple') then
        AddObjects(NS.ChildNode[i])
      else if OType = 'dict' then begin
        AddObjectsFromDictNames(NS.ChildNode[i]);
        AddObjects(NS.ChildNode[i])
      end else if OType = 'set' then
        AddObjectsFromString(VarToStr(NS.ChildNode[i].PyObject))
      else if isObject(NS.ChildNode[i]) then
        SL.Add(getNameFromValue(VarToStr(NS.ChildNode[i].PyObject)))
      else if isDunder(NS.ChildNode[i].Name) then
        break;
    end;
  end;

begin
  SL := TStringList.Create;
  Py := GI_PyControl.SafePyEngine;
  NS := getNodeFromName(Objectname);
  if assigned(NS) then
    AddObjects(NS);
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
  else if copy(Value, 1, 1) = '<' then begin
    Classname := getClassnameFromAddress(Value);
    Objectname := getNewObjectName(Classname);
    if SLObjectsAddressName.IndexOfName(Value) = -1 then
      SLObjectsAddressName.Add(Value + '=' + Objectname);
    Result := Objectname;
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

function TLivingObjects.getAddressFromName(Name: String): String;
begin
  Result:= '';
  for var i:= 0 to SLObjectsAddressName.Count - 1 do
    if SLObjectsAddressName.ValueFromIndex[i] = Name then
      Exit(SLObjectsAddressName.KeyNames[i]);
end;

function TLivingObjects.getRealAddressFromName(Name: String): String;
begin
  var address:= getAddressFromName(Name);
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
  Result:= (Node.ObjectType <> 'method') and
           (Node.ObjectType <> 'method-wrapper');
end;

function TLivingObjects.getClassnameOfObject(const Objectname: string): string;
begin
  Result:= getClassnameFromAddress(getAddressFromName(Objectname));
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
  NS: TBaseNameSpaceItem;
begin
  SL := TStringList.Create;
  Py := GI_PyControl.SafePyEngine;
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
  Py := GI_PyControl.SafePyEngine;
  NS := getNodeFromPath(Classname);
  for i := 0 to NS.ChildCount - 1 do
    if (NS.ChildNode[i].ObjectType = 'method') or
       (NS.ChildNode[i].ObjectType = 'function') then
      SL.Add(NS.ChildNode[i].Name + Chr(3) + NS.ChildNode[i].ObjectType);
  Result := SL;
end;

function TLivingObjects.getClassnameFromAddress(Address: string): string;
  var p: integer;
begin
  // example: <__main__.Node object at 0x0306546DF9>
  p := Pos('.', Address);
  delete(Address, 1, p);
  p := Pos(' ', Address);
  Result := copy(Address, 1, p - 1);
end;

procedure TLivingObjects.makeAllObjects;
  var SLObjectsAddressNameDuplicat: TStringList;
      i: integer;

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
      var OType:= NS.ChildNode[i].ObjectType;
      if (OType = 'list') or (OType = 'tuple' ) then
        Add(Prefixname + '.' + NS.ChildNode[i].Name, NS.ChildNode[i])
      else if OType = 'dict' then
        AddObjectsFromDict(Prefixname, NS.ChildNode[i])
      else if OType = 'set' then
        AddObjectsFromString(Prefixname + '.' + NS.ChildNode[i].Name, VarToStr(NS.ChildNode[i].PyObject))
      else if isObject(NS.ChildNode[i]) then begin
        var Name:= getObjectName(VarToStr(NS.ChildNode[i].PyObject));
        if SLObjectsNamePath.IndexOfName(Name) = -1 then begin
          SLObjectsNamePath.Add(Name + '=' + Prefixname);
          Add(Prefixname + '.' + NS.ChildNode[i].Name, NS.ChildNode[i]);
        end;
      end else if isDunder(NS.ChildNode[i].Name) then
        break;
    end;
  end;

begin
  SLObjectsAddressNameDuplicat:= TStringList.Create; // remember names
  SLObjectsAddressNameDuplicat.Assign(SLObjectsAddressName);
  SLObjectsAddressName.Clear;
  SLObjectsNamePath.Clear;
  var Py := GI_PyControl.SafePyEngine;
  var NS := VariablesWindow.GlobalsNameSpace;
  // collect objects with direct access first
  for i:= 0 to NS.ChildCount -1 do
    if isObject(NS.ChildNode[i]) then begin
      SLObjectsAddressName.Add(VarToStr(NS.ChildNode[i].PyObject) + '=' + NS.ChildNode[i].Name);
      SLObjectsNamePath.Add(NS.ChildNode[i].Name + '=' + NS.ChildNode[i].Name);
    end else if isDunder(NS.ChildNode[i].Name) then
      break;

  // collect objects with indirect access second
  for i:= 0 to NS.ChildCount -1 do
    if isObject(NS.ChildNode[i]) then
      Add(NS.ChildNode[i].Name, NS.ChildNode[i])
    else if isDunder(NS.ChildNode[i].Name) then
      break;
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
