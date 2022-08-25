unit cFilePersist;
{-----------------------------------------------------------------------------
 Unit Name: cFilePersist
 Author:    Kiriakos Vlahos
 Date:      09-Mar-2006
 Purpose:   Support class for editor file persistence
 History:
-----------------------------------------------------------------------------}

interface
Uses
  System.Classes,
  System.SysUtils,
  System.Contnrs,
  Vcl.Controls,
  JvAppStorage,
  uEditAppIntfs,
  dlgSynEditOptions;

Type
  TBookMarkInfo = class(TPersistent)
  private
    fLine, fChar, fBookmarkNumber : integer;
  published
    property Line : integer read fLine write fLine;
    property Char : integer read fChar write fChar;
    property BookmarkNumber : integer read fBookmarkNumber write fBookmarkNumber;
  end;

  TFilePersistInfo = class (TInterfacedPersistent, IJvAppStorageHandler)
  //  For storage/loading of a file's persistent info
  private
    FileKind: TFileKind;
    TabControlIndex : integer;
    PInteractiveHeight: integer;  // UMLForm
    RememberedHeight: integer;    // UMLForm
    Line, Char, TopLine : integer;
    BreakPoints : TObjectList;
    BookMarks : TObjectList;
    FileName : string;
    Highlighter : string;
    UseCodeFolding: Boolean;
    EditorOptions : TSynEditorOptionsContainer;
    SecondEditorVisible : Boolean;
    SecondEditorAlign : TAlign;
    SecondEditorSize : integer;
    SecondEditorUseCodeFolding: Boolean;
    EditorOptions2 : TSynEditorOptionsContainer;
    ReadOnly : Boolean;
    FoldState : string;
    FoldState2 : string;
    GuiFormOpen: Boolean;
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string); virtual;
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string); virtual;
    function CreateListItem(Sender: TJvCustomAppStorage; const Path: string;
      Index: Integer): TPersistent;
  public
    constructor Create;
    constructor CreateFromEditor(Editor : IEditor);
    constructor CreateFromFile(aFile: IFile);
    destructor Destroy; override;
  end;

  TPersistFileInfo = class
  // Stores/loads open editor file information through the class methods
  // WriteToAppStorage and ReadFromAppStorage
  private
    fFileInfoList : TObjectList;
    function CreateListItem(Sender: TJvCustomAppStorage; const Path: string;
      Index: Integer): TPersistent;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetFileInfo;
    class procedure WriteToAppStorage(AppStorage : TJvCustomAppStorage; Path : string);
    class procedure ReadFromAppStorage(AppStorage : TJvCustomAppStorage; Path : string);
  end;

  TTabsPersistInfo = class (TInterfacedPersistent, IJvAppStorageHandler)
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string); virtual;
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string); virtual;
  end;

Var
  TabsPersistsInfo : TTabsPersistInfo;   // Singleton

implementation

uses
  System.Math,
  SynEditTypes,
  SynEdit,
  SpTBXTabs,
  TB2Item,
  JvJCLUtils,
  dmCommands,
  frmPyIDEMain,
  uHighlighterProcs,
  cPyBaseDebugger,
  cPyControl,
  cPyScripterSettings,
  UUMLForm,
  UUtils;

{ TFilePersistInfo }

constructor TFilePersistInfo.Create;
begin
  BreakPoints := TObjectList.Create(True);
  BookMarks := TObjectList.Create(True);
  EditorOptions := TSynEditorOptionsContainer.Create(nil);
  EditorOptions2 := TSynEditorOptionsContainer.Create(nil);
  SecondEditorAlign := alRight;
end;

procedure TFilePersistInfo.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
var
  IgnoreProperties : TStringList;
begin
   AppStorage.WriteString(BasePath+'\FileName', RemovePortableDrive(FileName));
   AppStorage.WriteInteger(BasePath+'\TabControlIndex', TabControlIndex);
   AppStorage.WriteInteger(BasePath+'\FileKind', Ord(FileKind));
   if FileKind = fkEditor then begin
     AppStorage.WriteInteger(BasePath+'\Line', Line);
     AppStorage.WriteInteger(BasePath+'\Char', Char);
     AppStorage.WriteInteger(BasePath+'\TopLine', TopLine);
     AppStorage.WriteString(BasePath+'\Highlighter', Highlighter);
     AppStorage.WriteObjectList(BasePath+'\BreakPoints', BreakPoints, 'BreakPoint');
     AppStorage.WriteObjectList(BasePath+'\BookMarks', BookMarks, 'BookMarks');
     AppStorage.WriteBoolean(BasePath+'\UseCodeFolding', UseCodeFolding);
     if UseCodeFolding then AppStorage.WriteString(BasePath+'\FoldState', FoldState);
     AppStorage.WriteBoolean(BasePath+'\ReadOnly', ReadOnly);
     AppStorage.WriteBoolean(BasePath+'\GUIFormOpen', GUIFormOpen);
     AppStorage.WriteBoolean(BasePath+'\SecondEditorVisible', SecondEditorVisible);
     IgnoreProperties := TStringList.Create;
     try
       IgnoreProperties.Add('Keystrokes');
       AppStorage.WritePersistent(BasePath+'\Editor Options', EditorOptions,
         True, IgnoreProperties);
       if SecondEditorVisible then begin
         AppStorage.WriteEnumeration(BasePath+'\Second Editor Align', TypeInfo(TAlign), SecondEditorAlign);
         AppStorage.WriteInteger(BasePath+'Second Editor Size', SecondEditorSize);
         AppStorage.WriteBoolean(BasePath+'\Second Editor UseCodeFolding', SecondEditorUseCodeFolding);
         if SecondEditorUseCodeFolding then
           AppStorage.WriteString(BasePath+'\Second Editor FoldState', FoldState2);
         AppStorage.WritePersistent(BasePath+'\Second Editor Options', EditorOptions2,
           True, IgnoreProperties);
       end;
     finally
       IgnoreProperties.Free;
     end;
   end;
   if FileKind = fkUML then begin
     AppStorage.WriteInteger(BasePath+'\PInteractiveHeight', PInteractiveHeight);
     AppStorage.WriteInteger(BasePath+'\RememberedHeight', RememberedHeight);
   end;
end;

procedure TFilePersistInfo.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
   FileName := AddPortableDrive(AppStorage.ReadString(BasePath+'\FileName'));
   TabControlIndex := AppStorage.ReadInteger(BasePath+'\TabControlIndex', 1);
   FileKind:= TFileKind(AppStorage.ReadInteger(BasePath+'\FileKind', 0));
   if FileKind = fkEditor then begin
     Line := AppStorage.ReadInteger(BasePath+'\Line');
     Char := AppStorage.ReadInteger(BasePath+'\Char');
     TopLine := AppStorage.ReadInteger(BasePath+'\TopLine');
     Highlighter := AppStorage.ReadString(BasePath+'\Highlighter', Highlighter);
     AppStorage.ReadObjectList(BasePath+'\BreakPoints', BreakPoints, CreateListItem, True, 'BreakPoint');
     AppStorage.ReadObjectList(BasePath+'\BookMarks', BookMarks, CreateListItem, True, 'BookMarks');
     UseCodeFolding := AppStorage.ReadBoolean(BasePath+'\UseCodeFolding', False);
     if UseCodeFolding then
       FoldState := AppStorage.ReadString(BasePath+'\FoldState', '');
     ReadOnly := AppStorage.ReadBoolean(BasePath+'\ReadOnly', False);
     GUIFormOpen:= AppStorage.ReadBoolean(BasePath+'\GUIFormOpen', False);

     EditorOptions.Assign(cPyScripterSettings.EditorOptions);
     AppStorage.ReadPersistent(BasePath+'\Editor Options', EditorOptions, True, True);

     SecondEditorVisible := AppStorage.ReadBoolean(BasePath+'\SecondEditorVisible', False);
     if SecondEditorVisible then begin
       AppStorage.ReadEnumeration(BasePath+'\Second Editor Align', TypeInfo(TAlign),
         SecondEditorAlign, SecondEditorAlign);
       SecondEditorSize := AppStorage.ReadInteger(BasePath+'Second Editor Size');
       SecondEditorUseCodeFolding := AppStorage.ReadBoolean(BasePath+'\Second Editor UseCodeFolding', False);
       if SecondEditorUseCodeFolding then
         FoldState2 := AppStorage.ReadString(BasePath+'\Second Editor FoldState', '');
       EditorOptions2.Assign(cPyScripterSettings.EditorOptions);
       AppStorage.ReadPersistent(BasePath+'\Second Editor Options', EditorOptions2, True, True);
     end;
   end;
   if FileKind = fkUML then begin
     PInteractiveHeight:= AppStorage.ReadInteger(BasePath+'\PInteractiveHeight');
     RememberedHeight:= AppStorage.ReadInteger(BasePath+'\RememberedHeight');
   end;
end;

destructor TFilePersistInfo.Destroy;
begin
  BreakPoints.Free;
  BookMarks.Free;
  EditorOptions.Free;
  EditorOptions2.Free;
  inherited;
end;

function TFilePersistInfo.CreateListItem(Sender: TJvCustomAppStorage;
  const Path: string; Index: Integer): TPersistent;
begin
  if Pos('BreakPoint', Path) > 0 then
    Result := TBreakPoint.Create
  else if Pos('BookMark', Path) > 0 then
    Result := TBookMarkInfo.Create
  else
    Result := nil;
end;

constructor TFilePersistInfo.CreateFromEditor(Editor: IEditor);

  procedure GetFoldInfo(SynEdit: TSynEdit; var UseCodeFolding: Boolean; var FoldState: string);
  Var
    Stream : TMemoryStream;
  begin
    UseCodeFolding := SynEdit.UseCodeFolding;
    if UseCodeFolding then begin
      Stream := TMemoryStream.Create;
      try
        SynEdit.AllFoldRanges.StoreCollapsedState(Stream);
        FoldState := BufToBinStr(Stream.Memory, Stream.Size);
      finally
        Stream.Free;
      end;
    end;
  end;

Var
  i : integer;
  BookMark : TBookMarkInfo;
  BreakPoint : TBreakPoint;
begin
  Create;
  FileKind:= fkEditor;
  FileName := Editor.FileId;
  TabControlIndex := Editor.TabControlIndex;
  Char := Editor.SynEdit.CaretX;
  Line := Editor.SynEdit.CaretY;
  TopLine := Editor.Synedit.TopLine;
  if Assigned(Editor.SynEdit.Highlighter) then
    Highlighter := Editor.SynEdit.Highlighter.FriendlyLanguageName;
  if Assigned(Editor.SynEdit.Marks) then
    for i := 0 to Editor.SynEdit.Marks.Count - 1 do
      if Editor.SynEdit.Marks[i].IsBookmark then with Editor.SynEdit.Marks[i] do
      begin
        BookMark := TBookMarkInfo.Create;
        BookMark.fChar := Char;
        BookMark.fLine := Line;
        BookMark.fBookmarkNumber := BookmarkNumber;
        BookMarks.Add(BookMark);
      end;
  for i := 0 to Editor.BreakPoints.Count - 1 do begin
    BreakPoint := TBreakPoint.Create;
    with TBreakPoint(Editor.BreakPoints[i]) do begin
      BreakPoint.LineNo := LineNo;
      BreakPoint.Disabled := Disabled;
      BreakPoint.Condition := Condition;
      BreakPoints.Add(BreakPoint);
    end;
  end;
  EditorOptions.Assign(Editor.SynEdit);
  GetFoldInfo(Editor.SynEdit, UseCodeFolding, FoldState);
  ReadOnly := Editor.ReadOnly;
  GUIFormOpen:= Editor.GUIFormOpen;

  SecondEditorVisible := Editor.SynEdit2.Visible;
  if SecondEditorVisible then begin
    SecondEditorAlign := Editor.SynEdit2.Align;
    SecondEditorSize := IfThen(SecondEditorAlign = alRight,
      Editor.SynEdit2.Width, Editor.SynEdit2.Height);
    EditorOptions2.Assign(Editor.SynEdit2);
    GetFoldInfo(Editor.SynEdit2, SecondEditorUseCodeFolding, FoldState2);
  end;
end;

constructor TFilePersistInfo.CreateFromFile(aFile: IFile);
begin
  Create;
  FileKind:= aFile.FileKind;
  if FileKind = fkUML then begin
    PInteractiveHeight:= (aFile.Form as TFUMLForm).PInteractive.Height;
    RememberedHeight:= (aFile.Form as TFUMLForm).RememberedHeight;
  end;
  if aFile.FileName <> '' then
    FileName := aFile.FileName
  else
    FileName := aFile.FileId;
  TabControlIndex := aFile.TabControlIndex;
end;

{ TPersistFileInfo }

constructor TPersistFileInfo.Create;
begin
  fFileInfoList := TObjectList.Create(True);
end;

class procedure TPersistFileInfo.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; Path : string);

  procedure RestoreFoldInfo(SynEdit: TSynEdit; UseCodeFolding: Boolean; FoldState: string);
  Var
    Stream: TMemoryStream;
  begin
    SynEdit.UseCodeFolding := UseCodeFolding;
    if UseCodeFolding and (FoldState <> '') then begin
      Stream := TMemoryStream.Create;
      try
        Stream.Size := FoldState.Length div 2;
        BinStrToBuf(FoldState, Stream.Memory, Stream.Size);
        Stream.Position := 0;
        SynEdit.AllFoldRanges.RestoreCollapsedState(Stream);
        SynEdit.Invalidate;
        SynEdit.InvalidateGutter;
      finally
        Stream.Free;
      end;
    end;
  end;

Var
  PersistFileInfo : TPersistFileInfo;
  FilePersistInfo : TFilePersistInfo;
  Editor : IEditor;
  aFile: IFile;
  i, j : integer;
  FName : string;
begin
  PersistFileInfo := TPersistFileInfo.Create;
  try
    AppStorage.ReadObjectList(Path, PersistFileInfo.fFileInfoList,
      PersistFileInfo.CreateListItem,  True, 'File');
    for i := 0 to PersistFileInfo.fFileInfoList.Count - 1 do begin
      FilePersistInfo := TFilePersistInfo(PersistFileInfo.fFileInfoList[i]);
      try
        aFile := PyIDEMainForm.DoOpenFile(FilePersistInfo.FileName, '',
          FilePersistInfo.TabControlIndex);
      except
        Continue; // to the next file
      end;
      if assigned(aFile) then begin
        if aFile.FileKind = fkEditor then begin
          Editor:= aFile as IEditor;
          Editor.SynEdit.TopLine := FilePersistInfo.TopLine;
          Editor.SynEdit.CaretXY := BufferCoord(FilePersistInfo.Char, FilePersistInfo.Line);
          for j := 0 to FilePersistInfo.BreakPoints.Count - 1 do
            with TBreakPoint(FilePersistInfo.BreakPoints[j]) do
              PyControl.SetBreakPoint(FilePersistInfo.FileName,
                LineNo, Disabled, Condition);
          for j := 0 to FilePersistInfo.BookMarks.Count - 1 do
            with TBookMarkInfo(FilePersistInfo.BookMarks[j]) do
              Editor.SynEdit.SetBookMark(BookMarkNumber, Char, Line);
          if FilePersistInfo.Highlighter <> '' then begin
            Editor.SynEdit.Highlighter := GetHighlighterFromLanguageName(
              FilePersistInfo.Highlighter, CommandsDataModule.Highlighters);
            Editor.SynEdit2.Highlighter := Editor.SynEdit.Highlighter;
          end;
          Editor.SynEdit.Assign(FilePersistInfo.EditorOptions);
          RestoreFoldInfo(Editor.SynEdit, FilePersistInfo.UseCodeFolding, FilePersistInfo.FoldState);
          Editor.ReadOnly := FilePersistInfo.ReadOnly;
          if FilePersistInfo.SecondEditorVisible then begin
            Editor.SynEdit2.Assign(FilePersistInfo.EditorOptions2);
            RestoreFoldInfo(Editor.SynEdit2, FilePersistInfo.SecondEditorUseCodeFolding,
              FilePersistInfo.FoldState2);

            Editor.SynEdit2.UseCodeFolding := FilePersistInfo.SecondEditorUseCodeFolding;

            if FilePersistInfo.SecondEditorAlign = alRight then begin
              Editor.SplitEditorVertrically;
              Editor.SynEdit2.Width := FilePersistInfo.SecondEditorSize;
            end else begin
              Editor.SplitEditorHorizontally;
              Editor.SynEdit2.Height := FilePersistInfo.SecondEditorSize;
            end;
          end;
          if FilePersistInfo.GUIFormOpen then
            PyIDEMainForm.DoOpenFile(ChangeFileExt(FilePersistInfo.FileName, '.pfm'), '',
              FilePersistInfo.TabControlIndex);
        end;
        if aFile.FileKind = fkUML then begin
          (aFile.Form as TFUMLForm).PInteractive.Height:= FilePersistInfo.PInteractiveHeight;
          (aFile.Form as TFUMLForm).RememberedHeight:= FilePersistInfo.RememberedHeight;
        end;
      end;
    end;
  finally
    PersistFileInfo.Free;
  end;
  FName := AppStorage.ReadString(Path+'\ActiveFile', FName);
  if FName <> '' then begin
    aFile := GI_FileFactory.GetFileByName(FName);
    if Assigned(aFile) then
      aFile.Activate;
  end;
end;

function TPersistFileInfo.CreateListItem(Sender: TJvCustomAppStorage;
  const Path: string; Index: Integer): TPersistent;
begin
  Result := TFilePersistInfo.Create;
end;

destructor TPersistFileInfo.Destroy;
begin
  fFileInfoList.Free;
  inherited;
end;

class procedure TPersistFileInfo.WriteToAppStorage(
  AppStorage: TJvCustomAppStorage; Path : string);
Var
  PersistFileInfo : TPersistFileInfo;
  ActiveFile : IFile;
  FName : string;
begin
  PersistFileInfo := TPersistFileInfo.Create;
  try
    PersistFileInfo.GetFileInfo;
    AppStorage.WriteObjectList(Path, PersistFileInfo.fFileInfoList, 'File');
  finally
    PersistFileInfo.Free;
  end;
  ActiveFile := GI_PyIDEServices.ActiveFile;
  if Assigned(ActiveFile) then
    FName := ActiveFile.FileName
  else
    FName := '';
  AppStorage.WriteString(Path+'\ActiveFile', FName);
end;

procedure TPersistFileInfo.GetFileInfo;

  procedure ProcessTabControl(TabControl : TSpTBXCustomTabControl);
  var
    I: Integer;
    IV: TTBItemViewer;
    Editor : IEditor;
    aFile : IFile;
    FilePersistInfo : TFilePersistInfo;
  begin
    // Note that the Pages property may have a different order than the
    // physical order of the tabs
    for I := 0 to TabControl.View.ViewerCount - 1 do begin
      IV := TabControl.View.Viewers[I];
      if IV.Item is TSpTBXTabItem then begin
        aFile := PyIDEMainForm.FileFromTab(TSpTBXTabItem(IV.Item));
        if Assigned(aFile) and ((aFile.FileName <> '') or (aFile.RemoteFileName <> '')) then begin
          if aFile.FileKind = fkEditor then begin
            Editor:= aFile as IEditor;
            FilePersistInfo := TFilePersistInfo.CreateFromEditor(Editor);
          end else
            FilePersistInfo := TFilePersistInfo.CreateFromFile(aFile);
          fFileInfoList.Add(FilePersistInfo);
          // We need to do it here before we call SaveEnvironement
          GI_PyIDEServices.MRUAddFile(aFile);
        end;
      end;
    end;
  end;
begin
  ProcessTabControl(PyIDEMainForm.TabControl1);
  ProcessTabControl(PyIDEMainForm.TabControl2);
end;

{ TTabsPersistInfo }

procedure TTabsPersistInfo.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
Var
  IsVisible : Boolean;
  Size : integer;
  Alignment : TAlign;
begin
  with PyIDEMainForm do begin
    IsVisible := AppStorage.ReadBoolean(BasePath+'\Visible', False);
    if IsVisible then begin
      Alignment := alRight;
      AppStorage.ReadEnumeration(BasePath+'\Align', TypeInfo(TAlign),
        Alignment, Alignment);
      Size := AppStorage.ReadInteger(BasePath+'\Size', -1);
      SplitWorkspace(True, Alignment, Size);
    end else
      SplitWorkspace(False);
  end;
end;

procedure TTabsPersistInfo.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteBoolean(BasePath+'\Visible', PyIDEMainForm.TabControl2.Visible);
  with PyIDEMainForm do if TabControl2.Visible then begin
    AppStorage.WriteEnumeration(BasePath+'\Align', TypeInfo(TAlign), TabControl2.Align);
    AppStorage.WriteInteger(BasePath+'\Size',
     IfThen(TabControl2.Align = alRight, TabControl2.Width, TabControl2.Height));
  end;
end;

initialization
  TabsPersistsInfo := TTabsPersistInfo.Create;
finalization
  FreeAndNil(TabsPersistsInfo);
end.
