object FUpdater: TFUpdater
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Updater'
  ClientHeight = 254
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 833
    Height = 219
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 219
    Width = 833
    Height = 35
    Align = alBottom
    TabOrder = 1
    object BOK: TButton
      AlignWithMargins = True
      Left = 758
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = 'OK'
      TabOrder = 0
      OnClick = BOKClick
      ExplicitLeft = 754
    end
    object BRetry: TButton
      Left = 677
      Top = 4
      Width = 75
      Height = 27
      Caption = 'Retry'
      TabOrder = 1
      OnClick = BRetryClick
    end
  end
end
