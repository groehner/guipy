inherited ProjectExplorerWindow: TProjectExplorerWindow
  HelpContext = 435
  Caption = 'Project Explorer'
  ClientHeight = 399
  ClientWidth = 531
  OnShow = FormShow
  ExplicitWidth = 547
  ExplicitHeight = 438
  TextHeight = 15
  inherited BGPanel: TPanel
    Width = 531
    Height = 399
    ExplicitWidth = 531
    ExplicitHeight = 399
    inherited FGPanel: TPanel
      Width = 527
      Height = 395
      ExplicitWidth = 527
      ExplicitHeight = 395
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 527
        Height = 395
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object ExplorerTree: TVirtualStringTree
          Left = 0
          Top = 30
          Width = 527
          Height = 365
          Align = alClient
          BorderStyle = bsNone
          DefaultNodeHeight = 19
          Header.AutoSizeIndex = -1
          Header.Height = 15
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          HintMode = hmHintAndDefault
          Images = vilProjects
          IncrementalSearch = isAll
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoChangeScale]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toWheelPanning]
          TreeOptions.PaintOptions = [toHideSelection, toHotTrack, toShowButtons, toShowDropmark, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toMultiSelect, toRightClickSelect, toSiblingSelectConstraint]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnContextPopup = ExplorerTreeContextPopup
          OnDragAllowed = ExplorerTreeDragAllowed
          OnDragOver = ExplorerTreeDragOver
          OnDragDrop = ExplorerTreeDragDrop
          OnEditing = ExplorerTreeEditing
          OnGetCellText = ExplorerTreeGetCellText
          OnGetImageIndexEx = ExplorerTreeGetImageIndexEx
          OnGetHint = ExplorerTreeGetHint
          OnIncrementalSearch = ExplorerTreeIncrementalSearch
          OnInitChildren = ExplorerTreeInitChildren
          OnInitNode = ExplorerTreeInitNode
          OnKeyPress = ExplorerTreeKeyPress
          OnNewText = ExplorerTreeNewText
          OnNodeDblClick = ExplorerTreeNodeDblClick
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
        object SpTBXDock1: TSpTBXDock
          Left = 0
          Top = 0
          Width = 527
          Height = 30
          AllowDrag = False
          DoubleBuffered = True
          object SpTBXToolbar1: TSpTBXToolbar
            Left = 0
            Top = 0
            Align = alTop
            AutoResize = False
            DockMode = dmCannotFloat
            FullSize = True
            Images = vilImages
            TabOrder = 0
            Caption = 'Project Explorer Toolbar'
            Customizable = False
            object tbiProjectNew: TSpTBXItem
              Action = CommandsDataModule.actProjectNew
            end
            object tbiProjectOpen: TSpTBXItem
              Action = CommandsDataModule.actProjectOpen
            end
            object tbiProjectSave: TSpTBXItem
              Action = CommandsDataModule.actProjectSave
            end
            object SpTBXSeparatorItem8: TSpTBXSeparatorItem
            end
            object tbiRunLast: TSpTBXItem
              Action = PyIDEMainForm.actRunLastScript
              ImageIndex = 17
            end
            object tbiDebugLast: TSpTBXItem
              Action = PyIDEMainForm.actRunDebugLastScript
              ImageIndex = 18
            end
            object tbiRunLastExternal: TSpTBXItem
              Action = PyIDEMainForm.actRunLastScriptExternal
              ImageIndex = 19
            end
            object SpTBXSeparatorItem11: TSpTBXSeparatorItem
            end
            object tbiExpandAll: TSpTBXItem
              Action = actProjectExpandAll
            end
            object tbiCollapseAll: TSpTBXItem
              Action = actProjectCollapseAll
            end
          end
        end
      end
    end
  end
  object ProjectActionList: TActionList [1]
    Images = vilImages
    Left = 225
    Top = 44
    object actProjectRelativePaths: TAction
      Category = 'Project'
      AutoCheck = True
      Caption = 'Store &Relative Paths'
      HelpContext = 435
      HelpType = htContext
      Hint = 'Store file paths relative to the project directory'
      OnExecute = actProjectRelativePathsExecute
    end
    object actProjectShowFileExtensions: TAction
      Category = 'Project'
      AutoCheck = True
      Caption = 'Show File &Extensions'
      HelpContext = 435
      HelpType = htContext
      Hint = 'Display file extensions'
      OnExecute = actProjectShowFileExtensionsExecute
    end
    object actProjectExtraPythonPath: TAction
      Category = 'Project'
      Caption = 'Extra Python &Path...'
      HelpContext = 435
      HelpType = htContext
      ImageIndex = 0
      ImageName = 'Folders'
      OnExecute = actProjectExtraPythonPathExecute
    end
    object actProjectExpandAll: TAction
      Category = 'Project'
      Caption = '&Expand All'
      HelpContext = 435
      HelpType = htContext
      Hint = 'Expand all project nodes'
      ImageIndex = 2
      ImageName = 'Expand'
      OnExecute = actProjectExpandAllExecute
    end
    object actProjectCollapseAll: TAction
      Category = 'Project'
      Caption = '&Collapse All'
      HelpContext = 435
      HelpType = htContext
      Hint = 'Collapse all project nodes'
      ImageIndex = 3
      ImageName = 'Collapse'
      OnExecute = actProjectCollapseAllExecute
    end
  end
  object ImmutableProjectActionList: TActionList [2]
    Images = vilImages
    Left = 72
    Top = 44
    object actProjectAddFiles: TAction
      Category = 'Project'
      Caption = '&Add File(s)...'
      HelpContext = 435
      Hint = 'Add file(s) to a project folder'
      ImageIndex = 8
      ImageName = 'ProjectAdd'
      OnExecute = actProjectAddFilesExecute
    end
    object actProjectAddFolder: TAction
      Category = 'Project'
      Caption = 'Add &Subfolder'
      HelpContext = 435
      Hint = 'Add a new subfolder'
      ImageIndex = 10
      ImageName = 'FolderAdd'
      OnExecute = actProjectAddFolderExecute
    end
    object actProjectRemove: TAction
      Category = 'Project'
      Caption = '&Remove'
      HelpContext = 435
      Hint = 'Remove a file, folder or run configuration from the project'
      ImageIndex = 9
      ImageName = 'ProjectRemove'
      OnExecute = actProjectRemoveExecute
    end
    object actProjectRename: TAction
      Category = 'Project'
      Caption = 'Re&name'
      HelpContext = 435
      Hint = 'Rename the selected folder or RunConfiguration'
      OnExecute = actProjectRenameExecute
    end
    object actProjectFileEdit: TAction
      Category = 'Project'
      Caption = '&Edit'
      HelpContext = 435
      Hint = 'Open the selected file in the editor'
      ImageIndex = 11
      ImageName = 'Editor'
      OnExecute = actProjectFileEditExecute
    end
    object actProjectAddActiveFile: TAction
      Category = 'Project'
      Caption = 'Add Active File'
      HelpContext = 435
      Hint = 'Add the active editor file to the folder'
      OnExecute = actProjectAddActiveFileExecute
    end
    object actProjectImportDirectory: TAction
      Category = 'Project'
      Caption = '&Import Directory...'
      HelpContext = 435
      Hint = 'Import a directory into the selected folder'
      OnExecute = actProjectImportDirectoryExecute
    end
    object actProjectAddRunConfig: TAction
      Category = 'Project'
      Caption = 'Add Run Configuration'
      HelpContext = 435
      Hint = 'Add run configuration'
      ImageIndex = 13
      ImageName = 'RunConfigAdd'
      OnExecute = actProjectAddRunConfigExecute
    end
    object actProjectEditRunConfig: TAction
      Category = 'Project'
      Caption = '&Edit Run Configuration'
      HelpContext = 435
      Hint = 'Edit run configuration'
      ImageIndex = 14
      ImageName = 'RunConfigEdit'
      OnExecute = actProjectEditRunConfigExecute
    end
    object actProjectFileProperties: TAction
      Category = 'Project'
      Caption = '&Properties'
      HelpContext = 435
      Hint = 'Show file properties'
      ImageIndex = 15
      ImageName = 'FileProperties'
      OnExecute = actProjectFilePropertiesExecute
    end
    object actProjectRun: TAction
      Category = 'Project'
      Caption = '&Run'
      HelpContext = 435
      Hint = 'Run the selected configuration'
      ImageIndex = 4
      ImageName = 'Run'
      OnExecute = actProjectRunExecute
    end
    object actProjectExternalRun: TAction
      Category = 'Project'
      Caption = 'E&xternal Run'
      HelpContext = 435
      Hint = 'Run configuration using an external Python interpreter'
      ImageIndex = 1
      ImageName = 'ExternalRun'
      OnExecute = actProjectExternalRunExecute
    end
    object actProjectDebug: TAction
      Category = 'Project'
      Caption = '&Debug'
      HelpContext = 435
      Hint = 'Debug the selected configuration'
      ImageIndex = 5
      ImageName = 'Debug'
      OnExecute = actProjectDebugExecute
    end
    object actProjectAddRemoteFile: TAction
      Category = 'Project'
      Caption = 'Add Remote File'
      HelpContext = 435
      Hint = 'Add a remote file to the folder'
      ImageIndex = 16
      ImageName = 'Download'
      OnExecute = actProjectAddRemoteFileExecute
    end
  end
  inherited DockClient: TJvDockClient
    Left = 304
    Top = 30
  end
  object ProjectMainPopUpMenu: TSpTBXPopupMenu
    Images = vilImages
    OnPopup = ProjectMainPopUpMenuPopup
    Left = 264
    Top = 260
    object mnProjectNew: TSpTBXItem
      Action = CommandsDataModule.actProjectNew
    end
    object mnProjectOpen: TSpTBXItem
      Action = CommandsDataModule.actProjectOpen
    end
    object mnProjectSave: TSpTBXItem
      Action = CommandsDataModule.actProjectSave
    end
    object mnProjectSaveAs: TSpTBXItem
      Action = CommandsDataModule.actProjectSaveAs
    end
    object SpTBXSeparatorItem10: TSpTBXSeparatorItem
    end
    object mnExpandAll: TSpTBXItem
      Action = actProjectExpandAll
    end
    object mnCollapseAll: TSpTBXItem
      Action = actProjectCollapseAll
    end
    object SpTBXSeparatorItem9: TSpTBXSeparatorItem
    end
    object mnShowFileExt: TSpTBXItem
      Action = actProjectShowFileExtensions
    end
    object mnStoreRelativePaths: TSpTBXItem
      Action = actProjectRelativePaths
    end
    object SpTBXSeparatorItem12: TSpTBXSeparatorItem
    end
    object mnExtraPythonPath: TSpTBXItem
      Action = actProjectExtraPythonPath
    end
  end
  object ProjectFolderPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 288
    Top = 205
    object mnAddFiles: TSpTBXItem
      Action = actProjectAddFiles
    end
    object mnAddActiveFile: TSpTBXItem
      Action = actProjectAddActiveFile
    end
    object SpTBXItem1: TSpTBXItem
      Action = actProjectAddRemoteFile
    end
    object SpTBXItem6: TSpTBXItem
      Action = actProjectAddFolder
    end
    object mnImportDir: TSpTBXItem
      Action = actProjectImportDirectory
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object mnRename: TSpTBXItem
      Action = actProjectRename
    end
    object SpTBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object mnRemove: TSpTBXItem
      Action = actProjectRemove
    end
  end
  object ProjectFilePopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 424
    Top = 212
    object mnFileEdit: TSpTBXItem
      Action = actProjectFileEdit
    end
    object SpTBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object mnFileRemove: TSpTBXItem
      Action = actProjectRemove
    end
    object SpTBXSeparatorItem6: TSpTBXSeparatorItem
    end
    object mnFileProperties: TSpTBXItem
      Action = actProjectFileProperties
    end
  end
  object ProjectRunSettingsPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 424
    Top = 37
    object mnAddRunConfig: TSpTBXItem
      Action = actProjectAddRunConfig
    end
  end
  object ProjectRunConfigPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 287
    Top = 125
    object mnRun: TSpTBXItem
      Action = actProjectRun
    end
    object mnDebug: TSpTBXItem
      Action = actProjectDebug
    end
    object mnExternalRun: TSpTBXItem
      Action = actProjectExternalRun
    end
    object SpTBXSeparatorItem7: TSpTBXSeparatorItem
    end
    object mnEditRunConfig: TSpTBXItem
      Action = actProjectEditRunConfig
    end
    object SpTBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object mnRenameRunConfig: TSpTBXItem
      Action = actProjectRename
    end
    object SpTBXSeparatorItem4: TSpTBXSeparatorItem
    end
    object mnRemoveRunConfig: TSpTBXItem
      Action = actProjectRemove
    end
  end
  object vilProjects: TVirtualImageList
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'Projects\Project'
        Name = 'Project'
      end
      item
        CollectionIndex = 0
        CollectionName = 'Projects\Folder'
        Name = 'Folder'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Projects\RunConfigs'
        Name = 'RunConfigs'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Projects\RunConfig'
        Name = 'RunConfig'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Projects\FolderAutoRefresh'
        Name = 'FolderAutoRefresh'
      end>
    ImageCollection = icProjects
    PreserveItems = True
    Width = 18
    Height = 18
    Left = 56
    Top = 160
  end
  object vilImages: TVirtualImageList
    Images = <
      item
        CollectionIndex = 46
        CollectionName = 'Folders'
        Name = 'Folders'
      end
      item
        CollectionIndex = 32
        CollectionName = 'ExternalRun'
        Name = 'ExternalRun'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Expand'
        Name = 'Expand'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Collapse'
        Name = 'Collapse'
      end
      item
        CollectionName = 'Run'
        Name = 'Run'
      end
      item
        CollectionName = 'Debug'
        Name = 'Debug'
      end
      item
        CollectionIndex = 75
        CollectionName = 'ProjectFile'
        Name = 'ProjectFile'
      end
      item
        CollectionIndex = 76
        CollectionName = 'ProjectOpen'
        Name = 'ProjectOpen'
      end
      item
        CollectionIndex = 73
        CollectionName = 'ProjectAdd'
        Name = 'ProjectAdd'
      end
      item
        CollectionIndex = 77
        CollectionName = 'ProjectRemove'
        Name = 'ProjectRemove'
      end
      item
        CollectionIndex = 45
        CollectionName = 'FolderAdd'
        Name = 'FolderAdd'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Editor'
        Name = 'Editor'
      end
      item
        CollectionIndex = 78
        CollectionName = 'ProjectSave'
        Name = 'ProjectSave'
      end
      item
        CollectionIndex = 94
        CollectionName = 'RunConfigAdd'
        Name = 'RunConfigAdd'
      end
      item
        CollectionIndex = 95
        CollectionName = 'RunConfigEdit'
        Name = 'RunConfigEdit'
      end
      item
        CollectionIndex = 39
        CollectionName = 'FileProperties'
        Name = 'FileProperties'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Download'
        Name = 'Download'
      end
      item
        CollectionIndex = 96
        CollectionName = 'RunLast'
        Name = 'RunLast'
      end
      item
        CollectionIndex = 19
        CollectionName = 'DebugLast'
        Name = 'DebugLast'
      end
      item
        CollectionIndex = 33
        CollectionName = 'ExternalRunLast'
        Name = 'ExternalRunLast'
      end>
    ImageCollection = ResourcesDataModule.icSVGImages
    PreserveItems = True
    Width = 20
    Height = 20
    Left = 106
    Top = 160
  end
  object icProjects: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'Projects\Folder'
        SVGText = 
          '<svg viewBox="0 0 36 36">'#13#10#9'<path d="M31.2,7.2H18l-3.3-3.6H4.8c-' +
          '1.9,0-3.3,1.7-3.3,3.6v21.6c0,2,1.4,3.6,3.3,3.6h26.4c1.9,0,3.3-1.' +
          '6,3.3-3.6v-18'#13#10#9#9'C34.5,8.8,33,7.2,31.2,7.2z M31.2,28.8H4.8v-18h2' +
          '6.4V28.8z"/>'#13#10#9'<path d="M22.6,26.5h-9.2c-0.8,0-1.5-0.7-1.5-1.5V1' +
          '4.6c0-0.8,0.7-1.5,1.5-1.5h9.2c0.8,0,1.5,0.7,1.5,1.5V25'#13#10#9#9'C24.1,' +
          '25.8,23.4,26.5,22.6,26.5z M14.9,23.5h6.2v-7.3h-6.2V23.5z"/>'#13#10'</s' +
          'vg>'
      end
      item
        IconName = 'Projects\Project'
        SVGText = 
          '<svg viewBox="0 0 36 36">'#13#10'<g transform="scale(1.5) translate(-4' +
          ',-4)">'#13#10#9'<path d="M25.2,19.8v-7.6c0-0.9-0.5-1.8-1.3-2.3l-6.6-3.8' +
          'c-0.4-0.2-0.9-0.4-1.3-0.4c-0.5,0-0.9,0.1-1.3,0.4L8.1,9.9'#13#10#9#9'c-0.' +
          '8,0.5-1.3,1.3-1.3,2.3v7.6c0,0.9,0.5,1.8,1.3,2.3l6.6,3.8c0.4,0.2,' +
          '0.9,0.4,1.3,0.4c0.5,0,0.9-0.1,1.3-0.4l6.6-3.8'#13#10#9#9'C24.7,21.6,25.2' +
          ',20.7,25.2,19.8z M14.7,22.8l-5.3-3v-6.1l5.3,3.1V22.8z M16,14.5l-' +
          '5.2-3l5.2-3l5.2,3L16,14.5z M22.6,19.8l-5.3,3'#13#10#9#9'v-6.1l5.3-3.1V19' +
          '.8z"/>'#13#10'</g>'#13#10'</svg>'
      end
      item
        IconName = 'Projects\RunConfig'
        SVGText = 
          '<svg viewBox="0 0 36 36">'#13#10#9'<defs>'#13#10#9#9'<clipPath id="cp">'#13#10#9#9#9'<po' +
          'lygon points="2.4,2.4 2.4,33.6 21.9,33.6 21.9,18 33.6,18 33.6,2.' +
          '4 '#9#9'"/>'#13#10#9#9'</clipPath>'#13#10#9'</defs>'#13#10#9'<path d="M33.2,24.5l-6.4,6.4l' +
          '-2.2-2.2l2.6-2.6h-6.7v-3.2h6.7l-2.6-2.6l2.2-2.2l3.1,3l2.8,2.9L33' +
          '.2,24.5z"/>'#13#10#9'<g clip-path="url(#cp)">'#13#10#9#9'<path d="M31.6,23.6V12' +
          '.4c0-1.4-0.7-2.7-1.9-3.4l-9.7-5.6c-0.6-0.4-1.3-0.5-1.9-0.5s-1.3,' +
          '0.2-1.9,0.5L6.3,9c-1.2,0.7-1.9,2-1.9,3.4'#13#10#9#9#9'v11.2c0,1.4,0.7,2.7' +
          ',1.9,3.4l9.7,5.6c0.6,0.4,1.3,0.5,1.9,0.5s1.3-0.2,1.9-0.5l9.7-5.6' +
          'C30.9,26.3,31.6,25,31.6,23.6z M16.1,28.1'#13#10#9#9#9'l-7.8-4.5v-9l7.8,4.' +
          '5V28.1z M18,15.7l-7.7-4.5L18,6.8l7.7,4.4L18,15.7z M27.7,23.6l-7.' +
          '8,4.5v-9l7.8-4.5V23.6z"/>'#13#10#9'</g>'#13#10'</svg>'
      end
      item
        IconName = 'Projects\RunConfigs'
        SVGText = 
          '<svg viewBox="0 0 36 36">'#13#10'<path d="M31.2,7.2H18l-3.3-3.6H4.8c-1' +
          '.9,0-3.3,1.7-3.3,3.6v21.6c0,2,1.4,3.6,3.3,3.6h26.4c1.9,0,3.3-1.6' +
          ',3.3-3.6v-18'#13#10#9'C34.5,8.8,33,7.2,31.2,7.2z M31.2,28.8H4.8v-18h26.' +
          '4V28.8z"/>'#13#10'<path d="M18.4,18h-7.6v3.6h7.6l-2.9,2.9L18,27l7.2-7.' +
          '2L18,12.6l-2.5,2.5L18.4,18z"/>'#13#10'</svg>'
      end
      item
        IconName = 'Projects\FolderAutoRefresh'
        SVGText = 
          '<svg viewBox="0 0 24 24">'#13#10'  <path d="M18 14.5C19.11 14.5 20.11 ' +
          '14.95 20.83 15.67L22 14.5V18.5H18L19.77 16.73C19.32 16.28 18.69 ' +
          '16 18 16C16.62 16 15.5 17.12 15.5 18.5C15.5 19.88 16.62 21 18 21' +
          'C18.82 21 19.54 20.61 20 20H21.71C21.12 21.47 19.68 22.5 18 22.5' +
          'C15.79 22.5 14 20.71 14 18.5C14 16.29 15.79 14.5 18 14.5M20 8H4V' +
          '18H12L12 18.5C12 19 12.06 19.5 12.17 20H4C2.89 20 2 19.1 2 18L2 ' +
          '6C2 4.89 2.89 4 4 4H10L12 6H20C21.1 6 22 6.89 22 8V13C21.39 12.6' +
          '3 20.72 12.34 20 12.17V8Z"/>'#13#10'</svg>'#13#10
      end>
    Left = 10
    Top = 160
  end
  object ProjectAutoUpdateFolderPopupMenu: TSpTBXPopupMenu
    Images = vilImages
    Left = 424
    Top = 117
    object SpTBXItem8: TSpTBXItem
      Action = actProjectRename
    end
    object SpTBXSeparatorItem14: TSpTBXSeparatorItem
    end
    object SpTBXItem9: TSpTBXItem
      Action = actProjectRemove
    end
  end
end
