object FAssociation: TFAssociation
  Left = 459
  Top = 280
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Connection types'
  ClientHeight = 493
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object LSelect: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 15
    Caption = 'Please select'
  end
  object LMultiplicityA: TLabel
    Left = 8
    Top = 354
    Width = 71
    Height = 15
    Caption = 'Multiplicity A'
  end
  object LRelation: TLabel
    Left = 136
    Top = 282
    Width = 43
    Height = 15
    Caption = 'Relation'
  end
  object LMultiplicityB: TLabel
    Left = 230
    Top = 354
    Width = 70
    Height = 15
    Caption = 'Multiplicity B'
  end
  object LRoleA: TLabel
    Left = 8
    Top = 282
    Width = 34
    Height = 15
    Caption = 'Role A'
  end
  object LRoleB: TLabel
    Left = 266
    Top = 282
    Width = 33
    Height = 15
    Caption = 'Role B'
  end
  object LBAssociations: TListBox
    Left = 8
    Top = 32
    Width = 217
    Height = 217
    Style = lbOwnerDrawFixed
    ItemHeight = 21
    Items.Strings = (
      'Association'
      'Association directed'
      'Association bidirectional'
      'Aggregation'
      'Aggregation with arrow'
      'Composition'
      'Composition with arrow'
      'Inheritance'
      'Instance of'
      'Comment')
    TabOrder = 0
    OnDblClick = LBAssociationsDblClick
    OnDrawItem = LBAssociationsDrawItem
  end
  object BOK: TButton
    Left = 230
    Top = 32
    Width = 76
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BTurn: TButton
    Left = 231
    Top = 63
    Width = 76
    Height = 25
    Caption = 'Turn'
    ModalResult = 6
    TabOrder = 3
  end
  object BDelete: TButton
    Left = 230
    Top = 96
    Width = 76
    Height = 25
    Caption = 'Delete'
    ModalResult = 7
    TabOrder = 4
  end
  object BCancel: TButton
    Left = 230
    Top = 128
    Width = 76
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object ERelation: TEdit
    Left = 104
    Top = 301
    Width = 105
    Height = 23
    TabOrder = 1
  end
  object RGRecursivCorner: TRadioGroup
    Left = 8
    Top = 419
    Width = 297
    Height = 72
    Caption = 'Recursive relation'
    Columns = 2
    Items.Strings = (
      'top left'
      'bottom left'
      'top right'
      'bottom right')
    TabOrder = 6
  end
  object CBReadingOrderA: TCheckBox
    Left = 104
    Top = 328
    Width = 49
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = CBReadingOrderAClick
  end
  object CBReadingOrderB: TCheckBox
    Left = 176
    Top = 328
    Width = 33
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = CBReadingOrderBClick
  end
  object MRoleA: TMemo
    Left = 8
    Top = 301
    Width = 90
    Height = 40
    TabOrder = 9
  end
  object MRoleB: TMemo
    Left = 215
    Top = 301
    Width = 90
    Height = 40
    TabOrder = 10
  end
  object MMultiplicityA: TMemo
    Left = 8
    Top = 373
    Width = 90
    Height = 40
    TabOrder = 11
  end
  object MMultiplicityB: TMemo
    Left = 215
    Top = 373
    Width = 90
    Height = 40
    TabOrder = 12
  end
  object vilConnectionsLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'AssociationUndirected'
        Name = 'AssociationUndirected'
      end
      item
        CollectionIndex = 1
        CollectionName = 'AssociationDirected'
        Name = 'AssociationDirected'
      end
      item
        CollectionIndex = 2
        CollectionName = 'AssociationBidirectional'
        Name = 'AssociationBidirectional'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Aggregation'
        Name = 'Aggregation'
      end
      item
        CollectionIndex = 4
        CollectionName = 'AggregationWithArrow'
        Name = 'AggregationWithArrow'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Composition'
        Name = 'Composition'
      end
      item
        CollectionIndex = 6
        CollectionName = 'CompositionWithArrow'
        Name = 'CompositionWithArrow'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Inheritance'
        Name = 'Inheritance'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Implements'
        Name = 'Implements'
      end
      item
        CollectionIndex = 9
        CollectionName = 'InstanceOf'
        Name = 'InstanceOf'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Comment'
        Name = 'Comment'
      end>
    ImageCollection = icMenuConnection
    Width = 26
    Left = 176
    Top = 96
  end
  object vilConnectionsDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 11
        CollectionName = 'AssociationUndirected'
        Name = 'AssociationUndirected'
      end
      item
        CollectionIndex = 12
        CollectionName = 'AssociationDirected'
        Name = 'AssociationDirected'
      end
      item
        CollectionIndex = 13
        CollectionName = 'AssociationBidirectional'
        Name = 'AssociationBidirectional'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Aggregation'
        Name = 'Aggregation'
      end
      item
        CollectionIndex = 15
        CollectionName = 'AggregationWithArrow'
        Name = 'AggregationWithArrow'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Composition'
        Name = 'Composition'
      end
      item
        CollectionIndex = 17
        CollectionName = 'CompositionWithArrow'
        Name = 'CompositionWithArrow'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Inheritance'
        Name = 'Inheritance'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Implements'
        Name = 'Implements'
      end
      item
        CollectionIndex = 20
        CollectionName = 'InstanceOf'
        Name = 'InstanceOf'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Comment'
        Name = 'Comment'
      end>
    ImageCollection = icMenuConnection
    Width = 26
    Left = 176
    Top = 152
  end
  object icMenuConnection: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'AssociationUndirected'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M0 8h26"' +
          ' />'#13#10'</svg>'
      end
      item
        IconName = 'AssociationDirected'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M0 8h25"' +
          '/>'#13#10'<polyline fill="none" stroke="#000000" points="19,2 25,8 19,' +
          '14 " />  '#13#10'</svg>'
      end
      item
        IconName = 'AssociationBidirectional'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M1 8h24"' +
          '/>'#13#10'<polyline fill="none" stroke="#000000" points="7,2 1,8 7,14 ' +
          '" /> '#13#10'<polyline fill="none" stroke="#000000" points="19,2 25,8 ' +
          '19,14 " />  '#13#10'</svg>'
      end
      item
        IconName = 'Aggregation'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M13 8h13' +
          '"/>'#13#10'<polyline fill="none" stroke="#000000" points="7,2 1,8 7,14' +
          ' 13,8 6.6465,1.6465" />  '#13#10'</svg>'
      end
      item
        IconName = 'AggregationWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M13 8h12' +
          '"/>'#13#10'<polyline fill="none" stroke="#000000" points="7,2 1,8 7,14' +
          ' 13,8 6.6465,1.6465" />'#13#10'<polyline fill="none" stroke="#000000" ' +
          'points="19,2 25,8 19,14 " />   '#13#10'</svg>'
      end
      item
        IconName = 'Composition'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M13 8h13' +
          '"/>'#13#10'<polyline stroke="#000000" points="7,2 1,8 7,14 13,8 6.6465' +
          ',1.6465" />  '#13#10'</svg>'
      end
      item
        IconName = 'CompositionWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M13 8h12' +
          '"/>'#13#10'<polyline stroke="#000000" points="7,2 1,8 7,14 13,8 6.6465' +
          ',1.6465" /> '#13#10'<polyline fill="none" stroke="#000000" points="19,' +
          '2 25,8 19,14 " />    '#13#10'</svg>'#13#10
      end
      item
        IconName = 'Inheritance'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M0 7.5h1' +
          '9 M0 8.5 h19"/>'#13#10'<polygon fill="none" stroke="#000000" points="1' +
          '9,2 25,8 19,14 19,2" />  '#13#10'</svg>'
      end
      item
        IconName = 'Implements'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M0 8h3 M' +
          '4 8h7 M12 8 h7"/>'#13#10'<polygon fill="none" stroke="#000000" points=' +
          '"19,2 25,8 19,14 19,2" />  '#13#10'</svg>'#13#10
      end
      item
        IconName = 'InstanceOf'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M0 8 h1 ' +
          'M2 8h7 M10 8h7 M18 8 h7"/>'#13#10'<polyline fill="none" stroke="#00000' +
          '0" points="19,2 25,8 19,14 " />  '#13#10'</svg>'
      end
      item
        IconName = 'Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#000000" d="M0 8h6 M' +
          '7 8h6  M14 8 h6 M21 8 h6"/>'#13#10'</svg>'
      end
      item
        IconName = 'AssociationUndirected'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M0 8h26"' +
          ' />'#13#10'</svg>'
      end
      item
        IconName = 'AssociationDirected'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M0 8h25"' +
          '/>'#13#10'<polyline fill="none" stroke="#ffffff" points="19,2 25,8 19,' +
          '14 " />  '#13#10'</svg>'
      end
      item
        IconName = 'AssociationBidirectional'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M1 8h24"' +
          '/>'#13#10'<polyline fill="none" stroke="#ffffff" points="7,2 1,8 7,14 ' +
          '" /> '#13#10'<polyline fill="none" stroke="#ffffff" points="19,2 25,8 ' +
          '19,14 " />  '#13#10'</svg>'
      end
      item
        IconName = 'Aggregation'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M13 8h13' +
          '"/>'#13#10'<polyline fill="none" stroke="#ffffff" points="7,2 1,8 7,14' +
          ' 13,8 6.6465,1.6465" />  '#13#10'</svg>'
      end
      item
        IconName = 'AggregationWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M13 8h12' +
          '"/>'#13#10'<polyline fill="none" stroke="#ffffff" points="7,2 1,8 7,14' +
          ' 13,8 6.6465,1.6465" />'#13#10'<polyline fill="none" stroke="#ffffff" ' +
          'points="19,2 25,8 19,14 " />   '#13#10'</svg>'
      end
      item
        IconName = 'Composition'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M13 8h13' +
          '"/>'#13#10'<polyline fill="#ffffff" stroke="#ffffff" points="7,2 1,8 7' +
          ',14 13,8 6.6465,1.6465" />  '#13#10'</svg>'
      end
      item
        IconName = 'CompositionWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M13 8h12' +
          '"/>'#13#10'<polyline fill="#ffffff" stroke="#ffffff" points="7,2 1,8 7' +
          ',14 13,8 6.6465,1.6465" /> '#13#10'<polyline fill="none" stroke="#ffff' +
          'ff" points="19,2 25,8 19,14 " />    '#13#10'</svg>'
      end
      item
        IconName = 'Inheritance'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M0 7.5h1' +
          '9 M0 8.5 h19"/>'#13#10'<polygon fill="none" stroke="#ffffff" points="1' +
          '9,2 25,8 19,14 19,2" />  '#13#10'</svg>'#13#10
      end
      item
        IconName = 'Implements'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M0 8h3 M' +
          '4 8h7 M12 8 h7"/>'#13#10'<polygon fill="none" stroke="#ffffff" points=' +
          '"19,2 25,8 19,14 19,2" />  '#13#10'</svg>'
      end
      item
        IconName = 'InstanceOf'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M0 8 h1 ' +
          'M2 8h7 M10 8h7 M18 8 h7"/>'#13#10'<polyline fill="none" stroke="#fffff' +
          'f" points="19,2 25,8 19,14 " />  '#13#10'</svg>'#13#10
      end
      item
        IconName = 'Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#13#10'<path stroke="#ffffff" d="M0 8h6 M' +
          '7 8h6  M14 8 h6 M21 8 h6"/>'#13#10'</svg>'
      end>
    Left = 176
    Top = 40
  end
end
