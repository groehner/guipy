{-----------------------------------------------------------------------------
 Unit Name: cFileTemplates
 Author:    Kiriakos Vlahos, Gerhard Röhner
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
    procedure AddTkinterTemplate;
    procedure AddQtTemplate;
    procedure AddClassTemplate;
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
    procedure Assign(Source: TFileTemplates);
    function TemplateByName(const Name : string) : TFileTemplate;
    function TemplateByExt(const Ext : string) : TFileTemplate;
    procedure AddDefaultTemplates(NoCheck: Boolean= False);
    function getDefaultByName(Templatename: string): TFileTemplate;
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
begin
  Name := AppStorage.ReadString(BasePath+'\Name', '');
  Highlighter := AppStorage.ReadString(BasePath+'\Highlighter', '');
  Extension := AppStorage.ReadString(BasePath+'\Extension', '');
  Category := AppStorage.ReadString(BasePath+'\Category', '');
  var SL := TStringList.Create;
  try
    AppStorage.ReadStringList(BasePath+'\Template', SL);
    Template := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TFileTemplate.WriteToAppStorage(AppStorage: TJvCustomAppStorage;
  const BasePath: string);
begin
  AppStorage.WriteString(BasePath+'\Name', Name);
  AppStorage.WriteString(BasePath+'\Highlighter', Highlighter);
  AppStorage.WriteString(BasePath+'\Extension', Extension);
  AppStorage.WriteString(BasePath+'\Category', Category);
  var SL := TStringList.Create;
  try
    SL.Text := Template;
    AppStorage.WriteStringList(BasePath+'\Template', SL);
  finally
    SL.Free;
  end;
end;

{ TFileTemplates }

procedure TFileTemplates.AddDefaultTemplates(NoCheck: Boolean);
begin
  if NoCheck or not Assigned(TemplateByExt('py')) then AddPythonTemplate;
  if NoCheck or not Assigned(TemplateByExt('pyw')) then AddTkinterTemplate;
  if NoCheck or not Assigned(TemplateByName(SQtTemplateName)) then AddQtTemplate;
  if NoCheck or not Assigned(TemplateByName(SClassTemplateName)) then AddClassTemplate;
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

function TFileTemplates.getDefaultByName(Templatename: string): TFileTemplate;
  var found: boolean;
begin
  found:= true;
  if Templatename = SPythonTemplateName then
    AddPythonTemplate
  else if Templatename = STkinterTemplateName then
    AddTkinterTemplate
  else if Templatename = SQtTemplateName then
    AddQtTemplate
  else if Templatename = SClassTemplateName then
    AddClassTemplate
  else if Templatename = SCythonTemplateName then
    AddCythonTemplate
  else if Templatename = SCSSFileTemplateName then
    AddCSSTemplate
  else if Templatename = SHTMLFileTemplateName then
    AddHTMLTemplate
  else if Templatename = STextFileTemplateName then
    AddPlainTextTemplate
  else if Templatename = SXMLTemplateName then
    AddHTMLTemplate
  else if Templatename = SJSONTemplateName then
    AddJSONTemplate
  else if Templatename = SYAMLTemplateName then
    AddYAMLTemplate
  else if Templatename = SJSTemplateName then
    AddJSTemplate
  else if Templatename = SPHPTemplateName then
    AddPHPTemplate
  else if Templatename = SJupyterTemplateName then
    AddJupyterTemplate
  else
    found:= false;
  if found
    then Result:= TFileTemplate(FileTemplates.Extract(FileTemplates.Last))
    else Result:= nil;
end;

procedure TFileTemplates.AddPythonTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SPythonTemplateName;
  FileTemplate.Extension := 'py';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Python';
  FileTemplate.Template := SPythonFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddTkinterTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := STkinterTemplateName;
  FileTemplate.Extension := 'pyw';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Python';
  FileTemplate.Template := STkinterFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddQtTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SQtTemplateName;
  FileTemplate.Extension := 'pyw';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Python';
  FileTemplate.Template := SQtFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddClassTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SClassTemplateName;
  FileTemplate.Extension := 'py';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Python';
  FileTemplate.Template := SClassFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddCythonTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SCythonTemplateName;
  FileTemplate.Extension := 'pyx';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'Cython';
  FileTemplate.Template := SPythonFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddHTMLTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SHTMLFileTemplateName;
  FileTemplate.Extension := 'htm';
  FileTemplate.Category := _(SFileTemplateCategoryInternet);
  FileTemplate.Highlighter := 'HTML';
  FileTemplate.Template := SHTMLFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddXMLTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SXMLTemplateName;
  FileTemplate.Extension := 'xml';
  FileTemplate.Category := _(SFileTemplateCategoryInternet);
  FileTemplate.Highlighter := 'XML';
  FileTemplate.Template := SXMLFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddJSONTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SJSONTemplateName;
  FileTemplate.Extension := 'json';
  FileTemplate.Category := _(SFileTemplateCategoryOther);
  FileTemplate.Highlighter := 'JSON';
  FileTemplate.Template := SJSONFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddYAMLTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SYAMLTemplateName;
  FileTemplate.Extension := 'yaml';
  FileTemplate.Category := _(SFileTemplateCategoryOther);
  FileTemplate.Highlighter := 'YAML';
  FileTemplate.Template := SYAMLFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddCSSTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SCSSFileTemplateName;
  FileTemplate.Extension := 'css';
  FileTemplate.Category := _(SFileTemplateCategoryInternet);
  FileTemplate.Highlighter := 'CSS';
  FileTemplate.Template := SCSSFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddJSTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SJSTemplateName;
  FileTemplate.Extension := 'js';
  FileTemplate.Category := _(SFileTemplateCategoryOther);
  FileTemplate.Highlighter := 'JavaScript';
  FileTemplate.Template := '';
  Add(FileTemplate);
end;

procedure TFileTemplates.AddPHPTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SPHPTemplateName;
  FileTemplate.Extension := 'php';
  FileTemplate.Category := _(SFileTemplateCategoryOther);
  FileTemplate.Highlighter := 'PHP';
  FileTemplate.Template := '';
  Add(FileTemplate);
end;

procedure TFileTemplates.AddJupyterTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := SJupyterTemplateName;
  FileTemplate.Extension := 'ipynb';
  FileTemplate.Category := 'Python';
  FileTemplate.Highlighter := 'JSON';
  FileTemplate.Template := SJupyterFileTemplate;
  Add(FileTemplate);
end;

procedure TFileTemplates.AddPlainTextTemplate;
begin
  var FileTemplate := TFileTemplate.Create;
  FileTemplate.Name := STextFileTemplateName;
  FileTemplate.Extension := 'txt';
  FileTemplate.Category := _(SFileTemplateCategoryOther);
  FileTemplate.Highlighter := 'General';
  FileTemplate.Template := '';
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
 for i := 0 to Count - 1 do
   if TFileTemplate(Items[i]).Name = Name then begin
     Result := TFileTemplate(Items[i]);
     break;
   end;
end;

initialization
  FileTemplates := TFileTemplates.Create(True);
  FileTemplates.AddDefaultTemplates(True);

finalization
  FileTemplates.Free;
end.
