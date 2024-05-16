object FSequenceForm: TFSequenceForm
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Sequence diagram'
  ClientHeight = 323
  ClientWidth = 594
  Color = clBtnFace
  ParentFont = True
  Position = poOwnerFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object SequenceScrollbox: TScrollBox
    Left = 0
    Top = 22
    Width = 594
    Height = 301
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    OnResize = SequenceScrollboxResize
    ExplicitWidth = 590
    ExplicitHeight = 300
  end
  object EMessage: TEdit
    Left = 456
    Top = 31
    Width = 121
    Height = 23
    TabOrder = 0
    Visible = False
  end
  object SequenceToolbar: TToolBar
    Left = 0
    Top = 0
    Width = 594
    Height = 22
    AutoSize = True
    Images = DMImages.ILSequenceToolbar
    TabOrder = 2
    ExplicitWidth = 590
    object TBClose: TToolButton
      Left = 0
      Top = 0
      Hint = 'Close'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = TBCloseClick
    end
    object TBLifeLine: TToolButton
      Left = 23
      Top = 0
      Hint = 'New lifeline'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = MIPopupNewLifeLineClick
    end
    object TBActor: TToolButton
      Left = 46
      Top = 0
      Hint = 'New actor'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = MIPopupNewActorClick
    end
    object TBZoomOut: TToolButton
      Left = 69
      Top = 0
      Hint = 'Zoom out'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = TBZoomOutClick
    end
    object TBZoomIn: TToolButton
      Left = 92
      Top = 0
      Hint = 'Zoom in'
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = TBZoomInClick
    end
    object TBNewLayout: TToolButton
      Left = 115
      Top = 0
      Hint = 'New layout'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      OnClick = MIPopupNewLayoutClick
    end
    object TBRefresh: TToolButton
      Left = 138
      Top = 0
      Hint = 'Refresh'
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = MIPopupRefreshClick
    end
  end
  object PopupMenuConnection: TSpTBXPopupMenu
    Images = DMImages.ILSequencediagramLight
    OnPopup = PopupMenuConnectionPopup
    Left = 64
    Top = 49
    object MISynchron: TSpTBXItem
      Caption = 'Synchron'
      ImageIndex = 0
      OnClick = MIConnectionClick
    end
    object MIAsynchron: TSpTBXItem
      Tag = 1
      Caption = 'Asynchron'
      ImageIndex = 1
      OnClick = MIConnectionClick
    end
    object MIReturn: TSpTBXItem
      Tag = 2
      Caption = 'Return'
      ImageIndex = 2
      OnClick = MIConnectionClick
    end
    object MINew: TSpTBXItem
      Tag = 3
      Caption = 'New'
      ImageIndex = 3
      OnClick = MIConnectionClick
    end
    object MIClose: TSpTBXItem
      Tag = 4
      Caption = 'Close'
      ImageIndex = 4
      OnClick = MIConnectionClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIMessage: TSpTBXItem
      Tag = 5
      Caption = 'Message'
      ImageIndex = 5
      OnClick = MIConnectionClick
    end
    object MITurn: TSpTBXItem
      Tag = 6
      Caption = 'Turn'
      ImageIndex = 6
      OnClick = MIConnectionClick
    end
    object MIDelete: TSpTBXItem
      Tag = 7
      Caption = 'Delete'
      ImageIndex = 7
      OnClick = MIConnectionClick
    end
  end
  object PopupMenuLifeLineAndSequencePanel: TSpTBXPopupMenu
    Images = DMImages.ILSequenceToolbar
    OnPopup = PopupMenuLifeLineAndSequencePanelPopup
    Left = 272
    Top = 41
    object MIPopupNewLifeLine: TSpTBXItem
      Caption = 'New lifeline'
      ImageIndex = 1
      OnClick = MIPopupNewLifeLineClick
    end
    object MIPopupNewActor: TSpTBXItem
      Caption = 'New actor'
      ImageIndex = 2
      OnClick = MIPopupNewActorClick
    end
    object MIPopupCreateObject: TSpTBXItem
      Caption = 'Create object'
      ImageIndex = 3
      OnClick = MIPopupCreateObjectClick
    end
    object MIPopupConnectWith: TSpTBXSubmenuItem
      Caption = 'Connect with'
    end
    object MIPopupDeleteLifeLine: TSpTBXItem
      Caption = 'Delete lifeline'
      ImageIndex = 7
      OnClick = MIPopupDeleteLifeLineClick
    end
    object MIPopupNewLayout: TSpTBXItem
      Caption = 'New layout'
      ImageIndex = 5
      OnClick = MIPopupNewLayoutClick
    end
    object MIPopupRefresh: TSpTBXItem
      Caption = 'Refresh'
      ImageIndex = 6
      OnClick = MIPopupRefreshClick
    end
    object MIPopupAsText: TSpTBXItem
      Caption = 'As text'
      ImageIndex = 8
      OnClick = MIPopupAsTextClick
    end
    object MIFont: TSpTBXItem
      Caption = 'Font'
      ImageIndex = 10
      OnClick = MIPopupFontClick
    end
    object MIPopupConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 9
      OnClick = MIPopupConfigurationClick
    end
  end
end
