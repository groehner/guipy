object FConnectForm: TFConnectForm
  Left = 459
  Top = 280
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Connection type'
  ClientHeight = 202
  ClientWidth = 308
  Color = clBtnFace
  ParentFont = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object LSelect: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 15
    Caption = 'Please select'
  end
  object LMessage: TLabel
    Left = 8
    Top = 155
    Width = 46
    Height = 15
    Caption = 'Message'
  end
  object LBConnections: TListBox
    Left = 8
    Top = 32
    Width = 217
    Height = 109
    Style = lbOwnerDrawVariable
    ItemHeight = 21
    Items.Strings = (
      'Synchron'
      'Asynchron'
      'Return'
      'Create'
      'Close')
    TabOrder = 1
    OnClick = LBConnectionsClick
    OnDblClick = LBConnectionsDblClick
    OnDrawItem = LBConnectionsDrawItem
  end
  object BOK: TButton
    Left = 231
    Top = 32
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BTurn: TButton
    Left = 231
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Turn'
    ModalResult = 6
    TabOrder = 3
  end
  object BDelete: TButton
    Left = 231
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Delete'
    ModalResult = 7
    TabOrder = 4
  end
  object BCancel: TButton
    Left = 231
    Top = 116
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object ERelation: TEdit
    Left = 8
    Top = 174
    Width = 298
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 0
  end
  object vilConnectionsLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Lifeline'
        Name = 'Lifeline'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Actor'
        Name = 'Actor'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 4
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 5
        CollectionName = 'NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 8
        CollectionName = 'AsText'
        Name = 'AsText'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end
      item
        CollectionIndex = 11
        CollectionName = 'CreateLifeline'
        Name = 'CreateLifeline'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Synchron'
        Name = 'Synchron'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Asynchron'
        Name = 'Asynchron'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Return'
        Name = 'Return'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Create'
        Name = 'Create'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Turn'
        Name = 'Turn'
      end>
    ImageCollection = DMImages.icSequencediagram
    Width = 26
    Left = 88
    Top = 9
  end
  object vilConnectionsDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 12
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 13
        CollectionName = 'LifeLine'
        Name = 'LifeLine'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Actor'
        Name = 'Actor'
      end
      item
        CollectionIndex = 15
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 16
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 17
        CollectionName = 'NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 20
        CollectionName = 'AsText'
        Name = 'AsText'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end
      item
        CollectionIndex = 22
        CollectionName = 'CreateLifeline'
        Name = 'CreateLifeline'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Synchron'
        Name = 'Synchron'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Asynchron'
        Name = 'Asynchron'
      end
      item
        CollectionIndex = 32
        CollectionName = 'Return'
        Name = 'Return'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Create'
        Name = 'Create'
      end
      item
        CollectionIndex = 34
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Turn'
        Name = 'Turn'
      end>
    ImageCollection = DMImages.icSequencediagram
    Width = 26
    Left = 200
    Top = 9
  end
end
