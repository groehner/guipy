object FClassEditor: TFClassEditor
  Left = 280
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'UML class editor'
  ClientHeight = 446
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poDesigned
  OnAfterMonitorDpiChanged = FormAfterMonitorDpiChanged
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object LClass: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 15
    Caption = 'Class'
  end
  object TreeView: TTreeView
    Left = 13
    Top = 27
    Width = 323
    Height = 418
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HideSelection = False
    Indent = 24
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TabStop = False
    OnChange = TreeViewChange
    OnDragDrop = TreeViewDragDrop
    OnDragOver = TreeViewDragOver
  end
  object PageControl: TPageControl
    Left = 338
    Top = 10
    Width = 364
    Height = 435
    ActivePage = TSAttributes
    TabOrder = 0
    OnChange = PageControlChange
    object TSClass: TTabSheet
      Caption = '&Class'
      object LClassName: TLabel
        Left = 8
        Top = 20
        Width = 32
        Height = 15
        Caption = 'Name'
      end
      object LExtends: TLabel
        Left = 8
        Top = 52
        Width = 41
        Height = 15
        Caption = 'Extends'
      end
      object EClass: TEdit
        Left = 96
        Top = 16
        Width = 129
        Height = 23
        TabOrder = 0
        OnKeyPress = EClassKeyPress
      end
      object BClassClose: TButton
        Left = 272
        Top = 375
        Width = 80
        Height = 25
        Action = ActionClose
        ModalResult = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object EExtends: TEdit
        Left = 96
        Top = 48
        Width = 129
        Height = 23
        TabOrder = 1
        OnKeyPress = EClassKeyPress
      end
      object BClassApply: TButton
        Left = 96
        Top = 375
        Width = 80
        Height = 25
        Action = ActionApply
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object BClassNew: TButton
        Left = 8
        Top = 375
        Width = 80
        Height = 25
        Action = ActionNew
        TabOrder = 4
      end
      object CBClassInner: TCheckBox
        Left = 96
        Top = 80
        Width = 97
        Height = 17
        Caption = 'inner'
        TabOrder = 5
      end
    end
    object TSAttributes: TTabSheet
      Caption = '&Attributes'
      ImageIndex = 1
      object LAttributeName: TLabel
        Left = 8
        Top = 153
        Width = 32
        Height = 15
        Caption = 'Name'
      end
      object LAttributeType: TLabel
        Left = 8
        Top = 187
        Width = 24
        Height = 15
        Caption = 'Type'
      end
      object LAttributeValue: TLabel
        Left = 8
        Top = 223
        Width = 28
        Height = 15
        Caption = 'Value'
      end
      object RGAttributeAccess: TRadioGroup
        Left = 64
        Top = 16
        Width = 100
        Height = 115
        Caption = 'Visibility'
        ItemIndex = 0
        Items.Strings = (
          'private'
          'protected'
          'public')
        TabOrder = 0
      end
      object CBAttributeType: TComboBox
        Left = 64
        Top = 184
        Width = 225
        Height = 23
        AutoDropDown = True
        Sorted = True
        TabOrder = 3
        OnCloseUp = ComboBoxCloseUp
        OnDropDown = CBAttributeTypeDropDown
        OnEnter = CBComboBoxEnter
        OnKeyDown = ComboBoxKeyDown
        OnKeyPress = CBAttributeTypeKeyPress
        OnKeyUp = CBAttributeTypeKeyUp
        OnSelect = CBAttributeTypeSelect
        Items.Strings = (
          'boolean'
          'dict'
          'float'
          'integer'
          'list'
          'None'
          'set'
          'str'
          'String'
          'tuple')
      end
      object BAttributeDelete: TButton
        Left = 184
        Top = 375
        Width = 80
        Height = 25
        Action = ActionDelete
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object BAttributeNew: TButton
        Left = 8
        Top = 375
        Width = 80
        Height = 25
        Action = ActionNew
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object GBAttributeOptions: TGroupBox
        Left = 176
        Top = 16
        Width = 113
        Height = 115
        Caption = 'Options'
        TabOrder = 1
        object CBSetMethod: TCheckBox
          Left = 8
          Top = 90
          Width = 95
          Height = 17
          Caption = 'set method'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CBGetMethod: TCheckBox
          Left = 8
          Top = 66
          Width = 95
          Height = 17
          Caption = 'get method'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object CBAttributeStatic: TCheckBox
          Left = 8
          Top = 18
          Width = 78
          Height = 17
          Caption = 'static'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CBAttributeFinal: TCheckBox
          Left = 8
          Top = 42
          Width = 78
          Height = 17
          Caption = 'final'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object EAttributeName: TEdit
        Left = 64
        Top = 149
        Width = 225
        Height = 23
        TabOrder = 2
        OnKeyPress = EAttributeNameKeyPress
        OnKeyUp = EAttributeNameKeyUp
      end
      object BAttributeClose: TButton
        Left = 272
        Top = 375
        Width = 80
        Height = 25
        Action = ActionClose
        ModalResult = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object BAttributeApply: TButton
        Left = 96
        Top = 375
        Width = 80
        Height = 25
        Action = ActionApply
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object CBAttributeValue: TComboBox
        Left = 64
        Top = 220
        Width = 225
        Height = 23
        TabOrder = 4
        OnCloseUp = ComboBoxCloseUp
        OnDropDown = CBAttributeValueDropDown
        OnEnter = CBComboBoxEnter
        OnKeyDown = ComboBoxKeyDown
        OnKeyPress = CBAttributeValueKeyPress
        OnKeyUp = CBAttributeValueKeyUp
        OnSelect = CBAttributeValueSelect
        Items.Strings = (
          '0'
          '0.0'
          #39#39
          'True'
          'False'
          'None'
          '[]'
          '()'
          '{}'
          'set()')
      end
    end
    object TSMethods: TTabSheet
      Caption = '&Methods'
      ImageIndex = 2
      object LMethodName: TLabel
        Left = 8
        Top = 140
        Width = 32
        Height = 15
        Caption = 'Name'
      end
      object LMethodType: TLabel
        Left = 8
        Top = 166
        Width = 24
        Height = 15
        Caption = 'Type'
      end
      object CBMethodType: TComboBox
        Left = 64
        Top = 163
        Width = 162
        Height = 23
        AutoDropDown = True
        Sorted = True
        TabOrder = 4
        OnCloseUp = ComboBoxCloseUp
        OnDropDown = CBMethodTypeDropDown
        OnEnter = CBComboBoxEnter
        OnKeyDown = ComboBoxKeyDown
        OnKeyPress = CBMethodTypeKeyPress
        OnKeyUp = CBMethodParamTypeKeyUp
        OnSelect = CBMethodTypeSelect
        Items.Strings = (
          'boolean'
          'dict'
          'float'
          'integer'
          'list'
          'None'
          'set'
          'str'
          'String'
          'tuple')
      end
      object RGMethodAccess: TRadioGroup
        Left = 160
        Top = 16
        Width = 90
        Height = 105
        Caption = 'Visibility'
        ItemIndex = 2
        Items.Strings = (
          'private'
          'protected'
          'public')
        TabOrder = 1
      end
      object GBMethodOptions: TGroupBox
        Left = 256
        Top = 16
        Width = 88
        Height = 105
        Caption = 'Options'
        TabOrder = 2
        object CBMethodStatic: TCheckBox
          Left = 8
          Top = 20
          Width = 57
          Height = 17
          Caption = 'static'
          TabOrder = 0
        end
        object CBMethodAbstract: TCheckBox
          Left = 8
          Top = 78
          Width = 81
          Height = 17
          Caption = 'abstract'
          TabOrder = 1
        end
        object CBMethodClass: TCheckBox
          Left = 8
          Top = 49
          Width = 97
          Height = 17
          Caption = 'class'
          TabOrder = 2
        end
      end
      object BMethodNew: TButton
        Left = 8
        Top = 375
        Width = 80
        Height = 25
        Action = ActionNew
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object BMethodDelete: TButton
        Left = 184
        Top = 375
        Width = 80
        Height = 25
        Action = ActionDelete
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object RGMethodKind: TRadioGroup
        Left = 3
        Top = 16
        Width = 151
        Height = 105
        Caption = 'Kind'
        Items.Strings = (
          'constructor'
          'with return value'
          'without return value')
        TabOrder = 0
      end
      object GRFormalParameters: TGroupBox
        Left = 8
        Top = 208
        Width = 337
        Height = 161
        Caption = 'formal parameters'
        TabOrder = 5
        object LParameterName: TLabel
          Left = 13
          Top = 32
          Width = 32
          Height = 15
          Caption = 'Name'
        end
        object LParameterType: TLabel
          Left = 13
          Top = 64
          Width = 24
          Height = 15
          Caption = 'Type'
        end
        object SBUp: TSpeedButton
          Left = 310
          Top = 33
          Width = 18
          Height = 18
          ImageIndex = 4
          ImageName = '04'
          Images = ILClassEditor
          OnClick = SBUpClick
        end
        object SBDelete: TSpeedButton
          Left = 310
          Top = 60
          Width = 18
          Height = 19
          ImageIndex = 1
          ImageName = '01'
          Images = ILClassEditor
          OnClick = SBDeleteClick
        end
        object SBDown: TSpeedButton
          Left = 310
          Top = 90
          Width = 18
          Height = 18
          ImageIndex = 5
          ImageName = '05'
          Images = ILClassEditor
          OnClick = SBDownClick
        end
        object SBRight: TSpeedButton
          Left = 175
          Top = 48
          Width = 18
          Height = 18
          ImageIndex = 3
          ImageName = '03'
          Images = ILClassEditor
          OnClick = SBRightClick
        end
        object SBLeft: TSpeedButton
          Left = 176
          Top = 80
          Width = 18
          Height = 18
          ImageIndex = 2
          ImageName = '02'
          Images = ILClassEditor
          OnClick = SBLeftClick
        end
        object LParameterValue: TLabel
          Left = 13
          Top = 96
          Width = 28
          Height = 15
          Caption = 'Value'
        end
        object CBParamType: TComboBox
          Left = 57
          Top = 61
          Width = 113
          Height = 23
          AutoDropDown = True
          Sorted = True
          TabOrder = 1
          OnCloseUp = ComboBoxCloseUp
          OnDropDown = CBParamTypeDropDown
          OnEnter = CBComboBoxEnter
          OnKeyDown = ComboBoxKeyDown
          OnKeyPress = CBParamTypeKeyPress
          OnKeyUp = CBMethodParamTypeKeyUp
          OnSelect = CBParamTypeSelect
          Items.Strings = (
            'boolean'
            'dict'
            'float'
            'integer'
            'list'
            'None'
            'set'
            'str'
            'String'
            'tuple')
        end
        object BParameterNew: TButton
          Left = 178
          Top = 126
          Width = 75
          Height = 25
          Caption = 'New'
          TabOrder = 5
          OnClick = BParameterNewClick
        end
        object LBParams: TListBox
          Left = 200
          Top = 29
          Width = 104
          Height = 85
          TabStop = False
          ItemHeight = 15
          TabOrder = 4
          OnKeyUp = LBParamsKeyUp
        end
        object CBParamName: TComboBox
          Left = 56
          Top = 32
          Width = 113
          Height = 23
          Sorted = True
          TabOrder = 0
          OnKeyDown = ComboBoxKeyDown
          OnKeyPress = CBParamNameKeyPress
          OnKeyUp = CBParamNameKeyUp
          OnSelect = CBParamNameSelect
        end
        object CBParameter: TComboBox
          Left = 15
          Top = 128
          Width = 157
          Height = 23
          AutoDropDown = True
          TabOrder = 3
          Text = 'Select attribute'
          OnEnter = CBComboBoxEnter
          OnKeyDown = ComboBoxKeyDown
          OnKeyPress = CBParameterKeyPress
          OnSelect = CBParameterSelect
        end
        object BParameterDelete: TButton
          Left = 259
          Top = 126
          Width = 75
          Height = 25
          Caption = 'Delete'
          TabOrder = 6
          OnClick = BParameterDeleteClick
        end
        object CBParamValue: TComboBox
          Left = 57
          Top = 93
          Width = 113
          Height = 23
          TabOrder = 2
          OnCloseUp = ComboBoxCloseUp
          OnEnter = CBComboBoxEnter
          OnKeyDown = ComboBoxKeyDown
          Items.Strings = (
            '0'
            '0.0'
            #39#39
            'True'
            'False'
            'None'
            '[]'
            '()'
            '{}')
        end
      end
      object BMethodClose: TButton
        Left = 272
        Top = 375
        Width = 80
        Height = 25
        Action = ActionClose
        ModalResult = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
      end
      object CBMethodname: TComboBox
        Left = 64
        Top = 136
        Width = 162
        Height = 23
        Sorted = True
        TabOrder = 3
        OnKeyDown = ComboBoxKeyDown
        OnKeyPress = CBMethodnameKeyPress
        OnKeyUp = CBMethodnameKeyUp
        OnSelect = CBMethodnameSelect
      end
      object BMethodApply: TButton
        Left = 96
        Top = 375
        Width = 80
        Height = 25
        Action = ActionApply
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
    end
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 48
    Top = 48
    object ActionNew: TAction
      Caption = '&New'
      ShortCut = 16462
      OnExecute = ActionNewExecute
    end
    object ActionDelete: TAction
      Caption = '&Delete'
      ShortCut = 16460
      OnExecute = ActionDeleteExecute
    end
    object ActionClose: TAction
      Caption = '&Close'
      ShortCut = 16467
      OnExecute = ActionCloseExecute
    end
    object ActionApply: TAction
      Caption = '&Apply'
      ShortCut = 16469
      OnExecute = ActionApplyExecute
    end
  end
  object ILClassEditor: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '00'
        Name = '00'
      end
      item
        CollectionIndex = 1
        CollectionName = '01'
        Name = '01'
      end
      item
        CollectionIndex = 2
        CollectionName = '02'
        Name = '02'
      end
      item
        CollectionIndex = 3
        CollectionName = '03'
        Name = '03'
      end
      item
        CollectionIndex = 4
        CollectionName = '04'
        Name = '04'
      end
      item
        CollectionIndex = 5
        CollectionName = '05'
        Name = '05'
      end>
    ImageCollection = icClassEditor
    Width = 18
    Height = 18
    Left = 144
    Top = 48
  end
  object icClassEditor: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = '00'
        SVGText = 
          '<svg viewBox="0 -0.5 13 13" >'#13#10'<path stroke="#1e1e1e" d="M0 0h3M' +
          '12 0h1M0 1h4M10 1h2M1 2h4M9 2h2M3 3h3M8 3h2M4 4h5M5 5h3M4 6h5M3 ' +
          '7h3M8 7h2M2 8h3M9 8h2M1 9h3M10 9h1M0 10h4M11 10h1M0 11h3M1 12h1M' +
          '12 12h1" />'#13#10'</svg>'
      end
      item
        IconName = '01'
        SVGText = 
          '<svg viewBox="0 -0.5 13 13">'#13#10'<path stroke="#e1e1e1" d="M0 0h3M1' +
          '2 0h1M0 1h4M10 1h2M1 2h4M9 2h2M3 3h3M8 3h2M4 4h5M5 5h3M4 6h5M3 7' +
          'h3M8 7h2M2 8h3M9 8h2M1 9h3M10 9h1M0 10h4M11 10h1M0 11h3M1 12h1M1' +
          '2 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '02'
        SVGText = 
          '<svg viewBox="0 -0.5 13 13">'#13#10'<path stroke="#d0d8cc" d="M6 1h1" ' +
          '/>'#13#10'<path stroke="#9ebe9e" d="M7 1h1M6 2h1" />'#13#10'<path stroke="#d' +
          '1dbcd" d="M5 2h1" />'#13#10'<path stroke="#606f50" d="M7 2h1" />'#13#10'<pat' +
          'h stroke="#d2dbce" d="M4 3h1" />'#13#10'<path stroke="#aec69e" d="M5 3' +
          'h1M4 4h1" />'#13#10'<path stroke="#ceefbe" d="M6 3h1M3 6h1" />'#13#10'<path ' +
          'stroke="#515850" d="M7 3h1" />'#13#10'<path stroke="#d3ddd0" d="M3 4h1' +
          '" />'#13#10'<path stroke="#cef7be" d="M5 4h1M4 5h1" />'#13#10'<path stroke="' +
          '#bee7ae" d="M6 4h1M5 5h1" />'#13#10'<path stroke="#425842" d="M7 4h1" ' +
          '/>'#13#10'<path stroke="#8ea68e" d="M8 4h1" />'#13#10'<path stroke="#8e9e7e"' +
          ' d="M9 4h2" />'#13#10'<path stroke="#7f967e" d="M11 4h1" />'#13#10'<path str' +
          'oke="#d4ddd0" d="M2 5h1" />'#13#10'<path stroke="#aece9e" d="M3 5h1" /' +
          '>'#13#10'<path stroke="#aedf8e" d="M6 5h1M5 6h1" />'#13#10'<path stroke="#be' +
          'df9e" d="M7 5h1" />'#13#10'<path stroke="#aed69e" d="M8 5h1" />'#13#10'<path' +
          ' stroke="#9ec68e" d="M9 5h1" />'#13#10'<path stroke="#8ebe8e" d="M10 5' +
          'h1" />'#13#10'<path stroke="#424942" d="M11 5h1M7 8h1" />'#13#10'<path strok' +
          'e="#9eb68e" d="M2 6h1" />'#13#10'<path stroke="#beefae" d="M4 6h1" />'#13 +
          #10'<path stroke="#9ed68e" d="M6 6h1M5 7h1" />'#13#10'<path stroke="#8ec6' +
          '7e" d="M7 6h1" />'#13#10'<path stroke="#7fb66f" d="M8 6h1" />'#13#10'<path s' +
          'troke="#6fae60" d="M9 6h1" />'#13#10'<path stroke="#608650" d="M10 6h1' +
          '" />'#13#10'<path stroke="#334233" d="M11 6h1M8 8h1M7 9h1M6 10h2" />'#13#10 +
          '<path stroke="#c1c5bd" d="M2 7h1" />'#13#10'<path stroke="#516750" d="' +
          'M3 7h1" />'#13#10'<path stroke="#7fa66f" d="M4 7h1M6 8h1" />'#13#10'<path st' +
          'roke="#8ebe6f" d="M6 7h1" />'#13#10'<path stroke="#7fa660" d="M7 7h1" ' +
          '/>'#13#10'<path stroke="#6f9660" d="M8 7h1M5 8h1" />'#13#10'<path stroke="#6' +
          '08e50" d="M9 7h1" />'#13#10'<path stroke="#517e42" d="M10 7h1" />'#13#10'<pa' +
          'th stroke="#333a33" d="M11 7h1M9 8h1M7 11h1" />'#13#10'<path stroke="#' +
          'cecec7" d="M3 8h1" />'#13#10'<path stroke="#516050" d="M4 8h1" />'#13#10'<pa' +
          'th stroke="#252c25" d="M10 8h1" />'#13#10'<path stroke="#252525" d="M1' +
          '1 8h1" />'#13#10'<path stroke="#ccccc5" d="M4 9h1" />'#13#10'<path stroke="#' +
          '607760" d="M5 9h1" />'#13#10'<path stroke="#607e50" d="M6 9h1" />'#13#10'<pa' +
          'th stroke="#c5c5c0" d="M5 10h1" />'#13#10'<path stroke="#c4c4c0" d="M6' +
          ' 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '03'
        SVGText = 
          '<svg viewBox="0 -0.5 13 13">'#13#10'<path stroke="#7f8e7e" d="M6 1h1M6' +
          ' 2h1M6 3h1" />'#13#10'<path stroke="#c4c4c0" d="M7 1h1" />'#13#10'<path stro' +
          'ke="#252525" d="M7 2h1M8 3h1M9 4h1M10 5h1" />'#13#10'<path stroke="#a7' +
          'aaa2" d="M8 2h1" />'#13#10'<path stroke="#517742" d="M7 3h1M8 4h1M9 5h' +
          '1" />'#13#10'<path stroke="#aaaea6" d="M9 3h1" />'#13#10'<path stroke="#7f96' +
          '7e" d="M2 4h1M10 7h1M6 8h1M9 8h1M8 9h1M7 10h1" />'#13#10'<path stroke=' +
          '"#252c25" d="M3 4h1" />'#13#10'<path stroke="#333a33" d="M4 4h1" />'#13#10'<' +
          'path stroke="#334233" d="M5 4h1" />'#13#10'<path stroke="#424942" d="M' +
          '6 4h1" />'#13#10'<path stroke="#608e50" d="M7 4h1M10 6h1" />'#13#10'<path st' +
          'roke="#a9ada4" d="M10 4h1" />'#13#10'<path stroke="#8e9e7e" d="M2 5h1M' +
          '5 8h1M6 9h1" />'#13#10'<path stroke="#bee7ae" d="M3 5h1M5 7h1M7 8h1" /' +
          '>'#13#10'<path stroke="#7fae6f" d="M4 5h1M9 7h1" />'#13#10'<path stroke="#7f' +
          'a66f" d="M5 5h1" />'#13#10'<path stroke="#6f9e60" d="M6 5h1" />'#13#10'<path' +
          ' stroke="#6f9660" d="M7 5h1" />'#13#10'<path stroke="#6fa660" d="M8 5h' +
          '1M9 6h1" />'#13#10'<path stroke="#a8aba3" d="M11 5h1" />'#13#10'<path stroke' +
          '="#8ea68e" d="M2 6h1M4 8h1M6 10h1" />'#13#10'<path stroke="#beefae" d=' +
          '"M3 6h1M4 7h1" />'#13#10'<path stroke="#aedf8e" d="M4 6h1" />'#13#10'<path s' +
          'troke="#9ed68e" d="M5 6h1" />'#13#10'<path stroke="#9ece7e" d="M6 6h1"' +
          ' />'#13#10'<path stroke="#8ebe6f" d="M7 6h1M8 7h1" />'#13#10'<path stroke="#' +
          '7fb66f" d="M8 6h1" />'#13#10'<path stroke="#607760" d="M11 6h1" />'#13#10'<p' +
          'ath stroke="#9eb68e" d="M2 7h1M3 8h1M6 11h1" />'#13#10'<path stroke="#' +
          'ceefae" d="M3 7h1" />'#13#10'<path stroke="#bee79e" d="M6 7h1" />'#13#10'<pa' +
          'th stroke="#aedf9e" d="M7 7h1" />'#13#10'<path stroke="#c7cbbc" d="M11' +
          ' 7h1" />'#13#10'<path stroke="#9ebe8e" d="M2 8h1" />'#13#10'<path stroke="#8' +
          'ec67e" d="M8 8h1" />'#13#10'<path stroke="#c8cdbe" d="M10 8h1" />'#13#10'<pa' +
          'th stroke="#bedf9e" d="M7 9h1" />'#13#10'<path stroke="#c9cebf" d="M9 ' +
          '9h1" />'#13#10'<path stroke="#cacfc0" d="M8 10h1" />'#13#10'<path stroke="#d' +
          '0d9cc" d="M7 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '04'
        SVGText = 
          '<svg viewBox="0 -0.5 13 13">'#13#10'<path stroke="#c2cde2" d="M5 2h1" ' +
          '/>'#13#10'<path stroke="#6f96df" d="M6 2h1M3 5h1M2 6h1" />'#13#10'<path stro' +
          'ke="#c1c7d2" d="M7 2h1" />'#13#10'<path stroke="#c3cee3" d="M4 3h1" />' +
          #13#10'<path stroke="#6f9eef" d="M5 3h1M4 4h1" />'#13#10'<path stroke="#9eb' +
          'eff" d="M6 3h1M5 4h1M4 5h1M5 7h1" />'#13#10'<path stroke="#33589e" d="' +
          'M7 3h1" />'#13#10'<path stroke="#c0c6cf" d="M8 3h1" />'#13#10'<path stroke="' +
          '#c4cfe5" d="M3 4h1" />'#13#10'<path stroke="#8eaeff" d="M6 4h1M5 5h1M5' +
          ' 6h1" />'#13#10'<path stroke="#6086df" d="M7 4h1M7 7h1M6 8h1M5 9h1" />' +
          #13#10'<path stroke="#33509e" d="M8 4h1M9 5h1M5 10h1" />'#13#10'<path strok' +
          'e="#bec4ce" d="M9 4h1" />'#13#10'<path stroke="#c5d0e5" d="M2 5h1" />'#13 +
          #10'<path stroke="#6f9eff" d="M6 5h1" />'#13#10'<path stroke="#608eef" d=' +
          '"M7 5h1" />'#13#10'<path stroke="#4277ce" d="M8 5h1" />'#13#10'<path stroke=' +
          '"#bdc3cc" d="M10 5h1" />'#13#10'<path stroke="#426fce" d="M3 6h1" />'#13#10 +
          '<path stroke="#3367ce" d="M4 6h1" />'#13#10'<path stroke="#6096ef" d="' +
          'M6 6h2M6 7h1" />'#13#10'<path stroke="#3358ae" d="M8 6h1" />'#13#10'<path st' +
          'roke="#25509e" d="M9 6h1M8 7h1" />'#13#10'<path stroke="#25498e" d="M1' +
          '0 6h1M8 9h1M6 10h3" />'#13#10'<path stroke="#517edf" d="M4 7h1M4 8h1M4' +
          ' 9h1M4 10h1" />'#13#10'<path stroke="#7fa6ef" d="M5 8h1" />'#13#10'<path str' +
          'oke="#5177ce" d="M7 8h1" />'#13#10'<path stroke="#25499e" d="M8 8h1" /' +
          '>'#13#10'<path stroke="#517ece" d="M6 9h1" />'#13#10'<path stroke="#426fbe" ' +
          'd="M7 9h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = '05'
        SVGText = 
          '<svg viewBox="0 -0.5 13 13">'#13#10'<path stroke="#6f9eef" d="M4 2h1M2' +
          ' 6h1" />'#13#10'<path stroke="#6f96df" d="M5 2h1M4 3h1M3 6h1" />'#13#10'<pat' +
          'h stroke="#6f8edf" d="M6 2h1M4 4h1M4 6h1" />'#13#10'<path stroke="#608' +
          '6ce" d="M7 2h2M4 5h1" />'#13#10'<path stroke="#9ebeff" d="M5 3h1M5 4h1' +
          '" />'#13#10'<path stroke="#8eb6ff" d="M6 3h1" />'#13#10'<path stroke="#8eaef' +
          'f" d="M7 3h1" />'#13#10'<path stroke="#516fbe" d="M8 3h1" />'#13#10'<path st' +
          'roke="#7fa6ff" d="M6 4h1M5 6h1" />'#13#10'<path stroke="#608eef" d="M7' +
          ' 4h1M6 6h1" />'#13#10'<path stroke="#4267ae" d="M8 4h1M10 6h1" />'#13#10'<pa' +
          'th stroke="#7faeff" d="M5 5h1" />'#13#10'<path stroke="#608eff" d="M6 ' +
          '5h1" />'#13#10'<path stroke="#5186ef" d="M7 5h1" />'#13#10'<path stroke="#42' +
          '60ae" d="M8 5h1M9 6h1" />'#13#10'<path stroke="#517edf" d="M7 6h1M5 8h' +
          '1" />'#13#10'<path stroke="#33509e" d="M8 6h1M9 7h1M8 8h1" />'#13#10'<path s' +
          'troke="#5177be" d="M3 7h1" />'#13#10'<path stroke="#6f96ef" d="M4 7h1"' +
          ' />'#13#10'<path stroke="#6f9eff" d="M5 7h1" />'#13#10'<path stroke="#5186df' +
          '" d="M6 7h1" />'#13#10'<path stroke="#5177ce" d="M7 7h1" />'#13#10'<path str' +
          'oke="#4267be" d="M8 7h1M7 8h1M6 9h1" />'#13#10'<path stroke="#bdc3cc" ' +
          'd="M10 7h1" />'#13#10'<path stroke="#3358ae" d="M4 8h1M5 9h1M6 10h1" /' +
          '>'#13#10'<path stroke="#5177df" d="M6 8h1" />'#13#10'<path stroke="#bec4ce" ' +
          'd="M9 8h1" />'#13#10'<path stroke="#d2d5df" d="M4 9h1" />'#13#10'<path strok' +
          'e="#33589e" d="M7 9h1" />'#13#10'<path stroke="#c0c6cf" d="M8 9h1" />'#13 +
          #10'<path stroke="#d1d4dd" d="M5 10h1" />'#13#10'<path stroke="#c1c7d2" d' +
          '="M7 10h1" />'#13#10'</svg>'#13#10
      end>
    Left = 240
    Top = 48
  end
  object icClassTreeView: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'EditClass'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#10'<path stroke="#e1e1e1e1" d="M2 1h11' +
          'M1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h' +
          '1M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M1' +
          '3 11h1M1 12h1M13 12h1M2 13h12" />'#10'<path stroke="#8eb3dd" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#10'<path stroke="#408acc" d="M3 3h10M3 4h2M11 4h2M3 5h2M8 5h' +
          '1M12 5h1M3 6h1M7 6h3M12 6h1M3 7h1M6 7h7M3 8h1M6 8h7M3 9h1M7 9h3M' +
          '12 9h1M3 10h2M8 10h1M12 10h1M3 11h2M11 11h2M3 12h10" />'#10'<path st' +
          'roke="#468dcd" d="M5 4h1M5 11h1" />'#10'<path stroke="#a0c5e6" d="M6' +
          ' 4h1" />'#10'<path stroke="#f2f7fb" d="M7 4h2" />'#10'<path stroke="#cde' +
          '1f1" d="M9 4h1M9 11h1" />'#10'<path stroke="#5497d1" d="M10 4h1M10 1' +
          '1h1" />'#10'<path stroke="#c1d9ee" d="M5 5h1M5 10h1" />'#10'<path stroke' +
          '="#b2d0ea" d="M6 5h1M6 10h1" />'#10'<path stroke="#488fce" d="M7 5h1' +
          'M7 10h1" />'#10'<path stroke="#73aada" d="M9 5h1" />'#10'<path stroke="#' +
          'e8f0f8" d="M10 5h1M10 10h1" />'#10'<path stroke="#438bcc" d="M11 5h1' +
          '" />'#10'<path stroke="#609ed4" d="M4 6h1" />'#10'<path stroke="#f8fafc"' +
          ' d="M5 6h1M5 9h1M7 11h2" />'#10'<path stroke="#4990ce" d="M6 6h1M6 9' +
          'h1M11 10h1" />'#10'<path stroke="#70a8da" d="M10 6h1" />'#10'<path strok' +
          'e="#5094d0" d="M11 6h1" />'#10'<path stroke="#7eb1dd" d="M4 7h1" />'#10 +
          '<path stroke="#d0e3f2" d="M5 7h1M5 8h1" />'#10'<path stroke="#77acdb' +
          '" d="M4 8h1" />'#10'<path stroke="#5d9cd4" d="M4 9h1" />'#10'<path strok' +
          'e="#94bee3" d="M10 9h1" />'#10'<path stroke="#6da6d8" d="M11 9h1M9 1' +
          '0h1" />'#10'<path stroke="#aacbe9" d="M6 11h1" />'#10'</svg>'
      end
      item
        IconName = 'PrivateAttribute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ca3636" d="M3 3h9M3' +
          ' 4h1M3 5h1M3 6h1M3 7h1M3 8h1M3 9h1M3 10h1M3 11h1M3 12h1" />'#13#10'<pa' +
          'th stroke="#973636" d="M12 3h1M12 4h1M12 5h1M12 6h1M12 7h1M12 8h' +
          '1M12 9h1M12 10h1M12 11h1M4 12h9" />'#13#10'<path stroke="#fe6536" d="M' +
          '4 4h8M4 5h8M4 6h8M4 7h1M11 7h1M4 8h1M11 8h1M4 9h8M4 10h8M4 11h8"' +
          ' />'#13#10'<path stroke="#ffffff" d="M5 7h6M5 8h6" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ProtectedAttribute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ca3636" d="M3 3h9M3' +
          ' 4h1M3 5h1M3 6h1M3 7h1M3 8h1M3 9h1M3 10h1M3 11h1M3 12h1" />'#13#10'<pa' +
          'th stroke="#973636" d="M12 3h1M12 4h1M12 5h1M12 6h1M12 7h1M12 8h' +
          '1M12 9h1M12 10h1M12 11h1M4 12h9" />'#13#10'<path stroke="#fe6536" d="M' +
          '4 4h8M4 5h2M7 5h2M10 5h2M4 6h1M11 6h1M4 7h2M7 7h2M10 7h2M4 8h2M7' +
          ' 8h2M10 8h2M4 9h1M11 9h1M4 10h2M7 10h2M10 10h2M4 11h8" />'#13#10'<path' +
          ' stroke="#ffffff" d="M6 5h1M9 5h1M5 6h6M6 7h1M9 7h1M6 8h1M9 8h1M' +
          '5 9h6M6 10h1M9 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PublicAttribute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ca3636" d="M3 3h9M3' +
          ' 4h1M3 5h1M3 6h1M3 7h1M3 8h1M3 9h1M3 10h1M3 11h1M3 12h1" />'#13#10'<pa' +
          'th stroke="#973636" d="M12 3h1M12 4h1M12 5h1M12 6h1M12 7h1M12 8h' +
          '1M12 9h1M12 10h1M12 11h1M4 12h9" />'#13#10'<path stroke="#fe6536" d="M' +
          '4 4h8M4 5h3M9 5h3M4 6h3M9 6h3M4 7h1M11 7h1M4 8h1M11 8h1M4 9h3M9 ' +
          '9h3M4 10h3M9 10h3M4 11h8" />'#13#10'<path stroke="#ffffff" d="M7 5h2M7' +
          ' 6h2M5 7h6M5 8h6M7 9h2M7 10h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Class1'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'  <circle cx="8" cy="8" r="7" fill="#' +
          '3a7758"/>'#13#10'  <circle cx="8" cy="8" r="5.5" fill="#3b963a"/>'#13#10'  <' +
          'path d="M 10.5, 5 C 8.5, 3, 4.5, 4, 4.5, 8 C 4.5, 12, 8.5, 13, 1' +
          '0.5, 11" fill="none" stroke="white" stroke-width="1.5"/>'#13#10'</svg>' +
          #13#10
      end
      item
        IconName = 'PrivateMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'    <p' +
          'olygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="w' +
          'hite" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ProtectedMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'<path ' +
          'stroke="white" d="M4.5 6 h7 M4.5 10 h7 M6 4.5 v7 M10 4.5 v7" />'#13 +
          #10'</svg>'
      end
      item
        IconName = 'PublicMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'    <p' +
          'olygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="w' +
          'hite" />'#13#10'    <polygon points="7.5,5 8.5,5 8.5,11 7.5,11 " fill=' +
          '"none" stroke="white" />'#13#10'</svg>'
      end
      item
        IconName = 'Attribute1'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#d63a3a" d="M2 2h11M' +
          '2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12h1M2' +
          ' 13h1" />'#13#10'<path stroke="#963a3a" d="M13 2h1M13 3h1M13 4h1M13 5h' +
          '1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M3 13h11" /' +
          '>'#13#10'<path stroke="#d6583a" d="M3 3h1M5 3h1M7 3h1M9 3h1M11 3h1M4 4' +
          'h1M6 4h1M8 4h1M10 4h1M12 4h1M3 5h1M5 5h1M7 5h1M9 5h1M11 5h1M4 6h' +
          '1M6 6h1M8 6h1M10 6h1M12 6h1M3 7h1M5 7h1M7 7h1M9 7h1M11 7h1M4 8h1' +
          'M6 8h1M8 8h1M10 8h1M12 8h1M3 9h1M5 9h1M7 9h1M9 9h1M11 9h1M4 10h1' +
          'M6 10h1M8 10h1M10 10h1M12 10h1M3 11h1M5 11h1M7 11h1M9 11h1M11 11' +
          'h1M4 12h1M6 12h1M8 12h1M10 12h1M12 12h1" />'#13#10'<path stroke="#fe77' +
          '3a" d="M4 3h1M6 3h1M8 3h1M10 3h1M12 3h1M3 4h1M5 4h1M7 4h1M9 4h1M' +
          '11 4h1M4 5h1M6 5h1M8 5h1M10 5h1M12 5h1M3 6h1M5 6h1M7 6h1M9 6h1M1' +
          '1 6h1M4 7h1M6 7h1M8 7h1M10 7h1M12 7h1M3 8h1M5 8h1M7 8h1M9 8h1M11' +
          ' 8h1M4 9h1M6 9h1M8 9h1M10 9h1M12 9h1M3 10h1M5 10h1M7 10h1M9 10h1' +
          'M11 10h1M4 11h1M6 11h1M8 11h1M10 11h1M12 11h1M3 12h1M5 12h1M7 12' +
          'h1M9 12h1M11 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Method'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'</svg>' +
          #13#10
      end
      item
        IconName = 'ClassEdit'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#95fff8" d="M2 1h11M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="#8eb3dd" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#13#10'<path stroke="#408acc" d="M3 3h10M3 4h2M11 4h2M3 5h2M8 5' +
          'h1M12 5h1M3 6h1M7 6h3M12 6h1M3 7h1M6 7h7M3 8h1M6 8h7M3 9h1M7 9h3' +
          'M12 9h1M3 10h2M8 10h1M12 10h1M3 11h2M11 11h2M3 12h10" />'#13#10'<path ' +
          'stroke="#468dcd" d="M5 4h1M5 11h1" />'#13#10'<path stroke="#a0c5e6" d=' +
          '"M6 4h1" />'#13#10'<path stroke="#f2f7fb" d="M7 4h1" />'#13#10'<path stroke=' +
          '"#cde1f1" d="M8 4h2M8 11h2" />'#13#10'<path stroke="#5497d1" d="M10 4h' +
          '1M10 11h1" />'#13#10'<path stroke="#c1d9ee" d="M5 5h1M5 10h1" />'#13#10'<pat' +
          'h stroke="#b2d0ea" d="M6 5h1M6 10h1" />'#13#10'<path stroke="#488fce" ' +
          'd="M7 5h1M7 10h1" />'#13#10'<path stroke="#73aada" d="M9 5h1" />'#13#10'<pat' +
          'h stroke="#e8f0f8" d="M10 5h1M10 10h1" />'#13#10'<path stroke="#438bcc' +
          '" d="M11 5h1" />'#13#10'<path stroke="#609ed4" d="M4 6h1" />'#13#10'<path st' +
          'roke="#f8fafc" d="M5 6h1M5 9h1M7 11h1" />'#13#10'<path stroke="#4990ce' +
          '" d="M6 6h1M6 9h1M11 10h1" />'#13#10'<path stroke="#70a8da" d="M10 6h1' +
          '" />'#13#10'<path stroke="#5094d0" d="M11 6h1" />'#13#10'<path stroke="#7eb1' +
          'dd" d="M4 7h1" />'#13#10'<path stroke="#d0e3f2" d="M5 7h1M5 8h1" />'#13#10'<' +
          'path stroke="#77acdb" d="M4 8h1" />'#13#10'<path stroke="#5d9cd4" d="M' +
          '4 9h1" />'#13#10'<path stroke="#94bee3" d="M10 9h1" />'#13#10'<path stroke="' +
          '#6da6d8" d="M11 9h1M9 10h1" />'#13#10'<path stroke="#aacbe9" d="M6 11h' +
          '1" />'#13#10'</svg>'#13#10
      end>
    Left = 256
    Top = 136
  end
  object vilTreeViewLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'EditClass'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PrivateAttribute'
        Name = 'PrivateAttribute'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ProtectedAttribute'
        Name = 'ProtectedAttribute'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PublicAttribute'
        Name = 'PublicAttribute'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Class1'
        Name = 'Class1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'PrivateMethod'
        Name = 'PrivateMethod'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ProtectedMethod'
        Name = 'ProtectedMethod'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PublicMethod'
        Name = 'PublicMethod'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Attribute1'
        Name = 'Attribute1'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Method'
        Name = 'Method'
      end
      item
        CollectionIndex = 10
        CollectionName = 'ClassEdit'
        Name = 'Local'
      end>
    ImageCollection = icClassTreeView
    Left = 48
    Top = 136
  end
  object vilTreeViewDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 10
        CollectionName = 'ClassEdit'
        Name = 'ClassEdit'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PrivateAttribute'
        Name = 'PrivateAttribute'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ProtectedAttribute'
        Name = 'ProtectedAttribute'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PublicAttribute'
        Name = 'PublicAttribute'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Class1'
        Name = 'Class1'
      end
      item
        CollectionIndex = 5
        CollectionName = 'PrivateMethod'
        Name = 'PrivateMethod'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ProtectedMethod'
        Name = 'ProtectedMethod'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PublicMethod'
        Name = 'PublicMethod'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Attribute1'
        Name = 'Attribute1'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Method'
        Name = 'Method'
      end
      item
        CollectionIndex = 10
        CollectionName = 'ClassEdit'
        Name = 'Local'
      end>
    ImageCollection = icClassTreeView
    Left = 152
    Top = 136
  end
end
