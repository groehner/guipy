inherited NewFileDialog: TNewFileDialog
  HelpContext = 640
  Caption = 'New File'
  ClientHeight = 297
  ClientWidth = 466
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 478
  ExplicitHeight = 335
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 466
    Height = 297
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 462
    ExplicitHeight = 296
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 464
      Height = 255
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 460
      object Splitter1: TSplitter
        Left = 186
        Top = 1
        Height = 253
        Cursor = crSizeWE
        ResizeStyle = rsUpdate
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 185
        Height = 253
        Align = alLeft
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 7
          Width = 59
          Height = 15
          Caption = 'Categories:'
        end
        object tvCategories: TVirtualStringTree
          Left = 1
          Top = 29
          Width = 183
          Height = 223
          Align = alBottom
          BevelInner = bvNone
          BevelOuter = bvNone
          BevelKind = bkFlat
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          NodeDataSize = 0
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoHideButtons, toAutoDeleteMovedNodes, toAutoChangeScale]
          TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          OnChange = tvCategoriesChange
          OnGetText = tvCategoriesGetText
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
      end
      object Panel4: TPanel
        Left = 189
        Top = 1
        Width = 274
        Height = 253
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 270
        object Label2: TLabel
          Left = 6
          Top = 7
          Width = 56
          Height = 15
          Caption = 'Templates:'
        end
        object lvTemplates: TListView
          Left = 1
          Top = 29
          Width = 272
          Height = 223
          Align = alBottom
          Columns = <>
          FlatScrollBars = True
          ReadOnly = True
          TabOrder = 0
          OnDblClick = lvTemplatesDblClick
          OnSelectItem = lvTemplatesSelectItem
          ExplicitWidth = 268
        end
      end
    end
    object btnCancel: TButton
      Left = 378
      Top = 264
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnCreate: TButton
      Left = 293
      Top = 265
      Width = 75
      Height = 25
      Caption = 'C&reate'
      Enabled = False
      TabOrder = 2
      OnClick = btnCreateClick
    end
  end
end
