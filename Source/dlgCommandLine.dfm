inherited CommandLineDlg: TCommandLineDlg
  HelpContext = 910
  ActiveControl = SynParameters
  Caption = 'Command Line Parameters'
  ClientWidth = 528
  OnDestroy = FormDestroy
  ExplicitWidth = 544
  TextHeight = 15
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 528
    Height = 172
    Align = alClient
    TabOrder = 0
    DesignSize = (
      528
      172)
    object Label1: TLabel
      Left = 13
      Top = 43
      Width = 456
      Height = 35
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = 
        'Please enter parameters to be appended to the command line:'#13#10'Not' +
        'e that the script name is automatically inserted as the first ar' +
        'gument.'
      Color = clNone
      ParentColor = False
      ExplicitWidth = 460
    end
    object Label3: TLabel
      Left = 13
      Top = 108
      Width = 272
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'Parameters : Shift+Ctrl+P, Modifiers : Shift+Ctrl+M '
      Color = clNone
      Enabled = False
      ParentColor = False
    end
    object SynParameters: TSynEdit
      Left = 11
      Top = 84
      Width = 480
      Height = 18
      Anchors = [akLeft, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Consolas'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      TabOrder = 0
      OnEnter = SynParametersEnter
      UseCodeFolding = False
      ExtraLineSpacing = 0
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
          Width = 15
        end
        item
          Kind = gbkLineNumbers
        end
        item
          Kind = gbkFold
        end
        item
          Kind = gbkMargin
          Width = 2
        end>
      HideSelection = True
      RightEdge = 0
      ScrollBars = ssNone
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
      WantReturns = False
    end
    object TBXButton1: TSpTBXButton
      Left = 497
      Top = 83
      Width = 19
      Height = 19
      Hint = 'History'
      Anchors = [akRight, akBottom]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      DropDownMenu = TBXPopupHistory
    end
    object cbUseCommandLine: TCheckBox
      Left = 13
      Top = 16
      Width = 395
      Height = 21
      Caption = 'Use Command Line Parameters?'
      TabOrder = 4
    end
    object OKButton: TButton
      Left = 140
      Top = 137
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = OKButtonClick
    end
    object btnCancel: TButton
      Left = 234
      Top = 137
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object btnHelp: TButton
      Left = 329
      Top = 137
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Help'
      TabOrder = 3
      OnClick = btnHelpClick
    end
  end
  object TBXPopupHistory: TSpTBXPopupMenu
    OnPopup = TBXPopupHistoryPopup
    Left = 456
    Top = 8
    object EmptyHistoryPopupItem: TSpTBXItem
      Caption = '(Empty History)'
    end
    object mnCommandHistoryMRU: TSpTBXMRUListItem
      HidePathExtension = False
      MaxItems = 6
      OnClick = mnCommandHistoryMRUClick
    end
  end
end
