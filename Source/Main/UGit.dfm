object FGit: TFGit
  Left = 327
  Top = 212
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Revisions'
  ClientHeight = 193
  ClientWidth = 531
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LVRevisions: TListView
    Left = 8
    Top = 8
    Width = 513
    Height = 145
    Columns = <
      item
        Caption = 'Revision'
        Width = 53
      end
      item
        Caption = 'Author'
        Width = 70
      end
      item
        Caption = 'Date'
        Width = 110
      end
      item
        Caption = 'Message'
        Width = 260
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = LVRevisionsDblClick
  end
  object BOK: TButton
    Left = 202
    Top = 160
    Width = 74
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BCancel: TButton
    Left = 288
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
