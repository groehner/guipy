object FUMLForm: TFUMLForm
  Left = 394
  Top = 229
  Caption = 'UML'
  ClientHeight = 558
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PUML: TPanel
    Left = 0
    Top = 0
    Width = 619
    Height = 558
    Align = alClient
    Caption = 'PUML'
    TabOrder = 0
    ExplicitWidth = 615
    ExplicitHeight = 557
    object PDiagramPanel: TPanel
      Left = 1
      Top = 23
      Width = 617
      Height = 534
      Align = alClient
      BevelEdges = [beLeft, beTop]
      BevelOuter = bvNone
      Color = clWhite
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnResize = PDiagramPanelResize
      ExplicitWidth = 613
      ExplicitHeight = 533
      object TVFileStructure: TTreeView
        Left = 472
        Top = 6
        Width = 121
        Height = 18
        Indent = 19
        TabOrder = 0
        Visible = False
      end
    end
    object UMLToolbar: TToolBar
      Left = 1
      Top = 1
      Width = 617
      Height = 22
      AutoSize = True
      ButtonWidth = 24
      Color = clBtnFace
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = vilToolbarDark
      ParentColor = False
      TabOrder = 1
      ExplicitWidth = 613
      object TBClose: TToolButton
        Left = 0
        Top = 0
        Hint = 'Close'
        ImageIndex = 0
        ImageName = 'Close'
        OnClick = SBCloseClick
      end
      object TBClassDefinition: TToolButton
        Left = 24
        Top = 0
        Hint = 'New class'
        ImageIndex = 1
        ImageName = 'New'
        OnClick = TBClassDefinitionClick
      end
      object TBClassOpen: TToolButton
        Left = 48
        Top = 0
        Hint = 'Open class'
        ImageIndex = 2
        ImageName = 'Open'
        OnClick = TBClassOpenClick
      end
      object TBShowConnections: TToolButton
        Left = 72
        Top = 0
        Hint = 'Connections: none, classes and objects, all'
        ImageIndex = 3
        ImageName = 'Connection'
        OnClick = TBShowConnectionsClick
      end
      object TBObjectDiagram: TToolButton
        Left = 96
        Top = 0
        Hint = 'Class diagram on/off'
        ImageIndex = 4
        ImageName = 'ClassesOnOff'
        OnClick = TBObjectDiagramClick
      end
      object TBView: TToolButton
        Left = 120
        Top = 0
        Hint = 'View'
        ImageIndex = 5
        ImageName = 'View'
        OnClick = TBViewClick
      end
      object TBZoomOut: TToolButton
        Left = 144
        Top = 0
        Hint = 'Zoom out'
        ImageIndex = 6
        ImageName = 'ZoomOut'
        OnClick = TBZoomOutClick
      end
      object TBZoomIn: TToolButton
        Left = 168
        Top = 0
        Hint = 'Zoom in'
        ImageIndex = 7
        ImageName = 'ZoomIn'
        OnClick = TBZoomInClick
      end
      object TBComment: TToolButton
        Left = 192
        Top = 0
        Hint = 'Comment'
        ImageIndex = 8
        ImageName = 'Comment'
        OnClick = TBCommentClick
      end
      object TBNewLayout: TToolButton
        Left = 216
        Top = 0
        Hint = 'New layout'
        ImageIndex = 9
        ImageName = 'NewLayout'
        OnClick = TBNewLayoutClick
      end
      object TBRefresh: TToolButton
        Left = 240
        Top = 0
        Hint = 'Refresh'
        ImageIndex = 10
        ImageName = 'Refresh'
        OnClick = TBRefreshClick
      end
      object TBRecognizeAssociations: TToolButton
        Left = 264
        Top = 0
        Hint = 'Recognize associations'
        Caption = 'Recognize associations'
        ImageIndex = 13
        OnClick = TBRecognizeAssociationsClick
      end
      object TBInteractive: TToolButton
        Left = 288
        Top = 0
        Hint = 'Show/hide interactive'
        ImageIndex = 11
        ImageName = 'Interactive'
        OnClick = TBInteractiveClick
      end
      object TBReInitialize: TToolButton
        Left = 312
        Top = 0
        Hint = 'Reinitialize Python engine'
        ImageIndex = 12
        ImageName = 'ResetPython'
        OnClick = TBReInitializeClick
      end
    end
  end
  object EmptyPopupMenu: TPopupMenu
    Left = 57
    Top = 50
  end
  object vilToolbarLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Light\Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Light\New'
        Name = 'New'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Light\Open'
        Name = 'Open'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Light\Connection'
        Name = 'Connection'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Light\ClassesOnOff'
        Name = 'ClassesOnOff'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Light\View'
        Name = 'View'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Light\ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Light\ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Light\Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Light\NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Light\Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Light\Interactive'
        Name = 'Interactive'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Light\ResetPython'
        Name = 'ResetPython'
      end
      item
        CollectionIndex = 28
      end>
    ImageCollection = icUML
    Left = 49
    Top = 129
  end
  object vilToolbarDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 14
        CollectionName = 'Dark\Close'
        Name = 'Close'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Dark\New'
        Name = 'New'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Dark\Open'
        Name = 'Open'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Dark\Connection'
        Name = 'Connection'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Dark\ClassesOnOff'
        Name = 'ClassesOnOff'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Dark\View'
        Name = 'View'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Dark\ZoomOut'
        Name = 'ZoomOut'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Dark\ZoomIn'
        Name = 'ZoomIn'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Dark\Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Dark\NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Dark\Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Dark\Interactive'
        Name = 'Interactive'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Dark\ResetPython'
        Name = 'ResetPython'
      end
      item
        CollectionIndex = 29
      end>
    ImageCollection = icUML
    Left = 169
    Top = 130
  end
  object icUML: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Light\Close'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\New'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M4 0h1M4' +
          ' 2h1M0 4h1M4 4h1M7 4h8M3 5h1M5 5h10M2 6h1M7 6h8M4 7h1M0 8h1M2 8h' +
          '1M5 8h1M7 8h8M2 9h13M2 10h13M2 12h13M2 13h13M2 14h13" />'#13#10'<path ' +
          'stroke="#ffff36" d="M0 1h1M4 1h1M1 2h1M7 2h1M2 3h1M4 3h1M6 3h1M3' +
          ' 4h1M4 6h1M6 6h1M1 7h2M5 7h1M7 7h1M4 8h1M6 8h1" />'#13#10'<path stroke' +
          '="#979797" d="M3 1h1M7 1h1M0 2h1M3 2h1M6 2h1M1 3h1M3 3h1M5 3h1M8' +
          ' 3h1M2 4h1M5 4h2M0 5h3M4 5h1M1 6h1M3 6h1M5 6h1M0 7h1M3 7h1M6 7h1' +
          'M3 8h1" />'#13#10'<path stroke="#000000" d="M7 3h1M9 3h7M15 4h1M15 5h1' +
          'M15 6h1M8 7h8M15 8h1M15 9h1M1 10h1M15 10h1M1 11h15M1 12h1M15 12h' +
          '1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<path stroke="#ffff' +
          '65" d="M1 4h1" />'#13#10'<path stroke="#363665" d="M1 8h1" />'#13#10'<path s' +
          'troke="#363636" d="M1 9h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\Open'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a74d50" d="M5 0h1" ' +
          '/>'#13#10'<path stroke="#a44e4e" d="M6 0h3M9 1h1M10 2h1M9 3h2" />'#13#10'<pa' +
          'th stroke="#a45050" d="M4 1h3M10 4h1" />'#13#10'<path stroke="#a44f4f"' +
          ' d="M7 1h1" />'#13#10'<path stroke="#a45353" d="M8 1h1" />'#13#10'<path stro' +
          'ke="#ad4c55" d="M3 2h1" />'#13#10'<path stroke="#ac4c55" d="M4 2h1" />' +
          #13#10'<path stroke="#a55759" d="M5 2h1" />'#13#10'<path stroke="#a94d52" d' +
          '="M9 2h1" />'#13#10'<path stroke="#a44e4f" d="M12 2h1" />'#13#10'<path strok' +
          'e="#000000" d="M1 3h8M14 3h2M1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 ' +
          '6h1M1 7h15M1 8h1M15 8h1M1 9h1M15 9h1M1 10h1M15 10h1M1 11h15M1 12' +
          'h1M15 12h1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<path stro' +
          'ke="#a45252" d="M11 3h1" />'#13#10'<path stroke="#a34f4f" d="M12 3h1" ' +
          '/>'#13#10'<path stroke="#0d0808" d="M13 3h1" />'#13#10'<path stroke="#ffffff' +
          '" d="M2 4h7M13 4h2M2 5h7M13 5h2M2 6h9M12 6h3M2 8h13M2 9h13M2 10h' +
          '13M2 12h13M2 13h13M2 14h13" />'#13#10'<path stroke="#d0d0d0" d="M9 4h1' +
          '" />'#13#10'<path stroke="#a54f4f" d="M11 4h1" />'#13#10'<path stroke="#aa58' +
          '58" d="M12 4h1" />'#13#10'<path stroke="#a95959" d="M9 5h1" />'#13#10'<path ' +
          'stroke="#a55050" d="M10 5h1" />'#13#10'<path stroke="#a95656" d="M11 5' +
          'h1" />'#13#10'<path stroke="#e8d5d5" d="M12 5h1" />'#13#10'<path stroke="#ef' +
          'e2e2" d="M11 6h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\Insert'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 3h15M' +
          '1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 6h1M1 7h15" />'#13#10'<path stroke=' +
          '"#ffffff" d="M2 4h13M2 5h13M2 6h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\Connection'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <path stroke="#000000" d="M8 2L1' +
          '4 7.2 M2 7h12 M8 12 L14 6.8"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\ClassesOnOff'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <path stroke="#000000" d="M2 0h1' +
          '2M2 1h1M13 1h1M1 2h1M14 2h1M1 3h1M14 3h1M1 4h1M14 4h1M1 5h14M1 6' +
          'h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10h1M14 10h1M' +
          '1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M14 14h1M1 15' +
          'h14"/>'#13#10'  <path stroke="#360036" d="M1 1h1M14 1h1"/>'#13#10'  <path st' +
          'roke="#f1ff12" d="M3 1h10M2 2h12M2 3h12M2 4h12"/>'#13#10'  <path strok' +
          'e="#ffffff" d="M2 6h12M2 7h12M2 8h12M2 9h12M2 10h12M2 11h12M2 12' +
          'h12M2 13h12M2 14h12"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\View'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <path stroke="#000000" d="M1 1h5' +
          'M10 1h5M1 2h1M5 2h1M10 2h1M14 2h1M1 3h5M10 3h5M1 4h1M5 4h6M14 4h' +
          '1M1 5h1M5 5h1M10 5h1M14 5h1M1 6h1M5 6h1M10 6h1M14 6h1M1 7h5M10 7' +
          'h5M3 8h1M3 9h1M6 9h5M3 10h1M6 10h1M10 10h1M3 11h4M10 11h1M6 12h1' +
          'M10 12h1M6 13h1M10 13h1M6 14h5"/>'#13#10'  <path stroke="#ffffff" d="M' +
          '2 2h3M11 2h3"/>'#13#10'  <path stroke="#dcbb92" d="M2 4h1M4 6h1M7 11h1' +
          'M9 13h1"/>'#13#10'  <path stroke="#f6d4ab" d="M3 4h1M3 6h1M8 11h1M8 13' +
          'h1"/>'#13#10'  <path stroke="#feddab" d="M4 4h1M2 6h1"/>'#13#10'  <path stro' +
          'ke="#bb9a72" d="M11 4h1"/>'#13#10'  <path stroke="#d4b38a" d="M12 4h1M' +
          '11 5h1"/>'#13#10'  <path stroke="#eecca3" d="M13 4h1M2 5h1M4 5h1M12 5h' +
          '1M11 6h1M13 6h1M7 12h1M9 12h1"/>'#13#10'  <path stroke="#fee6b3" d="M3' +
          ' 5h1M13 5h1M12 6h1M8 12h1"/>'#13#10'  <path stroke="#ccb382" d="M7 10h' +
          '1"/>'#13#10'  <path stroke="#e6c49a" d="M8 10h1"/>'#13#10'  <path stroke="#f' +
          'eddb3" d="M9 10h1M9 11h1M7 13h1"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\ZoomOut'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#191919">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400ZM280-540v' +
          '-80h200v80H280Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\ZoomIn'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#191919">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Zm-40-60v-' +
          '80h-80v-80h80v-80h80v80h80v80h-80v80h-80Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Light\Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<polygon stroke="black" fill="#a4c' +
          '8ef" points="1.5,0 10,0  15,5 15,15 1.5,15" />'#13#10'<path stroke="bl' +
          'ack" fill="none" d="M10 0 L 10, 5 15, 5" />'#13#10'</svg>'
      end
      item
        IconName = 'Light\NewLayout'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 1h6M1' +
          ' 2h1M6 2h1M10 2h5M1 3h1M6 3h1M10 3h1M14 3h1M1 4h1M6 4h1M10 4h1M1' +
          '4 4h1M1 5h1M6 5h1M10 5h1M14 5h1M1 6h1M6 6h1M10 6h1M14 6h1M1 7h1M' +
          '6 7h1M10 7h5M1 8h6M1 11h12M1 12h1M12 12h1M1 13h1M12 13h1M1 14h12' +
          '" />'#13#10'<path stroke="#ffffff" d="M2 2h4M2 3h4M11 3h3M2 4h4M11 4h3' +
          'M2 5h4M11 5h3M2 6h4M11 6h3M2 7h4M2 12h10M2 13h10" />'#13#10'<path stro' +
          'ke="#725252" d="M7 3h1M6 10h1" />'#13#10'<path stroke="#eeeeee" d="M8 ' +
          '3h1M7 4h1M6 9h1M5 10h1M7 10h2" />'#13#10'<path stroke="#727272" d="M8 ' +
          '4h1" />'#13#10'<path stroke="#ababab" d="M9 4h1" />'#13#10'<path stroke="#9a' +
          '9a9a" d="M9 5h1M9 9h1" />'#13#10'<path stroke="#525252" d="M10 8h1" />' +
          #13#10'<path stroke="#dddddd" d="M4 9h1" />'#13#10'<path stroke="#626262" d' +
          '="M5 9h1" />'#13#10'<path stroke="#cccccc" d="M10 9h1" />'#13#10'<path strok' +
          'e="#7a7a7a" d="M9 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Light\Refresh'
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
        IconName = 'Light\Interactive'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16" >'#10'<path stroke="#000000" d="M5 1h10M' +
          '5 2h1M14 2h1M5 3h1M14 3h1M5 4h10M5 5h1M14 5h1M5 6h1M14 6h1M0 9h1' +
          '6M0 10h1M2 10h1M15 10h1M0 11h1M3 11h1M15 11h1M0 12h1M4 12h1M15 1' +
          '2h1M0 13h1M3 13h1M15 13h1M0 14h1M2 14h1M15 14h1M0 15h16" />'#10'<pat' +
          'h stroke="#ffffff" d="M6 2h8M6 3h8M6 5h8M6 6h8M3 10h12M4 11h11M5' +
          ' 12h10M4 13h11M3 14h12" />'#10'<path stroke="#560056" d="M5 7h10" />' +
          #10'<path stroke="#4eff00" d="M1 10h1M1 11h2M1 12h3M1 13h2M1 14h1" ' +
          '/>'#10'</svg>'
      end
      item
        IconName = 'Light\ResetPython'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16" >'#10'<path stroke="#333333" d="M7 0h1M8' +
          ' 1h1" />'#10'<path stroke="#cecece" d="M3 1h1M3 4h1M3 7h1M7 7h1M5 8h' +
          '1M3 10h1M7 10h1" />'#10'<path stroke="#7e7e7e" d="M4 1h3M4 10h3" />'#10 +
          '<path stroke="#000000" d="M7 1h1M3 2h6M2 3h1M7 3h1M2 4h1M1 5h1M1' +
          ' 6h1M9 6h1M2 7h1M8 7h1M2 8h1M8 8h1M3 9h5" />'#10'<path stroke="#6f6f' +
          '6f" d="M2 2h1M2 9h1M8 9h1" />'#10'<path stroke="#aeaeae" d="M9 2h1" ' +
          '/>'#10'<path stroke="#8e8e8e" d="M1 3h1M1 8h1M9 8h1" />'#10'<path stroke' +
          '="#171717" d="M3 3h1M3 8h1M7 8h1" />'#10'<path stroke="#9e9e9e" d="M' +
          '4 3h1M8 3h1M7 4h1M4 8h1M6 8h1" />'#10'<path stroke="#bebebe" d="M5 3' +
          'h2" />'#10'<path stroke="#252525" d="M1 4h1M1 7h1M9 7h1" />'#10'<path st' +
          'roke="#424242" d="M2 5h1M8 6h1" />'#10'<path stroke="#505050" d="M2 ' +
          '6h1" />'#10'<path stroke="#6ac377" d="M11 8h1" />'#10'<path stroke="#6bc' +
          '479" d="M12 8h2" />'#10'<path stroke="#b0e0b7" d="M14 8h1" />'#10'<path ' +
          'stroke="#0e9c21" d="M11 9h1M14 9h1M11 10h1M11 11h1M11 12h1" />'#10'<' +
          'path stroke="#b2e1b9" d="M12 9h1" />'#10'<path stroke="#aedfb6" d="M' +
          '13 9h1" />'#10'<path stroke="#9ed8a7" d="M15 9h1" />'#10'<path stroke="#' +
          '8cd197" d="M14 10h1" />'#10'<path stroke="#5ebe6d" d="M15 10h1" />'#10'<' +
          'path stroke="#72c67e" d="M14 11h1" />'#10'<path stroke="#78c984" d="' +
          'M15 11h1" />'#10'<path stroke="#3eb150" d="M12 12h1" />'#10'<path stroke' +
          '="#35ad47" d="M13 12h1" />'#10'<path stroke="#58bb66" d="M14 12h1" /' +
          '>'#10'<path stroke="#0e9b21" d="M11 13h1M11 14h1" />'#10'<path stroke="#' +
          '0f9c22" d="M11 15h1" />'#10'</svg>'
      end
      item
        IconName = 'Dark\Close'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#ffffff">'#13#10'  <path d="m291-2' +
          '40-51-51 189-189-189-189 51-51 189 189 189-189 51 51-189 189 189' +
          ' 189-51 51-189-189-189 189Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\New'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#363636" d="M4 0h1M4' +
          ' 2h1M0 4h1M4 4h1M7 4h8M3 5h1M5 5h10M2 6h1M7 6h8M4 7h1M0 8h1M2 8h' +
          '1M5 8h1M7 8h8M2 9h13M2 10h13M2 12h13M2 13h13M2 14h13" />'#13#10'<path ' +
          'stroke="#ffff36" d="M0 1h1M4 1h1M1 2h1M7 2h1M2 3h1M4 3h1M6 3h1M3' +
          ' 4h1M4 6h1M6 6h1M1 7h2M5 7h1M7 7h1M4 8h1M6 8h1" />'#13#10'<path stroke' +
          '="#baffab" d="M3 1h1M7 1h1M0 2h1M3 2h1M6 2h1M1 3h1M3 3h1M5 3h1M8' +
          ' 3h1M2 4h1M5 4h2M0 5h3M4 5h1M1 6h1M3 6h1M5 6h1M0 7h1M3 7h1M6 7h1' +
          'M3 8h1" />'#13#10'<path stroke="#ffffff" d="M7 3h1M9 3h7M15 4h1M15 5h1' +
          'M15 6h1M8 7h8M1 8h1M15 8h1M1 9h1M15 9h1M1 10h1M15 10h1M1 11h15M1' +
          ' 12h1M15 12h1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<path s' +
          'troke="#ffff65" d="M1 4h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\Open'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#fea0a3" d="M5 0h1" ' +
          '/>'#13#10'<path stroke="#fba1a1" d="M6 0h3M9 1h1M10 2h1M9 3h2" />'#13#10'<pa' +
          'th stroke="#fba4a4" d="M4 1h1" />'#13#10'<path stroke="#fba3a3" d="M5 ' +
          '1h2M10 4h1" />'#13#10'<path stroke="#fba2a2" d="M7 1h1" />'#13#10'<path stro' +
          'ke="#fca8a8" d="M8 1h1" />'#13#10'<path stroke="#fea3ac" d="M3 2h1" />' +
          #13#10'<path stroke="#fea1aa" d="M4 2h1" />'#13#10'<path stroke="#fdacae" d' +
          '="M5 2h1" />'#13#10'<path stroke="#fea1a7" d="M9 2h1" />'#13#10'<path stroke' +
          '="#fba1a2" d="M12 2h1" />'#13#10'<path stroke="#ffffff" d="M1 3h8M13 3' +
          'h3M1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 6h1M1 7h15M1 8h1M15 8h1M1 ' +
          '9h1M15 9h1M1 10h1M15 10h1M1 11h15M1 12h1M15 12h1M1 13h1M15 13h1M' +
          '1 14h1M15 14h1M1 15h15" />'#13#10'<path stroke="#fca7a7" d="M11 3h1" /' +
          '>'#13#10'<path stroke="#faa2a2" d="M12 3h1" />'#13#10'<path stroke="#363636"' +
          ' d="M2 4h8M13 4h2M2 5h7M12 5h3M2 6h13M2 8h13M2 9h13M2 10h13M2 12' +
          'h13M2 13h13M2 14h13" />'#13#10'<path stroke="#fca2a2" d="M11 4h1" />'#13#10 +
          '<path stroke="#feafaf" d="M12 4h1M9 5h1" />'#13#10'<path stroke="#fca3' +
          'a3" d="M10 5h1" />'#13#10'<path stroke="#feacac" d="M11 5h1" />'#13#10'</svg' +
          '>'#13#10
      end
      item
        IconName = 'Dark\Insert'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 3h15M' +
          '1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 6h1M1 7h15" />'#13#10'<path stroke=' +
          '"#363636" d="M2 4h13M2 5h13M2 6h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\Connection'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <path stroke="#e6e6e6" d="M8 2L1' +
          '4 7.2 M2 7h12 M8 12 L14 6.8"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\ClassesOnOff'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M2 0h12M' +
          '1 1h2M13 1h2M1 2h1M14 2h1M1 3h1M14 3h1M1 4h1M14 4h1M1 5h14M1 6h1' +
          'M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10h1M14 10h1M1 ' +
          '11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M14 14h1M1 15h1' +
          '4" />'#13#10'<path stroke="#f1ff12" d="M3 1h10M2 2h12M2 3h12M2 4h12" /' +
          '>'#13#10'<path stroke="#363636" d="M2 6h12M2 7h12M2 8h12M2 9h12M2 10h1' +
          '2M2 11h12M2 12h12M2 13h12M2 14h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\View'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 1h5M1' +
          '0 1h5M1 2h1M5 2h1M10 2h5M1 3h5M10 3h5M1 4h1M5 4h6M14 4h1M1 5h1M5' +
          ' 5h1M10 5h1M14 5h1M1 6h1M5 6h1M10 6h1M14 6h1M1 7h5M10 7h5M3 8h1M' +
          '3 9h1M6 9h5M3 10h1M6 10h1M10 10h1M3 11h4M10 11h1M6 12h1M10 12h1M' +
          '6 13h1M10 13h1M6 14h5" />'#13#10'<path stroke="#1a21ff" d="M2 2h3" />'#13 +
          #10'<path stroke="#dcbb92" d="M2 4h1M4 6h1M7 11h1M9 13h1" />'#13#10'<path' +
          ' stroke="#f6d4ab" d="M3 4h1M3 6h1M8 11h1M8 13h1" />'#13#10'<path strok' +
          'e="#feddab" d="M4 4h1M2 6h1" />'#13#10'<path stroke="#bb9a72" d="M11 4' +
          'h1" />'#13#10'<path stroke="#d4b38a" d="M12 4h1M11 5h1" />'#13#10'<path stro' +
          'ke="#eecca3" d="M13 4h1M2 5h1M4 5h1M12 5h1M11 6h1M13 6h1M7 12h1M' +
          '9 12h1" />'#13#10'<path stroke="#fee6b3" d="M3 5h1M13 5h1M12 6h1M8 12h' +
          '1" />'#13#10'<path stroke="#ccb382" d="M7 10h1" />'#13#10'<path stroke="#e6c' +
          '49a" d="M8 10h1" />'#13#10'<path stroke="#feddb3" d="M9 10h1M9 11h1M7 ' +
          '13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\ZoomOut'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#e6e6e6">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400ZM280-540v' +
          '-80h200v80H280Z"/>'#13#10'</svg>'#13#10#13#10
      end
      item
        IconName = 'Dark\ZoomIn'
        SVGText = 
          '<svg viewBox="100 -850 800 800" fill="#e6e6e6">'#13#10'  <path d="M784' +
          '-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109' +
          ' 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l2' +
          '52 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T38' +
          '0-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Zm-40-60v-' +
          '80h-80v-80h80v-80h80v80h80v80h-80v80h-80Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Dark\Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<polygon stroke="white" fill="#a4c' +
          '8ef" points="1.5,0 10,0  15,5 15,15 1.5,15" />'#13#10'<path stroke="wh' +
          'ite" fill="none" d="M10 0 L 10, 5 15, 5" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\NewLayout'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 1h6M1' +
          ' 2h1M6 2h1M10 2h5M1 3h1M6 3h1M10 3h1M14 3h1M1 4h1M6 4h1M10 4h1M1' +
          '4 4h1M1 5h1M6 5h1M10 5h1M14 5h1M1 6h1M6 6h1M10 6h1M14 6h1M1 7h1M' +
          '6 7h1M10 7h5M1 8h6M1 11h12M1 12h1M12 12h1M1 13h1M12 13h1M1 14h12' +
          '" />'#13#10'<path stroke="#363636" d="M2 2h4M2 3h4M11 3h3M2 4h4M11 4h3' +
          'M2 5h4M11 5h3M2 6h4M11 6h3M2 7h4M2 12h10M2 13h10" />'#13#10'<path stro' +
          'ke="#725252" d="M7 3h1M6 10h1" />'#13#10'<path stroke="#eeeeee" d="M8 ' +
          '3h1M7 4h1M6 9h1M5 10h1M7 10h2" />'#13#10'<path stroke="#727272" d="M8 ' +
          '4h1" />'#13#10'<path stroke="#ababab" d="M9 4h1" />'#13#10'<path stroke="#9a' +
          '9a9a" d="M9 5h1M9 9h1" />'#13#10'<path stroke="#525252" d="M10 8h1" />' +
          #13#10'<path stroke="#dddddd" d="M4 9h1" />'#13#10'<path stroke="#626262" d' +
          '="M5 9h1" />'#13#10'<path stroke="#cccccc" d="M10 9h1" />'#13#10'<path strok' +
          'e="#7a7a7a" d="M9 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\Refresh'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h11M' +
          '1 1h1M11 1h2M1 2h1M11 2h1M13 2h1M1 3h1M11 3h4M1 4h1M14 4h1M1 5h1' +
          'M14 5h1M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10' +
          'h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M1' +
          '4 14h1M1 15h14" />'#13#10'<path stroke="#363636" d="M2 1h9M2 2h9M12 2h' +
          '1M2 3h5M8 3h3M2 4h5M9 4h5M2 5h3M10 5h4M2 6h2M5 6h2M9 6h5M2 7h2M5' +
          ' 7h2M8 7h6M2 8h2M5 8h5M11 8h3M2 9h5M8 9h2M11 9h3M2 10h4M8 10h2M1' +
          '1 10h3M2 11h3M10 11h4M2 12h4M8 12h6M2 13h5M8 13h6M2 14h12" />'#13#10'<' +
          'path stroke="#4ba34b" d="M7 3h1M7 4h2M5 5h5M4 6h1M7 6h2M4 7h1M7 ' +
          '7h1M4 8h1M10 8h1M7 9h1M10 9h1M6 10h2M10 10h1M5 11h5M6 12h2M7 13h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Dark\Interactive'
        SVGText = 
          '<svg  viewBox="0 -0.5 16 16" >'#10'<path stroke="#ffffff" d="M5 1h10' +
          'M5 2h1M14 2h1M5 3h1M14 3h1M5 4h10M5 5h1M14 5h1M5 6h1M14 6h1M5 7h' +
          '10M0 9h16M0 10h1M2 10h1M15 10h1M0 11h1M3 11h1M15 11h1M0 12h1M4 1' +
          '2h1M15 12h1M0 13h1M3 13h1M15 13h1M0 14h1M2 14h1M15 14h1M0 15h16"' +
          ' />'#10'<path stroke="#000000" d="M6 2h8M6 3h8M6 5h8M6 6h8M3 10h12M4' +
          ' 11h11M5 12h10M4 13h11M3 14h12" />'#10'<path stroke="#4eff00" d="M1 ' +
          '10h1M1 11h2M1 12h3M1 13h2M1 14h1" />'#10'</svg>'
      end
      item
        IconName = 'Dark\ResetPython'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16" >'#10'<path stroke="#cdcdcd" d="M7 0h1" ' +
          '/>'#10'<path stroke="#323232" d="M3 1h1M3 4h1M3 7h1M7 7h1M5 8h1M3 10' +
          'h1M7 10h1" />'#10'<path stroke="#7e7e7e" d="M4 1h3M4 10h3" />'#10'<path ' +
          'stroke="#ffffff" d="M7 1h1M3 2h6M2 3h1M7 3h1M2 4h1M1 5h1M1 6h1M2' +
          ' 7h1M8 7h1M2 8h1M8 8h1M3 9h5" />'#10'<path stroke="#333333" d="M8 1h' +
          '1" />'#10'<path stroke="#8d8d8d" d="M2 2h1M2 9h1M8 9h1" />'#10'<path str' +
          'oke="#505050" d="M9 2h1" />'#10'<path stroke="#6e6e6e" d="M1 3h1M1 8' +
          'h1M9 8h1" />'#10'<path stroke="#eeeeee" d="M3 3h1M3 8h1M7 8h1" />'#10'<p' +
          'ath stroke="#5f5f5f" d="M4 3h1M8 3h1M7 4h1M4 8h1M6 8h1" />'#10'<path' +
          ' stroke="#414141" d="M5 3h2" />'#10'<path stroke="#dedede" d="M1 4h1' +
          'M1 7h1M9 7h1" />'#10'<path stroke="#bdbdbd" d="M2 5h1M8 6h1" />'#10'<pat' +
          'h stroke="#adadad" d="M2 6h1" />'#10'<path stroke="#8eea68" d="M11 8' +
          'h1" />'#10'<path stroke="#90eb6a" d="M12 8h2" />'#10'<path stroke="#c3f3' +
          'b0" d="M14 8h1" />'#10'<path stroke="#45df00" d="M11 9h1M14 9h1M11 1' +
          '0h1M11 11h1" />'#10'<path stroke="#c6f4b2" d="M12 9h1" />'#10'<path stro' +
          'ke="#c2f3ae" d="M13 9h1" />'#10'<path stroke="#b6f29e" d="M15 9h1" /' +
          '>'#10'<path stroke="#a8ef8b" d="M14 10h1" />'#10'<path stroke="#85e95d" ' +
          'd="M15 10h1" />'#10'<path stroke="#94ec71" d="M14 11h1" />'#10'<path str' +
          'oke="#98ed77" d="M15 11h1" />'#10'<path stroke="#45df06" d="M11 12h1' +
          '" />'#10'<path stroke="#6de53c" d="M12 12h1" />'#10'<path stroke="#65e43' +
          '3" d="M13 12h1" />'#10'<path stroke="#80ea55" d="M14 12h1" />'#10'<path ' +
          'stroke="#45de06" d="M11 13h1M11 14h1" />'#10'<path stroke="#46de08" ' +
          'd="M11 15h1" />'#10'</svg>'
      end
      item
        SVGText = 
          '<svg viewBox="0 0 114 110" >'#13#10#13#10'<path stroke="#000000" stroke-wi' +
          'dth="10" d="M8 80 h101.5'#13#10'  M70 60 l39 20  M70 100 l 39 -20'#13#10'  "' +
          '/>  '#13#10#13#10'<path stroke="#000000" fill="#ff0" transform="matrix(.51' +
          '317 0 0 .4885 -3.115 -.567)" style="fill:#ff0;stroke:#060603;str' +
          'oke-opacity:1;stroke-width:10;stroke-miterlimit:4.0999999;stroke' +
          '-dasharray:none" d="M53.009 54.872 64 13.9l10.991 40.97L64 13.90' +
          '2l10.991 40.97 42.362-2.207L81.784 75.78l15.19 39.606L64 88.7l-3' +
          '2.974 26.685 15.19-39.606-35.57-23.115z"/>'#13#10#13#10'</svg>'
      end
      item
        SVGText = 
          '<svg viewBox="0 0 114 110" >'#13#10#13#10'<path stroke="#f0f0f0" stroke-wi' +
          'dth="10" d="M8 80 h101.5'#13#10'  M70 60 l39 20  M70 100 l 39 -20'#13#10'  "' +
          '/>  '#13#10#13#10'<path stroke="#eoeoeo" fill="#ff0" transform="matrix(.51' +
          '317 0 0 .4885 -3.115 -.567)" style="fill:#ff0;stroke:#f0f0f0;str' +
          'oke-opacity:1;stroke-width:10;stroke-miterlimit:4.0999999;stroke' +
          '-dasharray:none" d="M53.009 54.872 64 13.9l10.991 40.97L64 13.90' +
          '2l10.991 40.97 42.362-2.207L81.784 75.78l15.19 39.606L64 88.7l-3' +
          '2.974 26.685 15.19-39.606-35.57-23.115z"/>'#13#10#13#10'</svg>'
      end>
    Left = 312
    Top = 136
  end
end
