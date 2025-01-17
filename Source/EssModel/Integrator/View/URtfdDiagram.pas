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

uses Controls, Types, Graphics, Classes, ExtCtrls,
  uDiagramFrame, uRtfdComponents, uFeedback, uListeners, uModelEntity, uModel,
  UUtils, uViewIntegrator, UEssConnectPanel, USequenceform,
  UUMLForm, UConnection, ULivingObjects;

type
  TRtfdDiagram = class(TDiagramIntegrator,
      IBeforeObjectModelListener,
      IAfterObjectModelListener,
      IAfterUnitPackageListener)
  private
    // Model: TObjectModel; is inherited
    IsAllClasses : Boolean;
    OnModified: TNotifyEvent;
    BoxNames, FullParameters, MenuClassFiles: TStringList;
    FLivingObjects: TLivingObjects;
    UMLForm: TFUMLForm;
    PPIControl: TControl;

    CreateObjectObjectname: string;
    CreateObjectParameter: string;
    CreateObjectClass: TClass;

    CallMethodObjectname: string;
    CallMethodMethodname: string;
    CallMethodFrom: string;

    procedure AddBox(E: TModelEntity);
    function GetBox(typ: string) : TRtfdBox;
    //Model listeners
    procedure ModelBeforeChange(Sender: TModelEntity);
    procedure ModelAfterChange(Sender: TModelEntity);
    procedure IBeforeObjectModelListener.Change = ModelBeforeChange;
    procedure IAfterObjectModelListener.Change = ModelAfterChange;
    //Unitpackage listeners
    procedure UnitPackageAfterChange(Sender: TModelEntity);
    procedure UnitPackageAfterAddChild(Sender: TModelEntity; NewChild: TModelEntity);
    procedure UnitPackageAfterRemove(Sender: TModelEntity);
    procedure UnitPackageAfterEntityChange(Sender: TModelEntity);
    procedure IAfterUnitPackageListener.Change = UnitPackageAfterChange;
    procedure IAfterUnitPackageListener.AddChild = UnitPackageAfterAddChild;
    procedure IAfterUnitPackageListener.Remove = UnitPackageAfterRemove;
    procedure IAfterUnitPackageListener.EntityChange = UnitPackageAfterEntityChange;
  private
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
    Panel: TessConnectPanel;
    Frame: TAFrameDiagram;
    SequenceForm: TFSequenceForm;
    constructor Create(om: TObjectModel; Parent: TWinControl; aFeedback : IEldeanFeedback = nil); override;
    destructor Destroy; override;
    procedure ClearDiagram; override;
    procedure ResolveAssociations; override;
    procedure ResolveObjectAssociations; override;
    procedure InitFromModel; override;
    procedure PaintTo(Canvas: TCanvas; X, Y: Integer; SelectedOnly : Boolean); override;
    procedure GetDiagramSize(var W, H : Integer); override;
    procedure SetPackage(const Value: TAbstractPackage); override;
    procedure DoLayout; override;
    function GetClickAreas : TStringList; override;
    procedure ClassEditSelectedDiagramElements; override;
    procedure ClassEditSelectedDiagramElementsControl(Sender: TObject); override;
    procedure SourceEditSelectedDiagramElements(C: TControl); override;

    procedure UnSelectAllElements; override;
    function GetSelectedRect: TRect; override;
    procedure ScreenCenterEntity(E : TModelEntity); override;
    procedure SetFont(const aFont: TFont); override;

    procedure StoreDiagram(filename: string); override;
    procedure FetchDiagram(filename: string); override;

    procedure RefreshDiagram; override;
    procedure RecalcPanelSize; override;
    procedure SetConnections(const Value: Integer); override;

    procedure SelectAssociation; override;
    procedure DeleteSelectedControls(Sender: TObject);
    procedure DeleteSelectedControlsAndRefresh; override;

    procedure DeleteObjects; override;
    function hasObjects: Boolean; override;
    function hasSelectedConnection: Boolean; override;
    function GetPanel: TCustomPanel; override;
    procedure SetInteractive(OnInteractiveModified: TNotifyEvent); override;
    procedure SetFormMouseDown(OnFormMouseDown: TNotifyEvent); override;
    procedure AddToInteractive(const s: string);
    function getSourcePath: string; override;
    procedure Reinitalize; override;

    procedure Run(C: TControl); override;
    procedure ShowInheritedMethodsFromSystemClasses(C: TControl; ShowOrHide: Boolean); override;

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
    procedure PopMenuObjectPopup(Sender: TOBject); override;
    procedure PopMenuConnectionPopup(Sender: TObject); override;

    procedure CreateObjectForSelectedClass(Sender: TObject);
    function CreateModelClass(const Typ: string): TClass;
    function FindClassifier(const CName: string): TClassifier;
    procedure ShowNewObject(const Objectname: string; aClass: TClass = nil);

    procedure CallMethod(C: TControl; Sender: TObject);
    procedure CallMethodForObject(Sender: TObject);
    procedure CallMethodForClass(Sender: TObject);
    procedure CollectClasses;

    procedure EditObject(C: TControl); override;
    function HasAttributes(Objectname: string): Boolean;
    procedure UpdateAllObjects;
    procedure ShowAttributes(Objectname: string; aClass: TClass; aModelObject: TObjekt);
    procedure SetAttributeValues(aModelClass: TClass; Objectname: string; Attributes: TStringList);
    function EditClass(const Caption, Title, ObjectNameOld: string; var ObjectNameNew: string; Attributes: TStringList): Boolean;
    function EditObjectOrParams(const Caption, Title: string; Attributes: TStringList): Boolean;
    function Edit(Attributes: TStringList; Row: Integer): Boolean;
    procedure SetRecursiv(P: TPoint; pos: Integer); override;
    function getModelClass(const s: string): TClass;
    function StringToArrowStyle(s: string): TessConnectionArrowStyle;
    function ArrowStyleToString(ArrowStyle: TessConnectionArrowStyle): string;
    function getCommentBoxName: string;
    procedure AddCommentBoxTo(aControl: TControl); override;
    function insertParameterNames(s: string): string;
    function hasClass(aClassname: string): Boolean;
    procedure DoShowParameter(aControl: TControl; Mode: Integer); override;
    procedure DoShowVisibility(aControl: TControl; Mode: Integer); override;
    procedure DoShowVisibilityFilter(aControl: TControl; Mode: Integer); override;
    procedure CreateTestClass(aControl: TControl); override;
    procedure RunTests(aControl: TControl; const Method: string); override;
    procedure OnRunJunitTestMethod(Sender: TObject);
    procedure ShowMethodEntered(const aMethodname, From, _To, Parameter: string);
    procedure ShowMethodExited(const aMethodname, From, _To, _Result: string);
    procedure ShowObjectDeleted(const From, _To: string);
    procedure CloseNotify(Sender: TObject);
    procedure ClearSelection; override;
    procedure CopyDiagramToClipboard; override;
    procedure ClearMarkerAndConnections(Control: TControl); override;
    procedure DrawMarkers(r: TRect; show: Boolean); override;
    procedure EditBox(Control: TControl); override;
    procedure SetModified(const Value: Boolean); override;
    procedure SetOnModified(OnBoolEvent: TBoolEvent); override;
    procedure ChangeStyle; override;
    procedure DeleteComment; override;
    function getDebug: TStringList;
    function getSVG: string; override;
    function getParameterAsString(Parameter, ParamValues: TStringList): string;
    function getInternName(aClass: TClass; aName: string; aVisibility: TVisibility): string;
    function StrToPythonValue(s: string): string;
    function StrAndTypeToPythonValue(s, pValue: string): string;
    procedure ExecutePython(s: string); override;
    procedure GetVisFromName(var Name: string; var vis: TVisibility);
    procedure Retranslate; override;
    function PanelIsLocked: Boolean; override;
    procedure SetUMLFont; override;
    function HasAInvalidClass: Boolean; override;
  end;

implementation

uses Windows, Menus, Forms, Math, SysUtils, UITypes, Dialogs, Contnrs, IOUtils,
  IniFiles, Clipbrd, JvGnugettext, TB2Item, SpTBXItem,
  uIterators, uRtfdDiagramFrame, USugiyamaLayout, uIntegrator, UConfiguration,
  SynEdit, UUMLModule, UImages, UObjectGenerator, dmResources,
  frmPyIDEMain, uEditAppIntfs, frmFile, frmPythonII, frmVariables,
  cPyControl, cPyBaseDebugger, PythonEngine, uCommonFunctions;

{ TRtfdDiagram }

constructor TRtfdDiagram.Create(om: TObjectModel; Parent: TWinControl; aFeedback: IEldeanFeedback = nil);
begin
  inherited Create(Om, Parent, aFeedback);
  Frame:= TAFrameRtfdDiagram.Create(Parent, Self);
  Frame.Parent:= Parent;  // assigment to the gui
  UMLForm:= (Parent.Parent.Parent as TFUMLForm);
  PPIControl:= UMLForm.TBClose;
  FLivingObjects:= TLivingObjects.Create;

  // Panel is ActiveControl in MainForm
  Panel:= TessConnectPanel.Create(UMLForm);
  Panel.PopupMenuConnection:= Frame.PopMenuConnection;
  Panel.PopupMenuAlign:= Frame.PopupMenuAlign;
  Panel.PopupMenuWindow:= Frame.PopupMenuWindow;
  Panel.Parent:= Frame.ScrollBox;
  Panel.Name:= 'PanelName';
  Panel.OnDeleteSelectedControls:= DeleteSelectedControls;
  Panel.OnClassEditSelectedDiagramElements:= ClassEditSelectedDiagramElementsControl;

  OnModified:= nil;
  Sequenceform:= nil;

  BoxNames:= TStringList.Create;
  BoxNames.CaseSensitive:= True;
  BoxNames.Sorted:= True;
  BoxNames.Duplicates:= dupIgnore;
  FullParameters:= TStringList.Create;
  MenuClassFiles:= TStringList.Create;
  MenuClassFiles.Sorted:= True;
  MenuClassFiles.Duplicates:= dupIgnore;

  Model.AddListener(IBeforeObjectModelListener(Self));
  ClearDiagram;
end;

destructor TRtfdDiagram.Destroy;
  var Box: TRtfdBox; i: Integer;
begin
  // Force listeners to release, and diagram to persist.
  // Package:= nil;
  //Model.RemoveListener(IBeforeObjectModelListener(Self));
  Model.ClearListeners;

  FreeAndNil(FullParameters);
  for i:= 0 to BoxNames.Count-1 do begin
    Box := BoxNames.Objects[i] as TRtfdBox;
    FreeAndNil(Box);
  end;
  FreeAndNil(BoxNames);
  FreeAndNil(MenuClassFiles);
  FreeAndNil(FLivingObjects);
  // dont do that: FreeAndNil(Frame);
  // Frame is part of the gui and therefore is destroyed as GUI-component
  // Panel is part of Frame so it is also destroyed by system as GUI-component
  inherited;   // Model is inherited
end;

procedure TRtfdDiagram.InitFromModel;
var
  Mi: IModelIterator;

  procedure InAddUnit(Up: TUnitPackage);
  var
    Mi: IModelIterator;
    Cl: TClassifier;
  begin
    Mi:= Up.GetClassifiers;
    while Mi.HasNext do begin
      Cl:= MI.Next as TClassifier;
      if CL.IsVisible then
        AddBox( Cl );
    end;
  end;

begin
  // IsAllClasses:= (Package = AllClassesPackage);
  IsAllClasses:= True;  // otherwise no Delpi-class is shown
  Panel.Hide;
  if not Assigned(FPackage) then begin
    Package := Model.ModelRoot;
    //If there is only one package (except unknown) then show it.
    //Assign with Package-property to trigger listeners
    Mi := (FPackage as TLogicPackage).GetPackages;
    if Mi.Count = 2 then begin
      Mi.Next;
      Package := Mi.Next as TAbstractPackage;
    end;
  end;

  //Clean old
  ClearDiagram;

  //Create boxes
  if FPackage is TUnitPackage then
    InAddUnit(FPackage as TUnitPackage)
  else  begin
    //Logic package
    //Exclude unknown-package, otherwise all temp-classes will be included on showallclasses.
    //Also, unkown-package will be shown on package-overview (including docgen)
    if IsAllClasses then begin
      //These lines show all members of a package on one diagram
      Mi := TModelIterator.Create( (Model.ModelRoot as TLogicPackage).GetPackages, TEntitySkipFilter.Create(Model.UnknownPackage) );
      while Mi.HasNext do
        InAddUnit(Mi.Next as TUnitPackage)
    end else begin
      Mi := TModelIterator.Create( (FPackage as TLogicPackage).GetPackages, TEntitySkipFilter.Create(Model.UnknownPackage) );
      while Mi.HasNext do
        AddBox(Mi.Next);
    end;
  end;

  //Create arrow between boxes
  //This must be done after fetchdiagram because connection-setting might be stored
  DoLayout;
  Panel.RecalcSize;
  Panel.IsModified := False;
  Panel.Show;
  Panel.SetFocus;
end;

procedure TRtfdDiagram.ModelBeforeChange(Sender: TModelEntity);
begin
  Package := nil;
  IsAllClasses := False;
  ClearDiagram;
end;

procedure TRtfdDiagram.ModelAfterChange(Sender: TModelEntity);
begin
  InitFromModel;
end;

procedure TRtfdDiagram.PaintTo(Canvas: TCanvas; X, Y: Integer; SelectedOnly : Boolean);
var
  OldBit : Graphics.TBitmap;
begin
  OldBit := Panel.BackBitmap;
  Panel.BackBitmap := nil;
  if SelectedOnly then begin
    if Panel.GetFirstSelected <> nil then
      Panel.SelectedOnly := True;
  end else
    // selection-markers should not be visible in the saved picture
    Panel.ClearSelection;
  Canvas.Lock;
  try
    Panel.PaintTo(Canvas.Handle, X, Y);
    Panel.TextTo(Canvas);
  finally
    Canvas.Unlock;
    Panel.SelectedOnly := False;
    Panel.BackBitmap := OldBit;
  end;
end;

function TRtfdDiagram.getSVG: string;
  var s, sw, si, ga: string; i, w, h: Integer;
begin
  Panel.GetDiagramSize(w, h);
  s:= '<?xml version="1.0" encoding="UTF-8" ?>'#13#10;
  s:= s + '<svg width="' + IntToStr(w) + '"' + ' height="' + IntToStr(h) + '"' +
          ' font-family="' + Font.Name + '"' +
          ' font-size="' + IntToStr(round(Font.Size*1.3)) + '">'#13#10;
  if GuiPyOptions.Shadowwidth > 0 then begin
    sw:= FloatToVal(GuiPyOptions.ShadowWidth / 2.0);
    si:= FloatToVal(Min(2*GuiPyOptions.ShadowIntensity/10.0, 1));
    ga:= FloatToVal(Min(GuiPyOptions.ShadowWidth, 10)*0.4);
    s:= s +
      '  <defs>'#13#10 +
      '    <filter style="color-interpolation-filters:sRGB;" id="Shadow">'#13#10 +
      '      <feFlood flood-opacity=' + si + ' flood-color="rgb(0,0,0)" result="flood" />'#13#10 +
      '      <feComposite in="flood" in2="SourceGraphic" operator="in" result="composite1"/>'#13#10 +
      '      <feGaussianBlur in="composite1" stdDeviation=' + ga + ' result="blur" />'#13#10 +
      '      <feOffset dx=' + sw + ' dy=' + sw + ' result="offset" />'#13#10 +
      '      <feComposite in="SourceGraphic" in2="offset" operator="over" result="composite2" />'#13#10 +
      '    </filter>'#13#10 +
      '  </defs>'#13#10;
  end;
  s:= s + Panel.getSVGConnections;
  for i:= 0 to BoxNames.Count-1 do
    s:= s + (BoxNames.Objects[i] as TRtfdBox).getSVG;
  Result:= s + '</svg>'#13#10;
end;

procedure TRtfdDiagram.ClearDiagram;
begin
  if not (csDestroying in Panel.ComponentState) then begin
    Panel.ClearManagedObjects;
    Panel.DestroyComponents;
  end;
  BoxNames.Clear;
end;

//Add a 'Box' to the diagram (class/package/objekt/comment).
procedure TRtfdDiagram.AddBox(E: TModelEntity);
var
  Mi : IModelIterator;
  C : TClass;
  A : TAttribute;
  i: Integer;

  function InCreateBox(E: TModelEntity; BoxT: TRtfdBoxClass): TRtfdBox;
  begin
    Result:= BoxT.Create(Panel, E, Frame, viPrivate);
    Result.Font.Assign(Font);
    BoxNames.AddObject(E.Name, Result);
  end;

begin
  if E is TUnitPackage then
    Panel.AddManagedObject(InCreateBox(E, TRtfdUnitPackage))
  else if E is TClass then begin
    //Insert related boxes from other packages
    //This should not be done if IsAllClasses, because then all boxes are inserted anyway
    IsAllClasses:= True; // for testing
    if not IsAllClasses then begin
      //Ancestor that is in another package and that is not already inserted
      //is added to the diagram.
      C := (E as TClass);
      for i:= 0 to C.AncestorsCount - 1 do
        if (C.Ancestor[i].Owner <> E.Owner) and
          (GetBox(C.Ancestor[i].FullName) = nil) then begin
            Panel.AddManagedObject(InCreateBox(C.Ancestor[i], TRtfdClass));
        end;
      //Attribute associations that are in other packages are added
      Mi := C.GetAttributes;
      while Mi.HasNext do begin
        A := TAttribute(Mi.Next);
        if Assigned(A.TypeClassifier) and (GetBox(A.TypeClassifier.FullName) = nil) and
          (A.TypeClassifier <> C) and (A.TypeClassifier <> C.Ancestor[0]) and  // ToDo n ancestors
          (A.TypeClassifier.Owner <> Model.UnknownPackage) then
        begin
          if A.TypeClassifier is TClass then
            Panel.AddManagedObject(InCreateBox(A.TypeClassifier,TRtfdClass) );
          if A.TypeClassifier is TInterface then
            Panel.AddManagedObject(InCreateBox(A.TypeClassifier, TRtfdInterface) );
        end;
      end;
    end;
    if E.IsVisible and (GetBox(E.getFullnameWithoutOuter) = nil)
      then Panel.AddManagedObject(InCreateBox(E, TRtfdClass));
  end
  else if E is TObjekt then begin
    if GetBox(E.FullName) = nil then
      Panel.AddManagedObject(InCreateBox(E, TRtfdObject));
  end;
end;

//Make arrows between boxes
procedure TRtfdDiagram.ResolveAssociations;
var
  i, j, p : Integer;
  CBox: TRtfdClass;
  aClass: TClass;
  A : TAttribute;
  OBox: TRtfdObject;

  UBox : TRtfdUnitPackage;
  U : TUnitPackage;
  Dep : TUnitDependency;

  Mi : IModelIterator;
  DestBox: TRtfdBox;
  s, Agg, Ass: string;
  AttributeConnected: Boolean;

begin
  Panel.DeleteNotEditedConnections;
  Panel.DeleteObjectConnections;    // why?
  for i:= 0 to BoxNames.Count - 1 do
    if (BoxNames.Objects[i] is TRtfdClass) then begin //Class
      CBox:= (BoxNames.Objects[i] as TRtfdClass);
      //Ancestors
      for j:= 0 to (CBox.Entity as TClass).AncestorsCount - 1 do begin
        aClass:= CBox.Entity as TClass;
        if Assigned(aClass) then begin
          DestBox := GetBox( aClass.Ancestor[j].FullName );
          if Assigned(DestBox) then
            Panel.ConnectObjects(CBox, DestBox, asInheritends);
        end;
      end;
      p:= Pos('.', CBox.Entity.Name);
      if p > 0 then begin
        DestBox:= GetBox(Copy(CBox.Entity.Name, 1, p-1));
        if Assigned(DestBox) then
          Panel.ConnectObjects(DestBox, CBox, asAssociation2);
      end;

      //Attributes associations
      AttributeConnected:= False;
      aClass:= CBox.Entity as TClass;
      Mi := aClass.GetAttributes;
      while Mi.HasNext do begin
        AttributeConnected:= False;
        A := TAttribute(Mi.Next);
        // avoid arrows that points to themselves, also associations to ancestor (double arrows)
        if Assigned(A.TypeClassifier) then begin
          for j:= 0 to aClass.AncestorsCount - 1 do
            if (A.TypeClassifier = aClass.Ancestor[j]) and Assigned(getBox(A.TypeClassifier.Name)) then
              A.Connected:= True;
          s:= A.TypeClassifier.Fullname;
          if (Pos('[', s) > 0) and (Pos(']', s) > 0) then begin // Typ[], i.e. list[aClass]
            Agg:= Copy(s, Pos('[', s) + 1, Length(s));
            Agg:= Copy(Agg, 1, Pos(']', Agg) - 1);
            DestBox:= GetBox(Agg);
            if not Assigned(DestBox) and (Pos('.', Agg) = 0) and (CBox.Entity.Package <> '') then begin
              Agg:= CBox.Entity.Package + '.' + Agg;
              DestBox:= GetBox(Agg);
            end;
            if Assigned(DestBox) and (Panel.HaveConnection(CBox, DestBox) = -1) then
              Panel.ConnectObjects(CBox, DestBox, asAggregation1);
          end else if IsPythonType(s)
            then Continue
          else begin
            Ass:= s;
            DestBox:= GetBox(Ass);
            if not Assigned(DestBox) and (Pos('.', Ass) = 0) and (CBox.Entity.Package <> '') then begin
              Ass:= CBox.Entity.Package + '.' + Ass;
              DestBox:= GetBox(Ass);
            end;
            if Assigned(DestBox) then
              if Panel.HaveConnection(CBox, DestBox) = -1  then
                Panel.ConnectObjects(CBox, DestBox, asAssociation2)
              else begin
                p:= Panel.HaveConnection(DestBox, CBox, asAssociation2);
                if p > -1 then
                  Panel.SetConnection(p, asAssociation3)
              end;
          end;
          if Assigned(DestBox) and (Panel.HaveConnection(CBox, DestBox) > -1) and DestBox.Entity.IsVisible then begin
            A.Connected:= True;
            AttributeConnected:= True;
          end;
        end;
      end;
      if AttributeConnected then
        CBox.RefreshEntities;
    end else if (BoxNames.Objects[I] is TRtfdUnitPackage) then begin
      //Unit
      UBox := (BoxNames.Objects[I] as TRtfdUnitPackage);
      U := UBox.Entity as TUnitPackage;
      Mi := U.GetUnitDependencies;
      while Mi.HasNext do begin
        Dep := Mi.Next as TUnitDependency;
        if Dep.Visibility = viPublic then begin
          DestBox:= GetBox( Dep.myPackage.FullName );
          if Assigned(DestBox) then
            Panel.ConnectObjects(UBox, DestBox, asAssociation2);
        end;
      end;
    end
    else if (BoxNames.Objects[i] is TRtfdObject) then begin
      // connect Objects to Classes
      OBox:= (BoxNames.Objects[I] as TRtfdObject);
      if Assigned(OBox.Entity) then begin
        DestBox:= GetBox(FLivingObjects.getClassnameOfObject(OBox.Entity.Name));
        if Assigned(DestBox) then
          Panel.ConnectObjects(OBox, DestBox, asInstanceOf);
      end;
    end;
  Panel.ShowAll;
end;

procedure TRtfdDiagram.ShowRelationshipAttributesBold;
var
  i, j: Integer;
  CBox: TRtfdClass;
  aClass: TClass;
  A : TAttribute;
  Mi : IModelIterator;
  DestBox: TRtfdBox;
  Ass, Agg, s: string;
begin
  for i:= 0 to BoxNames.Count - 1 do begin
    if (BoxNames.Objects[i] is TRtfdClass) then begin //Class
      CBox:= (BoxNames.Objects[i] as TRtfdClass);
      aClass:= CBox.Entity as TClass;
      Mi := aClass.GetAttributes;
      while Mi.HasNext do begin
        A := TAttribute(Mi.Next);
        if Assigned(A.TypeClassifier) then begin
          for j:= 0 to aClass.AncestorsCount - 1 do
            if (A.TypeClassifier = aClass.Ancestor[j]) and Assigned(getBox(A.TypeClassifier.Name)) then
              A.Connected:= True;
          s:= A.TypeClassifier.Fullname;
          if (Pos('[', s) > 0) and (Pos(']', s) > 0) then begin // Typ[], i.e. list[aClass]
            Agg:= Copy(s, Pos('[', s) + 1, Length(s));
            Agg:= Copy(Agg, 1, Pos(']', Agg) - 1);
            DestBox:= GetBox(Agg);
            if not Assigned(DestBox) and (Pos('.', Agg) = 0) and (CBox.Entity.Package <> '') then begin
              Agg:= CBox.Entity.Package + '.' + Agg;
              DestBox:= GetBox(Agg);
            end;
          end else if IsPythonType(s)
            then Continue
          else begin
            Ass:= s;
            DestBox:= GetBox(Ass);
            if not Assigned(DestBox) and (Pos('.', Ass) = 0) and (CBox.Entity.Package <> '') then begin
              Ass:= CBox.Entity.Package + '.' + Ass;
              DestBox:= GetBox(Ass);
            end;
          end;
          if Assigned(DestBox) and (Panel.HaveConnection(CBox, DestBox) > -1) and DestBox.Entity.IsVisible then
            A.Connected:= True;
        end;
      end;
    end;
  end;
end;

// make arrows between Objects
procedure TRtfdDiagram.ResolveObjectAssociations;
  var
    i, j: Integer;
    SLObjectAttributes: TStringList;
    OBox: TRtfdObject;
    DestBox: TRtfdBox;
begin
  Panel.DeleteObjectConnections;
  for i:= 0 to BoxNames.Count - 1 do begin
    if Assigned(BoxNames.Objects[i]) and (BoxNames.Objects[i] is TRtfdObject) then begin  // reconnect Objects
      OBox:= BoxNames.Objects[i] as TRtfdObject;
      if Assigned(OBox.Entity) then begin
        SLObjectAttributes:= FLivingObjects.getObjectObjectMembers(OBox.Entity.Name);
        for j:= 0 to SLObjectAttributes.Count - 1 do begin
          DestBox:= GetBox(SLObjectAttributes[j]);
          if Assigned(DestBox) then
            Panel.ConnectObjects(OBox, DestBox, asAssociation2);
        end;
        FreeAndNil(SLObjectAttributes);

        DestBox:= GetBox(FLivingObjects.getClassnameOfObject(OBox.Entity.Name));
        if Assigned(DestBox) and (Panel.HaveConnection(OBox, DestBox) = -1) then
          Panel.ConnectObjects(OBox, DestBox, asInstanceOf);
      end;
    end;
  end;
  Panel.ShowAll;
end;

procedure TRtfdDiagram.SetPackage(const Value: TAbstractPackage);
begin
  if Assigned(FPackage) and (FPackage is TUnitPackage) then
    FPackage.RemoveListener(IAfterUnitPackageListener(Self));
  inherited SetPackage(Value);
  if Assigned(FPackage) then begin
    if (FPackage is TUnitPackage)
      then FPackage.AddListener(IAfterUnitPackageListener(Self));
    if (FPackage is TLogicPackage)
      then FPackage.AddListener(IAfterUnitPackageListener(Self));
  end;
  if Assigned(Frame.ScrollBox) and Assigned(GuiPyOptions) then begin
    Frame.ScrollBox.HorzScrollBar.Position := 0;
    Frame.ScrollBox.VertScrollBar.Position := 0;
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

procedure TRtfdDiagram.StoreDiagram(FileName: string);
var
  Ini : TMemIniFile;
  p, comments: Integer;
  Box: TRtfdBox;
  S, C, fname, s1, path: string;
  Connections: TList;
  Conn: TConnection;
  Values: TStrings;

begin
  Values:= TStringList.Create;
  if FileExists(FileName) then begin
    Ini:= TMemIniFile.Create(FileName);
    Ini.ReadSectionValues('Window', Values);
    FreeAndNil(Ini);
  end;
  DeleteFile(FileName);

  path:= ExtractFilePath(FileName);
  if isUNC(path)
    then path:= ''
    else SetCurrentDir(path); // due to relativ paths

  Ini:= TMemIniFile.Create(FileName, TEncoding.UTF8);
  try
    try
      //Boxes
      comments:= 0;
      for var I:= 0 to BoxNames.Count - 1 do begin
        if BoxNames.Objects[I] is TRtfdObject then begin
          // Objects
          Box:= BoxNames.Objects[I] as TRtfdObject;
          S:= 'Object: ' + Box.Entity.FullName;
          Ini.WriteInteger(S, 'X', PPIUnScale(Box.Left));
          Ini.WriteInteger(S, 'Y', PPIUnScale(Box.Top));
          Ini.WriteString(S, 'Name', Box.Entity.Name);
          if FLivingObjects.ObjectExists(Box.Entity.Name)
            then Ini.WriteString(S, 'Typ', FLivingObjects.getClassnameOfObject(Box.Entity.Name))
            else Ini.WriteString(S, 'Typ','unknown')
        end else if BoxNames.Objects[I] is TRtfdCommentBox then begin
          // Comments
          Box:= BoxNames.Objects[I] as TRtfdBox;
          S:= Box.Entity.FullName;
          Ini.WriteInteger(S, 'X', PPIUnScale(Box.Left));
          Ini.WriteInteger(S, 'Y', PPIUnScale(Box.Top));
          Ini.WriteInteger(S, 'W', PPIUnScale(Box.Width));
          Ini.WriteInteger(S, 'H', PPIUnScale(Box.Height));
          s1:= (Box as TRtfdCommentBox).TrMemo.Text;
          Ini.WriteString(S, 'Comment', myStringReplace(s1, #13#10, '_;_'));
        end else begin
          // Class
          Box:= BoxNames.Objects[I] as TRtfdBox;
          if Box.Entity.IsVisible then begin
            S:= 'Box: ' + Box.Entity.FullName;
            fName:= RemovePortableDrive((Box.Entity as TClassifier).Pathname, path);
            Ini.WriteString(S, 'File', fName);
            Ini.WriteInteger(S, 'X', PPIUnScale(Box.Left));
            Ini.WriteInteger(S, 'Y', PPIUnScale(Box.Top));
            Ini.WriteInteger(S, 'MinVis', Integer(Box.MinVisibility));
            Ini.WriteInteger(S, 'ShowParameter', Box.ShowParameter);
            Ini.WriteInteger(S, 'SortOrder', Box.SortOrder);
            Ini.WriteInteger(S, 'ShowIcons', Box.ShowIcons);
            if Box.TypeBinding <> '' then
              Ini.WriteString(S, 'TypeBinding', Box.TypeBinding);
          end;
        end;
      end;

      //Diagram stuff
      s:= 'Diagram';
      Ini.WriteInteger(S, 'comments', comments);
      Ini.WriteInteger(S, 'OffsetX', Frame.ScrollBox.VertScrollBar.Position);
      Ini.WriteInteger(S, 'OffsetY', Frame.ScrollBox.HorzScrollBar.Position);

      Ini.WriteInteger(S, 'Visibility', Integer(VisibilityFilter));
      Ini.WriteInteger(S, 'ShowParameter', Showparameter);
      Ini.WriteInteger(S, 'SortOrder', SortOrder);
      Ini.WriteInteger(S, 'ShowIcons', ShowIcons);
      Ini.WriteInteger(S, 'ShowConnections', ShowConnections);
      Ini.WriteString (S, 'Fontname', Font.Name);
      Ini.WriteInteger(S, 'Fontsize', PPIUnScale(Font.Size));
      Ini.WriteBool   (S, 'ShowObjectDiagram', ShowObjectDiagram);

      // Connections
      s:= 'Connections';
      Connections:= Panel.GetConnections;
      for var I:= 0 to Connections.Count - 1 do begin
        Conn:= TConnection(Connections[I]);
        with conn do
          c:= (FFrom as TRtfdBox).Entity.FullName + '#' +
              (FTo as TRtfdBox).Entity.FullName + '#' +
              ArrowStyleToString(ArrowStyle) + '#' +
              HideCrLf(MultiplicityA) + '#' + Relation + '#' + HideCrLf(MultiplicityB) + '#' +
              IntToStr(RecursivCorner) + '#' + BoolToStr(isTurned) + '#' +
              BoolToStr(isEdited) + '#' +
              HideCrLf(RoleA) + '#' + HideCrLf(RoleB) + '#' +
              BoolToStr(ReadingOrderA) + '#' + BoolToStr(ReadingOrderB);
         Ini.WriteString(S, 'V' + IntToStr(I), c);
      end;
      FreeAndNil(Connections);

      // Interactive
      for var I:= 0 to UMLForm.InteractiveLines.Count - 1 do
        Ini.WriteString('Interactive', 'I' + IntToStr(I), UMLForm.InteractiveLines[I]);

      // Window
      for var I:= 0 to Values.Count - 1 do begin
        s:= Values[I];
        p:= Pos('=', s);
        Ini.WriteString('Window', Copy(s, 1, p - 1), Copy(s, p + 1, Length(s)));
      end;

      Ini.UpdateFile;
    except
      on e: Exception do begin
        ErrorMsg(e.Message);
      end;
    end;
  finally
    FreeAndNil(Ini);
  end;

  FreeAndNil(Values);
  Panel.IsModified:= False;
end;

procedure TRtfdDiagram.FetchDiagram(FileName: string);
var
  Ini: TMemIniFile;
  i, j, p, CountObjects: Integer;
  Box, Box1, Box2: TRtfdBox;
  s, c, aFile, b1, b2, path: string;
  Files, Sections, SL: TStringList;
  AllBoxes: TList;

  UnitPackage: TUnitPackage;
  theClassname: string;
  theObjectname: string;
  aModelObject: TObjekt;

  Attributes: TConnectionAttributes;
  aClass: TClass;
  aClassifier: TClassifier;

  BoxShowParameter, BoxSortorder, BoxShowIcons: Integer;
  BoxTypeBinding: string;
  CommentBox: TRtfdCommentBox;
  VisibilityFilterAsInteger: Integer;
begin
  FileName:= ExpandFileName(FileName);
  Ini:= TMemIniFile.Create(FileName);
  Files:= TStringList.Create;
  Sections:= TStringList.Create;
  Attributes:= TConnectionAttributes.Create;
  try
    s:= 'Diagram';
    Frame.ScrollBox.VertScrollBar.Position:= Ini.ReadInteger(S, 'OffsetX', Frame.ScrollBox.VertScrollBar.Position);
    Frame.ScrollBox.HorzScrollBar.Position:= Ini.ReadInteger(S, 'OffsetY', Frame.ScrollBox.HorzScrollBar.Position);

    ShowConnections:= Ini.ReadInteger(S, 'ShowConnections', 0);
    VisibilityFilterAsInteger:= Ini.ReadInteger(S, 'Visibility', 0);
    VisibilityFilter:= TVisibility(VisibilityFilterAsInteger);
    ShowParameter:= Ini.ReadInteger(S, 'ShowParameter', ShowParameter);
    SortOrder:= Ini.ReadInteger(S, 'SortOrder', SortOrder);
    ShowIcons:= Ini.ReadInteger(S, 'ShowIcons', ShowIcons);
    ShowObjectDiagram:= Ini.ReadBool(S, 'ShowObjectDiagram', False);
    Font.Name:= Ini.ReadString(S, 'Fontname', 'Segoe UI');
    Font.Size:= PPIScale(Ini.ReadInteger(S, 'Fontsize', 11));
    setFont(Font);

    // read files
    path:= ExtractFilePath(FileName);
    if isUNC(path)
      then path:= ''
      else SetCurrentDir(path); // due to relativ paths
    Ini.ReadSections(Sections);
    for i:= 0 to Sections.Count - 1 do begin
      if Pos('Box: ', Sections[i]) > 0 then begin
        aFile:= Ini.ReadString(Sections[i], 'File', '');
        if aFile <> '' then begin
          aFile:= ExpandFileName(AddPortableDrive(aFile, path));
          if not FileExistsCaseSensitive(aFile) then
            aFile:= ExtractFilePath(FileName) + extractFilename(aFile);
          if FileExistsCaseSensitive(aFile) and (Files.IndexOf(aFile) = -1) then
            Files.Add(aFile);
        end;
      end;
    end;
    UMLForm.MainModul.LoadProject(Files);

    // read classes
    for i:= BoxNames.Count - 1 downto 0 do begin
      Box:= BoxNames.Objects[i] as TRtfdBox;
      if BoxNames.Objects[i] is TRtfdClass then begin
        S:= 'Box: ' + Box.Entity.FullName;
        if Ini.SectionExists(S) then begin
          Box.Left:= PPIScale(Ini.ReadInteger(S, 'X', Box.Left));
          Box.Top := PPIScale(Ini.ReadInteger(S, 'Y', Box.Top));
          Box.MinVisibility:= TVisibility(Ini.ReadInteger(S, 'MinVis', VisibilityFilterAsInteger));
          BoxShowParameter:= Ini.ReadInteger(S, 'ShowParameter', ShowParameter);
          BoxSortOrder:= Ini.ReadInteger(S, 'SortOrder', SortOrder);
          BoxShowIcons:= Ini.ReadInteger(S, 'ShowIcons', ShowIcons);
          BoxTypeBinding:= Ini.ReadString(S, 'TypeBinding', '');
          Box.SetParameters(BoxShowParameter, BoxSortOrder, BoxShowIcons, Font, BoxTypeBinding);
        end else
          TManagedObject(Panel.FindManagedControl(Box)).Selected:= True;
      end;
    end;
    DeleteSelectedControls(nil);

    // read objects
    CountObjects:= 0;
    for i:= 0 to Sections.Count - 1 do begin
      if Pos('Object: ', Sections[i]) > 0 then begin
        S:= Sections[i];
        UnitPackage:= Model.ModelRoot.FindUnitPackage('Default');
        if not Assigned(UnitPackage) then
          UnitPackage:= Model.ModelRoot.AddUnit('Default');
        theClassname := Ini.ReadString(S, 'Typ', '');
        theObjectname:= Ini.ReadString(S, 'Name', '');

        aClass:= nil;
        if FLivingObjects.ObjectExists(theObjectname) then begin
          j:= BoxNames.IndexOf(theClassname);
          if j >= 0 then
            aClass:= ((BoxNames.Objects[j] as TRtfdClass).Entity) as TClass
        end else
          theObjectname:= '';
        if aClass = nil then begin
          aClassifier:= UnitPackage.FindClassifier(theClassname, TClass, True);
          if Assigned(aClassifier) then
            aClass:= aClassifier as TClass
          else begin
            aClass:= TClass.Create(nil);
            aClass.Name:= theClassname;
            UnitPackage.AddClass(aClass);
          end;
        end;

        if theObjectname <> '' then begin
          aModelObject:= UnitPackage.AddObject(theObjectname, aClass);
          ShowAttributes(theObjectname, aClass, aModelObject);
          j:= BoxNames.IndexOf(theObjectname);
          if j = -1 then begin
            AddBox(aModelObject);
            j:= BoxNames.IndexOf(theObjectname);
          end;

          if j > -1 then begin
            Box:= BoxNames.Objects[j] as TRtfdBox;
            Box.Left:= PPIScale(Ini.ReadInteger(S, 'X', Box.Left));
            Box.Top := PPIScale(Ini.ReadInteger(S, 'Y', Box.Top));
            Box.Font.Assign(Font);
          end;
          Inc(CountObjects);
        end;
      end;
    end;
    Panel.DeleteConnections;

    // read comments
    for i:= 0 to Sections.Count - 1 do begin
      if Pos('Comment: ', Sections[i]) = 1 then begin
        S:= Sections[i];
        j:= BoxNames.IndexOf(S);
        if j = -1 then begin
          CommentBox:= TRtfdCommentBox.Create(Panel, S, Frame, viPublic, HANDLESIZE);
          BoxNames.AddObject(S, CommentBox);
          Panel.AddManagedObject(CommentBox);
          j:= BoxNames.IndexOf(S);
        end;
        if j > -1 then begin
          Box:= BoxNames.Objects[j] as TRtfdBox;
          Box.Left:= PPIScale(Ini.ReadInteger(S, 'X', Box.Left));
          Box.Top := PPIScale(Ini.ReadInteger(S, 'Y', Box.Top));
          Box.Width:= PPIScale(Ini.ReadInteger(S, 'W', Box.Width));
          Box.Height:= PPIScale(Ini.ReadInteger(S, 'H', Box.Height));
          Box.Font.Assign(Font);
          s:= Ini.ReadString(S, 'Comment', '');
          (Box as TRtfdCommentBox).TrMemo.Text:= myStringReplace(s, '_;_', #13#10);
        end;
      end;
    end;
    Panel.DeleteConnections;
    AllBoxes:= Panel.GetManagedObjects;

    S:= 'Connections';
    i:= 0;
    repeat
      c:= Ini.ReadString(S, 'V' + IntToStr(i), '');
      if c <> '' then begin
        Box1:= nil;
        Box2:= nil;
        SL:= Split('#', c);
        b1:= Trim(SL[0]);
        b2:= Trim(SL[1]);
        Attributes.ArrowStyle:= StringToArrowStyle(SL[2]);
        Attributes.MultiplicityA:= UnhideCrLf(SL[3]);
        Attributes.Relation:= SL[4];
        Attributes.MultiplicityB:= UnhideCrLf(SL[5]);
        Attributes.RecursivCorner:= StrToInt(SL[6]);
        Attributes.isTurned:= StrToBool(SL[7]);
        Attributes.isEdited:= StrToBool(SL[8]);
        Attributes.RoleA:= UnhideCrLf(SL[9]);
        Attributes.RoleB:= UnhideCrLf(SL[10]);
        Attributes.ReadingOrderA:= StrToBool(SL[11]);
        Attributes.ReadingOrderB:= StrToBool(SL[12]);
        for j:= 0 to AllBoxes.Count-1 do begin
          Box:= TRtfdBox(AllBoxes[j]);
          if Box.Entity.FullName = b1 then Box1:= Box;
          if Box.Entity.FullName = b2 then Box2:= Box;
        end;
        Panel.ConnectObjects(Box1, Box2, Attributes);
        FreeAndNil(SL);
      end;
      Inc(i);
    until c = '';
    FreeAndNil(AllBoxes);
    if GuiPyOptions.RelationshipAttributesBold then
      ShowRelationshipAttributesBold;

    Panel.SetConnections(ShowConnections);
    if CountObjects = 0
      then SetShowObjectDiagram(False)
      else SetShowObjectDiagram(ShowObjectDiagram);
    FLivingObjects.makeAllObjects;
    UpdateAllObjects;

    // read interactive lines
    SL:= TStringList.Create;
    Ini.ReadSectionValues('Interactive', SL);
    for i:= 0 to SL.Count - 1 do begin
      s:= SL[i];
      p:= Pos('=', s);
      Delete(s, 1, p);
      SL[i]:= s;
    end;
    UMLForm.InteractiveLines:= SL;
    FreeAndNil(SL);
  finally
    FreeAndNil(Ini);
    FreeAndNil(Files);
    FreeAndNil(Attributes);
    FreeAndNil(Sections);
  end;
  Panel.RecalcSize;
  Panel.IsModified := False;
  Panel.ShowAll;
  if Panel.CanFocus then
    Panel.SetFocus;
end;

procedure TRtfdDiagram.DoLayout;
begin
  if BoxNames.Count > 0 then begin
    Panel.Hide;
    var Layout:= TSugiyamaLayout.Create(Panel.GetManagedObjects, Panel.GetConnections);
    try
      Layout.Execute;
    finally
      Panel.Show;
      FreeAndNil(Layout);
    end;
    Panel.IsModified:= True;
    Panel.RecalcSize;
    Panel.ShowAll;
  end;
end;

function TRtfdDiagram.GetBox(typ: string): TRtfdBox;
  var i: Integer; s: string;
begin
  typ:= withoutGeneric(typ);
  i:= 0;
  while i < BoxNames.Count do begin
    s:= withoutGeneric(BoxNames[i]);
    if typ = s then
      Break;
    Inc(i);
  end;
  if i = BoxNames.Count
    then Result:= nil
    else Result:= BoxNames.Objects[i] as TRtfdBox;
end;

procedure TRtfdDiagram.SetVisibilityFilter(const Value: TVisibility);
  var B: TRtfdBox; L: TList; i: Integer;
begin
  if Panel.CountSelectedControls > 0
    then L:= Panel.GetSelectedControls
    else L:= Panel.GetManagedObjects;
  Panel.Hide;
  try
    for i:= 0 to L.Count-1 do
      if TObject(L[i]) is TRtfdBox then begin
        B:= TObject(L[i]) as TRtfdBox;
        if B.MinVisibility <> Value then begin
          B.MinVisibility:= Value;
          Panel.isModified:= True;
        end;
      end;
  finally
    FreeAndNil(L);
  end;
  Panel.RecalcSize;
  Panel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetShowView(Value: Integer);
  var i, objs: Integer; L: TList; B: TRtfdBox;
begin
  L:= Panel.GetManagedObjects;
  Panel.Hide;
  try
    objs:= 0;
    for i:= 0 to L.Count-1 do
      if TObject(L[i]) is TRtfdObject then
        Inc(objs);
    if (objs = 0) and (Value = 1) then
      Value:= 2;
    for i:= 0 to L.Count-1 do begin
      B:= TObject(L[i]) as TRtfdBox;
      case value of
        0: B.MinVisibility:= TVisibility(0);
        1: if B is TRtfdClass
             then B.MinVisibility:= TVisibility(3)
             else B.MinVisibility:= TVisibility(0);
        2: B.MinVisibility:= TVisibility(3);
      end;
    end;
  finally
    FreeAndNil(L);
  end;
  Panel.isModified:= True;
  Panel.RecalcSize;
  Panel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetShowParameter(const Value: Integer);
  var i: Integer; L: TList; B: TRtfdBox;
begin
  if Panel.CountSelectedControls > 0
    then L:= Panel.GetSelectedControls
    else L:= Panel.GetManagedObjects;
  Panel.Hide;
  try
    for i:= 0 to L.Count-1 do begin
      B:= TObject(L[i]) as TRtfdBox;
      if B.ShowParameter <> Value then begin
        B.ShowParameter:= Value;
        Panel.isModified:= True;
      end;
    end;
  finally
    FreeAndNil(L);
  end;
  Panel.RecalcSize;
  Panel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetSortOrder(const Value: Integer);
  var i: Integer; L: TList; B: TRtfdBox;
begin
  if Panel.CountSelectedControls > 0
    then L:= Panel.GetSelectedControls
    else L:= Panel.GetManagedObjects;
  Panel.Hide;
  try
    for i:= 0 to L.Count-1 do begin
      B:= TObject(L[i]) as TRtfdBox;
      if B.SortOrder <> Value then begin
        B.SortOrder:= Value;
        Panel.IsModified:= True;
      end;
    end;
  finally
    FreeAndNil(L);
  end;
  Panel.RecalcSize;
  Panel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetShowIcons(const Value: Integer);
  var i: Integer; L: TList; B: TRtfdBox;
begin
  if Panel.CountSelectedControls > 0
    then L:= Panel.GetSelectedControls
    else L:= Panel.GetManagedObjects;
  Panel.Hide;
  try
    for i:= 0 to L.Count-1 do begin
      B:= TObject(L[i]) as TRtfdBox;
      if (B is TRtfdObject) and GuiPyOptions.ObjectsWithoutVisibility then
        Continue;
      if B.ShowIcons <> Value then begin
        B.ShowIcons:= Value;
        Panel.IsModified:= True;
      end;
    end;
  finally
    FreeAndNil(L);
  end;
  Panel.RecalcSize;
  Panel.Show;
  inherited;
end;

procedure TRtfdDiagram.SetFont(const aFont: TFont);
  var i: Integer; L: TList; B: TRtfdBox;
begin
  inherited;
  L:= Panel.GetManagedObjects;
  try
    for i:= 0 to L.Count - 1 do begin
      B:= TObject(L[i]) as TRtfdBox;
      if Assigned(B) and Assigned(B.Font) then
        B.Font.Assign(aFont);
    end;
  finally
    FreeAndNil(L);
  end;
  Panel.Font.Assign(aFont);
end;

procedure TRtfdDiagram.GetDiagramSize(var W, H: Integer);
begin
  Panel.GetDiagramSize(W, H);
end;

//Returns list with str = 'x1,y1,x2,y2', obj = modelentity
function TRtfdDiagram.GetClickAreas: TStringList;
var
  I : Integer;
  Box : TRtfdBox;
  S : string;
begin
  Result := TStringList.Create;
  for I := 0 to BoxNames.Count-1 do begin
    Box := BoxNames.Objects[I] as TRtfdBox;
    S := IntToStr(Box.Left) + ',' + IntToStr(Box.Top) + ',' +
      IntToStr(Box.Left + Box.Width) + ',' + IntToStr(Box.Top + Box.Height);
    Result.AddObject(S,Box.Entity);
  end;
end;

procedure TRtfdDiagram.ClassEditSelectedDiagramElementsControl(Sender: TObject);
  var Pathname: string; aBox: TRtfdBox;
    Editor: IEditor; aFile: IFile;
begin
  LockFormUpdate(PyIDEMainForm);
  aBox:= (Sender as TRtfdBox);
  if (aBox is TRtfdClass) and Assigned(GetBox(aBox.Entity.FullName)) then begin
    aFile:= GI_PyIDEServices.getActiveFile;
    Pathname:= ChangeFileExt(aBox.GetPathname, '.py');
    Editor:= IEditor(PyIDEMainForm.DoOpen(Pathname));
    if Assigned(Editor) then begin
      if Editor.Modified then
        TFileForm(Editor.Form).DoSave;
      if Assigned(aFile) and (aFile.FileKind = fkUML) then
        PyIDEMainForm.PrepareClassEdit(Editor, 'Edit', TFUMLForm(aFile.Form));
    end;
    aFile.Activate;
  end;
  Panel.ClearSelection;
  UnlockFormUpdate(PyIDEMainForm);
end;

procedure TRtfdDiagram.ClassEditSelectedDiagramElements;
  var C: TControl;
begin
  C:= Panel.GetFirstSelected;
  if not Assigned(C) then
    C:= Panel.GetFirstManaged;
  if Assigned(C) then
    ClassEditSelectedDiagramElementsControl(C);
end;

procedure TRtfdDiagram.SourceEditSelectedDiagramElements(C: TControl);
  var FileName: string;
begin
  Panel.ClearSelection;
  if Assigned(C) and (C is TRtfdBox) then begin
    FileName:= (C as TRtfdBox).GetPathname;
    if FileExists(FileName) then
      PyIDEMainForm.DoOpen(FileName);
  end;
end;

procedure TRtfdDiagram.DeleteSelectedControls(Sender: TObject);
var
  C: TControl;
  L: TObjectList;
  Box: TRtfdBox;
  U : TUnitPackage;
  i, k: Integer;
  key: string;
  aObject: TObject;

  function CountClassesWith(const classname: string): Integer;
    var
      C: TControl;
      L: TList;
      Box: TRtfdBox;
      s: string;
      i: Integer;
  begin
    Result:= 0;
    L:= Panel.GetManagedObjects;
    for i:= 0 to L.Count-1 do begin
      C:= TControl(L[i]);
      if C is TRtfdBox then begin
        Box:= C as TRtfdBox;
        if C is TRtfdClass then begin
          s:= Box.Entity.Name;
          Delete(s, 1, LastDelimiter('.', s));
          //if Pos(classname, s) = 1 then inc(Result);
          if classname = s then Inc(Result);
        end;
      end;
    end;
    FreeAndNil(L);
  end;

begin
  L:= Panel.GetSelectedControls;
  try
    for i:= 0 to L.Count-1 do begin
      C:= L[i] as TControl;
      if C is TRtfdBox then begin
        Box:= C as TRtfdBox;
        if C is TRtfdClass then begin
          Box.Entity.isVisible:= False;
          k:= BoxNames.IndexOf(Box.Entity.FullName);
          if k > -1 then begin
            if Assigned(BoxNames.Objects[k]) then begin
              aObject:= BoxNames.Objects[k];
              FreeAndNil(aObject);
            end;
            BoxNames.Delete(k);
          end
        end else if (C is TRtfdObject) then begin
          key:= (C as TRtfdObject).Entity.Name;
          ShowObjectDeleted('Actor', key);
          k:= BoxNames.IndexOf(key);
          if k > -1 then begin
            if Assigned(BoxNames.Objects[k]) then begin
              aObject:= BoxNames.Objects[k];
              FreeAndNil(aObject);
            end;
            BoxNames.Delete(k);
          end;
          if FLivingObjects.ObjectExists(key) then begin
            PyControl.ActiveInterpreter.RunSource('del ' + key, '<interactive input>');
            FLivingObjects.DeleteObject(key);
          end;
          U:= Model.ModelRoot.FindUnitPackage('Default');
          U.DeleteObject(key);                               // diagram-level
        end else if (C is TRtfdCommentBox) then begin
          key:= (C as TRtfdCommentBox).Entity.Name;
          k:= BoxNames.IndexOf(key);
          if k > -1 then begin
            if Assigned(BoxNames.Objects[k]) then begin
              aObject:= BoxNames.Objects[k];
              FreeAndNil(aObject);
            end;
            BoxNames.Delete(k);
          end;
        end;
      end;
    end;
  finally
    Panel.DeleteSelectedControls;
    FreeAndNil(L);
  end;
  ResolveObjectAssociations;
end;

procedure TRtfdDiagram.DeleteSelectedControlsAndRefresh;
begin
  LockFormUpdate(UMLForm);
  DeleteSelectedControls(nil);
  UMLForm.SaveAndReload;
  UMLForm.CreateTVFileStructure;
  UnlockFormUpdate(UMLForm);
end;

procedure TRtfdDiagram.UnSelectAllElements;
begin
  if Assigned(Panel) then
    Panel.ClearSelection(False)
end;

procedure TRtfdDiagram.CurrentEntityChanged;
var
  P : TModelEntity;
begin
  inherited;

  P := CurrentEntity;
  while Assigned(P) and (not (P is TAbstractPackage)) do
    P := P.Owner;

  if Assigned(P) and (P<>Package) then
  begin
    Package := P as TAbstractPackage;
    InitFromModel;
  end;

  if CurrentEntity is TClass then
    ScreenCenterEntity(CurrentEntity);
end;

function TRtfdDiagram.GetSelectedRect: TRect;
begin
  Result:= Panel.GetSelectedRect;
end;

procedure TRtfdDiagram.ScreenCenterEntity(E: TModelEntity);
var
  I : Integer;
  Box : TRtfdBox;
begin
  for I := 0 to BoxNames.Count-1 do
    if TRtfdBox(BoxNames.Objects[I]).Entity = E then begin
      Box := TRtfdBox(BoxNames.Objects[I]);
      Frame.ScrollBox.ScrollInView(Box);
      Break;
    end;
end;

procedure TRtfdDiagram.SetShowObjectDiagram(const Value: Boolean);
begin
  UMLForm.TBObjectDiagram.Down:= Value;
  inherited SetShowObjectDiagram(Value);
  Panel.SetShowObjectDiagram(Value);
end;

procedure TRtfdDiagram.RefreshDiagram;
begin
  if not PanelIsLocked then
    for var i:= 0 to BoxNames.Count - 1 do
      (BoxNames.Objects[I] as TRtfdBox).RefreshEntities;
  Panel.RecalcSize;
  Panel.ShowAll;
  Panel.IsModified:= True;
end;

function TRtfdDiagram.HasAInvalidClass: Boolean;
begin
  for var i:= 0 to BoxNames.Count - 1 do
    if (BoxNames.Objects[i] is TRtfdClass) then begin
      var path:= (BoxNames.Objects[i] as TRtfdClass).getPathname;
      if not PyIDEMainForm.IsAValidClass(path) then Exit(True);
    end;
   Result:= False;
end;

procedure TRtfdDiagram.RecalcPanelSize;
begin
  Panel.RecalcSize;
end;

procedure TRtfdDiagram.SetConnections(const Value: Integer);
begin
  if Value <> ShowConnections then begin
    Panel.IsModified:= True;
    inherited SetConnections(Value);
    Panel.SetConnections(Value);
  end;
  inherited;
end;

procedure TRtfdDiagram.SelectAssociation;
begin
  Panel.SelectAssociation;
end;

function TRtfdDiagram.GetPanel: TCustomPanel;
begin
  Result:= Panel;
end;

procedure TRtfdDiagram.Retranslate;
begin
  Frame.Retranslate;
end;

procedure TRtfdDiagram.Run(C: TControl);
begin
  if Assigned(GetBox((C as TRtfdBox).Entity.FullName)) then
    PyIDEMainForm.actRunExecute(nil);
  Panel.ClearSelection;
end;

function TRtfdDiagram.getDebug: TStringList;
  var L: TList; i: Integer; aBox: TRtfdBox;
begin
  try
    L:= Panel.GetManagedObjects;
    Result:= TStringList.Create;
    for i:= 0 to L.Count-1 do begin
      aBox:= TRtfdBox(L[I]);
      Result.Add(aBox.Entity.Fullname);
    end;
    Result.Add('');
 finally
    FreeAndNil(L);
  end;
end;

procedure TRtfdDiagram.ShowInheritedMethodsFromSystemClasses(C: TControl; ShowOrHide: Boolean);
begin
  if (C is TRtfdBox) then
   (C as TRtfdBox).ShowInherited:= ShowOrHide;
  Panel.ClearSelection;
end;

procedure TRtfdDiagram.CollectClasses;
  var Pathname, Boxname, aClassname: string;
      SLFiles: TStringList;
begin
  SLFiles:= TStringList.Create;
  for var i:= BoxNames.Count - 1 downto 0 do begin
    Boxname:= (BoxNames.Objects[i] as TRtfdBox).Entity.Name;
    if BoxNames.Objects[i] is TRtfdObject then begin
      aClassname:= FLivingObjects.getClassnameOfObject(Boxname);
      if not FLivingObjects.ClassExists(aClassname) then
        FLivingObjects.LoadClassOfObject(Boxname, aClassname)
    end else if not FLivingObjects.ClassExists(Boxname) then begin
      if (BoxNames.Objects[i] is TRtfdClass) then
        Pathname:= ((BoxNames.Objects[i] as TRtfdBox).Entity as TClass).Pathname;
      if SLFiles.IndexOf(Pathname) = -1 then begin
        PyIDEMainForm.ImportModule(Pathname);
        SLFiles.Add(Pathname);
      end;
    end;
  end;
  FreeAndNil(SLFiles);
  Sleep(100);
end;

procedure TRtfdDiagram.ShowNewObject(const Objectname: string; aClass: TClass = nil);
  var U: TUnitPackage;
      aModelObject: TObjekt;
      B1, B2: TRtfdBox;
      Address, Classname: string;
begin
  U:= Model.ModelRoot.FindUnitPackage('Default');
  if not Assigned(U) then
    U:= Model.ModelRoot.AddUnit('Default');
  if aClass = nil then begin
    Address:= FLivingObjects.getHexAddressFromName(Objectname);
    Classname:= FLivingObjects.getClassnameFromAddress(Address);
    aClass:= TClass(FindClassifier(Classname));
  end;
  aModelObject:= U.AddObject(Objectname, aClass);   // model-level -> show object
  B1:= GetBox(aClass.Name);
  B2:= GetBox(aModelObject.FullName);
  if Assigned(B1) and Assigned(B2) then begin
    B2.Top := B1.Top + B1.Height + 50 + random(30)-30;
    B2.Left:= Max(B1.Left + (B1.Width - B2.Width) div 2 + random(200) - 100, 0);
    Panel.ConnectObjects(B2, B1, asInstanceOf);
  end else if Assigned(B2) then begin
    B2.Top := B2.Top  + random(30) - 30;
    B2.Left:= B2.Left + random(30) - 30;
  end;
  B2.Font.Assign(Font);
  ShowAttributes(Objectname, aClass, aModelObject);
  if (B2 = nil) and Assigned(aModelObject) then
    AddBox(aModelObject);
end;

procedure TRtfdDiagram.CreateObjectForSelectedClass(Sender: TObject);
  var Caption, Title, Pathname, ParamName, ParamValue, s, s1: string;
      p, p1, p2: Integer;
      C: TControl;
      aClass: TClass;
      command: string;
      theClassname: string;
      theObjectname: string;
      theObjectnameNew: string;
      ParameterAsString: string;
      Parameter: TStringList;
      ParamValues: TStringList;
      MenuItem: TSpTBXItem;
begin
  C:= FindVCLWindow(Frame.PopMenuClass.PopupPoint);
  if Assigned(C) and (C is TRtfdClass) then begin
    Panel.ClearSelection;
    Pathname:= (C as TRtfdClass).GetPathname;
    aClass:= (C as TRtfdClass).Entity as TClass;
    theClassname:= aClass.Name;
    CollectClasses;
    // get parameters for constructor
    Parameter:= TStringList.Create;
    ParamValues:= TStringList.Create;
    MenuItem:= (Sender as TSpTBXItem);
    s:= myStringReplace(MenuItem.Caption, ' = ', chr(4));
    if Assigned(MenuItem.Parent) then begin
      s1:= MenuItem.Parent.caption;
      p:= Pos('Inherited from ', s1);
      if p > 0 then
        theClassname:= Copy(s1, 16, Length(s1));
    end;

    p:= FullParameters.IndexOfName(s);
    s:= FullParameters.ValueFromIndex[p];
    p:= Pos('(', s);
    Delete(s, 1, p);

    while s <> ')' do begin
      p1:= Pos(Chr(4), s);
      ParamName:= Copy(s, 1, p1 - 1);
      p2:= Pos(Chr(5), s);
      ParamValue:= Copy(s, p1 + 1, p2 - p1 - 1);
      Delete(s, 1, p2);
      Parameter.Add(ParamName);
      ParamValues.Add(ParamValue);
    end;

    if Parameter.Count = 0 then begin
      Title  := _('Attribute') + #13#10 + _('Value');
      Caption:= _('Name of object')
    end else begin
      Title  := _('Parameter') + #13#10 + _('Value');
      Caption:= _('Parameter for constructor') + ' ' + theClassname + '(...)';
    end;
    theObjectname:= FLivingObjects.getNewObjectName(theClassname);
    theObjectnameNew:= '';

    if (Parameter.Count = 0) or EditClass(Caption, Title, theObjectName, theObjectnameNew, Parameter)
    then begin
      if (theObjectnameNew <> '') and not FLivingObjects.ObjectExists(theObjectnameNew) then
        theObjectname:= theObjectnameNew;
      if FLivingObjects.ClassExists(aClass.Name) then begin
        ParameterAsString:= getParameterAsString(Parameter, ParamValues);
        AddToInteractive(theObjectname  + ' = ' + aClass.Name + '(' + ParameterAsString +')');
        CreateObjectObjectname:= theObjectname;
        CreateObjectParameter:= ParameterAsString;
        CreateObjectClass:= aClass;
        VariablesWindow.OnNotify:= CreateObjectExecuted;
        command:= theObjectname  + ' = ' + aClass.Name + '(' + ParameterAsString + ')';
        // executed in a thread
        FLivingObjects.Execute(command);
      end;
    end;
  end;
  FreeAndNil(Parameter);
  FreeAndNil(ParamValues);
end;

procedure TRtfdDiagram.CreateObjectExecuted(Sender: TObject);
begin
  VariablesWindow.OnNotify:= nil;
  LockFormUpdate(UMLForm);
  Screen.Cursor := crHourGlass;
  try
    FLivingObjects.makeAllObjects;
    if FLivingObjects.InsertObject(CreateObjectObjectname) then begin
      ShowMethodEntered('<init>', 'Actor', CreateObjectObjectname, CreateObjectParameter);
      ShowNewObject(CreateObjectObjectname, CreateObjectClass);
      if GuiPyOptions.ShowAllNewObjects then
        ShowAllNewObjectsString(CreateObjectObjectname)
      else begin
        UpdateAllObjects;
        ResolveObjectAssociations;
        Panel.RecalcSize;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    UnLockFormUpdate(UMLForm);
  end;
end;

function TRtfdDiagram.getInternName(aClass: TClass; aName: string; aVisibility: TVisibility): string;

  function getAncestorInternName(aClass: TClass; aName: string): string;
  begin
    Result:= '';
    if aClass.AncestorsCount > 0 then
      Result:= getAncestorInternName(aClass.Ancestor[0], aName);
    if Result = '' then begin
      var Ami:= TModelIterator.Create(aClass.GetAttributes);
      while Ami.HasNext do begin // we have a model from sourecode
        var Attribute:= Ami.Next;
        if Attribute.Name = aName then
          Exit('_' + aClass.Name + '__' + aName);
      end;
    end;
  end;

begin
  Result:= '';
  if aVisibility <> viPrivate then
    Result:= VisibilityAsString(aVisibility) + aName
  else begin
    if aClass.AncestorsCount > 0 then
      Result:= getAncestorInternName(aClass.Ancestor[0], aName);
    if Result = '' then  // we use live values from python
      Result:= '_' + aClass.Name + '__' + aName;
  end;
end;

procedure TRtfdDiagram.ShowAttributes(Objectname: string; aClass: TClass;
            aModelObject: TObjekt);
  // just create attributes, they will be shown by UpdateAllObjects

  var SLObject: TStringList;
      AddedAttributes: TStringList;

  procedure ShowAttributesOfClass1(aClass: TClass);
    var aModelAttribut: TAttribute;
        SL1: TStringList;
        Ami : IModelIterator;
        aEntity: TModelEntity;
        aBox: TRtfdBox;
        p: Integer; iname: string;
        SuperClass: TClass;
  begin
    // add from knowledge about model
    if aClass.AncestorsCount > 0 then begin
      SuperClass:= aClass.Ancestor[0];
      ShowAttributesOfClass1(SuperClass);
    end;
    aBox:= GetBox(Objectname);
    // get names in visibility order like in TRtfdClass.RefreshEntities
    if Assigned(aBox) then
      if aBox.MinVisibility > Low(TVisibility) then
        Ami:= TModelIterator.Create(aClass.GetAttributes, TAttribute,
                aBox.MinVisibility, TIteratorOrder(aBox.SortOrder))
      else
        Ami:= TModelIterator.Create(aClass.GetAttributes, TIteratorOrder(aBox.SortOrder))
    else
      Ami:= TModelIterator.Create(aClass.GetAttributes, TIteratorOrder(GuiPyOptions.DiSortOrder));

    //Attributes
    while Ami.HasNext do begin
      aEntity:= Ami.Next;
      iname:= getInternName(aClass, aEntity.Name, aEntity.Visibility);
      p:= SLObject.IndexOfName(iname);
      if {(p > -1) and }not aEntity.Static then begin
        SL1:= Split('|', SLObject.ValueFromIndex[p]);
        if SL1.Count = 2 then begin // object has an attribute
          aModelAttribut:= aModelObject.AddAttribute(aEntity.Name);  // AddAttribut can raise an exception
          AddedAttributes.Add(iname);
          aModelAttribut.Visibility:= aEntity.Visibility;
          aModelAttribut.Static:= aEntity.Static;
          aModelAttribut.IsFinal:= aEntity.IsFinal;
          if aModelAttribut.IsFinal then
            aModelObject.hasFinal:= True;
          aModelAttribut.Value:= SL1[0];
          aModelAttribut.TypeClassifier:= FindClassifier(SL1[1]);
          if aModelAttribut.TypeClassifier = nil then begin
            aModelAttribut.TypeClassifier:= TClassifier.Create(nil);
            aModelAttribut.TypeClassifier.Name:= SL1[1];
          end;
        end;
        FreeAndNil(SL1);
      end;
    end;
  end;

  procedure ShowAttributesOfClass2(aClass: TClass);
    var aModelAttribut: TAttribute;
        SL1: TStringList;
        iname: string;
        vis: TVisibility;
  begin
    // add from knowldege about LivingObjects
    for var i:= 0 to SLObject.Count - 1 do begin
      iname:= SLObject.KeyNames[i];
      if AddedAttributes.IndexOf(iname) = -1 then begin
        SL1:= Split('|', SLObject.ValueFromIndex[i]);
        if SL1.Count = 2 then begin // object has an attribute
          getVisFromName(iname, vis);
          aModelAttribut:= aModelObject.AddAttribute(iname);
          aModelAttribut.Visibility:= vis;
          aModelAttribut.Value:= SL1[0];
          aModelAttribut.TypeClassifier:= FindClassifier(SL1[1]);
          if aModelAttribut.TypeClassifier = nil then begin
            aModelAttribut.TypeClassifier:= TClassifier.Create(nil);
            aModelAttribut.TypeClassifier.Name:= SL1[1];
          end;
        end;
        FreeAndNil(SL1);
      end;
    end;
  end;

begin
  aModelObject.Locked:= True;
  AddedAttributes:= TStringList.Create;
  SLObject:= FLivingObjects.getObjectMembers(Objectname);
  aModelObject.setCapacity(SLObject.Count);
  ShowAttributesOfClass1(aClass);
  ShowAttributesOfClass2(aClass);
  FreeAndNil(SLObject);
  FreeAndNil(AddedAttributes);
  aModelObject.Locked:= False;
end;

function TRtfdDiagram.StrToPythonValue(s: string): string;
begin
  Result:= Trim(s);
  if not ((Result <> '') and (Pos(Result[1], '[({''') > 0) or
          isNumber(Result) or isBool(Result) or (Result = 'None') or
          FLivingObjects.ObjectExists(Result))
  then
    Result:= asString(Result);
end;

function TRtfdDiagram.StrAndTypeToPythonValue(s, pValue: string): string;
begin
  Result:= StrToPythonValue(s);
  if (Result = asString('')) and (pValue <> '') then
    Result:= '';
end;

function TRtfdDiagram.getParameterAsString(Parameter, ParamValues: TStringList): string;
  var s, s1, value: string; i: Integer;
begin
  s:= '';
  var AllParameters:= True;
  for i:= 0 to Parameter.Count - 1 do begin
    value:= ParamValues[i];
    s1:= StrAndTypeToPythonValue(Parameter.ValueFromIndex[i], Value);
    if AllParameters then
      if s1 <> ''
        then s:= s +  s1 + ', '
        else AllParameters:= False
    else
      if s1 <> '' then
        s:= s + Parameter.KeyNames[i] + '=' + s1 + ', ';
  end;
  Result:= Copy(s, 1, Length(s)-2);
end;

procedure TRtfdDiagram.SetAttributeValues(aModelClass: TClass; Objectname: string; Attributes: TStringList);
  var OldAttributes: TStringList; i: Integer;

  procedure DoSetAttributeValues(aClass: TClass);
    var newValue: string; i: Integer;
  begin
    if aClass.AncestorsCount > 0 then
      DoSetAttributeValues(aClass.Ancestor[0]);
    for i:= 0 to Attributes.Count - 1 do begin
      newValue:= StrToPythonValue(Attributes.ValueFromIndex[i]);
      if newValue <> OldAttributes.ValueFromIndex[i] then
      PyControl.ActiveInterpreter.RunSource(
        Objectname + '.' + OldAttributes.KeyNames[i] + ' = ' + newValue, '<interactive input>');
    end;
  end;

begin
  OldAttributes:= FLivingObjects.getObjectAttributeValues(Objectname);
  for i:= OldAttributes.Count - 1 downto 0 do
    if not (GuiPyOptions.PrivateAttributEditable or (Pos('__', OldAttributes.KeyNames[i]) = 0)) then
      OldAttributes.Delete(i);
  DoSetAttributeValues(aModelClass);
  FreeAndNil(OldAttributes);
end;

procedure TRtfdDiagram.CallMethodForObject(Sender: TObject);
  var C: TControl;
begin
  C:= FindVCLWindow(Frame.PopMenuObject.PopupPoint);
  CallMethod(C, Sender);
end;

procedure TRtfdDiagram.CallMethodForClass(Sender: TObject);
  var C: TControl;
begin
  C:= FindVCLWindow(Frame.PopMenuClass.PopupPoint);
  CallMethod(C, Sender);
end;

procedure TRtfdDiagram.CallMethod(C: TControl; Sender: TObject);
  var Caption, Title, ParamName, ParamValue, s: string;
      p, p1, p2, InheritedLevel: Integer;
      theClassname: string;
      ParameterAsString: string;
      Parameter: TStringList;
      ParamValues: TStringList;
      aViewClass: TRtfdClass;
      aModelClass: TClass;
      MethodCall: string;
begin
  try
    if Assigned(C) and ((C is TRtfdObject) or (C is TRtfdClass)) then begin
      CollectClasses;
      LockFormUpdate(UMLForm);
      try
        Panel.ClearSelection;
        if C is TRtfdObject
          then CallMethodObjectName:= (C as TRtfdObject).Entity.Name
          else CallMethodObjectName:= '';
        InheritedLevel:= (Sender as TSpTBXItem).Tag;
        // get parameters for method call
        Parameter:= TStringList.Create;
        ParamValues:= TStringList.Create;

        s:= myStringReplace((Sender as TSpTBXItem).Caption, ' = ', chr(4));

        p:= FullParameters.IndexOfName(s);
        s:= FullParameters.ValueFromIndex[p];
        p:= Pos('(', s);
        CallMethodMethodname:= getShortType(Copy(s, 1, p-1));
        Delete(s, 1, p);
        s:= Trim(s);

        while s <> ')' do begin
          p1:= Pos(Chr(4), s);
          ParamName:= Copy(s, 1, p1 - 1);
          p2:= Pos(Chr(5), s);
          ParamValue:= Copy(s, p1 + 1, p2 - p1 - 1);
          Delete(s, 1, p2);
          Parameter.Add(ParamName);
          ParamValues.Add(ParamValue);
        end;
        Caption:= _('Parameter for method call') + ' ' + CallMethodMethodName + '(...)';
        Title:= _('Parameter') + #13#10 + _('Value');
        // get parameter-values from user
        if (Parameter.Count = 0) or EditObjectOrParams(Caption, Title, Parameter) then begin
          ParameterAsString:= getParameterAsString(Parameter, ParamValues);
          CollectClasses;
          // call the method
          if CallMethodObjectName = '' then begin // static method of a class
            aModelClass:= (C as TRtfdClass).Entity as TClass;
            CallMethodObjectname:= aModelClass.GetTyp;
          end else begin                          // method of an object
            theClassname:= FLivingObjects.getClassnameOfObject(CallMethodObjectname);
            // get model class for object to get the methods
            aModelClass:= nil;
            aViewClass:= GetBox(theClassname) as TRtfdClass;
            if aViewClass = nil then
              aViewClass:= GetBox(getShortType(theClassname)) as TRtfdClass;
            if Assigned(aViewClass) then
              aModelClass:= (aViewClass.Entity as TClass);      // model class from view class
            if aModelClass = nil then
              aModelClass:= getModelClass(theClassname);        // model class from model
            if (aModelClass = nil) or (aModelClass.Pathname = '') then
              aModelClass:= CreateModelClass(TheClassname);     // model class from python
          end;
          while Assigned(aModelClass) and (InheritedLevel > 0) do begin
            aModelClass:= aModelClass.Ancestor[0];  // ToDo many ancestors
            Dec(InheritedLevel);
          end;
          CallMethodFrom:= CallMethodObjectname;
          if (CallMethodFrom = '') and Assigned(aModelClass) then
            CallMethodFrom:= aModelClass.Name;
          if aModelClass.OperationIsProperty(CallMethodMethodname) then
            if Parameter.Count = 0
              then Methodcall:= CallMethodObjectname + '.' + CallMethodMethodname
              else Methodcall:= CallMethodObjectname + '.' + CallMethodMethodname + ' = ' + ParameterAsString
            else Methodcall:= CallMethodObjectname + '.' + CallMethodMethodname + '(' + ParameterAsString + ')';
          AddToInteractive(MethodCall);
          ShowMethodEntered(CallMethodMethodName, 'Actor', CallMethodObjectname, ParameterAsString);
          PythonIIForm.OnExecuted:= CallMethodExecuted;
          GI_PyInterpreter.StartOutputMirror(TPath.Combine(GuiPyOptions.TempDir, 'output.txt'), False);
          // execute within a thread
          FLivingObjects.Execute(Methodcall);
        end;
        FreeAndNil(Parameter);
        FreeAndNil(ParamValues);
      except
        on e: Exception do
          ErrorMsg('TRtfdDiagram.CallMethod: ' + e.Message);
      end;
    end;
  finally
    UnlockFormUpdate(UMLForm);
  end;
end;

procedure TRtfdDiagram.CallMethodExecuted(Sender: TObject);
  var SL: TStringList;
begin
  PythonIIForm.OnExecuted:= nil;
  GI_PyInterpreter.StopFileMirror;
  FLivingObjects.makeAllObjects;

  if GuiPyOptions.ShowAllNewObjects then
    ShowAllNewObjectsString(CallMethodFrom)
  else
    UpdateAllObjects;
  SL:= TStringList.Create;
  try
    SL.LoadFromFile(TPath.Combine(GuiPyOptions.TempDir, 'output.txt'));
    if SL.Count > 0
      then ShowMethodExited(CallMethodMethodName, CallMethodObjectname, 'Actor', SL[0])
      else ShowMethodExited(CallMethodMethodName, CallMethodObjectname, 'Actor', '');
  finally
    FreeAndNil(SL);
  end;
end;

function TRtfdDiagram.CreateModelClass(const Typ: string): TClass;
  var U: TUnitPackage;
      C, C1: TClass;
      Operation: UModel.TOperation;
      SLMethods, SLParams: TStringList;
      i, p: Integer;
      Method, ParName, OpName, Params: string;
      vis: TVisibility;
begin
  Result:= nil;
  U:= Model.ModelRoot.FindUnitPackage('Default');
  CollectClasses;
  if FLivingObjects.ClassExists(Typ) then begin
    C:= U.MakeClass(Typ, '');
    C.Importname:= Typ;
    U.AddClassWithoutShowing(C);

    // make operations
    SLMethods:= FLivingObjects.getClassMethods(Typ); // static and not static
    try
      for i:= 0 to SLMethods.Count - 1 do begin
        Method:= SLMethods[i];
        p:= Pos(chr(3), Method);
        OpName:= Copy(Method, 1, p - 1);
        if OpName = '__init__' then Continue;
        Params:= FLivingObjects.getSignature(Typ + '.' + OpName);
        Operation:= C.AddOperationWithoutType('');
        getVisFromName(OpName, vis);
        Operation.Visibility:= vis;
        Operation.Name:= OpName;
        Delete(Method, 1, p);
        if Method = 'function'
          then Operation.OperationType:= otFunction
          else Operation.OperationType:= otProcedure;
        Operation.Static:= False;
        // Parameters
        p:= Pos(' ->', Params);
        if p > 0 then begin
          C1:= U.MakeClass(Copy(Params, p+3, Length(Params)), '');
          if Assigned(C1) then begin
            Operation.ReturnValue:= C1;
            U.AddClassWithoutShowing(C1);
          end;
          Delete(Params, p, Length(Params));
        end;
        Params:= Copy(Params, 2, Length(Params)-2);
        SLParams:= Split(',', Params);
        for var j:= 0 to SLParams.Count - 1 do begin
          ParName:= SLParams[j];
          p:= Pos(':', Parname);
          if p > 0 then
            Delete(Parname, p, Length(Parname));
          ParName:= Trim(ParName);
          if ParName <> '' then
            Operation.AddParameter(ParName);
        end;
        FreeAndNil(SLParams);
      end;
    finally
      FreeAndNil(SLMethods);
    end;
    // no attributes, because classes don't have them
    C.Pathname:= FLivingObjects.getPathOf(Typ);
    Result:= C;
  end;
end;

function TRtfdDiagram.PPIScale(ASize: Integer): Integer;
begin
  Result := MulDiv(ASize, PPIControl.CurrentPPI, 96);
end;

function TRtfdDiagram.PPIUnScale(ASize: Integer): Integer;
begin
  Result := MulDiv(ASize, 96, PPIControl.CurrentPPI);
end;

function TRtfdDiagram.FindClassifier(const CName: string): TClassifier;
var
  PName, ShortName : string;
  CacheI : Integer;
  aClass: TClass;
  TheClass: TModelEntityClass;

  function InLookInModel: TClassifier;
  var
    U : TUnitPackage;
  begin
    Result := nil;
    if PName <> '' then begin // search in package
      U := Model.ModelRoot.FindUnitPackage(PName);
      if Assigned(U) then
        Result:= U.FindClassifier(ShortName, TheClass, True);
    end;
    if Result = nil then begin
      U:= Model.ModelRoot.FindUnitPackage('Default');
      Result := U.FindClassifier(ShortName, TheClass, True);
    end;
    if Result = nil then begin
      U:= Model.ModelRoot.FindUnitPackage('Default');
      Result := U.FindClassifier(CName, TheClass, True);
    end;
  end;

  function ExtractPackageName(const CName: string): string;
  var
    I : Integer;
  begin
    I := LastDelimiter('.', CName);
    if I=0 then
      Result := ''
    else
      Result := Copy(CName, 1, I-1);
  end;

  function ExtractClassName(const CName: string): string;
  var
    I : Integer;
  begin
    I := LastDelimiter('.', CName);
    if I=0 then
      Result := CName
    else
      Result := Copy(CName,I+1,255);
    Result:= withoutArray(Result);
  end;

begin
  TheClass:= nil;
  CacheI:= Model.NameCache.IndexOf(CName);
  if (CacheI > -1) then begin
    Result := TClassifier(Model.NameCache.Objects[CacheI]);
    Exit;
  end;
  PName := ExtractPackageName(CName);
  ShortName := ExtractClassName(CName);
  Result := InLookInModel;

  if Assigned(Result) and (Pos('[]', CName) > 0) and (Result.Name <> CName) then begin
    if Result is TClass then begin
      aClass:= TClass.Create(Result.Owner);
      aClass.Pathname:= Result.Pathname;
      aClass.Importname:= Result.Importname;
      aClass.Ancestor[0]:= (Result as TClass).Ancestor[0]; // ToDo n ancestors
      aClass.Name:= CName;
      aClass.Visibility:= Result.Visibility;
      aClass.Static:= Result.Static;
      Result:= aClass;
    end;
    Model.NameCache.AddObject(CName, Result);
  end;

  if not Assigned(Result) then begin
    Result:= Model.UnknownPackage.FindClassifier(CName, TClass, True);
    if not Assigned(Result) then begin
      Result:= Model.UnknownPackage.MakeClass(CName, '');
      Model.UnknownPackage.AddClass(TClass(Result));
    end;
  end;

 // if Assigned(Result) and (CacheI = -1) then
 //   Model.NameCache.AddObject(CName, Result);
  if Assigned(Result) and (Pos('/', Result.Name) > 0) then
    Result.Name:= myStringReplace(Result.Name, '/', '.');
end;

procedure TRtfdDiagram.EditObject(C: TControl);
  var Caption, Title, Objectname, Classname: string;
      Attributes: TStringList;
      aModelClass: TClass;
      U: TUnitPackage;
      i: Integer;
begin
  if Assigned(C) and (C is TRtfdObject) then begin
    Panel.ClearSelection;
    Objectname:= (C as TRtfdObject).Entity.Name;
    Classname:= FLivingObjects.getClassnameOfObject(Objectname);
    U:= Model.ModelRoot.FindUnitPackage('Default');
    aModelClass:= U.FindClassifier(Classname) as TClass;
    if FLivingObjects.ObjectExists(Objectname) and Assigned(aModelClass) then begin
      Attributes:= FLivingObjects.getObjectAttributeValues(Objectname);
      for i:= Attributes.Count - 1 downto 0 do
        if GuiPyOptions.PrivateAttributEditable or (Pos('__', Attributes.KeyNames[i]) = 0)
          then Attributes[i]:= WithoutVisibility(Attributes[i])
          else Attributes.Delete(i);
      Caption:= _('Edit object') + ' ' + ObjectName;
      Title  := _('Attribute') + #13#10 + _('Value');
      if EditObjectOrParams(Caption, Title, Attributes) then begin
        SetAttributeValues(aModelClass, Objectname, Attributes);
        FLivingObjects.makeAllObjects;
        UpdateAllObjects;
      end;
      FreeAndNil(Attributes);
    end;
  end;
end;

procedure TRtfdDiagram.UpdateAllObjects;
  var
    U: TUnitPackage;
    aModelClass: TClassifier;
    aModelObject: TObjekt;
    aModelAttribut: TAttribute;
    aModelClassAttribut: TAttribute;
    It, It2: IModelIterator;
    aObjectList, SL_Attributes: TStringList;
    i, j: Integer;
    value, internname: string;

  function Shorten(const s: string): string;
    var p: Integer;
  begin
    Result:= s;
    if Length(s) > 100 then begin
      p:= 100;
      while (p > 0) and (s[p] <> ',') do
        Dec(p);
      if p = 0 then p:= 96;
      Result:= Copy(s, 1, p+1) + '...';
    end;
  end;

begin
  if Assigned(Model) and Assigned(Model.ModelRoot)
    then U:= Model.ModelRoot.FindUnitPackage('Default')
    else U:= nil;
  if U = nil then Exit;
  aObjectList:= U.GetAllObjects;
  for i:= 0 to aObjectList.Count - 1 do begin
    if not FLivingObjects.ObjectExists(aObjectList[i]) then
      Continue;
    if Assigned(aObjectList.objects[i]) and (aObjectList.Objects[i] is TObjekt)
      then aModelObject:= aObjectList.objects[i] as TObjekt
      else Continue;
    SL_Attributes:= FLivingObjects.getObjectAttributeValues(aObjectList[i]);
    It:= aModelObject.GetAttributes;
    while It.HasNext do begin
      aModelAttribut:= It.Next as TAttribute;
      Internname:= getInternName(aModelObject.getTyp, aModelAttribut.Name, aModelAttribut.Visibility);
      j:= SL_Attributes.IndexOfName(Internname);
      if j >= 0
        then Value:= Shorten(SL_Attributes.ValueFromIndex[j])
        else Value:= '<error>';

      if aModelAttribut.Static then begin
        aModelClass:= aModelObject.getTyp;
        if Assigned(aModelClass) then begin
          It2:= aModelClass.GetAttributes;
          while It2.HasNext do begin
            aModelClassAttribut:= It2.Next as TAttribute;
            if aModelClassAttribut.Name = aModelAttribut.Name then begin
              aModelClassAttribut.Value:= Value;
              Break;
            end;
          end;
        end;
      end else
        aModelAttribut.Value:= Value;
    end;
    FreeAndNil(SL_Attributes);
  end;
  FreeAndNil(aObjectList);
  RefreshDiagram;
end;

function TRtfdDiagram.insertParameterNames(s: string): string;
  var p: Integer; s1, s2: string;
begin
  p:= pos('(', s);
  s1:= Copy(s, 1, p);
  Delete(s, 1, p);
  s:= myStringReplace(s, ')', ',)');
  p:= pos(',', s);
  while p > 0 do begin
    s2:= Copy(s, 1, p-1);
    Delete(s, 1, p);
    s2:= GetShortTypeWith(s2);
    if Pos('<?', s2) > 0 then begin
      s2:= s2;
    end else begin
      p:= Pos(' ', s2);
      if (p = 0) and (s2 <> '') then
        s2:= s2;
    end;
    p:= Pos(',', s);
    if p > 0
      then s1:= s1 + s2 + ', '
      else s1:= s1 + s2 + ')';
  end;
  Result:= s1;
end;

procedure TRtfdDiagram.PopMenuClassPopup(Sender: TObject);
  var s1, s2: string;
      i, MenuIndex, InheritedLevel, StartIndex: Integer;
      aViewClass: TRtfdClass;
      aModelClass: TClass;
      it1: IModelIterator;
      Operation: UModel.TOperation;
      Attribute: UModel.TAttribute;
      aInheritedMenu: TSpTBXItem;
      HasSourcecode: Boolean;
      Associations: TStringList;
      Connections: TStringlist;
      SLSorted: TStringList;
      aBox: TControl;
      hasInheritedSystemMethods: Boolean;

  procedure MakeOpenClassMenuItem(aClass: string; ImageIndex: Integer);
  begin
    if (BoxNames.IndexOf(aClass) = -1) and FLivingObjects.ClassExists(aClass) and
       (MenuClassFiles.IndexOfName(aClass) = -1)
    then begin
      var aMenuItem:= TSpTBXItem.Create(Frame.PopMenuClass);
      aMenuItem.Caption:= WithoutGeneric(aClass);
      aMenuItem.OnClick:= OpenClassOrInterface;
      aMenuItem.ImageIndex:= ImageIndex;
      Frame.MIClassPopupOpenClass.Add(aMenuItem);
      MenuClassFiles.Add(aClass + '=' + FLivingObjects.getPathOf(aClass));
    end;
  end;

  procedure MakeConnectClassMenuItems;
    var aMenuItem: TSpTBXItem; c: char;
        i: Integer; s: string;
  begin
    for i:= BoxNames.Count - 1 downto 0 do
      if (BoxNames.Objects[i] is TRtfdClass) then
        Connections.Add('C' + (BoxNames.Objects[i] as TRtfdBox).Entity.FullName)
      else if (BoxNames.Objects[i] is TRtfdCommentBox) then
        Connections.Add('K' + BoxNames[i]);
    for i:= 0 to Connections.Count - 1 do begin
      s:= Connections[i];
      c:= s[1];
      s:= Copy(s, 2, Length(s));
      aMenuItem:= TSpTBXItem.Create(Frame.PopMenuClass);
      aMenuItem.Caption:= WithoutGeneric(s);
      AMenuItem.Caption:= s;
      aMenuItem.OnClick:= ConnectBoxes;
      case c of
        'C': aMenuItem.ImageIndex:= 0;
        'I': aMenuItem.ImageIndex:= 16;
        'K': aMenuItem.ImageIndex:= 23;
      end;
      s:= (aBox as TRtfdBox).Entity.Name;
      aMenuItem.Tag:= BoxNames.IndexOf(s);
      Frame.MIClassPopupConnect.Add(aMenuItem);
    end;
  end;

  procedure AddDatatype(const s: string);
  begin
    if IsPythonType(s) then
      Exit;
    var s1:= WithoutGeneric(WithOutArray(s));
    if IsPythonType(s1) or (s1 = '') then
      Exit;
    for var i:= 0 to BoxNames.Count - 1 do
      if s1 = BoxNames[i] then Exit;
    if (Associations.IndexOf(s1) > -1) then
      Exit;
    Associations.Add(getShortType(s1));
  end;

  procedure MakeMenuItem(const s1, s2: string; ImageIndex: Integer);
  begin
    if s1 = '' then begin
      var aSeparator:= TSpTBXSeparatorItem.Create(Frame.PopMenuClass);
      Frame.PopMenuClass.Items.Insert(MenuIndex, aSeparator);
      Inc(MenuIndex);
    end else begin
      var aMenuItem:= TSpTBXItem.Create(Frame.PopMenuClass);
      aMenuItem.Caption:= s1; // Copy(Caption, 1, 50);
      aMenuItem.Tag:= InheritedLevel;
      if s1 <> '' then begin
        if ImageIndex >= 7
          then aMenuItem.OnClick:= CallMethodForClass
          else aMenuItem.OnClick:= CreateObjectForSelectedClass;
        aMenuItem.ImageIndex:= ImageIndex;
        FullParameters.Add(s1 + '=' + s2);
      end;
      if (InheritedLevel = 0) and (0 <= MenuIndex) and (MenuIndex < Frame.PopMenuClass.Items.Count) then begin
        Frame.PopMenuClass.Items.Insert(MenuIndex, aMenuItem);
        Inc(MenuIndex);
      end else
        aInheritedMenu.Add(aMenuItem);
    end;
  end;

  function MakeTestMenuItem(const s1, s2: string): TSpTBXItem;
  begin
    var aMenuItem:= TSpTBXItem.Create(Frame.PopMenuClass);
    aMenuItem.Caption:= s1; // Copy(Caption, 1, 50);
    aMenuItem.OnClick:= OnRunJunitTestMethod;
    aMenuItem.ImageIndex:= 21;
    FullParameters.Add(s1 + '=' + s2);
    Result:= aMenuItem;
  end;

  procedure MakeSeparatorItem;
  begin
    var aMenuItem:= TSpTBXSeparatorItem.Create(Frame.PopMenuClass);
    aMenuItem.Tag:= InheritedLevel;
    if (InheritedLevel = 0) and (0 <= MenuIndex) and
       (MenuIndex < Frame.PopMenuClass.Items.Count) then begin
        Frame.PopMenuClass.Items.Insert(MenuIndex, aMenuItem);
        Inc(MenuIndex);
      end
    else
      aInheritedMenu.Add(aMenuItem);
  end;

  procedure AddParameter(var s1, s2: string; Operation: TOperation);
    var Parameter: TParameter;
  begin
    var it2:= Operation.GetParameters;
    while it2.HasNext do begin
      Parameter:= it2.Next as TParameter;
      if (Parameter.Name = 'self') or (Parameter.Name = 'cls') then
        Continue;
      s1:= s1 + Parameter.Name;
      s2:= s2 + Parameter.Name;
      // chr(x) are used as separators
      if Assigned(Parameter.TypeClassifier) then begin
        s1:= s1 + ': ' + Parameter.TypeClassifier.asType;
        if InheritedLevel = 0 then
          AddDatatype(Parameter.TypeClassifier.asType);
      end;
      s2:= s2 + chr(4);
      if Parameter.Value <> '' then  begin
        s1:= s1 + chr(4) + Parameter.Value;
        s2:= s2 + Parameter.Value;
      end;
      s1:= s1 + ', ';
      s2:= s2 + chr(5);
    end;
    s1:= myStringReplace(s1 + ')', ', )', ')');
    s2:= s2 + ')';
    if (Operation.OperationType = otFunction) and Assigned(Operation.ReturnValue) then begin
      s1:= s1 + ': ' + Operation.ReturnValue.GetShortType;
      if InheritedLevel = 0 then
        AddDatatype(Operation.ReturnValue.Name);
    end;
  end;

  procedure Debugmenu(aMenu: TSpTBXPopupMenu);
    var i, j: Integer; s: string; aMenuItem: TTBCustomItem;
  begin
    s:= '';
    for i:= 0 to aMenu.Items.Count - 1 do begin
      aMenuItem:= aMenu.Items[i];
      s:= s + aMenuItem.caption + ' ' + BoolToStr(aMenuItem.Visible, True) + sLineBreak;
      for j:= 0 to aMenuItem.Count - 1 do
        s:= s + '-- ' + aMenuItem.Items[j].caption + ' ' + BoolToStr(aMenuItem.Items[j].Visible, True) + sLineBreak;
    end;
    ShowMessage(s);
  end;

begin // PopMenuClassPopup
  aBox:= FindVCLWindow((Sender as TPopupMenu).PopupPoint);

  aViewClass:= nil;
  MenuClassFiles.Clear;
  Panel.ClearSelection;
  if Assigned(aBox)
    then TManagedObject(Panel.FindManagedControl(aBox)).Selected:= True
    else Exit;

  // delete previous menu
  for i:= Frame.PopMenuClass.Items.Count - 1 downto 0 do
    if Frame.PopMenuClass.Items[i].Tag = 0 then
      FreeAndNil(Frame.PopMenuClass.Items[i]);
  for i:= Frame.MIClassPopupRunOneTest.Count - 1 downto 0 do
    FreeAndNil(Frame.MIClassPopupRunOneTest.Items[i]);
  for i:= Frame.MIClassPopupOpenClass.Count - 1 downto 0 do
    FreeAndNil(Frame.MIClassPopupOpenClass.Items[i]);
  for i:= Frame.MIClassPopupConnect.Count - 1 downto 0 do
    FreeAndNil(Frame.MIClassPopupConnect.Items[i]);

  FullParameters.Clear;
  InheritedLevel:= 0;
  StartIndex:= 10;
  MenuIndex:= StartIndex;
  Associations:= TStringList.Create;
  Associations.Sorted:= True;
  Associations.Duplicates:= dupIgnore;
  Connections:= TStringList.Create;
  Connections.Sorted:= True;
  Connections.Duplicates:= dupIgnore;
  SLSorted:= TStringList.Create;
  SLSorted.Sorted:= True;
  hasInheritedSystemMethods:= False;
  MakeSeparatorItem;

  if (aBox is TRtfdClass) and not (aBox as TRtfdBox).isJUnitTestclass then begin
    aViewClass:= aBox as TRtfdClass;
    aModelClass:= aViewClass.Entity as TClass;

    // get superclasses
    for i:= 1 to aModelClass.AncestorsCount do
      MakeOpenClassMenuItem(aModelClass.Ancestor[i-1].Name, 13);

    // get constructor
    if not aModelClass.IsAbstract then begin
      var ConstructorMissing:= True;
      it1:= aModelClass.GetOperations;
      while it1.HasNext do begin
        Operation:= it1.Next as UModel.TOperation;
        if Operation.OperationType = otConstructor then begin
          ConstructorMissing:= False;
          s1:= aModelClass.Name + '(';   // Konto() instead of __init__()
          s2:= s1;
          AddParameter(s1, s2, Operation);
          Break;  // only one constructor
        end
      end;
      if ConstructorMissing then begin
        s1:= aModelClass.Name + '()';
        s2:= s1;
      end;
      MakeMenuItem(s1, s2, 2);
    end;

    // get static|class methods and parameter classes
    repeat
      it1:= aModelClass.GetOperations;
      while it1.HasNext do begin
        Operation:= it1.Next as UModel.TOperation;
        if Operation.OperationType in [otFunction, otProcedure] then begin
          if not (Operation.isClassMethod or Operation.isStaticMethod) then
            Continue;
          s1:= Operation.Name + '(';
          s2:= s1;
          addParameter(s1, s2, Operation);
          MakeMenuItem(s1, s2, Integer(Operation.Visibility) + 7);
        end;
      end;

      // empty inherited static methods menu
      if (InheritedLevel > 0) and (aInheritedMenu.Count = 0) then begin
        FreeAndNil(aInheritedMenu);
        Dec(MenuIndex);
      end;

      // get association classes
      if InheritedLevel = 0 then begin
        it1:= aModelClass.GetAttributes;
        while it1.HasNext do begin
          Attribute:= it1.Next as UModel.TAttribute;
          if Assigned(Attribute.TypeClassifier) then
            AddDatatype(Attribute.TypeClassifier.Importname)
        end;
      end;

      // get inherited static methods
      if aModelClass.AncestorsCount > 0 then begin
         //for j:= 0 to aModelClass.AncestorsCount -1 do begin // wrong approach
         aModelClass:= aModelClass.Ancestor[0];
         if Assigned(aModelClass) then begin
           Inc(InheritedLevel);
           aInheritedMenu:= TSpTBXSubmenuItem.Create(Frame.PopMenuClass);
           aInheritedMenu.Caption:= 'Inherited from ' + aModelClass.Name;
           Frame.PopMenuClass.Items.Insert(MenuIndex, aInheritedMenu);
           Inc(MenuIndex);
         end
       end else
        aModelClass:= nil;
    until aModelClass = nil;
  end;

  for i:= 0 to Associations.Count - 1 do
    MakeOpenClassMenuItem(Associations[i], 0);
  MakeConnectClassMenuItems;

  InheritedLevel:= 0;
  Inc(MenuIndex, 2);
  MakeSeparatorItem;

  s1:= ChangeFileExt((aBox as TRtfdBox).GetPathname, '.py');
  HasSourcecode:= FileExists(s1);

  Frame.MIClassPopupRun.Visible:= True; // was hasMain
  Frame.MIClassPopupClassEdit.Visible := (aBox is TRtfdClass) and HasSourceCode;
  Frame.MIClassPopupOpenSource.Visible:= HasSourceCode;  // in Arbeit
  Frame.MIClassPopupOpenclass.Visible := (Frame.MIClassPopupOpenclass.Count > 0);
  Frame.MIClassPopupConnect.Visible   := (Frame.MIClassPopupConnect.Count > 0);
  Frame.MIClassPopupDelete.Caption    := _('Delete class');
  Frame.MIClassPopupShowInherited.Visible:= not (aBox as TRtfdBox).ShowInherited and hasInheritedSystemMethods;
  Frame.MIClassPopupHideInherited.Visible:= (aBox as TRtfdBox).ShowInherited and hasInheritedSystemMethods;
  Frame.MIClassPopupRunAllTests.Visible:= False;
  Frame.MIClassPopupRunOneTest.Visible:= False;
  Frame.NEndOfJUnitTest.Visible:= False;
  Frame.MIClassPopupCreateTestClass.Visible:= False;
  for i:= 0 to Frame.MIClassPopupDisplay.Count - 1 do
    Frame.MIClassPopupDisplay.Items[i].Checked:= False;
  if Assigned(aViewClass) then begin
    i:= 3 - Ord(aViewClass.MinVisibility);
    Frame.MIClassPopupDisplay.Items[i].Checked:= True;
  end;
  for i:= 0 to Frame.MIClassPopupParameter.Count - 1 do
    Frame.MIClassPopupParameter.Items[i].Checked:= False;
  if Assigned(aViewClass) then begin
    i:= aViewClass.ShowParameter;
    Frame.MIClassPopUpParameter.Items[i].Checked:= True;
  end;
  for i:= 0 to Frame.MIClassPopupVisibility.Count - 1 do
    Frame.MIClassPopupVisibility.Items[i].Checked:= False;
  if Assigned(aViewClass) then begin
    i:= 2 - aViewClass.ShowIcons;
    Frame.MIClassPopupVisibility.Items[i].Checked:= True;
  end;
  Frame.MIClassPopupVisibility.Visible:= True;

  FreeAndNil(Associations);
  FreeAndNil(Connections);
  FreeAndNil(SLSorted);
  // DebugMenu(Frame.PopMenuClass);
end;  // PopMenuClassPopup

procedure TRtfdDiagram.PopMenuObjectPopup(Sender: TOBject);

  var LongType, objectname: string; C: TControl;
      i, InheritedLevel, MenuIndex: Integer;
      aObjectBox: TRtfdObject;
      aViewClass: TRtfdClass;
      aModelClass: TClass;
      aModelClassRoot: TClass;
      aMenuItem: TTBCustomItem;
      aInheritedMenu: TSpTBXItem;

  procedure MakeMenuItem(const s1, s2: string; ImageIndex: Integer);
  begin
    if s1 = '' then begin
      var aSeparator:= TSpTBXSeparatorItem.Create(Frame.PopMenuObject);
      Frame.PopMenuObject.Items.Insert(MenuIndex, aSeparator);
      Inc(MenuIndex);
    end else begin
      var aMenuItem:= TSpTBXItem.Create(Frame.PopMenuObject);
      aMenuItem.Caption:= s1;
      aMenuItem.OnClick:= CallMethodForObject;
      aMenuItem.ImageIndex:= ImageIndex;
      FullParameters.Add(s1 + '=' + s2);
      if InheritedLevel = 0 then begin
        Frame.PopMenuObject.Items.Insert(MenuIndex, aMenuItem);
        Inc(MenuIndex);
      end else begin
        aMenuItem.Tag:= InheritedLevel;
        aInheritedMenu.Add(aMenuItem);
      end;
    end;
  end;

  procedure MakeSortedMenu(SLSorted: TStringList);
    var i, e, p, img: Integer; s, s1, s2: string;
  begin
    for i:= 0 to SLSorted.Count - 1 do begin
      s:= SLSorted[i];
      p:= Pos(chr(3), s);
      Delete(s, 1, p);
      p:= Pos(chr(3), s);
      s1:= Copy(s, 1, p - 1);
      Delete(s, 1, p);
      p:= Pos(chr(3), s);
      s2:= Copy(s, 1, p - 1);
      Delete(s, 1, p);
      val(s, img, e);
      MakeMenuItem(s1, s2, img);
    end;
  end;

  procedure MakeShowUnnamedMenu;
    var
      i: Integer;
      SL1, SL2: TStringList;
      aMenuItem: TSpTBXItem;

    function NotShown(const s: string): Boolean;
    begin
      Result:= (s <> '') and (BoxNames.IndexOf(s) = -1) and (SL2.IndexOf(s) = -1);
    end;

    procedure PrepareMenu(const attr: string);
    begin
      if NotShown(attr) then
        SL2.Add(attr);
    end;

    function MakeMenuItem(const s: string; Count: Integer): TSpTBXItem;
      var aMenuItem: TSpTBXItem;
    begin
      aMenuItem:= TSpTBXItem.Create(Frame.MIObjectPopupShowNewObject);
      if Count > 3
        then aMenuItem.Caption:= s
        else aMenuItem.Caption:= Frame.MIObjectPopupShowNewObject.Caption + ' ' + s;
      aMenuItem.OnClick:= ShowUnnamedObject;
      aMenuItem.ImageIndex:= 19;
      aMenuItem.Tag:= -2;  // only unnamed menuitems
      Result:= aMenuItem;
    end;

  begin // MakeShowUnnamedMenu
    Frame.MIObjectPopupShowNewObject.Visible:= False;
    Frame.MIObjectPopupShowAllNewObjects.Visible:= False;
    SL1:= FLivingObjects.getObjectObjectMembers(Objectname);
    SL2:= TStringList.Create;
    for i:= 0 to SL1.Count - 1 do
      PrepareMenu(SL1[i]);
    for i:= 0 to SL2.Count - 1 do begin
      aMenuItem:= MakeMenuItem(SL2[i], SL2.Count);
      if SL2.Count > 3 then
        Frame.MIObjectPopupShowNewObject.Add(aMenuItem)
      else begin
        Frame.PopMenuObject.Items.Insert(MenuIndex-1, aMenuItem);
        Inc(MenuIndex);
      end;
    end;
    Frame.MIObjectPopupShowNewObject.Visible:= (SL2.Count > 3);
    Frame.MIObjectPopupShowAllNewObjects.Visible:= (SL2.Count > 1);
    FreeAndNil(SL2);
    FreeAndNil(SL1);
  end;

  procedure MakeSeparatorItem;
  begin
    var aMenuItem:= TSpTBXSeparatorItem.Create(Frame.PopMenuObject);
    aMenuItem.Tag:= InheritedLevel;
    if (InheritedLevel = 0) then begin
        Frame.PopMenuObject.Items.Insert(MenuIndex, aMenuItem);
        Inc(MenuIndex);
    end else begin
      aMenuItem.Tag:= InheritedLevel;
      aInheritedMenu.Add(aMenuItem);
    end;
  end;

  procedure MakeMethodMenuFromModel;
    var
      Operation: UModel.TOperation;
      Parameter: TParameter;
      s1, s2, ancest, iname: string;
      it1, it2: IModelIterator;
  begin
    var SLSorted:= TStringList.Create;
    SLSorted.Sorted:= True;
    repeat
      it1:= aModelClass.GetOperations;
      while it1.HasNext do begin
        Operation:= it1.Next as UModel.TOperation;
        if (InheritedLevel > 0) and (Operation.Visibility = viPrivate) then Continue;
        if (Operation.OperationType in [otProcedure, otFunction]) and not Operation.IsAbstract then begin
          iname:= getInternName(aModelClass, Operation.Name, Operation.Visibility);
          s1:= Operation.Name + '(';
          s2:= iname + '(';
          it2:= Operation.GetParameters;
          while it2.HasNext do begin
            Parameter:= it2.Next as TParameter;
            if (Parameter.Name = 'self') or (Parameter.Name = 'cls') then
              Continue;
            s1:= s1 + Parameter.Name;
            s2:= s2 + Parameter.Name;
            if Assigned(Parameter.TypeClassifier) then
              s1:= s1 + ': ' + Parameter.TypeClassifier.asType;
            s2:= s2 + chr(4);
            if Parameter.Value <> '' then begin
              s1:= s1 + chr(4) + Parameter.Value;
              s2:= s2 + Parameter.Value;
            end;
            s1:= s1 + ', ';
            s2:= s2 + chr(5);
          end;
          s1:= myStringReplace(s1 + ')', ', )', ')');
          s2:= s2 + ')';
          if (Operation.OperationType = otFunction) and Assigned(Operation.ReturnValue) then
            s1:= s1 + ': ' + Operation.ReturnValue.GetShortType;
          // Operation.Name is sort-criteria, s1 is Menu.caption, s2 is for calling method
          SLSorted.add(Operation.Name + chr(3) + s1 + chr(3) + s2 + chr(3) + IntToStr(Integer(Operation.Visibility) + 7));
        end;
      end;
      // end of while - all methods handelt

      MakeSortedMenu(SLSorted);
      SLSorted.Text:= '';

      // empty inherited methods menu
      if (InheritedLevel > 0) and (aInheritedMenu.Count = 0) then begin
        FreeAndNil(aInheritedMenu);
        Dec(MenuIndex);
      end;
      if aModelClass.AncestorsCount > 0 then begin
        var aClassname:= aModelClass.Name;
        ancest:= aModelClass.Ancestor[0].Name;
        aModelClass:= getModelClass(ancest);
        { if assigned(aModelClass) and (aModelClass.Name = aClassname) then
          break;}
        if (aModelClass = nil) or (aModelClass.Pathname = '') then
          aModelClass:= CreateModelClass(ancest);
      end else
        aModelClass:= nil;
      if Assigned(aModelClass) then begin
        Inc(InheritedLevel);
        aInheritedMenu:= TSpTBXSubmenuItem.Create(Frame.PopMenuObject);
        aInheritedMenu.Caption:= _('Inherited from') + ' ' + aModelClass.Name;
        Frame.PopMenuObject.Items.Insert(MenuIndex, aInheritedMenu);
        Inc(MenuIndex);
      end else
        Break;
    until False;
    FreeAndNil(SLSorted);
  end;

  procedure MakeMethodMenuFromLivingObjects;
    var SLSorted, SLMethods, SLParameters: TStringList;
        s1, s2, Param, ParamTyp, ReturnType, Signature: string;
  begin
    SLSorted:= TStringList.Create;
    SLSorted.Sorted:= True;
    SLMethods:= FLivingObjects.getMethods(Objectname);
    var p:= SLMethods.IndexOf('__init__');
    if p > -1 then SLMethods.Delete(p);
    for var i:= 0 to SLMethods.Count - 1 do begin
       s1:= SLMethods[i] + '(';
       s2:= s1;
       Signature:= FLivingObjects.getSignature(Objectname + '.' + SLMethods[i]);
       p:= Pos('->', Signature);
       if p > 0 then begin
         ReturnType:= Trim(Copy(Signature, p + 2, Length(Signature)));
         Signature:= Trim(Copy(Signature, 1, p - 1));
       end else
         ReturnType:= '';
       Signature:= Copy(Signature, 2, Length(Signature) - 2);
       SLParameters:= Split(',', Signature);
       for var j:= 0 to SLParameters.Count -1 do begin
          Param:= SLParameters[j];
          p:= Pos(':', Param);
          if p > 0 then begin
            ParamTyp:= Trim(Copy(Param, p+1, Length(Param)));
            Param:= Copy(Param, 1, p - 1);
          end else
            ParamTyp:= '';
          s1:= s1 + Param;
          s2:= s2 + Param;
          if ParamTyp <> '' then
            s1:= s1 + ': ' + ParamTyp;
          s2:= s2 + chr(4);
          s1:= s1 + ', ';
          s2:= s2 + chr(5);
       end;
       s1:= myStringReplace(s1 + ')', ', )', ')');
       s2:= s2 + ')';
       if ReturnType <> '' then
         s1:= s1 + ': ' + ReturnType;
       SLSorted.add(SLMethods[i] + chr(3) + s1 + chr(3) + s2 + chr(3) + IntToStr(Integer(viPublic) + 7));
       FreeAndNil(SLParameters);
    end;
    FreeAndNil(SLMethods);
    MakeSortedMenu(SLSorted);
    FreeAndNil(SLSorted);
  end;

begin // PopMenuObjectPopup
  C:= FindVCLWindow((Sender as TPopupMenu).PopupPoint);
  Panel.ClearSelection;
  if Assigned(C)
    then TManagedObject(Panel.FindManagedControl(C)).Selected:= True
    else Exit;

  // delete previous menu
  for i:= Frame.PopMenuObject.Items.Count - 1 downto 0 do
    if Frame.PopMenuObject.Items[i].Tag <= 0 then begin
      aMenuItem:= Frame.PopMenuObject.Items[i];
      FreeAndNil(aMenuItem);
    end;
  for i:= Frame.MIObjectPopupShowNewObject.Count - 1 downto 0 do begin
    aMenuItem:= Frame.MIObjectPopupShowNewObject.Items[i];
    FreeAndNil(aMenuItem);
  end;

  FullParameters.Clear;

  if Assigned(C) and (C is TRtfdObject) then begin
    Objectname:= (C as TRtfdObject).Entity.FullName;
    Longtype:= ((C as TRtfdObject).Entity as TObjekt).getTyp.Name;
    InheritedLevel:= 0;
    MenuIndex:= 3;   // edit, show, hide, show final, hide final, open class
    Inc(MenuIndex);
    MakeShowUnnamedMenu;
    MakeSeparatorItem;

    // get model class for object to get the methods
    aObjectBox:= GetBox(Objectname) as TRtfdObject;
    aViewClass:= GetBox(Longtype) as TRtfdClass;
    if aViewClass = nil then
      aViewClass:= GetBox(getShortType(LongType)) as TRtfdClass;
    aModelClass:= nil;
    if Assigned(aViewClass) then
      aModelClass:= (aViewClass.Entity as TClass);       // model class from view class
    if aModelClass = nil then
      aModelClass:= getModelClass(LongType);             // model class from model
    if (aModelClass = nil) or (aModelClass.Pathname = '') then
      aModelClass:= CreateModelClass(LongType);          // model class from python
    aModelClassRoot:= aModelClass;

    if Assigned(aModelClass)
      then MakeMethodMenuFromModel // known Class in Model
      else MakeMethodMenuFromLivingObjects;

    InheritedLevel:= 0;
    Inc(MenuIndex, 1);
    MakeSeparatorItem;
    if Assigned(aModelClassRoot)
      then Frame.MIObjectPopupEdit.Visible:= HasAttributes(Objectname)
      else Frame.MIObjectPopupEdit.Visible:= False;
    if Assigned(aObjectBox) then begin
      Frame.MIObjectPopupShowInherited.Visible:= not aObjectBox.ShowInherited;
      Frame.MIObjectPopupHideInherited.Visible:= aObjectBox.ShowInherited;
    end;

    // ToDo
    Frame.MIObjectPopupShowInherited.Visible:= False;
    Frame.MIObjectPopupHideInherited.Visible:= False;

    for i:= 0 to Frame.MIObjectPopupDisplay.Count - 1 do
      Frame.MIObjectPopupDisplay.Items[i].Checked:= False;
    i:= 3 - Ord(aObjectBox.MinVisibility);
    Frame.MIObjectPopupDisplay.Items[i].Checked:= True;

    for i:= 0 to Frame.MIObjectPopupVisibility.Count - 1 do
      Frame.MIObjectPopupVisibility.Items[i].Checked:= False;
    i:= 2 - aObjectBox.ShowIcons;
    Frame.MIObjectPopupVisibility.Items[i].Checked:= True;
  end;
end; // PopMenuObjectPopup

procedure TRtfdDiagram.PopMenuConnectionPopup(Sender: TObject);
  var Conn: TConnection;
      BothClass, AClassAObject: Boolean;
begin
  Conn:= Panel.GetClickedConnection;
  if Conn = nil then Exit;

  BothClass:=
    ((Conn.FFrom is TRtfdClass) and (Conn.FTo is TRtfdClass));
  AClassAObject:=
    ((Conn.FFrom is TRtfdClass) and (Conn.FTo is TRtfdObject)) or
    ((Conn.FFrom is TRtfdObject) and (Conn.FTo is TRtfdClass));
  Frame.MIConnectionAssociation.Visible:= BothClass;
  Frame.MIConnectionAssociationArrow.Visible:= BothClass;
  Frame.MIConnectionAssociationBidirectional.Visible:= BothClass;
  Frame.MIConnectionAggregation.Visible:= BothClass;
  Frame.MIConnectionAggregationArrow.Visible:= BothClass;
  Frame.MIConnectionComposition.Visible:= BothClass;
  Frame.MIConnectionCompositionArrow.Visible:= BothClass;
  Frame.MIConnectionInheritance.Visible:= not Conn.isRecursiv and BothClass;
  Frame.MIConnectionInstanceOf.Visible:= AClassAObject;
  Frame.MIConnectionRecursiv.Visible:= Conn.isRecursiv;
end;

function TRtfdDiagram.HasAttributes(Objectname: string): Boolean;
begin
  var SL:= FLivingObjects.getObjectMembers(Objectname);
  Result:= (SL.Count > 0);
  FreeAndNil(SL);
end;

function TRtfdDiagram.hasSelectedConnection: Boolean;
begin
  Result:= Panel.hasSelectedConnection;
end;

procedure TRtfdDiagram.OpenClassOrInterface(Sender: TObject);
  var CName, FileName: string;
begin
  CName:= (Sender as TSpTBXItem).Caption;
  try
    Screen.Cursor:= crHourGlass;
    FileName:= MenuClassFiles.Values[CName];
    (Frame.Parent.Owner as TFUMLForm).AddToProject(FileName);
    Panel.ClearSelection;
  finally
    Screen.Cursor:= crDefault;
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
  var address: string; p: Integer;
begin
  p:= Pos(' ', Objectname);
  while p > 0 do begin
    Delete(Objectname, 1, p);
    p:= Pos(' ', Objectname);
  end;
  if FLivingObjects.ObjectExists(Objectname) then begin
    // ToDo is this necessary?
    PyControl.ActiveInterpreter.RunSource('import ctypes', '<interactive input>');
    address:= FLivingObjects.getRealAddressFromName(Objectname);
    PyControl.ActiveInterpreter.RunSource(
      Objectname + ' = ctypes.cast(' + address + ', ctypes.py_object).value',
      '<interactive input>');
    FLivingObjects.SimplifyPath(Objectname);
    ShowNewObject(Objectname);
  end;
end;

procedure TRtfdDiagram.ShowUnnamedObject(Sender: TObject);
begin
  try
    LockFormUpdate(UMLForm);
    ShowUnnamed((Sender as TSpTBXItem).Caption);
    ResolveObjectAssociations;
    UpdateAllObjects;
    Panel.RecalcSize;
  finally
    UnlockFormUpdate(UMLForm);
  end;
end;

procedure TRtfdDiagram.ShowAllNewObjects(Sender: TObject);
  var i: Integer;
begin
  try
    LockFormUpdate(UMLForm);
    Screen.Cursor:= crHourGlass;
    if Frame.MIObjectPopupShowNewObject.Visible then
      for i:= 0 to Frame.MIObjectPopupShowNewObject.Count - 1 do
        ShowUnnamed(Frame.MIObjectPopupShowNewObject.Items[i].Caption)
    else begin
      i:= 0;
      while (i < Frame.PopMenuObject.Items.Count) and
            (Frame.PopMenuObject.Items[i].Tag <> -2)  do
        Inc(i);
      while (i < Frame.PopMenuObject.Items.Count) and
            (Frame.PopMenuObject.Items[i].Tag = -2) do begin
        ShowUnnamed(Frame.PopMenuObject.Items[i].Caption);
        Inc(i);
      end;
    end;
    ResolveObjectAssociations;
  finally
    UnLockFormUpdate(UMLForm);
    Screen.Cursor:= crDefault;
  end;
end;

procedure TRtfdDiagram.ShowAllNewObjectsString(From: string = '');
  var SLObjects: TStringList;
      Py: IPyEngineAndGIL;
      newObject, address: string;
      i: Integer;
begin
  PyControl.ActiveInterpreter.RunSource('import ctypes', '<interactive input>');
  SLObjects:= FLivingObjects.getAllObjects;
  Py := SafePyEngine;
  for i:= 0 to SLObjects.Count - 1 do begin
    newObject:= SLObjects.KeyNames[i];
    if BoxNames.IndexOf(newObject) = -1 then begin
      address:= FLivingObjects.getRealAddressFromName(newObject);
      PyControl.ActiveInterpreter.RunSource(
        newObject + ' = ctypes.cast(' + address + ', ctypes.py_object).value',
        '<interactive input>');
      FLivingObjects.SimplifyPath(newObject);
      ShowNewObject(newObject);
      if From = '' then
        From:= 'Actor';
      ShowMethodEntered('<init>', From, newObject, '');
    end;
  end;
  UpdateAllObjects;
  ResolveObjectAssociations;
  Panel.RecalcSize;
end;

procedure TRtfdDiagram.ConnectBoxes(Sender: TObject);
  var CName: string; Src: TControl; Dest: TRtfdBox; UMLForm: TFUMLForm;
begin
  Src:= Panel.GetFirstSelected;
  if (Src <> nil) and (Src is TRtfdBox) then begin
    if Src.Owner.Owner is TFUMLForm
      then UMLForm:= Src.Owner.Owner as TFUMLForm
      else UMLForm:= nil;
    LockFormUpdate(UMLForm);
    CName:= (Sender as TSpTBXItem).Caption;
    Dest:= GetBox(CName);
    Panel.FindManagedControl(Dest).Selected:= True;
    Panel.ConnectBoxes(Src, Dest);
    UnLockFormUpdate(UMLForm);
  end;
end;

procedure TRtfdDiagram.DoConnection(Item: Integer);
begin
  Panel.DoConnection(Item);
end;

procedure TRtfdDiagram.DoAlign(Item: Integer);
begin
  Panel.DoAlign(Item);
end;

procedure TRtfdDiagram.SetInteractive(OnInteractiveModified: TNotifyEvent);
begin
  OnModified:= OnInteractiveModified;
end;

procedure TRtfdDiagram.SetFormMouseDown(OnFormMouseDown: TNotifyEvent);
begin
  Panel.OnFormMouseDown:= OnFormMouseDown;
end;

procedure TRtfdDiagram.AddToInteractive(const s: string);
begin
  UMLForm.AddInteractiveLine(s);
end;

function TRtfdDiagram.EditClass(const Caption, Title, ObjectNameOld: string;
           var ObjectNameNew: string; Attributes: TStringList): Boolean;
  var i, Count: Integer;
begin
  FObjectGenerator.PrepareEditClass(Caption, Title, ObjectNameOld);
  Result:= Edit(Attributes, 2);
  if Result then begin
    ObjectNameNew:= FObjectGenerator.ValueListEditor.Cells[1, 1];
    Count:= Attributes.Count;
    Attributes.Clear;
    for i:= 0 to Count - 1 do
      Attributes.Add(FObjectGenerator.ValueListEditor.Cells[0, i+2] + '=' +
                     FObjectGenerator.ValueListEditor.Cells[1, i+2]);
  end;
end;

function TRtfdDiagram.EditObjectOrParams(const Caption, Title: string; Attributes: TStringList): Boolean;
  var Count, i: Integer;
begin
  FObjectGenerator.PrepareEditObjectOrParams(Caption, Title);
  Result:= Edit(Attributes, 1);
  if Result then begin
    Count:= Attributes.Count;
    Attributes.Clear;
    for i:= 0 to Count - 1 do
      Attributes.Add(FObjectGenerator.ValueListEditor.Cells[0, i+1] + '=' +
                     FObjectGenerator.ValueListEditor.Cells[1, i+1]);
  end;
end;

function TRtfdDiagram.Edit(Attributes: TStringList; Row: Integer): Boolean;
  var i: Integer;
begin
  for i:= 0 to Attributes.Count - 1 do
    FObjectGenerator.AddRow(Attributes.KeyNames[i], Attributes.ValueFromIndex[i]);
  FObjectGenerator.DeleteRow;
  FObjectGenerator.SetRow(Row);
  FObjectGenerator.SetColWidths;
  Result:= (FObjectGenerator.ShowModal = mrOk);
end;

procedure TRtfdDiagram.DeleteObjects;
  var i: Integer; aObject: TRtfdObject; ManagedObject: TManagedObject;
begin
  // FLivingObjects.makeAllObjects;
  UnSelectAllElements;
  for i:= BoxNames.Count - 1 downto 0 do
    if (BoxNames.Objects[i] is TRtfdObject) then begin
      aObject:= BoxNames.Objects[i] as TRtfdObject;
      ManagedObject:= Panel.FindManagedControl(aObject);
      if Assigned(ManagedObject) then begin
        ManagedObject.Selected:= True;
      end;
    end;
  DeleteSelectedControls(nil);
  Panel.Invalidate;
end;

function TRtfdDiagram.hasObjects: Boolean;
begin
  for var i:= 0 to BoxNames.Count - 1 do
    if (BoxNames.Objects[i] is TRtfdObject) then
      Exit(True);
  Result:= False;
end;

procedure TRtfdDiagram.Reinitalize;
begin
  DeleteObjects;
  FLivingObjects.DeleteObjects;
  RefreshDiagram;
end;

procedure TRtfdDiagram.SetRecursiv(P: TPoint; pos: Integer);
begin
  Panel.SetRecursiv(P, pos);
end;

function TRtfdDiagram.getModelClass(const s: string): TClass;
  var Ci: IModelIterator; cent: TClassifier; typ: string;
begin
  Result:= nil;
  Ci:= Model.ModelRoot.GetAllClassifiers;
  while Ci.HasNext do begin
    cent:= TClassifier(Ci.Next);
    if cent is TClass then begin
      typ:= (cent as TClass).getTyp;
      if (typ = s) or (typ = GetShortType(s)) then begin
        Result:= (cent as TClass);
        Break;
      end;
    end;
  end;                    // without source
  if Assigned(Result) and (Result.Pathname = '') then begin
    var U:= Model.ModelRoot.FindUnitPackage('Default');
    U.DeleteObject(typ);
    Result:= nil;
  end;
end;

function TRtfdDiagram.StringToArrowStyle(s: string): TessConnectionArrowStyle;
  var i: Integer; t: TessConnectionArrowStyle;
begin
  Result:= asAssociation1;
  s:= Trim(s);
  if TryStrToInt(s, i) then // pre 10.3 uml-file-format
    Result:= TessConnectionArrowStyle(i)
  else
    for t:= asAssociation1 to asComment do
      if ArrowStyleToString(t) = s then begin
        Result:= t;
        Exit;
      end;
end;

function TRtfdDiagram.ArrowStyleToString(ArrowStyle: TessConnectionArrowStyle): string;
begin
  case ArrowStyle of
    asAssociation1: Result:= 'Association';
    asAssociation2: Result:= 'AssociationDirected';
    asAssociation3: Result:= 'AssociationBidirectional';
    asAggregation1: Result:= 'Aggregation';
    asAggregation2: Result:= 'AggregationArrow';
    asComposition1: Result:= 'Composition';
    asComposition2: Result:= 'CompositionArrow';
    asInheritends:  Result:= 'Inheritends';
    asInstanceOf:   Result:= 'InstanceOf';
    asComment:      Result:= 'Comment';
  end;
end;

function TRtfdDiagram.getSourcepath: string;
  var i: Integer; SL: TStringList; s: string;
begin
  Result:= '';
  if Assigned(Model) and Assigned(Model.ModelRoot) then begin
    SL:= Model.ModelRoot.Files;
    for i:= 0 to SL.Count - 1 do begin
      s:= SL[i];
      s:= ExtractFilePath(s);
      if Pos(s, Result) = 0 then
        Result:= Result + ';' + s;
    end;
    Delete(Result, 1, 1);
  end;
end;

function TRtfdDiagram.getCommentBoxName: string;
  var i, Nr, CommentNr: Integer;
      s: string;
begin
  CommentNr:= 0;
  for i:= 0 to BoxNames.Count - 1 do
    if Pos('Comment: ', BoxNames[i]) = 1 then begin
      s:= Copy(BoxNames[i], 9, 255);
      if TryStrToInt(s, Nr) then
        CommentNr:= Math.Max(CommentNr, Nr);
    end;
  Result:= 'Comment: ' + IntToStr(CommentNr+1);
end;

procedure TRtfdDiagram.AddCommentBoxTo(aControl: TControl);
  var CommentBox: TRtfdCommentBox;
      aClass: TRtfdClass;
      s: string;
begin
  s:= getCommentBoxName;
  CommentBox:= TRtfdCommentBox.Create(Panel, S, Frame, viPublic, HANDLESIZE);
  CommentBox.Top:= 50 + random(50);
  CommentBox.Left:= 50 + random(50);
  CommentBox.Width:= 150;
  CommentBox.Height:= 100;
  BoxNames.AddObject(S, CommentBox);
  Panel.AddManagedObject(CommentBox);

  if aControl = nil then
    aControl:= Panel.GetFirstSelected;
  if Assigned(aControl) and (aControl is TRtfdClass) then begin
    aClass:= (aControl as TRtfdClass);
    CommentBox.Font.Assign(Font);
    CommentBox.Top:= aClass.Top + random(50);
    CommentBox.Left:= aClass.Left + aClass.Width + 100 + random(50);
    Panel.ConnectObjects(aClass, CommentBox, asComment);
  end;
  Panel.IsModified:= True;
  Panel.RecalcSize;
  Panel.ShowConnections;
  CommentBox.SendToBack;
end;

function TRtfdDiagram.hasClass(aClassname: string): Boolean;
  var i: Integer;
begin
  Result:= False;
  for i:= 0 to BoxNames.Count - 1 do
    if BoxNames[i] = aClassname then begin
      Result:= True;
      Break;
    end;
end;

procedure TRtfdDiagram.DoShowParameter(aControl: TControl; Mode: Integer);
  var Box: TRtfdBox;
begin
  if aControl is TRtfdBox then begin
    Box:= (aControl as TRtfdBox);
    if Box.ShowParameter <> Mode then begin
      Box.ShowParameter:= Mode;
      Panel.ShowAll;
      Panel.IsModified:= True;
    end;
  end;
end;

procedure TRtfdDiagram.DoShowVisibility(aControl: TControl; Mode: Integer);
  var Box: TRtfdBox;
begin
  if aControl is TRtfdBox then begin
    Box:= (aControl as TRtfdBox);
    if Box.ShowIcons <>  Mode then begin
      Box.ShowIcons:= Mode;
      Panel.ShowAll;
      Panel.IsModified:= True;
    end;
  end;
end;

procedure TRtfdDiagram.DoShowVisibilityFilter(aControl: TControl; Mode: Integer);
  var Box: TRtfdBox;
begin
  if aControl is TRtfdBox then begin
    Box:= (aControl as TRtfdBox);
    if Box.MinVisibility <>  TVisibility(Mode) then begin
      Box.MinVisibility:= TVisibility(Mode);
      Panel.ShowAll;
      Panel.IsModified:= True;
    end;
  end;
end;


procedure TRtfdDiagram.CreateTestClass(aControl: TControl);
//  var aClass: TRtfdClass; aClassname, Filename: String; SL: TStringList;
begin
{
  if (aControl is TRtfdClass) then begin
    aClass:= (aControl as TRtfdClass);
    aClassname:= aClass.Entity.Name + 'Test';
    Filename:= ExtractFilepath(aClass.getPathname) + WithoutGeneric(aClassname) + '.py';
    if FileExists(Filename) and
                 (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [Filename]),
                            mtConfirmation, mbYesNoCancel, 0) = mrYes) or
                 not FileExists(Filename)
    then begin
      SL:= TStringList.Create;
      SL.Text:= FObjectgenerator.GetTemplate(aClassname, 12);
      if SL.Text = '' then SL.Text:= FObjectGenerator.GetTestClassCode(aClassname);
      SL.SaveToFile(Filename);
      UMLForm.MainModul.AddToProject(Filename);
      UMLForm.Modified:= true;
    end;
  end;
  }
end;

procedure TRtfdDiagram.OnRunJunitTestMethod(Sender: TObject);
{  var aMenuItem: TSpTBXItem; s: string; p: integer;
      C: TControl;}
begin
{  C:= FindVCLWindow(Frame.PopMenuClass.PopupPoint);
  if (Sender is TSpTBXItem) then begin
    aMenuItem:= Sender as TSpTBXItem;
    p:= FullParameters.IndexOfName(aMenuItem.Caption);
    s:= FullParameters.ValueFromIndex[p];
    RunTests(C, s);
  end;}
end;

procedure TRtfdDiagram.RunTests(aControl: TControl; const Method: string);
begin
{
  if (aControl is TRtfdClass) then
    if (aControl as TRtfdClass).Entity is TClass then begin
      if FJUnitTests = nil then
        FJUnitTests:= TFJUnitTests.Create(FJava);
      FJUnitTests.Pathname:= ((aControl as TRtfdClass).Entity as TClass).Pathname;
      myJavaCommands.RunTests((aControl as TRtfdClass).Entity as TClass, Method);
    end;
    }
end;

procedure TRtfdDiagram.ShowMethodEntered(const aMethodname, From, _To, Parameter: string);
begin
  if Assigned(SequenceForm) then begin
    Sequenceform.MethodEntered(aMethodname);
    if GuiPyOptions.SDShowParameter then
      Sequenceform.addParameter(Parameter);
    Sequenceform.FromParticipant:= From;
    Sequenceform.ToParticipant:= _To;
    Sequenceform.makeConnection;
  end;
end;

procedure TRtfdDiagram.ShowMethodExited(const aMethodname, From, _To, _Result: string);
begin
  if Assigned(SequenceForm) then begin
    Sequenceform.MethodExited(aMethodname);
    Sequenceform.FromParticipant:= From;
    Sequenceform.ToParticipant:= _To;
    Sequenceform.aResult:= _Result;
    Sequenceform.makeConnection;
  end;
end;

procedure TRtfdDiagram.ShowObjectDeleted(const From, _To: string);
begin
  if Assigned(SequenceForm) then begin
    Sequenceform.ObjectDelete;
    Sequenceform.FromParticipant:= From;
    Sequenceform.ToParticipant:= _To;
    Sequenceform.makeConnection;
  end;
end;

procedure TRtfdDiagram.CloseNotify(Sender: TObject);
begin
  SequenceForm:= nil;
end;

procedure TRtfdDiagram.ClearSelection;
begin
  Panel.ClearSelection();
end;

procedure TRtfdDiagram.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    Frame.PopMenuClass.Images:= Frame.vilClassObjectDark;
    Frame.PopMenuObject.Images:= Frame.vilClassObjectDark;
    Frame.PopMenuConnection.Images:= Frame.vilAssociationsDark;
    Frame.PopupMenuWindow.Images:= Frame.vilWindowDark;
    Frame.PopupMenuAlign.Images:= Frame.vilAlignDark;
  end else begin
    Frame.PopMenuClass.Images:= Frame.vilClassObjectLight;
    Frame.PopMenuObject.Images:= Frame.vilClassObjectLight;
    Frame.PopMenuConnection.Images:= Frame.vilAssociationsLight;
    Frame.PopupMenuWindow.Images:= Frame.vilWindowLight;
    Frame.PopupMenuAlign.Images:= Frame.vilAlignLight;
  end;
  Panel.ChangeStyle;
end;

procedure TRtfdDiagram.CopyDiagramToClipboard;
var
  Selected: Boolean;
  B1, B2:  Graphics.TBitmap;
  W, H : Integer;
  SelRect: TRect;
begin
  Panel.ChangeStyle(True);
  SelRect:= GetSelectedRect;
  Selected:= (SelRect.Right > SelRect.Left);
  GetDiagramSize(W, H);
  try
    B1:= Graphics.TBitmap.Create;
    B1.Width := W;
    B1.Height:= H;
    B1.Canvas.Lock;
    PaintTo(B1.Canvas, 0, 0, True);

    B2:= Graphics.TBitmap.Create;
    if Selected then begin
      B2.Width := SelRect.Right - SelRect.Left + 2;
      B2.Height:= SelRect.Bottom - SelRect.Top + 2;
      B2.Canvas.Draw(-SelRect.Left + 1, -SelRect.Top + 1, B1);
      Clipboard.Assign(B2)
    end else
      Clipboard.Assign(B1);
    B1.Canvas.Unlock;
  finally
    FreeAndNil(B1);
    FreeAndNil(B2);
  end;
  ClearSelection;
  Panel.ChangeStyle(False);
end;

procedure TRtfdDiagram.ClearMarkerAndConnections(Control: TControl);
begin
  Panel.ClearMarkerAndConnections(Control);
end;

procedure TRtfdDiagram.DrawMarkers(r: TRect; show: Boolean);
begin
  Panel.DrawMarkers(r, show);
end;

procedure TRtfdDiagram.EditBox(Control: TControl);
begin
  Panel.EditBox(Control);
end;

procedure TRtfdDiagram.SetModified(const Value: Boolean);
begin
  Panel.SetModified(Value);
end;

procedure TRtfdDiagram.SetOnModified(OnBoolEvent: TBoolEvent);
begin
  Panel.OnModified:= OnBoolEvent;
end;

procedure TRtfdDiagram.DeleteComment;
  var C: TControl; ManagedObject: TManagedObject;
begin
  C:= FindVCLWindow(Frame.PopupMenuComment.PopupPoint);
  if Assigned(C) then begin
    ManagedObject:= Panel.FindManagedControl(C);
    if Assigned(ManagedObject) then begin
      UnSelectAllElements;
      ManagedObject.Selected:= True;
      DeleteSelectedControls(nil);
    end;
  end;
end;

procedure TRtfdDiagram.ExecutePython(s: string);
begin
  FLivingObjects.ExecutePython(s);
end;

procedure TRtfdDiagram.GetVisFromName(var Name: string; var vis: TVisibility);
begin
  vis:= viPublic;
  var p:= Pos('__', Name);
  if p > 0 then begin
    Name:= Copy(Name, p+2, Length(Name));
    vis:= viPrivate;
  end;
  if Name[1] = '_' then begin
    Name:= Copy(Name, 2, Length(Name));
    vis:= viProtected;
  end;
end;

function TRtfdDiagram.PanelIsLocked: Boolean;
begin
  Result:= (Panel.UpdateCounter > 0);
end;

procedure TRtfdDiagram.SetUMLFont;
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign(Font);
  ResourcesDataModule.dlgFontDialog.Options:= [];
  if ResourcesDataModule.dlgFontDialog.Execute then begin
    Font.Assign(ResourcesDataModule.dlgFontDialog.Font);
    GuiPyOptions.UMLFont.Assign(Font);
    SetFont(Font);
    RefreshDiagram;
  end;
end;

end.
