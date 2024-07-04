object FTextDiff: TFTextDiff
  Left = 362
  Top = 211
  Caption = 'Compare text'
  ClientHeight = 534
  ClientWidth = 796
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 15
  object TBTextDiff: TToolBar
    Left = 0
    Top = 0
    Width = 796
    Height = 26
    AutoSize = True
    EdgeBorders = [ebTop, ebBottom]
    Images = vilTextDiffDark
    Indent = 4
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ExplicitWidth = 792
    object TBClose: TToolButton
      Left = 4
      Top = 0
      Hint = 'Close'
      ImageIndex = 0
      ImageName = 'Close'
      OnClick = TBCloseClick
    end
    object TBView: TToolButton
      Left = 27
      Top = 0
      Hint = 'Change view'
      ImageIndex = 1
      ImageName = 'Horizontal'
      OnClick = HorzSplitClick
    end
    object TBNext: TToolButton
      Left = 50
      Top = 0
      Hint = 'Next difference'
      ImageIndex = 3
      ImageName = 'Down'
      OnClick = NextClick
    end
    object TBPrev: TToolButton
      Left = 73
      Top = 0
      Hint = 'Previous difference'
      ImageIndex = 4
      ImageName = 'Up'
      OnClick = PrevClick
    end
    object TBSourcecode: TToolButton
      Left = 96
      Top = 0
      Hint = 'Source code'
      ImageIndex = 5
      ImageName = 'Sourcecode'
      OnClick = TBSourcecodeClick
    end
    object TBCompare: TToolButton
      Left = 119
      Top = 0
      Hint = 'Compare'
      HelpType = htKeyword
      ImageIndex = 6
      ImageName = 'Compare'
      OnClick = TBCompareClick
    end
    object TBDiffsOnly: TToolButton
      Left = 142
      Top = 0
      Hint = 'Only differences'
      HelpType = htKeyword
      ImageIndex = 7
      ImageName = 'DiffsOnly'
      OnClick = TBDiffsOnlyClick
    end
    object TBCopyBlockLeft: TToolButton
      Left = 165
      Top = 0
      Hint = 'Copy block left'
      HelpType = htKeyword
      ImageIndex = 8
      ImageName = 'Left'
      OnClick = CopyBlockLeftClick
    end
    object TBCopyBlockRight: TToolButton
      Left = 188
      Top = 0
      Hint = 'Copy block right'
      HelpType = htKeyword
      ImageIndex = 9
      ImageName = 'Right'
      OnClick = CopyBlockRightClick
    end
    object TBIgnoreCase: TToolButton
      Left = 211
      Top = 0
      Hint = 'Ignore upper/lower case'
      ImageIndex = 12
      ImageName = 'IgnoreCase'
      OnClick = TBIgnoreCaseClick
    end
    object TBIgnoreBlanks: TToolButton
      Left = 234
      Top = 0
      Hint = 'Ignore spaces'
      ImageIndex = 13
      ImageName = 'IgnoreBlanks'
      OnClick = TBIgnoreBlanksClick
    end
    object TBParagraph: TToolButton
      Left = 257
      Top = 0
      Hint = 'Paragraph marks on/off '
      ImageIndex = 14
      ImageName = 'Paragraph'
      OnClick = TBParagraphClick
    end
    object TBZoomOut: TToolButton
      Left = 280
      Top = 0
      Caption = 'Zoom out'
      ImageIndex = 15
      ImageName = 'ZoomOut'
      OnClick = TBZoomOutClick
    end
    object TBZoomIn: TToolButton
      Left = 303
      Top = 0
      Caption = 'Zoom in'
      ImageIndex = 16
      ImageName = 'ZoomIn'
      OnClick = TBZoomInClick
    end
  end
  object PMain: TPanel
    Left = 0
    Top = 26
    Width = 796
    Height = 483
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 792
    ExplicitHeight = 482
    object Splitter: TSplitter
      Left = 315
      Top = 0
      Height = 483
      OnMoved = SplitterMoved
      ExplicitHeight = 214
    end
    object PLeft: TPanel
      Left = 0
      Top = 0
      Width = 315
      Height = 483
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 482
      object PCaptionLeft: TPanel
        Left = 0
        Top = 0
        Width = 315
        Height = 20
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object PRight: TPanel
      Left = 318
      Top = 0
      Width = 478
      Height = 483
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 474
      ExplicitHeight = 482
      object PCaptionRight: TPanel
        Left = 0
        Top = 0
        Width = 478
        Height = 20
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitWidth = 474
      end
    end
  end
  object StatusBar: TSpTBXStatusBar
    Left = 0
    Top = 509
    Width = 796
    Height = 25
    ExplicitTop = 508
    ExplicitWidth = 792
    object liLineColumn: TSpTBXLabelItem
      Caption = '0000: 000'
      Alignment = taCenter
      MinWidth = 60
    end
    object liModifiedProtected: TSpTBXLabelItem
      Caption = 'Modified'
      Alignment = taCenter
    end
    object liInsOvr: TSpTBXLabelItem
      Caption = 'Insert Overwrite'
      Alignment = taCenter
    end
    object liEncoding: TSpTBXLabelItem
      Caption = 'Encoding'
      Alignment = taCenter
    end
    object liAdded: TSpTBXLabelItem
      Tag = 1
      Caption = 'Added'
      Alignment = taCenter
      OnDrawItem = liDrawItem
    end
    object liModified: TSpTBXLabelItem
      Tag = 2
      Caption = 'Modified'
      Alignment = taCenter
      OnDrawItem = liDrawItem
    end
    object liDeleted: TSpTBXLabelItem
      Tag = 3
      Caption = 'Deleted'
      Alignment = taCenter
      OnDrawItem = liDrawItem
    end
    object liDifferences: TSpTBXLabelItem
      Caption = 'Differences'
    end
  end
  object PopUpEditor: TSpTBXPopupMenu
    Left = 174
    Top = 98
    object MIUndo: TSpTBXItem
      Caption = 'Undo'
      ShortCut = 16474
      OnClick = MIUndoClick
    end
    object MIRedo: TSpTBXItem
      Caption = 'Redo'
      OnClick = MIRedoClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MICut: TSpTBXItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = MICutClick
    end
    object MICopy: TSpTBXItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = MICopyClick
    end
    object MIPaste: TSpTBXItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = MIPasteClick
    end
    object MIClose: TSpTBXItem
      Caption = 'Close'
      ShortCut = 16499
      OnClick = MICloseClick
    end
  end
  object vilTextDiffLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Horizontal'
        Name = 'Horizontal'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Vertical'
        Name = 'Vertical'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Sourcecode'
        Name = 'Sourcecode'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Compare'
        Name = 'Compare'
      end
      item
        CollectionIndex = 8
        CollectionName = 'DiffsOnly'
        Name = 'DiffsOnly'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Left'
        Name = 'Left'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Right'
        Name = 'Right'
      end
      item
        CollectionIndex = 12
        CollectionName = 'GreenUp'
        Name = 'GreenUp'
      end
      item
        CollectionIndex = 13
        CollectionName = 'GreenDown'
        Name = 'GreenDown'
      end
      item
        CollectionIndex = 14
        CollectionName = 'IgnoreCase'
        Name = 'IgnoreCase'
      end
      item
        CollectionIndex = 16
        CollectionName = 'IgnoreBlanks'
        Name = 'IgnoreBlanks'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Paragraph'
        Name = 'Paragraph'
      end
      item
        CollectionIndex = 20
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 21
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end>
    ImageCollection = icTextDiff
    Left = 64
    Top = 226
  end
  object vilTextDiffDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Horizontal'
        Name = 'Horizontal'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Vertical'
        Name = 'Vertical'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Down'
        Name = 'Down'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Up'
        Name = 'Up'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Sourcecode'
        Name = 'Sourcecode'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Compare'
        Name = 'Compare'
      end
      item
        CollectionIndex = 9
        CollectionName = 'DiffsOnly'
        Name = 'DiffsOnly'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Left'
        Name = 'Left'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Right'
        Name = 'Right'
      end
      item
        CollectionIndex = 12
        CollectionName = 'GreenUp'
        Name = 'GreenUp'
      end
      item
        CollectionIndex = 13
        CollectionName = 'GreenDown'
        Name = 'GreenDown'
      end
      item
        CollectionIndex = 15
        CollectionName = 'IgnoreCase'
        Name = 'IgnoreCase'
      end
      item
        CollectionIndex = 17
        CollectionName = 'IgnoreBlanks'
        Name = 'IgnoreBlanks'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Paragraph'
        Name = 'Paragraph'
      end
      item
        CollectionIndex = 22
        CollectionName = 'ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 23
        CollectionName = 'ZoomIn'
        Name = 'ZoomIn'
      end>
    ImageCollection = icTextDiff
    Left = 168
    Top = 226
  end
  object icTextDiff: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Close'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Close'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#ffffff">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Horizontal'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 1h13M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h13M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13 11h1M' +
          '1 12h1M13 12h1M1 13h13" />'#13#10'<path stroke="#ffffff" d="M2 2h1M2 4' +
          'h11M2 5h11M2 6h11M2 8h1M2 10h11M2 11h11M2 12h11" />'#13#10'<path strok' +
          'e="#000077" d="M3 2h1M5 2h2M8 2h2M11 2h2M2 3h11M3 8h1M5 8h8M2 9h' +
          '2M5 9h2M8 9h2M11 9h2" />'#13#10'<path stroke="#000097" d="M4 2h1M7 2h1' +
          'M10 2h1M4 8h1M4 9h1M7 9h1M10 9h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Vertical'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 1h13M' +
          '1 2h1M7 2h1M13 2h1M1 3h1M7 3h1M13 3h1M1 4h1M7 4h1M13 4h1M1 5h1M7' +
          ' 5h1M13 5h1M1 6h1M7 6h1M13 6h1M1 7h1M7 7h1M13 7h1M1 8h1M7 8h1M13' +
          ' 8h1M1 9h1M7 9h1M13 9h1M1 10h1M7 10h1M13 10h1M1 11h1M7 11h1M13 1' +
          '1h1M1 12h1M7 12h1M13 12h1M1 13h13" />'#13#10'<path stroke="#ffffff" d=' +
          '"M2 2h1M8 2h1M2 4h5M8 4h5M2 5h5M8 5h5M2 6h5M8 6h5M2 7h5M8 7h5M2 ' +
          '8h5M8 8h5M2 9h5M8 9h5M2 10h5M8 10h5M2 11h5M8 11h5M2 12h5M8 12h5"' +
          ' />'#13#10'<path stroke="#000077" d="M3 2h1M5 2h2M9 2h1M11 2h2M2 3h5M8' +
          ' 3h2M11 3h2" />'#13#10'<path stroke="#000097" d="M4 2h1M10 2h1M10 3h1"' +
          ' />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Down'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#6f9eef" d="M5 3h1M3' +
          ' 7h1" />'#13#10'<path stroke="#6f96df" d="M6 3h1M5 4h1M4 7h1" />'#13#10'<pat' +
          'h stroke="#6f8edf" d="M7 3h1M5 5h1M5 7h1" />'#13#10'<path stroke="#608' +
          '6ce" d="M8 3h2M5 6h1" />'#13#10'<path stroke="#9ebeff" d="M6 4h1M6 5h1' +
          '" />'#13#10'<path stroke="#8eb6ff" d="M7 4h1" />'#13#10'<path stroke="#8eaef' +
          'f" d="M8 4h1" />'#13#10'<path stroke="#516fbe" d="M9 4h1" />'#13#10'<path st' +
          'roke="#7fa6ff" d="M7 5h1M6 7h1" />'#13#10'<path stroke="#608eef" d="M8' +
          ' 5h1M7 7h1" />'#13#10'<path stroke="#4267ae" d="M9 5h1M11 7h1" />'#13#10'<pa' +
          'th stroke="#7faeff" d="M6 6h1" />'#13#10'<path stroke="#608eff" d="M7 ' +
          '6h1" />'#13#10'<path stroke="#5186ef" d="M8 6h1" />'#13#10'<path stroke="#42' +
          '60ae" d="M9 6h1M10 7h1" />'#13#10'<path stroke="#517edf" d="M8 7h1M6 9' +
          'h1" />'#13#10'<path stroke="#33509e" d="M9 7h1M10 8h1M9 9h1" />'#13#10'<path' +
          ' stroke="#5177be" d="M4 8h1" />'#13#10'<path stroke="#6f96ef" d="M5 8h' +
          '1" />'#13#10'<path stroke="#6f9eff" d="M6 8h1" />'#13#10'<path stroke="#5186' +
          'df" d="M7 8h1" />'#13#10'<path stroke="#5177ce" d="M8 8h1" />'#13#10'<path s' +
          'troke="#4267be" d="M9 8h1M8 9h1M7 10h1" />'#13#10'<path stroke="#bdc3c' +
          'c" d="M11 8h1" />'#13#10'<path stroke="#3358ae" d="M5 9h1M6 10h1M7 11h' +
          '1" />'#13#10'<path stroke="#5177df" d="M7 9h1" />'#13#10'<path stroke="#bec4' +
          'ce" d="M10 9h1" />'#13#10'<path stroke="#d2d5df" d="M5 10h1" />'#13#10'<path' +
          ' stroke="#33589e" d="M8 10h1" />'#13#10'<path stroke="#c0c6cf" d="M9 1' +
          '0h1" />'#13#10'<path stroke="#d1d4dd" d="M6 11h1" />'#13#10'<path stroke="#c' +
          '1c7d2" d="M8 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Up'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#c2cde2" d="M6 4h1" ' +
          '/>'#13#10'<path stroke="#6f96df" d="M7 4h1M4 7h1M3 8h1" />'#13#10'<path stro' +
          'ke="#c1c7d2" d="M8 4h1" />'#13#10'<path stroke="#c3cee3" d="M5 5h1" />' +
          #13#10'<path stroke="#6f9eef" d="M6 5h1M5 6h1" />'#13#10'<path stroke="#9eb' +
          'eff" d="M7 5h1M6 6h1M5 7h1M6 9h1" />'#13#10'<path stroke="#33589e" d="' +
          'M8 5h1" />'#13#10'<path stroke="#c0c6cf" d="M9 5h1" />'#13#10'<path stroke="' +
          '#c4cfe5" d="M4 6h1" />'#13#10'<path stroke="#8eaeff" d="M7 6h1M6 7h1M6' +
          ' 8h1" />'#13#10'<path stroke="#6086df" d="M8 6h1M8 9h1M7 10h1M6 11h1" ' +
          '/>'#13#10'<path stroke="#33509e" d="M9 6h1M10 7h1M6 12h1" />'#13#10'<path st' +
          'roke="#bec4ce" d="M10 6h1" />'#13#10'<path stroke="#c5d0e5" d="M3 7h1"' +
          ' />'#13#10'<path stroke="#6f9eff" d="M7 7h1" />'#13#10'<path stroke="#608eef' +
          '" d="M8 7h1" />'#13#10'<path stroke="#4277ce" d="M9 7h1" />'#13#10'<path str' +
          'oke="#bdc3cc" d="M11 7h1" />'#13#10'<path stroke="#426fce" d="M4 8h1" ' +
          '/>'#13#10'<path stroke="#3367ce" d="M5 8h1" />'#13#10'<path stroke="#6096ef"' +
          ' d="M7 8h2M7 9h1" />'#13#10'<path stroke="#3358ae" d="M9 8h1" />'#13#10'<pat' +
          'h stroke="#25509e" d="M10 8h1M9 9h1" />'#13#10'<path stroke="#25498e" ' +
          'd="M11 8h1M9 11h1M7 12h3" />'#13#10'<path stroke="#517edf" d="M5 9h1M5' +
          ' 10h1M5 11h1M5 12h1" />'#13#10'<path stroke="#7fa6ef" d="M6 10h1" />'#13#10 +
          '<path stroke="#5177ce" d="M8 10h1" />'#13#10'<path stroke="#25499e" d=' +
          '"M9 10h1" />'#13#10'<path stroke="#517ece" d="M7 11h1" />'#13#10'<path strok' +
          'e="#426fbe" d="M8 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Sourcecode'
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
        IconName = 'Compare'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#bc7f1a" d="M4 0h2M3' +
          ' 1h1M5 1h1M2 2h1M5 2h1M1 3h1M5 3h7M0 4h1M10 7h1M10 8h3M10 9h1M12' +
          ' 9h2M4 10h7M14 10h1M3 11h1M15 11h1" />'#13#10'<path stroke="#fdf9eb" d' +
          '="M4 1h1M4 2h1M11 9h1" />'#13#10'<path stroke="#fffff6" d="M3 2h1" />'#13 +
          #10'<path stroke="#fdf6d8" d="M2 3h3M11 10h3" />'#13#10'<path stroke="#fc' +
          'edc2" d="M1 4h5M7 4h5" />'#13#10'<path stroke="#fbf2c8" d="M6 4h1" />'#13 +
          #10'<path stroke="#a66c17" d="M12 4h1M6 5h1M8 5h1M10 5h1M5 6h1M3 7h' +
          '1M5 7h1M4 8h1M4 12h7M14 12h1M10 13h1M13 13h1M10 14h1M12 14h1M10 ' +
          '15h2" />'#13#10'<path stroke="#aa7118" d="M1 5h1M5 5h1M7 5h1M9 5h1M11 ' +
          '5h1M2 6h1M5 8h1" />'#13#10'<path stroke="#fde6a7" d="M2 5h3M12 11h1" /' +
          '>'#13#10'<path stroke="#fae397" d="M3 6h2M4 7h1M11 12h3M11 13h2M11 14h' +
          '1" />'#13#10'<path stroke="#ba893e" d="M11 7h1" />'#13#10'<path stroke="#fae' +
          'ab3" d="M4 11h5M10 11h1M14 11h1" />'#13#10'<path stroke="#fbf0b2" d="M' +
          '9 11h1M11 11h1M13 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'DiffsOnly'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 1h14M' +
          '1 2h1M14 2h1M1 3h1M14 3h1M1 4h1M14 4h1M1 5h14M1 6h1M14 6h1M1 7h1' +
          'M14 7h1M1 8h1M14 8h1M1 9h14M1 10h1M14 10h1M1 11h1M14 11h1M1 12h1' +
          'M14 12h1M1 13h14" />'#13#10'<path stroke="#89fa6e" d="M2 2h12M2 3h12M2' +
          ' 4h12" />'#13#10'<path stroke="#fe76b9" d="M2 6h12M2 7h12M2 8h12" />'#13#10 +
          '<path stroke="#a6caef" d="M2 10h12M2 11h12M2 12h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'DiffsOnly'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 1h14M' +
          '1 2h1M14 2h1M1 3h1M14 3h1M1 4h1M14 4h1M1 5h14M1 6h1M14 6h1M1 7h1' +
          'M14 7h1M1 8h1M14 8h1M1 9h14M1 10h1M14 10h1M1 11h1M14 11h1M1 12h1' +
          'M14 12h1M1 13h14" />'#13#10'<path stroke="#35a01c" d="M2 2h12M2 3h12M2' +
          ' 4h12" />'#13#10'<path stroke="#a42362" d="M2 6h12M2 7h12M2 8h12" />'#13#10 +
          '<path stroke="#507295" d="M2 10h12M2 11h12M2 12h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Left'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#d0d9cb" d="M7 2h1" ' +
          '/>'#13#10'<path stroke="#9ebe9e" d="M8 2h1M7 3h1" />'#13#10'<path stroke="#d' +
          '1dbcd" d="M6 3h1" />'#13#10'<path stroke="#606f50" d="M8 3h1" />'#13#10'<pat' +
          'h stroke="#d2dbce" d="M5 4h1" />'#13#10'<path stroke="#aec69e" d="M6 4' +
          'h1M5 5h1" />'#13#10'<path stroke="#ceefbe" d="M7 4h1M4 7h1" />'#13#10'<path ' +
          'stroke="#515850" d="M8 4h1" />'#13#10'<path stroke="#d3ddd0" d="M4 5h1' +
          '" />'#13#10'<path stroke="#cef7be" d="M6 5h1M5 6h1" />'#13#10'<path stroke="' +
          '#bee7ae" d="M7 5h1M6 6h1" />'#13#10'<path stroke="#425842" d="M8 5h1" ' +
          '/>'#13#10'<path stroke="#8ea68e" d="M9 5h1" />'#13#10'<path stroke="#8e9e7e"' +
          ' d="M10 5h2" />'#13#10'<path stroke="#7f967e" d="M12 5h1" />'#13#10'<path st' +
          'roke="#d4ddd0" d="M3 6h1" />'#13#10'<path stroke="#aece9e" d="M4 6h1" ' +
          '/>'#13#10'<path stroke="#aedf8e" d="M7 6h1M6 7h1" />'#13#10'<path stroke="#b' +
          'edf9e" d="M8 6h1" />'#13#10'<path stroke="#aed69e" d="M9 6h1" />'#13#10'<pat' +
          'h stroke="#9ec68e" d="M10 6h1" />'#13#10'<path stroke="#8ebe8e" d="M11' +
          ' 6h1" />'#13#10'<path stroke="#424942" d="M12 6h1M8 9h1" />'#13#10'<path str' +
          'oke="#9eb68e" d="M3 7h1" />'#13#10'<path stroke="#beefae" d="M5 7h1" /' +
          '>'#13#10'<path stroke="#9ed68e" d="M7 7h1M6 8h1" />'#13#10'<path stroke="#8e' +
          'c67e" d="M8 7h1" />'#13#10'<path stroke="#7fb66f" d="M9 7h1" />'#13#10'<path' +
          ' stroke="#6fae60" d="M10 7h1" />'#13#10'<path stroke="#608650" d="M11 ' +
          '7h1" />'#13#10'<path stroke="#334233" d="M12 7h1M9 9h1M8 10h1M7 11h2" ' +
          '/>'#13#10'<path stroke="#c1c5bd" d="M3 8h1" />'#13#10'<path stroke="#516750"' +
          ' d="M4 8h1" />'#13#10'<path stroke="#7fa66f" d="M5 8h1M7 9h1" />'#13#10'<pat' +
          'h stroke="#8ebe6f" d="M7 8h1" />'#13#10'<path stroke="#7fa660" d="M8 8' +
          'h1" />'#13#10'<path stroke="#6f9660" d="M9 8h1M6 9h1" />'#13#10'<path stroke' +
          '="#608e50" d="M10 8h1" />'#13#10'<path stroke="#517e42" d="M11 8h1" />' +
          #13#10'<path stroke="#333a33" d="M12 8h1M10 9h1M8 12h1" />'#13#10'<path str' +
          'oke="#cecec7" d="M4 9h1" />'#13#10'<path stroke="#516050" d="M5 9h1" /' +
          '>'#13#10'<path stroke="#252c25" d="M11 9h1" />'#13#10'<path stroke="#252525"' +
          ' d="M12 9h1" />'#13#10'<path stroke="#ccccc5" d="M5 10h1" />'#13#10'<path st' +
          'roke="#607760" d="M6 10h1" />'#13#10'<path stroke="#607e50" d="M7 10h1' +
          '" />'#13#10'<path stroke="#c5c5c0" d="M6 11h1" />'#13#10'<path stroke="#c4c4' +
          'bf" d="M7 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Right'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#9eb68e" d="M7 2h1M4' +
          ' 5h1M3 6h1" />'#13#10'<path stroke="#d0d9cc" d="M8 2h1" />'#13#10'<path stro' +
          'ke="#8ea68e" d="M7 3h1M5 5h1M3 7h1" />'#13#10'<path stroke="#7f967e" d' +
          '="M8 3h1M9 4h1M7 5h1M10 5h1M11 6h1M3 9h1" />'#13#10'<path stroke="#cac' +
          'fc0" d="M9 3h1" />'#13#10'<path stroke="#8e9e7e" d="M7 4h1M6 5h1M3 8h1' +
          '" />'#13#10'<path stroke="#bedf9e" d="M8 4h1" />'#13#10'<path stroke="#c9ceb' +
          'f" d="M10 4h1" />'#13#10'<path stroke="#9ebe8e" d="M3 5h1" />'#13#10'<path s' +
          'troke="#bee7ae" d="M8 5h1M6 6h1M4 8h1" />'#13#10'<path stroke="#8ec67e' +
          '" d="M9 5h1" />'#13#10'<path stroke="#c8cdbe" d="M11 5h1" />'#13#10'<path st' +
          'roke="#ceefae" d="M4 6h1" />'#13#10'<path stroke="#beefae" d="M5 6h1M4' +
          ' 7h1" />'#13#10'<path stroke="#bee79e" d="M7 6h1" />'#13#10'<path stroke="#a' +
          'edf9e" d="M8 6h1" />'#13#10'<path stroke="#8ebe6f" d="M9 6h1M8 7h1" />' +
          #13#10'<path stroke="#7fae6f" d="M10 6h1M5 8h1" />'#13#10'<path stroke="#c7' +
          'cbbc" d="M12 6h1" />'#13#10'<path stroke="#aedf8e" d="M5 7h1" />'#13#10'<pat' +
          'h stroke="#9ed68e" d="M6 7h1" />'#13#10'<path stroke="#9ece7e" d="M7 7' +
          'h1" />'#13#10'<path stroke="#7fb66f" d="M9 7h1" />'#13#10'<path stroke="#6fa' +
          '660" d="M10 7h1M9 8h1" />'#13#10'<path stroke="#608e50" d="M11 7h1M8 9' +
          'h1" />'#13#10'<path stroke="#607760" d="M12 7h1" />'#13#10'<path stroke="#7f' +
          'a66f" d="M6 8h1" />'#13#10'<path stroke="#6f9e60" d="M7 8h1" />'#13#10'<path' +
          ' stroke="#6f9660" d="M8 8h1" />'#13#10'<path stroke="#517742" d="M10 8' +
          'h1M9 9h1M8 10h1" />'#13#10'<path stroke="#252525" d="M11 8h1M10 9h1M9 ' +
          '10h1M8 11h1" />'#13#10'<path stroke="#a8aba3" d="M12 8h1" />'#13#10'<path st' +
          'roke="#252c25" d="M4 9h1" />'#13#10'<path stroke="#333a33" d="M5 9h1" ' +
          '/>'#13#10'<path stroke="#334233" d="M6 9h1" />'#13#10'<path stroke="#424942"' +
          ' d="M7 9h1" />'#13#10'<path stroke="#a9ada4" d="M11 9h1" />'#13#10'<path str' +
          'oke="#7f8e7e" d="M7 10h1M7 11h1M7 12h1" />'#13#10'<path stroke="#aaaea' +
          '6" d="M10 10h1" />'#13#10'<path stroke="#a7aaa2" d="M9 11h1" />'#13#10'<path' +
          ' stroke="#c4c4c0" d="M8 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'GreenUp'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#d4ddd0" d="M6 3h1" ' +
          '/>'#13#10'<path stroke="#9eb68e" d="M7 3h1" />'#13#10'<path stroke="#c1c5bd"' +
          ' d="M8 3h1" />'#13#10'<path stroke="#d3ddd0" d="M5 4h1" />'#13#10'<path stro' +
          'ke="#aece9e" d="M6 4h1" />'#13#10'<path stroke="#ceefbe" d="M7 4h1M4 7' +
          'h1" />'#13#10'<path stroke="#516750" d="M8 4h1" />'#13#10'<path stroke="#cec' +
          'ec7" d="M9 4h1" />'#13#10'<path stroke="#d2dbce" d="M4 5h1" />'#13#10'<path ' +
          'stroke="#aec69e" d="M5 5h1M4 6h1" />'#13#10'<path stroke="#cef7be" d="' +
          'M6 5h1M5 6h1" />'#13#10'<path stroke="#beefae" d="M7 5h1" />'#13#10'<path st' +
          'roke="#7fa66f" d="M8 5h1M9 7h1" />'#13#10'<path stroke="#516050" d="M9' +
          ' 5h1" />'#13#10'<path stroke="#ccccc5" d="M10 5h1" />'#13#10'<path stroke="#' +
          'd1dbcd" d="M3 6h1" />'#13#10'<path stroke="#bee7ae" d="M6 6h1M5 7h1" /' +
          '>'#13#10'<path stroke="#aedf8e" d="M7 6h1M6 7h1" />'#13#10'<path stroke="#9e' +
          'd68e" d="M8 6h1M7 7h1" />'#13#10'<path stroke="#6f9660" d="M9 6h1M8 9h' +
          '1" />'#13#10'<path stroke="#607760" d="M10 6h1" />'#13#10'<path stroke="#c5c' +
          '5c0" d="M11 6h1" />'#13#10'<path stroke="#d0d8cc" d="M2 7h1" />'#13#10'<path' +
          ' stroke="#9ebe9e" d="M3 7h1M2 8h1" />'#13#10'<path stroke="#8ebe6f" d=' +
          '"M8 7h1" />'#13#10'<path stroke="#607e50" d="M10 7h1" />'#13#10'<path stroke' +
          '="#334233" d="M11 7h1M10 8h2M9 9h1M7 12h1" />'#13#10'<path stroke="#c4' +
          'c4c0" d="M12 7h1" />'#13#10'<path stroke="#606f50" d="M3 8h1" />'#13#10'<pat' +
          'h stroke="#515850" d="M4 8h1" />'#13#10'<path stroke="#425842" d="M5 8' +
          'h1" />'#13#10'<path stroke="#bedf9e" d="M6 8h1" />'#13#10'<path stroke="#8ec' +
          '67e" d="M7 8h1" />'#13#10'<path stroke="#7fa660" d="M8 8h1" />'#13#10'<path ' +
          'stroke="#424942" d="M9 8h1M6 12h1" />'#13#10'<path stroke="#333a33" d=' +
          '"M12 8h1M9 10h1M8 12h1" />'#13#10'<path stroke="#8ea68e" d="M5 9h1" />' +
          #13#10'<path stroke="#aed69e" d="M6 9h1" />'#13#10'<path stroke="#7fb66f" d' +
          '="M7 9h1" />'#13#10'<path stroke="#8e9e7e" d="M5 10h1M5 11h1" />'#13#10'<pat' +
          'h stroke="#9ec68e" d="M6 10h1" />'#13#10'<path stroke="#6fae60" d="M7 ' +
          '10h1" />'#13#10'<path stroke="#608e50" d="M8 10h1" />'#13#10'<path stroke="#' +
          '8ebe8e" d="M6 11h1" />'#13#10'<path stroke="#608650" d="M7 11h1" />'#13#10'<' +
          'path stroke="#517e42" d="M8 11h1" />'#13#10'<path stroke="#252c25" d="' +
          'M9 11h1" />'#13#10'<path stroke="#7f967e" d="M5 12h1" />'#13#10'<path stroke' +
          '="#252525" d="M9 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'GreenDown'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#9ebe8e" d="M5 3h1" ' +
          '/>'#13#10'<path stroke="#9eb68e" d="M6 3h1M5 4h1M2 7h1" />'#13#10'<path stro' +
          'ke="#8ea68e" d="M7 3h1M5 5h1M3 7h1" />'#13#10'<path stroke="#8e9e7e" d' +
          '="M8 3h1M5 6h1M4 7h1" />'#13#10'<path stroke="#7f967e" d="M9 3h1M5 7h1' +
          'M3 8h1M4 9h1M5 10h1M6 11h1" />'#13#10'<path stroke="#ceefae" d="M6 4h1' +
          '" />'#13#10'<path stroke="#beefae" d="M7 4h1M6 5h1" />'#13#10'<path stroke="' +
          '#bee7ae" d="M8 4h1M6 6h1M5 8h1" />'#13#10'<path stroke="#252c25" d="M9' +
          ' 4h1" />'#13#10'<path stroke="#aedf8e" d="M7 5h1" />'#13#10'<path stroke="#7' +
          'fae6f" d="M8 5h1M6 10h1" />'#13#10'<path stroke="#333a33" d="M9 5h1" /' +
          '>'#13#10'<path stroke="#9ed68e" d="M7 6h1" />'#13#10'<path stroke="#7fa66f" ' +
          'd="M8 6h1" />'#13#10'<path stroke="#334233" d="M9 6h1" />'#13#10'<path strok' +
          'e="#bee79e" d="M6 7h1" />'#13#10'<path stroke="#9ece7e" d="M7 7h1" />'#13 +
          #10'<path stroke="#6f9e60" d="M8 7h1" />'#13#10'<path stroke="#424942" d=' +
          '"M9 7h1" />'#13#10'<path stroke="#7f8e7e" d="M10 7h3" />'#13#10'<path stroke' +
          '="#d0d9cc" d="M2 8h1" />'#13#10'<path stroke="#bedf9e" d="M4 8h1" />'#13#10 +
          '<path stroke="#aedf9e" d="M6 8h1" />'#13#10'<path stroke="#8ebe6f" d="' +
          'M7 8h1M6 9h1" />'#13#10'<path stroke="#6f9660" d="M8 8h1" />'#13#10'<path st' +
          'roke="#608e50" d="M9 8h1M7 11h1" />'#13#10'<path stroke="#517742" d="M' +
          '10 8h1M9 9h1M8 10h1" />'#13#10'<path stroke="#252525" d="M11 8h1M10 9h' +
          '1M9 10h1M8 11h1" />'#13#10'<path stroke="#c4c4c0" d="M12 8h1" />'#13#10'<pat' +
          'h stroke="#cacfc0" d="M3 9h1" />'#13#10'<path stroke="#8ec67e" d="M5 9' +
          'h1" />'#13#10'<path stroke="#7fb66f" d="M7 9h1" />'#13#10'<path stroke="#6fa' +
          '660" d="M8 9h1M7 10h1" />'#13#10'<path stroke="#a7aaa2" d="M11 9h1" />' +
          #13#10'<path stroke="#c9cebf" d="M4 10h1" />'#13#10'<path stroke="#aaaea6" ' +
          'd="M10 10h1" />'#13#10'<path stroke="#c8cdbe" d="M5 11h1" />'#13#10'<path st' +
          'roke="#a9ada4" d="M9 11h1" />'#13#10'<path stroke="#c7cbbc" d="M6 12h1' +
          '" />'#13#10'<path stroke="#607760" d="M7 12h1" />'#13#10'<path stroke="#a8ab' +
          'a3" d="M8 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'IgnoreCase'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#292929" d="M11 3h1M' +
          '12 4h1M3 5h2M10 6h1M13 7h1M2 8h1M9 8h1M9 9h1M14 9h1M3 11h1" />'#13#10 +
          '<path stroke="#515151" d="M12 3h1M2 5h1M10 5h1M1 10h1M8 10h1M2 1' +
          '1h1M4 11h1M8 11h1" />'#13#10'<path stroke="#a1a1a1" d="M10 4h1M11 5h1M' +
          '15 10h1M5 11h1" />'#13#10'<path stroke="#3e3e3e" d="M11 4h1M13 6h1M6 7' +
          'h1M6 8h1M13 8h1M1 9h1M6 9h1M5 10h2M14 10h1" />'#13#10'<path stroke="#e' +
          '5e5e5" d="M13 4h1M9 6h1M2 7h1M4 10h1" />'#13#10'<path stroke="#626262"' +
          ' d="M5 5h1M12 5h1M5 6h1M5 7h1M10 7h1M10 8h1M14 8h1M6 11h1" />'#13#10'<' +
          'path stroke="#929292" d="M13 5h1M5 9h1M14 11h1" />'#13#10'<path stroke' +
          '="#838383" d="M6 6h1M4 7h1M3 8h2M11 8h2M10 9h3" />'#13#10'<path stroke' +
          '="#bdbdbd" d="M12 6h1M3 7h1M14 7h1M8 9h1" />'#13#10'<path stroke="#737' +
          '373" d="M9 7h1M5 8h1M13 9h1M2 10h1M9 10h1M15 11h1" />'#13#10'<path str' +
          'oke="#afafaf" d="M1 8h1M2 9h1" />'#13#10'<path stroke="#d7d7d7" d="M9 ' +
          '11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'IgnoreCase'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#d8d8d8" d="M11 3h1M' +
          '12 4h1M3 5h2M10 6h1M13 7h1M2 8h1M9 8h1M9 9h1M14 9h1M3 11h1" />'#13#10 +
          '<path stroke="#acacac" d="M12 3h1M2 5h1M10 5h1M1 10h1M8 10h1M2 1' +
          '1h1M4 11h1M8 11h1" />'#13#10'<path stroke="#5c5c5c" d="M10 4h1M11 5h1M' +
          '15 10h1M5 11h1" />'#13#10'<path stroke="#c1c1c1" d="M11 4h1M13 6h1M6 7' +
          'h1M6 8h1M13 8h1M1 9h1M6 9h1M5 10h2M14 10h1" />'#13#10'<path stroke="#1' +
          'f1f1f" d="M13 4h1M9 6h1M2 7h1M4 10h1" />'#13#10'<path stroke="#9a9a9a"' +
          ' d="M5 5h1M12 5h1M5 6h1M5 7h1M10 7h1M10 8h1M14 8h1M6 11h1" />'#13#10'<' +
          'path stroke="#6a6a6a" d="M13 5h1M5 9h1M14 11h1" />'#13#10'<path stroke' +
          '="#797979" d="M6 6h1M4 7h1M3 8h2M11 8h2M10 9h3" />'#13#10'<path stroke' +
          '="#424242" d="M12 6h1M3 7h1M14 7h1M1 8h1M2 9h1M8 9h1" />'#13#10'<path ' +
          'stroke="#898989" d="M9 7h1M5 8h1M13 9h1M2 10h1M9 10h1M15 11h1" /' +
          '>'#13#10'<path stroke="#2a2a2a" d="M9 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'IgnoreBlanks'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#cacaca" d="M4 3h1M4' +
          ' 4h1M4 5h1M4 6h1M4 7h1M4 8h1M4 9h1M4 10h1M6 10h2" />'#13#10'<path stro' +
          'ke="#292929" d="M5 3h4M9 4h1M5 6h1M9 6h1M5 7h1M9 7h1M10 9h1" />'#13 +
          #10'<path stroke="#737373" d="M9 3h1M8 6h1M9 8h1M10 10h1" />'#13#10'<path' +
          ' stroke="#3e3e3e" d="M5 4h1M5 5h1M9 5h1M5 8h1M5 9h1M5 10h1M9 10h' +
          '1M5 11h4" />'#13#10'<path stroke="#e5e5e5" d="M8 4h1M10 6h1" />'#13#10'<path' +
          ' stroke="#929292" d="M10 4h1M9 11h1" />'#13#10'<path stroke="#838383" ' +
          'd="M10 5h1M6 6h2M6 7h2" />'#13#10'<path stroke="#515151" d="M8 7h1M10 ' +
          '8h1" />'#13#10'<path stroke="#d7d7d7" d="M10 7h1M4 11h1" />'#13#10'<path str' +
          'oke="#a1a1a1" d="M9 9h1" />'#13#10'<path stroke="#2e2e2e" d="M2 10h1" ' +
          '/>'#13#10'<path stroke="#bdbdbd" d="M8 10h1" />'#13#10'<path stroke="#000000' +
          '" d="M13 10h1M13 11h1M2 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="' +
          '#2b2b2b" d="M2 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'IgnoreBlanks'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#363636" d="M4 3h1M4' +
          ' 4h1M4 5h1M4 6h1M4 7h1M4 8h1M4 9h1M4 10h1M6 10h2" />'#13#10'<path stro' +
          'ke="#d8d8d8" d="M5 3h4M9 4h1M5 6h1M9 6h1M5 7h1M9 7h1M10 9h1" />'#13 +
          #10'<path stroke="#898989" d="M9 3h1M8 6h1M9 8h1M10 10h1" />'#13#10'<path' +
          ' stroke="#c1c1c1" d="M5 4h1M5 5h1M9 5h1M5 8h1M5 9h1M5 10h1M9 10h' +
          '1M5 11h4" />'#13#10'<path stroke="#1f1f1f" d="M8 4h1M10 6h1" />'#13#10'<path' +
          ' stroke="#6a6a6a" d="M10 4h1M9 11h1" />'#13#10'<path stroke="#797979" ' +
          'd="M10 5h1M6 6h2M6 7h2" />'#13#10'<path stroke="#acacac" d="M8 7h1M10 ' +
          '8h1" />'#13#10'<path stroke="#2a2a2a" d="M10 7h1M4 11h1" />'#13#10'<path str' +
          'oke="#5c5c5c" d="M9 9h1" />'#13#10'<path stroke="#ffffff" d="M2 10h1M1' +
          '3 10h1M2 11h1M13 11h1M2 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="' +
          '#424242" d="M8 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Paragraph'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#001be1" d="M5 4h6M4' +
          ' 5h1M7 5h1M9 5h1M4 6h1M7 6h1M9 6h1M5 7h3M9 7h1M7 8h1M9 8h1M7 9h1' +
          'M9 9h1M7 10h1M9 10h1M6 11h2M9 11h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Paragraph'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#11ffff" d="M5 4h6M4' +
          ' 5h1M7 5h1M9 5h1M4 6h1M7 6h1M9 6h1M5 7h3M9 7h1M7 8h1M9 8h1M7 9h1' +
          'M9 9h1M7 10h1M9 10h1M6 11h2M9 11h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ZoomOut'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#191919">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400ZM280-540v' +
          '-80h200v80H280Z"/>'#13#10'</svg>'#13#10
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
        IconName = 'ZoomOut'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#e6e6e6">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400ZM280-540v' +
          '-80h200v80H280Z"/>'#13#10'</svg>'#13#10
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
      end>
    Left = 248
    Top = 226
  end
end
