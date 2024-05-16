object FAssociation: TFAssociation
  Left = 459
  Top = 280
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Connection types'
  ClientHeight = 493
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
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
  object LMultiplicityA: TLabel
    Left = 8
    Top = 354
    Width = 71
    Height = 15
    Caption = 'Multiplicity A'
  end
  object LRelation: TLabel
    Left = 136
    Top = 282
    Width = 43
    Height = 15
    Caption = 'Relation'
  end
  object LMultiplicityB: TLabel
    Left = 230
    Top = 354
    Width = 70
    Height = 15
    Caption = 'Multiplicity B'
  end
  object LRoleA: TLabel
    Left = 8
    Top = 282
    Width = 34
    Height = 15
    Caption = 'Role A'
  end
  object LRoleB: TLabel
    Left = 266
    Top = 282
    Width = 33
    Height = 15
    Caption = 'Role B'
  end
  object LBAssociations: TListBox
    Left = 8
    Top = 32
    Width = 217
    Height = 217
    Style = lbOwnerDrawFixed
    ItemHeight = 21
    Items.Strings = (
      'Association'
      'Association directed'
      'Association bidirectional'
      'Aggregation'
      'Aggregation with arrow'
      'Composition'
      'Composition with arrow'
      'Inheritance'
      'Instance of'
      'Comment')
    TabOrder = 0
    OnDblClick = LBAssociationsDblClick
    OnDrawItem = LBAssociationsDrawItem
  end
  object BOK: TButton
    Left = 230
    Top = 32
    Width = 76
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BTurn: TButton
    Left = 231
    Top = 63
    Width = 76
    Height = 25
    Caption = 'Turn'
    ModalResult = 6
    TabOrder = 3
  end
  object BDelete: TButton
    Left = 230
    Top = 96
    Width = 76
    Height = 25
    Caption = 'Delete'
    ModalResult = 7
    TabOrder = 4
  end
  object BCancel: TButton
    Left = 230
    Top = 128
    Width = 76
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object ERelation: TEdit
    Left = 104
    Top = 301
    Width = 105
    Height = 23
    TabOrder = 1
  end
  object RGRecursivCorner: TRadioGroup
    Left = 8
    Top = 419
    Width = 297
    Height = 72
    Caption = 'Recursive relation'
    Columns = 2
    Items.Strings = (
      'top left'
      'bottom left'
      'top right'
      'bottom right')
    TabOrder = 6
  end
  object CBReadingOrderA: TCheckBox
    Left = 104
    Top = 328
    Width = 49
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = CBReadingOrderAClick
  end
  object CBReadingOrderB: TCheckBox
    Left = 176
    Top = 328
    Width = 33
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = CBReadingOrderBClick
  end
  object MRoleA: TMemo
    Left = 8
    Top = 301
    Width = 90
    Height = 40
    TabOrder = 9
  end
  object MRoleB: TMemo
    Left = 215
    Top = 301
    Width = 90
    Height = 40
    TabOrder = 10
  end
  object MMultiplicityA: TMemo
    Left = 8
    Top = 373
    Width = 90
    Height = 40
    TabOrder = 11
  end
  object MMultiplicityB: TMemo
    Left = 215
    Top = 373
    Width = 90
    Height = 40
    TabOrder = 12
  end
end
