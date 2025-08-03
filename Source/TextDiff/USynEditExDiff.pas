{ -------------------------------------------------------------------------------
  Unit:     USynEditExDiff
  Author:   Gerhard Röhner
  Date:     2011
  Purpose:  SynEdit descendent for TextDiff
  ------------------------------------------------------------------------------- }

unit USynEditExDiff;

interface

uses
  Classes,
  Graphics,
  ExtCtrls,
  Forms,
  SynEdit,
  SynEditTextBuffer;

type

  TLineObj = class
  private
    FBackClr: TColor;
    FSpezial: Boolean;
    FTag: LongInt;
  public
    property BackClr: TColor read FBackClr write FBackClr;
    property Spezial: Boolean read FSpezial write FSpezial;
    property Tag: LongInt read FTag write FTag;
  end;

  TSynEditExDiff = class(TSynEdit)
  private
    FMyOwner: TComponent;
    FCurrLongestLineLen: Integer; // needed for horizontal scrollbar
    FLineModClr: TColor;
    FYellowGray: TColor;
    FSilveryGray: TColor;
    FModifiedStrs: array [Boolean] of string;
    FInsertModeStrs: array [Boolean] of string;
    FEncoding: string; // ANSI, UTF-8, UTF-16
    FLineBreak: string; // Windows, Unix, Mac
    FNumber: Integer;
    FPathname: string;
    FPCaption: TPanel;
    FWithColoredLines: Boolean;
    procedure DoExit1(Sender: TObject);
    procedure CodeEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    function DoSaveFile: Boolean;
    procedure SetHighlighter;
    procedure DeleteObjects(From, Till: Integer);
    procedure CreateObjects(From, Till, Tag: Integer); overload;
    function EncodingAsString(const Encoding: string): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoUndo;
    procedure DoRedo;
    procedure Enter(Sender: TObject);
    procedure LinesClearAll;
    procedure Save;
    procedure CreateObjects; overload;
    function LinebreakAsString: string;
    procedure SynEditorSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var Foreground, Background: TColor);
    procedure GutterTextEvent(Sender: TObject; ALine: Integer;
      var AText: string);
    function GetLineObj(Index: Integer): TLineObj;
    procedure Load(Lines12: TSynEditStringList; const APathname: string);
    procedure SetModified(Value: Boolean);
    procedure ShowFilename;
    procedure InsertItem(Index: Integer; const Str: string;
      LineObject: TLineObj);
    function CopyIntoClipboard(From, Till: Integer): Boolean;
    procedure PasteClipboard(EmptyClipboard: Boolean; From, Till, Num: Integer);
    procedure ChangeStyle;
    procedure SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);

    property Number: Integer read FNumber write FNumber;
    property Pathname: string read FPathname;
    property PCaption: TPanel read FPCaption write FPCaption;
    property WithColoredLines: Boolean read FWithColoredLines
      write FWithColoredLines;
  end;

implementation

uses
  SysUtils,
  Windows,
  Controls,
  Clipbrd,
  FileCtrl,
  JvGnugettext,
  StringResources,
  UTextDiff,
  UUtils,
  SynEditTypes,
  cPyScripterSettings,
  dmResources,
  uCommonFunctions;

constructor TSynEditExDiff.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMyOwner := AOwner;
  FCurrLongestLineLen := 60;
  FWithColoredLines := False;
  FNumber := 0;
  FPathname := '';
  FModifiedStrs[False] := '';
  FModifiedStrs[True] := _(SModified);
  FInsertModeStrs[False] := _('Over');
  FInsertModeStrs[True] := _('Ins');
  MaxUndo := 300;
  TabWidth := 2;
  WantTabs := True;
  Options := [eoAutoIndent, eoDragDropEditing, eoSmartTabs, eoTabIndent,
    eoTabsToSpaces, eoTrimTrailingSpaces, eoSmartTabDelete, eoGroupUndo,
    eoKeepCaretX, eoEnhanceHomeKey];
  ScrollOptions := [eoScrollPastEol, eoShowScrollHint];
  Font.Assign(GEditorOptions.Font);
  OnKeyUp := CodeEditKeyUp;
  OnStatusChange := EditorStatusChange;
  OnEnter := Enter;
  OnExit := DoExit1;
  OnScroll := SyncScroll;
  ChangeStyle;
end;

destructor TSynEditExDiff.Destroy;
begin
  OnStatusChange := nil;
  OnEnter := nil;
  OnExit := nil;
  TSynEditStringList(Lines).OnCleared := nil;
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
  Gutter.Color := FYellowGray;
  EditorStatusChange(Sender, [scAll]);
  if FWithColoredLines then
    (FMyOwner as TFTextDiff).ShowDiffState;
end;

procedure TSynEditExDiff.DoExit1(Sender: TObject);
begin
  Gutter.Color := FSilveryGray;
end;

procedure TSynEditExDiff.CodeEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with FMyOwner as TFTextDiff do
    if FilesCompared and (Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) then
      SyncScroll(Self, sbVertical)
    else if (Key = VK_RETURN) or ([ssCtrl] = Shift) and (Key = Ord('V')) then
      CreateObjects;
end;

function TSynEditExDiff.GetLineObj(Index: Integer): TLineObj;
begin
  if Lines.Count = 0 then
    Result := nil
  else
  begin
    if (Index < 0) or (Index >= Lines.Count) then
      raise Exception.Create('TLines.GetLineObj() - index out of bounds.');
    Result := TLineObj(Lines.Objects[Index]);
  end;
end;

procedure TSynEditExDiff.InsertItem(Index: Integer; const Str: string;
  LineObject: TLineObj);
begin
  inherited Lines.InsertObject(Index, Str, LineObject);
end;

procedure TSynEditExDiff.SynEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var Foreground, Background: TColor);
begin
  if (Line > Lines.Count) or not FWithColoredLines then
    Exit;
  var
  Lo1 := GetLineObj(Line - 1);
  if not Assigned(Lo1) then
  begin
    // Background:= clRed;      // good for debugging
    Background := FLineModClr;
    Special := True;
  end
  else
    with Lo1 do
      if Spezial then
      begin
        Background := BackClr;
        Special := True;
      end;
end;

procedure TSynEditExDiff.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  (FMyOwner as TFTextDiff).Number := FNumber;
  (FMyOwner as TFTextDiff).liLineColumn.Caption :=
    Format(' %4d : %3d ', [CaretY, CaretX]);
  if Changes * [scModified] <> [] then
  begin
    (FMyOwner as TFTextDiff).liModified.Caption := FModifiedStrs[Modified];
    ShowFilename;
  end;
  (FMyOwner as TFTextDiff).liInsOvr.Caption := FInsertModeStrs[InsertMode];
  (FMyOwner as TFTextDiff).liEncoding.Caption := ' ' + FEncoding + '/' +
    LinebreakAsString + ' ';
end;

procedure TSynEditExDiff.GutterTextEvent(Sender: TObject; ALine: Integer;
  var AText: string);
begin
  if FWithColoredLines then
  begin
    var
    LineObject := GetLineObj(ALine - 1);
    if not Assigned(LineObject) then
      Exit;
    with LineObject do
      if Tag = 0 then
        AText := ''
      else
        AText := IntToStr(Tag);
  end
  else
    AText := IntToStr(ALine);
end;

procedure TSynEditExDiff.Load(Lines12: TSynEditStringList;
  const APathname: string);
begin
  try
    Lines12.LoadFromFile(APathname);
  except
    on e: Exception do
      ErrorMsg('TSynEditExDiff.Load: ' + APathname);
  end;
  Lines.BeginUpdate;
  LinesClearAll;
  Lines.Assign(Lines12);
  Lines.EndUpdate;
  Self.FPathname := APathname;

  FEncoding := EncodingAsString(Lines12.Encoding.EncodingName);
  FLineBreak := Lines12.LineBreak;

  FWithColoredLines := False;
  SetHighlighter;
  SetModified(False);
  //(FMyOwner as TFTextDiff).SetActiveControl(Self);
end;

procedure TSynEditExDiff.Save;
var
  Line: TLineObj;
begin
  if FWithColoredLines then
  begin
    BeginUpdate;
    for var I := Lines.Count - 1 downto 0 do
    begin
      Line := GetLineObj(I);
      if Assigned(Line) then
        if Line.FTag = 0 then
        begin
          FreeAndNil(Line);
          Lines.Delete(I);
        end
        else
          Line.FSpezial := False;
    end;
    FWithColoredLines := False;
    EndUpdate;
    Invalidate;
  end;

  if Modified then
    try
      DoSaveFile;
      SetModified(False);
    except
      on e: Exception do
        ErrorMsg(e.Message);
    end;
end;

function TSynEditExDiff.DoSaveFile: Boolean;
begin
  Result := False;
  // Trim all lines just in case (Issue 196)
  if (Lines.Count > 0) and ((eoTrimTrailingSpaces in Options) or
    PyIDEOptions.TrimTrailingSpacesOnSave) then
  begin
    BeginUpdate;
    try
      for var I := 0 to Lines.Count - 1 do
        Lines[I] := TrimRight(Lines[I]);
    finally
      EndUpdate;
    end;
  end;
  if FPathname <> '' then
    Result := SaveWideStringsToFile(FPathname, Lines,
      PyIDEOptions.CreateBackupFiles);
  { else if fEditor.fRemoteFileName <> '' then
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
begin
  var Str := LowerCase(ExtractFileExt(FPathname));
  Highlighter := ResourcesDataModule.Highlighters.
    HighlighterFromFriendlyName(Str);
  if Highlighter = nil then
    OnPaintTransient := nil;
end;

function TSynEditExDiff.EncodingAsString(const Encoding: string): string;
begin
  Result := Encoding;
  if Pos('ANSI', Result) > 0 then
    Result := 'ANSI'
  else if Pos('ASCII', Result) > 0 then
    Result := 'ASCII'
  else if Pos('UTF-8', Result) > 0 then
    Result := 'UTF-8'
  else if Pos('UTF-16', Result) > 0 then
    Result := 'UTF-16'
  else if Pos('Unicode', Result) > 0 then
    Result := 'UTF-16';
end;

function TSynEditExDiff.LinebreakAsString: string;
begin
  if FLineBreak = #13#10 then
    Result := 'Windows'
  else if FLineBreak = #10 then
    Result := 'Unix'
  else
    Result := 'Mac';
end;

procedure TSynEditExDiff.LinesClearAll;
begin
  DeleteObjects(0, Lines.Count - 1);
  Lines.Clear;
  OnSpecialLineColors := nil;
  OnGutterGetText := nil;
end;

procedure TSynEditExDiff.DeleteObjects(From, Till: Integer);
var
  LineObject: TLineObj;
begin
  for var I := From to Till do
  begin
    LineObject := GetLineObj(I);
    if Assigned(LineObject) then
    begin
      LineObject.Free;
      Lines.Objects[I] := nil;
    end;
  end;
end;

procedure TSynEditExDiff.CreateObjects;
var
  LineObject: TLineObj;
begin
  if not FWithColoredLines then
    Exit;
  Lines.BeginUpdate;
  var Int := 0;
  while (Int < Lines.Count) and Assigned(GetLineObj(Int)) do
    Inc(Int);
  while (Int < Lines.Count) and (GetLineObj(Int) = nil) do
  begin
    LineObject := TLineObj.Create;
    LineObject.FSpezial := True;
    LineObject.FBackClr := FLineModClr;
    LineObject.FTag := Int + 1;
    Lines.Objects[Int] := LineObject;
    Inc(Int);
  end;
  Lines.EndUpdate;
  Invalidate;
end;

procedure TSynEditExDiff.CreateObjects(From, Till, Tag: Integer);
var
  LineObject: TLineObj;
begin
  for var I := From to Till do
    if GetLineObj(I) = nil then
    begin
      LineObject := TLineObj.Create;
      LineObject.FSpezial := True;
      LineObject.FBackClr := FLineModClr;
      LineObject.FTag := Tag;
      if Tag > 0 then
        Inc(Tag);
      Lines.Objects[I] := LineObject;
    end;
end;

procedure TSynEditExDiff.ShowFilename;
var
  Str: string;
  ACanvas: TCanvas;
begin
  ACanvas := (FMyOwner as TFTextDiff).Canvas;
  ACanvas.Font.Assign(FPCaption.Font);
  Str := ' ' + FPathname;
  if Modified then
    Str := Str + '*';
  FPCaption.Caption := MinimizeName(Str, ACanvas, FPCaption.Width);
end;

procedure TSynEditExDiff.SetModified(Value: Boolean);
begin
  Modified := Value;
  ShowFilename;
end;

function TSynEditExDiff.CopyIntoClipboard(From, Till: Integer): Boolean;
begin
  SelStart := RowColToCharIndex(BufferCoord(1, From + 1));
  if Till + 2 > Lines.Count then
    SelEnd := RowColToCharIndex(BufferCoord(Length(Lines[Lines.Count - 1]) + 1,
      Till + 1))
  else
    SelEnd := RowColToCharIndex(BufferCoord(1, Till + 2)) - 2;
  Result := (SelLength = 0);
  if Result then
    Clipboard.Clear
  else
    CopyToClipboard;
  SelLength := 0;
end;

procedure TSynEditExDiff.PasteClipboard(EmptyClipboard: Boolean;
  From, Till, Num: Integer);
begin
  DeleteObjects(From, Till);
  SelStart := RowColToCharIndex(BufferCoord(1, From + 1));
  if Till + 2 > Lines.Count then
    SelEnd := RowColToCharIndex(BufferCoord(Length(Lines[Lines.Count - 1]) + 1,
      Till + 1))
  else
    SelEnd := RowColToCharIndex(BufferCoord(1, Till + 2)) - 2;
  try
    if EmptyClipboard then
    begin
      CutToClipboard;
      Clipboard.Clear;
    end
    else
      PasteFromClipboard;
  except on e: Exception do
    ErrorMsg(e.Message);
  end;
  CreateObjects(From, Till, Num);
  SetModified(True);
  Invalidate;
end;

procedure TSynEditExDiff.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
  begin
    FLineModClr := $878787;
    FYellowGray := $519595;
    FSilveryGray := $777777;
  end
  else
  begin
    FLineModClr := $E0E0E0;
    FYellowGray := $97734F;
    FSilveryGray := $16A231;
  end;
end;

procedure TSynEditExDiff.SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
begin
  (FMyOwner as TFTextDiff).SyncScroll(Self, ScrollBar);
end;

end.
