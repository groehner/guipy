object FClassEditor: TFClassEditor
  Left = 284
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'UML class editor'
  ClientHeight = 452
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poOwnerFormCenter
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
    ActivePage = TSMethods
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
        Left = 94
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
        Top = 220
        Width = 24
        Height = 15
        Caption = 'Type'
      end
      object LAttributeValue: TLabel
        Left = 8
        Top = 187
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
        Top = 217
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
        object CBsetMethod: TCheckBox
          Left = 8
          Top = 90
          Width = 95
          Height = 17
          Caption = 'set method'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CBgetMethod: TCheckBox
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
        Top = 184
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
        Left = 126
        Top = 16
        Width = 100
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
        Left = 244
        Top = 16
        Width = 100
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
        Width = 100
        Height = 105
        Caption = 'Kind'
        Items.Strings = (
          'Constructor'
          'Function'
          'Procedure')
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
          Top = 96
          Width = 24
          Height = 15
          Caption = 'Type'
        end
        object SBUp: TSpeedButton
          Left = 310
          Top = 33
          Width = 18
          Height = 18
          Glyph.Data = {
            9E010000424D9E0100000000000036000000280000000B0000000A0000000100
            18000000000068010000C40E0000C40E000000000000000000001C1CFF1C1CFF
            1C1CFFE08050A050309048209048209048201C1CFF1C1CFF1C1CFF1CFFFF1C1C
            FF1C1CFF1C1CFFE08050E08860D08050C070409048201C1CFF1C1CFF1C1CFF80
            50FF1C1CFF1C1CFF1C1CFFE08050F0A880E08860D07850A048201C1CFF1C1CFF
            1C1CFF9860FF1C1CFF1C1CFF1C1CFFE08050FFC0A0F09860E08860A050201C1C
            FF1C1CFF1C1CFF5830FF1C1CFFE09870D07040D06830FFB090F09860F09860B0
            5830A050209048201C1CFFC5BFFF1C1CFFE6D2C7E09870FFC0A0FFB090FFA070
            F09060D07840A05030CEC5BF1C1CFF1CFFFF1C1CFF1C1CFFE6D1C6F0A070FFC0
            A0FFB090E08860A05030D0C6C01C1CFF1C1CFFD1C6FF1C1CFF1C1CFF1C1CFFE4
            D0C5F0A070FFC0A0A05830D1C8C21C1CFF1C1CFF1C1CFFA070FF1C1CFF1C1CFF
            1C1CFF1C1CFFE3CFC4E09870D4C9C31C1CFF1C1CFF1C1CFF1C1CFFC9C3FF1C1C
            FF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C
            FFFF}
          OnClick = SBUpClick
        end
        object SBDelete: TSpeedButton
          Left = 310
          Top = 60
          Width = 18
          Height = 19
          Glyph.Data = {
            12010000424D120100000000000042000000280000001A0000000D0000000100
            040000000000D0000000880B0000880B0000030000000300000000000000CC33
            FF00FFFFFF001011111111110121111111111200000000011111111112221111
            1111110000000000111111101222211111112100000010001111110111222111
            1112110000001100011110011112221111221100000011100011001111112221
            1221110000001111000001111111122222111100000011111000111111111122
            2111110000001111000001111111122222111100000011100011001111112221
            1221110000001000011110011122221111221100000000001111110012222111
            11122100000000011111111102221111111112000000}
          NumGlyphs = 2
          OnClick = SBDeleteClick
        end
        object SBDown: TSpeedButton
          Left = 310
          Top = 90
          Width = 18
          Height = 18
          Glyph.Data = {
            7A010000424D7A0100000000000036000000280000000B000000090000000100
            18000000000044010000C40E0000C40E000000000000000000001C1CFF1C1CFF
            1C1CFF1C1CFFDED6D3B05830D4C9C31C1CFF1C1CFF1C1CFF1C1CFFD7D4FF1C1C
            FF1C1CFF1C1CFFE0D7D4B05830C06840A05830D1C8C21C1CFF1C1CFF1C1CFF78
            50FF1C1CFF1C1CFF1C1CFFB05830E08050E07850C06840A05030D0C6C01C1CFF
            1C1CFF6840FF1C1CFF1C1CFFC07850F09870FFA070E08850D07850C06840A050
            30CEC5BF1C1CFF6840FF1C1CFFF0A070E09870E09070FFA880F09060E08050A0
            5030B06040B068401C1CFF1CFFFF1C1CFF1C1CFF1C1CFFD08860FFB080FF9060
            F08850B060401C1CFF1C1CFF1C1CFF1CFFFF1C1CFF1C1CFF1C1CFFE09070FFC0
            A0FFA880F09060B068401C1CFF1C1CFF1C1CFFC0A0FF1C1CFF1C1CFF1C1CFFE0
            9870FFC0A0FFB890FFB090C070501C1CFF1C1CFF1C1CFFB090FF1C1CFF1C1CFF
            1C1CFFF0A070E09870E09070D08860D088601C1CFF1C1CFF1C1CFF1CFFFF}
          OnClick = SBDownClick
        end
        object SBRight: TSpeedButton
          Left = 175
          Top = 48
          Width = 18
          Height = 18
          Glyph.Data = {
            0A020000424D0A0200000000000036000000280000000B0000000D0000000100
            180000000000D4010000C40E0000C40E000000000000000000001C1CFF1C1CFF
            1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF9880FF1C1C
            FF1C1CFF1C1CFF1C1CFF1C1CFF90B8A0CEDBD21C1CFF1C1CFF1C1CFF1C1CFFD0
            CBFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF90A890809880C2D1CC1C1CFF1C1CFF
            1C1CFF1CFFFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF80A090A0E0C0809880C1D0
            CB1C1CFF1C1CFFC0A0FF1C1CFF90C0A090B8A090A89080A090809880B0E8C080
            C890809880C0CFCA1C1CFFF0C0FF1C1CFF90B8A0B0F0D0B0F0C0B0E8C0A0E8C0
            A0E0B070C09070B080809880BECDC9D0A0FF1C1CFF90A890B0F0C090E0B090D8
            A080D0A070C09070B88060A870509060607860A870FF1C1CFF80A090B0E8C070
            B08070A88060A07060987060A870407850202020A5ADAAAFABFF1C1CFF809880
            202820303830304030404840509060407850202020A6AFAB1C1CFF1CFFFF1C1C
            FF1C1CFF1C1CFF1C1CFF1C1CFF809080407850202020A8B0AC1C1CFF1C1CFF1C
            FFFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF809080202020A4ACA91C1CFF1C1CFF
            1C1CFF1CFFFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF809080C2C6C61C1CFF1C1C
            FF1C1CFF1C1CFFC6C6FF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C
            1CFF1C1CFF1C1CFF1C1CFF1CFFFF}
          OnClick = SBRightClick
        end
        object SBLeft: TSpeedButton
          Left = 176
          Top = 80
          Width = 18
          Height = 18
          Glyph.Data = {
            0A020000424D0A0200000000000036000000280000000B0000000D0000000100
            180000000000D4010000C40E0000C40E000000000000000000001C1CFF1C1CFF
            1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF4030FF1C1C
            FF1C1CFF1C1CFF1C1CFF1C1CFFC2C6C63038301C1CFF1C1CFF1C1CFF1C1CFF1C
            FFFF1C1CFF1C1CFF1C1CFF1C1CFFC2C7C73040303040301C1CFF1C1CFF1C1CFF
            1C1CFF2020FF1C1CFF1C1CFF1C1CFFC7CECE6078605080603040301C1CFF1C1C
            FF1C1CFF1C1CFF1CFFFF1C1CFF1C1CFFC9D0D050605060987070A88040484030
            4030303830202820202020A880FF1C1CFFBFC7C350685070A88090D8A070C090
            60A880609870509060408050303830D8A0FF1C1CFF90B8A0C0F0D0B0F0C090E0
            B090D8A080C89070B88060B070508860304030D8B0FF1C1CFFD2DED6A0D0B0C0
            F8D0B0E8C090E0B0A0E0C0A0D8B090C8A090C090404840A090FF1C1CFF1C1CFF
            D2DED5A0C8B0C0F8D0B0E8C040584090A89080A09080A0908098801CFFFF1C1C
            FF1C1CFF1C1CFFD0DCD4A0C8B0C0F0D05058501C1CFF1C1CFF1C1CFF1C1CFF1C
            FFFF1C1CFF1C1CFF1C1CFF1C1CFFCFDCD3A0C0A05070601C1CFF1C1CFF1C1CFF
            1C1CFFDCD3FF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFFCEDAD2A0C0A01C1CFF1C1C
            FF1C1CFF1C1CFFC0A0FF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C1CFF1C
            1CFF1C1CFF1C1CFF1C1CFF1CFFFF}
          OnClick = SBLeftClick
        end
        object LParameterValue: TLabel
          Left = 13
          Top = 64
          Width = 28
          Height = 15
          Caption = 'Value'
        end
        object CBParamType: TComboBox
          Left = 57
          Top = 93
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
          Left = 57
          Top = 29
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
          Top = 61
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
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
    end
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 40
    Top = 272
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
  object ILSpeedButton: TImageList
    Height = 13
    Width = 13
    Left = 528
    Top = 320
    Bitmap = {
      494C01010200080004000D000D00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000340000000D0000000100200000000000900A
      000000000000000000000000000000000000CC33FF0000000000CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF0000000000CC33FF00FFFFFF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFFFF00FFFFFF00FFFF
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF000000
      0000CC33FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFFFF00CC33FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC33FF00000000000000000000000000CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF0000000000CC33FF00CC33FF00CC33FF00FFFFFF00FFFF
      FF00FFFFFF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFF
      FF00CC33FF00CC33FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC33FF00CC33FF00000000000000
      000000000000CC33FF00CC33FF00CC33FF00CC33FF000000000000000000CC33
      FF00CC33FF00CC33FF00CC33FF00FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33
      FF00CC33FF00CC33FF00FFFFFF00FFFFFF00CC33FF00CC33FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC33FF00CC33FF00CC33FF00000000000000000000000000CC33FF00CC33
      FF000000000000000000CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF00FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33FF00FFFFFF00FFFFFF00CC33
      FF00CC33FF00CC33FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC33FF00CC33FF00CC33FF00CC33
      FF000000000000000000000000000000000000000000CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CC33FF00CC33FF00CC33FF00CC33FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC33FF00CC33FF00CC33FF00CC33FF00CC33FF0000000000000000000000
      0000CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC33FF00CC33FF00CC33FF00CC33
      FF000000000000000000000000000000000000000000CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CC33FF00CC33FF00CC33FF00CC33FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC33FF00CC33FF00CC33FF00000000000000000000000000CC33FF00CC33
      FF000000000000000000CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF00FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33FF00FFFFFF00FFFFFF00CC33
      FF00CC33FF00CC33FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC33FF0000000000000000000000
      000000000000CC33FF00CC33FF00CC33FF00CC33FF000000000000000000CC33
      FF00CC33FF00CC33FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33
      FF00CC33FF00CC33FF00FFFFFF00FFFFFF00CC33FF00CC33FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF000000000000000000CC33FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFF
      FF00FFFFFF00CC33FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33
      FF0000000000FFFFFF00FFFFFF00FFFFFF00CC33FF00CC33FF00CC33FF00CC33
      FF00CC33FF00CC33FF00CC33FF00CC33FF00CC33FF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E00000028000000340000000D00000001000100
      00000000680000000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
  end
end
