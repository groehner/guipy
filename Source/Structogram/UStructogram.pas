{-------------------------------------------------------------------------------
 Unit:     UStructogram
 Author:   Gerhard Röhner
 Based on: NSD-Editor by Marcel Kalt
 Date:     August 2013
 Purpose:  structogram editor
-------------------------------------------------------------------------------}

unit UStructogram;

interface

uses
  Windows, Messages, Classes, Controls, ExtCtrls, Forms, Graphics,
  ComCtrls, StdCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList,
  SpTBXSkins, frmFile, UTypes, SpTBXItem, TB2Item, Vcl.Menus,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, SVGIconImageCollection,
  Vcl.VirtualImage;

type

  TFStructogram = class(TFileForm)
    ScrollBox: TScrollBox;
    PanelLeft: TPanel;
    StructogramToolbar: TToolBar;
    TBClose: TToolButton;
    TBStatement: TToolButton;
    TBIfElse: TToolButton;
    TBIfElseif: TToolButton;
    TBWhile: TToolButton;
    TBFor: TToolButton;
    TBSubprogram: TToolButton;
    TBBreak: TToolButton;
    TBAlgorithm: TToolButton;
    TBCreatePythonCode: TToolButton;
    TBZoomOut: TToolButton;
    TBZoomIn: TToolButton;
    TBPuzzleMode: TToolButton;
    StructoPopupMenu: TSpTBXPopupMenu;
    MIConfiguration: TSpTBXItem;
    MIFont: TSpTBXItem;
    MIPuzzle: TSpTBXItem;
    MICopyAsPicture: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIGenerateFunction: TSpTBXItem;
    MIDatatype: TSpTBXSubmenuItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MIDeleteCase: TSpTBXItem;
    MIAddCase: TSpTBXItem;
    MISwitchWithCaseLine: TSpTBXItem;
    MICopy: TSpTBXItem;
    MIDelete: TSpTBXItem;
    MIString: TSpTBXItem;
    MIInt: TSpTBXItem;
    MIFloat: TSpTBXItem;
    MIBoolean: TSpTBXItem;
    MILong: TSpTBXItem;
    icStructogram: TSVGIconImageCollection;
    vilToolbarDark: TVirtualImageList;
    vilToolbarLight: TVirtualImageList;
    vilPopupMenuLight: TVirtualImageList;
    vilPopupMenuDark: TVirtualImageList;
    TrashImage: TVirtualImage;
    MISavePuzzleFiles: TSpTBXItem;

    procedure FormCreate(Sender: TObject); override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;

    // used by buttons
    procedure StrElementMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure ImageDblClick(Sender: TObject);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBoxClick(Sender: TObject);
    procedure ScrollBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MICopyAsPictureClick(Sender: TObject);
    procedure MIDatatypeClick(Sender: TObject);
    procedure StructoPopupMenuPopup(Sender: TObject);
    procedure EditMemoChange(Sender: TObject);

    procedure MIGenerateFunctionClick(Sender: TObject);
    procedure MIFontClick(Sender: TObject);
    procedure MISwitchWithCaseLineClick(Sender: TObject);
    procedure MIAddCaseClick(Sender: TObject);
    procedure MIDeleteCaseClick(Sender: TObject);
    procedure MIDeleteClick(Sender: TObject);
    procedure MIPuzzleClick(Sender: TObject);
    procedure MICopyClick(Sender: TObject);
    procedure BBGeneratePythonClick(Sender: TObject);
    procedure BBCloseClick(Sender: TObject);
    procedure BBZoomOutClick(Sender: TObject);
    procedure BBZoomInClick(Sender: TObject);
    procedure BBPuzzleClick(Sender: TObject);
    procedure MIConfigurationClick(Sender: TObject);
    procedure MISavePuzzleFilesClick(Sender: TObject);
  private
    EditMemo: TMemo;
    oldShape: TRect;
    oldCanvas: TCanvas;
    curElement: TStrElement;
    curList: TStrList;
    EditMemoElement: TStrElement;
    EditMemoBeginText: string;
    CurInsert: Integer;
    IsMoving: Boolean;
    ReadOnly: Boolean;
    MousePos: TPoint;
    ScreenMousePos: TPoint;
    DataType: string;
    Variables: string;
    ControlCanvas: TCanvas;
    IgnoreNextMouseDown: Boolean;
    IgnoreNextMouseUp: Boolean;
    Separating: Integer;
    PuzzleMode: Integer;
    Solution: string;
    Version: Byte;
    procedure ShowShape;
    procedure HideShape;
    procedure AddParameter(list: TStrList; paramList: TStringList);
    procedure AddVariable(aText: string; list: TStringList);
    procedure StrElementToPython(element: TStrElement; pList, VariablesList: TStringList; const indent: string);
    function FindElement(current: TStrElement; X, Y: Integer): TStrElement;
    function FindVisibleElement(current: TStrElement; X, Y: Integer): TStrElement;
    function BeforeOrAfter(current: TStrElement): Boolean;

    function getParentElement(element: TStrElement): TStrElement;
    function getToken(var S: string; var Token: string): Integer;
    procedure CalculateInsertionShape(DestList, InsertList: TStrList; x, y: Integer);
    procedure InsertElement(DestList, InsertList: TStrList; aCurElement: TStrElement);

    procedure Save;
    procedure CutToClipboard;
    procedure UpdateState;

    procedure setEvents(Image: TListImage);
    procedure DoEdit(StrElement: TStrElement; s: string);
    procedure CloseEdit(b: Boolean);
    procedure setLeftBorderForEditMemo;
    function getAlgorithmParameter(ParamList: TStringList): string;
    procedure PythonProgram(list: TStrList; progList: TStringList; const aName: string);
    function getAlgorithm: TStrAlgorithm;
    function getList: TStrList;
    function getListAtScreenPos(Pt: TPoint): TStrList;
    function getCurList: Boolean;
    function getCurListAndCurElement: Boolean;
    function getBitmap: TBitmap;
    function getName(StrList: TStrList): string;
    procedure PaintAll;
    function fitsIn(aCurList: TStrList; aCurElement: TStrElement): Boolean;
    procedure SetPuzzleMode(Mode: Integer);
    procedure MakeVeryHard;
    procedure ChangeStyle;
  protected
    function OpenFile(const aPathname: string): Boolean; override;
    function LoadFromFile(const FileName: string): Boolean; override;
    function CanPaste: Boolean; override;
    function CanCopy: Boolean; override;
    procedure CopyToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure DoActivateFile(Primary: Boolean = True); override;
    procedure SetFont(aFont: TFont); override;
    procedure Enter(Sender: TObject); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    procedure New;
    procedure Print; override;
    function getAsStringList: TStringList; override;
    function GetSaveAsName: string;
    procedure FromText(const s: string);
    procedure RenewFromText(const s: string);
    procedure DoExport; override;
    procedure debug(const s: string);
    procedure SetOptions; override;
    procedure DPIChanged; override;
    class function ToolbarCount: Integer;
end;

implementation

{$R *.DFM}

uses SysUtils, Math, Clipbrd, Dialogs, Themes, Types, UITypes, Buttons,
     JvGnugettext, StringResources, IOUtils, UUtils, UConfiguration,
     frmPyIDEMain, uEditAppIntfs, uCommonFunctions,
     cPyScripterSettings, frmMessages, UGenerateStructogram;

procedure TFStructogram.FormCreate(Sender: TObject);
begin
  inherited;
  oldShape:= Rect(-1, -1, -1, -1);
  EditMemo:= TMemo.Create(Self);
  EditMemo.Parent:= Self;
  EditMemo.SetBounds(136, 156, 99, 37);
  EditMemo.Color:= StyleServices.GetSystemColor(clSkyBlue);
  EditMemo.OnChange:= EditMemoChange;
  EditMemo.Visible:= False;
  EditMemo.WordWrap:= False;
  EditMemo.BevelInner:= bvNone;
  ControlCanvas:= TControlCanvas.Create;
  TControlCanvas(ControlCanvas).Control:= Scrollbox;
  Font.assign(GuiPyOptions.StructogramFont);
  ScrollBox.DoubleBuffered:= True;
  Separating:= 0;
  StructogramToolbar.Height:= 308 - 22;
  Version:= $0E;
  curList:= nil;
  curElement:= nil;
  DefaultExtension:= 'psg';
  UpdateState;
  ChangeStyle;
  setOptions;
  setPuzzleMode(0);
end;

procedure TFStructogram.FormClose(Sender: TObject; var Action: TCloseAction);
  var i: Integer;
begin
  inherited;
  for i:= Scrollbox.ControlCount - 1 downto 0 do
    TListImage(ScrollBox.Controls[i]).StrList.Destroy;
  FreeAndNil(ControlCanvas);
  Action:= caFree;
end;

procedure TFStructogram.New;
  var elem: TStrElement;
      StrList: TStrAlgorithm;
begin
  //setActiveControl(SBClose);
  if Pathname = '' then Pathname:= PyIDEMainForm.getFilename('.psg');
  Caption:= Pathname;
  StrList:= TStrAlgorithm.Create(ScrollBox, PuzzleMode, Font);
  StrList.text:= GuiPyLanguageOptions.Algorithm + ' ' + ChangeFileExt(ExtractFilename(Pathname), '');
  elem:= TStrStatement.Create(StrList);
  StrList.insert(StrList, elem);
  setEvents(StrList.Image);
  StrList.ResizeAll;
  StrList.Paint;
  Modified:= False;
  Enter(Self); // must stay!
  SetFocus;
end;

procedure TFStructogram.FromText(const s: string);
  var Generator: TGenerateStructogram;
      StrList: TStrAlgorithm;
begin
  if Pathname = '' then Pathname:= PyIDEMainForm.getFilename('.psg');
  StrList:= TStrAlgorithm.Create(ScrollBox, PuzzleMode, Font);
  StrList.Text:= GuiPyLanguageOptions.Algorithm + ' ';
  Generator:= TGenerateStructogram.Create(True);
  try
    Generator.GenerateStructogram(s, StrList);
  finally
    FreeAndNil(Generator);
  end;
  setEvents(StrList.Image);
  StrList.ResizeAll;
  StrList.Paint;
  FFile.ExecSave;
  Save;
  Enter(Self); // must stay!
  SetFocus;
end;

procedure TFStructogram.RenewFromText(const s: string);
  var Generator: TGenerateStructogram;
      StrList: TStrList; i: Integer;
      Alg: string;
begin
  for i:= ScrollBox.ControlCount - 1 downTo 0 do begin
    Strlist:= TListImage(ScrollBox.Controls[i]).StrList;
    if StrList is TStrAlgorithm then Alg:= Strlist.text;
    FreeAndNil(Strlist);
  end;

  StrList:= TStrAlgorithm.Create(ScrollBox, PuzzleMode, Font);
  StrList.Text:= Alg;
  setEvents(StrList.Image);
  StrList.Text:= GuiPyLanguageOptions.Algorithm + ' ';
  Generator:= TGenerateStructogram.Create(True);
  try
    Generator.GenerateStructogram(s, StrList);
  finally
    FreeAndNil(Generator);
  end;
  StrList.ResizeAll;
  StrList.Paint;
  Save;
  Enter(Self); // must stay!
  SetFocus;
end;

function TFStructogram.OpenFile(const aPathname: string): Boolean;
begin
  CloseEdit(True);
  Result:= inherited;
end;

procedure TFStructogram.enter(Sender: TObject);
begin
  if StructogramToolbar.Visible and StructogramToolbar.CanFocus then
    StructogramToolbar.SetFocus;
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
end;

function TFStructogram.LoadFromFile(const FileName: string): Boolean;
var
  StrList: TStrList;
  SwitchWithCaseLine: Boolean;
  Reader: TStringListReader;

  procedure Init(aList: TStrList);
  begin
    aList.SwitchWithCaseLine:= SwitchWithCaseLine;
    aList.setPuzzleMode(PuzzleMode);
    aList.setFont(Font);
    aList.setLineHeight;
    setEvents(aList.Image);
    aList.ResizeAll;
    aList.Paint;
  end;

begin
  Result:= True;
  try
    Reader:= TStringListReader.Create(FileName);
    try
      repeat
        Reader.ReadLine;
        if Reader.key = 'FontName' then
          Font.Name:= Reader.val
        else if Reader.key = 'FontSize' then
          Font.Size:= PPIScale(StrToInt(Reader.val))
        else if Reader.key = 'FontColor' then
          Font.Color:= StrToInt(Reader.val)
        else if Reader.key = 'FontBold' then
          if Reader.val = 'true'
            then Font.Style:= Font.Style + [fsBold]
            else Font.Style:= Font.Style - [fsBold]
        else if Reader.key = 'FontItalic' then
          if Reader.val = 'true'
            then Font.Style:= Font.Style + [fsItalic]
            else Font.Style:= Font.Style - [fsItalic]
        else if Reader.key = 'PuzzleMode' then
          PuzzleMode:= StrToInt(Reader.val)
        else if Reader.key = 'Solution' then
          Solution:= UnhideCrLf(Reader.val);
      until (Reader.key = '- Kind') or (Reader.key = '');

      while (Reader.key = '- Kind') and Result do begin
        if Reader.val = 'Algorithm'
          then StrList:= TStrAlgorithm.Create(ScrollBox, PuzzleMode, Font)
          else StrList:= TStrList.Create(Scrollbox, PuzzleMode, Font);
        Reader.ReadLine;
        if Reader.key = 'SwitchWithCaseLine'
          then SwitchWithCaseLine:= (Reader.val = 'true')
          else Reader.LineBack;
        StrList.LoadFromReader(Reader);
        Init(StrList);
        Result:= Result and not StrList.LoadError;
        Reader.ReadLine;
      end;
      GuiPyOptions.StructogramFont.assign(Font);
      SetPuzzleMode(PuzzleMode);
    finally
      FreeAndNil(Reader);
    end
  except
    on e: Exception do begin
      ErrorMsg(e.Message);
      Result:= False;
    end;
  end;
  Version:= $0F;
end;

function TFStructogram.getAsStringList: TStringList;
  var SL: TStringList; aList: TStrList;
begin
  SL:= TStringList.Create;
  SL.Add( 'PSG: true');
  if Font.Name = 'Arial' then
    Font.Name:= 'Segoe UI';
  SL.Add('FontName: ' + Font.Name);
  SL.Add('FontSize: ' + IntToStr(PPIUnscale(Font.Size)));
  if fsBold in Font.Style then
    SL.Add('FontBold: true');
  if fsItalic in Font.Style then
    SL.Add('FontItalic: true');
  SL.Add('FontColor: ' + IntToStr(Font.Color));
  if PuzzleMode > 0 then begin
    SL.Add('PuzzleMode: ' + IntToStr(PuzzleMode));
    SL.Add('Solution: ' + HideCrLf(Solution));
  end;
  for var i:= 0 to ScrollBox.ControlCount - 1 do begin
    aList:= (ScrollBox.Controls[i] as TListImage).StrList;
    SL.Add('- Kind: ' + aList.getKind);
    SL.Add('  SwitchWithCaseLine: ' + BoolToStr(aList.SwitchWithCaseLine, True));
    SL.Add('  RectPos' + aList.getRectPos('  '));
    SL.Add(aList.getText('  '));
  end;
  Result:= SL;
end;

procedure TFStructogram.ShowShape;
begin
  with OldCanvas, OldShape do begin
    Pen.Color:= clRed; //StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
    if Top = Bottom then begin
      MoveTo(Left+1, Top-2);
      LineTo(Right, Top-2);
      MoveTo(Left+1, Top-1);
      LineTo(Right, Top-1);
      MoveTo(Left+1, Top+1);
      LineTo(Right, Top+1);
      MoveTo(Left+1, Top+2);
      LineTo(Right, Top+2);
    end else begin
      MoveTo(Left, Top);
      LineTo(Right, Top);
      LineTo(Right, Bottom);
      LineTo(Left,  Bottom);
      LineTo(Left, Top);
      MoveTo(Left+1, Top+1);
      LineTo(Right-1, Top+1);
      LineTo(Right-1, Bottom-1);
      LineTo(Left+1,  Bottom-1);
      LineTo(Left+1, Top+1);
    end;
  end;
end;

procedure TFStructogram.HideShape;
begin
  if oldShape.top > -1 then begin
    with OldCanvas, OldShape do begin
      Pen.Color:= StyleServices.GetStyleColor(scPanel);
      if Top = Bottom then begin
        MoveTo(Left+1, Top-2);
        LineTo(Right, Top-2);
        MoveTo(Left+1, Top-1);
        LineTo(Right, Top-1);
        MoveTo(Left+1, Top+1);
        LineTo(Right, Top+1);
        MoveTo(Left+1, Top+2);
        LineTo(Right, Top+2);
      end else begin
        MoveTo(Left, Top);
        LineTo(Right, Top);
        LineTo(Right, Bottom);
        LineTo(Left,  Bottom);
        LineTo(Left, Top);
        MoveTo(Left+1, Top+1);
        LineTo(Right-1, Top+1);
        LineTo(Right-1, Bottom-1);
        LineTo(Left+1,  Bottom-1);
        LineTo(Left+1, Top+1);
      end;
    end;
    oldShape:= Rect(-1, -1, -1, -1);
    PaintAll;
  end;
end;

// used by buttons
procedure TFStructogram.StrElementMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var StrList: TStrList; elem: TStrElement;
      PtScreen, PtClient: TPoint;
begin
  if Button = mbLeft then begin
    CloseEdit(True);
    if TSpeedButton(Sender).Tag = 0
      then StrList:= TStrAlgorithm.Create(ScrollBox, PuzzleMode, Font)
      else StrList:= TStrList.Create(Scrollbox, PuzzleMode, Font);
    elem:= nil;
    case TSpeedButton(Sender).Tag of
      ord(nsAlgorithm):  begin
                           elem:= TStrStatement.Create(StrList);
                           StrList.text:= GuiPyLanguageOptions.Algorithm + ' ';
                         end;
      ord(nsStatement):  elem:= TStrStatement.Create(StrList);
      ord(nsIf):         elem:= TStrIf.Create(StrList);
      ord(nsWhile):      begin
                           elem:= TStrWhile.Create(StrList);
                           elem.text:= GuiPyLanguageOptions._While + ' ';
                         end;
      ord(nsFor):        begin
                           elem:= TStrFor.Create(StrList);
                           elem.text:= myStringReplace(myStringReplace(GuiPyLanguageOptions._For, '[', ''), ']', '') + ' ';
                         end;
      ord(nsSwitch):     elem:= TStrSwitch.Create(StrList);
      ord(nsSubprogram): elem:= TStrSubProgram.Create(StrList);
      ord(nsBreak):      elem:= TStrBreak.Create(StrList);
    end;
    StrList.insert(StrList, elem);
    StrList.setFont(Font);
    StrList.ResizeAll;
    PtScreen:= (Sender as TToolButton).ClientToScreen(Point(X, Y));
    PtClient:= StructogramToolbar.ScreenToClient(PtScreen);
    StrList.Image.SetBounds(PtClient.X - StrList.rctList.Width div 2,
                            PtClient.y - StrList.LineHeight div 2,
                            StrList.rctList.Width, StrList.rctList.Height);
    setEvents(StrList.Image);
    StrList.Paint;
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    SetCursorPos(Mouse.CursorPos.X + 30, Mouse.CursorPos.Y);
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
  end;
end;

procedure TFStructogram.ImageDblClick(Sender: TObject);
begin
  curList:= (Sender as TListImage).StrList;
  curElement:= FindVisibleElement(curList, MousePos.X, MousePos.Y);
  DoEdit(CurElement, '');
  IgnoreNextMouseDown:= True;
end;

procedure TFStructogram.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var Image: TListImage;
begin
  if ignoreNextMouseDown then begin
    ignoreNextMouseDown:= False;
    Exit;
  end;
  if IsMoving then Exit;
  Image:= (Sender as TListImage);
  Image.BringToFront;
  curList:= Image.StrList;
  MousePos:= Point(X, Y);
  ScreenMousePos:= Image.ClientToScreen(Point(X, Y));
  if EditMemo.Visible then
    CloseEdit(True);
  curElement:= FindVisibleElement(curList, MousePos.X, MousePos.Y);
  if (Separating = 0) and Assigned(curElement) and Assigned(curElement.prev) then
    if (curElement.prev is TStrAlgorithm) or
       not ((curElement.prev is TStrList) or (curElement is TStrCase)) then
      Separating:= 1;
  UpdateState;
end;

// mouse move over a structogram
procedure TFStructogram.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  ScrollBoxPt, Image2Pt, ScreenPt: TPoint;
  dx, dy, dx1, dy1, i: Integer;
  Image, Image2: TListImage;
  StrList: TStrList; StrStatement: TStrStatement;
  aRect: TRect;
begin
  HideShape;
  if EditMemo.Visible then Exit;
  inherited;

  if ssLeft in Shift then begin
    Image:= (Sender as TListImage);
    curList:= Image.StrList;
    // start moving
    ScreenPt:= Image.ClientToScreen(Point(X, Y));
    ScrollBoxPt:= ScrollBox.ScreenToClient(ScreenPt);
    dx:= ScreenPt.x - ScreenMousePos.x;
    dy:= ScreenPt.y - ScreenMousePos.y;
    if (dx = 0) and (dy = 0) then Exit;

    if (Abs(dx) + Abs(dy) > 5) or IsMoving then begin  // move Image
      IsMoving:= True;
      Modified:= True;
      ScreenMousePos:= ScreenPt;
      curElement:= FindVisibleElement(curList, X - dx, Y - dy);

      // if assigned(curElement) then curElement.debug;

      if Assigned(curElement) and (Separating = 1) then begin
        dx1:= X - curElement.rct.Left;
        dy1:= Y - curelement.rct.Top;
        if curElement.prev = nil then
          Exit;
        aRect:= curElement.rct;
        if (curElement.prev is TStrListHead) or (curElement.prev is TStrCase) or
           (Puzzlemode = 1)
        then begin
          StrStatement:= TStrStatement.Create(curList);
          StrStatement.rct:= curElement.rct;
          ControlCanvas.Font.Assign(Font);
          curList.insert(curElement.prev, StrStatement);
        end;

        if PuzzleMode = 1 then begin // handle single statements, no lists
          curElement.prev.Next:= curElement.Next;
          if Assigned(curElement.Next) then
            curElement.Next.prev:= curElement.prev;
          curElement.prev:= nil;
          curElement.Next:= nil;
        end else begin
          curElement.prev.Next:= nil;
          curElement.prev:= nil;
        end;
        curList.ResizeAll;
        curList.Paint;

        // create new list
        StrList:= TStrList.Create(ScrollBox, PuzzleMode, Font);
        StrList.setFont(Font);
        StrList.insert(StrList, curElement);
        StrList.setList(StrList);
        setEvents(StrList.Image);
        StrList.ResizeAll;
        StrList.rctList.Right:= Max(aRect.Right - aRect.Left, StrList.rctList.Right);
        StrList.rctList.Bottom:= Max(aRect.Bottom - aRect.Top, strList.rctList.Bottom);
        StrList.rct:= StrList.rctList;
        StrList.Image.Left:= Image.Left + aRect.Left + dy;
        StrList.Image.Top := Image.Top + aRect.Top + dx;
        StrList.Paint;
        Separating:= 2;
        CurList.DontMove:= True;
        ignoreNextMouseUp:= True;
        isMoving:= False;
        ScreenPt:= StrList.Image.ClientToScreen(Point(dx1, dy1));
        SetCursorPos(ScreenPt.x, Screenpt.y);
        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        CurList:= StrList;
      end else begin
        // crucial for switching mouse to new image
        Image.SetBounds(Image.Left + dx, Image.Top + dy, Image.Width, Image.Height);
        if curList.DontMove then begin
          Image.SetBounds(Image.Left - dx, Image.Top - dy, Image.Width, Image.Height);
          curList.DontMove:= False;
        end;
        if curList.Kind <> byte(nsAlgorithm) then begin
          for i:= ScrollBox.ControlCount - 1 downto 0 do begin
            Image2:= TListImage(ScrollBox.Controls[i]);
            if Image2 <> Image then begin
              aRect:= Image2.BoundsRect;
              aRect.Inflate(20, 20);
              if aRect.Contains(ScrollBoxPt) then begin
                Image2Pt:= Image2.ScreenToClient(ScreenPt);
                curElement:= FindElement(Image2.StrList, Image2Pt.X, Image2Pt.Y);
                CalculateInsertionShape(Image2.StrList, curList, Image2Pt.X, Image2Pt.Y);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFStructogram.CalculateInsertionShape(DestList, InsertList: TStrList; x, y: Integer);
  var dy: Integer;
begin
  // curElement.debug()
  if curElement = nil then Exit;

  with curElement do
    if not EqualRect(oldShape, Rect(rct.bottom, rct.Left, rct.bottom, rct.Right)) then begin
      if BeforeOrAfter(curElement) then begin
        if Y < curElement.rct.Top + curElement.getMaxDelta then begin
          oldShape:= Rect(rct.Left, rct.top, rct.Right, rct.top);
          CurInsert:= -1;  // insert before
        end else if Y > curElement.rct.Bottom - curElement.getMaxDelta then begin
          if CurElement = List then
            oldShape:= Rect(rct.Left, rct.bottom, List.rctList.Right, rct.bottom)
          else
            oldShape:= Rect(rct.Left, rct.bottom, rct.Right, rct.bottom);
          CurInsert:= +1;  // insert after
        end
      end else begin
        dy:= (curElement.rct.Bottom - curElement.rct.Top) div 4;
        if Y < curElement.rct.Top + dy then begin
          oldShape:= Rect(rct.Left, rct.top, rct.Right, rct.top);
          CurInsert:= -1;
        end else if Y < curElement.rct.Bottom - dy then begin
          oldShape:= Rect(rct.Left + 1, rct.top + 1, rct.Right - 1, rct.bottom - 1);
          CurInsert:= 0;
        end else begin
          oldShape:= Rect(rct.Left, rct.bottom, rct.Right, rct.bottom);
          CurInsert:= +1;
        end;
      end;
      OldCanvas:= DestList.Image.Canvas;
      if FitsIn(InsertList, curElement) then begin
        ShowShape;
        DestList.dirty:= True;
      end;
    end;
end;

procedure TFStructogram.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ScreenPt, q, ScrollBoxPt, Image2Pt: TPoint;
      Image, Image2: TListImage;
      StrList: TStrList;
      i: Integer;
      aRect: TRect;
begin
  IsMoving:= False;
  Image:= (Sender as TListImage);
  StrList:= Image.StrList;

  if ignoreNextMouseUp then begin
    ignoreNextMouseUp:= False;
    Exit;
  end;

  aRect:= StrList.rctList;
  StrList.ResizeAll;
  if aRect <> StrList.rctList then
    StrList.Paint;
  if StrList.Kind in [byte(nsAlgorithm), byte(nsList)] then begin
    ScreenPt:= Image.ClientToScreen(Point(X, Y));
    q:= Self.ScreenToClient(ScreenPt);
    if q.x < ScrollBox.Left then begin
       FreeAndNil(StrList);
       Exit;
    end;
    if q.y < ScrollBox.Top then
      Image.Top:= 0;
  end;
  if StrList.Kind = byte(nsList) then begin
    ScrollBoxPt:= ScrollBox.ScreenToClient(ScreenPt);
    for i:= ScrollBox.ControlCount - 1 downto 0 do begin
      Image2:= TListImage(ScrollBox.Controls[i]);
      aRect:= Image2.BoundsRect;
      aRect.Inflate(30, 30);
      if (Image2 <> Image) and aRect.Contains(ScrollBoxPt) then begin
        Image2Pt:= Image2.ScreenToClient(ScreenPt);
        curElement:= FindElement(Image2.StrList, Image2Pt.X , Image2Pt.Y);
        if Assigned(curElement) and FitsIn(StrList, curElement) then
          InsertElement(Image2.StrList, StrList, curElement);
      end;
    end;
  end;
  Separating:= 0;
  PaintAll;
end;

// dropped on a structogram, insert element
procedure TFStructogram.InsertElement(DestList, InsertList: TStrList; aCurElement: TStrElement);
  var elems, aPrevious: TStrElement;

  procedure Inserted;
  begin
    DestList.ResizeAll;
    DestList.Paint;
    Modified:= True;
    InsertList.Next:= nil;
    FreeAndNil(InsertList);
  end;

begin
  HideShape;
  if Assigned(OldCanvas) then
    OldCanvas.Pen.Mode:= pmCopy;

  InsertList.setList(DestList);
  elems:= InsertList.Next;

  if elems <> nil then begin
    if PuzzleMode = 1 then begin // replace empty statement
      DestList.Insert(aCurElement, elems);
      DestList.deleteElem(aCurElement);
    end else begin
      if (CurInsert = 1) or (aCurElement.prev = nil) then
        DestList.Insert(aCurElement, elems)
      else if CurInsert = 0 then begin
        DestList.Insert(aCurElement, elems);
        DestList.deleteElem(aCurElement);
      end else begin
        aPrevious:= aCurElement.prev;
        DestList.insert(aPrevious, elems);
      end;
    end;
    Inserted;
  end;
  isMoving:= False;
end;

procedure TFStructogram.MIGenerateFunctionClick(Sender: TObject);
begin
  CloseEdit(True);
  if getCurList then
    BBGeneratePythonClick(Self);
end;

procedure TFStructogram.MIPuzzleClick(Sender: TObject);
begin
  if PuzzleMode > 0 then begin
    setPuzzleMode(0);
    Solution:= '';
  end else begin
    if not ((ScrollBox.ControlCount = 1) and (TListImage(Scrollbox.Controls[0]).StrList is TStrAlgorithm)) then begin
      ShowMessage(_('Switch to puzzle mode with the finished solution from a single algorithm structogram.'));
      Exit;
    end;
    setPuzzleMode(1);
    var StrList:= TListImage(ScrollBox.Controls[0]).StrList;
    StrList.setPuzzleMode(1);
    Solution:= StrList.asString;
  end;
end;

procedure TFStructogram.SetPuzzleMode(Mode: Integer);
begin
  PuzzleMode:= Mode;
  if PuzzleMode = 0 then begin
    MIPuzzle.Checked:= False;
    TBPuzzlemode.Visible:= False;
    MISavePuzzleFiles.Visible:= False;
  end else begin
    MIPuzzle.Checked:= True;
    TBPuzzleMode.Visible:= True;
    MISavePuzzleFiles.Visible:= True;
  end;
end;

procedure TFStructogram.MISavePuzzleFilesClick(Sender: TObject);
begin
  if PuzzleMode = 1 then
    Save;
end;

procedure TFStructogram.MISwitchWithCaseLineClick(Sender: TObject);
  var StrList: TStrList;
begin
  if not ReadOnly then begin
    for var i:= 0 to ScrollBox.ControlCount -1 do begin
      StrList:= TListImage(Scrollbox.Controls[i]).StrList;
      StrList.SwitchWithCaseLine:= not StrList.SwitchWithCaseLine;
      StrList.Paint;
    end;
    UpdateState;
  end;
end;

procedure TFStructogram.MIAddCaseClick(Sender: TObject);
  var Switch: TStrSwitch; i: Integer;
begin
  CloseEdit(True);
  if getCurListAndCurElement and (curElement is TStrSwitch) then begin
    Switch:= (curElement as TStrSwitch);
    i:= Length(Switch.case_elems);
    setLength(Switch.case_elems, i+1);
    Switch.case_elems[i]:= Switch.case_elems[i-1];
    Switch.case_elems[i-1]:= TStrListHead.Create(curList, Switch);
    curList.ResizeAll;
    curList.Paint;
    Modified:= True;
    UpdateState;
  end;
end;

procedure TFStructogram.MIDeleteCaseClick(Sender: TObject);
  var Switch: TStrSwitch; x, i, k, n: Integer;
begin
  CloseEdit(True);
  if getCurListAndCurElement and (curElement is TStrSwitch) then begin
    Switch:= (curElement as TStrSwitch);
    x:= MousePos.X;
    i:= 0;
    while (i < Length(Switch.case_elems)) and (x > Switch.case_elems[i].rct.Right) do
      Inc(i);
    FreeAndNil(Switch.case_elems[i]);
    n:= high(Switch.case_elems);
    for k:= i to n - 1 do
      Switch.case_elems[k]:= Switch.case_elems[k+1];
    setLength(Switch.case_elems, n);
    curList.ResizeAll;
    curList.Paint;
    Modified:= True;
    UpdateState;
  end;
end;

procedure TFStructogram.MIDeleteClick(Sender: TObject);
begin
  if getCurListAndCurElement then begin
    if (curElement.Kind = byte(nsAlgorithm)) or
      (Assigned(curElement.prev) and (curElement.prev.Kind = byte(nsList))) then
      FreeAndNil(curList)
    else begin
      curList.deleteElem(curElement);
      curList.ResizeAll;
      curList.Paint;
    end;
    Modified:= True;
    UpdateState;
  end;
end;

procedure TFStructogram.MICopyClick(Sender: TObject);
  var StrList: TStrList;
      Stream: TMemoryStream;
begin
  if getCurList then begin
    Stream:= TMemoryStream.Create();
    try
      curList.SaveToStream(Stream);
      if curList is TStrAlgorithm
        then StrList:= TStrAlgorithm.Create(ScrollBox, PuzzleMode, Font)
        else StrList:= TStrList.Create(Scrollbox, PuzzleMode, Font);
      Stream.Position:= 0;
      StrList.LoadFromStream(stream, Version);
      StrList.setFont(Font);
      StrList.ResizeAll;
      StrList.Image.SetBounds(curList.Image.Left + 30, curList.Image.Top + 30,
                              curList.Image.Width, curList.Image.Height);
      setEvents(StrList.Image);
      StrList.setList(StrList);
      StrList.Paint;
      Modified:= True;
      UpdateState;
    finally
      FreeAndNil(Stream);
    end;
  end;
end;

procedure TFStructogram.MIConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('Structogram');
end;

procedure TFStructogram.MIFontClick(Sender: TObject);
begin
  SelectFont(fkStructogram);
end;

procedure TFStructogram.DoEdit(StrElement: TStrElement; s: string);
  var le, aTop, wi, he: Integer;
      Image: TListImage;
begin
  if Assigned(StrElement) and not ReadOnly then begin
    EditMemoElement:= StrElement;
    Image:= StrElement.List.Image;
    EditMemoBeginText:= StrElement.text;
    EditMemo.Text:= StrElement.text + s;
    le:= StructogramToolbar.Width + Image.Left + StrElement.rct.Left;
    aTop:= Image.Top + StrElement.rct.Top;
    wi:= StrElement.rct.Right - StrElement.rct.Left + 1;
    he:= EditMemo.Lines.Count*StrElement.list.LineHeight + 1;
    he:= Max(StrElement.getHeadHeight + 1, he);

    if StrElement is TStrIf then begin
      wi:= StrElement.list.getWidthOfLines(EditMemo.Text) + 10;
      le:= StructogramToolbar.Width + Image.Left + StrElement.TextPos.x - 5;
    end else if StrElement is TStrSwitch then begin
      le:= StructogramToolbar.Width + Image.Left + StrElement.TextPos.x - 5;
      wi:= Math.Max(100, StrElement.list.getWidthOfLines(EditMemo.Text) + 10);
    end else if (StrElement is TStrSubProgram) then begin
      le:= StructogramToolbar.Width + Image.Left + StrElement.TextPos.x - 5;
      EditMemo.Width:= EditMemo.Width - LEFT_RIGHT;
    end else if (StrElement is TStrBreak) then begin
      le:= StructogramToolbar.Width + Image.Left + StrElement.TextPos.x - 5;
      wi:= EditMemo.Width - LEFT_RIGHT;
    end;

    EditMemo.SetBounds(le + 2, aTop + 2, wi, he);
    setLeftBorderForEditMemo;
    EditMemo.Visible:= True;
    EditMemo.SetFocus;
    EditMemo.Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

procedure TFStructogram.setLeftBorderForEditMemo;
  var R: TRect;
begin
  R:= EditMemo.ClientRect;
  R.Left:= 4;
  SendMessage(EditMemo.Handle, EM_SETRECT,0, Longint(@R)) ;
end;

procedure TFStructogram.EditMemoChange(Sender: TObject);
  var w, h: Integer; aList: TStrList;
begin
  aList:= getList;
  if Assigned(aList) then begin
    aList.getWidthHeigthOfText(EditMemo.Lines.Text, w, h);
    if EditMemo.Height < h then
      EditMemo.Height:= h;
    if EditMemo.Width < w then
      EditMemo.Width:= w;
  end;
  SendMessage(EditMemo.handle, WM_VSCROLL, SB_TOP, 0);
  setLeftBorderForEditMemo;
end;

procedure TFStructogram.CloseEdit(b: Boolean);
begin
  if EditMemo.Visible then begin
    if b and Assigned(EditMemoElement) then begin
      EditMemoElement.text:= EditMemo.text;
      if EditMemo.Text <> EditMemoBeginText then
        Modified:= True;
    end;
    if Assigned(curList) then begin
      curList.ResizeAll;
      curList.Paint;
    end;
    UpdateState;
    EditMemo.Visible:= False;
  end;
end;

procedure TFStructogram.FormKeyPress(Sender: TObject; var Key: Char);
  var s: string;
begin
  if Key = #08
    then s:= ''
    else s:= Key;
  if not EditMemo.Visible then
    DoEdit(curElement, s);
end;

procedure TFStructogram.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
   CutToClipboard
  else if Key = VK_INSERT then
    PasteFromClipboard
  else if (Key = VK_F2) then
    DoEdit(curElement, '');
end;

procedure TFStructogram.BBCloseClick(Sender: TObject);
begin
  (fFile as IFileCommands).ExecClose;
end;

function TFStructogram.getName(StrList: TStrList): string;
begin
  if StrList is TStrAlgorithm then
    Result:= (StrList as TStrAlgorithm).getAlgorithmName;
  if Result = '' then
    Result:= TPath.GetFileNameWithoutExtension(Pathname)
end;

procedure TFStructogram.BBGeneratePythonClick(Sender: TObject);
var
  FileName, aName: string;
  progList: TStringList;
  StrList: TStrList;
  aFile: IFile;
begin
  if curList = nil then curList:= getAlgorithm;
  if curList = nil then curList:= getList;
  if curList = nil then Exit;
  StrList:= curList;
  aName:= getName(StrList);
  FileName:= ExtractFilePath(Pathname) + aName + '.py';
  progList:= TStringList.Create;
  try
    try
      PythonProgram(StrList, progList, aName);
      aFile:= GI_FileFactory.GetFileByNameAndType(FileName, fkEditor);
      if (Assigned(aFile) or FileExists(FileName)) and
         (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [FileName]),
                             mtConfirmation, mbYesNoCancel,0) <> mrYes)
      then
        FileName:= PyIDEMainForm.getFilename('.py');
      if FileName <> '' then begin
        progList.SaveToFile(FileName, TEncoding.UTF8);
        PyIDEMainForm.DoOpen(FileName);
      end;
    except on e: Exception do
      StyledMessageDlg(Format(_(SFileSaveError), [FileName, E.Message]), mtError, [mbOK], 0);
    end;
  finally
    FreeAndNil(progList);
  end;
end;

procedure TFStructogram.BBPuzzleClick(Sender: TObject);
  var i: Integer; StrList: TStrList;
begin
  for i:= ScrollBox.ControlCount - 1 downTo 0 do begin
    StrList:= TListImage(ScrollBox.Controls[i]).StrList;
    if StrList is TStrAlgorithm then begin
      if StrList.asString = Solution
        then ShowMessage(_('Great, solved!'))
        else ShowMessage(_('Try again!'));
      Exit;
    end;
  end;
end;

procedure TFStructogram.BBZoomInClick(Sender: TObject);
begin
  SetFontSize(+1);
end;

procedure TFStructogram.BBZoomOutClick(Sender: TObject);
begin
  SetFontSize(-1);
end;

{$WARNINGS OFF}
procedure TFStructogram.Save;
  var FileName, aPathname, Filepath: string;
      FStructogram: TFileForm; aFile: IFile;
begin
  CloseEdit(True);
  try
    if (PuzzleMode = 1) and (Pos(_('Easy'), Pathname) = 0) then begin
      FileName:= ChangeFileExt(ExtractFilename(Pathname), '');
      Filepath:= ExtractFilePath(Pathname);

      PuzzleMode:= 2;
      aPathname:= Filepath + FileName + _('Medium') + '.psg';
      SaveToFile(aPathname);
      GI_EditorFactory.OpenFile(aPathname);

      PuzzleMode:= 3;
      aPathname:= Filepath + FileName + _('Hard') + '.psg';
      SaveToFile(aPathname);
      GI_EditorFactory.OpenFile(aPathname);

      PuzzleMode:= 4;
      aPathname:= Filepath + FileName + _('VeryHard') + '.psg';
      SaveToFile(aPathname);
      GI_EditorFactory.OpenFile(aPathname);

      aFile:= GI_FileFactory.GetFileByNameAndType(aPathname, fkStructogram);
      if Assigned(aFile) then begin
        FStructogram:= TFStructogram(aFile.Form);
        (FStructogram as TFStructogram).MakeVeryHard;
        (FStructogram as TFStructogram).Save;
      end;

      PuzzleMode:= 1;
      Pathname:= Filepath + FileName + _('Easy') + '.psg';
      SaveToFile(Pathname);
      DoUpdateCaption;
    end else begin
      if ReadOnly then Exit;
      SaveToFile(Pathname);
    end;
    Modified:= False;
  except
    on E: Exception do begin
      ErrorMsg(E.Message);
    end;
  end;

  // debugging
  {
  for var i:= 0 to ScrollBox.ControlCount - 1 do begin
    var aList:= (ScrollBox.Controls[i] as TListImage).StrList;
    aList.debug;
    aList.Paint;
  end;
  }
end;
{$WARNINGS ON}

// Click outside of any image
procedure TFStructogram.ScrollBoxClick(Sender: TObject);
begin
  UpdateState;
  SetFocus;
  CloseEdit(True);
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
end;

procedure TFStructogram.ScrollBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  HideShape;
end;

procedure TFStructogram.DoExport;
  var aBitmap: TBitmap;
begin
  aBitmap:= getBitmap;
  try
    PyIDEMainForm.DoExport(Pathname, aBitmap);
  finally
    FreeAndNil(aBitmap);
    SetFocus;
  end;
end;

procedure TFStructogram.Print;
  var aBitmap: Graphics.TBitmap;
      i: Integer; aRect: TRect; LI: TListImage;
begin
  aRect:= Rect(-1, -1, -1, -1);
  for i:= 0 to ScrollBox.ControlCount - 1 do
    if aRect.Left = -1
      then aRect:= TListImage(ScrollBox.Controls[i]).BoundsRect
      else aRect:= UnionRect(aRect, TListImage(ScrollBox.Controls[i]).BoundsRect);
  aBitmap:= TBitmap.Create;
  aBitmap.Width:=  aRect.Width + GuiPyOptions.StructogramShadowWidth;
  aBitmap.Height:= aRect.Height + GuiPyOptions.StructogramShadowWidth;
  aBitmap.Canvas.Lock;
  try
    for i:= 0 to ScrollBox.ControlCount - 1 do begin
      LI:= TListImage(ScrollBox.Controls[i]);
      aBitmap.Canvas.Draw(LI.Left - aRect.Left, LI.top - aRect.Top, LI.Picture.Graphic);
    end;
    PrintBitmap(aBitmap, PixelsPerInch);
  finally
    aBitmap.Canvas.Unlock;
    FreeAndNil(aBitmap);
  end;
end;

procedure TFStructogram.MICopyAsPictureClick(Sender: TObject);
  var aBitmap: Graphics.TBitmap;
begin
  if getCurList then begin
    aBitmap:= TBitmap.Create;
    try
      aBitmap.Width:= curList.Image.Width + GuiPyOptions.StructogramShadowWidth;
      aBitmap.Height:= curList.Image.Height + GuiPyOptions.StructogramShadowWidth;
      curList.setBlackAndWhite(true);
      aBitmap.Canvas.Draw(0, 0, curList.Image.Picture.Graphic);
      Clipboard.Assign(aBitmap);
      curList.setBlackAndWhite(false);
    finally
      FreeAndNil(aBitmap);
    end;
  end else begin
    CloseEdit(True);
    CopyToClipboard;
  end;
end;

procedure TFStructogram.CopyToClipboard;
  var aBitmap: Graphics.TBitmap;
      i: Integer; aRect: TRect; LI: TListImage;
begin
  if EditMemo.Visible then
    EditMemo.CopyToClipboard
  else if ScrollBox.ControlCount > 0 then begin
    aRect:= TListImage(ScrollBox.Controls[0]).BoundsRect;
    for i:= 1 to ScrollBox.ControlCount - 1 do
      aRect:= UnionRect(aRect, TListImage(ScrollBox.Controls[i]).BoundsRect);
    try
      aBitmap:= TBitmap.Create;
      aBitmap.Width := aRect.Width + GuiPyOptions.StructogramShadowWidth;
      aBitmap.Height:= aRect.Height + GuiPyOptions.StructogramShadowWidth;
      for i:= 0 to ScrollBox.ControlCount - 1 do begin
        LI:= TListImage(ScrollBox.Controls[i]);
        aBitmap.Canvas.Draw(LI.Left - aRect.Left, LI.top - aRect.Top, LI.Picture.Graphic);
      end;
      Clipboard.Assign(aBitmap);
    finally
      FreeAndNil(aBitmap);
    end;
    UpdateState;
  end;
end;

procedure TFStructogram.CutToClipboard;
begin
  if EditMemo.Visible then begin
    EditMemo.CutToClipboard;
    Modified:= True;
    UpdateState;
  end;
end;

function TFStructogram.CanCopy: Boolean;
begin
  Result:= True;
end;

function TFStructogram.CanPaste: Boolean;
begin
  Result:= EditMemo.Visible;
end;

procedure TFStructogram.PasteFromClipboard;
begin
  if EditMemo.Visible then
    EditMemo.PasteFromClipboard
end;

procedure TFStructogram.MIDatatypeClick(Sender: TObject);
  var s: string;
begin
  s:= (Sender as TSpTBXItem).Caption;
  GuiPyOptions.StructoDatatype:= myStringReplace(s, '&', '');
end;

procedure TFStructogram.SetFont(aFont: TFont);
  var i: Integer; StrList: TStrList;
begin
  Font.Assign(aFont);
  for i := 0 to ScrollBox.ControlCount -1 do begin
    StrList:= TListImage(ScrollBox.Controls[i]).StrList;
    StrList.setFont(aFont);
    StrList.setLineHeight;
    StrList.ResizeAll;
    StrList.Paint;
  end;
  Modified:= True;
  GuiPyOptions.StructogramFont.Assign(aFont);
end;

procedure TFStructogram.StructoPopupMenuPopup(Sender: TObject);
  var s: string; i: Integer; found, aParent: TStrElement;
begin
  MIAddCase.Visible:= False;
  MIDeleteCase.Visible:= False;
  MISwitchWithCaseLine.Visible:= False;

  s:= GuiPyOptions.StructoDatatype;
  for i:= 0 to MIDatatype.Count - 1 do
    MIDatatype.Items[i].Checked:= (myStringReplace(MIDatatype.Items[i].Caption, '&', '') = s);

  if getCurList then begin
    MISwitchWithCaseLine.Checked:= curList.SwitchWithCaseLine;
    found:= FindVisibleElement(curList, MousePos.X, MousePos.Y);

    aParent:= getParentElement(found);
    curElement:= nil;
    if Assigned(found) and (found is TStrSwitch) then
      curElement:= found
    else if Assigned(aParent) and (aParent is TStrSwitch) then
      curElement:= aParent;

    if Assigned(curElement) then begin
      MIAddCase.Visible:= True;
      MIDeleteCase.Visible:= (Length((curElement as TStrSwitch).case_elems) > 2);
      MISwitchWithCaseLine.Visible:= True;
    end else
      curElement:= found;
  end;
  MIDelete.Enabled:= Assigned(CurList);
  MICopy.Enabled:= Assigned(CurList);
end;

procedure TFStructogram.UpdateState;
begin
  inherited;
  MISwitchWithCaseLine.Checked:= GuiPyOptions.SwitchWithCaseLine;
  TBStatement.Enabled:= not ReadOnly;
  TBIfElse.Enabled:= not ReadOnly;
  TBifElseIf.Enabled:= not ReadOnly;
  TBWhile.Enabled:= not ReadOnly;
  TBFor.Enabled:= not ReadOnly;
  TBSubprogram.Enabled:= not ReadOnly;
  TBBreak.Enabled:= not ReadOnly;
end;

function TFStructogram.GetSaveAsName: string;
  var StrList: TStrAlgorithm;
begin
  StrList:= getAlgorithm;
  if Assigned(StrList)
    then Result:= StrList.getAlgorithmName
    else Result:= '';
end;

procedure TFStructogram.SetOptions;
begin
  FConfiguration.setToolbarVisibility(StructogramToolbar, 4);
  for var i:= 0 to ScrollBox.ControlCount - 1 do
    if ScrollBox.Controls[i] is TListImage then
      TListImage(ScrollBox.Controls[i]).StrList.Paint;
  var b:= not GuiPyOptions.LockedStructogram;
  TBCreatePythoncode.Enabled:= b;
  MIGenerateFunction.Visible:= b and MIGenerateFunction.Visible;
  MIDatatype.Visible:= b and MIDatatype.Visible;
end;

procedure TFStructogram.AddParameter(list: TStrList; paramList: TStringList);
var
  aText, token, param: string;
  i, typ: Integer;
begin
  i:= Pos('(', list.text);
  if i > 0 then begin
    aText:= Copy(list.text, i+1, Length(list.text));
    typ:= GetToken(aText, token);
    while (typ > 0) and (token <> ')') do begin
      if typ = 1 then begin
        param:= token;
        repeat
          GetToken(aText, token);
          if (token <> ',') and (token <> ')') then
            param:= param + token;
        until (token = '') or (token = ',') or (token = ')');
        paramList.Add(param);
      end;
      typ:= GetToken(aText, token);
    end;
  end;
end;

procedure TFStructogram.AddVariable(aText: string; list: TStringList);
var
  typ: Integer;
  token, variable: string;
begin
  if Pos('=', aText)  > 0 then begin
    aText:= Trim(aText);
    GetToken(aText, variable);
    if Pos('#' + variable + '#', Variables) = 0 then begin
      Variables:= Variables + '#' + variable + '#';  // store of variables;
      GetToken(aText, token);
      typ:= GetToken(aText, token);
      variable:= myStringReplace(variable, ' ', '_');
      case typ of
        2: variable:= variable + ': ' + 'str';
        3: variable:= variable + ': ' + 'bool';
        4: variable:= variable + ': ' + 'int';
        5: variable:= variable + ': ' + 'float';
        6: variable:= variable + ': ' + 'float';
        7: variable:= variable + ': ' + 'str';
      else variable:= variable + ': ' +  DataType;
      end;
      list.Add(variable)
    end;
  end;
end;

function TFStructogram.getAlgorithmParameter(ParamList: TStringList): string;
  var Param, s: string; i: Integer;
begin
  Param:= '';
  for i:= 0 to ParamList.Count - 1 do begin
    s:= Trim(ParamList[i]);
    Param:= Param + s + ', ';
  end;
  if Param <> '' then
    Delete(Param, Length(Param)-1, 2);
  Result:= '(' + Param + ')';
end;

procedure TFStructogram.PythonProgram(list: TStrList; progList: TStringList; const aName: string);
var
  i, j, p: Integer;
  paramList, VariablesList: TStringList;
  Indent, param, typ: string;
begin
  Datatype:= GuiPyOptions.StructoDatatype;
  Variables:= '';
  paramList:= TStringList.Create;
  VariablesList:= TStringList.Create;
  try
    AddParameter(list, paramList);
    Indent:= FConfiguration.Indent1;
    StrElementToPython(list.Next, progList, VariablesList, Indent);
    for i:= 0 to paramList.Count-1 do begin
      param:= ParamList[i];
      if Pos(':', param) = 0 then begin
        j:= 0;
        while j < VariablesList.Count do begin
          if (Pos(param + ':', VariablesList[j]) = 1) then begin
            typ:= Trim(VariablesList[j]);
            p:= Pos(':', typ);
            typ:= Copy(typ, p + 1, Length(typ));
            ParamList[i]:= param + ':' + typ;
            VariablesList.Delete(j);
          end;
          Inc(j);
        end;
      end;
    end;
    progList.Insert(0, 'def ' + aName + getAlgorithmParameter(paramList) + ':');
  finally
    FreeAndNil(VariablesList);
    FreeAndNil(paramList);
  end;
end;

procedure TFStructogram.StrElementToPython(element: TStrElement; pList, VariablesList: TStringList; const indent: string);
var
  i: Integer;
  aText, s, condition, indent1: string;
  SwitchElement: TStrSwitch;

  function StripLNG(const LNG: string; s: string): string;
    var p: Integer;
  begin
    p:= Pos(LNG, s);
    if p > 0 then Delete(s, p, Length(LNG));
    Result:= Trim(s);
  end;

  function ElementInList(s: string): string;
    var i, j: Integer;
  begin
    s:= Trim(s);
    i:= Length(s);
    for j:= 1 to 3 do begin
      while (i > 0) and (s[i] <> ' ') do
        Dec(i);
      Dec(i);
    end;
    Result:= Copy(s, i+2, Length(s));
  end;

  function withoutCrLf(const s: string): string;
  begin
    Result:= myStringReplace(s, CrLf, ' ');
  end;

  function MakeCompareEqual(s: string): string;
    var p: Integer;
  begin
    p:= Pos('=', s);
    if (p > 0) and (p < Length(s)) and (s[p-1] <> '=') and (s[p+1] <> '=') then
      insert('=', s, p);
    Result:= s;
  end;

begin
  indent1:= StringOfChar(' ', EditorOptions.TabWidth);
  while element <> nil do begin
    if element is TStrStatement then begin
      s:= withoutCrLf(element.text);
      if Pos(GuiPyLanguageOptions.Input, s) = 1 then begin
        Delete(s, 1, Length(GuiPyLanguageOptions.Input));
        s:= Trim(s);
        s:= myStringReplace(s, ' ', '_');
        AddVariable( s + '= ;', VariablesList);
        s:= s + ' = ' + DataType + '(input' + '(''' + s + ': ''));';
      end else if Pos(GuiPyLanguageOptions.Output, s) = 1 then begin
        Delete(s, 1, Length(GuiPyLanguageOptions.Output));
        s:= 'print(' + Trim(s) + ')'
      end;
      aText:= indent + s;
      if Trim(s) <> '' then pList.Add(aText);
      // declaration of variables only in TStrStatement possible
      AddVariable(aText, VariablesList);
    end else if element is TStrIf then begin
      condition:= MakeCompareEqual(withoutCrLf(element.text));
      pList.Add(indent + 'if ' + condition + ':');
      StrElementToPython(TStrIf(element).then_elem.Next, pList, VariablesList, indent + indent1);
      if (TStrIf(element).else_elem.Next.text <> '') or (TStrIf(element).else_elem.Next.Next <> nil) then begin
        pList.Add(indent + 'else:');
        StrElementToPython(TStrIf(element).else_elem.Next, pList, VariablesList, indent + indent1);
      end;
    end else if element is TStrFor then begin
      condition:= ElementInList(withoutCrLf(element.text));
      pList.Add(indent + 'for ' + condition + ':');
      StrElementToPython(TStrWhile(element).do_elem.Next, pList, VariablesList, indent + indent1);
    end else if element is TStrWhile then begin
      condition:= stripLNG(GuiPyLanguageOptions._While, withoutCrLf(element.text));
      pList.Add(indent + 'while ' + condition + ':');
      StrElementToPython(TStrWhile(element).do_elem.Next, pList, VariablesList, indent + indent1);
    end else if element is TStrSwitch then begin
      SwitchElement:= element as TStrSwitch;
      for i:= 0 to high(SwitchElement.case_elems)-1 do begin
        if i = 0
          then aText:= 'if '
          else aText:= 'elif ';
        pList.Add(indent + aText + MakeCompareEqual(SwitchElement.case_elems[i].Next.text) + ':');
        StrElementToPython(SwitchElement.case_elems[i].Next.Next, pList, VariablesList, indent + indent1);
      end;
      pList.Add(indent + 'else:');
      i:= high(SwitchElement.case_elems);
      StrElementToPython(SwitchElement.case_elems[i].Next.Next, pList, VariablesList, indent + indent1);
    end else if element is TStrSubProgram then begin
      s:= withoutCrLf(element.text);
      if Trim(s) <> '' then pList.Add(indent + s);
    end else if element is TStrBreak then
      pList.Add(indent + 'break');
    element:= element.Next;
  end;
end;

function TFStructogram.FindElement(current: TStrElement; X, Y: Integer): TStrElement;
var
  ifElement: TStrIf;
  whileElement: TStrWhile;
  switchElement: TStrSwitch;
begin
  while (current <> nil) and (current.Next <> nil) and (Y > current.rct.bottom) do
    current:= current.Next;
  if current is TStrIf then begin                    { search recursively inside IF }
    ifElement:= (current as TStrIf);
    if Y > current.rct.Top + current.getHeadHeight div 2 then
      if X < ifElement.then_elem.rct.Right - 5 then  { except if ±5 from middle}
        current:= FindElement(ifElement.then_elem.Next, X, Y)
      else if X > ifElement.else_elem.rct.Left + 5 then
        current:= FindElement(ifElement.else_elem.Next, X, Y)
  end else if current is TStrWhile then begin        { search recursively inside WHILE/REPEAT/FOR(!) }
    whileElement:= current as TStrWhile;
    if (X > whileElement.do_elem.rct.Left) and
       (Y > current.rct.Top + current.getHeadHeight div 2) then
      current:= FindElement(whileElement.do_elem.Next, X, Y);
  end else if current is TStrSwitch then begin       { search recursively inside SWITCH }
    SwitchElement:= (current as TStrSwitch);
    if Y > current.rct.Top + current.getHeadHeight then
      for var i:= 0 to high(SwitchElement.case_elems) do
        if (SwitchElement.case_elems[i].rct.Left + 5 < X) and {except if ±5 from middle}
           (X < SwitchElement.case_elems[i].rct.Right - 5)
        then begin
          current:= FindElement(SwitchElement.case_elems[i].Next.Next, X, Y);
          Break;
        end;
  end;
  if Assigned(current) and BeforeOrAfter(current) and
    (((Y > current.rct.top + current.getMaxDelta) and
      (Y < current.rct.bottom - current.getMaxDelta)) or
    ((current is TStrAlgorithm) and
     (Y < current.rct.top + current.getMaxDelta))) then
      current:= nil;
  Result:= current;
end;

function TFStructogram.BeforeOrAfter(current: TStrElement): Boolean;
  var TestElement: TStrElement;
begin
  if current is TStrListHead
    then TestElement:= current.Next
    else TestElement:= current;
  Result:= (TestElement.kind <> byte(nsStatement)) or (TestElement.text <> '');
end;

function TFStructogram.FindVisibleElement(current: TStrElement; X, Y: Integer): TStrElement;
var
  ifElement: TStrIf;
  whileElement: TStrWhile;
  switchElement: TStrSwitch;
begin
  while (current <> nil) and (current.Next <> nil) and (Y > current.rct.bottom) do
    current:= current.Next;
  if current is TStrIf then begin                    { search recursively inside IF }
    ifElement:= (current as TStrIf);
    if Y > current.rct.Top + current.getHeadHeight then
      if X <= ifElement.then_elem.rct.Right
        then current:= FindVisibleElement(ifElement.then_elem.Next, X, Y)
        else current:= FindVisibleElement(ifElement.else_elem.Next, X, Y)
  end else if current is TStrWhile then begin        { search recursively inside WHILE/REPEAT/FOR(!) }
    whileElement:= current as TStrWhile;
    if (X > whileElement.do_elem.rct.Left) and (Y > whileElement.do_elem.rct.top) then
      current:= FindVisibleElement(whileElement.do_elem.Next, X, Y);
  end else if current is TStrSwitch then begin       { search recursively inside SWITCH }
    SwitchElement:= (current as TStrSwitch);
    if Y > current.rct.Top + current.getHeadHeight then
      for var i:= 0 to high(SwitchElement.case_elems) do
         if X < SwitchElement.case_elems[i].rct.Right then begin     {except if ±5 from middle}
           current:= FindVisibleElement(SwitchElement.case_elems[i].Next, X, Y);
           Break;                                            // not next.next like in FindElement
         end;
  end;
  Result:= current;
end;

function TFStructogram.getParentElement(element: TStrElement): TStrElement;
  var tmp: TStrElement;
begin
  tmp:= element;
  while Assigned(tmp) and (tmp.prev <> nil) do
    tmp:= tmp.prev;
  if Assigned(tmp) and (tmp is TStrListHead)
    then Result:= TStrListhead(tmp).Parent
    else Result:= nil;
end;

function TFStructogram.GetToken(var S: string; var Token: string): Integer;
{  get next token in <S> and return in <Token>.
   Return type of token: -1=no token, 0=invalid, 1=name, 2=char, 3=boolean, 4=integer,
                         5=real, 6=hex number, 7=string, 8=special char.
}
var
  ch: Char;
  i: Integer;
  hex: Boolean;

  procedure NextCh;
  begin
    Token[i]:= ch;
    Inc(i);
    if i <= Length(s)
      then ch:= S[i]
      else ch:= #0;
  end;

begin
  setLength(Token, 255);
  i:= 1;
  while i <= Length(S) do begin // overread leading blanks and tabs
    ch:= S[i];
    if (ch <> ' ') and (ord(ch) <> 9) then Break;
    Inc(i);
  end;
  Delete(S, 1, i-1);
  if S = '' then begin
    Token:= '';
    Result:= -1;  {no token}
    Exit;
  end;
  i:= 1;
  if not IsWordBreakChar(ch) and not CharInSet(ch, ['0'..'9']) then begin   { name }
    repeat
      NextCh;
    until IsWordBreakChar(ch) and not isDigit(ch) and (ch <> '.') or (i > Length(S));
    Dec(i);
    SetLength(Token, i);
    if (UpperCase(Token) = 'TRUE') or (UpperCase(Token) = 'FALSE') then
      Result:= 3   {boolean}
    else
      Result:= 1;  { name }
  end
  else if (ch = '''') then begin                                    { char }
    NextCh;
    while (ch <> '''') and (ch >= ' ') and (i <= Length(S)) do
      NextCh;
    Token[i]:= '''';
    Result:= 2;  { char }
  end
  else if (ch = '"') then begin                                    { string }
    NextCh;
    while (ch <> '"') and (ch >= ' ') and (i <= Length(S)) do
      NextCh;
    Token[i]:= '"';
    Result:= 7;  { String }
  end
  else begin
    if (ch = '-') then
      NextCh;
    if ('0' <= ch) and (ch <= '9') then begin                       { number }
      hex:=False;
      while True do begin
        NextCh;
        if (ch < '0') or (i > Length(S)) then Break;
        if (ch > '9') then begin
          if ('A' <= UpperCase(ch)) and (UpperCase(ch) <= 'F') then
            hex:=True
          else
            Break;
        end;
      end;
      if (UpperCase(ch) = 'H') then begin                           { hex number }
        NextCh;
        Dec(i);
        Result:= 6;  {hex number}
      end
      else if (ch = '.') then begin                                 { real }
        NextCh;
        while ('0' <= ch) and (ch <= '9') do
          NextCh;
        if (ch = 'E') then
          NextCh;
        if (ch = '+') or (ch = '-') then
          NextCh;
        while ('0' <= ch) and (ch <= '9') do
          NextCh;
        Dec(i);
        if hex then
          Result:= 0   {invalid}
        else
          Result:= 5;  {real number}
      end
      else begin
        if hex then
          Result:= 0   {invalid}
        else
          Result:= 4;  {integer}
      end;
    end
    else begin
      NextCh;
      Dec(i);
      Result:= 8; {special char}
    end;
  end;
  SetLength(Token, i);
  Delete(S, 1, i);
end;

procedure TFStructogram.setEvents(Image: TListImage);
begin
  with Image do begin
    OnDblClick := ImageDblClick;
    OnMouseDown:= ImageMouseDown;
    OnMouseMove:= ImageMouseMove;
    OnMouseUp  := ImageMouseUp;
  end;
end;

function TFStructogram.getAlgorithm: TStrAlgorithm;
  var i: Integer; aList: TStrList;
begin
  Result:= nil;
  for i:= 0 to ScrollBox.ControlCount - 1 do begin
    aList:= TListImage(ScrollBox.controls[i]).StrList;
    if aList is TStrAlgorithm then Exit(aList as TStrAlgorithm);
  end;
end;

function TFStructogram.getListAtScreenPos(Pt: TPoint): TStrList;
begin
  Result:= nil;
  for var i:= 0 to ScrollBox.ControlCount - 1 do
    if ScrollBox.controls[i].BoundsRect.contains(pt) then
      Exit(TListImage(ScrollBox.controls[i]).StrList);
end;

function TFStructogram.getCurList: Boolean;
begin
  var pt:= ScrollBox.ScreenToClient(StructoPopupMenu.PopupPoint);
  curList:= getListAtScreenPos(pt);
  Result:= Assigned(curList);
end;

function TFStructogram.getCurListAndCurElement: Boolean;
begin
  curElement:= nil;
  if getCurList then begin
    var pt:= CurList.Image.ScreenToClient(StructoPopupMenu.PopupPoint);
    curElement:= FindVisibleElement(curList, Pt.X, Pt.Y);
  end;
  Result:= Assigned(curElement);
end;

function TFStructogram.getList: TStrList;
begin
  if ScrollBox.ControlCount = 0
    then Result:= nil
    else Result:= TListImage(ScrollBox.controls[0]).StrList;
end;

function TFStructogram.getBitmap: TBitmap;
  var aRect: TRect;
      i: Integer;
      aBitmap: TBitmap;
begin
  aRect:= rect(-1, -1, -1, -1);
  for i:= 0 to ScrollBox.ControlCount - 1 do
    if aRect.Left = -1
      then aRect:= TListImage(ScrollBox.Controls[i]).BoundsRect
      else aRect:= Unionrect(arect, TListImage(ScrollBox.Controls[i]).BoundsRect);

  aBitmap:= TBitmap.Create;
  aBitmap.Width:=  aRect.Width + GuiPyOptions.StructogramShadowWidth;
  aBitmap.Height:= aRect.Height + GuiPyOptions.StructogramShadowWidth;
  ScrollBox.PaintTo(aBitmap.Canvas.Handle,  -aRect.Left, -aRect.Top);
  Result:= aBitmap;
end;

procedure TFStructogram.PaintAll;
begin
  for var i:= 0 to ScrollBox.ControlCount - 1 do begin
    var aList:= (ScrollBox.Controls[i] as TListImage).StrList;
    if aList.dirty then
      aList.Paint;
    aList.dirty:= False;
  end;
end;

procedure TFStructogram.debug(const s: string);
begin
  MessagesWindow.AddMessage(s);
end;

function TFStructogram.fitsIn(aCurList: TStrList; aCurElement: TStrElement): Boolean;
  var w, h: Integer;
begin
  if PuzzleMode = 0 then
    Result:= True
  else if (aCurElement is TStrListHead) or (aCurElement is TStrCase) or
          ((PuzzleMode = 1) and (CurInsert <> 0)) then
    Result:= False
  else begin
    w:= aCurElement.rct.Right - aCurElement.rct.Left;
    h:= aCurElement.rct.Bottom - aCurElement.rct.Top;
    if PuzzleMode = 1 then
      Result:= (aCurList.rctList.Width = w) and (aCurList.rctList.Height = h)
    else if PuzzleMode = 2 then
      Result:= (aCurList.rctList.Width = w)
    else
      Result:= True;
  end;
end;

procedure TFStructogram.MakeVeryHard;
  var i: Integer; aList: TStrList;
begin
  for i:= 0 to ScrollBox.ControlCount -1 do begin
    aList:= TListImage(ScrollBox.controls[i]).StrList;
    aList.Collapse;
    if aList.Next = nil then
      aList.Destroy
    else begin
      aList.ResizeAll;
      aList.Paint;
    end;
  end;
end;

procedure TFStructogram.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFStructogram.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    StructogramToolbar.Images:= vilToolbarDark;
    TrashImage.ImageIndex:= 29;
    StructoPopupMenu.Images:= vilPopupMenuDark;
  end else begin
    StructogramToolbar.Images:= vilToolbarLight;
    TrashImage.ImageIndex:= 14;
    StructoPopupMenu.Images:= vilPopupMenuLight;
  end;

  for var i:= 0 to ScrollBox.ControlCount -1 do
    if Scrollbox.Controls[i] is TListImage then begin
      var StrList:= TListImage(Scrollbox.Controls[i]).StrList;
      StrList.Paint;
    end;
end;

procedure TFStructogram.DoActivateFile(Primary: Boolean = True);
begin
  inherited;
  Enter(Self);
end;

procedure TFStructogram.DPIChanged;
begin
  setFontSize(0);
  Hide;
  Show;
end;

class function TFStructogram.ToolbarCount: Integer;
begin
  Result:= 13;
end;

end.
