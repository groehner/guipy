{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde
  Gerhard Röhner

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

unit UDiagramFrame;

interface

uses
  Messages, Classes, Controls, Forms,
  Vcl.ImgList, System.ImageList,
  uViewIntegrator, uListeners, uModelEntity, uModel, SpTBXItem, TB2Item,
  Vcl.Menus;

const
  WM_ChangePackage = WM_USER + 1;

type

  // permanent menu items have Tag=1

  TAFrameDiagram = class(TFrame, IBeforeObjectModelListener, IAfterObjectModelListener)

    ILUMLLight: TImageList;
    ILUMLDark: TImageList;
    ILAssoziationenLight: TImageList;
    ILAssoziationenDark: TImageList;
    ILAlign: TImageList;
    PopupMenuAlign: TSpTBXPopupMenu;
    MIPopupBottom: TSpTBXItem;
    MIPopupMiddle: TSpTBXItem;
    MIPopupTop: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIPopupRight: TSpTBXItem;
    MIPopupCentered: TSpTBXItem;
    MIPopupLeft: TSpTBXItem;
    PopMenuConnection: TSpTBXPopupMenu;
    MIConnectionDelete: TSpTBXItem;
    MIConnectionTurn: TSpTBXItem;
    MIConnectionEdit: TSpTBXItem;
    MIConnectionRecursiv: TSpTBXSubmenuItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MIConnectionInstanceOf: TSpTBXItem;
    MIConnectionInheritance: TSpTBXItem;
    MIConnectionCompositionArrow: TSpTBXItem;
    MIConnectionComposition: TSpTBXItem;
    MIConnectionAggregationArrow: TSpTBXItem;
    MIConnectionAggregation: TSpTBXItem;
    MIConnectionAssociationBidirectional: TSpTBXItem;
    MIConnectionAssociationArrow: TSpTBXItem;
    MIConnectionAssociation: TSpTBXItem;
    MIConnectionBottomRight: TSpTBXItem;
    MIConnectionBottomLeft: TSpTBXItem;
    MIConnectionTopLeft: TSpTBXItem;
    MIConnectionTopRight: TSpTBXItem;
    PopupMenuComment: TSpTBXPopupMenu;
    PopupMenuCommentDelete: TSpTBXItem;
    PopupMenuWindow: TSpTBXPopupMenu;
    MIWindowPopupConfiguration: TSpTBXItem;
    MIWindowPopupVisibility: TSpTBXSubmenuItem;
    MIWindowPopupParameter: TSpTBXSubmenuItem;
    MIWindowPopupDisplay: TSpTBXSubmenuItem;
    MIWindowPopupRefresh: TSpTBXItem;
    MIWindowPopupNewLayout: TSpTBXItem;
    MIWindowPopupNewComment: TSpTBXItem;
    MIWindowPopupOpenClass: TSpTBXItem;
    MIWindowPopupNewClass: TSpTBXItem;
    MIWindowPopupDisplay3: TSpTBXItem;
    MIWindowPopupDisplay2: TSpTBXItem;
    MIWindowPopupDisplay1: TSpTBXItem;
    MIWindowPopupDisplay0: TSpTBXItem;
    MIWindowPopupParameterDisplay5: TSpTBXItem;
    MIWindowPopupParameterDisplay4: TSpTBXItem;
    MIWindowPopupParameterDisplay3: TSpTBXItem;
    MIWindowPopupParameterDisplay2: TSpTBXItem;
    MIWindowPopupParameterDisplay1: TSpTBXItem;
    MIWindowPopupParameterDisplay0: TSpTBXItem;
    MIWindowPopupVisibilityIcon: TSpTBXItem;
    MIWindowPopupVisibilityText: TSpTBXItem;
    MIWindowPopupVisibilityNone: TSpTBXItem;
    PopMenuObject: TSpTBXPopupMenu;
    MIObjectPopupCopyAsPicture: TSpTBXItem;
    MIObjectPopupDelete: TSpTBXItem;
    MIObjectPopupVisibility: TSpTBXSubmenuItem;
    MIObjectPopupDisplay: TSpTBXSubmenuItem;
    MIObjectPopupHideInherited: TSpTBXItem;
    MIObjectPopupShowInherited: TSpTBXItem;
    MIObjectPopupShowAllNewObjects: TSpTBXItem;
    MIObjectPopupEdit: TSpTBXItem;
    MIObjectPopupDisplay3: TSpTBXItem;
    MIObjectPopupDisplay2: TSpTBXItem;
    MIObjectPopupDisplay1: TSpTBXItem;
    MIObjectPopupDisplay0: TSpTBXItem;
    MIObjectPopupVisibilityIcon: TSpTBXItem;
    MIObjectPopupVisibilityText: TSpTBXItem;
    MIObjectPopupVisibilityNone: TSpTBXItem;
    MIObjectPopupShowNewObject: TSpTBXSubmenuItem;

    PopMenuClass: TSpTBXPopupMenu;
    MIClassPopupCreateTestClass: TSpTBXItem;
    MIClassPopupDelete: TSpTBXItem;
    MIClassPopupVisibility: TSpTBXSubmenuItem;
    MIClassPopupParameter: TSpTBXSubmenuItem;
    MIClassPopupDisplay: TSpTBXSubmenuItem;
    N1: TSpTBXSeparatorItem;
    MIClassPopupHideInherited: TSpTBXItem;
    MIClassPopupShowInherited: TSpTBXItem;
    MIClassPopupNewComment: TSpTBXItem;
    MIClassPopupSelectAssociation: TSpTBXItem;
    MIClassPopupOpenSource: TSpTBXItem;
    MIClassPopupRun: TSpTBXItem;
    MIClassPopupClassEdit: TSpTBXItem;
    NEndOfJUnitTest: TSpTBXSeparatorItem;
    MIClassPopupRunOneTest: TSpTBXItem;
    MIClassPopupRunAllTests: TSpTBXItem;
    MIClassPopupConnect: TSpTBXSubmenuItem;
    MIClassPopupOpenClass: TSpTBXSubmenuItem;
    MIClassPopupDisplay3: TSpTBXItem;
    MIClassPopupDisplay2: TSpTBXItem;
    MIClassPopupDisplay1: TSpTBXItem;
    MIClassPopupDisplay0: TSpTBXItem;
    MIClassPopupParameterDisplay6: TSpTBXItem;
    MIClassPopupParameterDisplay5: TSpTBXItem;
    MIClassPopupParameterDisplay3: TSpTBXItem;
    MIClassPopupParameterDisplay2: TSpTBXItem;
    MIClassPopupParameterDisplay1: TSpTBXItem;
    MIClassPopupParameterDisplay0: TSpTBXItem;
    MIClassPopupVisibilityIcon: TSpTBXItem;
    MIClassPopupVisibilityText: TSpTBXItem;
    MIClassPopupVisibilityNone: TSpTBXItem;
    MIClassPopupCopyAsPicture: TSpTBXItem;
    MIClassPopupParameterDisplay4: TSpTBXItem;
    MIWindowPopupCopyAsPicture: TSpTBXItem;
    MIWindowPopupFont: TSpTBXItem;

    procedure PopMenuClassPopup(Sender: TObject);
      procedure MIClassPopupClassEditClick(Sender: TObject);
      procedure MIClassPopupOpenSourceClick(Sender: TObject);
      procedure MIClassPopupDeleteClick(Sender: TObject);
      procedure MIClassPopupCopyAsPictureClick(Sender: TObject);
      procedure MIClassPopupSelectAssociationClick(Sender: TObject);
      procedure MIClassPopupRunClick(Sender: TObject);
      procedure MIClassPopupShowInheritedClick(Sender: TObject);
      procedure MIClassPopupHideInheritedClick(Sender: TObject);
      procedure MIClassPopupNewCommentClick(Sender: TObject);
      procedure MIClassPopupParameterDisplayClick(Sender: TObject);
      procedure MIClassPopupVisibilityClick(Sender: TObject);

    procedure PopMenuObjectPopup(Sender: TObject);
      procedure MIObjectPopupEditClick(Sender: TObject);
      procedure MIObjectPopupShowAllNewObjectsClick(Sender: TObject);
      procedure MIObjectPopUpShowUnnamedClick(Sender: TObject);
      procedure MIObjectPopupHideInheritedClick(Sender: TObject);
      procedure MIObjectPopupShowInheritedClick(Sender: TObject);

    procedure PopMenuConnectionPopup(Sender: TObject);
      procedure MIConnectionClick(Sender: TObject);
      procedure MISetRecursiv(Sender: TObject);
    procedure MIPopupAlignClick(Sender: TObject);

    {
    procedure MIAttributesMethodsPrivateClick(Sender: TObject);
    procedure MIAttributesMethodsPackageClick(Sender: TObject);
    procedure MIAttributesMethodsProtectedClick(Sender: TObject);
    procedure MIAttributesMethodsPublicClick(Sender: TObject);
    procedure MIAttributesMethodsNoneClick(Sender: TObject);
    }
    procedure MIWindowPopupOpenClassClick(Sender: TObject);
    procedure MIWindowPopupNewClassClick(Sender: TObject);
    procedure MIWindowPopupNewCommentClick(Sender: TObject);
    procedure MIWindowPopupRefreshClick(Sender: TObject);
    procedure MIWindowPopupNewLayoutClick(Sender: TObject);
    procedure MIWindowPopupVisibilityClick(Sender: TObject);
    procedure MIWindowPopupParameterDisplayClick(Sender: TObject);
    procedure MIClassPopupCreateTestClassClick(Sender: TObject);
    procedure MIClassPopupRunAllTestsClick(Sender: TObject);
    procedure MIClassPopupDisplayClick(Sender: TObject);
    procedure MIWindowPopupDisplayClick(Sender: TObject);
    procedure MIObjectPopupVisibilityClick(Sender: TObject);
    procedure MIObjectPopupDisplayClick(Sender: TObject);
    procedure MIWindowPopupConfigurationClick(Sender: TObject);
    procedure PopupMenuWindowPopup(Sender: TObject);
    procedure PopupMenuCommentDeleteClick(Sender: TObject);
    procedure MIWindowPopupCopyAsPictureClick(Sender: TObject);
    procedure MIWindowPopupFontClick(Sender: TObject);
  private
    procedure ModelBeforeChange(Sender: TModelEntity);
    procedure ModelAfterChange(Sender: TModelEntity);
    procedure IBeforeObjectModelListener.Change = ModelBeforeChange;
    procedure IAfterObjectModelListener.Change = ModelAfterChange;
  public
    Diagram : TDiagramIntegrator;
    Model : TObjectModel;
    ScrollBox : TScrollBox;
    constructor Create(AOwner: TComponent; aModel: TObjectModel); reintroduce;
    destructor Destroy; override;
    procedure OnUpdateToolbar(Sender : TObject);
    procedure Retranslate;
    function getPopMenuClass: TControl;
    function getPopMenuObject: TControl;
  end;

implementation

uses JvGnugettext, uUtils, UConfiguration;

{$R *.DFM}

type
  TScrollBoxWithNotify = class(TScrollBox)
  protected
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TScrollBoxWithNotify }

constructor TScrollBoxWithNotify.Create(AOwner: TComponent);
begin
  inherited;
  HorzScrollBar.Smooth := True;
  HorzScrollBar.Tracking := True;
  VertScrollBar.Smooth := True;
  VertScrollBar.Tracking := True;
  Align := alClient;
  //Anchors:= [alLeft, alTop];
  AutoScroll:= true;
end;

procedure TScrollBoxWithNotify.WMHScroll(var Message: TWMHScroll);
begin
  inherited;
  if (Message.ScrollBar = 0) and (HorzScrollBar.Visible) and Assigned(OnResize) then
    OnResize(nil);
end;

procedure TScrollBoxWithNotify.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  if (Message.ScrollBar = 0) and (VertScrollBar.Visible) and Assigned(OnResize) then
    OnResize(nil);
end;

{ TDiagramFrame }

constructor TAFrameDiagram.Create(AOwner: TComponent; aModel: TObjectModel);
begin
  inherited Create(AOwner);
  //Translate; //
  TranslateComponent(Self);
  Self.Model:= aModel;
  Self.Model.AddListener(IAfterObjectModelListener(Self));  // without self
  ScrollBox:= TScrollBoxWithNotify.Create(Self);
  ScrollBox.Parent:= Self;
end;

destructor TAFrameDiagram.Destroy;
begin
  // responsible for SIGSEGV exception
  // if Assigned(Model) then
  //Model.RemoveListener(IAfterObjectModelListener(Self));
  inherited;
end;


procedure TAFrameDiagram.OnUpdateToolbar(Sender: TObject);
begin
end;

procedure TAFrameDiagram.ModelBeforeChange(Sender: TModelEntity);
begin
  uViewIntegrator.SetCurrentEntity(nil);
end;

procedure TAFrameDiagram.ModelAfterChange(Sender: TModelEntity);
begin
end;

procedure TAFrameDiagram.Retranslate;
begin
  RetranslateComponent(Self);
end;

procedure TAFrameDiagram.PopMenuClassPopup(Sender: TObject);
begin
  Diagram.PopMenuClassPopup(Sender);
end;

procedure TAFrameDiagram.PopMenuConnectionPopup(Sender: TObject);
begin
  Diagram.PopMenuConnectionPopup(Sender);
end;

procedure TAFrameDiagram.MIClassPopupRunClick(Sender: TObject);
begin
  Diagram.Run(getPopMenuClass);
end;

{procedure TAFrameDiagram.MIAttributesMethodsPrivateClick(Sender: TObject);
begin
  Diagram.VisibilityFilter:= TVisibility(0);
  GuiPyOptions.DiVisibilityFilter:= 0;
end;

procedure TAFrameDiagram.MIAttributesMethodsPackageClick(Sender: TObject);
begin
  Diagram.VisibilityFilter:= TVisibility(1);
  GuiPyOptions.DiVisibilityFilter:= 1;
end;

procedure TAFrameDiagram.MIAttributesMethodsProtectedClick(Sender: TObject);
begin
  Diagram.VisibilityFilter:= TVisibility(2);
  GuiPyOptions.DiVisibilityFilter:= 2;
end;

procedure TAFrameDiagram.MIAttributesMethodsPublicClick(Sender: TObject);
begin
  Diagram.VisibilityFilter:= TVisibility(3);
  GuiPyOptions.DiVisibilityFilter:= 3;
end;

procedure TAFrameDiagram.MIAttributesMethodsNoneClick(Sender: TObject);
begin
  Diagram.VisibilityFilter:= TVisibility(4);
  GuiPyOptions.DiVisibilityFilter:= 4;
end;
}

procedure TAFrameDiagram.MIClassPopupClassEditClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ClassEditSelectedDiagramElementsControl(getPopMenuClass);
end;

procedure TAFrameDiagram.MIClassPopupOpenSourceClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.SourceEditSelectedDiagramElements(getPopMenuClass);
end;

procedure TAFrameDiagram.MIClassPopupParameterDisplayClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoShowParameter(getPopMenuClass, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupVisibilityClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoShowVisibility(getPopMenuClass, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupSelectAssociationClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.SelectAssociation;
end;

procedure TAFrameDiagram.MIClassPopupShowInheritedClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ShowInheritedMethodsFromSystemClasses(getPopMenuClass, true);
  PopMenuClass.PopUp(PopMenuClass.PopupPoint.x, PopMenuClass.PopupPoint.y);
end;

procedure TAFrameDiagram.MIClassPopupHideInheritedClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ShowInheritedMethodsFromSystemClasses(getPopMenuClass, false);
  PopMenuClass.PopUp(PopMenuClass.PopupPoint.x, PopMenuClass.PopupPoint.y);
end;

procedure TAFrameDiagram.MIClassPopupNewCommentClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.AddCommentBoxTo(getPopMenuClass);
end;

procedure TAFrameDiagram.MIConnectionClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoConnection((Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupDeleteClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DeleteSelectedControlsAndRefresh;
end;

procedure TAFrameDiagram.MIClassPopupDisplayClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoShowVisibilityFilter(getPopMenuClass, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupCopyAsPictureClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.CopyDiagramToClipboard;
end;

procedure TAFrameDiagram.MIClassPopupCreateTestClassClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.CreateTestClass(getPopMenuClass);
end;

procedure TAFrameDiagram.MIClassPopupRunAllTestsClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.RunTests(getPopMenuClass, 'Class');
end;

procedure TAFrameDiagram.PopMenuObjectPopup(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.PopMenuObjectPopup(Sender);
end;

procedure TAFrameDiagram.PopupMenuCommentDeleteClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DeleteComment;
end;

procedure TAFrameDiagram.PopupMenuWindowPopup(Sender: TObject);
  var i: integer;
begin
  for i:= 0 to MIWindowPopupDisplay.Count - 1 do
    MIWindowPopupDisplay.Items[i].Checked:= false;
  MIWindowPopupDisplay.Items[3 - GuiPyOptions.DiVisibilityFilter].Checked:= true;
  for i:= 0 to MIWindowPopupParameter.Count - 1 do
    MIWindowPopupParameter.Items[i].Checked:= false;
  MIWindowPopupParameter.Items[GuiPyOptions.DIShowParameter].Checked:= true;
  for i:= 0 to MIWindowPopupVisibility.Count - 1 do
    MIWindowPopupVisibility.Items[i].Checked:= false;
  MIWindowPopupVisibility.Items[2-GuiPyOptions.DiShowIcons].Checked:= true;
end;

procedure TAFrameDiagram.MIObjectPopupDisplayClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoShowVisibilityFilter(getPopMenuObject, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIObjectPopupEditClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.EditObject(getPopMenuObject);
end;

procedure TAFrameDiagram.MIObjectPopupShowAllNewObjectsClick(
  Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ShowAllNewObjects(Sender);
end;

procedure TAFrameDiagram.MIObjectPopupShowInheritedClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ShowInheritedMethodsFromSystemClasses(getPopMenuObject, true);
  PopMenuObject.PopUp(PopMenuObject.PopupPoint.x, PopMenuObject.PopupPoint.y);
end;

procedure TAFrameDiagram.MIObjectPopupHideInheritedClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ShowInheritedMethodsFromSystemClasses(getPopMenuObject, false);
  PopMenuObject.PopUp(PopMenuObject.PopupPoint.x, PopMenuObject.PopupPoint.y);
end;

procedure TAFrameDiagram.MIObjectPopUpShowUnnamedClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.ShowUnnamedObject(Sender);
end;

procedure TAFrameDiagram.MIObjectPopupVisibilityClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoShowVisibility(getPopMenuObject, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIPopupAlignClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoAlign((Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MISetRecursiv(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.setRecursiv(PopMenuConnection.PopupPoint, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIWindowPopupNewCommentClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.AddCommentBoxTo(nil);
end;

procedure TAFrameDiagram.MIWindowPopupNewLayoutClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.DoLayout;
end;

procedure TAFrameDiagram.MIWindowPopupNewClassClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.NewClass;
end;

procedure TAFrameDiagram.MIWindowPopupOpenClassClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.OpenClassWithDialog;
end;

procedure TAFrameDiagram.MIWindowPopupRefreshClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.RefreshDiagram;
end;

procedure TAFrameDiagram.MIWindowPopupCopyAsPictureClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.CopyDiagramToClipboard;
end;

procedure TAFrameDiagram.MIWindowPopupDisplayClick(Sender: TObject);
begin
  GuiPyOptions.DIVisibilityFilter:= (Sender as TSpTBXItem).Tag;
  if assigned(Diagram) then
    Diagram.VisibilityFilter:= TVisibility((Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIWindowPopupFontClick(Sender: TObject);
begin
  if assigned(Diagram) then
    Diagram.SetUMLFont;
end;

procedure TAFrameDiagram.MIWindowPopupParameterDisplayClick(Sender: TObject);
begin
  GuiPyOptions.DIShowParameter:= (Sender as TSpTBXItem).Tag;
  if assigned(Diagram) then
    Diagram.ShowParameter:= (Sender as TSpTBXItem).Tag;
end;

procedure TAFrameDiagram.MIWindowPopupVisibilityClick(Sender: TObject);
begin
  GuiPyOptions.DIShowIcons:= (Sender as TSpTBXItem).Tag;
  if assigned(Diagram) then
    Diagram.ShowIcons:= (Sender as TSpTBXItem).Tag;
end;

procedure TAFrameDiagram.MIWindowPopupConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('UML Design');
end;

function TAFrameDiagram.getPopMenuClass: TControl;
begin
  Result:= FindVCLWindow(PopMenuClass.PopupPoint);
end;

function TAFrameDiagram.getPopMenuObject: TControl;
begin
  Result:= FindVCLWindow(PopMenuObject.PopupPoint);
end;

end.
