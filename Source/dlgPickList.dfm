inherited PickListDialog: TPickListDialog
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = 'PickListDialog'
  ClientHeight = 323
  ClientWidth = 461
  ExplicitWidth = 473
  ExplicitHeight = 361
  TextHeight = 15
  object Panel2: TPanel
    Left = 0
    Top = 239
    Width = 461
    Height = 84
    Align = alBottom
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    ExplicitTop = 238
    ExplicitWidth = 457
    DesignSize = (
      461
      84)
    object Bevel1: TBevel
      Left = 0
      Top = 36
      Width = 476
      Height = 2
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsTopLine
      ExplicitWidth = 496
    end
    object btnSelectAll: TButton
      Left = 85
      Top = 6
      Width = 130
      Height = 24
      Caption = '&Select All'
      ImageIndex = 0
      ImageName = 'TreeSelectAll'
      Images = vilImages
      TabOrder = 0
      OnClick = mnSelectAllClick
    end
    object btnDeselectAll: TButton
      Left = 220
      Top = 6
      Width = 130
      Height = 24
      Anchors = [akRight, akBottom]
      Caption = '&Deselect All'
      ImageIndex = 1
      ImageName = 'TreeDeselectAll'
      Images = vilImages
      TabOrder = 1
      OnClick = mnDeselectAllClick
      ExplicitLeft = 216
    end
    object btnOk: TButton
      Left = 255
      Top = 48
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
      ExplicitLeft = 251
    end
    object btnCancel: TButton
      Left = 352
      Top = 48
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 3
      ExplicitLeft = 348
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 239
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 457
    ExplicitHeight = 238
    DesignSize = (
      461
      239)
    object imgIcon: TImage
      Left = 8
      Top = 12
      Width = 32
      Height = 32
      Transparent = True
    end
    object lbMessage: TLabel
      Left = 58
      Top = 14
      Width = 374
      Height = 52
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Color = clNone
      ParentColor = False
      WordWrap = True
      ExplicitWidth = 394
    end
    object CheckListBox: TCheckListBox
      AlignWithMargins = True
      Left = 4
      Top = 72
      Width = 453
      Height = 163
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkSoft
      ItemHeight = 17
      PopupMenu = PickListPopUp
      TabOrder = 0
      ExplicitWidth = 449
      ExplicitHeight = 162
    end
  end
  object PickListPopUp: TPopupMenu
    Images = vilImages
    Left = 272
    Top = 104
    object mnSelectAll: TMenuItem
      Caption = '&Select All'
      Hint = 'Select all items'
      ImageIndex = 0
      ImageName = 'TreeSelectAll'
      OnClick = mnSelectAllClick
    end
    object mnDeselectAll: TMenuItem
      Caption = '&Deselect All'
      Hint = 'Deselect all items'
      ImageIndex = 1
      ImageName = 'TreeDeselectAll'
      OnClick = mnDeselectAllClick
    end
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 126
        CollectionName = 'TreeSelectAll'
        Name = 'TreeSelectAll'
      end
      item
        CollectionIndex = 125
        CollectionName = 'TreeDeselectAll'
        Name = 'TreeDeselectAll'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Left = 176
    Top = 104
  end
end
