object FUpdate: TFUpdate
  Left = 630
  Top = 184
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Update'
  ClientHeight = 267
  ClientWidth = 334
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
  object LOldVersion: TLabel
    Left = 13
    Top = 11
    Width = 81
    Height = 15
    Caption = 'Current version'
  end
  object LChecking: TLabel
    Left = 13
    Top = 186
    Width = 111
    Height = 15
    Caption = 'Check automatically '
  end
  object LNewVersion: TLabel
    Left = 13
    Top = 42
    Width = 65
    Height = 15
    Caption = 'New version'
  end
  object BClose: TButton
    Left = 111
    Top = 236
    Width = 100
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = BCloseClick
  end
  object ProgressBar: TProgressBar
    Left = 13
    Top = 215
    Width = 313
    Height = 15
    TabOrder = 1
  end
  object EOldVersion: TEdit
    Left = 101
    Top = 7
    Width = 225
    Height = 23
    TabOrder = 2
  end
  object BUpdate: TButton
    Left = 217
    Top = 236
    Width = 100
    Height = 25
    Hint = 'Performs an update. To do this, you need sufficient rights.'
    Caption = 'Update'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BUpdateClick
  end
  object CBUpdate: TComboBox
    Left = 192
    Top = 182
    Width = 134
    Height = 23
    TabOrder = 4
    Items.Strings = (
      'never'
      'monthly'
      'weekly'
      'daily'
      'at every start')
  end
  object Memo: TMemo
    Left = 13
    Top = 70
    Width = 313
    Height = 106
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object ENewVersion: TEdit
    Left = 101
    Top = 38
    Width = 225
    Height = 23
    TabOrder = 6
  end
end
