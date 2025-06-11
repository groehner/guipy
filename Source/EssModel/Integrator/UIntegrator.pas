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

unit UIntegrator;

interface

uses
  Classes,
  Contnrs,
  UCodeProvider,
  UModel;

type
  {
    Baseclass for integrators
  }
  TIntegrator = class(TComponent)
  private
    FModel: TObjectModel;
  public
    constructor Create(ObjectModel: TObjectModel); reintroduce;
    destructor Destroy; override;
    // THE objectmodel
    property Model: TObjectModel read FModel;
  end;

  {
    Baseclass for an integrator where the model can be changed from the source and
    changes in the model can change the source.
  }
  TTwowayIntegrator = class(TIntegrator)
  public
    procedure InitFromModel; virtual;
    procedure BuildModelFrom(const Filename: string); virtual;
  end;

  {
    Baseclass for an integrator where the model is used to generate 'something'.
  }
  TExportIntegrator = class(TIntegrator)
  public
    procedure InitFromModel; virtual; abstract;
  end;

  {
    Baseclass for an integrator where 'something' (probably some source code) is
    used to generate a model.
  }
  TImportIntegrator = class(TIntegrator)
  private
    FCodeProvider: TCodeProvider;
  protected
    // List of files that have been read in this Lista importsession
    FFilesRead: TStringList;
    procedure ImportOneFile(const Filename: string;
      WithoutNeedSource: Boolean = False); virtual; abstract;
  public
    constructor Create(ObjectModel: TObjectModel; FCodeProvider: TCodeProvider);
      reintroduce;
    destructor Destroy; override;
    procedure BuildModelFrom(const Filename: string; ResetModel: Boolean = True;
      Lock: Boolean = True; WithoutNeedSource: Boolean = False); overload;
    procedure BuildModelFrom(FileNames: TStrings;
      WithoutNeedSource: Boolean = False); overload;
    procedure AddFileToModel(const Filename: string);
    procedure AddClasspath(Classpath: string; const Pathname: string);
    class function GetFileExtensions: TStringList; virtual; abstract;
    property CodeProvider: TCodeProvider read FCodeProvider write FCodeProvider;
  end;

  TIntegratorClass = class of TIntegrator;
  TImportIntegratorClass = class of TImportIntegrator;

  TIntegrators = class
  private
    FList: TClassList;
  public
    constructor Create;
    destructor Destroy; override;

    {
      Should be called by all integrator implementations to register it with
      the masterlist of integrators.
      eg. Integrators.Register( TEiffelIntegrator );
    }
    procedure Register(IntegratorClass: TIntegratorClass);

    // Retrieves a FList of available integrators of a given kind
    function Get(Kind: TIntegratorClass): TClassList;
  end;

  {
    Used to retrieve _the_ instance of TIntegrators.
  }
function Integrators: TIntegrators;

implementation

uses SysUtils, Dialogs;

var
  GIntegrators: TIntegrators = nil;

  { TIntegrator }

constructor TIntegrator.Create(ObjectModel: TObjectModel);
begin
  inherited Create(nil);
  FModel := ObjectModel;
end;

destructor TIntegrator.Destroy;
begin
  inherited;
  FModel := nil;
end;

{ TTwowayIntegrator }

procedure TTwowayIntegrator.BuildModelFrom(const Filename: string);
begin
  // Stub
end;

procedure TTwowayIntegrator.InitFromModel;
begin
  // Stub
end;

{ TImportIntegrator }

procedure TImportIntegrator.BuildModelFrom(const Filename: string;
  ResetModel: Boolean; Lock: Boolean; WithoutNeedSource: Boolean);
begin
  FCodeProvider.AddSearchPath(ExtractFilePath(Filename));
  if Lock then
    Model.Lock;

  if ResetModel then
  begin
    Model.Clear;
    Model.ModelRoot.SetConfigFile(Filename);
  end;

  FFilesRead.Add(Filename);
  try
    try
      if Assigned(Model) and Assigned(Model.ModelRoot) and
        (Model.ModelRoot.Files.IndexOf(Filename) = -1) then
        Model.ModelRoot.Files.Add(Filename);
      ImportOneFile(Filename, WithoutNeedSource);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    if Lock then
      Model.Unlock;
  end;
end;

procedure TImportIntegrator.BuildModelFrom(FileNames: TStrings;
  WithoutNeedSource: Boolean = False);
begin
  try
    Model.Lock;
    // Add all searchpaths first so the units can find eachother.
    for var I := 0 to FileNames.Count - 1 do
      FCodeProvider.AddSearchPath(ExtractFilePath(FileNames[I]));
    Model.Clear;
    Model.ModelRoot.SetConfigFile(FileNames[0]);
    for var I := 0 to FileNames.Count - 1 do
      BuildModelFrom(FileNames[I], False, True, WithoutNeedSource);
  finally
    Model.Unlock;
  end;
end;

procedure TImportIntegrator.AddFileToModel(const Filename: string);
begin
  BuildModelFrom(Filename, False, False, True);
end;

procedure TImportIntegrator.AddClasspath(Classpath: string;
  const Pathname: string);
var
  Posi: Integer;
  Str: string;
begin
  Classpath := Classpath + ';';
  repeat
    Posi := Pos(';', Classpath);
    Str := Copy(Classpath, 1, Posi - 1);
    Delete(Classpath, 1, Posi);
    if Str = '.' then
      Str := ExtractFilePath(Pathname);
    if DirectoryExists(Str) then
      FCodeProvider.AddSearchPath(Str);
  until Classpath = '';
end;

constructor TImportIntegrator.Create(ObjectModel: TObjectModel;
  FCodeProvider: TCodeProvider);
begin
  inherited Create(ObjectModel);
  Self.FCodeProvider := FCodeProvider;
  FFilesRead := TStringList.Create;
  FFilesRead.Sorted := True;
  FFilesRead.Duplicates := dupIgnore;
end;

destructor TImportIntegrator.Destroy;
begin
  FreeAndNil(FCodeProvider);
  FreeAndNil(FFilesRead);
  inherited;
end;

{ TIntegrators }

constructor TIntegrators.Create;
begin
  FList := TClassList.Create;
end;

destructor TIntegrators.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TIntegrators.Get(Kind: TIntegratorClass): TClassList;
begin
  Result := TClassList.Create;
  for var I := 0 to FList.Count - 1 do
    if FList[I].InheritsFrom(Kind) then
      Result.Add(FList[I]);
end;

procedure TIntegrators.Register(IntegratorClass: TIntegratorClass);
begin
  FList.Add(IntegratorClass);
end;

function Integrators: TIntegrators;
begin
  if not Assigned(GIntegrators) then
    GIntegrators := TIntegrators.Create;
  Result := GIntegrators;
end;

initialization

finalization

FreeAndNil(GIntegrators);

end.
