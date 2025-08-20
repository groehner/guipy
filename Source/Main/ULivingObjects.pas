{ ------------------------------------------------------------------------------
  Unit:     ULivingObjects
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  administration of created objects
  ------------------------------------------------------------------------------- }

unit ULivingObjects;

interface

uses
  Classes,
  cPyBaseDebugger;

type

  TLivingObjects = class
  private
    // From Address to name
    // <__main__.Node object at 0x0306546DF9>=node1
    // <Auto.Auto object at 0x03770658>=auto1
    // <TurtleIntern Sprite(in 771 groups)>
    FSLObjectsAddressName: TStringList;
    FSLObjectsAddressNameDuplicat: TStringList;

    // path in the namespace
    // node4=linkedlist.head.next.next.next
    // auto1=auto1
    FSLObjectsNamePath: TStringList;

    function GetNodeFromPath(const Path: string): TBaseNameSpaceItem;
    function IsObject(Node: TBaseNameSpaceItem): Boolean;
    function IsAttribute(Node: TBaseNameSpaceItem): Boolean;
    function GetNameFromValue(Value: string; const Parentname: string;
      Node: TBaseNameSpaceItem = nil): string;
    procedure Add(const Prefixname: string; NameSpace: TBaseNameSpaceItem);
    function GetNameFromAddress(const Address: string): string;
    function GetObjectName(const AObject: string): string;
    function AddObject(const Prefixname, AObject: string): string;
    procedure AddObjectsFromString(const Prefixname: string; Values: string);
    procedure AddObjectsFromDictNames(const Prefixname: string;
      NameSpace: TBaseNameSpaceItem);
    procedure AddObjectsFromDict(const Prefixname: string;
      NameSpace: TBaseNameSpaceItem);
  public
    constructor Create;
    destructor Destroy; override;
    function ObjectExists(const Objectname: string): Boolean;
    function ClassExists(const Classname: string): Boolean;
    function InsertObject(const Objectname: string): Boolean;
    procedure DeleteObject(const Objectname: string);

    function GetNewObjectName(AClassname: string): string;
    function GetObjectMembers(const Objectname: string): TStringList;
    function GetObjectObjectMembers(const Objectname: string): TStringList;
    function GetObjectAttributeValues(const Objectname: string): TStringList;
    function GetNodeFromName(const Objectname: string): TBaseNameSpaceItem;
    function GetHexAddressFromName(const Name: string): string;
    function GetRealAddressFromName(const Name: string): string;
    function GetPathFromName(const Name: string): string;
    function GetClassAttributes(const Classname: string): TStringList;
    function GetClassMethods(const Classname: string): TStringList;
    function GetClassnameOfObject(const Objectname: string): string;
    function GetClassnameFromAddress(Address: string): string;
    procedure SimplifyPath(const Objectname: string);

    // access to python
    procedure Execute(const Command: string);
    procedure ExecutePython(Source: string);
    procedure LoadClassOfObject(const Objectname, Classname: string);
    function GetSignature(const From: string): string;
    function GetHexAddress(const From, Value: string): string;
    function GetMethods(const From: string): TStringList;
    function GetPathOf(const Classname: string): string;

    function GetAllObjects: TStringList;
    procedure MakeAllObjects;
    procedure DeleteObjects;
  end;

implementation

uses
  Windows,
  Forms,
  SysUtils,
  Variants,
  Types,
  SynEditKeyCmds,
  System.RegularExpressions,
  cPyControl,
  cPySupportTypes,
  PythonEngine,
  frmVariables,
  frmPythonII,
  uCommonFunctions,
  UConfiguration,
  UUtils;

constructor TLivingObjects.Create;
begin
  FSLObjectsAddressName := TStringList.Create;
  FSLObjectsAddressName.Sorted := True;
  FSLObjectsAddressName.Duplicates := dupIgnore;
  FSLObjectsNamePath := TStringList.Create;
  FSLObjectsNamePath.Sorted := True;
  FSLObjectsNamePath.Duplicates := dupIgnore;
end;

destructor TLivingObjects.Destroy;
begin
  FSLObjectsAddressName.Clear;
  FreeAndNil(FSLObjectsAddressName);
  FreeAndNil(FSLObjectsNamePath);
  inherited;
end;

procedure TLivingObjects.Execute(const Command: string);
var
  Buffer: TStringDynArray;
begin
  SetLength(Buffer, 1);
  Buffer[0] := Command;
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
  EncodedSource := UTF8BOMString + UTF8Encode(Source);

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

function TLivingObjects.GetSignature(const From: string): string;
var
  PyEngine: IPyEngineAndGIL;
  Vari: Variant;
begin
  if not ClassExists('inspect') then
    PyControl.ActiveInterpreter.RunSource('import inspect',
      '<interactive input>');
  PyEngine := SafePyEngine;
  Application.ProcessMessages;
  Vari := PyControl.ActiveInterpreter.EvalCode('inspect.signature(' +
    From + ')');
  Result := string(Vari);
end;

procedure TLivingObjects.LoadClassOfObject(const Objectname, Classname: string);
var
  PyEngine: IPyEngineAndGIL;
  Vari: Variant;
  Filepath: string;
begin
  PyEngine := SafePyEngine;
  Vari := PyControl.ActiveInterpreter.EvalCode(Objectname + '.__module__');
  Filepath := string(Vari);
  PyControl.ActiveInterpreter.RunSource('From ' + Filepath + ' import ' +
    Classname, '<interactive input>');
end;

function TLivingObjects.GetPathOf(const Classname: string): string;
var
  PyEngine: IPyEngineAndGIL;
  Vari: Variant;
  Path, Filename: string;
begin
  PyEngine := SafePyEngine;
  if not ClassExists('os') then
    PyControl.ActiveInterpreter.RunSource('import os', '<interactive input>');
  Vari := PyControl.ActiveInterpreter.EvalCode('os.path.abspath(os.curdir)');
  Path := string(Vari);
  Vari := PyControl.ActiveInterpreter.EvalCode(Classname + '.__module__');
  Filename := string(Vari);
  Result := Path + '\' + Filename + '.PyEngine';
end;

function TLivingObjects.GetHexAddress(const From, Value: string): string;
var
  PyEngine: IPyEngineAndGIL;
  Hex: Variant;
begin
  PyEngine := SafePyEngine;
  try
    Hex := PyControl.ActiveInterpreter.EvalCode('Hex(id(' + From + '))');
  except
    Hex := '';
  end;
  var
  Posi := Pos(' ', Value);
  if (Posi = -1) or (Hex = '') then
    Result := Value
  else
    Result := Copy(Value, 1, Posi) + 'object at ' + Hex + '>';
end;

function TLivingObjects.GetMethods(const From: string): TStringList;
var
  PyEngine: IPyEngineAndGIL;
  Vari: Variant;
  RegEx: TRegEx;
  Matches: TMatchCollection;
begin
  var
  StringList := TStringList.Create;
  if not ClassExists('inspect') then
    PyControl.ActiveInterpreter.RunSource('import inspect',
      '<interactive input>');
  PyEngine := SafePyEngine;
  Vari := PyControl.ActiveInterpreter.EvalCode('inspect.Getmembers(' + From +
    ', inspect.IsMethod)');
  RegEx := CompiledRegEx('''(\w+)''');
  Matches := RegEx.Matches(string(Vari));
  for var I := 0 to Matches.Count - 1 do
    StringList.Add(Matches[I].Groups[1].Value);
  Result := StringList;
end;

function TLivingObjects.ObjectExists(const Objectname: string): Boolean;
begin
  Result := Assigned(GetNodeFromName(Objectname));
end;

function TLivingObjects.ClassExists(const Classname: string): Boolean;
begin
  Result := Assigned(GetNodeFromPath(Classname));
end;

function TLivingObjects.InsertObject(const Objectname: string): Boolean;
var
  StringList: TStringList;
  PyEngine: IPyEngineAndGIL;
  NameSpace: TBaseNameSpaceItem;
  Name, Address: string;
begin
  Result := False;
  PyEngine := SafePyEngine;
  StringList := Split('.', Objectname); // also find Class.SubClass
  NameSpace := VariablesWindow.GlobalsNameSpace;
  for var I := 0 to StringList.Count - 1 do
  begin
    Name := StringList[I];
    for var J := 0 to NameSpace.ChildCount - 1 do
      if NameSpace.ChildNode[J].Name = Name then
      begin
        if I < StringList.Count - 1 then
          NameSpace := NameSpace.ChildNode[J]
        else
        begin
          Result := True;
          Address := VarToStr(NameSpace.ChildNode[J].PyObject);
          FSLObjectsAddressName.Add(Address + '=' + Objectname);
        end;
        Break;
      end;
  end;
  FreeAndNil(StringList);
end;

procedure TLivingObjects.DeleteObject(const Objectname: string);
begin
  for var I := 0 to FSLObjectsAddressName.Count - 1 do
    if FSLObjectsAddressName.ValueFromIndex[I] = Objectname then
    begin
      FSLObjectsAddressName.Delete(I);
      Break;
    end;
  var
  Int := FSLObjectsNamePath.IndexOfName(Objectname);
  if Int > -1 then
    FSLObjectsNamePath.Delete(Int);
end;

function TLivingObjects.GetNodeFromPath(const Path: string): TBaseNameSpaceItem;
var
  StringList: TStringList;
  PyEngine: IPyEngineAndGIL;
  NameSpace: TBaseNameSpaceItem;
  Name: string;
begin
  Result := nil;
  PyEngine := SafePyEngine;
  StringList := Split('.', Path); // also find Class.SubClass
  try
    NameSpace := VariablesWindow.GlobalsNameSpace;
    if Assigned(NameSpace) then
      for var I := 0 to StringList.Count - 1 do
      begin
        Name := StringList[I];
        for var J := 0 to NameSpace.ChildCount - 1 do
          if NameSpace.ChildNode[J].Name = Name then
          begin
            NameSpace := NameSpace.ChildNode[J];
            if I = StringList.Count - 1 then
              Exit(NameSpace);
            Break;
          end;
      end;
  finally
    FreeAndNil(StringList);
  end;
end;

function TLivingObjects.GetNewObjectName(AClassname: string): string;
var
  Len, KMax, Num: Integer;
  Str: string;
begin
  AClassname := GetShortType(AClassname);
  if GuiPyOptions.ObjectLowerCaseLetter then
    AClassname := LowerCase(AClassname);
  Num := 1;
  for var I := 0 to FSLObjectsAddressName.Count - 1 do
  begin
    Str := FSLObjectsAddressName.ValueFromIndex[I];
    Len := Length(Str);
    // classnames can have digits too, example: Eval$5
    while (Len > Length(AClassname)) and CharInSet(Str[Len], ['0' .. '9']) do
      Dec(Len);
    if Len < Length(Str) then
    begin
      KMax := StrToInt(Copy(Str, Len + 1, Length(Str)));
      Str := Copy(Str, 1, Len);
      if (Str = AClassname) and (Num <= KMax) then
        Num := KMax + 1;
    end;
  end;
  Result := AClassname + IntToStr(Num);
end;

function TLivingObjects.GetObjectMembers(const Objectname: string): TStringList;
var
  StringList: TStringList;
  PyEngine: IPyEngineAndGIL;
  NameSpace, NameSpaceItem: TBaseNameSpaceItem;
begin
  StringList := TStringList.Create;
  PyEngine := SafePyEngine;
  NameSpace := GetNodeFromName(Objectname);
  if Assigned(NameSpace) then
    for var I := 0 to NameSpace.ChildCount - 1 do
    begin
      NameSpaceItem := NameSpace.ChildNode[I];
      if IsDunder(NameSpaceItem.Name) then
        Break
      else if IsAttribute(NameSpaceItem) then
      begin
        var
        Str := VarToStr(NameSpaceItem.PyObject);
        Str := GetNameFromValue(Str, NameSpace.Name, NameSpaceItem);
        StringList.Add(NameSpaceItem.Name + '=' + Str + '|' +
          NameSpaceItem.ObjectType);
      end;
    end;
  Result := StringList;
end;

function TLivingObjects.GetObjectAttributeValues(const Objectname: string)
  : TStringList;
var
  StringList: TStringList;
  PyEngine: IPyEngineAndGIL;
  NameSpace, NameSpaceItem: TBaseNameSpaceItem;
begin
  StringList := TStringList.Create;
  PyEngine := SafePyEngine;
  NameSpace := GetNodeFromName(Objectname);
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    NameSpaceItem := NameSpace.ChildNode[I];
    if IsDunder(NameSpaceItem.Name) then
      Break
    else if IsAttribute(NameSpaceItem) then
    begin
      var
      Str := VarToStr(NameSpaceItem.PyObject);
      Str := GetNameFromValue(Str, NameSpace.Name, NameSpaceItem);
      StringList.Add(NameSpaceItem.Name + '=' + Str);
    end;
  end;
  Result := StringList;
end;

function TLivingObjects.GetObjectObjectMembers(const Objectname: string)
  : TStringList;
var
  StringList: TStringList;
  PyEngine: IPyEngineAndGIL;
  NameSpace: TBaseNameSpaceItem;

  procedure AddObjectsFromString(NameSpace: TBaseNameSpaceItem; Values: string);
  // set or dict names
  var
    Posi, PStart, PEnd: Integer;
  begin
    Posi := Pos('object at 0x', Values);
    while Posi > 0 do
    begin
      PStart := Posi - 1;
      while Values[PStart] <> '<' do
        Dec(PStart);
      PEnd := Posi + Length('object at 0x');
      while Values[PEnd] <> '>' do
        Inc(PEnd);
      StringList.Add(GetNameFromValue(Copy(Values, PStart, PEnd - PStart + 1),
        NameSpace.Name, NameSpace));
      Values := Copy(Values, PEnd + 1, Length(Values));
      Posi := Pos('object at 0x', Values);
    end;
  end;

  procedure AddObjectsFromDictNames(NameSpace: TBaseNameSpaceItem);
  var
    NameSpaceItem: TBaseNameSpaceItem;
  begin
    for var I := 0 to NameSpace.ChildCount - 1 do
    begin
      NameSpaceItem := NameSpace.ChildNode[I];
      var
      Str := NameSpaceItem.Name;
      if (Str[1] = '(') and (Str[Length(Str)] = ')') then // a tuple
        AddObjectsFromString(NameSpaceItem, Str)
      else if Pos('object at 0x', Str) > 0 then // a object
        StringList.Add(GetNameFromValue(Str, NameSpace.Name, NameSpaceItem));
    end;
  end;

  procedure AddObjects(NameSpace: TBaseNameSpaceItem);
  var
    Str: string;
    NameSpaceItem: TBaseNameSpaceItem;
  begin
    for var I := 0 to NameSpace.ChildCount - 1 do
    begin
      NameSpaceItem := NameSpace.ChildNode[I];
      var
      OType := NameSpaceItem.ObjectType;
      if (OType = 'list') or (OType = 'tuple') then
      begin
        AddObjects(NameSpaceItem);
        Continue;
      end;
      if OType = 'dict' then
      begin
        AddObjectsFromDictNames(NameSpaceItem);
        AddObjects(NameSpaceItem);
        Continue;
      end;
      if OType = 'set' then
      begin
        Str := VarToStr(NameSpaceItem.PyObject);
        AddObjectsFromString(NameSpaceItem, Str);
        Continue;
      end;
      if IsObject(NameSpaceItem) then
      begin
        Str := VarToStr(NameSpaceItem.PyObject);
        Str := GetNameFromValue(Str, NameSpace.Name, NameSpaceItem);
        StringList.Add(Str);
        Continue;
      end;
      if IsDunder(NameSpaceItem.Name) then
        Break;
    end;
  end;

begin
  StringList := TStringList.Create;
  PyEngine := SafePyEngine;
  NameSpace := GetNodeFromName(Objectname);
  if Assigned(NameSpace) then
    AddObjects(NameSpace);
  Result := StringList;
end;

function TLivingObjects.GetNameFromValue(Value: string; const Parentname: string;
  Node: TBaseNameSpaceItem): string;
var
  Int, Pos1, Pos2: Integer;
  Classname, Objectname: string;
begin
  if Pos('<', Value) = 0 then
    Exit(Value);
  Int := FSLObjectsAddressName.IndexOfName(Value);
  if Int > -1 then
    Exit(FSLObjectsAddressName.ValueFromIndex[Int]);
  if Copy(Value, 1, 1) = '<' then
  begin
    // for example: <TurtleIntern Sprite(in <xxx> groups)>
    Value := GetHexAddress(Parentname + '.' + Node.Name, Value);
    Int := FSLObjectsAddressName.IndexOfName(Value);
    if Int > -1 then
      Result := FSLObjectsAddressName.ValueFromIndex[Int]
    else
    begin
      Classname := GetClassnameFromAddress(Value);
      Result := GetNewObjectName(Classname);
      FSLObjectsAddressName.Add(Value + '=' + Result);
    end;
  end
  else
  begin
    Pos1 := Pos('<', Value);
    Pos2 := Pos('>', Value);
    while (Pos1 > 0) and (Pos2 > Pos1) do
    begin
      Objectname := Copy(Value, Pos1, Pos2 - Pos1 + 1);
      Int := FSLObjectsAddressName.IndexOfName(Objectname);
      if Int > -1 then
      begin
        Delete(Value, Pos1, Pos2 - Pos1 + 1);
        Insert(FSLObjectsAddressName.ValueFromIndex[Int], Value, Pos1);
        Pos1 := Pos('<', Value);
        Pos2 := Pos('>', Value);
      end
      else
        Pos1 := 0;
    end;
    Result := Value;
  end;
end;

function TLivingObjects.GetHexAddressFromName(const Name: string): string;
begin
  Result := '';
  for var I := 0 to FSLObjectsAddressName.Count - 1 do
    if FSLObjectsAddressName.ValueFromIndex[I] = Name then
      Exit(FSLObjectsAddressName.KeyNames[I]);
end;

function TLivingObjects.GetRealAddressFromName(const Name: string): string;
begin
  var
  Address := GetHexAddressFromName(Name);
  if Address <> '' then
  begin
    var
    Posi := Pos(' 0x', Address);
    Address := Copy(Address, Posi + 1, Length(Address) - Posi - 1);
  end;
  Result := Address;
end;

function TLivingObjects.GetPathFromName(const Name: string): string;
begin
  var
  I := FSLObjectsNamePath.IndexOfName(Name);
  if I > -1 then
    Result := FSLObjectsNamePath.ValueFromIndex[I]
  else
    Result := '';
end;

function TLivingObjects.IsObject(Node: TBaseNameSpaceItem): Boolean;
begin
  Result := False;
  if not(Node.IsClass or Node.IsModule or Node.IsFunction or Node.IsMethod) and
    (Pos('object at', Node.Value) > 0) then
    Result := (Node.ObjectType <> 'Window') and
      (Node.ObjectType <> 'QMetaObject') and
      (Node.ObjectType <> 'QApplication');
end;

function TLivingObjects.IsAttribute(Node: TBaseNameSpaceItem): Boolean;
begin
  Result := not Node.IsMethod;
end;

function TLivingObjects.GetClassnameOfObject(const Objectname: string): string;
begin
  Result := GetClassnameFromAddress(GetHexAddressFromName(Objectname));
end;

function TLivingObjects.GetNodeFromName(const Objectname: string)
  : TBaseNameSpaceItem;
begin
  Result := GetNodeFromPath(GetPathFromName(Objectname));
end;

function TLivingObjects.GetClassAttributes(const Classname: string)
  : TStringList;
var
  PyEngine: IPyEngineAndGIL;
  StringList: TStringList;
  NameSpace, NameSpaceItem: TBaseNameSpaceItem;
begin
  StringList := TStringList.Create;
  PyEngine := SafePyEngine;
  NameSpace := GetNodeFromPath(Classname);
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    NameSpaceItem := NameSpace.ChildNode[I];
    if IsDunder(NameSpaceItem.Name) then
      Break
    else if NameSpaceItem.ObjectType <> 'function' then
      StringList.Add(NameSpaceItem.Name + '=' + NameSpaceItem.ObjectType);
  end;
  Result := StringList;
end;

function TLivingObjects.GetClassMethods(const Classname: string): TStringList;
var
  StringList: TStringList;
  PyEngine: IPyEngineAndGIL;
  NameSpace, NameSpaceItem: TBaseNameSpaceItem;
begin
  StringList := TStringList.Create;
  PyEngine := SafePyEngine;
  NameSpace := GetNodeFromPath(Classname);
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    NameSpaceItem := NameSpace.ChildNode[I];
    if (NameSpaceItem.ObjectType = 'method') or
      (NameSpaceItem.ObjectType = 'function') then
      StringList.Add(NameSpaceItem.Name + Chr(3) + NameSpaceItem.ObjectType);
  end;
  Result := StringList;
end;

function TLivingObjects.GetClassnameFromAddress(Address: string): string;
var
  Posi: Integer;
begin
  // examples: <__main__.Node object at 0x0306546DF9>
  // '<TurtleIntern Sprite(in 37 groups)>'
  Posi := Pos('.', Address);
  Delete(Address, 1, Posi);
  Posi := Pos(' ', Address);
  Address := Copy(Address, 1, Posi - 1);
  if Copy(Address, 1, 1) = '<' then
    Delete(Address, 1, 1);
  Result := Address;
end;

function TLivingObjects.GetNameFromAddress(const Address: string): string;
var
  AClassname, Objectname, Str: string;
  StringList: TStringList;
  Len, Max, Num: Integer;
begin
  StringList := TStringList.Create;
  StringList.Assign(FSLObjectsAddressNameDuplicat);
  StringList.Text := StringList.Text + FSLObjectsAddressName.Text;
  AClassname := GetClassnameFromAddress(Address);
  AClassname := GetShortType(AClassname);
  if GuiPyOptions.ObjectLowerCaseLetter then
    AClassname := LowerCase(AClassname);
  Num := 1;
  for var I := 0 to StringList.Count - 1 do
  begin
    Str := StringList.ValueFromIndex[I];
    Len := Length(Str);
    // classnames can have digits too, example: Eval$5
    while (Len > Length(AClassname)) and CharInSet(Str[Len], ['0' .. '9']) do
      Dec(Len);
    if Len < Length(Str) then
    begin
      Max := StrToInt(Copy(Str, Len + 1, Length(Str)));
      Str := Copy(Str, 1, Len);
      if (Str = AClassname) and (Num <= Max) then
        Num := Max + 1;
    end;
  end;
  Objectname := AClassname + IntToStr(Num);
  if FSLObjectsAddressName.IndexOfName(Address) = -1 then
    FSLObjectsAddressName.Add(Address + '=' + Objectname);
  Result := Objectname;
  FreeAndNil(StringList);
end;

function TLivingObjects.GetObjectName(const AObject: string): string;
begin
  var
  Index := FSLObjectsAddressNameDuplicat.IndexOfName(AObject);
  if Index > -1 then
  begin
    Result := FSLObjectsAddressNameDuplicat.ValueFromIndex[Index];
    FSLObjectsAddressName.Add(AObject + '=' + Result);
  end
  else
  begin
    Index := FSLObjectsAddressName.IndexOfName(AObject);
    if Index > -1 then
      Result := FSLObjectsAddressName.ValueFromIndex[Index]
    else
      Result := GetNameFromAddress(AObject);
  end;
end;

function TLivingObjects.AddObject(const Prefixname, AObject: string): string;
begin
  Result := GetObjectName(AObject);
  if FSLObjectsNamePath.IndexOfName(Result) = -1 then
    FSLObjectsNamePath.Add(Result + '=' + Prefixname);
end;

procedure TLivingObjects.AddObjectsFromString(const Prefixname: string; Values: string);
// set or dict names
var
  Posi, PStart, PEnd: Integer;
begin
  Posi := Pos('object at 0x', Values);
  while Posi > 0 do
  begin
    PStart := Posi - 1;
    while Values[PStart] <> '<' do
      Dec(PStart);
    PEnd := Posi + Length('object at 0x');
    while Values[PEnd] <> '>' do
      Inc(PEnd);
    AddObject(Prefixname, Copy(Values, PStart, PEnd - PStart + 1));
    Values := Copy(Values, PEnd + 1, Length(Values));
    Posi := Pos('object at 0x', Values);
  end;
end;

procedure TLivingObjects.AddObjectsFromDictNames(const Prefixname: string;
  NameSpace: TBaseNameSpaceItem);
// dict names must be hashable, I.e. simple, tuple, object
begin
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    var
    Str := NameSpace.ChildNode[I].Name;
    if (Str[1] = '(') and (Str[Length(Str)] = ')') then // a tuple
      AddObjectsFromString(Prefixname, Str)
    else if Pos('object at 0x', Str) > 0 then // a object
      AddObject(Prefixname + Str, Str);
  end;
end;

procedure TLivingObjects.AddObjectsFromDict(const Prefixname: string;
  NameSpace: TBaseNameSpaceItem);
begin
  AddObjectsFromDictNames(Prefixname + '.' + NameSpace.Name, NameSpace);
  Add(Prefixname + '.' + NameSpace.Name, NameSpace);
end;

procedure TLivingObjects.Add(const Prefixname: string; NameSpace: TBaseNameSpaceItem);
var
  Str, Name, OType: string;
  NameSpaceItem: TBaseNameSpaceItem;

  procedure AddObject;
  begin
    Str := VarToStr(NameSpaceItem.PyObject);
    Name := GetObjectName(Str);
    if FSLObjectsNamePath.IndexOfName(Name) = -1 then
    begin
      FSLObjectsNamePath.Add(Name + '=' + Prefixname);
      Add(Prefixname + '.' + NameSpaceItem.Name, NameSpaceItem);
    end;
  end;

  procedure AddItem;
  begin
    OType := NameSpaceItem.ObjectType;
    if (OType = 'list') or (OType = 'tuple') then
      Add(Prefixname + '.' + NameSpaceItem.Name, NameSpaceItem)
    else if OType = 'dict' then
      AddObjectsFromDict(Prefixname, NameSpaceItem)
    else if OType = 'set' then
    begin
      Str := VarToStr(NameSpaceItem.PyObject);
      AddObjectsFromString(Prefixname + '.' + NameSpaceItem.Name, Str);
    end
    else if IsObject(NameSpaceItem) then
      AddObject
    else
    begin
      // object with modified string representation by __repr__
      // for example: <TurtleIntern Sprite(in 1039 groups)>
      Str := VarToStr(NameSpaceItem.PyObject);
      if Copy(Str, 1, 1) = '<' then
        Name := GetHexAddress(Prefixname + '.' + NameSpaceItem.Name, Str);
    end;
  end;

begin
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    NameSpaceItem := NameSpace.ChildNode[I];
    if IsDunder(NameSpaceItem.Name) then
      Break;
    if NameSpaceItem.IsMethod or NameSpaceItem.IsFunction or
      NameSpaceItem.IsClass or NameSpaceItem.IsModule then
      Continue;
    AddItem;
  end;
end;

procedure TLivingObjects.MakeAllObjects;
var
  PyEngine: IPyEngineAndGIL;
  Str: string;
  NameSpaceItem: TBaseNameSpaceItem;
begin
  FSLObjectsAddressNameDuplicat := TStringList.Create; // remember names
  FSLObjectsAddressNameDuplicat.Assign(FSLObjectsAddressName);
  FSLObjectsAddressName.Clear;
  FSLObjectsNamePath.Clear;
  PyEngine := SafePyEngine;
  var
  NameSpace := VariablesWindow.GlobalsNameSpace;
  if not Assigned(NameSpace) then
    Exit;

  // collect objects with direct access first
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    NameSpaceItem := NameSpace.ChildNode[I];
    if IsObject(NameSpaceItem) then
    begin
      Str := VarToStr(NameSpaceItem.PyObject);
      FSLObjectsAddressName.Add(Str + '=' + NameSpaceItem.Name);
      FSLObjectsNamePath.Add(NameSpaceItem.Name + '=' + NameSpaceItem.Name);
    end
    else if IsDunder(NameSpaceItem.Name) then
      Break;
  end;

  // collect objects with indirect access second
  for var I := 0 to NameSpace.ChildCount - 1 do
  begin
    NameSpaceItem := NameSpace.ChildNode[I];
    if IsObject(NameSpaceItem) then
      Add(NameSpaceItem.Name, NameSpaceItem)
    else if IsDunder(NameSpaceItem.Name) then
      Break;
  end;
  FreeAndNil(FSLObjectsAddressNameDuplicat);
end;

function TLivingObjects.GetAllObjects: TStringList;
begin
  Result := FSLObjectsNamePath;
end;

procedure TLivingObjects.DeleteObjects;
begin
  FSLObjectsAddressName.Clear;
  FSLObjectsNamePath.Clear;
end;

procedure TLivingObjects.SimplifyPath(const Objectname: string);
begin
  FSLObjectsNamePath.Sorted := False;
  if FSLObjectsNamePath.IndexOfName(Objectname) > -1 then
    FSLObjectsNamePath.Values[Objectname] := Objectname;
  FSLObjectsNamePath.Sorted := True;
end;

end.
