{
  ESS-FModel
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
  Messages,
  Classes,
  Controls,
  Forms,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  SVGIconImageCollection,
  SpTBXItem,
  TB2Item,
  UViewIntegrator,
  UListeners,
  UModelEntity,
  UModel;

const
  WM_ChangePackage = WM_USER + 1;

type

  // permanent menu items have Tag=1

  TAFrameDiagram = class(TFrame, IBeforeObjectModelListener,
    IAfterObjectModelListener)
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
    N1Sep: TSpTBXSeparatorItem;
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
    scMenuAlign: TSVGIconImageCollection;
    vilAlignLight: TVirtualImageList;
    vilAlignDark: TVirtualImageList;
    icMenuWindow: TSVGIconImageCollection;
    vilWindowLight: TVirtualImageList;
    vilWindowDark: TVirtualImageList;
    icMenuClassObject: TSVGIconImageCollection;
    vilClassObjectLight: TVirtualImageList;
    vilClassObjectDark: TVirtualImageList;
    icMenuConnection: TSVGIconImageCollection;
    vilAssociationsLight: TVirtualImageList;
    vilAssociationsDark: TVirtualImageList;
    icUMLRtfdComponents: TSVGIconImageCollection;
    vilUMLRtfdComponentsLight: TVirtualImageList;
    vilUMLRtfdComponentsDark: TVirtualImageList;

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
    FDiagram: TDiagramIntegrator;
    FModel: TObjectModel;
    FScrollBox: TScrollBox;
    procedure ModelBeforeChange(Sender: TModelEntity);
    procedure ModelAfterChange(Sender: TModelEntity);
    procedure IBeforeObjectModelListener.Change = ModelBeforeChange;
    procedure IAfterObjectModelListener.Change = ModelAfterChange;
  public
    constructor Create(Owner: TComponent; Model: TObjectModel); reintroduce;
    destructor Destroy; override;
    procedure OnUpdateToolbar(Sender: TObject);
    procedure Retranslate;
    function GetPopMenuClass: TControl;
    function GetPopMenuObject: TControl;

    property Diagram: TDiagramIntegrator read FDiagram write FDiagram;
    property Model: TObjectModel read FModel;
    property ScrollBox: TScrollBox read FScrollBox;
  end;

implementation

uses
  JvGnugettext,
  UUtils,
  UConfiguration;

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
  AutoScroll := True;
end;

procedure TScrollBoxWithNotify.WMHScroll(var Message: TWMHScroll);
begin
  inherited;
  if (Message.ScrollBar = 0) and HorzScrollBar.Visible and Assigned(OnResize)
  then
    OnResize(nil);
end;

procedure TScrollBoxWithNotify.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  if (Message.ScrollBar = 0) and VertScrollBar.Visible and Assigned(OnResize)
  then
    OnResize(nil);
end;

{ TDiagramFrame }

constructor TAFrameDiagram.Create(Owner: TComponent; Model: TObjectModel);
begin
  inherited Create(Owner);
  TranslateComponent(Self);
  Self.FModel := Model;
  Self.FModel.AddListener(IAfterObjectModelListener(Self)); // without self
  FScrollBox := TScrollBoxWithNotify.Create(Self);
  FScrollBox.Parent := Self;
end;

destructor TAFrameDiagram.Destroy;
begin
  // responsible for SIGSEGV exception
  // if Assigned(FModel) then
  // FModel.RemoveListener(IAfterObjectModelListener(Self));
  inherited;
end;

procedure TAFrameDiagram.OnUpdateToolbar(Sender: TObject);
begin
end;

procedure TAFrameDiagram.ModelBeforeChange(Sender: TModelEntity);
begin
  UViewIntegrator.SetCurrentEntity(nil);
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
  FDiagram.PopMenuClassPopup(Sender);
end;

procedure TAFrameDiagram.PopMenuConnectionPopup(Sender: TObject);
begin
  FDiagram.PopMenuConnectionPopup(Sender);
end;

procedure TAFrameDiagram.MIClassPopupRunClick(Sender: TObject);
begin
  FDiagram.Run(GetPopMenuClass);
end;

{ procedure TAFrameDiagram.MIAttributesMethodsPrivateClick(Sender: TObject);
  begin
  FDiagram.VisibilityFilter:= TVisibility(0);
  GuiPyOptions.DiVisibilityFilter:= 0;
  end;

  procedure TAFrameDiagram.MIAttributesMethodsPackageClick(Sender: TObject);
  begin
  FDiagram.VisibilityFilter:= TVisibility(1);
  GuiPyOptions.DiVisibilityFilter:= 1;
  end;

  procedure TAFrameDiagram.MIAttributesMethodsProtectedClick(Sender: TObject);
  begin
  FDiagram.VisibilityFilter:= TVisibility(2);
  GuiPyOptions.DiVisibilityFilter:= 2;
  end;

  procedure TAFrameDiagram.MIAttributesMethodsPublicClick(Sender: TObject);
  begin
  FDiagram.VisibilityFilter:= TVisibility(3);
  GuiPyOptions.DiVisibilityFilter:= 3;
  end;

  procedure TAFrameDiagram.MIAttributesMethodsNoneClick(Sender: TObject);
  begin
  FDiagram.VisibilityFilter:= TVisibility(4);
  GuiPyOptions.DiVisibilityFilter:= 4;
  end;
}

procedure TAFrameDiagram.MIClassPopupClassEditClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ClassEditSelectedDiagramElementsControl(GetPopMenuClass);
end;

procedure TAFrameDiagram.MIClassPopupOpenSourceClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.SourceEditSelectedDiagramElements(GetPopMenuClass);
end;

procedure TAFrameDiagram.MIClassPopupParameterDisplayClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoShowParameter(GetPopMenuClass, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupVisibilityClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoShowVisibility(GetPopMenuClass, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupSelectAssociationClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.SelectAssociation;
end;

procedure TAFrameDiagram.MIClassPopupShowInheritedClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ShowInheritedMethodsFromSystemClasses(GetPopMenuClass, True);
  PopMenuClass.Popup(PopMenuClass.PopupPoint.X, PopMenuClass.PopupPoint.Y);
end;

procedure TAFrameDiagram.MIClassPopupHideInheritedClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ShowInheritedMethodsFromSystemClasses(GetPopMenuClass, False);
  PopMenuClass.Popup(PopMenuClass.PopupPoint.X, PopMenuClass.PopupPoint.Y);
end;

procedure TAFrameDiagram.MIClassPopupNewCommentClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.AddCommentBoxTo(GetPopMenuClass);
end;

procedure TAFrameDiagram.MIConnectionClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoConnection((Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupDeleteClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DeleteSelectedControlsAndRefresh;
end;

procedure TAFrameDiagram.MIClassPopupDisplayClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoShowVisibilityFilter(GetPopMenuClass,
      (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIClassPopupCopyAsPictureClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.CopyDiagramToClipboard;
end;

procedure TAFrameDiagram.MIClassPopupCreateTestClassClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.CreateTestClass(GetPopMenuClass);
end;

procedure TAFrameDiagram.MIClassPopupRunAllTestsClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.RunTests(GetPopMenuClass, 'Class');
end;

procedure TAFrameDiagram.PopMenuObjectPopup(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.PopMenuObjectPopup(Sender);
end;

procedure TAFrameDiagram.PopupMenuCommentDeleteClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DeleteComment;
end;

procedure TAFrameDiagram.PopupMenuWindowPopup(Sender: TObject);
begin
  for var I := 0 to MIWindowPopupDisplay.Count - 1 do
    MIWindowPopupDisplay[I].Checked := False;
  MIWindowPopupDisplay[3 - GuiPyOptions.DiVisibilityFilter]
    .Checked := True;
  for var I := 0 to MIWindowPopupParameter.Count - 1 do
    MIWindowPopupParameter[I].Checked := False;
  MIWindowPopupParameter[GuiPyOptions.DiShowParameter].Checked := True;
  for var I := 0 to MIWindowPopupVisibility.Count - 1 do
    MIWindowPopupVisibility[I].Checked := False;
  MIWindowPopupVisibility[2 - GuiPyOptions.DiShowIcons].Checked := True;
end;

procedure TAFrameDiagram.MIObjectPopupDisplayClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoShowVisibilityFilter(GetPopMenuObject,
      (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIObjectPopupEditClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.EditObject(GetPopMenuObject);
end;

procedure TAFrameDiagram.MIObjectPopupShowAllNewObjectsClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ShowAllNewObjects(Sender);
end;

procedure TAFrameDiagram.MIObjectPopupShowInheritedClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ShowInheritedMethodsFromSystemClasses(GetPopMenuObject, True);
  PopMenuObject.Popup(PopMenuObject.PopupPoint.X, PopMenuObject.PopupPoint.Y);
end;

procedure TAFrameDiagram.MIObjectPopupHideInheritedClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ShowInheritedMethodsFromSystemClasses(GetPopMenuObject, False);
  PopMenuObject.Popup(PopMenuObject.PopupPoint.X, PopMenuObject.PopupPoint.Y);
end;

procedure TAFrameDiagram.MIObjectPopUpShowUnnamedClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.ShowUnnamedObject(Sender);
end;

procedure TAFrameDiagram.MIObjectPopupVisibilityClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoShowVisibility(GetPopMenuObject, (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIPopupAlignClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoAlign((Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MISetRecursiv(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.SetRecursiv(PopMenuConnection.PopupPoint,
      (Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIWindowPopupNewCommentClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.AddCommentBoxTo(nil);
end;

procedure TAFrameDiagram.MIWindowPopupNewLayoutClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.DoLayout;
end;

procedure TAFrameDiagram.MIWindowPopupNewClassClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.NewClass;
end;

procedure TAFrameDiagram.MIWindowPopupOpenClassClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.OpenClassWithDialog;
end;

procedure TAFrameDiagram.MIWindowPopupRefreshClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.RefreshDiagram;
end;

procedure TAFrameDiagram.MIWindowPopupCopyAsPictureClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.CopyDiagramToClipboard;
end;

procedure TAFrameDiagram.MIWindowPopupDisplayClick(Sender: TObject);
begin
  GuiPyOptions.DiVisibilityFilter := (Sender as TSpTBXItem).Tag;
  if Assigned(FDiagram) then
    FDiagram.VisibilityFilter := TVisibility((Sender as TSpTBXItem).Tag);
end;

procedure TAFrameDiagram.MIWindowPopupFontClick(Sender: TObject);
begin
  if Assigned(FDiagram) then
    FDiagram.SetUMLFont;
end;

procedure TAFrameDiagram.MIWindowPopupParameterDisplayClick(Sender: TObject);
begin
  GuiPyOptions.DiShowParameter := (Sender as TSpTBXItem).Tag;
  if Assigned(FDiagram) then
    FDiagram.ShowParameter := (Sender as TSpTBXItem).Tag;
end;

procedure TAFrameDiagram.MIWindowPopupVisibilityClick(Sender: TObject);
begin
  GuiPyOptions.DiShowIcons := (Sender as TSpTBXItem).Tag;
  if Assigned(FDiagram) then
    FDiagram.ShowIcons := (Sender as TSpTBXItem).Tag;
end;

procedure TAFrameDiagram.MIWindowPopupConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('UML Design');
end;

function TAFrameDiagram.GetPopMenuClass: TControl;
begin
  Result := FindVCLWindow(PopMenuClass.PopupPoint);
end;

function TAFrameDiagram.GetPopMenuObject: TControl;
begin
  Result := FindVCLWindow(PopMenuObject.PopupPoint);
end;

end.
