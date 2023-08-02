object FIconEditor: TFIconEditor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Image'
  ClientHeight = 267
  ClientWidth = 282
  Color = clBtnFace
  ParentFont = True
  TextHeight = 15
  object BSelect: TButton
    Left = 16
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 0
    OnClick = BSelectClick
  end
  object BLoeschen: TButton
    Left = 104
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 1
    OnClick = BLoeschenClick
  end
  object BOK: TButton
    Left = 192
    Top = 232
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object ImagePanel: TPanel
    Left = 16
    Top = 16
    Width = 251
    Height = 201
    BevelKind = bkSoft
    TabOrder = 3
    object Image: TImage
      Left = 0
      Top = 0
      Width = 251
      Height = 200
      Center = True
    end
  end
  object ODIconDialog: TOpenPictureDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 48
    Top = 176
  end
end
