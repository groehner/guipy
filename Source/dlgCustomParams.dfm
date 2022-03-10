inherited CustomizeParams: TCustomizeParams
  Left = 340
  Top = 192
  HelpContext = 720
  Caption = 'Custom Parameters'
  ClientHeight = 343
  ClientWidth = 557
  ShowHint = True
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 563
  ExplicitHeight = 372
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 343
    Align = alClient
    TabOrder = 0
    DesignSize = (
      557
      343)
    object Label3: TLabel
      Left = 12
      Top = 304
      Width = 214
      Height = 13
      Caption = 'Press Shift+Ctrl+P for Parameter completion'
      Enabled = False
    end
    object Label4: TLabel
      Left = 12
      Top = 319
      Width = 204
      Height = 13
      Caption = 'Press Shift+Ctrl+M for Modifier completion'
      Enabled = False
    end
    object TBXButton1: TButton
      Left = 8
      Top = 183
      Width = 100
      Height = 24
      Action = actAddItem
      Images = vilImages
      TabOrder = 3
    end
    object TBXButton3: TButton
      Left = 117
      Top = 183
      Width = 100
      Height = 24
      Action = actDeleteItem
      Images = vilImages
      TabOrder = 4
    end
    object TBXButton4: TButton
      Left = 227
      Top = 183
      Width = 100
      Height = 24
      Action = actMoveUp
      Images = vilImages
      TabOrder = 5
    end
    object TBXButton5: TButton
      Left = 336
      Top = 183
      Width = 100
      Height = 24
      Action = actMoveDown
      Images = vilImages
      TabOrder = 6
    end
    object TBXButton2: TButton
      Left = 446
      Top = 183
      Width = 100
      Height = 24
      Action = actUpdateItem
      Images = vilImages
      TabOrder = 7
    end
    object btnOK: TButton
      Left = 382
      Top = 308
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TButton
      Left = 462
      Top = 308
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 8
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 215
      Width = 536
      Height = 83
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Name-Value Pair'
      TabOrder = 2
      object Label1: TLabel
        Left = 14
        Top = 28
        Width = 31
        Height = 13
        Caption = '&Name:'
      end
      object Label2: TLabel
        Left = 14
        Top = 50
        Width = 30
        Height = 13
        Caption = '&Value:'
      end
      object SynValue: TSynEdit
        Left = 133
        Top = 48
        Width = 380
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 1
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.Bands = <
          item
            Kind = gbkMarks
            Visible = True
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
            Visible = True
            Width = 3
          end>
        HideSelection = True
        Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
        ScrollBars = ssNone
        WantReturns = False
      end
      object edName: TEdit
        Left = 133
        Top = 23
        Width = 155
        Height = 21
        TabOrder = 0
        OnKeyPress = edNameKeyPress
      end
    end
    object lvItems: TListView
      Left = 1
      Top = 1
      Width = 555
      Height = 171
      Align = alTop
      Columns = <
        item
          Caption = 'Name'
          Width = 140
        end
        item
          Caption = 'Value'
          Width = 250
        end>
      ColumnClick = False
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = lvItemsSelectItem
    end
  end
  object ActionList: TActionList
    Images = vilImages
    OnUpdate = ActionListUpdate
    Left = 354
    Top = 18
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
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Disabled = False
        Name = 'Delete'
      end
      item
        CollectionIndex = 88
        CollectionName = 'Refresh'
        Disabled = False
        Name = 'Refresh'
      end
      item
        CollectionIndex = 129
        CollectionName = 'Up'
        Disabled = False
        Name = 'Up'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Down'
        Disabled = False
        Name = 'Down'
      end
      item
        CollectionIndex = 68
        CollectionName = 'Plus'
        Disabled = False
        Name = 'Plus'
      end>
    ImageCollection = CommandsDataModule.icSVGImages
    PreserveItems = True
    Left = 304
    Top = 17
  end
end
