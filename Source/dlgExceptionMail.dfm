inherited ExceptionDialogMail: TExceptionDialogMail
  Left = 310
  Top = 255
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  ClientHeight = 245
  ClientWidth = 422
  Constraints.MinWidth = 200
  KeyPreview = True
  Position = poScreenCenter
  ShowHint = True
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 434
  ExplicitHeight = 283
  DesignSize = (
    422
    245)
  TextHeight = 15
  object BevelDetails: TBevel
    Left = 3
    Top = 91
    Width = 408
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
    ExplicitWidth = 422
  end
  object DetailsMemo: TMemo
    Left = 4
    Top = 101
    Width = 407
    Height = 137
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
    WantReturns = False
    WordWrap = False
    ExplicitWidth = 403
    ExplicitHeight = 136
  end
  object TextMemo: TMemo
    Left = 56
    Top = 8
    Width = 267
    Height = 75
    Hint = 'Use Ctrl+C to copy the report to the clipboard'
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsNone
    Ctl3D = True
    ParentColor = True
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 1
    WantReturns = False
    ExplicitWidth = 263
  end
  object SendBtn: TButton
    Left = 337
    Top = 32
    Width = 75
    Height = 25
    Hint = 'Send bug report using default mail client'
    Anchors = [akTop, akRight]
    Caption = '&Send'
    TabOrder = 0
    OnClick = SendBtnClick
    ExplicitLeft = 333
  end
  object OkBtn: TButton
    Left = 338
    Top = 4
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 334
  end
  object DetailsBtn: TButton
    Left = 338
    Top = 60
    Width = 75
    Height = 25
    Hint = 'Show or hide additional information|'
    Anchors = [akTop, akRight]
    Caption = '&Details'
    Enabled = False
    TabOrder = 3
    OnClick = DetailsBtnClick
    ExplicitLeft = 334
  end
end
