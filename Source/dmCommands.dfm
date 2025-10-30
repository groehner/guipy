object CommandsDataModule: TCommandsDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 457
  Width = 774
  object SynEditPrint: TSynEditPrint
    Copies = 1
    Header.DefaultFont.Charset = DEFAULT_CHARSET
    Header.DefaultFont.Color = clBlack
    Header.DefaultFont.Height = -13
    Header.DefaultFont.Name = 'Arial'
    Header.DefaultFont.Style = []
    Footer.DefaultFont.Charset = DEFAULT_CHARSET
    Footer.DefaultFont.Color = clBlack
    Footer.DefaultFont.Height = -13
    Footer.DefaultFont.Name = 'Arial'
    Footer.DefaultFont.Style = []
    Margins.Left = 25.000000000000000000
    Margins.Right = 15.000000000000000000
    Margins.Top = 25.000000000000000000
    Margins.Bottom = 25.000000000000000000
    Margins.Header = 18.000000000000000000
    Margins.Footer = 18.000000000000000000
    Margins.LeftHFTextIndent = 2.000000000000000000
    Margins.RightHFTextIndent = 2.000000000000000000
    Margins.HFInternalMargin = 0.500000000000000000
    Margins.MirrorMargins = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabWidth = 8
    Color = clWhite
    Left = 260
    Top = 100
  end
  object SynEditSearch: TSynEditSearch
    Left = 163
    Top = 99
  end
  object SynEditRegexSearch: TSynEditRegexSearch
    Left = 57
    Top = 100
  end
  object ProgramVersionCheck: TJvProgramVersionCheck
    AllowedReleaseType = prtAlpha
    AppStoragePath = 'Check for Updates'
    CheckFrequency = 0
    LocalDirectory = 'Updates'
    LocalInstallerFileName = 'PyScripter-Setup.exe'
    LocalVersionInfoFileName = 'versioninfo.ini'
    LocationHTTP = ProgramVersionHTTPLocation
    LocationType = pvltHTTP
    UserOptions = [uoCheckFrequency, uoLocalDirectory, uoAllowedReleaseType, uoLocationHTTP]
    VersionHistoryFileOptions.INIOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    VersionHistoryFileOptions.INIOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    VersionHistoryFileOptions.INIOptions.SetAsString = True
    VersionHistoryFileOptions.INIOptions.FloatAsString = True
    VersionHistoryFileOptions.INIOptions.DefaultIfReadConvertError = True
    VersionHistoryFileOptions.XMLOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    VersionHistoryFileOptions.XMLOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    VersionHistoryFileOptions.XMLOptions.SetAsString = True
    VersionHistoryFileOptions.XMLOptions.FloatAsString = True
    VersionHistoryFileOptions.XMLOptions.DefaultIfReadConvertError = True
    VersionHistoryFileOptions.XMLOptions.UseOldItemNameFormat = False
    VersionHistoryFileOptions.XMLOptions.WhiteSpaceReplacement = '_'
    VersionHistoryFileOptions.XMLOptions.InvalidCharReplacement = '_'
    Left = 67
    Top = 23
  end
  object ProgramVersionHTTPLocation: TJvProgramVersionHTTPLocation
    OnLoadFileFromRemote = ProgramVersionHTTPLocationLoadFileFromRemote
    VersionInfoLocationPathList.Strings = (
      'https://raw.githubusercontent.com/pyscripter/pyscripter/master')
    VersionInfoFileName = 'PyScripterVersionInfo.ini'
    Left = 246
    Top = 24
  end
  object actlMain: TActionList
    Images = PyIDEMainForm.vilImages
    Left = 37
    Top = 181
    object actFileSave: TAction
      Category = 'File'
      Caption = '&Save'
      Enabled = False
      HelpContext = 310
      Hint = 'Save|Save active file'
      ImageIndex = 2
      ImageName = 'Save13'
      ShortCut = 16467
      OnExecute = actFileSaveExecute
      OnUpdate = UpdateFileActions
    end
    object actEditCut: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Enabled = False
      HelpContext = 320
      HelpType = htContext
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 9
      ImageName = 'Cut13'
      ShortCut = 16472
    end
    object actFileSaveAs: TAction
      Category = 'File'
      Caption = 'Sav&e As...'
      Enabled = False
      HelpContext = 310
      Hint = 'Save As|Save active file under different name'
      OnExecute = actFileSaveAsExecute
      OnUpdate = UpdateFileActions
    end
    object actFileClose: TAction
      Category = 'File'
      Caption = '&Close'
      Enabled = False
      HelpContext = 310
      Hint = 'Close|Close active file'
      ImageIndex = 92
      ImageName = 'TabCLose'
      ShortCut = 16499
      OnExecute = actFileCloseExecute
      OnUpdate = UpdateFileActions
    end
    object actEditCopy: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Enabled = False
      HelpContext = 320
      HelpType = htContext
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 10
      ImageName = 'Copy13'
      ShortCut = 16451
    end
    object actEditCopyRTF: TAction
      Category = 'Edit'
      Caption = 'RTF'
      Hint = 
        'Copy RTF|Copies the selection as RTF and puts it on the Clipboar' +
        'd'
      OnExecute = actEditCopyRTFExecute
    end
    object actEditCopyRTFNumbered: TAction
      Category = 'Edit'
      Caption = 'RTF numbered'
      Hint = 
        'Copy RTF numbered|Copies the selection as RTF numbered and puts ' +
        'it on the Clipboard'
      OnExecute = actEditCopyRTFNumberedExecute
    end
    object actEditCopyHTML: TAction
      Category = 'Edit'
      Caption = 'HTML'
      Hint = 
        'Copy HTML|Copies the selection as HTML and puts it on the Clipbo' +
        'ard'
      OnExecute = actEditCopyHTMLExecute
    end
    object actEditCopyHTMLasText: TAction
      Category = 'Edit'
      Caption = 'HTML as Text'
      Hint = 
        'Copy|Copies the selection as HTML as text and puts it on the Cli' +
        'pboard'
      OnExecute = actEditCopyHTMLasTextExecute
    end
    object actEditCopyNumbered: TAction
      Category = 'Edit'
      Caption = 'Numbered'
      Hint = 
        'Copy Numbered|Copies the selection numbered and puts it on the C' +
        'lipboard'
      OnExecute = actEditCopyNumberedExecute
    end
    object actEditPaste: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      HelpContext = 320
      HelpType = htContext
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 11
      ImageName = 'Paste13'
      ShortCut = 16470
    end
    object actEditDelete: TEditDelete
      Category = 'Edit'
      Caption = 'De&lete'
      Enabled = False
      HelpContext = 320
      HelpType = htContext
      Hint = 'Delete|Delete selection'
      ImageIndex = 12
      ImageName = 'Delete'
    end
    object actEditUndo: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Enabled = False
      HelpContext = 320
      HelpType = htContext
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 7
      ImageName = 'Undo13'
      ShortCut = 16474
    end
    object actEditRedo: TSynEditRedo
      Category = 'Edit'
      Caption = '&Redo'
      Hint = 'Redo| Redo last action'
      ImageIndex = 8
      ImageName = 'Redo13'
      ShortCut = 24666
    end
    object actEditSelectAll: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      HelpContext = 320
      HelpType = htContext
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object actInsertTemplate: TAction
      Category = 'Edit'
      Caption = 'Insert &Template'
      HelpContext = 320
      Hint = 'Insert a Code Template'
      ShortCut = 16458
      OnExecute = actInsertTemplateExecute
      OnUpdate = UpdateEditActions
    end
    object actEditCopyFileName: TAction
      Category = 'Edit'
      Caption = 'Copy File Name'
      HelpContext = 320
      HelpType = htContext
      Hint = 'Copy file name of active file to clipboard'
      ImageIndex = 10
      ImageName = 'Copy13'
      OnExecute = actEditCopyFileNameExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actSearchFind: TAction
      Category = 'Search'
      Caption = '&Find...'
      Enabled = False
      HelpContext = 330
      Hint = 'Search|Search for a string'
      ImageIndex = 13
      ImageName = 'Search13'
      ShortCut = 16454
      OnExecute = actSearchFindExecute
      OnUpdate = UpdateSearchActions
    end
    object actSearchFindNext: TAction
      Category = 'Search'
      Caption = 'Find &Next'
      Enabled = False
      HelpContext = 330
      Hint = 'Find next|Find next match'
      ImageIndex = 14
      ImageName = 'FindNext'
      ShortCut = 114
      OnExecute = actSearchFindNextExecute
      OnUpdate = UpdateSearchActions
    end
    object actSearchFindPrev: TAction
      Category = 'Search'
      Caption = 'Find &Previous'
      Enabled = False
      HelpContext = 330
      Hint = 'Find previous|Find Previous match'
      ImageIndex = 76
      ImageName = 'FindPrevious'
      ShortCut = 8306
      OnExecute = actSearchFindPrevExecute
      OnUpdate = UpdateSearchActions
    end
    object actSearchReplace: TAction
      Category = 'Search'
      Caption = '&Replace...'
      Enabled = False
      HelpContext = 330
      Hint = 'Replace|Search & Replace'
      ImageIndex = 15
      ImageName = 'Replace13'
      ShortCut = 16456
      OnExecute = actSearchReplaceExecute
      OnUpdate = UpdateSearchActions
    end
    object actFileSaveAll: TAction
      Category = 'File'
      Caption = 'Save &All'
      HelpContext = 310
      Hint = 'Save all|Save project and all open files'
      ImageIndex = 3
      ImageName = 'SaveAll'
      OnExecute = actFileSaveAllExecute
      OnUpdate = UpdateFileActions
    end
    object actFileSaveToRemote: TAction
      Category = 'File'
      Caption = 'Save to Remote File'
      Hint = 'Save to remote file with SSH'
      ImageIndex = 96
      ImageName = 'Upload'
      OnExecute = actFileSaveToRemoteExecute
      OnUpdate = UpdateFileActions
    end
    object actFileReload: TAction
      Category = 'File'
      Caption = 'Re&load'
      Enabled = False
      HelpContext = 310
      Hint = 'Reload|Reload active file'
      ImageIndex = 29
      ImageName = 'Refresh'
      OnExecute = actFileReloadExecute
      OnUpdate = UpdateFileActions
    end
    object actFilePrint: TAction
      Category = 'File'
      Caption = '&Print...'
      Enabled = False
      HelpContext = 310
      Hint = 'Print|Print active file'
      ImageIndex = 6
      ImageName = 'Print13'
      ShortCut = 16464
      OnExecute = actFilePrintExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actPrinterSetup: TAction
      Category = 'File'
      Caption = 'Printer Set&up...'
      HelpContext = 310
      Hint = 'Printer setup'
      ImageIndex = 4
      ImageName = 'PrintSetup'
      OnExecute = actPrinterSetupExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actPrintPreview: TAction
      Category = 'File'
      Caption = 'Print Pre&view'
      HelpContext = 310
      Hint = 'Print preview'
      ImageIndex = 5
      ImageName = 'PrintPreview'
      OnExecute = actPrintPreviewExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actPageSetup: TAction
      Category = 'File'
      Caption = 'Pa&ge Setup...'
      HelpContext = 310
      Hint = 'Page setup'
      ImageIndex = 52
      ImageName = 'PageSetup'
      OnExecute = actPageSetupExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actEditIndent: TAction
      Category = 'Source Code'
      Caption = '&Indent Block'
      HelpContext = 320
      Hint = 'Indent block|Indent selected block of code'
      ImageIndex = 45
      ImageName = 'Indent13'
      ShortCut = 24649
      OnExecute = actEditIndentExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actEditDedent: TAction
      Category = 'Source Code'
      Caption = '&Unindent Block'
      HelpContext = 320
      Hint = 'Unindent|Unindent selected block of code'
      ImageIndex = 46
      ImageName = 'Dedent'
      ShortCut = 24661
      OnExecute = actEditDedentExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actEditCommentOut: TAction
      Category = 'Source Code'
      Caption = '&Comment out'
      HelpContext = 320
      Hint = 'Comment out| Comment out block of code'
      ImageIndex = 47
      ImageName = 'CodeComment'
      ShortCut = 49342
      OnExecute = actEditCommentOutExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actEditUncomment: TAction
      Category = 'Source Code'
      Caption = '&Uncomment'
      HelpContext = 320
      Hint = 'Uncomment| Uncomment block of code'
      ImageIndex = 48
      ImageName = 'UnCodeComment'
      ShortCut = 49340
      OnExecute = actEditUncommentExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actSearchMatchingBrace: TAction
      Category = 'Search'
      Caption = '&Matching Brace'
      HelpContext = 330
      Hint = 'Find Matching Brace'
      ShortCut = 16605
      OnExecute = actSearchMatchingBraceExecute
      OnUpdate = UpdateSearchActions
    end
    object actEditTabify: TAction
      Category = 'Source Code'
      Caption = '&Tabify'
      HelpContext = 320
      Hint = 'Tabify|Convert spaces to tabs'
      ShortCut = 32990
      OnExecute = actEditTabifyExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actEditUntabify: TAction
      Category = 'Source Code'
      Caption = 'U&ntabify'
      HelpContext = 320
      Hint = 'Untabify|Convert tabs to spaces'
      ShortCut = 41182
      OnExecute = actEditUntabifyExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actConfigureTools: TAction
      Category = 'Tools'
      Caption = 'Configure &Tools...'
      HelpContext = 710
      Hint = 'Configure Tools|Add/remove/edit command-line tools'
      ImageIndex = 56
      ImageName = 'ToolsSetup'
      OnExecute = actConfigureToolsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actCheckForUpdates: TAction
      Category = 'Tools'
      Caption = 'Check For &Updates'
      HelpContext = 350
      Hint = 'Check whether a newer version of PyScripter is available'
      OnExecute = actCheckForUpdatesExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actToolsEditStartupScripts: TAction
      Category = 'Tools'
      Caption = 'Edit &Startup Scripts'
      HelpContext = 350
      HelpType = htContext
      Hint = 'Edit PyScripter initialization files'
      OnExecute = actToolsEditStartupScriptsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actToolsRestartLS: TAction
      Category = 'Tools'
      Caption = 'Restart &Language Server'
      HelpContext = 350
      HelpType = htContext
      Hint = 'Restart the Language Server'
      OnExecute = actToolsRestartLSExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actHelpContents: THelpContents
      Category = 'Help'
      Caption = '&Contents'
      Enabled = False
      HelpContext = 370
      HelpType = htContext
      Hint = 'Help Contents'
      ImageIndex = 27
      ImageName = 'Help'
      OnExecute = actHelpContentsExecute
    end
    object actPythonManuals: THelpContents
      Category = 'Help'
      Caption = '&Python Manuals'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Show Python Manuals'
      ImageIndex = 51
      ImageName = 'PyDoc'
      OnExecute = actPythonManualsExecute
    end
    object actAbout: TAction
      Category = 'Help'
      Caption = 'About...'
      HelpContext = 370
      HelpType = htContext
      Hint = 'About|Info about the application'
      ImageIndex = 25
      ImageName = 'Info'
      OnExecute = actAboutExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actSearchGoToLine: TAction
      Category = 'Search'
      Caption = 'Go To &Line...'
      HelpContext = 330
      Hint = 'Go to line number'
      ImageIndex = 26
      ImageName = 'GoToLine'
      ShortCut = 32839
      OnExecute = actSearchGoToLineExecute
      OnUpdate = UpdateSearchActions
    end
    object actSearchGoToSyntaxError: TAction
      Category = 'Search'
      Caption = 'Go To Syntax &Error'
      HelpContext = 330
      Hint = 'Jump to the position of the first syntax error'
      ImageIndex = 78
      ImageName = 'GoToError'
      ShortCut = 24645
      OnExecute = actSearchGoToSyntaxErrorExecute
      OnUpdate = UpdateSearchActions
    end
    object actFindInFiles: TAction
      Category = 'Search'
      Caption = 'Find &in Files...'
      HelpContext = 330
      Hint = 'Search in Files|Search for a string in Files'
      ImageIndex = 59
      ImageName = 'SearchFolder'
      ShortCut = 24646
      OnExecute = actFindInFilesExecute
      OnUpdate = UpdateSearchActions
    end
    object actParameterCompletion: TAction
      Category = 'Parameters'
      Caption = 'Insert &parameter'
      HelpContext = 720
      Hint = 'Insert parameter to the edited file'
      ShortCut = 24656
      OnExecute = actParameterCompletionExecute
      OnUpdate = UpdateParameterActions
    end
    object actModifierCompletion: TAction
      Category = 'Parameters'
      Caption = 'Insert &modifier'
      HelpContext = 720
      Hint = 'Insert parameter to the edited file'
      ShortCut = 24653
      OnExecute = actModifierCompletionExecute
      OnUpdate = UpdateParameterActions
    end
    object actReplaceParameters: TAction
      Category = 'Parameters'
      Caption = '&Replace parameters'
      HelpContext = 720
      Hint = 'Replace parameters with their values'
      ShortCut = 24658
      OnExecute = actReplaceParametersExecute
      OnUpdate = UpdateParameterActions
    end
    object actHelpParameters: TAction
      Category = 'Help'
      Caption = '&Parameters'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Help on custom parameters'
      OnExecute = actHelpParametersExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actHelpExternalTools: TAction
      Category = 'Help'
      Caption = 'External &Tools'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Help on External Tools'
      OnExecute = actHelpExternalToolsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actFindFunction: TAction
      Category = 'Search'
      Caption = 'Find F&unction...'
      HelpContext = 330
      Hint = 'Find Function|Find function from function list'
      ImageIndex = 21
      ImageName = 'Function13'
      ShortCut = 16455
      OnExecute = actFindFunctionExecute
      OnUpdate = UpdateSearchActions
    end
    object actEditReadOnly: TAction
      Category = 'Edit'
      Caption = 'Read Only'
      Hint = 'Enable/disable editing'
      OnExecute = actEditReadOnlyExecute
      OnUpdate = UpdateEditActions
    end
    object actEditLineNumbers: TAction
      Category = 'Edit'
      Caption = 'Line &Numbers'
      HelpContext = 320
      Hint = 'Show/Hide line numbers'
      ImageIndex = 31
      ImageName = 'LineNumbers'
      OnExecute = actEditLineNumbersExecute
      OnUpdate = UpdateEditActions
    end
    object actEditShowSpecialChars: TAction
      Category = 'Edit'
      Caption = 'Special &Characters'
      HelpContext = 320
      Hint = 'Show/Hide special characters'
      ImageIndex = 63
      ImageName = 'SpecialChars'
      OnExecute = actEditShowSpecialCharsExecute
      OnUpdate = UpdateEditActions
    end
    object actEditWordWrap: TAction
      Category = 'Edit'
      Caption = 'Word &Wrap'
      HelpContext = 320
      Hint = 'Turn word wrap on/off (incompatible with code folding)'
      ImageIndex = 79
      ImageName = 'WordWrap'
      OnExecute = actEditWordWrapExecute
      OnUpdate = UpdateEditActions
    end
    object actFindPreviousReference: TAction
      Tag = 1
      Category = 'Search'
      Caption = 'Find Previous Reference'
      HelpContext = 330
      Hint = 'Find previous identifier reference'
      ShortCut = 49190
      OnExecute = actFindNextReferenceExecute
      OnUpdate = UpdateSearchActions
    end
    object actFindNextReference: TAction
      Category = 'Search'
      Caption = 'Find Next Reference'
      HelpContext = 330
      Hint = 'Find next identifier reference'
      ShortCut = 49192
      OnExecute = actFindNextReferenceExecute
      OnUpdate = UpdateSearchActions
    end
    object actEditLBDos: TAction
      Category = 'Edit'
      Caption = '&DOS/Windows'
      Checked = True
      HelpContext = 320
      Hint = 'DOS/Windows|Convert to DOS line break'
      OnExecute = actEditLBExecute
      OnUpdate = UpdateLineBreakActions
    end
    object actEditLBUnix: TAction
      Tag = 1
      Category = 'Edit'
      Caption = '&UNIX'
      HelpContext = 320
      Hint = 'UNIX|Convert to UNIX line break'
      OnExecute = actEditLBExecute
      OnUpdate = UpdateLineBreakActions
    end
    object actEditLBMac: TAction
      Tag = 2
      Category = 'Edit'
      Caption = '&Mac'
      HelpContext = 320
      Hint = 'Mac|Convert to Mac line break'
      OnExecute = actEditLBExecute
      OnUpdate = UpdateLineBreakActions
    end
    object actEditAnsi: TAction
      Category = 'Edit'
      Caption = 'ANSI'
      Checked = True
      HelpContext = 320
      Hint = 'Use ANSI encoding'
      OnExecute = actEditFileEncodingExecute
      OnUpdate = UpdateEncodingActions
    end
    object actHelpEditorShortcuts: TAction
      Category = 'Help'
      Caption = 'Editor &Shortcuts'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Help on editor shortcuts'
      OnExecute = actHelpEditorShortcutsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actPythonPath: TAction
      Category = 'Tools'
      Caption = 'Python &Path...'
      HelpContext = 870
      Hint = 'Python Path|View or edit the Python path'
      ImageIndex = 20
      ImageName = 'Folders'
      OnExecute = actPythonPathExecute
      OnUpdate = UpdateToolsActions
    end
    object actUnitTestWizard: TAction
      Category = 'Tools'
      Caption = 'Unit Test &Wizard...'
      HelpContext = 930
      Hint = 'Unit test wizard|Create unit test for active module'
      ImageIndex = 68
      ImageName = 'UnitTestWin'
      OnExecute = actUnitTestWizardExecute
      OnUpdate = UpdateToolsActions
    end
    object actInterpreterEditorOptions: TAction
      Category = 'Options'
      Caption = '&Interpreter Editor Options...'
      HelpContext = 620
      Hint = 'Set Interpreter Editor Options'
      ImageIndex = 18
      ImageName = 'EditOptions'
      OnExecute = actInterpreterEditorOptionsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actEditToggleComment: TAction
      Category = 'Source Code'
      Caption = 'Toggle &Comment'
      HelpContext = 320
      Hint = 'Toggle Comment| Comment/Uncomment block of code'
      ImageIndex = 47
      ImageName = 'CodeComment'
      ShortCut = 16606
      OnExecute = actEditToggleCommentExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actEditUTF8: TAction
      Tag = 1
      Category = 'Edit'
      Caption = 'UTF-8 with BOM'
      HelpContext = 320
      Hint = 'Use UTF-8 encoding when saving the file'
      OnExecute = actEditFileEncodingExecute
      OnUpdate = UpdateEncodingActions
    end
    object actEditUTF8NoBOM: TAction
      Tag = 2
      Category = 'Edit'
      Caption = 'UTF-8'
      HelpContext = 320
      Hint = 'Use UTF-8 encoding without BOM'
      OnExecute = actEditFileEncodingExecute
      OnUpdate = UpdateEncodingActions
    end
    object actEditUTF16LE: TAction
      Tag = 3
      Category = 'Edit'
      Caption = 'UTF-16LE'
      HelpContext = 320
      Hint = 'Use UTF-16LE encoding'
      OnExecute = actEditFileEncodingExecute
      OnUpdate = UpdateEncodingActions
    end
    object actEditUTF16BE: TAction
      Tag = 4
      Category = 'Edit'
      Caption = 'UTF-16BE'
      HelpContext = 320
      Hint = 'Use UTF-16BE encoding'
      OnExecute = actEditFileEncodingExecute
      OnUpdate = UpdateEncodingActions
    end
    object actImportShortcuts: TAction
      Category = 'Import/Export'
      Caption = 'Import Shortcuts'
      Hint = 'Import Shortcuts'
      OnExecute = actImportShortcutsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actExportShortCuts: TAction
      Category = 'Import/Export'
      Caption = 'Export Shortcuts'
      Hint = 'Export Shortcuts'
      OnExecute = actExportShortCutsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actImportHighlighters: TAction
      Category = 'Import/Export'
      Caption = 'Import Highlighters'
      Hint = 'Import Syntax Highlighters'
      OnExecute = actImportHighlightersExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actExportHighlighters: TAction
      Category = 'Import/Export'
      Caption = 'Export Highlighters'
      Hint = 'Export Syntax Highlighters'
      OnExecute = actExportHighlightersExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actSearchReplaceNow: TAction
      Category = 'Search'
      Caption = 'Replace'
      Enabled = False
      HelpContext = 330
      Hint = 'Replace with existing settings'
      ImageName = 'Replace'
      OnExecute = actSearchReplaceNowExecute
      OnUpdate = UpdateSearchActions
    end
    object actSearchHighlight: TAction
      Category = 'Search'
      AutoCheck = True
      Caption = '&Highlight Search Text'
      HelpContext = 330
      Hint = 'Highlight the search text in the current editor'
      ImageIndex = 77
      ImageName = 'Highlight'
      ShortCut = 24648
      OnExecute = actSearchHighlightExecute
      OnUpdate = UpdateSearchActions
    end
    object actSearchGoToDebugLine: TAction
      Category = 'Search'
      Caption = 'Go To &Debugger Position'
      HelpContext = 330
      Hint = 'Go to the current position of the debugger'
      OnExecute = actSearchGoToDebugLineExecute
      OnUpdate = UpdateSearchActions
    end
    object actHelpWebProjectHome: TBrowseURL
      Category = 'Help'
      Caption = '&Project Home'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Go to the project home page'
      ImageIndex = 90
      ImageName = 'Link'
      URL = 'https://guipy.de'
    end
    object actHelpWebGroupSupport: TBrowseURL
      Category = 'Help'
      Caption = '&Group Support'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Go to the PyScripter Internet group'
      ImageIndex = 90
      ImageName = 'Link'
      URL = 'http://groups.google.com/group/PyScripter'
    end
    object actFileCloseAllOther: TAction
      Tag = 1
      Category = 'File'
      Caption = 'Close All &Other'
      HelpContext = 310
      Hint = 'Close all files except the active one'
      OnExecute = actFileCloseWorkspaceTabsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actFileCloseAllToTheRight: TAction
      Category = 'File'
      Caption = 'Close All to the &Right'
      HelpContext = 310
      Hint = 'Close all files to the right'
      OnExecute = actFileCloseWorkspaceTabsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actFoldVisible: TAction
      Category = 'Code Folding'
      Caption = 'Code Folding'
      Hint = 'Show/Hide Code Folding'
      OnExecute = actFoldVisibleExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldAll: TAction
      Category = 'Code Folding'
      Caption = 'All'
      Hint = 'Fold all'
      ImageIndex = 24
      ImageName = 'Collapse'
      OnExecute = actFoldAllExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldAll: TAction
      Category = 'Code Folding'
      Caption = 'All'
      Hint = 'Unfold all'
      ImageIndex = 23
      ImageName = 'Expand'
      OnExecute = actUnfoldAllExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldNearest: TAction
      Category = 'Code Folding'
      Caption = 'Nearest'
      Hint = 'Collapse nearest fold'
      OnExecute = actFoldNearestExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldNearest: TAction
      Category = 'Code Folding'
      Caption = 'Nearest'
      Hint = 'Expand nearest fold'
      OnExecute = actUnfoldNearestExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldRegions: TAction
      Category = 'Code Folding'
      Caption = 'Regions'
      Hint = 'Fold Ranges'
      OnExecute = actFoldRegionsExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldRegions: TAction
      Category = 'Code Folding'
      Caption = 'Regions'
      Hint = 'Unfold ranges'
      OnExecute = actUnfoldRegionsExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldLevel1: TAction
      Category = 'Code Folding'
      Caption = 'Level 1'
      Hint = 'Fold level 1'
      OnExecute = actFoldLevel1Execute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldLevel1: TAction
      Category = 'Code Folding'
      Caption = 'Level 1'
      Hint = 'Unfold level 1'
      OnExecute = actUnfoldLevel1Execute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldLevel2: TAction
      Category = 'Code Folding'
      Caption = 'Level 2'
      Hint = 'Fold level 2'
      OnExecute = actFoldLevel2Execute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldLevel2: TAction
      Category = 'Code Folding'
      Caption = 'Level 2'
      Hint = 'Unfold level 2'
      OnExecute = actUnfoldLevel2Execute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldLevel3: TAction
      Category = 'Code Folding'
      Caption = 'Level 3'
      Hint = 'Fold level 3'
      OnExecute = actFoldLevel3Execute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldLevel3: TAction
      Category = 'Code Folding'
      Caption = 'Level 3'
      Hint = 'Unfold level 3'
      OnExecute = actUnfoldLevel3Execute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldClasses: TAction
      Category = 'Code Folding'
      Caption = 'Classes'
      Hint = 'Fold classes'
      OnExecute = actFoldClassesExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldClasses: TAction
      Category = 'Code Folding'
      Caption = 'Classes'
      Hint = 'Unfold classes'
      OnExecute = actUnfoldClassesExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actFoldFunctions: TAction
      Category = 'Code Folding'
      Caption = 'Functions'
      Hint = 'Fold functions'
      OnExecute = actFoldFunctionsExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actUnfoldFunctions: TAction
      Category = 'Code Folding'
      Caption = 'Functions'
      Hint = 'Unfold functions'
      OnExecute = actUnfoldFunctionsExecute
      OnUpdate = UpdateCodeFoldingActions
    end
    object actEditCreateStructogram: TAction
      Category = 'Edit'
      Caption = 'Create structogram'
      Hint = 'Create a structogram from selected source code'
      OnExecute = actEditCreateStructogramExecute
    end
    object actSynSpellCheckFile: TSynSpellCheckFile
      Category = 'Spell Checking'
      Caption = 'Check File'
    end
    object actSynSpellCheckLine: TSynSpellCheckLine
      Category = 'Spell Checking'
      Caption = 'Check Line'
    end
    object actSynSpellCheckSelection: TSynSpellCheckSelection
      Category = 'Spell Checking'
      Caption = 'Check Selection'
    end
    object actSynSpellCheckWord: TSynSpellCheckWord
      Category = 'Spell Checking'
      Caption = 'Check Word'
    end
    object actSynSpellClearErrors: TSynSpellClearErrors
      Category = 'Spell Checking'
      Caption = 'Clear Errors'
    end
    object actSynSpellCheckAsYouType: TSynSpellCheckAsYouType
      Category = 'Spell Checking'
      Caption = 'Check As You Type'
    end
    object actSynSpellErrorAdd: TSynSpellErrorAdd
      Category = 'Spell Checking'
      Caption = 'Add'
    end
    object actSynSpellErrorIgnoreOnce: TSynSpellErrorIgnoreOnce
      Category = 'Spell Checking'
      Caption = 'Ignore Once'
    end
    object actSynSpellErrorIgnore: TSynSpellErrorIgnore
      Category = 'Spell Checking'
      Caption = 'Ignore'
    end
    object actSynSpellErrorDelete: TSynSpellErrorDelete
      Category = 'Spell Checking'
      Caption = 'Delete'
    end
    object actAssistantSuggest: TAction
      Category = 'Assistant'
      Caption = 'Suggest'
      Hint = 'Provide a suggestion for code completion'
      ShortCut = 49184
      OnExecute = actAssistantSuggestExecute
      OnUpdate = UpdateAssistantActions
    end
    object actAssistantCancel: TAction
      Category = 'Assistant'
      Caption = 'Cancel'
      Hint = 'Cancel Assistant action'
      ImageIndex = 118
      ImageName = 'Cancel'
      OnExecute = actAssistantCancelExecute
      OnUpdate = UpdateAssistantActions
    end
    object actAssistantOptimize: TAction
      Category = 'Assistant'
      Caption = 'Optimize'
      Hint = 'Optimize the selected code'
      OnExecute = actAssistantOptimizeExecute
      OnUpdate = UpdateAssistantActions
    end
    object actAssistantFixBugs: TAction
      Category = 'Assistant'
      Caption = 'Fix Bugs'
      Hint = 'Fix bugs in the selected code'
      OnExecute = actAssistantFixBugsExecute
      OnUpdate = UpdateAssistantActions
    end
    object actAssistantExplain: TAction
      Category = 'Assistant'
      Caption = 'Explain'
      Hint = 'Add comments explaining the selected code'
      OnExecute = actAssistantExplainExecute
      OnUpdate = UpdateAssistantActions
    end
    object actDonate: TBrowseURL
      Category = 'Help'
      Caption = '&Donate'
      HelpContext = 370
      HelpType = htContext
      Hint = 'Donate to the GuiPy project'
      ImageIndex = 90
      ImageName = 'Link'
      URL = 'https://www.paypal.com/donate?hosted_button_id=6RTJT5GMUN3LG'
    end
    object actFileExport: TAction
      Category = 'File'
      Caption = 'Export'
      Hint = 'Export to RTF or HTML file'
      OnExecute = actFileExportExecute
      OnUpdate = UpdateFileActions
    end
    object actFormatCode: TAction
      Category = 'Source Code'
      Caption = 'Format'
      Hint = 
        'Format source code, either the selected text or the whole docume' +
        'nt.'
      ShortCut = 41030
      OnExecute = actFormatCodeExecute
      OnUpdate = UpdateSourceCodeActions
    end
    object actCodeCheck: TAction
      Category = 'Source Code'
      Caption = 'Check Code'
      Hint = 'Perform a code check'
      ShortCut = 16497
      OnExecute = actCodeCheckExecute
      OnUpdate = UpdateIssuesActions
    end
    object actClearIssues: TAction
      Category = 'Source Code'
      Caption = 'Clear Issues'
      Hint = 'Clear code issues'
      ShortCut = 24689
      OnExecute = actClearIssuesExecute
      OnUpdate = UpdateIssuesActions
    end
    object actNextIssue: TAction
      Category = 'Source Code'
      Caption = 'Next Issue'
      Hint = 'Go to the next issue'
      ImageIndex = 65
      ImageName = 'ArrowRight'
      OnExecute = actNextIssueExecute
      OnUpdate = UpdateIssuesActions
    end
    object actPreviousIssue: TAction
      Category = 'Source Code'
      Caption = 'Previous Issue'
      Hint = 'Go to the previous issue'
      ImageIndex = 64
      ImageName = 'ArrowLeft'
      OnExecute = actPreviousIssueExecute
      OnUpdate = UpdateIssuesActions
    end
    object actFixAll: TAction
      Category = 'Refactoring'
      Caption = 'Fix All'
      Hint = 'Apply all available fixes'
      ImageIndex = 124
      OnExecute = actFixAllExecute
      OnUpdate = UpdateRefactorActions
    end
    object actOrganizeImports: TAction
      Category = 'Refactoring'
      Caption = 'Organize Imports'
      Hint = 'Organize import statements'
      OnExecute = actOrganizeImportsExecute
      OnUpdate = UpdateRefactorActions
    end
    object actRefactorRename: TAction
      Category = 'Refactoring'
      Caption = 'Rename'
      Hint = 'Rename the selected identifier '
      ImageName = 'Rename'
      OnExecute = actRefactorRenameExecute
      OnUpdate = UpdateRefactorActions
    end
    object actCodeAction: TAction
      Category = 'Refactoring'
      ImageIndex = 56
      ImageName = 'ToolsSetup'
      OnExecute = actCodeActionExecute
      OnUpdate = UpdateRefactorActions
    end
    object actShowRefactorMenu: TAction
      Category = 'Refactoring'
      Caption = 'actShowRefactorMenu'
      ShortCut = 8305
      OnExecute = actShowRefactorMenuExecute
      OnUpdate = UpdateRefactorActions
    end
    object actFileExit: TAction
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit'
      ImageIndex = 32
      ImageName = 'Exit13'
      ShortCut = 32883
      OnExecute = actFileExitExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavEditor: TAction
      Category = 'IDE Navigation'
      Caption = '&Editor'
      Hint = 'Activate the Editor'
      ImageIndex = 86
      ImageName = 'Editor'
      ShortCut = 123
      OnExecute = actNavEditorExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavFindResults: TAction
      Tag = 12
      Category = 'IDE Navigation'
      Caption = 'Find &in Files Results'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Activate the Find in Files Results window'
      ImageIndex = 60
      ImageName = 'FindResults'
      ShortCut = 49222
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavWatches: TAction
      Tag = 3
      Category = 'IDE Navigation'
      Caption = '&Watches'
      HelpType = htContext
      Hint = 'Activate the Watches window'
      ImageIndex = 43
      ImageName = 'WatchesWin'
      ShortCut = 49239
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavBreakpoints: TAction
      Tag = 4
      Category = 'IDE Navigation'
      Caption = '&BreakPoints'
      HelpType = htContext
      Hint = 'Activate the Breakpoints window'
      ImageIndex = 44
      ImageName = 'BreakpointsWin'
      ShortCut = 49218
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavInterpreter: TAction
      Category = 'IDE Navigation'
      Caption = '&Interpreter'
      HelpType = htContext
      Hint = 'Activate the Interpreter window'
      ImageIndex = 83
      ImageName = 'Python'
      ShortCut = 49225
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavVariables: TAction
      Tag = 2
      Category = 'IDE Navigation'
      Caption = '&Variables'
      HelpType = htContext
      Hint = 'Activate the Variables window'
      ImageIndex = 42
      ImageName = 'VariablesWin'
      ShortCut = 49238
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavCallStack: TAction
      Tag = 1
      Category = 'IDE Navigation'
      Caption = '&Call Stack'
      HelpType = htContext
      Hint = 'Activate the Call Stack window'
      ImageIndex = 41
      ImageName = 'CallStack'
      ShortCut = 49235
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavMessages: TAction
      Tag = 6
      Category = 'IDE Navigation'
      Caption = '&Messages '
      HelpType = htContext
      Hint = 'Activate the Messages window'
      ImageIndex = 49
      ImageName = 'MessagesWin'
      ShortCut = 49229
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavFileExplorer: TAction
      Tag = 8
      Category = 'IDE Navigation'
      Caption = 'File E&xplorer'
      HelpType = htContext
      Hint = 'Activate the File Explorer window'
      ImageIndex = 57
      ImageName = 'FileExplorer'
      ShortCut = 49240
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavCodeExplorer: TAction
      Tag = 7
      Category = 'IDE Navigation'
      Caption = '&Code Explorer'
      HelpType = htContext
      Hint = 'Activate the Code Explorer window'
      ImageIndex = 50
      ImageName = 'CodeExplorer'
      ShortCut = 49219
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavTodo: TAction
      Tag = 9
      Category = 'IDE Navigation'
      Caption = '&Todo List'
      HelpType = htContext
      Hint = 'Activate the Todo List window'
      ImageIndex = 58
      ImageName = 'TodoWin'
      ShortCut = 49236
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavUnitTests: TAction
      Tag = 11
      Category = 'IDE Navigation'
      Caption = '&Unit Tests'
      HelpType = htContext
      Hint = 'Activate the Todo List window'
      ImageIndex = 68
      ImageName = 'UnitTestWin'
      ShortCut = 49237
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavOutput: TAction
      Tag = 5
      Category = 'IDE Navigation'
      Caption = 'Command &Output'
      HelpType = htContext
      Hint = 'Activate the Command Output window'
      ImageIndex = 62
      ImageName = 'CmdOuputWin'
      ShortCut = 49231
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavProjectExplorer: TAction
      Tag = 13
      Category = 'IDE Navigation'
      Caption = '&Project Explorer'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Activate the Project Explorer window'
      ImageIndex = 85
      ImageName = 'ProjectExplorer'
      ShortCut = 49232
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavRegExp: TAction
      Tag = 10
      Category = 'IDE Navigation'
      Caption = 'Regular Expression Tester'
      Hint = 'Activate the Regular Expression Tester window'
      ImageIndex = 66
      ImageName = 'RegExp'
      ShortCut = 49234
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavChat: TAction
      Tag = 14
      Category = 'IDE Navigation'
      Caption = 'Chat'
      Hint = 'Activate the Chat window'
      ImageIndex = 117
      ImageName = 'Chat'
      ShortCut = 49217
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavObjectInspector: TAction
      Tag = 15
      Category = 'IDE Navigation'
      Caption = 'Object inspector'
      Hint = 'Activate the object inspector  window'
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavStructure: TAction
      Tag = 16
      Category = 'IDE Navigation'
      Caption = 'Structure'
      Hint = 'Activate the structure window'
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actNavUMLInteractive: TAction
      Tag = 17
      Category = 'IDE Navigation'
      Caption = 'UML interactive'
      Hint = 'Activate the UML interactive window'
      OnExecute = actNavigateToDockWindow
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actProjectNew: TAction
      Category = 'Project'
      Caption = '&New Project'
      Hint = 'Start a new project'
      ImageIndex = 121
      ImageName = 'ProjectFile'
      OnExecute = actProjectNewExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actProjectOpen: TAction
      Category = 'Project'
      Caption = '&Open Project...'
      Hint = 'Open a project file'
      ImageIndex = 122
      ImageName = 'ProjectOpen'
      OnExecute = actProjectOpenExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actProjectSave: TAction
      Category = 'Project'
      Caption = '&Save Project'
      Hint = 'Save the project'
      ImageIndex = 123
      ImageName = 'ProjectSave'
      OnExecute = actProjectSaveExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
    object actProjectSaveAs: TAction
      Category = 'Project'
      Caption = 'Save Project &As...'
      Hint = 'Save project with under a different name'
      OnExecute = actProjectSaveAsExecute
      OnUpdate = UpdateActionAlwaysEnabled
    end
  end
  object SynWebCompletion: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    Width = 340
    EndOfTokenChr = ';>()[] .'
    TriggerChars = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    GripperFont.Charset = DEFAULT_CHARSET
    GripperFont.Color = clBtnText
    GripperFont.Height = -36
    GripperFont.Name = 'Segoe UI'
    GripperFont.Style = []
    Columns = <
      item
        ColumnWidth = 100
      end>
    Resizeable = True
    ShortCut = 0
    Left = 484
    Top = 112
  end
  object SynParamCompletion: TSynCompletionProposal
    DefaultType = ctParams
    Options = [scoCaseSensitive, scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoConsiderWordBreakChars, scoCompleteWithTab, scoCompleteWithEnter]
    EndOfTokenChr = '()[]. ='
    TriggerChars = '('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    GripperFont.Charset = DEFAULT_CHARSET
    GripperFont.Color = clBtnText
    GripperFont.Height = -36
    GripperFont.Name = 'Segoe UI'
    GripperFont.Style = []
    Columns = <>
    ShortCut = 0
    TimerInterval = 300
    Left = 484
    Top = 71
  end
  object SynCodeCompletion: TSynCompletionProposal
    Options = [scoCaseSensitive, scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoEndCharCompletion, scoConsiderWordBreakChars, scoCompleteWithTab, scoCompleteWithEnter]
    Width = 200
    EndOfTokenChr = '()[]{}. =:'
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    GripperFont.Charset = DEFAULT_CHARSET
    GripperFont.Color = clBtnText
    GripperFont.Height = -36
    GripperFont.Name = 'Segoe UI'
    GripperFont.Style = []
    Columns = <>
    Resizeable = True
    ShortCut = 0
    TimerInterval = 300
    Left = 484
    Top = 25
  end
  object SynSpellCheck: TSynSpellCheck
    AttributesChecked.Strings = (
      'Comment'
      'Text'
      'String'
      'Documentation')
    CheckAsYouType = False
    OnChange = SynSpellCheckChange
    Left = 480
    Top = 176
  end
  object pmSpelling: TSpTBXPopupMenu
    Left = 122
    Top = 180
    object mnSpelling: TSpTBXSubmenuItem
      Caption = 'Spelling'
      OnPopup = mnSpellingPopup
      object mnSpellCheckTopSeparator: TSpTBXSeparatorItem
      end
      object mnSpellCheckAdd: TSpTBXItem
        Action = actSynSpellErrorAdd
      end
      object mnSpellCheckDelete: TSpTBXItem
        Action = actSynSpellErrorDelete
      end
      object mnSpellCheckIgnore: TSpTBXItem
        Action = actSynSpellErrorIgnore
      end
      object mnSpellCheckIgnoreOnce: TSpTBXItem
        Action = actSynSpellErrorIgnoreOnce
      end
      object mnSpellCheckSecondSeparator: TSpTBXSeparatorItem
      end
      object SpTBXItem20: TSpTBXItem
        Action = actSynSpellCheckWord
      end
      object SpTBXItem21: TSpTBXItem
        Action = actSynSpellCheckLine
      end
      object SpTBXItem22: TSpTBXItem
        Action = actSynSpellCheckSelection
      end
      object SpTBXItem23: TSpTBXItem
        Action = actSynSpellCheckFile
      end
      object SpTBXSeparatorItem24: TSpTBXSeparatorItem
      end
      object SpTBXItem24: TSpTBXItem
        Action = actSynSpellClearErrors
      end
      object SpTBXSeparatorItem25: TSpTBXSeparatorItem
      end
      object SpTBXItem25: TSpTBXItem
        Action = actSynSpellCheckAsYouType
      end
    end
  end
  object pmAssistant: TSpTBXPopupMenu
    Images = EditorForm.vilContextMenuDark
    Left = 248
    Top = 180
    object spiAssistant: TSpTBXSubmenuItem
      Caption = 'Assistant'
      object spiSuggest: TSpTBXItem
        Action = actAssistantSuggest
      end
      object spiAssistantExplain: TSpTBXItem
        Action = actAssistantExplain
      end
      object spiFixBugs: TSpTBXItem
        Action = actAssistantFixBugs
      end
      object spiOptimize: TSpTBXItem
        Action = actAssistantOptimize
      end
      object SpTBXSeparatorItem4: TSpTBXSeparatorItem
      end
      object spiAssistantCancel: TSpTBXItem
        Action = actAssistantCancel
        ImageIndex = 20
      end
    end
  end
end
