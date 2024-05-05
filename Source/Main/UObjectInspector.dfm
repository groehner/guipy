object FObjectInspector: TFObjectInspector
  Left = 71
  Top = 270
  BorderStyle = bsSizeToolWin
  Caption = 'Object Inspector'
  ClientHeight = 437
  ClientWidth = 247
  Color = clBtnFace
  Constraints.MinHeight = 150
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  PopupMenu = PMObjectInspector
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnMouseActivate = FormMouseActivate
  OnShow = FormShow
  TextHeight = 15
  object TCAttributesEvents: TTabControl
    Left = 0
    Top = 23
    Width = 247
    Height = 25
    Align = alTop
    TabOrder = 0
    Tabs.Strings = (
      'Attributes'
      'Events')
    TabIndex = 0
    OnChange = TCAttributesEventsChange
    OnMouseDown = TCAttributesEventsMouseDown
    ExplicitWidth = 239
  end
  object PNewDel: TPanel
    Left = 0
    Top = 412
    Width = 247
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 400
    ExplicitWidth = 239
    DesignSize = (
      247
      25)
    object BNewDelete: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 0
      Visible = False
      OnClick = BNewDeleteClick
    end
    object BMore: TButton
      Left = 124
      Top = 0
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'More'
      TabOrder = 1
      OnClick = BMoreClick
      ExplicitLeft = 116
    end
  end
  object CBObjects: TComboBox
    Left = 0
    Top = 0
    Width = 247
    Height = 23
    Align = alTop
    Style = csDropDownList
    Sorted = True
    TabOrder = 2
    OnChange = CBObjectsChange
    ExplicitWidth = 239
  end
  object PMObjectInspector: TSpTBXPopupMenu
    Left = 32
    Top = 80
    object MICut: TSpTBXItem
      Caption = 'Cut'
      ImageIndex = 2
      ShortCut = 16472
      OnClick = MICutClick
    end
    object MICopy: TSpTBXItem
      Caption = 'Copy'
      ImageIndex = 3
      ShortCut = 16451
      OnClick = MICopyClick
    end
    object MIPaste: TSpTBXItem
      Caption = 'Paste'
      ImageIndex = 4
      ShortCut = 16470
      OnClick = MIPasteClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIDefaultLayout: TSpTBXItem
      Caption = 'Default layout'
      OnClick = MIDefaultLayoutClick
    end
    object MIFont: TSpTBXItem
      Caption = 'Font'
      ImageIndex = 0
      OnClick = MIFontClick
    end
    object MIClose: TSpTBXItem
      Caption = 'Close'
      ImageIndex = 1
      OnClick = MICloseClick
    end
  end
end
