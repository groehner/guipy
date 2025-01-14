inherited ReplaceInFilesDialog: TReplaceInFilesDialog
  Left = 378
  Top = 227
  HelpContext = 460
  Caption = 'Replace Matches'
  ClientHeight = 158
  ClientWidth = 401
  Position = poScreenCenter
  ExplicitWidth = 413
  ExplicitHeight = 196
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 158
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 397
    ExplicitHeight = 157
    DesignSize = (
      401
      158)
    object lblReplaceString: TLabel
      Left = 92
      Top = 8
      Width = 51
      Height = 15
      Caption = 'TestString'
      Color = clNone
      ParentColor = False
      ShowAccelChar = False
    end
    object lblWith: TLabel
      Left = 10
      Top = 33
      Width = 25
      Height = 15
      Caption = '&With'
      Color = clNone
      FocusControl = cbReplace
      ParentColor = False
    end
    object lblIn: TLabel
      Left = 10
      Top = 57
      Width = 10
      Height = 15
      Caption = 'In'
      Color = clNone
      ParentColor = False
    end
    object lblReplace: TLabel
      Left = 10
      Top = 8
      Width = 41
      Height = 15
      Caption = 'Replace'
      Color = clNone
      ParentColor = False
    end
    object lblInString: TLabel
      Left = 92
      Top = 57
      Width = -1
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      Color = clNone
      ParentColor = False
      ShowAccelChar = False
      ExplicitWidth = 3
    end
    object cbReplace: TComboBox
      Left = 92
      Top = 30
      Width = 286
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      ExplicitWidth = 282
    end
    object btnOK: TButton
      Left = 144
      Top = 125
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
      ExplicitLeft = 140
      ExplicitTop = 124
    end
    object btnCancel: TButton
      Left = 223
      Top = 125
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 2
      ExplicitLeft = 219
      ExplicitTop = 124
    end
    object btnHelp: TButton
      Left = 302
      Top = 125
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Help'
      TabOrder = 3
      OnClick = btnHelpClick
      ExplicitLeft = 298
      ExplicitTop = 124
    end
    object cbBackup: TCheckBox
      Left = 10
      Top = 105
      Width = 300
      Height = 21
      Caption = 'Backup Modified Files'
      TabOrder = 4
    end
  end
end
