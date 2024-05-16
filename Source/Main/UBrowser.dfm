object FBrowser: TFBrowser
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 333
  ClientWidth = 515
  Color = clBtnFace
  ParentFont = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 25
    Width = 515
    Height = 308
    Align = alClient
    TabOrder = 0
    SelectedEngine = EdgeIfAvailable
    OnCommandStateChange = WebBrowserCommandStateChange
    OnDownloadBegin = WebBrowserDownloadBegin
    OnDownloadComplete = WebBrowserDownloadComplete
    OnBeforeNavigate2 = WebBrowserBeforeNavigate2
    ExplicitWidth = 523
    ExplicitHeight = 310
    ControlData = {
      4C0000000E3600000A2000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PBrowser: TPanel
    Left = 0
    Top = 0
    Width = 515
    Height = 25
    Align = alTop
    TabOrder = 1
    object PTop: TPanel
      Left = 188
      Top = 1
      Width = 326
      Height = 23
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter: TSplitter
        Left = 156
        Top = 0
        Width = 4
        Height = 23
        Beveled = True
      end
      object PLeft: TPanel
        Left = 0
        Top = 0
        Width = 156
        Height = 23
        Align = alLeft
        Constraints.MinWidth = 50
        TabOrder = 0
        object CBUrls: TComboBox
          Left = 0
          Top = 1
          Width = 156
          Height = 23
          Hint = 'Enter address'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TabStop = False
          OnClick = CBUrlsClick
          OnKeyDown = CBUrlsKeyDown
        end
      end
      object PRight: TPanel
        Left = 160
        Top = 0
        Width = 166
        Height = 23
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 170
      end
    end
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 187
      Height = 23
      Align = alLeft
      Caption = 'ToolBar'
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = DMImages.ILBrowser
      TabOrder = 1
      object TBClose: TToolButton
        Left = 0
        Top = 0
        Hint = 'Close'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = TBCloseClick
      end
      object TBShowSource: TToolButton
        Left = 23
        Top = 0
        Hint = 'Show source code'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = TBShowSourceClick
      end
      object TBBack: TToolButton
        Left = 46
        Top = 0
        Hint = 'Back'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = TBBackClick
      end
      object TBForward: TToolButton
        Left = 69
        Top = 0
        Hint = 'Forward'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = TBForwardClick
      end
      object TBStop: TToolButton
        Left = 92
        Top = 0
        Hint = 'Cancel loading'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = TBStopClick
      end
      object TBRefresh: TToolButton
        Left = 115
        Top = 0
        Hint = 'Reload'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = TBRefreshClick
      end
      object TBFavoritesAdd: TToolButton
        Left = 138
        Top = 0
        Hint = 'Add to favorites'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = TBFavoritesAddClick
      end
      object TBFavoritesDelete: TToolButton
        Left = 161
        Top = 0
        Hint = 'delete as favorite '
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = TBFavoritesDeleteClick
      end
    end
  end
end
