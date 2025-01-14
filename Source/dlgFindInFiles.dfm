inherited FindInFilesDialog: TFindInFilesDialog
  Left = 412
  Top = 114
  HelpContext = 810
  Caption = 'Find in Files Search'
  ClientHeight = 301
  ClientWidth = 388
  Position = poScreenCenter
  OnShow = FormShow
  ExplicitWidth = 400
  ExplicitHeight = 339
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 388
    Height = 301
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 384
    ExplicitHeight = 300
    DesignSize = (
      388
      301)
    object lblFind: TLabel
      Left = 8
      Top = 9
      Width = 62
      Height = 15
      Caption = '&Text to find:'
      FocusControl = cbText
    end
    object gbxOptions: TGroupBox
      Left = 10
      Top = 54
      Width = 169
      Height = 106
      Anchors = [akLeft]
      Caption = 'Options'
      TabOrder = 2
      object cbCaseSensitive: TCheckBox
        Left = 10
        Top = 16
        Width = 156
        Height = 21
        Caption = '&Case sensitive'
        TabOrder = 0
      end
      object cbNoComments: TCheckBox
        Left = 10
        Top = 79
        Width = 156
        Height = 21
        Caption = '&Ignore comments'
        TabOrder = 3
      end
      object cbWholeWord: TCheckBox
        Left = 10
        Top = 36
        Width = 156
        Height = 21
        Caption = '&Whole word'
        TabOrder = 1
      end
      object cbRegEx: TCheckBox
        Left = 10
        Top = 58
        Width = 167
        Height = 21
        Caption = 'Regular e&xpression'
        TabOrder = 2
      end
    end
    object gbxWhere: TGroupBox
      Left = 177
      Top = 53
      Width = 188
      Height = 106
      Anchors = [akRight]
      Caption = 'Where'
      TabOrder = 3
      ExplicitLeft = 173
      object rbOpenFiles: TRadioButton
        Left = 11
        Top = 36
        Width = 174
        Height = 21
        Caption = '&Open files'
        TabOrder = 1
        OnClick = rbProjectClick
      end
      object rbProject: TRadioButton
        Left = 11
        Top = 58
        Width = 166
        Height = 21
        Caption = '&Project files'
        TabOrder = 2
        OnClick = rbProjectClick
      end
      object rbCurrentOnly: TRadioButton
        Left = 11
        Top = 16
        Width = 166
        Height = 21
        Caption = 'Current &file only'
        TabOrder = 0
        OnClick = rbProjectClick
      end
      object rbDirectories: TRadioButton
        Left = 11
        Top = 79
        Width = 166
        Height = 21
        Caption = 'Search in &directories'
        TabOrder = 3
        OnClick = rbProjectClick
      end
    end
    object gbxDirectories: TGroupBox
      Left = 8
      Top = 166
      Width = 358
      Height = 97
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Directory Search'
      TabOrder = 1
      ExplicitTop = 165
      ExplicitWidth = 354
      DesignSize = (
        358
        97)
      object lblMasks: TLabel
        Left = 9
        Top = 52
        Width = 57
        Height = 15
        Caption = 'File mas&ks:'
        FocusControl = cbMasks
      end
      object lblDirectory: TLabel
        Left = 8
        Top = 26
        Width = 59
        Height = 15
        Caption = 'Di&rectories:'
        FocusControl = cbDirectory
      end
      object btnBrowse: TButton
        Left = 333
        Top = 22
        Width = 20
        Height = 20
        Hint = 'Select directory'
        Anchors = [akTop, akRight]
        ImageIndex = 0
        ImageName = 'OpenFolder'
        Images = vilImages
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = btnBrowseClick
        ExplicitLeft = 329
      end
      object cbInclude: TCheckBox
        Left = 96
        Top = 73
        Width = 184
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Include su&bdirectories'
        TabOrder = 3
        ExplicitWidth = 180
      end
      object cbMasks: TComboBox
        Left = 96
        Top = 48
        Width = 257
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 15
        TabOrder = 2
        ExplicitWidth = 253
      end
      object cbDirectory: TComboBox
        Left = 96
        Top = 21
        Width = 235
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 15
        TabOrder = 0
        OnDropDown = cbDirectoryDropDown
        ExplicitWidth = 231
      end
    end
    object btnOK: TButton
      Left = 130
      Top = 269
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 4
      OnClick = btnOKClick
      ExplicitLeft = 126
      ExplicitTop = 268
    end
    object btnCancel: TButton
      Left = 211
      Top = 269
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 5
      ExplicitLeft = 207
      ExplicitTop = 268
    end
    object btnHelp: TButton
      Left = 291
      Top = 269
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Help'
      TabOrder = 6
      OnClick = btnHelpClick
      ExplicitLeft = 287
      ExplicitTop = 268
    end
    object cbText: TComboBox
      Left = 8
      Top = 28
      Width = 356
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      DropDownCount = 15
      TabOrder = 0
      ExplicitWidth = 352
    end
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 63
        CollectionName = 'OpenFolder'
        Name = 'OpenFolder'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Left = 24
    Top = 248
  end
end
