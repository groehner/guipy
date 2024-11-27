inherited OutputWindow: TOutputWindow
  Left = 319
  Top = 173
  HelpContext = 450
  Caption = 'Output'
  ClientHeight = 314
  ClientWidth = 304
  ExplicitWidth = 320
  ExplicitHeight = 353
  TextHeight = 15
  inherited BGPanel: TPanel
    Width = 304
    Height = 314
    ExplicitWidth = 304
    ExplicitHeight = 314
    inherited FGPanel: TPanel
      Width = 300
      Height = 310
      ExplicitWidth = 300
      ExplicitHeight = 310
      object lsbConsole: TListBox
        Left = 0
        Top = 0
        Width = 300
        Height = 310
        TabStop = False
        Align = alClient
        BevelInner = bvNone
        BorderStyle = bsNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ItemHeight = 14
        ParentCtl3D = False
        ParentFont = False
        PopupMenu = OutputPopup
        TabOrder = 0
      end
    end
  end
  object OutputPopup: TSpTBXPopupMenu
    Images = vilImages
    Left = 28
    Top = 76
    object RunningProcess: TSpTBXSubmenuItem
      Caption = 'Running Process'
      object mnTerminate: TSpTBXItem
        Action = actToolTerminate
      end
    end
    object N1: TSpTBXSeparatorItem
    end
    object mnCopy: TSpTBXItem
      Action = actCopy
    end
    object mnClear: TSpTBXItem
      Action = actClearOutput
    end
    object N2: TSpTBXSeparatorItem
    end
    object mnFont: TSpTBXItem
      Action = actOutputFont
    end
  end
  object OutputActions: TActionList
    Images = vilImages
    OnUpdate = OutputActionsUpdate
    Left = 27
    Top = 130
    object actCopy: TAction
      Caption = 'Co&py'
      Hint = 'Copy contents to Clipboard'
      ImageIndex = 0
      ImageName = 'Copy'
      OnExecute = actCopyExecute
    end
    object actOutputFont: TAction
      Caption = 'Font...'
      Hint = 'Select font'
      ImageIndex = 5
      ImageName = 'Font'
      OnExecute = actOutputFontExecute
    end
    object actClearOutput: TAction
      Caption = 'Clear'
      Hint = 'Clear output'
      ImageIndex = 1
      ImageName = 'Delete'
      OnExecute = actClearOutputExecute
    end
    object actToolTerminate: TAction
      Caption = '&Terminate'
      Hint = 'Terminate running tool (unsafe)'
      ImageIndex = 2
      ImageName = 'Stop'
      OnExecute = actToolTerminateExecute
    end
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 16
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 111
        CollectionName = 'Stop'
        Name = 'Stop'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Exit'
        Name = 'Exit'
      end
      item
        CollectionIndex = 86
        CollectionName = 'Quit'
        Name = 'Quit'
      end
      item
        CollectionIndex = 47
        CollectionName = 'Font'
        Name = 'Font'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Width = 20
    Height = 20
    Left = 24
    Top = 240
  end
end
