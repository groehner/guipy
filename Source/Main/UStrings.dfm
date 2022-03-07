object FStringEditor: TFStringEditor
  Left = 479
  Top = 252
  Caption = 'String editor'
  ClientHeight = 198
  ClientWidth = 386
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MStrings: TMemo
    Left = 8
    Top = 8
    Width = 289
    Height = 185
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object BOK: TButton
    Left = 312
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BCancel: TButton
    Left = 312
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
