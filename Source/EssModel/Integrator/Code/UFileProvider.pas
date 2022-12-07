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

unit UFileProvider;

interface

uses Classes, uCodeProvider, frmFile;

type

  {
    Implementation of a TCodeProvider using the physical filesystem.
  }
  TFileProvider = class(TCodeProvider)
  protected
    procedure HookChanges; override;
    procedure UnhookChanges; override;
  public
    function LoadStream(const AName: string; Form: TFileForm = nil): TStream; override;
    procedure SaveStream(const AName: string; AStream: TStream); override;
    function LocateFile(const AName: string): string; override;
  end;

implementation

uses SysUtils, SynUnicode, uEditAppIntfs, UUtils, uCommonFunctions, frmEditor;

{ TFileProvider }

function TFileProvider.LoadStream(const AName: string; Form: TFileForm = nil): TStream;
  var fStream: TFileStream; sStream: TStringStream;
      Lines: TStringList; source: string; EditForm: TEditorForm;
begin
  Result:= nil;
  try
    if AName <> '' then begin
      if Form = nil
        then EditForm:= TEditorform(GI_EditorFactory.GetEditorByName(AName))
        else EditForm:= Form as TEditorForm;
      if Assigned(EditForm) then begin
        Source:= EditForm.SynEdit.Text + #0;
        if Source = #0 then Source:= 'null' + #0;
        Result:= TStringStream.Create(Source, TEncoding.Unicode);
      end else if FileExists(AName) and ValidFilename(AName) then begin
        // used by ClassInsert
        try
          try
            Lines:= TXStringList.Create;
            fStream:= TFileStream.Create(AName, fmOpenRead or fmShareDenyWrite);
            Lines.LoadFromStream(fStream, TEncoding.ANSI);  // switches to UTF8 automatically
            sStream:= TStringStream.Create(Lines.Text + #0, TEncoding.Unicode, true);
            Result:= sStream;
          except on e: Exception do
            ErrorMsg(e.Message);
          end;
        finally
          FreeAndNil(fStream);
          FreeAndNil(Lines);
        end;

      end else
        Result:= TStringStream.Create('null' + #0);
      Inc(LoadedCount);
      AddChangeWatch(AName);
      AddSearchPath(ExtractFilePath(AName));
    end;
  except
    on e: exception do begin
      ErrorMsg(E.Message);
      Result:= nil;
    end;
  end;
end;

procedure TFileProvider.SaveStream(const AName: string; AStream: TStream);
var
  fs: TFileStream;
begin
   //inherited;
   { TODO : Make a backup before we save the file. }
  fs := TFileStream.Create(AName, fmOpenWrite + fmShareExclusive);
  try
    try
      fs.CopyFrom(AStream, 0);
    except
      on e: exception do
        ErrorMsg(e.Message);
    end;
  finally
    FreeAndNil(fs);
  end;
end;

procedure TFileProvider.HookChanges;
begin
   { TODO : Attach a filesystem listener. }

end;

procedure TFileProvider.UnhookChanges;
begin
   { TODO : Dettach the filesystem listener. }
end;

function TFileProvider.LocateFile(const AName: string): string;
var
  i: Integer;
  p: string;
begin
  Result := '';
  if ( Pos(Copy(AName, 1, 1), '\/') > 0 ) or (Copy(AName, 2, 1) = ':') then
  begin
    //Filename with an absolute path
    if FileExists(AName) then
      Result := AName;
  end
  else
  begin
    //Filename without a path, use searchpath to locate it.
    for I := 0 to SearchPath.Count - 1 do
    begin
      if FileExists(SearchPath[I] + AName) then
      begin
        Result := SearchPath[I] + AName;
        Break;
      end;
    end;
  end;

  // Add the searchpath of the file to searchpaths.
  // It will only be added if it doesn't already exist in searchpaths
  P := ExtractFilePath(Result);
  if (P <> '') and (SearchPath.IndexOf(P) < 0) then
    SearchPath.Add(P);
end;

end.

