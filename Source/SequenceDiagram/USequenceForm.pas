{-------------------------------------------------------------------------------
 Unit:     USequenceForm
 Author:   Gerhard R�hner
 Date:     July 2019
 Purpose:  sequence diagram editor
-------------------------------------------------------------------------------}

unit USequenceForm;

{ future work: let debugger generate a sequence diagram.

  In an UML window, a sequence diagram symbol opens a form with the same
  name but psd, the sequence diagram belonging to the UML window.

  Debugger must have sequence window or it is nil.

}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, ComCtrls,
  ExtCtrls, StdCtrls, Toolwin, ImgList, ImageList,
  uEditAppIntfs, SpTBXSkins, frmFile, USequencePanel, ULifeLine, TB2Item,
  SpTBXItem, Vcl.Menus, Vcl.VirtualImageList;

type
  TFSequenceForm = class(TFileForm)
    SequenceScrollbox: TScrollBox;
    SequenceToolbar: TToolBar;
    TBClose: TToolButton;
    TBLifeLine: TToolButton;
    TBZoomOut: TToolButton;
    TBZoomIn: TToolButton;
    TBActor: TToolButton;
    TBNewLayout: TToolButton;
    TBRefresh: TToolButton;
    EMessage: TEdit;
    PopupMenuConnection: TSpTBXPopupMenu;
    MISynchron: TSpTBXItem;
    MIAsynchron: TSpTBXItem;
    MIClose: TSpTBXItem;
    MINew: TSpTBXItem;
    MIReturn: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    MIDelete: TSpTBXItem;
    MITurn: TSpTBXItem;
    MIMessage: TSpTBXItem;
    PopupMenuLifeLineAndSequencePanel: TSpTBXPopupMenu;
    MIPopupConfiguration: TSpTBXItem;
    MIFont: TSpTBXItem;
    MIPopupAsText: TSpTBXItem;
    MIPopupRefresh: TSpTBXItem;
    MIPopupNewLayout: TSpTBXItem;
    MIPopupDeleteLifeLine: TSpTBXItem;
    MIPopupCreateObject: TSpTBXItem;
    MIPopupNewActor: TSpTBXItem;
    MIPopupNewLifeLine: TSpTBXItem;
    MIPopupConnectWith: TSpTBXSubmenuItem;
    vilPopupDark: TVirtualImageList;
    vilPopupLight: TVirtualImageList;
    vilToolbarDark: TVirtualImageList;
    vilToolbarLight: TVirtualImageList;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    MIPopupCopyAsPicture: TSpTBXItem;
    procedure FormCreate(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var aAction: TCloseAction); override;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TBCloseClick(Sender: TObject);
    procedure TBZoomOutClick(Sender: TObject);
    procedure TBZoomInClick(Sender: TObject);
    procedure MIPopupNewLayoutClick(Sender: TObject);
    procedure OnPanelClick(Sender: TObject);
    procedure OnPanelModified(Sender: TObject);
    procedure OnShowAll(Sender: TObject);
    procedure OnConnectionSet(Sender: TObject);
    procedure OnConnectionChanged(Sender: TObject; ArrowStyleOld, ArrowStyleNew: TArrowStyle);
    procedure OnLifeLineSequencePanel(Sender: TObject);
    procedure MIConnectionClick(Sender: TObject);
    procedure MIPopupRefreshClick(Sender: TObject);
    procedure MIPopupCreateObjectClick(Sender: TObject);
    procedure MIPopupDeleteLifeLineClick(Sender: TObject);
    procedure MIPopupNewLifeLineClick(Sender: TObject);
    procedure MIPopupNewActorClick(Sender: TObject);
    procedure MIPopupConfigurationClick(Sender: TObject);
    procedure MIPopupAsTextClick(Sender: TObject);
    procedure MIPopupFontClick(Sender: TObject);
    procedure LifeLineDblClick(Sender: TObject);
    procedure ConnectLifeLines(Sender: TObject);
    procedure PopupMenuConnectionPopup(Sender: TObject);
    procedure PopupMenuLifeLineAndSequencePanelPopup(Sender: TObject);
    procedure EditMemoChange(Sender: TObject);
    procedure SequenceScrollboxResize(Sender: TObject);
    procedure MIPopupCopyAsPictureClick(Sender: TObject);
  private
    EditMemo: TMemo;
    LifeLines: TList;
    EditMemoElement: TLifeLine;
    EditConnection: TConnection;
    LifeLinesTop: Integer;
    PopupAtYPos: Integer;
    PopupAtLifeLine: TLifeLine;
    DistY: Integer;
    ActivationWidth: Integer;
    minWidth: Integer;
    minHeight: Integer;
    minDist: Integer;
    MaxHeadHeight: Integer;
    aMessage: string;
    MethodArrowStyle: TArrowStyle;
    procedure DoEdit(LifeLine: TLifeLine);
    procedure DoEditMessage(Conn: TConnection);
    procedure setLeftBorderForEditMemo;
    procedure CloseEdit(b: Boolean);
    function getLifeLine(const Participant: string): TLifeLine;
    procedure OnBackgroundDblClick(Sender: TObject; Conn: TConnection);
    procedure onCreatedChanged(Sender: TObject);
    function getParticipantName: string;
    function getActorName: string;
  private
    SequencePanel: TSequencePanel;
    OnCloseNotify: TNotifyEvent; // future use for CreateSequencediagram
    procedure AddLifeline(const Participant: string);
    procedure AddConnection(const Connection: string);
    procedure setPanelFont(aFont: TFont);
    procedure MoveDiagram;
    procedure CalculateXPositions;
    procedure CalculateDiagram;
    procedure SortLifeLines;
    procedure prepareMethod(const aMethod: string);
    function prepareParticipant(const participant: string): string;
    function GetSequenceDiagramAsBitmap: TBitmap;
    procedure ChangeStyle;
    function getMaxLifelineHeight: Integer;
    function getMinLifelineTop: Integer;
    function getMinLifelineLeft: Integer;
  protected
    procedure SetModified(Value: Boolean); override;
    function LoadFromFile(const FileName: string): Boolean; override;
    procedure SetFont(aFont: TFont); override;
    function CanCopy: Boolean; override;
    procedure CopyToClipboard; override;
    procedure SetFontSize(Delta: Integer); override;
    procedure DoActivateFile(Primary: Boolean = True); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    // debugger related
    FromParticipant: string;
    ToParticipant: string;
    aResult: string;
    class function ToolbarCount: Integer;
    procedure MethodEntered(const aMethod: string);
    procedure MethodExited(aMethod: string);
    procedure addParameter(const parameter: string);
    procedure changeParameter(Parameter: TStringList);
    procedure changeLifeLineName(const value, aName: string);
    procedure makeFromParticipant(const participant: string);
    procedure makeToParticipant(const participant: string);
    procedure makeConnection;

    // UML-diagram related
    procedure ObjectDelete;

    procedure Print; override;
    function getAsStringList: TStringList; override;
    procedure DoExport; override;
    procedure SetOptions; override;
    procedure DPIChanged; override;
  end;

implementation

{$R *.dfm}

uses SysUtils, Printers, IniFiles, Math, Clipbrd, Themes, Dialogs,
     UITypes, uCommonFunctions, UConfiguration, UUtils,
     frmPyIDEMain;

const cMinDist = 20;
      cLifeLinesTop = 30;

procedure TFSequenceForm.FormCreate(Sender: TObject);
begin
  inherited;
  SequencePanel:= TSequencePanel.Create(SequenceScrollBox);
  SequencePanel.OnClick:= OnPanelClick;
  SequencePanel.OnModified:= OnPanelModified;
  SequencePanel.OnShowAll:=  OnShowAll;
  SequencePanel.OnBackgroundDblClicked:= OnBackgroundDblClick;
  SequencePanel.OnConnectionSet:= OnConnectionSet;
  SequencePanel.OnConnectionChanged:= OnConnectionChanged;
  SequencePanel.OnLifeLineSequencePanel:= OnLifeLineSequencePanel;
  SequencePanel.PopupMenuConnection:= PopupMenuConnection;
  SequencePanel.PopupMenuLifeLineAndSequencePanel:= PopupMenuLifeLineAndSequencePanel;
  SequencePanel.Parent:= SequenceScrollbox;
  SequencePanel.Width:= 800;
  SequencePanel.Height:= 600;
  // SequencePanel.Align:= alClient; inhibits Scrollbars

  EditMemo:= TMemo.Create(Self);
  EditMemo.Parent:= Self;
  EditMemo.SetBounds(136, 156, 99, 37);
  EditMemo.Color:= clSkyBlue;
  EditMemo.OnChange:= EditMemoChange;
  EditMemo.Visible:= False;
  EditMemo.WordWrap:= False;
  EditMemo.BevelInner:= bvNone;

  OnClose:= FormClose;
  OnCloseQuery:= FormCloseQuery;

  LifeLines:= TList.Create;
  setFont(GuiPyOptions.SequenceFont);
  setOptions;
  DefaultExtension:= 'psd';
  ChangeStyle;
end;

procedure TFSequenceForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if Assigned(OnCloseNotify) then
    OnCloseNotify(Self);
  CanClose:= True;
end;

procedure TFSequenceForm.FormClose(Sender: TObject; var aAction: TCloseAction);
begin
  inherited;
  LifeLines.Clear;
  FreeAndNil(LifeLines);
  aAction:= caFree;
end;

function TFSequenceForm.LoadFromFile(const FileName: string): Boolean;
  var i: Integer;
     Ini: TMemIniFile;
     SL: TStringList;
begin
  Result:= False;
  SL:= TStringList.Create;
  SequencePanel.isLocked:= True;
  Ini:= TMemIniFile.Create(FileName, TEncoding.UTF8);
  try
    try
      LifeLinesTop:= PPIScale(Min(Ini.ReadInteger('Diagram', 'Top', 30), 500));
      Ini.ReadSectionValues('Participants', SL);
      for i := 0 to SL.Count - 1 do
        AddLifeLine(UnhideCrLf(SL[i]));
      Ini.ReadSectionValues('Messages', SL);
      for i := 0 to SL.Count - 1 do
        AddConnection(SL[i]);
      Font.Name:= Ini.ReadString('Diagram', 'FontName', 'Segoe UI');
      Font.Size:= PPIScale(Ini.ReadInteger('Diagram', 'FontSize', 12));
      setFont(Font);
      Result:= True;
    except on e: Exception do
      ErrorMsg(e.Message);
    end;
  finally
    FreeAndNil(SL);
    FreeAndNil(Ini);
    SequencePanel.isLocked:= False;
  end;
end;

function TFSequenceForm.getAsStringList: TStringList;
var
  aLifeLine: TLifeline;
  i: Integer;
  c: string;
  Connections: TList;
  Conn: TConnection;
  SL: TStringList;
begin
  SL:= TStringList.Create;
  SL.add('[Participants]');
  SL.add('# Object | x-position');
  for i:= 0 to LifeLines.Count - 1 do begin
    aLifeline:= TLifeLine(LifeLines.Items[i]);
    SL.add(HideCrLf(aLifeLine.Participant) + ' | ' +  IntToStr(PPIUnScale(aLifeLine.Left)));
  end;

  SL.add('');
  SL.add('[Messages]');
  SL.add('# Object1 ->  Object2 | synchron message');
  SL.add('# Object1 --> Object2 | return message');
  SL.add('# Object1 ->> Object2 | asynchron message');
  SL.Add('# Object1 ->o Object2 | new message');
  SL.Add('# Object1 ->x Object2 | close message');
  Connections:= SequencePanel.getConnections;
  try
    for i:= 0 to Connections.Count-1 do begin
      Conn:= TConnection(Connections[i]);
      with conn do
        c:= HideCrLf((FFrom as TLifeLine).Participant) + getArrowStyleAsString +
            HideCrLf((FTo as TLifeLine).Participant) + ' | ' + conn.aMessage;
       SL.add(c);
    end;
  finally
    FreeAndNil(Connections);
  end;
  SL.add('');
  SL.add('[Diagram]');
  if LifeLines.Count = 0
    then SL.Add('Top=' + IntToStr(PPIUnScale(LifeLinesTop)))
    else SL.Add('Top=' + IntToStr(PPIUnScale(TLifeLine(LifeLines.Items[0]).Top)));
  SL.add('FontName=' + Font.Name);
  SL.add('FontSize=' + IntToStr(PPIUnScale(Font.Size)));
  Result:= SL;
end;

procedure TFSequenceForm.ConnectLifeLines(Sender: TObject);
  var Src, Dest: TControl;
begin
  Src:= SequencePanel.GetFirstSelected;
  Dest:= TControl(LifeLines.Items[(Sender as TSpTBXItem).Tag]);
  SequencePanel.FindManagedControl(Dest).Selected:= True;
  SequencePanel.ConnectBoxesAt(Src, Dest, PopupAtYPos);
end;

procedure TFSequenceForm.MIConnectionClick(Sender: TObject);
begin
  SequencePanel.DoConnection((Sender as TSpTBXItem).Tag);
end;

procedure TFSequenceForm.MIPopupFontClick(Sender: TObject);
begin
  SelectFont(fkSequencediagram);
end;

procedure TFSequenceForm.CalculateDiagram;
  var i, j, yPos, theWidth, NewWidth, NewHeight: Integer;
      Conn, Conn1: TConnection; ConnList: TList;
      LifeLine, LifeLine1, LifeLine2: TLifeLine;
      Activations: array of Integer;
begin
  if SequencePanel.isLocked then Exit;

  ConnList:= SequencePanel.GetConnections;
  // init activation calculating
  for i:= 0 to ConnList.Count - 1 do begin
    Conn1:= TConnection(ConnList.Items[i]);
    Conn1.FromActivation:= 0;
    Conn1.ToActivation:= 0;
  end;

  if ConnList.Count > 1 then
    TConnection(ConnList.Items[0]).FromActivation:= 1;

  // calculate activations
  SetLength(Activations, LifeLines.Count);
  for i:= 0 to LifeLines.Count - 1 do
    TLifeLine(LifeLines.Items[i]).Activation:= 0;
  if LifeLines.Count > 0 then
    TLifeLine(LifeLines.Items[0]).Activation:= 1;
  for i:= 0 to ConnList.Count - 1 do begin
    Conn:= TConnection(ConnList.Items[i]);
    if Conn.isRecursiv then begin
      LifeLine:= Conn.FFrom as TLifeLine;
      Conn.FromActivation:= LifeLine.Activation;
      if Conn.ArrowStyle = casReturn
        then Dec(LifeLine.Activation)
        else Inc(LifeLine.Activation);
      Conn.ToActivation:= LifeLine.Activation;
    end else begin
      LifeLine1:= Conn.FFrom as TLifeLine;
      LifeLine2:= Conn.FTo as TLifeLine;
      if Conn.ArrowStyle = casReturn then begin
        Conn.FromActivation:= LifeLine1.Activation;
        Conn.ToActivation:= LifeLine2.Activation;
        Dec(LifeLine1.Activation);
      end else if Conn.ArrowStyle = casNew then begin
        Conn.FromActivation:= LifeLine1.Activation;
        Conn.ToActivation:= 0;
      end else begin
        Conn.FromActivation:= LifeLine1.Activation;
        LifeLine2.Activation:= 1;
        Conn.ToActivation:= LifeLine2.Activation;
      end;
    end;
  end;

  // calculate y-positions
  yPos:= minHeight;
  if ConnList.Count > 0 then begin
    yPos:= TConnection(ConnList.Items[0]).FFrom.Top + maxHeadHeight + DistY;
    for i:= 0 to ConnList.Count - 1 do begin
      TConnection(ConnList.Items[i]).yPos:= yPos;
      if TConnection(ConnList.Items[i]).isRecursiv then
        yPos:= yPos + Round(1.5*DistY)
      else begin
        if (i > 0) and (TConnection(ConnList.Items[i-1]).ArrowStyle = casNew) and
          (TConnection(ConnList.Items[i-1]).FTo = TConnection(ConnList.Items[i]).FFrom)
        then begin
          while YPos <= TConnection(ConnList.Items[i-1]).YPos +
                        TLifeLine(TConnection(ConnList.Items[i-1]).FTo).HeadHeight div 2 +
                        Canvas.TextHeight('A') do
            yPos:= yPos + DistY div 2;
          TConnection(ConnList.Items[i]).YPos:= YPos;
        end;
        yPos:= yPos + DistY;
      end;
    end;
  end else
    yPos:= yPos + maxHeadHeight + DistY;

  theWidth:= 0;
  for i:= 0 to LifeLines.Count - 1 do begin
    LifeLine:= TLifeLine(LifeLines.Items[i]);
    theWidth:= Max(theWidth, LifeLine.Left + LifeLine.Width);
    if LifeLine.Created then begin
      for j:= 0 to ConnList.Count - 1 do begin
        Conn1:= TConnection(ConnList.Items[j]);
        if (Conn1.ArrowStyle = casNew) and (Conn1.FTo = LifeLine) then begin
          LifeLine.Top:= Conn1.YPos - LifeLine.Headheight div 2;
          Break;
        end;
      end;
      LifeLine.Height:= TLifeLine(LifeLines.Items[0]).Top + TLifeLine(LifeLines.Items[0]).Height - LifeLine.Top;
    end else begin
      LifeLine.Height:= yPos;
      LifeLine.Top:= TLifeLine(LifeLines.Items[0]).Top;
    end;
    if LifeLine.Closed then begin
      for j:= 0 to ConnList.Count - 1 do begin
        Conn1:= TConnection(ConnList.Items[j]);
        if (Conn1.ArrowStyle = casClose) and (Conn1.FTo = LifeLine) then begin
          LifeLine.Height:= Conn1.YPos - LifeLine.Top - 10;
          Break;
        end;
      end;
    end;
  end;

  NewWidth:= Max(SequenceScrollbox.Width, theWidth + 30);
  NewHeight:= Max(SequenceScrollbox.Height, yPos + 30);
  if (NewWidth > SequenceScrollbox.Width) or (NewHeight > SequenceScrollbox.Height) then
    SequenceScrollbox.SetBounds(0, 0, NewWidth, NewHeight);

  if (NewWidth > SequencePanel.Width) or (NewHeight > SequencePanel.Height) or
     (SequencePanel.Left <> 0) or (SequencePanel.Top <> 0) then
    SequencePanel.SetBounds(0, 0, NewWidth, NewHeight);
  FreeAndNil(ConnList);
end;

procedure TFSequenceForm.DoActivateFile(Primary: Boolean = True);
begin
  inherited;
  SequencePanel.SetFocus;
end;

procedure TFSequenceForm.MIPopupAsTextClick(Sender: TObject);
begin
  DoSave;
  GI_EditorFactory.OpenFile(Pathname, '', 1, True);
end;

procedure TFSequenceForm.MIPopupConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('Sequence diagram');
end;

procedure TFSequenceForm.MIPopupCopyAsPictureClick(Sender: TObject);
begin
  var Bitmap:= GetSequenceDiagramAsBitmap;
  Clipboard.Assign(Bitmap);
  FreeAndNil(Bitmap);
end;

procedure TFSequenceForm.MIPopupCreateObjectClick(Sender: TObject);
  var LifeLine1, LifeLine2: TLifeLine; Attributes: TConnectionAttributes;
      Connections: TList; Conn: TConnection;
      i, Pos: Integer;
begin
  if LifeLines.Count > 0 then begin
    LifeLine1:= TLifeLine(SequencePanel.GetFirstSelected);
    AddLifeLine(getParticipantName);
    LifeLine2:= TLifeLine(LifeLines.Items[LifeLines.Count-1]);
    LifeLine2.Created:= True;
    if LifeLine1 =  TLifeLine(LifeLines.Items[LifeLines.Count-2]) then
      LifeLine2.Left:= LifeLine2.Left - minDist + Canvas.TextWidth(GuiPyLanguageOptions.SDNew);
    if Assigned(LifeLine1) and Assigned(LifeLine2) then begin
      Attributes:= TConnectionAttributes.Create;
      try
        Attributes.ArrowStyle:= casNew;
        Attributes.aMessage:= GuiPyLanguageOptions.SDNew;
        Connections:= SequencePanel.getConnections;
        i:= 0;
        Pos:= 0;
        while i < Connections.Count do begin
          Conn:= TConnection(Connections[i]);
          if Conn.YPos < PopupAtYPos then
            Pos:= i + 1;
          Inc(i);
        end;
        SequencePanel.ConnectObjectsAt(LifeLine1, LifeLine2, Attributes, Pos);
        Modified:= True;
        CalculateDiagram;
      finally
        FreeAndNil(Attributes);
        FreeAndNil(Connections);
      end;
    end;
  end;
end;

procedure TFSequenceForm.MIPopupDeleteLifeLineClick(Sender: TObject);
  var LifeLine: TLifeLine; i: Integer;
begin
  LifeLine:= TLifeLine(SequencePanel.GetFirstSelected);
  if Assigned(LifeLine) then begin
    i:= 0;
    while i < LifeLines.Count do begin
      if TLifeLine(LifeLines.Items[i]) = LifeLine then begin
        LifeLines.Delete(i);
        i:= LifeLines.Count;
      end;
      Inc(i);
    end;
  end;
  SequencePanel.DeleteSelectedControls;
end;

procedure TFSequenceForm.MIPopupRefreshClick(Sender: TObject);
begin
  SequencePanel.isLocked:= True;
  if Assigned(fFile) then
    DoSave;
  SequencePanel.ClearManagedObjects;
  LifeLines.Clear;
  LoadFromFile(Pathname);
  SequencePanel.isLocked:= False;
  CalculateDiagram;
  SequencePanel.Clear;
  SequencePanel.ShowAll;
  //Invalidate;
  Modified:= True;
end;

procedure TFSequenceForm.PopupMenuConnectionPopup(Sender: TObject);
begin
  inherited;
  var Pt:= SequencePanel.ScreenToClient(Mouse.CursorPos);
  PopupAtYPos:= Pt.Y;
end;

procedure TFSequenceForm.OnLifeLineSequencePanel(Sender: TObject);
  var Pt: TPoint;
begin
  Pt:= SequencePanel.ScreenToClient(Mouse.CursorPos);
  PopupAtYPos:= Pt.Y;
  if Assigned(Sender) and (Sender is TLifeLine)
    then PopupAtLifeLine:= (Sender as TLifeLine)
    else PopupAtLifeLine:= nil;
end;

procedure TFSequenceForm.PopupMenuLifeLineAndSequencePanelPopup(Sender: TObject);
  var aMenuItem: TSpTBXItem;
      i, p: Integer; s: string;
begin
  for i:= MIPopupConnectWith.Count - 1 downto 0 do
    FreeAndNil(MIPopupConnectWith.Items[i]);

  if Assigned(PopupAtLifeLine) then begin
    MIPopupConnectWith.Visible:= True;
    MIPopupDeleteLifeLine.Visible:= True;
    MIPopupCreateObject.Visible:= True;
    for i:= 0 to LifeLines.Count - 1 do begin
      s:= TLifeLine(LifeLines.Items[i]).Participant;
      p:= Pos(#13#10, s); if p > 0 then Delete(s, p, Length(s));
      aMenuItem:= TSpTBXItem.Create(PopupMenuLifeLineAndSequencePanel);
      aMenuItem.Caption:= s;
      aMenuItem.OnClick:= ConnectLifeLines;
      aMenuItem.ImageIndex:= 16;
      aMenuItem.Tag:= i;
      MIPopupConnectWith.Add(aMenuItem);
    end;
  end else begin
    MIPopupConnectWith.Visible:= False;
    MIPopupDeleteLifeLine.Visible:= False;
    MIPopupCreateObject.Visible:= False;
  end;
end;

function TFSequenceForm.GetSequenceDiagramAsBitmap: TBitmap;
begin
  SequencePanel.ChangeStyle(True);
  var EnclosingRect:= SequencePanel.GetEnclosingRect;
  Result := TBitmap.Create;
  Result.Width := EnclosingRect.Right - EnclosingRect.Left + 2;
  Result.Height := EnclosingRect.Bottom - EnclosingRect.Top + 2;
  Result.Canvas.Lock;
  SequencePanel.PaintTo(Result.Canvas.Handle, -EnclosingRect.Left + 1, -EnclosingRect.Top + 1);
  Result.Canvas.Unlock;
  SequencePanel.ChangeStyle(False);
end;

procedure TFSequenceForm.Print;
begin
  var
  Bitmap := GetSequenceDiagramAsBitmap;
  PrintBitmap(Bitmap, PixelsPerInch);
  FreeAndNil(Bitmap);
end;

procedure TFSequenceForm.CopyToClipboard;
begin
  var
  Bitmap := GetSequenceDiagramAsBitmap;
  Clipboard.Assign(Bitmap);
  FreeAndNil(Bitmap);
end;

procedure TFSequenceForm.DoExport;
begin
  var
  Bitmap := GetSequenceDiagramAsBitmap;
  PyIDEMainForm.DoExport(Pathname, Bitmap);
  FreeAndNil(Bitmap);
  if CanFocus then
    SetFocus;
end;

function TFSequenceForm.CanCopy: Boolean;
begin
  Result:= True;
end;

procedure TFSequenceForm.SequenceScrollboxResize(Sender: TObject);
begin
  inherited;
  SequencePanel.RecalcSize;
end;

procedure TFSequenceForm.SetFont(aFont: TFont);
begin
  inherited;
  Font.Assign(aFont);
  DistY:= Round(cDistY*Font.Size/12.0);
  ActivationWidth:= Round(cActivationWidth*Font.Size/12.0);
  MinWidth:= Round(cMinWidth*Font.Size/12.0);
  MinHeight:= Round(cMinHeight*Font.Size/12.0);
  LifeLinesTop:= Round(cLifeLinesTop*Font.Size/12.0);
  minDist:= Round(cMinDist*Font.Size/12.0);
  Canvas.Font.Assign(aFont);
  setPanelFont(aFont);
  SortLifeLines;
  CalculateDiagram;
  GuiPyOptions.SequenceFont.Assign(aFont);
  Invalidate;
end;

procedure TFSequenceForm.SetFontSize(Delta: Integer);
begin
  inherited;
  CalculateXPositions;
end;

procedure TFSequenceForm.CalculateXPositions;
  var i, j, w, activation, w1, w2: Integer;
      Connections: TList;
      Conn, ConnPrev: TConnection;
      LifeLine1, LifeLine2: TLifeLine;
begin
  Connections:= SequencePanel.getConnections;
  for i:= 0 to LifeLines.Count - 2 do begin
    LifeLine1:= TLifeLine(LifeLines.Items[i]);
    LifeLine2:= TLifeLine(LifeLines.Items[i+1]);
    w:= LifeLine1.Width div 2 + minDist + LifeLine2.Width div 2;
    Activation:= 0;
    for j:= 0 to Connections.Count-1 do begin
      Conn:= TConnection(Connections[j]);
      if (Conn.FFrom = LifeLine1) and (Conn.FTo = LifeLine2) or
         (Conn.FFrom = LifeLine2) and (Conn.FTo = LifeLine1) or
         (Conn.FFrom = LifeLine1) and (Conn.FTo = LifeLine1)
      then begin
        w1:= Canvas.TextWidth(Conn.aMessage);
        if Conn.ArrowStyle = casNew
          then w:= Max(w, w1 + LifeLine2.Width div 2)
          else w:= Max(w, w1);
        Activation:= Max(Activation, (Conn.FromActivation + Conn.ToActivation)*ActivationWidth);
      end;
      if j > 0 then begin
        ConnPrev:= TConnection(Connections[j - 1]);
        if (ConnPrev.ArrowStyle = casNew) and
           (ConnPrev.FFrom = LifeLine1) and
           (ConnPrev.FTo = LifeLine2)
        then begin
          w1:= Canvas.TextWidth(ConnPrev.aMessage) + ConnPrev.FTo.Width div 2;
          w2:= Canvas.TextWidth(Conn.aMessage) + + ConnPrev.FTo.Width div 2 - MinDist;
          w:= Max(Max(w, w1), w2);
        end;
      end;
    end;
    LifeLine2.Left:= LifeLine1.Left + LifeLine1.Width div 2 + w + Activation + minDist - LifeLine2.Width div 2;
  end;
  FreeAndNil(Connections);
end;

procedure TFSequenceForm.setPanelFont(aFont: TFont);
  var i: Integer;
begin
  maxHeadHeight:= 2*DistY;
  for i:= 0 to LifeLines.Count-1 do begin
    TLifeLine(LifeLines.Items[i]).setFont(aFont);
    maxHeadHeight:= Max(maxHeadHeight, TLifeLine(LifeLines.Items[i]).HeadHeight);
  end;
  SequencePanel.setFont(aFont);
end;

procedure TFSequenceForm.TBCloseClick(Sender: TObject);
begin
  (fFile as IFileCommands).ExecClose;
end;

procedure TFSequenceForm.AddLifeline(const Participant: string);
  var LifeLine: TLifeLine; i, maxx, x1, lef: Integer; SL: TStringList;
begin
  if Copy(Participant, 1, 1) = '#' then Exit;
  SL:= Split('|', Participant);
  LifeLine:= TLifeLine.createLL(SequencePanel, Trim(SL[0]), Font, TBClose);
  LifeLine.OnDblClick:= LifeLineDblClick;
  LifeLine.PopupMenu:= PopupMenuLifeLineAndSequencePanel;
  LifeLine.onCreatedChanged:= onCreatedChanged;
  if (Sl.Count > 1) and TryStrToInt(Trim(SL[1]), lef) then begin
    LifeLine.Left:= PPIScale(lef);
    if LifeLines.Count > 0
      then LifeLine.Top:= TLifeLine(LifeLines.Items[0]).Top
      else LifeLine.Top:= LifeLinesTop;
  end else begin
    maxx:= 0;
    for i:= 0 to LifeLines.Count - 1 do begin
      x1:= TLifeLine(LifeLines.Items[i]).Left + TLifeLine(LifeLines.Items[i]).Width;
      if x1 > maxx then maxx:= x1;
    end;
    LifeLine.Left:= maxx + minDist;
    if LifeLines.Count > 0 then begin
      LifeLine.Top:= TLifeLine(LifeLines.Items[0]).Top;
      LifeLine.Height:= TLifeLine(LifeLines.Items[0]).Height;
    end else begin
      LifeLine.Top:= LifeLinesTop;
      LifeLine.Height:= LifeLine.HeadHeight + 2*DistY;
    end;
  end;
  SequencePanel.AddManagedObject(LifeLine);
  LifeLines.Add(LifeLine);
  LifeLine.First:= (LifeLines.Count = 1);
  FreeAndNil(SL);
end;

procedure TFSequenceForm.AddConnection(const Connection: string);
  var Participant1, Participant2, bMessage: string;
      p: Integer;
      ArrowStyle: TArrowStyle;
      Attributes: TConnectionAttributes;
      Lifeline1, LifeLine2: TLifeLine;
begin
  if Copy(Connection, 1, 1) = '#' then
    Exit;
  ArrowStyle:= casSynchron;
  p:= Pos('->>', Connection);
  if p > 0 then
    ArrowStyle:= casAsynchron
  else begin
    p:= Pos('-->', Connection);
    if p > 0 then
      ArrowStyle:= casReturn
    else begin
      p:= Pos('->x', Connection);
      if p > 0 then
        ArrowStyle:= casClose
      else begin
        p:= Pos('->o', Connection);
        if p > 0 then
          ArrowStyle:= casNew
        else
          p:= Pos('->', Connection);
      end;
    end;
  end;
  if p = 0 then Exit;
  Participant1:= UnhideCrLf(Trim(Copy(Connection, 1, p-1)));
  if ArrowStyle = casSynchron
    then Participant2:= Trim(Copy(Connection, p + 2, Length(Connection)))
    else Participant2:= Trim(Copy(Connection, p + 3, Length(Connection)));
  p:= Pos('|', Participant2);
  if p > 0 then begin
    bMessage:= Trim(Copy(Participant2, p + 1, Length(Participant2)));
    Participant2:= Trim(Copy(Participant2, 1, p-1));
  end else
    bMessage:= '';
  Participant2:= UnHideCrLf(Participant2);
  LifeLine1:= getLifeline(Participant1);
  LifeLine2:= getLifeline(Participant2);
  if Assigned(LifeLine1) and Assigned(LifeLine2) then begin
    Attributes:= TConnectionAttributes.Create;
    try
      Attributes.ArrowStyle:= ArrowStyle;
      Attributes.aMessage:= bMessage;
      if Attributes.ArrowStyle = casNew then
        LifeLine2.Created:= True;
      if Attributes.ArrowStyle = casClose then
        LifeLine2.Closed:= True;
      SequencePanel.ConnectObjects(LifeLine1, LifeLine2, Attributes);
    finally
      FreeAndNil(Attributes);
    end;
  end;
end;

procedure TFSequenceForm.MIPopupNewLifeLineClick(Sender: TObject);
begin
  AddLifeLine(getParticipantName);
  Modified:= True;
end;

function TFSequenceForm.getParticipantName: string;
  var i, n: Integer; ok: Boolean;
begin
  n:= 1;
  repeat
    ok:= True;
    Result:= GuiPyLanguageOptions.SDObject + IntToStr(n);
    for i:= 0 to LifeLines.Count - 1 do
      if Pos(Result, TLifeLine(LifeLines.Items[i]).Participant) = 1 then
        ok:= False;
    Inc(n);
  until ok;
end;

procedure TFSequenceForm.MIPopupNewActorClick(Sender: TObject);
begin
  AddLifeLine(getActorName);
  Modified:= True;
end;

function TFSequenceForm.getActorName: string;
  var i, n: Integer; ok: Boolean;
begin
  n:= 1;
  repeat
    ok:= True;
    Result:= 'Actor' + IntToStr(n);
    for i:= 0 to LifeLines.Count - 1 do
      if Pos(Result, TLifeLine(LifeLines.Items[i]).Participant) = 1 then
        ok:= False;
    Inc(n);
  until ok;
end;

procedure TFSequenceForm.MoveDiagram;
  var i, delta: Integer;
begin
  delta:= getMinLifelineLeft - minDist;
  if delta <> 0 then
    for i:= 0 to Lifelines.Count - 1 do
      TLifeline(Lifelines.Items[i]).Left:=
        TLifeline(Lifelines.Items[i]).Left - delta;
  delta:= getMinLifelineTop - cLifeLinesTop;
  if delta <> 0 then
    for i:= 0 to Lifelines.Count - 1 do
      TLifeline(Lifelines.Items[i]).Top:=
        TLifeline(Lifelines.Items[i]).Top - delta;
end;

procedure TFSequenceForm.MIPopupNewLayoutClick(Sender: TObject);
begin
  SequencePanel.IsLocked := True;
  SortLifelines;
  CalculateXPositions;
  MoveDiagram;
  SequenceScrollbox.HorzScrollBar.Position := 0;
  SequenceScrollbox.VertScrollBar.Position := 0;
  SequencePanel.IsLocked := False;
  SequencePanel.ShowAll;
end;

procedure TFSequenceForm.TBZoomInClick(Sender: TObject);
begin
  SetFontSize(+1);
  Modified:= True;
end;

procedure TFSequenceForm.TBZoomOutClick(Sender: TObject);
begin
  SetFontSize(-1);
  Modified:= True;
end;

procedure TFSequenceForm.DoEdit(LifeLine: TLifeLine);
begin
  if Assigned(LifeLine) and not ReadOnly then begin
    EditMemoElement:= LifeLine;
    EditMemo.Text:= LifeLine.Participant;
    EditMemo.SetBounds(LifeLine.Left+2, SequenceToolbar.Height + LifeLine.Top +2,
                       LifeLine.Width, LifeLine.HeadHeight);
    setLeftBorderForEditMemo;
    EditMemo.Visible:= True;
    if EditMemo.canFocus then EditMemo.SetFocus;
    EditMemo.Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

procedure TFSequenceForm.DoEditMessage(Conn: TConnection);
begin
  if Assigned(Conn) and not ReadOnly then begin
    EditConnection:= Conn;
    EMessage.Text:= Conn.aMessage;
    EMessage.Font.Assign(Font);
    EMessage.SetBounds(Conn.TextRect.Left-1, SequenceToolbar.Height + Conn.TextRect.Top + 1,
                       Round(Conn.TextRect.Width + 100), Conn.TextRect.Height);
    EMessage.Visible:= True;
    if EMessage.canFocus then EMessage.SetFocus;
    EMessage.SelStart:= Length(Conn.aMessage);
  end;
end;

procedure TFSequenceForm.setLeftBorderForEditMemo;
  var R: TRect;
begin
  R:= EditMemo.ClientRect;
  R.Left:= 4;
  SendMessage(EditMemo.Handle, EM_SETRECT,0, Longint(@R)) ;
end;

procedure TFSequenceForm.EditMemoChange(Sender: TObject);
  var w, h: Integer; LifeLine: TLifeLine;
begin
  LifeLine:= EditMemoElement;
  if Assigned(LifeLine) then begin
    LifeLine.getWidthHeigthOfText(EditMemo.Lines.Text, w, h);
    if EditMemo.Height < h then
      EditMemo.Height:= h;
    if EditMemo.Width < w then
      EditMemo.Width:= w;
  end;
  SendMessage(EditMemo.handle, WM_VSCROLL, SB_TOP, 0);
  setLeftBorderForEditMemo;
end;

procedure TFSequenceForm.CloseEdit(b: Boolean);
begin
  if EditMemo.Visible then begin
    if b and Assigned(EditMemoElement) then begin
      EditMemoElement.Participant:= EditMemo.Text;
      EditMemoElement.CalcWidthHeight;
      Modified:= True;
      SequencePanel.Invalidate;
    end;
    EditMemo.Visible:= False;
    EditMemoElement:= nil;
  end;
  if EMessage.Visible then begin
    if b and Assigned(EditConnection) then begin
      EditConnection.aMessage:= EMessage.Text;
      Modified:= True;
      SequencePanel.Invalidate;
    end;
    EMessage.Visible:= False;
    EditConnection:= nil;
  end;
end;

function TFSequenceForm.getLifeLine(const Participant: string): TLifeLine;
  var i: Integer;
begin
  i:= 0;
  while i < LifeLines.Count do
    if (TLifeLine(LifeLines.Items[i]).Participant = Participant) or
       (TLifeLine(LifeLines.Items[i]).Internalname = Participant)
    then begin
      Result:= TLifeLine(LifeLines.Items[i]);
      Exit;
    end else
      Inc(i);
  AddLifeLine(Participant);
  Result:= TLifeLine(LifeLines.Items[Lifelines.Count-1]);
end;

procedure TFSequenceForm.LifeLineDblClick(Sender: TObject);
  var P: TPoint; Connection: TConnection;
begin
  if Sender is TLifeLine then begin
    P:= (Sender as TLifeLine).ScreenToClient(Mouse.CursorPos);
    if P.Y <= (Sender as TLifeLine).Headheight
      then DoEdit(Sender as TLifeLine)
    else begin
      Connection:= SequencePanel.getConnectionOfClickedTextRect;
      if Assigned(Connection)
        then DoEditMessage(Connection)
    end;
  end;
end;

procedure TFSequenceForm.OnBackgroundDblClick(Sender: TObject; Conn: TConnection);
begin
  if Assigned(Conn) then
    DoEditMessage(Conn)
end;

procedure TFSequenceForm.OnPanelClick(Sender: TObject);
begin
  CloseEdit(True);
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
end;

procedure TFSequenceForm.OnPanelModified(Sender: TObject);
begin
  Modified:= True;
end;

procedure TFSequenceForm.OnShowAll(Sender: TObject);
begin
  CalculateDiagram;
end;

procedure TFSequenceForm.OnConnectionSet(Sender: TObject);
  var conn: TConnection;
begin
  conn:= (Sender as TConnection);
  if conn.ArrowStyle = casClose then
    TLifeLine(conn.FTo).Closed:= True;
  if conn.ArrowStyle = casNew then
    TLifeLine(conn.FTo).Created:= True;
end;

procedure TFSequenceForm.OnConnectionChanged(Sender: TObject; ArrowStyleOld, ArrowStyleNew: TArrowStyle);
  var conn: TConnection; aLifeline: TLifeline; minTop, maxHeight: Integer;
begin
  conn:= Sender as TConnection;
  aLifeLine:= TLifeLine(conn.FTo);
  aLifeLine.Created:= False;
  aLifeLine.Closed:= False;
  if ArrowStyleNew = casNew then
    aLifeline.Created:= True;
  if ArrowStyleNew = casClose then
    aLifeline.Closed:= True;
  minTop:= getMinLifelineTop;
  maxHeight:= getmaxLifelineHeight;
  if ArrowStyleNew = casNew
    then aLifeLine.Top:= conn.YPos - aLifeLine.Headheight div 2
    else aLifeLine.Top:= minTop;
  if ArrowStyleNew = casClose then
    aLifeline.Height:= Conn.YPos - aLifeline.Top - 10
  else if ArrowStyleNew = casNew then
    aLifeline.Height:= minTop + maxHeight - aLifeLine.Top
  else
    aLifeline.Height:= maxHeight;
  conn.FFrom.Invalidate;
  conn.FTo.Invalidate;
end;

procedure TFSequenceForm.SortLifeLines;
  var i, j: Integer;
begin
  if LifeLines.Count > 1 then
    for j:= LifeLines.Count downto 2 do
      for i:= 0 to j - 2  do
        if TLifeLine(LifeLines.Items[i]).Left > TLifeLine(LifeLines.Items[i+1]).Left then
          LifeLines.Exchange(i, i+1);
  for i:= 0 to LifeLines.Count - 1 do
    TLifeLine(LifeLines.Items[i]).First:= (i = 0);
end;

procedure TFSequenceForm.onCreatedChanged(Sender: TObject);
begin
  CalculateDiagram;
end;

// Sequencediagram from Debugger

procedure TFSequenceForm.prepareMethod(const aMethod: string);
  var p: Integer;
begin
  aMessage:= aMethod;
  p:= Pos('(', aMessage);
  if p > 0 then
    Delete(aMessage, p, Length(aMessage));
  p:= Pos('.', aMessage);
  if p > 0 then
    Delete(aMessage, 1, p);
end;

procedure TFSequenceForm.addParameter(const parameter: string);
begin
  aMessage:= aMessage + '(' + Parameter + ')';
end;

procedure TFSequenceForm.changeParameter(Parameter: TStringList);
  var i: Integer; conn: TConnection;
begin
  conn:= SequencePanel.Get2NdLastConnection;
  if Assigned(conn) then
    for i:= 0 to Parameter.Count - 1 do
      if Pos(Parameter.Names[i], conn.aMessage) > 0 then
        conn.aMessage:= myStringReplace(conn.aMessage, Parameter.Names[i], Parameter.ValueFromIndex[i]);
  conn:= SequencePanel.GetLastConnection;
  if Assigned(conn) then
    for i:= 0 to Parameter.Count - 1 do
      if Pos(Parameter.Names[i], conn.aMessage) > 0 then
        conn.aMessage:= myStringReplace(conn.aMessage, Parameter.Names[i], Parameter.ValueFromIndex[i]);
end;

procedure TFSequenceForm.changeLifeLineName(const value, aName: string);
  var i: Integer;
begin
  for i:= 0 to LifeLines.Count - 1 do begin
    if TLifeLine(LifeLines.Items[i]).Participant <> '' then Continue;
    if TLifeLine(LifeLines.Items[i]).Internalname = value then begin
      TLifeLine(LifeLines.Items[i]).RenameParticipant(aName);
      Exit;
    end;
  end;
end;

procedure TFSequenceForm.MethodEntered(const aMethod: string);
begin
  prepareMethod(aMethod);
  if aMessage = '<init>' then begin
    aMessage:= GuiPyLanguageOptions.SDNew;
    MethodArrowStyle:= casNew;
  end else
    MethodArrowStyle:= casSynchron;
end;

procedure TFSequenceForm.MethodExited(aMethod: string);
  var p: Integer;
begin
  p:= Pos(', ', aMethod);
  if p > 0 then begin
    aResult:= Copy(aMethod, 1, p-1);
    if aResult = '<void value>' then
      aResult:= '';
    Delete(aMethod, 1, p+1);
  end;
  prepareMethod(aMethod);
  MethodArrowStyle:= casReturn;
end;

procedure TFSequenceForm.ObjectDelete;
begin
  aMessage:= GuiPyLanguageOptions.SDClose;
  MethodArrowStyle:= casClose;
end;

function TFSequenceForm.prepareParticipant(const participant: string): string;
begin
  if participant = 'main'
    then Result:= 'Actor'
    else Result:= participant;
end;

procedure TFSequenceForm.makeFromParticipant(const participant: string);
begin
  FromParticipant:= prepareParticipant(participant);
end;

procedure TFSequenceForm.makeToParticipant(const participant: string);
begin
  ToParticipant:= prepareParticipant(Participant);
  if (FromParticipant = ToParticipant) {and (myDebugger.SequenceForm = self)} then
    if MethodArrowStyle in [casSynchron, casNew]
      then FromParticipant:= 'Actor'
      else ToParticipant:= 'Actor';
end;

procedure TFSequenceForm.makeConnection;
  var LifeLine1, LifeLine2: TLifeLine; Attributes: TConnectionAttributes;
begin
  if not GuiPyOptions.SDShowMainCall and (FromParticipant = 'Actor') and (ToParticipant = 'Actor') then
    Exit;
  LifeLine1:= getLifeline(FromParticipant);
  LifeLine2:= getLifeline(ToParticipant);
  if Assigned(LifeLine1) and Assigned(LifeLine2) then begin
    Attributes:= TConnectionAttributes.Create;
    try
      Attributes.ArrowStyle:= MethodArrowStyle;
      if Attributes.ArrowStyle = casNew then
        LifeLine2.Created:= True;
      if not ((MethodArrowStyle = casReturn) and (aMessage = '<init>')) then begin
        if MethodArrowStyle = casReturn then
          if GuiPyOptions.SDShowReturn
            then aMessage:= myStringReplace(aResult, '"', '')
            else aMessage:= '';
        Attributes.aMessage:= aMessage;
        SequencePanel.ConnectObjects(LifeLine1, LifeLine2, Attributes);
      end;
    finally
      FreeAndNil(Attributes);
    end;
    MIPopupNewLayoutClick(Self);
  end;
end;

procedure TFSequenceForm.SetModified(Value: Boolean);
begin
  if fModified <> Value then begin
    inherited;
    SequencePanel.OnModified:= nil;
    SequencePanel.IsModified:= Value;
    SequencePanel.OnModified:= OnPanelModified;
  end;
end;

procedure TFSequenceForm.WMSpSkinChange(var Message: TMessage);
begin
  inherited;
  ChangeStyle;
end;

procedure TFSequenceForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark then begin
    SequenceToolbar.Images:= vilToolbarDark;
    PopupMenuLifeLineAndSequencePanel.Images:= vilToolbarDark;
    PopupMenuConnection.Images:= vilPopupDark;
  end else begin
    SequenceToolbar.Images:= vilToolbarLight;
    PopupMenuLifeLineAndSequencePanel.Images:= vilToolbarLight;
    PopupMenuConnection.Images:= vilPopupLight;
  end;
  SequencePanel.ChangeStyle;
end;

function TFSequenceForm.getMaxLifelineHeight: Integer;
begin
  Result:= 0;
  for var i:= 0 to LifeLines.Count - 1 do
    Result:= Max(Result, TLifeLine(LifeLines.Items[i]).Height);
end;

function TFSequenceForm.getMinLifelineTop: Integer;
begin
  Result:= MaxInt;
  for var i:= 0 to LifeLines.Count - 1 do
    Result:= Min(Result, TLifeLine(LifeLines.Items[i]).Top);
end;

function TFSequenceForm.getMinLifelineLeft: Integer;
begin
  Result:= MaxInt;
  for var i:= 0 to LifeLines.Count - 1 do
    Result:= Min(Result, TLifeLine(LifeLines.Items[i]).Left);
end;

procedure TFSequenceForm.SetOptions;
begin
  FConfiguration.setToolbarVisibility(SequenceToolbar, 5);
end;

procedure TFSequenceForm.DPIChanged;
begin
  setFontSize(0);
end;

class function TFSequenceForm.ToolbarCount: Integer;
begin
  Result:= 7;
end;

end.
