{-----------------------------------------------------------------------------
 Unit Name: cFilePersist
 Author:    Kiriakos Vlahos, Gerhard Röhner
 Date:      09-Mar-2006
 Purpose:   Support class for editor file persistence
 History:
-----------------------------------------------------------------------------}

unit cFilePersist;

interface
uses
  System.Classes,
  System.Contnrs,
  Vcl.Controls,
  JvAppStorage,
  uEditAppIntfs,
  dlgSynEditOptions;

type
  TBookMarkInfo = class(TPersistent)
  private
    FLine, FChar, FBookmarkNumber: Integer;
  published
    property Line: Integer read FLine write FLine;
    property Char: Integer read FChar write FChar;
    property BookmarkNumber: Integer read FBookmarkNumber write FBookmarkNumber;
  end;

  TFilePersistInfo = class (TInterfacedPersistent, IJvAppStorageHandler)
  //  For storage/loading of a file's persistent info
  private
    FileKind: TFileKind;
    TabControlIndex : Integer;
    Line, Char, TopLine : Integer;
    BreakPoints : TObjectList;
    BookMarks : TObjectList;
    FileName : string;
    Highlighter : string;
    UseCodeFolding: Boolean;
    EditorOptions : TSynEditorOptionsContainer;
    EditorOptions2 : TSynEditorOptionsContainer;
    SecondEditorVisible : Boolean;
    SecondEditorAlign : TAlign;
    SecondEditorSize : Integer;
    SecondEditorUseCodeFolding: Boolean;
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
  // Stores/loads open file information through the class methods
  // WriteToAppStorage and ReadFromAppStorage
  private
    FFileInfoList : TObjectList;
    function CreateListItem(Sender: TJvCustomAppStorage; const Path: string;
      Index: Integer): TPersistent;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetFileInfo;
    class procedure WriteToAppStorage(AppStorage : TJvCustomAppStorage; const Path : string);
    class procedure ReadFromAppStorage(AppStorage : TJvCustomAppStorage; const Path : string);
  end;

  TTabsPersistInfo = class (TInterfacedPersistent, IJvAppStorageHandler)
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string); virtual;
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string); virtual;
  end;

var
  TabsPersistsInfo : TTabsPersistInfo;   // Singleton

implementation

uses
  System.Math,
  System.SysUtils,
  SynEditTypes,
  SynEdit,
  SpTBXTabs,
  TB2Item,
  JvJCLUtils,
  dmResources,
  frmPyIDEMain,
  uHighlighterProcs,
  cPyControl,
  cPyScripterSettings,
  cPySupportTypes,
  UUMLForm,
  frmEditor,
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
       IgnoreProperties.AddStrings(['Keystrokes', 'TrackChanges', 'SelectedColor', 'IndentGuides']);
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

     EditorOptions.Assign(cPyScripterSettings.GEditorOptions);
     AppStorage.ReadPersistent(BasePath+'\Editor Options', EditorOptions, True, True);
     EditorOptions.Options := EditorOptions.Options + [eoBracketsHighlight];

     SecondEditorVisible := AppStorage.ReadBoolean(BasePath+'\SecondEditorVisible', False);
     if SecondEditorVisible then begin
       AppStorage.ReadEnumeration(BasePath+'\Second Editor Align', TypeInfo(TAlign),
         SecondEditorAlign, SecondEditorAlign);
       SecondEditorSize := AppStorage.ReadInteger(BasePath+'Second Editor Size');
       SecondEditorUseCodeFolding := AppStorage.ReadBoolean(BasePath+'\Second Editor UseCodeFolding', False);
       if SecondEditorUseCodeFolding then
         FoldState2 := AppStorage.ReadString(BasePath+'\Second Editor FoldState', '');
       EditorOptions2.Assign(cPyScripterSettings.GEditorOptions);
       AppStorage.ReadPersistent(BasePath+'\Second Editor Options', EditorOptions2, True, True);
     end;
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
  var
    Stream: TMemoryStream;
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

begin
  FileKind:= fkEditor;
  FileName := Editor.FileId;
  TabControlIndex := Editor.TabControlIndex;
  Char := Editor.SynEdit.CaretX;
  Line := Editor.SynEdit.CaretY;
  TopLine := Editor.SynEdit.TopLine;
  if Assigned(Editor.SynEdit.Highlighter) then
    Highlighter := Editor.SynEdit.Highlighter.FriendlyLanguageName;

  if Assigned(Editor.SynEdit.Marks) then
    for var Mark in Editor.SynEdit.Marks do
      if Mark.IsBookmark then
      begin
        var BookMark := TBookMarkInfo.Create;
        BookMark.FChar := Mark.Char;
        BookMark.FLine := Mark.Line;
        BookMark.FBookmarkNumber := Mark.BookmarkNumber;
        BookMarks.Add(BookMark);
      end;

  for var BPoint in Editor.BreakPoints do
  begin
    var BreakPoint := TBreakpoint.Create;
    BreakPoint.Assign(BPoint);
    BreakPoints.Add(BreakPoint);
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
  if FileKind = fkEditor then
    CreateFromEditor(aFile as IEditor);
  if aFile.FileName <> '' then
    FileName := aFile.FileName
  else
    FileName := aFile.FileId;
  TabControlIndex := aFile.TabControlIndex;
end;

{ TPersistFileInfo }

constructor TPersistFileInfo.Create;
begin
  FFileInfoList := TObjectList.Create(True);
end;

class procedure TPersistFileInfo.ReadFromAppStorage(
  AppStorage: TJvCustomAppStorage; const Path : string);

  procedure RestoreFoldInfo(SynEdit: TSynEdit; UseCodeFolding: Boolean; FoldState: string);
  var
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

var
  PersistFileInfo : TPersistFileInfo;
  FilePersistInfo : TFilePersistInfo;
  Editor : IEditor;
  aFile: IFile;
  FName : string;
begin
  PersistFileInfo := TPersistFileInfo.Create;
  try
    AppStorage.ReadObjectList(Path, PersistFileInfo.FFileInfoList,
      PersistFileInfo.CreateListItem,  True, 'File');
    for var i := 0 to PersistFileInfo.FFileInfoList.Count - 1 do begin
      FilePersistInfo := TFilePersistInfo(PersistFileInfo.FFileInfoList[i]);
      if FileExists(FilePersistInfo.FileName) then
        try
          aFile := GI_EditorFactory.OpenFile(FilePersistInfo.FileName, '',
            FilePersistInfo.TabControlIndex);
        except
          Continue; // to the next file
        end
      else
        Continue;
      if Assigned(aFile) then begin
        if aFile.FileKind = fkEditor then begin
          Editor:= aFile as IEditor;
          Editor.SynEdit.TopLine := FilePersistInfo.TopLine;
          Editor.SynEdit.CaretXY := BufferCoord(FilePersistInfo.Char, FilePersistInfo.Line);

          for var BPoint in FilePersistInfo.BreakPoints do
            with TBreakpoint(BPoint) do
              GI_BreakpointManager.SetBreakpoint(FilePersistInfo.FileName,
                LineNo, Disabled, Condition, IgnoreCount);

          for var BookMark in FilePersistInfo.BookMarks do
            with TBookMarkInfo(BookMark) do
              Editor.SynEdit.SetBookMark(BookmarkNumber, Char, Line);

          if FilePersistInfo.Highlighter <> '' then begin
            Editor.SynEdit.Highlighter := ResourcesDataModule.Highlighters.
             HighlighterFromFriendlyName(FilePersistInfo.Highlighter);
            Editor.SynEdit2.Highlighter := Editor.SynEdit.Highlighter;
          end;
          FilePersistInfo.EditorOptions.Options:= FilePersistInfo.EditorOptions.Options + [eoCopyPlainText];
          Editor.SynEdit.Assign(FilePersistInfo.EditorOptions);
          RestoreFoldInfo(Editor.SynEdit, FilePersistInfo.UseCodeFolding, FilePersistInfo.FoldState);
          Editor.ReadOnly := FilePersistInfo.ReadOnly;
          if FilePersistInfo.SecondEditorVisible then begin
            RestoreFoldInfo(Editor.SynEdit2, FilePersistInfo.SecondEditorUseCodeFolding,
              FilePersistInfo.FoldState2);
            Editor.SynEdit2.Assign(FilePersistInfo.EditorOptions2);

            if FilePersistInfo.SecondEditorAlign = alRight then begin
              Editor.SplitEditorVertrically;
              Editor.SynEdit2.Width := FilePersistInfo.SecondEditorSize;
            end else begin
              Editor.SplitEditorHorizontally;
              Editor.SynEdit2.Height := FilePersistInfo.SecondEditorSize;
            end;
          end;
          if FilePersistInfo.GUIFormOpen then
            GI_EditorFactory.OpenFile(ChangeFileExt(FilePersistInfo.FileName, '.pfm'), '',
              FilePersistInfo.TabControlIndex);
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
  FFileInfoList.Free;
  inherited;
end;

class procedure TPersistFileInfo.WriteToAppStorage(
  AppStorage: TJvCustomAppStorage; const Path : string);
var
  PersistFileInfo : TPersistFileInfo;
  ActiveFile : IFile;
  FName : string;
begin
  PersistFileInfo := TPersistFileInfo.Create;
  try
    PersistFileInfo.GetFileInfo;
    AppStorage.WriteObjectList(Path, PersistFileInfo.FFileInfoList, 'File');
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
          FilePersistInfo := TFilePersistInfo.CreateFromFile(aFile);
          FFileInfoList.Add(FilePersistInfo);
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
var
  IsVisible : Boolean;
  Size : Integer;
  Alignment : TAlign;
begin
  IsVisible := AppStorage.ReadBoolean(BasePath+'\Visible', False);
  if IsVisible then begin
    Alignment := alRight;
    AppStorage.ReadEnumeration(BasePath+'\Align', TypeInfo(TAlign),
      Alignment, Alignment);
    Size := AppStorage.ReadInteger(BasePath+'\Size', -1);
    PyIDEMainForm.SplitWorkspace(True, Alignment, Size);
  end else
    PyIDEMainForm.SplitWorkspace(False);
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
