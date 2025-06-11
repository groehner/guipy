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

unit UUMLModule;

interface

uses
  Dialogs,
  Classes,
  ExtCtrls,
  UModel,
  UViewIntegrator;

type
  TDMUMLModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure CopyDiagramClipboardActionExecute(Sender: TObject);
    procedure FileOpenActionExecute(Sender: TObject);
    procedure SaveDiagramActionExecute(Sender: TObject);
    function OpenFolderActionExecute(Sender: TObject): Boolean;
  private
    FModel: TObjectModel;
    FDiagram: TDiagramIntegrator;
    // TRtfdDiagram is descendent of TDiagramIntegrator
    FSD: TSaveDialog;
    FOD: TOpenDialog;
    FOpendFolder: string;
  public
    constructor Create(AOwner: TComponent; Panel: TPanel); reintroduce;
    procedure LoadProject(FileNames: TStrings); overload;
    procedure LoadProject(const FileName: string); overload;
    procedure AddToProject(const FileName: string); overload;
    procedure AddToProject(FileNames: TStrings); overload;
    procedure ShowAllOpenedFiles;
    procedure SaveUML(const Pathname: string);
    procedure LoadUML(const Pathname: string);
    function GetUMLFilename: string;
    procedure InitShowParameter(I: Integer);
    procedure SetShowIcons(I: Integer);
    procedure RefreshDiagram;
    procedure DoLayout;
    procedure EditSelectedElement;
    procedure UnSelectAllElements;
    procedure SelectAssociation;
    procedure Print;
    function GetFiles: TStringList;

    property Diagram: TDiagramIntegrator read FDiagram;
    property Model: TObjectModel read FModel;
    property OpendFolder: string read FOpendFolder;
  end;

implementation

uses Windows,
  SysUtils,
  Graphics,
  Controls,
  Forms,
  Clipbrd,
  Printers,
  Contnrs,
  UIntegrator,
  UFileProvider,
  uEditAppIntfs,
  JvGnugettext,
  UOpenFolderForm,
  UUtils,
  URtfdDiagram;

{$R *.DFM}

constructor TDMUMLModule.Create(AOwner: TComponent; Panel: TPanel);
begin
  inherited Create(AOwner);
  FSD := nil;
  FOD := nil;
  FModel := TObjectModel.Create;
  FDiagram := TRtfdDiagram.Create(FModel, Panel);
end;

procedure TDMUMLModule.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FDiagram);
  FreeAndNil(FModel);
end;

procedure TDMUMLModule.LoadProject(FileNames: TStrings);
var
  Ext: string;
  Imp: TImportIntegrator;
  Ints: TClassList;
  Exts: TStringList;
  JIdx: Integer;
  SikCursor: TCursor;
  OtherFiles: TStringList;
begin
  // Examine fileextension and call the correct integrator
  SikCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Ext := '';
  for var I := 0 to FileNames.Count - 1 do
    if LowerCase(ExtractFileExt(FileNames[I])) = '.py' then
      Ext := '.py';
  if (Ext = '') and (FileNames.Count > 0) then
    Ext := LowerCase(ExtractFileExt(FileNames[0]));

  Imp := nil;
  Ints := Integrators.Get(TImportIntegrator);
  OtherFiles := TStringList.Create;
  try
    for var I := 0 to Ints.Count - 1 do
    begin
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        if Exts.IndexOfName(Ext) > -1 then
        begin
          Imp := TImportIntegratorClass(Ints[I])
            .Create(Model, TFileProvider.Create);
          JIdx := 0;
          while JIdx < FileNames.Count do
            if Exts.IndexOfName(LowerCase(ExtractFileExt(FileNames[JIdx]))) = -1
            then
            begin
              OtherFiles.Add(FileNames[JIdx]);
              FileNames.Delete(JIdx);
            end
            else
              Inc(JIdx);
          Break;
        end;
      finally
        FreeAndNil(Exts);
      end;
    end;
    if Assigned(Imp) then
      try
        Imp.BuildModelFrom(FileNames);
      finally
        FreeAndNil(Imp);
      end;
    AddToProject(OtherFiles);
  finally
    FreeAndNil(Ints);
    FreeAndNil(OtherFiles);
    Screen.Cursor := SikCursor;
  end;
end;

procedure TDMUMLModule.LoadProject(const FileName: string);
var
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  StringList.Add(FileName);
  LoadProject(StringList);
  FreeAndNil(StringList);
end;

procedure TDMUMLModule.AddToProject(const FileName: string);
var
  Ext: string;
  Imp: TImportIntegrator;
  Ints: TClassList;
  Exts: TStringList;
begin
  try
    if Assigned(FModel) and Assigned(FModel.ModelRoot) and
      Assigned(FModel.ModelRoot.Files) and (FModel.ModelRoot.Files.Text = '')
    then
    begin
      LoadProject(FileName);
      FDiagram.ResolveAssociations;
      FDiagram.ResolveObjectAssociations;
      Exit;
    end;
  except
    on E: Exception do
      ErrorMsg('TDMUMLModule.AddToProject ');
  end;
  Ext := LowerCase(ExtractFileExt(FileName));
  Imp := nil;
  Ints := Integrators.Get(TImportIntegrator);
  try
    for var I := 0 to Ints.Count - 1 do
    begin
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        if Exts.IndexOfName(Ext) > -1 then
          Imp := TImportIntegratorClass(Ints[I])
            .Create(Model, TFileProvider.Create);
      finally
        FreeAndNil(Exts);
      end;
    end;

    if Assigned(Imp) then
      try
        Imp.AddFileToModel(FileName);
        FDiagram.ResolveAssociations;
        FDiagram.ResolveObjectAssociations;
      finally
        FreeAndNil(Imp);
      end;
  finally
    FreeAndNil(Ints);
  end;
end;

procedure TDMUMLModule.AddToProject(FileNames: TStrings);
begin
  for var I := 0 to FileNames.Count - 1 do
    AddToProject(FileNames[I]);
end;

procedure TDMUMLModule.CopyDiagramClipboardActionExecute(Sender: TObject);
var
  Selected: Boolean;
  Bmp1, Bmp2: Graphics.TBitmap;
  Width, Height: Integer;
  SelRect: TRect;
begin
  SelRect := Diagram.GetSelectedRect;
  Selected := (SelRect.Right > SelRect.Left);
  Diagram.GetDiagramSize(Width, Height);
  try
    Bmp1 := Graphics.TBitmap.Create;
    Bmp1.Width := Width;
    Bmp1.Height := Height;
    Bmp1.Canvas.Lock;
    Diagram.PaintTo(Bmp1.Canvas, 0, 0, True);

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
end;

procedure TDMUMLModule.FileOpenActionExecute(Sender: TObject);
var
  Ints: TClassList;
  Exts: TStringList;
  AnyFilter, Filter: string;
begin
  Filter := '';
  Ints := Integrators.Get(TImportIntegrator);
  try
    for var I := 0 to Ints.Count - 1 do
    begin
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        for var J := 0 to Exts.Count - 1 do
        begin
          if Filter <> '' then
            Filter := Filter + '|';
          Filter := Filter + Exts.Values[Exts.Names[J]] + ' (*' + Exts.Names[J]
            + ')|*' + Exts.Names[J];
          if AnyFilter <> '' then
            AnyFilter := AnyFilter + ';';
          AnyFilter := AnyFilter + '*' + Exts.Names[J];
        end;
      finally
        FreeAndNil(Exts);
      end;
    end;
  finally
    FreeAndNil(Ints);
  end;

  Filter := 'All types (' + AnyFilter + ')|' + AnyFilter + '|' + Filter;

  if not Assigned(FOD) then
  begin
    FOD := TOpenDialog.Create(Self);
    FOD.Filter := Filter;
    FOD.Options := FOD.Options + [ofAllowMultiSelect];
  end;
  if FOD.Execute then
    LoadProject(FOD.Files);
end;

procedure TDMUMLModule.SaveDiagramActionExecute(Sender: TObject);
begin
  if not Assigned(FSD) then
  begin
    FSD := TSaveDialog.Create(Self);
    FSD.InitialDir := ExtractFilePath(Model.ModelRoot.GetConfigFile);
    FSD.Filter :=
      'SVG files (*.svg)|*.svg|PNG files (*.png)|*.png|All files (*.*)|*.*';
    FSD.Options := FSD.Options + [ofOverwritePrompt];
  end;
  if FSD.Execute then
  begin
    if ExtractFileExt(FSD.FileName) = '' then
    begin
      if FSD.FilterIndex = 2 then
        FSD.FileName := ChangeFileExt(FSD.FileName, '.png')
      else
        FSD.FileName := ChangeFileExt(FSD.FileName, '.svg');
    end;
    Diagram.SaveAsPicture(FSD.FileName);
  end;
end;

procedure TDMUMLModule.ShowAllOpenedFiles;
var
  Files: TStringList;
begin
  Files := TStringList.Create;
  for var I := 0 to GI_EditorFactory.Count - 1 do
    if GI_EditorFactory[I].HasPythonFile then
      Files.Add(GI_EditorFactory[I].FileName);
  LoadProject(Files);
  FreeAndNil(Files);
end;

procedure TDMUMLModule.SaveUML(const Pathname: string);
begin
  Diagram.StoreDiagram(Pathname);
end;

procedure TDMUMLModule.LoadUML(const Pathname: string);
begin
  Diagram.FetchDiagram(Pathname);
end;

function TDMUMLModule.GetUMLFilename: string;
begin
  if Assigned(Diagram.Package) then
    Result := Diagram.Package.GetConfigFile
  else
    Result := '';
end;

procedure TDMUMLModule.InitShowParameter(I: Integer);
begin
  Diagram.InitShowParameter(I);
end;

procedure TDMUMLModule.SetShowIcons(I: Integer);
begin
  Diagram.ShowIcons := I;
end;

function TDMUMLModule.OpenFolderActionExecute(Sender: TObject): Boolean;

  procedure AddFileNames(Files: TStringList; const Path, Ext: string;
    Rekursiv: Boolean);
  var
    SearchRec: TSearchRec;
  begin
    if FindFirst(Path + '\*.*', faReadOnly or faDirectory, SearchRec) = 0 then
    begin
      repeat
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          if ((SearchRec.Attr and faDirectory) = faDirectory) and Rekursiv then
            AddFileNames(Files, Path + '\' + SearchRec.Name, Ext, Rekursiv)
          else if CompareText(ExtractFileExt(SearchRec.Name), Ext) = 0 then
            Files.Add(Path + '\' + SearchRec.Name);
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
  end;

begin
  Result := False;
  var
  StringList := TStringList.Create;
  var
  Ints := Integrators.Get(TImportIntegrator);
  var
  OpenFolderForm := TFOpenFolderForm.Create(nil);
  try
    for var I := 0 to Ints.Count - 1 do
    begin
      var
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        OpenFolderForm.CBFiletype.Items.Add('*' + Exts.Names[0]);
      finally
        FreeAndNil(Exts);
      end;
    end;
    OpenFolderForm.CBFiletype.ItemIndex := 0;
    if OpenFolderForm.ShowModal = mrOk then
    begin
      Result := True;
      AddFileNames(StringList, OpenFolderForm.PathTreeView.Path,
        Copy(OpenFolderForm.CBFiletype.Items
        [OpenFolderForm.CBFiletype.ItemIndex], 2, 10),
        OpenFolderForm.CBWithSubFolder.Checked);
      if StringList.Count > 0 then
        LoadProject(StringList)
      else
        ShowMessage(_('No files found.'));
      FOpendFolder := OpenFolderForm.PathTreeView.Path;
    end
    else
      FOpendFolder := '';
  finally
    FreeAndNil(StringList);
    FreeAndNil(Ints);
    OpenFolderForm.Release;
  end;
end;

procedure TDMUMLModule.RefreshDiagram;
begin
  Diagram.RefreshDiagram;
end;

procedure TDMUMLModule.DoLayout;
begin
  Diagram.DoLayout;
end;

procedure TDMUMLModule.SelectAssociation;
begin
  Diagram.SelectAssociation;
end;

procedure TDMUMLModule.EditSelectedElement;
begin
  Diagram.ClassEditSelectedDiagramElements;
end;

procedure TDMUMLModule.UnSelectAllElements;
begin
  Diagram.UnSelectAllElements;
end;

procedure TDMUMLModule.Print;
var
  DBx, DBy: Integer;
  FormImage: TBitmap;
  Info: PBitmapInfo;
  InfoSize: DWORD;
  Image: Pointer;
  ImageSize: DWORD;
  Bits: HBITMAP;
  DIBWidth, DIBHeight: LongInt;
  PrintWidth, PrintHeight: LongInt;
  Canvas: TCanvas;

begin
  FormImage := TBitmap.Create;
  Diagram.GetDiagramSize(DBx, DBy);
  FormImage.Width := DBx - 1;
  FormImage.Height := DBy - 1;

  try
    Canvas := FormImage.Canvas;
    Canvas.Lock;
    Diagram.PaintTo(FormImage.Canvas, 0, 0, False);

    // Print aus der Forms-Unit
    Printer.BeginDoc;
    try
      // Paint bitmap to the printer
      with Printer do
      begin
        Bits := FormImage.Handle;
        GetDIBSizes(Bits, InfoSize, ImageSize);
        Info := AllocMem(InfoSize);
        try
          Image := AllocMem(ImageSize);
          try
            GetDIB(Bits, 0, Info^, Image^);
            with Info^.bmiHeader do
            begin
              DIBWidth := biWidth;
              DIBHeight := biHeight;
            end;
            PrintWidth := MulDiv(DIBWidth, GetDeviceCaps(Handle, LOGPIXELSX),
              Screen.PixelsPerInch);
            PrintHeight := MulDiv(DIBHeight, GetDeviceCaps(Handle, LOGPIXELSY),
              Screen.PixelsPerInch);
            StretchDIBits(Canvas.Handle, 0, 0, PrintWidth, PrintHeight, 0, 0,
              DIBWidth, DIBHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
          finally
            FreeMem(Image, ImageSize);
          end;
        finally
          FreeMem(Info, InfoSize);
        end;
      end;
    finally
      Canvas.Unlock;
      FreeAndNil(FormImage);
    end;
  finally
    Printer.EndDoc;
  end;
end;

function TDMUMLModule.GetFiles: TStringList;
begin
  if Assigned(FModel) and Assigned(FModel.ModelRoot) then
    Result := FModel.ModelRoot.Files
  else
    Result := nil;
end;

end.
