object FConnectForm: TFConnectForm
  Left = 459
  Top = 280
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Connection type'
  ClientHeight = 203
  ClientWidth = 301
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
end
