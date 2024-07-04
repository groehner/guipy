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
  Dialogs, Classes, ExtCtrls,
  uModel, uViewIntegrator, uFeedback;

type
  TDMUMLModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure CopyDiagramClipboardActionExecute(Sender: TObject);
    procedure FileOpenActionExecute(Sender: TObject);
    procedure SaveDiagramActionExecute(Sender: TObject);
    function OpenFolderActionExecute(Sender: TObject): boolean;
  private
    FModel   : TObjectModel;
    FDiagram : TDiagramIntegrator;  // TRtfdDiagram is descendent of TDiagramIntegrator
    Feedback : IEldeanFeedback;
    SD: TSaveDialog;
    OD: TOpenDialog;
  public
    property Diagram: TDiagramIntegrator read FDiagram;
    property Model: TObjectModel read FModel;

    constructor Create(AOwner: TComponent; Panel: TPanel); reintroduce;
    procedure LoadProject(FileNames : TStrings); overload;
    procedure LoadProject(const FileName : string); overload;
    procedure AddToProject(const FileName: String); overload;
    procedure AddToProject(FileNames: TStrings); overload;
    procedure ShowAllOpenedFiles;
    procedure SaveUML(const Pathname: string);
    procedure LoadUML(const Pathname: string);
    function  getUMLFilename: string;
    procedure InitShowParameter(i: integer);
    procedure SetShowIcons(i: integer);
    procedure RefreshDiagram;
    procedure DoLayout;
    procedure EditSelectedElement;
    procedure UnSelectAllElements;
    procedure SelectAssociation;
    procedure Print;
    function getFiles: TStringList;
  end;

implementation

uses Windows, SysUtils, Graphics, Controls, Forms, Clipbrd, Printers, Contnrs,
     INIFiles, uIntegrator, uFileProvider, uEditAppIntfs,
     uOpenFolderForm, UUtils, UUMLForm, URtfdDiagram;

{$R *.DFM}

constructor TDMUMLModule.Create(AOwner: TComponent; Panel: TPanel);
begin
  inherited Create(AOwner);
  SD:= nil;
  OD:= nil;
  Feedback:= nil;
  FModel := TObjectModel.Create;
  FDiagram:= TRtfdDiagram.Create(FModel, Panel, Feedback);
end;

procedure TDMUMLModule.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FDiagram);
  FreeAndNil(FModel);
  inherited;
end;

procedure TDMUMLModule.LoadProject(FileNames : TStrings);
var
  Ext : string;
  Imp : TImportIntegrator;
  Ints : TClassList;
  Exts : TStringList;
  I,J : integer;
  SikCursor: TCursor;
  OtherFiles: TStringList;
begin
  // Examine fileextension and call the correct integrator
  SikCursor:= Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Ext:= '';
  for i:= 0 to Filenames.Count - 1 do
    if LowerCase(ExtractFileExt(FileNames[i])) = '.py' then
      Ext:= '.py';
  if (Ext = '') and (Filenames.Count > 0) then
    Ext:= LowerCase(ExtractFileExt(FileNames[0]));

  Imp := nil;
  Ints := Integrators.Get(TImportIntegrator);
  OtherFiles:= TStringList.Create;
  try
    for I := 0 to Ints.Count - 1 do begin
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        if Exts.IndexOfName(Ext) > -1 then begin
          Imp := TImportIntegratorClass(Ints[I]).Create(Model, TFileProvider.Create(Feedback) );
          J := 0;
          while J < FileNames.Count do
            if Exts.IndexOfName(LowerCase(ExtractFileExt(FileNames[J]))) = -1
              then begin
                OtherFiles.Add(FileNames[J]);
                FileNames.Delete(J)
              end
              else Inc(J);
          Break;
        end;
      finally
        FreeAndNil(Exts);
      end;
    end;
    if Imp <> nil then
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
  L : TStringList;
begin
  L := TStringList.Create;
  L.Add(FileName);
  LoadProject(L);
  FreeAndNil(L);
end;

procedure TDMUMLModule.AddToProject(const FileName: String);
var
  Ext : string;
  Imp : TImportIntegrator;
  Ints : TClassList;
  Exts : TStringList;
  I: integer; 
begin
  try
    if assigned(FModel) and assigned(FModel.ModelRoot) and
       assigned(FModel.ModelRoot.Files) and (FModel.ModelRoot.Files.Text = '') then begin
      LoadProject(Filename);
      FDiagram.ResolveAssociations;
      FDiagram.ResolveObjectAssociations;
      exit;
    end;
  except
    on e: exception do
      ErrorMsg('TDMUMLModule.AddToProject ');
  end;
  Ext:= LowerCase(ExtractFileExt(FileName));
  Imp := nil;
  Ints := Integrators.Get(TImportIntegrator);
  try
    for I := 0 to Ints.Count - 1 do begin
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        if Exts.IndexOfName(Ext)>-1 then
          Imp := TImportIntegratorClass(Ints[I]).Create(Model, TFileProvider.Create(Feedback) );
      finally
        FreeAndNil(Exts);
      end;
    end;

    if Imp <> nil then
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

procedure TDMUMLModule.AddToProject(Filenames: TStrings);
  var i: integer;
begin
  for i:= 0 to Filenames.Count - 1 do
    AddToProject(Filenames[i]);
end;

procedure TDMUMLModule.CopyDiagramClipboardActionExecute(Sender: TObject);
var
  Selected: boolean;
  B1, B2:  Graphics.TBitmap;
  W, H : integer;
  SelRect: TRect;
begin
  SelRect:= Diagram.GetSelectedRect;
  Selected:= (SelRect.Right > SelRect.Left);
  Diagram.GetDiagramSize(W, H);
  try
    B1:= Graphics.TBitmap.Create;
    B1.Width := W;
    B1.Height:= H;
    B1.Canvas.Lock;
    Diagram.PaintTo(B1.Canvas, 0, 0, True);

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
end;

procedure TDMUMLModule.FileOpenActionExecute(Sender: TObject);
var
  Ints : TClassList;
  Exts : TStringList;
  I,J : integer;
  AnyFilter,
  Filter : string;
begin
  Filter := '';
  Ints := Integrators.Get(TImportIntegrator);
  try
    for I := 0 to Ints.Count - 1 do
    begin
      Exts := TImportIntegratorClass(Ints[I]).GetFileExtensions;
      try
        for J := 0 to Exts.Count - 1 do
        begin
          if Filter<>'' then
            Filter := Filter + '|';
          Filter := Filter + Exts.Values[ Exts.Names[J] ] + ' (*' + Exts.Names[J] + ')|*' + Exts.Names[J];
          if AnyFilter<>'' then
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

  if not Assigned(OD) then begin
    OD := TOpenDialog.Create(Self);
    OD.Filter := Filter;
    OD.Options := OD.Options + [ofAllowMultiSelect];
  end;
  if OD.Execute then
    LoadProject(OD.Files);
end;

procedure TDMUMLModule.SaveDiagramActionExecute(Sender: TObject);
begin
  if not assigned(SD) then begin
    SD:= TSaveDialog.Create(Self);
    SD.InitialDir:= ExtractFilePath(Model.ModelRoot.GetConfigFile);
    SD.Filter:= 'SVG files (*.svg)|*.svg|PNG files (*.png)|*.png|All files (*.*)|*.*';
    SD.Options:= SD.Options + [ofOverwritePrompt];
  end;
  if SD.Execute then begin
    if ExtractFileExt(SD.FileName) = '' then begin
      if SD.FilterIndex = 2
        then SD.FileName:= ChangeFileExt(SD.FileName, '.png')
        else SD.FileName:= ChangeFileExt(SD.FileName, '.svg');
    end;
    Diagram.SaveAsPicture(SD.FileName);
  end;
end;

procedure TDMUMLModule.ShowAllOpenedFiles;
  var Files: TStringList; i: integer;
begin
  Files:= TStringList.Create;
  for i:= 0 to GI_EditorFactory.Count - 1 do
    if GI_EditorFactory.Editor[i].hasPythonFile then
      Files.Add(GI_EditorFactory.Editor[i].Filename);
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

function TDMUMLModule.getUMLFilename: String;
begin
  if Assigned(Diagram.Package)
    then Result:= Diagram.Package.GetConfigFile
    else Result:= '';
end;

procedure TDMUMLModule.InitShowParameter(i: integer);
begin
  Diagram.InitShowParameter(i);
end;

procedure TDMUMLModule.SetShowIcons(i: integer);
begin
  Diagram.ShowIcons:= i;
end;

{$WARNINGS OFF}
function TDMUMLModule.OpenFolderActionExecute(Sender: TObject): boolean;

  procedure _AddFileNames(Files: TStringList; const Path, Ext: string; rekursiv: boolean);
    var Sr: TSearchRec;
  begin
    if FindFirst(Path + '\*.*', faReadOnly or faDirectory, Sr) = 0 then begin
      repeat
        if (Sr.Name <> '.') and (Sr.Name <> '..') then
          if ((Sr.Attr and faDirectory) = faDirectory) and rekursiv then
            _AddFileNames(Files, Path + '\' + Sr.Name, Ext, rekursiv)
          else
            if CompareText(ExtractFileExt(Sr.Name), Ext) = 0 then
              Files.Add(Path + '\' + Sr.Name);
      until FindNext(Sr) <> 0;
      FindClose(Sr);
    end;
  end;

begin
  Result:= false;
  var SL := TStringList.Create;
  var OpenFolderForm:= TFOpenFolderForm.Create(nil);
  var Ints := Integrators.Get(TImportIntegrator);
  try
    for var i := 0 to Ints.Count - 1 do begin
      var Exts := TImportIntegratorClass(Ints[i]).GetFileExtensions;
      try
        OpenFolderForm.CBFiletype.Items.Add( '*' + Exts.Names[0]);
      finally
        FreeAndNil(Exts);
      end;
    end;
    OpenFolderForm.CBFiletype.ItemIndex:= 0;

    if OpenFolderForm.ShowModal = mrOk then begin
      Result:= true;
      _AddFileNames(SL, OpenFolderForm.PathTreeView.Path,
                    Copy(OpenFolderForm.CBFiletype.Items[OpenFolderForm.CBFiletype.ItemIndex], 2, 10),
                    OpenFolderForm.CBWithSubFolder.Checked);
      if SL.Count > 0 then begin
        LoadProject(SL);
        FDiagram.ResolveAssociations;
      end else
        ShowMessage('No files found.');
    end;
  finally
    FreeAndNil(SL);
    FreeAndNil(Ints);
    OpenFolderForm.Release;
  end;
end;
{$WARNINGS ON}

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
  Var DBx, DBY: Integer;
  FormImage: TBitmap;
  Info: PBitmapInfo;
  InfoSize: DWORD;
  Image: Pointer;
  ImageSize: DWORD;
  Bits: HBITMAP;
  DIBWidth, DIBHeight: Longint;
  PrintWidth, PrintHeight: Longint;
  Canvas: TCanvas;

begin
  FormImage:= TBitmap.Create;
  Diagram.GetDiagramSize(DBx, DBy);
  FormImage.Width:= DBx-1;
  FormImage.Height:= DBy-1;

  try
    Canvas:= FormImage.Canvas;
    Canvas.Lock;
    Diagram.PaintTo(FormImage.Canvas, 0, 0, false);

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
            with Info^.bmiHeader do begin
              DIBWidth := biWidth;
              DIBHeight := biHeight;
            end;
            PrintWidth := MulDiv(DIBWidth, GetDeviceCaps(Handle,
                             LOGPIXELSX), Screen.PixelsPerInch);
            PrintHeight := MulDiv(DIBHeight, GetDeviceCaps(Handle,
                             LOGPIXELSY), Screen.PixelsPerInch);
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

function TDMUMLModule.getFiles: TStringList;
begin
  if assigned(FModel) and assigned(FModel.ModelRoot)
    then Result:= FModel.ModelRoot.Files
    else Result:= nil;
end;

end.
