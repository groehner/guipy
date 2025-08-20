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

unit UViewIntegrator;

interface

uses
  Controls,
  Graphics,
  IniFiles,
  Classes,
  Types,
  ExtCtrls,
  UIntegrator,
  UModel,
  UModelEntity,
  UUtils;

type

  // Baseclass for integrators that are parented
  TViewIntegrator = class(TTwowayIntegrator)
  private
    FParent: TWinControl;
    function GetCurrentEntity: TModelEntity;
    class procedure SetCurrentEntity(const Value: TModelEntity);
  protected
    procedure CurrentEntityChanged; virtual;
  public
    constructor Create(ObjectModel: TObjectModel; Parent: TWinControl); virtual;
    destructor Destroy; override;
    // Current entity, all view integratros share the same instance
    property CurrentEntity: TModelEntity read GetCurrentEntity
      write SetCurrentEntity;
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
    procedure SetShowConnections(const Value: Integer); virtual;
    procedure SetShowView(Value: Integer); virtual;
    procedure SetShowParameter(const Value: Integer); virtual;
    procedure SetSortOrder(const Value: Integer); virtual;
    procedure SetShowIcons(const Value: Integer); virtual;
    procedure SetShowObjectDiagram(const Value: Boolean); virtual;
    function GetStorage(Create: Boolean = False): TMemIniFile; virtual;
  public
    // class function CreateDiagram(om: TObjectModel; aParent: TWinControl; aFeedback : IEldeanFeedback = nil) : TDiagramIntegrator;
    constructor Create(ObjectModel: TObjectModel; Parent: TWinControl);
      override;
    destructor Destroy; override;
    procedure GetDiagramSize(var Width, Height: Integer); virtual; abstract;
    function GetSelectedRect: TRect; virtual; abstract;
    procedure PaintTo(Canvas: TCanvas; X, Y: Integer; SelectedOnly: Boolean);
      virtual; abstract;
    procedure SaveAsPicture(const Filename: string);
    procedure DoLayout; virtual; abstract;
    function GetClickAreas: TStringList; virtual; abstract;
    procedure ScreenCenterEntity(ModelEntity: TModelEntity); virtual; abstract;
    procedure DeleteSelectedControlsAndRefresh; virtual; abstract;
    procedure DeleteObjects; virtual; abstract;
    function HasObjects: Boolean; virtual; abstract;
    procedure ClassEditSelectedDiagramElements; virtual; abstract;
    procedure ClassEditSelectedDiagramElementsControl(Sender: TObject);
      virtual; abstract;
    procedure SourceEditSelectedDiagramElements(Control: TControl);
      virtual; abstract;
    procedure UnSelectAllElements; virtual; abstract;
    procedure StoreDiagram(const Filename: string); virtual; abstract;
    procedure FetchDiagram(Filename: string); virtual; abstract;
    procedure RefreshDiagram; virtual; abstract;
    procedure ClearDiagram; virtual; abstract;
    procedure RecalcPanelSize; virtual; abstract;
    procedure SelectAssociation; virtual; abstract;
    procedure Retranslate; virtual; abstract;
    procedure InitShowParameter(const Value: Integer);
    function GetPanel: TCustomPanel; virtual; abstract;
    procedure ResolveAssociations; virtual; abstract;
    procedure ResolveObjectAssociations; virtual; abstract;
    function HasSelectedConnection: Boolean; virtual; abstract;
    procedure SetInteractive(OnInteractiveModified: TNotifyEvent);
      virtual; abstract;
    procedure SetFormMouseDown(OnFormMouseDown: TNotifyEvent); virtual;
      abstract;
    function GetSourcePath: string; virtual; abstract;
    procedure SetFont(const Font: TFont); virtual;
    function GetFont: TFont; virtual;
    procedure PopMenuClassPopup(Sender: TObject); virtual; abstract;
    procedure PopMenuObjectPopup(Sender: TObject); virtual; abstract;
    procedure PopMenuConnectionPopup(Sender: TObject); virtual; abstract;
    procedure Run(Control: TControl); virtual; abstract;
    procedure DoShowParameter(Control: TControl; Mode: Integer);
      virtual; abstract;
    procedure DoShowVisibility(Control: TControl; Mode: Integer);
      virtual; abstract;
    procedure DoShowVisibilityFilter(Control: TControl; Mode: Integer);
      virtual; abstract;
    procedure ShowInheritedMethodsFromSystemClasses(Control: TControl;
      ShowOrHide: Boolean); virtual; abstract;
    procedure AddCommentBoxTo(Control: TControl); virtual; abstract;
    procedure DoConnection(Item: Integer); virtual; abstract;
    procedure DoAlign(Item: Integer); virtual; abstract;
    procedure ClearSelection; virtual; abstract;
    procedure CreateTestClass(Control: TControl); virtual; abstract;
    procedure RunTests(Control: TControl; const Method: string);
      virtual; abstract;
    procedure EditObject(Control: TControl); virtual; abstract;
    procedure OpenClassWithDialog; virtual; abstract;
    procedure NewClass; virtual; abstract;
    procedure ShowAll; virtual; abstract;
    procedure ShowAllNewObjects(Sender: TObject); virtual; abstract;
    procedure ShowUnnamedObject(Sender: TObject); virtual; abstract;
    procedure SetRecursiv(Point: TPoint; Pos: Integer); virtual; abstract;
    procedure CopyDiagramToClipboard; virtual; abstract;
    procedure ClearMarkerAndConnections(Control: TControl); virtual; abstract;
    procedure DrawMarkers(Rect: TRect; Show: Boolean); virtual; abstract;
    procedure EditBox(Control: TControl); virtual; abstract;
    procedure SetModified(const Value: Boolean); virtual; abstract;
    procedure SetOnModified(OnBoolEvent: TBoolEvent); virtual; abstract;
    procedure ChangeStyle; virtual; abstract;
    procedure DeleteComment; virtual; abstract;
    function GetSVG: string; virtual; abstract;
    procedure ExecutePython(const Source: string); virtual; abstract;
    procedure Reinitalize; virtual; abstract;
    function PanelIsLocked: Boolean; virtual; abstract;
    procedure SetUMLFont; virtual; abstract;
    function HasAInvalidClass: Boolean; virtual; abstract;

    // Current package
    property Package: TAbstractPackage read FPackage write SetPackage;
    property VisibilityFilter: TVisibility read FVisibilityFilter
      write SetVisibilityFilter;
    property ShowConnections: Integer read FShowConnections
      write SetShowConnections;
    property ShowView: Integer read FShowView write SetShowView;
    property ShowParameter: Integer read FShowParameter write SetShowParameter;
    property SortOrder: Integer read FSortOrder write SetSortOrder;
    property ShowIcons: Integer read FShowIcons write SetShowIcons;
    property ShowObjectDiagram: Boolean read FShowObjectDiagram
      write SetShowObjectDiagram;
    property Font: TFont read GetFont write SetFont;
  end;

procedure SetCurrentEntity(Value: TModelEntity);

implementation

uses
  Winapi.Windows,
  SysUtils,
  Contnrs,
  Forms,
  Imaging.pngimage,
  JvGnugettext,
  StringResources,
  UConfiguration;

var
  GCurrentEntity: TModelEntity = nil;
  GViewIntegrators: TObjectList;

  { TViewIntegrator }

constructor TViewIntegrator.Create(ObjectModel: TObjectModel;
  Parent: TWinControl);
begin
  inherited Create(ObjectModel);
  FParent := Parent;
  GViewIntegrators.Add(Self);
end;

{ TDiagramIntegrator }

procedure TDiagramIntegrator.SetPackage(const Value: TAbstractPackage);
begin
  FPackage := Value;
end;

// Creates storage space for the diagram
function TDiagramIntegrator.GetStorage(Create: Boolean): TMemIniFile;
var
  Filename: string;
begin
  Result := nil;
  if Assigned(FPackage) then
  begin
    Filename := FPackage.GetConfigFile;
    if Filename = '' then
      Filename := ChangeFileExt(Application.ExeName, ConfigFileExt);
    if FileExists(Filename) or Create then
      Result := TMemIniFile.Create(Filename);
  end;
end;

procedure TDiagramIntegrator.SetVisibilityFilter(const Value: TVisibility);
begin
  if FVisibilityFilter <> Value then
    FVisibilityFilter := Value;
end;

procedure TDiagramIntegrator.SetShowParameter(const Value: Integer);
begin
  if FShowParameter <> Value then
    FShowParameter := Value;
end;

procedure TDiagramIntegrator.SetSortOrder(const Value: Integer);
begin
  if FSortOrder <> Value then
    FSortOrder := Value;
end;

procedure TDiagramIntegrator.SetShowIcons(const Value: Integer);
begin
  if FShowIcons <> Value then
    FShowIcons := Value;
end;

procedure TDiagramIntegrator.SetShowObjectDiagram(const Value: Boolean);
begin
  if FShowObjectDiagram <> Value then
    FShowObjectDiagram := Value;
end;

procedure TDiagramIntegrator.SetFont(const Font: TFont);
begin
  FFont.Assign(Font);
end;

function TDiagramIntegrator.GetFont: TFont;
begin
  Result := FFont;
end;

procedure TDiagramIntegrator.SaveAsPicture(const Filename: string);
var
  Width, Height: Integer;

  procedure InToPng;
  var
    Bitmap: Graphics.TBitmap;
    Png: TPngImage;
  begin
    Bitmap := Graphics.TBitmap.Create;
    Png := TPngImage.Create;
    try
      try
        Bitmap.PixelFormat := pf8bit;
        Bitmap.Width := Width;
        Bitmap.Height := Height;
        PaintTo(Bitmap.Canvas, 0, 0, False);
        Png.Assign(Bitmap);
        Png.SaveToFile(Filename);
      finally
        FreeAndNil(Bitmap);
        FreeAndNil(Png);
      end;
    except
      on E: Exception do
        ErrorMsg(Format(_(SFileSaveError), [FileName, E.Message]));
    end;
  end;

  procedure InToSVG;
  begin
    var
    StringList := TStringList.Create;
    StringList.Text := GetSVG;
    StringList.SaveToFile(Filename, TEncoding.UTF8);
    FreeAndNil(StringList);
  end;

begin
  GetDiagramSize(Width, Height);
  if LowerCase(ExtractFileExt(Filename)) = '.svg' then
    InToSVG
  else
    InToPng;
end;

procedure TDiagramIntegrator.SetShowConnections(const Value: Integer);
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

// --------------------------------------

procedure TViewIntegrator.CurrentEntityChanged;
begin
  // stub
end;

destructor TViewIntegrator.Destroy;
begin
  GViewIntegrators.Remove(Self);
  inherited;
end;

function TViewIntegrator.GetCurrentEntity: TModelEntity;
begin
  Result := GCurrentEntity;
end;

procedure SetCurrentEntity(Value: TModelEntity);
begin
  if Value <> GCurrentEntity then
  begin
    GCurrentEntity := Value;
    for var I := 0 to GViewIntegrators.Count - 1 do
      (GViewIntegrators[I] as TViewIntegrator).CurrentEntityChanged;
  end;
end;

class procedure TViewIntegrator.SetCurrentEntity(const Value: TModelEntity);
begin
  UViewIntegrator.SetCurrentEntity(Value);
end;

constructor TDiagramIntegrator.Create(ObjectModel: TObjectModel;
  Parent: TWinControl);
begin
  inherited Create(ObjectModel, Parent);
  FFont := TFont.Create;
  FFont.Assign(GuiPyOptions.UMLFont);
  FVisibilityFilter := TVisibility(GuiPyOptions.DiVisibilityFilter);
  FSortOrder := GuiPyOptions.DiSortOrder;
  FShowParameter := GuiPyOptions.DiShowParameter;
  FShowIcons := GuiPyOptions.DiShowIcons;
end;

destructor TDiagramIntegrator.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

initialization

GViewIntegrators := TObjectList.Create(False);

finalization

FreeAndNil(GViewIntegrators);

end.
