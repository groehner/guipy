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
  Windows,
  Messages,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  Graphics,
  ComCtrls,
  StdCtrls,
  System.ImageList,
  Vcl.ToolWin,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  Vcl.VirtualImage,
  SVGIconImageCollection,
  SpTBXSkins,
  frmFile,
  UTypes,
  SpTBXItem,
  TB2Item;

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
    FEditMemo: TMemo;
    FOldShape: TRect;
    FOldCanvas: TCanvas;
    FCurElement: TStrElement;
    FCurList: TStrList;
    FEditMemoElement: TStrElement;
    FEditMemoBeginText: string;
    FCurInsert: Integer;
    FIsMoving: Boolean;
    FReadOnly: Boolean;
    FMousePos: TPoint;
    FScreenMousePos: TPoint;
    FDataType: string;
    FVariables: string;
    FControlCanvas: TCanvas;
    FIgnoreNextMouseDown: Boolean;
    FIgnoreNextMouseUp: Boolean;
    FSeparating: Integer;
    FPuzzleMode: Integer;
    FSolution: string;
    FVersion: Byte;
    procedure ShowShape;
    procedure HideShape;
    procedure AddParameter(List: TStrList; ParamList: TStringList);
    procedure AddVariable(AText: string; List: TStringList);
    procedure StrElementToPython(Element: TStrElement; PList, VariablesList: TStringList; const Indent: string);
    function FindElement(Current: TStrElement; X, Y: Integer): TStrElement;
    function FindVisibleElement(Current: TStrElement; X, Y: Integer): TStrElement;
    function BeforeOrAfter(Current: TStrElement): Boolean;

    function GetParentElement(Element: TStrElement): TStrElement;
    function GetToken(var Str: string; var Token: string): Integer;
    procedure CalculateInsertionShape(DestList, InsertList: TStrList; X, Y: Integer);
    procedure InsertElement(DestList, InsertList: TStrList; ACurElement: TStrElement);

    procedure Save;
    procedure CutToClipboard;
    procedure UpdateState;

    procedure SetEvents(ListImage: TListImage);
    procedure DoEdit(StrElement: TStrElement; Str: string);
    procedure CloseEdit;
    procedure SetLeftBorderForEditMemo;
    function GetAlgorithmParameter(ParamList: TStringList): string;
    procedure PythonProgram(List: TStrList; ProgList: TStringList; const Name: string);
    function GetAlgorithm: TStrAlgorithm;
    function GetList: TStrList;
    function GetListAtScreenPos(Point: TPoint): TStrList;
    function GetCurList: Boolean;
    function GetCurListAndCurElement: Boolean;
    function GetStructogramAsBitmap: TBitmap;
    function GetName(StrList: TStrList): string;
    procedure PaintAll;
    function FitsIn(ACurList: TStrList; ACurElement: TStrElement): Boolean;
    procedure SetPuzzleMode(Mode: Integer);
    procedure MakeVeryHard;
    procedure ChangeStyle;
    procedure Debug(const Str: string);
  protected
    function OpenFile(const Pathname: string): Boolean; override;
    function LoadFromFile(const FileName: string): Boolean; override;
    function CanPaste: Boolean; override;
    function CanCopy: Boolean; override;
    procedure CopyToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure DoActivateFile(Primary: Boolean = True); override;
    procedure SetFont(AFont: TFont); override;
    procedure Enter(Sender: TObject); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    procedure New;
    procedure Print; override;
    function GetAsStringList: TStringList; override;
    function GetSaveAsName: string;
    procedure FromText(const Source: string);
    procedure RenewFromText(const Source: string);
    procedure DoExport; override;
    procedure SetOptions; override;
    procedure DPIChanged; override;
    class function ToolbarCount: Integer;
end;

implementation

{$R *.DFM}

uses
  SysUtils,
  Math,
  Clipbrd,
  Dialogs,
  Themes,
  Types,
  UITypes,
  Buttons,
  JvGnugettext,
  StringResources,
  IOUtils,
  UUtils,
  UConfiguration,
  frmPyIDEMain,
  uEditAppIntfs,
  uCommonFunctions,
  cPyScripterSettings,
  frmMessages,
  UGenerateStructogram;

procedure TFStructogram.FormCreate(Sender: TObject);
begin
  inherited;
  FOldShape:= Rect(-1, -1, -1, -1);
  FEditMemo:= TMemo.Create(Self);
  FEditMemo.Parent:= Self;
  FEditMemo.SetBounds(136, 156, 99, 37);
  FEditMemo.Color:= StyleServices.GetSystemColor(clSkyBlue);
  FEditMemo.OnChange:= EditMemoChange;
  FEditMemo.Visible:= False;
  FEditMemo.WordWrap:= False;
  FEditMemo.BevelInner:= bvNone;
  FControlCanvas:= TControlCanvas.Create;
  TControlCanvas(FControlCanvas).Control:= ScrollBox;
  Font.Assign(GuiPyOptions.StructogramFont);
  ScrollBox.DoubleBuffered:= True;
  FSeparating:= 0;
  StructogramToolbar.Height:= 308 - 22;
  FVersion:= $0E;
  FCurList:= nil;
  FCurElement:= nil;
  DefaultExtension:= 'psg';
  UpdateState;
  ChangeStyle;
  SetOptions;
  SetPuzzleMode(0);
end;

procedure TFStructogram.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  for var I:= ScrollBox.ControlCount - 1 downto 0 do
    TListImage(ScrollBox.Controls[I]).StrList.Destroy;
  FreeAndNil(FControlCanvas);
  Action:= caFree;
end;

procedure TFStructogram.New;
  var Elem: TStrElement;
      StrList: TStrAlgorithm;
begin
  if Pathname = '' then Pathname:= PyIDEMainForm.getFilename('.psg');
  Caption:= Pathname;
  StrList:= TStrAlgorithm.Create(ScrollBox, FPuzzleMode, Font);
  StrList.Text:= GuiPyLanguageOptions.Algorithm + ' ' + ChangeFileExt(ExtractFileName(Pathname), '');
  Elem:= TStrStatement.Create(StrList);
  StrList.Insert(StrList, Elem);
  SetEvents(StrList.ListImage);
  StrList.ResizeAll;
  StrList.Paint;
  Modified:= False;
  Enter(Self); // must stay!
  SetFocus;
end;

procedure TFStructogram.FromText(const Source: string);
  var Generator: TGenerateStructogram;
      StrList: TStrAlgorithm;
begin
  if Pathname = '' then Pathname:= PyIDEMainForm.getFilename('.psg');
  StrList:= TStrAlgorithm.Create(ScrollBox, FPuzzleMode, Font);
  StrList.Text:= GuiPyLanguageOptions.Algorithm + ' ';
  Generator:= TGenerateStructogram.Create(True);
  try
    Generator.GenerateStructogram(Source, StrList);
  finally
    FreeAndNil(Generator);
  end;
  SetEvents(StrList.ListImage);
  StrList.ResizeAll;
  StrList.Paint;
  MyFile.ExecSave;
  Save;
  Enter(Self); // must stay!
  SetFocus;
end;

procedure TFStructogram.RenewFromText(const Source: string);
  var Generator: TGenerateStructogram;
      StrList: TStrList;
      Alg: string;
begin
  for var I:= ScrollBox.ControlCount - 1 downto 0 do begin
    StrList:= TListImage(ScrollBox.Controls[I]).StrList;
    if StrList is TStrAlgorithm then Alg:= StrList.Text;
    FreeAndNil(StrList);
  end;

  StrList:= TStrAlgorithm.Create(ScrollBox, FPuzzleMode, Font);
  StrList.Text:= Alg;
  SetEvents(StrList.ListImage);
  StrList.Text:= GuiPyLanguageOptions.Algorithm + ' ';
  Generator:= TGenerateStructogram.Create(True);
  try
    Generator.GenerateStructogram(Source, StrList);
  finally
    FreeAndNil(Generator);
  end;
  StrList.ResizeAll;
  StrList.Paint;
  Save;
  Enter(Self); // must stay!
  SetFocus;
end;

function TFStructogram.OpenFile(const Pathname: string): Boolean;
begin
  CloseEdit;
  Result:= inherited;
end;

procedure TFStructogram.Enter(Sender: TObject);
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

  procedure Init(AList: TStrList);
  begin
    AList.SwitchWithCaseLine:= SwitchWithCaseLine;
    AList.SetPuzzleMode(FPuzzleMode);
    AList.SetFont(Font);
    AList.SetLineHeight;
    SetEvents(AList.ListImage);
    AList.ResizeAll;
    AList.Paint;
  end;

begin
  Result:= True;
  try
    Reader:= TStringListReader.Create(FileName);
    try
      repeat
        Reader.ReadLine;
        if Reader.Key = 'FontName' then
          Font.Name:= Reader.Val
        else if Reader.Key = 'FontSize' then
          Font.Size:= PPIScale(StrToInt(Reader.Val))
        else if Reader.Key = 'FontColor' then
          Font.Color:= StrToInt(Reader.Val)
        else if Reader.Key = 'FontBold' then
          if Reader.Val = 'true'
            then Font.Style:= Font.Style + [fsBold]
            else Font.Style:= Font.Style - [fsBold]
        else if Reader.Key = 'FontItalic' then
          if Reader.Val = 'true'
            then Font.Style:= Font.Style + [fsItalic]
            else Font.Style:= Font.Style - [fsItalic]
        else if Reader.Key = 'PuzzleMode' then
          FPuzzleMode:= StrToInt(Reader.Val)
        else if Reader.Key = 'Solution' then
          FSolution:= UnHideCrLf(Reader.Val);
      until (Reader.Key = '- Kind') or (Reader.Key = '');

      while (Reader.Key = '- Kind') and Result do begin
        if Reader.Val = 'Algorithm'
          then StrList:= TStrAlgorithm.Create(ScrollBox, FPuzzleMode, Font)
          else StrList:= TStrList.Create(ScrollBox, FPuzzleMode, Font);
        Reader.ReadLine;
        if Reader.Key = 'SwitchWithCaseLine'
          then SwitchWithCaseLine:= (Reader.Val = 'True')
          else Reader.LineBack;
        StrList.LoadFromReader(Reader);
        Init(StrList);
        Result:= Result and not StrList.LoadError;
        Reader.ReadLine;
      end;
      SetPuzzleMode(FPuzzleMode);
    finally
      FreeAndNil(Reader);
    end;
  except
    on e: Exception do begin
      ErrorMsg(e.Message);
      Result:= False;
    end;
  end;
  FVersion:= $0F;
end;

function TFStructogram.GetAsStringList: TStringList;
  var StringList: TStringList; AList: TStrList;
begin
  StringList:= TStringList.Create;
  StringList.Add( 'PSG: true');
  if Font.Name = 'Arial' then
    Font.Name:= 'Segoe UI';
  StringList.Add('FontName: ' + Font.Name);
  StringList.Add('FontSize: ' + IntToStr(PPIUnScale(Font.Size)));
  if fsBold in Font.Style then
    StringList.Add('FontBold: true');
  if fsItalic in Font.Style then
    StringList.Add('FontItalic: true');
  StringList.Add('FontColor: ' + IntToStr(Font.Color));
  if FPuzzleMode > 0 then begin
    StringList.Add('FPuzzleMode: ' + IntToStr(FPuzzleMode));
    StringList.Add('FSolution: ' + HideCrLf(FSolution));
  end;
  for var I:= 0 to ScrollBox.ControlCount - 1 do begin
    AList:= (ScrollBox.Controls[I] as TListImage).StrList;
    StringList.Add('- Kind: ' + AList.GetKind);
    StringList.Add('  SwitchWithCaseLine: ' + BoolToStr(AList.SwitchWithCaseLine, True));
    StringList.Add('  RectPos' + AList.GetRectPos('  '));
    StringList.Add(AList.GetText('  '));
  end;
  Result:= StringList;
end;

procedure TFStructogram.ShowShape;
begin
  with FOldCanvas, FOldShape do begin
    Pen.Color:= clRed;
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
  if FOldShape.Top > -1 then begin
    with FOldCanvas, FOldShape do begin
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
    FOldShape:= Rect(-1, -1, -1, -1);
    PaintAll;
  end;
end;

// used by buttons
procedure TFStructogram.StrElementMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var StrList: TStrList; Elem: TStrElement;
      PtScreen, PtClient: TPoint;
begin
  if Button = mbLeft then begin
    CloseEdit;
    if TSpeedButton(Sender).Tag = 0
      then StrList:= TStrAlgorithm.Create(ScrollBox, FPuzzleMode, Font)
      else StrList:= TStrList.Create(ScrollBox, FPuzzleMode, Font);
    Elem:= nil;
    case TSpeedButton(Sender).Tag of
      Ord(nsAlgorithm):  begin
                           Elem:= TStrStatement.Create(StrList);
                           StrList.Text:= GuiPyLanguageOptions.Algorithm + ' ';
                         end;
      Ord(nsStatement):  Elem:= TStrStatement.Create(StrList);
      Ord(nsIf):         Elem:= TStrIf.Create(StrList);
      Ord(nsWhile):      begin
                           Elem:= TStrWhile.Create(StrList);
                           Elem.Text:= GuiPyLanguageOptions._While + ' ';
                         end;
      Ord(nsFor):        begin
                           Elem:= TStrFor.Create(StrList);
                           Elem.Text:= myStringReplace(myStringReplace(GuiPyLanguageOptions._For, '[', ''), ']', '') + ' ';
                         end;
      Ord(nsSwitch):     Elem:= TStrSwitch.Create(StrList);
      Ord(nsSubProgram): Elem:= TStrSubprogram.Create(StrList);
      Ord(nsBreak):      Elem:= TStrBreak.Create(StrList);
    end;
    StrList.Insert(StrList, Elem);
    StrList.SetFont(Font);
    StrList.ResizeAll;
    PtScreen:= (Sender as TToolButton).ClientToScreen(Point(X, Y));
    PtClient:= StructogramToolbar.ScreenToClient(PtScreen);
    StrList.ListImage.SetBounds(PtClient.X - StrList.RctList.Width div 2,
                            PtClient.Y - StrList.LineHeight div 2,
                            StrList.RctList.Width, StrList.RctList.Height);
    SetEvents(StrList.ListImage);
    StrList.Paint;
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    SetCursorPos(Mouse.CursorPos.X + 30, Mouse.CursorPos.Y);
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
  end;
end;

procedure TFStructogram.ImageDblClick(Sender: TObject);
begin
  FCurList:= (Sender as TListImage).StrList;
  FCurElement:= FindVisibleElement(FCurList, FMousePos.X, FMousePos.Y);
  DoEdit(FCurElement, '');
  FIgnoreNextMouseDown:= True;
end;

procedure TFStructogram.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ListImage: TListImage;
begin
  if FIgnoreNextMouseDown then begin
    FIgnoreNextMouseDown:= False;
    Exit;
  end;
  if FIsMoving then Exit;
  ListImage:= (Sender as TListImage);
  ListImage.BringToFront;
  FCurList:= ListImage.StrList;
  FMousePos:= Point(X, Y);
  FScreenMousePos:= ListImage.ClientToScreen(Point(X, Y));
  if FEditMemo.Visible then
    CloseEdit;
  FCurElement:= FindVisibleElement(FCurList, FMousePos.X, FMousePos.Y);
  if (FSeparating = 0) and Assigned(FCurElement) and Assigned(FCurElement.Prev) then
    if (FCurElement.Prev is TStrAlgorithm) or
       not ((FCurElement.Prev is TStrList) or (FCurElement is TStrCase)) then
      FSeparating:= 1;
  UpdateState;
end;

// mouse move over a structogram
procedure TFStructogram.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  ScrollBoxPt, Image2Pt, ScreenPt: TPoint;
  DeltaX, DeltaY, DeltaX1, DeltaY1: Integer;
  ListImage, Image2: TListImage;
  StrList: TStrList; StrStatement: TStrStatement;
  ARect: TRect;
begin
  HideShape;
  if FEditMemo.Visible then Exit;
  inherited;
  if ssLeft in Shift then begin
    ListImage:= (Sender as TListImage);
    FCurList:= ListImage.StrList;
    // start moving
    ScreenPt:= ListImage.ClientToScreen(Point(X, Y));
    ScrollBoxPt:= ScrollBox.ScreenToClient(ScreenPt);
    DeltaX:= ScreenPt.X - FScreenMousePos.X;
    DeltaY:= ScreenPt.Y - FScreenMousePos.Y;
    if (DeltaX = 0) and (DeltaY = 0) then Exit;

    if (Abs(DeltaX) + Abs(DeltaY) > 5) or FIsMoving then begin  // move ListImage
      FIsMoving:= True;
      Modified:= True;
      FScreenMousePos:= ScreenPt;
      FCurElement:= FindVisibleElement(FCurList, X - DeltaX, Y - DeltaY);

      // if assigned(FCurElement) then FCurElement.debug

      if Assigned(FCurElement) and (FSeparating = 1) then begin
        DeltaX1:= X - FCurElement.Rct.Left;
        DeltaY1:= Y - FCurElement.Rct.Top;
        if not Assigned(FCurElement.Prev) then
          Exit;
        ARect:= FCurElement.Rct;
        if (FCurElement.Prev is TStrListHead) or (FCurElement.Prev is TStrCase) or
           (FPuzzleMode = 1)
        then begin
          StrStatement:= TStrStatement.Create(FCurList);
          StrStatement.Rct:= FCurElement.Rct;
          FControlCanvas.Font.Assign(Font);
          FCurList.Insert(FCurElement.Prev, StrStatement);
        end;

        if FPuzzleMode = 1 then begin // handle single statements, no lists
          FCurElement.Prev.Next:= FCurElement.Next;
          if Assigned(FCurElement.Next) then
            FCurElement.Next.Prev:= FCurElement.Prev;
          FCurElement.Prev:= nil;
          FCurElement.Next:= nil;
        end else begin
          FCurElement.Prev.Next:= nil;
          FCurElement.Prev:= nil;
        end;
        FCurList.ResizeAll;
        FCurList.Paint;

        // create new List
        StrList:= TStrList.Create(ScrollBox, FPuzzleMode, Font);
        StrList.SetFont(Font);
        StrList.Insert(StrList, FCurElement);
        StrList.SetList(StrList);
        SetEvents(StrList.ListImage);
        StrList.ResizeAll;

        // due to property restrictions
        var Rect := StrList.RctList;
        Rect.Right:= Max(ARect.Right - ARect.Left, StrList.RctList.Right);
        Rect.Bottom:= Max(ARect.Bottom - ARect.Top, StrList.RctList.Bottom);
        StrList.RctList:= Rect;

        StrList.Rct:= StrList.RctList;
        StrList.ListImage.Left:= ListImage.Left + ARect.Left + DeltaY;
        StrList.ListImage.Top := ListImage.Top + ARect.Top + DeltaX;
        StrList.Paint;
        FSeparating:= 2;
        FCurList.DontMove:= True;
        FIgnoreNextMouseUp:= True;
        FIsMoving:= False;
        ScreenPt:= StrList.ListImage.ClientToScreen(Point(DeltaX1, DeltaY1));
        SetCursorPos(ScreenPt.X, ScreenPt.Y);
        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        FCurList:= StrList;
      end else begin
        // crucial for switching mouse to new ListImage
        ListImage.SetBounds(ListImage.Left + DeltaX, ListImage.Top + DeltaY, ListImage.Width, ListImage.Height);
        if FCurList.DontMove then begin
          ListImage.SetBounds(ListImage.Left - DeltaX, ListImage.Top - DeltaY, ListImage.Width, ListImage.Height);
          FCurList.DontMove:= False;
        end;
        if FCurList.Kind <> Byte(nsAlgorithm) then begin
          for var I:= ScrollBox.ControlCount - 1 downto 0 do begin
            Image2:= TListImage(ScrollBox.Controls[I]);
            if Image2 <> ListImage then begin
              ARect:= Image2.BoundsRect;
              ARect.Inflate(20, 20);
              if ARect.Contains(ScrollBoxPt) then begin
                Image2Pt:= Image2.ScreenToClient(ScreenPt);
                FCurElement:= FindElement(Image2.StrList, Image2Pt.X, Image2Pt.Y);
                CalculateInsertionShape(Image2.StrList, FCurList, Image2Pt.X, Image2Pt.Y);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFStructogram.CalculateInsertionShape(DestList, InsertList: TStrList; X, Y: Integer);
begin
  // FCurElement.debug()
  if not Assigned(FCurElement) then Exit;

  with FCurElement do
    if not EqualRect(FOldShape, Rect(Rct.Bottom, Rct.Left, Rct.Bottom, Rct.Right)) then begin
      if BeforeOrAfter(FCurElement) then begin
        if Y < FCurElement.Rct.Top + FCurElement.GetMaxDelta then begin
          FOldShape:= Rect(Rct.Left, Rct.Top, Rct.Right, Rct.Top);
          FCurInsert:= -1;  // Insert before
        end else if Y > FCurElement.Rct.Bottom - FCurElement.GetMaxDelta then begin
          if FCurElement = List then
            FOldShape:= Rect(Rct.Left, Rct.Bottom, List.RctList.Right, Rct.Bottom)
          else
            FOldShape:= Rect(Rct.Left, Rct.Bottom, Rct.Right, Rct.Bottom);
          FCurInsert:= +1;  // Insert after
        end;
      end else begin
        var DeltaY:= (FCurElement.Rct.Bottom - FCurElement.Rct.Top) div 4;
        if Y < FCurElement.Rct.Top + DeltaY then begin
          FOldShape:= Rect(Rct.Left, Rct.Top, Rct.Right, Rct.Top);
          FCurInsert:= -1;
        end else if Y < FCurElement.Rct.Bottom - DeltaY then begin
          FOldShape:= Rect(Rct.Left + 1, Rct.Top + 1, Rct.Right - 1, Rct.Bottom - 1);
          FCurInsert:= 0;
        end else begin
          FOldShape:= Rect(Rct.Left, Rct.Bottom, Rct.Right, Rct.Bottom);
          FCurInsert:= +1;
        end;
      end;
      FOldCanvas:= DestList.ListImage.Canvas;
      if FitsIn(InsertList, FCurElement) then begin
        ShowShape;
        DestList.Dirty:= True;
      end;
    end;
end;

procedure TFStructogram.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ScreenPt, QPoint, ScrollBoxPt, Image2Pt: TPoint;
      ListImage, Image2: TListImage;
      StrList: TStrList;
      ARect: TRect;
begin
  FIsMoving:= False;
  ListImage:= (Sender as TListImage);
  StrList:= ListImage.StrList;

  if FIgnoreNextMouseUp then begin
    FIgnoreNextMouseUp:= False;
    Exit;
  end;

  ARect:= StrList.RctList;
  StrList.ResizeAll;
  if ARect <> StrList.RctList then
    StrList.Paint;
  if StrList.Kind in [Byte(nsAlgorithm), Byte(nsList)] then begin
    ScreenPt:= ListImage.ClientToScreen(Point(X, Y));
    QPoint:= Self.ScreenToClient(ScreenPt);
    if QPoint.X < ScrollBox.Left then begin
       FreeAndNil(StrList);
       Exit;
    end;
    if QPoint.Y < ScrollBox.Top then
      ListImage.Top:= 0;
  end;
  if StrList.Kind = Byte(nsList) then begin
    ScrollBoxPt:= ScrollBox.ScreenToClient(ScreenPt);
    for var I:= ScrollBox.ControlCount - 1 downto 0 do begin
      Image2:= TListImage(ScrollBox.Controls[I]);
      ARect:= Image2.BoundsRect;
      ARect.Inflate(30, 30);
      if (Image2 <> ListImage) and ARect.Contains(ScrollBoxPt) then begin
        Image2Pt:= Image2.ScreenToClient(ScreenPt);
        FCurElement:= FindElement(Image2.StrList, Image2Pt.X , Image2Pt.Y);
        if Assigned(FCurElement) and FitsIn(StrList, FCurElement) then
          InsertElement(Image2.StrList, StrList, FCurElement);
      end;
    end;
  end;
  FSeparating:= 0;
  PaintAll;
end;

// dropped on a structogram, Insert Element
procedure TFStructogram.InsertElement(DestList, InsertList: TStrList; ACurElement: TStrElement);
  var Elems, APrevious: TStrElement;

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
  if Assigned(FOldCanvas) then
    FOldCanvas.Pen.Mode:= pmCopy;

  InsertList.SetList(DestList);
  Elems:= InsertList.Next;

  if Assigned(Elems) then begin
    if FPuzzleMode = 1 then begin // replace empty statement
      DestList.Insert(ACurElement, Elems);
      DestList.DeleteElem(ACurElement);
    end else begin
      if (FCurInsert = 1) or not Assigned(ACurElement.Prev) then
        DestList.Insert(ACurElement, Elems)
      else if FCurInsert = 0 then begin
        DestList.Insert(ACurElement, Elems);
        DestList.DeleteElem(ACurElement);
      end else begin
        APrevious:= ACurElement.Prev;
        DestList.Insert(APrevious, Elems);
      end;
    end;
    Inserted;
  end;
  FIsMoving:= False;
end;

procedure TFStructogram.MIGenerateFunctionClick(Sender: TObject);
begin
  CloseEdit;
  if GetCurList then
    BBGeneratePythonClick(Self);
end;

procedure TFStructogram.MIPuzzleClick(Sender: TObject);
begin
  if FPuzzleMode > 0 then begin
    SetPuzzleMode(0);
    FSolution:= '';
  end else begin
    if not ((ScrollBox.ControlCount = 1) and (TListImage(ScrollBox.Controls[0]).StrList is TStrAlgorithm)) then begin
      ShowMessage(_('Switch to puzzle mode with the finished FSolution from a single algorithm structogram.'));
      Exit;
    end;
    SetPuzzleMode(1);
    var StrList:= TListImage(ScrollBox.Controls[0]).StrList;
    StrList.SetPuzzleMode(1);
    FSolution:= StrList.AsString;
  end;
end;

procedure TFStructogram.SetPuzzleMode(Mode: Integer);
begin
  FPuzzleMode:= Mode;
  if FPuzzleMode = 0 then begin
    MIPuzzle.Checked:= False;
    TBPuzzleMode.Visible:= False;
    MISavePuzzleFiles.Visible:= False;
  end else begin
    MIPuzzle.Checked:= True;
    TBPuzzleMode.Visible:= True;
    MISavePuzzleFiles.Visible:= True;
  end;
end;

procedure TFStructogram.MISavePuzzleFilesClick(Sender: TObject);
begin
  if FPuzzleMode = 1 then
    Save;
end;

procedure TFStructogram.MISwitchWithCaseLineClick(Sender: TObject);
  var StrList: TStrList;
begin
  if not FReadOnly then begin
    for var I:= 0 to ScrollBox.ControlCount -1 do begin
      StrList:= TListImage(ScrollBox.Controls[I]).StrList;
      StrList.SwitchWithCaseLine:= not StrList.SwitchWithCaseLine;
      StrList.Paint;
    end;
    UpdateState;
  end;
end;

procedure TFStructogram.MIAddCaseClick(Sender: TObject);
begin
  CloseEdit;
  if GetCurListAndCurElement and (FCurElement is TStrSwitch) then
  begin
    var
    Switch := (FCurElement as TStrSwitch);
    var
    Int := Length(Switch.CaseElems);
    var
    Elems := Switch.CaseElems;
    SetLength(Elems, Int + 1);
    Switch.CaseElems := Elems;
    Switch.CaseElems[Int] := Switch.CaseElems[Int - 1];
    Switch.CaseElems[Int - 1] := TStrListHead.Create(FCurList, Switch);
    FCurList.ResizeAll;
    FCurList.Paint;
    Modified := True;
    UpdateState;
  end;
end;

procedure TFStructogram.MIDeleteCaseClick(Sender: TObject);
var
  Int, Num: Integer;
begin
  CloseEdit;
  if GetCurListAndCurElement and (FCurElement is TStrSwitch) then
  begin
    var
    Switch := (FCurElement as TStrSwitch);
    Int := 0;
    while (Int < Length(Switch.CaseElems)) and
      (FMousePos.X > Switch.CaseElems[Int].Rct.Right) do
      Inc(Int);
    FreeAndNil(Switch.CaseElems[Int]);
    Num := High(Switch.CaseElems);
    for var K := Int to Num - 1 do
      Switch.CaseElems[K] := Switch.CaseElems[K + 1];
    var
    Elems := Switch.CaseElems;
    SetLength(Elems, Num);
    Switch.CaseElems := Elems;
    FCurList.ResizeAll;
    FCurList.Paint;
    Modified := True;
    UpdateState;
  end;
end;

procedure TFStructogram.MIDeleteClick(Sender: TObject);
begin
  if GetCurListAndCurElement then begin
    if (FCurElement.Kind = Byte(nsAlgorithm)) or
      (Assigned(FCurElement.Prev) and (FCurElement.Prev.Kind = Byte(nsList))) then
      FreeAndNil(FCurList)
    else begin
      FCurList.DeleteElem(FCurElement);
      FCurList.ResizeAll;
      FCurList.Paint;
    end;
    Modified:= True;
    UpdateState;
  end;
end;

procedure TFStructogram.MICopyClick(Sender: TObject);
  var StrList: TStrList;
      Stream: TMemoryStream;
begin
  if GetCurList then begin
    Stream:= TMemoryStream.Create;
    try
      FCurList.SaveToStream(Stream);
      if FCurList is TStrAlgorithm
        then StrList:= TStrAlgorithm.Create(ScrollBox, FPuzzleMode, Font)
        else StrList:= TStrList.Create(ScrollBox, FPuzzleMode, Font);
      Stream.Position:= 0;
      StrList.LoadFromStream(Stream, FVersion);
      StrList.SetFont(Font);
      StrList.ResizeAll;
      StrList.ListImage.SetBounds(FCurList.ListImage.Left + 30, FCurList.ListImage.Top + 30,
                              FCurList.ListImage.Width, FCurList.ListImage.Height);
      SetEvents(StrList.ListImage);
      StrList.SetList(StrList);
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

procedure TFStructogram.DoEdit(StrElement: TStrElement; Str: string);
  var Left, Top, Width, Height: Integer;
      ListImage: TListImage;
begin
  if Assigned(StrElement) and not FReadOnly then begin
    FEditMemoElement:= StrElement;
    ListImage:= StrElement.List.ListImage;
    FEditMemoBeginText:= StrElement.Text;
    FEditMemo.Text:= StrElement.Text + Str;
    Left:= StructogramToolbar.Width + ListImage.Left + StrElement.Rct.Left;
    Top:= ListImage.Top + StrElement.Rct.Top;
    Width:= StrElement.Rct.Right - StrElement.Rct.Left + 1;
    Height:= FEditMemo.Lines.Count*StrElement.List.LineHeight + 1;
    Height:= Max(StrElement.GetHeadHeight + 1, Height);

    if StrElement is TStrIf then begin
      Width:= StrElement.List.GetWidthOfLines(FEditMemo.Text) + 10;
      Left:= StructogramToolbar.Width + ListImage.Left + StrElement.TextPos.X - 5;
    end else if StrElement is TStrSwitch then begin
      Left:= StructogramToolbar.Width + ListImage.Left + StrElement.TextPos.X - 5;
      Width:= Math.Max(100, StrElement.List.GetWidthOfLines(FEditMemo.Text) + 10);
    end else if (StrElement is TStrSubprogram) then begin
      Left:= StructogramToolbar.Width + ListImage.Left + StrElement.TextPos.X - 5;
      FEditMemo.Width:= FEditMemo.Width - LEFT_RIGHT;
    end else if (StrElement is TStrBreak) then begin
      Left:= StructogramToolbar.Width + ListImage.Left + StrElement.TextPos.X - 5;
      Width:= FEditMemo.Width - LEFT_RIGHT;
    end;

    FEditMemo.SetBounds(Left + 2, Top + 2, Width, Height);
    SetLeftBorderForEditMemo;
    FEditMemo.Visible:= True;
    FEditMemo.SetFocus;
    FEditMemo.Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

procedure TFStructogram.SetLeftBorderForEditMemo;
begin
  var Rect:= FEditMemo.ClientRect;
  Rect.Left:= 4;
  SendMessage(FEditMemo.Handle, EM_SETRECT,0, LPARAM(@Rect)) ;
end;

procedure TFStructogram.EditMemoChange(Sender: TObject);
  var Width, Height: Integer; AList: TStrList;
begin
  AList:= GetList;
  if Assigned(AList) then begin
    AList.GetWidthHeigthOfText(FEditMemo.Lines.Text, Width, Height);
    if FEditMemo.Height < Height then
      FEditMemo.Height:= Height;
    if FEditMemo.Width < Width then
      FEditMemo.Width:= Width;
  end;
  SendMessage(FEditMemo.Handle, WM_VSCROLL, SB_TOP, 0);
  SetLeftBorderForEditMemo;
end;

procedure TFStructogram.CloseEdit;
begin
  if FEditMemo.Visible then begin
    if Assigned(FEditMemoElement) then begin
      FEditMemoElement.Text:= FEditMemo.Text;
      if FEditMemo.Text <> FEditMemoBeginText then
        Modified:= True;
    end;
    if Assigned(FCurList) then begin
      FCurList.ResizeAll;
      FCurList.Paint;
    end;
    UpdateState;
    FEditMemo.Visible:= False;
  end;
end;

procedure TFStructogram.FormKeyPress(Sender: TObject; var Key: Char);
  var Str: string;
begin
  if Key = #08
    then Str:= ''
    else Str:= Key;
  if not FEditMemo.Visible then
    DoEdit(FCurElement, Str);
end;

procedure TFStructogram.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
   CutToClipboard
  else if Key = VK_INSERT then
    PasteFromClipboard
  else if (Key = VK_F2) then
    DoEdit(FCurElement, '');
end;

procedure TFStructogram.BBCloseClick(Sender: TObject);
begin
  (MyFile as IFileCommands).ExecClose;
end;

function TFStructogram.GetName(StrList: TStrList): string;
begin
  if StrList is TStrAlgorithm then
    Result:= (StrList as TStrAlgorithm).GetAlgorithmName;
  if Result = '' then
    Result:= TPath.GetFileNameWithoutExtension(Pathname);
end;

procedure TFStructogram.BBGeneratePythonClick(Sender: TObject);
var
  FileName, AName: string;
  ProgList: TStringList;
  StrList: TStrList;
  AFile: IFile;
begin
  if not Assigned(FCurList) then FCurList:= GetAlgorithm;
  if not Assigned(FCurList) then FCurList:= GetList;
  if not Assigned(FCurList) then Exit;
  StrList:= FCurList;
  AName:= GetName(StrList);
  FileName:= ExtractFilePath(Pathname) + AName + '.py';
  ProgList:= TStringList.Create;
  try
    try
      PythonProgram(StrList, ProgList, AName);
      AFile:= GI_FileFactory.GetFileByNameAndType(FileName, fkEditor);
      if (Assigned(AFile) or FileExists(FileName)) and
         (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [FileName]),
                             mtConfirmation, mbYesNoCancel,0) <> mrYes)
      then
        FileName:= PyIDEMainForm.getFilename('.py');
      if FileName <> '' then begin
        ProgList.SaveToFile(FileName, TEncoding.UTF8);
        PyIDEMainForm.DoOpen(FileName);
      end;
    except on E: Exception do
      StyledMessageDlg(Format(_(SFileSaveError), [FileName, E.Message]), mtError, [mbOK], 0);
    end;
  finally
    FreeAndNil(ProgList);
  end;
end;

procedure TFStructogram.BBPuzzleClick(Sender: TObject);
  var StrList: TStrList;
begin
  for var I:= ScrollBox.ControlCount - 1 downto 0 do begin
    StrList:= TListImage(ScrollBox.Controls[I]).StrList;
    if StrList is TStrAlgorithm then begin
      if StrList.AsString = FSolution
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

procedure TFStructogram.Save;
  var FileName, APathname, Filepath: string;
      FStructogram: TFileForm; AFile: IFile;
begin
  CloseEdit;
  try
    if (FPuzzleMode = 1) and (Pos(_('Easy'), Pathname) = 0) then begin
      FileName:= ChangeFileExt(ExtractFileName(Pathname), '');
      Filepath:= ExtractFilePath(Pathname);

      FPuzzleMode:= 2;
      APathname:= Filepath + FileName + _('Medium') + '.psg';
      SaveToFile(APathname);
      GI_EditorFactory.OpenFile(APathname);

      FPuzzleMode:= 3;
      APathname:= Filepath + FileName + _('Hard') + '.psg';
      SaveToFile(APathname);
      GI_EditorFactory.OpenFile(APathname);

      FPuzzleMode:= 4;
      APathname:= Filepath + FileName + _('VeryHard') + '.psg';
      SaveToFile(APathname);
      GI_EditorFactory.OpenFile(APathname);

      AFile:= GI_FileFactory.GetFileByNameAndType(APathname, fkStructogram);
      if Assigned(AFile) then begin
        FStructogram:= TFStructogram(AFile.Form);
        (FStructogram as TFStructogram).MakeVeryHard;
        (FStructogram as TFStructogram).Save;
      end;

      FPuzzleMode:= 1;
      Pathname:= Filepath + FileName + _('Easy') + '.psg';
      SaveToFile(Pathname);
      DoUpdateCaption;
    end else begin
      if FReadOnly then Exit;
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
  for var I:= 0 to ScrollBox.ControlCount - 1 do begin
    var AList:= (ScrollBox.Controls[I] as TListImage).StrList;
    AList.debug;
    AList.Paint;
  end;
  }
end;

// Click outside of any ListImage
procedure TFStructogram.ScrollBoxClick(Sender: TObject);
begin
  UpdateState;
  SetFocus;
  CloseEdit;
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
end;

procedure TFStructogram.ScrollBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  HideShape;
end;

procedure TFStructogram.DoExport;
begin
  var Bitmap := GetStructogramAsBitmap;
  PyIDEMainForm.DoExport(Pathname, Bitmap);
  FreeAndNil(Bitmap);
  if CanFocus then
    SetFocus;
end;

procedure TFStructogram.Print;
begin
  var Bitmap := GetStructogramAsBitmap;
  PrintBitmap(Bitmap, PixelsPerInch);
  FreeAndNil(Bitmap);
end;

procedure TFStructogram.MICopyAsPictureClick(Sender: TObject);
begin
  if GetCurList then
  begin
    var Bitmap := TBitmap.Create;
    try
      Bitmap.Width := FCurList.ListImage.Width +
        GuiPyOptions.StructogramShadowWidth;
      Bitmap.Height := FCurList.ListImage.Height +
        GuiPyOptions.StructogramShadowWidth;
      FCurList.Paint(True);
      Bitmap.Canvas.Draw(0, 0, FCurList.ListImage.Picture.Graphic);
      FCurList.Paint(False);
      Clipboard.Assign(Bitmap);
    finally
      FreeAndNil(Bitmap);
    end;
  end
  else
  begin
    CloseEdit;
    CopyToClipboard;
  end;
end;

procedure TFStructogram.CopyToClipboard;
begin
  if FEditMemo.Visible then
    FEditMemo.CopyToClipboard
  else begin
    var Bitmap:= GetStructogramAsBitmap;
    Clipboard.Assign(Bitmap);
    FreeAndNil(Bitmap);
    UpdateState;
  end;
end;

procedure TFStructogram.CutToClipboard;
begin
  if FEditMemo.Visible then begin
    FEditMemo.CutToClipboard;
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
  Result:= FEditMemo.Visible;
end;

procedure TFStructogram.PasteFromClipboard;
begin
  if FEditMemo.Visible then
    FEditMemo.PasteFromClipboard;
end;

procedure TFStructogram.MIDatatypeClick(Sender: TObject);
begin
  var Str:= (Sender as TSpTBXItem).Caption;
  GuiPyOptions.StructoDatatype:= myStringReplace(Str, '&', '');
end;

procedure TFStructogram.SetFont(AFont: TFont);
  var StrList: TStrList;
begin
  Font.Assign(AFont);
  for var I := 0 to ScrollBox.ControlCount -1 do begin
    StrList:= TListImage(ScrollBox.Controls[I]).StrList;
    StrList.SetFont(AFont);
    StrList.SetLineHeight;
    StrList.ResizeAll;
    StrList.Paint;
  end;
  Modified:= True;
  GuiPyOptions.StructogramFont.Assign(AFont);
end;

procedure TFStructogram.StructoPopupMenuPopup(Sender: TObject);
  var Str: string; Found, AParent: TStrElement;
begin
  MIAddCase.Visible:= False;
  MIDeleteCase.Visible:= False;
  MISwitchWithCaseLine.Visible:= False;

  Str:= GuiPyOptions.StructoDatatype;
  for var I:= 0 to MIDatatype.Count - 1 do
    MIDatatype[I].Checked:= (myStringReplace(MIDatatype[I].Caption, '&', '') = Str);

  if GetCurList then begin
    MISwitchWithCaseLine.Checked:= FCurList.SwitchWithCaseLine;
    Found:= FindVisibleElement(FCurList, FMousePos.X, FMousePos.Y);

    AParent:= GetParentElement(Found);
    FCurElement:= nil;
    if Assigned(Found) and (Found is TStrSwitch) then
      FCurElement:= Found
    else if Assigned(AParent) and (AParent is TStrSwitch) then
      FCurElement:= AParent;

    if Assigned(FCurElement) then begin
      MIAddCase.Visible:= True;
      MIDeleteCase.Visible:= (Length((FCurElement as TStrSwitch).CaseElems) > 2);
      MISwitchWithCaseLine.Visible:= True;
    end else
      FCurElement:= Found;
  end;
  MIDelete.Enabled:= Assigned(FCurList);
  MICopy.Enabled:= Assigned(FCurList);
end;

procedure TFStructogram.UpdateState;
begin
  MISwitchWithCaseLine.Checked:= GuiPyOptions.SwitchWithCaseLine;
  TBStatement.Enabled:= not FReadOnly;
  TBIfElse.Enabled:= not FReadOnly;
  TBIfElseif.Enabled:= not FReadOnly;
  TBWhile.Enabled:= not FReadOnly;
  TBFor.Enabled:= not FReadOnly;
  TBSubprogram.Enabled:= not FReadOnly;
  TBBreak.Enabled:= not FReadOnly;
end;

function TFStructogram.GetSaveAsName: string;
begin
  var StrList:= GetAlgorithm;
  if Assigned(StrList)
    then Result:= StrList.GetAlgorithmName
    else Result:= '';
end;

procedure TFStructogram.SetOptions;
begin
  FConfiguration.setToolbarVisibility(StructogramToolbar, 4);
  for var I:= 0 to ScrollBox.ControlCount - 1 do
    if ScrollBox.Controls[I] is TListImage then
      TListImage(ScrollBox.Controls[I]).StrList.Paint;
  var NotLocked:= not GuiPyOptions.LockedStructogram;
  TBCreatePythonCode.Enabled:= NotLocked;
  MIGenerateFunction.Visible:= NotLocked and MIGenerateFunction.Visible;
  MIDatatype.Visible:= NotLocked and MIDatatype.Visible;
end;

procedure TFStructogram.AddParameter(List: TStrList; ParamList: TStringList);
var
  AText, Token, Param: string;
  Int, Typ: Integer;
begin
  Int:= Pos('(', List.Text);
  if Int > 0 then begin
    AText:= Copy(List.Text, Int+1, Length(List.Text));
    Typ:= GetToken(AText, Token);
    while (Typ > 0) and (Token <> ')') do begin
      if Typ = 1 then begin
        Param:= Token;
        repeat
          GetToken(AText, Token);
          if (Token <> ',') and (Token <> ')') then
            Param:= Param + Token;
        until (Token = '') or (Token = ',') or (Token = ')');
        ParamList.Add(Param);
      end;
      Typ:= GetToken(AText, Token);
    end;
  end;
end;

procedure TFStructogram.AddVariable(AText: string; List: TStringList);
var
  Typ: Integer;
  Token, Variable: string;
begin
  if Pos('=', AText)  > 0 then begin
    AText:= Trim(AText);
    GetToken(AText, Variable);
    if Pos('#' + Variable + '#', FVariables) = 0 then begin
      FVariables:= FVariables + '#' + Variable + '#';  // store of FVariables;
      GetToken(AText, Token);
      Typ:= GetToken(AText, Token);
      Variable:= myStringReplace(Variable, ' ', '_');
      case Typ of
        2: Variable:= Variable + ': ' + 'str';
        3: Variable:= Variable + ': ' + 'bool';
        4: Variable:= Variable + ': ' + 'int';
        5: Variable:= Variable + ': ' + 'float';
        6: Variable:= Variable + ': ' + 'float';
        7: Variable:= Variable + ': ' + 'str';
      else Variable:= Variable + ': ' +  FDataType;
      end;
      List.Add(Variable);
    end;
  end;
end;

function TFStructogram.GetAlgorithmParameter(ParamList: TStringList): string;
  var Param, Str: string;
begin
  Param:= '';
  for var I:= 0 to ParamList.Count - 1 do begin
    Str:= Trim(ParamList[I]);
    Param:= Param + Str + ', ';
  end;
  if Param <> '' then
    Delete(Param, Length(Param) - 1, 2);
  Result:= '(' + Param + ')';
end;

procedure TFStructogram.PythonProgram(List: TStrList; ProgList: TStringList; const Name: string);
var
  JPos, Posi: Integer;
  ParamList, VariablesList: TStringList;
  Indent, Param, Typ: string;
begin
  FDataType:= GuiPyOptions.StructoDatatype;
  FVariables:= '';
  ParamList:= TStringList.Create;
  VariablesList:= TStringList.Create;
  try
    AddParameter(List, ParamList);
    Indent:= FConfiguration.Indent1;
    StrElementToPython(List.Next, ProgList, VariablesList, Indent);
    for var I:= 0 to ParamList.Count-1 do begin
      Param:= ParamList[I];
      if Pos(':', Param) = 0 then begin
        JPos:= 0;
        while JPos < VariablesList.Count do begin
          if (Pos(Param + ':', VariablesList[JPos]) = 1) then begin
            Typ:= Trim(VariablesList[JPos]);
            Posi:= Pos(':', Typ);
            Typ:= Copy(Typ, Posi + 1, Length(Typ));
            ParamList[I]:= Param + ':' + Typ;
            VariablesList.Delete(JPos);
          end;
          Inc(JPos);
        end;
      end;
    end;
    ProgList.Insert(0, 'def ' + Name + GetAlgorithmParameter(ParamList) + ':');
  finally
    FreeAndNil(VariablesList);
    FreeAndNil(ParamList);
  end;
end;

procedure TFStructogram.StrElementToPython(Element: TStrElement; PList, VariablesList: TStringList; const Indent: string);
var
  Int: Integer;
  AText, Str, Condition, Indent1: string;
  SwitchElement: TStrSwitch;

  function StripLNG(const LNG: string; Str: string): string;
  begin
    var Posi:= Pos(LNG, Str);
    if Posi > 0 then Delete(Str, Posi, Length(LNG));
    Result:= Trim(Str);
  end;

  function ElementInList(Str: string): string;
  begin
    Str:= Trim(Str);
    var Len:= Length(Str);
    for var J:= 1 to 3 do begin
      while (Len > 0) and (Str[Len] <> ' ') do
        Dec(Len);
      Dec(Len);
    end;
    Result:= Copy(Str, Len + 2, Length(Str));
  end;

  function withoutCrLf(const Str: string): string;
  begin
    Result:= myStringReplace(Str, CrLf, ' ');
  end;

  function MakeCompareEqual(Str: string): string;
  begin
    var Posi:= Pos('=', Str);
    if (Posi > 0) and (Posi < Length(Str)) and (Str[Posi-1] <> '=') and (Str[Posi+1] <> '=') then
      Insert('=', Str, Posi);
    Result:= Str;
  end;

begin
  Indent1:= StringOfChar(' ', GEditorOptions.TabWidth);
  while Assigned(Element) do begin
    if Element is TStrStatement then begin
      Str:= withoutCrLf(Element.Text);
      if Pos(GuiPyLanguageOptions.Input, Str) = 1 then begin
        Delete(Str, 1, Length(GuiPyLanguageOptions.Input));
        Str:= Trim(Str);
        Str:= myStringReplace(Str, ' ', '_');
        AddVariable( Str + '= ;', VariablesList);
        Str:= Str + ' = ' + FDataType + '(input' + '(''' + Str + ': ''));';
      end else if Pos(GuiPyLanguageOptions.Output, Str) = 1 then begin
        Delete(Str, 1, Length(GuiPyLanguageOptions.Output));
        Str:= 'print(' + Trim(Str) + ')';
      end;
      AText:= Indent + Str;
      if Trim(Str) <> '' then PList.Add(AText);
      // declaration of variables only in TStrStatement possible
      AddVariable(AText, VariablesList);
    end else if Element is TStrIf then begin
      Condition:= MakeCompareEqual(withoutCrLf(Element.Text));
      PList.Add(Indent + 'if ' + Condition + ':');
      StrElementToPython(TStrIf(Element).ThenElem.Next, PList, VariablesList, Indent + Indent1);
      if (TStrIf(Element).ElseElem.Next.Text <> '') or (TStrIf(Element).ElseElem.Next.Next <> nil) then begin
        PList.Add(Indent + 'else:');
        StrElementToPython(TStrIf(Element).ElseElem.Next, PList, VariablesList, Indent + Indent1);
      end;
    end else if Element is TStrFor then begin
      Condition:= ElementInList(withoutCrLf(Element.Text));
      PList.Add(Indent + 'for ' + Condition + ':');
      StrElementToPython(TStrWhile(Element).DoElem.Next, PList, VariablesList, Indent + Indent1);
    end else if Element is TStrWhile then begin
      Condition:= StripLNG(GuiPyLanguageOptions._While, withoutCrLf(Element.Text));
      PList.Add(Indent + 'while ' + Condition + ':');
      StrElementToPython(TStrWhile(Element).DoElem.Next, PList, VariablesList, Indent + Indent1);
    end else if Element is TStrSwitch then begin
      SwitchElement:= Element as TStrSwitch;
      for Int:= 0 to High(SwitchElement.CaseElems)-1 do begin
        if Int = 0
          then AText:= 'if '
          else AText:= 'elif ';
        PList.Add(Indent + AText + MakeCompareEqual(SwitchElement.CaseElems[Int].Next.Text) + ':');
        StrElementToPython(SwitchElement.CaseElems[Int].Next.Next, PList, VariablesList, Indent + Indent1);
      end;
      PList.Add(Indent + 'else:');
      Int:= High(SwitchElement.CaseElems);
      StrElementToPython(SwitchElement.CaseElems[Int].Next.Next, PList, VariablesList, Indent + Indent1);
    end else if Element is TStrSubprogram then begin
      Str:= withoutCrLf(Element.Text);
      if Trim(Str) <> '' then PList.Add(Indent + Str);
    end else if Element is TStrBreak then
      PList.Add(Indent + 'break');
    Element:= Element.Next;
  end;
end;

function TFStructogram.FindElement(Current: TStrElement; X, Y: Integer): TStrElement;
var
  IfElement: TStrIf;
  WhileElement: TStrWhile;
  SwitchElement: TStrSwitch;
begin
  while Assigned(Current) and Assigned(Current.Next) and (Y > Current.Rct.Bottom) do
    Current:= Current.Next;
  if Current is TStrIf then begin                    { search recursively inside IF }
    IfElement:= (Current as TStrIf);
    if Y > Current.Rct.Top + Current.GetHeadHeight div 2 then
      if X < IfElement.ThenElem.Rct.Right - 5 then  { except if ±5 from middle}
        Current:= FindElement(IfElement.ThenElem.Next, X, Y)
      else if X > IfElement.ElseElem.Rct.Left + 5 then
        Current:= FindElement(IfElement.ElseElem.Next, X, Y);
  end else if Current is TStrWhile then begin        { search recursively inside WHILE/REPEAT/FOR(!) }
    WhileElement:= Current as TStrWhile;
    if (X > WhileElement.DoElem.Rct.Left) and
       (Y > Current.Rct.Top + Current.GetHeadHeight div 2) then
      Current:= FindElement(WhileElement.DoElem.Next, X, Y);
  end else if Current is TStrSwitch then begin       { search recursively inside SWITCH }
    SwitchElement:= (Current as TStrSwitch);
    if Y > Current.Rct.Top + Current.GetHeadHeight then
      for var I:= 0 to High(SwitchElement.CaseElems) do
        if (SwitchElement.CaseElems[I].Rct.Left + 5 < X) and {except if ±5 from middle}
           (X < SwitchElement.CaseElems[I].Rct.Right - 5)
        then begin
          Current:= FindElement(SwitchElement.CaseElems[I].Next.Next, X, Y);
          Break;
        end;
  end;
  if Assigned(Current) and BeforeOrAfter(Current) and
    (((Y > Current.Rct.Top + Current.GetMaxDelta) and
      (Y < Current.Rct.Bottom - Current.GetMaxDelta)) or
    ((Current is TStrAlgorithm) and
     (Y < Current.Rct.Top + Current.GetMaxDelta))) then
      Current:= nil;
  Result:= Current;
end;

function TFStructogram.BeforeOrAfter(Current: TStrElement): Boolean;
  var TestElement: TStrElement;
begin
  if Current is TStrListHead
    then TestElement:= Current.Next
    else TestElement:= Current;
  Result:= (TestElement.Kind <> Byte(nsStatement)) or (TestElement.Text <> '');
end;

function TFStructogram.FindVisibleElement(Current: TStrElement; X, Y: Integer): TStrElement;
var
  IfElement: TStrIf;
  WhileElement: TStrWhile;
  SwitchElement: TStrSwitch;
begin
  while Assigned(Current) and Assigned(Current.Next) and (Y > Current.Rct.Bottom) do
    Current:= Current.Next;
  if Current is TStrIf then begin                    { search recursively inside IF }
    IfElement:= (Current as TStrIf);
    if Y > Current.Rct.Top + Current.GetHeadHeight then
      if X <= IfElement.ThenElem.Rct.Right
        then Current:= FindVisibleElement(IfElement.ThenElem.Next, X, Y)
        else Current:= FindVisibleElement(IfElement.ElseElem.Next, X, Y);
  end else if Current is TStrWhile then begin        { search recursively inside WHILE/REPEAT/FOR(!) }
    WhileElement:= Current as TStrWhile;
    if (X > WhileElement.DoElem.Rct.Left) and (Y > WhileElement.DoElem.Rct.Top) then
      Current:= FindVisibleElement(WhileElement.DoElem.Next, X, Y);
  end else if Current is TStrSwitch then begin       { search recursively inside SWITCH }
    SwitchElement:= (Current as TStrSwitch);
    if Y > Current.Rct.Top + Current.GetHeadHeight then
      for var I:= 0 to High(SwitchElement.CaseElems) do
         if X < SwitchElement.CaseElems[I].Rct.Right then begin     {except if ±5 from middle}
           Current:= FindVisibleElement(SwitchElement.CaseElems[I].Next, X, Y);
           Break;                                            // not next.next like in FindElement
         end;
  end;
  Result:= Current;
end;

function TFStructogram.GetParentElement(Element: TStrElement): TStrElement;
begin
  var Tmp:= Element;
  while Assigned(Tmp) and Assigned(Tmp.Prev) do
    Tmp:= Tmp.Prev;
  if Assigned(Tmp) and (Tmp is TStrListHead)
    then Result:= TStrListHead(Tmp).Parent
    else Result:= nil;
end;

function TFStructogram.GetToken(var Str: string; var Token: string): Integer;
{  get next Token in <Str> and return in <Token>.
   Return type of Token: -1=no Token, 0=invalid, 1=name, 2=char, 3=boolean, 4=integer,
                         5=real, 6=Hex number, 7=string, 8=special char.
}
var
  Chr: Char;
  Int: Integer;
  Hex: Boolean;

  procedure NextCh;
  begin
    Token[Int]:= Chr;
    Inc(Int);
    if Int <= Length(Str)
      then Chr:= Str[Int]
      else Chr:= #0;
  end;

begin
  SetLength(Token, 255);
  Int:= 1;
  while Int <= Length(Str) do begin // overread leading blanks and tabs
    Chr:= Str[Int];
    if (Chr <> ' ') and (Ord(Chr) <> 9) then Break;
    Inc(Int);
  end;
  Delete(Str, 1, Int-1);
  if Str = '' then begin
    Token:= '';
    Result:= -1;  {no Token}
    Exit;
  end;
  Int:= 1;
  if not IsWordBreakChar(Chr) and not CharInSet(Chr, ['0'..'9']) then begin   { name }
    repeat
      NextCh;
    until IsWordBreakChar(Chr) and not IsDigit(Chr) and (Chr <> '.') or (Int > Length(Str));
    Dec(Int);
    SetLength(Token, Int);
    if (UpperCase(Token) = 'TRUE') or (UpperCase(Token) = 'FALSE') then
      Result:= 3   {boolean}
    else
      Result:= 1;  { name }
  end
  else if (Chr = '''') then begin                                    { char }
    NextCh;
    while (Chr <> '''') and (Chr >= ' ') and (Int <= Length(Str)) do
      NextCh;
    Token[Int]:= '''';
    Result:= 2;  { char }
  end
  else if (Chr = '"') then begin                                    { string }
    NextCh;
    while (Chr <> '"') and (Chr >= ' ') and (Int <= Length(Str)) do
      NextCh;
    Token[Int]:= '"';
    Result:= 7;  { String }
  end
  else begin
    if (Chr = '-') then
      NextCh;
    if ('0' <= Chr) and (Chr <= '9') then begin                       { number }
      Hex:=False;
      while True do begin
        NextCh;
        if (Chr < '0') or (Int > Length(Str)) then Break;
        if (Chr > '9') then begin
          if ('A' <= UpperCase(Chr)) and (UpperCase(Chr) <= 'F') then
            Hex:=True
          else
            Break;
        end;
      end;
      if (UpperCase(Chr) = 'H') then begin                           { Hex number }
        NextCh;
        Dec(Int);
        Result:= 6;  {Hex number}
      end
      else if (Chr = '.') then begin                                 { real }
        NextCh;
        while ('0' <= Chr) and (Chr <= '9') do
          NextCh;
        if (Chr = 'E') then
          NextCh;
        if (Chr = '+') or (Chr = '-') then
          NextCh;
        while ('0' <= Chr) and (Chr <= '9') do
          NextCh;
        Dec(Int);
        if Hex then
          Result:= 0   {invalid}
        else
          Result:= 5;  {real number}
      end
      else begin
        if Hex then
          Result:= 0   {invalid}
        else
          Result:= 4;  {integer}
      end;
    end
    else begin
      NextCh;
      Dec(Int);
      Result:= 8; {special char}
    end;
  end;
  SetLength(Token, Int);
  Delete(Str, 1, Int);
end;

procedure TFStructogram.SetEvents(ListImage: TListImage);
begin
  with ListImage do begin
    OnDblClick := ImageDblClick;
    OnMouseDown:= ImageMouseDown;
    OnMouseMove:= ImageMouseMove;
    OnMouseUp  := ImageMouseUp;
  end;
end;

function TFStructogram.GetAlgorithm: TStrAlgorithm;
begin
  Result:= nil;
  for var I:= 0 to ScrollBox.ControlCount - 1 do begin
    var AList:= TListImage(ScrollBox.Controls[I]).StrList;
    if AList is TStrAlgorithm then Exit(AList as TStrAlgorithm);
  end;
end;

function TFStructogram.GetListAtScreenPos(Point: TPoint): TStrList;
begin
  Result:= nil;
  for var I:= 0 to ScrollBox.ControlCount - 1 do
    if ScrollBox.Controls[I].BoundsRect.Contains(Point) then
      Exit(TListImage(ScrollBox.Controls[I]).StrList);
end;

function TFStructogram.GetCurList: Boolean;
begin
  var Point:= ScrollBox.ScreenToClient(StructoPopupMenu.PopupPoint);
  FCurList:= GetListAtScreenPos(Point);
  Result:= Assigned(FCurList);
end;

function TFStructogram.GetCurListAndCurElement: Boolean;
begin
  FCurElement:= nil;
  if GetCurList then begin
    var Point:= FCurList.ListImage.ScreenToClient(StructoPopupMenu.PopupPoint);
    FCurElement:= FindVisibleElement(FCurList, Point.X, Point.Y);
  end;
  Result:= Assigned(FCurElement);
end;

function TFStructogram.GetList: TStrList;
begin
  if ScrollBox.ControlCount = 0
    then Result:= nil
    else Result:= TListImage(ScrollBox.Controls[0]).StrList;
end;

function TFStructogram.GetStructogramAsBitmap: TBitmap;
var
  ARect: TRect;
  Bitmap: TBitmap;
begin
  for var I := 0 to ScrollBox.ControlCount - 1 do
    if ScrollBox.Controls[I] is TListImage then
      TListImage(ScrollBox.Controls[I]).StrList.Paint(True);

  ARect := Rect(-1, -1, -1, -1);
  for var I := 0 to ScrollBox.ControlCount - 1 do
    if ARect.Left = -1 then
      ARect := TListImage(ScrollBox.Controls[I]).BoundsRect
    else
      ARect := UnionRect(ARect, TListImage(ScrollBox.Controls[I]).BoundsRect);
  Bitmap := TBitmap.Create;
  Bitmap.Width := ARect.Width + GuiPyOptions.StructogramShadowWidth;
  Bitmap.Height := ARect.Height + GuiPyOptions.StructogramShadowWidth;
  for var I := 0 to ScrollBox.ControlCount - 1 do begin
    var ListImage := TListImage(ScrollBox.Controls[I]);
    Bitmap.Canvas.Draw(ListImage.Left - ARect.Left, ListImage.Top - ARect.Top, ListImage.Picture.Graphic);
  end;
  Result := Bitmap;

  for var I := 0 to ScrollBox.ControlCount - 1 do
    if ScrollBox.Controls[I] is TListImage then
      TListImage(ScrollBox.Controls[I]).StrList.Paint(False);
end;

procedure TFStructogram.PaintAll;
begin
  for var I:= 0 to ScrollBox.ControlCount - 1 do begin
    var AList:= (ScrollBox.Controls[I] as TListImage).StrList;
    if AList.Dirty then
      AList.Paint;
    AList.Dirty:= False;
  end;
end;

procedure TFStructogram.Debug(const Str: string);
begin
  MessagesWindow.AddMessage(Str);
end;

function TFStructogram.FitsIn(ACurList: TStrList; ACurElement: TStrElement): Boolean;
  var Width, Height: Integer;
begin
  if FPuzzleMode = 0 then
    Result:= True
  else if (ACurElement is TStrListHead) or (ACurElement is TStrCase) or
          ((FPuzzleMode = 1) and (FCurInsert <> 0)) then
    Result:= False
  else begin
    Width:= ACurElement.Rct.Right - ACurElement.Rct.Left;
    Height:= ACurElement.Rct.Bottom - ACurElement.Rct.Top;
    if FPuzzleMode = 1 then
      Result:= (ACurList.RctList.Width = Width) and (ACurList.RctList.Height = Height)
    else if FPuzzleMode = 2 then
      Result:= (ACurList.RctList.Width = Width)
    else
      Result:= True;
  end;
end;

procedure TFStructogram.MakeVeryHard;
begin
  for var I:= 0 to ScrollBox.ControlCount -1 do begin
    var AList:= TListImage(ScrollBox.Controls[I]).StrList;
    AList.Collapse;
    if not Assigned(AList.Next) then
      AList.Destroy
    else begin
      AList.ResizeAll;
      AList.Paint;
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

  for var I:= 0 to ScrollBox.ControlCount -1 do
    if ScrollBox.Controls[I] is TListImage then begin
      var StrList:= TListImage(ScrollBox.Controls[I]).StrList;
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
  SetFontSize(0);
  Hide;
  Show;
end;

class function TFStructogram.ToolbarCount: Integer;
begin
  Result:= 13;
end;

end.
