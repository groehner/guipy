unit UTextDiff;

// -----------------------------------------------------------------------------
// Application:     TextDiff                                                   .
// Module:          Main                                                       .
// Version:         4.3                                                        .
// Date:            10.07.2022                                                 .
// Target:          Win32, Delphi 10.4                                            .
// Author:          Angus Johnson - angusj-AT-myrealbox-DOT-com
// Lizenz:          Freeware - http://www.angusj.com/delphi/textdiff.html
// Copyright:       © 2003-2004 Angus Johnson
// © 2006-2025 Gerhard Röhner                                  .
// -----------------------------------------------------------------------------

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  ComCtrls,
  ToolWin,
  System.ImageList,
  System.Classes,
  Vcl.Menus,
  Vcl.ImgList,
  Vcl.BaseImageCollection,
  SVGIconImageCollection,
  Vcl.VirtualImageList,
  TB2Item,
  SpTBXItem,
  SpTBXSkins,
  SynEdit,
  frmFile,
  UDiff,
  USynEditExDiff,
  SynEditTextBuffer,
  uEditAppIntfs,
  frmEditor;

type

  { TFTextDiff }

  TFTextDiff = class(TFileForm, ISearchCommands)
    TBTextDiff: TToolBar;
    TBView: TToolButton;
    TBNext: TToolButton;
    TBPrev: TToolButton;
    TBDiffsOnly: TToolButton;
    TBCopyBlockLeft: TToolButton;
    TBCopyBlockRight: TToolButton;
    PMain: TPanel;
    Splitter: TSplitter;
    PLeft: TPanel;
    PCaptionLeft: TPanel;
    PRight: TPanel;
    PCaptionRight: TPanel;
    TBCompare: TToolButton;
    TBSourcecode: TToolButton;
    TBClose: TToolButton;
    TBIgnoreCase: TToolButton;
    TBIgnoreBlanks: TToolButton;
    TBParagraph: TToolButton;
    PopUpEditor: TSpTBXPopupMenu;
    MIClose: TSpTBXItem;
    MIPaste: TSpTBXItem;
    MICopy: TSpTBXItem;
    MICut: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIRedo: TSpTBXItem;
    MIUndo: TSpTBXItem;
    StatusBar: TSpTBXStatusBar;
    liLineColumn: TSpTBXLabelItem;
    liModifiedProtected: TSpTBXLabelItem;
    liInsOvr: TSpTBXLabelItem;
    liEncoding: TSpTBXLabelItem;
    liAdded: TSpTBXLabelItem;
    liModified: TSpTBXLabelItem;
    liDeleted: TSpTBXLabelItem;
    liDifferences: TSpTBXLabelItem;
    vilTextDiffLight: TVirtualImageList;
    vilTextDiffDark: TVirtualImageList;
    icTextDiff: TSVGIconImageCollection;
    TBZoomOut: TToolButton;
    TBZoomIn: TToolButton;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MIOpenFile: TSpTBXItem;
    procedure FormCreate(Sender: TObject); override;
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;

    procedure NextClick(Sender: TObject);
    procedure PrevClick(Sender: TObject);
    procedure CopyBlockLeftClick(Sender: TObject);
    procedure CopyBlockRightClick(Sender: TObject);
    procedure TBDiffsOnlyClick(Sender: TObject);
    procedure TBCompareClick(Sender: TObject);
    procedure TBSourcecodeClick(Sender: TObject);
    procedure TBCloseClick(Sender: TObject);
    procedure TBIgnoreCaseClick(Sender: TObject);
    procedure TBIgnoreBlanksClick(Sender: TObject);
    procedure TBParagraphClick(Sender: TObject);
    procedure SplitterMoved(Sender: TObject);
    procedure HorzSplitClick(Sender: TObject);
    procedure MICutClick(Sender: TObject);
    procedure MICopyClick(Sender: TObject);
    procedure MIPasteClick(Sender: TObject);
    procedure MICloseClick(Sender: TObject);
    procedure MIUndoClick(Sender: TObject);
    procedure MIRedoClick(Sender: TObject);
    procedure liDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      ItemInfo: TSpTBXMenuItemInfo; const PaintStage: TSpTBXPaintStage;
      var PaintDefault: Boolean);
    procedure MIOpenFileClick(Sender: TObject);
    procedure PopUpEditorPopup(Sender: TObject);
    procedure TBZoomOutClick(Sender: TObject);
    procedure TBZoomInClick(Sender: TObject);
  private
    FDiff: TDiff;
    FActiveSynEdit: TSynEdit;
    FLines1, FLines2: TSynEditStringList;
    FAddClr, FDelClr, FModClr, FDefaultClr: TColor;
    FCodeEdit1: TSynEditExDiff;
    FCodeEdit2: TSynEditExDiff;
    FFilesCompared: Boolean;
    FOnlyDifferences: Boolean;
    FIgnoreBlanks: Boolean;
    FIgnoreCase: Boolean;
    FNumber: Integer;
    procedure DoCompare;
    procedure DoSaveFile(Num: Integer); reintroduce;
    procedure DoLoadFile(const Filename: string; Num: Integer);
    procedure ChooseFiles(EditForm: TEditorForm);
    procedure DisplayDiffs;
    procedure SynEditEnter(Sender: TObject);
    procedure SynEditExit(Sender: TObject);
    procedure LinkScroll(IsLinked: Boolean);

    procedure Undo;
    procedure Redo;
    procedure DoSaveBoth;
    procedure ShowFilenames;
    procedure SetFilesCompared(Value: Boolean);
    function IsEmpty: Boolean;
    function GetCodeEdit: TSynEditExDiff;
    procedure ChangeStyle;

    // ISearchCommands implementation
    function CanFind: Boolean;
    function CanFindNext: Boolean;
    function ISearchCommands.CanFindPrev = CanFindNext;
    function CanReplace: Boolean;
    function GetSearchTarget: TSynEdit;
    procedure ExecFind;
    procedure ExecFindNext;
    procedure ExecFindPrev;
    procedure ExecReplace;
  protected
    procedure SetFont(Font: TFont); override;
    procedure SetFontSize(Delta: Integer); override;
    procedure CutToClipboard;
    procedure CopyToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure Retranslate; override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    procedure New(EditForm1, EditForm2: TEditorForm);
    procedure Open(const Filename: string); overload;
    procedure Open(const Filename1, Filename2: string); overload;
    procedure ShowDiffState;
    procedure Save;
    procedure SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
    procedure DPIChanged; override;

    property FilesCompared: Boolean read FFilesCompared;
    property Number: Integer read FNumber write FNumber;
  end;

implementation

uses
  SysUtils,
  Themes,
  Dialogs,
  SynEditTypes,
  JvGnugettext,
  uCommonFunctions,
  frmPyIDEMain,
  cPyScripterSettings,
  StringResources,
  dmCommands,
  dmResources,
  UConfiguration,
  UUtils,
  UHashUnit;

{$R *.DFM}

procedure TFTextDiff.FormCreate(Sender: TObject);
var
  State: string;
begin
  inherited;
  State := GuiPyOptions.TextDiffState;
  FIgnoreCase := GuiPyOptions.TextDiffIgnoreCase;
  FIgnoreBlanks := GuiPyOptions.TextDiffIgnoreBlanks;
  TBIgnoreCase.Down := FIgnoreCase;
  TBIgnoreBlanks.Down := FIgnoreBlanks;
  SetState(State);

  // the FDiff engine ...
  FDiff := TDiff.Create(Self);

  // FLines1 & FLines2 contain the unmodified files
  FLines1 := TSynEditStringList.Create(nil);
  FLines2 := TSynEditStringList.Create(nil);

  // edit windows where color highlighing of diffs and changes are displayed ...
  FCodeEdit1 := TSynEditExDiff.Create(Self);
  with FCodeEdit1 do
  begin
    FNumber := 1;
    Parent := PLeft;
    Align := alClient;
    PCaption := PCaptionLeft;
    PopupMenu := PopUpEditor;
    OnEnter := SynEditEnter;
    OnExit := SynEditExit;
    Gutter.Font.Assign(FConfiguration.Font);
    Gutter.Font.Height := Font.Height + 2;
    Gutter.ShowLineNumbers := True;
    Gutter.DigitCount := 0;
    Gutter.AutoSize := True;
    Highlighter := ResourcesDataModule.Highlighters.
      HighlighterFromFileExt('.py');
  end;
  FCodeEdit1.Assign(GEditorOptions);
  FCodeEdit2 := TSynEditExDiff.Create(Self);
  with FCodeEdit2 do
  begin
    FNumber := 2;
    Parent := PRight;
    Align := alClient;
    PCaption := PCaptionRight;
    PopupMenu := PopUpEditor;
    OnEnter := SynEditEnter;
    OnExit := SynEditExit;
    Gutter.Font.Assign(FConfiguration.Font);
    Gutter.Font.Height := Font.Height + 2;
    Gutter.ShowLineNumbers := True;
    Gutter.DigitCount := 0;
    Gutter.AutoSize := True;
    Highlighter := ResourcesDataModule.Highlighters.
      HighlighterFromFileExt('.py');
  end;
  FCodeEdit2.Assign(GEditorOptions);
  FNumber := 1;
  OnClose := FormClose;
  FOnlyDifferences := False;
  SetFont(GEditorOptions.Font);
  TBCopyBlockLeft.Hint := _('Copy block left');
  TBCopyBlockRight.Hint := _('Copy block right');
  ChangeStyle;
end;

procedure TFTextDiff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDiff.Free;
  FCodeEdit1.Free;
  FCodeEdit2.Free;
  FLines1.Free;
  FLines2.Free;
  Action := caFree;
  inherited;
end;

procedure TFTextDiff.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  GuiPyOptions.TextDiffState := GetState;
  GuiPyOptions.TextDiffIgnoreCase := FIgnoreCase;
  GuiPyOptions.TextDiffIgnoreBlanks := FIgnoreBlanks;
  if FOnlyDifferences then
    TBDiffsOnlyClick(Self);
  DoSaveBoth;
  CanClose := True;
end;

procedure TFTextDiff.New(EditForm1, EditForm2: TEditorForm);
begin
  Pathname := Caption;
  if Assigned(EditForm1) and Assigned(EditForm2) then
    Open(EditForm1.Pathname, EditForm2.Pathname)
  else
  begin
    if Assigned(EditForm1) then
      Open(EditForm1.Pathname);
    ChooseFiles(EditForm1);
  end;
  DoCompare;
  DoActivateFile;
end;

procedure TFTextDiff.SynEditEnter(Sender: TObject);
begin
  GI_SearchCmds := Self;
  FActiveSynEdit := Sender as TSynEdit;
  FNumber := (FActiveSynEdit as TSynEditExDiff).Number;
  TBCopyBlockLeft.Hint := _('Copy block left');
  TBCopyBlockRight.Hint := _('Copy block right');
  EditorSearchOptions.TextDiffIsSearchTarget := True;
  EditorSearchOptions.InterpreterIsSearchTarget := False;
  DoAssignInterfacePointer(True);
end;

procedure TFTextDiff.SynEditExit(Sender: TObject);
begin
  GI_SearchCmds := nil;
  PyIDEMainForm.mnEditCopy.Action := CommandsDataModule.actEditCopy;
  PyIDEMainForm.mnEditPaste.Action := CommandsDataModule.actEditPaste;
  DoAssignInterfacePointer(False);
end;

procedure TFTextDiff.TBDiffsOnlyClick(Sender: TObject);
var
  CodeEdit: TSynEditExDiff;
  Caret: TBufferCoord;
begin
  if FOnlyDifferences then
  begin
    FOnlyDifferences := False;
    FCodeEdit1.ReadOnly := False;
    FCodeEdit2.ReadOnly := False;
    FCodeEdit1.Gutter.AutoSize := True;
    FCodeEdit2.Gutter.AutoSize := True;
    TBCopyBlockLeft.Enabled := True;
    TBCopyBlockRight.Enabled := True;
    CodeEdit := GetCodeEdit;
    Caret := CodeEdit.CaretXY;
    if Caret.Line - 1 > 0 then
      Caret.Line := CodeEdit.GetLineObj(Caret.Line - 1).Tag;
    DisplayDiffs;
    CodeEdit.CaretXY := Caret;
    SyncScroll(GetCodeEdit, sbVertical);
  end
  else
  begin
    DoSaveBoth;
    if not FFilesCompared then
      DoCompare;
    if FFilesCompared then
    begin
      FOnlyDifferences := True;
      FCodeEdit1.Gutter.AutoSize := False;
      FCodeEdit2.Gutter.AutoSize := False;
      DisplayDiffs;
      FCodeEdit1.ReadOnly := True;
      FCodeEdit2.ReadOnly := True;
      TBCopyBlockLeft.Enabled := False;
      TBCopyBlockRight.Enabled := False;
    end;
  end;
end;

procedure TFTextDiff.Save;
begin
  DoSaveFile(GetCodeEdit.Number);
end;

procedure TFTextDiff.Open(const Filename: string);
begin
  DoLoadFile(Filename, FNumber);
end;

procedure TFTextDiff.DoLoadFile(const Filename: string; Num: Integer);
begin
  if FOnlyDifferences then
    TBDiffsOnlyClick(Self);
  SetFilesCompared(False);
  LinkScroll(False);
  if Num = 1 then
    FCodeEdit1.Load(FLines1, Filename)
  else
    FCodeEdit2.Load(FLines2, Filename);
end;

procedure TFTextDiff.Open(const Filename1, Filename2: string);
begin
  if FOnlyDifferences then
    TBDiffsOnlyClick(Self);
  SetFilesCompared(False);
  LinkScroll(False);
  FCodeEdit1.Load(FLines1, Filename1);
  FCodeEdit2.Load(FLines2, Filename2);
  DoCompare;
end;

procedure TFTextDiff.HorzSplitClick(Sender: TObject);
begin
  TBView.ImageIndex := 3 - TBView.ImageIndex;
  if TBView.ImageIndex = 2 then
  begin
    PLeft.Align := alTop;
    PLeft.Height := PMain.ClientHeight div 2 - 1;
    Splitter.Align := alTop;
    Splitter.Cursor := crVSplit;
    TBCopyBlockLeft.Hint := _('Copy block up');
    TBCopyBlockLeft.ImageIndex := 10;
    TBCopyBlockRight.Hint := _('Copy block down');
    TBCopyBlockRight.ImageIndex := 11;
  end
  else
  begin
    PLeft.Align := alLeft;
    PLeft.Width := PMain.ClientWidth div 2 - 1;
    Splitter.Align := alLeft;
    Splitter.Left := 10;
    Splitter.Cursor := crHSplit;
    TBCopyBlockLeft.Hint := _('Copy block left');
    TBCopyBlockLeft.ImageIndex := 8;
    TBCopyBlockRight.Hint := _('Copy block right');
    TBCopyBlockRight.ImageIndex := 9;
  end;
  FCodeEdit1.ShowFilename;
  GetCodeEdit.EnsureCursorPosVisible;
  SyncScroll(GetCodeEdit, sbVertical);
end;

procedure TFTextDiff.DoCompare;
var
  HashArray1, HashArray2: TArrOfInteger;
  CodeEdit: TSynEditExDiff;
  Caret: TBufferCoord;
begin
  if (FLines1.Count = 0) or (FLines2.Count = 0) then
    Exit;

  CodeEdit := GetCodeEdit;
  Caret := CodeEdit.CaretXY;

  if FCodeEdit1.Modified or FCodeEdit2.Modified then
    DoSaveBoth;

  FCodeEdit1.Color := FDefaultClr;
  FCodeEdit2.Color := FDefaultClr;

  // THIS PROCEDURE IS WHERE ALL THE HEAVY LIFTING (COMPARING) HAPPENS ...

  // Because it's SO MUCH EASIER AND FASTER comparing hashes (integers) than
  // comparing whole lines of text, we'll build an array of hashes for each line
  // in the source files. Each line is represented by a (virtually) unique
  // hash that is based on the contents of that line. Also, since the
  // likelihood of 2 different lines generating the same hash is so small,
  // we can safely ignore that possibility.

  try
    Screen.Cursor := crHourGlass;
    SetLength(HashArray1, FLines1.Count);
    SetLength(HashArray2, FLines2.Count);
    for var I := 0 to FLines1.Count - 1 do
      HashArray1[I] := HashLine(FLines1[I], FIgnoreCase, FIgnoreBlanks);
    for var I := 0 to FLines2.Count - 1 do
      HashArray2[I] := HashLine(FLines2[I], FIgnoreCase, FIgnoreBlanks);
    // CALCULATE THE DIFFS HERE ...
    if not FDiff.Execute(HashArray1, HashArray2, FLines1.Count, FLines2.Count)
    then
      Exit;

    SetFilesCompared(True);
    DisplayDiffs;
    LinkScroll(True);
    CodeEdit.CaretXY := Caret;
    SyncScroll(GetCodeEdit, sbVertical);
  finally
    Screen.Cursor := crDefault;
    HashArray1 := nil;
    HashArray2 := nil;
  end;
end;

procedure TFTextDiff.DisplayDiffs;

  procedure AddAndFormat(CodeEdit: TSynEditExDiff; const Text: string;
    Color: TColor; Num: LongInt);
  var
    LineObject: TLineObj;
  begin
    var Count := CodeEdit.Lines.Count;
    LineObject := TLineObj.Create;
    LineObject.Spezial := Color <> FDefaultClr;
    LineObject.BackClr := Color;
    LineObject.Tag := Num;
    CodeEdit.InsertItem(Count, Text, LineObject);
  end;

begin
  // THIS IS WHERE THE TDIFF Result IS CONVERTED INTO COLOR HIGHLIGHTING ...
  FCodeEdit1.Lines.BeginUpdate;
  FCodeEdit2.Lines.BeginUpdate;
  try
    FCodeEdit1.LinesClearAll;
    FCodeEdit2.LinesClearAll;
    FCodeEdit1.OnSpecialLineColors := FCodeEdit1.SynEditorSpecialLineColors;
    FCodeEdit2.OnSpecialLineColors := FCodeEdit2.SynEditorSpecialLineColors;

    FCodeEdit1.OnGutterGetText := FCodeEdit1.GutterTextEvent;
    FCodeEdit2.OnGutterGetText := FCodeEdit2.GutterTextEvent;

    for var I := 0 to FDiff.Count - 1 do
      with FDiff[I] do
        if Kind = ckAdd then
        begin
          AddAndFormat(FCodeEdit1, '', FAddClr, 0);
          AddAndFormat(FCodeEdit2, FLines2[OldIndex2], FAddClr, OldIndex2 + 1);
        end
        else if Kind = ckDelete then
        begin
          AddAndFormat(FCodeEdit1, FLines1[OldIndex1], FDelClr, OldIndex1 + 1);
          AddAndFormat(FCodeEdit2, '', FDelClr, 0);
        end
        else if Kind = ckModify then
        begin
          AddAndFormat(FCodeEdit1, FLines1[OldIndex1], FModClr, OldIndex1 + 1);
          AddAndFormat(FCodeEdit2, FLines2[OldIndex2], FModClr, OldIndex2 + 1);
        end
        else if not FOnlyDifferences then
        begin
          AddAndFormat(FCodeEdit1, FLines1[OldIndex1], FDefaultClr,
            OldIndex1 + 1);
          AddAndFormat(FCodeEdit2, FLines2[OldIndex2], FDefaultClr,
            OldIndex2 + 1);
        end;
    FCodeEdit1.SetModified(False);
    FCodeEdit2.SetModified(False);
  finally
    FCodeEdit1.Lines.EndUpdate;
    FCodeEdit2.Lines.EndUpdate;
  end;
  with FDiff.DiffStats do
    if adds + modifies + deletes = 0 then
    begin
      FCodeEdit1.WithColoredLines := False;
      FCodeEdit2.WithColoredLines := False;
    end
    else
    begin
      FCodeEdit1.WithColoredLines := True;
      FCodeEdit2.WithColoredLines := True;
    end;
  FCodeEdit1.ClearUndo;
  FCodeEdit2.ClearUndo;
  ShowDiffState;
end;

procedure TFTextDiff.ShowDiffState;
begin
  liAdded.Caption := Format(' ' + _('%d lines added') + ' ',
    [FDiff.DiffStats.adds]);
  liModified.Caption := Format(' ' + _('%d lines modified') + ' ',
    [FDiff.DiffStats.modifies]);
  liDeleted.Caption := Format(' ' + _('%d lines deleted') + ' ',
    [FDiff.DiffStats.deletes]);
  with FDiff.DiffStats do
    if adds + modifies + deletes = 0 then
      liDifferences.Caption := _('No differences.')
    else
      liDifferences.Caption := '';
end;

// Syncronise scrolling of both CodeEdits (once files are compared)...
var
  IsSyncing: Boolean;

procedure TFTextDiff.SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
begin
  var Str := Sender.ClassName;
  if IsSyncing or not(FCodeEdit1.WithColoredLines and
    FCodeEdit2.WithColoredLines) then
    Exit;
  IsSyncing := True; // stops recursion
  try
    if Sender = FCodeEdit1 then
      FCodeEdit2.TopLine := FCodeEdit1.TopLine
    else
      FCodeEdit1.TopLine := FCodeEdit2.TopLine;
    //FCodeEdit1.UpdateScrollBars;
    //FCodeEdit2.UpdateScrollBars;
  finally
    IsSyncing := False;
  end;
end;

procedure TFTextDiff.ShowFilenames;
begin
  FCodeEdit1.ShowFilename;
  FCodeEdit2.ShowFilename;
end;

procedure TFTextDiff.LinkScroll(IsLinked: Boolean);
begin
  if IsLinked then
  begin
    FCodeEdit1.OnScroll := FCodeEdit1.SyncScroll;
    FCodeEdit2.OnScroll := FCodeEdit2.SyncScroll;
    SyncScroll(GetCodeEdit, sbVertical);
  end
  else
  begin
    FCodeEdit1.OnScroll := nil;
    FCodeEdit2.OnScroll := nil;
  end;
end;

// go to next color block (only enabled if files have been compared)
procedure TFTextDiff.NextClick(Sender: TObject);
begin
  // get next colored block ...
  with GetCodeEdit do
  begin
    if (Lines.Count = 0) or not WithColoredLines then
      Exit;
    var Int := CaretY - 1;
    var Clr := GetLineObj(Int).BackClr;
    repeat
      Inc(Int);
    until (Int = Lines.Count) or (GetLineObj(Int).BackClr <> Clr);

    if (Int <> Lines.Count) and (GetLineObj(Int).BackClr = Color) then
      repeat
        Inc(Int);
      until (Int = Lines.Count) or (GetLineObj(Int).BackClr <> Color);

    if Int = Lines.Count then
    begin
      Beep; // not found
      Exit;
    end;
    CaretY := Int + 1;
    // now make sure as much of the block as possible is visible ...
    Clr := GetLineObj(Int).BackClr;
    repeat
      Inc(Int);
    until (Int = Lines.Count) or (GetLineObj(Int).BackClr <> Clr);
    if Int >= TopLine + LinesInWindow then
    begin
      TopLine := CaretY;
      SyncScroll(GetCodeEdit, sbVertical);
    end;
  end;
end;

// go to previous color block (only enabled if files have been compared)
procedure TFTextDiff.PrevClick(Sender: TObject);
begin
  // get prev colored block ...
  with GetCodeEdit do
  begin
    if not WithColoredLines then
      Exit;
    var Int := CaretY - 1;
    if Int = Lines.Count then
    begin
      Beep;
      Exit;
    end;
    var Clr := GetLineObj(Int).BackClr;
    repeat
      Dec(Int);
    until (Int < 0) or (GetLineObj(Int).BackClr <> Clr);
    if Int < 0 then
    begin
      Beep;
      Exit;
    end;
    if GetLineObj(Int).BackClr = Color then
      repeat
        Dec(Int);
      until (Int < 0) or (GetLineObj(Int).BackClr <> Color);
    if Int < 0 then
      Beep
    else
    begin
      Clr := GetLineObj(Int).BackClr;
      while (Int > 0) and (GetLineObj(Int - 1).BackClr = Clr) do
        Dec(Int);
      // 'Int' now at the beginning of the previous color block.
      CaretY := Int + 1;
      SyncScroll(GetCodeEdit, sbVertical);
    end;
  end;
end;

procedure TFTextDiff.CopyBlockRightClick(Sender: TObject);
var
  From, Till: Integer;
  EmptyClipboard: Boolean;
  Clr: TColor;
  LinObj: TLineObj;
begin
  if (MyActiveControl <> FCodeEdit1) or FOnlyDifferences or not FFilesCompared
  then
    Exit;
  with FCodeEdit1 do
  begin
    if Lines.Count = 0 then
      Exit;
    From := CaretY - 1;
    Clr := GetLineObj(From).BackClr;
    if Clr = Color then
      Exit; // we're not in a colored block !!!
    Till := From;
    while (From > 0) and (GetLineObj(From - 1).BackClr = Clr) do
      Dec(From);
    while (Till < Lines.Count - 1) and (GetLineObj(Till + 1).BackClr = Clr) do
      Inc(Till);
    // make sure color blocks still match up ...
    if (Till > FCodeEdit2.Lines.Count - 1) or
      (FCodeEdit2.GetLineObj(From).BackClr <> Clr) or
      (FCodeEdit2.GetLineObj(Till).BackClr <> Clr) then
      Exit;
    EmptyClipboard := CopyIntoClipboard(From, Till);
    LinObj := GetLineObj(From);
  end;
  FCodeEdit2.PasteClipboard(EmptyClipboard, From, Till, LinObj.Tag);
  SyncScroll(FCodeEdit1, sbVertical);
  FCodeEdit1.Enter(Self);
end;

procedure TFTextDiff.CopyBlockLeftClick(Sender: TObject);
var
  From, Till: Integer;
  EmptyClipboard: Boolean;
  Clr: TColor;
  LinObj: TLineObj;
begin
  if (MyActiveControl <> FCodeEdit2) or FOnlyDifferences or not FFilesCompared
  then
    Exit;
  with FCodeEdit2 do
  begin
    if Lines.Count = 0 then
      Exit;
    From := CaretY - 1;
    Clr := GetLineObj(From).BackClr;
    if Clr = Color then
      Exit; // we're not in a colored block !!!
    Till := From;
    while (From > 0) and (GetLineObj(From - 1).BackClr = Clr) do
      Dec(From);
    while (Till < Lines.Count - 1) and (GetLineObj(Till + 1).BackClr = Clr) do
      Inc(Till);
    // make sure color blocks still match up ...
    if (Till > FCodeEdit1.Lines.Count - 1) or
      (FCodeEdit1.GetLineObj(From).BackClr <> Clr) or
      (FCodeEdit1.GetLineObj(Till).BackClr <> Clr) then
      Exit;
    EmptyClipboard := CopyIntoClipboard(From, Till);
    LinObj := GetLineObj(From);
  end;
  FCodeEdit1.PasteClipboard(EmptyClipboard, From, Till, LinObj.Tag);
  SyncScroll(FCodeEdit2, sbVertical);
  FCodeEdit2.Enter(Self);
end;

procedure TFTextDiff.MIUndoClick(Sender: TObject);
begin
  Undo;
end;

procedure TFTextDiff.MIRedoClick(Sender: TObject);
begin
  Redo;
end;

procedure TFTextDiff.MICutClick(Sender: TObject);
begin
  CutToClipboard;
end;

procedure TFTextDiff.MICopyClick(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TFTextDiff.MIPasteClick(Sender: TObject);
begin
  PasteFromClipboard;
end;

procedure TFTextDiff.MICloseClick(Sender: TObject);
begin
  (MyFile as IFileCommands).ExecClose;
end;

procedure TFTextDiff.Undo;
begin
  GetCodeEdit.DoUndo;
end;

procedure TFTextDiff.Redo;
begin
  GetCodeEdit.DoRedo;
end;

procedure TFTextDiff.CutToClipboard;
begin
  GetCodeEdit.CutToClipboard;
end;

procedure TFTextDiff.CopyToClipboard;
begin
  GetCodeEdit.CopyToClipboard;
end;

procedure TFTextDiff.PasteFromClipboard;
begin
  with GetCodeEdit do
  begin
    PasteFromClipboard;
    CreateObjects;
  end;
end;

procedure TFTextDiff.SetFont(Font: TFont);
begin
  FCodeEdit1.Font.Assign(Font);
  FCodeEdit2.Font.Assign(Font);
  SetFontSize(0);
end;

procedure TFTextDiff.SetFontSize(Delta: Integer);
begin
  var Size := FCodeEdit1.Font.Size + Delta;
  if Size < 6 then
    Size := 6;
  FCodeEdit1.Font.Size := Size;
  FCodeEdit2.Font.Size := Size;
  FCodeEdit1.Gutter.Font.Size := Size;
  FCodeEdit2.Gutter.Font.Size := Size;
  ShowFilenames;
end;

procedure TFTextDiff.FormResize(Sender: TObject);
begin
  if TBView.Marked then
    PLeft.Height := PMain.ClientHeight div 2 - 1
  else
    PLeft.Width := PMain.ClientWidth div 2 - 1;
end;

procedure TFTextDiff.TBCompareClick(Sender: TObject);
begin
  if FOnlyDifferences then
    TBDiffsOnlyClick(Self);
  DoCompare;
end;

procedure TFTextDiff.DoSaveFile(Num: Integer);
var
  CodeEdit: TSynEditExDiff;
begin
  if Num = 1 then
    CodeEdit := FCodeEdit1
  else
    CodeEdit := FCodeEdit2;
  if (CodeEdit.Pathname = '') or FOnlyDifferences then
    Exit;
  CodeEdit.Save;
  if Num = 1 then
    FLines1.Assign(CodeEdit.Lines)
  else
    FLines2.Assign(CodeEdit.Lines);
  SetFilesCompared(False);
end;

procedure TFTextDiff.DoSaveBoth;
begin
  DoSaveFile(1);
  DoSaveFile(2);
end;

procedure TFTextDiff.TBSourcecodeClick(Sender: TObject);
var
  CodeEdit: TSynEditExDiff;
  Caret: TBufferCoord;
begin
  if FOnlyDifferences then
    TBDiffsOnlyClick(Self);
  CodeEdit := GetCodeEdit;
  Caret := CodeEdit.CaretXY;
  DoSaveFile(1);
  DoSaveFile(2);
  CodeEdit.CaretXY := Caret;
  //SetActiveControl(CodeEdit);
  SyncScroll(GetCodeEdit, sbVertical);
end;

procedure TFTextDiff.TBZoomInClick(Sender: TObject);
begin
  SetFontSize(+1);
end;

procedure TFTextDiff.TBZoomOutClick(Sender: TObject);
begin
  SetFontSize(-1);
end;

procedure TFTextDiff.SetFilesCompared(Value: Boolean);
begin
  FFilesCompared := Value;
end;

procedure TFTextDiff.TBCloseClick(Sender: TObject);
begin
  (MyFile as IFileCommands).ExecClose;
end;

function TFTextDiff.GetCodeEdit: TSynEditExDiff;
begin
  if MyActiveControl = FCodeEdit1 then
    Result := FCodeEdit1
  else
    Result := FCodeEdit2;
end;

procedure TFTextDiff.SplitterMoved(Sender: TObject);
begin
  ShowFilenames;
end;

procedure TFTextDiff.TBIgnoreCaseClick(Sender: TObject);
begin
  FIgnoreCase := not FIgnoreCase;
  TBIgnoreCase.Down := FIgnoreCase;
  if FFilesCompared then
    TBCompareClick(Self);
end;

procedure TFTextDiff.TBIgnoreBlanksClick(Sender: TObject);
begin
  FIgnoreBlanks := not FIgnoreBlanks;
  TBIgnoreBlanks.Down := FIgnoreBlanks;
  if FFilesCompared then
    TBCompareClick(Self);
end;

procedure TFTextDiff.TBParagraphClick(Sender: TObject);
begin
  var
  VisibleSpecialChars := FCodeEdit1.VisibleSpecialChars;
  if VisibleSpecialChars = [] then
    FCodeEdit1.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    FCodeEdit1.VisibleSpecialChars := [];
  VisibleSpecialChars := FCodeEdit2.VisibleSpecialChars;
  if VisibleSpecialChars = [] then
    FCodeEdit2.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    FCodeEdit2.VisibleSpecialChars := [];
  TBParagraph.Down := not(FCodeEdit1.VisibleSpecialChars = []);
end;

procedure TFTextDiff.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFTextDiff.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
  begin
    FAddClr := $97734F;
    FModClr := $16A231;
    FDelClr := $621EA6;
    FDefaultClr := StyleServices.GetSystemColor(clWindow);
    TBTextDiff.Images := vilTextDiffDark;
  end
  else
  begin
    FAddClr := $F0CCA8;
    FModClr := $6FFB8A;
    FDelClr := $BB77FF;
    FDefaultClr := clWindow;
    TBTextDiff.Images := vilTextDiffLight;
  end;
  PyIDEMainForm.ThemeEditorGutter(FCodeEdit1.Gutter);
  FCodeEdit1.InvalidateGutter;
  FCodeEdit1.CodeFolding.FolderBarLinesColor := FCodeEdit1.Gutter.Font.Color;

  PyIDEMainForm.ThemeEditorGutter(FCodeEdit2.Gutter);
  FCodeEdit2.CodeFolding.FolderBarLinesColor := FCodeEdit2.Gutter.Font.Color;
  FCodeEdit2.InvalidateGutter;
  FCodeEdit1.ChangeStyle;
  FCodeEdit2.ChangeStyle;
  Invalidate;
end;

procedure TFTextDiff.ChooseFiles(EditForm: TEditorForm);

  procedure InitDir;
  begin
    with ResourcesDataModule.dlgFileOpen do
    begin
      InitialDir := GuiPyOptions.Sourcepath;
      if not SysUtils.DirectoryExists(InitialDir) then
        InitialDir := GetDocumentsPath;
    end;
  end;

begin
  with ResourcesDataModule.dlgFileOpen do
  begin
    if Assigned(EditForm) then
    begin
      InitialDir := ExtractFilePath(EditForm.Pathname);
      FNumber := 2;
    end
    else
    begin
      InitDir;
      FNumber := 1;
    end;
    FileName := '';
    var TempFilter := Filter;
    Filter := 'Python (*.py;*.pyw)|*.py;*.pyw|HTML (*.html)|*.html;*.htm|Text (*.txt)|*.txt|'
      + _(LNGAll) + ' (*.*)|*.*';
    FilterIndex := 1;
    Title := _(SOpenFile);
    Options := Options + [ofAllowMultiSelect];
    try
      if Execute then
      begin
        GuiPyOptions.Sourcepath := ExtractFilePath(FileName);
        if Files.Count >= 2 then
          Open(Files[0], Files[1])
        else
          Open(FileName);
      end;
    finally
      Filter := TempFilter;
      Options := Options - [ofAllowMultiSelect];
    end;
  end;
end;

procedure TFTextDiff.Retranslate;
begin
  inherited;
  ShowDiffState;
end;

function TFTextDiff.IsEmpty: Boolean;
begin
  Result := (FActiveSynEdit.Lines.Count = 0) or
    ((FActiveSynEdit.Lines.Count = 1) and (FActiveSynEdit.Lines[0] = ''));
end;

procedure TFTextDiff.liDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
  ItemInfo: TSpTBXMenuItemInfo; const PaintStage: TSpTBXPaintStage;
  var PaintDefault: Boolean);
begin
  if PaintStage = pstPrePaint then
  begin
    PaintDefault := False;
    var
    Color := clBtnFace;
    case (Sender as TSpTBXLabelItem).Tag of
      1:
        Color := FAddClr;
      2:
        Color := FModClr;
      3:
        Color := FDelClr;
    end;
    ACanvas.Brush.Color := Color;
    ACanvas.Pen.Color := Color;
    ACanvas.Rectangle(ARect);
  end;
end;

function TFTextDiff.CanFind: Boolean;
begin
  Result := not IsEmpty;
end;

function TFTextDiff.CanFindNext: Boolean;
begin
  Result := not IsEmpty and (EditorSearchOptions.SearchText <> '');
end;

function TFTextDiff.CanReplace: Boolean;
begin
  Result := not IsEmpty;
end;

procedure TFTextDiff.ExecFind;
begin
  CommandsDataModule.ShowSearchReplaceDialog(FActiveSynEdit, False);
end;

procedure TFTextDiff.ExecFindNext;
begin
  CommandsDataModule.DoSearchReplaceText(FActiveSynEdit, False, False);
end;

procedure TFTextDiff.ExecFindPrev;
begin
  CommandsDataModule.DoSearchReplaceText(FActiveSynEdit, False, True);
end;

procedure TFTextDiff.ExecReplace;
begin
  CommandsDataModule.ShowSearchReplaceDialog(FActiveSynEdit, True);
end;

function TFTextDiff.GetSearchTarget: TSynEdit;
begin
  Result := FActiveSynEdit;
end;

procedure TFTextDiff.DPIChanged;
begin
  SetFontSize(0);
end;

procedure TFTextDiff.MIOpenFileClick(Sender: TObject);
begin
  PyIDEMainForm.actFileOpenExecute(Sender);
  DoCompare;
end;

procedure TFTextDiff.PopUpEditorPopup(Sender: TObject);
begin
  if PopUpEditor.PopupComponent = FCodeEdit1 then
    FNumber := 1;
  if PopUpEditor.PopupComponent = FCodeEdit2 then
    FNumber := 2;
end;

end.
