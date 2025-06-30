inherited AboutBox: TAboutBox
  Left = 365
  Top = 155
  BorderIcons = [biSystemMenu]
  Caption = 'About GuiPy'
  ClientHeight = 427
  ClientWidth = 530
  KeyPreview = True
  StyleElements = [seFont, seBorder]
  OnKeyPress = FormKeyPress
  ExplicitWidth = 546
  ExplicitHeight = 466
  TextHeight = 15
  object SpTBXTabControl: TSpTBXTabControl
    Left = 0
    Top = 0
    Width = 530
    Height = 427
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    ActiveTabIndex = 0
    TabBackgroundBorders = True
    TabPosition = ttpBottom
    HiddenItems = <>
    object tbAbout: TSpTBXTabItem
      Caption = 'About'
      Checked = True
    end
    object tbCredits: TSpTBXTabItem
      Caption = 'Credits'
    end
    object tbLinks: TSpTBXTabItem
      Caption = 'Links'
    end
    object SpTBXTabSheet2: TSpTBXTabSheet
      Left = 0
      Top = 0
      Width = 530
      Height = 402
      Caption = 'Credits'
      ImageIndex = -1
      TabItem = 'tbCredits'
      object ScrollBox: TSpTBXPageScroller
        Left = 2
        Top = 4
        Width = 524
        Height = 398
        Align = alClient
        ButtonSize = 15
        Color = clBtnFace
        Ctl3D = False
        ParentColor = False
        ParentCtl3D = False
        TabOrder = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 524
          Height = 89
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          object reCredits: TRichEdit
            Left = 0
            Top = 0
            Width = 524
            Height = 89
            Align = alTop
            BorderStyle = bsNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnText
            Font.Height = -12
            Font.Name = 'MS Shell Dlg 2'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnResizeRequest = reCreditsResizeRequest
          end
        end
      end
    end
    object SpTBXTabSheet3: TSpTBXTabSheet
      Left = 0
      Top = 0
      Width = 530
      Height = 402
      Caption = 'Links'
      ImageIndex = -1
      TabItem = 'tbLinks'
      object reLinks: TRichEdit
        Left = 2
        Top = 4
        Width = 524
        Height = 398
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object SpTBXTabSheet1: TSpTBXTabSheet
      Left = 0
      Top = 0
      Width = 530
      Height = 402
      Caption = 'About'
      ImageIndex = -1
      TabItem = 'tbAbout'
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 22
        Top = 24
        Width = 484
        Height = 358
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBtnText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentBackground = False
        ParentDoubleBuffered = False
        ParentFont = False
        ShowCaption = False
        TabOrder = 0
        OnClick = Panel1Click
        DesignSize = (
          484
          358)
        object Copyright: TLabel
          Left = 199
          Top = 130
          Width = 69
          Height = 19
          Caption = 'Copyright'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 16746564
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
          StyleElements = [seClient, seBorder]
          OnClick = Panel1Click
        end
        object Version: TLabel
          Left = 199
          Top = 67
          Width = 131
          Height = 24
          Caption = 'Version 1.0.0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 16746564
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          StyleElements = [seClient, seBorder]
          OnClick = Panel1Click
        end
        object ProductName: TLabel
          Left = 199
          Top = 25
          Width = 92
          Height = 36
          Caption = 'GuiPy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 16746564
          Font.Height = -32
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          Transparent = True
          StyleElements = [seClient, seBorder]
          OnClick = Panel1Click
        end
        object Comments: TLabel
          AlignWithMargins = True
          Left = 17
          Top = 200
          Width = 433
          Height = 151
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Anchors = [akTop, akRight, akBottom]
          AutoSize = False
          Caption = 
            'A free and open source Python IDE created with the ambition to s' +
            'upport teaching and learning informatics with various modeling t' +
            'echniques.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -12
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          OnClick = Panel1Click
          ExplicitLeft = 25
          ExplicitHeight = 153
        end
        object SVGIconImage1: TSVGIconImage
          Left = 17
          Top = 0
          Width = 144
          Height = 214
          AutoSize = False
          SVGText = 
            '<?xml version="1.0" encoding="UTF-8"?>'#13#10'<svg xmlns:inkscape="htt' +
            'p://www.inkscape.org/namespaces/inkscape" xmlns:sodipodi="http:/' +
            '/sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns:xlink="http:' +
            '//www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" xmln' +
            's:svg="http://www.w3.org/2000/svg" width="148mm" height="210mm" ' +
            'viewBox="0 0 148 210" version="1.1" id="svg974" inkscape:version' +
            '="1.1 (c68e22c387, 2021-05-23)" sodipodi:docname="Guipy11.svg">'#13 +
            #10'  <defs id="defs971">'#13#10'    <linearGradient xlink:href="#linearG' +
            'radient2179" id="linearGradient2181" x1="780" y1="1100" x2="600"' +
            ' y2="900" gradientUnits="userSpaceOnUse"></linearGradient>'#13#10'    ' +
            '<linearGradient id="linearGradient2179">'#13#10'      <stop style="sto' +
            'p-color:#00ff00;stop-opacity:1;" offset="0" id="stop2175"></stop' +
            '>'#13#10'      <stop style="stop-color:#0082ff;stop-opacity:1" offset=' +
            '"1" id="stop2177"></stop>'#13#10'    </linearGradient>'#13#10'  </defs>'#13#10'  <' +
            'g inkscape:label="Ebene 1" inkscape:groupmode="layer" id="layer1' +
            '">'#13#10'    <g id="g1258" transform="matrix(1.6607143,0,0,1.6607143,' +
            '1.6509052,-29.880262)">'#13#10'      <g id="g1900-6" transform="transl' +
            'ate(-139.85317,-187.92379)">'#13#10'        <path id="rect1239-5" styl' +
            'e="fill:url(#linearGradient2181);fill-opacity:1" d="M 560,900.00' +
            '001 V 940 1100 a 40.000004,40.000004 44.999994 0 0 40.00001,40 h' +
            ' 180 A 39.99999,39.99999 135 0 0 820,1100 V 1060 960 H 740 720.0' +
            '0001 A 60.000009,60.000009 135 0 0 660,1020 v 20 h 80 v 20 H 640' +
            ' V 940 H 820 V 899.99999 A 39.99999,39.99999 45 0 0 780.00001,86' +
            '0 h -180 A 40.000011,40.000011 135 0 0 560,900.00001 Z" transfor' +
            'm="scale(0.26458333)" inkscape:path-effect="#path-effect1233" in' +
            'kscape:original-d="m 560,860 v 80 160 40 h 260 v -80 -100 h -80 ' +
            '-80 v 80 h 80 v 20 H 640 V 940 h 180 v -80 z"></path>'#13#10'      </g' +
            '>'#13#10'      <circle style="fill:#d40000;fill-opacity:1" id="path867' +
            '2" cx="46.407757" cy="76.297531" r="4.3299999"></circle>'#13#10'    </' +
            'g>'#13#10'  </g>'#13#10'</svg>'
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
      end
    end
  end
end
