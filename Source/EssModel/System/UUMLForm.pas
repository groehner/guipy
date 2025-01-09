{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

unit UUMLForm;

// UMLForm -> MainModul -> Diagram -> RtfdDiagram -> TessConnectPanel
//                      -> Model                  -> TAFrameDiagram
// contextmenus in UDiagramFrame

interface

uses
  Messages, Classes, Graphics, Forms, ToolWin, Controls, ExtCtrls, ComCtrls,
  Menus, System.ImageList, Vcl.ImgList,
  SpTBXDkPanels, SpTBXSkins, UUMLModule, frmFile, SynEdit, SpTBXItem, TB2Item,
  Vcl.StdCtrls, Vcl.BaseImageCollection, SVGIconImageCollection,
  Vcl.VirtualImageList;

type

  TFUMLForm = class(TFileForm)
    PDiagramPanel: TPanel;
    PDiagram: TPanel;
    UMLToolbar: TToolBar;
    TBClose: TToolButton;
    TBShowConnections: TToolButton;
    TBNewLayout: TToolButton;
    TBClassDefinition: TToolButton;
    TBObjectDiagram: TToolButton;
    TBComment: TToolButton;
    TBZoomOut: TToolButton;
    TBZoomIn: TToolButton;
    TBView: TToolButton;
    TBClassOpen: TToolButton;
    TBRefresh: TToolButton;
    PInteractive: TPanel;
    TBInteractiveToolbar: TToolBar;
    TBExecute: TToolButton;
    TBDelete: TToolButton;
    SynEdit: TSynEdit;
    TBSynEditZoomMinus: TToolButton;
    TBSynEditZoomPlus: TToolButton;
    TBInteractive: TToolButton;
    TBInteractiveClose: TToolButton;
    TBReInitialize: TToolButton;
    PMInteractive: TSpTBXPopupMenu;
    MIFont: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIDeleteAll: TSpTBXItem;
    MICopyAll: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MIDelete: TSpTBXItem;
    MICopy: TSpTBXItem;
    MIPaste: TSpTBXItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    MIClose: TSpTBXItem;
    EmptyPopupMenu: TPopupMenu;
    SpTBXSplitter1: TSpTBXSplitter;
    PUML: TPanel;
    TVFileStructure: TTreeView;
    vilToolbarLight: TVirtualImageList;
    vilToolbarDark: TVirtualImageList;
    icUML: TSVGIconImageCollection;
    vilInteractiveLight: TVirtualImageList;
    vilInteractiveDark: TVirtualImageList;
    icInteractive: TSVGIconImageCollection;
    vilPMInteractiveLight: TVirtualImageList;
    vilPMInteractiveDark: TVirtualImageList;
    icPMInteractive: TSVGIconImageCollection;
    TBRecognizeAssociations: TToolButton;
    procedure FormCreate(Sender: TObject); override;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var aAction: TCloseAction); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure SBCloseClick(Sender: TObject);
    procedure TBShowConnectionsClick(Sender: TObject);
    procedure TBNewLayoutClick(Sender: TObject);
    procedure TBDiagramFromOpenWindowsClick(Sender: TObject);
    procedure TBClassDefinitionClick(Sender: TObject);
    procedure TBRefreshClick(Sender: TObject);
    procedure TBObjectDiagramClick(Sender: TObject);
    procedure TBCommentClick(Sender: TObject);
    procedure TBZoomOutClick(Sender: TObject);
    procedure TBZoomInClick(Sender: TObject);
    procedure TBViewClick(Sender: TObject);
    procedure TBExecuteClick(Sender: TObject);
    procedure TBDeleteClick(Sender: TObject);
    procedure MIPasteClick(Sender: TObject);
    procedure MICopyClick(Sender: TObject);
    procedure MIDeleteClick(Sender: TObject);
    procedure MICopyAllClick(Sender: TObject);
    procedure MIDeleteAllClick(Sender: TObject);
    procedure MIFontClick(Sender: TObject);
    procedure TBSynEditZoomMinusClick(Sender: TObject);
    procedure TBSynEditZoomPlusClick(Sender: TObject);
    procedure MICloseClick(Sender: TObject);
    procedure TBInteractiveClick(Sender: TObject);
    procedure TBClassOpenClick(Sender: TObject);
    procedure SynEditChange(Sender: TObject);
    //procedure PDiagramPanelEnter(Sender: TObject);
    procedure TBReInitializeClick(Sender: TObject);
    procedure PUMLResize(Sender: TObject);
    procedure PDiagramPanelResize(Sender: TObject);
    procedure TBInteractiveCloseClick(Sender: TObject);
    procedure TBRecognizeAssociationsClick(Sender: TObject);
  private
    LockEnter: boolean;
    LockRefresh: boolean;
    LockCreateTV: boolean;
    FInteractiveHeight: integer;
    FInteractiveClosed: boolean;
    AlreadySavedAs: boolean;
    procedure ChangeStyle;
    procedure setInteractiveClosed(value: boolean);
    procedure setInteractiveHeight(value: integer);
  protected
    procedure Retranslate; override;
    function LoadFromFile(const FileName: string): boolean; override;
    function CanCopy: boolean; override;
    procedure CopyToClipboard; override;
    procedure SetFont(aFont: TFont); override;
    procedure SetFontSize(Delta: integer); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
    // IJvAppStorageHandler implementation
  public
    MainModul: TDMUMLModule;
    procedure Open(const Filename: string; State: string);
    procedure ConfigureWindow(Sender: TObject);
    procedure Save(MitBackup: boolean);
    procedure Print; override;
    function  GetFont: TFont;
    procedure SetOptions; override;
    procedure Enter(Sender: TObject); override;
    procedure SetOnlyModified(aModified: boolean);
    procedure CollectClasses(SL: TStringList); override;
    procedure SaveAndReload;
    procedure OnPanelModified(aValue: Boolean);
    procedure OnInteractiveModified(Sender: TObject);
    procedure AddToProject(const Filename: string);
    procedure CreateTVFileStructure;
    function getAsStringList: TStringList; override;
    procedure ClassEdit;
    procedure OnFormMouseDown(Sender: TObject);
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure DeleteObjects;
    procedure DPIChanged; override;
    procedure OpenFolder;
    procedure OpenFiles;
    class function ToolbarCount: integer;

    property InteractiveHeight: integer read FInteractiveHeight write setInteractiveHeight;
    property InteractiveClosed: boolean read FInteractiveClosed write setInteractiveClosed;
  end;

implementation

uses Windows, SysUtils, Types, IniFiles, Math, Clipbrd, Dialogs,
     frmPyIDEMain, dmResources, uEditAppIntfs, uCommonFunctions,
     JvGnugettext, StringResources, cPyScripterSettings, UFileStructure,
     UConfiguration, UUtils, UModelEntity, UModel, URtfdDiagram, UViewIntegrator,
     cPyControl, cFileTemplates, dmCommands;

{$R *.DFM}

procedure TFUMLForm.FormCreate(Sender: TObject);
begin
  inherited;
  MainModul:= TDMUMLModule.Create(Self, PDiagramPanel);
  SetFont(GuiPyOptions.UMLFont);  // ToDo makes a RefreshDiagramm
  DefaultExtension:= 'puml';
  Modified:= false;
  FInteractiveClosed:= true;
  MainModul.Diagram.SetOnModified(OnPanelModified);
  MainModul.Diagram.SetInteractive(OnInteractiveModified);
  MainModul.Diagram.SetFormMouseDown(OnFormMouseDown);
  // to avoid popup of PopupMenuWindow on Classes
  PDiagramPanel.PopupMenu:= EmptyPopupMenu;
  SynEdit.PopupMenu:= PMInteractive;
  SynEdit.Font.Assign(EditorOptions.Font);
  ChangeStyle;
  SetOptions;
  LockEnter:= false;
  LockRefresh:= false;
  LockCreateTV:= false;
end;

procedure TFUMLForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Modified and not AlreadySavedAs then begin
    DoSaveFile;
    AlreadySavedAs:= true;
  end;
  FFileStructure.Clear(Self);
  if MainModul.Diagram.hasObjects and PyIDEOptions.ReinitializeWhenClosing then
    TBReInitializeClick(Self);
  CanClose:= true;
end;

procedure TFUMLForm.FormClose(Sender: TObject; var aAction: TCloseAction);
begin
  inherited;
  LockEnter:= true;
  LockRefresh:= true;
  LockCreateTV:= true;
  aAction:= caFree;
  for var i:= TVFileStructure.Items.Count - 1 downto 0 do
    FreeAndNil(TVFileStructure.Items[i].Data);
end;

procedure TFUMLForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MainModul);
  inherited;
end;

procedure TFUMLForm.OnFormMouseDown(Sender: TObject);
begin
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
  CreateTVFileStructure;
end;

procedure TFUMLForm.Open(const Filename: string; State: string);
begin
  LockFormUpdate(Self);
  try
    MainModul.LoadUML(Filename);
    Pathname:= Filename;
    Caption:= Filename;
    SetState(State);
    MainModul.AddToProject(Filename);
  finally
    UnlockFormUpdate(Self);
  end;
end;

function TFUMLForm.LoadFromFile(const FileName: string): boolean;
begin
  Open(Filename, '');
  Result:= true;
end;

procedure TFUMLForm.MICloseClick(Sender: TObject);
begin
  TBInteractiveClick(Self);
end;

procedure TFUMLForm.MICopyAllClick(Sender: TObject);
begin
  Clipboard.AsText:= SynEdit.Text;
end;

procedure TFUMLForm.MICopyClick(Sender: TObject);
begin
  Clipboard.AsText:= SynEdit.SelText;
end;

procedure TFUMLForm.MIDeleteAllClick(Sender: TObject);
begin
  SynEdit.Clear;
end;

procedure TFUMLForm.MIDeleteClick(Sender: TObject);
begin
  SynEdit.DeleteSelections;
end;

procedure TFUMLForm.MIFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(SynEdit.Font);
  if ResourcesDataModule.dlgFontDialog.Execute then
    SynEdit.Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
end;

procedure TFUMLForm.MIPasteClick(Sender: TObject);
begin
  SynEdit.PasteFromClipboard;
end;

procedure TFUMLForm.Retranslate;
begin
  RetranslateComponent(Self);
  MainModul.Diagram.Retranslate;
end;

procedure TFUMLForm.Enter(Sender: TObject);
  var aPanel: TCustomPanel;
begin
  if LockEnter then exit;
  LockEnter:= true;
  inherited;
  if Visible then begin  // due to bug, else ActiveForm doesn't change
    if assigned(MainModul) and assigned(MainModul.Diagram) then begin
      aPanel:= MainModul.Diagram.GetPanel;
      if assigned(aPanel) and aPanel.CanFocus then
        aPanel.SetFocus;
    end;
  end;
  SaveAndReload;
  if MainModul.Diagram.HasAInvalidClass then
    PyIDEMainForm.RunFile(fFile);
  LockEnter:= false;
end;

procedure TFUMLForm.ConfigureWindow(Sender: TObject);
begin
  Align:= alClient;
  MainModul.Diagram.ShowIcons:= GuiPyOptions.DiShowIcons;
  MainModul.Diagram.VisibilityFilter:= TVisibility(0);
  MainModul.Diagram.ShowParameter:= GuiPyOptions.DiShowParameter;
  MainModul.Diagram.SortOrder:= GuiPyOptions.DiSortOrder;
end;

procedure TFUMLForm.SBCloseClick(Sender: TObject);
begin
  (fFile as IFileCommands).ExecClose;
end;

procedure TFUMLForm.TBShowConnectionsClick(Sender: TObject);
begin
  if assigned(MainModul) and assigned(MainModul.Diagram) then begin
    var sa:= (Mainmodul.Diagram.ShowConnections + 1) mod 3;
    MainModul.Diagram.ShowConnections:= sa;
    Modified:= true;
    MainModul.Diagram.GetPanel.Invalidate;
  end;
end;

procedure TFUMLForm.TBSynEditZoomMinusClick(Sender: TObject);
begin
  SynEdit.Font.Size:= max(SynEdit.Font.Size -1, 6);
end;

procedure TFUMLForm.TBSynEditZoomPlusClick(Sender: TObject);
begin
  SynEdit.Font.Size:= SynEdit.Font.Size + 1;
end;

procedure TFUMLForm.TBViewClick(Sender: TObject);
begin
  if assigned(MainModul) and assigned(MainModul.Diagram) then begin
    var sv:= (Mainmodul.Diagram.ShowView + 1) mod 3;
    MainModul.Diagram.ShowView:= sv;
    Modified:= true;
    MainModul.Diagram.GetPanel.Invalidate;
  end;
end;

procedure TFUMLForm.TBZoomInClick(Sender: TObject);
begin
  SetFontSize(+1);
end;

procedure TFUMLForm.TBZoomOutClick(Sender: TObject);
begin
  SetFontSize(-1);
end;

procedure TFUMLForm.TBNewLayoutClick(Sender: TObject);
begin
  MainModul.DoLayout;
  Modified:= true;
end;

procedure TFUMLForm.TBDeleteClick(Sender: TObject);
begin
  if SynEdit.SelAvail
    then SynEdit.DeleteSelections
    else SynEdit.Clear;
end;

procedure TFUMLForm.TBDiagramFromOpenWindowsClick(Sender: TObject);
begin
  MainModul.ShowAllOpenedFiles;
  Modified:= true;
end;

procedure TFUMLForm.TBExecuteClick(Sender: TObject);
  var Text: string; SL: TStringList;
begin
  if SynEdit.SelAvail
    then Text:= SynEdit.SelText
    else Text:= SynEdit.LineText;
  SynEdit.SelStart:= SynEdit.SelEnd;
  if Text = '' then Exit;
  Text:= StringReplace(Text, #9,
     StringOfChar(' ', SynEdit.TabWidth), [rfReplaceAll]);
  Text:= Dedent(Text);
  CollectClasses(nil);
  TBExecute.Enabled:= false;
  Screen.Cursor:= crHourglass;
  SL := TStringList.Create;
  try
    MainModul.Diagram.ExecutePython(Text);
    if GuiPyOptions.ShowAllNewObjects then
      MainModul.Diagram.ShowAllNewObjects(Self);
    MainModul.Diagram.ShowAll;
  finally
    SL.Free;
    Screen.Cursor:= crDefault;
    TBExecute.Enabled:= true;
  end;
end;

procedure TFUMLForm.TBInteractiveClick(Sender: TObject);
begin
  FInteractiveClosed:= not FInteractiveClosed;
  PUMLResize(Self);
end;

procedure TFUMLForm.TBInteractiveCloseClick(Sender: TObject);
begin
  FInteractiveClosed:= true;
  PUMLResize(Self);
end;

procedure TFUMLForm.PUMLResize(Sender: TObject);
begin
  Modified:= true;
  FInteractiveHeight:= max(FInteractiveHeight, 100);
  if FInteractiveClosed
    then PDiagram.Height:= ClientHeight - 4
    else PDiagram.Height:= ClientHeight - 4 - FInteractiveHeight;
end;

procedure TFUMLForm.setInteractiveClosed(value: boolean);
begin
  FInteractiveClosed:= value;
  if FInteractiveClosed
    then TBInteractiveCloseClick(self)
    else PUMLResize(Self);
end;

procedure TFUMLForm.setInteractiveHeight(value: integer);
begin
  if FInteractiveHeight <> value then begin
    FInteractiveHeight:= value;
    PUMLResize(self);
  end;
end;

procedure TFUMLForm.PDiagramPanelResize(Sender: TObject);
begin
  if Assigned(MainModul) then
    MainModul.Diagram.RecalcPanelSize;
  FInteractiveHeight:= ClientHeight - 4 - PDiagram.Height;
end;

procedure TFUMLForm.SaveAndReload;
begin
  if LockRefresh then exit;
  LockRefresh:= true;
  if Pathname <> '' then begin
    LockFormUpdate(Self);
    DoSave;
    MainModul.Diagram.FetchDiagram(Pathname);
    MainModul.Diagram.ShowAll;
    CreateTVFileStructure;
    UnLockFormUpdate(Self);
  end;
  LockRefresh:= false;
end;

procedure TFUMLForm.TBRecognizeAssociationsClick(Sender: TObject);
begin
  MainModul.Diagram.ResolveAssociations;
end;

procedure TFUMLForm.TBRefreshClick(Sender: TObject);
begin
  SaveAndReload;
end;

procedure TFUMLForm.TBClassDefinitionClick(Sender: TObject);
  var NewName: string; Editor: IEditor;
      FileTemplate : TFileTemplate;
begin
  NewName:= ExtractFilepath(Pathname);
  if ResourcesDataModule.GetSaveFileName(NewName, ResourcesDataModule.SynPythonSyn, 'py')
  then begin
    FileTemplate := FileTemplates.TemplateByName(SClassTemplateName);
    if FileTemplate = nil then begin
      FileTemplates.AddClassTemplate;
      FileTemplate:= FileTemplates.TemplateByName(SClassTemplateName);
    end;
    Editor:= PyIDEMainForm.NewFileFromTemplate(FileTemplate,
      PyIDEMainForm.TabControlIndex(PyIDEMainForm.ActiveTabControl), NewName);
    (Editor as IFileCommands).ExecSave;
    PyIDEMainForm.PrepareClassEdit(Editor, 'New', Self);
    ConfigureWindow(Self);
    Modified:= true;
  end;
end;

procedure TFUMLForm.Save(MitBackup: boolean);
begin
  MainModul.SaveUML(Pathname);
  SynEdit.Modified:= false;
  Modified:= false;
end;

procedure TFUMLForm.Print;
begin
  MainModul.Print;
end;

procedure TFUMLForm.TBObjectDiagramClick(Sender: TObject);
begin
  if assigned(MainModul) and assigned(MainModul.Diagram) then begin
    var b:= not Mainmodul.Diagram.ShowObjectDiagram;
    Mainmodul.Diagram.ShowObjectDiagram:= b;
    Modified:= true;
    TBObjectDiagram.Down:= b;
  end;
end;

procedure TFUMLForm.TBCommentClick(Sender: TObject);
begin
  if assigned(MainModul) and assigned(MainModul.Diagram) then
    Mainmodul.Diagram.AddCommentBoxTo(nil);
end;

procedure TFUMLForm.TBClassOpenClick(Sender: TObject);
begin
  if Mainmodul.Diagram.ShowObjectDiagram then begin
    Mainmodul.Diagram.ShowObjectDiagram:= false;
    TBObjectDiagram.Down:= false;
  end;
  PyIDEMainForm.actUMLOpenClassExecute(Self);
  Modified:= true;
end;

function TFUMLForm.CanCopy: boolean;
begin
  Result:= true;
end;

procedure TFUMLForm.CopyToClipboard;
begin
  MainModul.CopyDiagramClipboardActionExecute(Self);
end;

procedure TFUMLForm.SetFont(aFont: TFont);
begin
  Font.Assign(aFont);
  MainModul.Diagram.SetFont(aFont);
  MainModul.RefreshDiagram;
end;

function TFUMLForm.GetFont: TFont;
begin
  Result:= MainModul.Diagram.Font;
end;

procedure TFUMLForm.SetFontSize(Delta: integer);
begin
  if Delta <> 0 then begin
    var aFont:= GetFont;
    aFont.Size:= aFont.Size + Delta;
    if aFont.Size < 6 then aFont.Size:= 6;
    Font.Size:= aFont.Size;
    SetFont(aFont);
  end;
end;

procedure TFUMLForm.SetOptions;
begin
  FConfiguration.setToolbarVisibility(UMLToolbar, 3);
end;

procedure TFUMLForm.SetOnlyModified(aModified: boolean);
begin
  inherited SetModified(aModified);
end;

procedure TFUMLForm.OnPanelModified(aValue: Boolean);
begin
  setModified(aValue);
end;

procedure TFUMLForm.TBReInitializeClick(Sender: TObject);
  var i, Loops: integer;
begin
  BeginUpdate;
  // inhibit erasing of object background during delete
  LockFormUpdate(Self);
  DeleteObjects;
  pyIDEMainform.actPythonReinitializeExecute(Sender);
  Loops:= 0;
  while GI_PyControl.Running and (Loops < 20) do begin
    sleep(50);
    inc(Loops);
  end;
  if not GI_PyControl.Running then begin
    var SL:= TStringList.Create(dupIgnore, true, false);
    SL.AddStrings(MainModul.getFiles);
    for i:= 0 to SL.Count - 1 do
      if FileExists(SL[i]) then
        pyIDEMainform.ImportModule(SL[i]);
    MainModul.RefreshDiagram;
    FreeAndNil(SL);
  end;
  UnLockFormUpdate(Self);
  EndUpdate;
end;

procedure TFUMLForm.AddToProject(const Filename: string);
begin
  if Filename <> '' then
    MainModul.AddToProject(Filename);
end;

procedure TFUMLForm.OnInteractiveModified(Sender: TObject);
begin
  Modified:= true;
end;

procedure TFUMLForm.CollectClasses(SL: TStringList);
begin
  (MainModul.Diagram as TRtfdDiagram).CollectClasses;
end;

procedure TFUMLForm.CreateTVFileStructure;
  var
    Ci, it: IModelIterator;
    cent: TClassifier;
    Attribute: TAttribute;
    Method: TOperation;
    PictureNr, i, Indent, IndentOld: Integer;
    CName: string;
    Node: TTreeNode;
    ClassNode: TTreeNode;
    aInteger: TInteger;

  function CalculateIndentation(const Klassenname: string): integer;
  begin
    Result:= 0;
    for var i:= 1 to length(Klassenname) do
      if Klassenname[i] = '.' then inc(Result);
  end;

begin
  if LockCreateTV then exit;
  LockCreateTV:= true;
  Indent:= 0;
  Classnode:= nil;
  TVFileStructure.Items.BeginUpdate;
  for i:= TVFileStructure.Items.Count - 1 downto 0 do begin
    aInteger:= TInteger(TVFileStructure.Items[i].Data);
    FreeAndNil(aInteger);
  end;
  TVFileStructure.Items.Clear;
  Ci:= MainModul.Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent := TClassifier(Ci.Next);
    if (MainModul.Model.ModelRoot.Files.Indexof(Cent.Pathname) = -1) or
       not Cent.IsVisible or Cent.Name.EndsWith('[]') then
      continue;

    CName:= cent.ShortName;
    IndentOld:= Indent;
    Indent:= CalculateIndentation(CName);
    while Pos('.', CName) > 0 do
      delete(CName, 1, Pos('.', CName));

    if Indent = 0 then
      ClassNode:= TVFileStructure.Items.AddObject(nil, CName, TInteger.create(cent.LineS))
    else if Indent > IndentOld then
      ClassNode:= TVFileStructure.Items.AddChildObject(ClassNode, CName, TInteger.create(cent.LineS))
    else begin
      while Indent < IndentOld do begin
        dec(IndentOld);
        ClassNode:= ClassNode.Parent;
      end;
      ClassNode:= TVFileStructure.Items.AddChildObject(ClassNode, CName, TInteger.create(cent.LineS));
    end;

    ClassNode.ImageIndex:= 0;
    ClassNode.SelectedIndex:= 0;
    ClassNode.HasChildren:= true;

    it:= cent.GetAttributes;
    while It.HasNext do begin
      Attribute:= It.Next as TAttribute;
      PictureNr:= 1 + Integer(Attribute.Visibility);
      Node:= TVFileStructure.Items.AddChildObject(ClassNode,
                 Attribute.toNameTypeUML, TInteger.create(Attribute.LineS));
      Node.ImageIndex:= PictureNr;
      Node.SelectedIndex:= PictureNr;
      Node.HasChildren:= false;
    end;
    It:= cent.GetOperations;
    while It.HasNext do begin
      Method:= It.Next as TOperation;
      if Method.OperationType = otConstructor
        then PictureNr:= 4
        else PictureNr:= 5 + Integer(Method.Visibility);
      Node:= TVFileStructure.Items.AddChildObject(ClassNode, Method.toShortStringNode, TInteger.create(Method.LineS));
      Node.ImageIndex:= PictureNr;
      Node.SelectedIndex:= PictureNr;
      Node.HasChildren:= false;
    end;
  end;
  TVFileStructure.Items.EndUpdate;
  FFileStructure.init(TVFileStructure.Items, Self);
  LockCreateTV:= false;
end;

procedure TFUMLForm.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFUMLForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    UMLToolbar.Images:= vilToolbarDark;
    TBInteractiveToolbar.Images:= vilInteractiveDark;
    PMInteractive.Images:= vilPMInteractiveDark;
  end else begin
    UMLToolbar.Images:= vilToolbarLight;
    TBInteractiveToolbar.Images:= vilInteractiveLight;
    PMInteractive.Images:= vilPMInteractiveLight;
  end;
  SynEdit.Highlighter:= ResourcesDataModule.Highlighters.HighlighterFromFileExt('py');
  MainModul.Diagram.ChangeStyle;
end;

function TFUMLForm.getAsStringList: TStringList;
begin
  Save(false);
  Result:= TStringList.Create;
  Result.LoadFromFile(Pathname);
end;

procedure TFUMLForm.SynEditChange(Sender: TObject);
begin
  Modified:= true;
end;

procedure TFUMLForm.ClassEdit;
begin
  MainModul.EditSelectedElement;
  Modified:= true;
end;

procedure TFUMLForm.BeginUpdate;
begin
  (MainModul.Diagram as TRtfdDiagram).Panel.BeginUpdate;
end;

procedure TFUMLForm.EndUpdate;
begin
  (MainModul.Diagram as TRtfdDiagram).Panel.EndUpdate;
end;

procedure TFUMLForm.DeleteObjects;
begin
  (MainModul.Diagram as TRtfdDiagram).DeleteObjects;
end;

procedure TFUMLForm.DPIChanged;
begin
  setFontSize(Font.Size - GetFont.Size);
  MainModul.Diagram.RefreshDiagram;
end;

procedure TFUMLForm.OpenFiles;
begin
  MainModul.ShowAllOpenedFiles;
  MainModul.Diagram.ShowParameter:= 4;
  SaveAndReload;
  MainModul.Diagram.ResolveAssociations;
  MainModul.DoLayout;
  PyIDEMainForm.RunFile(fFile);
end;

procedure TFUMLForm.OpenFolder;
begin
  if MainModul.OpenFolderActionExecute(Self) then begin
    Pathname:= PyIDEMainForm.getFilename('.puml', MainModul.OpendFolder);
    MainModul.Diagram.ShowParameter:= 4;
    SaveAndReload;
    MainModul.Diagram.ResolveAssociations;
    MainModul.DoLayout;
    PyIDEMainForm.RunFile(fFile);
  end else
    CommandsDataModule.actFileCloseExecute(Self);
end;

class function TFUMLForm.ToolbarCount: integer;
begin
  Result:= 14;
end;

end.

