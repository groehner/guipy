{ -----------------------------------------------------------------------------
  Unit Name: frmEditor
  Author:    Kiriakos Vlahos, Gerhard Röhner
  Date:      23-Feb-2005
  Purpose:
  History:   Originally Based on SynEdit Demo
  -----------------------------------------------------------------------------}

unit frmEditor;

interface

uses
  Winapi.Windows,
  WinApi.Messages,
  Winapi.D2D1,
  System.Types,
  System.UITypes,
  System.SysUtils,
  System.Classes,
  System.Contnrs,
  System.ImageList,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Menus,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.Dialogs,
  Vcl.VirtualImageList,
  TB2Item,
  SpTBXItem,
  SpTBXSkins,
  SpTBXDkPanels,
  SpTBXTabs,
  SpTBXControls,
  SynEdit,
  SynEditTypes,
  SynEditHighlighter,
  SynEditMiscClasses,
  SynEditKeyCmds,
  SynEditExport,
  SynCompletionProposal,
  SynEditLsp,
  VirtualResources,
  uCommonFunctions,
  frmCodeExplorer,
  JediLspClient,
  uEditAppIntfs,
  cPyControl,
  cPythonSourceScanner,
  cCodeCompletion,
  cPyBaseDebugger,
  cPySupportTypes,
  frmFile,
  uModel,
  uPythonIntegrator,
  Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.BaseImageCollection, SVGIconImageCollection;

type
  TEditor = class;

  THotIdentInfo = record
    HaveHotIdent: Boolean;
    StartCoord: TBufferCoord;
  end;

  TEditorForm = class(TFileForm)
    pmnuEditor: TSpTBXPopupMenu;
    pmnuViewsTab: TSpTBXPopupMenu;
    mnCloseTab: TSpTBXItem;
    SynEdit: TSynEdit;
    SynEdit2: TSynEdit;
    EditorSplitter: TSpTBXSplitter;
    mnUpdateView: TSpTBXItem;
    ViewsTabControl: TSpTBXTabControl;
    tabSource: TSpTBXTabItem;
    tbshSource: TSpTBXTabSheet;
    SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem;
    tbiUpdateView: TSpTBXItem;
    tbiCloseTab: TSpTBXItem;
    N5: TSpTBXSeparatorItem;
    mnEditCut: TSpTBXItem;
    mnEditCopy: TSpTBXItem;
    mnEditPaste: TSpTBXItem;
    mnEditDelete: TSpTBXItem;
    mnEditSelectAll: TSpTBXItem;
    TBXSeparatorItem9: TSpTBXSeparatorItem;
    mnMaximizeEditor2: TSpTBXItem;
    BGPanel: TPanel;
    mnFoldVisible: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    mnFold: TSpTBXSubmenuItem;
    mnUnfold: TSpTBXSubmenuItem;
    mnFoldAll: TSpTBXItem;
    mnUnfoldAll: TSpTBXItem;
    mnFoldNearest: TSpTBXItem;
    mnUnfoldNearest: TSpTBXItem;
    mnFoldRegions: TSpTBXItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    mnFoldLevel1: TSpTBXItem;
    mnUnfoldRegions: TSpTBXItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    mnUnfoldLevel1: TSpTBXItem;
    mnFoldLevel2: TSpTBXItem;
    mnFoldLevel3: TSpTBXItem;
    mnUnfoldLevel2: TSpTBXItem;
    mnUnfoldLevel3: TSpTBXItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    mnFoldFunctions: TSpTBXItem;
    mnFoldClasses: TSpTBXItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    mnUnfoldFunctions: TSpTBXItem;
    mnUnfoldClasses: TSpTBXItem;
    vilGutterGlyphs: TVirtualImageList;
    vilCodeImages: TVirtualImageList;
    SpTBXSeparatorItem8: TSpTBXSeparatorItem;
    EditformToolbar: TToolBar;
    TBClose: TToolButton;
    TBExplorer: TToolButton;
    TBBrowser: TToolButton;
    TBDesignform: TToolButton;
    TBClassEdit: TToolButton;
    TBClassOpen: TToolButton;
    TBStructureIndent: TToolButton;
    TBIfStatement: TToolButton;
    TBIfElseStatement: TToolButton;
    TBWhileStatement: TToolButton;
    TBForStatement: TToolButton;
    TBIfElifStatement: TToolButton;
    TBTryStatement: TToolButton;
    TBComment: TToolButton;
    TBWordWrap: TToolButton;
    TBIndent: TToolButton;
    TBUnindent: TToolButton;
    TBBreakpoint: TToolButton;
    TBBreakpointsClear: TToolButton;
    TBBookmark: TToolButton;
    TBGotoBookmark: TToolButton;
    TBParagraph: TToolButton;
    TBNumbers: TToolButton;
    TBZoomPlus: TToolButton;
    TBZoomMinus: TToolButton;
    TBValidate: TToolButton;
    mnEditCreateStructogram: TSpTBXItem;
    TBMatchBracket: TToolButton;
    TBCheck: TToolButton;
    mnEditClassEditor: TSpTBXItem;
    mnEditOpenClass: TSpTBXItem;
    mnEditCopyPathname: TSpTBXItem;
    mnEditConfiguration: TSpTBXItem;
    mnEditGit: TSpTBXSubmenuItem;
    mnGitConsole: TSpTBXItem;
    mnGitViewer: TSpTBXItem;
    mnGitGUI: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    mnGitPush: TSpTBXItem;
    mnGitFetch: TSpTBXItem;
    mnGitRemote: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    mnGitRemove: TSpTBXItem;
    mnGitCheckout: TSpTBXItem;
    mnGitReset: TSpTBXItem;
    mnGitLog: TSpTBXItem;
    mnGitCommit: TSpTBXItem;
    mnGitAdd: TSpTBXItem;
    mnGitStatus: TSpTBXItem;
    TVFileStructure: TTreeView;
    mnFont: TSpTBXItem;
    mnEditAddImports: TSpTBXItem;
    vilEditorToolbarLight: TVirtualImageList;
    vilEditorToolbarDark: TVirtualImageList;
    vilBookmarksDark: TVirtualImageList;
    vilBookmarksLight: TVirtualImageList;

    vilContextMenuDark: TVirtualImageList;
    vilContextMenuLight: TVirtualImageList;
    mnEditAssistant: TSpTBXSubmenuItem;
    procedure SynEditChange(Sender: TObject);
    procedure SynEditEnter(Sender: TObject);
    procedure SynEditExit(Sender: TObject);
    procedure SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure SynEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SynEditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure FGPanelEnter(Sender: TObject);
    procedure FGPanelExit(Sender: TObject);
    procedure mnCloseTabClick(Sender: TObject);
    procedure SynEditMouseCursor(Sender: TObject;
      const aLineCharPos: TBufferCoord; var aCursor: TCursor);
    procedure SynEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynCodeCompletionExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: string; var X, Y: Integer;
      var CanExecute: Boolean);
    procedure SynCodeCompletionClose(Sender: TObject);
    procedure SynWebCompletionExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: string; var X, Y: Integer; var CanExecute: Boolean);
    procedure SynWebCompletionAfterCodeCompletion(Sender: TObject;
      const Value: string; Shift: TShiftState; Index: Integer;
      EndToken: WideChar);
    procedure mnUpdateViewClick(Sender: TObject);
    procedure ViewsTabControlContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ViewsTabControlActiveTabChange(Sender: TObject;
      TabIndex: Integer);
    procedure SynEditDblClick(Sender: TObject);
    procedure SynCodeCompletionAfterCodeCompletion(Sender: TObject;
      const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure SynEditGutterGetText(Sender: TObject; aLine: Integer;
      var aText: string);
    procedure SynEditDebugInfoPaintLines(RT: ID2D1RenderTarget; ClipR:
        TRect; const FirstRow, LastRow: Integer; var DoDefaultPainting: Boolean);
    procedure SynEditGutterDebugInfoCLick(Sender: TObject; Button: TMouseButton;
        X, Y, Row, Line: Integer);
    procedure SynEditGutterDebugInfoMouseCursor(Sender: TObject; X, Y, Row, Line:
        Integer; var Cursor: TCursor);
    procedure EditorShowHint(var HintStr: string; var CanShow: Boolean; var
        HintInfo: Vcl.Controls.THintInfo);
    procedure TBClassEditClick(Sender: TObject);
    procedure TBClassOpenClick(Sender: TObject);
    procedure TBWordWrapClick(Sender: TObject);
    procedure TBStatementClick(Sender: TObject);
    procedure TBZoomMinusClick(Sender: TObject);
    procedure TBZoomPlusClick(Sender: TObject);
    procedure TBNumbersClick(Sender: TObject);
    procedure TBParagraphClick(Sender: TObject);
    procedure TBGotoBookmarkClick(Sender: TObject);
    procedure TBUnindentClick(Sender: TObject);
    procedure TBIndentClick(Sender: TObject);
    procedure TBCommentClick(Sender: TObject);
    procedure TBBookmarkClick(Sender: TObject);
    procedure TBBreakpointClick(Sender: TObject);
    procedure TBBreakpointsClearClick(Sender: TObject);
    procedure SBDesignformClick(Sender: TObject);
    procedure TBDesignformClick(Sender: TObject);
    procedure TBCloseClick(Sender: TObject);
    procedure TBMatchBracketClick(Sender: TObject);
    procedure TBCheckClick(Sender: TObject);
    procedure mnEditCopyPathnameClick(Sender: TObject);
    procedure mnEditConfigurationClick(Sender: TObject);
    procedure mnGitExecute(Sender: TObject);
    procedure pmnuEditorPopup(Sender: TObject);
    procedure TBBrowserClick(Sender: TObject);
    procedure TBExplorerClick(Sender: TObject);
    procedure TBValidateClick(Sender: TObject);
    procedure mnFontClick(Sender: TObject);
    procedure mnEditAddImportsClick(Sender: TObject);
    procedure TBStructureIndentClick(Sender: TObject);
    class procedure SynParamCompletionExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: string; var X, Y: Integer;
      var CanExecute: Boolean);
  private
    const HotIdentIndicatorSpec: TGUID = '{8715589E-C990-4423-978F-F00F26041AEF}';
  private
    fEditor: TEditor;
    fActiveSynEdit: TSynEdit;
    fAutoCompleteActive: Boolean;
    fHotIdentInfo: THotIdentInfo;
    fNeedToSyncCodeExplorer: Boolean;
    fCloseBracketChar: WideChar;
    fOldCaretY: Integer;
    // Hints
    FHintFuture: IFuture<string>;
    FHintCursorRect: TRect;
    fNeedToParseModule: Boolean;
    fNeedToSyncFileStructure: Boolean;
    fPartner: TForm;
    fIndent1, fIndent2, fIndent3: string;
    fBookmark: Integer;
    fMouseIsInBorderOfStructure: Boolean;
    fMouseBorderOfStructure: Integer;
    FFrameType: Integer; // 3 = Qt, 2 = Tk, 1 = else, 0 unknown

    procedure AutoCompleteBeforeExecute(Sender: TObject);
    procedure AutoCompleteAfterExecute(Sender: TObject);
    procedure WMFolderChangeNotify(var Msg: TMessage); message WM_FOLDERCHANGENOTIFY;
    procedure SynCodeCompletionCodeItemInfo(Sender: TObject;
      AIndex: Integer; var Info : string);
    procedure DoAssignInterfacePointer(AActive: Boolean);
    function DoSave: Boolean;
    procedure setNeedsParsing(value: Boolean);
    procedure SetToolButtons;
    procedure TBControlStructures(KTag: Integer; OnKey: Boolean = False);
    procedure SetDeleteBookmark(XPos, YPos: Integer);
    procedure Unindent;
    procedure Indent;
    procedure SelStructure(var LineNo: Integer);
    function GetControlStructure(KTag: Integer; const Indent: string; block: string): string;
    function BeginOfStructure(Line: string): Boolean;
    function getNumbered: TStringList;
    procedure ChangeStyle;
    procedure ShowTkOrQt;
    function getFrameType: Integer;
    function getActiveSynEdit: TSynEdit;
    procedure ApplyPyIDEOptions;
    procedure ScrollbarAnnotationGetInfo(Sender: TObject; AnnType:
      TSynScrollbarAnnType; var Rows: TArray<Integer>; var Colors: TArray<TColor>);
    class procedure DoCodeCompletion(Editor: TSynEdit; Caret: TBufferCoord);
    class procedure SymbolsChanged(Sender: TObject);
    class var fOldEditorForm: TEditorForm;
    class procedure CodeHintLinkHandler(Sender: TObject; LinkName: string);
  protected
    procedure Retranslate; override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
    function DoSaveFile: Boolean; override;
    function DoSaveAs: Boolean; override;
    function DoSaveAsRemote: Boolean; override;
    function OpenFile(const aFilename: string): Boolean; override;
    function DoAskSaveChanges: Boolean; override;
    procedure SetModified(Value: Boolean); override;
    function GetModified: Boolean; override;
  public
    BorderHighlight : TColor;
    BorderNormal : TColor;
    BreakPoints: TObjectList;
    HasFocus: Boolean;
    HasSearchHighlight: Boolean;
    FoundSearchItems: TObjectList;
    SourceScanner: IAsyncSourceScanner;
    Model: TObjectModel;

    procedure ApplyEditorOptions;
    procedure DoActivate;
    procedure DoActivateEditor(Primary: Boolean = True);
    function DoActivateView(ViewFactory: IEditorViewFactory): IEditorView;
    function GetEditor: IEditor;
    procedure EditorCommandHandler(Sender: TObject; AfterProcessing: Boolean;
      var Handled: Boolean; var Command: TSynEditorCommand;
      var AChar: WideChar; Data: Pointer; HandlerData: Pointer);
    procedure DoOnIdle; override;
    procedure SyncCodeExplorer;
    procedure AddWatchAtCursor;
    function HasSyntaxError: Boolean;
    procedure GoToSyntaxError;

    procedure Enter(Sender: TObject); override;
    procedure SetOptions; override;
    function ReparseIfNeeded: Boolean;
    procedure SyncFileStructure;
    procedure CreateStructogram;
    function isPython: Boolean;
    function IsPythonAndGUI: Boolean;
    function isHTML: Boolean;
    function isCSS: Boolean;
    procedure GotoLine(i: Integer);
    procedure GotoWord(const s: string);
    procedure PutText(s: string; withCursor: Boolean = True);
    function getGeometry: TPoint;
    function getIndent: string;

    function  CBSearchClassOrMethod(Stop: Boolean; line: Integer): string;
    procedure DeleteBreakpointMark(Mark: TSynEditMark);
    procedure CreateTVFileStructure;

    function getClass(ClassNumber: Integer): TClass;
    function getConstructor(ClassNumber: Integer): TOperation;
    function getCreateWidgets: TOperation;
    function getLastConstructorLine(ClassNumber: Integer): Integer;
    function getLastCreateWidgetsLine: Integer;
    function getFirstCreateWidgetsLine: Integer;
    function getLineForConstructor(ClassNumber: Integer): Integer;
    function getLineForMethod(ClassNumber: Integer): Integer;
    function getFirstWidget(From: Integer; const widget: string): Integer;

    function getLineNumberWith(const s: string): Integer;
    function getLineNumberWithFrom(From: Integer; const s: string): Integer;
    function getLineNumberWithWord(const s: string): Integer;
    function getLineNumberWithWordFromTill(s: string; From: Integer; till: Integer=0): Integer;
    function getLineNumberOfBinding(Name, Attr: string): Integer;
    function getSource(LineS, LineE: Integer): string;
    function getLinesWithSelection: string;

    procedure ReplaceLine(const s1, s2: string);
    procedure ReplaceLineInLine(line: Integer; const old, aNew: string);
    procedure ReplaceWord(const s1, s2: string; all: Boolean);
    procedure ReplaceComponentname(const s1, s2: string; Events: string);
    procedure ReplaceAttribute(const key, s: string);
    procedure RemovePass(Classnumber: Integer);
    procedure setAttributValue(const destination, key, s: string; after: Integer);

    procedure InsertValue(const destination, s: string; after: Integer);
    procedure InsertLinesAt(line: Integer; s: string); overload;
    procedure InsertNewAttribute(const s: string);
    procedure InsertAtBegin(const s: string);
    procedure InsertAtEnd(const s: string);
    procedure InsertAttributeCE(const s: string; ClassNumber: Integer);
    procedure InsertTkBinding(const Name, Attr, Binding: string);
    procedure InsertQtBinding(const Name, Binding: string);
    procedure InsertProcedure(const aProcedure: string; ClassNumber: Integer = 0);
    procedure InsertProcedureWithoutParse(const aProcedure: string; ClassNumber: Integer = 0);
    procedure InsertConstructor(const aConstructor: string; ClassNumber: Integer);
    procedure InsertImport(Module: string);

    procedure DeleteAttribute(const s: string);
    procedure DeleteAttributeCE(const s: string; ClassNumber: Integer);
    procedure DeleteAttributeValues(const s: string);
    procedure DeleteEmptyLine(line: Integer);
    procedure DeleteLine(line: Integer); overload;
    procedure DeleteLine(s: string); overload;
    procedure DeleteBlock(StartLine, EndLine: Integer);
    procedure DeleteComponent(Control: TControl);
    procedure DeleteMethod(const Method: string);
    procedure DeleteOldAddNewMethods(OldMethods, NewMethods: TStringList);
    procedure DeleteBinding(const Binding: string);
    procedure DeleteItems(Name, Key: string);

    procedure MoveBlock(from, till, dest, desttill: Integer; const blanklines: string);
    procedure toForeground(Control: TControl);
    procedure toBackground(Control: TControl);

    procedure GoTo2(const s: string);
    function hasText(const s: string): Boolean;
    function hasWidget(const key: string; line: Integer): Boolean;

    procedure CreateModel;
    procedure ParseAndCreateModel;
    procedure NewClass(Pathname: string);
    procedure ExportToClipboard(Lines: TStringList; Exporter: TSynCustomExporter; asText: Boolean);
    procedure CopyRTF;
    procedure CopyRTFNumbered;
    procedure CopyHTML(asText: Boolean);
    procedure CopyNumbered;
    procedure ExportToFile(const filename: string; Exporter: TSynCustomExporter);
    procedure DoExport; override;
    procedure CollectClasses(SL: TStringList); override;
    procedure DoUpdateCaption; override;
    procedure CollapseGUICreation;
    function isGUICreationCollapsed: Boolean;
    procedure DoUpdateHighlighter(HighlighterName: string = '');
    function GetFileFormat: string;
    class function ToolbarCount: Integer;

    property Partner: TForm read fPartner write fPartner;
    property NeedsParsing: Boolean read fNeedToParseModule write setNeedsParsing;
    property ActiveSynEdit: TSynEdit read getActiveSynEdit;
    property FrameType: Integer read getFrameType;
    property Modified: Boolean read GetModified write SetModified;
  end;

  TEditor = class(TFile, IUnknown, IEditor, IEditCommands, ISearchCommands)
  private
    // IEditor implementation
    function ActivateView(ViewFactory: IEditorViewFactory): IEditorView;
    function GetCaretPos: TPoint;
    function GetSynEdit: TSynEdit;
    function GetSynEdit2: TSynEdit;
    function GetActiveSynEdit: TSynEdit;
    function GetBreakPoints: TObjectList;
    function GetFileFormat: string;
    function GetEditorState: string;
    function GetFileName: string;
    function GetHasSearchHighlight: Boolean;
    function GetFileEncoding: TFileSaveFormat;
    procedure SetFileEncoding(FileEncoding: TFileSaveFormat);
    function GetEncodedText: AnsiString;
    procedure OpenFile(const AFileName: string; HighlighterName: string = '');
    function HasPythonFile: Boolean;
    function GetReadOnly : Boolean;
    procedure SetHasSearchHighlight(Value : Boolean);
    procedure SetHighlighter(const HighlighterName: string);

    function GetGUIFormOpen: Boolean;
    procedure SetGuiFormOpen(Value: Boolean);
    procedure SetReadOnly(Value : Boolean);
    procedure ExecuteSelection;
    procedure SplitEditorHorizontally;
    procedure SplitEditorVertrically;
    procedure SplitEditorHide;
    procedure RefreshSymbols;
    procedure Retranslate;
    function GetForm: TForm;
    function GetDocSymbols: TObject;
    function GetTabControlIndex: Integer;
    function GetSSHServer: string;

    // ISearchCommands implementation
    function CanFind: Boolean;
    function CanFindNext: Boolean;
    function ISearchCommands.CanFindPrev = CanFindNext;
    function ISearchCommands.GetSearchTarget = GetActiveSynEdit;
    function CanReplace: Boolean;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
  private
    fForm: TEditorForm;
    FSynLsp: TLspSynEditPlugin;
    FGUIFormOpen: Boolean;
    //fCodeExplorerData: ICodeExplorerData;
    function IsEmpty: Boolean;
    function GetEncodedTextEx(var EncodedText: AnsiString;
      InformationLossWarning: Boolean): Boolean;
  protected
    procedure Activate(Primary: Boolean = True); override;
    procedure Close; override;
    function GetModified: Boolean; override;
    procedure SetModified(Value: Boolean); override;
    function GetFileTitle: string; override;
    // IFileCommands implementation
    procedure ExecPrint; override;
    procedure ExecPrintPreview; override;
    procedure ExecReload(Quiet: Boolean = False); override;
    // IEditCommands implementation
    function CanCopy: Boolean; override;
    function CanCut: Boolean;
    function IEditCommands.CanDelete = CanCut;
    function CanPaste: Boolean; override;
    function CanRedo: Boolean;
    function CanSelectAll: Boolean;
    function CanUndo: Boolean;
    procedure ExecCopy; override;
    procedure ExecCut;
    procedure ExecDelete;
    procedure ExecPaste; override;
    procedure ExecRedo;
    procedure ExecSelectAll;
    procedure ExecUndo;
  public
    constructor Create(AForm: TFileForm); reintroduce;
    destructor Destroy; override;
    procedure DoSetFileName(AFileName: string); override;
    procedure OpenRemoteFile(const FileName, ServerName: string); override;
    function SaveToRemoteFile(const FileName, ServerName: string) : Boolean; override;
  end;

implementation

{$R *.DFM}

uses
  Clipbrd,
  System.Math,
  RegularExpressions,
  VirtualShellNotifier,
  PythonEngine,
  VarPyth,
  Vcl.Themes,
  StrUtils,
  IOUtils,
  JSON,
  JclFileUtils,
  SynUnicode,
  SynEditTextBuffer,
  SynHighlighterWebMisc,
  SynHighlighterWeb,
  SynHighlighterPython,
  SynDWrite,
  SynExportRTF,
  SynExportHTML,
  JvDockControlForm,
  JvGnugettext,
  StringResources,
  dmResources,
  dmCommands,
  uHighlighterProcs,
  dlgSynPrintPreview,
  dlgRemoteFile,
  frmPyIDEMain,
  frmBreakPoints,
  frmPythonII,
  frmWatches,
  frmIDEDockWin,
  frmMessages,
  uSearchHighlighter,
  cInternalPython,
  cPyDebugger,
  cCodeHint,
  cPyScripterSettings,
  cSSHSupport,
  UUtils,
  UConfiguration,
  uModelEntity,
  UUMLForm,
  UGUIForm,
  UGUIDesigner,
  UClassEditor,
  UBrowser,
  ULink,
  UFileStructure,
  UBaseWidgets,
  UPythonScanner,
  UImages,
  UGit,
  cFileSearch,
  cTools;

const
  WM_DELETETHIS = WM_USER + 42;

  { TGutterMarkDrawPlugin }

type
  TDebugSupportPlugin = class(TSynEditPlugin)
  protected
    fForm: TEditorForm;
    procedure LinesInserted(FirstLine, Count: Integer); override;
    procedure LinesDeleted(FirstLine, Count: Integer); override;
  public
    constructor Create(AForm: TEditorForm);
  end;

constructor TDebugSupportPlugin.Create(AForm: TEditorForm);
begin
  inherited Create(AForm.SynEdit);
  FHandlers := [phLinesInserted, phLinesDeleted, phAfterPaint];
  fForm := AForm;
end;

procedure TDebugSupportPlugin.LinesInserted(FirstLine, Count: Integer);
var
  i: Integer;
begin
  with fForm do
  begin
    for i := 0 to BreakPoints.Count - 1 do
      if TBreakPoint(BreakPoints[i]).LineNo >= FirstLine then
      begin
        TBreakPoint(BreakPoints[i]).LineNo := TBreakPoint(BreakPoints[i])
          .LineNo + Count;
        PyControl.BreakPointsChanged := True;
        BreakPointsWindow.UpdateWindow;
      end;
  end;
end;

procedure TDebugSupportPlugin.LinesDeleted(FirstLine, Count: Integer);
var
  i: Integer;
begin
  with fForm do
  begin
    for i := BreakPoints.Count - 1 downto 0 do
      if TBreakPoint(BreakPoints[i]).LineNo >= FirstLine + Count then
      begin
        TBreakPoint(BreakPoints[i]).LineNo := TBreakPoint(BreakPoints[i])
          .LineNo - Count;
        PyControl.BreakPointsChanged := True;
        BreakPointsWindow.UpdateWindow;
      end
      else if TBreakPoint(BreakPoints[i]).LineNo >= FirstLine then
      begin
        BreakPoints.Delete(i);
        PyControl.BreakPointsChanged := True;
        BreakPointsWindow.UpdateWindow;
      end;
  end;
end;

{ TEditor }

constructor TEditor.Create(AForm: TFileForm);
begin
  Assert(AForm <> nil);
  inherited Create(fkEditor, AForm);
  fForm := TEditorForm(AForm);
  //fCodeExplorerData := TCodeExplorerData.Create;
  SetFileEncoding(PyIDEOptions.NewFileEncoding);
  FSynLsp := TLspSynEditPlugin.Create(fForm.SynEdit);
  FSynLsp.DocSymbols.OnNotify := FForm.SymbolsChanged;
  CodeExplorerWindow.UpdateWindow(FSynLsp.DocSymbols, ceuEditorEnter);
end;

procedure TEditor.Activate(Primary: Boolean = True);
begin
  if fForm <> nil then
    fForm.DoActivateEditor(Primary);
end;

function TEditor.ActivateView(ViewFactory: IEditorViewFactory): IEditorView;
begin
  if fForm <> nil then
    Result := fForm.DoActivateView(ViewFactory);
end;

procedure TEditor.Close;
// Closes without asking
begin
  if fForm <> nil then begin
    FSynLsp.FileClosed;
    GI_EditorFactory.RemoveEditor(Self);
    inherited;
  end;
end;

destructor TEditor.Destroy;
begin
  // Kept for debugging
  inherited;
end;

procedure TEditor.DoSetFileName(AFileName: string);
begin
  fForm.fNeedToParseModule := True;
  inherited DoSetFilename(AFileName);
end;

function TEditor.GetSynEdit: TSynEdit;
begin
  if Assigned(fForm)
    then Result:= fForm.SynEdit
    else Result:= nil;
end;

function TEditor.GetSynEdit2: TSynEdit;
begin
  if Assigned(fForm)
    then Result:= fForm.SynEdit2
    else Result:= nil;
end;

function TEditor.GetTabControlIndex: Integer;
begin
  Result := PyIDEMainForm.TabControlIndex(fForm.ParentTabControl);
end;

function TEditor.GetActiveSynEdit: TSynEdit;
begin
  if fForm.SynEdit2.Visible and (fForm.fActiveSynEdit = fForm.SynEdit2) then
    Result := fForm.SynEdit2
  else
    Result := fForm.SynEdit;
end;

function TEditor.GetBreakPoints: TObjectList;
begin
  Result := fForm.BreakPoints;
end;

function TEditor.GetCaretPos: TPoint;
begin
  if fForm <> nil then
  begin
    Result := TPoint(GetActiveSynEdit.CaretXY);
  end
  else
    Result := Point(-1, -1);
end;

function TEditor.GetDocSymbols: TObject;
begin
  Result := FSynLsp.DocSymbols;
end;

function TEditor.GetFileFormat: string;
begin
  if fForm <> nil
    then Result:= fForm.GetFileformat
    else Result:= '';
end;

function TEditor.GetEditorState: string;
begin
  if fForm <> nil then
  begin
    if fForm.SynEdit.ReadOnly then
      Result := _(SReadOnly)
    else if fForm.SynEdit.InsertMode then
      Result := _(SInsert)
    else
      Result := _(SOverwrite);
  end
  else
    Result := '';
end;

function TEditor.GetEncodedText: AnsiString;
begin
  GetEncodedTextEx(Result, False);
end;

function TEditor.GetEncodedTextEx(var EncodedText: AnsiString;
  InformationLossWarning: Boolean): Boolean;
begin
  Result := WideStringsToEncodedText(GetFileId, fForm.SynEdit.Lines,
    EncodedText, InformationLossWarning, HasPythonFile);
end;

function TEditor.GetFileName: string;
begin
  Result := fFileName;
end;

function TEditor.GetFileTitle: string;
begin
  if (fFileName <> '') or (fSSHServer <> '') then
    Result:= inherited
  else begin
    if fUntitledNumber = -1 then
      fUntitledNumber := GetUntitledNumber;
    if fForm.SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn then
      Result := _(SNonamePythonFileTitle) + IntToStr(fUntitledNumber)
    else
      Result := _(SNonameFileTitle) + IntToStr(fUntitledNumber);
  end;
end;

function TEditor.GetModified: Boolean;
begin
  if fForm <> nil then
    Result := fForm.SynEdit.Modified
  else
    Result := False;
end;

procedure TEditor.SetModified(Value: Boolean);
begin
  if fForm <> nil then
    fForm.SynEdit.Modified:= Value;
end;

function TEditor.GetReadOnly: Boolean;
begin
  Result := GetSynEdit.ReadOnly;
end;

function TEditor.GetGUIFormOpen: Boolean;
begin
  Result := fGUIFormOpen;
end;

procedure TEditor.SetGuiFormOpen(Value: Boolean);
begin
  fGUIFormOpen:= Value;
end;

function TEditor.GetSSHServer: string;
begin
  Result := fSSHServer;
end;

function TEditor.GetFileEncoding: TFileSaveFormat;
begin
  with fForm.SynEdit.Lines do
  begin
    if Encoding = nil then Exit(sf_Ansi);

    if Encoding = TEncoding.UTF8 then
    begin
      if WriteBOM then
        Result := sf_UTF8
      else
        Result := sf_UTF8_NoBOM;
    end else if Encoding = TEncoding.Unicode then
      Result := sf_UTF16LE
    else if Encoding = TEncoding.BigEndianUnicode then
      Result := sf_UTF16BE
    else
      Result := sf_Ansi;
  end;
end;

procedure TEditor.SetFileEncoding(FileEncoding: TFileSaveFormat);
begin
  with TSynEditStringList(fForm.SynEdit.Lines) do
  begin
    case FileEncoding of
      sf_Ansi: SetEncoding(Encoding.ANSI);
      sf_UTF8,
      sf_UTF8_NoBOM: SetEncoding(TEncoding.UTF8);
      sf_UTF16LE: SetEncoding(TEncoding.Unicode);
      sf_UTF16BE: SetEncoding(TEncoding.BigEndianUnicode);
    end;
    if FileEncoding = sf_UTF8_NoBOM then
      WriteBOM := False
    else
      WriteBom := True;
  end;
end;

procedure TEditor.SetHasSearchHighlight(Value: Boolean);
begin
  fForm.HasSearchHighlight :=  Value;
end;

procedure TEditor.SetHighlighter(const HighlighterName: string);
begin
  fForm.DoUpdateHighlighter(HighlighterName);
end;

procedure TEditor.SetReadOnly(Value: Boolean);
begin
  GetSynEdit.ReadOnly := Value;
  GetSynEdit2.ReadOnly := Value;
end;

procedure TEditor.SplitEditorHorizontally;
begin
  with fForm do
  begin
    if not SynEdit2.IsChained then
      SynEdit2.SetLinesPointer(SynEdit);
    EditorSplitter.Visible := False;
    SynEdit2.Visible := False;
    SynEdit2.Align := alBottom;
    SynEdit2.Height := (ClientHeight - 5) div 2;
    EditorSplitter.Align := alBottom;
    SynEdit2.Visible := True;
    EditorSplitter.Visible := True;
  end;
end;

procedure TEditor.SplitEditorVertrically;
begin
  with fForm do
  begin
    if not SynEdit2.IsChained then
      SynEdit2.SetLinesPointer(SynEdit);
    EditorSplitter.Visible := False;
    SynEdit2.Visible := False;
    SynEdit2.Align := alRight;
    SynEdit2.Width := (ClientWidth - 5) div 2;
    EditorSplitter.Align := alRight;
    SynEdit2.Visible := True;
    EditorSplitter.Visible := True;
  end;
end;

procedure TEditor.SplitEditorHide;
begin
  with fForm do
  begin
    EditorSplitter.Visible:= False;
    SynEdit2.Visible := False;
    if Synedit2.IsChained then
      SynEdit2.RemoveLinesPointer;
  end;
end;

procedure TEditor.OpenFile(const AFileName: string;
  HighlighterName: string = '');
begin
  if FForm = nil then Abort;

  DoSetFileName(AFileName);
  if (AFileName <> '') and FileExists(AFileName) then
  begin
    fForm.SynEdit.LockUndo;
    try
      if LoadFileIntoWideStrings(AFileName, fForm.SynEdit.Lines) then
      begin
        if not FileAge(AFileName, fForm.FileTime) then
          fForm.FileTime := 0;
      end
      else
        Abort;
    finally
      fForm.SynEdit.UnlockUndo;
    end;
  end
  else
  begin
    if AFileName = '' then
    begin
      // Default settings for new files
      if PyIDEOptions.NewFileLineBreaks <> sffUnicode then
        (fForm.SynEdit.Lines as TSynEditStringList).FileFormat :=
          PyIDEOptions.NewFileLineBreaks;
    end;
  end;
  fForm.DoUpdateHighlighter(HighlighterName);
  if PyIDEOptions.CodeFoldingForGuiElements then
    fForm.CollapseGUICreation;
  if HasPythonFile then
    FSynLsp.FileOpened(GetFileId, lidPython)
  else
    FSynLsp.FileOpened(GetFileId, lidNone);
end;

procedure TEditor.OpenRemoteFile(const FileName, ServerName: string);
var
  TempFileName : string;
  ErrorMsg : string;
begin
  if (fForm = nil) or (FileName = '') or (ServerName = '') then Abort;

  DoSetFileName('');

  TempFileName := ChangeFileExt(FileGetTempName('PyScripter'), ExtractFileExt(FileName));
  if not GI_SSHServices.ScpDownload(ServerName, FileName, TempFileName, ErrorMsg) then begin
    StyledMessageDlg(Format(_(SFileOpenError), [FileName, ErrorMsg]), mtError, [mbOK], 0);
    Abort;
  end else
  begin
    fForm.SynEdit.LockUndo;
    try
      if not LoadFileIntoWideStrings(TempFileName, fForm.SynEdit.Lines) then
        Abort
      else
        DeleteFile(TempFileName);
    finally
      fForm.SynEdit.UnlockUndo
    end;
  end;

  fRemoteFileName := FileName;
  fSSHServer := ServerName;

  fForm.SynEdit.Modified := False;
  fForm.DoUpdateHighlighter('');
  fForm.DoUpdateCaption;
  fForm.SynEdit.UseCodeFolding := PyIDEOptions.CodeFoldingEnabled;
  fForm.Synedit2.UseCodeFolding := fForm.SynEdit.UseCodeFolding;

  if HasPythonFile then
    FSynLsp.FileOpened(GetFileId, lidPython)
  else
    FSynLsp.FileOpened(GetFileId, lidNone);
end;

function TEditor.SaveToRemoteFile(const FileName, ServerName: string): Boolean;
var
  TempFileName : string;
  ErrorMsg : string;
begin
  if (fForm = nil)  or (FileName = '') or (ServerName = '') then  Abort;

  TempFileName := FileGetTempName('PyScripter');
  Result := SaveWideStringsToFile(TempFileName, fForm.SynEdit.Lines, False);
  if Result then begin
    Result := GI_SSHServices.ScpUpload(ServerName, TempFileName, FileName, ErrorMsg);
    DeleteFile(TempFileName);
    if not Result then
      StyledMessageDlg(Format(_(SFileSaveError), [FileName, ErrorMsg]), mtError, [mbOK], 0);
  end;
end;

procedure TEditor.RefreshSymbols;
begin
  if FSynLsp.NeedToRefreshSymbols then
    FSynLsp.RefreshSymbols(GetFileId);
end;

procedure TEditor.Retranslate;
begin
  fForm.Retranslate;
end;

function TEditor.HasPythonFile: Boolean;
begin
  var edit:= GetSynEdit;
  if Assigned(edit)
    then Result:= GetSynEdit.Highlighter is TSynPythonSyn
    else Result:= False;
end;

function TEditor.GetForm: TForm;
begin
  Result := fForm;
end;

function TEditor.GetHasSearchHighlight: Boolean;
begin
  Result := fForm.HasSearchHighlight;
end;

// IEditCommands implementation

function TEditor.CanCopy: Boolean;
begin
  Result := not GetActiveSynEdit.Selections.IsEmpty or (GetActiveSynEdit.LineText <> '');
end;

function TEditor.CanCut: Boolean;
begin
  Result := (fForm <> nil) and not GetReadOnly;
end;

function TEditor.CanPaste: Boolean;
begin
  Result := (fForm <> nil) and GetActiveSynEdit.CanPaste;
end;

function TEditor.CanRedo: Boolean;
begin
  Result := (fForm <> nil) and fForm.SynEdit.CanRedo;
end;

function TEditor.CanSelectAll: Boolean;
begin
  Result := fForm <> nil;
end;

function TEditor.CanUndo: Boolean;
begin
  Result := (fForm <> nil) and fForm.SynEdit.CanUndo;
end;

procedure TEditor.ExecCopy;
begin
  if fForm <> nil then
    GetActiveSynEdit.CopyToClipboard;
end;

procedure TEditor.ExecCut;
begin
  if fForm <> nil then
    GetActiveSynEdit.CutToClipboard;
end;

procedure TEditor.ExecDelete;
begin
  if fForm <> nil then
    GetActiveSynEdit.SelText := '';
end;

procedure TEditor.ExecPaste;
begin
  if fForm <> nil then
    GetActiveSynEdit.PasteFromClipboard;
end;

procedure TEditor.ExecRedo;
begin
  if fForm <> nil then
    fForm.SynEdit.Redo;
end;

procedure TEditor.ExecReload(Quiet: Boolean = False);
var
  P: TBufferCoord;
begin
  if Quiet or not GetModified or (StyledMessageDlg(_(SFileReloadingWarning),
      mtWarning, [mbYes, mbNo], 0) = mrYes) then
  begin
    P := GetSynEdit.CaretXY;
    OpenFile(GetFileName);
    if (P.Line <= GetSynEdit.Lines.Count) then
      GetSynEdit.CaretXY := P;
  end;
end;

procedure TEditor.ExecSelectAll;
begin
  if fForm <> nil then
    GetActiveSynEdit.SelectAll;
end;

procedure TEditor.ExecUndo;
begin
  if fForm <> nil then
    fForm.SynEdit.Undo;
end;

procedure TEditor.ExecuteSelection;
var
  ExecType: string;
  Source: string;
  Editor: TSynEdit;
begin
  if not HasPythonFile or not GI_PyControl.PythonLoaded or GI_PyControl.Running then
  begin
    // it is dangerous to execute code while running scripts
    // so just beep and do nothing
    MessageBeep(MB_ICONERROR);
    Exit;
  end;

  Editor := GetActiveSynEdit;

  ExecType := 'exec';

  // If nothing is selected then try to eval the word at cursor
  if Editor.SelAvail then
  begin
    Source := Editor.SelText;
    // if a single line or part of a line is selected then eval the selection
    if Editor.BlockBegin.Line = Editor.BlockEnd.Line then
      ExecType := 'single'
    else
      Source := Source + sLineBreak; // issue 291
  end
  else
  begin
    Source := Editor.WordAtCursor;
    if Source <> '' then
      ExecType := 'single'
    else
      Exit;
  end;

  // Dedent the selection
  Source := Dedent(Source);

  GI_PyInterpreter.ShowWindow;
  GI_PyInterpreter.AppendText(sLineBreak);
  PythonIIForm.SynEdit.ExecuteCommand(ecEditorBottom, ' ', nil);
  Source := CleanEOLs(Source);

  ThreadPythonExec(procedure
  begin
    // RunSource
    case PyControl.DebuggerState of
      dsInactive:
        PyControl.ActiveInterpreter.RunSource(Source, '<editor selection>',
          ExecType);
      dsPaused, dsPostMortem:
        PyControl.ActiveDebugger.RunSource(Source, '<editor selection>',
          ExecType);
    end;
  end,
  procedure
  begin
    GI_PyInterpreter.AppendPrompt;
    Activate(False);
  end);
end;

// IFileCommands implementation

procedure TEditor.ExecPrint;
begin
  if fForm <> nil then
    with ResourcesDataModule, CommandsDataModule do
    begin
      SynEditPrint.SynEdit := fForm.SynEdit;
      PrintDialog.MinPage := 1;
      PrintDialog.MaxPage := SynEditPrint.PageCount;
      PrintDialog.FromPage := 1;
      PrintDialog.ToPage := PrintDialog.MaxPage;
      PrintDialog.PrintRange := prAllPages;

      if PrintDialog.Execute then
      begin
        SynEditPrint.Title := GetFileTitle;
        if PrintDialog.PrintRange = prAllPages then
          SynEditPrint.Print
        else
          SynEditPrint.PrintRange(PrintDialog.FromPage, PrintDialog.ToPage);
      end;
    end;
end;

procedure TEditor.ExecPrintPreview;
begin
  CommandsDataModule.SynEditPrint.SynEdit := fForm.SynEdit;
  CommandsDataModule.SynEditPrint.Title := GetFileTitle;
  with TPrintPreviewDlg.Create(Application.MainForm) do
  begin
    SynEditPrintPreview.SynEditPrint := CommandsDataModule.SynEditPrint;
    ShowModal;
    Release;
  end;
end;

// ISearchCommands implementation

function TEditor.CanFind: Boolean;
begin
  Result := (fForm <> nil) and not IsEmpty;
end;

function TEditor.CanFindNext: Boolean;
begin
  Result := (fForm <> nil) and not IsEmpty and
    (EditorSearchOptions.SearchText <> '');
end;

function TEditor.CanReplace: Boolean;
begin
  Result := (fForm <> nil) and not GetReadOnly and not IsEmpty;
end;

procedure TEditor.ExecFind;
begin
  if fForm <> nil then
    CommandsDataModule.ShowSearchReplaceDialog(GetActiveSynEdit, False);
end;

procedure TEditor.ExecFindNext;
begin
  if fForm <> nil then
    CommandsDataModule.DoSearchReplaceText(GetActiveSynEdit, False, False);
end;

procedure TEditor.ExecFindPrev;
begin
  if fForm <> nil then
    CommandsDataModule.DoSearchReplaceText(GetActiveSynEdit, False, True);
end;

procedure TEditor.ExecReplace;
begin
  if fForm <> nil then
    CommandsDataModule.ShowSearchReplaceDialog(GetActiveSynEdit, True);
end;

function TEditor.IsEmpty: Boolean;
begin
  Result := (fForm.SynEdit.Lines.Count = 0) or
    ((fForm.SynEdit.Lines.Count = 1) and (fForm.SynEdit.Lines[0] = ''));
end;

{ TEditorFactory }

type
  TEditorFactory = class(TFileFactory, IEditorFactory)
  private
    // IEditorFactory implementation
    function NewEditor(TabControlIndex:Integer = 1): IEditor;
    function GetEditorCount: Integer;
    function GetEditorByName(const Name: string): IEditor;
    function GetEditorByFileId(const Name: string): IEditor;
    function GetEditor(Index: Integer): IEditor;
    procedure RemoveEditor(AEditor: IEditor);
    function RegisterViewFactory(ViewFactory: IEditorViewFactory): Integer;
    procedure SetupEditorViewsMenu(ViewsMenu: TSpTBXItem; IL: TCustomImageList);
    procedure UpdateEditorViewsMenu(ViewsMenu: TSpTBXItem);
    procedure CreateRecoveryFiles;
    procedure RecoverFiles;
    function GetViewFactoryCount: Integer;
    function GetViewFactory(Index: Integer): IEditorViewFactory;
    procedure LockList;
    procedure UnlockList;
    procedure ApplyToEditors(const Proc: TProc<IEditor>);
    function FirstEditorCond(const Predicate: TPredicate<IEditor>): IEditor;
  private
    //fEditors: TInterfaceList;
    fEditorViewFactories: TInterfaceList;
    constructor Create;
    destructor Destroy; override;
    procedure OnEditorViewClick(Sender: TObject);
  end;

constructor TEditorFactory.Create;
begin
  inherited Create;
  //fEditors := TInterfaceList.Create;
  fEditorViewFactories := TInterfaceList.Create;
end;

procedure TEditorFactory.CreateRecoveryFiles;
begin
  var RecoveryDir := TPyScripterSettings.RecoveryDir;
  if TDirectory.Exists(RecoveryDir) then
    TDirectory.Delete(RecoveryDir, True);
  TDirectory.CreateDirectory(RecoveryDir);

  ApplyToEditors(procedure(Ed: IEditor)
  begin
    if not Ed.Modified then Exit;

    if (Ed.FileName <> '') or (Ed.RemoteFileName <> '') then
      (Ed as IFileCommands).ExecSave
    else
    with TEditorForm(Ed.Form) do
    begin
      // save module1 as 1.py etc.
      var FName := (Ed as TEditor).fUntitledNumber.ToString;
      FName := TPath.Combine(RecoveryDir, TPath.ChangeExtension(FName, DefaultExtension));
      SaveWideStringsToFile(FName, SynEdit.Lines, False);
    end;
  end);
end;

destructor TEditorFactory.Destroy;
begin
  FreeAndNil(fEditorViewFactories);
  inherited Destroy;
end;

procedure TEditorFactory.ApplyToEditors(const Proc: TProc<IEditor>);
begin
  fFiles.Lock;
  try
    for var i:= 0 to fFiles.Count - 1 do
      if IFile(fFiles[i]).FileKind = fkEditor then
        Proc(IEditor(fFiles[I]));
  finally
    fFiles.Unlock;
  end;
end;

function TEditorFactory.FirstEditorCond(const Predicate: TPredicate<IEditor>): IEditor;
var
  Editor: IEditor;
begin
  fFiles.Lock;
  try
    Result := nil;
    for var I := 0 to fFiles.Count - 1 do
      if IFile(fFiles[i]).FileKind = fkEditor then begin
        Editor := IEditor(fFiles[I]);
        if Predicate(Editor) then
          Exit(Editor);
      end;
  finally
    fFiles.Unlock;
  end;
end;

function TEditorFactory.NewEditor(TabControlIndex:Integer = 1): IEditor;
var
  Sheet: TSpTBXTabSheet;
  LForm: TEditorForm;
  TabItem: TSpTBXTabItem;
begin
  var TabControl := PyIDEMainForm.TabControl(TabControlIndex);

  TabItem := TabControl.Add('');
  TabItem.Images := PyIDEMainForm.vilTabDecorators;
  Sheet := TabControl.GetPage(TabItem);
  try
    LForm := TEditorForm.Create(Sheet);
    with LForm do
    begin
      Visible := False;
      fEditor := TEditor.Create(LForm);
      fFile   := fEditor;
      ParentTabItem := TabItem;
      ParentTabItem.OnTabClosing := PyIDEMainForm.TabControlTabClosing;
      ParentTabItem.OnDrawTabCloseButton := PyIDEMainForm.DrawCloseButton;
      ParentTabControl := TabControl;
      Result := fEditor;
      BorderStyle := bsNone;
      Parent := Sheet;
      Align := alClient;
      Visible := True;
      ScaleForPPI(Sheet.CurrentPPI);
      ApplyEditorOptions;
      ApplyPyIDEOptions;
    end;
    if Result <> nil then
      fFiles.Add(Result);
  except
    Sheet.Free;
  end;
end;

function TEditorFactory.GetEditorCount: Integer;
  var i: Integer;
begin
  Result := 0;
  for i:= 0 to GetFileCount - 1 do
    if GetFile(i).FileKind = fkEditor then
      Inc(Result);
end;

function TEditorFactory.GetViewFactory(Index: Integer): IEditorViewFactory;
begin
  fEditorViewFactories.Lock;
  try
    Result := fEditorViewFactories[Index] as IEditorViewFactory;
  finally
    fEditorViewFactories.UnLock;
  end;
end;

function TEditorFactory.GetViewFactoryCount: Integer;
begin
  Result := fEditorViewFactories.Count;
end;

procedure TEditorFactory.LockList;
begin
  fFiles.Lock;
end;

procedure TEditorFactory.UnlockList;
begin
  fFiles.UnLock;
end;

function TEditorFactory.GetEditorByName(const Name: string): IEditor;
var
  FullName: string;
begin
  // The Name may contain invalid characters and ExpandFileName will raise an
  // exception.  This is the case with exceptions raised by pywin32 COM objects
  try
    FullName := GetLongFileName(ExpandFileName(Name));
  except
    Exit(nil);
  end;
  Result := FirstEditorCond(function(Editor: IEditor): Boolean
  begin
    Result := AnsiSameText(Editor.GetFileName, FullName);
  end);
end;

function TEditorFactory.GetEditorByFileId(const Name: string): IEditor;
begin
  Result := GetEditorByName(Name);
  if not Assigned(Result) then
    Result := FirstEditorCond(function(Editor: IEditor): Boolean
    begin
      Result := (Editor.FileName = '') and AnsiSameText(Editor.GetFileTitle, Name);
    end);
end;

function TEditorFactory.GetEditor(Index: Integer): IEditor;
  var i, n: Integer;
begin
  Result:= nil;
  n:= -1;
  for i:= 0 to GetFileCount - 1 do
    if GetFile(i).FileKind = fkEditor then begin
      Inc(n);
      if n = Index then begin
        Result:= IEditor(getFile(i));
        Exit;
      end;
    end;
end;

procedure TEditorFactory.RemoveEditor(AEditor: IEditor);
begin
  RemoveFile(AEditor);
end;

procedure TEditorFactory.RecoverFiles;
var
  UntitledNumber: Integer;
begin
  var RecoveryDir := TPyScripterSettings.RecoveryDir;
  if not TDirectory.Exists(RecoveryDir) then Exit;

  var RecoveredFiles := TDirectory.GetFiles(RecoveryDir);
  for var RecoveredFile in RecoveredFiles do
  begin
    var FName := TPath.GetFileNameWithoutExtension(RecoveredFile);
    if not TryStrToInt(FName, UntitledNumber) then Continue;

    var Ed := NewEditor;
    Ed.OpenFile(RecoveredFile);

    var Editor := Ed as TEditor;
    Editor.fUntitledNumber := UntitledNumber;
    Editor.UntitledNumbers.Bits[UntitledNumber] := True;
    Editor.DoSetFileName('');
    Editor.fForm.DoUpdateCaption;
    if Editor.HasPythonFile then
      Editor.FSynLsp.FileSavedAs(Editor.GetFileId, lidPython)
  end;
  TDirectory.Delete(RecoveryDir, True);
end;

function TEditorFactory.RegisterViewFactory(ViewFactory: IEditorViewFactory): Integer;
begin
  Result := fEditorViewFactories.Add(ViewFactory);
end;

procedure TEditorFactory.OnEditorViewClick(Sender: TObject);
var
  ViewFactory: IEditorViewFactory;
  EditorView: IEditorView;
  Editor: IEditor;
  Index: Integer;
begin
  Editor := GI_PyIDEServices.ActiveEditor;
  if not Assigned(Editor) then
    Exit;
  //Index := (Sender as TSpTBXItem).Tag;
  Index:= 2;  // Tag = 0 for valid menu items
  if (Index >= 0) and (Index < fEditorViewFactories.Count) then
  begin
    ViewFactory := fEditorViewFactories[Index] as IEditorViewFactory;
    EditorView := Editor.ActivateView(ViewFactory);
    if Assigned(EditorView) then
      EditorView.UpdateView(Editor);
  end;
end;

procedure TEditorFactory.SetupEditorViewsMenu(ViewsMenu: TSpTBXItem; IL: TCustomImageList);
var
  MenuItem: TSpTBXItem;
  i: Integer;
  ViewFactory: IEditorViewFactory;
begin
  ViewsMenu.Clear;
  fEditorViewFactories.Lock;
  try
    ViewsMenu.Enabled := fEditorViewFactories.Count > 0;
    for i := 0 to fEditorViewFactories.Count - 1 do
    begin
      ViewFactory := fEditorViewFactories[i] as IEditorViewFactory;

      // Add MenuItem
      MenuItem := TSpTBXItem.Create(nil); // will be freed by the Parent Item
      MenuItem.Hint := ViewFactory.Hint;
      MenuItem.ImageIndex := IL.GetIndexByName(ViewFactory.ImageName);
      MenuItem.Caption := ViewFactory.MenuCaption;
      MenuItem.ShortCut := ViewFactory.ShortCut;
      MenuItem.OnClick := OnEditorViewClick;
      MenuItem.Tag := i;

      ViewsMenu.Add(MenuItem);
    end;
  finally
    fEditorViewFactories.UnLock;
  end;
end;

procedure TEditorFactory.UpdateEditorViewsMenu(ViewsMenu: TSpTBXItem);
var
  i, j: Integer;
  Editor: IEditor;
  ViewFactory: IEditorViewFactory;
  List: TList;
  Enabled: Boolean;
begin
  fEditorViewFactories.Lock;
  List := TList.Create;
  try
    for i := 0 to fEditorViewFactories.Count - 1 do
    begin
      Editor := GI_PyIDEServices.ActiveEditor;
      Enabled := Assigned(Editor);
      if Enabled then
      begin
        ViewFactory := fEditorViewFactories[i] as IEditorViewFactory;
        ViewFactory.GetContextHighlighters(List);
        if List.Count > 0 then
        begin
          Enabled := False;
          for j := 0 to List.Count - 1 do
          begin
            if List[j] = Editor.SynEdit.Highlighter then
            begin
              Enabled := True;
              Break;
            end;
          end;
        end;
        List.Clear;
      end;
      ViewsMenu.Items[i].Enabled := Enabled;
    end;
  finally
    List.Free;
    fEditorViewFactories.UnLock;
  end;
end;

{ TEditorForm }

procedure TEditorForm.FormDestroy(Sender: TObject);
begin
  if Assigned(SourceScanner) then
    SourceScanner.StopScanning;
  SourceScanner := nil;
  if Assigned(Partner) then
    Partner.Close;
  if Assigned(fEditor) then
    fEditor.fForm := nil;

  FoundSearchItems.Free;
  FreeAndNil(TVFileStructure);
  FreeAndNil(Model);

  // PyIDEOptions change notification
  PyIDEOptions.OnChange.RemoveHandler(ApplyPyIDEOptions);

  if SynEdit2.IsChained then
    SynEdit2.RemoveLinesPointer;

  if BreakPoints.Count > 0 then
  begin
    PyControl.BreakPointsChanged := True;
    BreakPointsWindow.UpdateWindow;
  end;
  BreakPoints.Free;

  GI_EditorFactory.RemoveFile(IEditor(fEditor));
  inherited;
end;

procedure TEditorForm.SynEditChange(Sender: TObject);
begin
  if PyControl.ErrorPos.Editor = GetEditor then
    PyControl.ErrorPos := TEditorPos.EmptyPos;

  ClearSearchHighlight(FEditor);
  fNeedToParseModule:= True; // at every change of the source code
end;

procedure TEditorForm.SynEditDblClick(Sender: TObject);
var
  ptMouse: TPoint;
  ASynEdit: TSynEdit;
begin
  ASynEdit := Sender as TSynEdit;
  GetCursorPos(ptMouse);
  ptMouse := ASynEdit.ScreenToClient(ptMouse);
  if (ptMouse.X >= ASynEdit.GutterWidth + 2)
    and ASynEdit.SelAvail and PyIDEOptions.HighlightSelectedWord
  then
    CommandsDataModule.HighlightWordInActiveEditor(ASynEdit.SelText);
end;

procedure TEditorForm.ShowTkOrQt;
begin
  var PC:= PyIDEMainForm.TabControlWidgets;
  PC.TabClick(TSpTBXTabItem(PC.Items[0]));
  if FrameType in [0, 1] then begin
    PC.Items[1].Visible:= FConfiguration.VisTabs[1];
    PC.Items[2].Visible:= FConfiguration.VisTabs[2];
    PC.Items[3].Visible:= FConfiguration.VisTabs[3];
    PC.Items[4].Visible:= FConfiguration.VisTabs[4];
  end else if FrameType = 2 then begin
    PC.Items[1].Visible:= FConfiguration.VisTabs[1];
    PC.Items[2].Visible:= FConfiguration.VisTabs[2];
    PC.Items[3].Visible:= False;
    PC.Items[4].Visible:= False;
    PC.TabClick(TSpTBXTabItem(PC.Items[1]));
  end else if FrameType = 3 then begin
    PC.Items[1].Visible:= False;
    PC.Items[2].Visible:= False;
    PC.Items[3].Visible:= FConfiguration.VisTabs[3];
    PC.Items[4].Visible:= FConfiguration.VisTabs[4];
    PC.TabClick(TSpTBXTabItem(PC.Items[3]));
  end;
  case FrameType of
    2: CreateTkCursors;
    3: CreateQtCursors;
  end;
end;

procedure TEditorForm.SynEditEnter(Sender: TObject);
var
  ASynEdit: TSynEdit;
begin
  EditorSearchOptions.InitSearch;
  ASynEdit := Sender as TSynEdit;
  fActiveSynEdit := ASynEdit;
  fOldCaretY := ASynEdit.CaretY;
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
  //Enter(Self);
  DoAssignInterfacePointer(True);
  with ResourcesDataModule.CodeTemplatesCompletion do
  begin
    Editor := ASynEdit;
    OnBeforeExecute := AutoCompleteBeforeExecute;
    OnAfterExecute := AutoCompleteAfterExecute;
  end;

  if ASynEdit.Highlighter is TSynWebBase then
  begin
    // SynCodeCompletion
    CommandsDataModule.SynCodeCompletion.Editor := nil;
    CommandsDataModule.SynCodeCompletion.OnExecute := nil;
    CommandsDataModule.SynCodeCompletion.OnAfterCodeCompletion := nil;
    CommandsDataModule.SynCodeCompletion.OnAfterCodeCompletion := nil;
    CommandsDataModule.SynCodeCompletion.OnCodeItemInfo := nil;
    CommandsDataModule.SynCodeCompletion.Images := vilCodeImages;
    // SynParamCompletion
    CommandsDataModule.SynParamCompletion.Editor := nil;
    CommandsDataModule.SynParamCompletion.OnExecute := nil;
    // SynWebCompletion
    CommandsDataModule.SynWebCompletion.Editor := ASynEdit;
    CommandsDataModule.SynWebCompletion.OnExecute := SynWebCompletionExecute;
    CommandsDataModule.SynWebCompletion.OnAfterCodeCompletion := SynWebCompletionAfterCodeCompletion;
  end
  else
  begin
    // SynCodeCompletion
    CommandsDataModule.SynCodeCompletion.Editor := ASynEdit;
    CommandsDataModule.SynCodeCompletion.OnExecute := SynCodeCompletionExecute;
    CommandsDataModule.SynCodeCompletion.OnAfterCodeCompletion := SynCodeCompletionAfterCodeCompletion;
    CommandsDataModule.SynCodeCompletion.OnClose := SynCodeCompletionClose;
    CommandsDataModule.SynCodeCompletion.OnCodeItemInfo := SynCodeCompletionCodeItemInfo;
    CommandsDataModule.SynCodeCompletion.Images := vilCodeImages;
    // SynParamCompletion
    CommandsDataModule.SynParamCompletion.Editor := ASynEdit;
    CommandsDataModule.SynParamCompletion.OnExecute := SynParamCompletionExecute;
    // SynWebCompletion
    CommandsDataModule.SynWebCompletion.Editor := nil;
    CommandsDataModule.SynWebCompletion.OnExecute := nil;
    CommandsDataModule.SynWebCompletion.OnAfterCodeCompletion := nil;
  end;

  if {(fOldEditorForm <> Self) and }not GI_PyIDEServices.IsClosing then
    CodeExplorerWindow.UpdateWindow(fEditor.FSynLsp.DocSymbols, ceuEditorEnter);
  fOldEditorForm := Self;
  // Search and Replace Target
  EditorSearchOptions.InterpreterIsSearchTarget := False;
  EditorSearchOptions.TextDiffIsSearchTarget := False;
  PyIDEMainForm.UpdateCaption;
  SynEdit.Options:= SynEdit.Options + [eoDropFiles, eoNoHTMLBackground];
end;

procedure TEditorForm.SynEditExit(Sender: TObject);
begin
  // The following create problems
  // CommandsDataModule.ParameterCompletion.Editor := nil;
  // CommandsDataModule.ModifierCompletion.Editor := nil;
  // CommandsDataModule.CodeTemplatesCompletion.Editor := nil;
  DoAssignInterfacePointer(False);

  if fHotIdentInfo.HaveHotIdent then
  begin
    fHotIdentInfo.HaveHotIdent := False;
    (Sender as TCustomSynEdit).Indicators.Clear(HotIdentIndicatorSpec, True,
      fHotIdentInfo.StartCoord.Line);
    SetCursor(TCustomSynEdit(Sender).Cursor);
  end;

  PyIDEMainForm.mnEditCopy.Action:= CommandsDataModule.actEditCopy;
  mnEditCopy.Action:= CommandsDataModule.actEditCopy;

  PyIDEMainForm.mnEditPaste.Action:= CommandsDataModule.actEditPaste;
  mnEditPaste.Action:= CommandsDataModule.actEditPaste;
end;

procedure TEditorForm.SynEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
var
  ASynEdit: TSynEdit;
  NewCaretY: Integer;
begin
  ASynEdit := Sender as TSynEdit;
  Assert(fEditor <> nil);
  if scModified in Changes then
  begin
    PyIDEMainForm.UpdateCaption;
    ParentTabItem.Invalidate;
  end;
  if scCaretY in Changes then begin
    fNeedToSyncCodeExplorer := True;
    fNeedToSyncFileStructure := True;
    fCloseBracketChar := #0;
    fEditor.RefreshSymbols;
  end;
  if (scCaretY in Changes) and ASynEdit.Gutter.Visible
    and ASynEdit.Gutter.ShowLineNumbers
    and PyIDEOptions.CompactLineNumbers then
  begin
    NewCaretY := ASynEdit.CaretY;
    ASynEdit.InvalidateGutterLine(fOldCaretY);
    ASynEdit.InvalidateGutterLine(NewCaretY);
    fOldCaretY := NewCaretY;
  end;
  if scTopLine in Changes then
    Application.CancelHint;
end;

procedure TEditorForm.DoActivate;
begin
  ParentTabItem.Checked := True;
end;

procedure TEditorForm.DoActivateEditor(Primary: Boolean = True);
var
  ASynEdit: TSynEdit;
begin
  DoActivate;
  ViewsTabControl.ActiveTabIndex := 0;
  if Primary then
    ASynEdit := SynEdit
  else
    ASynEdit := ActiveSynEdit;
  if CanActuallyFocus(ASynEdit) then
    ASynEdit.SetFocus;
end;

function TEditorForm.DoActivateView(ViewFactory: IEditorViewFactory)
  : IEditorView;
var
  i: Integer;
  Form: TCustomForm;
  Tab: TSpTBXTabItem;
  TabSheet: TSpTBXTabSheet;
begin
  Result := nil;
  DoActivate;
  // Does the EditorView tab exist?
  Result := nil;
  for i := 0 to ViewsTabControl.PagesCount - 1 do
    if ViewsTabControl.Pages[i].Caption = ViewFactory.TabCaption then
    begin
      ViewsTabControl.ActiveTabIndex := i;
      Result := ViewsTabControl.Pages[i].Components[0] as IEditorView;
      Break;
    end;
  if not Assigned(Result) then
  begin
    // Editor View does not exist - Create
    Tab := ViewsTabControl.Add(ViewFactory.TabCaption);
    TabSheet := ViewsTabControl.GetPage(Tab);
    try
      Form := ViewFactory.CreateForm(fEditor, TabSheet);
      with Form do
      begin
        BorderStyle := bsNone;
        Parent := TabSheet;
        Align := alClient;
        Visible := True;
        // Form.SetFocus;
        Result := Form as IEditorView;
      end;
      // fix for Delphi 4 (???)
      // Form.Realign;
      Tab.Checked := True;
    except
      Tab.Free;
      raise ;
    end;
  end;

  ViewsTabControl.TabVisible := True;
end;

function TEditorForm.DoAskSaveChanges: Boolean;
begin
  fModified:= SynEdit.Modified;
  Result:= inherited;
end;

procedure TEditorForm.DoAssignInterfacePointer(AActive: Boolean);
begin
  if AActive then
  begin
    GI_ActiveEditor := fEditor;
    GI_EditCmds := fEditor;
    GI_FileCmds := fEditor;
    GI_SearchCmds := fEditor;
  end
  else
  begin
    if GI_ActiveEditor = IEditor(fEditor) then
      GI_ActiveEditor := nil;
    if GI_EditCmds = IEditCommands(fEditor) then
      GI_EditCmds := nil;
    if GI_FileCmds = IFileCommands(fEditor) then
      GI_FileCmds := nil;
    if GI_SearchCmds = ISearchCommands(fEditor) then
      GI_SearchCmds := nil;
  end;
end;

procedure TEditorForm.Enter(Sender: TObject);
begin
  DoUpdateCaption;
  fOldEditorForm:= Self;
  SetOptions;
  ShowTkOrQt;
  if Assigned(Partner) then
    FGUIDesigner.ChangeTo(TFGUIForm(Partner));
  if Assigned(TVFileStructure) and (FFileStructure.myForm <> Self) and
     Assigned(TVFileStructure.Items) then
    FFileStructure.init(TVFileStructure.Items, Self);
end;

procedure TEditorForm.CollapseGUICreation;
  var i, Line: Integer;
begin
  if PyIDEOptions.CodeFoldingForGuiElements and (DefaultExtension = 'pyw') then begin
    for i:= 0 to Min(SynEdit.AllFoldRanges.Count - 1, 2) do begin
      Line:= SynEdit.AllFoldRanges[i].FromLine;
      if Pos('def __init__(self):', SynEdit.Lines[Line-1]) > 0 then
        SynEdit.Collapse(i);
      if Pos('def create_widgets(self):', SynEdit.Lines[Line-1]) > 0 then
        SynEdit.Collapse(i)
    end;
  end;
end;

function TEditorForm.isGUICreationCollapsed: Boolean;
  var i, Line: Integer;
begin
  Result:= False;
  if DefaultExtension = 'pyw' then begin
    for i:= 0 to Min(SynEdit.AllFoldRanges.Count - 1, 2) do begin
      Line:= SynEdit.AllFoldRanges[i].FromLine;
      if Pos('def create_widgets(self):', SynEdit.Lines[Line-1]) > 0 then
        Result:= SynEdit.AllFoldRanges.Ranges.List[i].Collapsed;
    end;
  end;
end;

function TEditorForm.DoSave: Boolean;
begin
  Assert(fEditor <> nil);
  if (fEditor.fFileName <> '') or (fEditor.fRemoteFileName <> '') then
  begin
    Result := DoSaveFile;
    if Result then
      FEditor.FSynLsp.FileSaved;
  end
  else
    Result := DoSaveAs;
end;

function TEditorForm.DoSaveFile: Boolean;
var
  Line, TrimmedLine: string;
begin
  // Trim all lines just in case (Issue 196)
  if (SynEdit.Lines.Count > 0) and ((eoTrimTrailingSpaces in SynEdit.Options) or
    PyIDEOptions.TrimTrailingSpacesOnSave)  then
  begin
    SynEdit.BeginUpdate;
    try
      for var I := 0 to SynEdit.Lines.Count - 1 do
      begin
        Line := SynEdit.Lines[I];
        TrimmedLine := TrimRight(Line);
        if Line <> TrimmedLine then
          SynEdit.Lines[I] := TrimmedLine;
      end;

      if (SynEdit.Lines.Count > 1) and (Pos('# Name:', SynEdit.Lines[1]) = 1) then
        SynEdit.Lines[1]:= '# Name:         ' + ExtractFilename(fEditor.fFileName);
    finally
      SynEdit.EndUpdate;
    end;
  end;
  Result := False;
  if fEditor.fFileName <> '' then begin
    Result := SaveWideStringsToFile(fEditor.fFileName, SynEdit.Lines,
      PyIDEOptions.CreateBackupFiles);
    if Result then begin
      if not FileAge(fEditor.fFileName, FileTime) then
        FileTime := 0;
    end else begin

    end
  end else if fEditor.fRemoteFileName <> '' then
     Result := fEditor.SaveToRemoteFile(fEditor.fRemoteFileName, fEditor.fSSHServer);
  if Result then
  begin
    if not PyIDEOptions.UndoAfterSave then
      SynEdit.ClearUndo;
    SynEdit.MarkSaved;
    SynEdit.Modified := False;
  end;
  if Assigned(Partner) then TFGuiForm(Partner).Save(False);
end;

function TEditorForm.DoSaveAs: Boolean;
var
  NewName: string;
  Edit: IEditor;
begin
  Assert(fEditor <> nil);
  NewName := fEditor.GetFileId;
  if (fEditor.GetFileName = '') and (DefaultExtension <> '') and
    (ExtractFileExt(NewName) = '') then
    NewName := NewName + '.' + DefaultExtension;
  if ResourcesDataModule.GetSaveFileName(NewName, SynEdit.Highlighter,
    DefaultExtension) then
  begin
    Edit := GI_EditorFactory.GetEditorByName(NewName);
    if Assigned(Edit) and (Edit <> Self.fEditor as IEditor) then
    begin
      StyledMessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    fEditor.DoSetFileName(NewName);
    DoUpdateHighlighter;
    DoUpdateCaption; // Do it twice in case the following statement fails
    Result := DoSaveFile;
    if Result and Assigned(Partner) then begin
      TFGUIForm(Partner).Pathname:= ChangeFileExt(Pathname, '.pfm');
      TFGuiForm(Partner).Save(False);
    end;
    DoUpdateCaption;

    if FEditor.HasPythonFile then
      FEditor.FSynLsp.FileSavedAs(FEditor.GetFileId, lidPython)
    else
      FEditor.FSynLsp.FileSavedAs(FEditor.GetFileId, lidNone);
  end
  else
    Result := False;
end;

function TEditorForm.DoSaveAsRemote: Boolean;
var
  FileName, Server : string;
  Edit : IEditor;
begin
  Assert(fEditor <> nil);
  if fEditor.fFileName <> '' then
    FileName := TPath.GetFileName(fEditor.fFileName)
  else if fEditor.fRemoteFileName <> '' then
    FileName := fEditor.fRemoteFileName;
  if ExecuteRemoteFileDialog(FileName, Server, rfdSave) then
  begin
    Edit := GI_EditorFactory.GetEditorByName(TSSHFileName.Format(Server, FileName));
    if Assigned(Edit) and (Edit <> Self.fEditor as IEditor) then
    begin
      StyledMessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    fEditor.fRemoteFileName := FileName;
    fEditor.fSSHServer := Server;
    fEditor.DoSetFileName('');
    DoUpdateHighlighter;
    Result := DoSaveFile;
    DoUpdateCaption;

    if FEditor.HasPythonFile then
      FEditor.FSynLsp.FileSavedAs(FEditor.GetFileId, lidPython)
    else
      FEditor.FSynLsp.FileSavedAs(FEditor.GetFileId, lidNone);
  end
  else
    Result := False;
end;

function TEditorForm.OpenFile(const aFilename: string): Boolean;
begin
  Result:= True;
  try
    fEditor.OpenFile(aFilename);
  except
    Result:= False;
  end;
end;

procedure TEditorForm.setModified(Value: Boolean);
begin
  if FModified <> Value then begin
    inherited;
    ActiveSynEdit.Modified:= Value;
  end;
end;

function TEditorForm.getModified: Boolean;
begin
  if ActiveSynEdit <> nil
    then Result:= ActiveSynEdit.Modified
    else Result:= False;
end;

procedure TEditorForm.DoUpdateHighlighter(HighlighterName: string = '');
begin
  Assert(fEditor <> nil);
  if HighlighterName <> '' then
    SynEdit.Highlighter :=
      ResourcesDataModule.Highlighters.HighlighterFromFriendlyName(HighlighterName)
  else if fEditor.fFileName <> '' then
    SynEdit.Highlighter :=
      ResourcesDataModule.Highlighters.HighlighterFromFileName(fEditor.fFileName)
  else if fEditor.fRemoteFileName <> '' then
    SynEdit.Highlighter :=
      ResourcesDataModule.Highlighters.HighlighterFromFileName(fEditor.fRemoteFileName)
  else // No highlighter otherwise
    SynEdit.Highlighter := nil;

  SynEdit2.Highlighter := SynEdit.Highlighter;

  // Set DefaultExtension
  if SynEdit.Highlighter <> nil then
    //DefaultExtension := DefaultExtensionFromFilter(SynEdit.Highlighter.DefaultFilter)
    DefaultExtension:= Copy(LowerCase(TPath.getExtension(Pathname)), 2, 20)
  else
    DefaultExtension := '';
  SynEdit.UseCodeFolding := PyIDEOptions.CodeFoldingEnabled;
  SynEdit2.UseCodeFolding := SynEdit.UseCodeFolding;
end;

function TEditorForm.GetFileFormat: string;
begin
  var ASynEdit := ActiveSynEdit;
  var Encoding:= UpperCase(ASynEdit.Lines.Encoding.EncodingName);
  if Pos('ANSI', Encoding) > 0 then Encoding:= 'ANSI' else
  if Pos('ASCII', Encoding) > 0 then Encoding:= 'ASCII' else
  if Pos('UTF-8', Encoding) > 0 then Encoding:= 'UTF-8' else
  if Pos('UTF-16', Encoding) > 0 then Encoding:= 'UTF-16' else
  if Pos('UNICODE', Encoding) > 0 then Encoding:= 'UTF-16' else
  if Pos('CP1252', Encoding) > 0 then Encoding:= 'ANSI';
  var LineBreak:= ASynEdit.Lines.LineBreak;
  if LineBreak = #13#10 then LineBreak:= 'Windows' else
  if LineBreak = #10 then LineBreak:= 'Unix'
  else LineBreak:= 'Mac';
  Result:= Encoding + '/' + LineBreak;
end;

procedure TEditorForm.EditorCommandHandler(Sender: TObject;
  AfterProcessing: Boolean; var Handled: Boolean;
  var Command: TSynEditorCommand; var AChar: WideChar;
  Data, HandlerData: Pointer);
var
  ASynEdit: TSynEdit;
  iPrevLine: string;
  Position, Len: Integer;
  OpenBrackets, CloseBrackets: string;
  OpenBracketPos: Integer;
  Line: string;
  CharRight, CharLeft: WideChar;
  Caret: TBufferCoord;
begin
  ASynEdit := Sender as TSynEdit;
  if (Command <> ecLostFocus) and (Command <> ecGotFocus) then
    EditorSearchOptions.InitSearch;
  if Command <> ecChar then
    fCloseBracketChar := #0;

  if not AfterProcessing then
  begin
    if (Command <> ecCancelSelections) and (ASynEdit.Selections.Count > 1) then
      Exit;

    case Command of
      ecCodeCompletion:
        if ASynEdit.Highlighter is TSynPythonSyn then
        begin
          if CommandsDataModule.SynCodeCompletion.Form.Visible then
            CommandsDataModule.SynCodeCompletion.CancelCompletion;
          DoCodeCompletion(ASynEdit, ASynEdit.CaretXY);
          Handled := True;
        end else if ASynEdit.Highlighter is TSynWebBase then
          CommandsDataModule.SynWebCompletion.ActivateCompletion;
      ecParamCompletion:
        if ASynEdit.Highlighter is TSynPythonSyn then
        begin
          if CommandsDataModule.SynParamCompletion.Form.Visible then
            CommandsDataModule.SynParamCompletion.CancelCompletion;
          CommandsDataModule.SynParamCompletion.ActivateCompletion;
          Handled := True;
        end;
      ecCancelSelections:
        ClearSearchHighlight(FEditor);
    end;
  end
  else
  begin // AfterProcessing
    case Command of
      ecLineBreak: // Python Mode
        if ASynEdit.InsertMode and (eoAutoIndent in ASynEdit.Options)
          and (ASynEdit.Highlighter is TSynPythonSyn)
          and (ASynEdit.Selections.Count = 1)
          and not fAutoCompleteActive
        then
        begin
          { CaretY should never be less than 2 right after ecLineBreak, so there's
            no need for a check }
          iPrevLine := TrimRight(ASynEdit.Lines[ASynEdit.CaretY - 2]);

          //BC := BufferCoord(Length(iPrevLine), ASynEdit.CaretY - 1);
          // Indent on: if a: # success?
          //if ASynEdit.GetHighlighterAttriAtRowCol(BC, DummyToken, Attr) and not
          //  ( // (attr = ASynEdit.Highlighter.StringAttribute) or
          //  (Attr = ASynEdit.Highlighter.CommentAttribute) or
          //    (Attr = TSynPythonSyn(ASynEdit.Highlighter).CodeCommentAttri) { or
          //    (attr = ResourcesDataModule.SynPythonSyn.DocStringAttri) } ) then
          //begin
          if TPyRegExpr.IsBlockOpener(iPrevLine) then
            ASynEdit.ExecuteCommand(ecTab, #0, nil)
          else if TPyRegExpr.IsBlockCloser(iPrevLine) then
            ASynEdit.ExecuteCommand(ecShiftTab, #0, nil);
          //end;
        end;
      ecChar:
        // Trigger auto-complection on completion trigger chars
        begin
          if PyIDEOptions.EditorCodeCompletion and (ASynEdit.Selections.Count = 1) then
          begin
            if (TIDECompletion.EditorCodeCompletion.CompletionInfo.Editor = nil)
              and (Pos(AChar, CommandsDataModule.SynCodeCompletion.TriggerChars) > 0)
              and not ResourcesDataModule.CodeTemplatesCompletion.Executing
            then
            begin
              Caret := ASynEdit.CaretXY;
              TThread.ForceQueue(nil, procedure
                begin
                  DoCodeCompletion(ASynEdit, Caret);
                end, IfThen(AChar = '.', 200,
                CommandsDataModule.SynCodeCompletion.TimerInterval));
            end;
          end;

          // Autocomplete brackets
          if not fAutoCompleteActive and PyIDEOptions.AutoCompleteBrackets and
             (ASynEdit.Selections.Count = 1)
          then
            with ASynEdit do
            begin
              if ASynEdit.Highlighter is TSynPythonSyn then
              begin
                OpenBrackets := '([{"''';
                CloseBrackets := ')]}"''';
              end
              else if (ASynEdit.Highlighter = ResourcesDataModule.SynWebHTMLSyn)
                or (ASynEdit.Highlighter = ResourcesDataModule.SynWebXMLSyn) or
                (ASynEdit.Highlighter = ResourcesDataModule.SynWebCssSyn) then
              begin
                OpenBrackets := '<"''';
                CloseBrackets := '>"''';
              end
              else
                Exit;

              Line := LineText;
              Len := Length(LineText);

              if AChar = fCloseBracketChar then
              begin
                if InsertMode and (CaretX <= Len) and
                  (Line[CaretX] = fCloseBracketChar) then
                  ExecuteCommand(ecDeleteChar, WideChar(#0), nil);
                fCloseBracketChar := #0;
              end
              else if CharInSet(AChar, [')', ']', '}']) then
              begin
                fCloseBracketChar := #0;
                Position := CaretX;
                if Position <= Len then
                  CharRight := Line[Position]
                else
                  CharRight := WideNull;
                if (AChar = CharRight) and (GetMatchingBracket.Line <= 0) then
                  ExecuteCommand(ecDeleteChar, #0, nil);
              end
              else
              begin
                //fCloseBracketChar := #0;
                OpenBracketPos := Pos(AChar, OpenBrackets);

                if (OpenBracketPos > 0) then
                begin
                  CharLeft := WideNull;
                  Position := CaretX - 2;
                  while (Position >= 1) and Highlighter.IsWhiteChar
                    (LineText[Position]) do
                    Dec(Position);
                  if Position >= 1 then
                    CharLeft := Line[Position];

                  if not (CharInSet(AChar, ['"', '''']) and (CharLeft = AChar)) then
                  begin
                    ExecuteCommand(ecChar, CloseBrackets[OpenBracketPos], nil);
                    CaretX := CaretX - 1;
                    if not CharInSet(AChar, [')', ']', '}']) then
                      fCloseBracketChar := CloseBrackets[OpenBracketPos];
                  end;
                end;
              end;
            end;
        end;
      ecSelWord:
        if ASynEdit.SelAvail and PyIDEOptions.HighlightSelectedWord then
          CommandsDataModule.HighlightWordInActiveEditor(ASynEdit.SelText);
      ecLostFocus:
        if not (CommandsDataModule.SynCodeCompletion.Form.Visible or SynEdit.Focused or SynEdit2.Focused) then
          CommandsDataModule.SynParamCompletion.CancelCompletion;
    end;
  end;
end;

procedure TEditorForm.ScrollbarAnnotationGetInfo(Sender: TObject;
  AnnType: TSynScrollbarAnnType; var Rows: TArray<Integer>;
  var Colors: TArray<TColor>);
begin
  Rows := [];
  Colors := [];
  if HasSyntaxError then
  begin
    var List := FEditor.FSynLsp.Diagnostics;
    if List.Count > 0 then
    begin
      Rows := [fActiveSynEdit.BufferToDisplayPos(List[0].BlockBegin).Row];
      Colors := [$3C14DC];
    end;
  end;
end;

class procedure TEditorForm.SymbolsChanged(Sender: TObject);
begin
  CodeExplorerWindow.UpdateWindow(Sender as TDocSymbols, ceuSymbolsChanged);
end;

procedure TEditorForm.SyncCodeExplorer;
begin
  if fNeedToSyncCodeExplorer and GetEditor.HasPythonFile then begin
    CodeExplorerWindow.ShowEditorCodeElement;
    fNeedToSyncCodeExplorer := False;
  end;
end;

procedure TEditorForm.SyncFileStructure;
begin
  if fNeedToSyncFileStructure and IsPython then begin
    FFileStructure.ShowEditorCodeElement(ActiveSynEdit.CaretY);
    fNeedToSyncFileStructure := False;
  end;
end;

function TEditorForm.ReparseIfNeeded: Boolean;
begin
  if fNeedToParseModule and GetEditor.HasPythonFile then begin
    fNeedToParseModule:= False;
    if Assigned(SourceScanner) then
      SourceScanner.StopScanning;
    SourceScanner:= AsynchSourceScannerFactory.CreateAsynchSourceScanner
      (fEditor.GetFileId, SynEdit.Text);  // ToDo asynchron?
    while not SourceScanner.Finished do
      Sleep(50);
    CreateModel;
    CreateTVFileStructure;
    Result:= True; // due to recursive call of ReparseIfNeeded
  end else begin
    SourceScanner:= nil;
    Result:= False;
  end;
end;

procedure TEditorForm.Retranslate;
begin
  RetranslateComponent(Self);
  TBIfStatement.Hint:= 'if-' + _('Statement');
  TBIfElseStatement.Hint:= 'if-else-' + _('Statement');
  TBWhileStatement.Hint:= 'while-' + _('Statement');
  TBForStatement.Hint:= 'for-' + _('Statement');
  TBIfElifStatement.Hint:= 'if-elif-' + _('Statement');
  TBTryStatement.Hint:= 'try-' + _('Statement');
end;

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  for var i:= TVFileStructure.Items.Count - 1 downto 0 do begin
    var aInteger:= TInteger(TVFileStructure.Items[i].Data);
    FreeAndNil(aInteger);
  end;
  FFileStructure.Clear(Self);
end;

procedure TEditorForm.FormCreate(Sender: TObject);
begin
  StyledBorderColors(BorderNormal, BorderHighlight);

  FGPanelExit(Self);

  SynEdit.OnReplaceText := CommandsDataModule.SynEditReplaceText;

  fHotIdentInfo.HaveHotIdent := False;

  ViewsTabControl.TabVisible := False;
  case PyIDEOptions.EditorsTabPosition of
    ttpTop:
      ViewsTabControl.TabPosition := ttpBottom;
    ttpBottom:
      ViewsTabControl.TabPosition := ttpTop;
  end;

  SynEdit2.SetLinesPointer(SynEdit);
  SynEdit.OnDropFiles:=  PyIDEMainForm.DropFiles;
  SynEdit2.OnDropFiles:= PyIDEMainForm.DropFiles;

  //  Custom command handling
  SynEdit.RegisterCommandHandler(EditorCommandHandler, nil);
  SynEdit2.RegisterCommandHandler(EditorCommandHandler, nil);

  BreakPoints := TObjectList.Create(True);
  TDebugSupportPlugin.Create(Self); // No need to free

  // Indicators
  var IndicatorSpec :=
    TSynIndicatorSpec.New(sisTextDecoration, clNoneF, clNoneF, [fsUnderline]);
  SynEdit.Indicators.RegisterSpec(HotIdentIndicatorSpec, IndicatorSpec);
  SynEdit2.Indicators.RegisterSpec(HotIdentIndicatorSpec, IndicatorSpec);

  // PyIDEOptions change notification
  PyIDEOptions.OnChange.AddHandler(ApplyPyIDEOptions);

  // Register Kernel Notification
  ChangeNotifier.RegisterKernelChangeNotify(Self, [vkneFileName, vkneDirName,
    vkneLastWrite, vkneCreation]);
  SkinManager.AddSkinNotification(Self);
  PyIDEMainForm.ThemeEditorGutter(SynEdit.Gutter);
  TranslateComponent(Self);

  // GuiPy
  SetOptions;
  PyIDEMainForm.ThemeEditorGutter(SynEdit.Gutter);
  Retranslate;
  fIndent1:= FConfiguration.Indent1;
  fIndent2:= FConfiguration.Indent2;
  fIndent3:= FConfiguration.Indent3;
  Model:= TObjectModel.Create;
  ChangeStyle;
end;

procedure TEditorForm.SynEditGutterGetText(Sender: TObject; aLine: Integer;
  var aText: string);
begin
  if aLine = TSynEdit(Sender).CaretY then
    Exit;

  if aLine mod 10 <> 0 then
    if aLine mod 5 <> 0 then
      aText := '·'
    else
      aText := '–';
end;

procedure TEditorForm.SynEditSpecialLineColors(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
var
  LI: TDebuggerLineInfos;
begin
  if PyControl.ActiveDebugger <> nil then
  begin
    LI := PyControl.GetLineInfos(fEditor, Line);
    if dlCurrentLine in LI then
    begin
      Special := True;     { TODO : Allow customization of these colors }
      FG := clWhite;
      BG := clBlue;
    end
    else if (dlErrorLine in LI) then
    begin
      Special := True;
      FG := clWhite;
      BG := clRed
    end;
  end;
end;

function TEditorForm.GetEditor: IEditor;
begin
  Result := fEditor;
end;

procedure TEditorForm.GoToSyntaxError;
begin
  if HasSyntaxError then
  begin
    var List := FEditor.FSynLsp.Diagnostics;
    if List.Count > 0 then
    begin
      var BB := List[0].BlockBegin;
      SynEdit.CaretXY := BufferCoord(BB.Char, BB.Line);
    end;
  end;
end;

function TEditorForm.HasSyntaxError: Boolean;
begin
  Result := fEditor.HasPythonFile and (FEditor.FSynLsp.Diagnostics.Count > 0);
end;

procedure TEditorForm.CreateStructogram;
  var s, aText, FileName: string; BufB, BufE: TBufferCoord; Indent, Line: Integer;
      Scanner: TPythonScannerWithTokens;
begin
  aText:= '';
  if ActiveSynEdit.SelAvail then begin
    BufB:= BufB.Min(ActiveSynEdit.BlockBegin, ActiveSynEdit.BlockEnd);
    BufE:= BufE.Max(ActiveSynEdit.BlockEnd, ActiveSynEdit.BlockEnd);
    Line:= BufB.Line;
    while Line <= BufE.Line do begin
      aText:= aText + ActiveSynEdit.Lines[Line-1] + Chr(10);
      Inc(Line);
    end;
  end else begin
    Mouse.CursorPos:= pmnuEditor.PopupPoint;
    ActiveSynEdit.GetPositionOfMouse(BufB);
    Line:= BufB.Line - 1;
    Indent:= CalcIndent(ActiveSynEdit.Lines[Line]);
    while Line < ActiveSynEdit.Lines.Count do begin
      s:= ActiveSynEdit.Lines[Line];
      if (CalcIndent(s) >= Indent) or (Trim(s) = '') then begin
        aText:= aText + s + Chr(10);
        Inc(Line);
      end else
        Break;
    end;
  end;
  if Trim(aText) <> '' then begin
    Scanner:= TPythonScannerWithTokens.Create;
    Scanner.Init(aText);
    FileName:= Scanner.getFilename;
    FreeAndNil(Scanner);
    if FileName <> ''
      then FileName:= extractFilePath(Pathname) + FileName + '.psg'
      else FileName:= ChangeFileExt(Pathname, '.psg');
    PyIDEMainForm.StructogramFromText(aText, FileName);
  end;
end;

procedure TEditorForm.SetOptions;
begin
  FConfiguration.setToolbarVisibility(EditFormToolbar, 2);
  SetToolButtons;
  if GuiPyOptions.LockedStructogram then
    mnEditCreateStructogram.Visible:= False;
end;

function TEditorForm.IsPython: Boolean;
begin
  Result:= (SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn);
end;

function TEditorForm.IsPythonAndGUI: Boolean;
begin
  Result:= IsPython and (DefaultExtension = 'pyw');
end;

function TEditorForm.IsHTML: Boolean;
begin
  Result:= (DefaultExtension = 'html') or (DefaultExtension = 'htm');
end;

function TEditorForm.IsCSS: Boolean;
begin
  Result:= (DefaultExtension = 'css');
end;

procedure TEditorForm.GotoLine(i: Integer);
begin
  if i = 0 then Exit;
  ActiveSynEdit.TopLine:= i;
  ActiveSynEdit.CaretX := 1;
  ActiveSynEdit.CaretY := i;
  ActiveSynEdit.EnsureCursorPosVisible;
end;

procedure TEditorForm.GotoWord(const s: string);
  var line: Integer;
begin
  with ActiveSynEdit do begin
    line:= getLineNumberWithWord(s);
    if (0 <= line) and (line <= Lines.Count - 1) then begin
      CaretX:= Pos(s, Lines[line]);
      CaretY:= line + 1;
    end;
  end;
end;

procedure TEditorForm.PutText(s: string; withCursor: Boolean = True);
  var p, OffX, OffY, x, y: Integer; s1: string;
      TmpOptions, OrigOptions: TSynEditorOptions;
      ChangedIndent, ChangedTrailing: Boolean;
begin
  TmpOptions := ActiveSynEdit.Options;
  OrigOptions := ActiveSynEdit.Options;
  ChangedIndent := eoAutoIndent in TmpOptions;
  ChangedTrailing := eoTrimTrailingSpaces in TmpOptions;

  if ChangedIndent then Exclude(TmpOptions, eoAutoIndent);
  if ChangedTrailing then Exclude(TmpOptions, eoTrimTrailingSpaces);

  if ChangedIndent or ChangedTrailing then
    ActiveSynEdit.Options := TmpOptions;

  p:= Pos('|', s);
  if p = 0 then
    withCursor:= False;

  if withCursor then begin
    OffY:= 0;
    s1:= Copy(s, 1, p-1);
    Delete(s, p, 1);
    p:= Pos(#13#10, s1);
    while p > 0 do begin
      Inc(OffY);
      Delete(s1, 1, p+1);
      p:= Pos(#13#10, s1);
    end;
    OffX:= Length(s1) + 1;
    with ActiveSynEdit do begin
      if SelText = '' then begin
        x:= CaretX;
        y:= CaretY;
      end else begin
        x:= BlockBegin.Char;
        y:= BlockBegin.Line;
      end;
      SelText:= s;
      CaretY:= y + OffY;
      if OffY = 0
        then CaretX:= x + OffX - 1
        else CaretX:= OffX;
    end;
  end else
    ActiveSynEdit.SelText:= s;
  ActiveSynEdit.EnsureCursorPosVisible;
  if ChangedIndent or ChangedTrailing then ActiveSynEdit.Options := OrigOptions;
end;

function TEditorForm.getGeometry: TPoint;
  var p, line: Integer; s, sx, sy: string;
begin
  Result.X:= 300;
  Result.Y:= 300;
  if FrameType = 2 then begin
    line:= getLineNumberWith('self.root.geometry');
    if line >= 0 then begin
      s:= ActiveSynEdit.Lines[line];
      p:= Pos('(', s);
      Delete(s, 1, p+1);
      p:= Pos('x', s);
      sx:= Copy(s, 1, p-1);
      Delete(s, 1, p);
      p:= Pos(')', s);
      sy:= Copy(s, 1, p-2);
    end;
  end else begin
    line:= getLineNumberWith('self.resize');
    if line >= 0 then begin
      s:= ActiveSynEdit.Lines[line];
      p:= Pos('(', s);
      Delete(s, 1, p);
      p:= Pos(',', s);
      sx:= Copy(s, 1, p-1);
      Delete(s, 1, p);
      p:= Pos(')', s);
      sy:= Copy(s, 1, p-1);
    end;
  end;

  if sx <> '' then
    TryStrToInt(sx, Result.X);
  if sy <> '' then
    TryStrToInt(sy, Result.Y);
end;

function TEditorForm.getIndent: string;
  var Ind: Integer;
begin
  if ActiveSynEdit.SelText = ''
    then Ind:= ActiveSynEdit.CaretX - 1
    else Ind:= ActiveSynEdit.BlockBegin.Char;
  Result:= StringOfChar(' ', Ind);
end;

procedure TEditorForm.SynEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Cancel Code Hint when the Ctrl key is depressed
  Application.CancelHint;
end;

procedure TEditorForm.SynEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if fHotIdentInfo.HaveHotIdent then
  begin
    fHotIdentInfo.HaveHotIdent := False;
    (Sender as TCustomSynEdit).Indicators.Clear(HotIdentIndicatorSpec, True,
      fHotIdentInfo.StartCoord.Line);
    SetCursor(TCustomSynEdit(Sender).Cursor);
  end;
end;

procedure TEditorForm.SynEditMouseCursor(Sender: TObject;
  const aLineCharPos: TBufferCoord; var aCursor: TCursor);
var
  TokenType, Start: Integer;
  Token: string;
  Attri: TSynHighlighterAttributes;
  OldHotIdent: Boolean;
  OldStartCoord: TBufferCoord;
  ASynEdit: TSynEdit;
begin
  ASynEdit := Sender as TSynEdit;
  OldHotIdent := fHotIdentInfo.HaveHotIdent;
  OldStartCoord := fHotIdentInfo.StartCoord;

  fHotIdentInfo.HaveHotIdent := False;
  if ASynEdit.Focused and (HiWord(GetAsyncKeyState(VK_CONTROL)) > 0)
    and fEditor.HasPythonFile and
    not ASynEdit.IsPointInSelection(aLineCharPos)
  then
    with ASynEdit do
    begin
      GetHighlighterAttriAtRowColEx(aLineCharPos, Token, TokenType, Start,
        Attri);
      if (Attri = TSynPythonSyn(Highlighter).IdentifierAttri) or
        (Attri = TSynPythonSyn(Highlighter).NonKeyAttri) or
        (Attri = TSynPythonSyn(Highlighter).SystemAttri) then
      begin
        aCursor := crHandPoint;
        with fHotIdentInfo do
        begin
          HaveHotIdent := True;
          StartCoord := BufferCoord(Start, aLineCharPos.Line);
        end;
      end;
    end;
    if (OldHotIdent <> fHotIdentInfo.HaveHotIdent) or
      (OldStartCoord <> fHotIdentInfo.StartCoord) then
    begin
      if OldHotIdent then
        ASynEdit.Indicators.Clear(HotIdentIndicatorSpec, True,
          OldStartCoord.Line);
      if fHotIdentInfo.HaveHotIdent then
        ASynEdit.Indicators.Add(fHotIdentInfo.StartCoord.Line,
          TSynIndicator.New(HotIdentIndicatorSpec,
            fHotIdentInfo.StartCoord.Char,
            fHotIdentInfo.StartCoord.Char + Token.Length));
    end;
end;

procedure TEditorForm.SynEditMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EditorSearchOptions.InitSearch;
  if PyControl.ErrorPos.Editor = GetEditor then
    PyControl.ErrorPos := TEditorPos.EmptyPos;

  if fHotIdentInfo.HaveHotIdent then
  begin
    // fHodIdentInfo is reset in the KeyUp handler
    PostMessage(Application.MainForm.Handle, WM_FINDDEFINITION,
      fHotIdentInfo.StartCoord.Char, fHotIdentInfo.StartCoord.Line);
  end;
  if CommandsDataModule.SynParamCompletion.Form.Visible then
    CommandsDataModule.SynParamCompletion.CancelCompletion;
end;

procedure TEditorForm.FGPanelEnter(Sender: TObject);
begin
  HasFocus := True;
  BGPanel.Color := BorderHighlight;
end;

procedure TEditorForm.FGPanelExit(Sender: TObject);
begin
  HasFocus := False;
  BGPanel.Color := BorderNormal;
end;

procedure TEditorForm.mnCloseTabClick(Sender: TObject);
begin
  if ViewsTabControl.ActivePage <> tbshSource then
  begin
    ViewsTabControl.ActivePage.Free;
    if ViewsTabControl.PagesCount = 1 then
    begin
      ViewsTabControl.TabVisible := False;
    end;
  end;
end;

procedure TEditorForm.mnEditConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('Editor');
end;

procedure TEditorForm.mnEditCopyPathnameClick(Sender: TObject);
begin
  Clipboard.AsText:= Pathname;
end;

procedure TEditorForm.mnEditAddImportsClick(Sender: TObject);
begin
  var FileName:= ExtractFilename(Pathname);
  var SL:= FConfiguration.getClassesAndFilename(Pathname);
  for var i:= 0 to SL.Count - 1 do begin
     if SL.ValueFromIndex[i] <> FileName then begin
       var RegEx:= CompiledRegEx('\W' + SL.KeyNames[i] + '\W');
       if RegEx.IsMatch(ActiveSynedit.Text) then
         InsertImport('from ' + ChangeFileExt(SL.ValueFromIndex[i], '') +
                      ' import ' + SL.KeyNames[i]);
     end;
  end;
  FreeAndNil(SL);
end;

procedure TEditorForm.mnFontClick(Sender: TObject);
  var FontDialog: TFontDialog;
begin
  FontDialog:= TFontDialog.Create(Self);
  FontDialog.font.Assign(ActiveSynEdit.Font);
  if FontDialog.Execute then begin
    ActiveSynEdit.Font.Assign(FontDialog.Font);
    FConfiguration.labFont.Font.Assign(ActiveSynEdit.Font);
  end;
  FreeAndNil(FontDialog);
end;

procedure TEditorForm.mnGitExecute(Sender: TObject);
begin
  FGit.Execute(TSpTBXItem(Sender).Tag, GetEditor);
end;

procedure TEditorForm.WMFolderChangeNotify(var Msg: TMessage);
begin
  if fEditor.fFileName <> '' then
    TThread.ForceQueue(nil, procedure
    begin
      CommandsDataModule.ProcessFolderChange(TPath.GetDirectoryName(fEditor.fFileName));
    end, 200);
end;

procedure TEditorForm.AddWatchAtCursor;
var
  Token, LineTxt, DottedIdent: string;
  Attri: TSynHighlighterAttributes;
  aLineCharPos: TBufferCoord;
begin
  aLineCharPos := SynEdit.CaretXY;
  if SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn then
    with SynEdit do
    begin
      GetHighlighterAttriAtRowCol(aLineCharPos, Token, Attri);
      if (Attri = ResourcesDataModule.SynPythonSyn.IdentifierAttri) or
        (Attri = ResourcesDataModule.SynPythonSyn.NonKeyAttri) or
        (Attri = ResourcesDataModule.SynPythonSyn.SystemAttri) or
        ((Token = ')') or (Token = ']')) then
      begin
        LineTxt := Lines[aLineCharPos.Line - 1];
        DottedIdent := GetWordAtPos(LineTxt, aLineCharPos.Char,
          True, True, False, True);
        DottedIdent := DottedIdent + GetWordAtPos(LineTxt,
          aLineCharPos.Char + 1, False, False, True);
        if DottedIdent <> '' then
          WatchesWindow.AddWatch(DottedIdent);
      end;
    end;
end;

procedure TEditorForm.mnUpdateViewClick(Sender: TObject);
var
  TabCaption: string;
  i: Integer;
  ViewFactory: IEditorViewFactory;
  EditorView: IEditorView;
begin
  if ViewsTabControl.ActivePage <> tbshSource then
  begin
    TabCaption := ViewsTabControl.ActivePage.Caption;
    ViewFactory := nil;
    for i := 0 to GI_EditorFactory.ViewFactoryCount - 1 do
    begin
      if GI_EditorFactory.ViewFactory[i].TabCaption = TabCaption then
      begin
        ViewFactory := GI_EditorFactory.ViewFactory[i];
        Break;
      end;
    end;
    if Assigned(ViewFactory) then
    begin
      EditorView := fEditor.ActivateView(ViewFactory);
      if Assigned(EditorView) then
        EditorView.UpdateView(fEditor);
    end;
  end;
end;

procedure TEditorForm.ApplyEditorOptions;
begin
  SynEdit.Assign(EditorOptions);
  SynEdit2.Assign(EditorOptions);

  SynEdit.BracketsHighlight.SetFontColorsAndStyle(
    ResourcesDataModule.SynPythonSyn.MatchingBraceAttri.Foreground,
    ResourcesDataModule.SynPythonSyn.UnbalancedBraceAttri.Foreground, [fsBold]);
  SynEdit2.BracketsHighlight.SetFontColorsAndStyle(
    ResourcesDataModule.SynPythonSyn.MatchingBraceAttri.Foreground,
    ResourcesDataModule.SynPythonSyn.UnbalancedBraceAttri.Foreground, [fsBold]);
end;

procedure TEditorForm.ApplyPyIDEOptions;
  procedure  ApplyOptionsToEditor(Editor: TCustomSynEdit);
  begin
    Editor.CodeFolding.Assign(PyIDEOptions.CodeFolding);
    Editor.SelectedColor.Assign(PyIDEOptions.SelectionColor);
    Editor.IndentGuides.Assign(PyIDEOptions.IndentGuides);
    Editor.DisplayFlowControl.Assign(PyIDEOptions.DisplayFlowControl);
    Editor.Gutter.TrackChanges.Assign(PyIDEOptions.TrackChanges);

    if PyIDEOptions.CompactLineNumbers then
      Editor.OnGutterGetText := SynEditGutterGetText
    else
      Editor.OnGutterGetText := nil;
    Editor.InvalidateGutter;

    if PyIDEOptions.ScrollbarAnnotation then
    begin
      Editor.ScrollbarAnnotations.SetDefaultAnnotations;
      with Editor.ScrollbarAnnotations.Add as TSynScrollbarAnnItem do
      begin
        AnnType := sbaCustom1;
        AnnPos := sbpFullWidth;
        FullRow := True;
        OnGetInfo := ScrollbarAnnotationGetInfo;
      end;
    end
    else
      Editor.ScrollbarAnnotations.Clear;
  end;

begin
  RegisterSearchHighlightIndicatorSpec(fEditor);

  // Tab position
  if PyIDEOptions.EditorsTabPosition = ttpTop then
    ViewsTabControl.TabPosition := ttpBottom
  else  //ttpBottom:
    ViewsTabControl.TabPosition := ttpTop;

  ApplyOptionsToEditor(SynEdit);
  ApplyOptionsToEditor(SynEdit2);
end;

procedure TEditorForm.AutoCompleteAfterExecute(Sender: TObject);
begin
  fAutoCompleteActive := False;
  CommandsDataModule.actReplaceParametersExecute(nil);
end;

procedure TEditorForm.AutoCompleteBeforeExecute(Sender: TObject);
begin
  // Application.processMessages;
  fAutoCompleteActive := True;
end;

procedure TEditorForm.WMSpSkinChange(var Message: TMessage);
begin
  StyledBorderColors(BorderNormal, BorderHighlight);
  ChangeStyle;
end;

procedure TEditorForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    EditFormToolbar.Images:= vilEditorToolbarDark;
    pmnuEditor.Images:= vilContextMenuDark;
    SynEdit.BookMarkOptions.BookmarkImages:= vilBookmarksDark;
  end else begin
    EditFormToolbar.Images:= vilEditorToolbarLight;
    pmnuEditor.Images:= vilContextMenuLight;
    SynEdit.BookMarkOptions.BookmarkImages:= vilBookmarksLight;
  end;

  if HasFocus
    then BGPanel.Color := BorderHighlight
    else BGPanel.Color := BorderNormal;

  PyIDEMainForm.ThemeEditorGutter(SynEdit.Gutter);
  SynEdit.InvalidateGutter;
  SynEdit.CodeFolding.FolderBarLinesColor := SynEdit.Gutter.Font.Color;

  PyIDEMainForm.ThemeEditorGutter(SynEdit2.Gutter);
  SynEdit2.CodeFolding.FolderBarLinesColor := SynEdit2.Gutter.Font.Color;
  SynEdit2.InvalidateGutter;
  Invalidate;
end;

procedure TEditorForm.SynCodeCompletionAfterCodeCompletion(Sender: TObject;
  const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char);
var
  Editor: TSynEdit;
begin
  Editor := fActiveSynEdit;
  if Value.EndsWith('()') then begin
    Editor.CaretX:= Editor.CaretX - 1;
    EndToken:= '(';
  end;
  if EndToken = '(' then
    TThread.ForceQueue(nil, procedure
    begin
      if Assigned(GI_ActiveEditor) and (GI_ActiveEditor.ActiveSynEdit = Editor) then
        CommandsDataModule.SynParamCompletion.ActivateCompletion;
    end);
end;

procedure TEditorForm.SynCodeCompletionClose(Sender: TObject);
begin
  PyIDEOptions.CodeCompletionListSize :=
    CommandsDataModule.SynCodeCompletion.NbLinesInWindow;
  TIDECompletion.EditorCodeCompletion.CleanUp;
end;

procedure TEditorForm.SynCodeCompletionCodeItemInfo(Sender: TObject;
  AIndex: Integer; var Info: string);
begin
  var CC := TIDECompletion.EditorCodeCompletion;
  if not CC.Lock.TryEnter then Exit;
  try
    if Assigned(CC.CompletionInfo.CompletionHandler) then
      Info := CC.CompletionInfo.CompletionHandler.GetInfo(
        (Sender as TSynCompletionProposal).InsertList[AIndex]);
  finally
    CC.Lock.Leave;
  end;
end;

class procedure TEditorForm.DoCodeCompletion(Editor: TSynEdit; Caret: TBufferCoord);
var
  locline: string;
  Attr: TSynHighlighterAttributes;
  Highlighter: TSynCustomHighlighter;
  FileName, DummyToken: string;
begin
  //Exit if cursor has moved
  if not Assigned(GI_ActiveEditor) or (GI_ActiveEditor.ActiveSynEdit <> Editor)
    or (Editor.ReadOnly) or (Caret <> Editor.CaretXY)
  then
    Exit;

  if not (GI_ActiveEditor.HasPythonFile and
    GI_PyControl.PythonLoaded and not GI_PyControl.Running and
    PyIDEOptions.EditorCodeCompletion)
  then
    Exit;

  Highlighter := Editor.Highlighter;
  FileName := GI_ActiveEditor.FileId;

  Dec(Caret.Char);
  Editor.GetHighlighterAttriAtRowCol(Caret, DummyToken, Attr);
  // to deal with trim trailing spaces
  locline := Editor.LineText.PadRight(Caret.Char);
  Inc(Caret.Char);

  var CC := TIDECompletion.EditorCodeCompletion;
  if not CC.Lock.TryEnter then Exit;
  try
    // Exit if busy
    if CC.CompletionInfo.Editor <> nil then Exit;
    CC.CleanUp;
    CC.CompletionInfo.Editor := Editor;
    CC.CompletionInfo.CaretXY := Caret;
  finally
    CC.Lock.Leave;
  end;

  TTask.Create(procedure
  var
    DisplayText, InsertText: string;
  begin
    var CC := TIDECompletion.EditorCodeCompletion;
    if not CC.Lock.TryEnter then Exit;
    try
      var Skipped := False;
      for var I := 0 to CC.SkipHandlers.Count -1 do
      begin
        var SkipHandler := CC.SkipHandlers[I] as TBaseCodeCompletionSkipHandler;
        Skipped := SkipHandler.SkipCodeCompletion(locline, FileName, Caret, Highlighter, Attr);
        if Skipped then Break;
      end;

      var Handled := False;
      if not Skipped then
      begin
        for var I := 0 to CC.CompletionHandlers.Count - 1 do
        begin
          var CompletionHandler := CC.CompletionHandlers[I] as TBaseCodeCompletionHandler;
          CompletionHandler.Initialize;
          try
            Handled := CompletionHandler.HandleCodeCompletion(locline, FileName,
              Caret, Highlighter, Attr, InsertText, DisplayText);
          except
          end;
          if Handled then begin
            //CompletionHandler will be finalized in the Cleanup call
            CC.CompletionInfo.CompletionHandler := CompletionHandler;
            CC.CompletionInfo.InsertText := InsertText;
            CC.CompletionInfo.DisplayText := DisplayText;
            Break;
          end
          else
            CompletionHandler.Finalize;
        end;
      end;

      if not Skipped and Handled and (InsertText <> '') then
        TThread.Queue(nil, procedure
        begin
          if Assigned(GI_ActiveEditor) and (GI_ActiveEditor.FileId = FileName) and
            (CommandsDataModule.SynCodeCompletion.Editor = GI_ActiveEditor.ActiveSynEdit)
          then
            CommandsDataModule.SynCodeCompletion.ActivateCompletion;
        end)
      else
        CC.CleanUp;
    finally
      CC.Lock.Leave;
    end;
  end).Start;
end;

procedure TEditorForm.setNeedsParsing(value: Boolean);
begin
  if value <> fNeedToParseModule then begin
    if value and Assigned(ActiveSynEdit) {and not fGetActiceSynEdit.LockBuildStructure}
      then fNeedToParseModule:= True
      else fNeedToParseModule:= False;
  end;
end;

procedure TEditorForm.SetToolButtons;
  var Python: Boolean;
begin
  Python:= IsPython;
  // TBClose.Visible:= true;
  // TBExplorer.Visible:= true;
  TBBrowser.Visible:= isHTML and TBBrowser.Visible;
  TBDesignform.Visible:= Python and TBDesignform.Visible;
  TBClassOpen.Visible:= Python and TBClassOpen.Visible;
  TBCheck.Visible:= Python and TBCheck.Visible;
  // TBMatchBracket.Visible:= true;
  TBClassEdit.Visible:= Python and TBClassEdit.Visible;
  TBStructureIndent.Visible:= Python and TBStructureIndent.Visible;
  TBIfStatement.Visible:= Python and TBIfStatement.Visible;
  TBIfElseStatement.Visible:= Python and TBIfElseStatement.Visible;
  TBWhileStatement.Visible:= Python and TBWhileStatement.Visible;
  TBForStatement.Visible:= Python and TBForStatement.Visible;
  TBIfElifStatement.Visible:= Python and TBIfElifStatement.Visible;
  TBTryStatement.Visible:= Python and TBTryStatement.Visible;
  // TBComment.Visible:= true;
  // TBWordWrap.Visible:= true;
  // TBIndent.Visible:= true;
  // TBUnindent.Visible:= true;
  TBBreakpoint.Visible:= Python and TBBreakpoint.Visible;
  TBBreakpointsClear.Visible:= Python and TBBreakpointsClear.Visible;
  // TBBookmark.Visible:= true;
  // TBGotoBookmark.Visible:= true;
  // TBParagraph.Visible:= true;
  // TBNumbers.Visible:= true;
  // TBZoomPlus.Visible:= true;
  // TBZoomMinus.Visible:= true;
  TBValidate.Visible:= (isHTML or isCSS) and TBValidate.Visible; // needs TFBrowser-Support
end;

procedure TEditorForm.SynCodeCompletionExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: string; var X, Y: Integer;
  var CanExecute: Boolean);
begin
  var CC := TIDECompletion.EditorCodeCompletion;
  var CP := TSynCompletionProposal(Sender);

  CanExecute := False;
  if CC.Lock.TryEnter then
  try
    CanExecute := Assigned(GI_ActiveEditor) and
      (GI_ActiveEditor.ActiveSynEdit = CC.CompletionInfo.Editor) and
      Application.Active and
      (GetParentForm(CC.CompletionInfo.Editor).ActiveControl = CC.CompletionInfo.Editor) and
      (CC.CompletionInfo.CaretXY = CC.CompletionInfo.Editor.CaretXY);

    if CanExecute then
    begin
      CP.Font := PyIDEOptions.AutoCompletionFont;
      CP.ItemList.Text := CC.CompletionInfo.DisplayText;
      CP.InsertList.Text := CC.CompletionInfo.InsertText;
      CP.NbLinesInWindow := PyIDEOptions.CodeCompletionListSize;
      CP.CurrentString := CurrentInput;

      if CP.Form.AssignedList.Count = 0 then
      begin
        CanExecute := False;
        CC.CleanUp;
      end
      else
      if PyIDEOptions.CompleteWithOneEntry and (CP.Form.AssignedList.Count = 1) then
      begin
        // Auto-complete with one entry without showing the form
        CanExecute := False;
        CP.OnValidate(CP.Form, [], #0);
        CC.CleanUp;
      end;
    end else begin
      CP.ItemList.Clear;
      CP.InsertList.Clear;
      CC.CleanUp;
    end;
  finally
    CC.Lock.Leave;
  end;
end;

class procedure TEditorForm.SynParamCompletionExecute(Kind: SynCompletionType;
    Sender: TObject; var CurrentInput: string; var X, Y: Integer; var
    CanExecute: Boolean);
var
  P : TPoint;
  CP: TSynCompletionProposal;
  Editor: IEditor;
begin
   Editor := GI_ActiveEditor;
   CP := Sender as TSynCompletionProposal;

  TJedi.ParamCompletionInfo.Lock;
  try
    CanExecute := Assigned(Editor) and Editor.HasPythonFile and TJedi.Ready
      and (Editor.ActiveSynEdit = CP.Editor) and PyIDEOptions.EditorCodeCompletion;

    // This function is called
    // a) from the editor using trigger char or editor command
    // b) From TSynCompletionProposal.HookEditorCommand
    // c) for TJedi ParamCompletionHandler Only then RequestId <> 0

    if not TJedi.ParamCompletionInfo.Handled then
    begin
      TJedi.RequestParamCompletion(Editor.FileId, CP.Editor);

      if CanExecute and CP.Form.Visible then
      begin
        // Keep showing the form at the same position
        X := CP.Form.Left;
        Y := CP.Form.Top - MulDiv(2, Editor.Form.CurrentPPI, Screen.DefaultPixelsPerInch);
      end
      else
        CanExecute := False;

      Exit;
    end;

    // ParamCompletionInfo  request was handled.  Make sure is still valid
    CanExecute := CanExecute and TJedi.ParamCompletionInfo.Succeeded and
      (TJedi.ParamCompletionInfo.FileId = Editor.FileId) and
      (TJedi.ParamCompletionInfo.CurrentLine = CP.Editor.LineText) and
      (TJedi.ParamCompletionInfo.Caret = CP.Editor.CaretXY);

    if CanExecute then
    begin
      var DisplayString := TJedi.ParamCompletionInfo.DisplayString;
      CP.FormatParams := not (DisplayString = '');
      if not CP.FormatParams then
        DisplayString :=  '\style{~B}' + _(SNoParameters) + '\style{~B}';

      var DocString := TJedi.ParamCompletionInfo.DocString;
      if (DocString <> '') then
      begin
        DisplayString := DisplayString + sLineBreak;
        DocString := GetLineRange(DocString, 1, 20) // 20 lines max
      end;

      CP.Form.CurrentIndex := TJedi.ParamCompletionInfo.ActiveParameter;
      CP.ItemList.Text := DisplayString + DocString;

      // position the hint window at and just below the opening bracket
      P := CP.Editor.ClientToScreen(CP.Editor.RowColumnToPixels(
          CP.Editor.BufferToDisplayPos(
          BufferCoord(TJedi.ParamCompletionInfo.StartX, CP.Editor.CaretY))));
      Inc(P.Y, CP.Editor.LineHeight);
      X := P.X;
      Y := P.Y;
    end
    else
      CP.ItemList.Clear;

    // Mark request as not handled even if you cannot execute
    // It will be marked again as handled by the asynchronous request handler
    TJedi.ParamCompletionInfo.Handled := False;

  finally
    TJedi.ParamCompletionInfo.UnLock;
  end;
end;

procedure TEditorForm.SynWebCompletionAfterCodeCompletion(Sender: TObject;
  const Value: string; Shift: TShiftState; Index: Integer;
  EndToken: WideChar);
var
    SynEdit: TCustomSynEdit;

  function CaretBetween(AStr: string): Boolean;
  var
    i: Integer;
  begin
    i := Pos(AStr, Value);
    Result := i > 0;
    if Result then
      SynEdit.CaretX := SynEdit.CaretX - (Length(Value) - i);
  end;

begin
  SynEdit := TSynCompletionProposal(Sender).Editor;
  if Pos('>>', SynEdit.Lines[SynEdit.CaretY-1]) >= 1 then
    SynEdit.ExecuteCommand(ecDeleteChar, ' ', nil);

  if not CaretBetween('()') then
    if not CaretBetween('><') then
      if not CaretBetween('""') then
        CaretBetween(' ;');
end;

procedure TEditorForm.SynWebCompletionExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: string; var X, Y: Integer;
  var CanExecute: Boolean);
var
  SynEdit: TCustomSynEdit;
begin
  SynEdit := TSynCompletionProposal(Sender).Editor;
  SynWebFillCompletionProposal(SynEdit, ResourcesDataModule.SynWebHTMLSyn,
    CommandsDataModule.SynWebCompletion, CurrentInput);
  TSynCompletionProposal(Sender).Font := PyIDEOptions.AutoCompletionFont;
end;

procedure TEditorForm.SetDeleteBookmark(XPos, YPos: Integer);
  var i, x, y: Integer;
begin
  with ActiveSynEdit do begin
    i:= 0;
    while (i < 10) do begin
      if GetBookmark(i, x, y) and (y = YPos) then begin
        ClearBookmark(i);
        Exit;
      end;
      Inc(i);
    end;
    i:= 0;
    while (i < 10) and IsBookMark(i) do Inc(i);
    if i < 10 then begin
      SetBookMark(i, XPos, YPos);
      end
    else
      Beep;
  end;
end;

procedure TEditorForm.TBCheckClick(Sender: TObject);
  var ErrorPos: TEditorPos;
begin
  if TPyInternalInterpreter(PyControl.InternalInterpreter).SyntaxCheck(fEditor, ErrorPos) then begin
    GI_PyIDEServices.Messages.AddMessage(Format(_(SSyntaxIsOK), [Pathname]));
    ShowDockForm(MessagesWindow);
  end else
    ShowDockForm(PythonIIForm);
end;

procedure TEditorForm.TBClassEditClick(Sender: TObject);
begin
  if IsPython then begin
    if Modified or fFile.GetFromTemplate then
      DoSave;
    PyIDEMainForm.PrepareClassEdit(fEditor, 'Edit', nil);
  end;
end;

procedure TEditorForm.TBClassOpenClick(Sender: TObject);
begin
  if IsPython then begin
    try
      if Modified or fFile.GetFromTemplate then
        DoSave;
      var s:= ChangeFileExt(Pathname, '.puml');
      if FileExists(s) then
        PyIDEMainForm.DoOpenFile(s, '', PyIDEMainForm.ActiveTabControlIndex)
      else begin
        var UMLForm:= PyIDEMainForm.CreateUMLForm(s);
        UMLForm.Visible:= False;
        UMLForm.MainModul.AddToProject(Pathname);
        UMLForm.CreateTVFileStructure;
        UMLForm.MainModul.DoLayout;
        UMLForm.DoSave;
        PyIDEMainForm.RunFile(UMLForm.fFile);
        UMLForm.Visible:= True;
      end;
    except on e: Exception do
      ErrorMsg(e.Message);
    end;
  end;
end;

procedure TEditorForm.TBCloseClick(Sender: TObject);
begin
  (fEditor as IFileCommands).ExecClose;
end;

procedure TEditorForm.TBWordWrapClick(Sender: TObject);
begin
  if ActiveSynEdit.WordWrap then begin
    ActiveSynEdit.WordWrap:= False;
    ActiveSynEdit.UseCodeFolding:= True;
  end else begin
    ActiveSynEdit.UseCodeFolding:= False;
    ActiveSynEdit.WordWrap:= True;
  end;
  TBParagraph.Down:= ActiveSynEdit.WordWrap;
end;

procedure TEditorForm.TBStatementClick(Sender: TObject);
begin
  TBControlStructures((Sender as TToolButton).Tag)
end;

procedure TEditorForm.TBStructureIndentClick(Sender: TObject);
begin
  var ExternalTool:= TExternalTool.Create;
  with ExternalTool do begin
    ApplicationName := '$[PythonExe-Short]';
    Parameters := '$[PythonDir-Short]Tools\Scripts\reindent.py -n ';
    SaveFiles := sfActive;
    ProcessInput := piActiveFile;
    ProcessOutput := poActiveFile;
    Context:= tcActiveFile;
    ParseMessages := False;
    CaptureOutput := False;
    ConsoleHidden := True;
  end;
  ExternalTool.Execute;
  FreeAndNil(ExternalTool);
end;

procedure TEditorForm.TBZoomMinusClick(Sender: TObject);
begin
  var fs:= Max(SynEdit.Font.Size - 1, 6);
  SynEdit.Font.Size:= fs;
  SynEdit.Gutter.Font.Size:= fs - 2;
  SynEdit2.Font.Size:= fs;
  SynEdit2.Gutter.Font.Size:= fs - 2;
  EditorOptions.Font.Size:= fs;
end;

procedure TEditorForm.TBZoomPlusClick(Sender: TObject);
begin
  var fs:= SynEdit.Font.Size + 1;
  SynEdit.Font.Size:= fs;
  SynEdit.Gutter.Font.Size:= fs - 2;
  SynEdit2.Font.Size:= fs;
  SynEdit2.Gutter.Font.Size:= fs - 2;
  EditorOptions.Font.Size:= fs;
end;

procedure TEditorForm.TBNumbersClick(Sender: TObject);
begin
  ActiveSynEdit.Gutter.ShowLineNumbers:= not ActiveSynEdit.Gutter.ShowLineNumbers;
  ActiveSynEdit.Gutter.AutoSize:= not ActiveSynEdit.Gutter.AutoSize;
end;

procedure TEditorForm.TBParagraphClick(Sender: TObject);
begin
  var VisibleSpecialChars := SynEdit.VisibleSpecialChars;
  if VisibleSpecialChars = [] then
    SynEdit.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    SynEdit.VisibleSpecialChars := [];
  TBParagraph.Down:= not (SynEdit.VisibleSpecialChars = []);
end;

procedure TEditorForm.TBGotoBookmarkClick(Sender: TObject);
  var OldNumber: Integer;
begin
  OldNumber:= fBookmark;
  repeat
    if ActiveSynEdit.IsBookmark(fBookmark) then begin
      ActiveSynEdit.GotoBookmark(fBookmark);
      fBookmark:= (fBookmark+1) mod 10;
      Exit;
    end;
    fBookmark:= (fBookmark+1) mod 10;
  until OldNumber = fBookmark;
end;

procedure TEditorForm.TBUnindentClick(Sender: TObject);
begin
  Unindent;
end;

procedure TEditorForm.TBValidateClick(Sender: TObject);
  var Browser: TFBrowser;
begin
  Browser:= PyIDEMainForm.NewBrowser('');
  if isCSS then
    Browser.UploadFilesHttpPost('https://jigsaw.w3.org/css-validator/validator', [], [], ['file'], [Pathname])
  else
    Browser.UploadFilesHttpPost('https://validator.w3.org/check', [], [], ['uploaded_file'], [Pathname]);
end;

procedure TEditorForm.TBIndentClick(Sender: TObject);
begin
  Indent;
end;

procedure TEditorForm.TBMatchBracketClick(Sender: TObject);
begin
  ActiveSynEdit.CommandProcessor(ecMatchBracket, #0, nil);
end;

procedure TEditorForm.TBCommentClick(Sender: TObject);
  var i, p, From, To_: Integer; s: string;
      p1, p2: TBufferCoord;
begin
  with ActiveSynEdit do begin
    BeginUpdate;
    if SelAvail then begin
      From:= BlockBegin.Line;
      To_:= BlockEnd.Line;
      p1:= BlockBegin;
      p2:= BlockEnd;
      end
    else begin
      From:= CaretY; p1.Char:= CaretX; p1.Line:= CaretY;
      To_:= CaretY; p2.Char:= 0;
    end;
    for i:= From to To_ do begin
      s:= Lines[i-1];
      p:= Pos('#', s);
      if p = 1
        then Delete(s, p, 1)
        else s:= '#' + s;
      Lines[i-1]:= s;
    end;
    if p2.Char <> 0 then begin
      BlockBegin:= p1;
      BlockEnd:= p2;
    end;
    EndUpdate;
    InvalidateLines(From, To_);
  end;
  Modified:= True;
end;

procedure TEditorForm.TBBookmarkClick(Sender: TObject);
begin
  with ActiveSynEdit do
    SetDeleteBookmark(CaretX, CaretY);
end;

procedure TEditorForm.TBBreakpointClick(Sender: TObject);
begin
  var Editor := GI_PyIDEServices.GetActiveEditor;
  if Assigned(Editor) and Editor.HasPythonFile then
    PyControl.ToggleBreakpoint(Editor, Editor.SynEdit.CaretY);
end;

procedure TEditorForm.TBBreakpointsClearClick(Sender: TObject);
begin
  PyControl.ClearAllBreakpoints;
end;

procedure TEditorForm.TBBrowserClick(Sender: TObject);
begin
  if Modified or fFile.GetFromTemplate then
    DoSave;
  FConfiguration.DoHelp(Pathname);
end;

procedure TEditorForm.SBDesignformClick(Sender: TObject);
  var s: string;
begin
  if IsPython and (Partner = nil) then begin
    s:= ChangeFileExt(Pathname, '.pfm');
    PyIDEMainForm.DoOpen(s);
  end;
end;

procedure TEditorForm.TBDesignformClick(Sender: TObject);
begin
  if IsPythonAndGUI and (Partner = nil) then
    FGUIDesigner.Open(ChangeFileExt(Pathname, '.pfm'));
end;

procedure TEditorForm.TBExplorerClick(Sender: TObject);
begin
  PyIDEMainForm.actNavFileExplorerExecute(nil);
end;

function TEditorForm.BeginOfStructure(Line: string): Boolean;
  var p: Integer;
begin
  p:= Pos('#', Line);
  if p > 0 then
    Delete(Line, p, Length(Line));
  Line:= Trim(Line);
  Result:= (Line <> '') and (Line[Length(Line)] = ':');
end;

procedure TEditorForm.Unindent;
  var x: Integer;
begin
  with ActiveSynEdit do begin
    TabWidth:= Length(FConfiguration.Indent1);
    if SelAvail
      then CommandProcessor(ecBlockUnindent, #0, nil)
    else begin
      x:= CaretX;
      if fMouseIsInBorderOfStructure
        then SelStructure(fMouseBorderOfStructure)
        else SelEnd:= SelStart + 1;
      CommandProcessor(ecBlockUnindent, #0, nil);
      SelEnd:= SelStart;
      CaretX:= x - TabWidth;
    end;
    TabWidth:= EditorOptions.TabWidth;
  end;
end;

procedure TEditorForm.Indent;
  var x: Integer;
begin
  with ActiveSynEdit do begin
    TabWidth:= Length(FConfiguration.Indent1);
    if SelAvail
      then CommandProcessor(ecBlockIndent, #0, nil)
    else begin
      x:= CaretX;
      if fMouseIsInBorderOfStructure
        then SelStructure(fMouseBorderOfStructure)
        else SelEnd:= SelStart + 1;
      CommandProcessor(ecBlockIndent, #0, nil);
      SelEnd:= SelStart;
      CaretX:= x + TabWidth;
    end;
    TabWidth:= EditorOptions.TabWidth;
  end;
end;

procedure TEditorForm.SelStructure(var LineNo: Integer);
  var i, Indent: Integer; Line: string; aPos, Block: TBufferCoord;
begin
  LineNo:= -1;
  ActiveSynEdit.GetPositionOfMouse(aPos);
  if aPos.Line < ActiveSynEdit.Lines.Count then begin
    Line:= ActiveSynEdit.Lines[aPos.Line];
    if BeginOfStructure(Line) then begin
      LineNo:= aPos.Line;
      Block.Char:= 1;
      Block.Line:= aPos.Line;
      ActiveSynEdit.BlockBegin:= Block;
      Indent:= CalcIndent(Line);
      i:= aPos.Line + 1;
      while (i < ActiveSynEdit.lines.Count) and (CalcIndent(ActiveSynEdit.Lines[i]) > Indent) do
        Inc(i);
      Block.Line:= i;
      ActiveSynEdit.BlockEnd:= Block;
    end;
  end;
end;

procedure TEditorForm.TBControlStructures(KTag: Integer; OnKey: Boolean = False);
  var s, line, SelectedBlock, Indent: string; empty: Boolean;

  function PrepareBlock(s: string): string;
    var s1, s2: string; p: Integer;
  begin
    s1:= '';
    p:= System.Pos(CrLf, s);
    while p > 0 do begin
      s2:= Copy(s, 1, p+1);
      if KTag = 5 then // switch needs double indent
        if Trim(s2) = ''
          then s1:= s1 + Indent + fIndent2 + CrLf
          else s1:= s1 + fIndent2 + s2
      else
        if Trim(s2) = ''
          then s1:= s1 + Indent + fIndent1 + CrLf
          else s1:= s1 + fIndent1 + s2;
      Delete(s, 1, p+1);
      p:= Pos(CrLf, s);
    end;
    Result:= s1;
  end;

begin
  if ActiveSynEdit.SelAvail then begin
    Indent:= StringOfChar(' ', CalcIndent(ActiveSynEdit.Lines[ActiveSynEdit.BlockBegin.Line]));
    SelectedBlock:= GetLinesWithSelection + CrLf;
    SelectedBlock:= PrepareBlock(SelectedBlock);
  end else begin
    line:= ActiveSynEdit.Lines[ActiveSynEdit.CaretY-1];
    empty:= (Trim(line) = '');
    Delete(line, ActiveSynEdit.CaretX, MaxInt);
    if empty then begin
      Indent:= StringOfChar(' ', ActiveSynEdit.CaretX-1);
      ActiveSynEdit.CaretX:= 1;
      ActiveSynEdit.Lines[ActiveSynEdit.CaretY-1]:= '';
    end else
      Indent:= getIndent;
    SelectedBlock:= '';
  end;
  s:= GetControlStructure(KTag, Indent, SelectedBlock);
  if not ActiveSynEdit.SelAvail and (Trim(line) <> '') then
    Delete(s, 1, Length(Indent));
  if (KTag = 1) and OnKeY
    then // FJava.scpJava.ActivateTimer(EditForm.Editor) ToDo
    else PutText(s);
end;

function TEditorForm.GetLinesWithSelection: string;
  var BlockA, BlockE: TBufferCoord;
begin
  with ActiveSynEdit do begin
    BlockA:= BlockBegin;
    BlockE:= BlockEnd;
    if BlockBegin.Line <= BlockEnd.Line then begin
      BlockA.Char:= 1;
      BlockE.Char:= Length(Lines[BlockEnd.Line-1]) + 1;
    end else begin
      BlockE.Char:= 1;
      BlockA.Char:= Length(Lines[BlockBegin.Line-1]) + 1;
    end;
    BlockBegin:= BlockA;
    BlockEnd:= BlockE;
    Result:= SelText;
  end;
end;

function TEditorForm.GetControlStructure(KTag: Integer; const Indent: string; block: string): string;
  var s, s1: string;
      p: Integer;
begin
  Result:= '';
  s:= '';
  p:= 0;
  while p < FConfiguration.ControlStructureTemplates[KTag].Count do begin
    s1:= FConfiguration.ControlStructureTemplates[KTag][p];
    if (block <> '') and (Trim(s1) = '') then begin
      s:= s + block;
      block:= '';
    end
    else if (block <> '') and (Trim(s1) = '|') then begin
      if KTag = 10 then
        s:= s + '|' + block
      else begin
        s:= s + Indent + s1 + CrLf;
        s:= s + block
      end;
      block:= '';
    end
    else
      s:= s + Indent + s1 + CrLf;
    Inc(p);
  end;
  Delete(s, Length(s)-1, 2);
  Result:= s;
end;

procedure TEditorForm.ViewsTabControlActiveTabChange(Sender: TObject;
  TabIndex: Integer);
begin
  tbiUpdateView.Enabled := ViewsTabControl.ActivePage <> tbshSource;
  tbiCloseTab.Enabled := ViewsTabControl.ActivePage <> tbshSource;
end;

procedure TEditorForm.ViewsTabControlContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  IV: TTBItemViewer;
  P: TPoint;
begin
  IV := ViewsTabControl.View.ViewerFromPoint(MousePos);
  if Assigned(IV) and (IV.Item is TSpTBXTabItem) then
  begin
    IV.Item.Checked := True;
    P := ClientToScreen(MousePos);
    mnCloseTab.Enabled := not(ViewsTabControl.GetPage(TSpTBXTabItem(IV.Item))
        = tbshSource);
    pmnuViewsTab.Popup(P.X, P.Y);
  end;
  Handled := True;
end;

class procedure TEditorForm.CodeHintLinkHandler(Sender: TObject; LinkName: string);
begin
  var Editor := GI_PyIDEServices.ActiveEditor;
  if Assigned(Editor) then
  begin
    var SynEd := Editor.ActiveSynEdit;
    var P := TEditorForm(Editor.Form).FHintCursorRect.TopLeft;
    var DC := SynEd.PixelsToNearestRowColumn(P.X, P.Y);
    var BC := SynEd.DisplayToBufferPos(DC);
    PyIDEMainForm.JumpToFilePosInfo(LinkName);
    PyIDEMainForm.AdjustBrowserLists(Editor.GetFileId, BC.Line, BC.Char, LinkName);
  end;
end;

procedure TEditorForm.DoOnIdle;
begin
  ReparseIfNeeded;
  SyncCodeExplorer;
  SyncFileStructure;
  //if PyIDEOptions.CheckSyntaxAsYouType and FEditor.HasPythonFile then
  //  FEditor.FSynLsp.ApplyNewDiagnostics;

  if SynEdit.ReadOnly then
    ParentTabItem.ImageIndex := PyIDEMainForm.vilTabDecorators.GetIndexByName('Lock')
  else if HasSyntaxError then
    ParentTabItem.ImageIndex := PyIDEMainForm.vilTabDecorators.GetIndexByName('Bug')
  else
    ParentTabItem.ImageIndex := -1;
end;

procedure TEditorForm.SynEditDebugInfoPaintLines(RT: ID2D1RenderTarget; ClipR:
    TRect; const FirstRow, LastRow: Integer; var DoDefaultPainting: Boolean);
var
  LH, Y: Integer;
  LI: TDebuggerLineInfos;
  ImgIndex: Integer;
  Row, Line: Integer;
begin
  DoDefaultPainting := False;
  if not (SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn) then Exit;

  if (PyControl.ActiveDebugger <> nil) and SynEdit.Gutter.Visible then
  begin
    LH := SynEdit.LineHeight;

    for Row := FirstRow to LastRow do
    begin
      Line := SynEdit.RowToLine(Row);
      if Row <> SynEdit.LineToRow(Line) then Continue;  //Wrapped line

      Y := (LH - vilGutterGlyphs.Height) div 2 + LH *
        (Row - SynEdit.TopLine);
      LI := PyControl.GetLineInfos(fEditor, Line);
      if dlCurrentLine in LI then
      begin
        if dlBreakpointLine in LI then
          ImgIndex := 2
        else
          ImgIndex := 1;
      end
      else if dlExecutableLine in LI then
      begin
        if dlBreakpointLine in LI then
          ImgIndex := 3
        else if dlDisabledBreakpointLine in LI then
          ImgIndex := 5
        else if PyIDEOptions.MarkExecutableLines then
          ImgIndex := 0
        else
          ImgIndex := -1
      end
      else
      begin
        if dlBreakpointLine in LI then
          ImgIndex := 4
        else if dlDisabledBreakpointLine in LI then
          ImgIndex := 5
        else
          ImgIndex := -1;
      end;
      if ImgIndex >= 0 then
        ImageListDraw(RT, vilGutterGlyphs, ClipR.Left +
          MulDiv(TSynGutterBand.MarginX, FCurrentPPI, 96), Y, ImgIndex);
    end;
  end;
end;

procedure TEditorForm.SynEditGutterDebugInfoCLick(Sender: TObject; Button:
    TMouseButton; X, Y, Row, Line: Integer);
var
  ASynEdit: TSynEdit;
begin
  ASynEdit := Sender as TSynEdit;
  if (ASynEdit.Highlighter = ResourcesDataModule.SynPythonSyn) and
    (PyControl.ActiveDebugger <> nil)
  then
    PyControl.ToggleBreakpoint(fEditor, Line, GetKeyState(VK_CONTROL) < 0);
end;

procedure TEditorForm.SynEditGutterDebugInfoMouseCursor(Sender: TObject; X, Y,
    Row, Line: Integer; var Cursor: TCursor);
begin
  Cursor := crHandPoint;
end;

procedure TEditorForm.InsertLinesAt(line: Integer; s: string);
  var cx, cy, tl, cl: Integer; collapsed: Boolean;
begin
  if not s.endsWith(CrLf) then
    s:= s + CrLf;
  with ActiveSynEdit do begin
    BeginUpdate;
    collapsed:= (AllFoldRanges.Count > 2) and AllFoldRanges.Ranges[2].Collapsed;
    cx:= CaretX;
    cy:= CaretY;
    tl:= TopLine;
    if Line > Lines.Count then begin
      ExecuteCommand(ecEditorBottom, #0, nil);
      while line > Lines.Count do
        ExecuteCommand(ecInsertLine, #0, nil);
    end;

    CaretY:= line+1;
    CaretX:= 1;
    PutText(s, False);
    if cy > line + 1 then begin
      cl:= CountChar(#13, s);
      if cl = 0 then cl:= 1;
      cy:= cy + cl;
      tl:= tl + cl;
    end;
    TopLine:= tl;
    CaretX:= cx;
    CaretY:= cy;
    EnsureCursorPosVisible;
    Modified:= True;
    if collapsed then Collapse(2);
    EndUpdate;
  end;
  Modified:= True;
end;

procedure TEditorForm.InsertNewAttribute(const s: string);
begin
  InsertLinesAt(getLastCreateWidgetsLine, s);
end;

procedure TEditorForm.InsertAtBegin(const s: string);
begin
  InsertLinesAt(getFirstCreateWidgetsLine, s);
end;

procedure TEditorForm.InsertAtEnd(const s: string);
begin
  InsertLinesAt(getLastCreateWidgetsLine, s);
end;

procedure TEditorForm.InsertAttributeCE(const s: string; ClassNumber: Integer);
  var Operation: TOperation;
begin
  Operation:= getConstructor(ClassNumber);
  if Assigned(Operation) then
    InsertLinesAt(Operation.LineSE, s);
end;

function TEditorForm.getLineNumberOfBinding(Name, Attr: string): Integer;
  var line, till, p: Integer; key1, key2: string;
begin
  Result:= -1;
  key1:= 'self.' + Name + '.bind';
  key2:= 'self.' + Name + '_' + Attr;
  line:= getLineNumberWithWord(key1);
  till:= getLastCreateWidgetsLine;
  p:= Pos(key2, ActiveSynEdit.Lines[line]);
  while (p = 0) and (-1 < line) and (line < till) do begin
    Inc(line);
    line:= getLineNumberWithWordFromTill(key1, line, till);
    if line > -1 then
      p:= Pos(key2, ActiveSynEdit.Lines[line])
  end;
  if (line >= 0) and (line < till) and (p > 0) then
    Result:= line;
end;

procedure TEditorForm.InsertTkBinding(const Name, Attr, Binding: string);
  var line: Integer;
begin
  line:= getLineNumberOfBinding(Name, Attr);
  if line >= 0
    then ActiveSynEdit.Lines[line]:= Binding
    else InsertValue(Name, Binding, 1);
  Modified:= True;
end;

procedure TEditorForm.InsertQtBinding(const Name, Binding: string);
  var key: string;
begin
  key:= Copy(Binding, 1, Pos('(', Binding) - 1);
  SetAttributValue(Name, key, Binding, 1);
  Modified:= True;
end;

procedure TEditorForm.InsertProcedure(const aProcedure: string; ClassNumber: Integer = 0);
  var Line: Integer;
begin
  ParseAndCreateModel;
  Line:= getLineForMethod(ClassNumber);
  if (Line > -1) and (aProcedure <> '') then
    InsertLinesAt(Line, aProcedure)
end;

procedure TEditorForm.InsertProcedureWithoutParse(const aProcedure: string; ClassNumber: Integer = 0);
  var Line: Integer;
begin
  Line:= getLineForMethod(ClassNumber);
  if Line > -1 then
    InsertLinesAt(Line, aProcedure)
end;

procedure TEditorForm.InsertConstructor(const aConstructor: string; ClassNumber: Integer);
  var Line: Integer;
begin
  line:= getLineForConstructor(ClassNumber);
  if Line > -1 then
    InsertLinesAt(Line, aConstructor);
end;

procedure TEditorForm.InsertImport(Module: string);
begin
  with ActiveSynEdit do begin
    var line:= getLineNumberWithWord('import');
    if line = -1 then begin
      Module:= Module + CrLf;
      line:= getLineNumberWithWord('class');
      if line > -1
        then line:= line - 1
        else line:= 0;
    end else begin
      while (line < Lines.Count) and (Pos('import', Lines[line]) > 0) do begin
        if Pos(Module, Lines[line]) > 0 then Exit;
        Inc(line);
      end;
      Dec(line);
    end;
    InsertLinesAt(line + 1, Module + CrLf);
    ParseAndCreateModel;
  end;
end;


procedure TEditorForm.DeleteEmptyLine(line: Integer);
begin
  ActiveSynEdit.BeginUpdate;
  if Trim(ActiveSynEdit.Lines[line]) = '' then
    deleteLine(line);
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteLine(line: Integer);
  var i: Integer; collapsed: Boolean;
begin
  i:= 0;
  while i < ActiveSynEdit.Marks.Count do begin
    if ActiveSynEdit.Marks[i].line = line then
      DeleteBreakpointMark(ActiveSynEdit.Marks[i]);
    Inc(i);
  end;
  collapsed:= (ActiveSynEdit.AllFoldRanges.Count > 1) and ActiveSynEdit.AllFoldRanges.Ranges[1].Collapsed;
  ActiveSynEdit.CaretY:= Line+1;
  ActiveSynEdit.CommandProcessor(ecDeleteLine, #0, nil);
  if collapsed then ActiveSynEdit.Collapse(1);
  Modified:= True;
end;

procedure TEditorForm.DeleteLine(s: string);
begin
  var line:= getLineNumberWith(s);
  if line > -1 then DeleteLine(line);
end;

procedure TEditorForm.DeleteBlock(StartLine, EndLine: Integer);
  var i: Integer;
begin
  ActiveSynEdit.BeginUpdate;
  for i:= EndLine downto StartLine do
    if i < ActiveSynEdit.Lines.Count then
      DeleteLine(i);
  Modified:= True;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteComponent(Control: TControl);
begin
  ActiveSynEdit.BeginUpdate;
  var cw:= GetCreateWidgets;
  if Assigned(cw) then begin
    for var i:= cw.LineE - 1 downto cw.LineS do
      if hasWidget(Control.Name, i) then
        DeleteLine(i);
  end;
  Modified:= True;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteItems(Name, Key: string);
begin
  ActiveSynEdit.BeginUpdate;
  var cw:= GetCreateWidgets;
  if Assigned(cw) then begin
    for var i:= cw.LineE - 1 downto cw.LineS do begin
      var RegEx := '^[ \t]*self\.' + Name + '(' + Key + '\d+)';
      if TRegEx.IsMatch(ActiveSynEdit.Lines[i], RegEx) then
        DeleteLine(i);
    end;
  end;
  Modified:= True;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteMethod(const Method: string);
  var line: Integer;
begin
  if Method <> '' then begin
    ActiveSynEdit.Lines.BeginUpdate;
    line:= getLineNumberWithWord('def ' + Method);
    // don't delete implemented methods automatically
    if (line > -1) and (line + 2 < ActiveSynEdit.Lines.Count) and
       (ActiveSynEdit.Lines[line+1] = fIndent2 + '# ToDo insert source code here') and
       (ActiveSynEdit.Lines[line+2] = fIndent2 + 'pass') then
    begin
      DeleteBlock(line, line+2);
      while (line < ActiveSynEdit.Lines.Count - 1) and (Trim(ActiveSynEdit.Lines[line]) = '') do
        DeleteLine(line);
    end;
    ActiveSynEdit.Lines.EndUpdate;
  end;
end;

type
  TMethodSource = record
     Name: string;
     from: Integer;
     till: Integer;
  end;

procedure TEditorForm.DeleteOldAddNewMethods(OldMethods, NewMethods: TStringList);
  var i, p, from, till, Index: Integer;
      Ci, it: IModelIterator;
      cent: TModelEntity;
      Method: TOperation;
      MethodArray: array[0..500] of TMethodSource;
      SL: TStringList;
      s1, s2, func: string;

  function inMethodArray(com: string): Integer;
  begin
    Result:= -1;
    for var i:= 0 to Index do
      if Pos(MethodArray[i].Name + '(', com) = 1 then
        Result:= i;
  end;

begin
  // 1. add new methods at the end
  // 2. delete old methods in the middle
  ParseAndCreateModel;
  SL:= TStringList.Create;

  // get existing methods
  Index:= -1;
  Ci:= Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent:= Ci.Next;
    if cent is TClass then begin
      It:= (cent as TClass).GetOperations;
      while It.HasNext do begin
        Inc(Index);
        Method:= It.Next as TOperation;
        MethodArray[Index].Name:= Method.Name;
        MethodArray[Index].from:= Method.LineS - 1;
        MethodArray[Index].till:= Method.LineE - 1;
      end;
    end;
  end;

  //add missing new methods
  for i:= 0 to NewMethods.Count - 1 do
    if inMethodArray(NewMethods[i]) = -1 then begin
      func:= CrLf +
             fIndent1 + 'def ' + NewMethods[i] + CrLf +
             fIndent2 + '# ToDo insert source code here' + CrLf +
             fIndent2 + 'pass';
      SL.Add(func);
    end;
  InsertProcedure(SL.Text);

  // delete unnecessary default methods
  // determine methods to delete
  SL.Clear;
  for i := 0 to OldMethods.Count - 1 do   // keeps method lines valid
    if NewMethods.IndexOf(OldMethods[i]) = -1 then begin
      p:= inMethodArray(OldMethods[i]);
      if p > -1 then begin
        // delete if default
        from:= MethodArray[p].from;
        till:= MethodArray[p].till;
        s1:= getSource(from, till);
        s2:= fIndent1 + 'def ' + OldMethods[i] + CrLf +
             fIndent2 + '# ToDo insert source code here' + CrLf +
             fIndent2 + 'pass' + CrLf;
        if s1 = s2 then
          SL.Add(Copy(OldMethods[i], 1, Pos('(', OldMethods[i]) - 1));
      end;
    end;

  // delete beginning at the end of the sourcecode
  for i:= Index downto 0 do
    if SL.indexOf(MethodArray[i].Name) > -1 then begin
      from:= MethodArray[i].from;
      till:= MethodArray[i].till;
      DeleteBlock(from, till);
      while (from < ActiveSynEdit.Lines.Count - 1) and (Trim(ActiveSynEdit.Lines[from]) = '') do
        DeleteLine(from);
      InsertLinesAt(from, '');
    end;
  FreeAndNil(SL);
end;

procedure TEditorForm.DeleteBinding(const Binding: string);
  var line: Integer;
begin
  line:= getLineNumberWith(Binding);
  if line > -1 then begin
    DeleteLine(line);
    Modified:= True;
  end;
end;

procedure TEditorForm.DeleteAttribute(const s: string);
  var LineNo: Integer;
begin
  LineNo:= getLineNumberWithWord(s);
  if (0 <= LineNo) and (LineNo < getLastCreateWidgetsLine) then begin
    DeleteLine(LineNo);
    Modified:= True;
  end;
end;

procedure TEditorForm.DeleteAttributeCE(const s: string; ClassNumber: Integer);
  var Operation: TOperation; Line: Integer;
begin
  Operation:= getConstructor(ClassNumber);
  if Assigned(Operation) then begin
    if Operation.LineE = Operation.LineSE + 1 then // last attribute
      ReplaceAttribute(s, StringTimesN(FConfiguration.Indent1, Operation.Level + 2) + 'pass')
    else begin
      Line:= getLineNumberWithWordFromTill(s, Operation.LineSE);
      if Line > -1 then
        DeleteLine(Line);
    end;
  end;
end;

procedure TEditorForm.DeleteAttributeValues(const s: string);
  var line, till: Integer;
begin
  if s = 'self.' then
     raise Exception.CreateFmt('Invalid name : ''%s''', [s]);

  ActiveSynEdit.BeginUpdate;
  line:= getLineNumberWithWord(s);
  till:= getLastCreateWidgetsLine;
  while (-1 < line) and (line < till) do begin
    DeleteLine(line);
    Dec(till);
    Modified:= True;
    line:= getLineNumberWithWordFromTill(s, line, till);
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.MoveBlock(from, till, dest, desttill: Integer; const blanklines: string);
  var s: string; i: Integer;

  procedure DeleteBlanklines(i: Integer);
    var s: string;
  begin
    if i > 0 then begin
      s:= Trim(ActiveSynEdit.Lines[i-1]) + Trim(ActiveSynEdit.Lines[i]);
      if s = '' then DeleteLine(i);
      s:= Trim(ActiveSynEdit.Lines[i-1]) + Trim(ActiveSynEdit.Lines[i]);
      if s = '' then DeleteLine(i);
    end else if (i < ActiveSynEdit.Lines.Count-1) then begin
      s:= Trim(ActiveSynEdit.Lines[i]) + Trim(ActiveSynEdit.Lines[i+1]);
      if s = '' then DeleteLine(i);
    end;
  end;

begin
  ActiveSynEdit.BeginUpdate;
  s:= '';
  for i:= from to till do
    s:= s + ActiveSynEdit.Lines[i] + #13#10;
  s:= s + blanklines;
  if dest < from then begin
    for i:= from to till do
      DeleteLine(from);
    DeleteBlanklines(from);
    insertLinesAt(dest, s);
  end else begin // dest > from
    insertLinesAt(desttill+1, s);
    for i:= from to till do
      DeleteLine(from);
    DeleteBlanklines(from);
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.toBackground(Control: TControl);
  var from, till: Integer; OP: TOperation;
begin
  if Control is TBaseWidget then begin
    OP:= getCreateWidgets;
    if Assigned(OP) then begin
      from:= getFirstWidget(OP.LineS, Control.Name);
      till:= from + 1;
      while (till < OP.LineE) and hasWidget(Control.Name, till) do
        Inc(till);
      Dec(till);
      if till > -1 then
       MoveBlock(from, till, OP.LineS, 0, '');
    end;
  end;
end;

procedure TEditorForm.toForeground(Control: TControl);
  var from, till: Integer; OP: TOperation;
begin
  if Control is TBaseWidget then begin
    OP:= getCreateWidgets;
    if Assigned(OP) then begin
      from:= getFirstWidget(OP.LineS, Control.Name);
      till:= from + 1;
      while (till < OP.LineE) and hasWidget(Control.Name, till) do
        Inc(till);
      Dec(till);
      if till > -1 then
        MoveBlock(from, till, OP.LineE-2, OP.LineE-2, '');
    end;
  end;
end;

procedure TEditorForm.GoTo2(const s: string);
  var line: Integer;
begin
  with ActiveSynEdit do begin
    line:= getLineNumberWithWord(s);
    if (0 <= line) and (line <= Lines.Count - 1) then
      if Pos('def ', Lines[line]) > 0 then begin
        CaretY:= line + 2;
        CaretX:= Length(fIndent2) + 1;
      end else begin
        CaretX:= Pos(s, Lines[line]);
        CaretY:= line + 1;
      end;
    end;
end;

function TEditorForm.hasText(const s: string): Boolean;
begin
  Result:= (Pos(s, ActiveSynEdit.Text) > 0);
end;

function TEditorForm.hasWidget(const key: string; line: Integer): Boolean;
  var RegEx: string;
begin
 // if Pos('self.', key) > 0 then
 //   raise Exception.CreateFmt('Invalid name : ''%s''', ['HALLO']);
  if Pos(fIndent2, key) = 1
    then RegEx := '^' + key + '(CV|TV|LV|VC|ScrollbarH|ScrollbarV|Image|RB\d+|Tab\d+)?\b'
    else RegEx := '^[ \t]*self\.' + key + '(CV|TV|LV|VC|ScrollbarH|ScrollbarV|Image|RB\d+|Tab\d+)?\b';
  Result:= TRegEx.IsMatch(ActiveSynEdit.Lines[line], RegEx);
end;

function TEditorForm.CBSearchClassOrMethod(Stop: Boolean; line: Integer): string;
  var aClassname, aMethodname: string;
      Ci, it: IModelIterator;
      cent: TClassifier;
      Method: TOperation;
      found: Boolean;
      ClassInLine: Integer;
begin
  // ParseSourcecode;  to be done by caller
  Result:= '';
  found:= False;
  ClassInLine:= -1;
  Ci:= Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext and not found do begin
    cent:= TClassifier(Ci.Next);
    if cent.Pathname = Pathname then begin
      if cent.LineS > line then Break;
      if (cent.LineS <= Line) and (Line <= cent.LineE) then begin
        aClassname:= cent.Name;
        ClassInLine:= cent.LineS;
        aMethodname:= '';
        It:= cent.GetOperations;
        while It.HasNext and not found do begin
          Method:= It.Next as TOperation;
          if Method.LineS = line then begin
            aMethodname:= Method.Name;
            found:= True;
          end;
        end;
      end;
    end;
  end;
  if aClassname = '' then Exit;

  if Stop then begin
    if found
      then Result:= 'stop in ' + aClassname + '.' + aMethodname
      else if line > ClassInLine then
        Result:= 'stop at ' + aClassname + ':' + IntToStr(line)
    end
  else // clear
    if found
      then Result:= 'clear ' + aClassname + '.' + aMethodname
      else if line > ClassInLine then
         Result:= 'clear ' + aClassname + ':' + IntToStr(line)
end;

procedure TEditorForm.DeleteBreakpointMark(Mark: TSynEditMark);
  const StopInAt = True;
  var s: string;
begin
  s:= CBSearchClassOrMethod(not StopInAt, Mark.Line);
  {if myDebugger.Running and (s <> '') then      ToDo
    myDebugger.NewCommand(2, s);}
  ActiveSynEdit.InvalidateLine(Mark.Line);
  ActiveSynEdit.Marks.Remove(Mark);
  //Dec(BreakPointCount);
  //ResetGutterOffset;
end;

function TEditorForm.getClass(ClassNumber: Integer): TClass;
  var Ci: IModelIterator; cent: TClassifier;
begin
  Result:= nil;
  Ci := Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    if cent.Pathname = '' then Continue;
    if ClassNumber = 0 then
      Exit(cent as TClass);
    Dec(ClassNumber);
  end;
end;

function TEditorForm.getLineForMethod(ClassNumber: Integer): Integer;
  var Ci, it: IModelIterator;
      cent: TClassifier;
      Method: TOperation;
begin
  Result:= -1;
  Method:= nil;
  Ci := Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    if cent.Pathname = '' then Continue;
    if ClassNumber = 0 then begin
      It:= (cent as TClass).GetOperations;
      while It.HasNext do
        Method:= It.Next as TOperation;
      if Assigned(Method)
        then Exit(Method.LineE)
        else Exit(-1);
    end;
    Dec(ClassNumber);
  end;
end;

function TEditorForm.getConstructor(ClassNumber: Integer): TOperation;
  var it: IModelIterator;
      cent: TClassifier;
      Operation: TOperation;
begin
  cent:= getClass(ClassNumber);
  if Assigned(cent) then begin
    it:= cent.GetOperations;
    while it.HasNext do begin
      Operation:= TOperation(it.Next);
      if Operation.OperationType = otConstructor then
        Exit(Operation);
    end;
  end;
  Result:= nil;
end;

function TEditorForm.getCreateWidgets: TOperation;
  var it: IModelIterator;
      cent: TClassifier;
      Operation: TOperation;
begin
  cent:= getClass(0);
  if Assigned(cent) then begin
    it:= cent.GetOperations;
    while it.HasNext do begin
      Operation:= TOperation(it.Next);
      if Operation.Name = 'create_widgets' then
        Exit(Operation);
    end;
  end;
  Result:= nil;
end;

procedure TEditorForm.RemovePass(Classnumber: Integer);
  var i, p: Integer; s: string;
      Operation: TOperation;
begin
  Operation:= getConstructor(ClassNumber);
  if Assigned(Operation) then
    for i:= Operation.LineS + 1 to Operation.LineE do begin
      s:=  ActiveSynEdit.Lines[i - 1];
      p:= Pos('#', s);
      if p > 0 then
        Delete(s, p, Length(s));
      if Trim(s) = 'pass' then begin
        ActiveSynEdit.Lines.Delete(i-1);
        Operation.LineE:= Operation.LineE - 1;
      end;
    end;
end;

procedure TEditorForm.setAttributValue(const destination, key, s: string; after: Integer);
  var line, till: Integer; aChanged: Boolean;
begin
  aChanged:= True;
  line:= getLineNumberWithWord(key);
  till:= getLastCreateWidgetsLine;
  if (line >= 0) and (line < till) then
    if Trim(s) = ''
      then DeleteLine(line)
      else ActiveSynedit.Lines[line]:= s
  else begin
    line:= getLineNumberWithWord(destination);  // self.create_widgets, self.button1
    if (line = -1) or (line >= till) then
      line:= till
    else if after = 1 then begin
      Inc(line);
      while (line < till) and hasWidget(destination, line) do
        Inc(line);
    end;
    if line >= 0 then
      InsertLinesAt(line, s)
    else
      aChanged:= False;
  end;
  Modified:= aChanged;
end;

procedure TEditorForm.insertValue(const destination, s: string; after: Integer);
  var line, from, till: Integer; aChanged: Boolean;
begin
  aChanged:= True;
  from:= getFirstCreateWidgetsLine;
  till:= getLastCreateWidgetsLine;
  line:= getLineNumberWithWordFromTill(destination, from, till);
  if (line = -1) or (line >= till) then
    line:= till
  else
    if after = 1 then begin
      Inc(line);
      while (line < till) and hasWidget(destination, line) do
        Inc(line);
    end;
  if line >= 0 then
    InsertLinesAt(line, s)
  else
    aChanged:= False;
  Modified:= aChanged;
end;

function TEditorForm.getLastConstructorLine(ClassNumber: Integer): Integer;
  var cent: TClassifier; Operation: TOperation; Ident, s: string;
begin
  Operation:= getConstructor(ClassNumber);
  if Assigned(Operation) then
    Exit(Operation.LineE);
  cent:= GetClass(ClassNumber);
  Ident:= StringTimesN(FConfiguration.Indent1, cent.Level + 1);
  s:= Ident + 'def __init__(self):' + CrLf;
  InsertLinesAt(cent.LineSE + 1, s);
  Result:= cent.LineSE + 2;
end;

function TEditorForm.getLastCreateWidgetsLine: Integer;
  var cent: TClassifier; Operation: TOperation; Ident, s: string;
      LineS, LineE: Integer;
begin
  Result:= -1;
  LineS:= getLineNumberWith('def create_widgets(self):');
  if LineS = -1 then begin
    ParseAndCreateModel;
    cent:= GetClass(0);
    if Assigned(cent) then begin
      Ident:= StringTimesN(FConfiguration.Indent1, cent.Level + 1);
      s:= CrLf + Ident + 'def create_widgets(self):' + CrLf;
      InsertLinesAt(cent.LineE, s);
      Exit(cent.LineE + 2);
    end else
      Exit(-1);
  end;
  LineE:= getLineNumberWithWordFromTill('pass', LineS+1);
  if LineE = -1 then begin
    ParseAndCreateModel;
    Operation:= getCreateWidgets;
    if Assigned(Operation) then begin
      InsertLinesAt(Operation.LineE, FConfiguration.Indent2 + 'pass');
      Exit(Operation.LineE);
    end;
  end else
    Exit(LineE);
end;

function TEditorForm.getFirstCreateWidgetsLine: Integer;
  var cent: TClassifier; Ident, s: string;
      LineS: Integer;
begin
  LineS:= getLineNumberWith('def create_widgets(self):');
  if LineS = -1 then begin
    ParseAndCreateModel;
    cent:= GetClass(0);
    if Assigned(cent) then begin
      Ident:= StringTimesN(FConfiguration.Indent1, cent.Level + 1);
      s:= CrLf + Ident + 'def create_widgets(self):' + CrLf;
      InsertLinesAt(cent.LineE, s);
      Result:= cent.LineE;
    end else
      Result:= -1;
  end else
    Result:= LineS + 1;
end;

function TEditorForm.getLineForConstructor(ClassNumber: Integer): Integer;
  var Ci: IModelIterator;
      cent: TClassifier;
begin
  Result:= -1;
  Ci := Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    if ClassNumber = 0 then
      Exit(cent.LineSE + 1);
    Dec(ClassNumber);
  end;
end;

function TEditorForm.getFirstWidget(From: Integer; const widget: string): Integer;
begin
  Result:= -1;
  var i:= From;
  repeat
    if hasWidget(widget, i) then
      Exit(i);
    Inc(i);
  until i >= ActiveSynEdit.Lines.Count;
end;

function TEditorForm.getLineNumberWith(const s: string): Integer;
begin
  Result:= getLineNumberWithFrom(0, s);
end;

function TEditorForm.getLineNumberWithFrom(From: Integer; const s: string): Integer;
  var i: Integer;
begin
  Result:= -1;
  i:= From;
  repeat
    if (i < ActiveSynEdit.Lines.Count) and (Pos(s, ActiveSynEdit.Lines[i]) > 0) then
      Exit(i);
    Inc(i);
  until i >= ActiveSynEdit.Lines.Count;
end;

function TEditorForm.getLineNumberWithWord(const s: string): Integer;
begin
  Result:= getLineNumberWithWordFromTill(s, 0);
end;

function TEditorForm.getLineNumberWithWordFromTill(s: string; from: Integer; till: Integer=0): Integer;
  var i: Integer; RegEx: TRegEx;
begin
  Result:= -1;
  if (s <> '') and (s[Length(s)] = ']') then
    RegEx:= CompiledRegEx('\b' + TRegEx.Escape(s))
  else if Pos(fIndent2, s) = 1 then
    RegEx:= CompiledRegEx('^' + TRegEx.Escape(s) +'\b')
  else
    RegEx:= CompiledRegEx('\b' + TRegEx.Escape(s) +'\b');
  i:= From;
  if till = 0 then
    till:= ActiveSynEdit.Lines.Count;
  repeat
    if RegEx.IsMatch(ActiveSynEdit.Lines[i]) then
      Exit(i);
    Inc(i);
  until i >= Till;
end;

function TEditorForm.getSource(LineS, LineE: Integer): string;
begin
  Result:= '';
  for var i:= LineS to LineE do
    Result:= Result + ActiveSynEdit.Lines[i] + #13#10;
end;

procedure TEditorForm.ReplaceLine(const s1, s2: string);
begin
  if s1 <> s2 then begin
    var line:= getLineNumberWith(s1);
    if line >= 0 then begin
      ActiveSynEdit.Lines[line]:= s2;
      Modified:= True;
    end;
  end;
end;

procedure TEditorForm.ReplaceLineInLine(line: Integer; const old, aNew: string);
  var s: string; p: Integer;
begin
  if (0 <= line) and (line < ActiveSynEdit.Lines.Count) then begin
    s:= ActiveSynEdit.Lines[line];
    p:= pos(old, s);
    if p = 0
      then s:= ''
      else s:= Copy(s, p + Length(old), Length(s)); // preserve comments
    ActiveSynEdit.Lines[line]:= aNew + s;
    Modified:= True;
  end;
end;

procedure TEditorForm.ReplaceWord(const s1, s2: string; all: Boolean);
  var line: Integer; ws1, RegExExpr: string;
      RegEx: TRegEx; Matches: TMatchCollection; Group: TGroup;
begin
  if (s1 = s2) or (s1 = '') then Exit;
  ActiveSynEdit.BeginUpdate;
  // '(' + s1 + ')' is Groups[1]
  RegExExpr:= '\b(' + TRegEx.Escape(s1) + ')(CV|TV|LV|ScrollbarH|ScrollbarV|Image|Painter|RB\d+|Tab\d+)?';
  if not isWordBreakChar(s1[Length(s1)]) then
    RegExExpr:= RegExExpr + '\b';
  RegEx := CompiledRegEx(RegExExpr);
  line:= getLineNumberWithFrom(0, s1);
  while line >= 0 do begin // for every line
    ws1:= ActiveSynEdit.Lines[line];
    Matches:= RegEx.Matches(ws1);
    for var i:= Matches.Count - 1 downto 0 do begin
      Group:= Matches.Item[i].Groups[1];
      Delete(ws1, Group.Index, Group.Length);
      insert(s2, ws1, Group.Index);
    end;
    ActiveSynEdit.Lines[line]:= ws1;
    line:= getLineNumberWithFrom(line+1, s1);
    Modified:= True;
    if not all then
      Break;
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.ReplaceComponentname(const s1, s2: string; Events: string);
  var line: Integer; ws1, RegExExpr: string;
      RegEx: TRegEx; Matches: TMatchCollection; Group: TGroup;
begin
  if s1 = s2 then Exit;
  ReplaceWord('self.' + s1, 'self.' + s2, True);
  ActiveSynEdit.BeginUpdate;
  while Pos('|', events) = 1 do
    Delete(events, 1, 1);
  while events[Length(events)] = '|' do
    Delete(events, Length(events), 1);
  events:= events + '|Command';

  if Pos('self.', s1) > 0 then
    raise Exception.CreateFmt('Invalid name : ''%s''', [s1]);
  // '(' + s1 + ')' is Groups[1]
  RegExExpr:= '\b(' + TRegEx.Escape(s1) + ')_(' + events + ')\b';
  RegEx := CompiledRegEx(RegExExpr);
  line:= getLineNumberWithFrom(0, s1);
  while line >= 0 do begin // for every line
    ws1:= ActiveSynEdit.Lines[line];
    Matches:= RegEx.Matches(ws1);
    for var i:= Matches.Count - 1 downto 0 do begin
      Group:= Matches.Item[i].Groups[1];
      Delete(ws1, Group.Index, Group.Length);
      insert(s2, ws1, Group.Index);
    end;
    ActiveSynEdit.Lines[line]:= ws1;
    line:= getLineNumberWithFrom(line+1, s1);
    Modified:= True;
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.ReplaceAttribute(const key, s: string);
  var line: Integer;
begin
  line:= getLineNumberWithWord(key);
  if line >= 0 then begin
    ActiveSynEdit.Lines[line]:= s;
    Modified:= True;
  end else
    InsertNewAttribute(s);
end;

procedure TEditorForm.CreateModel;
  var Parser: TPythonParser;
      Module: TParsedModule;
begin
  if Assigned(SourceScanner) then begin
    Module:= SourceScanner.ParsedModule;
    Model.Lock;
    Model.Clear;
    Parser:= TPythonParser.Create(True);
    try
      Parser.ParseModul(Module, Model.ModelRoot, Model, Pathname, 0, False);
    finally
      FreeAndNil(Parser);
      Model.Unlock;
    end;
  end;
end;

procedure TEditorForm.ParseAndCreateModel;
begin
  fNeedToParseModule:= True;
  ReparseIfNeeded;
end;

procedure TEditorForm.pmnuEditorPopup(Sender: TObject);
begin
  mnEditGit.Visible:= FConfiguration.gitOK;
  mnEditCut.ImageIndex:= -1;
  mnEditCopy.ImageIndex:= -1;
  mnEditPaste.ImageIndex:= -1;
  mnEditDelete.ImageIndex:= -1;
end;

procedure TEditorForm.NewClass(Pathname: string);
  var s, FName, Indent: string;
      p: Integer;
begin
  FName:= ChangeFileExt(ExtractFilename(Pathname), '');
  Indent:= FConfiguration.Indent1;
  s:= FConfiguration.getClassCodeTemplate;

  if s = '' then
    s:= 'class ' + FName + ':' + CrLf +
        Indent + CrLf +
        Indent + 'def __init__(self):' + CrLf +
        Indent + Indent + 'pass'
  else begin
    p:= Pos('|', s);
    insert(FName, s, p + 1);
    Delete(s, p, 1);
  end;

  ActiveSynEdit.Clear;
  PutText(s);
  DoSave;
  ParseAndCreateModel;
  Modified:= False;
  // ActiveSynedit.Undolist.Clear;
end;

procedure TEditorForm.ExportToClipboard(Lines: TStringList; Exporter: TSynCustomExporter; asText: Boolean);
begin
  with Exporter do begin
    // python source code can be exported as RTF or HTML
    // the exporter must know the highlighter;
    Highlighter:= ActiveSynEdit.Highlighter;
    ExportAsText:= asText;
    ExportAll(Lines);
    Exporter.CopyToClipboard;
  end;
end;

function TEditorForm.getNumbered: TStringList;
  var Lines: TStringList; i, digits: Integer;

  function getFormatted(i, digits: Integer): string;
    var s: string;
  begin
    s:= intToStr(i);
    while Length(s) < digits do
      s:= '0' + s;
    result:= s + ' ';
  end;

begin
  Lines:= TStringList.Create;
  Lines.Text:= ActiveSynEdit.SelText;
  digits:= 3;
  if Lines.Count < 100 then digits:= 2;
  if Lines.Count < 10  then digits:= 1;
  for i:= 0 to Lines.Count-1 do
    Lines[i]:= getFormatted(i+1, digits) + Lines[i];
  Result:= Lines;
end;

procedure TEditorForm.CopyRTF;
  var Lines: TStringList;
      RTFExporter: TSynExporterRTF;
begin
  Lines:= TStringList.Create;
  Lines.Text:= ActiveSynEdit.SelText;
  RTFExporter:= TSynExporterRTF.Create(Self);
  ExportToClipboard(Lines, RTFExporter, False);
  FreeAndNil(Lines);
  FreeAndNil(RTFExporter);
end;

procedure TEditorForm.CopyRTFNumbered;
  var Lines: TStringList;
      RTFExporter: TSynExporterRTF;
begin
  Lines:= getNumbered;
  RTFExporter:= TSynExporterRTF.Create(Self);
  ExportToClipboard(Lines, RTFExporter, False);
  FreeAndNil(Lines);
  FreeAndNil(RTFExporter);
end;

procedure TEditorForm.CopyHTML(asText: Boolean);
begin
  var Lines:= TStringList.Create;
  Lines.Text:= ActiveSynEdit.SelText;
  var HTMLExporter:= TSynExporterHTML.Create(Self);
  if not asText then
    HTMLExporter.CreateHTMLFragment:= True;
  ExportToClipboard(Lines, HTMLExporter, asText);
  FreeAndNil(Lines);
  FreeAndNil(HTMLExporter);
end;

procedure TEditorForm.CopyNumbered;
begin
  var Lines:= getNumbered;
  Clipboard.AsText:= Lines.Text;
  FreeAndNil(Lines);
end;

procedure TEditorForm.ExportToFile(const filename: string; Exporter: TSynCustomExporter);
begin
  with Exporter do begin
    Highlighter := ActiveSynEdit.Highlighter;
    ExportAsText := True;
    ExportAll(ActiveSynEdit.Lines);
    try
      SaveToFile(filename);
    except
      on E: Exception do
        ErrorMsg(E.Message);
    end;
  end;
end;

procedure TEditorForm.DoExport;
  var folder: string;
      Exporter: TSynCustomExporter;
begin
  with ResourcesDataModule.dlgFileSave do begin
    Title:= _('Export to');
    Filter:= 'RTF (*.rtf)|*.rtf|HTML (*.html)|*.html;*.htm';
    FileName:= Pathname;
    folder:= ExtractFilePath(FileName);
    FileName:= ChangeFileExt(FileName, '');
    if folder <> ''
      then InitialDir:= folder
      else InitialDir:= GuiPyOptions.Sourcepath;
    if Execute then begin
      if ExtractFileExt(FileName) = '' then
        case FilterIndex of
          1: FileName:= FileName + '.rtf';
          2: FileName:= FileName + '.html';
        end;
      if not FileExists(FileName) or
         FileExists(FileName) and
         (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [FileName]),
                       mtConfirmation, mbYesNoCancel,0) = mrYes)
      then begin
        if LowerCase(ExtractFileExt(FileName)) = '.rtf'
          then Exporter:= TSynExporterRTF.Create(Self)
          else Exporter:= TSynExporterHTML.Create(Self);
        Exporter.Font.assign(ActiveSynEdit.Font);
        ExportToFile(FileName, Exporter);
        if CanFocus then SetFocus;
        GuiPyOptions.Sourcepath:= ExtractFilePath(FileName);
        FreeAndNil(Exporter);
      end
    end;
  end;
end;

// compare to procedure TFUMLForm.CreateTVFileStructure;
procedure TEditorForm.CreateTVFileStructure;
  var
    Ci, it, Fi: IModelIterator;
    cent: TClassifier;
    Attribute: TAttribute;
    Method, Operation: TOperation;
    ImageNr, i, indented, indentedOld: Integer;
    CName: string;
    Node: TTreeNode;
    ClassNode: TTreeNode;
    aInteger: TInteger;

  function CalculateIndented(const aClassname: string): Integer;
    var i: Integer;
  begin
    Result:= 0;
    for i:= 1 to Length(aClassname) do
      if CharInSet(aClassname[i], ['$', '.']) then Inc(Result);
  end;

  procedure AddOperationNode(Operation: TOperation);
    var Node: TTreeNode;
  begin
    Node:= TVFileStructure.Items.AddObject(nil,
      Operation.toShortStringNode, TInteger.Create(Operation.LineS));
    Node.ImageIndex:= 15;
    Node.SelectedIndex:= 15;
    Node.HasChildren:= False;
  end;

  procedure AddFunctions(BeforeLine: Integer);
  begin
    if Assigned(Operation) and (Operation.LineE < BeforeLine) then
      AddOperationNode(Operation);
    while Fi.hasNext do begin
      Operation:= TOperation(Fi.Next);
      if Operation.LineE < BeforeLine
        then AddOperationNode(Operation)
        else Break;
    end;
  end;

begin
  indented:= 0;
  Classnode:= nil;
  Operation:= nil;
  if not isPython then Exit;
  TVFileStructure.Items.BeginUpdate;
  //TVFileStructure.Images:= FFileStructure.vilFileStructureLight;
  try
    for i:= TVFileStructure.Items.Count - 1 downto 0 do begin
      aInteger:= TInteger(TVFileStructure.Items[i].Data);
      FreeAndNil(aInteger);
    end;
    TVFilestructure.Items.Clear;
    Fi:= Model.ModelRoot.GetFunctions;
    Ci:= Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      cent := TClassifier(Ci.Next);
      if Cent.Pathname <> Pathname then Continue;
      if Cent.Name.endsWith('[]') then Continue;
      AddFunctions(cent.LineS);

      {if (Cent is TClass)
        then isJUnitTestClass:= (Cent as TClass).isJUnitTestclass
        else isJunitTestClass:= false;
      }

      CName:= cent.ShortName;
      indentedOld:= indented;
      indented:= cent.Level;
      while Pos('$', CName) + Pos('.', CName) > 0 do begin
        Delete(CName, 1, Pos('$', CName));
        Delete(CName, 1, Pos('.', CName));
      end;

      if indented = 0 then
        ClassNode:= TVFileStructure.Items.AddObject(nil, CName, TInteger.Create(cent.LineS))
      else if indented > indentedOld then
        ClassNode:= TVFileStructure.Items.AddChildObject(ClassNode, CName, TInteger.Create(cent.LineS))
      else begin
        while indented <= indentedOld do begin
          Dec(indentedOld);
          ClassNode:= ClassNode.Parent;
        end;
        ClassNode:= TVFileStructure.Items.AddChildObject(ClassNode, CName, TInteger.Create(cent.LineS));
      end;

      ClassNode.ImageIndex:= 0;
      ClassNode.SelectedIndex:= 0;
      ClassNode.HasChildren:= True;

      it:= cent.GetAttributes;
      while It.HasNext do begin
        Attribute:= It.Next as TAttribute;
        ImageNr:= 1 + Integer(Attribute.Visibility);
        Node:= TVFileStructure.Items.AddChildObject(ClassNode,
          Attribute.toNameTypeUML, TInteger.Create(Attribute.LineS));
        Node.ImageIndex:= ImageNr;
        Node.SelectedIndex:= ImageNr;
        Node.HasChildren:= False;
      end;
      It:= cent.GetOperations;
      while It.HasNext do begin
        Method:= It.Next as TOperation;
        if Method.OperationType = otConstructor
          then ImageNr:= 4
          else ImageNr:= 5 + Integer(Method.Visibility);
        Node:= TVFileStructure.Items.AddChildObject(ClassNode,
          Method.toShortStringNode, TInteger.Create(Method.LineS));
        Node.ImageIndex:= ImageNr;
        Node.SelectedIndex:= ImageNr;
        Node.HasChildren:= False;
      end;
    end;
    AddFunctions(MaxInt);
  finally
    TVFileStructure.Items.EndUpdate;
    FFileStructure.init(TVFileStructure.Items, Self);
  end;
  // PyIDEMainForm.Memo1.lines.AddStrings(Model.ModelRoot.Debug);
end;

procedure TEditorForm.CollectClasses(SL: TStringList);
  var
    Ci: IModelIterator;
    cent: TModelEntity;
begin
  if IsPython then begin
    Ci:= Model.ModelRoot.GetAllClassifiers;
    while Ci.HasNext do begin
      cent:= Ci.Next;
      if (cent is TClass) or (cent is TInterface) then
        SL.Add(WithoutArray(cent.Name));
    end;
  end;
end;

procedure TEditorForm.DoUpdateCaption;
var
  TabCaption : string;
begin
  Assert(fEditor <> nil, 'TEditorForm.DoUpdateCaption');
  if fEditor.fRemoteFileName <> '' then
    TabCaption := TPath.GetFileName(fEditor.fRemoteFileName)
  else
    TabCaption := fEditor.GetFileTitle;

  SynEdit.AccessibleName := TabCaption;
  SynEdit2.AccessibleName := TabCaption;

  with ParentTabItem do
  begin
    Caption := StringReplace(TabCaption, '&', '&&', [rfReplaceAll]);
    Hint := fEditor.GetFileId;
  end;
  PyIDEMainForm.UpdateCaption;
end;

function TEditorForm.getFrameType: Integer;
  var PythonScanner: TPythonScannerWithTokens;
begin
  if (FFrameType = 0) and (DefaultExtension = 'pyw') then begin
    PythonScanner:= TPythonScannerWithTokens.Create;
    PythonScanner.Init(SynEdit.Lines.Text);
    FFrameType:= PythonScanner.GetFrameType;
    PythonScanner.Destroy;
  end;
  Result:= FFrameType;
end;

function TEditorForm.getActiveSynEdit: TSynEdit;
begin
  Result:= fEditor.getActiveSynEdit;
end;

procedure TEditorForm.EditorShowHint(var HintStr: string; var CanShow:
    Boolean; var HintInfo: Vcl.Controls.THintInfo);

  function CursorRect(SynEd: TCustomSynEdit; const BC1, BC2: TBufferCoord;
    out HintPos: TPoint): TRect;
  begin
    var P1 := SynEd.RowColumnToPixels(SynEd.BufferToDisplayPos(BC1));
    var P2 := SynEd.RowColumnToPixels(SynEd.BufferToDisplayPos(BC2));
    Inc(P2.Y, SynEd.LineHeight);

    HintPos := SynEd.ClientToScreen(Point(P1.X, P2.Y));
    Result := TRect.Create(P1,P2);
  end;

var
  Indicator: TSynIndicator;
  BC1, BC2: TBufferCoord;
  TokenType, Start: Integer;
  Token, DottedIdent: string;
  Attri: TSynHighlighterAttributes;
begin
  CanShow := False;

  // No hints for Gutter
  var SynEd := HintInfo.HintControl as TCustomSynEdit;
  if (SynEd.Gutter.Visible) and (HintInfo.CursorPos.X < SynEd.GutterWidth) then
    Exit;
  var Highlighter := TSynPythonSyn(SynEd.Highlighter);

  var DC := SynEd.PixelsToNearestRowColumn(HintInfo.CursorPos.X, HintInfo.CursorPos.Y);
  var BC := SynEd.DisplayToBufferPos(DC);

  // Diagnostic errors hints first
  if (FEditor.FSynLsp.Diagnostics.Count > 0) and
    SynEd.Indicators.IndicatorAtPos(BC,
    FEditor.FSynLsp.DiagnosticsErrorIndicatorSpec, Indicator)
  then
  begin
    CanShow := True;
    BC1 := BufferCoord(Indicator.CharStart, BC.Line);
    BC2 := BufferCoord(Indicator.CharEnd, BC.Line);
    // Setting HintInfo.CursorRect is important.  Otherwise no other hint
    // will be shown unlessmouse leaves and reenters the control
    HintInfo.CursorRect := CursorRect(SynEd, BC1, BC2, HintInfo.HintPos);
    HintStr := FEditor.FSynLsp.Diagnostics[Indicator.Tag].Msg;
  end
  else if fEditor.HasPythonFile and not SynEd.IsPointInSelection(BC) and
    SynEd.GetHighlighterAttriAtRowColEx(BC, Token, TokenType, Start, Attri) and
    (((PyControl.DebuggerState in [dsPaused, dsPostMortem]) and
       PyIDEOptions.ShowDebuggerHints) or
       (GI_PyControl.Inactive and PyIDEOptions.ShowCodeHints)) and
    ((Attri = Highlighter.IdentifierAttri) or
     (Attri = Highlighter.NonKeyAttri) or
     (Attri = Highlighter.SystemAttri) or
      // bracketed debugger expression
     ((Attri = Highlighter.SymbolAttri) and
      (PyControl.DebuggerState in [dsPaused, dsPostMortem]) and
      ((Token = ')') or (Token = ']')))) then
  begin
    // LSP or debugger hints
    if GI_PyControl.Inactive then
    begin
      BC1 := BufferCoord(Start, BC.Line);
      BC2 := BufferCoord(Start + Token.Length, BC.Line);
    end
    else
    begin
      var LineTxt := SynEd.Lines[BC.Line - 1];
      DottedIdent := GetWordAtPos(LineTxt, BC.Char,
        True, True, False, True);
      BC1 := BufferCoord(BC.Char - Length(DottedIdent) + 1, BC.Line);
      DottedIdent := DottedIdent + GetWordAtPos(LineTxt,
        BC.Char + 1, False, False, True);
      BC2 := BufferCoord(BC1.Char + DottedIdent.Length, BC.Line);
    end;
    HintInfo.CursorRect := CursorRect(SynEd, BC1, BC2, HintInfo.HintPos);

    if (FHintCursorRect = HintInfo.CursorRect) and Assigned(FHintFuture) and
      (FHintFuture.Status = TTaskStatus.Completed) then
    begin
      HintStr := FHintFuture.Value;
      CanShow := HintStr <> '';
      FHintFuture := nil;
    end
    else
    begin
      CanShow := False;
      FHintCursorRect := HintInfo.CursorRect;
      HintInfo.ReshowTimeout := 200;

      if GI_PyControl.Inactive then
      begin
        // LSP code hints
        FHintFuture := TFuture<string>.Create(nil, nil,
          function : string
          begin
            Result := TJedi.CodeHintAtCoordinates(FEditor.GetFileId,
              BC1, Token);
          end, TThreadPool.Default).Start;
      end
      else
      begin
        // Debugger hints
        FHintFuture := TFuture<string>.Create(nil, nil,
          function : string
          var
            ObjectValue, ObjectType: string;
          begin
            PyControl.ActiveDebugger.Evaluate(DottedIdent, ObjectType,
              ObjectValue);
            if ObjectValue <> _(SNotAvailable) then
            begin
              ObjectValue := HTMLSafe(ObjectValue);
              ObjectType := HTMLSafe(ObjectType);
              Result := Format(_(SDebuggerHintFormat),
                [DottedIdent, ObjectType, ObjectValue]);
            end
            else
              Result := '';
          end, TThreadPool.Default).Start;
      end;
    end;
  end
  else
    FHintFuture := nil;

  if CanShow then
  begin
    HintInfo.HintData := Pointer(NativeInt(SynEd.LineHeight));
    HintInfo.HintWindowClass := TCodeHintWindow;
    FHintFuture := nil;
  end;

end;

class function TEditorForm.ToolbarCount: Integer;
begin
  Result:= 28;
end;

initialization
  GI_EditorFactory := TEditorFactory.Create;
  GI_FileFactory := IFileFactory(GI_EditorFactory);
  TCodeHintWindow.OnHyperLinkClick := TEditorForm.CodeHintLinkHandler;

finalization
  GI_EditorFactory := nil;    // calls TEditorFactory.Destroy
end.
