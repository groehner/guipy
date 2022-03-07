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

uses Classes, Contnrs, uCodeProvider, uModel;

type
  {
    Baseclass for integrators
  }
  TIntegrator = class(TComponent)
  private
    FModel: TObjectModel;
  public
    constructor Create(om: TObjectModel); reintroduce;
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
    procedure BuildModelFrom(const FileName : string); virtual;
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
  protected

    // List of files that have been read in this Lista importsession
    FilesRead : TStringList;

    procedure ImportOneFile(const FileName: string; withoutNeedSource: boolean = false); virtual; abstract;
  public
    CodeProvider: TCodeProvider;
    constructor Create(om: TObjectModel; aCodeProvider: TCodeProvider); reintroduce;
    destructor Destroy; override;
    procedure BuildModelFrom(const FileName : string; ResetModel : boolean = True; Lock : boolean = true; withoutNeedSource: boolean = false); overload;
    procedure BuildModelFrom(FileNames : TStrings; withoutNeedSource: boolean = false); overload;
    procedure AddFileToModel(const Filename: String);
    procedure AddClasspath(Classpath: string; const Pathname: String);
    class function GetFileExtensions : TStringList; virtual; abstract;
  end;

  TIntegratorClass = class of TIntegrator;
  TImportIntegratorClass = class of TImportIntegrator;

  TIntegrators = class
  private
    List : TClassList;
  public
    constructor Create;
    destructor Destroy; override;

    {
     Should be called by all integrator implementations to register it with
     the masterlist of integrators.
     eg. Integrators.Register( TEiffelIntegrator );
    }
    procedure Register(T: TIntegratorClass);

    // Retrieves a list of available integrators of a given kind
    function Get(Kind : TIntegratorClass) : TClassList;
  end;

{
  Used to retrieve _the_ instance of TIntegrators.
}
function Integrators : TIntegrators;

implementation

uses SysUtils, Dialogs;

var
  _Integrators : TIntegrators = nil;

{ TIntegrator }

constructor TIntegrator.Create(om: TObjectModel);
begin
  inherited Create(nil);
  FModel := om;
end;

destructor TIntegrator.Destroy;
begin
  inherited;
  FModel := nil;
end;

{ TTwowayIntegrator }

procedure TTwowayIntegrator.BuildModelFrom(const FileName : string);
begin
//Stub
end;

procedure TTwowayIntegrator.InitFromModel;
begin
//Stub
end;

{ TImportIntegrator }

procedure TImportIntegrator.BuildModelFrom(const FileName: string; ResetModel: boolean; Lock: boolean; withoutNeedSource: boolean);
begin
  CodeProvider.AddSearchPath(ExtractFilePath(FileName));
  if Lock then
    Model.Lock;

  if ResetModel then begin
    Model.Clear;
    Model.ModelRoot.SetConfigFile(FileName);
  end;

  FilesRead.Add(FileName);
  try
    try
      if assigned(Model) and assigned(Model.ModelRoot) and
        (Model.ModelRoot.Files.IndexOf(Filename) = -1) then
        Model.ModelRoot.Files.Add(Filename);
      ImportOneFile(FileName, withoutNeedSource);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    if Lock then
      Model.Unlock;
  end;
end;

procedure TImportIntegrator.BuildModelFrom(FileNames: TStrings; withoutNeedSource: boolean = false);
  var i: integer;
begin
  try
    Model.Lock;
    // Add all searchpaths first so the units can find eachother.
    for i:= 0 to FileNames.Count-1 do
      CodeProvider.AddSearchPath(ExtractFilePath(FileNames[I]));
    Model.Clear;
    Model.ModelRoot.SetConfigFile(FileNames[0]);
    for i:= 0 to FileNames.Count - 1 do
      BuildModelFrom(FileNames[i], false, true, withoutNeedSource);
  finally
     Model.UnLock;
  end;
end;

procedure TImportIntegrator.AddFileToModel(const Filename: String);
begin
  BuildModelFrom(FileName, false, false, true);
end;

procedure TImportIntegrator.AddClasspath(Classpath: string; const Pathname: String);
  var p: integer; s: string;
begin
  Classpath:= Classpath + ';';
  repeat
    p:= Pos(';', Classpath);
    s:= copy(Classpath, 1, p-1);
    delete(Classpath, 1, p);
    if s = '.' then s:= ExtractFilepath(Pathname);
    if DirectoryExists(s) then
      Codeprovider.AddSearchPath(s);
  until Classpath = '';
end;

constructor TImportIntegrator.Create(om: TObjectModel; aCodeProvider: TCodeProvider);
begin
  inherited Create(Om);
  Self.CodeProvider := aCodeProvider;
  FilesRead := TStringList.Create;
  FilesRead.Sorted := True;
  FilesRead.Duplicates := dupIgnore;
end;

destructor TImportIntegrator.Destroy;
begin
  FreeAndNil(CodeProvider);
  FreeAndNil(FilesRead);
  inherited;
end;

{ TIntegrators }

constructor TIntegrators.Create;
begin
  List := TClassList.Create;
end;

destructor TIntegrators.Destroy;
begin
  FreeAndNil(List);
end;

function TIntegrators.Get(Kind: TIntegratorClass): TClassList;
var
  I : integer;
begin
  Result := TClassList.Create;
  for I := 0 to List.Count - 1 do
    if List[I].InheritsFrom(Kind) then
      Result.Add(List[I]);
end;

procedure TIntegrators.Register(T: TIntegratorClass);
begin
  List.Add(T);
end;

function Integrators : TIntegrators;
begin
  if _Integrators = nil then
    _Integrators := TIntegrators.Create;
  Result := _Integrators;
end;

initialization

finalization
   FreeAndNil(_Integrators);

end.

