inherited CollectionEditor: TCollectionEditor
  Left = 342
  Top = 215
  BorderIcons = [biSystemMenu]
  ClientHeight = 267
  ClientWidth = 301
  ParentFont = False
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 313
  ExplicitHeight = 305
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 267
    Align = alClient
    UseDockManager = False
    ParentColor = True
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 297
    ExplicitHeight = 266
    DesignSize = (
      301
      267)
    object ItemList: TListBox
      Left = 8
      Top = 8
      Width = 173
      Height = 251
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragMode = dmAutomatic
      ItemHeight = 15
      TabOrder = 5
      OnClick = ItemListClick
      OnDblClick = ModifyBtnClick
      OnDragDrop = ItemListDragDrop
      OnDragOver = ItemListDragOver
      ExplicitWidth = 169
      ExplicitHeight = 250
    end
    object AddBtn: TButton
      Left = 192
      Top = 12
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Add...'
      TabOrder = 0
      OnClick = AddBtnClick
      ExplicitLeft = 188
    end
    object RemoveBtn: TButton
      Left = 192
      Top = 76
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Remove'
      TabOrder = 2
      OnClick = RemoveBtnClick
      ExplicitLeft = 188
    end
    object ModifyBtn: TButton
      Left = 192
      Top = 44
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Modify..'
      TabOrder = 1
      OnClick = ModifyBtnClick
      ExplicitLeft = 188
    end
    object OKBtn: TButton
      Left = 192
      Top = 206
      Width = 90
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 3
      ExplicitLeft = 188
      ExplicitTop = 205
    end
    object CancelBtn: TButton
      Left = 192
      Top = 237
      Width = 90
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 4
      ExplicitLeft = 188
      ExplicitTop = 236
    end
    object MoveUpBtn: TButton
      Left = 192
      Top = 108
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Up'
      TabOrder = 6
      OnClick = MoveUpBtnClick
      ExplicitLeft = 188
    end
    object MoveDownBtn: TButton
      Left = 192
      Top = 140
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Down'
      TabOrder = 7
      OnClick = MoveDownBtnClick
      ExplicitLeft = 188
    end
  end
end
