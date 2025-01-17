{-------------------------------------------------------------------------------
 Unit:     USynEditExDiff
 Author:   Gerhard Röhner
 Date:     2011
 Purpose:  SynEdit descendent for TextDiff
-------------------------------------------------------------------------------}

unit USynEditExDiff;

interface

uses Classes, Graphics, ExtCtrls, Forms, SynEdit, SynEditTextBuffer;

type

  TLineObj = class
  public
    Spezial: Boolean;
    BackClr: TColor;
    Tag: longint;
  end;

  TSynEditExDiff = class (TSynEdit)
    private
      myOwner: TComponent;
      fCurrLongestLineLen: Integer; //needed for horizontal scrollbar
      fLineModClr: TColor;
      fYellowGray: TColor;
      fSilveryGray: TColor;
      ModifiedStrs: array[Boolean] of string;
      InsertModeStrs: array[Boolean] of string;
      procedure DoExit1(Sender: TObject);
      procedure CodeEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
      function DoSaveFile: Boolean;
      procedure SetHighlighter;
      procedure DeleteObjects(from, _to: Integer);
      procedure CreateObjects(from, _to, aTag: Integer); overload;
      function EncodingAsString(const aEncoding: string): string;
    public
      Encoding: string;   // ANSI, UTF-8, UTF-16
      LineBreak: string;  // Windows, Unix, Mac
      Nr: Integer;
      PCaption: TPanel;
      Pathname: string;
      WithColoredLines: Boolean;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure DoUndo;
      procedure DoRedo;
      procedure Enter(Sender: TObject);
      procedure LinesClearAll;
      procedure Save;
      procedure CreateObjects; overload;
      function LinebreakAsString: string;
      procedure SynEditorSpecialLineColors(Sender: TObject;
                  Line: Integer; var Special: Boolean; var FG, BG: TColor);
      procedure GutterTextEvent(Sender: TObject; aLine: Integer;
                  var aText: string);
      function  GetLineObj(index: Integer): TLineObj;
      procedure Load(Lines12: TSynEditStringList; const aPathname: string);
      procedure SetModified(Value: Boolean);
      procedure ShowFilename;
      procedure InsertItem(index: Integer; const s: string; LineObject: TLineObj);
      function  CopyIntoClipboard(from, _to: Integer): Boolean;
      procedure PasteClipboard(EmptyClipboard: Boolean; from, _to, aNr: Integer);
      procedure ChangeStyle;
      procedure SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
    end;

implementation

uses SysUtils, Windows, Controls, Clipbrd, FileCtrl,
     JvGnugettext, StringResources,
     UTextDiff, UUtils, frmFile, SynEditTypes,
     cPyScripterSettings, dmResources, uCommonFunctions;

constructor TSynEditExDiff.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  myOwner:= AOwner;
  fCurrLongestLineLen:= 60;
  WithColoredLines:= False;
  Nr:= 0;
  Pathname:= '';
  ModifiedStrs[False]:= '';
  ModifiedStrs[True]:= _(SModified);
  InsertModeStrs[False]:= _('Over');
  InsertModeStrs[True]:= _('Ins');
  MaxUndo:= 300;
  TabWidth:= 2;
  WantTabs:= True;
  Options:= [eoAutoIndent, eoDragDropEditing, eoScrollPastEol, eoShowScrollHint,
             eoSmartTabs, eoTabIndent, eoTabsToSpaces, eoTrimTrailingSpaces,
             eoSmartTabDelete, eoGroupUndo, eoKeepCaretX, eoEnhanceHomeKey];
  Font.Assign(EditorOptions.Font);
  OnKeyUp:= CodeEditKeyUp;
  OnStatusChange:= EditorStatusChange;
  OnEnter:= Enter;
  OnExit:= DoExit1;
  onScroll:= SyncScroll;
  ChangeStyle;
end;

destructor TSynEditExDiff.Destroy;
begin
  OnStatusChange:= nil;
  OnEnter:= nil;
  OnExit:= nil;
  TSynEditStringList(Lines).onCleared:= nil;
  LinesClearAll;
  inherited;
end;

procedure TSynEditExDiff.DoUndo;
begin
  Undo;
  CreateObjects;
end;

procedure TSynEditExDiff.DoRedo;
begin
  Redo;
  CreateObjects;
end;

procedure TSynEditExDiff.Enter(Sender: TObject);
begin
  Gutter.Color:= fYellowGray;
  EditorStatusChange(Sender, [scAll]);
  if WithColoredLines then
    (myOwner as TFTextDiff).ShowDiffState;
end;

procedure TSynEditExDiff.DoExit1(Sender: TObject);
begin
  inherited;
  Gutter.Color:= fSilveryGray;
end;

procedure TSynEditExDiff.CodeEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with myOwner as TFTextDiff do
    if FilesCompared and (Key in [VK_Up, VK_Down, VK_Prior, VK_Next]) then
      SyncScroll(Self, sbVertical) else
    if (Key = VK_RETURN) or ([ssCtrl] = Shift) and (Key = Ord('V'))
      then CreateObjects;
end;

function TSynEditExDiff.GetLineObj(index: Integer): TLineObj;
begin
  if Lines.Count = 0 then
    result:= nil
  else begin
    if (index < 0) or (index >= Lines.Count) then
      raise Exception.Create('TLines.GetLineObj() - index out of bounds.');
    result:= TLineObj(Lines.objects[index]);
  end;
end;

procedure TSynEditExDiff.InsertItem(index: Integer; const s: string; LineObject: TLineObj);
begin
  inherited Lines.InsertObject(index, s, LineObject);
end;

procedure TSynEditExDiff.SynEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
   var Lo1: TLineObj;
begin
  if (Line > Lines.Count) or not WithColoredLines then Exit;
  Lo1:= GetLineObj(Line-1);
  if Lo1 = nil then begin
    // BG:= clRed;      good for debugging
    BG:= fLineModClr;
    Special:= True;
    end
  else with Lo1 do
    if Spezial then begin
      BG:= BackClr;
      Special:= True;
    end;
end;

procedure TSynEditExDiff.EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  (MyOwner as TFTextDiff).Nr:= Nr;
  (MyOwner as TFTextDiff).liLineColumn.Caption:= Format(' %4d : %3d ', [CaretY, CaretX]);
  if Changes * [scModified] <> [] then begin
    (MyOwner as TFTextDiff).liModified.Caption:= ModifiedStrs[Modified];
    ShowFilename;
  end;
  (MyOwner as TFTextDiff).liInsOvr.Caption:= InsertModeStrs[InsertMode];
  (MyOwner as TFTextDiff).liEncoding.Caption:= ' ' + Encoding + '/' + LinebreakAsString + ' ';
end;

procedure TSynEditExDiff.GutterTextEvent(Sender: TObject; aLine: Integer;
           var aText: string);
   var LineObject: TLineObj;
begin
  if WithColoredLines then begin
    LineObject:= GetLineObj(aLine-1);
    if LineObject = nil then Exit;
    with LineObject do
      if Tag = 0
        then aText:= ''
        else aText:= InttoStr(Tag);
    end
  else
    aText:= IntToStr(aLine);
end;

procedure TSynEditExDiff.Load(Lines12: TSynEditStringList; const aPathname: string);
begin
  try
    Lines12.LoadFromFile(aPathname);
  except on e: Exception do
    ErrorMsg('TSynEditExDiff.Load: ' + aPathname);
  end;
  Lines.BeginUpdate;
  LinesClearAll;
  Lines.Assign(Lines12);
  Lines.EndUpdate;
  Self.Pathname:= aPathname;

  Encoding:= EncodingAsString(Lines12.Encoding.EncodingName);
  Linebreak:= Lines12.LineBreak;

  WithColoredLines:= False;
  SetHighlighter;
  SetModified(False);
  (myOwner as TFTextDiff).setActiveControl(Self);
end;

procedure TSynEditExDiff.Save;
  var i: Integer;
      Line: TLineObj;
begin
  if WithColoredLines then begin
    BeginUpdate;
    for i:= Lines.Count - 1 downto 0 do begin
      Line:= GetLineObj(i);
      if Assigned(Line) then
        if Line.Tag = 0 then begin
          FreeAndNil(Line);
          Lines.Delete(i);
        end else
          Line.Spezial:= False;
    end;
    WithColoredLines:= False;
    EndUpdate;
    Invalidate;
  end;

  if Modified then
    try
      DoSaveFile;
      SetModified(False);
    except
      on E: Exception do
        ErrorMsg(E.Message);
    end;
end;


function TSynEditExDiff.DoSaveFile: Boolean;
var
  i: Integer;
begin
  Result:= False;
  // Trim all lines just in case (Issue 196)
  if (Lines.Count > 0) and ((eoTrimTrailingSpaces in Options) or
    PyIDEOptions.TrimTrailingSpacesOnSave)  then
  begin
    BeginUpdate;
    try
      for i := 0 to Lines.Count - 1 do
        Lines[i] := TrimRight(Lines[i]);
    finally
      EndUpdate;
    end;
  end;
  if Pathname <> '' then
    Result:= SaveWideStringsToFile(Pathname, Lines, PyIDEOptions.CreateBackupFiles);
{  else if fEditor.fRemoteFileName <> '' then
     Result := fEditor.SaveToRemoteFile(fEditor.fRemoteFileName, fEditor.fSSHServer);
}

  if Result then
  begin
    if not PyIDEOptions.UndoAfterSave then
      ClearUndo;
    Modified := False;
  end;
end;

procedure TSynEditExDiff.SetHighlighter;
  var s: string;
begin
  s:= Lowercase(ExtractFileExt(Pathname));
  Highlighter:= ResourcesDataModule.Highlighters.HighlighterFromFriendlyName(s);
  if Highlighter = nil then
    OnPaintTransient:= nil;
end;

function TSynEditExDiff.EncodingAsString(const aEncoding: string): string;
begin
  Result:= aEncoding;
  if Pos('ANSI', Result) > 0 then Result:= 'ANSI' else
  if Pos('ASCII', Result) > 0 then Result:= 'ASCII' else
  if Pos('UTF-8', Result) > 0 then Result:= 'UTF-8' else
  if Pos('UTF-16', Result) > 0 then Result:= 'UTF-16' else
  if Pos('Unicode', Result) > 0 then Result:= 'UTF-16';
end;

function TSynEditExDiff.LinebreakAsString: string;
begin
  if LineBreak = #13#10 then Result:= 'Windows' else
  if LineBreak = #10 then Result:= 'Unix'
  else Result:= 'Mac';
end;

procedure TSynEditExDiff.LinesClearAll;
begin
  DeleteObjects(0, Lines.Count-1);
  Lines.Clear;
  OnSpecialLineColors:= nil;
  OnGutterGetText:= nil;
end;

procedure TSynEditExDiff.DeleteObjects(from, _to: Integer);
  var i: Integer;
      LineObject: TLineObj;
begin
  for i:= from to _to do begin
    LineObject:= GetLineObj(i);
    if Assigned(LineObject) then begin
      FreeAndNil(LineObject);
      Lines.objects[i]:= nil
    end;  
  end;
end;

procedure TSynEditExDiff.CreateObjects;
  var i: Integer;
      LineObject: TLineObj;
begin
  if not WithColoredLines then Exit;
  Lines.BeginUpdate;
  i:= 0;
  while (i < Lines.Count) and Assigned(GetLineObj(i)) do
    Inc(i);
  while (i < Lines.Count) and (GetLineObj(i) = nil) do begin
    LineObject:= TLineObj.Create;
    LineObject.Spezial:= True;
    LineObject.BackClr:= fLineModClr;
    LineObject.Tag:= i+1;
    Lines.Objects[i]:= LineObject;
    Inc(i);
  end;
  Lines.EndUpdate;
  Invalidate;
end;

procedure TSynEditExDiff.CreateObjects(from, _to, aTag: Integer);
  var i: Integer;
      LineObject: TLineObj;
begin
  for i:= from to _to do
    if GetLineObj(i) = nil then begin
      LineObject:= TLineObj.Create;
      LineObject.Spezial:= True;
      LineObject.BackClr:= fLineModClr;
      LineObject.Tag:= aTag;
      if aTag > 0 then Inc(aTag);
      Lines.Objects[i]:= LineObject;
    end;
end;

procedure TSynEditExDiff.ShowFilename;
  var s: string; aCanvas: TCanvas;
begin
  aCanvas:= (myOwner as TFTextDiff).Canvas;
  aCanvas.Font.Assign(PCaption.Font);
  s:= ' ' + Pathname;
  if Modified then s:= s + '*';
  PCaption.Caption:= MinimizeName(s, aCanvas, PCaption.Width);
end;

procedure TSynEditExDiff.SetModified(Value: Boolean);
begin
  Modified:= Value;
  ShowFilename;
end;

function TSynEditExDiff.CopyIntoClipboard(from, _to: Integer): Boolean;
begin
  SelStart:= RowColToCharIndex(BufferCoord(1, from + 1));
  if _to + 2 > Lines.Count
    then SelEnd:= RowColToCharIndex(BufferCoord(Length(Lines[Lines.Count-1]) + 1, _to + 1))
    else SelEnd:= RowColToCharIndex(BufferCoord(1, _to + 2)) - 2;
  Result:= (SelLength = 0);
  if Result
    then Clipboard.Clear
    else CopyToClipboard;
  SelLength:= 0;
end;

procedure TSynEditExDiff.PasteClipboard(EmptyClipboard: Boolean; from, _to, aNr: Integer);
begin
  DeleteObjects(from, _To);
  SelStart:= RowColToCharIndex(BufferCoord(1, from+1));
  if _to + 2 > Lines.Count
    then SelEnd:= RowColToCharIndex(BufferCoord(Length(Lines[Lines.Count-1])+1, _to + 1))
    else SelEnd:= RowColToCharIndex(BufferCoord(1, _To + 2)) - 2;
  try
    if EmptyClipboard then begin
      CutToClipboard;
      Clipboard.Clear
      end
    else
      PasteFromClipboard;
  except
  end;
  CreateObjects(from, _To, aNr);
  SetModified(True);
  Invalidate;
end;

procedure TSynEditExDiff.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    fLineModClr:= $878787;
    fYellowGray:= $519595;
    fSilveryGray:= $777777;
  end else begin
    fLineModClr:= $E0E0E0;
    fYellowGray:= $97734F;
    fSilveryGray:= $16A231;
  end;
end;

procedure TSynEditExDiff.SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
begin
  (myOwner as TFTextDiff).SyncScroll(Self, ScrollBar);
end;

end.
