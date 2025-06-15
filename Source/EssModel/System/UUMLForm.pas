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
  Messages,
  Classes,
  Graphics,
  Forms,
  ToolWin,
  Controls,
  ExtCtrls,
  ComCtrls,
  Menus,
  System.ImageList,
  Vcl.ImgList,
  Vcl.BaseImageCollection,
  Vcl.VirtualImageList,
  SpTBXSkins,
  SVGIconImageCollection,
  frmFile,
  UUMLModule;

type

  TFUMLForm = class(TFileForm)
    PDiagramPanel: TPanel;
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
    TBInteractive: TToolButton;
    TBReInitialize: TToolButton;
    EmptyPopupMenu: TPopupMenu;
    PUML: TPanel;
    TVFileStructure: TTreeView;
    vilToolbarLight: TVirtualImageList;
    vilToolbarDark: TVirtualImageList;
    icUML: TSVGIconImageCollection;
    TBRecognizeAssociations: TToolButton;
    procedure FormCreate(Sender: TObject); override;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var AAction: TCloseAction); override;
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
    procedure TBInteractiveClick(Sender: TObject);
    procedure TBClassOpenClick(Sender: TObject);
    procedure TBReInitializeClick(Sender: TObject);
    procedure PDiagramPanelResize(Sender: TObject);
    procedure TBRecognizeAssociationsClick(Sender: TObject);
  private
    FLockEnter: Boolean;
    FLockRefresh: Boolean;
    FLockCreateTV: Boolean;
    FAlreadySavedAs: Boolean;
    FInteractiveLines: TStrings;
    FMainModul: TDMUMLModule;
    procedure ChangeStyle;
    procedure SetInteractiveLines(Value: TStrings);
  protected
    procedure Retranslate; override;
    function LoadFromFile(const FileName: string): Boolean; override;
    function CanCopy: Boolean; override;
    procedure CopyToClipboard; override;
    procedure SetFont(AFont: TFont); override;
    procedure SetFontSize(Delta: Integer); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
    // IJvAppStorageHandler implementation
  public
    procedure Open(const FileName: string; State: string);
    procedure Save(MitBackup: Boolean);
    procedure SetInteractive(Lines: TStrings);
    procedure ConfigureWindow(Sender: TObject);
    procedure Print; override;
    function  GetFont: TFont;
    procedure SetOptions; override;
    procedure Enter(Sender: TObject); override;
    procedure SetOnlyModified(AModified: Boolean);
    procedure CollectClasses(TSL: TStringList); override;
    procedure SaveAndReload;
    procedure OnPanelModified(AValue: Boolean);
    procedure OnInteractiveModified(Sender: TObject);
    procedure OnFormMouseDown(Sender: TObject);
    procedure AddToProject(const FileName: string);
    procedure CreateTVFileStructure;
    function GetAsStringList: TStringList; override;
    procedure ClassEdit;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure DeleteObjects;
    procedure DPIChanged; override;
    procedure OpenFolder;
    procedure OpenFiles;
    procedure AddInteractiveLine(Line: string);

    class function ToolbarCount: Integer;
    property InteractiveLines: TStrings read FInteractiveLines write SetInteractiveLines;
    property MainModul: TDMUMLModule read FMainModul;
  end;

implementation

uses
  SysUtils,
  Types,
  frmPyIDEMain,
  dmCommands,
  dmResources,
  uEditAppIntfs,
  uCommonFunctions,
  JvGnugettext,
  StringResources,
  cPyScripterSettings,
  cPySupportTypes,
  cFileTemplates,
  UModel,
  UModelEntity,
  URtfdDiagram,
  UFileStructure,
  UConfiguration,
  UUtils,
  UUMLInteractive;

{$R *.DFM}

procedure TFUMLForm.FormCreate(Sender: TObject);
begin
  inherited;
  FMainModul:= TDMUMLModule.Create(Self, PDiagramPanel);
  SetFont(GuiPyOptions.UMLFont);  // ToDo makes a RefreshDiagramm
  DefaultExtension:= 'puml';
  Modified:= False;
  MainModul.Diagram.SetOnModified(OnPanelModified);
  MainModul.Diagram.SetInteractive(OnInteractiveModified);
  MainModul.Diagram.SetFormMouseDown(OnFormMouseDown);
  // to avoid popup of PopupMenuWindow on Classes
  PDiagramPanel.PopupMenu:= EmptyPopupMenu;
  ChangeStyle;
  SetOptions;
  FLockEnter:= False;
  FLockRefresh:= False;
  FLockCreateTV:= False;
  FInteractiveLines:= TStringList.Create;
end;

procedure TFUMLForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Modified and not FAlreadySavedAs then begin
    DoSaveFile;
    FAlreadySavedAs:= True;
  end;
  FFileStructure.Clear(Self);
  FUMLInteractive.Clear;
  if MainModul.Diagram.HasObjects and PyIDEOptions.ReinitializeWhenClosing then
    TBReInitializeClick(Self);
  CanClose:= True;
end;

procedure TFUMLForm.FormClose(Sender: TObject; var AAction: TCloseAction);
begin
  inherited;
  FLockEnter:= True;
  FLockRefresh:= True;
  FLockCreateTV:= True;
  AAction:= caFree;
  for var I:= TVFileStructure.Items.Count - 1 downto 0 do
    Dispose(TVFileStructure.Items[I].Data);
end;

procedure TFUMLForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MainModul);
  FreeAndNil(FInteractiveLines);
  inherited;
end;

procedure TFUMLForm.OnFormMouseDown(Sender: TObject);
begin
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
  CreateTVFileStructure;
end;

procedure TFUMLForm.Open(const FileName: string; State: string);
begin
  LockFormUpdate(Self);
  try
    MainModul.LoadUML(FileName);
    Pathname:= FileName;
    Caption:= FileName;
    SetState(State);
    MainModul.AddToProject(FileName);
  finally
    UnlockFormUpdate(Self);
  end;
end;

function TFUMLForm.LoadFromFile(const FileName: string): Boolean;
begin
  Open(FileName, '');
  Result:= True;
end;

procedure TFUMLForm.Retranslate;
begin
  RetranslateComponent(Self);
  MainModul.Diagram.Retranslate;
end;

procedure TFUMLForm.Enter(Sender: TObject);
begin
  if FLockEnter then
    Exit;
  FLockEnter:= True;
  inherited;
  FUMLInteractive.SaveInteractiveLines;
  FUMLInteractive.Init(InteractiveLines, Self);
  if Visible then begin  // due to bug, else ActiveForm doesn't change
    if Assigned(MainModul) and Assigned(MainModul.Diagram) then begin
      var APanel:= MainModul.Diagram.GetPanel;
      if Assigned(APanel) and APanel.CanFocus then
        APanel.SetFocus;
    end;
  end;
  SaveAndReload;
  if MainModul.Diagram.HasAInvalidClass then
    PyIDEMainForm.RunFile(MyFile);
  FLockEnter:= False;
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
  (MyFile as IFileCommands).ExecClose;
end;

procedure TFUMLForm.TBShowConnectionsClick(Sender: TObject);
begin
  if Assigned(MainModul) and Assigned(MainModul.Diagram) then begin
    var Show:= (MainModul.Diagram.ShowConnections + 1) mod 3;
    MainModul.Diagram.ShowConnections:= Show;
    Modified:= True;
    MainModul.Diagram.GetPanel.Invalidate;
  end;
end;

procedure TFUMLForm.TBViewClick(Sender: TObject);
begin
  if Assigned(MainModul) and Assigned(MainModul.Diagram) then begin
    var Show:= (MainModul.Diagram.ShowView + 1) mod 3;
    MainModul.Diagram.ShowView:= Show;
    Modified:= True;
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
  Modified:= True;
end;

procedure TFUMLForm.TBDiagramFromOpenWindowsClick(Sender: TObject);
begin
  MainModul.ShowAllOpenedFiles;
  Modified:= True;
end;

procedure TFUMLForm.TBInteractiveClick(Sender: TObject);
begin
  PyIDEMainForm.actViewUMLInteractiveExecute(Self);
end;

procedure TFUMLForm.PDiagramPanelResize(Sender: TObject);
begin
  if Assigned(MainModul) then
    MainModul.Diagram.RecalcPanelSize;
end;

procedure TFUMLForm.SaveAndReload;
begin
  if FLockRefresh then
    Exit;
  FLockRefresh:= True;
  if Pathname <> '' then begin
    LockFormUpdate(Self);
    DoSave;
    MainModul.Diagram.FetchDiagram(Pathname);
    CreateTVFileStructure;
    UnlockFormUpdate(Self);
  end;
  FLockRefresh:= False;
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
  NewName:= ExtractFilePath(Pathname);
  if ResourcesDataModule.GetSaveFileName(NewName, ResourcesDataModule.SynPythonSyn, 'py')
  then begin
    FileTemplate := FileTemplates.TemplateByName(SClassTemplateName);
    if not Assigned(FileTemplate) then begin
      FileTemplates.AddClassTemplate;
      FileTemplate:= FileTemplates.TemplateByName(SClassTemplateName);
    end;
    Editor:= PyIDEMainForm.NewFileFromTemplate(FileTemplate,
      PyIDEMainForm.TabControlIndex(PyIDEMainForm.ActiveTabControl), NewName);
    (Editor as IFileCommands).ExecSave;
    PyIDEMainForm.PrepareClassEdit(Editor, 'New', Self);
    ConfigureWindow(Self);
    Modified:= True;
  end;
end;

procedure TFUMLForm.Save(MitBackup: Boolean);
begin
  MainModul.SaveUML(Pathname);
  FUMLInteractive.SynEdit.Modified:= False;
  Modified:= False;
end;

procedure TFUMLForm.Print;
begin
  MainModul.Print;
end;

procedure TFUMLForm.TBObjectDiagramClick(Sender: TObject);
begin
  if Assigned(MainModul) and Assigned(MainModul.Diagram) then begin
    var Show:= not MainModul.Diagram.ShowObjectDiagram;
    MainModul.Diagram.ShowObjectDiagram:= Show;
    Modified:= True;
    TBObjectDiagram.Down:= Show;
  end;
end;

procedure TFUMLForm.TBCommentClick(Sender: TObject);
begin
  if Assigned(MainModul) and Assigned(MainModul.Diagram) then
    MainModul.Diagram.AddCommentBoxTo(nil);
end;

procedure TFUMLForm.TBClassOpenClick(Sender: TObject);
begin
  if MainModul.Diagram.ShowObjectDiagram then begin
    MainModul.Diagram.ShowObjectDiagram:= False;
    TBObjectDiagram.Down:= False;
  end;
  PyIDEMainForm.actUMLOpenClassExecute(Self);
  Modified:= True;
end;

function TFUMLForm.CanCopy: Boolean;
begin
  Result:= True;
end;

procedure TFUMLForm.CopyToClipboard;
begin
  MainModul.CopyDiagramClipboardActionExecute(Self);
end;

procedure TFUMLForm.SetFont(AFont: TFont);
begin
  Font.Assign(AFont);
  MainModul.Diagram.SetFont(AFont);
  MainModul.RefreshDiagram;
end;

function TFUMLForm.GetFont: TFont;
begin
  Result:= MainModul.Diagram.Font;
end;

procedure TFUMLForm.SetFontSize(Delta: Integer);
begin
  if Delta <> 0 then begin
    var AFont:= GetFont;
    AFont.Size:= AFont.Size + Delta;
    if AFont.Size < 6 then AFont.Size:= 6;
    Font.Size:= AFont.Size;
    SetFont(AFont);
  end;
end;

procedure TFUMLForm.SetInteractive(Lines: TStrings);
begin
  InteractiveLines.Assign(Lines);
end;

procedure TFUMLForm.SetOptions;
begin
  FConfiguration.setToolbarVisibility(UMLToolbar, 3);
end;

procedure TFUMLForm.SetOnlyModified(AModified: Boolean);
begin
  inherited SetModified(AModified);
end;

procedure TFUMLForm.OnPanelModified(AValue: Boolean);
begin
  SetModified(AValue);
end;

procedure TFUMLForm.TBReInitializeClick(Sender: TObject);
  var Loops: Integer;
begin
  BeginUpdate;
  // inhibit erasing of object background during delete
  LockFormUpdate(Self);
  DeleteObjects;
  PyIDEMainForm.actPythonReinitializeExecute(Sender);
  Loops:= 0;
  while GI_PyControl.Running and (Loops < 20) do begin
    Sleep(50);
    Inc(Loops);
  end;
  if not GI_PyControl.Running then begin
    var TSL:= TStringList.Create(dupIgnore, True, False);
    TSL.AddStrings(MainModul.GetFiles);
    for var I:= 0 to TSL.Count - 1 do
      if FileExists(TSL[I]) then
        PyIDEMainForm.ImportModule(TSL[I]);
    MainModul.RefreshDiagram;
    FreeAndNil(TSL);
  end;
  UnlockFormUpdate(Self);
  EndUpdate;
end;

procedure TFUMLForm.AddToProject(const FileName: string);
begin
  if FileName <> '' then
    MainModul.AddToProject(FileName);
end;

procedure TFUMLForm.OnInteractiveModified(Sender: TObject);
begin
  Modified:= True;
end;

procedure TFUMLForm.CollectClasses(TSL: TStringList);
begin
  (MainModul.Diagram as TRtfdDiagram).CollectClasses;
end;

procedure TFUMLForm.CreateTVFileStructure;
  var
    Cmi, Imt: IModelIterator;
    Cent: TClassifier;
    Attribute: TAttribute;
    Method: TOperation;
    PictureNr, Indent, IndentOld: Integer;
    CName: string;
    Node: TTreeNode;
    ClassNode: TTreeNode;
    AInteger: TInteger;

  function CalculateIndentation(const Klassenname: string): Integer;
  begin
    Result:= 0;
    for var I:= 1 to Length(Klassenname) do
      if Klassenname[I] = '.' then
        Inc(Result);
  end;

begin
  if FLockCreateTV then
    Exit;
  FLockCreateTV:= True;
  Indent:= 0;
  ClassNode:= nil;
  TVFileStructure.Items.BeginUpdate;
  for var I:= TVFileStructure.Items.Count - 1 downto 0 do begin
    AInteger:= TInteger(TVFileStructure.Items[I].Data);
    FreeAndNil(AInteger);
  end;
  TVFileStructure.Items.Clear;
  Cmi:= MainModul.Model.ModelRoot.GetAllClassifiers;
  while Cmi.HasNext do begin
    Cent := TClassifier(Cmi.Next);
    if (MainModul.Model.ModelRoot.Files.IndexOf(Cent.Pathname) = -1) or
       not Cent.IsVisible or Cent.Name.EndsWith('[]') then
      Continue;

    CName:= Cent.ShortName;
    IndentOld:= Indent;
    Indent:= CalculateIndentation(CName);
    while Pos('.', CName) > 0 do
      Delete(CName, 1, Pos('.', CName));

    if Indent = 0 then
      ClassNode:= TVFileStructure.Items.AddObject(nil, CName,
        TInteger.Create(Cent.LineS))
    else if Indent > IndentOld then
      ClassNode:= TVFileStructure.Items.AddChildObject(ClassNode, CName,
        TInteger.Create(Cent.LineS))
    else begin
      while Indent < IndentOld do begin
        Dec(IndentOld);
        ClassNode:= ClassNode.Parent;
      end;
      ClassNode:= TVFileStructure.Items.AddChildObject(ClassNode, CName,
        TInteger.Create(Cent.LineS));
    end;

    ClassNode.ImageIndex:= 0;
    ClassNode.SelectedIndex:= 0;
    ClassNode.HasChildren:= True;

    Imt:= Cent.GetAttributes;
    while Imt.HasNext do begin
      Attribute:= Imt.Next as TAttribute;
      PictureNr:= 1 + Integer(Attribute.Visibility);
      Node:= TVFileStructure.Items.AddChildObject(ClassNode,
                 Attribute.ToNameTypeUML, TInteger.Create(Attribute.LineS));
      Node.ImageIndex:= PictureNr;
      Node.SelectedIndex:= PictureNr;
      Node.HasChildren:= False;
    end;
    Imt:= Cent.GetOperations;
    while Imt.HasNext do begin
      Method:= Imt.Next as TOperation;
      if Method.OperationType = otConstructor
        then PictureNr:= 4
        else PictureNr:= 5 + Integer(Method.Visibility);
      Node:= TVFileStructure.Items.AddChildObject(ClassNode, Method.ToShortStringNode, TInteger.Create(Method.LineS));
      Node.ImageIndex:= PictureNr;
      Node.SelectedIndex:= PictureNr;
      Node.HasChildren:= False;
    end;
  end;
  TVFileStructure.Items.EndUpdate;
  FFileStructure.Init(TVFileStructure.Items, Self);
  FLockCreateTV:= False;
end;

procedure TFUMLForm.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFUMLForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
    UMLToolbar.Images:= vilToolbarDark
  else
    UMLToolbar.Images:= vilToolbarLight;
  MainModul.Diagram.ChangeStyle;
end;

function TFUMLForm.GetAsStringList: TStringList;
begin
  Save(False);
  Result:= TStringList.Create;
  Result.LoadFromFile(Pathname);
end;

procedure TFUMLForm.ClassEdit;
begin
  MainModul.EditSelectedElement;
  Modified:= True;
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
  SetFontSize(Font.Size - GetFont.Size);
  MainModul.Diagram.RefreshDiagram;
end;

procedure TFUMLForm.OpenFiles;
begin
  MainModul.ShowAllOpenedFiles;
  MainModul.Diagram.ShowParameter:= 4;
  SaveAndReload;
  MainModul.Diagram.ResolveAssociations;
  MainModul.DoLayout;
  PyIDEMainForm.RunFile(MyFile);
end;

procedure TFUMLForm.OpenFolder;
begin
  if MainModul.OpenFolderActionExecute(Self) then begin
    Pathname:= PyIDEMainForm.getFilename('.puml', MainModul.OpendFolder);
    MainModul.Diagram.ShowParameter:= 4;
    SaveAndReload;
    MainModul.Diagram.ResolveAssociations;
    MainModul.DoLayout;
    PyIDEMainForm.RunFile(MyFile);
  end else
    CommandsDataModule.actFileCloseExecute(Self);
end;

procedure TFUMLForm.AddInteractiveLine(Line: string);
begin
  InteractiveLines.Add(Line);
  FUMLInteractive.Add(Line);
  Modified:= True;
end;

procedure TFUMLForm.SetInteractiveLines(Value: TStrings);
begin
  InteractiveLines.Assign(Value);
end;

class function TFUMLForm.ToolbarCount: Integer;
begin
  Result:= 14;
end;

end.

