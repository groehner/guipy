object FGUIDesigner: TFGUIDesigner
  Left = 564
  Top = 308
  Caption = 'GUI designer'
  ClientHeight = 184
  ClientWidth = 382
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object GUIDesignerTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = GUIDesignerTimerTimer
    Left = 288
    Top = 8
  end
  object PopupMenu: TSpTBXPopupMenu
    Images = DMImages.ILGUIDesigner
    OnPopup = PopupMenuPopup
    Left = 24
    Top = 8
    object MIClose: TSpTBXItem
      Caption = 'Close'
      ImageIndex = 0
      OnClick = MICloseClick
    end
    object MIToSource: TSpTBXItem
      Caption = 'to sourcecode'
      ImageIndex = 1
      OnClick = MIToSourceClick
    end
    object MIForeground: TSpTBXItem
      Caption = 'to foreground'
      ImageIndex = 2
      OnClick = MIForegroundClick
    end
    object MIBackground: TSpTBXItem
      Caption = 'to background'
      ImageIndex = 3
      OnClick = MIBackgroundClick
    end
    object SpTBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object MIAlign: TSpTBXSubmenuItem
      Caption = 'Align'
      ImageIndex = 4
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
    object MIAlignToGrid: TSpTBXItem
      Caption = 'Align to grid'
      OnClick = MIAlignToGridClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIDelete: TSpTBXItem
      Caption = 'Delete'
      ImageIndex = 5
      OnClick = MIDeleteClick
    end
    object MICut: TSpTBXItem
      Caption = 'Cut'
      ImageIndex = 6
      ShortCut = 16472
      OnClick = CutClick
    end
    object MICopy: TSpTBXItem
      Caption = 'Copy'
      ImageIndex = 7
      ShortCut = 16451
      OnClick = CopyClick
    end
    object MIPaste: TSpTBXItem
      Caption = 'Paste'
      ImageIndex = 8
      ShortCut = 16470
      OnClick = PasteClick
    end
    object SpTBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object MIZoomIn: TSpTBXItem
      Caption = 'Zoom in'
      ImageIndex = 19
      OnClick = MIZoomInClick
    end
    object MIZoomOut: TSpTBXItem
      Caption = 'Zoom out'
      ImageIndex = 20
      OnClick = MIZoomOutClick
    end
  end
end
