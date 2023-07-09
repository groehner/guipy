object PyIDEMainForm: TPyIDEMainForm
  Left = 0
  Top = 115
  HelpContext = 100
  Caption = 'GuiPy'
  ClientHeight = 651
  ClientWidth = 946
  Color = clWindow
  Ctl3D = False
  ParentFont = True
  OldCreateOrder = True
  Position = poDefault
  ShowHint = True
  StyleElements = [seFont, seClient]
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TSpTBXStatusBar
    Left = 0
    Top = 626
    Width = 946
    Height = 25
    SizeGrip = False
    ExplicitTop = 641
    object lbStatusMessage: TSpTBXLabelItem
      Wrapping = twEndEllipsis
      Options = [tboNoAutoHint]
    end
    object SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
      Wrapping = twNone
      CustomWidth = 0
    end
    object SpTBXSeparatorItem22: TSpTBXSeparatorItem
    end
    object lbPythonVersion: TSpTBXLabelItem
      Hint = 'Python version'
      OnClick = lbPythonVersionClick
      Alignment = taCenter
      MinWidth = 130
    end
    object SpTBXSeparatorItem23: TSpTBXSeparatorItem
    end
    object lbPythonEngine: TSpTBXLabelItem
      Hint = 'Python engine type'
      OnClick = lbPythonEngineClick
      Alignment = taCenter
      MinWidth = 100
    end
    object SpTBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object lbFileFormat: TSpTBXLabelItem
      Hint = 'File format'
      Alignment = taCenter
    end
    object SpTBXSeparatorItem30: TSpTBXSeparatorItem
    end
    object lbStatusCaret: TSpTBXLabelItem
      Hint = 'Text position'
      Wrapping = twEndEllipsis
      OnClick = lbStatusCaretClick
      Alignment = taCenter
      CustomWidth = 92
    end
    object SpTBXSeparatorItem6: TSpTBXSeparatorItem
    end
    object lbStatusModified: TSpTBXLabelItem
      Wrapping = twEndEllipsis
      Options = [tboNoAutoHint]
      Alignment = taCenter
      CustomWidth = 80
    end
    object SpTBXSeparatorItem7: TSpTBXSeparatorItem
    end
    object lbStatusOverwrite: TSpTBXLabelItem
      Wrapping = twEndEllipsis
      Options = [tboNoAutoHint]
      Alignment = taCenter
      CustomWidth = 90
    end
    object SpTBXSeparatorItem8: TSpTBXSeparatorItem
    end
    object lbStatusCaps: TSpTBXLabelItem
      Wrapping = twEndEllipsis
      Options = [tboNoAutoHint]
      Alignment = taCenter
      CustomWidth = 40
    end
    object SpTBXSeparatorItem9: TSpTBXSeparatorItem
    end
    object spiStatusLED: TSpTBXItem
      Hint = 'Ready'
      ImageIndex = 0
      ImageName = 'StatusLED'
      Images = vilIndicators
    end
    object spiLspLed: TSpTBXItem
      Hint = 'Ready'
      ImageIndex = 2
      ImageName = 'LspLED'
      Images = vilIndicators
    end
    object spiExternalToolsLED: TSpTBXItem
      Hint = 'External Tool Running'
      ImageIndex = 1
      ImageName = 'ExternalToolsLED'
      Images = vilIndicators
      Visible = False
    end
  end
  object BGPanel: TPanel
    Left = 9
    Top = 84
    Width = 928
    Height = 533
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 2
    ExplicitWidth = 286
    ExplicitHeight = 83
    object TabControl1: TSpTBXTabControl
      Left = 0
      Top = 0
      Width = 924
      Height = 533
      Align = alClient
      PopupMenu = TabControlPopupMenu
      OnContextPopup = TabContolContextPopup
      ActiveTabIndex = -1
      Images = vilImages
      TabDragReorder = True
      TabPosition = ttpBottom
      OnActiveTabChange = TabControlActiveTabChange
      HiddenItems = <>
      object tbiRightAlign: TSpTBXRightAlignSpacerItem
        CustomWidth = 798
      end
      object tbiTabSep: TSpTBXSeparatorItem
      end
      object tbiTabFiles: TSpTBXSubmenuItem
        Tag = 1
        Hint = 'Select File'
        ImageIndex = 98
        ImageName = 'Tabs'
        Options = [tboDropdownArrow]
        LinkSubitems = mnFiles
      end
      object tbiScrollLeft: TSpTBXItem
        Tag = 1
        Hint = 'Scroll left'
        Enabled = False
        ImageIndex = 54
        ImageName = 'TabPrevious'
        Options = [tboToolbarStyle]
        OnClick = tbiScrollLeftClick
      end
      object tbiScrollRight: TSpTBXItem
        Tag = 1
        Hint = 'Scroll right'
        Enabled = False
        ImageIndex = 53
        ImageName = 'TabNext'
        Options = [tboToolbarStyle]
        OnClick = tbiScrollRightClick
        FontSettings.Name = 'Marlett'
      end
      object tbiTabClose: TSpTBXItem
        Tag = 1
        Action = CommandsDataModule.actFileClose
        ImageName = 'TabClose'
        Options = [tboToolbarStyle]
      end
    end
    object TabControl2: TSpTBXTabControl
      Left = 924
      Top = 0
      Width = 0
      Height = 533
      Align = alRight
      PopupMenu = TabControlPopupMenu
      Visible = False
      OnContextPopup = TabContolContextPopup
      ActiveTabIndex = -1
      Images = vilImages
      TabDragReorder = True
      TabPosition = ttpBottom
      OnActiveTabChange = TabControlActiveTabChange
      HiddenItems = <>
      object SpTBXRightAlignSpacerItem2: TSpTBXRightAlignSpacerItem
        CustomWidth = 0
      end
      object SpTBXSeparatorItem13: TSpTBXSeparatorItem
      end
      object tbiTabFiles2: TSpTBXSubmenuItem
        Tag = 2
        Hint = 'Select File'
        ImageIndex = 98
        ImageName = 'Tabs'
        Options = [tboDropdownArrow]
        LinkSubitems = mnFiles
      end
      object tbiScrollLeft2: TSpTBXItem
        Tag = 2
        Hint = 'Scroll left'
        Enabled = False
        ImageIndex = 54
        ImageName = 'TabPrevious'
        Options = [tboToolbarStyle]
        OnClick = tbiScrollLeftClick
      end
      object tbiScrollRight2: TSpTBXItem
        Tag = 2
        Hint = 'Scroll right'
        Enabled = False
        ImageIndex = 53
        ImageName = 'TabNext'
        Options = [tboToolbarStyle]
        OnClick = tbiScrollRightClick
        FontSettings.Name = 'Marlett'
      end
      object tbiTabClose2: TSpTBXItem
        Tag = 2
        Action = CommandsDataModule.actFileClose
        Options = [tboToolbarStyle]
      end
    end
    object TabSplitter: TSpTBXSplitter
      Left = 924
      Top = 0
      Width = 4
      Height = 533
      Cursor = crSizeWE
      Align = alRight
      ParentColor = False
      Visible = False
    end
  end
  object TBXDockTop: TSpTBXDockablePanel
    Left = 0
    Top = 0
    Width = 946
    Height = 84
    Align = alTop
    DockMode = dmCannotFloatOrChangeDocks
    DockPos = 0
    PopupMenu = ToolbarPopupMenu
    TabOrder = 1
    Options.Close = False
    object TBControlItem3: TTBControlItem
      Control = DockTopPanel
    end
    object TBControlItem1: TTBControlItem
    end
    object DockTopPanel: TPanel
      Tag = 114580
      Left = 0
      Top = 0
      Width = 946
      Height = 80
      Align = alTop
      Color = clNone
      ParentBackground = False
      TabOrder = 0
    end
    object MainMenu: TSpTBXToolbar
      Left = 0
      Top = -1
      Width = 323
      Height = 21
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 0
      FullSize = True
      Images = vilImages
      TabOrder = 0
      object FileMenu: TSpTBXSubmenuItem
        Caption = '&File'
        object TBXSubmenuItem5: TSpTBXSubmenuItem
          Caption = '&New'
          object mnNewModule: TSpTBXItem
            Caption = '&Python module'
            Action = actFileNewModule
          end
          object mnNewFile: TSpTBXItem
            Caption = '&File...'
            Action = actFileNewFile
          end
          object mnFileNewTkApplication: TSpTBXItem
            Caption = '&Tk/Tkk Application'
            Hint = 'New Tk/TKK Application'
            OnClick = actFileNewTkinterExecute
          end
          object mnFileNewQtApplication: TSpTBXItem
            Caption = '&Qt-Application'
            Hint = 'New QT Application'
            OnClick = TBQtApplicationClick
          end
          object TBXSeparatorItem23: TSpTBXSeparatorItem
          end
          object mnFileNewClass: TSpTBXItem
            Caption = '&Class'
            Action = actUMLNewClass
          end
          object mnFileNewStrutogram: TSpTBXItem
            Caption = '&Structogram'
            OnClick = actFileNewStructogramExecute
          end
          object mnFileNewSequencediagram: TSpTBXItem
            Caption = 'Sequence &diagram'
            OnClick = actFileNewSequencediagramExecute
          end
        end
        object mnFileOpen: TSpTBXItem
          Action = actFileOpen
        end
        object RecentSubmenu: TSpTBXSubmenuItem
          Caption = '&Recent Files'
          object tbiRecentFileList: TSpTBXMRUListItem
            HidePathExtension = False
            MaxItems = 6
            OnClick = tbiRecentFileListClick
          end
        end
        object SpTBXSeparatorItem21: TSpTBXSeparatorItem
        end
        object mnRemoteFileOpen: TSpTBXItem
          Action = actRemoteFileOpen
        end
        object mnRemoteFileSave: TSpTBXItem
          Action = CommandsDataModule.actFileSaveToRemote
        end
        object N14: TSpTBXSeparatorItem
        end
        object mnFileSave: TSpTBXItem
          Action = CommandsDataModule.actFileSave
        end
        object mnFileSaveAs: TSpTBXItem
          Action = CommandsDataModule.actFileSaveAs
        end
        object mnFileExport: TSpTBXItem
          Caption = 'Expor&t'
          Action = CommandsDataModule.actFileExport
        end
        object mnFileReload: TSpTBXItem
          Action = CommandsDataModule.actFileReload
        end
        object mnFileClose: TSpTBXItem
          Action = CommandsDataModule.actFileClose
        end
        object N1: TSpTBXSeparatorItem
        end
        object mnFileSaveAll: TSpTBXItem
          Action = CommandsDataModule.actFileSaveAll
        end
        object mnFileCloseAll: TSpTBXItem
          Action = actFileCloseAll
        end
        object N2: TSpTBXSeparatorItem
        end
        object PageSetup1: TSpTBXItem
          Action = CommandsDataModule.actPageSetup
        end
        object PrinterSetup1: TSpTBXItem
          Action = CommandsDataModule.actPrinterSetup
        end
        object PrintPreview1: TSpTBXItem
          Action = CommandsDataModule.actPrintPreview
        end
        object Print1: TSpTBXItem
          Action = CommandsDataModule.actFilePrint
        end
        object N4: TSpTBXSeparatorItem
        end
        object N3: TSpTBXItem
          Action = actFileExit
        end
      end
      object EditMenu: TSpTBXSubmenuItem
        Caption = '&Edit'
        object mnEditUndo: TSpTBXItem
          Action = CommandsDataModule.actEditUndo
        end
        object mnEditRedo: TSpTBXItem
          Action = CommandsDataModule.actEditRedo
        end
        object N5: TSpTBXSeparatorItem
        end
        object mnEditCut: TSpTBXItem
          Action = CommandsDataModule.actEditCut
        end
        object mnCopyMenu: TSpTBXSubmenuItem
          Caption = '&Copy'
          object mnEditCopy: TSpTBXItem
            Action = CommandsDataModule.actEditCopy
          end
          object mnEditCopyRTF: TSpTBXItem
            Action = CommandsDataModule.actEditCopyRTF
          end
          object mnEditCopyRTFNumbered: TSpTBXItem
            Action = CommandsDataModule.actEditCopyRTFNumbered
          end
          object mnEditCopyHTML: TSpTBXItem
            Action = CommandsDataModule.actEditCopyHTML
          end
          object mnEditCopyHTMLAsText: TSpTBXItem
            Action = CommandsDataModule.actEditCopyHTMLasText
          end
          object mnEditCopyNumbered: TSpTBXItem
            Action = CommandsDataModule.actEditCopyNumbered
          end
        end
        object mnEditPaste: TSpTBXItem
          Action = CommandsDataModule.actEditPaste
        end
        object mnEditDelete: TSpTBXItem
          Action = CommandsDataModule.actEditDelete
        end
        object mnEditSelectAll: TSpTBXItem
          Action = CommandsDataModule.actEditSelectAll
        end
        object SpTBXSeparatorItem19: TSpTBXSeparatorItem
        end
        object mnEditReadOnly: TSpTBXItem
          Action = CommandsDataModule.actEditReadOnly
        end
        object TBXSeparatorItem9: TSpTBXSeparatorItem
        end
        object mnSourceCode: TSpTBXSubmenuItem
          Caption = '&Source Code'
          object mnIndentBlock: TSpTBXItem
            Action = CommandsDataModule.actEditIndent
          end
          object mnDedentBlock: TSpTBXItem
            Action = CommandsDataModule.actEditDedent
          end
          object mnToggleComment: TSpTBXItem
            Action = CommandsDataModule.actEditToggleComment
          end
          object mnTabify: TSpTBXItem
            Action = CommandsDataModule.actEditTabify
          end
          object mnUnTabify: TSpTBXItem
            Action = CommandsDataModule.actEditUntabify
          end
          object TBXSeparatorItem27: TSpTBXSeparatorItem
          end
          object mnExecSelection: TSpTBXItem
            Action = actExecSelection
          end
        end
        object SpTBXSeparatorItem29: TSpTBXSeparatorItem
        end
        object mnSpelling: TSpTBXSubmenuItem
          Caption = 'Spelling'
          Visible = False
          OnPopup = mnSpellingPopup
          object mnSpellCheckTopSeparator: TSpTBXSeparatorItem
          end
          object mnSpellCheckAdd: TSpTBXItem
            Action = CommandsDataModule.actSynSpellErrorAdd
          end
          object mnSpellCheckDelete: TSpTBXItem
            Action = CommandsDataModule.actSynSpellErrorDelete
          end
          object mnSpellCheckIgnore: TSpTBXItem
            Action = CommandsDataModule.actSynSpellErrorIgnore
          end
          object mnSpellCheckIgnoreOnce: TSpTBXItem
            Action = CommandsDataModule.actSynSpellErrorIgnoreOnce
          end
          object mnSpellCheckSecondSeparator: TSpTBXSeparatorItem
          end
          object SpTBXItem20: TSpTBXItem
            Action = CommandsDataModule.actSynSpellCheckWord
          end
          object SpTBXItem21: TSpTBXItem
            Action = CommandsDataModule.actSynSpellCheckLine
          end
          object SpTBXItem22: TSpTBXItem
            Action = CommandsDataModule.actSynSpellCheckSelection
          end
          object SpTBXItem23: TSpTBXItem
            Action = CommandsDataModule.actSynSpellCheckFile
          end
          object SpTBXSeparatorItem31: TSpTBXSeparatorItem
          end
          object SpTBXItem24: TSpTBXItem
            Action = CommandsDataModule.actSynSpellClearErrors
          end
          object SpTBXSeparatorItem32: TSpTBXSeparatorItem
          end
          object SpTBXItem25: TSpTBXItem
            Action = CommandsDataModule.actSynSpellCheckAsYouType
          end
        end
        object mnIsertCodeTemplate: TSpTBXItem
          Action = CommandsDataModule.actInsertTemplate
        end
        object mnEditParameters1: TSpTBXSubmenuItem
          Caption = 'Parameters'
          object mnInsertParameter: TSpTBXItem
            Action = CommandsDataModule.actParameterCompletion
          end
          object mnInsertModifier: TSpTBXItem
            Action = CommandsDataModule.actModifierCompletion
          end
          object N16: TSpTBXSeparatorItem
          end
          object mnReplaceParameter: TSpTBXItem
            Action = CommandsDataModule.actReplaceParameters
          end
        end
        object N6: TSpTBXSeparatorItem
        end
        object TBXSubmenuItem3: TSpTBXSubmenuItem
          Caption = 'File Format'
          object mnEditAnsi: TSpTBXItem
            Action = CommandsDataModule.actEditAnsi
            RadioItem = True
          end
          object mnEditUtf8NoBom: TSpTBXItem
            Action = CommandsDataModule.actEditUTF8NoBOM
            RadioItem = True
          end
          object mnEditUtf8: TSpTBXItem
            Action = CommandsDataModule.actEditUTF8
            RadioItem = True
          end
          object mnEditUtf16LE: TSpTBXItem
            Action = CommandsDataModule.actEditUTF16LE
          end
          object mnEditUtf16BE: TSpTBXItem
            Action = CommandsDataModule.actEditUTF16BE
          end
          object TBXSeparatorItem12: TSpTBXSeparatorItem
          end
          object mnEditLBDos: TSpTBXItem
            Action = CommandsDataModule.actEditLBDos
            RadioItem = True
          end
          object mnEditLBUnix: TSpTBXItem
            Action = CommandsDataModule.actEditLBUnix
            RadioItem = True
          end
          object mnEditLBMac: TSpTBXItem
            Action = CommandsDataModule.actEditLBMac
            RadioItem = True
          end
        end
      end
      object SearchMenu: TSpTBXSubmenuItem
        Caption = '&Search'
        object mnSearchFind: TSpTBXItem
          Action = CommandsDataModule.actSearchFind
        end
        object mnSearchFindNext: TSpTBXItem
          Action = CommandsDataModule.actSearchFindNext
        end
        object mnSearchFindPrevious: TSpTBXItem
          Action = CommandsDataModule.actSearchFindPrev
        end
        object mnSearchReplace: TSpTBXItem
          Action = CommandsDataModule.actSearchReplace
        end
        object mnSearchHighlight: TSpTBXItem
          Action = CommandsDataModule.actSearchHighlight
        end
        object N15: TSpTBXSeparatorItem
        end
        object mnFindinFiles: TSpTBXItem
          Action = CommandsDataModule.actFindInFiles
        end
        object N7: TSpTBXSeparatorItem
        end
        object mnGoToLine: TSpTBXItem
          Action = CommandsDataModule.actSearchGoToLine
        end
        object mnGotoSyntaxError: TSpTBXItem
          Action = CommandsDataModule.actSearchGoToSyntaxError
        end
        object mnGoToDebugLine: TSpTBXItem
          Action = CommandsDataModule.actSearchGoToDebugLine
        end
        object TBXSeparatorItem31: TSpTBXSeparatorItem
        end
        object mnFindFunction: TSpTBXItem
          Action = CommandsDataModule.actFindFunction
        end
        object mnFindNextReference: TSpTBXItem
          Action = CommandsDataModule.actFindNextReference
        end
        object mnFindPreviousReference: TSpTBXItem
          Action = CommandsDataModule.actFindPreviousReference
        end
        object mnMatchingBrace: TSpTBXItem
          Action = CommandsDataModule.actSearchMatchingBrace
        end
        object N23: TSpTBXSeparatorItem
        end
        object mnFindDefinition: TSpTBXItem
          Action = actFindDefinition
        end
        object mnFindReferences: TSpTBXItem
          Action = actFindReferences
        end
      end
      object ViewMenu: TSpTBXSubmenuItem
        Caption = '&View'
        object mnViewDefaultLayout: TSpTBXItem
          Caption = 'Default Layout'
          OnClick = mnViewDefaultLayoutClick
        end
        object mnViewDebugLayout: TSpTBXItem
          Caption = 'Debug Layout'
          OnClick = mnViewDebugLayoutClick
        end
        object mnLayouts: TSpTBXSubmenuItem
          Caption = 'Layouts'
          ImageIndex = 97
          ImageName = 'Layouts'
          object mnLayOutSeparator: TSpTBXSeparatorItem
          end
          object TBXItem47: TSpTBXItem
            Caption = 'Save Layout...'
            Hint = 'Save Current Layout'
            OnClick = actLayoutSaveExecute
          end
          object TBXItem48: TSpTBXItem
            Caption = 'Delete Layouts...'
            Hint = 'Delete a layout'
            OnClick = actLayoutsDeleteExecute
          end
          object TBXItem49: TSpTBXItem
            Caption = 'Set Debug Layout'
            Hint = 'Set the current layout as the debug layout'
            OnClick = actLayoutDebugExecute
          end
          object TBXSeparatorItem17: TSpTBXSeparatorItem
          end
          object mnViewRestoreEditor: TSpTBXItem
            Action = actRestoreEditor
          end
        end
        object SpTBXSeparatorItem10: TSpTBXSeparatorItem
        end
        object mnMaximizeEditor: TSpTBXItem
          Caption = '&Maximize/Restore Editor'
          Action = actMaximizeEditor
        end
        object mnNextEditor: TSpTBXItem
          Action = actViewNextEditor
        end
        object mnPreviousEditor: TSpTBXItem
          Action = actViewPreviousEditor
        end
        object mnSplitEditors: TSpTBXSubmenuItem
          Caption = 'Split Editor'
          object mnSplitEditorVer: TSpTBXItem
            Action = actViewSplitEditorVer
          end
          object mnSplitEditorHor: TSpTBXItem
            Action = actViewSplitEditorHor
          end
          object SpTBXSeparatorItem15: TSpTBXSeparatorItem
          end
          object mnHideSecondEditor: TSpTBXItem
            Action = actViewHideSecondEditor
          end
        end
        object mnSplitWorkspace: TSpTBXSubmenuItem
          Caption = 'Split Workspace'
          object SpTBXItem8: TSpTBXItem
            Action = actViewSplitWorkspaceVer
          end
          object SpTBXItem7: TSpTBXItem
            Action = actViewSplitWorkspaceHor
          end
          object SpTBXSeparatorItem14: TSpTBXSeparatorItem
          end
          object SpTBXItem9: TSpTBXItem
            Action = actViewHideSecondaryWorkspace
          end
        end
        object TBXSeparatorItem20: TSpTBXSeparatorItem
        end
        object mnZoomIn: TSpTBXItem
          Action = actEditorZoomIn
        end
        object mnZoomOut: TSpTBXItem
          Action = actEditorZoomOut
        end
        object N10: TSpTBXSeparatorItem
        end
        object mnuToolbars: TSpTBXSubmenuItem
          Caption = '&Toolbars'
          object mnViewMainMenu: TSpTBXItem
            Action = actViewMainMenu
          end
          object mnMainToolbarVisibilityToggle: TSpTBXItem
            Caption = '&Main Toolbar'
            Hint = 'Main toolbar|Show/Hide the Main toolbar'
            HelpContext = 360
            Control = MainToolBar
          end
          object mnDebugtoolbarVisibilityToggle: TSpTBXItem
            Caption = '&Debug Toolbar'
            Hint = 'Debug toolbar|Show/Hide the Debug toolbar'
            HelpContext = 360
            Control = DebugToolbar
          end
          object mnEditorToolbarVisibilityToggle: TSpTBXItem
            Caption = '&Editor Toolbar'
            Hint = 'Editor toolbar|Show/Hide the Editor toolbar'
            HelpContext = 360
            Control = EditorToolbar
          end
          object mnViewToolbarVisibilityToggle: TSpTBXItem
            Caption = '&View Toolbar'
            Hint = 'View toolbar|Show/Hide the View toolbar'
            HelpContext = 360
          end
          object mnuUserToolbarVisibilityToggle: TSpTBXItem
            Caption = 'Use&r Toolbar'
            Hint = 'User toolbar|Show/Hide the User toolbar'
            HelpContext = 360
          end
          object SpTBXSeparatorItem3: TSpTBXSeparatorItem
          end
          object mnViewCustomizeToolbars: TSpTBXItem
            Action = actViewCustomizeToolbars
          end
        end
        object mnViewStatusBar: TSpTBXItem
          Action = actViewStatusBar
        end
        object TBXSeparatorItem18: TSpTBXSeparatorItem
        end
        object mnSyntax: TSpTBXSubmenuItem
          Caption = '&Syntax'
          OnPopup = mnSyntaxPopup
          object TBXSeparatorItem19: TSpTBXSeparatorItem
          end
          object mnNoSyntax: TSpTBXItem
            Caption = '&No Syntax'
            Hint = 'Do not use syntax highlighting'
            OnClick = mnNoSyntaxClick
          end
        end
        object TBXSeparatorItem21: TSpTBXSeparatorItem
        end
        object mnLanguage: TSpTBXSubmenuItem
          Caption = 'Language'
        end
        object mnStyles: TSpTBXItem
          Action = actSelectStyle
        end
        object mnViewII: TSpTBXItem
          Action = actViewII
          ShortCut = 49225
        end
        object mnObjectInspector: TSpTBXItem
          Caption = 'Object Inspector'
          Action = actViewObjectinspector
          ShortCut = 49226
        end
        object SpTBXItem2: TSpTBXItem
          Action = actNavStructure
        end
        object mnViewFileExplorer: TSpTBXItem
          Action = actViewFileExplorer
          ShortCut = 49240
        end
        object mnViewCodeExplorer: TSpTBXItem
          Action = actViewCodeExplorer
          ShortCut = 49219
        end
        object mnViewToDoList: TSpTBXItem
          Action = actViewToDoList
          ShortCut = 49236
        end
        object mnViewFindResults: TSpTBXItem
          Action = actViewFindResults
        end
        object mnViewOutput: TSpTBXItem
          Action = actViewOutput
          ShortCut = 49231
        end
        object SpTBXSeparatorItem28: TSpTBXSeparatorItem
        end
        object mnViewBreakpoints: TSpTBXItem
          Action = actBreakPointsWin
          ShortCut = 49218
        end
        object mnViewCallStack: TSpTBXItem
          Action = actCallStackWin
          ShortCut = 49235
        end
        object mnViewMessages: TSpTBXItem
          Action = actMessagesWin
          ShortCut = 49229
        end
        object mnViewVariables: TSpTBXItem
          Action = actVariablesWin
          ShortCut = 49238
        end
        object mnViewWatches: TSpTBXItem
          Action = actWatchesWin
          ShortCut = 49239
        end
      end
      object ProjectMenu: TSpTBXSubmenuItem
        Caption = '&Project'
        object mnProjectNew: TSpTBXItem
          Action = ProjectExplorerWindow.actProjectNew
          ImageName = 'Print'
          Images = ProjectExplorerWindow.vilImages
        end
        object mnProjectOpen: TSpTBXItem
          Action = ProjectExplorerWindow.actProjectOpen
          ImageName = 'Undo'
          Images = ProjectExplorerWindow.vilImages
        end
        object SpTBXSubmenuItem1: TSpTBXSubmenuItem
          Caption = '&Recent Projects'
          object tbiRecentProjects: TSpTBXMRUListItem
            HidePathExtension = False
            MaxItems = 6
            OnClick = tbiRecentProjectsClick
          end
        end
        object SpTBXSeparatorItem16: TSpTBXSeparatorItem
        end
        object mnProjectSave: TSpTBXItem
          Action = ProjectExplorerWindow.actProjectSave
          ImageName = 'Delete'
          Images = ProjectExplorerWindow.vilImages
        end
        object mnProjectSaveAs: TSpTBXItem
          Action = ProjectExplorerWindow.actProjectSaveAs
        end
        object SpTBXSeparatorItem4: TSpTBXSeparatorItem
        end
        object mnNavProjectExplorer2: TSpTBXItem
          Action = actNavProjectExplorer
        end
      end
      object RunMenu: TSpTBXSubmenuItem
        Caption = '&Run'
        object mnSyntaxCheck: TSpTBXItem
          Action = actSyntaxCheck
        end
        object mnImportModule: TSpTBXItem
          Action = actImportModule
        end
        object N21: TSpTBXSeparatorItem
        end
        object mnRun: TSpTBXItem
          Action = actRun
        end
        object mnCommandLineParams: TSpTBXItem
          Action = actCommandLine
        end
        object N22: TSpTBXSeparatorItem
        end
        object mnExternalRun: TSpTBXItem
          Action = actExternalRun
        end
        object mnConfigureExternalRun: TSpTBXItem
          Action = actExternalRunConfigure
        end
        object N8: TSpTBXSeparatorItem
        end
        object mnDebug: TSpTBXItem
          Action = actDebug
        end
        object mnRunToCursor: TSpTBXItem
          Action = actRunToCursor
        end
        object mnStepInto: TSpTBXItem
          Action = actStepInto
        end
        object mnStepOver: TSpTBXItem
          Action = actStepOver
        end
        object mnStepOut: TSpTBXItem
          Action = actStepOut
        end
        object mnPause: TSpTBXItem
          Action = actDebugPause
        end
        object mnAbortDebugging: TSpTBXItem
          Action = actDebugAbort
        end
        object TBXSeparatorItem33: TSpTBXSeparatorItem
        end
        object mnPostMortem: TSpTBXItem
          Action = actPostMortem
        end
        object N9: TSpTBXSeparatorItem
        end
        object mnTogglebreakpoint: TSpTBXItem
          Action = actToggleBreakPoint
        end
        object mnClearAllBreakpoints: TSpTBXItem
          Action = actClearAllBreakpoints
        end
        object mnAddWatchAtCursor: TSpTBXItem
          Action = actAddWatchAtCursor
        end
        object SpTBXSeparatorItem17: TSpTBXSeparatorItem
        end
        object mnPythonVersions: TSpTBXSubmenuItem
          Caption = 'Python Versions'
          ImageIndex = 83
          ImageName = 'Python'
          OnPopup = mnPythonVersionsPopup
          object SpTBXSeparatorItem18: TSpTBXSeparatorItem
          end
          object SpTBXItem4: TSpTBXItem
            Action = actPythonSetup
            Images = vilImages
          end
        end
        object mnPythonEngines: TSpTBXSubmenuItem
          Caption = 'Python Engine'
          object mnEngineInternal: TSpTBXItem
            Action = actPythonInternal
          end
          object mnEngineRemote: TSpTBXItem
            Action = actPythonRemote
          end
          object mnEngineRemoteTk: TSpTBXItem
            Action = actPythonRemoteTk
          end
          object mnEngineRemoteWx: TSpTBXItem
            Action = actPythonRemoteWx
          end
          object mnPythonEngineSSH: TSpTBXItem
            Action = actPythonSSH
          end
          object TBXSeparatorItem26: TSpTBXSeparatorItem
          end
          object mnReinitEngine: TSpTBXItem
            Action = actPythonReinitialize
          end
        end
      end
      object SpTBXSubmenuItem3: TSpTBXSubmenuItem
        Caption = '&UML'
        object mnNewUML: TSpTBXItem
          Action = actUMLNewUML
        end
        object mnNewClass: TSpTBXItem
          Action = actUMLNewClass
        end
        object mnOpenClass: TSpTBXItem
          Action = actUMLOpenClass
        end
        object mnEditClass: TSpTBXItem
          Action = actUMLEditClass
        end
        object mnNewComment: TSpTBXItem
          Action = actUMLNewComment
        end
        object mnNewLayout: TSpTBXItem
          Action = actUMLNewLayout
        end
        object mnRefresh: TSpTBXItem
          Action = actUMLRefresh
        end
        object mnDiagramFromOpenFiles: TSpTBXItem
          Action = actUMLDiagramFromOpenFiles
        end
        object mnSaveAsPicture: TSpTBXItem
          Action = actUMLSaveAsPicture
        end
      end
      object ToolsMenu: TSpTBXSubmenuItem
        Caption = '&Tools'
        object mnToolsConfiguration: TSpTBXItem
          Caption = 'Configuration'
          Action = actToolsConfiguration
        end
        object mnToolsTextCompare: TSpTBXItem
          Action = actToolsTextDiff
        end
        object mnPythonPath: TSpTBXItem
          Action = CommandsDataModule.actPythonPath
        end
        object mnToolsGit: TSpTBXSubmenuItem
          Caption = 'Git'
          ImageIndex = 112
          object mnToolsGitStatus: TSpTBXItem
            Tag = 1
            Caption = 'Status'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitAdd: TSpTBXItem
            Tag = 2
            Caption = 'Add'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitCommit: TSpTBXItem
            Tag = 3
            Caption = 'Commit'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitLog: TSpTBXItem
            Tag = 4
            Caption = 'Log'
            OnClick = mnToolsGitClick
          end
          object SpTBXSeparatorItem24: TSpTBXSeparatorItem
          end
          object mnToolsGitReset: TSpTBXItem
            Tag = 5
            Caption = 'Reset'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitCheckout: TSpTBXItem
            Tag = 6
            Caption = 'Checkout'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitRemove: TSpTBXItem
            Tag = 7
            Caption = 'Remove'
            OnClick = mnToolsGitClick
          end
          object SpTBXSeparatorItem25: TSpTBXSeparatorItem
          end
          object mnToolsGitRemote: TSpTBXItem
            Tag = 8
            Caption = 'Remote'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitFetch: TSpTBXItem
            Tag = 9
            Caption = 'Fetch'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitPush: TSpTBXItem
            Tag = 10
            Caption = 'Push'
            OnClick = mnToolsGitClick
          end
          object SpTBXSeparatorItem26: TSpTBXSeparatorItem
          end
          object mnToolsGitGUI: TSpTBXItem
            Tag = 11
            Caption = 'GUI'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitViewer: TSpTBXItem
            Tag = 12
            Caption = 'Viewer'
            OnClick = mnToolsGitClick
          end
          object mnToolsGitConsole: TSpTBXItem
            Tag = 13
            Caption = 'Console'
            OnClick = mnToolsGitClick
          end
        end
        object mnToolsSVN: TSpTBXSubmenuItem
          Caption = 'SVN'
          ImageIndex = 113
          object mnToolsSVNCommit: TSpTBXItem
            Tag = 1
            Caption = 'Commit'
            OnClick = mnToolsSVNClick
          end
          object mnToolsSVNAdd: TSpTBXItem
            Tag = 2
            Caption = 'Add file'
            OnClick = mnToolsSVNClick
          end
          object mnToolsSVNLog: TSpTBXItem
            Tag = 3
            Caption = 'Log of file'
            OnClick = mnToolsSVNClick
          end
          object mnToolsSVNCompare: TSpTBXItem
            Tag = 4
            Caption = 'Compare file'
            OnClick = mnToolsSVNClick
          end
          object SpTBXSeparatorItem27: TSpTBXSeparatorItem
          end
          object mnToolsSVNStatus: TSpTBXItem
            Tag = 5
            Caption = 'Status of folder'
            OnClick = mnToolsSVNClick
          end
          object mnToolsSVNTree: TSpTBXItem
            Tag = 6
            Caption = 'Tree of repository'
            OnClick = mnToolsSVNClick
          end
          object mnToolsSVNUpdate: TSpTBXItem
            Tag = 7
            Caption = 'Update from repository'
            OnClick = mnToolsSVNClick
          end
        end
        object mnUnitTestWizard: TSpTBXItem
          Action = CommandsDataModule.actUnitTestWizard
        end
        object mnViewUnitTests: TSpTBXItem
          Action = actViewUnitTests
          ShortCut = 49237
        end
        object EditorViewsMenu: TSpTBXSubmenuItem
          Caption = 'Source Code Views'
          OnClick = EditorViewsMenuClick
        end
        object mnViewRegExpTester: TSpTBXItem
          Action = actViewRegExpTester
        end
        object mnToolsBrowser: TSpTBXItem
          Caption = 'Browser'
          Hint = 'Opens a browser window'
          OnClick = mnToolsBrowserClick
        end
        object N13: TSpTBXSeparatorItem
        end
        object mnTools: TSpTBXSubmenuItem
          Caption = 'Tools'
          Hint = 'External Tools'
          ImageIndex = 55
          ImageName = 'Tools'
        end
        object mnConfigureTools: TSpTBXItem
          Action = CommandsDataModule.actConfigureTools
        end
        object N20: TSpTBXSeparatorItem
        end
        object OptionsMenu: TSpTBXSubmenuItem
          Caption = '&Options'
          object mnIDEOptions: TSpTBXItem
            Action = CommandsDataModule.actIDEOptions
          end
          object mnIDEShortCuts: TSpTBXItem
            Action = CommandsDataModule.actIDEShortcuts
          end
          object mnEditorOptions: TSpTBXItem
            Action = CommandsDataModule.actEditorOptions
          end
          object TBXSeparatorItem29: TSpTBXSeparatorItem
          end
          object mnToolsOptionsImportExport: TSpTBXSubmenuItem
            Caption = 'Import/Export'
            object mnExportShortcuts: TSpTBXItem
              Action = CommandsDataModule.actExportShortCuts
            end
            object mnImportShortcuts: TSpTBXItem
              Action = CommandsDataModule.actImportShortcuts
            end
            object TBXSeparatorItem30: TSpTBXSeparatorItem
            end
            object mnExportHighlighters: TSpTBXItem
              Action = CommandsDataModule.actExportHighlighters
            end
            object mnImportHighlighters: TSpTBXItem
              Action = CommandsDataModule.actImportHighlighters
            end
          end
          object TBXSeparatorItem8: TSpTBXSeparatorItem
          end
          object mnCustomizeParameters: TSpTBXItem
            Action = CommandsDataModule.actCustomizeParameters
          end
          object mnCodeTemplates: TSpTBXItem
            Action = CommandsDataModule.actCodeTemplates
          end
          object mnFileTemplates: TSpTBXItem
            Caption = '&File Templates...'
            Hint = 'Add/Remove file templates'
            HelpContext = 640
          end
        end
        object TBXSeparatorItem15: TSpTBXSeparatorItem
        end
        object mnToolsEditStartupScript: TSpTBXItem
          Action = CommandsDataModule.actToolsEditStartupScripts
        end
        object mnToolsRestartLS: TSpTBXItem
          Action = CommandsDataModule.actToolsRestartLS
        end
        object SpTBXSeparatorItem12: TSpTBXSeparatorItem
        end
        object mnCheckForUpdates: TSpTBXItem
          Action = CommandsDataModule.actCheckForUpdates
        end
      end
      object HelpMenu: TSpTBXSubmenuItem
        Caption = '&Help'
        object mnHelpPythonManuals: TSpTBXItem
          Action = CommandsDataModule.actPythonManuals
        end
        object N18: TSpTBXSeparatorItem
        end
        object PyScripter1: TSpTBXSubmenuItem
          Caption = 'PyScripter1'
          object mnHelpContents: TSpTBXItem
            Action = CommandsDataModule.actHelpContents
          end
          object mnHelpEditorShortcuts: TSpTBXItem
            Action = CommandsDataModule.actHelpEditorShortcuts
          end
          object mnHelpExternalTools: TSpTBXItem
            Action = CommandsDataModule.actHelpExternalTools
          end
          object mnHelpParameters: TSpTBXItem
            Action = CommandsDataModule.actHelpParameters
          end
        end
        object mnHelpProjectHome: TSpTBXItem
          Action = CommandsDataModule.actHelpWebProjectHome
        end
        object mnHelpWebSupport: TSpTBXItem
          Action = CommandsDataModule.actHelpWebGroupSupport
        end
        object SpTBXItem14: TSpTBXItem
          Action = CommandsDataModule.actDonate
        end
        object N17: TSpTBXSeparatorItem
        end
        object mnHelpAbout: TSpTBXItem
          Action = CommandsDataModule.actAbout
        end
      end
    end
    object MainToolBar: TSpTBXToolbar
      Left = 2
      Top = 26
      Width = 162
      Height = 26
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 0
      DockRow = 1
      Images = vilImages
      TabOrder = 1
      Caption = 'Main Toolbar'
      object tbiFileOpen: TSpTBXItem
        Action = actFileOpen
      end
      object tbiFileSave: TSpTBXItem
        Action = CommandsDataModule.actFileSave
      end
      object tbiFileSaveAll: TSpTBXItem
        Action = CommandsDataModule.actFileSaveAll
      end
      object tbiEditUndo: TSpTBXItem
        Action = CommandsDataModule.actEditUndo
      end
      object tbiEditRedo: TSpTBXItem
        Action = CommandsDataModule.actEditRedo
      end
      object tbitbiDiagramFromOpenFiles: TSpTBXItem
        Action = actUMLDiagramFromOpenFiles
      end
    end
    object DebugToolbar: TSpTBXToolbar
      Left = 3
      Top = 52
      Width = 162
      Height = 26
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 0
      DockRow = 2
      Images = vilImages
      TabOrder = 2
      Caption = 'Debug Toolbar'
      object tbiRunRun: TSpTBXItem
        Action = actRun
      end
      object tbiRunDebug: TSpTBXItem
        Action = actDebug
      end
      object tbiRunRunToCursor: TSpTBXItem
        Action = actRunToCursor
      end
      object tbiRunStepInto: TSpTBXItem
        Action = actStepInto
      end
      object tbiRunStepOver: TSpTBXItem
        Action = actStepOver
      end
      object tbiRunAbort: TSpTBXItem
        Action = actDebugAbort
      end
    end
    object EditorToolbar: TSpTBXToolbar
      Left = 610
      Top = 27
      Width = 206
      Height = 26
      DockPos = 574
      DockRow = 1
      Images = vilImages
      TabOrder = 5
      Visible = False
      Caption = 'Editor Toolbar'
      object tbiBrowsePrevious: TSpTBXSubmenuItem
        Action = actBrowseBack
        Options = [tboDropdownArrow]
        DropdownCombo = True
        object mnPreviousList: TSpTBXMRUListItem
          HidePathExtension = False
          MaxItems = 15
          OnClick = PreviousListClick
        end
      end
      object tbiBrowseNext: TSpTBXSubmenuItem
        Action = actBrowseForward
        Options = [tboDropdownArrow]
        DropdownCombo = True
        object mnNextList: TSpTBXMRUListItem
          HidePathExtension = False
          MaxItems = 15
          OnClick = NextListClick
        end
      end
      object TBXSeparatorItem14: TSpTBXSeparatorItem
      end
      object tbiEditDedent: TSpTBXItem
        Action = CommandsDataModule.actEditDedent
      end
      object tbiEditIndent: TSpTBXItem
        Action = CommandsDataModule.actEditIndent
      end
      object TBXSeparatorItem10: TSpTBXSeparatorItem
      end
      object tbiEditToggleComment: TSpTBXItem
        Action = CommandsDataModule.actEditToggleComment
      end
      object TBXSeparatorItem11: TSpTBXSeparatorItem
      end
      object tbiEditLineNumbers: TSpTBXItem
        Action = CommandsDataModule.actEditLineNumbers
      end
    end
    object FindToolbar: TSpTBXToolbar
      Left = 2
      Top = 81
      Width = 524
      Height = 26
      CloseButtonWhenDocked = True
      DockPos = 0
      DockRow = 3
      Images = vilImages
      Options = [tboDropdownArrow]
      TabOrder = 3
      Visible = False
      OnVisibleChanged = FindToolbarVisibleChanged
      Caption = 'Find Toolbar'
      Customizable = False
      object tbiFindClose: TSpTBXItem
        Caption = 'Close'
        Hint = 'Close'
        ImageIndex = 114
        OnClick = tbiFindCloseClick
      end
      object tbiFindLabel: TSpTBXLabelItem
        Caption = 'Find:'
      end
      object TBControlItem2: TTBControlItem
        Control = tbiSearchText
      end
      object tbiFindNext: TSpTBXItem
        Action = CommandsDataModule.actSearchFindNext
      end
      object tbiFindPrevious: TSpTBXItem
        Action = CommandsDataModule.actSearchFindPrev
      end
      object tbiHighlight: TSpTBXItem
        Action = CommandsDataModule.actSearchHighlight
        RadioItem = True
      end
      object tbiReplaceSeparator: TSpTBXSeparatorItem
        Visible = False
      end
      object tbiReplaceLabel: TSpTBXLabelItem
        Caption = 'Replace with:'
        Visible = False
      end
      object TBControlItem4: TTBControlItem
        Control = tbiReplaceText
      end
      object tbiReplaceExecute: TSpTBXItem
        Action = CommandsDataModule.actSearchReplaceNow
      end
      object TBXSeparatorItem32: TSpTBXSeparatorItem
      end
      object tbiSearchOptions: TSpTBXSubmenuItem
        Caption = 'Options'
        ImageIndex = 101
        ImageName = 'Setup'
        OnPopup = tbiSearchOptionsPopup
        object tbiSearchFromCaret: TSpTBXItem
          Caption = 'Search From C&aret'
          AutoCheck = True
          OnClick = SearchOptionsChanged
        end
        object SpTBXSeparatorItem2: TSpTBXSeparatorItem
        end
        object tbiAutoCaseSensitive: TSpTBXItem
          Caption = '&Auto Case Sensitive'
          Hint = 'Case Sensitive when search text contains upper case characters'
          AutoCheck = True
          Checked = True
          OnClick = SearchOptionsChanged
        end
        object tbiCaseSensitive: TSpTBXItem
          Caption = '&Case Sensitive'
          AutoCheck = True
          OnClick = SearchOptionsChanged
        end
        object tbiWholeWords: TSpTBXItem
          Caption = '&Whole Words Only'
          AutoCheck = True
          OnClick = SearchOptionsChanged
        end
        object tbiSearchInSelection: TSpTBXItem
          Caption = 'Search in &Selection'
          AutoCheck = True
          OnClick = SearchOptionsChanged
        end
        object tbiRegExp: TSpTBXItem
          Caption = '&Regular Expressions'
          AutoCheck = True
          OnClick = SearchOptionsChanged
        end
        object SpTBXSeparatorItem1: TSpTBXSeparatorItem
        end
        object tbiIncrementalSearch: TSpTBXItem
          Caption = '&Incremental Search'
          AutoCheck = True
          OnClick = SearchOptionsChanged
        end
      end
      object tbiSearchText: TSpTBXComboBox
        Left = 63
        Top = 2
        Width = 160
        Height = 21
        AutoCloseUp = True
        ItemHeight = 13
        TabOrder = 0
        OnChange = tbiSearchTextChange
        OnExit = tbiSearchTextExit
        OnKeyPress = tbiSearchTextKeyPress
        AutoDropDownWidth = True
      end
      object tbiReplaceText: TSpTBXComboBox
        Left = 304
        Top = 2
        Width = 160
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        OnChange = tbiReplaceTextChange
        OnKeyPress = tbiReplaceTextKeyPress
        AutoDropDownWidth = True
      end
    end
    object TabControlWidgets: TSpTBXTabControl
      Left = 171
      Top = 22
      Width = 763
      Height = 55
      ActiveTabIndex = 0
      TabAutofit = True
      TabAutofitMaxSize = 80
      HiddenItems = <>
      object SpTBXTabItem1: TSpTBXTabItem
        Caption = 'Program'
        Checked = True
        CustomWidth = 80
      end
      object SpTBXTabItem2: TSpTBXTabItem
        Caption = 'Tkinter'
        CustomWidth = 80
      end
      object SpTBXTabItem3: TSpTBXTabItem
        Caption = 'TTK'
        CustomWidth = 80
      end
      object SpTBXTabItem4: TSpTBXTabItem
        Caption = 'Qt Base'
        CustomWidth = 80
      end
      object SpTBXTabItem5: TSpTBXTabItem
        Caption = 'Qt Controls'
        CustomWidth = 80
      end
      object SpTBXTabSheetTkinter: TSpTBXTabSheet
        Left = 0
        Top = 25
        Width = 763
        Height = 30
        Caption = 'Tkinter'
        ImageIndex = -1
        TabItem = 'SpTBXTabItem2'
        object ToolbarTkinter: TToolBar
          Left = 2
          Top = 0
          Width = 757
          Height = 26
          Align = alClient
          AutoSize = True
          ButtonHeight = 27
          ButtonWidth = 28
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ILTKinter
          TabOrder = 0
          Wrapable = False
          object TBLabel: TToolButton
            Tag = 1
            Left = 0
            Top = 0
            Hint = 'Tk Label'
            Grouped = True
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBEntry: TToolButton
            Tag = 2
            Left = 28
            Top = 0
            Hint = 'Tk Entry'
            Grouped = True
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBText: TToolButton
            Tag = 3
            Left = 56
            Top = 0
            Hint = 'Tk Text'
            Grouped = True
            ImageIndex = 3
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBButton: TToolButton
            Tag = 4
            Left = 84
            Top = 0
            Hint = 'Tk Button'
            Grouped = True
            ImageIndex = 4
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBCheckbutton: TToolButton
            Tag = 5
            Left = 112
            Top = 0
            Hint = 'Tk Checkbutton'
            Grouped = True
            ImageIndex = 5
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBRadiobuttonGroup: TToolButton
            Tag = 7
            Left = 140
            Top = 0
            Hint = 'Tk RadiobuttonGroup'
            ImageIndex = 7
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBListbox: TToolButton
            Tag = 8
            Left = 168
            Top = 0
            Hint = 'Tk Listbox'
            Grouped = True
            ImageIndex = 8
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBSpinBox: TToolButton
            Tag = 9
            Left = 196
            Top = 0
            Hint = 'Tk SpinBox'
            Grouped = True
            ImageIndex = 11
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBScrollbar: TToolButton
            Tag = 12
            Left = 224
            Top = 0
            Hint = 'Tk Scrollbar'
            Grouped = True
            ImageIndex = 12
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTMessage: TToolButton
            Tag = 10
            Left = 252
            Top = 0
            Hint = 'Tk Message'
            ImageIndex = 9
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBCanvas: TToolButton
            Tag = 11
            Left = 280
            Top = 0
            Hint = 'Tk Canvas'
            Grouped = True
            ImageIndex = 15
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBFrame: TToolButton
            Tag = 13
            Left = 308
            Top = 0
            Hint = 'Tk Frame'
            Grouped = True
            ImageIndex = 13
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBLabelFrame: TToolButton
            Tag = 14
            Left = 336
            Top = 0
            Hint = 'Tk LabelFrame'
            Grouped = True
            ImageIndex = 19
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBScale: TToolButton
            Tag = 15
            Left = 364
            Top = 0
            Hint = 'Tk Scale'
            ImageIndex = 21
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBPanedWindow: TToolButton
            Tag = 16
            Left = 392
            Top = 0
            Hint = 'Tk PanedWindow'
            ImageIndex = 22
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBMenu: TToolButton
            Tag = 19
            Left = 420
            Top = 0
            Hint = 'Tk Menu'
            Grouped = True
            ImageIndex = 17
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBPopupMenu: TToolButton
            Tag = 20
            Left = 448
            Top = 0
            Hint = 'Tk PopupMenu'
            Grouped = True
            ImageIndex = 18
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBMenubutton: TToolButton
            Tag = 17
            Left = 476
            Top = 0
            Hint = 'Tk Menubutton'
            ImageIndex = 23
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBOptionMenu: TToolButton
            Tag = 18
            Left = 504
            Top = 0
            Hint = 'Tk Optionmenu'
            ImageIndex = 24
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
        end
      end
      object SpTBXTabSheetTTK: TSpTBXTabSheet
        Left = 0
        Top = 25
        Width = 763
        Height = 30
        Caption = 'TTK'
        ImageIndex = -1
        TabItem = 'SpTBXTabItem3'
        object ToolbarTTK: TToolBar
          Left = 2
          Top = 0
          Width = 757
          Height = 26
          Align = alClient
          AutoSize = True
          ButtonHeight = 27
          ButtonWidth = 28
          Color = clBtnFace
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ILTKinter
          ParentColor = False
          TabOrder = 0
          Wrapable = False
          object TBTTKLabel: TToolButton
            Tag = 31
            Left = 0
            Top = 0
            Hint = 'TTK Label'
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKEntry: TToolButton
            Tag = 32
            Left = 28
            Top = 0
            Hint = 'TTK Entry'
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKText: TToolButton
            Tag = 3
            Left = 56
            Top = 0
            Hint = 'Tk Text'
            ImageIndex = 3
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKButton: TToolButton
            Tag = 34
            Left = 84
            Top = 0
            Hint = 'TTK Button'
            ImageIndex = 4
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKCheckbutton: TToolButton
            Tag = 35
            Left = 112
            Top = 0
            Hint = 'TTK Checkbutton'
            ImageIndex = 5
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKRadiogroup: TToolButton
            Tag = 37
            Left = 140
            Top = 0
            Hint = 'TTK RadiobuttonGroup'
            ImageIndex = 7
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKListbox: TToolButton
            Tag = 8
            Left = 168
            Top = 0
            Hint = 'Tk Listbox'
            ImageIndex = 8
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKCombobox: TToolButton
            Tag = 38
            Left = 196
            Top = 0
            Hint = 'TTK Combobox'
            ImageIndex = 10
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKSpinbox: TToolButton
            Tag = 39
            Left = 224
            Top = 0
            Hint = 'TTK Spinbox'
            ImageIndex = 11
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKScrollbar: TToolButton
            Tag = 42
            Left = 252
            Top = 0
            Hint = 'TTK Scrollbar'
            ImageIndex = 12
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKMessage: TToolButton
            Tag = 10
            Left = 280
            Top = 0
            Hint = 'TTK Message'
            ImageIndex = 9
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKCanvas: TToolButton
            Tag = 11
            Left = 308
            Top = 0
            Hint = 'Tk Canvas'
            ImageIndex = 15
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKFrame: TToolButton
            Tag = 43
            Left = 336
            Top = 0
            Hint = 'TTK Frame'
            ImageIndex = 13
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKLabelFrame: TToolButton
            Tag = 44
            Left = 364
            Top = 0
            Hint = 'TTK LabelFrame'
            ImageIndex = 19
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKScale: TToolButton
            Tag = 45
            Left = 392
            Top = 0
            Hint = 'TTK Scale'
            ImageIndex = 25
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKLabeldScale: TToolButton
            Tag = 46
            Left = 420
            Top = 0
            Hint = 'TTK LabeldScale'
            ImageIndex = 26
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKPanedWindow: TToolButton
            Tag = 47
            Left = 448
            Top = 0
            Hint = 'TTK PanedWindow'
            ImageIndex = 27
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKMenu: TToolButton
            Tag = 19
            Left = 476
            Top = 0
            Hint = 'Tk Menu'
            ImageIndex = 17
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKPopupMenu: TToolButton
            Tag = 20
            Left = 504
            Top = 0
            Hint = 'Tk PopupMenu'
            ImageIndex = 18
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKMenuButton: TToolButton
            Tag = 48
            Left = 532
            Top = 0
            Hint = 'TTK Menubutton'
            ImageIndex = 23
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKOptionMenu: TToolButton
            Tag = 49
            Left = 560
            Top = 0
            Hint = 'TTK OptionMenu'
            ImageIndex = 24
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKNotebook: TToolButton
            Tag = 50
            Left = 588
            Top = 0
            Hint = 'TTK Notebook'
            ImageIndex = 28
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKTreeview: TToolButton
            Tag = 51
            Left = 616
            Top = 0
            Hint = 'TTK Treeview'
            ImageIndex = 29
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKProgressbar: TToolButton
            Tag = 52
            Left = 644
            Top = 0
            Hint = 'TTK Progressbar'
            ImageIndex = 30
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKSeparator: TToolButton
            Tag = 53
            Left = 672
            Top = 0
            Hint = 'TTK Separator'
            ImageIndex = 31
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBTTKSizegrip: TToolButton
            Tag = 54
            Left = 700
            Top = 0
            Hint = 'TTK Sizegrip'
            ImageIndex = 32
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
        end
      end
      object SpTBXTabSheetQtBase: TSpTBXTabSheet
        Left = 0
        Top = 25
        Width = 763
        Height = 30
        Caption = 'Qt Base'
        ImageIndex = -1
        TabItem = 'SpTBXTabItem4'
        object ToolBarQtBase: TToolBar
          Left = 2
          Top = 0
          Width = 757
          Height = 26
          Align = alClient
          AutoSize = True
          ButtonHeight = 27
          ButtonWidth = 28
          Color = clBtnFace
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ILTKinter
          ParentColor = False
          TabOrder = 0
          Wrapable = False
          object TBQtLabel: TToolButton
            Tag = 71
            Left = 0
            Top = 0
            Hint = 'QLabel'
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtLineEdit: TToolButton
            Tag = 72
            Left = 28
            Top = 0
            Hint = 'QLineEdit'
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtPlainTextEdit: TToolButton
            Tag = 73
            Left = 56
            Top = 0
            Hint = 'QPlainTextEdit'
            ImageIndex = 3
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtPushButton: TToolButton
            Tag = 74
            Left = 84
            Top = 0
            Hint = 'QPushButton'
            ImageIndex = 4
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtCheckBox: TToolButton
            Tag = 75
            Left = 112
            Top = 0
            Hint = 'QCheckBox'
            ImageIndex = 5
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtButtonGroup: TToolButton
            Tag = 76
            Left = 140
            Top = 0
            Hint = 'ButtonGroup'
            ImageIndex = 7
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtListWidget: TToolButton
            Tag = 77
            Left = 168
            Top = 0
            Hint = 'QListWidget'
            ImageIndex = 8
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtComboBox: TToolButton
            Tag = 78
            Left = 196
            Top = 0
            Hint = 'QComboBox'
            ImageIndex = 10
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtSpinBox: TToolButton
            Tag = 79
            Left = 224
            Top = 0
            Hint = 'QSpinBox'
            ImageIndex = 11
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtScrollbar: TToolButton
            Tag = 80
            Left = 252
            Top = 0
            Hint = 'QScrollbar'
            ImageIndex = 12
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtCanvas: TToolButton
            Tag = 81
            Left = 280
            Top = 0
            Hint = 'Canvas'
            ImageIndex = 15
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtFrame: TToolButton
            Tag = 82
            Left = 308
            Top = 0
            Hint = 'QFrame'
            ImageIndex = 13
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtGroupBox: TToolButton
            Tag = 83
            Left = 336
            Top = 0
            Hint = 'QGroupBox'
            ImageIndex = 19
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtSlider: TToolButton
            Tag = 84
            Left = 364
            Top = 0
            Hint = 'QSlider'
            ImageIndex = 25
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQMenuBar: TToolButton
            Tag = 85
            Left = 392
            Top = 0
            Hint = 'QMenuBar'
            ImageIndex = 17
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtContextMenu: TToolButton
            Tag = 86
            Left = 420
            Top = 0
            Hint = 'QContextMenu'
            ImageIndex = 18
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTabWidget: TToolButton
            Tag = 87
            Left = 448
            Top = 0
            Hint = 'QTabWidget'
            ImageIndex = 28
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTreeWidget: TToolButton
            Tag = 88
            Left = 476
            Top = 0
            Hint = 'QTreeWidget'
            ImageIndex = 29
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTableWidget: TToolButton
            Tag = 89
            Left = 504
            Top = 0
            Hint = 'QTableWidget'
            ImageIndex = 34
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtProgressBar: TToolButton
            Tag = 90
            Left = 532
            Top = 0
            Hint = 'QProgressBar'
            ImageIndex = 30
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtStatusBar: TToolButton
            Tag = 91
            Left = 560
            Top = 0
            Hint = 'QStatusBar'
            ImageIndex = 32
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
        end
      end
      object SpTBXTabSheetQtControls: TSpTBXTabSheet
        Left = 0
        Top = 25
        Width = 763
        Height = 30
        Caption = 'Qt Controls'
        ImageIndex = -1
        TabItem = 'SpTBXTabItem5'
        object ToolBarQtControls: TToolBar
          Left = 2
          Top = 0
          Width = 757
          Height = 26
          Align = alClient
          ButtonHeight = 27
          ButtonWidth = 28
          Color = clBtnFace
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ILQtControls
          ParentColor = False
          TabOrder = 0
          object TBQtTextedit: TToolButton
            Tag = 101
            Left = 0
            Top = 0
            Hint = 'QTextEdit'
            ImageIndex = 0
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTextBrowser: TToolButton
            Tag = 102
            Left = 28
            Top = 0
            Hint = 'QTextBrowser'
            ImageIndex = 1
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtToolButton: TToolButton
            Tag = 103
            Left = 56
            Top = 0
            Hint = 'QToolButton'
            ImageIndex = 2
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtCommandLinkButton: TToolButton
            Tag = 104
            Left = 84
            Top = 0
            Hint = 'QCommandLinkButton'
            ImageIndex = 3
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtFontComboBox: TToolButton
            Tag = 105
            Left = 112
            Top = 0
            Hint = 'QFontComboBox'
            ImageIndex = 4
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtDoubleSpinBox: TToolButton
            Tag = 106
            Left = 140
            Top = 0
            Hint = 'QDoubleSpinBox'
            ImageIndex = 5
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtLCDNumber: TToolButton
            Tag = 107
            Left = 168
            Top = 0
            Hint = 'QLCDNumber'
            ImageIndex = 6
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtDateTimeEdit: TToolButton
            Tag = 108
            Left = 196
            Top = 0
            Hint = 'QDateTimeEdit'
            ImageIndex = 7
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtDateEdit: TToolButton
            Tag = 109
            Left = 224
            Top = 0
            Hint = 'QDateEdit'
            ImageIndex = 8
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTimeEdit: TToolButton
            Tag = 110
            Left = 252
            Top = 0
            Hint = 'QTimeEdit'
            ImageIndex = 9
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtDial: TToolButton
            Tag = 111
            Left = 280
            Top = 0
            Hint = 'QDial'
            ImageIndex = 10
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtLine: TToolButton
            Tag = 112
            Left = 308
            Top = 0
            Hint = 'QLine'
            ImageIndex = 11
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtScrollArea: TToolButton
            Tag = 113
            Left = 336
            Top = 0
            Hint = 'QScrollArea'
            ImageIndex = 12
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtToolBox: TToolButton
            Tag = 114
            Left = 364
            Top = 0
            Hint = 'QToolBox'
            ImageIndex = 13
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtStackWidget: TToolButton
            Tag = 115
            Left = 392
            Top = 0
            Hint = 'QStackWidget'
            ImageIndex = 14
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtListView: TToolButton
            Tag = 116
            Left = 420
            Top = 0
            Hint = 'QListView'
            ImageIndex = 15
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtColumnView: TToolButton
            Tag = 117
            Left = 448
            Top = 0
            Hint = 'QColumnView'
            ImageIndex = 16
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTreeView: TToolButton
            Tag = 118
            Left = 476
            Top = 0
            ImageIndex = 17
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtTableView: TToolButton
            Tag = 119
            Left = 504
            Top = 0
            Hint = 'QTableView'
            ImageIndex = 18
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
          object TBQtGraphicsView: TToolButton
            Tag = 120
            Left = 532
            Top = 0
            Hint = 'QGraphicsView'
            ImageIndex = 19
            OnClick = ToolButtonClick
            OnMouseDown = ToolButtonMouseDown
            OnStartDrag = ToolButtonStartDrag
          end
        end
      end
      object SpTBXTabSheetProgram: TSpTBXTabSheet
        Left = 0
        Top = 25
        Width = 763
        Height = 30
        Caption = 'Program'
        ImageIndex = -1
        TabItem = 'SpTBXTabItem1'
        object ToolbarProgram: TToolBar
          Left = 2
          Top = 0
          Width = 757
          Height = 26
          Align = alClient
          ButtonHeight = 27
          ButtonWidth = 30
          Color = clBtnFace
          Images = ILProgram
          ParentColor = False
          TabOrder = 0
          object TBClass: TToolButton
            Left = 0
            Top = 0
            Hint = 'New class'
            ImageIndex = 1
            OnClick = actUMLNewClassExecute
          end
          object TBStructogram: TToolButton
            Left = 30
            Top = 0
            Hint = 'New structogram'
            ImageIndex = 2
            OnClick = actFileNewStructogramExecute
          end
          object TBSequence: TToolButton
            Left = 60
            Top = 0
            Hint = 'New sequence diagram'
            ImageIndex = 3
            OnClick = actFileNewSequencediagramExecute
          end
          object TBConsole: TToolButton
            Tag = 1
            Left = 90
            Top = 0
            Action = actFileNewModule
            ImageIndex = 4
          end
          object TBTkApplication: TToolButton
            Left = 120
            Top = 0
            Hint = 'New Tk/TTK application'
            ImageIndex = 5
            OnClick = actFileNewTkinterExecute
          end
          object TBQtApplication: TToolButton
            Left = 150
            Top = 0
            Hint = 'New QT Application'
            Caption = 'Qt-Application'
            ImageIndex = 6
            OnClick = TBQtApplicationClick
          end
        end
      end
    end
  end
  object TBXDockLeft: TSpTBXDock
    Left = 0
    Top = 84
    Width = 9
    Height = 533
    FixAlign = True
    PopupMenu = ToolbarPopupMenu
    Position = dpLeft
  end
  object TBXDockRight: TSpTBXDock
    Left = 937
    Top = 84
    Width = 9
    Height = 533
    FixAlign = True
    PopupMenu = ToolbarPopupMenu
    Position = dpRight
  end
  object TBXDockBottom: TSpTBXDock
    Left = 0
    Top = 617
    Width = 946
    Height = 9
    FixAlign = True
    PopupMenu = ToolbarPopupMenu
    Position = dpBottom
  end
  object DockServer: TJvDockServer
    LeftSplitterStyle.Cursor = crHSplit
    LeftSplitterStyle.ParentColor = False
    LeftSplitterStyle.ResizeStyle = rsUpdate
    LeftSplitterStyle.Size = 5
    RightSplitterStyle.Cursor = crHSplit
    RightSplitterStyle.ParentColor = False
    RightSplitterStyle.ResizeStyle = rsUpdate
    RightSplitterStyle.Size = 5
    TopSplitterStyle.Cursor = crVSplit
    TopSplitterStyle.ParentColor = False
    TopSplitterStyle.ResizeStyle = rsUpdate
    TopSplitterStyle.Size = 5
    BottomSplitterStyle.Cursor = crVSplit
    BottomSplitterStyle.ParentColor = False
    BottomSplitterStyle.ResizeStyle = rsUpdate
    BottomSplitterStyle.Size = 5
    Left = 37
    Top = 142
  end
  object AppStorage: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    StorageOptions.DateTimeAsString = False
    StorageOptions.DefaultIfReadConvertError = True
    FlushOnDestroy = False
    Location = flCustom
    DefaultSection = 'Other Settings'
    SubStorages = <>
    Left = 466
    Top = 141
  end
  object CloseTimer: TTimer
    Enabled = False
    OnTimer = CloseTimerTimer
    Left = 39
    Top = 219
  end
  object TabControlPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 320
    Top = 282
    object mnNewModule2: TSpTBXItem
      Action = actFileNewModule
    end
    object mnPopupFileOpen: TSpTBXItem
      Action = actFileOpen
    end
    object mnFileClose2: TSpTBXItem
      Action = CommandsDataModule.actFileClose
    end
    object mnFileCloseAll2: TSpTBXItem
      Action = actFileCloseAll
    end
    object mnFileCloseAllOther: TSpTBXItem
      Action = CommandsDataModule.actFileCloseAllOther
    end
    object SpTBXItem6: TSpTBXItem
      Action = CommandsDataModule.actFileCloseAllToTheRight
    end
    object SpTBXSeparatorItem20: TSpTBXSeparatorItem
    end
    object SpTBXItem11: TSpTBXItem
      Action = CommandsDataModule.actEditReadOnly
    end
    object TBXSeparatorItem28: TSpTBXSeparatorItem
    end
    object SpTBXItem1: TSpTBXItem
      Action = CommandsDataModule.actEditCopyFileName
    end
    object SpTBXSeparatorItem11: TSpTBXSeparatorItem
    end
    object mnMaximizeEditor2: TSpTBXItem
      Caption = '&MaximizeRestore Editor'
      Action = actMaximizeEditor
    end
    object N12: TSpTBXSeparatorItem
    end
    object mnFiles: TSpTBXSubmenuItem
      Caption = '&Files'
      Hint = 'Open Files'
      OnClick = mnFilesClick
    end
  end
  object RunningProcessesPopUpMenu: TSpTBXPopupMenu
    LinkSubitems = OutputWindow.RunningProcess
    Left = 172
    Top = 280
  end
  object JvAppInstances: TJvAppInstances
    Active = False
    OnCmdLineReceived = JvAppInstancesCmdLineReceived
    Left = 467
    Top = 213
  end
  object SpTBXCustomizer: TSpTBXCustomizer
    Images = vilImages
    OnGetCustomizeForm = SpTBXCustomizerGetCustomizeForm
    Left = 296
    Top = 136
  end
  object ToolbarPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    LinkSubitems = mnuToolbars
    Left = 40
    Top = 280
  end
  object JvFormStorage: TJvFormStorage
    Active = False
    AppStorage = LocalAppStorage
    AppStoragePath = 'Main Form Placement\'
    VersionCheck = fpvcNocheck
    StoredValues = <>
    Left = 545
    Top = 213
  end
  object actlImmutable: TActionList
    Images = vilImages
    Left = 208
    Top = 140
    object actViewNextEditor: TAction
      Category = 'View'
      Caption = '&Next Editor'
      HelpContext = 360
      Hint = 'Next Editor|Move to the next editor'
      ImageIndex = 53
      ImageName = 'TabNext'
      ShortCut = 16393
      OnExecute = actNextEditorExecute
    end
    object actViewPreviousEditor: TAction
      Category = 'View'
      Caption = '&Previous Editor'
      HelpContext = 360
      Hint = 'Previous editor|Move to the previous editor'
      ImageIndex = 54
      ImageName = 'TabPrevious'
      ShortCut = 24585
      OnExecute = actPreviousEditorExecute
    end
  end
  object actlStandard: TActionList
    Images = vilImages
    Left = 122
    Top = 140
    object actViewMainMenu: TAction
      Category = 'View'
      Caption = 'Main Men&u'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide main menu'
      ShortCut = 16505
      OnExecute = actViewMainMenuExecute
    end
    object actCallStackWin: TAction
      Category = 'Debug Windows'
      Caption = '&Call Stack'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'Show/Hide Call Stack window'
      ImageIndex = 41
      ImageName = 'CallStack'
      OnExecute = actCallStackWinExecute
    end
    object actVariablesWin: TAction
      Category = 'Debug Windows'
      Caption = '&Variables'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'Show/Hide Variables window'
      ImageIndex = 42
      ImageName = 'VariablesWin'
      OnExecute = actVariablesWinExecute
    end
    object actSyntaxCheck: TAction
      Category = 'Run'
      Caption = '&Syntax Check'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Syntax Check|Perform syntax check and load scripts'
      ImageIndex = 17
      ImageName = 'Check'
      OnExecute = actSyntaxCheckExecute
    end
    object actRun: TAction
      Category = 'Run'
      Caption = '&Run'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Run|Run active module'
      ImageIndex = 33
      ImageName = 'Run'
      ShortCut = 16504
      OnExecute = actRunExecute
    end
    object actCommandLine: TAction
      Category = 'Run'
      Caption = 'Command Line &Parameters...'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Set command line parameters'
      OnExecute = actCommandLineExecute
    end
    object actImportModule: TAction
      Category = 'Run'
      Caption = 'Import &Module'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Import module'
      ImageIndex = 28
      ImageName = 'RunScript'
      OnExecute = actImportModuleExecute
    end
    object actFileNewModule: TAction
      Category = 'File'
      Caption = '&New Python module'
      HelpContext = 310
      HelpType = htContext
      Hint = 'New Python module'
      ImageIndex = 84
      ImageName = 'PythonScript'
      ShortCut = 16462
      OnExecute = actFileNewModuleExecute
    end
    object actFileOpen: TAction
      Category = 'File'
      Caption = '&Open...'
      HelpContext = 310
      HelpType = htContext
      Hint = 'Select a file to open'
      ImageIndex = 1
      ImageName = 'FileOpen'
      ShortCut = 16463
      OnExecute = actFileOpenExecute
    end
    object actFileCloseAll: TAction
      Category = 'File'
      Caption = 'Close A&ll'
      Enabled = False
      HelpContext = 310
      HelpType = htContext
      Hint = 'Close all files'
      ImageIndex = 93
      ImageName = 'TabsClose'
      ShortCut = 24691
      OnExecute = actFileCloseAllExecute
    end
    object actFileExit: TAction
      Category = 'File'
      Caption = 'E&xit'
      HelpContext = 310
      HelpType = htContext
      Hint = 'Exit'
      ImageIndex = 32
      ImageName = 'Exit'
      ShortCut = 32883
      OnExecute = actFileExitExecute
    end
    object actViewStatusBar: TAction
      Category = 'View'
      Caption = 'Status &Bar'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide status bar'
      OnExecute = actViewStatusBarExecute
    end
    object actExternalRun: TAction
      Category = 'Run'
      Caption = 'E&xternal Run'
      HelpContext = 340
      HelpType = htContext
      Hint = 'External Run|Run active module in external Python interpreter'
      ImageIndex = 22
      ImageName = 'ExternalRun'
      ShortCut = 32888
      OnExecute = actExternalRunExecute
    end
    object actExternalRunConfigure: TAction
      Category = 'Run'
      Caption = 'Configure &External Run...'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Configure External Run'
      ImageIndex = 61
      ImageName = 'ExternalRunSetup'
      OnExecute = actExternalRunConfigureExecute
    end
    object actRunDebugLastScript: TAction
      Category = 'Run'
      Caption = 'Debug Last Script'
      HelpType = htContext
      Hint = 'Debug last script'
      ImageIndex = 88
      ImageName = 'DebugLast'
      ShortCut = 8312
      OnExecute = actRunDebugLastScriptExecute
    end
    object actDebug: TAction
      Category = 'Run'
      Caption = '&Debug'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Debug|Debug active script'
      ImageIndex = 34
      ImageName = 'Debug'
      ShortCut = 120
      OnExecute = actDebugExecute
    end
    object actRestoreEditor: TAction
      Category = 'View'
      Caption = '&Restore Editor'
      HelpContext = 270
      HelpType = htContext
      Hint = 'Restore editor window'
      ImageIndex = 75
      ImageName = 'EditorMin'
      ShortCut = 41050
      OnExecute = actRestoreEditorExecute
    end
    object actRunToCursor: TAction
      Category = 'Run'
      Caption = 'Run To &Cursor'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Run to cursor'
      ImageIndex = 35
      ImageName = 'RunToCursor'
      ShortCut = 115
      OnExecute = actRunToCursorExecute
    end
    object actStepInto: TAction
      Category = 'Run'
      Caption = 'Step &Into'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Step into subroutine '
      ImageIndex = 36
      ImageName = 'StepIn'
      ShortCut = 118
      OnExecute = actStepIntoExecute
    end
    object actStepOver: TAction
      Category = 'Run'
      Caption = 'Step &Over'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Step over next function call'
      ImageIndex = 37
      ImageName = 'StepOver'
      ShortCut = 119
      OnExecute = actStepOverExecute
    end
    object actStepOut: TAction
      Category = 'Run'
      Caption = 'Step O&ut'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Step out of the current subroutine'
      ImageIndex = 38
      ImageName = 'StepOut'
      ShortCut = 8311
      OnExecute = actStepOutExecute
    end
    object actDebugPause: TAction
      Category = 'Run'
      Caption = '&Pause'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Pause running program'
      ImageIndex = 73
      ImageName = 'Pause'
      OnExecute = actDebugPauseExecute
    end
    object actDebugAbort: TAction
      Category = 'Run'
      Caption = '&Abort Debugging'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Abort debugging'
      ImageIndex = 30
      ImageName = 'Abort'
      ShortCut = 49272
      OnExecute = actDebugAbortExecute
    end
    object actRunLastScriptExternal: TAction
      Category = 'Run'
      Caption = 'Run Last Script Externally'
      HelpType = htContext
      Hint = 'Run last script externally'
      ImageIndex = 89
      ImageName = 'ExternalRunLast'
      ShortCut = 41080
      OnExecute = actRunLastScriptExternalExecute
    end
    object actRunLastScript: TAction
      Category = 'Run'
      Caption = 'Run Last Script'
      HelpType = htContext
      Hint = 'Run last script'
      ImageIndex = 87
      ImageName = 'RunLast'
      ShortCut = 24696
      OnExecute = actRunLastScriptExecute
    end
    object actToggleBreakPoint: TAction
      Category = 'Run'
      Caption = 'Toggle &breakpoint'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Toggle breakpoint'
      ImageIndex = 39
      ImageName = 'Breakpoint'
      ShortCut = 116
      OnExecute = actToggleBreakPointExecute
    end
    object actClearAllBreakpoints: TAction
      Category = 'Run'
      Caption = 'Clear A&ll Breakpoints'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Clear all breakpoints'
      ImageIndex = 40
      ImageName = 'BreakpointsRemove'
      OnExecute = actClearAllBreakpointsExecute
    end
    object actBreakPointsWin: TAction
      Category = 'Debug Windows'
      Caption = '&Breakpoints'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'Show/Hide Breakpoints window'
      ImageIndex = 44
      ImageName = 'BreakpointsWin'
      OnExecute = actBreakPointsWinExecute
    end
    object actWatchesWin: TAction
      Category = 'Debug Windows'
      Caption = '&Watches'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'Show/Hide Watches window'
      ImageIndex = 43
      ImageName = 'WatchesWin'
      OnExecute = actWatchesWinExecute
    end
    object actMessagesWin: TAction
      Category = 'Debug Windows'
      Caption = '&Messages'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'Show/Hide Messages window'
      ImageIndex = 49
      ImageName = 'MessagesWin'
      OnExecute = actMessagesWinExecute
    end
    object actViewII: TAction
      Category = 'View'
      Caption = '&Interactive Interpreter'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide Interactive Interpreter'
      ImageIndex = 83
      ImageName = 'Python'
      OnExecute = actViewIIExecute
    end
    object actViewCodeExplorer: TAction
      Category = 'View'
      Caption = '&Code Explorer'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide Code Explorer'
      ImageIndex = 50
      ImageName = 'CodeExplorer'
      OnExecute = actViewCodeExplorerExecute
    end
    object actViewFileExplorer: TAction
      Category = 'View'
      Caption = '&File Explorer'
      Checked = True
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide File Explorer'
      ImageIndex = 57
      ImageName = 'FileExplorer'
      OnExecute = actViewFileExplorerExecute
    end
    object actViewToDoList: TAction
      Category = 'View'
      Caption = '&To-Do List'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide To Do List'
      ImageIndex = 58
      ImageName = 'TodoWin'
      OnExecute = actViewToDoListExecute
    end
    object actViewFindResults: TAction
      Category = 'View'
      Caption = 'Find &in Files Results'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide Find in Files Results'
      ImageIndex = 60
      ImageName = 'FindResults'
      ShortCut = 49222
      OnExecute = actViewFindResultsExecute
    end
    object actViewOutput: TAction
      Category = 'View'
      Caption = '&Output Window'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide Output Window'
      ImageIndex = 62
      ImageName = 'CmdOuputWin'
      OnExecute = actViewOutputExecute
    end
    object actViewUnitTests: TAction
      Category = 'View'
      Caption = '&Unit Tests'
      HelpType = htContext
      Hint = 'View/Hide Unit Tests Window'
      ImageIndex = 68
      ImageName = 'UnitTestWin'
      OnExecute = actViewUnitTestsExecute
    end
    object actFindDefinition: TAction
      Category = 'Refactoring'
      Caption = 'Find &Definition'
      HelpContext = 830
      HelpType = htContext
      Hint = 'Find definition of an Identifier'
      ShortCut = 32836
      OnExecute = actFindDefinitionExecute
    end
    object actFindReferences: TAction
      Category = 'Refactoring'
      Caption = 'Find R&eferences'
      HelpContext = 840
      HelpType = htContext
      Hint = 'Find references of an Identifier'
      OnExecute = actFindReferencesExecute
    end
    object actBrowseBack: TAction
      Category = 'Refactoring'
      Caption = 'Browse &Back'
      HelpContext = 830
      HelpType = htContext
      Hint = 'Browse back'
      ImageIndex = 64
      ImageName = 'ArrowLeft'
      ShortCut = 32805
      OnExecute = tbiBrowsePreviousClick
    end
    object actBrowseForward: TAction
      Category = 'Refactoring'
      Caption = 'Browse &Forward'
      HelpContext = 830
      HelpType = htContext
      Hint = 'Browse forward'
      ImageIndex = 65
      ImageName = 'ArrowRight'
      ShortCut = 32807
      OnExecute = tbiBrowseNextClick
    end
    object actViewRegExpTester: TAction
      Category = 'View'
      Caption = '&Regular Expression Tester'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide Regular Expression Tester'
      ImageIndex = 66
      ImageName = 'RegExp'
      OnExecute = actViewRegExpTesterExecute
    end
    object actLayoutSave: TAction
      Category = 'View'
      Caption = 'Save Layout...'
      HelpType = htContext
      Hint = 'Save Current Layout'
      OnExecute = actLayoutSaveExecute
    end
    object actLayoutsDelete: TAction
      Category = 'View'
      Caption = 'Delete Layouts...'
      HelpType = htContext
      Hint = 'Delete a layout'
      OnExecute = actLayoutsDeleteExecute
    end
    object actLayoutDebug: TAction
      Category = 'View'
      Caption = 'Set Debug Layout'
      HelpType = htContext
      Hint = 'Set the current layout as the debug layout'
      OnExecute = actLayoutDebugExecute
    end
    object actMaximizeEditor: TAction
      Category = 'View'
      Caption = '&Maximize Editor'
      HelpContext = 270
      HelpType = htContext
      Hint = 'Maximize editor window'
      ImageIndex = 74
      ImageName = 'EditorMax'
      ShortCut = 32858
      OnExecute = actMaximizeEditorExecute
    end
    object actEditorZoomIn: TAction
      Category = 'View'
      Caption = 'Zoom &In'
      HelpType = htContext
      Hint = 'Increase the font size of the editor'
      ImageIndex = 71
      ImageName = 'ZoomIn'
      ShortCut = 32875
      OnExecute = actEditorZoomInExecute
    end
    object actEditorZoomOut: TAction
      Category = 'View'
      Caption = 'Zoom &Out'
      HelpType = htContext
      Hint = 'Decrease the font size of the editor'
      ImageIndex = 72
      ImageName = 'ZoomOut'
      ShortCut = 32877
      OnExecute = actEditorZoomOutExecute
    end
    object actViewSplitEditorVer: TAction
      Category = 'View'
      Caption = 'Split Editor Vertically'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Split the editor Windows vertically'
      ImageIndex = 80
      ImageName = 'SplitVertical'
      OnExecute = actViewSplitEditorVerExecute
    end
    object actAddWatchAtCursor: TAction
      Category = 'Run'
      Caption = 'Add &Watch At Cursor'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Add the expression at the editor current position as a watch'
      ImageIndex = 43
      ImageName = 'WatchesWin'
      ShortCut = 32855
      OnExecute = actAddWatchAtCursorExecute
    end
    object actPythonReinitialize: TAction
      Category = 'Run'
      Caption = 'Reinitiali&ze Python engine'
      HelpContext = 340
      HelpType = htContext
      ShortCut = 16497
      OnExecute = actPythonReinitializeExecute
    end
    object actPythonInternal: TAction
      Category = 'Run'
      AutoCheck = True
      Caption = '&Internal'
      Checked = True
      GroupIndex = 1
      HelpContext = 340
      HelpType = htContext
      Hint = 'Use internal Python Engine'
      OnExecute = actPythonEngineExecute
    end
    object actPythonRemote: TAction
      Tag = 1
      Category = 'Run'
      AutoCheck = True
      Caption = '&Remote'
      GroupIndex = 1
      HelpContext = 340
      HelpType = htContext
      Hint = 'Use a remote Python engine'
      OnExecute = actPythonEngineExecute
    end
    object actPythonRemoteTk: TAction
      Tag = 2
      Category = 'Run'
      AutoCheck = True
      Caption = 'Remote (&Tk)'
      GroupIndex = 1
      HelpContext = 340
      HelpType = htContext
      Hint = 'Use a remote Python engine for Tkinter applications'
      OnExecute = actPythonEngineExecute
    end
    object actPythonRemoteWx: TAction
      Tag = 3
      Category = 'Run'
      AutoCheck = True
      Caption = 'Remote (&Wx)'
      GroupIndex = 1
      HelpContext = 340
      HelpType = htContext
      Hint = 'Use a remote Python engine for wxPython applications'
      OnExecute = actPythonEngineExecute
    end
    object actFileNewFile: TAction
      Category = 'File'
      Caption = 'New File...'
      HelpType = htContext
      Hint = 'New file from template'
      ImageIndex = 0
      ImageName = 'FileNew'
      OnExecute = actFileNewFileExecute
    end
    object actNavWatches: TAction
      Category = 'IDE Navigation'
      Caption = '&Watches'
      HelpType = htContext
      Hint = 'Activate the Watches window'
      ImageIndex = 43
      ImageName = 'WatchesWin'
      ShortCut = 49239
      OnExecute = actNavWatchesExecute
    end
    object actNavBreakpoints: TAction
      Category = 'IDE Navigation'
      Caption = '&BreakPoints'
      HelpType = htContext
      Hint = 'Activate the Breakpoints window'
      ImageIndex = 44
      ImageName = 'BreakpointsWin'
      ShortCut = 49218
      OnExecute = actNavBreakpointsExecute
    end
    object actNavInterpreter: TAction
      Category = 'IDE Navigation'
      Caption = '&Interpreter'
      HelpType = htContext
      Hint = 'Activate the Interpreter window'
      ImageIndex = 83
      ImageName = 'Python'
      ShortCut = 49225
      OnExecute = actNavInterpreterExecute
    end
    object actNavVariables: TAction
      Category = 'IDE Navigation'
      Caption = '&Variables'
      HelpType = htContext
      Hint = 'Activate the Variables window'
      ImageIndex = 42
      ImageName = 'VariablesWin'
      ShortCut = 49238
      OnExecute = actNavVariablesExecute
    end
    object actNavCallStack: TAction
      Category = 'IDE Navigation'
      Caption = '&Call Stack'
      HelpType = htContext
      Hint = 'Activate the Call Stack window'
      ImageIndex = 41
      ImageName = 'CallStack'
      ShortCut = 49235
      OnExecute = actNavCallStackExecute
    end
    object actNavMessages: TAction
      Category = 'IDE Navigation'
      Caption = '&Messages '
      HelpType = htContext
      Hint = 'Activate the Messages window'
      ImageIndex = 49
      ImageName = 'MessagesWin'
      ShortCut = 49229
      OnExecute = actNavMessagesExecute
    end
    object actNavFileExplorer: TAction
      Category = 'IDE Navigation'
      Caption = 'File E&xplorer'
      HelpType = htContext
      Hint = 'Activate the File Explorer window'
      ImageIndex = 57
      ImageName = 'FileExplorer'
      ShortCut = 49240
      OnExecute = actNavFileExplorerExecute
    end
    object actNavCodeExplorer: TAction
      Category = 'IDE Navigation'
      Caption = '&Code Explorer'
      HelpType = htContext
      Hint = 'Activate the Code Explorer window'
      ImageIndex = 50
      ImageName = 'CodeExplorer'
      ShortCut = 49219
      OnExecute = actNavCodeExplorerExecute
    end
    object actNavTodo: TAction
      Category = 'IDE Navigation'
      Caption = '&Todo List'
      HelpType = htContext
      Hint = 'Activate the Todo List window'
      ImageIndex = 58
      ImageName = 'TodoWin'
      ShortCut = 49236
      OnExecute = actNavTodoExecute
    end
    object actNavUnitTests: TAction
      Category = 'IDE Navigation'
      Caption = '&Unit Tests'
      HelpType = htContext
      Hint = 'Activate the Todo List window'
      ImageIndex = 68
      ImageName = 'UnitTestWin'
      ShortCut = 49237
      OnExecute = actNavUnitTestsExecute
    end
    object actNavOutput: TAction
      Category = 'IDE Navigation'
      Caption = 'Command &Output'
      HelpType = htContext
      Hint = 'Activate the Command Output window'
      ImageIndex = 62
      ImageName = 'CmdOuputWin'
      ShortCut = 49231
      OnExecute = actNavOutputExecute
    end
    object actNavEditor: TAction
      Category = 'IDE Navigation'
      Caption = '&Editor'
      HelpType = htContext
      Hint = 'Activate the Editor'
      ImageIndex = 86
      ImageName = 'Editor'
      ShortCut = 123
      OnExecute = actNavEditorExecute
    end
    object actPythonSSH: TAction
      Tag = 4
      Category = 'Run'
      AutoCheck = True
      Caption = '&SSH'
      GroupIndex = 1
      HelpContext = 340
      HelpType = htContext
      Hint = 'Use an SSH remote Python engine'
      OnExecute = actPythonEngineExecute
    end
    object actExecSelection: TAction
      Category = 'Run'
      Caption = 'E&xecute selection'
      HelpContext = 320
      HelpType = htContext
      Hint = 'Execute the editor selection'
      ImageIndex = 16
      ImageName = 'Execute'
      ShortCut = 16502
      OnExecute = actExecSelectionExecute
    end
    object actViewSplitEditorHor: TAction
      Category = 'View'
      Caption = 'Split Editor Horizontally'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Split the editor Windows horizontally'
      ImageIndex = 81
      ImageName = 'SplitHorizontal'
      OnExecute = actViewSplitEditorHorExecute
    end
    object actViewHideSecondEditor: TAction
      Category = 'View'
      Caption = 'Hide Second Editor'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Clear the editor'
      OnExecute = actViewHideSecondEditorExecute
    end
    object actPostMortem: TAction
      Category = 'Run'
      Caption = '&Post Mortem'
      HelpContext = 340
      HelpType = htContext
      Hint = 'Enter post mortem analysis'
      ImageIndex = 82
      ImageName = 'PostMortem'
      OnExecute = actPostMortemExecute
    end
    object actViewCustomizeToolbars: TAction
      Category = 'View'
      Caption = 'Customize...'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Customize the toolbars'
      OnExecute = actViewCustomizeToolbarsExecute
    end
    object actViewProjectExplorer: TAction
      Category = 'View'
      Caption = '&Project Explorer'
      HelpContext = 360
      HelpType = htContext
      Hint = 'View/Hide Project Explorer'
      ImageIndex = 85
      ImageName = 'ProjectExplorer'
      OnExecute = actViewProjectExplorerExecute
    end
    object actNavProjectExplorer: TAction
      Category = 'IDE Navigation'
      Caption = '&Project Explorer'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Activate the Project Explorer window'
      ImageIndex = 85
      ImageName = 'ProjectExplorer'
      ShortCut = 49232
      OnExecute = actNavProjectExplorerExecute
    end
    object actViewSplitWorkspaceVer: TAction
      Category = 'View'
      Caption = 'Split Workspace Vertically'
      HelpContext = 360
      HelpType = htContext
      Hint = 
        'Split workspace vertically|Show secondary editor tabset vertical' +
        'ly aligned'
      ImageIndex = 80
      ImageName = 'SplitVertical'
      OnExecute = actViewSplitWorkspaceVerExecute
    end
    object actViewSplitWorkspaceHor: TAction
      Category = 'View'
      Caption = 'Split Workspace Horizontally'
      HelpContext = 360
      HelpType = htContext
      Hint = 
        'Split workspace horizontally|Show secondary workspace horizontal' +
        'ly aligned'
      ImageIndex = 81
      ImageName = 'SplitHorizontal'
      OnExecute = actViewSplitWorkspaceHorExecute
    end
    object actViewHideSecondaryWorkspace: TAction
      Category = 'View'
      Caption = 'Hide Secondary Workspace'
      HelpContext = 360
      HelpType = htContext
      Hint = 'Hide secondary workspace'
      OnExecute = actViewHideSecondaryWorkspaceExecute
    end
    object actSelectStyle: TAction
      Category = 'View'
      Caption = 'Styles...'
      Hint = 'Select Style'
      ImageIndex = 69
      ImageName = 'Styles'
      OnExecute = actSelectStyleExecute
    end
    object actPythonSetup: TAction
      Category = 'Run'
      Caption = 'Setup Python Versions...'
      Hint = 'Setup Python engine'
      ImageIndex = 94
      ImageName = 'PySetup'
      OnExecute = actPythonSetupExecute
    end
    object actRemoteFileOpen: TAction
      Category = 'File'
      Caption = 'Open Remote File'
      Hint = 'Open Remote File with SSH'
      ImageIndex = 95
      ImageName = 'Download'
      OnExecute = actRemoteFileOpenExecute
    end
    object actUMLNewUML: TAction
      Category = 'UML'
      Caption = 'New'
      Hint = 'New UML window'
      ImageIndex = 0
      ImageName = 'FileNew'
      OnExecute = actUMLNewUMLExecute
    end
    object actUMLNewClass: TAction
      Category = 'UML'
      Caption = 'New class'
      ImageIndex = 102
      ImageName = 'UMLNew'
      OnExecute = actUMLNewClassExecute
    end
    object actUMLOpenClass: TAction
      Category = 'UML'
      Caption = 'Open class'
      ImageIndex = 103
      ImageName = 'UMLOpen'
      OnExecute = actUMLOpenClassExecute
    end
    object actUMLEditClass: TAction
      Category = 'UML'
      Caption = 'Edit class'
      ImageIndex = 104
      ImageName = 'ClassEdit'
      OnExecute = actUMLEditClassExecute
    end
    object actUMLNewComment: TAction
      Category = 'UML'
      Caption = 'New comment'
      ImageIndex = 105
      ImageName = 'NewComment'
      OnExecute = actUMLNewCommentExecute
    end
    object actUMLNewLayout: TAction
      Category = 'UML'
      Caption = 'New layout'
      ImageIndex = 106
      ImageName = 'Aktualisieren'
      OnExecute = actUMLNewLayoutExecute
    end
    object actUMLRefresh: TAction
      Category = 'UML'
      Caption = 'Refresh'
      ImageIndex = 107
      ImageName = 'NewLayout'
      OnExecute = actUMLRefreshExecute
    end
    object actUMLDiagramFromOpenFiles: TAction
      Category = 'UML'
      Caption = 'Diagram from open files'
      ImageIndex = 108
      ImageName = 'DiagramFromFiles'
      OnExecute = actUMLDiagramFromOpenFilesExecute
    end
    object actUMLSaveAsPicture: TAction
      Category = 'UML'
      Caption = 'Save as picture'
      ImageIndex = 109
      ImageName = 'SaveAsPicture'
      OnExecute = actUMLSaveAsPictureExecute
    end
    object actToolsTextDiff: TAction
      Category = 'Tools'
      Caption = 'Textdiff'
      ImageIndex = 110
      ImageName = 'TextDiff'
      OnExecute = actToolsTextDiffExecute
    end
    object actToolsConfiguration: TAction
      Category = 'Tools'
      Caption = 'Tools configuration'
      ImageIndex = 111
      ImageName = 'Configuration'
      OnExecute = actToolsConfigurationExecute
    end
    object actToolsGit: TAction
      Category = 'Tools'
      Caption = 'Git'
      ImageIndex = 110
      ImageName = 'TextDiff'
    end
    object actViewObjectinspector: TAction
      Category = 'View'
      Caption = 'actViewObjectinspector'
      OnExecute = actViewObjectinspectorExecute
    end
    object actNavStructure: TAction
      Category = 'IDE Navigation'
      Caption = 'Structure'
      Hint = 'Activate the Structure window'
      OnExecute = actNavStructureExecute
    end
    object actFileNewTkApp: TAction
      Category = 'File'
      Caption = 'Tk/Tkk Application'
      Hint = 'New Tk/TKK Application'
      OnExecute = actFileNewTkinterExecute
    end
    object actFileNewQtApp: TAction
      Category = 'File'
      Caption = 'Qt-Application'
      Hint = 'New QT Application'
    end
    object actEditorZoomReset: TAction
      Category = 'View'
      Caption = '&Reset Zoom'
      Hint = 'Reset the font size of the editor to its default'
      OnExecute = actEditorZoomResetExecute
    end
  end
  object LocalAppStorage: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    StorageOptions.DateTimeAsString = False
    StorageOptions.DefaultIfReadConvertError = True
    FlushOnDestroy = False
    Location = flCustom
    DefaultSection = 'Other Settings'
    SubStorages = <>
    Left = 546
    Top = 141
  end
  object vilImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 37
        CollectionName = 'FileNew'
        Disabled = False
        Name = 'FileNew'
      end
      item
        CollectionIndex = 38
        CollectionName = 'FileOpen'
        Disabled = False
        Name = 'FileOpen'
      end
      item
        CollectionIndex = 99
        CollectionName = 'Save'
        Disabled = False
        Name = 'Save'
      end
      item
        CollectionIndex = 100
        CollectionName = 'SaveAll'
        Disabled = False
        Name = 'SaveAll'
      end
      item
        CollectionIndex = 72
        CollectionName = 'PrintSetup'
        Disabled = False
        Name = 'PrintSetup'
      end
      item
        CollectionIndex = 71
        CollectionName = 'PrintPreview'
        Disabled = False
        Name = 'PrintPreview'
      end
      item
        CollectionIndex = 70
        CollectionName = 'Print'
        Disabled = False
        Name = 'Print'
      end
      item
        CollectionIndex = 128
        CollectionName = 'Undo'
        Disabled = False
        Name = 'Undo'
      end
      item
        CollectionIndex = 87
        CollectionName = 'Redo'
        Disabled = False
        Name = 'Redo'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Cut'
        Disabled = False
        Name = 'Cut'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Copy'
        Disabled = False
        Name = 'Copy'
      end
      item
        CollectionIndex = 65
        CollectionName = 'Paste'
        Disabled = False
        Name = 'Paste'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Disabled = False
        Name = 'Delete'
      end
      item
        CollectionIndex = 101
        CollectionName = 'Search'
        Disabled = False
        Name = 'Search'
      end
      item
        CollectionIndex = 41
        CollectionName = 'FindNext'
        Disabled = False
        Name = 'FindNext'
      end
      item
        CollectionIndex = 91
        CollectionName = 'Replace'
        Disabled = False
        Name = 'Replace'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Execute'
        Disabled = False
        Name = 'Execute'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Check'
        Disabled = False
        Name = 'Check'
      end
      item
        CollectionIndex = 27
        CollectionName = 'EditOptions'
        Disabled = False
        Name = 'EditOptions'
      end
      item
        CollectionIndex = 1
        CollectionName = 'AppSettings'
        Disabled = False
        Name = 'AppSettings'
      end
      item
        CollectionIndex = 46
        CollectionName = 'Folders'
        Disabled = False
        Name = 'Folders'
      end
      item
        CollectionIndex = 49
        CollectionName = 'Function'
        Disabled = False
        Name = 'Function'
      end
      item
        CollectionIndex = 32
        CollectionName = 'ExternalRun'
        Disabled = False
        Name = 'ExternalRun'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Expand'
        Disabled = False
        Name = 'Expand'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Collapse'
        Disabled = False
        Name = 'Collapse'
      end
      item
        CollectionIndex = 55
        CollectionName = 'Info'
        Disabled = False
        Name = 'Info'
      end
      item
        CollectionIndex = 51
        CollectionName = 'GoToLine'
        Disabled = False
        Name = 'GoToLine'
      end
      item
        CollectionIndex = 52
        CollectionName = 'Help'
        Disabled = False
        Name = 'Help'
      end
      item
        CollectionIndex = 97
        CollectionName = 'RunScript'
        Disabled = False
        Name = 'RunScript'
      end
      item
        CollectionIndex = 88
        CollectionName = 'Refresh'
        Disabled = False
        Name = 'Refresh'
      end
      item
        CollectionIndex = 0
        CollectionName = 'Abort'
        Disabled = False
        Name = 'Abort'
      end
      item
        CollectionIndex = 58
        CollectionName = 'LineNumbers'
        Disabled = False
        Name = 'LineNumbers'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Exit'
        Disabled = False
        Name = 'Exit'
      end
      item
        CollectionIndex = 93
        CollectionName = 'Run'
        Disabled = False
        Name = 'Run'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Debug'
        Disabled = False
        Name = 'Debug'
      end
      item
        CollectionIndex = 98
        CollectionName = 'RunToCursor'
        Disabled = False
        Name = 'RunToCursor'
      end
      item
        CollectionIndex = 108
        CollectionName = 'StepIn'
        Disabled = False
        Name = 'StepIn'
      end
      item
        CollectionIndex = 110
        CollectionName = 'StepOver'
        Disabled = False
        Name = 'StepOver'
      end
      item
        CollectionIndex = 109
        CollectionName = 'StepOut'
        Disabled = False
        Name = 'StepOut'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Breakpoint'
        Disabled = False
        Name = 'Breakpoint'
      end
      item
        CollectionIndex = 7
        CollectionName = 'BreakpointsRemove'
        Disabled = False
        Name = 'BreakpointsRemove'
      end
      item
        CollectionIndex = 10
        CollectionName = 'CallStack'
        Disabled = False
        Name = 'CallStack'
      end
      item
        CollectionIndex = 132
        CollectionName = 'VariablesWin'
        Disabled = False
        Name = 'VariablesWin'
      end
      item
        CollectionIndex = 136
        CollectionName = 'WatchesWin'
        Disabled = False
        Name = 'WatchesWin'
      end
      item
        CollectionIndex = 8
        CollectionName = 'BreakpointsWin'
        Disabled = False
        Name = 'BreakpointsWin'
      end
      item
        CollectionIndex = 54
        CollectionName = 'Indent'
        Disabled = False
        Name = 'Indent'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Dedent'
        Disabled = False
        Name = 'Dedent'
      end
      item
        CollectionIndex = 13
        CollectionName = 'CodeComment'
        Disabled = False
        Name = 'CodeComment'
      end
      item
        CollectionIndex = 127
        CollectionName = 'UnCodeComment'
        Disabled = False
        Name = 'UnCodeComment'
      end
      item
        CollectionIndex = 61
        CollectionName = 'MessagesWin'
        Disabled = False
        Name = 'MessagesWin'
      end
      item
        CollectionIndex = 14
        CollectionName = 'CodeExplorer'
        Disabled = False
        Name = 'CodeExplorer'
      end
      item
        CollectionIndex = 80
        CollectionName = 'PyDoc'
        Disabled = False
        Name = 'PyDoc'
      end
      item
        CollectionIndex = 64
        CollectionName = 'PageSetup'
        Disabled = False
        Name = 'PageSetup'
      end
      item
        CollectionIndex = 114
        CollectionName = 'TabNext'
        Disabled = False
        Name = 'TabNext'
      end
      item
        CollectionIndex = 115
        CollectionName = 'TabPrevious'
        Disabled = False
        Name = 'TabPrevious'
      end
      item
        CollectionIndex = 123
        CollectionName = 'Tools'
        Disabled = False
        Name = 'Tools'
      end
      item
        CollectionIndex = 124
        CollectionName = 'ToolsSetup'
        Disabled = False
        Name = 'ToolsSetup'
      end
      item
        CollectionIndex = 36
        CollectionName = 'FileExplorer'
        Disabled = False
        Name = 'FileExplorer'
      end
      item
        CollectionIndex = 121
        CollectionName = 'TodoWin'
        Disabled = False
        Name = 'TodoWin'
      end
      item
        CollectionIndex = 102
        CollectionName = 'SearchFolder'
        Disabled = False
        Name = 'SearchFolder'
      end
      item
        CollectionIndex = 44
        CollectionName = 'FindResults'
        Disabled = False
        Name = 'FindResults'
      end
      item
        CollectionIndex = 34
        CollectionName = 'ExternalRunSetup'
        Disabled = False
        Name = 'ExternalRunSetup'
      end
      item
        CollectionIndex = 12
        CollectionName = 'CmdOuputWin'
        Disabled = False
        Name = 'CmdOuputWin'
      end
      item
        CollectionIndex = 104
        CollectionName = 'SpecialChars'
        Disabled = False
        Name = 'SpecialChars'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ArrowLeft'
        Disabled = False
        Name = 'ArrowLeft'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ArrowRight'
        Disabled = False
        Name = 'ArrowRight'
      end
      item
        CollectionIndex = 89
        CollectionName = 'RegExp'
        Disabled = False
        Name = 'RegExp'
      end
      item
        CollectionIndex = 56
        CollectionName = 'Keyboard'
        Disabled = False
        Name = 'Keyboard'
      end
      item
        CollectionIndex = 129
        CollectionName = 'UnitTestWin'
        Disabled = False
        Name = 'UnitTestWin'
      end
      item
        CollectionIndex = 112
        CollectionName = 'Styles'
        Disabled = False
        Name = 'Styles'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Assembly'
        Disabled = False
        Name = 'Assembly'
      end
      item
        CollectionIndex = 139
        CollectionName = 'ZoomIn'
        Disabled = False
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 140
        CollectionName = 'ZoomOut'
        Disabled = False
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 66
        CollectionName = 'Pause'
        Disabled = False
        Name = 'Pause'
      end
      item
        CollectionIndex = 25
        CollectionName = 'EditorMax'
        Disabled = False
        Name = 'EditorMax'
      end
      item
        CollectionIndex = 28
        CollectionName = 'EditorMin'
        Disabled = False
        Name = 'EditorMin'
      end
      item
        CollectionIndex = 42
        CollectionName = 'FindPrevious'
        Disabled = False
        Name = 'FindPrevious'
      end
      item
        CollectionIndex = 53
        CollectionName = 'Highlight'
        Disabled = False
        Name = 'Highlight'
      end
      item
        CollectionIndex = 50
        CollectionName = 'GoToError'
        Disabled = False
        Name = 'GoToError'
      end
      item
        CollectionIndex = 138
        CollectionName = 'WordWrap'
        Disabled = False
        Name = 'WordWrap'
      end
      item
        CollectionIndex = 107
        CollectionName = 'SplitVertical'
        Disabled = False
        Name = 'SplitVertical'
      end
      item
        CollectionIndex = 106
        CollectionName = 'SplitHorizontal'
        Disabled = False
        Name = 'SplitHorizontal'
      end
      item
        CollectionIndex = 69
        CollectionName = 'PostMortem'
        Disabled = False
        Name = 'PostMortem'
      end
      item
        CollectionIndex = 84
        CollectionName = 'Python'
        Disabled = False
        Name = 'Python'
      end
      item
        CollectionIndex = 85
        CollectionName = 'PythonScript'
        Disabled = False
        Name = 'PythonScript'
      end
      item
        CollectionIndex = 74
        CollectionName = 'ProjectExplorer'
        Disabled = False
        Name = 'ProjectExplorer'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Editor'
        Disabled = False
        Name = 'Editor'
      end
      item
        CollectionIndex = 96
        CollectionName = 'RunLast'
        Disabled = False
        Name = 'RunLast'
      end
      item
        CollectionIndex = 19
        CollectionName = 'DebugLast'
        Disabled = False
        Name = 'DebugLast'
      end
      item
        CollectionIndex = 33
        CollectionName = 'ExternalRunLast'
        Disabled = False
        Name = 'ExternalRunLast'
      end
      item
        CollectionIndex = 59
        CollectionName = 'Link'
        Disabled = False
        Name = 'Link'
      end
      item
        CollectionIndex = 137
        CollectionName = 'Web'
        Disabled = False
        Name = 'Web'
      end
      item
        CollectionIndex = 113
        CollectionName = 'TabClose'
        Disabled = False
        Name = 'TabCLose'
      end
      item
        CollectionIndex = 117
        CollectionName = 'TabsClose'
        Disabled = False
        Name = 'TabsClose'
      end
      item
        CollectionIndex = 81
        CollectionName = 'PySetup'
        Disabled = False
        Name = 'PySetup'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Download'
        Disabled = False
        Name = 'Download'
      end
      item
        CollectionIndex = 131
        CollectionName = 'Upload'
        Disabled = False
        Name = 'Upload'
      end
      item
        CollectionIndex = 57
        CollectionName = 'Layouts'
        Disabled = False
        Name = 'Layouts'
      end
      item
        CollectionIndex = 116
        CollectionName = 'Tabs'
        Disabled = False
        Name = 'Tabs'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Bug'
        Disabled = False
        Name = 'Bug'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Edit'
        Disabled = False
        Name = 'Edit'
      end
      item
        CollectionIndex = 103
        CollectionName = 'Setup'
        Disabled = False
        Name = 'Setup'
      end
      item
        CollectionIndex = 142
        CollectionName = 'UMLNew'
        Disabled = False
        Name = 'UMLNew'
      end
      item
        CollectionIndex = 143
        CollectionName = 'UMLOpen'
        Disabled = False
        Name = 'UMLOpen'
      end
      item
        CollectionIndex = 144
        CollectionName = 'ClassEdit'
        Disabled = False
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 145
        CollectionName = 'NewComment'
        Disabled = False
        Name = 'NewComment'
      end
      item
        CollectionIndex = 146
        CollectionName = 'Aktualisieren'
        Disabled = False
        Name = 'Aktualisieren'
      end
      item
        CollectionIndex = 147
        CollectionName = 'NewLayout'
        Disabled = False
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 148
        CollectionName = 'DiagramFromFiles'
        Disabled = False
        Name = 'DiagramFromFiles'
      end
      item
        CollectionIndex = 149
        CollectionName = 'SaveAsPicture'
        Disabled = False
        Name = 'SaveAsPicture'
      end
      item
        CollectionIndex = 150
        CollectionName = 'TextDiff'
        Disabled = False
        Name = 'TextDiff'
      end
      item
        CollectionIndex = 151
        CollectionName = 'Configuration'
        Disabled = False
        Name = 'Configuration'
      end
      item
        CollectionIndex = 152
        CollectionName = 'git'
        Disabled = False
        Name = 'git'
      end
      item
        CollectionIndex = 153
        CollectionName = 'svn'
        Disabled = False
        Name = 'svn'
      end
      item
        CollectionIndex = 154
        Disabled = False
      end
      item
        CollectionIndex = 155
        CollectionName = 'EditClass'
        Disabled = False
        Name = 'EditClass'
      end>
    ImageCollection = CommandsDataModule.icSVGImages
    PreserveItems = True
    Width = 20
    Height = 20
    Left = 360
    Top = 432
  end
  object icIndicators: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'StatusLED'
        SVGText = 
          '<svg viewBox="0 0 100 100">'#13#10'  <defs>'#13#10'    <radialGradient cx=".' +
          '5" cy=".5"  fx=".3" fy=".2" r="0.5" id="myGradient" gradientUnit' +
          's="objectBoundingBox">'#13#10'      <stop offset="0%" stop-opacity="0.' +
          '3" stop-color="#22AA22"/>'#13#10'      <stop offset="1" stop-opacity="' +
          '1" stop-color="#22AA22"/>'#13#10'    </radialGradient>'#13#10'  </defs>'#13#10#13#10' ' +
          ' <!-- using my radial gradient 4CBB17 -->'#13#10'  <circle cx="50" cy=' +
          '"50" r="40" fill="url(#myGradient)" />'#13#10'</svg>'
      end
      item
        IconName = 'ExternalToolsLED'
        SVGText = 
          '<svg viewBox="0 0 100 100">'#13#10'  <defs>'#13#10'    <radialGradient cx=".' +
          '5" cy=".5"  fx=".3" fy=".2" r="0.5" id="myGradient" gradientUnit' +
          's="objectBoundingBox">'#13#10'      <stop offset="0%" stop-opacity="0.' +
          '3" stop-color="#E24444"/>'#13#10'      <stop offset="1" stop-opacity="' +
          '1" stop-color="#E24444"/>'#13#10'    </radialGradient>'#13#10'  </defs>'#13#10#13#10' ' +
          ' <!-- using my radial gradient -->'#13#10'  <circle cx="50" cy="50" r=' +
          '"40" fill="url(#myGradient)" />'#13#10'</svg>'
      end
      item
        IconName = 'LspLED'
        SVGText = 
          '<svg viewBox="0 0 100 100">'#13#10'  <defs>'#13#10'    <radialGradient cx=".' +
          '5" cy=".5"  fx=".3" fy=".2" r="0.5" id="myGradient" gradientUnit' +
          's="objectBoundingBox">'#13#10'      <stop offset="0%" stop-opacity="0.' +
          '3" stop-color="#FF5F1F"/>'#13#10'      <stop offset="1" stop-opacity="' +
          '1" stop-color="#FF5F1F"/>'#13#10'    </radialGradient>'#13#10'  </defs>'#13#10#13#10' ' +
          ' <!-- using my radial gradient 4CBB17 -->'#13#10'  <circle cx="50" cy=' +
          '"50" r="40" fill="url(#myGradient)" />'#13#10'</svg>'
      end>
    Left = 48
    Top = 432
  end
  object vilIndicators: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'StatusLED'
        Disabled = False
        Name = 'StatusLED'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ExternalToolsLED'
        Disabled = False
        Name = 'ExternalToolsLED'
      end
      item
        CollectionIndex = 2
        CollectionName = 'LspLED'
        Disabled = False
        Name = 'LspLED'
      end>
    ImageCollection = icIndicators
    PreserveItems = True
    Width = 12
    Height = 12
    Left = 120
    Top = 432
  end
  object ILProgramDark: TImageList
    Height = 17
    Width = 23
    Left = 120
    Top = 353
    Bitmap = {
      494C010108004800040017001100FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000005C0000003300000001002000000000005049
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080000000000000000000C8D0D00080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000C8D0D0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C4CCCC00C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000B5BCBC00C8D0D0009FA5A50032343400898E
      8E00C8D0D000B5BCBC00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0001A1B
      1B00B9C1C100C8D0D000C7CFCF0000000000C8D0D0006569690000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000797E7E00222323003E41
      410025272700191A1A009FA5A500C8D0D0005A5E5E002F30300092989800C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00015161600B9C1C100C8D0D000C7CFCF000000
      00007479790025272700C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000AEB5B500191A1A00B5BCBC00C8D0D000BEC6C600222323009CA2A200C8D0
      D00025272700B8BFBF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C0C0C000000000000000
      0000000000000000000000000000C8D0D000C0C0C00000000000000000000000
      00000000000000000000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0001011
      1100B9C1C100C8D0D000C7CFCF000000000000000000A3AAAA00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000828888005E616100C8D0D000C8D0
      D000C8D0D00063676700696E6E00C8D0D000191A1A00C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C0C0C000C8D0D000C8D0D000C8D0D000C8D0D00000000000C8D0
      D000C0C0C000C8D0D000C8D0D000C8D0D000C8D0D00000000000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D0000B0C0C00B9C1C100C8D0D000C7CFCF000000
      00004E5151005B5F5F00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000797E7E00B5BCBC00C8D0D000C8D0D000C8D0D000B5BCBC00797E7E00C8D0
      D000191A1A00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C8D0D000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0000707
      0700B9C1C100C8D0D000C7CFCF0000000000C8D0D000515454006D727200C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000797E7E0061656500C8D0D000C8D0
      D000C8D0D000797E7E0063676700C8D0D000191A1A00C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF0000000000C0C0
      C000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000BFC7C700BFC7C70002020200B0B7B700BDC5C500C7CFCF000808
      0800C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000929898003B3D3D00C8D0D000C8D0D000C8D0D000575B5B00737777006D71
      7100060606003234340092989800C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D00005050500000000003436
      36003436360034363600ADB4B40015161600C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C4CCCC0022232300868B8B00C4CC
      CC00989F9F00191A1A00B5BCBC00C8D0D000191A1A00C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF0000000000C0C0
      C000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000949A
      9A00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000B5BCBC005154540032343400484B4B00A8AFAF00C8D0D000C8D0
      D0009FA5A500C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D00000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D0000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000C0C0C00000000000C0C0C0000000
      0000C0C0C00000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF00000000000000C0C0C00000000000C0C0
      C00000000000C0C0C0000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000C0C0C00000000000C0C0C0000000
      0000C0C0C0000000000000000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000C0C0C00000000000C0C0C00000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000009999990033FFFF000000000033FFFF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000009999990033FFFF0033FFFF0099999900FFFFFF0033FF
      FF009999990033FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      9900FFFFFF009999990033FFFF009999990033FFFF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000999999009999990099999900FFFFFF00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0066FF
      FF009999990033FFFF00FFFFFF00999999009999990000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009999990033FFFF009999990033FFFF009999
      990033FFFF00FFFFFF0099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009999990033FF
      FF000000000099999900FFFFFF00000000009999990033FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033FFFF0000000000000000009999990033FFFF000000
      0000000000009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000005C0000003300000001000100
      00000000640200000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000007FFFFF00000000000000000
      07FFFFF000000000000000000400003000000000000000000400003000000000
      0000000004000030000000000000000004000030000000000000000004000030
      0000000000000000040000300000000000000000040000300000000000000000
      0400003000000000000000000400003000000000000000000400003000000000
      0000000004000030000000000000000004000030000000000000000004000030
      000000000000000004000030000000000000000007FFFFF0FFFFFFFFFFFFFFFF
      FFFFFFF0F8003FE0003FC000FFEFFBF0FBFFBFEFFFBFDFBEFFEFFBF0FBFFBFEF
      FFBFDFBEFFEFFBF0FBFFBFEFFFBFDFBEFFEBFBF0FBFFBFE0003FDFBEFFE003F0
      FBFFBFEFFFBFDFBEFFEBFBF0FBFFBFEFFFBFDFBEFFEFFBF0FBFFBFE97FBFDFBE
      FFEFFBF0FBFFBFC0003FDFBEFFEFEBF0FBFFBFE07FBFDFBEFFE003F0FBFFBFC1
      FFBFC000FFEFEBF0FBFC3FC07FBFDE4EFFEFFBF0FBFD7FE0003FD1F2FF83E0F0
      FBFCFFC93FFFCFFCFFBBEEF0F801FFD9BFFFC000FF83E0F0FFFFFFFDFFFFFFFF
      FFFFFFF000000000000000000000000000000000000000000000}
  end
  object ILProgram: TImageList
    Height = 17
    Width = 23
    Left = 40
    Top = 353
    Bitmap = {
      494C010108004800040017001100FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000005C0000003300000001002000000000005049
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080000000000000000000C8D0D00080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000C8D0D0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C4CCCC00C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000B5BCBC00C8D0D0009FA5A50032343400898E
      8E00C8D0D000B5BCBC00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0001A1B
      1B00B9C1C100C8D0D000C7CFCF0000000000C8D0D0006569690000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000797E7E00222323003E41
      410025272700191A1A009FA5A500C8D0D0005A5E5E002F30300092989800C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00015161600B9C1C100C8D0D000C7CFCF000000
      00007479790025272700C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000AEB5B500191A1A00B5BCBC00C8D0D000BEC6C600222323009CA2A200C8D0
      D00025272700B8BFBF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C0C0C000000000000000
      0000000000000000000000000000C8D0D000C0C0C00000000000000000000000
      00000000000000000000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0001011
      1100B9C1C100C8D0D000C7CFCF000000000000000000A3AAAA00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000828888005E616100C8D0D000C8D0
      D000C8D0D00063676700696E6E00C8D0D000191A1A00C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C0C0C000C8D0D000C8D0D000C8D0D000C8D0D00000000000C8D0
      D000C0C0C000C8D0D000C8D0D000C8D0D000C8D0D00000000000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D0000B0C0C00B9C1C100C8D0D000C7CFCF000000
      00004E5151005B5F5F00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000797E7E00B5BCBC00C8D0D000C8D0D000C8D0D000B5BCBC00797E7E00C8D0
      D000191A1A00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C8D0D000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0000707
      0700B9C1C100C8D0D000C7CFCF0000000000C8D0D000515454006D727200C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000797E7E0061656500C8D0D000C8D0
      D000C8D0D000797E7E0063676700C8D0D000191A1A00C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF0000000000C0C0
      C000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000BFC7C700BFC7C70002020200B0B7B700BDC5C500C7CFCF000808
      0800C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000929898003B3D3D00C8D0D000C8D0D000C8D0D000575B5B00737777006D71
      7100060606003234340092989800C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D00005050500000000003436
      36003436360034363600ADB4B40015161600C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C4CCCC0022232300868B8B00C4CC
      CC00989F9F00191A1A00B5BCBC00C8D0D000191A1A00C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D0008080800000000000000000000000000000000000FFFFFF0000000000C0C0
      C000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000949A
      9A00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000808080000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000B5BCBC005154540032343400484B4B00A8AFAF00C8D0D000C8D0
      D0009FA5A500C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D0008080
      8000000000000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D0008080800000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000808080000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D00080808000000000000000000000000000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D00000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D0000000000000000000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000C0C0C00000000000C0C0C0000000
      0000C0C0C00000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF00000000000000C0C0C00000000000C0C0
      C00000000000C0C0C0000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000C0C0C00000000000C0C0C0000000
      0000C0C0C0000000000000000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000C0C0C00000000000C0C0C00000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000333333000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006633
      3300000000009999990033FFFF000000000033FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009999990033FFFF0033FFFF0099999900FFFFFF0033FF
      FF009999990033FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      9900FFFFFF009999990033FFFF009999990033FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000999999009999990099999900FFFFFF00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0066FF
      FF009999990033FFFF00FFFFFF00999999009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009999990033FFFF009999990033FFFF009999
      990033FFFF000000000099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009999990033FF
      FF000000000099999900FFFFFF00000000009999990033FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033FFFF0000000000000000009999990033FFFF000000
      0000000000009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000005C0000003300000001000100
      00000000640200000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000007FFFFF00000000000000000
      07FFFFF000000000000000000400003000000000000000000400003000000000
      0000000004000030000000000000000004000030000000000000000004000030
      0000000000000000040000300000000000000000040000300000000000000000
      0400003000000000000000000400003000000000000000000400003000000000
      0000000004000030000000000000000004000030000000000000000004000030
      000000000000000004000030000000000000000007FFFFF0FFFFFFFFFFFFFFFF
      FFFFFFF0F8003FE0003FC000FFEFFBF0FBFFBFEFFFBFDFBEFFEFFBF0FBFFBFEF
      FFBFDFBEFFEFFBF0FBFFBFEFFFBFDFBEFFEBFBF0FBFFBFE0003FDFBEFFE003F0
      FBFFBFEFFFBFDFBEFFEBFBF0FBFFBFEFFFBFDFBEFFEFFBF0FBFFBFE97FBFDFBE
      FFEFFBF0FBFFBFC0003FDFBEFFEFEBF0FBFFBFE07FBFDFBEFFE003F0FBFFBFC1
      FFBFC000FFEFEBF0FBFC3FC07FBFDE4EFFEFFBF0FBFD7FE0003FD1F2FF83E0F0
      FBFCFFC93FFFCFFCFFBBEEF0F801FFD9BFFFC000FF83E0F0FFFFFFFDFFFFFFFF
      FFFFFFF000000000000000000000000000000000000000000000}
  end
  object ILTKinterDark: TImageList
    Height = 21
    Width = 21
    Left = 304
    Top = 352
    Bitmap = {
      494C010123002800040015001500FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000054000000BD000000010020000000000010F8
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBF
      BF00BFBFBF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00BFBFBF00BFBFBF00FFFF
      FF00FFFFFF000000000000000000C0C0C000C0C0C0008080800000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000C0C0C000C0C0C000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00BFBFBF00BFBF
      BF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00FFFFFF000000000000000000FFFF
      FF0000000000C0C0C00000000000C0C0C000FFFFFF00C0C0C000FFFFFF000000
      0000FFFFFF0000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000FFFFFF003333330033333300333333003333
      33003333330033333300333333003333330033333300333333004D4D4D003333
      330033333300333333003333330033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000FFFFFF00FFFFFF00C0C0C0000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBF
      BF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00BFBFBF00BFBFBF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000C0C0C00080808000000000000000000000000000FFFF
      FF00333333009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999004D4D
      4D00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF0000000000C0C0
      C000000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC0099999900999999009999990099999900CBCBCB00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF00C0C0C000FFFF
      FF00000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00B3B3
      B300B3B3B300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00CECECE001C1C1C001C1C1C00CECECE00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF00C0C0C000FFFF
      FF00000000000000000000000000FFFFFF0033333300DCDCDC00A5A5A5006E6E
      6E006E6E6E00A5A5A500DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000FFFFFF003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300333333003333330033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000C0C0C00080808000000000000000000000000000FFFF
      FF0033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF0000000000C0C0
      C000000000000000000000000000FFFFFF0033333300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0099999900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00C0C0C000000000000000000000000000FFFF
      FF00333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CED3D600CED3D600CED3D600CED3D600CED3
      D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
      D600CED3D600CED3D600CED3D600CED3D600CED3D60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00C0C0C000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00C0C0C000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00C0C0C000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00C0C0C000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00C0C0C000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00C0C0C000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EEEEEE00C0C0C000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00C0C0C000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00C0C0C000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00C0C0C000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D00000000000C8D0D0000000000000000000C8D0
      D00000000000C8D0D00000000000C8D0D000C8D0D000C8D0D000C8D0D0000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00C0C0C000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D00000000000C8D0
      D000C8D0D000C8D0D000C8D0D00000000000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00C0C0C000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00C0C0C000EEEEEE00EEEEEE000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60069696900000000000000000000000000000000000000
      0000000000000000000033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0033333300000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      000000000000000000000000000000000000000000000000000033333300FFFF
      FF00999999009999990099999900999999009999990099999900999999009999
      9900FFFFFF003333330000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000D6D6D600D6D6D600D97A0000D97A0000D97A
      0000D97A0000D97A0000D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D6000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60069696900000000000000000000000000000000000000
      0000000000000000000033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0033333300000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F0F0
      F000F0F0F000D97A0000D97A0000D97A0000D97A0000D97A0000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F0000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      00000000000000000000D0D0D0004B4B4B00333333003333330033333300FFFF
      FF00999999009999990099999900999999009999990099999900999999009999
      9900FFFFFF003333330000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000D6D6D600D6D6D600D97A0000D97A0000D97A
      0000D97A0000D97A0000D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D6000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600696969000000000000000000000000004B4B4B009999
      9900FFFFFF00FFFFFF0033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0033333300000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000033333300FFFFFF00DEDEDE00DCDCDC00333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000000000000000000000D6D6D600D6D6
      D600D97A0000D97A0000D97A0000D97A0000D97A0000D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6006969690000000000000000000000000033333300FFFF
      FF00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00FFFFFF00333333000000000000000000000000000000
      00000000000000000000F0F0F000F0F0F000D97A0000D97A0000D97A0000D97A
      0000D97A0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000033333300FFFFFF00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00FFFFFF003333
      3300000000000000000000000000000000000000000000000000D6D6D600D6D6
      D600D97A0000D97A0000D97A0000D97A0000D97A0000D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF006969690000000000000000000000000033333300FFFF
      FF00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00B3B3B3001C1C
      1C00CECECE00DCDCDC00FFFFFF00333333000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00F6F6F600F6F6F600F6F6F600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00696969000000
      0000000000000000000033333300FFFFFF00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00292929000000000060606000DCDCDC00FFFFFF003333
      3300000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00D0D0D0005E5E5E000303
      030066666600B5B5B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6006969690000000000000000000000000033333300FFFF
      FF00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC006E6E6E00000000000000
      000000000000A5A5A500FFFFFF00333333000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000033333300FFFFFF00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00FFFFFF003333
      3300000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000F5F5F500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6006969690000000000000000000000000033333300FFFF
      FF00DEDEDE00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DEDEDE00FFFFFF00333333000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      000000000000000000004B4B4B0099999900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00999999004B4B
      4B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00CACACA00ABABAB000000
      0000F5F5F500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60069696900000000000000000000000000D0D0D0004B4B
      4B00333333003333330033333300333333003333330033333300333333003333
      330033333300333333004B4B4B00D0D0D0000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF008B8B8B0000000000F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00069696900696969006969690069696900696969006969
      690069696900696969006969690069696900F7F7F700FFFFFF00000000006969
      6900696969006969690069696900696969006969690069696900696969000000
      0000696969000000000069696900696969006969690069696900696969006969
      6900696969006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF006969
      6900696969006969690069696900696969006A6A6A0069696900696969006969
      6900F7F7F700FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006E6E6E0069696900F8F8F800FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0006E6E6E006969
      6900F9F9F900FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006D6D6D0069696900F9F9F900FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0006D6D6D006969
      6900FAFAFA00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ABF0F00060006000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006D6D6D0069696900FAFAFA00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000B1B1B100C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00ABF0F00060006000F0F0AB00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0006A6A6A006969
      6900FDFDFD00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000B6B6B600232323002121210002020200323232007373
      7300C0C0C0000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00080808000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ABF0F00060006000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDFDFD00FEFEFE006969690069696900FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000797979002D2D
      2D00C0C0C000C0C0C0000F0F0F0073737300C0C0C000FFFFFF00909090009090
      90009090900090909000909090009090900000000000C0C0C000808080000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      0000800000008000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00ABF0F00060006000F0F0AB00FFFFFF00A0A0A000FFFFFF006969
      6900696969006969690069696900696969006A6A6A0069696900696969006969
      6900FFFFFF00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000939393000000000080808000A6A6A6002D2D2D007373
      7300C0C0C000FFFFFF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0009090
      900000000000C0C0C00080808000000000000000000000000000000000008080
      800080000000800000008000000080000000800000008000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ABF0F00060006000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006969690069696900FFFFFF00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000C0C0C0009D9D
      9D005F5F5F00444444000B0B0B0073737300C0C0C000FFFFFF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F0009090900000000000C0C0C000808080000000
      00000000000000000000000000008080800080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00003687006060000060006000F0F0AB00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000EDEDED00696969006B6B
      6B00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006969690069696900696969006969690069696900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000C0C0C000B2B2B200C0C0C000C0C0C000333333007979
      7900C0C0C000FFFFFF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0009090
      900000000000C0C0C00080808000000000000000000000000000000000008080
      8000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0060ABF00060000000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EDEDED00696969006C6C6C00FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00F0F0
      F000F0F0F000F0F0F00069696900F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000A6A6A6000101
      010046464600434343000D0D0D00AAAAAA00C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000808080000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000ECECEC00696969006D6D
      6D00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000FFFFFF00F0F0F000F0F0F000F0F0F00069696900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000C0C0C000BBBBBB00929292008F8F8F00BBBBBB00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080808000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000ECECEC00696969006D6D6D00FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00F0F0
      F000F0F0F000F0F0F00069696900F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000ECECEC00696969006D6D
      6D00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFFFF0069696900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FAFAFA00696969006E6E6E00FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C7C7C700C7C7C700C8C8C800CACA
      CA00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A4A4A400FEFEFE00FFFFFF00000000006969
      6900696969006969690069696900696969006969690069696900696969000000
      0000000000000000000069696900696969006969690069696900696969006969
      6900696969006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000C0C0C00080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF00000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF0000000000FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFB06B00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF000000000000000000FFFFFF0000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000000000000000000000000000FFFF
      FF000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008000000080000000800000008000
      0000800000008000000080000000800000008000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      00000000000000000000FFB06B00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF00000000000000000000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFB06B00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF0000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000080808000FFFF
      FF008000000080000000800000008000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00F5F5F500FAFAFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF000000000080808000FFFFFF0080000000FFFFFF00FFFFFF00FFFF
      FF0080000000FFFFFF008000000080000000FFFFFF00FFFFFF00800000008000
      000080000000FFFFFF00FFFFFF00808080000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00555555006D6D6D000F0F0F00F9F9F900FFFFFF000606060079797900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000080808000FFFF
      FF008000000080000000800000008000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000FFFFFF000B0B0B00FFFFFF0011111100FFFF
      FF00E7E7E700A2A2A200FFFFFF00FFFFFF008080800080808000808080008080
      8000808080008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF008000000080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0055555500171717008E8E8E00FFFFFF00FFFFFF000909090009090900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0055555500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000808080008080800080808000FFFFFF00000000008080
      8000C0C0C0008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF000000000080808000C0C0C000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00F9F9F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FDFDFD008B8B8B00A1A1A100D1D1D100F9F9
      F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FBFBFB00D3D3D300A3A3A30087878700AFAFAF00DDDDDD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3
      F300C7C7C700979797008D8D8D00BBBBBB00EBEBEB00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700B9B9
      B9008D8D8D0099999900C7C7C700F5F5F500FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00DBDBDB00ADADAD008989
      8900F9F9F900FFFFFF0080808000FFFFFF0080808000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E3E3E300C7C7C700BFBFBF00C7C7C700E3E3
      E300FFFFFF00FFFFFF00FFFFFF00FBFBFB00FFFFFF00FFFFFF0080808000FFFF
      FF0080808000FFFFFF008080800080808000C0C0C00000000000FFFFFF00C0C0
      C000C0C0C000C0C0C00000000000C0C0C000FFFFFF00C0C0C000FFFFFF000000
      0000FFFFFF008080800080808000C0C0C000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700979797009191
      9100B5B5B500BFBFBF00B5B5B5009191910097979700E7E7E700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF0080808000FFFFFF00000000000000
      0000C0C0C00000000000FFFFFF00C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000FFFFFF000000000000000000C0C0
      C000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00F3F3F3008B8B8B00CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CFCFCF008B8B8B00F3F3F300FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF0080808000FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFFFF00FFFF
      FF00FFFFFF00C0C0C00000000000C0C0C000FFFFFF00C0C0C000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00C5C5C500B3B3B300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B3B3B300C5C5C500FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00C7C7C700B1B1B100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B1B1B100C7C7C700FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00F5F5F5008D8D8D00CDCDCD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CDCDCD008D8D8D00F5F5F500FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EBEBEB009999990091919100B5B5B500BFBFBF00B5B5B5009191
      910099999900EBEBEB00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
      E700C9C9C900BFBFBF00C9C9C900E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00F1F1F100F3F3F300FFFF
      FF00FFFFFF00FFFFFF00E1E1E100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F6F6F600E2E2E200FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF006C6C6C004E4E4E005757570076767600F9F9F90042424200575757000707
      0700474747009B9B9B00FFFFFF0081818100000000005959590001010100FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000FFFFFF00A2A2A2005F5F5F00FFFFFF00FFFFFF00FFFF
      FF008E8E8E0073737300FFFFFF00FFFFFF004E4E4E009B9B9B00D7D7D7003939
      3900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF008080800080808000C0C0C0000000000000000000FFFFFF008080
      80009F9F9F00FFFFFF00FFFFFF00FFFFFF006F6F6F00B3B3B300FFFFFF00FFFF
      FF007B7B7B009B9B9B00B8B8B800202020005B5B5B005D5D5D0060606000B3B3
      B300FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000C0C0
      C0000000000000000000FFFFFF00A9A9A9003D3D3D00FFFFFF00FFFFFF00FFFF
      FF008A8A8A0052525200FFFFFF00FFFFFF006F6F6F009B9B9B00D0D0D0001A1A
      1A00C4C4C400C4C4C4003A3A3A00BEBEBE00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF00FFFFFF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF003939390059595900A6A6A60075757500EAEAEA0001010100A9A9A9006666
      66000D0D0D009B9B9B00FFFFFF00555555008C8C8C009191910001010100FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ADADAD0091919100CDCD
      CD00FFFFFF00E4E4E40096969600A6A6A600555555009B9B9B00FFFFFF00FFFF
      FF00AEAEAE0094949400E2E2E200FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF00DEEBEF00000000000000000000000000DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00646464009B9B9B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000FFFFFF00FFFFFF008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF000000
      00000000000000000000DEEBEF00DEEBEF000000000080808000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000008000000000000000C0C0C000FFFFFF00C0C0C000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00646464009B9B9B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080000000800000000000000000000000FFFFFF00FFFFFF00840000008400
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF000000000000000000000000000000000000000000DEEB
      EF0000000000808080008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000800000000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000FFFFFF00FFFFFF008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000000080808000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000008000000000000000C0C0C000FFFFFF00C0C0C000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EAEAEA00FFFFFF00FAFAFA00FFFFFF00FFFFFF00FFFFFF00E9E9E900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF008400
      000084000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF000000000000000000000000000000000000000000DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B9B9B900020202005B5B5B005F5F5F0038383800FFFF
      FF002B2B2B004848480063636300000000009F9F9F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFFFF00C0C0C000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B006B6B
      6B00FFFFFF008B8B8B003E3E3E00FFFFFF002B2B2B00A5A5A500FFFFFF00FCFC
      FC0001010100F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF00FFFFFF000000000000000000FFFFFF0084000000840000008400
      00008400000084000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF000000000000000000000000000000000000000000DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C8C8C80001010100878787007D7D7D004A4A4A00FFFF
      FF002B2B2B00DADADA00FFFFFF00FFFFFF0049494900D6D6D600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF008400000084000000840000008400000084000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF000000
      00000000000000000000DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C0006D6D6D0056565600FFFFFF002B2B2B00BBBBBB00FFFFFF00FFFF
      FF0026262600E1E1E100FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF00DEEBEF00000000000000000000000000DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F5F5F50046464600B4B4B400636363007F7F7F00FFFF
      FF002B2B2B0008080800B2B2B2008D8D8D0040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000C0C0
      C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CACA
      CA0094949400A8A8A800FFFFFF00FFFFFF002B2B2B00CACACA00A4A4A400A1A1
      A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF008080
      800080808000C0C0C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000FFFFFF008080800080808000C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF002B2B2B00CACACA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFFFF0080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF0000000000FFFFFF000000000000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002B2B2B00CFCFCF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD00000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C0008080800080808000FFFFFF00FFFFFF0080808000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C0008080800000000000FFFF
      FF008080800080808000FFFFFF0080808000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C00000000000FFFFFF0080808000000000000000000080808000FFFF
      FF0080808000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C00000000000FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF0080808000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000008080800000000000FFFFFF00FFFFFF008080
      80008080800080808000FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C0000000000080808000FFFFFF008080800080808000FFFFFF008080
      8000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C00000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C00080808000000000008080
      8000FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0
      C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF0080808000000000000000
      000000000000000000000000000080808000FFFFFF0080808000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF008080800000000000000000000000000000000000000000008080
      8000FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF0080808000000000000000
      000000000000000000000000000080808000FFFFFF0080808000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000808080008080
      8000FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0
      C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF008080
      80008080800080808000FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C0008080800000000000FFFFFF008080800080808000FFFFFF008080
      8000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      80000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C00000000000FFFFFF008080
      8000000000000000000080808000FFFFFF0080808000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C00000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF0080808000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C0000000000080808000FFFF
      FF008080800080808000FFFFFF0080808000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000808080000000000080808000FFFFFF00FFFFFF00000000008080
      8000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF000000000000000000000000008080
      800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E2E2E2000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E2E2E200000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF000000
      000000000000FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFCFC00FEFE
      FE00FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00E2E2E200D4D0D400E2E2E200E2E2E200E2E2E2000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF0080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008206060080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00800000008000
      0000FFFFFF008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00840808008000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00E2E2E200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF008000000080000000FFFFFF008000000080000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FDFB
      FB00FFFFFF00FFFFFF008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF008000
      0000800000008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FEFCFC0082050500FEFEFE00800000008000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00E2E2E200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000000080000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FEFC
      FC0080000000891313008000000080000000FEFCFC00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FDFBFB0081030300800000008000
      0000FEFCFC00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00E2E2E200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFBFB008206060081040400FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00E2E2E200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E0000002800000054000000BD00000001000100
      00000000DC0800000000000000000000000000000000000000000000FFFFFF00
      800007FFFFFFFFFE0000000080000400007FFFFE000000008000040000600006
      0000000080000400006000060000000080000400006000060000000080000400
      0060000600000000800004000060000600000000800004000060000600000000
      8000040000600006000000008000040000600006000000008000040000600006
      0000000080000400006000060000000080000400006000060000000080000400
      0060000600000000800004000060000600000000800004000060000600000000
      8000040000600006000000008000040000600006000000008000040000600006
      00000000800004000060000600000000FFFFFFFFFFFFFFFE00000000FFFFFFFF
      FFE00001FFFFF000FFFFFC0000600001FFFFF000FFFFFC0000600001FFFFF000
      8000040000600000000000008000040000600000000000008000040000600000
      0000000080000400006000000000000080000400006000000000000080000400
      0060000000000000800004000060000000000000800004000060000000000000
      8000040000600000000000008000040000600000000000008000040000600000
      0000000080000400006000000000000080000400006000000000000080010C00
      0060000000000000C03FFC000060000000000000FFFFFC0000600001FFFFF000
      FFFFFC0000600001FFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFC0000200001
      FFFFF000FFFFFC000020000100001000FFFFFC000020000100001000FC003C00
      0020000100001000FC003C000020000100001000FC003C000020000100001000
      FC003C000020000100001000C0003C000020000100001000C0003C0000200001
      00001000C0003C000020000100001000C000FC000020000100001000C000FC00
      0020000100001000C000FC000020000100001000C000FC000020000100001000
      C000FC000020000100001000C000FC000020000100001000C000FC0000200001
      00001000C000FC000020000100001000C000FC000020000100001000FFFFFC00
      0020000100001000FFFFFFFFFFFFFFFFFFFFF000FFFE7C00003FFFFFFFFFF000
      FFFC3C0000200003FFFFF000FFFC3C0000200003FFFFF000FFC87C0000200003
      FFFFF000FFC07C0000200003FFFFF000FFC0FC000020000300001000FFC03C00
      0020000200000000FFC07C000020000200000000E000FC000020000200000000
      E001FC000020000200000000E003FC000020000200000000E003FC0000200002
      00000000E003FC000020000200000000E003FC000020000200000000E003FC00
      0020000200000000E003FC000020000200000000E003FC000020000300001000
      E003FC0000200003FFFFF000E003FC0000200003FFFFF000E003FC0000200003
      FFFFF000E003FFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFF80000000FFFFFFFF
      FFFFFFFF00000000FFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF00000000
      FFC7FFFFFFFFFFFF00000000C783FFFFFFFFFFFF0000000080C1FFFFFFFFFFFF
      000000000001FFFFFFFFFFFF000000000001FFFFFFFE003F00000000E000FFFF
      FFFE003F00000000E0007FFFFFFE003F00000000C0003FFFFFFE003F00000000
      C0003FFFFFFE003F00000000C0001FFFFFFE003F00000000E0000C0000FE003F
      00000000F00F040000FE003F00000000F81F0400007E003F00000000FFFF8C00
      007E003F00000000FFFFFC00007E003F00000000FFFFFC00007E003F00001000
      FFFFFFFFFFFE003FFFFFF000FFFFFE000030000180000000FFFFFC0000200001
      00000000FFFFFC000020000100000000FFFFFC000020000100000000FFFFFC00
      0020000100000000FFFFFC000020000100000000FFFFFC000020000100000000
      FFFFFC0000200001000000000000040000200001000000000000040000200001
      0000000000000400002000010000000000000400002000010000000000000400
      0020000100000000000004000020000100000000FFFFFC000020000100000000
      FFFFFC000020000100000000FFFFFC000020000100000000FFFFFC0000200001
      00000000FFFFFC000020000100000000FFFFFC000060000300001000FFFFFFFF
      FFFFFFFFFFFFF000FFFFFC00003FFFFFFFFFF00080000400003FFFFFFFFFF000
      8000040000380001FFFFF0008000040000380000000000008000040000380000
      0000000080000400003800000000000080000400003800000000000080000400
      0038000000000000800004000038000000000000800004000038000000000000
      8000040000380000000000008000040000380000000000008000040000380000
      0000000080000400003800000000000080000400002000000000000080000400
      0020000000000000800004000020000000000000800004000020000000000000
      8000040000200000000000008000040000200001FFFFF000FFFFFFFFFFFFFFFF
      FFFFF000FFFFFFFFFFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFFF
      FFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFC003FFFFFFC000F000
      C0000F8003FFC1FFC000F0008000078003FF007FC000F0008000078003FE007F
      C000F0008000078003FE003FC000F0008000078003FC003FC000F00080000780
      03FC003FC000F0008000078003FC003FC000F0008000078003FC003FC000F000
      8000078003FE007FC000F0008000078003FE007FC000F0008000078003FF00FF
      C000F000C0000F8007FFC3FFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFFF
      FFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000
      FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFF
      80007000FFFFFC0000E0000780007000FFFFFC0000E0000780007000FE01FC00
      00E0000780007000FE01FC0000E0000780007000FE01FC0000E0000780007000
      FE1FFC0000E0000780007000FE1FFC0000E0000780007000FE1FFC0000E00007
      80007000FE1FFC0000E0000780007000FE1FFC0000E0000780007000FE1FFC00
      00E0000780007000FE1FFC0000E0000780007000FE1FFC0000E0000780007000
      FFFFFC0000E0000780007000FFFFFC0000E0000780007000FFFFFC0000E00007
      80007000FFFFFFFFFFFFFFFF80007000FFFFFFFFFFFFFFFFFFFFF00000000000
      000000000000000000000000000000000000}
  end
  object ILTKinter: TImageList
    Height = 21
    Width = 21
    Left = 208
    Top = 352
    Bitmap = {
      494C010123002800040015001500FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000054000000BD000000010020000000000010F8
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBF
      BF00BFBFBF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00BFBFBF00BFBFBF00FFFF
      FF00FFFFFF000000000000000000C0C0C000C0C0C0008080800000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000C0C0C000C0C0C000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00BFBFBF00BFBF
      BF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00FFFFFF000000000000000000FFFF
      FF0000000000C0C0C00000000000C0C0C000FFFFFF00C0C0C000FFFFFF000000
      0000FFFFFF0000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000FFFFFF003333330033333300333333003333
      33003333330033333300333333003333330033333300333333004D4D4D003333
      330033333300333333003333330033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000FFFFFF00FFFFFF00C0C0C0000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBF
      BF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00BFBFBF00BFBFBF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000C0C0C00080808000000000000000000000000000FFFF
      FF00333333009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999004D4D
      4D00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF0000000000C0C0
      C000000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00BFBFBF00BFBFBF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC0099999900999999009999990099999900CBCBCB00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF00C0C0C000FFFF
      FF00000000000000000000000000FFFFFF0033333300DCDCDC00DCDCDC00B3B3
      B300B3B3B300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00CECECE001C1C1C001C1C1C00CECECE00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF00C0C0C000FFFF
      FF00000000000000000000000000FFFFFF0033333300DCDCDC00A5A5A5006E6E
      6E006E6E6E00A5A5A500DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000FFFFFF003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300333333003333330033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000C0C0C000C0C0C00080808000000000000000000000000000FFFF
      FF0033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080000000800000008000
      00008000000080000000800000008000000000000000FFFFFF0000000000C0C0
      C000000000000000000000000000FFFFFF0033333300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0099999900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0033333300FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00C0C0C000000000000000000000000000FFFF
      FF00333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CED3D600CED3D600CED3D600CED3D600CED3
      D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
      D600CED3D600CED3D600CED3D600CED3D600CED3D6000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EEEEEE0080808000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E60025B0060025B0060025B0060025B0060025B0060025B0
      0600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D00000000000C8D0D0000000000000000000C8D0
      D00000000000C8D0D00000000000C8D0D000C8D0D000C8D0D000C8D0D0000000
      0000C8D0D000C8D0D000C8D0D000C8D0D000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E60025B0060025B0
      060025B0060025B0060025B0060025B00600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000FFFFFF00C8D0D000C8D0
      D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0D00000000000C8D0
      D000C8D0D000C8D0D000C8D0D00000000000C8D0D000C8D0D000C8D0D000C8D0
      D000000000000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000FFFFFF00C8D0D000C8D0D000C8D0D000C8D0D000C8D0D000C8D0
      D000C8D0D000C8D0D00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000BCBCBC00E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600BCBCBC00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED3D6000000000000000000BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CED3D6000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60069696900000000000000000000000000000000000000
      0000000000000000000033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0033333300000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      000000000000000000000000000000000000000000000000000033333300FFFF
      FF00999999009999990099999900999999009999990099999900999999009999
      9900FFFFFF003333330000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000D6D6D600D6D6D600D97A0000D97A0000D97A
      0000D97A0000D97A0000D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D6000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60069696900000000000000000000000000000000000000
      0000000000000000000033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0033333300000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F0F0
      F000F0F0F000D97A0000D97A0000D97A0000D97A0000D97A0000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F0000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      00000000000000000000D0D0D0004B4B4B00333333003333330033333300FFFF
      FF00999999009999990099999900999999009999990099999900999999009999
      9900FFFFFF003333330000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000D6D6D600D6D6D600D97A0000D97A0000D97A
      0000D97A0000D97A0000D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D6000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600696969000000000000000000000000004B4B4B009999
      9900FFFFFF00FFFFFF0033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0033333300000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000033333300FFFFFF00DEDEDE00DCDCDC00333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000000000000000000000D6D6D600D6D6
      D600D97A0000D97A0000D97A0000D97A0000D97A0000D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6006969690000000000000000000000000033333300FFFF
      FF00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00FFFFFF00333333000000000000000000000000000000
      00000000000000000000F0F0F000F0F0F000D97A0000D97A0000D97A0000D97A
      0000D97A0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000FFFF
      FF00FFFFFF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000033333300FFFFFF00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00FFFFFF003333
      3300000000000000000000000000000000000000000000000000D6D6D600D6D6
      D600D97A0000D97A0000D97A0000D97A0000D97A0000D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A
      0000D97A0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF006969690000000000000000000000000033333300FFFF
      FF00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00B3B3B3001C1C
      1C00CECECE00DCDCDC00FFFFFF00333333000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00F6F6F600F6F6F600F6F6F600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00696969000000
      0000000000000000000033333300FFFFFF00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00292929000000000060606000DCDCDC00FFFFFF003333
      3300000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00D0D0D0005E5E5E000303
      030066666600B5B5B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6006969690000000000000000000000000033333300FFFF
      FF00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC006E6E6E00000000000000
      000000000000A5A5A500FFFFFF00333333000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000033333300FFFFFF00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00FFFFFF003333
      3300000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00D97A0000D97A0000D97A0000D97A0000D97A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000F5F5F500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6006969690000000000000000000000000033333300FFFF
      FF00DEDEDE00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DEDEDE00FFFFFF00333333000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00D97A0000D97A0000D97A0000D97A
      0000D97A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      000000000000000000004B4B4B0099999900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00999999004B4B
      4B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00CACACA00ABABAB000000
      0000F5F5F500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000069696900C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60069696900000000000000000000000000D0D0D0004B4B
      4B00333333003333330033333300333333003333330033333300333333003333
      330033333300333333004B4B4B00D0D0D0000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF008B8B8B0000000000F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000069696900C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600696969000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900696969006969690069696900696969006969
      6900696969006969690069696900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00069696900696969006969690069696900696969006969
      690069696900696969006969690069696900F7F7F700FFFFFF00000000006969
      6900696969006969690069696900696969006969690069696900696969000000
      0000696969000000000069696900696969006969690069696900696969006969
      6900696969006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF006969
      6900696969006969690069696900696969006A6A6A0069696900696969006969
      6900F7F7F700FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006E6E6E0069696900F8F8F800FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0006E6E6E006969
      6900F9F9F900FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006D6D6D0069696900F9F9F900FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0006D6D6D006969
      6900FAFAFA00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ABF0F00060006000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006D6D6D0069696900FAFAFA00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000B1B1B100C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00ABF0F00060006000F0F0AB00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0006A6A6A006969
      6900FDFDFD00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000B6B6B600232323002121210002020200323232007373
      7300C0C0C0000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00080808000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ABF0F00060006000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDFDFD00FEFEFE006969690069696900FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000797979002D2D
      2D00C0C0C000C0C0C0000F0F0F0073737300C0C0C000FFFFFF00909090009090
      90009090900090909000909090009090900000000000C0C0C000808080000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      0000800000008000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00ABF0F00060006000F0F0AB00FFFFFF00A0A0A000FFFFFF006969
      6900696969006969690069696900696969006A6A6A0069696900696969006969
      6900FFFFFF00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000939393000000000080808000A6A6A6002D2D2D007373
      7300C0C0C000FFFFFF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0009090
      900000000000C0C0C00080808000000000000000000000000000000000008080
      800080000000800000008000000080000000800000008000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ABF0F00060006000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006969690069696900FFFFFF00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000C0C0C0009D9D
      9D005F5F5F00444444000B0B0B0073737300C0C0C000FFFFFF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F0009090900000000000C0C0C000808080000000
      00000000000000000000000000008080800080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00003687006060000060006000F0F0AB00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000EDEDED00696969006B6B
      6B00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0006969690069696900696969006969690069696900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000C0C0C000B2B2B200C0C0C000C0C0C000333333007979
      7900C0C0C000FFFFFF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0009090
      900000000000C0C0C00080808000000000000000000000000000000000008080
      8000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0060ABF00060000000F0F0
      AB00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EDEDED00696969006C6C6C00FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00F0F0
      F000F0F0F000F0F0F00069696900F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00C0C0C000A6A6A6000101
      010046464600434343000D0D0D00AAAAAA00C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000808080000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000ECECEC00696969006D6D
      6D00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000FFFFFF00F0F0F000F0F0F000F0F0F00069696900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000008080
      8000FFFFFF00C0C0C000C0C0C000BBBBBB00929292008F8F8F00BBBBBB00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080808000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000ECECEC00696969006D6D6D00FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00F0F0
      F000F0F0F000F0F0F00069696900F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000696969000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000ECECEC00696969006D6D
      6D00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFFFF0069696900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FAFAFA00696969006E6E6E00FEFEFE00FFFFFF00000000006969
      6900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C7C7C700C7C7C700C8C8C800CACA
      CA00FEFEFE00FFFFFF000000000069696900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00069696900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A4A4A400FEFEFE00FFFFFF00000000006969
      6900696969006969690069696900696969006969690069696900696969000000
      0000000000000000000069696900696969006969690069696900696969006969
      6900696969006969690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000C0C0C00080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000098000000FFFFFF00FFFF
      FF009800000098000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF00000000000000000000000000FFFF
      FF0098000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0098000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF000000000000000000000000000000000098000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0098000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      000098000000FFFFFF00FFFFFF00FFFFFF0098000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000FFFFFF0098000000FFFFFF00FFFFFF009800
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF00000000000000000000000000FFFF
      FF0098000000FFFFFF0098000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008000000080000000800000008000
      0000800000008000000080000000800000008000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0098000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00980000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF009800000098000000980000009800000000000000FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000080808000FFFF
      FF008000000080000000800000008000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00F5F5F500FAFAFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000080808000FFFFFF0080000000FFFFFF00FFFFFF00FFFF
      FF0080000000FFFFFF008000000080000000FFFFFF00FFFFFF00800000008000
      000080000000FFFFFF00FFFFFF00808080000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00555555006D6D6D000F0F0F00F9F9F900FFFFFF000606060079797900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF008000000080000000800000008000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000FFFFFF000B0B0B00FFFFFF0011111100FFFF
      FF00E7E7E700A2A2A200FFFFFF00FFFFFF008080800080808000808080008080
      8000808080008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF008000000080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000080808000FFFFFF0080000000800000008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0055555500171717008E8E8E00FFFFFF00FFFFFF000909090009090900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0055555500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000808080008080800080808000FFFFFF00000000008080
      8000C0C0C0008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF000000000080808000C0C0C000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00F9F9F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FDFDFD008B8B8B00A1A1A100D1D1D100F9F9
      F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FBFBFB00D3D3D300A3A3A30087878700AFAFAF00DDDDDD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3
      F300C7C7C700979797008D8D8D00BBBBBB00EBEBEB00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700B9B9
      B9008D8D8D0099999900C7C7C700F5F5F500FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00DBDBDB00ADADAD008989
      8900F9F9F900FFFFFF0080808000FFFFFF0080808000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E3E3E300C7C7C700BFBFBF00C7C7C700E3E3
      E300FFFFFF00FFFFFF00FFFFFF00FBFBFB00FFFFFF00FFFFFF0080808000FFFF
      FF0080808000FFFFFF008080800080808000C0C0C00000000000FFFFFF00C0C0
      C000C0C0C000C0C0C00000000000C0C0C000FFFFFF00C0C0C000FFFFFF000000
      0000FFFFFF008080800080808000C0C0C000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700979797009191
      9100B5B5B500BFBFBF00B5B5B5009191910097979700E7E7E700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF0080808000FFFFFF00000000000000
      0000C0C0C00000000000FFFFFF00C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00C0C0C000FFFFFF00C0C0C00000000000FFFFFF000000000000000000C0C0
      C000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00F3F3F3008B8B8B00CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CFCFCF008B8B8B00F3F3F300FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF0080808000FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFFFF00FFFF
      FF00FFFFFF00C0C0C00000000000C0C0C000FFFFFF00C0C0C000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00C5C5C500B3B3B300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B3B3B300C5C5C500FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00C7C7C700B1B1B100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B1B1B100C7C7C700FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00F5F5F5008D8D8D00CDCDCD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CDCDCD008D8D8D00F5F5F500FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EBEBEB009999990091919100B5B5B500BFBFBF00B5B5B5009191
      910099999900EBEBEB00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
      E700C9C9C900BFBFBF00C9C9C900E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080808000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00F1F1F100F3F3F300FFFF
      FF00FFFFFF00FFFFFF00E1E1E100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F6F6F600E2E2E200FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF006C6C6C004E4E4E005757570076767600F9F9F90042424200575757000707
      0700474747009B9B9B00FFFFFF0081818100000000005959590001010100FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000FFFFFF00A2A2A2005F5F5F00FFFFFF00FFFFFF00FFFF
      FF008E8E8E0073737300FFFFFF00FFFFFF004E4E4E009B9B9B00D7D7D7003939
      3900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF008080800080808000C0C0C0000000000000000000FFFFFF008080
      80009F9F9F00FFFFFF00FFFFFF00FFFFFF006F6F6F00B3B3B300FFFFFF00FFFF
      FF007B7B7B009B9B9B00B8B8B800202020005B5B5B005D5D5D0060606000B3B3
      B300FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000C0C0
      C0000000000000000000FFFFFF00A9A9A9003D3D3D00FFFFFF00FFFFFF00FFFF
      FF008A8A8A0052525200FFFFFF00FFFFFF006F6F6F009B9B9B00D0D0D0001A1A
      1A00C4C4C400C4C4C4003A3A3A00BEBEBE00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF00FFFFFF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF003939390059595900A6A6A60075757500EAEAEA0001010100A9A9A9006666
      66000D0D0D009B9B9B00FFFFFF00555555008C8C8C009191910001010100FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00ADADAD0091919100CDCD
      CD00FFFFFF00E4E4E40096969600A6A6A600555555009B9B9B00FFFFFF00FFFF
      FF00AEAEAE0094949400E2E2E200FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF00DEEBEF00000000000000000000000000DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00646464009B9B9B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000FFFFFF00FFFFFF008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF000000
      00000000000000000000DEEBEF00DEEBEF000000000080808000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000008000000000000000C0C0C000FFFFFF00C0C0C000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00646464009B9B9B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080000000800000000000000000000000FFFFFF00FFFFFF00840000008400
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF000000000000000000000000000000000000000000DEEB
      EF0000000000808080008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000800000000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000FFFFFF00FFFFFF008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000000080808000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000008000000000000000C0C0C000FFFFFF00C0C0C000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EAEAEA00FFFFFF00FAFAFA00FFFFFF00FFFFFF00FFFFFF00E9E9E900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF008400
      000084000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF000000000000000000000000000000000000000000DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B9B9B900020202005B5B5B005F5F5F0038383800FFFF
      FF002B2B2B004848480063636300000000009F9F9F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFFFF00C0C0C000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B006B6B
      6B00FFFFFF008B8B8B003E3E3E00FFFFFF002B2B2B00A5A5A500FFFFFF00FCFC
      FC0001010100F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF00FFFFFF000000000000000000FFFFFF0084000000840000008400
      00008400000084000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF000000000000000000000000000000000000000000DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000FFFFFF00C0C0C000FFFFFF00C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C8C8C80001010100878787007D7D7D004A4A4A00FFFF
      FF002B2B2B00DADADA00FFFFFF00FFFFFF0049494900D6D6D600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF008400000084000000840000008400000084000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF000000
      00000000000000000000DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C0006D6D6D0056565600FFFFFF002B2B2B00BBBBBB00FFFFFF00FFFF
      FF0026262600E1E1E100FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF00DEEBEF00000000000000000000000000DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F5F5F50046464600B4B4B400636363007F7F7F00FFFF
      FF002B2B2B0008080800B2B2B2008D8D8D0040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF0000000000DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000C0C0
      C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CACA
      CA0094949400A8A8A800FFFFFF00FFFFFF002B2B2B00CACACA00A4A4A400A1A1
      A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF008080
      800080808000C0C0C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF000000000080808000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000FFFFFF008080800080808000C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF002B2B2B00CACACA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFFFF0080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF0000000000FFFFFF000000000000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002B2B2B00CFCFCF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD00000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C0008080800080808000FFFFFF00FFFFFF0080808000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C0008080800000000000FFFF
      FF008080800080808000FFFFFF0080808000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C00000000000FFFFFF0080808000000000000000000080808000FFFF
      FF0080808000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C00000000000FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF0080808000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000008080800000000000FFFFFF00FFFFFF008080
      80008080800080808000FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C0000000000080808000FFFFFF008080800080808000FFFFFF008080
      8000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C00000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C00080808000000000008080
      8000FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0
      C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF0080808000000000000000
      000000000000000000000000000080808000FFFFFF0080808000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF008080800000000000000000000000000000000000000000008080
      8000FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF0080808000000000000000
      000000000000000000000000000080808000FFFFFF0080808000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000808080008080
      8000FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0
      C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000008080800000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF008080
      80008080800080808000FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C0008080800000000000FFFFFF008080800080808000FFFFFF008080
      8000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      80000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C00000000000FFFFFF008080
      8000000000000000000080808000FFFFFF0080808000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C00000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF0080808000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C0000000000080808000FFFF
      FF008080800080808000FFFFFF0080808000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000808080000000000080808000FFFFFF00FFFFFF00000000008080
      8000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF000000000000000000000000008080
      800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000370037000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037003700000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF000000
      000000000000FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFCFC00FEFE
      FE00FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000016001600370037003700370037003700370037000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF0080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008206060080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000370037000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00800000008000
      0000FFFFFF008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00840808008000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037003700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF008000000080000000FFFFFF008000000080000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FDFB
      FB00FFFFFF00FFFFFF008000000080000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000370037000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF008000
      0000800000008000000080000000FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FEFCFC0082050500FEFEFE00800000008000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037003700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000000080000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FEFC
      FC0080000000891313008000000080000000FEFCFC00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000370037000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FDFBFB0081030300800000008000
      0000FEFCFC00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037003700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFBFB008206060081040400FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000370037000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037003700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00C0C0C000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00C0C0C000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000000000000000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF000000000000000000000000000000000080808000FFFFFF008000
      00008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E0000002800000054000000BD00000001000100
      00000000DC0800000000000000000000000000000000000000000000FFFFFF00
      800007FFFFFFFFFE0000000080000400007FFFFE000000008000040000600006
      0000000080000400006000060000000080000400006000060000000080000400
      0060000600000000800004000060000600000000800004000060000600000000
      8000040000600006000000008000040000600006000000008000040000600006
      0000000080000400006000060000000080000400006000060000000080000400
      0060000600000000800004000060000600000000800004000060000600000000
      8000040000600006000000008000040000600006000000008000040000600006
      00000000800004000060000600000000FFFFFFFFFFFFFFFE00000000FFFFFFFF
      FFE00001FFFFF000FFFFFC0000600001FFFFF000FFFFFC0000600001FFFFF000
      8000040000600000000000008000040000600000000000008000040000600000
      0000000080000400006000000000000080000400006000000000000080000400
      0060000000000000800004000060000000000000800004000060000000000000
      8000040000600000000000008000040000600000000000008000040000600000
      0000000080000400006000000000000080000400006000000000000080010C00
      0060000000000000C03FFC000060000000000000FFFFFC0000600001FFFFF000
      FFFFFC0000600001FFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFC0000200001
      FFFFF000FFFFFC000020000100001000FFFFFC000020000100001000FC003C00
      0020000100001000FC003C000020000100001000FC003C000020000100001000
      FC003C000020000100001000C0003C000020000100001000C0003C0000200001
      00001000C0003C000020000100001000C000FC000020000100001000C000FC00
      0020000100001000C000FC000020000100001000C000FC000020000100001000
      C000FC000020000100001000C000FC000020000100001000C000FC0000200001
      00001000C000FC000020000100001000C000FC000020000100001000FFFFFC00
      0020000100001000FFFFFFFFFFFFFFFFFFFFF000FFFE7C00003FFFFFFFFFF000
      FFFC3C0000200003FFFFF000FFFC3C0000200003FFFFF000FFC87C0000200003
      FFFFF000FFC07C0000200003FFFFF000FFC0FC000020000300001000FFC03C00
      0020000200000000FFC07C000020000200000000E000FC000020000200000000
      E001FC000020000200000000E003FC000020000200000000E003FC0000200002
      00000000E003FC000020000200000000E003FC000020000200000000E003FC00
      0020000200000000E003FC000020000200000000E003FC000020000300001000
      E003FC0000200003FFFFF000E003FC0000200003FFFFF000E003FC0000200003
      FFFFF000E003FFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFF80000000FFFFFFFF
      FFFFFFFF00000000FFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF00000000
      FFC7FFFFFFFFFFFF00000000C783FFFFFFFFFFFF0000000080C1FFFFFFFFFFFF
      000000000001FFFFFFFFFFFF000000000001FFFFFFFE003F00000000E000FFFF
      FFFE003F00000000E0007FFFFFFE003F00000000C0003FFFFFFE003F00000000
      C0003FFFFFFE003F00000000C0001FFFFFFE003F00000000E0000C0000FE003F
      00000000F00F040000FE003F00000000F81F0400007E003F00000000FFFF8C00
      007E003F00000000FFFFFC00007E003F00000000FFFFFC00007E003F00001000
      FFFFFFFFFFFE003FFFFFF000FFFFFE000030000180000000FFFFFC0000200001
      00000000FFFFFC000020000100000000FFFFFC000020000100000000FFFFFC00
      0020000100000000FFFFFC000020000100000000FFFFFC000020000100000000
      FFFFFC0000200001000000000000040000200001000000000000040000200001
      0000000000000400002000010000000000000400002000010000000000000400
      0020000100000000000004000020000100000000FFFFFC000020000100000000
      FFFFFC000020000100000000FFFFFC000020000100000000FFFFFC0000200001
      00000000FFFFFC000020000100000000FFFFFC000060000300001000FFFFFFFF
      FFFFFFFFFFFFF000FFFFFC00003FFFFFFFFFF00080000400003FFFFFFFFFF000
      8000040000380001FFFFF0008000040000380000000000008000040000380000
      0000000080000400003800000000000080000400003800000000000080000400
      0038000000000000800004000038000000000000800004000038000000000000
      8000040000380000000000008000040000380000000000008000040000380000
      0000000080000400003800000000000080000400002000000000000080000400
      0020000000000000800004000020000000000000800004000020000000000000
      8000040000200000000000008000040000200001FFFFF000FFFFFFFFFFFFFFFF
      FFFFF000FFFFFFFFFFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFFF
      FFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFC003FFFFFFC000F000
      C0000F8003FFC1FFC000F0008000078003FF007FC000F0008000078003FE007F
      C000F0008000078003FE003FC000F0008000078003FC003FC000F00080000780
      03FC003FC000F0008000078003FC003FC000F0008000078003FC003FC000F000
      8000078003FE007FC000F0008000078003FE007FC000F0008000078003FF00FF
      C000F000C0000F8007FFC3FFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFFF
      FFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000FFFFFFFFFFFFFFFFC000F000
      FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFF
      80007000FFFFFC0000E0000780007000FFFFFC0000E0000780007000FE01FC00
      00E0000780007000FE01FC0000E0000780007000FE01FC0000E0000780007000
      FE1FFC0000E0000780007000FE1FFC0000E0000780007000FE1FFC0000E00007
      80007000FE1FFC0000E0000780007000FE1FFC0000E0000780007000FE1FFC00
      00E0000780007000FE1FFC0000E0000780007000FE1FFC0000E0000780007000
      FFFFFC0000E0000780007000FFFFFC0000E0000780007000FFFFFC0000E00007
      80007000FFFFFFFFFFFFFFFF80007000FFFFFFFFFFFFFFFFFFFFF00000000000
      000000000000000000000000000000000000}
  end
  object MachineStorage: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    SubStorages = <>
    Left = 641
    Top = 144
  end
  object vilTabDecorators: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 9
        CollectionName = 'Bug'
        Disabled = False
        Name = 'Bug'
      end
      item
        CollectionIndex = 60
        CollectionName = 'Lock'
        Disabled = False
        Name = 'Lock'
      end>
    ImageCollection = CommandsDataModule.icSVGImages
    PreserveItems = True
    Width = 14
    Height = 14
    Left = 280
    Top = 432
  end
  object ILQtControls: TImageList
    Height = 21
    Width = 21
    Left = 416
    Top = 353
    Bitmap = {
      494C010114005801040015001500FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000540000007E000000010020000000000060A5
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080800039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680000000000FFFFFF0039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE68000000
      00008080800039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE6800000000008080800039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF00333333003333330033333300333333003333330033333300333333003333
      330033333300333333004D4D4D00333333003333330033333300333333003333
      3300333333003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7C7
      C700A0A0A000DDDDDD00E9E9E900F4F4F400FFFFFF00FFFFFF00A0A0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C7C7C700A0A0A000DDDDDD00E9E9E900F4F4
      F400FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0039BE68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0083838300DFDFDF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7C7
      C700A0A0A000DDDDDD00E9E9E900F4F4F400FFFFFF00FFFFFF00A0A0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ABABAB000000000014141400BBBBBB00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C7C7C700A0A0A000DDDDDD00E9E9E900F4F4
      F400FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0039BE68000000000080808000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E70044444400000000000404
      040087878700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7C7
      C700A0A0A000DDDDDD00E9E9E900F4F4F400FFFFFF00FFFFFF00A0A0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF003333330099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      990099999900999999009999990099999900999999004D4D4D0039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FBFBFB007F7F7F00000000000000000054545400F3F3F300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C7C7C700A0A0A000DDDDDD00E9E9E900F4F4
      F400FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0039BE68000000000080808000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B7B7
      B70014141400000000002C2C2C00E3E3E300FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7C7
      C700A0A0A000DDDDDD00E9E9E900F4F4F400FFFFFF00FFFFFF00A0A0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3F300979797008F8F
      8F00EFEFEF00FFFFFF00FFFFFF00FFFFFF00E3E3E30030303000000000001818
      1800DBDBDB00FFFFFF00FFFFFF0039BE68000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C7C7C700A0A0A000DDDDDD00E9E9E900F4F4
      F400FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0039BE68000000000080808000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300DCDCDC00DCDCDC00DCDCDC009999990099999900999999009999
      9900CBCBCB00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00707070000000000000000000101010008F8F8F00FFFFFF00FFFF
      FF00FFFFFF00F3F3F3003C3C3C000000000028282800F7F7F700FFFFFF0039BE
      68000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7C7
      C700A0A0A000DDDDDD00E9E9E900F4F4F400FFFFFF00FFFFFF00A0A0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF0014141400000000005050
      5000000000000000000044444400E7E7E700FFFFFF00FFFFFF00F3F3F3003434
      3400000000008F8F8F00FFFFFF0039BE680000000000F5F5F500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F1F100C7C7C700D2D2D200DDDDDD00E9E9E900F4F4
      F400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00FBFBFB00FFFFFF00FFFF
      FF0039BE68000000000080808000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300DCDCDC00DCDCDC00B3B3B300B3B3B300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00F7F7F7000000000004040400FFFFFF00B3B3B30018181800000000001C1C
      1C00CFCFCF00FFFFFF00FFFFFF00747474000000000074747400FFFFFF0039BE
      68000000000055555500C1C1C100FFFFFF00FFFFFF00DCDCDC0027272700F0F0
      F000F0F0F000F0F0F000F0F0F000BFBFBF00F0F0F000F0F0F000F0F0F000D6D6
      D6000909090033333300020202006464640039BE68000000000080808000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300DCDCDC00CECECE001C1C
      1C001C1C1C00CECECE00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00CBCBCB000000000024242400FFFF
      FF00FFFFFF00E7E7E70040404000000000000C0C0C00A7A7A700EFEFEF000808
      080000000000C3C3C300FFFFFF0039BE680000000000AAAAAA0065656500C5C5
      C500C5C5C500636363007E7E7E00F0F0F000F0F0F000F0F0F000BFBFBF00BFBF
      BF00BFBFBF00F0F0F000F0F0F000D6D6D60009090900FFFFFF00FFFFFF005151
      5100BDBDBD000000000080808000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300DCDCDC00A5A5A5006E6E6E006E6E6E00A5A5A500DCDCDC00DCDC
      DC00DCDCDC00DCDCDC0099999900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF007F7F7F000000000064646400FFFFFF00FFFFFF00FFFFFF00FBFBFB007474
      7400000000000000000051515100000000004C4C4C00FFFFFF00FFFFFF0039BE
      680000000000808080000E0E0E005C5C5C005B5B5B000A0A0A00D5D5D500F0F0
      F000F0F0F000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00F0F0F000D6D6
      D60009090900FFFFFF00FFFFFF0015151500C1C1C1000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC0099999900DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00DFDFDF000C0C0C0000000000BFBFBF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009F9F9F0004040400000000000000
      00007F7F7F00FFFFFF00FFFFFF0039BE6800000000008080800063636300B1B1
      B100C7C7C7003C3C3C00FFFFFF00F0F0F000BFBFBF00BFBFBF00BFBFBF00F0F0
      F000BFBFBF00BFBFBF00BFBFBF00D6D6D6000000000000000000000000007A7A
      7A0039BE68000000000080808000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF00333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330039BE68000000000080808000FFFFFF00FFFFFF00BBBB
      BB001010100048484800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C3C3C3002D2D2D00000000007F7F7F00FFFFFF00FFFFFF0039BE
      68000000000080808000B8B8B8003A3A3A004C4C4C0094949400FFFFFF00F0F0
      F000BFBFBF00BFBFBF00F0F0F000F0F0F000F0F0F000BFBFBF00BFBFBF00D6D6
      D60009090900FFFFFF00DEDEDE003535350039BE68000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF0033333300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0099999900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DCDCDC00DCDCDC003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00E3E3E300E7E7E700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000FFFFFF001B1B
      1B0000000000EBEBEB00FFFFFF00F0F0F000BFBFBF00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000BFBFBF00D6D6D60009090900FFFFFF00AFAFAF002828
      280039BE68000000000080808000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF0033333300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCDC
      DC00DCDCDC003333330039BE68000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000080808000FFFFFF002C2C2C0007070700FFFFFF00FFFFFF00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000DEDE
      DE0041414100424242005D5D5D00BBBBBB0039BE68000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0039BE680000000000FFFFFF003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300333333003333330033333300333333003333330039BE68000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE680000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      680000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A0A0A000A0A0A000A0A0A000A0A0A0009F9F9F00A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00EBEBEB00BBBBBB00FDFDFD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00008080800039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE680039BE680039BE680039BE680039BE
      680039BE680039BE680039BE680039BE68000000000000000000C0C0C000C0C0
      C0008080800000000000FFFFFF00C0C0C000FFFFFF00C0C0C00000000000C0C0
      C000C0C0C0008080800000000000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00EBEBEB00A7A7A700A0A0
      A000B4B4B400D4D4D400FFFFFF00A0A0A000A0A0A000A0A0A000A0A0A000D8D8
      D800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF0000000000C0C0C00000000000C0C0C000FFFF
      FF00C0C0C000FFFFFF0000000000FFFFFF0000000000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00EBEBEB00AAAAAA00FFFFFF00FFFFFF00A0A0A000FFFFFF00EDED
      ED009F9F9F00F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00C0C0C00000000000FFFFFF00C0C0C000FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00EBEBEB00BEBEBE00FFFF
      FF00FFFFFF00B3B3B300F1F1F100FFFFFF00EAEAEA009F9F9F00FAFAFA00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A00000000000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      6800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00EBEBEB00A9A9A900FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFF
      FF00FFFFFF00DCDCDC00C4C4C400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00000000000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000808080000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00EBEBEB00B7B7B700A2A2
      A200A0A0A000CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ABABAB00F9F9
      F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A00000000000F0F0
      F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A0A0A000FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000FFFFFF0000000000C0C0C000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8A8
      A800FAFAFA00F5F5F500A0A0A000FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000A0A0A000FFFFFF000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E0E0E000B7B7B700B3B3B300D5D5D500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F0F0
      F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A0A0A000A0A0A000FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000A0A0A000FFFFFF000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF00FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFFFF00C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F0F0
      F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A0A0A000A0A0A000A0A0A0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000FFFFFF00C0C0C000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000A0A0A000A0A0A000A0A0A0000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFFFF00C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A000A0A0A0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000FFFFFF00C0C0C000FFFFFF00000000000000000000000000A0A0A000A0A0
      A000A0A0A0009F9F9F00A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A00000000000FFFFFF00F0F0F000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A000A0A0A0000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFFFF00C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00EBEBEB00BBBBBB00FDFDFD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A00000000000FFFF
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000A0A0A000A0A0A0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00EBEBEB00A7A7A700A0A0A000B4B4B400D4D4D400FFFFFF00BCBCBC009F9F
      9F00A0A0A000A0A0A000D7D7D700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00F0F0F000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A0000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000808080000000
      00000000000000000000FFFFFF00FFFFFF00EBEBEB00AAAAAA00FFFFFF00FFFF
      FF00A0A0A000FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A00000000000FFFF
      FF00FFFFFF00F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A0A0A0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      68000000000000000000FFFFFF00FFFFFF008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000FFFFFF0000000000C0C0C000000000000000000000000000FFFFFF00FFFF
      FF00EBEBEB00BEBEBE00FFFFFF00FFFFFF00B3B3B300F1F1F100FFFFFF00FFFF
      FF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000A0A0A0000000
      000080808000FFFFFF00FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000FFFFFF00FFFFFF0039BE68000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C0C0C0000000
      00000000000000000000FFFFFF00FFFFFF00EBEBEB00A9A9A900FFFFFF00FFFF
      FF00A0A0A000FFFFFF00FFFFFF00FFFFFF00A0A0A000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A0A0A00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0039BE
      6800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00EBEBEB00B7B7B700A2A2A200A0A0A000CDCDCD00FFFFFF00FFFFFF00FFFF
      FF00A0A0A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B7B7B700CDCDCD00A0A0A000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E3E3E300D3D3D300C8C8C800C2C2C200C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C2C2C200C8C8C800D3D3D300E3E3E30000000000FEFEFE00F7F7
      F700EBEBEB00DFDFDF00D3D3D300C5C5C500B6B6B600A7A7A700999999008D8D
      8D008B8B8B0094949400A0A0A000ADADAD00BBBBBB00C9C9C900D6D6D600E2E2
      E200F0F0F000FBFBFB0000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000EEEEEE00DDDDDD00CFCFCF00CACACA00CACACA00CACACA00CACACA00CBCB
      CB00D7D7D700E8E8E800F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B40000000000FAFAFA00EBEBEB00DCDCDC00CDCDCD00BFBFBF00B0AD
      AB00A079550099602B0094521100914905009149050094511100965D29009A73
      4F00A3A09E00B1B1B100BFBFBF00CDCDCD00DCDCDC00EBEBEB0000000000F0F0
      F000F0F0F000F0F0F000F0F0F000E0E0E000CACACA00CACACA00CACACA00C5C5
      C500BBBBBB00CACACA00CACACA00CACACA00CACACA00CACACA00D6D6D600EEEE
      EE00F0F0F000F0F0F000F0F0F000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B3B300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B3B3B30000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E5D1BC00A25E1C009F530B00A4560A00AE5D0F00B865
      1600B8651600AE5D0F00A4560A009F530B00A25E1C00E5D1BC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000F0F0F000F0F0F000F0F0F000D8D8D800CACA
      CA00ABABAB00808080006868680065656500888888005F5F5F00787878009696
      9600CACACA00CACACA00CACACA00CDCDCD00EBEBEB00F0F0F000F0F0F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B1B1B100FFFFFF00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00FFFF
      FF00B1B1B10000000000FFFFFF00FFFFFF00FEFDFD00C6966800A45B1600B05F
      1100BE793C00C29E7E00CAB4A200D1CBC500D5CEC800CFB9A700C9A48300C17B
      3E00B05F1100A45B1600C6966800FEFDFD00FFFFFF00FFFFFF0000000000F0F0
      F000F0F0F000DBDBDB00CACACA00888888008C8C8C00DEDEDE00F7F7F700FDFD
      FD00F6F6F600FCFCFC00ECECEC00C3C3C30069696900B6B6B600CACACA00CACA
      CA00CDCDCD00EEEEEE00F0F0F000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE0000000000B0B0B000FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFE5D500FFFFFF00ADADAD00FFFFFF00B0B0B00000000000FFFFFF00FFFF
      FF00CB9D7200AD601500B8671900BD936E00C7C7C300E7E8E800F2F4F300D6D7
      D700D7D7D700F7F8F800EFF1F000DAD9D600C69B7500B8671900AD601500CB9D
      7200FFFFFF00FFFFFF0000000000F0F0F000E6E6E600C9C9C90072727200CDCD
      CD00FCFCFC00EAEAEA00E7E7E700E1E1E100E0E0E000E1E1E100E7E7E700F2F2
      F200EDEDED006B6B6B00B6B6B600CACACA00CACACA00D6D6D600F0F0F000EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000AEAEAE00FFFFFF00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00FFFF
      FF00AEAEAE0000000000FFFFFF00ECDBCA00B3682100B9681B00B4A29000D0D3
      D200EEF0EF00F2F4F300F4F6F500DADBDA00DADBDB00F5F7F600F4F6F500F2F4
      F300E5E7E600C7B3A000B9681B00B3682100ECDBCA00FFFFFF0000000000F0F0
      F000D1D1D10071717100D6D6D600F6F6F600E7E7E700EFEFEF00E1E1E100EDED
      ED00E4E4E400E2E2E200E1E1E100DFDFDF00E9E9E900F6F6F6006B6B6B00B6B6
      B600CACACA00CACACA00E8E8E800EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFE5D500FFFFFF00ADADAD00FFFFFF00ADADAD0000000000FDFCF900BF7F
      4300B8671B00B68D6900C9CCCB00ECEFED00EEF1EF00A6A9A700D2DFD400F0F3
      F200F0F3F200F0F3F200F0F3F200F0F2F100EEF1EF00E1E4E200C2967000B867
      1B00BF7F4300FDFCF90000000000E8E8E80097979700B5B5B500F8F8F800EAEA
      EA00E5E5E50099999900A3A3A300C3C3C300EFEFEF00E4E4E400E3E3E300E2E2
      E200E0E0E000E9E9E900EDEDED0069696900CACACA00CACACA00D7D7D700EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000ABABAB00FFFFFF00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00FFFF
      FF00ABABAB0000000000E4C9AE00B86B2100BB783A00B1B3AE00E4E8E600EAED
      EC00BEC1BE004F524F00A6A9A700CCDBCD00F0F3F200F0F3F200F0F3F200F0F3
      F200ECEFED00EAEDEC00D0D1CD00BC793B00B86B2100E4C9AE0000000000CACA
      CA0083838300FCFCFC00E9E9E900EDEDED00A5A5A500C6C6C600E1E1E100A1A1
      A100DADADA00EAEAEA00E6E6E600E4E4E400E3E3E300E1E1E100F2F2F200C4C4
      C40096969600CACACA00CBCBCB00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000AAAAAA00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFE5D500FFFFFF00ADADAD00FFFFFF00AAAAAA0000000000D9B28B00BB6D
      2500B08E6D00CDD0CF00E6EAE800E8ECEA00E9EDEB00BEC1BE004F524F00A6A9
      A700EBEEEC00F0F3F200F0F3F200F0F3F200E9EDEB00E8ECEA00E0E4E200BD98
      7500BB6D2500DAB18B0000000000A9A9A900B0B0B000F8F8F800EAEAEA00EDED
      ED00A4A4A400BCBCBC00DBDBDB009D9D9D00DBDBDB00ECECEC00E8E8E800E7E7
      E700E5E5E500E4E4E400EAEAEA00ECECEC0078787800CACACA00CACACA00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000A8A8A800FFFFFF00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00FFFF
      FF00A8A8A80000000000D09A6800BF722B00A9978300D6DAD800E4E8E600E5EA
      E700E7EBE900E8ECEA00BEC1BE004F524F00A6A9A700F0F3F200F0F3F200E8EC
      EA00E7EBE900E5EAE700E3E7E500BFA99400BF722B00D09A6800000000009090
      9000D7D7D700F7F7F700F1F1F100F2F2F200E2E2E2009595950097979700C1C1
      C100F1F1F100F0F0F000EBEBEB00E9E9E900E8E8E800E6E6E600E6E6E600FCFC
      FC005F5F5F00CACACA00CACACA00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000A7A7A700FFFFFF00ADADAD00FFFFFF00D38D5F00D38D5F00D38D
      5F00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFE5D500FFFFFF00ADADAD00FFFFFF00A7A7A70000000000C3814200BF73
      2D009E9D9500BABEBB00BEC1C000E3E8E500E4E9E700E6EAE800E6EAE8007579
      77004F524F00F0F3F200E6EAE800E6EAE800E4E9E700BFC3C100BEC1C000BEBC
      B300BF732D00C38142000000000080808000F0F0F000F5F5F500F2F2F200F2F2
      F200F3F3F300EEEEEE00E3E3E300F0F0F000F2F2F200F2F2F200F1F1F100F0F0
      F000EAEAEA00E8E8E800E6E6E600F8F8F80089898900BBBBBB00CACACA00EEEE
      EE00808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EEEEEE0080808000EEEEEE00EEEEEE0000000000A5A5A500FFFFFF00ADAD
      AD00ADADAD00D38D5F00FFFFFF00D38D5F00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00FFFF
      FF00A5A5A50000000000C5834600C17834009E9B9300C5C9C700C9CDCB00E2E7
      E500E7EBE800E9ECEB00ECEFED009B9C9B0087888700ECEFED00EAEDEC00E8EB
      E900E4E8E600CACECC00C9CDCB00BAB8AE00C1783400C5834600000000008282
      8200EAEAEA00F7F7F700F3F3F300F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F3F3F300F2F2F200F2F2F200F0F0F000EAEAEA00E8E8E800FEFE
      FE0065656500C5C5C500CACACA00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000A4A4A400FFFFFF00ADADAD00FFFFFF00D38D5F00D38D5F00D38D
      5F00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADAD
      AD00FFE5D500FFFFFF00ADADAD00FFFFFF00A4A4A40000000000D3A17300C684
      4600A4937E00CED4D100E4E8E600EDF0EF00EEF1F000EFF1F000EFF2F000A6A8
      A60067676500EFF2F100EFF2F000EFF1F000EEF1F000E5E9E800D9DEDC00B5A2
      8C00C6844600D3A1730000000000A1A1A100CCCCCC00FAFAFA00F4F4F400F5F5
      F500F5F5F500F5F5F500F6F6F600F5F5F500F5F5F500F5F5F500F4F4F400F3F3
      F300F2F2F200F0F0F000EDEDED00F8F8F80069696900CACACA00CFCFCF00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000A2A2A200FFFFFF00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00FFFF
      FF00A2A2A20000000000E0BD9D00C88B5300A8876400CACDCD00EFF2F000EFF2
      F100F0F2F100F0F3F200F1F3F200ACAEAB006E6F6C00F1F3F200F1F3F200F0F3
      F200F0F2F100EFF2F100DCE0DE00AF8D6900C88B5300E1BE9E0000000000C6C6
      C600A1A1A100FBFBFB00F5F5F500F6F6F600F6F6F600F7F7F700F7F7F700F7F7
      F700F6F6F600F6F6F600F5F5F500F4F4F400F3F3F300F2F2F200F5F5F500E1E1
      E10081818100CACACA00DDDDDD00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000A1A1A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A1A1A10000000000EDD9C600C98C
      5400B97B4000A5A6A300EBEDEC00F2F4F300F2F4F300F2F4F300F2F5F300B0B4
      B10074777400F2F5F300F2F5F300F2F4F300F2F4F300F0F2F100BDBFBC00B97B
      4000C98C5400EDD9C60000000000EFEFEF0071717100F7F7F700F9F9F900F7F7
      F700F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F7F7F700F6F6F600F5F5
      F500F4F4F400F3F3F300FEFEFE0090909000ABABAB00CACACA00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE0000000000109000002E911000309A
      220032A2310034A93F0035AF4B0037B4540038B85C0038BB620039BD660039BE
      680039BE680039BD670038BB630038B85D0037B5560036B04C0034AA410033A3
      33001090000000000000FEFDFC00D19C6D00D09A6800AC866000BFC1C000F4F6
      F500F5F6F500F5F6F600F5F6F600B5B7B600797B7A00F5F7F600F5F6F600F5F6
      F600F5F6F500D4D5D500AF896200D09A6800D19C6D00FEFDFC0000000000F0F0
      F000CFCFCF0078787800FFFFFF00F8F8F800F9F9F900F9F9F900FAFAFA00FAFA
      FA00F9F9F900F9F9F900F8F8F800F6F6F600F5F5F500FBFBFB00D3D3D3008989
      8900CACACA00E0E0E000F0F0F000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE0080808000EEEEEE00EEEE
      EE0000000000129F000074C37B0075C47D005DAC550053A2440055A4470063B2
      600084D2960086D4990088D59B0088D59B0087D49A0085D3970063B2600055A4
      470054A345005DAD560075C47E0074C37B00129F000000000000FFFFFF00F6EB
      E200CF966300CB8D5500A2938000C1C2C100F1F3F200F8F9F800F8F9F800B7B8
      B70084868400F8F9F800F8F9F800F4F5F400D1D3D200A7988400CB8D5500CF96
      6300F6EBE200FFFFFF0000000000F0F0F000F0F0F000AAAAAA009B9B9B00FFFF
      FF00FBFBFB00FAFAFA00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F9F9F900F7F7
      F700FCFCFC00DDDDDD0072727200CACACA00D8D8D800F0F0F000F0F0F000EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0080808000EEEEEE00EEEEEE000000000012A4000012A4000012A4
      000088888800EDEDED00EDEDED008888880012A4000012A4000012A4000012A4
      000012A4000012A4000088888800EDEDED00EDEDED008888880012A4000012A4
      000012A4000000000000FFFFFF00FFFFFF00E7CAB100D5A37800CC915C00AA88
      6100A8A9A600D9DADA00ECEDEC00D7D9D700BDC0BD00EEEFEE00E0E1E100B3B5
      B300AB886200CC915C00D5A37800E7CAB100FFFFFF00FFFFFF0000000000F0F0
      F000F0F0F000F0F0F000AAAAAA0078787800F8F8F800FEFEFE00FEFEFE00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FEFEFE00BABABA0073737300C9C9C900DBDB
      DB00F0F0F000F0F0F000F0F0F000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE0000000000FFFFFF00FFFFFF00FFFFFF0088888800C2C2C200C2C2C2008888
      8800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0088888800C2C2
      C200C2C2C20088888800FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFE00E7CAB100D6A27800D8AA8200B87D4300A7876400A89C8B00A5A4
      9F00A5A49F00A99C8C00A7876400B87D4300D8AA8200D6A27800E7CAB100FFFF
      FE00FFFFFF00FFFFFF0000000000F0F0F000F0F0F000F0F0F000F0F0F000CFCF
      CF0072727200A2A2A200CFCFCF00EDEDED00F3F3F300DBDBDB00B4B4B4008686
      860098989800D1D1D100E6E6E600F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00A9A9A9009797970097979700A9A9A900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A9A9A9009797970097979700A9A9A900FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7EDE400D8A9
      8200DCB08C00DFB79600D6A57B00CC925C00CC925C00D6A57B00DFB79600DCB0
      8C00D8A98200F7EDE400FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000EFEFEF00C6C6C600A1A1A1008383
      83008282820092929200A9A9A900CACACA00E8E8E800F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFDFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFD
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFDFC00F0DECF00E7C8AE00DFB49300DAAA
      8400DAAA8400DFB49300E6C8AD00F0DECF00FEFDFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E3E3E300D3D3D300C8C8C800C2C2
      C200C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C1C1C100C1C1C100C2C2C200C8C8C800D3D3D300E3E3
      E300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A0000000
      0000B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400F7F7F700DEDEDE00C3C2C200A7927F009375580091735600A08B
      7800B8B7B700D2D2D200EEEEEE00B4B4B4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A0A0A00000000000B3B3B300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00F3EAE200BA84
      5000AC692A00BB814B00BC834C00AD6A2B00B9845000F2EAE100FEFEFE00B3B3
      B30000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD0000000000FFFFFF00A0A0A000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00A0A0A0000000
      0000B1B1B100FFFFFF00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00FCFAF800BE7F4400BB8B5D00DCD8D200E3E3E100E5E4E300E6E1
      DB00C3936400BE7F4400FCFAF800B1B1B1000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D1FFF006D1FFF00FCFB
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF0000000000DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F00078787800000000000000000000000000000000007878
      7800F0F0F000F0F0F00078787800000000000000000000000000000000007878
      7800F0F0F000FFFFFF00A0A0A00000000000B0B0B000FFFFFF00ADADAD00FFFF
      FF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00DEBD9D00B77D4700DADB
      D900C1C4C200D9E1DB00EFF2F100F0F3F200E6E7E400BE834D00DEBD9D00B0B0
      B00000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF006D1FFF00752BFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEBEF0000000000DEEB
      EF00DEEBEF00DEEBEF0000000000FFFFFF00A0A0A000F0F0F00078787800F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00078787800F0F0
      F000F0F0F000F0F0F000F0F0F00078787800F0F0F000FFFFFF00A0A0A0000000
      0000AEAEAE00FFFFFF00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00CA905900BDAC9800E7EBE900C8CBC900888C8900E9ECEA00EFF2
      F100E9ECEA00CDBBA700CB905900AEAEAE000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D1FFF00752B
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAFAFA0000000000DEEB
      EF00DEEBEF00000000000000000000000000DEEBEF00DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F000FFFFFF00A0A0A00000000000ADADAD00FFFFFF00ADADAD00FFFF
      FF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00C37D3C00B1B1AA00D6DA
      D800E6EAE800A7AAA800ADB0AE00E8ECEA00D7DBD900C3C1BB00C37D3C00ADAD
      AD0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF006D1FFF00752BFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00DDDDDD0020202000FFFFFF0057575700FFFFFF00FFFFFF00F0F0F0000D0D
      0D00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF0000000000000000000000
      0000DEEBEF00DEEBEF0000000000FFFFFF00A0A0A000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F000FFFFFF00A0A0A0000000
      0000ABABAB00FFFFFF00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00CA8E5500B7B2A800E4E7E600EDF0EE00C9CBC900AFB1B000EDF0
      EF00E5E8E700C5C0B500CA8E5500ABABAB000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D1FFF00752B
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF00DADADA0020202000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F0F0000D0D0D00FFFFFF00FFFFFF0000000000DEEB
      EF000000000000000000000000000000000000000000DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F000FFFFFF00A0A0A00000000000AAAAAA00FFFFFF00ADADAD00FFFF
      FF00ADADAD00FFFFFF00ADADAD00FFFFFF00ADADAD00D9AF8800B3997E00EEF0
      EF00F1F4F300D0D3D100B2B4B200F2F4F300F0F2F100BFA58A00D9AF8800AAAA
      AA0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007A33FF006B1CFF006B1CFF006B1CFF00FEFEFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00DADADA0020202000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0F0F0000D0D
      0D00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000FFFFFF00A0A0A000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F000FFFFFF00A0A0A0000000
      0000A8A8A800FFFFFF00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00F3E6DA00C8926000C1BDB500F4F5F400D7D8D700BCBDBC00F5F6
      F500CBC7C000C8926000F3E6DA00A8A8A8000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7A9FF007931FF007F3B
      FF00C7A9FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF00DADADA0020202000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F0F0000D0D0D00FFFFFF00FFFFFF0000000000DEEB
      EF000000000000000000000000000000000000000000DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F000C8C8C80078787800282828002828280078787800C8C8
      C800F0F0F000F0F0F000C8C8C80078787800282828002828280078787800C8C8
      C800F0F0F000FFFFFF00A0A0A00000000000A7A7A700FFFFFF00ADADAD00FFFF
      FF00D38D5F00D38D5F00D38D5F00FFFFFF00ADADAD00FFFFFF00EAD1BB00CB9B
      7000B79D8200C0BDB600BBB8B100BBA28700CB9B7000EAD1BB00FFFFFF00A7A7
      A70000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008E52FF007024FF00D0B8FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00DADADA0020202000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0F0F0000D0D
      0D00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000FFFFFF00A0A0A000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00A0A0A0000000
      0000A5A5A500FFFFFF00ADADAD00ADADAD00D38D5F00FFFFFF00D38D5F00ADAD
      AD00ADADAD00FFFFFF00FFFFFF00F4E6DA00E5C4A900D7A67C00D7A67C00E5C4
      A900F4E6DA00FFFFFF00FFFFFF00A5A5A5000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D4BDFF007E39
      FF006B1CFF00E4D6FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF0092929200DADADA0020202000FFFFFF00FFFF
      FF00FFFFFF008C8C8C00F0F0F0000D0D0D00FFFFFF00FFFFFF0000000000DEEB
      EF000000000000000000000000000000000000000000DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F000FFFFFF00A0A0A00000000000A4A4A400FFFFFF00ADADAD00FFFF
      FF00D38D5F00D38D5F00D38D5F00FFFFFF00ADADAD00FFFFFF00ADADAD00FFFF
      FF00ADADAD00FFFFFF00ADADAD00FFE5D500FFFFFF00ADADAD00FFFFFF00A4A4
      A40000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFCFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF007474
      74000303030020202000FFFFFF00FFFFFF00FFFFFF0076767600040404000D0D
      0D00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF0000000000000000000000
      0000DEEBEF00DEEBEF0000000000FFFFFF00A0A0A000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F000FFFFFF00A0A0A0000000
      0000A2A2A200FFFFFF00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00FFFFFF00A2A2A2000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00EEEEEE0019191900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F70019191900FFFFFF00FFFFFF0000000000DEEB
      EF00DEEBEF00000000000000000000000000DEEBEF00DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F000FFFFFF00A0A0A00000000000A1A1A100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A1A1
      A1000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000DEEBEF00DEEBEF00DEEBEF0000000000DEEB
      EF00DEEBEF00DEEBEF0000000000FFFFFF00A0A0A000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F000FFFFFF00A0A0A0000000
      0000109000002E911000309A220032A2310034A93F0035AF4B0037B4540038B8
      5C0038BB620039BD660039BE680039BE680039BD670038BB630038B85D0037B5
      560036B04C0034AA410033A33300109000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF008080800080808000C0C0
      C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF0000000000FFFF
      FF00A0A0A000F0F0F00078787800F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F00078787800F0F0F000F0F0F000F0F0F000F0F0F0007878
      7800F0F0F000FFFFFF00A0A0A00000000000129F000074C37B0075C47D005DAC
      550053A2440055A4470063B2600084D2960086D4990088D59B0088D59B0087D4
      9A0085D3970063B2600055A4470054A345005DAD560075C47E0074C37B00129F
      00000000000080808000FFFFFF00800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000FFFFFF000000
      0000FFFFFF000000000000000000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00A0A0A000F0F0F000787878000000
      000000000000000000000000000078787800F0F0F000F0F0F000787878000000
      000000000000000000000000000078787800F0F0F000FFFFFF00A0A0A0000000
      000012A4000012A4000012A4000088888800EDEDED00EDEDED008888880012A4
      000012A4000012A4000012A4000012A4000012A4000088888800EDEDED00EDED
      ED008888880012A4000012A4000012A400000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000000000009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAA
      AD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD009CAAAD0000000000FFFF
      FF00A0A0A000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00FFFFFF008888
      8800C2C2C200C2C2C20088888800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0088888800C2C2C200C2C2C20088888800FFFFFF00FFFFFF00FFFF
      FF00000000008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000FFFFFF00A0A0A0000000
      0000FFFFFF00FFFFFF00FFFFFF00A9A9A9009797970097979700A9A9A900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A9A9A900979797009797
      9700A9A9A900FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A0A0A00000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFDFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFDFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E4B4
      7800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E8CBA500D7780000E0A4590000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00F1F9EB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F1F9EB00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FF940000FF94
      0000FF940000FF940000FF940000FF940000FF940000FF940000FF940000FF94
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7C3
      9600D7780000E0A4590000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00CDECB70060C61700E3F4
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBF7E20060C61700CAECB300FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFBF900FFFBF900FFFBF900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000080808000FFFFFF0080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7C39600D7780000E0A459000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF0092D7600091D76000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CCECB50060C61700E5F5DA00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFDC
      AF00FF940000FF940000FF940000FF960700FFAE4000FFE1BA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000B3B3B300C0C0C000C0C0
      C000C0C0C000B3B3B300C0C0C000C0C0C000C0C0C000B3B3B300C0C0C000C0C0
      C000C0C0C0008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7C39600D7780000E0A459000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00E0F3D20060C6
      1700A9DF8300CAECB200CAECB200C8EBB00092D7600062C61B00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFF1DD00FF940000FFD19500FFEED900FFE9
      CD00FFC87E00FF940000FFDCAE00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C0006E6E6E000000000092929200C0C0C00076767600000000008A8A8A00C0C0
      C0007D7D7D000000000083838300C0C0C000C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C39600D778
      0000E0A45900000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A4DE7B0060C6170062C61B0065C71F0069C8
      25006DCA2A007DD04200FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF9B1300FFC26F00FFFFFF00FFFFFF00FFFFFF00FFB75500FFAA3600FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000A1A1A1002F2F2F008D8D8D00C0C0
      C000A7A7A7002E2E2E0086868600C0C0C000AEAEAE002D2D2D007E7E7E00C0C0
      C000C0C0C000808080000000000000000000DD953B00D7780000D7780000D778
      0000D7780000D7780000D7780000D7780000D7780000D7780000D7780000D778
      0000D7780000D7780000D7780000D7780000D7780000E1AC6800000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3FA
      EE0068C82400B9E59900FFFFFF00FFFFFF0072CC320098D96900FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFB14600FFAB3800FFFFFF00FFFF
      FF00FFFFFF00FFB95900FF9C1500FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000000000000000
      0000E1AC6800DD953B00DD953B00DD953B00DD953B00DD953B00DD953B00DD95
      3B00DD953B00DD953B00DD953B00DD953B00DD953B00DD953B00DB8E2C00D778
      0000D7780000E7C396000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B7E4960060C61700FFFFFF00FFFF
      FF0060C61700B3E39000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFC57800FF930100FFD6A000FFD9A800FFC47500FF940000FFB95C00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DB8E2C00D7780000E7C3960000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007CD04000A2DD7800FEFEFE0060C61700CDEDB700FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFDBAB00FF940000FFA72E00FFAF
      4300FF940000FFA93600FFFBF800FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DB8E2C00D7780000E7C3
      960000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CAECB30060C61700D6F0
      C30060C61700E8F6DE00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFEFDD00FF940000FFD9A600FFFFFF00FFFFFF00FFB95A00FFB45000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DB8E2C00D7780000E7C39600000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008ED65B0073CC340066C72000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9B1300FFC16E00FFFF
      FF00FFFFFF00FFDEB300FF940000FFF2E300FFFFFF00FFFFFF00000000000000
      000000000000000000000000000080808000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DB8E2C00D7780000E7C39600000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDF2CE0060C6
      170081D14700FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFB14600FFAC3C00FFFFFF00FFFEFC00FFCF9000FF940000FFEB
      D100FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E5BC8700D778
      0000E7C396000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7F6DC00ECF7E400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC57800FF940000FF94
      0000FF940000FF940000FFC37100FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EBDAC3000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF2E300FFF2E300FFF3E500FFFCFB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000540000007E0000000100010000000000E80500000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000040000200001000000008000040000200001
      0000000080000400002000010000000080000400002000010000000080000400
      0020000100000000800004000020000100000000800004000020000100000000
      8000040000200001000000008000040000200001000000008000040000200001
      0000000080000400002000010000000080000400002000010000000080000400
      0020000100000000800004000020000100000000800004000020000100000000
      8000040000200001000000008000040000200001000000008000040000200001
      0000000080000400002000010000000080000400002000010000000080000400
      003FFFFF00000000FFFFFC0000200001FFFFF00080000C000020000100000000
      80000C00002000010000000080000C00002000010000000080000C0000200001
      0000000080000C00002000010000000080000C00002000010000000080000C00
      002000010000000080000C00002000010000000080000C000020000100000000
      80000C00002000010000000080000C00002000010000000080000C0000200001
      0000000080000C00002000010000000080000C00002000010000000080000C00
      002000010000000080000C00002000010000000080000C000020000100000000
      80000C00002000010000000080000C000020000100000000FFFFFC0000200001
      FFFFF0008000040000200001FFFFF0008000040000200001FFFFF00080000400
      00200001FFFFF000800004000020000000000000800004000020000000000000
      8000040000200000000000008000040000200000000000008000040000200000
      0000000080000400002000000000000080000400002000000000000080000400
      0020000000000000800004000020000000000000800004000020000000000000
      8000040000200000000000008000040000200000000000008000040000200000
      0000000080000400002000000000000080000400002000000000000080000400
      00200001FFFFF0008000040000200001FFFFF0008000040000200001FFFFF000
      FFFFFFFFFFFFFFFF00000000FFFFFFFFFFE0000100000000E00007FFFFE00001
      00000000E00000000020000100000000E00000000020000100000000E0000000
      0020000100000000E00000000020000100000000E00000000020000100000000
      E00000000020000100000000E00000000020000100000000E000000000200001
      00000000E00000000020000100000000E00000000020000100000000E0000000
      0020000100000000800000000020000100000000800000000020000100000000
      8000000000200001000000008000000000200001000000008000000000200001
      00000000800007FFFFE0000100000000FFFFFFFFFFE0000100000000FFFFFFFF
      FFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000C0003E0001FFFFFFFFFFF000
      C0003E0001FFFFFFFFEFF000C0003E0001FFFFFFFFC7F000C0003E0001F00003
      FFE3F000C0003E0001E00001FFF1F000C0003E0001E00001FFF8F000C0003E00
      01E00001FFFC7000C0003E0001E0000100003000C0003E0001E0000100003000
      C0003E0001E00001FFFC7000C0003E0001E00001FFF8F000C0003E0001E00001
      FFF1F000C0003E0001E00001FFE3F000C0003E0001E00001FFC7F000C0003E00
      01F00003FFEFF000C0003E0001FFFFFFFFFFF000C0003E0001FFFFFFFFFFF000
      C0003E0001FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF0000000000000000000
      0000000000000000000000000000}
  end
end
