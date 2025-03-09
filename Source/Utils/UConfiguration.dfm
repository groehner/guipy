object FConfiguration: TFConfiguration
  Left = 203
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 498
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object PMain: TPanel
    Left = 0
    Top = 0
    Width = 832
    Height = 498
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object TVConfiguration: TTreeView
      Left = 0
      Top = 0
      Width = 189
      Height = 498
      Align = alLeft
      AutoExpand = True
      HideSelection = False
      Indent = 19
      TabOrder = 0
      OnChange = TVConfigurationChange
      Items.NodeData = {
        071800000009540054007200650065004E006F00640065002B00000000000000
        00000000FFFFFFFFFFFFFFFF0000000000000000000000000001065000790074
        0068006F006E000000350000000000000000000000FFFFFFFFFFFFFFFF000000
        00000000000000000000010B49006E0074006500720070007200650074006500
        720000002B0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        0009000000010645006400690074006F00720000002D00000000000000000000
        00FFFFFFFFFFFFFFFF0000000000000000000000000001074400690073007000
        6C006100790000002F0000000000000000000000FFFFFFFFFFFFFFFF00000000
        00000000000000000001084F007000740069006F006E007300310000002F0000
        000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000000108
        4F007000740069006F006E007300320000003D0000000000000000000000FFFF
        FFFFFFFFFFFF00000000000000000000000000010F43006F0064006500200043
        006F006D0070006C006500740069006F006E0000003300000000000000000000
        00FFFFFFFFFFFFFFFF00000000000000000000000000010A4B00650079007300
        740072006F006B00650073000000390000000000000000000000FFFFFFFFFFFF
        FFFF00000000000000000000000000010D530079006E00740061007800200063
        006F006C006F00720073000000370000000000000000000000FFFFFFFFFFFFFF
        FF00000000000000000000000000010C43006F006C006F007200200074006800
        65006D006500730000003B0000000000000000000000FFFFFFFFFFFFFFFF0000
        0000000000000000000000010E43006F00640065002000740065006D0070006C
        00610074006500730000003B0000000000000000000000FFFFFFFFFFFFFFFF00
        000000000000000000000000010E460069006C0065002000740065006D007000
        6C0061007400650073000000390000000000000000000000FFFFFFFFFFFFFFFF
        00000000000000000000000000010D43006C0061007300730020006D006F0064
        0065006C00650072000000370000000000000000000000FFFFFFFFFFFFFFFF00
        000000000000000000000000010C470055004900200064006500730069006700
        6E00650072000000350000000000000000000000FFFFFFFFFFFFFFFF00000000
        000000000000000000010B5300740072007500630074006F006700720061006D
        0000003F0000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
        000000000110530065007100750065006E006300650020006400690061006700
        720061006D000000330000000000000000000000FFFFFFFFFFFFFFFF00000000
        000000000000000000010A55004D004C002000440065007300690067006E0000
        00350000000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000
        0000010B55004D004C0020004F007000740069006F006E007300000039000000
        0000000000000000FFFFFFFFFFFFFFFF00000000000000000000000000010D49
        00440045002000530068006F0072007400630075007400730000002D00000000
        00000000000000FFFFFFFFFFFFFFFF0000000000000000000000000001074200
        72006F00770073006500720000002F0000000000000000000000FFFFFFFFFFFF
        FFFF0000000000000000000000000001084C0061006E00670075006100670065
        0000002D0000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
        0000000001074F007000740069006F006E00730000002B000000000000000000
        0000FFFFFFFFFFFFFFFF0000000000000000000000000001065300740079006C
        006500730000002D0000000000000000000000FFFFFFFFFFFFFFFF0000000000
        000000000000000001075000720069006E0074006500720000003D0000000000
        000000000000FFFFFFFFFFFFFFFF00000000000000000000000000010F480065
        00610064006500720020002600200046006F006F007400650072000000370000
        000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000000010C
        5200650073007400720069006300740069006F006E0073000000370000000000
        000000000000FFFFFFFFFFFFFFFF00000000000000000000000000010C410073
        0073006F00630069006100740069006F006E0073000000390000000000000000
        000000FFFFFFFFFFFFFFFF00000000000000000000000000010D4C004C004D00
        200041007300730069007300740061006E00740000002F000000000000000000
        0000FFFFFFFFFFFFFFFF0000000000000000000000000001084C004C004D0020
        0043006800610074000000330000000000000000000000FFFFFFFFFFFFFFFF00
        000000000000000000000000010A5600690073006900620069006C0069007400
        79000000250000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        000000000001035300530048000000290000000000000000000000FFFFFFFFFF
        FFFFFF00000000000000000002000000010554006F006F006C00730000002500
        00000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000000001
        034700690074000000330000000000000000000000FFFFFFFFFFFFFFFF000000
        00000000000000000000010A530075006200760065007200730069006F006E00
        00001F0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000
        0000000100}
    end
    object PanelRight: TPanel
      Left = 189
      Top = 0
      Width = 643
      Height = 498
      Align = alClient
      TabOrder = 1
      object PButtons: TPanel
        Left = 1
        Top = 456
        Width = 641
        Height = 41
        Align = alBottom
        TabOrder = 0
        object BSave: TButton
          Left = 546
          Top = 9
          Width = 75
          Height = 25
          Hint = 'Saves the current settings '
          Caption = 'Save'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = BSaveClick
        end
        object BCancel: TButton
          Tag = 1
          Left = 465
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Cancel'
          TabOrder = 3
          OnClick = BCancelClick
        end
        object BDump: TButton
          Tag = 2
          Left = 380
          Top = 9
          Width = 75
          Height = 25
          Hint = 'Outputs the entire configuration as a text file. '
          Caption = 'Dump'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = BDumpClick
        end
        object BCheck: TButton
          Tag = 3
          Left = 294
          Top = 9
          Width = 75
          Height = 25
          Hint = 'Checks the set paths and files'
          Caption = 'Check'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BCheckClick
        end
        object BHelp: TButton
          Tag = 4
          Left = 209
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Help'
          TabOrder = 0
          OnClick = BHelpClick
        end
      end
      object PTitle: TPanel
        Left = 1
        Top = 1
        Width = 641
        Height = 20
        Align = alTop
        BevelOuter = bvSpace
        TabOrder = 1
        object LTitle: TLabel
          Left = 8
          Top = 4
          Width = 5
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object PageList: TPageControl
        Left = 1
        Top = 21
        Width = 641
        Height = 435
        ActivePage = POptions1
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 2
        object PPython: TTabSheet
          Caption = 'Python'
          object vtPythonVersions: TVirtualStringTree
            Left = 3
            Top = 0
            Width = 561
            Height = 321
            DefaultNodeHeight = 19
            Header.AutoSizeIndex = 0
            Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
            Images = vilTreeImages
            TabOrder = 0
            OnDblClick = actPVActivateExecute
            OnGetCellText = vtPythonVersionsGetCellText
            OnGetImageIndex = vtPythonVersionsGetImageIndex
            OnInitChildren = vtPythonVersionsInitChildren
            OnInitNode = vtPythonVersionsInitNode
            Touch.InteractiveGestures = [igPan, igPressAndTap]
            Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
            Columns = <
              item
                MinWidth = 250
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coStyleColor]
                Position = 0
                Text = 'Name'
                Width = 250
              end
              item
                MinWidth = 200
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coStyleColor]
                Position = 1
                Text = 'Folder'
                Width = 300
              end>
          end
          object BPythonActivate: TButton
            Left = 568
            Top = 24
            Width = 75
            Height = 25
            Hint = 'Activate selected Python version'
            HelpContext = 880
            Caption = 'Activate'
            ImageIndex = 6
            TabOrder = 1
            OnClick = actPVActivateExecute
          end
          object BPythonAdd: TButton
            Left = 568
            Top = 64
            Width = 75
            Height = 25
            Hint = 'Add a new Python version'
            HelpContext = 880
            Caption = 'Add'
            ImageIndex = 1
            TabOrder = 2
            OnClick = actPVAddExecute
          end
          object BPythonRemove: TButton
            Left = 568
            Top = 104
            Width = 75
            Height = 25
            Hint = 'Remove selected Python version'
            HelpContext = 880
            Caption = 'Remove'
            ImageIndex = 2
            TabOrder = 3
            OnClick = actPVRemoveExecute
          end
          object RGEngineTypes: TRadioGroup
            Left = 3
            Top = 336
            Width = 374
            Height = 57
            Caption = 'Python Engine'
            Columns = 4
            ItemIndex = 0
            Items.Strings = (
              'Remote'
              'Remote (Tk)'
              'Remote (Wx)'
              'SSH')
            TabOrder = 4
          end
        end
        object PInterpreter: TTabSheet
          Caption = 'Interpreter'
          ImageIndex = 22
          object LInterpreterHistorySize: TLabel
            Left = 341
            Top = 257
            Width = 116
            Height = 15
            Caption = 'Interpreter history size'
          end
          object LTimeOut: TLabel
            Left = 341
            Top = 185
            Width = 176
            Height = 15
            Caption = 'Timeout for running scripts in ms'
          end
          object CBAlwaysUseSockets: TCheckBox
            Left = 16
            Top = 16
            Width = 270
            Height = 17
            Caption = 'Always use sockets'
            TabOrder = 0
          end
          object CBClearOutputBeforeRun: TCheckBox
            Left = 16
            Top = 40
            Width = 270
            Height = 17
            Caption = 'Clear output before run'
            TabOrder = 1
          end
          object CBInternalInterpreterHidden: TCheckBox
            Left = 16
            Top = 64
            Width = 270
            Height = 17
            Caption = 'Internal Interpreter hidden'
            TabOrder = 2
          end
          object CBJumpToErrorOnException: TCheckBox
            Left = 16
            Top = 88
            Width = 270
            Height = 17
            Caption = 'Jump to error on exception'
            TabOrder = 3
          end
          object CBMaskFPUExceptions: TCheckBox
            Left = 16
            Top = 111
            Width = 270
            Height = 17
            Caption = 'Mask FPU exceptions'
            TabOrder = 4
          end
          object CBPostMortemOnException: TCheckBox
            Left = 16
            Top = 136
            Width = 270
            Height = 17
            Caption = 'Post mortem on exception'
            TabOrder = 5
          end
          object CBPrettyPrintOutput: TCheckBox
            Left = 16
            Top = 160
            Width = 270
            Height = 17
            Caption = 'Pretty print output'
            TabOrder = 6
          end
          object CBReinitializeBeforeRun: TCheckBox
            Left = 16
            Top = 184
            Width = 270
            Height = 17
            Caption = 'Reinitialize before run'
            TabOrder = 7
          end
          object CBSaveEnvironmentBeforeRun: TCheckBox
            Left = 16
            Top = 208
            Width = 270
            Height = 17
            Caption = 'Save environment before run'
            TabOrder = 8
          end
          object CBSaveFilesBeforeRun: TCheckBox
            Left = 16
            Top = 232
            Width = 270
            Height = 17
            Caption = 'Save files before run'
            TabOrder = 9
          end
          object CBSaveInterpreterHistory: TCheckBox
            Left = 16
            Top = 256
            Width = 270
            Height = 17
            Caption = 'Save interpreter history'
            TabOrder = 10
          end
          object CBTraceOnlyIntoOpenFiles: TCheckBox
            Left = 16
            Top = 280
            Width = 270
            Height = 17
            Caption = 'Step into open files only'
            TabOrder = 11
          end
          object UDInterpreterHistorySize: TUpDown
            Left = 312
            Top = 254
            Width = 16
            Height = 23
            Associate = EInterpreterHistorySize
            TabOrder = 12
          end
          object EInterpreterHistorySize: TEdit
            Left = 288
            Top = 254
            Width = 24
            Height = 23
            TabOrder = 13
            Text = '0'
          end
          object UDTimeOut: TUpDown
            Left = 312
            Top = 182
            Width = 16
            Height = 23
            Associate = ETimeOut
            Max = 2000
            TabOrder = 14
          end
          object ETimeOut: TEdit
            Left = 288
            Top = 182
            Width = 24
            Height = 23
            TabOrder = 15
            Text = '0'
          end
          object CBReinitializeWhenClosing: TCheckBox
            Left = 16
            Top = 304
            Width = 369
            Height = 17
            Caption = 'Reinitialize when closing a UML window with objects'
            TabOrder = 16
          end
        end
        object PEditor: TTabSheet
          Caption = 'Editor'
        end
        object PDisplay: TTabSheet
          Caption = 'Display'
          ImageIndex = 27
          DesignSize = (
            633
            402)
          object gbGutter: TGroupBox
            AlignWithMargins = True
            Left = 8
            Top = 206
            Width = 533
            Height = 193
            Anchors = [akLeft, akRight, akBottom]
            Caption = 'Gutter'
            TabOrder = 0
            DesignSize = (
              533
              193)
            object lGutterColor: TLabel
              Left = 262
              Top = 118
              Width = 66
              Height = 15
              Anchors = [akTop, akRight]
              Caption = 'Gutter color:'
              ExplicitLeft = 274
            end
            object lDigits: TLabel
              Left = 274
              Top = 45
              Width = 30
              Height = 15
              Caption = 'Digits'
            end
            object pnlGutterFontDisplay: TPanel
              Left = 341
              Top = 148
              Width = 181
              Height = 27
              Anchors = [akTop, akRight]
              TabOrder = 6
              object lblGutterFont: TLabel
                Left = 1
                Top = 1
                Width = 179
                Height = 25
                Align = alClient
                Alignment = taCenter
                Caption = 'Terminal 8pt'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Terminal'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 72
                ExplicitHeight = 8
              end
            end
            object cbGutterColor: TSpTBXColorEdit
              Left = 361
              Top = 112
              Width = 137
              Height = 23
              TabOrder = 7
              SelectedColor = clBlack
              SelectedFormat = cttHTML
            end
            object ckGutterAutosize: TCheckBox
              Left = 24
              Top = 42
              Width = 180
              Height = 21
              Caption = 'Autosize'
              TabOrder = 1
              OnClick = ckGutterAutosizeClick
            end
            object ckGutterShowLineNumbers: TCheckBox
              Left = 24
              Top = 66
              Width = 180
              Height = 21
              Caption = 'Show line numbers'
              TabOrder = 2
            end
            object ckGutterShowLeaderZeros: TCheckBox
              Left = 24
              Top = 114
              Width = 225
              Height = 21
              Caption = 'Show leading zeros'
              TabOrder = 3
            end
            object ckGutterVisible: TCheckBox
              Left = 24
              Top = 18
              Width = 180
              Height = 21
              Caption = 'Visible'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object ckGutterStartAtZero: TCheckBox
              Left = 24
              Top = 90
              Width = 180
              Height = 21
              Caption = 'Start at zero'
              TabOrder = 8
            end
            object cbGutterFont: TCheckBox
              Left = 12
              Top = 162
              Width = 196
              Height = 21
              Anchors = [akTop, akRight]
              Caption = 'Use Gutter Font'
              TabOrder = 4
              OnClick = cbGutterFontClick
            end
            object ckGutterGradient: TCheckBox
              Left = 12
              Top = 138
              Width = 137
              Height = 21
              Hint = 'Gutter gradient visible'
              Anchors = [akTop, akRight]
              Caption = 'Gutter Gradient'
              TabOrder = 9
            end
            object btnGutterFont: TButton
              Left = 258
              Top = 149
              Width = 89
              Height = 25
              Caption = 'Font'
              TabOrder = 5
              OnClick = btnGutterFontClick
            end
            object EDigits: TEdit
              Left = 360
              Top = 41
              Width = 35
              Height = 23
              TabOrder = 10
              Text = '2'
            end
          end
          object gbLineSpacing: TGroupBox
            Left = 3
            Top = 125
            Width = 265
            Height = 88
            Anchors = [akTop]
            Caption = 'Line spacing / Tab spacing'
            TabOrder = 1
            DesignSize = (
              265
              88)
            object Label8: TLabel
              Left = 23
              Top = 27
              Width = 143
              Height = 15
              Caption = 'Extra lines spacing in pixels'
            end
            object Label9: TLabel
              Left = 23
              Top = 56
              Width = 102
              Height = 15
              Caption = 'Tab width in spaces'
            end
            object eLineSpacing: TEdit
              Left = 216
              Top = 23
              Width = 35
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              Text = '0'
            end
            object eTabWidth: TEdit
              Left = 216
              Top = 53
              Width = 35
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
              Text = '8'
            end
          end
          object gbRightEdge: TGroupBox
            Left = 267
            Top = 125
            Width = 271
            Height = 88
            Anchors = [akTop, akRight]
            Caption = 'Right Edge'
            TabOrder = 2
            DesignSize = (
              271
              88)
            object Label3: TLabel
              Left = 17
              Top = 53
              Width = 59
              Height = 15
              Caption = 'Edge color:'
            end
            object Label10: TLabel
              Left = 17
              Top = 27
              Width = 75
              Height = 15
              Caption = 'Edge Column:'
            end
            object eRightEdge: TEdit
              Left = 128
              Top = 23
              Width = 35
              Height = 23
              Anchors = [akTop, akRight]
              TabOrder = 0
              Text = '0'
            end
            object cbRightEdgeColor: TSpTBXColorEdit
              Left = 128
              Top = 53
              Width = 129
              Height = 23
              Anchors = [akTop, akRight]
              TabOrder = 1
              SelectedColor = clBlack
              SelectedFormat = cttHTML
            end
          end
          object gbBookmarks: TGroupBox
            Left = 267
            Top = 57
            Width = 271
            Height = 62
            Anchors = [akTop, akRight]
            Caption = 'Bookmarks'
            TabOrder = 3
            object ckBookmarkKeys: TCheckBox
              Left = 23
              Top = 16
              Width = 230
              Height = 21
              Caption = 'Bookmark keys'
              TabOrder = 0
            end
            object ckBookmarkVisible: TCheckBox
              Left = 23
              Top = 35
              Width = 230
              Height = 21
              Caption = 'Bookmarks visible'
              TabOrder = 1
            end
          end
          object gbActiveLineColor: TGroupBox
            Left = 267
            Top = 8
            Width = 271
            Height = 43
            Anchors = [akTop, akRight]
            Caption = 'Active Line Color'
            TabOrder = 4
            DesignSize = (
              271
              43)
            object cbActiveLineColor: TSpTBXColorEdit
              Left = 48
              Top = 16
              Width = 206
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              SelectedColor = clBlack
              SelectedFormat = cttHTML
            end
          end
          object gbEditorFont: TGroupBox
            Left = 8
            Top = 8
            Width = 265
            Height = 111
            Caption = 'Editor Font'
            TabOrder = 5
            object Panel3: TPanel
              Left = 35
              Top = 21
              Width = 190
              Height = 30
              TabOrder = 1
              object labFont: TLabel
                Left = 1
                Top = 1
                Width = 188
                Height = 28
                Align = alClient
                Alignment = taCenter
                Caption = 'Consolas 10pt'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Consolas'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 91
                ExplicitHeight = 15
              end
            end
            object btnFont: TButton
              Left = 78
              Top = 57
              Width = 92
              Height = 25
              Caption = 'Font'
              TabOrder = 0
              OnClick = btnFontClick
            end
          end
        end
        object POptions1: TTabSheet
          Caption = 'Options 1'
          object CBAutoCompleteBrackets: TCheckBox
            Left = 16
            Top = 64
            Width = 260
            Height = 17
            Caption = 'Auto complete brackets'
            TabOrder = 0
          end
          object CBAutoHideFindToolbar: TCheckBox
            Left = 16
            Top = 88
            Width = 260
            Height = 17
            Caption = 'Auto hide find toolbar'
            TabOrder = 1
          end
          object CBAutoReloadChangedFiles: TCheckBox
            Left = 16
            Top = 112
            Width = 260
            Height = 17
            Caption = 'Auto reload changed files'
            TabOrder = 2
          end
          object CBCheckSyntaxAsYouType: TCheckBox
            Left = 16
            Top = 16
            Width = 207
            Height = 17
            Caption = 'Check syntax as you type'
            TabOrder = 3
          end
          object CBCodeFoldingEnabled: TCheckBox
            Left = 16
            Top = 136
            Width = 260
            Height = 17
            Caption = 'Code folding enabled'
            TabOrder = 4
          end
          object CBCompactLineNumbers: TCheckBox
            Left = 16
            Top = 184
            Width = 260
            Height = 17
            Caption = 'Compact line numbers'
            TabOrder = 5
          end
          object CBCreateBackupFiles: TCheckBox
            Left = 16
            Top = 208
            Width = 260
            Height = 17
            Caption = 'Create backup files'
            TabOrder = 6
          end
          object CBDetectUTF8Encoding: TCheckBox
            Left = 16
            Top = 232
            Width = 321
            Height = 17
            Caption = 'Detect UTF8 encoding when opening files'
            TabOrder = 7
          end
          object CBDisplayPackageNames: TCheckBox
            Left = 16
            Top = 256
            Width = 332
            Height = 17
            Caption = 'Display package names in editor tabs'
            TabOrder = 8
          end
          object CBHighlightSelectedWord: TCheckBox
            Left = 354
            Top = 39
            Width = 200
            Height = 17
            Caption = 'Highlight selected word'
            TabOrder = 9
          end
          object CBMarkExecutableLines: TCheckBox
            Left = 16
            Top = 280
            Width = 260
            Height = 17
            Caption = 'Mark executable lines'
            TabOrder = 10
          end
          object CBSearchTextAtCaret: TCheckBox
            Left = 16
            Top = 304
            Width = 260
            Height = 17
            Caption = 'Search text at caret'
            TabOrder = 11
          end
          object CBShowCodeHints: TCheckBox
            Left = 16
            Top = 328
            Width = 260
            Height = 17
            Caption = 'Show code hints'
            TabOrder = 12
          end
          object CBShowDebuggerHints: TCheckBox
            Left = 16
            Top = 40
            Width = 260
            Height = 17
            Caption = 'Show debugger hints'
            TabOrder = 13
          end
          object CBTrimTrailingSpacesOnSave: TCheckBox
            Left = 16
            Top = 351
            Width = 332
            Height = 17
            Caption = 'Trim trailing spaces on save'
            TabOrder = 14
          end
          object CBUndoAfterSave: TCheckBox
            Left = 16
            Top = 374
            Width = 260
            Height = 17
            Caption = 'Undo after save'
            TabOrder = 15
          end
          object CBHighlightSelectedWordColor: TColorBox
            Left = 560
            Top = 41
            Width = 86
            Height = 22
            Style = [cbStandardColors, cbCustomColor, cbPrettyNames]
            TabOrder = 16
          end
          object RGNewFileEncoding: TRadioGroup
            Left = 354
            Top = 129
            Width = 233
            Height = 137
            Caption = 'File encoding for new files'
            Items.Strings = (
              'ANSI'
              'UTF8'
              'UTF8 no BOM'
              'UTF16 LE'
              'UTF16 BE')
            TabOrder = 17
          end
          object RGNewFileLineBreaks: TRadioGroup
            Left = 354
            Top = 272
            Width = 233
            Height = 113
            Caption = 'Line break format for new files'
            Items.Strings = (
              'DOS'
              'Unix'
              'Mac'
              'Unicode')
            TabOrder = 18
          end
          object CBGUICodeFolding: TCheckBox
            Left = 16
            Top = 160
            Width = 296
            Height = 17
            Caption = 'Code folding for gui components'
            TabOrder = 19
          end
          object cbDisplayFlowControl: TCheckBox
            Left = 354
            Top = 16
            Width = 200
            Height = 17
            Caption = 'Program flow control symbols'
            TabOrder = 20
          end
          object cbDisplayFlowControlColor: TColorBox
            Left = 560
            Top = 16
            Width = 86
            Height = 22
            Style = [cbStandardColors, cbCustomColor, cbPrettyNames]
            TabOrder = 21
          end
          object CBIndentationGuide: TCheckBox
            Left = 354
            Top = 64
            Width = 200
            Height = 17
            Caption = 'Indentation lines'
            TabOrder = 22
          end
          object cbAccessibilitySupport: TCheckBox
            Left = 354
            Top = 88
            Width = 215
            Height = 17
            Caption = 'Accessibility support'
            TabOrder = 23
          end
        end
        object POptions2: TTabSheet
          Caption = 'Options 2'
          ImageIndex = 26
          object LAuthor: TLabel
            Left = 16
            Top = 325
            Width = 37
            Height = 15
            Caption = 'Author'
          end
          object LLicence: TLabel
            Left = 330
            Top = 325
            Width = 40
            Height = 15
            Caption = 'Licence'
          end
          object gbOptions: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 627
            Height = 310
            Align = alTop
            Caption = 'Options'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            object GridPanel1: TGridPanel
              Left = 2
              Top = 17
              Width = 623
              Height = 291
              Align = alClient
              BevelOuter = bvNone
              ColumnCollection = <
                item
                  Value = 50.000000000000000000
                end
                item
                  Value = 50.000000000000010000
                end>
              ControlCollection = <
                item
                  Column = 0
                  Control = StackPanel1
                  Row = 0
                end
                item
                  Column = 1
                  Control = StackPanel2
                  Row = 0
                end>
              RowCollection = <
                item
                  Value = 100.000000000000000000
                end>
              TabOrder = 0
              object StackPanel1: TStackPanel
                Left = 0
                Top = 0
                Width = 312
                Height = 291
                Align = alClient
                BevelOuter = bvNone
                ControlCollection = <
                  item
                    Control = ckAutoIndent
                  end
                  item
                    Control = ckDragAndDropEditing
                  end
                  item
                    Control = ckEnhanceEndKey
                  end
                  item
                    Control = ckEnhanceHomeKey
                  end
                  item
                    Control = ckGroupUndo
                  end
                  item
                    Control = ckKeepCaretX
                  end
                  item
                    Control = ckRightMouseMoves
                  end
                  item
                    Control = ckSmartTabs
                  end
                  item
                    Control = ckSmartTabDelete
                  end
                  item
                    Control = ckTabIndent
                  end
                  item
                    Control = ckTabsToSpaces
                  end
                  item
                    Control = ckTrimTrailingSpaces
                  end>
                HorizontalPositioning = sphpFill
                Padding.Left = 4
                Spacing = 7
                TabOrder = 0
                DesignSize = (
                  312
                  291)
                object ckAutoIndent: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 0
                  Width = 302
                  Height = 17
                  Hint = 
                    'Will indent the caret on new lines with the same amount of leadi' +
                    'ng white space as the preceding line'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Auto indent'
                  TabOrder = 9
                end
                object ckDragAndDropEditing: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 24
                  Width = 302
                  Height = 17
                  Hint = 
                    'Allows you to select a block of text and drag it within the docu' +
                    'ment to another location'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Drag and drop editing'
                  TabOrder = 8
                end
                object ckEnhanceEndKey: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 48
                  Width = 302
                  Height = 17
                  Hint = 'Enhances end key similar to JDeveloper'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Enhance End Key'
                  TabOrder = 1
                end
                object ckEnhanceHomeKey: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 72
                  Width = 302
                  Height = 17
                  Hint = 'enhances home key positioning, similar to visual studio'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Enhance Home Key'
                  TabOrder = 2
                end
                object ckGroupUndo: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 96
                  Width = 302
                  Height = 17
                  Hint = 
                    'When undoing/redoing actions, handle all continuous changes of t' +
                    'he same kind in one call instead undoing/redoing each command se' +
                    'parately'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Group undo'
                  TabOrder = 11
                end
                object ckKeepCaretX: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 120
                  Width = 302
                  Height = 17
                  Hint = 
                    'When moving through lines the X position will always stay the sa' +
                    'me'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Maintain caret column'
                  TabOrder = 7
                end
                object ckRightMouseMoves: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 144
                  Width = 302
                  Height = 17
                  Hint = 
                    'When clicking with the right mouse for a popup menu, move the cu' +
                    'rsor to that location'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Right mouse moves cursor'
                  TabOrder = 0
                end
                object ckSmartTabs: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 168
                  Width = 302
                  Height = 17
                  Hint = 
                    'When tabbing, the cursor will go to the next non-white space cha' +
                    'racter of the previous line'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Smart tabs'
                  TabOrder = 5
                end
                object ckSmartTabDelete: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 192
                  Width = 302
                  Height = 17
                  Hint = 'similar to Smart Tabs, but when you delete characters'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Smart tab delete'
                  TabOrder = 4
                end
                object ckTabIndent: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 216
                  Width = 302
                  Height = 17
                  Hint = 'Tab indents and Shift-Tab unindents'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Tab Indent'
                  TabOrder = 6
                end
                object ckTabsToSpaces: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 240
                  Width = 302
                  Height = 17
                  Hint = 'Converts a tab character to the number of spaces in Tab Width'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Tabs to spaces'
                  TabOrder = 3
                end
                object ckTrimTrailingSpaces: TCheckBox
                  AlignWithMargins = True
                  Left = 7
                  Top = 264
                  Width = 302
                  Height = 17
                  Hint = 'Spaces at the end of lines will be trimmed and not saved'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Trim trailing spaces'
                  TabOrder = 10
                end
              end
              object StackPanel2: TStackPanel
                Left = 312
                Top = 0
                Width = 311
                Height = 291
                Align = alClient
                BevelOuter = bvNone
                ControlCollection = <
                  item
                    Control = ckDisableScrollArrows
                  end
                  item
                    Control = ckHalfPageScroll
                  end
                  item
                    Control = ckHideShowScrollbars
                  end
                  item
                    Control = ckScrollByOneLess
                  end
                  item
                    Control = ckScrollPastEOF
                  end
                  item
                    Control = ckScrollPastEOL
                  end
                  item
                    Control = ckShowScrollHint
                  end
                  item
                    Control = ckShowLigatures
                  end
                  item
                    Control = ckScrollHintFollows
                  end
                  item
                    Control = ckShowSpecialChars
                  end
                  item
                    Control = ckScrollbarAnnotation
                  end
                  item
                    Control = ckWordWrap
                  end>
                HorizontalPositioning = sphpFill
                Spacing = 7
                TabOrder = 1
                DesignSize = (
                  311
                  291)
                object ckDisableScrollArrows: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 0
                  Width = 305
                  Height = 17
                  Hint = 
                    'Disables the scroll bar arrow buttons when you can'#39't scroll in t' +
                    'hat direction any more'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Disable scroll arrows'
                  TabOrder = 2
                end
                object ckHalfPageScroll: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 24
                  Width = 305
                  Height = 17
                  Hint = 
                    'When scrolling with page-up and page-down commands, only scroll ' +
                    'a half page at a time'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Half page scroll'
                  TabOrder = 9
                end
                object ckHideShowScrollbars: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 48
                  Width = 305
                  Height = 17
                  Hint = 
                    'If enabled, then the scrollbars will only show when necessary.  ' +
                    'If you have ScrollPastEOL, then it the horizontal bar will alway' +
                    's be there (it uses MaxLength instead).'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Hide scrollbars as necessary'
                  TabOrder = 3
                end
                object ckScrollByOneLess: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 72
                  Width = 305
                  Height = 17
                  Hint = 'Forces scrolling to be one less'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Scroll by one less'
                  TabOrder = 8
                end
                object ckScrollPastEOF: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 96
                  Width = 305
                  Height = 17
                  Hint = 'Allows the cursor to go past the end of file marker'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Scroll past end of file'
                  TabOrder = 7
                end
                object ckScrollPastEOL: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 120
                  Width = 305
                  Height = 17
                  Hint = 
                    'Allows the cursor to go past the last character into the white s' +
                    'pace at the end of a line'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Scroll past end of line'
                  TabOrder = 6
                end
                object ckShowScrollHint: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 144
                  Width = 305
                  Height = 17
                  Hint = 
                    'Shows a hint of the visible line numbers when scrolling vertical' +
                    'ly'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Show scroll hint'
                  TabOrder = 5
                end
                object ckShowLigatures: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 168
                  Width = 305
                  Height = 17
                  Hint = 'Show font ligatures'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Show font ligatures'
                  TabOrder = 10
                end
                object ckScrollHintFollows: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 192
                  Width = 305
                  Height = 17
                  Hint = 'The scroll hint follows the mouse when scrolling vertically'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Scroll hint follows mouse'
                  TabOrder = 4
                end
                object ckShowSpecialChars: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 216
                  Width = 305
                  Height = 17
                  Hint = 'Shows line breaks, spaces and tabs using special symbols'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Show special chars'
                  TabOrder = 1
                end
                object ckScrollbarAnnotation: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 240
                  Width = 305
                  Height = 17
                  Hint = 
                    'Shows errors, bookmarks, modifications and carets in the scrollb' +
                    'ar'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Anchors = [akTop, akRight]
                  Caption = 'Scrollbar annotation'
                  TabOrder = 0
                end
                object ckWordWrap: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 264
                  Width = 305
                  Height = 17
                  Hint = 'Allows the editor accept OLE file drops'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Caption = 'Word wrap'
                  TabOrder = 11
                end
              end
            end
          end
          object EAuthor: TEdit
            Left = 16
            Top = 346
            Width = 241
            Height = 23
            TabOrder = 1
          end
          object ELicence: TEdit
            Left = 330
            Top = 346
            Width = 241
            Height = 23
            TabOrder = 2
          end
        end
        object PCodeCompletion: TTabSheet
          Caption = 'Code completion'
          object LCodeCompletionListSize: TLabel
            Left = 360
            Top = 26
            Width = 132
            Height = 15
            Caption = 'Code completion list size'
          end
          object LSpecialPackages: TLabel
            Left = 439
            Top = 55
            Width = 89
            Height = 15
            Caption = 'Special packages'
          end
          object CBCompletionCaseSensitive: TCheckBox
            Left = 16
            Top = 16
            Width = 270
            Height = 17
            Caption = 'Case sensitive'
            TabOrder = 0
          end
          object CBCompleteAsYouType: TCheckBox
            Left = 16
            Top = 40
            Width = 270
            Height = 17
            Caption = 'Complete as you type'
            TabOrder = 1
          end
          object CBCompleteKeywords: TCheckBox
            Left = 16
            Top = 64
            Width = 270
            Height = 17
            Caption = 'Complete Python keywords'
            TabOrder = 2
          end
          object CBCompleteWithOneEntry: TCheckBox
            Left = 16
            Top = 88
            Width = 270
            Height = 17
            Caption = 'Auto-complete with one entry'
            TabOrder = 3
          end
          object CBCompleteWithWordBreakChars: TCheckBox
            Left = 16
            Top = 112
            Width = 270
            Height = 17
            Caption = 'Complete with word-break character'
            TabOrder = 4
          end
          object CBEditorCodeCompletion: TCheckBox
            Left = 16
            Top = 136
            Width = 270
            Height = 17
            Caption = 'Editor code completion'
            TabOrder = 5
          end
          object CBInterpreterCodeCompletion: TCheckBox
            Left = 16
            Top = 160
            Width = 270
            Height = 17
            Caption = 'Interpreter code completion'
            TabOrder = 6
          end
          object ECodeCompletionListSize: TEdit
            Left = 304
            Top = 21
            Width = 34
            Height = 23
            TabOrder = 7
            Text = '0'
          end
          object ESpecialPackages: TEdit
            Left = 304
            Top = 51
            Width = 121
            Height = 23
            TabOrder = 8
            Text = 'os'
          end
          object BCodeCompletionFont: TButton
            Left = 304
            Top = 84
            Width = 75
            Height = 25
            Caption = 'Font'
            TabOrder = 9
            OnClick = BCodeCompletionFontClick
          end
          object UDCodeComletionListSize: TUpDown
            Left = 338
            Top = 21
            Width = 16
            Height = 23
            Associate = ECodeCompletionListSize
            TabOrder = 10
          end
        end
        object PKeystrokes: TTabSheet
          Caption = 'Keystrokes'
          ImageIndex = 25
          object gbKeyStrokes: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 233
            Width = 526
            Height = 119
            Caption = 'Keystroke Options'
            TabOrder = 0
            object Label5: TLabel
              Left = 50
              Top = 28
              Width = 60
              Height = 15
              Caption = 'Command:'
            end
            object Label6: TLabel
              Left = 50
              Top = 91
              Width = 63
              Height = 15
              Caption = 'Keystroke 2:'
            end
            object Label7: TLabel
              Left = 50
              Top = 59
              Width = 63
              Height = 15
              Caption = 'Keystroke 1:'
            end
            object cKeyCommand: TComboBox
              Left = 185
              Top = 23
              Width = 268
              Height = 23
              Style = csDropDownList
              Sorted = True
              TabOrder = 0
              OnKeyUp = cKeyCommandKeyUp
            end
          end
          object btnRemKey: TButton
            Left = 296
            Top = 185
            Width = 102
            Height = 25
            Caption = '&Remove'
            TabOrder = 1
            OnClick = btnRemKeyClick
          end
          object btnAddKey: TButton
            Left = 173
            Top = 185
            Width = 102
            Height = 25
            Caption = '&Add'
            TabOrder = 2
            OnClick = btnAddKeyClick
          end
          object btnUpdateKey: TButton
            Left = 50
            Top = 185
            Width = 102
            Height = 25
            Caption = '&Update'
            TabOrder = 3
            OnClick = btnUpdateKeyClick
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 633
            Height = 169
            Align = alTop
            TabOrder = 4
            object KeyList: TListView
              Left = 1
              Top = 1
              Width = 528
              Height = 167
              BorderStyle = bsNone
              Columns = <
                item
                  Caption = 'Command'
                  Width = 200
                end
                item
                  Caption = 'Keystroke'
                  Width = 142
                end>
              ColumnClick = False
              FlatScrollBars = True
              HideSelection = False
              ReadOnly = True
              RowSelect = True
              SortType = stText
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
          object btnResetKeys: TButton
            Left = 420
            Top = 185
            Width = 102
            Height = 25
            Hint = 'Restart GuiPy'
            Caption = 'Reset'
            TabOrder = 5
            OnClick = btnResetKeysClick
          end
        end
        object PSyntaxColors: TTabSheet
          Caption = 'Syntax colors'
          DesignSize = (
            633
            402)
          object Label13: TLabel
            Left = 8
            Top = 240
            Width = 99
            Height = 15
            Caption = 'B&ackground Color:'
          end
          object Label12: TLabel
            Left = 8
            Top = 188
            Width = 97
            Height = 15
            Caption = '&Foreground Color:'
          end
          object Label14: TLabel
            Left = 217
            Top = 61
            Width = 70
            Height = 15
            Caption = 'Code Sample'
          end
          object Label11: TLabel
            Left = 8
            Top = 60
            Width = 46
            Height = 15
            Caption = '&Element:'
          end
          object Label15: TLabel
            Left = 8
            Top = 4
            Width = 124
            Height = 15
            Caption = 'Editor Syntax Language'
          end
          object cbHighlighters: TComboBox
            Left = 8
            Top = 23
            Width = 136
            Height = 23
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = cbHighlightersChange
          end
          object GroupBox1: TGroupBox
            Left = 8
            Top = 296
            Width = 191
            Height = 69
            Caption = 'Text attributes'
            TabOrder = 1
            DesignSize = (
              191
              69)
            object cbxElementBold: TCheckBox
              Left = 5
              Top = 17
              Width = 84
              Height = 21
              Caption = '&Bold'
              Enabled = False
              TabOrder = 0
              OnClick = cbxElementBoldClick
            end
            object cbxElementItalic: TCheckBox
              Left = 5
              Top = 41
              Width = 86
              Height = 21
              Caption = '&Italic'
              Enabled = False
              TabOrder = 1
              OnClick = cbxElementBoldClick
            end
            object cbxElementUnderline: TCheckBox
              Left = 77
              Top = 17
              Width = 93
              Height = 21
              Anchors = [akTop, akRight]
              Caption = '&Underline'
              Enabled = False
              TabOrder = 2
              OnClick = cbxElementBoldClick
            end
            object cbxElementStrikeout: TCheckBox
              Left = 77
              Top = 41
              Width = 93
              Height = 21
              Anchors = [akTop, akRight]
              Caption = '&Strike Out'
              Enabled = False
              TabOrder = 3
              OnClick = cbxElementBoldClick
            end
          end
          object cbElementBackground: TSpTBXColorEdit
            Left = 8
            Top = 261
            Width = 191
            Height = 23
            TabOrder = 2
            SelectedColor = clBlack
            SelectedFormat = cttHTML
            OnSelectedColorChanged = cbElementBackgroundSelectedColorChanged
          end
          object cbElementForeground: TSpTBXColorEdit
            Left = 8
            Top = 205
            Width = 191
            Height = 23
            TabOrder = 3
            SelectedColor = clBlack
            SelectedFormat = cttHTML
            OnSelectedColorChanged = cbElementForegroundSelectedColorChanged
          end
          object SynSyntaxSample: TSynEdit
            Left = 217
            Top = 80
            Width = 324
            Height = 281
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Consolas'
            Font.Style = []
            Font.Quality = fqClearTypeNatural
            TabOrder = 4
            OnClick = SynSyntaxSampleClick
            UseCodeFolding = False
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Consolas'
            Gutter.Font.Style = []
            Gutter.Font.Quality = fqClearTypeNatural
            Gutter.Visible = False
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
              end
              item
                Kind = gbkMargin
                Width = 3
              end>
            RightEdge = 0
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
          end
          object lbElements: TSpTBXListBox
            Left = 8
            Top = 79
            Width = 188
            Height = 97
            Style = lbStandard
            ItemHeight = 13
            TabOrder = 5
            OnClick = lbElementsClick
          end
        end
        object PColorTheme: TTabSheet
          Caption = 'Color themes'
          ImageIndex = 24
          DesignSize = (
            633
            402)
          object SpTBXLabel1: TLabel
            Left = 199
            Top = 3
            Width = 70
            Height = 15
            Caption = 'Code Sample'
          end
          object SpTBXLabel2: TLabel
            Left = 19
            Top = 3
            Width = 92
            Height = 15
            Caption = 'Available Themes'
          end
          object lbColorThemes: TListBox
            Left = 27
            Top = 22
            Width = 166
            Height = 387
            ItemHeight = 15
            TabOrder = 0
            OnClick = lbColorThemesClick
          end
          object SynThemeSample: TSynEdit
            Left = 199
            Top = 22
            Width = 342
            Height = 387
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Consolas'
            Font.Style = []
            Font.Quality = fqClearTypeNatural
            TabOrder = 1
            UseCodeFolding = False
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Consolas'
            Gutter.Font.Style = []
            Gutter.Font.Quality = fqClearTypeNatural
            Gutter.Visible = False
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
              end
              item
                Kind = gbkMargin
                Width = 3
              end>
            RightEdge = 0
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
          end
        end
        object PCodeTemplates: TTabSheet
          Caption = 'Code templates'
          DesignSize = (
            633
            402)
          object GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 8
            Top = 160
            Width = 557
            Height = 240
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Code Template:'
            TabOrder = 0
            DesignSize = (
              557
              240)
            object Label2: TLabel
              Left = 14
              Top = 21
              Width = 35
              Height = 15
              Caption = '&Name:'
            end
            object Label4: TLabel
              Left = 14
              Top = 65
              Width = 51
              Height = 15
              Caption = '&Template:'
            end
            object Label16: TLabel
              Left = 14
              Top = 44
              Width = 63
              Height = 15
              Caption = '&Description:'
            end
            object Label17: TLabel
              Left = 14
              Top = 206
              Width = 204
              Height = 13
              Caption = 'Press Shift+Ctrl+M for Modifier completion'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Shell Dlg 2'
              Font.Style = []
              ParentFont = False
            end
            object Label18: TLabel
              Left = 14
              Top = 220
              Width = 214
              Height = 13
              Caption = 'Press Shift+Ctrl+P for Parameter completion'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Shell Dlg 2'
              Font.Style = []
              ParentFont = False
            end
            object CodeSynTemplate: TSynEdit
              Left = 14
              Top = 84
              Width = 541
              Height = 116
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Consolas'
              Font.Pitch = fpFixed
              Font.Style = []
              Font.Quality = fqClearTypeNatural
              TabOrder = 1
              UseCodeFolding = False
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
                end
                item
                  Kind = gbkMargin
                  Width = 3
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
              TabWidth = 4
            end
            object edDescription: TEdit
              Left = 115
              Top = 43
              Width = 435
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edShortcut: TEdit
              Left = 115
              Top = 16
              Width = 121
              Height = 23
              TabOrder = 0
              OnKeyPress = edShortcutKeyPress
            end
          end
          object CodeTemplatesLvItems: TListView
            Left = 8
            Top = 3
            Width = 489
            Height = 109
            Columns = <
              item
                Caption = 'Name'
                Width = 120
              end
              item
                Caption = 'Description'
                Width = 280
              end>
            ColumnClick = False
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            OnDeletion = CodeTemplatesLvItemsDeletion
            OnSelectItem = CodeTemplatesLvItemsSelectItem
          end
          object btnAdd: TButton
            Left = 30
            Top = 118
            Width = 80
            Height = 24
            Action = actCodeAddItem
            TabOrder = 2
          end
          object btnDelete: TButton
            Left = 121
            Top = 118
            Width = 80
            Height = 24
            Action = actCodeDeleteItem
            TabOrder = 3
          end
          object btnMoveDown: TButton
            Left = 305
            Top = 118
            Width = 80
            Height = 24
            Action = actCodeMoveDown
            TabOrder = 4
          end
          object btnMoveup: TButton
            Left = 213
            Top = 118
            Width = 80
            Height = 24
            Action = actCodeMoveUp
            TabOrder = 5
          end
          object btnUpdate: TButton
            Left = 397
            Top = 118
            Width = 80
            Height = 24
            Action = actCodeUpdateItem
            TabOrder = 6
          end
        end
        object PFileTemplates: TTabSheet
          Caption = 'File templates'
          ImageIndex = 28
          DesignSize = (
            633
            402)
          object FileTemplatesLvItems: TListView
            Left = 14
            Top = 3
            Width = 555
            Height = 109
            Columns = <
              item
                Caption = 'Name'
                Width = 200
              end
              item
                Caption = 'Category'
                Width = 280
              end>
            ColumnClick = False
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnSelectItem = FileTemplatesLvItemsSelectItem
          end
          object GroupBox3: TGroupBox
            Left = 8
            Top = 160
            Width = 586
            Height = 240
            Anchors = [akLeft, akTop, akRight]
            Caption = 'File Template:'
            TabOrder = 1
            DesignSize = (
              586
              240)
            object Label19: TLabel
              Left = 14
              Top = 21
              Width = 35
              Height = 15
              Caption = '&Name:'
              FocusControl = edName
            end
            object Label20: TLabel
              Left = 14
              Top = 65
              Width = 51
              Height = 15
              Caption = '&Template:'
              FocusControl = FileSynTemplate
            end
            object Label21: TLabel
              Left = 276
              Top = 21
              Width = 51
              Height = 15
              Caption = '&Category:'
              FocusControl = edCategory
            end
            object Label22: TLabel
              Left = 14
              Top = 220
              Width = 230
              Height = 15
              Caption = 'Press Shift+Ctrl+M for Modifier completion'
              Enabled = False
            end
            object Label23: TLabel
              Left = 14
              Top = 206
              Width = 235
              Height = 15
              Caption = 'Press Shift+Ctrl+P for Parameter completion'
              Enabled = False
            end
            object Label24: TLabel
              Left = 14
              Top = 44
              Width = 95
              Height = 15
              Caption = '&Default Extension:'
              FocusControl = edExtension
            end
            object Label25: TLabel
              Left = 276
              Top = 44
              Width = 63
              Height = 15
              Caption = '&Highlighter:'
              FocusControl = edCategory
            end
            object FileSynTemplate: TSynEdit
              Left = 14
              Top = 84
              Width = 570
              Height = 116
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Consolas'
              Font.Style = []
              Font.Quality = fqClearTypeNatural
              TabOrder = 1
              UseCodeFolding = False
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
                end
                item
                  Kind = gbkMargin
                  Width = 3
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
              TabWidth = 4
            end
            object CBFileTemplatesHighlighter: TComboBox
              Left = 400
              Top = 44
              Width = 121
              Height = 23
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 4
              OnChange = CBFileTemplatesHighlighterChange
            end
            object edName: TEdit
              Left = 115
              Top = 16
              Width = 127
              Height = 23
              TabOrder = 0
            end
            object edCategory: TEdit
              Left = 400
              Top = 20
              Width = 161
              Height = 23
              AutoSize = False
              TabOrder = 2
            end
            object edExtension: TEdit
              Left = 204
              Top = 44
              Width = 38
              Height = 23
              TabOrder = 3
            end
          end
          object btnFileAdd: TButton
            Left = 30
            Top = 118
            Width = 80
            Height = 24
            Action = actFileAddItem
            TabOrder = 2
          end
          object btnFileDelete: TButton
            Left = 116
            Top = 118
            Width = 80
            Height = 24
            Action = actFileDeleteItem
            TabOrder = 3
          end
          object btnFileDown: TButton
            Left = 288
            Top = 118
            Width = 80
            Height = 24
            Action = actFileMoveDown
            TabOrder = 4
          end
          object btnFileUp: TButton
            Left = 202
            Top = 118
            Width = 80
            Height = 24
            Action = actFileMoveUp
            TabOrder = 5
          end
          object btnFileUpdate: TButton
            Left = 374
            Top = 118
            Width = 80
            Height = 24
            Action = actFileUpdateItem
            TabOrder = 6
          end
          object btnFileDefaultItem: TButton
            Left = 460
            Top = 118
            Width = 80
            Height = 24
            Action = actFileDefaultItem
            TabOrder = 7
          end
          object btnFileDefaultAll: TButton
            Left = 546
            Top = 118
            Width = 80
            Height = 24
            Action = actFileDefaultAll
            TabOrder = 8
          end
        end
        object PClassModeler: TTabSheet
          Caption = 'Class modeler'
          ImageIndex = 30
          object GBAttribuesOptions: TGroupBox
            Left = 16
            Top = 16
            Width = 305
            Height = 153
            Caption = 'Attributes options'
            TabOrder = 0
            object CBShowGetSetMethods: TCheckBox
              Left = 16
              Top = 24
              Width = 185
              Height = 17
              Caption = 'Show get/set methods'
              TabOrder = 0
            end
            object CBShowTypeSelection: TCheckBox
              Left = 16
              Top = 120
              Width = 169
              Height = 17
              Caption = 'Show type selection'
              TabOrder = 1
            end
            object CBGetSetMethodsAsProperty: TCheckBox
              Left = 16
              Top = 48
              Width = 201
              Height = 17
              Caption = 'get/set methods as property'
              TabOrder = 2
            end
            object CBGetMethodChecked: TCheckBox
              Left = 16
              Top = 72
              Width = 193
              Height = 17
              Caption = 'get method checked'
              TabOrder = 3
            end
            object CBSetMethodChecked: TCheckBox
              Left = 16
              Top = 96
              Width = 217
              Height = 17
              Caption = 'set method checked'
              TabOrder = 4
            end
          end
          object GBMethodsOptions: TGroupBox
            Left = 16
            Top = 184
            Width = 305
            Height = 73
            Caption = 'Methods options'
            TabOrder = 1
            object CBShowWithWithoutReturnValue: TCheckBox
              Left = 16
              Top = 24
              Width = 206
              Height = 17
              Caption = 'Show with/without return value'
              TabOrder = 0
            end
            object CBShowParameterTypeSelection: TCheckBox
              Left = 16
              Top = 47
              Width = 206
              Height = 17
              Caption = 'Show parameter type selection'
              TabOrder = 1
            end
          end
          object GBClassOptions: TGroupBox
            Left = 16
            Top = 280
            Width = 305
            Height = 57
            Caption = 'Class options'
            TabOrder = 2
            object CBFromFutureImport: TCheckBox
              Left = 16
              Top = 24
              Width = 273
              Height = 17
              Caption = 'Use "from __future__ import annotations"'
              TabOrder = 0
            end
          end
        end
        object PGUIDesigner: TTabSheet
          Caption = 'GUI Designer'
          ImageIndex = 21
          object LGridSize: TLabel
            Left = 57
            Top = 94
            Width = 127
            Height = 15
            Caption = 'Grid size in GUI designer'
          end
          object LFrameheight: TLabel
            Left = 16
            Top = 316
            Width = 70
            Height = 15
            Caption = 'Frame height'
          end
          object LFrameWidth: TLabel
            Left = 16
            Top = 284
            Width = 66
            Height = 15
            Caption = 'Frame width'
          end
          object LZoomsteps: TLabel
            Left = 59
            Top = 127
            Width = 87
            Height = 15
            Caption = 'Font zoom steps'
          end
          object LDefault: TLabel
            Left = 178
            Top = 169
            Width = 66
            Height = 15
            Caption = 'Segoe UI 9pt'
          end
          object CBNameFromText: TCheckBox
            Left = 16
            Top = 16
            Width = 349
            Height = 17
            Caption = 'Name GUI components after attribute Text'
            TabOrder = 0
          end
          object CBGuiDesignerHints: TCheckBox
            Left = 16
            Top = 40
            Width = 349
            Height = 17
            Caption = 'Show hints permanently in GUI designer'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object CBSnapToGrid: TCheckBox
            Left = 16
            Top = 64
            Width = 349
            Height = 17
            Caption = 'Snap to grid'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object EGridSize: TEdit
            Left = 16
            Top = 90
            Width = 21
            Height = 23
            TabOrder = 3
            Text = '8'
          end
          object UDGridSize: TUpDown
            Left = 37
            Top = 90
            Width = 16
            Height = 23
            Associate = EGridSize
            Min = 2
            Max = 60
            Position = 8
            TabOrder = 4
          end
          object EFrameheight: TEdit
            Left = 88
            Top = 313
            Width = 41
            Height = 23
            TabOrder = 5
            Text = '300'
          end
          object EFrameWidth: TEdit
            Left = 88
            Top = 281
            Width = 41
            Height = 23
            TabOrder = 6
            Text = '300'
          end
          object BGuiFont: TButton
            Left = 16
            Top = 165
            Width = 75
            Height = 25
            Caption = 'Font'
            TabOrder = 7
            OnClick = BGuiFontClick
          end
          object EZoomSteps: TEdit
            Left = 16
            Top = 124
            Width = 21
            Height = 23
            TabOrder = 8
            Text = '1'
          end
          object UDZoomSteps: TUpDown
            Left = 37
            Top = 124
            Width = 16
            Height = 23
            Associate = EZoomSteps
            Min = 1
            Max = 5
            Position = 1
            TabOrder = 9
          end
          object BGuiFontDefault: TButton
            Left = 97
            Top = 165
            Width = 75
            Height = 25
            Caption = 'Default'
            TabOrder = 10
            OnClick = BGuiFontDefaultClick
          end
        end
        object PStructogram: TTabSheet
          Caption = 'Structogram'
          object LInput: TLabel
            Left = 16
            Top = 51
            Width = 28
            Height = 15
            Caption = 'Input'
          end
          object LOutput: TLabel
            Left = 16
            Top = 83
            Width = 38
            Height = 15
            Caption = 'Output'
          end
          object LAlgorithm: TLabel
            Left = 16
            Top = 19
            Width = 54
            Height = 15
            Caption = 'Algorithm'
          end
          object LWhile: TLabel
            Left = 16
            Top = 115
            Width = 28
            Height = 15
            Caption = 'while'
          end
          object LFor: TLabel
            Left = 16
            Top = 147
            Width = 15
            Height = 15
            Caption = 'for'
          end
          object LYes: TLabel
            Left = 57
            Top = 179
            Width = 17
            Height = 15
            Caption = 'Yes'
          end
          object LNo: TLabel
            Left = 57
            Top = 211
            Width = 16
            Height = 15
            Caption = 'No'
          end
          object LDatatype: TLabel
            Left = 273
            Top = 19
            Width = 47
            Height = 15
            Caption = 'Datatype'
          end
          object LCaseCount: TLabel
            Left = 537
            Top = 179
            Width = 89
            Height = 15
            Caption = 'Number of cases'
          end
          object LOther: TLabel
            Left = 57
            Top = 243
            Width = 20
            Height = 15
            Caption = 'Else'
          end
          object LStructogramShadow: TLabel
            Left = 493
            Top = 19
            Width = 42
            Height = 15
            Caption = 'Shadow'
          end
          object LStructogramShadowWidth: TLabel
            Left = 546
            Top = 39
            Width = 32
            Height = 15
            Caption = 'Width'
          end
          object LStructogramShadowIntensity: TLabel
            Left = 546
            Top = 66
            Width = 45
            Height = 15
            Caption = 'Intensity'
          end
          object LIf: TLabel
            Left = 16
            Top = 179
            Width = 7
            Height = 15
            Caption = 'if'
          end
          object EInput: TEdit
            Left = 90
            Top = 48
            Width = 140
            Height = 23
            TabOrder = 1
            Text = 'Input:'
          end
          object EOutput: TEdit
            Left = 90
            Top = 80
            Width = 140
            Height = 23
            TabOrder = 2
            Text = 'Output:'
          end
          object EAlgorithm: TEdit
            Left = 90
            Top = 16
            Width = 140
            Height = 23
            TabOrder = 0
            Text = 'Algorithm'
          end
          object EWhile: TEdit
            Left = 90
            Top = 112
            Width = 140
            Height = 23
            TabOrder = 3
            Text = 'repeat while'
          end
          object EFor: TEdit
            Left = 90
            Top = 144
            Width = 140
            Height = 23
            TabOrder = 4
            Text = 'for item in list'
          end
          object EYes: TEdit
            Left = 90
            Top = 176
            Width = 140
            Height = 23
            TabOrder = 5
            Text = 'yes'
          end
          object ENo: TEdit
            Left = 90
            Top = 208
            Width = 140
            Height = 23
            TabOrder = 6
            Text = 'no'
          end
          object CBDataType: TComboBox
            Left = 275
            Top = 38
            Width = 140
            Height = 23
            AutoComplete = False
            AutoDropDown = True
            Sorted = True
            TabOrder = 8
            Items.Strings = (
              ''
              'bool'
              'float'
              'int'
              'long'
              'str')
          end
          object CBSwitchWithCaseLine: TCheckBox
            Left = 275
            Top = 180
            Width = 166
            Height = 17
            Caption = 'Selection with case line'
            TabOrder = 9
          end
          object UpDowncaseCount: TUpDown
            Left = 513
            Top = 176
            Width = 16
            Height = 23
            Associate = ECaseCount
            Max = 10
            Position = 4
            TabOrder = 13
          end
          object ECaseCount: TEdit
            Left = 493
            Top = 176
            Width = 20
            Height = 23
            TabOrder = 12
            Text = '4'
          end
          object EOther: TEdit
            Left = 90
            Top = 240
            Width = 140
            Height = 23
            TabOrder = 7
            Text = 'else'
          end
          object EStructogramShadowWidth: TEdit
            Left = 495
            Top = 36
            Width = 27
            Height = 23
            TabOrder = 10
            Text = '3'
          end
          object UDStructogramShadowWidth: TUpDown
            Left = 522
            Top = 36
            Width = 16
            Height = 23
            Associate = EStructogramShadowWidth
            Position = 3
            TabOrder = 14
          end
          object EStructogramShadowIntensity: TEdit
            Left = 495
            Top = 63
            Width = 27
            Height = 23
            TabOrder = 11
            Text = '0'
          end
          object UDStructogramShadowIntensity: TUpDown
            Left = 522
            Top = 63
            Width = 16
            Height = 23
            Associate = EStructogramShadowIntensity
            Max = 10
            TabOrder = 15
          end
        end
        object PSequencediagram: TTabSheet
          Caption = 'Sequence diagram'
          object LSDObject: TLabel
            Left = 16
            Top = 20
            Width = 35
            Height = 15
            Caption = 'Object'
          end
          object LSDNew: TLabel
            Left = 16
            Top = 52
            Width = 24
            Height = 15
            Caption = 'New'
          end
          object LSDClose: TLabel
            Left = 16
            Top = 84
            Width = 29
            Height = 15
            Caption = 'Close'
          end
          object LSDFilling: TLabel
            Left = 286
            Top = 20
            Width = 32
            Height = 15
            Caption = 'Filling'
          end
          object ESDObject: TEdit
            Left = 90
            Top = 16
            Width = 140
            Height = 23
            TabOrder = 0
            Text = 'Object'
          end
          object ESDNew: TEdit
            Left = 90
            Top = 48
            Width = 140
            Height = 23
            TabOrder = 1
            Text = 'new'
          end
          object ESDClose: TEdit
            Left = 90
            Top = 80
            Width = 140
            Height = 23
            TabOrder = 2
            Text = 'close'
          end
          object CBSDFillingColor: TColorBox
            Left = 359
            Top = 16
            Width = 145
            Height = 22
            Selected = clYellow
            TabOrder = 3
          end
          object CBSDShowMainCall: TCheckBox
            Left = 16
            Top = 116
            Width = 145
            Height = 17
            Caption = 'Show main call'
            TabOrder = 4
          end
          object CBSDShowParameter: TCheckBox
            Left = 16
            Top = 140
            Width = 153
            Height = 17
            Caption = 'Show parameter'
            TabOrder = 5
          end
          object CBSDShowReturn: TCheckBox
            Left = 16
            Top = 164
            Width = 153
            Height = 17
            Caption = 'Show return'
            TabOrder = 6
          end
          object CBSDNoFilling: TCheckBox
            Left = 359
            Top = 44
            Width = 97
            Height = 17
            Caption = 'no'
            TabOrder = 7
          end
        end
        object PUML: TTabSheet
          Caption = 'UML Design'
          object LObjectDesign: TLabel
            Left = 16
            Top = 95
            Width = 93
            Height = 15
            Caption = 'Design of Objects'
          end
          object LClassDesign: TLabel
            Left = 16
            Top = 15
            Width = 91
            Height = 15
            Caption = 'Design of Classes'
          end
          object LValidClassColor: TLabel
            Left = 24
            Top = 38
            Width = 53
            Height = 15
            Caption = 'valid class'
          end
          object LShadowWidth: TLabel
            Left = 514
            Top = 45
            Width = 32
            Height = 15
            Caption = 'Width'
          end
          object LShadowIntensity: TLabel
            Left = 514
            Top = 72
            Width = 45
            Height = 15
            Caption = 'Intensity'
          end
          object LInvalidClassColor: TLabel
            Left = 170
            Top = 38
            Width = 63
            Height = 15
            Caption = 'invalid class'
          end
          object LShadow: TLabel
            Left = 461
            Top = 20
            Width = 42
            Height = 15
            Caption = 'Shadow'
          end
          object LObjectColor: TLabel
            Left = 24
            Top = 120
            Width = 29
            Height = 15
            Caption = 'Color'
          end
          object LCommentDesign: TLabel
            Left = 16
            Top = 172
            Width = 112
            Height = 15
            Caption = 'Design of Comments'
          end
          object LAttributesAndMethods: TLabel
            Left = 16
            Top = 230
            Width = 125
            Height = 15
            Caption = 'Attributes and Methods'
          end
          object RGObjectHead: TRadioGroup
            Left = 170
            Top = 124
            Width = 125
            Height = 65
            Caption = 'Head'
            ItemIndex = 0
            Items.Strings = (
              'rectangular'
              'rounded')
            TabOrder = 0
          end
          object CBObjectColor: TColorBox
            Left = 24
            Top = 140
            Width = 125
            Height = 22
            Selected = clYellow
            TabOrder = 1
          end
          object RGObjectCaption: TRadioGroup
            Left = 459
            Top = 124
            Width = 144
            Height = 103
            Caption = 'Labeling'
            ItemIndex = 0
            Items.Strings = (
              'Object: Class'
              'Object'
              ': Class'
              '')
            TabOrder = 2
          end
          object CBObjectUnderline: TCheckBox
            Left = 467
            Top = 202
            Width = 110
            Height = 17
            Caption = 'Underlined'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object RGClassHead: TRadioGroup
            Left = 317
            Top = 28
            Width = 125
            Height = 65
            Caption = 'Head'
            ItemIndex = 0
            Items.Strings = (
              'rectangular'
              'rounded')
            TabOrder = 4
          end
          object CBValidClassColor: TColorBox
            Left = 24
            Top = 57
            Width = 125
            Height = 22
            Selected = clWhite
            TabOrder = 5
          end
          object EShadowWidth: TEdit
            Left = 463
            Top = 42
            Width = 27
            Height = 23
            TabOrder = 6
            Text = '3'
          end
          object UDShadowWidth: TUpDown
            Left = 490
            Top = 42
            Width = 16
            Height = 23
            Associate = EShadowWidth
            Position = 3
            TabOrder = 7
          end
          object UDShadowIntensity: TUpDown
            Left = 490
            Top = 69
            Width = 16
            Height = 23
            Associate = EShadowIntensity
            Max = 10
            TabOrder = 8
          end
          object EShadowIntensity: TEdit
            Left = 463
            Top = 69
            Width = 27
            Height = 23
            TabOrder = 9
            Text = '0'
          end
          object CBInvalidClassColor: TColorBox
            Left = 170
            Top = 57
            Width = 125
            Height = 22
            Selected = clWhite
            TabOrder = 10
          end
          object RGObjectFooter: TRadioGroup
            Left = 317
            Top = 124
            Width = 125
            Height = 65
            Caption = 'Foot'
            ItemIndex = 0
            Items.Strings = (
              'rectangular'
              'rounded')
            TabOrder = 11
          end
          object CBCommentColor: TColorBox
            Left = 24
            Top = 197
            Width = 125
            Height = 22
            Selected = clSkyBlue
            TabOrder = 12
          end
          object RGAttributsMethodsDisplay: TRadioGroup
            Left = 24
            Top = 250
            Width = 113
            Height = 103
            Caption = 'Show'
            Items.Strings = (
              'not any'
              'public'
              'protected'
              'all')
            TabOrder = 13
          end
          object RGSequenceAttributsMethods: TRadioGroup
            Left = 154
            Top = 249
            Width = 103
            Height = 83
            Caption = 'Order'
            Items.Strings = (
              'Sourcecode'
              'Visibility'
              'Alphabetical')
            TabOrder = 14
          end
          object RGParameterDisplay: TRadioGroup
            Left = 278
            Top = 249
            Width = 164
            Height = 144
            Caption = 'Parameter'
            Items.Strings = (
              'none'
              ': type'
              '(...): type'
              '(name): type'
              '(name = value): type'
              '(name: type = value): type')
            TabOrder = 15
          end
          object RGVisibilityDisplay: TRadioGroup
            Left = 459
            Top = 250
            Width = 144
            Height = 83
            Caption = 'Visibility'
            Items.Strings = (
              'no'
              'Text'
              'Icons')
            TabOrder = 16
          end
        end
        object PUML2: TTabSheet
          Caption = 'UML Options'
          object GBClassPresentation: TGroupBox
            Left = 16
            Top = 20
            Width = 300
            Height = 189
            Caption = 'Class representation'
            TabOrder = 0
            object CBShowEmptyRects: TCheckBox
              Left = 12
              Top = 24
              Width = 300
              Height = 17
              Caption = 'show empty attribute and method rectangles'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object CBIntegerInsteadofInt: TCheckBox
              Left = 12
              Top = 47
              Width = 269
              Height = 17
              Caption = 'Integer instead of int'
              TabOrder = 1
            end
            object CBShowClassparameterSeparately: TCheckBox
              Left = 12
              Top = 116
              Width = 283
              Height = 17
              Caption = 'Display class parameters separately'
              TabOrder = 2
            end
            object CBRoleHidesAttribute: TCheckBox
              Left = 12
              Top = 139
              Width = 221
              Height = 17
              Caption = 'Role hides attribute'
              TabOrder = 3
            end
            object CBConstructorWithVisibility: TCheckBox
              Left = 12
              Top = 70
              Width = 281
              Height = 17
              Caption = 'Show constructor with visibility'
              TabOrder = 4
            end
            object CBRelationshipAttributesBold: TCheckBox
              Left = 12
              Top = 93
              Width = 278
              Height = 17
              Caption = 'Relationship attributes in bold'
              TabOrder = 5
            end
            object CBClassnameInUppercase: TCheckBox
              Left = 12
              Top = 162
              Width = 221
              Height = 17
              Caption = 'Class name in uppercase'
              TabOrder = 6
            end
          end
          object GBObjectPresentation: TGroupBox
            Left = 334
            Top = 20
            Width = 300
            Height = 189
            Caption = 'Object representation'
            TabOrder = 1
            object CBShowObjectsWithMethods: TCheckBox
              Left = 12
              Top = 47
              Width = 287
              Height = 17
              Caption = 'show with methods'
              TabOrder = 0
            end
            object CBShowObjectsWithInheritedPrivateAttributes: TCheckBox
              Left = 12
              Top = 24
              Width = 289
              Height = 17
              Caption = 'show with inherited private attributes'
              TabOrder = 1
            end
            object CBShowAllNewObjects: TCheckBox
              Left = 12
              Top = 93
              Width = 279
              Height = 17
              Caption = 'show all new objects'
              TabOrder = 2
            end
            object CBLowerCaseLetter: TCheckBox
              Left = 12
              Top = 70
              Width = 279
              Height = 17
              Caption = 'start names with lowercase letters'
              TabOrder = 3
            end
            object CBObjectsWithoutVisibility: TCheckBox
              Left = 12
              Top = 116
              Width = 229
              Height = 17
              Caption = 'without visibility'
              TabOrder = 4
            end
          end
          object GBClassEditing: TGroupBox
            Left = 16
            Top = 226
            Width = 300
            Height = 71
            Caption = 'Class editing'
            TabOrder = 2
            object CBOpenPublicClasses: TCheckBox
              Left = 12
              Top = 47
              Width = 269
              Height = 17
              Caption = 'only open public classes'
              TabOrder = 0
            end
            object CBDefaultModifiers: TCheckBox
              Left = 12
              Top = 24
              Width = 306
              Height = 17
              Caption = 'Standard modifiers for attributes and methods'
              Checked = True
              State = cbChecked
              TabOrder = 1
            end
          end
          object GBObjectEditing: TGroupBox
            Left = 338
            Top = 226
            Width = 300
            Height = 71
            Caption = 'Object editing'
            TabOrder = 3
            object CBUMLEdit: TCheckBox
              Left = 12
              Top = 24
              Width = 279
              Height = 17
              Caption = 'private attributes editable'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
          end
        end
        object PIDEShortcuts: TTabSheet
          Caption = 'IDE Shortcuts'
          ImageIndex = 27
          DesignSize = (
            633
            402)
          object lblAssignedTo: TLabel
            Left = 10
            Top = 270
            Width = 73
            Height = 15
            Caption = 'lblAssignedTo'
            Color = clNone
            ParentColor = False
            Visible = False
          end
          object lblCurrent: TLabel
            Left = 10
            Top = 251
            Width = 115
            Height = 15
            Caption = 'Currently assigned to:'
            Color = clNone
            ParentColor = False
            Visible = False
          end
          object lblCurrentKeys: TLabel
            Left = 224
            Top = 205
            Width = 70
            Height = 15
            Caption = 'C&urrent Keys:'
            Color = clNone
            ParentColor = False
          end
          object lblNewShortcutKey: TLabel
            Left = 10
            Top = 205
            Width = 123
            Height = 15
            Caption = 'Press &new shortcut key:'
            Color = clNone
            ParentColor = False
          end
          object lblCommands: TLabel
            Left = 224
            Top = 9
            Width = 65
            Height = 15
            Caption = 'C&ommands:'
            Color = clNone
            ParentColor = False
          end
          object lblCategories: TLabel
            Left = 10
            Top = 9
            Width = 59
            Height = 15
            Caption = '&Categories:'
            Color = clNone
            ParentColor = False
          end
          object btnRemove: TButton
            Left = 224
            Top = 289
            Width = 97
            Height = 25
            Action = actRemoveShortcut
            TabOrder = 0
          end
          object btnAssign: TButton
            Left = 10
            Top = 289
            Width = 107
            Height = 25
            Action = actAssignShortcut
            TabOrder = 1
          end
          object lbCurrentKeys: TListBox
            Left = 224
            Top = 226
            Width = 245
            Height = 57
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 15
            TabOrder = 2
          end
          object lbCategories: TListBox
            Left = 10
            Top = 28
            Width = 184
            Height = 97
            ItemHeight = 15
            TabOrder = 3
            OnClick = lbCategoriesClick
          end
          object lbCommands: TListBox
            Left = 224
            Top = 28
            Width = 245
            Height = 97
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 15
            Sorted = True
            TabOrder = 4
            OnClick = lbCommandsClick
          end
          object gbDescription: TGroupBox
            Left = 3
            Top = 131
            Width = 466
            Height = 61
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Description'
            TabOrder = 5
            object lblDescription: TLabel
              Left = 2
              Top = 17
              Width = 462
              Height = 42
              Align = alClient
              AutoSize = False
              Color = clNone
              ParentColor = False
              Transparent = True
              ExplicitTop = 15
              ExplicitWidth = 460
              ExplicitHeight = 44
            end
          end
        end
        object PBrowser: TTabSheet
          Caption = 'Browser'
          ImageIndex = 29
          object LBrowser: TLabel
            Left = 24
            Top = 84
            Width = 87
            Height = 15
            Caption = 'External browser'
          end
          object LBrowserTitle: TLabel
            Left = 24
            Top = 116
            Width = 65
            Height = 15
            Caption = 'Browser title'
          end
          object LAltKeysBrowser: TLabel
            Left = 24
            Top = 148
            Width = 237
            Height = 15
            Caption = 'Keystrokes for "Open address" in the browser'
          end
          object CBUseIEinternForDocuments: TCheckBox
            Left = 24
            Top = 24
            Width = 353
            Height = 17
            Caption = 'use Internet Explorer internally for documents'
            TabOrder = 0
          end
          object CBOnlyOneBrowserWindow: TCheckBox
            Left = 24
            Top = 47
            Width = 249
            Height = 17
            Caption = 'only use one browser window'
            TabOrder = 1
          end
          object EBrowserProgram: TEdit
            Left = 120
            Top = 80
            Width = 330
            Height = 23
            TabOrder = 2
          end
          object EBrowserTitle: TEdit
            Left = 120
            Top = 112
            Width = 330
            Height = 23
            TabOrder = 3
          end
          object CBOpenBrowserShortcut: TComboBox
            Left = 289
            Top = 145
            Width = 161
            Height = 23
            TabOrder = 4
          end
          object BSelectBrowser: TButton
            Left = 470
            Top = 80
            Width = 75
            Height = 23
            Caption = 'Select'
            TabOrder = 5
            OnClick = BSelectBrowserClick
          end
          object BBrowserTitle: TButton
            Left = 470
            Top = 109
            Width = 75
            Height = 23
            Caption = 'Default'
            TabOrder = 6
            OnClick = BBrowserTitleClick
          end
        end
        object PLanguage: TTabSheet
          Caption = 'Language'
          object RGLanguages: TRadioGroup
            Left = 16
            Top = 2
            Width = 297
            Height = 425
            Caption = 'Languages'
            TabOrder = 0
          end
        end
        object PGeneralOptions: TTabSheet
          Caption = 'Options'
          object LTempFolder: TLabel
            Left = 16
            Top = 333
            Width = 133
            Height = 15
            Caption = 'Folder for temporary files'
          end
          object SBTempSelect: TSpeedButton
            Tag = 7
            Left = 449
            Top = 357
            Width = 21
            Height = 19
            Flat = True
            Glyph.Data = {
              7E030000424D7E030000000000003600000028000000120000000F0000000100
              18000000000048030000880B0000880B000000000000000000005D5DC15D5DC1
              5D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5D
              C15D5DC15D5DC15D5DC15D5DC15D5DC16F725D5DC10000000000000000000000
              000000000000000000000000000000000000000000005D5DC15D5DC15D5DC15D
              5DC15D5DC15D5DC16F725D5DC100000000000000787800787800787800787800
              78780078780078780078780078780000005D5DC15D5DC15D5DC15D5DC15D5DC1
              6F725D5DC100000000FFFF000000007878007878007878007878007878007878
              0078780078780078780000005D5DC15D5DC15D5DC15D5DC16F725D5DC1000000
              FFFFFF00FFFF0000000078780078780078780078780078780078780078780078
              780078780000005D5DC15D5DC15D5DC16F725D5DC100000000FFFFFFFFFF00FF
              FF00000000787800787800787800787800787800787800787800787800787800
              00005D5DC15D5DC16F725D5DC1000000FFFFFF00FFFFFFFFFF00FFFF00000000
              00000000000000000000000000000000000000000000000000000000005D5DC1
              6F725D5DC100000000FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF
              00FFFF0000005D5DC15D5DC15D5DC15D5DC15D5DC15D5DC16F725D5DC1000000
              FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF0000005D5D
              C15D5DC15D5DC15D5DC15D5DC15D5DC16F725D5DC100000000FFFFFFFFFF00FF
              FF0000000000000000000000000000000000000000005D5DC15D5DC15D5DC15D
              5DC15D5DC15D5DC16F725D5DC15D5DC10000000000000000005D5DC15D5DC15D
              5DC15D5DC15D5DC15D5DC15D5DC15D5DC10000000000000000005D5DC15D5DC1
              6F725D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC1
              5D5DC15D5DC15D5DC15D5DC10000000000005D5DC15D5DC16F725D5DC15D5DC1
              5D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC10000005D5DC15D5DC15D5D
              C10000005D5DC10000005D5DC15D5DC16F725D5DC15D5DC15D5DC15D5DC15D5D
              C15D5DC15D5DC15D5DC15D5DC15D5DC10000000000000000005D5DC15D5DC15D
              5DC15D5DC15D5DC16F725D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D
              5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC15D5DC1
              6F72}
            OnClick = SBTempSelectClick
          end
          object LNoOfRecentFiles: TLabel
            Left = 355
            Top = 46
            Width = 118
            Height = 15
            Caption = 'Number of recent files'
          end
          object LDaysBetweenUpdateChecks: TLabel
            Left = 355
            Top = 16
            Width = 152
            Height = 15
            Caption = 'Days between update checks'
          end
          object LDockAnimationInterval: TLabel
            Left = 355
            Top = 76
            Width = 126
            Height = 15
            Caption = 'Dock animation interval'
          end
          object LDockAnimationMoveWidth: TLabel
            Left = 355
            Top = 106
            Width = 150
            Height = 15
            Caption = 'Dock animation move width'
          end
          object LIDEFontSize: TLabel
            Left = 355
            Top = 136
            Width = 64
            Height = 15
            Caption = 'IDE font size'
          end
          object ETempFolder: TEdit
            Left = 33
            Top = 357
            Width = 412
            Height = 23
            TabOrder = 0
          end
          object BTempFolder: TButton
            Left = 476
            Top = 356
            Width = 85
            Height = 23
            Caption = 'Default'
            TabOrder = 1
            OnClick = BTempFolderClick
          end
          object ENoOfRecentFiles: TEdit
            Left = 310
            Top = 43
            Width = 24
            Height = 23
            TabOrder = 2
            Text = '9'
          end
          object UDNoOfRecentFiles: TUpDown
            Left = 334
            Top = 43
            Width = 16
            Height = 23
            Associate = ENoOfRecentFiles
            Max = 20
            Position = 9
            TabOrder = 3
          end
          object CBRestoreOpenFiles: TCheckBox
            Left = 16
            Top = 40
            Width = 260
            Height = 17
            Caption = 'Restore open files'
            TabOrder = 4
          end
          object CBRestoreOpenProject: TCheckBox
            Left = 16
            Top = 64
            Width = 260
            Height = 17
            Caption = 'Restore open project'
            TabOrder = 5
          end
          object CBShowTabCloseButton: TCheckBox
            Left = 16
            Top = 88
            Width = 260
            Height = 17
            Caption = 'Show tab close button'
            TabOrder = 6
          end
          object CBSmartNextPrevPage: TCheckBox
            Left = 16
            Top = 112
            Width = 260
            Height = 17
            Caption = 'Smart next prev page'
            TabOrder = 7
          end
          object CBStyleMainWindowBorder: TCheckBox
            Left = 16
            Top = 136
            Width = 260
            Height = 17
            Caption = 'Style main window border'
            TabOrder = 8
          end
          object CBAutoCheckForUpdates: TCheckBox
            Left = 16
            Top = 280
            Width = 268
            Height = 17
            Caption = 'Check for updates automaticallly'
            TabOrder = 9
          end
          object EDaysBetweenChecks: TEdit
            Left = 310
            Top = 13
            Width = 24
            Height = 23
            TabOrder = 10
            Text = '0'
          end
          object UDDaysBetweenChecks: TUpDown
            Left = 334
            Top = 13
            Width = 16
            Height = 23
            Associate = EDaysBetweenChecks
            TabOrder = 11
          end
          object EDockAnimationInterval: TEdit
            Left = 310
            Top = 73
            Width = 24
            Height = 23
            TabOrder = 12
            Text = '0'
          end
          object UDDockAnimationInterval: TUpDown
            Left = 334
            Top = 73
            Width = 16
            Height = 23
            Associate = EDockAnimationInterval
            TabOrder = 13
          end
          object UDDockAnimationMoveWidth: TUpDown
            Left = 334
            Top = 103
            Width = 16
            Height = 23
            Associate = EDockAnimationMoveWidth
            TabOrder = 14
          end
          object EDockAnimationMoveWidth: TEdit
            Left = 310
            Top = 103
            Width = 24
            Height = 23
            TabOrder = 15
            Text = '0'
          end
          object RGEditorTabPosition: TRadioGroup
            Left = 310
            Top = 187
            Width = 133
            Height = 62
            Caption = 'Editor tab position'
            Items.Strings = (
              'Top'
              'Bottom')
            TabOrder = 16
          end
          object CBExporerInitiallyExpanded: TCheckBox
            Left = 16
            Top = 160
            Width = 260
            Height = 17
            Caption = 'File explorer initially expanded'
            TabOrder = 17
          end
          object CBProjectExporerInitiallyExpanded: TCheckBox
            Left = 16
            Top = 208
            Width = 260
            Height = 17
            Caption = 'Project explorer initially expanded'
            TabOrder = 18
          end
          object CBFileExplorerContextMenu: TCheckBox
            Left = 16
            Top = 184
            Width = 260
            Height = 17
            Caption = 'File explorer context menu'
            TabOrder = 19
          end
          object CBFileExplorerBackgroundProcessing: TCheckBox
            Left = 16
            Top = 232
            Width = 249
            Height = 17
            Caption = 'File explorer background processing'
            TabOrder = 20
          end
          object RGFileChangeNotification: TRadioGroup
            Left = 449
            Top = 187
            Width = 185
            Height = 85
            Caption = 'File change notification'
            Items.Strings = (
              'Full'
              'No mapped files'
              'Disabled')
            TabOrder = 21
          end
          object CBMethodsWithComment: TCheckBox
            Left = 16
            Top = 256
            Width = 201
            Height = 17
            Caption = 'Methods with comment'
            TabOrder = 22
          end
          object CBSaveFilesAutomatically: TCheckBox
            Left = 16
            Top = 16
            Width = 268
            Height = 17
            Caption = 'Save files automatically when closing'
            TabOrder = 23
          end
          object UDIDEFontSize: TUpDown
            Left = 334
            Top = 133
            Width = 16
            Height = 23
            Associate = EIDEFontSize
            Position = 9
            TabOrder = 24
          end
          object EIDEFontSize: TEdit
            Left = 310
            Top = 133
            Width = 24
            Height = 23
            TabOrder = 25
            Text = '9'
          end
        end
        object PStyles: TTabSheet
          Caption = 'Styles'
          ImageIndex = 30
          object Label43: TLabel
            Left = 255
            Top = 8
            Width = 41
            Height = 15
            Caption = 'Preview'
          end
          object Label44: TLabel
            Left = 8
            Top = 8
            Width = 81
            Height = 15
            Caption = 'Available Styles'
          end
          object StylesPreviewPanel: TPanel
            Left = 255
            Top = 27
            Width = 390
            Height = 365
            TabOrder = 0
          end
          object LBStyleNames: TListBox
            Left = 8
            Top = 27
            Width = 241
            Height = 365
            ItemHeight = 15
            TabOrder = 1
            OnClick = LBStyleNamesClick
            OnDblClick = ActionApplyStyleExecute
          end
          object BApplyStyle: TButton
            Left = 56
            Top = 398
            Width = 140
            Height = 25
            Caption = 'Apply Style'
            TabOrder = 2
            OnClick = BApplyStyleClick
          end
        end
        object PPrinter: TTabSheet
          Caption = 'Printer'
          DesignSize = (
            633
            402)
          object Image1: TImage
            Left = 300
            Top = 10
            Width = 223
            Height = 298
            Anchors = [akLeft, akTop, akBottom]
            Picture.Data = {
              07544269746D617036800000424D36800000000000007600000028000000DF00
              0000240100000100040000000000C07F0000C40E0000C40E0000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FFF0F00FF0FF0FF0F
              F0F0000F0FFFF00F000F0FF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FF0FF000FF0F0FF0FF0FF0F0FF0F0FFFF0F0FFFFF00F0FFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FF000FF0F0FF0FF0F
              F0FF000F0FFFF0F0000FF00F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FF0F0F00FF0F0FF0FF0FF0FFFF0F0FFFF0F0FF0FF00F0FFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF00FF0F00FF00000000
              0FF0000F0FFF000F00FF0FF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FF00FF0FFFFFFFFFFFFFFFFFFFFF0FFFF0FFFFFFFFFF0FFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FFF0FFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF00000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFF000000F
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFF00000F
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0000FF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFF000FF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFF99FF9FF9FF99F99FF9F
              F9FF99F99FF90F9FF99F99F99FF9FF99F99F99FF9FF900000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFF99F99FF9FF9FF99F99FF9FF9FF99F99099FF9FF99F99F99FF9F
              F99F99F99FF9FF9FF99F99FF9FF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFF0FF
              F0FF000F0000FF000FF000F0FFFF00FF000F0FF000FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9F0FFF0F0FFFF0FF0F0FF0F0FFFF0FFFF0FF0
              FFFFF00F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF00FF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF
              F0F0000FF000F0FF0F0000F0FFFF0FF0000FF00F0FFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFFFF00000F0FF0FFFF0F0FF0F0FF0F0FFFF0FF0
              FF0FF00F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFF000FF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9F0FF
              F0FF00FF0000FF000FF00FF000F000FF00FF0FF000FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF9F0FFF0FFFFFFFFFFFFFF0FFFFFFFFFFF0FFF
              FFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFF0FFF0FF00000
              00FF000FF000F0FFFFFFFFFFFFF0FFFFFFF0FFFFFFFF0000000FFFFFFFF0000F
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF
              F0FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFF0FFF0F0FFF0FF0F0FF0F0FFFF0FFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFF0FFFFFFFFFF00000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFF0FFF0F0000F0
              00F0FF0F0000F0FFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFF0FFFFFFFFFF000000
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFF00000F0FF0FFF0F0FF0F0FF0F0FFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFF0FFFFFFFFFF000000FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFF0FFF0FF00F00
              00FF000FF00FF000FFFFFFFFFFF0FFFFFFF0FFFFFFFF0000000FFFFFF0000000
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFF0FFF0FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFF0FFF0FFFFFFF
              FFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFF0000000FFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFF0FF0FFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFF0FF0FFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFF0000000FFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFF00000FFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFF0FFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFF0000FFFFFFFFFFFFF
              FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000FFFF
              FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF000000FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0F0F0FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF00F0FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF00000FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF9FFFFFFFFFFFFFFF9FFFF
              FFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F0000000FFFFFFFFFFFFFFFFFFF9FFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF0000FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000FFFFFFFFFFFFFFFF00000
              000000F00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F00000000FF9FFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FF00FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFF9FFFFFFFFFFFFFFF9FFFF
              F00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0F0F0FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000F000FF000FF0FFF0F0FFFFFF0F
              FF000F0FF000FF0F0FF0FF000FF000F0FF0F00FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFF
              FF0FFF0FFFFF00FFF0FFF0F0FFFFFF0FF0FFFFF00F0FFF0F0FF0F0FF0F0FFFF0
              FF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFF0FFF0000FF00FFF0FFF0F0FFFFFF0F
              F0000FF00F0FFF0F0FF0F0FF0F0000F0FF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF00FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF0FFF0FF0FF00FFF00000F000FFFF0FF0FF0FF00F0FFF0F0FF0F0FF0F0FF0F0
              FF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFF0FFFF00FF0000FF0FFF0F0FFFFFF0F
              FF00FF0FF000FF0F000FFF000FF00FF000F000FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFF0FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFF
              FF0FFFFFFFFF00FFF0FFF0F0FFFFFF0FFFFFFFFFFF0FFF0FFFFFFFFF0FFFFFFF
              FFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFF0FFF0F0000F0000
              0FFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF00FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF9FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FF00FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0F0F0FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF000F0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0FFF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFF0F0FFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFF0F00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
              0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF0000FFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF
              FFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              000F0FF000FF000FF000FFFF000FF0FF0F0FF0F000F0FF0FF000FFFFF0F0FF0F
              00F0FF0FFF0FF0FF0F0F0FF0FFF00FF0FFF000FF000FFFF0FF0FF00000F0FFF0
              00F0F0FF0F000FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF00F0FF0F0FFFF0FF0FFFF0FF0F0FF
              0F0FF0F0F0F0FF0F0FF0FFFF0F0F0F0F0FF0FF0FFF0FF0FF0F0F0FF0FF0FF0F0
              FF0FFFF0FF0FFFF0FF0FF00FF0F0FF0FF0F0F0FF0FFFF0FFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF00F
              F00F0F0FF0F0000F0FF0FFFF0FF0F0FF0F0FF0F0F0F0FF0F0FF0FFFF0F0F0F0F
              0FF0FF0FFF0FF0FF0F0F0FF0FF0FF0F0FF0000F0FF0FFFF0FF0FF0F000F0FF0F
              F0F0F0FF0FF00FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0FFF0F0FF0F0FF0F0FF0FFFF0FF0F0FF
              0F0FF0F0F0F0FF0F0FF0FFFF0F0F0F0F0FF0FF0FFF0FF0FF0F0F0FF0FF0FF0F0
              FF0FF0F0FF0FFFF0FF0FF0FFF0F0FF0FF0F0F0FF0F0FFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              F0000FF000FF00FFF000FFFF000FF0000F000F0000F000FFF000FFFF0F0F0F00
              00F000FFFF000000FF0F000000F00FF000F00FFF000FFFF000000F0000F000F0
              00F0F000FFF000FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFF
              FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFF
              FFFF0FFFF0FFFFFFFFF0FFFFFFFFFFFF0FFFFFFFF0FFFFFFFFFFFFFFFFFFFF0F
              FFF0FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000090000000000000000
              000000000000000000000000000000000000000000000000000000000000FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFF000FFF00FF0000FF00FF0FF0FF0FFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0F0FF0F0F0FF0FF0F0FF0
              FF0FFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFF000FFF00FF00F00F00FF0FF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FF0F0FF0F0F0FF0FF0F0FF0FF0FFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF0FF0F0FF0F0FF0F0FF0F0FF0FF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFF0000F0FF0F0F0FF0FF0F0FF0
              FF0FFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFF0FF0F0FF0F0FF0F0FF0F0FF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FF0FF00F00000FF00FF000000FFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF0000F0FF0F0FF0F0FF0F0FF0FF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFF0F0FFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFF0FF0FF00F000000F00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFF0FF0FFFFFF0FF0FFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
              000000000FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF00
              00000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFF00000F
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FF0FFFFF0FF00FFFF00000FF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FF0FFFFF0
              FF00FFF0FFFFF0F9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFF0000000FFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FF0FF0FF0FF00FFF0FFFFF0F9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0000000FFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF0FF0FFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFF0F000F
              FF00FFF0FF0FF0F9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFF0FF0FFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFF0FF0FFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFF0F000FF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0FF0FFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF0FF00FFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFF0000000FFF9FFFF0000F
              FF00FFFFFFFFFFF9FFF0000000FFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFF0FF00FFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFF00FF00FFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFF0FFF9FFFFFFFF0FF00FFFFF0000FF9FFFFFFFFF0FFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF00FF00FFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF0F00000FFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFF9FFFFFFFF0
              FF00FFFFFFFFF0F9FFFFFFFFF0FFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFF0F00000FFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFF0FFF9FFFF00000FF00FFFFFFFFF0F9FFFFFFFFF0FFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF000F0FFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF000FFFF9FFFF0FFFF
              FF00FFFFF00000F9FFFFFF000FFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFF000F0FFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFF0FFF0F0FFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFF0F0F0FFF9FFF000000FF00FFFFF0FFFFF9FFFFF0F0F0FFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFF0F0FFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFF0FFF0F0FFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0F0F0FFF9FFFF0FFF0
              FF00FFFF000000F9FFFFF0F0F0FFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFF0FFF0F0FFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFF000000FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFF00F0FFF9FFF000000FF00FFFFF0FFF0F9FFFFFF00F0FFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF000000FFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFF0FFF0
              FF00FFFF000000F9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFF0000000FFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFF0FFFFFFF9FFFFFFFFFFF00FFFFF0FFF0F9FFFFF0FFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0000000FFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFF0FFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF000000FFF9FFFFF000F
              FF00FFFFFFFFFFF9FFFF000000FFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFF0FFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFF0FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFF0F0FFFFFFF9FFFF0F0F0FF00FFFFFF000FF9FFF0000000FFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0000FFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF000000FFF9FFFF0F0F0
              FF00FFFFF0F0F0F9FFFFF0FFF0FFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFF0000FFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFF0FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFF0FFF0FFF9FFFFF00F0FF00FFFFF0F0F0F9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF000000FFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFF00F0F9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFF000000FFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFF0FFF0FFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFF00000FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFF0FFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFF0FFFF
              FF00FFFFF00000F9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFF0FFFFFF00FFFFF0FFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFF0FFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF0FFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
              000000000FFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFF00
              00000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFF0FFFF00FF000FFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFF0FF0F0FF0FFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFF00FF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFF0FFF0FF0F0FF0FFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FF0F0FF0FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFF0FF0F0FF0FFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FF0FF0F0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFF0FFFF00FF000FFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FF0F0FF0FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFF00FF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFF00FFFFFFFFFFF9FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF
              FF00FFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
              0000000000000000000000900000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000FFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF0000FF000FF00
              0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF0FFFF0000FF000FF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFF0FFFF0FF0F0FF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF0FF0F0FF0F0FFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF000F0FF0F000
              0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF0FFFFF000F0FF0F0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFF0000FFFF0F0FF0F0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF0F0FF0F0FF0FFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0F0000FF000FF00
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF0FF0F0000FF000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFF0FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FF0FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FF
              0FF000F0FF0FFFF0FF0FF000F0FF0FF0000FFF000F0FFF000FF000FFFFFFFFFF
              FFFFFFFFFFFF000FF0FF0FF000FFF0FF000F0FF0FFFF0FF0FF000F0FF0FF0F00
              0FFF000F0FFF000F000FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0F00FFFF0FF0FFFF0FF0F0FF0F0FF0FF0
              0FF0F0FFFF0FF0FFFF0FF0FFFFFFFFFFFFFFFFFFFFF0FFF0F0FF0F0FFFFF0F00
              FFFF0FF0FFFF0FF0F0FF0F0FF0FF0F0FF0F0FFFF0FF0FFF0FF0FFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF0
              F00000F0FF0FFFF0FF0F0FF0F0FF0FF00FF0F0000F0FF0000F0FF0FFFFFFFFFF
              FFFFFFFFFFF0FFF0F0FF0F0000FF0F00000F0FF0FFFF0FF0F0FF0F0FF0FF0F0F
              F0F0000F0FF00000FF0FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF00000F0F00FF0F0FF0FFFF0FF0F0FF0F0FF0FF0
              0FF0F0FF0F0FF0FF0F0FF0FFFFFFFFFFFFFFFFFFFFF0FFF0F0FF0F0FF0FF0F00
              FF0F0FF0FFFF0FF0F0FF0F0FF0FF0F0FF0F0FF0F0FF0FF00FF0FFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF0F
              FF000FF000FFFFF000FF0FF0F000000F000FFF00FF000F00FFF000FFFFFFFFFF
              FFFFFFFFFFF0FFF0F000FFF00FF0FFF000FF000FFFFF000FF0FF0F000000FF00
              0FFF00FF000F00FF000FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFF0FFF0FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF
              FFFFFFFFFFF0FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F
              FFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF0}
            Proportional = True
            Stretch = True
            ExplicitHeight = 292
          end
          object Label26: TLabel
            Left = 10
            Top = 264
            Width = 92
            Height = 15
            Caption = 'Right Text Indent:'
          end
          object Label27: TLabel
            Left = 10
            Top = 239
            Width = 84
            Height = 15
            Caption = 'Left Text Indent:'
          end
          object Label28: TLabel
            Left = 10
            Top = 214
            Width = 84
            Height = 15
            Caption = 'Internal Margin:'
          end
          object Label29: TLabel
            Left = 10
            Top = 189
            Width = 37
            Height = 15
            Caption = 'Footer:'
          end
          object Label30: TLabel
            Left = 10
            Top = 164
            Width = 41
            Height = 15
            Caption = 'Header:'
          end
          object Label31: TLabel
            Left = 10
            Top = 139
            Width = 33
            Height = 15
            Caption = 'Gutter'
          end
          object Label32: TLabel
            Left = 10
            Top = 114
            Width = 43
            Height = 15
            Caption = 'Bottom:'
          end
          object Label33: TLabel
            Left = 10
            Top = 89
            Width = 22
            Height = 15
            Caption = 'Top:'
          end
          object Label34: TLabel
            Left = 10
            Top = 64
            Width = 31
            Height = 15
            Caption = 'Right:'
          end
          object Label35: TLabel
            Left = 10
            Top = 39
            Width = 23
            Height = 15
            Caption = 'Left:'
          end
          object Label36: TLabel
            Left = 10
            Top = 14
            Width = 30
            Height = 15
            Caption = 'Units:'
          end
          object CBUnits: TSpTBXComboBox
            Left = 130
            Top = 10
            Width = 151
            Height = 23
            Style = csDropDownList
            ItemHeight = 15
            TabOrder = 0
            OnChange = CBUnitsChange
            Items.Strings = (
              'mm'
              'cm'
              'Inches'
              '(1/1000) Inches')
          end
          object EditLeft: TEdit
            Left = 130
            Top = 35
            Width = 151
            Height = 23
            TabOrder = 1
          end
          object EditRight: TEdit
            Left = 130
            Top = 60
            Width = 151
            Height = 23
            TabOrder = 2
          end
          object EditTop: TEdit
            Left = 129
            Top = 85
            Width = 151
            Height = 23
            TabOrder = 3
          end
          object EditBottom: TEdit
            Left = 130
            Top = 110
            Width = 151
            Height = 23
            TabOrder = 4
          end
          object EditHeader: TEdit
            Left = 130
            Top = 160
            Width = 151
            Height = 23
            TabOrder = 5
          end
          object EditGutter: TEdit
            Left = 130
            Top = 135
            Width = 151
            Height = 23
            TabOrder = 6
          end
          object EditFooter: TEdit
            Left = 130
            Top = 185
            Width = 151
            Height = 23
            TabOrder = 7
          end
          object EditHFInternalMargin: TEdit
            Left = 130
            Top = 210
            Width = 151
            Height = 23
            TabOrder = 8
          end
          object EditLeftHFTextIndent: TEdit
            Left = 130
            Top = 235
            Width = 151
            Height = 23
            TabOrder = 9
          end
          object EditRightHFTextIndent: TEdit
            Left = 130
            Top = 260
            Width = 151
            Height = 23
            TabOrder = 10
          end
          object CBWrap: TCheckBox
            Left = 220
            Top = 358
            Width = 200
            Height = 21
            Caption = 'Wrap lines'
            TabOrder = 11
          end
          object CBColors: TCheckBox
            Left = 220
            Top = 334
            Width = 200
            Height = 21
            Caption = 'Use colors'
            TabOrder = 12
          end
          object CBHighlight: TCheckBox
            Left = 220
            Top = 310
            Width = 200
            Height = 21
            Caption = 'Syntax print'
            TabOrder = 13
          end
          object CBLineNumbersInMargin: TCheckBox
            Left = 3
            Top = 358
            Width = 200
            Height = 21
            Caption = 'Print line numbers in margin'
            TabOrder = 14
          end
          object CBLineNumbers: TCheckBox
            Left = 3
            Top = 334
            Width = 200
            Height = 21
            Caption = 'Line numbers'
            TabOrder = 15
          end
          object CBMirrorMargins: TCheckBox
            Left = 3
            Top = 310
            Width = 200
            Height = 21
            Caption = 'Mirror margins'
            TabOrder = 16
          end
        end
        object PHeaderFooter: TTabSheet
          Caption = 'Header/Footer'
          ImageIndex = 29
          object GroupBox4: TGroupBox
            Left = 5
            Top = 30
            Width = 611
            Height = 161
            Caption = 'Header'
            TabOrder = 0
            object Label37: TLabel
              Left = 10
              Top = 15
              Width = 20
              Height = 15
              Caption = 'Left'
            end
            object Label38: TLabel
              Left = 210
              Top = 15
              Width = 35
              Height = 15
              Caption = 'Center'
            end
            object Label39: TLabel
              Left = 410
              Top = 15
              Width = 28
              Height = 15
              Caption = 'Right'
            end
            object GroupBox5: TGroupBox
              Left = 10
              Top = 95
              Width = 391
              Height = 61
              Caption = 'Appearance'
              TabOrder = 3
              object PBHeaderLine: TPaintBox
                Left = 96
                Top = 39
                Width = 95
                Height = 12
                OnPaint = PBHeaderLinePaint
              end
              object PBHeaderShadow: TPaintBox
                Left = 281
                Top = 39
                Width = 95
                Height = 12
                OnPaint = PBHeaderLinePaint
              end
              object HeaderLineColorBtn: TButton
                Left = 96
                Top = 10
                Width = 95
                Height = 25
                Caption = 'Line color'
                TabOrder = 3
                OnClick = HeaderLineColorBtnClick
              end
              object HeaderShadowColorBtn: TButton
                Left = 281
                Top = 12
                Width = 96
                Height = 25
                Caption = 'Shadow color'
                TabOrder = 4
                OnClick = HeaderShadowColorBtnClick
              end
              object CBHeaderLine: TCheckBox
                Left = 8
                Top = 19
                Width = 87
                Height = 21
                Caption = 'Line under'
                TabOrder = 0
              end
              object CBHeaderBox: TCheckBox
                Left = 8
                Top = 39
                Width = 87
                Height = 21
                Caption = 'Box'
                TabOrder = 1
              end
              object CBHeaderShadow: TCheckBox
                Left = 209
                Top = 27
                Width = 72
                Height = 21
                Caption = 'Shadow'
                TabOrder = 2
              end
            end
            object CBHeaderMirror: TCheckBox
              Left = 410
              Top = 95
              Width = 191
              Height = 21
              Caption = 'Mirror position'
              TabOrder = 4
            end
            object REHeaderLeft: TRichEdit
              Left = 10
              Top = 32
              Width = 191
              Height = 56
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              WordWrap = False
              OnEnter = REHeaderLeftEnter
              OnSelectionChange = REHeaderLeftSelectionChange
            end
            object REHeaderCenter: TRichEdit
              Left = 210
              Top = 32
              Width = 191
              Height = 56
              Alignment = taCenter
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 1
              WordWrap = False
              OnEnter = REHeaderLeftEnter
              OnSelectionChange = REHeaderLeftSelectionChange
            end
            object REHeaderRight: TRichEdit
              Left = 410
              Top = 32
              Width = 191
              Height = 56
              Alignment = taRightJustify
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 2
              WordWrap = False
              OnEnter = REHeaderLeftEnter
              OnSelectionChange = REHeaderLeftSelectionChange
            end
          end
          object GroupBox6: TGroupBox
            Left = 5
            Top = 200
            Width = 611
            Height = 161
            Caption = 'Footer'
            TabOrder = 1
            object Label40: TLabel
              Left = 10
              Top = 15
              Width = 20
              Height = 15
              Caption = 'Left'
            end
            object Label41: TLabel
              Left = 210
              Top = 15
              Width = 35
              Height = 15
              Caption = 'Center'
            end
            object Label42: TLabel
              Left = 410
              Top = 15
              Width = 28
              Height = 15
              Caption = 'Right'
            end
            object GroupBox7: TGroupBox
              Left = 10
              Top = 92
              Width = 391
              Height = 61
              Caption = 'Appearance'
              TabOrder = 3
              object PBFooterLine: TPaintBox
                Left = 96
                Top = 38
                Width = 95
                Height = 12
                OnPaint = PBHeaderLinePaint
              end
              object PBFooterShadow: TPaintBox
                Left = 281
                Top = 38
                Width = 95
                Height = 12
                OnPaint = PBHeaderLinePaint
              end
              object FooterLineColorBtn: TButton
                Left = 96
                Top = 10
                Width = 95
                Height = 25
                Caption = 'Line color'
                TabOrder = 3
                OnClick = FooterLineColorBtnClick
              end
              object FooterShadowColorBtn: TButton
                Left = 281
                Top = 10
                Width = 96
                Height = 25
                Caption = 'Shadow color'
                TabOrder = 4
                OnClick = FooterShadowColorBtnClick
              end
              object CBFooterLine: TCheckBox
                Left = 8
                Top = 19
                Width = 88
                Height = 21
                Caption = 'Line above'
                TabOrder = 0
              end
              object CBFooterBox: TCheckBox
                Left = 8
                Top = 39
                Width = 82
                Height = 21
                Caption = 'Box'
                TabOrder = 1
              end
              object CBFooterShadow: TCheckBox
                Left = 209
                Top = 24
                Width = 66
                Height = 21
                Caption = 'Shadow'
                TabOrder = 2
              end
            end
            object CBFooterMirror: TCheckBox
              Left = 407
              Top = 94
              Width = 194
              Height = 21
              Caption = 'Mirror position'
              TabOrder = 4
            end
            object REFooterLeft: TRichEdit
              Left = 10
              Top = 32
              Width = 191
              Height = 56
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              WordWrap = False
              OnEnter = REHeaderLeftEnter
              OnSelectionChange = REHeaderLeftSelectionChange
            end
            object REFooterCenter: TRichEdit
              Left = 210
              Top = 32
              Width = 191
              Height = 56
              Alignment = taCenter
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 1
              WordWrap = False
              OnEnter = REHeaderLeftEnter
              OnSelectionChange = REHeaderLeftSelectionChange
            end
            object REFooterRight: TRichEdit
              Left = 410
              Top = 32
              Width = 191
              Height = 56
              Alignment = taRightJustify
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 2
              WordWrap = False
              OnEnter = REHeaderLeftEnter
              OnSelectionChange = REHeaderLeftSelectionChange
            end
          end
          object ToolbarDock: TSpTBXDock
            Left = 0
            Top = 0
            Width = 633
            Height = 26
            AllowDrag = False
            LimitToOneRow = True
            object Toolbar: TSpTBXToolbar
              Left = 0
              Top = 0
              DockMode = dmCannotFloatOrChangeDocks
              DockPos = 1
              FullSize = True
              Images = vilPageSetup
              TabOrder = 0
              Customizable = False
              object tbiPgNumber: TSpTBXItem
                Action = PageNumCmd
              end
              object tbiPages: TSpTBXItem
                Action = PagesCmd
              end
              object tbiTime: TSpTBXItem
                Action = TimeCmd
              end
              object tbiDate: TSpTBXItem
                Action = DateCmd
              end
              object tbiTitle: TSpTBXItem
                Action = TitleCmd
              end
              object SpTBXSeparatorItem2: TSpTBXSeparatorItem
              end
              object tbiFont: TSpTBXItem
                Action = FontCmd
              end
              object SpTBXSeparatorItem1: TSpTBXSeparatorItem
              end
              object tbiBold: TSpTBXItem
                Action = BoldCmd
              end
              object tbiItalic: TSpTBXItem
                Action = ItalicCmd
              end
              object tbiUdnerline: TSpTBXItem
                Action = UnderlineCmd
              end
            end
          end
        end
        object PRestrictions: TTabSheet
          Caption = 'Restrictions'
          object LRestrictions: TLabel
            Left = 16
            Top = 152
            Width = 280
            Height = 13
            Caption = 'Restrictions can only be modified with administrator rights.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CBLockedInternet: TCheckBox
            Left = 16
            Top = 40
            Width = 281
            Height = 17
            Caption = 'Lock internet access'
            TabOrder = 1
          end
          object CBLockedPaths: TCheckBox
            Left = 16
            Top = 64
            Width = 281
            Height = 17
            Caption = 'Lock paths'
            TabOrder = 2
          end
          object CBLockedDosWindow: TCheckBox
            Left = 16
            Top = 17
            Width = 281
            Height = 17
            Caption = 'Deactivate DOS-Window'
            TabOrder = 0
          end
          object CBLockedStructogram: TCheckBox
            Left = 16
            Top = 88
            Width = 305
            Height = 17
            Caption = 'Lock conversion structogram <-> program'
            TabOrder = 3
          end
          object CBUsePredefinedLayouts: TCheckBox
            Left = 16
            Top = 112
            Width = 305
            Height = 17
            Caption = 'Use predefined default and debug layouts'
            TabOrder = 4
          end
        end
        object PAssociations: TTabSheet
          Caption = 'Associations'
          object LAssociations: TLabel
            Left = 16
            Top = 20
            Width = 219
            Height = 15
            Caption = 'Associate these file extensions with GuiPy'
          end
          object LAdditionalAssociations: TLabel
            Left = 16
            Top = 106
            Width = 133
            Height = 15
            Caption = 'Additional file extensions'
          end
          object LAssociationsExample: TLabel
            Left = 160
            Top = 130
            Width = 66
            Height = 15
            Caption = '*.pywd;*.pas'
          end
          object LJEAssociation: TLabel
            Left = 16
            Top = 228
            Width = 109
            Height = 15
            Caption = 'Association of GuiPy'
          end
          object CBAssociationPython: TCheckBox
            Left = 30
            Top = 40
            Width = 60
            Height = 19
            Caption = '.py'
            TabOrder = 0
          end
          object CBAssociationJfm: TCheckBox
            Left = 150
            Top = 40
            Width = 60
            Height = 17
            Caption = '.pfm'
            TabOrder = 1
          end
          object CBAssociationHtml: TCheckBox
            Left = 330
            Top = 66
            Width = 60
            Height = 17
            Caption = '.html'
            TabOrder = 2
          end
          object CBAssociationUml: TCheckBox
            Left = 204
            Top = 39
            Width = 60
            Height = 17
            Caption = '.puml'
            TabOrder = 3
          end
          object CBAssociationTxt: TCheckBox
            Left = 30
            Top = 66
            Width = 60
            Height = 17
            Caption = '.txt'
            TabOrder = 4
          end
          object CBAssociationJsp: TCheckBox
            Left = 90
            Top = 66
            Width = 60
            Height = 17
            Caption = '.jsp'
            TabOrder = 5
          end
          object CBAssociationPhp: TCheckBox
            Left = 150
            Top = 66
            Width = 60
            Height = 17
            Caption = '.php'
            TabOrder = 6
          end
          object CBAssociationCss: TCheckBox
            Left = 210
            Top = 66
            Width = 60
            Height = 17
            Caption = '.css'
            TabOrder = 7
          end
          object EAdditionalAssociations: TEdit
            Left = 30
            Top = 126
            Width = 119
            Height = 23
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
          end
          object CBAssociationInc: TCheckBox
            Left = 270
            Top = 66
            Width = 60
            Height = 17
            Caption = '.inc'
            TabOrder = 9
          end
          object BFileExtensions: TButton
            Left = 16
            Top = 160
            Width = 85
            Height = 25
            Caption = 'Change'
            TabOrder = 10
            OnClick = BFileExtensionsClick
          end
          object EGuiPyAssociation: TEdit
            Left = 30
            Top = 255
            Width = 603
            Height = 23
            TabOrder = 11
          end
          object BJEAssociation: TButton
            Left = 16
            Top = 294
            Width = 85
            Height = 25
            Caption = 'Change'
            TabOrder = 12
            OnClick = BJEAssociationClick
          end
          object CBAssociationJsg: TCheckBox
            Left = 330
            Top = 40
            Width = 60
            Height = 17
            Caption = '.psg'
            TabOrder = 13
          end
          object CBAssociationJSD: TCheckBox
            Left = 270
            Top = 40
            Width = 55
            Height = 17
            Caption = '.psd'
            TabOrder = 14
          end
          object CheckBox1: TCheckBox
            Left = 90
            Top = 40
            Width = 54
            Height = 17
            Caption = '.pyw'
            TabOrder = 15
          end
        end
        object PLLMAssistant: TTabSheet
          Caption = 'LLM Assistant'
          ImageIndex = 32
          object LProvider: TLabel
            Left = 16
            Top = 16
            Width = 44
            Height = 15
            Caption = 'Provider'
          end
          object LEndpoint: TLabel
            Left = 32
            Top = 48
            Width = 48
            Height = 15
            Caption = 'Endpoint'
          end
          object LModel: TLabel
            Left = 32
            Top = 80
            Width = 34
            Height = 15
            Caption = 'Model'
          end
          object LLLMTimeout: TLabel
            Left = 32
            Top = 208
            Width = 103
            Height = 15
            Caption = 'Timeout in seconds'
          end
          object LAPIKey: TLabel
            Left = 32
            Top = 112
            Width = 39
            Height = 15
            Caption = 'API key'
          end
          object LMaxTokens: TLabel
            Left = 32
            Top = 176
            Width = 111
            Height = 15
            Caption = 'Max response tokens'
          end
          object LSystemPrompt: TLabel
            Left = 32
            Top = 144
            Width = 81
            Height = 15
            Caption = 'System prompt'
          end
          object LLLMTemperature: TLabel
            Left = 32
            Top = 241
            Width = 66
            Height = 15
            Caption = 'Temperature'
          end
          object CBProvider: TComboBox
            Left = 160
            Top = 13
            Width = 97
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnDropDown = CBProviderDropDown
            OnSelect = CBProviderSelect
            Items.Strings = (
              'OpenAI'
              'Gemini'
              'Ollama'
              'DeepSeek'
              'Grok')
          end
          object EEndPoint: TEdit
            Left = 160
            Top = 45
            Width = 400
            Height = 23
            TabOrder = 1
          end
          object EModel: TEdit
            Left = 160
            Top = 77
            Width = 400
            Height = 23
            TabOrder = 2
          end
          object EAPIKey: TEdit
            Left = 160
            Top = 109
            Width = 400
            Height = 23
            PasswordChar = #9679
            TabOrder = 3
          end
          object ELLMTimeout: TEdit
            Left = 160
            Top = 206
            Width = 60
            Height = 23
            TabOrder = 4
            Text = '20'
          end
          object EMaxTokens: TEdit
            Left = 160
            Top = 173
            Width = 60
            Height = 23
            TabOrder = 5
            Text = '1000'
          end
          object ESystemPrompt: TEdit
            Left = 160
            Top = 141
            Width = 400
            Height = 23
            TabOrder = 6
            Text = 'You are my expert python coding assistant'
          end
          object ELLMTemperature: TEdit
            Left = 160
            Top = 239
            Width = 60
            Height = 23
            TabOrder = 7
            Text = '1.0'
          end
        end
        object PLLMChat: TTabSheet
          Caption = 'LLM Chat'
          ImageIndex = 33
          object LChatProvider: TLabel
            Left = 16
            Top = 16
            Width = 44
            Height = 15
            Caption = 'Provider'
          end
          object LChatEndPoint: TLabel
            Left = 32
            Top = 48
            Width = 48
            Height = 15
            Caption = 'Endpoint'
          end
          object LChatModel: TLabel
            Left = 32
            Top = 80
            Width = 34
            Height = 15
            Caption = 'Model'
          end
          object LChatApiKey: TLabel
            Left = 32
            Top = 112
            Width = 39
            Height = 15
            Caption = 'API key'
          end
          object LChatSystemPrompt: TLabel
            Left = 32
            Top = 144
            Width = 81
            Height = 15
            Caption = 'System prompt'
          end
          object LChatMaxTokens: TLabel
            Left = 32
            Top = 176
            Width = 111
            Height = 15
            Caption = 'Max response tokens'
          end
          object LChatTimeout: TLabel
            Left = 32
            Top = 208
            Width = 103
            Height = 15
            Caption = 'Timeout in seconds'
          end
          object LChatTemperature: TLabel
            Left = 32
            Top = 242
            Width = 66
            Height = 15
            Caption = 'Temperature'
          end
          object CBChatProvider: TComboBox
            Left = 160
            Top = 13
            Width = 97
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnDropDown = CBChatProviderDropDown
            OnSelect = CBChatProviderSelect
            Items.Strings = (
              'OpenAI'
              'Gemini'
              'Ollama'
              'DeepSeek'
              'Grok')
          end
          object EChatEndPoint: TEdit
            Left = 160
            Top = 45
            Width = 400
            Height = 23
            TabOrder = 1
          end
          object EChatModel: TEdit
            Left = 160
            Top = 77
            Width = 400
            Height = 23
            TabOrder = 2
          end
          object EChatApiKey: TEdit
            Left = 160
            Top = 109
            Width = 400
            Height = 23
            PasswordChar = #9679
            TabOrder = 3
          end
          object EChatSystemPrompt: TEdit
            Left = 160
            Top = 141
            Width = 400
            Height = 23
            TabOrder = 4
            Text = 'You are my expert python coding assistant'
          end
          object EChatMaxTokens: TEdit
            Left = 160
            Top = 173
            Width = 60
            Height = 23
            TabOrder = 5
            Text = '1000'
          end
          object EChatTimeout: TEdit
            Left = 160
            Top = 206
            Width = 60
            Height = 23
            TabOrder = 6
            Text = '20'
          end
          object EChatTemperature: TEdit
            Left = 160
            Top = 239
            Width = 60
            Height = 23
            TabOrder = 7
            Text = '1.0'
          end
        end
        object PVisibility: TTabSheet
          Caption = 'Visibility'
          ImageIndex = 31
          object LVisTabs: TLabel
            Left = 8
            Top = 3
            Width = 23
            Height = 15
            Caption = 'Tabs'
          end
          object LVisMenus: TLabel
            Left = 8
            Top = 120
            Width = 36
            Height = 15
            Caption = 'Menus'
          end
          object LVisToolbars: TLabel
            Left = 8
            Top = 313
            Width = 44
            Height = 15
            Caption = 'Toolbars'
          end
          object LVVisibilityTabs: TListView
            Left = 90
            Top = 3
            Width = 140
            Height = 102
            Checkboxes = True
            Columns = <
              item
                AutoSize = True
              end>
            HideSelection = False
            ReadOnly = True
            ShowColumnHeaders = False
            TabOrder = 0
            ViewStyle = vsReport
            OnClick = LVVisibilityTabsClick
          end
          object LVVisibilityElements: TListView
            Left = 244
            Top = 3
            Width = 292
            Height = 430
            Checkboxes = True
            Columns = <
              item
                AutoSize = True
              end>
            HideSelection = False
            ReadOnly = True
            ShowColumnHeaders = False
            TabOrder = 3
            ViewStyle = vsReport
          end
          object LVVisibilityMenus: TListView
            Left = 90
            Top = 120
            Width = 140
            Height = 176
            Checkboxes = True
            Columns = <
              item
                AutoSize = True
              end>
            HideSelection = False
            ReadOnly = True
            ShowColumnHeaders = False
            TabOrder = 1
            ViewStyle = vsReport
            OnClick = LVVisibilityMenusClick
          end
          object LVVisibilityToolbars: TListView
            Left = 90
            Top = 313
            Width = 140
            Height = 120
            Checkboxes = True
            Columns = <
              item
                AutoSize = True
              end>
            HideSelection = False
            ReadOnly = True
            ShowColumnHeaders = False
            TabOrder = 2
            ViewStyle = vsReport
            OnClick = LVVisibilityToolbarsClick
          end
          object BVisDefault: TButton
            Left = 549
            Top = 206
            Width = 85
            Height = 25
            Caption = 'Default'
            TabOrder = 4
            OnClick = BVisDefaultClick
          end
        end
        object PSSH: TTabSheet
          Caption = 'SSH'
          ImageIndex = 23
          object LScpCommand: TLabel
            Left = 16
            Top = 20
            Width = 79
            Height = 15
            Caption = 'SCP command'
          end
          object LScpOptions: TLabel
            Left = 16
            Top = 52
            Width = 64
            Height = 15
            Caption = 'SCP options'
          end
          object LSSHCommand: TLabel
            Left = 16
            Top = 84
            Width = 79
            Height = 15
            Caption = 'SSH command'
          end
          object LSSHOptions: TLabel
            Left = 16
            Top = 116
            Width = 64
            Height = 15
            Caption = 'SSH options'
          end
          object CBSSHDisableVariablesWin: TCheckBox
            Left = 16
            Top = 152
            Width = 209
            Height = 17
            Caption = 'Disable Variables Window with SSH'
            TabOrder = 0
          end
          object EScpCommand: TEdit
            Left = 116
            Top = 16
            Width = 380
            Height = 23
            TabOrder = 1
            Text = 'scp'
          end
          object EScpOptions: TEdit
            Left = 116
            Top = 48
            Width = 380
            Height = 23
            TabOrder = 2
            Text = '-o PasswordAuthentication=no -o StrictHostKeyChecking=no'
          end
          object ESSHCommand: TEdit
            Left = 116
            Top = 80
            Width = 380
            Height = 23
            TabOrder = 3
            Text = 'ssh'
          end
          object ESSHOptions: TEdit
            Left = 116
            Top = 112
            Width = 380
            Height = 23
            TabOrder = 4
            Text = '-o PasswordAuthentication=no -o StrictHostKeyChecking=no'
          end
        end
        object PTools: TTabSheet
          Caption = 'Tools'
        end
        object PGit: TTabSheet
          Caption = 'Git'
          object LGitFolder: TLabel
            Left = 16
            Top = 20
            Width = 42
            Height = 13
            Caption = 'Git folder'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = LGitFolderClick
            OnMouseEnter = LMouseEnter
            OnMouseLeave = LMouseLeave
          end
          object LLocalRepository: TLabel
            Left = 16
            Top = 52
            Width = 84
            Height = 15
            Caption = 'Repository local'
          end
          object LUserName: TLabel
            Left = 16
            Top = 116
            Width = 55
            Height = 15
            Caption = 'user.name'
          end
          object LRemoteRepository: TLabel
            Left = 16
            Top = 84
            Width = 97
            Height = 15
            Caption = 'Repository remote'
          end
          object LUserEMail: TLabel
            Left = 16
            Top = 148
            Width = 54
            Height = 15
            Caption = 'user.email'
          end
          object EGitFolder: TEdit
            Left = 140
            Top = 16
            Width = 394
            Height = 23
            TabOrder = 0
          end
          object CBLocalRepository: TComboBox
            Left = 140
            Top = 48
            Width = 394
            Height = 23
            TabOrder = 1
          end
          object BGitFolder: TButton
            Left = 550
            Top = 16
            Width = 85
            Height = 23
            Caption = 'Select'
            TabOrder = 2
            OnClick = BGitFolderClick
          end
          object BGitRepository: TButton
            Left = 550
            Top = 48
            Width = 85
            Height = 23
            Caption = 'Select'
            TabOrder = 3
            OnClick = BGitRepositoryClick
          end
          object CBRemoteRepository: TComboBox
            Left = 140
            Top = 80
            Width = 394
            Height = 23
            TabOrder = 4
          end
          object EUserName: TEdit
            Left = 140
            Top = 112
            Width = 394
            Height = 23
            TabOrder = 5
          end
          object EUserEMail: TEdit
            Left = 140
            Top = 144
            Width = 394
            Height = 23
            TabOrder = 6
          end
          object BGitClone: TButton
            Left = 550
            Top = 80
            Width = 85
            Height = 23
            Caption = 'Clone'
            TabOrder = 7
            OnClick = BGitCloneClick
          end
        end
        object PSubversion: TTabSheet
          Caption = 'Subversion'
          object LRepository: TLabel
            Left = 32
            Top = 52
            Width = 56
            Height = 15
            Caption = 'Repository'
          end
          object LSVN: TLabel
            Left = 16
            Top = 20
            Width = 51
            Height = 13
            Caption = 'SVN folder'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = LSVNClick
            OnMouseEnter = LMouseEnter
            OnMouseLeave = LMouseLeave
          end
          object CBRepository: TComboBox
            Left = 140
            Top = 48
            Width = 394
            Height = 23
            TabOrder = 0
          end
          object BRepository: TButton
            Left = 550
            Top = 48
            Width = 85
            Height = 23
            Caption = 'Select'
            TabOrder = 1
            OnClick = BRepositoryClick
          end
          object BSVN: TButton
            Left = 550
            Top = 16
            Width = 85
            Height = 23
            Caption = 'Select'
            TabOrder = 2
            OnClick = BSVNClick
          end
          object ESVNFolder: TEdit
            Left = 140
            Top = 16
            Width = 394
            Height = 23
            TabOrder = 3
          end
        end
      end
    end
  end
  object FolderDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 712
    Top = 216
  end
  object vilTreeImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 3
        CollectionName = 'ArrowRight'
        Name = 'ArrowRight'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    Left = 768
    Top = 408
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    Options = [fdEffects, fdFixedPitchOnly, fdScalableOnly]
    Left = 682
    Top = 141
  end
  object IDEShortcutsActionList1: TActionList
    Left = 648
    Top = 384
    object actAssignShortcut: TAction
      Caption = '&Assign'
      Hint = 'Assign shortcut to command'
      OnExecute = actAssignShortcutExecute
      OnUpdate = actAssignShortcutUpdate
    end
    object actRemoveShortcut: TAction
      Caption = '&Remove'
      Hint = 'Remove shortcut'
      OnExecute = actRemoveShortcutExecute
      OnUpdate = actRemoveShortcutUpdate
    end
  end
  object PTemplatesActionList: TActionList
    OnUpdate = PTemplatesActionListUpdate
    Left = 779
    Top = 139
    object actCodeAddItem: TAction
      Category = 'CodeTemplate'
      Caption = '&Add'
      Hint = 'Add item'
      ImageIndex = 4
      OnExecute = actCodeAddItemExecute
    end
    object actCodeDeleteItem: TAction
      Category = 'CodeTemplate'
      Caption = '&Delete'
      Hint = 'Delete item'
      ImageIndex = 0
      OnExecute = actCodeDeleteItemExecute
    end
    object actCodeMoveUp: TAction
      Category = 'CodeTemplate'
      Caption = '&Up'
      Hint = 'Move item up'
      ImageIndex = 2
      OnExecute = actCodeMoveUpExecute
    end
    object actCodeMoveDown: TAction
      Category = 'CodeTemplate'
      Caption = '&Down'
      Hint = 'Move item down'
      ImageIndex = 3
      OnExecute = actCodeMoveDownExecute
    end
    object actCodeUpdateItem: TAction
      Category = 'CodeTemplate'
      Caption = '&Update'
      Hint = 'Update item'
      ImageIndex = 1
      OnExecute = actCodeUpdateItemExecute
    end
    object actFileAddItem: TAction
      Category = 'FileTemplate'
      Caption = '&Add'
      Hint = 'Add item'
      ImageIndex = 4
      OnExecute = actFileAddItemExecute
    end
    object actFileDeleteItem: TAction
      Category = 'FileTemplate'
      Caption = '&Delete'
      Hint = 'Delete item'
      ImageIndex = 0
      OnExecute = actFileDeleteItemExecute
    end
    object actFileMoveUp: TAction
      Category = 'FileTemplate'
      Caption = '&Up'
      Hint = 'Move item up'
      ImageIndex = 2
      OnExecute = actFileMoveUpExecute
    end
    object actFileMoveDown: TAction
      Category = 'FileTemplate'
      Caption = '&Down'
      Hint = 'Move item down'
      ImageIndex = 3
      OnExecute = actFileMoveDownExecute
    end
    object actFileUpdateItem: TAction
      Category = 'FileTemplate'
      Caption = '&Update'
      Hint = 'Update item'
      ImageIndex = 1
      OnExecute = actFileUpdateItemExecute
    end
    object actFileDefaultItem: TAction
      Category = 'FileTemplate'
      Caption = 'Default'
      OnExecute = actFileDefaultItemExecute
    end
    object actFileDefaultAll: TAction
      Category = 'FileTemplate'
      Caption = 'Default all'
      OnExecute = actFileDefaultAllExecute
    end
  end
  object TemplatesVirtualImageList: TVirtualImageList
    Images = <
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 88
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 130
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 68
        CollectionName = 'Plus'
        Name = 'Plus'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    Left = 782
    Top = 368
  end
  object ColorDialog: TColorDialog
    Left = 487
    Top = 380
  end
  object actlPythonVersions: TActionList
    OnUpdate = actlPythonVersionsUpdate
    Left = 672
    Top = 272
    object actPVActivate: TAction
      Caption = 'Activate'
      HelpContext = 880
      Hint = 'Activate selected Python version'
      ImageIndex = 6
      OnExecute = actPVActivateExecute
    end
    object actPVAdd: TAction
      Caption = 'Add'
      HelpContext = 880
      Hint = 'Add a new Python version'
      ImageIndex = 1
      OnExecute = actPVAddExecute
    end
    object actPVRemove: TAction
      Caption = 'Remove'
      HelpContext = 880
      Hint = 'Remove selected Python version'
      ImageIndex = 2
      OnExecute = actPVRemoveExecute
    end
    object actPVTest: TAction
      Caption = 'Test'
      HelpContext = 880
      Hint = 'Test selected Python version'
      ImageIndex = 5
      OnExecute = actPVTestExecute
    end
    object actPVShow: TAction
      Caption = 'Show'
      HelpContext = 880
      Hint = 'Show selected Python version in Explorer'
      ImageIndex = 0
      OnExecute = actPVShowExecute
    end
    object actPVCommandShell: TAction
      Caption = 'Shell'
      HelpContext = 880
      Hint = 'Open command prompt for the selected Python version'
      ImageIndex = 4
      OnExecute = actPVCommandShellExecute
    end
    object actPVHelp: TAction
      Caption = 'Help'
      HelpContext = 880
      Hint = 'Show Help'
      ImageIndex = 3
      OnExecute = actPVHelpExecute
    end
    object actPVRename: TAction
      Caption = 'Rename'
      HelpContext = 880
      Hint = 'Rename selected Python version'
      ImageIndex = 7
      OnExecute = actPVRenameExecute
    end
  end
  object vilPageSetup: TVirtualImageList
    Images = <
      item
        CollectionIndex = 5
        CollectionName = 'PageSetup\PageNum'
        Name = 'PageNum'
      end
      item
        CollectionIndex = 6
        CollectionName = 'PageSetup\Pages'
        Name = 'Pages'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PageSetup\Time'
        Name = 'Time'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PageSetup\Date'
        Name = 'Date'
      end
      item
        CollectionIndex = 8
        CollectionName = 'PageSetup\Title'
        Name = 'Title'
      end
      item
        CollectionIndex = 2
        CollectionName = 'PageSetup\Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 0
        CollectionName = 'PageSetup\Bold'
        Name = 'Bold'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PageSetup\Italic'
        Name = 'Italic'
      end
      item
        CollectionIndex = 9
        CollectionName = 'PageSetup\Underline'
        Name = 'Underline'
      end>
    ImageCollection = icPageSetup
    PreserveItems = True
    Width = 20
    Left = 780
    Top = 325
  end
  object icPageSetup: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'PageSetup\Bold'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M13.5,15.5H10V12.5H13.5A1' +
          '.5,1.5 0 0,1 15,14A1.5,1.5 0 0,1 13.5,15.5M10,6.5H13A1.5,1.5 0 0' +
          ',1 14.5,8A1.5,1.5 0 0,1 13,9.5H10M15.6,10.79C16.57,10.11 17.25,9' +
          ' 17.25,8C17.25,5.74 15.5,4 13.25,4H7V18H14.04C16.14,18 17.75,16.' +
          '3 17.75,14.21C17.75,12.69 16.89,11.39 15.6,10.79Z" />'#13#10'</svg>'
      end
      item
        IconName = 'PageSetup\Date'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M4.6,6.5H21V2.4c0-1.1-0.9-2' +
          '.1-2.1-2.1H4.6C4,0.3,3.3,0.7,2.9,1.3C2.8,1.5,2.6,1.8,2.6,2c0,0.1' +
          '-0.1,0.3-0.1,0.5v18.8'#13#10#9#9'c0,1.1,0.9,2.1,2.1,2.1h4.2v-2.1H4.6V6.5' +
          'z M4.6,2.4h14.3v2.1H4.6V2.4z"/>'#13#10#9'<path d="M27.4,8.8H14.8c-0.5-0' +
          '.7-1.3-1-2.2-1H8v9.9H11v0.8h-5v2.3h5v8.9c0,1.1,0.9,2.1,2.1,2.1h1' +
          '4.3c1.1,0,2.1-0.9,2.1-2.1V10.8'#13#10#9#9'C29.5,9.7,28.5,8.8,27.4,8.8z M' +
          '10.3,9.5h1.1c0,0,0,0-0.1,0.1c-0.2,0.2-0.3,0.5-0.3,0.7c0,0.2-0.1,' +
          '0.3-0.1,0.5v0.8v0.1h-0.7V9.5z'#13#10#9#9' M10.3,15.9v-2.1H11v2.1H10.3z M' +
          '27.4,29.6H13.1v-8.9v-2.3v-0.8v-1.8V15h0.8h1.8h3.3h8.4V29.6z M27.' +
          '4,12.9h-8.4h-4.2h-1.7v-1.5v-0.6'#13#10#9#9'h0.3h0.1h1.9h12V12.9z"/>'#13#10#9'<p' +
          'olygon points="16.7,17.8 21.4,17.8 21,18.7 20.4,20.1 18.8,23.3 1' +
          '7.6,26 20.1,26 23.8,17.3 23.8,16.1 16.7,16.1 "/>'#13#10#9'<rect x="14.4' +
          '" y="26.7" width="11.7" height="2.3"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PageSetup\Font'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M17,8H20V20H21V21H17V20H1' +
          '8V17H14L12.5,20H14V21H10V20H11L17,8M18,9L14.5,16H18V9M5,3H10C11.' +
          '11,3 12,3.89 12,5V16H9V11H6V16H3V5C3,3.89 3.89,3 5,3M6,5V9H9V5H6' +
          'Z" />'#13#10'</svg>'
      end
      item
        IconName = 'PageSetup\Italic'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M10,4V7H12.21L8.79,15H6V1' +
          '8H14V15H11.79L15.21,7H18V4H10Z" />'#13#10'</svg>'
      end
      item
        IconName = 'PageSetup\Page6'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M17,8H20V20H21V21H17V20H1' +
          '8V17H14L12.5,20H14V21H10V20H11L17,8M18,9L14.5,16H18V9M5,3H10C11.' +
          '11,3 12,3.89 12,5V16H9V11H6V16H3V5C3,3.89 3.89,3 5,3M6,5V9H9V5H6' +
          'Z" />'#13#10'</svg>'
      end
      item
        IconName = 'PageSetup\PageNum'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M19,1H7C5.3,1,4,2.3,4,4v24c' +
          '0,1.7,1.3,3,3,3h18c1.7,0,3-1.3,3-3V10L19,1z M25,28H7V4h10.5v7.5H' +
          '18v1.4h-4v-4h-2v4H8v2h4v4'#13#10#9#9'H8v2h4v4h2v-4h4v4h2v-4h4v-2h-4v-4h4' +
          'v-2h-4v-1.4h5V28z M18,14.9v4h-4v-4H18z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PageSetup\Pages'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M19,1H7C5.3,1,4,2.3,4,4v24c' +
          '0,1.7,1.3,3,3,3h18c1.7,0,3-1.3,3-3V10L19,1z M7,28V4h10.5v7.5H25V' +
          '28H7z"/>'#13#10#9#9'<path d="M19.9,19.5v-4h-2v4h-4v2h4v4h2v-4h4v-2H19.9z' +
          ' M17.5,14.2v-2h-4v-4h-2v4h-4v2h4v4h2v-4C13.5,14.2,17.5,14.2,17.5' +
          ',14.2z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PageSetup\Time'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M16,1C7.7,1,1,7.8,1,16s6.8,' +
          '15,15,15s15-6.8,15-15C31,7.6,24.2,1,16,1z M16,28C9.4,28,4,22.6,4' +
          ',16S9.4,4,16,4s12,5.4,12,12'#13#10#9#9'S22.6,28,16,28z M16.7,8.5h-2.3v9l' +
          '7.9,4.7l1.2-1.8l-6.8-4L16.7,8.5L16.7,8.5z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PageSetup\Title'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M5,4V7H10.5V19H13.5V7H19V' +
          '4H5Z" />'#13#10'</svg>'
      end
      item
        IconName = 'PageSetup\Underline'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M5,21H19V19H5V21M12,17A6,' +
          '6 0 0,0 18,11V3H15.5V11A3.5,3.5 0 0,1 12,14.5A3.5,3.5 0 0,1 8.5,' +
          '11V3H6V11A6,6 0 0,0 12,17Z"/>'#13#10'</svg>'
      end>
    ApplyFixedColorToRootOnly = True
    Left = 774
    Top = 198
  end
  object ActionListPageSetup: TActionList
    Images = vilPageSetup
    Left = 659
    Top = 332
    object PageNumCmd: TAction
      Caption = 'Page number'
      Hint = 'Page number'
      ImageIndex = 0
      ImageName = 'PageNum'
      OnExecute = PageNumCmdExecute
    end
    object PagesCmd: TAction
      Caption = 'Num. pages'
      Hint = 'Num. pages'
      ImageIndex = 1
      ImageName = 'Pages'
      OnExecute = PagesCmdExecute
    end
    object TimeCmd: TAction
      Caption = 'Time'
      Hint = 'Time'
      ImageIndex = 2
      ImageName = 'Time'
      OnExecute = TimeCmdExecute
    end
    object DateCmd: TAction
      Caption = 'Date'
      Hint = 'Date'
      ImageIndex = 3
      ImageName = 'Date'
      OnExecute = DateCmdExecute
    end
    object TitleCmd: TAction
      Caption = 'Title'
      Hint = 'Title'
      ImageIndex = 4
      ImageName = 'Title'
      OnExecute = TitleCmdExecute
    end
    object FontCmd: TAction
      Caption = 'Font'
      Hint = 'Font'
      ImageIndex = 5
      ImageName = 'Font'
      OnExecute = FontCmdExecute
    end
    object BoldCmd: TAction
      Caption = 'Bold'
      Hint = 'Bold'
      ImageIndex = 6
      ImageName = 'Bold'
      OnExecute = BoldCmdExecute
    end
    object ItalicCmd: TAction
      Caption = 'Italic'
      Hint = 'Italic'
      ImageIndex = 7
      ImageName = 'Italic'
      OnExecute = ItalicCmdExecute
    end
    object UnderlineCmd: TAction
      Caption = 'Underline'
      Hint = 'Underline'
      ImageIndex = 8
      ImageName = 'Underline'
      OnExecute = UnderlineCmdExecute
    end
  end
end
