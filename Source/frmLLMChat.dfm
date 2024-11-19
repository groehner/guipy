inherited LLMChatForm: TLLMChatForm
  Left = 0
  Top = 0
  HelpContext = 497
  Caption = 'Chat'
  ClientHeight = 643
  ClientWidth = 578
  OnShow = FormShow
  ExplicitWidth = 586
  ExplicitHeight = 670
  TextHeight = 15
  inherited BGPanel: TPanel
    Width = 578
    Height = 643
    FullRepaint = False
    ExplicitWidth = 570
    ExplicitHeight = 631
    inherited FGPanel: TPanel
      Width = 574
      Height = 639
      ExplicitWidth = 566
      ExplicitHeight = 627
      object pnlQuestion: TPanel
        Left = 0
        Top = 554
        Width = 574
        Height = 85
        Align = alBottom
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        ExplicitTop = 542
        ExplicitWidth = 566
        DesignSize = (
          574
          85)
        object sbAsk: TSpeedButton
          Left = 510
          Top = 4
          Width = 32
          Height = 32
          Action = actAskQuestion
          Anchors = [akTop, akRight]
          Images = vilImages
          Flat = True
          ExplicitLeft = 542
        end
        object aiBusy: TActivityIndicator
          Left = 510
          Top = 44
          Anchors = [akRight, akBottom]
          FrameDelay = 150
          IndicatorType = aitRotatingSector
          ExplicitLeft = 502
        end
        object synQuestion: TSynEdit
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 498
          Height = 77
          Cursor = crDefault
          Align = alLeft
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          PopupMenu = pmAsk
          TabOrder = 0
          OnEnter = synQuestionEnter
          OnKeyDown = synQuestionKeyDown
          UseCodeFolding = False
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
          Gutter.Font.Quality = fqClearTypeNatural
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
          HideSelection = True
          Highlighter = SynMultiSyn
          RightEdge = 0
          ScrollBars = ssVertical
          SelectedColor.Alpha = 0.400000005960464500
          WordWrap = True
          ExplicitWidth = 490
        end
      end
      object ScrollBox: TScrollBox
        Left = 0
        Top = 34
        Width = 574
        Height = 515
        HorzScrollBar.Visible = False
        VertScrollBar.Tracking = True
        Align = alClient
        ParentBackground = True
        TabOrder = 1
        ExplicitWidth = 566
        ExplicitHeight = 503
        object QAStackPanel: TStackPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 566
          Height = 23
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          ControlCollection = <>
          DoubleBuffered = True
          HorizontalPositioning = sphpFill
          ParentColor = True
          ParentDoubleBuffered = False
          TabOrder = 0
          ExplicitWidth = 558
        end
      end
      object Splitter: TSpTBXSplitter
        Left = 0
        Top = 549
        Width = 574
        Height = 5
        Cursor = crSizeNS
        Align = alBottom
        ParentColor = False
        MinSize = 90
        ExplicitTop = 537
        ExplicitWidth = 566
      end
      object SpTBXDock: TSpTBXDock
        Left = 0
        Top = 0
        Width = 574
        Height = 34
        AllowDrag = False
        DoubleBuffered = True
        ExplicitWidth = 566
        object SpTBXToolbar: TSpTBXToolbar
          Left = 0
          Top = 0
          CloseButton = False
          DockMode = dmCannotFloatOrChangeDocks
          DockPos = 0
          DragHandleStyle = dhNone
          FullSize = True
          Images = vilImages
          ParentShowHint = False
          ShowHint = True
          ShrinkMode = tbsmNone
          Stretch = True
          TabOrder = 0
          Customizable = False
          object spiNewTopic: TSpTBXItem
            Action = actChatNew
          end
          object spiRemoveTopic: TSpTBXItem
            Action = actChatRemove
          end
          object SpTBXSeparatorItem2: TSpTBXSeparatorItem
          end
          object spiSave: TSpTBXItem
            Action = actChatSave
          end
          object SpTBXSeparatorItem4: TSpTBXSeparatorItem
          end
          object spiTitle: TSpTBXItem
            Action = actTopicTitle
          end
          object spiCancel: TTBItem
            Action = actCancelRequest
          end
          object SpTBXRightAlignSpacerItem: TSpTBXRightAlignSpacerItem
            CustomWidth = 341
          end
          object spiPreviousTopic: TSpTBXItem
            Action = actChatPrevious
          end
          object spiNextTopic: TSpTBXItem
            Action = actChatNext
          end
        end
      end
    end
  end
  inherited DockClient: TJvDockClient
    LRDockWidth = 400
    Left = 32
    Top = 58
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 2
        CollectionName = 'ArrowLeft'
        Name = 'ArrowLeft'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ArrowRight'
        Name = 'ArrowRight'
      end
      item
        CollectionIndex = 103
        CollectionName = 'Setup'
        Name = 'Setup'
      end
      item
        CollectionIndex = 99
        CollectionName = 'Save'
        Name = 'Save'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 142
        CollectionName = 'Chat\Chat'
        Name = 'Chat'
      end
      item
        CollectionIndex = 143
        CollectionName = 'Chat\ChatPlus'
        Name = 'ChatPlus'
      end
      item
        CollectionIndex = 144
        CollectionName = 'Chat\ChatRemove'
        Name = 'ChatRemove'
      end
      item
        CollectionIndex = 145
        CollectionName = 'Chat\ChatQuestion'
        Name = 'ChatQuestion'
      end
      item
        CollectionIndex = 146
        CollectionName = 'Chat\UserQuestion'
        Name = 'UserQuestion'
      end
      item
        CollectionIndex = 65
        CollectionName = 'Paste'
        Name = 'Paste'
      end
      item
        CollectionIndex = 166
        CollectionName = 'Title'
        Name = 'Title'
      end
      item
        CollectionIndex = 164
        CollectionName = 'Assistant'
        Name = 'Assitant'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 85
        CollectionName = 'PythonScript'
        Name = 'PythonScript'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    Width = 24
    Height = 24
    Left = 120
    Top = 352
  end
  object ChatActionList: TActionList
    Images = vilImages
    OnUpdate = ChatActionListUpdate
    Left = 32
    Top = 352
    object actChatSave: TAction
      Category = 'Chat'
      Caption = 'Save chat'
      Hint = 'Save chat history'
      ImageIndex = 3
      ImageName = 'Save'
      OnExecute = actChatSaveExecute
    end
    object actChatRemove: TAction
      Category = 'Chat'
      Caption = 'Remove Chat Topic'
      Hint = 'Remove current chat topic'
      ImageIndex = 7
      ImageName = 'ChatRemove'
      OnExecute = actChatRemoveExecute
    end
    object actChatNew: TAction
      Category = 'Chat'
      Caption = 'New Chat Topic'
      Hint = 'Add a new chat topic'
      ImageIndex = 6
      ImageName = 'ChatPlus'
      OnExecute = actChatNewExecute
    end
    object actChatPrevious: TAction
      Category = 'Chat'
      Caption = 'Previous Chat Topic'
      Hint = 'Show previous chat topic'
      ImageIndex = 0
      ImageName = 'ArrowLeft'
      OnExecute = actChatPreviousExecute
    end
    object actChatNext: TAction
      Category = 'Chat'
      Caption = 'Next Chat Topic'
      Hint = 'Show next chat topic'
      ImageIndex = 1
      ImageName = 'ArrowRight'
      OnExecute = actChatNextExecute
    end
    object actCopyText: TAction
      Category = 'Chat'
      Caption = 'Copy'
      Hint = 'Copy text'
      ImageIndex = 4
      ImageName = 'Copy'
      OnExecute = actCopyTextExecute
    end
    object actAskQuestion: TAction
      Category = 'Chat'
      Hint = 'Ask question'
      ImageIndex = 8
      ImageName = 'ChatQuestion'
      OnExecute = actAskQuestionExecute
    end
    object actTopicTitle: TAction
      Category = 'Chat'
      Caption = 'Topic Title'
      Hint = 'Set the title of the chat topic'
      ImageIndex = 11
      ImageName = 'Title'
      OnExecute = actTopicTitleExecute
    end
    object actCancelRequest: TAction
      Category = 'Chat'
      Caption = 'Cancel Request'
      Hint = 'Cancel active request'
      ImageIndex = 13
      ImageName = 'Delete'
      OnExecute = actCancelRequestExecute
    end
    object actCopyCode: TAction
      Category = 'Chat'
      Caption = 'Copy Code'
      Hint = 'Copy the python code'
      OnExecute = actCopyCodeExecute
    end
    object actCopyToNewEditor: TAction
      Category = 'Chat'
      Caption = 'Copy Code to New Editor'
      Hint = 'Copy the python code to a new editor'
      ImageIndex = 14
      ImageName = 'PythonScript'
      OnExecute = actCopyToNewEditorExecute
    end
  end
  object AppEvents: TApplicationEvents
    OnMessage = AppEventsMessage
    Left = 120
    Top = 264
  end
  object SynMultiSyn: TSynMultiSyn
    Schemes = <
      item
        StartExpr = '```python'
        EndExpr = '```'
        MarkerAttri.Background = clNone
        MarkerAttri.Style = []
        SchemeName = 'Python'
      end
      item
        StartExpr = '```'
        EndExpr = '```'
        MarkerAttri.Background = clNone
        MarkerAttri.Style = []
        SchemeName = 'Python'
      end>
    Left = 32
    Top = 264
  end
  object pmAsk: TSpTBXPopupMenu
    Left = 120
    Top = 136
    object mnCopy: TSpTBXItem
      Action = CommandsDataModule.actEditCopy
    end
    object mnPaste: TSpTBXItem
      Action = CommandsDataModule.actEditPaste
    end
  end
  object pmTextMenu: TSpTBXPopupMenu
    Images = vilImages
    OnPopup = pmTextMenuPopup
    Left = 32
    Top = 136
    object mnCopyText: TSpTBXItem
      Action = actCopyText
    end
    object SpTBXItem1: TSpTBXItem
      Action = actCopyCode
    end
    object SpTBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object SpTBXItem2: TSpTBXItem
      Action = actCopyToNewEditor
    end
  end
end
