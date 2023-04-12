object DocForm: TDocForm
  Left = 417
  Top = 88
  HelpContext = 850
  Caption = 'Documentation'
  ClientHeight = 446
  ClientWidth = 463
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object TBXDock1: TSpTBXDock
    Left = 0
    Top = 0
    Width = 463
    Height = 30
    AllowDrag = False
    object TBXToolbar1: TSpTBXToolbar
      Left = 0
      Top = 0
      DockPos = 0
      FullSize = True
      Images = BrowserImages
      TabOrder = 0
      Caption = 'TBXToolbar1'
      Customizable = False
      object ToolButtonBack: TSpTBXItem
        Hint = 'Go Back'
        ImageIndex = 0
        ImageName = 'Back'
        OnClick = ToolButtonBackClick
      end
      object ToolButtonForward: TSpTBXItem
        Hint = 'Go Forward'
        ImageIndex = 1
        ImageName = 'Forward'
        OnClick = ToolButtonForwardClick
      end
      object TBXSeparatorItem1: TSpTBXSeparatorItem
      end
      object TBXItem3: TSpTBXItem
        Hint = 'Stop'
        ImageIndex = 2
        ImageName = 'Cancel'
        OnClick = ToolButtonStopClick
      end
      object TBXSeparatorItem2: TSpTBXSeparatorItem
      end
      object TBXItem5: TSpTBXItem
        Hint = 'Print'
        ImageIndex = 5
        ImageName = 'Print'
        OnClick = ToolButtonPrintClick
      end
      object TBXSeparatorItem4: TSpTBXSeparatorItem
      end
      object TBXItem7: TSpTBXItem
        Hint = 'Save'
        ImageIndex = 6
        ImageName = 'Save'
        OnClick = ToolButtonSaveClick
      end
    end
  end
  object WebBrowser: TEdgeBrowser
    Left = 0
    Top = 30
    Width = 463
    Height = 416
    HelpContext = 850
    Align = alClient
    TabOrder = 0
    TabStop = True
    OnCreateWebViewCompleted = WebBrowserCreateWebViewCompleted
  end
  object BrowserImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Browser\Back'
        Disabled = False
        Name = 'Back'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Browser\Forward'
        Disabled = False
        Name = 'Forward'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Browser\Cancel'
        Disabled = False
        Name = 'Cancel'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Browser\PageSetup'
        Disabled = False
        Name = 'PageSetup'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Browser\Preview'
        Disabled = False
        Name = 'Preview'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Browser\Print'
        Disabled = False
        Name = 'Print'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Browser\Save'
        Disabled = False
        Name = 'Save'
      end>
    ImageCollection = CommandsDataModule.icBrowserImages
    PreserveItems = True
    Width = 20
    Height = 20
    Left = 40
    Top = 88
  end
end
