object EditorForm: TEditorForm
  Left = 304
  Top = 173
  BorderStyle = bsNone
  ClientHeight = 696
  ClientWidth = 582
  Color = clWindow
  Ctl3D = False
  ParentFont = True
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
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
          Images = ILEditorToolbar
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
            ImageIndex = 5
            Wrap = True
            OnClick = TBClassOpenClick
          end
          object TBCheck: TToolButton
            Left = 0
            Top = 110
            Hint = 'Check Syntax'
            ImageIndex = 30
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
            ImageIndex = 4
            Wrap = True
            OnClick = TBClassEditClick
          end
          object TBStructureIndent: TToolButton
            Left = 0
            Top = 176
            Hint = 'Indent structured'
            ImageIndex = 8
            Wrap = True
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
            ImageIndex = 14
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBTryStatement: TToolButton
            Tag = 6
            Left = 0
            Top = 308
            Hint = 'try-Statement'
            ImageIndex = 15
            Wrap = True
            OnClick = TBStatementClick
          end
          object TBComment: TToolButton
            Left = 0
            Top = 330
            Hint = 'Comment on/off'
            ImageIndex = 17
            Wrap = True
            OnClick = TBCommentClick
          end
          object TBWordWrap: TToolButton
            Left = 0
            Top = 352
            Hint = 'Wordwrap'
            ImageIndex = 20
            Wrap = True
            OnClick = TBWordWrapClick
          end
          object TBIndent: TToolButton
            Left = 0
            Top = 374
            Hint = 'Indent'
            ImageIndex = 18
            Wrap = True
            OnClick = TBIndentClick
          end
          object TBUnindent: TToolButton
            Left = 0
            Top = 396
            Hint = 'Unindent'
            ImageIndex = 19
            Wrap = True
            OnClick = TBUnindentClick
          end
          object TBBreakpoint: TToolButton
            Left = 0
            Top = 418
            Hint = 'Breakpoint on/off'
            ImageIndex = 21
            Wrap = True
            OnClick = TBBreakpointClick
          end
          object TBBreakpointsClear: TToolButton
            Left = 0
            Top = 440
            Hint = 'Delete all breakpoints'
            ImageIndex = 22
            Wrap = True
            OnClick = TBBreakpointsClearClick
          end
          object TBBookmark: TToolButton
            Left = 0
            Top = 462
            Hint = 'Set bookmark'
            ImageIndex = 23
            Wrap = True
            OnClick = TBBookmarkClick
          end
          object TBGotoBookmark: TToolButton
            Left = 0
            Top = 484
            Hint = 'Goto bookmark'
            ImageIndex = 24
            Wrap = True
            OnClick = TBGotoBookmarkClick
          end
          object TBParagraph: TToolButton
            Left = 0
            Top = 506
            Hint = 'Paragraph marks on/off'
            ImageIndex = 25
            Wrap = True
            OnClick = TBParagraphClick
          end
          object TBNumbers: TToolButton
            Left = 0
            Top = 528
            Hint = 'Line numbers on/off'
            ImageIndex = 26
            Wrap = True
            OnClick = TBNumbersClick
          end
          object TBZoomPlus: TToolButton
            Left = 0
            Top = 550
            Hint = 'Zoom in'
            ImageIndex = 27
            Wrap = True
            OnClick = TBZoomPlusClick
          end
          object TBZoomMinus: TToolButton
            Left = 0
            Top = 572
            Hint = 'Zoom out'
            ImageIndex = 28
            Wrap = True
            OnClick = TBZoomMinusClick
          end
          object TBValidate: TToolButton
            Left = 0
            Top = 594
            Hint = 'Validate'
            ImageIndex = 29
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
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 5
        CollectionName = 'EditorGutter\Executable'
        Disabled = False
        Name = 'Executable'
      end
      item
        CollectionIndex = 3
        CollectionName = 'EditorGutter\Current'
        Disabled = False
        Name = 'Current'
      end
      item
        CollectionIndex = 4
        CollectionName = 'EditorGutter\CurrentBreak'
        Disabled = False
        Name = 'CurrentBreak'
      end
      item
        CollectionIndex = 0
        CollectionName = 'EditorGutter\Break'
        Disabled = False
        Name = 'Break'
      end
      item
        CollectionIndex = 2
        CollectionName = 'EditorGutter\BreakInvalid'
        Disabled = False
        Name = 'BreakInvalid'
      end
      item
        CollectionIndex = 1
        CollectionName = 'EditorGutter\BreakDisabled'
        Disabled = False
        Name = 'BreakDisabled'
      end>
    ImageCollection = CommandsDataModule.icGutterGlyphs
    PreserveItems = True
    Width = 11
    Height = 14
    Left = 200
    Top = 176
  end
  object vilCodeImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 8
        CollectionName = 'CodeImages\Python'
        Disabled = False
        Name = 'Python'
      end
      item
        CollectionIndex = 9
        CollectionName = 'CodeImages\Variable'
        Disabled = False
        Name = 'Variable'
      end
      item
        CollectionIndex = 1
        CollectionName = 'CodeImages\Field'
        Disabled = False
        Name = 'Field'
      end
      item
        CollectionIndex = 2
        CollectionName = 'CodeImages\Function'
        Disabled = False
        Name = 'Function'
      end
      item
        CollectionIndex = 5
        CollectionName = 'CodeImages\Method'
        Disabled = False
        Name = 'Method'
      end
      item
        CollectionIndex = 0
        CollectionName = 'CodeImages\Class'
        Disabled = False
        Name = 'Class'
      end
      item
        CollectionIndex = 7
        CollectionName = 'CodeImages\Namespace'
        Disabled = False
        Name = 'Namespace'
      end
      item
        CollectionIndex = 4
        CollectionName = 'CodeImages\List'
        Disabled = False
        Name = 'List'
      end
      item
        CollectionIndex = 6
        CollectionName = 'CodeImages\Module'
        Disabled = False
        Name = 'Module'
      end
      item
        CollectionIndex = 3
        CollectionName = 'CodeImages\Keyword'
        Disabled = False
        Name = 'Keyword'
      end>
    ImageCollection = CommandsDataModule.icCodeImages
    PreserveItems = True
    Left = 92
    Top = 177
  end
  object ILEditorToolbar: TImageList
    Left = 96
    Top = 290
    Bitmap = {
      494C01011F008400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B9B9B90087878700E9E9E9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5B5B5007979790079797900888888000000000080440000804400007C43
      0200A68A6A00AB9174007C440400804400008044000083521A00C8B9A900A080
      5B007D4301008044000080440000000000000000000000000000000000000000
      00000000000000000000EA4A1600BD711100E64D160000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B2B2
      B200797979007979790079797900B9B9B900804400008044000082511A00C7BA
      AB00E1D3C200E1D0BC00CEC2B50084552000946F4400E2DDD900CB91B500EAD0
      E000C4B4A100814D120080440000804400000000000000000000000000000000
      000000000000EA4A160038E9020021FE000063C3070000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E4E4
      E400ADADAD008E8E8E008585850091919100B3B3B300EBEBEB00B0B0B0007979
      79007979790079797900BBBBBB00000000008044000084531B00DFDAD600D5B4
      8D00BD762200BD742000D5B08600E7E4E000E8E2E400944975009C006300BE0E
      8100E0A0C900DDD5CC007C420100804400000000000000000000000000000000
      0000EA4A160043DF030021FF000022FD000024FC0000DF541500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5B5B5007A7A
      7A0079797900797979007979790079797900797979007A7A7A00797979007979
      790079797900BEBEBE000000000000000000804400007A430400DCD7D100A179
      3B00B36D1800BC721C00BC721C00C88F4D00E9DFD400BD8EA900B5007500BB00
      7A00D673B300C5B5A2007E43000080440000000000000000000000000000EA4A
      160043DF030021FF000055D005007DAB0A0021FF000074B40900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4B4B400797979008080
      8000BEBEBE00EAEAEA00F5F5F500E2E2E200AEAEAE007A7A7A00797979007979
      7900C2C2C200000000000000000000000000804400007F440000B39C8300BAA9
      88009B7C4300CC995E00BC721C00BC721C00D2A77400E1A7CC00BB007A00BB00
      7A00EAC5DD009D79510080440000804400000000000000000000EA4A160043DF
      030021FF000055D00500F4411700EA4A160027F8000024FB0000DF5415000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1E1E1007A7A7A0082828200E8E8
      E8000000000000000000000000000000000000000000D0D0D0007A7A7A007D7D
      7D00F0F0F00000000000000000000000000080440000804400008C643700E9E7
      E400D6E7D900D2E8D800DCBE9C00BE782600E4D0B900CF57A500BB007A00C323
      8B00F4F2F2007F501A00804400008044000000000000EA4A160043DF030021FF
      000055D00500F4411700000000000000000082A70A0021FF000074B409000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A70079797900CACACA000000
      0000000000000000000000000000000000000000000000000000AAAAAA007979
      7900BBBBBB000000000000000000000000007F4300008C613100D9D1C900A4DE
      B50013BF4A000FBE46009DDEB000EADFD200F1EAEC00BE0E8100BB007A00D773
      B400E4E4EC00E7E1DB00966F43007E43000000000000CE6313002BF5010055D0
      0500F4411700000000000000000000000000EA4A160027F8000024FB0000DF54
      1500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000868686007C7C7C00000000000000
      0000000000000000000000000000000000000000000000000000DCDCDC007979
      79009B9B9B00000000000000000000000000A88C6C00E0E6DF0060CF830001BB
      3C0000BB3B0007BD400086D9A000F3F3F200F4F1F200F1E4EC00F2E5ED00F6F1
      F4004A4B960056569D00E6E6EE00B8A085000000000000000000D1601300F441
      1700000000000000000000000000000000000000000082A70A0021FF000074B4
      0900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B008787870000000000B479
      3E00B4793E00B4793E00B4793E00B4793E00B4793E00B4793E00EDEDED007979
      790090909000000000000000000000000000C6B8A80070D38E0000BB3B0000BB
      3B0029C45A00C5E8CF00BBEAF200A0E6F300ADAFE1002B31BF002B31BF002B31
      C000171DB300141BB1009194D900C3AF98000000000000000000000000000000
      00000000000000000000000000000000000000000000EA4A160027F8000024FB
      0000DF5415000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000848484007D7D7D00000000000000
      0000000000000000000000000000000000000000000000000000E0E0E0007979
      79009A9A9A000000000000000000000000009F7F5A00B4E2C20000BA3B000096
      2800B0D0B600A5E6F20039D4F30052D9F300E7E8F2001D23BC00171EBA00171E
      BA00171EBA00181FBA00DDDDF300987144000000000000000000000000000000
      000000000000000000000000000000000000000000000000000082A70A0021FF
      000074B409000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A3A3A30079797900D2D2D2000000
      0000000000000000000000000000000000000000000000000000B1B1B1007979
      7900B9B9B9000000000000000000000000007F4B1100E9EAE70072BD850073AC
      7C00B6D1BA00BAEAF30038D4F30038D4F300D2F0F600ACAEE3009B9DDF009B9E
      DF009C9FE000A6A9E400F1EDE9007B4405000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EA4A160027F8
      000024FB0000DF54150000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DADADA007979790088888800F0F0
      F0000000000000000000000000000000000000000000DCDCDC007C7C7C007C7C
      7C00EEEEEE000000000000000000000000007E4300009F7F5A00AA8F7000AE91
      7000AF957800EEF2F30043D6F30038D4F3005AC5E8007BB6DD00F9F8F800B298
      7A00B2967500B3967600A17C52007F4400000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000082A7
      0A0021FF000074B4090000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00797979008787
      8700CECECE000000000000000000F2F2F200BDBDBD007D7D7D0079797900C0C0
      C000000000000000000000000000000000008044000080440000804400008044
      00007C420000D6CCC0007CE0F40038D4F3002EC3EA0056A2D500DBD1C5007C42
      0000804400008044000080440000804400000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EA4A
      160027F8000024FB0000DF541500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A9A9A9007979
      7900797979007A7A7A007F7F7F0079797900797979007A7A7A00BCBCBC000000
      0000000000000000000000000000000000008044000080440000804400008044
      000080440000AC8F6F00C5EFF70065DDF50065DDF500B6DCEF00B29778008044
      0000804400008044000080440000804400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000082A70A002BF50100B9761100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D900A2A2A200848484007B7B7B0087878700AAAAAA00E5E5E500000000000000
      0000000000000000000000000000000000000000000080440000804400008044
      00008044000086551E00DCD4CA00DDD5CB00DED6CC00DFD7CD008B5D29008044
      0000804400008044000080440000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ED471700EA4A160000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B9B9B90087878700E9E9E9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5B5B5007979790079797900888888000000000000000000000000000000
      0000808080008080800080808000808080006F6F6F0080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B2B2
      B200797979007979790079797900B9B9B9000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C0007B7B7B00020202007C7C7C00C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF010800FF00
      0800FF000800FF000800FF0008000000000000000000FF6C7000FF091000FF21
      2700FF464B00000000000000000000000000000000000000000000000000E4E4
      E400ADADAD008E8E8E008585850091919100B3B3B300EBEBEB00B0B0B0007979
      79007979790079797900BBBBBB00000000000000000000000000000000000000
      0000DFDFDF00C0C0C000808080000C0C0C00000000000C0C0C0080808000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000E2150000E215000000000000E2150000E21500000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF050C00FFB6B7000000000000000000FFABAD00FF0E1400000000000000
      0000FF676B00FF74770000000000000000000000000000000000B5B5B5007A7A
      7A0079797900797979007979790079797900797979007A7A7A00797979007979
      790079797900BEBEBE0000000000000000000000000000000000000000000000
      0000DFDFDF00808080000C0C0C009292920000000000929292000C0C0C008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E215000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF010800FFB6B7000000000000000000FF636700FF7A7D00000000000000
      0000FFC4C500FF1B2100000000000000000000000000B4B4B400797979008080
      8000BEBEBE00EAEAEA00F5F5F500E2E2E200AEAEAE007A7A7A00797979007979
      7900C2C2C2000000000000000000000000000000000000000000000000000000
      0000D1D1D1001515150092929200C0C0C00000000000C0C0C000929292001515
      1500777777000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E215000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000800FFB6B7000000000000000000FF4A4F00FF929400000000000000
      0000FFDFDF00FF0008000000000000000000E1E1E1007A7A7A0082828200E8E8
      E8000000000000000000B4793E000000000000000000D0D0D0007A7A7A007D7D
      7D00F0F0F0000000000000000000000000000000000000000000000000000000
      0000DFDFDF00B9B9B900C0C0C000C0C0C00000000000C0C0C000C0C0C000B9B9
      B900808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E215000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000800FFB6B7000000000000000000FF424700FF999B00000000000000
      0000FFE9E900FF0008000000000000000000A7A7A70079797900CACACA000000
      00000000000000000000B4793E00000000000000000000000000AAAAAA007979
      7900BBBBBB000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      000000000000E2150000E2150000E215000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000800FFB6B7000000000000000000FF5B5F00FF888B00000000000000
      0000FFD2D200FF070E000000000000000000868686007C7C7C00000000000000
      00000000000000000000B4793E00000000000000000000000000DCDCDC007979
      79009B9B9B000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000E21500000000000000000000E215000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000FF0D1400FFE0
      E000FF000800FFB8B9000000000000000000FF919300FF4E5300000000000000
      0000FF9EA000FF3D420000000000000000007B7B7B008787870000000000B479
      3E00B4793E00B4793E00B4793E00B4793E00B4793E00B4793E00EDEDED007979
      7900909090000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000E21500000000000000000000E215000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000FFB0B100FF25
      2B00FF000800FFBCBD000000000000000000FFE9E900FF313600FF737600FF98
      9A00FF000800FF9799000000000000000000848484007D7D7D00000000000000
      00000000000000000000B4793E00000000000000000000000000E0E0E0007979
      79009A9A9A000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      000000000000E2150000E2150000E2150000E2150000E2150000E21500000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF434800FFE1E10000000000000000000000000000000000FFA0A200FF7E
      8100FFB0B100000000000000000000000000A3A3A30079797900D2D2D2000000
      00000000000000000000B4793E00000000000000000000000000B1B1B1007979
      7900B9B9B9000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DADADA007979790088888800F0F0
      F0000000000000000000B4793E000000000000000000DCDCDC007C7C7C007C7C
      7C00EEEEEE000000000000000000000000000000000000000000000000000000
      0000DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00797979008787
      8700CECECE000000000000000000F2F2F200BDBDBD007D7D7D0079797900C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A9A9A9007979
      7900797979007A7A7A007F7F7F0079797900797979007A7A7A00BCBCBC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D900A2A2A200848484007B7B7B0087878700AAAAAA00E5E5E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007D76
      6A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A09900C6C4C1000000
      00000000000000000000000000000000000000000000817B7000E5E5E500C0BE
      BA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B2AFA900E5E5E500C7C5
      C10000000000000000000000000000000000817B7000E5E5E500E5E5E5008181
      E3009E9EE400A3A1B00000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B3B0AA00E5E5
      E500C7C5C1000000000000000000817B7000E5E5E500E5E5E5006F685B004343
      E1004343E1004C4CE200AEACC600000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A3A1B0009E9EE4008181E3009E9EE400A3A1B0000000
      000000000000000000000000000000000000000000000000000000000000B3B0
      AA00E5E5E500C7C5C100827C7100E5E5E500E5E5E5006F685A004343E1004343
      E1004343E1004343E1005D5DE2007E7978000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AEACC6004C4CE2004343E1004343E1004343E1004C4CE200AEAC
      C600000000000000000000000000000000000000000000000000000000000000
      0000B3B0AA00E5E5E500E5E5E500E5E5E5006E6759004343E1004343E1004343
      E1004343E1004343E1004343E1009B97AA000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007E7978005D5DE2004343E1004343E1004343E1004343E1004343E1005D5D
      E2007E7978000000000000000000000000000000000000000000000000000000
      0000817B7000E5E5E500E5E5E500CAC8C500625A4B004343E1004343E1004343
      E1004343E1004343E1004343E1009B97AA000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00009B97AA004343E1004343E1004343E1004343E1004343E1004343E1004343
      E1009B97AA00000000000000000000000000000000000000000000000000817B
      7000E5E5E500E5E5E500B5B2AD00E5E5E500C5C4C0004343E1004343E1004343
      E1004343E1004343E1005D5DE2007E7978000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000008000000000000000000000000000000000000000000000000000
      00009B97AA004343E1004343E1004343E1004343E1004343E1004343E1004343
      E1009B97AA000000000000000000000000000000000000000000817B7000E5E5
      E500E5E5E50070695C008181E300B2AFA900E5E5E500BFBCB8004343E1004343
      E1004343E1004C4CE200AEACC600000000000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000008000000000000000000000000000000000000000000000000000
      00007E7978005D5DE2004343E1004343E1004343E1004343E1004343E1005D5D
      E2007E79780000000000000000000000000000000000817B7000E5E5E500E5E5
      E5004C4CE2004343E1004343E1004343E100B3B0AA00E5E5E500A19D95008181
      E3009E9EE400A3A1B00000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      000000000000AEACC6004C4CE2004343E1004343E1004343E1004C4CE200AEAC
      C60000000000000000000000000000000000817B7000E5E5E500E5E5E5007069
      5F004343E1004343E1004343E1004343E1004343E1008E897F00C8C6C3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      00000000000000000000A3A1B0009E9EE4008181E3009E9EE400A3A1B0000000
      0000000000000000000000000000000000009A968D00E5E5E5009B97AA004343
      E1004343E1004343E1004343E1004343E1004343E1004343E1009B97AA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B97AA004343
      E1004343E1004343E1004343E1004343E1004343E1004343E1009B97AA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E7978005D5D
      E2004343E1004343E1004343E1004343E1004343E1005D5DE2007E7978000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AEAC
      C6004C4CE2004343E1004343E1004343E1004C4CE200AEACC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3A1B0009E9EE4008181E3009E9EE400A3A1B00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E21500000000000000000000E215000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E21500000000000000000000E215000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E21500000000000000000000E215000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2150000E2150000E2150000E2150000E2150000E2150000E2150000E215
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E21500000000000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E21500000000000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2150000E2150000E2150000E2150000E2150000E2150000E2150000E215
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E21500000000000000000000E2150000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E21500000000000000000000E21500000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E21500000000000000000000E21500000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E21500000000000000000000E21500000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001B001F001A00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001000100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001000100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B000E000F00120000000000000000000000000000000000000000000000
      00001A001F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001000100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001700
      1B0018001D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000037003F00000000002300
      28000000000025002B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000E001000110014000D000F00000000001F00
      2400000000001C00210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000021062C00000000000000000000000000000000000000
      000022062D0017041E0000000000000000000000000000000000000000001900
      1D00000000000F000F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000110317001303
      1900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000180420000000000000000000000000000601080000000000000000001101
      140009010C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF1900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF1900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF19000CFF
      FF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF19000CFF
      FF00FF9400000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF19000CFF
      FF00FF940000FF9400007363FF007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF9400007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF940000FF940000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF940000FF940000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF9400007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF19000CFF
      FF00FF940000FF9400007363FF007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF00000000000000000000000000000000000000
      0000000000000000000021062C00000000000000000000000000000000000000
      000022062D0017041E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF19000CFF
      FF00FF9400000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF00000000000000000000000000000000000000
      0000000000000000000000000000060108000000000000000000110317001303
      1900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF19000CFF
      FF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF00000000000000000000000000000000000000
      0000180420000000000000000000000000000000000000000000000000001101
      140009010C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF1900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF1900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C5200009C52
      00009C5200009C5200009C5200009C5200009C5200009C5200009C5200009C52
      00009C5200009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009F9F9F000000000000000000000000000000000000000000808080009F9F
      9F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000000000009F9F9F00000000000000000000000000000000009F9F9F000000
      00009F9F9F000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CF8F4400EACDAC00FDFBF900F9F1E900F2E2CF00D3995300CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      FF0000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DAA86E00F9F1E900D092
      4800CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00D69E5D00FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00E4C09600DAA8
      6E00CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00DCAE7800F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000009F9F9F000000
      00009F9F9F000000000000000000000000000000000000000000000000009F9F
      9F00000000009F9F9F0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00DEB37F00F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000009F9F
      9F00000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00D6A06000FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00DBAA7100D296
      4F00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00009F9F9F000000000000000000000000000000000000000000000000009F9F
      9F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DBAC7400F9F1E900CE8D
      4100CE8C3E009C52000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CF8F4400E7C7A200FCF8F300F9F1E900F2E2CF00D3995300CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008080
      8000000000009F9F9F00000000000000000000000000000000009F9F9F000000
      0000808080000000000000000000000000000000000000000000000000008400
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C520000DEB59000DEB5
      9000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB5
      9000DEB590009C52000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00009F9F9F000000000000000000000000000000000000000000000000009F9F
      9F00000000000000000000000000000000000000000000000000000000008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C5200009C52
      00009C5200009C5200009C5200009C5200009C5200009C5200009C5200009C52
      00009C5200000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009098
      9800585858005858600000000000000000000000000000000000000000007B00
      00007B0000007B000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808800505050004048
      4800404848004048480040484800404848004048480040484800585858008878
      98006080A80040484800A8B8B8000000000000000000000000007B000000FF00
      0000FF0000007B000000BDBDBD00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00BDBDBD00000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000070A0B8001880B0001880B0001878
      B0001078A8001078A8001078A8000870A0000870A000387898008880A0004888
      D8003098D800384040008890900000000000000000007B000000FF000000FF00
      0000FF000000FF000000BDBDBD00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF00BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001880B00040A8D000D0FFFF0078D0
      FF0068D0FF0068D0FF0068D0FF0068D0FF0078C8E8009088A8004888D80050B8
      FF000870A00020485800606068000000000000000000FF000000007B0000FF00
      0000FF000000FF000000BDBDBD00FFFFFF0000FFFF007B0000007B0000007B00
      0000BDBDBD00FFFFFF00BDBDBD00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002088B8002888C000D0FFFF00A8E8
      FF0090C0D800C8C8C000C0C0B000A8B8B80090A0B0005890D00050B8FF0070D8
      FF001078A8000858800040484800000000007B7B7B00007B0000FF000000FF00
      0000FF000000BDBDBD00BDBDBD00FFFFFF007B7B0000FF000000FF000000FF00
      00007B000000FFFFFF00BDBDBD00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002888C0002890C00080C8F000C8C0
      C800F0E8E000FFFFE800FFFFD800FFF0C000D8B0980090C0D80078E0FF0080E8
      FF003098C8001880B00038404000909098007B7B7B007B7B0000BDBDBD00FF00
      00007B7B00007B7B0000BDBDBD00FFFFFF007B7B0000BDBDBD00007B0000FF00
      00007B000000FFFFFF00BDBDBD00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002888C00048B0E0003898D000D8C8
      B000FFFFFF00FFFFFF00FFFFE000FFF0C000FFE8B000B0C8C80090F0FF0090F0
      FF0050B8E8001078A80028405000585860007B7B7B007B7B0000BDBDBD00FFFF
      FF00BDBDBD00007B0000BDBDBD00FFFFFF007B7B0000FFFFFF00BDBDBD00007B
      00007B000000FFFFFF00BDBDBD00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002890C00068D0FF002088B800E0D0
      B000FFFFE000FFFFE800FFFFD800FFE8B800FFE8B800D8D0B80098FFFF0098FF
      FF0060C0FF0040A8D00010587800384040007B7B7B00BDBDBD00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00BDBDBD00FFFFFF0000FFFF007B7B00007B7B00007B7B
      0000BDBDBD00FFFFFF00BDBDBD00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002890C00078E0FF0040A8D000D8C0
      A000FFF0D000FFFFC800FFF0C000FFE8B800FFF0D000E8C8C000FFFFFF00FFFF
      FF0078E0FF0078D8E80000609000404848007B7B7B00FFFFFF00FFFFFF00FFFF
      FF00FF000000007B0000BDBDBD00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003090C80080E8FF0068D0FF008088
      9000FFE8B000FFE8B000FFF0C000FFFFE800E8D8D0005088B0002088B8002080
      B8001880B0001880B00000689800A8B8B8007B7B7B00BDBDBD00FFFFFF00BDBD
      BD00FFFFFF00FF000000BDBDBD00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF00BDBDBD00FFFFFF007B7B7B00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003098C80090F0FF0090F0FF0090E8
      F000B0B8B800E0C8A800E0C8A800D8C0B800E8D8D000FFFFFF00FFFFFF00FFFF
      FF001078A800585858000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00007B0000007B0000BDBDBD00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00BDBDBD007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003098C800FFFFFF0098FFFF0098FF
      FF0098FFFF0098FFFF00FFFFFF002088B8002080B8001880B0001880B0001880
      B0001878B000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD007B7B0000007B00007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003098C800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002888C000A0A8A8000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00FF000000007B0000FF000000007B0000007B0000FF00
      00007B0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003098C8003098
      C8003090C8002890C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B00BDBDBD00FFFFFF00FF0000007B7B00007B7B0000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00FFF8FFFFFFFF0000FFF08001FC7F0000
      FFE00000F87F0000E0010000F03F0000C0030000E03F000080070000C01F0000
      0F870000831F00001FC70000870F00003FC70000CF8F000020070000FF870000
      3FC70000FFC700001FC70000FFC300000F870000FFE30000860F0000FFE10000
      C01F0000FFF10000E03F8001FFF30000FFFFFFFFFFFFFFF8FFFFFFFFFFFFFFF0
      F007FFFFFFFFFFE0F007FFFFC187E001F007FC9FF333C003F007FEBFF3338007
      F007FEBFF3330D87F007FEBFF3331DC7F007F8BFF3333DC7F007F6BFC3332007
      F007F6BFC3033DC7F007F81FF3C71DC7F007FFFFFFFF0D87F007FFFFFFFF860F
      FFFFFFFFFFFFC01FFFFFFFFFFFFFE03FFFFFFFFFFFEFFFFFFFFFFFFF9F8FFFFF
      FFFFFFFF8F03F007FFFFFFFFC601F00781FFFC1FE000F007FFDFF80FF000F007
      879FF007F000F007FF07F007E000F007879BF007C001F007FFDBF0078003F007
      81FBF80F001FF007FFFBFC1F001FF007FC07FFFFC01FF007FFFFFFFFC01FF007
      FFFFFFFFE03FFFFFFFFFFFFFF07FFFFFFFFFFFFFFFFFFFFF8001FFFFFEFFFEFF
      BFFDFFFFFFFFFFFFBFFDFB7FC27FC27FBFFDFB7FFFFFFFFFBFFDFB7FC200C200
      BFFDF00FFFFFFFFFBFFDFDBFDE07DE07BFFDFDBFCE079E07BFFDF00F07FF07FF
      BFFDFDBFCE009E00BFFDFEDFDE00DE00BFFDFEDFFFFFFFFFBFFDFEDFC200C200
      8001FFFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFFFFFFFFFF8001800180018001
      B7FDBFFDBBDDBFFDB7BDBFFDBBDDBFCDB7BDB001BBDDBFF5B7BDB7FDBBDDB2F5
      B7BDB7FDBBDDB6E5B7FDB7FDBBDDB6A9B7BDB7FDBBDDB629B7FDB7FDBBDDB7FD
      B7FDB7FD8001A3FDB001B7FDBB0DB7FDBFFDB7FDB061BFFDBFFDB7FD87F9BFFD
      8001800180018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001800180018001
      8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD
      8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD
      800180018001B7FD8001BE0DBC9DB0018001B0E1BFFDBFFD800187F99FF9BFFD
      8001800180018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF807
      C0038003F18FF80780038003E3C7F80780038003E7E7F80780038003E7E7F807
      80038003E7E7F80780038003C7E3F80780038003CFF3F80780038003E7E7F80F
      80038003E7E7E81F80038003E7E7E7FF80038003E3C7E3FF80038003F18FE7FF
      C0078003FFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF800FFFFFFFFFFE3E000C7E3
      FFFF8001C000C003FFFF00018000C7E3FFFF00018000EFF7F3CF00010000EFF7
      F99F00000000EFF7FC3F00000000EFF7FE7F00000000EFF7FC3F00000000EFF7
      F99F00000001EFF7F3CF00038003C7E3FFFF00078003C003FFFF80FFC007C7E3
      FFFFC3FFE00FFFFFFFFFFFFFF83FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ILEditorToolbarDark: TImageList
    Left = 232
    Top = 290
    Bitmap = {
      494C01011F003000040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000AFAFAF00535353000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000083838300BDBDBD00BDBDBD00B1B1B1000000000080440000804400007C43
      0200A68A6A00AB9174007C440400804400008044000083521A00C8B9A900A080
      5B007D4301008044000080440000000000000000000000000000000000000000
      00000000000000000000EA4A1600BD711100E64D160000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008787
      8700BDBDBD00BDBDBD00BDBDBD0080808000804400008044000082511A00C7BA
      AB00E1D3C200E1D0BC00CEC2B50084552000946F4400E2DDD900CB91B500EAD0
      E000C4B4A100814D120080440000804400000000000000000000000000000000
      000000000000EA4A160038E9020021FE000063C3070000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005959
      59008B8B8B00A9A9A900B3B3B300A7A7A70087878700525252008A8A8A00BDBD
      BD00BDBDBD00BDBDBD007F7F7F00000000008044000084531B00DFDAD600D5B4
      8D00BD762200BD742000D5B08600E7E4E000E8E2E400944975009C006300BE0E
      8100E0A0C900DDD5CC007C420100804400000000000000000000000000000000
      0000EA4A160043DF030021FF000022FD000024FC0000DF541500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD007D7D7D000000000000000000804400007A430400DCD7D100A179
      3B00B36D1800BC721C00BC721C00C88F4D00E9DFD400BD8EA900B5007500BB00
      7A00D673B300C5B5A2007E43000080440000000000000000000000000000EA4A
      160043DF030021FF000055D005007DAB0A0021FF000074B40900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000086868600BDBDBD00B8B8
      B8007D7D7D0053535300000000005A5A5A008D8D8D00BDBDBD00BDBDBD00BDBD
      BD007A7A7A00000000000000000000000000804400007F440000B39C8300BAA9
      88009B7C4300CC995E00BC721C00BC721C00D2A77400E1A7CC00BB007A00BB00
      7A00EAC5DD009D79510080440000804400000000000000000000EA4A160043DF
      030021FF000055D00500F4411700EA4A160027F8000024FB0000DF5415000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D5D5D00BDBDBD00B5B5B5005555
      550000000000000000000000000000000000000000006D6D6D00BDBDBD00BBBB
      BB000000000000000000000000000000000080440000804400008C643700E9E7
      E400D6E7D900D2E8D800DCBE9C00BE782600E4D0B900CF57A500BB007A00C323
      8B00F4F2F2007F501A00804400008044000000000000EA4A160043DF030021FF
      000055D00500F4411700000000000000000082A70A0021FF000074B409000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000091919100BDBDBD00717171000000
      000000000000000000000000000000000000000000000000000090909000BDBD
      BD007F7F7F000000000000000000000000007F4300008C613100D9D1C900A4DE
      B50013BF4A000FBE46009DDEB000EADFD200F1EAEC00BE0E8100BB007A00D773
      B400E4E4EC00E7E1DB00966F43007E43000000000000CE6313002BF5010055D0
      0500F4411700000000000000000000000000EA4A160027F8000024FB0000DF54
      1500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1B1B100BBBBBB00000000000000
      000000000000000000000000000000000000000000000000000060606000BDBD
      BD009D9D9D00000000000000000000000000A88C6C00E0E6DF0060CF830001BB
      3C0000BB3B0007BD400086D9A000F3F3F200F4F1F200F1E4EC00F2E5ED00F6F1
      F4004A4B960056569D00E6E6EE00B8A085000000000000000000D1601300F441
      1700000000000000000000000000000000000000000082A70A0021FF000074B4
      0900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BCBCBC00AFAFAF0000000000F4B9
      7E00F4B97E00F4B97E00F4B97E00F4B97E00F4B97E00F4B97E0050505000BDBD
      BD00A8A8A800000000000000000000000000C6B8A80070D38E0000BB3B0000BB
      3B0029C45A00C5E8CF00BBEAF200A0E6F300ADAFE1002B31BF002B31BF002B31
      C000171DB300141BB1009194D900C3AF98000000000000000000000000000000
      00000000000000000000000000000000000000000000EA4A160027F8000024FB
      0000DF5415000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B3B3B300B9B9B900000000000000
      00000000000000000000000000000000000000000000000000005D5D5D00BDBD
      BD009E9E9E000000000000000000000000009F7F5A00B4E2C20000BA3B000096
      2800B0D0B600A5E6F20039D4F30052D9F300E7E8F2001D23BC00171EBA00171E
      BA00171EBA00181FBA00DDDDF300987144000000000000000000000000000000
      000000000000000000000000000000000000000000000000000082A70A0021FF
      000074B409000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000095959500BDBDBD006A6A6A000000
      000000000000000000000000000000000000000000000000000087878700BDBD
      BD00808080000000000000000000000000007F4B1100E9EAE70072BD850073AC
      7C00B6D1BA00BAEAF30038D4F30038D4F300D2F0F600ACAEE3009B9DDF009B9E
      DF009C9FE000A6A9E400F1EDE9007B4405000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EA4A160027F8
      000024FB0000DF54150000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000061616100BDBDBD00B1B1B1000000
      0000000000000000000000000000000000000000000060606000BCBCBC00BBBB
      BB00505050000000000000000000000000007E4300009F7F5A00AA8F7000AE91
      7000AF957800EEF2F30043D6F30038D4F3005AC5E8007BB6DD00F9F8F800B298
      7A00B2967500B3967600A17C52007F4400000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000082A7
      0A0021FF000074B4090000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000090909000BDBDBD00B1B1
      B1006E6E6E000000000000000000000000007D7D7D00B9B9B900BDBDBD007A7A
      7A00000000000000000000000000000000008044000080440000804400008044
      00007C420000D6CCC0007CE0F40038D4F3002EC3EA0056A2D500DBD1C5007C42
      0000804400008044000080440000804400000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EA4A
      160027F8000024FB0000DF541500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090909000BDBD
      BD00BDBDBD00BCBCBC00B8B8B800BDBDBD00BDBDBD00BCBCBC007E7E7E000000
      0000000000000000000000000000000000008044000080440000804400008044
      000080440000AC8F6F00C5EFF70065DDF50065DDF500B6DCEF00B29778008044
      0000804400008044000080440000804400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000082A70A002BF50100B9761100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      630097979700B5B5B500BCBCBC00AFAFAF009090900059595900000000000000
      0000000000000000000000000000000000000000000080440000804400008044
      00008044000086551E00DCD4CA00DDD5CB00DED6CC00DFD7CD008B5D29008044
      0000804400008044000080440000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ED471700EA4A160000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000AFAFAF00535353000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000083838300BDBDBD00BDBDBD00B1B1B1000000000000000000000000000000
      0000808080008080800080808000808080006F6F6F0080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008787
      8700BDBDBD00BDBDBD00BDBDBD00808080000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C0007B7B7B00020202007C7C7C00C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F8FF9400F9FF
      9600F9FF9600F9FF9600F9FF96000000000000000000FBFFC200F9FF9900F9FF
      A300FAFFB2000000000000000000000000000000000000000000000000005959
      59008B8B8B00A9A9A900B3B3B300A7A7A70087878700525252008A8A8A00BDBD
      BD00BDBDBD00BDBDBD007F7F7F00000000000000000000000000000000000000
      0000DFDFDF00C0C0C000808080000C0C0C00000000000C0C0C0080808000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000F9FF9600F9FF960000000000F9FF9600F9FF96000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8FF9700FDFFE0000000000000000000FCFFDB00F8FF9B00000000000000
      0000FAFFBF00FBFFC5000000000000000000000000000000000084848400BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD007D7D7D0000000000000000000000000000000000000000000000
      0000DFDFDF00808080000C0C0C009292920000000000929292000C0C0C008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F9FF960000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8FF9500FDFFE0000000000000000000FBFFBE00FBFFC700000000000000
      0000FCFFE600F8FFA00000000000000000000000000086868600BDBDBD00B8B8
      B8007D7D7D0053535300494949005A5A5A008D8D8D00BDBDBD00BDBDBD00BDBD
      BD007A7A7A000000000000000000000000000000000000000000000000000000
      0000D1D1D1001515150092929200C0C0C00000000000C0C0C000929292001515
      1500777777000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F9FF960000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9FF9600FDFFE0000000000000000000F9FFB300FBFFD100000000000000
      0000FDFFF100F9FF960000000000000000005D5D5D00BDBDBD00B5B5B5005555
      55000000000000000000F4B97E0000000000000000006D6D6D00BDBDBD00BBBB
      BB00000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00B9B9B900C0C0C000C0C0C00000000000C0C0C000C0C0C000B9B9
      B900808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F9FF960000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9FF9600FDFFE0000000000000000000FAFFB000FBFFD500000000000000
      0000FFFFF500F9FF9600000000000000000091919100BDBDBD00717171000000
      00000000000000000000F4B97E0000000000000000000000000090909000BDBD
      BD007F7F7F000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      000000000000F9FF9600F9FF9600F9FF960000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9FF9600FDFFE0000000000000000000FAFFBA00FBFFCE00000000000000
      0000FDFFEB00F8FF98000000000000000000B1B1B100BBBBBB00000000000000
      00000000000000000000F4B97E0000000000000000000000000060606000BDBD
      BD009D9D9D000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000F9FF96000000000000000000F9FF960000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000F9FF9B000000
      0000F9FF9600FDFFE1000000000000000000FBFFD000F9FFB500000000000000
      0000FCFFD600F9FFAE000000000000000000BCBCBC00AFAFAF0000000000F4B9
      7E00F4B97E00F4B97E00F4B97E00F4B97E00F4B97E00F4B97E0050505000BDBD
      BD00A8A8A8000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000F9FF96000000000000000000F9FF960000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000FCFFDE00F9FF
      A400F9FF9600FCFFE200000000000000000000000000F9FFA900FBFFC400FBFF
      D300F9FF9600FCFFD3000000000000000000B3B3B300B9B9B900000000000000
      00000000000000000000F4B97E000000000000000000000000005D5D5D00BDBD
      BD009E9E9E000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      000000000000F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF96000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9FFB1000000000000000000000000000000000000000000FBFFD700FBFF
      C900FCFFDD0000000000000000000000000095959500BDBDBD006A6A6A000000
      00000000000000000000F4B97E0000000000000000000000000087878700BDBD
      BD00808080000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000061616100BDBDBD00B1B1B1000000
      00000000000000000000F4B97E00000000000000000060606000BCBCBC00BBBB
      BB00505050000000000000000000000000000000000000000000000000000000
      0000DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000090909000BDBDBD00B1B1
      B1006E6E6E000000000000000000000000007D7D7D00B9B9B900BDBDBD007A7A
      7A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090909000BDBD
      BD00BDBDBD00BCBCBC00B8B8B800BDBDBD00BDBDBD00BCBCBC007E7E7E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      630097979700B5B5B500BCBCBC00AFAFAF009090900059595900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007D76
      6A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A09900C6C4C1000000
      00000000000000000000000000000000000000000000817B7000E5E5E500C0BE
      BA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B2AFA900E5E5E500C7C5
      C10000000000000000000000000000000000817B7000E5E5E500E5E5E5008181
      E3009E9EE400A3A1B00000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B3B0AA00E5E5
      E500C7C5C1000000000000000000817B7000E5E5E500E5E5E5006F685B004343
      E1004343E1004C4CE200AEACC600000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0008080800000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A3A1B0009E9EE4008181E3009E9EE400A3A1B0000000
      000000000000000000000000000000000000000000000000000000000000B3B0
      AA00E5E5E500C7C5C100827C7100E5E5E500E5E5E5006F685A004343E1004343
      E1004343E1004343E1005D5DE2007E7978000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AEACC6004C4CE2004343E1004343E1004343E1004C4CE200AEAC
      C600000000000000000000000000000000000000000000000000000000000000
      0000B3B0AA00E5E5E500E5E5E500E5E5E5006E6759004343E1004343E1004343
      E1004343E1004343E1004343E1009B97AA000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C0008080800000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007E7978005D5DE2004343E1004343E1004343E1004343E1004343E1005D5D
      E2007E7978000000000000000000000000000000000000000000000000000000
      0000817B7000E5E5E500E5E5E500CAC8C500625A4B004343E1004343E1004343
      E1004343E1004343E1004343E1009B97AA000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00009B97AA004343E1004343E1004343E1004343E1004343E1004343E1004343
      E1009B97AA00000000000000000000000000000000000000000000000000817B
      7000E5E5E500E5E5E500B5B2AD00E5E5E500C5C4C0004343E1004343E1004343
      E1004343E1004343E1005D5DE2007E7978000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C0008080800000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00009B97AA004343E1004343E1004343E1004343E1004343E1004343E1004343
      E1009B97AA000000000000000000000000000000000000000000817B7000E5E5
      E500E5E5E50070695C008181E300B2AFA900E5E5E500BFBCB8004343E1004343
      E1004343E1004C4CE200AEACC600000000000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00007E7978005D5DE2004343E1004343E1004343E1004343E1004343E1005D5D
      E2007E79780000000000000000000000000000000000817B7000E5E5E500E5E5
      E5004C4CE2004343E1004343E1004343E100B3B0AA00E5E5E500A19D95008181
      E3009E9EE400A3A1B00000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C0008080800000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000AEACC6004C4CE2004343E1004343E1004343E1004C4CE200AEAC
      C60000000000000000000000000000000000817B7000E5E5E500E5E5E5007069
      5F004343E1004343E1004343E1004343E1004343E1008E897F00C8C6C3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C00000000000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000A3A1B0009E9EE4008181E3009E9EE400A3A1B0000000
      0000000000000000000000000000000000009A968D00E5E5E5009B97AA004343
      E1004343E1004343E1004343E1004343E1004343E1004343E1009B97AA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B97AA004343
      E1004343E1004343E1004343E1004343E1004343E1004343E1009B97AA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E7978005D5D
      E2004343E1004343E1004343E1004343E1004343E1005D5DE2007E7978000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AEAC
      C6004C4CE2004343E1004343E1004343E1004C4CE200AEACC600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3A1B0009E9EE4008181E3009E9EE400A3A1B00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000F9FF96000000000000000000F9FF960000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000F9FF96000000000000000000F9FF960000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000F9FF96000000000000000000F9FF960000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF
      9600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000F9FF96000000000000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000F9FF96000000000000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF
      960000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000F9FF96000000000000000000F9FF9600000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000F9FF96000000000000000000F9FF96000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000F9FF96000000000000000000F9FF96000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000F9FF96000000000000000000F9FF96000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
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
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000E4FFE000E5FF
      E0000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000F4FFF100F0FFED0000000000FFFFFF000000000000000000000000000000
      0000E5FFE00000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000E8FF
      E400E7FFE20000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF0000000000C8FFC00000000000DCFF
      D70000000000DAFFD400FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000F1FFEF00EEFFEB00F2FFF00000000000E0FF
      DB0000000000E3FFDE00FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF0000000000E6FF
      E200FFFFFF00F0FFF00000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
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
      0000000000000000000000000000000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF19000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF19000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF19000CFF
      FF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF19000CFF
      FF00FF9400000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF19000CFF
      FF00FF940000FF9400007363FF007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF9400007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF940000FF940000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF940000FF940000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000000000000000FF940000FF940000FF94
      0000FF940000FF940000FF9400007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF19000CFF
      FF00FF940000FF9400007363FF007363FF007363FF007363FF007363FF007363
      FF007363FF007363FF007363FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF19000CFF
      FF00FF9400000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000034FF190034FF19000CFF
      FF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFFFF000CFF
      FF000CFFFF000CFFFF000CFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF19000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000034FF190034FF190034FF
      190034FF190034FF190034FF190034FF190034FF190034FF190034FF190034FF
      190034FF190034FF190034FF19000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000F9FF9600F9FF
      9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF
      9600F9FF9600F9FF9600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000086868600FFFFFF00FFFFFF000000000000000000FFFFFF00A4A4A4008686
      8600000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000A4A4
      A400FFFFFF00868686000000000000000000000000000000000086868600FFFF
      FF00868686000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CF8F4400EACDAC00FDFBF900F2E2CF00F2E2CF00D3995300CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFF000000000000000000000000000000000000FFFF
      0000FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DAA86E00F9F1E900D092
      4800CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00D69E5D00FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00E4C09600DAA8
      6E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00DCAE7800F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000086868600FFFF
      FF00868686000000000000000000000000000000000000000000000000008686
      8600FFFFFF008686860000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00DEB37F00F3E4D200CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000A4A4A400FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00D6A06000FDFBF900D0924800CE8C3E00CE8C3E00CE8C3E00DBAA7100D296
      4F00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00868686000000000000000000000000000000000000000000000000008686
      8600FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00EFDBC300EBD2B400D0914700CE8C3E00DBAC7400F9F1E900CE8D
      4100CE8C3E00F9FF9600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CF8F4400E7C7A200FCF8F300F2E2CF00F2E2CF00D3995300CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000CE8C
      3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C3E00CE8C
      3E00CE8C3E00F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000A4A4
      A400FFFFFF00868686000000000000000000000000000000000086868600FFFF
      FF00A4A4A4000000000000000000000000000000000000000000000000007BFF
      FF007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9FF9600DEB59000DEB5
      9000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB59000DEB5
      9000DEB59000F9FF9600000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000086868600FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF008686
      8600000000000000000000000000000000000000000000000000000000007B7B
      7B007BFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9FF9600F9FF
      9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF9600F9FF
      9600F9FF960000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BFF
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
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009098
      9800585858005858600000000000000000000000000000000000000000007B00
      00007B0000007B000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808800505050004048
      4800404848004048480040484800404848004048480040484800585858008878
      98006080A80040484800A8B8B8000000000000000000000000007B000000FF00
      0000FF0000007B000000BDBDBD00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00BDBDBD00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000070A0B8001880B0001880B0001878
      B0001078A8001078A8001078A8000870A0000870A000387898008880A0004888
      D8003098D800384040008890900000000000000000007B000000FF000000FF00
      0000FF000000FF000000BDBDBD00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF00BDBDBD00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001880B00040A8D000D0FFFF0078D0
      FF0068D0FF0068D0FF0068D0FF0068D0FF0078C8E8009088A8004888D80050B8
      FF000870A00020485800606068000000000000000000FF000000007B0000FF00
      0000FF000000FF000000BDBDBD00FFFFFF0000FFFF007B0000007B0000007B00
      0000BDBDBD00FFFFFF00BDBDBD00FFFFFF000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000002088B8002888C000D0FFFF00A8E8
      FF0090C0D800C8C8C000C0C0B000A8B8B80090A0B0005890D00050B8FF0070D8
      FF001078A8000858800040484800000000007B7B7B00007B0000FF000000FF00
      0000FF000000BDBDBD00BDBDBD00FFFFFF007B7B0000FF000000FF000000FF00
      00007B000000FFFFFF00BDBDBD00FFFFFF000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000002888C0002890C00080C8F000C8C0
      C800F0E8E000FFFFE800FFFFD800FFF0C000D8B0980090C0D80078E0FF0080E8
      FF003098C8001880B00038404000909098007B7B7B007B7B0000BDBDBD00FF00
      00007B7B00007B7B0000BDBDBD00FFFFFF007B7B0000BDBDBD00007B0000FF00
      00007B000000FFFFFF00BDBDBD00FFFFFF000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000002888C00048B0E0003898D000D8C8
      B000FFFFFF00FFFFFF00FFFFE000FFF0C000FFE8B000B0C8C80090F0FF0090F0
      FF0050B8E8001078A80028405000585860007B7B7B007B7B0000BDBDBD00FFFF
      FF00BDBDBD00007B0000BDBDBD00FFFFFF007B7B0000FFFFFF00BDBDBD00007B
      00007B000000FFFFFF00BDBDBD00FFFFFF000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000002890C00068D0FF002088B800E0D0
      B000FFFFE000FFFFE800FFFFD800FFE8B800FFE8B800D8D0B80098FFFF0098FF
      FF0060C0FF0040A8D00010587800384040007B7B7B00BDBDBD00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00BDBDBD00FFFFFF0000FFFF007B7B00007B7B00007B7B
      0000BDBDBD00FFFFFF00BDBDBD00FFFFFF000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000002890C00078E0FF0040A8D000D8C0
      A000FFF0D000FFFFC800FFF0C000FFE8B800FFF0D000E8C8C000FFFFFF00FFFF
      FF0078E0FF0078D8E80000609000404848007B7B7B00FFFFFF00FFFFFF00FFFF
      FF00FF000000007B0000BDBDBD00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000003090C80080E8FF0068D0FF008088
      9000FFE8B000FFE8B000FFF0C000FFFFE800E8D8D0005088B0002088B8002080
      B8001880B0001880B00000689800A8B8B8007B7B7B00BDBDBD00FFFFFF00BDBD
      BD00FFFFFF00FF000000BDBDBD00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF00BDBDBD00FFFFFF007B7B7B00000000000000000000000000000000007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000003098C80090F0FF0090F0FF0090E8
      F000B0B8B800E0C8A800E0C8A800D8C0B800E8D8D000FFFFFF00FFFFFF00FFFF
      FF001078A800585858000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00007B0000007B0000BDBDBD00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00BDBDBD007B7B7B0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003098C800FFFFFF0098FFFF0098FF
      FF0098FFFF0098FFFF00FFFFFF002088B8002080B8001880B0001880B0001880
      B0001878B000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD007B7B0000007B00007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003098C800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002888C000A0A8A8000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00FF000000007B0000FF000000007B0000007B0000FF00
      00007B0000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003098C8003098
      C8003090C8002890C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B00BDBDBD00FFFFFF00FF0000007B7B00007B7B0000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00FFF8FFFFFFFF0000FFF08001FC7F0000
      FFE00000F87F0000E0010000F03F0000C0030000E03F000082070000C01F0000
      0F8F0000831F00001FC70000870F00003FC70000CF8F000020070000FF870000
      3FC70000FFC700001FC70000FFC300001F870000FFE30000870F0000FFE10000
      C01F0000FFF10000E03F8001FFF30000FFFFFFFFFFFFFFF8FFFFFFFFFFFFFFF0
      F007FFFFFFFFFFE0F007FFFFC187E001F007FC9FF333C003F007FEBFF3338007
      F007FEBFF3330D8FF007FEBFF3331DC7F007F8BFF3333DC7F007F6BFD3332007
      F007F6BFC3833DC7F007F81FF7C71DC7F007FFFFFFFF1D87F007FFFFFFFF870F
      FFFFFFFFFFFFC01FFFFFFFFFFFFFE03FFFFFFFFFFFEFFFFFFFFFFFFF9F8FFFFF
      FFFFFFFF8F03F007FFFFFFFFC601F00781FFFC1FE000F007FFDFF80FF000F007
      879FF007F000F007FF07F007E000F007879BF007C001F007FFDBF0078003F007
      81FBF80F001FF007FFFBFC1F001FF007FC07FFFFC01FF007FFFFFFFFC01FF007
      FFFFFFFFE03FFFFFFFFFFFFFF07FFFFFFFFFFFFFFFFFFFFF8001FFFFFEFFFEFF
      BFFDFFFFFFFFFFFFBFFDFB7FC27FC27FBFFDFB7FFFFFFFFFBFFDFB7FC200C200
      BFFDF00FFFFFFFFFBFFDFDBFDE07DE07BFFDFDBFCE079E07BFFDF00F07FF07FF
      BFFDFDBFCE009E00BFFDFEDFDE00DE00BFFDFEDFFFFFFFFFBFFDFEDFC200C200
      8001FFFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFFFFFFFFFF8001800180018001
      B7FDBFFDBBDDBFFDB7BDBFFDBBDDBFCDB7BDB001BBDDBFF5B7BDB7FDBBDDB2F5
      B7BDB7FDBBDDB6E5B7FDB7FDBBDDB6A9B7BDB7FDBBDDB629B7FDB7FDBBDDB7FD
      B7FDB7FD8001A3FDB001B7FDBB0DB7FDBFFDB7FDB061BFFDBFFDB7FD87F9BFFD
      8001800180018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001800180018001
      8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD
      8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD8001BFDDBF7DB7FD
      800180018001B7FD8001BE0DBC9DB0018001B0E1A3E5BFFD800187F99FF9BFFD
      8001800180018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF807
      C0038003F18FFBF78003BFFBE3C7F8078003BFFBE7E7F9E78003BFFBE7E7F807
      80038003E7E7FA178003BFFBC7E3FBF78003BFFBCFF3FBC78003BFFBE7E7FBCF
      80038003E7E7E81F8003BFFBE7E7E7FF8003BFFBE3C7E3FF8003BFFBF18FE7FF
      C0078003FFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF800FFFFFFFFFFE3E000C7E3
      FFFF8001C000C003FFFF00018000C7E3FFFF00018000EFF7F3CF00010000EFF7
      F99F00000000EFF7FC3F00000000EFF7FE7F00000000EFF7FC3F00000000EFF7
      F99F00000001EFF7F3CF00038003C7E3FFFF00078003C003FFFF80FFC007C7E3
      FFFFC3FFE00FFFFFFFFFFFFFF83FFFFF00000000000000000000000000000000
      000000000000}
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
