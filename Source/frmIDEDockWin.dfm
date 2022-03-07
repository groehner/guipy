object IDEDockWindow: TIDEDockWindow
  Left = 356
  Top = 263
  BorderStyle = bsSizeToolWin
  Caption = 'IDE Dock Window'
  ClientHeight = 408
  ClientWidth = 227
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  ParentFont = True
  OldCreateOrder = False
  PopupMode = pmExplicit
  Position = poDesigned
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object BGPanel: TPanel
    Left = 0
    Top = 0
    Width = 227
    Height = 408
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 0
    StyleElements = [seFont]
    object FGPanel: TPanel
      Left = 2
      Top = 2
      Width = 223
      Height = 404
      Align = alClient
      BevelOuter = bvNone
      Ctl3D = False
      FullRepaint = False
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object DockClient: TJvDockClient
    LRDockWidth = 220
    TBDockHeight = 220
    DirectDrag = False
    OnTabHostFormCreated = DockClientTabHostFormCreated
    Left = 8
    Top = 10
  end
end
