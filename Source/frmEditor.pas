{ -----------------------------------------------------------------------------
  Unit Name: frmEditor
  Author:    Kiriakos Vlahos, Gerhard Röhner
  Date:      23-Feb-2005
  Purpose:
  History:   Originally Based on SynEdit Demo
  ----------------------------------------------------------------------------- }

unit frmEditor;

interface

uses
  Winapi.Messages,
  Winapi.D2D1,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Contnrs,
  System.ImageList,
  System.Threading,
  System.Messaging,
  Vcl.ComCtrls,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Menus,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.ToolWin,
  Vcl.VirtualImageList,
  TB2Item,
  SpTBXItem,
  SpTBXSkins,
  SpTBXDkPanels,
  SpTBXTabs,
  SynEdit,
  SynEditTypes,
  SynEditMiscClasses,
  SynEditExport,
  SynCompletionProposal,
  SynEditLsp,
  VirtualResources,
  FileSystemMonitor,
  uEditAppIntfs,
  cPySupportTypes,
  cPythonSourceScanner,
  frmFile,
  UModel;

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
    N5Sep: TSpTBXSeparatorItem;
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
    pmnuBreakpoint: TSpTBXPopupMenu;
    spiBreakpointEnabled: TSpTBXItem;
    spiBreakpointProperties: TSpTBXItem;
    spiSeparatorItem: TSpTBXSeparatorItem;
    spiBreakpointClear: TSpTBXItem;
    procedure SynEditChange(Sender: TObject);
    procedure SynEditEnter(Sender: TObject);
    procedure SynEditExit(Sender: TObject);
    procedure SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var Foreground, Background: TColor);
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
      const LineCharPos: TBufferCoord; var Cursor: TCursor);
    procedure SynEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynCodeCompletionExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: string; var X, Y: Integer; var CanExecute: Boolean);
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
    procedure SynEditGutterGetText(Sender: TObject; Line: Integer;
      var Text: string);
    procedure SynEditDebugInfoPaintLines(RenderTarget: ID2D1RenderTarget;
      ClipR: TRect; const FirstRow, LastRow: Integer;
      var DoDefaultPainting: Boolean);
    procedure SynEditGutterDebugInfoCLick(Sender: TObject; Button: TMouseButton;
      X, Y, Row, Line: Integer);
    procedure SynEditGutterDebugInfoMouseCursor(Sender: TObject;
      X, Y, Row, Line: Integer; var Cursor: TCursor);
    procedure EditorShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: Vcl.Controls.THintInfo);
    procedure BreakpointContextPopup(Sender: TObject; MousePos: TPoint;
      Row, Line: Integer; var Handled: Boolean);
    procedure spiBreakpointEnabledClick(Sender: TObject);
    procedure spiBreakpointPropertiesClick(Sender: TObject);
    procedure spiBreakpointClearClick(Sender: TObject);

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
  private const
    HotIdentIndicatorSpec: TGUID = '{8715589E-C990-4423-978F-F00F26041AEF}';
  private
    FEditor: TEditor;
    FActiveSynEdit: TSynEdit;
    FAutoCompleteActive: Boolean;
    FHotIdentInfo: THotIdentInfo;
    FNeedToSyncCodeExplorer: Boolean;
    FOldCaretY: Integer;
    // Hints
    FHintFuture: IFuture<string>;
    FHintCursorRect: TRect;
    FNeedToParseModule: Boolean;
    FNeedToSyncFileStructure: Boolean;
    FPartner: TForm;
    FIndent1: string;
    FIndent2: string;
    FIndent3: string;
    FBookmark: Integer;
    FMouseIsInBorderOfStructure: Boolean;
    FMouseBorderOfStructure: Integer;
    FFrameType: Integer; // 3 = Qt, 2 = Tk, 1 = else, 0 unknown
    FBorderHighlight: TColor;
    FBorderNormal: TColor;
    FBreakPoints: TBreakpointList;
    FHasFocus: Boolean;
    FHasSearchHighlight: Boolean;
    FFoundSearchItems: TObjectList;
    FSourceScanner: IAsyncSourceScanner;
    FModel: TObjectModel;

    class var FOldEditorForm: TEditorForm;

    procedure AutoCompleteBeforeExecute(Sender: TObject);
    procedure AutoCompleteAfterExecute(Sender: TObject);
    procedure SynCodeCompletionCodeItemInfo(Sender: TObject; AIndex: Integer;
      var Info: string);
    procedure DoAssignInterfacePointer(Active: Boolean);
    function DoSave: Boolean;
    procedure SetNeedsParsing(Value: Boolean);
    procedure SetToolButtons;
    procedure TBControlStructures(KTag: Integer; OnKey: Boolean = False);
    procedure SetDeleteBookmark(XPos, YPos: Integer);
    procedure Unindent;
    procedure Indent;
    procedure SelStructure(var LineNo: Integer);
    function GetControlStructure(KTag: Integer; const Indent: string;
      Block: string): string;
    function BeginOfStructure(Line: string): Boolean;
    function GetNumbered: TStringList;
    procedure ChangeStyle;
    function GetFrameType: Integer;
    function GetActiveSynEdit: TSynEdit;
    procedure ApplyPyIDEOptions(const Sender: TObject; const Msg:
        System.Messaging.TMessage);
    procedure ScrollbarAnnotationGetInfo(Sender: TObject;
      AnnType: TSynScrollbarAnnType; var Rows: TArray<Integer>;
      var Colors: TArray<TColor>);
    class procedure DoCodeCompletion(Editor: TSynEdit; Caret: TBufferCoord);
    class procedure SymbolsChanged(Sender: TObject);
    class procedure CodeHintLinkHandler(Sender: TObject; LinkName: string);
  protected
    procedure Retranslate; override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
    function DoSaveFile: Boolean; override;
    function DoSaveAs: Boolean; override;
    function DoSaveAsRemote: Boolean; override;
    function OpenFile(const FileName: string): Boolean; override;
    function DoAskSaveChanges: Boolean; override;
    procedure SetModified(Value: Boolean); override;
    function GetModified: Boolean; override;
  public
    procedure ApplyEditorOptions;
    procedure DoActivate;
    procedure DoActivateEditor(Primary: Boolean = True);
    function DoActivateView(ViewFactory: IEditorViewFactory): IEditorView;
    function GetEditor: IEditor;
    procedure EditorCommandHandler(Sender: TObject; AfterProcessing: Boolean;
      var Handled: Boolean; var Command: TSynEditorCommand; var AChar: WideChar;
      Data: Pointer; HandlerData: Pointer);
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
    function IsPython: Boolean;
    function IsPythonAndGUI: Boolean;
    function IsHTML: Boolean;
    function IsCSS: Boolean;
    procedure GotoLine(Line: Integer);
    procedure GotoWord(const Word: string);
    procedure PutText(Source: string; WithCursor: Boolean = True);
    function GetGeometry: TPoint;
    function GetIndent: string;

    function CBSearchClassOrMethod(Stop: Boolean; Line: Integer): string;
    procedure DeleteBreakpointMark(Mark: TSynEditMark);
    procedure CreateTVFileStructure;

    function GetClass(ClassNumber: Integer): TClass;
    function GetConstructor(ClassNumber: Integer): TOperation;
    function GetCreateWidgets: TOperation;
    function GetLastConstructorLine(ClassNumber: Integer): Integer;
    function GetLastCreateWidgetsLine: Integer;
    function GetFirstCreateWidgetsLine: Integer;
    function GetLineForConstructor(ClassNumber: Integer): Integer;
    function GetLineForMethod(ClassNumber: Integer): Integer;
    function GetFirstWidget(From: Integer; const Widget: string): Integer;

    function GetLineNumberWith(const Text: string): Integer;
    function GetLineNumberWithFrom(From: Integer; const Text: string): Integer;
    function GetLineNumberWithWord(const Word: string): Integer;
    function GetLineNumberWithWordFromTill(const Word: string; From: Integer;
      Till: Integer = 0): Integer;
    function GetLineNumberOfBinding(const Name, Attr: string): Integer;
    function GetSource(LineS, LineE: Integer): string;
    function GetLinesWithSelection: string;

    procedure ReplaceLine(const Str1, Str2: string);
    procedure ReplaceLineInLine(Line: Integer; const Old, New: string);
    procedure ReplaceWord(const Word1, Word2: string; All: Boolean);
    procedure ReplaceComponentname(const Name1, Name2: string; Events: string);
    procedure ReplaceAttribute(const Key, Attr: string);
    procedure RemovePass(ClassNumber: Integer);
    procedure SetAttributValue(const Destination, Key, Value: string;
      After: Integer);

    procedure InsertValue(const Destination, Value: string; After: Integer);
    procedure InsertLinesAt(Line: Integer; ALines: string); overload;
    procedure InsertNewAttribute(const Attribute: string);
    procedure InsertAtBegin(const Text: string);
    procedure InsertAtEnd(const Text: string);
    procedure InsertAttributeCE(const Attribute: string; ClassNumber: Integer);
    procedure InsertTkBinding(const Name, Attr, Binding: string);
    procedure InsertQtBinding(const Name, Binding: string);
    procedure InsertProcedure(const AProcedure: string;
      ClassNumber: Integer = 0);
    procedure InsertProcedureWithoutParse(const AProcedure: string;
      ClassNumber: Integer = 0);
    procedure InsertConstructor(const AConstructor: string;
      ClassNumber: Integer);
    procedure InsertImport(Module: string);

    procedure DeleteAttribute(const Attribute: string);
    procedure DeleteAttributeCE(const Attribute: string; ClassNumber: Integer);
    procedure DeleteAttributeValues(const Values: string);
    procedure DeleteEmptyLine(Line: Integer);
    procedure DeleteLine(Line: Integer); overload;
    procedure DeleteLine(const Line: string); overload;
    procedure DeleteBlock(StartLine, EndLine: Integer);
    procedure DeleteComponent(Control: TControl);
    procedure DeleteMethod(const Method: string);
    procedure DeleteOldAddNewMethods(OldMethods, NewMethods: TStringList);
    procedure DeleteBinding(const Binding: string);
    procedure DeleteItems(const Name, Key: string);

    procedure MoveBlock(From, Till, Dest, DestTill: Integer;
      const BlankLines: string);
    procedure ToForeground(Control: TControl);
    procedure ToBackground(Control: TControl);

    procedure GoTo2(const Str: string);
    procedure ShowTopLine(LineNum: Integer; const NodeText: string);
    function HasText(const Text: string): Boolean;
    function HasWidget(const Key: string; Line: Integer): Boolean;

    procedure CreateModel;
    procedure ParseAndCreateModel;
    procedure NewClass(const Pathname: string);
    procedure ExportToClipboard(LineS: TStringList;
      Exporter: TSynCustomExporter; AsText: Boolean);
    procedure CopySelected;
    procedure CopyRTF;
    procedure CopyRTFNumbered;
    procedure CopyHTML(AsText: Boolean);
    procedure CopyNumbered;
    procedure ExportToFile(const FileName: string;
      Exporter: TSynCustomExporter);
    procedure DoExport; override;
    procedure CollectClasses(StringList: TStringList); override;
    procedure DoUpdateCaption; override;
    procedure CollapseGUICreation;
    function IsGUICreationCollapsed: Boolean;
    procedure DoUpdateHighlighter(const HighlighterName: string = '');
    function GetFileFormat: string;
    class function ToolbarCount: Integer;

    property Partner: TForm read FPartner write FPartner;
    property NeedsParsing: Boolean read FNeedToParseModule
      write SetNeedsParsing;
    property ActiveSynEdit: TSynEdit read GetActiveSynEdit;
    property FrameType: Integer read GetFrameType;
    property Modified: Boolean read GetModified write SetModified;
    property Model: TObjectModel read FModel;
  end;

  TEditor = class(TFile, IUnknown, IEditor, IFileCommands, ISearchCommands)
  private
    FForm: TEditorForm;
    FSynLsp: TLspSynEditPlugin;
    FGUIFormOpen: Boolean;

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
    procedure OpenLocalFile(const AFilename: string;
      const HighlighterName: string = '');
    function HasPythonFile: Boolean;
    function GetReadOnly: Boolean;
    procedure SetHasSearchHighlight(Value: Boolean);
    procedure SetHighlighter(const HighlighterName: string);

    function GetGUIFormOpen: Boolean;
    procedure SetGuiFormOpen(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
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
  public
    constructor Create(AForm: TFileForm); reintroduce;
    destructor Destroy; override;

    procedure DoSetFilename(const FileName: string); override;
    procedure OpenRemoteFile(const FileName, Servername: string); override;
    function SaveToRemoteFile(const FileName, Servername: string)
      : Boolean; override;
  end;

implementation

{$R *.DFM}

uses
  Winapi.Windows,
  Clipbrd,
  System.SysUtils,
  Vcl.Dialogs,

  System.Math,
  RegularExpressions,
  PythonEngine,
  IOUtils,
  System.DateUtils,
  System.SyncObjs,
  System.Generics.Collections,
  JclFileUtils,
  SynEditHighlighter,
  SynEditKeyCmds,

  SynEditTextBuffer,
  SynHighlighterWebMisc,
  SynHighlighterWeb,
  SynHighlighterPython,
  SynEditMiscProcs,
  SynDWrite,
  SynExportRTF,
  SynExportHTML,
  JvDockControlForm,
  JvGnugettext,
  StringResources,
  dmResources,
  dmCommands,
  dlgSynPrintPreview,
  dlgRemoteFile,
  frmPyIDEMain,
  frmMessages,
  uSearchHighlighter,
  cPyDebugger,
  cCodeHint,
  cPyScripterSettings,
  cSSHSupport,
  cTools,

  uCommonFunctions,
  UPythonIntegrator,
  frmCodeExplorer,
  cLspClients,
  cPyControl,
  cCodeCompletion,

  UUtils,
  UConfiguration,
  UModelEntity,
  UGUIForm,
  UGUIDesigner,
  UBrowser,
  UFileStructure,
  UBaseWidgets,
  UPythonScanner,
  UGit;

const WM_DELETETHIS = WM_USER + 42;

{$REGION 'TDebugSupportPlugin'}

type
  TDebugSupportPlugin = class(TSynEditPlugin)
  protected
    FForm: TEditorForm;
    procedure LinesInserted(FirstLine, Count: Integer); override;
    procedure LinesDeleted(FirstLine, Count: Integer); override;
  public
    constructor Create(AForm: TEditorForm);
  end;

constructor TDebugSupportPlugin.Create(AForm: TEditorForm);
begin
  inherited Create(AForm.SynEdit);
  FHandlers := [phLinesInserted, phLinesDeleted, phAfterPaint];
  FForm := AForm;
end;

procedure TDebugSupportPlugin.LinesInserted(FirstLine, Count: Integer);
begin
  with FForm do
  begin
    for var I := 0 to FBreakPoints.Count - 1 do
      if TBreakpoint(FBreakPoints[I]).LineNo >= FirstLine then
      begin
        TBreakpoint(FBreakPoints[I]).LineNo := TBreakpoint(FBreakPoints[I])
          .LineNo + Count;
        GI_BreakpointManager.BreakpointsChanged := True;
      end;
  end;
end;

procedure TDebugSupportPlugin.LinesDeleted(FirstLine, Count: Integer);
begin
  with FForm do
  begin
    for var I := FBreakPoints.Count - 1 downto 0 do
      if TBreakpoint(FBreakPoints[I]).LineNo >= FirstLine + Count then
      begin
        TBreakpoint(FBreakPoints[I]).LineNo := TBreakpoint(FBreakPoints[I])
          .LineNo - Count;
        GI_BreakpointManager.BreakpointsChanged := True;
      end
      else if TBreakpoint(FBreakPoints[I]).LineNo >= FirstLine then
      begin
        FBreakPoints.Delete(I);
        GI_BreakpointManager.BreakpointsChanged := True;
      end;
  end;
end;

{$ENDREGION 'TDebugSupportPlugin'}
{$REGION 'TEditor'}

constructor TEditor.Create(AForm: TFileForm);
begin
  inherited Create(fkEditor, AForm);
  FForm := TEditorForm(AForm);
  SetFileEncoding(PyIDEOptions.NewFileEncoding);
  FSynLsp := TLspSynEditPlugin.Create(FForm.SynEdit);
  FSynLsp.DocSymbols.OnNotify := FForm.SymbolsChanged;
  CodeExplorerWindow.UpdateWindow(FSynLsp.DocSymbols, ceuEditorEnter);
end;

procedure TEditor.Activate(Primary: Boolean = True);
begin
  if Assigned(FForm) then
    FForm.DoActivateEditor(Primary);
end;

function TEditor.ActivateView(ViewFactory: IEditorViewFactory): IEditorView;
begin
  if Assigned(FForm) then
    Result := FForm.DoActivateView(ViewFactory)
  else
    Result := nil;
end;

procedure TEditor.Close;
// Closes without asking
begin
  if Assigned(FForm) then
  begin
    FSynLsp.FileClosed;
    FForm.DoAssignInterfacePointer(False);
    GI_EditorFactory.RemoveEditor(Self);
    if GI_EditorFactory.Count = 0 then
      PyIDEMainForm.UpdateCaption;
    inherited;
  end;
end;

destructor TEditor.Destroy;
begin
  // Unregister existing File Notification
  if FileName <> '' then
    GI_FileSystemMonitor.RemoveFile(FileName, FileChanged);
  inherited;
end;

procedure TEditor.DoSetFilename(const FileName: string);
begin
  FForm.FNeedToParseModule := True;
  inherited DoSetFilename(FileName);
end;

function TEditor.GetSynEdit: TSynEdit;
begin
  if Assigned(FForm) then
    Result := FForm.SynEdit
  else
    Result := nil;
end;

function TEditor.GetSynEdit2: TSynEdit;
begin
  if Assigned(FForm) then
    Result := FForm.SynEdit2
  else
    Result := nil;
end;

function TEditor.GetTabControlIndex: Integer;
begin
  Result := PyIDEMainForm.TabControlIndex(FForm.ParentTabControl);
end;

function TEditor.GetActiveSynEdit: TSynEdit;
begin
  if not Assigned(FForm) then
    Exit(nil);

  if FForm.SynEdit2.Visible and (FForm.FActiveSynEdit = FForm.SynEdit2) then
    Result := FForm.SynEdit2
  else
    Result := FForm.SynEdit;
end;

function TEditor.GetBreakPoints: TObjectList;
begin
  Result := FForm.FBreakPoints;
end;

function TEditor.GetCaretPos: TPoint;
begin
  if Assigned(FForm) then
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
  if Assigned(FForm) then
    Result := FForm.GetFileFormat
  else
    Result := '';
end;

function TEditor.GetEditorState: string;
begin
  if Assigned(FForm) then
  begin
    if FForm.SynEdit.ReadOnly then
      Result := _(SReadOnly)
    else if FForm.SynEdit.InsertMode then
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
  Result := WideStringsToEncodedText(GetFileId, FForm.SynEdit.LineS,
    EncodedText, InformationLossWarning, HasPythonFile);
end;

function TEditor.GetFileName: string;
begin
  Result := FileName;
end;

function TEditor.GetFileTitle: string;
begin
  if (FileName <> '') or (SSHServer <> '') then
    Result := inherited
  else
  begin
    if FUntitledNumber = -1 then
      FUntitledNumber := GetUntitledNumber;
    if FForm.SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn then
      Result := _(SNonamePythonFileTitle) + IntToStr(FUntitledNumber)
    else
      Result := _(SNonameFileTitle) + IntToStr(FUntitledNumber);
  end;
end;

function TEditor.GetModified: Boolean;
begin
  if Assigned(FForm) then
    Result := FForm.SynEdit.Modified
  else
    Result := False;
end;

procedure TEditor.SetModified(Value: Boolean);
begin
  if Assigned(FForm) then
    FForm.SynEdit.Modified := Value;
end;

function TEditor.GetReadOnly: Boolean;
begin
  Result := GetSynEdit.ReadOnly;
end;

function TEditor.GetGUIFormOpen: Boolean;
begin
  Result := FGUIFormOpen;
end;

procedure TEditor.SetGuiFormOpen(Value: Boolean);
begin
  FGUIFormOpen := Value;
end;

function TEditor.GetSSHServer: string;
begin
  Result := SSHServer;
end;

function TEditor.GetFileEncoding: TFileSaveFormat;
begin
  with FForm.SynEdit.LineS do
  begin
    if Encoding = nil then
      Exit(sf_Ansi);

    if Encoding = TEncoding.UTF8 then
    begin
      if WriteBOM then
        Result := sf_UTF8
      else
        Result := sf_UTF8_NoBOM;
    end
    else if Encoding = TEncoding.Unicode then
      Result := sf_UTF16LE
    else if Encoding = TEncoding.BigEndianUnicode then
      Result := sf_UTF16BE
    else
      Result := sf_Ansi;
  end;
end;

procedure TEditor.SetFileEncoding(FileEncoding: TFileSaveFormat);
begin
  with TSynEditStringList(FForm.SynEdit.LineS) do
  begin
    case FileEncoding of
      sf_Ansi:
        SetEncoding(Encoding.ANSI);
      sf_UTF8, sf_UTF8_NoBOM:
        SetEncoding(TEncoding.UTF8);
      sf_UTF16LE:
        SetEncoding(TEncoding.Unicode);
      sf_UTF16BE:
        SetEncoding(TEncoding.BigEndianUnicode);
    end;
    if FileEncoding = sf_UTF8_NoBOM then
      WriteBOM := False
    else
      WriteBOM := True;
  end;
end;

procedure TEditor.SetHasSearchHighlight(Value: Boolean);
begin
  FForm.FHasSearchHighlight := Value;
end;

procedure TEditor.SetHighlighter(const HighlighterName: string);
begin
  FForm.DoUpdateHighlighter(HighlighterName);
end;

procedure TEditor.SetReadOnly(Value: Boolean);
begin
  GetSynEdit.ReadOnly := Value;
  GetSynEdit2.ReadOnly := Value;
end;

procedure TEditor.SplitEditorHorizontally;
begin
  with FForm do
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
  with FForm do
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
  with FForm do
  begin
    EditorSplitter.Visible := False;
    SynEdit2.Visible := False;
    if SynEdit2.IsChained then
      SynEdit2.RemoveLinesPointer;
  end;
end;

procedure TEditor.OpenLocalFile(const AFilename: string;
  const HighlighterName: string = '');
var AFileTime: TDateTime;
begin
  if not Assigned(FForm) then
    Abort;

  DoSetFilename(AFilename);
  if (AFilename <> '') and FileExists(AFilename) then
  begin
    FForm.SynEdit.LockUndo;
    try
      if LoadFileIntoWideStrings(AFilename, FForm.SynEdit.LineS) then
      begin
        AFileTime := FForm.FileTime;
        if not FileAge(AFilename, AFileTime) then
          FForm.FileTime := 0
        else
          FForm.FileTime := AFileTime;
      end
      else
        Abort;
    finally
      FForm.SynEdit.UnlockUndo;
    end;
  end
  else
  begin
    if AFilename = '' then
    begin
      // Default settings for new files
      if PyIDEOptions.NewFileLineBreaks <> sffUnicode then
        (FForm.SynEdit.LineS as TSynEditStringList).FileFormat :=
          PyIDEOptions.NewFileLineBreaks;
    end;
  end;
  FForm.DoUpdateHighlighter(HighlighterName);
  if PyIDEOptions.CodeFoldingForGuiElements then
    FForm.CollapseGUICreation;
  if HasPythonFile then
    FSynLsp.FileOpened(GetFileId, lidPython)
  else
    FSynLsp.FileOpened(GetFileId, lidNone);
end;

procedure TEditor.OpenRemoteFile(const FileName, Servername: string);
begin
  if (FForm = nil) or (FileName = '') or (Servername = '') then
    Abort;

  // CopyRemoteFileToTemp aborts on failure
  var
  TempFileName := CopyRemoteFileToTemp(FileName, Servername);

  FForm.SynEdit.LockUndo;
  try
    if not LoadFileIntoWideStrings(TempFileName, FForm.SynEdit.LineS) then
      Abort;
  finally
    DeleteFile(TempFileName);
    FForm.SynEdit.UnlockUndo;
  end;

  RemoteFileName := FileName;
  SSHServer := Servername;
  DoSetFilename('');

  FForm.SynEdit.Modified := False;
  FForm.SynEdit.UseCodeFolding := PyIDEOptions.CodeFoldingEnabled;
  FForm.SynEdit2.UseCodeFolding := FForm.SynEdit.UseCodeFolding;

  FForm.DoUpdateHighlighter('');
  FForm.DoUpdateCaption;
  if HasPythonFile then
    FSynLsp.FileOpened(GetFileId, lidPython)
  else
    FSynLsp.FileOpened(GetFileId, lidNone);
end;

function TEditor.SaveToRemoteFile(const FileName, Servername: string): Boolean;
var TempFileName: string; ErrorMsg: string;
begin
  if not Assigned(FForm) or (FileName = '') or (Servername = '') then
    Abort;

  TempFileName := FileGetTempName('GuiPy');
  Result := SaveWideStringsToFile(TempFileName, FForm.SynEdit.LineS, False);
  if Result then
  begin
    Result := GI_SSHServices.ScpUpload(Servername, TempFileName, FileName,
      ErrorMsg);
    DeleteFile(TempFileName);
    if not Result then
      StyledMessageDlg(Format(_(SFileSaveError), [FileName, ErrorMsg]), mtError,
        [mbOK], 0);
  end;
end;

procedure TEditor.RefreshSymbols;
begin
  if FSynLsp.NeedToRefreshSymbols then
    FSynLsp.RefreshSymbols;
end;

procedure TEditor.Retranslate;
begin
  FForm.Retranslate;
end;

function TEditor.HasPythonFile: Boolean;
begin
  var
  Edit := GetSynEdit;
  if Assigned(Edit) then
    Result := GetSynEdit.Highlighter is TSynPythonSyn
  else
    Result := False;
end;

function TEditor.GetForm: TForm;
begin
  Result := FForm;
end;

function TEditor.GetHasSearchHighlight: Boolean;
begin
  Result := FForm.FHasSearchHighlight;
end;

procedure TEditor.ExecReload(Quiet: Boolean = False);
var BufferC: TBufferCoord;
begin
  if Quiet or not GetModified or
    (StyledMessageDlg(_(SFileReloadingWarning), mtWarning, [mbYes, mbNo], 0)
    = mrYes) then
  begin
    BufferC := GetSynEdit.CaretXY;
    OpenLocalFile(GetFileName);
    if (BufferC.Line <= GetSynEdit.LineS.Count) then
      GetSynEdit.CaretXY := BufferC;
  end;
end;

procedure TEditor.ExecuteSelection;
var ExecType: string; Source: string; Editor: TSynEdit;
begin
  if not HasPythonFile or not GI_PyControl.PythonLoaded or GI_PyControl.Running
  then
  begin
    // Ite is dangerous to execute code while running scripts
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
    // if a single Line or part of a Line is selected then eval the selection
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
  Source := CleanEOLs(Source);

  ThreadPythonExec(
    procedure
    begin
      // RunSource
      case GI_PyControl.DebuggerState of
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
  if not Assigned(FForm) then
    Exit;

  with ResourcesDataModule do
  begin
    PrintDialog.MinPage := 1;
    PrintDialog.MaxPage := CommandsDataModule.SynEditPrint.PageCount;
    PrintDialog.FromPage := 1;
    PrintDialog.ToPage := PrintDialog.MaxPage;
    PrintDialog.PrintRange := prAllPages;
  end;

  with CommandsDataModule do
  begin
    SynEditPrint.SynEdit := FForm.SynEdit;
    if ResourcesDataModule.PrintDialog.Execute then
    begin
      SynEditPrint.Title := GetFileTitle;
      if ResourcesDataModule.PrintDialog.PrintRange = prAllPages then
        SynEditPrint.Print
      else
        SynEditPrint.PrintRange(ResourcesDataModule.PrintDialog.FromPage,
          ResourcesDataModule.PrintDialog.ToPage);
    end;
  end;
end;

procedure TEditor.ExecPrintPreview;
begin
  CommandsDataModule.SynEditPrint.SynEdit := FForm.SynEdit;
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
  Result := Assigned(FForm) and not IsEmpty;
end;

function TEditor.CanFindNext: Boolean;
begin
  Result := Assigned(FForm) and not IsEmpty and
    (EditorSearchOptions.SearchText <> '');
end;

function TEditor.CanReplace: Boolean;
begin
  Result := Assigned(FForm) and not GetReadOnly and not IsEmpty;
end;

procedure TEditor.ExecFind;
begin
  if Assigned(FForm) then
    CommandsDataModule.ShowSearchReplaceDialog(GetActiveSynEdit, False);
end;

procedure TEditor.ExecFindNext;
begin
  if Assigned(FForm) then
    CommandsDataModule.DoSearchReplaceText(GetActiveSynEdit, False, False);
end;

procedure TEditor.ExecFindPrev;
begin
  if Assigned(FForm) then
    CommandsDataModule.DoSearchReplaceText(GetActiveSynEdit, False, True);
end;

procedure TEditor.ExecReplace;
begin
  if Assigned(FForm) then
    CommandsDataModule.ShowSearchReplaceDialog(GetActiveSynEdit, True);
end;

function TEditor.IsEmpty: Boolean;
begin
  Result := (FForm.SynEdit.LineS.Count = 0) or
    ((FForm.SynEdit.LineS.Count = 1) and (FForm.SynEdit.LineS[0] = ''));
end;

{$ENDREGION 'TEditor'}
{$REGION 'TEditorFactory'}

type
  TEditorFactory = class(TFileFactory, IEditorFactory)
  private
    FEditorViewFactories: TInterfaceList;
    // IEditorFactory implementation
    function OpenFile(AFilename: string; const HighlighterName: string = '';
      TabControlIndex: Integer = 0; AsEditor: Boolean = False): IFile;
    function GetEditorCount: Integer;
    function GetEditorByName(const Name: string): IEditor;
    function GetEditorByFileId(const Name: string): IEditor;
    function GetEditor(Index: Integer): IEditor;
    function GetViewFactoryCount: Integer;
    function GetViewFactory(Index: Integer): IEditorViewFactory;
    function NewEditor(TabControlIndex: Integer = 1): IEditor;
    procedure InvalidatePos(const AFilename: string; ALine: Integer;
      AType: TInvalidationType);
    procedure RemoveEditor(AEditor: IEditor);
    function RegisterViewFactory(ViewFactory: IEditorViewFactory): Integer;
    procedure SetupEditorViewsMenu(ViewsMenu: TSpTBXItem;
    ImageList: TCustomImageList);
    procedure UpdateEditorViewsMenu(ViewsMenu: TSpTBXItem);
    procedure CreateRecoveryFiles;
    procedure RecoverFiles;
    procedure LockList;
    procedure UnlockList;
    procedure ApplyToEditors(const Proc: TProc<IEditor>);
    function FirstEditorCond(const Predicate: TPredicate<IEditor>): IEditor;

    constructor Create;
    destructor Destroy; override;
    procedure OnEditorViewClick(Sender: TObject);
  end;

constructor TEditorFactory.Create;
begin
  inherited Create;
  FEditorViewFactories := TInterfaceList.Create;
end;

procedure TEditorFactory.CreateRecoveryFiles;
var RecoveryDir: string;
begin
  RecoveryDir := TPyScripterSettings.RecoveryDir;
  if TDirectory.Exists(RecoveryDir) then
    TDirectory.Delete(RecoveryDir, True);
  TDirectory.CreateDirectory(RecoveryDir);

  ApplyToEditors(
    procedure(Editor: IEditor)
    begin
      if not Editor.Modified then
        Exit;

      if (Editor.FileName <> '') or (Editor.RemoteFileName <> '') then
        (Editor as IFileCommands).ExecSave
      else
        with TEditorForm(Editor.Form) do
        begin
          // save module1 as 1.py etc.
          var
          FName := (Editor as TEditor).FUntitledNumber.ToString;
          FName := TPath.Combine(RecoveryDir, ChangeFileExt(FName,
            DefaultExtension));
          SaveWideStringsToFile(FName, SynEdit.LineS, False);
        end;
    end);
end;

destructor TEditorFactory.Destroy;
begin
  FreeAndNil(FEditorViewFactories);
  inherited Destroy;
end;

procedure TEditorFactory.ApplyToEditors(const Proc: TProc<IEditor>);
begin
  Files.Lock;
  try
    for var I := 0 to Files.Count - 1 do
      if IFile(Files[I]).FileKind = fkEditor then
        Proc(IEditor(Files[I]));
  finally
    Files.Unlock;
  end;
end;

function TEditorFactory.FirstEditorCond(const Predicate
  : TPredicate<IEditor>): IEditor;
var Editor: IEditor;
begin
  Files.Lock;
  try
    Result := nil;
    for var I := 0 to Files.Count - 1 do
      if IFile(Files[I]).FileKind = fkEditor then
      begin
        Editor := IEditor(Files[I]);
        if Predicate(Editor) then
          Exit(Editor);
      end;
  finally
    Files.Unlock;
  end;
end;

function TEditorFactory.NewEditor(TabControlIndex: Integer = 1): IEditor;
var Sheet: TSpTBXTabSheet; LForm: TEditorForm; TabItem: TSpTBXTabItem;
begin
  var
  TabControl := PyIDEMainForm.TabControl(TabControlIndex);

  TabItem := TabControl.Add('');
  TabItem.Images := PyIDEMainForm.vilTabDecorators;
  Sheet := TabControl.GetPage(TabItem);
  try
    LForm := TEditorForm.Create(Sheet);
    with LForm do
    begin
      Visible := False;
      FEditor := TEditor.Create(LForm);
      MyFile := FEditor;
      ParentTabItem := TabItem;
      ParentTabItem.OnTabClosing := PyIDEMainForm.TabControlTabClosing;
      ParentTabItem.OnDrawTabCloseButton := PyIDEMainForm.DrawCloseButton;
      ParentTabControl := TabControl;
      Result := FEditor;
      BorderStyle := bsNone;
      Parent := Sheet;
      Align := alClient;
      Visible := True;
      ScaleForPPI(Sheet.CurrentPPI);
      ApplyEditorOptions;
      ApplyPyIDEOptions(PyIDEOptions, nil);
    end;
    if Assigned(Result) then
      Files.Add(Result);
  except
    Sheet.Free;
  end;
end;

function TEditorFactory.GetEditorCount: Integer;
begin
  Result := 0;
  for var I := 0 to GetFileCount - 1 do
    if GetFile(I).FileKind = fkEditor then
      Inc(Result);
end;

function TEditorFactory.GetViewFactory(Index: Integer): IEditorViewFactory;
begin
  FEditorViewFactories.Lock;
  try
    Result := FEditorViewFactories[Index] as IEditorViewFactory;
  finally
    FEditorViewFactories.Unlock;
  end;
end;

function TEditorFactory.GetViewFactoryCount: Integer;
begin
  Result := FEditorViewFactories.Count;
end;

procedure TEditorFactory.InvalidatePos(const AFilename: string; ALine: Integer;
AType: TInvalidationType);

  procedure ProcessEditor(SynEd: TSynEdit);
  begin
    if ALine > 0 then
      case AType of
        itLine:
          SynEd.InvalidateLine(ALine);
        itGutter:
          SynEd.InvalidateGutterLine(ALine);
        itBoth:
          begin
            SynEd.InvalidateLine(ALine);
            SynEd.InvalidateGutterLine(ALine);
          end;
      end
    else
      case AType of
        itLine:
          SynEd.InvalidateLines(-1, -1);
        itGutter:
          SynEd.InvalidateGutterLines(-1, -1);
        itBoth:
          SynEd.Invalidate;
      end;
  end;

begin
  if AFilename = '' then
    Exit;

  var
  Editor := GetEditorByFileId(AFilename);
  if Assigned(Editor) then
  begin
    ProcessEditor(Editor.SynEdit);
    ProcessEditor(Editor.SynEdit2);
  end;
end;

procedure TEditorFactory.LockList;
begin
  Files.Lock;
end;

procedure TEditorFactory.UnlockList;
begin
  Files.Unlock;
end;

function TEditorFactory.GetEditorByName(const Name: string): IEditor;
var FullName: string;
begin
  // The Name may contain invalid characters and ExpandFileName will raise an
  // exception.  This is the case with exceptions raised by pywin32 COM objects
  try
    FullName := GetLongFileName(ExpandFileName(Name));
  except
    Exit(nil);
  end;
  Result := FirstEditorCond(
    function(Editor: IEditor): Boolean
    begin
      Result := AnsiSameText(Editor.GetFileName, FullName);
    end);
end;

function TEditorFactory.GetEditorByFileId(const Name: string): IEditor;
begin
  Result := GetEditorByName(Name);
  if not Assigned(Result) then
    Result := FirstEditorCond(
      function(Editor: IEditor): Boolean
      begin
        Result := (Editor.FileName = '') and
          AnsiSameText(Editor.GetFileTitle, Name);
      end);
end;

function TEditorFactory.GetEditor(Index: Integer): IEditor;
var Num: Integer;
begin
  Result := nil;
  Num := -1;
  for var I := 0 to GetFileCount - 1 do
    if GetFile(I).FileKind = fkEditor then
    begin
      Inc(Num);
      if Num = Index then
      begin
        Result := IEditor(GetFile(I));
        Exit;
      end;
    end;
end;

procedure TEditorFactory.RemoveEditor(AEditor: IEditor);
begin
  RemoveFile(AEditor);
end;

procedure TEditorFactory.RecoverFiles;
var UntitledNumber: Integer;
begin
  var
  RecoveryDir := TPyScripterSettings.RecoveryDir;
  if not TDirectory.Exists(RecoveryDir) then
    Exit;

  for var RecoveredFile in TDirectory.GetFiles(RecoveryDir) do
  begin
    var
    FName := TPath.GetFileNameWithoutExtension(RecoveredFile);
    if not TryStrToInt(FName, UntitledNumber) then
      Continue;

    var
    AEd := NewEditor;
    AEd.OpenLocalFile(RecoveredFile);

    var
    Editor := AEd as TEditor;
    Editor.FUntitledNumber := UntitledNumber;
    Editor.UntitledNumbers[UntitledNumber] := True;
    Editor.DoSetFilename('');
    Editor.FForm.DoUpdateCaption;
    if Editor.HasPythonFile then
      Editor.FSynLsp.FileSavedAs(Editor.GetFileId, lidPython);
  end;
  TDirectory.Delete(RecoveryDir, True);
end;

function TEditorFactory.RegisterViewFactory(ViewFactory
  : IEditorViewFactory): Integer;
begin
  Result := FEditorViewFactories.Add(ViewFactory);
end;

procedure TEditorFactory.OnEditorViewClick(Sender: TObject);
var ViewFactory: IEditorViewFactory; EditorView: IEditorView; Editor: IEditor;
  Index: Integer;
begin
  Editor := GI_PyIDEServices.ActiveEditor;
  if not Assigned(Editor) then
    Exit;
  Index := 2; // Tag = 0 for valid menu items
  if (Index >= 0) and (Index < FEditorViewFactories.Count) then
  begin
    ViewFactory := FEditorViewFactories[Index] as IEditorViewFactory;
    EditorView := Editor.ActivateView(ViewFactory);
    if Assigned(EditorView) then
      EditorView.UpdateView(Editor);
  end;
end;

function TEditorFactory.OpenFile(AFilename: string;
const HighlighterName: string = ''; TabControlIndex: Integer = 0;
AsEditor: Boolean = False): IFile;
var IsRemote: Boolean; Server, FName, GuiFormPath: string;
  TabCtrl: TSpTBXCustomTabControl; Editor: IEditor; FileKind: TFileKind;
begin
  Result := nil;
  PyIDEMainForm.tbiRecentFileList.MRURemove(AFilename);
  IsRemote := TSSHFileName.Parse(AFilename, Server, FName);
  GuiFormPath := '';
  if TPath.GetExtension(AFilename) = '.pfm' then
  begin
    GuiFormPath := AFilename;
    AFilename := TPath.ChangeExtension(AFilename, '.pyw');
    Editor := GI_EditorFactory.GetEditorByName(AFilename);
    if (Assigned(Editor) and Assigned((Editor.Form as TEditorForm).Partner) or
      not FileExists(GuiFormPath)) then
      GuiFormPath := '';
  end;

  // activate the editor if already open
  if IsRemote then
  begin
    Result := GI_FileFactory.GetFileByFileId(AFilename);
    if Assigned(Result) and not AsEditor then
    begin
      Result.Activate;
      Exit;
    end;
  end
  else if AFilename <> '' then
  begin
    if not IsHttp(AFilename) then
      AFilename := GetLongFileName(ExpandFileName(AFilename));
    Result := GI_FileFactory.GetFileByName(AFilename);
    if Assigned(Result) then
    begin
      Result.Activate;
      if GuiFormPath <> '' then
        FGUIDesigner.Open(GuiFormPath);
      if not AsEditor then // not AsEditor for Sequenceform as Text
        Exit;
    end;
  end;
  // create a new file, add it to the file list, open the file
  TabCtrl := PyIDEMainForm.TabControl(TabControlIndex);
  TabCtrl.Toolbar.BeginUpdate;
  try
    if AsEditor then
      FileKind := fkEditor
    else
      FileKind := FilenameToFileKind(AFilename);
    Result := CreateFile(FileKind, TabControlIndex);
    if Assigned(Result) then
    begin
      if Result.FileKind = fkEditor then
        Editor := Result as IEditor
      else
        Editor := nil;
      try
        if IsRemote then
          Result.OpenRemoteFile(FName, Server)
        else if Assigned(Editor) then
          Editor.OpenLocalFile(AFilename, HighlighterName)
        else
          Result.OpenFile(AFilename);
        Result.Activate; // necessary!

        PyIDEMainForm.tbiRecentFileList.MRURemove(AFilename);
        if GuiFormPath <> '' then
          FGUIDesigner.Open(GuiFormPath);
      except
        Result.Close;
        raise;
      end;

      if (AFilename <> '') and (GI_FileFactory.Count = 2) and
        (GI_FileFactory.GetFile(0).FileName = '') and
        (GI_FileFactory.GetFile(0).RemoteFileName = '') and
        not GI_FileFactory.GetFile(0).Modified then
        GI_FileFactory.GetFile(0).Close;
      if (AFilename = '') and (HighlighterName = 'Python') then
        TEditorForm(Result.Form).DefaultExtension := 'py';
    end;
  finally
    TabCtrl.Toolbar.EndUpdate;
    if Assigned(TabCtrl.ActiveTab) then
    begin
      TabCtrl.MakeVisible(TabCtrl.ActiveTab);
    end;
  end;
end;

procedure TEditorFactory.SetupEditorViewsMenu(ViewsMenu: TSpTBXItem;
ImageList: TCustomImageList);
var MenuItem: TSpTBXItem; ViewFactory: IEditorViewFactory;
begin
  ViewsMenu.Clear;
  FEditorViewFactories.Lock;
  try
    ViewsMenu.Enabled := FEditorViewFactories.Count > 0;
    for var I := 0 to FEditorViewFactories.Count - 1 do
    begin
      ViewFactory := FEditorViewFactories[I] as IEditorViewFactory;

      // Add MenuItem
      MenuItem := TSpTBXItem.Create(nil); // will be freed by the Parent Item
      MenuItem.Hint := ViewFactory.Hint;
      MenuItem.ImageIndex := ImageList.GetIndexByName(ViewFactory.ImageName);
      MenuItem.Caption := ViewFactory.MenuCaption;
      MenuItem.ShortCut := ViewFactory.ShortCut;
      MenuItem.OnClick := OnEditorViewClick;
      MenuItem.Tag := I;

      ViewsMenu.Add(MenuItem);
    end;
  finally
    FEditorViewFactories.Unlock;
  end;
end;

procedure TEditorFactory.UpdateEditorViewsMenu(ViewsMenu: TSpTBXItem);
var Editor: IEditor; ViewFactory: IEditorViewFactory; List: TList;
  Enabled: Boolean;
begin
  FEditorViewFactories.Lock;
  List := TList.Create;
  try
    for var I := 0 to FEditorViewFactories.Count - 1 do
    begin
      Editor := GI_PyIDEServices.ActiveEditor;
      Enabled := Assigned(Editor);
      if Enabled then
      begin
        ViewFactory := FEditorViewFactories[I] as IEditorViewFactory;
        ViewFactory.GetContextHighlighters(List);
        if List.Count > 0 then
        begin
          Enabled := False;
          for var J := 0 to List.Count - 1 do
          begin
            if List[J] = Editor.SynEdit.Highlighter then
            begin
              Enabled := True;
              Break;
            end;
          end;
        end;
        List.Clear;
      end;
      ViewsMenu[I].Enabled := Enabled;
    end;
  finally
    List.Free;
    FEditorViewFactories.Unlock;
  end;
end;

{$ENDREGION 'TEditorFactory'}
{$REGION 'TEditorForm'}

procedure TEditorForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FSourceScanner) then
    FSourceScanner.StopScanning;
  FSourceScanner := nil;
  if Assigned(Partner) then
    Partner.Close;
  if Assigned(FEditor) then
    FEditor.FForm := nil;

  FFoundSearchItems.Free;
  FreeAndNil(TVFileStructure);
  FreeAndNil(FModel);

  if SynEdit2.IsChained then
    SynEdit2.RemoveLinesPointer;

  if FBreakPoints.Count > 0 then
    GI_BreakpointManager.BreakpointsChanged := True;
  FBreakPoints.Free;

  // Remove notifications
  TMessageManager.DefaultManager.Unsubscribe(TIDEOptionsChangedMessage,
    ApplyPyIDEOptions);
  SkinManager.RemoveSkinNotification(Self);

  GI_EditorFactory.RemoveFile(IEditor(FEditor));
  inherited;
end;

procedure TEditorForm.SynEditChange(Sender: TObject);
begin
  if GI_PyControl.ErrorPos.FileName = GetEditor.FileId then
    GI_PyControl.ErrorPos := TEditorPos.EmptyPos;

  ClearSearchHighlight(FEditor);
  FNeedToParseModule := True; // at every change of the source code
end;

procedure TEditorForm.SynEditDblClick(Sender: TObject);
var PtMouse: TPoint; ASynEdit: TSynEdit;
begin
  ASynEdit := Sender as TSynEdit;
  GetCursorPos(PtMouse);
  PtMouse := ASynEdit.ScreenToClient(PtMouse);
  if (PtMouse.X >= ASynEdit.GutterWidth + 2) and ASynEdit.SelAvail and
    PyIDEOptions.HighlightSelectedWord then
    CommandsDataModule.HighlightWordInActiveEditor(ASynEdit.SelText);
end;

procedure TEditorForm.SynEditEnter(Sender: TObject);
var ASynEdit: TSynEdit;
begin
  EditorSearchOptions.InitSearch;
  ASynEdit := Sender as TSynEdit;
  FActiveSynEdit := ASynEdit;
  FOldCaretY := ASynEdit.CaretY;
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
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
    CommandsDataModule.SynWebCompletion.OnAfterCodeCompletion :=
      SynWebCompletionAfterCodeCompletion;
  end
  else
  begin
    // SynCodeCompletion
    CommandsDataModule.SynCodeCompletion.Editor := ASynEdit;
    CommandsDataModule.SynCodeCompletion.OnExecute := SynCodeCompletionExecute;
    CommandsDataModule.SynCodeCompletion.OnAfterCodeCompletion :=
      SynCodeCompletionAfterCodeCompletion;
    CommandsDataModule.SynCodeCompletion.OnClose := SynCodeCompletionClose;
    CommandsDataModule.SynCodeCompletion.OnCodeItemInfo :=
      SynCodeCompletionCodeItemInfo;
    CommandsDataModule.SynCodeCompletion.Images := vilCodeImages;
    // SynParamCompletion
    CommandsDataModule.SynParamCompletion.Editor := ASynEdit;
    CommandsDataModule.SynParamCompletion.OnExecute :=
      SynParamCompletionExecute;
    // SynWebCompletion
    CommandsDataModule.SynWebCompletion.Editor := nil;
    CommandsDataModule.SynWebCompletion.OnExecute := nil;
    CommandsDataModule.SynWebCompletion.OnAfterCodeCompletion := nil;
  end;

  if { (FOldEditorForm <> Self) and } not GI_PyIDEServices.IsClosing then
    CodeExplorerWindow.UpdateWindow(FEditor.FSynLsp.DocSymbols, ceuEditorEnter);
  FOldEditorForm := Self;
  // Search and Replace Target
  EditorSearchOptions.InterpreterIsSearchTarget := False;
  EditorSearchOptions.TextDiffIsSearchTarget := False;
  PyIDEMainForm.UpdateCaption;
  SynEdit.Options := SynEdit.Options + [eoDropFiles, eoNoHTMLBackground];
end;

procedure TEditorForm.SynEditExit(Sender: TObject);
begin
  DoAssignInterfacePointer(False);

  if FHotIdentInfo.HaveHotIdent then
  begin
    FHotIdentInfo.HaveHotIdent := False;
    (Sender as TCustomSynEdit).Indicators.Clear(HotIdentIndicatorSpec, True,
      FHotIdentInfo.StartCoord.Line);
    SetCursor(TCustomSynEdit(Sender).Cursor);
  end;

  PyIDEMainForm.mnEditCopy.Action := CommandsDataModule.actEditCopy;
  mnEditCopy.Action := CommandsDataModule.actEditCopy;

  PyIDEMainForm.mnEditPaste.Action := CommandsDataModule.actEditPaste;
  mnEditPaste.Action := CommandsDataModule.actEditPaste;
end;

procedure TEditorForm.SynEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
var
  ASynEdit: TSynEdit;
  NewCaretY: Integer;
begin
  ASynEdit := Sender as TSynEdit;
  Assert(FEditor <> nil, 'TEditorForm.SynEditStatusChange');
  if scModified in Changes then
  begin
    PyIDEMainForm.UpdateCaption;
    ParentTabItem.Invalidate;
  end;
  if scCaretY in Changes then
  begin
    FNeedToSyncCodeExplorer := True;
    // We refresh symbols only when the user finishes editing a line
    // and moves the cursor to another one.  This is so that
    // there is no slow down while typing.
    FEditor.RefreshSymbols;
  end;
  if (scCaretY in Changes) and ASynEdit.Gutter.Visible
    and ASynEdit.Gutter.ShowLineNumbers
    and PyIDEOptions.CompactLineNumbers then
  begin
    NewCaretY := ASynEdit.CaretY;
    ASynEdit.InvalidateGutterLine(FOldCaretY);
    ASynEdit.InvalidateGutterLine(NewCaretY);
    FOldCaretY := NewCaretY;
  end;
  if scTopLine in Changes then
    Application.CancelHint;
  if ASynEdit.Selection.IsEmpty then
   ClearSearchHighlight(FEditor);
end;

procedure TEditorForm.DoActivate;
begin
  ParentTabItem.Checked := True;
end;

procedure TEditorForm.DoActivateEditor(Primary: Boolean = True);
var ASynEdit: TSynEdit;
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
var Form: TCustomForm; Tab: TSpTBXTabItem; TabSheet: TSpTBXTabSheet;
begin
  Result := nil;
  DoActivate;
  // Does the EditorView tab exist?
  Result := nil;
  for var I := 0 to ViewsTabControl.PagesCount - 1 do
    if ViewsTabControl.Pages[I].Caption = ViewFactory.TabCaption then
    begin
      ViewsTabControl.ActiveTabIndex := I;
      Result := ViewsTabControl.Pages[I].Components[0] as IEditorView;
      Break;
    end;
  if not Assigned(Result) then
  begin
    // Editor View does not exist - Create
    Tab := ViewsTabControl.Add(ViewFactory.TabCaption);
    TabSheet := ViewsTabControl.GetPage(Tab);
    try
      Form := ViewFactory.CreateForm(FEditor, TabSheet);
      with Form do
      begin
        BorderStyle := bsNone;
        Parent := TabSheet;
        Align := alClient;
        Visible := True;
        Result := Form as IEditorView;
      end;
      Tab.Checked := True;
    except
      Tab.Free;
      raise;
    end;
  end;

  ViewsTabControl.TabVisible := True;
end;

function TEditorForm.DoAskSaveChanges: Boolean;
begin
  FModified := SynEdit.Modified;
  Result := inherited;
end;

procedure TEditorForm.DoAssignInterfacePointer(Active: Boolean);
begin
  if Active then
  begin
    GI_ActiveEditor := FEditor;
    GI_FileCmds := FEditor;
    GI_SearchCmds := FEditor;
  end
  else
  begin
    if GI_ActiveEditor = IEditor(FEditor) then
      GI_ActiveEditor := nil;
    if GI_FileCmds = IFileCommands(FEditor) then
      GI_FileCmds := nil;
    if GI_SearchCmds = ISearchCommands(FEditor) then
      GI_SearchCmds := nil;
  end;
end;

procedure TEditorForm.Enter(Sender: TObject);
begin
  DoUpdateCaption;
  FOldEditorForm := Self;
  SetOptions;
  PyIDEMainForm.ShowTkOrQt(FrameType);
  if Assigned(Partner) then
    FGUIDesigner.ChangeTo(TFGuiForm(Partner));
  if Assigned(TVFileStructure) and Assigned(TVFileStructure.Items) and
    Assigned(FFileStructure) and (FFileStructure.MyForm <> Self) then
    FFileStructure.Init(TVFileStructure.Items, Self);
end;

procedure TEditorForm.CollapseGUICreation;
var Line: Integer;
begin
  if PyIDEOptions.CodeFoldingForGuiElements and (DefaultExtension = 'pyw') then
  begin
    for var I := 0 to Min(SynEdit.AllFoldRanges.Count - 1, 2) do
    begin
      Line := SynEdit.AllFoldRanges[I].FromLine;
      if Pos('def __init__(self):', SynEdit.LineS[Line - 1]) > 0 then
        SynEdit.Collapse(I);
      if Pos('def create_widgets(self):', SynEdit.LineS[Line - 1]) > 0 then
        SynEdit.Collapse(I);
    end;
  end;
end;

function TEditorForm.IsGUICreationCollapsed: Boolean;
var Line: Integer;
begin
  Result := False;
  if DefaultExtension = 'pyw' then
  begin
    for var I := 0 to Min(SynEdit.AllFoldRanges.Count - 1, 2) do
    begin
      Line := SynEdit.AllFoldRanges[I].FromLine;
      if Pos('def create_widgets(self):', SynEdit.LineS[Line - 1]) > 0 then
        Result := SynEdit.AllFoldRanges.Ranges.List[I].Collapsed;
    end;
  end;
end;

function TEditorForm.DoSave: Boolean;
begin
  if (FEditor.FileName <> '') or (FEditor.RemoteFileName <> '') then
  begin
    Result := DoSaveFile;
    if Result then
      FEditor.FSynLsp.FileSaved;
  end
  else
    Result := DoSaveAs;
end;

function TEditorForm.DoSaveFile: Boolean;
var Line, TrimmedLine: string; AFileTime: TDateTime;
begin
  // Trim All lines just in case (Issue 196)
  if (SynEdit.LineS.Count > 0) and ((eoTrimTrailingSpaces in SynEdit.Options) or
    PyIDEOptions.TrimTrailingSpacesOnSave) then
  begin
    SynEdit.BeginUpdate;
    try
      for var I := 0 to SynEdit.LineS.Count - 1 do
      begin
        Line := SynEdit.LineS[I];
        TrimmedLine := TrimRight(Line);
        if Line <> TrimmedLine then
          SynEdit.LineS[I] := TrimmedLine;
      end;

      if (SynEdit.LineS.Count > 1) and (Pos('# Name:', SynEdit.LineS[1]) = 1)
      then
        SynEdit.LineS[1] := '# Name:         ' +
          ExtractFileName(FEditor.FileName);
    finally
      SynEdit.EndUpdate;
    end;
  end;
  Result := False;
  if FEditor.FileName <> '' then
  begin
    Result := SaveWideStringsToFile(FEditor.FileName, SynEdit.LineS,
      PyIDEOptions.CreateBackupFiles);
    if Result then
    begin
      AFileTime := FileTime;
      if not FileAge(FEditor.FileName, AFileTime) then
        FileTime := 0
      else
        FileTime := AFileTime;
    end;
  end
  else if FEditor.RemoteFileName <> '' then
    Result := FEditor.SaveToRemoteFile(FEditor.RemoteFileName,
      FEditor.SSHServer);
  if Result then
  begin
    if not PyIDEOptions.UndoAfterSave then
      SynEdit.ClearUndo;
    SynEdit.MarkSaved;
    SynEdit.Modified := False;
  end;
  if Assigned(Partner) then
    TFGuiForm(Partner).Save(False);
end;

function TEditorForm.DoSaveAs: Boolean;
var NewName: string; Edit: IEditor;
begin
  NewName := FEditor.GetFileId;
  if (FEditor.GetFileName = '') and (DefaultExtension <> '') and
    (ExtractFileExt(NewName) = '') then
    NewName := NewName + '.' + DefaultExtension;
  if ResourcesDataModule.GetSaveFileName(NewName, SynEdit.Highlighter,
    DefaultExtension) then
  begin
    Edit := GI_EditorFactory.GetEditorByName(NewName);
    if Assigned(Edit) and (Edit <> Self.FEditor as IEditor) then
    begin
      StyledMessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    FEditor.DoSetFilename(NewName);
    DoUpdateHighlighter;
    DoUpdateCaption; // Do Ite twice in case the following statement fails
    Result := DoSaveFile;
    if Result and Assigned(Partner) then
    begin
      TFGuiForm(Partner).Pathname := ChangeFileExt(Pathname, '.pfm');
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
var FileName, Server: string; Edit: IEditor;
begin
  if FEditor.FileName <> '' then
    FileName := TPath.GetFileName(FEditor.FileName)
  else if FEditor.RemoteFileName <> '' then
    FileName := FEditor.RemoteFileName;
  if ExecuteRemoteFileDialog(FileName, Server, rfdSave) then
  begin
    Edit := GI_EditorFactory.GetEditorByName(TSSHFileName.Format(Server,
      FileName));
    if Assigned(Edit) and (Edit <> Self.FEditor as IEditor) then
    begin
      StyledMessageDlg(_(SFileAlreadyOpen), mtError, [mbAbort], 0);
      Result := False;
      Exit;
    end;
    FEditor.RemoteFileName := FileName;
    FEditor.SSHServer := Server;
    FEditor.DoSetFilename('');
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

function TEditorForm.OpenFile(const FileName: string): Boolean;
begin
  Result := True;
  try
    FEditor.OpenFile(FileName);
  except
    Result := False;
  end;
end;

procedure TEditorForm.SetModified(Value: Boolean);
begin
  if FModified <> Value then
  begin
    inherited;
    ActiveSynEdit.Modified := Value;
  end;
end;

function TEditorForm.GetModified: Boolean;
begin
  if ActiveSynEdit <> nil then
    Result := ActiveSynEdit.Modified
  else
    Result := False;
end;

procedure TEditorForm.DoUpdateHighlighter(const HighlighterName: string = '');
begin
  if HighlighterName <> '' then
    SynEdit.Highlighter := ResourcesDataModule.Highlighters.
      HighlighterFromFriendlyName(HighlighterName)
  else if FEditor.FileName <> '' then
    SynEdit.Highlighter := ResourcesDataModule.Highlighters.
      HighlighterFromFileName(FEditor.FileName)
  else if FEditor.RemoteFileName <> '' then
    SynEdit.Highlighter := ResourcesDataModule.Highlighters.
      HighlighterFromFileName(FEditor.RemoteFileName)
  else // No highlighter otherwise
    SynEdit.Highlighter := nil;

  SynEdit2.Highlighter := SynEdit.Highlighter;

  // Set DefaultExtension
  if SynEdit.Highlighter <> nil then
    // DefaultExtension := DefaultExtensionFromFilter(SynEdit.Highlighter.DefaultFilter)
    DefaultExtension := Copy(LowerCase(TPath.GetExtension(Pathname)), 2, 20)
  else
    DefaultExtension := '';
  SynEdit.UseCodeFolding := PyIDEOptions.CodeFoldingEnabled;
  SynEdit2.UseCodeFolding := SynEdit.UseCodeFolding;
end;

function TEditorForm.GetFileFormat: string;
begin
  var
  ASynEdit := ActiveSynEdit;
  var
  Encoding := UpperCase(ASynEdit.LineS.Encoding.EncodingName);
  if Pos('ANSI', Encoding) > 0 then
    Encoding := 'ANSI'
  else if Pos('ASCII', Encoding) > 0 then
    Encoding := 'ASCII'
  else if Pos('UTF-8', Encoding) > 0 then
    Encoding := 'UTF-8'
  else if Pos('UTF-16', Encoding) > 0 then
    Encoding := 'UTF-16'
  else if Pos('UNICODE', Encoding) > 0 then
    Encoding := 'UTF-16'
  else if Pos('CP1252', Encoding) > 0 then
    Encoding := 'ANSI';
  var
  LineBreak := ASynEdit.LineS.LineBreak;
  if LineBreak = #13#10 then
    LineBreak := 'Windows'
  else if LineBreak = #10 then
    LineBreak := 'Unix'
  else
    LineBreak := 'Mac';
  Result := Encoding + '/' + LineBreak;
end;

procedure TEditorForm.EditorCommandHandler(Sender: TObject;
AfterProcessing: Boolean; var Handled: Boolean; var Command: TSynEditorCommand;
var AChar: WideChar; Data, HandlerData: Pointer);
var SynEd: TSynEdit; PrevLine: string; Caret: TBufferCoord;
begin
  if Handled then
    Exit;

  SynEd := Sender as TSynEdit;
  if (Command <> ecLostFocus) and (Command <> ecGotFocus) then
    EditorSearchOptions.InitSearch;

  if not AfterProcessing then
  begin
    if (Command <> ecCancelSelections) and (SynEd.Selections.Count > 1) then
      Exit;

    case Command of
      ecCodeCompletion:
        if SynEd.Highlighter is TSynPythonSyn then
        begin
          if CommandsDataModule.SynCodeCompletion.Form.Visible then
            CommandsDataModule.SynCodeCompletion.CancelCompletion;
          DoCodeCompletion(SynEd, SynEd.CaretXY);
          Handled := True;
        end
        else if SynEd.Highlighter is TSynWebBase then
          CommandsDataModule.SynWebCompletion.ActivateCompletion;
      ecParamCompletion:
        if SynEd.Highlighter is TSynPythonSyn then
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
        if SynEd.InsertMode and (eoAutoIndent in SynEd.Options) and
          (SynEd.Highlighter is TSynPythonSyn) and (SynEd.Selections.Count = 1)
          and not FAutoCompleteActive then
        begin
          { CaretY should never be less than 2 right After ecLineBreak, so there's
            no need for a check }
          PrevLine := TrimRight(SynEd.LineS[SynEd.CaretY - 2]);

          // BC := BufferCoord(Length(PrevLine), SynEd.CaretY - 1);
          // Indent on: if a: # success?
          // if SynEd.GetHighlighterAttriAtRowCol(BC, DummyToken, Attr) and not
          // ( // (attr = SynEd.Highlighter.StringAttribute) or
          // (Attr = SynEd.Highlighter.CommentAttribute) or
          // (Attr = TSynPythonSyn(SynEd.Highlighter).CodeCommentAttri) { or
          // (attr = ResourcesDataModule.SynPythonSyn.DocStringAttri) } ) then
          // begin
          if TPyRegExpr.IsBlockOpener(PrevLine) then
            SynEd.ExecuteCommand(ecTab, #0, nil)
          else if TPyRegExpr.IsBlockCloser(PrevLine) then
            SynEd.ExecuteCommand(ecShiftTab, #0, nil);
          // end;
        end;
      ecChar:
        // Trigger auto-complection on completion trigger chars
        begin
          if PyIDEOptions.EditorCodeCompletion and (SynEd.Selections.Count = 1) then
          begin
            if (TIDECompletion.CompletionInfo.Editor = nil)
              and (Pos(AChar, CommandsDataModule.SynCodeCompletion.TriggerChars) > 0)
              and not ResourcesDataModule.CodeTemplatesCompletion.Executing
            then
            begin
              Caret := SynEd.CaretXY;
              TThread.ForceQueue(nil, procedure
                begin
                  DoCodeCompletion(SynEd, Caret);
                end, IfThen(AChar = '.', 200,
                CommandsDataModule.SynCodeCompletion.TimerInterval));
            end;
          end;
        end;
      ecSelWord:
        if SynEd.SelAvail and PyIDEOptions.HighlightSelectedWord then
          CommandsDataModule.HighlightWordInActiveEditor(SynEd.SelText);
      ecLostFocus:
        if not(CommandsDataModule.SynCodeCompletion.Form.Visible or
          SynEdit.Focused or SynEdit2.Focused) then
          CommandsDataModule.SynParamCompletion.CancelCompletion;
    end;
  end;
end;

procedure TEditorForm.ScrollbarAnnotationGetInfo(Sender: TObject;
AnnType: TSynScrollbarAnnType; var Rows: TArray<Integer>;
var Colors: TArray<TColor>);
begin
  var
  Editor := Sender as TCustomSynEdit;

  Rows := [];
  Colors := [];
  if AnnType = sbaCustom1 then
  begin
    if HasSyntaxError then
    begin
      var
      List := FEditor.FSynLsp.Diagnostics;
      if List.Count > 0 then
      begin
        Rows := [Editor.BufferToDisplayPos(List[0].BlockBegin).Row];
      end;
      Colors := [$3C14DC];
    end;
  end
  else if AnnType = sbaCustom2 then
  begin
    for var Pair in SynEdit.Indicators.GetById(SearchHighlightIndicatorId) do
      Rows := Rows + [Editor.LineToRow(Pair.Key)];
    Colors := [PyIDEOptions.HighlightSelectedWordColor];
  end;
end;

class procedure TEditorForm.SymbolsChanged(Sender: TObject);
begin
  CodeExplorerWindow.UpdateWindow(Sender as TDocSymbols, ceuSymbolsChanged);
end;

procedure TEditorForm.SyncCodeExplorer;
begin
  if FNeedToSyncCodeExplorer and GetEditor.HasPythonFile then
  begin
    CodeExplorerWindow.ShowEditorCodeElement;
    FNeedToSyncCodeExplorer := False;
  end;
end;

procedure TEditorForm.SyncFileStructure;
begin
  if FNeedToSyncFileStructure and IsPython then
  begin
    FFileStructure.ShowEditorCodeElement(ActiveSynEdit.CaretY);
    FNeedToSyncFileStructure := False;
  end;
end;

function TEditorForm.ReparseIfNeeded: Boolean;
begin
  if FNeedToParseModule and GetEditor.HasPythonFile then
  begin
    FNeedToParseModule := False;
    if Assigned(FSourceScanner) then
      FSourceScanner.StopScanning;
    FSourceScanner := AsynchSourceScannerFactory.CreateAsynchSourceScanner
      (FEditor.GetFileId, SynEdit.Text); // ToDo asynchron?
    while not FSourceScanner.Finished do
      Sleep(50);
    CreateModel;
    CreateTVFileStructure;
    Result := True; // due to recursive call of ReparseIfNeeded
  end
  else
  begin
    FSourceScanner := nil;
    Result := False;
  end;
end;

procedure TEditorForm.Retranslate;
begin
  RetranslateComponent(Self);
  TBIfStatement.Hint := 'if-' + _('Statement');
  TBIfElseStatement.Hint := 'if-else-' + _('Statement');
  TBWhileStatement.Hint := 'while-' + _('Statement');
  TBForStatement.Hint := 'for-' + _('Statement');
  TBIfElifStatement.Hint := 'if-elif-' + _('Statement');
  TBTryStatement.Hint := 'try-' + _('Statement');
end;

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  for var I := TVFileStructure.Items.Count - 1 downto 0 do
  begin
    var
    AInteger := TInteger(TVFileStructure.Items[I].Data);
    AInteger.Free;
  end;
  if Assigned(FFileStructure) then
    FFileStructure.Clear(Self);
  PyIDEMainForm.ShowTkOrQt(0);
end;

procedure TEditorForm.FormCreate(Sender: TObject);
begin
  StyledBorderColors(FBorderNormal, FBorderHighlight);

  FGPanelExit(Self);

  SynEdit.OnReplaceText := CommandsDataModule.SynEditReplaceText;

  FHotIdentInfo.HaveHotIdent := False;

  ViewsTabControl.TabVisible := False;
  case PyIDEOptions.EditorsTabPosition of
    ttpTop:
      ViewsTabControl.TabPosition := ttpBottom;
    ttpBottom:
      ViewsTabControl.TabPosition := ttpTop;
  end;

  SynEdit2.SetLinesPointer(SynEdit);
  SynEdit.OnDropFiles := PyIDEMainForm.DropFiles;
  SynEdit2.OnDropFiles := PyIDEMainForm.DropFiles;

  // Custom command handling
  SynEdit.RegisterCommandHandler(EditorCommandHandler, nil);
  SynEdit2.RegisterCommandHandler(EditorCommandHandler, nil);

  FBreakPoints := TBreakpointList.Create(True);
  TDebugSupportPlugin.Create(Self); // No need to free

  // Indicators
  var
  IndicatorSpec := TSynIndicatorSpec.New(sisTextDecoration, clNoneF, clNoneF,
    [fsUnderline]);
  SynEdit.Indicators.RegisterSpec(HotIdentIndicatorSpec, IndicatorSpec);
  SynEdit2.Indicators.RegisterSpec(HotIdentIndicatorSpec, IndicatorSpec);

  PyIDEMainForm.ThemeEditorGutter(SynEdit.Gutter);

  // Setup notifications
  TMessageManager.DefaultManager.SubscribeToMessage(TIDEOptionsChangedMessage,
    ApplyPyIDEOptions);
  SkinManager.AddSkinNotification(Self);

  TranslateComponent(Self);

  // GuiPy
  SetOptions;
  PyIDEMainForm.ThemeEditorGutter(SynEdit.Gutter);
  Retranslate;
  FIndent1 := FConfiguration.Indent1;
  FIndent2 := FConfiguration.Indent2;
  FIndent3 := FConfiguration.Indent3;
  FModel := TObjectModel.Create;
  ChangeStyle;
end;

procedure TEditorForm.SynEditGutterGetText(Sender: TObject; Line: Integer;
var Text: string);
begin
  if Line = TSynEdit(Sender).CaretY then
    Exit;

  if Line mod 10 <> 0 then
    if Line mod 5 <> 0 then
      Text := '·'
    else
      Text := '–';
end;

procedure TEditorForm.SynEditSpecialLineColors(Sender: TObject; Line: Integer;
var Special: Boolean; var Foreground, Background: TColor);
begin
  if GI_PyControl.PythonLoaded then
  begin
    if GI_PyControl.CurrentPos.PointsTo(FEditor.GetFileId, Line) then
    begin
      Special := True; { TODO: Allow customization of these colors }
      Foreground := clWhite;
      Background := $FF901E; // Dodger Blue
    end
    else if GI_PyControl.ErrorPos.PointsTo(FEditor.GetFileId, Line) then
    begin
      Special := True;
      Foreground := clWhite;
      Background := $4763FF; // Tomato Red
    end;
  end;
end;

function TEditorForm.GetEditor: IEditor;
begin
  Result := FEditor;
end;

procedure TEditorForm.GoToSyntaxError;
begin
  if HasSyntaxError then
  begin
    var
    List := FEditor.FSynLsp.Diagnostics;
    if List.Count > 0 then
    begin
      var
      BlockBegin := List[0].BlockBegin;
      SynEdit.CaretXY := BufferCoord(BlockBegin.Char, BlockBegin.Line);
    end;
  end;
end;

function TEditorForm.HasSyntaxError: Boolean;
begin
  Result := FEditor.HasPythonFile and (FEditor.FSynLsp.Diagnostics.Count > 0);
end;

procedure TEditorForm.CreateStructogram;
var Str, AText, FileName: string; BufB, BufE: TBufferCoord;
  AIndent, Line: Integer; Scanner: TPythonScannerWithTokens;
begin
  AText := '';
  if ActiveSynEdit.SelAvail then
  begin
    BufB := BufB.Min(ActiveSynEdit.BlockBegin, ActiveSynEdit.BlockEnd);
    BufE := BufE.Max(ActiveSynEdit.BlockEnd, ActiveSynEdit.BlockEnd);
    Line := BufB.Line;
    while Line <= BufE.Line do
    begin
      AText := AText + ActiveSynEdit.LineS[Line - 1] + Chr(10);
      Inc(Line);
    end;
  end
  else
  begin
    Mouse.CursorPos := pmnuEditor.PopupPoint;
    ActiveSynEdit.GetPositionOfMouse(BufB);
    Line := BufB.Line - 1;
    AIndent := CalcIndent(ActiveSynEdit.LineS[Line]);
    while Line < ActiveSynEdit.LineS.Count do
    begin
      Str := ActiveSynEdit.LineS[Line];
      if (CalcIndent(Str) >= AIndent) or (Trim(Str) = '') then
      begin
        AText := AText + Str + Chr(10);
        Inc(Line);
      end
      else
        Break;
    end;
  end;
  if Trim(AText) <> '' then
  begin
    Scanner := TPythonScannerWithTokens.Create;
    Scanner.Init(AText);
    FileName := Scanner.GetFileName;
    FreeAndNil(Scanner);
    if FileName <> '' then
      FileName := ExtractFilePath(Pathname) + FileName + '.psg'
    else
      FileName := ChangeFileExt(Pathname, '.psg');
    PyIDEMainForm.StructogramFromText(AText, FileName);
  end;
end;

procedure TEditorForm.SetOptions;
begin
  FConfiguration.SetToolbarVisibility(EditformToolbar, 2);
  SetToolButtons;
  if GuiPyOptions.LockedStructogram then
    mnEditCreateStructogram.Visible := False;
end;

function TEditorForm.IsPython: Boolean;
begin
  Result := (SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn);
end;

function TEditorForm.IsPythonAndGUI: Boolean;
begin
  Result := IsPython and (DefaultExtension = 'pyw');
end;

function TEditorForm.IsHTML: Boolean;
begin
  Result := (DefaultExtension = 'html') or (DefaultExtension = 'htm');
end;

function TEditorForm.IsCSS: Boolean;
begin
  Result := (DefaultExtension = 'css');
end;

procedure TEditorForm.GotoLine(Line: Integer);
begin
  if Line = 0 then
    Exit;
  ActiveSynEdit.TopLine := Line;
  ActiveSynEdit.CaretX := 1;
  ActiveSynEdit.CaretY := Line;
  ActiveSynEdit.EnsureCursorPosVisible;
end;

procedure TEditorForm.GotoWord(const Word: string);
var Line: Integer;
begin
  with ActiveSynEdit do
  begin
    Line := GetLineNumberWithWord(Word);
    if (0 <= Line) and (Line <= LineS.Count - 1) then
    begin
      CaretX := Pos(Word, LineS[Line]);
      CaretY := Line + 1;
    end;
  end;
end;

procedure TEditorForm.PutText(Source: string; WithCursor: Boolean = True);
var Posi, OffX, OffY, XPos, YPos: Integer; Str1: string;
  TmpOptions, OrigOptions: TSynEditorOptions;
  ChangedIndent, ChangedTrailing: Boolean;
begin
  TmpOptions := ActiveSynEdit.Options;
  OrigOptions := ActiveSynEdit.Options;
  ChangedIndent := eoAutoIndent in TmpOptions;
  ChangedTrailing := eoTrimTrailingSpaces in TmpOptions;

  if ChangedIndent then
    Exclude(TmpOptions, eoAutoIndent);
  if ChangedTrailing then
    Exclude(TmpOptions, eoTrimTrailingSpaces);

  if ChangedIndent or ChangedTrailing then
    ActiveSynEdit.Options := TmpOptions;

  Posi := Pos('|', Source);
  if Posi = 0 then
    WithCursor := False;

  if WithCursor then
  begin
    OffY := 0;
    Str1 := Copy(Source, 1, Posi - 1);
    Delete(Source, Posi, 1);
    Posi := Pos(#13#10, Str1);
    while Posi > 0 do
    begin
      Inc(OffY);
      Delete(Str1, 1, Posi + 1);
      Posi := Pos(#13#10, Str1);
    end;
    OffX := Length(Str1) + 1;
    with ActiveSynEdit do
    begin
      if SelText = '' then
      begin
        XPos := CaretX;
        YPos := CaretY;
      end
      else
      begin
        XPos := BlockBegin.Char;
        YPos := BlockBegin.Line;
      end;
      SelText := Source;
      CaretY := YPos + OffY;
      if OffY = 0 then
        CaretX := XPos + OffX - 1
      else
        CaretX := OffX;
    end;
  end
  else
    ActiveSynEdit.SelText := Source;
  ActiveSynEdit.EnsureCursorPosVisible;
  if ChangedIndent or ChangedTrailing then
    ActiveSynEdit.Options := OrigOptions;
end;

function TEditorForm.GetGeometry: TPoint;
var Posi, Line: Integer; Str, StrX, StrY: string;
begin
  Result.X := 300;
  Result.Y := 300;
  if FrameType = 2 then
  begin
    Line := GetLineNumberWith('self.root.geometry');
    if Line >= 0 then
    begin
      Str := ActiveSynEdit.LineS[Line];
      Posi := Pos('(', Str);
      Delete(Str, 1, Posi + 1);
      Posi := Pos('x', Str);
      StrX := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
      Posi := Pos(')', Str);
      StrY := Copy(Str, 1, Posi - 2);
    end;
  end
  else
  begin
    Line := GetLineNumberWith('self.resize');
    if Line >= 0 then
    begin
      Str := ActiveSynEdit.LineS[Line];
      Posi := Pos('(', Str);
      Delete(Str, 1, Posi);
      Posi := Pos(',', Str);
      StrX := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
      Posi := Pos(')', Str);
      StrY := Copy(Str, 1, Posi - 1);
    end;
  end;

  if StrX <> '' then
    TryStrToInt(StrX, Result.X);
  if StrY <> '' then
    TryStrToInt(StrY, Result.Y);
end;

function TEditorForm.GetIndent: string;
var Int: Integer;
begin
  if ActiveSynEdit.SelText = '' then
    Int := ActiveSynEdit.CaretX - 1
  else
    Int := ActiveSynEdit.BlockBegin.Char;
  Result := StringOfChar(' ', Int);
end;

procedure TEditorForm.SynEditKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  // Cancel Code Hint when the Ctrl Key is depressed
  Application.CancelHint;
end;

procedure TEditorForm.SynEditKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  if FHotIdentInfo.HaveHotIdent then
  begin
    FHotIdentInfo.HaveHotIdent := False;
    (Sender as TCustomSynEdit).Indicators.Clear(HotIdentIndicatorSpec, True,
      FHotIdentInfo.StartCoord.Line);
    SetCursor(TCustomSynEdit(Sender).Cursor);
  end;
end;

procedure TEditorForm.SynEditMouseCursor(Sender: TObject;
const LineCharPos: TBufferCoord; var Cursor: TCursor);
var TokenType, Start: Integer; Token: string; Attri: TSynHighlighterAttributes;
  OldHotIdent: Boolean; OldStartCoord: TBufferCoord; ASynEdit: TSynEdit;
begin
  ASynEdit := Sender as TSynEdit;
  OldHotIdent := FHotIdentInfo.HaveHotIdent;
  OldStartCoord := FHotIdentInfo.StartCoord;

  FHotIdentInfo.HaveHotIdent := False;
  if ASynEdit.Focused and (HiWord(GetAsyncKeyState(VK_CONTROL)) > 0) and
    FEditor.HasPythonFile and not ASynEdit.IsPointInSelection(LineCharPos) then
    with ASynEdit do
    begin
      GetHighlighterAttriAtRowColEx(LineCharPos, Token, TokenType,
        Start, Attri);
      if (Attri = TSynPythonSyn(Highlighter).IdentifierAttri) or
        (Attri = TSynPythonSyn(Highlighter).NonKeyAttri) or
        (Attri = TSynPythonSyn(Highlighter).SystemAttri) then
      begin
        // Cursor := crHandPoint;
        FHotIdentInfo.HaveHotIdent := True;
        FHotIdentInfo.StartCoord := BufferCoord(Start, LineCharPos.Line);
      end;
    end;
  if (OldHotIdent <> FHotIdentInfo.HaveHotIdent) or
    (OldStartCoord <> FHotIdentInfo.StartCoord) then
  begin
    if OldHotIdent then
      ASynEdit.Indicators.Clear(HotIdentIndicatorSpec, True,
        OldStartCoord.Line);
    if FHotIdentInfo.HaveHotIdent then
      ASynEdit.Indicators.Add(FHotIdentInfo.StartCoord.Line,
        TSynIndicator.New(HotIdentIndicatorSpec, FHotIdentInfo.StartCoord.Char,
        FHotIdentInfo.StartCoord.Char + Token.Length));
  end;
end;

procedure TEditorForm.SynEditMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
  EditorSearchOptions.InitSearch;
  if GI_PyControl.ErrorPos.FileName = GetEditor.FileId then
    GI_PyControl.ErrorPos := TEditorPos.EmptyPos;

  if FHotIdentInfo.HaveHotIdent then
  begin
    // fHodIdentInfo is reset in the KeyUp handler
    PostMessage(Application.MainForm.Handle, WM_FINDDEFINITION,
      FHotIdentInfo.StartCoord.Char, FHotIdentInfo.StartCoord.Line);
  end;
  if CommandsDataModule.SynParamCompletion.Form.Visible then
    CommandsDataModule.SynParamCompletion.CancelCompletion;
end;

procedure TEditorForm.FGPanelEnter(Sender: TObject);
begin
  FHasFocus := True;
  BGPanel.Color := FBorderHighlight;
end;

procedure TEditorForm.FGPanelExit(Sender: TObject);
begin
  FHasFocus := False;
  BGPanel.Color := FBorderNormal;
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
  Clipboard.AsText := Pathname;
end;

procedure TEditorForm.mnEditAddImportsClick(Sender: TObject);
begin
  var
  FileName := ExtractFileName(Pathname);
  var
  StringList := FConfiguration.GetClassesAndFilename(Pathname);
  for var I := 0 to StringList.Count - 1 do
  begin
    if StringList.ValueFromIndex[I] <> FileName then
    begin
      var
      RegEx := CompiledRegEx('\W' + StringList.KeyNames[I] + '\W');
      if RegEx.IsMatch(ActiveSynEdit.Text) then
        InsertImport('from ' + ChangeFileExt(StringList.ValueFromIndex[I], '') +
          ' import ' + StringList.KeyNames[I]);
    end;
  end;
  FreeAndNil(StringList);
end;

procedure TEditorForm.mnFontClick(Sender: TObject);
var FontDialog: TFontDialog;
begin
  FontDialog := TFontDialog.Create(Self);
  FontDialog.Font.Assign(ActiveSynEdit.Font);
  if FontDialog.Execute then
  begin
    ActiveSynEdit.Font.Assign(FontDialog.Font);
    FConfiguration.labFont.Font.Assign(ActiveSynEdit.Font);
  end;
  FontDialog.Free;
end;

procedure TEditorForm.mnGitExecute(Sender: TObject);
begin
  FGit.Execute(TSpTBXItem(Sender).Tag, GetEditor);
end;

procedure TEditorForm.AddWatchAtCursor;
var Token, LineTxt, DottedIdent: string; Attri: TSynHighlighterAttributes;
  LineCharPos: TBufferCoord;
begin
  LineCharPos := SynEdit.CaretXY;
  if SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn then
    with SynEdit do
    begin
      GetHighlighterAttriAtRowCol(LineCharPos, Token, Attri);
      if (Attri = ResourcesDataModule.SynPythonSyn.IdentifierAttri) or
        (Attri = ResourcesDataModule.SynPythonSyn.NonKeyAttri) or
        (Attri = ResourcesDataModule.SynPythonSyn.SystemAttri) or
        ((Token = ')') or (Token = ']')) then
      begin
        LineTxt := LineS[LineCharPos.Line - 1];
        DottedIdent := GetWordAtPos(LineTxt, LineCharPos.Char, True, True,
          False, True);
        DottedIdent := DottedIdent + GetWordAtPos(LineTxt, LineCharPos.Char + 1,
          False, False, True);
        if (DottedIdent <> '') and Assigned(GI_WatchManager) then
          GI_WatchManager.AddWatch(DottedIdent);
      end;
    end;
end;

procedure TEditorForm.mnUpdateViewClick(Sender: TObject);
var TabCaption: string; ViewFactory: IEditorViewFactory;
  EditorView: IEditorView;
begin
  if ViewsTabControl.ActivePage <> tbshSource then
  begin
    TabCaption := ViewsTabControl.ActivePage.Caption;
    ViewFactory := nil;
    for var I := 0 to GI_EditorFactory.ViewFactoryCount - 1 do
    begin
      if GI_EditorFactory.ViewFactory[I].TabCaption = TabCaption then
      begin
        ViewFactory := GI_EditorFactory.ViewFactory[I];
        Break;
      end;
    end;
    if Assigned(ViewFactory) then
    begin
      EditorView := FEditor.ActivateView(ViewFactory);
      if Assigned(EditorView) then
        EditorView.UpdateView(FEditor);
    end;
  end;
end;

procedure TEditorForm.ApplyEditorOptions;
begin
  SynEdit.Assign(GEditorOptions);
  SynEdit2.Assign(GEditorOptions);

  SynEdit.BracketsHighlight.SetFontColorsAndStyle
    (ResourcesDataModule.SynPythonSyn.MatchingBraceAttri.Foreground,
    ResourcesDataModule.SynPythonSyn.UnbalancedBraceAttri.Foreground, [fsBold]);
  SynEdit2.BracketsHighlight.SetFontColorsAndStyle
    (ResourcesDataModule.SynPythonSyn.MatchingBraceAttri.Foreground,
    ResourcesDataModule.SynPythonSyn.UnbalancedBraceAttri.Foreground, [fsBold]);
end;

procedure TEditorForm.ApplyPyIDEOptions(const Sender: TObject;
  const Msg: System.Messaging.TMessage);

  procedure ApplyOptionsToEditor(Editor: TCustomSynEdit);
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
      // Diagnostics
      with Editor.ScrollbarAnnotations.Add as TSynScrollbarAnnItem do
      begin
        AnnType := sbaCustom1;
        AnnPos := sbpFullWidth;
        FullRow := True;
        OnGetInfo := ScrollbarAnnotationGetInfo;
      end;
      // Search highlight
      with Editor.ScrollbarAnnotations.Add as TSynScrollbarAnnItem do
      begin
        AnnType := sbaCustom2;
        AnnPos := sbpSecondLeft;
        FullRow := False;
        OnGetInfo := ScrollbarAnnotationGetInfo;
      end;
    end
    else
      Editor.ScrollbarAnnotations.Clear;

    if PyIDEOptions.AutoCompleteBrackets then
      Editor.Options := Editor.Options + [eoCompleteBrackets, eoCompleteQuotes]
    else
      Editor.Options := Editor.Options - [eoCompleteBrackets, eoCompleteQuotes];
    if PyIDEOptions.AccessibilitySupport then
      Editor.Options := Editor.Options + [eoAccessibility]
    else
      Editor.Options := Editor.Options - [eoAccessibility];
  end;

begin
  RegisterSearchHighlightIndicatorSpec(FEditor);

  // Tab position
  if PyIDEOptions.EditorsTabPosition = ttpTop then
    ViewsTabControl.TabPosition := ttpBottom
  else // ttpBottom:
    ViewsTabControl.TabPosition := ttpTop;

  ApplyOptionsToEditor(SynEdit);
  ApplyOptionsToEditor(SynEdit2);
end;

procedure TEditorForm.AutoCompleteAfterExecute(Sender: TObject);
begin
  FAutoCompleteActive := False;
  CommandsDataModule.actReplaceParametersExecute(nil);
end;

procedure TEditorForm.AutoCompleteBeforeExecute(Sender: TObject);
begin
  FAutoCompleteActive := True;
end;

procedure TEditorForm.WMSpSkinChange(var Message: TMessage);
begin
  StyledBorderColors(FBorderNormal, FBorderHighlight);
  if FHasFocus then
    BGPanel.Color := FBorderHighlight
  else
    BGPanel.Color := FBorderNormal;

  PyIDEMainForm.ThemeEditorGutter(SynEdit.Gutter);
  SynEdit.CodeFolding.FolderBarLinesColor := SynEdit.Gutter.Font.Color;
  SynEdit.InvalidateGutter;

  PyIDEMainForm.ThemeEditorGutter(SynEdit2.Gutter);
  SynEdit2.CodeFolding.FolderBarLinesColor := SynEdit2.Gutter.Font.Color;
  SynEdit2.InvalidateGutter;
  ChangeStyle;
  Invalidate;
end;

procedure TEditorForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
  begin
    EditformToolbar.Images := vilEditorToolbarDark;
    pmnuEditor.Images := vilContextMenuDark;
    SynEdit.BookMarkOptions.BookmarkImages := vilBookmarksDark;
  end
  else
  begin
    EditformToolbar.Images := vilEditorToolbarLight;
    pmnuEditor.Images := vilContextMenuLight;
    SynEdit.BookMarkOptions.BookmarkImages := vilBookmarksLight;
  end;

  if FHasFocus then
    BGPanel.Color := FBorderHighlight
  else
    BGPanel.Color := FBorderNormal;

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
var Editor: TSynEdit;
begin
  Editor := FActiveSynEdit;

  if Value.EndsWith('()') then
  begin
    // if the next char is an opening bracket remove the added brackets
    if (EndToken = '(') or ((Editor.CaretX <= Editor.LineText.Length) and
      IsOpeningBracket(Editor.LineText[Editor.CaretX], Editor.Brackets)) then
    begin
      Editor.BeginUpdate;
      try
        Editor.ExecuteCommand(ecDeleteLastChar, #0, nil);
        Editor.ExecuteCommand(ecDeleteLastChar, #0, nil);
      finally
        Editor.EndUpdate;
      end;
    end
    else
    begin
      Editor.CaretX := Editor.CaretX - 1;
      EndToken := '(';
    end;
  end;
  if EndToken = '(' then
    TThread.ForceQueue(nil,
      procedure
      begin
        if Assigned(GI_ActiveEditor) and (GI_ActiveEditor.ActiveSynEdit = Editor)
        then
          CommandsDataModule.SynParamCompletion.ActivateCompletion;
      end);
end;

procedure TEditorForm.SynCodeCompletionClose(Sender: TObject);
begin
  PyIDEOptions.CodeCompletionListSize :=
    CommandsDataModule.SynCodeCompletion.NbLinesInWindow;
 TIDECompletion.CompletionInfo.CleanUp;
end;

procedure TEditorForm.SynCodeCompletionCodeItemInfo(Sender: TObject;
  AIndex: Integer; var Info: string);
begin
  if not TIDECompletion.CompletionLock.TryEnter then Exit;
  try
    if Assigned(TIDECompletion.CompletionInfo.CompletionHandler) then
    begin
      var CCItem := (Sender as TSynCompletionProposal).InsertList[AIndex];
      Info := TIDECompletion.CompletionInfo.CompletionHandler.GetInfo(CCItem);
    end;
  finally
    TIDECompletion.CompletionLock.Leave;
  end;
end;

class procedure TEditorForm.DoCodeCompletion(Editor: TSynEdit; Caret: TBufferCoord);
var
  Locline: string;
  Attr: TSynHighlighterAttributes;
  Highlighter: TSynCustomHighlighter;
  FileName, DummyToken: string;
  DisplayText, InsertText: string;
begin
  //Exit if cursor has moved
  if not Assigned(GI_ActiveEditor) or (GI_ActiveEditor.ActiveSynEdit <> Editor)
    or Editor.ReadOnly or (Caret <> Editor.CaretXY)
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
  Locline := Editor.LineText.PadRight(Caret.Char);
  Inc(Caret.Char);

  var CC := TIDECompletion.EditorCodeCompletion;
  if not TIDECompletion.CompletionLock.TryEnter then Exit;
  try
    TIDECompletion.CompletionInfo.CleanUp;

    var Skipped := False;
    for var I := 0 to CC.SkipHandlers.Count -1 do
    begin
      var SkipHandler := CC.SkipHandlers[I] as TBaseCodeCompletionSkipHandler;
      Skipped := SkipHandler.SkipCodeCompletion(Locline, FileName, Caret, Highlighter, Attr);
      if Skipped then Break;
    end;

    if not Skipped then
      // There is one CompletionHandler (LSP)!
      // Completion will be activated by the LSP completion handler later
      for var I := 0 to CC.CompletionHandlers.Count - 1 do
      begin
        var CompletionHandler := CC.CompletionHandlers[I] as TBaseCodeCompletionHandler;
        CompletionHandler.Initialize;
        // We ignore the result of HandleCodeCompletion
        CompletionHandler.HandleCodeCompletion(Locline, FileName,
          Caret, Highlighter, Attr, InsertText, DisplayText);
        TIDECompletion.CompletionInfo.CompletionHandler := CompletionHandler;
        TIDECompletion.CompletionInfo.Editor := Editor;
        TIDECompletion.CompletionInfo.CaretXY := Caret;
      end;
  finally
    TIDECompletion.CompletionLock.Leave;
  end;
end;
procedure TEditorForm.SetNeedsParsing(Value: Boolean);
begin
  if Value <> FNeedToParseModule then
  begin
    if Value and Assigned(ActiveSynEdit)
    { and not fGetActiceSynEdit.LockBuildStructure }
    then
      FNeedToParseModule := True
    else
      FNeedToParseModule := False;
  end;
end;

procedure TEditorForm.SetToolButtons;
var Python: Boolean;
begin
  Python := IsPython;
  TBBrowser.Visible := IsHTML and TBBrowser.Visible;
  TBDesignform.Visible := Python and TBDesignform.Visible;
  TBClassOpen.Visible := Python and TBClassOpen.Visible;
  TBCheck.Visible := Python and TBCheck.Visible;
  TBClassEdit.Visible := Python and TBClassEdit.Visible;
  TBStructureIndent.Visible := Python and TBStructureIndent.Visible;
  TBIfStatement.Visible := Python and TBIfStatement.Visible;
  TBIfElseStatement.Visible := Python and TBIfElseStatement.Visible;
  TBWhileStatement.Visible := Python and TBWhileStatement.Visible;
  TBForStatement.Visible := Python and TBForStatement.Visible;
  TBIfElifStatement.Visible := Python and TBIfElifStatement.Visible;
  TBTryStatement.Visible := Python and TBTryStatement.Visible;
  TBBreakpoint.Visible := Python and TBBreakpoint.Visible;
  TBBreakpointsClear.Visible := Python and TBBreakpointsClear.Visible;
  TBValidate.Visible := (IsHTML or IsCSS) and TBValidate.Visible;
  // needs TFBrowser-Support
end;

procedure TEditorForm.SynCodeCompletionExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: string; var X, Y: Integer;
  var CanExecute: Boolean);
begin
  var CI := TIDECompletion.CompletionInfo;
  var CP := TSynCompletionProposal(Sender);

  CanExecute := False;
  if TIDECompletion.CompletionLock.TryEnter then
  try
    CanExecute := Assigned(GI_ActiveEditor) and
      (GI_ActiveEditor.ActiveSynEdit = CI.Editor) and
      Application.Active and
      (GetParentForm(CI.Editor).ActiveControl = CI.Editor) and
      (TIDECompletion.CompletionInfo.CaretXY = TIDECompletion.CompletionInfo.Editor.CaretXY);

    if CanExecute then
    begin
      CP.Font := PyIDEOptions.AutoCompletionFont;
      CP.ItemList.Text := CI.DisplayText;
      CP.InsertList.Text := CI.InsertText;
      CP.NbLinesInWindow := PyIDEOptions.CodeCompletionListSize;
      CP.CurrentString := CurrentInput;

      if CP.Form.AssignedList.Count = 0 then
      begin
        CanExecute := False;
        TIDECompletion.CompletionInfo.CleanUp;
      end
      else
      if PyIDEOptions.CompleteWithOneEntry and (CP.Form.AssignedList.Count = 1) then
      begin
        // Auto-complete with one entry without showing the form
        CanExecute := False;
        CP.OnValidate(CP.Form, [], #0);
        TIDECompletion.CompletionInfo.CleanUp;
      end;
    end
    else
    begin
      CP.ItemList.Clear;
      CP.InsertList.Clear;
      TIDECompletion.CompletionInfo.CleanUp;
    end;
  finally
    TIDECompletion.CompletionLock.Leave;
  end;
end;

class procedure TEditorForm.SynParamCompletionExecute(Kind: SynCompletionType;
    Sender: TObject; var CurrentInput: string; var X, Y: Integer; var
    CanExecute: Boolean);
var
  P: TPoint;
  CP: TSynCompletionProposal;
  Editor: IEditor;
begin
   Editor := GI_ActiveEditor;
   CP := Sender as TSynCompletionProposal;

  TIDECompletion.SignatureHelpInfo.Lock;
  try
    CanExecute := Assigned(Editor) and Editor.HasPythonFile and TPyLspClient.MainLspClient.Ready
      and (Editor.ActiveSynEdit = CP.Editor) and PyIDEOptions.EditorCodeCompletion;

    // This function is called
    // a) from the editor using trigger char or editor command
    // b) From TSynCompletionProposal.HookEditorCommand
    // c) from TJedi ParamCompletionHandler only then RequestId <> 0

    if not TIDECompletion.SignatureHelpInfo.Handled then
    begin
      TPyLspClient.MainLspClient.SignatureHelp(Editor.FileId, CP.Editor);

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
    CanExecute := CanExecute and TIDECompletion.SignatureHelpInfo.Succeeded and
      (TIDECompletion.SignatureHelpInfo.FileId = Editor.FileId) and
      (TIDECompletion.SignatureHelpInfo.CurrentLine = CP.Editor.LineText) and
      (TIDECompletion.SignatureHelpInfo.Caret = CP.Editor.CaretXY);

    if CanExecute then
    begin
      var DisplayString := TIDECompletion.SignatureHelpInfo.DisplayString;
      CP.FormatParams := not (DisplayString = '');
      if not CP.FormatParams then
        DisplayString :=  '\style{~B}' + _(SNoParameters) + '\style{~B}';

      var DocString := TIDECompletion.SignatureHelpInfo.DocString;
      if (DocString <> '') then
      begin
        DisplayString := DisplayString + sLineBreak;
        DocString := GetLineRange(DocString, 1, 20); // 20 lines max
      end;

      CP.Font := PyIDEOptions.AutoCompletionFont;
      CP.Form.CurrentIndex := TIDECompletion.SignatureHelpInfo.ActiveParameter;
      CP.ItemList.Text := DisplayString + DocString;

      // position the hint window at and just below the opening bracket
      P := CP.Editor.ClientToScreen(CP.Editor.RowColumnToPixels(
          CP.Editor.BufferToDisplayPos(
          BufferCoord(TIDECompletion.SignatureHelpInfo.StartX, CP.Editor.CaretY))));
      Inc(P.Y, CP.Editor.LineHeight);
      X := P.X;
      Y := P.Y;
    end
    else
      CP.ItemList.Clear;

    // Mark request as not handled even if you cannot execute
    // It will be marked again as handled by the asynchronous request handler
    TIDECompletion.SignatureHelpInfo.Handled := False;

  finally
    TIDECompletion.SignatureHelpInfo.UnLock;
  end;
end;

procedure TEditorForm.SynWebCompletionAfterCodeCompletion(Sender: TObject;
const Value: string; Shift: TShiftState; Index: Integer; EndToken: WideChar);
var ASynEdit: TCustomSynEdit;

  function CaretBetween(const AStr: string): Boolean;
  begin
    var
    Int := Pos(AStr, Value);
    Result := Int > 0;
    if Result then
      ASynEdit.CaretX := ASynEdit.CaretX - (Length(Value) - Int);
  end;

begin
  ASynEdit := TSynCompletionProposal(Sender).Editor;
  if Pos('>>', ASynEdit.LineS[ASynEdit.CaretY - 1]) >= 1 then
    ASynEdit.ExecuteCommand(ecDeleteChar, ' ', nil);

  if not CaretBetween('()') then
    if not CaretBetween('><') then
      if not CaretBetween('""') then
        CaretBetween(' ;');
end;

procedure TEditorForm.SynWebCompletionExecute(Kind: SynCompletionType;
Sender: TObject; var CurrentInput: string; var X, Y: Integer;
var CanExecute: Boolean);
var ASynEdit: TCustomSynEdit;
begin
  ASynEdit := TSynCompletionProposal(Sender).Editor;
  SynWebFillCompletionProposal(ASynEdit, ResourcesDataModule.SynWebHtmlSyn,
    CommandsDataModule.SynWebCompletion, CurrentInput);
  TSynCompletionProposal(Sender).Font := PyIDEOptions.AutoCompletionFont;
end;

procedure TEditorForm.SetDeleteBookmark(XPos, YPos: Integer);
var Int, AtX, AtY: Integer;
begin
  with ActiveSynEdit do
  begin
    Int := 0;
    while (Int < 10) do
    begin
      if GetBookMark(Int, AtX, AtY) and (AtY = YPos) then
      begin
        ClearBookMark(Int);
        Exit;
      end;
      Inc(Int);
    end;
    Int := 0;
    while (Int < 10) and IsBookmark(Int) do
      Inc(Int);
    if Int < 10 then
      SetBookMark(Int, XPos, YPos)
    else
      Beep;
  end;
end;

procedure TEditorForm.TBCheckClick(Sender: TObject);
var ErrorPos: TEditorPos;
begin
  if TPyInternalInterpreter(PyControl.InternalInterpreter)
    .SyntaxCheck(FEditor, ErrorPos) then
  begin
    GI_PyIDEServices.Messages.AddMessage(Format(_(SSyntaxIsOK), [Pathname]));
    ShowDockForm(MessagesWindow);
  end;
end;

procedure TEditorForm.TBClassEditClick(Sender: TObject);
begin
  if IsPython then
  begin
    if Modified or MyFile.GetFromTemplate then
      DoSave;
    PyIDEMainForm.PrepareClassEdit(FEditor, 'Edit', nil);
  end;
end;

procedure TEditorForm.TBClassOpenClick(Sender: TObject);
begin
  if IsPython then
  begin
    try
      if Modified or MyFile.GetFromTemplate then
        DoSave;
      var
      Str := ChangeFileExt(Pathname, '.puml');
      if FileExists(Str) then
        GI_EditorFactory.OpenFile(Str, '', PyIDEMainForm.ActiveTabControlIndex)
      else
      begin
        var
        UMLForm := PyIDEMainForm.CreateUMLForm(Str);
        UMLForm.Visible := False;
        UMLForm.MainModul.AddToProject(Pathname);
        UMLForm.CreateTVFileStructure;
        UMLForm.MainModul.DoLayout;
        UMLForm.DoSave;
        PyIDEMainForm.RunFile(UMLForm.MyFile);
        UMLForm.Visible := True;
      end;
    except
      on E: Exception do
        ErrorMsg(E.Message);
    end;
  end;
end;

procedure TEditorForm.TBCloseClick(Sender: TObject);
begin
  (FEditor as IFileCommands).ExecClose;
end;

procedure TEditorForm.TBWordWrapClick(Sender: TObject);
begin
  if ActiveSynEdit.WordWrap then
  begin
    ActiveSynEdit.WordWrap := False;
    ActiveSynEdit.UseCodeFolding := True;
  end
  else
  begin
    ActiveSynEdit.UseCodeFolding := False;
    ActiveSynEdit.WordWrap := True;
  end;
  TBParagraph.Down := ActiveSynEdit.WordWrap;
end;

procedure TEditorForm.TBStatementClick(Sender: TObject);
begin
  TBControlStructures((Sender as TToolButton).Tag);
end;

procedure TEditorForm.TBStructureIndentClick(Sender: TObject);
begin
  var
  ExternalTool := TExternalTool.Create;
  with ExternalTool do
  begin
    ApplicationName := '$[PythonExe-Short]';
    Parameters := '$[PythonDir-Short]Tools\Scripts\reindent.py -n ';
    SaveFiles := sfActive;
    ProcessInput := piActiveFile;
    ProcessOutput := poActiveFile;
    Context := tcActiveFile;
    ParseMessages := False;
    CaptureOutput := False;
    ConsoleHidden := True;
  end;
  ExternalTool.Execute;
  FreeAndNil(ExternalTool);
end;

procedure TEditorForm.TBZoomMinusClick(Sender: TObject);
begin
  SynEdit.Zoom(-1);
  SynEdit2.Zoom(-1);
end;

procedure TEditorForm.TBZoomPlusClick(Sender: TObject);
begin
  SynEdit.Zoom(+1);
  SynEdit2.Zoom(+1);
end;

procedure TEditorForm.TBNumbersClick(Sender: TObject);
begin
  ActiveSynEdit.Gutter.ShowLineNumbers :=
    not ActiveSynEdit.Gutter.ShowLineNumbers;
  ActiveSynEdit.Gutter.AutoSize := not ActiveSynEdit.Gutter.AutoSize;
end;

procedure TEditorForm.TBParagraphClick(Sender: TObject);
begin
  var
  VisibleSpecialChars := SynEdit.VisibleSpecialChars;
  if VisibleSpecialChars = [] then
    SynEdit.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    SynEdit.VisibleSpecialChars := [];
  TBParagraph.Down := not(SynEdit.VisibleSpecialChars = []);
end;

procedure TEditorForm.TBGotoBookmarkClick(Sender: TObject);
var OldNumber: Integer;
begin
  OldNumber := FBookmark;
  repeat
    if ActiveSynEdit.IsBookmark(FBookmark) then
    begin
      ActiveSynEdit.GotoBookMark(FBookmark);
      FBookmark := (FBookmark + 1) mod 10;
      Exit;
    end;
    FBookmark := (FBookmark + 1) mod 10;
  until OldNumber = FBookmark;
end;

procedure TEditorForm.TBUnindentClick(Sender: TObject);
begin
  Unindent;
end;

procedure TEditorForm.TBValidateClick(Sender: TObject);
var Browser: TFBrowser;
begin
  Browser := PyIDEMainForm.NewBrowser('');
  if IsCSS then
    Browser.UploadFileHttpPost('https://jigsaw.w3.org/css-validator/validator',
      'file', Pathname)
  else
    Browser.UploadFileHttpPost('https://validator.w3.org/check',
      'uploaded_file', Pathname);
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
var Posi, From, Till: Integer; Str: string; Pos1, Pos2: TBufferCoord;
begin
  with ActiveSynEdit do
  begin
    BeginUpdate;
    if SelAvail then
    begin
      From := BlockBegin.Line;
      Till := BlockEnd.Line;
      Pos1 := BlockBegin;
      Pos2 := BlockEnd;
    end
    else
    begin
      From := CaretY;
      Pos1.Char := CaretX;
      Pos1.Line := CaretY;
      Till := CaretY;
      Pos2.Char := 0;
    end;
    for var I := From to Till do
    begin
      Str := LineS[I - 1];
      Posi := Pos('#', Str);
      if Posi = 1 then
        Delete(Str, Posi, 1)
      else
        Str := '#' + Str;
      LineS[I - 1] := Str;
    end;
    if Pos2.Char <> 0 then
    begin
      BlockBegin := Pos1;
      BlockEnd := Pos2;
    end;
    EndUpdate;
    InvalidateLines(From, Till);
  end;
  Modified := True;
end;

procedure TEditorForm.TBBookmarkClick(Sender: TObject);
begin
  SetDeleteBookmark(ActiveSynEdit.CaretX, ActiveSynEdit.CaretY);
end;

procedure TEditorForm.TBBreakpointClick(Sender: TObject);
begin
  var
  Editor := GI_PyIDEServices.GetActiveEditor;
  if Assigned(Editor) and Editor.HasPythonFile then
    GI_BreakpointManager.ToggleBreakpoint(Editor.GetFileId,
      Editor.SynEdit.CaretY);
end;

procedure TEditorForm.TBBreakpointsClearClick(Sender: TObject);
begin
  GI_BreakpointManager.ClearAllBreakpoints;
end;

procedure TEditorForm.TBBrowserClick(Sender: TObject);
begin
  if Modified or MyFile.GetFromTemplate then
    DoSave;
  FConfiguration.DoHelp(Pathname);
end;

procedure TEditorForm.SBDesignformClick(Sender: TObject);
var FileName: string;
begin
  if IsPython and (Partner = nil) then
  begin
    FileName := ChangeFileExt(Pathname, '.pfm');
    PyIDEMainForm.DoOpen(FileName);
  end;
end;

procedure TEditorForm.TBDesignformClick(Sender: TObject);
begin
  if IsPythonAndGUI then
    if not Assigned(Partner) then
      FGUIDesigner.Open(ChangeFileExt(Pathname, '.pfm'))
    else
      FGUIDesigner.DesignForm.Show;
end;

procedure TEditorForm.TBExplorerClick(Sender: TObject);
begin
  PyIDEMainForm.actNavFileExplorerExecute(nil);
end;

function TEditorForm.BeginOfStructure(Line: string): Boolean;
var Posi: Integer;
begin
  Posi := Pos('#', Line);
  if Posi > 0 then
    Delete(Line, Posi, Length(Line));
  Line := Trim(Line);
  Result := (Line <> '') and (Line[Length(Line)] = ':');
end;

procedure TEditorForm.Unindent;
var CarX: Integer;
begin
  with ActiveSynEdit do
  begin
    TabWidth := Length(FConfiguration.Indent1);
    if SelAvail then
      CommandProcessor(ecBlockUnindent, #0, nil)
    else
    begin
      CarX := CaretX;
      if FMouseIsInBorderOfStructure then
        SelStructure(FMouseBorderOfStructure)
      else
        SelEnd := SelStart + 1;
      CommandProcessor(ecBlockUnindent, #0, nil);
      SelEnd := SelStart;
      CaretX := CarX - TabWidth;
    end;
    TabWidth := GEditorOptions.TabWidth;
  end;
end;

procedure TEditorForm.Indent;
var CarX: Integer;
begin
  with ActiveSynEdit do
  begin
    TabWidth := Length(FConfiguration.Indent1);
    if SelAvail then
      CommandProcessor(ecBlockIndent, #0, nil)
    else
    begin
      CarX := CaretX;
      if FMouseIsInBorderOfStructure then
        SelStructure(FMouseBorderOfStructure)
      else
        SelEnd := SelStart + 1;
      CommandProcessor(ecBlockIndent, #0, nil);
      SelEnd := SelStart;
      CaretX := CarX + TabWidth;
    end;
    TabWidth := GEditorOptions.TabWidth;
  end;
end;

procedure TEditorForm.SelStructure(var LineNo: Integer);
var Int, AIndent: Integer; Line: string; Pos, Block: TBufferCoord;
begin
  LineNo := -1;
  ActiveSynEdit.GetPositionOfMouse(Pos);
  if Pos.Line < ActiveSynEdit.LineS.Count then
  begin
    Line := ActiveSynEdit.LineS[Pos.Line];
    if BeginOfStructure(Line) then
    begin
      LineNo := Pos.Line;
      Block.Char := 1;
      Block.Line := Pos.Line;
      ActiveSynEdit.BlockBegin := Block;
      AIndent := CalcIndent(Line);
      Int := Pos.Line + 1;
      while (Int < ActiveSynEdit.LineS.Count) and
        (CalcIndent(ActiveSynEdit.LineS[Int]) > AIndent) do
        Inc(Int);
      Block.Line := Int;
      ActiveSynEdit.BlockEnd := Block;
    end;
  end;
end;

procedure TEditorForm.TBControlStructures(KTag: Integer;
OnKey: Boolean = False);
var Str, Line, SelectedBlock, AIndent: string; Empty: Boolean;

  function PrepareBlock(Str: string): string;
  var Str1, Str2: string; Posi: Integer;
  begin
    Str1 := '';
    Posi := System.Pos(CrLf, Str);
    while Posi > 0 do
    begin
      Str2 := Copy(Str, 1, Posi + 1);
      if KTag = 5 then // switch needs double AIndent
        if Trim(Str2) = '' then
          Str1 := Str1 + AIndent + FIndent2 + CrLf
        else
          Str1 := Str1 + FIndent2 + Str2
      else if Trim(Str2) = '' then
        Str1 := Str1 + AIndent + FIndent1 + CrLf
      else
        Str1 := Str1 + FIndent1 + Str2;
      Delete(Str, 1, Posi + 1);
      Posi := Pos(CrLf, Str);
    end;
    Result := Str1;
  end;

begin
  if ActiveSynEdit.SelAvail then
  begin
    AIndent := StringOfChar(' ',
      CalcIndent(ActiveSynEdit.LineS[ActiveSynEdit.BlockBegin.Line]));
    SelectedBlock := GetLinesWithSelection + CrLf;
    SelectedBlock := PrepareBlock(SelectedBlock);
  end
  else
  begin
    Line := ActiveSynEdit.LineS[ActiveSynEdit.CaretY - 1];
    Empty := (Trim(Line) = '');
    Delete(Line, ActiveSynEdit.CaretX, MaxInt);
    if Empty then
    begin
      AIndent := StringOfChar(' ', ActiveSynEdit.CaretX - 1);
      ActiveSynEdit.CaretX := 1;
      ActiveSynEdit.LineS[ActiveSynEdit.CaretY - 1] := '';
    end
    else
      AIndent := GetIndent;
    SelectedBlock := '';
  end;
  Str := GetControlStructure(KTag, AIndent, SelectedBlock);
  if not ActiveSynEdit.SelAvail and (Trim(Line) <> '') then
    Delete(Str, 1, Length(AIndent));
  if (KTag = 1) and OnKey then
    // FJava.scpJava.ActivateTimer(EditForm.Editor) ToDo
  else
    PutText(Str);
end;

function TEditorForm.GetLinesWithSelection: string;
var BlockA, BlockE: TBufferCoord;
begin
  with ActiveSynEdit do
  begin
    BlockA := BlockBegin;
    BlockE := BlockEnd;
    if BlockBegin.Line <= BlockEnd.Line then
    begin
      BlockA.Char := 1;
      BlockE.Char := Length(LineS[BlockEnd.Line - 1]) + 1;
    end
    else
    begin
      BlockE.Char := 1;
      BlockA.Char := Length(LineS[BlockBegin.Line - 1]) + 1;
    end;
    BlockBegin := BlockA;
    BlockEnd := BlockE;
    Result := SelText;
  end;
end;

function TEditorForm.GetControlStructure(KTag: Integer; const Indent: string;
Block: string): string;
var Str, Str1: string; Index: Integer;
begin
  Result := '';
  Str := '';
  Index := 0;
  while Index < FConfiguration.ControlStructureTemplates[KTag].Count do
  begin
    Str1 := FConfiguration.ControlStructureTemplates[KTag][Index];
    if (Block <> '') and (Trim(Str1) = '') then
    begin
      Str := Str + Block;
      Block := '';
    end
    else if (Block <> '') and (Trim(Str1) = '|') then
    begin
      if KTag = 10 then
        Str := Str + '|' + Block
      else
      begin
        Str := Str + Indent + Str1 + CrLf;
        Str := Str + Block;
      end;
      Block := '';
    end
    else
      Str := Str + Indent + Str1 + CrLf;
    Inc(Index);
  end;
  Delete(Str, Length(Str) - 1, 2);
  Result := Str;
end;

procedure TEditorForm.ViewsTabControlActiveTabChange(Sender: TObject;
TabIndex: Integer);
begin
  tbiUpdateView.Enabled := ViewsTabControl.ActivePage <> tbshSource;
  tbiCloseTab.Enabled := ViewsTabControl.ActivePage <> tbshSource;
end;

procedure TEditorForm.ViewsTabControlContextPopup(Sender: TObject;
MousePos: TPoint; var Handled: Boolean);
var ItemViewer: TTBItemViewer; Point: TPoint;
begin
  ItemViewer := ViewsTabControl.View.ViewerFromPoint(MousePos);
  if Assigned(ItemViewer) and (ItemViewer.Item is TSpTBXTabItem) then
  begin
    ItemViewer.Item.Checked := True;
    Point := ClientToScreen(MousePos);
    mnCloseTab.Enabled :=
      not(ViewsTabControl.GetPage(TSpTBXTabItem(ItemViewer.Item)) = tbshSource);
    pmnuViewsTab.Popup(Point.X, Point.Y);
  end;
  Handled := True;
end;

class procedure TEditorForm.CodeHintLinkHandler(Sender: TObject;
LinkName: string);
begin
  var
  Editor := GI_PyIDEServices.ActiveEditor;
  if Assigned(Editor) then
  begin
    var
    SynEd := Editor.ActiveSynEdit;
    var
    Point := TEditorForm(Editor.Form).FHintCursorRect.TopLeft;
    var
    DisplayC := SynEd.PixelsToNearestRowColumn(Point.X, Point.Y);
    var
    BufferC := SynEd.DisplayToBufferPos(DisplayC);
    PyIDEMainForm.JumpToFilePosInfo(LinkName);
    PyIDEMainForm.AdjustBrowserLists(Editor.GetFileId, BufferC.Line,
      BufferC.Char, LinkName);
  end;
end;

procedure TEditorForm.DoOnIdle;
begin
  ReparseIfNeeded;
  SyncCodeExplorer;
  SyncFileStructure;
  // if PyIDEOptions.CheckSyntaxAsYouType and FEditor.HasPythonFile then
  // FEditor.FSynLsp.ApplyNewDiagnostics;

  if SynEdit.ReadOnly then
    ParentTabItem.ImageIndex := PyIDEMainForm.vilTabDecorators.
      GetIndexByName('Lock')
  else if HasSyntaxError then
    ParentTabItem.ImageIndex := PyIDEMainForm.vilTabDecorators.
      GetIndexByName('Bug')
  else
    ParentTabItem.ImageIndex := -1;
end;

procedure TEditorForm.SynEditDebugInfoPaintLines(RenderTarget
  : ID2D1RenderTarget; ClipR: TRect; const FirstRow, LastRow: Integer;
var DoDefaultPainting: Boolean);
var LineHeight, YPos: Integer; ImgIndex: Integer; Row, Line: Integer;
  Breakpoint: TBreakpoint; HasBP, HasDisabledBP: Boolean;
begin
  DoDefaultPainting := False;
  if not(SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn) then
    Exit;

  if (PyControl.ActiveDebugger <> nil) and SynEdit.Gutter.Visible then
  begin
    LineHeight := SynEdit.LineHeight;

    for Row := FirstRow to LastRow do
    begin
      Line := SynEdit.RowToLine(Row);
      if Row <> SynEdit.LineToRow(Line) then
        Continue; // Wrapped Line

      YPos := (LineHeight - vilGutterGlyphs.Height) div 2 + LineHeight *
        (Row - SynEdit.TopLine);

      HasBP := False;
      HasDisabledBP := False;
      if FBreakPoints.FindBreakpoint(Line, Breakpoint) then
      begin
        if Breakpoint.Disabled then
          HasDisabledBP := True
        else
          HasBP := True;
      end;

      if GI_PyControl.CurrentPos.PointsTo(FEditor.GetFileId, Line) then
      begin
        if HasBP then
          ImgIndex := 2
        else
          ImgIndex := 1;
      end
      else if TPyRegExpr.IsExecutableLine(SynEdit.LineS[Line - 1]) then
      begin
        if HasBP then
          ImgIndex := 3
        else if HasDisabledBP then
          ImgIndex := 5
        else if PyIDEOptions.MarkExecutableLines then
          ImgIndex := 0
        else
          ImgIndex := -1;
      end
      else
      begin
        if HasBP then
          ImgIndex := 4
        else if HasDisabledBP then
          ImgIndex := 5
        else
          ImgIndex := -1;
      end;
      if ImgIndex >= 0 then
        ImageListDraw(RenderTarget, vilGutterGlyphs,
          ClipR.Left + MulDiv(TSynGutterBand.MarginX, FCurrentPPI, 96), YPos,
          ImgIndex);
    end;
  end;
end;

procedure TEditorForm.SynEditGutterDebugInfoCLick(Sender: TObject;
Button: TMouseButton; X, Y, Row, Line: Integer);
var ASynEdit: TSynEdit;
begin
  ASynEdit := Sender as TSynEdit;
  if (ASynEdit.Highlighter = ResourcesDataModule.SynPythonSyn) and
    (PyControl.ActiveDebugger <> nil) then
    GI_BreakpointManager.ToggleBreakpoint(FEditor.GetFileId, Line,
      GetKeyState(VK_CONTROL) < 0);
end;

procedure TEditorForm.SynEditGutterDebugInfoMouseCursor(Sender: TObject;
X, Y, Row, Line: Integer; var Cursor: TCursor);
begin
  Cursor := crHandPoint;
end;

procedure TEditorForm.InsertLinesAt(Line: Integer; ALines: string);
var CarX, CarY, TopL, CountLines: Integer; Collapsed: Boolean;
begin
  if not ALines.EndsWith(CrLf) then
    ALines := ALines + CrLf;
  with ActiveSynEdit do
  begin
    BeginUpdate;
    Collapsed := (AllFoldRanges.Count > 2) and AllFoldRanges.Ranges[2]
      .Collapsed;
    CarX := CaretX;
    CarY := CaretY;
    TopL := TopLine;
    if Line > LineS.Count then
    begin
      ExecuteCommand(ecEditorBottom, #0, nil);
      while Line > LineS.Count do
        ExecuteCommand(ecInsertLine, #0, nil);
    end;
    CaretY := Line + 1;
    CaretX := 1;
    PutText(ALines, False);
    if CarY > Line + 1 then
    begin
      CountLines := CountChar(#13, ALines);
      if CountLines = 0 then
        CountLines := 1;
      CarY := CarY + CountLines;
      TopL := TopL + CountLines;
    end;
    TopLine := TopL;
    CaretX := CarX;
    CaretY := CarY;
    EnsureCursorPosVisible;
    Modified := True;
    if Collapsed then
      Collapse(2);
    EndUpdate;
  end;
  Modified := True;
end;

procedure TEditorForm.InsertNewAttribute(const Attribute: string);
begin
  InsertLinesAt(GetLastCreateWidgetsLine, Attribute);
end;

procedure TEditorForm.InsertAtBegin(const Text: string);
begin
  InsertLinesAt(GetFirstCreateWidgetsLine, Text);
end;

procedure TEditorForm.InsertAtEnd(const Text: string);
begin
  InsertLinesAt(GetLastCreateWidgetsLine, Text);
end;

procedure TEditorForm.InsertAttributeCE(const Attribute: string;
ClassNumber: Integer);
var Operation: TOperation;
begin
  Operation := GetConstructor(ClassNumber);
  if Assigned(Operation) then
    InsertLinesAt(Operation.LineSE, Attribute);
end;

function TEditorForm.GetLineNumberOfBinding(const Name, Attr: string): Integer;
var Line, Till, Posi: Integer; Key1, Key2: string;
begin
  Result := -1;
  Key1 := 'self.' + Name + '.bind';
  Key2 := 'self.' + Name + '_' + Attr;
  Line := GetLineNumberWithWord(Key1);
  Till := GetLastCreateWidgetsLine;
  Posi := Pos(Key2, ActiveSynEdit.LineS[Line]);
  while (Posi = 0) and (-1 < Line) and (Line < Till) do
  begin
    Inc(Line);
    Line := GetLineNumberWithWordFromTill(Key1, Line, Till);
    if Line > -1 then
      Posi := Pos(Key2, ActiveSynEdit.LineS[Line]);
  end;
  if (Line >= 0) and (Line < Till) and (Posi > 0) then
    Result := Line;
end;

procedure TEditorForm.InsertTkBinding(const Name, Attr, Binding: string);
var Line: Integer;
begin
  Line := GetLineNumberOfBinding(Name, Attr);
  if Line >= 0 then
    ActiveSynEdit.LineS[Line] := Binding
  else
    InsertValue(Name, Binding, 1);
  Modified := True;
end;

procedure TEditorForm.InsertQtBinding(const Name, Binding: string);
var Key: string;
begin
  Key := Copy(Binding, 1, Pos('(', Binding) - 1);
  SetAttributValue(Name, Key, Binding, 1);
  Modified := True;
end;

procedure TEditorForm.InsertProcedure(const AProcedure: string;
ClassNumber: Integer = 0);
var Line: Integer;
begin
  ParseAndCreateModel;
  Line := GetLineForMethod(ClassNumber);
  if (Line > -1) and (AProcedure <> '') then
    InsertLinesAt(Line, AProcedure);
end;

procedure TEditorForm.InsertProcedureWithoutParse(const AProcedure: string;
ClassNumber: Integer = 0);
var Line: Integer;
begin
  Line := GetLineForMethod(ClassNumber);
  if Line > -1 then
    InsertLinesAt(Line, AProcedure);
end;

procedure TEditorForm.InsertConstructor(const AConstructor: string;
ClassNumber: Integer);
var Line: Integer;
begin
  Line := GetLineForConstructor(ClassNumber);
  if Line > -1 then
    InsertLinesAt(Line, AConstructor);
end;

procedure TEditorForm.InsertImport(Module: string);
begin
  with ActiveSynEdit do
  begin
    var
    Line := GetLineNumberWithWord('import');
    if Line = -1 then
    begin
      Module := Module + CrLf;
      Line := GetLineNumberWithWord('class');
      if Line > -1 then
        Line := Line - 1
      else
        Line := 0;
    end
    else
    begin
      while (Line < LineS.Count) and (Pos('import', LineS[Line]) > 0) do
      begin
        if Pos(Module, LineS[Line]) > 0 then
          Exit;
        Inc(Line);
      end;
      Dec(Line);
    end;
    InsertLinesAt(Line + 1, Module + CrLf);
    ParseAndCreateModel;
  end;
end;

procedure TEditorForm.DeleteEmptyLine(Line: Integer);
begin
  ActiveSynEdit.BeginUpdate;
  if Trim(ActiveSynEdit.LineS[Line]) = '' then
    DeleteLine(Line);
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteLine(Line: Integer);
var Int: Integer; Collapsed: Boolean;
begin
  Int := 0;
  while Int < ActiveSynEdit.Marks.Count do
  begin
    if ActiveSynEdit.Marks[Int].Line = Line then
      DeleteBreakpointMark(ActiveSynEdit.Marks[Int]);
    Inc(Int);
  end;
  Collapsed := (ActiveSynEdit.AllFoldRanges.Count > 1) and
    ActiveSynEdit.AllFoldRanges.Ranges[1].Collapsed;
  ActiveSynEdit.CaretY := Line + 1;
  ActiveSynEdit.CommandProcessor(ecDeleteLine, #0, nil);
  if Collapsed then
    ActiveSynEdit.Collapse(1);
  Modified := True;
end;

procedure TEditorForm.DeleteLine(const Line: string);
begin
  var
  Num := GetLineNumberWith(Line);
  if Num > -1 then
    DeleteLine(Num);
end;

procedure TEditorForm.DeleteBlock(StartLine, EndLine: Integer);
begin
  ActiveSynEdit.BeginUpdate;
  for var I := EndLine downto StartLine do
    if I < ActiveSynEdit.LineS.Count then
      DeleteLine(I);
  Modified := True;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteComponent(Control: TControl);
begin
  ActiveSynEdit.BeginUpdate;
  var
  CreateWidget := GetCreateWidgets;
  if Assigned(CreateWidget) then
  begin
    for var I := CreateWidget.LineE - 1 downto CreateWidget.LineS do
      if HasWidget(Control.Name, I) then
        DeleteLine(I);
  end;
  Modified := True;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteItems(const Name, Key: string);
begin
  ActiveSynEdit.BeginUpdate;
  var
  CreateWidget := GetCreateWidgets;
  if Assigned(CreateWidget) then
  begin
    for var I := CreateWidget.LineE - 1 downto CreateWidget.LineS do
    begin
      var
      RegEx := '^[ \t]*self\.' + Name + '(' + Key + '\d+)';
      if TRegEx.IsMatch(ActiveSynEdit.LineS[I], RegEx) then
        DeleteLine(I);
    end;
  end;
  Modified := True;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.DeleteMethod(const Method: string);
var Line: Integer;
begin
  if Method <> '' then
  begin
    ActiveSynEdit.LineS.BeginUpdate;
    Line := GetLineNumberWithWord('def ' + Method);
    // don't delete implemented methods automatically
    if (Line > -1) and (Line + 2 < ActiveSynEdit.LineS.Count) and
      (ActiveSynEdit.LineS[Line + 1] = FIndent2 + LNGInsertSourceCodeHere) and
      (ActiveSynEdit.LineS[Line + 2] = FIndent2 + 'pass') then
    begin
      DeleteBlock(Line, Line + 2);
      while (Line < ActiveSynEdit.LineS.Count - 1) and
        (Trim(ActiveSynEdit.LineS[Line]) = '') do
        DeleteLine(Line);
    end;
    ActiveSynEdit.LineS.EndUpdate;
  end;
end;

type
  TMethodSource = record
    Name: string;
    From: Integer;
    Till: Integer;
  end;

procedure TEditorForm.DeleteOldAddNewMethods(OldMethods,
  NewMethods: TStringList);
var Posi, From, Till, Index: Integer; Cite, Ite: IModelIterator;
  Cent: TModelEntity; Method: TOperation;
  MethodArray: array [0 .. 500] of TMethodSource; StringList: TStringList;
  Str1, Str2, Func: string;

  function InMethodArray(Com: string): Integer;
  begin
    Result := -1;
    for var I := 0 to Index do
      if Pos(MethodArray[I].Name + '(', Com) = 1 then
        Result := I;
  end;

begin
  // 1. add new methods at the end
  // 2. delete old methods in the middle
  ParseAndCreateModel;
  StringList := TStringList.Create;

  // get existing methods
  Index := -1;
  Cite := FModel.ModelRoot.GetAllClassifiers;
  while Cite.HasNext do
  begin
    Cent := Cite.Next;
    if Cent is TClass then
    begin
      Ite := (Cent as TClass).GetOperations;
      while Ite.HasNext do
      begin
        Inc(Index);
        Method := Ite.Next as TOperation;
        MethodArray[Index].Name := Method.Name;
        MethodArray[Index].From := Method.LineS - 1;
        MethodArray[Index].Till := Method.LineE - 1;
      end;
    end;
  end;

  // add missing new methods
  for var I := 0 to NewMethods.Count - 1 do
    if InMethodArray(NewMethods[I]) = -1 then
    begin
      Func := CrLf + FIndent1 + 'def ' + NewMethods[I] + CrLf + FIndent2 +
        LNGInsertSourceCodeHere + CrLf + FIndent2 + 'pass';
      StringList.Add(Func);
    end;
  InsertProcedure(StringList.Text);

  // delete unnecessary default methods
  // determine methods to delete
  StringList.Clear;
  for var I := 0 to OldMethods.Count - 1 do // keeps method lines valid
    if NewMethods.IndexOf(OldMethods[I]) = -1 then
    begin
      Posi := InMethodArray(OldMethods[I]);
      if Posi > -1 then
      begin
        // delete if default
        From := MethodArray[Posi].From;
        Till := MethodArray[Posi].Till;
        Str1 := GetSource(From, Till);
        Str2 := FIndent1 + 'def ' + OldMethods[I] + CrLf + FIndent2 +
          LNGInsertSourceCodeHere + CrLf + FIndent2 + 'pass' + CrLf;
        if Str1 = Str2 then
          StringList.Add(Copy(OldMethods[I], 1, Pos('(', OldMethods[I]) - 1));
      end;
    end;

  // delete beginning at the end of the sourcecode
  for var I := Index downto 0 do
    if StringList.IndexOf(MethodArray[I].Name) > -1 then
    begin
      From := MethodArray[I].From;
      Till := MethodArray[I].Till;
      DeleteBlock(From, Till);
      while (From < ActiveSynEdit.LineS.Count - 1) and
        (Trim(ActiveSynEdit.LineS[From]) = '') do
        DeleteLine(From);
      InsertLinesAt(From, '');
    end;
  FreeAndNil(StringList);
end;

procedure TEditorForm.DeleteBinding(const Binding: string);
var Line: Integer;
begin
  Line := GetLineNumberWith(Binding);
  if Line > -1 then
  begin
    DeleteLine(Line);
    Modified := True;
  end;
end;

procedure TEditorForm.DeleteAttribute(const Attribute: string);
var Line: Integer;
begin
  Line := GetLineNumberWithWord(Attribute);
  if (0 <= Line) and (Line < GetLastCreateWidgetsLine) then
  begin
    DeleteLine(Line);
    Modified := True;
  end;
end;

procedure TEditorForm.DeleteAttributeCE(const Attribute: string;
ClassNumber: Integer);
var Operation: TOperation; Line: Integer;
begin
  Operation := GetConstructor(ClassNumber);
  if Assigned(Operation) then
  begin
    if Operation.LineE = Operation.LineSE + 1 then // last attribute
      ReplaceAttribute(Attribute, StringTimesN(FConfiguration.Indent1,
        Operation.Level + 2) + 'pass')
    else
    begin
      Line := GetLineNumberWithWordFromTill(Attribute, Operation.LineSE);
      if Line > -1 then
        DeleteLine(Line);
    end;
  end;
end;

procedure TEditorForm.DeleteAttributeValues(const Values: string);
var Line, Till: Integer;
begin
  if Values = 'self.' then
    raise Exception.CreateFmt('Invalid name : ''%s''', [Values]);

  ActiveSynEdit.BeginUpdate;
  Line := GetLineNumberWithWord(Values);
  Till := GetLastCreateWidgetsLine;
  while (-1 < Line) and (Line < Till) do
  begin
    DeleteLine(Line);
    Dec(Till);
    Modified := True;
    Line := GetLineNumberWithWordFromTill(Values, Line, Till);
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.MoveBlock(From, Till, Dest, DestTill: Integer;
const BlankLines: string);
var Str: string;

  procedure DeleteBlanklines(Num: Integer);
  var Str: string;
  begin
    if Num > 0 then
    begin
      Str := Trim(ActiveSynEdit.LineS[Num - 1]) +
        Trim(ActiveSynEdit.LineS[Num]);
      if Str = '' then
        DeleteLine(Num);
      Str := Trim(ActiveSynEdit.LineS[Num - 1]) +
        Trim(ActiveSynEdit.LineS[Num]);
      if Str = '' then
        DeleteLine(Num);
    end
    else if (Num < ActiveSynEdit.LineS.Count - 1) then
    begin
      Str := Trim(ActiveSynEdit.LineS[Num]) +
        Trim(ActiveSynEdit.LineS[Num + 1]);
      if Str = '' then
        DeleteLine(Num);
    end;
  end;

begin
  ActiveSynEdit.BeginUpdate;
  Str := '';
  for var I := From to Till do
    Str := Str + ActiveSynEdit.LineS[I] + #13#10;
  Str := Str + BlankLines;
  if Dest < From then
  begin
    for var I := From to Till do
      DeleteLine(From);
    DeleteBlanklines(From);
    InsertLinesAt(Dest, Str);
  end
  else
  begin // Dest > From
    InsertLinesAt(DestTill + 1, Str);
    for var I := From to Till do
      DeleteLine(From);
    DeleteBlanklines(From);
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.ToBackground(Control: TControl);
var From, Till: Integer; Operation: TOperation;
begin
  if Control is TBaseWidget then
  begin
    Operation := GetCreateWidgets;
    if Assigned(Operation) then
    begin
      From := GetFirstWidget(Operation.LineS, Control.Name);
      Till := From + 1;
      while (Till < Operation.LineE) and HasWidget(Control.Name, Till) do
        Inc(Till);
      Dec(Till);
      if Till > -1 then
        MoveBlock(From, Till, Operation.LineS, 0, '');
    end;
  end;
end;

procedure TEditorForm.ToForeground(Control: TControl);
var From, Till: Integer; Operation: TOperation;
begin
  if Control is TBaseWidget then
  begin
    Operation := GetCreateWidgets;
    if Assigned(Operation) then
    begin
      From := GetFirstWidget(Operation.LineS, Control.Name);
      Till := From + 1;
      while (Till < Operation.LineE) and HasWidget(Control.Name, Till) do
        Inc(Till);
      Dec(Till);
      if Till > -1 then
        MoveBlock(From, Till, Operation.LineE - 2, Operation.LineE - 2, '');
    end;
  end;
end;

procedure TEditorForm.GoTo2(const Str: string);
var Line: Integer;
begin
  with ActiveSynEdit do
  begin
    Line := GetLineNumberWithWord(Str);
    if (0 <= Line) and (Line <= LineS.Count - 1) then
      if Pos('def ', LineS[Line]) > 0 then
      begin
        CaretY := Line + 2;
        CaretX := Length(FIndent2) + 1;
      end
      else
      begin
        CaretX := Pos(Str, LineS[Line]);
        CaretY := Line + 1;
      end;
  end;
end;

procedure TEditorForm.ShowTopLine(LineNum: Integer; const NodeText: string);
var IsWrapping: Boolean; Line: string;
begin
  IsWrapping := ActiveSynEdit.WordWrap;
  // Changing TopLine/CaretXY calls indirect ShowSelected;
  if IsWrapping then
    TBWordWrapClick(nil);
  Line := ActiveSynEdit.LineS[LineNum - 1];
  ActiveSynEdit.TopLine := LineNum;
  ActiveSynEdit.CaretXY := BufferCoord(Max(1, Pos(NodeText, Line)), LineNum);
  if IsWrapping then
    TBWordWrapClick(nil);
end;

function TEditorForm.HasText(const Text: string): Boolean;
begin
  Result := (Pos(Text, ActiveSynEdit.Text) > 0);
end;

function TEditorForm.HasWidget(const Key: string; Line: Integer): Boolean;
var RegEx: string;
begin
  if Pos(FIndent2, Key) = 1 then
    RegEx := '^' + Key +
      '(CV|TV|LV|VC|ScrollbarH|ScrollbarV|Image|RB\d+|Tab\d+)?\b'
  else
    RegEx := '^[ \t]*self\.' + Key +
      '(CV|TV|LV|VC|ScrollbarH|ScrollbarV|Image|RB\d+|Tab\d+)?\b';
  Result := TRegEx.IsMatch(ActiveSynEdit.LineS[Line], RegEx);
end;

function TEditorForm.CBSearchClassOrMethod(Stop: Boolean;
Line: Integer): string;
var AClassname, AMethodname: string; Cite, Ite: IModelIterator;
  Cent: TClassifier; Method: TOperation; Found: Boolean; ClassInLine: Integer;
begin
  // ParseSourcecode;  to be done by caller
  Result := '';
  Found := False;
  ClassInLine := -1;
  Cite := FModel.ModelRoot.GetAllClassifiers;
  while Cite.HasNext and not Found do
  begin
    Cent := TClassifier(Cite.Next);
    if Cent.Pathname = Pathname then
    begin
      if Cent.LineS > Line then
        Break;
      if (Cent.LineS <= Line) and (Line <= Cent.LineE) then
      begin
        AClassname := Cent.Name;
        ClassInLine := Cent.LineS;
        AMethodname := '';
        Ite := Cent.GetOperations;
        while Ite.HasNext and not Found do
        begin
          Method := Ite.Next as TOperation;
          if Method.LineS = Line then
          begin
            AMethodname := Method.Name;
            Found := True;
          end;
        end;
      end;
    end;
  end;
  if AClassname = '' then
    Exit;

  if Stop then
  begin
    if Found then
      Result := 'stop in ' + AClassname + '.' + AMethodname
    else if Line > ClassInLine then
      Result := 'stop at ' + AClassname + ':' + IntToStr(Line);
  end
  else // clear
    if Found then
      Result := 'clear ' + AClassname + '.' + AMethodname
    else if Line > ClassInLine then
      Result := 'clear ' + AClassname + ':' + IntToStr(Line);
end;

procedure TEditorForm.DeleteBreakpointMark(Mark: TSynEditMark);
const StopInAt = True;
var Str: string;
begin
  Str := CBSearchClassOrMethod(not StopInAt, Mark.Line);
  { if myDebugger.Running and (Str <> '') then      ToDo
    myDebugger.NewCommand(2, Str); }
  ActiveSynEdit.InvalidateLine(Mark.Line);
  ActiveSynEdit.Marks.Remove(Mark);
  // Dec(BreakPointCount);
  // ResetGutterOffset;
end;

function TEditorForm.GetClass(ClassNumber: Integer): TClass;
var Cite: IModelIterator; Cent: TClassifier;
begin
  Result := nil;
  Cite := FModel.ModelRoot.GetAllClassifiers;
  while Cite.HasNext do
  begin
    Cent := TClassifier(Cite.Next);
    if Cent.Pathname = '' then
      Continue;
    if ClassNumber = 0 then
      Exit(Cent as TClass);
    Dec(ClassNumber);
  end;
end;

function TEditorForm.GetLineForMethod(ClassNumber: Integer): Integer;
var Cite, Ite: IModelIterator; Cent: TClassifier; Method: TOperation;
begin
  Result := -1;
  Method := nil;
  Cite := FModel.ModelRoot.GetAllClassifiers;
  while Cite.HasNext do
  begin
    Cent := TClassifier(Cite.Next);
    if Cent.Pathname = '' then
      Continue;
    if ClassNumber = 0 then
    begin
      Ite := (Cent as TClass).GetOperations;
      while Ite.HasNext do
        Method := Ite.Next as TOperation;
      if Assigned(Method) then
        Exit(Method.LineE)
      else
        Exit(-1);
    end;
    Dec(ClassNumber);
  end;
end;

function TEditorForm.GetConstructor(ClassNumber: Integer): TOperation;
var Ite: IModelIterator; Cent: TClassifier; Operation: TOperation;
begin
  Cent := GetClass(ClassNumber);
  if Assigned(Cent) then
  begin
    Ite := Cent.GetOperations;
    while Ite.HasNext do
    begin
      Operation := TOperation(Ite.Next);
      if Operation.OperationType = otConstructor then
        Exit(Operation);
    end;
  end;
  Result := nil;
end;

function TEditorForm.GetCreateWidgets: TOperation;
var Ite: IModelIterator; Cent: TClassifier; Operation: TOperation;
begin
  Cent := GetClass(0);
  if Assigned(Cent) then
  begin
    Ite := Cent.GetOperations;
    while Ite.HasNext do
    begin
      Operation := TOperation(Ite.Next);
      if Operation.Name = 'create_widgets' then
        Exit(Operation);
    end;
  end;
  Result := nil;
end;

procedure TEditorForm.RemovePass(ClassNumber: Integer);
var Posi: Integer; Line: string; Operation: TOperation;
begin
  Operation := GetConstructor(ClassNumber);
  if Assigned(Operation) then
    for var I := Operation.LineS + 1 to Operation.LineE do
    begin
      Line := ActiveSynEdit.LineS[I - 1];
      Posi := Pos('#', Line);
      if Posi > 0 then
        Delete(Line, Posi, Length(Line));
      if Trim(Line) = 'pass' then
      begin
        ActiveSynEdit.LineS.Delete(I - 1);
        Operation.LineE := Operation.LineE - 1;
      end;
    end;
end;

procedure TEditorForm.SetAttributValue(const Destination, Key, Value: string;
After: Integer);
var Line, Till: Integer; Changed: Boolean;
begin
  Changed := True;
  Line := GetLineNumberWithWord(Key);
  Till := GetLastCreateWidgetsLine;
  if (Line >= 0) and (Line < Till) then
    if Trim(Value) = '' then
      DeleteLine(Line)
    else
      ActiveSynEdit.LineS[Line] := Value
  else
  begin
    Line := GetLineNumberWithWord(Destination);
    // self.create_widgets, self.button1
    if (Line = -1) or (Line >= Till) then
      Line := Till
    else if After = 1 then
    begin
      Inc(Line);
      while (Line < Till) and HasWidget(Destination, Line) do
        Inc(Line);
    end;
    if Line >= 0 then
      InsertLinesAt(Line, Value)
    else
      Changed := False;
  end;
  Modified := Changed;
end;

procedure TEditorForm.InsertValue(const Destination, Value: string;
After: Integer);
var Line, From, Till: Integer; Changed: Boolean;
begin
  Changed := True;
  From := GetFirstCreateWidgetsLine;
  Till := GetLastCreateWidgetsLine;
  Line := GetLineNumberWithWordFromTill(Destination, From, Till);
  if (Line = -1) or (Line >= Till) then
    Line := Till
  else if After = 1 then
  begin
    Inc(Line);
    while (Line < Till) and HasWidget(Destination, Line) do
      Inc(Line);
  end;
  if Line >= 0 then
    InsertLinesAt(Line, Value)
  else
    Changed := False;
  Modified := Changed;
end;

function TEditorForm.GetLastConstructorLine(ClassNumber: Integer): Integer;
var Cent: TClassifier; Operation: TOperation; Ident, Text: string;
begin
  Operation := GetConstructor(ClassNumber);
  if Assigned(Operation) then
    Exit(Operation.LineE);
  Cent := GetClass(ClassNumber);
  Ident := StringTimesN(FConfiguration.Indent1, Cent.Level + 1);
  Text := Ident + 'def __init__(self):' + CrLf;
  InsertLinesAt(Cent.LineSE + 1, Text);
  Result := Cent.LineSE + 2;
end;

function TEditorForm.GetLastCreateWidgetsLine: Integer;
var Cent: TClassifier; Operation: TOperation; Ident, Text: string;
  LineS, LineE: Integer;
begin
  Result := -1;
  LineS := GetLineNumberWith('def create_widgets(self):');
  if LineS = -1 then
  begin
    ParseAndCreateModel;
    Cent := GetClass(0);
    if Assigned(Cent) then
    begin
      Ident := StringTimesN(FConfiguration.Indent1, Cent.Level + 1);
      Text := CrLf + Ident + 'def create_widgets(self):' + CrLf;
      InsertLinesAt(Cent.LineE, Text);
      Exit(Cent.LineE + 2);
    end
    else
      Exit(-1);
  end;
  LineE := GetLineNumberWithWordFromTill('pass', LineS + 1);
  if LineE = -1 then
  begin
    ParseAndCreateModel;
    Operation := GetCreateWidgets;
    if Assigned(Operation) then
    begin
      InsertLinesAt(Operation.LineE, FConfiguration.Indent2 + 'pass');
      Exit(Operation.LineE);
    end;
  end
  else
    Exit(LineE);
end;

function TEditorForm.GetFirstCreateWidgetsLine: Integer;
var Cent: TClassifier; Ident, Text: string; LineS: Integer;
begin
  LineS := GetLineNumberWith('def create_widgets(self):');
  if LineS = -1 then
  begin
    ParseAndCreateModel;
    Cent := GetClass(0);
    if Assigned(Cent) then
    begin
      Ident := StringTimesN(FConfiguration.Indent1, Cent.Level + 1);
      Text := CrLf + Ident + 'def create_widgets(self):' + CrLf;
      InsertLinesAt(Cent.LineE, Text);
      Result := Cent.LineE;
    end
    else
      Result := -1;
  end
  else
    Result := LineS + 1;
end;

function TEditorForm.GetLineForConstructor(ClassNumber: Integer): Integer;
var Cite: IModelIterator; Cent: TClassifier;
begin
  Result := -1;
  Cite := FModel.ModelRoot.GetAllClassifiers;
  while Cite.HasNext do
  begin
    Cent := TClassifier(Cite.Next);
    if ClassNumber = 0 then
      Exit(Cent.LineSE + 1);
    Dec(ClassNumber);
  end;
end;

function TEditorForm.GetFirstWidget(From: Integer;
const Widget: string): Integer;
begin
  Result := -1;
  var
  I := From;
  repeat
    if HasWidget(Widget, I) then
      Exit(I);
    Inc(I);
  until I >= ActiveSynEdit.LineS.Count;
end;

function TEditorForm.GetLineNumberWith(const Text: string): Integer;
begin
  Result := GetLineNumberWithFrom(0, Text);
end;

function TEditorForm.GetLineNumberWithFrom(From: Integer;
const Text: string): Integer;
var Int: Integer;
begin
  Result := -1;
  Int := From;
  repeat
    if (Int < ActiveSynEdit.LineS.Count) and
      (Pos(Text, ActiveSynEdit.LineS[Int]) > 0) then
      Exit(Int);
    Inc(Int);
  until Int >= ActiveSynEdit.LineS.Count;
end;

function TEditorForm.GetLineNumberWithWord(const Word: string): Integer;
begin
  Result := GetLineNumberWithWordFromTill(Word, 0);
end;

function TEditorForm.GetLineNumberWithWordFromTill(const Word: string;
From: Integer; Till: Integer = 0): Integer;
var Int: Integer; RegEx: TRegEx;
begin
  Result := -1;
  if (Word <> '') and (Word[Length(Word)] = ']') then
    RegEx := CompiledRegEx('\b' + TRegEx.Escape(Word))
  else if Pos(FIndent2, Word) = 1 then
    RegEx := CompiledRegEx('^' + TRegEx.Escape(Word) + '\b')
  else
    RegEx := CompiledRegEx('\b' + TRegEx.Escape(Word) + '\b');
  Int := From;
  if Till = 0 then
    Till := ActiveSynEdit.LineS.Count;
  repeat
    if RegEx.IsMatch(ActiveSynEdit.LineS[Int]) then
      Exit(Int);
    Inc(Int);
  until Int >= Till;
end;

function TEditorForm.GetSource(LineS, LineE: Integer): string;
begin
  Result := '';
  for var I := LineS to LineE do
    Result := Result + ActiveSynEdit.LineS[I] + #13#10;
end;

procedure TEditorForm.ReplaceLine(const Str1, Str2: string);
begin
  if Str1 <> Str2 then
  begin
    var
    Line := GetLineNumberWith(Str1);
    if Line >= 0 then
    begin
      ActiveSynEdit.LineS[Line] := Str2;
      Modified := True;
    end;
  end;
end;

procedure TEditorForm.ReplaceLineInLine(Line: Integer; const Old, New: string);
var ALine: string; Posi: Integer;
begin
  if (0 <= Line) and (Line < ActiveSynEdit.LineS.Count) then
  begin
    ALine := ActiveSynEdit.LineS[Line];
    Posi := Pos(Old, ALine);
    if Posi = 0 then
      ALine := ''
    else
      ALine := Copy(ALine, Posi + Length(Old), Length(ALine));
    // preserve comments
    ActiveSynEdit.LineS[Line] := New + ALine;
    Modified := True;
  end;
end;

procedure TEditorForm.ReplaceWord(const Word1, Word2: string; All: Boolean);
var Line: Integer; Ws1, RegExExpr: string; RegEx: TRegEx;
  Matches: TMatchCollection; Group: TGroup;
begin
  if (Word1 = Word2) or (Word1 = '') then
    Exit;
  ActiveSynEdit.BeginUpdate;
  // '(' + Word1 + ')' is Groups[1]
  RegExExpr := '\b(' + TRegEx.Escape(Word1) +
    ')(CV|TV|LV|ScrollbarH|ScrollbarV|Image|Painter|RB\d+|Tab\d+)?';
  if not IsWordBreakChar(Word1[Length(Word1)]) then
    RegExExpr := RegExExpr + '\b';
  RegEx := CompiledRegEx(RegExExpr);
  Line := GetLineNumberWithFrom(0, Word1);
  while Line >= 0 do
  begin // for every Line
    Ws1 := ActiveSynEdit.LineS[Line];
    Matches := RegEx.Matches(Ws1);
    for var I := Matches.Count - 1 downto 0 do
    begin
      Group := Matches[I].Groups[1];
      Delete(Ws1, Group.Index, Group.Length);
      Insert(Word2, Ws1, Group.Index);
    end;
    ActiveSynEdit.LineS[Line] := Ws1;
    Line := GetLineNumberWithFrom(Line + 1, Word1);
    Modified := True;
    if not All then
      Break;
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.ReplaceComponentname(const Name1, Name2: string;
Events: string);
var Line: Integer; Ws1, RegExExpr: string; RegEx: TRegEx;
  Matches: TMatchCollection; Group: TGroup;
begin
  if Name1 = Name2 then
    Exit;
  ReplaceWord('self.' + Name1, 'self.' + Name2, True);
  ActiveSynEdit.BeginUpdate;
  while Pos('|', Events) = 1 do
    Delete(Events, 1, 1);
  while Events[Length(Events)] = '|' do
    Delete(Events, Length(Events), 1);
  Events := Events + '|Command';

  if Pos('self.', Name1) > 0 then
    raise Exception.CreateFmt('Invalid name : ''%s''', [Name1]);
  // '(' + Name1 + ')' is Groups[1]
  RegExExpr := '\b(' + TRegEx.Escape(Name1) + ')_(' + Events + ')\b';
  RegEx := CompiledRegEx(RegExExpr);
  Line := GetLineNumberWithFrom(0, Name1);
  while Line >= 0 do
  begin // for every Line
    Ws1 := ActiveSynEdit.LineS[Line];
    Matches := RegEx.Matches(Ws1);
    for var I := Matches.Count - 1 downto 0 do
    begin
      Group := Matches[I].Groups[1];
      Delete(Ws1, Group.Index, Group.Length);
      Insert(Name2, Ws1, Group.Index);
    end;
    ActiveSynEdit.LineS[Line] := Ws1;
    Line := GetLineNumberWithFrom(Line + 1, Name1);
    Modified := True;
  end;
  ActiveSynEdit.EndUpdate;
end;

procedure TEditorForm.ReplaceAttribute(const Key, Attr: string);
var Line: Integer;
begin
  Line := GetLineNumberWithWord(Key);
  if Line >= 0 then
  begin
    ActiveSynEdit.LineS[Line] := Attr;
    Modified := True;
  end
  else
    InsertNewAttribute(Attr);
end;

procedure TEditorForm.CreateModel;
var Parser: TPythonParser; Module: TParsedModule;
begin
  if Assigned(FSourceScanner) then
  begin
    Module := FSourceScanner.ParsedModule;
    FModel.Lock;
    FModel.Clear;
    Parser := TPythonParser.Create(True);
    try
      Parser.ParseModul(Module, FModel.ModelRoot, FModel, Pathname, 0, False);
    finally
      FreeAndNil(Parser);
      FModel.Unlock;
    end;
  end;
end;

procedure TEditorForm.ParseAndCreateModel;
begin
  FNeedToParseModule := True;
  ReparseIfNeeded;
end;

procedure TEditorForm.pmnuEditorPopup(Sender: TObject);
begin
  mnEditGit.Visible := FConfiguration.GitOK;
  mnEditCut.ImageIndex := -1;
  mnEditCopy.ImageIndex := -1;
  mnEditPaste.ImageIndex := -1;
  mnEditDelete.ImageIndex := -1;
end;

procedure TEditorForm.NewClass(const Pathname: string);
var Template, Name, AIndent: string; Posi: Integer;
begin
  Name := ChangeFileExt(ExtractFileName(Pathname), '');
  AIndent := FConfiguration.Indent1;
  Template := FConfiguration.GetClassCodeTemplate;

  if Template = '' then
    Template := 'class ' + Name + ':' + CrLf + AIndent + CrLf + AIndent +
      'def __init__(self):' + CrLf + AIndent + AIndent + 'pass'
  else
  begin
    Posi := Pos('|', Template);
    Insert(Name, Template, Posi + 1);
    Delete(Template, Posi, 1);
  end;

  ActiveSynEdit.Clear;
  PutText(Template);
  DoSave;
  ParseAndCreateModel;
  Modified := False;
end;

procedure TEditorForm.ExportToClipboard(LineS: TStringList;
Exporter: TSynCustomExporter; AsText: Boolean);
begin
  with Exporter do
  begin
    // python source code can be exported as RTF or HTML
    // the exporter must know the highlighter;
    Highlighter := ActiveSynEdit.Highlighter;
    ExportAsText := AsText;
    ExportAll(LineS);
    Exporter.CopyToClipboard;
  end;
end;

function TEditorForm.GetNumbered: TStringList;
var LineS: TStringList; Digits: Integer;

  function getFormatted(Int, Digits: Integer): string;
  var Str: string;
  begin
    Str := IntToStr(Int);
    while Length(Str) < Digits do
      Str := '0' + Str;
    Result := Str + ' ';
  end;

begin
  LineS := TStringList.Create;
  LineS.Text := ActiveSynEdit.SelText;
  Digits := 3;
  if LineS.Count < 100 then
    Digits := 2;
  if LineS.Count < 10 then
    Digits := 1;
  for var I := 0 to LineS.Count - 1 do
    LineS[I] := getFormatted(I + 1, Digits) + LineS[I];
  Result := LineS;
end;

procedure TEditorForm.CopySelected;
begin
  Clipboard.AsText := ActiveSynEdit.SelText;
end;

procedure TEditorForm.CopyRTF;
var LineS: TStringList; RTFExporter: TSynExporterRTF;
begin
  LineS := TStringList.Create;
  LineS.Text := ActiveSynEdit.SelText;
  RTFExporter := TSynExporterRTF.Create(Self);
  ExportToClipboard(LineS, RTFExporter, False);
  FreeAndNil(LineS);
  FreeAndNil(RTFExporter);
end;

procedure TEditorForm.CopyRTFNumbered;
var LineS: TStringList; RTFExporter: TSynExporterRTF;
begin
  LineS := GetNumbered;
  RTFExporter := TSynExporterRTF.Create(Self);
  ExportToClipboard(LineS, RTFExporter, False);
  FreeAndNil(LineS);
  FreeAndNil(RTFExporter);
end;

procedure TEditorForm.CopyHTML(AsText: Boolean);
begin
  var
  LineS := TStringList.Create;
  LineS.Text := ActiveSynEdit.SelText;
  var
  HTMLExporter := TSynExporterHTML.Create(Self);
  if not AsText then
    HTMLExporter.CreateHTMLFragment := True;
  ExportToClipboard(LineS, HTMLExporter, AsText);
  FreeAndNil(LineS);
  FreeAndNil(HTMLExporter);
end;

procedure TEditorForm.CopyNumbered;
begin
  var
  LineS := GetNumbered;
  Clipboard.AsText := LineS.Text;
  FreeAndNil(LineS);
end;

procedure TEditorForm.ExportToFile(const FileName: string;
Exporter: TSynCustomExporter);
begin
  with Exporter do
  begin
    Highlighter := ActiveSynEdit.Highlighter;
    ExportAsText := True;
    ExportAll(ActiveSynEdit.LineS);
    try
      SaveToFile(FileName);
    except
      on E: Exception do
        ErrorMsg(E.Message);
    end;
  end;
end;

procedure TEditorForm.DoExport;
var Folder: string; Exporter: TSynCustomExporter;
begin
  with ResourcesDataModule.dlgFileSave do
  begin
    Title := _('Export to');
    Filter := 'RTF (*.rtf)|*.rtf|HTML (*.html)|*.html;*.htm';
    FileName := Pathname;
    Folder := ExtractFilePath(FileName);
    FileName := ChangeFileExt(FileName, '');
    if Folder <> '' then
      InitialDir := Folder
    else
      InitialDir := GuiPyOptions.Sourcepath;
    if Execute then
    begin
      if ExtractFileExt(FileName) = '' then
        case FilterIndex of
          1:
            FileName := FileName + '.rtf';
          2:
            FileName := FileName + '.html';
        end;
      if not FileExists(FileName) or FileExists(FileName) and
        (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [FileName]),
        mtConfirmation, mbYesNoCancel, 0) = mrYes) then
      begin
        if LowerCase(ExtractFileExt(FileName)) = '.rtf' then
          Exporter := TSynExporterRTF.Create(Self)
        else
          Exporter := TSynExporterHTML.Create(Self);
        Exporter.Font.Assign(ActiveSynEdit.Font);
        ExportToFile(FileName, Exporter);
        if CanFocus then
          SetFocus;
        GuiPyOptions.Sourcepath := ExtractFilePath(FileName);
        FreeAndNil(Exporter);
      end;
    end;
  end;
end;

// compare to procedure TFUMLForm.CreateTVFileStructure;
procedure TEditorForm.CreateTVFileStructure;
var Cite, Ite, FuncIte: IModelIterator; Cent: TClassifier;
  Attribute: TAttribute; Method, Operation: TOperation;
  ImageNr, Indented, IndentedOld: Integer; CName: string; Node: TTreeNode;
  ClassNode: TTreeNode; AInteger: TInteger;

  function CalculateIndented(const AClassname: string): Integer;
  begin
    Result := 0;
    for var I := 1 to Length(AClassname) do
      if CharInSet(AClassname[I], ['$', '.']) then
        Inc(Result);
  end;

  procedure AddOperationNode(Operation: TOperation);
  var Node: TTreeNode;
  begin
    Node := TVFileStructure.Items.AddObject(nil, Operation.ToShortStringNode,
      TInteger.Create(Operation.LineS));
    Node.ImageIndex := 15;
    Node.SelectedIndex := 15;
    Node.HasChildren := False;
  end;

  procedure AddFunctions(BeforeLine: Integer);
  begin
    if Assigned(Operation) and (Operation.LineE < BeforeLine) then
      AddOperationNode(Operation);
    while FuncIte.HasNext do
    begin
      Operation := TOperation(FuncIte.Next);
      if Operation.LineE < BeforeLine then
        AddOperationNode(Operation)
      else
        Break;
    end;
  end;

begin
  Indented := 0;
  ClassNode := nil;
  Operation := nil;
  if not IsPython then
    Exit;
  TVFileStructure.Items.BeginUpdate;
  try
    for var I := TVFileStructure.Items.Count - 1 downto 0 do
    begin
      AInteger := TInteger(TVFileStructure.Items[I].Data);
      FreeAndNil(AInteger);
    end;
    TVFileStructure.Items.Clear;
    FuncIte := FModel.ModelRoot.GetFunctions;
    Cite := FModel.ModelRoot.GetAllClassifiers;
    while Cite.HasNext do
    begin
      Cent := TClassifier(Cite.Next);
      if Cent.Pathname <> Pathname then
        Continue;
      if Cent.Name.EndsWith('[]') then
        Continue;
      AddFunctions(Cent.LineS);

      { if (Cent is TClass)
        then isJUnitTestClass:= (Cent as TClass).isJUnitTestclass
        else isJunitTestClass:= false;
      }

      CName := Cent.ShortName;
      IndentedOld := Indented;
      Indented := Cent.Level;
      while Pos('$', CName) + Pos('.', CName) > 0 do
      begin
        Delete(CName, 1, Pos('$', CName));
        Delete(CName, 1, Pos('.', CName));
      end;

      if Indented = 0 then
        ClassNode := TVFileStructure.Items.AddObject(nil, CName,
          TInteger.Create(Cent.LineS))
      else if Indented > IndentedOld then
        ClassNode := TVFileStructure.Items.AddChildObject(ClassNode, CName,
          TInteger.Create(Cent.LineS))
      else
      begin
        while Indented <= IndentedOld do
        begin
          Dec(IndentedOld);
          ClassNode := ClassNode.Parent;
        end;
        ClassNode := TVFileStructure.Items.AddChildObject(ClassNode, CName,
          TInteger.Create(Cent.LineS));
      end;

      ClassNode.ImageIndex := 0;
      ClassNode.SelectedIndex := 0;
      ClassNode.HasChildren := True;

      Ite := Cent.GetAttributes;
      while Ite.HasNext do
      begin
        Attribute := Ite.Next as TAttribute;
        ImageNr := 1 + Integer(Attribute.Visibility);
        Node := TVFileStructure.Items.AddChildObject(ClassNode,
          Attribute.ToNameTypeUML, TInteger.Create(Attribute.LineS));
        Node.ImageIndex := ImageNr;
        Node.SelectedIndex := ImageNr;
        Node.HasChildren := False;
      end;
      Ite := Cent.GetOperations;
      while Ite.HasNext do
      begin
        Method := Ite.Next as TOperation;
        if Method.OperationType = otConstructor then
          ImageNr := 4
        else
          ImageNr := 5 + Integer(Method.Visibility);
        Node := TVFileStructure.Items.AddChildObject(ClassNode,
          Method.ToShortStringNode, TInteger.Create(Method.LineS));
        Node.ImageIndex := ImageNr;
        Node.SelectedIndex := ImageNr;
        Node.HasChildren := False;
      end;
    end;
    AddFunctions(MaxInt);
  finally
    TVFileStructure.Items.EndUpdate;
    FFileStructure.Init(TVFileStructure.Items, Self);
  end;
end;

procedure TEditorForm.CollectClasses(StringList: TStringList);
var Cite: IModelIterator; Cent: TModelEntity;
begin
  if IsPython then
  begin
    Cite := FModel.ModelRoot.GetAllClassifiers;
    while Cite.HasNext do
    begin
      Cent := Cite.Next;
      if (Cent is TClass) or (Cent is TInterface) then
        StringList.Add(WithoutArray(Cent.Name));
    end;
  end;
end;

procedure TEditorForm.DoUpdateCaption;
var TabCaption: string;
begin
  if FEditor.RemoteFileName <> '' then
    TabCaption := TPath.GetFileName(FEditor.RemoteFileName)
  else
    TabCaption := FEditor.GetFileTitle;

  SynEdit.AccessibleName := TabCaption;
  SynEdit2.AccessibleName := TabCaption;

  with ParentTabItem do
  begin
    Caption := StringReplace(TabCaption, '&', '&&', [rfReplaceAll]);
    Hint := FEditor.GetFileId;
  end;
  PyIDEMainForm.UpdateCaption;
end;

function TEditorForm.GetFrameType: Integer;
var PythonScanner: TPythonScannerWithTokens;
begin
  if (FFrameType = 0) and (DefaultExtension = 'pyw') then
  begin
    PythonScanner := TPythonScannerWithTokens.Create;
    PythonScanner.Init(SynEdit.LineS.Text);
    FFrameType := PythonScanner.GetFrameType;
    PythonScanner.Destroy;
  end;
  Result := FFrameType;
end;

function TEditorForm.GetActiveSynEdit: TSynEdit;
begin
  Result := FEditor.GetActiveSynEdit;
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
  if (HintInfo.CursorPos.Y div SynEd.LineHeight) > (SynEd.DisplayRowCount - SynEd.TopLine) then
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
  else if FEditor.HasPythonFile and not SynEd.IsPointInSelection(BC) and
    SynEd.GetHighlighterAttriAtRowColEx(BC, Token, TokenType, Start, Attri) and
    (((GI_PyControl.DebuggerState in [dsPaused, dsPostMortem]) and
       PyIDEOptions.ShowDebuggerHints) or
       (GI_PyControl.Inactive and PyIDEOptions.ShowCodeHints)) and
    ((Attri = Highlighter.IdentifierAttri) or
     (Attri = Highlighter.NonKeyAttri) or
     (Attri = Highlighter.SystemAttri) or
      // bracketed debugger expression
     ((Attri = Highlighter.SymbolAttri) and
      (GI_PyControl.DebuggerState in [dsPaused, dsPostMortem]) and
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
          function: string
          begin
            Result := TPyLspClient.CodeHintAtCoordinates(
              FEditor.GetFileId, BC1, Token);
          end, TThreadPool.Default).Start;
      end
      else
      begin
        // Debugger hints
        FHintFuture := TFuture<string>.Create(nil, nil,
          function: string
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

procedure TEditorForm.BreakpointContextPopup(Sender: TObject; MousePos: TPoint;
Row, Line: Integer; var Handled: Boolean);
var Breakpoint: TBreakpoint;
begin
  if FBreakPoints.FindBreakpoint(Line, Breakpoint) then
  begin
    pmnuBreakpoint.Tag := Integer(Breakpoint);
    spiBreakpointEnabled.Checked := not Breakpoint.Disabled;
    MousePos := ClientToScreen(MousePos);
    pmnuBreakpoint.Popup(MousePos.X, MousePos.Y);
    Handled := True;
  end;
end;

procedure TEditorForm.spiBreakpointClearClick(Sender: TObject);
begin
  GI_BreakpointManager.ToggleBreakpoint(FEditor.GetFileId,
    TBreakpoint(pmnuBreakpoint.Tag).LineNo);
end;

procedure TEditorForm.spiBreakpointEnabledClick(Sender: TObject);
begin
  with TBreakpoint(pmnuBreakpoint.Tag) do
    GI_BreakpointManager.SetBreakpoint(FEditor.GetFileId, LineNo,
      not spiBreakpointEnabled.Checked, Condition, IgnoreCount);
end;

procedure TEditorForm.spiBreakpointPropertiesClick(Sender: TObject);
var Condition: string; IgnoreCount: Integer;
begin
  var
  Breakpoint := TBreakpoint(pmnuBreakpoint.Tag);
  Condition := Breakpoint.Condition;
  IgnoreCount := Breakpoint.IgnoreCount;

  if GI_BreakpointManager.EditProperties(Condition, IgnoreCount) then
  begin
    GI_BreakpointManager.SetBreakpoint(FEditor.GetFileId, Breakpoint.LineNo,
      Breakpoint.Disabled, Condition, IgnoreCount);
  end;
end;

class function TEditorForm.ToolbarCount: Integer;
begin
  Result := 28;
end;

{$ENDREGION 'TEditorForm'}

initialization

GI_EditorFactory := TEditorFactory.Create;
GI_FileFactory := IFileFactory(GI_EditorFactory);
TCodeHintWindow.OnHyperLinkClick := TEditorForm.CodeHintLinkHandler;

finalization

GI_EditorFactory := nil; // calls TEditorFactory.Destroy

end.
