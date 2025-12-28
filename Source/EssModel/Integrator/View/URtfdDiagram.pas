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

{$ASSERTIONS ON}
unit URtfdDiagram;

interface

uses
  Controls,
  Types,
  Graphics,
  Classes,
  ExtCtrls,
  UDiagramFrame,
  URtfdComponents,
  UListeners,
  UModelEntity,
  UModel,
  UUtils,
  UViewIntegrator,
  UEssConnectPanel,
  USequenceForm,
  UUMLForm,
  UConnection,
  ULivingObjects;

type
  TRtfdDiagram = class(TDiagramIntegrator, IBeforeObjectModelListener,
    IAfterObjectModelListener, IAfterUnitPackageListener)
  private
    // Model: TObjectModel is inherited
    FIsAllClasses: Boolean;
    FOnModified: TNotifyEvent;
    FBoxNames: TStringList;
    FFullParameters: TStringList;
    FMenuClassFiles: TStringList;
    FLivingObjects: TLivingObjects;
    FUMLForm: TFUMLForm;
    FPPIControl: TControl;
    FCreateObjectObjectname: string;
    FCreateObjectParameter: string;
    FCreateObjectClass: TClass;
    FCallMethodObjectname: string;
    FCallMethodMethodname: string;
    FCallMethodFrom: string;
    FFrame: TAFrameDiagram;
    FPanel: TEssConnectPanel;
    FSequenceForm: TFSequenceForm;
    procedure AddBox(ModelEntity: TModelEntity);
    function GetBox(Typ: string): TRtfdBox;
    // Model listeners
    procedure ModelBeforeChange(Sender: TModelEntity);
    procedure ModelAfterChange(Sender: TModelEntity);
    procedure IBeforeObjectModelListener.Change = ModelBeforeChange;
    procedure IAfterObjectModelListener.Change = ModelAfterChange;
    // Unitpackage listeners
    procedure UnitPackageAfterChange(Sender: TModelEntity);
    procedure UnitPackageAfterAddChild(Sender: TModelEntity;
      NewChild: TModelEntity);
    procedure UnitPackageAfterRemove(Sender: TModelEntity);
    procedure UnitPackageAfterEntityChange(Sender: TModelEntity);
    procedure IAfterUnitPackageListener.Change = UnitPackageAfterChange;
    procedure IAfterUnitPackageListener.AddChild = UnitPackageAfterAddChild;
    procedure IAfterUnitPackageListener.Remove = UnitPackageAfterRemove;
    procedure IAfterUnitPackageListener.EntityChange =
      UnitPackageAfterEntityChange;
    procedure CreateObjectExecuted(Sender: TObject);
    procedure CallMethodExecuted(Sender: TObject);
    function PPIScale(ASize: Integer): Integer;
    function PPIUnScale(ASize: Integer): Integer;
    procedure ShowUnnamed(Objectname: string);
    procedure ShowRelationshipAttributesBold;
  protected
    procedure SetVisibilityFilter(const Value: TVisibility); override;
    procedure SetShowParameter(const Value: Integer); override;
    procedure SetShowView(Value: Integer); override;
    procedure SetSortOrder(const Value: Integer); override;
    procedure SetShowIcons(const Value: Integer); override;
    procedure SetShowObjectDiagram(const Value: Boolean); override;
    procedure CurrentEntityChanged; override;
  public
    constructor Create(ObjectModel: TObjectModel; Parent: TWinControl);
      override;
    destructor Destroy; override;
    procedure ClearDiagram; override;
    procedure ResolveAssociations; override;
    procedure ResolveObjectAssociations; override;
    procedure InitFromModel; override;
    procedure PaintTo(Canvas: TCanvas; X, Y: Integer;
      SelectedOnly: Boolean); override;
    procedure GetDiagramSize(var Width, Height: Integer); override;
    procedure SetPackage(const Value: TAbstractPackage); override;
    procedure DoLayout; override;
    function GetClickAreas: TStringList; override;
    procedure ClassEditSelectedDiagramElements; override;
    procedure ClassEditSelectedDiagramElementsControl(Sender: TObject);
      override;
    procedure SourceEditSelectedDiagramElements(Control: TControl); override;
    procedure UnSelectAllElements; override;
    function GetSelectedRect: TRect; override;
    procedure ScreenCenterEntity(ModelEntity: TModelEntity); override;
    procedure SetFont(const AFont: TFont); override;
    procedure StoreDiagram(const Filename: string); override;
    procedure FetchDiagram(Filename: string); override;
    procedure RefreshDiagram; override;
    procedure RecalcPanelSize; override;
    procedure SetShowConnections(const Value: Integer); override;
    procedure SelectAssociation; override;
    procedure DeleteSelectedControls(Sender: TObject);
    procedure DeleteSelectedControlsAndRefresh; override;
    procedure DeleteObjects; override;
    function HasObjects: Boolean; override;
    function HasSelectedConnection: Boolean; override;
    function GetPanel: TCustomPanel; override;
    procedure SetInteractive(OnInteractiveModified: TNotifyEvent); override;
    procedure SetFormMouseDown(OnFormMouseDown: TNotifyEvent); override;
    procedure AddToInteractive(const Source: string);
    function GetSourcePath: string; override;
    procedure Reinitalize; override;
    procedure Run(Control: TControl); override;
    procedure ShowInheritedMethodsFromSystemClasses(Control: TControl;
      ShowOrHide: Boolean); override;
    procedure OpenClassOrInterface(Sender: TObject);
    procedure OpenClassWithDialog; override;
    procedure NewClass; override;
    procedure ShowAll; override;
    procedure ShowUnnamedObject(Sender: TObject); override;
    procedure ShowAllNewObjects(Sender: TObject); override;
    procedure ShowAllNewObjectsString(From: string = '');
    procedure ConnectBoxes(Sender: TObject);
    procedure DoConnection(Item: Integer); override;
    procedure DoAlign(Item: Integer); override;
    procedure PopMenuClassPopup(Sender: TObject); override;
    procedure PopMenuObjectPopup(Sender: TObject); override;
    procedure PopMenuConnectionPopup(Sender: TObject); override;
    procedure CreateObjectForSelectedClass(Sender: TObject);
    function CreateModelClass(const Typ: string): TClass;
    function FindClassifier(const CName: string): TClassifier;
    procedure ShowNewObject(const Objectname: string; AClass: TClass = nil);
    procedure CallMethod(Control: TControl; Sender: TObject);
    procedure CallMethodForObject(Sender: TObject);
    procedure CallMethodForClass(Sender: TObject);
    procedure CollectClasses;
    procedure EditObject(Control: TControl); override;
    function HasAttributes(const Objectname: string): Boolean;
    procedure UpdateAllObjects;
    procedure ShowAttributes(const Objectname: string; AClass: TClass;
      AModelObject: TObjekt);
    procedure SetAttributeValues(ModelClass: TClass; const Objectname: string;
      Attributes: TStringList);
    function EditClass(const Caption, Title, ObjectNameOld: string;
      var ObjectNameNew: string; Control: TControl;
      Attributes: TStringList): Boolean;
    function EditObjectOrParams(const Caption, Title: string; Control: TControl;
      Attributes: TStringList): Boolean;
    procedure SetRecursiv(Point: TPoint; Pos: Integer); override;
    function GetModelClass(const Str: string): TClass;
    function StringToArrowStyle(Str: string): TEssConnectionArrowStyle;
    function ArrowStyleToString(ArrowStyle: TEssConnectionArrowStyle): string;
    function GetCommentBoxName: string;
    procedure AddCommentBoxTo(Control: TControl); override;
    function InsertParameterNames(Names: string): string;
    function HasClass(const AClassname: string): Boolean;
    procedure DoShowParameter(Control: TControl; Mode: Integer); override;
    procedure DoShowVisibility(Control: TControl; Mode: Integer); override;
    procedure DoShowVisibilityFilter(Control: TControl; Mode: Integer);
      override;
    procedure CreateTestClass(Control: TControl); override;
    procedure RunTests(Control: TControl; const Method: string); override;
    procedure OnRunJunitTestMethod(Sender: TObject);
    procedure ShowMethodEntered(const Methodname, From, Till,
      Parameter: string);
    procedure ShowMethodExited(const Methodname, From, Till, Result: string);
    procedure ShowObjectDeleted(const From, Till: string);
    procedure CloseNotify(Sender: TObject);
    procedure ClearSelection; override;
    procedure CopyDiagramToClipboard; override;
    procedure ClearMarkerAndConnections(Control: TControl); override;
    procedure DrawMarkers(Rect: TRect; Show: Boolean); override;
    procedure EditBox(Control: TControl); override;
    procedure SetModified(const Value: Boolean); override;
    procedure SetOnModified(OnBoolEvent: TBoolEvent); override;
    procedure ChangeStyle; override;
    procedure DeleteComment; override;
    function GetDebug: TStringList;
    function GetSVG: string; override;
    function GetParameterAsString(Parameter, ParamValues: TStringList): string;
    function GetInternName(AClass: TClass; const Name: string;
      Visibility: TVisibility): string;
    function StrToPythonValue(const Value: string): string;
    function StrAndTypeToPythonValue(const Value, PValue: string): string;
    procedure ExecutePython(const Source: string); override;
    procedure GetVisFromName(var Name: string; var Vis: TVisibility);
    procedure Retranslate; override;
    function PanelIsLocked: Boolean; override;
    procedure SetUMLFont; override;
    function HasAInvalidClass: Boolean; override;
    property Frame: TAFrameDiagram read FFrame;
    property Panel: TEssConnectPanel read FPanel;
    property SequenceForm: TFSequenceForm read FSequenceForm
      write FSequenceForm;
  end;

implementation

uses
  Windows,
  Menus,
  Forms,
  Math,
  SysUtils,
  UITypes,
  Dialogs,
  Contnrs,
  IOUtils,
  IniFiles,
  Clipbrd,
  JvGnugettext,
  TB2Item,
  SpTBXItem,
  dmCommands,
  dmResources,
  frmPyIDEMain,
  uEditAppIntfs,
  frmFile,
  frmPythonII,
  frmVariables,
  uPythonItfs,
  PythonEngine,
  StringResources,
  uCommonFunctions,
  UIterators,
  URtfdDiagramFrame,
  USugiyamaLayout,
  UIntegrator,
  UObjectGenerator,
  UConfiguration,
  FrmEditor;

{ TRtfdDiagram }

constructor TRtfdDiagram.Create(ObjectModel: TObjectModel; Parent: TWinControl);
begin
  inherited Create(ObjectModel, Parent);
  FFrame := TAFrameRtfdDiagram.Create(Parent, Self);
  FFrame.Parent := Parent; // assigment to the gui
  FUMLForm := (Parent.Parent.Parent as TFUMLForm);
  FPPIControl := FUMLForm.TBClose;
  FLivingObjects := TLivingObjects.Create;

  // FPanel is ActiveControl in MainForm
  FPanel := TEssConnectPanel.Create(FUMLForm);
  FPanel.PopupMenuConnection := FFrame.PopMenuConnection;
  FPanel.PopupMenuAlign := FFrame.PopupMenuAlign;
  FPanel.PopupMenuWindow := FFrame.PopupMenuWindow;
  FPanel.Parent := FFrame.ScrollBox;
  FPanel.Name := 'PanelName';
  FPanel.OnDeleteSelectedControls := DeleteSelectedControls;
  FPanel.OnClassEditSelectedDiagramElements :=
    ClassEditSelectedDiagramElementsControl;

  FOnModified := nil;
  FSequenceForm := nil;

  FBoxNames := TStringList.Create;
  FBoxNames.CaseSensitive := True;
  FBoxNames.Sorted := True;
  FBoxNames.Duplicates := dupIgnore;
  FFullParameters := TStringList.Create;
  FMenuClassFiles := TStringList.Create;
  FMenuClassFiles.Sorted := True;
  FMenuClassFiles.Duplicates := dupIgnore;

  Model.AddListener(IBeforeObjectModelListener(Self));
  ClearDiagram;
end;

destructor TRtfdDiagram.Destroy;
var
  Box: TRtfdBox;
begin
  // Force listeners to release, and diagram to persist.
  // Package:= nil;
  // Model.RemoveListener(IBeforeObjectModelListener(Self));
  Model.ClearListeners;

  FreeAndNil(FFullParameters);
  for var I := 0 to FBoxNames.Count - 1 do
  begin
    Box := FBoxNames.Objects[I] as TRtfdBox;
    FreeAndNil(Box);
  end;
  FreeAndNil(FBoxNames);
  FreeAndNil(FMenuClassFiles);
  FreeAndNil(FLivingObjects);
  // dont do that: FreeAndNil(FFrame);
  // FFrame is part of the gui and therefore is destroyed as GUI-component
  // FPanel is part of FFrame so it is also destroyed by system as GUI-component
  inherited; // Model is inherited
end;

procedure TRtfdDiagram.InitFromModel;
var
  MIte: IModelIterator;

  procedure InAddUnit(UnitPackage: TUnitPackage);
  var
    MIte: IModelIterator;
    Classifier: TClassifier;
  begin
    MIte := UnitPackage.GetClassifiers;
    while MIte.HasNext do
    begin
      Classifier := MIte.Next as TClassifier;
      if Classifier.IsVisible then
        AddBox(Classifier);
    end;
  end;

begin
  FIsAllClasses := True;
  FPanel.Hide;
  if not Assigned(FPackage) then
  begin
    Package := Model.ModelRoot;
    // If there is only one package (except unknown) then show it.
    // Assign with Package-property to trigger listeners
    MIte := (FPackage as TLogicPackage).GetPackages;
    if MIte.Count = 2 then
    begin
      MIte.Next;
      Package := MIte.Next as TAbstractPackage;
    end;
  end;

  // Clean old
  ClearDiagram;

  // Create boxes
  if FPackage is TUnitPackage then
    InAddUnit(FPackage as TUnitPackage)
  else
  begin
    // Logic package
    // Exclude unknown-package, otherwise all temp-classes will be included on showallclasses.
    // Also, unkown-package will be shown on package-overview (including docgen)
    if FIsAllClasses then
    begin
      // These lines show all members of a package on one diagram
      MIte := TModelIterator.Create(Model.ModelRoot.GetPackages,
        TEntitySkipFilter.Create(Model.UnknownPackage));
      while MIte.HasNext do
        InAddUnit(MIte.Next as TUnitPackage);
    end
    else
    begin
      MIte := TModelIterator.Create((FPackage as TLogicPackage).GetPackages,
        TEntitySkipFilter.Create(Model.UnknownPackage));
      while MIte.HasNext do
        AddBox(MIte.Next);
    end;
  end;

  // Create arrow between boxes
  // This must be done after fetchdiagram because connection-setting might be stored
  DoLayout;
  FPanel.RecalcSize;
  FPanel.IsModified := False;
  FPanel.Show;
  FPanel.SetFocus;
end;

procedure TRtfdDiagram.ModelBeforeChange(Sender: TModelEntity);
begin
  Package := nil;
  FIsAllClasses := False;
  ClearDiagram;
end;

procedure TRtfdDiagram.ModelAfterChange(Sender: TModelEntity);
begin
  InitFromModel;
end;

procedure TRtfdDiagram.PaintTo(Canvas: TCanvas; X, Y: Integer;
  SelectedOnly: Boolean);
var
  OldBit: Graphics.TBitmap;
begin
  OldBit := FPanel.BackBitmap;
  FPanel.BackBitmap := nil;
  if SelectedOnly then
  begin
    if FPanel.GetFirstSelected <> nil then
      FPanel.SelectedOnly := True;
  end
  else
    // selection-markers should not be visible in the saved picture
    FPanel.ClearSelection;
  Canvas.Lock;
  try
    FPanel.PaintTo(Canvas.Handle, X, Y);
    FPanel.TextTo(Canvas);
  finally
    Canvas.Unlock;
    FPanel.SelectedOnly := False;
    FPanel.BackBitmap := OldBit;
  end;
end;

function TRtfdDiagram.GetSVG: string;
var
  SVG, ShadowWidth, ShadowIntensity, ShadowWidth2: string;
  Width, Height: Integer;
begin
  FPanel.GetDiagramSize(Width, Height);
  SVG := '<?xml version="1.0" encoding="UTF-8" ?>'#13#10;
  SVG := SVG + '<svg width="' + IntToStr(Width) + '"' + ' height="' +
    IntToStr(Height) + '"' + ' font-family="' + Font.Name + '"' + ' font-size="'
    + IntToStr(Round(Font.Size * 1.3)) + '">'#13#10;
  if GuiPyOptions.ShadowWidth > 0 then
  begin
    ShadowWidth := FloatToVal(GuiPyOptions.ShadowWidth / 2.0);
    ShadowIntensity :=
      FloatToVal(Min(2 * GuiPyOptions.ShadowIntensity / 10.0, 1));
    ShadowWidth2 := FloatToVal(Min(GuiPyOptions.ShadowWidth, 10) * 0.4);
    SVG := SVG + '  <defs>'#13#10 +
      '    <filter style="color-interpolation-filters:sRGB;" id="Shadow">'#13#10
      + '      <feFlood flood-opacity=' + ShadowIntensity +
      ' flood-color="rgb(0,0,0)" result="flood" />'#13#10 +
      '      <feComposite in="flood" in2="SourceGraphic" operator="in" result="composite1"/>'#13#10
      + '      <feGaussianBlur in="composite1" stdDeviation=' + ShadowWidth2 +
      ' result="blur" />'#13#10 + '      <feOffset dx=' + ShadowWidth + ' dy=' +
      ShadowWidth + ' result="offset" />'#13#10 +
      '      <feComposite in="SourceGraphic" in2="offset" operator="over" result="composite2" />'#13#10
      + '    </filter>'#13#10 + '  </defs>'#13#10;
  end;
  SVG := SVG + FPanel.GetSVGConnections;
  for var I := 0 to FBoxNames.Count - 1 do
    SVG := SVG + (FBoxNames.Objects[I] as TRtfdBox).GetSVG;
  Result := SVG + '</svg>'#13#10;
end;

procedure TRtfdDiagram.ClearDiagram;
begin
  if not(csDestroying in FPanel.ComponentState) then
  begin
    FPanel.ClearManagedObjects;
    FPanel.DestroyComponents;
  end;
  FBoxNames.Clear;
end;

// Add a 'Box' to the diagram (class/package/objekt/comment).
procedure TRtfdDiagram.AddBox(ModelEntity: TModelEntity);
var
  MIte: IModelIterator;
  AClass: TClass;
  Attribute: TAttribute;

  function InCreateBox(ModelEntity: TModelEntity; BoxT: TRtfdBoxClass)
    : TRtfdBox;
  begin
    Result := BoxT.Create(FPanel, ModelEntity, FFrame, viPrivate);
    Result.Font.Assign(Font);
    FBoxNames.AddObject(ModelEntity.Name, Result);
  end;

begin
  if ModelEntity is TUnitPackage then
    FPanel.AddManagedObject(InCreateBox(ModelEntity, TRtfdUnitPackage))
  else if ModelEntity is TClass then
  begin
    // Insert related boxes from other packages
    // This should not be done if FIsAllClasses, because then all boxes are inserted anyway
    FIsAllClasses := True; // for testing
    if not FIsAllClasses then
    begin
      // Ancestor that is in another package and that is not already inserted
      // is added to the diagram.
      AClass := (ModelEntity as TClass);
      for var I := 0 to AClass.AncestorsCount - 1 do
        if (AClass.Ancestor[I].Owner <> ModelEntity.Owner) and
          (GetBox(AClass.Ancestor[I].Fullname) = nil) then
        begin
          FPanel.AddManagedObject(InCreateBox(AClass.Ancestor[I], TRtfdClass));
        end;
      // Attribute associations that are in other packages are added
      MIte := AClass.GetAttributes;
      while MIte.HasNext do
      begin
        Attribute := TAttribute(MIte.Next);
        if Assigned(Attribute.TypeClassifier) and
          (GetBox(Attribute.TypeClassifier.Fullname) = nil) and
          (Attribute.TypeClassifier <> AClass) and
          (Attribute.TypeClassifier <> AClass.Ancestor[0]) and
        // ToDo n ancestors
          (Attribute.TypeClassifier.Owner <> Model.UnknownPackage) then
        begin
          if Attribute.TypeClassifier is TClass then
            FPanel.AddManagedObject(InCreateBox(Attribute.TypeClassifier,
              TRtfdClass));
          if Attribute.TypeClassifier is TInterface then
            FPanel.AddManagedObject(InCreateBox(Attribute.TypeClassifier,
              TRtfdInterface));
        end;
      end;
    end;
    if ModelEntity.IsVisible and (GetBox(ModelEntity.GetFullnameWithoutOuter)
      = nil) then
      FPanel.AddManagedObject(InCreateBox(ModelEntity, TRtfdClass));
  end
  else if ModelEntity is TObjekt then
  begin
    if GetBox(ModelEntity.Fullname) = nil then
      FPanel.AddManagedObject(InCreateBox(ModelEntity, TRtfdObject));
  end;
end;

// Make arrows between boxes
procedure TRtfdDiagram.ResolveAssociations;
var
  Posi: Integer;
  CBox: TRtfdClass;
  AClass: TClass;
  Attribute: TAttribute;
  OBox: TRtfdObject;

  UBox: TRtfdUnitPackage;
  UnitPackage: TUnitPackage;
  Dep: TUnitDependency;

  MIte: IModelIterator;
  DestBox: TRtfdBox;
  Str, Agg, Ass: string;
  AttributeConnected: Boolean;

begin
  FPanel.DeleteNotEditedConnections;
  FPanel.DeleteObjectConnections; // why?
  for var I := 0 to FBoxNames.Count - 1 do
    if (FBoxNames.Objects[I] is TRtfdClass) then
    begin // Class
      CBox := (FBoxNames.Objects[I] as TRtfdClass);
      // Ancestors
      for var J := 0 to (CBox.Entity as TClass).AncestorsCount - 1 do
      begin
        AClass := CBox.Entity as TClass;
        if Assigned(AClass) then
        begin
          DestBox := GetBox(AClass.Ancestor[J].Fullname);
          if Assigned(DestBox) then
            FPanel.ConnectObjects(CBox, DestBox, asInheritends);
        end;
      end;
      Posi := Pos('.', CBox.Entity.Name);
      if Posi > 0 then
      begin
        DestBox := GetBox(Copy(CBox.Entity.Name, 1, Posi - 1));
        if Assigned(DestBox) then
          FPanel.ConnectObjects(DestBox, CBox, asAssociation2);
      end;

      // Attributes associations
      AttributeConnected := False;
      AClass := CBox.Entity as TClass;
      MIte := AClass.GetAttributes;
      while MIte.HasNext do
      begin
        AttributeConnected := False;
        Attribute := TAttribute(MIte.Next);
        // avoid arrows that points to themselves, also associations to ancestor (double arrows)
        if Assigned(Attribute.TypeClassifier) then
        begin
          for var J := 0 to AClass.AncestorsCount - 1 do
            if (Attribute.TypeClassifier = AClass.Ancestor[J]) and
              Assigned(GetBox(Attribute.TypeClassifier.Name)) then
              Attribute.Connected := True;
          Str := Attribute.TypeClassifier.Fullname;
          if (Pos('[', Str) > 0) and (Pos(']', Str) > 0) then
          begin // Typ[], I.e. list[AClass]
            Agg := Copy(Str, Pos('[', Str) + 1, Length(Str));
            Agg := Copy(Agg, 1, Pos(']', Agg) - 1);
            DestBox := GetBox(Agg);
            if not Assigned(DestBox) and (Pos('.', Agg) = 0) and
              (CBox.Entity.Package <> '') then
            begin
              Agg := CBox.Entity.Package + '.' + Agg;
              DestBox := GetBox(Agg);
            end;
            if Assigned(DestBox) and (FPanel.HaveConnection(CBox, DestBox) = -1)
            then
              FPanel.ConnectObjects(CBox, DestBox, asAggregation1);
          end
          else if IsPythonType(Str) then
            Continue
          else
          begin
            Ass := Str;
            DestBox := GetBox(Ass);
            if not Assigned(DestBox) and (Pos('.', Ass) = 0) and
              (CBox.Entity.Package <> '') then
            begin
              Ass := CBox.Entity.Package + '.' + Ass;
              DestBox := GetBox(Ass);
            end;
            if Assigned(DestBox) then
              if FPanel.HaveConnection(CBox, DestBox) = -1 then
                FPanel.ConnectObjects(CBox, DestBox, asAssociation2)
              else
              begin
                Posi := FPanel.HaveConnection(DestBox, CBox, asAssociation2);
                if Posi > -1 then
                  FPanel.SetConnection(Posi, asAssociation3);
              end;
          end;
          if Assigned(DestBox) and (FPanel.HaveConnection(CBox, DestBox) > -1)
            and DestBox.Entity.IsVisible then
          begin
            Attribute.Connected := True;
            AttributeConnected := True;
          end;
        end;
      end;
      if AttributeConnected then
        CBox.RefreshEntities;
    end
    else if (FBoxNames.Objects[I] is TRtfdUnitPackage) then
    begin
      // Unit
      UBox := (FBoxNames.Objects[I] as TRtfdUnitPackage);
      UnitPackage := UBox.Entity as TUnitPackage;
      MIte := UnitPackage.GetUnitDependencies;
      while MIte.HasNext do
      begin
        Dep := MIte.Next as TUnitDependency;
        if Dep.Visibility = viPublic then
        begin
          DestBox := GetBox(Dep.MyPackage.Fullname);
          if Assigned(DestBox) then
            FPanel.ConnectObjects(UBox, DestBox, asAssociation2);
        end;
      end;
    end
    else if (FBoxNames.Objects[I] is TRtfdObject) then
    begin
      // connect Objects to Classes
      OBox := (FBoxNames.Objects[I] as TRtfdObject);
      if Assigned(OBox.Entity) then
      begin
        DestBox := GetBox(FLivingObjects.getClassnameOfObject
          (OBox.Entity.Name));
        if Assigned(DestBox) then
          FPanel.ConnectObjects(OBox, DestBox, asInstanceOf);
      end;
    end;
  FPanel.ShowAll;
end;

procedure TRtfdDiagram.ShowRelationshipAttributesBold;
var
  CBox: TRtfdClass;
  AClass: TClass;
  Attribute: TAttribute;
  MIte: IModelIterator;
  DestBox: TRtfdBox;
  Ass, Agg, Str: string;
begin
  for var I := 0 to FBoxNames.Count - 1 do
  begin
    if (FBoxNames.Objects[I] is TRtfdClass) then
    begin // Class
      CBox := (FBoxNames.Objects[I] as TRtfdClass);
      AClass := CBox.Entity as TClass;
      MIte := AClass.GetAttributes;
      while MIte.HasNext do
      begin
        Attribute := TAttribute(MIte.Next);
        if Assigned(Attribute.TypeClassifier) then
        begin
          for var J := 0 to AClass.AncestorsCount - 1 do
            if (Attribute.TypeClassifier = AClass.Ancestor[J]) and
              Assigned(GetBox(Attribute.TypeClassifier.Name)) then
              Attribute.Connected := True;
          Str := Attribute.TypeClassifier.Fullname;
          if (Pos('[', Str) > 0) and (Pos(']', Str) > 0) then
          begin // Typ[], I.e. list[AClass]
            Agg := Copy(Str, Pos('[', Str) + 1, Length(Str));
            Agg := Copy(Agg, 1, Pos(']', Agg) - 1);
            DestBox := GetBox(Agg);
            if not Assigned(DestBox) and (Pos('.', Agg) = 0) and
              (CBox.Entity.Package <> '') then
            begin
              Agg := CBox.Entity.Package + '.' + Agg;
              DestBox := GetBox(Agg);
            end;
          end
          else if IsPythonType(Str) then
            Continue
          else
          begin
            Ass := Str;
            DestBox := GetBox(Ass);
            if not Assigned(DestBox) and (Pos('.', Ass) = 0) and
              (CBox.Entity.Package <> '') then
            begin
              Ass := CBox.Entity.Package + '.' + Ass;
              DestBox := GetBox(Ass);
            end;
          end;
          if Assigned(DestBox) and (FPanel.HaveConnection(CBox, DestBox) > -1)
            and DestBox.Entity.IsVisible then
            Attribute.Connected := True;
        end;
      end;
    end;
  end;
end;

// make arrows between Objects
procedure TRtfdDiagram.ResolveObjectAssociations;
var
  SLObjectAttributes: TStringList;
  OBox: TRtfdObject;
  DestBox: TRtfdBox;
begin
  FPanel.DeleteObjectConnections;
  for var I := 0 to FBoxNames.Count - 1 do
  begin
    if Assigned(FBoxNames.Objects[I]) and (FBoxNames.Objects[I] is TRtfdObject)
    then
    begin // reconnect Objects
      OBox := FBoxNames.Objects[I] as TRtfdObject;
      if Assigned(OBox.Entity) then
      begin
        SLObjectAttributes := FLivingObjects.getObjectObjectMembers
          (OBox.Entity.Name);
        for var J := 0 to SLObjectAttributes.Count - 1 do
        begin
          DestBox := GetBox(SLObjectAttributes[J]);
          if Assigned(DestBox) then
            FPanel.ConnectObjects(OBox, DestBox, asAssociation2);
        end;
        FreeAndNil(SLObjectAttributes);

        DestBox := GetBox(FLivingObjects.getClassnameOfObject
          (OBox.Entity.Name));
        if Assigned(DestBox) and (FPanel.HaveConnection(OBox, DestBox) = -1)
        then
          FPanel.ConnectObjects(OBox, DestBox, asInstanceOf);
      end;
    end;
  end;
  FPanel.ShowAll;
end;

procedure TRtfdDiagram.SetPackage(const Value: TAbstractPackage);
begin
  if Assigned(FPackage) and (FPackage is TUnitPackage) then
    FPackage.RemoveListener(IAfterUnitPackageListener(Self));
  inherited SetPackage(Value);
  if Assigned(FPackage) then
  begin
    if (FPackage is TUnitPackage) then
      FPackage.AddListener(IAfterUnitPackageListener(Self));
    if (FPackage is TLogicPackage) then
      FPackage.AddListener(IAfterUnitPackageListener(Self));
  end;
  if Assigned(FFrame.ScrollBox) and Assigned(GuiPyOptions) then
  begin
    FFrame.ScrollBox.HorzScrollBar.Position := 0;
    FFrame.ScrollBox.VertScrollBar.Position := 0;
  end;
end;

procedure TRtfdDiagram.UnitPackageAfterAddChild(Sender, NewChild: TModelEntity);
begin
  if (NewChild is TClass) or (NewChild is TObjekt) then
    AddBox(NewChild);
end;

procedure TRtfdDiagram.UnitPackageAfterChange(Sender: TModelEntity);
begin
end;

procedure TRtfdDiagram.UnitPackageAfterEntityChange(Sender: TModelEntity);
begin
end;

procedure TRtfdDiagram.UnitPackageAfterRemove(Sender: TModelEntity);
begin
end;

procedure TRtfdDiagram.StoreDiagram(const Filename: string);
var
  Ini: TMemIniFile;
  Posi, Comments: Integer;
  Box: TRtfdBox;
  Section, ConnStr, FName, Path: string;
  Connections: TList;
  Conn: TConnection;
  Values: TStrings;

begin
  Values := TStringList.Create;
  if FileExists(Filename) then
  begin
    Ini := TMemIniFile.Create(Filename);
    Ini.ReadSectionValues('Window', Values);
    FreeAndNil(Ini);
  end;
  DeleteFile(Filename);

  Path := ExtractFilePath(Filename);
  if IsUNC(Path) then
    Path := ''
  else
    SetCurrentDir(Path); // due to relativ paths

  Ini := TMemIniFile.Create(Filename, TEncoding.UTF8);
  try
    try
      // Boxes
      Comments := 0;
      for var I := 0 to FBoxNames.Count - 1 do
      begin
        if FBoxNames.Objects[I] is TRtfdObject then
        begin
          // Objects
          Box := FBoxNames.Objects[I] as TRtfdObject;
          Section := 'Object: ' + Box.Entity.Fullname;
          Ini.WriteInteger(Section, 'X', PPIUnScale(Box.Left));
          Ini.WriteInteger(Section, 'Y', PPIUnScale(Box.Top));
          Ini.WriteString(Section, 'Name', Box.Entity.Name);
          if FLivingObjects.ObjectExists(Box.Entity.Name) then
            Ini.WriteString(Section, 'Typ',
              FLivingObjects.getClassnameOfObject(Box.Entity.Name))
          else
            Ini.WriteString(Section, 'Typ', 'unknown');
        end
        else if FBoxNames.Objects[I] is TRtfdCommentBox then
        begin
          // Comments
          Box := FBoxNames.Objects[I] as TRtfdBox;
          Section := Box.Entity.Fullname;
          Ini.WriteInteger(Section, 'X', PPIUnScale(Box.Left));
          Ini.WriteInteger(Section, 'Y', PPIUnScale(Box.Top));
          Ini.WriteInteger(Section, 'W', PPIUnScale(Box.Width));
          Ini.WriteInteger(Section, 'H', PPIUnScale(Box.Height));
          var
          Str := (Box as TRtfdCommentBox).TrMemo.Text;
          Ini.WriteString(Section, 'Comment',
            myStringReplace(Str, #13#10, '_;_'));
        end
        else
        begin
          // Class
          Box := FBoxNames.Objects[I] as TRtfdBox;
          if Box.Entity.IsVisible then
          begin
            Section := 'Box: ' + Box.Entity.Fullname;
            FName := RemovePortableDrive((Box.Entity as TClassifier)
              .Pathname, Path);
            Ini.WriteString(Section, 'File', FName);
            Ini.WriteInteger(Section, 'X', PPIUnScale(Box.Left));
            Ini.WriteInteger(Section, 'Y', PPIUnScale(Box.Top));
            Ini.WriteInteger(Section, 'MinVis', Integer(Box.MinVisibility));
            Ini.WriteInteger(Section, 'ShowParameter', Box.ShowParameter);
            Ini.WriteInteger(Section, 'SortOrder', Box.SortOrder);
            Ini.WriteInteger(Section, 'ShowIcons', Box.ShowIcons);
            if Box.TypeBinding <> '' then
              Ini.WriteString(Section, 'TypeBinding', Box.TypeBinding);
          end;
        end;
      end;

      // Diagram stuff
      Section := 'Diagram';
      Ini.WriteInteger(Section, 'Comments', Comments);
      Ini.WriteInteger(Section, 'OffsetX',
        FFrame.ScrollBox.VertScrollBar.Position);
      Ini.WriteInteger(Section, 'OffsetY',
        FFrame.ScrollBox.HorzScrollBar.Position);

      Ini.WriteInteger(Section, 'Visibility', Integer(VisibilityFilter));
      Ini.WriteInteger(Section, 'ShowParameter', ShowParameter);
      Ini.WriteInteger(Section, 'SortOrder', SortOrder);
      Ini.WriteInteger(Section, 'ShowIcons', ShowIcons);
      Ini.WriteInteger(Section, 'ShowConnections', ShowConnections);
      Ini.WriteString(Section, 'Fontname', Font.Name);
      Ini.WriteInteger(Section, 'Fontsize', PPIUnScale(Font.Size));
      Ini.WriteBool(Section, 'ShowObjectDiagram', ShowObjectDiagram);

      // Connections
      Section := 'Connections';
      Connections := FPanel.GetConnections;
      for var I := 0 to Connections.Count - 1 do
      begin
        Conn := TConnection(Connections[I]);
        with Conn do
          ConnStr := (FromControl as TRtfdBox).Entity.Fullname + '#' +
            (ToControl as TRtfdBox).Entity.Fullname + '#' +
            ArrowStyleToString(ArrowStyle) + '#' + HideCrLf(MultiplicityA) + '#'
            + Relation + '#' + HideCrLf(MultiplicityB) + '#' +
            IntToStr(RecursivCorner) + '#' + BoolToStr(IsTurned) + '#' +
            BoolToStr(IsEdited) + '#' + HideCrLf(RoleA) + '#' + HideCrLf(RoleB)
            + '#' + BoolToStr(ReadingOrderA) + '#' + BoolToStr(ReadingOrderB);
        Ini.WriteString(Section, 'V' + IntToStr(I), ConnStr);
      end;
      FreeAndNil(Connections);

      // Interactive
      for var I := 0 to FUMLForm.InteractiveLines.Count - 1 do
        Ini.WriteString('Interactive', 'I' + IntToStr(I),
          FUMLForm.InteractiveLines[I]);

      // Window
      for var I := 0 to Values.Count - 1 do
      begin
        Section := Values[I];
        Posi := Pos('=', Section);
        Ini.WriteString('Window', Copy(Section, 1, Posi - 1),
          Copy(Section, Posi + 1, Length(Section)));
      end;

      Ini.UpdateFile;
    except
      on E: Exception do
        ErrorMsg(Format(_(SFileSaveError), [FileName, E.Message]));
    end;
  finally
    FreeAndNil(Ini);
  end;

  FreeAndNil(Values);
  FPanel.IsModified := False;
end;

procedure TRtfdDiagram.FetchDiagram(Filename: string);
var
  Ini: TMemIniFile;
  Int, Num, Posi, CountObjects: Integer;
  Box, Box1, Box2: TRtfdBox;
  Section, CName, AFile, B1Name, B2Name, Path: string;
  Files, Sections, StringList: TStringList;
  AllBoxes: TList;

  UnitPackage: TUnitPackage;
  TheClassname: string;
  TheObjectname: string;
  AModelObject: TObjekt;

  Attributes: TConnectionAttributes;
  AClass: TClass;
  AClassifier: TClassifier;

  BoxShowParameter, BoxSortOrder, BoxShowIcons: Integer;
  BoxTypeBinding: string;
  CommentBox: TRtfdCommentBox;
  VisibilityFilterAsInteger: Integer;
begin
  Filename := ExpandFileName(Filename);
  Ini := TMemIniFile.Create(Filename);
  Files := TStringList.Create;
  Sections := TStringList.Create;
  Attributes := TConnectionAttributes.Create;
  try
    Section := 'Diagram';
    FFrame.ScrollBox.VertScrollBar.Position :=
      Ini.ReadInteger(Section, 'OffsetX',
      FFrame.ScrollBox.VertScrollBar.Position);
    FFrame.ScrollBox.HorzScrollBar.Position :=
      Ini.ReadInteger(Section, 'OffsetY',
      FFrame.ScrollBox.HorzScrollBar.Position);

    ShowConnections := Ini.ReadInteger(Section, 'ShowConnections', 0);
    VisibilityFilterAsInteger := Ini.ReadInteger(Section, 'Visibility', 0);
    VisibilityFilter := TVisibility(VisibilityFilterAsInteger);
    ShowParameter := Ini.ReadInteger(Section, 'ShowParameter', ShowParameter);
    SortOrder := Ini.ReadInteger(Section, 'SortOrder', SortOrder);
    ShowIcons := Ini.ReadInteger(Section, 'ShowIcons', ShowIcons);
    ShowObjectDiagram := Ini.ReadBool(Section, 'ShowObjectDiagram', False);
    Font.Name := Ini.ReadString(Section, 'Fontname', 'Segoe UI');
    Font.Size := PPIScale(Ini.ReadInteger(Section, 'Fontsize', 11));
    SetFont(Font);

    // read files
    Path := ExtractFilePath(Filename);
    if IsUNC(Path) then
      Path := ''
    else
      SetCurrentDir(Path); // due to relativ paths
    Ini.ReadSections(Sections);
    for var I := 0 to Sections.Count - 1 do
    begin
      if Pos('Box: ', Sections[I]) > 0 then
      begin
        AFile := Ini.ReadString(Sections[I], 'File', '');
        if AFile <> '' then
        begin
          AFile := ExpandFileName(AddPortableDrive(AFile, Path));
          if not FileExistsCaseSensitive(AFile) then
            AFile := ExtractFilePath(Filename) + ExtractFileName(AFile);
          if FileExistsCaseSensitive(AFile) and (Files.IndexOf(AFile) = -1) then
            Files.Add(AFile);
        end;
      end;
    end;
    FUMLForm.MainModul.LoadProject(Files);

    // read classes
    for var I := FBoxNames.Count - 1 downto 0 do
    begin
      Box := FBoxNames.Objects[I] as TRtfdBox;
      if FBoxNames.Objects[I] is TRtfdClass then
      begin
        Section := 'Box: ' + Box.Entity.Fullname;
        if Ini.SectionExists(Section) then
        begin
          Box.Left := PPIScale(Ini.ReadInteger(Section, 'X', Box.Left));
          Box.Top := PPIScale(Ini.ReadInteger(Section, 'Y', Box.Top));
          Box.MinVisibility := TVisibility(Ini.ReadInteger(Section, 'MinVis',
            VisibilityFilterAsInteger));
          BoxShowParameter := Ini.ReadInteger(Section, 'ShowParameter',
            ShowParameter);
          BoxSortOrder := Ini.ReadInteger(Section, 'SortOrder', SortOrder);
          BoxShowIcons := Ini.ReadInteger(Section, 'ShowIcons', ShowIcons);
          BoxTypeBinding := Ini.ReadString(Section, 'TypeBinding', '');
          Box.SetParameters(BoxShowParameter, BoxSortOrder, BoxShowIcons, Font,
            BoxTypeBinding);
        end
        else
          FPanel.FindManagedControl(Box).Selected := True;
      end;
    end;
    DeleteSelectedControls(nil);

    // read Objects
    CountObjects := 0;
    for var I := 0 to Sections.Count - 1 do
    begin
      if Pos('Object: ', Sections[I]) > 0 then
      begin
        Section := Sections[I];
        UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
        if not Assigned(UnitPackage) then
          UnitPackage := Model.ModelRoot.AddUnit('Default');
        TheClassname := Ini.ReadString(Section, 'Typ', '');
        TheObjectname := Ini.ReadString(Section, 'Name', '');

        AClass := nil;
        if FLivingObjects.ObjectExists(TheObjectname) then
        begin
          Num := FBoxNames.IndexOf(TheClassname);
          if Num >= 0 then
            AClass := (FBoxNames.Objects[Num] as TRtfdClass).Entity as TClass;
        end
        else
          TheObjectname := '';
        if not Assigned(AClass) then
        begin
          AClassifier := UnitPackage.FindClassifier(TheClassname, TClass, True);
          if Assigned(AClassifier) then
            AClass := AClassifier as TClass
          else
          begin
            AClass := TClass.Create(nil);
            AClass.Name := TheClassname;
            UnitPackage.AddClass(AClass);
          end;
        end;

        if TheObjectname <> '' then
        begin
          AModelObject := UnitPackage.AddObject(TheObjectname, AClass);
          ShowAttributes(TheObjectname, AClass, AModelObject);
          Num := FBoxNames.IndexOf(TheObjectname);
          if Num = -1 then
          begin
            AddBox(AModelObject);
            Num := FBoxNames.IndexOf(TheObjectname);
          end;

          if Num > -1 then
          begin
            Box := FBoxNames.Objects[Num] as TRtfdBox;
            Box.Left := PPIScale(Ini.ReadInteger(Section, 'X', Box.Left));
            Box.Top := PPIScale(Ini.ReadInteger(Section, 'Y', Box.Top));
            Box.Font.Assign(Font);
          end;
          Inc(CountObjects);
        end;
      end;
    end;
    FPanel.DeleteConnections;

    // read Comments
    for var I := 0 to Sections.Count - 1 do
    begin
      if Pos('Comment: ', Sections[I]) = 1 then
      begin
        Section := Sections[I];
        Num := FBoxNames.IndexOf(Section);
        if Num = -1 then
        begin
          CommentBox := TRtfdCommentBox.Create(FPanel, Section, FFrame,
            viPublic, HANDLESIZE);
          FBoxNames.AddObject(Section, CommentBox);
          FPanel.AddManagedObject(CommentBox);
          Num := FBoxNames.IndexOf(Section);
        end;
        if Num > -1 then
        begin
          Box := FBoxNames.Objects[Num] as TRtfdBox;
          Box.Left := PPIScale(Ini.ReadInteger(Section, 'X', Box.Left));
          Box.Top := PPIScale(Ini.ReadInteger(Section, 'Y', Box.Top));
          Box.Width := PPIScale(Ini.ReadInteger(Section, 'W', Box.Width));
          Box.Height := PPIScale(Ini.ReadInteger(Section, 'H', Box.Height));
          Box.Font.Assign(Font);
          Section := Ini.ReadString(Section, 'Comment', '');
          (Box as TRtfdCommentBox).TrMemo.Text :=
            myStringReplace(Section, '_;_', #13#10);
        end;
      end;
    end;
    FPanel.DeleteConnections;
    AllBoxes := FPanel.GetManagedObjects;

    Section := 'Connections';
    Int := 0;
    repeat
      CName := Ini.ReadString(Section, 'V' + IntToStr(Int), '');
      if CName <> '' then
      begin
        Box1 := nil;
        Box2 := nil;
        StringList := Split('#', CName);
        B1Name := Trim(StringList[0]);
        B2Name := Trim(StringList[1]);
        Attributes.ArrowStyle := StringToArrowStyle(StringList[2]);
        Attributes.MultiplicityA := UnHideCrLf(StringList[3]);
        Attributes.Relation := StringList[4];
        Attributes.MultiplicityB := UnHideCrLf(StringList[5]);
        Attributes.RecursivCorner := StrToInt(StringList[6]);
        Attributes.IsTurned := StrToBool(StringList[7]);
        Attributes.IsEdited := StrToBool(StringList[8]);
        Attributes.RoleA := UnHideCrLf(StringList[9]);
        Attributes.RoleB := UnHideCrLf(StringList[10]);
        Attributes.ReadingOrderA := StrToBool(StringList[11]);
        Attributes.ReadingOrderB := StrToBool(StringList[12]);
        for Num := 0 to AllBoxes.Count - 1 do
        begin
          Box := TRtfdBox(AllBoxes[Num]);
          if Box.Entity.Fullname = B1Name then
            Box1 := Box;
          if Box.Entity.Fullname = B2Name then
            Box2 := Box;
        end;
        FPanel.ConnectObjects(Box1, Box2, Attributes);
        FreeAndNil(StringList);
      end;
      Inc(Int);
    until CName = '';
    FreeAndNil(AllBoxes);
    if GuiPyOptions.RelationshipAttributesBold then
      ShowRelationshipAttributesBold;

    FPanel.SetConnections(ShowConnections);
    if CountObjects = 0 then
      SetShowObjectDiagram(False)
    else
      SetShowObjectDiagram(ShowObjectDiagram);
    FLivingObjects.makeAllObjects;
    UpdateAllObjects;

    // read interactive lines
    StringList := TStringList.Create;
    Ini.ReadSectionValues('Interactive', StringList);
    for var I := 0 to StringList.Count - 1 do
    begin
      Section := StringList[I];
      Posi := Pos('=', Section);
      Delete(Section, 1, Posi);
      StringList[I] := Section;
    end;
    FUMLForm.InteractiveLines := StringList;
    FreeAndNil(StringList);
  finally
    FreeAndNil(Ini);
    FreeAndNil(Files);
    FreeAndNil(Attributes);
    FreeAndNil(Sections);
  end;
  FPanel.RecalcSize;
  FPanel.IsModified := False;
  FPanel.ShowAll;
  if FPanel.CanFocus then
    FPanel.SetFocus;
end;

procedure TRtfdDiagram.DoLayout;
begin
  if FBoxNames.Count > 0 then
  begin
    FPanel.Hide;
    var
    Layout := TSugiyamaLayout.Create(FPanel.GetManagedObjects,
      FPanel.GetConnections);
    try
      Layout.Execute;
    finally
      FPanel.Show;
      FreeAndNil(Layout);
    end;
    FPanel.IsModified := True;
    FPanel.RecalcSize;
    FPanel.ShowAll;
  end;
end;

function TRtfdDiagram.GetBox(Typ: string): TRtfdBox;
var
  Int: Integer;
begin
  Typ := WithoutGeneric(Typ);
  Int := 0;
  while Int < FBoxNames.Count do
  begin
    if Typ = WithoutGeneric(FBoxNames[Int]) then
      Break;
    Inc(Int);
  end;
  if Int = FBoxNames.Count then
    Result := nil
  else
    Result := FBoxNames.Objects[Int] as TRtfdBox;
end;

procedure TRtfdDiagram.SetVisibilityFilter(const Value: TVisibility);
var
  Box: TRtfdBox;
  Controls: TList;
begin
  if FPanel.CountSelectedControls > 0 then
    Controls := FPanel.GetSelectedControls
  else
    Controls := FPanel.GetManagedObjects;
  FPanel.Hide;
  try
    for var I := 0 to Controls.Count - 1 do
      if TObject(Controls[I]) is TRtfdBox then
      begin
        Box := TObject(Controls[I]) as TRtfdBox;
        if Box.MinVisibility <> Value then
        begin
          Box.MinVisibility := Value;
          FPanel.IsModified := True;
        end;
      end;
  finally
    FreeAndNil(Controls);
  end;
  FPanel.RecalcSize;
  FPanel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetShowView(Value: Integer);
var
  Objs: Integer;
  Objects: TList;
  Box: TRtfdBox;
begin
  Objects := FPanel.GetManagedObjects;
  FPanel.Hide;
  try
    Objs := 0;
    for var I := 0 to Objects.Count - 1 do
      if TObject(Objects[I]) is TRtfdObject then
        Inc(Objs);
    if (Objs = 0) and (Value = 1) then
      Value := 2;
    for var I := 0 to Objects.Count - 1 do
    begin
      Box := TObject(Objects[I]) as TRtfdBox;
      case Value of
        0:
          Box.MinVisibility := TVisibility(0);
        1:
          if Box is TRtfdClass then
            Box.MinVisibility := TVisibility(3)
          else
            Box.MinVisibility := TVisibility(0);
        2:
          Box.MinVisibility := TVisibility(3);
      end;
    end;
  finally
    FreeAndNil(Objects);
  end;
  FPanel.IsModified := True;
  FPanel.RecalcSize;
  FPanel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetShowParameter(const Value: Integer);
var
  Objects: TList;
  Box: TRtfdBox;
begin
  if FPanel.CountSelectedControls > 0 then
    Objects := FPanel.GetSelectedControls
  else
    Objects := FPanel.GetManagedObjects;
  FPanel.Hide;
  try
    for var I := 0 to Objects.Count - 1 do
    begin
      Box := TObject(Objects[I]) as TRtfdBox;
      if Box.ShowParameter <> Value then
      begin
        Box.ShowParameter := Value;
        FPanel.IsModified := True;
      end;
    end;
  finally
    FreeAndNil(Objects);
  end;
  FPanel.RecalcSize;
  FPanel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetSortOrder(const Value: Integer);
var
  Objects: TList;
  Box: TRtfdBox;
begin
  if FPanel.CountSelectedControls > 0 then
    Objects := FPanel.GetSelectedControls
  else
    Objects := FPanel.GetManagedObjects;
  FPanel.Hide;
  try
    for var I := 0 to Objects.Count - 1 do
    begin
      Box := TObject(Objects[I]) as TRtfdBox;
      if Box.SortOrder <> Value then
      begin
        Box.SortOrder := Value;
        FPanel.IsModified := True;
      end;
    end;
  finally
    FreeAndNil(Objects);
  end;
  FPanel.RecalcSize;
  FPanel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetShowIcons(const Value: Integer);
var
  Objects: TList;
  Box: TRtfdBox;
begin
  if FPanel.CountSelectedControls > 0 then
    Objects := FPanel.GetSelectedControls
  else
    Objects := FPanel.GetManagedObjects;
  FPanel.Hide;
  try
    for var I := 0 to Objects.Count - 1 do
    begin
      Box := TObject(Objects[I]) as TRtfdBox;
      if (Box is TRtfdObject) and GuiPyOptions.ObjectsWithoutVisibility then
        Continue;
      if Box.ShowIcons <> Value then
      begin
        Box.ShowIcons := Value;
        FPanel.IsModified := True;
      end;
    end;
  finally
    FreeAndNil(Objects);
  end;
  FPanel.RecalcSize;
  FPanel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetFont(const AFont: TFont);
var
  Objects: TList;
  Box: TRtfdBox;
begin
  inherited;
  Objects := FPanel.GetManagedObjects;
  try
    for var I := 0 to Objects.Count - 1 do
    begin
      Box := TObject(Objects[I]) as TRtfdBox;
      if Assigned(Box) and Assigned(Box.Font) then
        Box.Font.Assign(AFont);
    end;
  finally
    FreeAndNil(Objects);
  end;
  FPanel.Font.Assign(AFont);
end;

procedure TRtfdDiagram.GetDiagramSize(var Width, Height: Integer);
begin
  FPanel.GetDiagramSize(Width, Height);
end;

// Returns list with str = 'x1,y1,x2,y2', obj = modelentity
function TRtfdDiagram.GetClickAreas: TStringList;
begin
  Result := TStringList.Create;
  for var I := 0 to FBoxNames.Count - 1 do
  begin
    var
    Box := FBoxNames.Objects[I] as TRtfdBox;
    var
    Size := IntToStr(Box.Left) + ',' + IntToStr(Box.Top) + ',' +
      IntToStr(Box.Left + Box.Width) + ',' + IntToStr(Box.Top + Box.Height);
    Result.AddObject(Size, Box.Entity);
  end;
end;

procedure TRtfdDiagram.ClassEditSelectedDiagramElementsControl(Sender: TObject);
var
  Pathname: string;
  Box: TRtfdBox;
  Editor: IEditor;
  AFile: IFile;
begin
  LockFormUpdate(PyIDEMainForm);
  Box := (Sender as TRtfdBox);
  if (Box is TRtfdClass) and Assigned(GetBox(Box.Entity.Fullname)) then
  begin
    AFile := GI_PyIDEServices.GetActiveFile;
    Pathname := ChangeFileExt(Box.GetPathname, '.py');
    Editor := PyIDEMainForm.DoOpenAsEditor(Pathname);
    if Assigned(Editor) then
    begin
      if Editor.Modified then
        (Editor.Form as TFileForm).DoSave;
      if Assigned(AFile) and (AFile.FileKind = fkUML) then
        PyIDEMainForm.PrepareClassEdit(Editor, 'Edit', TFUMLForm(AFile.Form));
    end;
    AFile.Activate;
  end;
  FPanel.ClearSelection;
  UnlockFormUpdate(PyIDEMainForm);
end;

procedure TRtfdDiagram.ClassEditSelectedDiagramElements;
var
  Control: TControl;
begin
  Control := FPanel.GetFirstSelected;
  if not Assigned(Control) then
    Control := FPanel.GetFirstManaged;
  if Assigned(Control) then
    ClassEditSelectedDiagramElementsControl(Control);
end;

procedure TRtfdDiagram.SourceEditSelectedDiagramElements(Control: TControl);
var
  Filename: string;
begin
  FPanel.ClearSelection;
  if Assigned(Control) and (Control is TRtfdBox) then
  begin
    Filename := (Control as TRtfdBox).GetPathname;
    if FileExists(Filename) then
      PyIDEMainForm.DoOpen(Filename);
  end;
end;

procedure TRtfdDiagram.DeleteSelectedControls(Sender: TObject);
var
  Control: TControl;
  ObjectList: TObjectList;
  Box: TRtfdBox;
  UnitPackage: TUnitPackage;
  Num: Integer;
  KIdx: string;
  AObject: TObject;

  function CountClassesWith(const AClassname: string): Integer;
  var
    Control: TControl;
    ObjectList: TList;
    Box: TRtfdBox;
    Name: string;
  begin
    Result := 0;
    ObjectList := FPanel.GetManagedObjects;
    for var I := 0 to ObjectList.Count - 1 do
    begin
      Control := TControl(ObjectList[I]);
      if Control is TRtfdBox then
      begin
        Box := Control as TRtfdBox;
        if Control is TRtfdClass then
        begin
          Name := Box.Entity.Name;
          Delete(Name, 1, LastDelimiter('.', Name));
          if AClassname = Name then
            Inc(Result);
        end;
      end;
    end;
    FreeAndNil(ObjectList);
  end;

begin
  ObjectList := FPanel.GetSelectedControls;
  try
    for var I := 0 to ObjectList.Count - 1 do
    begin
      Control := ObjectList[I] as TControl;
      if Control is TRtfdBox then
      begin
        Box := Control as TRtfdBox;
        if Control is TRtfdClass then
        begin
          Box.Entity.IsVisible := False;
          Num := FBoxNames.IndexOf(Box.Entity.Fullname);
          if Num > -1 then
          begin
            if Assigned(FBoxNames.Objects[Num]) then
            begin
              AObject := FBoxNames.Objects[Num];
              FreeAndNil(AObject);
            end;
            FBoxNames.Delete(Num);
          end;
        end
        else if (Control is TRtfdObject) then
        begin
          KIdx := (Control as TRtfdObject).Entity.Name;
          ShowObjectDeleted('Actor', KIdx);
          Num := FBoxNames.IndexOf(KIdx);
          if Num > -1 then
          begin
            if Assigned(FBoxNames.Objects[Num]) then
            begin
              AObject := FBoxNames.Objects[Num];
              FreeAndNil(AObject);
            end;
            FBoxNames.Delete(Num);
          end;
          if FLivingObjects.ObjectExists(KIdx) then
          begin
            GI_PyControl.ActiveInterpreter.RunSource('del ' + KIdx,
              '<interactive input>');
            FLivingObjects.DeleteObject(KIdx);
          end;
          UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
          UnitPackage.DeleteObject(KIdx); // diagram-level
        end
        else if (Control is TRtfdCommentBox) then
        begin
          KIdx := (Control as TRtfdCommentBox).Entity.Name;
          Num := FBoxNames.IndexOf(KIdx);
          if Num > -1 then
          begin
            if Assigned(FBoxNames.Objects[Num]) then
            begin
              AObject := FBoxNames.Objects[Num];
              FreeAndNil(AObject);
            end;
            FBoxNames.Delete(Num);
          end;
        end;
      end;
    end;
  finally
    FPanel.DeleteSelectedControls;
    FreeAndNil(ObjectList);
  end;
  ResolveObjectAssociations;
end;

procedure TRtfdDiagram.DeleteSelectedControlsAndRefresh;
begin
  LockFormUpdate(FUMLForm);
  DeleteSelectedControls(nil);
  FUMLForm.SaveAndReload;
  FUMLForm.CreateTVFileStructure;
  UnlockFormUpdate(FUMLForm);
end;

procedure TRtfdDiagram.UnSelectAllElements;
begin
  if Assigned(FPanel) then
    FPanel.ClearSelection(False);
end;

procedure TRtfdDiagram.CurrentEntityChanged;
var
  ModelEntity: TModelEntity;
begin
  inherited;

  ModelEntity := CurrentEntity;
  while Assigned(ModelEntity) and (not(ModelEntity is TAbstractPackage)) do
    ModelEntity := ModelEntity.Owner;

  if Assigned(ModelEntity) and (ModelEntity <> Package) then
  begin
    Package := ModelEntity as TAbstractPackage;
    InitFromModel;
  end;

  if CurrentEntity is TClass then
    ScreenCenterEntity(CurrentEntity);
end;

function TRtfdDiagram.GetSelectedRect: TRect;
begin
  Result := FPanel.GetSelectedRect;
end;

procedure TRtfdDiagram.ScreenCenterEntity(ModelEntity: TModelEntity);
begin
  for var I := 0 to FBoxNames.Count - 1 do
    if TRtfdBox(FBoxNames.Objects[I]).Entity = ModelEntity then
    begin
      var
      Box := TRtfdBox(FBoxNames.Objects[I]);
      FFrame.ScrollBox.ScrollInView(Box);
      Break;
    end;
end;

procedure TRtfdDiagram.SetShowObjectDiagram(const Value: Boolean);
begin
  FUMLForm.TBObjectDiagram.Down := Value;
  inherited SetShowObjectDiagram(Value);
  FPanel.SetShowObjectDiagram(Value);
end;

procedure TRtfdDiagram.RefreshDiagram;
begin
  if not PanelIsLocked then
    for var I := 0 to FBoxNames.Count - 1 do
      (FBoxNames.Objects[I] as TRtfdBox).RefreshEntities;
  FPanel.RecalcSize;
  FPanel.ShowAll;
  FPanel.IsModified := True;
end;

function TRtfdDiagram.HasAInvalidClass: Boolean;
begin
  for var I := 0 to FBoxNames.Count - 1 do
    if (FBoxNames.Objects[I] is TRtfdClass) then
    begin
      var
      Path := (FBoxNames.Objects[I] as TRtfdClass).GetPathname;
      if not PyIDEMainForm.IsAValidClass(Path) then
        Exit(True);
    end;
  Result := False;
end;

procedure TRtfdDiagram.RecalcPanelSize;
begin
  FPanel.RecalcSize;
end;

procedure TRtfdDiagram.SetShowConnections(const Value: Integer);
begin
  if Value <> ShowConnections then
  begin
    FPanel.IsModified := True;
    inherited SetShowConnections(Value);
    FPanel.SetConnections(Value);
  end;
  inherited;
end;

procedure TRtfdDiagram.SelectAssociation;
begin
  FPanel.SelectAssociation;
end;

function TRtfdDiagram.GetPanel: TCustomPanel;
begin
  Result := FPanel;
end;

procedure TRtfdDiagram.Retranslate;
begin
  FFrame.Retranslate;
end;

procedure TRtfdDiagram.Run(Control: TControl);
begin
  if Assigned(GetBox((Control as TRtfdBox).Entity.Fullname)) then
    CommandsDataModule.actRunExecute(nil);
  FPanel.ClearSelection;
end;

function TRtfdDiagram.GetDebug: TStringList;
var
  ObjectList: TList;
  Box: TRtfdBox;
begin
  try
    ObjectList := FPanel.GetManagedObjects;
    Result := TStringList.Create;
    for var I := 0 to ObjectList.Count - 1 do
    begin
      Box := TRtfdBox(ObjectList[I]);
      Result.Add(Box.Entity.Fullname);
    end;
    Result.Add('');
  finally
    FreeAndNil(ObjectList);
  end;
end;

procedure TRtfdDiagram.ShowInheritedMethodsFromSystemClasses(Control: TControl;
  ShowOrHide: Boolean);
begin
  if (Control is TRtfdBox) then
    (Control as TRtfdBox).ShowInherited := ShowOrHide;
  FPanel.ClearSelection;
end;

procedure TRtfdDiagram.CollectClasses;
var
  Pathname, Boxname, AClassname: string;
  SLFiles: TStringList;
begin
  SLFiles := TStringList.Create;
  for var I := FBoxNames.Count - 1 downto 0 do
  begin
    Boxname := (FBoxNames.Objects[I] as TRtfdBox).Entity.Name;
    if FBoxNames.Objects[I] is TRtfdObject then
    begin
      AClassname := FLivingObjects.getClassnameOfObject(Boxname);
      if not FLivingObjects.ClassExists(AClassname) then
        FLivingObjects.LoadClassOfObject(Boxname, AClassname);
    end
    else if not FLivingObjects.ClassExists(Boxname) then
    begin
      if (FBoxNames.Objects[I] is TRtfdClass) then
        Pathname := ((FBoxNames.Objects[I] as TRtfdBox)
          .Entity as TClass).Pathname;
      if SLFiles.IndexOf(Pathname) = -1 then
      begin
        PyIDEMainForm.ImportModule(Pathname);
        SLFiles.Add(Pathname);
      end;
    end;
  end;
  FreeAndNil(SLFiles);
  Sleep(100);
end;

procedure TRtfdDiagram.ShowNewObject(const Objectname: string;
  AClass: TClass = nil);
var
  UnitPackage: TUnitPackage;
  AModelObject: TObjekt;
  Box1, Box2: TRtfdBox;
  Address, AClassname: string;
begin
  UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
  if not Assigned(UnitPackage) then
    UnitPackage := Model.ModelRoot.AddUnit('Default');
  if not Assigned(AClass) then
  begin
    Address := FLivingObjects.getHexAddressFromName(Objectname);
    AClassname := FLivingObjects.getClassnameFromAddress(Address);
    AClass := TClass(FindClassifier(AClassname));
  end;
  AModelObject := UnitPackage.AddObject(Objectname, AClass);
  // model-level -> show object
  Box1 := GetBox(AClass.Name);
  Box2 := GetBox(AModelObject.Fullname);
  if Assigned(Box1) and Assigned(Box2) then
  begin
    Box2.Top := Box1.Top + Box1.Height + 50 + Random(30) - 30;
    Box2.Left := Max(Box1.Left + (Box1.Width - Box2.Width) div 2 + Random(200)
      - 100, 0);
    FPanel.ConnectObjects(Box2, Box1, asInstanceOf);
  end
  else if Assigned(Box2) then
  begin
    Box2.Top := Box2.Top + Random(30) - 30;
    Box2.Left := Box2.Left + Random(30) - 30;
  end;
  Box2.Font.Assign(Font);
  ShowAttributes(Objectname, AClass, AModelObject);
  if not Assigned(Box2) and Assigned(AModelObject) then
    AddBox(AModelObject);
end;

procedure TRtfdDiagram.CreateObjectForSelectedClass(Sender: TObject);
var
  Caption, Title, ParamName, ParamValue, StringList, Str1: string;
  Posi, Posi1, Posi2: Integer;
  Control: TControl;
  AClass: TClass;
  Command: string;
  TheClassname: string;
  TheObjectname: string;
  TheObjectnameNew: string;
  ParameterAsString: string;
  Parameter: TStringList;
  ParamValues: TStringList;
  MenuItem: TSpTBXItem;
begin
  Control := FindVCLWindow(FFrame.PopMenuClass.PopupPoint);
  if Assigned(Control) and (Control is TRtfdClass) then
  begin
    FPanel.ClearSelection;
    AClass := (Control as TRtfdClass).Entity as TClass;
    TheClassname := AClass.Name;
    CollectClasses;
    // get parameters for constructor
    Parameter := TStringList.Create;
    ParamValues := TStringList.Create;
    MenuItem := (Sender as TSpTBXItem);
    StringList := myStringReplace(MenuItem.Caption, ' = ', Chr(4));
    if Assigned(MenuItem.Parent) then
    begin
      Str1 := MenuItem.Parent.Caption;
      Posi := Pos('Inherited from ', Str1);
      if Posi > 0 then
        TheClassname := Copy(Str1, 16, Length(Str1));
    end;

    Posi := FFullParameters.IndexOfName(StringList);
    StringList := FFullParameters.ValueFromIndex[Posi];
    Posi := Pos('(', StringList);
    Delete(StringList, 1, Posi);

    while StringList <> ')' do
    begin
      Posi1 := Pos(Chr(4), StringList);
      ParamName := Copy(StringList, 1, Posi1 - 1);
      Posi2 := Pos(Chr(5), StringList);
      ParamValue := Copy(StringList, Posi1 + 1, Posi2 - Posi1 - 1);
      Delete(StringList, 1, Posi2);
      Parameter.Add(ParamName);
      ParamValues.Add(ParamValue);
    end;

    if Parameter.Count = 0 then
    begin
      Title := _('Attribute') + #13#10 + _('Value');
      Caption := _('Name of object');
    end
    else
    begin
      Title := _('Parameter') + #13#10 + _('Value');
      Caption := _('Parameter for constructor') + ' ' + TheClassname + '(...)';
    end;
    TheObjectname := FLivingObjects.getNewObjectName(TheClassname);
    TheObjectnameNew := '';

    if (Parameter.Count = 0) or EditClass(Caption, Title, TheObjectname,
      TheObjectnameNew, Control, Parameter) then
    begin
      if (TheObjectnameNew <> '') and not FLivingObjects.ObjectExists
        (TheObjectnameNew) then
        TheObjectname := TheObjectnameNew;
      if FLivingObjects.ClassExists(AClass.Name) then
      begin
        ParameterAsString := GetParameterAsString(Parameter, ParamValues);
        AddToInteractive(TheObjectname + ' = ' + AClass.Name + '(' +
          ParameterAsString + ')');
        FCreateObjectObjectname := TheObjectname;
        FCreateObjectParameter := ParameterAsString;
        FCreateObjectClass := AClass;
        VariablesWindow.OnNotify := CreateObjectExecuted;
        Command := TheObjectname + ' = ' + AClass.Name + '(' +
          ParameterAsString + ')';
        // executed in a thread
        FLivingObjects.Execute(Command);
      end;
    end;
  end;
  FreeAndNil(Parameter);
  FreeAndNil(ParamValues);
end;

procedure TRtfdDiagram.CreateObjectExecuted(Sender: TObject);
begin
  VariablesWindow.OnNotify := nil;
  LockFormUpdate(FUMLForm);
  Screen.Cursor := crHourGlass;
  try
    FLivingObjects.makeAllObjects;
    if FLivingObjects.InsertObject(FCreateObjectObjectname) then
    begin
      ShowMethodEntered('<init>', 'Actor', FCreateObjectObjectname,
        FCreateObjectParameter);
      ShowNewObject(FCreateObjectObjectname, FCreateObjectClass);
      if GuiPyOptions.ShowAllNewObjects then
        ShowAllNewObjectsString(FCreateObjectObjectname)
      else
      begin
        UpdateAllObjects;
        ResolveObjectAssociations;
        FPanel.RecalcSize;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    UnlockFormUpdate(FUMLForm);
  end;
end;

function TRtfdDiagram.GetInternName(AClass: TClass; const Name: string;
  Visibility: TVisibility): string;

  function getAncestorInternName(AClass: TClass; const Name: string): string;
  begin
    Result := '';
    if AClass.AncestorsCount > 0 then
      Result := getAncestorInternName(AClass.Ancestor[0], Name);
    if Result = '' then
    begin
      var
      Ami := TModelIterator.Create(AClass.GetAttributes);
      while Ami.HasNext do
      begin // we have a model from sourecode
        var
        Attribute := Ami.Next;
        if Attribute.Name = Name then
          Exit('_' + AClass.Name + '__' + Name);
      end;
    end;
  end;

begin
  Result := '';
  if Visibility <> viPrivate then
    Result := VisibilityAsString(Visibility) + Name
  else
  begin
    if AClass.AncestorsCount > 0 then
      Result := getAncestorInternName(AClass.Ancestor[0], Name);
    if Result = '' then // we use live values from python
      Result := '_' + AClass.Name + '__' + Name;
  end;
end;

procedure TRtfdDiagram.ShowAttributes(const Objectname: string; AClass: TClass;
  AModelObject: TObjekt);
// just create attributes, they will be shown by UpdateAllObjects

var
  SLObject: TStringList;
  AddedAttributes: TStringList;

  procedure ShowAttributesOfClass1(AClass: TClass);
  var
    ModelAttribute: TAttribute;
    SL1: TStringList;
    Ami: IModelIterator;
    ModelEntity: TModelEntity;
    Box: TRtfdBox;
    Posi: Integer;
    IName: string;
    SuperClass: TClass;
  begin
    // Add from knowledge about model
    if AClass.AncestorsCount > 0 then
    begin
      SuperClass := AClass.Ancestor[0];
      ShowAttributesOfClass1(SuperClass);
    end;
    Box := GetBox(Objectname);
    // get names in visibility order like in TRtfdClass.RefreshEntities
    if Assigned(Box) then
      if Box.MinVisibility > Low(TVisibility) then
        Ami := TModelIterator.Create(AClass.GetAttributes, TAttribute,
          Box.MinVisibility, TIteratorOrder(Box.SortOrder))
      else
        Ami := TModelIterator.Create(AClass.GetAttributes,
          TIteratorOrder(Box.SortOrder))
    else
      Ami := TModelIterator.Create(AClass.GetAttributes,
        TIteratorOrder(GuiPyOptions.DiSortOrder));

    // Attributes
    while Ami.HasNext do
    begin
      ModelEntity := Ami.Next;
      IName := GetInternName(AClass, ModelEntity.Name, ModelEntity.Visibility);
      Posi := SLObject.IndexOfName(IName);
      if { (Posi > -1) and } not ModelEntity.Static then
      begin
        SL1 := Split('|', SLObject.ValueFromIndex[Posi]);
        if SL1.Count = 2 then
        begin // object has an attribute
          ModelAttribute := AModelObject.AddAttribute(ModelEntity.Name);
          // AddAttribut can raise an exception
          AddedAttributes.Add(IName);
          ModelAttribute.Visibility := ModelEntity.Visibility;
          ModelAttribute.Static := ModelEntity.Static;
          ModelAttribute.IsFinal := ModelEntity.IsFinal;
          if ModelAttribute.IsFinal then
            AModelObject.HasFinal := True;
          ModelAttribute.Value := SL1[0];
          ModelAttribute.TypeClassifier := FindClassifier(SL1[1]);
          if ModelAttribute.TypeClassifier = nil then
          begin
            ModelAttribute.TypeClassifier := TClassifier.Create(nil);
            ModelAttribute.TypeClassifier.Name := SL1[1];
          end;
        end;
        FreeAndNil(SL1);
      end;
    end;
  end;

  procedure ShowAttributesOfClass2(AClass: TClass);
  var
    ModelAttribute: TAttribute;
    SL1: TStringList;
    IName: string;
    Vis: TVisibility;
  begin
    // Add from knowldege about LivingObjects
    for var I := 0 to SLObject.Count - 1 do
    begin
      IName := SLObject.KeyNames[I];
      if AddedAttributes.IndexOf(IName) = -1 then
      begin
        SL1 := Split('|', SLObject.ValueFromIndex[I]);
        if SL1.Count = 2 then
        begin // object has an attribute
          GetVisFromName(IName, Vis);
          ModelAttribute := AModelObject.AddAttribute(IName);
          ModelAttribute.Visibility := Vis;
          ModelAttribute.Value := SL1[0];
          ModelAttribute.TypeClassifier := FindClassifier(SL1[1]);
          if ModelAttribute.TypeClassifier = nil then
          begin
            ModelAttribute.TypeClassifier := TClassifier.Create(nil);
            ModelAttribute.TypeClassifier.Name := SL1[1];
          end;
        end;
        FreeAndNil(SL1);
      end;
    end;
  end;

begin
  AModelObject.Locked := True;
  AddedAttributes := TStringList.Create;
  SLObject := FLivingObjects.getObjectMembers(Objectname);
  AModelObject.SetCapacity(SLObject.Count);
  ShowAttributesOfClass1(AClass);
  ShowAttributesOfClass2(AClass);
  FreeAndNil(SLObject);
  FreeAndNil(AddedAttributes);
  AModelObject.Locked := False;
end;

function TRtfdDiagram.StrToPythonValue(const Value: string): string;
begin
  Result := Trim(Value);
  if not((Result <> '') and (Pos(Result[1], '[({''') > 0) or isNumber(Result) or
    isBool(Result) or (Result = 'None') or FLivingObjects.ObjectExists(Result))
  then
    Result := asString(Result);
end;

function TRtfdDiagram.StrAndTypeToPythonValue(const Value, PValue: string): string;
begin
  Result := StrToPythonValue(Value);
  if (Result = asString('')) and (PValue <> '') then
    Result := '';
end;

function TRtfdDiagram.GetParameterAsString(Parameter,
  ParamValues: TStringList): string;
var
  Str, Str1, Value: string;
begin
  Str := '';
  var
  AllParameters := True;
  for var I := 0 to Parameter.Count - 1 do
  begin
    Value := ParamValues[I];
    Str1 := StrAndTypeToPythonValue(Parameter.ValueFromIndex[I], Value);
    if AllParameters then
      if Str1 <> '' then
        Str := Str + Str1 + ', '
      else
        AllParameters := False
    else if Str1 <> '' then
      Str := Str + Parameter.KeyNames[I] + '=' + Str1 + ', ';
  end;
  Result := Copy(Str, 1, Length(Str) - 2);
end;

procedure TRtfdDiagram.SetAttributeValues(ModelClass: TClass;
  const Objectname: string; Attributes: TStringList);
var
  OldAttributes: TStringList;

  procedure DoSetAttributeValues(AClass: TClass);
  var
    NewValue: string;
  begin
    if AClass.AncestorsCount > 0 then
      DoSetAttributeValues(AClass.Ancestor[0]);
    for var I := 0 to Attributes.Count - 1 do
    begin
      NewValue := StrToPythonValue(Attributes.ValueFromIndex[I]);
      if NewValue <> OldAttributes.ValueFromIndex[I] then
        GI_PyControl.ActiveInterpreter.RunSource
          (Objectname + '.' + OldAttributes.KeyNames[I] + ' = ' + NewValue,
          '<interactive input>');
    end;
  end;

begin
  OldAttributes := FLivingObjects.getObjectAttributeValues(Objectname);
  for var I := OldAttributes.Count - 1 downto 0 do
    if not(GuiPyOptions.PrivateAttributEditable or
      (Pos('__', OldAttributes.KeyNames[I]) = 0)) then
      OldAttributes.Delete(I);
  DoSetAttributeValues(ModelClass);
  FreeAndNil(OldAttributes);
end;

procedure TRtfdDiagram.CallMethodForObject(Sender: TObject);
var
  Control: TControl;
begin
  Control := FindVCLWindow(FFrame.PopMenuObject.PopupPoint);
  CallMethod(Control, Sender);
end;

procedure TRtfdDiagram.CallMethodForClass(Sender: TObject);
var
  Control: TControl;
begin
  Control := FindVCLWindow(FFrame.PopMenuClass.PopupPoint);
  CallMethod(Control, Sender);
end;

procedure TRtfdDiagram.CallMethod(Control: TControl; Sender: TObject);
var
  Caption, Title, ParamName, ParamValue, Str: string;
  Posi, Posi1, Posi2, InheritedLevel: Integer;
  TheClassname: string;
  ParameterAsString: string;
  Parameter: TStringList;
  ParamValues: TStringList;
  AViewClass: TRtfdClass;
  ModelClass: TClass;
  MethodCall: string;
begin
  try
    if Assigned(Control) and ((Control is TRtfdObject) or
      (Control is TRtfdClass)) then
    begin
      CollectClasses;
      LockFormUpdate(FUMLForm);
      try
        FPanel.ClearSelection;
        if Control is TRtfdObject then
          FCallMethodObjectname := (Control as TRtfdObject).Entity.Name
        else
          FCallMethodObjectname := '';
        InheritedLevel := (Sender as TSpTBXItem).Tag;
        // get parameters for method call
        Parameter := TStringList.Create;
        ParamValues := TStringList.Create;

        Str := myStringReplace((Sender as TSpTBXItem).Caption, ' = ', Chr(4));

        Posi := FFullParameters.IndexOfName(Str);
        Str := FFullParameters.ValueFromIndex[Posi];
        Posi := Pos('(', Str);
        FCallMethodMethodname := GetShortType(Copy(Str, 1, Posi - 1));
        Delete(Str, 1, Posi);
        Str := Trim(Str);

        while Str <> ')' do
        begin
          Posi1 := Pos(Chr(4), Str);
          ParamName := Copy(Str, 1, Posi1 - 1);
          Posi2 := Pos(Chr(5), Str);
          ParamValue := Copy(Str, Posi1 + 1, Posi2 - Posi1 - 1);
          Delete(Str, 1, Posi2);
          Parameter.Add(ParamName);
          ParamValues.Add(ParamValue);
        end;
        Caption := _('Parameter for method call') + ' ' + FCallMethodMethodname
          + '(...)';
        Title := _('Parameter') + #13#10 + _('Value');
        // get parameter-values from user
        if (Parameter.Count = 0) or EditObjectOrParams(Caption, Title, Control,
          Parameter) then
        begin
          ParameterAsString := GetParameterAsString(Parameter, ParamValues);
          CollectClasses;
          // call the method
          if FCallMethodObjectname = '' then
          begin // static method of a class
            ModelClass := (Control as TRtfdClass).Entity as TClass;
            FCallMethodObjectname := ModelClass.GetTyp;
          end
          else
          begin // method of an object
            TheClassname := FLivingObjects.getClassnameOfObject
              (FCallMethodObjectname);
            // get model class for object to get the methods
            ModelClass := nil;
            AViewClass := GetBox(TheClassname) as TRtfdClass;
            if not Assigned(AViewClass) then
              AViewClass := GetBox(GetShortType(TheClassname)) as TRtfdClass;
            if Assigned(AViewClass) then
              ModelClass := (AViewClass.Entity as TClass);
            // model class from view class
            if not Assigned(ModelClass) then
              ModelClass := GetModelClass(TheClassname);
            // model class from model
            if not Assigned(ModelClass) or (ModelClass.Pathname = '') then
              ModelClass := CreateModelClass(TheClassname);
            // model class from python
          end;
          while Assigned(ModelClass) and (InheritedLevel > 0) do
          begin
            ModelClass := ModelClass.Ancestor[0]; // ToDo many ancestors
            Dec(InheritedLevel);
          end;
          FCallMethodFrom := FCallMethodObjectname;
          if (FCallMethodFrom = '') and Assigned(ModelClass) then
            FCallMethodFrom := ModelClass.Name;
          if ModelClass.OperationIsProperty(FCallMethodMethodname) then
            if Parameter.Count = 0 then
              MethodCall := FCallMethodObjectname + '.' + FCallMethodMethodname
            else
              MethodCall := FCallMethodObjectname + '.' + FCallMethodMethodname
                + ' = ' + ParameterAsString
          else
            MethodCall := FCallMethodObjectname + '.' + FCallMethodMethodname +
              '(' + ParameterAsString + ')';
          AddToInteractive(MethodCall);
          ShowMethodEntered(FCallMethodMethodname, 'Actor',
            FCallMethodObjectname, ParameterAsString);
          PythonIIForm.OnExecuted := CallMethodExecuted;
          GI_PyInterpreter.StartOutputMirror(TPath.Combine(GuiPyOptions.TempDir,
            'output.txt'), False);
          // execute within a thread
          FLivingObjects.Execute(MethodCall);
        end;
        FreeAndNil(Parameter);
        FreeAndNil(ParamValues);
      except
        on E: Exception do
          ErrorMsg('TRtfdDiagram.CallMethod: ' + E.Message);
      end;
    end;
  finally
    UnlockFormUpdate(FUMLForm);
  end;
end;

procedure TRtfdDiagram.CallMethodExecuted(Sender: TObject);
var
  StringList: TStringList;
begin
  PythonIIForm.OnExecuted := nil;
  GI_PyInterpreter.StopFileMirror;
  FLivingObjects.makeAllObjects;

  if GuiPyOptions.ShowAllNewObjects then
    ShowAllNewObjectsString(FCallMethodFrom)
  else
    UpdateAllObjects;
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(TPath.Combine(GuiPyOptions.TempDir, 'output.txt'));
    if StringList.Count > 0 then
      ShowMethodExited(FCallMethodMethodname, FCallMethodObjectname, 'Actor',
        StringList[0])
    else
      ShowMethodExited(FCallMethodMethodname, FCallMethodObjectname,
        'Actor', '');
  finally
    FreeAndNil(StringList);
  end;
end;

function TRtfdDiagram.CreateModelClass(const Typ: string): TClass;
var
  UnitPackage: TUnitPackage;
  AClass, AClass1: TClass;
  Operation: UModel.TOperation;
  SLMethods, SLParams: TStringList;
  Posi: Integer;
  Method, ParName, OpName, Params: string;
  Vis: TVisibility;
begin
  Result := nil;
  UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
  CollectClasses;
  if FLivingObjects.ClassExists(Typ) then
  begin
    AClass := UnitPackage.MakeClass(Typ, '');
    AClass.Importname := Typ;
    UnitPackage.AddClassWithoutShowing(AClass);

    // make operations
    SLMethods := FLivingObjects.getClassMethods(Typ); // static and not static
    try
      for var I := 0 to SLMethods.Count - 1 do
      begin
        Method := SLMethods[I];
        Posi := Pos(Chr(3), Method);
        OpName := Copy(Method, 1, Posi - 1);
        if OpName = '__init__' then
          Continue;
        Params := FLivingObjects.getSignature(Typ + '.' + OpName);
        Operation := AClass.AddOperationWithoutType('');
        GetVisFromName(OpName, Vis);
        Operation.Visibility := Vis;
        Operation.Name := OpName;
        Delete(Method, 1, Posi);
        if Method = 'function' then
          Operation.OperationType := otFunction
        else
          Operation.OperationType := otProcedure;
        Operation.Static := False;
        // Parameters
        Posi := Pos(' ->', Params);
        if Posi > 0 then
        begin
          AClass1 := UnitPackage.MakeClass(Copy(Params, Posi + 3,
            Length(Params)), '');
          if Assigned(AClass1) then
          begin
            Operation.ReturnValue := AClass1;
            UnitPackage.AddClassWithoutShowing(AClass1);
          end;
          Delete(Params, Posi, Length(Params));
        end;
        Params := Copy(Params, 2, Length(Params) - 2);
        SLParams := Split(',', Params);
        for var J := 0 to SLParams.Count - 1 do
        begin
          ParName := SLParams[J];
          Posi := Pos(':', ParName);
          if Posi > 0 then
            Delete(ParName, Posi, Length(ParName));
          ParName := Trim(ParName);
          if ParName <> '' then
            Operation.AddParameter(ParName);
        end;
        FreeAndNil(SLParams);
      end;
    finally
      FreeAndNil(SLMethods);
    end;
    // no attributes, because classes don't have them
    AClass.Pathname := FLivingObjects.getPathOf(Typ);
    Result := AClass;
  end;
end;

function TRtfdDiagram.PPIScale(ASize: Integer): Integer;
begin
  Result := MulDiv(ASize, FPPIControl.CurrentPPI, 96);
end;

function TRtfdDiagram.PPIUnScale(ASize: Integer): Integer;
begin
  Result := MulDiv(ASize, 96, FPPIControl.CurrentPPI);
end;

function TRtfdDiagram.FindClassifier(const CName: string): TClassifier;
var
  PName, ShortName: string;
  CacheI: Integer;
  AClass: TClass;
  TheClass: TModelEntityClass;

  function InLookInModel: TClassifier;
  var
    UnitPackage: TUnitPackage;
  begin
    Result := nil;
    if PName <> '' then
    begin // search in package
      UnitPackage := Model.ModelRoot.FindUnitPackage(PName);
      if Assigned(UnitPackage) then
        Result := UnitPackage.FindClassifier(ShortName, TheClass, True);
    end;
    if not Assigned(Result) then
    begin
      UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
      Result := UnitPackage.FindClassifier(ShortName, TheClass, True);
    end;
    if not Assigned(Result) then
    begin
      UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
      Result := UnitPackage.FindClassifier(CName, TheClass, True);
    end;
  end;

  function ExtractPackageName(const CName: string): string;
  begin
    var
    Int := LastDelimiter('.', CName);
    if Int = 0 then
      Result := ''
    else
      Result := Copy(CName, 1, Int - 1);
  end;

  function ExtractClassName(const CName: string): string;
  begin
    var
    Int := LastDelimiter('.', CName);
    if Int = 0 then
      Result := CName
    else
      Result := Copy(CName, Int + 1, 255);
    Result := WithoutArray(Result);
  end;

begin
  TheClass := nil;
  CacheI := Model.NameCache.IndexOf(CName);
  if (CacheI > -1) then
  begin
    Result := TClassifier(Model.NameCache.Objects[CacheI]);
    Exit;
  end;
  PName := ExtractPackageName(CName);
  ShortName := ExtractClassName(CName);
  Result := InLookInModel;

  if Assigned(Result) and (Pos('[]', CName) > 0) and (Result.Name <> CName) then
  begin
    if Result is TClass then
    begin
      AClass := TClass.Create(Result.Owner);
      AClass.Pathname := Result.Pathname;
      AClass.Importname := Result.Importname;
      AClass.Ancestor[0] := (Result as TClass).Ancestor[0]; // ToDo n ancestors
      AClass.Name := CName;
      AClass.Visibility := Result.Visibility;
      AClass.Static := Result.Static;
      Result := AClass;
    end;
    Model.NameCache.AddObject(CName, Result);
  end;

  if not Assigned(Result) then
  begin
    Result := Model.UnknownPackage.FindClassifier(CName, TClass, True);
    if not Assigned(Result) then
    begin
      Result := Model.UnknownPackage.MakeClass(CName, '');
      Model.UnknownPackage.AddClass(TClass(Result));
    end;
  end;
  if Assigned(Result) and (Pos('/', Result.Name) > 0) then
    Result.Name := myStringReplace(Result.Name, '/', '.');
end;

procedure TRtfdDiagram.EditObject(Control: TControl);
var
  Caption, Title, Objectname, Classname: string;
  Attributes: TStringList;
  ModelClass: TClass;
  UnitPackage: TUnitPackage;
begin
  if Assigned(Control) and (Control is TRtfdObject) then
  begin
    FPanel.ClearSelection;
    Objectname := (Control as TRtfdObject).Entity.Name;
    Classname := FLivingObjects.getClassnameOfObject(Objectname);
    UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
    ModelClass := UnitPackage.FindClassifier(Classname) as TClass;
    if FLivingObjects.ObjectExists(Objectname) and Assigned(ModelClass) then
    begin
      Attributes := FLivingObjects.getObjectAttributeValues(Objectname);
      for var I := Attributes.Count - 1 downto 0 do
        if GuiPyOptions.PrivateAttributEditable or
          (Pos('__', Attributes.KeyNames[I]) = 0) then
          Attributes[I] := WithoutVisibility(Attributes[I])
        else
          Attributes.Delete(I);
      Caption := _('Edit object') + ' ' + Objectname;
      Title := _('Attribute') + #13#10 + _('Value');
      if EditObjectOrParams(Caption, Title, Control, Attributes) then
      begin
        SetAttributeValues(ModelClass, Objectname, Attributes);
        FLivingObjects.makeAllObjects;
        UpdateAllObjects;
      end;
      FreeAndNil(Attributes);
    end;
  end;
end;

procedure TRtfdDiagram.UpdateAllObjects;
var
  UnitPackage: TUnitPackage;
  ModelClass: TClassifier;
  AModelObject: TObjekt;
  ModelAttribut: TAttribute;
  ModelClassAttribut: TAttribute;
  It1, It2: IModelIterator;
  ObjectList, SL_Attributes: TStringList;
  Value, Internname: string;

  function Shorten(const Value: string): string;
  var
    Posi: Integer;
  begin
    Result := Value;
    if Length(Value) > 100 then
    begin
      Posi := 100;
      while (Posi > 0) and (Value[Posi] <> ',') do
        Dec(Posi);
      if Posi = 0 then
        Posi := 96;
      Result := Copy(Value, 1, Posi + 1) + '...';
    end;
  end;

begin
  if Assigned(Model) and Assigned(Model.ModelRoot) then
    UnitPackage := Model.ModelRoot.FindUnitPackage('Default')
  else
    UnitPackage := nil;
  if not Assigned(UnitPackage) then
    Exit;
  ObjectList := UnitPackage.GetAllObjects;
  for var I := 0 to ObjectList.Count - 1 do
  begin
    if not FLivingObjects.ObjectExists(ObjectList[I]) then
      Continue;
    if Assigned(ObjectList.Objects[I]) and (ObjectList.Objects[I] is TObjekt)
    then
      AModelObject := ObjectList.Objects[I] as TObjekt
    else
      Continue;
    SL_Attributes := FLivingObjects.getObjectAttributeValues(ObjectList[I]);
    It1 := AModelObject.GetAttributes;
    while It1.HasNext do
    begin
      ModelAttribut := It1.Next as TAttribute;
      Internname := GetInternName(AModelObject.GetTyp, ModelAttribut.Name,
        ModelAttribut.Visibility);
      var
      J := SL_Attributes.IndexOfName(Internname);
      if J >= 0 then
        Value := Shorten(SL_Attributes.ValueFromIndex[J])
      else
        Value := '<error>';

      if ModelAttribut.Static then
      begin
        ModelClass := AModelObject.GetTyp;
        if Assigned(ModelClass) then
        begin
          It2 := ModelClass.GetAttributes;
          while It2.HasNext do
          begin
            ModelClassAttribut := It2.Next as TAttribute;
            if ModelClassAttribut.Name = ModelAttribut.Name then
            begin
              ModelClassAttribut.Value := Value;
              Break;
            end;
          end;
        end;
      end
      else
        ModelAttribut.Value := Value;
    end;
    FreeAndNil(SL_Attributes);
  end;
  FreeAndNil(ObjectList);
  RefreshDiagram;
end;

function TRtfdDiagram.InsertParameterNames(Names: string): string;
var
  Posi: Integer;
  Str1, Str2: string;
begin
  Posi := Pos('(', Names);
  Str1 := Copy(Names, 1, Posi);
  Delete(Names, 1, Posi);
  Names := myStringReplace(Names, ')', ',)');
  Posi := Pos(',', Names);
  while Posi > 0 do
  begin
    Str2 := Copy(Names, 1, Posi - 1);
    Delete(Names, 1, Posi);
    Str2 := GetShortTypeWith(Str2);
    Posi := Pos(',', Names);
    if Posi > 0 then
      Str1 := Str1 + Str2 + ', '
    else
      Str1 := Str1 + Str2 + ')';
  end;
  Result := Str1;
end;

procedure TRtfdDiagram.PopMenuClassPopup(Sender: TObject);
var
  Str1, Str2: string;
  MenuIndex, InheritedLevel, StartIndex, Num: Integer;
  ViewClass: TRtfdClass;
  ModelClass: TClass;
  Ite1: IModelIterator;
  Operation: UModel.TOperation;
  Attribute: UModel.TAttribute;
  InheritedMenu: TSpTBXItem;
  HasSourcecode: Boolean;
  Associations: TStringList;
  Connections: TStringList;
  SLSorted: TStringList;
  Box: TControl;
  HasInheritedSystemMethods: Boolean;

  procedure MakeOpenClassMenuItem(AClass: string; ImageIndex: Integer);
  begin
    if (FBoxNames.IndexOf(AClass) = -1) and FLivingObjects.ClassExists(AClass)
      and (FMenuClassFiles.IndexOfName(AClass) = -1) then
    begin
      var
      AMenuItem := TSpTBXItem.Create(FFrame.PopMenuClass);
      AMenuItem.Caption := WithoutGeneric(AClass);
      AMenuItem.OnClick := OpenClassOrInterface;
      AMenuItem.ImageIndex := ImageIndex;
      FFrame.MIClassPopupOpenClass.Add(AMenuItem);
      FMenuClassFiles.Add(AClass + '=' + FLivingObjects.getPathOf(AClass));
    end;
  end;

  procedure MakeConnectClassMenuItems;
  var
    MenuItem: TSpTBXItem;
    Connection: Char;
    Name: string;
  begin
    for var I := FBoxNames.Count - 1 downto 0 do
      if (FBoxNames.Objects[I] is TRtfdClass) then
        Connections.Add('Connection' + (FBoxNames.Objects[I] as TRtfdBox)
          .Entity.Fullname)
      else if (FBoxNames.Objects[I] is TRtfdCommentBox) then
        Connections.Add('K' + FBoxNames[I]);
    for var I := 0 to Connections.Count - 1 do
    begin
      Name := Connections[I];
      Connection := Name[1];
      Name := Copy(Name, 2, Length(Name));
      MenuItem := TSpTBXItem.Create(FFrame.PopMenuClass);
      MenuItem.Caption := WithoutGeneric(Name);
      MenuItem.Caption := Name;
      MenuItem.OnClick := ConnectBoxes;
      case Connection of
        'C':
          MenuItem.ImageIndex := 0;
        'I':
          MenuItem.ImageIndex := 16;
        'K':
          MenuItem.ImageIndex := 23;
      end;
      Name := (Box as TRtfdBox).Entity.Name;
      MenuItem.Tag := FBoxNames.IndexOf(Name);
      FFrame.MIClassPopupConnect.Add(MenuItem);
    end;
  end;

  procedure AddDatatype(const Source: string);
  begin
    if IsPythonType(Source) then
      Exit;
    var
    Str1 := WithoutGeneric(WithoutArray(Source));
    if IsPythonType(Str1) or (Str1 = '') then
      Exit;
    for var I := 0 to FBoxNames.Count - 1 do
      if Str1 = FBoxNames[I] then
        Exit;
    if (Associations.IndexOf(Str1) > -1) then
      Exit;
    Associations.Add(GetShortType(Str1));
  end;

  procedure MakeMenuItem(const Str1, Str2: string; ImageIndex: Integer);
  begin
    if Str1 = '' then
    begin
      var
      ASeparator := TSpTBXSeparatorItem.Create(FFrame.PopMenuClass);
      FFrame.PopMenuClass.Items.Insert(MenuIndex, ASeparator);
      Inc(MenuIndex);
    end
    else
    begin
      var
      AMenuItem := TSpTBXItem.Create(FFrame.PopMenuClass);
      AMenuItem.Caption := Str1;
      AMenuItem.Tag := InheritedLevel;
      if Str1 <> '' then
      begin
        if ImageIndex >= 7 then
          AMenuItem.OnClick := CallMethodForClass
        else
          AMenuItem.OnClick := CreateObjectForSelectedClass;
        AMenuItem.ImageIndex := ImageIndex;
        FFullParameters.Add(Str1 + '=' + Str2);
      end;
      if (InheritedLevel = 0) and (0 <= MenuIndex) and
        (MenuIndex < FFrame.PopMenuClass.Items.Count) then
      begin
        FFrame.PopMenuClass.Items.Insert(MenuIndex, AMenuItem);
        Inc(MenuIndex);
      end
      else
        InheritedMenu.Add(AMenuItem);
    end;
  end;

  function MakeTestMenuItem(const Str1, Str2: string): TSpTBXItem;
  begin
    var
    AMenuItem := TSpTBXItem.Create(FFrame.PopMenuClass);
    AMenuItem.Caption := Str1;
    AMenuItem.OnClick := OnRunJunitTestMethod;
    AMenuItem.ImageIndex := 21;
    FFullParameters.Add(Str1 + '=' + Str2);
    Result := AMenuItem;
  end;

  procedure MakeSeparatorItem;
  begin
    var
    AMenuItem := TSpTBXSeparatorItem.Create(FFrame.PopMenuClass);
    AMenuItem.Tag := InheritedLevel;
    if (InheritedLevel = 0) and (0 <= MenuIndex) and
      (MenuIndex < FFrame.PopMenuClass.Items.Count) then
    begin
      FFrame.PopMenuClass.Items.Insert(MenuIndex, AMenuItem);
      Inc(MenuIndex);
    end
    else
      InheritedMenu.Add(AMenuItem);
  end;

  procedure AddParameter(var Str1, Str2: string; Operation: TOperation);
  var
    Parameter: TParameter;
  begin
    var
    Ite2 := Operation.GetParameters;
    while Ite2.HasNext do
    begin
      Parameter := Ite2.Next as TParameter;
      if (Parameter.Name = 'self') or (Parameter.Name = 'cls') then
        Continue;
      Str1 := Str1 + Parameter.Name;
      Str2 := Str2 + Parameter.Name;
      // Chr(x) are used as separators
      if Assigned(Parameter.TypeClassifier) then
      begin
        Str1 := Str1 + ': ' + Parameter.TypeClassifier.AsType;
        if InheritedLevel = 0 then
          AddDatatype(Parameter.TypeClassifier.AsType);
      end;
      Str2 := Str2 + Chr(4);
      if Parameter.Value <> '' then
      begin
        Str1 := Str1 + Chr(4) + Parameter.Value;
        Str2 := Str2 + Parameter.Value;
      end;
      Str1 := Str1 + ', ';
      Str2 := Str2 + Chr(5);
    end;
    Str1 := myStringReplace(Str1 + ')', ', )', ')');
    Str2 := Str2 + ')';
    if (Operation.OperationType = otFunction) and Assigned(Operation.ReturnValue)
    then
    begin
      Str1 := Str1 + ': ' + Operation.ReturnValue.GetShortType;
      if InheritedLevel = 0 then
        AddDatatype(Operation.ReturnValue.Name);
    end;
  end;

  procedure Debugmenu(AMenu: TSpTBXPopupMenu);
  var
    Str: string;
    AMenuItem: TTBCustomItem;
  begin
    Str := '';
    for var I := 0 to AMenu.Items.Count - 1 do
    begin
      AMenuItem := AMenu.Items[I];
      Str := Str + AMenuItem.Caption + ' ' + BoolToStr(AMenuItem.Visible, True)
        + sLineBreak;
      for var J := 0 to AMenuItem.Count - 1 do
        Str := Str + '-- ' + AMenuItem[J].Caption + ' ' +
          BoolToStr(AMenuItem[J].Visible, True) + sLineBreak;
    end;
    ShowMessage(Str);
  end;

begin // PopMenuClassPopup
  Box := FindVCLWindow((Sender as TPopupMenu).PopupPoint);

  ViewClass := nil;
  FMenuClassFiles.Clear;
  FPanel.ClearSelection;
  if Assigned(Box) then
    FPanel.FindManagedControl(Box).Selected := True
  else
    Exit;

  // delete previous menu
  for var I := FFrame.PopMenuClass.Items.Count - 1 downto 0 do
    if FFrame.PopMenuClass.Items[I].Tag = 0 then
      FreeAndNil(FFrame.PopMenuClass.Items[I]);
  for var I := FFrame.MIClassPopupRunOneTest.Count - 1 downto 0 do
    FreeAndNil(FFrame.MIClassPopupRunOneTest[I]);
  for var I := FFrame.MIClassPopupOpenClass.Count - 1 downto 0 do
    FreeAndNil(FFrame.MIClassPopupOpenClass[I]);
  for var I := FFrame.MIClassPopupConnect.Count - 1 downto 0 do
    FreeAndNil(FFrame.MIClassPopupConnect[I]);

  FFullParameters.Clear;
  InheritedLevel := 0;
  StartIndex := 10;
  MenuIndex := StartIndex;
  Associations := TStringList.Create;
  Associations.Sorted := True;
  Associations.Duplicates := dupIgnore;
  Connections := TStringList.Create;
  Connections.Sorted := True;
  Connections.Duplicates := dupIgnore;
  SLSorted := TStringList.Create;
  SLSorted.Sorted := True;
  HasInheritedSystemMethods := False;
  MakeSeparatorItem;

  if (Box is TRtfdClass) and not(Box as TRtfdBox).IsJUnitTestClass then
  begin
    ViewClass := Box as TRtfdClass;
    ModelClass := ViewClass.Entity as TClass;

    // get superclasses
    for var I := 1 to ModelClass.AncestorsCount do
      MakeOpenClassMenuItem(ModelClass.Ancestor[I - 1].Name, 13);

    // get constructor
    if not ModelClass.IsAbstract then
    begin
      var
      ConstructorMissing := True;
      Ite1 := ModelClass.GetOperations;
      while Ite1.HasNext do
      begin
        Operation := Ite1.Next as UModel.TOperation;
        if Operation.OperationType = otConstructor then
        begin
          ConstructorMissing := False;
          Str1 := ModelClass.Name + '('; // Konto() instead of __init__()
          Str2 := Str1;
          AddParameter(Str1, Str2, Operation);
          Break; // only one constructor
        end;
      end;
      if ConstructorMissing then
      begin
        Str1 := ModelClass.Name + '()';
        Str2 := Str1;
      end;
      MakeMenuItem(Str1, Str2, 2);
    end;

    // get static|class methods and parameter classes
    repeat
      Ite1 := ModelClass.GetOperations;
      while Ite1.HasNext do
      begin
        Operation := Ite1.Next as UModel.TOperation;
        if Operation.OperationType in [otFunction, otProcedure] then
        begin
          if not(Operation.IsClassMethod or Operation.IsStaticMethod) then
            Continue;
          Str1 := Operation.Name + '(';
          Str2 := Str1;
          AddParameter(Str1, Str2, Operation);
          MakeMenuItem(Str1, Str2, Integer(Operation.Visibility) + 7);
        end;
      end;

      // empty inherited static methods menu
      if (InheritedLevel > 0) and (InheritedMenu.Count = 0) then
      begin
        FreeAndNil(InheritedMenu);
        Dec(MenuIndex);
      end;

      // get association classes
      if InheritedLevel = 0 then
      begin
        Ite1 := ModelClass.GetAttributes;
        while Ite1.HasNext do
        begin
          Attribute := Ite1.Next as UModel.TAttribute;
          if Assigned(Attribute.TypeClassifier) then
            AddDatatype(Attribute.TypeClassifier.Importname);
        end;
      end;

      // get inherited static methods
      if ModelClass.AncestorsCount > 0 then
      begin
        // for J:= 0 to ModelClass.AncestorsCount -1 do begin // wrong approach
        ModelClass := ModelClass.Ancestor[0];
        if Assigned(ModelClass) then
        begin
          Inc(InheritedLevel);
          InheritedMenu := TSpTBXSubmenuItem.Create(FFrame.PopMenuClass);
          InheritedMenu.Caption := 'Inherited from ' + ModelClass.Name;
          FFrame.PopMenuClass.Items.Insert(MenuIndex, InheritedMenu);
          Inc(MenuIndex);
        end;
      end
      else
        ModelClass := nil;
    until not Assigned(ModelClass);
  end;

  for var I := 0 to Associations.Count - 1 do
    MakeOpenClassMenuItem(Associations[I], 0);
  MakeConnectClassMenuItems;

  InheritedLevel := 0;
  Inc(MenuIndex, 2);
  MakeSeparatorItem;

  Str1 := ChangeFileExt((Box as TRtfdBox).GetPathname, '.py');
  HasSourcecode := FileExists(Str1);

  FFrame.MIClassPopupRun.Visible := True; // was hasMain
  FFrame.MIClassPopupClassEdit.Visible := (Box is TRtfdClass) and HasSourcecode;
  FFrame.MIClassPopupOpenSource.Visible := HasSourcecode; // in Arbeit
  FFrame.MIClassPopupOpenClass.Visible :=
    (FFrame.MIClassPopupOpenClass.Count > 0);
  FFrame.MIClassPopupConnect.Visible := (FFrame.MIClassPopupConnect.Count > 0);
  FFrame.MIClassPopupDelete.Caption := _('Delete class');
  FFrame.MIClassPopupShowInherited.Visible := not(Box as TRtfdBox)
    .ShowInherited and HasInheritedSystemMethods;
  FFrame.MIClassPopupHideInherited.Visible := (Box as TRtfdBox)
    .ShowInherited and HasInheritedSystemMethods;
  FFrame.MIClassPopupRunAllTests.Visible := False;
  FFrame.MIClassPopupRunOneTest.Visible := False;
  FFrame.NEndOfJUnitTest.Visible := False;
  FFrame.MIClassPopupCreateTestClass.Visible := False;
  for var I := 0 to FFrame.MIClassPopupDisplay.Count - 1 do
    FFrame.MIClassPopupDisplay[I].Checked := False;
  if Assigned(ViewClass) then
  begin
    Num := 3 - Ord(ViewClass.MinVisibility);
    FFrame.MIClassPopupDisplay[Num].Checked := True;
  end;
  for var I := 0 to FFrame.MIClassPopupParameter.Count - 1 do
    FFrame.MIClassPopupParameter[I].Checked := False;
  if Assigned(ViewClass) then
  begin
    Num := ViewClass.ShowParameter;
    FFrame.MIClassPopupParameter[Num].Checked := True;
  end;
  for var I := 0 to FFrame.MIClassPopupVisibility.Count - 1 do
    FFrame.MIClassPopupVisibility[I].Checked := False;
  if Assigned(ViewClass) then
  begin
    Num := 2 - ViewClass.ShowIcons;
    FFrame.MIClassPopupVisibility[Num].Checked := True;
  end;
  FFrame.MIClassPopupVisibility.Visible := True;

  FreeAndNil(Associations);
  FreeAndNil(Connections);
  FreeAndNil(SLSorted);
end; // PopMenuClassPopup

procedure TRtfdDiagram.PopMenuObjectPopup(Sender: TObject);
var
  LongType, Objectname: string;
  Control: TControl;
  Num, InheritedLevel, MenuIndex: Integer;
  AObjectBox: TRtfdObject;
  AViewClass: TRtfdClass;
  AModelClass: TClass;
  AModelClassRoot: TClass;
  AMenuItem: TTBCustomItem;
  AInheritedMenu: TSpTBXItem;

  procedure MakeMenuItem(const Str1, Str2: string; ImageIndex: Integer);
  begin
    if Str1 = '' then
    begin
      var
      ASeparator := TSpTBXSeparatorItem.Create(FFrame.PopMenuObject);
      FFrame.PopMenuObject.Items.Insert(MenuIndex, ASeparator);
      Inc(MenuIndex);
    end
    else
    begin
      var
      AMenuItem := TSpTBXItem.Create(FFrame.PopMenuObject);
      AMenuItem.Caption := Str1;
      AMenuItem.OnClick := CallMethodForObject;
      AMenuItem.ImageIndex := ImageIndex;
      FFullParameters.Add(Str1 + '=' + Str2);
      if InheritedLevel = 0 then
      begin
        FFrame.PopMenuObject.Items.Insert(MenuIndex, AMenuItem);
        Inc(MenuIndex);
      end
      else
      begin
        AMenuItem.Tag := InheritedLevel;
        AInheritedMenu.Add(AMenuItem);
      end;
    end;
  end;

  procedure MakeSortedMenu(SLSorted: TStringList);
  var
    Error, Posi, Img: Integer;
    Str, Str1, Str2: string;
  begin
    for var I := 0 to SLSorted.Count - 1 do
    begin
      Str := SLSorted[I];
      Posi := Pos(Chr(3), Str);
      Delete(Str, 1, Posi);
      Posi := Pos(Chr(3), Str);
      Str1 := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
      Posi := Pos(Chr(3), Str);
      Str2 := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
      Val(Str, Img, Error);
      MakeMenuItem(Str1, Str2, Img);
    end;
  end;

  procedure MakeShowUnnamedMenu;
  var
    SL1, SL2: TStringList;
    AMenuItem: TSpTBXItem;

    function NotShown(const Str: string): Boolean;
    begin
      Result := (Str <> '') and (FBoxNames.IndexOf(Str) = -1) and
        (SL2.IndexOf(Str) = -1);
    end;

    procedure PrepareMenu(const Attr: string);
    begin
      if NotShown(Attr) then
        SL2.Add(Attr);
    end;

    function MakeMenuItem(const Str: string; Count: Integer): TSpTBXItem;
    var
      AMenuItem: TSpTBXItem;
    begin
      AMenuItem := TSpTBXItem.Create(FFrame.MIObjectPopupShowNewObject);
      if Count > 3 then
        AMenuItem.Caption := Str
      else
        AMenuItem.Caption := FFrame.MIObjectPopupShowNewObject.Caption +
          ' ' + Str;
      AMenuItem.OnClick := ShowUnnamedObject;
      AMenuItem.ImageIndex := 19;
      AMenuItem.Tag := -2; // only unnamed menuitems
      Result := AMenuItem;
    end;

  begin // MakeShowUnnamedMenu
    FFrame.MIObjectPopupShowNewObject.Visible := False;
    FFrame.MIObjectPopupShowAllNewObjects.Visible := False;
    SL1 := FLivingObjects.getObjectObjectMembers(Objectname);
    SL2 := TStringList.Create;
    for var I := 0 to SL1.Count - 1 do
      PrepareMenu(SL1[I]);
    for var I := 0 to SL2.Count - 1 do
    begin
      AMenuItem := MakeMenuItem(SL2[I], SL2.Count);
      if SL2.Count > 3 then
        FFrame.MIObjectPopupShowNewObject.Add(AMenuItem)
      else
      begin
        FFrame.PopMenuObject.Items.Insert(MenuIndex - 1, AMenuItem);
        Inc(MenuIndex);
      end;
    end;
    FFrame.MIObjectPopupShowNewObject.Visible := (SL2.Count > 3);
    FFrame.MIObjectPopupShowAllNewObjects.Visible := (SL2.Count > 1);
    FreeAndNil(SL2);
    FreeAndNil(SL1);
  end;

  procedure MakeSeparatorItem;
  begin
    var
    AMenuItem := TSpTBXSeparatorItem.Create(FFrame.PopMenuObject);
    AMenuItem.Tag := InheritedLevel;
    if (InheritedLevel = 0) then
    begin
      FFrame.PopMenuObject.Items.Insert(MenuIndex, AMenuItem);
      Inc(MenuIndex);
    end
    else
    begin
      AMenuItem.Tag := InheritedLevel;
      AInheritedMenu.Add(AMenuItem);
    end;
  end;

  procedure MakeMethodMenuFromModel;
  var
    Operation: UModel.TOperation;
    Parameter: TParameter;
    Str1, Str2, Ancest, IName: string;
    Ite1, Ite2: IModelIterator;
  begin
    var
    SLSorted := TStringList.Create;
    SLSorted.Sorted := True;
    repeat
      Ite1 := AModelClass.GetOperations;
      while Ite1.HasNext do
      begin
        Operation := Ite1.Next as UModel.TOperation;
        if (InheritedLevel > 0) and (Operation.Visibility = viPrivate) then
          Continue;
        if (Operation.OperationType in [otProcedure, otFunction]) and
          not Operation.IsAbstract then
        begin
          IName := GetInternName(AModelClass, Operation.Name,
            Operation.Visibility);
          Str1 := Operation.Name + '(';
          Str2 := IName + '(';
          Ite2 := Operation.GetParameters;
          while Ite2.HasNext do
          begin
            Parameter := Ite2.Next as TParameter;
            if (Parameter.Name = 'self') or (Parameter.Name = 'cls') then
              Continue;
            Str1 := Str1 + Parameter.Name;
            Str2 := Str2 + Parameter.Name;
            if Assigned(Parameter.TypeClassifier) then
              Str1 := Str1 + ': ' + Parameter.TypeClassifier.AsType;
            Str2 := Str2 + Chr(4);
            if Parameter.Value <> '' then
            begin
              Str1 := Str1 + Chr(4) + Parameter.Value;
              Str2 := Str2 + Parameter.Value;
            end;
            Str1 := Str1 + ', ';
            Str2 := Str2 + Chr(5);
          end;
          Str1 := myStringReplace(Str1 + ')', ', )', ')');
          Str2 := Str2 + ')';
          if (Operation.OperationType = otFunction) and
            Assigned(Operation.ReturnValue) then
            Str1 := Str1 + ': ' + Operation.ReturnValue.GetShortType;
          // Operation.Name is sort-criteria, Str1 is Menu.Caption, Str2 is for calling method
          SLSorted.Add(Operation.Name + Chr(3) + Str1 + Chr(3) + Str2 + Chr(3) +
            IntToStr(Integer(Operation.Visibility) + 7));
        end;
      end;
      // end of while - all methods handelt

      MakeSortedMenu(SLSorted);
      SLSorted.Text := '';

      // empty inherited methods menu
      if (InheritedLevel > 0) and (AInheritedMenu.Count = 0) then
      begin
        FreeAndNil(AInheritedMenu);
        Dec(MenuIndex);
      end;
      if AModelClass.AncestorsCount > 0 then
      begin
        Ancest := AModelClass.Ancestor[0].Name;
        AModelClass := GetModelClass(Ancest);
        if not Assigned(AModelClass) or (AModelClass.Pathname = '') then
          AModelClass := CreateModelClass(Ancest);
      end
      else
        AModelClass := nil;
      if Assigned(AModelClass) then
      begin
        Inc(InheritedLevel);
        AInheritedMenu := TSpTBXSubmenuItem.Create(FFrame.PopMenuObject);
        AInheritedMenu.Caption := _('Inherited from') + ' ' + AModelClass.Name;
        FFrame.PopMenuObject.Items.Insert(MenuIndex, AInheritedMenu);
        Inc(MenuIndex);
      end
      else
        Break;
    until False;
    FreeAndNil(SLSorted);
  end;

  procedure MakeMethodMenuFromLivingObjects;
  var
    SLSorted, SLMethods, SLParameters: TStringList;
    Str1, Str2, Param, ParamTyp, ReturnType, Signature: string;
  begin
    SLSorted := TStringList.Create;
    SLSorted.Sorted := True;
    SLMethods := FLivingObjects.getMethods(Objectname);
    var
    Posi := SLMethods.IndexOf('__init__');
    if Posi > -1 then
      SLMethods.Delete(Posi);
    for var I := 0 to SLMethods.Count - 1 do
    begin
      Str1 := SLMethods[I] + '(';
      Str2 := Str1;
      Signature := FLivingObjects.getSignature(Objectname + '.' + SLMethods[I]);
      Posi := Pos('->', Signature);
      if Posi > 0 then
      begin
        ReturnType := Trim(Copy(Signature, Posi + 2, Length(Signature)));
        Signature := Trim(Copy(Signature, 1, Posi - 1));
      end
      else
        ReturnType := '';
      Signature := Copy(Signature, 2, Length(Signature) - 2);
      SLParameters := Split(',', Signature);
      for var J := 0 to SLParameters.Count - 1 do
      begin
        Param := SLParameters[J];
        Posi := Pos(':', Param);
        if Posi > 0 then
        begin
          ParamTyp := Trim(Copy(Param, Posi + 1, Length(Param)));
          Param := Copy(Param, 1, Posi - 1);
        end
        else
          ParamTyp := '';
        Str1 := Str1 + Param;
        Str2 := Str2 + Param;
        if ParamTyp <> '' then
          Str1 := Str1 + ': ' + ParamTyp;
        Str2 := Str2 + Chr(4);
        Str1 := Str1 + ', ';
        Str2 := Str2 + Chr(5);
      end;
      Str1 := myStringReplace(Str1 + ')', ', )', ')');
      Str2 := Str2 + ')';
      if ReturnType <> '' then
        Str1 := Str1 + ': ' + ReturnType;
      SLSorted.Add(SLMethods[I] + Chr(3) + Str1 + Chr(3) + Str2 + Chr(3) +
        IntToStr(Integer(viPublic) + 7));
      FreeAndNil(SLParameters);
    end;
    FreeAndNil(SLMethods);
    MakeSortedMenu(SLSorted);
    FreeAndNil(SLSorted);
  end;

begin // PopMenuObjectPopup
  Control := FindVCLWindow((Sender as TPopupMenu).PopupPoint);
  FPanel.ClearSelection;
  if Assigned(Control) then
    FPanel.FindManagedControl(Control).Selected := True
  else
    Exit;

  // delete previous menu
  for var I := FFrame.PopMenuObject.Items.Count - 1 downto 0 do
    if FFrame.PopMenuObject.Items[I].Tag <= 0 then
    begin
      AMenuItem := FFrame.PopMenuObject.Items[I];
      FreeAndNil(AMenuItem);
    end;
  for var I := FFrame.MIObjectPopupShowNewObject.Count - 1 downto 0 do
  begin
    AMenuItem := FFrame.MIObjectPopupShowNewObject[I];
    FreeAndNil(AMenuItem);
  end;

  FFullParameters.Clear;

  if Assigned(Control) and (Control is TRtfdObject) then
  begin
    Objectname := (Control as TRtfdObject).Entity.Fullname;
    LongType := ((Control as TRtfdObject).Entity as TObjekt).GetTyp.Name;
    InheritedLevel := 0;
    MenuIndex := 3; // edit, show, hide, show final, hide final, open class
    Inc(MenuIndex);
    MakeShowUnnamedMenu;
    MakeSeparatorItem;

    // get model class for object to get the methods
    AObjectBox := GetBox(Objectname) as TRtfdObject;
    AViewClass := GetBox(LongType) as TRtfdClass;
    if not Assigned(AViewClass) then
      AViewClass := GetBox(GetShortType(LongType)) as TRtfdClass;
    AModelClass := nil;
    if Assigned(AViewClass) then
      AModelClass := (AViewClass.Entity as TClass);
    // model class from view class
    if not Assigned(AModelClass) then
      AModelClass := GetModelClass(LongType); // model class from model
    if not Assigned(AModelClass) or (AModelClass.Pathname = '') then
      AModelClass := CreateModelClass(LongType); // model class from python
    AModelClassRoot := AModelClass;

    if Assigned(AModelClass) then
      MakeMethodMenuFromModel // known Class in Model
    else
      MakeMethodMenuFromLivingObjects;

    InheritedLevel := 0;
    Inc(MenuIndex, 1);
    MakeSeparatorItem;
    if Assigned(AModelClassRoot) then
      FFrame.MIObjectPopupEdit.Visible := HasAttributes(Objectname)
    else
      FFrame.MIObjectPopupEdit.Visible := False;
    if Assigned(AObjectBox) then
    begin
      FFrame.MIObjectPopupShowInherited.Visible := not AObjectBox.ShowInherited;
      FFrame.MIObjectPopupHideInherited.Visible := AObjectBox.ShowInherited;
    end;

    // ToDo
    FFrame.MIObjectPopupShowInherited.Visible := False;
    FFrame.MIObjectPopupHideInherited.Visible := False;

    for var I := 0 to FFrame.MIObjectPopupDisplay.Count - 1 do
      FFrame.MIObjectPopupDisplay[I].Checked := False;
    Num := 3 - Ord(AObjectBox.MinVisibility);
    FFrame.MIObjectPopupDisplay[Num].Checked := True;

    for var I := 0 to FFrame.MIObjectPopupVisibility.Count - 1 do
      FFrame.MIObjectPopupVisibility[I].Checked := False;
    Num := 2 - AObjectBox.ShowIcons;
    FFrame.MIObjectPopupVisibility[Num].Checked := True;
  end;
end; // PopMenuObjectPopup

procedure TRtfdDiagram.PopMenuConnectionPopup(Sender: TObject);
var
  Conn: TConnection;
  BothClass, AClassAObject: Boolean;
begin
  Conn := FPanel.GetClickedConnection;
  if not Assigned(Conn) then
    Exit;

  BothClass := ((Conn.FromControl is TRtfdClass) and (Conn.ToControl is TRtfdClass));
  AClassAObject := ((Conn.FromControl is TRtfdClass) and (Conn.ToControl is TRtfdObject)) or
    ((Conn.FromControl is TRtfdObject) and (Conn.ToControl is TRtfdClass));
  FFrame.MIConnectionAssociation.Visible := BothClass;
  FFrame.MIConnectionAssociationArrow.Visible := BothClass;
  FFrame.MIConnectionAssociationBidirectional.Visible := BothClass;
  FFrame.MIConnectionAggregation.Visible := BothClass;
  FFrame.MIConnectionAggregationArrow.Visible := BothClass;
  FFrame.MIConnectionComposition.Visible := BothClass;
  FFrame.MIConnectionCompositionArrow.Visible := BothClass;
  FFrame.MIConnectionInheritance.Visible := not Conn.IsRecursiv and BothClass;
  FFrame.MIConnectionInstanceOf.Visible := AClassAObject;
  FFrame.MIConnectionRecursiv.Visible := Conn.IsRecursiv;
end;

function TRtfdDiagram.HasAttributes(const Objectname: string): Boolean;
begin
  var
  StringList := FLivingObjects.getObjectMembers(Objectname);
  Result := (StringList.Count > 0);
  FreeAndNil(StringList);
end;

function TRtfdDiagram.HasSelectedConnection: Boolean;
begin
  Result := FPanel.HasSelectedConnection;
end;

procedure TRtfdDiagram.OpenClassOrInterface(Sender: TObject);
var
  CName, Filename: string;
begin
  CName := (Sender as TSpTBXItem).Caption;
  try
    Screen.Cursor := crHourGlass;
    Filename := FMenuClassFiles.Values[CName];
    (FFrame.Parent.Owner as TFUMLForm).AddToProject(Filename);
    FPanel.ClearSelection;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TRtfdDiagram.OpenClassWithDialog;
begin
  PyIDEMainForm.actUMLOpenClassExecute(nil);
end;

procedure TRtfdDiagram.NewClass;
begin
  PyIDEMainForm.actUMLNewClassExecute(nil);
end;

procedure TRtfdDiagram.ShowAll;
begin
  FLivingObjects.makeAllObjects;
  if GuiPyOptions.ShowAllNewObjects then
    ShowAllNewObjectsString('');
  UpdateAllObjects;
end;

procedure TRtfdDiagram.ShowUnnamed(Objectname: string);
var
  Address: string;
  Posi: Integer;
begin
  Posi := Pos(' ', Objectname);
  while Posi > 0 do
  begin
    Delete(Objectname, 1, Posi);
    Posi := Pos(' ', Objectname);
  end;
  if FLivingObjects.ObjectExists(Objectname) then
  begin
    // ToDo is this necessary?
    GI_PyControl.ActiveInterpreter.RunSource('import ctypes',
      '<interactive input>');
    Address := FLivingObjects.getRealAddressFromName(Objectname);
    GI_PyControl.ActiveInterpreter.RunSource(Objectname + ' = ctypes.cast(' +
      Address + ', ctypes.py_object).value', '<interactive input>');
    FLivingObjects.SimplifyPath(Objectname);
    ShowNewObject(Objectname);
  end;
end;

procedure TRtfdDiagram.ShowUnnamedObject(Sender: TObject);
begin
  try
    LockFormUpdate(FUMLForm);
    ShowUnnamed((Sender as TSpTBXItem).Caption);
    ResolveObjectAssociations;
    UpdateAllObjects;
    FPanel.RecalcSize;
  finally
    UnlockFormUpdate(FUMLForm);
  end;
end;

procedure TRtfdDiagram.ShowAllNewObjects(Sender: TObject);
var
  Int: Integer;
begin
  try
    LockFormUpdate(FUMLForm);
    Screen.Cursor := crHourGlass;
    if FFrame.MIObjectPopupShowNewObject.Visible then
      for Int := 0 to FFrame.MIObjectPopupShowNewObject.Count - 1 do
        ShowUnnamed(FFrame.MIObjectPopupShowNewObject[Int].Caption)
    else
    begin
      Int := 0;
      while (Int < FFrame.PopMenuObject.Items.Count) and
        (FFrame.PopMenuObject.Items[Int].Tag <> -2) do
        Inc(Int);
      while (Int < FFrame.PopMenuObject.Items.Count) and
        (FFrame.PopMenuObject.Items[Int].Tag = -2) do
      begin
        ShowUnnamed(FFrame.PopMenuObject.Items[Int].Caption);
        Inc(Int);
      end;
    end;
    ResolveObjectAssociations;
  finally
    UnlockFormUpdate(FUMLForm);
    Screen.Cursor := crDefault;
  end;
end;

procedure TRtfdDiagram.ShowAllNewObjectsString(From: string = '');
var
  SLObjects: TStringList;
  PyE: IPyEngineAndGIL;
  NewObject, Address: string;
begin
  GI_PyControl.ActiveInterpreter.RunSource('import ctypes', '<interactive input>');
  SLObjects := FLivingObjects.GetAllObjects;
  PyE := SafePyEngine;
  for var I := 0 to SLObjects.Count - 1 do
  begin
    NewObject := SLObjects.KeyNames[I];
    if FBoxNames.IndexOf(NewObject) = -1 then
    begin
      Address := FLivingObjects.getRealAddressFromName(NewObject);
      GI_PyControl.ActiveInterpreter.RunSource(NewObject + ' = ctypes.cast(' +
        Address + ', ctypes.py_object).value', '<interactive input>');
      FLivingObjects.SimplifyPath(NewObject);
      ShowNewObject(NewObject);
      if From = '' then
        From := 'Actor';
      ShowMethodEntered('<init>', From, NewObject, '');
    end;
  end;
  UpdateAllObjects;
  ResolveObjectAssociations;
  FPanel.RecalcSize;
end;

procedure TRtfdDiagram.ConnectBoxes(Sender: TObject);
var
  CName: string;
  Src: TControl;
  Dest: TRtfdBox;
  UMLForm: TFUMLForm;
begin
  Src := FPanel.GetFirstSelected;
  if Assigned(Src) and (Src is TRtfdBox) then
  begin
    if Src.Owner.Owner is TFUMLForm then
      UMLForm := Src.Owner.Owner as TFUMLForm
    else
      UMLForm := nil;
    LockFormUpdate(UMLForm);
    CName := (Sender as TSpTBXItem).Caption;
    Dest := GetBox(CName);
    FPanel.FindManagedControl(Dest).Selected := True;
    FPanel.ConnectBoxes(Src, Dest);
    UnlockFormUpdate(UMLForm);
  end;
end;

procedure TRtfdDiagram.DoConnection(Item: Integer);
begin
  FPanel.DoConnection(Item);
end;

procedure TRtfdDiagram.DoAlign(Item: Integer);
begin
  FPanel.DoAlign(Item);
end;

procedure TRtfdDiagram.SetInteractive(OnInteractiveModified: TNotifyEvent);
begin
  FOnModified := OnInteractiveModified;
end;

procedure TRtfdDiagram.SetFormMouseDown(OnFormMouseDown: TNotifyEvent);
begin
  FPanel.OnFormMouseDown := OnFormMouseDown;
end;

procedure TRtfdDiagram.AddToInteractive(const Source: string);
begin
  FUMLForm.AddInteractiveLine(Source);
end;

function TRtfdDiagram.EditClass(const Caption, Title, ObjectNameOld: string;
  var ObjectNameNew: string; Control: TControl;
  Attributes: TStringList): Boolean;
var
  Count: Integer;
begin
  FObjectGenerator.PrepareEditClass(Caption, Title, ObjectNameOld);
  Result := FObjectGenerator.Edit(Control, Attributes, 2);
  if Result then
  begin
    ObjectNameNew := FObjectGenerator.ValueListEditor.Cells[1, 1];
    Count := Attributes.Count;
    Attributes.Clear;
    for var I := 0 to Count - 1 do
      Attributes.Add(FObjectGenerator.ValueListEditor.Cells[0, I + 2] + '=' +
        FObjectGenerator.ValueListEditor.Cells[1, I + 2]);
  end;
end;

function TRtfdDiagram.EditObjectOrParams(const Caption, Title: string;
  Control: TControl; Attributes: TStringList): Boolean;
var
  Count: Integer;
begin
  FObjectGenerator.PrepareEditObjectOrParams(Caption, Title);
  Result := FObjectGenerator.Edit(Control, Attributes, 1);
  if Result then
  begin
    Count := Attributes.Count;
    Attributes.Clear;
    for var I := 0 to Count - 1 do
      Attributes.Add(FObjectGenerator.ValueListEditor.Cells[0, I + 1] + '=' +
        FObjectGenerator.ValueListEditor.Cells[1, I + 1]);
  end;
end;

procedure TRtfdDiagram.DeleteObjects;
var
  AObject: TRtfdObject;
  ManagedObject: TManagedObject;
begin
  // FLivingObjects.makeAllObjects;
  UnSelectAllElements;
  for var I := FBoxNames.Count - 1 downto 0 do
    if (FBoxNames.Objects[I] is TRtfdObject) then
    begin
      AObject := FBoxNames.Objects[I] as TRtfdObject;
      ManagedObject := FPanel.FindManagedControl(AObject);
      if Assigned(ManagedObject) then
      begin
        ManagedObject.Selected := True;
      end;
    end;
  DeleteSelectedControls(nil);
  FPanel.Invalidate;
end;

function TRtfdDiagram.HasObjects: Boolean;
begin
  for var I := 0 to FBoxNames.Count - 1 do
    if (FBoxNames.Objects[I] is TRtfdObject) then
      Exit(True);
  Result := False;
end;

procedure TRtfdDiagram.Reinitalize;
begin
  DeleteObjects;
  FLivingObjects.DeleteObjects;
  RefreshDiagram;
end;

procedure TRtfdDiagram.SetRecursiv(Point: TPoint; Pos: Integer);
begin
  FPanel.SetRecursiv(Point, Pos);
end;

function TRtfdDiagram.GetModelClass(const Str: string): TClass;
var
  CIte: IModelIterator;
  Cent: TClassifier;
  Typ: string;
begin
  Result := nil;
  CIte := Model.ModelRoot.GetAllClassifiers;
  while CIte.HasNext do
  begin
    Cent := TClassifier(CIte.Next);
    if Cent is TClass then
    begin
      Typ := (Cent as TClass).GetTyp;
      if (Typ = Str) or (Typ = GetShortType(Str)) then
      begin
        Result := (Cent as TClass);
        Break;
      end;
    end;
  end; // without source
  if Assigned(Result) and (Result.Pathname = '') then
  begin
    var
    UnitPackage := Model.ModelRoot.FindUnitPackage('Default');
    UnitPackage.DeleteObject(Typ);
    Result := nil;
  end;
end;

function TRtfdDiagram.StringToArrowStyle(Str: string): TEssConnectionArrowStyle;
var
  Int: Integer;
  ArrowStyle: TEssConnectionArrowStyle;
begin
  Result := asAssociation1;
  Str := Trim(Str);
  if TryStrToInt(Str, Int) then // pre 10.3 uml-file-format
    Result := TEssConnectionArrowStyle(Int)
  else
    for ArrowStyle := asAssociation1 to asComment do
      if ArrowStyleToString(ArrowStyle) = Str then
      begin
        Result := ArrowStyle;
        Exit;
      end;
end;

function TRtfdDiagram.ArrowStyleToString(ArrowStyle
  : TEssConnectionArrowStyle): string;
begin
  case ArrowStyle of
    asAssociation1:
      Result := 'Association';
    asAssociation2:
      Result := 'AssociationDirected';
    asAssociation3:
      Result := 'AssociationBidirectional';
    asAggregation1:
      Result := 'Aggregation';
    asAggregation2:
      Result := 'AggregationArrow';
    asComposition1:
      Result := 'Composition';
    asComposition2:
      Result := 'CompositionArrow';
    asInheritends:
      Result := 'Inheritends';
    asInstanceOf:
      Result := 'InstanceOf';
    asComment:
      Result := 'Comment';
  end;
end;

function TRtfdDiagram.GetSourcepath: string;
var
  StringList: TStringList;
  Str: string;
begin
  Result := '';
  if Assigned(Model) and Assigned(Model.ModelRoot) then
  begin
    StringList := Model.ModelRoot.Files;
    for var I := 0 to StringList.Count - 1 do
    begin
      Str := StringList[I];
      Str := ExtractFilePath(Str);
      if Pos(Str, Result) = 0 then
        Result := Result + ';' + Str;
    end;
    Delete(Result, 1, 1);
  end;
end;

function TRtfdDiagram.GetCommentBoxName: string;
var
  Num, CommentNr: Integer;
  Str: string;
begin
  CommentNr := 0;
  for var I := 0 to FBoxNames.Count - 1 do
    if Pos('Comment: ', FBoxNames[I]) = 1 then
    begin
      Str := Copy(FBoxNames[I], 9, 255);
      if TryStrToInt(Str, Num) then
        CommentNr := Math.Max(CommentNr, Num);
    end;
  Result := 'Comment: ' + IntToStr(CommentNr + 1);
end;

procedure TRtfdDiagram.AddCommentBoxTo(Control: TControl);
var
  CommentBox: TRtfdCommentBox;
  AClass: TRtfdClass;
  Boxname: string;
begin
  Boxname := GetCommentBoxName;
  CommentBox := TRtfdCommentBox.Create(FPanel, Boxname, FFrame, viPublic,
    HANDLESIZE);
  CommentBox.Top := 50 + Random(50);
  CommentBox.Left := 50 + Random(50);
  CommentBox.Width := 150;
  CommentBox.Height := 100;
  FBoxNames.AddObject(Boxname, CommentBox);
  FPanel.AddManagedObject(CommentBox);

  if not Assigned(Control) then
    Control := FPanel.GetFirstSelected;
  if Assigned(Control) and (Control is TRtfdClass) then
  begin
    AClass := (Control as TRtfdClass);
    CommentBox.Font.Assign(Font);
    CommentBox.Top := AClass.Top + Random(50);
    CommentBox.Left := AClass.Left + AClass.Width + 100 + Random(50);
    FPanel.ConnectObjects(AClass, CommentBox, asComment);
  end;
  FPanel.IsModified := True;
  FPanel.RecalcSize;
  FPanel.ShowConnections;
  CommentBox.SendToBack;
end;

function TRtfdDiagram.HasClass(const AClassname: string): Boolean;
begin
  Result := False;
  for var I := 0 to FBoxNames.Count - 1 do
    if FBoxNames[I] = AClassname then
    begin
      Result := True;
      Break;
    end;
end;

procedure TRtfdDiagram.DoShowParameter(Control: TControl; Mode: Integer);
var
  Box: TRtfdBox;
begin
  if Control is TRtfdBox then
  begin
    Box := (Control as TRtfdBox);
    if Box.ShowParameter <> Mode then
    begin
      Box.ShowParameter := Mode;
      FPanel.ShowAll;
      FPanel.IsModified := True;
    end;
  end;
end;

procedure TRtfdDiagram.DoShowVisibility(Control: TControl; Mode: Integer);
var
  Box: TRtfdBox;
begin
  if Control is TRtfdBox then
  begin
    Box := (Control as TRtfdBox);
    if Box.ShowIcons <> Mode then
    begin
      Box.ShowIcons := Mode;
      FPanel.ShowAll;
      FPanel.IsModified := True;
    end;
  end;
end;

procedure TRtfdDiagram.DoShowVisibilityFilter(Control: TControl; Mode: Integer);
var
  Box: TRtfdBox;
begin
  if Control is TRtfdBox then
  begin
    Box := (Control as TRtfdBox);
    if Box.MinVisibility <> TVisibility(Mode) then
    begin
      Box.MinVisibility := TVisibility(Mode);
      FPanel.ShowAll;
      FPanel.IsModified := True;
    end;
  end;
end;

procedure TRtfdDiagram.CreateTestClass(Control: TControl);
// var AClass: TRtfdClass; aClassname, Filename: String; SL: TStringList;
begin
  {
    if (Control is TRtfdClass) then begin
    AClass:= (Control as TRtfdClass);
    aClassname:= AClass.Entity.Name + 'Test';
    Filename:= ExtractFilepath(AClass.GetPathname) + WithoutGeneric(aClassname) + '.py';
    if FileExists(Filename) and
    (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [Filename]),
    mtConfirmation, mbYesNoCancel, 0) = mrYes) or
    not FileExists(Filename)
    then begin
    SL:= TStringList.Create;
    SL.Text:= FObjectgenerator.GetTemplate(aClassname, 12);
    if SL.Text = '' then SL.Text:= FObjectGenerator.GetTestClassCode(aClassname);
    SL.SaveToFile(Filename);
    FUMLForm.MainModul.AddToProject(Filename);
    FUMLForm.Modified:= true;
    end;
    end;
  }
end;

procedure TRtfdDiagram.OnRunJunitTestMethod(Sender: TObject);
{ var AMenuItem: TSpTBXItem; s: string; p: integer;
  C: TControl; }
begin
  { C:= FindVCLWindow(FFrame.PopMenuClass.PopupPoint);
    if (Sender is TSpTBXItem) then begin
    AMenuItem:= Sender as TSpTBXItem;
    p:= FFullParameters.IndexOfName(AMenuItem.Caption);
    s:= FFullParameters.ValueFromIndex[p];
    RunTests(C, s);
    end; }
end;

procedure TRtfdDiagram.RunTests(Control: TControl; const Method: string);
begin
  {
    if (Control is TRtfdClass) then
    if (Control as TRtfdClass).Entity is TClass then begin
    if FJUnitTests = nil then
    FJUnitTests:= TFJUnitTests.Create(FJava);
    FJUnitTests.Pathname:= ((Control as TRtfdClass).Entity as TClass).Pathname;
    myJavaCommands.RunTests((Control as TRtfdClass).Entity as TClass, Method);
    end;
  }
end;

procedure TRtfdDiagram.ShowMethodEntered(const Methodname, From, Till,
  Parameter: string);
begin
  if Assigned(FSequenceForm) then
  begin
    FSequenceForm.MethodEntered(Methodname);
    if GuiPyOptions.SDShowParameter then
      FSequenceForm.AddParameter(Parameter);
    FSequenceForm.StartParticipant := From;
    FSequenceForm.EndParticipant := Till;
    FSequenceForm.MakeConnection;
  end;
end;

procedure TRtfdDiagram.ShowMethodExited(const Methodname, From, Till,
  Result: string);
begin
  if Assigned(FSequenceForm) then
  begin
    FSequenceForm.MethodExited(Methodname);
    FSequenceForm.StartParticipant := From;
    FSequenceForm.EndParticipant := Till;
    FSequenceForm.AResult := Result;
    FSequenceForm.MakeConnection;
  end;
end;

procedure TRtfdDiagram.ShowObjectDeleted(const From, Till: string);
begin
  if Assigned(FSequenceForm) then
  begin
    FSequenceForm.ObjectDelete;
    FSequenceForm.StartParticipant := From;
    FSequenceForm.EndParticipant := Till;
    FSequenceForm.MakeConnection;
  end;
end;

procedure TRtfdDiagram.CloseNotify(Sender: TObject);
begin
  FSequenceForm := nil;
end;

procedure TRtfdDiagram.ClearSelection;
begin
  FPanel.ClearSelection;
end;

procedure TRtfdDiagram.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
  begin
    FFrame.PopMenuClass.Images := FFrame.vilClassObjectDark;
    FFrame.PopMenuObject.Images := FFrame.vilClassObjectDark;
    FFrame.PopMenuConnection.Images := FFrame.vilAssociationsDark;
    FFrame.PopupMenuWindow.Images := FFrame.vilWindowDark;
    FFrame.PopupMenuAlign.Images := FFrame.vilAlignDark;
  end
  else
  begin
    FFrame.PopMenuClass.Images := FFrame.vilClassObjectLight;
    FFrame.PopMenuObject.Images := FFrame.vilClassObjectLight;
    FFrame.PopMenuConnection.Images := FFrame.vilAssociationsLight;
    FFrame.PopupMenuWindow.Images := FFrame.vilWindowLight;
    FFrame.PopupMenuAlign.Images := FFrame.vilAlignLight;
  end;
  FPanel.ChangeStyle;
end;

procedure TRtfdDiagram.CopyDiagramToClipboard;
var
  Selected: Boolean;
  Bmp1, Bmp2: Graphics.TBitmap;
  Width, Height: Integer;
  SelRect: TRect;
begin
  FPanel.ChangeStyle(True);
  SelRect := GetSelectedRect;
  Selected := (SelRect.Right > SelRect.Left);
  GetDiagramSize(Width, Height);
  try
    Bmp1 := Graphics.TBitmap.Create;
    Bmp1.Width := Width;
    Bmp1.Height := Height;
    Bmp1.Canvas.Lock;
    PaintTo(Bmp1.Canvas, 0, 0, True);

    Bmp2 := Graphics.TBitmap.Create;
    if Selected then
    begin
      Bmp2.Width := SelRect.Right - SelRect.Left + 2;
      Bmp2.Height := SelRect.Bottom - SelRect.Top + 2;
      Bmp2.Canvas.Draw(-SelRect.Left + 1, -SelRect.Top + 1, Bmp1);
      Clipboard.Assign(Bmp2);
    end
    else
      Clipboard.Assign(Bmp1);
    Bmp1.Canvas.Unlock;
  finally
    FreeAndNil(Bmp1);
    FreeAndNil(Bmp2);
  end;
  ClearSelection;
  FPanel.ChangeStyle(False);
end;

procedure TRtfdDiagram.ClearMarkerAndConnections(Control: TControl);
begin
  FPanel.ClearMarkerAndConnections(Control);
end;

procedure TRtfdDiagram.DrawMarkers(Rect: TRect; Show: Boolean);
begin
  FPanel.DrawMarkers(Rect, Show);
end;

procedure TRtfdDiagram.EditBox(Control: TControl);
begin
  FPanel.EditBox(Control);
end;

procedure TRtfdDiagram.SetModified(const Value: Boolean);
begin
  FPanel.SetModified(Value);
end;

procedure TRtfdDiagram.SetOnModified(OnBoolEvent: TBoolEvent);
begin
  FPanel.OnModified := OnBoolEvent;
end;

procedure TRtfdDiagram.DeleteComment;
var
  Control: TControl;
  ManagedObject: TManagedObject;
begin
  Control := FindVCLWindow(FFrame.PopupMenuComment.PopupPoint);
  if Assigned(Control) then
  begin
    ManagedObject := FPanel.FindManagedControl(Control);
    if Assigned(ManagedObject) then
    begin
      UnSelectAllElements;
      ManagedObject.Selected := True;
      DeleteSelectedControls(nil);
    end;
  end;
end;

procedure TRtfdDiagram.ExecutePython(const Source: string);
begin
  FLivingObjects.ExecutePython(Source);
end;

procedure TRtfdDiagram.GetVisFromName(var Name: string; var Vis: TVisibility);
begin
  Vis := viPublic;
  var
  Posi := Pos('__', Name);
  if Posi > 0 then
  begin
    Name := Copy(Name, Posi + 2, Length(Name));
    Vis := viPrivate;
  end;
  if Name[1] = '_' then
  begin
    Name := Copy(Name, 2, Length(Name));
    Vis := viProtected;
  end;
end;

function TRtfdDiagram.PanelIsLocked: Boolean;
begin
  Result := (FPanel.UpdateCounter > 0);
end;

procedure TRtfdDiagram.SetUMLFont;
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  ResourcesDataModule.dlgFontDialog.Options := [];
  if ResourcesDataModule.dlgFontDialog.Execute then
  begin
    Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
    GuiPyOptions.UMLFont.Assign(Font);
    SetFont(Font);
    RefreshDiagram;
  end;
end;

end.
