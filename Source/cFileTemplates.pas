{-----------------------------------------------------------------------------
 Unit Name: cFileTemplates
 Author:    Kiriakos Vlahos
 Date:      08-Aug-2006
 Purpose:   Data Structures for File Templates
 History:
-----------------------------------------------------------------------------}

unit cFileTemplates;

interface

Uses
  Classes, SysUtils, Contnrs, JvAppStorage;

Type

  TFileTemplate = class(TInterfacedPersistent, IJvAppStorageHandler)
  protected
    // IJvAppStorageHandler implementation
    procedure ReadFromAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
    procedure WriteToAppStorage(AppStorage: TJvCustomAppStorage; const BasePath: string);
  public
    Name: string;
    Template: string;
    Extension: string;
    Category: string;
    Highlighter : string;
    procedure Assign(Source: TPersistent); override;
  end;

  TFileTemplates = class(TObjectList)
    function CreateListItem(Sender: TJvCustomAppStorage; const Path: string;
      Index: Integer): TPersistent;
    procedure AddPythonTemplate;
    procedure AddCythonTemplate;
    procedure AddHTMLTemplate;
    procedure AddCSSTemplate;
    procedure AddXMLTemplate;
    procedure AddJSONTemplate;
    procedure AddYAMLTemplate;
    procedure AddJSTemplate;
    procedure AddJupyterTemplate;
    procedure AddPHPTemplate;
    procedure AddPlainTextTemplate;
    procedure AddTkinterTemplate;
    procedure Assign(Source: TFileTemplates);
    function TemplateByName(const Name : string) : TFileTemplate;
    function TemplateByExt(const Ext : string) : TFileTemplate;
    procedure AddDefaultTemplates(NoCheck: Boolean= False);
  end;

var
  FileTemplates : TFileTemplates;

implementation

uses StringResources, JvGnugettext;

{ TFileTemplate }

procedure TFileTemplate.Assign(Source: TPersistent);
begin
  if Source is TFileTemplate then begin
    Name := TFileTemplate(Source).Name;
    Template := TFileTemplate(Source).Template;
    Extension := TFileTemplate(Source).Extension;
    Category := TFileTemplate(Source).Category;
    Highlighter := TFileTemplate(Source).Highlighter;
  end else
    inherited;
end;

procedure TFileTemplate.ReadFromAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
Var
  SL : TStringList;
begin
  Name := AppStorage.ReadString(BasePath+'\Name', '');
  Highlighter := AppStorage.ReadString(BasePath+'\Highlighter', '');
  Extension := AppStorage.ReadString(BasePath+'\Extension', '');
  Category := AppStorage.ReadString(BasePath+'\Category', '');
  SL := TStringList.Create;
  try
    AppStorage.ReadStringList(BasePath+'\Template', SL);
    Template := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TFileTemplate.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
Var
  SL : TStringList;
begin
  AppStorage.WriteString(BasePath+'\Name', Name);
  AppStorage.WriteString(BasePath+'\Highlighter', Highlighter);
  AppStorage.WriteString(BasePath+'\Extension', Extension);
  AppStorage.WriteString(BasePath+'\Category', Category);
  SL := TStringList.Create;
  try
    SL.Text := Template;
    AppStorage.WriteStringList(BasePath+'\Template', SL);
  finally
    SL.Free;
  end;
end;

{ TFileTemplates }

procedure TFileTemplates.AddCSSTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SCSSFileTemplateName;
  FileTemplate.Extension := 'css';
  FileTemplate.Category := SFileTemplateCategoryInternet;
  FileTemplate.Highlighter := 'CSS';
  FileTemplate.Template := SCSSFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddCythonTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SCythonTemplateName;
  FileTemplate.Extension := 'pyx';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Cython';
  FileTemplate.Template := SPythonFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddDefaultTemplates(NoCheck: Boolean);
begin
   if NoCheck or not Assigned(TemplateByExt('py')) then AddPythonTemplate;
   if NoCheck or not Assigned(TemplateByExt('pyw')) then AddTkinterTemplate;
   if NoCheck or not Assigned(TemplateByExt('pyx')) then AddCythonTemplate;
   if NoCheck or not Assigned(TemplateByExt('htm')) then AddHTMLTemplate;
   if NoCheck or not Assigned(TemplateByExt('xml')) then AddXMLTemplate;
   if NoCheck or not Assigned(TemplateByExt('json')) then AddJSONTemplate;
   if NoCheck or not Assigned(TemplateByExt('yaml')) then AddYAMLTemplate;
   if NoCheck or not Assigned(TemplateByExt('css')) then AddCSSTemplate;
   if NoCheck or not Assigned(TemplateByExt('js')) then AddJSTemplate;
   if NoCheck or not Assigned(TemplateByExt('php')) then AddPHPTemplate;
   if NoCheck or not Assigned(TemplateByExt('ipynb')) then AddJupyterTemplate;
   if NoCheck or not Assigned(TemplateByExt('txt')) then AddPlainTextTemplate;
end;

procedure TFileTemplates.AddHTMLTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SHTMLFileTemplateName;
  FileTemplate.Extension := 'htm';
  FileTemplate.Category := SFileTemplateCategoryInternet;
  FileTemplate.Highlighter := 'HTML';
  FileTemplate.Template := SHTMLFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddJSTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SJSTemplateName;
  FileTemplate.Extension := 'js';
  FileTemplate.Category := SFileTemplateCategoryOther;
  FileTemplate.Highlighter := 'JavaScript';
  FileTemplate.Template := '';
  Add(FileTemplate);
end;

procedure TFileTemplates.AddJupyterTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SJupyterTemplateName;
  FileTemplate.Extension := 'ipynb';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'JSON';
  FileTemplate.Template := SJupyterFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddPHPTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SPHPTemplateName;
  FileTemplate.Extension := 'php';
  FileTemplate.Category := SFileTemplateCategoryOther;
  FileTemplate.Highlighter := 'PHP';
  FileTemplate.Template := '';
  Add(FileTemplate);
end;

procedure TFileTemplates.AddPlainTextTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := STextFileTemplateName;
  FileTemplate.Extension := 'txt';
  FileTemplate.Category := SFileTemplateCategoryOther;
  FileTemplate.Highlighter := 'General';
  FileTemplate.Template := '';
  Add(FileTemplate);
end;

procedure TFileTemplates.AddPythonTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SPythonTemplateName;
  FileTemplate.Extension := 'py';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Python';
  FileTemplate.Template := SPythonFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddTkinterTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := STkinterTemplateName;
  FileTemplate.Extension := 'pyw';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Python';
  FileTemplate.Template := STkinterFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddXMLTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SXMLTemplateName;
  FileTemplate.Extension := 'xml';
  FileTemplate.Category := SFileTemplateCategoryInternet;
  FileTemplate.Highlighter := 'XML';
  FileTemplate.Template := SXMLFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddJSONTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SJSONTemplateName;
  FileTemplate.Extension := 'json';
  FileTemplate.Category := SFileTemplateCategoryOther;
  FileTemplate.Highlighter := 'JSON';
  FileTemplate.Template := SJSONFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddYAMLTemplate;
Var
  FileTemplate : TFileTemplate;
begin
  FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SYAMLTemplateName;
  FileTemplate.Extension := 'yaml';
  FileTemplate.Category := SFileTemplateCategoryOther;
  FileTemplate.Highlighter := 'YAML';
  FileTemplate.Template := SYAMLFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.Assign(Source: TFileTemplates);
var
  i : Integer;
  FileTemplate: TFileTemplate;
begin
  Clear;
  for i := 0 to Source.Count - 1 do begin
    FileTemplate := TFileTemplate.Create;
    FileTemplate.Assign(Source[i] as TFileTemplate);
    Add(FileTemplate)
  end;
end;

function TFileTemplates.CreateListItem(Sender: TJvCustomAppStorage;
  const Path: string; Index: Integer): TPersistent;
begin
  Result := TFileTemplate.Create;
end;

function TFileTemplates.TemplateByExt(const Ext: string): TFileTemplate;
var
  i: Integer;
begin
 Result := nil;
 for i := 0 to Count - 1 do
   if TFileTemplate(Items[i]).Extension = Ext then begin
     Result := TFileTemplate(Items[i]);
     break;
   end;
end;

function TFileTemplates.TemplateByName(const Name: string): TFileTemplate;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    var s:= TFileTemplate(Items[i]).Name;
    if s = Name then begin
      Result := TFileTemplate(Items[i]);
      break;
    end;
  end;
end;

initialization
  FileTemplates := TFileTemplates.Create(True);
  FileTemplates.AddDefaultTemplates(True);
finalization
  FileTemplates.Free;
end.
