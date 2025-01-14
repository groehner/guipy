inherited PythonIIForm: TPythonIIForm
  Left = 259
  Top = 201
  HelpContext = 410
  Caption = 'Python Interpreter'
  ClientHeight = 343
  ClientWidth = 629
  StyleElements = []
  OnHelp = FormHelp
  ExplicitWidth = 645
  ExplicitHeight = 382
  TextHeight = 15
  inherited BGPanel: TPanel
    Width = 629
    Height = 343
    StyleElements = []
    ExplicitWidth = 629
    ExplicitHeight = 343
    inherited FGPanel: TPanel
      Width = 625
      Height = 339
      Color = clInactiveBorder
      StyleElements = []
      ExplicitWidth = 625
      ExplicitHeight = 339
      object SynEdit: TSynEdit
        Left = 0
        Top = 0
        Width = 625
        Height = 339
        HelpContext = 410
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        PopupMenu = InterpreterPopUp
        TabOrder = 0
        OnDblClick = SynEditDblClick
        OnEnter = SynEditEnter
        OnExit = SynEditExit
        OnMouseDown = SynEditMouseDown
        UseCodeFolding = False
        BorderStyle = bsNone
        Gutter.BorderStyle = gbsNone
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Consolas'
        Gutter.Font.Style = []
        Gutter.Font.Quality = fqClearTypeNatural
        Gutter.Visible = False
        Gutter.Gradient = True
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
            Kind = gbkMargin
            Width = 3
          end>
        Options = [eoDragDropEditing, eoEnhanceHomeKey, eoGroupUndo, eoHideShowScrollbars, eoKeepCaretX, eoShowScrollHint, eoTabIndent, eoTabsToSpaces]
        RightEdge = 0
        ScrollbarAnnotations = <
          item
            AnnType = sbaCarets
            AnnPos = sbpFullWidth
            FullRow = False
          end>
        SelectedColor.Alpha = 0.400000005960464500
        TabWidth = 4
        VisibleSpecialChars = []
        WantTabs = True
        WordWrap = True
        OnCommandProcessed = SynEditCommandProcessed
        OnProcessCommand = SynEditProcessCommand
        OnProcessUserCommand = SynEditProcessUserCommand
      end
    end
  end
  inherited DockClient: TJvDockClient
    Left = 40
  end
  object PythonIO: TPythonInputOutput
    UnicodeIO = False
    RawOutput = False
    Left = 40
    Top = 273
  end
  object InterpreterPopUp: TSpTBXPopupMenu
    Images = vilImages
    Left = 37
    Top = 60
    object mnPythonVersions: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Python Versions'
      ImageIndex = 5
      ImageName = 'Python'
      LinkSubitems = PyIDEMainForm.mnPythonVersions
    end
    object TBXPythonEngines: TSpTBXSubmenuItem
      Caption = 'Python Engine'
      LinkSubitems = PyIDEMainForm.mnPythonEngines
    end
    object TBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object mnEditCut: TSpTBXItem
      Action = CommandsDataModule.actEditCut
      ImageIndex = 0
    end
    object mnEditCopy: TSpTBXItem
      Action = CommandsDataModule.actEditCopy
      ImageIndex = 1
    end
    object mnEditPaste: TSpTBXItem
      Action = CommandsDataModule.actEditPaste
      ImageIndex = 2
    end
    object TBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object mnCopyNoPrompts: TSpTBXItem
      Action = actCopyWithoutPrompts
    end
    object mnPasteWithPrompts: TSpTBXItem
      Action = actPasteAndExecute
    end
    object mnCopyHistory: TSpTBXItem
      Action = actCopyHistory
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object mnClearAll: TSpTBXItem
      Action = actClearContents
    end
    object TBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object mnInterpreterEditorOptions: TSpTBXItem
      Action = CommandsDataModule.actInterpreterEditorOptions
    end
    object mnReinitialzePython: TSpTBXItem
      Action = PyIDEMainForm.actPythonReinitialize
    end
  end
  object InterpreterActionList: TActionList
    Images = vilImages
    Left = 40
    Top = 109
    object actCopyHistory: TAction
      Category = 'Interpreter'
      Caption = 'Copy &History'
      HelpContext = 410
      Hint = 'Copy history to Clipboard'
      ImageIndex = 1
      ImageName = 'Copy'
      OnExecute = actCopyHistoryExecute
    end
    object actClearContents: TAction
      Category = 'Interpreter'
      Caption = 'Clear &All'
      HelpContext = 410
      Hint = 'Clear all interpreter output'
      ImageIndex = 3
      ImageName = 'Delete'
      OnExecute = actClearContentsExecute
    end
    object actCopyWithoutPrompts: TAction
      Category = 'Interpreter'
      Caption = 'Copy (&No Prompts)'
      HelpContext = 410
      Hint = 'Copy selected text without the interpreter prompts'
      ImageIndex = 1
      ImageName = 'Copy'
      ShortCut = 24643
      OnExecute = actCopyWithoutPromptsExecute
    end
    object actPasteAndExecute: TAction
      Category = 'Interpreter'
      Caption = 'Paste && E&xecute'
      HelpContext = 410
      Hint = 'Paste clipboard text with added interpreter prompts'
      ImageIndex = 2
      ImageName = 'Paste'
      ShortCut = 24662
      OnExecute = actPasteAndExecuteExecute
    end
  end
  object vilCodeImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 8
        CollectionName = 'CodeImages\Python'
        Name = 'Python'
      end
      item
        CollectionIndex = 9
        CollectionName = 'CodeImages\Variable'
        Name = 'Variable'
      end
      item
        CollectionIndex = 1
        CollectionName = 'CodeImages\Field'
        Name = 'Field'
      end
      item
        CollectionIndex = 2
        CollectionName = 'CodeImages\Function'
        Name = 'Function'
      end
      item
        CollectionIndex = 5
        CollectionName = 'CodeImages\Method'
        Name = 'Method'
      end
      item
        CollectionIndex = 0
        CollectionName = 'CodeImages\Class'
        Name = 'Class'
      end
      item
        CollectionIndex = 7
        CollectionName = 'CodeImages\Namespace'
        Name = 'Namespace'
      end
      item
        CollectionIndex = 4
        CollectionName = 'CodeImages\List'
        Name = 'List'
      end
      item
        CollectionIndex = 6
        CollectionName = 'CodeImages\Module'
        Name = 'Module'
      end
      item
        CollectionIndex = 3
        CollectionName = 'CodeImages\Keyword'
        Name = 'Keyword'
      end>
    ImageCollection = ResourcesDataModule.icCodeImages
    PreserveItems = True
    Left = 40
    Top = 160
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 17
        CollectionName = 'Cut'
        Name = 'Cut'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 65
        CollectionName = 'Paste'
        Name = 'Paste'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 27
        CollectionName = 'EditOptions'
        Name = 'EditOptions'
      end
      item
        CollectionIndex = 84
        CollectionName = 'Python'
        Name = 'Python'
      end
      item
        CollectionIndex = 81
        CollectionName = 'PySetup'
        Name = 'PySetup'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Width = 20
    Height = 20
    Left = 40
    Top = 216
  end
end
