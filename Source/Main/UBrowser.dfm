object FBrowser: TFBrowser
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 332
  ClientWidth = 511
  Color = clBtnFace
  ParentFont = True
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 25
    Width = 511
    Height = 307
    Align = alClient
    TabOrder = 0
    SelectedEngine = EdgeIfAvailable
    OnCommandStateChange = WebBrowserCommandStateChange
    OnDownloadBegin = WebBrowserDownloadBegin
    OnDownloadComplete = WebBrowserDownloadComplete
    OnBeforeNavigate2 = WebBrowserBeforeNavigate2
    ControlData = {
      4C000000D0340000BB1F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PBrowser: TPanel
    Left = 0
    Top = 0
    Width = 511
    Height = 25
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 507
    object PTop: TPanel
      Left = 188
      Top = 1
      Width = 322
      Height = 23
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 318
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
        Width = 162
        Height = 23
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 158
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
      Images = vilBrowserDark
      TabOrder = 1
      object TBClose: TToolButton
        Left = 0
        Top = 0
        Hint = 'Close'
        ImageIndex = 0
        ImageName = 'Close'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBCloseClick
      end
      object TBShowSource: TToolButton
        Left = 23
        Top = 0
        Hint = 'Show source code'
        ImageIndex = 1
        ImageName = 'ShowSource'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBShowSourceClick
      end
      object TBBack: TToolButton
        Left = 46
        Top = 0
        Hint = 'Back'
        ImageIndex = 2
        ImageName = 'Backward'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBBackClick
      end
      object TBForward: TToolButton
        Left = 69
        Top = 0
        Hint = 'Forward'
        ImageIndex = 3
        ImageName = 'Forward'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBForwardClick
      end
      object TBStop: TToolButton
        Left = 92
        Top = 0
        Hint = 'Cancel loading'
        ImageIndex = 4
        ImageName = 'AbortOff'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBStopClick
      end
      object TBRefresh: TToolButton
        Left = 115
        Top = 0
        Hint = 'Reload'
        ImageIndex = 6
        ImageName = 'Refresh'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBRefreshClick
      end
      object TBFavoritesAdd: TToolButton
        Left = 138
        Top = 0
        Hint = 'Add to favorites'
        ImageIndex = 7
        ImageName = 'FavoritAdd'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBFavoritesAddClick
      end
      object TBFavoritesDelete: TToolButton
        Left = 161
        Top = 0
        Hint = 'delete as favorite '
        ImageIndex = 8
        ImageName = 'FavoritDelete'
        ParentShowHint = False
        ShowHint = True
        OnClick = TBFavoritesDeleteClick
      end
    end
  end
  object icBrowser: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Close'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ShowSource'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7e7e" d="M2 0h13M' +
          '2 1h1M2 2h1M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 1' +
          '1h1M2 12h1M2 13h1M2 14h1" />'#13#10'<path stroke="#ffffff" d="M3 1h11M' +
          '3 2h11M3 3h1M6 3h8M3 4h11M3 5h11M3 6h1M13 6h1M3 7h11M3 8h1M12 8h' +
          '2M3 9h11M3 10h1M13 10h1M3 11h11M4 13h10" />'#13#10'<path stroke="#0000' +
          '00" d="M14 1h1M14 2h1M14 3h1M14 4h1M14 5h1M14 6h1M14 7h1M14 8h1M' +
          '14 9h1M14 10h1M14 11h1M14 12h1M14 13h1M14 14h1" />'#13#10'<path stroke' +
          '="#00007e" d="M4 3h2M4 6h9M4 8h8M4 10h9M4 12h9" />'#13#10'<path stroke' +
          '="#fdfdfd" d="M3 12h1M13 12h1M3 13h1" />'#13#10'<path stroke="#555555"' +
          ' d="M3 14h11" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Backward'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M6 3h1M6' +
          ' 4h1M6 5h1M6 6h1M2 8h1M3 9h1M6 9h7M4 10h1M6 10h1M5 11h2M6 12h1" ' +
          '/>'#13#10'<path stroke="#3360ff" d="M5 4h1M4 5h1M3 6h1M7 6h6M2 7h1M12 ' +
          '7h1M12 8h1" />'#13#10'<path stroke="#97ffff" d="M5 5h1M4 6h2M3 7h9" />' +
          #13#10'<path stroke="#3396ff" d="M3 8h1M5 8h7M4 9h2M5 10h1" />'#13#10'<path' +
          ' stroke="#34c6ff" d="M4 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Forward'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#3462ff" d="M9 3h1M9' +
          ' 4h1M9 5h1M2 6h8M2 7h1M2 8h1M12 8h1M11 9h1M10 10h1" />'#13#10'<path st' +
          'roke="#000000" d="M10 4h1M11 5h1M12 6h1M13 7h1M13 8h1M2 9h8M12 9' +
          'h1M9 10h1M11 10h1M9 11h2M9 12h1" />'#13#10'<path stroke="#35ccff" d="M' +
          '10 5h1M11 6h1M12 7h1M11 8h1" />'#13#10'<path stroke="#ccffff" d="M10 6' +
          'h1M3 7h8" />'#13#10'<path stroke="#9affff" d="M11 7h1" />'#13#10'<path strok' +
          'e="#349aff" d="M3 8h8M10 9h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'AbortOff'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7e7e" d="M5 0h6M3' +
          ' 1h2M10 1h1M9 2h3M1 3h1M7 3h6M1 4h1M5 4h8M0 5h1M4 5h1M7 5h2M11 5' +
          'h2M0 6h1M4 6h2M10 6h3M0 7h1M4 7h3M9 7h4M0 8h1M3 8h3M10 8h3M0 9h1' +
          'M4 9h1M7 9h2M11 9h1M0 10h1M3 10h9M1 11h1M4 11h7M1 12h1M4 12h5M2 ' +
          '13h1" />'#13#10'<path stroke="#aeaeae" d="M5 1h5M3 2h2M8 2h1M2 3h1M6 3' +
          'h1M2 4h1M1 5h1M3 5h1M1 6h1M1 7h1M3 7h1M1 8h1M1 9h1M1 10h2M3 11h1' +
          'M3 12h1" />'#13#10'<path stroke="#000000" d="M11 1h2M13 2h1M14 3h1M14 ' +
          '4h1M15 5h1M15 6h1M15 7h1M15 8h1M15 9h1M15 10h1M14 11h1M14 12h1M1' +
          '3 13h1M3 14h2M11 14h2M5 15h6" />'#13#10'<path stroke="#979797" d="M2 2' +
          'h1M3 9h1" />'#13#10'<path stroke="#d6d6d6" d="M5 2h2M3 3h2M3 4h1M2 5h1' +
          'M2 6h1M2 7h1M2 8h1M2 9h1" />'#13#10'<path stroke="#cacaca" d="M7 2h1M5' +
          ' 3h1M4 4h1M3 6h1M2 11h1" />'#13#10'<path stroke="#606060" d="M12 2h1M1' +
          '3 4h1M13 5h1M13 6h1M13 7h1M13 8h1M12 9h2M12 10h1M11 11h2M2 12h1M' +
          '9 12h3M3 13h7" />'#13#10'<path stroke="#494949" d="M13 3h1M14 5h1M14 6' +
          'h1M14 7h1M14 8h1M14 9h1M13 10h2M13 11h1M12 12h2M10 13h3M5 14h6" ' +
          '/>'#13#10'<path stroke="#ffffff" d="M5 5h2M9 5h2M6 6h4M7 7h2M6 8h4M5 9' +
          'h2M9 9h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'AbortOn'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#10'<path stroke="#960000" d="M5 0h6M3 ' +
          '1h2M2 2h1M1 3h1M13 3h1M1 4h1M0 5h1M14 5h1M0 6h1M14 6h1M0 7h1M14 ' +
          '7h1M0 8h1M14 8h1M0 9h1M14 9h1M0 10h1M13 10h2M1 11h1M13 11h1M1 12' +
          'h1M12 12h2M2 13h1M10 13h3M5 14h6" />'#10'<path stroke="#c66060" d="M' +
          '5 1h1M3 2h1M2 3h1M1 5h1" />'#10'<path stroke="#fe6060" d="M6 1h4M4 2' +
          'h1M2 4h1M1 6h1M1 7h1M1 8h1M1 9h1M1 10h1" />'#10'<path stroke="#c6000' +
          '0" d="M10 1h1M12 2h1M13 4h1M13 5h1M13 6h1M13 7h1M13 8h1M12 9h2M1' +
          '2 10h1M11 11h2M2 12h1M9 12h3M3 13h7" />'#10'<path stroke="#000000" d' +
          '="M11 1h2M13 2h1M14 3h1M14 4h1M15 5h1M15 6h1M15 7h1M15 8h1M15 9h' +
          '1M15 10h1M14 11h1M14 12h1M13 13h1M3 14h2M11 14h2M5 15h6" />'#10'<pat' +
          'h stroke="#fe9633" d="M5 2h2M3 3h2M3 4h1M2 5h1M2 6h1M2 7h1M2 8h1' +
          'M2 9h1" />'#10'<path stroke="#fe6000" d="M7 2h2M5 3h2M4 4h1M3 5h1M3 ' +
          '6h1M2 10h1M2 11h1M3 12h1" />'#10'<path stroke="#fe0033" d="M9 2h3M7 ' +
          '3h6M5 4h8M4 5h1M7 5h2M11 5h2M4 6h2M10 6h3M3 7h4M9 7h4M3 8h3M10 8' +
          'h3M3 9h2M7 9h2M11 9h1M3 10h9M3 11h8M4 12h5" />'#10'<path stroke="#ff' +
          'ffff" d="M5 5h2M9 5h2M6 6h4M7 7h2M6 8h4M5 9h2M9 9h2" />'#10'</svg>'
      end
      item
        IconName = 'Refresh'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4b4b4b" d="M1 0h11M' +
          '1 1h1M11 1h2M1 2h1M11 2h1M13 2h1M1 3h1M11 3h4M1 4h1M14 4h1M1 5h1' +
          'M14 5h1M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10' +
          'h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M1' +
          '4 14h1M1 15h14" />'#13#10'<path stroke="#ffffff" d="M2 1h9M2 2h9M12 2h' +
          '1M2 3h5M8 3h3M2 4h5M9 4h5M2 5h3M10 5h4M2 6h2M5 6h2M9 6h5M2 7h2M5' +
          ' 7h2M8 7h6M2 8h2M5 8h5M11 8h3M2 9h5M8 9h2M11 9h3M2 10h4M8 10h2M1' +
          '1 10h3M2 11h3M10 11h4M2 12h4M8 12h6M2 13h5M8 13h6M2 14h12" />'#13#10'<' +
          'path stroke="#4ba34b" d="M7 3h1M7 4h2M5 5h5M4 6h1M7 6h2M4 7h1M7 ' +
          '7h1M4 8h1M10 8h1M7 9h1M10 9h1M6 10h2M10 10h1M5 11h5M6 12h2M7 13h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'FavoritAdd'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M0 0h9M1' +
          '3 0h1M0 1h1M8 1h1M13 1h1M0 2h1M8 2h1M11 2h5M0 3h1M8 3h1M13 3h1M0' +
          ' 4h1M6 4h4M13 4h1M0 5h1M5 5h1M10 5h1M0 6h1M4 6h1M11 6h5M0 7h1M4 ' +
          '7h1M15 7h1M0 8h1M4 8h1M10 8h1M15 8h1M0 9h1M4 9h1M9 9h1M11 9h1M15' +
          ' 9h1M0 10h5M8 10h1M12 10h1M15 10h1M4 11h1M9 11h1M11 11h1M15 11h1' +
          'M4 12h1M10 12h1M15 12h1M4 13h1M15 13h1M4 14h12" />'#13#10'<path stroke' +
          '="#ffffff" d="M1 1h7M1 2h1M4 2h1M7 2h1M1 3h1M4 3h4M1 4h1M4 4h1M1' +
          ' 5h4M6 5h1M1 6h1M1 7h3M5 7h1M7 7h1M9 7h1M11 7h1M13 7h1M1 8h1M1 9' +
          'h3M5 9h1M10 10h1M5 11h1M5 13h1" />'#13#10'<path stroke="#088200" d="M2' +
          ' 2h2M2 3h2M2 4h2" />'#13#10'<path stroke="#0000ff" d="M5 2h2M2 6h2M2 8' +
          'h2" />'#13#10'<path stroke="#828282" d="M5 4h1M10 4h1" />'#13#10'<path strok' +
          'e="#828200" d="M5 6h6" />'#13#10'<path stroke="#ffff00" d="M6 7h1M8 7h' +
          '1M10 7h1M12 7h1M14 7h1M5 8h1M7 8h1M13 8h1M6 9h1M14 9h1M5 10h1M7 ' +
          '10h1M13 10h1M6 11h1M14 11h1M5 12h1M7 12h1M13 12h1M6 13h1M8 13h1M' +
          '10 13h1M12 13h1M14 13h1" />'#13#10'<path stroke="#000082" d="M8 8h1M12' +
          ' 8h1M10 9h1M9 10h1M11 10h1M10 11h1M8 12h1M12 12h1" />'#13#10'</svg>'
      end
      item
        IconName = 'FavoritDelete'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M0 0h9M0' +
          ' 1h1M8 1h1M0 2h1M8 2h1M11 2h5M0 3h1M8 3h1M0 4h1M6 4h4M0 5h1M5 5h' +
          '1M10 5h1M0 6h1M4 6h1M11 6h5M0 7h1M4 7h1M15 7h1M0 8h1M4 8h1M10 8h' +
          '1M15 8h1M0 9h1M4 9h1M9 9h1M11 9h1M15 9h1M0 10h5M8 10h1M12 10h1M1' +
          '5 10h1M4 11h1M9 11h1M11 11h1M15 11h1M4 12h1M10 12h1M15 12h1M4 13' +
          'h1M15 13h1M4 14h12" />'#13#10'<path stroke="#ffffff" d="M1 1h7M1 2h1M4' +
          ' 2h1M7 2h1M1 3h1M4 3h4M1 4h1M4 4h1M1 5h4M6 5h1M1 6h1M1 7h3M5 7h1' +
          'M7 7h1M9 7h1M11 7h1M13 7h1M1 8h1M1 9h3M5 9h1M10 10h1M5 11h1M5 13' +
          'h1" />'#13#10'<path stroke="#088000" d="M2 2h2M2 3h2M2 4h2" />'#13#10'<path ' +
          'stroke="#0000ff" d="M5 2h2M2 6h2M2 8h2" />'#13#10'<path stroke="#82848' +
          '2" d="M5 4h1M10 4h1" />'#13#10'<path stroke="#828000" d="M5 6h6" />'#13#10'<' +
          'path stroke="#ffff00" d="M6 7h1M8 7h1M10 7h1M12 7h1M14 7h1M5 8h1' +
          'M7 8h1M13 8h1M6 9h1M14 9h1M5 10h1M7 10h1M13 10h1M6 11h1M14 11h1M' +
          '5 12h1M7 12h1M13 12h1M6 13h1M8 13h1M10 13h1M12 13h1M14 13h1" />'#13 +
          #10'<path stroke="#000082" d="M8 8h1M12 8h1M10 9h1M9 10h1M11 10h1M1' +
          '0 11h1M8 12h1M12 12h1" />'#13#10'</svg>'
      end
      item
        IconName = 'Close'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#ffffff">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Backward'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M6 3h1M6' +
          ' 4h1M6 5h1M6 6h1M2 8h1M3 9h1M6 9h7M4 10h1M6 10h1M5 11h2M6 12h1" ' +
          '/>'#13#10'<path stroke="#3360ff" d="M5 4h1M4 5h1M3 6h1M7 6h6M2 7h1M12 ' +
          '7h1M12 8h1" />'#13#10'<path stroke="#97ffff" d="M5 5h1M4 6h2M3 7h9" />' +
          #13#10'<path stroke="#3396ff" d="M3 8h1M5 8h7M4 9h2M5 10h1" />'#13#10'<path' +
          ' stroke="#34c6ff" d="M4 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Forward'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#3462ff" d="M9 3h1M9' +
          ' 4h1M9 5h1M2 6h8M2 7h1M2 8h1M12 8h1M11 9h1M10 10h1" />'#13#10'<path st' +
          'roke="#ffffff" d="M10 4h1M11 5h1M12 6h1M13 7h1M13 8h1M2 9h8M12 9' +
          'h1M9 10h1M11 10h1M9 11h2M9 12h1" />'#13#10'<path stroke="#35ccff" d="M' +
          '10 5h1M11 6h1M12 7h1M11 8h1" />'#13#10'<path stroke="#ccffff" d="M10 6' +
          'h1M3 7h8" />'#13#10'<path stroke="#9affff" d="M11 7h1" />'#13#10'<path strok' +
          'e="#349aff" d="M3 8h8M10 9h1" />'#13#10'</svg>'#13#10
      end>
    Left = 184
    Top = 48
  end
  object vilBrowserLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ShowSource'
        Name = 'ShowSource'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Backward'
        Name = 'Backward'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Forward'
        Name = 'Forward'
      end
      item
        CollectionIndex = 4
        CollectionName = 'AbortOff'
        Name = 'AbortOff'
      end
      item
        CollectionIndex = 5
        CollectionName = 'AbortOn'
        Name = 'AbortOn'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 7
        CollectionName = 'FavoritAdd'
        Name = 'FavoritAdd'
      end
      item
        CollectionIndex = 8
        CollectionName = 'FavoritDelete'
        Name = 'FavoritDelete'
      end>
    ImageCollection = icBrowser
    Left = 64
    Top = 48
  end
  object vilBrowserDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 9
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ShowSource'
        Name = 'ShowSource'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Backward'
        Name = 'Backward'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Forward'
        Name = 'Forward'
      end
      item
        CollectionIndex = 4
        CollectionName = 'AbortOff'
        Name = 'AbortOff'
      end
      item
        CollectionIndex = 5
        CollectionName = 'AbortOn'
        Name = 'AbortOn'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 7
        CollectionName = 'FavoritAdd'
        Name = 'FavoritAdd'
      end
      item
        CollectionIndex = 8
        CollectionName = 'FavoritDelete'
        Name = 'FavoritDelete'
      end>
    ImageCollection = icBrowser
    Left = 64
    Top = 128
  end
end
