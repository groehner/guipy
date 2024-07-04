object AFrameDiagram: TAFrameDiagram
  Left = 0
  Top = 0
  Width = 600
  Height = 439
  Align = alClient
  TabOrder = 0
  TabStop = True
  object PopupMenuAlign: TSpTBXPopupMenu
    Images = vilAlignLight
    Left = 40
    Top = 200
    object MIPopupLeft: TSpTBXItem
      Tag = 1
      Caption = 'Left'
      ImageIndex = 0
      ImageName = 'Left'
      OnClick = MIPopupAlignClick
    end
    object MIPopupCentered: TSpTBXItem
      Tag = 2
      Caption = 'Center'
      ImageIndex = 1
      ImageName = 'Centered'
      OnClick = MIPopupAlignClick
    end
    object MIPopupRight: TSpTBXItem
      Tag = 3
      Caption = 'Right'
      ImageIndex = 2
      ImageName = 'Right'
      OnClick = MIPopupAlignClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIPopupTop: TSpTBXItem
      Tag = 4
      Caption = 'Top'
      ImageIndex = 3
      ImageName = 'Top'
      OnClick = MIPopupAlignClick
    end
    object MIPopupMiddle: TSpTBXItem
      Tag = 5
      Caption = 'Center'
      ImageIndex = 4
      ImageName = 'Middle'
      OnClick = MIPopupAlignClick
    end
    object MIPopupBottom: TSpTBXItem
      Tag = 6
      Caption = 'Bottom'
      ImageIndex = 5
      ImageName = 'Bottom'
      OnClick = MIPopupAlignClick
    end
  end
  object PopMenuConnection: TSpTBXPopupMenu
    Images = vilAssociationsLight
    Left = 40
    Top = 136
    object MIConnectionAssociation: TSpTBXItem
      Caption = 'Association'
      ImageIndex = 0
      ImageName = 'AssociationUndirected'
      OnClick = MIConnectionClick
    end
    object MIConnectionAssociationArrow: TSpTBXItem
      Tag = 1
      Caption = 'Association directed'
      ImageIndex = 1
      ImageName = 'AssociationDirected'
      OnClick = MIConnectionClick
    end
    object MIConnectionAssociationBidirectional: TSpTBXItem
      Tag = 2
      Caption = 'Association bidirectional'
      ImageIndex = 2
      ImageName = 'AssociationBidirectional'
      OnClick = MIConnectionClick
    end
    object MIConnectionAggregation: TSpTBXItem
      Tag = 3
      Caption = 'Aggregation'
      ImageIndex = 3
      ImageName = 'Aggregation'
      OnClick = MIConnectionClick
    end
    object MIConnectionAggregationArrow: TSpTBXItem
      Tag = 4
      Caption = 'Aggregation with arrow'
      ImageIndex = 4
      ImageName = 'AggregationWithArrow'
      OnClick = MIConnectionClick
    end
    object MIConnectionComposition: TSpTBXItem
      Tag = 5
      Caption = 'Composition'
      ImageIndex = 5
      ImageName = 'Composition'
      OnClick = MIConnectionClick
    end
    object MIConnectionCompositionArrow: TSpTBXItem
      Tag = 6
      Caption = 'Composition with arrow'
      ImageIndex = 6
      ImageName = 'CompositionWithArrow'
      OnClick = MIConnectionClick
    end
    object MIConnectionInheritance: TSpTBXItem
      Tag = 7
      Caption = 'Inheritance'
      ImageIndex = 7
      ImageName = 'Inheritance'
      OnClick = MIConnectionClick
    end
    object MIConnectionInstanceOf: TSpTBXItem
      Tag = 9
      Caption = 'Instance of'
      ImageIndex = 9
      ImageName = 'InstanceOf'
      OnClick = MIConnectionClick
    end
    object SpTBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object MIConnectionRecursiv: TSpTBXSubmenuItem
      Caption = 'Recursive relation'
      ImageIndex = 10
      ImageName = 'Recursive'
      object MIConnectionTopRight: TSpTBXItem
        Tag = 1
        Caption = 'top right'
        OnClick = MISetRecursiv
      end
      object MIConnectionTopLeft: TSpTBXItem
        Tag = 2
        Caption = 'top left'
        OnClick = MISetRecursiv
      end
      object MIConnectionBottomLeft: TSpTBXItem
        Tag = 3
        Caption = 'bottom left'
        OnClick = MISetRecursiv
      end
      object MIConnectionBottomRight: TSpTBXItem
        Tag = 4
        Caption = 'bottom right'
        OnClick = MISetRecursiv
      end
    end
    object MIConnectionEdit: TSpTBXItem
      Tag = 10
      Caption = 'Edit'
      ImageIndex = 11
      ImageName = 'Edit'
      OnClick = MIConnectionClick
    end
    object MIConnectionTurn: TSpTBXItem
      Tag = 11
      Caption = 'Turn'
      ImageIndex = 12
      ImageName = 'Turn'
      OnClick = MIConnectionClick
    end
    object MIConnectionDelete: TSpTBXItem
      Tag = 12
      Caption = 'Delete'
      ImageIndex = 13
      ImageName = 'Delete'
      OnClick = MIConnectionClick
    end
  end
  object PopupMenuComment: TSpTBXPopupMenu
    Left = 48
    Top = 320
    object PopupMenuCommentDelete: TSpTBXItem
      Caption = 'Delete'
      OnClick = PopupMenuCommentDeleteClick
    end
  end
  object PopupMenuWindow: TSpTBXPopupMenu
    Images = vilWindowLight
    OnPopup = PopupMenuWindowPopup
    Left = 40
    Top = 256
    object MIWindowPopupNewClass: TSpTBXItem
      Caption = 'New class'
      ImageIndex = 0
      ImageName = 'New'
      OnClick = MIWindowPopupNewClassClick
    end
    object MIWindowPopupOpenClass: TSpTBXItem
      Caption = 'Open class'
      ImageIndex = 1
      ImageName = 'Open'
      OnClick = MIWindowPopupOpenClassClick
    end
    object MIWindowPopupNewComment: TSpTBXItem
      Caption = 'New comment'
      ImageIndex = 3
      ImageName = 'Comment'
      OnClick = MIWindowPopupNewCommentClick
    end
    object MIWindowPopupNewLayout: TSpTBXItem
      Caption = 'New layout'
      ImageIndex = 4
      ImageName = 'NewLayout'
      OnClick = MIWindowPopupNewLayoutClick
    end
    object MIWindowPopupRefresh: TSpTBXItem
      Caption = 'Refresh'
      ImageIndex = 5
      ImageName = 'Refresh'
      OnClick = MIWindowPopupRefreshClick
    end
    object MIWindowPopupDisplay: TSpTBXSubmenuItem
      Caption = 'Attributes and Methods'
      object MIWindowPopupDisplay0: TSpTBXItem
        Tag = 3
        Caption = 'none'
        OnClick = MIWindowPopupDisplayClick
      end
      object MIWindowPopupDisplay1: TSpTBXItem
        Tag = 2
        Caption = 'public'
        OnClick = MIWindowPopupDisplayClick
      end
      object MIWindowPopupDisplay2: TSpTBXItem
        Tag = 1
        Caption = 'protected'
        OnClick = MIWindowPopupDisplayClick
      end
      object MIWindowPopupDisplay3: TSpTBXItem
        Tag = 1
        Caption = 'all'
        OnClick = MIWindowPopupDisplayClick
      end
    end
    object MIWindowPopupParameter: TSpTBXSubmenuItem
      Caption = 'Parameter'
      object MIWindowPopupParameterDisplay0: TSpTBXItem
        Caption = 'none'
        OnClick = MIWindowPopupParameterDisplayClick
      end
      object MIWindowPopupParameterDisplay1: TSpTBXItem
        Tag = 1
        Caption = ': type'
        OnClick = MIWindowPopupParameterDisplayClick
      end
      object MIWindowPopupParameterDisplay2: TSpTBXItem
        Tag = 2
        Caption = '(...): type'
        OnClick = MIWindowPopupParameterDisplayClick
      end
      object MIWindowPopupParameterDisplay3: TSpTBXItem
        Tag = 3
        Caption = '(name): type'
        OnClick = MIWindowPopupParameterDisplayClick
      end
      object MIWindowPopupParameterDisplay4: TSpTBXItem
        Tag = 4
        Caption = '(name = value): type'
        OnClick = MIWindowPopupParameterDisplayClick
      end
      object MIWindowPopupParameterDisplay5: TSpTBXItem
        Tag = 5
        Caption = '(name: type = value): type'
        OnClick = MIWindowPopupParameterDisplayClick
      end
    end
    object MIWindowPopupVisibility: TSpTBXSubmenuItem
      Caption = 'Visibility'
      object MIWindowPopupVisibilityNone: TSpTBXItem
        Tag = 2
        Caption = 'none'
        OnClick = MIWindowPopupVisibilityClick
      end
      object MIWindowPopupVisibilityText: TSpTBXItem
        Tag = 1
        Caption = 'Text'
        OnClick = MIWindowPopupVisibilityClick
      end
      object MIWindowPopupVisibilityIcon: TSpTBXItem
        Caption = 'Icon'
        OnClick = MIWindowPopupVisibilityClick
      end
    end
    object MIWindowPopupFont: TSpTBXItem
      Caption = 'Font'
      ImageIndex = 6
      ImageName = 'Font'
      OnClick = MIWindowPopupFontClick
    end
    object MIWindowPopupCopyAsPicture: TSpTBXItem
      Tag = 1
      Caption = 'Copy as picture'
      ImageIndex = 7
      ImageName = 'Copy'
      OnClick = MIWindowPopupCopyAsPictureClick
    end
    object MIWindowPopupConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 8
      ImageName = 'Configuration'
      OnClick = MIWindowPopupConfigurationClick
    end
  end
  object PopMenuObject: TSpTBXPopupMenu
    Images = vilClassObjectLight
    OnPopup = PopMenuObjectPopup
    Left = 32
    Top = 72
    object MIObjectPopupEdit: TSpTBXItem
      Tag = 1
      Caption = 'Edit'
      ImageIndex = 6
      ImageName = 'EditObject'
      OnClick = MIObjectPopupEditClick
    end
    object MIObjectPopupShowAllNewObjects: TSpTBXItem
      Tag = 1
      Caption = 'Show all new objects'
      ImageIndex = 18
      ImageName = 'ShowObjects'
      OnClick = MIObjectPopupShowAllNewObjectsClick
    end
    object MIObjectPopupShowNewObject: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Show object'
      ImageIndex = 18
      ImageName = 'ShowObjects'
    end
    object MIObjectPopupShowInherited: TSpTBXItem
      Tag = 1
      Caption = 'Show inherited methods of system classes'
      OnClick = MIObjectPopupShowInheritedClick
    end
    object MIObjectPopupHideInherited: TSpTBXItem
      Tag = 1
      Caption = 'Hide inherited methods of system classes'
      OnClick = MIObjectPopupHideInheritedClick
    end
    object MIObjectPopupDisplay: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Attributes'
      object MIObjectPopupDisplay0: TSpTBXItem
        Tag = 3
        Caption = 'none'
        OnClick = MIObjectPopupDisplayClick
      end
      object MIObjectPopupDisplay1: TSpTBXItem
        Tag = 2
        Caption = 'public'
        OnClick = MIObjectPopupDisplayClick
      end
      object MIObjectPopupDisplay2: TSpTBXItem
        Tag = 1
        Caption = 'protected'
        OnClick = MIObjectPopupDisplayClick
      end
      object MIObjectPopupDisplay3: TSpTBXItem
        Caption = 'all'
        OnClick = MIObjectPopupDisplayClick
      end
    end
    object MIObjectPopupVisibility: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Visibility'
      object MIObjectPopupVisibilityNone: TSpTBXItem
        Tag = 2
        Caption = 'none'
        OnClick = MIObjectPopupVisibilityClick
      end
      object MIObjectPopupVisibilityText: TSpTBXItem
        Tag = 1
        Caption = 'Text'
        OnClick = MIObjectPopupVisibilityClick
      end
      object MIObjectPopupVisibilityIcon: TSpTBXItem
        Caption = 'Icon'
        OnClick = MIObjectPopupVisibilityClick
      end
    end
    object MIObjectPopupDelete: TSpTBXItem
      Tag = 1
      Caption = 'Delete object'
      ImageIndex = 19
      ImageName = 'Delete'
      OnClick = MIClassPopupDeleteClick
    end
    object MIObjectPopupCopyAsPicture: TSpTBXItem
      Tag = 1
      Caption = 'Copy as picture'
      ImageIndex = 5
      ImageName = 'Copy'
      OnClick = MIClassPopupCopyAsPictureClick
    end
  end
  object PopMenuClass: TSpTBXPopupMenu
    Images = vilClassObjectLight
    OnPopup = PopMenuClassPopup
    Left = 32
    Top = 16
    object MIClassPopupRunAllTests: TSpTBXItem
      Tag = 1
      Caption = 'Run all tests'
      ImageIndex = 20
      ImageName = 'Execute'
      OnClick = MIClassPopupRunAllTestsClick
    end
    object MIClassPopupRunOneTest: TSpTBXItem
      Tag = 1
      Caption = 'Run one test'
      ImageIndex = 20
      ImageName = 'Execute'
    end
    object NEndOfJUnitTest: TSpTBXSeparatorItem
      Tag = 1
    end
    object MIClassPopupClassEdit: TSpTBXItem
      Tag = 1
      Caption = 'Edit class'
      ImageIndex = 0
      ImageName = 'EditClass'
      OnClick = MIClassPopupClassEditClick
    end
    object MIClassPopupRun: TSpTBXItem
      Tag = 1
      Caption = 'Run'
      ImageIndex = 20
      ImageName = 'Execute'
      OnClick = MIClassPopupRunClick
    end
    object MIClassPopupOpenSource: TSpTBXItem
      Tag = 1
      Caption = 'Open source code'
      ImageIndex = 21
      ImageName = 'Document'
      OnClick = MIClassPopupOpenSourceClick
    end
    object MIClassPopupConnect: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Connect with'
      ImageIndex = 17
      ImageName = 'Aggregation'
    end
    object MIClassPopupSelectAssociation: TSpTBXItem
      Tag = 1
      Caption = 'Select connection type'
      ImageIndex = 17
      ImageName = 'Aggregation'
      OnClick = MIClassPopupSelectAssociationClick
    end
    object MIClassPopupOpenClass: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Open class'
      ImageIndex = 16
      ImageName = 'ClassOpen'
    end
    object MIClassPopupNewComment: TSpTBXItem
      Tag = 1
      Caption = 'New comment'
      ImageIndex = 22
      ImageName = 'Comment'
      OnClick = MIClassPopupNewCommentClick
    end
    object MIClassPopupShowInherited: TSpTBXItem
      Tag = 1
      Caption = 'Show inherited methods of system classes'
      OnClick = MIClassPopupShowInheritedClick
    end
    object MIClassPopupHideInherited: TSpTBXItem
      Tag = 1
      Caption = 'Hide inherited methods of system classes'
      OnClick = MIClassPopupHideInheritedClick
    end
    object N1: TSpTBXSeparatorItem
    end
    object MIClassPopupDisplay: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Attributes and Methods'
      object MIClassPopupDisplay0: TSpTBXItem
        Tag = 3
        Caption = 'none'
        OnClick = MIClassPopupDisplayClick
      end
      object MIClassPopupDisplay1: TSpTBXItem
        Tag = 2
        Caption = 'public'
        OnClick = MIClassPopupDisplayClick
      end
      object MIClassPopupDisplay2: TSpTBXItem
        Tag = 1
        Caption = 'protected'
        OnClick = MIClassPopupDisplayClick
      end
      object MIClassPopupDisplay3: TSpTBXItem
        Caption = 'all'
        OnClick = MIClassPopupDisplayClick
      end
    end
    object MIClassPopupParameter: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Parameter'
      object MIClassPopupParameterDisplay0: TSpTBXItem
        Caption = 'none'
        OnClick = MIClassPopupParameterDisplayClick
      end
      object MIClassPopupParameterDisplay1: TSpTBXItem
        Tag = 1
        Caption = ': type'
        OnClick = MIClassPopupParameterDisplayClick
      end
      object MIClassPopupParameterDisplay2: TSpTBXItem
        Tag = 2
        Caption = '(...): type'
        OnClick = MIClassPopupParameterDisplayClick
      end
      object MIClassPopupParameterDisplay3: TSpTBXItem
        Tag = 3
        Caption = '(name): type'
        OnClick = MIClassPopupParameterDisplayClick
      end
      object MIClassPopupParameterDisplay4: TSpTBXItem
        Tag = 4
        Caption = '(name: type): type'
        OnClick = MIClassPopupParameterDisplayClick
      end
      object MIClassPopupParameterDisplay5: TSpTBXItem
        Tag = 5
        Caption = '(name = value): type'
        OnClick = MIClassPopupParameterDisplayClick
      end
      object MIClassPopupParameterDisplay6: TSpTBXItem
        Tag = 6
        Caption = '(name: type = value): type'
        OnClick = MIClassPopupParameterDisplayClick
      end
    end
    object MIClassPopupVisibility: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Visibility'
      object MIClassPopupVisibilityNone: TSpTBXItem
        Tag = 2
        Caption = 'none'
        OnClick = MIClassPopupVisibilityClick
      end
      object MIClassPopupVisibilityText: TSpTBXItem
        Tag = 1
        Caption = 'Text'
        OnClick = MIClassPopupVisibilityClick
      end
      object MIClassPopupVisibilityIcon: TSpTBXItem
        Caption = 'Icon'
        OnClick = MIClassPopupVisibilityClick
      end
    end
    object MIClassPopupDelete: TSpTBXItem
      Tag = 1
      Caption = 'Delete class'
      ImageIndex = 4
      ImageName = 'DeleteClass'
      OnClick = MIClassPopupDeleteClick
    end
    object MIClassPopupCopyAsPicture: TSpTBXItem
      Tag = 1
      Caption = 'Copy as picture'
      ImageIndex = 5
      ImageName = 'Copy'
      OnClick = MIClassPopupCopyAsPictureClick
    end
    object MIClassPopupCreateTestClass: TSpTBXItem
      Tag = 1
      Caption = 'Create test class'
      OnClick = MIClassPopupCreateTestClassClick
    end
  end
  object scMenuAlign: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Left'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M1 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M2 1h1M1 2h1M1 3h1M1 4h1M1 5h1M1 6' +
          'h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M1 12h1M1 13h1" />'#13#10'<path stro' +
          'ke="#000000" d="M2 2h1M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1' +
          'M2 10h1M2 11h1M2 12h1M2 13h1M1 14h2" />'#13#10'<path stroke="#4f623b" ' +
          'd="M4 2h12M4 3h1M15 3h1M4 4h1M15 4h1M4 5h1M15 5h1M4 6h12" />'#13#10'<p' +
          'ath stroke="#cedbc1" d="M5 3h1" />'#13#10'<path stroke="#b5c7a2" d="M6' +
          ' 3h6M5 4h1M5 5h1" />'#13#10'<path stroke="#b7c9a4" d="M12 3h1" />'#13#10'<pa' +
          'th stroke="#b8caa5" d="M13 3h1" />'#13#10'<path stroke="#b9caa7" d="M1' +
          '4 3h1" />'#13#10'<path stroke="#90ab73" d="M6 4h3M6 5h2" />'#13#10'<path str' +
          'oke="#92ad75" d="M9 4h1M8 5h1" />'#13#10'<path stroke="#97b17d" d="M10' +
          ' 4h1" />'#13#10'<path stroke="#99b37e" d="M11 4h1M10 5h1" />'#13#10'<path st' +
          'roke="#9bb481" d="M12 4h1M11 5h1" />'#13#10'<path stroke="#9db683" d="' +
          'M13 4h1" />'#13#10'<path stroke="#9fb786" d="M14 4h1" />'#13#10'<path stroke' +
          '="#93ae78" d="M9 5h1" />'#13#10'<path stroke="#9cb582" d="M12 5h1" />'#13 +
          #10'<path stroke="#9eb685" d="M13 5h1" />'#13#10'<path stroke="#a0b887" d' +
          '="M14 5h1" />'#13#10'<path stroke="#344f6b" d="M4 8h7M4 9h1M10 9h1M4 1' +
          '0h1M10 10h1M4 11h1M10 11h1M4 12h7" />'#13#10'<path stroke="#c2cddb" d=' +
          '"M5 9h1" />'#13#10'<path stroke="#a3b4c8" d="M6 9h2M5 10h1M5 11h1" />'#13 +
          #10'<path stroke="#a3b5c8" d="M8 9h1" />'#13#10'<path stroke="#a5b6c9" d=' +
          '"M9 9h1" />'#13#10'<path stroke="#7a94b2" d="M6 10h1" />'#13#10'<path stroke' +
          '="#7c96b3" d="M7 10h1M6 11h1" />'#13#10'<path stroke="#7e98b5" d="M8 1' +
          '0h1M7 11h1" />'#13#10'<path stroke="#809ab7" d="M9 10h1M8 11h1" />'#13#10'<p' +
          'ath stroke="#829cb8" d="M9 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Centered'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M7 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M8 1h1M7 2h1M7 3h1M7 4h1M7 5h1M7 6' +
          'h1M7 7h1M7 8h1M7 9h1M7 10h1M7 11h1M7 12h1M7 13h1" />'#13#10'<path stro' +
          'ke="#4f623b" d="M2 2h5M9 2h5M2 3h1M13 3h1M2 4h1M13 4h1M2 5h1M13 ' +
          '5h1M2 6h5M9 6h5" />'#13#10'<path stroke="#000000" d="M8 2h1M8 3h1M8 4h' +
          '1M8 5h1M8 6h1M8 7h1M8 8h1M8 9h1M8 10h1M8 11h1M8 12h1M8 13h1M7 14' +
          'h2" />'#13#10'<path stroke="#cedbc1" d="M3 3h1" />'#13#10'<path stroke="#b5c' +
          '7a2" d="M4 3h3M9 3h1M3 4h1M3 5h1" />'#13#10'<path stroke="#b7c9a4" d="' +
          'M10 3h1" />'#13#10'<path stroke="#b8caa5" d="M11 3h1" />'#13#10'<path stroke' +
          '="#b9caa7" d="M12 3h1" />'#13#10'<path stroke="#90ab73" d="M4 4h3M4 5h' +
          '2" />'#13#10'<path stroke="#99b37e" d="M9 4h1" />'#13#10'<path stroke="#9bb4' +
          '81" d="M10 4h1M9 5h1" />'#13#10'<path stroke="#9db683" d="M11 4h1" />'#13 +
          #10'<path stroke="#9fb786" d="M12 4h1" />'#13#10'<path stroke="#92ad75" d' +
          '="M6 5h1" />'#13#10'<path stroke="#9cb582" d="M10 5h1" />'#13#10'<path strok' +
          'e="#9eb685" d="M11 5h1" />'#13#10'<path stroke="#a0b887" d="M12 5h1" /' +
          '>'#13#10'<path stroke="#344f6b" d="M4 8h3M9 8h3M4 9h1M11 9h1M4 10h1M11' +
          ' 10h1M4 11h1M11 11h1M4 12h3M9 12h3" />'#13#10'<path stroke="#c2cddb" d' +
          '="M5 9h1" />'#13#10'<path stroke="#a3b4c8" d="M6 9h1M5 10h1M5 11h1" />' +
          #13#10'<path stroke="#a3b5c8" d="M9 9h1" />'#13#10'<path stroke="#a5b6c9" d' +
          '="M10 9h1" />'#13#10'<path stroke="#7a94b2" d="M6 10h1" />'#13#10'<path stro' +
          'ke="#7e98b5" d="M9 10h1" />'#13#10'<path stroke="#809ab7" d="M10 10h1M' +
          '9 11h1" />'#13#10'<path stroke="#7c96b3" d="M6 11h1" />'#13#10'<path stroke=' +
          '"#829cb8" d="M10 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Right'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M13 1h1"' +
          ' />'#13#10'<path stroke="#565249" d="M14 1h1M13 2h1M13 3h1M13 4h1M13 5' +
          'h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M13 13h1" ' +
          '/>'#13#10'<path stroke="#4f623b" d="M0 2h12M0 3h1M11 3h1M0 4h1M11 4h1M' +
          '0 5h1M11 5h1M0 6h12" />'#13#10'<path stroke="#000000" d="M14 2h1M14 3h' +
          '1M14 4h1M14 5h1M14 6h1M14 7h1M14 8h1M14 9h1M14 10h1M14 11h1M14 1' +
          '2h1M14 13h1M13 14h2" />'#13#10'<path stroke="#cedbc1" d="M1 3h1" />'#13#10'<' +
          'path stroke="#b5c7a2" d="M2 3h6M1 4h1M1 5h1" />'#13#10'<path stroke="#' +
          'b7c9a4" d="M8 3h1" />'#13#10'<path stroke="#b8caa5" d="M9 3h1" />'#13#10'<pa' +
          'th stroke="#b9caa7" d="M10 3h1" />'#13#10'<path stroke="#90ab73" d="M2' +
          ' 4h3M2 5h2" />'#13#10'<path stroke="#92ad75" d="M5 4h1M4 5h1" />'#13#10'<pat' +
          'h stroke="#97b17d" d="M6 4h1" />'#13#10'<path stroke="#99b37e" d="M7 4' +
          'h1M6 5h1" />'#13#10'<path stroke="#9bb481" d="M8 4h1M7 5h1" />'#13#10'<path ' +
          'stroke="#9db683" d="M9 4h1" />'#13#10'<path stroke="#9fb786" d="M10 4h' +
          '1" />'#13#10'<path stroke="#93ae78" d="M5 5h1" />'#13#10'<path stroke="#9cb5' +
          '82" d="M8 5h1" />'#13#10'<path stroke="#9eb685" d="M9 5h1" />'#13#10'<path s' +
          'troke="#a0b887" d="M10 5h1" />'#13#10'<path stroke="#344f6b" d="M5 8h7' +
          'M5 9h1M11 9h1M5 10h1M11 10h1M5 11h1M11 11h1M5 12h7" />'#13#10'<path st' +
          'roke="#c2cddb" d="M6 9h1" />'#13#10'<path stroke="#a3b4c8" d="M7 9h2M6' +
          ' 10h1M6 11h1" />'#13#10'<path stroke="#a3b5c8" d="M9 9h1" />'#13#10'<path st' +
          'roke="#a5b6c9" d="M10 9h1" />'#13#10'<path stroke="#7a94b2" d="M7 10h1' +
          '" />'#13#10'<path stroke="#7c96b3" d="M8 10h1M7 11h1" />'#13#10'<path stroke' +
          '="#7e98b5" d="M9 10h1M8 11h1" />'#13#10'<path stroke="#809ab7" d="M10 ' +
          '10h1M9 11h1" />'#13#10'<path stroke="#829cb8" d="M10 11h1" />'#13#10'</svg>'#13 +
          #10
      end
      item
        IconName = 'Top'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#7e7c73" d="M1 1h1" ' +
          '/>'#13#10'<path stroke="#565249" d="M2 1h12M1 2h1" />'#13#10'<path stroke="#' +
          '000000" d="M14 1h1M2 2h13" />'#13#10'<path stroke="#4f623b" d="M3 4h5M' +
          '3 5h1M7 5h1M3 6h1M7 6h1M3 7h1M7 7h1M3 8h1M7 8h1M3 9h1M7 9h1M3 10' +
          'h1M7 10h1M3 11h1M7 11h1M3 12h1M7 12h1M3 13h1M7 13h1M3 14h5" />'#13#10 +
          '<path stroke="#344f6b" d="M9 4h5M9 5h1M13 5h1M9 6h1M13 6h1M9 7h1' +
          'M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10h1M13 10h1M9 11h5" />'#13#10'<pa' +
          'th stroke="#cedbc1" d="M4 5h1" />'#13#10'<path stroke="#b5c7a2" d="M5 ' +
          '5h2M4 6h1M4 7h1M4 8h1M4 9h1M4 10h1" />'#13#10'<path stroke="#c2cddb" d' +
          '="M10 5h1" />'#13#10'<path stroke="#a3b4c8" d="M11 5h2M10 6h1M10 7h1" ' +
          '/>'#13#10'<path stroke="#90ab73" d="M5 6h2M5 7h2M5 8h1" />'#13#10'<path stro' +
          'ke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<path stroke="#7c96b3" d="M1' +
          '2 6h1M12 7h1" />'#13#10'<path stroke="#92ad75" d="M6 8h1M5 9h1" />'#13#10'<p' +
          'ath stroke="#a3b5c8" d="M10 8h1M10 9h1" />'#13#10'<path stroke="#7e98b' +
          '5" d="M11 8h1M11 9h1" />'#13#10'<path stroke="#809ab7" d="M12 8h1M12 9' +
          'h1M11 10h1" />'#13#10'<path stroke="#93ae78" d="M6 9h1" />'#13#10'<path stro' +
          'ke="#99b37e" d="M5 10h1" />'#13#10'<path stroke="#9bb481" d="M6 10h1M5' +
          ' 11h1" />'#13#10'<path stroke="#a5b6c9" d="M10 10h1" />'#13#10'<path stroke=' +
          '"#829cb8" d="M12 10h1" />'#13#10'<path stroke="#b7c9a4" d="M4 11h1" />' +
          #13#10'<path stroke="#9cb582" d="M6 11h1" />'#13#10'<path stroke="#b8caa5" ' +
          'd="M4 12h1" />'#13#10'<path stroke="#9db683" d="M5 12h1" />'#13#10'<path str' +
          'oke="#9eb685" d="M6 12h1" />'#13#10'<path stroke="#b9caa7" d="M4 13h1"' +
          ' />'#13#10'<path stroke="#9fb786" d="M5 13h1" />'#13#10'<path stroke="#a0b88' +
          '7" d="M6 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Middle'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M2 2h5M2' +
          ' 3h1M6 3h1M2 4h1M6 4h1M2 5h1M6 5h1M2 6h1M6 6h1M2 9h1M6 9h1M2 10h' +
          '1M6 10h1M2 11h1M6 11h1M2 12h1M6 12h1M2 13h5" />'#13#10'<path stroke="#' +
          'cedbc1" d="M3 3h1" />'#13#10'<path stroke="#b5c7a2" d="M4 3h2M3 4h1M3 ' +
          '5h1M3 6h1M3 9h1" />'#13#10'<path stroke="#90ab73" d="M4 4h2M4 5h2M4 6h' +
          '1" />'#13#10'<path stroke="#344f6b" d="M8 4h5M8 5h1M12 5h1M8 6h1M12 6h' +
          '1M8 9h1M12 9h1M8 10h1M12 10h1M8 11h5" />'#13#10'<path stroke="#c2cddb"' +
          ' d="M9 5h1" />'#13#10'<path stroke="#a3b4c8" d="M10 5h2M9 6h1" />'#13#10'<pa' +
          'th stroke="#92ad75" d="M5 6h1" />'#13#10'<path stroke="#7a94b2" d="M10' +
          ' 6h1" />'#13#10'<path stroke="#7c96b3" d="M11 6h1" />'#13#10'<path stroke="#' +
          '7e7c73" d="M1 7h1" />'#13#10'<path stroke="#565249" d="M2 7h12M1 8h1" ' +
          '/>'#13#10'<path stroke="#000000" d="M14 7h1M2 8h13" />'#13#10'<path stroke="' +
          '#99b37e" d="M4 9h1" />'#13#10'<path stroke="#9bb481" d="M5 9h1M4 10h1"' +
          ' />'#13#10'<path stroke="#a3b5c8" d="M9 9h1" />'#13#10'<path stroke="#7e98b5' +
          '" d="M10 9h1" />'#13#10'<path stroke="#809ab7" d="M11 9h1M10 10h1" />'#13 +
          #10'<path stroke="#b7c9a4" d="M3 10h1" />'#13#10'<path stroke="#9cb582" d' +
          '="M5 10h1" />'#13#10'<path stroke="#a5b6c9" d="M9 10h1" />'#13#10'<path stro' +
          'ke="#829cb8" d="M11 10h1" />'#13#10'<path stroke="#b8caa5" d="M3 11h1"' +
          ' />'#13#10'<path stroke="#9db683" d="M4 11h1" />'#13#10'<path stroke="#9eb68' +
          '5" d="M5 11h1" />'#13#10'<path stroke="#b9caa7" d="M3 12h1" />'#13#10'<path ' +
          'stroke="#9fb786" d="M4 12h1" />'#13#10'<path stroke="#a0b887" d="M5 12' +
          'h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Bottom'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M3 1h5M3' +
          ' 2h1M7 2h1M3 3h1M7 3h1M3 4h1M7 4h1M3 5h1M7 5h1M3 6h1M7 6h1M3 7h1' +
          'M7 7h1M3 8h1M7 8h1M3 9h1M7 9h1M3 10h1M7 10h1M3 11h5" />'#13#10'<path s' +
          'troke="#cedbc1" d="M4 2h1" />'#13#10'<path stroke="#b5c7a2" d="M5 2h2M' +
          '4 3h1M4 4h1M4 5h1M4 6h1M4 7h1" />'#13#10'<path stroke="#90ab73" d="M5 ' +
          '3h2M5 4h2M5 5h1" />'#13#10'<path stroke="#344f6b" d="M9 4h5M9 5h1M13 5' +
          'h1M9 6h1M13 6h1M9 7h1M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10h1M13' +
          ' 10h1M9 11h5" />'#13#10'<path stroke="#92ad75" d="M6 5h1M5 6h1" />'#13#10'<p' +
          'ath stroke="#c2cddb" d="M10 5h1" />'#13#10'<path stroke="#a3b4c8" d="M' +
          '11 5h2M10 6h1M10 7h1" />'#13#10'<path stroke="#93ae78" d="M6 6h1" />'#13#10 +
          '<path stroke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<path stroke="#7c9' +
          '6b3" d="M12 6h1M12 7h1" />'#13#10'<path stroke="#99b37e" d="M5 7h1" />' +
          #13#10'<path stroke="#9bb481" d="M6 7h1M5 8h1" />'#13#10'<path stroke="#b7c' +
          '9a4" d="M4 8h1" />'#13#10'<path stroke="#9cb582" d="M6 8h1" />'#13#10'<path ' +
          'stroke="#a3b5c8" d="M10 8h1M10 9h1" />'#13#10'<path stroke="#7e98b5" d' +
          '="M11 8h1M11 9h1" />'#13#10'<path stroke="#809ab7" d="M12 8h1M12 9h1M1' +
          '1 10h1" />'#13#10'<path stroke="#b8caa5" d="M4 9h1" />'#13#10'<path stroke="' +
          '#9db683" d="M5 9h1" />'#13#10'<path stroke="#9eb685" d="M6 9h1" />'#13#10'<p' +
          'ath stroke="#b9caa7" d="M4 10h1" />'#13#10'<path stroke="#9fb786" d="M' +
          '5 10h1" />'#13#10'<path stroke="#a0b887" d="M6 10h1" />'#13#10'<path stroke=' +
          '"#a5b6c9" d="M10 10h1" />'#13#10'<path stroke="#829cb8" d="M12 10h1" /' +
          '>'#13#10'<path stroke="#7e7c73" d="M1 13h1" />'#13#10'<path stroke="#565249"' +
          ' d="M2 13h12M1 14h1" />'#13#10'<path stroke="#000000" d="M14 13h1M2 14' +
          'h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Left'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M1 1h2M1' +
          ' 2h1M1 3h1M1 4h1M1 5h1M1 6h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M1 1' +
          '2h1M1 13h1" />'#13#10'<path stroke="#ffffff" d="M2 2h1M2 3h1M2 4h1M2 5' +
          'h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12h1M2 13h1M1 14h2" /' +
          '>'#13#10'<path stroke="#4f623b" d="M4 2h12M4 3h1M15 3h1M4 4h1M15 4h1M4' +
          ' 5h1M15 5h1M4 6h12" />'#13#10'<path stroke="#cedbc1" d="M5 3h1" />'#13#10'<p' +
          'ath stroke="#b5c7a2" d="M6 3h6M5 4h1M5 5h1" />'#13#10'<path stroke="#b' +
          '7c9a4" d="M12 3h1" />'#13#10'<path stroke="#b8caa5" d="M13 3h1" />'#13#10'<p' +
          'ath stroke="#b9caa7" d="M14 3h1" />'#13#10'<path stroke="#90ab73" d="M' +
          '6 4h3M6 5h2" />'#13#10'<path stroke="#92ad75" d="M9 4h1M8 5h1" />'#13#10'<pa' +
          'th stroke="#97b17d" d="M10 4h1" />'#13#10'<path stroke="#99b37e" d="M1' +
          '1 4h1M10 5h1" />'#13#10'<path stroke="#9bb481" d="M12 4h1M11 5h1" />'#13#10 +
          '<path stroke="#9db683" d="M13 4h1" />'#13#10'<path stroke="#9fb786" d=' +
          '"M14 4h1" />'#13#10'<path stroke="#93ae78" d="M9 5h1" />'#13#10'<path stroke' +
          '="#9cb582" d="M12 5h1" />'#13#10'<path stroke="#9eb685" d="M13 5h1" />' +
          #13#10'<path stroke="#a0b887" d="M14 5h1" />'#13#10'<path stroke="#344f6b" ' +
          'd="M4 8h7M4 9h1M10 9h1M4 10h1M10 10h1M4 11h1M10 11h1M4 12h7" />'#13 +
          #10'<path stroke="#c2cddb" d="M5 9h1" />'#13#10'<path stroke="#a3b4c8" d=' +
          '"M6 9h2M5 10h1M5 11h1" />'#13#10'<path stroke="#a3b5c8" d="M8 9h1" />'#13 +
          #10'<path stroke="#a5b6c9" d="M9 9h1" />'#13#10'<path stroke="#7a94b2" d=' +
          '"M6 10h1" />'#13#10'<path stroke="#7c96b3" d="M7 10h1M6 11h1" />'#13#10'<pat' +
          'h stroke="#7e98b5" d="M8 10h1M7 11h1" />'#13#10'<path stroke="#809ab7"' +
          ' d="M9 10h1M8 11h1" />'#13#10'<path stroke="#829cb8" d="M9 11h1" />'#13#10'<' +
          '/svg>'#13#10
      end
      item
        IconName = 'Centered'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M7 1h2 M' +
          '7 2h1M7 3h1M7 4h1M7 5h1M7 6h1M7 7h1M7 8h1M7 9h1M7 10h1M7 11h1M7 ' +
          '12h1M7 13h1" />'#13#10'<path stroke="#4f623b" d="M2 2h5M9 2h5M2 3h1M13' +
          ' 3h1M2 4h1M13 4h1M2 5h1M13 5h1M2 6h5M9 6h5" />'#13#10'<path stroke="#f' +
          'fffff" d="M8 2h1M8 3h1M8 4h1M8 5h1M8 6h1M8 7h1M8 8h1M8 9h1M8 10h' +
          '1M8 11h1M8 12h1M8 13h1M7 14h2" />'#13#10'<path stroke="#cedbc1" d="M3 ' +
          '3h1" />'#13#10'<path stroke="#b5c7a2" d="M4 3h3M9 3h1M3 4h1M3 5h1" />'#13 +
          #10'<path stroke="#b7c9a4" d="M10 3h1" />'#13#10'<path stroke="#b8caa5" d' +
          '="M11 3h1" />'#13#10'<path stroke="#b9caa7" d="M12 3h1" />'#13#10'<path stro' +
          'ke="#90ab73" d="M4 4h3M4 5h2" />'#13#10'<path stroke="#99b37e" d="M9 4' +
          'h1" />'#13#10'<path stroke="#9bb481" d="M10 4h1M9 5h1" />'#13#10'<path strok' +
          'e="#9db683" d="M11 4h1" />'#13#10'<path stroke="#9fb786" d="M12 4h1" /' +
          '>'#13#10'<path stroke="#92ad75" d="M6 5h1" />'#13#10'<path stroke="#9cb582" ' +
          'd="M10 5h1" />'#13#10'<path stroke="#9eb685" d="M11 5h1" />'#13#10'<path str' +
          'oke="#a0b887" d="M12 5h1" />'#13#10'<path stroke="#344f6b" d="M4 8h3M9' +
          ' 8h3M4 9h1M11 9h1M4 10h1M11 10h1M4 11h1M11 11h1M4 12h3M9 12h3" /' +
          '>'#13#10'<path stroke="#c2cddb" d="M5 9h1" />'#13#10'<path stroke="#a3b4c8" ' +
          'd="M6 9h1M5 10h1M5 11h1" />'#13#10'<path stroke="#a3b5c8" d="M9 9h1" /' +
          '>'#13#10'<path stroke="#a5b6c9" d="M10 9h1" />'#13#10'<path stroke="#7a94b2"' +
          ' d="M6 10h1" />'#13#10'<path stroke="#7e98b5" d="M9 10h1" />'#13#10'<path st' +
          'roke="#809ab7" d="M10 10h1M9 11h1" />'#13#10'<path stroke="#7c96b3" d=' +
          '"M6 11h1" />'#13#10'<path stroke="#829cb8" d="M10 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Right'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M13 1h2M' +
          '13 2h1M13 3h1M13 4h1M13 5h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M' +
          '13 11h1M13 12h1M13 13h1" />'#13#10'<path stroke="#4f623b" d="M0 2h12M0' +
          ' 3h1M11 3h1M0 4h1M11 4h1M0 5h1M11 5h1M0 6h12" />'#13#10'<path stroke="' +
          '#ffffff" d="M14 2h1M14 3h1M14 4h1M14 5h1M14 6h1M14 7h1M14 8h1M14' +
          ' 9h1M14 10h1M14 11h1M14 12h1M14 13h1M13 14h2" />'#13#10'<path stroke="' +
          '#cedbc1" d="M1 3h1" />'#13#10'<path stroke="#b5c7a2" d="M2 3h6M1 4h1M1' +
          ' 5h1" />'#13#10'<path stroke="#b7c9a4" d="M8 3h1" />'#13#10'<path stroke="#b' +
          '8caa5" d="M9 3h1" />'#13#10'<path stroke="#b9caa7" d="M10 3h1" />'#13#10'<pa' +
          'th stroke="#90ab73" d="M2 4h3M2 5h2" />'#13#10'<path stroke="#92ad75" ' +
          'd="M5 4h1M4 5h1" />'#13#10'<path stroke="#97b17d" d="M6 4h1" />'#13#10'<path' +
          ' stroke="#99b37e" d="M7 4h1M6 5h1" />'#13#10'<path stroke="#9bb481" d=' +
          '"M8 4h1M7 5h1" />'#13#10'<path stroke="#9db683" d="M9 4h1" />'#13#10'<path s' +
          'troke="#9fb786" d="M10 4h1" />'#13#10'<path stroke="#93ae78" d="M5 5h1' +
          '" />'#13#10'<path stroke="#9cb582" d="M8 5h1" />'#13#10'<path stroke="#9eb68' +
          '5" d="M9 5h1" />'#13#10'<path stroke="#a0b887" d="M10 5h1" />'#13#10'<path s' +
          'troke="#344f6b" d="M5 8h7M5 9h1M11 9h1M5 10h1M11 10h1M5 11h1M11 ' +
          '11h1M5 12h7" />'#13#10'<path stroke="#c2cddb" d="M6 9h1" />'#13#10'<path str' +
          'oke="#a3b4c8" d="M7 9h2M6 10h1M6 11h1" />'#13#10'<path stroke="#a3b5c8' +
          '" d="M9 9h1" />'#13#10'<path stroke="#a5b6c9" d="M10 9h1" />'#13#10'<path st' +
          'roke="#7a94b2" d="M7 10h1" />'#13#10'<path stroke="#7c96b3" d="M8 10h1' +
          'M7 11h1" />'#13#10'<path stroke="#7e98b5" d="M9 10h1M8 11h1" />'#13#10'<path' +
          ' stroke="#809ab7" d="M10 10h1M9 11h1" />'#13#10'<path stroke="#829cb8"' +
          ' d="M10 11h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Top'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#eeeeee" d="M1 1h13M' +
          '1 2h1" />'#13#10'<path stroke="#ffffff" d="M14 1h1M2 2h13" />'#13#10'<path s' +
          'troke="#4f623b" d="M3 4h5M3 5h1M7 5h1M3 6h1M7 6h1M3 7h1M7 7h1M3 ' +
          '8h1M7 8h1M3 9h1M7 9h1M3 10h1M7 10h1M3 11h1M7 11h1M3 12h1M7 12h1M' +
          '3 13h1M7 13h1M3 14h5" />'#13#10'<path stroke="#344f6b" d="M9 4h5M9 5h1' +
          'M13 5h1M9 6h1M13 6h1M9 7h1M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10' +
          'h1M13 10h1M9 11h5" />'#13#10'<path stroke="#cedbc1" d="M4 5h1" />'#13#10'<pa' +
          'th stroke="#b5c7a2" d="M5 5h2M4 6h1M4 7h1M4 8h1M4 9h1M4 10h1" />' +
          #13#10'<path stroke="#c2cddb" d="M10 5h1" />'#13#10'<path stroke="#a3b4c8" ' +
          'd="M11 5h2M10 6h1M10 7h1" />'#13#10'<path stroke="#90ab73" d="M5 6h2M5' +
          ' 7h2M5 8h1" />'#13#10'<path stroke="#7a94b2" d="M11 6h1M11 7h1" />'#13#10'<p' +
          'ath stroke="#7c96b3" d="M12 6h1M12 7h1" />'#13#10'<path stroke="#92ad7' +
          '5" d="M6 8h1M5 9h1" />'#13#10'<path stroke="#a3b5c8" d="M10 8h1M10 9h1' +
          '" />'#13#10'<path stroke="#7e98b5" d="M11 8h1M11 9h1" />'#13#10'<path stroke' +
          '="#809ab7" d="M12 8h1M12 9h1M11 10h1" />'#13#10'<path stroke="#93ae78"' +
          ' d="M6 9h1" />'#13#10'<path stroke="#99b37e" d="M5 10h1" />'#13#10'<path str' +
          'oke="#9bb481" d="M6 10h1M5 11h1" />'#13#10'<path stroke="#a5b6c9" d="M' +
          '10 10h1" />'#13#10'<path stroke="#829cb8" d="M12 10h1" />'#13#10'<path strok' +
          'e="#b7c9a4" d="M4 11h1" />'#13#10'<path stroke="#9cb582" d="M6 11h1" /' +
          '>'#13#10'<path stroke="#b8caa5" d="M4 12h1" />'#13#10'<path stroke="#9db683"' +
          ' d="M5 12h1" />'#13#10'<path stroke="#9eb685" d="M6 12h1" />'#13#10'<path st' +
          'roke="#b9caa7" d="M4 13h1" />'#13#10'<path stroke="#9fb786" d="M5 13h1' +
          '" />'#13#10'<path stroke="#a0b887" d="M6 13h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Middle'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4f623b" d="M2 2h5M2' +
          ' 3h1M6 3h1M2 4h1M6 4h1M2 5h1M6 5h1M2 6h1M6 6h1M2 9h1M6 9h1M2 10h' +
          '1M6 10h1M2 11h1M6 11h1M2 12h1M6 12h1M2 13h5" />'#13#10'<path stroke="#' +
          'cedbc1" d="M3 3h1" />'#13#10'<path stroke="#b5c7a2" d="M4 3h2M3 4h1M3 ' +
          '5h1M3 6h1M3 9h1" />'#13#10'<path stroke="#90ab73" d="M4 4h2M4 5h2M4 6h' +
          '1" />'#13#10'<path stroke="#344f6b" d="M8 4h5M8 5h1M12 5h1M8 6h1M12 6h' +
          '1M8 9h1M12 9h1M8 10h1M12 10h1M8 11h5" />'#13#10'<path stroke="#c2cddb"' +
          ' d="M9 5h1" />'#13#10'<path stroke="#a3b4c8" d="M10 5h2M9 6h1" />'#13#10'<pa' +
          'th stroke="#92ad75" d="M5 6h1" />'#13#10'<path stroke="#7a94b2" d="M10' +
          ' 6h1" />'#13#10'<path stroke="#7c96b3" d="M11 6h1" />'#13#10'<path stroke="#' +
          'eeeeee" d="M1 7h13M1 8h1" />'#13#10'<path stroke="#ffffff" d="M14 7h1M' +
          '2 8h13" />'#13#10'<path stroke="#99b37e" d="M4 9h1" />'#13#10'<path stroke="' +
          '#9bb481" d="M5 9h1M4 10h1" />'#13#10'<path stroke="#a3b5c8" d="M9 9h1"' +
          ' />'#13#10'<path stroke="#7e98b5" d="M10 9h1" />'#13#10'<path stroke="#809ab' +
          '7" d="M11 9h1M10 10h1" />'#13#10'<path stroke="#b7c9a4" d="M3 10h1" />' +
          #13#10'<path stroke="#9cb582" d="M5 10h1" />'#13#10'<path stroke="#a5b6c9" ' +
          'd="M9 10h1" />'#13#10'<path stroke="#829cb8" d="M11 10h1" />'#13#10'<path st' +
          'roke="#b8caa5" d="M3 11h1" />'#13#10'<path stroke="#9db683" d="M4 11h1' +
          '" />'#13#10'<path stroke="#9eb685" d="M5 11h1" />'#13#10'<path stroke="#b9ca' +
          'a7" d="M3 12h1" />'#13#10'<path stroke="#9fb786" d="M4 12h1" />'#13#10'<path' +
          ' stroke="#a0b887" d="M5 12h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Bottom'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#10'<path stroke="#4f623b" d="M3 1h5M3 ' +
          '2h1M7 2h1M3 3h1M7 3h1M3 4h1M7 4h1M3 5h1M7 5h1M3 6h1M7 6h1M3 7h1M' +
          '7 7h1M3 8h1M7 8h1M3 9h1M7 9h1M3 10h1M7 10h1M3 11h5" />'#10'<path str' +
          'oke="#cedbc1" d="M4 2h1" />'#10'<path stroke="#b5c7a2" d="M5 2h2M4 3' +
          'h1M4 4h1M4 5h1M4 6h1M4 7h1" />'#10'<path stroke="#90ab73" d="M5 3h2M' +
          '5 4h2M5 5h1" />'#10'<path stroke="#344f6b" d="M9 4h5M9 5h1M13 5h1M9 ' +
          '6h1M13 6h1M9 7h1M13 7h1M9 8h1M13 8h1M9 9h1M13 9h1M9 10h1M13 10h1' +
          'M9 11h5" />'#10'<path stroke="#92ad75" d="M6 5h1M5 6h1" />'#10'<path str' +
          'oke="#c2cddb" d="M10 5h1" />'#10'<path stroke="#a3b4c8" d="M11 5h2M1' +
          '0 6h1M10 7h1" />'#10'<path stroke="#93ae78" d="M6 6h1" />'#10'<path stro' +
          'ke="#7a94b2" d="M11 6h1M11 7h1" />'#10'<path stroke="#7c96b3" d="M12' +
          ' 6h1M12 7h1" />'#10'<path stroke="#99b37e" d="M5 7h1" />'#10'<path strok' +
          'e="#9bb481" d="M6 7h1M5 8h1" />'#10'<path stroke="#b7c9a4" d="M4 8h1' +
          '" />'#10'<path stroke="#9cb582" d="M6 8h1" />'#10'<path stroke="#a3b5c8"' +
          ' d="M10 8h1M10 9h1" />'#10'<path stroke="#7e98b5" d="M11 8h1M11 9h1"' +
          ' />'#10'<path stroke="#809ab7" d="M12 8h1M12 9h1M11 10h1" />'#10'<path s' +
          'troke="#b8caa5" d="M4 9h1" />'#10'<path stroke="#9db683" d="M5 9h1" ' +
          '/>'#10'<path stroke="#9eb685" d="M6 9h1" />'#10'<path stroke="#b9caa7" d' +
          '="M4 10h1" />'#10'<path stroke="#9fb786" d="M5 10h1" />'#10'<path stroke' +
          '="#a0b887" d="M6 10h1" />'#10'<path stroke="#a5b6c9" d="M10 10h1" />' +
          #10'<path stroke="#829cb8" d="M12 10h1" />'#10'<path stroke="#eeeeee" d' +
          '="M1 13h14" />'#10'<path stroke="#ffffff" d="M14 13h1M2 14h13" />'#10'</' +
          'svg>'#10
      end>
    Left = 152
    Top = 192
  end
  object vilAlignLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Left'
        Name = 'Left'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Centered'
        Name = 'Centered'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Right'
        Name = 'Right'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Top'
        Name = 'Top'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Middle'
        Name = 'Middle'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Bottom'
        Name = 'Bottom'
      end>
    ImageCollection = scMenuAlign
    Left = 272
    Top = 192
  end
  object vilAlignDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 6
        CollectionName = 'Left'
        Name = 'Left'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Centered'
        Name = 'Centered'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Right'
        Name = 'Right'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Top'
        Name = 'Top'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Middle'
        Name = 'Middle'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Bottom'
        Name = 'Bottom'
      end>
    ImageCollection = scMenuAlign
    Left = 384
    Top = 192
  end
  object icMenuWindow: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'New'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M4 0h1M4' +
          ' 2h1M0 4h1M4 4h1M7 4h8M3 5h1M5 5h10M2 6h1M7 6h8M4 7h1M0 8h1M2 8h' +
          '1M5 8h1M7 8h8M2 9h13M2 10h13M2 12h13M2 13h13M2 14h13" />'#13#10'<path ' +
          'stroke="#ffff36" d="M0 1h1M4 1h1M1 2h1M7 2h1M2 3h1M4 3h1M6 3h1M3' +
          ' 4h1M4 6h1M6 6h1M1 7h2M5 7h1M7 7h1M4 8h1M6 8h1" />'#13#10'<path stroke' +
          '="#979797" d="M3 1h1M7 1h1M0 2h1M3 2h1M6 2h1M1 3h1M3 3h1M5 3h1M8' +
          ' 3h1M2 4h1M5 4h2M0 5h3M4 5h1M1 6h1M3 6h1M5 6h1M0 7h1M3 7h1M6 7h1' +
          'M3 8h1" />'#13#10'<path stroke="#000000" d="M7 3h1M9 3h7M15 4h1M15 5h1' +
          'M15 6h1M8 7h8M15 8h1M15 9h1M1 10h1M15 10h1M1 11h15M1 12h1M15 12h' +
          '1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<path stroke="#ffff' +
          '65" d="M1 4h1" />'#13#10'<path stroke="#363665" d="M1 8h1" />'#13#10'<path s' +
          'troke="#363636" d="M1 9h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Open'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a74d50" d="M5 0h1" ' +
          '/>'#13#10'<path stroke="#a44e4e" d="M6 0h3M9 1h1M10 2h1M9 3h2" />'#13#10'<pa' +
          'th stroke="#a45050" d="M4 1h3M10 4h1" />'#13#10'<path stroke="#a44f4f"' +
          ' d="M7 1h1" />'#13#10'<path stroke="#a45353" d="M8 1h1" />'#13#10'<path stro' +
          'ke="#ad4c55" d="M3 2h1" />'#13#10'<path stroke="#ac4c55" d="M4 2h1" />' +
          #13#10'<path stroke="#a55759" d="M5 2h1" />'#13#10'<path stroke="#a94d52" d' +
          '="M9 2h1" />'#13#10'<path stroke="#a44e4f" d="M12 2h1" />'#13#10'<path strok' +
          'e="#000000" d="M1 3h8M14 3h2M1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 ' +
          '6h1M1 7h15M1 8h1M15 8h1M1 9h1M15 9h1M1 10h1M15 10h1M1 11h15M1 12' +
          'h1M15 12h1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<path stro' +
          'ke="#a45252" d="M11 3h1" />'#13#10'<path stroke="#a34f4f" d="M12 3h1" ' +
          '/>'#13#10'<path stroke="#0d0808" d="M13 3h1" />'#13#10'<path stroke="#ffffff' +
          '" d="M2 4h7M13 4h2M2 5h7M13 5h2M2 6h9M12 6h3M2 8h13M2 9h13M2 10h' +
          '13M2 12h13M2 13h13M2 14h13" />'#13#10'<path stroke="#d0d0d0" d="M9 4h1' +
          '" />'#13#10'<path stroke="#a54f4f" d="M11 4h1" />'#13#10'<path stroke="#aa58' +
          '58" d="M12 4h1" />'#13#10'<path stroke="#a95959" d="M9 5h1" />'#13#10'<path ' +
          'stroke="#a55050" d="M10 5h1" />'#13#10'<path stroke="#a95656" d="M11 5' +
          'h1" />'#13#10'<path stroke="#e8d5d5" d="M12 5h1" />'#13#10'<path stroke="#ef' +
          'e2e2" d="M11 6h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Insert'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 3h15M' +
          '1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 6h1M1 7h15" />'#13#10'<path stroke=' +
          '"#ffffff" d="M2 4h13M2 5h13M2 6h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 0h9M1' +
          ' 1h1M9 1h2M1 2h1M9 2h1M11 2h1M1 3h1M9 3h1M12 3h1M1 4h1M9 4h1M13 ' +
          '4h1M1 5h1M9 5h6M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 ' +
          '9h1M1 10h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M' +
          '1 14h1M14 14h1M1 15h14" />'#13#10'<path stroke="#a4c8ef" d="M2 1h7M2 2' +
          'h7M10 2h1M2 3h7M10 3h2M2 4h7M10 4h3M2 5h7M2 6h12M2 7h12M2 8h12M2' +
          ' 9h12M2 10h12M2 11h12M2 12h12M2 13h12M2 14h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'NewLayout'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 1h6M1' +
          ' 2h1M6 2h1M10 2h5M1 3h1M6 3h1M10 3h1M14 3h1M1 4h1M6 4h1M10 4h1M1' +
          '4 4h1M1 5h1M6 5h1M10 5h1M14 5h1M1 6h1M6 6h1M10 6h1M14 6h1M1 7h1M' +
          '6 7h1M10 7h5M1 8h6M1 11h12M1 12h1M12 12h1M1 13h1M12 13h1M1 14h12' +
          '" />'#13#10'<path stroke="#ffffff" d="M2 2h4M2 3h4M11 3h3M2 4h4M11 4h3' +
          'M2 5h4M11 5h3M2 6h4M11 6h3M2 7h4M2 12h10M2 13h10" />'#13#10'<path stro' +
          'ke="#725252" d="M7 3h1M6 10h1" />'#13#10'<path stroke="#eeeeee" d="M8 ' +
          '3h1M7 4h1M6 9h1M5 10h1M7 10h2" />'#13#10'<path stroke="#727272" d="M8 ' +
          '4h1" />'#13#10'<path stroke="#ababab" d="M9 4h1" />'#13#10'<path stroke="#9a' +
          '9a9a" d="M9 5h1M9 9h1" />'#13#10'<path stroke="#525252" d="M10 8h1" />' +
          #13#10'<path stroke="#dddddd" d="M4 9h1" />'#13#10'<path stroke="#626262" d' +
          '="M5 9h1" />'#13#10'<path stroke="#cccccc" d="M10 9h1" />'#13#10'<path strok' +
          'e="#7a7a7a" d="M9 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Refresh'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#4b4b4b" d="M1 0h11M' +
          '1 1h1M11 1h2M1 2h1M11 2h1M13 2h1M1 3h1M11 3h4M1 4h1M14 4h1M1 5h1' +
          'M14 5h1M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10' +
          'h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M1' +
          '4 14h1M1 15h14" />'#13#10'<path stroke="#ffffff" d="M2 1h9M2 2h9M12 2h' +
          '1M2 3h5M8 3h3M2 4h5M9 4h5M2 5h3M10 5h4M2 6h2M5 6h2M9 6h5M2 7h2M5' +
          ' 7h2M8 7h6M2 8h2M5 8h5M11 8h3M2 9h5M8 9h2M11 9h3M2 10h4M8 10h2M1' +
          '1 10h3M2 11h3M10 11h4M2 12h4M8 12h6M2 13h5M8 13h6M2 14h12" />'#13#10'<' +
          'path stroke="#4ba34b" d="M7 3h1M7 4h2M5 5h5M4 6h1M7 6h2M4 7h1M7 ' +
          '7h1M4 8h1M10 8h1M7 9h1M10 9h1M6 10h2M10 10h1M5 11h5M6 12h2M7 13h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Font'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="M186-8' +
          '0q-54 0-80-22t-26-66q0-58 49-74t116-16h21v-56q0-34-1-55.5t-6-35.' +
          '5q-5-14-11.5-19.5T230-430q-9 0-16.5 3t-12.5 8q-4 5-5 10.5t1 11.5' +
          'q6 11 14 21.5t8 24.5q0 25-17.5 42.5T159-291q-25 0-42.5-17.5T99-3' +
          '51q0-27 12-44t32.5-27q20.5-10 47.5-14t58-4q85 0 118 30.5T400-302' +
          'v147q0 19 4.5 28t15.5 9q12 0 19.5-18t9.5-56h11q-3 62-23.5 87T368' +
          '-80q-43 0-67.5-13.5T269-134q-10 29-29.5 41.5T186-80Zm373 0q-20 0' +
          '-32.5-16.5T522-132l102-269q7-17 22-28t34-11q19 0 34 11t22 28l102' +
          ' 269q8 19-4.5 35.5T801-80q-12 0-22-7t-15-19l-20-58H616l-20 58q-4' +
          ' 11-14 18.5T559-80Zm-324-29q13 0 22-20.5t9-49.5v-67q-26 0-38 15.' +
          '5T216-180v11q0 36 4 48t15 12Zm407-125h77l-39-114-38 114Zm-37-285' +
          'q-48 0-76.5-33.5T500-643q0-104 66-170.5T735-880q42 0 68 9.5t26 2' +
          '4.5q0 6-2 12t-7 11q-5 7-12.5 10t-15.5 1q-14-4-32-7t-33-3q-71 0-1' +
          '14 48t-43 127q0 22 8 46t36 24q11 0 21.5-5t18.5-14q17-18 31.5-60T' +
          '712-758q2-13 10.5-18.5T746-782q18 0 27.5 9.5T779-749q-12 43-17.5' +
          ' 75t-5.5 58q0 20 5.5 29t16.5 9q11 0 21.5-8t29.5-30q2-3 15-7 8 0 ' +
          '12 6t4 17q0 28-32 54t-67 26q-26 0-44.5-14T691-574q-15 26-37 40.5' +
          'T605-519Zm-485-1v-220q0-58 41-99t99-41q58 0 99 41t41 99v220h-80v' +
          '-80H200v80h-80Zm80-160h120v-60q0-25-17.5-42.5T260-800q-25 0-42.5' +
          ' 17.5T200-740v60Z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Copy'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a7a7a7" d="M1 0h4M0' +
          ' 1h1M5 1h1M0 2h1M5 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1' +
          'M0 10h1M1 11h4" />'#13#10'<path stroke="#b1b1b1" d="M5 0h1" />'#13#10'<path ' +
          'stroke="#ececec" d="M6 0h1" />'#13#10'<path stroke="#aeaeae" d="M6 1h1' +
          'M7 2h1" />'#13#10'<path stroke="#e9e9e9" d="M7 1h1" />'#13#10'<path stroke="' +
          '#e6e6e6" d="M6 2h1M5 3h1" />'#13#10'<path stroke="#e4e4e4" d="M8 2h1" ' +
          '/>'#13#10'<path stroke="#6ea5d7" d="M2 3h2M2 5h2M2 7h3M2 9h3" />'#13#10'<pat' +
          'h stroke="#909090" d="M6 4h1" />'#13#10'<path stroke="#777777" d="M7 4' +
          'h4M6 5h1M11 5h1M6 6h1M11 6h1M6 7h1M11 7h1M6 8h1M12 8h3M6 9h1M15 ' +
          '9h1M6 10h1M15 10h1M6 11h1M15 11h1M6 12h1M15 12h1M6 13h1M15 13h1M' +
          '6 14h1M15 14h1M7 15h8" />'#13#10'<path stroke="#858585" d="M11 4h1" />' +
          #13#10'<path stroke="#e2e2e2" d="M12 4h1" />'#13#10'<path stroke="#fcfcfc" ' +
          'd="M7 5h4M7 6h4M7 7h1M10 7h1M12 7h1M7 8h4M7 9h1M10 9h5M7 10h8M7 ' +
          '11h1M14 11h1M7 12h8M7 13h1M14 13h1M7 14h8" />'#13#10'<path stroke="#81' +
          '8181" d="M12 5h1M13 6h1" />'#13#10'<path stroke="#dcdcdc" d="M13 5h1" ' +
          '/>'#13#10'<path stroke="#d8d8d8" d="M12 6h1" />'#13#10'<path stroke="#d7d7d7' +
          '" d="M14 6h1" />'#13#10'<path stroke="#3f77b0" d="M8 7h2M8 9h2M8 11h6M' +
          '8 13h6" />'#13#10'<path stroke="#dedede" d="M13 7h1" />'#13#10'<path stroke=' +
          '"#828282" d="M14 7h1" />'#13#10'<path stroke="#d1d1d1" d="M15 7h1" />'#13 +
          #10'<path stroke="#8c8c8c" d="M11 8h1" />'#13#10'<path stroke="#7e7e7e" d' +
          '="M15 8h1" />'#13#10'<path stroke="#8f8f8f" d="M6 15h1M15 15h1" />'#13#10'</' +
          'svg>'
      end
      item
        IconName = 'Configuration'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#828282" d="M0 1h15M' +
          '0 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1M0 10h1M0 11h1M0 ' +
          '12h1M0 13h1" />'#13#10'<path stroke="#ffffff" d="M1 2h1M11 2h1M13 2h1M' +
          '2 4h1M4 4h1M6 4h1M8 4h1M10 4h1M12 4h1M1 5h1M3 5h1M5 5h1M9 5h1M11' +
          ' 5h1M13 5h1M2 6h1M4 6h1M8 6h1M10 6h1M12 6h1M1 7h1M7 7h1M9 7h1M11' +
          ' 7h1M13 7h1M2 8h1M6 8h1M8 8h1M10 8h1M12 8h1M1 9h1M3 9h1M5 9h1M9 ' +
          '9h1M11 9h1M13 9h1M2 10h1M4 10h1M8 10h1M10 10h1M12 10h1M1 11h1M7 ' +
          '11h1M9 11h1M11 11h1M13 11h1M2 12h1M6 12h1M8 12h1M10 12h1M12 12h1' +
          'M1 13h1M3 13h1M5 13h1M7 13h1M9 13h1M11 13h1M13 13h1" />'#13#10'<path s' +
          'troke="#0000ff" d="M2 2h9M12 2h1" />'#13#10'<path stroke="#000000" d="' +
          'M14 2h1M1 3h14M14 4h1M6 5h2M14 5h1M3 6h1M5 6h2M14 6h1M3 7h3M14 7' +
          'h1M4 8h1M14 8h1M6 9h2M14 9h1M3 10h1M5 10h2M14 10h1M3 11h3M14 11h' +
          '1M4 12h1M14 12h1M14 13h1M0 14h15" />'#13#10'<path stroke="#c4c4c4" d="' +
          'M1 4h1M3 4h1M5 4h1M7 4h1M9 4h1M11 4h1M13 4h1M2 5h1M4 5h1M8 5h1M1' +
          '0 5h1M12 5h1M1 6h1M7 6h1M9 6h1M11 6h1M13 6h1M2 7h1M6 7h1M8 7h1M1' +
          '0 7h1M12 7h1M1 8h1M3 8h1M5 8h1M7 8h1M9 8h1M11 8h1M13 8h1M2 9h1M4' +
          ' 9h1M8 9h1M10 9h1M12 9h1M1 10h1M7 10h1M9 10h1M11 10h1M13 10h1M2 ' +
          '11h1M6 11h1M8 11h1M10 11h1M12 11h1M1 12h1M3 12h1M5 12h1M7 12h1M9' +
          ' 12h1M11 12h1M13 12h1M2 13h1M4 13h1M6 13h1M8 13h1M10 13h1M12 13h' +
          '1" />'#13#10'</svg>'
      end
      item
        IconName = 'New'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#363636" d="M4 0h1M4' +
          ' 2h1M0 4h1M4 4h1M7 4h8M3 5h1M5 5h10M2 6h1M7 6h8M4 7h1M0 8h1M2 8h' +
          '1M5 8h1M7 8h8M2 9h13M2 10h13M2 12h13M2 13h13M2 14h13" />'#13#10'<path ' +
          'stroke="#ffff36" d="M0 1h1M4 1h1M1 2h1M7 2h1M2 3h1M4 3h1M6 3h1M3' +
          ' 4h1M4 6h1M6 6h1M1 7h2M5 7h1M7 7h1M4 8h1M6 8h1" />'#13#10'<path stroke' +
          '="#baffab" d="M3 1h1M7 1h1M0 2h1M3 2h1M6 2h1M1 3h1M3 3h1M5 3h1M8' +
          ' 3h1M2 4h1M5 4h2M0 5h3M4 5h1M1 6h1M3 6h1M5 6h1M0 7h1M3 7h1M6 7h1' +
          'M3 8h1" />'#13#10'<path stroke="#ffffff" d="M7 3h1M9 3h7M15 4h1M15 5h1' +
          'M15 6h1M8 7h8M1 8h1M15 8h1M1 9h1M15 9h1M1 10h1M15 10h1M1 11h15M1' +
          ' 12h1M15 12h1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<path s' +
          'troke="#ffff65" d="M1 4h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Open'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#fea0a3" d="M5 0h1" ' +
          '/>'#13#10'<path stroke="#fba1a1" d="M6 0h3M9 1h1M10 2h1M9 3h2" />'#13#10'<pa' +
          'th stroke="#fba4a4" d="M4 1h1" />'#13#10'<path stroke="#fba3a3" d="M5 ' +
          '1h2M10 4h1" />'#13#10'<path stroke="#fba2a2" d="M7 1h1" />'#13#10'<path stro' +
          'ke="#fca8a8" d="M8 1h1" />'#13#10'<path stroke="#fea3ac" d="M3 2h1" />' +
          #13#10'<path stroke="#fea1aa" d="M4 2h1" />'#13#10'<path stroke="#fdacae" d' +
          '="M5 2h1" />'#13#10'<path stroke="#fea1a7" d="M9 2h1" />'#13#10'<path stroke' +
          '="#fba1a2" d="M12 2h1" />'#13#10'<path stroke="#ffffff" d="M1 3h8M13 3' +
          'h3M1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 6h1M1 7h15M1 8h1M15 8h1M1 ' +
          '9h1M15 9h1M1 10h1M15 10h1M1 11h15M1 12h1M15 12h1M1 13h1M15 13h1M' +
          '1 14h1M15 14h1M1 15h15" />'#13#10'<path stroke="#fca7a7" d="M11 3h1" /' +
          '>'#13#10'<path stroke="#faa2a2" d="M12 3h1" />'#13#10'<path stroke="#363636"' +
          ' d="M2 4h8M13 4h2M2 5h7M12 5h3M2 6h13M2 8h13M2 9h13M2 10h13M2 12' +
          'h13M2 13h13M2 14h13" />'#13#10'<path stroke="#fca2a2" d="M11 4h1" />'#13#10 +
          '<path stroke="#feafaf" d="M12 4h1M9 5h1" />'#13#10'<path stroke="#fca3' +
          'a3" d="M10 5h1" />'#13#10'<path stroke="#feacac" d="M11 5h1" />'#13#10'</svg' +
          '>'#13#10
      end
      item
        IconName = 'Insert'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 3h15M' +
          '1 4h1M15 4h1M1 5h1M15 5h1M1 6h1M15 6h1M1 7h15" />'#13#10'<path stroke=' +
          '"#363636" d="M2 4h13M2 5h13M2 6h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h9M1' +
          ' 1h1M9 1h2M1 2h1M9 2h1M11 2h1M1 3h1M9 3h1M12 3h1M1 4h1M9 4h1M13 ' +
          '4h1M1 5h1M9 5h6M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 ' +
          '9h1M1 10h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M' +
          '1 14h1M14 14h1M1 15h14" />'#13#10'<path stroke="#a4c8ef" d="M2 1h7M2 2' +
          'h7M10 2h1M2 3h7M10 3h2M2 4h7M10 4h3M2 5h7M2 6h12M2 7h12M2 8h12M2' +
          ' 9h12M2 10h12M2 11h12M2 12h12M2 13h12M2 14h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'NewLayout'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 1h6M1' +
          ' 2h1M6 2h1M10 2h5M1 3h1M6 3h1M10 3h1M14 3h1M1 4h1M6 4h1M10 4h1M1' +
          '4 4h1M1 5h1M6 5h1M10 5h1M14 5h1M1 6h1M6 6h1M10 6h1M14 6h1M1 7h1M' +
          '6 7h1M10 7h5M1 8h6M1 11h12M1 12h1M12 12h1M1 13h1M12 13h1M1 14h12' +
          '" />'#13#10'<path stroke="#363636" d="M2 2h4M2 3h4M11 3h3M2 4h4M11 4h3' +
          'M2 5h4M11 5h3M2 6h4M11 6h3M2 7h4M2 12h10M2 13h10" />'#13#10'<path stro' +
          'ke="#725252" d="M7 3h1M6 10h1" />'#13#10'<path stroke="#eeeeee" d="M8 ' +
          '3h1M7 4h1M6 9h1M5 10h1M7 10h2" />'#13#10'<path stroke="#727272" d="M8 ' +
          '4h1" />'#13#10'<path stroke="#ababab" d="M9 4h1" />'#13#10'<path stroke="#9a' +
          '9a9a" d="M9 5h1M9 9h1" />'#13#10'<path stroke="#525252" d="M10 8h1" />' +
          #13#10'<path stroke="#dddddd" d="M4 9h1" />'#13#10'<path stroke="#626262" d' +
          '="M5 9h1" />'#13#10'<path stroke="#cccccc" d="M10 9h1" />'#13#10'<path strok' +
          'e="#7a7a7a" d="M9 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Refresh'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h11M' +
          '1 1h1M11 1h2M1 2h1M11 2h1M13 2h1M1 3h1M11 3h4M1 4h1M14 4h1M1 5h1' +
          'M14 5h1M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10' +
          'h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M1' +
          '4 14h1M1 15h14" />'#13#10'<path stroke="#363636" d="M2 1h9M2 2h9M12 2h' +
          '1M2 3h5M8 3h3M2 4h5M9 4h5M2 5h3M10 5h4M2 6h2M5 6h2M9 6h5M2 7h2M5' +
          ' 7h2M8 7h6M2 8h2M5 8h5M11 8h3M2 9h5M8 9h2M11 9h3M2 10h4M8 10h2M1' +
          '1 10h3M2 11h3M10 11h4M2 12h4M8 12h6M2 13h5M8 13h6M2 14h12" />'#13#10'<' +
          'path stroke="#4ba34b" d="M7 3h1M7 4h2M5 5h5M4 6h1M7 6h2M4 7h1M7 ' +
          '7h1M4 8h1M10 8h1M7 9h1M10 9h1M6 10h2M10 10h1M5 11h5M6 12h2M7 13h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Font'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#e6e6e6">'#13#10'  <path d="M186-8' +
          '0q-54 0-80-22t-26-66q0-58 49-74t116-16h21v-56q0-34-1-55.5t-6-35.' +
          '5q-5-14-11.5-19.5T230-430q-9 0-16.5 3t-12.5 8q-4 5-5 10.5t1 11.5' +
          'q6 11 14 21.5t8 24.5q0 25-17.5 42.5T159-291q-25 0-42.5-17.5T99-3' +
          '51q0-27 12-44t32.5-27q20.5-10 47.5-14t58-4q85 0 118 30.5T400-302' +
          'v147q0 19 4.5 28t15.5 9q12 0 19.5-18t9.5-56h11q-3 62-23.5 87T368' +
          '-80q-43 0-67.5-13.5T269-134q-10 29-29.5 41.5T186-80Zm373 0q-20 0' +
          '-32.5-16.5T522-132l102-269q7-17 22-28t34-11q19 0 34 11t22 28l102' +
          ' 269q8 19-4.5 35.5T801-80q-12 0-22-7t-15-19l-20-58H616l-20 58q-4' +
          ' 11-14 18.5T559-80Zm-324-29q13 0 22-20.5t9-49.5v-67q-26 0-38 15.' +
          '5T216-180v11q0 36 4 48t15 12Zm407-125h77l-39-114-38 114Zm-37-285' +
          'q-48 0-76.5-33.5T500-643q0-104 66-170.5T735-880q42 0 68 9.5t26 2' +
          '4.5q0 6-2 12t-7 11q-5 7-12.5 10t-15.5 1q-14-4-32-7t-33-3q-71 0-1' +
          '14 48t-43 127q0 22 8 46t36 24q11 0 21.5-5t18.5-14q17-18 31.5-60T' +
          '712-758q2-13 10.5-18.5T746-782q18 0 27.5 9.5T779-749q-12 43-17.5' +
          ' 75t-5.5 58q0 20 5.5 29t16.5 9q11 0 21.5-8t29.5-30q2-3 15-7 8 0 ' +
          '12 6t4 17q0 28-32 54t-67 26q-26 0-44.5-14T691-574q-15 26-37 40.5' +
          'T605-519Zm-485-1v-220q0-58 41-99t99-41q58 0 99 41t41 99v220h-80v' +
          '-80H200v80h-80Zm80-160h120v-60q0-25-17.5-42.5T260-800q-25 0-42.5' +
          ' 17.5T200-740v60Z"/>'#13#10'</svg>'
      end>
    Left = 152
    Top = 256
  end
  object vilWindowLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'New'
        Name = 'New'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Open'
        Name = 'Open'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Insert'
        Name = 'Insert'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 4
        CollectionName = 'NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end>
    ImageCollection = icMenuWindow
    Left = 273
    Top = 257
  end
  object vilWindowDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 9
        CollectionName = 'New'
        Name = 'New'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Open'
        Name = 'Open'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Insert'
        Name = 'Insert'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 13
        CollectionName = 'NewLayout'
        Name = 'NewLayout'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Refresh'
        Name = 'Refresh'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Font'
        Name = 'Font'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end>
    ImageCollection = icMenuWindow
    Left = 385
    Top = 258
  end
  object icMenuClassObject: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'EditClass'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#05529a" d="M2 1h11M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="#8eb3dd" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#13#10'<path stroke="#408acc" d="M3 3h10M3 4h2M11 4h2M3 5h2M8 5' +
          'h1M12 5h1M3 6h1M7 6h3M12 6h1M3 7h1M6 7h7M3 8h1M6 8h7M3 9h1M7 9h3' +
          'M12 9h1M3 10h2M8 10h1M12 10h1M3 11h2M11 11h2M3 12h10" />'#13#10'<path ' +
          'stroke="#468dcd" d="M5 4h1M5 11h1" />'#13#10'<path stroke="#a0c5e6" d=' +
          '"M6 4h1" />'#13#10'<path stroke="#f2f7fb" d="M7 4h1" />'#13#10'<path stroke=' +
          '"#cde1f1" d="M9 4h1M9 11h1" />'#13#10'<path stroke="#5497d1" d="M10 4h' +
          '1M10 11h1" />'#13#10'<path stroke="#c1d9ee" d="M5 5h1M5 10h1" />'#13#10'<pat' +
          'h stroke="#b2d0ea" d="M6 5h1M6 10h1" />'#13#10'<path stroke="#488fce" ' +
          'd="M7 5h1M7 10h1" />'#13#10'<path stroke="#73aada" d="M9 5h1" />'#13#10'<pat' +
          'h stroke="#e8f0f8" d="M10 5h1M10 10h1" />'#13#10'<path stroke="#438bcc' +
          '" d="M11 5h1" />'#13#10'<path stroke="#609ed4" d="M4 6h1" />'#13#10'<path st' +
          'roke="#f8fafc" d="M5 6h1M5 9h1M7 11h1" />'#13#10'<path stroke="#4990ce' +
          '" d="M6 6h1M6 9h1M11 10h1" />'#13#10'<path stroke="#70a8da" d="M10 6h1' +
          '" />'#13#10'<path stroke="#5094d0" d="M11 6h1" />'#13#10'<path stroke="#7eb1' +
          'dd" d="M4 7h1" />'#13#10'<path stroke="#d0e3f2" d="M5 7h1M5 8h1" />'#13#10'<' +
          'path stroke="#77acdb" d="M4 8h1" />'#13#10'<path stroke="#5d9cd4" d="M' +
          '4 9h1" />'#13#10'<path stroke="#94bee3" d="M10 9h1" />'#13#10'<path stroke="' +
          '#6da6d8" d="M11 9h1M9 10h1" />'#13#10'<path stroke="#aacbe9" d="M6 11h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'OpenFolder'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M9 1h3M8' +
          ' 2h1M12 2h1M14 2h1M13 3h2M1 4h3M12 4h3M0 5h1M4 5h7M0 6h1M10 6h1M' +
          '0 7h1M10 7h1M0 8h1M5 8h11M0 9h1M4 9h1M14 9h1M0 10h1M3 10h1M13 10' +
          'h1M0 11h1M2 11h1M12 11h1M0 12h2M11 12h1M0 13h11" />'#13#10'<path strok' +
          'e="#ffff00" d="M1 5h1M3 5h1M2 6h1M4 6h1M6 6h1M8 6h1M1 7h1M3 7h1M' +
          '5 7h1M7 7h1M9 7h1M2 8h1M4 8h1M1 9h1M3 9h1M2 10h1M1 11h1" />'#13#10'<pa' +
          'th stroke="#ffffff" d="M2 5h1M1 6h1M3 6h1M5 6h1M7 6h1M9 6h1M2 7h' +
          '1M4 7h1M6 7h1M8 7h1M1 8h1M3 8h1M2 9h1M1 10h1" />'#13#10'<path stroke="' +
          '#777700" d="M5 9h9M4 10h9M3 11h9M2 12h9" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Class'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'  <pat' +
          'h d="M 10.5, 5'#13#10'           C 8.5, 3, 4.5, 4, 4.5, 8'#13#10'           ' +
          'C 4.5, 12, 8.5, 13, 10.5, 11"'#13#10#13#10'        fill="none" stroke="whi' +
          'te" stroke-width="1.5"/></svg>'#13#10
      end
      item
        IconName = 'DeleteItem'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a34b4b" d="M6 2h2M5' +
          ' 3h2M0 4h2M4 4h2M1 5h4M2 6h3M2 7h4M1 8h2M5 8h2M1 9h1M6 9h1M0 10h' +
          '2M7 10h1M0 11h1" />'#13#10'<path stroke="#a3a3a3" d="M8 2h1M7 3h1M2 4h' +
          '1M6 4h1M0 5h1M5 5h1M1 6h1M1 7h1M15 7h1M3 8h1M15 8h1M0 9h1M2 9h1M' +
          '5 9h1M7 9h1M15 9h1M6 10h1M15 10h1M15 11h1M0 12h1M15 12h1M15 13h1' +
          'M15 14h1M2 15h14" />'#13#10'<path stroke="#4b4b4b" d="M6 5h8M13 6h2M14' +
          ' 7h1M14 8h1M14 9h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M' +
          '14 13h1M1 14h14" />'#13#10'<path stroke="#fff6ee" d="M5 6h8M7 7h7M4 8h' +
          '1M8 8h6M3 9h2M8 9h6M2 10h3M8 10h6M2 11h12M2 12h12M2 13h12" />'#13#10'<' +
          'path stroke="#ffffff" d="M6 7h1M7 8h1M5 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'DeleteClass'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#973636" d="M6 0h2M5' +
          ' 1h1M0 2h2M4 2h2M1 3h3M3 4h2M2 5h1M1 6h2M5 6h2M6 7h1M0 8h2M7 8h1' +
          '" />'#13#10'<path stroke="#979797" d="M8 0h1M7 1h1M2 2h1M6 2h1M0 3h1M5' +
          ' 3h1M1 4h1M1 5h1M3 6h1M0 7h1M2 7h1M5 7h1M7 7h1M6 8h1" />'#13#10'<path ' +
          'stroke="#976565" d="M6 1h1M4 3h1M2 4h1M3 5h2M1 7h1M0 9h1" />'#13#10'<p' +
          'ath stroke="#653636" d="M6 3h3" />'#13#10'<path stroke="#000000" d="M9' +
          ' 3h7M15 4h1M15 5h1M15 6h1M3 7h2M8 7h8M15 8h1M15 9h1M15 10h1M1 11' +
          'h15M1 12h1M15 12h1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<p' +
          'ath stroke="#ffffff" d="M5 4h10M6 5h9M4 6h1M7 6h8M2 8h4M8 8h7M2 ' +
          '9h13M2 10h13M2 12h13M2 13h13M2 14h13" />'#13#10'<path stroke="#976536"' +
          ' d="M5 5h1" />'#13#10'<path stroke="#366536" d="M1 9h1" />'#13#10'<path stro' +
          'ke="#653665" d="M1 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Copy'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#a7a7a7" d="M1 0h4M0' +
          ' 1h1M5 1h1M0 2h1M5 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1' +
          'M0 10h1M1 11h4" />'#13#10'<path stroke="#b1b1b1" d="M5 0h1" />'#13#10'<path ' +
          'stroke="#ececec" d="M6 0h1" />'#13#10'<path stroke="#aeaeae" d="M6 1h1' +
          'M7 2h1" />'#13#10'<path stroke="#e9e9e9" d="M7 1h1" />'#13#10'<path stroke="' +
          '#e6e6e6" d="M6 2h1M5 3h1" />'#13#10'<path stroke="#e4e4e4" d="M8 2h1" ' +
          '/>'#13#10'<path stroke="#6ea5d7" d="M2 3h2M2 5h2M2 7h3M2 9h3" />'#13#10'<pat' +
          'h stroke="#909090" d="M6 4h1" />'#13#10'<path stroke="#777777" d="M7 4' +
          'h4M6 5h1M11 5h1M6 6h1M11 6h1M6 7h1M11 7h1M6 8h1M12 8h3M6 9h1M15 ' +
          '9h1M6 10h1M15 10h1M6 11h1M15 11h1M6 12h1M15 12h1M6 13h1M15 13h1M' +
          '6 14h1M15 14h1M7 15h8" />'#13#10'<path stroke="#858585" d="M11 4h1" />' +
          #13#10'<path stroke="#e2e2e2" d="M12 4h1" />'#13#10'<path stroke="#fcfcfc" ' +
          'd="M7 5h4M7 6h4M7 7h1M10 7h1M12 7h1M7 8h4M7 9h1M10 9h5M7 10h8M7 ' +
          '11h1M14 11h1M7 12h8M7 13h1M14 13h1M7 14h8" />'#13#10'<path stroke="#81' +
          '8181" d="M12 5h1M13 6h1" />'#13#10'<path stroke="#dcdcdc" d="M13 5h1" ' +
          '/>'#13#10'<path stroke="#d8d8d8" d="M12 6h1" />'#13#10'<path stroke="#d7d7d7' +
          '" d="M14 6h1" />'#13#10'<path stroke="#3f77b0" d="M8 7h2M8 9h2M8 11h6M' +
          '8 13h6" />'#13#10'<path stroke="#dedede" d="M13 7h1" />'#13#10'<path stroke=' +
          '"#828282" d="M14 7h1" />'#13#10'<path stroke="#d1d1d1" d="M15 7h1" />'#13 +
          #10'<path stroke="#8c8c8c" d="M11 8h1" />'#13#10'<path stroke="#7e7e7e" d' +
          '="M15 8h1" />'#13#10'<path stroke="#8f8f8f" d="M6 15h1M15 15h1" />'#13#10'</' +
          'svg>'#13#10
      end
      item
        IconName = 'EditObject'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#979797" d="M0 1h1M1' +
          '5 1h1M10 2h1M13 2h1M8 4h1M8 5h1M8 6h1M8 7h1M8 8h1M8 9h1M8 10h1M8' +
          ' 11h1M8 12h1M8 13h1M8 14h1M0 15h1" />'#13#10'<path stroke="#7e7e7e" d=' +
          '"M1 1h14M0 2h1M0 3h1M0 4h1M0 5h1M0 6h1M0 7h1M0 8h1M0 9h1M0 10h1M' +
          '0 11h1M0 12h1M0 13h1M0 14h1" />'#13#10'<path stroke="#ffffff" d="M1 2h' +
          '1M1 4h7M9 4h6M1 5h1M6 5h2M9 5h1M13 5h2M1 6h7M9 6h6M1 7h1M7 7h1M9' +
          ' 7h1M13 7h2M1 8h7M9 8h6M1 9h1M5 9h3M9 9h1M14 9h1M1 10h7M9 10h6M1' +
          ' 11h1M7 11h1M9 11h1M12 11h3M1 12h7M9 12h6M1 13h1M6 13h2M9 13h1M1' +
          '3 13h2M1 14h7M9 14h6" />'#13#10'<path stroke="#9eb1c5" d="M2 2h8M11 2h' +
          '2M14 2h1M1 3h9M11 3h2M14 3h1M2 5h1M10 5h1M2 7h1M10 7h1M2 9h1M10 ' +
          '9h1M2 11h1M10 11h1M2 13h1M10 13h1" />'#13#10'<path stroke="#656565" d=' +
          '"M15 2h1M10 3h1M13 3h1M15 3h1M15 4h1M15 5h1M15 6h1M15 7h1M15 8h1' +
          'M15 9h1M15 10h1M15 11h1M15 12h1M15 13h1M15 14h1M1 15h15" />'#13#10'<pa' +
          'th stroke="#366597" d="M3 5h3M11 5h2M3 7h4M11 7h2M3 9h2M11 9h3M3' +
          ' 11h4M11 11h1M3 13h3M11 13h2" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Private'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'    <p' +
          'olygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="w' +
          'hite" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Protected'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'<text ' +
          'x="3.6" y="12" fill="white">~</text>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Package'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'<path ' +
          'stroke="white" d="M4.5 6 h7 M4.5 10 h7 M6 4.5 v7 M10 4.5 v7" />'#13 +
          #10'</svg>'
      end
      item
        IconName = 'Public'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#3a' +
          '7758"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#3b963a"/> '#13#10'    <p' +
          'olygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="w' +
          'hite" />'#13#10'    <polygon points="7.5,5 8.5,5 8.5,11 7.5,11 " fill=' +
          '"none" stroke="white" />'#13#10'</svg>'
      end
      item
        IconName = 'Compile'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 0h3M0' +
          ' 1h1M4 1h5M0 2h1M9 2h1M0 3h1M9 3h1M0 4h1M9 4h1M0 5h1M9 5h1M11 5h' +
          '3M0 6h1M9 6h1M13 6h2M0 7h1M9 7h1M13 7h2M0 8h9M13 8h2M12 9h4M13 1' +
          '0h2M3 12h1M6 12h1M9 12h1M12 12h1M15 12h1M3 13h1M5 13h1M7 13h1M9 ' +
          '13h1M11 13h1M13 13h1M15 13h1M3 14h1M5 14h1M7 14h1M9 14h1M11 14h1' +
          'M13 14h1M15 14h1M3 15h1M6 15h1M9 15h1M12 15h1M15 15h1" />'#13#10'<path' +
          ' stroke="#ffff00" d="M1 1h1M3 1h1M4 2h1M6 2h1M8 2h1M1 3h1M3 3h1M' +
          '5 3h1M7 3h1M2 4h1M4 4h1M6 4h1M8 4h1M1 5h1M3 5h1M5 5h1M7 5h1M2 6h' +
          '1M4 6h1M6 6h1M8 6h1M1 7h1M3 7h1M5 7h1M7 7h1" />'#13#10'<path stroke="#' +
          'ffffff" d="M2 1h1M5 2h1M7 2h1M2 3h1M4 3h1M6 3h1M8 3h1M1 4h1M3 4h' +
          '1M5 4h1M7 4h1M2 5h1M4 5h1M6 5h1M8 5h1M1 6h1M3 6h1M5 6h1M7 6h1M2 ' +
          '7h1M4 7h1M6 7h1M8 7h1" />'#13#10'<path stroke="#7e7e7e" d="M1 2h3M14 5' +
          'h1M9 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Compile2'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 0h3M0' +
          ' 1h1M4 1h5M0 2h1M9 2h1M0 3h1M9 3h1M0 4h1M9 4h1M0 5h1M9 5h1M11 5h' +
          '3M0 6h1M9 6h1M13 6h2M0 7h1M9 7h1M13 7h2M0 8h9M13 8h2M12 9h4M13 1' +
          '0h2M3 12h1M6 12h1M9 12h1M12 12h1M15 12h1M3 13h1M5 13h1M7 13h1M9 ' +
          '13h1M11 13h1M13 13h1M15 13h1M3 14h1M5 14h1M7 14h1M9 14h1M11 14h1' +
          'M13 14h1M15 14h1M3 15h1M6 15h1M9 15h1M12 15h1M15 15h1" />'#13#10'<path' +
          ' stroke="#fe471a" d="M1 1h3M4 2h5M1 3h8M1 4h8M1 5h8M1 6h8M1 7h8"' +
          ' />'#13#10'<path stroke="#7e7e7e" d="M1 2h3M14 5h1M9 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Inherits'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<polygon points="2,7 8,1 14,7" sty' +
          'le="fill:white;stroke:black"/>'#13#10'<polygon points="7,7 9,7 9,13 7,' +
          '13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Unknown'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#585858" d="M3 3h10M' +
          '3 4h1M12 4h1M3 5h1M12 5h1M3 6h1M12 6h1M3 7h1M12 7h1M3 8h1M12 8h1' +
          'M3 9h1M12 9h1M3 10h1M12 10h1M3 11h1M12 11h1M3 12h10" />'#13#10'<path s' +
          'troke="#c6d6df" d="M4 4h8M4 5h8M4 6h8M4 7h8M4 8h8M4 9h8M4 10h8M4' +
          ' 11h8" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Private'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#5f5f5f" d="M3 3h10M' +
          '3 4h1M12 4h1M3 5h1M12 5h1M3 6h1M12 6h1M3 7h1M5 7h6M12 7h1M3 8h1M' +
          '5 8h6M12 8h1M3 9h1M12 9h1M3 10h1M12 10h1M3 11h1M12 11h1M3 12h10"' +
          ' />'#13#10'<path stroke="#cad9e0" d="M4 4h8M4 5h8M4 6h8M4 7h1M11 7h1M4' +
          ' 8h1M11 8h1M4 9h8M4 10h8M4 11h8" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Interface'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#feca36" d="M2 1h11M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="#ffffca" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#13#10'<path stroke="#ffff65" d="M3 3h10M3 4h10M3 5h3M9 5h4M3 6' +
          'h4M8 6h5M3 7h4M8 7h5M3 8h4M8 8h5M3 9h4M8 9h5M3 10h3M9 10h4M3 11h' +
          '10M3 12h10" />'#13#10'<path stroke="#000000" d="M6 5h3M7 6h1M7 7h1M7 8' +
          'h1M7 9h1M6 10h3" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ClassOpen'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 1h13M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h13M1 6h1M13 6h1M1 7h1' +
          'M13 7h1M1 8h1M13 8h1M1 9h13M1 10h1M13 10h1M1 11h1M13 11h1M1 12h1' +
          'M13 12h1M1 13h13" />'#13#10'<path stroke="#ffffff" d="M2 2h11M2 3h11M2' +
          ' 4h11M2 6h11M2 7h11M2 8h11M2 10h11M2 11h11M2 12h11" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Aggregation'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <polygon points="6,2 11,7 6,12 1' +
          ',7 " style="fill:white;stroke:black"/>'#13#10'  <path stroke="#000000"' +
          ' d="M11 7 h5"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ShowObjects'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <path stroke="#000000" d="M2 0h1' +
          '2M2 1h1M13 1h1M1 2h1M14 2h1M1 3h1M14 3h1M1 4h1M14 4h1M1 5h14M1 6' +
          'h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10h1M14 10h1M' +
          '1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M14 14h1M1 15' +
          'h14"/>'#13#10'  <path stroke="#360036" d="M1 1h1M14 1h1"/>'#13#10'  <path st' +
          'roke="#f1ff12" d="M3 1h10M2 2h12M2 3h12M2 4h12"/>'#13#10'  <path strok' +
          'e="#ffffff" d="M2 6h12M2 7h12M2 8h12M2 9h12M2 10h12M2 11h12M2 12' +
          'h12M2 13h12M2 14h12"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Delete'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="M280-1' +
          '20q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-4' +
          '0v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-' +
          '280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/>'#13 +
          #10'</svg>'#13#10
      end
      item
        IconName = 'Execute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 0h2M1' +
          ' 1h1M3 1h1M1 2h1M4 2h1M1 3h1M5 3h1M1 4h1M6 4h1M1 5h1M7 5h1M1 6h1' +
          'M8 6h1M1 7h1M9 7h1M1 8h1M9 8h1M1 9h1M8 9h1M1 10h1M7 10h1M1 11h1M' +
          '6 11h1M1 12h1M5 12h1M1 13h1M4 13h1M1 14h1M3 14h1" />'#13#10'<path stro' +
          'ke="#25e852" d="M2 1h1M2 2h2M2 3h3M2 4h4M2 5h5M2 6h6M2 7h7M2 8h7' +
          'M2 9h6M2 10h5M2 11h4M2 12h3M2 13h2" />'#13#10'<path stroke="#25e851" d' +
          '="M2 14h1" />'#13#10'<path stroke="#0a0606" d="M1 15h1" />'#13#10'<path stro' +
          'ke="#0a0808" d="M2 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Document'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#979797" d="M1 1h1" ' +
          '/>'#13#10'<path stroke="#656565" d="M2 1h10M1 2h1M10 2h1M12 2h1M1 3h1M' +
          '10 3h1M1 4h1M10 4h3M1 5h1M1 6h1M1 7h1M1 8h1M1 9h1M1 10h1M1 11h1M' +
          '1 12h1M1 13h1M1 14h1" />'#13#10'<path stroke="#ffffff" d="M2 2h8M2 3h8' +
          'M2 4h2M8 4h2M2 5h9M2 6h4M2 7h10M2 8h4M11 8h1M2 9h10M2 10h2M11 10' +
          'h1M2 11h10M2 12h4M11 12h1M2 13h10" />'#13#10'<path stroke="#ffffe9" d=' +
          '"M11 2h1M11 3h2" />'#13#10'<path stroke="#4e4e4e" d="M13 3h1M13 4h1M13' +
          ' 5h1M13 6h1M13 7h1M13 8h1M13 9h1M13 10h1M13 11h1M13 12h1M13 13h1' +
          'M13 14h1" />'#13#10'<path stroke="#4b4b4b" d="M4 4h4M6 6h5M6 8h5M4 10h' +
          '7M6 12h5M2 15h11" />'#13#10'<path stroke="#fcfade" d="M11 5h2M11 6h2M1' +
          '2 7h1M12 8h1M12 9h1M12 10h1M12 11h1M12 12h1M12 13h1M2 14h11" />'#13 +
          #10'<path stroke="#8f8f8f" d="M1 15h1M13 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 0h9M1' +
          ' 1h1M9 1h2M1 2h1M9 2h1M11 2h1M1 3h1M9 3h1M12 3h1M1 4h1M9 4h1M13 ' +
          '4h1M1 5h1M9 5h6M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 ' +
          '9h1M1 10h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M' +
          '1 14h1M14 14h1M1 15h14" />'#13#10'<path stroke="#a4c8ef" d="M2 1h7M2 2' +
          'h7M10 2h1M2 3h7M10 3h2M2 4h7M10 4h3M2 5h7M2 6h12M2 7h12M2 8h12M2' +
          ' 9h12M2 10h12M2 11h12M2 12h12M2 13h12M2 14h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'EditClass'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M2 1h11M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h1M13 5h1M1 6h1M13 6h1' +
          'M1 7h1M13 7h1M1 8h1M13 8h1M1 9h1M13 9h1M1 10h1M13 10h1M1 11h1M13' +
          ' 11h1M1 12h1M13 12h1M2 13h12" />'#13#10'<path stroke="#8eb3dd" d="M2 2' +
          'h11M2 3h1M2 4h1M2 5h1M2 6h1M2 7h1M2 8h1M2 9h1M2 10h1M2 11h1M2 12' +
          'h1" />'#13#10'<path stroke="#408acc" d="M3 3h10M3 4h2M11 4h2M3 5h2M8 5' +
          'h1M12 5h1M3 6h1M7 6h3M12 6h1M3 7h1M6 7h7M3 8h1M6 8h7M3 9h1M7 9h3' +
          'M12 9h1M3 10h2M8 10h1M12 10h1M3 11h2M11 11h2M3 12h10" />'#13#10'<path ' +
          'stroke="#468dcd" d="M5 4h1M5 11h1" />'#13#10'<path stroke="#a0c5e6" d=' +
          '"M6 4h1" />'#13#10'<path stroke="#f2f7fb" d="M7 4h2" />'#13#10'<path stroke=' +
          '"#cde1f1" d="M9 4h1M9 11h1" />'#13#10'<path stroke="#5497d1" d="M10 4h' +
          '1M10 11h1" />'#13#10'<path stroke="#c1d9ee" d="M5 5h1M5 10h1" />'#13#10'<pat' +
          'h stroke="#b2d0ea" d="M6 5h1M6 10h1" />'#13#10'<path stroke="#488fce" ' +
          'd="M7 5h1M7 10h1" />'#13#10'<path stroke="#73aada" d="M9 5h1" />'#13#10'<pat' +
          'h stroke="#e8f0f8" d="M10 5h1M10 10h1" />'#13#10'<path stroke="#438bcc' +
          '" d="M11 5h1" />'#13#10'<path stroke="#609ed4" d="M4 6h1" />'#13#10'<path st' +
          'roke="#f8fafc" d="M5 6h1M5 9h1M7 11h2" />'#13#10'<path stroke="#4990ce' +
          '" d="M6 6h1M6 9h1M11 10h1" />'#13#10'<path stroke="#70a8da" d="M10 6h1' +
          '" />'#13#10'<path stroke="#5094d0" d="M11 6h1" />'#13#10'<path stroke="#7eb1' +
          'dd" d="M4 7h1" />'#13#10'<path stroke="#d0e3f2" d="M5 7h1M5 8h1" />'#13#10'<' +
          'path stroke="#77acdb" d="M4 8h1" />'#13#10'<path stroke="#5d9cd4" d="M' +
          '4 9h1" />'#13#10'<path stroke="#94bee3" d="M10 9h1" />'#13#10'<path stroke="' +
          '#6da6d8" d="M11 9h1M9 10h1" />'#13#10'<path stroke="#aacbe9" d="M6 11h' +
          '1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'OpenFolder'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M9 1h3M8' +
          ' 2h1M12 2h1M14 2h1M13 3h2M1 4h3M12 4h3M0 5h1M4 5h7M0 6h1M10 6h1M' +
          '0 7h1M10 7h1M0 8h1M5 8h11M0 9h1M4 9h1M14 9h1M0 10h1M3 10h1M13 10' +
          'h1M0 11h1M2 11h1M12 11h1M0 12h2M11 12h1M0 13h11" />'#13#10'<path strok' +
          'e="#ffff00" d="M1 5h1M3 5h1M2 6h1M4 6h1M6 6h1M8 6h1M1 7h1M3 7h1M' +
          '5 7h1M7 7h1M9 7h1M2 8h1M4 8h1M1 9h1M3 9h1M2 10h1M1 11h1" />'#13#10'<pa' +
          'th stroke="#000000" d="M2 5h1M1 6h1M3 6h1M5 6h1M7 6h1M9 6h1M2 7h' +
          '1M4 7h1M6 7h1M8 7h1M1 8h1M3 8h1M2 9h1M1 10h1" />'#13#10'<path stroke="' +
          '#777700" d="M5 9h9M4 10h9M3 11h9M2 12h9" />'#13#10'</svg>'
      end
      item
        IconName = 'DeleteClass'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#973636" d="M6 0h2M5' +
          ' 1h1M0 2h2M4 2h2M1 3h3M3 4h2M2 5h1M1 6h2M5 6h2M6 7h1M0 8h2M7 8h1' +
          '" />'#13#10'<path stroke="#979797" d="M8 0h1M7 1h1M2 2h1M6 2h1M0 3h1M5' +
          ' 3h1M1 4h1M1 5h1M3 6h1M0 7h1M2 7h1M5 7h1M7 7h1M6 8h1" />'#13#10'<path ' +
          'stroke="#976565" d="M6 1h1M4 3h1M2 4h1M3 5h2M1 7h1M0 9h1" />'#13#10'<p' +
          'ath stroke="#653636" d="M6 3h3" />'#13#10'<path stroke="#ffffff" d="M9' +
          ' 3h7M15 4h1M15 5h1M15 6h1M3 7h2M8 7h8M15 8h1M15 9h1M15 10h1M1 11' +
          'h15M1 12h1M15 12h1M1 13h1M15 13h1M1 14h1M15 14h1M1 15h15" />'#13#10'<p' +
          'ath stroke="#000000" d="M5 4h10M6 5h9M4 6h1M7 6h8M2 8h4M8 8h7M2 ' +
          '9h13M2 10h13M2 12h13M2 13h13M2 14h13" />'#13#10'<path stroke="#976536"' +
          ' d="M5 5h1" />'#13#10'<path stroke="#366536" d="M1 9h1" />'#13#10'<path stro' +
          'ke="#653665" d="M1 10h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Compile'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h3M0' +
          ' 1h1M4 1h5M0 2h1M9 2h1M0 3h1M9 3h1M0 4h1M9 4h1M0 5h1M9 5h1M11 5h' +
          '3M0 6h1M9 6h1M13 6h2M0 7h1M9 7h1M13 7h2M0 8h9M13 8h2M12 9h4M13 1' +
          '0h2M3 12h1M6 12h1M9 12h1M12 12h1M15 12h1M3 13h1M5 13h1M7 13h1M9 ' +
          '13h1M11 13h1M13 13h1M15 13h1M3 14h1M5 14h1M7 14h1M9 14h1M11 14h1' +
          'M13 14h1M15 14h1M3 15h1M6 15h1M9 15h1M12 15h1M15 15h1" />'#13#10'<path' +
          ' stroke="#ffff00" d="M1 1h1M3 1h1M4 2h1M6 2h1M8 2h1M1 3h1M3 3h1M' +
          '5 3h1M7 3h1M2 4h1M4 4h1M6 4h1M8 4h1M1 5h1M3 5h1M5 5h1M7 5h1M2 6h' +
          '1M4 6h1M6 6h1M8 6h1M1 7h1M3 7h1M5 7h1M7 7h1" />'#13#10'<path stroke="#' +
          '000000" d="M2 1h1M5 2h1M7 2h1M2 3h1M4 3h1M6 3h1M8 3h1M1 4h1M3 4h' +
          '1M5 4h1M7 4h1M2 5h1M4 5h1M6 5h1M8 5h1M1 6h1M3 6h1M5 6h1M7 6h1M2 ' +
          '7h1M4 7h1M6 7h1M8 7h1" />'#13#10'<path stroke="#7e7e7e" d="M1 2h3M14 5' +
          'h1M9 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Compile2'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h3M0' +
          ' 1h1M4 1h5M0 2h1M9 2h1M0 3h1M9 3h1M0 4h1M9 4h1M0 5h1M9 5h1M11 5h' +
          '3M0 6h1M9 6h1M13 6h2M0 7h1M9 7h1M13 7h2M0 8h9M13 8h2M12 9h4M13 1' +
          '0h2M3 12h1M6 12h1M9 12h1M12 12h1M15 12h1M3 13h1M5 13h1M7 13h1M9 ' +
          '13h1M11 13h1M13 13h1M15 13h1M3 14h1M5 14h1M7 14h1M9 14h1M11 14h1' +
          'M13 14h1M15 14h1M3 15h1M6 15h1M9 15h1M12 15h1M15 15h1" />'#13#10'<path' +
          ' stroke="#fe471a" d="M1 1h3M4 2h5M1 3h8M1 4h8M1 5h8M1 6h8M1 7h8"' +
          ' />'#13#10'<path stroke="#7e7e7e" d="M1 2h3M14 5h1M9 8h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Inherits'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<polygon points="2,7 8,1 14,7" sty' +
          'le="fill:black;stroke:white"/>'#13#10'<polygon points="7,7 9,7 9,13 7,' +
          '13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Unknown'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M3 3h10M' +
          '3 4h1M12 4h1M3 5h1M12 5h1M3 6h1M12 6h1M3 7h1M12 7h1M3 8h1M12 8h1' +
          'M3 9h1M12 9h1M3 10h1M12 10h1M3 11h1M12 11h1M3 12h10" />'#13#10'<path s' +
          'troke="#c6d6df" d="M4 4h8M4 5h8M4 6h8M4 7h8M4 8h8M4 9h8M4 10h8M4' +
          ' 11h8" />'#13#10'</svg>'
      end
      item
        IconName = 'Private'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M3 3h10M' +
          '3 4h1M12 4h1M3 5h1M12 5h1M3 6h1M12 6h1M3 7h1M5 7h6M12 7h1M3 8h1M' +
          '5 8h6M12 8h1M3 9h1M12 9h1M3 10h1M12 10h1M3 11h1M12 11h1M3 12h10"' +
          ' />'#13#10'<path stroke="#cad9e0" d="M4 4h8M4 5h8M4 6h8M4 7h1M11 7h1M4' +
          ' 8h1M11 8h1M4 9h8M4 10h8M4 11h8" />'#13#10'</svg>'#13#10#13#10
      end
      item
        IconName = 'ClassOpen'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 1h13M' +
          '1 2h1M13 2h1M1 3h1M13 3h1M1 4h1M13 4h1M1 5h13M1 6h1M13 6h1M1 7h1' +
          'M13 7h1M1 8h1M13 8h1M1 9h13M1 10h1M13 10h1M1 11h1M13 11h1M1 12h1' +
          'M13 12h1M1 13h13" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Aggregation'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'  <polygon points="6,2 11,7 6,12 1' +
          ',7 " style="fill:none;stroke:white"/>'#13#10'  <path stroke="#ffffff" ' +
          'd="M11 7 h5"/>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ShowObjects'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M2 0h12M' +
          '1 1h2M13 1h2M1 2h1M14 2h1M1 3h1M14 3h1M1 4h1M14 4h1M1 5h14M1 6h1' +
          'M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 9h1M1 10h1M14 10h1M1 ' +
          '11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M1 14h1M14 14h1M1 15h1' +
          '4" />'#13#10'<path stroke="#f1ff12" d="M3 1h10M2 2h12M2 3h12M2 4h12" /' +
          '>'#13#10'<path stroke="#363636" d="M2 6h12M2 7h12M2 8h12M2 9h12M2 10h1' +
          '2M2 11h12M2 12h12M2 13h12M2 14h12" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Delete'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#e6e6e6">'#13#10'  <path d="M280-1' +
          '20q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-4' +
          '0v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-' +
          '280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/>'#13 +
          #10'</svg>'#13#10
      end
      item
        IconName = 'Execute'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h2M1' +
          ' 1h1M3 1h1M1 2h1M4 2h1M1 3h1M5 3h1M1 4h1M6 4h1M1 5h1M7 5h1M1 6h1' +
          'M8 6h1M1 7h1M9 7h1M1 8h1M9 8h1M1 9h1M8 9h1M1 10h1M7 10h1M1 11h1M' +
          '6 11h1M1 12h1M5 12h1M1 13h1M4 13h1M1 14h1M3 14h1" />'#13#10'<path stro' +
          'ke="#25e852" d="M2 1h1M2 2h2M2 3h3M2 4h4M2 5h5M2 6h6M2 7h7M2 8h7' +
          'M2 9h6M2 10h5M2 11h4M2 12h3M2 13h2" />'#13#10'<path stroke="#25e851" d' +
          '="M2 14h1" />'#13#10'<path stroke="#ffffff" d="M1 15h1" />'#13#10'<path stro' +
          'ke="#ffffff" d="M2 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'git'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#f7dcdb" d="M4 0h1M0' +
          ' 4h1" />'#13#10'<path stroke="#e99691" d="M5 0h1M0 5h1" />'#13#10'<path stro' +
          'ke="#df6a63" d="M6 0h1M0 6h1" />'#13#10'<path stroke="#db564f" d="M7 0' +
          'h1M4 3h1M0 7h1M0 8h1M7 11h1" />'#13#10'<path stroke="#db5650" d="M8 0h' +
          '1M6 8h1" />'#13#10'<path stroke="#df6c65" d="M9 0h1" />'#13#10'<path stroke=' +
          '"#d3a397" d="M10 0h1" />'#13#10'<path stroke="#d6ede1" d="M11 0h1" />'#13 +
          #10'<path stroke="#fdf8f7" d="M2 1h1M1 2h1" />'#13#10'<path stroke="#e994' +
          '8f" d="M3 1h1M1 3h1" />'#13#10'<path stroke="#da534c" d="M4 1h1M1 4h1M' +
          '7 8h1M1 11h1" />'#13#10'<path stroke="#da524b" d="M5 1h5M3 2h2M2 3h2M2' +
          ' 4h2M1 5h3M1 6h3M1 7h3M1 8h4M1 9h8M1 10h8M2 11h2M2 12h2M3 13h1" ' +
          '/>'#13#10'<path stroke="#aa6751" d="M10 1h1" />'#13#10'<path stroke="#2b9f62' +
          '" d="M11 1h1M14 4h1M14 11h1M11 14h1" />'#13#10'<path stroke="#7bc59f" ' +
          'd="M12 1h1M14 3h1" />'#13#10'<path stroke="#f7fbf9" d="M13 1h1M14 2h1"' +
          ' />'#13#10'<path stroke="#e37a74" d="M2 2h1" />'#13#10'<path stroke="#eeb0ad' +
          '" d="M5 2h1" />'#13#10'<path stroke="#efb4b1" d="M6 2h4" />'#13#10'<path str' +
          'oke="#b8ae9b" d="M10 2h1" />'#13#10'<path stroke="#2a9f62" d="M11 2h2M' +
          '11 3h3M7 4h7M7 5h8M10 6h5M11 7h4M12 8h3M12 9h3M12 10h3M12 11h2M1' +
          '1 12h3M10 13h3M5 14h6" />'#13#10'<path stroke="#5ab686" d="M13 2h1" />' +
          #13#10'<path stroke="#fffdfd" d="M5 3h1M5 7h1" />'#13#10'<path stroke="#fcf' +
          'dfd" d="M6 3h1" />'#13#10'<path stroke="#f9fcfa" d="M7 3h3" />'#13#10'<path ' +
          'stroke="#bfe3d1" d="M10 3h1" />'#13#10'<path stroke="#dd625a" d="M4 4h' +
          '1" />'#13#10'<path stroke="#9ed4b9" d="M6 4h1" />'#13#10'<path stroke="#d4ec' +
          'e1" d="M15 4h1" />'#13#10'<path stroke="#e06e68" d="M4 5h1" />'#13#10'<path ' +
          'stroke="#8acbaa" d="M6 5h1M7 6h1" />'#13#10'<path stroke="#7dc5a0" d="' +
          'M15 5h1" />'#13#10'<path stroke="#e47c76" d="M4 6h1" />'#13#10'<path stroke=' +
          '"#abdbc2" d="M6 6h1" />'#13#10'<path stroke="#86c9a6" d="M8 6h1" />'#13#10'<' +
          'path stroke="#55b382" d="M9 6h1" />'#13#10'<path stroke="#47ad78" d="M' +
          '15 6h1M15 9h1M6 15h1" />'#13#10'<path stroke="#e47f7a" d="M4 7h1M5 11h' +
          '1" />'#13#10'<path stroke="#fffdfc" d="M6 7h1" />'#13#10'<path stroke="#fdfa' +
          'fa" d="M7 7h1" />'#13#10'<path stroke="#a7d8bf" d="M10 7h1" />'#13#10'<path ' +
          'stroke="#2ea165" d="M15 7h1M7 15h1" />'#13#10'<path stroke="#de655f" d' +
          '="M5 8h1" />'#13#10'<path stroke="#e06f69" d="M8 8h1" />'#13#10'<path stroke' +
          '="#f8e0de" d="M9 8h1" />'#13#10'<path stroke="#5fb88a" d="M11 8h1M5 13' +
          'h1" />'#13#10'<path stroke="#2ea164" d="M15 8h1M8 15h1" />'#13#10'<path stro' +
          'ke="#df6a64" d="M0 9h1" />'#13#10'<path stroke="#e88f8a" d="M9 9h1" />' +
          #13#10'<path stroke="#8accab" d="M11 9h1" />'#13#10'<path stroke="#e99692" ' +
          'd="M0 10h1" />'#13#10'<path stroke="#e8938e" d="M9 10h1" />'#13#10'<path str' +
          'oke="#81c7a3" d="M11 10h1" />'#13#10'<path stroke="#7cc59f" d="M15 10h' +
          '1" />'#13#10'<path stroke="#f7dddc" d="M0 11h1" />'#13#10'<path stroke="#e68' +
          '882" d="M4 11h1" />'#13#10'<path stroke="#dc5c55" d="M6 11h1" />'#13#10'<pat' +
          'h stroke="#e17670" d="M8 11h1" />'#13#10'<path stroke="#f9e6e5" d="M9 ' +
          '11h1" />'#13#10'<path stroke="#fafcfb" d="M10 11h1" />'#13#10'<path stroke="' +
          '#44ac76" d="M11 11h1" />'#13#10'<path stroke="#d3ece0" d="M15 11h1M11 ' +
          '15h1" />'#13#10'<path stroke="#e99490" d="M1 12h1" />'#13#10'<path stroke="#' +
          'ecb1ad" d="M4 12h1" />'#13#10'<path stroke="#f6faf8" d="M9 12h1" />'#13#10'<' +
          'path stroke="#74c29a" d="M10 12h1" />'#13#10'<path stroke="#7ac49e" d=' +
          '"M14 12h1M12 14h1" />'#13#10'<path stroke="#fdf8f8" d="M1 13h1M2 14h1"' +
          ' />'#13#10'<path stroke="#e37b74" d="M2 13h1" />'#13#10'<path stroke="#797f5' +
          'c" d="M4 13h1" />'#13#10'<path stroke="#80c7a3" d="M6 13h1" />'#13#10'<path ' +
          'stroke="#87caa7" d="M7 13h1" />'#13#10'<path stroke="#71c097" d="M8 13' +
          'h1" />'#13#10'<path stroke="#39a76e" d="M9 13h1" />'#13#10'<path stroke="#59' +
          'b686" d="M13 13h1" />'#13#10'<path stroke="#f6fbf9" d="M14 13h1" />'#13#10'<' +
          'path stroke="#e99590" d="M3 14h1" />'#13#10'<path stroke="#757e59" d="' +
          'M4 14h1" />'#13#10'<path stroke="#f6fbf8" d="M13 14h1" />'#13#10'<path strok' +
          'e="#d9eae0" d="M4 15h1" />'#13#10'<path stroke="#7cc5a0" d="M5 15h1M10' +
          ' 15h1" />'#13#10'<path stroke="#46ad78" d="M9 15h1" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'Comment'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#ffffff" d="M1 0h9M1' +
          ' 1h1M9 1h2M1 2h1M9 2h1M11 2h1M1 3h1M9 3h1M12 3h1M1 4h1M9 4h1M13 ' +
          '4h1M1 5h1M9 5h6M1 6h1M14 6h1M1 7h1M14 7h1M1 8h1M14 8h1M1 9h1M14 ' +
          '9h1M1 10h1M14 10h1M1 11h1M14 11h1M1 12h1M14 12h1M1 13h1M14 13h1M' +
          '1 14h1M14 14h1M1 15h14" />'#13#10'<path stroke="#a4c8ef" d="M2 1h7M2 2' +
          'h7M10 2h1M2 3h7M10 3h2M2 4h7M10 4h3M2 5h7M2 6h12M2 7h12M2 8h12M2' +
          ' 9h12M2 10h12M2 11h12M2 12h12M2 13h12M2 14h12" />'#13#10'</svg>'#13#10
      end>
    Left = 144
    Top = 56
  end
  object vilClassObjectLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'EditClass'
        Name = 'EditClass'
      end
      item
        CollectionIndex = 1
        CollectionName = 'OpenFolder'
        Name = 'OpenFolder'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Class'
        Name = 'Class'
      end
      item
        CollectionIndex = 3
        CollectionName = 'DeleteItem'
        Name = 'DeleteItem'
      end
      item
        CollectionIndex = 4
        CollectionName = 'DeleteClass'
        Name = 'DeleteClass'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 6
        CollectionName = 'EditObject'
        Name = 'EditObject'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Private'
        Name = 'Private'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Package'
        Name = 'Package'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Public'
        Name = 'Public'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Compile'
        Name = 'Compile'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Compile2'
        Name = 'Compile2'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Inherits'
        Name = 'Inherits'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Unknown'
        Name = 'Unknown'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Private'
        Name = 'Private'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Interface'
        Name = 'Interface'
      end
      item
        CollectionIndex = 17
        CollectionName = 'ClassOpen'
        Name = 'ClassOpen'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Aggregation'
        Name = 'Aggregation'
      end
      item
        CollectionIndex = 19
        CollectionName = 'ShowObjects'
        Name = 'ShowObjects'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Execute'
        Name = 'Execute'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Document'
        Name = 'Document'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 37
        CollectionName = 'git'
        Name = 'git'
      end>
    ImageCollection = icMenuClassObject
    Left = 280
    Top = 56
  end
  object vilClassObjectDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 24
        CollectionName = 'EditClass'
        Name = 'EditClass'
      end
      item
        CollectionIndex = 25
        CollectionName = 'OpenFolder'
        Name = 'OpenFolder'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Class'
        Name = 'Class'
      end
      item
        CollectionIndex = 3
        CollectionName = 'DeleteItem'
        Name = 'DeleteItem'
      end
      item
        CollectionIndex = 26
        CollectionName = 'DeleteClass'
        Name = 'DeleteClass'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Copy'
        Name = 'Copy'
      end
      item
        CollectionIndex = 6
        CollectionName = 'EditObject'
        Name = 'EditObject'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Private'
        Name = 'Private'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Package'
        Name = 'Package'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Public'
        Name = 'Public'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Compile'
        Name = 'Compile'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Compile2'
        Name = 'Compile2'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Inherits'
        Name = 'Inherits'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Unknown'
        Name = 'Unknown'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Private'
        Name = 'Private'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Interface'
        Name = 'Interface'
      end
      item
        CollectionIndex = 32
        CollectionName = 'ClassOpen'
        Name = 'ClassOpen'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Aggregation'
        Name = 'Aggregation'
      end
      item
        CollectionIndex = 34
        CollectionName = 'ShowObjects'
        Name = 'ShowObjects'
      end
      item
        CollectionIndex = 35
        CollectionName = 'Delete'
        Name = 'Delete'
      end
      item
        CollectionIndex = 36
        CollectionName = 'Execute'
        Name = 'Execute'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Document'
        Name = 'Document'
      end
      item
        CollectionIndex = 38
        CollectionName = 'Comment'
        Name = 'Comment'
      end
      item
        CollectionIndex = 37
        CollectionName = 'git'
        Name = 'git'
      end>
    ImageCollection = icMenuClassObject
    Left = 400
    Top = 56
  end
  object icMenuConnection: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'AssociationUndirected'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 8h14"' +
          ' />'#13#10'</svg>'
      end
      item
        IconName = 'AssociationDirected'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 8h14"' +
          '/>'#13#10'<polyline fill="none" stroke="#000000" points="10.5,3.5 15,8' +
          ' 10.5,12.5 " />   '#13#10'</svg>'
      end
      item
        IconName = 'AssociationBidirectional'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M1 8h14"' +
          '/>'#13#10'<polyline fill="none" stroke="#000000" points="4.5,3.5 0.5,8' +
          ' 4.5,12.5 " />  '#13#10'<polyline fill="none" stroke="#000000" points=' +
          '"10.5,3.5 15,8 10.5,12.5 " />   '#13#10'</svg>'
      end
      item
        IconName = 'Aggregation'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="none" stroke="#000000" points="1,8 5,4 9,8 5,1' +
          '2" />'#13#10'</svg>'
      end
      item
        IconName = 'AggregationWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="none" stroke="#000000" points="1,8 5,4 9,8 5,1' +
          '2" />'#13#10'<polyline fill="none" stroke="#000000" points="10.5,3.5 1' +
          '5,8 10.5,12.5 " />   '#13#10'</svg>'
      end
      item
        IconName = 'Composition'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="#000000" stroke="#000000" points="1,8 5,4 9,8 ' +
          '5,12" />'#13#10'</svg>'
      end
      item
        IconName = 'CompositionWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="#000000" stroke="#000000" points="1,8 5,4 9,8 ' +
          '5,12" />'#13#10'  <polyline fill="none" stroke="#000000" points="10.5,' +
          '3.5 15,8 10.5,12.5 " />   '#13#10'</svg>'
      end
      item
        IconName = 'Inheritance'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M0 7.5h1' +
          '0 M0 8.5 h10"/>'#13#10'<polygon fill="none" stroke="#000000" points="1' +
          '0.5,3.5 15,8 10.5,12.5" />  '#13#10'</svg>'
      end
      item
        IconName = 'Implements'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M0 8h4 M' +
          '5 8h5 "/>'#13#10'<polygon fill="none" stroke="#000000" points="10.5,3.' +
          '5 15,8 10.5,12.5" />  '#13#10'</svg>'
      end
      item
        IconName = 'InstanceOf'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#000000" d="M0 8 h1 ' +
          'M2 8h7 M10 8h5"/>'#13#10'<polyline fill="none" stroke="#000000" points' +
          '="10.5,3.5 15,8 10.5,12.5" />  '#13#10'</svg>'
      end
      item
        IconName = 'Recursive'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<polyline fill="none" stroke="#000' +
          '000" points="4,4 6,6 8,4" /> '#13#10'<polyline fill="none" stroke="#00' +
          '0000" points="6,6 6,1 12,1 12,11 9,11" /> '#13#10'</svg>'#13#10#13#10
      end
      item
        IconName = 'Edit'
        SVGText = 
          '<svg viewBox="0 -0.5 26 16">'#10'<path stroke="#c32a6a" d="M17 1h1" ' +
          '/>'#10'<path stroke="#bd2062" d="M18 1h1" />'#10'<path stroke="#c22b6d" ' +
          'd="M16 2h1" />'#10'<path stroke="#f99a8e" d="M17 2h1" />'#10'<path strok' +
          'e="#eb5948" d="M18 2h1" />'#10'<path stroke="#b51d5f" d="M19 2h1" />' +
          #10'<path stroke="#ba7647" d="M15 3h1" />'#10'<path stroke="#db9a2a" d=' +
          '"M16 3h1" />'#10'<path stroke="#ec745d" d="M17 3h1" />'#10'<path stroke=' +
          '"#df502d" d="M18 3h1" />'#10'<path stroke="#be3222" d="M19 3h1" />'#10'<' +
          'path stroke="#ad174e" d="M20 3h1" />'#10'<path stroke="#8a5bc3" d="M' +
          '14 4h1M13 5h1M12 6h1M11 7h1M10 8h1" />'#10'<path stroke="#b09818" d=' +
          '"M15 4h1" />'#10'<path stroke="#f8c50e" d="M16 4h1" />'#10'<path stroke=' +
          '"#c5591b" d="M17 4h1" />'#10'<path stroke="#c63515" d="M18 4h1" />'#10'<' +
          'path stroke="#be3020" d="M19 4h1" />'#10'<path stroke="#9f0050" d="M' +
          '20 4h1" />'#10'<path stroke="#c9c6ff" d="M14 5h1M13 6h1M12 7h1M11 8h' +
          '1" />'#10'<path stroke="#92980c" d="M15 5h1" />'#10'<path stroke="#feca0' +
          '0" d="M16 5h1" />'#10'<path stroke="#f4c000" d="M17 5h1" />'#10'<path st' +
          'roke="#ce7a18" d="M18 5h1" />'#10'<path stroke="#a10062" d="M19 5h1"' +
          ' />'#10'<path stroke="#cacaff" d="M14 6h1M13 7h1M12 8h1M11 9h1" />'#10'<' +
          'path stroke="#9797ca" d="M15 6h1M15 7h1M14 8h1M13 9h1M12 10h1M11' +
          ' 11h1" />'#10'<path stroke="#aa9f05" d="M16 6h1" />'#10'<path stroke="#e' +
          'db314" d="M17 6h1" />'#10'<path stroke="#c67344" d="M18 6h1" />'#10'<pat' +
          'h stroke="#acace1" d="M14 7h1M13 8h1M12 9h1M11 10h1" />'#10'<path st' +
          'roke="#988fcc" d="M16 7h1M15 8h1M14 9h1M13 10h1M12 11h1" />'#10'<pat' +
          'h stroke="#7f48b8" d="M17 7h1M16 8h1M15 9h1M14 10h1M13 11h1" />'#10 +
          '<path stroke="#8762bf" d="M10 9h1" />'#10'<path stroke="#a04c5e" d="' +
          'M9 10h1M8 12h1" />'#10'<path stroke="#aca5e2" d="M10 10h1" />'#10'<path ' +
          'stroke="#9e534e" d="M9 11h1" />'#10'<path stroke="#86850f" d="M10 11' +
          'h1" />'#10'<path stroke="#9d6b22" d="M9 12h1" />'#10'<path stroke="#a47b' +
          '17" d="M10 12h1" />'#10'<path stroke="#80602d" d="M11 12h1" />'#10'<path' +
          ' stroke="#7a3970" d="M12 12h1" />'#10'<path stroke="#43005f" d="M8 1' +
          '3h1" />'#10'<path stroke="#4b2c26" d="M9 13h1" />'#10'<path stroke="#7f3' +
          '85c" d="M10 13h1" />'#10'<path stroke="#a85260" d="M11 13h1M9 14h1" ' +
          '/>'#10'<path stroke="#4e0070" d="M8 14h1" />'#10'</svg>'
      end
      item
        IconName = 'Turn'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#bc7f1a" d="M4 0h2M3' +
          ' 1h1M5 1h1M2 2h1M5 2h1M1 3h1M5 3h7M0 4h1M10 7h1M10 8h3M10 9h1M12' +
          ' 9h2M4 10h7M14 10h1M3 11h1M15 11h1" />'#13#10'<path stroke="#fdf9eb" d' +
          '="M4 1h1M4 2h1M11 9h1" />'#13#10'<path stroke="#fffff6" d="M3 2h1" />'#13 +
          #10'<path stroke="#fdf6d8" d="M2 3h3M11 10h3" />'#13#10'<path stroke="#fc' +
          'edc2" d="M1 4h5M7 4h5" />'#13#10'<path stroke="#fbf2c8" d="M6 4h1" />'#13 +
          #10'<path stroke="#a66c17" d="M12 4h1M6 5h1M8 5h1M10 5h1M5 6h1M3 7h' +
          '1M5 7h1M4 8h1M4 12h7M14 12h1M10 13h1M13 13h1M10 14h1M12 14h1M10 ' +
          '15h2" />'#13#10'<path stroke="#aa7118" d="M1 5h1M5 5h1M7 5h1M9 5h1M11 ' +
          '5h1M2 6h1M5 8h1" />'#13#10'<path stroke="#fde6a7" d="M2 5h3M12 11h1" /' +
          '>'#13#10'<path stroke="#fae397" d="M3 6h2M4 7h1M11 12h3M11 13h2M11 14h' +
          '1" />'#13#10'<path stroke="#ba893e" d="M11 7h1" />'#13#10'<path stroke="#fae' +
          'ab3" d="M4 11h5M10 11h1M14 11h1" />'#13#10'<path stroke="#fbf0b2" d="M' +
          '9 11h1M11 11h1M13 11h1" />'#13#10'</svg>'
      end
      item
        IconName = 'Delete'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#191919">'#13#10'  <path d="M280-1' +
          '20q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-4' +
          '0v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-' +
          '280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/>'#13 +
          #10'</svg>'
      end
      item
        IconName = 'AssociationUndirected'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M1 8h14"' +
          ' />'#13#10'</svg>'
      end
      item
        IconName = 'AssociationDirected'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M1 8h14"' +
          '/>'#13#10'<polyline fill="none" stroke="#e1e1e1" points="10.5,3.5 15,8' +
          ' 10.5,12.5 " />   '#13#10'</svg>'
      end
      item
        IconName = 'AssociationBidirectional'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M1 8h14"' +
          '/>'#13#10'<polyline fill="none" stroke="#e1e1e1" points="4.5,3.5 0.5,8' +
          ' 4.5,12.5 " />  '#13#10'<polyline fill="none" stroke="#e1e1e1" points=' +
          '"10.5,3.5 15,8 10.5,12.5 " />   '#13#10'</svg>'#13#10
      end
      item
        IconName = 'Aggregation'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="none" stroke="#e1e1e1" points="1,8 5,4 9,8 5,1' +
          '2" />'#13#10'</svg>'
      end
      item
        IconName = 'AggregationWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="none" stroke="#e1e1e1" points="1,8 5,4 9,8 5,1' +
          '2" />'#13#10'<polyline fill="none" stroke="#e1e1e1" points="10.5,3.5 1' +
          '5,8 10.5,12.5 " />   '#13#10'</svg>'
      end
      item
        IconName = 'Composition'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="#e1e1e1" stroke="#e1e1e1" points="1,8 5,4 9,8 ' +
          '5,12" />'#13#10'</svg>'
      end
      item
        IconName = 'CompositionWithArrow'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M9 8h6"/' +
          '>'#13#10'<polygon fill="#e1e1e1" stroke="#e1e1e1" points="1,8 5,4 9,8 ' +
          '5,12" />'#13#10'  <polyline fill="none" stroke="#e1e1e1" points="10.5,' +
          '3.5 15,8 10.5,12.5 " />   '#13#10'</svg>>'
      end
      item
        IconName = 'Inheritance'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M0 7.5h1' +
          '0 M0 8.5 h10"/>'#13#10'<polygon fill="none" stroke="#e1e1e1" points="1' +
          '0.5,3.5 15,8 10.5,12.5" />  '#13#10'</svg>'
      end
      item
        IconName = 'Implements'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M0 8h4 M' +
          '5 8h5 "/>'#13#10'<polygon fill="none" stroke="#e1e1e1" points="10.5,3.' +
          '5 15,8 10.5,12.5" />  '#13#10'</svg>'
      end
      item
        IconName = 'InstanceOf'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<path stroke="#e1e1e1" d="M0 8 h1 ' +
          'M2 8h7 M10 8h5"/>'#13#10'<polyline fill="none" stroke="#e1e1e1" points' +
          '="10.5,3.5 15,8 10.5,12.5" />  '#13#10'</svg>'
      end
      item
        IconName = 'Recursive'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16">'#13#10'<polyline fill="none" stroke="#e1e' +
          '1e1" points="4,4 6,6 8,4" /> '#13#10'<polyline fill="none" stroke="#e1' +
          'e1e1" points="6,6 6,1 12,1 12,11 9,11" /> '#13#10'</svg>'
      end
      item
        IconName = 'Edit'
        SVGText = 
          '<svg viewBox="0 -0.5 16 16" >'#13#10'<path stroke="#744dd4" d="M12 1h1' +
          '" />'#13#10'<path stroke="#7f38c4" d="M13 1h1" />'#13#10'<path stroke="#764f' +
          'db" d="M11 2h1" />'#13#10'<path stroke="#16c5de" d="M12 2h1" />'#13#10'<path' +
          ' stroke="#2cb08c" d="M13 2h1" />'#13#10'<path stroke="#8f31bc" d="M14 ' +
          '2h1" />'#13#10'<path stroke="#86ed8a" d="M10 3h1" />'#13#10'<path stroke="#4' +
          '7c54d" d="M11 3h1" />'#13#10'<path stroke="#2be9b8" d="M12 3h1" />'#13#10'<p' +
          'ath stroke="#3f9e52" d="M13 3h1" />'#13#10'<path stroke="#7d5e3c" d="M' +
          '14 3h1" />'#13#10'<path stroke="#9f2698" d="M15 3h1" />'#13#10'<path stroke=' +
          '"#e6b474" d="M9 4h1M8 5h1M7 6h1M6 7h1M5 8h1" />'#13#10'<path stroke="#' +
          '99c928" d="M10 4h1" />'#13#10'<path stroke="#157013" d="M11 4h1" />'#13#10'<' +
          'path stroke="#70b02e" d="M12 4h1" />'#13#10'<path stroke="#6e6321" d="' +
          'M13 4h1" />'#13#10'<path stroke="#7d5a38" d="M14 4h1" />'#13#10'<path stroke' +
          '="#bb009c" d="M15 4h1" />'#13#10'<path stroke="#686e06" d="M9 5h1M8 6h' +
          '1M7 7h1M6 8h1" />'#13#10'<path stroke="#d5c910" d="M10 5h1" />'#13#10'<path ' +
          'stroke="#096600" d="M11 5h1" />'#13#10'<path stroke="#1c7a00" d="M12 5' +
          'h1" />'#13#10'<path stroke="#60f528" d="M13 5h1" />'#13#10'<path stroke="#b7' +
          '00c4" d="M14 5h1" />'#13#10'<path stroke="#666606" d="M9 6h1M8 7h1M7 8' +
          'h1M6 9h1" />'#13#10'<path stroke="#cbcb66" d="M10 6h1M10 7h1M9 8h1M8 9' +
          'h1M7 10h1M6 11h1" />'#13#10'<path stroke="#a5bb08" d="M11 6h1" />'#13#10'<pa' +
          'th stroke="#28931f" d="M12 6h1" />'#13#10'<path stroke="#6fe784" d="M1' +
          '3 6h1" />'#13#10'<path stroke="#a1a13d" d="M9 7h1M8 8h1M7 9h1M6 10h1" ' +
          '/>'#13#10'<path stroke="#c9dc62" d="M11 7h1M10 8h1M9 9h1M8 10h1M7 11h1' +
          '" />'#13#10'<path stroke="#fc8c89" d="M12 7h1M11 8h1M10 9h1M9 10h1M8 1' +
          '1h1" />'#13#10'<path stroke="#ecc27c" d="M5 9h1" />'#13#10'<path stroke="#b9' +
          '94ba" d="M4 10h1M3 12h1" />'#13#10'<path stroke="#a1af3b" d="M5 10h1" ' +
          '/>'#13#10'<path stroke="#bda498" d="M4 11h1" />'#13#10'<path stroke="#eef015' +
          '" d="M5 11h1" />'#13#10'<path stroke="#bfd63c" d="M4 12h1" />'#13#10'<path s' +
          'troke="#b1f725" d="M5 12h1" />'#13#10'<path stroke="#fabe52" d="M6 12h' +
          '1" />'#13#10'<path stroke="#f56de1" d="M7 12h1" />'#13#10'<path stroke="#820' +
          '0bc" d="M3 13h1" />'#13#10'<path stroke="#925043" d="M4 13h1" />'#13#10'<pat' +
          'h stroke="#fc6bb6" d="M5 13h1" />'#13#10'<path stroke="#a9a2be" d="M6 ' +
          '13h1M4 14h1" />'#13#10'<path stroke="#9a00e1" d="M3 14h1" />'#13#10'</svg>'
      end
      item
        IconName = 'Delete'
        SVGText = 
          '<svg viewBox="0 -960 960 960" fill="#e6e6e6">'#13#10'  <path d="M280-1' +
          '20q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-4' +
          '0v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-' +
          '280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/>'#13 +
          #10'</svg>'
      end>
    Left = 168
    Top = 136
  end
  object vilAssociationsLight: TVirtualImageList
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
        CollectionName = 'Recursive'
        Name = 'Recursive'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Edit'
        Name = 'Edit'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Turn'
        Name = 'Turn'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Delete'
        Name = 'Delete'
      end>
    ImageCollection = icMenuConnection
    Left = 288
    Top = 136
  end
  object vilAssociationsDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 14
        CollectionName = 'AssociationUndirected'
        Name = 'AssociationUndirected'
      end
      item
        CollectionIndex = 15
        CollectionName = 'AssociationDirected'
        Name = 'AssociationDirected'
      end
      item
        CollectionIndex = 16
        CollectionName = 'AssociationBidirectional'
        Name = 'AssociationBidirectional'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Aggregation'
        Name = 'Aggregation'
      end
      item
        CollectionIndex = 18
        CollectionName = 'AggregationWithArrow'
        Name = 'AggregationWithArrow'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Composition'
        Name = 'Composition'
      end
      item
        CollectionIndex = 20
        CollectionName = 'CompositionWithArrow'
        Name = 'CompositionWithArrow'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Inheritance'
        Name = 'Inheritance'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Implements'
        Name = 'Implements'
      end
      item
        CollectionIndex = 23
        CollectionName = 'InstanceOf'
        Name = 'InstanceOf'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Recursive'
        Name = 'Recursive'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Edit'
        Name = 'Edit'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Turn'
        Name = 'Turn'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Delete'
        Name = 'Delete'
      end>
    ImageCollection = icMenuConnection
    Left = 416
    Top = 136
  end
  object icUMLRtfdComponents: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'PrivateAttribute'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'  <rect x="2" y="2" width="12" height' +
          '="12" style="fill:#ccdde6;stroke-width:1;stroke:#5a5a5a" />'#13#10'<po' +
          'lygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="#5' +
          'a5a5a" />  '#13#10'</svg>'#13#10
      end
      item
        IconName = 'PackageAttribute'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'  <rect x="2" y="2" width="12" height' +
          '="12" style="fill:#ccdde6;stroke-width:1;stroke:#5a5a5a" />'#13#10'<te' +
          'xt x="3.6" y="12" fill="#5a5a5a">~</text>'#13#10'</svg>'
      end
      item
        IconName = 'ProtectedAttribute'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'  <rect x="2" y="2" width="12" height' +
          '="12" style="fill:#ccdde6;stroke-width:1;stroke:#5a5a5a" />'#13#10'<pa' +
          'th stroke="#5a5a5a" d="M4.5 6 h7 M4.5 10 h7 M6 4.5 v7 M10 4.5 v7' +
          '" /> '#13#10'</svg>'#13#10
      end
      item
        IconName = 'PublicAttribute'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'  <rect x="2" y="2" width="12" height' +
          '="12" style="fill:#ccdde6;stroke-width:1;stroke:#5a5a5a" />'#13#10'<po' +
          'lygon points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="#5' +
          'a5a5a" />'#13#10'<polygon points="7.5,5 8.5,5 8.5,11 7.5,11 " fill="no' +
          'ne" stroke="#5a5a5a" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PrivateMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#5a' +
          '5a5a"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#ccdde6"/> '#13#10'<polyg' +
          'on points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="#5a5a' +
          '5a" />'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PackageMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#5a' +
          '5a5a"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#ccdde6"/> '#13#10'<text ' +
          'x="3.6" y="12" fill="#5a5a5a">~</text>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'ProtectedMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#5a' +
          '5a5a"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#ccdde6"/> '#13#10'<path ' +
          'stroke="#5a5a5a" d="M4.5 6 h7 M4.5 10 h7 M6 4.5 v7 M10 4.5 v7" /' +
          '>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'PublicMethod'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#5a' +
          '5a5a"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#ccdde6"/> '#13#10'<polyg' +
          'on points="5,7.5 11,7.5 11,8.5 5,8.5 " fill="none" stroke="#5a5a' +
          '5a" />'#13#10'<polygon points="7.5,5 8.5,5 8.5,11 7.5,11 " fill="none"' +
          ' stroke="#5a5a5a" />'#13#10'</svg>'
      end
      item
        IconName = 'Constructor'
        SVGText = 
          '<svg viewBox="0 0 16 16">'#13#10'<circle cx="8" cy="8" r="7" fill="#5a' +
          '5a5a"/>'#13#10'<circle cx="8" cy="8" r="5.5" fill="#ccdde6"/> '#13#10'  <pat' +
          'h d="M 10.5, 5'#13#10'           C 8.5, 3, 4.5, 4, 4.5, 8'#13#10'           ' +
          'C 4.5, 12, 8.5, 13, 10.5, 11"'#13#10#13#10'        fill="none" stroke="#5a' +
          '5a5a" stroke-width="1.5"/></svg>'#13#10
      end>
    Left = 56
    Top = 383
  end
  object vilUMLRtfdComponentsLight: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'PrivateAttribute'
        Name = 'PrivateAttribute'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PackageAttribute'
        Name = 'PackageAttribute'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ProtectedAttribute'
        Name = 'ProtectedAttribute'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PublicAttribute'
        Name = 'PublicAttribute'
      end
      item
        CollectionIndex = 4
        CollectionName = 'PrivateMethod'
        Name = 'PrivateMethod'
      end
      item
        CollectionIndex = 5
        CollectionName = 'PackageMethod'
        Name = 'PackageMethod'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ProtectedMethod'
        Name = 'ProtectedMethod'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PublicMethod'
        Name = 'PublicMethod'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Constructor'
        Name = 'Constructor'
      end>
    ImageCollection = icUMLRtfdComponents
    Left = 232
    Top = 383
  end
  object vilUMLRtfdComponentsDark: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'PrivateAttribute'
        Name = 'PrivateAttribute'
      end
      item
        CollectionIndex = 1
        CollectionName = 'PackageAttribute'
        Name = 'PackageAttribute'
      end
      item
        CollectionIndex = 2
        CollectionName = 'ProtectedAttribute'
        Name = 'ProtectedAttribute'
      end
      item
        CollectionIndex = 3
        CollectionName = 'PublicAttribute'
        Name = 'PublicAttribute'
      end
      item
        CollectionIndex = 4
        CollectionName = 'PrivateMethod'
        Name = 'PrivateMethod'
      end
      item
        CollectionIndex = 5
        CollectionName = 'PackageMethod'
        Name = 'PackageMethod'
      end
      item
        CollectionIndex = 6
        CollectionName = 'ProtectedMethod'
        Name = 'ProtectedMethod'
      end
      item
        CollectionIndex = 7
        CollectionName = 'PublicMethod'
        Name = 'PublicMethod'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Constructor'
        Name = 'Constructor'
      end>
    ImageCollection = icUMLRtfdComponents
    Left = 379
    Top = 383
  end
end
