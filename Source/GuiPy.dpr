﻿{-----------------------------------------------------------------------------
 Program:   GuiPy
 Author:    Gerhard Röhner
            Kiriakos Vlahos
 Date:      2022.03.07
 Purpose:   Python IDE written with Python for Delphi
 History:
-----------------------------------------------------------------------------}
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
program GuiPy;
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  WinApi.Windows,
  System.SysUtils,
  Vcl.HTMLHelpViewer,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  VirtualTrees.Accessibility,
  uCmdLine in 'uCmdLine.pas',
  frmPyIDEMain in 'frmPyIDEMain.pas' {PyIDEMainForm},
  uEditAppIntfs in 'uEditAppIntfs.pas',
  frmEditor in 'frmEditor.pas' {EditorForm},
  dmCommands in 'dmCommands.pas' {CommandsDataModule: TDataModule},
  uHighlighterProcs in 'uHighlighterProcs.pas',
  dlgConfirmReplace in 'dlgConfirmReplace.pas' {ConfirmReplaceDialog},
  frmPythonII in 'frmPythonII.pas' {PythonIIForm},
  frmMessages in 'frmMessages.pas' {MessagesWindow},
  cPyDebugger in 'cPyDebugger.pas',
  dlgSynPageSetup in 'dlgSynPageSetup.pas' {PageSetupDlg},
  dlgSynPrintPreview in 'dlgSynPrintPreview.pas' {PrintPreviewDlg},
  frmCallStack in 'frmCallStack.pas' {CallStackWindow},
  frmBreakPoints in 'frmBreakPoints.pas' {BreakPointsWindow},
  frmWatches in 'frmWatches.pas' {WatchesWindow},
  frmVariables in 'frmVariables.pas' {VariablesWindow},
  frmCodeExplorer in 'frmCodeExplorer.pas' {CodeExplorerWindow},
  dlgDirectoryList in 'dlgDirectoryList.pas' {DirectoryListDialog},
  frmFileExplorer in 'frmFileExplorer.pas' {FileExplorerWindow},
  frmIDEDockWin in 'frmIDEDockWin.pas' {IDEDockWindow},
  frmDisassemlyView in 'frmDisassemlyView.pas' {DisForm},
  frmDocView in 'frmDocView.pas' {DocForm},
  frmWebPreview in 'frmWebPreview.pas' {WebPreviewForm},
  SynHighlighterPython in 'SynHighlighterPython.pas',
  frmToDo in 'frmToDo.pas' {ToDoWindow},
  dlgToDoOptions in 'dlgToDoOptions.pas' {fmToDoOptions},
  cFileSearch in 'cFileSearch.pas',
  cFindInFiles in 'cFindInFiles.pas',
  dlgFindInFiles in 'dlgFindInFiles.pas' {FindInFilesDialog},
  frmFindResults in 'frmFindResults.pas' {FindResultsWindow},
  dlgFindResultsOptions in 'dlgFindResultsOptions.pas' {FindResultsOptionsDialog},
  dlgReplaceInFiles in 'dlgReplaceInFiles.pas' {ReplaceInFilesDialog},
  cParameters in 'cParameters.pas',
  uParams in 'uParams.pas',
  cTools in 'cTools.pas',
  dlgCollectionEditor in 'dlgCollectionEditor.pas' {CollectionEditor},
  dlgToolProperties in 'dlgToolProperties.pas' {ToolProperties},
  frmCommandOutput in 'frmCommandOutput.pas' {OutputWindow},
  frmFunctionList in 'frmFunctionList.pas' {FunctionListWindow},
  uCommonFunctions in 'uCommonFunctions.pas',
  StringResources in 'StringResources.pas',
  SynCompletionProposal in 'SynCompletionProposal.pas',
  frmRegExpTester in 'frmRegExpTester.pas' {RegExpTesterWindow},
  cCodeHint in 'cCodeHint.pas',
  dlgCommandLine in 'dlgCommandLine.pas' {CommandLineDlg},
  dlgUnitTestWizard in 'dlgUnitTestWizard.pas' {UnitTestWizard},
  frmUnitTests in 'frmUnitTests.pas' {UnitTestWindow},
  cFilePersist in 'cFilePersist.pas',
  dlgPickList in 'dlgPickList.pas' {PickListDialog},
  dlgAboutPyScripter in 'dlgAboutPyScripter.pas' {AboutBox},
  cPyBaseDebugger in 'cPyBaseDebugger.pas',
  cPyRemoteDebugger in 'cPyRemoteDebugger.pas',
  cFileTemplates in 'cFileTemplates.pas',
  dlgNewFile in 'dlgNewFile.pas' {NewFileDialog},
  JvDockVSNetStyle in 'JvDockVSNetStyle.pas',
  JvDockControlForm in 'JvDockControlForm.pas',
  uSearchHighlighter in 'uSearchHighlighter.pas',
  frmModSpTBXCustomize in 'frmModSpTBXCustomize.pas',
  cProjectClasses in 'cProjectClasses.pas',
  frmProjectExplorer in 'frmProjectExplorer.pas' {ProjectExplorerWindow},
  dlgImportDirectory in 'dlgImportDirectory.pas' {ImportDirectoryForm},
  dlgRunConfiguration in 'dlgRunConfiguration.pas' {RunConfigurationForm},
  dlgPyIDEBase in 'dlgPyIDEBase.pas' {PyIDEDlgBase},
  JvDockInfo in 'JvDockInfo.pas',
  JvDockSupportControl in 'JvDockSupportControl.pas',
  JvDockVIDStyle in 'JvDockVIDStyle.pas',
  cCodeCompletion in 'cCodeCompletion.pas',
  VCL.Styles.PyScripter in 'VCL.Styles.PyScripter.pas' {/  Vcl.Styles.Utils.Forms;},
  cPyScripterSettings in 'cPyScripterSettings.pas',
  cPySupportTypes in 'cPySupportTypes.pas',
  cPyControl in 'cPyControl.pas',
  JvGnugettext in 'JvGnugettext.pas',
  cInternalPython in 'cInternalPython.pas',
  dlgPythonVersions in 'dlgPythonVersions.pas' {PythonVersionsDialog},
  cSSHSupport in 'cSSHSupport.pas',
  dlgRemoteFile in 'dlgRemoteFile.pas' {RemoteFileDialog},
  cPySSHDebugger in 'cPySSHDebugger.pas',
  RtlVclFixes in 'RtlVclFixes.pas',
  JvDockAdvTree in 'JvDockAdvTree.pas',
  JvDockSupportProc in 'JvDockSupportProc.pas',
  JvDockTree in 'JvDockTree.pas',
  JvDockVSNetStyleSpTBX in 'JvDockVSNetStyleSpTBX.pas',
  frmFile in 'frmFile.pas' {FileForm},
  UConnectForm in 'SequenceDiagram\UConnectForm.pas' {FConnectForm},
  ULifeLine in 'SequenceDiagram\ULifeLine.pas',
  USequenceForm in 'SequenceDiagram\USequenceForm.pas' {FSequenceForm},
  USequencePanel in 'SequenceDiagram\USequencePanel.pas',
  ELControls in 'Formdesigner\ELControls.pas',
  ELDsgnr in 'Formdesigner\ELDsgnr.pas',
  ELEvents in 'Formdesigner\ELEvents.pas' {ELEventEditorDlg},
  ELHintWindow in 'Formdesigner\ELHintWindow.pas',
  ELImage in 'Formdesigner\ELImage.pas' {FIconEditor},
  ELPropInsp in 'Formdesigner\ELPropInsp.pas',
  ELSConsts in 'Formdesigner\ELSConsts.pas',
  ELStringsEdit in 'Formdesigner\ELStringsEdit.pas' {ELStringsEditorDlg},
  ELUtils in 'Formdesigner\ELUtils.pas',
  UConnection in 'EssModel\Components\UConnection.pas',
  UEssConnectPanel in 'EssModel\Components\UEssConnectPanel.pas',
  USugiyamaLayout in 'EssModel\Components\USugiyamaLayout.pas',
  UCodeIntegrator in 'EssModel\Integrator\Code\UCodeIntegrator.pas',
  UCodeProvider in 'EssModel\Integrator\Code\UCodeProvider.pas',
  UFileProvider in 'EssModel\Integrator\Code\UFileProvider.pas',
  UPythonIntegrator in 'EssModel\Integrator\Code\UPythonIntegrator.pas',
  UDiagramFrame in 'EssModel\Integrator\View\UDiagramFrame.pas' {AFrameDiagram: TFrame},
  UPanelTransparent in 'EssModel\Integrator\View\UPanelTransparent.pas',
  URtfdComponents in 'EssModel\Integrator\View\URtfdComponents.pas',
  URtfdDiagram in 'EssModel\Integrator\View\URtfdDiagram.pas',
  URtfdDiagramFrame in 'EssModel\Integrator\View\URtfdDiagramFrame.pas' {AFrameRtfdDiagram: TFrame},
  UViewIntegrator in 'EssModel\Integrator\View\UViewIntegrator.pas',
  UIntegrator in 'EssModel\Integrator\UIntegrator.pas',
  UDocumentation in 'EssModel\Model\UDocumentation.pas',
  UIterators in 'EssModel\Model\UIterators.pas',
  UListeners in 'EssModel\Model\UListeners.pas',
  UModel in 'EssModel\Model\UModel.pas',
  UModelEntity in 'EssModel\Model\UModelEntity.pas',
  UFeedback in 'EssModel\System\UFeedback.pas',
  UUMLForm in 'EssModel\System\UUMLForm.pas' {FUMLForm},
  UUMLModule in 'EssModel\System\UUMLModule.pas' {DMUMLModule: TDataModule},
  UAssociation in 'Main\UAssociation.pas' {FAssociation},
  UClassEditor in 'Main\UClassEditor.pas' {FClassEditor},
  UGUIDesigner in 'Main\UGUIDesigner.pas' {FGUIDesigner},
  UImages in 'Main\UImages.pas' {DMImages: TDataModule},
  ULink in 'Main\ULink.pas',
  UObjectGenerator in 'Main\UObjectGenerator.pas' {FObjectGenerator},
  UObjectInspector in 'Main\UObjectInspector.pas' {FObjectInspector},
  UOpenFolderForm in 'Main\UOpenFolderForm.pas' {FOpenFolderForm},
  UBaseTKWidgets in 'Components\UBaseTKWidgets.pas',
  UHTMLHelp in 'Utils\UHTMLHelp.pas',
  UConfiguration in 'Utils\UConfiguration.pas' {FConfiguration},
  UStyledMemo in 'Utils\UStyledMemo.pas',
  UUtils in 'Utils\UUtils.pas',
  UTKButtonBase in 'Components\TKinter\UTKButtonBase.pas',
  UTKMiscBase in 'Components\TKinter\UTKMiscBase.pas',
  UTKTextBase in 'Components\TKinter\UTKTextBase.pas',
  UTKWidgets in 'Components\TKinter\UTKWidgets.pas',
  UTTKButtonBase in 'Components\TTKinter\UTTKButtonBase.pas',
  UTTKMiscBase in 'Components\TTKinter\UTTKMiscBase.pas',
  UTTKTextBase in 'Components\TTKinter\UTTKTextBase.pas',
  UTTKWidgets in 'Components\TTKinter\UTTKWidgets.pas',
  UHashUnit in 'TextDiff\UHashUnit.pas',
  USynEditExDiff in 'TextDiff\USynEditExDiff.pas',
  UTextDiff in 'TextDiff\UTextDiff.pas' {FTextDiff},
  UStructogram in 'Structogram\UStructogram.pas' {FStructogram},
  UTypes in 'Structogram\UTypes.pas',
  ULivingObjects in 'Main\ULivingObjects.pas',
  UGenerateStructogram in 'Structogram\UGenerateStructogram.pas',
  UPythonScanner in 'EssModel\Integrator\Code\UPythonScanner.pas',
  UFileStructure in 'Main\UFileStructure.pas' {FFileStructure},
  UGit in 'Main\UGit.pas' {FGit},
  USubversion in 'Main\USubversion.pas' {FSubversion},
  JediLspClient in 'JediLspClient.pas',
  LspClient in 'LspClient.pas',
  LspUtils in 'LspUtils.pas',
  SynEditLsp in 'SynEditLsp.pas',
  cPythonSourceScanner in 'cPythonSourceScanner.pas',
  UBrowser in 'Main\UBrowser.pas' {FBrowser},
  UUpdate in 'Main\UUpdate.pas' {FUpdate},
  UDownload in 'Main\UDownload.pas' {FDownload},
  UBaseWidgets in 'Components\UBaseWidgets.pas',
  UDiff in 'TextDiff\UDiff.pas',
  UBaseQtWidgets in 'Components\UBaseQtWidgets.pas',
  UGUIForm in 'Main\UGUIForm.pas' {FGUIForm},
  UQtButtonBase in 'Components\PyQt\UQtButtonBase.pas',
  UQtFrameBased in 'Components\PyQt\UQtFrameBased.pas',
  UQtItemViews in 'Components\PyQt\UQtItemViews.pas',
  UQtScrollable in 'Components\PyQt\UQtScrollable.pas',
  UQtSpinBoxes in 'Components\PyQt\UQtSpinBoxes.pas',
  UQtWidgetDescendants in 'Components\PyQt\UQtWidgetDescendants.pas',
  dmResources in 'dmResources.pas' {ResourcesDataModule: TDataModule},
  uSysUtils in 'uSysUtils.pas',
  Vcl.Consts in 'Utils\Vcl.Consts.pas',
  cCustomShortcuts in 'cCustomShortcuts.pas',
  dlgSynEditOptions in 'dlgSynEditOptions.pas' {fmEditorOptionsDialog};

{$R *.RES}
{$R WebCopyAvi.RES}

{$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED
  or IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP
  or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
  ReportMemoryLeaksOnShutdown :=  DebugHook <> 0;

  TStyleManager.SystemHooks := TStyleManager.SystemHooks - [shMenus, shDialogs];

  Application.Initialize;
  SetDefaultUIFont(Application.DefaultFont);

  Application.MainFormOnTaskbar := True;

  if TStyleManager.TrySetStyle('Windows10 SlateGray') then
    TFConfiguration.CurrentSkinName := 'Windows10 SlateGray';

  Application.Title := 'GuiPy';
  Application.CreateForm(TResourcesDataModule, ResourcesDataModule);
  Application.CreateForm(TCommandsDataModule, CommandsDataModule);
  Application.CreateForm(TPyIDEMainForm, PyIDEMainForm);
  Application.Run;

 end.

