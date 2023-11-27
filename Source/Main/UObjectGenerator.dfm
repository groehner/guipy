object FObjectGenerator: TFObjectGenerator
  Left = 599
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Object generator'
  ClientHeight = 567
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object StatusBar: TStatusBar
    Left = 0
    Top = 536
    Width = 241
    Height = 31
    Panels = <>
    ExplicitTop = 548
    ExplicitWidth = 249
    DesignSize = (
      241
      31)
    object BCancel: TButton
      Left = 160
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object BFont: TButton
      Left = 81
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Font'
      TabOrder = 1
      OnClick = MIFontClick
    end
    object BOK: TButton
      Left = 0
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object ValueListEditor: TValueListEditor
    Left = 0
    Top = 0
    Width = 241
    Height = 536
    Align = alClient
    Constraints.MinWidth = 235
    TabOrder = 0
    TitleCaptions.Strings = (
      'Attribute'
      'Value')
    OnKeyUp = ValueListEditorKeyUp
    ExplicitWidth = 249
    ExplicitHeight = 548
    ColWidths = (
      111
      140)
  end
  object PictureDialog: TOpenDialog
    Filter = 
      'jpg and gif files|*.jpg;*.jpeg;*.gif|jpg files (*.jpg, *.jpeg)|*' +
      '.jpg;*.jpeg|gif files (*.gif)|*.gif|All (*.*)|*.*'
    FilterIndex = 0
    Left = 70
    Top = 184
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 158
    Top = 184
  end
end
