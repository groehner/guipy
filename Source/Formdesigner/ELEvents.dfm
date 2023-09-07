object ELEventEditorDlg: TELEventEditorDlg
  Left = 0
  Top = 0
  Caption = 'Mouse or Key Event'
  ClientHeight = 159
  ClientWidth = 297
  Color = clBtnFace
  ParentFont = True
  OnResize = FormResize
  TextHeight = 15
  object GBModifier: TGroupBox
    Left = 8
    Top = 8
    Width = 89
    Height = 138
    Caption = ' Modifier '
    TabOrder = 0
    object CBAlt: TCheckBox
      Left = 8
      Top = 65
      Width = 97
      Height = 17
      Caption = 'Alt'
      TabOrder = 0
    end
    object CBControl: TCheckBox
      Left = 8
      Top = 19
      Width = 97
      Height = 17
      Caption = 'Ctrl'
      TabOrder = 1
    end
    object CBDouble: TCheckBox
      Left = 8
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Double'
      TabOrder = 2
    end
    object CBShift: TCheckBox
      Left = 8
      Top = 42
      Width = 97
      Height = 17
      Caption = 'Shift'
      TabOrder = 3
    end
    object CBTriple: TCheckBox
      Left = 8
      Top = 111
      Width = 97
      Height = 17
      Caption = 'Triple'
      TabOrder = 4
    end
  end
  object RBMouseButton: TRadioGroup
    Left = 215
    Top = 8
    Width = 75
    Height = 112
    Caption = '  Button '
    Items.Strings = (
      'Any'
      'Left'
      'Middle'
      'Right')
    TabOrder = 1
  end
  object GBKey: TGroupBox
    Left = 103
    Top = 8
    Width = 106
    Height = 94
    Caption = ' Key '
    TabOrder = 2
    object CBKey: TComboBox
      Left = 8
      Top = 22
      Width = 89
      Height = 23
      TabOrder = 0
      OnSelect = CBKeySelect
      Items.Strings = (
        'Alt_L'
        'Alt_R'
        'BackSpace'
        'Begin'
        'CapsLock'
        'Control_L'
        'Control_R'
        'Delete'
        'Down'
        'End'
        'Escape'
        'Home'
        'Insert'
        'Left'
        'Less'
        'Linefeed'
        'Menu'
        'Next'
        'Pause'
        'Prior'
        'Print'
        'Return'
        'Right'
        'Shift_L'
        'Shift_R'
        'space'
        'Tab'
        'Up'
        'Win_L'
        'Win_R'
        'App'
        '-'
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z'
        'a'
        'b'
        'c'
        'd'
        'e'
        'f'
        'g'
        'h'
        'i'
        'j'
        'k'
        'l'
        'm'
        'n'
        'o'
        'p'
        'q'
        'r'
        's'
        't'
        'u'
        'v'
        'w'
        'x'
        'y'
        'z'
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        'F1'
        'F2'
        'F3'
        'F4'
        'F5'
        'F6'
        'F7'
        'F8'
        'F9'
        'F10'
        'F11'
        'F12'
        '-'
        '^'
        #176
        '!'
        '`'
        '"'
        #167
        '$'
        '%'
        '&'
        '/'
        '('
        ')'
        '='
        '? '
        '['
        ']'
        '{'
        '}'
        '+'
        '~'
        '*'
        '#'
        #39
        ','
        '.'
        '-'
        ';'
        ':'
        '_'
        '<'
        '>'
        '|'
        '\'
        '@')
    end
    object CBAny: TCheckBox
      Left = 8
      Top = 49
      Width = 66
      Height = 17
      Caption = 'Any key'
      TabOrder = 1
      OnClick = CBAnyClick
    end
  end
  object btnOk: TButton
    Left = 133
    Top = 126
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 214
    Top = 126
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
