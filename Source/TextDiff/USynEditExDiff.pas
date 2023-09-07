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
    Spezial: boolean;
    BackClr: TColor;
    Tag: longint;
  end;

  TSynEditExDiff = class (TSynEdit)
    private
      myOwner: TComponent;
      fCurrLongestLineLen: integer; //needed for horizontal scrollbar
      fLineModClr: TColor;
      fYellowGray: TColor;
      fSilveryGray: TColor;
      ModifiedStrs: array[boolean] of string;
      InsertModeStrs: array[boolean] of string;
      procedure DoExit1(Sender: TObject);
      procedure CodeEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
      function DoSaveFile: boolean;
      procedure SetHighlighter;
      procedure DeleteObjects(von, bis: integer);
      procedure CreateObjects(von, bis, aTag: integer); overload;
      function EncodingAsString(const aEncoding: String): string;
    public
      Encoding: string;   // ANSI, UTF-8, UTF-16
      LineBreak: string;  // Windows, Unix, Mac
      Nr: integer;
      PCaption: TPanel;
      Pathname: string;
      WithColoredLines: boolean;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure DoUndo;
      procedure DoRedo;
      procedure Enter(Sender: TObject);
      procedure LinesClearAll;
      procedure Save(MitBackup: boolean);
      procedure CreateObjects; overload;
      function LinebreakAsString: String;
      procedure SynEditorSpecialLineColors(Sender: TObject;
                  Line: Integer; var Special: Boolean; var FG, BG: TColor);
      procedure GutterTextEvent(Sender: TObject; aLine: Integer;
                  var aText: String);
      function  GetLineObj(index: integer): TLineObj;
      procedure Load(Lines12: TSynEditStringList; const aPathname: string);
      procedure SetModified(Value: boolean);
      procedure ShowFilename;
      procedure InsertItem(index: integer; const s: string; LineObject: TLineObj);
      function  CopyIntoClipboard(von, bis: integer): boolean;
      procedure PasteClipboard(EmptyClipboard: boolean; von, bis, aNr: integer);
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
  WithColoredLines:= false;
  Nr:= 0;
  Pathname:= '';
  ModifiedStrs[false]:= '';
  ModifiedStrs[true]:= _(SModified);
  InsertModeStrs[false]:= _('Over');
  InsertModeStrs[true]:= _('Ins');
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
    if (Key = VK_Return) or ([ssCtrl] = Shift) and (Key = Ord('V'))
      then CreateObjects;
end;

function TSynEditExDiff.GetLineObj(index: integer): TLineObj;
begin
  if Lines.count = 0 then
    result:= nil
  else begin
    if (index < 0) or (index >= Lines.count) then
      raise Exception.Create('TLines.GetLineObj() - index out of bounds.');
    result:= TLineObj(Lines.objects[index]);
  end;
end;

procedure TSynEditExDiff.InsertItem(index: integer; const s: string; LineObject: TLineObj);
begin
  inherited Lines.InsertObject(index, s, LineObject);
end;

procedure TSynEditExDiff.SynEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
   var Lo1: TLineObj;
begin
  if (Line > Lines.Count) or not WithColoredLines then exit;
  Lo1:= GetLineObj(Line-1);
  if Lo1 = nil then begin
    // BG:= clRed;      good for debugging
    BG:= fLineModClr;
    Special:= true;
    end
  else with Lo1 do
    if Spezial then begin
      BG:= BackClr;
      Special:= true;
    end;
end;

procedure TSynEditExDiff.EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
  var LineColumn: string;

  procedure setPanel(i: integer; s: string);
  begin
    if (MyOwner as TFTextDiff).StatusBar.Panels[i].Text <> s then
      (MyOwner as TFTextDiff).StatusBar.Panels[i].Text:= s;
    (MyOwner as TFTextDiff).Nr:= Nr;
 end;

begin
  LineColumn:= _('Line') + ': %4d  ' + _('Column') + ': %3d';
  setPanel(0, Format(LineColumn, [CaretY, CaretX]));
  if Changes * [scModified] <> [] then begin
    setPanel(1, ModifiedStrs[Modified]);
    ShowFilename;
  end;
  setPanel(2, InsertModeStrs[InsertMode]);
  setPanel(3, ' ' + Encoding + '/' + LinebreakAsString + ' ');
end;

procedure TSynEditExDiff.GutterTextEvent(Sender: TObject; aLine: Integer;
           var aText: String);
   var LineObject: TLineObj;
begin
  if WithColoredLines then begin
    LineObject:= GetLineObj(aLine-1);
    if LineObject = nil then exit;
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
  self.Pathname:= aPathname;

  Encoding:= EncodingAsString(Lines12.Encoding.EncodingName);
  Linebreak:= Lines12.LineBreak;

  WithColoredLines:= false;
  SetHighlighter;
  SetModified(false);
  (myOwner as TFTextDiff).setActiveControl(Self);
end;

procedure TSynEditExDiff.Save(MitBackup: boolean);
  var i: integer;
      Zeile: TLineObj;
begin
  if WithColoredLines then begin
    BeginUpdate;
    for i:= Lines.Count - 1 downto 0 do begin
      Zeile:= GetLineObj(i);
      if assigned(Zeile) then
        if Zeile.Tag = 0 then begin
          FreeAndNil(Zeile);
          Lines.Delete(i);
        end else
          Zeile.Spezial:= false;
    end;
    WithColoredLines:= false;
    EndUpdate;
    Invalidate;
  end;

  if Modified then
    try
      DoSaveFile;
      SetModified(false);
    except
      on E: Exception do
        ErrorMsg(E.Message);
    end;
end;


function TSynEditExDiff.DoSaveFile: boolean;
var
  i: Integer;
begin
  Result:= false;
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

function TSynEditExDiff.EncodingAsString(const aEncoding: String): string;
begin
  Result:= aEncoding;
  if Pos('ANSI', Result) > 0 then Result:= 'ANSI' else
  if Pos('ASCII', Result) > 0 then Result:= 'ASCII' else
  if Pos('UTF-8', Result) > 0 then Result:= 'UTF-8' else
  if Pos('UTF-16', Result) > 0 then Result:= 'UTF-16' else
  if Pos('Unicode', Result) > 0 then Result:= 'UTF-16';
end;

function TSynEditExDiff.LinebreakAsString: String;
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

procedure TSynEditExDiff.DeleteObjects(von, bis: integer);
  var i: integer;
      LineObject: TLineObj;
begin
  for i:= von to bis do begin
    LineObject:= GetLineObj(i);
    if assigned(LineObject) then begin
      FreeAndNil(LineObject);
      Lines.objects[i]:= nil
    end;  
  end;
end;

procedure TSynEditExDiff.CreateObjects;
  var i: integer;
      LineObject: TLineObj;
begin
  if not WithColoredLines then exit;
  Lines.BeginUpdate;
  i:= 0;
  while (i < Lines.Count) and assigned(GetLineObj(i)) do
    inc(i);
  while (i < Lines.Count) and (GetLineObj(i) = nil) do begin
    LineObject:= TLineObj.Create;
    LineObject.Spezial:= true;
    LineObject.BackClr:= fLineModClr;
    LineObject.Tag:= i+1;
    Lines.Objects[i]:= LineObject;
    inc(i);
  end;
  Lines.EndUpdate;
  Invalidate;
end;

procedure TSynEditExDiff.CreateObjects(von, bis, aTag: integer);
  var i: integer;
      LineObject: TLineObj;
begin
  for i:= von to bis do
    if GetLineObj(i) = nil then begin
      LineObject:= TLineObj.Create;
      LineObject.Spezial:= true;
      LineObject.BackClr:= fLineModClr;
      LineObject.Tag:= aTag;
      if aTag > 0 then inc(aTag);
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

procedure TSynEditExDiff.SetModified(Value: boolean);
begin
  Modified:= Value;
  ShowFilename;
end;

function TSynEditExDiff.CopyIntoClipboard(von, bis: integer): boolean;
begin
  SelStart:= RowColToCharIndex(BufferCoord(1, von+1));
  if bis + 2 > Lines.Count
    then SelEnd:= RowColToCharIndex(BufferCoord(length(Lines[Lines.count-1])+1, bis+1))
    else SelEnd:= RowColToCharIndex(BufferCoord(1, bis+2)) - 2;
  Result:= (SelLength = 0);
  if Result
    then Clipboard.Clear
    else CopyToClipboard;
  SelLength:= 0;
end;

procedure TSynEditExDiff.PasteClipboard(EmptyClipboard: boolean; von, bis, aNr: integer);
begin
  DeleteObjects(von, bis);
  SelStart:= RowColToCharIndex(BufferCoord(1, von+1));
  if bis + 2 > Lines.Count
    then SelEnd:= RowColToCharIndex(BufferCoord(length(Lines[Lines.count-1])+1, bis+1))
    else SelEnd:= RowColToCharIndex(BufferCoord(1, bis+2)) - 2;
  try
    if EmptyClipboard then begin
      CutToClipboard;
      Clipboard.Clear
      end
    else
      PasteFromClipboard;
  except
  end;
  CreateObjects(von, bis, aNr);
  SetModified(true);
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
