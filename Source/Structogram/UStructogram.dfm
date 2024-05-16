object FStructogram: TFStructogram
  Left = 591
  Top = 96
  BorderIcons = []
  Caption = 'Diagram'
  ClientHeight = 609
  ClientWidth = 727
  Color = clWhite
  ParentFont = True
  KeyPreview = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  TextHeight = 15
  object ScrollBox: TScrollBox
    Left = 24
    Top = 0
    Width = 703
    Height = 609
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWhite
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    PopupMenu = StructoPopupMenu
    TabOrder = 0
    OnClick = ScrollBoxClick
    OnMouseMove = ScrollBoxMouseMove
    ExplicitWidth = 699
    ExplicitHeight = 608
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 24
    Height = 609
    Align = alLeft
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 608
    object TrashImage: TImage
      Left = 1
      Top = 287
      Width = 22
      Height = 321
      Hint = 'Recycle bin'
      Align = alClient
      Center = True
      ParentShowHint = False
      ShowHint = True
      Transparent = True
      ExplicitLeft = 2
      ExplicitTop = 293
      ExplicitHeight = 322
    end
    object StructogramToolbar: TToolBar
      Left = 1
      Top = 1
      Width = 22
      Height = 286
      AutoSize = True
      Ctl3D = False
      Images = DMImages.ILStructogramToolbar
      TabOrder = 0
      object TBClose: TToolButton
        Left = 0
        Top = 0
        Hint = 'Close'
        ImageIndex = 0
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnClick = BBCloseClick
      end
      object TBStatement: TToolButton
        Tag = 1
        Left = 0
        Top = 22
        Hint = 'Statement'
        ImageIndex = 1
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBIfElse: TToolButton
        Tag = 2
        Left = 0
        Top = 44
        Hint = 'if else'
        ImageIndex = 2
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBIfElseif: TToolButton
        Tag = 6
        Left = 0
        Top = 66
        Hint = 'if elseif'
        ImageIndex = 3
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBWhile: TToolButton
        Tag = 3
        Left = 0
        Top = 88
        Hint = 'while'
        ImageIndex = 4
        Wrap = True
        OnMouseDown = StrElementMouseDown
      end
      object TBFor: TToolButton
        Tag = 5
        Left = 0
        Top = 110
        Hint = 'for'
        ImageIndex = 5
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBSubprogram: TToolButton
        Tag = 7
        Left = 0
        Top = 132
        Hint = 'Subprogram'
        ImageIndex = 6
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBBreak: TToolButton
        Tag = 10
        Left = 0
        Top = 154
        Hint = 'break'
        ImageIndex = 7
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBAlgorithm: TToolButton
        Left = 0
        Top = 176
        Hint = 'Algorithm'
        ImageIndex = 8
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnMouseDown = StrElementMouseDown
      end
      object TBCreatePythonCode: TToolButton
        Left = 0
        Top = 198
        Hint = 'Create Python code'
        ImageIndex = 9
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnClick = BBGeneratePythonClick
      end
      object TBZoomOut: TToolButton
        Left = 0
        Top = 220
        Hint = 'Zoom out'
        ImageIndex = 10
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnClick = BBZoomOutClick
      end
      object TBZoomIn: TToolButton
        Left = 0
        Top = 242
        Hint = 'Zoom in'
        ImageIndex = 11
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnClick = BBZoomInClick
      end
      object TBPuzzleMode: TToolButton
        Left = 0
        Top = 264
        Hint = 'Puzzle mode'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = BBPuzzleClick
      end
    end
  end
  object StructoPopupMenu: TSpTBXPopupMenu
    Images = DMImages.ILStructogramLight
    OnPopup = StructoPopupMenuPopup
    Left = 144
    Top = 56
    object MIDelete: TSpTBXItem
      Caption = 'Delete'
      ImageIndex = 0
      OnClick = MIDeleteClick
    end
    object MICopy: TSpTBXItem
      Caption = 'Copy'
      ImageIndex = 1
      OnClick = MICopyClick
    end
    object MISwitchWithCaseLine: TSpTBXItem
      Caption = 'Selection with case line'
      OnClick = MISwitchWithCaseLineClick
    end
    object MIAddCase: TSpTBXItem
      Caption = 'Add case'
      OnClick = MIAddCaseClick
    end
    object MIDeleteCase: TSpTBXItem
      Caption = 'Delete case'
      OnClick = MIDeleteCaseClick
    end
    object SpTBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object MIGenerateFunction: TSpTBXItem
      Caption = 'Create Python code'
      ImageIndex = 2
      OnClick = MIGenerateFunctionClick
    end
    object MIDatatype: TSpTBXSubmenuItem
      Caption = 'Data type'
      object MIBoolean: TSpTBXItem
        Caption = 'bool'
        OnClick = MIDatatypeClick
      end
      object MIFloat: TSpTBXItem
        Caption = 'float'
        OnClick = MIDatatypeClick
      end
      object MIInt: TSpTBXItem
        Caption = 'int'
        OnClick = MIDatatypeClick
      end
      object MILong: TSpTBXItem
        Caption = 'long'
        OnClick = MIDatatypeClick
      end
      object MIString: TSpTBXItem
        Caption = 'str'
        OnClick = MIDatatypeClick
      end
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MICopyAsPicture: TSpTBXItem
      Caption = 'Copy as picture'
      ImageIndex = 1
      OnClick = MICopyAsPictureClick
    end
    object MIPuzzle: TSpTBXItem
      Caption = 'Puzzle mode'
      ImageIndex = 3
      OnClick = MIPuzzleClick
    end
    object MIFont: TSpTBXItem
      Caption = 'Font'
      ImageIndex = 4
      OnClick = MIFontClick
    end
    object MIConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 5
      OnClick = MIConfigurationClick
    end
  end
end
