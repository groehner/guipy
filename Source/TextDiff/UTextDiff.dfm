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
    Images = DMImages.ILTextDiffDark
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
      OnClick = TBCloseClick
    end
    object TBView: TToolButton
      Left = 27
      Top = 0
      Hint = 'Change view'
      ImageIndex = 1
      OnClick = HorzSplitClick
    end
    object TBNext: TToolButton
      Left = 50
      Top = 0
      Hint = 'Next difference'
      ImageIndex = 3
      OnClick = NextClick
    end
    object TBPrev: TToolButton
      Left = 73
      Top = 0
      Hint = 'Previous difference'
      ImageIndex = 4
      OnClick = PrevClick
    end
    object TBSourcecode: TToolButton
      Left = 96
      Top = 0
      Hint = 'Source code'
      ImageIndex = 5
      OnClick = TBSourcecodeClick
    end
    object TBCompare: TToolButton
      Left = 119
      Top = 0
      Hint = 'Compare'
      HelpType = htKeyword
      ImageIndex = 6
      OnClick = TBCompareClick
    end
    object TBDiffsOnly: TToolButton
      Left = 142
      Top = 0
      Hint = 'Only differences'
      HelpType = htKeyword
      ImageIndex = 7
      OnClick = TBDiffsOnlyClick
    end
    object TBCopyBlockLeft: TToolButton
      Left = 165
      Top = 0
      Hint = 'Copy block left'
      HelpType = htKeyword
      ImageIndex = 8
      OnClick = CopyBlockLeftClick
    end
    object TBCopyBlockRight: TToolButton
      Left = 188
      Top = 0
      Hint = 'Copy block right'
      HelpType = htKeyword
      ImageIndex = 9
      OnClick = CopyBlockRightClick
    end
    object TBIgnoreCase: TToolButton
      Left = 211
      Top = 0
      Hint = 'Ignore upper/lower case'
      ImageIndex = 12
      OnClick = TBIgnoreCaseClick
    end
    object TBIgnoreBlanks: TToolButton
      Left = 234
      Top = 0
      Hint = 'Ignore spaces'
      ImageIndex = 13
      OnClick = TBIgnoreBlanksClick
    end
    object TBParagraph: TToolButton
      Left = 257
      Top = 0
      Hint = 'Paragraph marks on/off '
      ImageIndex = 14
      OnClick = TBParagraphClick
    end
  end
  object PMain: TPanel
    Left = 0
    Top = 26
    Width = 796
    Height = 489
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 792
    ExplicitHeight = 488
    object Splitter: TSplitter
      Left = 315
      Top = 0
      Height = 489
      OnMoved = SplitterMoved
      ExplicitHeight = 214
    end
    object PLeft: TPanel
      Left = 0
      Top = 0
      Width = 315
      Height = 489
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 488
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
      Height = 489
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 474
      ExplicitHeight = 488
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 515
    Width = 796
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Width = 150
      end
      item
        Style = psOwnerDraw
        Width = 50
      end
      item
        Style = psOwnerDraw
        Width = 50
      end
      item
        Style = psOwnerDraw
        Width = 50
      end
      item
        Width = 150
      end>
    ParentFont = True
    UseSystemFont = False
    OnDrawPanel = StatusBarDrawPanel
    ExplicitTop = 514
    ExplicitWidth = 792
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
end
