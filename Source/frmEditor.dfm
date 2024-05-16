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
    Images = DMImages.ILContextMenuDark
    OnPopup = pmnuEditorPopup
    Left = 112
    Top = 40
    object mnEditOpenClass: TSpTBXItem
      Caption = 'Open class'
      ImageIndex = 103
      ImageName = 'UMLOpen'
      OnClick = TBClassOpenClick
    end
    object mnEditClassEditor: TSpTBXItem
      Caption = 'Class editor'
      ImageIndex = 14
      ImageName = 'ClassEdit'
      OnClick = TBClassEditClick
    end
    object mnEditCreateStructogram: TSpTBXItem
      Action = CommandsDataModule.actEditCreateStructogram
      ImageIndex = 15
    end
    object mnEditAddImports: TSpTBXItem
      Caption = 'Add imports'
      ImageIndex = 17
      OnClick = mnEditAddImportsClick
    end
    object mnEditCopyPathname: TSpTBXItem
      Caption = 'Copy pathname'
      OnClick = mnEditCopyPathnameClick
    end
    object mnEditConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 111
      ImageName = 'Configuration'
      OnClick = mnEditConfigurationClick
    end
    object mnGit: TSpTBXSubmenuItem
      Caption = 'Git'
      ImageIndex = 16
      ImageName = 'git'
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
      ImageIndex = 2
    end
    object mnEditPaste: TSpTBXItem
      Action = CommandsDataModule.actEditPaste
      ImageIndex = 3
    end
    object mnEditCopy: TSpTBXItem
      Action = CommandsDataModule.actEditCopy
      ImageIndex = 4
    end
    object mnEditDelete: TSpTBXItem
      Action = CommandsDataModule.actEditDelete
      ImageIndex = 5
    end
    object mnEditSelectAll: TSpTBXItem
      Action = CommandsDataModule.actEditSelectAll
    end
    object mnExecuteSelection: TSpTBXItem
      Action = PyIDEMainForm.actExecSelection
      ImageIndex = 13
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
end
