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
//                  © 2006-2024 Gerhard Röhner                                  .
// -----------------------------------------------------------------------------

interface

uses
  Windows, Messages, Graphics, Controls, Forms, ExtCtrls, ComCtrls,
  frmFile, UDiff, USynEditExDiff, SynEditTextBuffer,
  ToolWin, SpTBXSkins, SynEdit, uEditAppIntfs, frmEditor,
  TB2Item, SpTBXItem, Vcl.Menus, System.ImageList, Vcl.ImgList, System.Classes,
  Vcl.BaseImageCollection, SVGIconImageCollection, Vcl.VirtualImageList;

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
    procedure TBZoomOutClick(Sender: TObject);
    procedure TBZoomInClick(Sender: TObject);
  private
    Diff: TDiff;
    fActiveSynEdit: TSynEdit;
    Lines1, Lines2: TSynEditStringList;
    addClr, delClr, modClr, DefaultClr: TColor;
    CodeEdit1: TSynEditExDiff;
    CodeEdit2: TSynEditExDiff;
    OnlyDifferences: Boolean;
    IgnoreBlanks: Boolean;
    IgnoreCase: Boolean;
    procedure DoCompare;
    procedure DoSaveFile(Nr: Integer); reintroduce;
    procedure DoLoadFile(const FileName: string; Nr: Integer);
    procedure ChooseFiles(F1: TEditorForm);
    procedure DisplayDiffs;
    procedure SynEditEnter(Sender: TObject);
    procedure SynEditExit(Sender: TObject);
    procedure LinkScroll(IsLinked: Boolean);

    procedure Undo;
    procedure Redo;
    procedure DoSaveBoth;
    procedure ShowFilenames;
    procedure SetFilesCompared(Value: Boolean);
    function IsEmpty : Boolean;
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
    procedure SetFont(aFont: TFont); override;
    procedure SetFontSize(Delta: Integer); override;
    procedure CutToClipboard;
    procedure CopyToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure Retranslate; override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    Nr: Integer;
    FilesCompared: Boolean;
    procedure New(F1, F2: TEditorForm);
    procedure Open(const FileName: string); overload;
    procedure Open(const Filename1, Filename2: string); overload;
    procedure ShowDiffState;
    procedure Save;
    procedure SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
    procedure DPIChanged; override;
  end;

implementation

uses SysUtils,
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
  var State: string;
begin
  inherited;
  State       := GuiPyOptions.TextDiffState;
  IgnoreCase  := GuiPyOptions.TextDiffIgnoreCase;
  IgnoreBlanks:= GuiPyOptions.TextDiffIgnoreBlanks;
  TBIgnoreCase.Down:= IgnoreCase;
  TBIgnoreBlanks.Down:= IgnoreBlanks;
  SetState(State);

  //the diff engine ...
  Diff:= TDiff.Create(Self);

  //lines1 & lines2 contain the unmodified files
  Lines1:= TSynEditStringList.Create(nil);
  Lines2:= TSynEditStringList.Create(nil);

  //edit windows where color highlighing of diffs and changes are displayed ...
  CodeEdit1:= TSynEditExDiff.Create(Self);
  with CodeEdit1 do begin
    Nr:= 1;
    Parent:= PLeft;
    Align:= alClient;
    PCaption:= PCaptionLeft;
    PopupMenu:= PopUpEditor;
    onEnter:= SynEditEnter;
    onExit:= SynEditExit;
    Gutter.Font.Assign(FConfiguration.Font);
    Gutter.Font.Height:= Font.Height + 2;
    Gutter.ShowLineNumbers:= True;
    Gutter.DigitCount:= 0;
    Gutter.Autosize:= True;
    Highlighter:= ResourcesDataModule.Highlighters.HighlighterFromFileExt('.py');
  end;
  CodeEdit1.Assign(EditorOptions);
  CodeEdit2:= TSynEditExDiff.Create(Self);
  with CodeEdit2 do begin
    Nr:= 2;
    Parent:= PRight;
    Align:= alClient;
    PCaption:= PCaptionRight;
    PopupMenu:= PopUpEditor;
    onEnter:= SynEditEnter;
    onExit:= SynEditExit;
    Gutter.Font.Assign(FConfiguration.Font);
    Gutter.Font.Height:= Font.Height + 2;
    Gutter.ShowLineNumbers:= True;
    Gutter.DigitCount:= 0;
    Gutter.Autosize:= True;
    Highlighter:= ResourcesDataModule.Highlighters.HighlighterFromFileExt('.py');
  end;
  CodeEdit2.Assign(EditorOptions);
  Nr:= 1;
  OnClose:= FormClose;
  OnlyDifferences:= False;
  SetFont(EditorOptions.Font);
  TBCopyBlockLeft.Hint:= _('Copy block left');
  TBCopyBlockRight.Hint:= _('Copy block right');
  ChangeStyle;
end;

procedure TFTextDiff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Diff);
  FreeAndNil(CodeEdit1);
  FreeAndNil(CodeEdit2);
  FreeAndNil(Lines1);
  FreeAndNil(Lines2);
  Action:= caFree;
  inherited;
end;

procedure TFTextDiff.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  GuiPyOptions.TextDiffState:= GetState;
  GuiPyOptions.TextDiffIgnoreCase:= IgnoreCase;
  GuiPyOptions.TextDiffIgnoreBlanks:= IgnoreBlanks;
  if OnlyDifferences then TBDiffsOnlyClick(Self);
  DoSaveBoth;
  CanClose:= True;
end;

procedure TFTextDiff.New(F1, F2: TEditorForm);
begin
  Pathname:= Caption;
  if Assigned(F1) and Assigned(F2) then
    Open(F1.Pathname, F2.Pathname)
  else begin
    if Assigned(F1) then
      Open(F1.Pathname);
    ChooseFiles(F1);
  end;
  DoCompare;
  DoActivateFile;
end;

procedure TFTextDiff.SynEditEnter(Sender: TObject);
begin
  inherited;
  GI_SearchCmds := Self;
  fActiveSynEdit := Sender as TSynEdit;
  Nr:= (fActiveSynEdit as TSynEditExDiff).Nr;
  TBCopyBlockLeft.Hint:= _('Copy block left');
  TBCopyBlockRight.Hint:= _('Copy block right');
  EditorSearchOptions.TextDiffIsSearchTarget := True;
  EditorSearchOptions.InterpreterIsSearchTarget := False;
  DoAssignInterfacePointer(True);
end;

procedure TFTextDiff.SynEditExit(Sender: TObject);
begin
  inherited;
  GI_SearchCmds := nil;
  PyIDEMainForm.mnEditCopy.Action:= CommandsDataModule.actEditCopy;
  PyIDEMainForm.mnEditPaste.Action:= CommandsDataModule.actEditPaste;
  DoAssignInterfacePointer(False);
end;

procedure TFTextDiff.TBDiffsOnlyClick(Sender: TObject);
  var CodeEdit: TSynEditExDiff;
      Caret: TBufferCoord;
begin
  if OnlyDifferences then begin
    OnlyDifferences:= False;
    CodeEdit1.ReadOnly:= False;
    CodeEdit2.ReadOnly:= False;
    CodeEdit1.Gutter.Autosize:= True;
    CodeEdit2.Gutter.Autosize:= True;
    TBCopyBlockLeft.Enabled:= True;
    TBCopyBlockRight.Enabled:= True;
    CodeEdit:= GetCodeEdit;
    Caret:= CodeEdit.CaretXY;
    if Caret.Line - 1 > 0 then
      Caret.Line:= CodeEdit.GetLineObj(Caret.Line-1).Tag;
    DisplayDiffs;
    CodeEdit.CaretXY:= Caret;
    SyncScroll(GetCodeEdit, sbVertical);
    end
  else begin
    DoSaveBoth;
    if not FilesCompared then DoCompare;
    if FilesCompared then begin
      OnlyDifferences:= True;
      CodeEdit1.Gutter.Autosize:= False;
      CodeEdit2.Gutter.Autosize:= False;
      DisplayDiffs;
      CodeEdit1.ReadOnly:= True;
      CodeEdit2.ReadOnly:= True;
      TBCopyBlockLeft.Enabled:= False;
      TBCopyBlockRight.Enabled:= False;
    end;
  end;
end;

procedure TFTextDiff.Save;
begin
  DoSaveFile(GetCodeEdit.Nr);
end;

procedure TFTextDiff.Open(const FileName: string);
begin
  DoLoadFile(FileName, Nr);
end;

procedure TFTextDiff.DoLoadFile(const FileName: string; Nr: Integer);
begin
  if OnlyDifferences then
    TBDiffsOnlyClick(Self);
  SetFilesCompared(False);
  LinkScroll(False);
  if Nr = 1
    then CodeEdit1.Load(Lines1, FileName)
    else CodeEdit2.Load(Lines2, FileName);
end;

procedure TFTextDiff.Open(const Filename1, Filename2: string);
begin
  if OnlyDifferences then
    TBDiffsOnlyClick(Self);
  SetFilesCompared(False);
  LinkScroll(False);
  CodeEdit1.Load(Lines1, Filename1);
  CodeEdit2.Load(Lines2, Filename2);
end;

procedure TFTextDiff.HorzSplitClick(Sender: TObject);
begin
  TBView.ImageIndex:= 3 - TBView.ImageIndex;
  if TBView.ImageIndex = 2 then begin
    PLeft.Align:= alTop;
    PLeft.Height:= PMain.ClientHeight div 2 -1;
    Splitter.Align:= alTop;
    Splitter.Cursor:= crVSplit;
    TBCopyBlockLeft.Hint:= _('Copy block up');
    TBCopyBlockLeft.ImageIndex:= 10;
    TBCopyBlockRight.Hint:= _('Copy block down');
    TBCopyBlockRight.ImageIndex:= 11;
  end else begin
    PLeft.Align:= alLeft;
    PLeft.Width:= PMain.ClientWidth div 2 -1;
    Splitter.Align:= alLeft;
    Splitter.Left:= 10;
    Splitter.Cursor:= crHSplit;
    TBCopyBlockLeft.Hint:= _('Copy block left');
    TBCopyBlockLeft.ImageIndex:= 8;
    TBCopyBlockRight.Hint:= _('Copy block right');
    TBCopyBlockRight.ImageIndex:= 9;
  end;
  CodeEdit1.ShowFilename;
  GetCodeEdit.EnsureCursorPosVisible;
  SyncScroll(GetCodeEdit, sbVertical);
end;

procedure TFTextDiff.DoCompare;
var
  i: Integer;
  HashArray1, HashArray2: TArrOfInteger;
  CodeEdit: TSynEditExDiff;
  Caret: TBufferCoord;
begin
  if (Lines1.Count = 0) or (Lines2.Count = 0) then Exit;

  CodeEdit:= GetCodeEdit;
  Caret:= CodeEdit.CaretXY;

  if CodeEdit1.Modified or CodeEdit2.Modified then
    DoSaveBoth;

  CodeEdit1.Color:= DefaultClr;
  CodeEdit2.Color:= DefaultClr;

  //THIS PROCEDURE IS WHERE ALL THE HEAVY LIFTING (COMPARING) HAPPENS ...

  //Because it's SO MUCH EASIER AND FASTER comparing hashes (integers) than
  //comparing whole lines of text, we'll build an array of hashes for each line
  //in the source files. Each line is represented by a (virtually) unique
  //hash that is based on the contents of that line. Also, since the
  //likelihood of 2 different lines generating the same hash is so small,
  //we can safely ignore that possibility.

  try
    Screen.Cursor:= crHourGlass;
    SetLength(HashArray1, Lines1.Count);
    SetLength(HashArray2, Lines2.Count);
    for i:= 0 to Lines1.Count-1 do
      HashArray1[i]:= HashLine(Lines1[i], IgnoreCase, IgnoreBlanks);
    for i:= 0 to Lines2.Count-1 do
      HashArray2[i]:= HashLine(Lines2[i], IgnoreCase, IgnoreBlanks);
    try
      //CALCULATE THE DIFFS HERE ...
       if not Diff.Execute(HashArray1, HashArray2,
                           Lines1.Count, Lines2.Count) then Exit;

      SetFilesCompared(True);
      DisplayDiffs;
    finally
    end;
    LinkScroll(True);
    setActiveControl(CodeEdit);
    CodeEdit.CaretXY:= Caret;
    SyncScroll(GetCodeEdit, sbVertical);
  finally
    Screen.Cursor:= crDefault;
    HashArray1:= nil;
    HashArray2:= nil;
  end;
end;

function Log10(int: Integer): Integer;
begin
  result:= 1;
  while int > 9 do begin Inc(result); int:= int div 10; end;
end;

procedure TFTextDiff.DisplayDiffs;
  var i: Integer;

  procedure AddAndFormat(CodeEdit: TSynEditExDiff; const Text: string;
                         Color: TColor; Num: longint);
    var i: Integer; LineObject: TLineObj;
  begin
    i:= CodeEdit.Lines.Count;
    LineObject:= TLineObj.Create;
    LineObject.Spezial:= Color <> DefaultClr;
    LineObject.BackClr:= Color;
    LineObject.Tag:= Num;
    CodeEdit.InsertItem(i, Text, LineObject);
  end;

begin
  // THIS IS WHERE THE TDIFF RESULT IS CONVERTED INTO COLOR HIGHLIGHTING ...
  CodeEdit1.Lines.BeginUpdate;
  CodeEdit2.Lines.BeginUpdate;
  try
    CodeEdit1.LinesClearAll;
    CodeEdit2.LinesClearAll;
    CodeEdit1.OnSpecialLineColors:= CodeEdit1.SynEditorSpecialLineColors;
    CodeEdit2.OnSpecialLineColors:= CodeEdit2.SynEditorSpecialLineColors;

    CodeEdit1.OnGutterGetText:= CodeEdit1.GutterTextEvent;
    CodeEdit2.OnGutterGetText:= CodeEdit2.GutterTextEvent;

    for i:= 0 to Diff.Count-1 do
      with Diff.Compares[i] do
        if Kind = ckAdd then begin
           AddAndFormat(CodeEdit1, '', addClr, 0);
           AddAndFormat(CodeEdit2, lines2[oldindex2], addClr, oldindex2+1);
        end else if Kind = ckDelete then begin
           AddAndFormat(CodeEdit1, lines1[oldindex1], delClr, oldindex1+1);
           AddAndFormat(CodeEdit2, '', delClr, 0);
        end else if Kind = ckModify then begin
           AddAndFormat(CodeEdit1, lines1[oldindex1], modClr, oldindex1+1);
           AddAndFormat(CodeEdit2, lines2[oldindex2], modClr, oldindex2+1);
        end else if not OnlyDifferences then begin
           AddAndFormat(CodeEdit1, lines1[oldindex1], defaultClr, oldindex1+1);
           AddAndFormat(CodeEdit2, lines2[oldindex2], defaultClr, oldindex2+1);
        end;
    CodeEdit1.SetModified(False);
    CodeEdit2.SetModified(False);
  finally
    CodeEdit1.Lines.EndUpdate;
    CodeEdit2.Lines.EndUpdate;
  end;
  with Diff.DiffStats do
    if adds + modifies + deletes = 0 then begin
      CodeEdit1.WithColoredLines:= False;
      CodeEdit2.WithColoredLines:= False;
      end
    else begin
      CodeEdit1.WithColoredLines:= True;
      CodeEdit2.WithColoredLines:= True;
    end;
  CodeEdit1.ClearUndo;
  CodeEdit2.ClearUndo;
  ShowDiffState;
end;

procedure TFTextDiff.ShowDiffState;
begin
  liAdded.Caption:= Format(' ' + _('%d lines added') + ' ', [Diff.DiffStats.adds]);
  liModified.Caption:= Format(' ' + _('%d lines modified') + ' ', [Diff.DiffStats.modifies]);;
  liDeleted.Caption:= Format(' ' + _('%d lines deleted') + ' ', [Diff.DiffStats.deletes]);
  with Diff.DiffStats do
    if adds + modifies + deletes = 0
      then liDifferences.Caption:= _('No differences.')
      else liDifferences.Caption:= '';
end;

//Syncronise scrolling of both CodeEdits (once files are compared)...
var IsSyncing: Boolean;

procedure TFTextDiff.SyncScroll(Sender: TObject; ScrollBar: TScrollBarKind);
 var CurrMouse: TPoint;
begin
  if IsSyncing or not (CodeEdit1.WithColoredLines and CodeEdit2.WithColoredLines)
    then Exit;
  IsSyncing:= True; //stops recursion
  try
    if (Sender as TSynEditExDiff) = CodeEdit1
      then CodeEdit2.TopLine:= CodeEdit1.TopLine
      else CodeEdit1.TopLine:= CodeEdit2.TopLine;

    // Workaround to force the scroll bars to show their actual position
    CurrMouse:= Mouse.CursorPos;
    SendMessage(CodeEdit1.Handle,
      WM_MouseMove, 0, MAKELPARAM(CodeEdit1.Width - 10, CodeEdit1.Height div 2));
    SendMessage(CodeEdit2.Handle,
      WM_MouseMove, 0, MAKELPARAM(CodeEdit2.Width - 10, CodeEdit2.Height div 2));
    Mouse.CursorPos:= CurrMouse;
  finally
    IsSyncing:= False;
  end;
end;

procedure TFTextDiff.ShowFileNames;
begin
  CodeEdit1.ShowFilename;
  CodeEdit2.ShowFilename;
end;

procedure TFTextDiff.LinkScroll(IsLinked: Boolean);
begin
  if IsLinked then begin
    CodeEdit1.OnScroll:= CodeEdit1.SyncScroll;
    CodeEdit2.OnScroll:= CodeEdit2.SyncScroll;
    SyncScroll(GetCodeEdit, sbVertical);
  end else begin
    CodeEdit1.OnScroll:= nil;
    CodeEdit2.OnScroll:= nil;
  end;
end;

//go to next color block (only enabled if files have been compared)
procedure TFTextDiff.NextClick(Sender: TObject);
  var i: Integer; clr: TColor;
begin
  //get next colored block ...
  with GetCodeEdit do begin
    if (lines.Count = 0) or not WithColoredLines then Exit;
    i:= CaretY-1;
    clr:= GetLineObj(i).BackClr;
    repeat
      Inc(i);
    until (i = Lines.Count) or (GetLineObj(i).BackClr <> clr);
    if (i = Lines.Count) then //do nothing here
    else if GetLineObj(i).BackClr = color then
    repeat
      Inc(i);
    until (i = Lines.Count) or (GetLineObj(i).BackClr <> color);
    if (i = Lines.Count) then
    begin
      Beep;  //not found
      Exit;
    end;
    CaretY:= i+1;
    //now make sure as much of the block as possible is visible ...
    clr:= GetLineObj(i).BackClr;
    repeat
      Inc(i);
    until(i = Lines.Count) or (GetLineObj(i).BackClr <> clr);
    if i >= TopLine + LinesInWindow then begin
      TopLine:= CaretY;
      SyncScroll(GetCodeEdit, sbVertical);
    end;
  end;
end;

//go to previous color block (only enabled if files have been compared)
procedure TFTextDiff.PrevClick(Sender: TObject);
  var i: Integer; clr: TColor;
begin
  //get prev colored block ...
  with GetCodeEdit do begin
    if not WithColoredLines then Exit;
    i:= CaretY-1;
    if i = Lines.Count then begin Beep; Exit end;
    clr:= GetLineObj(i).BackClr;
    repeat
      Dec(i);
    until (i < 0) or (GetLineObj(i).BackClr <> clr);
    if i < 0 then begin Beep; Exit end;;
    if GetLineObj(i).BackClr = Color then
    repeat
      Dec(i);
    until (i < 0) or (GetLineObj(i).BackClr <> Color);
    if i < 0 then Beep
    else begin
      clr:= GetLineObj(i).BackClr;
      while (i > 0) and (GetLineObj(i-1).BackClr = clr) do Dec(i);
      //'i' now at the beginning of the previous color block.
      CaretY:= i+1;
      SyncScroll(GetCodeEdit, sbVertical);
    end;
  end;
end;

procedure TFTextDiff.CopyBlockRightClick(Sender: TObject);
  var From, To_: Integer;
      EmptyClipboard: Boolean;
      clr: TColor; LinObj: TLineObj;
begin
  if (myActiveControl <> CodeEdit1) or OnlyDifferences or not FilesCompared then Exit;
  with CodeEdit1 do begin
    if lines.Count = 0 then Exit;
    From:= CaretY - 1;
    clr:= GetLineObj(From).BackClr;
    if clr = color then Exit; //we're not in a colored block !!!
    To_:= From;
    while (From > 0) and
      (GetLineObj(From-1).BackClr = clr) do Dec(From);
    while (To_ < Lines.Count-1) and
      (GetLineObj(To_+1).BackClr = clr) do Inc(To_);
    //make sure color blocks still match up ...
    if (To_ > CodeEdit2.Lines.Count -1) or
      (CodeEdit2.GetLineObj(From).BackClr <> clr) or
      (CodeEdit2.GetLineObj(To_).BackClr <> clr) then Exit;
    EmptyClipboard:= CopyIntoClipboard(From, To_);
    LinObj:= GetLineObj(From);
  end;
  CodeEdit2.PasteClipboard(EmptyClipboard, From, To_, LinObj.Tag);
  SyncScroll(CodeEdit1, sbVertical);
  CodeEdit1.Enter(Self);
end;

procedure TFTextDiff.CopyBlockLeftClick(Sender: TObject);
  var From, To_: Integer;
      EmptyClipboard: Boolean;
      clr: TColor; LinObj: TLineObj;
begin
  if (myActiveControl <> CodeEdit2) or OnlyDifferences or not FilesCompared then Exit;
  with CodeEdit2 do begin
    if lines.Count = 0 then Exit;
    From:= CaretY - 1;
    clr:= GetLineObj(From).BackClr;
    if clr = color then Exit; //we're not in a colored block !!!
    To_:= From;
    while (From > 0) and
      (GetLineObj(From-1).BackClr = clr) do Dec(From);
    while (To_ < Lines.Count-1) and
      (GetLineObj(To_+1).BackClr = clr) do Inc(To_);
    //make sure color blocks still match up ...
    if (To_ > CodeEdit1.Lines.Count -1) or
      (CodeEdit1.GetLineObj(From).BackClr <> clr) or
      (CodeEdit1.GetLineObj(To_).BackClr <> clr) then Exit;
    EmptyClipboard:= CopyIntoClipboard(From, To_);
    LinObj:= GetLineObj(From);
  end;
  CodeEdit1.PasteClipboard(EmptyClipboard, From, To_, LinObj.Tag);
  SyncScroll(CodeEdit2, sbVertical);
  CodeEdit2.Enter(Self);
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
  (fFile as IFileCommands).ExecClose;
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
  GetCodeEdit.CutToClipBoard;
end;

procedure TFTextDiff.CopyToClipboard;
begin
  GetCodeEdit.CopyToClipBoard;
end;

procedure TFTextDiff.PasteFromClipboard;
begin
  with GetCodeEdit do begin
    PasteFromClipBoard;
    CreateObjects;
  end;
end;

procedure TFTextDiff.SetFont(aFont: TFont);
begin
  CodeEdit1.Font.Assign(aFont);
  CodeEdit2.Font.Assign(aFont);
  SetFontSize(0);
end;

procedure TFTextDiff.SetFontSize(Delta: Integer);
  var Size: Integer;
begin
  Size:= CodeEdit1.Font.Size + Delta;
  if Size < 6 then Size:= 6;
  CodeEdit1.Font.Size:= Size;
  CodeEdit2.Font.Size:= Size;
  CodeEdit1.Gutter.Font.Size:= Size;
  CodeEdit2.Gutter.Font.Size:= Size;
  ShowFileNames;
end;

procedure TFTextDiff.FormResize(Sender: TObject);
begin
  if TBView.Marked
    then PLeft.height:= PMain.ClientHeight div 2 - 1
    else PLeft.width := PMain.ClientWidth  div 2 - 1;
end;

procedure TFTextDiff.TBCompareClick(Sender: TObject);
begin
  if OnlyDifferences then TBDiffsOnlyClick(Self);
  DoCompare;
end;

procedure TFTextDiff.DoSaveFile(Nr: Integer);
  var CodeEdit: TSynEditExDiff;
begin
  if Nr = 1
    then CodeEdit:= CodeEdit1
    else CodeEdit:= CodeEdit2;
  if (CodeEdit.Pathname = '') or OnlyDifferences then Exit;
  CodeEdit.Save;
  if Nr = 1
    then Lines1.Assign(CodeEdit.Lines)
    else Lines2.Assign(CodeEdit.Lines);
  SetFilesCompared(False);
end;

procedure TFTextDiff.DoSaveBoth;
begin
  DoSaveFile(1);
  DoSaveFile(2);
end;

procedure TFTextDiff.TBSourcecodeClick(Sender: TObject);
  var CodeEdit: TSynEditExDiff;
      Caret: TBufferCoord;
begin
  if OnlyDifferences then TBDiffsOnlyClick(Self);
  CodeEdit:= GetCodeEdit;
  Caret:= CodeEdit.CaretXY;
  DoSaveFile(1);
  DoSaveFile(2);
  CodeEdit.CaretXY:= Caret;
  setActiveControl(CodeEdit);
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
  FilesCompared:= Value;
end;

procedure TFTextDiff.TBCloseClick(Sender: TObject);
begin
  (fFile as IFileCommands).ExecClose;
end;

function TFTextDiff.GetCodeEdit: TSynEditExDiff;
begin
  if myActiveControl = CodeEdit1
    then Result:= CodeEdit1
    else Result:= CodeEdit2;
end;

procedure TFTextDiff.SplitterMoved(Sender: TObject);
begin
  ShowFilenames;
end;                                         

procedure TFTextDiff.TBIgnoreCaseClick(Sender: TObject);
begin
  IgnoreCase:= not IgnoreCase;
  TBIgnoreCase.Down:= IgnoreCase;
  if FilesCompared then TBCompareClick(Self);
end;

procedure TFTextDiff.TBIgnoreBlanksClick(Sender: TObject);
begin
  IgnoreBlanks:= not IgnoreBlanks;
  TBIgnoreBlanks.Down:= IgnoreBlanks;
  if FilesCompared then TBCompareClick(Self);
end;

procedure TFTextDiff.TBParagraphClick(Sender: TObject);
begin
  var VisibleSpecialChars := CodeEdit1.VisibleSpecialChars;
  if VisibleSpecialChars = [] then
    CodeEdit1.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    CodeEdit1.VisibleSpecialChars := [];
  VisibleSpecialChars := CodeEdit2.VisibleSpecialChars;
  if VisibleSpecialChars = [] then
    CodeEdit2.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    CodeEdit2.VisibleSpecialChars := [];
  TBParagraph.Down:= not (CodeEdit1.VisibleSpecialChars = []);
end;

procedure TFTextDiff.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFTextDiff.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    addClr:= $97734F;
    modClr:= $16A231;
    delClr:= $621EA6;
    DefaultClr:= StyleServices.GetSystemColor(clWindow);
    TBTextDiff.Images:= vilTextDiffDark;
  end else begin
    addClr:= $F0CCA8;
    modClr:= $6FFB8A;
    delClr:= $BB77FF;
    DefaultClr:= clWindow;
    TBTextDiff.Images:= vilTextDiffLight;
  end;
  PyIDEMainForm.ThemeEditorGutter(CodeEdit1.Gutter);
  CodeEdit1.InvalidateGutter;
  CodeEdit1.CodeFolding.FolderBarLinesColor := CodeEdit1.Gutter.Font.Color;

  PyIDEMainForm.ThemeEditorGutter(CodeEdit2.Gutter);
  CodeEdit2.CodeFolding.FolderBarLinesColor := CodeEdit2.Gutter.Font.Color;
  CodeEdit2.InvalidateGutter;
  CodeEdit1.ChangeStyle;
  CodeEdit2.ChangeStyle;
  Invalidate;
end;

procedure TFTextDiff.ChooseFiles(F1: TEditorForm);
  var TempFilter: string;

  procedure InitDir;
  begin
    with ResourcesDataModule.dlgFileOpen do begin
      InitialDir:= GuiPyOptions.Sourcepath;
      if not SysUtils.DirectoryExists(InitialDir) then
        InitialDir:= GetDocumentsPath;
    end;
  end;

begin
  with ResourcesDataModule.dlgFileOpen do begin
    if Assigned(F1)then begin
      InitialDir:= ExtractFilePath(F1.Pathname);
      Nr:= 2;
    end else begin
      InitDir;
      Nr:= 1;
    end;
    FileName:= '';
    TempFilter:= Filter;
    Filter:= 'Python (*.py;*.pyw)|*.py;*.pyw|HTML (*.html)|*.html;*.htm|Text (*.txt)|*.txt|' + _(LNGAll) + ' (*.*)|*.*';
    FilterIndex:= 1;
    Title:= _(SOpenFile);
    Options := Options + [ofAllowMultiSelect];
    try
      if Execute then begin
        GuiPyOptions.Sourcepath:= ExtractFilePath(FileName);
        if Files.Count >= 2
          then Open(Files[0], Files[1])
          else Open(FileName);
      end;
    finally
      Filter:= TempFilter;
      Options := Options - [ofAllowMultiSelect];
    end;
  end;
end;

procedure TFTextDiff.Retranslate;
begin
  inherited;
  ShowDiffState;
end;

function TFTextDiff.IsEmpty : Boolean;
begin
  Result := (fActiveSynEdit.Lines.Count  = 0) or
    ((fActiveSynEdit.Lines.Count  = 1) and (fActiveSynEdit.Lines[0] = ''));
end;

procedure TFTextDiff.liDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ItemInfo: TSpTBXMenuItemInfo;
  const PaintStage: TSpTBXPaintStage; var PaintDefault: Boolean);
begin
  if PaintStage = pstPrePaint then begin
    PaintDefault:= False;
    var aColor:= clBtnFace;
    case (Sender as TSpTBXLabelItem).Tag of
      1: aColor:= addClr;
      2: aColor:= modClr;
      3: aColor:= delClr;
    end;
    ACanvas.Brush.Color:= aColor;
    ACanvas.Pen.Color:= aColor;
    ACanvas.Rectangle(ARect);
  end;
end;

function TFTextDiff.CanFind: Boolean;
begin
  Result := not IsEmpty;
end;

function TFTextDiff.CanFindNext: Boolean;
begin
  Result := not IsEmpty and
    (EditorSearchOptions.SearchText <> '');
end;

function TFTextDiff.CanReplace: Boolean;
begin
  Result := not IsEmpty;
end;

procedure TFTextDiff.ExecFind;
begin
  CommandsDataModule.ShowSearchReplaceDialog(fActiveSynEdit, FALSE);
end;

procedure TFTextDiff.ExecFindNext;
begin
  CommandsDataModule.DoSearchReplaceText(fActiveSynEdit, FALSE, FALSE);
end;

procedure TFTextDiff.ExecFindPrev;
begin
  CommandsDataModule.DoSearchReplaceText(fActiveSynEdit, FALSE, TRUE);
end;

procedure TFTextDiff.ExecReplace;
begin
  CommandsDataModule.ShowSearchReplaceDialog(fActiveSynEdit, TRUE);
end;

function TFTextDiff.GetSearchTarget: TSynEdit;
begin
  Result := fActiveSynEdit;
end;

procedure TFTextDiff.DPIChanged;
begin
  setFontsize(0);
end;

end.
