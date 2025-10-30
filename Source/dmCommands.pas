{ -----------------------------------------------------------------------------
  Unit Name: dmCommands
  Author:    Kiriakos Vlahos
  Gerhard Röhner
  Date:      09-Mar-2005
  Purpose:   Data Module of PyScripter
  History:
  ----------------------------------------------------------------------------- }

unit dmCommands;

interface

uses
  System.Types,
  System.Classes,
  System.Actions,
//  System.ImageList,
  System.Messaging,
  Vcl.Graphics,
  Vcl.ActnList,
  Vcl.StdActns,
  Vcl.Menus,
  Vcl.ExtActns,
  Vcl.ImgList,
  Vcl.BaseImageCollection,
  SynEdit,
  SynEditPrint,
  SynEditRegexSearch,
  SynEditHighlighter,
  SynEditMiscClasses,
  SynCompletionProposal,
  SynEditSearch,
  SynHighlighterGeneral,
  JvComponentBase,
  JvProgramVersionCheck,
  JvStringHolder,
  JvPropertyStore,
  TB2Item,
  SpTBXSkins,
  SpTBXItem,
  SpTBXEditors,
  VirtualExplorerTree,
  VirtualShellNotifier,
  uEditAppIntfs,
  SynSpellCheck;

type
  TSynGeneralSyn = class(SynHighlighterGeneral.TSynGeneralSyn)
  public
    class function GetFriendlyLanguageName: string; override;
  end;

  TCommandsDataModule = class(TDataModule)
    SynEditPrint: TSynEditPrint;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    ProgramVersionCheck: TJvProgramVersionCheck;
    ProgramVersionHTTPLocation: TJvProgramVersionHTTPLocation;
    actlMain: TActionList;
    actPythonManuals: THelpContents;
    actHelpContents: THelpContents;
    actEditSelectAll: TEditSelectAll;
    actEditUndo: TEditUndo;
    actEditDelete: TEditDelete;
    actEditPaste: TEditPaste;
    actEditCopy: TEditCopy;
    actEditCut: TEditCut;
    actFileCloseAllOther: TAction;
    actHelpWebGroupSupport: TBrowseURL;
    actSearchGoToDebugLine: TAction;
    actEditWordWrap: TAction;
    actSearchHighlight: TAction;
    actSearchReplaceNow: TAction;
    actExportHighlighters: TAction;
    actImportHighlighters: TAction;
    actExportShortCuts: TAction;
    actImportShortcuts: TAction;
    actFileReload: TAction;
    actEditUTF16BE: TAction;
    actEditUTF16LE: TAction;
    actEditUTF8NoBOM: TAction;
    actEditUTF8: TAction;
    actEditToggleComment: TAction;
    actUnitTestWizard: TAction;
    actCheckForUpdates: TAction;
    actHelpEditorShortcuts: TAction;
    actEditAnsi: TAction;
    actEditLBMac: TAction;
    actEditLBUnix: TAction;
    actEditLBDos: TAction;
    actFindNextReference: TAction;
    actFindPreviousReference: TAction;
    actEditShowSpecialChars: TAction;
    actEditLineNumbers: TAction;
    actFindFunction: TAction;
    actHelpExternalTools: TAction;
    actConfigureTools: TAction;
    actInsertTemplate: TAction;
    actHelpParameters: TAction;
    actReplaceParameters: TAction;
    actModifierCompletion: TAction;
    actParameterCompletion: TAction;
    actFindInFiles: TAction;
    actSearchGoToSyntaxError: TAction;
    actSearchGoToLine: TAction;
    actAbout: TAction;
    actEditUntabify: TAction;
    actEditTabify: TAction;
    actSearchMatchingBrace: TAction;
    actEditUncomment: TAction;
    actEditCommentOut: TAction;
    actEditDedent: TAction;
    actEditIndent: TAction;
    actPageSetup: TAction;
    actPrintPreview: TAction;
    actPrinterSetup: TAction;
    actFilePrint: TAction;
    actFileSaveAll: TAction;
    actSearchReplace: TAction;
    actSearchFindPrev: TAction;
    actSearchFindNext: TAction;
    actSearchFind: TAction;
    actFileClose: TAction;
    actFileSaveAs: TAction;
    actFileSave: TAction;
    actEditCopyFileName: TAction;
    actToolsEditStartupScripts: TAction;
    actFoldVisible: TAction;
    actFoldAll: TAction;
    actUnfoldAll: TAction;
    actFoldNearest: TAction;
    actUnfoldNearest: TAction;
    actFoldRegions: TAction;
    actUnfoldRegions: TAction;
    actFoldLevel1: TAction;
    actUnfoldLevel1: TAction;
    actFoldLevel2: TAction;
    actUnfoldLevel2: TAction;
    actFoldLevel3: TAction;
    actUnfoldLevel3: TAction;
    actFoldClasses: TAction;
    actUnfoldClasses: TAction;
    actFoldFunctions: TAction;
    actUnfoldFunctions: TAction;
    actFileCloseAllToTheRight: TAction;
    actFileSaveToRemote: TAction;
    SynWebCompletion: TSynCompletionProposal;
    SynParamCompletion: TSynCompletionProposal;
    SynCodeCompletion: TSynCompletionProposal;
    actToolsRestartLS: TAction;
    SynSpellCheck: TSynSpellCheck;
    actSynSpellCheckFile: TSynSpellCheckFile;
    actSynSpellCheckLine: TSynSpellCheckLine;
    actSynSpellCheckSelection: TSynSpellCheckSelection;
    actSynSpellCheckWord: TSynSpellCheckWord;
    actSynSpellClearErrors: TSynSpellClearErrors;
    actSynSpellCheckAsYouType: TSynSpellCheckAsYouType;
    actSynSpellErrorAdd: TSynSpellErrorAdd;
    actSynSpellErrorIgnoreOnce: TSynSpellErrorIgnoreOnce;
    actSynSpellErrorIgnore: TSynSpellErrorIgnore;
    actSynSpellErrorDelete: TSynSpellErrorDelete;
    actEditCreateStructogram: TAction;
    actEditCopyRTF: TAction;
    actEditCopyRTFNumbered: TAction;
    actEditCopyHTML: TAction;
    actEditCopyHTMLasText: TAction;
    actEditCopyNumbered: TAction;
    actFileExport: TAction;
    actInterpreterEditorOptions: TAction;
    actHelpWebProjectHome: TBrowseURL;
    actDonate: TBrowseURL;
    pmSpelling: TSpTBXPopupMenu;
    mnSpelling: TSpTBXSubmenuItem;
    mnSpellCheckTopSeparator: TSpTBXSeparatorItem;
    mnSpellCheckAdd: TSpTBXItem;
    mnSpellCheckDelete: TSpTBXItem;
    mnSpellCheckIgnore: TSpTBXItem;
    mnSpellCheckIgnoreOnce: TSpTBXItem;
    mnSpellCheckSecondSeparator: TSpTBXSeparatorItem;
    SpTBXItem20: TSpTBXItem;
    SpTBXItem21: TSpTBXItem;
    SpTBXItem22: TSpTBXItem;
    SpTBXItem23: TSpTBXItem;
    SpTBXSeparatorItem24: TSpTBXSeparatorItem;
    SpTBXItem24: TSpTBXItem;
    SpTBXSeparatorItem25: TSpTBXSeparatorItem;
    SpTBXItem25: TSpTBXItem;
    pmAssistant: TSpTBXPopupMenu;
    spiAssistant: TSpTBXSubmenuItem;
    spiSuggest: TSpTBXItem;
    spiAssistantExplain: TSpTBXItem;
    spiFixBugs: TSpTBXItem;
    spiOptimize: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    spiAssistantCancel: TSpTBXItem;
    actAssistantSuggest: TAction;
    actAssistantCancel: TAction;
    actAssistantOptimize: TAction;
    actAssistantFixBugs: TAction;
    actAssistantExplain: TAction;
    actEditRedo: TSynEditRedo;
    actFormatCode: TAction;
    actCodeCheck: TAction;
    actClearIssues: TAction;
    actNextIssue: TAction;
    actPreviousIssue: TAction;
    actFixAll: TAction;
    actOrganizeImports: TAction;
    actRefactorRename: TAction;
    actCodeAction: TAction;
    actShowRefactorMenu: TAction;
    actFileExit: TAction;
    actNavFindResults: TAction;
    actNavWatches: TAction;
    actNavBreakpoints: TAction;
    actNavEditor: TAction;
    actNavInterpreter: TAction;
    actNavVariables: TAction;
    actNavCallStack: TAction;
    actNavMessages: TAction;
    actNavFileExplorer: TAction;
    actNavCodeExplorer: TAction;
    actNavTodo: TAction;
    actNavUnitTests: TAction;
    actNavOutput: TAction;
    actNavProjectExplorer: TAction;
    actNavRegExp: TAction;
    actNavChat: TAction;
    actNavObjectInspector: TAction;
    actNavStructure: TAction;
    actNavUMLInteractive: TAction;
    actProjectNew: TAction;
    actProjectOpen: TAction;
    actProjectSave: TAction;
    actProjectSaveAs: TAction;
    actEditReadOnly: TAction;
    actPythonPath: TAction;
    actCommandLine: TAction;
    procedure actAboutExecute(Sender: TObject);
    function ProgramVersionHTTPLocationLoadFileFromRemote
      (AProgramVersionLocation: TJvProgramVersionHTTPLocation;
      const ARemotePath, ARemoteFileName, ALocalPath, ALocalFileName
      : string): string;
    procedure actCheckForUpdatesExecute(Sender: TObject);
    procedure actUnitTestWizardExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFilePrintExecute(Sender: TObject);
    procedure actFileCloseExecute(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchFindNextExecute(Sender: TObject);
    procedure actSearchFindPrevExecute(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actFileSaveAllExecute(Sender: TObject);
    procedure actPrinterSetupExecute(Sender: TObject);
    procedure actPageSetupExecute(Sender: TObject);
    procedure actPrintPreviewExecute(Sender: TObject);
    procedure actEditIndentExecute(Sender: TObject);
    procedure actEditDedentExecute(Sender: TObject);
    procedure actEditCommentOutExecute(Sender: TObject);
    procedure actEditUncommentExecute(Sender: TObject);
    procedure actSearchMatchingBraceExecute(Sender: TObject);
    procedure actEditTabifyExecute(Sender: TObject);
    procedure actEditUntabifyExecute(Sender: TObject);
    procedure actIDEOptionsExecute(Sender: TObject);
    procedure UpdateFileActions(Sender: TObject);
    procedure actAssistantExplainExecute(Sender: TObject);
    procedure actAssistantCancelExecute(Sender: TObject);
    procedure actAssistantFixBugsExecute(Sender: TObject);
    procedure actAssistantOptimizeExecute(Sender: TObject);
    procedure actAssistantSuggestExecute(Sender: TObject);
    procedure actClearIssuesExecute(Sender: TObject);
    procedure actCodeActionExecute(Sender: TObject);
    procedure actCodeCheckExecute(Sender: TObject);
    procedure actCommandLineExecute(Sender: TObject);
    procedure actPythonManualsExecute(Sender: TObject);
    procedure actSearchGoToLineExecute(Sender: TObject);
    procedure actFindInFilesExecute(Sender: TObject);
    procedure actHelpContentsExecute(Sender: TObject);
    procedure ParameterCompletionCodeCompletion(Sender: TObject;
      var Value: string; Shift: TShiftState; Index: Integer;
      EndToken: WideChar);
    procedure actParameterCompletionExecute(Sender: TObject);
    procedure actModifierCompletionExecute(Sender: TObject);
    procedure actReplaceParametersExecute(Sender: TObject);
    procedure actHelpParametersExecute(Sender: TObject);
    procedure actInsertTemplateExecute(Sender: TObject);
    procedure actConfigureToolsExecute(Sender: TObject);
    procedure actHelpExternalToolsExecute(Sender: TObject);
    procedure actFindFunctionExecute(Sender: TObject);
    procedure actEditLineNumbersExecute(Sender: TObject);
    procedure actEditShowSpecialCharsExecute(Sender: TObject);
    procedure actFindNextReferenceExecute(Sender: TObject);
    procedure actEditLBExecute(Sender: TObject);
    procedure actHelpEditorShortcutsExecute(Sender: TObject);
    procedure actEditToggleCommentExecute(Sender: TObject);
    procedure actEditFileEncodingExecute(Sender: TObject);
    procedure actFileReloadExecute(Sender: TObject);
    procedure actExportShortCutsExecute(Sender: TObject);
    procedure actImportShortcutsExecute(Sender: TObject);
    procedure actExportHighlightersExecute(Sender: TObject);
    procedure actImportHighlightersExecute(Sender: TObject);
    procedure actSearchReplaceNowExecute(Sender: TObject);
    procedure actSearchGoToSyntaxErrorExecute(Sender: TObject);
    procedure actSearchHighlightExecute(Sender: TObject);
    procedure actEditWordWrapExecute(Sender: TObject);
    procedure actSearchGoToDebugLineExecute(Sender: TObject);
    procedure actFileCloseWorkspaceTabsExecute(Sender: TObject);
    procedure actEditCopyFileNameExecute(Sender: TObject);
    procedure actToolsEditStartupScriptsExecute(Sender: TObject);
    procedure actFoldVisibleExecute(Sender: TObject);
    procedure actFoldAllExecute(Sender: TObject);
    procedure actUnfoldAllExecute(Sender: TObject);
    procedure actFoldNearestExecute(Sender: TObject);
    procedure actUnfoldNearestExecute(Sender: TObject);
    procedure actUnfoldRegionsExecute(Sender: TObject);
    procedure actFoldRegionsExecute(Sender: TObject);
    procedure actUnfoldLevel1Execute(Sender: TObject);
    procedure actFoldLevel1Execute(Sender: TObject);
    procedure actFoldLevel2Execute(Sender: TObject);
    procedure actUnfoldLevel2Execute(Sender: TObject);
    procedure actFoldLevel3Execute(Sender: TObject);
    procedure actUnfoldLevel3Execute(Sender: TObject);
    procedure actFoldClassesExecute(Sender: TObject);
    procedure actUnfoldClassesExecute(Sender: TObject);
    procedure actFoldFunctionsExecute(Sender: TObject);
    procedure actUnfoldFunctionsExecute(Sender: TObject);
    procedure actEditReadOnlyExecute(Sender: TObject);
    procedure actFileSaveToRemoteExecute(Sender: TObject);
    procedure actToolsRestartLSExecute(Sender: TObject);
    procedure HighlightCheckedImg(Sender: TObject; ACanvas: TCanvas;
      State: TSpTBXSkinStatesType; const PaintStage: TSpTBXPaintStage;
      var AImageList: TCustomImageList; var AImageIndex: Integer;
      var ARect: TRect; var PaintDefault: Boolean);

    procedure actEditCreateStructogramExecute(Sender: TObject);
    procedure actEditCopyRTFExecute(Sender: TObject);
    procedure actEditCopyRTFNumberedExecute(Sender: TObject);
    procedure actEditCopyHTMLExecute(Sender: TObject);
    procedure actEditCopyHTMLasTextExecute(Sender: TObject);
    procedure actEditCopyNumberedExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actFileExportExecute(Sender: TObject);
    procedure actInterpreterEditorOptionsExecute(Sender: TObject);
    procedure actFormatCodeExecute(Sender: TObject);
    procedure actNextIssueExecute(Sender: TObject);
    procedure actPreviousIssueExecute(Sender: TObject);
    procedure actPythonPathExecute(Sender: TObject);
    procedure actFixAllExecute(Sender: TObject);
    procedure actNavEditorExecute(Sender: TObject);
    procedure actNavigateToDockWindow(Sender: TObject);
    procedure actOrganizeImportsExecute(Sender: TObject);
    procedure actRefactorRenameExecute(Sender: TObject);
    procedure actShowRefactorMenuExecute(Sender: TObject);
    procedure UpdateRefactorActions(Sender: TObject);
    procedure mnSpellingPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure actProjectNewExecute(Sender: TObject);
    procedure actProjectOpenExecute(Sender: TObject);
    procedure actProjectSaveAsExecute(Sender: TObject);
    procedure actProjectSaveExecute(Sender: TObject);
    procedure SynSpellCheckChange(Sender: TObject);
    procedure UpdateActionAlwaysEnabled(Sender: TObject);
    procedure UpdateAssistantActions(Sender: TObject);
    procedure UpdateCodeFoldingActions(Sender: TObject);
    procedure UpdateEditActions(Sender: TObject);
    procedure UpdateEncodingActions(Sender: TObject);
    procedure UpdateIssuesActions(Sender: TObject);
    procedure UpdateLineBreakActions(Sender: TObject);
    procedure UpdateParameterActions(Sender: TObject);
    procedure UpdateRunActions(Sender: TObject);
    procedure UpdateSearchActions(Sender: TObject);
    procedure UpdateSourceCodeActions(Sender: TObject);
    procedure UpdateToolsActions(Sender: TObject);
  private
    fConfirmReplaceDialogRect: TRect;
    procedure PyIDEOptionsChanged(const Sender: TObject; const Msg:
        System.Messaging.TMessage);
  protected
    procedure Loaded; override;
  public
    procedure AutoCheckForUpdates;
    procedure SynEditOptionsDialogGetHighlighterCount(Sender: TObject;
      var Count: Integer);
    procedure SynEditOptionsDialogGetHighlighter(Sender: TObject;
      Index: Integer; var SynHighlighter: TSynCustomHighlighter);
    procedure SynEditOptionsDialogSetHighlighter(Sender: TObject;
      Index: Integer; SynHighlighter: TSynCustomHighlighter);
    procedure SynInterpreterOptionsDialogGetHighlighterCount(Sender: TObject;
      var Count: Integer);
    procedure SynInterpreterOptionsDialogGetHighlighter(Sender: TObject;
      Index: Integer; var SynHighlighter: TSynCustomHighlighter);
    procedure SynInterpreterOptionsDialogSetHighlighter(Sender: TObject;
      Index: Integer; SynHighlighter: TSynCustomHighlighter);
    function ShowPythonKeywordHelp(const KeyWord: string): Boolean;
    procedure GetEditorUserCommand(AUserCommand: Integer;
      var ADescription: string);
    procedure GetEditorAllUserCommands(ACommands: TStrings);
    function DoSearchReplaceText(SynEdit: TSynEdit;
      AReplace, ABackwards: Boolean; IsIncremental: Boolean = False): Integer;
    procedure ShowSearchReplaceDialog(SynEdit: TSynEdit; AReplace: Boolean);
    procedure SynEditReplaceText(Sender: TObject;
      const ASearch, AReplace: string; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure IncrementalSearch;
    procedure ApplyEditorOptions;
    function FindSearchTarget: ISearchCommands;
    procedure HighlightWordInActiveEditor(const SearchWord: string);
    class procedure RegisterActionList(ActionList: TActionList);
  end;

var
  CommandsDataModule: TCommandsDataModule = nil;

implementation

{$R *.DFM}

uses
  WinApi.ShlObj,
  WinApi.ShellAPI,
  WinApi.ActiveX,
  WinApi.Windows,
  System.UITypes,
  System.SysUtils,
  System.Win.Registry,
  System.StrUtils,
  System.DateUtils,
  System.IOUtils,
  System.IniFiles,
  System.Math,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Clipbrd,
  Vcl.Themes,
  MPShellUtilities,
  MPCommonUtilities,
  SpTBXMDIMRU,
  SpTBXTabs,
  PythonEngine,
  SVGIconImage,
  JclDebug,
  JclShell,
  JvAppIniStorage,
  JvAppStorage,
  JvDSADialogs,
  JvJCLUtils,
  JvDynControlEngineVCL,
  JvGnugettext,
  SynEditTypes,
  SynEditTextBuffer,
  SynEditKeyCmds,
  SynEditMiscProcs,
  SynHighlighterPython,
  cPyBaseDebugger,
  XLSPTypes,
  dmResources,
  StringResources,
  uPythonItfs,
  dlgSynPageSetup,
  dlgDirectoryList,
  dlgAboutPyScripter,
  dlgCommandLine,
  dlgConfirmReplace,
  dlgCustomShortcuts,
  dlgUnitTestWizard,
  dlgPickList,
  dlgCollectionEditor,
  dlgToolProperties,
  dlgSynEditOptions,
  frmPythonII,
  frmPyIDEMain,
  frmEditor,
  frmFile,
  frmIDEDockWin,
  frmFindResults,
  frmFunctionList,
  cLspClients,
  uParams,
  uCommonFunctions,
  uSearchHighlighter,
  uLLMSupport,
  cTools,
  cPySupportTypes,
  cPyScripterSettings,
  cParameters,
  UUpdate;

procedure TCommandsDataModule.actAboutExecute(Sender: TObject);
begin
  with TAboutBox.Create(Self) do begin
    ShowModal;
    Release;
  end;
end;

{ TCommandsDataModule }

procedure TCommandsDataModule.DataModuleCreate(Sender: TObject);
begin
  // Set the language before all calls to TranslateComponent
  // This avoids retranslating if the local lanuage <> "en"
  // and the stored lanuage option is "en".
  UseLanguage('en');
  TranslateComponent(Self);
  RegisterActionList(actlMain);

  TMessageManager.DefaultManager.SubscribeToMessage(TIDEOptionsChangedMessage,
     PyIDEOptionsChanged);
end;

procedure TCommandsDataModule.DataModuleDestroy(Sender: TObject);
begin
  CommandsDataModule := nil;
  TMessageManager.DefaultManager.Unsubscribe(TIDEOptionsChangedMessage,
      PyIDEOptionsChanged);
end;

{$REGION 'Highlighter methods'}

procedure TCommandsDataModule.SynEditOptionsDialogGetHighlighterCount
  (Sender: TObject; var Count: Integer);
begin
  Count := ResourcesDataModule.Highlighters.Count + 1;
  // The last one is the Python Interpreter
end;

procedure TCommandsDataModule.SynEditOptionsDialogGetHighlighter
  (Sender: TObject; Index: Integer; var SynHighlighter: TSynCustomHighlighter);
begin
  if (Index >= 0) and (Index < ResourcesDataModule.Highlighters.Count) then
    SynHighlighter := ResourcesDataModule.Highlighters[Index]
  else if Index = ResourcesDataModule.Highlighters.Count then
    SynHighlighter := GI_PyInterpreter.Editor.Highlighter
  else
    SynHighlighter := nil;
end;

procedure TCommandsDataModule.SynEditOptionsDialogSetHighlighter
  (Sender: TObject; Index: Integer; SynHighlighter: TSynCustomHighlighter);
begin
  if (Index >= 0) and (Index < ResourcesDataModule.Highlighters.Count) then
    ResourcesDataModule.Highlighters[Index].Assign(SynHighlighter)
  else if Index = ResourcesDataModule.Highlighters.Count then
    GI_PyInterpreter.Editor.Highlighter.Assign(SynHighlighter);
end;

procedure TCommandsDataModule.SynInterpreterOptionsDialogGetHighlighter
  (Sender: TObject; Index: Integer; var SynHighlighter: TSynCustomHighlighter);
begin
  if Index = 0 then
    SynHighlighter := GI_PyInterpreter.Editor.Highlighter
  else
    SynHighlighter := nil;
end;

procedure TCommandsDataModule.SynInterpreterOptionsDialogGetHighlighterCount
  (Sender: TObject; var Count: Integer);
begin
  Count := 1;
end;

procedure TCommandsDataModule.SynInterpreterOptionsDialogSetHighlighter
  (Sender: TObject; Index: Integer; SynHighlighter: TSynCustomHighlighter);
begin
  if Index = 0 then
    GI_PyInterpreter.Editor.Highlighter.Assign(SynHighlighter);
end;

procedure TCommandsDataModule.HighlightWordInActiveEditor(const SearchWord: string);
var
  OldWholeWords: Boolean;
  OldSearchText: string;
begin
  EditorSearchOptions.InitSearch;
  OldWholeWords := EditorSearchOptions.SearchWholeWords;
  OldSearchText := EditorSearchOptions.SearchText;

  EditorSearchOptions.SearchWholeWords := True;
  EditorSearchOptions.SearchText := SearchWord;
  actSearchHighlight.Checked := True;
  actSearchHighlightExecute(Self);

  EditorSearchOptions.SearchWholeWords := OldWholeWords;
  EditorSearchOptions.SearchText := OldSearchText;
end;

{$ENDREGION 'Highlighter methods'}

procedure TCommandsDataModule.actFileSaveExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSave;
end;

procedure TCommandsDataModule.actFileSaveToRemoteExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSaveAsRemote;
end;

procedure TCommandsDataModule.actFileSaveAsExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSaveAs;
end;

procedure TCommandsDataModule.actFileSaveAllExecute(Sender: TObject);
begin
  GI_FileFactory.ApplyToFiles(
    procedure(Fi: IFile)
    begin
      var
      FileCommands := Fi as IFileCommands;
      if Assigned(FileCommands) and FileCommands.CanSave then
        FileCommands.ExecSave;
    end);
end;

procedure TCommandsDataModule.actFilePrintExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecPrint;
end;

procedure TCommandsDataModule.actFileReloadExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecReload;
end;

procedure TCommandsDataModule.actPrintPreviewExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecPrintPreview;
end;

procedure TCommandsDataModule.actPrinterSetupExecute(Sender: TObject);
begin
  with TPrinterSetupDialog.Create(Self) do
  begin
    Execute;
    Free;
  end;
end;

procedure TCommandsDataModule.actPageSetupExecute(Sender: TObject);
begin
  with TPageSetupDlg.Create(Self) do
  begin
    SetValues(SynEditPrint);
    if ShowModal = mrOk then
      GetValues(SynEditPrint);
    Release;
  end;
end;

procedure TCommandsDataModule.actFileCloseWorkspaceTabsExecute(Sender: TObject);

  procedure WorkspaceCloseOtherTabs(aFile: IFile; Backwards: Boolean);
  var
    NextTab: TSpTBXTabItem;
    NextFile: IFile;
  begin
    repeat
      NextTab := TFileForm(aFile.Form).ParentTabItem.GetNextTab(not Backwards,
        sivtNormal);
      if Assigned(NextTab) then
      begin
        NextFile := PyIDEMainForm.FileFromTab(NextTab);
        if Assigned(NextFile) then
          if NextFile.AskSaveChanges then
            NextFile.Close
          else
            Break;
      end;
    until not Assigned(NextTab);
  end;

var
  aFile: IFile;
begin
  aFile := GI_PyIDEServices.GetActiveFile;
  if not Assigned(aFile) then
    Exit;

  WorkspaceCloseOtherTabs(aFile, False);
  if (Sender as TBasicAction).Tag > 0 then
    WorkspaceCloseOtherTabs(aFile, True);

  aFile.Activate;
end;

procedure TCommandsDataModule.actFileExportExecute(Sender: TObject);
var
  aFile: IFile;
begin
  aFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(aFile) then
    aFile.ExecExport;
end;

procedure TCommandsDataModule.actFileCloseExecute(Sender: TObject);
var
  aFile: IFile;
begin
  aFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(aFile) then
    (aFile as IFileCommands).ExecClose;
end;

procedure TCommandsDataModule.actEditReadOnlyExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ReadOnly := not GI_ActiveEditor.ReadOnly;
end;

procedure TCommandsDataModule.actSearchFindExecute(Sender: TObject);
var
  SearchCommands: ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecFind
end;

procedure TCommandsDataModule.actSearchFindNextExecute(Sender: TObject);
var
  SearchCommands: ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecFindNext
end;

procedure TCommandsDataModule.actSearchFindPrevExecute(Sender: TObject);
var
  SearchCommands: ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecFindPrev
end;

procedure TCommandsDataModule.actSearchReplaceExecute(Sender: TObject);
var
  SearchCommands: ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecReplace
end;

procedure TCommandsDataModule.IncrementalSearch;
var
  SearchCmds: ISearchCommands;
begin
  SearchCmds := FindSearchTarget;
  if Assigned(SearchCmds) then
    with SearchCmds do
    begin
      SearchTarget.SetCaretAndSelection(SearchTarget.BlockBegin,
        SearchTarget.BlockBegin, SearchTarget.BlockBegin);
      EditorSearchOptions.InitSearch;
      DoSearchReplaceText(SearchTarget, False, False, True);
    end;
end;

procedure TCommandsDataModule.Loaded;
begin
  inherited;
  // SynEditPrint
  with SynEditPrint do
  begin
    Font.Name := DefaultCodeFontName;
    Font.Size := 10;
    with Header do
    begin
      Add('$TITLE$', nil, taCenter, 2);
      DefaultFont.Size := 10;
    end;
    with Footer do
    begin
      Add('$PAGENUM$/$PAGECOUNT$', nil, taCenter, 1);
      DefaultFont.Size := 10;
    end;
  end;

  // Program Version Check
  ProgramVersionCheck.ThreadDialog.DialogOptions.ShowModal := False;
{$IFDEF CPUX64}
  ProgramVersionHTTPLocation.VersionInfoFileName :=
    'PyScripterVersionInfo-x64.ini';
{$ELSE}
  ProgramVersionHTTPLocation.VersionInfoFileName := 'PyScripterVersionInfo.ini';
{$ENDIF}
end;


procedure TCommandsDataModule.ApplyEditorOptions;
// Assign Editor Options to all open editors
begin
  GI_EditorFactory.ApplyToEditors(
    procedure(Editor: IEditor)
    begin
      Editor.ApplyEditorOptions(GEditorOptions);
    end);
end;

{$REGION 'Action Execute Handlers'}

procedure TCommandsDataModule.AutoCheckForUpdates;
begin
  if PyIDEOptions.AutoCheckForUpdates then
  begin
    var DateLastCheckedForUpdates := GI_PyIDEServices.AppStorage.ReadDateTime(
      'Date checked for updates', MinDateTime);
    if (DaysBetween(Now, DateLastCheckedForUpdates) >=
      PyIDEOptions.DaysBetweenChecks) and ConnectedToInternet
    then
      actCheckForUpdatesExecute(nil);  // nil so that we get no confirmation
  end;
end;

procedure TCommandsDataModule.actSearchReplaceNowExecute(Sender: TObject);
var
  SearchCmds: ISearchCommands;
begin
  SearchCmds := FindSearchTarget;
  if Assigned(SearchCmds) then
    with SearchCmds do
    begin
      EditorSearchOptions.InitSearch;
      DoSearchReplaceText(SearchTarget, True, False);
    end;
end;

procedure TCommandsDataModule.actToolsEditStartupScriptsExecute
  (Sender: TObject);
begin
  GI_EditorFactory.OpenFile(TPyScripterSettings.PyScripterInitFile);
  GI_EditorFactory.OpenFile(TPyScripterSettings.EngineInitFile);
end;

procedure TCommandsDataModule.actSearchGoToDebugLineExecute(Sender: TObject);
begin
  with GI_PyControl.CurrentPos do
    if (Line >= 1) and GI_PyControl.PythonLoaded and not GI_PyControl.Running
    then
      GI_PyIDEServices.ShowFilePosition(FileId, Line, 1, 0, True, True);
end;

procedure TCommandsDataModule.actSearchGoToLineExecute(Sender: TObject);
var
  Line: string;
  LineNo: Integer;
begin
  if Assigned(GI_ActiveEditor) then
    if InputQuery(_(SGoToLineNumber), _(SEnterLineNumber), Line) then
    begin
      try
        LineNo := StrToInt(Line);
        GI_ActiveEditor.ActiveSynEdit.CaretXY := BufferCoord(1, LineNo);
      except
        on E: EConvertError do
        begin
          StyledMessageDlg(Format(_(SNotAValidNumber), [Line]), mtError,
            [mbAbort], 0);
        end;
      end;
    end;
end;

procedure TCommandsDataModule.actSearchGoToSyntaxErrorExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).GoToSyntaxError;
end;

procedure TCommandsDataModule.actSearchHighlightExecute(Sender: TObject);
var
  SearchEngine: TSynEditSearchCustom;
  SearchOptions: TSynSearchOptions;
  Editor: IEditor;
begin
  Editor := GI_PyIDEServices.ActiveEditor;
  if Assigned(Editor) then
  begin
    if actSearchHighlight.Checked and (EditorSearchOptions.SearchText <> '')
    then
    begin
      SearchOptions := [];
      case EditorSearchOptions.SearchCaseSensitiveType of
        scsAuto:
          if LowerCase(EditorSearchOptions.SearchText) <> EditorSearchOptions.SearchText
          then
            Include(SearchOptions, ssoMatchCase);
        scsCaseSensitive:
          Include(SearchOptions, ssoMatchCase);
      end;
      if EditorSearchOptions.SearchWholeWords then
        Include(SearchOptions, ssoWholeWord);

      if EditorSearchOptions.UseRegExp then
        SearchEngine := SynEditRegexSearch
      else
        SearchEngine := SynEditSearch;
      try
        HighligthtSearchTerm(EditorSearchOptions.SearchText, Editor,
          SearchEngine, SearchOptions);
      except
        on E: ESynRegEx do
        begin
          MessageBeep(MB_ICONERROR);
          GI_PyIDEServices.WriteStatusMsg(Format(_(SInvalidRegularExpression),
            [E.Message]));
          Exit;
        end;
      end;
    end
    else if not actSearchHighlight.Checked then
      ClearAllHighlightedTerms;
  end;
end;

procedure TCommandsDataModule.actFindInFilesExecute(Sender: TObject);
begin
  if Assigned(FindResultsWindow) then
    FindResultsWindow.Execute(False)
end;

procedure TCommandsDataModule.actUnfoldAllExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.UncollapseAll;
end;

procedure TCommandsDataModule.actUnfoldClassesExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.UncollapseFoldType(3);
end;

procedure TCommandsDataModule.actUnfoldFunctionsExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.UncollapseFoldType(4);
end;

procedure TCommandsDataModule.actUnfoldLevel1Execute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecUnfoldLevel1, ' ', nil);
end;

procedure TCommandsDataModule.actUnfoldLevel2Execute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecUnfoldLevel2, ' ', nil);
end;

procedure TCommandsDataModule.actUnfoldLevel3Execute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecUnfoldLevel3, ' ', nil);
end;

procedure TCommandsDataModule.actUnfoldNearestExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecUnfoldNearest, ' ', nil);
end;

procedure TCommandsDataModule.actUnfoldRegionsExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecUnfoldRegions, ' ', nil);
end;

procedure TCommandsDataModule.actUnitTestWizardExecute(Sender: TObject);
var
  Tests: string;
  Editor: IEditor;
begin
  if Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile then
  begin
    Tests := TUnitTestWizard.GenerateTests(GI_ActiveEditor.FileId);
    if Tests <> '' then
    begin
      Editor := IEditor(GI_EditorFactory.OpenFile('', 'Python'));
      if Assigned(Editor) then
        Editor.SynEdit.SelText := Tests;
    end;
  end;
end;


procedure TCommandsDataModule.actInterpreterEditorOptionsExecute
  (Sender: TObject);
begin
  var
  TempEditorOptions := TSmartPtr.Make
    (TSynEditorOptionsContainer.Create(Self))();
  with TSynEditOptionsDialog.Create(Self) do
  begin
    TempEditorOptions.Assign(GI_PyInterpreter.Editor);
    Form.cbApplyToAll.Checked := False;
    Form.cbApplyToAll.Enabled := False;
    Form.Caption := 'Interpreter Editor Options';
    OnGetHighlighterCount := SynInterpreterOptionsDialogGetHighlighterCount;
    OnGetHighlighter := SynInterpreterOptionsDialogGetHighlighter;
    OnSetHighlighter := SynInterpreterOptionsDialogSetHighlighter;
    VisiblePages := [soDisplay, soOptions, soColor];
    TSynEditOptionsDialog.HighlighterFileDir :=
      TPyScripterSettings.ColorThemesFilesDir;
    if Execute(TempEditorOptions) then
    begin
      UpdateHighlighters;
      (GI_PyInterpreter as TPythonIIForm).ApplyEditorOptions(TempEditorOptions);
    end;
    Free;
  end;
end;

procedure TCommandsDataModule.actEditIndentExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.CommandProcessor(ecBlockIndent, ' ', nil);
end;

procedure TCommandsDataModule.actEditDedentExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.CommandProcessor(ecBlockUnIndent, ' ', nil);
end;

procedure TCommandsDataModule.actEditToggleCommentExecute(Sender: TObject);
var
  EndLine: Integer;
  BlockIsCommented: Boolean;
begin
  if Assigned(GI_ActiveEditor) then
    with GI_ActiveEditor.ActiveSynEdit do
    begin
      if (BlockBegin.Line <> BlockEnd.Line) and (BlockEnd.Char = 1) then
        EndLine := BlockEnd.Line - 1
      else
        EndLine := BlockEnd.Line;

      BlockIsCommented := True;
      for var I := BlockBegin.Line to EndLine do
        if Copy(Trim(Lines[I - 1]), 1, 2) <> '##' then
        begin
          BlockIsCommented := False;
          Break;
        end;

      if BlockIsCommented then
        actEditUncommentExecute(Sender)
      else
        actEditCommentOutExecute(Sender);
    end;
end;

procedure TCommandsDataModule.actEditFileEncodingExecute(Sender: TObject);
begin
  if (Sender is TAction) and Assigned(GI_ActiveEditor) then
  begin
    GI_ActiveEditor.FileEncoding := TFileSaveFormat(TAction(Sender).Tag);
    GI_ActiveEditor.SynEdit.Modified := True;
  end;
end;

procedure TCommandsDataModule.actEditCommentOutExecute(Sender: TObject);
var
  Str: string;
  Offset: Integer;
  OldBlockBegin, OldBlockEnd: TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then
    with GI_ActiveEditor.ActiveSynEdit do
    begin
      OldBlockBegin := BlockBegin;
      OldBlockEnd := BlockEnd;
      if SelAvail then
      begin // has selection
        OldBlockBegin := BufferCoord(1, OldBlockBegin.Line);
        BlockBegin := OldBlockBegin;
        BlockEnd := OldBlockEnd;
        BeginUpdate;
        Str := '##' + SelText;
        Offset := 0;
        if Str[Length(Str)] = #10 then
        begin // if the selection ends with a newline, eliminate it
          if Str[Length(Str) - 1] = #13 then // do we ignore 1 or 2 chars?
            Offset := 2
          else
            Offset := 1;
          Str := Copy(Str, 1, Length(Str) - Offset);
        end;
        Str := StringReplace(Str, #10, #10'##', [rfReplaceAll]);
        if Offset = 1 then
          Str := Str + #10
        else if Offset = 2 then
          Str := Str + sLineBreak;
        SelText := Str;
        EndUpdate;
        BlockBegin := OldBlockBegin;
        if Offset = 0 then
          Inc(OldBlockEnd.Char, 2);
        BlockEnd := BufferCoord(OldBlockEnd.Char, OldBlockEnd.Line);
      end
      else
      begin // no selection; easy stuff ;)
        // Do with selection to be able to undo
        // LineText:='##'+LineText;
        CaretXY := BufferCoord(1, CaretY);
        SelText := '##';
        CaretXY := BufferCoord(OldBlockEnd.Char + 2, OldBlockEnd.Line);
      end;
      UpdateCarets;
    end;
end;

procedure TCommandsDataModule.actEditUncommentExecute(Sender: TObject);
var
  OldBlockBegin, OldBlockEnd: TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then
    with GI_ActiveEditor.ActiveSynEdit do
    begin
      OldBlockBegin := BlockBegin;
      OldBlockEnd := BlockEnd;
      if SelAvail then
      begin
        OldBlockBegin := BufferCoord(1, OldBlockBegin.Line);
        BlockBegin := OldBlockBegin;
        BlockEnd := OldBlockEnd;
        SelText := TPyRegExpr.CodeCommentLineRE.Replace(SelText, '$1');
        BlockBegin := OldBlockBegin;
        BlockEnd := BufferCoord(OldBlockEnd.Char - 2, OldBlockEnd.Line);
      end
      else
      begin
        BlockBegin := BufferCoord(1, CaretY);
        BlockEnd := BufferCoord(Length(LineText) + 1, CaretY);
        SelText := TPyRegExpr.CodeCommentLineRE.Replace(SelText, '$1');
        CaretXY := BufferCoord(OldBlockEnd.Char - 2, OldBlockEnd.Line);
      end;
      UpdateCarets;
    end;
end;

procedure TCommandsDataModule.actEditTabifyExecute(Sender: TObject);
var
  BB, BE: TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do
  begin
    if SelAvail then
    begin
      BB := BlockBegin;
      BE := BlockEnd;
    end
    else
    begin
      BB := BufferCoord(1,1);
      BE := BufferCoord(Lines[Lines.Count -1].Length + 1, Lines.Count);
    end;
    var S := TabifyString(SelectionText(BB, BE));
    SetSelectionText(S, BB, BE);
  end;
end;

procedure TCommandsDataModule.actEditUntabifyExecute(Sender: TObject);
var
  BB, BE: TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do
  begin
    if SelAvail then
    begin
      BB := BlockBegin;
      BE := BlockEnd;
    end
    else
    begin
      BB := BufferCoord(1,1);
      BE := BufferCoord(Lines[Lines.Count -1].Length + 1, Lines.Count);
    end;
    var S := SelectionText(BB, BE);
    var SLines := StringToLines(S);
    for var I := 0 to Length(SLines) - 1 do
       SLines[I] := ExpandTabs(SLines[I], TabWidth);
    S := ''.Join(SLineBreak, SLines);
    SetSelectionText(S, BB, BE);
  end;
end;

procedure TCommandsDataModule.actExportHighlightersExecute(Sender: TObject);
begin
  ResourcesDataModule.ExportHighlighters;
end;

procedure TCommandsDataModule.actExportShortCutsExecute(Sender: TObject);
var
  AppStorage: TJvAppIniFileStorage;
  ActionProxyCollection: TActionProxyCollection;
begin
  with ResourcesDataModule.dlgFileSave do
  begin
    Title := _(SExportShortcuts);
    Filter := ResourcesDataModule.SynIniSyn.DefaultFilter;
    DefaultExt := 'ini';
    if Execute then
    begin
      AppStorage := TJvAppIniFileStorage.Create(nil);
      try
        AppStorage.FlushOnDestroy := True;
        AppStorage.Location := flCustom;
        AppStorage.FileName := FileName;
        AppStorage.StorageOptions.StoreDefaultValues := False;
        AppStorage.WriteString('PyScripter\Version', ApplicationVersion);
        AppStorage.DeleteSubTree('IDE Shortcuts');
        ActionProxyCollection := TActionProxyCollection.Create(apcctAll);
        try
          AppStorage.WriteCollection('IDE Shortcuts', ActionProxyCollection,
            'Action');
        finally
          ActionProxyCollection.Free;
        end;
        AppStorage.DeleteSubTree('Editor Shortcuts');
        AppStorage.WriteCollection('Editor Shortcuts',
          GEditorOptions.Keystrokes);
      finally
        AppStorage.Free;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.actImportHighlightersExecute(Sender: TObject);
begin
  ResourcesDataModule.ImportHighlighters;
end;

procedure TCommandsDataModule.actImportShortcutsExecute(Sender: TObject);
var
  AppStorage: TJvAppIniFileStorage;
  ActionProxyCollection: TActionProxyCollection;
  TempKeyStrokes: TSynEditKeyStrokes;
begin
  with ResourcesDataModule.dlgFileOpen do
  begin
    Title := _(SImportShortcuts);
    Filter := ResourcesDataModule.SynIniSyn.DefaultFilter;
    FileName := '';
    if Execute then
    begin
      AppStorage := TJvAppIniFileStorage.Create(nil);
      try
        AppStorage.Location := flCustom;
        AppStorage.FileName := FileName;
        AppStorage.ReadOnly := True;

        if AppStorage.PathExists('IDE Shortcuts') then
        begin
          ActionProxyCollection := TActionProxyCollection.Create(apcctEmpty);
          try
            AppStorage.ReadCollection('IDE Shortcuts', ActionProxyCollection,
              True, 'Action');
            ActionProxyCollection.ApplyShortCuts;
          finally
            ActionProxyCollection.Free;
          end;
        end;
        if AppStorage.PathExists('Editor Shortcuts') then
        begin
          TempKeyStrokes := TSmartPtr.Make(TSynEditKeyStrokes.Create(nil))();
          try
            AppStorage.ReadCollection('Editor Shortcuts', TempKeyStrokes, True);
            GEditorOptions.Keystrokes.Assign(TempKeyStrokes);
          except
            on E: ESynKeyError do
              StyledMessageDlg(E.Message, mtError, [TMsgDlgBtn.mbOK], 0);
          end;
          GI_EditorFactory.ApplyToEditors(
            procedure(Editor: IEditor)
            begin
              Editor.SynEdit.Keystrokes.Assign(GEditorOptions.Keystrokes);
            end);

          (GI_PyInterpreter as TPythonIIForm).ApplyEditorOptions(GEditorOptions, True);
        end;
      finally
        AppStorage.Free;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.actEditLBExecute(Sender: TObject);
begin
  if (Sender is TAction) and Assigned(GI_ActiveEditor) then
  begin
    (GI_ActiveEditor.SynEdit.Lines as TSynEditStringList).FileFormat :=
      TSynEditFileFormat(TAction(Sender).Tag);
    GI_ActiveEditor.SynEdit.Modified := True;
  end;
end;

procedure TCommandsDataModule.actSearchMatchingBraceExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.CommandProcessor(ecMatchBracket, #0, nil);
end;

procedure TCommandsDataModule.actIDEOptionsExecute(Sender: TObject);
var
  Reg: TRegistry;
  IsRegistered: Boolean;
  Key: string;
  IgnoredProperties: TArray<string>;
begin

  // Shell Integration
  IsRegistered := False;
  Reg := TRegistry.Create(KEY_READ and not KEY_NOTIFY);
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Key := 'Python.File\shell\Edit with GuiPy';
    IsRegistered := Reg.KeyExists(Key);
  except
  end;
  FreeAndNil(Reg);

  PyIDEOptions.FileExplorerContextMenu := IsRegistered;

  PyIDEOptions.SearchTextAtCaret := EditorSearchOptions.SearchTextAtCaret;

  IgnoredProperties := ['StructureColors', 'UseStructureColors'];

  var
  AdditionalFriendlyNames := TSmartPtr.Make(TStringList.Create)();
  AdditionalFriendlyNames.AddPair('StructureHighlight',
    _('Highlight structure'));
  AdditionalFriendlyNames.AddPair('ShowHintMark', _('Show hint mark'));
  AdditionalFriendlyNames.AddPair('GutterShapeSize', _('Gutter shape size'));
  AdditionalFriendlyNames.AddPair('ShowCollapsedLine',
    _('Show collapsed line'));
  AdditionalFriendlyNames.AddPair('CollapsedLineColor',
    _('Collapsed line color'));
  AdditionalFriendlyNames.AddPair('FolderBarLinesColor',
    _('Folder bar lines color'));
  AdditionalFriendlyNames.AddPair('FillWholeLines', _('Fill whole lines'));
  AdditionalFriendlyNames.AddPair('ModifiedColor', _('Modified color'));
  AdditionalFriendlyNames.AddPair('OriginalColor', _('Original color'));
  AdditionalFriendlyNames.AddPair('SavedColor', _('Saved color'));
  AdditionalFriendlyNames.AddPair('SavedModifiedColor',
    _('Saved and modified color'));

  PyIDEOptions.Changed;
  PyIDEMainForm.StoreApplicationData;
  if PyIDEOptions.FileExplorerContextMenu <> IsRegistered then
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CLASSES_ROOT;
      if IsRegistered then
      begin
        Reg.DeleteKey(Key)
      end
      else
      begin
        Reg.OpenKey(Key, True);
        Reg.CloseKey;
        Reg.OpenKey(Key + '\command', True);
        Reg.WriteString('', '"' + Application.ExeName + ' "%1"');
        Reg.CloseKey;
      end;

      SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
    except
      StyledMessageDlg(_(SRegistryAccessDenied), mtError, [mbOK], 0);
    end;
    FreeAndNil(Reg);
  end;
end;

procedure TCommandsDataModule.actPythonPathExecute(Sender: TObject);
var
  Paths: TStringList;
begin
  if not GI_PyControl.PythonLoaded then
    Exit;

  Paths := TStringList.Create;
  try
    GI_PyControl.ActiveInterpreter.SysPathToStrings(Paths);
    if EditFolderList(Paths, _('Python Path'), 870) then
      GI_PyControl.ActiveInterpreter.StringsToSysPath(Paths);
  finally
    Paths.Free;
  end;
end;

procedure TCommandsDataModule.actAssistantExplainExecute(Sender: TObject);
begin
  LLMAssistant.Explain;
end;

procedure TCommandsDataModule.actAssistantCancelExecute(Sender: TObject);
begin
  if LLMAssistant.IsBusy then
    LLMAssistant.CancelRequest;
end;

procedure TCommandsDataModule.actAssistantFixBugsExecute(Sender: TObject);
begin
  LLMAssistant.FixBugs;
end;

procedure TCommandsDataModule.actAssistantOptimizeExecute(Sender: TObject);
begin
  LLMAssistant.Optimize;
end;

procedure TCommandsDataModule.actAssistantSuggestExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
  begin
    SynCodeCompletion.CancelCompletion;
    SynParamCompletion.CancelCompletion;
    LLMAssistant.Suggest;
  end;
end;

procedure TCommandsDataModule.actPythonManualsExecute(Sender: TObject);
begin
  var
  PythonHelpFile := GI_PyControl.PythonHelpFile;
  if PythonHelpFile = '' then
    Exit;

  if ExtractFileExt(PythonHelpFile) = '.chm' then
  begin
    var
    OldHelpFile := Application.HelpFile;
    Application.HelpFile := PythonHelpFile;
    PyIDEMainForm.MenuHelpRequested := True;
    try
      Application.HelpCommand(HELP_CONTENTS, 0);
    finally
      Application.HelpFile := OldHelpFile;
      PyIDEMainForm.MenuHelpRequested := False;
    end;
  end
  else if ExtractFileExt(PythonHelpFile) = '.html' then // python 11
    ShellExecute(0, 'open', PChar(FilePathToURI(PythonHelpFile)), '', '',
      SW_SHOWNORMAL);
end;

function TCommandsDataModule.ShowPythonKeywordHelp(const KeyWord: string): Boolean;
begin
  Result := False;
  var
  PythonHelpFile := GI_PyControl.PythonHelpFile;
  if PythonHelpFile = '' then
    Exit;

  if ExtractFileExt(PythonHelpFile) = '.chm' then
  begin
    var
    OldHelpFile := Application.HelpFile;
    Application.HelpFile := GI_PyControl.PythonHelpFile;
    PyIDEMainForm.PythonKeywordHelpRequested := True;
    try
      Result := Application.HelpKeyword(KeyWord);
    finally
      PyIDEMainForm.PythonKeywordHelpRequested := False;
      Application.HelpFile := OldHelpFile;
    end;
  end
  else if ExtractFileExt(PythonHelpFile) = '.html' then // python 11
  begin
    var
    Executable := ShellFindExecutable(PythonHelpFile, '');
    if Executable <> '' then
    begin
      var
      Args := Format('?q=%s&check_keywords=yes', [KeyWord]);
      var
      URI := FilePathToURI(ExtractFilePath(PythonHelpFile) +
        'search.html') + Args;
      Result := ShellExecute(0, 'open', PChar(Executable), PChar(URI), '',
        SW_SHOWNORMAL) > 32;
    end;
  end;
end;

procedure TCommandsDataModule.actHelpContentsExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpCommand(HELP_CONTENTS, 0);
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.ParameterCompletionCodeCompletion(Sender: TObject;
var Value: string; Shift: TShiftState; Index: Integer; EndToken: WideChar);
begin
  if ssCtrl in Shift then
    Value := Parameters.Values[Value]
  else
    Value := Parameters.MakeParameter(Value);
end;

procedure TCommandsDataModule.actParameterCompletionExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TCustomSynEdit then
  begin
    ResourcesDataModule.ParameterCompletion.Editor :=
      TCustomSynEdit(Screen.ActiveControl);
    ResourcesDataModule.ParameterCompletion.ActivateCompletion;
  end;
end;

procedure TCommandsDataModule.actModifierCompletionExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TCustomSynEdit then
  begin
    ResourcesDataModule.ModifierCompletion.Editor :=
      TCustomSynEdit(Screen.ActiveControl);
    ResourcesDataModule.ModifierCompletion.ActivateCompletion;
  end;
end;

procedure TCommandsDataModule.actReplaceParametersExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TCustomSynEdit then
    with TCustomSynEdit(Screen.ActiveControl) do
    begin
      var
      OldCaret := CaretXY;
      if SelAvail then
        SelText := Parameters.ReplaceInText(SelText)
      else
        try
          BeginUpdate;
          for var Line := 0 to Lines.Count - 1 do
          begin
            var
            SLine := Lines[Line];
            var
            MaskPos := AnsiPos(Parameters.StartMask, SLine);
            if MaskPos > 0 then
            begin
              BeginUndoBlock;
              try
                BlockBegin := BufferCoord(MaskPos, Line + 1);
                BlockEnd := BufferCoord(Length(SLine) + 1, Line + 1);
                SelText := Parameters.ReplaceInText
                  (Copy(SLine, MaskPos, MaxInt));
              finally
                EndUndoBlock;
              end;
            end;
          end;
        finally
          EndUpdate;
        end;
      CaretXY := OldCaret;
    end;
end;

procedure TCommandsDataModule.actInsertTemplateExecute(Sender: TObject);
var
  SynEdit: TSynEdit;
begin
  if (Screen.ActiveControl is TSynEdit) and Assigned(GI_ActiveEditor) then
  begin
    SynEdit := TSynEdit(Screen.ActiveControl);
    with ResourcesDataModule.CodeTemplatesCompletion do
      Execute(GetPreviousToken(SynEdit), SynEdit);
  end;
end;

procedure TCommandsDataModule.actHelpParametersExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpJump('parameters');
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.actHelpExternalToolsExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpJump('externaltools');
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.actHelpEditorShortcutsExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpJump('editorshortcuts');
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.actConfigureToolsExecute(Sender: TObject);
begin
  if EditCollection(ToolsCollection, TToolItem, _('Configure Tools'),
    EditToolItem, 710) then
  begin
    PyIDEMainForm.SetupToolsMenu;
    PyIDEMainForm.SetupCustomizer;
  end;
end;

procedure TCommandsDataModule.actEditCopyFileNameExecute(Sender: TObject);
var
  Editor: IEditor;
begin
  Editor := GI_PyIDEServices.ActiveEditor;
  if Assigned(Editor) then
    Clipboard.AsText := Editor.FileId;
end;

procedure TCommandsDataModule.actEditCopyRTFExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).CopyRTF;
end;

procedure TCommandsDataModule.actEditCopyRTFNumberedExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).CopyRTFNumbered;
end;

procedure TCommandsDataModule.actEditCopyHTMLExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
  begin
    GI_ActiveEditor.GetActiveSynEdit.Options :=
      GI_ActiveEditor.GetActiveSynEdit.Options - [eoCopyPlainText];
    TEditorForm(GI_ActiveEditor.Form).CopySelected;
    GI_ActiveEditor.GetActiveSynEdit.Options :=
      GI_ActiveEditor.GetActiveSynEdit.Options + [eoCopyPlainText];
  end;
end;

procedure TCommandsDataModule.actEditCopyHTMLasTextExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).CopyHTML(True);
end;

procedure TCommandsDataModule.actEditCopyNumberedExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).CopyNumbered;
end;

procedure TCommandsDataModule.actEditCreateStructogramExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).CreateStructogram;
end;

procedure TCommandsDataModule.actFindFunctionExecute(Sender: TObject);
begin
  JumpToFunction;
end;

procedure TCommandsDataModule.actEditLineNumbersExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.Gutter.ShowLineNumbers :=
      not GI_ActiveEditor.ActiveSynEdit.Gutter.ShowLineNumbers;
end;

procedure TCommandsDataModule.actEditWordWrapExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.WordWrap :=
      not GI_ActiveEditor.ActiveSynEdit.WordWrap
  else if GI_PyInterpreter.Editor.Focused then
    GI_PyInterpreter.Editor.WordWrap := not GI_PyInterpreter.Editor.WordWrap;
end;

procedure TCommandsDataModule.actEditShowSpecialCharsExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
  begin
    var
    VisibleSpecialChars := GI_ActiveEditor.ActiveSynEdit.VisibleSpecialChars;
    if VisibleSpecialChars = [] then
      GI_ActiveEditor.ActiveSynEdit.VisibleSpecialChars :=
        [scWhitespace, scControlChars, scEOL]
    else
      GI_ActiveEditor.ActiveSynEdit.VisibleSpecialChars := [];
  end
  else if GI_PyInterpreter.Editor.Focused then
  begin
    var
    VisibleSpecialChars := GI_PyInterpreter.Editor.Options;
    if VisibleSpecialChars = [] then
      GI_PyInterpreter.Editor.VisibleSpecialChars :=
        [scWhitespace, scControlChars, scEOL]
    else
      GI_PyInterpreter.Editor.VisibleSpecialChars := [];
  end;
end;

procedure TCommandsDataModule.actFindNextReferenceExecute(Sender: TObject);
var
  SearchOptions: TSynSearchOptions;
  SearchText: string;
  OldCaret: TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then
    with GI_ActiveEditor.ActiveSynEdit do
    begin
      SearchText := WordAtCursor;
      if SearchText <> '' then
      begin
        OldCaret := CaretXY;

        SearchEngine := SynEditSearch;
        SearchOptions := [];
        if (Sender as TComponent).Tag = 1 then
          Include(SearchOptions, ssoBackwards)
        else
          CaretX := CaretX + 1; // So that we find the next identifier
        Include(SearchOptions, ssoMatchCase);
        Include(SearchOptions, ssoWholeWord);
        GI_PyIDEServices.WriteStatusMsg('');
        if SearchReplace(SearchText, '', SearchOptions) = 0 then
        begin
          CaretXY := OldCaret;
          MessageBeep(MB_ICONASTERISK);
          GI_PyIDEServices.WriteStatusMsg(Format(_(SNotFound), [SearchText]));
        end
        else
        begin
          CaretXY := BlockBegin;
        end;
      end;
    end;
end;

procedure TCommandsDataModule.actFoldAllExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.CollapseAll;
end;

procedure TCommandsDataModule.actFoldClassesExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.CollapseFoldType(Integer(pftClassDefType));
end;

procedure TCommandsDataModule.actFoldFunctionsExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.CollapseFoldType(Integer(pftFunctionDefType));
end;

procedure TCommandsDataModule.actFoldLevel1Execute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecFoldLevel1, ' ', nil);
end;

procedure TCommandsDataModule.actFoldLevel2Execute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecFoldLevel2, ' ', nil);
end;

procedure TCommandsDataModule.actFoldLevel3Execute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecFoldLevel3, ' ', nil);
end;

procedure TCommandsDataModule.actFoldNearestExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecFoldNearest, ' ', nil);
end;

procedure TCommandsDataModule.actFoldRegionsExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecFoldRegions, ' ', nil);
end;

procedure TCommandsDataModule.actFoldVisibleExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.UseCodeFolding :=
      not GI_ActiveEditor.ActiveSynEdit.UseCodeFolding;
end;

procedure TCommandsDataModule.actCheckForUpdatesExecute(Sender: TObject);
begin
  with TFUpdate.Create(Self) do
  begin
    EOldVersion.Text := Version + ', ' + GetVersionDate;
    ENewVersion.Text := '';
    Memo.Lines.Clear;
    ProgressBar.Position := 0;
    ShowModal;
  end;
end;

procedure TCommandsDataModule.actClearIssuesExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    (GI_ActiveEditor as TEditor).ClearDiagnostics;
end;

procedure TCommandsDataModule.actCodeActionExecute(Sender: TObject);
begin
  Tag := (Sender as TSpTBXItem).Tag;
  if Assigned(TPyLspClient.CodeActions) and
    InRange(Tag, 0, High(TPyLspClient.CodeActions.codeActions))
  then
    ApplyWorkspaceEdit(TPyLspClient.CodeActions.codeActions[Tag].edit);
end;

procedure TCommandsDataModule.actCodeCheckExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.PullDiagnostics;
end;

procedure TCommandsDataModule.actCommandLineExecute(Sender: TObject);
begin
  TCommandLineDlg.Execute;
end;

procedure TCommandsDataModule.actFileExitExecute(Sender: TObject);
begin
  Application.MainForm.Close;
end;

procedure TCommandsDataModule.actFormatCodeExecute(Sender: TObject);
begin
  var Editor := GI_ActiveEditor;
  if Assigned(Editor) and Editor.HasPythonFile then
    TPyLspClient.FormatCode(Editor.FileId, Editor.ActiveSynEdit);
end;

procedure TCommandsDataModule.actNextIssueExecute(Sender: TObject);
begin
  if  Assigned(GI_ActiveEditor) then
    (GI_ActiveEditor as TEditor).NextDiagnostic;
end;

procedure TCommandsDataModule.actPreviousIssueExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    (GI_ActiveEditor as TEditor).PreviousDiagnostic;
end;

procedure TCommandsDataModule.actToolsRestartLSExecute(Sender: TObject);
begin
  TPyLspClient.RestartServers;
end;

procedure TCommandsDataModule.actFixAllExecute(Sender: TObject);
begin
  var Editor := GI_ActiveEditor;
  if Assigned(Editor) and Editor.HasPythonFile then
    TPyLspClient.DiagnosticsLspClient.ExecuteCommand('ruff.applyAutofix',
      Editor.FileId, Editor.Version);
end;

procedure TCommandsDataModule.actNavEditorExecute(Sender: TObject);
begin
  var Editor := GI_PyIDEServices.GetActiveEditor;
  if Assigned(Editor) then
    Editor.Activate;
end;

procedure TCommandsDataModule.actNavigateToDockWindow(Sender: TObject);
begin
  var DockForm := IDEDockForm(TIDEDockWindowKind((Sender as TAction).Tag));
  if Assigned(DockForm) then
    GI_PyIDEServices.ShowIDEDockForm(DockForm);
end;

procedure TCommandsDataModule.actOrganizeImportsExecute(Sender: TObject);
begin
  var Editor := GI_ActiveEditor;
  if Assigned(Editor) and Editor.HasPythonFile then
    TPyLspClient.DiagnosticsLspClient.ExecuteCommand('ruff.applyOrganizeImports',
      Editor.FileId, Editor.Version);
end;

procedure TCommandsDataModule.actRefactorRenameExecute(Sender: TObject);
begin
var
  BB, BE: TBufferCoord;
begin
  var Editor := GI_ActiveEditor;
  if not Assigned(Editor) or not Editor.HasPythonFile then Exit;
  var SynEdit := Editor.ActiveSynEdit;

  var Client := TPyLspClient.MainLspClient;
  if Client.LspClient.IsRequestSupported(lspPrepareRename) then
  begin
    var PrepRenameRes := Client.PrepareRename(Editor.FileId, SynEdit.CaretXY);
    if not Assigned(PrepRenameRes) then
    begin
      GI_PyIDEServices.WriteStatusMsg(_('Cannot perform rename'));
      Exit;
    end;
    BufferCoordinatesFromLspRange(PrepRenameRes.range, BB, BE);
    if BB <> BE then
      SynEdit.SetCaretAndSelection(BE, BB, BE)
    else
      SynEdit.ExecuteCommand(ecSelWord);
  end
  else
    SynEdit.ExecuteCommand(ecSelWord);

  var NewName := SynEdit.WordAtCursor;
  if not InputQuery(_('Rename'), _('New name')+':', NewName) then
    Exit;

  var Edit := Client.Rename(Editor.FileId, NewName, SynEdit.CaretXY);
  if not Assigned(Edit) then
    GI_PyIDEServices.WriteStatusMsg(_('Cannot perform rename'))
  else
    try
      ApplyWorkspaceEdit(Edit);
    finally
      Edit.Free;
    end;
  end;
end;

procedure TCommandsDataModule.actShowRefactorMenuExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile then
    GI_ActiveEditor.ShowRefactoringMenu;
end;

{$ENDREGION 'Action Execute Handlers'}

{$REGION 'Action Update Handlers'}

procedure TCommandsDataModule.UpdateActionAlwaysEnabled(Sender: TObject);
begin
  TAction(Sender).Enabled := True;
end;

procedure TCommandsDataModule.UpdateAssistantActions(Sender: TObject);
begin
  var SelAvail := Assigned(GI_ActiveEditor) and GI_ActiveEditor.ActiveSynEdit.SelAvail;
  var HasPython := Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile;
  if Sender = actAssistantCancel then
    actAssistantCancel.Enabled := LLMAssistant.IsBusy
  else
  begin
    TAction(Sender).Enabled := HasPython and not LLMAssistant.IsBusy;
    if Sender = actAssistantSuggest then
      TAction(Sender).Enabled := TAction(Sender).Enabled and not SelAvail
    else
      TAction(Sender).Enabled := TAction(Sender).Enabled and SelAvail
  end;
end;

procedure TCommandsDataModule.UpdateCodeFoldingActions(Sender: TObject);
begin
  var HasFold := Assigned(GI_ActiveEditor) and
    GI_ActiveEditor.SynEdit.UseCodeFolding;
  if Sender = actFoldVisible then
  begin
    actFoldVisible.Enabled := Assigned(GI_ActiveEditor);
    actFoldVisible.Checked := HasFold;
  end
  else
    TAction(Sender).Enabled := HasFold;
end;

procedure TCommandsDataModule.UpdateEditActions(Sender: TObject);
begin
  var ReadOnly := Assigned(GI_ActiveEditor) and GI_ActiveEditor.SynEdit.ReadOnly;
  if Sender = actEditLineNumbers then
  begin
    actEditLineNumbers.Enabled := Assigned(GI_ActiveEditor);
    actEditLineNumbers.Checked := Assigned(GI_ActiveEditor) and
      GI_ActiveEditor.ActiveSynEdit.Gutter.ShowLineNumbers;
  end
  else if Sender = actEditReadOnly then
    actEditReadOnly.Checked := ReadOnly
  else if Sender = actEditWordWrap then
  begin
    actEditWordWrap.Enabled := Assigned(GI_ActiveEditor) and
      not GI_ActiveEditor.ActiveSynEdit.UseCodeFolding or
      GI_PyInterpreter.Editor.Focused;
    actEditWordWrap.Checked := Assigned(GI_ActiveEditor) and
      GI_ActiveEditor.ActiveSynEdit.WordWrap or
      GI_PyInterpreter.Editor.Focused and GI_PyInterpreter.Editor.WordWrap;
  end
  else if Sender = actEditShowSpecialChars then
  begin
    actEditShowSpecialChars.Enabled := Assigned(GI_ActiveEditor) or
      GI_PyInterpreter.Editor.Focused;
    actEditShowSpecialChars.Checked := Assigned(GI_ActiveEditor) and
      not (GI_ActiveEditor.ActiveSynEdit.VisibleSpecialChars = []);
  end
  else if Sender = actInsertTemplate then
    actInsertTemplate.Enabled := Assigned(GI_ActiveEditor);
end;

procedure TCommandsDataModule.UpdateEncodingActions(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(GI_ActiveEditor);
  if TAction(Sender).Enabled then
  begin
    var Encoding := GI_ActiveEditor.FileEncoding;
    if Sender = actEditAnsi then
      actEditAnsi.Checked := Encoding = sf_Ansi
    else if Sender = actEditUTF8 then
      actEditUTF8.Checked := Encoding = sf_UTF8
    else if Sender = actEditUTF8NoBOM then
      actEditUTF8NoBOM.Checked := Encoding = sf_UTF8_NoBOM
    else if Sender = actEditUTF16LE then
      actEditUTF16LE.Checked := Encoding = sf_UTF16LE
    else if Sender = actEditUTF16BE then
      actEditUTF16BE.Checked := Encoding = sf_UTF16BE;
  end
  else
    TAction(Sender).Checked := False;
end;

procedure TCommandsDataModule.UpdateFileActions(Sender: TObject);
begin
  var HaveFile := Assigned(GI_FileCmds);
  if Sender = actFileClose then
    actFileClose.Enabled := HaveFile and GI_FileCmds.CanClose
  else if Sender = actFileSave then
    actFileSave.Enabled := HaveFile and GI_FileCmds.CanSave
  else if Sender = actFileSaveAs then
    actFileSaveAs.Enabled := HaveFile
  else if Sender = actFileSaveToRemote then
    actFileSaveToRemote.Enabled := HaveFile
  else if Sender = actFilePrint then
    actFilePrint.Enabled := HaveFile
  else if Sender = actPrintPreview then
    actPrintPreview.Enabled := HaveFile
  else if Sender = actFileReload then
    actFileReload.Enabled := HaveFile and GI_FileCmds.CanReload
  else if Sender = actFileSaveAll then
    // Lesson to remember do not change the Enabled state of an Action from false to true
    // and back within an Update or OnIdle handler. The result is 100% CPU utilisation.
    actFileSaveAll.Enabled := Assigned(GI_EditorFactory.FirstEditorCond(
      function(Ed: IEditor): Boolean
      begin
        Result := (Ed as IFileCommands).CanSave;
      end));
end;

procedure TCommandsDataModule.UpdateLineBreakActions(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(GI_ActiveEditor);
  if TAction(Sender).Enabled then
  begin
    var Fmt := (GI_ActiveEditor.SynEdit.Lines as TSynEditStringList).FileFormat;
    if Sender = actEditLBDos then
      actEditLBDos.Checked := Fmt = sffDos
    else if Sender = actEditLBUnix then
      actEditLBUnix.Checked := Fmt = sffUnix
    else if Sender = actEditLBMac then
      actEditLBMac.Checked := Fmt = sffMac;
  end
  else
    TAction(Sender).Checked := False;
end;

procedure TCommandsDataModule.UpdateParameterActions(Sender: TObject);
begin
  TAction(Sender).Enabled := Screen.ActiveControl is TCustomSynEdit;;
end;

procedure TCommandsDataModule.UpdateRefactorActions(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(GI_ActiveEditor)
    and GI_ActiveEditor.HasPythonFile and not GI_ActiveEditor.SynEdit.ReadOnly;
end;

procedure TCommandsDataModule.UpdateRunActions(Sender: TObject);
begin
  if Sender = actCommandLine then
    actCommandLine.Checked := CommandLineParams <> '';
end;

procedure TCommandsDataModule.UpdateSearchActions(Sender: TObject);
begin
  if Sender = actSearchMatchingBrace then
    actSearchMatchingBrace.Enabled := Assigned(GI_ActiveEditor)
  else if Sender = actSearchMatchingBrace then
    actSearchGoToLine.Enabled := Assigned(actSearchGoToLine)
  else if Sender = actSearchGoToSyntaxError then
    actSearchGoToSyntaxError.Enabled := Assigned(GI_ActiveEditor) and
      TEditorForm(GI_ActiveEditor.Form).HasSyntaxError
  else if Sender = actSearchHighlight then
  begin
    var Editor := GI_PyIDEServices.ActiveEditor;
    actSearchHighlight.Enabled := actSearchHighlight.Checked or
      Assigned(Editor) and (EditorSearchOptions.SearchText <> '');
    actSearchHighlight.Checked := Assigned(Editor) and Editor.HasSearchHighlight;
  end
  else if Sender = actSearchGoToDebugLine then
    actSearchGoToDebugLine.Enabled := (GI_PyControl.CurrentPos.Line >= 1) and
     GI_PyControl.PythonLoaded and not GI_PyControl.Running
  else if Sender = actFindInFiles then
    actFindInFiles.Enabled := not FindResultsWindow.IsBusy
  else if Sender = actFindFunction then
    actFindFunction.Enabled := Assigned(GI_ActiveEditor) and
      GI_ActiveEditor.HasPythonFile
  else if (Sender = actFindNextReference) or (Sender = actFindPreviousReference) then
    actFindNextReference.Enabled := Assigned(GI_ActiveEditor)
  else
  begin
    var SearchCommands := FindSearchTarget;
    if Sender = actSearchFind then
      actSearchFind.Enabled := (SearchCommands <> nil) and
        SearchCommands.CanFind
    else if (Sender = actSearchFindNext) or (Sender = actSearchFindPrev) then
      TAction(Sender).Enabled := (SearchCommands <> nil) and
        SearchCommands.CanFindNext
    else if Sender = actSearchReplace then
      actSearchReplace.Enabled := (SearchCommands <> nil) and
        SearchCommands.CanReplace
    else if Sender = actSearchReplaceNow then
      actSearchReplaceNow.Enabled := (SearchCommands <> nil) and
        SearchCommands.CanFindNext and SearchCommands.CanReplace;
  end;
end;

procedure TCommandsDataModule.UpdateIssuesActions(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(GI_ActiveEditor) and
    GI_ActiveEditor.HasPythonFile;
end;

procedure TCommandsDataModule.UpdateSourceCodeActions(Sender: TObject);
begin
  var ReadOnly := Assigned(GI_ActiveEditor) and GI_ActiveEditor.SynEdit.ReadOnly;
  var SelAvail := Assigned(GI_ActiveEditor) and GI_ActiveEditor.ActiveSynEdit.SelAvail;
  if (Sender = actEditIndent)  or (Sender = actEditDedent)then
    TAction(Sender).Enabled := SelAvail and not ReadOnly
  else if (Sender = actEditTabify)  or (Sender = actEditUntabify) then
    TAction(Sender).Enabled := not ReadOnly
  else if (Sender = actEditCommentOut)  or (Sender = actEditUncomment) or
    (Sender = actEditToggleComment)
  then
    TAction(Sender).Enabled := Assigned(GI_ActiveEditor) and not ReadOnly
  else if Sender = actFormatCode then
    actFormatCode.Enabled := not ReadOnly and GI_ActiveEditor.HasPythonFile;
end;

procedure TCommandsDataModule.UpdateToolsActions(Sender: TObject);
begin
  if Sender = actPythonPath then
    actPythonPath.Enabled := GI_PyControl.PythonLoaded
  else if Sender = actUnitTestWizard then
    actUnitTestWizard.Enabled := Assigned(GI_ActiveEditor) and
      GI_ActiveEditor.HasPythonFile;
end;

{$ENDREGION 'Action Update Handlers'}

procedure TCommandsDataModule.GetEditorUserCommand(AUserCommand: Integer;
var ADescription: string);
begin
  if AUserCommand = ecCodeCompletion then
    ADescription := _(SEdCmdCodeCompletion)
  else if AUserCommand = ecParamCompletion then
    ADescription := _(SEdCmdParameterCompletion);
end;

procedure TCommandsDataModule.GetEditorAllUserCommands(ACommands: TStrings);
begin
  ACommands.AddObject(_(SEdCmdCodeCompletion), TObject(ecCodeCompletion));
  ACommands.AddObject(_(SEdCmdParameterCompletion), TObject(ecParamCompletion));
  ACommands.AddObject(_(SEdCmdSelectToBracket), TObject(ecSelMatchBracket));
end;

function TCommandsDataModule.DoSearchReplaceText(SynEdit: TSynEdit;
AReplace, ABackwards: Boolean; IsIncremental: Boolean = False): Integer;

  function EndReached(ABackwards, SelectionOnly: Boolean): string;
  begin
    if ABackwards then
      Result := Format(_(SReachedTheStart),
        [IfThen(SelectionOnly, _(SOfTheSelection), _(SOfTheDocument))])
    else
      Result := Format(_(SReachedTheEnd),
        [IfThen(SelectionOnly, _(SOfTheSelection), _(SOfTheDocument))]);
  end;

var
  Options: TSynSearchOptions;
  IsNewSearch: Boolean;
  MsgText: string;
  BB, BE: TBufferCoord;
  dlgID: Integer;
  OldNoReplaceCount: Integer;
begin
  Result := 0;
  OldNoReplaceCount := 0;

  if EditorSearchOptions.SearchText = '' then
    Exit; // Nothing to Search
  if PyIDEOptions.AutoHideFindToolbar and not IsIncremental then
  begin
    PyIDEMainForm.FindToolbar.Visible := False;
  end;
  if EditorSearchOptions.UseRegExp then
    SynEdit.SearchEngine := SynEditRegexSearch
  else
    SynEdit.SearchEngine := SynEditSearch;

  IsNewSearch := (not EditorSearchOptions.InitCaretXY.IsValid) or
    (EditorSearchOptions.BackwardSearch <> ABackwards);
  if IsNewSearch then
    EditorSearchOptions.NewSearch(SynEdit, ABackwards);

  if AReplace then
  begin
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll];
    EditorSearchOptions.NoReplaceCount := 0;
  end
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  case EditorSearchOptions.SearchCaseSensitiveType of
    scsAuto:
      if LowerCase(EditorSearchOptions.SearchText) <> EditorSearchOptions.SearchText
      then
        Include(Options, ssoMatchCase);
    scsCaseSensitive:
      Include(Options, ssoMatchCase);
  end;
  if EditorSearchOptions.SearchWholeWords then
    Include(Options, ssoWholeWord);

  with EditorSearchOptions do
    if EditorSearchOptions.TempSelectionOnly then
    begin
      Options := Options + [ssoSelectedOnly] - [ssoEntireScope];
      BE := TBufferCoord.Invalid;
      if IsNewSearch then
        BB := TBufferCoord.Invalid
      else
      begin
        BB := SynEdit.CaretXY;
        SynEdit.Selections.Restore(SelStorage);
      end;
    end
    else if WrappedSearch then
    begin
      if ABackwards then
      begin
        BB := InitCaretXY;
        if CanWrapSearch then
          BE := BufferCoord(Length(SynEdit.Lines[SynEdit.Lines.Count - 1]) + 1,
            SynEdit.Lines.Count)
        else
          BE := SynEdit.CaretXY;
      end
      else
      begin
        BE := InitCaretXY;
        if CanWrapSearch then
          BB := BufferCoord(1, 1)
        else
          BB := SynEdit.CaretXY;
      end;
      CanWrapSearch := False; // Do not wrap again!
    end
    else
    begin
      BB := BufferCoord(1, 1);
      BE := BufferCoord(Length(SynEdit.Lines[SynEdit.Lines.Count - 1]) + 1,
        SynEdit.Lines.Count);
      if TempSearchFromCaret then
      begin
        if ABackwards then
          BE := SynEdit.CaretXY
        else
          BB := SynEdit.CaretXY;
      end;
    end;

  GI_PyIDEServices.WriteStatusMsg('');

  if EditorSearchOptions.TempSelectionOnly and SynEdit.Selections.IsEmpty then
    Result := 0
  else
    try
      Result := SynEdit.SearchReplace(EditorSearchOptions.SearchText,
        EditorSearchOptions.ReplaceText, Options, BB, BE);
    except
      on E: ESynRegEx do
      begin
        Result := 0;
        MessageBeep(MB_ICONERROR);
        GI_PyIDEServices.WriteStatusMsg(Format(_(SInvalidRegularExpression),
          [E.Message]));
        Exit;
      end;
    end;

  with EditorSearchOptions do
  begin
    // Further searches will be from caret. Only applies if not SelectionOnly
    TempSearchFromCaret := True;

    if (Result = 0) or (ssoReplace in Options) then
    // We have reached the end of the search range
    begin
      MessageBeep(MB_ICONASTERISK);
      if TempSelectionOnly and not AReplace then
        // All done - Restore the original selection
        SynEdit.Selections.Restore(SelStorage);

      if WrappedSearch then
      begin
        MsgText := _(SStartReached);
        GI_PyIDEServices.WriteStatusMsg(MsgText);
        DSAMessageDlg(dsaSearchStartReached, 'GuiPy', MsgText, mtInformation,
          [mbOK], 0, dckActiveForm, 0, mbOK);
        InitSearch;
      end
      else
      begin
        MsgText := EndReached(ABackwards, TempSelectionOnly);
        if Result = 0 then
          GI_PyIDEServices.WriteStatusMsg(Format(_(SNotFound), [SearchText]))
        else
          GI_PyIDEServices.WriteStatusMsg(MsgText);
        if CanWrapSearch and (LastReplaceAction <> raCancel) then
        begin
          dlgID := IfThen(ssoReplace in Options, dsaReplaceFromStart,
            dsaSearchFromStart);
          MsgText := Format(MsgText + sLineBreak + _(SContinueSearch),
            [IfThen(ssoReplace in Options, _(STheSearchAndReplace),
            _(STheSearch)), IfThen(ABackwards, _(SFromTheEnd),
            _(SFromTheStart))]);

          if IsIncremental or
            (DSAMessageDlg(dlgID, 'GuiPy', MsgText, mtConfirmation,
            [mbYes, mbNo], 0, dckActiveForm, 0, mbYes, mbNo) = mrYes) then
          begin
            WrappedSearch := True;
            OldNoReplaceCount := NoReplaceCount;
            Result := Result + DoSearchReplaceText(SynEdit, AReplace,
              ABackwards, IsIncremental);
            WrappedSearch := False;
          end;
        end
        else
        begin
          MsgText := _(SStartReached);
          if (Result = 0) and not(ssoReplace in Options) then
            GI_PyIDEServices.WriteStatusMsg(Format(_(SNotFound), [SearchText]))
          else
            GI_PyIDEServices.WriteStatusMsg(MsgText);
          InitSearch;
        end;
      end;
    end;

    if (ssoReplace in Options) and (Result > 0) and not WrappedSearch then
    begin
      MsgText := Format(_(SItemsReplaced),
        [Result + NoReplaceCount + OldNoReplaceCount, Result]);
      GI_PyIDEServices.WriteStatusMsg(MsgText);
      DSAMessageDlg(dsaReplaceNumber, 'GuiPy', MsgText, mtInformation, [mbOK],
        0, dckActiveForm, 0, mbOK);
    end;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

function TCommandsDataModule.FindSearchTarget: ISearchCommands;
var
  Editor: IEditor;
begin
  Result := GI_SearchCmds;
  if not Assigned(GI_SearchCmds) then
  begin
    if EditorSearchOptions.InterpreterIsSearchTarget and
      CanActuallyFocus(GI_PyInterpreter.Editor) then
      Result := GI_PyInterpreter as ISearchCommands
    else if EditorSearchOptions.TextDiffIsSearchTarget then
      Result := GI_PyIDEServices.GetActiveTextDiff
    else
    begin
      Editor := GI_PyIDEServices.ActiveEditor;
      if Assigned(Editor) then
        Result := Editor as ISearchCommands
    end;
  end;
end;

procedure TCommandsDataModule.HighlightCheckedImg(Sender: TObject;
  ACanvas: TCanvas; State: TSpTBXSkinStatesType;
  const PaintStage: TSpTBXPaintStage; var AImageList: TCustomImageList;
  var AImageIndex: Integer; var ARect: TRect; var PaintDefault: Boolean);
begin
  if (PaintStage = pstPrePaint) and (Sender as TSpTBXItem).Checked then
  begin
    ACanvas.Brush.Color := StyleServices.GetSystemColor(clHighlight);
    ACanvas.FillRect(ARect);
  end;
  PaintDefault := True;
end;

procedure TCommandsDataModule.mnSpellingPopup(Sender: TTBCustomItem;
FromLink: Boolean);
var
  Error: ISpellingError;
  CorrectiveAction: CORRECTIVE_ACTION;
  Replacement: PChar;
  MenuItem: TTBCustomItem;
  Action: TSynSpellErrorReplace;
  Suggestions: IEnumString;
  Suggestion: PWideChar;
  Fetched: LongInt;
  Indicator: TSynIndicator;
  AWord: string;
  HaveError: Boolean;
  Editor: TCustomSynEdit;
begin
  Editor := SynSpellCheck.Editor;
  if not Assigned(Editor) then
    Exit;

  // Remove replacement menu items and actions;
  repeat
    MenuItem := mnSpelling.Items[0];
    if MenuItem.Action is TSynSpellErrorReplace then
    begin
      mnSpelling.Remove(MenuItem);
      MenuItem.Action.Free;
      MenuItem.Free;
    end
    else
      Break;
  until (False);

  if not Assigned(SynSpellCheck.SpellChecker()) then
  begin
    mnSpelling.Visible := False;
    Exit;
  end;

  if Editor.Indicators.IndicatorAtPos(Editor.CaretXY,
    TSynSpellCheck.SpellErrorIndicatorId, Indicator) then
    AWord := Copy(Editor.Lines[Editor.CaretY - 1], Indicator.CharStart,
      Indicator.CharEnd - Indicator.CharStart)
  else
    AWord := '';

  // SynSpellCheck.Editor := Editor;
  Error := SynSpellCheck.ErrorAtPos(Editor.CaretXY);
  HaveError := Assigned(Error) and (AWord <> '');

  mnSpellCheckTopSeparator.Visible := HaveError;
  mnSpellCheckSecondSeparator.Visible := HaveError;
  mnSpellCheckAdd.Visible := HaveError;
  mnSpellCheckIgnore.Visible := HaveError;
  mnSpellCheckIgnoreOnce.Visible := HaveError;
  mnSpellCheckDelete.Visible := HaveError;

  if HaveError then
  begin
    Error.Get_CorrectiveAction(CorrectiveAction);
    case CorrectiveAction of
      CORRECTIVE_ACTION_GET_SUGGESTIONS:
        begin
          CheckOSError(SynSpellCheck.SpellChecker.Suggest(PChar(AWord),
            Suggestions));
          while Suggestions.Next(1, Suggestion, @Fetched) = S_OK do
          begin
            Action := TSynSpellErrorReplace.Create(Self);
            Action.Caption := Suggestion;
            MenuItem := TSpTBXItem.Create(Self);
            MenuItem.Action := Action;
            mnSpelling.Insert(mnSpelling.IndexOf(mnSpellCheckTopSeparator),
              MenuItem);
            CoTaskMemFree(Suggestion);
          end;
        end;
      CORRECTIVE_ACTION_REPLACE:
        begin
          Error.Get_Replacement(Replacement);
          Action := TSynSpellErrorReplace.Create(Self);
          Action.Caption := Replacement;
          MenuItem := TSpTBXItem.Create(Self);
          MenuItem.Action := Action;
          mnSpelling.Insert(0, MenuItem);
        end;
    end;
  end;
end;

procedure TCommandsDataModule.ShowSearchReplaceDialog(SynEdit: TSynEdit;
AReplace: Boolean);
var
  Str: string;
begin
  EditorSearchOptions.InitSearch;
  with PyIDEMainForm do
  begin
    tbiReplaceSeparator.Visible := AReplace;
    tbiReplaceLabel.Visible := AReplace;
    tbiReplaceText.Visible := AReplace;
    tbiReplaceExecute.Visible := AReplace;
    if AReplace then
    begin
      tbiReplaceText.Text := EditorSearchOptions.ReplaceText;
      tbiReplaceText.Items.CommaText := EditorSearchOptions.ReplaceTextHistory;
      PyIDEMainForm.tbiReplaceTextChange(Self);
    end;
    FindToolbar.Visible := True;
    FindToolbar.View.CancelMode;
    // start with last search text
    tbiSearchText.Text := EditorSearchOptions.SearchText;
    if EditorSearchOptions.SearchTextAtCaret then
    begin
      // if something is selected search for that text
      if SynEdit.SelAvail and (SynEdit.BlockBegin.Line = SynEdit.BlockEnd.Line)
      then
        tbiSearchText.Text := SynEdit.SelText
      else
      begin
        Str := SynEdit.WordAtCursor;
        if Str <> '' then
          tbiSearchText.Text := Str;
      end;
    end;
    tbiSearchText.Items.CommaText := EditorSearchOptions.SearchTextHistory;
    PyIDEMainForm.tbiSearchTextChange(Self);

    if CanActuallyFocus(tbiSearchText) then
      tbiSearchText.SetFocus;
  end;
end;

procedure TCommandsDataModule.SynEditReplaceText(Sender: TObject;
const ASearch, AReplace: string; Line, Column: Integer;
var Action: TSynReplaceAction);
var
  APos: TPoint;
  EditRect: TRect;
  SynEdit: TSynEdit;
begin
  SynEdit := Sender as TSynEdit;
  if ASearch = AReplace then
    Action := raSkip
  else
  begin
    APos := SynEdit.ClientToScreen
      (SynEdit.RowColumnToPixels(SynEdit.BufferToDisplayPos
      (BufferCoord(Column, Line))));
    EditRect := SynEdit.ClientToScreen(SynEdit.ClientRect);

    if ConfirmReplaceDialog = nil then
    begin
      ConfirmReplaceDialog := TConfirmReplaceDialog.Create(Application);
      ConfirmReplaceDialog.btnReplaceAll.ModalResult := mrYesToAll;
      // http://www.bobswart.nl/Weblog/Blog.aspx?RootId=5:5029
      fConfirmReplaceDialogRect := ConfirmReplaceDialog.BoundsRect;
    end;
    if EqualRect(fConfirmReplaceDialogRect, ConfirmReplaceDialog.BoundsRect)
    then
    begin
      ConfirmReplaceDialog.PrepareShow(EditRect, APos.X, APos.Y,
        APos.Y + SynEdit.LineHeight, ASearch);
      fConfirmReplaceDialogRect := ConfirmReplaceDialog.BoundsRect;
    end
    else
      fConfirmReplaceDialogRect := Rect(0, 0, 0, 0);

    case ConfirmReplaceDialog.ShowModal of
      mrYes:
        Action := raReplace;
      mrYesToAll:
        Action := raReplaceAll;
      mrNo:
        Action := raSkip;
    else
      Action := raCancel;
    end;
  end;
  EditorSearchOptions.LastReplaceAction := Action;
  if Action in [raSkip, raCancel] then
    Inc(EditorSearchOptions.NoReplaceCount);
end;

function TCommandsDataModule.ProgramVersionHTTPLocationLoadFileFromRemote
  (AProgramVersionLocation: TJvProgramVersionHTTPLocation;
const ARemotePath, ARemoteFileName, ALocalPath, ALocalFileName: string): string;
var
  LocalFileName, URL: string;
begin
  Result := '';
  if (DirectoryExists(ALocalPath) or (ALocalPath = '')) then
    if ALocalFileName = '' then
      LocalFileName := TPath.Combine(ALocalPath, ARemoteFileName)
    else
      LocalFileName := TPath.Combine(ALocalPath, ALocalFileName)
  else
    Exit;

  if Copy(ARemotePath, Length(ARemotePath), 1) <> '/' then
    URL := ARemotePath + '/' + ARemoteFileName
  else
    URL := ARemotePath + ARemoteFileName;

  GI_PyIDEServices.SetActivityIndicator(True, _('Downloading...'));
  try
    if DownloadUrlToFile(URL, LocalFileName) and FileExists(LocalFileName) then
      Result := LocalFileName
    else
    begin
      if FileExists(LocalFileName) then
        DeleteFile(LocalFileName);
      ProgramVersionHTTPLocation.DownloadError := _('File download failed');
    end;
  finally
    GI_PyIDEServices.SetActivityIndicator(False);
  end;
end;

procedure TCommandsDataModule.actProjectNewExecute(Sender: TObject);
begin
  GI_ProjectService.NewProject;
end;

procedure TCommandsDataModule.actProjectOpenExecute(Sender: TObject);
begin
  GI_ProjectService.OpenProject;
end;

procedure TCommandsDataModule.actProjectSaveAsExecute(Sender: TObject);
begin
  GI_ProjectService.SaveProjectAs;
end;

procedure TCommandsDataModule.actProjectSaveExecute(Sender: TObject);
begin
  GI_ProjectService.SaveProject;
end;

procedure TCommandsDataModule.PyIDEOptionsChanged(const Sender: TObject;
  const Msg: System.Messaging.TMessage);
begin
  // Syntax Code Completion
  SynCodeCompletion.Font.Assign(PyIDEOptions.AutoCompletionFont);
  with SynCodeCompletion do
  begin
    if PyIDEOptions.CodeCompletionCaseSensitive then
      Options := Options + [scoCaseSensitive]
    else
      Options := Options - [scoCaseSensitive];
    if PyIDEOptions.CompleteWithWordBreakChars then
      Options := Options + [scoEndCharCompletion]
    else
      Options := Options - [scoEndCharCompletion];

    TriggerChars := '.';
    TimerInterval := 200;
    if PyIDEOptions.CompleteAsYouType then
    begin
      for var I := ord('a') to ord('z') do
        TriggerChars := TriggerChars + Chr(I);
      for var I := ord('A') to ord('Z') do
        TriggerChars := TriggerChars + Chr(I);
      if PyIDEOptions.CompleteWithWordBreakChars or PyIDEOptions.CompleteWithOneEntry
      then
        TimerInterval := 500
    end;
  end;

  // Syntax Parameter Completion
  SynParamCompletion.Font.Assign(PyIDEOptions.AutoCompletionFont);

  // SpellCheck
  {
    SynSpellCheck.BeginUpdate;
    try
    SynSpellCheck.CheckAsYouType := PyIDEOptions.SpellCheckAsYouType;
    SynSpellCheck.AttributesChecked.CommaText := PyIDEOptions.SpellCheckedTokens;
    SynSpellCheck.LanguageCode := PyIDEOptions.DictLanguage;
    finally
    SynSpellCheck.EndUpdate;
    end;

    TThread.ForceQueue(nil, procedure
    begin
    if SynSpellCheck.SpellChecker = nil then
    DSAMessageDlg(dsaDictonaryNA, 'PyScripter',
    Format(_(SDictionaryNA),
    [CommandsDataModule.SynSpellCheck.LanguageCode]),
    mtInformation, [mbOK], 0, dckActiveForm, 0, mbOK);
    end);
  }
end;

procedure TCommandsDataModule.SynSpellCheckChange(Sender: TObject);
begin
  PyIDEOptions.SpellCheckAsYouType := SynSpellCheck.CheckAsYouType;
end;

class procedure TCommandsDataModule.RegisterActionList(ActionList: TActionList);
begin
  TActionProxyCollection.ActionLists := TActionProxyCollection.ActionLists +
    [ActionList];
end;


{ TSynGeneralSyn }

class function TSynGeneralSyn.GetFriendlyLanguageName: string;
begin
  Result := 'General'; // Do not localize
end;

initialization

// gettext stuff
// Classes that should not be translated
 TP_GlobalIgnoreClass(TCustomImageCollection);
TP_GlobalIgnoreClass(TSVGIconImage);
TP_GlobalIgnoreClass(TJvMultiStringHolder);
TP_GlobalIgnoreClass(TSynEdit);
TP_GlobalIgnoreClass(TSynCompletionProposal);
TP_GlobalIgnoreClass(TSynAutoComplete);
TP_GlobalIgnoreClass(TSpTBXMRUListItem);
TP_GlobalIgnoreClass(TSynCustomHighlighter);
TP_GlobalIgnoreClass(TCommonDialog);
TP_GlobalIgnoreClass(TJvProgramVersionCheck);
TP_GlobalIgnoreClass(TJvProgramVersionHTTPLocation);
TP_GlobalIgnoreClass(TJvCustomAppStorage);
TP_GlobalIgnoreClass(TPythonModule);
// VCL stuff
TP_GlobalIgnoreClass(TFont);
TP_GlobalIgnoreClassProperty(TCustomAction, 'Category');
TP_GlobalIgnoreClassProperty(TCustomAction, 'HelpKeyword');
TP_GlobalIgnoreClassProperty(TObject, 'ImageName');
TP_GlobalIgnoreClassProperty(TControl, 'HelpKeyword');
TP_GlobalIgnoreClassProperty(TControl, 'StyleName');
TP_GlobalIgnoreClassProperty(TBrowseURL, 'URL');

// JCL Debug
AddIgnoredException(EClipboardException);

end.
