object FGUIDesigner: TFGUIDesigner
  Left = 564
  Top = 308
  Caption = 'GUI designer'
  ClientHeight = 368
  ClientWidth = 356
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object GUIDesignerTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = GUIDesignerTimerTimer
    Left = 24
    Top = 88
  end
  object PopupMenu: TSpTBXPopupMenu
    Images = vilGuiDesignerLight
    OnPopup = PopupMenuPopup
    Left = 24
    Top = 8
    object MIClose: TSpTBXItem
      Caption = 'Close'
      ImageIndex = 0
      ImageName = 'Close1'
      OnClick = MICloseClick
    end
    object MIToSource: TSpTBXItem
      Caption = 'to sourcecode'
      ImageIndex = 1
      ImageName = 'OpenSource'
      OnClick = MIToSourceClick
    end
    object MIForeground: TSpTBXItem
      Caption = 'to foreground'
      ImageIndex = 2
      ImageName = 'ToFront'
      OnClick = MIForegroundClick
    end
    object MIBackground: TSpTBXItem
      Caption = 'to background'
      ImageIndex = 3
      ImageName = 'ToBack'
      OnClick = MIBackgroundClick
    end
    object SpTBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object MIAlign: TSpTBXSubmenuItem
      Caption = 'Align'
      ImageIndex = 4
      ImageName = 'Left1'
      object MIAlignLeft: TSpTBXItem
        Tag = 1
        Caption = 'Left'
        ImageIndex = 9
        OnClick = MIAlignClick
      end
      object MIAlignCentered: TSpTBXItem
        Tag = 2
        Caption = 'Centered'
        ImageIndex = 10
        OnClick = MIAlignClick
      end
      object MIAlignRight: TSpTBXItem
        Tag = 3
        Caption = 'Right'
        ImageIndex = 11
        OnClick = MIAlignClick
      end
      object MIAlignCenteredInWindowHorz: TSpTBXItem
        Tag = 4
        Caption = 'Centered in window'
        ImageIndex = 12
        OnClick = MIAlignClick
      end
      object MISameDistanceHorz: TSpTBXItem
        Tag = 5
        Caption = 'Same distance'
        ImageIndex = 13
        OnClick = MIAlignClick
      end
      object SpTBXSeparatorItem4: TSpTBXSeparatorItem
      end
      object MIAlignTop: TSpTBXItem
        Tag = 6
        Caption = 'Above'
        ImageIndex = 14
        OnClick = MIAlignClick
      end
      object MIAlignMiddle: TSpTBXItem
        Tag = 7
        Caption = 'Center'
        ImageIndex = 15
        OnClick = MIAlignClick
      end
      object MIAlignBottom: TSpTBXItem
        Tag = 8
        Caption = 'Below'
        ImageIndex = 16
        OnClick = MIAlignClick
      end
      object MIAlignCenteredInWindowVert: TSpTBXItem
        Tag = 9
        Caption = 'Centered in window'
        ImageIndex = 17
        OnClick = MIAlignClick
      end
      object MISameDistanceVert: TSpTBXItem
        Tag = 10
        Caption = 'Same distance'
        ImageIndex = 18
        OnClick = MIAlignClick
      end
    end
    object SpTBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object MISnapToGrid: TSpTBXItem
      Caption = 'Snap to grid'
      OnClick = MISnapToGridClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIDelete: TSpTBXItem
      Caption = 'Delete'
      ImageIndex = 5
      ImageName = 'Delete1'
      OnClick = MIDeleteClick
    end
    object MICut: TSpTBXItem
      Caption = 'Cut'
      ImageIndex = 6
      ImageName = 'Cut1'
      ShortCut = 16472
      OnClick = CutClick
    end
    object MICopy: TSpTBXItem
      Caption = 'Copy'
      ImageIndex = 7
      ImageName = 'Copy1'
      ShortCut = 16451
      OnClick = CopyClick
    end
    object MIPaste: TSpTBXItem
      Caption = 'Paste'
      ImageIndex = 8
      ImageName = 'Paste1'
      ShortCut = 16470
      OnClick = PasteClick
    end
    object SpTBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object MIZoomIn: TSpTBXItem
      Caption = 'Font zoom in'
      ImageIndex = 19
      ImageName = 'ZoomOut'
      OnClick = MIZoomInClick
    end
    object MIZoomOut: TSpTBXItem
      Caption = 'Font zoom out'
      ImageIndex = 20
      ImageName = 'ZoomIn'
      OnClick = MIZoomOutClick
    end
    object SpTBXSeparatorItem6: TSpTBXSeparatorItem
    end
    object MIConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 21
      ImageName = 'Configuration'
      OnClick = MIConfigurationClick
    end
  end
  object scGuiDesignerLight: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Close1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'OpenSource'
        SVGText = 
          '<svg viewBox="0 -0.5 14 17">'#13#10'<path stroke="#656565" d="M1 0h9M0' +
          ' 1h1M9 1h2M0 2h1M9 2h1M11 2h1M0 3h1M9 3h1M0 4h1M9 4h3M0 5h1M0 6h' +
          '1M0 7h1M0 8h1M0 9h1M0 10h1M0 11h1M0 12h1M0 13h1M0 14h1" />'#13#10'<pat' +
          'h stroke="#ffffff" d="M1 1h8M1 2h8M1 3h1M8 3h1M1 4h8M1 5h3M8 5h3' +
          'M1 6h11M1 7h3M11 7h1M1 8h11M1 9h1M11 9h1M1 10h11M1 11h3M11 11h1M' +
          '1 12h11M1 13h1M11 13h1" />'#13#10'<path stroke="#ffffe9" d="M10 2h1M10' +
          ' 3h2" />'#13#10'<path stroke="#4b4b4b" d="M2 3h6M4 5h4M4 7h7M2 9h9M4 1' +
          '1h7M2 13h9M1 15h12" />'#13#10'<path stroke="#4e4e4e" d="M12 3h1M12 4h2' +
          'M13 5h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M13 1' +
          '3h1M13 14h1" />'#13#10'<path stroke="#fcfade" d="M11 5h2M12 6h1M12 7h1' +
          'M12 8h1M12 9h1M12 10h1M12 11h1M12 12h1M12 13h1M1 14h12" />'#13#10'<pat' +
          'h stroke="#8f8f8f" d="M0 15h1M13 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ToFront'
        SVGText = 
          '<svg viewBox="0 -0.5 18 18">'#13#10'<path stroke="#526e2e" d="M5 1h12M' +
          '5 2h1M16 2h1M5 3h1M16 3h1M5 4h1M16 4h1M5 5h1M16 5h1M5 6h1M16 6h1' +
          'M5 7h1M16 7h1M5 8h1M16 8h1M5 9h1M16 9h1M5 10h1M16 10h1M5 11h1M16' +
          ' 11h1M5 12h12" />'#13#10'<path stroke="#cedbbf" d="M6 2h1" />'#13#10'<path s' +
          'troke="#b4c99e" d="M7 2h4M6 3h1M6 4h1M6 5h1M6 6h1M6 7h1M6 8h1M6 ' +
          '9h1" />'#13#10'<path stroke="#bacda2" d="M11 2h1" />'#13#10'<path stroke="#b' +
          'bcea3" d="M12 2h1" />'#13#10'<path stroke="#bfd2a7" d="M13 2h1" />'#13#10'<p' +
          'ath stroke="#c1d4a9" d="M14 2h2" />'#13#10'<path stroke="#8faf6d" d="M' +
          '7 3h3M7 4h2M7 5h2M7 6h2M7 7h2" />'#13#10'<path stroke="#93b371" d="M10' +
          ' 3h1" />'#13#10'<path stroke="#95b371" d="M11 3h1" />'#13#10'<path stroke="#' +
          '99b675" d="M12 3h1M11 5h1" />'#13#10'<path stroke="#9ebb7a" d="M13 3h1' +
          'M10 7h1" />'#13#10'<path stroke="#9dbb79" d="M14 3h1" />'#13#10'<path stroke' +
          '="#a6c181" d="M15 3h1" />'#13#10'<path stroke="#91b16f" d="M9 4h1" />'#13 +
          #10'<path stroke="#95b573" d="M10 4h1" />'#13#10'<path stroke="#96b472" d' +
          '="M11 4h1" />'#13#10'<path stroke="#9cb879" d="M12 4h1" />'#13#10'<path stro' +
          'ke="#a0be7c" d="M13 4h1" />'#13#10'<path stroke="#a5c080" d="M14 4h1M1' +
          '0 11h1" />'#13#10'<path stroke="#a6c182" d="M15 4h1M14 5h1" />'#13#10'<path ' +
          'stroke="#93b271" d="M9 5h1" />'#13#10'<path stroke="#96b574" d="M10 5h' +
          '1M9 6h1" />'#13#10'<path stroke="#9cba78" d="M12 5h1" />'#13#10'<path stroke' +
          '="#a3bf7e" d="M13 5h1" />'#13#10'<path stroke="#a8c483" d="M15 5h1" />' +
          #13#10'<path stroke="#9ab676" d="M10 6h1M9 8h1" />'#13#10'<path stroke="#9d' +
          'ba79" d="M11 6h1M10 9h1" />'#13#10'<path stroke="#a2bf7d" d="M12 6h1" ' +
          '/>'#13#10'<path stroke="#a5c081" d="M13 6h1" />'#13#10'<path stroke="#a6c281' +
          '" d="M14 6h1" />'#13#10'<path stroke="#abc586" d="M15 6h1" />'#13#10'<path s' +
          'troke="#a9a9a9" d="M1 7h4M1 8h1M1 9h1M1 10h1M1 11h1M1 12h1M1 13h' +
          '1M12 13h1M1 14h1M12 14h1M1 15h1M12 15h1M1 16h12" />'#13#10'<path strok' +
          'e="#99b676" d="M9 7h1" />'#13#10'<path stroke="#a1bf7e" d="M11 7h1" />' +
          #13#10'<path stroke="#a1bd7c" d="M12 7h1" />'#13#10'<path stroke="#a3be7f" ' +
          'd="M13 7h1" />'#13#10'<path stroke="#a9c485" d="M14 7h1" />'#13#10'<path str' +
          'oke="#abc786" d="M15 7h1M12 11h1" />'#13#10'<path stroke="#e3e3e3" d="' +
          'M2 8h1" />'#13#10'<path stroke="#d7d7d7" d="M3 8h2M2 9h1M2 10h1M2 11h1' +
          'M2 12h1M2 13h1M2 14h1M2 15h1" />'#13#10'<path stroke="#92af6d" d="M7 8' +
          'h1" />'#13#10'<path stroke="#96b272" d="M8 8h1" />'#13#10'<path stroke="#a0b' +
          'd7b" d="M10 8h1" />'#13#10'<path stroke="#9fbc7b" d="M11 8h1M9 10h1" /' +
          '>'#13#10'<path stroke="#a4bf80" d="M12 8h1" />'#13#10'<path stroke="#a9c683"' +
          ' d="M13 8h1" />'#13#10'<path stroke="#acc687" d="M14 8h1M13 9h1" />'#13#10'<' +
          'path stroke="#b1cc8b" d="M15 8h1M14 9h1" />'#13#10'<path stroke="#c6c6' +
          'c6" d="M3 9h2M3 10h2M3 11h2M3 12h2M3 13h3M3 14h3M3 15h2" />'#13#10'<pa' +
          'th stroke="#93b06e" d="M7 9h1" />'#13#10'<path stroke="#98b573" d="M8 ' +
          '9h1" />'#13#10'<path stroke="#9bb777" d="M9 9h1" />'#13#10'<path stroke="#a1' +
          'bd7e" d="M11 9h1" />'#13#10'<path stroke="#a7c382" d="M12 9h1" />'#13#10'<pa' +
          'th stroke="#b3ce8d" d="M15 9h1" />'#13#10'<path stroke="#b5ca9f" d="M6' +
          ' 10h1" />'#13#10'<path stroke="#95b270" d="M7 10h1" />'#13#10'<path stroke="' +
          '#99b574" d="M8 10h1" />'#13#10'<path stroke="#a3c07e" d="M10 10h1" />'#13 +
          #10'<path stroke="#a4bf7f" d="M11 10h1" />'#13#10'<path stroke="#abc686" ' +
          'd="M12 10h1" />'#13#10'<path stroke="#aec988" d="M13 10h1" />'#13#10'<path s' +
          'troke="#b2cd8d" d="M14 10h1M13 11h1" />'#13#10'<path stroke="#b4cf8e" ' +
          'd="M15 10h1M14 11h1" />'#13#10'<path stroke="#b9cba0" d="M6 11h1" />'#13#10 +
          '<path stroke="#97b472" d="M7 11h1" />'#13#10'<path stroke="#99b674" d=' +
          '"M8 11h1" />'#13#10'<path stroke="#9fbc7a" d="M9 11h1" />'#13#10'<path strok' +
          'e="#a6c283" d="M11 11h1" />'#13#10'<path stroke="#b6d190" d="M15 11h1"' +
          ' />'#13#10'<path stroke="#c7c7c7" d="M6 13h1M6 14h1M5 15h1" />'#13#10'<path ' +
          'stroke="#c9c9c9" d="M7 13h1" />'#13#10'<path stroke="#cacaca" d="M8 13' +
          'h1M7 14h2M7 15h1" />'#13#10'<path stroke="#cbcbcb" d="M9 13h2M9 14h1M8' +
          ' 15h1" />'#13#10'<path stroke="#cccccc" d="M11 13h1M10 14h1M9 15h1" />' +
          #13#10'<path stroke="#cdcdcd" d="M11 14h1M10 15h1" />'#13#10'<path stroke="' +
          '#c8c8c8" d="M6 15h1" />'#13#10'<path stroke="#cecece" d="M11 15h1" />'#13 +
          #10'</svg>'#13#10
      end
      item
        IconName = 'ToBack'
        SVGText = 
          '<svg viewBox="0 -0.5 18 18">'#13#10'<path stroke="#a8b697" d="M5 1h12M' +
          '5 2h1M16 2h1M5 3h1M16 3h1M5 4h1M16 4h1M5 5h1M16 5h1M5 6h1M16 6h1' +
          'M16 7h1M16 8h1M16 9h1M16 10h1M16 11h1M13 12h4" />'#13#10'<path stroke=' +
          '"#e2e7db" d="M6 2h1" />'#13#10'<path stroke="#d5e0cc" d="M7 2h4M6 3h1M' +
          '6 4h1M6 5h1M6 6h1" />'#13#10'<path stroke="#d9e2cd" d="M11 2h1" />'#13#10'<p' +
          'ath stroke="#d9e2ce" d="M12 2h1" />'#13#10'<path stroke="#dbe4d0" d="M' +
          '13 2h1" />'#13#10'<path stroke="#dce5d0" d="M14 2h2" />'#13#10'<path stroke=' +
          '"#c5d3b5" d="M7 3h3M7 4h2M7 5h2M7 6h2" />'#13#10'<path stroke="#c7d5b7' +
          '" d="M10 3h1" />'#13#10'<path stroke="#c8d5b7" d="M11 3h1M11 4h1" />'#13#10 +
          '<path stroke="#c9d6b9" d="M12 3h1M11 5h1" />'#13#10'<path stroke="#ccd' +
          '8bb" d="M13 3h1" />'#13#10'<path stroke="#cbd8bb" d="M14 3h1M11 6h1" /' +
          '>'#13#10'<path stroke="#cfdcbf" d="M15 3h1M15 4h1M14 5h1M13 6h1" />'#13#10'<' +
          'path stroke="#c6d4b6" d="M9 4h1" />'#13#10'<path stroke="#c8d6b8" d="M' +
          '10 4h1M10 5h1M9 6h1" />'#13#10'<path stroke="#cbd7bb" d="M12 4h1" />'#13#10 +
          '<path stroke="#ccdbbc" d="M13 4h1" />'#13#10'<path stroke="#cfdcbe" d=' +
          '"M14 4h1" />'#13#10'<path stroke="#c7d4b7" d="M9 5h1" />'#13#10'<path stroke' +
          '="#cbd8ba" d="M12 5h1" />'#13#10'<path stroke="#cedbbd" d="M13 5h1" />' +
          #13#10'<path stroke="#d0debf" d="M15 5h1M13 8h1" />'#13#10'<path stroke="#c' +
          'ad6b9" d="M10 6h1" />'#13#10'<path stroke="#cddbbc" d="M12 6h1" />'#13#10'<p' +
          'ath stroke="#cfddbf" d="M14 6h1" />'#13#10'<path stroke="#d1dec1" d="M' +
          '15 6h1" />'#13#10'<path stroke="#4f4f4f" d="M1 7h12M1 8h1M12 8h1M1 9h1' +
          'M12 9h1M1 10h1M12 10h1M1 11h1M12 11h1M1 12h1M12 12h1M1 13h1M12 1' +
          '3h1M1 14h1M12 14h1M1 15h1M12 15h1M1 16h12" />'#13#10'<path stroke="#ce' +
          'dbbe" d="M13 7h1" />'#13#10'<path stroke="#d0dec0" d="M14 7h1" />'#13#10'<pa' +
          'th stroke="#d1dfc1" d="M15 7h1" />'#13#10'<path stroke="#cecece" d="M2' +
          ' 8h1" />'#13#10'<path stroke="#b5b5b5" d="M3 8h6M2 9h1M2 10h1M2 11h1M2' +
          ' 12h1M2 13h1M2 14h1M2 15h1" />'#13#10'<path stroke="#b7b7b7" d="M9 8h1' +
          '" />'#13#10'<path stroke="#b8b8b8" d="M10 8h1" />'#13#10'<path stroke="#b9b9' +
          'b9" d="M11 8h1" />'#13#10'<path stroke="#d2dec1" d="M14 8h1M13 9h1" />' +
          #13#10'<path stroke="#d4e1c3" d="M15 8h1M14 9h1" />'#13#10'<path stroke="#8' +
          'f8f8f" d="M3 9h5M3 10h4M3 11h4M3 12h4M3 13h3M3 14h3M3 15h2" />'#13#10 +
          '<path stroke="#919191" d="M8 9h1M7 10h1M6 14h1M5 15h1" />'#13#10'<path' +
          ' stroke="#939393" d="M9 9h1M8 10h1M6 15h1" />'#13#10'<path stroke="#95' +
          '9595" d="M10 9h1M9 10h1" />'#13#10'<path stroke="#979797" d="M11 9h1M1' +
          '0 10h1M7 14h1" />'#13#10'<path stroke="#d5e2c4" d="M15 9h1M15 10h1M14 ' +
          '11h1" />'#13#10'<path stroke="#999999" d="M11 10h1M8 14h1M7 15h1" />'#13#10 +
          '<path stroke="#d3e0c2" d="M13 10h1" />'#13#10'<path stroke="#d4e2c4" d' +
          '="M14 10h1M13 11h1" />'#13#10'<path stroke="#929292" d="M7 11h1" />'#13#10'<' +
          'path stroke="#949494" d="M8 11h1M7 12h1" />'#13#10'<path stroke="#9696' +
          '96" d="M9 11h1M8 12h1M7 13h1" />'#13#10'<path stroke="#989898" d="M10 ' +
          '11h1M9 12h1M8 13h1" />'#13#10'<path stroke="#9a9a9a" d="M11 11h1M10 12' +
          'h1M9 13h1" />'#13#10'<path stroke="#d6e3c5" d="M15 11h1" />'#13#10'<path str' +
          'oke="#9c9c9c" d="M11 12h1M9 15h1" />'#13#10'<path stroke="#909090" d="' +
          'M6 13h1" />'#13#10'<path stroke="#9b9b9b" d="M10 13h1M9 14h1M8 15h1" /' +
          '>'#13#10'<path stroke="#9d9d9d" d="M11 13h1M10 14h1" />'#13#10'<path stroke=' +
          '"#9f9f9f" d="M11 14h1" />'#13#10'<path stroke="#9e9e9e" d="M10 15h1" /' +
          '>'#13#10'<path stroke="#a0a0a0" d="M11 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Left1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M1 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M2 1h1M1 2h1M1 3h1M1 4h1M1 5h1M1 6' +
          'h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M1 12h1M1 13h1" />'#13#10'<path stro' +
          'ke="#000000" d="M2 2h1M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1' +
          'M2 10h1M2 11h1M2 12h1M2 13h1M1 14h2" />'#13#10'<path stroke="#4f623b" ' +
          'd="M4 2h12M4 3h1M15 3h1M4 4h1M15 4h1M4 5h1M15 5h1M4 6h12" />'#13#10'<p' +
          'ath stroke="#cedbc1" d="M5 3h1" />'#13#10'<path stroke="#b5c7a2" d="M6' +
          ' 3h6M5 4h1M5 5h1" />'#13#10'<path stroke="#b7c9a4" d="M12 3h1" />'#13#10'<pa' +
          'th stroke="#b8caa5" d="M13 3h1" />'#13#10'<path stroke="#b9caa7" d="M1' +
          '4 3h1" />'#13#10'<path stroke="#90ab73" d="M6 4h3M6 5h2" />'#13#10'<path str' +
          'oke="#92ad75" d="M9 4h1M8 5h1" />'#13#10'<path stroke="#97b17d" d="M10' +
          ' 4h1" />'#13#10'<path stroke="#99b37e" d="M11 4h1M10 5h1" />'#13#10'<path st' +
          'roke="#9bb481" d="M12 4h1M11 5h1" />'#13#10'<path stroke="#9db683" d="' +
          'M13 4h1" />'#13#10'<path stroke="#9fb786" d="M14 4h1" />'#13#10'<path stroke' +
          '="#93ae78" d="M9 5h1" />'#13#10'<path stroke="#9cb582" d="M12 5h1" />'#13 +
          #10'<path stroke="#9eb685" d="M13 5h1" />'#13#10'<path stroke="#a0b887" d' +
          '="M14 5h1" />'#13#10'<path stroke="#344f6b" d="M4 8h7M4 9h1M10 9h1M4 1' +
          '0h1M10 10h1M4 11h1M10 11h1M4 12h7" />'#13#10'<path stroke="#c2cddb" d=' +
          '"M5 9h1" />'#13#10'<path stroke="#a3b4c8" d="M6 9h2M5 10h1M5 11h1" />'#13 +
          #10'<path stroke="#a3b5c8" d="M8 9h1" />'#13#10'<path stroke="#a5b6c9" d=' +
          '"M9 9h1" />'#13#10'<path stroke="#7a94b2" d="M6 10h1" />'#13#10'<path stroke' +
          '="#7c96b3" d="M7 10h1M6 11h1" />'#13#10'<path stroke="#7e98b5" d="M8 1' +
          '0h1M7 11h1" />'#13#10'<path stroke="#809ab7" d="M9 10h1M8 11h1" />'#13#10'<p' +
          'ath stroke="#829cb8" d="M9 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Delete1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="M280-1' +
          '20q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-4' +
          '0v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-' +
          '280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/>'#13 +
          #10'</svg>'
      end
      item
        IconName = 'Cut1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#f9f9f9" d="M3 0h1M1' +
          '2 6h1" />'#13#10'<path stroke="#f6f6f6" d="M12 0h1" />'#13#10'<path stroke="' +
          '#a2a2a2" d="M13 0h1M5 4h1" />'#13#10'<path stroke="#929292" d="M2 1h1"' +
          ' />'#13#10'<path stroke="#a6a6a6" d="M3 1h1" />'#13#10'<path stroke="#a4a4a4' +
          '" d="M12 1h1" />'#13#10'<path stroke="#959595" d="M13 1h1" />'#13#10'<path s' +
          'troke="#afafaf" d="M2 2h1" />'#13#10'<path stroke="#777777" d="M3 2h1M' +
          '12 2h1M3 3h1M12 3h1M4 4h1M11 4h1M4 5h2M10 5h2M5 6h1M10 6h1M6 7h1' +
          'M9 7h2M7 8h2" />'#13#10'<path stroke="#cfcfcf" d="M4 2h1M6 5h1" />'#13#10'<p' +
          'ath stroke="#cdcdcd" d="M11 2h1M9 5h1" />'#13#10'<path stroke="#b0b0b0' +
          '" d="M13 2h1" />'#13#10'<path stroke="#dcdcdc" d="M2 3h1" />'#13#10'<path st' +
          'roke="#808080" d="M4 3h1" />'#13#10'<path stroke="#f2f2f2" d="M5 3h1" ' +
          '/>'#13#10'<path stroke="#f1f1f1" d="M10 3h1" />'#13#10'<path stroke="#7f7f7f' +
          '" d="M11 3h1" />'#13#10'<path stroke="#d7d7d7" d="M13 3h1" />'#13#10'<path s' +
          'troke="#888888" d="M3 4h1" />'#13#10'<path stroke="#a0a0a0" d="M10 4h1' +
          '" />'#13#10'<path stroke="#838383" d="M12 4h1" />'#13#10'<path stroke="#fbfb' +
          'fb" d="M13 4h1" />'#13#10'<path stroke="#c8c8c8" d="M3 5h1" />'#13#10'<path ' +
          'stroke="#bebebe" d="M12 5h1" />'#13#10'<path stroke="#909090" d="M4 6h' +
          '1" />'#13#10'<path stroke="#7e7e7e" d="M6 6h1M9 6h1" />'#13#10'<path stroke=' +
          '"#ededed" d="M7 6h1" />'#13#10'<path stroke="#ececec" d="M8 6h1" />'#13#10'<' +
          'path stroke="#868686" d="M11 6h1" />'#13#10'<path stroke="#e7e7e7" d="' +
          'M4 7h1" />'#13#10'<path stroke="#7c7c7c" d="M5 7h1" />'#13#10'<path stroke="' +
          '#919191" d="M7 7h1" />'#13#10'<path stroke="#8f8f8f" d="M8 7h1" />'#13#10'<p' +
          'ath stroke="#d8d8d8" d="M11 7h1" />'#13#10'<path stroke="#d5d5d5" d="M' +
          '5 8h1" />'#13#10'<path stroke="#7a7a7a" d="M6 8h1" />'#13#10'<path stroke="#' +
          '767676" d="M9 8h1" />'#13#10'<path stroke="#c0c0c0" d="M10 8h1" />'#13#10'<p' +
          'ath stroke="#c4d1e0" d="M6 9h1" />'#13#10'<path stroke="#90abc6" d="M7' +
          ' 9h2" />'#13#10'<path stroke="#adc0d4" d="M9 9h1" />'#13#10'<path stroke="#b' +
          'acee3" d="M2 10h1" />'#13#10'<path stroke="#5a89bb" d="M3 10h1" />'#13#10'<p' +
          'ath stroke="#4076b0" d="M4 10h1" />'#13#10'<path stroke="#457bb2" d="M' +
          '5 10h1M10 14h1M13 14h1" />'#13#10'<path stroke="#5384b8" d="M6 10h1M9 ' +
          '10h1" />'#13#10'<path stroke="#3f77b0" d="M7 10h2M6 11h1M9 11h1M13 11h' +
          '1M6 12h1M9 12h1M6 13h1M9 13h1" />'#13#10'<path stroke="#5182b7" d="M10' +
          ' 10h1M12 11h1" />'#13#10'<path stroke="#4278b2" d="M11 10h1" />'#13#10'<path' +
          ' stroke="#5888ba" d="M12 10h1" />'#13#10'<path stroke="#b3c9e1" d="M13' +
          ' 10h1M8 13h1" />'#13#10'<path stroke="#c4d5e7" d="M1 11h1" />'#13#10'<path s' +
          'troke="#4078b1" d="M2 11h1" />'#13#10'<path stroke="#4f81b6" d="M3 11h' +
          '1M3 15h1M11 15h1" />'#13#10'<path stroke="#a1bdda" d="M4 11h1" />'#13#10'<pa' +
          'th stroke="#7ba2c9" d="M5 11h1" />'#13#10'<path stroke="#4077b1" d="M7' +
          ' 11h1M1 13h1M14 13h1" />'#13#10'<path stroke="#497eb4" d="M8 11h1" />'#13 +
          #10'<path stroke="#719ac4" d="M10 11h1" />'#13#10'<path stroke="#a1bcd7" ' +
          'd="M11 11h1" />'#13#10'<path stroke="#c0d1e6" d="M14 11h1" />'#13#10'<path s' +
          'troke="#6692c0" d="M1 12h1" />'#13#10'<path stroke="#4379b1" d="M2 12h' +
          '1M5 14h1" />'#13#10'<path stroke="#dfe8f2" d="M3 12h1" />'#13#10'<path strok' +
          'e="#e1e9f3" d="M5 12h1M6 15h1" />'#13#10'<path stroke="#5b8bbc" d="M7 ' +
          '12h1M9 14h1" />'#13#10'<path stroke="#79a0c8" d="M8 12h1" />'#13#10'<path st' +
          'roke="#d8e3ef" d="M10 12h1" />'#13#10'<path stroke="#dde7f1" d="M12 12' +
          'h1" />'#13#10'<path stroke="#4278b1" d="M13 12h1" />'#13#10'<path stroke="#6' +
          '28fbf" d="M14 12h1M1 14h1" />'#13#10'<path stroke="#6590bf" d="M2 13h1' +
          'M13 13h1" />'#13#10'<path stroke="#a6c0dc" d="M5 13h1" />'#13#10'<path strok' +
          'e="#8dafd1" d="M7 13h1" />'#13#10'<path stroke="#a8c1dc" d="M10 13h1M1' +
          '1 14h1" />'#13#10'<path stroke="#447ab2" d="M2 14h1" />'#13#10'<path stroke=' +
          '"#a9c2dd" d="M3 14h1" />'#13#10'<path stroke="#a0bbd8" d="M4 14h1" />'#13 +
          #10'<path stroke="#4c7eb5" d="M6 14h1" />'#13#10'<path stroke="#e6ecf5" d' +
          '="M7 14h1" />'#13#10'<path stroke="#f9fbfc" d="M8 14h1" />'#13#10'<path stro' +
          'ke="#b2c8e0" d="M12 14h1" />'#13#10'<path stroke="#5f8dbd" d="M14 14h1' +
          '" />'#13#10'<path stroke="#e5edf4" d="M1 15h1" />'#13#10'<path stroke="#7ba1' +
          'c8" d="M2 15h1" />'#13#10'<path stroke="#5283b8" d="M4 15h1" />'#13#10'<path' +
          ' stroke="#80a5cb" d="M5 15h1M10 15h1" />'#13#10'<path stroke="#e9eff5"' +
          ' d="M9 15h1" />'#13#10'<path stroke="#4a7eb5" d="M12 15h1" />'#13#10'<path s' +
          'troke="#759dc7" d="M13 15h1" />'#13#10'<path stroke="#e2eaf3" d="M14 1' +
          '5h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Copy1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a7a7a7" d="M1 0h4M0' +
          ' 1h1M5 1h1M0 2h1M5 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1' +
          'M0 10h1M1 11h4" />'#13#10'<path stroke="#b1b1b1" d="M5 0h1" />'#13#10'<path ' +
          'stroke="#ececec" d="M6 0h1" />'#13#10'<path stroke="#aeaeae" d="M6 1h1' +
          'M7 2h1" />'#13#10'<path stroke="#e9e9e9" d="M7 1h1" />'#13#10'<path stroke="' +
          '#e6e6e6" d="M6 2h1M5 3h1" />'#13#10'<path stroke="#e4e4e4" d="M8 2h1" ' +
          '/>'#13#10'<path stroke="#6ea5d7" d="M2 3h2M2 5h2M2 7h3M2 9h3" />'#13#10'<pat' +
          'h stroke="#909090" d="M6 4h1" />'#13#10'<path stroke="#777777" d="M7 4' +
          'h4M6 5h1M11 5h1M6 6h1M11 6h1M6 7h1M11 7h1M6 8h1M12 8h3M6 9h1M15 ' +
          '9h1M6 10h1M15 10h1M6 11h1M15 11h1M6 12h1M15 12h1M6 13h1M15 13h1M' +
          '6 14h1M15 14h1M7 15h8" />'#13#10'<path stroke="#858585" d="M11 4h1" />' +
          #13#10'<path stroke="#e2e2e2" d="M12 4h1" />'#13#10'<path stroke="#fcfcfc" ' +
          'd="M7 5h4M7 6h4M7 7h1M10 7h1M12 7h1M7 8h4M7 9h1M10 9h5M7 10h8M7 ' +
          '11h1M14 11h1M7 12h8M7 13h1M14 13h1M7 14h8" />'#13#10'<path stroke="#81' +
          '8181" d="M12 5h1M13 6h1" />'#13#10'<path stroke="#dcdcdc" d="M13 5h1" ' +
          '/>'#13#10'<path stroke="#d8d8d8" d="M12 6h1" />'#13#10'<path stroke="#d7d7d7' +
          '" d="M14 6h1" />'#13#10'<path stroke="#3f77b0" d="M8 7h2M8 9h2M8 11h6M' +
          '8 13h6" />'#13#10'<path stroke="#dedede" d="M13 7h1" />'#13#10'<path stroke=' +
          '"#828282" d="M14 7h1" />'#13#10'<path stroke="#d1d1d1" d="M15 7h1" />'#13 +
          #10'<path stroke="#8c8c8c" d="M11 8h1" />'#13#10'<path stroke="#7e7e7e" d' +
          '="M15 8h1" />'#13#10'<path stroke="#8f8f8f" d="M6 15h1M15 15h1" />'#13#10'</' +
          'svg>'#13#10
      end
      item
        IconName = 'Paste1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#898989" d="M4 0h1M7' +
          ' 0h1" />'#13#10'<path stroke="#777777" d="M5 0h2M4 1h4M8 6h3M7 7h1M11 ' +
          '7h1M7 8h1M11 8h1M7 9h1M11 9h1M7 10h1M12 10h3M7 11h1M15 11h1M7 12' +
          'h1M15 12h1M7 13h1M15 13h1M7 14h1M15 14h1M8 15h7" />'#13#10'<path strok' +
          'e="#e8bd78" d="M0 1h1M0 13h1" />'#13#10'<path stroke="#e5b262" d="M1 1' +
          'h1M10 1h1M0 2h2M10 2h2M0 3h12M0 4h12M0 5h6M0 6h6M0 7h6M0 8h6M0 9' +
          'h6M0 10h6M0 11h6M0 12h6M1 13h5" />'#13#10'<path stroke="#7f7f7f" d="M3' +
          ' 1h1" />'#13#10'<path stroke="#838383" d="M8 1h1" />'#13#10'<path stroke="#e' +
          '8be78" d="M11 1h1" />'#13#10'<path stroke="#f8f2e6" d="M2 2h1" />'#13#10'<pa' +
          'th stroke="#ffffff" d="M3 2h6" />'#13#10'<path stroke="#f7f0e7" d="M9 ' +
          '2h1" />'#13#10'<path stroke="#efd5ab" d="M6 5h1" />'#13#10'<path stroke="#fc' +
          'fbf9" d="M7 5h1M6 6h1" />'#13#10'<path stroke="#91908f" d="M7 6h1" />'#13 +
          #10'<path stroke="#858585" d="M11 6h1" />'#13#10'<path stroke="#e2e2e2" d' +
          '="M12 6h1" />'#13#10'<path stroke="#fcfcfc" d="M8 7h3M8 8h3M8 9h3M12 9' +
          'h1M8 10h3M8 11h7M8 12h7M8 13h7M8 14h7" />'#13#10'<path stroke="#818181' +
          '" d="M12 7h1M13 8h1" />'#13#10'<path stroke="#dcdcdc" d="M13 7h1" />'#13#10 +
          '<path stroke="#d8d8d8" d="M12 8h1" />'#13#10'<path stroke="#d7d7d7" d=' +
          '"M14 8h1" />'#13#10'<path stroke="#dedede" d="M13 9h1" />'#13#10'<path strok' +
          'e="#828282" d="M14 9h1" />'#13#10'<path stroke="#d1d1d1" d="M15 9h1" /' +
          '>'#13#10'<path stroke="#8c8c8c" d="M11 10h1" />'#13#10'<path stroke="#7e7e7e' +
          '" d="M15 10h1" />'#13#10'<path stroke="#8f8f8f" d="M7 15h1M15 15h1" />' +
          #13#10'</svg>'
      end
      item
        IconName = 'Left1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M1 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M2 1h1M1 2h1M1 3h1M1 4h1M1 5h1M1 6' +
          'h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M1 12h1M1 13h1" />'#13#10'<path stro' +
          'ke="#000000" d="M2 2h1M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1' +
          'M2 10h1M2 11h1M2 12h1M2 13h1M1 14h2" />'#13#10'<path stroke="#4f623b" ' +
          'd="M4 2h12M4 3h1M15 3h1M4 4h1M15 4h1M4 5h1M15 5h1M4 6h12" />'#13#10'<p' +
          'ath stroke="#cedbc1" d="M5 3h1" />'#13#10'<path stroke="#b5c7a2" d="M6' +
          ' 3h6M5 4h1M5 5h1" />'#13#10'<path stroke="#b7c9a4" d="M12 3h1" />'#13#10'<pa' +
          'th stroke="#b8caa5" d="M13 3h1" />'#13#10'<path stroke="#b9caa7" d="M1' +
          '4 3h1" />'#13#10'<path stroke="#90ab73" d="M6 4h3M6 5h2" />'#13#10'<path str' +
          'oke="#92ad75" d="M9 4h1M8 5h1" />'#13#10'<path stroke="#97b17d" d="M10' +
          ' 4h1" />'#13#10'<path stroke="#99b37e" d="M11 4h1M10 5h1" />'#13#10'<path st' +
          'roke="#9bb481" d="M12 4h1M11 5h1" />'#13#10'<path stroke="#9db683" d="' +
          'M13 4h1" />'#13#10'<path stroke="#9fb786" d="M14 4h1" />'#13#10'<path stroke' +
          '="#93ae78" d="M9 5h1" />'#13#10'<path stroke="#9cb582" d="M12 5h1" />'#13 +
          #10'<path stroke="#9eb685" d="M13 5h1" />'#13#10'<path stroke="#a0b887" d' +
          '="M14 5h1" />'#13#10'<path stroke="#344f6b" d="M4 8h7M4 9h1M10 9h1M4 1' +
          '0h1M10 10h1M4 11h1M10 11h1M4 12h7" />'#13#10'<path stroke="#c2cddb" d=' +
          '"M5 9h1" />'#13#10'<path stroke="#a3b4c8" d="M6 9h2M5 10h1M5 11h1" />'#13 +
          #10'<path stroke="#a3b5c8" d="M8 9h1" />'#13#10'<path stroke="#a5b6c9" d=' +
          '"M9 9h1" />'#13#10'<path stroke="#7a94b2" d="M6 10h1" />'#13#10'<path stroke' +
          '="#7c96b3" d="M7 10h1M6 11h1" />'#13#10'<path stroke="#7e98b5" d="M8 1' +
          '0h1M7 11h1" />'#13#10'<path stroke="#809ab7" d="M9 10h1M8 11h1" />'#13#10'<p' +
          'ath stroke="#829cb8" d="M9 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Centered1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M7 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M8 1h1M7 2h1M7 3h1M7 4h1M7 5h1M7 6' +
          'h1M7 7h1M7 8h1M7 9h1M7 10h1M7 11h1M7 12h1M7 13h1" />'#13#10'<path stro' +
          'ke="#4f623b" d="M2 2h5M9 2h5M2 3h1M13 3h1M2 4h1M13 4h1M2 5h1M13 ' +
          '5h1M2 6h5M9 6h5" />'#13#10'<path stroke="#000000" d="M8 2h1M8 3h1M8 4h' +
          '1M8 5h1M8 6h1M8 7h1M8 8h1M8 9h1M8 10h1M8 11h1M8 12h1M8 13h1M7 14' +
          'h2" />'#13#10'<path stroke="#cedbc1" d="M3 3h1" />'#13#10'<path stroke="#b5c' +
          '7a2" d="M4 3h3M9 3h1M3 4h1M3 5h1" />'#13#10'<path stroke="#b7c9a4" d="' +
          'M10 3h1" />'#13#10'<path stroke="#b8caa5" d="M11 3h1" />'#13#10'<path stroke' +
          '="#b9caa7" d="M12 3h1" />'#13#10'<path stroke="#90ab73" d="M4 4h3M4 5h' +
          '2" />'#13#10'<path stroke="#99b37e" d="M9 4h1" />'#13#10'<path stroke="#9bb4' +
          '81" d="M10 4h1M9 5h1" />'#13#10'<path stroke="#9db683" d="M11 4h1" />'#13 +
          #10'<path stroke="#9fb786" d="M12 4h1" />'#13#10'<path stroke="#92ad75" d' +
          '="M6 5h1" />'#13#10'<path stroke="#9cb582" d="M10 5h1" />'#13#10'<path strok' +
          'e="#9eb685" d="M11 5h1" />'#13#10'<path stroke="#a0b887" d="M12 5h1" /' +
          '>'#13#10'<path stroke="#344f6b" d="M4 8h3M9 8h3M4 9h1M11 9h1M4 10h1M11' +
          ' 10h1M4 11h1M11 11h1M4 12h3M9 12h3" />'#13#10'<path stroke="#c2cddb" d' +
          '="M5 9h1" />'#13#10'<path stroke="#a3b4c8" d="M6 9h1M5 10h1M5 11h1" />' +
          #13#10'<path stroke="#a3b5c8" d="M9 9h1" />'#13#10'<path stroke="#a5b6c9" d' +
          '="M10 9h1" />'#13#10'<path stroke="#7a94b2" d="M6 10h1" />'#13#10'<path stro' +
          'ke="#7e98b5" d="M9 10h1" />'#13#10'<path stroke="#809ab7" d="M10 10h1M' +
          '9 11h1" />'#13#10'<path stroke="#7c96b3" d="M6 11h1" />'#13#10'<path stroke=' +
          '"#829cb8" d="M10 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Right1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M13 1h1"' +
          ' />'#13#10'<path stroke="#565249" d="M14 1h1M13 2h1M13 3h1M13 4h1M13 5' +
          'h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M13 13h1" ' +
          '/>'#13#10'<path stroke="#4f623b" d="M0 2h12M0 3h1M11 3h1M0 4h1M11 4h1M' +
          '0 5h1M11 5h1M0 6h12" />'#13#10'<path stroke="#000000" d="M14 2h1M14 3h' +
          '1M14 4h1M14 5h1M14 6h1M14 7h1M14 8h1M14 9h1M14 10h1M14 11h1M14 1' +
          '2h1M14 13h1M13 14h2" />'#13#10'<path stroke="#cedbc1" d="M1 3h1" />'#13#10'<' +
          'path stroke="#b5c7a2" d="M2 3h6M1 4h1M1 5h1" />'#13#10'<path stroke="#' +
          'b7c9a4" d="M8 3h1" />'#13#10'<path stroke="#b8caa5" d="M9 3h1" />'#13#10'<pa' +
          'th stroke="#b9caa7" d="M10 3h1" />'#13#10'<path stroke="#90ab73" d="M2' +
          ' 4h3M2 5h2" />'#13#10'<path stroke="#92ad75" d="M5 4h1M4 5h1" />'#13#10'<pat' +
          'h stroke="#97b17d" d="M6 4h1" />'#13#10'<path stroke="#99b37e" d="M7 4' +
          'h1M6 5h1" />'#13#10'<path stroke="#9bb481" d="M8 4h1M7 5h1" />'#13#10'<path ' +
          'stroke="#9db683" d="M9 4h1" />'#13#10'<path stroke="#9fb786" d="M10 4h' +
          '1" />'#13#10'<path stroke="#93ae78" d="M5 5h1" />'#13#10'<path stroke="#9cb5' +
          '82" d="M8 5h1" />'#13#10'<path stroke="#9eb685" d="M9 5h1" />'#13#10'<path s' +
          'troke="#a0b887" d="M10 5h1" />'#13#10'<path stroke="#344f6b" d="M5 8h7' +
          'M5 9h1M11 9h1M5 10h1M11 10h1M5 11h1M11 11h1M5 12h7" />'#13#10'<path st' +
          'roke="#c2cddb" d="M6 9h1" />'#13#10'<path stroke="#a3b4c8" d="M7 9h2M6' +
          ' 10h1M6 11h1" />'#13#10'<path stroke="#a3b5c8" d="M9 9h1" />'#13#10'<path st' +
          'roke="#a5b6c9" d="M10 9h1" />'#13#10'<path stroke="#7a94b2" d="M7 10h1' +
          '" />'#13#10'<path stroke="#7c96b3" d="M8 10h1M7 11h1" />'#13#10'<path stroke' +
          '="#7e98b5" d="M9 10h1M8 11h1" />'#13#10'<path stroke="#809ab7" d="M10 ' +
          '10h1M9 11h1" />'#13#10'<path stroke="#829cb8" d="M10 11h1" />'#13#10'</svg>'#13 +
          #10
      end
      item
        IconName = 'CenteredWindows'
        SVGText = 
          '<svg viewBox="0 -0.5 20 20">'#13#10'<path stroke="#7e7e7e" d="M1 1h18M' +
          '1 2h1M18 2h1M1 3h1M18 3h1M1 4h1M18 4h1M1 5h1M18 5h1M1 6h1M18 6h1' +
          'M1 7h1M18 7h1M1 8h1M18 8h1M1 9h1M18 9h1M1 10h1M18 10h1M1 11h1M18' +
          ' 11h1M1 12h1M18 12h1M1 13h1M18 13h1M1 14h1M18 14h1M1 15h1M18 15h' +
          '1M1 16h1M18 16h1M1 17h1M18 17h1M1 18h18" />'#13#10'<path stroke="#7e7c' +
          '73" d="M9 3h1" />'#13#10'<path stroke="#565249" d="M10 3h1M9 4h1M9 5h1' +
          'M9 6h1M9 7h1M9 8h1M9 9h1M9 10h1M9 11h1M9 12h1M9 13h1M9 14h1M9 15' +
          'h1" />'#13#10'<path stroke="#4f623b" d="M4 4h5M11 4h5M4 5h1M15 5h1M4 6' +
          'h1M15 6h1M4 7h1M15 7h1M4 8h5M11 8h5" />'#13#10'<path stroke="#000000" ' +
          'd="M10 4h1M10 5h1M10 6h1M10 7h1M10 8h1M10 9h1M10 10h1M10 11h1M10' +
          ' 12h1M10 13h1M10 14h1M10 15h1M9 16h2" />'#13#10'<path stroke="#cedbc1"' +
          ' d="M5 5h1" />'#13#10'<path stroke="#b5c7a2" d="M6 5h3M11 5h1M5 6h1M5 ' +
          '7h1" />'#13#10'<path stroke="#b7c9a4" d="M12 5h1" />'#13#10'<path stroke="#b' +
          '8caa5" d="M13 5h1" />'#13#10'<path stroke="#b9caa7" d="M14 5h1" />'#13#10'<p' +
          'ath stroke="#90ab73" d="M6 6h3M6 7h2" />'#13#10'<path stroke="#99b37e"' +
          ' d="M11 6h1" />'#13#10'<path stroke="#9bb481" d="M12 6h1M11 7h1" />'#13#10'<' +
          'path stroke="#9db683" d="M13 6h1" />'#13#10'<path stroke="#9fb786" d="' +
          'M14 6h1" />'#13#10'<path stroke="#92ad75" d="M8 7h1" />'#13#10'<path stroke=' +
          '"#9cb582" d="M12 7h1" />'#13#10'<path stroke="#9eb685" d="M13 7h1" />'#13 +
          #10'<path stroke="#a0b887" d="M14 7h1" />'#13#10'<path stroke="#344f6b" d' +
          '="M6 10h3M11 10h3M6 11h1M13 11h1M6 12h1M13 12h1M6 13h1M13 13h1M6' +
          ' 14h3M11 14h3" />'#13#10'<path stroke="#c2cddb" d="M7 11h1" />'#13#10'<path ' +
          'stroke="#a3b4c8" d="M8 11h1M7 12h1M7 13h1" />'#13#10'<path stroke="#a3' +
          'b5c8" d="M11 11h1" />'#13#10'<path stroke="#a5b6c9" d="M12 11h1" />'#13#10'<' +
          'path stroke="#7a94b2" d="M8 12h1" />'#13#10'<path stroke="#7e98b5" d="' +
          'M11 12h1" />'#13#10'<path stroke="#809ab7" d="M12 12h1M11 13h1" />'#13#10'<p' +
          'ath stroke="#7c96b3" d="M8 13h1" />'#13#10'<path stroke="#829cb8" d="M' +
          '12 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'SameDistanceH'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#344f6b" d="M1 5h3M6' +
          ' 5h4M12 5h3M1 6h1M3 6h1M6 6h1M9 6h1M12 6h1M14 6h1M1 7h1M3 7h1M6 ' +
          '7h1M9 7h1M12 7h1M14 7h1M1 8h1M3 8h1M6 8h1M9 8h1M12 8h1M14 8h1M1 ' +
          '9h3M6 9h4M12 9h3" />'#13#10'<path stroke="#c2cddb" d="M2 6h1M7 6h2M13 ' +
          '6h1" />'#13#10'<path stroke="#a3b4c8" d="M2 7h1M7 7h2M13 7h1M2 8h1M7 8' +
          'h2M13 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Top1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M1 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M2 1h12M1 2h1" />'#13#10'<path stroke="#' +
          '000000" d="M14 1h1M2 2h13" />'#13#10'<path stroke="#4f623b" d="M3 4h5M' +
          '3 5h1M7 5h1M3 6h1M7 6h1M3 7h1M7 7h1M3 8h1M7 8h1M3 9h1M7 9h1M3 10' +
          'h1M7 10h1M3 11h1M7 11h1M3 12h1M7 12h1M3 13h1M7 13h1M3 14h5" />'#13#10 +
          '<path stroke="#344f6b" d="M9 4h5M9 5h1M13 5h1M9 6h1M13 6h1M9 7h1' +
          'M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10h1M13 10h1M9 11h5" />'#13#10'<pa' +
          'th stroke="#cedbc1" d="M4 5h1" />'#13#10'<path stroke="#b5c7a2" d="M5 ' +
          '5h2M4 6h1M4 7h1M4 8h1M4 9h1M4 10h1" />'#13#10'<path stroke="#c2cddb" d' +
          '="M10 5h1" />'#13#10'<path stroke="#a3b4c8" d="M11 5h2M10 6h1M10 7h1" ' +
          '/>'#13#10'<path stroke="#90ab73" d="M5 6h2M5 7h2M5 8h1" />'#13#10'<path stro' +
          'ke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<path stroke="#7c96b3" d="M1' +
          '2 6h1M12 7h1" />'#13#10'<path stroke="#92ad75" d="M6 8h1M5 9h1" />'#13#10'<p' +
          'ath stroke="#a3b5c8" d="M10 8h1M10 9h1" />'#13#10'<path stroke="#7e98b' +
          '5" d="M11 8h1M11 9h1" />'#13#10'<path stroke="#809ab7" d="M12 8h1M12 9' +
          'h1M11 10h1" />'#13#10'<path stroke="#93ae78" d="M6 9h1" />'#13#10'<path stro' +
          'ke="#99b37e" d="M5 10h1" />'#13#10'<path stroke="#9bb481" d="M6 10h1M5' +
          ' 11h1" />'#13#10'<path stroke="#a5b6c9" d="M10 10h1" />'#13#10'<path stroke=' +
          '"#829cb8" d="M12 10h1" />'#13#10'<path stroke="#b7c9a4" d="M4 11h1" />' +
          #13#10'<path stroke="#9cb582" d="M6 11h1" />'#13#10'<path stroke="#b8caa5" ' +
          'd="M4 12h1" />'#13#10'<path stroke="#9db683" d="M5 12h1" />'#13#10'<path str' +
          'oke="#9eb685" d="M6 12h1" />'#13#10'<path stroke="#b9caa7" d="M4 13h1"' +
          ' />'#13#10'<path stroke="#9fb786" d="M5 13h1" />'#13#10'<path stroke="#a0b88' +
          '7" d="M6 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Middle1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M2 2h5M2' +
          ' 3h1M6 3h1M2 4h1M6 4h1M2 5h1M6 5h1M2 6h1M6 6h1M2 9h1M6 9h1M2 10h' +
          '1M6 10h1M2 11h1M6 11h1M2 12h1M6 12h1M2 13h5" />'#13#10'<path stroke="#' +
          'cedbc1" d="M3 3h1" />'#13#10'<path stroke="#b5c7a2" d="M4 3h2M3 4h1M3 ' +
          '5h1M3 6h1M3 9h1" />'#13#10'<path stroke="#90ab73" d="M4 4h2M4 5h2M4 6h' +
          '1" />'#13#10'<path stroke="#344f6b" d="M8 4h5M8 5h1M12 5h1M8 6h1M12 6h' +
          '1M8 9h1M12 9h1M8 10h1M12 10h1M8 11h5" />'#13#10'<path stroke="#c2cddb"' +
          ' d="M9 5h1" />'#13#10'<path stroke="#a3b4c8" d="M10 5h2M9 6h1" />'#13#10'<pa' +
          'th stroke="#92ad75" d="M5 6h1" />'#13#10'<path stroke="#7a94b2" d="M10' +
          ' 6h1" />'#13#10'<path stroke="#7c96b3" d="M11 6h1" />'#13#10'<path stroke="#' +
          '7e7c73" d="M1 7h1" />'#13#10'<path stroke="#565249" d="M2 7h12M1 8h1" ' +
          '/>'#13#10'<path stroke="#000000" d="M14 7h1M2 8h13" />'#13#10'<path stroke="' +
          '#99b37e" d="M4 9h1" />'#13#10'<path stroke="#9bb481" d="M5 9h1M4 10h1"' +
          ' />'#13#10'<path stroke="#a3b5c8" d="M9 9h1" />'#13#10'<path stroke="#7e98b5' +
          '" d="M10 9h1" />'#13#10'<path stroke="#809ab7" d="M11 9h1M10 10h1" />'#13 +
          #10'<path stroke="#b7c9a4" d="M3 10h1" />'#13#10'<path stroke="#9cb582" d' +
          '="M5 10h1" />'#13#10'<path stroke="#a5b6c9" d="M9 10h1" />'#13#10'<path stro' +
          'ke="#829cb8" d="M11 10h1" />'#13#10'<path stroke="#b8caa5" d="M3 11h1"' +
          ' />'#13#10'<path stroke="#9db683" d="M4 11h1" />'#13#10'<path stroke="#9eb68' +
          '5" d="M5 11h1" />'#13#10'<path stroke="#b9caa7" d="M3 12h1" />'#13#10'<path ' +
          'stroke="#9fb786" d="M4 12h1" />'#13#10'<path stroke="#a0b887" d="M5 12' +
          'h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Bottom1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M3 1h5M3' +
          ' 2h1M7 2h1M3 3h1M7 3h1M3 4h1M7 4h1M3 5h1M7 5h1M3 6h1M7 6h1M3 7h1' +
          'M7 7h1M3 8h1M7 8h1M3 9h1M7 9h1M3 10h1M7 10h1M3 11h5" />'#13#10'<path s' +
          'troke="#cedbc1" d="M4 2h1" />'#13#10'<path stroke="#b5c7a2" d="M5 2h2M' +
          '4 3h1M4 4h1M4 5h1M4 6h1M4 7h1" />'#13#10'<path stroke="#90ab73" d="M5 ' +
          '3h2M5 4h2M5 5h1" />'#13#10'<path stroke="#344f6b" d="M9 4h5M9 5h1M13 5' +
          'h1M9 6h1M13 6h1M9 7h1M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10h1M13' +
          ' 10h1M9 11h5" />'#13#10'<path stroke="#92ad75" d="M6 5h1M5 6h1" />'#13#10'<p' +
          'ath stroke="#c2cddb" d="M10 5h1" />'#13#10'<path stroke="#a3b4c8" d="M' +
          '11 5h2M10 6h1M10 7h1" />'#13#10'<path stroke="#93ae78" d="M6 6h1" />'#13#10 +
          '<path stroke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<path stroke="#7c9' +
          '6b3" d="M12 6h1M12 7h1" />'#13#10'<path stroke="#99b37e" d="M5 7h1" />' +
          #13#10'<path stroke="#9bb481" d="M6 7h1M5 8h1" />'#13#10'<path stroke="#b7c' +
          '9a4" d="M4 8h1" />'#13#10'<path stroke="#9cb582" d="M6 8h1" />'#13#10'<path ' +
          'stroke="#a3b5c8" d="M10 8h1M10 9h1" />'#13#10'<path stroke="#7e98b5" d' +
          '="M11 8h1M11 9h1" />'#13#10'<path stroke="#809ab7" d="M12 8h1M12 9h1M1' +
          '1 10h1" />'#13#10'<path stroke="#b8caa5" d="M4 9h1" />'#13#10'<path stroke="' +
          '#9db683" d="M5 9h1" />'#13#10'<path stroke="#9eb685" d="M6 9h1" />'#13#10'<p' +
          'ath stroke="#b9caa7" d="M4 10h1" />'#13#10'<path stroke="#9fb786" d="M' +
          '5 10h1" />'#13#10'<path stroke="#a0b887" d="M6 10h1" />'#13#10'<path stroke=' +
          '"#a5b6c9" d="M10 10h1" />'#13#10'<path stroke="#829cb8" d="M12 10h1" /' +
          '>'#13#10'<path stroke="#7e7c73" d="M1 13h1" />'#13#10'<path stroke="#565249"' +
          ' d="M2 13h12M1 14h1" />'#13#10'<path stroke="#000000" d="M14 13h1M2 14' +
          'h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'MiddleWindows'
        SVGText = 
          '<svg viewBox="0 -0.5 20 20">'#13#10'<path stroke="#7e7e7e" d="M1 1h18M' +
          '1 2h1M18 2h1M1 3h1M18 3h1M1 4h1M18 4h1M1 5h1M18 5h1M1 6h1M18 6h1' +
          'M1 7h1M18 7h1M1 8h1M18 8h1M1 9h1M18 9h1M1 10h1M18 10h1M1 11h1M18' +
          ' 11h1M1 12h1M18 12h1M1 13h1M18 13h1M1 14h1M18 14h1M1 15h1M18 15h' +
          '1M1 16h1M18 16h1M1 17h1M18 17h1M1 18h18" />'#13#10'<path stroke="#4f62' +
          '3b" d="M4 4h5M4 5h1M8 5h1M4 6h1M8 6h1M4 7h1M8 7h1M4 8h1M8 8h1M4 ' +
          '11h1M8 11h1M4 12h1M8 12h1M4 13h1M8 13h1M4 14h1M8 14h1M4 15h5" />' +
          #13#10'<path stroke="#cedbc1" d="M5 5h1" />'#13#10'<path stroke="#b5c7a2" d' +
          '="M6 5h2M5 6h1M5 7h1M5 8h1M5 11h1" />'#13#10'<path stroke="#90ab73" d=' +
          '"M6 6h2M6 7h2M6 8h1" />'#13#10'<path stroke="#344f6b" d="M10 6h5M10 7h' +
          '1M14 7h1M10 8h1M14 8h1M10 11h1M14 11h1M10 12h1M14 12h1M10 13h5" ' +
          '/>'#13#10'<path stroke="#c2cddb" d="M11 7h1" />'#13#10'<path stroke="#a3b4c8' +
          '" d="M12 7h2M11 8h1" />'#13#10'<path stroke="#92ad75" d="M7 8h1" />'#13#10'<' +
          'path stroke="#7a94b2" d="M12 8h1" />'#13#10'<path stroke="#7c96b3" d="' +
          'M13 8h1" />'#13#10'<path stroke="#7e7c73" d="M3 9h1" />'#13#10'<path stroke=' +
          '"#565249" d="M4 9h12M3 10h1" />'#13#10'<path stroke="#000000" d="M16 9' +
          'h1M4 10h13" />'#13#10'<path stroke="#99b37e" d="M6 11h1" />'#13#10'<path str' +
          'oke="#9bb481" d="M7 11h1M6 12h1" />'#13#10'<path stroke="#a3b5c8" d="M' +
          '11 11h1" />'#13#10'<path stroke="#7e98b5" d="M12 11h1" />'#13#10'<path strok' +
          'e="#809ab7" d="M13 11h1M12 12h1" />'#13#10'<path stroke="#b7c9a4" d="M' +
          '5 12h1" />'#13#10'<path stroke="#9cb582" d="M7 12h1" />'#13#10'<path stroke=' +
          '"#a5b6c9" d="M11 12h1" />'#13#10'<path stroke="#829cb8" d="M13 12h1" /' +
          '>'#13#10'<path stroke="#b8caa5" d="M5 13h1" />'#13#10'<path stroke="#9db683"' +
          ' d="M6 13h1" />'#13#10'<path stroke="#9eb685" d="M7 13h1" />'#13#10'<path st' +
          'roke="#b9caa7" d="M5 14h1" />'#13#10'<path stroke="#9fb786" d="M6 14h1' +
          '" />'#13#10'<path stroke="#a0b887" d="M7 14h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'SameDistanceV'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#344f6b" d="M6 1h5M6' +
          ' 2h1M10 2h1M6 3h5M6 6h5M6 7h1M10 7h1M6 8h1M10 8h1M6 9h5M6 12h5M6' +
          ' 13h1M10 13h1M6 14h5" />'#13#10'<path stroke="#a3b4c8" d="M7 2h2M7 7h2' +
          'M7 8h2M7 13h2" />'#13#10'<path stroke="#c2cddb" d="M9 2h1M9 7h1M9 8h1M' +
          '9 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ZoomOut'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#191919">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400ZM280-540v' +
          '-80h200v80H280Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'ZoomIn'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#191919">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Zm-40-60v-' +
          '80h-80v-80h80v-80h80v80h80v80h-80v80h-80Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Configuration'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#828282" d="M0 1h15M' +
          '0 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1M0 10h1M0 11h1M0 ' +
          '12h1M0 13h1" />'#13#10'<path stroke="#ffffff" d="M1 2h1M11 2h1M13 2h1M' +
          '2 4h1M4 4h1M6 4h1M8 4h1M10 4h1M12 4h1M1 5h1M3 5h1M5 5h1M9 5h1M11' +
          ' 5h1M13 5h1M2 6h1M4 6h1M8 6h1M10 6h1M12 6h1M1 7h1M7 7h1M9 7h1M11' +
          ' 7h1M13 7h1M2 8h1M6 8h1M8 8h1M10 8h1M12 8h1M1 9h1M3 9h1M5 9h1M9 ' +
          '9h1M11 9h1M13 9h1M2 10h1M4 10h1M8 10h1M10 10h1M12 10h1M1 11h1M7 ' +
          '11h1M9 11h1M11 11h1M13 11h1M2 12h1M6 12h1M8 12h1M10 12h1M12 12h1' +
          'M1 13h1M3 13h1M5 13h1M7 13h1M9 13h1M11 13h1M13 13h1" />'#13#10'<path s' +
          'troke="#0000ff" d="M2 2h9M12 2h1" />'#13#10'<path stroke="#000000" d="' +
          'M14 2h1M1 3h14M14 4h1M6 5h2M14 5h1M3 6h1M5 6h2M14 6h1M3 7h3M14 7' +
          'h1M4 8h1M14 8h1M6 9h2M14 9h1M3 10h1M5 10h2M14 10h1M3 11h3M14 11h' +
          '1M4 12h1M14 12h1M14 13h1M0 14h15" />'#13#10'<path stroke="#c4c4c4" d="' +
          'M1 4h1M3 4h1M5 4h1M7 4h1M9 4h1M11 4h1M13 4h1M2 5h1M4 5h1M8 5h1M1' +
          '0 5h1M12 5h1M1 6h1M7 6h1M9 6h1M11 6h1M13 6h1M2 7h1M6 7h1M8 7h1M1' +
          '0 7h1M12 7h1M1 8h1M3 8h1M5 8h1M7 8h1M9 8h1M11 8h1M13 8h1M2 9h1M4' +
          ' 9h1M8 9h1M10 9h1M12 9h1M1 10h1M7 10h1M9 10h1M11 10h1M13 10h1M2 ' +
          '11h1M6 11h1M8 11h1M10 11h1M12 11h1M1 12h1M3 12h1M5 12h1M7 12h1M9' +
          ' 12h1M11 12h1M13 12h1M2 13h1M4 13h1M6 13h1M8 13h1M10 13h1M12 13h' +
          '1" />'#13#10'</svg>'
      end>
    Left = 144
    Top = 8
  end
  object vilGuiDesignerLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Close1'
        Name = 'Close1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'OpenSource'
        Name = 'OpenSource'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ToFront'
        Name = 'ToFront'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ToBack'
        Name = 'ToBack'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Left1'
        Name = 'Left1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Delete1'
        Name = 'Delete1'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Cut1'
        Name = 'Cut1'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Copy1'
        Name = 'Copy1'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Paste1'
        Name = 'Paste1'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Left1'
        Name = 'Left1'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Centered1'
        Name = 'Centered1'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Right1'
        Name = 'Right1'
      end
      item
        CollectionIndex = 12
        CollectionName = 'CenteredWindows'
        Name = 'CenteredWindows'
      end
      item
        CollectionIndex = 13
        CollectionName = 'SameDistanceH'
        Name = 'SameDistanceH'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Top1'
        Name = 'Top1'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Middle1'
        Name = 'Middle1'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Bottom1'
        Name = 'Bottom1'
      end
      item
        CollectionIndex = 17
        CollectionName = 'MiddleWindows'
        Name = 'MiddleWindows'
      end
      item
        CollectionIndex = 18
        CollectionName = 'SameDistanceV'
        Name = 'SameDistanceV'
      end
      item
        CollectionIndex = 19
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 20
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end>
    ImageCollection = scGuiDesignerLight
    Left = 272
    Top = 8
  end
  object scGUIDesignerDark: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Close1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#ffffff">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'OpenSource'
        SVGText = 
          '<svg viewBox="0 -0.5 14 17">'#13#10'<path stroke="#656565" d="M1 0h9M0' +
          ' 1h1M9 1h2M0 2h1M9 2h1M11 2h1M0 3h1M9 3h1M0 4h1M9 4h3M0 5h1M0 6h' +
          '1M0 7h1M0 8h1M0 9h1M0 10h1M0 11h1M0 12h1M0 13h1M0 14h1" />'#13#10'<pat' +
          'h stroke="#ffffff" d="M1 1h8M1 2h8M1 3h1M8 3h1M1 4h8M1 5h3M8 5h3' +
          'M1 6h11M1 7h3M11 7h1M1 8h11M1 9h1M11 9h1M1 10h11M1 11h3M11 11h1M' +
          '1 12h11M1 13h1M11 13h1" />'#13#10'<path stroke="#ffffe9" d="M10 2h1M10' +
          ' 3h2" />'#13#10'<path stroke="#4b4b4b" d="M2 3h6M4 5h4M4 7h7M2 9h9M4 1' +
          '1h7M2 13h9M1 15h12" />'#13#10'<path stroke="#4e4e4e" d="M12 3h1M12 4h2' +
          'M13 5h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M13 1' +
          '3h1M13 14h1" />'#13#10'<path stroke="#fcfade" d="M11 5h2M12 6h1M12 7h1' +
          'M12 8h1M12 9h1M12 10h1M12 11h1M12 12h1M12 13h1M1 14h12" />'#13#10'<pat' +
          'h stroke="#8f8f8f" d="M0 15h1M13 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ToFront'
        SVGText = 
          '<svg viewBox="0 -0.5 18 18">'#13#10'<path stroke="#526e2e" d="M5 1h12M' +
          '5 2h1M16 2h1M5 3h1M16 3h1M5 4h1M16 4h1M5 5h1M16 5h1M5 6h1M16 6h1' +
          'M5 7h1M16 7h1M5 8h1M16 8h1M5 9h1M16 9h1M5 10h1M16 10h1M5 11h1M16' +
          ' 11h1M5 12h12" />'#13#10'<path stroke="#cedbbf" d="M6 2h1" />'#13#10'<path s' +
          'troke="#b4c99e" d="M7 2h4M6 3h1M6 4h1M6 5h1M6 6h1M6 7h1M6 8h1M6 ' +
          '9h1" />'#13#10'<path stroke="#bacda2" d="M11 2h1" />'#13#10'<path stroke="#b' +
          'bcea3" d="M12 2h1" />'#13#10'<path stroke="#bfd2a7" d="M13 2h1" />'#13#10'<p' +
          'ath stroke="#c1d4a9" d="M14 2h2" />'#13#10'<path stroke="#8faf6d" d="M' +
          '7 3h3M7 4h2M7 5h2M7 6h2M7 7h2" />'#13#10'<path stroke="#93b371" d="M10' +
          ' 3h1" />'#13#10'<path stroke="#95b371" d="M11 3h1" />'#13#10'<path stroke="#' +
          '99b675" d="M12 3h1M11 5h1" />'#13#10'<path stroke="#9ebb7a" d="M13 3h1' +
          'M10 7h1" />'#13#10'<path stroke="#9dbb79" d="M14 3h1" />'#13#10'<path stroke' +
          '="#a6c181" d="M15 3h1" />'#13#10'<path stroke="#91b16f" d="M9 4h1" />'#13 +
          #10'<path stroke="#95b573" d="M10 4h1" />'#13#10'<path stroke="#96b472" d' +
          '="M11 4h1" />'#13#10'<path stroke="#9cb879" d="M12 4h1" />'#13#10'<path stro' +
          'ke="#a0be7c" d="M13 4h1" />'#13#10'<path stroke="#a5c080" d="M14 4h1M1' +
          '0 11h1" />'#13#10'<path stroke="#a6c182" d="M15 4h1M14 5h1" />'#13#10'<path ' +
          'stroke="#93b271" d="M9 5h1" />'#13#10'<path stroke="#96b574" d="M10 5h' +
          '1M9 6h1" />'#13#10'<path stroke="#9cba78" d="M12 5h1" />'#13#10'<path stroke' +
          '="#a3bf7e" d="M13 5h1" />'#13#10'<path stroke="#a8c483" d="M15 5h1" />' +
          #13#10'<path stroke="#9ab676" d="M10 6h1M9 8h1" />'#13#10'<path stroke="#9d' +
          'ba79" d="M11 6h1M10 9h1" />'#13#10'<path stroke="#a2bf7d" d="M12 6h1" ' +
          '/>'#13#10'<path stroke="#a5c081" d="M13 6h1" />'#13#10'<path stroke="#a6c281' +
          '" d="M14 6h1" />'#13#10'<path stroke="#abc586" d="M15 6h1" />'#13#10'<path s' +
          'troke="#a9a9a9" d="M1 7h4M1 8h1M1 9h1M1 10h1M1 11h1M1 12h1M1 13h' +
          '1M12 13h1M1 14h1M12 14h1M1 15h1M12 15h1M1 16h12" />'#13#10'<path strok' +
          'e="#99b676" d="M9 7h1" />'#13#10'<path stroke="#a1bf7e" d="M11 7h1" />' +
          #13#10'<path stroke="#a1bd7c" d="M12 7h1" />'#13#10'<path stroke="#a3be7f" ' +
          'd="M13 7h1" />'#13#10'<path stroke="#a9c485" d="M14 7h1" />'#13#10'<path str' +
          'oke="#abc786" d="M15 7h1M12 11h1" />'#13#10'<path stroke="#e3e3e3" d="' +
          'M2 8h1" />'#13#10'<path stroke="#d7d7d7" d="M3 8h2M2 9h1M2 10h1M2 11h1' +
          'M2 12h1M2 13h1M2 14h1M2 15h1" />'#13#10'<path stroke="#92af6d" d="M7 8' +
          'h1" />'#13#10'<path stroke="#96b272" d="M8 8h1" />'#13#10'<path stroke="#a0b' +
          'd7b" d="M10 8h1" />'#13#10'<path stroke="#9fbc7b" d="M11 8h1M9 10h1" /' +
          '>'#13#10'<path stroke="#a4bf80" d="M12 8h1" />'#13#10'<path stroke="#a9c683"' +
          ' d="M13 8h1" />'#13#10'<path stroke="#acc687" d="M14 8h1M13 9h1" />'#13#10'<' +
          'path stroke="#b1cc8b" d="M15 8h1M14 9h1" />'#13#10'<path stroke="#c6c6' +
          'c6" d="M3 9h2M3 10h2M3 11h2M3 12h2M3 13h3M3 14h3M3 15h2" />'#13#10'<pa' +
          'th stroke="#93b06e" d="M7 9h1" />'#13#10'<path stroke="#98b573" d="M8 ' +
          '9h1" />'#13#10'<path stroke="#9bb777" d="M9 9h1" />'#13#10'<path stroke="#a1' +
          'bd7e" d="M11 9h1" />'#13#10'<path stroke="#a7c382" d="M12 9h1" />'#13#10'<pa' +
          'th stroke="#b3ce8d" d="M15 9h1" />'#13#10'<path stroke="#b5ca9f" d="M6' +
          ' 10h1" />'#13#10'<path stroke="#95b270" d="M7 10h1" />'#13#10'<path stroke="' +
          '#99b574" d="M8 10h1" />'#13#10'<path stroke="#a3c07e" d="M10 10h1" />'#13 +
          #10'<path stroke="#a4bf7f" d="M11 10h1" />'#13#10'<path stroke="#abc686" ' +
          'd="M12 10h1" />'#13#10'<path stroke="#aec988" d="M13 10h1" />'#13#10'<path s' +
          'troke="#b2cd8d" d="M14 10h1M13 11h1" />'#13#10'<path stroke="#b4cf8e" ' +
          'd="M15 10h1M14 11h1" />'#13#10'<path stroke="#b9cba0" d="M6 11h1" />'#13#10 +
          '<path stroke="#97b472" d="M7 11h1" />'#13#10'<path stroke="#99b674" d=' +
          '"M8 11h1" />'#13#10'<path stroke="#9fbc7a" d="M9 11h1" />'#13#10'<path strok' +
          'e="#a6c283" d="M11 11h1" />'#13#10'<path stroke="#b6d190" d="M15 11h1"' +
          ' />'#13#10'<path stroke="#c7c7c7" d="M6 13h1M6 14h1M5 15h1" />'#13#10'<path ' +
          'stroke="#c9c9c9" d="M7 13h1" />'#13#10'<path stroke="#cacaca" d="M8 13' +
          'h1M7 14h2M7 15h1" />'#13#10'<path stroke="#cbcbcb" d="M9 13h2M9 14h1M8' +
          ' 15h1" />'#13#10'<path stroke="#cccccc" d="M11 13h1M10 14h1M9 15h1" />' +
          #13#10'<path stroke="#cdcdcd" d="M11 14h1M10 15h1" />'#13#10'<path stroke="' +
          '#c8c8c8" d="M6 15h1" />'#13#10'<path stroke="#cecece" d="M11 15h1" />'#13 +
          #10'</svg>'#13#10
      end
      item
        IconName = 'ToBack'
        SVGText = 
          '<svg viewBox="0 -0.5 18 18">'#13#10'<path stroke="#a8b697" d="M5 1h12M' +
          '5 2h1M16 2h1M5 3h1M16 3h1M5 4h1M16 4h1M5 5h1M16 5h1M5 6h1M16 6h1' +
          'M16 7h1M16 8h1M16 9h1M16 10h1M16 11h1M13 12h4" />'#13#10'<path stroke=' +
          '"#e2e7db" d="M6 2h1" />'#13#10'<path stroke="#d5e0cc" d="M7 2h4M6 3h1M' +
          '6 4h1M6 5h1M6 6h1" />'#13#10'<path stroke="#d9e2cd" d="M11 2h1" />'#13#10'<p' +
          'ath stroke="#d9e2ce" d="M12 2h1" />'#13#10'<path stroke="#dbe4d0" d="M' +
          '13 2h1" />'#13#10'<path stroke="#dce5d0" d="M14 2h2" />'#13#10'<path stroke=' +
          '"#c5d3b5" d="M7 3h3M7 4h2M7 5h2M7 6h2" />'#13#10'<path stroke="#c7d5b7' +
          '" d="M10 3h1" />'#13#10'<path stroke="#c8d5b7" d="M11 3h1M11 4h1" />'#13#10 +
          '<path stroke="#c9d6b9" d="M12 3h1M11 5h1" />'#13#10'<path stroke="#ccd' +
          '8bb" d="M13 3h1" />'#13#10'<path stroke="#cbd8bb" d="M14 3h1M11 6h1" /' +
          '>'#13#10'<path stroke="#cfdcbf" d="M15 3h1M15 4h1M14 5h1M13 6h1" />'#13#10'<' +
          'path stroke="#c6d4b6" d="M9 4h1" />'#13#10'<path stroke="#c8d6b8" d="M' +
          '10 4h1M10 5h1M9 6h1" />'#13#10'<path stroke="#cbd7bb" d="M12 4h1" />'#13#10 +
          '<path stroke="#ccdbbc" d="M13 4h1" />'#13#10'<path stroke="#cfdcbe" d=' +
          '"M14 4h1" />'#13#10'<path stroke="#c7d4b7" d="M9 5h1" />'#13#10'<path stroke' +
          '="#cbd8ba" d="M12 5h1" />'#13#10'<path stroke="#cedbbd" d="M13 5h1" />' +
          #13#10'<path stroke="#d0debf" d="M15 5h1M13 8h1" />'#13#10'<path stroke="#c' +
          'ad6b9" d="M10 6h1" />'#13#10'<path stroke="#cddbbc" d="M12 6h1" />'#13#10'<p' +
          'ath stroke="#cfddbf" d="M14 6h1" />'#13#10'<path stroke="#d1dec1" d="M' +
          '15 6h1" />'#13#10'<path stroke="#4f4f4f" d="M1 7h12M1 8h1M12 8h1M1 9h1' +
          'M12 9h1M1 10h1M12 10h1M1 11h1M12 11h1M1 12h1M12 12h1M1 13h1M12 1' +
          '3h1M1 14h1M12 14h1M1 15h1M12 15h1M1 16h12" />'#13#10'<path stroke="#ce' +
          'dbbe" d="M13 7h1" />'#13#10'<path stroke="#d0dec0" d="M14 7h1" />'#13#10'<pa' +
          'th stroke="#d1dfc1" d="M15 7h1" />'#13#10'<path stroke="#cecece" d="M2' +
          ' 8h1" />'#13#10'<path stroke="#b5b5b5" d="M3 8h6M2 9h1M2 10h1M2 11h1M2' +
          ' 12h1M2 13h1M2 14h1M2 15h1" />'#13#10'<path stroke="#b7b7b7" d="M9 8h1' +
          '" />'#13#10'<path stroke="#b8b8b8" d="M10 8h1" />'#13#10'<path stroke="#b9b9' +
          'b9" d="M11 8h1" />'#13#10'<path stroke="#d2dec1" d="M14 8h1M13 9h1" />' +
          #13#10'<path stroke="#d4e1c3" d="M15 8h1M14 9h1" />'#13#10'<path stroke="#8' +
          'f8f8f" d="M3 9h5M3 10h4M3 11h4M3 12h4M3 13h3M3 14h3M3 15h2" />'#13#10 +
          '<path stroke="#919191" d="M8 9h1M7 10h1M6 14h1M5 15h1" />'#13#10'<path' +
          ' stroke="#939393" d="M9 9h1M8 10h1M6 15h1" />'#13#10'<path stroke="#95' +
          '9595" d="M10 9h1M9 10h1" />'#13#10'<path stroke="#979797" d="M11 9h1M1' +
          '0 10h1M7 14h1" />'#13#10'<path stroke="#d5e2c4" d="M15 9h1M15 10h1M14 ' +
          '11h1" />'#13#10'<path stroke="#999999" d="M11 10h1M8 14h1M7 15h1" />'#13#10 +
          '<path stroke="#d3e0c2" d="M13 10h1" />'#13#10'<path stroke="#d4e2c4" d' +
          '="M14 10h1M13 11h1" />'#13#10'<path stroke="#929292" d="M7 11h1" />'#13#10'<' +
          'path stroke="#949494" d="M8 11h1M7 12h1" />'#13#10'<path stroke="#9696' +
          '96" d="M9 11h1M8 12h1M7 13h1" />'#13#10'<path stroke="#989898" d="M10 ' +
          '11h1M9 12h1M8 13h1" />'#13#10'<path stroke="#9a9a9a" d="M11 11h1M10 12' +
          'h1M9 13h1" />'#13#10'<path stroke="#d6e3c5" d="M15 11h1" />'#13#10'<path str' +
          'oke="#9c9c9c" d="M11 12h1M9 15h1" />'#13#10'<path stroke="#909090" d="' +
          'M6 13h1" />'#13#10'<path stroke="#9b9b9b" d="M10 13h1M9 14h1M8 15h1" /' +
          '>'#13#10'<path stroke="#9d9d9d" d="M11 13h1M10 14h1" />'#13#10'<path stroke=' +
          '"#9f9f9f" d="M11 14h1" />'#13#10'<path stroke="#9e9e9e" d="M10 15h1" /' +
          '>'#13#10'<path stroke="#a0a0a0" d="M11 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Left1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M1 1h2M1' +
          ' 2h1M1 3h1M1 4h1M1 5h1M1 6h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M1 1' +
          '2h1M1 13h1" />'#13#10'<path stroke="#ffffff" d="M2 2h1M2 3h1M2 4h1M2 5' +
          'h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12h1M2 13h1M1 14h2" /' +
          '>'#13#10'<path stroke="#4f623b" d="M4 2h12M4 3h1M15 3h1M4 4h1M15 4h1M4' +
          ' 5h1M15 5h1M4 6h12" />'#13#10'<path stroke="#cedbc1" d="M5 3h1" />'#13#10'<p' +
          'ath stroke="#b5c7a2" d="M6 3h6M5 4h1M5 5h1" />'#13#10'<path stroke="#b' +
          '7c9a4" d="M12 3h1" />'#13#10'<path stroke="#b8caa5" d="M13 3h1" />'#13#10'<p' +
          'ath stroke="#b9caa7" d="M14 3h1" />'#13#10'<path stroke="#90ab73" d="M' +
          '6 4h3M6 5h2" />'#13#10'<path stroke="#92ad75" d="M9 4h1M8 5h1" />'#13#10'<pa' +
          'th stroke="#97b17d" d="M10 4h1" />'#13#10'<path stroke="#99b37e" d="M1' +
          '1 4h1M10 5h1" />'#13#10'<path stroke="#9bb481" d="M12 4h1M11 5h1" />'#13#10 +
          '<path stroke="#9db683" d="M13 4h1" />'#13#10'<path stroke="#9fb786" d=' +
          '"M14 4h1" />'#13#10'<path stroke="#93ae78" d="M9 5h1" />'#13#10'<path stroke' +
          '="#9cb582" d="M12 5h1" />'#13#10'<path stroke="#9eb685" d="M13 5h1" />' +
          #13#10'<path stroke="#a0b887" d="M14 5h1" />'#13#10'<path stroke="#344f6b" ' +
          'd="M4 8h7M4 9h1M10 9h1M4 10h1M10 10h1M4 11h1M10 11h1M4 12h7" />'#13 +
          #10'<path stroke="#c2cddb" d="M5 9h1" />'#13#10'<path stroke="#a3b4c8" d=' +
          '"M6 9h2M5 10h1M5 11h1" />'#13#10'<path stroke="#a3b5c8" d="M8 9h1" />'#13 +
          #10'<path stroke="#a5b6c9" d="M9 9h1" />'#13#10'<path stroke="#7a94b2" d=' +
          '"M6 10h1" />'#13#10'<path stroke="#7c96b3" d="M7 10h1M6 11h1" />'#13#10'<pat' +
          'h stroke="#7e98b5" d="M8 10h1M7 11h1" />'#13#10'<path stroke="#809ab7"' +
          ' d="M9 10h1M8 11h1" />'#13#10'<path stroke="#829cb8" d="M9 11h1" />'#13#10'<' +
          '/svg>'#13#10
      end
      item
        IconName = 'Delete1'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#e1e1e1">'#13#10'  <path d="M280-1' +
          '20q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-4' +
          '0v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-' +
          '280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/>'#13 +
          #10'</svg>'
      end
      item
        IconName = 'Cut1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#616467" d="M13 0h1M' +
          '10 4h1" />'#13#10'<path stroke="#66696b" d="M2 1h1M13 1h1" />'#13#10'<path s' +
          'troke="#5e6264" d="M3 1h1" />'#13#10'<path stroke="#5f6265" d="M12 1h1' +
          '" />'#13#10'<path stroke="#5a5e62" d="M2 2h1" />'#13#10'<path stroke="#76767' +
          '6" d="M3 2h1M12 2h1M3 3h1M12 3h1M4 4h1M11 4h1M4 5h2M10 5h2M5 6h1' +
          'M10 6h1M6 7h1M9 7h1M7 8h2" />'#13#10'<path stroke="#4b5258" d="M4 2h1M' +
          '6 5h1" />'#13#10'<path stroke="#4c5358" d="M11 2h1M9 5h1" />'#13#10'<path st' +
          'roke="#5a5f62" d="M13 2h1" />'#13#10'<path stroke="#475055" d="M2 3h1"' +
          ' />'#13#10'<path stroke="#6f7071" d="M4 3h1M11 3h1" />'#13#10'<path stroke="' +
          '#3d464e" d="M5 3h1M10 3h1" />'#13#10'<path stroke="#474f55" d="M13 3h1' +
          '" />'#13#10'<path stroke="#6b6d6e" d="M3 4h1" />'#13#10'<path stroke="#60636' +
          '6" d="M5 4h1" />'#13#10'<path stroke="#6d6e6f" d="M12 4h1" />'#13#10'<path s' +
          'troke="#4e545a" d="M3 5h1" />'#13#10'<path stroke="#52585d" d="M12 5h1' +
          '" />'#13#10'<path stroke="#686a6c" d="M4 6h1M8 7h1" />'#13#10'<path stroke="' +
          '#707172" d="M6 6h1" />'#13#10'<path stroke="#3e474f" d="M7 6h2" />'#13#10'<p' +
          'ath stroke="#717272" d="M9 6h1" />'#13#10'<path stroke="#6d6e70" d="M1' +
          '1 6h1" />'#13#10'<path stroke="#424a51" d="M4 7h1" />'#13#10'<path stroke="#' +
          '727273" d="M5 7h1" />'#13#10'<path stroke="#676a6c" d="M7 7h1" />'#13#10'<pa' +
          'th stroke="#747474" d="M10 7h1" />'#13#10'<path stroke="#485055" d="M1' +
          '1 7h1" />'#13#10'<path stroke="#495056" d="M5 8h1" />'#13#10'<path stroke="#' +
          '727373" d="M6 8h1" />'#13#10'<path stroke="#747575" d="M9 8h1" />'#13#10'<pa' +
          'th stroke="#51575c" d="M10 8h1" />'#13#10'<path stroke="#3f5164" d="M6' +
          ' 9h1" />'#13#10'<path stroke="#43607e" d="M7 9h2" />'#13#10'<path stroke="#4' +
          '0576f" d="M9 9h1" />'#13#10'<path stroke="#3a536c" d="M2 10h1" />'#13#10'<pa' +
          'th stroke="#3c6c9f" d="M3 10h1" />'#13#10'<path stroke="#3e75af" d="M4' +
          ' 10h1M7 11h1M14 13h1" />'#13#10'<path stroke="#3d73aa" d="M5 10h1M10 1' +
          '4h1M13 14h1" />'#13#10'<path stroke="#3c6fa3" d="M6 10h1M9 10h1" />'#13#10'<' +
          'path stroke="#3e76af" d="M7 10h2M2 11h1M6 11h1M9 11h1M6 12h1M9 1' +
          '2h1M6 13h1M9 13h1" />'#13#10'<path stroke="#3d6fa4" d="M10 10h1M12 11h' +
          '1" />'#13#10'<path stroke="#3e74ae" d="M11 10h1" />'#13#10'<path stroke="#3d' +
          '6da0" d="M12 10h1" />'#13#10'<path stroke="#39546f" d="M13 10h1M8 13h1' +
          '" />'#13#10'<path stroke="#395067" d="M1 11h1" />'#13#10'<path stroke="#3c6f' +
          'a4" d="M3 11h1" />'#13#10'<path stroke="#3a5a79" d="M4 11h1" />'#13#10'<path' +
          ' stroke="#3b648d" d="M5 11h1" />'#13#10'<path stroke="#3d71a8" d="M8 1' +
          '1h1" />'#13#10'<path stroke="#3c6692" d="M10 11h1" />'#13#10'<path stroke="#' +
          '3b5978" d="M11 11h1" />'#13#10'<path stroke="#3d76af" d="M13 11h1" />'#13 +
          #10'<path stroke="#3a516a" d="M14 11h1" />'#13#10'<path stroke="#3c6998" ' +
          'd="M1 12h1" />'#13#10'<path stroke="#3d74ac" d="M2 12h1" />'#13#10'<path str' +
          'oke="#38495a" d="M3 12h1" />'#13#10'<path stroke="#384959" d="M5 12h1M' +
          '6 15h1" />'#13#10'<path stroke="#3c6d9e" d="M7 12h1M9 14h1" />'#13#10'<path ' +
          'stroke="#3b648e" d="M8 12h1" />'#13#10'<path stroke="#394c5e" d="M10 1' +
          '2h1" />'#13#10'<path stroke="#374a5a" d="M12 12h1" />'#13#10'<path stroke="#' +
          '3d74ad" d="M13 12h1" />'#13#10'<path stroke="#3c6a9b" d="M14 12h1M1 14' +
          'h1" />'#13#10'<path stroke="#3d74ae" d="M1 13h1" />'#13#10'<path stroke="#3d' +
          '6a99" d="M2 13h1M13 13h1" />'#13#10'<path stroke="#395776" d="M5 13h1"' +
          ' />'#13#10'<path stroke="#3a5f83" d="M7 13h1" />'#13#10'<path stroke="#3a577' +
          '5" d="M10 13h1M11 14h1" />'#13#10'<path stroke="#3d73ac" d="M2 14h1" /' +
          '>'#13#10'<path stroke="#395675" d="M3 14h1" />'#13#10'<path stroke="#3b5a7b"' +
          ' d="M4 14h1" />'#13#10'<path stroke="#3d73ab" d="M5 14h1" />'#13#10'<path st' +
          'roke="#3e71a8" d="M6 14h1" />'#13#10'<path stroke="#384757" d="M7 14h1' +
          '" />'#13#10'<path stroke="#395470" d="M12 14h1" />'#13#10'<path stroke="#3c6' +
          'b9c" d="M14 14h1" />'#13#10'<path stroke="#384957" d="M1 15h1" />'#13#10'<pa' +
          'th stroke="#3c638c" d="M2 15h1" />'#13#10'<path stroke="#3d70a5" d="M3' +
          ' 15h1M11 15h1" />'#13#10'<path stroke="#3c6ea3" d="M4 15h1" />'#13#10'<path ' +
          'stroke="#3a628a" d="M5 15h1M10 15h1" />'#13#10'<path stroke="#384754" ' +
          'd="M9 15h1" />'#13#10'<path stroke="#3d72a8" d="M12 15h1" />'#13#10'<path st' +
          'roke="#3b6590" d="M13 15h1" />'#13#10'<path stroke="#384858" d="M14 15' +
          'h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Copy1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a7a7a7" d="M1 0h4M0' +
          ' 1h1M5 1h1M0 2h1M5 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1' +
          'M0 10h1M1 11h4" />'#13#10'<path stroke="#b1b1b1" d="M5 0h1" />'#13#10'<path ' +
          'stroke="#ececec" d="M6 0h1" />'#13#10'<path stroke="#aeaeae" d="M6 1h1' +
          'M7 2h1" />'#13#10'<path stroke="#e9e9e9" d="M7 1h1" />'#13#10'<path stroke="' +
          '#e6e6e6" d="M6 2h1M5 3h1" />'#13#10'<path stroke="#e4e4e4" d="M8 2h1" ' +
          '/>'#13#10'<path stroke="#6ea5d7" d="M2 3h2M2 5h2M2 7h3M2 9h3" />'#13#10'<pat' +
          'h stroke="#909090" d="M6 4h1" />'#13#10'<path stroke="#777777" d="M7 4' +
          'h4M6 5h1M11 5h1M6 6h1M11 6h1M6 7h1M11 7h1M6 8h1M12 8h3M6 9h1M15 ' +
          '9h1M6 10h1M15 10h1M6 11h1M15 11h1M6 12h1M15 12h1M6 13h1M15 13h1M' +
          '6 14h1M15 14h1M7 15h8" />'#13#10'<path stroke="#858585" d="M11 4h1" />' +
          #13#10'<path stroke="#e2e2e2" d="M12 4h1" />'#13#10'<path stroke="#fcfcfc" ' +
          'd="M7 5h4M7 6h4M7 7h1M10 7h1M12 7h1M7 8h4M7 9h1M10 9h5M7 10h8M7 ' +
          '11h1M14 11h1M7 12h8M7 13h1M14 13h1M7 14h8" />'#13#10'<path stroke="#81' +
          '8181" d="M12 5h1M13 6h1" />'#13#10'<path stroke="#dcdcdc" d="M13 5h1" ' +
          '/>'#13#10'<path stroke="#d8d8d8" d="M12 6h1" />'#13#10'<path stroke="#d7d7d7' +
          '" d="M14 6h1" />'#13#10'<path stroke="#3f77b0" d="M8 7h2M8 9h2M8 11h6M' +
          '8 13h6" />'#13#10'<path stroke="#dedede" d="M13 7h1" />'#13#10'<path stroke=' +
          '"#828282" d="M14 7h1" />'#13#10'<path stroke="#d1d1d1" d="M15 7h1" />'#13 +
          #10'<path stroke="#8c8c8c" d="M11 8h1" />'#13#10'<path stroke="#7e7e7e" d' +
          '="M15 8h1" />'#13#10'<path stroke="#8f8f8f" d="M6 15h1M15 15h1" />'#13#10'</' +
          'svg>'#13#10
      end
      item
        IconName = 'Paste1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#898989" d="M4 0h1M7' +
          ' 0h1" />'#13#10'<path stroke="#777777" d="M5 0h2M4 1h4M8 6h3M7 7h1M11 ' +
          '7h1M7 8h1M11 8h1M7 9h1M11 9h1M7 10h1M12 10h3M7 11h1M15 11h1M7 12' +
          'h1M15 12h1M7 13h1M15 13h1M7 14h1M15 14h1M8 15h7" />'#13#10'<path strok' +
          'e="#e8bd78" d="M0 1h1M0 13h1" />'#13#10'<path stroke="#e5b262" d="M1 1' +
          'h1M10 1h1M0 2h2M10 2h2M0 3h12M0 4h12M0 5h6M0 6h6M0 7h6M0 8h6M0 9' +
          'h6M0 10h6M0 11h6M0 12h6M1 13h5" />'#13#10'<path stroke="#7f7f7f" d="M3' +
          ' 1h1" />'#13#10'<path stroke="#838383" d="M8 1h1" />'#13#10'<path stroke="#e' +
          '8be78" d="M11 1h1" />'#13#10'<path stroke="#f8f2e6" d="M2 2h1" />'#13#10'<pa' +
          'th stroke="#ffffff" d="M3 2h6" />'#13#10'<path stroke="#f7f0e7" d="M9 ' +
          '2h1" />'#13#10'<path stroke="#efd5ab" d="M6 5h1" />'#13#10'<path stroke="#fc' +
          'fbf9" d="M7 5h1M6 6h1" />'#13#10'<path stroke="#91908f" d="M7 6h1" />'#13 +
          #10'<path stroke="#858585" d="M11 6h1" />'#13#10'<path stroke="#e2e2e2" d' +
          '="M12 6h1" />'#13#10'<path stroke="#fcfcfc" d="M8 7h3M8 8h3M8 9h3M12 9' +
          'h1M8 10h3M8 11h7M8 12h7M8 13h7M8 14h7" />'#13#10'<path stroke="#818181' +
          '" d="M12 7h1M13 8h1" />'#13#10'<path stroke="#dcdcdc" d="M13 7h1" />'#13#10 +
          '<path stroke="#d8d8d8" d="M12 8h1" />'#13#10'<path stroke="#d7d7d7" d=' +
          '"M14 8h1" />'#13#10'<path stroke="#dedede" d="M13 9h1" />'#13#10'<path strok' +
          'e="#828282" d="M14 9h1" />'#13#10'<path stroke="#d1d1d1" d="M15 9h1" /' +
          '>'#13#10'<path stroke="#8c8c8c" d="M11 10h1" />'#13#10'<path stroke="#7e7e7e' +
          '" d="M15 10h1" />'#13#10'<path stroke="#8f8f8f" d="M7 15h1M15 15h1" />' +
          #13#10'</svg>'
      end
      item
        IconName = 'Left1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M1 1h2M1' +
          ' 2h1M1 3h1M1 4h1M1 5h1M1 6h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M1 1' +
          '2h1M1 13h1" />'#13#10'<path stroke="#ffffff" d="M2 2h1M2 3h1M2 4h1M2 5' +
          'h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12h1M2 13h1M1 14h2" /' +
          '>'#13#10'<path stroke="#4f623b" d="M4 2h12M4 3h1M15 3h1M4 4h1M15 4h1M4' +
          ' 5h1M15 5h1M4 6h12" />'#13#10'<path stroke="#cedbc1" d="M5 3h1" />'#13#10'<p' +
          'ath stroke="#b5c7a2" d="M6 3h6M5 4h1M5 5h1" />'#13#10'<path stroke="#b' +
          '7c9a4" d="M12 3h1" />'#13#10'<path stroke="#b8caa5" d="M13 3h1" />'#13#10'<p' +
          'ath stroke="#b9caa7" d="M14 3h1" />'#13#10'<path stroke="#90ab73" d="M' +
          '6 4h3M6 5h2" />'#13#10'<path stroke="#92ad75" d="M9 4h1M8 5h1" />'#13#10'<pa' +
          'th stroke="#97b17d" d="M10 4h1" />'#13#10'<path stroke="#99b37e" d="M1' +
          '1 4h1M10 5h1" />'#13#10'<path stroke="#9bb481" d="M12 4h1M11 5h1" />'#13#10 +
          '<path stroke="#9db683" d="M13 4h1" />'#13#10'<path stroke="#9fb786" d=' +
          '"M14 4h1" />'#13#10'<path stroke="#93ae78" d="M9 5h1" />'#13#10'<path stroke' +
          '="#9cb582" d="M12 5h1" />'#13#10'<path stroke="#9eb685" d="M13 5h1" />' +
          #13#10'<path stroke="#a0b887" d="M14 5h1" />'#13#10'<path stroke="#344f6b" ' +
          'd="M4 8h7M4 9h1M10 9h1M4 10h1M10 10h1M4 11h1M10 11h1M4 12h7" />'#13 +
          #10'<path stroke="#c2cddb" d="M5 9h1" />'#13#10'<path stroke="#a3b4c8" d=' +
          '"M6 9h2M5 10h1M5 11h1" />'#13#10'<path stroke="#a3b5c8" d="M8 9h1" />'#13 +
          #10'<path stroke="#a5b6c9" d="M9 9h1" />'#13#10'<path stroke="#7a94b2" d=' +
          '"M6 10h1" />'#13#10'<path stroke="#7c96b3" d="M7 10h1M6 11h1" />'#13#10'<pat' +
          'h stroke="#7e98b5" d="M8 10h1M7 11h1" />'#13#10'<path stroke="#809ab7"' +
          ' d="M9 10h1M8 11h1" />'#13#10'<path stroke="#829cb8" d="M9 11h1" />'#13#10'<' +
          '/svg>'#13#10
      end
      item
        IconName = 'Centered1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M7 1h2 M' +
          '7 2h1M7 3h1M7 4h1M7 5h1M7 6h1M7 7h1M7 8h1M7 9h1M7 10h1M7 11h1M7 ' +
          '12h1M7 13h1" />'#13#10'<path stroke="#4f623b" d="M2 2h5M9 2h5M2 3h1M13' +
          ' 3h1M2 4h1M13 4h1M2 5h1M13 5h1M2 6h5M9 6h5" />'#13#10'<path stroke="#f' +
          'fffff" d="M8 2h1M8 3h1M8 4h1M8 5h1M8 6h1M8 7h1M8 8h1M8 9h1M8 10h' +
          '1M8 11h1M8 12h1M8 13h1M7 14h2" />'#13#10'<path stroke="#cedbc1" d="M3 ' +
          '3h1" />'#13#10'<path stroke="#b5c7a2" d="M4 3h3M9 3h1M3 4h1M3 5h1" />'#13 +
          #10'<path stroke="#b7c9a4" d="M10 3h1" />'#13#10'<path stroke="#b8caa5" d' +
          '="M11 3h1" />'#13#10'<path stroke="#b9caa7" d="M12 3h1" />'#13#10'<path stro' +
          'ke="#90ab73" d="M4 4h3M4 5h2" />'#13#10'<path stroke="#99b37e" d="M9 4' +
          'h1" />'#13#10'<path stroke="#9bb481" d="M10 4h1M9 5h1" />'#13#10'<path strok' +
          'e="#9db683" d="M11 4h1" />'#13#10'<path stroke="#9fb786" d="M12 4h1" /' +
          '>'#13#10'<path stroke="#92ad75" d="M6 5h1" />'#13#10'<path stroke="#9cb582" ' +
          'd="M10 5h1" />'#13#10'<path stroke="#9eb685" d="M11 5h1" />'#13#10'<path str' +
          'oke="#a0b887" d="M12 5h1" />'#13#10'<path stroke="#344f6b" d="M4 8h3M9' +
          ' 8h3M4 9h1M11 9h1M4 10h1M11 10h1M4 11h1M11 11h1M4 12h3M9 12h3" /' +
          '>'#13#10'<path stroke="#c2cddb" d="M5 9h1" />'#13#10'<path stroke="#a3b4c8" ' +
          'd="M6 9h1M5 10h1M5 11h1" />'#13#10'<path stroke="#a3b5c8" d="M9 9h1" /' +
          '>'#13#10'<path stroke="#a5b6c9" d="M10 9h1" />'#13#10'<path stroke="#7a94b2"' +
          ' d="M6 10h1" />'#13#10'<path stroke="#7e98b5" d="M9 10h1" />'#13#10'<path st' +
          'roke="#809ab7" d="M10 10h1M9 11h1" />'#13#10'<path stroke="#7c96b3" d=' +
          '"M6 11h1" />'#13#10'<path stroke="#829cb8" d="M10 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Right1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M13 1h2M' +
          '13 2h1M13 3h1M13 4h1M13 5h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M' +
          '13 11h1M13 12h1M13 13h1" />'#13#10'<path stroke="#4f623b" d="M0 2h12M0' +
          ' 3h1M11 3h1M0 4h1M11 4h1M0 5h1M11 5h1M0 6h12" />'#13#10'<path stroke="' +
          '#ffffff" d="M14 2h1M14 3h1M14 4h1M14 5h1M14 6h1M14 7h1M14 8h1M14' +
          ' 9h1M14 10h1M14 11h1M14 12h1M14 13h1M13 14h2" />'#13#10'<path stroke="' +
          '#cedbc1" d="M1 3h1" />'#13#10'<path stroke="#b5c7a2" d="M2 3h6M1 4h1M1' +
          ' 5h1" />'#13#10'<path stroke="#b7c9a4" d="M8 3h1" />'#13#10'<path stroke="#b' +
          '8caa5" d="M9 3h1" />'#13#10'<path stroke="#b9caa7" d="M10 3h1" />'#13#10'<pa' +
          'th stroke="#90ab73" d="M2 4h3M2 5h2" />'#13#10'<path stroke="#92ad75" ' +
          'd="M5 4h1M4 5h1" />'#13#10'<path stroke="#97b17d" d="M6 4h1" />'#13#10'<path' +
          ' stroke="#99b37e" d="M7 4h1M6 5h1" />'#13#10'<path stroke="#9bb481" d=' +
          '"M8 4h1M7 5h1" />'#13#10'<path stroke="#9db683" d="M9 4h1" />'#13#10'<path s' +
          'troke="#9fb786" d="M10 4h1" />'#13#10'<path stroke="#93ae78" d="M5 5h1' +
          '" />'#13#10'<path stroke="#9cb582" d="M8 5h1" />'#13#10'<path stroke="#9eb68' +
          '5" d="M9 5h1" />'#13#10'<path stroke="#a0b887" d="M10 5h1" />'#13#10'<path s' +
          'troke="#344f6b" d="M5 8h7M5 9h1M11 9h1M5 10h1M11 10h1M5 11h1M11 ' +
          '11h1M5 12h7" />'#13#10'<path stroke="#c2cddb" d="M6 9h1" />'#13#10'<path str' +
          'oke="#a3b4c8" d="M7 9h2M6 10h1M6 11h1" />'#13#10'<path stroke="#a3b5c8' +
          '" d="M9 9h1" />'#13#10'<path stroke="#a5b6c9" d="M10 9h1" />'#13#10'<path st' +
          'roke="#7a94b2" d="M7 10h1" />'#13#10'<path stroke="#7c96b3" d="M8 10h1' +
          'M7 11h1" />'#13#10'<path stroke="#7e98b5" d="M9 10h1M8 11h1" />'#13#10'<path' +
          ' stroke="#809ab7" d="M10 10h1M9 11h1" />'#13#10'<path stroke="#829cb8"' +
          ' d="M10 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'CenterdWindows'
        SVGText = 
          '<svg viewBox="0 -0.5 20 20">'#13#10'<path stroke="#7e7e7e" d="M1 1h18M' +
          '1 2h1M18 2h1M1 3h1M18 3h1M1 4h1M18 4h1M1 5h1M18 5h1M1 6h1M18 6h1' +
          'M1 7h1M18 7h1M1 8h1M18 8h1M1 9h1M18 9h1M1 10h1M18 10h1M1 11h1M18' +
          ' 11h1M1 12h1M18 12h1M1 13h1M18 13h1M1 14h1M18 14h1M1 15h1M18 15h' +
          '1M1 16h1M18 16h1M1 17h1M18 17h1M1 18h18" />'#13#10'<path stroke="#eeee' +
          'ee" d="M9 3h2M9 4h1M9 5h1M9 6h1M9 7h1M9 8h1M9 9h1M9 10h1M9 11h1M' +
          '9 12h1M9 13h1M9 14h1M9 15h1" />'#13#10'<path stroke="#4f623b" d="M4 4h' +
          '5M11 4h5M4 5h1M15 5h1M4 6h1M15 6h1M4 7h1M15 7h1M4 8h5M11 8h5" />' +
          #13#10'<path stroke="#ffffff" d="M10 4h1M10 5h1M10 6h1M10 7h1M10 8h1M' +
          '10 9h1M10 10h1M10 11h1M10 12h1M10 13h1M10 14h1M10 15h1M9 16h2" /' +
          '>'#13#10'<path stroke="#cedbc1" d="M5 5h1" />'#13#10'<path stroke="#b5c7a2" ' +
          'd="M6 5h3M11 5h1M5 6h1M5 7h1" />'#13#10'<path stroke="#b7c9a4" d="M12 ' +
          '5h1" />'#13#10'<path stroke="#b8caa5" d="M13 5h1" />'#13#10'<path stroke="#b' +
          '9caa7" d="M14 5h1" />'#13#10'<path stroke="#90ab73" d="M6 6h3M6 7h2" /' +
          '>'#13#10'<path stroke="#99b37e" d="M11 6h1" />'#13#10'<path stroke="#9bb481"' +
          ' d="M12 6h1M11 7h1" />'#13#10'<path stroke="#9db683" d="M13 6h1" />'#13#10'<' +
          'path stroke="#9fb786" d="M14 6h1" />'#13#10'<path stroke="#92ad75" d="' +
          'M8 7h1" />'#13#10'<path stroke="#9cb582" d="M12 7h1" />'#13#10'<path stroke=' +
          '"#9eb685" d="M13 7h1" />'#13#10'<path stroke="#a0b887" d="M14 7h1" />'#13 +
          #10'<path stroke="#344f6b" d="M6 10h3M11 10h3M6 11h1M13 11h1M6 12h1' +
          'M13 12h1M6 13h1M13 13h1M6 14h3M11 14h3" />'#13#10'<path stroke="#c2cdd' +
          'b" d="M7 11h1" />'#13#10'<path stroke="#a3b4c8" d="M8 11h1M7 12h1M7 13' +
          'h1" />'#13#10'<path stroke="#a3b5c8" d="M11 11h1" />'#13#10'<path stroke="#a' +
          '5b6c9" d="M12 11h1" />'#13#10'<path stroke="#7a94b2" d="M8 12h1" />'#13#10'<' +
          'path stroke="#7e98b5" d="M11 12h1" />'#13#10'<path stroke="#809ab7" d=' +
          '"M12 12h1M11 13h1" />'#13#10'<path stroke="#7c96b3" d="M8 13h1" />'#13#10'<p' +
          'ath stroke="#829cb8" d="M12 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'SameDistanceH'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#344f6b" d="M1 5h3M6' +
          ' 5h4M12 5h3M1 6h1M3 6h1M6 6h1M9 6h1M12 6h1M14 6h1M1 7h1M3 7h1M6 ' +
          '7h1M9 7h1M12 7h1M14 7h1M1 8h1M3 8h1M6 8h1M9 8h1M12 8h1M14 8h1M1 ' +
          '9h3M6 9h4M12 9h3" />'#13#10'<path stroke="#c2cddb" d="M2 6h1M7 6h2M13 ' +
          '6h1" />'#13#10'<path stroke="#a3b4c8" d="M2 7h1M7 7h2M13 7h1M2 8h1M7 8' +
          'h2M13 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Top1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M1 1h13M' +
          '1 2h1" />'#13#10'<path stroke="#ffffff" d="M14 1h1M2 2h13" />'#13#10'<path s' +
          'troke="#4f623b" d="M3 4h5M3 5h1M7 5h1M3 6h1M7 6h1M3 7h1M7 7h1M3 ' +
          '8h1M7 8h1M3 9h1M7 9h1M3 10h1M7 10h1M3 11h1M7 11h1M3 12h1M7 12h1M' +
          '3 13h1M7 13h1M3 14h5" />'#13#10'<path stroke="#344f6b" d="M9 4h5M9 5h1' +
          'M13 5h1M9 6h1M13 6h1M9 7h1M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10' +
          'h1M13 10h1M9 11h5" />'#13#10'<path stroke="#cedbc1" d="M4 5h1" />'#13#10'<pa' +
          'th stroke="#b5c7a2" d="M5 5h2M4 6h1M4 7h1M4 8h1M4 9h1M4 10h1" />' +
          #13#10'<path stroke="#c2cddb" d="M10 5h1" />'#13#10'<path stroke="#a3b4c8" ' +
          'd="M11 5h2M10 6h1M10 7h1" />'#13#10'<path stroke="#90ab73" d="M5 6h2M5' +
          ' 7h2M5 8h1" />'#13#10'<path stroke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<p' +
          'ath stroke="#7c96b3" d="M12 6h1M12 7h1" />'#13#10'<path stroke="#92ad7' +
          '5" d="M6 8h1M5 9h1" />'#13#10'<path stroke="#a3b5c8" d="M10 8h1M10 9h1' +
          '" />'#13#10'<path stroke="#7e98b5" d="M11 8h1M11 9h1" />'#13#10'<path stroke' +
          '="#809ab7" d="M12 8h1M12 9h1M11 10h1" />'#13#10'<path stroke="#93ae78"' +
          ' d="M6 9h1" />'#13#10'<path stroke="#99b37e" d="M5 10h1" />'#13#10'<path str' +
          'oke="#9bb481" d="M6 10h1M5 11h1" />'#13#10'<path stroke="#a5b6c9" d="M' +
          '10 10h1" />'#13#10'<path stroke="#829cb8" d="M12 10h1" />'#13#10'<path strok' +
          'e="#b7c9a4" d="M4 11h1" />'#13#10'<path stroke="#9cb582" d="M6 11h1" /' +
          '>'#13#10'<path stroke="#b8caa5" d="M4 12h1" />'#13#10'<path stroke="#9db683"' +
          ' d="M5 12h1" />'#13#10'<path stroke="#9eb685" d="M6 12h1" />'#13#10'<path st' +
          'roke="#b9caa7" d="M4 13h1" />'#13#10'<path stroke="#9fb786" d="M5 13h1' +
          '" />'#13#10'<path stroke="#a0b887" d="M6 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Middle1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M2 2h5M2' +
          ' 3h1M6 3h1M2 4h1M6 4h1M2 5h1M6 5h1M2 6h1M6 6h1M2 9h1M6 9h1M2 10h' +
          '1M6 10h1M2 11h1M6 11h1M2 12h1M6 12h1M2 13h5" />'#13#10'<path stroke="#' +
          'cedbc1" d="M3 3h1" />'#13#10'<path stroke="#b5c7a2" d="M4 3h2M3 4h1M3 ' +
          '5h1M3 6h1M3 9h1" />'#13#10'<path stroke="#90ab73" d="M4 4h2M4 5h2M4 6h' +
          '1" />'#13#10'<path stroke="#344f6b" d="M8 4h5M8 5h1M12 5h1M8 6h1M12 6h' +
          '1M8 9h1M12 9h1M8 10h1M12 10h1M8 11h5" />'#13#10'<path stroke="#c2cddb"' +
          ' d="M9 5h1" />'#13#10'<path stroke="#a3b4c8" d="M10 5h2M9 6h1" />'#13#10'<pa' +
          'th stroke="#92ad75" d="M5 6h1" />'#13#10'<path stroke="#7a94b2" d="M10' +
          ' 6h1" />'#13#10'<path stroke="#7c96b3" d="M11 6h1" />'#13#10'<path stroke="#' +
          'eeeeee" d="M1 7h13M1 8h1" />'#13#10'<path stroke="#ffffff" d="M14 7h1M' +
          '2 8h13" />'#13#10'<path stroke="#99b37e" d="M4 9h1" />'#13#10'<path stroke="' +
          '#9bb481" d="M5 9h1M4 10h1" />'#13#10'<path stroke="#a3b5c8" d="M9 9h1"' +
          ' />'#13#10'<path stroke="#7e98b5" d="M10 9h1" />'#13#10'<path stroke="#809ab' +
          '7" d="M11 9h1M10 10h1" />'#13#10'<path stroke="#b7c9a4" d="M3 10h1" />' +
          #13#10'<path stroke="#9cb582" d="M5 10h1" />'#13#10'<path stroke="#a5b6c9" ' +
          'd="M9 10h1" />'#13#10'<path stroke="#829cb8" d="M11 10h1" />'#13#10'<path st' +
          'roke="#b8caa5" d="M3 11h1" />'#13#10'<path stroke="#9db683" d="M4 11h1' +
          '" />'#13#10'<path stroke="#9eb685" d="M5 11h1" />'#13#10'<path stroke="#b9ca' +
          'a7" d="M3 12h1" />'#13#10'<path stroke="#9fb786" d="M4 12h1" />'#13#10'<path' +
          ' stroke="#a0b887" d="M5 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Bottom1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M3 1h5M3' +
          ' 2h1M7 2h1M3 3h1M7 3h1M3 4h1M7 4h1M3 5h1M7 5h1M3 6h1M7 6h1M3 7h1' +
          'M7 7h1M3 8h1M7 8h1M3 9h1M7 9h1M3 10h1M7 10h1M3 11h5" />'#13#10'<path s' +
          'troke="#cedbc1" d="M4 2h1" />'#13#10'<path stroke="#b5c7a2" d="M5 2h2M' +
          '4 3h1M4 4h1M4 5h1M4 6h1M4 7h1" />'#13#10'<path stroke="#90ab73" d="M5 ' +
          '3h2M5 4h2M5 5h1" />'#13#10'<path stroke="#344f6b" d="M9 4h5M9 5h1M13 5' +
          'h1M9 6h1M13 6h1M9 7h1M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10h1M13' +
          ' 10h1M9 11h5" />'#13#10'<path stroke="#92ad75" d="M6 5h1M5 6h1" />'#13#10'<p' +
          'ath stroke="#c2cddb" d="M10 5h1" />'#13#10'<path stroke="#a3b4c8" d="M' +
          '11 5h2M10 6h1M10 7h1" />'#13#10'<path stroke="#93ae78" d="M6 6h1" />'#13#10 +
          '<path stroke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<path stroke="#7c9' +
          '6b3" d="M12 6h1M12 7h1" />'#13#10'<path stroke="#99b37e" d="M5 7h1" />' +
          #13#10'<path stroke="#9bb481" d="M6 7h1M5 8h1" />'#13#10'<path stroke="#b7c' +
          '9a4" d="M4 8h1" />'#13#10'<path stroke="#9cb582" d="M6 8h1" />'#13#10'<path ' +
          'stroke="#a3b5c8" d="M10 8h1M10 9h1" />'#13#10'<path stroke="#7e98b5" d' +
          '="M11 8h1M11 9h1" />'#13#10'<path stroke="#809ab7" d="M12 8h1M12 9h1M1' +
          '1 10h1" />'#13#10'<path stroke="#b8caa5" d="M4 9h1" />'#13#10'<path stroke="' +
          '#9db683" d="M5 9h1" />'#13#10'<path stroke="#9eb685" d="M6 9h1" />'#13#10'<p' +
          'ath stroke="#b9caa7" d="M4 10h1" />'#13#10'<path stroke="#9fb786" d="M' +
          '5 10h1" />'#13#10'<path stroke="#a0b887" d="M6 10h1" />'#13#10'<path stroke=' +
          '"#a5b6c9" d="M10 10h1" />'#13#10'<path stroke="#829cb8" d="M12 10h1" /' +
          '>'#13#10'<path stroke="#eeeeee" d="M1 13h12M1 14h1" />'#13#10'<path stroke="' +
          '#ffffff" d="M14 13h1M2 14h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'MiddleWindows'
        SVGText = 
          '<svg viewBox="0 -0.5 20 20">'#13#10'<path stroke="#7e7e7e" d="M1 1h18M' +
          '1 2h1M18 2h1M1 3h1M18 3h1M1 4h1M18 4h1M1 5h1M18 5h1M1 6h1M18 6h1' +
          'M1 7h1M18 7h1M1 8h1M18 8h1M1 9h1M18 9h1M1 10h1M18 10h1M1 11h1M18' +
          ' 11h1M1 12h1M18 12h1M1 13h1M18 13h1M1 14h1M18 14h1M1 15h1M18 15h' +
          '1M1 16h1M18 16h1M1 17h1M18 17h1M1 18h18" />'#13#10'<path stroke="#4f62' +
          '3b" d="M4 4h5M4 5h1M8 5h1M4 6h1M8 6h1M4 7h1M8 7h1M4 8h1M8 8h1M4 ' +
          '11h1M8 11h1M4 12h1M8 12h1M4 13h1M8 13h1M4 14h1M8 14h1M4 15h5" />' +
          #13#10'<path stroke="#cedbc1" d="M5 5h1" />'#13#10'<path stroke="#b5c7a2" d' +
          '="M6 5h2M5 6h1M5 7h1M5 8h1M5 11h1" />'#13#10'<path stroke="#90ab73" d=' +
          '"M6 6h2M6 7h2M6 8h1" />'#13#10'<path stroke="#344f6b" d="M10 6h5M10 7h' +
          '1M14 7h1M10 8h1M14 8h1M10 11h1M14 11h1M10 12h1M14 12h1M10 13h5" ' +
          '/>'#13#10'<path stroke="#c2cddb" d="M11 7h1" />'#13#10'<path stroke="#a3b4c8' +
          '" d="M12 7h2M11 8h1" />'#13#10'<path stroke="#92ad75" d="M7 8h1" />'#13#10'<' +
          'path stroke="#7a94b2" d="M12 8h1" />'#13#10'<path stroke="#7c96b3" d="' +
          'M13 8h1" />'#13#10'<path stroke="#eeeeee" d="M3 9h13M3 10h1" />'#13#10'<path' +
          ' stroke="#ffffff" d="M16 9h1M4 10h13" />'#13#10'<path stroke="#99b37e"' +
          ' d="M6 11h1" />'#13#10'<path stroke="#9bb481" d="M7 11h1M6 12h1" />'#13#10'<' +
          'path stroke="#a3b5c8" d="M11 11h1" />'#13#10'<path stroke="#7e98b5" d=' +
          '"M12 11h1" />'#13#10'<path stroke="#809ab7" d="M13 11h1M12 12h1" />'#13#10'<' +
          'path stroke="#b7c9a4" d="M5 12h1" />'#13#10'<path stroke="#9cb582" d="' +
          'M7 12h1" />'#13#10'<path stroke="#a5b6c9" d="M11 12h1" />'#13#10'<path strok' +
          'e="#829cb8" d="M13 12h1" />'#13#10'<path stroke="#b8caa5" d="M5 13h1" ' +
          '/>'#13#10'<path stroke="#9db683" d="M6 13h1" />'#13#10'<path stroke="#9eb685' +
          '" d="M7 13h1" />'#13#10'<path stroke="#b9caa7" d="M5 14h1" />'#13#10'<path s' +
          'troke="#9fb786" d="M6 14h1" />'#13#10'<path stroke="#a0b887" d="M7 14h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'SameDistanceV'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#344f6b" d="M6 1h5M6' +
          ' 2h1M10 2h1M6 3h5M6 6h5M6 7h1M10 7h1M6 8h1M10 8h1M6 9h5M6 12h5M6' +
          ' 13h1M10 13h1M6 14h5" />'#13#10'<path stroke="#a3b4c8" d="M7 2h2M7 7h2' +
          'M7 8h2M7 13h2" />'#13#10'<path stroke="#c2cddb" d="M9 2h1M9 7h1M9 8h1M' +
          '9 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ZoomOut'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#e6e6e6">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400ZM280-540v' +
          '-80h200v80H280Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'ZoomIn'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#e6e6e6">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Zm-40-60v-' +
          '80h-80v-80h80v-80h80v80h80v80h-80v80h-80Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Configuration\'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#828282" d="M0 1h15M' +
          '0 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1M0 10h1M0 11h1M0 ' +
          '12h1M0 13h1" />'#13#10'<path stroke="#ffffff" d="M1 2h1M11 2h1M13 2h1M' +
          '2 4h1M4 4h1M6 4h1M8 4h1M10 4h1M12 4h1M1 5h1M3 5h1M5 5h1M9 5h1M11' +
          ' 5h1M13 5h1M2 6h1M4 6h1M8 6h1M10 6h1M12 6h1M1 7h1M7 7h1M9 7h1M11' +
          ' 7h1M13 7h1M2 8h1M6 8h1M8 8h1M10 8h1M12 8h1M1 9h1M3 9h1M5 9h1M9 ' +
          '9h1M11 9h1M13 9h1M2 10h1M4 10h1M8 10h1M10 10h1M12 10h1M1 11h1M7 ' +
          '11h1M9 11h1M11 11h1M13 11h1M2 12h1M6 12h1M8 12h1M10 12h1M12 12h1' +
          'M1 13h1M3 13h1M5 13h1M7 13h1M9 13h1M11 13h1M13 13h1" />'#13#10'<path s' +
          'troke="#0000ff" d="M2 2h9M12 2h1" />'#13#10'<path stroke="#000000" d="' +
          'M14 2h1M1 3h14M14 4h1M6 5h2M14 5h1M3 6h1M5 6h2M14 6h1M3 7h3M14 7' +
          'h1M4 8h1M14 8h1M6 9h2M14 9h1M3 10h1M5 10h2M14 10h1M3 11h3M14 11h' +
          '1M4 12h1M14 12h1M14 13h1M0 14h15" />'#13#10'<path stroke="#c4c4c4" d="' +
          'M1 4h1M3 4h1M5 4h1M7 4h1M9 4h1M11 4h1M13 4h1M2 5h1M4 5h1M8 5h1M1' +
          '0 5h1M12 5h1M1 6h1M7 6h1M9 6h1M11 6h1M13 6h1M2 7h1M6 7h1M8 7h1M1' +
          '0 7h1M12 7h1M1 8h1M3 8h1M5 8h1M7 8h1M9 8h1M11 8h1M13 8h1M2 9h1M4' +
          ' 9h1M8 9h1M10 9h1M12 9h1M1 10h1M7 10h1M9 10h1M11 10h1M13 10h1M2 ' +
          '11h1M6 11h1M8 11h1M10 11h1M12 11h1M1 12h1M3 12h1M5 12h1M7 12h1M9' +
          ' 12h1M11 12h1M13 12h1M2 13h1M4 13h1M6 13h1M8 13h1M10 13h1M12 13h' +
          '1" />'#13#10'</svg>'
      end>
    Left = 144
    Top = 88
  end
  object vilGUIDesignerDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Close1'
        Name = 'Close1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'OpenSource'
        Name = 'OpenSource'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ToFront'
        Name = 'ToFront'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ToBack'
        Name = 'ToBack'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Left1'
        Name = 'Left1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Delete1'
        Name = 'Delete1'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Cut1'
        Name = 'Cut1'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Copy1'
        Name = 'Copy1'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Paste1'
        Name = 'Paste1'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Left1'
        Name = 'Left1'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Centered1'
        Name = 'Centered1'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Right1'
        Name = 'Right1'
      end
      item
        CollectionIndex = 12
        CollectionName = 'CenterdWindows'
        Name = 'CenterdWindows'
      end
      item
        CollectionIndex = 13
        CollectionName = 'SameDistanceH'
        Name = 'SameDistanceH'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Top1'
        Name = 'Top1'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Middle1'
        Name = 'Middle1'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Bottom1'
        Name = 'Bottom1'
      end
      item
        CollectionIndex = 17
        CollectionName = 'MiddleWindows'
        Name = 'MiddleWindows'
      end
      item
        CollectionIndex = 18
        CollectionName = 'SameDistanceV'
        Name = 'SameDistanceV'
      end
      item
        CollectionIndex = 19
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 20
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Configuration\'
        Name = 'Configuration\'
      end>
    ImageCollection = scGUIDesignerDark
    Left = 272
    Top = 88
  end
  object icPythonControls: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = '00'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e8e8e8" d="M4 0h1M1' +
          '1 0h1M0 4h1M15 4h1M1 6h2M13 6h2" />'#13#10'<path stroke="#cecece" d="M' +
          '5 0h1M10 0h1M3 1h1M12 1h1M1 3h1M14 3h1M0 5h1M15 5h1" />'#13#10'<path s' +
          'troke="#bebebe" d="M6 0h1M9 0h1M0 6h1M15 6h1" />'#13#10'<path stroke="' +
          '#b3b3b3" d="M7 0h2M0 7h1M15 7h1M0 8h1M15 8h1M7 15h2" />'#13#10'<path s' +
          'troke="#f0f0f0" d="M2 1h1M13 1h1M1 2h1M6 2h1M9 2h1M14 2h1" />'#13#10'<' +
          'path stroke="#b9b9b9" d="M4 1h1M11 1h1M1 4h1M14 4h1" />'#13#10'<path s' +
          'troke="#dad9da" d="M5 1h1M10 1h1M6 14h1M9 14h1" />'#13#10'<path stroke' +
          '="#efefef" d="M6 1h1M9 1h1M4 3h1M11 3h1M2 5h1M13 5h1M1 7h1M14 7h' +
          '1" />'#13#10'<path stroke="#fafafa" d="M7 1h2" />'#13#10'<path stroke="#c2c2' +
          'c2" d="M2 2h1M13 2h1" />'#13#10'<path stroke="#cccccc" d="M3 2h1M12 2h' +
          '1M5 14h1M10 14h1" />'#13#10'<path stroke="#f7f7f7" d="M4 2h1M11 2h1M3 ' +
          '15h1M12 15h1" />'#13#10'<path stroke="#f5f5f5" d="M5 2h1M10 2h1M2 14h1' +
          'M13 14h1" />'#13#10'<path stroke="#ededed" d="M7 2h2M5 3h6M4 15h1M11 1' +
          '5h1" />'#13#10'<path stroke="#cbcbcb" d="M2 3h1M13 3h1" />'#13#10'<path stro' +
          'ke="#f8f8f8" d="M3 3h1M12 3h1" />'#13#10'<path stroke="#f3f3f3" d="M2 ' +
          '4h1M13 4h1" />'#13#10'<path stroke="#ececec" d="M3 4h1M12 4h1M1 8h1M14' +
          ' 8h1" />'#13#10'<path stroke="#ebebeb" d="M4 4h8" />'#13#10'<path stroke="#d' +
          '5d5d5" d="M1 5h1M14 5h1" />'#13#10'<path stroke="#e9e9e9" d="M3 5h10" ' +
          '/>'#13#10'<path stroke="#e7e7e7" d="M3 6h10" />'#13#10'<path stroke="#e4e4e4' +
          '" d="M2 7h1M13 7h1" />'#13#10'<path stroke="#e5e5e5" d="M3 7h10M2 11h1' +
          'M13 11h1" />'#13#10'<path stroke="#e2e2e2" d="M2 8h1M13 8h1M3 9h10" />' +
          #13#10'<path stroke="#e3e3e3" d="M3 8h10M1 9h2M13 9h2" />'#13#10'<path stro' +
          'ke="#bdbdbd" d="M0 9h1M15 9h1M6 15h1M9 15h1" />'#13#10'<path stroke="#' +
          'cfcfcf" d="M0 10h1M15 10h1M1 12h1M14 12h1M3 14h1M12 14h1M5 15h1M' +
          '10 15h1" />'#13#10'<path stroke="#d0d0d0" d="M1 10h1M14 10h1" />'#13#10'<pat' +
          'h stroke="#e6e6e6" d="M2 10h1M13 10h1M3 12h1M12 12h1" />'#13#10'<path ' +
          'stroke="#e0e0e0" d="M3 10h10" />'#13#10'<path stroke="#eaeaea" d="M0 1' +
          '1h1M15 11h1" />'#13#10'<path stroke="#b7b7b7" d="M1 11h1M14 11h1M4 14h' +
          '1M11 14h1" />'#13#10'<path stroke="#dfdfdf" d="M3 11h1M12 11h1M5 13h1M' +
          '10 13h1" />'#13#10'<path stroke="#dedede" d="M4 11h8M4 12h1M11 12h1" /' +
          '>'#13#10'<path stroke="#f4f4f4" d="M0 12h1M15 12h1M1 13h1M14 13h1" />'#13 +
          #10'<path stroke="#c5c5c5" d="M2 12h1M13 12h1" />'#13#10'<path stroke="#d' +
          'cdcdc" d="M5 12h6" />'#13#10'<path stroke="#c3c3c3" d="M2 13h1M13 13h1' +
          '" />'#13#10'<path stroke="#c4c4c4" d="M3 13h1M12 13h1" />'#13#10'<path strok' +
          'e="#e1e1e1" d="M4 13h1M11 13h1M7 14h2" />'#13#10'<path stroke="#dbdbdb' +
          '" d="M6 13h1M9 13h1" />'#13#10'<path stroke="#d8d8d8" d="M7 13h2" />'#13#10 +
          '</svg>'#13#10
      end
      item
        IconName = '01'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e8e8e8" d="M4 0h1M1' +
          '1 0h1M0 4h1M15 4h1M1 6h2M13 6h2" />'#13#10'<path stroke="#cecece" d="M' +
          '5 0h1M10 0h1M3 1h1M12 1h1M1 3h1M14 3h1M0 5h1M15 5h1" />'#13#10'<path s' +
          'troke="#bebebe" d="M6 0h1M9 0h1M0 6h1M15 6h1" />'#13#10'<path stroke="' +
          '#b3b3b3" d="M7 0h2M0 7h1M15 7h1M0 8h1M15 8h1M7 15h2" />'#13#10'<path s' +
          'troke="#f0f0f0" d="M2 1h1M13 1h1M1 2h1M6 2h1M9 2h1M14 2h1" />'#13#10'<' +
          'path stroke="#b9b9b9" d="M4 1h1M11 1h1M1 4h1M14 4h1" />'#13#10'<path s' +
          'troke="#dad9da" d="M5 1h1M10 1h1M6 14h1M9 14h1" />'#13#10'<path stroke' +
          '="#efefef" d="M6 1h1M9 1h1M4 3h1M11 3h1M2 5h1M13 5h1M1 7h1M14 7h' +
          '1" />'#13#10'<path stroke="#fafafa" d="M7 1h2" />'#13#10'<path stroke="#c2c2' +
          'c2" d="M2 2h1M13 2h1" />'#13#10'<path stroke="#cccccc" d="M3 2h1M12 2h' +
          '1M5 14h1M10 14h1" />'#13#10'<path stroke="#f7f7f7" d="M4 2h1M11 2h1M3 ' +
          '15h1M12 15h1" />'#13#10'<path stroke="#f5f5f5" d="M5 2h1M10 2h1M2 14h1' +
          'M13 14h1" />'#13#10'<path stroke="#ededed" d="M7 2h2M5 3h6M4 15h1M11 1' +
          '5h1" />'#13#10'<path stroke="#cbcbcb" d="M2 3h1M13 3h1" />'#13#10'<path stro' +
          'ke="#f8f8f8" d="M3 3h1M12 3h1" />'#13#10'<path stroke="#f3f3f3" d="M2 ' +
          '4h1M13 4h1M6 12h1M9 12h1" />'#13#10'<path stroke="#ececec" d="M3 4h1M1' +
          '2 4h1M1 8h1M14 8h1" />'#13#10'<path stroke="#ebebeb" d="M4 4h1M11 4h1"' +
          ' />'#13#10'<path stroke="#d1d1d1" d="M5 4h1M10 4h1" />'#13#10'<path stroke="' +
          '#818181" d="M6 4h1M9 4h1M4 6h1M11 6h1" />'#13#10'<path stroke="#5d5d5d' +
          '" d="M7 4h2" />'#13#10'<path stroke="#d5d5d5" d="M1 5h1M14 5h1" />'#13#10'<p' +
          'ath stroke="#e9e9e9" d="M3 5h1M12 5h1" />'#13#10'<path stroke="#d0d0d0' +
          '" d="M4 5h1M11 5h1M1 10h1M14 10h1" />'#13#10'<path stroke="#5e5e5e" d=' +
          '"M5 5h1M10 5h1M4 7h1M11 7h1M4 8h1M11 8h1M5 10h1M10 10h1M7 11h2" ' +
          '/>'#13#10'<path stroke="#575757" d="M6 5h4M5 6h6M5 7h6M5 8h6M5 9h6M6 1' +
          '0h4" />'#13#10'<path stroke="#e7e7e7" d="M3 6h1M12 6h1" />'#13#10'<path stro' +
          'ke="#e4e4e4" d="M2 7h1M13 7h1" />'#13#10'<path stroke="#e5e5e5" d="M3 ' +
          '7h1M12 7h1M2 11h1M13 11h1" />'#13#10'<path stroke="#e2e2e2" d="M2 8h1M' +
          '13 8h1M3 9h1M12 9h1M5 11h1M10 11h1" />'#13#10'<path stroke="#e3e3e3" d' +
          '="M3 8h1M12 8h1M1 9h2M13 9h2M4 11h1M11 11h1" />'#13#10'<path stroke="#' +
          'bdbdbd" d="M0 9h1M15 9h1M6 15h1M9 15h1" />'#13#10'<path stroke="#86868' +
          '6" d="M4 9h1M11 9h1" />'#13#10'<path stroke="#cfcfcf" d="M0 10h1M15 10' +
          'h1M1 12h1M14 12h1M3 14h1M12 14h1M5 15h1M10 15h1" />'#13#10'<path strok' +
          'e="#e6e6e6" d="M2 10h1M13 10h1M3 12h1M12 12h1" />'#13#10'<path stroke=' +
          '"#e0e0e0" d="M3 10h1M12 10h1" />'#13#10'<path stroke="#dcdcdc" d="M4 1' +
          '0h1M11 10h1" />'#13#10'<path stroke="#eaeaea" d="M0 11h1M15 11h1" />'#13#10 +
          '<path stroke="#b7b7b7" d="M1 11h1M14 11h1M4 14h1M11 14h1" />'#13#10'<p' +
          'ath stroke="#dfdfdf" d="M3 11h1M12 11h1M5 13h1M10 13h1" />'#13#10'<pat' +
          'h stroke="#878787" d="M6 11h1M9 11h1" />'#13#10'<path stroke="#f4f4f4"' +
          ' d="M0 12h1M15 12h1M1 13h1M14 13h1" />'#13#10'<path stroke="#c5c5c5" d' +
          '="M2 12h1M13 12h1" />'#13#10'<path stroke="#dedede" d="M4 12h1M11 12h1' +
          '" />'#13#10'<path stroke="#e1e1e1" d="M5 12h1M10 12h1M4 13h1M11 13h1M7' +
          ' 14h2" />'#13#10'<path stroke="#fcfcfc" d="M7 12h2" />'#13#10'<path stroke="' +
          '#c3c3c3" d="M2 13h1M13 13h1" />'#13#10'<path stroke="#c4c4c4" d="M3 13' +
          'h1M12 13h1" />'#13#10'<path stroke="#dbdbdb" d="M6 13h1M9 13h1" />'#13#10'<p' +
          'ath stroke="#d8d8d8" d="M7 13h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '02'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#b8b8b8" d="M1 0h1M1' +
          '4 0h1M0 1h1M15 1h1M0 14h1M15 14h1M1 15h1M14 15h1" />'#13#10'<path stro' +
          'ke="#b3b3b3" d="M2 0h12M0 2h1M15 2h1M0 3h1M15 3h1M0 4h1M15 4h1M0' +
          ' 5h1M15 5h1M0 6h1M15 6h1M0 7h1M15 7h1M0 8h1M15 8h1M0 9h1M15 9h1M' +
          '0 10h1M15 10h1M0 11h1M15 11h1M0 12h1M15 12h1M0 13h1M15 13h1M2 15' +
          'h12" />'#13#10'<path stroke="#eeeeee" d="M1 1h1M14 1h1M3 2h10M1 8h1M14' +
          ' 8h1" />'#13#10'<path stroke="#fcfcfc" d="M2 1h12" />'#13#10'<path stroke="#' +
          'fbfbfb" d="M1 2h1M14 2h1" />'#13#10'<path stroke="#f0f0f0" d="M2 2h1M1' +
          '3 2h1" />'#13#10'<path stroke="#f9f9f9" d="M1 3h1M14 3h1" />'#13#10'<path st' +
          'roke="#ededed" d="M2 3h12M1 9h1M14 9h1" />'#13#10'<path stroke="#f7f7f' +
          '7" d="M1 4h1M14 4h1" />'#13#10'<path stroke="#ebebeb" d="M2 4h12M1 10h' +
          '1M14 10h1" />'#13#10'<path stroke="#f5f5f5" d="M1 5h1M14 5h1" />'#13#10'<pat' +
          'h stroke="#e9e9e9" d="M2 5h12M1 11h1M14 11h1" />'#13#10'<path stroke="' +
          '#f3f3f3" d="M1 6h1M14 6h1" />'#13#10'<path stroke="#e7e7e7" d="M2 6h12' +
          'M1 12h1M14 12h1" />'#13#10'<path stroke="#f1f1f1" d="M1 7h1M14 7h1" />' +
          #13#10'<path stroke="#e5e5e5" d="M2 7h12M1 13h1M14 13h1" />'#13#10'<path st' +
          'roke="#e3e3e3" d="M2 8h12M2 14h12" />'#13#10'<path stroke="#e2e2e2" d=' +
          '"M2 9h12" />'#13#10'<path stroke="#e0e0e0" d="M2 10h12" />'#13#10'<path stro' +
          'ke="#dedede" d="M2 11h12" />'#13#10'<path stroke="#dcdcdc" d="M2 12h12' +
          '" />'#13#10'<path stroke="#dbdbdb" d="M2 13h1M13 13h1" />'#13#10'<path strok' +
          'e="#dad9da" d="M3 13h10M1 14h1M14 14h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '03'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#b8b8b8" d="M1 0h1M1' +
          '4 0h1M0 1h1M15 1h1M0 14h1M15 14h1M1 15h1M14 15h1" />'#13#10'<path stro' +
          'ke="#b3b3b3" d="M2 0h12M0 2h1M15 2h1M0 3h1M15 3h1M0 4h1M15 4h1M0' +
          ' 5h1M15 5h1M0 6h1M15 6h1M0 7h1M15 7h1M0 8h1M15 8h1M0 9h1M15 9h1M' +
          '0 10h1M15 10h1M0 11h1M15 11h1M0 12h1M15 12h1M0 13h1M15 13h1M2 15' +
          'h12" />'#13#10'<path stroke="#eeeeee" d="M1 1h1M14 1h1M3 2h9M1 8h1M14 ' +
          '8h1" />'#13#10'<path stroke="#fcfcfc" d="M2 1h12" />'#13#10'<path stroke="#f' +
          'bfbfb" d="M1 2h1M14 2h1" />'#13#10'<path stroke="#f0f0f0" d="M2 2h1" /' +
          '>'#13#10'<path stroke="#c8c8c8" d="M12 2h1" />'#13#10'<path stroke="#d6d6d6"' +
          ' d="M13 2h1" />'#13#10'<path stroke="#f9f9f9" d="M1 3h1M14 3h1" />'#13#10'<p' +
          'ath stroke="#ededed" d="M2 3h9M1 9h1M14 9h1M7 13h1" />'#13#10'<path st' +
          'roke="#d1d1d1" d="M11 3h1" />'#13#10'<path stroke="#646464" d="M12 3h1' +
          '" />'#13#10'<path stroke="#e8e8e8" d="M13 3h1M8 12h1" />'#13#10'<path stroke' +
          '="#f7f7f7" d="M1 4h1M14 4h1M6 13h1" />'#13#10'<path stroke="#ebebeb" d' +
          '="M2 4h8M13 4h1M10 9h1M1 10h1M14 10h1" />'#13#10'<path stroke="#6a6a6a' +
          '" d="M11 4h1" />'#13#10'<path stroke="#9e9e9e" d="M12 4h1" />'#13#10'<path s' +
          'troke="#f5f5f5" d="M1 5h1M14 5h1" />'#13#10'<path stroke="#e9e9e9" d="' +
          'M2 5h8M13 5h1M12 6h1M1 11h1M14 11h1" />'#13#10'<path stroke="#888888" ' +
          'd="M10 5h1" />'#13#10'<path stroke="#5e5e5e" d="M11 5h1M9 7h1" />'#13#10'<pa' +
          'th stroke="#e5e5e5" d="M12 5h1M2 7h1M5 7h3M12 7h2M1 13h1M14 13h1' +
          '" />'#13#10'<path stroke="#f3f3f3" d="M1 6h1M14 6h1" />'#13#10'<path stroke=' +
          '"#e7e7e7" d="M2 6h1M5 6h4M13 6h1M4 11h1M1 12h1M14 12h1" />'#13#10'<pat' +
          'h stroke="#d5d5d5" d="M3 6h1" />'#13#10'<path stroke="#e4e4e4" d="M4 6' +
          'h1M5 12h1" />'#13#10'<path stroke="#aaaaaa" d="M9 6h1" />'#13#10'<path strok' +
          'e="#575757" d="M10 6h1M4 8h1M9 8h1M5 9h1M8 9h1M5 10h3M6 11h2" />' +
          #13#10'<path stroke="#a7a7a7" d="M11 6h1" />'#13#10'<path stroke="#f1f1f1" ' +
          'd="M1 7h1M14 7h1" />'#13#10'<path stroke="#a2a2a2" d="M3 7h1" />'#13#10'<pat' +
          'h stroke="#838383" d="M4 7h1" />'#13#10'<path stroke="#cbcbcb" d="M8 7' +
          'h1" />'#13#10'<path stroke="#686868" d="M10 7h1" />'#13#10'<path stroke="#ec' +
          'ecec" d="M11 7h1" />'#13#10'<path stroke="#e3e3e3" d="M2 8h1M6 8h1M11 ' +
          '8h3M9 10h1M2 14h12" />'#13#10'<path stroke="#d4d4d4" d="M3 8h1" />'#13#10'<p' +
          'ath stroke="#929292" d="M5 8h1" />'#13#10'<path stroke="#dcdcdc" d="M7' +
          ' 8h1M2 12h3M9 12h5" />'#13#10'<path stroke="#6f6f6f" d="M8 8h1" />'#13#10'<p' +
          'ath stroke="#c0c0c0" d="M10 8h1" />'#13#10'<path stroke="#e2e2e2" d="M' +
          '2 9h1M11 9h3" />'#13#10'<path stroke="#e6e6e6" d="M3 9h1" />'#13#10'<path st' +
          'roke="#7a7a7a" d="M4 9h1" />'#13#10'<path stroke="#919191" d="M6 9h1" ' +
          '/>'#13#10'<path stroke="#848484" d="M7 9h1" />'#13#10'<path stroke="#878787"' +
          ' d="M9 9h1M5 11h1" />'#13#10'<path stroke="#e0e0e0" d="M2 10h2M10 10h4' +
          '" />'#13#10'<path stroke="#c6c6c6" d="M4 10h1" />'#13#10'<path stroke="#6161' +
          '61" d="M8 10h1" />'#13#10'<path stroke="#dedede" d="M2 11h2M10 11h4" /' +
          '>'#13#10'<path stroke="#bfbfbf" d="M8 11h1" />'#13#10'<path stroke="#727272"' +
          ' d="M6 12h1" />'#13#10'<path stroke="#a1a1a1" d="M7 12h1" />'#13#10'<path st' +
          'roke="#dbdbdb" d="M2 13h1M13 13h1" />'#13#10'<path stroke="#dad9da" d=' +
          '"M3 13h2M8 13h5M1 14h1M14 14h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '04'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#999999" d="M4 6h1" ' +
          '/>'#13#10'<path stroke="#575757" d="M5 6h6M6 7h4M7 8h2" />'#13#10'<path stro' +
          'ke="#aeaeae" d="M11 6h1" />'#13#10'<path stroke="#9c9c9c" d="M5 7h1" /' +
          '>'#13#10'<path stroke="#afafaf" d="M10 7h1" />'#13#10'<path stroke="#9d9d9d"' +
          ' d="M6 8h1" />'#13#10'<path stroke="#b1b1b1" d="M9 8h1" />'#13#10'<path stro' +
          'ke="#9e9e9e" d="M7 9h1" />'#13#10'<path stroke="#b2b2b2" d="M8 9h1" />' +
          #13#10'</svg>'#13#10
      end
      item
        IconName = '05'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#575757" d="M3 3h9M3' +
          ' 4h9M3 5h9M3 6h1M5 6h1M7 6h1M9 6h1M11 6h1M3 7h9M3 8h1M5 8h1M7 8h' +
          '1M9 8h1M11 8h1M3 9h9M3 10h1M5 10h1M7 10h1M9 10h1M11 10h1M3 11h9"' +
          ' />'#13#10'<path stroke="#ffffff" d="M4 6h1M6 6h1M8 6h1M10 6h1M4 8h1M6' +
          ' 8h1M8 8h1M10 8h1M4 10h1M6 10h1M8 10h1M10 10h1M3 12h9" />'#13#10'</svg' +
          '>'#13#10
      end>
    Left = 144
    Top = 168
  end
  object vilPythonControls: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end>
    ImageCollection = icPythonControls
    Left = 272
    Top = 168
  end
  object icQtControls: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = '00'
        SVGText = 
          '<svg viewBox="0 -0.5 15 15">'#13#10'<path stroke="#363636" d="M1 1h13M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M1 13h13" />'#13#10'<path stroke="#ffffff" d="M2 2' +
          'h11M2 3h11M2 4h11M2 5h11M2 6h11M2 7h11M2 8h11M2 9h11M2 10h11M2 1' +
          '1h11M2 12h11" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '01'
        SVGText = 
          '<svg viewBox="0 -0.5 15 15">'#13#10'<path stroke="#363636" d="M1 1h13M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M1 13h13" />'#13#10'<path stroke="#ffffff" d="M2 2' +
          'h11M2 3h11M2 4h8M2 5h7M2 6h6M12 6h1M5 7h2M11 7h2M10 8h3M2 9h1M9 ' +
          '9h4M2 10h2M8 10h5M2 11h11M2 12h11" />'#13#10'<path stroke="#e1e1e1" d=' +
          '"M10 4h1M9 5h1M8 6h1M4 7h1M7 7h1M5 8h2" />'#13#10'<path stroke="#49494' +
          '9" d="M11 4h1M10 5h1M9 6h1M3 7h1M8 7h1M4 8h1M7 8h1M5 9h2" />'#13#10'<p' +
          'ath stroke="#b6b6b6" d="M12 4h1M2 7h1" />'#13#10'<path stroke="#6a6a6a' +
          '" d="M11 5h1M10 6h1M9 7h1M3 8h1M8 8h1M4 9h1M7 9h1M5 10h2" />'#13#10'<p' +
          'ath stroke="#f5f5f5" d="M12 5h1M11 6h1M10 7h1M2 8h1M9 8h1M3 9h1M' +
          '8 9h1M4 10h1M7 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '02'
        SVGText = 
          '<svg viewBox="0 -0.5 15 15">'#13#10'<path stroke="#c2c2c2" d="M4 1h1M1' +
          '0 1h1M1 4h1M13 4h1M1 10h1M13 10h1M4 13h1M10 13h1" />'#13#10'<path stro' +
          'ke="#737373" d="M5 1h1M9 1h1M13 5h1M1 9h1M13 9h1M5 13h1M9 13h1" ' +
          '/>'#13#10'<path stroke="#484848" d="M6 1h1M8 1h1" />'#13#10'<path stroke="#3' +
          'a3a3a" d="M7 1h1M13 7h1M7 13h1" />'#13#10'<path stroke="#808080" d="M3' +
          ' 2h1M11 2h1M3 12h1M11 12h1" />'#13#10'<path stroke="#626262" d="M4 2h1' +
          'M10 2h1M2 4h1M12 4h1M2 10h1M12 10h1M4 12h1M10 12h1" />'#13#10'<path st' +
          'roke="#b5b5b5" d="M5 2h1M9 2h1M2 9h1M12 9h1M5 12h1M9 12h1" />'#13#10'<' +
          'path stroke="#e8e8e8" d="M6 2h1M8 2h1" />'#13#10'<path stroke="#f9f9f9' +
          '" d="M7 2h1M12 7h1M7 12h1" />'#13#10'<path stroke="#7c7c7c" d="M2 3h1M' +
          '12 3h1" />'#13#10'<path stroke="#888888" d="M3 3h1" />'#13#10'<path stroke="' +
          '#fdfdfd" d="M4 3h1M10 3h1M4 11h1M10 11h1" />'#13#10'<path stroke="#fff' +
          'fff" d="M5 3h5M3 4h9M3 5h9M3 6h9M2 7h10M3 8h9M3 9h9M4 10h7M5 11h' +
          '5" />'#13#10'<path stroke="#898989" d="M11 3h1M3 11h1M11 11h1" />'#13#10'<pa' +
          'th stroke="#747474" d="M1 5h1" />'#13#10'<path stroke="#b4b4b4" d="M2 ' +
          '5h1M12 5h1" />'#13#10'<path stroke="#454545" d="M1 6h1M1 8h1" />'#13#10'<pat' +
          'h stroke="#ececec" d="M2 6h1M2 8h1" />'#13#10'<path stroke="#e9e9e9" d' +
          '="M12 6h1M12 8h1M6 12h1M8 12h1" />'#13#10'<path stroke="#474747" d="M1' +
          '3 6h1M13 8h1M6 13h1M8 13h1" />'#13#10'<path stroke="#363636" d="M1 7h1' +
          '" />'#13#10'<path stroke="#fcfcfc" d="M3 10h1M11 10h1" />'#13#10'<path strok' +
          'e="#818181" d="M2 11h1M12 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '03'
        SVGText = 
          '<svg viewBox="0 -0.5 15 15">'#13#10'<path stroke="#c2c2c2" d="M4 1h1M1' +
          '0 1h1M1 4h1M13 4h1M1 10h1M13 10h1M4 13h1M10 13h1" />'#13#10'<path stro' +
          'ke="#737373" d="M5 1h1M9 1h1M13 5h1M1 9h1M13 9h1M5 13h1M9 13h1" ' +
          '/>'#13#10'<path stroke="#484848" d="M6 1h1M8 1h1" />'#13#10'<path stroke="#3' +
          'a3a3a" d="M7 1h1M7 4h1M4 7h1M10 7h1M13 7h1M7 13h1" />'#13#10'<path str' +
          'oke="#808080" d="M3 2h1M11 2h1M3 12h1M11 12h1" />'#13#10'<path stroke=' +
          '"#626262" d="M4 2h1M10 2h1M2 4h1M12 4h1M2 10h1M12 10h1M4 12h1M10' +
          ' 12h1" />'#13#10'<path stroke="#b5b5b5" d="M5 2h1M9 2h1M2 9h1M12 9h1M5' +
          ' 12h1M9 12h1" />'#13#10'<path stroke="#e8e8e8" d="M6 2h1M8 2h1" />'#13#10'<p' +
          'ath stroke="#f9f9f9" d="M7 2h1M12 7h1M7 12h1" />'#13#10'<path stroke="' +
          '#7c7c7c" d="M2 3h1M12 3h1" />'#13#10'<path stroke="#888888" d="M3 3h1"' +
          ' />'#13#10'<path stroke="#fdfdfd" d="M4 3h1M10 3h1M4 11h1M10 11h1" />'#13 +
          #10'<path stroke="#ffffff" d="M5 3h5M3 4h2M10 4h2M3 5h1M11 5h1M3 6h' +
          '1M11 6h1M2 7h2M11 7h1M3 8h1M11 8h1M3 9h1M11 9h1M4 10h1M10 10h1M5' +
          ' 11h5" />'#13#10'<path stroke="#898989" d="M11 3h1M3 11h1M11 11h1" />'#13 +
          #10'<path stroke="#b8b8b8" d="M5 4h1M9 4h1M10 5h1" />'#13#10'<path stroke' +
          '="#555555" d="M6 4h1M8 4h1M4 6h1M10 6h1M4 8h1M10 8h1" />'#13#10'<path ' +
          'stroke="#747474" d="M1 5h1" />'#13#10'<path stroke="#b4b4b4" d="M2 5h1' +
          'M12 5h1" />'#13#10'<path stroke="#bababa" d="M4 5h1" />'#13#10'<path stroke=' +
          '"#363636" d="M5 5h5M5 6h5M1 7h1M5 7h5M5 8h5M5 9h5" />'#13#10'<path str' +
          'oke="#454545" d="M1 6h1M1 8h1" />'#13#10'<path stroke="#ececec" d="M2 ' +
          '6h1M2 8h1" />'#13#10'<path stroke="#e9e9e9" d="M12 6h1M12 8h1M6 12h1M8' +
          ' 12h1" />'#13#10'<path stroke="#474747" d="M13 6h1M13 8h1M6 13h1M8 13h' +
          '1" />'#13#10'<path stroke="#b9b9b9" d="M4 9h1" />'#13#10'<path stroke="#b7b7' +
          'b7" d="M10 9h1M5 10h1M9 10h1" />'#13#10'<path stroke="#fcfcfc" d="M3 1' +
          '0h1M11 10h1" />'#13#10'<path stroke="#545454" d="M6 10h1M8 10h1" />'#13#10'<' +
          'path stroke="#393939" d="M7 10h1" />'#13#10'<path stroke="#818181" d="' +
          'M2 11h1M12 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '04'
        SVGText = 
          '<svg viewBox="0 -1.5 15 15">'#13#10'<path stroke="#d1d1d1" d="M3 0h1M1' +
          '0 0h1" />'#13#10'<path stroke="#939393" d="M4 0h1M9 0h1" />'#13#10'<path str' +
          'oke="#616161" d="M5 0h1M8 0h1" />'#13#10'<path stroke="#404040" d="M6 ' +
          '0h2M6 1h2" />'#13#10'<path stroke="#a8a8a8" d="M2 1h1M11 1h1M1 2h1M12 ' +
          '2h1" />'#13#10'<path stroke="#545454" d="M3 1h1M10 1h1M2 9h1M11 9h1" /' +
          '>'#13#10'<path stroke="#393939" d="M4 1h1M9 1h1" />'#13#10'<path stroke="#3e' +
          '3e3e" d="M5 1h1M8 1h1M6 9h2" />'#13#10'<path stroke="#424242" d="M2 2h' +
          '2M10 2h2M1 4h1M12 4h1M6 10h2M4 11h1M9 11h1" />'#13#10'<path stroke="#4' +
          'a4a4a" d="M4 2h1M9 2h1" />'#13#10'<path stroke="#4f4f4f" d="M5 2h1M8 2' +
          'h1M2 10h1M11 10h1" />'#13#10'<path stroke="#525252" d="M6 2h2M3 6h1M10' +
          ' 6h1M1 7h1M12 7h1" />'#13#10'<path stroke="#d2d2d2" d="M0 3h1M13 3h1" ' +
          '/>'#13#10'<path stroke="#585858" d="M1 3h1M12 3h1" />'#13#10'<path stroke="#' +
          '454545" d="M2 3h1M11 3h1" />'#13#10'<path stroke="#505050" d="M3 3h1M1' +
          '0 3h1M2 4h1M11 4h1M1 6h1M12 6h1M0 7h1M13 7h1M1 8h1M12 8h1M6 11h2' +
          'M6 12h2" />'#13#10'<path stroke="#9a9a9a" d="M4 3h1M9 3h1" />'#13#10'<path s' +
          'troke="#6a6a6a" d="M5 3h1M8 3h1M0 5h1M13 5h1" />'#13#10'<path stroke="' +
          '#626262" d="M6 3h2" />'#13#10'<path stroke="#979797" d="M0 4h1M13 4h1M' +
          '3 9h1M10 9h1" />'#13#10'<path stroke="#999999" d="M3 4h1M10 4h1" />'#13#10'<' +
          'path stroke="#ffffff" d="M4 4h1M9 4h1M5 5h1M8 5h1M6 6h2M6 7h2M5 ' +
          '8h1M8 8h1M4 9h1M9 9h1" />'#13#10'<path stroke="#e4e4e4" d="M5 4h1M8 4h' +
          '1" />'#13#10'<path stroke="#727272" d="M6 4h2" />'#13#10'<path stroke="#4b4b' +
          '4b" d="M1 5h1M12 5h1M4 12h1M9 12h1" />'#13#10'<path stroke="#555555" d' +
          '="M2 5h1M11 5h1" />'#13#10'<path stroke="#5d5d5d" d="M3 5h1M10 5h1M2 7' +
          'h1M11 7h1" />'#13#10'<path stroke="#dfdfdf" d="M4 5h1M9 5h1M6 8h2" />'#13 +
          #10'<path stroke="#e6e6e6" d="M6 5h2" />'#13#10'<path stroke="#4e4e4e" d=' +
          '"M0 6h1M13 6h1M1 9h1M12 9h1M5 12h1M8 12h1" />'#13#10'<path stroke="#5a' +
          '5a5a" d="M2 6h1M11 6h1M2 8h1M11 8h1" />'#13#10'<path stroke="#4c4c4c" ' +
          'd="M4 6h1M9 6h1" />'#13#10'<path stroke="#e1e1e1" d="M5 6h1M8 6h1M5 7h' +
          '1M8 7h1" />'#13#10'<path stroke="#5e5e5e" d="M3 7h1M10 7h1" />'#13#10'<path ' +
          'stroke="#5b5b5b" d="M4 7h1M9 7h1" />'#13#10'<path stroke="#6f6f6f" d="' +
          'M0 8h1M13 8h1" />'#13#10'<path stroke="#696969" d="M3 8h1M10 8h1" />'#13#10 +
          '<path stroke="#e2e2e2" d="M4 8h1M9 8h1" />'#13#10'<path stroke="#9c9c9' +
          'c" d="M0 9h1M13 9h1" />'#13#10'<path stroke="#dddddd" d="M5 9h1M8 9h1"' +
          ' />'#13#10'<path stroke="#d5d5d5" d="M0 10h1M13 10h1" />'#13#10'<path stroke' +
          '="#646464" d="M1 10h1M12 10h1M3 12h1M10 12h1" />'#13#10'<path stroke="' +
          '#434343" d="M3 10h1M10 10h1" />'#13#10'<path stroke="#858585" d="M4 10' +
          'h1M9 10h1" />'#13#10'<path stroke="#444444" d="M5 10h1M8 10h1" />'#13#10'<pa' +
          'th stroke="#b0b0b0" d="M1 11h1M12 11h1M2 12h1M11 12h1" />'#13#10'<path' +
          ' stroke="#535353" d="M2 11h1M11 11h1" />'#13#10'<path stroke="#484848"' +
          ' d="M3 11h1M10 11h1" />'#13#10'<path stroke="#464646" d="M5 11h1M8 11h' +
          '1" />'#13#10'<path stroke="#d6d6d6" d="M3 13h1M10 13h1" />'#13#10'<path stro' +
          'ke="#a0a0a0" d="M4 13h1" />'#13#10'<path stroke="#747474" d="M5 13h1" ' +
          '/>'#13#10'<path stroke="#555656" d="M6 13h1" />'#13#10'<path stroke="#565656' +
          '" d="M7 13h1" />'#13#10'<path stroke="#747374" d="M8 13h1" />'#13#10'<path s' +
          'troke="#9fa09f" d="M9 13h1" />'#13#10'</svg>'#13#10
      end>
    Left = 144
    Top = 240
  end
  object vilQtControls1616: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end>
    ImageCollection = icQtControls
    Left = 272
    Top = 240
  end
end
