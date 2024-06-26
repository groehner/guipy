object FUMLForm: TFUMLForm
  Left = 394
  Top = 229
  Caption = 'UML'
  ClientHeight = 604
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PUML: TPanel
    Left = 0
    Top = 0
    Width = 685
    Height = 604
    Align = alClient
    Caption = 'PUML'
    TabOrder = 0
    OnResize = PUMLResize
    ExplicitWidth = 681
    ExplicitHeight = 603
    object PDiagram: TPanel
      Left = 1
      Top = 1
      Width = 683
      Height = 420
      Align = alTop
      Constraints.MinHeight = 100
      TabOrder = 0
      ExplicitWidth = 679
      object PDiagramPanel: TPanel
        Left = 1
        Top = 23
        Width = 681
        Height = 396
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
        ExplicitWidth = 677
        object TVFileStructure: TTreeView
          Left = 536
          Top = 18
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
        Width = 681
        Height = 22
        AutoSize = True
        ButtonWidth = 24
        Color = clBtnFace
        EdgeInner = esNone
        EdgeOuter = esNone
        Images = DMImages.ILUMLToolbarLight
        ParentColor = False
        TabOrder = 1
        ExplicitWidth = 677
        object TBClose: TToolButton
          Left = 0
          Top = 0
          Hint = 'Close'
          ImageIndex = 0
          OnClick = SBCloseClick
        end
        object TBClassDefinition: TToolButton
          Left = 24
          Top = 0
          Hint = 'New class'
          ImageIndex = 1
          OnClick = TBClassDefinitionClick
        end
        object TBClassOpen: TToolButton
          Left = 48
          Top = 0
          Hint = 'Open class'
          ImageIndex = 2
          OnClick = TBClassOpenClick
        end
        object TBShowConnections: TToolButton
          Left = 72
          Top = 0
          Hint = 'Connections: none, classes and objects, all'
          ImageIndex = 3
          OnClick = TBShowConnectionsClick
        end
        object TBObjectDiagram: TToolButton
          Left = 96
          Top = 0
          Hint = 'Class diagram on/off'
          ImageIndex = 4
          OnClick = TBObjectDiagramClick
        end
        object TBView: TToolButton
          Left = 120
          Top = 0
          Hint = 'View'
          ImageIndex = 5
          OnClick = TBViewClick
        end
        object TBZoomOut: TToolButton
          Left = 144
          Top = 0
          Hint = 'Zoom out'
          ImageIndex = 6
          OnClick = TBZoomOutClick
        end
        object TBZoomIn: TToolButton
          Left = 168
          Top = 0
          Hint = 'Zoom in'
          ImageIndex = 7
          OnClick = TBZoomInClick
        end
        object TBComment: TToolButton
          Left = 192
          Top = 0
          Hint = 'Comment'
          ImageIndex = 8
          OnClick = TBCommentClick
        end
        object TBNewLayout: TToolButton
          Left = 216
          Top = 0
          Hint = 'New layout'
          ImageIndex = 9
          OnClick = TBNewLayoutClick
        end
        object TBRefresh: TToolButton
          Left = 240
          Top = 0
          Hint = 'Refresh'
          ImageIndex = 10
          OnClick = TBRefreshClick
        end
        object TBInteractive: TToolButton
          Left = 264
          Top = 0
          Hint = 'Show/hide interactive'
          ImageIndex = 11
          OnClick = TBInteractiveClick
        end
        object TBReInitialize: TToolButton
          Left = 288
          Top = 0
          Hint = 'Reinitialize Python engine'
          ImageIndex = 12
          OnClick = TBReInitializeClick
        end
      end
    end
    object PInteractive: TPanel
      Left = 1
      Top = 424
      Width = 683
      Height = 179
      Align = alClient
      PopupMenu = PMInteractive
      TabOrder = 1
      ExplicitWidth = 679
      ExplicitHeight = 178
      object TBInteractiveToolbar: TToolBar
        Left = 1
        Top = 1
        Width = 681
        Height = 22
        AutoSize = True
        Color = clBtnFace
        Images = DMImages.ILInteractive
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 677
        object TBInteractiveClose: TToolButton
          Left = 0
          Top = 0
          Hint = 'Close'
          ImageIndex = 0
          OnClick = TBInteractiveCloseClick
        end
        object TBExecute: TToolButton
          Left = 23
          Top = 0
          Hint = 'Execute selected/current line'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = TBExecuteClick
        end
        object TBSynEditZoomMinus: TToolButton
          Left = 46
          Top = 0
          Hint = 'Zoom out'
          ImageIndex = 8
          OnClick = TBSynEditZoomMinusClick
        end
        object TBSynEditZoomPlus: TToolButton
          Left = 69
          Top = 0
          Hint = 'Zoom in'
          ImageIndex = 9
          OnClick = TBSynEditZoomPlusClick
        end
        object TBDelete: TToolButton
          Left = 92
          Top = 0
          Hint = 'Delete selected/all'
          ImageIndex = 7
          ParentShowHint = False
          ShowHint = True
          OnClick = TBDeleteClick
        end
      end
      object SynEdit: TSynEdit
        Left = 1
        Top = 23
        Width = 681
        Height = 155
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 1
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Consolas'
        Gutter.Font.Style = []
        Gutter.Visible = False
        Gutter.Bands = <
          item
            Kind = gbkMarks
            Width = 13
          end
          item
            Kind = gbkLineNumbers
          end
          item
            Kind = gbkFold
          end
          item
            Kind = gbkTrackChanges
          end
          item
            Kind = gbkMargin
            Width = 3
          end>
        Highlighter = ResourcesDataModule.SynCppSyn
        RightEdge = 0
        SelectedColor.Alpha = 0.400000005960464500
        OnChange = SynEditChange
        ExplicitWidth = 677
        ExplicitHeight = 154
      end
    end
    object SpTBXSplitter1: TSpTBXSplitter
      Left = 1
      Top = 421
      Width = 683
      Height = 3
      Cursor = crSizeNS
      Align = alTop
      ParentColor = False
      ExplicitWidth = 679
    end
  end
  object PMInteractive: TSpTBXPopupMenu
    Images = DMImages.ILInteractive
    Left = 56
    Top = 472
    object MIClose: TSpTBXItem
      Caption = 'Close'
      ImageIndex = 0
      OnClick = MICloseClick
    end
    object SpTBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object MIPaste: TSpTBXItem
      Caption = 'Paste'
      ImageIndex = 6
      ShortCut = 16470
      OnClick = MIPasteClick
    end
    object MICopy: TSpTBXItem
      Caption = 'Copy'
      ImageIndex = 5
      ShortCut = 16451
      OnClick = MICopyClick
    end
    object MIDelete: TSpTBXItem
      Caption = 'Delete'
      ImageIndex = 7
      ShortCut = 16472
      OnClick = MIDeleteClick
    end
    object SpTBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object MICopyAll: TSpTBXItem
      Caption = 'Copy all'
      OnClick = MICopyAllClick
    end
    object MIDeleteAll: TSpTBXItem
      Caption = 'Delete all'
      OnClick = MIDeleteAllClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIFont: TSpTBXItem
      Caption = 'Font'
      OnClick = MIFontClick
    end
  end
  object EmptyPopupMenu: TPopupMenu
    Left = 57
    Top = 50
  end
end
