object AFrameDiagram: TAFrameDiagram
  Left = 0
  Top = 0
  Width = 600
  Height = 439
  Align = alClient
  TabOrder = 0
  TabStop = True
  object PopupMenuAlign: TSpTBXPopupMenu
    Images = DMImages.ILAlign
    Left = 40
    Top = 200
    object MIPopupLeft: TSpTBXItem
      Tag = 1
      Caption = 'Left'
      ImageIndex = 0
      OnClick = MIPopupAlignClick
    end
    object MIPopupCentered: TSpTBXItem
      Tag = 2
      Caption = 'Center'
      ImageIndex = 1
      OnClick = MIPopupAlignClick
    end
    object MIPopupRight: TSpTBXItem
      Tag = 3
      Caption = 'Right'
      ImageIndex = 2
      OnClick = MIPopupAlignClick
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object MIPopupTop: TSpTBXItem
      Tag = 4
      Caption = 'Top'
      ImageIndex = 3
      OnClick = MIPopupAlignClick
    end
    object MIPopupMiddle: TSpTBXItem
      Tag = 5
      Caption = 'Center'
      ImageIndex = 4
      OnClick = MIPopupAlignClick
    end
    object MIPopupBottom: TSpTBXItem
      Tag = 6
      Caption = 'Bottom'
      ImageIndex = 5
      OnClick = MIPopupAlignClick
    end
  end
  object PopMenuConnection: TSpTBXPopupMenu
    Images = DMImages.ILAssoziationenLight
    Left = 40
    Top = 136
    object MIConnectionAssociation: TSpTBXItem
      Caption = 'Association'
      ImageIndex = 0
      OnClick = MIConnectionClick
    end
    object MIConnectionAssociationArrow: TSpTBXItem
      Tag = 1
      Caption = 'Association directed'
      ImageIndex = 1
      OnClick = MIConnectionClick
    end
    object MIConnectionAssociationBidirectional: TSpTBXItem
      Tag = 2
      Caption = 'Association bidirectional'
      ImageIndex = 2
      OnClick = MIConnectionClick
    end
    object MIConnectionAggregation: TSpTBXItem
      Tag = 3
      Caption = 'Aggregation'
      ImageIndex = 3
      OnClick = MIConnectionClick
    end
    object MIConnectionAggregationArrow: TSpTBXItem
      Tag = 4
      Caption = 'Aggregation with arrow'
      ImageIndex = 4
      OnClick = MIConnectionClick
    end
    object MIConnectionComposition: TSpTBXItem
      Tag = 5
      Caption = 'Composition'
      ImageIndex = 5
      OnClick = MIConnectionClick
    end
    object MIConnectionCompositionArrow: TSpTBXItem
      Tag = 6
      Caption = 'Composition with arrow'
      ImageIndex = 6
      OnClick = MIConnectionClick
    end
    object MIConnectionInheritance: TSpTBXItem
      Tag = 7
      Caption = 'Inheritance'
      ImageIndex = 7
      OnClick = MIConnectionClick
    end
    object MIConnectionInstanceOf: TSpTBXItem
      Tag = 9
      Caption = 'Instance of'
      ImageIndex = 9
      OnClick = MIConnectionClick
    end
    object SpTBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object MIConnectionRecursiv: TSpTBXSubmenuItem
      Caption = 'Recursive relation'
      ImageIndex = 13
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
      ImageIndex = 12
      OnClick = MIConnectionClick
    end
    object MIConnectionTurn: TSpTBXItem
      Tag = 11
      Caption = 'Turn'
      ImageIndex = 10
      OnClick = MIConnectionClick
    end
    object MIConnectionDelete: TSpTBXItem
      Tag = 12
      Caption = 'Delete'
      ImageIndex = 11
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
    Images = DMImages.ILUMLToolbarLight
    OnPopup = PopupMenuWindowPopup
    Left = 40
    Top = 256
    object MIWindowPopupNewClass: TSpTBXItem
      Caption = 'New class'
      ImageIndex = 1
      OnClick = MIWindowPopupNewClassClick
    end
    object MIWindowPopupOpenClass: TSpTBXItem
      Caption = 'Open class'
      ImageIndex = 2
      OnClick = MIWindowPopupOpenClassClick
    end
    object MIWindowPopupNewComment: TSpTBXItem
      Caption = 'New comment'
      ImageIndex = 9
      OnClick = MIWindowPopupNewCommentClick
    end
    object MIWindowPopupNewLayout: TSpTBXItem
      Caption = 'New layout'
      ImageIndex = 10
      OnClick = MIWindowPopupNewLayoutClick
    end
    object MIWindowPopupRefresh: TSpTBXItem
      Caption = 'Refresh'
      ImageIndex = 11
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
      OnClick = MIWindowPopupFontClick
    end
    object MIWindowPopupCopyAsPicture: TSpTBXItem
      Tag = 1
      Caption = 'Copy as picture'
      ImageIndex = 15
      OnClick = MIWindowPopupCopyAsPictureClick
    end
    object MIWindowPopupConfiguration: TSpTBXItem
      Caption = 'Configuration'
      ImageIndex = 13
      OnClick = MIWindowPopupConfigurationClick
    end
  end
  object PopMenuObject: TSpTBXPopupMenu
    Images = DMImages.ILUMLLight
    OnPopup = PopMenuObjectPopup
    Left = 32
    Top = 72
    object MIObjectPopupEdit: TSpTBXItem
      Tag = 1
      Caption = 'Edit'
      ImageIndex = 6
      OnClick = MIObjectPopupEditClick
    end
    object MIObjectPopupShowAllNewObjects: TSpTBXItem
      Tag = 1
      Caption = 'Show all new objects'
      ImageIndex = 19
      OnClick = MIObjectPopupShowAllNewObjectsClick
    end
    object MIObjectPopupShowNewObject: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Show object'
      ImageIndex = 19
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
      ImageIndex = 20
      OnClick = MIClassPopupDeleteClick
    end
    object MIObjectPopupCopyAsPicture: TSpTBXItem
      Tag = 1
      Caption = 'Copy as picture'
      ImageIndex = 5
      OnClick = MIClassPopupCopyAsPictureClick
    end
  end
  object PopMenuClass: TSpTBXPopupMenu
    Images = DMImages.ILUMLLight
    OnPopup = PopMenuClassPopup
    Left = 32
    Top = 16
    object MIClassPopupRunAllTests: TSpTBXItem
      Tag = 1
      Caption = 'Run all tests'
      ImageIndex = 21
      OnClick = MIClassPopupRunAllTestsClick
    end
    object MIClassPopupRunOneTest: TSpTBXItem
      Tag = 1
      Caption = 'Run one test'
      ImageIndex = 21
    end
    object NEndOfJUnitTest: TSpTBXSeparatorItem
      Tag = 1
    end
    object MIClassPopupClassEdit: TSpTBXItem
      Tag = 1
      Caption = 'Edit class'
      ImageIndex = 0
      OnClick = MIClassPopupClassEditClick
    end
    object MIClassPopupRun: TSpTBXItem
      Tag = 1
      Caption = 'Run'
      ImageIndex = 21
      OnClick = MIClassPopupRunClick
    end
    object MIClassPopupOpenSource: TSpTBXItem
      Tag = 1
      Caption = 'Open source code'
      ImageIndex = 22
      OnClick = MIClassPopupOpenSourceClick
    end
    object MIClassPopupConnect: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Connect with'
      ImageIndex = 18
    end
    object MIClassPopupSelectAssociation: TSpTBXItem
      Tag = 1
      Caption = 'Select connection type'
      ImageIndex = 18
      OnClick = MIClassPopupSelectAssociationClick
    end
    object MIClassPopupOpenClass: TSpTBXSubmenuItem
      Tag = 1
      Caption = 'Open class'
      ImageIndex = 17
    end
    object MIClassPopupNewComment: TSpTBXItem
      Tag = 1
      Caption = 'New comment'
      ImageIndex = 23
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
      OnClick = MIClassPopupDeleteClick
    end
    object MIClassPopupCopyAsPicture: TSpTBXItem
      Tag = 1
      Caption = 'Copy as picture'
      ImageIndex = 5
      OnClick = MIClassPopupCopyAsPictureClick
    end
    object MIClassPopupCreateTestClass: TSpTBXItem
      Tag = 1
      Caption = 'Create test class'
      ImageIndex = 24
      OnClick = MIClassPopupCreateTestClassClick
    end
  end
end
