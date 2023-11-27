object FOpenFolderForm: TFOpenFolderForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Open folder'
  ClientHeight = 336
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    394
    336)
  TextHeight = 15
  object LFiletype: TLabel
    Left = 14
    Top = 278
    Width = 79
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Select file type:'
    ExplicitTop = 279
  end
  object BOK: TButton
    Left = 211
    Top = 306
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object BCancel: TButton
    Left = 293
    Top = 306
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object CBFiletype: TComboBox
    Left = 108
    Top = 274
    Width = 69
    Height = 23
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 2
    TabStop = False
  end
  object CBWithSubFolder: TCheckBox
    Left = -7
    Top = 309
    Width = 161
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'With &subfolders'
    Checked = True
    State = cbChecked
    TabOrder = 3
    ExplicitLeft = -3
  end
end
