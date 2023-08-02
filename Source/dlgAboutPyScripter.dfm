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
    ExplicitWidth = 534
    ExplicitHeight = 428
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
      Width = 534
      Height = 403
      Caption = 'Credits'
      ImageIndex = -1
      TabItem = 'tbCredits'
      object ScrollBox: TSpTBXPageScroller
        Left = 2
        Top = 4
        Width = 528
        Height = 399
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
          Width = 528
          Height = 89
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          object reCredits: TRichEdit
            Left = 0
            Top = 0
            Width = 528
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
      ExplicitWidth = 534
      ExplicitHeight = 403
      TabItem = 'tbLinks'
      object reLinks: TRichEdit
        Left = 2
        Top = 4
        Width = 528
        Height = 399
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
      ExplicitWidth = 534
      ExplicitHeight = 403
      TabItem = 'tbAbout'
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 22
        Top = 24
        Width = 488
        Height = 359
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
          Left = 21
          Top = 200
          Width = 433
          Height = 152
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
          Left = 9
          Top = 0
          Width = 148
          Height = 215
          AutoSize = False
          SVGText = 
            '<svg'#13#10'   viewBox="0 0 148 210"'#13#10'   id="svg974"'#13#10'   >'#13#10'<svg'#10'   wi' +
            'dth="148mm"'#10'   height="210mm"'#10'   viewBox="0 0 148 210"'#10'   versio' +
            'n="1.1"'#10'   id="svg974"'#10'   inkscape:version="1.1 (c68e22c387, 202' +
            '1-05-23)"'#10'   sodipodi:docname="Guipy11.svg"'#10'   xmlns:inkscape="h' +
            'ttp://www.inkscape.org/namespaces/inkscape"'#10'   xmlns:sodipodi="h' +
            'ttp://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"'#10'   xmlns:xlin' +
            'k="http://www.w3.org/1999/xlink"'#10'   xmlns="http://www.w3.org/200' +
            '0/svg"'#10'   xmlns:svg="http://www.w3.org/2000/svg">'#10'  <sodipodi:na' +
            'medview'#10'     id="namedview976"'#10'     pagecolor="#ffffff"'#10'     bor' +
            'dercolor="#666666"'#10'     borderopacity="1.0"'#10'     inkscape:pagesh' +
            'adow="2"'#10'     inkscape:pageopacity="0.0"'#10'     inkscape:pagecheck' +
            'erboard="0"'#10'     inkscape:document-units="mm"'#10'     showgrid="tru' +
            'e"'#10'     inkscape:zoom="1"'#10'     inkscape:cx="362.5"'#10'     inkscape' +
            ':cy="382.5"'#10'     inkscape:window-width="1600"'#10'     inkscape:wind' +
            'ow-height="1137"'#10'     inkscape:window-x="-8"'#10'     inkscape:windo' +
            'w-y="-8"'#10'     inkscape:window-maximized="1"'#10'     inkscape:curren' +
            't-layer="layer1"'#10'     showguides="true"'#10'     inkscape:guide-bbox' +
            '="true"'#10'     showborder="true"'#10'     gridtolerance="10" />'#10'  <def' +
            's'#10'     id="defs971">'#10'    <inkscape:path-effect'#10'       effect="fi' +
            'llet_chamfer"'#10'       id="path-effect1233"'#10'       is_visible="tru' +
            'e"'#10'       lpeversion="1"'#10'       satellites_param="F,0,0,1,0,40.0' +
            '00011,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,40.000' +
            '008,0,1 @ F,0,0,1,0,39.99999,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0' +
            ',0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,60.000009,0,1 @ F,0,0,1,0,0,0' +
            ',1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0' +
            ',1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,39.99999,0,1"'#10'       un' +
            'it="px"'#10'       method="auto"'#10'       mode="F"'#10'       radius="0"'#10' ' +
            '      chamfer_steps="1"'#10'       flexible="false"'#10'       use_knot_' +
            'distance="true"'#10'       apply_no_radius="true"'#10'       apply_with_' +
            'radius="true"'#10'       only_selected="false"'#10'       hide_knots="fa' +
            'lse" />'#10'    <inkscape:path-effect'#10'       effect="fillet_chamfer"' +
            #10'       id="path-effect6450"'#10'       is_visible="true"'#10'       lpe' +
            'version="1"'#10'       satellites_param="F,0,0,1,0,40.000011,0,1 @ F' +
            ',0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,40.000008,0,1 @ F,0' +
            ',0,1,0,39.99999,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,' +
            '1,0,0,0,1 @ F,0,0,1,0,60.000009,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,' +
            '0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ F,0,0,1,0,0,0,1 @ ' +
            'F,0,0,1,0,39.99999,0,1 @ F,0,0,1,0,0,0,1"'#10'       unit="px"'#10'     ' +
            '  method="auto"'#10'       mode="F"'#10'       radius="0"'#10'       chamfer' +
            '_steps="1"'#10'       flexible="false"'#10'       use_knot_distance="tru' +
            'e"'#10'       apply_no_radius="true"'#10'       apply_with_radius="true"' +
            #10'       only_selected="false"'#10'       hide_knots="false" />'#10'    <' +
            'linearGradient'#10'       xlink:href="#linearGradient2179"'#10'       id' +
            '="linearGradient2181"'#10'       x1="780"'#10'       y1="1100"'#10'       x2' +
            '="600"'#10'       y2="900"'#10'       gradientUnits="userSpaceOnUse" />'#10 +
            '    <linearGradient'#10'       id="linearGradient2179">'#10'      <stop'#10 +
            '         style="stop-color:#00ff00;stop-opacity:1;"'#10'         off' +
            'set="0"'#10'         id="stop2175" />'#10'      <stop'#10'         style="st' +
            'op-color:#0082ff;stop-opacity:1"'#10'         offset="1"'#10'         id' +
            '="stop2177" />'#10'    </linearGradient>'#10'  </defs>'#10'  <g'#10'     inkscap' +
            'e:label="Ebene 1"'#10'     inkscape:groupmode="layer"'#10'     id="layer' +
            '1">'#10'    <g'#10'       id="g1258"'#10'       transform="matrix(1.6607143,' +
            '0,0,1.6607143,1.6509052,-29.880262)">'#10'      <g'#10'         id="g190' +
            '0-6"'#10'         transform="translate(-139.85317,-187.92379)">'#10'    ' +
            '    <path'#10'           id="rect1239-5"'#10'           style="fill:url(' +
            '#linearGradient2181);fill-opacity:1"'#10'           d="M 560,900.000' +
            '01 V 940 1100 a 40.000004,40.000004 44.999994 0 0 40.00001,40 h ' +
            '180 A 39.99999,39.99999 135 0 0 820,1100 V 1060 960 H 740 720.00' +
            '001 A 60.000009,60.000009 135 0 0 660,1020 v 20 h 80 v 20 H 640 ' +
            'V 940 H 820 V 899.99999 A 39.99999,39.99999 45 0 0 780.00001,860' +
            ' h -180 A 40.000011,40.000011 135 0 0 560,900.00001 Z"'#10'         ' +
            '  transform="scale(0.26458333)"'#10'           inkscape:path-effect=' +
            '"#path-effect1233"'#10'           inkscape:original-d="m 560,860 v 8' +
            '0 160 40 h 260 v -80 -100 h -80 -80 v 80 h 80 v 20 H 640 V 940 h' +
            ' 180 v -80 z" />'#10'      </g>'#10'      <circle'#10'         style="fill:#' +
            'd40000;fill-opacity:1"'#10'         id="path8672"'#10'         cx="46.40' +
            '7757"'#10'         cy="76.297531"'#10'         r="4.3299999" />'#10'    </g>' +
            #10'  </g>'#10'</svg>'#10
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
      end
    end
  end
end
