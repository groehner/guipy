{-----------------------------------------------------------------------------
 Unit Name: frmFunctionList
 Author:    Kiriakos Vlahos
 Date:      14-Jun-2005
 Purpose:   Function List window for code navigation
            Adapted from GExperts and covered by its license

GExperts License Agreement
GExperts is copyright 1996-2005 by GExperts, Inc, Erik Berry, and several other
authors who have submitted their code for inclusion. This license agreement only
covers code written by GExperts, Inc and Erik Berry. You should contact the
other authors concerning their respective copyrights and conditions.

The rules governing the use of GExperts and the GExperts source code are derived
from the official Open Source Definition, available at http://www.opensource.org.
The conditions and limitations are as follows:

    * Usage of GExperts binary distributions is permitted for all developers.
      You may not use the GExperts source code to develop proprietary or
      commercial products including plugins or libraries for those products.
      You may use the GExperts source code in an Open Source project, under the
      terms listed below.
    * You may not use the GExperts source code to create and distribute custom
      versions of GExperts under the "GExperts" name. If you do modify and
      distribute custom versions of GExperts, the binary distribution must be
      named differently and clearly marked so users can tell they are not using
      the official GExperts distribution. A visible and unmodified version of
      this license must appear in any modified distribution of GExperts.
    * Custom distributions of GExperts must include all of the custom changes
      as a patch file that can be applied to the original source code. This
      restriction is in place to protect the integrity of the original author's
      source code. No support for modified versions of GExperts will be provided
      by the original authors or on the GExperts mailing lists.
    * All works derived from GExperts must be distributed under a license
      compatible with this license and the official Open Source Definition,
      which can be obtained from http://www.opensource.org/.
    * Please note that GExperts, Inc. and the other contributing authors hereby
      state that this package is provided "as is" and without any express or
      implied warranties, including, but not without limitation, the implied
      warranties of merchantability and fitness for a particular purpose. In
      other words, we accept no liability for any damage that may result from
      using GExperts or programs that use the GExperts source code.

-----------------------------------------------------------------------------}
unit frmFunctionList;

interface

uses
  Winapi.Messages,
  System.Classes,
  System.Actions,
  System.ImageList,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  TB2Dock,
  TB2Toolbar,
  SpTBXItem,
  TB2Item,
  dlgPyIDEBase;

const
  UM_RESIZECOLS = WM_USER + 523;

type
  TProcInfo = class(TObject)
  private
    FLineNo: Integer;
    FChar: Integer;
    FProcClass: string;
    FProcName: string;
    FProcIndex: Integer;
    function GetDisplayName: string;
  public
    property LineNo: Integer read FLineNo write FLineNo;
    property Char: Integer read FChar write FChar;
    property DisplayName: string read GetDisplayName;
    property ProcName: string read FProcName write FProcName;
    property ProcClass: string read FProcClass write FProcClass;
    property ProcIndex: Integer read FProcIndex write FProcIndex;
  end;

  TFunctionListWindow = class(TPyIDEDlgBase)
    pnHolder: TPanel;
    pnlHeader: TPanel;
    dlgProcFont: TFontDialog;
    pnlHeaderLeft: TPanel;
    pnlHeaderRight: TPanel;
    Actions: TActionList;
    actHelpHelp: TAction;
    actViewGoto: TAction;
    actViewAny: TAction;
    actViewStart: TAction;
    actOptionsFont: TAction;
    actEditCopy: TAction;
    lblMethods: TLabel;
    lblObjects: TLabel;
    edtMethods: TEdit;
    cbxObjects: TComboBox;
    ToolBarDock: TSpTBXDock;
    Toolbar: TSpTBXToolbar;
    tbiHelp: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbiViewGoto: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    tbiViewAny: TSpTBXItem;
    tbiViewStart: TSpTBXItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    tbiFont: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    tbiCopy: TSpTBXItem;
    StatusBar: TSpTBXStatusBar;
    LeftStatusLabel: TSpTBXLabelItem;
    SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    RightStatusLabel: TSpTBXLabelItem;
    lvProcs: TListView;
    vilCodeImages: TVirtualImageList;
    vilImages: TVirtualImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtMethodsChange(Sender: TObject);
    procedure edtMethodsKeyPress(Sender: TObject; var Key: Char);
    procedure edtMethodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxObjectsChange(Sender: TObject);
    procedure pnlHeaderResize(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actHelpHelpExecute(Sender: TObject);
    procedure actOptionsFontExecute(Sender: TObject);
    procedure actViewStartExecute(Sender: TObject);
    procedure actViewAnyExecute(Sender: TObject);
    procedure actViewGotoExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lvProcsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvProcsColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormResize(Sender: TObject);
  private
    FSortOnColumn: Integer;
    FSearchAll: Boolean;
    FProcList: TStringList;
    FFileName: string;
    FObjectStrings: TStringList;
    function Signature(ProcInfo: TProcInfo): string;
    procedure QuickSort(L, R: Integer);
    procedure UMResizeCols(var Msg: TMessage); message UM_RESIZECOLS;
    procedure LoadProcs;
    procedure FillListBox;
    procedure ResizeCols;
    procedure GotoCurrentlySelectedProcedure;
    procedure ClearObjectStrings;
    procedure LoadObjectCombobox;
    procedure InitializeForm;
    procedure AddProcedure(ProcedureInfo: TProcInfo);
  public
    constructor CreateWithFileName(AOwner: TComponent; const FileName: string);
    destructor Destroy; override;
    procedure SaveSettings;
    procedure LoadSettings;
  end;

procedure JumpToFunction;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.Generics.Collections,
  System.SysUtils,
  System.StrUtils,
  System.Math,
  System.IOUtils,
  System.JSON,
  Vcl.Graphics,
  Vcl.Clipbrd,
  JvJVCLUtils,
  JvGnugettext,
  dmResources,
  uEditAppIntfs,
  XLSPTypes,
  cLspClients,
  uCommonFunctions;

resourcestring
  SAllString = '<All>';
  SNoneString = '<None>';

constructor TFunctionListWindow.CreateWithFileName(AOwner: TComponent; const FileName: string);
resourcestring
  SParseStatistics = 'Module processed in %g seconds';
var
  LoadTime: DWORD;
begin
  inherited Create(AOwner);

  FFileName := FileName;

  LoadTime := GetTickCount;

  InitializeForm;
  LoadTime := GetTickCount - LoadTime;
  RightStatusLabel.Caption := Format(_(SParseStatistics), [LoadTime / 1000]);
  ResizeCols;
end;

procedure TFunctionListWindow.LoadProcs;

  procedure ProcessSymbol(Symbol: TLSPDocumentSymbol; const ParentClass: string);
  var
    ProcInfo: TProcInfo;
    KlassName: string;
  begin
    KlassName := '';
    case Symbol.kind of
      TLSPSymbolKind.symClass:  KlassName := Symbol.name;
      TLSPSymbolKind.symFunction,
      TLSPSymbolKind.symMethod:
        begin
          ProcInfo := TProcInfo.Create;
          ProcInfo.ProcName := Symbol.name;
          ProcInfo.LineNo := Symbol.selectionRange.start.line + 1;
          ProcInfo.Char := Symbol.selectionRange.start.character + 1;
          if ParentClass <> '' then
          begin
            ProcInfo.FProcClass := ParentClass;
            ProcInfo.ProcIndex := Integer(TCodeImages.Method);
          end else
            ProcInfo.ProcIndex := Integer(TCodeImages.Func);
          AddProcedure(ProcInfo);
        end;
    end;

    for var Child in Symbol.children do
      ProcessSymbol(CHild, KlassName);
  end;

  procedure ProcessSymbolArray(Symbols: TLSPDocumentSymbols);
  begin
    for var Symbol in Symbols do
      ProcessSymbol(Symbol, '');
  end;

begin
  Caption := Caption + ' - ' + TPath.GetFileName(FFileName);
  var DocSymbols := TPyLspClient.DocumentSymbols(FFileName);
  if Length(DocSymbols) = 0 then Exit;

  FProcList.Capacity := 200;
  ClearObjectStrings;
  FProcList.BeginUpdate;
  try
    ProcessSymbolArray(DocSymbols);
  finally
    FProcList.EndUpdate;
    LoadObjectCombobox;
  end;
  QuickSort(0, FProcList.Count - 1);
  RightStatusLabel.Caption := Trim(IntToStr(lvProcs.Items.Count));
end;

procedure TFunctionListWindow.AddProcedure(ProcedureInfo: TProcInfo);
begin
  FProcList.AddObject(#9 + ProcedureInfo.DisplayName + #9 + IntToStr(ProcedureInfo.LineNo), ProcedureInfo);
  if Length(ProcedureInfo.ProcClass) = 0 then
    FObjectStrings.Add(SNoneString)
  else
    FObjectStrings.Add(ProcedureInfo.ProcClass);
end;

procedure TFunctionListWindow.FillListBox;
var
  ProcName: string;
  IsObject: Boolean;
  ProcInfo: TProcInfo;

  procedure AddListItem(ProcInfo: TProcInfo);
  var
    ListItem: TListItem;
  begin
    ListItem := lvProcs.Items.Add;
    ListItem.Caption := '';
    ListItem.ImageIndex := ProcInfo.ProcIndex;
    ListItem.SubItems.Add(ProcInfo.DisplayName);
    ListItem.SubItems.Add(IntToStr(ProcInfo.LineNo));
    ListItem.Data := ProcInfo;
  end;

  procedure FocusAndSelectFirstItem;
  begin
    if lvProcs.Items.Count > 0 then
    begin
      lvProcs.Selected := lvProcs.Items[0];
      lvProcs.ItemFocused := lvProcs.Selected;
    end;
  end;

begin
  lvProcs.Items.BeginUpdate;
  try
    lvProcs.Items.Clear;
    if (Length(edtMethods.Text) = 0) and (cbxObjects.Text = SAllString) then
    begin
      for var I := 0 to FProcList.Count - 1 do
        AddListItem(TProcInfo(FProcList.Objects[I]));
    end
    else
    begin
      for var I := 0 to FProcList.Count - 1 do
      begin
        ProcInfo := TProcInfo(FProcList.Objects[I]);
        IsObject := Length(ProcInfo.ProcClass) > 0;

        // Is it the object we want?
        if cbxObjects.Text <> SAllString then
        begin
          if cbxObjects.Text = SNoneString then
          begin
            if IsObject then // Does it have an object?
              Continue;
            if Length(edtMethods.Text) = 0 then // If no filter is active, add
            begin
              AddListItem(ProcInfo);
              Continue;
            end;
          end // if/then
          else if not SameText(cbxObjects.Text, ProcInfo.ProcClass) then
            Continue;
        end;

        ProcName := ProcInfo.ProcName;

        if Length(edtMethods.Text) = 0 then
          AddListItem(ProcInfo)
        else if not FSearchAll and SameText(edtMethods.Text, Copy(ProcName, 1, Length(edtMethods.Text))) then
          AddListItem(ProcInfo)
        else if FSearchAll and AnsiContainsText(ProcName, edtMethods.Text) then
          AddListItem(ProcInfo);
      end;
    end;
  finally
    lvProcs.Items.EndUpdate;
  end;
  FocusAndSelectFirstItem;
  ResizeCols;
end;

procedure TFunctionListWindow.UMResizeCols(var Msg: TMessage);
begin
  Application.ProcessMessages;
  lvProcs.Columns[1].Width := Max(0, lvProcs.ClientWidth - lvProcs.Columns[2].Width
    - lvProcs.Columns[0].Width);
end;

// This is just a nasty hack to be sure the scroll bar is set right
// before playing with the column widths. We should fix this somehow.
procedure TFunctionListWindow.ResizeCols;
begin
  PostMessage(Self.Handle, UM_RESIZECOLS, 0, 0);
end;

procedure TFunctionListWindow.SaveSettings;
begin
  // Do not localize any of the following lines
  with GI_PyIDEServices.AppStorage do begin
    DeleteSubTree('Function List');
    WriteInteger('Function List\Width', MulDiv(Width, 96, FCurrentPPI));
    WriteInteger('Function List\Height',  MulDiv(Height, 96, FCurrentPPI));

    WriteBoolean('Function List\SearchAll', FSearchAll);
    WriteInteger('Function List\SortColumn', FSortOnColumn);

    var StoredFont := TSmartPtr.Make(TStoredFont.Create)();
    StoredFont.Assign(lvProcs.Font);
    StoredFont.PixelsPerInch := FCurrentPPI;
    StoredFont.Height := lvProcs.Font.Height;
    WritePersistent('Function List\Font', StoredFont);
  end;
end;

procedure TFunctionListWindow.LoadSettings;
begin
  // Do not localize any of the following lines
  with GI_PyIDEServices.AppStorage do begin
    if PathExists('Function List\Width') then
      Width := MulDiv(ReadInteger('Function List\Width', Width), FCurrentPPI, 96);
    if PathExists('Function List\Height') then
      Height := MulDiv(ReadInteger('Function List\Height', Height), FCurrentPPI, 96);

    FSortOnColumn := ReadInteger('Function List\SortColumn', FSortOnColumn);

    {$IF CompilerVersion >= 36}
    lvProcs.Font.IsDPIRelated := True;
    lvProcs.Font.PixelsPerInch := FCurrentPPI;
    {$ENDIF}
    ReadPersistent('Function List\Font', lvProcs.Font);
    {$IF CompilerVersion < 36}
    lvProcs.Font.Height := MulDiv(lvProcs.Font.Height, FCurrentPPI,
      Screen.PixelsPerInch);
    {$ENDIF}

    FSearchAll := ReadBoolean('Function List\SearchAll', True);
    ResizeCols;
  end;
end;

procedure TFunctionListWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSettings;
end;

procedure TFunctionListWindow.FormResize(Sender: TObject);
begin
  ResizeCols;
end;

procedure TFunctionListWindow.QuickSort(L, R: Integer);
resourcestring
  SInvalidIndex = 'Invalid index number';

  function GetValue(Idx: Integer): string;
  begin
    if Idx >= FProcList.Count then
      raise Exception.Create(SInvalidIndex);
    Result := FProcList[Idx];
    for var I := 0 to FSortOnColumn - 1 do
    begin
      var TabPos := Pos(#9, Result);
      if TabPos > 0 then
        Delete(Result, 1, TabPos)
      else
        Exit;
    end;
    if FSortOnColumn = 2 then
    begin
      for var I := Length(Result) to 5 do
        Result := ' ' + Result;
    end;
  end;

var
  I, J: Integer;
  Value: string;
begin
  if FProcList.Count = 0 then
    Exit;
  repeat
    I := L;
    J := R;
    Value := GetValue((L + R) shr 1);
    repeat
      while AnsiCompareText(GetValue(I), Value) < 0 do
        Inc(I);
      while AnsiCompareText(GetValue(J), Value) > 0 do
        Dec(J);
      if I <= J then
      begin
        FProcList.Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TFunctionListWindow.lvProcsColumnClick(Sender: TObject; Column: TListColumn);
var
  Idx: Integer;
  Cursor: IInterface;
begin
  Idx := Column.Index;
  if Idx <> 0 then
  begin
    Cursor := WaitCursor;
    FSortOnColumn := Idx;
    QuickSort(0, FProcList.Count - 1);
    FillListBox;
  end;
end;

procedure TFunctionListWindow.lvProcsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  ProcInfo: TProcInfo;
begin
  ProcInfo := nil;
  if lvProcs.Selected <> nil then
    ProcInfo := lvProcs.Selected.Data;
  if ProcInfo <> nil then
  begin
    LeftStatusLabel.Caption := Signature(ProcInfo);
    RightStatusLabel.Caption := Format('%d/%d', [lvProcs.Selected.Index + 1, lvProcs.Items.Count]);
    actViewGoto.Enabled := (lvProcs.Selected <> nil);
  end;
end;

procedure TFunctionListWindow.edtMethodsChange(Sender: TObject);
begin
  FillListBox;
end;

procedure TFunctionListWindow.edtMethodsKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13:
      begin
        GotoCurrentlySelectedProcedure;
        Key := #0;
      end;
    #27:
      begin
        Close;
        Key := #0;
      end;
  end;
end;

procedure TFunctionListWindow.edtMethodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not (((Key = VK_F4) and (ssAlt in Shift)) or
    (Key in [VK_DELETE, VK_LEFT, VK_RIGHT]) or
    ((Key in [VK_INSERT]) and ((ssShift in Shift) or (ssCtrl in Shift))) or
    ((Key in [VK_HOME, VK_END]) and (ssShift in Shift))) then
  begin
    SendMessage(lvProcs.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TFunctionListWindow.cbxObjectsChange(Sender: TObject);
begin
  FillListBox;
  ResizeCols;
end;

procedure TFunctionListWindow.pnlHeaderResize(Sender: TObject);
begin
  pnlHeaderLeft.Width := (pnlHeader.ClientWidth div 2);
  edtMethods.Width := pnlHeaderLeft.ClientWidth - edtMethods.Left - 8;
  cbxObjects.Width := pnlHeaderRight.ClientWidth - cbxObjects.Left - 8;
end;

procedure TFunctionListWindow.ClearObjectStrings;
begin
  FObjectStrings.Clear;
  FObjectStrings.Add(SAllString);
end;

procedure TFunctionListWindow.LoadObjectCombobox;
begin
  cbxObjects.Items.Assign(FObjectStrings);
  cbxObjects.ItemIndex := cbxObjects.Items.IndexOf(SAllString);
end;

procedure TFunctionListWindow.actEditCopyExecute(Sender: TObject);
var
  Procs: TStringList;
  ProcInfo: TProcInfo;
begin
  Procs := TStringList.Create;
  try
    for var I := 0 to lvProcs.Items.Count - 1 do
    begin
      ProcInfo := TProcInfo(lvProcs.Items[I].Data);
      if ProcInfo <> nil then
        Procs.Add(Signature(ProcInfo));
    end;
  finally
    if Procs.Count > 0 then
      Clipboard.AsText := Procs.Text;
    FreeAndNil(Procs);
  end;
end;

procedure TFunctionListWindow.actHelpHelpExecute(Sender: TObject);
begin
    Application.HelpContext(HelpContext);
end;

procedure TFunctionListWindow.actOptionsFontExecute(Sender: TObject);
begin
  lvProcs.Font.PixelsPerInch := FCurrentPPI;
  dlgProcFont.Font := lvProcs.Font;
  if dlgProcFont.Execute then
    lvProcs.Font.Assign(dlgProcFont.Font);
  {$IF CompilerVersion < 36}
  lvProcs.Font.PixelsPerInch := Screen.PixelsPerInch;
  {$ENDIF}
end;

procedure TFunctionListWindow.actViewStartExecute(Sender: TObject);
begin
  FSearchAll := False;

  FillListBox;
end;

procedure TFunctionListWindow.actViewAnyExecute(Sender: TObject);
begin
  FSearchAll := True;

  FillListBox;
end;

procedure TFunctionListWindow.actViewGotoExecute(Sender: TObject);
begin
  GotoCurrentlySelectedProcedure;
end;

function TFunctionListWindow.Signature(ProcInfo: TProcInfo): string;
begin
//  var BC := BufferCoord(ProcInfo.Char, ProcInfo.LineNo);
//  Result := TPyLspClient.SimpleHintAtCoordinates(FFileName, BC);
//  if Result <> '' then
//    Result := GetLineRange(Result, 1, 1);
  Result := Trim(GetNthSourceLine(FFileName, ProcInfo.LineNo));
  var Index := Result.LastIndexOf(':');
  if Index >= 0 then
    Delete(Result, Index + 1, MaxInt);
  if Result.StartsWith('def') then
    Delete(Result, 1, 3);
  Result := Result.TrimLeft;
end;

procedure TFunctionListWindow.GotoCurrentlySelectedProcedure;
var
  ProcInfo: TProcInfo;
begin
  if lvProcs.Selected <> nil then
  begin
    ProcInfo := lvProcs.Selected.Data;
    if ProcInfo <> nil then
    begin
      GI_PyIDEServices.ShowFilePosition(FFileName, ProcInfo.LineNo, 1);
      ModalResult := mrOk;
    end;
  end;
end;

destructor TFunctionListWindow.Destroy;
begin
  FreeAndNil(FObjectStrings);

  if FProcList <> nil then
  begin
    for var I := 0 to FProcList.Count - 1 do
      FProcList.Objects[I].Free;
    FreeAndNil(FProcList);
  end;

  inherited Destroy;
end;

procedure TFunctionListWindow.InitializeForm;
begin
  FObjectStrings := TStringList.Create;
  FObjectStrings.CaseSensitive := True;
  FObjectStrings.Sorted := True;
  FObjectStrings.Duplicates := dupIgnore;
  ClearObjectStrings;

  FSortOnColumn := 1;

  FProcList := TStringList.Create;

  LoadSettings;
  LoadProcs;

  FillListBox;
end;

procedure TFunctionListWindow.ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  actViewGoto.Enabled := (lvProcs.Selected <> nil);
  actViewStart.Checked := not FSearchAll;
  actViewAny.Checked := FSearchAll;
end;

procedure JumpToFunction;
var
  FileName: string;
  Dlg: TFunctionListWindow;

begin
  if Assigned(GI_ActiveEditor) then begin
    FileName := GI_ActiveEditor.FileId;

    Dlg := TFunctionListWindow.CreateWithFileName(nil, FileName);
    Dlg.cbxObjects.ItemIndex := Dlg.cbxObjects.Items.IndexOf(SAllString);  // not sure why this is needed

    try
      Dlg.ShowModal;
    finally
      FreeAndNil(Dlg);
    end;
  end;
end;

{ TProcInfo }

function TProcInfo.GetDisplayName: string;
begin
  if FProcClass <> '' then
    Result := FProcClass + '.' + FProcName
  else
    Result := FProcName;
end;

end.
