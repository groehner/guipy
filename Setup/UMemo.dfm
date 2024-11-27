object FMemo: TFMemo
  Left = 306
  Top = 226
  BorderStyle = bsSingle
  Caption = 'Installation'
  ClientHeight = 303
  ClientWidth = 1049
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object MInstallation: TMemo
    Left = 0
    Top = 0
    Width = 1049
    Height = 257
    Align = alTop
    Lines.Strings = (
      'Installation'
      '')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object BClose: TButton
    Left = 978
    Top = 271
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = BCloseClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'deinstall.txt'
    Left = 104
    Top = 104
  end
end
