{-----------------------------------------------------------------------------
 Unit Name: cProjectClasses
 Author:    Kiriakos Vlahos
 Date:      30-Nov-2007
 Purpose:   Data structures for PyScripter projects
 History:

 16-Jun-2008 Roman Krivoruchko
    Project property ExtraPythonPath added with persistence
-----------------------------------------------------------------------------}
unit cProjectClasses;

interface

uses
  System.Classes,
  System.Contnrs,
  JvAppStorage,
  cPySupportTypes;

type
  TAbstractProjectNode = class;
  TAbstractProjectNodeClass = class of TAbstractProjectNode;

  TProjectNodeAction = function (Node: TAbstractProjectNode; Data: Pointer): Boolean;

  TAbstractProjectNode = class(TInterfacedPersistent, IJvAppStorageHandler, IJvAppStoragePublishedProps)
  private
    FChildren: TObjectList;
    FParent: TAbstractProjectNode;
    FModified: Boolean;
    function GetRootNode: TAbstractProjectNode;
    function GetModified: Boolean;
    procedure SetModified(const Value: Boolean);
    procedure SetParent(const Value: TAbstractProjectNode);
  protected
    function GetCaption: string; virtual; abstract;
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string); virtual;
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string); virtual;
    function CreateListItem(Sender: TJvCustomAppStorage; const Path: string;
      Index: Integer): TPersistent;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ClearChildren;
    procedure AddChild(Child:TAbstractProjectNode);
    procedure RemoveChild(Child:TAbstractProjectNode);
    procedure ForEach(Proc: TProjectNodeAction; Data:Pointer = nil);
    function FirstThat(Proc: TProjectNodeAction; Data:Pointer = nil): TAbstractProjectNode;
    procedure SortChildren; virtual;

    property Parent: TAbstractProjectNode read FParent write SetParent;
    property Children: TObjectList read FChildren;
    property RootNode: TAbstractProjectNode read GetRootNode;
    property Modified: Boolean read GetModified write SetModified;
    property Caption: string read GetCaption;
  end;

  TProjectRootNode = class(TAbstractProjectNode)
  private
    FFileName: string;
    FStoreRelativePaths: Boolean;
    FShowFileExtensions: Boolean;
    FExtraPythonPath: TStrings;
    function GetName: string;
  protected
    function GetCaption: string; override;
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string); override;
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function HasFile(const FileName: string): Boolean;
    procedure AppendExtraPaths;
    procedure RemoveExtraPaths;
    property Name: string read GetName;
    property FileName: string read FFileName write FFileName;
  published
    property StoreRelativePaths: Boolean read FStoreRelativePaths write FStoreRelativePaths;
    property ShowFileExtensions: Boolean read FShowFileExtensions write FShowFileExtensions;
    property ExtraPythonPath: TStrings read FExtraPythonPath;
  end;

  TProjectFileNode = class;
  TProjectFolderNode = class;

  TProjectFilesNode = class(TAbstractProjectNode)
  private
    function GetFileChild(FileName: string): TProjectFileNode;
    function GetFolderChild(FolderName: string): TProjectFolderNode;
  {There should be only one FilesNode per project under the Project Root}
  protected
    function GetCaption: string; override;
  public
    procedure SortChildren; override;
    procedure ImportDirectory(const Directory, Masks: string; Recursive: Boolean);
    property  FileChild[FileName: string]: TProjectFileNode read GetFileChild;
    property  FolderChild[FolderName: string]: TProjectFolderNode read GetFolderChild;
  end;

  TProjectFolderNode = class(TProjectFilesNode)
  {Like ProjectFilesNode but with a name that can be changed}
  private
    FName: string;
  protected
    function GetCaption: string; override;
  published
    property Name: string read FName write FName;
  end;

  TProjectFileNode = class(TAbstractProjectNode)
  private
    FFileName: string;
    function GetName: string;
  protected
    function GetCaption: string; override;
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string); override;
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage;
      const BasePath: string); override;
  public
    property Name: string read GetName;
    property FileName: string read FFileName write FFileName;
  end;

  TProjectRunConfiguationsNode = class(TAbstractProjectNode)
  protected
    function GetCaption: string; override;
  end;

  TProjectRunConfiguationNode = class(TAbstractProjectNode)
  private
    FName: string;
    FRunConfig: TRunConfiguration;
    procedure SetRunConfig(const Value: TRunConfiguration);
  protected
    function GetCaption: string; override;
  published
    constructor Create; override;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property RunConfig: TRunConfiguration read FRunConfig write SetRunConfig;
  end;

var
  ActiveProject: TProjectRootNode;

implementation

uses
  System.Types,
  System.SysUtils,
  System.IOUtils,
  JvGnugettext,
  uCommonFunctions,
  cPyControl,
  uEditAppIntfs;

{ TAbstractProjectNode }

procedure TAbstractProjectNode.AddChild(Child: TAbstractProjectNode);
begin
  FChildren.Add(Child);
  Child.FParent := Self;
  if FChildren.Count > 1 then SortChildren;
  FModified := True;
end;

procedure TAbstractProjectNode.ClearChildren;
begin
  while FChildren.Count > 0 do
    FChildren.Last.Free;
end;

constructor TAbstractProjectNode.Create;
begin
  inherited;
  FChildren := TObjectList.Create(False);
end;

function TAbstractProjectNode.CreateListItem(Sender: TJvCustomAppStorage;
  const Path: string; Index: Integer): TPersistent;

  procedure RaiseError;
  begin
    raise Exception.Create('Error in reading project data');
  end;

var
  ClassName: string;
  NodeClass: TAbstractProjectNodeClass;
begin
  Result := nil;
  ClassName := Sender.ReadString(Path + '\ClassName');
  if ClassName = '' then
    RaiseError;
  try
    NodeClass := TAbstractProjectNodeClass(GetClass(ClassName));
    if not Assigned(NodeClass) then
      RaiseError;
    Result := NodeClass.Create;
  except
      RaiseError;
  end;
end;

destructor TAbstractProjectNode.Destroy;
begin
  SetParent(nil);
  ClearChildren;
  FChildren.Free;
  inherited;
end;

function TAbstractProjectNode.FirstThat(Proc: TProjectNodeAction;
  Data: Pointer): TAbstractProjectNode;
begin
  Result := nil;
  if Proc(Self, Data) then
    Result := Self
  else
    for var Child in FChildren do begin
      Result := TAbstractProjectNode(Child).FirstThat(Proc, Data);
      if Result <> nil then Exit;
    end;
end;

procedure TAbstractProjectNode.ForEach(Proc: TProjectNodeAction; Data: Pointer);
begin
  Proc(Self, Data);
  for var Child in FChildren do
    TAbstractProjectNode(Child).ForEach(Proc, Data);
end;

function CheckModified(Node: TAbstractProjectNode; Data: Pointer): Boolean;
begin
  Result := Node.FModified;
end;

function TAbstractProjectNode.GetModified: Boolean;
var
  Node: TAbstractProjectNode;
begin
  Result := FModified;
  if not Result then begin
    Node := FirstThat(CheckModified);
    Result := Assigned(Node);
  end;
end;

function TAbstractProjectNode.GetRootNode: TAbstractProjectNode;
begin
  if FParent = nil then
    Result := Self
  else
    Result := FParent.RootNode;
end;

procedure TAbstractProjectNode.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  if AppStorage.PathExists(BasePath+'\ChildNodes') then begin
    ClearChildren;
    AppStorage.ReadObjectList(BasePath+'\ChildNodes', FChildren, CreateListItem, True, 'Node');
    for var Child in FChildren do
      TAbstractProjectNode(Child).FParent := Self;
    if FChildren.Count > 1 then SortChildren;
  end;
end;

procedure TAbstractProjectNode.RemoveChild(Child: TAbstractProjectNode);
begin
  if Child = FChildren.Last then
    FChildren.Delete(FChildren.Count - 1)  //speed up when destroying
  else
    FChildren.Remove(Child);
  Child.FParent := nil;
  FModified := True;
end;

function ReSetModified(Node: TAbstractProjectNode; Data: Pointer): Boolean;
begin
  Node.FModified := False;
  Result := True;
end;

procedure TAbstractProjectNode.SetModified(const Value: Boolean);
begin
  FModified := Value;
  // Only apply to children if Modified is False
  if not Value then
    ForEach(ReSetModified);
end;

procedure TAbstractProjectNode.SetParent(const Value: TAbstractProjectNode);
begin
  if FParent <> Value then
  begin
    if  FParent <> nil then FParent.RemoveChild(Self);
    if Value <> nil then Value.AddChild(Self);
  end;
end;

procedure TAbstractProjectNode.SortChildren;
begin
  // Do nothing by default
end;

procedure TAbstractProjectNode.WriteToAppStorage(
  AppStorage: TJvCustomAppStorage; const BasePath: string);
begin
  AppStorage.WriteString(BasePath+'\ClassName', Self.ClassName);
  if FChildren.Count > 0 then
    AppStorage.WriteObjectList(BasePath+'\ChildNodes', FChildren, 'Node');
end;

{ TProjectRootNode }

procedure TProjectRootNode.AppendExtraPaths;
begin
  if not (Assigned(PyControl) and Assigned(PyControl.ActiveInterpreter)) then Exit;

  for var Path in FExtraPythonPath do
  begin
    PyControl.InternalInterpreter.SysPathAdd(Path);
    if PyControl.ActiveInterpreter <> PyControl.InternalInterpreter then
      PyControl.ActiveInterpreter.SysPathAdd(Path);
  end;
end;

constructor TProjectRootNode.Create;
begin
  inherited;
  AddChild(TProjectFilesNode.Create);
  AddChild(TProjectRunConfiguationsNode.Create);
  Modified := False;
  FExtraPythonPath := TStringList.Create;
  FStoreRelativePaths := True;
end;

destructor TProjectRootNode.Destroy;
begin
  RemoveExtraPaths;
  FreeAndNil(FExtraPythonPath);
  inherited;
end;

function TProjectRootNode.GetCaption: string;
begin
  Result := Name;
end;

function TProjectRootNode.GetName: string;
begin
  if FFileName <> '' then
    Result := TPath.GetFileNameWithoutExtension(FFileName)
  else
    Result := _('Untitled');
end;

function NodeHasFile(Node: TAbstractProjectNode; Data: Pointer): Boolean;
begin
  Result := False;
  if (Node is TProjectFileNode) and
     AnsiSameText(PWideChar(Data), TProjectFileNode(Node).FileName)
  then
    Result := True;
end;

function TProjectRootNode.HasFile(const FileName: string): Boolean;
begin
  Result := FirstThat(NodeHasFile, PWideChar(FileName)) <> nil;
end;

procedure TProjectRootNode.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  inherited;
  RemoveExtraPaths;
  FExtraPythonPath.Clear;
  AppStorage.ReadStringList(BasePath+'\ExtraPythonPath', FExtraPythonPath);
  AppendExtraPaths;
end;

procedure TProjectRootNode.RemoveExtraPaths;
begin
  if not (Assigned(PyControl) and Assigned(PyControl.ActiveInterpreter)) then Exit;

  for var Path in FExtraPythonPath do
  begin
    PyControl.InternalInterpreter.SysPathRemove(Path);
    if PyControl.ActiveInterpreter <> PyControl.InternalInterpreter then
      PyControl.ActiveInterpreter.SysPathRemove(Path);
  end;
end;

procedure TProjectRootNode.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  inherited;
  AppStorage.WriteStringList(BasePath+'\ExtraPythonPath', FExtraPythonPath);
end;

{ TProjectFolderNode }

function TProjectFolderNode.GetCaption: string;
begin
  Result := FName;
end;

{ TProjectFilesNode }

function TProjectFilesNode.GetCaption: string;
begin
  Result := _('Files');
end;

function CompareFolderChildren(P1, P2: Pointer): Integer;
var
  Node1, Node2: TAbstractProjectNode;
begin
  Result := 0;  // to keep compiler happy...
  Node1 := TAbstractProjectNode(P1);
  Node2 := TAbstractProjectNode(P2);
  if (Node1 is TProjectFolderNode) and (Node2 is TProjectFileNode) then
    Result := -1
  else if (Node1 is TProjectFileNode) and (Node2 is TProjectFolderNode) then
    Result := 1
  else if (Node1 is TProjectFolderNode) and (Node2 is TProjectFolderNode) then
    Result := AnsiCompareText(TProjectFolderNode(Node1).Name, TProjectFolderNode(Node2).Name)
  else if (Node1 is TProjectFileNode) and (Node2 is TProjectFileNode) then
    Result := AnsiCompareText(TProjectFileNode(Node1).Name, TProjectFileNode(Node2).Name)
  else
    Assert(False, 'Unexpected Child types in TProjectFilesNode');
end;

function TProjectFilesNode.GetFileChild(FileName: string): TProjectFileNode;
begin
  Result := nil;
  for var Child in FChildren do
    if (TObject(Child) is TProjectFileNode) and
       (AnsiCompareText(TProjectFileNode(Child).FFileName, FileName) = 0)
    then
       Exit(TProjectFileNode(Child));
end;

function TProjectFilesNode.GetFolderChild(FolderName: string): TProjectFolderNode;
begin
  Result := nil;
  for var Child in FChildren do
    if (TObject(Child) is TProjectFolderNode) and
      (AnsiCompareText(TProjectFolderNode(Child).FName, FolderName) = 0) then
       Exit(TProjectFolderNode(Child));
end;

procedure TProjectFilesNode.ImportDirectory(const Directory, Masks: string;
  Recursive: Boolean);
var
  FileList: TStringList;
  FileNode: TProjectFileNode;
  FolderNode: TProjectFolderNode;
  FolderName: string;
begin
  FolderName := TPath.GetFileName(Directory);
  if (FolderName = '.') or (FolderName = '..') then
    Exit;

  FolderNode := FolderChild[FolderName];
  if not Assigned(FolderNode) then begin
    FolderNode := TProjectFolderNode.Create;
    FolderNode.FName := FolderName;
    AddChild(FolderNode);
  end;

  FileList := TStringList.Create;
  try
    GetFilesInPaths(Directory, Masks, FileList, False);
    for var FileName in FileList do
    begin
      if not Assigned(FileChild[FileName]) then begin
        FileNode := TProjectFileNode.Create;
        FileNode.FFileName := FileName;
        FolderNode.AddChild(FileNode);
      end;
    end;

    if Recursive then begin
      FileList.Clear;
      GetDirectoriesInPaths(Directory, '*.*', FileList, False);
      for FolderName in FileList do
      begin
        if (FolderName = '.') or (FolderName = '..') then
          Continue;
        FolderNode.ImportDirectory(FolderName, Masks, Recursive);
      end;
    end;

  finally
    FileList.Free;
  end;

  if FolderNode.Children.Count = 0 then
    FolderNode.Free;  //Delete empty nodes
end;

procedure TProjectFilesNode.SortChildren;
begin
  FChildren.Sort(CompareFolderChildren);
end;

{ TProjectRunConfiguationsNode }

function TProjectRunConfiguationsNode.GetCaption: string;
begin
  Result := _('Run Configurations');
end;

{ TProjectFileNode }

function TProjectFileNode.GetCaption: string;
begin
  Result := Name;
end;

function TProjectFileNode.GetName: string;
begin
  if FFileName <> '' then  begin
    Result := TPath.GetFileName(GI_PyIDEServices.ReplaceParams(FFileName));
    if not ActiveProject.ShowFileExtensions then
      Result := TPath.GetFileNameWithoutExtension(Result);
  end else
    Result := _('Untitled');
end;

procedure TProjectFileNode.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  inherited;
  FileName := AppStorage.ReadString(BasePath + '\FileName');
end;

procedure TProjectFileNode.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
var
  BaseDir: string;
begin
  inherited;

  BaseDir := '';
  if ActiveProject.StoreRelativePaths then begin
    BaseDir := ExtractFilePath(ActiveProject.FFileName);

    if BaseDir <> '' then begin
      if Pos(BaseDir, FFileName) = 1 then begin
        Delete(FFileName, 1, Length(BaseDir));
        FFileName := '$[Project-Path]'+FFileName;
      end;
    end;
  end else
    FFileName := GI_PyIDEServices.ReplaceParams(FFileName);

  AppStorage.WriteString(BasePath + '\FileName', FFileName);
end;

{ TProjectRunConfiguationNode }

constructor TProjectRunConfiguationNode.Create;
begin
  inherited;
  FRunConfig := TRunConfiguration.Create;
end;

destructor TProjectRunConfiguationNode.Destroy;
begin
  FRunConfig.Free;
  inherited;
end;

function TProjectRunConfiguationNode.GetCaption: string;
begin
  Result := Name;
end;

procedure TProjectRunConfiguationNode.SetRunConfig(const Value: TRunConfiguration);
begin
  FRunConfig.Assign(Value);
end;

initialization
  RegisterClasses([TProjectRootNode, TProjectFolderNode, TProjectFilesNode,
                   TProjectFileNode, TProjectRunConfiguationsNode, TProjectRunConfiguationNode]);
  ActiveProject := TProjectRootNode.Create;
finalization
  FreeAndNil(ActiveProject);
end.
