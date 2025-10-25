object EditorForm: TEditorForm
  Left = 304
  Top = 173
  BorderStyle = bsNone
  ClientHeight = 575
  ClientWidth = 503
  Color = clWindow
  Ctl3D = False
  ParentFont = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object BGPanel: TPanel
    Left = 0
    Top = 0
    Width = 503
    Height = 575
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 0
    StyleElements = [seFont]
    object ViewsTabControl: TSpTBXTabControl
      Left = 2
      Top = 2
      Width = 499
      Height = 571
      Align = alClient
      OnContextPopup = ViewsTabControlContextPopup
      OnEnter = FGPanelEnter
      OnExit = FGPanelExit
      ActiveTabIndex = 0
      OnActiveTabChange = ViewsTabControlActiveTabChange
      HiddenItems = <>
      object tabSource: TSpTBXTabItem
        Caption = 'Source'
        Checked = True
      end
      object SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
        CustomWidth = 558
      end
      object tbiUpdateView: TSpTBXItem
        Caption = 'Update View'
        Hint = 'Update View|Update the selected view'
        ImageIndex = 29
        ImageName = 'Refresh'
        OnClick = mnUpdateViewClick
      end
      object tbiCloseTab: TSpTBXItem
        Caption = 'Close Tab'
        Hint = 'Close active tab'
        ImageIndex = 92
        ImageName = 'TabClose'
        OnClick = mnCloseTabClick
      end
      object tbshSource: TSpTBXTabSheet
        Left = 0
        Top = 25
        Width = 499
        Height = 546
        Caption = 'Source'
        ImageIndex = -1
        TabItem = 'tabSource'
        object SynEdit: TSynEdit
          Left = 48
          Top = 0
          Width = 442
          Height = 542
          HelpContext = 510
          Align = alClient
          Ctl3D = False
          ParentCtl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          ParentShowHint = False
          PopupMenu = pmnuEditor
          ShowHint = True
          TabOrder = 0
          OnDblClick = SynEditDblClick
          OnEnter = SynEditEnter
          OnExit = SynEditExit
          OnKeyDown = SynEditKeyDown
          OnKeyUp = SynEditKeyUp
          OnMouseDown = SynEditMouseDown
          UseCodeFolding = False
          BorderStyle = bsNone
          Gutter.BorderStyle = gbsNone
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
          Gutter.Font.Quality = fqClearTypeNatural
          Gutter.Gradient = True
          Gutter.GradientSteps = 30
          Gutter.TrackChanges.Width = 2
          Gutter.TrackChanges.Visible = True
          Gutter.Bands = <
            item
              Kind = gbkMarks
              Width = 13
              OnCLick = SynEditGutterMarksCLick
              OnContextPopup = SynEditGutterMarksContextPopup
              OnMouseCursor = SynEditGutterMarksMouseCursor
            end
            item
              Kind = gbkCustom
              Width = 13
              OnPaintLines = SynEditDebugInfoPaintLines
              OnCLick = SynEditGutterDebugInfoCLick
              OnMouseCursor = SynEditGutterDebugInfoMouseCursor
            end
            item
              Kind = gbkLineNumbers
            end
            item
              Kind = gbkFold
            end
            item
              Kind = gbkTrackChanges
              Background = gbbEditor
            end
            item
              Kind = gbkMargin
              Width = 3
              Background = gbbEditor
            end>
          IndentGuides.Style = igsDotted
          ScrollbarAnnotations = <
            item
              AnnType = sbaCarets
              AnnPos = sbpFullWidth
              FullRow = False
            end
            item
              AnnType = sbaBookmark
              AnnPos = sbpLeft
              FullRow = True
            end
            item
              AnnType = sbaTrackChanges
              AnnPos = sbpRight
              FullRow = True
            end>
          SelectedColor.Background = clSkyBlue
          TabWidth = 4
          WantTabs = True
          OnChange = SynEditChange
          OnGutterGetText = SynEditGutterGetText
          OnMouseCursor = SynEditMouseCursor
          OnShowHint = EditorShowHint
          OnSpecialLineColors = SynEditSpecialLineColors
          OnStatusChange = SynEditStatusChange
        end
        object SynEdit2: TSynEdit
          Left = 490
          Top = 0
          Width = 0
          Height = 542
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          ParentShowHint = False
          PopupMenu = pmnuEditor
          ShowHint = True
          TabOrder = 1
          Visible = False
          OnDblClick = SynEditDblClick
          OnEnter = SynEditEnter
          OnExit = SynEditExit
          OnKeyDown = SynEditKeyDown
          OnKeyUp = SynEditKeyUp
          OnMouseDown = SynEditMouseDown
          UseCodeFolding = False
          BorderStyle = bsNone
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
          Gutter.Font.Quality = fqClearTypeNatural
          Gutter.Bands = <
            item
              Kind = gbkMarks
              Width = 13
            end
            item
              Kind = gbkLineNumbers
            end
            item
              Kind = gbkFold
            end
            item
              Kind = gbkTrackChanges
              Background = gbbEditor
            end
            item
              Kind = gbkMargin
              Width = 2
              Background = gbbEditor
            end>
          ScrollbarAnnotations = <
            item
              AnnType = sbaCarets
              AnnPos = sbpFullWidth
              FullRow = False
            end
            item
              AnnType = sbaBookmark
              AnnPos = sbpLeft
              FullRow = True
            end
            item
              AnnType = sbaTrackChanges
              AnnPos = sbpRight
              FullRow = True
            end>
          OnMouseCursor = SynEditMouseCursor
          OnShowHint = EditorShowHint
          OnSpecialLineColors = SynEditSpecialLineColors
          OnStatusChange = SynEditStatusChange
        end
        object EditorSplitter: TSpTBXSplitter
          Left = 490
          Top = 0
          Height = 542
          Cursor = crSizeWE
          Align = alRight
          ParentColor = False
          Visible = False
          GripSize = 80
        end
        object EditformToolbar: TToolBar
          Left = 2
          Top = 0
          Width = 46
          Height = 542
          Align = alLeft
          AutoSize = True
          Images = vilEditorToolbarLight
          TabOrder = 3
          object TBClose: TToolButton
            Left = 0
            Top = 0
            Hint = 'Close|Close active file'
            Caption = '&Close'
            ImageIndex = 0
            ImageName = 'Close'
            OnClick = TBCloseClick
          end
          object TBExplorer: TToolButton
            Left = 23
            Top = 0
            Hint = 'Open explorer for current file'
            ImageIndex = 1
            ImageName = 'Explorer'
            Wrap = True
            OnClick = TBExplorerClick
          end
          object TBBrowser: TToolButton
            Left = 0
            Top = 22
            Hint = 'Show in browser'
            ImageIndex = 2
            ImageName = 'Browser'
            OnClick = TBBrowserClick
          end
          object TBDesignform: TToolButton
            Left = 23
            Top = 22
            Hint = 'Open associated design form'
            ImageIndex = 3
            ImageName = 'Designform'
            Wrap = True
            OnClick = TBDesignformClick
          end
          object TBClassOpen: TToolButton
            Left = 0
            Top = 44
            Hint = 'Open class in the UML window'
            ImageIndex = 4
            ImageName = 'ClassOpen'
            OnClick = TBClassOpenClick
          end
          object TBCheck: TToolButton
            Left = 23
            Top = 44
            Hint = 'Check Syntax'
            ImageIndex = 5
            ImageName = 'Check'
            Wrap = True
            OnClick = TBCheckClick
          end
          object TBMatchBracket: TToolButton
            Left = 0
            Top = 66
            Hint = 'Match bracket'
            ImageIndex = 6
            ImageName = 'MatchBracket'
            OnClick = TBMatchBracketClick
          end
          object TBClassEdit: TToolButton
            Left = 23
            Top = 66
            Hint = 'Edit class'
            ImageIndex = 7
            ImageName = 'ClassEdit'
            Wrap = True
            OnClick = TBClassEditClick
          end
          object TBStructureIndent: TToolButton
            Left = 0
            Top = 88
            Hint = 'Indent structured'
            ImageIndex = 8
            ImageName = 'StructureIndent'
            OnClick = TBStructureIndentClick
          end
          object TBIfStatement: TToolButton
            Tag = 1
            Left = 23
            Top = 88
            Hint = 'If-Statement'
            ImageIndex = 9
            ImageName = 'IfStatement'
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBIfElseStatement: TToolButton
            Tag = 9
            Left = 0
            Top = 110
            Hint = 'If-Else-Statement'
            ImageIndex = 10
            ImageName = 'IfElseStatement'
            OnClick = TBStatementClick
          end
          object TBWhileStatement: TToolButton
            Tag = 2
            Left = 23
            Top = 110
            Hint = 'while-Statement'
            ImageIndex = 11
            ImageName = 'WhileStatement'
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBForStatement: TToolButton
            Tag = 3
            Left = 0
            Top = 132
            Hint = 'for-Statement'
            ImageIndex = 12
            ImageName = 'ForStatement'
            OnClick = TBStatementClick
          end
          object TBIfElifStatement: TToolButton
            Tag = 5
            Left = 23
            Top = 132
            Hint = 'if-elif-Statement'
            ImageIndex = 13
            ImageName = 'SwitchStatement'
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBTryStatement: TToolButton
            Tag = 6
            Left = 0
            Top = 154
            Hint = 'try-Statement'
            ImageIndex = 14
            ImageName = 'TryStatement'
            OnClick = TBStatementClick
          end
          object TBComment: TToolButton
            Left = 23
            Top = 154
            Hint = 'Comment on/off'
            ImageIndex = 15
            ImageName = 'Comment'
            Wrap = True
            OnClick = TBCommentClick
          end
          object TBWordWrap: TToolButton
            Left = 0
            Top = 176
            Hint = 'Wordwrap'
            ImageIndex = 17
            ImageName = 'WordWrap'
            OnClick = TBWordWrapClick
          end
          object TBIndent: TToolButton
            Left = 23
            Top = 176
            Hint = 'Indent'
            ImageIndex = 18
            ImageName = 'Indent'
            Wrap = True
            OnClick = TBIndentClick
          end
          object TBUnindent: TToolButton
            Left = 0
            Top = 198
            Hint = 'Unindent'
            ImageIndex = 19
            ImageName = 'Unindent'
            OnClick = TBUnindentClick
          end
          object TBBreakpoint: TToolButton
            Left = 23
            Top = 198
            Hint = 'Breakpoint on/off'
            ImageIndex = 20
            ImageName = 'Breakpoint'
            Wrap = True
            OnClick = TBBreakpointClick
          end
          object TBBreakpointsClear: TToolButton
            Left = 0
            Top = 220
            Hint = 'Delete all breakpoints'
            ImageIndex = 21
            ImageName = 'BreakpointsClear'
            OnClick = TBBreakpointsClearClick
          end
          object TBBookmark: TToolButton
            Left = 23
            Top = 220
            Hint = 'Set bookmark'
            ImageIndex = 22
            ImageName = 'Bookmark'
            Wrap = True
            OnClick = TBBookmarkClick
          end
          object TBGotoBookmark: TToolButton
            Left = 0
            Top = 242
            Hint = 'Goto bookmark'
            ImageIndex = 23
            ImageName = 'GotoBookmark'
            OnClick = TBGotoBookmarkClick
          end
          object TBParagraph: TToolButton
            Left = 23
            Top = 242
            Hint = 'Paragraph marks on/off'
            ImageIndex = 24
            ImageName = 'Paragraph'
            Wrap = True
            OnClick = TBParagraphClick
          end
          object TBNumbers: TToolButton
            Left = 0
            Top = 264
            Hint = 'Line numbers on/off'
            ImageIndex = 25
            ImageName = 'Numbers'
            OnClick = TBNumbersClick
          end
          object TBZoomMinus: TToolButton
            Left = 23
            Top = 264
            Hint = 'Zoom out'
            ImageIndex = 26
            ImageName = 'ZoomOut'
            Wrap = True
            OnClick = TBZoomMinusClick
          end
          object TBZoomPlus: TToolButton
            Left = 0
            Top = 286
            Hint = 'Zoom in'
            ImageIndex = 27
            ImageName = 'ZoomIn'
            OnClick = TBZoomPlusClick
          end
          object TBValidate: TToolButton
            Left = 23
            Top = 286
            Hint = 'Validate'
            ImageIndex = 28
            ImageName = 'Validate'
            OnClick = TBValidateClick
          end
        end
        object TVFileStructure: TTreeView
          Left = 80
          Top = 472
          Width = 121
          Height = 20
          Indent = 19
          TabOrder = 4
          Visible = False
        end
      end
    end
  end
  object pmnuEditor: TSpTBXPopupMenu
    Images = vilContextMenuLight
    OnPopup = pmnuEditorPopup
    Left = 112
    Top = 40
    object mnEditOpenClass: TSpTBXItem
      Caption = 'Open class'
      ImageIndex = 12
      ImageName = 'OpenClass'
      OnClick = TBClassOpenClick
    end
    object mnEditClassEditor: TSpTBXItem
      Caption = 'Class editor'
      ImageIndex = 13
      ImageName = 'ClassEdit'
      OnClick = TBClassEditClick
    end
    object mnEditCreateStructogram: TSpTBXItem
      Action = CommandsDataModule.actEditCreateStructogram
      ImageIndex = 14
      ImageName = 'CreateStructogram'
    end
    object mnEditAddImports: TSpTBXItem
      Caption = 'Add imports'
      OnClick = mnEditAddImportsClick
    end
    object mnEditCopyPathname: TSpTBXItem
      Caption = 'Copy pathname'
      OnClick = mnEditCopyPathnameClick
    end
    object mnEditConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 17
      ImageName = 'Configuration'
      OnClick = mnEditConfigurationClick
    end
    object mnEditAssistant: TSpTBXSubmenuItem
      Caption = 'Assistant'
      ImageIndex = 18
      ImageName = 'Assistant'
      LinkSubitems = CommandsDataModule.spiAssistant
    end
    object mnEditGit: TSpTBXSubmenuItem
      Caption = 'Git'
      ImageIndex = 16
      ImageName = 'git'
      OnClick = mnGitExecute
      object mnGitStatus: TSpTBXItem
        Tag = 1
        Caption = 'Status'
        OnClick = mnGitExecute
      end
      object mnGitAdd: TSpTBXItem
        Tag = 2
        Caption = 'Add'
        OnClick = mnGitExecute
      end
      object mnGitCommit: TSpTBXItem
        Tag = 3
        Caption = 'Commit'
        OnClick = mnGitExecute
      end
      object mnGitLog: TSpTBXItem
        Tag = 4
        Caption = 'Log'
        OnClick = mnGitExecute
      end
      object SpTBXSeparatorItem8: TSpTBXSeparatorItem
      end
      object mnGitReset: TSpTBXItem
        Tag = 5
        Caption = 'Reset'
        OnClick = mnGitExecute
      end
      object mnGitCheckout: TSpTBXItem
        Tag = 6
        Caption = 'Checkout'
        OnClick = mnGitExecute
      end
      object mnGitRemove: TSpTBXItem
        Tag = 7
        Caption = 'Remove'
        OnClick = mnGitExecute
      end
      object SpTBXSeparatorItem2: TSpTBXSeparatorItem
      end
      object mnGitRemote: TSpTBXItem
        Tag = 8
        Caption = 'Remote'
        OnClick = mnGitExecute
      end
      object mnGitFetch: TSpTBXItem
        Tag = 9
        Caption = 'Fetch'
        OnClick = mnGitExecute
      end
      object mnGitPush: TSpTBXItem
        Tag = 10
        Caption = 'Push'
        OnClick = mnGitExecute
      end
      object SpTBXSeparatorItem1: TSpTBXSeparatorItem
      end
      object mnGitGUI: TSpTBXItem
        Tag = 11
        Caption = 'GUI'
        OnClick = mnGitExecute
      end
      object mnGitViewer: TSpTBXItem
        Tag = 12
        Caption = 'Viewer'
        OnClick = mnGitExecute
      end
      object mnGitConsole: TSpTBXItem
        Tag = 13
        Caption = 'Console'
        OnClick = mnGitExecute
      end
    end
    object N5Sep: TSpTBXSeparatorItem
    end
    object mnEditCut: TSpTBXItem
      Action = CommandsDataModule.actEditCut
      ImageName = 'Redo'
    end
    object mnEditCopy: TSpTBXItem
      Action = CommandsDataModule.actEditCopy
      ImageName = 'APIHelp'
    end
    object mnEditPaste: TSpTBXItem
      Action = CommandsDataModule.actEditPaste
      ImageName = 'ResetJava'
    end
    object mnEditDelete: TSpTBXItem
      Action = CommandsDataModule.actEditDelete
      ImageName = 'OpenClass'
    end
    object mnEditSelectAll: TSpTBXItem
      Action = CommandsDataModule.actEditSelectAll
    end
    object mnExecuteSelection: TSpTBXItem
      Caption = 'E&xecute selection'
      Hint = 'Execute the editor selection'
      HelpContext = 320
      ImageIndex = 15
      ShortCut = 16502
    end
    object TBXSeparatorItem9: TSpTBXSeparatorItem
    end
    object mnFoldVisible: TSpTBXItem
      Action = CommandsDataModule.actFoldVisible
    end
    object mnFold: TSpTBXSubmenuItem
      Caption = 'Fold'
      object mnFoldAll: TSpTBXItem
        Action = CommandsDataModule.actFoldAll
      end
      object mnFoldNearest: TSpTBXItem
        Action = CommandsDataModule.actFoldNearest
      end
      object mnFoldRegions: TSpTBXItem
        Action = CommandsDataModule.actFoldRegions
      end
      object SpTBXSeparatorItem3: TSpTBXSeparatorItem
      end
      object mnFoldLevel1: TSpTBXItem
        Action = CommandsDataModule.actFoldLevel1
      end
      object mnFoldLevel2: TSpTBXItem
        Action = CommandsDataModule.actFoldLevel2
      end
      object mnFoldLevel3: TSpTBXItem
        Action = CommandsDataModule.actFoldLevel3
      end
      object SpTBXSeparatorItem6: TSpTBXSeparatorItem
      end
      object mnFoldClasses: TSpTBXItem
        Action = CommandsDataModule.actFoldClasses
      end
      object mnFoldFunctions: TSpTBXItem
        Action = CommandsDataModule.actFoldFunctions
      end
    end
    object mnUnfold: TSpTBXSubmenuItem
      Caption = 'Unfold'
      object mnUnfoldAll: TSpTBXItem
        Action = CommandsDataModule.actUnfoldAll
      end
      object mnUnfoldNearest: TSpTBXItem
        Action = CommandsDataModule.actUnfoldNearest
      end
      object mnUnfoldRegions: TSpTBXItem
        Action = CommandsDataModule.actUnfoldRegions
      end
      object SpTBXSeparatorItem5: TSpTBXSeparatorItem
      end
      object mnUnfoldLevel1: TSpTBXItem
        Action = CommandsDataModule.actUnfoldLevel1
      end
      object mnUnfoldLevel2: TSpTBXItem
        Action = CommandsDataModule.actUnfoldLevel2
      end
      object mnUnfoldLevel3: TSpTBXItem
        Action = CommandsDataModule.actUnfoldLevel3
      end
      object SpTBXSeparatorItem7: TSpTBXSeparatorItem
      end
      object mnUnfoldClasses: TSpTBXItem
        Action = CommandsDataModule.actUnfoldClasses
      end
      object mnUnfoldFunctions: TSpTBXItem
        Action = CommandsDataModule.actUnfoldFunctions
      end
    end
    object SpTBXSeparatorItem4: TSpTBXSeparatorItem
    end
    object mnFont: TSpTBXItem
      Caption = 'Font'
      ImageIndex = 0
      ImageName = 'Font'
      OnClick = mnFontClick
    end
    object mnMaximizeEditor2: TSpTBXItem
      Caption = '&Maximize/Restore Editor'
      Hint = 'Maximize/Restore editor window'
      HelpContext = 270
      ImageIndex = 74
      ShortCut = 32858
    end
  end
  object pmnuViewsTab: TSpTBXPopupMenu
    Left = 232
    Top = 40
    object mnUpdateView: TSpTBXItem
      Caption = 'Update View'
      Hint = 'Update View|Update the selected view'
      ImageIndex = 39
      ImageName = 'Breakpoint'
      OnClick = mnUpdateViewClick
    end
    object mnCloseTab: TSpTBXItem
      Caption = 'Close Tab'
      Hint = 'Close active tab'
      ImageIndex = 52
      ImageName = 'PageSetup'
      OnClick = mnCloseTabClick
    end
  end
  object vilGutterGlyphs: TVirtualImageList
    Images = <
      item
        CollectionIndex = 5
        CollectionName = 'EditorGutter\Executable'
        Name = 'Executable'
      end
      item
        CollectionIndex = 3
        CollectionName = 'EditorGutter\Current'
        Name = 'Current'
      end
      item
        CollectionIndex = 4
        CollectionName = 'EditorGutter\CurrentBreak'
        Name = 'CurrentBreak'
      end
      item
        CollectionIndex = 0
        CollectionName = 'EditorGutter\Break'
        Name = 'Break'
      end
      item
        CollectionIndex = 2
        CollectionName = 'EditorGutter\BreakInvalid'
        Name = 'BreakInvalid'
      end
      item
        CollectionIndex = 1
        CollectionName = 'EditorGutter\BreakDisabled'
        Name = 'BreakDisabled'
      end>
    ImageCollection = ResourcesDataModule.icGutterGlyphs
    PreserveItems = True
    Width = 11
    Height = 14
    Left = 256
    Top = 424
  end
  object vilCodeImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 8
        CollectionName = 'CodeImages\Python'
        Name = 'Python'
      end
      item
        CollectionIndex = 9
        CollectionName = 'CodeImages\Variable'
        Name = 'Variable'
      end
      item
        CollectionIndex = 1
        CollectionName = 'CodeImages\Field'
        Name = 'Field'
      end
      item
        CollectionIndex = 2
        CollectionName = 'CodeImages\Function'
        Name = 'Function'
      end
      item
        CollectionIndex = 5
        CollectionName = 'CodeImages\Method'
        Name = 'Method'
      end
      item
        CollectionIndex = 0
        CollectionName = 'CodeImages\Class'
        Name = 'Class'
      end
      item
        CollectionIndex = 7
        CollectionName = 'CodeImages\Namespace'
        Name = 'Namespace'
      end
      item
        CollectionIndex = 4
        CollectionName = 'CodeImages\List'
        Name = 'List'
      end
      item
        CollectionIndex = 6
        CollectionName = 'CodeImages\Module'
        Name = 'Module'
      end
      item
        CollectionIndex = 3
        CollectionName = 'CodeImages\Keyword'
        Name = 'Keyword'
      end>
    PreserveItems = True
    Left = 100
    Top = 417
  end
  object vilEditorToolbarLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Explorer'
        Name = 'Explorer'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Browser'
        Name = 'Browser'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Designform'
        Name = 'Designform'
      end
      item
        CollectionIndex = 4
        CollectionName = 'ClassOpen'
        Name = 'ClassOpen'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Check'
        Name = 'Check'
      end
      item
        CollectionIndex = 6
        CollectionName = 'MatchBracket'
        Name = 'MatchBracket'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Classedit'
        Name = 'Classedit'
      end
      item
        CollectionIndex = 8
        CollectionName = 'StructureIndent'
        Name = 'StructureIndent'
      end
      item
        CollectionIndex = 9
        CollectionName = 'IfStatement'
        Name = 'IfStatement'
      end
      item
        CollectionIndex = 10
        CollectionName = 'IfElseStatement'
        Name = 'IfElseStatement'
      end
      item
        CollectionIndex = 11
        CollectionName = 'WhileStatement'
        Name = 'WhileStatement'
      end
      item
        CollectionIndex = 12
        CollectionName = 'ForStatement'
        Name = 'ForStatement'
      end
      item
        CollectionIndex = 13
        CollectionName = 'SwitchStatement'
        Name = 'SwitchStatement'
      end
      item
        CollectionIndex = 14
        CollectionName = 'TryStatement'
        Name = 'TryStatement'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 17
        CollectionName = 'WordWrap'
        Name = 'WordWrap'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Indent'
        Name = 'Indent'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Unindent'
        Name = 'Unindent'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Breakpoint'
        Name = 'Breakpoint'
      end
      item
        CollectionIndex = 21
        CollectionName = 'BreakpointsClear'
        Name = 'BreakpointsClear'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Bookmark'
        Name = 'Bookmark'
      end
      item
        CollectionIndex = 23
        CollectionName = 'GotoBookmark'
        Name = 'GotoBookmark'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Paragraph'
        Name = 'Paragraph'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Numbers'
        Name = 'Numbers'
      end
      item
        CollectionIndex = 26
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 27
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Validate'
        Name = 'Validate'
      end>
    ImageCollection = DMImages.icEditorToolbar
    Left = 104
    Top = 255
  end
  object vilEditorToolbarDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 29
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Explorer'
        Name = 'Explorer'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Browser'
        Name = 'Browser'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Designform'
        Name = 'Designform'
      end
      item
        CollectionIndex = 32
        CollectionName = 'ClassOpen'
        Name = 'ClassOpen'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Check'
        Name = 'Check'
      end
      item
        CollectionIndex = 33
        CollectionName = 'MatchBracket'
        Name = 'MatchBracket'
      end
      item
        CollectionIndex = 31
        CollectionName = 'ClassEdit'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 8
        CollectionName = 'StructureIndent'
        Name = 'StructureIndent'
      end
      item
        CollectionIndex = 34
        CollectionName = 'IfStatement'
        Name = 'IfStatement'
      end
      item
        CollectionIndex = 35
        CollectionName = 'IfElseStatement'
        Name = 'IfElseStatement'
      end
      item
        CollectionIndex = 36
        CollectionName = 'WhileStatement'
        Name = 'WhileStatement'
      end
      item
        CollectionIndex = 37
        CollectionName = 'ForStatement'
        Name = 'ForStatement'
      end
      item
        CollectionIndex = 38
        CollectionName = 'SwitchStatement'
        Name = 'SwitchStatement'
      end
      item
        CollectionIndex = 39
        CollectionName = 'TryStatement'
        Name = 'TryStatement'
      end
      item
        CollectionIndex = 40
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 41
        CollectionName = 'WordWrap'
        Name = 'WordWrap'
      end
      item
        CollectionIndex = 42
        CollectionName = 'Indent'
        Name = 'Indent'
      end
      item
        CollectionIndex = 43
        CollectionName = 'Unindent'
        Name = 'Unindent'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Breakpoint'
        Name = 'Breakpoint'
      end
      item
        CollectionIndex = 21
        CollectionName = 'BreakpointsClear'
        Name = 'BreakpointsClear'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Bookmark'
        Name = 'Bookmark'
      end
      item
        CollectionIndex = 23
        CollectionName = 'GotoBookmark'
        Name = 'GotoBookmark'
      end
      item
        CollectionIndex = 44
        CollectionName = 'Paragraph'
        Name = 'Paragraph'
      end
      item
        CollectionIndex = 45
        CollectionName = 'Numbers'
        Name = 'Numbers'
      end
      item
        CollectionIndex = 46
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 47
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Validate'
        Name = 'Validate'
      end>
    ImageCollection = DMImages.icEditorToolbar
    Left = 256
    Top = 247
  end
  object vilBookmarksDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 15
        CollectionName = 'Bookmark0'
        Name = 'Bookmark0'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Bookmark1'
        Name = 'Bookmark1'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Bookmark2'
        Name = 'Bookmark2'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Bookmark3'
        Name = 'Bookmark3'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Bookmark4'
        Name = 'Bookmark4'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Bookmark5'
        Name = 'Bookmark5'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Bookmark6'
        Name = 'Bookmark6'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Bookmark7'
        Name = 'Bookmark7'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Bookmark8'
        Name = 'Bookmark8'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Bookmark9'
        Name = 'Bookmark9'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Warning'
        Name = 'Warning'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Question'
        Name = 'Question'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Debugline'
        Name = 'Debugline'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Breakpoint'
        Name = 'Breakpoint'
      end
      item
        CollectionIndex = 29
        CollectionName = 'BreakpointsDelete'
        Name = 'BreakpointsDelete'
      end>
    ImageCollection = DMImages.icEditorBookmarks
    Left = 256
    Top = 343
  end
  object vilBookmarksLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Bookmark0'
        Name = 'Bookmark0'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Bookmark1'
        Name = 'Bookmark1'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Bookmark2'
        Name = 'Bookmark2'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Bookmark3'
        Name = 'Bookmark3'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Bookmark4'
        Name = 'Bookmark4'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Bookmark5'
        Name = 'Bookmark5'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Bookmark6'
        Name = 'Bookmark6'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Bookmark7'
        Name = 'Bookmark7'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Bookmark8'
        Name = 'Bookmark8'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Bookmark9'
        Name = 'Bookmark9'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Warning'
        Name = 'Warning'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Question'
        Name = 'Question'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Debugline'
        Name = 'Debugline'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Breakpoint'
        Name = 'Breakpoint'
      end
      item
        CollectionIndex = 14
        CollectionName = 'BreakpointsDelete'
        Name = 'BreakpointsDelete'
      end>
    ImageCollection = DMImages.icEditorBookmarks
    Left = 104
    Top = 343
  end
  object vilContextMenuDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 18
        CollectionName = 'Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Cut1'
        Name = 'Cut1'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Copy1'
        Name = 'Copy1'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Paste1'
        Name = 'Paste1'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Delete1'
        Name = 'Delete1'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Indent'
        Name = 'Indent'
      end
      item
        CollectionIndex = 22
        CollectionName = 'UnIndent'
        Name = 'UnIndent'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Undo'
        Name = 'Undo'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Redo'
        Name = 'Redo'
      end
      item
        CollectionIndex = 10
        CollectionName = 'APIHelp'
        Name = 'APIHelp'
      end
      item
        CollectionIndex = 23
        CollectionName = 'ResetJava'
        Name = 'ResetJava'
      end
      item
        CollectionIndex = 24
        CollectionName = 'OpenClass'
        Name = 'OpenClass'
      end
      item
        CollectionIndex = 25
        CollectionName = 'ClassEdit'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 26
        CollectionName = 'CreateStructogram'
        Name = 'CreateStructogram'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Execute'
        Name = 'Execute'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Git'
        Name = 'Git'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end
      item
        CollectionIndex = 32
        CollectionName = 'Search'
        Name = 'Search'
      end
      item
        CollectionIndex = 35
        CollectionName = 'Assistant'
        Name = 'Assistant'
      end
      item
        CollectionIndex = 36
        CollectionName = 'Cancel'
        Name = 'Cancel'
      end>
    ImageCollection = DMImages.icEditorContextMenu
    Left = 232
    Top = 127
  end
  object vilContextMenuLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Cut1'
        Name = 'Cut1'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Copy1'
        Name = 'Copy1'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Paste1'
        Name = 'Paste1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Delete1'
        Name = 'Delete1'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Indent'
        Name = 'Indent'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Unindent'
        Name = 'Unindent'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Undo'
        Name = 'Undo'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Redo'
        Name = 'Redo'
      end
      item
        CollectionIndex = 10
        CollectionName = 'APIHelp'
        Name = 'APIHelp'
      end
      item
        CollectionIndex = 11
        CollectionName = 'ResetJava'
        Name = 'ResetJava'
      end
      item
        CollectionIndex = 12
        CollectionName = 'OpenClass'
        Name = 'OpenClass'
      end
      item
        CollectionIndex = 13
        CollectionName = 'ClassEdit'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 14
        CollectionName = 'CreateStructogram'
        Name = 'CreateStructogram'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Execute'
        Name = 'Execute'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Git'
        Name = 'Git'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Assistant'
        Name = 'Assistant'
      end
      item
        CollectionIndex = 34
        CollectionName = 'Cancel'
        Name = 'Cancel'
      end>
    ImageCollection = DMImages.icEditorContextMenu
    Left = 112
    Top = 127
  end
  object pmnuBreakpoint: TSpTBXPopupMenu
    Left = 336
    Top = 48
    object spiBreakpointEnabled: TSpTBXItem
      Caption = 'Enabled'
      Hint = 'Enable/Disable breakpoint'
      AutoCheck = True
      OnClick = spiBreakpointEnabledClick
    end
    object spiBreakpointProperties: TSpTBXItem
      Caption = 'Breakpoint Properties...'
      Hint = 'Edit breakpoint properties'
      OnClick = spiBreakpointPropertiesClick
    end
    object spiSeparatorItem: TSpTBXSeparatorItem
    end
    object spiBreakpointClear: TSpTBXItem
      Caption = 'Clear'
      Hint = 'Clear breakpoint'
      OnClick = spiBreakpointClearClick
    end
  end
  object vilEditorMarks: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Mark0'
        Name = 'Mark0'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Mark1'
        Name = 'Mark1'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Mark2'
        Name = 'Mark2'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Mark3'
        Name = 'Mark3'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Mark4'
        Name = 'Mark4'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Mark5'
        Name = 'Mark5'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Mark6'
        Name = 'Mark6'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Mark7'
        Name = 'Mark7'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Mark8'
        Name = 'Mark8'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Mark9'
        Name = 'Mark9'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Bulb'
        Name = 'Bulb'
      end>
    ImageCollection = ResourcesDataModule.icEditorMarks
    PreserveItems = True
    Width = 11
    Height = 14
    Left = 377
    Top = 256
  end
  object pmnuDiagnostics: TSpTBXPopupMenu
    Images = PyIDEMainForm.vilImages
    Left = 368
    Top = 112
    object mnFixIssue: TSpTBXItem
      Caption = 'Quick Fix Issue'
      ImageName = 'BugFix'
      OnClick = mnFixIssueClick
    end
    object mnIgnoreIssue: TSpTBXItem
      Caption = 'Ignore Issue'
      Hint = 'Flag the issue as ignored'
      OnClick = mnIgnoreIssueClick
    end
  end
end
