inherited LLMChatForm: TLLMChatForm
  Left = 0
  Top = 0
  HelpContext = 497
  Caption = 'Chat'
  ClientHeight = 655
  ClientWidth = 586
  OnShow = FormShow
  ExplicitWidth = 602
  ExplicitHeight = 694
  TextHeight = 15
  inherited BGPanel: TPanel
    Width = 586
    Height = 655
    FullRepaint = False
    ExplicitWidth = 586
    ExplicitHeight = 655
    inherited FGPanel: TPanel
      Width = 582
      Height = 651
      ExplicitWidth = 582
      ExplicitHeight = 651
      object pnlQuestion: TPanel
        Left = 0
        Top = 566
        Width = 582
        Height = 85
        Align = alBottom
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          582
          85)
        object sbAsk: TSpeedButton
          Left = 542
          Top = 4
          Width = 32
          Height = 32
          Action = actAskQuestion
          Anchors = [akTop, akRight]
          Flat = True
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00C73CC774833383AFBF3CBF7CEE2BEE3CFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00943894A3000000FF000000FF833383AFF91AF920FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FD0EFD10331733E3000000FF000000FF0F070FF7A73BA7938E36
            8EA75B275BCB1E0E1EEF251125EB6D2D6DBFA23AA297CA3BCA70FB14FB18FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00C73CC774000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF160A16F3BB3C
            BB80FD0EFD10FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00DE37DE58000000FF000000FF000000FF833383AFD13A
            D168EE2BEE3CFC11FC14FC11FC14EE2BEE3CD13AD168833383AF000000FF0000
            00FF1E0E1EEFEE2BEE3CFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00F81DF8242C142CE7000000FF732F73BBF425F430FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F425F4307E32
            7EB3000000FF2C142CE7F91AF920FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FC11FC14471F47D7000000FF893589ABFE03FE04FF00FF00FF00FF00FF00
            FF00FF00FF00000000FF000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF008E368EA7000000FF4E224ED3FD0AFD0CFF00FF00FF00FF00FF00FF00FF00
            FF00BF3CBF7C000000FF5B275BCBFD0AFD0CFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00000000FF000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FE03FE045B275BCB000000FFC73CC774FF00FF00FF00FF00FF00FF00FF00
            FF004E224ED3000000FFD13AD168FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00D13AD168000000FF552555CFFF00FF00FF00FF00FF00FF00FF00
            FF001E0E1EEF000000FFF91AF920FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF006D2D6DBF000000FFF91AF920FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00F91AF920000000FF1E0E1EEFFF00FF00FF00FF00FF00FF00FF00
            FF001E0E1EEF000000FFF91AF920FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00F91AF920672B67C3411D41DBF522F52CFF00FF00FF00FF00FF00
            FF00FF00FF00F91AF920000000FF1E0E1EEFFF00FF00FF00FF00FF00FF00FF00
            FF00552555CF000000FFD13AD168FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FE03FE04612961C7331733E3FF00FF00FF00FF00FF00
            FF00FF00FF00D13AD168000000FF552555CFFF00FF00FF00FF00FF00FF00FF00
            FF00C73CC774000000FF5B275BCBFD0AFD0CFF00FF00FF00FF00FF00FF00C33C
            C3786D2D6DBFD13AD168FD0AFD0C612961C7000000FFFC11FC14FF00FF00FF00
            FF00FD0AFD0C5B275BCB000000FFC73CC774FF00FF00FF00FF00FF00FF00FF00
            FF00FD0AFD0C4E224ED3000000FF7E327EB3FE03FE04FF00FF00FF00FF00E334
            E350070307FB000000FF000000FF000000FF793179B7FF00FF00FF00FF00FE03
            FE04893589AB000000FF4E224ED3FD0AFD0CFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FA17FA1C2C142CE7000000FF672B67C3EE2BEE3CFF00FF00FF00
            FF00FB14FB18E334E350C73CC774E633E64CFE03FE04FF00FF00F425F430732F
            73BB000000FF2C142CE7FA17FA1CFF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00F227F2342C142CE7000000FF000000FF833383AFD13A
            D168EE2BEE3CFC11FC14FC11FC14EE2BEE3CD13AD168833383AF000000FF0000
            00FF2C142CE7F227F234FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FE07FE08BF3CBF7C1E0E1EEF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF1E0E1EEFBF3C
            BF7CFE07FE08FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FB14FB18CA3BCA70A23A
            A297672B67C3251125EB251125EB6D2D6DBFA23AA297CA3BCA70FB14FB18FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        end
        object aiBusy: TActivityIndicator
          Left = 542
          Top = 44
          Anchors = [akRight, akBottom]
          FrameDelay = 150
          IndicatorType = aitRotatingSector
        end
        object synQuestion: TSynEdit
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 530
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
          ScrollbarAnnotations = <
            item
              AnnType = sbaCarets
              AnnPos = sbpFullWidth
              FullRow = False
            end>
          WordWrap = True
        end
      end
      object Splitter: TSpTBXSplitter
        Left = 0
        Top = 561
        Width = 582
        Height = 5
        Cursor = crSizeNS
        Align = alBottom
        ParentColor = False
        MinSize = 90
      end
      object SpTBXDock: TSpTBXDock
        Left = 0
        Top = 0
        Width = 582
        Height = 34
        AllowDrag = False
        DoubleBuffered = True
        object SpTBXToolbar: TSpTBXToolbar
          Left = 0
          Top = 0
          CloseButton = False
          DockMode = dmCannotFloatOrChangeDocks
          DockPos = 0
          DragHandleStyle = dhNone
          FullSize = True
          Images = vilImagesDark
          ParentShowHint = False
          ShowHint = True
          ShrinkMode = tbsmNone
          Stretch = True
          TabOrder = 0
          Customizable = False
          object spiNewTopic: TSpTBXItem
            Action = actChatNew
            ImageIndex = 2
          end
          object spiRemoveTopic: TSpTBXItem
            Action = actChatRemove
            ImageIndex = 3
          end
          object SpTBXSeparatorItem7: TSpTBXSeparatorItem
          end
          object spiPreviousTopic: TSpTBXItem
            Action = actChatPrevious
            ImageIndex = 14
            ImageName = 'ChatPrev'
          end
          object spiNextTopic: TSpTBXItem
            Action = actChatNext
            ImageIndex = 13
            ImageName = 'ChatNext'
          end
          object SpTBXSeparatorItem5: TSpTBXSeparatorItem
          end
          object spiTitle: TSpTBXItem
            Action = actTopicTitle
            ImageIndex = 5
            ImageName = 'ChatTitle'
          end
          object SpTBXSeparatorItem2: TSpTBXSeparatorItem
          end
          object spiPrint: TTBItem
            Action = actPrint
            ImageIndex = 19
          end
          object spiSave: TSpTBXItem
            Action = actChatSave
            ImageIndex = 4
            ImageName = 'ChatSave'
          end
          object SpTBXSeparatorItem4: TSpTBXSeparatorItem
          end
          object spiCancel: TTBItem
            Action = actCancelRequest
            ImageIndex = 6
            ImageName = 'ChatCancel'
          end
          object SpTBXRightAlignSpacerItem: TSpTBXRightAlignSpacerItem
            CustomWidth = 306
          end
        end
      end
      object EdgeBrowser: TEdgeBrowser
        Left = 0
        Top = 34
        Width = 582
        Height = 527
        Align = alClient
        TabOrder = 4
        AllowSingleSignOnUsingOSPrimaryAccount = False
        TargetCompatibleBrowserVersion = '117.0.2045.28'
        UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
        OnCreateWebViewCompleted = EdgeBrowserCreateWebViewCompleted
        OnWebMessageReceived = EdgeBrowserWebMessageReceived
      end
      object pnlBrowserCover: TPanel
        Left = 0
        Top = 34
        Width = 582
        Height = 527
        Align = alClient
        TabOrder = 3
      end
    end
  end
  inherited DockClient: TJvDockClient
    LRDockWidth = 400
    Left = 48
    Top = 74
  end
  object ChatActionList: TActionList
    OnUpdate = ChatActionListUpdate
    Left = 40
    Top = 328
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
    object actPrint: TAction
      Category = 'Chat'
      Caption = 'Print'
      Hint = 'Print chat topic'
      ImageIndex = 21
      ImageName = 'Print'
      OnExecute = actPrintExecute
    end
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
    Left = 40
    Top = 248
  end
  object pmAsk: TSpTBXPopupMenu
    Left = 40
    Top = 176
    object mnCopy: TSpTBXItem
      Action = CommandsDataModule.actEditCopy
    end
    object mnPaste: TSpTBXItem
      Action = CommandsDataModule.actEditPaste
    end
    object SpTBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object mnSpelling: TSpTBXSubmenuItem
      Caption = 'Spelling'
      LinkSubitems = CommandsDataModule.mnSpelling
    end
  end
  object icMenuAndToolbar: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'ArrowLeft'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'    <path d="M20,9V15H12V19.84L4.16,1' +
          '2L12,4.16V9H20Z" />'#13#10'</svg>'
      end
      item
        IconName = 'ArrowRight'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'    <path d="M4,15V9H12V4.16L19.84,12' +
          'L12,19.84V15H4Z" />'#13#10'</svg>'
      end
      item
        IconName = 'ChatPlus'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M12 3C17.5 3 22 6.58 22 11' +
          'C22 11.58 21.92 12.14 21.78 12.68C21.19 12.38 20.55 12.16 19.88 ' +
          '12.06C19.96 11.72 20 11.36 20 11C20 7.69 16.42 5 12 5C7.58 5 4 7' +
          '.69 4 11C4 14.31 7.58 17 12 17L13.09 16.95L13 18L13.08 18.95L12 ' +
          '19C10.81 19 9.62 18.83 8.47 18.5C6.64 20 4.37 20.89 2 21C4.33 18' +
          '.67 4.75 17.1 4.75 16.5C3.06 15.17 2.05 13.15 2 11C2 6.58 6.5 3 ' +
          '12 3M18 14H20V17H23V19H20V22H18V19H15V17H18V14Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatRemove'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M15.46 15.88L16.88 14.46L1' +
          '9 16.59L21.12 14.47L22.54 15.88L20.41 18L22.54 20.12L21.12 21.54' +
          'L19 19.41L16.88 21.54L15.46 20.12L17.59 18L15.47 15.88M12 3C17.5' +
          ' 3 22 6.58 22 11C22 11.58 21.92 12.14 21.78 12.68C21.19 12.38 20' +
          '.55 12.16 19.88 12.06C19.96 11.72 20 11.36 20 11C20 7.69 16.42 5' +
          ' 12 5C7.58 5 4 7.69 4 11C4 14.31 7.58 17 12 17L13.09 16.95L13 18' +
          'L13.08 18.95L12 19C10.81 19 9.62 18.83 8.47 18.5C6.64 20 4.37 20' +
          '.89 2 21C4.33 18.67 4.75 17.1 4.75 16.5C3.06 15.17 2.05 13.15 2 ' +
          '11C2 6.58 6.5 3 12 3Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatSave'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M23.5,2.5h-18c-1.7,0-3,1.4-' +
          '3,3v21c0,1.6,1.3,3,3,3h21c1.6,0,3-1.4,3-3v-18L23.5,2.5z M26.5,26' +
          '.5h-21v-21h16.8l4.2,4.2'#13#10#9#9'V26.5z M16,16c-2.5,0-4.5,1.9-4.5,4.5s' +
          '2,4.5,4.5,4.5s4.5-1.9,4.5-4.5S18.6,16,16,16z M7,7h13.5v6H7V7z"/>' +
          #13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatTitle'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'   <path d="M5,4V7H10.5V19H13.5V7H19V' +
          '4H5Z" />'#13#10'</svg>'
      end
      item
        IconName = 'ChatCancel'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path fill="#E24444" d="M24.9,10.2L2' +
          '7,5.9L22.5,8l-6.2,6.2L5.6,3.5L3.4,5.8l10.7,10.7l-9,9l2.2,2.2l9-9' +
          'l9,9l3.3,0.7l-1.2-3l-8.9-8.9L24.9,10.2z"/>'#13#10'</svg>'
      end
      item
        IconName = 'ChatCopy'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10'<g transform="translate(69.2 -212)">'#13 +
          #10#9'<path d="M-46.8,212.2h-17.2c-1.6,0-2.9,1.2-2.9,2.9v20.1h2.9v-2' +
          '0.1h17.2V212.2z M-42.5,218h-15.8'#13#10#9#9'c-1.6,0-2.9,1.2-2.9,2.9v20.1' +
          'c0,1.6,1.2,2.9,2.9,2.9h15.8c1.6,0,2.9-1.2,2.9-2.9v-20.1C-39.6,21' +
          '9.2-40.9,218-42.5,218L-42.5,218z'#13#10#9#9' M-42.5,240.9h-15.8v-20.1h15' +
          '.8V240.9z"/>'#13#10'</g>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'CopyNewEditor'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10'<g transform="translate(-272.1 -317.4' +
          ')">'#13#10#9'<path d="M290.9,318.8h-11.3c-1.6,0-2.9,1.3-2.8,2.9v23.4c0,' +
          '1.6,1.2,2.9,2.8,2.9h17c1.6,0,2.9-1.3,2.8-2.9v-17.6'#13#10#9#9'L290.9,318' +
          '.8z M279.6,345.2v-23.4h9.9v7.3h7.1v16.1H279.6z"/>'#13#10'</g>'#13#10'</svg>'#13 +
          #10#13#10
      end
      item
        IconName = 'ChatQuestion'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M12 3C6.5 3 2 6.6 2 11C2 1' +
          '3.2 3.1 15.2 4.8 16.5C4.8 17.1 4.4 18.7 2 21C4.4 20.9 6.6 20 8.5' +
          ' 18.5C9.6 18.8 10.8 19 12 19C17.5 19 22 15.4 22 11S17.5 3 12 3M1' +
          '2 17C7.6 17 4 14.3 4 11S7.6 5 12 5 20 7.7 20 11 16.4 17 12 17M12' +
          '.2 6.5C11.3 6.5 10.6 6.7 10.1 7C9.5 7.4 9.2 8 9.3 8.7H11.3C11.3 ' +
          '8.4 11.4 8.2 11.6 8.1C11.8 8 12 7.9 12.3 7.9C12.6 7.9 12.9 8 13.' +
          '1 8.2C13.3 8.4 13.4 8.6 13.4 8.9C13.4 9.2 13.3 9.4 13.2 9.6C13 9' +
          '.8 12.8 10 12.6 10.1C12.1 10.4 11.7 10.7 11.5 10.9C11.1 11.2 11 ' +
          '11.5 11 12H13C13 11.7 13.1 11.5 13.1 11.3C13.2 11.1 13.4 11 13.6' +
          ' 10.8C14.1 10.6 14.4 10.3 14.7 9.9C15 9.5 15.1 9.1 15.1 8.7C15.1' +
          ' 8 14.8 7.4 14.3 7C13.9 6.7 13.1 6.5 12.2 6.5M11 13V15H13V13H11Z' +
          '"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatPaste'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10'<g transform="translate(-180.6 -325.9' +
          ')">'#13#10#9'<path d="M206.8,329h-6.2c-0.9-2.3-3.3-3.4-5.6-2.6c-1.2,0.5' +
          '-2.2,1.4-2.6,2.6h-6.2c-1.6,0-2.9,1.2-2.9,2.8v23'#13#10#9#9'c0,1.6,1.3,2.' +
          '8,2.9,2.8h20.5c1.6,0,2.9-1.2,2.9-2.8v-23C209.7,330.2,208.4,329,2' +
          '06.8,329z M196.6,329c0.8,0,1.4,0.7,1.4,1.4'#13#10#9#9's-0.7,1.4-1.4,1.4s' +
          '-1.4-0.7-1.4-1.4S195.8,329,196.6,329z M206.8,354.8h-20.5v-23h2.9' +
          'v4.3h14.6v-4.3h2.9V354.8z"/>'#13#10'</g>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'UserQuestion'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M20.5,14.5V16H19V14.5H20.5' +
          'M18.5,9.5H17V9A3,3 0 0,1 20,6A3,3 0 0,1 23,9C23,9.97 22.5,10.88 ' +
          '21.71,11.41L21.41,11.6C20.84,12 20.5,12.61 20.5,13.3V13.5H19V13.' +
          '3C19,12.11 19.6,11 20.59,10.35L20.88,10.16C21.27,9.9 21.5,9.47 2' +
          '1.5,9A1.5,1.5 0 0,0 20,7.5A1.5,1.5 0 0,0 18.5,9V9.5M9,13C11.67,1' +
          '3 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,4A4,4 0 0,1 13,8' +
          'A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,14.9C6.03,14.9 2.9' +
          ',16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 9,14.9M9,5.9A2.' +
          '1,2.1 0 0,0 6.9,8A2.1,2.1 0 0,0 9,10.1A2.1,2.1 0 0,0 11.1,8A2.1,' +
          '2.1 0 0,0 9,5.9Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Assistant'
        SVGText = 
          '<svg viewBox="0 -960 960 960">'#13#10'    <circle r="70" cx="360" cy="' +
          '-640" fill="#E24444" /> '#13#10'    <circle r="70" cx="600" cy="-640" ' +
          'fill="#E24444" /> '#13#10#13#10'    <path'#13#10'        d="M160-120v-200q0-33 2' +
          '3.5-56.5T240-400h480q33 0 56.5 23.5T800-320v200H160Zm200-320'#13#10'  ' +
          '      q-83 0-141.5-58.5T160-640q0-83 58.5-141.5T360-840h240q83 0' +
          ' 141.5 58.5T800-640'#13#10'        q0 83-58.5 141.5T600-440H360Z'#13#10'    ' +
          '    M240-200h480v-120H240v120Zm120-320h240q50 0 85-35t35-85q0-50' +
          '-35-85t-85-35H360'#13#10'        q-50 0-85 35t-35 85q0 50 35 85t85 35Z' +
          '" />'#13#10'</svg>'
      end
      item
        IconName = 'ChatNext'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'      <path d="M12,3C6.5,3 2,6.58 2,1' +
          '1C2.05,13.15 3.06,15.17 4.75,16.5C4.75,17.1 4.33,18.67 2,21C4.37' +
          ',20.89 6.64,20 8.47,18.5C9.61,18.83 10.81,19 12,19C17.5,19 22,15' +
          '.42 22,11C22,6.58 17.5,3 12,3M12,17C7.58,17 4,14.31 4,11C4,7.69 ' +
          '7.58,5 12,5C16.42,5 20,7.69 20,11C20,14.31 16.42,17 12,17Z"/>'#13#10' ' +
          '     <path d="M12 10V7l4 4-4 4v-3H8v-2h4z" transform="translate(' +
          '0.5)"/>'#13#10'</svg>'
      end
      item
        IconName = 'ChatPrev'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'      <path d="M12,3C6.5,3 2,6.58 2,1' +
          '1C2.05,13.15 3.06,15.17 4.75,16.5C4.75,17.1 4.33,18.67 2,21C4.37' +
          ',20.89 6.64,20 8.47,18.5C9.61,18.83 10.81,19 12,19C17.5,19 22,15' +
          '.42 22,11C22,6.58 17.5,3 12,3M12,17C7.58,17 4,14.31 4,11C4,7.69 ' +
          '7.58,5 12,5C16.42,5 20,7.69 20,11C20,14.31 16.42,17 12,17Z"/>'#13#10' ' +
          '     <path d="M12 10V7l4 4-4 4v-3H8v-2h4z" transform="translate(' +
          '0, -2) rotate(180, 12, 12)"/>'#13#10'</svg>'
      end
      item
        IconName = 'ChatPlus'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'  <path d="M12 3C17.5 ' +
          '3 22 6.58 22 11C22 11.58 21.92 12.14 21.78 12.68C21.19 12.38 20.' +
          '55 12.16 19.88 12.06C19.96 11.72 20 11.36 20 11C20 7.69 16.42 5 ' +
          '12 5C7.58 5 4 7.69 4 11C4 14.31 7.58 17 12 17L13.09 16.95L13 18L' +
          '13.08 18.95L12 19C10.81 19 9.62 18.83 8.47 18.5C6.64 20 4.37 20.' +
          '89 2 21C4.33 18.67 4.75 17.1 4.75 16.5C3.06 15.17 2.05 13.15 2 1' +
          '1C2 6.58 6.5 3 12 3M18 14H20V17H23V19H20V22H18V19H15V17H18V14Z"/' +
          '>'#13#10'</svg>'
      end
      item
        IconName = 'ChatRemove'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'  <path d="M15.46 15.8' +
          '8L16.88 14.46L19 16.59L21.12 14.47L22.54 15.88L20.41 18L22.54 20' +
          '.12L21.12 21.54L19 19.41L16.88 21.54L15.46 20.12L17.59 18L15.47 ' +
          '15.88M12 3C17.5 3 22 6.58 22 11C22 11.58 21.92 12.14 21.78 12.68' +
          'C21.19 12.38 20.55 12.16 19.88 12.06C19.96 11.72 20 11.36 20 11C' +
          '20 7.69 16.42 5 12 5C7.58 5 4 7.69 4 11C4 14.31 7.58 17 12 17L13' +
          '.09 16.95L13 18L13.08 18.95L12 19C10.81 19 9.62 18.83 8.47 18.5C' +
          '6.64 20 4.37 20.89 2 21C4.33 18.67 4.75 17.1 4.75 16.5C3.06 15.1' +
          '7 2.05 13.15 2 11C2 6.58 6.5 3 12 3Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ChatSave'
        SVGText = 
          '<svg viewBox="0 0 32 32" fill="#e6e6e6">'#13#10#9'<path d="M23.5,2.5h-1' +
          '8c-1.7,0-3,1.4-3,3v21c0,1.6,1.3,3,3,3h21c1.6,0,3-1.4,3-3v-18L23.' +
          '5,2.5z M26.5,26.5h-21v-21h16.8l4.2,4.2'#13#10#9#9'V26.5z M16,16c-2.5,0-4' +
          '.5,1.9-4.5,4.5s2,4.5,4.5,4.5s4.5-1.9,4.5-4.5S18.6,16,16,16z M7,7' +
          'h13.5v6H7V7z"/>'#13#10'</svg>'
      end
      item
        IconName = 'ChatTitle'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'   <path d="M5,4V7H10.' +
          '5V19H13.5V7H19V4H5Z" />'#13#10'</svg>'
      end
      item
        IconName = 'ChatNext'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'      <path d="M12,3C6' +
          '.5,3 2,6.58 2,11C2.05,13.15 3.06,15.17 4.75,16.5C4.75,17.1 4.33,' +
          '18.67 2,21C4.37,20.89 6.64,20 8.47,18.5C9.61,18.83 10.81,19 12,1' +
          '9C17.5,19 22,15.42 22,11C22,6.58 17.5,3 12,3M12,17C7.58,17 4,14.' +
          '31 4,11C4,7.69 7.58,5 12,5C16.42,5 20,7.69 20,11C20,14.31 16.42,' +
          '17 12,17Z"/>'#13#10'      <path d="M12 10V7l4 4-4 4v-3H8v-2h4z" transf' +
          'orm="translate(0.5)"/>'#13#10'</svg>'
      end
      item
        IconName = 'ChatPrev'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'      <path d="M12,3C6' +
          '.5,3 2,6.58 2,11C2.05,13.15 3.06,15.17 4.75,16.5C4.75,17.1 4.33,' +
          '18.67 2,21C4.37,20.89 6.64,20 8.47,18.5C9.61,18.83 10.81,19 12,1' +
          '9C17.5,19 22,15.42 22,11C22,6.58 17.5,3 12,3M12,17C7.58,17 4,14.' +
          '31 4,11C4,7.69 7.58,5 12,5C16.42,5 20,7.69 20,11C20,14.31 16.42,' +
          '17 12,17Z"/>'#13#10'      <path d="M12 10V7l4 4-4 4v-3H8v-2h4z" transf' +
          'orm="translate(0, -2) rotate(180, 12, 12)"/>'#13#10'</svg>'
      end
      item
        IconName = 'ChatQuestion'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'  <path d="M12 3C6.5 3' +
          ' 2 6.6 2 11C2 13.2 3.1 15.2 4.8 16.5C4.8 17.1 4.4 18.7 2 21C4.4 ' +
          '20.9 6.6 20 8.5 18.5C9.6 18.8 10.8 19 12 19C17.5 19 22 15.4 22 1' +
          '1S17.5 3 12 3M12 17C7.6 17 4 14.3 4 11S7.6 5 12 5 20 7.7 20 11 1' +
          '6.4 17 12 17M12.2 6.5C11.3 6.5 10.6 6.7 10.1 7C9.5 7.4 9.2 8 9.3' +
          ' 8.7H11.3C11.3 8.4 11.4 8.2 11.6 8.1C11.8 8 12 7.9 12.3 7.9C12.6' +
          ' 7.9 12.9 8 13.1 8.2C13.3 8.4 13.4 8.6 13.4 8.9C13.4 9.2 13.3 9.' +
          '4 13.2 9.6C13 9.8 12.8 10 12.6 10.1C12.1 10.4 11.7 10.7 11.5 10.' +
          '9C11.1 11.2 11 11.5 11 12H13C13 11.7 13.1 11.5 13.1 11.3C13.2 11' +
          '.1 13.4 11 13.6 10.8C14.1 10.6 14.4 10.3 14.7 9.9C15 9.5 15.1 9.' +
          '1 15.1 8.7C15.1 8 14.8 7.4 14.3 7C13.9 6.7 13.1 6.5 12.2 6.5M11 ' +
          '13V15H13V13H11Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'UserQuestion'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'  <path d="M20.5,14.5V' +
          '16H19V14.5H20.5M18.5,9.5H17V9A3,3 0 0,1 20,6A3,3 0 0,1 23,9C23,9' +
          '.97 22.5,10.88 21.71,11.41L21.41,11.6C20.84,12 20.5,12.61 20.5,1' +
          '3.3V13.5H19V13.3C19,12.11 19.6,11 20.59,10.35L20.88,10.16C21.27,' +
          '9.9 21.5,9.47 21.5,9A1.5,1.5 0 0,0 20,7.5A1.5,1.5 0 0,0 18.5,9V9' +
          '.5M9,13C11.67,13 17,14.34 17,17V20H1V17C1,14.34 6.33,13 9,13M9,4' +
          'A4,4 0 0,1 13,8A4,4 0 0,1 9,12A4,4 0 0,1 5,8A4,4 0 0,1 9,4M9,14.' +
          '9C6.03,14.9 2.9,16.36 2.9,17V18.1H15.1V17C15.1,16.36 11.97,14.9 ' +
          '9,14.9M9,5.9A2.1,2.1 0 0,0 6.9,8A2.1,2.1 0 0,0 9,10.1A2.1,2.1 0 ' +
          '0,0 11.1,8A2.1,2.1 0 0,0 9,5.9Z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Assistant'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#e6e6e6">'#13#10'    <circle r="70' +
          '" cx="360" cy="-640" fill="#E24444" /> '#13#10'    <circle r="70" cx="' +
          '600" cy="-640" fill="#E24444" /> '#13#10#13#10'    <path'#13#10'        d="M160-' +
          '120v-200q0-33 23.5-56.5T240-400h480q33 0 56.5 23.5T800-320v200H1' +
          '60Zm200-320'#13#10'        q-83 0-141.5-58.5T160-640q0-83 58.5-141.5T3' +
          '60-840h240q83 0 141.5 58.5T800-640'#13#10'        q0 83-58.5 141.5T600' +
          '-440H360Z'#13#10'        M240-200h480v-120H240v120Zm120-320h240q50 0 8' +
          '5-35t35-85q0-50-35-85t-85-35H360'#13#10'        q-50 0-85 35t-35 85q0 ' +
          '50 35 85t85 35Z" />'#13#10'</svg>'
      end
      item
        IconName = 'Ollama'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M7.905 1.09c.216.085.411.2' +
          '25.588.41.295.306.544.744.734 1.263.191.522.315 1.1.362 1.68a5.0' +
          '54 5.054 0 012.049-.636l.051-.004c.87-.07 1.73.087 2.48.474.101.' +
          '053.2.11.297.17.05-.569.172-1.134.36-1.644.19-.52.439-.957.733-1' +
          '.264a1.67 1.67 0 01.589-.41c.257-.1.53-.118.796-.042.401.114.745' +
          '.368 1.016.737.248.337.434.769.561 1.287.23.934.27 2.163.115 3.6' +
          '45l.053.04.026.019c.757.576 1.284 1.397 1.563 2.35.435 1.487.216' +
          ' 3.155-.534 4.088l-.018.021.002.003c.417.762.67 1.567.724 2.4l.0' +
          '02.03c.064 1.065-.2 2.137-.814 3.19l-.007.01.01.024c.472 1.157.6' +
          '2 2.322.438 3.486l-.006.039a.651.651 0 01-.747.536.648.648 0 01-' +
          '.54-.742c.167-1.033.01-2.069-.48-3.123a.643.643 0 01.04-.617l.00' +
          '4-.006c.604-.924.854-1.83.8-2.72-.046-.779-.325-1.544-.8-2.273a.' +
          '644.644 0 01.18-.886l.009-.006c.243-.159.467-.565.58-1.12a4.229 ' +
          '4.229 0 00-.095-1.974c-.205-.7-.58-1.284-1.105-1.683-.595-.454-1' +
          '.383-.673-2.38-.61a.653.653 0 01-.632-.371c-.314-.665-.772-1.141' +
          '-1.343-1.436a3.288 3.288 0 00-1.772-.332c-1.245.099-2.343.801-2.' +
          '67 1.686a.652.652 0 01-.61.425c-1.067.002-1.893.252-2.497.703-.5' +
          '22.39-.878.935-1.066 1.588a4.07 4.07 0 00-.068 1.886c.112.558.33' +
          '1 1.02.582 1.269l.008.007c.212.207.257.53.109.785-.36.622-.629 1' +
          '.549-.673 2.44-.05 1.018.186 1.902.719 2.536l.016.019a.643.643 0' +
          ' 01.095.69c-.576 1.236-.753 2.252-.562 3.052a.652.652 0 01-1.269' +
          '.298c-.243-1.018-.078-2.184.473-3.498l.014-.035-.008-.012a4.339 ' +
          '4.339 0 01-.598-1.309l-.005-.019a5.764 5.764 0 01-.177-1.785c.04' +
          '4-.91.278-1.842.622-2.59l.012-.026-.002-.002c-.293-.418-.51-.953' +
          '-.63-1.545l-.005-.024a5.352 5.352 0 01.093-2.49c.262-.915.777-1.' +
          '701 1.536-2.269.06-.045.123-.09.186-.132-.159-1.493-.119-2.73.11' +
          '2-3.67.127-.518.314-.95.562-1.287.27-.368.614-.622 1.015-.737.26' +
          '6-.076.54-.059.797.042zm4.116 9.09c.936 0 1.8.313 2.446.855.63.5' +
          '27 1.005 1.235 1.005 1.94 0 .888-.406 1.58-1.133 2.022-.62.375-1' +
          '.451.557-2.403.557-1.009 0-1.871-.259-2.493-.734-.617-.47-.963-1' +
          '.13-.963-1.845 0-.707.398-1.417 1.056-1.946.668-.537 1.55-.849 2' +
          '.485-.849zm0 .896a3.07 3.07 0 00-1.916.65c-.461.37-.722.835-.722' +
          ' 1.25 0 .428.21.829.61 1.134.455.347 1.124.548 1.943.548.799 0 1' +
          '.473-.147 1.932-.426.463-.28.7-.686.7-1.257 0-.423-.246-.89-.683' +
          '-1.256-.484-.405-1.14-.643-1.864-.643zm.662 1.21l.004.004c.12.15' +
          '1.095.37-.056.49l-.292.23v.446a.375.375 0 01-.376.373.375.375 0 ' +
          '01-.376-.373v-.46l-.271-.218a.347.347 0 01-.052-.49.353.353 0 01' +
          '.494-.051l.215.172.22-.174a.353.353 0 01.49.051zm-5.04-1.919c.47' +
          '8 0 .867.39.867.871a.87.87 0 01-.868.871.87.87 0 01-.867-.87.87.' +
          '87 0 01.867-.872zm8.706 0c.48 0 .868.39.868.871a.87.87 0 01-.868' +
          '.871.87.87 0 01-.867-.87.87.87 0 01.867-.872zM7.44 2.3l-.003.002' +
          'a.659.659 0 00-.285.238l-.005.006c-.138.189-.258.467-.348.832-.1' +
          '7.692-.216 1.631-.124 2.782.43-.128.899-.208 1.404-.237l.01-.001' +
          '.019-.034c.046-.082.095-.161.148-.239.123-.771.022-1.692-.253-2.' +
          '444-.134-.364-.297-.65-.453-.813a.628.628 0 00-.107-.09L7.44 2.3' +
          'zm9.174.04l-.002.001a.628.628 0 00-.107.09c-.156.163-.32.45-.453' +
          '.814-.29.794-.387 1.776-.23 2.572l.058.097.008.014h.03a5.184 5.1' +
          '84 0 011.466.212c.086-1.124.038-2.043-.128-2.722-.09-.365-.21-.6' +
          '43-.349-.832l-.004-.006a.659.659 0 00-.285-.239h-.004z"/>'#13#10'</svg' +
          '>'
      end
      item
        IconName = 'DeepSeek'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M23.748 4.482c-.254-.124-.' +
          '364.113-.512.234-.051.039-.094.09-.137.136-.372.397-.806.657-1.3' +
          '73.626-.829-.046-1.537.214-2.163.848-.133-.782-.575-1.248-1.247-' +
          '1.548-.352-.156-.708-.311-.955-.65-.172-.241-.219-.51-.305-.774-' +
          '.055-.16-.11-.323-.293-.35-.2-.031-.278.136-.356.276-.313.572-.4' +
          '34 1.202-.422 1.84.027 1.436.633 2.58 1.838 3.393.137.093.172.18' +
          '7.129.323-.082.28-.18.552-.266.833-.055.179-.137.217-.329.14a5.5' +
          '26 5.526 0 01-1.736-1.18c-.857-.828-1.631-1.742-2.597-2.458a11.3' +
          '65 11.365 0 00-.689-.471c-.985-.957.13-1.743.388-1.836.27-.098.0' +
          '93-.432-.779-.428-.872.004-1.67.295-2.687.684a3.055 3.055 0 01-.' +
          '465.137 9.597 9.597 0 00-2.883-.102c-1.885.21-3.39 1.102-4.497 2' +
          '.623C.082 8.606-.231 10.684.152 12.85c.403 2.284 1.569 4.175 3.3' +
          '6 5.653 1.858 1.533 3.997 2.284 6.438 2.14 1.482-.085 3.133-.284' +
          ' 4.994-1.86.47.234.962.327 1.78.397.63.059 1.236-.03 1.705-.128.' +
          '735-.156.684-.837.419-.961-2.155-1.004-1.682-.595-2.113-.926 1.0' +
          '96-1.296 2.746-2.642 3.392-7.003.05-.347.007-.565 0-.845-.004-.1' +
          '7.035-.237.23-.256a4.173 4.173 0 001.545-.475c1.396-.763 1.96-2.' +
          '015 2.093-3.517.02-.23-.004-.467-.247-.588zM11.581 18c-2.089-1.6' +
          '42-3.102-2.183-3.52-2.16-.392.024-.321.471-.235.763.09.288.207.4' +
          '86.371.739.114.167.192.416-.113.603-.673.416-1.842-.14-1.897-.16' +
          '7-1.361-.802-2.5-1.86-3.301-3.307-.774-1.393-1.224-2.887-1.298-4' +
          '.482-.02-.386.093-.522.477-.592a4.696 4.696 0 011.529-.039c2.132' +
          '.312 3.946 1.265 5.468 2.774.868.86 1.525 1.887 2.202 2.891.72 1' +
          '.066 1.494 2.082 2.48 2.914.348.292.625.514.891.677-.802.09-2.14' +
          '.11-3.054-.614zm1-6.44a.306.306 0 01.415-.287.302.302 0 01.2.288' +
          '.306.306 0 01-.31.307.303.303 0 01-.304-.308zm3.11 1.596c-.2.081' +
          '-.399.151-.59.16a1.245 1.245 0 01-.798-.254c-.274-.23-.47-.358-.' +
          '552-.758a1.73 1.73 0 01.016-.588c.07-.327-.008-.537-.239-.727-.1' +
          '87-.156-.426-.199-.688-.199a.559.559 0 01-.254-.078c-.11-.054-.2' +
          '-.19-.114-.358.028-.054.16-.186.192-.21.356-.202.767-.136 1.146.' +
          '016.352.144.618.408 1.001.782.391.451.462.576.685.914.176.265.33' +
          '6.537.445.848.067.195-.019.354-.25.452z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'OpenAI'
        SVGText = 
          '<svg fill-rule="evenodd" viewBox="0 0 24 24">'#13#10'  <path d="M21.55' +
          ' 10.004a5.416 5.416 0 00-.478-4.501c-1.217-2.09-3.662-3.166-6.05' +
          '-2.66A5.59 5.59 0 0010.831 1C8.39.995 6.224 2.546 5.473 4.838A5.' +
          '553 5.553 0 001.76 7.496a5.487 5.487 0 00.691 6.5 5.416 5.416 0 ' +
          '00.477 4.502c1.217 2.09 3.662 3.165 6.05 2.66A5.586 5.586 0 0013' +
          '.168 23c2.443.006 4.61-1.546 5.361-3.84a5.553 5.553 0 003.715-2.' +
          '66 5.488 5.488 0 00-.693-6.497v.001zm-8.381 11.558a4.199 4.199 0' +
          ' 01-2.675-.954c.034-.018.093-.05.132-.074l4.44-2.53a.71.71 0 00.' +
          '364-.623v-6.176l1.877 1.069c.02.01.033.029.036.05v5.115c-.003 2.' +
          '274-1.87 4.118-4.174 4.123zM4.192 17.78a4.059 4.059 0 01-.498-2.' +
          '763c.032.02.09.055.131.078l4.44 2.53c.225.13.504.13.73 0l5.42-3.' +
          '088v2.138a.068.068 0 01-.027.057L9.9 19.288c-1.999 1.136-4.552.4' +
          '6-5.707-1.51h-.001zM3.023 8.216A4.15 4.15 0 015.198 6.41l-.002.1' +
          '51v5.06a.711.711 0 00.364.624l5.42 3.087-1.876 1.07a.067.067 0 0' +
          '1-.063.005l-4.489-2.559c-1.995-1.14-2.679-3.658-1.53-5.63h.001zm' +
          '15.417 3.54l-5.42-3.088L14.896 7.6a.067.067 0 01.063-.006l4.489 ' +
          '2.557c1.998 1.14 2.683 3.662 1.529 5.633a4.163 4.163 0 01-2.174 ' +
          '1.807V12.38a.71.71 0 00-.363-.623zm1.867-2.773a6.04 6.04 0 00-.1' +
          '32-.078l-4.44-2.53a.731.731 0 00-.729 0l-5.42 3.088V7.325a.068.0' +
          '68 0 01.027-.057L14.1 4.713c2-1.137 4.555-.46 5.707 1.513.487.83' +
          '3.664 1.809.499 2.757h.001zm-11.741 3.81l-1.877-1.068a.065.065 0' +
          ' 01-.036-.051V6.559c.001-2.277 1.873-4.122 4.181-4.12.976 0 1.92' +
          '.338 2.671.954-.034.018-.092.05-.131.073l-4.44 2.53a.71.71 0 00-' +
          '.365.623l-.003 6.173v.002zm1.02-2.168L12 9.25l2.414 1.375v2.75L1' +
          '2 14.75l-2.415-1.375v-2.75z"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Gemini'
        SVGText = 
          '<svg fill-rule="evenodd" viewBox="0 0 24 24" >'#13#10'  <path d="M12 2' +
          '4A14.304 14.304 0 000 12 14.304 14.304 0 0012 0a14.305 14.305 0 ' +
          '0012 12 14.305 14.305 0 00-12 12"/>'#13#10'</svg>'
      end
      item
        IconName = 'Print'
        SVGText = 
          '<svg viewBox="0 0 32 32">'#13#10#9'<path d="M26.5,10H25V2.5H7V10H5.5C3,' +
          '10,1,11.9,1,14.5v9h6v6h18v-6h6v-9C31,11.9,28.9,10,26.5,10z M10,5' +
          '.5h12V10H10V5.5z M22,23.5v3'#13#10#9#9'H10v-6h12V23.5z M25,20.5v-3H7v3H4' +
          'v-6C4,13.7,4.8,13,5.5,13h21c0.9,0,1.5,0.8,1.5,1.5v6H25z"/>'#13#10#9'<ci' +
          'rcle cx="25" cy="15.2" r="1.5"/>'#13#10'</svg>'
      end
      item
        IconName = 'Ollama'
        SVGText = 
          '<svg viewBox="0 0 24 24"  fill="#e6e6e6">'#13#10'  <path d="M7.905 1.0' +
          '9c.216.085.411.225.588.41.295.306.544.744.734 1.263.191.522.315 ' +
          '1.1.362 1.68a5.054 5.054 0 012.049-.636l.051-.004c.87-.07 1.73.0' +
          '87 2.48.474.101.053.2.11.297.17.05-.569.172-1.134.36-1.644.19-.5' +
          '2.439-.957.733-1.264a1.67 1.67 0 01.589-.41c.257-.1.53-.118.796-' +
          '.042.401.114.745.368 1.016.737.248.337.434.769.561 1.287.23.934.' +
          '27 2.163.115 3.645l.053.04.026.019c.757.576 1.284 1.397 1.563 2.' +
          '35.435 1.487.216 3.155-.534 4.088l-.018.021.002.003c.417.762.67 ' +
          '1.567.724 2.4l.002.03c.064 1.065-.2 2.137-.814 3.19l-.007.01.01.' +
          '024c.472 1.157.62 2.322.438 3.486l-.006.039a.651.651 0 01-.747.5' +
          '36.648.648 0 01-.54-.742c.167-1.033.01-2.069-.48-3.123a.643.643 ' +
          '0 01.04-.617l.004-.006c.604-.924.854-1.83.8-2.72-.046-.779-.325-' +
          '1.544-.8-2.273a.644.644 0 01.18-.886l.009-.006c.243-.159.467-.56' +
          '5.58-1.12a4.229 4.229 0 00-.095-1.974c-.205-.7-.58-1.284-1.105-1' +
          '.683-.595-.454-1.383-.673-2.38-.61a.653.653 0 01-.632-.371c-.314' +
          '-.665-.772-1.141-1.343-1.436a3.288 3.288 0 00-1.772-.332c-1.245.' +
          '099-2.343.801-2.67 1.686a.652.652 0 01-.61.425c-1.067.002-1.893.' +
          '252-2.497.703-.522.39-.878.935-1.066 1.588a4.07 4.07 0 00-.068 1' +
          '.886c.112.558.331 1.02.582 1.269l.008.007c.212.207.257.53.109.78' +
          '5-.36.622-.629 1.549-.673 2.44-.05 1.018.186 1.902.719 2.536l.01' +
          '6.019a.643.643 0 01.095.69c-.576 1.236-.753 2.252-.562 3.052a.65' +
          '2.652 0 01-1.269.298c-.243-1.018-.078-2.184.473-3.498l.014-.035-' +
          '.008-.012a4.339 4.339 0 01-.598-1.309l-.005-.019a5.764 5.764 0 0' +
          '1-.177-1.785c.044-.91.278-1.842.622-2.59l.012-.026-.002-.002c-.2' +
          '93-.418-.51-.953-.63-1.545l-.005-.024a5.352 5.352 0 01.093-2.49c' +
          '.262-.915.777-1.701 1.536-2.269.06-.045.123-.09.186-.132-.159-1.' +
          '493-.119-2.73.112-3.67.127-.518.314-.95.562-1.287.27-.368.614-.6' +
          '22 1.015-.737.266-.076.54-.059.797.042zm4.116 9.09c.936 0 1.8.31' +
          '3 2.446.855.63.527 1.005 1.235 1.005 1.94 0 .888-.406 1.58-1.133' +
          ' 2.022-.62.375-1.451.557-2.403.557-1.009 0-1.871-.259-2.493-.734' +
          '-.617-.47-.963-1.13-.963-1.845 0-.707.398-1.417 1.056-1.946.668-' +
          '.537 1.55-.849 2.485-.849zm0 .896a3.07 3.07 0 00-1.916.65c-.461.' +
          '37-.722.835-.722 1.25 0 .428.21.829.61 1.134.455.347 1.124.548 1' +
          '.943.548.799 0 1.473-.147 1.932-.426.463-.28.7-.686.7-1.257 0-.4' +
          '23-.246-.89-.683-1.256-.484-.405-1.14-.643-1.864-.643zm.662 1.21' +
          'l.004.004c.12.151.095.37-.056.49l-.292.23v.446a.375.375 0 01-.37' +
          '6.373.375.375 0 01-.376-.373v-.46l-.271-.218a.347.347 0 01-.052-' +
          '.49.353.353 0 01.494-.051l.215.172.22-.174a.353.353 0 01.49.051z' +
          'm-5.04-1.919c.478 0 .867.39.867.871a.87.87 0 01-.868.871.87.87 0' +
          ' 01-.867-.87.87.87 0 01.867-.872zm8.706 0c.48 0 .868.39.868.871a' +
          '.87.87 0 01-.868.871.87.87 0 01-.867-.87.87.87 0 01.867-.872zM7.' +
          '44 2.3l-.003.002a.659.659 0 00-.285.238l-.005.006c-.138.189-.258' +
          '.467-.348.832-.17.692-.216 1.631-.124 2.782.43-.128.899-.208 1.4' +
          '04-.237l.01-.001.019-.034c.046-.082.095-.161.148-.239.123-.771.0' +
          '22-1.692-.253-2.444-.134-.364-.297-.65-.453-.813a.628.628 0 00-.' +
          '107-.09L7.44 2.3zm9.174.04l-.002.001a.628.628 0 00-.107.09c-.156' +
          '.163-.32.45-.453.814-.29.794-.387 1.776-.23 2.572l.058.097.008.0' +
          '14h.03a5.184 5.184 0 011.466.212c.086-1.124.038-2.043-.128-2.722' +
          '-.09-.365-.21-.643-.349-.832l-.004-.006a.659.659 0 00-.285-.239h' +
          '-.004z"/>'#13#10'</svg>'
      end
      item
        IconName = 'DeepSeek'
        SVGText = 
          '<svg viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'  <path d="M23.748 4.4' +
          '82c-.254-.124-.364.113-.512.234-.051.039-.094.09-.137.136-.372.3' +
          '97-.806.657-1.373.626-.829-.046-1.537.214-2.163.848-.133-.782-.5' +
          '75-1.248-1.247-1.548-.352-.156-.708-.311-.955-.65-.172-.241-.219' +
          '-.51-.305-.774-.055-.16-.11-.323-.293-.35-.2-.031-.278.136-.356.' +
          '276-.313.572-.434 1.202-.422 1.84.027 1.436.633 2.58 1.838 3.393' +
          '.137.093.172.187.129.323-.082.28-.18.552-.266.833-.055.179-.137.' +
          '217-.329.14a5.526 5.526 0 01-1.736-1.18c-.857-.828-1.631-1.742-2' +
          '.597-2.458a11.365 11.365 0 00-.689-.471c-.985-.957.13-1.743.388-' +
          '1.836.27-.098.093-.432-.779-.428-.872.004-1.67.295-2.687.684a3.0' +
          '55 3.055 0 01-.465.137 9.597 9.597 0 00-2.883-.102c-1.885.21-3.3' +
          '9 1.102-4.497 2.623C.082 8.606-.231 10.684.152 12.85c.403 2.284 ' +
          '1.569 4.175 3.36 5.653 1.858 1.533 3.997 2.284 6.438 2.14 1.482-' +
          '.085 3.133-.284 4.994-1.86.47.234.962.327 1.78.397.63.059 1.236-' +
          '.03 1.705-.128.735-.156.684-.837.419-.961-2.155-1.004-1.682-.595' +
          '-2.113-.926 1.096-1.296 2.746-2.642 3.392-7.003.05-.347.007-.565' +
          ' 0-.845-.004-.17.035-.237.23-.256a4.173 4.173 0 001.545-.475c1.3' +
          '96-.763 1.96-2.015 2.093-3.517.02-.23-.004-.467-.247-.588zM11.58' +
          '1 18c-2.089-1.642-3.102-2.183-3.52-2.16-.392.024-.321.471-.235.7' +
          '63.09.288.207.486.371.739.114.167.192.416-.113.603-.673.416-1.84' +
          '2-.14-1.897-.167-1.361-.802-2.5-1.86-3.301-3.307-.774-1.393-1.22' +
          '4-2.887-1.298-4.482-.02-.386.093-.522.477-.592a4.696 4.696 0 011' +
          '.529-.039c2.132.312 3.946 1.265 5.468 2.774.868.86 1.525 1.887 2' +
          '.202 2.891.72 1.066 1.494 2.082 2.48 2.914.348.292.625.514.891.6' +
          '77-.802.09-2.14.11-3.054-.614zm1-6.44a.306.306 0 01.415-.287.302' +
          '.302 0 01.2.288.306.306 0 01-.31.307.303.303 0 01-.304-.308zm3.1' +
          '1 1.596c-.2.081-.399.151-.59.16a1.245 1.245 0 01-.798-.254c-.274' +
          '-.23-.47-.358-.552-.758a1.73 1.73 0 01.016-.588c.07-.327-.008-.5' +
          '37-.239-.727-.187-.156-.426-.199-.688-.199a.559.559 0 01-.254-.0' +
          '78c-.11-.054-.2-.19-.114-.358.028-.054.16-.186.192-.21.356-.202.' +
          '767-.136 1.146.016.352.144.618.408 1.001.782.391.451.462.576.685' +
          '.914.176.265.336.537.445.848.067.195-.019.354-.25.452z"/>'#13#10'</svg' +
          '>'#13#10
      end
      item
        IconName = 'OpenAI'
        SVGText = 
          '<svg fill-rule="evenodd" viewBox="0 0 24 24" fill="#e6e6e6">'#13#10'  ' +
          '<path d="M21.55 10.004a5.416 5.416 0 00-.478-4.501c-1.217-2.09-3' +
          '.662-3.166-6.05-2.66A5.59 5.59 0 0010.831 1C8.39.995 6.224 2.546' +
          ' 5.473 4.838A5.553 5.553 0 001.76 7.496a5.487 5.487 0 00.691 6.5' +
          ' 5.416 5.416 0 00.477 4.502c1.217 2.09 3.662 3.165 6.05 2.66A5.5' +
          '86 5.586 0 0013.168 23c2.443.006 4.61-1.546 5.361-3.84a5.553 5.5' +
          '53 0 003.715-2.66 5.488 5.488 0 00-.693-6.497v.001zm-8.381 11.55' +
          '8a4.199 4.199 0 01-2.675-.954c.034-.018.093-.05.132-.074l4.44-2.' +
          '53a.71.71 0 00.364-.623v-6.176l1.877 1.069c.02.01.033.029.036.05' +
          'v5.115c-.003 2.274-1.87 4.118-4.174 4.123zM4.192 17.78a4.059 4.0' +
          '59 0 01-.498-2.763c.032.02.09.055.131.078l4.44 2.53c.225.13.504.' +
          '13.73 0l5.42-3.088v2.138a.068.068 0 01-.027.057L9.9 19.288c-1.99' +
          '9 1.136-4.552.46-5.707-1.51h-.001zM3.023 8.216A4.15 4.15 0 015.1' +
          '98 6.41l-.002.151v5.06a.711.711 0 00.364.624l5.42 3.087-1.876 1.' +
          '07a.067.067 0 01-.063.005l-4.489-2.559c-1.995-1.14-2.679-3.658-1' +
          '.53-5.63h.001zm15.417 3.54l-5.42-3.088L14.896 7.6a.067.067 0 01.' +
          '063-.006l4.489 2.557c1.998 1.14 2.683 3.662 1.529 5.633a4.163 4.' +
          '163 0 01-2.174 1.807V12.38a.71.71 0 00-.363-.623zm1.867-2.773a6.' +
          '04 6.04 0 00-.132-.078l-4.44-2.53a.731.731 0 00-.729 0l-5.42 3.0' +
          '88V7.325a.068.068 0 01.027-.057L14.1 4.713c2-1.137 4.555-.46 5.7' +
          '07 1.513.487.833.664 1.809.499 2.757h.001zm-11.741 3.81l-1.877-1' +
          '.068a.065.065 0 01-.036-.051V6.559c.001-2.277 1.873-4.122 4.181-' +
          '4.12.976 0 1.92.338 2.671.954-.034.018-.092.05-.131.073l-4.44 2.' +
          '53a.71.71 0 00-.365.623l-.003 6.173v.002zm1.02-2.168L12 9.25l2.4' +
          '14 1.375v2.75L12 14.75l-2.415-1.375v-2.75z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Gemini'
        SVGText = 
          '<svg fill-rule="evenodd" viewBox="0 0 24 24"  fill="#e6e6e6">'#13#10' ' +
          ' <path d="M12 24A14.304 14.304 0 000 12 14.304 14.304 0 0012 0a1' +
          '4.305 14.305 0 0012 12 14.305 14.305 0 00-12 12"/>'#13#10'</svg>'
      end
      item
        IconName = 'Print'
        SVGText = 
          '<svg viewBox="0 0 32 32"  fill="#e6e6e6">'#13#10#9'<path d="M26.5,10H25' +
          'V2.5H7V10H5.5C3,10,1,11.9,1,14.5v9h6v6h18v-6h6v-9C31,11.9,28.9,1' +
          '0,26.5,10z M10,5.5h12V10H10V5.5z M22,23.5v3'#13#10#9#9'H10v-6h12V23.5z M' +
          '25,20.5v-3H7v3H4v-6C4,13.7,4.8,13,5.5,13h21c0.9,0,1.5,0.8,1.5,1.' +
          '5v6H25z"/>'#13#10#9'<circle cx="25" cy="15.2" r="1.5"/>'#13#10'</svg>'
      end>
    Left = 184
    Top = 144
  end
  object vilImagesLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'ArrowLeft'
        Name = 'ArrowLeft'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ArrowRight'
        Name = 'ArrowRight'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ChatPlus'
        Name = 'ChatPlus'
      end
      item
        CollectionIndex = 3
        CollectionName = 'ChatRemove'
        Name = 'ChatRemove'
      end
      item
        CollectionIndex = 4
        CollectionName = 'ChatSave'
        Name = 'ChatSave'
      end
      item
        CollectionIndex = 5
        CollectionName = 'ChatTitle'
        Name = 'ChatTitle'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ChatCancel'
        Name = 'ChatCancel'
      end
      item
        CollectionIndex = 7
        CollectionName = 'ChatCopy'
        Name = 'ChatCopy'
      end
      item
        CollectionIndex = 8
        CollectionName = 'CopyNewEditor'
        Name = 'CopyNewEditor'
      end
      item
        CollectionIndex = 9
        CollectionName = 'ChatQuestion'
        Name = 'ChatQuestion'
      end
      item
        CollectionIndex = 10
        CollectionName = 'ChatPaste'
        Name = 'ChatPaste'
      end
      item
        CollectionIndex = 11
        CollectionName = 'UserQuestion'
        Name = 'UserQuestion'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Assistant'
        Name = 'Assistant'
      end
      item
        CollectionIndex = 13
        CollectionName = 'ChatNext'
        Name = 'ChatNext'
      end
      item
        CollectionIndex = 14
        CollectionName = 'ChatPrev'
        Name = 'ChatPrev'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Ollama'
        Name = 'Ollama'
      end
      item
        CollectionIndex = 25
        CollectionName = 'DeepSeek'
        Name = 'DeepSeek'
      end
      item
        CollectionIndex = 26
        CollectionName = 'OpenAI'
        Name = 'OpenAI'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Gemini'
        Name = 'Gemini'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Print'
        Name = 'Print'
      end>
    ImageCollection = icMenuAndToolbar
    Width = 24
    Height = 24
    Left = 176
    Top = 248
  end
  object vilImagesDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'ArrowLeft'
        Name = 'ArrowLeft'
      end
      item
        CollectionIndex = 1
        CollectionName = 'ArrowRight'
        Name = 'ArrowRight'
      end
      item
        CollectionIndex = 15
        CollectionName = 'ChatPlus'
        Name = 'ChatPlus'
      end
      item
        CollectionIndex = 16
        CollectionName = 'ChatRemove'
        Name = 'ChatRemove'
      end
      item
        CollectionIndex = 17
        CollectionName = 'ChatSave'
        Name = 'ChatSave'
      end
      item
        CollectionIndex = 18
        CollectionName = 'ChatTitle'
        Name = 'ChatTitle'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ChatCancel'
        Name = 'ChatCancel'
      end
      item
        CollectionIndex = 7
        CollectionName = 'ChatCopy'
        Name = 'ChatCopy'
      end
      item
        CollectionIndex = 8
        CollectionName = 'CopyNewEditor'
        Name = 'CopyNewEditor'
      end
      item
        CollectionIndex = 21
        CollectionName = 'ChatQuestion'
        Name = 'ChatQuestion'
      end
      item
        CollectionIndex = 10
        CollectionName = 'ChatPaste'
        Name = 'ChatPaste'
      end
      item
        CollectionIndex = 22
        CollectionName = 'UserQuestion'
        Name = 'UserQuestion'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Assistant'
        Name = 'Assistant'
      end
      item
        CollectionIndex = 19
        CollectionName = 'ChatNext'
        Name = 'ChatNext'
      end
      item
        CollectionIndex = 20
        CollectionName = 'ChatPrev'
        Name = 'ChatPrev'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Ollama'
        Name = 'Ollama'
      end
      item
        CollectionIndex = 30
        CollectionName = 'DeepSeek'
        Name = 'DeepSeek'
      end
      item
        CollectionIndex = 31
        CollectionName = 'OpenAI'
        Name = 'OpenAI'
      end
      item
        CollectionIndex = 32
        CollectionName = 'Gemini'
        Name = 'Gemini'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Print'
        Name = 'Print'
      end>
    ImageCollection = icMenuAndToolbar
    Width = 24
    Height = 24
    Left = 288
    Top = 248
  end
end
