{-----------------------------------------------------------------------------
 Unit Name: cPyScripterSettings
 Author:    Pyscripter, Gerhard Röhner
 Date:      22-Jan-2018
 Purpose:   Centralize the management of PyScripter settings
 History:
-----------------------------------------------------------------------------}

unit cPyScripterSettings;

interface
uses
  Winapi.Windows,
  System.Classes,
  Vcl.ImgList,
  Vcl.Graphics,
  JclNotify,
  SpTBXTabs,
  SynEditTypes,
  SynEditCodeFolding,
  SynEditMiscClasses,
  SynEditKeyCmds,
  SynEdit,
  WrapDelphi,
  uEditAppIntfs,
  cPySupportTypes,
  dlgSynEditOptions;

const
  dsaSearchFromStart = 1;
  dsaReplaceFromStart = 2;
  dsaReplaceNumber = 3;
  dsaSearchStartReached = 4;
  dsaPostMortemInfo = 5;
  dsaDictonaryNA = 6;

type
  TFileChangeNotificationType = (fcnFull, fcnNoMappedDrives, fcnDisabled);

{$METHODINFO ON}
  TBaseOptionsClass = class of TBaseOptions;
  TBaseOptions = class(TInterfacedPersistent)
    public
    constructor Create; virtual; abstract;
  end;

  {
    Persistent IDE Settings
    Note: TPythonIDEOptions is exposed to Python.
    IFreeNotification is implemented to make sure the object is not used
    by Python after its destruction (see WrapDelphi for details)
  }
  TPythonIDEOptions = class(TBaseOptions, IFreeNotification)
  private
    fFreeNotifyImpl : IFreeNotification;
    fOnChange: TJclProcedureEventBroadcast;
    fTimeOut : Integer;
    fUndoAfterSave : Boolean;
    fSaveFilesBeforeRun : Boolean;
    fSaveFilesAutomatically: Boolean;
    fSaveEnvironmentBeforeRun : Boolean;
    fRestoreOpenFiles : Boolean;
    fRestoreOpenProject : Boolean;
    fCreateBackupFiles : Boolean;
    fExplorerInitiallyExpanded : Boolean;
    fProjectExplorerInitiallyExpanded : Boolean;
    fSearchTextAtCaret : Boolean;
    fPythonFileFilter : string;
    fCythonFileFilter : string;
    fHTMLFileFilter : string;
    fXMLFileFilter : string;
    fCSSFileFilter : string;
    fCPPFileFilter : string;
    fYAMLFileFilter : string;
    fJSFileFilter : string;
    fPHPFileFilter : string;
    fJSONFileFilter : string;
    fGeneralFileFilter : string;
    fPythonFormFileFilter : string;
    fUMLFileFilter : string;
    fStructogramFileFilter : string;
    fSequencediagramFileFilter : string;
    fAllFileFilter: string;
    fFileExplorerFilter : string;
    fDateLastCheckedForUpdates : TDateTime;
    fAutoCheckForUpdates : Boolean;
    fDaysBetweenChecks : Integer;
    fMaskFPUExceptions : Boolean;
    fSpecialPackages : string;
    fShowCodeHints : Boolean;
    fShowDebuggerHints : Boolean;
    fAutoCompleteBrackets : Boolean;
    fCommandLine : string;
    fUseCommandLine : Boolean;
    fMarkExecutableLines : Boolean;
    fCheckSyntaxAsYouType : Boolean;
    fFileExplorerContextMenu : Boolean;
    fNewFileLineBreaks : TSynEditFileFormat;
    fNewFileEncoding : TFileSaveFormat;
    fDetectUTF8Encoding: Boolean;
    fEditorsTabPosition : TSpTBXTabPosition;
    fPythonEngineType : TPythonEngineType;
    fPrettyPrintOutput : Boolean;
    fSmartNextPrevPage : Boolean;
    fAutoReloadChangedFiles : Boolean;
    fClearOutputBeforeRun : Boolean;
    fAutoHideFindToolbar : Boolean;
    fCodeCompletionListSize : Integer;
    fEditorCodeCompletion : Boolean;
    fInterpreterCodeCompletion : Boolean;
    fShowTabCloseButton : Boolean;
    fPostMortemOnException : Boolean;
    fDockAnimationInterval : Integer;
    fDockAnimationMoveWidth : Integer;
    fInterpreterHistorySize : Integer;
    fSaveInterpreterHistory : Boolean;
    fReinitializeBeforeRun: Boolean;
    fJumpToErrorOnException : Boolean;
    fFileTemplateForNewScripts : string;
    fAutoCompletionFont : TFont;
    fHighlightSelectedWord : Boolean;
    fHighlightSelectedWordColor : TColor;
    fFileChangeNotification : TFileChangeNotificationType;
    fCodeCompletionCaseSensitive : Boolean;
    fCompleteKeywords : Boolean;
    fCompleteAsYouType: Boolean;
    fCompleteWithWordBreakChars: Boolean;
    fCompleteWithOneEntry:Boolean;
    fDisplayPackageNames:Boolean;
    fNoOfRecentFiles : Integer;
    fCodeFoldingEnabled : Boolean;
    fCodeFoldingForGuiElements : Boolean;
    fCodeFolding : TSynCodeFolding;
    fInternalInterpreterHidden : Boolean;
    fCompactLineNumbers : Boolean;
    fStyleMainWindowBorder : Boolean;
    fFileExplorerBackgroundProcessing : Boolean;
    fSSHCommand : string;
    fSSHOptions: string;
    fScpCommand : string;
    fScpOptions: string;
    fSSHDisableVariablesWin: Boolean;
    fAlwaysUseSockets: Boolean;
    fTrimTrailingSpacesOnSave: Boolean;
    fTraceOnlyIntoOpenFiles: Boolean;
    fReinitializeWhenClosing: Boolean;
    fLspDebug: Boolean;
    fMethodsWithComment: Boolean;
    fDictLanguage: string;
    fSpellCheckedTokens: string;
    fSpellCheckAsYouType: Boolean;
    fAutoRestart: Boolean;
    fLoggingEnabled: Boolean;
    fScrollbarAnnotation: Boolean;
    FAccessibilitySupport: Boolean;
    fUIContentFontSize: Integer;
    fPreferFreeThreaded: Boolean;
    fTrackChanges: TSynTrackChanges;
    fSelectionColor: TSynSelectedColor;
    fIndentGuides: TSynIndentGuides;
    fDisplayFlowControl: TSynDisplayFlowControl;
    function GetPythonFileExtensions: string;
    procedure SetAutoCompletionFont(const Value: TFont);
    procedure SetCodeFolding(const Value: TSynCodeFolding);
    procedure SetTrackChanges(const Value: TSynTrackChanges);
    procedure SetSelectionColor(const Value: TSynSelectedColor);
    procedure SetIndentGuides(const Value: TSynIndentGuides);
    procedure SetDisplayFlowControl(const Value: TSynDisplayFlowControl);
  protected
    property FreeNotifyImpl : IFreeNotification read fFreeNotifyImpl implements IFreeNotification;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Changed;
    property PythonFileExtensions : string read GetPythonFileExtensions;
    property OnChange: TJclProcedureEventBroadcast read fOnChange;
  published
    property CodeFolding : TSynCodeFolding read fCodeFolding
      write SetCodeFolding;
    property TrackChanges: TSynTrackChanges read fTrackChanges
      write SetTrackChanges;
    property SelectionColor: TSynSelectedColor read fSelectionColor
      write SetSelectionColor;
    property IndentGuides: TSynIndentGuides read fIndentGuides
      write SetIndentGuides;
    property DisplayFlowControl: TSynDisplayFlowControl read fDisplayFlowControl
      write SetDisplayFlowControl;
    property TimeOut : Integer read fTimeOut write fTimeOut default 0;
    property UndoAfterSave : Boolean read fUndoAfterSave
      write fUndoAfterSave default True;
    property SaveFilesBeforeRun : Boolean read fSaveFilesBeforeRun
      write fSaveFilesBeforeRun default True;
    property SaveEnvironmentBeforeRun : Boolean read fSaveEnvironmentBeforeRun
      write fSaveEnvironmentBeforeRun default False;
    property SaveFilesAutomatically : Boolean read fSaveFilesAutomatically
      write fSaveFilesAutomatically default True;
    property RestoreOpenFiles : Boolean read fRestoreOpenFiles
      write fRestoreOpenFiles default True;
    property RestoreOpenProject : Boolean read fRestoreOpenProject
      write fRestoreOpenProject default True;
    property CreateBackupFiles : Boolean read fCreateBackupFiles
      write fCreateBackupFiles default False;
    property ExplorerInitiallyExpanded : Boolean read fExplorerInitiallyExpanded
      write fExplorerInitiallyExpanded default False;
    property ProjectExplorerInitiallyExpanded : Boolean read fProjectExplorerInitiallyExpanded
      write fProjectExplorerInitiallyExpanded default True;
    property SearchTextAtCaret : Boolean read fSearchTextAtCaret
      write fSearchTextAtCaret stored False;
    property PythonFileFilter : string read fPythonFileFilter
      write fPythonFileFilter;
    property CythonFileFilter : string read fCythonFileFilter
      write fCythonFileFilter;
    property HTMLFileFilter : string read fHTMLFileFilter
      write fHTMLFileFilter;
    property XMLFileFilter : string read fXMLFileFilter
      write fXMLFileFilter;
    property CSSFileFilter : string read fCSSFileFilter
      write fCSSFileFilter;
    property CPPFileFilter : string read fCPPFileFilter
      write fCPPFileFilter;
    property YAMLFileFilter : string read fYAMLFileFilter
      write fYAMLFileFilter;
    property JSFileFilter : string read fJSFileFilter
      write fJSFileFilter;
    property PHPFileFilter : string read fPHPFileFilter
      write fPHPFileFilter;
    property JSONFileFilter : string read fJSONFileFilter
      write fJSONFileFilter;
    property GeneralFileFilter : string read fGeneralFileFilter
      write fGeneralFileFilter;
    property PythonFormFileFilter : string read fPythonFormFileFilter
      write fPythonFormFileFilter;
    property UMLFileFilter : string read fUMLFileFilter
      write fUMLFileFilter;
    property StructogramFileFilter : string read fStructogramFileFilter
      write fStructogramFileFilter;
    property SequencediagramFileFilter : string read fSequencediagramFileFilter
      write fSequencediagramFileFilter;
    property AllFileFilter : string read fAllFileFilter
      write fAllFileFilter;
    property FileExplorerFilter : string read fFileExplorerFilter
      write fFileExplorerFilter;
    property DateLastCheckedForUpdates : TDateTime read fDateLastCheckedForUpdates
      write fDateLastCheckedForUpdates;
    property AutoCheckForUpdates : Boolean read fAutoCheckForUpdates
      write fAutoCheckForUpdates default True;
    property DaysBetweenChecks : Integer read fDaysBetweenChecks
      write fDaysBetweenChecks default 7;
    property MaskFPUExceptions : Boolean read fMaskFPUExceptions
      write fMaskFPUExceptions default True;
    property SpecialPackages : string read fSpecialPackages write fSpecialPackages;
    property ShowCodeHints : Boolean read fShowCodeHints
      write fShowCodeHints default True;
    property ShowDebuggerHints : Boolean read fShowDebuggerHints
      write fShowDebuggerHints default True;
    property AutoCompleteBrackets : Boolean read fAutoCompleteBrackets
      write fAutoCompleteBrackets default True;
    property CommandLine : string read fCommandLine write fCommandLine;
    property UseCommandLine : Boolean read fUseCommandLine
      write fUseCommandLine;
    property MarkExecutableLines : Boolean read fMarkExecutableLines
      write fMarkExecutableLines default False;
    property CheckSyntaxAsYouType : Boolean read fCheckSyntaxAsYouType
      write fCheckSyntaxAsYouType default False;
    property FileExplorerContextMenu : Boolean read fFileExplorerContextMenu
      write fFileExplorerContextMenu default True;
    property NewFileLineBreaks : TSynEditFileFormat read fNewFileLineBreaks
      write fNewFileLineBreaks default sffDos;
    property NewFileEncoding : TFileSaveFormat read fNewFileEncoding
      write fNewFileEncoding default sf_UTF8_NoBOM;
    property DetectUTF8Encoding : Boolean read fDetectUTF8Encoding
      write fDetectUTF8Encoding default True;
    property EditorsTabPosition : TSpTBXTabPosition read fEditorsTabPosition
      write fEditorsTabPosition default ttpBottom;
    property PythonEngineType : TPythonEngineType read fPythonEngineType
      write fPythonEngineType default peRemote;
    property PrettyPrintOutput : Boolean read fPrettyPrintOutput
      write fPrettyPrintOutput default True;
    property SmartNextPrevPage : Boolean read fSmartNextPrevPage
      write fSmartNextPrevPage default True;
    property AutoReloadChangedFiles : Boolean read fAutoReloadChangedFiles
      write fAutoReloadChangedFiles default True;
    property ClearOutputBeforeRun : Boolean read fClearOutputBeforeRun
      write fClearOutputBeforeRun default False;
    property AutoHideFindToolbar : Boolean read fAutoHideFindToolbar
      write fAutoHideFindToolbar default False;
    property EditorCodeCompletion : Boolean read fEditorCodeCompletion
      write fEditorCodeCompletion default True;
    property InterpreterCodeCompletion : Boolean read fInterpreterCodeCompletion
      write fInterpreterCodeCompletion default True;
    property CodeCompletionListSize : Integer read fCodeCompletionListSize
      write fCodeCompletionListSize default 10;
    property ShowTabCloseButton : Boolean read fShowTabCloseButton
      write fShowTabCloseButton default True;
    property PostMortemOnException : Boolean read fPostMortemOnException
      write fPostMortemOnException default False;
    property DockAnimationInterval : Integer read fDockAnimationInterval
      write fDockAnimationInterval;
    property DockAnimationMoveWidth : Integer read fDockAnimationMoveWidth
      write fDockAnimationMoveWidth;
    property InterpreterHistorySize : Integer read fInterpreterHistorySize
      write fInterpreterHistorySize;
    property SaveInterpreterHistory : Boolean read fSaveInterpreterHistory
      write fSaveInterpreterHistory default True;
    property ReinitializeBeforeRun : Boolean read fReinitializeBeforeRun
      write fReinitializeBeforeRun default True;
    property JumpToErrorOnException : Boolean read fJumpToErrorOnException
      write fJumpToErrorOnException default True;
    property FileTemplateForNewScripts: string read fFileTemplateForNewScripts
      write fFileTemplateForNewScripts;
    property AutoCompletionFont : TFont read fAutoCompletionFont
      write SetAutoCompletionFont;
    property HighlightSelectedWord : Boolean read fHighlightSelectedWord
      write fHighlightSelectedWord default True;
    property HighlightSelectedWordColor : TColor read fHighlightSelectedWordColor
      write fHighlightSelectedWordColor default clOlive;
    property FileChangeNotification : TFileChangeNotificationType read fFileChangeNotification
      write fFileChangeNotification default fcnDisabled;
    property CodeCompletionCaseSensitive : Boolean read fCodeCompletionCaseSensitive
      write fCodeCompletionCaseSensitive default True;
    property CompleteKeywords : Boolean read fCompleteKeywords
      write fCompleteKeywords default True;
    property CompleteAsYouType : Boolean read fCompleteAsYouType
      write fCompleteAsYouType default True;
    property CompleteWithWordBreakChars : Boolean read fCompleteWithWordBreakChars
      write fCompleteWithWordBreakChars default False;
    property CompleteWithOneEntry : Boolean read fCompleteWithOneEntry
      write fCompleteWithOneEntry default False;
    property DisplayPackageNames : Boolean read fDisplayPackageNames
      write fDisplayPackageNames default True;
    property NoOfRecentFiles : Integer read fNoOfRecentFiles
      write fNoOfRecentFiles default 12;
    property CodeFoldingEnabled : Boolean read fCodeFoldingEnabled
      write fCodeFoldingEnabled default True;
    property CodeFoldingForGuiElements : Boolean read fCodeFoldingForGuiElements
      write fCodeFoldingForGuiElements default True;
    property InternalInterpreterHidden : Boolean read fInternalInterpreterHidden
      write fInternalInterpreterHidden default True;
    property CompactLineNumbers : Boolean read fCompactLineNumbers
      write fCompactLineNumbers default True;
    property StyleMainWindowBorder : Boolean read fStyleMainWindowBorder
      write fStyleMainWindowBorder default False;
    property FileExplorerBackgroundProcessing : Boolean read fFileExplorerBackgroundProcessing
      write fFileExplorerBackgroundProcessing default False;
    property SSHCommand : string read fSSHCommand write fSSHCommand;
    property SSHOptions : string read fSSHOptions write fSSHOptions;
    property ScpCommand : string read fScpCommand write fScpCommand;
     property ScpOptions : string read fScpOptions write fScpOptions;
    property SSHDisableVariablesWin : Boolean read fSSHDisableVariablesWin
      write fSSHDisableVariablesWin default True;
    property AlwaysUseSockets : Boolean read fAlwaysUseSockets
      write fAlwaysUseSockets default False;
    property TrimTrailingSpacesOnSave : Boolean read fTrimTrailingSpacesOnSave
      write fTrimTrailingSpacesOnSave default True;
    property TraceOnlyIntoOpenFiles : Boolean read fTraceOnlyIntoOpenFiles
      write fTraceOnlyIntoOpenFiles default False;
    property ReinitializeWhenClosing : Boolean read fReinitializeWhenClosing
      write fReinitializeWhenClosing default True;
    property LspDebug: Boolean read fLspDebug write fLspDebug default False;
    property DictLanguage: string read fDictLanguage write fDictLanguage;
    property SpellCheckedTokens: string read fSpellCheckedTokens write fSpellCheckedTokens;
    property SpellCheckAsYouType: Boolean read fSpellCheckAsYouType
      write fSpellCheckAsYouType default False;
    property AutoRestart: Boolean read fAutoRestart write fAutoRestart default True;
    property LoggingEnabled: Boolean read fLoggingEnabled write fLoggingEnabled default False;
    property ScrollbarAnnotation: Boolean read fScrollbarAnnotation write fScrollbarAnnotation default True;
    property AccessibilitySupport: Boolean read FAccessibilitySupport write FAccessibilitySupport default True;
    property UIContentFontSize: Integer read fUIContentFontSize write fUIContentFontSize default 9;
    property PreferFreeThreaded: Boolean read fPreferFreeThreaded write fPreferFreeThreaded default False;

    property MethodsWithComment: Boolean read fMethodsWithComment
      write fMethodsWithComment default False;
  end;
{$METHODINFO OFF}

  TSearchCaseSensitiveType = (scsAuto, scsNotCaseSenitive, scsCaseSensitive);

  TEditorSearchOptions = class(TPersistent)
  private
    fSearchCaseSensitiveType: TSearchCaseSensitiveType;
    fSearchFromCaret: Boolean;
    fSearchSelectionOnly: Boolean;
    fSearchTextAtCaret: Boolean;
    fSearchWholeWords: Boolean;
    fUseRegExp: Boolean;
    fIncrementalSearch: Boolean;
    fSearchTextHistory: string;
    fReplaceTextHistory: string;
  public
    SearchText: string;
    ReplaceText: string;
    TempSearchFromCaret: Boolean;
    TempSelectionOnly: Boolean;
    NoReplaceCount: Integer;
    LastReplaceAction: TSynReplaceAction;
    CanWrapSearch: Boolean;
    WrappedSearch: Boolean;
    BackwardSearch: Boolean;
    InitCaretXY: TBufferCoord;
    InterpreterIsSearchTarget: Boolean;
    TextDiffIsSearchTarget: Boolean;
    SelStorage: TSynSelStorage;
    procedure Assign(Source: TPersistent); override;
    procedure InitSearch;
    procedure NewSearch(SynEdit : TCustomSynEdit; ABackwards : Boolean);
  published
    property SearchTextHistory: string read fSearchTextHistory write fSearchTextHistory;
    property ReplaceTextHistory: string read fReplaceTextHistory write fReplaceTextHistory;
    property SearchSelectionOnly: Boolean read fSearchSelectionOnly write fSearchSelectionOnly;
    property SearchCaseSensitiveType: TSearchCaseSensitiveType read fSearchCaseSensitiveType write fSearchCaseSensitiveType;
    property SearchFromCaret: Boolean read fSearchFromCaret write fSearchFromCaret;
    property SearchTextAtCaret: Boolean read fSearchTextAtCaret write fSearchTextAtCaret;
    property SearchWholeWords: Boolean read fSearchWholeWords write fSearchWholeWords;
    property UseRegExp: Boolean read fUseRegExp write fUseRegExp;
    property IncrementalSearch: Boolean read fIncrementalSearch write fIncrementalSearch;
  end;

  TPyScripterSettings = class
  private
    class procedure ApplyPyIDEOptions;
  public
    class var IsPortable: Boolean;
    class var UserDataPath: string;
    class var OptionsFileName: string;
    class var ColorThemesFilesDir: string;
    class var StylesFilesDir: string;
    class var UserDebugInspectorsDir: string;
    class var AppDebugInspectorsDir: string;
    class var LspServerPath: string;
    class var RecoveryDir: string;
    class var EngineInitFile: string;
    class var PyScripterInitFile: string;
    class var PyScripterLogFile: string;
    class var DefaultEditorKeyStrokes: TSynEditKeyStrokes;
    class procedure RegisterEditorUserCommands(Keystrokes: TSynEditKeyStrokes);
    class procedure CreateIDEOptions;
    class procedure CreateEditorOptions;
    class procedure CreateSearchOptions;
    class constructor CreateSettings;
    class destructor Destroy;
  end;

const
  // Additional Synedit commands
  ecRecallCommandPrev = ecUserFirst + 100;
  ecRecallCommandNext = ecUserFirst + 101;
  ecRecallCommandEsc = ecUserFirst + 102;
  ecCodeCompletion = ecUserFirst + 103;
  ecParamCompletion = ecUserFirst + 104;

var
  PyIDEOptions : TPythonIDEOptions;
  GEditorOptions : TSynEditorOptionsContainer;
  EditorSearchOptions : TEditorSearchOptions;

implementation

uses
  System.UITypes,
  System.SysUtils,
  System.IOUtils,
  System.Math,
  System.IniFiles,
  Vcl.Forms,
  Vcl.Dialogs,
  uHighlighterProcs,
  JvAppStorage,
  JvGnuGettext,
  SynUnicode,
  SynEditStrConst,
  SynHighlighterPython,
  SynHighlighterYAML,
  SynEditRegexSearch,
  StringResources,
  uCommonFunctions,
  uUtils;

{ TPythonIDEOptions }

procedure TPythonIDEOptions.Assign(Source: TPersistent);
begin
  if Source is TPythonIDEOptions then
    with TPythonIDEOptions(Source) do begin
      Self.fCodeFolding.Assign(CodeFolding);
      Self.fTrackChanges.Assign(TrackChanges);
      Self.fSelectionColor.Assign(SelectionColor);
      Self.fIndentGuides.Assign(IndentGuides);
      Self.fDisplayFlowControl.Assign(DisplayFlowControl);
      Self.fTimeOut := TimeOut;
      Self.fUndoAfterSave := UndoAfterSave;
      Self.fSaveFilesBeforeRun := SaveFilesBeforeRun;
      Self.fSaveEnvironmentBeforeRun := SaveEnvironmentBeforeRun;
      Self.fSaveFilesAutomatically:= fSaveFilesAutomatically;
      Self.fRestoreOpenFiles := fRestoreOpenFiles;
      Self.fRestoreOpenProject := fRestoreOpenProject;
      Self.fCreateBackUpFiles := CreateBackUpFiles;
      Self.fExplorerInitiallyExpanded := ExplorerInitiallyExpanded;
      Self.fProjectExplorerInitiallyExpanded := ProjectExplorerInitiallyExpanded;
      Self.fSearchTextAtCaret := SearchTextAtCaret;
      Self.fPythonFileFilter := PythonFileFilter;
      Self.fCythonFileFilter := CythonFileFilter;
      Self.fHTMLFileFilter := HTMLFileFilter;
      Self.fXMLFileFilter := XMLFileFilter;
      Self.fCSSFileFilter := CSSFileFilter;
      Self.fCPPFileFilter := CPPFileFilter;
      Self.fYAMLFileFilter := YAMLFileFilter;
      Self.fJSFileFilter := JSFileFilter;
      Self.fPHPFileFilter := PHPFileFilter;
      Self.fJSONFileFilter := JSONFileFilter;
      Self.fGeneralFileFilter := GeneralFileFilter;
      Self.fPythonFormFileFilter := PythonFormFileFilter;
      Self.fUMLFileFilter := UMLFileFilter;
      Self.fStructogramFileFilter:= StructogramFileFilter;
      Self.fSequencediagramFileFilter:= SequencediagramFileFilter;
      Self.fAllFileFilter:= AllFileFilter;
      Self.fFileExplorerFilter := FileExplorerFilter;
      Self.fDateLastCheckedForUpdates := DateLastCheckedForUpdates;
      Self.fAutoCheckForUpdates := AutoCheckForUpdates;
      Self.fDaysBetweenChecks := DaysBetweenChecks;
      Self.fMaskFPUExceptions := MaskFPUExceptions;
      Self.fSpecialPackages := SpecialPackages;
      Self.fShowCodeHints := ShowCodeHints;
      Self.fShowDebuggerHints := ShowDebuggerHints;
      Self.fAutoCompleteBrackets := AutoCompleteBrackets;
      Self.fUseCommandLine := UseCommandLine;
      Self.fCommandLine := CommandLine;
      Self.fMarkExecutableLines := MarkExecutableLines;
      Self.fCheckSyntaxAsYouType := CheckSyntaxAsYouType;
      Self.fFileExplorerContextMenu := FileExplorerContextMenu;
      Self.fNewFileLineBreaks := NewFileLineBreaks;
      Self.fNewFileEncoding := NewFileEncoding;
      Self.fDetectUTF8Encoding := DetectUTF8Encoding;
      Self.fEditorsTabPosition := EditorsTabPosition;
      Self.fPythonEngineType := PythonEngineType;
      Self.fPrettyPrintOutput := PrettyPrintOutput;
      Self.fSmartNextPrevPage := SmartNextPrevPage;
      Self.fAutoReloadChangedFiles := AutoReloadChangedFiles;
      Self.fClearOutputBeforeRun := ClearOutputBeforeRun;
      Self.fAutoHideFindToolbar := AutoHideFindToolbar;
      Self.fEditorCodeCompletion := EditorCodeCompletion;
      Self.fInterpreterCodeCompletion := InterpreterCodeCompletion;
      Self.fCodeCompletionListSize := CodeCompletionListSize;
      Self.fShowTabCloseButton := ShowTabCloseButton;
      Self.fPostMortemOnException := PostMortemOnException;
      Self.fDockAnimationInterval := DockAnimationInterval;
      Self.fDockAnimationMoveWidth := DockAnimationMoveWidth;
      Self.fInterpreterHistorySize := InterpreterHistorySize;
      Self.fSaveInterpreterHistory := SaveInterpreterHistory;
      Self.fReinitializeBeforeRun := ReinitializeBeforeRun;
      Self.fJumpToErrorOnException := JumpToErrorOnException;
      Self.fFileTemplateForNewScripts := FileTemplateForNewScripts;
      Self.fAutoCompletionFont.Assign(AutoCompletionFont);
      Self.fHighlightSelectedWord := HighlightSelectedWord;
      Self.fHighlightSelectedWordColor := HighlightSelectedWordColor;
      Self.fFileChangeNotification := FileChangeNotification;
      Self.fCodeCompletionCaseSensitive := CodeCompletionCaseSensitive;
      Self.fCompleteKeywords := CompleteKeywords;
      Self.fCompleteAsYouType := CompleteAsYouType;
      Self.fCompleteWithWordBreakChars := CompleteWithWordBreakChars;
      Self.fCompleteWithOneEntry := CompleteWithOneEntry;
      Self.fDisplayPackageNames := DisplayPackageNames;
      Self.fNoOfRecentFiles := NoOfRecentFiles;
      Self.fCodeFoldingEnabled := CodeFoldingEnabled;
      Self.fCodeFoldingForGuiElements:= CodeFoldingForGuiElements;
      Self.fInternalInterpreterHidden := InternalInterpreterHidden;
      Self.fCompactLineNumbers := CompactLineNumbers;
      Self.fStyleMainWindowBorder := StyleMainWindowBorder;
      Self.fFileExplorerBackgroundProcessing := FileExplorerBackgroundProcessing;
      Self.fSSHCommand := SSHCommand;
      Self.fSSHOptions := SSHOptions;
      Self.fScpCommand := ScpCommand;
      Self.fScpOptions := ScpOptions;
      Self.fSSHDisableVariablesWin := SSHDisableVariablesWin;
      Self.fAlwaysUseSockets := AlwaysUseSockets;
      Self.fTrimTrailingSpacesOnSave := TrimTrailingSpacesOnSave;
      Self.fTraceOnlyIntoOpenFiles := TraceOnlyIntoOpenFiles;
      Self.fReinitializeWhenClosing:= ReinitializeWhenClosing;
      Self.fLspDebug := LSpDebug;
      Self.fDictLanguage := DictLanguage;
      Self.fSpellCheckedTokens := SpellCheckedTokens;
      Self.fSpellCheckAsYouType := SpellCheckAsYouType;
      Self.fAutoRestart := AutoRestart;
      Self.fLoggingEnabled := LoggingEnabled;
      Self.fScrollbarAnnotation := ScrollbarAnnotation;
      Self.FAccessibilitySupport := AccessibilitySupport;
      Self.fUIContentFontSize := UIContentFontSize;
      Self.fPreferFreeThreaded := PreferFreeThreaded;
    end
  else
    inherited;
end;

procedure TPythonIDEOptions.Changed;
begin
  fOnChange.CallAllProcedures;
end;

constructor TPythonIDEOptions.Create;
begin
  fFreeNotifyImpl := TFreeNotificationImpl.Create(Self);
  fOnChange := TJclProcedureEventBroadcast.Create;

  fTimeOut := 0; // 5000;
  fUndoAfterSave := True;
  fSaveFilesBeforeRun := True;
  fSaveFilesAutomatically:= True;
  fSaveEnvironmentBeforeRun := False;
  fCreateBackupFiles := False;
  fExplorerInitiallyExpanded := False;
  fProjectExplorerInitiallyExpanded := True;
  fPythonFileFilter := _(sPythonFileFilter);
  fCythonFileFilter := _(sCythonFileFilter);
  fHTMLFileFilter := _(sHTMLFileFilter);
  fXMLFileFilter := _(sXMLFileFilter);
  fCSSFileFilter := _(sCSSFileFilter);
  fCPPFileFilter := _(sCPPFileFilter);
  fYAMLFileFilter := _(sYAMLFileFilter);
  fJSFileFilter := _(sJSFileFilter);
  fPHPFileFilter := _(sPHPFileFilter);
  fJSONFileFilter := _(sJSONFileFilter);
  fGeneralFileFilter := _(sGeneralFileFilter);
  fFileExplorerFilter := '*.py;*.pyw';
  fSearchTextAtCaret := True;
  fPythonFormFileFilter := _(sPythonFormFileFilter);
  fUMLFileFilter := _(sUMLFileFilter);
  fStructogramFileFilter := _(sStructogramFileFilter);
  fSequencediagramFileFilter := _(sSequencediagramFileFilter);
  fAllfileFilter := _(sAllFileFilter);
  fDateLastCheckedForUpdates := MinDateTime;
  fRestoreOpenFiles := True;
  fRestoreOpenProject := True;
  fAutoCheckForUpdates := True;
  fDaysBetweenChecks := 7;
  fMaskFPUExceptions := True;
  fSpecialPackages := 'os, numpy, pandas';
  fShowCodeHints := True;
  fShowDebuggerHints := True;
  fAutoCompleteBrackets := True;
  fMarkExecutableLines := False;
  fCheckSyntaxAsYouType := False;
  fFileExplorerContextMenu := True;
  fNewFileLineBreaks := sffDos;
  fNewFileEncoding := sf_UTF8_NoBOM;
  fDetectUTF8Encoding := True;
  fEditorsTabPosition := ttpBottom;
  fPythonEngineType := peRemote;
  fPrettyPrintOutput := True;
  fSmartNextPrevPage := True;
  fAutoReloadChangedFiles := True;
  fClearOutputBeforeRun := False;
  fAutoHideFindToolbar := False;
  fEditorCodeCompletion := True;
  fInterpreterCodeCompletion := True;
  fCodeCompletionListSize := 10;
  fShowTabCloseButton := True;
  fPostMortemOnException := False;
  fDockAnimationInterval := 20;
  fDockAnimationMoveWidth := 40;
  fInterpreterHistorySize := 50;
  fSaveInterpreterHistory := True;
  fReinitializeBeforeRun := True;
  fJumpToErrorOnException := True;
  fFileTemplateForNewScripts := _(SPythonTemplateName);
  fAutoCompletionFont := TFont.Create;
  SetDefaultUIFont(fAutoCompletionFont);
  fHighlightSelectedWord := True;
  fHighlightSelectedWordColor := TColors.Dodgerblue;
  fFileChangeNotification := fcnDisabled;
  fCodeCompletionCaseSensitive := True;
  fCompleteKeywords := True;
  fCompleteAsYouType := True;
  fCompleteWithWordBreakChars := False;
  fCompleteWithOneEntry := False;
  fDisplayPackageNames := True;
  fNoOfRecentFiles := 12;
  fCodeFoldingEnabled := True;
  fCodeFoldingForGuiElements := True;
  fInternalInterpreterHidden := True;
  fCompactLineNumbers := True;
  fStyleMainWindowBorder := False;
  fFileExplorerBackgroundProcessing := False;
  fSSHCommand := 'ssh';
  fSSHOptions := '-o PasswordAuthentication=no -o StrictHostKeyChecking=no';
  fScpCommand := 'scp';
  fScpOptions := '-T -o PasswordAuthentication=no -o StrictHostKeyChecking=no';
  fSSHDisableVariablesWin := True;
  fAlwaysUseSockets := True;
  fTrimTrailingSpacesOnSave := True;
  fTraceOnlyIntoOpenFiles := False;
  fReinitializeWhenClosing:= True;
  fLspDebug := False;
  fDictLanguage := UserLocaleName;
  fSpellCheckedTokens := 'Comment, Text, String, Multi-Line String, Documentation';
  fSpellCheckAsYouType := False;
  fAutoRestart := True;
  fLoggingEnabled := False;
  fScrollbarAnnotation := True;
  FAccessibilitySupport := True;
  fUIContentFontSize := 9;
  fCodeFolding := TSynCodeFolding.Create;
  fCodeFolding.GutterShapeSize := 9;  // default value
  fTrackChanges := TSynTrackChanges.Create(nil);
  fTrackChanges.Visible := True;
  fTrackChanges.Width := 3;
  fSelectionColor := TSynSelectedColor.Create;
  FSelectionColor.FillWholeLines := False;
  FSelectionColor.Background := TColors.Dodgerblue;
  fIndentGuides := TSynIndentGuides.Create;
  fIndentGuides.Style := igsDotted;
  fDisplayFlowControl := TSynDisplayFlowControl.Create;
end;

destructor TPythonIDEOptions.Destroy;
begin
  FreeAndNil(fAutoCompletionFont);
  FreeAndNil(fCodeFolding);
  FreeAndNil(fTrackChanges);
  FreeAndNil(fSelectionColor);
  FreeAndNil(fIndentGuides);
  FreeAndNil(fDisplayFlowControl);
  FreeAndNil(fOnChange);
  inherited;
end;

function TPythonIDEOptions.GetPythonFileExtensions: string;
begin
  Result := FileMaskFromFileFilter(PythonFileFilter);
end;

procedure TPythonIDEOptions.SetAutoCompletionFont(const Value: TFont);
begin
  fAutoCompletionFont.Assign(Value);
end;


procedure TPythonIDEOptions.SetCodeFolding(const Value: TSynCodeFolding);
begin
  fCodeFolding.Assign(Value);
end;

procedure TPythonIDEOptions.SetDisplayFlowControl(
  const Value: TSynDisplayFlowControl);
begin
  fDisplayFlowControl.Assign(Value);
end;

procedure TPythonIDEOptions.SetIndentGuides(const Value: TSynIndentGuides);
begin
  fIndentGuides.Assign(Value);
end;

procedure TPythonIDEOptions.SetSelectionColor(const Value: TSynSelectedColor);
begin
  fSelectionColor.Assign(Value);
end;

procedure TPythonIDEOptions.SetTrackChanges(const Value: TSynTrackChanges);
begin
  fTrackChanges.Assign(Value);
end;

{ TEditorSearchOptions }

procedure TEditorSearchOptions.Assign(Source: TPersistent);
begin
  if Source is TEditorSearchOptions then
    with TEditorSearchOptions(Source) do begin
      Self.SearchCaseSensitiveType := SearchCaseSensitiveType;
      Self.SearchFromCaret := SearchFromCaret;
      Self.TempSearchFromCaret := TempSearchFromCaret;
      Self.SearchSelectionOnly := SearchSelectionOnly;
      Self.SearchTextAtCaret := SearchTextAtCaret;
      Self.SearchWholeWords := SearchWholeWords;
      Self.UseRegExp := UseRegExp;
      Self.IncrementalSearch := IncrementalSearch;

      Self.SearchText := SearchText;
      Self.SearchTextHistory := SearchTextHistory;
      Self.ReplaceText := ReplaceText;
      Self.ReplaceTextHistory := ReplaceTextHistory;
    end
  else
    inherited;
end;

procedure TEditorSearchOptions.InitSearch;
begin
  TempSearchFromCaret := SearchFromCaret;
  LastReplaceAction := raReplace;
  InitCaretXY := TBufferCoord.Invalid;
  SelStorage.Selections := [];
end;

procedure TEditorSearchOptions.NewSearch(SynEdit: TCustomSynEdit; ABackwards:
    Boolean);

  function FindTextInBlock(Strings : TStrings; BB, BE : TBufferCoord) : Boolean;
  var
    StartChar, StopChar:  Integer;
    S: string;
  begin
    Result := False;
    // preconditions start
    Assert(BB.Line <= Strings.Count);
    Assert(BE.Line <= Strings.Count);
    Assert(BB.Line <= BE.Line);
    if BB.Line <= 0 then Exit;
    if BE.Line <= 0 then Exit;
    // preconditions end

    for var Line := BB.Line to BE.Line do
    begin
      S := Strings[Line - 1];
      StartChar := IfThen(Line = BB.Line, BB.Char, 1);
      StopChar := IfThen(Line = BE.Line, BE.Char, S.Length + 1);
      Result := SynEdit.SearchEngine.FindAll(S, StartChar, StopChar) > 0;
      if Result then Break;
    end;
  end;

var
  SearchOptions: TSynSearchOptions;
  BB: TBufferCoord;
  BE: TBufferCoord;
begin
  InitSearch;
  BackwardSearch := ABackwards;
  WrappedSearch := False;
  InitCaretXY := SynEdit.CaretXY;
  TempSelectionOnly := SearchSelectionOnly and not SynEdit.Selections.IsEmpty;
  if TempSelectionOnly then
    SynEdit.Selections.Store(SelStorage)
  else
  begin
    BB := BufferCoord(1, 1);
    BE  := BufferCoord(Length(SynEdit.Lines[SynEdit.Lines.Count - 1]) + 1,
      SynEdit.Lines.Count);
  end;

  CanWrapSearch := SearchFromCaret and not TempSelectionOnly and
    (ABackwards and (BE > InitCaretXY) or
    (not ABackwards and (InitCaretXY > BB)));
  if CanWrapSearch then begin
    SearchOptions := [];

    case SearchCaseSensitiveType of
      scsAuto:
        if LowerCase(SearchText) <> SearchText then
          Include(SearchOptions, ssoMatchCase);
      scsCaseSensitive :
        Include(SearchOptions, ssoMatchCase);
    end;
    if SearchWholeWords then
      Include(SearchOptions, ssoWholeWord);

    SynEdit.SearchEngine.Options := SearchOptions;
    try
      SynEdit.SearchEngine.Pattern := ''; //  To deal with case sensitivity
      SynEdit.SearchEngine.Pattern := SearchText;
      SynEdit.SearchEngine.IsWordBreakFunction := SynEdit.IsWordBreakChar;
      if ABackwards then
        CanWrapSearch := FindTextInBlock(SynEdit.Lines, InitCaretXY, BE)
      else
        CanWrapSearch := FindTextInBlock(SynEdit.Lines, BB, InitCaretXY);
    except
      on E: ESynRegEx do begin
        CanWrapSearch := False;
      end;
    end;
  end;
end;

{$REGION 'AppStorage handlers' }

type
// Modify JvAppStorage handling of Fonts
// We want to store Font.Size and not Font.Height
TJvAppStorageFontPropertyEngine = class(TJvAppStoragePropertyBaseEngine)
  private
    class var FFontIgnoreProperties: TStringList;
public
  function Supports(AObject: TObject; AProperty: TObject): Boolean; override;
  procedure ReadProperty(AStorage: TJvCustomAppStorage; const APath: string; AObject: TObject; AProperty: TObject; const Recursive,
    ClearFirst: Boolean; const IgnoreProperties: TStrings = nil); override;
  procedure WriteProperty(AStorage: TJvCustomAppStorage; const APath: string; AObject: TObject; AProperty: TObject; const
    Recursive: Boolean; const IgnoreProperties: TStrings = nil); override;
  class property FontIgnoreProperties : TStringList read FFontIgnoreProperties;
strict private
  class constructor Create;
  class destructor Destroy;
end;

{ TJvAppStorageFontPropertyEngine }

function TJvAppStorageFontPropertyEngine.Supports(AObject,
  AProperty: TObject): Boolean;
begin
  Result := AProperty is TFont;
end;

class constructor TJvAppStorageFontPropertyEngine.Create;
begin
  TJvAppStorageFontPropertyEngine.FFontIgnoreProperties := TStringList.Create;
  TJvAppStorageFontPropertyEngine.FFontIgnoreProperties.AddStrings(
    ['Height', 'Charset', 'Orientation', 'Pitch', 'Quality']);
end;

class destructor TJvAppStorageFontPropertyEngine.Destroy;
begin
  TJvAppStorageFontPropertyEngine.FFontIgnoreProperties.Free;
end;

procedure TJvAppStorageFontPropertyEngine.ReadProperty(
  AStorage: TJvCustomAppStorage; const APath: string; AObject,
  AProperty: TObject; const Recursive, ClearFirst: Boolean;
  const IgnoreProperties: TStrings);
begin
  TFont(AProperty).Style := []; // initialize
  // Font Size is a published property and is read
  AStorage.ReadPersistent(APath, AProperty as TFont, Recursive, ClearFirst,
    TJvAppStorageFontPropertyEngine.FFontIgnoreProperties);
  if Screen.Fonts.IndexOf(TFont(AProperty).Name) < 0 then
    TFont(AProperty).Name := DefaultCodeFontName;
end;

procedure TJvAppStorageFontPropertyEngine.WriteProperty(
  AStorage: TJvCustomAppStorage; const APath: string; AObject,
  AProperty: TObject; const Recursive: Boolean;
  const IgnoreProperties: TStrings);
var
  Index : Integer;
begin
  // Do not save style if empty
  Index := - 1;
  if TFont(AProperty).Style = [] then
    Index := TJvAppStorageFontPropertyEngine.FFontIgnoreProperties.Add('Style');
  AStorage.WritePersistent(APath, AProperty as TFont, Recursive,
    TJvAppStorageFontPropertyEngine.FFontIgnoreProperties);
  AStorage.WriteInteger(APath + '\Size', (AProperty as TFont).Size);
  if Index >= 0 then
    TJvAppStorageFontPropertyEngine.FFontIgnoreProperties.Delete(Index);
end;

type
// Modify JvAppStorage handling of TSynGutter
// We want to PPI scale size properties
TJvAppStorageGutterPropertyEngine = class(TJvAppStoragePropertyBaseEngine)
  private
    class var FGutterIgnoreProperties: TStringList;
public
  function Supports(AObject: TObject; AProperty: TObject): Boolean; override;
  procedure ReadProperty(AStorage: TJvCustomAppStorage; const APath: string; AObject: TObject; AProperty: TObject; const Recursive,
    ClearFirst: Boolean; const IgnoreProperties: TStrings = nil); override;
  procedure WriteProperty(AStorage: TJvCustomAppStorage; const APath: string; AObject: TObject; AProperty: TObject; const
    Recursive: Boolean; const IgnoreProperties: TStrings = nil); override;
strict private
  class constructor Create;
  class destructor Destroy;
end;

{ TJvAppStorageGutterPropertyEngine }

function TJvAppStorageGutterPropertyEngine.Supports(AObject,
  AProperty: TObject): Boolean;
begin
  Result := AProperty is TSynGutter;
end;

class constructor TJvAppStorageGutterPropertyEngine.Create;
begin
  FGutterIgnoreProperties := TStringList.Create;
  FGutterIgnoreProperties.AddStrings(['Bands', 'TrackChanges']);
end;

class destructor TJvAppStorageGutterPropertyEngine.Destroy;
begin
  FGutterIgnoreProperties.Free;
end;

procedure TJvAppStorageGutterPropertyEngine.ReadProperty(
  AStorage: TJvCustomAppStorage; const APath: string; AObject,
  AProperty: TObject; const Recursive, ClearFirst: Boolean;
  const IgnoreProperties: TStrings);
var
  FontSize : Integer;
begin
  AStorage.ReadPersistent(APath, AProperty as TSynGutter, Recursive, ClearFirst,
    FGutterIgnoreProperties);
  FontSize := TSynGutter(AProperty).Font.Size;
  TSynGutter(AProperty).ChangeScale(Screen.PixelsPerInch, 96);
  TSynGutter(AProperty).Font.Size := FontSize;
end;

procedure TJvAppStorageGutterPropertyEngine.WriteProperty(
  AStorage: TJvCustomAppStorage; const APath: string; AObject,
  AProperty: TObject; const Recursive: Boolean;
  const IgnoreProperties: TStrings);
var
  FontSize : Integer;
begin
  FontSize := TSynGutter(AProperty).Font.Size;
  TSynGutter(AProperty).ChangeScale(96, Screen.PixelsPerInch);
  TSynGutter(AProperty).Font.Size := FontSize;
  AStorage.WritePersistent(APath, AProperty as TSynGutter, Recursive,
    FGutterIgnoreProperties);
  TSynGutter(AProperty).ChangeScale(Screen.PixelsPerInch, 96);
  TSynGutter(AProperty).Font.Size := FontSize;
end;

type
TJvAppStorageKeyStrokesPropertyEngine = class(TJvAppStoragePropertyBaseEngine)
public
  function Supports(AObject: TObject; AProperty: TObject): Boolean; override;
  procedure ReadProperty(AStorage: TJvCustomAppStorage; const APath: string; AObject: TObject; AProperty: TObject; const Recursive,
    ClearFirst: Boolean; const IgnoreProperties: TStrings = nil); override;
  procedure WriteProperty(AStorage: TJvCustomAppStorage; const APath: string; AObject: TObject; AProperty: TObject; const
    Recursive: Boolean; const IgnoreProperties: TStrings = nil); override;
end;

{ TJvAppStorageKeyStrokesPropertyEngine }

function TJvAppStorageKeyStrokesPropertyEngine.Supports(AObject,
  AProperty: TObject): Boolean;
begin
  Result := AProperty is TSynEditKeyStrokes;
end;

procedure TJvAppStorageKeyStrokesPropertyEngine.WriteProperty(
  AStorage: TJvCustomAppStorage; const APath: string; AObject,
  AProperty: TObject; const Recursive: Boolean;
  const IgnoreProperties: TStrings);
var
  KeyStrokes: TSynEditKeyStrokes;

  procedure WriteAddedKeystrokes;
  var
    iDefaultKeys: TSynEditKeyStrokes;
    iAddedKeys: TSynEditKeyStrokes;
    cKey: Integer;
    iKey: TSynEditKeyStroke;
    iAddIndex: Integer;
  begin
    iDefaultKeys := TPyScripterSettings.DefaultEditorKeyStrokes;
    iAddedKeys := TSynEditKeyStrokes.Create(nil);
    try
      for cKey := 0 to Keystrokes.Count -1 do
      begin
        iKey := Keystrokes[cKey];
        iAddIndex := iDefaultKeys.FindShortcut2(iKey.ShortCut, iKey.ShortCut2);
        //if it's not a default keystroke, add it
        if (iAddIndex < 0) or (iDefaultKeys[iAddIndex].Command <> iKey.Command) then
          iAddedKeys.Add.Assign(iKey);
      end;
      AStorage.WriteCollection(APath, iAddedKeys);
    finally
      iAddedKeys.Free;
    end;
  end;

  procedure WriteRemovedKeystrokes;
  var
    iRemovedKeys: TSynEditKeyStrokes;
    cKey: Integer;
    iKey: TSynEditKeyStroke;
    iFoundAt: Integer;
  begin
    iRemovedKeys := TSynEditKeyStrokes.Create(nil);
    try
    iRemovedKeys.Assign(TPyScripterSettings.DefaultEditorKeyStrokes);
      cKey := 0;
      while cKey < iRemovedKeys.Count do
      begin
        iKey := iRemovedKeys[cKey];
        iFoundAt := Keystrokes.FindShortcut2(iKey.ShortCut, iKey.ShortCut2);
        if (iFoundAt >= 0) and (Keystrokes[iFoundAt].Command = iKey.Command) then
          iKey.Free //if exists in Keystrokes, then shouldn't be in "removed" list
        else
          Inc(cKey);
      end;
      AStorage.WriteCollection(APath + '\Removed', iRemovedKeys);
    finally
      iRemovedKeys.Free;
    end;
  end;

begin
  KeyStrokes := AProperty as TSynEditKeyStrokes;
  WriteAddedKeystrokes;
  WriteRemovedKeystrokes;
end;

procedure TJvAppStorageKeyStrokesPropertyEngine.ReadProperty(
  AStorage: TJvCustomAppStorage; const APath: string; AObject,
  AProperty: TObject; const Recursive, ClearFirst: Boolean;
  const IgnoreProperties: TStrings);
var
  KeyStrokes: TSynEditKeyStrokes;

  procedure ReadAddedKeystrokes;
  var
    iDefaultKeys: TSynEditKeyStrokes;
    iKey: TSynEditKeyStroke;
    cKey: Integer;
    iAddIndex: Integer;
  begin
    AStorage.ReadCollection(APath, KeyStrokes, True);
    iDefaultKeys := TPyScripterSettings.DefaultEditorKeyStrokes;
    for cKey := 0 to iDefaultKeys.Count -1 do
    begin
      iKey := iDefaultKeys[cKey];
      iAddIndex := KeyStrokes.FindShortcut2(iKey.ShortCut, iKey.ShortCut2);
      //if it's not a default keystroke, add it
      if (iAddIndex < 0) or (KeyStrokes[iAddIndex].Command <> iKey.Command) then
        KeyStrokes.Add.Assign(iKey);
    end;
  end;

  procedure ReadRemovedKeystrokes;
  var
    iDelKeys: TSynEditKeyStrokes;
    cKey: Integer;
    iKey: TSynEditKeyStroke;
    iToDelete: Integer;
  begin
    iDelKeys := TSynEditKeyStrokes.Create(nil);
    try
      AStorage.ReadCollection(APath + '\Removed', iDelKeys);
      for cKey := 0 to iDelKeys.Count -1 do
      begin
        iKey := iDelKeys[cKey];
        iToDelete := Keystrokes.FindShortcut2(iKey.ShortCut, iKey.ShortCut2);
        if (iToDelete >= 0) and (Keystrokes[iToDelete].Command = iKey.Command) then
          Keystrokes[iToDelete].Free;
      end;
    finally
      iDelKeys.Free;
    end;
  end;

begin
  if AStorage.PathExists(APath) then
  begin
    KeyStrokes := AProperty as TSynEditKeyStrokes;
    ReadAddedKeystrokes;
    ReadRemovedKeystrokes;
  end;
end;

{$ENDREGION 'AppStorage handlers' }


{ TPyScripterSettings }

class procedure TPyScripterSettings.CreateIDEOptions;
begin
  PyIDEOptions := TPythonIDEOptions.Create;
  // Register AppStorage handlers
  RegisterAppStoragePropertyEngine(TJvAppStorageFontPropertyEngine);
  RegisterAppStoragePropertyEngine(TJvAppStorageGutterPropertyEngine);
  RegisterAppStoragePropertyEngine(TJvAppStorageKeyStrokesPropertyEngine);
end;

class procedure TPyScripterSettings.CreateSearchOptions;
begin
  EditorSearchOptions := TEditorSearchOptions.Create;
  EditorSearchOptions.fSearchTextAtCaret := True;
  EditorSearchOptions.fSearchFromCaret := True;
  EditorSearchOptions.fIncrementalSearch := True;
  EditorSearchOptions.InitSearch;
end;

class constructor TPyScripterSettings.CreateSettings;

  procedure CopyFileIfNeeded(const Source, Dest: string);
  begin
    if not FileExists(Dest) and FileExists(Source) then
    try
       TFile.Copy(Source, Dest);
    except
      on E:Exception do
        raise Exception.CreateFmt(_('Error in copying file "%s" to "%s"'
          + SLineBreak + 'Error Message: '), [Source, Dest, E.Message]);
    end;
  end;

  procedure HandlePortable;
    var IniFilename, HomeDir: string; IniFile: TMemIniFile;
  begin
    // you can call GuiPy with an ini file as parameter
    IniFilename:= ParamStr(1);
    if (IniFilename = '') or (UpperCase(ExtractFileExt(IniFilename)) <> '.ini')
      then IniFilename:= TPath.Combine(ExtractFilePath(Application.ExeName), 'GuiPyMachine.ini')
      else IniFilename:= ExpandFileName(IniFilename);
    if FileExists(IniFilename) then begin
      IniFile:= TMemIniFile.Create(IniFilename);
      IsPortable:= IniFile.ReadBool('GuiPy', 'PortableApplication', False);
      HomeDir:= IniFile.ReadString('User', 'HomeDir', '');
      if IsPortable then
        HomeDir:= AddPortableDrive(HomeDir);
      HomeDir:= DissolveUsername(HomeDir);
      if DirectoryExists(HomeDir) then
        UserDataPath:= HomeDir;
      FreeAndNil(IniFile);
    end else
      IsPortable:= False;
  end;

var
  PublicPath: string;
  AppName, AppININame, EXEPath: string;
begin
  AppName := TPath.GetFileNameWithoutExtension(Application.ExeName);
  AppININame := AppName + '.ini';
  EXEPath := TPath.GetDirectoryName(Application.ExeName);

  OptionsFileName := TPath.Combine(EXEPath, AppININame);
  UserDataPath:= '';
  HandlePortable;
  if IsPortable then begin
    // Portable version - nothing is stored in other directories
    if UserDataPath = '' then
      UserDataPath := EXEPath;
    ColorThemesFilesDir := TPath.Combine(UserDataPath, 'Highlighters');
    StylesFilesDir := TPath.Combine(UserDataPath, 'Styles');
    LspServerPath := TPath.Combine(UserDataPath, 'Lsp');
    UserDebugInspectorsDir := TPath.Combine(UserDataPath, 'Variable Inspectors');
  end else begin
    UserDataPath := TPath.Combine(GetHomePath, AppName);
    OptionsFileName := TPath.Combine(UserDataPath, AppININame);
    if not ForceDirectories(UserDataPath) then
      StyledMessageDlg(Format(SAccessAppDataDir, [UserDataPath]), mtWarning, [mbOK], 0);
    PublicPath := TPath.Combine(TPath.GetPublicPath, AppName);
    ColorThemesFilesDir := TPath.Combine(PublicPath, 'Highlighters');
    StylesFilesDir := TPath.Combine(PublicPath, 'Styles');
    LspServerPath :=  TPath.Combine(PublicPath, 'Lsp');
    UserDebugInspectorsDir :=  TPath.Combine(UserDataPath, 'Variable Inspectors');
    AppDebugInspectorsDir := TPath.Combine(PublicPath, 'Variable Inspectors');
    // First use setup
    CopyFileIfNeeded(TPath.Combine(PublicPath, AppININame), OptionsFileName);
  end;
  ForceDirectories(UserDebugInspectorsDir);

  EngineInitFile := TPath.Combine(UserDataPath, 'python_init.py');
  PyScripterInitFile := TPath.Combine(UserDataPath, 'guipy_init.py');
  PyScripterLogFile := TPath.Combine(UserDataPath, 'guipy.log');
  RecoveryDir := TPath.Combine(UserDataPath, 'Recovery');
  if not IsPortable then begin
    // First use setup
    CopyFileIfNeeded(TPath.Combine(PublicPath, 'python_init.py'), EngineInitFile);
    CopyFileIfNeeded(TPath.Combine(PublicPath, 'guipy_init.py'), PyScripterInitFile);
  end;

  CreateIDEOptions;
  CreateEditorOptions;
  CreateSearchOptions;
  ApplyPyIDEOptions;
  PyIDEOptions.OnChange.AddHandler(ApplyPyIDEOptions);
  // Save Default editor keystrokes
  TPyScripterSettings.DefaultEditorKeyStrokes := TSynEditKeyStrokes.Create(nil);
  TPyScripterSettings.DefaultEditorKeyStrokes.Assign(GEditorOptions.Keystrokes);
end;

class procedure TPyScripterSettings.ApplyPyIDEOptions;
begin
  GEditorOptions.Gutter.TrackChanges.Assign(PyIDEOptions.TrackChanges);
  GEditorOptions.SelectedColor.Assign(PyIDEOptions.SelectionColor);
  GEditorOptions.IndentGuides.Assign(PyIDEOptions.IndentGuides);
  GEditorOptions.DisplayFlowControl.Assign(PyIDEOptions.DisplayFlowControl);
  if PyIDEOptions.AccessibilitySupport then
    GEditorOptions.Options := GEditorOptions.Options + [eoAccessibility]
  else
    GEditorOptions.Options := GEditorOptions.Options - [eoAccessibility];
  EditorSearchOptions.SearchTextAtCaret := PyIDEOptions.SearchTextAtCaret;
end;

class procedure TPyScripterSettings.CreateEditorOptions;
begin
  GEditorOptions := TSynEditorOptionsContainer.Create(nil);
  with GEditorOptions do begin
    Font.Name := DefaultCodeFontName;
    Font.Size := 10;
    Gutter.Font.Name := Font.Name;
    Gutter.Font.Color := clGrayText;
    Gutter.Gradient := False;
    Gutter.DigitCount := 2;
    Gutter.ShowLineNumbers := True;
    Gutter.Autosize := True;
    Gutter.ChangeScale(Screen.PixelsPerInch, 96);
    Gutter.Font.Size := 9;
    Gutter.BorderStyle := gbsNone;

    Options := [eoDragDropEditing, eoEnhanceHomeKey, eoShowLigatures,
                eoEnhanceEndKey, eoGroupUndo, eoKeepCaretX,
                eoSmartTabDelete, eoTabsToSpaces, eoTabIndent,
                eoTrimTrailingSpaces, eoAutoIndent, eoBracketsHighlight,
                eoAccessibility, eoCompleteBrackets, eoCompleteQuotes];
    ScrollOptions := [eoHideShowScrollbars, eoShowScrollHint];
    WantTabs := True;
    TabWidth := 4;
    MaxUndo := 0;

    RegisterEditorUserCommands(GEditorOptions.Keystrokes);
  end;
end;

class destructor TPyScripterSettings.Destroy;
begin
  PyIDEOptions.OnChange.RemoveHandler(ApplyPyIDEOptions);
  EditorSearchOptions.Free;
  PyIDEOptions.Free;
  GEditorOptions.Free;
  TPyScripterSettings.DefaultEditorKeyStrokes.Free;
end;

class procedure TPyScripterSettings.RegisterEditorUserCommands(
  Keystrokes: TSynEditKeyStrokes);
// Register User Commands and shortcuts
begin
  with Keystrokes do begin
    AddKey(ecCodeCompletion, VK_SPACE, [ssCtrl]);
    AddKey(ecParamCompletion, VK_SPACE, [ssCtrl, ssShift]);
    // #869
    Delete(FindCommand(ecDeleteLine));
    AddKey(ecDeleteLine, Ord('D'), [ssCtrl, ssShift]);
  end;
end;

end.
