object EditorForm: TEditorForm
  Left = 304
  Top = 173
  BorderStyle = bsNone
  ClientHeight = 696
  ClientWidth = 582
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
    Width = 582
    Height = 696
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
      Width = 578
      Height = 692
      Align = alClient
      OnContextPopup = ViewsTabControlContextPopup
      OnEnter = FGPanelEnter
      OnExit = FGPanelExit
      ActiveTabIndex = 0
      Images = PyIDEMainForm.vilImages
      OnActiveTabChange = ViewsTabControlActiveTabChange
      HiddenItems = <>
      object tabSource: TSpTBXTabItem
        Caption = 'Source'
        Checked = True
      end
      object SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
        CustomWidth = 470
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
        Top = 30
        Width = 578
        Height = 662
        Caption = 'Source'
        ImageIndex = -1
        TabItem = 'tabSource'
        object SynEdit: TSynEdit
          Left = 25
          Top = 0
          Width = 344
          Height = 658
          HelpContext = 510
          Align = alClient
          Ctl3D = False
          ParentCtl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
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
          OnMouseWheelDown = SynEditMouseWheelDown
          OnMouseWheelUp = SynEditMouseWheelUp
          UseCodeFolding = False
          BorderStyle = bsNone
          Gutter.BorderStyle = gbsNone
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Courier New'
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
          SelectedColor.Background = clSkyBlue
          SelectedColor.Alpha = 0.400000005960464500
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
          Left = 374
          Top = 0
          Width = 200
          Height = 658
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
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
          OnMouseWheelDown = SynEditMouseWheelDown
          OnMouseWheelUp = SynEditMouseWheelUp
          UseCodeFolding = False
          BorderStyle = bsNone
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Gutter.Font.Quality = fqClearTypeNatural
          Gutter.Bands = <
            item
              Kind = gbkMarks
              Width = 13
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
              Width = 2
              Background = gbbEditor
            end>
          SelectedColor.Alpha = 0.400000005960464500
          OnMouseCursor = SynEditMouseCursor
          OnShowHint = EditorShowHint
          OnSpecialLineColors = SynEditSpecialLineColors
          OnStatusChange = SynEditStatusChange
        end
        object EditorSplitter: TSpTBXSplitter
          Left = 369
          Top = 0
          Height = 658
          Cursor = crSizeWE
          Align = alRight
          ParentColor = False
          Visible = False
          GripSize = 80
        end
        object EditformToolbar: TToolBar
          Left = 2
          Top = 0
          Width = 23
          Height = 658
          Align = alLeft
          AutoSize = True
          Images = DMImages.ILEditorToolbarDark
          TabOrder = 3
          object TBClose: TToolButton
            Left = 0
            Top = 0
            Hint = 'Close|Close active file'
            Caption = '&Close'
            ImageIndex = 0
            Wrap = True
            OnClick = TBCloseClick
          end
          object TBExplorer: TToolButton
            Left = 0
            Top = 22
            Hint = 'Open explorer for current file'
            ImageIndex = 1
            Wrap = True
            OnClick = TBExplorerClick
          end
          object TBBrowser: TToolButton
            Left = 0
            Top = 44
            Hint = 'Show in browser'
            ImageIndex = 2
            Wrap = True
            OnClick = TBBrowserClick
          end
          object TBDesignform: TToolButton
            Left = 0
            Top = 66
            Hint = 'Open associated design form'
            ImageIndex = 3
            Wrap = True
            OnClick = TBDesignformClick
          end
          object TBClassOpen: TToolButton
            Left = 0
            Top = 88
            Hint = 'Open class in the UML window'
            ImageIndex = 4
            Wrap = True
            OnClick = TBClassOpenClick
          end
          object TBCheck: TToolButton
            Left = 0
            Top = 110
            Hint = 'Check Syntax'
            ImageIndex = 5
            Wrap = True
            OnClick = TBCheckClick
          end
          object TBMatchBracket: TToolButton
            Left = 0
            Top = 132
            Hint = 'Match bracket'
            ImageIndex = 6
            Wrap = True
            OnClick = TBMatchBracketClick
          end
          object TBClassEdit: TToolButton
            Left = 0
            Top = 154
            Hint = 'Edit class'
            ImageIndex = 7
            Wrap = True
            OnClick = TBClassEditClick
          end
          object TBStructureIndent: TToolButton
            Left = 0
            Top = 176
            Hint = 'Indent structured'
            ImageIndex = 8
            Wrap = True
            OnClick = TBStructureIndentClick
          end
          object TBIfStatement: TToolButton
            Tag = 1
            Left = 0
            Top = 198
            Hint = 'If-Statement'
            ImageIndex = 9
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBIfElseStatement: TToolButton
            Tag = 9
            Left = 0
            Top = 220
            Hint = 'If-Else-Statement'
            ImageIndex = 10
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBWhileStatement: TToolButton
            Tag = 2
            Left = 0
            Top = 242
            Hint = 'while-Statement'
            ImageIndex = 11
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBForStatement: TToolButton
            Tag = 3
            Left = 0
            Top = 264
            Hint = 'for-Statement'
            ImageIndex = 12
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBIfElifStatement: TToolButton
            Tag = 5
            Left = 0
            Top = 286
            Hint = 'if-elif-Statement'
            ImageIndex = 13
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBTryStatement: TToolButton
            Tag = 6
            Left = 0
            Top = 308
            Hint = 'try-Statement'
            ImageIndex = 14
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBComment: TToolButton
            Left = 0
            Top = 330
            Hint = 'Comment on/off'
            ImageIndex = 15
            Wrap = True
            OnClick = TBCommentClick
          end
          object TBWordWrap: TToolButton
            Left = 0
            Top = 352
            Hint = 'Wordwrap'
            ImageIndex = 16
            Wrap = True
            OnClick = TBWordWrapClick
          end
          object TBIndent: TToolButton
            Left = 0
            Top = 374
            Hint = 'Indent'
            ImageIndex = 17
            Wrap = True
            OnClick = TBIndentClick
          end
          object TBUnindent: TToolButton
            Left = 0
            Top = 396
            Hint = 'Unindent'
            ImageIndex = 18
            Wrap = True
            OnClick = TBUnindentClick
          end
          object TBBreakpoint: TToolButton
            Left = 0
            Top = 418
            Hint = 'Breakpoint on/off'
            ImageIndex = 19
            Wrap = True
            OnClick = TBBreakpointClick
          end
          object TBBreakpointsClear: TToolButton
            Left = 0
            Top = 440
            Hint = 'Delete all breakpoints'
            ImageIndex = 20
            Wrap = True
            OnClick = TBBreakpointsClearClick
          end
          object TBBookmark: TToolButton
            Left = 0
            Top = 462
            Hint = 'Set bookmark'
            ImageIndex = 21
            Wrap = True
            OnClick = TBBookmarkClick
          end
          object TBGotoBookmark: TToolButton
            Left = 0
            Top = 484
            Hint = 'Goto bookmark'
            ImageIndex = 22
            Wrap = True
            OnClick = TBGotoBookmarkClick
          end
          object TBParagraph: TToolButton
            Left = 0
            Top = 506
            Hint = 'Paragraph marks on/off'
            ImageIndex = 23
            Wrap = True
            OnClick = TBParagraphClick
          end
          object TBNumbers: TToolButton
            Left = 0
            Top = 528
            Hint = 'Line numbers on/off'
            ImageIndex = 24
            Wrap = True
            OnClick = TBNumbersClick
          end
          object TBZoomPlus: TToolButton
            Left = 0
            Top = 550
            Hint = 'Zoom in'
            ImageIndex = 25
            Wrap = True
            OnClick = TBZoomPlusClick
          end
          object TBZoomMinus: TToolButton
            Left = 0
            Top = 572
            Hint = 'Zoom out'
            ImageIndex = 26
            Wrap = True
            OnClick = TBZoomMinusClick
          end
          object TBValidate: TToolButton
            Left = 0
            Top = 594
            Hint = 'Validate'
            ImageIndex = 27
            OnClick = TBValidateClick
          end
        end
        object TVFileStructure: TTreeView
          Left = 400
          Top = 3
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
    Images = PyIDEMainForm.vilImages
    OnPopup = pmnuEditorPopup
    Left = 112
    Top = 40
    object mnEditOpenClass: TSpTBXItem
      Caption = 'Open class'
      OnClick = TBClassOpenClick
    end
    object mnEditClassEditor: TSpTBXItem
      Caption = 'Class editor'
      OnClick = TBClassEditClick
    end
    object mnEditCreateStructogram: TSpTBXItem
      Action = CommandsDataModule.actEditCreateStructogram
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
      OnClick = mnEditConfigurationClick
    end
    object mnGit: TSpTBXSubmenuItem
      Caption = 'Git'
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
    object N5: TSpTBXSeparatorItem
    end
    object mnEditCut: TSpTBXItem
      Action = CommandsDataModule.actEditCut
    end
    object mnEditPaste: TSpTBXItem
      Action = CommandsDataModule.actEditPaste
    end
    object mnEditCopy: TSpTBXItem
      Action = CommandsDataModule.actEditCopy
    end
    object mnEditDelete: TSpTBXItem
      Action = CommandsDataModule.actEditDelete
    end
    object mnEditSelectAll: TSpTBXItem
      Action = CommandsDataModule.actEditSelectAll
    end
    object mnExecuteSelection: TSpTBXItem
      Action = PyIDEMainForm.actExecSelection
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
      OnClick = mnFontClick
    end
    object mnMaximizeEditor2: TSpTBXItem
      Caption = '&Maximize/Restore Editor'
      Hint = 'Maximize/Restore editor window'
      Action = PyIDEMainForm.actMaximizeEditor
    end
  end
  object pmnuViewsTab: TSpTBXPopupMenu
    Images = PyIDEMainForm.vilImages
    Left = 208
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
    Left = 200
    Top = 176
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
    ImageCollection = ResourcesDataModule.icCodeImages
    PreserveItems = True
    Left = 92
    Top = 177
  end
  object ILContextMenuLight: TImageList
    Left = 104
    Top = 360
    Bitmap = {
      494C010112006801040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B1BCF200B2BDF50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009FADF7003351F0003351F0009EACF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009FADF7003351EF003351F0003351F0003351F0009EACF7000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A0AEF7003351EF003351F000637AF300687EF3003351F0003351F0009EAC
      F7000000000000000000000000000000000084848400C6C6C600FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A0AE
      F7003351EF003351F000425EF000FCFCFE00FDFDFE00516AF1003351F0003351
      F0009EACF70000000000000000000000000084848400FFFFFF00C6C6C6000000
      00000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0ADF7003351
      EF003351F0003351F0003754EF00D5DBFB00DFE4FC003B58F0003351F0003351
      F0003351F0009EACF700000000000000000084848400C6C6C600FFFFFF000000
      0000FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1AFF7003351EF003351
      F0003351F0003351F0003351F0008799F600A9B5F9003351F000425EF000536C
      F2003351F0003351F0009EACF7000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B7C1F9003351EF003351F0003351
      F0003351F0003351F0003351F0008799F600A9B5F9003351EF00E5E8FC00FDFD
      FE00647AF3003351F0003351F000B4BFF80084848400C6C6C600FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4BFF9003351F0003351F0003351
      F0003351F0003351F0003351F0008799F600A9B5F9004E68F100FCFCFE00F6F7
      FD00576FF2003351F0003351F000B5C0F80084848400FFFFFF00C6C6C6000000
      00000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009AA9F6003351F0003351
      F0003351F0003351F0003351F0008799F600C2CBFA00E5E8FC008295F5003C58
      F0003351F0003351EF009EACF7000000000084848400C6C6C600FFFFFF000000
      0000FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009AA9F7003351
      F0003351F0003351F0003B58F000E8EBFC0000000000889AF5003351F0003351
      F0003351EF00A0ADF700000000000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009AA9
      F7003351F0003351F0005770F20000000000F7F8FE004964F1003351F0003351
      EF009FADF70000000000000000000000000084848400C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009AA9F6004D67F100E4E8FC008A9BF6004D67F1003351F0003351EF009FAD
      F700000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F0F2FD008194F5003351F0003351F0003351EF00A0AEF7000000
      00000000000000000000000000000000000084848400FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FF000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009AA9F6003351F0003351EF00A0AEF700000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B4BFF900B7C1F90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000101
      0300020203000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000051E91D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C5200009C52
      00009C5200009C5200009C5200009C5200009C5200009C5200009C5200009C52
      00009C5200009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D00000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CF8F4400EACDAC00FDFBF900FFFFFF00F2E2CF00D3995300CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D0052E91D0000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DAA86E00F9F1E900D092
      4800CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D0052E91D0052E91D00000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00D69E5D00FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00E4C09600DAA8
      6E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D0052E91D0052E91D0052E91D000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00DCAE7800F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D0052E91D0052E91D0052E91D000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00DEB37F00F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D0052E91D0052E91D00000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00D6A06000FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00DBAA7100D296
      4F00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D0052E91D0000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DBAC7400F9F1E900CE8D
      4100CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D0052E91D000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CF8F4400E7C7A200FCF8F300FFFFFF00F2E2CF00D3995300CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0052E91D00000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000052E91D0052E91D0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000DEB5
      9000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB5
      9000DEB590009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052E91D000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C5200009C52
      00009C5200009C5200009C5200009C5200009C5200009C5200009C5200009C52
      00009C5200000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEDDCE00317331000052
      000007560700538A5300E2EBE200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E4ECE40007560700005200000052
      000000520000005200001D651D00F1F5F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009BBB9B00005200001D651D00EAF0
      EA00F7F9F700276C270000520000A8C3A8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F9D6F000052000081A981000000
      0000000000006F9D6F000052000081A981000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008482
      840000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000000000008000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000780000000000000000000000000000000000000000000000000000008400
      0000FF00000000000000FFFF0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D0D0
      D000808080008080800080808000D0D0D0000000000000000000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000808080008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000780000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000008200000000000000000000FF00000084000000000000000000
      0000000000000000000000000000000000000000000000000000707070000000
      0000000000000000000000000000000000007070700000000000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000007800
      0000780000000000000000000000000000000000000000000000000000000000
      0000000000007800000000000000000000008482840084000000FF000000FF00
      0000FF00000000820000008200000000000000820000FF000000840000008482
      8400000000000000000000000000000000000000000090909000000000001010
      1000A0A0A000D0D0D000A0A0A000101010000000000090909000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000007800
      0000780000000000000000000000000000000000000000000000000000000000
      00000000000078000000000000000000000084828400FF000000FF000000FF00
      0000FF0000000082000000820000008200000082000084820000FF0000008482
      840000000000000000000000000000000000000000002020200000000000D0D0
      D000000000000000000000000000D0D0D0000000000020202000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000800000000000000000000000000000000000000000000000000000007800
      0000000000007800000000000000000000000000000000000000000000000000
      00000000000078000000000000000000000084828400FF000000FF0000000082
      0000008200000082000000820000008200000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000505050000000
      0000000000000000000000000000000000004040400000000000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000808080008000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000078000000780000000000000000000000000000000000
      00007800000000000000000000000000000084828400FF000000008200000082
      00000082000000820000008200008400000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000000000008080
      8000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007800000078000000780000007800
      00000000000000000000000000000000000084828400FF000000C6C3C6000082
      00000082000084000000008200000082000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000000000002020200000000000D0D0
      D000000000000000000000000000A0A0A0000000000000000000000000000000
      0000000000006F9D6F00005200006F9D6F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008482840084828400FF000000FFFF
      FF00C6C3C600FF000000FF000000FF0000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000090909000000000001010
      1000A0A0A000C0C0C000C0C0C00000000000A0A0A00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084828400FFFFFF00C6C3
      C600FFFFFF000082000000820000008200000082000000820000000000000000
      0000000000000000000000000000000000000000000000000000707070000000
      00000000000000000000000000000000000000000000B0B0B000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848284008482
      840084820000C6C3C60000820000008200000082000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D0D0
      D0008080800080808000808080000000000030303000F0F0F000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008482
      8400848284008482840084828400848284008482840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000030303000F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B0000000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B00007B
      7B007B7B7B00007B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B0000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B00007B
      7B007B7B7B00007B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B00007B
      7B007B7B7B00007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B00007B7B007B7B7B00007B7B007B7B7B00007B7B007B7B
      7B00007B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00007B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B00007B
      7B000000000000FFFF00000000000000000000FFFF00000000007B7B7B00007B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000084000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000008482
      8400000084008482840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000084000000000000008400000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000084000000000000008400000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000084828400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000000000008400000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000008400000084000000840000008400
      0000000000000000000084008400840084000000000000000000000000000000
      0000000084000000000084828400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000848284008400840000000000000000000000
      0000000084000000000000000000848284000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400840000000000000000008482
      8400000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840084008400840084008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400840084828400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084008400840084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FE7FFFFF00000000FC3F000100000000
      F81F000100000000F00F000100000000E007000100000000C003000100000000
      8001000100000000000000010000000000000001000000008001000100000000
      C083000100000000E107000100000000F00F000100000000F81F000100000000
      FC3F000100000000FE7FFFFF00000000FFFFE7FFFFFF8001FFFFE3FFFFFFBF7D
      8003E1FFC003BF7D8003E0FF8003BF7D8003E07F8003BF7D8003E03F8003BF7D
      8003E01F8003BF7D8003E00F8003BF7D8003E00F8003BF7D8003E01F8003BF7D
      8003E03F800380018003E07F8003BC9D8003E0FF8003A3E58003E1FF80039FF9
      8003E3FFC0078001FFFFE7FFFFFFFFFFFFFFFFFFFEFFFF81FFFFFFFFFCFFFF00
      FFFFFFFFF80FFF00FFFFFFFFF00FFF18FFFFFFFFE00FFFF8E7FFFFE7C00FE0F8
      C783C1E7801FC078CFC3C3F300078038CFC3C3F300038E38CF13C8F300019F38
      C03BDC0700009FF8E0FFFF0F00008EF8FFFFFFFF0001807FFFFFFFFF8013C03F
      FFFFFFFFC037E03FFFFFFFFFE07FFE7FFFFFFFFFFFFFFFFFFC00FFFFFEFFFEFF
      8000DFFBFFFFFFFF00008FFFC27FC27F000087F7FFFFFFFF0000C7EFC200C200
      0001E3CFFFFFFFFF0003F19FDE07DE070003F83F9E07CE070003FC7F07FF07FF
      0003F83F9E00CE000FC3F19FDE00DE000003C3CFFFFFFFFF800787E7C200C200
      F87F8FFBFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFFFFFFFFFF3FFFFFFFF3FFFFFF
      3FFFFFFFED9FFE003FE3FFFFED6FFE001FF7FFFFED6FFE003FF5F3CFF16F8000
      3FF1F99FFD1F80000CF5FC3FFC7F8000FE76FE7FFEFF8000FF60FC3FFC7F8001
      FF7FF99FFD7F8003FE3FF3CFF93F8007FF7FFFFFFBBF807FFF3FFFFFFBBF80FF
      FF9FFFFFFBBF81FFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ILContextMenuDark: TImageList
    Left = 232
    Top = 360
    Bitmap = {
      494C010112006801040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B1BCF200B2BDF50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009FADF7003351F0003351F0009EACF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009FADF7003351EF003351F0003351F0003351F0009EACF7000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A0AEF7003351EF003351F000637AF300687EF3003351F0003351F0009EAC
      F7000000000000000000000000000000000084848400C6C6C600FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A0AE
      F7003351EF003351F000425EF000FCFCFE00FDFDFE00516AF1003351F0003351
      F0009EACF70000000000000000000000000084848400FFFFFF00C6C6C6000000
      00000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0ADF7003351
      EF003351F0003351F0003754EF00D5DBFB00DFE4FC003B58F0003351F0003351
      F0003351F0009EACF700000000000000000084848400C6C6C600FFFFFF000000
      0000FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1AFF7003351EF003351
      F0003351F0003351F0003351F0008799F600A9B5F9003351F000425EF000536C
      F2003351F0003351F0009EACF7000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B7C1F9003351EF003351F0003351
      F0003351F0003351F0003351F0008799F600A9B5F9003351EF00E5E8FC00FDFD
      FE00647AF3003351F0003351F000B4BFF80084848400C6C6C600FFFFFF00C6C6
      C60000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4BFF9003351F0003351F0003351
      F0003351F0003351F0003351F0008799F600A9B5F9004E68F100FCFCFE00F6F7
      FD00576FF2003351F0003351F000B5C0F80084848400FFFFFF00C6C6C6000000
      00000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009AA9F6003351F0003351
      F0003351F0003351F0003351F0008799F600C2CBFA00E5E8FC008295F5003C58
      F0003351F0003351EF009EACF7000000000084848400C6C6C600FFFFFF000000
      0000FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009AA9F7003351
      F0003351F0003351F0003B58F000E8EBFC0000000000889AF5003351F0003351
      F0003351EF00A0ADF700000000000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF000000000000000000C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009AA9
      F7003351F0003351F0005770F20000000000F7F8FE004964F1003351F0003351
      EF009FADF70000000000000000000000000084848400C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009AA9F6004D67F100E4E8FC008A9BF6004D67F1003351F0003351EF009FAD
      F700000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F0F2FD008194F5003351F0003351F0003351EF00A0AEF7000000
      00000000000000000000000000000000000084848400FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FF000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009AA9F6003351F0003351EF00A0AEF700000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B4BFF900B7C1F90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052EF
      180052EF180052EF180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF1800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9FF9600F9FF
      9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF
      9600F9FF9600F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF18000000000000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CF8F4400EACDAC00FDFBF900F2E2CF00F2E2CF00D3995300CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180052EF1800000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DAA86E00F9F1E900D092
      4800CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180052EF180052EF18000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00D69E5D00FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00E4C09600DAA8
      6E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180052EF180052EF180052EF
      18000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00DCAE7800F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180052EF180052EF180052EF
      18000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00DEB37F00F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180052EF180052EF18000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00D6A06000FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00DBAA7100D296
      4F00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180052EF1800000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DBAC7400F9F1E900CE8D
      4100CE8C3E00F9FF9600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF180052EF180000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CF8F4400E7C7A200FCF8F300F2E2CF00F2E2CF00D3995300CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF180052EF18000000000000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180052EF1800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000DEB5
      9000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB5
      9000DEB59000F9FF9600000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000000052EF
      180052EF180052EF180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9FF9600F9FF
      9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF
      9600F9FF960000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052EF
      180052EF18000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006FE76F003ED3
      3E0045D6450091F0910000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000045D645003ED33E003ED3
      3E003ED33E003ED33E005BE05B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9FDD9003ED33E005BE05B000000
      00000000000065E365003ED33E00E6FFE6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADF6AD003ED33E00BFF9BF000000
      000000000000ADF6AD003ED33E00BFF9BF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008482
      840000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF00000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F2F
      2F007F7F7F007F7F7F007F7F7F002F2F2F000000000000000000000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000000000007272
      7200646464000000000000000000000000000000000064646400646464006464
      6400646464006464640000000000000000000000000000000000646464006464
      6400646464006464640064646400000000000000000000000000000000006464
      6400717171000000000000000000000000000000000000000000FF000000FF00
      0000FF000000008200000000000000000000FF00000084000000000000000000
      00000000000000000000000000000000000000000000000000008F8F8F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008F8F8F0000000000000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000727272006464
      6400000000000000000000000000000000000000000000000000646464007272
      7200727272006464640000000000000000000000000000000000646464007171
      7100717171006464640000000000000000000000000000000000000000000000
      0000646464007171710000000000000000008482840084000000FF000000FF00
      0000FF00000000820000008200000000000000820000FF000000840000008482
      840000000000000000000000000000000000000000006F6F6F00FFFFFF00EFEF
      EF005F5F5F002F2F2F005F5F5F00EFEFEF00FFFFFF006F6F6F00000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000727272006464
      6400000000000000000000000000000000000000000000000000646464007272
      7200727272006464640000000000000000000000000000000000646464007171
      7100717171006464640000000000000000000000000000000000000000000000
      00006464640071717100000000000000000084828400FF000000FF000000FF00
      0000FF0000000082000000820000008200000082000084820000FF0000008482
      84000000000000000000000000000000000000000000DFDFDF00FFFFFF002F2F
      2F000000000000000000000000002F2F2F00FFFFFF00DFDFDF00000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000727272006464
      6400000000000000000000000000000000006464640064646400727272000000
      0000727272006464640000000000000000000000000000000000646464007171
      7100000000007171710064646400646464000000000000000000000000000000
      00006464640071717100000000000000000084828400FF000000FF0000000082
      0000008200000082000000820000008200000000000000000000000000000000
      000000000000FFFF0000000000000000000000000000FFFFFF00AFAFAF000000
      000000000000000000000000000000000000BFBFBF00FFFFFF00000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000000000000000
      0000727272007272720072727200727272000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007171710071717100717171007171
      71000000000000000000000000000000000084828400FF000000008200000082
      00000082000000820000008200008400000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00000000000000000000FFFFFF00BFBFBF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084828400FF000000C6C3C6000082
      00000082000084000000008200000082000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00000000000000000000DFDFDF00FFFFFF002F2F
      2F000000000000000000000000005F5F5F000000000000000000000000000000
      000000000000ADF6AD003ED33E00ADF6AD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008482840084828400FF000000FFFF
      FF00C6C3C600FF000000FF000000FF0000000000000000000000000000000000
      000000000000FFFF00000000000000000000000000006F6F6F00FFFFFF00EFEF
      EF005F5F5F003F3F3F003F3F3F00FFFFFF005F5F5F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084828400FFFFFF00C6C3
      C600FFFFFF000082000000820000008200000082000000820000000000000000
      00000000000000000000000000000000000000000000000000008F8F8F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004F4F4F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848284008482
      840084820000C6C3C60000820000008200000082000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F2F
      2F007F7F7F007F7F7F007F7F7F00FFFFFF003030300000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008482
      8400848284008482840084828400848284008482840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CFCFCF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B0000000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B00007B
      7B007B7B7B00007B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B0000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000007B7B007B7B7B00007B
      7B007B7B7B00007B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000007B7B007B7B7B00007B
      7B007B7B7B00007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000007B7B7B00007B7B007B7B
      7B00007B7B007B7B7B00007B7B007B7B7B00007B7B007B7B7B00007B7B007B7B
      7B00007B7B000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00007B7B000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000007B7B007B7B7B00007B
      7B000000000000FFFF00000000000000000000FFFF00000000007B7B7B00007B
      7B007B7B7B000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFC1C100FFC1C100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFB30F00FFB30F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFC1C100FFC1C100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFB3
      0F000000000000000000FFB30F000000000000000000FFB30F00FFB30F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFC1C100FFC1C100000000000000
      000000000000000000000000000000000000000000000000000000000000E4E3
      E400B9B9FF00E4E3E40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFB3
      0F000000000000000000FFB30F0000000000FFB30F000000000000000000FFB3
      0F00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFC1C100FFC1C100FFC1C1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B9B9FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFB3
      0F000000000000000000FFB30F0000000000FFB30F000000000000000000FFB3
      0F00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF0000000000FFC1C100FFC1C100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B9B9FF0000000000E4E3E400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFB30F00FFB30F00FFB30F0000000000FFB30F000000000000000000FFB3
      0F00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFC1C100FFC1C100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B9B9FF00B9B9FF00B9B9FF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFB30F0000000000FFB30F00FFB30F00FFB30F000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF0000000000FFC1C100FFC1C100FFC1C100FFC1
      C1000000000000000000FFB5FF00FFB5FF000000000000000000000000000000
      0000B9B9FF0000000000E4E3E400000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFB30F00AFAFAF00FFB30F0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000E4E3E400FFB5FF0000000000000000000000
      0000B9B9FF0000000000FF1CFF00C7C4C7000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AFAFAF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFB5FF000000000000000000E4E3
      E400B9B9FF00B9B9FF00B9B9FF00B9B9FF000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AFAFAF00AFAFAF00AFAFAF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFB5FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AFAFAF0000000000AFAFAF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFB5FF00FFB5FF00FFB5FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000AFAFAF00AFAFAF0000000000AFAFAF00AFAFAF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFB5FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AFAFAF00000000000000000000000000AFAFAF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFB5FF00E4E3E400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AFAFAF00000000000000000000000000AFAFAF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFB5FF00FFB5FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AFAFAF00000000000000000000000000AFAFAF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FE7FFFFF00000000FC3F000100000000
      F81F000100000000F00F000100000000E007000100000000C003000100000000
      8001000100000000000000010000000000000001000000008001000100000000
      C083000100000000E107000100000000F00F000100000000F81F000100000000
      FC3F000100000000FE7FFFFF00000000FFFFFFFFFFFFFFFFFFFFE3FFFFFF8001
      8003E1FFC003BF7DBFFBE0FF8003BF7DBFFBE07F8003BF7DBFFBE03F8003BF7D
      8003E01F8003BF7DBFFBE00F8003BF7DBFFBE00F8003BF7DBFFBE01F8003BF7D
      8003E03F80038001BFFBE07F8003BC9DBFFBE0FF8003A3E5BFFBE1FF80039FF9
      8003E3FFC0078001FFFFE7FFFFFFFFFFFFFFFFFFFEFFFFC3FFFFFFFFFCFFFF81
      FFFFFFFFF80FFF18FFFFFFFFF00FFF18FFFFFFFFE00FFFF8FFFFFFFFC00FE0F8
      E783C1E7801FC078CFC3C3F300078038CFC3C3F300038E38CF13C8F300019F38
      F0FFFF0F00009FF8FFFFFFFF00008EF8FFFFFFFF0001807FFFFFFFFF8013C03F
      FFFFFFFFC037E07FFFFFFFFFE07FFEFFFFFFFFFFFFFFFFFFFC00FFFFFEFFFEFF
      8000DFFBFFFFFFFF00008FFFC27FC27F000087F7FFFFFFFF0000C7EFC200C200
      0001E3CFFFFFFFFF0003F19FDE07DE070003F83F9E07CE070003FC7F07FF07FF
      0003F83F9E00CE000FC3F19FDE00DE000003C3CFFFFFFFFF800787E7C200C200
      F87F8FFBFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFFFFFFFFFF3FFFFFFFF3FFFFFF
      3FFFFFFFED9FFE003FE3FFFFED6FFE001FF7FFFFED6FFE003FF5F3CFF16F8000
      3FF1F99FFD1F80000CF5FC3FFC7F8000FE74FE7FFEFF8000FF60FC3FFC7F8001
      FF7FF99FFD7F8003FE3FF3CFF93F8007FF7FFFFFFBBF807FFF3FFFFFFBBF80FF
      FF9FFFFFFBBF81FFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
