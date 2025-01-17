{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter S�derman, Ville Krumlinde
  Gerhard R�hner

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

unit UViewIntegrator;

interface

uses Controls, Graphics, IniFiles, Classes, Types,
     ExtCtrls, uFeedback, uIntegrator, uModel, uModelEntity, UUtils;

type

  //Baseclass for integrators that are parented
  TViewIntegrator = class(TTwowayIntegrator)
  private
    Parent: TWinControl;
    function GetCurrentEntity: TModelEntity;
    class procedure SetCurrentEntity(const Value: TModelEntity);
  protected
    Feedback : IEldeanFeedback;
    procedure CurrentEntityChanged; virtual;
  public
    constructor Create(om: TObjectModel; aParent: TWinControl; aFeedback : IEldeanFeedback = nil); virtual;
    destructor Destroy; override;
    //Current entity, all view integratros share the same instance
    property CurrentEntity : TModelEntity read GetCurrentEntity write SetCurrentEntity;
  end;

  // Class to show/edit a model in a powerpointy view
  // TRtfdDiagram is a descendet of this class
  TDiagramIntegrator = class(TViewIntegrator)
  private
    FShowConnections: Integer;
    FShowParameter: Integer;
    FSortOrder: Integer;
    FShowIcons: Integer;
    FShowView: Integer;
    FShowObjectDiagram: Boolean;
    FFont: TFont;
  protected
    FVisibilityFilter: TVisibility;
    FPackage: TAbstractPackage;
    procedure SetVisibilityFilter(const Value: TVisibility); virtual;
    procedure SetPackage(const Value: TAbstractPackage); virtual;
    procedure SetConnections(const Value: Integer); virtual;
    procedure SetShowView(Value: Integer); virtual;
    procedure SetShowParameter(const Value: Integer); virtual;
    procedure SetSortOrder(const Value: Integer); virtual;
    procedure SetShowIcons(const Value: Integer); virtual;
    procedure SetShowObjectDiagram(const Value: Boolean); virtual;
    function GetStorage(aCreate : Boolean = False) : TMemIniFile; virtual;
  public
    //class function CreateDiagram(om: TObjectModel; aParent: TWinControl; aFeedback : IEldeanFeedback = nil) : TDiagramIntegrator;
    constructor Create(om: TObjectModel; aParent: TWinControl; aFeedback : IEldeanFeedback = nil); override;
    destructor Destroy; override;
    procedure GetDiagramSize(var W, H : Integer); virtual; abstract;
    function GetSelectedRect : TRect; virtual; abstract;
    procedure PaintTo(Canvas: TCanvas; X, Y: Integer; SelectedOnly : Boolean); virtual; abstract;
    procedure SaveAsPicture(const FileName : string);
    procedure DoLayout; virtual; abstract;
    function GetClickAreas : TStringList; virtual; abstract;
    procedure ScreenCenterEntity(E : TModelEntity); virtual; abstract;

    procedure DeleteSelectedControlsAndRefresh; virtual; abstract;
    procedure DeleteObjects; virtual; abstract;
    function hasObjects: Boolean; virtual; abstract;
    procedure ClassEditSelectedDiagramElements; virtual; abstract;
    procedure ClassEditSelectedDiagramElementsControl(Sender: TObject); virtual; abstract;
    procedure SourceEditSelectedDiagramElements(C: TControl); virtual; abstract;
    procedure UnSelectAllElements; virtual; abstract;
    procedure StoreDiagram(filename: string); virtual; abstract;
    procedure FetchDiagram(filename: string); virtual; abstract;
    procedure RefreshDiagram; virtual; abstract;
    procedure ClearDiagram; virtual; abstract;
    procedure RecalcPanelSize; virtual; abstract;
    procedure SelectAssociation; virtual; abstract;
    procedure Retranslate; virtual; abstract;
    procedure InitShowParameter(const Value: Integer);
    function GetPanel: TCustomPanel; virtual; abstract;
    procedure ResolveAssociations; virtual; abstract;
    procedure ResolveObjectAssociations; virtual; abstract;
    function hasSelectedConnection: Boolean; virtual; abstract;
    procedure SetInteractive(OnInteractiveModified: TNotifyEvent); virtual; abstract;
    procedure SetFormMouseDown(OnFormMouseDown: TNotifyEvent); virtual; abstract;
    function getSourcePath: string; virtual; abstract;
    procedure SetFont(const aFont: TFont); virtual;
    function  GetFont: TFont; virtual;
    procedure PopMenuClassPopup(Sender: TObject); virtual; abstract;
    procedure PopMenuObjectPopup(Sender: TOBject); virtual; abstract;
    procedure PopMenuConnectionPopup(Sender: TObject); virtual; abstract;
    procedure Run(C: TControl); virtual; abstract;
    procedure DoShowParameter(aControl: TControl; Mode: Integer); virtual; abstract;
    procedure DoShowVisibility(aControl: TControl; Mode: Integer); virtual; abstract;
    procedure DoShowVisibilityFilter(aControl: TControl; Mode: Integer); virtual; abstract;
    procedure ShowInheritedMethodsFromSystemClasses(C: TControl; ShowOrHide: Boolean); virtual; abstract;
    procedure AddCommentBoxTo(aControl: TControl); virtual; abstract;
    procedure DoConnection(Item: Integer); virtual; abstract;
    procedure DoAlign(Item: Integer); virtual; abstract;
    procedure ClearSelection; virtual; abstract;
    procedure CreateTestClass(aControl: TControl); virtual; abstract;
    procedure RunTests(aControl: TControl; const Method: string); virtual; abstract;
    procedure EditObject(C: TControl); virtual; abstract;
    procedure OpenClassWithDialog; virtual; abstract;
    procedure NewClass; virtual; abstract;
    procedure ShowAll; virtual; abstract;
    procedure ShowAllNewObjects(Sender: TObject); virtual; abstract;
    procedure ShowUnnamedObject(Sender: TObject); virtual; abstract;
    procedure SetRecursiv(P: TPoint; pos: Integer); virtual; abstract;
    procedure CopyDiagramToClipboard; virtual; abstract;
    procedure ClearMarkerAndConnections(Control: TControl); virtual; abstract;
    procedure DrawMarkers(r: TRect; show: Boolean); virtual; abstract;
    procedure EditBox(Control: TControl); virtual; abstract;
    procedure SetModified(const Value: Boolean); virtual; abstract;
    procedure SetOnModified(OnBoolEvent: TBoolEvent); virtual; abstract;
    procedure ChangeStyle; virtual; abstract;
    procedure DeleteComment; virtual; abstract;
    function getSVG: string; virtual; abstract;
    procedure ExecutePython(s: string); virtual; abstract;
    procedure Reinitalize; virtual; abstract;
    function PanelIsLocked: Boolean; virtual; abstract;
    procedure SetUMLFont; virtual; abstract;
    function HasAInvalidClass: Boolean; virtual; abstract;

    //Current package
    property Package: TAbstractPackage read FPackage write SetPackage;
    property VisibilityFilter : TVisibility read FVisibilityFilter write SetVisibilityFilter;
    property ShowConnections : Integer read FShowConnections write SetConnections;
    property ShowView: Integer read FShowView write SetShowView;
    property ShowParameter: Integer read FShowParameter write SetShowParameter;
    property SortOrder: Integer read FSortOrder write SetSortOrder;
    property ShowIcons: Integer read FShowIcons write SetShowIcons;
    property ShowObjectDiagram: Boolean read FShowObjectDiagram write SetShowObjectDiagram;
    property Font: TFont read GetFont write SetFont;
  end;

  procedure SetCurrentEntity(Value: TModelEntity);

implementation

uses SysUtils, Contnrs, Forms, Imaging.pngimage, uConfiguration;

var
  _CurrentEntity : TModelEntity = nil;
  _ViewIntegrators : TObjectList;

{ TViewIntegrator }

constructor TViewIntegrator.Create(om: TObjectModel; aParent: TWinControl; aFeedback : IEldeanFeedback = nil);
begin
  inherited Create(om);
  Self.Parent:= aParent;
  if aFeedback = nil
    then Self.Feedback:= NilFeedback
    else Self.Feedback:= aFeedback;
  _ViewIntegrators.Add(Self);
end;

{ TDiagramIntegrator }

//Factoryfunction, creates an instance of TDiagramIntegrator

{class function TDiagramIntegrator.CreateDiagram(om: TObjectModel; aParent: TWinControl; aFeedback : IEldeanFeedback = nil): TDiagramIntegrator;
begin
  // Parent.Owner = MainForm
  //Result:= TRtfdDiagram.Create(om, aParent, aFeedback); ToDo
end;
}

procedure TDiagramIntegrator.SetPackage(const Value: TAbstractPackage);
begin
  FPackage := Value;
end;

//Creates storage space for the diagram
function TDiagramIntegrator.GetStorage(aCreate: Boolean): TMemIniFile;
var
  F : string;
begin
  Result := nil;
  if Assigned(FPackage) then
  begin
    F := FPackage.GetConfigFile;
    if F='' then
      F := ChangeFileExt(Application.ExeName,ConfigFileExt);
    if FileExists(F) or aCreate then
      Result := TMemIniFile.Create(F);
  end;
end;

procedure TDiagramIntegrator.SetVisibilityFilter(const Value: TVisibility);
begin
  if FVisibilityFilter <> Value then
    FVisibilityFilter := Value;
end;

procedure TDiagramIntegrator.SetShowParameter(const Value: Integer);
begin
  if FShowParameter<>Value then
    FShowParameter := Value;
end;

procedure TDiagramIntegrator.SetSortOrder(const Value: Integer);
begin
  if FSortOrder<>Value then
    FSortOrder := Value;
end;

procedure TDiagramIntegrator.SetShowIcons(const Value: Integer);
begin
  if FShowIcons <> Value then
    FShowIcons:= Value;
end;

procedure TDiagramIntegrator.SetShowObjectDiagram(const Value: Boolean);
begin
  if FShowObjectDiagram <> Value then
    FShowObjectDiagram:= Value;
end;

procedure TDiagramIntegrator.SetFont(const aFont: TFont);
begin
  FFont.Assign(aFont);
end;

function TDiagramIntegrator.GetFont: TFont;
begin
  Result:= FFont;
end;

procedure TDiagramIntegrator.SaveAsPicture(const FileName: string);
  var W, H: Integer;

  procedure InToPng;
  var
    Bitmap : Graphics.TBitmap;
    png: TPngImage;
  begin
    Bitmap:= Graphics.TBitmap.Create;
    png:= TPngImage.Create;
    try
      try
        Bitmap.PixelFormat:= pf8bit;
        Bitmap.Width := W;
        Bitmap.Height := H;
        PaintTo(Bitmap.Canvas, 0, 0, False);
        Png.Assign(Bitmap);
        Png.SaveToFile(FileName);
      finally
        FreeAndNil(Bitmap);
        FreeAndNil(Png);
      end;
    except
    end;
  end;

  procedure InToSVG;
  begin
    var SL:= TStringList.Create;
    SL.Text:= getSVG;
    SL.SaveToFile(FileName, TEncoding.UTF8);
    FreeAndNil(SL);
  end;

begin
  GetDiagramSize(W, H);
  if LowerCase(ExtractFileExt(FileName)) = '.svg'
    then InToSVG
    else InToPng;
end;

procedure TDiagramIntegrator.SetConnections(const Value: Integer);
begin
  FShowConnections := Value;
end;

procedure TDiagramIntegrator.SetShowView(Value: Integer);
begin
  FShowView := Value;
end;

procedure TDiagramIntegrator.InitShowParameter(const Value: Integer);
begin
  FShowParameter := Value;
end;

//--------------------------------------

procedure TViewIntegrator.CurrentEntityChanged;
begin
//stub
end;

destructor TViewIntegrator.Destroy;
begin
  _ViewIntegrators.Remove(Self);
  inherited;
end;

function TViewIntegrator.GetCurrentEntity: TModelEntity;
begin
  Result := _CurrentEntity;
end;


procedure SetCurrentEntity(Value : TModelEntity);
var
  I : Integer;
begin
  if Value<>_CurrentEntity then
  begin
    _CurrentEntity := Value;
    for I := 0 to _ViewIntegrators.Count-1 do
      (_ViewIntegrators[I] as TViewIntegrator).CurrentEntityChanged;
  end;
end;

class procedure TViewIntegrator.SetCurrentEntity(const Value: TModelEntity);
begin
  uViewIntegrator.SetCurrentEntity(Value);
end;

constructor TDiagramIntegrator.Create(om: TObjectModel;
  aParent: TWinControl; aFeedback: IEldeanFeedback);
begin
  inherited Create(om, aParent, aFeedback);
  FFont:= TFont.Create;
  FFont.Assign(GuiPyOptions.UMLFont);
  FVisibilityFilter:= TVisibility(GuiPyOptions.DiVisibilityFilter);
  FSortOrder:= GuiPyOptions.DiSortOrder;
  FShowParameter:= GuiPyOptions.DiShowParameter;
  FShowIcons:= GuiPyOptions.DiShowIcons;
end;

destructor TDiagramIntegrator.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

initialization
  _ViewIntegrators := TObjectList.Create(False);

finalization
  FreeAndNil(_ViewIntegrators);
end.

