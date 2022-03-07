object ELStringsEditorDlg: TELStringsEditorDlg
  Left = 369
  Top = 177
  ActiveControl = memMain
  BorderStyle = bsDialog
  Caption = 'String editor'
  ClientHeight = 286
  ClientWidth = 431
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object lbLineCount: TLabel
    Left = 12
    Top = 12
    Width = 169
    Height = 15
    AutoSize = False
    Caption = '0 lines'
  end
  object bvlMain: TBevel
    Left = 8
    Top = 8
    Width = 413
    Height = 239
    Shape = bsFrame
  end
  object btnOk: TButton
    Left = 265
    Top = 253
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 345
    Top = 253
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object memMain: TMemo
    Left = 16
    Top = 27
    Width = 397
    Height = 206
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
  end
end
