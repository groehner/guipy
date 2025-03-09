object PyIDEMainForm: TPyIDEMainForm
  Left = 0
  Top = 115
  HelpContext = 100
  Caption = 'GuiPy'
  ClientHeight = 742
  ClientWidth = 1031
  Color = clWindow
  Ctl3D = False
  ParentFont = True
  Position = poDefault
  ShowHint = True
  StyleElements = [seFont, seClient]
  OnAfterMonitorDpiChanged = FormAfterMonitorDpiChanged
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShortCut = FormShortCut
  OnShow = FormShow
  TextHeight = 15
  object StatusBar: TSpTBXStatusBar
    Left = 0
    Top = 732
    Width = 1031
    Height = 10
    SizeGrip = False
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
    object spiAssistant: TTBControlItem
      Control = ActivityIndicator
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
    object ActivityIndicator: TActivityIndicator
      Left = 1027
      Top = 6
      FrameDelay = 150
      IndicatorSize = aisSmall
    end
  end
  object BGPanel: TPanel
    Left = 9
    Top = 113
    Width = 1013
    Height = 610
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 2
    ExplicitWidth = 606
    ExplicitHeight = 309
    object TabControl1: TSpTBXTabControl
      Left = 0
      Top = 0
      Width = 1009
      Height = 610
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
        CustomWidth = 883
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
        Options = [tboToolbarStyle]
      end
    end
    object TabControl2: TSpTBXTabControl
      Left = 1009
      Top = 0
      Width = 0
      Height = 610
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
      Left = 1009
      Top = 0
      Width = 4
      Height = 610
      Cursor = crSizeWE
      Align = alRight
      ParentColor = False
      Visible = False
    end
  end
  object TBXDockTop: TSpTBXDockablePanel
    Left = 0
    Top = 0
    Width = 1031
    Height = 113
    Align = alTop
    DockMode = dmCannotFloatOrChangeDocks
    DockPos = 0
    ParentShowHint = False
    PopupMenu = ToolbarPopupMenu
    ShowHint = False
    TabOrder = 1
    Options.Close = False
    Options.TitleBarMaxSize = 0
    ShowCaption = False
    ShowCaptionWhenDocked = False
    object TBControlItem3: TTBControlItem
    end
    object TBControlItem1: TTBControlItem
    end
    object DockTopPanel: TPanel
      Left = 0
      Top = 0
      Width = 1031
      Height = 113
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 624
      object DebugToolbar: TSpTBXToolbar
        Left = 2
        Top = 52
        Width = 162
        Height = 26
        DockMode = dmCannotFloatOrChangeDocks
        DockPos = 0
        DockRow = 2
        Images = vilImages
        TabOrder = 0
        Caption = 'Debug Toolbar'
        object tbiRunRun: TSpTBXItem
          Action = actRun
          ImageIndex = 33
          ImageName = 'Run1'
        end
        object tbiRunDebug: TSpTBXItem
          Action = actDebug
          ImageIndex = 34
          ImageName = 'Debug13'
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
        Left = 547
        Top = 0
        Width = 206
        Height = 26
        DockPos = 574
        DockRow = 1
        Images = vilImages
        TabOrder = 1
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
        Top = 83
        Width = 524
        Height = 26
        CloseButtonWhenDocked = True
        DockPos = 0
        DockRow = 3
        Images = vilImages
        Options = [tboDropdownArrow]
        TabOrder = 2
        Visible = False
        OnVisibleChanged = FindToolbarVisibleChanged
        Caption = 'Find Toolbar'
        Customizable = False
        object tbiFindClose: TSpTBXItem
          Caption = 'Close'
          Hint = 'Close'
          ImageIndex = 107
          ImageName = 'DiagramFromFiles'
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
          Top = 1
          Width = 160
          Height = 23
          AutoDropDownWidth = True
          AutoCloseUp = True
          ItemHeight = 15
          TabOrder = 0
          OnChange = tbiSearchTextChange
          OnExit = tbiSearchTextExit
          OnKeyPress = tbiSearchTextKeyPress
        end
        object tbiReplaceText: TSpTBXComboBox
          Left = 304
          Top = 1
          Width = 160
          Height = 23
          AutoDropDownWidth = True
          AutoCloseUp = True
          ItemHeight = 15
          TabOrder = 1
          Visible = False
          OnChange = tbiReplaceTextChange
          OnExit = tbiReplaceTextExit
          OnKeyPress = tbiReplaceTextKeyPress
        end
      end
      object MainMenu: TSpTBXToolbar
        Left = 2
        Top = -4
        Width = 377
        Height = 21
        DockMode = dmCannotFloatOrChangeDocks
        DockPos = 0
        FullSize = True
        Images = vilImages
        ProcessShortCuts = True
        ShrinkMode = tbsmWrap
        TabOrder = 3
        Customizable = False
        MenuBar = True
        object FileMenu: TSpTBXSubmenuItem
          Caption = '&File'
          object TBXSubmenuItem5: TSpTBXSubmenuItem
            Caption = '&New'
            Hint = 'New file'
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
            Hint = 'Recent files'
            object tbiRecentFileList: TSpTBXMRUListItem
              HidePathExtension = False
              MaxItems = 6
              OnClick = tbiRecentFileListClick
            end
          end
          object SpTBXSeparatorItem21: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnRemoteFileOpen: TSpTBXItem
            Action = actRemoteFileOpen
          end
          object mnRemoteFileSave: TSpTBXItem
            Action = CommandsDataModule.actFileSaveToRemote
          end
          object N14: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object mnFileSaveAll: TSpTBXItem
            Action = CommandsDataModule.actFileSaveAll
          end
          object mnFileCloseAll: TSpTBXItem
            Action = actFileCloseAll
          end
          object N2: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object mnFileExit: TSpTBXItem
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
            Tag = -2
          end
          object mnEditCut: TSpTBXItem
            Action = CommandsDataModule.actEditCut
          end
          object mnCopyMenu: TSpTBXSubmenuItem
            Caption = '&Copy'
            Hint = 'Copy'
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
            Tag = -2
          end
          object mnIndentBlock: TSpTBXItem
            Action = CommandsDataModule.actEditIndent
          end
          object mnDedentBlock: TSpTBXItem
            Action = CommandsDataModule.actEditDedent
          end
          object mnToggleComment: TSpTBXItem
            Action = CommandsDataModule.actEditToggleComment
          end
          object TBXSeparatorItem27: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnExecSelection: TSpTBXItem
            Action = actExecSelection
          end
          object mnEditReadOnly: TSpTBXItem
            Action = CommandsDataModule.actEditReadOnly
          end
          object TBXSeparatorItem9: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnSourceCode: TSpTBXSubmenuItem
            Tag = -1
            Caption = '&Source Code'
            object mnTabify: TSpTBXItem
              Action = CommandsDataModule.actEditTabify
            end
            object mnUnTabify: TSpTBXItem
              Action = CommandsDataModule.actEditUntabify
            end
          end
          object SpTBXSeparatorItem29: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnSpelling: TSpTBXSubmenuItem
            Tag = -1
            Caption = 'Spelling'
            Visible = False
            LinkSubitems = CommandsDataModule.mnSpelling
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
            Tag = -2
          end
          object TBXSubmenuItem3: TSpTBXSubmenuItem
            Caption = 'File Format'
            Hint = 'File format'
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
            Tag = -2
          end
          object mnFindinFiles: TSpTBXItem
            Action = CommandsDataModule.actFindInFiles
          end
          object N7: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
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
            Tag = -2
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
            Tag = -1
            Caption = 'Default Layout'
            GroupIndex = 3
            OnClick = mnViewDefaultLayoutClick
          end
          object mnViewDebugLayout: TSpTBXItem
            Tag = -1
            Caption = 'Debug Layout'
            GroupIndex = 3
            OnClick = mnViewDebugLayoutClick
          end
          object mnLayouts: TSpTBXSubmenuItem
            Caption = 'Layouts'
            Hint = 'Layouts'
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
              Tag = -1
              Action = actRestoreEditor
            end
          end
          object SpTBXSeparatorItem10: TSpTBXSeparatorItem
            Tag = -2
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
            Hint = 'Split Editor'
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
            Hint = 'Split Workspace'
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
            Tag = -2
          end
          object mnZoomIn: TSpTBXItem
            Action = actEditorZoomIn
          end
          object mnZoomOut: TSpTBXItem
            Action = actEditorZoomOut
          end
          object N10: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnuToolbars: TSpTBXSubmenuItem
            Tag = -1
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
            Tag = -1
            Action = actViewStatusBar
          end
          object TBXSeparatorItem18: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object mnLanguage: TSpTBXSubmenuItem
            Tag = -1
            Caption = 'Language'
          end
          object mnStyles: TSpTBXItem
            Tag = -1
            Action = actSelectStyle
          end
          object mnViewChat: TSpTBXItem
            Action = actNavChat
          end
          object mnViewII: TSpTBXItem
            Action = actViewII
            ShortCut = 49225
          end
          object mnObjectInspector: TSpTBXItem
            Caption = 'Object Inspector'
            Hint = 'Object inspector'
            Action = actViewObjectinspector
            ShortCut = 49226
          end
          object mnViewStructure: TSpTBXItem
            Action = actNavStructure
          end
          object mnViewUMLInteractive: TSpTBXItem
            Caption = 'UML interactive'
            Action = actViewUMLInteractive
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
            Tag = -2
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
            Images = ProjectExplorerWindow.vilImages
          end
          object mnProjectOpen: TSpTBXItem
            Action = ProjectExplorerWindow.actProjectOpen
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
            Tag = -2
          end
          object mnProjectSave: TSpTBXItem
            Action = ProjectExplorerWindow.actProjectSave
            Images = ProjectExplorerWindow.vilImages
          end
          object mnProjectSaveAs: TSpTBXItem
            Action = ProjectExplorerWindow.actProjectSaveAs
          end
          object SpTBXSeparatorItem4: TSpTBXSeparatorItem
            Tag = -2
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
          object mnRun: TSpTBXItem
            Action = actRun
          end
          object mnCommandLineParams: TSpTBXItem
            Action = actCommandLine
          end
          object N22: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnExternalRun: TSpTBXItem
            Action = actExternalRun
          end
          object mnConfigureExternalRun: TSpTBXItem
            Action = actExternalRunConfigure
          end
          object N8: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object mnPostMortem: TSpTBXItem
            Action = actPostMortem
          end
          object N9: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object mnPythonVersions: TSpTBXSubmenuItem
            Tag = -1
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
            Tag = -1
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
        object UMLMenu: TSpTBXSubmenuItem
          Caption = '&UML'
          object mnNewUML: TSpTBXItem
            Action = actUMLNewUML
          end
          object mnNewClass: TSpTBXItem
            Hint = 'New class'
            Action = actUMLNewClass
          end
          object mnOpenClass: TSpTBXItem
            Hint = 'Open class'
            Action = actUMLOpenClass
          end
          object mnEditClass: TSpTBXItem
            Hint = 'Edit class'
            Action = actUMLEditClass
            ImageIndex = 113
            ImageName = 'EditClass'
          end
          object mnNewComment: TSpTBXItem
            Hint = 'New comment'
            Action = actUMLNewComment
          end
          object mnNewLayout: TSpTBXItem
            Hint = 'New layout'
            Action = actUMLNewLayout
            ImageIndex = 105
            ImageName = 'NewLayout'
          end
          object mnRefresh: TSpTBXItem
            Hint = 'Refresh'
            Action = actUMLRefresh
            ImageIndex = 106
            ImageName = 'Update'
          end
          object mnRecognizeAssociations: TSpTBXItem
            Action = actUMLRecognizeAssociations
            ImageIndex = 115
            ImageName = 'RecognizeAssociations'
          end
          object mnDiagramFromOpenFiles: TSpTBXItem
            Hint = 'Diagram from open files'
            Action = actUMLDiagramFromOpenFiles
          end
          object mnOpenFolder: TSpTBXItem
            Hint = 'Open folder'
            Action = actUMLOpenFolder
            ImageIndex = 114
            ImageName = 'OpenFolder'
          end
          object mnSaveAsPicture: TSpTBXItem
            Hint = 'Save as picture'
            Action = actUMLSaveAsPicture
          end
        end
        object ToolsMenu: TSpTBXSubmenuItem
          Caption = '&Tools'
          object mnToolsConfiguration: TSpTBXItem
            Caption = 'Configuration'
            Hint = 'Configuration'
            Action = actToolsConfiguration
          end
          object mnToolsTextCompare: TSpTBXItem
            Hint = 'Textdiff'
            Action = actToolsTextDiff
          end
          object mnPythonPath: TSpTBXItem
            Action = CommandsDataModule.actPythonPath
          end
          object mnToolsGit: TSpTBXSubmenuItem
            Caption = 'Git'
            Hint = 'Git'
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
            Hint = 'SVN'
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
            Tag = -1
            Caption = 'Source Code Views'
            OnClick = EditorViewsMenuClick
          end
          object mnViewRegExpTester: TSpTBXItem
            Action = actViewRegExpTester
          end
          object mnToolsBrowser: TSpTBXItem
            Caption = 'Browser'
            Hint = 'Opens a browser window'
            ImageIndex = 116
            ImageName = 'Browser'
            OnClick = mnToolsBrowserClick
          end
          object N13: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object OptionsMenu: TSpTBXSubmenuItem
            Caption = '&Options'
            object mnImportShortcuts: TSpTBXItem
              Action = CommandsDataModule.actImportShortcuts
            end
            object mnExportShortcuts: TSpTBXItem
              Action = CommandsDataModule.actExportShortCuts
            end
            object TBXSeparatorItem30: TSpTBXSeparatorItem
            end
            object mnImportHighlighters: TSpTBXItem
              Action = CommandsDataModule.actImportHighlighters
            end
            object mnExportHighlighters: TSpTBXItem
              Action = CommandsDataModule.actExportHighlighters
            end
          end
          object TBXSeparatorItem15: TSpTBXSeparatorItem
            Tag = -2
          end
          object mnToolsEditStartupScript: TSpTBXItem
            Action = CommandsDataModule.actToolsEditStartupScripts
          end
          object mnToolsRestartLS: TSpTBXItem
            Action = CommandsDataModule.actToolsRestartLS
          end
          object SpTBXSeparatorItem12: TSpTBXSeparatorItem
            Tag = -2
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
            Tag = -2
          end
          object PyScripter1: TSpTBXSubmenuItem
            Tag = -1
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
            Tag = -2
          end
          object mnHelpAbout: TSpTBXItem
            Action = CommandsDataModule.actAbout
          end
        end
      end
      object MainToolBar: TSpTBXToolbar
        Left = 2
        Top = 23
        Width = 162
        Height = 26
        DockMode = dmCannotFloatOrChangeDocks
        DockPos = 0
        DockRow = 1
        Images = vilImages
        TabOrder = 4
        Caption = 'Main Toolbar'
        object tbiFileOpen: TSpTBXItem
          Hint = 'Open|Select a file to open'
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
          Hint = 'UML-Diagram from open files'
          Action = actUMLDiagramFromOpenFiles
        end
      end
      object TabControlWidgets: TSpTBXTabControl
        Left = 166
        Top = 23
        Width = 763
        Height = 57
        ActiveTabIndex = 1
        TabAutofit = True
        TabAutofitMaxSize = 80
        HiddenItems = <>
        object SpTBXTabItem1: TSpTBXTabItem
          Caption = 'Program'
          CustomWidth = 80
        end
        object SpTBXTabItem2: TSpTBXTabItem
          Caption = 'Tkinter'
          Checked = True
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
        object SpTBXTabSheetQtControls: TSpTBXTabSheet
          Left = 0
          Top = 25
          Width = 763
          Height = 32
          Caption = 'Qt Controls'
          ImageIndex = -1
          TabItem = 'SpTBXTabItem5'
          object ToolBarQtControls: TToolBar
            Left = 2
            Top = 0
            Width = 757
            Height = 28
            Align = alClient
            ButtonHeight = 27
            ButtonWidth = 28
            Color = clBtnFace
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = vilQtControls
            ParentColor = False
            TabOrder = 0
            object TBQtTextedit: TToolButton
              Tag = 101
              Left = 0
              Top = 0
              Hint = 'QTextEdit'
              ImageIndex = 0
              ImageName = '00'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '01'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '02'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '03'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '04'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '05'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '06'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '07'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '08'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '09'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '10'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '11'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '12'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '13'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '14'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '15'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '16'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtTreeView: TToolButton
              Tag = 118
              Left = 476
              Top = 0
              Hint = 'QTreeWidget'
              ImageIndex = 17
              ImageName = '17'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '18'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '19'
              ParentShowHint = False
              ShowHint = True
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
          Height = 32
          Caption = 'Qt Base'
          ImageIndex = -1
          TabItem = 'SpTBXTabItem4'
          object ToolBarQtBase: TToolBar
            Left = 2
            Top = 0
            Width = 757
            Height = 28
            Align = alClient
            AutoSize = True
            ButtonHeight = 27
            ButtonWidth = 28
            Color = clBtnFace
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = vilQtBaseLight
            ParentColor = False
            TabOrder = 0
            Wrapable = False
            object TBQtLabel: TToolButton
              Tag = 71
              Left = 0
              Top = 0
              Hint = 'QLabel'
              ImageIndex = 0
              ImageName = '00'
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
              ImageName = '01'
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
              ImageIndex = 2
              ImageName = '02'
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
              ImageIndex = 3
              ImageName = '03'
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
              ImageIndex = 4
              ImageName = '04'
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
              Hint = 'QButtonGroup'
              ImageIndex = 5
              ImageName = '05'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtListWidget: TToolButton
              Tag = 77
              Left = 168
              Top = 0
              Hint = 'QListWidget'
              ImageIndex = 6
              ImageName = '06'
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
              ImageIndex = 7
              ImageName = '07'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtSpinBox: TToolButton
              Tag = 79
              Left = 224
              Top = 0
              Hint = 'QSpinBox'
              ImageIndex = 8
              ImageName = '08'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtScrollbar: TToolButton
              Tag = 80
              Left = 252
              Top = 0
              Hint = 'QScrollbar'
              ImageIndex = 9
              ImageName = '09'
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
              Hint = 'QCanvas'
              ImageIndex = 10
              ImageName = '10'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtFrame: TToolButton
              Tag = 82
              Left = 308
              Top = 0
              Hint = 'QFrame'
              ImageIndex = 11
              ImageName = '11'
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
              ImageIndex = 12
              ImageName = '12'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtSlider: TToolButton
              Tag = 84
              Left = 364
              Top = 0
              Hint = 'QSlider'
              ImageIndex = 13
              ImageName = '13'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQMenuBar: TToolButton
              Tag = 85
              Left = 392
              Top = 0
              Hint = 'QMenuBar'
              ImageIndex = 14
              ImageName = '14'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtMenu: TToolButton
              Tag = 86
              Left = 420
              Top = 0
              Hint = 'QMenu'
              ImageIndex = 15
              ImageName = '15'
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
              ImageIndex = 16
              ImageName = '16'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtTreeWidget: TToolButton
              Tag = 88
              Left = 476
              Top = 0
              Hint = 'QTreeWidget'
              ImageIndex = 17
              ImageName = '17'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtTableWidget: TToolButton
              Tag = 89
              Left = 504
              Top = 0
              Hint = 'QTableWidget'
              ImageIndex = 18
              ImageName = '18'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtProgressBar: TToolButton
              Tag = 90
              Left = 532
              Top = 0
              Hint = 'QProgressBar'
              ImageIndex = 19
              ImageName = '19'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBQtStatusBar: TToolButton
              Tag = 91
              Left = 560
              Top = 0
              Hint = 'QStatusBar'
              ImageIndex = 20
              ImageName = '20'
              ParentShowHint = False
              ShowHint = True
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
          Height = 32
          Caption = 'Program'
          ImageIndex = -1
          TabItem = 'SpTBXTabItem1'
          object ToolbarProgram: TToolBar
            Left = 2
            Top = 0
            Width = 757
            Height = 28
            Align = alClient
            AutoSize = True
            ButtonHeight = 27
            ButtonWidth = 30
            Color = clBtnFace
            Images = vilProgramLight
            ParentColor = False
            TabOrder = 0
            object TBClass: TToolButton
              Left = 0
              Top = 0
              Hint = 'New class'
              ImageIndex = 0
              ImageName = '00'
              ParentShowHint = False
              ShowHint = True
              OnClick = actUMLNewClassExecute
            end
            object TBStructogram: TToolButton
              Left = 30
              Top = 0
              Hint = 'New structogram'
              ImageIndex = 1
              ImageName = '01'
              ParentShowHint = False
              ShowHint = True
              OnClick = actFileNewStructogramExecute
            end
            object TBSequence: TToolButton
              Left = 60
              Top = 0
              Hint = 'New sequence diagram'
              ImageIndex = 2
              ImageName = '02'
              ParentShowHint = False
              ShowHint = True
              OnClick = actFileNewSequencediagramExecute
            end
            object TBConsole: TToolButton
              Tag = 1
              Left = 90
              Top = 0
              Action = actFileNewModule
              ImageIndex = 3
              ImageName = '03'
              ParentShowHint = False
              ShowHint = True
            end
            object TBTkApplication: TToolButton
              Left = 120
              Top = 0
              Hint = 'New Tk/TTK-Application'
              ImageIndex = 4
              ImageName = '04'
              ParentShowHint = False
              ShowHint = True
              OnClick = actFileNewTkinterExecute
            end
            object TBQtApplication: TToolButton
              Left = 150
              Top = 0
              Hint = 'New Qt Application'
              Caption = 'Qt-Application'
              ImageIndex = 5
              ImageName = '05'
              ParentShowHint = False
              ShowHint = True
              OnClick = TBQtApplicationClick
            end
          end
        end
        object SpTBXTabSheetTTK: TSpTBXTabSheet
          Left = 0
          Top = 25
          Width = 763
          Height = 32
          Caption = 'TTK'
          ImageIndex = -1
          TabItem = 'SpTBXTabItem3'
          object ToolbarTTK: TToolBar
            Left = 2
            Top = 0
            Width = 757
            Height = 28
            Align = alClient
            AutoSize = True
            ButtonHeight = 27
            ButtonWidth = 28
            Color = clBtnFace
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = vilTTKLight
            ParentColor = False
            TabOrder = 0
            Wrapable = False
            object TBTTKLabel: TToolButton
              Tag = 31
              Left = 0
              Top = 0
              Hint = 'TTK Label'
              ImageIndex = 0
              ImageName = '00'
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
              ImageName = '01'
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
              ImageIndex = 2
              ImageName = '02'
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
              ImageIndex = 3
              ImageName = '03'
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
              ImageIndex = 4
              ImageName = '04'
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
              ImageIndex = 5
              ImageName = '05'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKListbox: TToolButton
              Tag = 8
              Left = 168
              Top = 0
              Hint = 'Tk Listbox'
              ImageIndex = 6
              ImageName = '06'
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
              ImageIndex = 7
              ImageName = '07'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKSpinbox: TToolButton
              Tag = 39
              Left = 224
              Top = 0
              Hint = 'TTK Spinbox'
              ImageIndex = 8
              ImageName = '08'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKScrollbar: TToolButton
              Tag = 42
              Left = 252
              Top = 0
              Hint = 'TTK Scrollbar'
              ImageIndex = 9
              ImageName = '09'
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
              ImageIndex = 10
              ImageName = '10'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKCanvas: TToolButton
              Tag = 11
              Left = 308
              Top = 0
              Hint = 'Tk Canvas'
              ImageIndex = 11
              ImageName = '11'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKFrame: TToolButton
              Tag = 43
              Left = 336
              Top = 0
              Hint = 'TTK Frame'
              ImageIndex = 12
              ImageName = '12'
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
              ImageIndex = 13
              ImageName = '13'
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
              ImageIndex = 14
              ImageName = '14'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKLabeldScale: TToolButton
              Tag = 46
              Left = 420
              Top = 0
              Hint = 'TTK LabeldScale'
              ImageIndex = 15
              ImageName = '15'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKPanedWindow: TToolButton
              Tag = 47
              Left = 448
              Top = 0
              Hint = 'TTK PanedWindow'
              ImageIndex = 16
              ImageName = '16'
              ParentShowHint = False
              ShowHint = True
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
              ImageName = '17'
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
              ImageName = '18'
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
              ImageIndex = 19
              ImageName = '19'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKOptionMenu: TToolButton
              Tag = 49
              Left = 560
              Top = 0
              Hint = 'TTK OptionMenu'
              ImageIndex = 20
              ImageName = '20'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKNotebook: TToolButton
              Tag = 50
              Left = 588
              Top = 0
              Hint = 'TTK Notebook'
              ImageIndex = 21
              ImageName = '21'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKTreeview: TToolButton
              Tag = 51
              Left = 616
              Top = 0
              Hint = 'TTK Treeview'
              ImageIndex = 22
              ImageName = '22'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKProgressbar: TToolButton
              Tag = 52
              Left = 644
              Top = 0
              Hint = 'TTK Progressbar'
              ImageIndex = 23
              ImageName = '23'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKSeparator: TToolButton
              Tag = 53
              Left = 672
              Top = 0
              Hint = 'TTK Separator'
              ImageIndex = 24
              ImageName = '24'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBTTKSizegrip: TToolButton
              Tag = 54
              Left = 700
              Top = 0
              Hint = 'TTK Sizegrip'
              ImageIndex = 25
              ImageName = '25'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
          end
        end
        object SpTBXTabSheetTkinter: TSpTBXTabSheet
          Left = 0
          Top = 25
          Width = 763
          Height = 32
          Caption = 'Tkinter'
          ImageIndex = -1
          TabItem = 'SpTBXTabItem2'
          object ToolbarTkinter: TToolBar
            Left = 2
            Top = 0
            Width = 757
            Height = 28
            Align = alClient
            AutoSize = True
            ButtonHeight = 27
            ButtonWidth = 28
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = vilTkInterDark
            TabOrder = 0
            Wrapable = False
            object TBLabel: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              Hint = 'Tk Label'
              Grouped = True
              ImageIndex = 0
              ImageName = '00'
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
              ImageName = '01'
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
              ImageIndex = 2
              ImageName = '02'
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
              ImageIndex = 3
              ImageName = '03'
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
              ImageIndex = 4
              ImageName = '04'
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
              ImageIndex = 5
              ImageName = '05'
              ParentShowHint = False
              ShowHint = True
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
              ImageIndex = 6
              ImageName = '06'
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
              ImageIndex = 7
              ImageName = '07'
              ParentShowHint = False
              ShowHint = True
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
              ImageIndex = 8
              ImageName = '08'
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
              ImageName = '09'
              ParentShowHint = False
              ShowHint = True
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
              ImageIndex = 10
              ImageName = '10'
              ParentShowHint = False
              ShowHint = True
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
              ImageIndex = 11
              ImageName = '11'
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
              ImageIndex = 12
              ImageName = '12'
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
              ImageIndex = 13
              ImageName = '13'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBPanedWindow: TToolButton
              Tag = 16
              Left = 392
              Top = 0
              Hint = 'Tk PanedWindow'
              ImageIndex = 14
              ImageName = '14'
              ParentShowHint = False
              ShowHint = True
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
              ImageIndex = 15
              ImageName = '15'
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
              ImageIndex = 16
              ImageName = '16'
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
              ImageIndex = 17
              ImageName = '17'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
            object TBOptionMenu: TToolButton
              Tag = 18
              Left = 504
              Top = 0
              Hint = 'Tk Optionmenu'
              ImageIndex = 18
              ImageName = '18'
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButtonClick
              OnMouseDown = ToolButtonMouseDown
              OnStartDrag = ToolButtonStartDrag
            end
          end
        end
      end
    end
  end
  object TBXDockLeft: TSpTBXDock
    Left = 0
    Top = 113
    Width = 9
    Height = 610
    FixAlign = True
    PopupMenu = ToolbarPopupMenu
    Position = dpLeft
  end
  object TBXDockRight: TSpTBXDock
    Left = 1022
    Top = 113
    Width = 9
    Height = 610
    FixAlign = True
    PopupMenu = ToolbarPopupMenu
    Position = dpRight
  end
  object TBXDockBottom: TSpTBXDock
    Left = 0
    Top = 723
    Width = 1031
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
    StorageOptions.StoreDefaultValues = False
    FlushOnDestroy = False
    Location = flCustom
    DefaultSection = 'Other Settings'
    SubStorages = <>
    Left = 794
    Top = 213
  end
  object TabControlPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 408
    Top = 226
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
    Left = 220
    Top = 224
  end
  object JvAppInstances: TJvAppInstances
    Active = False
    OnCmdLineReceived = JvAppInstancesCmdLineReceived
    Left = 667
    Top = 213
  end
  object SpTBXCustomizer: TSpTBXCustomizer
    Images = vilImages
    OnGetCustomizeForm = SpTBXCustomizerGetCustomizeForm
    Left = 328
    Top = 144
  end
  object ToolbarPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    LinkSubitems = mnuToolbars
    Left = 40
    Top = 224
  end
  object actlImmutable: TActionList
    Images = vilImages
    Left = 216
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
    object actViewUnitTests: TAction
      Category = 'View'
      Caption = '&Unit Tests'
      HelpType = htContext
      Hint = 'View/Hide Unit Tests Window'
      ImageIndex = 68
      ImageName = 'UnitTestWin'
      OnExecute = actViewUnitTestsExecute
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
      ImageName = 'ClassEdit'
      OnExecute = actUMLEditClassExecute
    end
    object actUMLNewComment: TAction
      Category = 'UML'
      Caption = 'New comment'
      ImageIndex = 104
      ImageName = 'NewComment'
      OnExecute = actUMLNewCommentExecute
    end
    object actUMLNewLayout: TAction
      Category = 'UML'
      Caption = 'New layout'
      ImageName = 'Aktualisieren'
      OnExecute = actUMLNewLayoutExecute
    end
    object actUMLRefresh: TAction
      Category = 'UML'
      Caption = 'Refresh'
      ImageIndex = 105
      ImageName = 'NewLayout'
      OnExecute = actUMLRefreshExecute
    end
    object actUMLDiagramFromOpenFiles: TAction
      Category = 'UML'
      Caption = 'Diagram from open files'
      ImageIndex = 107
      ImageName = 'DiagramFromFiles'
      OnExecute = actUMLDiagramFromOpenFilesExecute
    end
    object actUMLOpenFolder: TAction
      Category = 'UML'
      Caption = 'Open folder'
      ImageIndex = 109
      ImageName = 'TextDiff'
      OnExecute = actUMLOpenFolderExecute
    end
    object actUMLSaveAsPicture: TAction
      Category = 'UML'
      Caption = 'Save as picture'
      ImageIndex = 108
      ImageName = 'SaveAsPicture'
      OnExecute = actUMLSaveAsPictureExecute
    end
    object actToolsTextDiff: TAction
      Category = 'Tools'
      Caption = 'Textdiff'
      ImageIndex = 109
      ImageName = 'TextDiff'
      OnExecute = actToolsTextDiffExecute
    end
    object actToolsConfiguration: TAction
      Category = 'Tools'
      Caption = 'Tools configuration'
      ImageIndex = 110
      ImageName = 'Configuration'
      OnExecute = actToolsConfigurationExecute
    end
    object actToolsGit: TAction
      Category = 'Tools'
      Caption = 'Git'
      ImageIndex = 109
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
    object actUMLRecognizeAssociations: TAction
      Category = 'UML'
      Caption = 'Recognize associations'
      ImageIndex = 110
      ImageName = 'Configuration'
      OnExecute = actUMLRecognizeAssociationsExecute
    end
    object actNavChat: TAction
      Category = 'IDE Navigation'
      Caption = 'Chat'
      Hint = 'Activate the Chat window'
      ImageIndex = 117
      ImageName = 'Chat'
      ShortCut = 49217
      OnExecute = actNavChatExecute
    end
    object actPythonFreeThreaded: TAction
      Category = 'Run'
      Caption = 'Free-Threaded'
      Hint = 'Use the free-trheaded version of Python'
      OnExecute = actPythonFreeThreadedExecute
    end
    object actViewUMLInteractive: TAction
      Category = 'View'
      OnExecute = actViewUMLInteractiveExecute
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
    Left = 674
    Top = 133
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 37
        CollectionName = 'FileNew'
        Name = 'FileNew'
      end
      item
        CollectionIndex = 38
        CollectionName = 'FileOpen'
        Name = 'FileOpen'
      end
      item
        CollectionIndex = 99
        CollectionName = 'Save13'
        Name = 'Save13'
      end
      item
        CollectionIndex = 100
        CollectionName = 'SaveAll'
        Name = 'SaveAll'
      end
      item
        CollectionIndex = 72
        CollectionName = 'PrintSetup'
        Name = 'PrintSetup'
      end
      item
        CollectionIndex = 71
        CollectionName = 'PrintPreview'
        Name = 'PrintPreview'
      end
      item
        CollectionIndex = 70
        CollectionName = 'Print'
        Name = 'Print'
      end
      item
        CollectionIndex = 128
        CollectionName = 'Undo13'
        Name = 'Undo13'
      end
      item
        CollectionIndex = 87
        CollectionName = 'Redo13'
        Name = 'Redo13'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Cut'
        Name = 'Cut'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 65
        CollectionName = 'Paste'
        Name = 'Paste'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 101
        CollectionName = 'Search'
        Name = 'Search'
      end
      item
        CollectionIndex = 41
        CollectionName = 'FindNext'
        Name = 'FindNext'
      end
      item
        CollectionIndex = 91
        CollectionName = 'Replace'
        Name = 'Replace'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Execute'
        Name = 'Execute'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Check'
        Name = 'Check'
      end
      item
        CollectionIndex = 27
        CollectionName = 'EditOptions'
        Name = 'EditOptions'
      end
      item
        CollectionIndex = 1
        CollectionName = 'AppSettings'
        Name = 'AppSettings'
      end
      item
        CollectionIndex = 46
        CollectionName = 'Folders'
        Name = 'Folders'
      end
      item
        CollectionIndex = 49
        CollectionName = 'Function'
        Name = 'Function'
      end
      item
        CollectionIndex = 32
        CollectionName = 'ExternalRun'
        Name = 'ExternalRun'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Expand'
        Name = 'Expand'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Collapse'
        Name = 'Collapse'
      end
      item
        CollectionIndex = 55
        CollectionName = 'Info'
        Name = 'Info'
      end
      item
        CollectionIndex = 51
        CollectionName = 'GoToLine'
        Name = 'GoToLine'
      end
      item
        CollectionIndex = 52
        CollectionName = 'Help'
        Name = 'Help'
      end
      item
        CollectionIndex = 97
        CollectionName = 'RunScript'
        Name = 'RunScript'
      end
      item
        CollectionIndex = 88
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 0
        CollectionName = 'Abort'
        Name = 'Abort'
      end
      item
        CollectionIndex = 58
        CollectionName = 'LineNumbers'
        Name = 'LineNumbers'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Exit'
        Name = 'Exit'
      end
      item
        CollectionIndex = 93
        CollectionName = 'Run1'
        Name = 'Run1'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Debug13'
        Name = 'Debug13'
      end
      item
        CollectionIndex = 98
        CollectionName = 'RunToCursor'
        Name = 'RunToCursor'
      end
      item
        CollectionIndex = 108
        CollectionName = 'StepIn'
        Name = 'StepIn'
      end
      item
        CollectionIndex = 110
        CollectionName = 'StepOver'
        Name = 'StepOver'
      end
      item
        CollectionIndex = 109
        CollectionName = 'StepOut'
        Name = 'StepOut'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Breakpoint'
        Name = 'Breakpoint'
      end
      item
        CollectionIndex = 7
        CollectionName = 'BreakpointsRemove'
        Name = 'BreakpointsRemove'
      end
      item
        CollectionIndex = 10
        CollectionName = 'CallStack'
        Name = 'CallStack'
      end
      item
        CollectionIndex = 132
        CollectionName = 'VariablesWin'
        Name = 'VariablesWin'
      end
      item
        CollectionIndex = 136
        CollectionName = 'WatchesWin'
        Name = 'WatchesWin'
      end
      item
        CollectionIndex = 8
        CollectionName = 'BreakpointsWin'
        Name = 'BreakpointsWin'
      end
      item
        CollectionIndex = 54
        CollectionName = 'Indent'
        Name = 'Indent'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Dedent'
        Name = 'Dedent'
      end
      item
        CollectionIndex = 13
        CollectionName = 'CodeComment'
        Name = 'CodeComment'
      end
      item
        CollectionIndex = 127
        CollectionName = 'UnCodeComment'
        Name = 'UnCodeComment'
      end
      item
        CollectionIndex = 61
        CollectionName = 'MessagesWin'
        Name = 'MessagesWin'
      end
      item
        CollectionIndex = 14
        CollectionName = 'CodeExplorer'
        Name = 'CodeExplorer'
      end
      item
        CollectionIndex = 80
        CollectionName = 'PyDoc'
        Name = 'PyDoc'
      end
      item
        CollectionIndex = 64
        CollectionName = 'PageSetup'
        Name = 'PageSetup'
      end
      item
        CollectionIndex = 114
        CollectionName = 'TabNext'
        Name = 'TabNext'
      end
      item
        CollectionIndex = 115
        CollectionName = 'TabPrevious'
        Name = 'TabPrevious'
      end
      item
        CollectionIndex = 123
        CollectionName = 'Tools'
        Name = 'Tools'
      end
      item
        CollectionIndex = 124
        CollectionName = 'ToolsSetup'
        Name = 'ToolsSetup'
      end
      item
        CollectionIndex = 36
        CollectionName = 'FileExplorer'
        Name = 'FileExplorer'
      end
      item
        CollectionIndex = 121
        CollectionName = 'TodoWin'
        Name = 'TodoWin'
      end
      item
        CollectionIndex = 102
        CollectionName = 'SearchFolder'
        Name = 'SearchFolder'
      end
      item
        CollectionIndex = 44
        CollectionName = 'FindResults'
        Name = 'FindResults'
      end
      item
        CollectionIndex = 34
        CollectionName = 'ExternalRunSetup'
        Name = 'ExternalRunSetup'
      end
      item
        CollectionIndex = 12
        CollectionName = 'CmdOuputWin'
        Name = 'CmdOuputWin'
      end
      item
        CollectionIndex = 104
        CollectionName = 'SpecialChars'
        Name = 'SpecialChars'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ArrowLeft'
        Name = 'ArrowLeft'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ArrowRight'
        Name = 'ArrowRight'
      end
      item
        CollectionIndex = 89
        CollectionName = 'RegExp'
        Name = 'RegExp'
      end
      item
        CollectionIndex = 56
        CollectionName = 'Keyboard'
        Name = 'Keyboard'
      end
      item
        CollectionIndex = 129
        CollectionName = 'UnitTestWin'
        Name = 'UnitTestWin'
      end
      item
        CollectionIndex = 112
        CollectionName = 'Styles'
        Name = 'Styles'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Assembly'
        Name = 'Assembly'
      end
      item
        CollectionIndex = 139
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 140
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 66
        CollectionName = 'Pause'
        Name = 'Pause'
      end
      item
        CollectionIndex = 25
        CollectionName = 'EditorMax'
        Name = 'EditorMax'
      end
      item
        CollectionIndex = 28
        CollectionName = 'EditorMin'
        Name = 'EditorMin'
      end
      item
        CollectionIndex = 42
        CollectionName = 'FindPrevious'
        Name = 'FindPrevious'
      end
      item
        CollectionIndex = 53
        CollectionName = 'Highlight'
        Name = 'Highlight'
      end
      item
        CollectionIndex = 50
        CollectionName = 'GoToError'
        Name = 'GoToError'
      end
      item
        CollectionIndex = 138
        CollectionName = 'WordWrap'
        Name = 'WordWrap'
      end
      item
        CollectionIndex = 107
        CollectionName = 'SplitVertical'
        Name = 'SplitVertical'
      end
      item
        CollectionIndex = 106
        CollectionName = 'SplitHorizontal'
        Name = 'SplitHorizontal'
      end
      item
        CollectionIndex = 69
        CollectionName = 'PostMortem'
        Name = 'PostMortem'
      end
      item
        CollectionIndex = 84
        CollectionName = 'Python'
        Name = 'Python'
      end
      item
        CollectionIndex = 85
        CollectionName = 'PythonScript'
        Name = 'PythonScript'
      end
      item
        CollectionIndex = 74
        CollectionName = 'ProjectExplorer'
        Name = 'ProjectExplorer'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Editor'
        Name = 'Editor'
      end
      item
        CollectionIndex = 96
        CollectionName = 'RunLast'
        Name = 'RunLast'
      end
      item
        CollectionIndex = 19
        CollectionName = 'DebugLast'
        Name = 'DebugLast'
      end
      item
        CollectionIndex = 33
        CollectionName = 'ExternalRunLast'
        Name = 'ExternalRunLast'
      end
      item
        CollectionIndex = 59
        CollectionName = 'Link'
        Name = 'Link'
      end
      item
        CollectionIndex = 137
        CollectionName = 'Web'
        Name = 'Web'
      end
      item
        CollectionIndex = 113
        CollectionName = 'TabClose'
        Name = 'TabCLose'
      end
      item
        CollectionIndex = 117
        CollectionName = 'TabsClose'
        Name = 'TabsClose'
      end
      item
        CollectionIndex = 81
        CollectionName = 'PySetup'
        Name = 'PySetup'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Download'
        Name = 'Download'
      end
      item
        CollectionIndex = 131
        CollectionName = 'Upload'
        Name = 'Upload'
      end
      item
        CollectionIndex = 57
        CollectionName = 'Layouts'
        Name = 'Layouts'
      end
      item
        CollectionIndex = 116
        CollectionName = 'Tabs'
        Name = 'Tabs'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Bug'
        Name = 'Bug'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Edit'
        Name = 'Edit'
      end
      item
        CollectionIndex = 103
        CollectionName = 'Setup'
        Name = 'Setup'
      end
      item
        CollectionIndex = 148
        CollectionName = 'UMLNew'
        Name = 'UMLNew'
      end
      item
        CollectionIndex = 149
        CollectionName = 'UMLOpen'
        Name = 'UMLOpen'
      end
      item
        CollectionIndex = 150
        CollectionName = 'NewComment'
        Name = 'NewComment'
      end
      item
        CollectionIndex = 151
        CollectionName = 'NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 152
        CollectionName = 'Update'
        Name = 'Update'
      end
      item
        CollectionIndex = 153
        CollectionName = 'DiagramFromFiles'
        Name = 'DiagramFromFiles'
      end
      item
        CollectionIndex = 154
        CollectionName = 'SaveAsPicture'
        Name = 'SaveAsPicture'
      end
      item
        CollectionIndex = 155
        CollectionName = 'TextDiff'
        Name = 'TextDiff'
      end
      item
        CollectionIndex = 156
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end
      item
        CollectionIndex = 157
        CollectionName = 'git'
        Name = 'git'
      end
      item
        CollectionIndex = 158
        CollectionName = 'svn'
        Name = 'svn'
      end
      item
        CollectionIndex = 160
        CollectionName = 'EditClass'
        Name = 'EditClass'
      end
      item
        CollectionIndex = 161
        CollectionName = 'OpenFolder'
        Name = 'OpenFolder'
      end
      item
        CollectionIndex = 162
        CollectionName = 'RecognizeAssociations'
        Name = 'RecognizeAssociations'
      end
      item
        CollectionIndex = 163
        CollectionName = 'Browser'
        Name = 'Browser'
      end
      item
        CollectionIndex = 142
        CollectionName = 'Chat\Chat'
        Name = 'Chat'
      end
      item
        CollectionIndex = 165
        CollectionName = 'Cancel'
        Name = 'Cancel'
      end
      item
        CollectionIndex = 164
        CollectionName = 'Assistant'
        Name = 'Assistant'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Width = 20
    Height = 20
    Left = 768
    Top = 448
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
    Left = 664
    Top = 360
  end
  object vilIndicators: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'StatusLED'
        Name = 'StatusLED'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ExternalToolsLED'
        Name = 'ExternalToolsLED'
      end
      item
        CollectionIndex = 2
        CollectionName = 'LspLED'
        Name = 'LspLED'
      end>
    ImageCollection = icIndicators
    PreserveItems = True
    Width = 12
    Height = 12
    Left = 760
    Top = 360
  end
  object MachineStorage: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    SubStorages = <>
    Left = 793
    Top = 136
  end
  object vilTabDecorators: TVirtualImageList
    Images = <
      item
        CollectionIndex = 9
        CollectionName = 'Bug'
        Name = 'Bug'
      end
      item
        CollectionIndex = 60
        CollectionName = 'Lock'
        Name = 'Lock'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Width = 14
    Height = 14
    Left = 664
    Top = 448
  end
  object DdeServerConv: TDdeServerConv
    OnExecuteMacro = DdeServerConvExecuteMacro
    Left = 792
    Top = 272
  end
  object vilTkInterLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end>
    ImageCollection = DMImages.icTkInter
    Width = 21
    Height = 21
    Left = 40
    Top = 384
  end
  object vilTkInterDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 19
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end>
    ImageCollection = DMImages.icTkInter
    Width = 21
    Height = 21
    Left = 136
    Top = 384
  end
  object vilTTKLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end
      item
        CollectionIndex = 19
        CollectionName = '19'
        Name = '19'
      end
      item
        CollectionIndex = 20
        CollectionName = '20'
        Name = '20'
      end
      item
        CollectionIndex = 21
        CollectionName = '21'
        Name = '21'
      end
      item
        CollectionIndex = 22
        CollectionName = '22'
        Name = '22'
      end
      item
        CollectionIndex = 23
        CollectionName = '23'
        Name = '23'
      end
      item
        CollectionIndex = 24
        CollectionName = '24'
        Name = '24'
      end
      item
        CollectionIndex = 25
        CollectionName = '25'
        Name = '25'
      end>
    ImageCollection = DMImages.icTTKinter
    Width = 21
    Height = 21
    Left = 40
    Top = 456
  end
  object vilTTKDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 26
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end
      item
        CollectionIndex = 19
        CollectionName = '19'
        Name = '19'
      end
      item
        CollectionIndex = 20
        CollectionName = '20'
        Name = '20'
      end
      item
        CollectionIndex = 21
        CollectionName = '21'
        Name = '21'
      end
      item
        CollectionIndex = 22
        CollectionName = '22'
        Name = '22'
      end
      item
        CollectionIndex = 23
        CollectionName = '23'
        Name = '23'
      end
      item
        CollectionIndex = 24
        CollectionName = '24'
        Name = '24'
      end
      item
        CollectionIndex = 25
        CollectionName = '25'
        Name = '25'
      end>
    ImageCollection = DMImages.icTTKinter
    Width = 21
    Height = 21
    Left = 136
    Top = 456
  end
  object vilQtBaseLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end
      item
        CollectionIndex = 19
        CollectionName = '19'
        Name = '19'
      end
      item
        CollectionIndex = 20
        CollectionName = '20'
        Name = '20'
      end>
    ImageCollection = DMImages.icQtBase
    Width = 21
    Height = 21
    Left = 40
    Top = 536
  end
  object vilQtBaseDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 21
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end
      item
        CollectionIndex = 19
        CollectionName = '19'
        Name = '19'
      end
      item
        CollectionIndex = 20
        CollectionName = '20'
        Name = '20'
      end>
    ImageCollection = DMImages.icQtBase
    Width = 21
    Height = 21
    Left = 136
    Top = 536
  end
  object vilQtControls: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end
      item
        CollectionIndex = 6
        CollectionName = '06'
        Name = '06'
      end
      item
        CollectionIndex = 7
        CollectionName = '07'
        Name = '07'
      end
      item
        CollectionIndex = 8
        CollectionName = '08'
        Name = '08'
      end
      item
        CollectionIndex = 9
        CollectionName = '09'
        Name = '09'
      end
      item
        CollectionIndex = 10
        CollectionName = '10'
        Name = '10'
      end
      item
        CollectionIndex = 11
        CollectionName = '11'
        Name = '11'
      end
      item
        CollectionIndex = 12
        CollectionName = '12'
        Name = '12'
      end
      item
        CollectionIndex = 13
        CollectionName = '13'
        Name = '13'
      end
      item
        CollectionIndex = 14
        CollectionName = '14'
        Name = '14'
      end
      item
        CollectionIndex = 15
        CollectionName = '15'
        Name = '15'
      end
      item
        CollectionIndex = 16
        CollectionName = '16'
        Name = '16'
      end
      item
        CollectionIndex = 17
        CollectionName = '17'
        Name = '17'
      end
      item
        CollectionIndex = 18
        CollectionName = '18'
        Name = '18'
      end
      item
        CollectionIndex = 19
        CollectionName = '19'
        Name = '19'
      end>
    ImageCollection = DMImages.icQtControls
    Width = 21
    Height = 21
    Left = 89
    Top = 617
  end
  object vilProgramLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 2
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 4
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 6
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 7
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 8
        CollectionName = '05'
        Name = '05'
      end>
    ImageCollection = DMImages.icProgram
    Width = 23
    Height = 17
    Left = 40
    Top = 312
  end
  object vilProgramDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 1
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 3
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 5
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 6
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 7
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 8
        CollectionName = '05'
        Name = '05'
      end>
    ImageCollection = DMImages.icProgram
    Width = 23
    Height = 17
    Left = 136
    Top = 312
  end
end
