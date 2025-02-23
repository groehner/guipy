inherited CodeTemplates: TCodeTemplates
  Left = 340
  Top = 192
  HelpContext = 540
  Caption = 'Code Templates'
  ClientHeight = 425
  ClientWidth = 550
  ShowHint = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 562
  ExplicitHeight = 463
  TextHeight = 15
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 425
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 546
    ExplicitHeight = 424
    DesignSize = (
      550
      425)
    object btnAdd: TButton
      Left = 13
      Top = 118
      Width = 101
      Height = 24
      Action = actAddItem
      Images = vilImages
      TabOrder = 3
    end
    object btnDelete: TButton
      Left = 118
      Top = 118
      Width = 101
      Height = 24
      Action = actDeleteItem
      Images = vilImages
      TabOrder = 4
    end
    object btnMoveup: TButton
      Left = 224
      Top = 118
      Width = 101
      Height = 24
      Action = actMoveUp
      Images = vilImages
      TabOrder = 5
    end
    object btnMoveDown: TButton
      Left = 330
      Top = 118
      Width = 101
      Height = 24
      Action = actMoveDown
      Images = vilImages
      TabOrder = 6
    end
    object btnUpdate: TButton
      Left = 436
      Top = 118
      Width = 101
      Height = 24
      Action = actUpdateItem
      Images = vilImages
      TabOrder = 7
    end
    object btnCancel: TButton
      Left = 367
      Top = 393
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 9
      ExplicitLeft = 363
      ExplicitTop = 392
    end
    object btnOK: TButton
      Left = 283
      Top = 393
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
      ExplicitLeft = 279
      ExplicitTop = 392
    end
    object btnHelp: TButton
      Left = 451
      Top = 393
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Help'
      TabOrder = 8
      OnClick = btnHelpClick
      ExplicitLeft = 447
      ExplicitTop = 392
    end
    object GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 148
      Width = 528
      Height = 239
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Code Template:'
      TabOrder = 2
      ExplicitWidth = 524
      DesignSize = (
        528
        239)
      object Label1: TLabel
        Left = 8
        Top = 21
        Width = 35
        Height = 15
        Caption = '&Name:'
      end
      object Label2: TLabel
        Left = 8
        Top = 65
        Width = 51
        Height = 15
        Caption = '&Template:'
      end
      object Label5: TLabel
        Left = 8
        Top = 44
        Width = 63
        Height = 15
        Caption = '&Description:'
      end
      object Label4: TLabel
        Left = 8
        Top = 200
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
      object Label3: TLabel
        Left = 8
        Top = 215
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
      object SynTemplate: TSynEdit
        Left = 9
        Top = 84
        Width = 512
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
        Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
        TabWidth = 4
        ExplicitWidth = 508
      end
      object edDescription: TEdit
        Left = 115
        Top = 43
        Width = 406
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        ExplicitWidth = 402
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
    object lvItems: TListView
      Left = 1
      Top = 1
      Width = 548
      Height = 109
      Align = alTop
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
      TabOrder = 0
      ViewStyle = vsReport
      OnDeletion = lvItemsDeletion
      OnSelectItem = lvItemsSelectItem
      ExplicitWidth = 544
    end
  end
  object ActionList: TActionList
    Images = vilImages
    OnUpdate = ActionListUpdate
    Left = 379
    Top = 27
    object actAddItem: TAction
      Caption = '&Add'
      Hint = 'Add item'
      ImageIndex = 4
      ImageName = 'Plus'
      OnExecute = actAddItemExecute
    end
    object actDeleteItem: TAction
      Caption = '&Delete'
      Hint = 'Delete item'
      ImageIndex = 0
      ImageName = 'Delete'
      OnExecute = actDeleteItemExecute
    end
    object actMoveUp: TAction
      Caption = '&Up'
      Hint = 'Move item up'
      ImageIndex = 2
      ImageName = 'Up'
      OnExecute = actMoveUpExecute
    end
    object actMoveDown: TAction
      Caption = '&Down'
      Hint = 'Move item down'
      ImageIndex = 3
      ImageName = 'Down'
      OnExecute = actMoveDownExecute
    end
    object actUpdateItem: TAction
      Caption = '&Update'
      Hint = 'Update item'
      ImageIndex = 1
      ImageName = 'Refresh'
      OnExecute = actUpdateItemExecute
    end
  end
  object vilImages: TVirtualImageList
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
    PreserveItems = True
    Left = 320
    Top = 27
  end
end
